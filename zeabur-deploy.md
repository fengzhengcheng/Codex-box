# AIHub Pro - Zeabur 部署指南

> 将 AIHub Pro 一键部署到 Zeabur 云平台，实现公网访问

## 目录

1. [准备工作](#1-准备工作)
2. [上传 GitHub](#2-上传-github)
3. [Zeabur 创建项目](#3-zeabur-创建项目)
4. [添加 MySQL 服务](#4-添加-mysql-服务)
5. [部署后端](#5-部署后端)
6. [部署前端](#6-部署前端)
7. [配置环境变量](#7-配置环境变量)
8. [导入数据库](#8-导入数据库)
9. [绑定域名（可选）](#9-绑定域名可选)
10. [故障排查](#10-故障排查)

---

## 1. 准备工作

确保你已完成以下准备：

- [x] GitHub 账号（用于代码托管）
- [x] Zeabur 账号（可通过 GitHub 登录）
- [x] 本地项目已测试通过
- [x] 已安装 Git

---

## 2. 上传 GitHub

### 2.1 初始化 Git 仓库

在项目根目录 `aihub-pro/` 下打开终端：

```bash
git init
git add .
git commit -m "feat: AIHub Pro initial commit"
```

### 2.2 推送到 GitHub

```bash
# 在 GitHub 上新建仓库 aihub-pro（不要勾选 README、.gitignore）
git remote add origin https://github.com/fengzhengcheng/Codex-box.git
git branch -M main
git push -u origin main
```

> 如果推送时提示需要认证，按提示输入 GitHub 用户名和 Personal Access Token。

### 2.3 推荐的 .gitignore

项目根目录已包含或建议添加：

```gitignore
# IDE
.idea/
*.iml
.vscode/

# Java
target/
*.class
*.jar
*.war
*.log

# Node
node_modules/
dist/
.cache/

# OS
.DS_Store
Thumbs.db

# Env
*.local
```

---

## 3. Zeabur 创建项目

### 3.1 访问 Zeabur

1. 打开浏览器访问 [https://zeabur.com](https://zeabur.com)
2. 使用 **GitHub 账号登录**
3. 登录后进入 Dashboard

### 3.2 创建新 Project

1. 点击 **「+ New Project」** 或 **「创建新项目」**
2. 输入项目名称：`aihub-pro`
3. 选择区域（推荐选择离你近的区域，如 Hong Kong 或 AWS US East）

---

## 4. 添加 MySQL 服务

Zeabur 提供托管 MySQL，无需自建。

### 4.1 添加服务

1. 在项目中点击 **「+ Service」** 或 **「添加服务」**
2. 搜索 **「MySQL」** 或选择 Database 类别中的 MySQL
3. 选择官方 MySQL 服务（通常由 Zeabur 或 Bitnami 提供）
4. 点击 **Deploy**

### 4.2 获取 MySQL 连接信息

MySQL 服务部署完成后：

1. 点击进入 MySQL 服务详情页
2. 找到 **「Variables」** 或 **「环境变量」** 标签
3. 记录以下信息（后续配置需要）：

| 变量名 | 说明 | 示例值 |
|--------|------|--------|
| `MYSQL_HOST` | 数据库主机 | `zeabur-mysql-x.xxx.zeabur.internal` |
| `MYSQL_PORT` | 端口 | `3306` |
| `MYSQL_USER` | 用户名 | `root` |
| `MYSQL_PASSWORD` | 密码 | `xxxxxxxxxxxx` |
| `MYSQL_DATABASE` | 数据库名 | 默认会自动创建 |

> ⚠️ 不同 MySQL 服务的变量名可能不同，请以实际页面显示为准。

---

## 5. 部署后端

### 5.1 添加后端 Service

1. 回到项目主页，点击 **「+ Service」**
2. 选择 **「GitHub」**（从 GitHub 部署）
3. 授权并选择你的仓库：`fengzhengcheng/Codex-box`（或你实际的仓库名）
4. **重要**：设置 **Root Directory** 为 `backend`
   - 这告诉 Zeabur 只构建 backend 目录下的 Spring Boot 项目
5. 点击 **Deploy**

### 5.2 配置构建命令

Zeabur 会自动检测到 Spring Boot 项目（通过 pom.xml），通常会自动配置：

- **Build Command**: `mvn clean package -DskipTests`
- **Run Command**: `java -jar target/*.jar`

如果自动检测失败，手动设置：

1. 进入后端 Service 的 Settings
2. 找到 Build 设置：
   - Build Command: `mvn clean package -DskipTests -B`
3. Run 设置：
   - Start Command: `java -jar target/*.jar`

### 5.3 配置后端环境变量

在后端 Service 的 **Settings → Variables** 中添加：

| 变量名 | 值 | 说明 |
|--------|-----|------|
| `DB_HOST` | 从 MySQL 服务获取的主机地址 | 见第4步 |
| `DB_PORT` | `3306` | MySQL 端口 |
| `DB_NAME` | `aihub_pro` | 数据库名 |
| `DB_USERNAME` | 从 MySQL 服务获取的用户名 | 见第4步 |
| `DB_PASSWORD` | 从 MySQL 服务获取的密码 | 见第4步 |

> 这些变量会被 `application.yml` 中的 `${DB_HOST:localhost}` 格式读取。

### 5.4 验证后端部署

1. 等待部署完成（首次约 2-5 分钟）
2. Zeabur 会分配一个公网 URL，类似：`https://backend-xxx.zeabur.app`
3. 访问 `https://你的后端URL/api/tools` 测试是否能返回数据
4. 如果返回空数组是正常的（还没导入数据）

---

## 6. 部署前端

### 6.1 添加前端 Service

1. 再次点击 **「+ Service」**
2. 选择 **「GitHub」** → 选择同一仓库
3. **关键设置**：Root Directory 设为 `frontend`
4. 点击 **Deploy**

### 6.2 配置前端环境变量

在前端 Service 的 **Settings → Variables** 中添加：

| 变量名 | 值 | 说明 |
|--------|-----|------|
| `VITE_API_BASE_URL` | `https://你的后端URL/api` | 后端 API 地址 |

> 例如：`VITE_API_BASE_URL=https://backend-abc123.zeabur.app/api`

### 6.3 配置构建命令（如果自动检测失败）

- **Build Command**: `npm run build`
- **Output Directory**: `dist`
- **Start Command**: 无需（静态站点用 nginx/serve）

Zeabur 对前端项目会自动识别为静态网站，使用内置 Web 服务器。

### 6.4 验证前端部署

1. 等待部署完成
2. 访问分配的前端 URL，应该能看到网站首页
3. 但此时数据可能为空（因为还没导入数据库）

---

## 7. 导入数据库

这是最关键的一步！Zeabur 上的 MySQL 是空的，需要导入初始化数据。

### 方法一：通过 Zeabur 终端导入（推荐）

1. 进入 **MySQL 服务** 详情页
2. 找到 **「Terminal」** 或 **「终端」** 标签
3. 点击 **「Launch Terminal」** 启动 MySQL 命令行
4. 在终端中依次执行：

```sql
-- 先查看当前数据库名（可能不是 aihub_pro）
SHOW DATABASES;

-- 使用正确的数据库（以实际为准）
USE 你的数据库名;

-- 导入建表语句（复制 schema.sql 内容粘贴执行）
-- 或者用 source 命令（如果支持文件上传）
```

### 方法二：通过本地 Navicat 远程连接

部分 Zeabur MySQL 支持外部连接：

1. 在 MySQL 服务中找到 **「Connection Info」** 或 **连接信息**
2. 获取公网连接地址和端口（可能需要开启 Public Access）
3. 用本地 Navicat 连接远程 MySQL
4. 导入 `schema.sql` 和 `data.sql`

### 方法三：通过后端初始化接口（备用方案）

如果以上方法都不行，可以在后端添加一个初始化接口：

1. 在本地先确认 SQL 能正常执行
2. 部署后通过后端的 MySQL 终端执行

### 验证数据导入

导入完成后，访问：
- `https://你的后端URL/api/tools` - 应返回 14 条工具数据
- `https://你的后端URL/api/prompts` - 应返回 10 条提示词数据

---

## 8. 配置环境变量汇总

### 后端环境变量

| 变量名 | 来源 | 示例值 |
|--------|------|--------|
| `DB_HOST` | MySQL 服务 Variables | `zeabur-mysql-xxx.zeabur.internal` |
| `DB_PORT` | 固定值 | `3306` |
| `DB_NAME` | 自定义 | `aihub_pro` |
| `DB_USERNAME` | MySQL 服务 Variables | `root` |
| `DB_PASSWORD` | MySQL 服务 Variables | `your_password` |

### 前端环境变量

| 变量名 | 值 | 说明 |
|--------|-----|------|
| `VITE_API_BASE_URL` | 后端公网 URL + /api | `https://backend-xxx.zeabur.app/api` |

---

## 9. 绑定域名（可选）

### 9.1 准备域名

1. 准备一个已备案的域名（国内访问必须）
2. 或使用国际域名（海外访问无需备案）

### 9.2 在 Zeabur 绑定

1. 进入前端 Service 的 **Settings → Domains**
2. 点击 **「Add Domain」**
3. 输入你的域名，如 `www.yourdomain.com` 或 `aihub.yourdomain.com`
4. Zeabur 会显示需要配置的 DNS 记录：

| 类型 | 名称 | 值 |
|------|------|-----|
| CNAME | @ 或 www | `cname.zeabur.com.` 或 Zeabur 提供的目标地址 |

### 9.3 配置 DNS

去你的域名服务商（阿里云/腾讯云/Cloudflare 等）添加对应的 DNS 记录。

### 9.4 等待生效

DNS 解析通常需要几分钟到几小时不等。可以用 `ping 你的域名` 测试是否指向 Zeabur。

---

## 10. 故障排查

### 问题 1：页面跳转后白屏或 404

**症状**：首页正常，点击跳转后白屏或 Not Found

**排查步骤**：
1. 检查前端 Service 是否配置了 **SPA Fallback** 或 **Rewrites**
2. 在前端 Service Settings 中找到 **Routing** 或 **路由** 设置
3. 添加规则：所有非静态文件请求都指向 `index.html`
4. Zeabur 静态站点通常需要配置：`/* → /index.html (200)`

**解决方案**：在 zeabur.config.json 中添加（放在 frontend 目录）：
```json
{
  "rewrites": [
    { "source": "/(.*)", "destination": "/index.html" }
  ]
}
```

---

### 问题 2：接口返回 404

**症状**：前端页面能打开，但数据加载失败，F12 显示 404

**排查步骤**：
1. 确认后端 Service 是否正常运行（看 Deploy Logs）
2. 确认后端 URL 正确：访问 `https://后端URL/api/tools`
3. 检查前端 `VITE_API_BASE_URL` 是否正确填写了后端地址
4. 确认后端地址末尾没有多余的 `/`

**常见错误**：
- ❌ `https://backend-xxx.zeabur.appapi/tools` （缺少斜杠）
- ✅ `https://backend-xxx.zeabur.app/api/tools`

---

### 问题 3：数据库连接失败

**症状**：后端日志显示 `Cannot create connection to database`

**排查步骤**：
1. 检查后端环境变量是否正确填写
2. 确认 MySQL 服务状态为 Running
3. 确认 DB_HOST 使用的是 **内部地址**（`.zeabur.internal` 结尾）而非公网地址
4. 确认 DB_NAME 与实际创建的数据库名一致
5. 查看 MySQL 服务的 Logs 确认是否有报错

**调试方法**：在后端 Service 的 **Logs** 中搜索 `datasource` 或 `error` 关键字

---

### 问题 4：前端跨域错误 (CORS)

**症状**：F12 控制台显示 `Access-Control-Allow-Origin` 相关错误

**排查步骤**：
1. 确认后端 CorsConfig 生效（代码中已配置允许所有来源）
2. 检查请求是否带了正确的 Origin header
3. 如果 Zeabur 有前置代理/CDN，可能需要在 Zeabur 层面配置 CORS

**解决方案**：
- 方案A：确认后端 CORS 配置包含前端的 Origin
- 方案B：使用 Zeabur 的 Network 配置，将前后端放在同一个域下
- 方案C：在前端 vite.config.js 中保持 proxy 配置（仅开发环境）

---

### 问题 5：部署一直失败

**症状**：Deploy Status 显示 Failed

**排查步骤**：
1. 点击失败的 Deployment 查看 **Build Logs**
2. 常见原因：
   - **Maven 编译失败**：检查 Java 版本（需要 JDK 17），在 Settings 中设置 `JAVA_VERSION=17`
   - **依赖下载失败**：网络问题，重新触发 Deploy
   - **pom.xml 错误**：检查 XML 格式是否正确

**后端常见 Build Command**：
```bash
mvn clean package -DskipTests -B
```

**前端常见 Build Command**：
```bash
npm run build
```

---

### 问题 6：数据不显示

**症状**：页面正常但工具/提示词列表为空

**原因**：数据库未导入初始数据

**解决**：
1. 按照 [第8步](#8-导入数据库) 导入 `schema.sql` 和 `data.sql`
2. 验证：直接访问后端 API 确认有数据返回

---

### 问题 7：管理员无法登录

**症状**：输入 admin/123456 提示密码错误

**原因**：data.sql 未导入，admin 表为空

**解决**：
1. 确认 data.sql 已完整执行
2. 检查 admin 表是否有数据：`SELECT * FROM admin;`
3. 如果为空，手动插入：
   ```sql
   INSERT INTO admin (username, password, nickname) VALUES ('admin', '123456', '超级管理员');
   ```

---

## 快速检查清单

部署完成后，按以下顺序验证：

- [ ] 后端 Service 状态为 Running
- [ ] 前端 Service 状态为 Running
- [ ] MySQL Service 状态为 Running
- [ ] 访问前端 URL 能看到首页
- [ ] 访问 `/tools` 能看到工具列表（14条）
- [ ] 访问 `/prompts` 能看到提示词列表（10条）
- [ ] 使用 admin/123456 能登录后台
- [ ] 后台仪表盘显示统计数据
- [ ] 后台能新增/编辑/删除工具

全部通过？恭喜，部署成功！🎉

---

## 架构图

```
                    ┌─────────────┐
                    │   Browser   │
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │   Zeabur    │
                    │  (Frontend) │ ← 静态网站 (Vue3 build产物)
                    └──────┬──────┘
                           │ API请求
                    ┌──────▼──────┐
                    │   Zeabur    │
                    │  (Backend)  │ ← Spring Boot (Java 17)
                    └──────┬──────┘
                           │ JDBC
                    ┌──────▼──────┐
                    │   Zeabur    │
                    │   (MySQL)   │ ← 托管数据库
                    └─────────────┘
```

## 技术支持

遇到其他问题？
1. 查看 Zeabur 官方文档：[docs.zeabur.com](https://docs.zeabur.com)
2. 查看 Zeabur Discord 社区
3. 检查项目的 [GitHub Issues](https://github.com/fengzhengcheng/Codex-box/issues)
