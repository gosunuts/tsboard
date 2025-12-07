-- TSBOARD initial schema (copied from goapi env_setup.go)
CREATE TABLE IF NOT EXISTS tsb_user (
  uid INT UNSIGNED NOT NULL auto_increment,
  id VARCHAR(100) NOT NULL DEFAULT '',
  name VARCHAR(30) NOT NULL DEFAULT '',
  password CHAR(64) NOT NULL DEFAULT '',
  profile VARCHAR(300) NOT NULL DEFAULT '',
  level TINYINT UNSIGNED NOT NULL DEFAULT 0,
  point INT UNSIGNED NOT NULL DEFAULT 0,
  signature VARCHAR(300) NOT NULL DEFAULT '',
  signup BIGINT UNSIGNED NOT NULL DEFAULT 0,
  signin BIGINT UNSIGNED NOT NULL DEFAULT 0,
  blocked TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_user_token (
  user_uid INT UNSIGNED NOT NULL DEFAULT 0,
  refresh CHAR(64) NOT NULL DEFAULT '',
  timestamp BIGINT UNSIGNED NOT NULL DEFAULT 0,
  KEY (user_uid),
  CONSTRAINT fk_ut FOREIGN KEY (user_uid) REFERENCES tsb_user(uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_user_permission (
  uid INT UNSIGNED NOT NULL auto_increment,
  user_uid INT UNSIGNED NOT NULL DEFAULT 0,
  write_post TINYINT UNSIGNED NOT NULL DEFAULT '1',
  write_comment TINYINT UNSIGNED NOT NULL DEFAULT '1',
  send_chat TINYINT UNSIGNED NOT NULL DEFAULT '1',
  send_report TINYINT UNSIGNED NOT NULL DEFAULT '1',
  PRIMARY KEY (uid),
  KEY (user_uid),
  CONSTRAINT fk_up FOREIGN KEY (user_uid) REFERENCES tsb_user(uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_user_verification (
  uid INT UNSIGNED NOT NULL auto_increment,
  email VARCHAR(100) NOT NULL DEFAULT '',
  code CHAR(6) NOT NULL DEFAULT '',
  timestamp BIGINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_user_access_log (
  uid INT UNSIGNED NOT NULL auto_increment,
  user_uid INT UNSIGNED NOT NULL DEFAULT 0,
  timestamp BIGINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_user_black_list (
  user_uid INT UNSIGNED NOT NULL DEFAULT 0,
  black_uid INT UNSIGNED NOT NULL DEFAULT 0,
  KEY (user_uid),
  CONSTRAINT fk_ubl FOREIGN KEY (user_uid) REFERENCES tsb_user(uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_report (
  uid INT UNSIGNED NOT NULL auto_increment,
  to_uid INT UNSIGNED NOT NULL DEFAULT 0,
  from_uid INT UNSIGNED NOT NULL DEFAULT 0,
  request VARCHAR(1000) NOT NULL DEFAULT '',
  response VARCHAR(1000) NOT NULL DEFAULT '',
  timestamp BIGINT UNSIGNED NOT NULL DEFAULT 0,
  solved TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (uid),
  KEY (solved)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_chat (
  uid INT UNSIGNED NOT NULL auto_increment,
  to_uid INT UNSIGNED NOT NULL DEFAULT 0,
  from_uid INT UNSIGNED NOT NULL DEFAULT 0,
  message VARCHAR(1000) NOT NULL DEFAULT '',
  timestamp BIGINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (uid),
  KEY (to_uid),
  KEY (from_uid),
  CONSTRAINT fk_ct FOREIGN KEY (to_uid) REFERENCES tsb_user(uid),
  CONSTRAINT fk_cf FOREIGN KEY (from_uid) REFERENCES tsb_user(uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_group (
  uid INT UNSIGNED NOT NULL auto_increment,
  id VARCHAR(30) NOT NULL DEFAULT '',
  admin_uid INT UNSIGNED NOT NULL DEFAULT 0,
  timestamp BIGINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_board (
  uid INT UNSIGNED NOT NULL auto_increment,
  id VARCHAR(30) NOT NULL DEFAULT '',
  group_uid INT UNSIGNED NOT NULL DEFAULT 0,
  admin_uid INT UNSIGNED NOT NULL DEFAULT 0,
  type TINYINT NOT NULL DEFAULT 0,
  name VARCHAR(20) NOT NULL DEFAULT '',
  info VARCHAR(100) NOT NULL DEFAULT '',
  row_count TINYINT UNSIGNED NOT NULL DEFAULT '20',
  width INT UNSIGNED NOT NULL DEFAULT '1000',
  use_category TINYINT UNSIGNED NOT NULL DEFAULT 0,
  level_list TINYINT UNSIGNED NOT NULL DEFAULT 0,
  level_view TINYINT UNSIGNED NOT NULL DEFAULT 0,
  level_write TINYINT UNSIGNED NOT NULL DEFAULT 0,
  level_comment TINYINT UNSIGNED NOT NULL DEFAULT 0,
  level_download TINYINT UNSIGNED NOT NULL DEFAULT 0,
  point_view INT NOT NULL DEFAULT 0,
  point_write INT NOT NULL DEFAULT 0,
  point_comment INT NOT NULL DEFAULT 0,
  point_download INT NOT NULL DEFAULT 0,
  PRIMARY KEY (uid),
  CONSTRAINT fk_bg FOREIGN KEY (group_uid) REFERENCES tsb_group(uid),
  CONSTRAINT fk_ba FOREIGN KEY (admin_uid) REFERENCES tsb_user(uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_board_category (
  uid INT UNSIGNED NOT NULL auto_increment,
  board_uid INT UNSIGNED NOT NULL DEFAULT 0,
  name VARCHAR(30) NOT NULL DEFAULT '',
  PRIMARY KEY (uid),
  KEY (board_uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_point_history (
  uid INT UNSIGNED NOT NULL auto_increment,
  user_uid INT UNSIGNED NOT NULL DEFAULT 0,
  board_uid INT UNSIGNED NOT NULL DEFAULT 0,
  action TINYINT UNSIGNED NOT NULL DEFAULT 0,
  point INT NOT NULL DEFAULT 0,
  PRIMARY KEY (uid),
  KEY (user_uid),
  CONSTRAINT fk_ph_u FOREIGN KEY (user_uid) REFERENCES tsb_user(uid),
  CONSTRAINT fk_ph_b FOREIGN KEY (board_uid) REFERENCES tsb_board(uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_post (
  uid INT UNSIGNED NOT NULL auto_increment,
  board_uid INT UNSIGNED NOT NULL DEFAULT 0,
  user_uid INT UNSIGNED NOT NULL DEFAULT 0,
  category_uid INT UNSIGNED NOT NULL DEFAULT 0,
  title VARCHAR(300) NOT NULL DEFAULT '',
  content TEXT,
  submitted BIGINT UNSIGNED NOT NULL DEFAULT 0,
  modified BIGINT UNSIGNED NOT NULL DEFAULT 0,
  hit INT UNSIGNED NOT NULL DEFAULT 0,
  status TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (uid),
  KEY (board_uid),
  KEY (user_uid),
  KEY (category_uid),
  KEY (submitted),
  KEY (hit),
  KEY (status),
  CONSTRAINT fk_pb FOREIGN KEY (board_uid) REFERENCES tsb_board(uid),
  CONSTRAINT fk_pu FOREIGN KEY (user_uid) REFERENCES tsb_user(uid),
  CONSTRAINT fk_pc FOREIGN KEY (category_uid) REFERENCES tsb_board_category(uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_hashtag (
  uid INT UNSIGNED NOT NULL auto_increment,
  name VARCHAR(30) NOT NULL DEFAULT '',
  used INT UNSIGNED NOT NULL DEFAULT 0,
  timestamp BIGINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_post_hashtag (
  board_uid INT UNSIGNED NOT NULL DEFAULT 0,
  post_uid INT UNSIGNED NOT NULL DEFAULT 0,
  hashtag_uid INT UNSIGNED NOT NULL DEFAULT 0,
  KEY (board_uid),
  KEY (post_uid),
  KEY (hashtag_uid),
  CONSTRAINT fk_phb FOREIGN KEY (board_uid) REFERENCES tsb_board(uid),
  CONSTRAINT fk_php FOREIGN KEY (post_uid) REFERENCES tsb_post(uid),
  CONSTRAINT fk_phh FOREIGN KEY (hashtag_uid) REFERENCES tsb_hashtag(uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_post_like (
  board_uid INT UNSIGNED NOT NULL DEFAULT 0,
  post_uid INT UNSIGNED NOT NULL DEFAULT 0,
  user_uid INT UNSIGNED NOT NULL DEFAULT 0,
  liked TINYINT UNSIGNED NOT NULL DEFAULT 0,
  timestamp BIGINT UNSIGNED NOT NULL DEFAULT 0,
  KEY (post_uid),
  KEY (user_uid),
  KEY (liked),
  CONSTRAINT fk_plb FOREIGN KEY (board_uid) REFERENCES tsb_board(uid),
  CONSTRAINT fk_plp FOREIGN KEY (post_uid) REFERENCES tsb_post(uid),
  CONSTRAINT fk_plu FOREIGN KEY (user_uid) REFERENCES tsb_user(uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_comment (
  uid INT UNSIGNED NOT NULL auto_increment,
  reply_uid INT UNSIGNED NOT NULL DEFAULT 0,
  board_uid INT UNSIGNED NOT NULL DEFAULT 0,
  post_uid INT UNSIGNED NOT NULL DEFAULT 0,
  user_uid INT UNSIGNED NOT NULL DEFAULT 0,
  content VARCHAR(10000) NOT NULL DEFAULT '',
  submitted BIGINT UNSIGNED NOT NULL DEFAULT 0,
  modified BIGINT UNSIGNED NOT NULL DEFAULT 0,
  status TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (uid),
  KEY (reply_uid),
  KEY (board_uid),
  KEY (post_uid),
  KEY (user_uid),
  KEY (submitted),
  KEY (status),
  CONSTRAINT fk_cb FOREIGN KEY (board_uid) REFERENCES tsb_board(uid),
  CONSTRAINT fk_cp FOREIGN KEY (post_uid) REFERENCES tsb_post(uid),
  CONSTRAINT fk_cu FOREIGN KEY (user_uid) REFERENCES tsb_user(uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_comment_like (
  board_uid INT UNSIGNED NOT NULL DEFAULT 0,
  comment_uid INT UNSIGNED NOT NULL DEFAULT 0,
  user_uid INT UNSIGNED NOT NULL DEFAULT 0,
  liked TINYINT UNSIGNED NOT NULL DEFAULT 0,
  timestamp BIGINT UNSIGNED NOT NULL DEFAULT 0,
  KEY (comment_uid),
  KEY (user_uid),
  KEY (liked),
  CONSTRAINT fk_clb FOREIGN KEY (board_uid) REFERENCES tsb_board(uid),
  CONSTRAINT fk_clc FOREIGN KEY (comment_uid) REFERENCES tsb_comment(uid),
  CONSTRAINT fk_clu FOREIGN KEY (user_uid) REFERENCES tsb_user(uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_file (
  uid INT UNSIGNED NOT NULL auto_increment,
  board_uid INT UNSIGNED NOT NULL DEFAULT 0,
  post_uid INT UNSIGNED NOT NULL DEFAULT 0,
  name VARCHAR(100) NOT NULL DEFAULT '',
  path VARCHAR(300) NOT NULL DEFAULT '',
  timestamp BIGINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (uid),
  KEY (post_uid),
  CONSTRAINT fk_fb FOREIGN KEY (board_uid) REFERENCES tsb_board(uid),
  CONSTRAINT fk_fp FOREIGN KEY (post_uid) REFERENCES tsb_post(uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_file_thumbnail (
  uid INT UNSIGNED NOT NULL auto_increment,
  file_uid INT UNSIGNED NOT NULL DEFAULT 0,
  post_uid INT UNSIGNED NOT NULL DEFAULT 0,
  path VARCHAR(300) NOT NULL DEFAULT '',
  full_path VARCHAR(300) NOT NULL DEFAULT '',
  PRIMARY KEY (uid),
  KEY (file_uid),
  KEY (post_uid),
  CONSTRAINT fk_ftf FOREIGN KEY (file_uid) REFERENCES tsb_file(uid),
  CONSTRAINT fk_ftp FOREIGN KEY (post_uid) REFERENCES tsb_post(uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_image (
  uid INT UNSIGNED NOT NULL auto_increment,
  board_uid INT UNSIGNED NOT NULL DEFAULT 0,
  user_uid INT UNSIGNED NOT NULL DEFAULT 0,
  path VARCHAR(300) NOT NULL DEFAULT '',
  timestamp BIGINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (uid),
  KEY (user_uid),
  CONSTRAINT fk_ib FOREIGN KEY (board_uid) REFERENCES tsb_board(uid),
  CONSTRAINT fk_iu FOREIGN KEY (user_uid) REFERENCES tsb_user(uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_notification (
  uid INT UNSIGNED NOT NULL auto_increment,
  to_uid INT UNSIGNED NOT NULL DEFAULT 0,
  from_uid INT UNSIGNED NOT NULL DEFAULT 0,
  type TINYINT UNSIGNED NOT NULL DEFAULT 0,
  post_uid INT UNSIGNED NOT NULL DEFAULT 0,
  comment_uid INT UNSIGNED NOT NULL DEFAULT 0,
  checked TINYINT UNSIGNED NOT NULL DEFAULT 0,
  timestamp BIGINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (uid),
  KEY (to_uid),
  KEY (from_uid),
  KEY (post_uid),
  KEY (checked),
  CONSTRAINT fk_nt FOREIGN KEY (to_uid) REFERENCES tsb_user(uid),
  CONSTRAINT fk_nf FOREIGN KEY (from_uid) REFERENCES tsb_board(uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_exif (
  uid INT UNSIGNED NOT NULL auto_increment,
  file_uid INT UNSIGNED NOT NULL DEFAULT 0,
  post_uid INT UNSIGNED NOT NULL DEFAULT 0,
  make VARCHAR(20) NOT NULL DEFAULT '',
  model VARCHAR(20) NOT NULL DEFAULT '',
  aperture INT UNSIGNED NOT NULL DEFAULT 0,
  iso INT UNSIGNED NOT NULL DEFAULT 0,
  focal_length INT UNSIGNED NOT NULL DEFAULT 0,
  exposure INT UNSIGNED NOT NULL DEFAULT 0,
  width INT UNSIGNED NOT NULL DEFAULT 0,
  height INT UNSIGNED NOT NULL DEFAULT 0,
  date BIGINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (uid),
  KEY (file_uid),
  KEY (post_uid),
  CONSTRAINT fk_ef FOREIGN KEY (file_uid) REFERENCES tsb_file(uid),
  CONSTRAINT fk_ep FOREIGN KEY (post_uid) REFERENCES tsb_post(uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_image_description (
  uid INT UNSIGNED NOT NULL auto_increment,
  file_uid INT UNSIGNED NOT NULL DEFAULT 0,
  post_uid INT UNSIGNED NOT NULL DEFAULT 0,
  description VARCHAR(500) NOT NULL DEFAULT '',
  PRIMARY KEY (uid),
  KEY (file_uid),
  KEY (post_uid),
  CONSTRAINT fk_idf FOREIGN KEY (file_uid) REFERENCES tsb_file(uid),
  CONSTRAINT fk_idp FOREIGN KEY (post_uid) REFERENCES tsb_post(uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tsb_trade (
  uid INT UNSIGNED NOT NULL auto_increment,
  post_uid INT UNSIGNED NOT NULL DEFAULT 0,
  brand VARCHAR(100) NOT NULL DEFAULT '',
  category TINYINT UNSIGNED NOT NULL DEFAULT 0,
  price INT UNSIGNED NOT NULL DEFAULT 0,
  product_condition TINYINT UNSIGNED NOT NULL DEFAULT 0,
  location VARCHAR(100) NOT NULL DEFAULT '',
  shipping_type TINYINT UNSIGNED NOT NULL DEFAULT 0,
  status TINYINT UNSIGNED NOT NULL DEFAULT 0,
  completed BIGINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (uid),
  KEY (post_uid),
  KEY (status),
  CONSTRAINT fk_tpp FOREIGN KEY (post_uid) REFERENCES tsb_post(uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- seed data
INSERT INTO tsb_group (id, admin_uid, timestamp) VALUES ('boards', 1, UNIX_TIMESTAMP() * 1000);

INSERT INTO tsb_user (
  id, name, password, profile, level, point, signature, signup, signin, blocked
) VALUES (
  'admin', 'Admin', SHA2('admin123', 256), '', 9, 1000, '', UNIX_TIMESTAMP() * 1000, 0, 0
);

INSERT INTO tsb_board (
  id, group_uid, admin_uid, type, name, info, row_count, width, use_category,
  level_list, level_view, level_write, level_comment, level_download,
  point_view, point_write, point_comment, point_download
) VALUES
  ('free', 1, 1, 0, 'free', 'write everything you want', 15, 1000, 1, 0, 0, 1, 1, 1, 0, 5, 2, -10),
  ('photo', 1, 1, 1, 'gallery', 'home of photographers', 15, 1000, 1, 0, 0, 1, 1, 1, 0, 5, 2, -10);

INSERT INTO tsb_board_category (board_uid, name) VALUES
  (1, 'open'), (1, 'qna'), (1, 'news'),
  (2, 'daily'), (2, 'landscape'), (2, 'portrait');
