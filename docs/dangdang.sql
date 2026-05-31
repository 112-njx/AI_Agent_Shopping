/*
 Navicat Premium Data Transfer

 Source Server         : Java2010
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost:3306
 Source Schema         : dangdang

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 16/06/2021 09:12:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_address
-- ----------------------------
DROP TABLE IF EXISTS `t_address`;
CREATE TABLE `t_address`  (
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `province` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `city` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `district` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `town` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`address_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `t_address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_address
-- ----------------------------
INSERT INTO `t_address` VALUES (1, 'chenpx', '13271565362', '河南', '郑州', '惠济区', '南阳路', '升龙天汇广场', 1);
INSERT INTO `t_address` VALUES (2, 'cpx', '13271565363', '河南', '郑州', '惠济区', '南阳路', '刘寨社区', 1);

-- ----------------------------
-- Table structure for t_admin
-- ----------------------------
DROP TABLE IF EXISTS `t_admin`;
CREATE TABLE `t_admin`  (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`admin_id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `t_admin` VALUES (1, 'xiaohei', '123456');

-- ----------------------------
-- Table structure for t_book
-- ----------------------------
DROP TABLE IF EXISTS `t_book`;
CREATE TABLE `t_book`  (
  `BOOK_ID` int(11) NOT NULL AUTO_INCREMENT,
  `book_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `AUTHOR` varchar(90) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `COVER` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PRESS` varchar(90) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PRESS_DATE` date NOT NULL,
  `EDITION` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PRINT_DATE` date NOT NULL,
  `IMPRESSION` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ISBN` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `WORD_NUM` int(11) NOT NULL,
  `PAGE_NUM` int(11) NOT NULL,
  `SIZES` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PAPER` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PACK` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PRICE` float NOT NULL,
  `DPRICE` float NOT NULL,
  `CREATE_DATE` date NOT NULL,
  `EDITOR_RECOMMEND` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CONTENT_ABSTRACT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `AUTHOR_ABSTRACT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `DIRECTOR` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `MEDIA_COMMENTARY` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `category_id` int(11) NULL DEFAULT NULL,
  `SALE` int(11) NOT NULL,
  `STOCK` int(11) NOT NULL,
  PRIMARY KEY (`BOOK_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_book
-- ----------------------------
INSERT INTO `t_book` VALUES (1, '儒林外史', '吴敬梓', '16.jpg', '花山文艺出版社', '2019-07-01', '第三版,第三版,第三版,第三版', '2018-12-12', '第五次印刷', '9787551123426', 50000, 500, '16开', '胶版纸', '精装', 12, 10, '2019-01-07', '《儒林外史》，是一部描绘知识分子群像的长篇讽刺小说。作品描写了深受八股毒害的儒生的种种荒诞与虚伪行为。', '《儒林外史》，是一部描绘知识分子群像的长篇讽刺小说。作品描写了深受八股毒害的儒生的种种荒诞与虚伪行为。', '吴敬梓（1701-1754），汉族，安徽全椒人，清代最伟大的小说家之一。生活于“康乾盛世”时期，自幼聪慧好学。23岁时，考取秀才，当年其父吴霖起失官、病故。此后，他科场不顺，并经历了近亲掠夺祖产的事情，目睹了官场斗争的残酷。他开始挥金如土、纵情享乐，终致家财散尽。33岁时移居南京，生活清贫，喜交高雅之士，对热衷功名者嗤之以鼻。35岁时，决定放弃科考，并开始创作《儒林外史》。历13年书成，后坚持修改，直至54岁病逝。', '第　一　回 说楔子敷陈大义 借名流隐括全文 001\r\n第　二　回 王孝廉村学识同科 周蒙师暮年登上第 007\r\n第　三　回 周学道校士拔真才 胡屠户行凶闹捷报 012\r\n第　四　回 荐亡斋和尚吃官司 打秋风乡绅遭横事 019\r\n第　五　回 秀才议立偏房 严监生疾终正寝 024\r\n第　六　回 乡绅发病闹船家 寡妇含冤控大伯 030\r\n第　七　回 范学道视学报师恩 王员外立朝敦友谊 036\r\n第　八　回 王观察穷途逢世好 娄公子故里遇贫交 041\r\n第　九　回 娄公子捐金赎朋友 刘守备冒姓打船家 046\r\n第　十　回 鲁翰林怜才择婿 蘧公孙富室招亲 052\r\n第 十 一 回 鲁小姐制义难新郎 杨司训相府荐贤士 057\r\n第 十 二 回 名士大宴莺脰湖 侠客虚设人头会 062\r\n第 十 三 回 蘧夫求贤问业 马纯上仗义疏财 067\r\n第 十 四 回 蘧公孙书坊送良友 马秀才山洞遇神仙 073\r\n第 十 五 回 葬神仙马秀才送丧 思父母匡童生尽孝 078\r\n第 十 六 回 大柳庄孝子事亲 乐清县贤宰爱士 083\r\n第 十 七 回 匡秀才重游旧地 赵医生高踞诗坛 088\r\n第 十 八 回 约诗会名士携匡二 访朋友书店会潘三 093\r\n第 十 九 回 匡超人幸得良朋 潘自业横遭祸事 098\r\n第 二 十 回 匡超人高兴长安道 牛布衣客死芜湖关 103\r\n第二十一回 冒姓字小子求名 念亲戚老夫卧病 108\r\n第二十二回 认祖孙玉圃联宗 爱交游雪斋留客 113\r\n第二十三回 发阴私诗人被打 叹老景寡妇寻夫 119\r\n第二十四回 牛浦郎牵连多讼事 鲍文卿整理旧生涯 125\r\n第二十五回 鲍文卿南京遇旧 倪廷玺安庆招亲 130\r\n第二十六回 向观察升官哭友 鲍廷玺丧父娶妻 135\r\n第二十七回 王太太夫妻反目 倪廷珠兄弟相逢 140\r\n第二十八回 季苇萧扬州入赘 萧金铉白下选书 145\r\n第二十九回 诸葛佑僧寮遇友 杜慎卿江郡纳姬 150\r\n第 三 十 回 爱少俊访友神乐观 逞风流高会莫愁湖 155\r\n第三十一回 天长县同访豪杰 赐书楼大醉高朋 160\r\n第三十二回 杜少卿平居豪举 娄焕文临去遗言 166\r\n第三十三回 杜少卿夫妇游山 迟衡山朋友议礼 171\r\n第三十四回 议礼乐名流访友 备弓旌天子招贤 176\r\n第三十五回 圣天子求贤问道 庄征君辞爵还家 182\r\n第三十六回 常熟县真儒降生 泰伯祠名贤主祭 187\r\n第三十七回 祭先圣南京修礼 送孝子西蜀寻亲 192\r\n第三十八回 郭孝子深山遇虎 甘露僧狭路逢仇 198\r\n第三十九回 萧云仙救难明月岭 平少保奏凯青枫城 203\r\n第 四 十 回 萧云仙广武山赏雪 沈琼枝利涉桥卖文 208\r\n第四十一回 庄濯江话旧秦淮河 沈琼枝押解江都县 214\r\n第四十二回 公子妓院说科场 家人苗疆报信息 219\r\n第四十三回 野羊塘将军大战 歌舞地酋长劫营 224\r\n第四十四回 汤总镇成功归故乡 余明经把酒问葬事 229\r\n第四十五回 敦友谊代兄受过 讲堪舆回家葬亲 234\r\n第四十六回 三山门贤人饯别 五河县势利熏心 239\r\n第四十七回 虞秀才重修元武阁 方盐商大闹节孝祠 244\r\n第四十八回 徽州府烈妇殉夫 泰伯祠遗贤感旧 249\r\n第四十九回 翰林高谈龙虎榜 中书冒占凤凰池 254\r\n第 五 十 回 假官员当街出丑 真义气代友求名 259\r\n第五十一回 少妇骗人折风月 壮士高兴试官刑 263\r\n第五十二回 比武艺公子伤身 毁厅堂英雄讨债 267\r\n第五十三回 国公府雪夜留宾 来宾楼灯花惊梦 272\r\n第五十四回 病佳人青楼算命 呆名士妓馆献诗 277\r\n第五十五回 添四客述往思来 弹一曲高山流水 283\r\n第五十六回 神宗帝下诏旌贤 刘尚书奉旨承祭 288', '秉持公心，指摘时弊。机锋所向，尤在士林；其文又戚而能谐，婉而多讽。\r\n——鲁迅\r\n《儒林外史》是一部主角不断变换的长篇小说，其艺术特色堪称“精工提炼”。\r\n——胡适\r\n《儒林外史》里虽然没有一个*人称在那里穿线，但似乎有一个“我”在。这个“我”，把自己所历种种，老老实实地写了出来。\r\n——张天翼', 10, 0, 1000);
INSERT INTO `t_book` VALUES (2, '镜花缘', '李汝珍', 'jhy.jpg', '民主与建设出版社', '2019-10-01', '第四版', '2018-12-19', '第五次印刷', '9787551123426', 80000, 600, '16开', '胶版纸', '平装-胶订', 20, 18.5, '2019-01-15', '中国古典文学巨著，鲁迅称之为能“与万宝全书相邻比”的奇书）', '内容很好，买了就知道了', '李汝珍（约1763—约1830），字松石，号松石道人，直隶大兴（今属北京市）人。李汝珍自幼聪敏好学、多才多艺，精通音韵、博弈、书画、星卜等，著有音韵学著作《李氏音鉴》、围棋谱《受子谱》等。李汝珍凭借自己丰富的想象、幽默的笔调，运用夸张、隐喻、反衬等手法，创造出了结构独特、思想新颖的长篇小说《镜花缘》，书中写了君子国、女儿国、无肠国等国家，表现出作者无与伦比的想象力，而在其所描写的浪漫虚幻的世相下，却展现出对生命的热爱、对死亡的敬畏、对人类生存境遇的追问。', '第一回 女魁星北斗垂景象　老王母西池赐芳筵 001\r\n\r\n第二回 发正言花仙顺时令　定罚约月姊助风狂 004\r\n\r\n第三回 徐英公传檄起义兵　骆主簿修书寄良友 006\r\n\r\n第四回 吟雪诗暖阁赌酒　挥醉笔上苑催花 008\r\n\r\n第五回 俏宫娥戏夸金盏草　武太后怒贬牡丹花 011\r\n\r\n第六回 众宰承宣游上苑　百花获谴降红尘 014\r\n\r\n第七回 小才女月下论文科　老书生梦中闻善果 018\r\n\r\n第八回 弃嚣尘结伴游寰海　觅胜迹穷踪越远山 021\r\n\r\n第九回 服肉芝延年益寿　食朱草入圣超凡 024\r\n\r\n第十回 诛大虫佳人施药箭　搏奇鸟壮士奋空拳 028\r\n\r\n第十一回 观雅化闲游君子邦　慕仁风误入良臣府 032\r\n\r\n第十二回 双宰辅畅谈俗弊　两书生敬服良箴 035\r\n\r\n第十三回 美人入海遭罗网　儒士登山失路途 040\r\n\r\n第十四回 谈寿夭道经聂耳　论穷通路出无肠 043\r\n\r\n第十五回 喜相逢师生谈故旧　巧遇合宾主结新亲 046\r\n\r\n第十六回 紫衣女殷勤问字　白发翁傲慢谈文 050\r\n\r\n第十七回 因字声粗谈切韵　闻雁唳细问来宾 054\r\n\r\n第十八回 辟清谈幼女讲易经　发至论书生尊孟子 058\r\n\r\n第十九回 受女辱潜逃黑齿邦　观民风联步小人国 062\r\n\r\n第二十回 丹桂岩山鸡舞镜　碧梧岭孔雀开屏 066\r\n\r\n第二十一回 逢恶兽唐生被难　施神枪魏女解围 070\r\n\r\n第二十二回 遇白民儒士听奇文　观药兽武夫发妙论 074\r\n\r\n第二十三回 说酸话酒保咬文　讲迂谈腐儒嚼字 078\r\n\r\n第二十四回 唐探花酒楼闻善政　徐公子茶肆叙衷情 082\r\n\r\n第二十五回 越危垣潜出淑士关　登曲岸闲游两面国 085\r\n\r\n第二十六回 遇强梁义女怀德　遭大厄灵鱼报恩 088\r\n\r\n第二十七回 观奇形路过翼民郡　谈异相道出豕喙乡 092\r\n\r\n第二十八回 老书生仗义舞龙泉　小美女衔恩脱虎穴 096\r\n\r\n第二十九回 服妙药幼子回春　传奇方老翁济世 100\r\n\r\n第三十回 觅蝇头林郎货禽鸟　因恙体枝女作螟蛉 104\r\n\r\n第三十一回 谈字母妙语指谜团　看花灯戏言猜哑谜 107\r\n\r\n第三十二回 访筹算畅游智佳国　观艳妆闲步女儿乡 113\r\n\r\n第三十三回 粉面郎缠足受困　长须女玩股垂情 117\r\n\r\n第三十四回 观丽人女主定吉期　访良友老翁得凶信 120\r\n\r\n第三十五回 现红鸾林贵妃应课　揭黄榜唐义士治河 123\r\n\r\n第三十六回 佳人喜做东床婿　壮士愁为举案妻 127\r\n\r\n第三十七回 新贵妃返本为男　旧储子还原作女 130\r\n\r\n第三十八回 步玉桥茂林观凤舞　穿金户宝殿听鸾歌 133\r\n\r\n第三十九回 轩辕国诸王祝寿　蓬莱岛二老游山 136\r\n\r\n第四十回 入仙山撒手弃凡尘　走瀚海牵肠归故土 140\r\n\r\n第四十一回 观奇图喜遇佳文　述御旨欣逢盛典 144\r\n\r\n第四十二回 开女试太后颁恩诏　笃亲情佳人盼好音 152\r\n\r\n第四十三回 因游戏仙猿露意　念劬劳孝女伤怀 155\r\n\r\n第四十四回 小孝女岭上访红蕖　老道姑舟中献瑞草 159\r\n\r\n第四十五回 君子国海中逢水怪　丈夫邦岭下遇山精 162\r\n\r\n第四十六回 施慈悲仙子降妖　发慷慨储君结伴 166\r\n\r\n第四十七回 水月村樵夫寄信　镜花岭孝女寻亲 170\r\n\r\n第四十八回 睹碑记默喻仙机　观图章微明妙旨 173\r\n\r\n第四十九回 泣红亭书叶传佳话　流翠浦搴裳觅旧踪 178\r\n\r\n第五十回 遇难成祥马能伏虎　逢凶化吉妇可降夫 181\r\n\r\n第五十一回 走穷途孝女绝粮　得生路仙姑献稻 185\r\n\r\n第五十二回 谈春秋胸罗锦绣　讲礼制口吐珠玑 188\r\n\r\n第五十三回 论前朝数语分南北　书旧史挥毫贯古今 192\r\n\r\n第五十四回 通智慧白猿窃书　显奇能红女传信 196\r\n\r\n第五十五回 田氏女细谈妙剂　洛家娃默祷灵签 200', '好，很好', 13, 0, 1000);
INSERT INTO `t_book` VALUES (4, '聊斋志异', '蒲松龄', 'lzzy.jpg', '民主与建设出版社', '2019-07-01', '第三版', '2018-12-12', '第五次印刷', '9787551123426', 50000, 500, '16开', '胶版纸', '精装', 15, 14, '2019-01-07', '中国古代灵异与志怪小说的集大成者，收录近500篇知名小说', '清代小说家蒲松龄代表作，中国古代灵异、志怪小说的集大成者。', '作者很低调，没有做简介', '高序\r\n唐序\r\n聊斋自志\r\n卷一\r\n考城隍\r\n耳中人\r\n尸变\r\n喷水\r\n瞳人语\r\n画壁\r\n山魈\r\n咬鬼\r\n捉狐\r\n收中怪', '媒体也说很好看的一本书', 13, 0, 1000);
INSERT INTO `t_book` VALUES (5, '金瓶梅', '兰陵笑笑生', 'jpm.jpg', '吉林大学出版社', '2019-07-01', '第三版', '2018-12-12', '第五次印刷', '9787551123426', 50000, 500, '16开', '胶版纸', '精装', 125, 120, '2019-01-07', '中国伟大的写实小说，有明一代的百科全书，古代小说史上里程碑性质的作品，开拓了中国小说史的新阶段。没有《金瓶梅》，就产生不了《红楼梦》，《金瓶梅》与《红楼梦》是中华民族的骄傲，可以与世界*伟大的小说相媲美。 ', '中国伟大的写实小说 有明一代的百科全书 开拓了中国小说史上的新阶段', '作者很低调，没有做简介', '第一回\r\n西门庆热结十兄弟 武二郎冷遇亲哥嫂\r\n第二回\r\n俏潘娘帘下勾情 老王婆茶坊说技\r\n第三回\r\n定挨光王婆受贿 设圈套浪子私挑\r\n第四回\r\n赴巫山潘氏幽欢 闹茶坊郓哥义愤\r\n第五回\r\n捉奸情郓哥定计 饮酰药武大遭殃\r\n第六回\r\n何九受贿瞒天 王婆帮闲遇雨\r\n第七回\r\n薛媒婆说娶孟三儿 杨姑娘气骂张四舅\r\n第八回\r\n盼情郎佳人占鬼卦 烧夫灵和尚听淫声\r\n第九回\r\n西门庆偷娶潘金莲 武都头误打李皂隶\r\n第十回\r\n义士充配孟州道 妻妾玩赏芙蓉亭', '媒体也说很好看的一本书', 13, 0, 1000);
INSERT INTO `t_book` VALUES (6, '东周列国志', '冯梦龙', 'dzlgz.jpg', '民主与建设出版社', '2019-07-01', '第三版', '2018-12-12', '第五次印刷', '9787551123426', 50000, 500, '16开', '胶版纸', '精装', 20, 19, '2019-01-07', '当当网此版本销售火爆！写尽东周五百年群雄争霸颠覆历史格局的传奇巨著！', '古典小说精品系列： 《芈月传》小说原著及编剧蒋胜男读的首本书《 东周列国志 》 ', '作者很低调，没有做简介', '买了就知道目录了，我就不多介绍了', '媒体也说很好看的一本书', 13, 0, 1000);
INSERT INTO `t_book` VALUES (7, '搜神记', '马银琴', 'ssj.jpg', '中华书局出版社', '2019-07-01', '第三版', '2018-12-12', '第五次印刷', '9787551123426', 50000, 500, '16开', '胶版纸', '精装', 20, 19, '2019-01-07', '中华经典名著全书全注全译丛书', '中华经典名著全书全注全译丛书', '作者很低调，没有做简介', '买了就知道目录了，我就不多介绍了', '媒体也说很好看的一本书', 13, 0, 1000);
INSERT INTO `t_book` VALUES (8, '官场现形记', '李伯元', 'gcxxj.jpg', '上海古籍出版社', '2019-07-01', '第三版', '2018-12-12', '第五次印刷', '9787551123426', 50000, 600, '16开', '胶版纸', '平装-胶订', 22, 20, '2019-01-07', '中国官场有着说不尽道不明的故事。一个人不论身居什么环境，只要耳濡目染，久而久之，必然会潜移默化。因此，李伯元编著的《官场现形记》正是一面审视自己*好的借镜。', '中国官场有着说不尽道不明的故事。一个人不论身居什么环境，只要耳濡目染，久而久之，必然会潜移默化。', '作者很低调，没有做简介', '买了就知道目录了，我就不多介绍了', '媒体也说很好看的一本书', 13, 0, 1000);
INSERT INTO `t_book` VALUES (9, '世说新语', '刘义庆', 'ssxy.jpg', '上海古籍出版社', '2019-07-01', '第三版', '2018-12-12', '第五次印刷', '9787551123426', 50000, 600, '16开', '胶版纸', '平装-胶订', 30, 28, '2019-01-07', '世说新语详解(套装共2册)》包括《世说新语》原文、今译、刘孝标注、今注、评析五个部分。《世说新语》原文和刘孝标注以涵芬楼影印嘉趣堂本为底本，同时参考了余嘉锡《世说新语笺疏》等著作的校勘成果，力求保持原著的本来面貌；评析部分则注重历史事件、社会背景和人物关系的交代，以期钩深致远，充分阐发其本旨。', '刘义庆的《世说新语》是一部专记前代遗闻轶事 的笔记小说。《世说新语详解》是朱碧莲教授的*后一部著作', '刘义庆，南朝宋人，官至兖州刺史。为人“性简素，寡嗜欲”，喜与文学之士交游，在他的周围，聚集着一大批名儒硕学。他的著作丰富，其中最有名的是《世说新语》。这是一部记载汉末至魏晋时期士族阶层的言行风貌和逸事趣闻的笔记体小说。书中保留了大量反映当时社会生活的珍贵史料，语言简炼，文字生动鲜活，是一部文学价值极高的古典名著。刘义庆也因此书而名垂千古。', '序言\r\n前言\r\n德行第一\r\n言语第二\r\n政事第三\r\n文学第四\r\n方正第五\r\n雅量第六\r\n识鉴第七\r\n赏誉第八\r\n品藻第九\r\n规箴第十\r\n捷悟第十一\r\n夙惠第十二', '媒体也说很好看的一本书', 13, 0, 1000);
INSERT INTO `t_book` VALUES (10, '风神演义', '许仲琳', 'fsyy.jpg', '中华书局出版社', '2019-07-01', '第三版', '2018-12-12', '第五次印刷', '9787551123426', 50000, 600, '16开', '胶版纸', '平装-胶订', 50, 49, '2019-01-07', '封神演义》(作者许仲琳)是中国古代优秀的神话文学作品之一。它以周武王起兵伐纣的复杂曲折的斗争为主线，描写了许多仙道斗法的故事，塑造了凶残暴虐的纣王、神机妙算的姜子牙、三头六臂的哪吒等一大批栩栩如生的艺术形象。作品充分发挥神话传说的想象特长，幻想奇特，情节引人入胜，创造了一个色彩斑斓的奇妙世界。几百年来，一直在读者中广为流传。', ' 又名《商周列国全传》、《武王伐纣外史》、《封神 传》，中国神魔小说，为明代陈仲琳(一说是许仲琳) 所作，约成书于隆庆、万历年间。', '作者很低调，没有做简介', '第一回 纣王女娲宫进香\r\n第二回 冀州侯苏护反商\r\n第三回 姬昌解围进妲己\r\n第四回 恩州驿狐狸死妲己\r\n第五回 云中子进剑除妖\r\n第六回 纣王无道造炮烙\r\n第七回 费仲计废姜皇后\r\n第八回 方弼方相反朝歌\r\n第九回 商容九间殿死节\r\n第十回 姬伯燕山收雷震\r\n第十一回 里城囚西伯侯\r\n第十二回 陈塘关哪吒出世\r\n第十三回 太乙真人收石矶\r\n第十四回 哪吒现莲花化身', '媒体也说很好看的一本书', 13, 0, 1000);
INSERT INTO `t_book` VALUES (11, '西游记', '吴承恩', 'xyj.jpg', '人民文学出版社', '2019-10-01', '第四版', '2018-12-19', '第五次印刷', '9787551123426', 80000, 600, '16开', '胶版纸', '平装-胶订', 100, 88, '2019-01-15', '编辑没有推荐', '《西游记》主要描写的是孙悟空保唐僧西天取经，历经九九八十一难的故事。', '吴承恩（1500年-1582年），字汝忠，号淮海浪士，又号射阳山人。淮安府山阳县（今江苏省淮安市淮安区）人。中国明代杰出的小说家，著有中国古典四大名著之一《西游记》，被翻译成世界语。吴承恩一生创作丰富，但是由于家贫，又没有子女，作品多散失。据记载还著有志怪小说集《禹鼎记》，已失传。', '第一回 灵根育孕源流出 心性修持大道生\r\n第二回 悟彻菩提真妙理 断魔归本合元神\r\n第三回 四海千山皆拱伏 九幽十类尽除名\r\n第四回 官封弼马心何足 名注齐天意未宁\r\n第五回 乱蟠桃大圣偷丹 反天宫诸神捉怪\r\n第六回 观音赴会问原因 小圣施威降大圣\r\n第七回 八封炉中逃大圣 五行山下定心猿\r\n第八回 我佛造经传极乐 观音奉旨上长安\r\n第九回 袁守诚妙算无私曲 老龙王拙计犯天条\r\n第十回 二将军宫门镇鬼 唐太宗地府还魂\r\n第十一回 还受生唐王遵善果 度孤魂瑀萧正空门\r\n第十二回 玄奘秉诚建大会 观音显相化金蝉\r\n第十三回 陷虎穴金星解厄 双叉岭伯钦留僧\r\n第十四回 心猿归正 六贼无踪', '媒体也说很好看的一本书', 10, 0, 1000);
INSERT INTO `t_book` VALUES (12, '水浒传', '施耐庵', 'shz.jpg', '人民文学出版社', '2019-10-01', '第四版', '2018-12-19', '第五次印刷', '9787551123426', 80000, 600, '16开', '胶版纸', '平装-胶订', 100, 88, '2019-01-15', '编辑没有推荐', '《水浒传》是我国第一部以农民起义为题材的长篇章回小说，是我国文学史上一座巍然屹立的丰碑。', '作者很低调，没有做简介', '第一回 张天师祈禳瘟疫 \r\n洪太尉误走妖魔\r\n第二回 王教头私走延安府\r\n九纹龙大闹史家村\r\n第三回 史大郎夜走华阴县\r\n鲁提辖拳打镇关西\r\n第四回 赵员外重修文殊院\r\n鲁智深大闹五台山\r\n第五回 小霸王醉入销金帐\r\n花和尚大闹桃花村\r\n第六回 九纹龙剪径赤松林\r\n鲁智深火烧瓦罐寺\r\n第七回 花和尚倒拔垂杨柳', '媒体也说很好看的一本书', 10, 0, 1000);
INSERT INTO `t_book` VALUES (13, '三国演义', '罗贯中', 'sgyy.jpg', '人民文学出版社', '2019-10-01', '第四版', '2018-12-19', '第五次印刷', '9787551123426', 80000, 600, '16开', '胶版纸', '平装-胶订', 100, 88, '2019-01-15', '编辑没有推荐', '《三国演义》又名《三国志演义》、《三国志通俗演义》，是我国小说*著名最杰出的长篇章回体历史小说。', '作者很低调，没有做简介', '第001回　宴桃园豪杰三结义　斩黄巾英雄首立功\r\n第002回　张翼德怒鞭督邮　何国舅谋诛宦竖\r\n第003回　议温明董卓叱丁原　馈金珠李肃说吕布\r\n第004回　废汉帝陈留践位　谋董贼孟德献刀\r\n第005回　发矫诏诸镇应曹公　破关兵三英战吕布\r\n第006回　焚金阙董卓行凶　匿玉玺孙坚背约\r\n第007回　袁绍磐河战公孙　孙坚跨江击刘表\r\n第008回　王司徒巧使连环计　董太师大闹凤仪亭\r\n第009回　除暴凶吕布助司徒　犯长安李傕听贾诩\r\n第010回　勤王室马腾举义　报父仇曹操兴师\r\n第011回　刘皇叔北海救孔融　吕温侯濮阳破曹操\r\n第012回　陶恭祖三让徐州　曹孟穗大战吕布\r\n第013回　李傕郭汜大交兵　杨奉董承双救驾\r\n第014回　曹孟德移驾幸许都　吕奉先乘夜袭徐郡', '媒体也说很好看的一本书', 10, 0, 1000);
INSERT INTO `t_book` VALUES (14, '红楼梦', '曹雪芹', 'hlm.jpg', '人民文学出版社', '2019-10-01', '第四版', '2018-12-19', '第五次印刷', '9787551123426', 80000, 600, '16开', '胶版纸', '平装-胶订', 100, 88, '2019-01-15', '编辑没有推荐', '中国四大名著之一，本书是一部具有高度思想性和高度艺术性的伟大作品', '作者很低调，没有做简介', '第一回 甄士隐梦幻识通灵\r\n贾雨村风尘怀闺秀\r\n第二回 贾夫人仙逝扬州城\r\n冷子兴演说荣国府\r\n第三回 贾雨村夤缘复旧职\r\n林黛玉抛父进京都\r\n第四回 薄命女偏逢薄命郎\r\n戎芦僧乱判葫芦案\r\n第五回 游幻境指迷十二钗\r\n饮仙醪曲演红楼梦\r\n第六回 贾宝玉初试云雨情\r\n刘姥姥一进荣国府', '媒体也说很好看的一本书', 10, 0, 1000);
INSERT INTO `t_book` VALUES (15, '上课头疼的故事', '赵晓爽', '1.jpg', '百知教育出版社', '2019-10-01', '第四版', '2018-12-19', '第五次印刷', '9787551123426', 80000, 600, '16开', '胶版纸', '平装-胶订', 100, 89, '2019-01-15', '编辑没有推荐', '买了你就知道内容简介了', '作者很低调，没有做简介', '买了你就知道目录是啥了', '你的java学好了吗？', 12, 0, 1000);
INSERT INTO `t_book` VALUES (16, '上课睡觉的故事', '赵晓爽', '1.jpg', '百知教育出版社', '2019-10-01', '第四版', '2018-12-19', '第五次印刷', '9787551123426', 80000, 600, '16开', '胶版纸', '平装-胶订', 100, 89, '2019-01-15', '编辑没有推荐', '买了你就知道内容简介了', '作者很低调，没有做简介', '买了你就知道目录是啥了', '你的java学好了吗？', 12, 0, 1000);
INSERT INTO `t_book` VALUES (17, '下课头疼的故事', '赵晓爽', '1.jpg', '百知教育出版社', '2019-10-01', '第四版', '2018-12-19', '第五次印刷', '9787551123426', 80000, 600, '16开', '胶版纸', '平装-胶订', 100, 89, '2019-01-07', '编辑没有推荐', '买了你就知道内容简介了', '作者很低调，没有做简介', '买了你就知道目录是啥了', '你的java学好了吗？', 12, 0, 1000);
INSERT INTO `t_book` VALUES (18, '下课不睡觉的故事', '赵晓爽', '1.jpg', '百知教育出版社', '2019-10-01', '第四版', '2018-12-19', '第五次印刷', '9787551123426', 80000, 600, '16开', '胶版纸', '平装-胶订', 100, 89, '2019-01-07', '编辑没有推荐', '买了你就知道内容简介了', '作者很低调，没有做简介', '买了你就知道目录是啥了', '你的java学好了吗？', 12, 0, 1000);
INSERT INTO `t_book` VALUES (19, '中午吃饭的故事', '赵晓爽', '1.jpg', '百知教育出版社', '2019-10-01', '第四版', '2018-12-19', '第五次印刷', '9787551123426', 80000, 600, '16开', '胶版纸', '平装-胶订', 100, 89, '2019-01-07', '编辑没有推荐', '买了你就知道内容简介了', '作者很低调，没有做简介', '买了你就知道目录是啥了', '你的java学好了吗？', 12, 0, 1000);
INSERT INTO `t_book` VALUES (20, '早上不吃饭的故事', '赵晓爽', '1.jpg', '百知教育出版社', '2019-10-01', '第四版', '2018-12-19', '第五次印刷', '9787551123426', 80000, 600, '16开', '胶版纸', '平装-胶订', 100, 89, '2019-01-07', '编辑没有推荐', '买了你就知道内容简介了', '作者很低调，没有做简介', '买了你就知道目录是啥了', '你的java学好了吗？', 12, 0, 1000);
INSERT INTO `t_book` VALUES (21, '晚上减肥的故事', '赵晓爽', '1.jpg', '百知教育出版社', '2019-10-01', '第四版', '2018-12-19', '第五次印刷', '9787551123426', 80000, 600, '16开', '胶版纸', '平装-胶订', 100, 89, '2019-01-07', '编辑没有推荐', '买了你就知道内容简介了', '作者很低调，没有做简介', '买了你就知道目录是啥了', '你的java学好了吗？', 12, 0, 1000);
INSERT INTO `t_book` VALUES (22, '吃饭不减肥的故事', '赵晓爽', '1.jpg', '百知教育出版社', '2019-10-01', '第四版', '2018-12-19', '第五次印刷', '9787551123426', 80000, 600, '16开', '胶版纸', '平装-胶订', 100, 89, '2019-01-07', '编辑没有推荐', '买了你就知道内容简介了', '作者很低调，没有做简介', '买了你就知道目录是啥了', '你的java学好了吗？', 12, 0, 1000);
INSERT INTO `t_book` VALUES (23, '上课去厕所的故事', '赵晓爽', '1.jpg', '百知教育出版社', '2019-10-01', '第四版', '2018-12-19', '第五次印刷', '9787551123426', 80000, 600, '16开', '胶版纸', '平装-胶订', 100, 89, '2019-01-07', '编辑没有推荐', '买了你就知道内容简介了', '作者很低调，没有做简介', '买了你就知道目录是啥了', '你的java学好了吗？', 12, 0, 1000);
INSERT INTO `t_book` VALUES (24, '上课玩游戏的故事', '赵晓爽', '1.jpg', '百知教育出版社', '2019-10-01', '第四版', '2018-12-19', '第五次印刷', '9787551123426', 80000, 600, '16开', '胶版纸', '平装-胶订', 100, 89, '2019-01-22', '编辑没有推荐', '买了你就知道内容简介了', '作者很低调，没有做简介', '买了你就知道目录是啥了', '你的java学好了吗？', 12, 0, 1000);
INSERT INTO `t_book` VALUES (25, '1', '1', '16.jpg', '1', '2021-03-24', '1', '2021-03-24', '1', '1', 1, 1, '1', '11', '1', 1, 1, '2021-03-24', '1', '1', '1', '1', '1', 8, 0, 1);

-- ----------------------------
-- Table structure for t_category
-- ----------------------------
DROP TABLE IF EXISTS `t_category`;
CREATE TABLE `t_category`  (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `levels` int(11) NULL DEFAULT NULL,
  `parent_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `parent_id`(`parent_id`) USING BTREE,
  CONSTRAINT `t_category_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `t_category` (`category_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_category
-- ----------------------------
INSERT INTO `t_category` VALUES (1, '小说', 1, NULL);
INSERT INTO `t_category` VALUES (2, '文艺', 1, NULL);
INSERT INTO `t_category` VALUES (3, '科技', 1, NULL);
INSERT INTO `t_category` VALUES (4, '人文社科', 1, NULL);
INSERT INTO `t_category` VALUES (5, '生活', 1, NULL);
INSERT INTO `t_category` VALUES (6, '童书', 1, NULL);
INSERT INTO `t_category` VALUES (7, '教育', 1, NULL);
INSERT INTO `t_category` VALUES (8, '官场', 2, 1);
INSERT INTO `t_category` VALUES (9, '情感', 2, 1);
INSERT INTO `t_category` VALUES (10, '四大名著', 2, 1);
INSERT INTO `t_category` VALUES (11, '科幻小说', 2, 1);
INSERT INTO `t_category` VALUES (12, '近现代小说', 2, 1);
INSERT INTO `t_category` VALUES (13, '古典小说', 2, 1);
INSERT INTO `t_category` VALUES (14, '历史', 2, 4);
INSERT INTO `t_category` VALUES (15, '古籍', 2, 4);
INSERT INTO `t_category` VALUES (16, '哲学/宗教', 2, 4);
INSERT INTO `t_category` VALUES (17, '文化', 2, 4);
INSERT INTO `t_category` VALUES (18, '政治/军事', 2, 4);
INSERT INTO `t_category` VALUES (19, '法律', 2, 4);
INSERT INTO `t_category` VALUES (20, '文学', 2, 2);
INSERT INTO `t_category` VALUES (21, '传记', 2, 2);
INSERT INTO `t_category` VALUES (22, '艺术', 2, 2);
INSERT INTO `t_category` VALUES (23, '摄影', 2, 2);
INSERT INTO `t_category` VALUES (24, '科普', 2, 3);
INSERT INTO `t_category` VALUES (25, '建筑', 2, 3);
INSERT INTO `t_category` VALUES (26, '医学', 2, 3);
INSERT INTO `t_category` VALUES (27, '计算机', 2, 3);
INSERT INTO `t_category` VALUES (28, '农林', 2, 3);
INSERT INTO `t_category` VALUES (29, '自然科学', 2, 3);
INSERT INTO `t_category` VALUES (30, '两性', 2, 5);
INSERT INTO `t_category` VALUES (31, '孕期', 2, 5);
INSERT INTO `t_category` VALUES (32, '育儿', 2, 5);
INSERT INTO `t_category` VALUES (33, '亲自/家教', 2, 5);
INSERT INTO `t_category` VALUES (34, '保健', 2, 5);
INSERT INTO `t_category` VALUES (35, '运动', 2, 5);
INSERT INTO `t_category` VALUES (36, '家居', 2, 5);
INSERT INTO `t_category` VALUES (37, '0-2', 2, 6);
INSERT INTO `t_category` VALUES (38, '3-6', 2, 6);
INSERT INTO `t_category` VALUES (39, '7-10', 2, 6);
INSERT INTO `t_category` VALUES (40, '11-14', 2, 6);
INSERT INTO `t_category` VALUES (41, '绘本', 2, 6);
INSERT INTO `t_category` VALUES (42, '英语', 2, 6);
INSERT INTO `t_category` VALUES (43, '教材', 2, 7);
INSERT INTO `t_category` VALUES (44, '外语', 2, 7);
INSERT INTO `t_category` VALUES (45, '考试', 2, 7);
INSERT INTO `t_category` VALUES (46, '中小学教辅', 2, 7);
INSERT INTO `t_category` VALUES (47, '工具书', 2, 7);

-- ----------------------------
-- Table structure for t_item
-- ----------------------------
	DROP TABLE IF EXISTS `t_item`;
	CREATE TABLE `t_item`  (
	  `item_id` int(11) NOT NULL AUTO_INCREMENT,
	  `book_id` int(11) NULL DEFAULT NULL,
	  `count` int(11) NULL DEFAULT NULL,
	  `create_date` datetime(0) NULL,
	  `order_id` bigint NULL DEFAULT NULL,
	  PRIMARY KEY (`item_id`) USING BTREE,
	  INDEX `book_id`(`book_id`) USING BTREE,
	  INDEX `order_id`(`order_id`) USING BTREE,
	  CONSTRAINT `t_item_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `t_book` (`BOOK_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
	  CONSTRAINT `t_item_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `t_order` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
	) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_item
-- ----------------------------
INSERT INTO `t_item` VALUES (1, 14, 2, '2021-03-30 14:32:54', NULL);
INSERT INTO `t_item` VALUES (2, 25, 2, '2021-03-30 15:29:34', 3);

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order`  (
  `order_id` bigint(100),
  `total` double NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `province` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `city` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `district` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `town` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime(0) NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `t_order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB  CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES (2, 176, '未支付', 'chenpx', '13271565362', '河南', '郑州', '惠济区', '南阳路', '升龙汇金', '2021-03-30 14:32:54', 1);
INSERT INTO `t_order` VALUES (3, 2, '未支付', 'cpx', '13271565363', '河南', '郑州', '惠济区', '南阳路', '刘寨社区', '2021-03-30 15:29:34', 1);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `salt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nickname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` int(11) NULL DEFAULT NULL,
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, 'xiaobai@qq.com', '8c7498982f41b93eb0ce8216b48ba21d', 'abc', '小白', 1, 'kdkdk', '2021-03-23 17:03:39');

DROP TABLE IF EXISTS `t_pay`;
CREATE TABLE `t_pay`( 
  `pay_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `amount` decimal(10,2),
  `pay_method` int NOT NULL DEFAULT 1 COMMENT '支付方式，目前只支持支付宝支付',
  `pay_status` int NOT NULL DEFAULT 10 COMMENT '支付状态，10:支付中 20:已支付 30:已取消 40:已退款 50:已完成',
  `come_from` varchar(20) COMMENT '支付来源，比如当当网',
  `return_url` varchar(200) COMMENT '支付成功后的业务端回调通知地址，和支付宝回调的支付中心的地址不同',
  `create_time` datetime NULL DEFAULT now(),
  PRIMARY KEY (`pay_id`) USING BTREE
)ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
