-- Redis Cache module: Transparent subrequest-based caching layout for arbitrary nginx locations. 
-- Auth: huangjingkai
-- Date: 201X/04/23

local req_uri = ngx.var.uri
if ngx.var.args ~= nil then req_uri = req_uri .. '?' .. ngx.var.args; end
local real_uri = ngx.var.host .. string.sub(ngx.var.uri, 7, -1)
local real_request_uri = string.sub(req_uri,7,-1)

local keys = ngx.var.cache_key
if keys == '' or keys == nil then
    ngx.log(ngx.ERR,"[CACHE]cache_key is nil,wil goto reverse_proxy")
    ngx.header['X-RDS-STATUS'] = 'MISS'
    return ngx.exec('/reverse-proxy')
end

--
--  Connect to the redis server.
--

local redis = require "resty.redis"
local red = redis:new()
red:set_timeout(g_cache.redis_timeout) -- 1 sec

-- connect to a unix domain socket file listened by a redis server:
local ok, err = red:connect(ngx.var.redis_host, ngx.var.redis_port, {pool="mypool"})
if not ok then
  ngx.log(ngx.ERR, "[CACHE] redis server failed to connect: ", ngx.var.redis_host, ngx.var.redis_port)
  ngx.header['X-CACHED-STATUS'] = 'DOWN'
  return ngx.exec(g_cache.err_return_page)
end

local res, err = red:auth(ngx.var.redis_password)
if not res then
  ngx.log(ngx.ERR, "[CACHE] auth failed: ", ngx.var.redis_host, ":", ngx.var.redis_port)
  ngx.header['X-CACHED-STATUS'] = 'DOWN'
  ngx.header["pragma"]="no-cache"
  ngx.header["cache-control"]="no-cache, no-store, max-age=0"
  return ngx.exec(g_cache.err_return_page)
end

local count = g_cache.search_count
local loop
for loop = 1,count,1 do
  local res, err = red:get(keys)
  if not res then
    ngx.log(ngx.ERR, "[CACHE] failed to get keys: ", keys)
    ngx.header['X-CACHED-STATUS'] = 'MISS' 
    return ngx.exec(g_cache.err_return_page)
  end

  if res ~= ngx.null and type(res) == "string" then
    local values = res

    local headers, body = redis_string_split(values, '\n\n')

    if headers ~= nil and body ~= nil then
      local rt= {}
      string.gsub(headers, '[^'..'\n'..']+', function(w) table.insert(rt, w) end )

      for k,v in pairs(rt) do
          local header_name, header_value = redis_string_split(v, ':')
          ngx.header[header_name] = header_value
      end
      
      local ok, err = red:set_keepalive(g_cache.redis_max_idle_timeout, g_cache.redis_pool_size)
      if not ok then
        ngx.log(ngx.ERR, "[CACHE] failed to set keepalive", err )
      end

      ngx.header['X-CACHED-STATUS'] = 'HIT'

      ngx.print(body)
      ngx.exit(ngx.HTTP_OK)
    end
  end

  -- If the first time, then break to get reply from backend.
  if not ngx.shared.dict_cache_uri_search_flag:get(keys) then
    ngx.shared.dict_cache_uri_search_flag:set(keys, 1, g_cache.search_dict_exptime)
    break;
  end

  ngx.sleep(g_cache.search_sleep)

end

if loop == count then
  ngx.header['X-CACHED-STATUS'] = 'MISS'
  return ngx.exec(g_cache.err_return_page)
end


ngx.log(ngx.WARN, "[CACHE] Search from backend, key=", keys)


-- query from the backend.

for k,v in pairs(g_cache.req_header) do
  ngx.req.clear_header(k)
end

local capture_options = {copy_all_vars=true}
if ngx.var.request_method == "POST" then
   ngx.req.read_body()
   capture_options.method=ngx.HTTP_POST
   local req_body = ngx.var.request_body
   if not req_body and ngx.var.content_length ~= "0" then
    local file = ngx.req.get_body_file()
  if file then 
      local fp = io.open(file,"r")
      if fp then fp:seek("set",0) req_body = fp:read("*a") fp:close() end
  end
   end
   if not req_body then 
  ngx.log(ngx.ERR,"[CACHE]post request but doesnt has request_body,content_length:"..tostring(ngx.var.content_length))
        ngx.header['X-CACHED-STATUS'] = 'MISS'
    return ngx.exec('/reverse-proxy')
   end
   capture_options.body=req_body
   ngx.log(g_cache.log_level,"[CACHE]it's post request,cache_key is " ..keys)
end

local res_backend = ngx.location.capture('/reverse-proxy',capture_options)
if res_backend.status ~= ngx.HTTP_OK then
  ngx.shared.dict_cache_uri_search_flag:delete(keys)
  ngx.log(ngx.ERR,"[CACHE]response status is not ok,is "..res_backend.status)
  ngx.header['X-CACHED-STATUS'] = 'MISS'
  return ngx.exec('/reverse-proxy')
end

ngx.header['X-CACHED-STATUS'] = 'STORE'

-- save to the end.
local headers =''
local is_store = true
for k,v in pairs(res_backend.header) do

  if g_cache.resp_header[k] == "no-cache" then
    is_store = false
    break
  end

  if g_cache.resp_header[k] ~= "delete" and type(v) == "string" then
    headers = headers .. k .. ':' .. v .. '\n'
  end

end

if is_store == true then
  local body = res_backend.body
  local values = headers .. '\n' .. body
  local exptime = ngx.shared.dict_cache_uri_exptime:get(real_uri)
  if exptime == nil or exptime <= 0 then
    ngx.log(ngx.WARN, "[CACHE] Use default exptime, uri=", real_uri)
    exptime = g_cache.uri_default_exptime
  end

  local res, err = red:set(keys, values, "EX", exptime)
  if not res then
    ngx.log(ngx.ERR, "[CACHE] failed to set value: ", values)
  end
else
  ngx.log(ngx.WARN, "[CACHE] cache miss, key=", real_uri)
end

-- put it into the connection pool of size 100,
-- with 60 seconds max idle time
local ok, err = red:set_keepalive(g_cache.redis_max_idle_timeout, g_cache.redis_pool_size)
if not ok then
  ngx.log(ngx.ERR, "[CACHE] failed to set keepalive: ", err)
end

ngx.print(res_backend.body)
ngx.exit(ngx.HTTP_OK)
