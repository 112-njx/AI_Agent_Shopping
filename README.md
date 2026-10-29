# AI_Agent_Shopping

**基于 AI Agent 的电子商城全栈项目（图书商城）**

一个前后端分离的图书电子商城：Spring Boot + MyBatis 提供接口，Vue 3 负责页面，购物、下单、支付宝沙箱支付全流程可用，AI Agent 智能推荐系统按路线图逐步落地。

*浏览 → 搜索 → 加购 → 下单 → 支付宝沙箱支付*

⚠️ 本项目为**教学与实验用途**的学习项目，不用于真实商业运营。支付接入的是支付宝**沙箱环境**，代码中的密钥为测试凭证，请勿用于真实交易；图书、价格、销量等数据均为演示数据。

## 这是什么

AI_Agent_Shopping 是一个面向课程实验与毕设场景的电子商城全栈项目，覆盖「用户 → 图书 → 分类 → 购物车 → 订单 → 支付」完整购物链路，并按规划逐步加入 AI Agent 智能推荐能力。

本项目整合了：

- **用户体系**：邮箱注册/登录、图形验证码、邮箱激活、HMAC-MD5 加盐密码存储；
- **图书与分类**：推荐/热销/最新上架/新书热卖、关键词搜索（分页）、图书详情、二级分类树浏览；
- **购物与订单**：Session 购物车（加购/删除/改数量/自动合计）、一键下单（雪花 ID）、库存扣减；
- **支付宝沙箱支付**：页面支付、同步回调、异步通知（RSA2 验签）、支付查询、交易关闭、退款、退款查询；
- **前端**：Vue 3 + Vite 共 10 个页面，卡片化布局、统一色彩体系、三端响应式；
- **AI Agent 推荐**：按路线图推进用户行为采集、商品特征库、Python 推荐服务与多策略融合（见 `docs/back_end_roadmap.md`）。

它不是黑盒商业系统。所有接口、页面、支付流程与文档都在仓库内，可完整学习与二次开发。

## 当前进度

商城主体功能已全部完成并前后端联调通过，单测覆盖注册 / 下单 / 邮箱激活三个核心流程。

- **已实现**：用户、图书、分类、购物车、地址、订单、支付宝沙箱支付、前端 10 个页面、JUnit 单测；
- **推进中**（详见 `docs/back_end_roadmap.md` 的 17 步路线与优先级表）：Redis 缓存与购物车持久化、地址/订单/用户模块完善、后台管理系统、用户行为采集、商品特征库、Python AI 推荐服务、AI Agent 推荐策略。

## 系统架构

```
flowchart TB
 C["浏览器 Web 客户端"]
 FE["Vue 3 前端（dev: Vite :5173 / 生产: 静态资源由后端托管）"]
 API["Spring Boot（:8989/dangdang）"]
 DB[("MySQL（t_user / t_book / t_order / t_item / ...）")]
 ALI["支付宝沙箱网关"]
 MAIL["SMTP 邮件服务（激活码）"]

 C --> FE --> API
 API --> DB
 API --> ALI
 API --> MAIL
```

| 模块 | 职责 |
|---|---|
| `controller` | 接口层：user / book / category / cart / address / order，及 `pay/` 下的支付宝沙箱 Servlet |
| `service` | 业务层：注册登录、购物车、下单、支付状态流转等 |
| `dao` + `resources/.../mapper` | MyBatis Mapper 接口与 XML（开启驼峰映射） |
| `entity` / `dto` | 数据库实体与传输对象 |
| `frontend_agent` | Vue 3 前端工程，构建产物输出到 `src/main/resources/static/` 由后端托管 |
| `docs` | 需求、路线、API、调试文档与 SQL 初始化脚本 |

## 快速开始

前置要求：JDK 8+（已在 JDK 23 验证）、Maven、MySQL 5.7+、Node.js 18+（前端）。

1. **初始化数据库**：新建数据库（库名与 `src/main/resources/application.yml` 中 `datasource.url` 保持一致，默认 `AI_Agent_shopping`），导入 `docs/dangdang.sql` 完成建表与示例数据；
2. **检查配置**：`application.yml` 默认端口 8989、context-path `/dangdang`、MySQL 账号 root/123456，请按本机环境修改。

