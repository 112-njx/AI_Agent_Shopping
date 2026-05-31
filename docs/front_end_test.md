# 前端调试记录

## 2026-05-30：Vue3 前端项目初始化

### 项目结构

Vue3 + Vite 前端项目已创建在 `frontend_agent/` 目录下，包含以下页面：

| 页面 | 路由 | 功能 |
|------|------|------|
| 首页 | `/` | 轮播Banner、分类侧边栏、图书推荐Tab |
| 登录 | `/login` | 邮箱+密码登录 |
| 注册 | `/register` | 邮箱+昵称+密码+图形验证码注册 |
| 邮箱验证 | `/validate-email` | 激活码验证 |
| 图书详情 | `/book/:bookId` | 图书信息、加入购物车 |
| 搜索 | `/search` | 关键词搜索+分页 |
| 分类 | `/category` | 按分类浏览+分页 |
| 购物车 | `/cart` | 商品管理、数量修改、结算 |
| 下单 | `/order/place` | 地址选择、订单确认、发起支付 |
| 支付结果 | `/pay/result` | 支付状态查询 |

### 开发环境配置

1. **安装依赖**：
   ```bash
   cd frontend_agent
   npm install
   ```

2. **启动开发服务器**：
   ```bash
   npm run dev
   ```
   开发服务器运行在 `http://localhost:5173`，自动代理 `/dangdang` API 至 `http://localhost:8080`。

3. **构建生产版本**：
   ```bash
   npm run build
   ```
   构建产物输出至 `src/main/resources/static/`，由 Spring Boot 直接提供静态服务。

### 需要后端运行的服务

- Spring Boot 应用需运行在 `localhost:8080`
- MySQL 数据库（dangdang 库，端口 3306）
- 支付宝沙箱环境（支付功能需要）

### 构建验证

✅ `npm install` - 成功安装 60 个依赖包
✅ `npx vite build` - 成功构建，产出 27 个文件（CSS + JS），输出至 `src/main/resources/static/`

### 设计特色

- 卡片化布局，统一色彩体系（主色 #E60012 / 品牌红）
- CSS 自定义属性管理全局样式变量
- 响应式三端适配（Mobile <768px, Tablet 768-1024px, Desktop >1024px）
- Vue 3 Composition API (`<script setup>`)
- 路由懒加载
- Toast 通知系统（provide/inject）
- Axios 统一拦截器处理

### 注意事项

1. 图片资源路径：图书封面、Logo、Banner 等图片均从 Spring Boot 后端的 `/dangdang/front/images/` 路径加载，开发时通过 Vite 代理访问。
2. 购物车数据存储在 Session 中，需要保持 Session 一致性（浏览器 Cookie 携带 JSESSIONID）。
3. 支付流程需要支付宝沙箱环境配置正确。
4. 用户登录状态存储在 localStorage 中，`showUser` API 通过 Session 验证。
