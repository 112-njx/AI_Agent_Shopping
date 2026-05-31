# 后端实现路线 (Backend Roadmap)

## 当前已实现功能

### 用户模块
- [x] 注册（邮箱 + 密码 + 昵称 + 图形验证码）
- [x] 登录（邮箱 + 密码 + HMAC-MD5 加盐加密）
- [x] 邮箱激活（发送验证码邮件）
- [x] 图形验证码生成
- [x] 获取当前登录用户

### 图书模块
- [x] 推荐图书（随机4本）
- [x] 热销图书（按销量排序4本）
- [x] 最新上架（30天内）
- [x] 新书热卖（30天内按销量排序）
- [x] 关键词搜索（分页）
- [x] 图书详情
- [x] 按分类查询（分页）

### 分类模块
- [x] 全部分类（含二级子分类，树形结构）
- [x] 按父分类ID查子分类

### 购物车模块
- [x] 添加商品到购物车（Session 存储）
- [x] 查看购物车
- [x] 删除购物车商品
- [x] 修改商品数量

### 收货地址模块
- [x] 查询当前用户地址列表

### 订单模块
- [x] 创建订单（从购物车生成，雪花ID）
- [x] 查询订单详情

### 支付模块
- [x] 支付宝沙箱支付（页面支付）
- [x] 支付同步回调
- [x] 支付异步通知
- [x] 支付结果查询
- [x] 交易关闭
- [x] 退款
- [x] 退款查询

---

## 待提升实现功能（按步骤划分）

### 第1步：Redis 缓存集成与购物车持久化

**工作量**: 小

- [ ] 引入 Redis 依赖（spring-boot-starter-data-redis）
- [ ] 配置 Redis 连接（application.yml）
- [ ] 将购物车从 Session 迁移至 Redis 存储
- [ ] 实现购物车过期机制（如7天未操作自动清除）
- [ ] 首页热门数据缓存（热销、推荐、分类）

---

### 第2步：收货地址 CRUD 完善

**工作量**: 小

- [ ] 新增收货地址 (POST /address/add)
- [ ] 修改收货地址 (POST /address/update)
- [ ] 删除收货地址 (POST /address/delete)
- [ ] AddressDao 补充 insert、update、delete SQL
- [ ] AddressService 补充对应方法

---

### 第3步：用户模块完善

**工作量**: 中

- [ ] 用户登出 (GET /user/logout) - 清除 Session/Redis 会话
- [ ] 修改个人资料 (POST /user/updateProfile) - 昵称修改
- [ ] 修改密码 (POST /user/changePassword)
- [ ] 忘记密码/重置密码 (POST /user/resetPassword) - 邮箱验证码重置

---

### 第4步：订单模块完善

**工作量**: 中

- [ ] 用户订单列表 (GET /order/myOrders) - 分页查询当前用户所有订单
- [ ] 取消订单 (POST /order/cancel) - 订单状态改为 CANCELLED
- [ ] 订单状态流转：UNPAID -> PAID -> SHIPPED -> RECEIVED
- [ ] 确认收货 (POST /order/confirmReceive)
- [ ] OrderDao 补充 selectByUserId、cancelOrder 等 SQL

---

### 第5步：后台管理系统 - 管理员认证

**工作量**: 小

- [ ] 创建 Admin 实体（对应 t_admin 表）
- [ ] 创建 AdminDao、AdminService、AdminController
- [ ] 管理员登录 (POST /admin/login)
- [ ] 管理员登出 (POST /admin/logout)
- [ ] 登录拦截器 - 基于 Session 的权限校验

---

### 第6步：后台管理系统 - 图书管理

**工作量**: 中

- [ ] 图书列表（分页，支持搜索和分类筛选）(GET /admin/book/list)
- [ ] 新增图书 (POST /admin/book/add)
- [ ] 修改图书 (POST /admin/book/update)
- [ ] 删除图书 (POST /admin/book/delete)
- [ ] 图书上下架 (POST /admin/book/toggleStatus)
- [ ] 补充 BookDao 的 insertBook、updateBook、deleteBook SQL

---

### 第7步：后台管理系统 - 分类管理

**工作量**: 小

- [ ] 分类列表 (GET /admin/category/list)
- [ ] 新增分类 (POST /admin/category/add)
- [ ] 修改分类 (POST /admin/category/update)
- [ ] 删除分类 (POST /admin/category/delete)
- [ ] 补充 CategoryDao 的 insert、update、delete SQL

---

### 第8步：后台管理系统 - 订单管理

**工作量**: 中

- [ ] 全部订单列表 (GET /admin/order/list) - 分页 + 状态筛选
- [ ] 订单详情 (GET /admin/order/detail)
- [ ] 修改订单状态/发货 (POST /admin/order/updateStatus)
- [ ] 补充 OrderDao 的 selectAll、countByStatus 等 SQL

---

### 第9步：后台管理系统 - 用户管理

**工作量**: 小

- [ ] 用户列表 (GET /admin/user/list) - 分页
- [ ] 禁用/启用用户 (POST /admin/user/toggleStatus)
- [ ] 补充 UserDao 的 selectAll、updateUserStatus SQL

---

### 第10步：用户行为数据采集

**工作量**: 中

- [ ] 创建行为数据表：t_user_behavior（user_id, book_id, behavior_type, create_time）
  - behavior_type: BROWSE（浏览）, SEARCH（搜索）, ADD_CART（加购）, PURCHASE（购买）