### 方案 A：源码运行（推荐）

```
# 后端（项目根目录）
mvn spring-boot:run          # 或 mvn package 后 java -jar target/dangdang-test-1.0-SNAPSHOT.jar

# 前端
cd frontend_agent
npm install
npm run dev                  # http://127.0.0.1:5173
```

### 方案 B：前端产物由后端托管

```
cd frontend_agent
npm run build                # 产物输出至 ../src/main/resources/static/
```

然后直接访问 `http://127.0.0.1:8989/dangdang/`，Spring Boot 会托管前端静态资源。

> 注意：`frontend_agent/vite.config.js` 的 dev 代理默认指向 `8080`，若后端使用默认端口 8989，需同步修改代理 target 保持一致。

## 支付宝沙箱支付

- 支付模块使用 `alipay-sdk-java`，网关为沙箱环境 `https://openapi-sandbox.dl.alipaydev.com/gateway.do`；
- 在支付宝开放平台创建沙箱应用后，替换 `controller/pay/AlipayConfig.java` 中的 `app_id`、`merchant_private_key`、`alipay_public_key`；
- `notify_url` 需外网可访问（本地联调可用内网穿透，如 natapp）；`return_url` 指向本机回调地址；
- 沙箱买家账号与收款账号在支付宝开放平台沙箱控制台查看。

## 本地端点

| 服务 | 默认地址 | 用途 |
|---|---|---|
| 前端（dev） | http://127.0.0.1:5173 | Vite 开发服务器，代理 `/dangdang` 到后端 |
| 后端 API | http://127.0.0.1:8989/dangdang | 全部接口（含托管的前端静态页面） |
| MySQL | 127.0.0.1:3306 | 数据库（默认 `AI_Agent_shopping`） |

## 安全模型

- **密码存储**：注册时生成随机 6 位盐，密码经 HMAC-MD5 加盐后入库，登录时用库中盐重新计算比对；
- **图形验证码**：注册页验证码写入 Session，防止机器注册；
- **邮箱激活**：注册后向邮箱发送 6 位激活码，激活后用户状态生效；
- **会话机制**：登录态与购物车存于 Session（JSESSIONID Cookie）；
- **支付验签**：异步通知使用 `AlipaySignature.rsaCheckV1`（RSA2）验签通过后才更新订单与支付状态。

## 核心能力

| 领域 | 当前能力 |
|---|---|
| 用户 | 注册（邮箱+密码+昵称+图形验证码）、登录、邮箱激活、当前用户查询 |
| 图书 | 随机推荐/热销/最新上架/新书热卖、关键词搜索分页、详情、按分类分页 |
| 分类 | 一级+二级分类树、按父分类查子分类 |
| 购物车 | Session 购物车：加购、删除、改数量、总价与节省金额自动计算 |
| 订单 | 购物车一键下单（雪花 ID）、订单详情、库存扣减、下单后清空购物车 |
| 支付 | 支付宝沙箱：页面支付、同步/异步回调、支付查询、交易关闭、退款、退款查询 |
| 前端 | 首页/登录/注册/邮箱验证/详情/搜索/分类/购物车/下单/支付结果，三端响应式 |

## AI Agent 推荐路线

项目名中的 AI Agent 指向「智能推荐系统」，当前商城主体已完成，推荐链路按 `docs/back_end_roadmap.md` 逐步推进：

- **用户行为采集**（第 10 步）：埋点记录 BROWSE / SEARCH / ADD_CART / PURCHASE，异步写入避免拖慢接口；
- **商品特征库**（第 11 步）：从书名、作者、出版社、简介提取文本特征，构建 TF-IDF 词向量与余弦相似度；
- **Python 推荐服务**（第 12 步）：协同过滤（User-Based & Item-Based）+ 基于内容 + 混合推荐，提供 REST 接口；
- **Java-Python 对接**（第 13 步）：RestTemplate/Feign 封装、Redis 缓存结果、AI 服务不可用时回退规则推荐；
- **AI Agent 策略**（第 14 步）：冷启动兜底、用户画像动态调整、多策略权重（协同过滤 α / 内容 β / 热门 γ）AB 测试。

