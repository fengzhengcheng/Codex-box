-- =============================================
-- 晴雨通天气管理系统 - 数据库初始化脚本
-- 数据库: weather_db
-- 编码: UTF-8
-- =============================================

DROP DATABASE IF EXISTS weather_db;
CREATE DATABASE weather_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE weather_db;

-- =============================================
-- 1. 系统角色表 sys_role (无依赖，最先创建)
-- =============================================
DROP TABLE IF EXISTS sys_role;

CREATE TABLE sys_role (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    role_code VARCHAR(50) NOT NULL UNIQUE COMMENT '角色编码',
    role_name VARCHAR(50) NOT NULL COMMENT '角色名称',
    role_desc VARCHAR(200) COMMENT '角色描述',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统角色表';

INSERT INTO sys_role (role_code, role_name, role_desc, create_time) VALUES
('admin', '管理员', '系统管理员，拥有所有权限', '2024-01-01 00:00:00'),
('user', '普通用户', '普通用户，仅有查询权限', '2024-01-01 00:00:00'),
('guest', '访客', '访客用户，无权限', '2024-01-01 00:00:00'),
('editor', '编辑', '内容编辑人员，可编辑天气信息', '2024-01-15 00:00:00'),
('auditor', '审核', '内容审核人员，负责审核发布内容', '2024-01-15 00:00:00'),
('operator', '运维', '系统运维人员，负责系统监控', '2024-01-15 00:00:00'),
('analyst', '分析师', '数据分析人员，查看统计报表', '2024-01-15 00:00:00'),
('viewer', '访客', '只读访客，仅可查看数据', '2024-01-15 00:00:00'),
('supermanager', '超级管理员', '拥有系统全部权限', '2024-01-15 00:00:00');

-- =============================================
-- 2. 系统权限表 sys_permission (无依赖)
-- =============================================
DROP TABLE IF EXISTS sys_permission;

CREATE TABLE sys_permission (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    permission_code VARCHAR(50) NOT NULL UNIQUE COMMENT '权限编码',
    permission_name VARCHAR(50) NOT NULL COMMENT '权限名称',
    permission_path VARCHAR(200) COMMENT '权限路径',
    permission_type VARCHAR(20) COMMENT '权限类型: 菜单/按钮',
    parent_id BIGINT COMMENT '父权限ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统权限表';

INSERT INTO sys_permission (permission_code, permission_name, permission_path, permission_type, parent_id, create_time) VALUES
('weather:query', '天气查询', '/weather/**', '菜单', NULL, '2024-01-01 00:00:00'),
('user:manage', '用户管理', '/admin/user/**', '菜单', NULL, '2024-01-01 00:00:00'),
('weather:manage', '天气管理', '/admin/weather/**', '菜单', NULL, '2024-01-01 00:00:00'),
('user:edit', '用户编辑', '/user/edit/**', '按钮', NULL, '2024-01-15 00:00:00'),
('user:delete', '用户删除', '/user/delete/**', '按钮', NULL, '2024-01-15 00:00:00'),
('weather:add', '天气添加', '/weather/add/**', '按钮', NULL, '2024-01-15 00:00:00'),
('weather:delete', '天气删除', '/weather/delete/**', '按钮', NULL, '2024-01-15 00:00:00'),
('weather:edit', '天气编辑', '/weather/edit/**', '按钮', NULL, '2024-01-15 00:00:00'),
('log:view', '日志查看', '/log/**', '菜单', NULL, '2024-01-15 00:00:00'),
('alert:manage', '预警管理', '/alert/**', '菜单', NULL, '2024-01-15 00:00:00'),
('report:view', '报表查看', '/report/**', '菜单', NULL, '2024-01-15 00:00:00');

-- =============================================
-- 3. 角色权限关联表 sys_role_permission (依赖sys_role和sys_permission)
-- =============================================
DROP TABLE IF EXISTS sys_role_permission;

CREATE TABLE sys_role_permission (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    role_id BIGINT NOT NULL COMMENT '关联角色ID',
    permission_id BIGINT NOT NULL COMMENT '关联权限ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (role_id) REFERENCES sys_role(id) ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES sys_permission(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色权限关联表';

INSERT INTO sys_role_permission (role_id, permission_id, create_time) VALUES
(1, 1, NOW()), (1, 2, NOW()), (1, 3, NOW()),
(2, 1, NOW()),
(4, 1, NOW()), (4, 2, NOW()), (4, 3, NOW()), (4, 4, NOW()), (4, 5, NOW()),
(5, 6, NOW()),
(6, 7, NOW()),
(7, 1, NOW()), (7, 3, NOW()), (7, 6, NOW()),
(8, 8, NOW()),
(9, 6, NOW()), (9, 8, NOW());

-- =============================================
-- 4. 用户表 sys_user (依赖sys_role)
-- =============================================
DROP TABLE IF EXISTS sys_user;

CREATE TABLE sys_user (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '登录账号',
    password VARCHAR(100) NOT NULL COMMENT '登录密码',
    phone VARCHAR(11) UNIQUE COMMENT '手机号',
    role VARCHAR(20) NOT NULL COMMENT '角色: user-普通用户, admin-管理员',
    avatar VARCHAR(255) DEFAULT '/static/images/default-avatar.png' COMMENT '头像路径',
    status VARCHAR(20) DEFAULT '正常' COMMENT '状态: 正常/禁用',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

INSERT INTO sys_user (username, password, phone, role, status, create_time) VALUES
('admin', '123456', '13800138000', 'admin', '正常', '2024-01-01 10:00:00'),
('user01', '123456', '13900139000', 'user', '正常', '2024-01-02 10:00:00'),
('user02', '123456', '13700137000', 'user', '正常', '2024-01-03 10:00:00'),
('user03', '123456', '13512340001', 'user', '正常', '2024-02-01 10:00:00'),
('user04', '123456', '13612340002', 'user', '正常', '2024-02-02 10:00:00'),
('user05', '123456', '13712340003', 'user', '正常', '2024-02-03 10:00:00'),
('user06', '123456', '13812340004', 'user', '正常', '2024-02-04 10:00:00'),
('user07', '123456', '13912340005', 'user', '正常', '2024-02-05 10:00:00'),
('user08', '123456', '15012340006', 'user', '正常', '2024-02-06 10:00:00'),
('user09', '123456', '15112340007', 'user', '正常', '2024-02-07 10:00:00'),
('user10', '123456', '15212340008', 'user', '正常', '2024-02-08 10:00:00'),
('user11', '123456', '15312340009', 'user', '正常', '2024-02-09 10:00:00'),
('user12', '123456', '15412340010', 'user', '正常', '2024-02-10 10:00:00');

-- =============================================
-- 5. 城市天气表 city_weather (无依赖)
-- =============================================
DROP TABLE IF EXISTS city_weather;

CREATE TABLE city_weather (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    city_name VARCHAR(50) NOT NULL UNIQUE COMMENT '城市名称',
    temperature DECIMAL(5,2) COMMENT '温度(℃)',
    weather_desc VARCHAR(30) COMMENT '天气状况: 晴、多云、小雨等',
    wind VARCHAR(30) COMMENT '风向风力: 东北风 2级等',
    humidity DECIMAL(5,2) COMMENT '湿度(%)',
    air_quality VARCHAR(20) COMMENT '空气质量: 优、良、轻度污染等',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='城市天气表';

INSERT INTO city_weather (city_name, temperature, weather_desc, wind, humidity, air_quality, update_time) VALUES
('成都', 18.50, '多云', '东北风 2级', 65.00, '良', '2024-01-01 08:00:00'),
('北京', 12.30, '晴', '西北风 3级', 45.00, '优', '2024-01-01 08:00:00'),
('上海', 20.80, '小雨', '东南风 4级', 78.00, '良', '2024-01-01 08:00:00'),
('广州', 28.50, '晴', '南风 2级', 75.00, '良', NOW()),
('深圳', 27.30, '晴', '南风 2级', 72.00, '良', NOW()),
('重庆', 22.10, '阴', '东北风 1级', 78.00, '轻度污染', NOW()),
('武汉', 19.20, '多云', '东南风 2级', 62.00, '良', NOW()),
('西安', 15.60, '晴', '东北风 2级', 48.00, '良', NOW()),
('杭州', 21.30, '多云', '东风 2级', 70.00, '良', NOW()),
('南京', 18.90, '阴', '东风 3级', 73.00, '良', NOW()),
('天津', 14.20, '晴', '西北风 2级', 42.00, '优', NOW()),
('苏州', 20.50, '多云', '东南风 2级', 69.00, '良', NOW()),
('郑州', 16.80, '晴', '南风 2级', 55.00, '良', NOW()),
('长沙', 22.70, '小雨', '北风 2级', 80.00, '良', NOW()),
('沈阳', 8.30, '晴', '西南风 3级', 50.00, '优', NOW()),
('青岛', 15.40, '多云', '东南风 3级', 68.00, '良', NOW()),
('济南', 17.20, '晴', '南风 2级', 52.00, '良', NOW()),
('大连', 11.60, '晴', '西风 3级', 55.00, '优', NOW()),
('哈尔滨', 2.50, '小雪', '西北风 4级', 65.00, '良', NOW()),
('长春', 5.80, '多云', '西风 3级', 58.00, '良', NOW()),
('昆明', 22.40, '晴', '西南风 2级', 55.00, '优', NOW()),
('贵阳', 17.90, '阴', '北风 1级', 82.00, '良', NOW()),
('南宁', 26.30, '晴', '东南风 2级', 70.00, '良', NOW()),
('福州', 24.50, '多云', '东风 2级', 72.00, '良', NOW()),
('厦门', 25.80, '晴', '东南风 2级', 68.00, '良', NOW()),
('海口', 29.10, '晴', '东南风 2级', 78.00, '良', NOW()),
('太原', 13.50, '晴', '东北风 2级', 45.00, '良', NOW()),
('石家庄', 16.20, '晴', '南风 2级', 50.00, '良', NOW()),
('兰州', 11.30, '多云', '东北风 2级', 55.00, '良', NOW()),
('呼和浩特', 7.80, '晴', '西风 3级', 42.00, '优', NOW()),
('乌鲁木齐', 5.20, '多云', '西北风 2级', 60.00, '良', NOW()),
('银川', 12.70, '晴', '北风 2级', 48.00, '良', NOW()),
('西宁', 8.40, '多云', '西北风 2级', 52.00, '良', NOW()),
('拉萨', 15.60, '晴', '西南风 2级', 35.00, '优', NOW()),
('香港', 26.90, '晴', '东风 2级', 75.00, '良', NOW()),
('澳门', 27.20, '晴', '东南风 2级', 76.00, '良', NOW()),
('台北', 25.30, '多云', '东风 3级', 80.00, '良', NOW()),
('南昌', 21.80, '多云', '北风 2级', 68.00, '良', NOW()),
('合肥', 18.30, '阴', '东风 2级', 72.00, '良', NOW());

-- =============================================
-- 6. 用户收藏表 user_favorite (依赖sys_user)
-- =============================================
DROP TABLE IF EXISTS user_favorite;

CREATE TABLE user_favorite (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    user_id BIGINT NOT NULL UNIQUE COMMENT '关联用户ID',
    favorite_cities VARCHAR(500) COMMENT '收藏城市列表，逗号分隔',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (user_id) REFERENCES sys_user(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户收藏表';

INSERT INTO user_favorite (user_id, favorite_cities, create_time) VALUES
(1, '北京,上海,成都', '2024-01-01 10:00:00'),
(2, '成都,上海', '2024-01-02 10:00:00'),
(3, '上海', '2024-01-03 10:00:00'),
(4, '广州,深圳,成都', '2024-02-01 08:40:00'),
(5, '深圳,上海,北京', '2024-02-02 09:15:00'),
(6, '重庆,成都,昆明', '2024-02-03 10:35:00'),
(7, '武汉,长沙,南昌', '2024-02-04 11:20:00'),
(8, '西安,兰州,乌鲁木齐', '2024-02-05 08:25:00'),
(9, '杭州,苏州,南京', '2024-02-06 14:15:00'),
(10, '天津,青岛,济南', '2024-02-07 09:35:00'),
(11, '沈阳,大连,哈尔滨', '2024-02-08 10:25:00'),
(12, '广州,深圳,珠海', '2024-02-09 08:35:00');

-- =============================================
-- 7. 天气预警表 weather_alert (依赖city_weather)
-- =============================================
DROP TABLE IF EXISTS weather_alert;

CREATE TABLE weather_alert (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    city_id BIGINT NOT NULL COMMENT '关联城市ID',
    alert_type VARCHAR(30) COMMENT '预警类型: 暴雨/大风/高温/寒潮',
    alert_level VARCHAR(20) COMMENT '预警等级: 蓝色/黄色/橙色/红色',
    publish_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
    effective_time DATETIME COMMENT '生效时间',
    FOREIGN KEY (city_id) REFERENCES city_weather(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='天气预警表';

INSERT INTO weather_alert (city_id, alert_type, alert_level, publish_time, effective_time) VALUES
(2, '大风', '黄色', '2024-01-01 06:00:00', '2024-01-01 10:00:00'),
(1, '暴雨', '橙色', '2024-01-02 06:00:00', '2024-01-02 10:00:00'),
(3, '高温', '红色', '2024-01-03 06:00:00', '2024-01-03 10:00:00'),
(4, '暴雨', '橙色', '2024-02-01 06:00:00', '2024-02-01 10:00:00'),
(6, '高温', '黄色', '2024-02-02 08:00:00', '2024-02-02 12:00:00'),
(10, '大风', '蓝色', '2024-02-03 05:00:00', '2024-02-03 08:00:00'),
(13, '寒潮', '橙色', '2024-02-04 06:00:00', '2024-02-04 10:00:00'),
(15, '暴雪', '黄色', '2024-02-05 07:00:00', '2024-02-05 11:00:00'),
(19, '雷电', '橙色', '2024-02-06 14:00:00', '2024-02-06 18:00:00'),
(21, '大雾', '黄色', '2024-02-07 06:00:00', '2024-02-07 09:00:00'),
(23, '干旱', '蓝色', '2024-02-08 08:00:00', '2024-02-08 12:00:00'),
(27, '沙尘暴', '橙色', '2024-02-09 10:00:00', '2024-02-09 14:00:00'),
(30, '霜冻', '蓝色', '2024-02-10 05:00:00', '2024-02-10 08:00:00'),
(5, '台风', '红色', '2024-02-11 06:00:00', '2024-02-11 10:00:00'),
(12, '冰雹', '橙色', '2024-02-12 07:00:00', '2024-02-12 11:00:00');

-- =============================================
-- 8. 用户操作日志表 user_operation_log (依赖sys_user)
-- =============================================
DROP TABLE IF EXISTS user_operation_log;

CREATE TABLE user_operation_log (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    user_id BIGINT NOT NULL COMMENT '关联用户ID',
    operation_content VARCHAR(100) COMMENT '操作内容: 登录系统、查询天气等',
    operation_ip VARCHAR(50) COMMENT '操作IP地址',
    operation_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
    FOREIGN KEY (user_id) REFERENCES sys_user(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户操作日志表';

INSERT INTO user_operation_log (user_id, operation_content, operation_ip, operation_time) VALUES
(1, '登录系统', '127.0.0.1', '2024-01-01 10:00:00'),
(2, '查询北京天气', '127.0.0.2', '2024-01-02 11:00:00'),
(3, '用户注册', '127.0.0.3', '2024-01-03 12:00:00'),
(4, '登录系统', '192.168.1.101', '2024-02-01 08:30:00'),
(4, '查询广州天气', '192.168.1.101', '2024-02-01 08:35:00'),
(5, '登录系统', '192.168.1.102', '2024-02-02 09:00:00'),
(5, '查询深圳天气', '192.168.1.102', '2024-02-02 09:10:00'),
(6, '登录系统', '192.168.1.103', '2024-02-03 10:00:00'),
(6, '修改个人信息', '192.168.1.103', '2024-02-03 10:30:00'),
(7, '登录系统', '192.168.1.104', '2024-02-04 11:00:00'),
(7, '查询重庆天气', '192.168.1.104', '2024-02-04 11:15:00'),
(8, '登录系统', '192.168.1.105', '2024-02-05 08:00:00'),
(8, '查询武汉天气', '192.168.1.105', '2024-02-05 08:20:00'),
(9, '登录系统', '192.168.1.106', '2024-02-06 14:00:00'),
(9, '查询西安天气', '192.168.1.106', '2024-02-06 14:10:00'),
(10, '登录系统', '192.168.1.107', '2024-02-07 09:00:00'),
(10, '查询杭州天气', '192.168.1.107', '2024-02-07 09:30:00'),
(11, '登录系统', '192.168.1.108', '2024-02-08 10:00:00'),
(11, '查询南京天气', '192.168.1.108', '2024-02-08 10:20:00'),
(12, '登录系统', '192.168.1.109', '2024-02-09 08:00:00'),
(12, '查询天津天气', '192.168.1.109', '2024-02-09 08:30:00'),
(1, '修改天气数据', '127.0.0.1', '2024-02-10 09:00:00'),
(1, '删除预警信息', '127.0.0.1', '2024-02-10 10:00:00'),
(2, '收藏城市', '127.0.0.2', '2024-02-10 11:00:00'),
(3, '查询成都天气', '127.0.0.3', '2024-02-10 12:00:00');

-- =============================================
-- 执行成功标记
-- =============================================
SELECT 'SQL执行完成，所有表创建成功！' AS result;
