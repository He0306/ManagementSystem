/*
 Navicat Premium Data Transfer

 Source Server         : 22-7-19腾讯云
 Source Server Type    : MySQL
 Source Server Version : 80031
 Source Host           : 101.34.43.146:3306
 Source Schema         : springboot-vue

 Target Server Type    : MySQL
 Target Server Version : 80031
 File Encoding         : 65001

 Date: 27/03/2023 19:24:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '内容',
  `user` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '发布人',
  `time` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (1, '文章标题1', '111![1.jpg](http://localhost:8181/file/e02ccfec66fb44539d07a2aecc374cb0.jpg)\n\n## 123', '管理员', '2022-10-03 14:46:27');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '课程名称',
  `score` int NULL DEFAULT NULL COMMENT '学分',
  `times` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '上课时间',
  `state` tinyint(1) NULL DEFAULT NULL COMMENT '是否开课',
  `teacher_id` int NULL DEFAULT NULL COMMENT '授课老师ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (2, '高等数学', 6, '48', 1, 25);
INSERT INTO `course` VALUES (4, '高等数学', 8, '40', 1, 25);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '名称',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '单价',
  `store` int NULL DEFAULT NULL COMMENT '库存',
  `unit` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '单位',
  `img` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '封面',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (2, '红烧肉', 9999.00, 100, '斤', 'http://hechao.online:8181/file/78afbf0bb8434f24a1d8dbbafa347f50.jpg');
INSERT INTO `goods` VALUES (3, '海鲜大虾', 520.00, 1000, '斤', 'http://hechao.online:8181/file/2c23d5ec624444f487061e4161ad0943.jpeg');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '名称',
  `time` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '订单时间',
  `state` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '支付状态',
  `total` decimal(10, 2) NULL DEFAULT NULL COMMENT '订单总价',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `payment_time` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '支付时间',
  `alipay_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '支付宝交易号',
  `return_time` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '退款时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (70, '202301071673091699819', '海鲜大虾', '2023-01-07 19:41:39', '已支付', 520.00, 1, '2023-01-07 19:42:17', '2023010722001464620502263171', NULL);
INSERT INTO `orders` VALUES (71, '202301091673230600833', '红烧肉', '2023-01-09 10:16:40', '已退款', 9999.00, 1, '2023-03-08 16:54:43', '2023030822001464620502290086', '2023-03-11 14:17:52');

-- ----------------------------
-- Table structure for student_course
-- ----------------------------
DROP TABLE IF EXISTS `student_course`;
CREATE TABLE `student_course`  (
  `student_id` int NOT NULL,
  `course_id` int NOT NULL,
  PRIMARY KEY (`student_id`, `course_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student_course
-- ----------------------------
INSERT INTO `student_course` VALUES (1, 2);
INSERT INTO `student_course` VALUES (1, 3);
INSERT INTO `student_course` VALUES (29, 2);
INSERT INTO `student_course` VALUES (29, 3);
INSERT INTO `student_course` VALUES (29, 4);
INSERT INTO `student_course` VALUES (34, 2);
INSERT INTO `student_course` VALUES (4764, 2);

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '名称',
  `value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '内容',
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES (1, 'el-icon-user', 'el-icon-user', 'icon');
INSERT INTO `sys_dict` VALUES (2, 'el-icon-house', 'el-icon-house', 'icon');
INSERT INTO `sys_dict` VALUES (3, 'el-icon-menu', 'el-icon-menu', 'icon');
INSERT INTO `sys_dict` VALUES (4, 'el-icon-s-custom', 'el-icon-s-custom', 'icon');
INSERT INTO `sys_dict` VALUES (5, 'el-icon-document', 'el-icon-document', 'icon');
INSERT INTO `sys_dict` VALUES (6, 'el-icon-setting', 'el-icon-setting', 'icon');
INSERT INTO `sys_dict` VALUES (7, 'el-icon-map-location', 'el-icon-map-location', 'icon');
INSERT INTO `sys_dict` VALUES (8, 'el-icon-s-claim', 'el-icon-s-claim', 'icon');
INSERT INTO `sys_dict` VALUES (9, 'el-icon-view', 'el-icon-view', 'icon');
INSERT INTO `sys_dict` VALUES (13, 'el-icon-folder-opened', 'el-icon-folder-opened', 'icon');
INSERT INTO `sys_dict` VALUES (14, 'el-icon-location-outline', 'el-icon-location-outline', 'icon');
INSERT INTO `sys_dict` VALUES (15, 'el-icon-chat-dot-round', 'el-icon-chat-dot-round', 'icon');
INSERT INTO `sys_dict` VALUES (16, 'el-icon-goods', 'el-icon-goods', 'icon');
INSERT INTO `sys_dict` VALUES (17, 'el-icon-s-order', 'el-icon-s-order', 'icon');

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '文件类型',
  `size` bigint NULL DEFAULT NULL COMMENT '文件大小',
  `url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '文件路径',
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  `enable` tinyint(1) NULL DEFAULT 1 COMMENT '是否禁用链接',
  `md5` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '文件md5',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 76 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_file
-- ----------------------------
INSERT INTO `sys_file` VALUES (73, '1.jpg', 'jpg', 94, 'https://hechao.online:8181/file/4e8bb20125a646e89d6c56bf9df26297.jpg', 0, 1, 'f0656e56c8ad637a7e51be459ea99cdb');
INSERT INTO `sys_file` VALUES (74, 'Dreamland.jpg', 'jpg', 62, 'https://hechao.online:8181/file/124953ee4e0c4d4db42e5b55b2e8fc4f.jpg', 0, 1, 'd89626dfb9798d17b54b5b7473e4843f');
INSERT INTO `sys_file` VALUES (75, '1.php', 'php', 0, 'https://hechao.online:8181/file/4b65b28bc9e340df8ff6b2d9f792defc.php', 0, 1, '901c391f79607d8c07d392fa6c7b4c0f');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '名称',
  `path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '路劲',
  `icon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '图标',
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '描述',
  `sort_num` int NULL DEFAULT NULL COMMENT '排序',
  `pid` int NULL DEFAULT NULL COMMENT '父级ID',
  `page_path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '页面路径',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '主页', '/home', 'el-icon-house', '', NULL, NULL, 'Home');
INSERT INTO `sys_menu` VALUES (4, '系统管理', NULL, 'el-icon-setting', NULL, NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (5, '用户管理', '/user', 'el-icon-user', NULL, NULL, 4, 'User');
INSERT INTO `sys_menu` VALUES (6, '角色管理', '/role', 'el-icon-s-custom', NULL, NULL, 4, 'Role');
INSERT INTO `sys_menu` VALUES (7, '文件管理', '/file', 'el-icon-folder-opened', NULL, NULL, 4, 'File');
INSERT INTO `sys_menu` VALUES (8, '菜单管理', '/menu', 'el-icon-menu', NULL, NULL, 4, 'Menu');
INSERT INTO `sys_menu` VALUES (11, '课程管理', '/course', 'el-icon-s-claim', NULL, NULL, NULL, 'Course');
INSERT INTO `sys_menu` VALUES (12, '疫情地图', '/epidemic', 'el-icon-map-location', NULL, NULL, NULL, 'Epidemic');
INSERT INTO `sys_menu` VALUES (13, '图标管理', '/dict', 'el-icon-view', '', NULL, 4, 'Dict');
INSERT INTO `sys_menu` VALUES (14, '文章管理', '/article', 'el-icon-document', NULL, NULL, NULL, 'Article');
INSERT INTO `sys_menu` VALUES (15, '高德地图', 'map', 'el-icon-location-outline', NULL, NULL, NULL, 'Map');
INSERT INTO `sys_menu` VALUES (16, '聊天室', '/im', 'el-icon-chat-dot-round', NULL, NULL, NULL, 'Im');
INSERT INTO `sys_menu` VALUES (17, '商品管理', '/goods', 'el-icon-goods', NULL, 999, NULL, 'Goods');
INSERT INTO `sys_menu` VALUES (18, '订单管理', '/orders', 'el-icon-s-order', NULL, 999, NULL, 'Orders');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '名称',
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '描述',
  `flag` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '唯一标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '管理员', '管理员', 'ROLE_ADMIN');
INSERT INTO `sys_role` VALUES (2, '学生', '学生', 'ROLE_STUDENT');
INSERT INTO `sys_role` VALUES (4, '普通用户', '普通用户', 'ROLE_NORMAL');
INSERT INTO `sys_role` VALUES (5, '老师', '老师', 'ROLE_TEACHER');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` int NOT NULL COMMENT '角色ID',
  `menu_id` int NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE,
  INDEX `menu_id`(`menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 1);
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (3, 1);
INSERT INTO `sys_role_menu` VALUES (4, 1);
INSERT INTO `sys_role_menu` VALUES (1, 4);
INSERT INTO `sys_role_menu` VALUES (1, 5);
INSERT INTO `sys_role_menu` VALUES (1, 6);
INSERT INTO `sys_role_menu` VALUES (1, 7);
INSERT INTO `sys_role_menu` VALUES (1, 8);
INSERT INTO `sys_role_menu` VALUES (1, 11);
INSERT INTO `sys_role_menu` VALUES (3, 11);
INSERT INTO `sys_role_menu` VALUES (4, 11);
INSERT INTO `sys_role_menu` VALUES (1, 12);
INSERT INTO `sys_role_menu` VALUES (4, 12);
INSERT INTO `sys_role_menu` VALUES (1, 13);
INSERT INTO `sys_role_menu` VALUES (1, 14);
INSERT INTO `sys_role_menu` VALUES (4, 14);
INSERT INTO `sys_role_menu` VALUES (1, 15);
INSERT INTO `sys_role_menu` VALUES (4, 15);
INSERT INTO `sys_role_menu` VALUES (1, 16);
INSERT INTO `sys_role_menu` VALUES (4, 16);
INSERT INTO `sys_role_menu` VALUES (1, 17);
INSERT INTO `sys_role_menu` VALUES (4, 17);
INSERT INTO `sys_role_menu` VALUES (1, 18);
INSERT INTO `sys_role_menu` VALUES (4, 18);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '密码',
  `nickname` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `email` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `address` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '地址',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '角色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4765 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '464fa6d27101895f8e9b5ecf70a2f4d1', '管理员', '2740860037@qq.com', '18773283353', '湖南郴州', '2023-01-05 14:06:35', 'https://hechao.online:8181/file/4e8bb20125a646e89d6c56bf9df26297.jpg', 'ROLE_ADMIN');
INSERT INTO `sys_user` VALUES (4756, 'dreamland', 'e10adc3949ba59abbe56e057f20f883e', 'dreamland', NULL, NULL, NULL, '2023-02-15 16:13:06', NULL, 'ROLE_NORMAL');
INSERT INTO `sys_user` VALUES (4757, 'xiaowang', '0c8c4eeb19abc6c501b59287ba5ae9e4', 'xiaowang', NULL, NULL, NULL, '2023-03-19 13:12:50', NULL, 'ROLE_NORMAL');
INSERT INTO `sys_user` VALUES (4758, 'xiaochao', 'cd59c8062c208995834447b8625afb74', 'xiaochao', NULL, NULL, NULL, '2023-03-19 13:14:10', 'https://hechao.online:8181/file/124953ee4e0c4d4db42e5b55b2e8fc4f.jpg', 'ROLE_NORMAL');
INSERT INTO `sys_user` VALUES (4759, 'test123', 'cc03e747a6afbbcbf8be7668acfebee5', 'test123', NULL, NULL, NULL, '2023-03-24 14:36:38', NULL, 'ROLE_NORMAL');
INSERT INTO `sys_user` VALUES (4760, 'test123', 'cc03e747a6afbbcbf8be7668acfebee5', 'test123', NULL, NULL, NULL, '2023-03-24 14:36:38', NULL, 'ROLE_NORMAL');
INSERT INTO `sys_user` VALUES (4761, 'test123', 'cc03e747a6afbbcbf8be7668acfebee5', 'test123', NULL, NULL, NULL, '2023-03-24 14:36:38', NULL, 'ROLE_NORMAL');
INSERT INTO `sys_user` VALUES (4762, 'test123', 'cc03e747a6afbbcbf8be7668acfebee5', 'test123', NULL, NULL, NULL, '2023-03-24 14:36:38', NULL, 'ROLE_NORMAL');
INSERT INTO `sys_user` VALUES (4763, 'test123', 'cc03e747a6afbbcbf8be7668acfebee5', 'test123', NULL, NULL, NULL, '2023-03-24 14:36:38', NULL, 'ROLE_NORMAL');
INSERT INTO `sys_user` VALUES (4764, 'test321', 'ee53d4213c897ad632bb8d824762f918', 'test321', NULL, NULL, NULL, '2023-03-24 14:37:13', NULL, 'ROLE_NORMAL');

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `content` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '内容',
  `user_id` int NULL DEFAULT NULL COMMENT '评论人ID',
  `time` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '评论时间',
  `pid` int NULL DEFAULT NULL COMMENT '父ID',
  `origin_id` int NULL DEFAULT NULL COMMENT '最上级ID',
  `article_id` int NULL DEFAULT NULL COMMENT '关联文章的ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES (4, '测试测试测试评论\n', 1, '2022-10-03 16:58:14', NULL, NULL, 1);
INSERT INTO `t_comment` VALUES (7, '6666', 1, '2022-10-03 18:22:16', 5, 5, 1);
INSERT INTO `t_comment` VALUES (8, '5555', 1, '2022-10-03 18:24:50', 4, 4, 1);
INSERT INTO `t_comment` VALUES (9, '4444', 1, '2022-10-03 18:24:55', 8, 8, 1);
INSERT INTO `t_comment` VALUES (11, '1111', 1, '2022-10-03 22:20:05', 8, 4, 1);
INSERT INTO `t_comment` VALUES (12, '1111', 1, '2022-10-03 22:20:09', 4, 4, 1);
INSERT INTO `t_comment` VALUES (14, '何超6666', 33, '2022-10-03 22:36:29', NULL, NULL, 1);
INSERT INTO `t_comment` VALUES (15, '7777', 33, '2022-10-03 22:38:54', 14, 14, 1);

SET FOREIGN_KEY_CHECKS = 1;
