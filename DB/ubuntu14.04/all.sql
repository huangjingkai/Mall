DROP TABLE IF EXISTS verydows_admin;

CREATE TABLE verydows_admin (
  user_id smallint(5) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  username char(16) NOT NULL,
  password char(32) NOT NULL,
  name varchar(60) NOT NULL DEFAULT '',
  email varchar(60) NOT NULL DEFAULT '',
  last_ip char(15) NOT NULL DEFAULT '',
  last_date int(10) unsigned NOT NULL DEFAULT '0',
  created_date int(10) unsigned NOT NULL DEFAULT '0',
  hash char(40) NOT NULL DEFAULT ''
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_admin_active;
CREATE TABLE verydows_admin_active (
  sess_id char(32) NOT NULL PRIMARY KEY DEFAULT '',
  user_id smallint(5) unsigned NOT NULL,
  ip char(15) NOT NULL DEFAULT '0.0.0.0',
  dateline int(10) unsigned NOT NULL DEFAULT '0',
  expires int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_admin_role;
CREATE TABLE verydows_admin_role (
  user_id smallint(5) unsigned NOT NULL,
  role_id smallint(5) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_adv;
CREATE TABLE verydows_adv (
  adv_id mediumint(8) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  position_id smallint(5) unsigned NOT NULL DEFAULT '0',
  name varchar(100) NOT NULL DEFAULT '',
  type char(5) NOT NULL DEFAULT '',
  params text NOT NULL,
  codes text NOT NULL,
  start_date int(10) unsigned NOT NULL DEFAULT '0',
  end_date int(10) unsigned NOT NULL DEFAULT '0',
  seq tinyint(2) unsigned NOT NULL DEFAULT '99',
  status tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY position_id (position_id)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_adv_position;
CREATE TABLE verydows_adv_position (
  id smallint(5) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name varchar(100) NOT NULL DEFAULT '',
  width smallint(4) unsigned NOT NULL DEFAULT '0',
  height smallint(4) unsigned NOT NULL DEFAULT '0',
  codes text NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_aftersales;
CREATE TABLE verydows_aftersales (
  as_id mediumint(8) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  user_id mediumint(8) unsigned NOT NULL DEFAULT '0',
  order_id char(15) NOT NULL DEFAULT '',
  goods_id mediumint(8) unsigned NOT NULL DEFAULT '0',
  goods_qty smallint(5) unsigned NOT NULL DEFAULT '1',
  type tinyint(1) unsigned NOT NULL DEFAULT '0',
  cause text NOT NULL,
  mobile char(11) NOT NULL DEFAULT '',
  created_date int(10) unsigned NOT NULL DEFAULT '0',
  status tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY user_id (user_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_aftersales_message;
CREATE TABLE verydows_aftersales_message (
  id int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  as_id mediumint(8) unsigned NOT NULL DEFAULT '0',
  admin_id smallint(5) unsigned NOT NULL DEFAULT '0',
  content text NOT NULL,
  dateline int(10) unsigned NOT NULL DEFAULT '0',
  KEY as_id (as_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_article;
CREATE TABLE verydows_article (
  id mediumint(8) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  cate_id smallint(5) unsigned NOT NULL DEFAULT '0',
  title varchar(180) NOT NULL,
  picture varchar(255) NOT NULL DEFAULT '',
  content text NOT NULL,
  brief varchar(240) NOT NULL DEFAULT '',
  meta_keywords varchar(240) NOT NULL DEFAULT '',
  meta_description varchar(240) NOT NULL DEFAULT '',
  link varchar(255) NOT NULL DEFAULT '',
  status tinyint(1) unsigned NOT NULL DEFAULT '0',
  created_date int(10) unsigned NOT NULL DEFAULT '0',
  KEY cate_id (cate_id) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_article_cate;
CREATE TABLE verydows_article_cate (
  cate_id smallint(5) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  cate_name varchar(60) NOT NULL,
  meta_keywords varchar(240) NOT NULL DEFAULT '',
  meta_description varchar(240) NOT NULL DEFAULT '',
  seq tinyint(2) unsigned NOT NULL DEFAULT '99'
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_brand;
CREATE TABLE verydows_brand (
  brand_id smallint(5) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  brand_name varchar(60) NOT NULL DEFAULT '',
  brand_logo varchar(255) NOT NULL DEFAULT '',
  seq tinyint(2) unsigned NOT NULL DEFAULT '99'
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_email_queue;
CREATE TABLE verydows_email_queue (
  id int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  email varchar(60) NOT NULL DEFAULT '',
  tpl_id char(30) NOT NULL DEFAULT '',
  subject varchar(240) NOT NULL DEFAULT '',
  body text NOT NULL,
  is_html tinyint(1) unsigned NOT NULL DEFAULT '0',
  dateline int(10) unsigned NOT NULL DEFAULT '0',
  last_err varchar(255) NOT NULL DEFAULT '',
  err_count smallint(5) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_email_subscription;
CREATE TABLE verydows_email_subscription (
  id int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  email varchar(60) NOT NULL DEFAULT '',
  created_date int(10) unsigned NOT NULL DEFAULT '0',
  status tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_email_template;

CREATE TABLE verydows_email_template (
  id char(30) PRIMARY KEY NOT NULL,
  name varchar(50) NOT NULL DEFAULT '',
  subject varchar(240) NOT NULL DEFAULT '',
  is_html tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_feedback;

CREATE TABLE verydows_feedback (
  fb_id mediumint(8) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  user_id mediumint(8) unsigned NOT NULL DEFAULT '0',
  type tinyint(1) unsigned NOT NULL DEFAULT '0',
  subject varchar(120) NOT NULL DEFAULT '',
  content text NOT NULL,
  mobile char(11) NOT NULL DEFAULT '',
  created_date int(10) unsigned NOT NULL DEFAULT '0',
  status tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY user_id (user_id) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_feedback_message;
CREATE TABLE verydows_feedback_message (
  id int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  fb_id mediumint(8) unsigned NOT NULL DEFAULT '0',
  admin_id smallint(5) unsigned NOT NULL DEFAULT '0',
  content text NOT NULL,
  dateline int(10) unsigned NOT NULL DEFAULT '0',
  KEY fb_id (fb_id) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_friendlink;
CREATE TABLE verydows_friendlink (
  id smallint(5) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name varchar(60) NOT NULL DEFAULT '',
  logo varchar(255) NOT NULL DEFAULT '',
  url varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  created_date int(10) unsigned NOT NULL DEFAULT '0',
  seq tinyint(2) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_goods;
CREATE TABLE verydows_goods (
  goods_id mediumint(8) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  cate_id smallint(5) unsigned NOT NULL DEFAULT '0',
  brand_id smallint(5) unsigned NOT NULL DEFAULT '0',
  goods_name varchar(180) NOT NULL DEFAULT '',
  goods_sn char(20) NOT NULL DEFAULT '',
  now_price decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  original_price decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  goods_image varchar(30) NOT NULL DEFAULT '',
  goods_brief text NOT NULL,
  goods_content text NOT NULL,
  goods_weight decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  stock_qty smallint(4) unsigned NOT NULL DEFAULT '0',
  meta_keywords varchar(240) NOT NULL DEFAULT '',
  meta_description varchar(240) NOT NULL DEFAULT '',
  created_date int(10) unsigned NOT NULL DEFAULT '0',
  newarrival tinyint(1) unsigned NOT NULL DEFAULT '0',
  recommend tinyint(1) unsigned NOT NULL DEFAULT '0',
  bargain tinyint(1) unsigned NOT NULL DEFAULT '0',
  status tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY cate_id (cate_id)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_goods_album;
CREATE TABLE verydows_goods_album (
  id mediumint(8) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  goods_id mediumint(8) unsigned NOT NULL,
  image varchar(60) NOT NULL DEFAULT ''
) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_goods_attr;

CREATE TABLE verydows_goods_attr (
  goods_id mediumint(8) unsigned NOT NULL,
  attr_id mediumint(8) NOT NULL,
  value varchar(160) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_goods_cate;

CREATE TABLE verydows_goods_cate (
  cate_id smallint(5) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  parent_id smallint(5) unsigned NOT NULL DEFAULT '0',
  cate_name varchar(60) NOT NULL DEFAULT '',
  meta_keywords varchar(240) NOT NULL DEFAULT '',
  meta_description varchar(240) NOT NULL DEFAULT '',
  seq tinyint(2) unsigned NOT NULL DEFAULT '99',
  KEY parent_id (parent_id)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_goods_cate_attr;
CREATE TABLE verydows_goods_cate_attr (
  attr_id mediumint(8) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  cate_id smallint(5) unsigned NOT NULL DEFAULT '0',
  name varchar(60) NOT NULL DEFAULT '',
  opts text NOT NULL,
  uom varchar(20) NOT NULL DEFAULT '',
  filtrate tinyint(1) unsigned NOT NULL DEFAULT '0',
  seq tinyint(2) unsigned NOT NULL DEFAULT '99'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_goods_cate_brand;

CREATE TABLE verydows_goods_cate_brand (
  cate_id smallint(5) unsigned NOT NULL,
  brand_id smallint(5) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_goods_optional;
CREATE TABLE verydows_goods_optional (
  id int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  type_id smallint(5) unsigned NOT NULL DEFAULT '0',
  goods_id mediumint(8) unsigned NOT NULL DEFAULT '0',
  opt_text varchar(80) NOT NULL DEFAULT '',
  opt_price decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  KEY goods_id (goods_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_goods_optional_type;

CREATE TABLE verydows_goods_optional_type (
  type_id smallint(5) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name varchar(20) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_goods_related;

CREATE TABLE verydows_goods_related (
  goods_id mediumint(8) PRIMARY KEY NOT NULL,
  related_id mediumint(8) NOT NULL,
  direction tinyint(1) unsigned NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_goods_review;

CREATE TABLE verydows_goods_review (
  review_id int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  order_id char(15) NOT NULL DEFAULT '',
  goods_id mediumint(8) unsigned NOT NULL DEFAULT '0',
  user_id mediumint(8) unsigned NOT NULL DEFAULT '0',
  rating tinyint(1) unsigned NOT NULL DEFAULT '1',
  content text NOT NULL,
  created_date int(10) unsigned NOT NULL DEFAULT '0',
  status tinyint(1) unsigned NOT NULL DEFAULT '0',
  replied text NOT NULL,
  KEY goods_id (goods_id),
  KEY user_id (user_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_help;
CREATE TABLE verydows_help (
  id smallint(5) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  cate_id smallint(5) unsigned NOT NULL DEFAULT '0',
  title varchar(100) NOT NULL DEFAULT '',
  content text NOT NULL,
  meta_keywords varchar(240) NOT NULL DEFAULT '',
  meta_description varchar(240) NOT NULL DEFAULT '',
  link varchar(255) NOT NULL DEFAULT '',
  seq tinyint(2) unsigned NOT NULL DEFAULT '0',
  KEY cate_id (cate_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_help_cate;
CREATE TABLE verydows_help_cate (
  cate_id smallint(5) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  cate_name varchar(60) NOT NULL DEFAULT '',
  seq tinyint(2) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_navigation;

CREATE TABLE verydows_navigation (
  id smallint(5) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name varchar(60) NOT NULL DEFAULT '',
  link varchar(255) NOT NULL DEFAULT '',
  position tinyint(1) unsigned NOT NULL DEFAULT '0',
  target tinyint(1) unsigned NOT NULL DEFAULT '0',
  seq tinyint(2) unsigned NOT NULL DEFAULT '99',
  visible tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_oauth;
CREATE TABLE verydows_oauth (
  party char(10) NOT NULL DEFAULT '' PRIMARY KEY,
  name varchar(30) NOT NULL,
  params text NOT NULL,
  instruction varchar(240) NOT NULL DEFAULT '',
  enable tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_order;

CREATE TABLE verydows_order (
  id int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  order_id char(15) NOT NULL DEFAULT '',
  user_id mediumint(8) unsigned NOT NULL DEFAULT '0',
  shipping_method smallint(5) unsigned NOT NULL DEFAULT '0',
  payment_method smallint(5) unsigned NOT NULL DEFAULT '0',
  order_status tinyint(1) unsigned NOT NULL DEFAULT '1',
  goods_amount decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  shipping_amount decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  order_amount decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  memos varchar(240) NOT NULL DEFAULT '',
  created_date int(10) unsigned NOT NULL DEFAULT '0',
  payment_date int(10) unsigned NOT NULL DEFAULT '0',
  thirdparty_trade_id varchar(100) NOT NULL DEFAULT '',
  UNIQUE KEY order_id (order_id),
  KEY user_id (user_id)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_order_consignee;

CREATE TABLE verydows_order_consignee (
  id int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  order_id char(15) NOT NULL DEFAULT '',
  receiver varchar(20) NOT NULL DEFAULT '',
  province varchar(20) NOT NULL DEFAULT '',
  city varchar(20) NOT NULL DEFAULT '',
  borough varchar(20) NOT NULL DEFAULT '',
  address varchar(240) NOT NULL DEFAULT '',
  zip char(6) NOT NULL DEFAULT '',
  mobile char(11) NOT NULL DEFAULT '',
  UNIQUE KEY order_id (order_id)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_order_goods;
CREATE TABLE verydows_order_goods (
  id int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  order_id char(15) NOT NULL DEFAULT '',
  goods_id mediumint(8) unsigned NOT NULL DEFAULT '0',
  goods_name varchar(180) NOT NULL DEFAULT '',
  goods_image varchar(30) NOT NULL DEFAULT '',
  goods_qty smallint(5) NOT NULL DEFAULT '1',
  goods_price decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  is_reviewed tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY order_id (order_id)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_order_goods_optional;

CREATE TABLE verydows_order_goods_optional (
  id int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  map_id int(10) unsigned NOT NULL DEFAULT '0',
  opt_id int(10) unsigned NOT NULL DEFAULT '0',
  opt_type varchar(20) NOT NULL DEFAULT '',
  opt_text varchar(80) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_order_log;
CREATE TABLE verydows_order_log (
  id int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  order_id char(15) NOT NULL DEFAULT '',
  admin_id smallint(5) unsigned NOT NULL DEFAULT '0',
  operate char(10) NOT NULL,
  cause varchar(240) NOT NULL DEFAULT '',
  dateline int(10) unsigned NOT NULL DEFAULT '0',
  KEY order_id (order_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_order_shipping;

CREATE TABLE verydows_order_shipping (
  id mediumint(8) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  order_id char(15) NOT NULL DEFAULT '',
  carrier_id smallint(5) unsigned NOT NULL DEFAULT '0',
  tracking_no varchar(20) NOT NULL DEFAULT '',
  memos varchar(240) NOT NULL DEFAULT '',
  dateline int(10) unsigned NOT NULL DEFAULT '0',
  KEY order_id (order_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_payment_method;
CREATE TABLE verydows_payment_method (
  id tinyint(3) unsigned NOT NULL PRIMARY KEY,
  name varchar(30) NOT NULL DEFAULT '',
  type tinyint(1) unsigned NOT NULL DEFAULT '0',
  pcode varchar(20) NOT NULL DEFAULT '',
  params text NOT NULL,
  instruction varchar(240) NOT NULL DEFAULT '',
  seq tinyint(2) unsigned NOT NULL DEFAULT '99',
  enable tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_request_error;
CREATE TABLE verydows_request_error (
  ip char(15) NOT NULL DEFAULT '0.0.0.0' PRIMARY KEY,
  dateline int(10) unsigned NOT NULL DEFAULT '0',
  count tinyint(2) unsigned NOT NULL DEFAULT '0',
  lockout int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_role;
CREATE TABLE verydows_role (
  role_id smallint(5) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  role_name varchar(50) NOT NULL DEFAULT '',
  role_desc varchar(240) NOT NULL DEFAULT '',
  role_acl text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_sendmail_limit;

CREATE TABLE verydows_sendmail_limit (
  ip char(15) NOT NULL DEFAULT '',
  user_id mediumint(8) unsigned NOT NULL DEFAULT '0',
  type char(30) NOT NULL DEFAULT '',
  count tinyint(1) unsigned NOT NULL DEFAULT '1',
  dateline int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS verydows_shipping_carrier;

CREATE TABLE verydows_shipping_carrier (
  id smallint(5) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name varchar(30) NOT NULL DEFAULT '',
  tracking_url varchar(255) NOT NULL DEFAULT '',
  service_tel varchar(20) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_shipping_method;

CREATE TABLE verydows_shipping_method (
  id smallint(5) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name varchar(60) NOT NULL DEFAULT '',
  params text NOT NULL,
  instruction varchar(240) NOT NULL DEFAULT '',
  seq tinyint(2) unsigned NOT NULL DEFAULT '99',
  enable tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_user;

CREATE TABLE verydows_user (
  user_id mediumint(8) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  username char(16) NOT NULL DEFAULT '',
  password char(32) NOT NULL DEFAULT '',
  email varchar(60) NOT NULL DEFAULT '',
  mobile char(11) NOT NULL DEFAULT '',
  avatar varchar(50) NOT NULL DEFAULT '',
  status tinyint(1) unsigned NOT NULL DEFAULT '0',
  email_status tinyint(1) unsigned NOT NULL DEFAULT '0',
  mobile_status tinyint(1) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY username (username),
  KEY email (email)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_user_account;

CREATE TABLE verydows_user_account (
  user_id mediumint(8) unsigned NOT NULL PRIMARY KEY DEFAULT '0',
  balance decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  points int(10) unsigned NOT NULL DEFAULT '0',
  exp int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_user_account_log;
CREATE TABLE verydows_user_account_log (
  id int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  user_id mediumint(8) unsigned NOT NULL DEFAULT '0',
  admin_id smallint(5) unsigned NOT NULL DEFAULT '0',
  balance decimal(10,2) NOT NULL DEFAULT '0.00',
  points int(10) unsigned NOT NULL DEFAULT '0',
  exp int(10) unsigned NOT NULL DEFAULT '0',
  cause varchar(255) NOT NULL DEFAULT '',
  dateline int(10) unsigned NOT NULL DEFAULT '0',
  KEY user_id (user_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_user_consignee;
CREATE TABLE verydows_user_consignee (
  id int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  user_id mediumint(8) unsigned NOT NULL DEFAULT '0',
  receiver varchar(20) NOT NULL DEFAULT '',
  province tinyint(2) unsigned NOT NULL DEFAULT '0',
  city tinyint(2) unsigned NOT NULL DEFAULT '0',
  borough tinyint(2) unsigned NOT NULL DEFAULT '0',
  address varchar(240) NOT NULL DEFAULT '',
  zip char(6) NOT NULL DEFAULT '',
  mobile char(11) NOT NULL DEFAULT '',
  is_default tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_user_favorite;
CREATE TABLE verydows_user_favorite (
  user_id mediumint(8) unsigned NOT NULL PRIMARY KEY DEFAULT '0',
  goods_id mediumint(8) unsigned NOT NULL,
  created_date int(10) unsigned NOT NULL DEFAULT '0',
  KEY user_id (user_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_user_group;

CREATE TABLE verydows_user_group (
  group_id smallint(5) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  group_name varchar(60) NOT NULL,
  min_exp int(10) unsigned NOT NULL DEFAULT '0',
  discount_rate tinyint(3) unsigned NOT NULL DEFAULT '100'
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_user_oauth;

CREATE TABLE verydows_user_oauth (
  id int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  user_id mediumint(8) unsigned NOT NULL DEFAULT '0',
  party char(10) NOT NULL DEFAULT '',
  oauth_key char(32) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_user_profile;

CREATE TABLE verydows_user_profile (
  user_id mediumint(8) unsigned NOT NULL PRIMARY KEY,
  nickname varchar(30) NOT NULL DEFAULT '',
  gender tinyint(1) unsigned NOT NULL DEFAULT '0',
  birth_year smallint(4) unsigned NOT NULL DEFAULT '0',
  birth_month tinyint(2) unsigned NOT NULL DEFAULT '0',
  birth_day tinyint(2) unsigned NOT NULL DEFAULT '0',
  qq varchar(15) NOT NULL DEFAULT '',
  signature varchar(120) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS verydows_user_record;

CREATE TABLE verydows_user_record (
  user_id mediumint(8) unsigned NOT NULL PRIMARY KEY,
  created_date int(10) unsigned NOT NULL DEFAULT '0',
  created_ip char(15) NOT NULL DEFAULT '0.0.0.0',
  last_date int