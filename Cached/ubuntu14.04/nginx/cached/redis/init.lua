-- Redis Cache module: Transparent subrequest-based caching layout for arbitrary nginx locations. 
-- Auth: huangjingkai
-- Date: 201X/04/23

g_cache = {}
-- Server host and port.
g_cache.redis_host = "127.0.0.1"
g_cache.redis_port = 6379
g_cache.redis_password = "1qaz@WSX"

local redis_path = '/usr/local/NSP/etc/redis'
local file_uri_cache = redis_path .. '/uri_cache'

--[[
g_cache.err_return_page: failed page. 
]]
g_cache.err_return_page = "/503.html"

-- Sets the timeout (in ms) protection for subsequent operations, including the connect method.
g_cache.redis_timeout = 1000

--[[
Puts the current Redis connection immediately into the ngx_lua cosocket connection pool.
You can specify the max idle timeout (in ms) when the connection is in the pool and the maximal size of the pool every nginx worker process.
]]
g_cache.redis_max_idle_timeout = 60000
g_cache.redis_pool_size = 100
--[[
g_cache.search_count: 连接redis服务器，如果 key 值不存在的情况，并且不是该key值第一次查询的情况下，循环获取的次数。
g_cache.search_sleep: 连接redis服务器，如果 key 值不存在的情况，并且不是该key值第一次查询的情况下，每次循环需要等待的时间。
g_cache.search_dict_exptime: 首次获取 key 值，至少在该值之后，才会进行下一次查询。
]]
g_cache.search_count = 5
g_cache.search_sleep = 0.4
g_cache.search_dict_exptime = 1

-- 默认的uri超时时间，如果配置文件没有设置就使用这个值。
g_cache.uri_default_exptime = 5

-- 需要删除的 请求 的头域。
g_cache.req_header={
["Accept-Encoding"]=1,
}

-- 响应 头域中包含以下几个，属于 delete 则删除，属于 no-cache 则该响应不缓存。
g_cache.resp_header={
["ETag"]="delete",
["Content-Length"]="delete",
["Transfer-Encoding"]="no-cache",
["Set-Cookie"]="delete",
["Cookie"]="delete",
["Date"]="delete",
["Vary"]="delete",
}

-- [Configuration End]

function errs(a,b,c)
  ngx.log(ngx.WARN,a," ",b," ",c)
end

function redis_string_split(src, sub)
  if src == nil or sub == nil then return; end

  local output = {}
  local i,j = string.find(src,sub)
  if i == nil then return; end

  return string.sub(src, 1, i-1), string.sub(src, j+1, -1)
end

function string_split(s, p)
  local rt= {}
  string.gsub(s, '[^'..p..']+', function(w) table.insert(rt, w) end )
  return rt
end

function ngx_save_set(dict,key,value)
  success, err, forcible = dict:set(key,value)
  if not success then
    ngx.log(ngx.ERR, '[LUA] nginx dict set error, ', err)
  end
end

ngx.shared.dict_cache_uri_search_flag:flush_all()
ngx.shared.dict_cache_uri_exptime:flush_all()

ngx.log(ngx.WARN, '[CACHE] nginx redis script start.')