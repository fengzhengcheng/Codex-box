# AIHub Pro - AI工具导航 + 提示词社区

> 一站式 AI 工具发现平台 & 高质量提示词共享社区

## 项目简介

AIHub Pro 是一个现代化的 AI 工具导航网站和提示词社区，帮助用户发现最佳 AI 工具、学习高质量提示词、了解 AI 模型对比。

### 核心功能

- **AI 工具导航** - 收录 14+ 主流 AI 工具（ChatGPT、Claude、Gemini、DeepSeek 等）
- **提示词社区** - 10+ 专业提示词模板（生图、PPT、前端、后端、论文等）
- **模型对比** - GPT-4o、Claude、Gemini、DeepSeek 等 7 大模型全面对比
- **教程文章** - AI 工具使用指南和部署教程
- **用户系统** - 注册登录、个人收藏
- **管理后台** - 完整的 CRUD 管理功能

## 技术栈

| 层级 | 技术 | 版本 |
|------|------|------|
| 前端 | Vue 3 + Vite | ^3.4 / ^5.x |
| UI框架 | Element Plus | ^2.6 |
| 路由 | Vue Router 4 | ^4.3 |
| 状态管理 | Pinia | ^2.1 |
| HTTP客户端 | Axios | ^1.6 |
| 后端 | Spring Boot 3 | 3.2.x |
| ORM | MyBatis Plus | 3.5.x |
| 数据库 | MySQL | 8.0 |
| 部署 | Zeabur / GitHub | - |

## 项目结构

```
aihub-pro/
├── frontend/                  # Vue3 前端项目
│   ├── src/
│   │   ├── api/              # API 接口封装
│   │   ├── assets/           # 静态资源
│   │   ├── components/       # 公共组件 (9个)
│   │   ├── router/           # 路由配置
│   │   ├── store/            # Pinia 状态管理
│   │   └── views/            # 页面视图
│   │       ├── admin/        # 管理后台页面 (7个)
│   │       └── *.vue         # 用户端页面 (11个)
│   ├── package.json
│   ├── vite.config.js
│   └── .env.development      # 开发环境变量
├── backend/                   # Spring Boot 后端项目
│   ├── pom.xml
│   └── src/main/
│       ├── java/com/aihub/
│       │   ├── config/       # 配置类 (CORS/MyBatisPlus)
│       │   ├── common/       # 公共类 (Result/异常处理)
│       │   ├── controller/   # 控制器 (8个)
│       │   ├── dto/          # 数据传输对象
│       │   ├── entity/       # 实体类 (9个)
│       │   ├── mapper/       # Mapper接口 (9个)
│       │   └── service/      # 服务层 (9个接口+9个实现)
│       └── resources/
│           └── application.yml
├── database/
│   ├── schema.sql            # 数据库建表语句
│   └── data.sql              # 初始化数据
├── README.md                 # 本文件
└── zeabur-deploy.md          # Zeabur 部署指南
```

## 本地运行步骤

### 前置要求

- JDK 17+
- Node.js 18+
- MySQL 8.0+
- IntelliJ IDEA
- Navicat Premium Lite（或其他 MySQL 客户端）

### 第一步：创建数据库

1. 打开 **Navicat Premium Lite**
2. 新建连接（如已有可跳过）：
   - 主机：`localhost`
   - 端口：`3306`
   - 用户名：`root`
   - 密码：`123456`
3. 新建数据库，名称：`aihub_pro`
4. 字符集选择：`utf8mb4`
5. 双击打开数据库

6. 新建查询，执行 `database/schema.sql`（建表）
7. 再新建查询，执行 `database/data.sql`（导入数据）

或者使用命令行：
```bash
mysql -u root -p123456 < database/schema.sql
mysql -u root -p123456 aihub_pro < database/data.sql
```

### 第二步：启动后端

1. 打开 **IntelliJ IDEA**
2. 点击 **File → Open**，选择 `backend` 目录
3. 等待 Maven 自动下载依赖（右下角进度条）
4. 检查数据库配置：打开 `src/main/resources/application.yml`
5. 确认数据库连接信息正确：
   ```yaml
   spring:
     datasource:
       url: jdbc:mysql://localhost:3306/aihub_pro?...
       username: root
       password: 123456
   ```
6. 找到启动类：`AihubProApplication.java`
7. 右键 → **Run 'AihubProApplication'**
8. 看到控制台输出 `Started AihubProApplication` 表示启动成功
9. 后端访问地址：http://localhost:8080

### 第三步：启动前端

1. 打开终端（PowerShell 或 CMD）
2. 进入前端目录：
   ```bash
   cd frontend
   ```
3. 安装依赖：
   ```bash
   npm install
   ```
