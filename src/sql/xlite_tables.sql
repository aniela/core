/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

DROP TABLE IF EXISTS xlite_categories;
CREATE TABLE xlite_categories (
  category_id int(11) unsigned NOT NULL AUTO_INCREMENT,
  parent_id int(11) NOT NULL DEFAULT '0',
  lpos int(11) NOT NULL DEFAULT '0',
  rpos int(11) NOT NULL DEFAULT '0',
  membership_id int(11) DEFAULT '0',
  enabled int(1) NOT NULL DEFAULT '1',
  cleanUrl varchar(255) NOT NULL DEFAULT '',
  show_title int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (category_id),
  KEY parent_id (parent_id),
  KEY lpos (lpos),
  KEY rpos (rpos),
  KEY membership_id (membership_id),
  KEY enabled (enabled),
  KEY clean_url (cleanUrl)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_category_images;
CREATE TABLE xlite_category_images (
  image_id int(11) unsigned NOT NULL AUTO_INCREMENT,
  id int(11) NOT NULL DEFAULT '0',
  path varchar(512) NOT NULL DEFAULT '',
  mime varchar(64) NOT NULL DEFAULT 'image/jpeg',
  width int(11) NOT NULL DEFAULT '0',
  height int(11) NOT NULL DEFAULT '0',
  size int(11) NOT NULL DEFAULT '0',
  date int(11) NOT NULL DEFAULT '0',
  hash varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (image_id),
  KEY id (id)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_category_products;
CREATE TABLE xlite_category_products (
  id int(11) unsigned NOT NULL AUTO_INCREMENT,
  product_id int(11) NOT NULL DEFAULT '0',
  category_id int(11) NOT NULL DEFAULT '0',
  orderby int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (id),
  UNIQUE KEY (category_id,product_id),
  KEY xlite_product_links_product (product_id),
  KEY orderby (orderby),
  KEY xlite_product_links_category (category_id)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_category_quick_flags;
CREATE TABLE xlite_category_quick_flags (
  id int(11) unsigned NOT NULL AUTO_INCREMENT,
  category_id int(11) unsigned NOT NULL DEFAULT '0',
  subcategories_count_all int(11) NOT NULL DEFAULT '0',
  subcategories_count_enabled int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (id),
  UNIQUE KEY (category_id),
  CONSTRAINT `xlite_ck_flags_to_categories` FOREIGN KEY (`category_id`) REFERENCES `xlite_categories` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_category_translations;
CREATE TABLE xlite_category_translations (
  label_id int(11) NOT NULL AUTO_INCREMENT,
  code char(2) NOT NULL,
  id int(11) NOT NULL DEFAULT '0',
  name char(255),
  description text,
  meta_tags varchar(255) DEFAULT '',
  meta_desc text,
  meta_title varchar(255) DEFAULT '',
  PRIMARY KEY (label_id),
  KEY ci (code,id),
  KEY i (id)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_config;
CREATE TABLE xlite_config (
  config_id int NOT NULL auto_increment,
  name varchar(32) NOT NULL default '',
  category varchar(32) NOT NULL default '',
  type enum('','text','textarea','checkbox','country','state','select','serialized','separator') default NULL,
  orderby int(11) NOT NULL default '0',
  value text NOT NULL,
  PRIMARY KEY  (config_id),
  UNIQUE KEY nc (category, name),
  KEY orderby (orderby),
  KEY type (type),
  KEY value (value (65536))
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_config_translations;
CREATE TABLE xlite_config_translations (
  label_id int(11) NOT NULL auto_increment,
  code char(2) NOT NULL,
  id int(11) NOT NULL default 0,
  option_name char(255) NOT NULL,
  option_comment char(255) NOT NULL,
  PRIMARY KEY (label_id),
  KEY ci (code, id),
  KEY i (id)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_currencies;
CREATE TABLE xlite_currencies (
  code char(3) NOT NULL,
  currency_id int(3) NOT NULL auto_increment PRIMARY KEY,
  symbol varchar(16) NOT NULL,
  e tinyint(1) NOT NULL,
  UNIQUE KEY code(code)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_currency_translations;
CREATE TABLE xlite_currency_translations (
  label_id int(11) NOT NULL AUTO_INCREMENT,
  code char(2) NOT NULL,
  id int(11) NOT NULL DEFAULT '0',
  name char(255) NOT NULL,
  PRIMARY KEY (label_id),
  KEY ci (code,id),
  KEY i (id)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;


DROP TABLE IF EXISTS xlite_waitingips;
CREATE TABLE xlite_waitingips (
  id int NOT NULL auto_increment,
  ip varchar(32) NOT NULL DEFAULT '',
  unique_key varchar(50) NOT NULL DEFAULT '',
  first_date int(11) NOT NULL DEFAULT '0',
  last_date int(11) NOT NULL DEFAULT '0',
  count int NOT NULL DEFAULT '0',
  PRIMARY KEY  (id),
  UNIQUE (ip)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_htaccess;
CREATE TABLE xlite_htaccess (
  id int NOT NULL auto_increment,
  filename varchar(64) NOT NULL DEFAULT '',
  content text NOT NULL DEFAULT '',
  hash varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY  (id),
  KEY hash (hash),
  UNIQUE (filename)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_countries;
CREATE TABLE xlite_countries (
  country varchar(50) NOT NULL default '',
  code char(2) NOT NULL default '',
  language varchar(32) NOT NULL default '',
  charset varchar(32) NOT NULL default 'iso-8859-1',
  enabled int(1) NOT NULL default '1',
  eu_member char(1) NOT NULL default 'N',
  PRIMARY KEY  (code),
  KEY country (country),
  KEY language (language),
  KEY charset (charset),
  KEY enabled (enabled),
  KEY eu_member (eu_member)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_log;
CREATE TABLE xlite_log (
  unixtime int(11) NOT NULL default '0',
  ident varchar(16) NOT NULL default '',
  priority int(11) default NULL,
  message varchar(200) default NULL,
  KEY unixtime (unixtime,ident),
  KEY priority (priority),
  KEY message (message)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_modules;
CREATE TABLE xlite_modules (
  module_id int(6) NOT NULL auto_increment,
  name varchar(64) NOT NULL default '',
  enabled int(1) unsigned NOT NULL default '0',
  installed int(1) unsigned NOT NULL default 0,
  last_update int(11) default NULL,
  last_version varchar(32) NOT NULL default '',
  PRIMARY KEY (module_id),
  UNIQUE KEY (name),
  KEY enabled (enabled)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_order_items;
CREATE TABLE xlite_order_items (
  item_id int(11) NOT NULL auto_increment PRIMARY KEY,
  order_id int(11) NOT NULL default '0',
  object_id int(11) NOT NULL default '0',
  object_type varchar(16) NOT NULL default 'product',
  name varchar(255) NOT NULL,
  sku varchar(255) NOT NULL default '',
  price decimal(16,4) NOT NULL default '0.0000',
  amount int(11) NOT NULL default '1',
  subtotal decimal(16,4) NOT NULL default '0.0000',
  total decimal(16,4) NOT NULL default '0.0000',
  KEY ooo (order_id, object_id, object_type),
  KEY price (price),
  KEY amount (amount)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_orders;
CREATE TABLE xlite_orders (
  order_id int(11) NOT NULL auto_increment PRIMARY KEY,
  profile_id int(11) NOT NULL default '0',
  orig_profile_id int(11) NOT NULL default '0',
  total decimal(16,4) NOT NULL default '0.00',
  subtotal decimal(16,4) NOT NULL default '0.00',
  tracking varchar(32) default NULL,
  date int(11) default NULL,
  status char(1) default 'I',
  notes text,
  taxes text,
  shipping_id int(11) default NULL,
  is_order int(1) NOT NULL default 1,
  currency_id int(3) NOT NULL default 840,
  KEY xlite_order_date (date),
  KEY profile_id (profile_id),
  KEY orig_profile_id (orig_profile_id),
  KEY total (total),
  KEY subtotal (subtotal),
  KEY tracking (tracking),
  KEY status (status),
  KEY notes (notes (65536)),
  KEY shipping_id (shipping_id)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_order_details;
CREATE TABLE xlite_order_details (
  detail_id int(11) NOT NULL auto_increment PRIMARY KEY,
  order_id int(11) NOT NULL default '0',
  name varchar(255) NOT NULL default '',
  label varchar(255) default NULL,
  value text NOT NULL,
  KEY oname (order_id, name)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_order_modifiers;
CREATE TABLE xlite_order_modifiers (
  id int(11) NOT NULL auto_increment PRIMARY KEY,
  order_id int(11) NOT NULL default '0',
  code varchar(32) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  is_visible tinyint(1) NOT NULL default 0,
  is_summable tinyint(1) NOT NULL default 1,
  subcode varchar(32) NOT NULL default '',
  surcharge decimal(16,4) NOT NULL default '0.0000',
  KEY ocs (order_id, code, subcode)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_order_item_modifiers;
CREATE TABLE xlite_order_item_modifiers (
  id int(11) NOT NULL auto_increment PRIMARY KEY,
  item_id int(11) NOT NULL default '0',
  code varchar(32) NOT NULL default '',
  name varchar(255) NOT NULL default '',
  is_visible tinyint(1) NOT NULL default 0,
  is_summable tinyint(1) NOT NULL default 1,
  subcode varchar(32) NOT NULL default '',
  surcharge decimal(16,4) NOT NULL default '0.0000',
  KEY ics (item_id, code, subcode)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_payment_methods;
CREATE TABLE xlite_payment_methods (
  method_id int(11) NOT NULL auto_increment PRIMARY KEY,
  service_name varchar(128) NOT NULL default '',
  class varchar(64) NOT NULL default '',
  orderby int(11) NOT NULL default '0',
  enabled tinyint(1) NOT NULL default '1',
  KEY orderby (orderby),
  KEY class (class, enabled),
  KEY enabled (enabled)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_payment_method_translations;
CREATE TABLE xlite_payment_method_translations (
  label_id int(11) NOT NULL AUTO_INCREMENT,
  code char(2) NOT NULL,
  id int(11) NOT NULL DEFAULT '0',
  name char(255) NOT NULL,
  description text NOT NULL default '',
  PRIMARY KEY (label_id),
  KEY ci (code,id),
  KEY i (id)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_payment_method_settings;
CREATE TABLE xlite_payment_method_settings (
  setting_id int(11) NOT NULL auto_increment PRIMARY KEY,
  method_id int(11) NOT NULL default 0,
  name varchar(128) NOT NULL,
  value text NOT NULL,
  KEY mn (method_id, name)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_payment_transactions;
CREATE TABLE xlite_payment_transactions (
  `transaction_id` int(11) NOT NULL auto_increment PRIMARY KEY,
  `order_id` int(11) NOT NULL default 0,
  `method_id` int(11) NOT NULL default 0,
  `method_name` varchar(128) NOT NULL,
  `method_local_name` varchar(255) NOT NULL,
  `status` char(1) NOT NULL default 'I',
  `value` decimal(16,4) NOT NULL default '0.0000',
  `type` char(8) NOT NULL default 'sale',
  `note` varchar(255) NOT NULL default '',
  KEY o (order_id, status),
  KEY pm (method_id, status),
  KEY status (status)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_payment_transaction_data;
CREATE TABLE xlite_payment_transaction_data (
  data_id int(11) NOT NULL auto_increment PRIMARY KEY,
  transaction_id int(11) NOT NULL default 0,
  name varchar(128) NOT NULL,
  label varchar(255) NOT NULL default '',
  access_level char(1) NOT NULL default 'A',
  value text NOT NULL,
  KEY tn (transaction_id, name)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_products;
CREATE TABLE xlite_products (
  product_id int(11) NOT NULL auto_increment,
  price decimal(12,2) NOT NULL default '0.00',
  sale_price decimal(12,2) NOT NULL default '0.00',
  sku varchar(32) NOT NULL default '',
  order_by int(11) NOT NULL default '0',
  enabled int(11) NOT NULL default '1',
  weight decimal(12,2) NOT NULL default '0.00',
  tax_class varchar(32) NOT NULL default '',
  free_shipping int(11) NOT NULL default '0',
  clean_url varchar(255) NOT NULL default '',
  javascript text NOT NULL,
  PRIMARY KEY (product_id),
  KEY order_by (order_by),
  KEY price (price),
  KEY sku (sku),
  KEY enabled (enabled),
  KEY weight (weight),
  KEY tax_class (tax_class),
  KEY free_shipping (free_shipping),
  KEY clean_url (clean_url)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_product_images;
CREATE TABLE xlite_product_images (
  `image_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id` int(11) NOT NULL DEFAULT '0',
  `path` varchar(512) NOT NULL DEFAULT '',
  `mime` varchar(64) NOT NULL DEFAULT 'image/jpeg',
  `width` int(11) NOT NULL DEFAULT '0',
  `height` int(11) NOT NULL DEFAULT '0',
  `size` int(11) NOT NULL DEFAULT '0',
  `date` int(11) NOT NULL DEFAULT '0',
  `hash` varchar(32) NOT NULL DEFAULT '',
  `alt` varchar(255) NOT NULL default '',
  `orderby` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (image_id),
  KEY id (id)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_product_translations;
CREATE TABLE xlite_product_translations (
  label_id int(11) NOT NULL AUTO_INCREMENT,
  code char(2) NOT NULL,
  id int(11) NOT NULL DEFAULT '0',
  name char(255) NOT NULL,
  description text NOT NULL,
  brief_description text NOT NULL,
  meta_tags varchar(255) NOT NULL DEFAULT '',
  meta_desc text NOT NULL,
  meta_title varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (label_id),
  KEY ci (code,id),
  KEY i (id)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_extra_fields;
CREATE TABLE xlite_extra_fields (
  field_id int(11) NOT NULL auto_increment,
  product_id int(11) NOT NULL default '0',
  name varchar(255) NOT NULL default '',
  default_value varchar(255) NOT NULL default '',
  enabled int(1) NOT NULL default '1',
  order_by int(11) NOT NULL default '0',
  parent_field_id int(11) NOT NULL default '0',
  categories text NOT NULL,
  PRIMARY KEY  (field_id),
  KEY product_id (product_id),
  KEY order_by (order_by),
  KEY name (name),
  KEY default_value (default_value),
  KEY enabled (enabled),
  KEY parent_field_id (parent_field_id),
  KEY categories (categories (65536))
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_extra_field_values;
CREATE TABLE xlite_extra_field_values (
  product_id int(11) NOT NULL default '0',
  field_id int(11) NOT NULL default '0',
  value text(65536) NOT NULL default '',
  KEY field_key (product_id, field_id),
  KEY value (value (65536))
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_profiles;
CREATE TABLE xlite_profiles (
  profile_id int(11) NOT NULL auto_increment,
  login varchar(128) NOT NULL default '',
  password varchar(32) NOT NULL default '',
  password_hint varchar(128) NOT NULL default '',
  password_hint_answer varchar(128) NOT NULL default '',
  access_level int(11) NOT NULL default '0',
  cms_profile_id int(11) NOT NULL default '0',
  cms_name varchar(32) NOT NULL default '',
  added int(11) NOT NULL default '0',
  first_login int(11) NOT NULL default '0',
  last_login int(11) NOT NULL default '0',
  status char(1) NOT NULL default 'E',
  referer varchar(255) NOT NULL default '',
  membership_id int(11) default NULL,
  pending_membership_id int(11) default NULL,
  order_id int(11) NOT NULL default '0',
  sidebar_boxes TEXT NOT NULL,
  language varchar(2) NOT NUll default 'en',
  last_shipping_id int(11) default NULL,
  last_payment_id int(11) default NULL,
  PRIMARY KEY (profile_id),
  KEY (cms_profile_id),
  KEY login (login),
  KEY order_id (order_id),
  KEY password (password),
  KEY access_level (access_level),
  KEY first_login (first_login),
  KEY last_login (last_login),
  KEY status (status),
  KEY membership_id (membership_id),
  KEY pending_membership_id (pending_membership_id)
) TYPE=MyISAM;

DROP TABLE IF EXISTS xlite_profile_addresses;
CREATE TABLE xlite_profile_addresses (
  address_id int(11) NOT NULL auto_increment,
  profile_id int(11) NOT NULL default 0,
  is_billing tinyint(1) NOT NULL default 0,
  is_shipping tinyint(1) NOT NULL default 0,
  address_type char(1) NOT NULL default 'R',
  title varchar(32) NOT NULL default '',
  firstname varchar(128) NOT NULL default '',
  lastname varchar(128) NOT NULL default '',
  phone varchar(32) NOT NULL default '',
  street varchar(64) NOT NULL default '',
  city varchar(64) NOT NULL default '',
  state_id int(11) NOT NULL default '0',
  custom_state varchar(64) NOT NULL default '',
  country_code char(2) NOT NULL default '',
  zipcode varchar(32) NOT NULL default '',
  PRIMARY KEY (address_id),
  KEY profile_id (profile_id),
  KEY is_billing (is_billing),
  KEY is_shipping (is_shipping)
) TYPE=MyISAM;

DROP TABLE IF EXISTS xlite_search_stat;
CREATE TABLE xlite_search_stat (
  query varchar(64) NOT NULL default '',
  product_count int(11) NOT NULL default '0',
  count int(11) NOT NULL default '0',
  PRIMARY KEY  (query),
  KEY product_count (product_count),
  KEY count (count)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_sessions;
CREATE TABLE xlite_sessions (
  id int(11) NOT NULL auto_increment,
  sid char(32) NOT NULL,
  expiry int(11) unsigned NOT NULL default 0,
  PRIMARY KEY id (id),
  UNIQUE KEY sid (sid),
  KEY expiry (expiry)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_session_cells;
CREATE TABLE xlite_session_cells (
  `cell_id` int(11) NOT NULL auto_increment,
  `id` int(11) NOT NULL default 0,
  `name` varchar(255) NOT NULL,
  `value` text,
  `type` varchar(16),
  PRIMARY KEY (cell_id),
  KEY id (id),
  UNIQUE KEY iname (id, name),
  CONSTRAINT `xlite_session_to_cells` FOREIGN KEY (`id`) REFERENCES `xlite_sessions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;


DROP TABLE IF EXISTS xlite_shipping_methods;
CREATE TABLE xlite_shipping_methods (
  method_id int(11) NOT NULL auto_increment,
  processor varchar(255) NOT NULL default '',
  carrier varchar(255) NOT NULL default '',
  code varchar(32) NOT NULL default '',
  enabled int(1) NOT NULL default '1',
  position int(11) NOT NULL default '0',
  PRIMARY KEY  (method_id),
  KEY processor (processor),
  KEY carrier (carrier),
  KEY enabled (enabled),
  KEY position (position)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_shipping_method_translations;
CREATE TABLE xlite_shipping_method_translations (
  label_id int(11) NOT NULL AUTO_INCREMENT,
  code char(2) NOT NULL,
  id int(11) NOT NULL DEFAULT '0',
  name char(255) NOT NULL,
  PRIMARY KEY (label_id),
  KEY ci (code,id),
  KEY i (id)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_shipping_markups;
CREATE TABLE xlite_shipping_markups (
  markup_id int(11) NOT NULL auto_increment,
  method_id int(11) NOT NULL default '0',
  zone_id int(11) NOT NULL default '0',
  min_weight decimal(12,2) NOT NULL default '0.00',
  max_weight decimal(12,2) NOT NULL default '999999.00',
  min_total decimal(12,2) NOT NULL default '0.00',
  max_total decimal(12,2) NOT NULL default '999999.00',
  min_items int(11) NOT NULL default '0',
  max_items int(11) NOT NULL default '999999',
  markup_flat decimal(12,2) NOT NULL default '0.00',
  markup_percent decimal(12,2) NOT NULL default '0.00',
  markup_per_item decimal(12,2) NOT NULL default '0.00',
  markup_per_weight decimal(12,2) NOT NULL default '0.00',
  PRIMARY KEY  (markup_id),
  KEY rate (method_id,zone_id,min_weight,min_total,min_items),
  KEY max_weight (max_weight),
  KEY max_total (max_total),
  KEY max_items (max_items),
  KEY markup_flat (markup_flat),
  KEY markup_per_item (markup_per_item),
  KEY markup_percent (markup_percent),
  KEY markup_per_weight (markup_per_weight)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_states;
CREATE TABLE xlite_states (
  state_id int(11) NOT NULL auto_increment,
  state varchar(32) NOT NULL default '',
  code varchar(32) NOT NULL default '',
  country_code char(2) NOT NULL default '',
  PRIMARY KEY  (state_id),
  KEY code (code,country_code),
  KEY state (state)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_upgrades;
CREATE TABLE xlite_upgrades (
  from_ver varchar(10) NOT NULL default '',
  to_ver varchar(10) NOT NULL default '',
  date int(11) NOT NULL default '0',
  PRIMARY KEY  (from_ver,to_ver),
  KEY date (date)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_form_ids;
CREATE TABLE xlite_form_ids (
  id int(11) NOT NULL auto_increment PRIMARY KEY,
  session_id int(11) NOT NULL,
  form_id varchar(32) NOT NULL,
  date int(11) NOT NULL,
  KEY session_id (session_id),
  UNIQUE KEY fs(form_id, session_id),
  CONSTRAINT `xlite_session_to_forms` FOREIGN KEY session_id (`session_id`) REFERENCES `xlite_sessions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_view_lists;
CREATE TABLE xlite_view_lists (
  list_id int(11) NOT NULL auto_increment PRIMARY KEY,
  class varchar(512) NOT NULL default '',
  list varchar(255) NOT NULL default '',
  zone varchar(16) NOT NULL default 'customer',
  child varchar(512) default '',
  weight mediumint unsigned NOT NULL default 0,
  tpl varchar(1024) NOT NULL default '',
  KEY clzw (class, list, zone, weight)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_template_patches;
CREATE TABLE xlite_template_patches (
  patch_id int(11) NOT NULL auto_increment PRIMARY KEY,
  zone varchar(16) NOT NULL default 'customer',
  lang varchar(2) NOT NULL default '',
  tpl varchar(64) NOT NULL default '',
  patch_type varchar(8) NOT NULL default '',
  xpath_query varchar(255) NOT NUll default '',
  xpath_insert_type varchar(16) NOT NULL default 'before',
  xpath_block text NOT NULL,
  regexp_pattern varchar(255) NOT NUll default '',
  regexp_replace text NOT NULL,
  custom_callback varchar(128) NOT NUll default '',
  KEY zlt (zone, lang, tpl)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;


-- ALTER TABLE xlite_modules CHANGE version version varchar(12) NOT NULL DEFAULT '0';

DROP TABLE IF EXISTS xlite_languages;
CREATE TABLE xlite_languages (
  lng_id int(11) NOT NULL auto_increment PRIMARY KEY,
  code char(2) NOT NULL,
  code3 char(3) NOT NULL default '',
  r2l int(1) NOT NULL default 0,
  status int(1) NOT NULL default 0,
  UNIQUE KEY code3 (code3),
  UNIQUE KEY code2 (code),
  KEY status(status)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_language_translations;
CREATE TABLE xlite_language_translations (
  label_id int(11) NOT NULL auto_increment PRIMARY KEY,
  code char(2) NOT NULL,
  id int(11) NOT NULL default 0,
  name char(64) NOT NULL,
  KEY ci (code, id),
  KEY i (id)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_language_labels;
CREATE TABLE xlite_language_labels (
  label_id int(11) NOT NULL auto_increment PRIMARY KEY,
  name varchar(255) NOT NULL default '',
  KEY name (name)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_language_label_translations;
CREATE TABLE xlite_language_label_translations (
  label_id int(11) NOT NULL auto_increment PRIMARY KEY,
  code char(2) NOT NULL,
  id int(11) NOT NULL default 0,
  label text NOT NULL,
  KEY ci (code, id),
  KEY i (id)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_memberships;
CREATE TABLE xlite_memberships (
  membership_id int(11) NOT NULL auto_increment PRIMARY KEY,
  orderby int(11) NOT NULL default 0,
  active int(1) NOT NULL default 1
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_membership_translations;
CREATE TABLE xlite_membership_translations (
  label_id int(11) NOT NULL auto_increment PRIMARY KEY,
  code char(2) NOT NULL,
  id int(11) NOT NULL default 0,
  name char(128) NOT NULL,
  KEY ci (code, id),
  KEY i (id)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_zones;
CREATE TABLE xlite_zones (
  zone_id int(11) NOT NULL auto_increment,
  zone_name varchar(64) NOT NULL default '',
  is_default int(1) NOT NULL default '0',
  PRIMARY KEY  (zone_id),
  KEY zone_name (zone_name),
  KEY zone_default (is_default)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

DROP TABLE IF EXISTS xlite_zone_elements;
CREATE TABLE xlite_zone_elements (
  element_id int(11) NOT NULL auto_increment,
  zone_id int(11) NOT NULL default '0',
  element_value varchar(255) NOT NULL default '',
  element_type char(1) NOT NULL default '',
  PRIMARY KEY  (element_id),
  KEY type_value (element_type,element_value),
  KEY id_type (zone_id,element_type)
) ENGINE InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;


