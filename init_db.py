#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
晴雨通天气管理系统 - 数据库初始化脚本
自动创建数据库、8张表、初始化数据
连接参数: host=localhost, port=3306, user=root, password=123456
"""

import pymysql
import sys
from datetime import datetime, timedelta

# =============================================
# 数据库连接配置
# =============================================
DB_CONFIG = {
    "host": "localhost",
    "port": 3306,
    "user": "root",
    "password": "123456",
    "charset": "utf8mb4",
}

DB_NAME = "weather_db"

# =============================================
# 建表 SQL（无依赖 -> 有依赖依次创建）
# =============================================
CREATE_TABLES_SQL = {
    "sys_role": """
    CREATE TABLE IF NOT EXISTS sys_role (
        id BIGINT AUTO_INCREMENT PRIMARY KEY,
        role_code VARCHAR(50) NOT NULL UNIQUE COMMENT '角色编码',
        role_name VARCHAR(50) NOT NULL COMMENT '角色名称',
        role_desc VARCHAR(200) COMMENT '角色描述',
        create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统角色表';
    """,

    "sys_permission": """
    CREATE TABLE IF NOT EXISTS sys_permission (
        id BIGINT AUTO_INCREMENT PRIMARY KEY,
        permission_code VARCHAR(50) NOT NULL UNIQUE COMMENT '权限编码',
        permission_name VARCHAR(50) NOT NULL COMMENT '权限名称',
        permission_path VARCHAR(200) COMMENT '权限路径',
        permission_type VARCHAR(20) COMMENT '权限类型: 菜单/按钮',
        parent_id BIGINT COMMENT '父权限ID',
        create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统权限表';
    """,

    "sys_role_permission": """
    CREATE TABLE IF NOT EXISTS sys_role_permission (
        id BIGINT AUTO_INCREMENT PRIMARY KEY,
        role_id BIGINT NOT NULL COMMENT '关联角色ID',
        permission_id BIGINT NOT NULL COMMENT '关联权限ID',
        create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        FOREIGN KEY (role_id) REFERENCES sys_role(id) ON DELETE CASCADE,
        FOREIGN KEY (permission_id) REFERENCES sys_permission(id) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色权限关联表';
    """,

    "sys_user": """
    CREATE TABLE IF NOT EXISTS sys_user (
        id BIGINT AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(50) NOT NULL UNIQUE COMMENT '登录账号',
        password VARCHAR(100) NOT NULL COMMENT '登录密码',
        phone VARCHAR(11) UNIQUE COMMENT '手机号',
        role VARCHAR(20) NOT NULL COMMENT '角色: user-普通用户, admin-管理员',
        avatar VARCHAR(255) DEFAULT '/static/images/default-avatar.png' COMMENT '头像路径',
        status VARCHAR(20) DEFAULT '正常' COMMENT '状态: 正常/禁用',
        create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';
    """,

    "city_weather": """
    CREATE TABLE IF NOT EXISTS city_weather (
        id BIGINT AUTO_INCREMENT PRIMARY KEY,
        city_name VARCHAR(50) NOT NULL UNIQUE COMMENT '城市名称',
        temperature DECIMAL(5,2) COMMENT '温度(℃)',
        weather_desc VARCHAR(30) COMMENT '天气状况: 晴/多云/小雨等',
        wind VARCHAR(30) COMMENT '风向风力: 东北风 2级等',
        humidity DECIMAL(5,2) COMMENT '湿度(%)',
        air_quality VARCHAR(20) COMMENT '空气质量: 优/良/轻度污染等',
        update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间'
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='城市天气表';
    """,

    "user_favorite": """
    CREATE TABLE IF NOT EXISTS user_favorite (
        id BIGINT AUTO_INCREMENT PRIMARY KEY,
        user_id BIGINT NOT NULL UNIQUE COMMENT '关联用户ID',
        favorite_cities VARCHAR(500) COMMENT '收藏城市列表，逗号分隔',
        create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
        FOREIGN KEY (user_id) REFERENCES sys_user(id) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户收藏表';
    """,

    "weather_alert": """
    CREATE TABLE IF NOT EXISTS weather_alert (
        id BIGINT AUTO_INCREMENT PRIMARY KEY,
        city_id BIGINT NOT NULL COMMENT '关联城市ID',
        alert_type VARCHAR(30) COMMENT '预警类型: 暴雨/大风/高温/寒潮',
        alert_level VARCHAR(20) COMMENT '预警等级: 蓝色/黄色/橙色/红色',
        publish_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
        effective_time DATETIME COMMENT '生效时间',
        FOREIGN KEY (city_id) REFERENCES city_weather(id) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='天气预警表';
    """,

    "user_operation_log": """
    CREATE TABLE IF NOT EXISTS user_operation_log (
        id BIGINT AUTO_INCREMENT PRIMARY KEY,
        user_id BIGINT NOT NULL COMMENT '关联用户ID',
        operation_content VARCHAR(100) COMMENT '操作内容: 登录系统/查询天气等',
        operation_ip VARCHAR(50) COMMENT '操作IP地址',
        operation_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
        FOREIGN KEY (user_id) REFERENCES sys_user(id) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户操作日志表';
    """,
}

# =============================================
# 初始化数据
# =============================================
INIT_DATA = {
    "sys_role": [
        ("admin", "管理员", "系统管理员，拥有所有权限"),
        ("user", "普通用户", "普通用户，仅有查询权限"),
        ("guest", "访客", "访客用户，无权限"),
        ("editor", "编辑", "内容编辑人员，可编辑天气信息"),
        ("auditor", "审核", "内容审核人员，负责审核发布内容"),
        ("operator", "运维", "系统运维人员，负责系统监控"),
        ("analyst", "分析师", "数据分析人员，查看统计报表"),
        ("viewer", "访客", "只读访客，仅可查看数据"),
        ("supermanager", "超级管理员", "拥有系统全部权限"),
    ],

    "sys_permission": [
        ("weather:query", "天气查询", "/weather/**", "菜单", None),
        ("user:manage", "用户管理", "/admin/user/**", "菜单", None),
        ("weather:manage", "天气管理", "/admin/weather/**", "菜单", None),
        ("user:edit", "用户编辑", "/user/edit/**", "按钮", None),
        ("user:delete", "用户删除", "/user/delete/**", "按钮", None),
        ("weather:add", "天气添加", "/weather/add/**", "按钮", None),
        ("weather:delete", "天气删除", "/weather/delete/**", "按钮", None),
        ("weather:edit", "天气编辑", "/weather/edit/**", "按钮", None),
        ("log:view", "日志查看", "/log/**", "菜单", None),
        ("alert:manage", "预警管理", "/alert/**", "菜单", None),
        ("report:view", "报表查看", "/report/**", "菜单", None),
    ],

    "sys_role_permission": [
        (1, 1), (1, 2), (1, 3),
        (2, 1),
        (4, 1), (4, 2), (4, 3), (4, 4), (4, 5),
        (5, 6),
        (6, 7),
        (7, 1), (7, 3), (7, 6),
        (8, 8),
        (9, 6), (9, 8),
    ],

    "sys_user": [
        ("admin", "123456", "13800138000", "admin"),
        ("user01", "123456", "13900139000", "user"),
        ("user02", "123456", "13700137000", "user"),
        ("user03", "123456", "13512340001", "user"),
        ("user04", "123456", "13612340002", "user"),
        ("user05", "123456", "13712340003", "user"),
        ("user06", "123456", "13812340004", "user"),
        ("user07", "123456", "13912340005", "user"),
        ("user08", "123456", "15012340006", "user"),
        ("user09", "123456", "15112340007", "user"),
        ("user10", "123456", "15212340008", "user"),
        ("user11", "123456", "15312340009", "user"),
        ("user12", "123456", "15412340010", "user"),
    ],

    "city_weather": [
        ("成都", 18.50, "多云", "东北风 2级", 65.00, "良"),
        ("北京", 12.30, "晴", "西北风 3级", 45.00, "优"),
        ("上海", 20.80, "小雨", "东南风 4级", 78.00, "良"),
        ("广州", 28.50, "晴", "南风 2级", 75.00, "良"),
        ("深圳", 27.30, "晴", "南风 2级", 72.00, "良"),
        ("重庆", 22.10, "阴", "东北风 1级", 78.00, "轻度污染"),
        ("武汉", 19.20, "多云", "东南风 2级", 62.00, "良"),
        ("西安", 15.60, "晴", "东北风 2级", 48.00, "良"),
        ("杭州", 21.30, "多云", "东风 2级", 70.00, "良"),
        ("南京", 18.90, "阴", "东风 3级", 73.00, "良"),
        ("天津", 14.20, "晴", "西北风 2级", 42.00, "优"),
        ("苏州", 20.50, "多云", "东南风 2级", 69.00, "良"),
        ("郑州", 16.80, "晴", "南风 2级", 55.00, "良"),
        ("长沙", 22.70, "小雨", "北风 2级", 80.00, "良"),
        ("沈阳", 8.30, "晴", "西南风 3级", 50.00, "优"),
        ("青岛", 15.40, "多云", "东南风 3级", 68.00, "良"),
        ("济南", 17.20, "晴", "南风 2级", 52.00, "良"),
        ("大连", 11.60, "晴", "西风 3级", 55.00, "优"),
        ("哈尔滨", 2.50, "小雪", "西北风 4级", 65.00, "良"),
        ("长春", 5.80, "多云", "西风 3级", 58.00, "良"),
    ],

    "user_favorite": [
        (1, "北京,上海,成都"),
        (2, "成都,上海"),
        (3, "上海"),
        (4, "广州,深圳,成都"),
        (5, "深圳,上海,北京"),
        (6, "重庆,成都,昆明"),
        (7, "武汉,长沙,南昌"),
        (8, "西安,兰州,乌鲁木齐"),
        (9, "杭州,苏州,南京"),
        (10, "天津,青岛,济南"),
        (11, "沈阳,大连,哈尔滨"),
        (12, "广州,深圳,珠海"),
    ],

    "weather_alert": [
        (2, "大风", "黄色"),
        (1, "暴雨", "橙色"),
        (3, "高温", "红色"),
        (4, "暴雨", "橙色"),
        (6, "高温", "黄色"),
        (10, "大风", "蓝色"),
        (13, "寒潮", "橙色"),
        (15, "暴雪", "黄色"),
        (19, "雷电", "橙色"),
        (1, "大雾", "黄色"),
        (5, "干旱", "蓝色"),
        (7, "沙尘暴", "橙色"),
        (11, "霜冻", "蓝色"),
        (8, "台风", "红色"),
        (12, "冰雹", "橙色"),
    ],

    "user_operation_log": [
        (1, "登录系统", "127.0.0.1"),
        (2, "查询北京天气", "127.0.0.2"),
        (3, "用户注册", "127.0.0.3"),
        (4, "登录系统", "192.168.1.101"),
        (4, "查询广州天气", "192.168.1.101"),
        (5, "登录系统", "192.168.1.102"),
        (5, "查询深圳天气", "192.168.1.102"),
        (6, "登录系统", "192.168.1.103"),
        (6, "修改个人信息", "192.168.1.103"),
        (7, "登录系统", "192.168.1.104"),
        (7, "查询重庆天气", "192.168.1.104"),
        (8, "登录系统", "192.168.1.105"),
        (8, "查询武汉天气", "192.168.1.105"),
        (9, "登录系统", "192.168.1.106"),
        (9, "查询西安天气", "192.168.1.106"),
        (10, "登录系统", "192.168.1.107"),
        (10, "查询杭州天气", "192.168.1.107"),
        (11, "登录系统", "192.168.1.108"),
        (11, "查询南京天气", "192.168.1.108"),
        (12, "登录系统", "192.168.1.109"),
        (12, "查询天津天气", "192.168.1.109"),
        (1, "修改天气数据", "127.0.0.1"),
        (1, "删除预警信息", "127.0.0.1"),
        (2, "收藏城市", "127.0.0.2"),
        (3, "查询成都天气", "127.0.0.3"),
    ],
}

INSERT_SQL = {
    "sys_role": """
        INSERT INTO sys_role (role_code, role_name, role_desc, create_time)
        VALUES (%s, %s, %s, %s)
    """,
    "sys_permission": """
        INSERT INTO sys_permission
        (permission_code, permission_name, permission_path, permission_type, parent_id, create_time)
        VALUES (%s, %s, %s, %s, %s, %s)
    """,
    "sys_role_permission": """
        INSERT INTO sys_role_permission (role_id, permission_id, create_time)
        VALUES (%s, %s, %s)
    """,
    "sys_user": """
        INSERT INTO sys_user (username, password, phone, role, create_time)
        VALUES (%s, %s, %s, %s, %s)
    """,
    "city_weather": """
        INSERT INTO city_weather
        (city_name, temperature, weather_desc, wind, humidity, air_quality, update_time)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
    """,
    "user_favorite": """
        INSERT INTO user_favorite (user_id, favorite_cities, create_time)
        VALUES (%s, %s, %s)
    """,
    "weather_alert": """
        INSERT INTO weather_alert (city_id, alert_type, alert_level, publish_time, effective_time)
        VALUES (%s, %s, %s, %s, %s)
    """,
    "user_operation_log": """
        INSERT INTO user_operation_log (user_id, operation_content, operation_ip, operation_time)
        VALUES (%s, %s, %s, %s)
    """,
}


def log(msg):
    """在 GBK 环境下安全输出（含中文）"""
    print(msg)


def main():
    conn = None
    try:
        log("=" * 60)
        log("晴雨通天气管理系统 - 数据库初始化脚本")
        log("=" * 60)

        # ---- Step 1: 连接 MySQL ----
        log("\n[1/4] 正在连接 MySQL ...")
        conn = pymysql.connect(**DB_CONFIG)
        cursor = conn.cursor()
        log("    [OK] 连接成功")

        # ---- Step 2: 创建数据库 ----
        log("\n[2/4] 正在创建数据库 weather_db ...")
        cursor.execute(f"DROP DATABASE IF EXISTS {DB_NAME}")
        cursor.execute(
            f"CREATE DATABASE {DB_NAME} DEFAULT CHARACTER SET utf8mb4 "
            f"COLLATE utf8mb4_unicode_ci"
        )
        cursor.execute(f"USE {DB_NAME}")
        log("    [OK] 数据库创建成功")

        # ---- Step 3: 建表 ----
        log("\n[3/4] 正在创建 8 张数据表 ...")
        table_order = [
            "sys_role", "sys_permission", "sys_role_permission",
            "sys_user", "city_weather", "user_favorite",
            "weather_alert", "user_operation_log",
        ]
        for idx, table in enumerate(table_order, 1):
            cursor.execute(CREATE_TABLES_SQL[table])
            log(f"    [OK] {table} ({idx}/8)")

        # ---- Step 4: 插入数据 ----
        log("\n[4/4] 正在插入初始化数据 ...")
        now = datetime.now()
        base_times = {
            "sys_role": now - timedelta(days=120),
            "sys_permission": now - timedelta(days=120),
            "sys_user": now - timedelta(days=119),
            "city_weather": now,
            "user_favorite": now - timedelta(days=119),
            "weather_alert": now - timedelta(days=118),
            "user_operation_log": now - timedelta(days=119),
            "sys_role_permission": now,
        }

        for table, rows in INIT_DATA.items():
            count = 0
            for row_data in rows:
                if table == "sys_role":
                    vals = (*row_data, base_times[table])
                    cursor.execute(INSERT_SQL[table], vals)
                elif table == "sys_permission":
                    vals = (*row_data, base_times[table])
                    cursor.execute(INSERT_SQL[table], vals)
                elif table == "sys_role_permission":
                    vals = (*row_data, base_times[table])
                    cursor.execute(INSERT_SQL[table], vals)
                elif table == "sys_user":
                    vals = (*row_data, base_times[table])
                    cursor.execute(INSERT_SQL[table], vals)
                elif table == "city_weather":
                    vals = (*row_data, base_times[table])
                    cursor.execute(INSERT_SQL[table], vals)
                elif table == "user_favorite":
                    vals = (*row_data, base_times[table])
                    cursor.execute(INSERT_SQL[table], vals)
                elif table == "weather_alert":
                    publish = base_times[table] + timedelta(hours=6)
                    effective = base_times[table] + timedelta(hours=10)
                    vals = (*row_data, publish, effective)
                    cursor.execute(INSERT_SQL[table], vals)
                elif table == "user_operation_log":
                    vals = (*row_data, base_times[table])
                    base_times[table] = base_times[table] + timedelta(hours=1)
                    cursor.execute(INSERT_SQL[table], vals)
                count += 1
            conn.commit()
            log(f"    [OK] {table}: 插入 {count} 条数据")

        # ---- 完成 ----
        log("\n" + "=" * 60)
        log("  数据库初始化完成！共 8 张表，全部数据已插入。")
        log("=" * 60)
        log("\n  [INFO] 管理员账号: admin / 123456")
        log("  [INFO] 数据库名:   weather_db")
        log("  [INFO] 连接地址:   localhost:3306")

    except ImportError:
        log("\n[ERROR] 未找到 pymysql 库，请先安装:")
        log("  pip install pymysql")
        sys.exit(1)
    except pymysql.Error as e:
        log(f"\n[ERROR] MySQL 错误: {e}")
        sys.exit(1)
    except Exception as e:
        log(f"\n[ERROR] 未知错误: {e}")
        sys.exit(1)
    finally:
        if conn:
            conn.close()


if __name__ == "__main__":
    main()