4. 启动开发服务器：
   ```bash
   npm run dev
   ```
5. 看到 `Local: http://localhost:5173/` 表示启动成功
6. 浏览器访问：http://localhost:5173

### 默认账号

| 角色 | 用户名 | 密码 |
|------|--------|------|
| 管理员 | admin | 123456 |
| 普通用户 | test | 123456 |

## 页面路由说明

### 用户端

| 路径 | 页面 | 说明 |
|------|------|------|
| `/` | 首页 | Hero区域 + 热门推荐 + 分类入口 |
| `/tools` | AI工具导航 | 工具卡片列表 + 搜索筛选 |
| `/tools/:id` | 工具详情 | 工具详细信息 + 收藏 |
| `/prompts` | 提示词库 | 提示词卡片列表 |
| `/prompts/:id` | 提示词详情 | 提示词内容 + 一键复制 |
| `/models` | 模型对比 | AI模型全面对比 |
| `/articles` | 教程文章 | 文章列表 |
| `/articles/:id` | 文章详情 | 文章正文内容 |
| `/login` | 登录 | 用户/管理员登录 |
| `/register` | 注册 | 新用户注册 |
| `/favorites` | 我的收藏 | 收藏的工具和提示词 |

### 管理后台

| 路径 | 页面 | 功能 |
|------|------|------|
| `/admin/dashboard` | 仪表盘 | 数据统计概览 |
| `/admin/tools` | 工具管理 | 工具增删改查 |
| `/admin/prompts` | 提示词管理 | 提示词增删改查 |
| `/admin/categories` | 分类管理 | 工具/提示词分类管理 |
| `/admin/users` | 用户管理 | 用户启用/禁用/删除 |
| `/admin/articles` | 文章管理 | 文章增删改查 |
| `/admin/banners` | 轮播图管理 | 轮播图增删改查 |

## 接口文档

所有接口基础路径：`/api`

### 用户相关
- `POST /api/user/register` - 用户注册
- `POST /api/user/login` - 用户登录
- `GET /api/user/profile` - 获取个人信息
- `GET /api/user/favorites` - 获取收藏列表
- `POST /api/user/favorite` - 添加收藏
- `DELETE /api/user/favorite/{id}` - 取消收藏

### 管理员相关
- `POST /api/admin/login` - 管理员登录
- `GET /api/admin/statistics` - 统计数据

### AI工具
- `GET /api/tools` - 工具列表（支持 categoryId, keyword, page, size）
- `GET /api/tools/{id}` - 工具详情
- `POST /api/admin/tools` - 新增工具
- `PUT /api/admin/tools/{id}` - 编辑工具
- `DELETE /api/admin/tools/{id}` - 删除工具

### 其他模块
- 工具分类、提示词、提示词分类、文章、轮播图、用户管理
- 均遵循 RESTful 规范，详见 Controller 代码

### 统一返回格式

成功：
```json
{
  "code": 200,
  "message": "success",
  "data": {}
}
```

失败：
```json
{
  "code": 500,
  "message": "错误原因",
  "data": null
}
```

## 常见问题

### Q1: 后端启动报错 "Table doesn't exist"
**原因**：数据库表未创建
**解决**：先在 Navicat 中执行 `database/schema.sql`

### Q2: 前端页面空白
**原因**：
1. 后端未启动
2. 前端依赖未安装完整
**解决**：
1. 确认后端控制台无报错
2. 执行 `npm install` 重装依赖
3. 检查浏览器 F12 控制台错误信息

### Q3: 接口返回 404
**原因**：后端未启动或端口不对
**解决**：
1. 确认后端运行在 8080 端口
2. 检查 `.env.development` 中 VITE_API_BASE_URL 是否为 `http://localhost:8080/api`

### Q4: 跨域错误 (CORS)
**原因**：前后端跨域问题
**解决**：后端已配置 CORS 允许所有来源，检查是否被浏览器缓存，尝试 Ctrl+F5 强制刷新

### Q5: 数据库连接失败
**原因**：MySQL 未启动或密码错误
**解决**：
1. 确认 MySQL 服务已启动
2. 检查 `application.yml` 中的数据库密码是否正确（默认 root/123456）

### Q6: Maven 依赖下载慢
**解决**：配置阿里云镜像仓库，在 `pom.xml` 同目录创建 `settings.xml` 或修改 Maven 全局配置

### Q7: npm install 失败
**解决**：
1. 切换淘宝镜像：`npm config set registry https://registry.npmmirror.com`
2. 删除 `node_modules` 和 `package-lock.json` 后重新安装

## Zeabur 部署

详细的 Zeabur 部署步骤请查看 [zeabur-deploy.md](./zeabur-deploy.md)

## License

MIT License