- [ ] 创建 UserBehavior 实体、DAO
- [ ] 在各 Controller 中埋点记录用户行为：
  - 图书详情页 -> 记录 BROWSE
  - 搜索 -> 记录 SEARCH + 关键词
  - 加购 -> 记录 ADD_CART
  - 下单 -> 记录 PURCHASE
- [ ] 异步写入（@Async 或消息队列）避免影响响应时间

---

### 第11步：商品特征库构建

**工作量**: 中

- [ ] 创建商品特征表：t_book_feature（book_id, feature_vector JSON, tags, update_time）
- [ ] 特征提取逻辑（Java 端）：
  - 从书名、作者、出版社、分类、简介提取文本特征
  - 构建 TF-IDF 词向量（或调用 Python 服务生成）
- [ ] 商品相似度计算与存储（余弦相似度）

---

### 第12步：Python AI 推荐服务搭建

**工作量**: 大

- [ ] 搭建 Python Flask/FastAPI 推荐服务
- [ ] 实现协同过滤算法（User-Based & Item-Based CF）
- [ ] 实现基于内容的推荐（Content-Based）
- [ ] 实现混合推荐策略
- [ ] 训练/更新推荐模型
- [ ] 提供 REST API：
  - `GET /recommend/user/{userId}` - 个性化推荐
  - `GET /recommend/similar/{bookId}` - 相似商品推荐
  - `GET /recommend/hot` - 热门推荐
  - `POST /recommend/feedback` - 接收用户反馈用于模型更新

---

### 第13步：Java 后端与 Python AI 服务对接

**工作量**: 中

- [ ] 创建 AI 推荐服务调用层（RestTemplate / Feign）
- [ ] 推荐接口封装：
  - `GET /recommend/personalized` - 用户个性化推荐
  - `GET /recommend/similar/{bookId}` - 相似图书推荐
  - `GET /recommend/popular` - 热门推荐
- [ ] 推荐结果缓存（Redis）
- [ ] 降级策略：AI 服务不可用时回退到规则推荐

---

### 第14步：AI Agent 智能推荐策略

**工作量**: 大

- [ ] 设计 AI Agent 决策框架：
  - 冷启动策略：新用户使用热门 + 随机推荐
  - 基于用户画像的动态推荐调整
  - 实时反馈学习（点击率、加购率、购买转化率）
- [ ] 用户画像构建：
  - 创建用户画像表：t_user_profile（user_id, preferred_categories, price_range, author_prefs, tags）
  - 基于行为数据自动更新画像
- [ ] 多策略融合推荐：
  - 协同过滤权重 α
  - 内容推荐权重 β
  - 热门推荐权重 γ
  - 通过 AB 测试动态调整权重

---

### 第15步：SpringCloud 微服务化（可选/进阶）

**工作量**: 大

- [ ] 服务拆分：
  - dangdang-user-service（用户服务）
  - dangdang-book-service（商品服务）
  - dangdang-order-service（订单服务）
  - dangdang-cart-service（购物车服务）
  - dangdang-pay-service（支付服务）
  - dangdang-recommend-service（推荐服务网关）
- [ ] 注册中心：Nacos
- [ ] API 网关：Spring Cloud Gateway
- [ ] 服务间调用：OpenFeign
- [ ] 配置中心：Nacos Config

---

### 第16步：Docker 容器化部署

**工作量**: 中

- [ ] 编写 Dockerfile（Java 后端）
- [ ] 编写 Dockerfile（Python AI 服务）
- [ ] 编写 docker-compose.yml（MySQL + Redis + Java + Python + Nginx）
- [ ] Nginx 反向代理配置
- [ ] 数据卷持久化配置

---

### 第17步：系统测试与优化

**工作量**: 大

- [ ] 单元测试（JUnit + Mockito）
- [ ] 接口测试（Postman Collection）
- [ ] 推荐精度评估（准确率、召回率、F1-score）
- [ ] 响应速度优化：
  - 数据库索引优化
  - 查询 SQL 优化
  - Redis 缓存策略调优
- [ ] 压力测试（JMeter）

---

## 优先级总结

| 步骤 | 内容 | 优先级 | 工作量 | 依赖 |
|------|------|--------|--------|------|
| 1 | Redis 缓存集成 | 高 | 小 | 无 |
| 2 | 收货地址 CRUD | 高 | 小 | 无 |
| 3 | 用户模块完善 | 高 | 中 | 1 |
| 4 | 订单模块完善 | 高 | 中 | 无 |
| 5 | 后台-管理员认证 | 高 | 小 | 无 |
| 6 | 后台-图书管理 | 高 | 中 | 5 |
| 7 | 后台-分类管理 | 高 | 小 | 5 |
| 8 | 后台-订单管理 | 高 | 中 | 5 |
| 9 | 后台-用户管理 | 中 | 小 | 5 |
| 10 | 用户行为数据采集 | 高 | 中 | 无 |
| 11 | 商品特征库构建 | 高 | 中 | 10 |
| 12 | Python AI 推荐服务 | 高 | 大 | 10, 11 |
| 13 | Java-Python 对接 | 高 | 中 | 12 |
| 14 | AI Agent 推荐策略 | 高 | 大 | 12, 13 |
| 15 | SpringCloud 微服务 | 低 | 大 | 1-14 |
| 16 | Docker 部署 | 中 | 中 | 1-14 |
| 17 | 系统测试与优化 | 中 | 大 | 1-14 |
