# 前端实现路线 (Frontend Roadmap)

## 技术选型

- **框架**: Vue 3 (Composition API) + Vite
- **路由**: Vue Router 4 (Hash 模式)
- **HTTP**: Axios
- **UI**: 纯 CSS 自定义设计（卡片化布局、统一色彩体系、响应式）
- **构建输出**: 静态文件部署至 `src/main/resources/static/`

## 页面清单与对应 API

基于已实现的后端 API，规划以下前端页面：

### 1. 首页 (Home)
- **路由**: `/`
- **API 依赖**:
  - `GET /dangdang/book/listCommented` → 编辑推荐
  - `GET /dangdang/book/listHotSale` → 热销图书
  - `GET /dangdang/book/listNewGrounding` → 最新上架
  - `GET /dangdang/book/listNewSale` → 新书热卖
  - `GET /dangdang/category/showCategory` → 分类树
  - `GET /dangdang/user/showUser` → 当前用户

### 2. 登录页 (Login)
- **路由**: `/login`
- **API 依赖**:
  - `POST /dangdang/user/login` → 登录

### 3. 注册页 (Register)
- **路由**: `/register`
- **API 依赖**:
  - `GET /dangdang/user/validateCode` → 图形验证码
  - `POST /dangdang/user/register` → 注册

### 4. 邮箱验证页 (Validate Email)
- **路由**: `/validate-email`
- **API 依赖**:
  - `POST /dangdang/user/validateEmail` → 激活邮箱

### 5. 图书详情页 (Book Detail)
- **路由**: `/book/:bookId`
- **API 依赖**:
  - `GET /dangdang/book/showBook?bookId=` → 图书详情
  - `POST /dangdang/cart/putCart` → 加入购物车

### 6. 搜索页 (Search)
- **路由**: `/search?name=&pageNum=&pageSize=`
- **API 依赖**:
  - `GET /dangdang/book/search` → 关键词搜索

### 7. 分类图书页 (Category Books)
- **路由**: `/category?pid=&cid=&pageNum=&pageSize=`
- **API 依赖**:
  - `GET /dangdang/category/selectCategoryByParentId?pid=` → 子分类
  - `GET /dangdang/book/showBookByCategoryId` → 按分类查书

### 8. 购物车页 (Cart)
- **路由**: `/cart`
- **API 依赖**:
  - `GET /dangdang/cart/showCart` → 查看购物车
  - `POST /dangdang/cart/deleteCart` → 删除商品
  - `POST /dangdang/cart/updateCartCount` → 修改数量

### 9. 下单页 (Place Order)
- **路由**: `/order/place`
- **API 依赖**:
  - `GET /dangdang/address/show` → 收货地址
  - `GET /dangdang/cart/showCart` → 购物车内容
  - `POST /dangdang/order/addOrder` → 创建订单
  - `POST /dangdang/trade/pay` → 发起支付

### 10. 支付结果页 (Payment Result)
- **路由**: `/pay/result?orderId=`
- **API 依赖**:
  - `GET /dangdang/order/getPaidOrderInfo?orderId=` → 订单详情

---

## 开发步骤划分

### 第1步：项目初始化与基础配置
**工作量**: 小

- [ ] 使用 Vite 创建 Vue 3 项目（`frontend_agent/`）
- [ ] 配置 Vue Router（Hash 模式）
- [ ] 配置 Axios 实例（baseURL, 拦截器）
- [ ] 建立目录结构（components, views, router, utils, assets）
- [ ] 定义全局 CSS 变量（色彩体系、间距、字体）
- [ ] 创建通用布局组件（Header, Footer）

### 第2步：首页开发
**工作量**: 中

- [ ] 顶部导航栏（Logo、搜索框、用户状态、购物车图标）
- [ ] 分类侧边栏（树形展开/收起）
- [ ] Banner 轮播区
- [ ] 图书推荐 Tab 区（编辑推荐/热销/最新上架/新书热卖）
- [ ] 图书卡片组件
- [ ] 响应式布局适配（PC / Pad / Mobile）

### 第3步：登录与注册页开发
**工作量**: 小

- [ ] 登录页（邮箱+密码表单）
- [ ] 注册页（邮箱+昵称+密码+确认密码+图形验证码）
- [ ] 邮箱验证页
- [ ] 表单验证与错误提示

### 第4步：图书详情页开发
**工作量**: 小

- [ ] 图书封面与基本信息展示
- [ ] 图书详细信息（作者、出版社、ISBN 等）
- [ ] 编辑推荐、内容简介、作者简介、目录、媒体评论
- [ ] 加入购物车按钮

### 第5步：搜索与分类页开发
**工作量**: 中

- [ ] 搜索结果列表（分页）
- [ ] 分类图书列表（左侧子分类 + 右侧图书列表，分页）
- [ ] 面包屑导航
- [ ] 图书列表项组件（可复用）

### 第6步：购物车页开发
**工作量**: 中

- [ ] 购物车商品列表（封面、名称、单价、数量调整、小计）
- [ ] 数量加减按钮与删除操作
- [ ] 总价与节省金额计算
- [ ] 结算按钮 → 跳转下单页

### 第7步：下单与支付页开发
**工作量**: 中

- [ ] 收货地址选择/展示
- [ ] 订单商品清单
- [ ] 订单金额汇总
- [ ] 提交订单 → 新窗口支付宝支付
- [ ] 支付结果查询页

### 第8步：联调测试与优化
**工作量**: 小

- [ ] 所有页面 API 联调
- [ ] 响应式布局测试
- [ ] 交互细节打磨（loading、空状态、错误提示）
- [ ] 构建产物部署至 Spring Boot static 目录

---

## 色彩体系

| 用途 | 颜色值 | CSS 变量 |
|------|--------|----------|
| 主色（品牌红） | `#E60012` | `--color-primary` |
| 主色深 | `#C40010` | `--color-primary-dark` |
| 强调色（金） | `#FF6B35` | `--color-accent` |
| 背景色 | `#F5F5F5` | `--color-bg` |
| 卡片白 | `#FFFFFF` | `--color-card` |
| 文字主色 | `#1A1A1A` | `--color-text` |
| 文字次色 | `#666666` | `--color-text-secondary` |
| 文字弱色 | `#999999` | `--color-text-muted` |
| 成功绿 | `#52C41A` | `--color-success` |
| 边框色 | `#E8E8E8` | `--color-border` |

## 响应式断点

| 断点 | 宽度 | 目标设备 |
|------|------|----------|
| Mobile | < 768px | 手机 |
| Tablet | 768px - 1024px | 平板 |
| Desktop | > 1024px | PC |