## 开发

```
mvn test          # 运行单测（TestDangDang：注册 / 下单 / 邮箱激活）
mvn package       # 打包可执行 jar
cd frontend_agent && npm run build   # 构建前端产物到 static/
```

已记录的问题与修复见 `docs/back_end_test.md`：JDK 11+ 下 Lombok 注解处理器与 `javax.annotation` 依赖的兼容（`pom.xml` 已处理）、Mapper XML 与源码同步等。

## 仓库结构

```
AI_Agent_Shopping/
|-- src/                          # Spring Boot 后端（com.cpx.dangdang）
|   |-- main/java/com/cpx/dangdang/
|   |   |-- controller/           # 接口层（含 pay/ 支付宝沙箱 Servlet）
|   |   |-- service/ impl/        # 业务层
|   |   |-- dao/                  # MyBatis Mapper 接口
|   |   |-- entity/ dto/          # 实体与传输对象
|   |   |-- util/                 # 工具类（SendEmailUtil 等）
|   |   `-- DangDangApplication.java   # Spring Boot 入口
|   |-- main/resources/
|   |   |-- application.yml       # 端口 8989 / context-path /dangdang / MySQL / MyBatis
|   |   |-- com/cpx/dang/mapper/  # MyBatis XML
|   |   `-- static/               # 前端构建产物（Vue 打包输出，由后端托管）
|   `-- test/java/.../TestDangDang.java   # JUnit 单测
|-- frontend_agent/               # Vue 3 + Vite 前端
|   |-- src/
|   |   |-- views/                # 10 个页面
|   |   |-- components/           # Header/Footer/BookCard/分页/Toast 等
|   |   |-- router/ utils/ assets/
|   |   `-- App.vue / main.js
|   `-- vite.config.js            # dev 代理 + 构建产物输出到 static/
|-- docs/                         # 需求、路线图、API 文档、调试记录、SQL
|   |-- tech_docs.md              # 项目要求与技术栈说明
|   |-- back_end_roadmap.md       # 后端路线（含 AI 推荐 17 步）
|   |-- front_end_roadmap.md      # 前端路线与页面清单
|   |-- api_docs.md               # 接口文档（参数与返回实例）
|   |-- back_end_test.md          # 后端调试记录
|   |-- front_end_test.md         # 前端调试记录
|   `-- dangdang.sql              # 建表与示例数据
|-- pom.xml                       # Maven 配置（Spring Boot 2.3.12 / Java 8）
`-- .gitignore
```

## 文档

| 主题 | 文档 |
|---|---|
| 项目要求与技术栈 | `docs/tech_docs.md` |
| 后端实现路线（含 AI 推荐规划） | `docs/back_end_roadmap.md` |
| 前端实现路线 | `docs/front_end_roadmap.md` |
| API 文档 | `docs/api_docs.md` |
| 后端调试记录 | `docs/back_end_test.md` |
| 前端调试记录 | `docs/front_end_test.md` |
| 数据库初始化脚本 | `docs/dangdang.sql` |

## 参与贡献

提 PR 前请先看 `docs/back_end_roadmap.md`：当前实现集中在商城主体，AI 推荐相关步骤（10-14 步）按依赖顺序推进；改动请保持 Mapper XML 与接口同步，并为关键流程补充单测。

## 许可证与法律声明

- 仓库当前**未附带 LICENSE 文件**，版权归作者所有。如需引用、分发或商用，请先联系作者获取授权。
- 本项目为**教学与实验用途**，不构成任何商业服务。支付宝为沙箱环境，代码中的测试凭证不得用于真实交易；图书、价格、销量等均为演示数据。
- 仅用于合法学习与实验，不得用于欺诈、洗钱或其他违法活动。

## 致谢

本项目建立在以下开源生态之上：

- Spring Boot · MyBatis · Druid · PageHelper · Hutool · javax.mail
- Vue 3 · Vite · Vue Router · Axios
- 支付宝开放平台（沙箱环境）

<sub>如果本项目对您有帮助，一个 GitHub Star 就是最大的支持。</sub>
