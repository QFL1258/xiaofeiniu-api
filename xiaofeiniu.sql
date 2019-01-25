SET NAMES UTF8;
DROP DATABASE IF EXISTS xiaofeiniu;
CREATE DATABASE xiaofeiniu CHARSET=UTF8;
USE xiaofeiniu;

/*管理员信息表：xfn_admin*/
CREATE TABLE xfn_admin(
  aid INT PRIMARY KEY AUTO_INCREMENT  /*管理员编号*/,
  aname VARCHAR(32) UNIQUE  /*管理员用户名*/,
  apwd VARCHAR(64)  /*管理员密码*/
);
INSERT INTO xfn_admin VALUES(NULL,'admin',PASSWORD('123456')),(NULL,'boss',PASSWORD('666666'));

/*项目全局设置：xfn_settings*/
CREATE TABLE xfn_settings(
  sid INT PRIMARY KEY AUTO_INCREMENT  /*编号*/,
  appName VARCHAR(32)   /*应用/店家名称*/,
  apiUrl VARCHAR(64)  /*数据API子系统地址*/,
  adminUrl VARCHAR(64)  /*管理后台子系统地址*/,
  appUrl VARCHAR(64)  /*顾客App子系统地址*/,
  icp VARCHAR(64)  /*系统备案号*/,
  copyright VARCHAR(128)  /*系统版权声明*/
);
INSERT INTO xfn_settings VALUES(NULL,'小肥牛','http://127.0.0.1:8090','http://127.0.0.1:8091','http://127.0.0.1:8092','京公网安备11010802020134号-京ICP证110507号','小米公司版权所有-京ICP备10046444-');


/*桌台信息表：xfn_table*/
CREATE TABLE xfn_table(
  tid INT PRIMARY KEY AUTO_INCREMENT, 
  tname VARCHAR(64), 
  type  VARCHAR(16),  
  status INT 
);
INSERT INTO xfn_table VALUES(NULL,'福满堂','6-8人桌',1),
(NULL,'福满堂','4人桌',2),
(NULL,'福满堂','10人桌',3),
(NULL,'福满堂','2人桌',4);

/*桌台预定信息表：xfn_reservation*/
CREATE TABLE xfn_reservation(
  rid INT PRIMARY KEY AUTO_INCREMENT,
  contactName VARCHAR(32), 
  phone  VARCHAR(16),  
  contactTime BIGINT, 
  dinnerTime BIGINT 
);
INSERT INTO xfn_reservation VALUES(NULL,'丁丁','16602117410','1548404830420','1518110400000'),
(NULL,'当当','16602117411','1545504830420','1518220400000'),
(NULL,'豆豆','16602117412','1546504830420','1518330400000'),
(NULL,'丫丫','16602117413','1547504830420','1518440400000');


/*菜品分类表：xfn_category*/
CREATE TABLE xfn_category(
  cid INT PRIMARY KEY AUTO_INCREMENT, 
  cname VARCHAR(32) 
);
INSERT INTO xfn_category VALUES(NULL,'捞派特色菜'),
(NULL,'蔬菜豆制品'),
(NULL,'海鲜河鲜'),
(NULL,'丸滑类'),
(NULL,'肉类'),
(NULL,'菌菇类');


/*菜品信息表：xfn_dish*/
CREATE TABLE xfn_dish(
  did INT PRIMARY KEY AUTO_INCREMENT, 
  title VARCHAR(32),   
  imgUrl VARCHAR(128),  
  price DECIMAL(6,2),
  detail  VARCHAR(128), 
  categoryId  INT,
  FOREIGN KEY(categoryId) REFERENCES xfn_category(cid)
);
INSERT INTO xfn_dish VALUES
(100000,'招牌虾滑','1.jpg',35,'精选湛江、北海区域出产的南美品种白虾虾仁，配以盐和淀粉等调料制作而成。虾肉含量越高，虾滑口感越纯正。相比纯虾肉，虾滑食用方便、入口爽滑鲜甜Q弹，海底捞独有的定制生产工艺，含肉量虾肉含量93%，出品装盘前手工摔打10次，是火锅中的经典食材。',1),
(NULL,'捞派无刺巴沙鱼','2.jpg',40,'巴沙鱼是东南亚淡水鱼品种。越南音译为"卡巴沙"(CABaSa)，意思是"三块脂肪鱼"，因为该鱼在生长过程中，腹腔积累有三块较大的油脂，约占体重的58%。海底捞选用越南湄公河流域养殖的巴沙鱼。经工厂低温车间宰杀、快速去皮等工艺加工成鱼柳，包装速冻，再通过海底捞中央厨房加工腌制而成。巴沙鱼口味鲜嫩，且无刺无腥味，特别适合老人、小孩食用。',2),
(NULL,'捞派黄喉','3.jpg',45,'黄喉主要是猪和牛的大血管，以脆爽见长，是四川火锅中的经典菜式。捞派黄喉选用猪黄喉，相比牛黄喉，猪黄喉只有30cm可用，肉质比牛黄喉薄，口感更脆。捞派黄喉，通过去筋膜、清水浸泡15小时以上，自然去除黄喉的血水和腥味。口感脆嫩弹牙，是川味火锅的经典菜式。',3);

-- 订单
CREATE TABLE xfn_order(
   oid INT PRIMARY KEY AUTO_INCREMENT,
   startTime BIGINT,
   endTime BIGINT,
   customerCount INT,
   tableId INT,
   FOREIGN KEY(tableId) REFERENCES xfn_table(tid)
);
INSERT INTO xfn_order VALUES
(1,1548104810420,1548405810420,3,1);

-- 订单详情
CREATE TABLE xfn_order_detail(
   did INT PRIMARY KEY AUTO_INCREMENT,
   dishId INT,  
--    键参考菜品.did
   dishCount INT,
   customerName VARCHAR(64),
   orderId INT,
   FOREIGN KEY(dishId) REFERENCES xfn_dish(did),
   FOREIGN KEY(orderId) REFERENCES xfn_order(oid)
);
INSERT INTO xfn_order_detail VALUES
(NULL,100000,1,'丁丁',1);