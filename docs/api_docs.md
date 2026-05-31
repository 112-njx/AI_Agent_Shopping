# 电子商城 API 文档

## 一、用户模块 (User Module)

### 1.1 用户登录
- **Method**: GET/POST
- **Path**: `/dangdang/user/login`
- **Body 实例** (form-data / query params):
  ```
  email=xiaobai@qq.com&password=123456
  ```
- **成功返回实例**:
  ```json
  {
    "status": "ok",
    "message": "登录成功！"
  }
  ```
- **失败返回实例**:
  ```json
  {
    "status": "error",
    "message": "登录失败！"
  }
  ```

---

### 1.2 用户注册
- **Method**: GET/POST
- **Path**: `/dangdang/user/register`
- **Body 实例** (form-data / query params):
  ```
  email=newuser@qq.com&password=123456&nickname=新用户&code=abcd
  ```
- **成功返回实例**:
  ```json
  {
    "status": "ok",
    "message": "注册成功！"
  }
  ```
- **失败返回实例** (邮箱已存在):
  ```json
  {
    "status": "error",
    "message": "邮箱已存在！"
  }
  ```
- **失败返回实例** (验证码错误):
  ```json
  {
    "status": "errorCode",
    "message": "验证码输入有误！"
  }
  ```

---

### 1.3 邮箱激活
- **Method**: GET/POST
- **Path**: `/dangdang/user/validateEmail`
- **Body 实例** (form-data / query params):
  ```
  email=xiaobai@qq.com&activeCode=kdkdk
  ```
- **成功返回实例**:
  ```json
  {
    "status": "ok",
    "message": "激活成功"
  }
  ```
- **失败返回实例**:
  ```json
  {
    "status": "error",
    "message": "激活失败"
  }
  ```

---

### 1.4 获取当前登录用户
- **Method**: GET
- **Path**: `/dangdang/user/showUser`
- **Body 实例**: 无（从 Session 获取）
- **成功返回实例**:
  ```json
  {
    "userId": 1,
    "email": "xiaobai@qq.com",
    "password": "8c7498982f41b93eb0ce8216b48ba21d",
    "salt": "abc",
    "nickname": "小白",
    "status": 1,
    "code": "kdkdk",
    "createDate": "2021-03-23 17:03:39"
  }
  ```

---

### 1.5 获取图形验证码
- **Method**: GET
- **Path**: `/dangdang/user/validateCode`
- **Body 实例**: 无
- **成功返回**: 图片流（image/png），同时将验证码存入 Session 的 `code` 属性

---

## 二、图书模块 (Book Module)

### 2.1 获取推荐图书（随机推荐）
- **Method**: GET
- **Path**: `/dangdang/book/listCommented`
- **Body 实例**: 无
- **成功返回实例**:
  ```json
  [
    {
      "bookId": 1,
      "bookName": "儒林外史",
      "author": "吴敬梓",
      "cover": "16.jpg",
      "press": "花山文艺出版社",
      "pressDate": "2019-07-01",
      "edition": "第三版,第三版,第三版,第三版",
      "printDate": "2018-12-12",
      "impression": "第五次印刷",
      "isbn": "9787551123426",
      "wordNum": 50000,
      "pageNum": 500,
      "sizes": "16开",
      "paper": "胶版纸",
      "pack": "精装",
      "price": 12.0,
      "dprice": 10.0,
      "createDate": "2019-01-07",
      "editorRecommend": "《儒林外史》，是一部描绘知识分子群像的长篇讽刺小说...",
      "contentAbstract": "《儒林外史》，是一部描绘知识分子群像的长篇讽刺小说...",
      "authorAbstract": "吴敬梓（1701-1754），汉族，安徽全椒人...",
      "director": "第　一　回 说楔子敷陈大义...",
      "mediaCommentary": "秉持公心，指摘时弊...",
      "sale": 0,
      "stock": 1000,
      "categoryId": 10
    }
  ]
  ```
  （返回随机4本）

---

### 2.2 获取热销图书
- **Method**: GET
- **Path**: `/dangdang/book/listHotSale`
- **Body 实例**: 无
- **成功返回实例**:
  ```json
  [
    {
      "bookId": 14,
      "bookName": "红楼梦",
      "author": "曹雪芹",
      "cover": "hlm.jpg",
      "dprice": 88.0,
      "price": 100.0,
      "sale": 0,
      "stock": 1000
    }
  ]
  ```
  （返回销量最高的4本）

---

### 2.3 获取最新上架图书
- **Method**: GET
- **Path**: `/dangdang/book/listNewGrounding`
- **Body 实例**: 无
- **成功返回实例**: 返回最近30天内上架的图书列表（最多4本），结构与 2.1 相同

---

### 2.4 获取新书热卖
- **Method**: GET
- **Path**: `/dangdang/book/listNewSale`
- **Body 实例**: 无
- **成功返回实例**: 返回最近30天内上架且销量最高的图书列表（最多4本），结构与 2.1 相同

---

### 2.5 搜索图书
- **Method**: GET
- **Path**: `/dangdang/book/search`
- **Body 实例** (query params):
  ```
  name=三国&pageNum=1&pageSize=10
  ```
- **成功返回实例**:
  ```json
  {
    "total": 1,
    "list": [
      {
        "bookId": 13,
        "bookName": "三国演义",
        "cover": "sgyy.jpg",
        "dprice": 88.0,
        "price": 100.0
      }
    ],
    "pageNum": 1,
    "pageSize": 10,
    "pages": 1
  }
  ```

---

### 2.6 查看图书详情
- **Method**: GET
- **Path**: `/dangdang/book/showBook`
- **Body 实例** (query params):
  ```
  bookId=13
  ```
- **成功返回实例**:
  ```json
  {
    "bookId": 13,
    "bookName": "三国演义",
    "author": "罗贯中",
    "cover": "sgyy.jpg",
    "press": "人民文学出版社",
    "pressDate": "2019-10-01",
    "edition": "第四版",
    "printDate": "2018-12-19",
    "impression": "第五次印刷",
    "isbn": "9787551123426",
    "wordNum": 80000,
    "pageNum": 600,
    "sizes": "16开",
    "paper": "胶版纸",
    "pack": "平装-胶订",
    "price": 100.0,
    "dprice": 88.0,
    "createDate": "2019-01-15",
    "editorRecommend": "编辑没有推荐",
    "contentAbstract": "《三国演义》又名《三国志演义》...",
    "authorAbstract": "作者很低调，没有做简介",
    "director": "第001回　宴桃园豪杰三结义...",
    "mediaCommentary": "媒体也说很好看的一本书",
    "sale": 0,
    "stock": 1000,
    "categoryId": 10
  }
  ```

---

### 2.7 按分类查询图书
- **Method**: GET
- **Path**: `/dangdang/book/showBookByCategoryId`
- **Body 实例** (query params):
  ```
  pid=1&cid=10&pageNum=1&pageSize=10
  ```
  - `pid`: 父分类ID（一级分类）
  - `cid`: 子分类ID（二级分类，可选）
- **成功返回实例**: 分页结果，结构与 2.5 相同

---

## 三、分类模块 (Category Module)

### 3.1 获取全部分类（含二级分类）
- **Method**: GET
- **Path**: `/dangdang/category/showCategory`
- **Body 实例**: 无
- **成功返回实例**:
  ```json
  [
    {
      "categoryId": 1,
      "name": "小说",
      "levels": 1,
      "parentId": null,
      "childList": [
        {
          "categoryId": 8,
          "name": "官场",
          "levels": 2,
          "parentId": 1
        },
        {
          "categoryId": 9,
          "name": "情感",
          "levels": 2,
          "parentId": 1
        },
        {
          "categoryId": 10,
          "name": "四大名著",
          "levels": 2,
          "parentId": 1
        }
      ]
    },
    {
      "categoryId": 2,
      "name": "文艺",
      "levels": 1,
      "parentId": null,
      "childList": [
        {
          "categoryId": 20,
          "name": "文学",
          "levels": 2,
          "parentId": 2
        }
      ]
    }
  ]
  ```

---

### 3.2 根据父分类查询子分类
- **Method**: GET
- **Path**: `/dangdang/category/selectCategoryByParentId`
- **Body 实例** (query params):
  ```
  pid=1
  ```
- **成功返回实例**:
  ```json
  [
    { "categoryId": 8, "name": "官场", "levels": 2, "parentId": 1 },
    { "categoryId": 9, "name": "情感", "levels": 2, "parentId": 1 },
    { "categoryId": 10, "name": "四大名著", "levels": 2, "parentId": 1 },
    { "categoryId": 11, "name": "科幻小说", "levels": 2, "parentId": 1 },
    { "categoryId": 12, "name": "近现代小说", "levels": 2, "parentId": 1 },
    { "categoryId": 13, "name": "古典小说", "levels": 2, "parentId": 1 }
  ]
  ```

---

## 四、购物车模块 (Cart Module)

> 注：购物车数据存储在 Session 中，未持久化到数据库或 Redis。

### 4.1 添加商品到购物车
- **Method**: GET/POST
- **Path**: `/dangdang/cart/putCart`
- **Body 实例** (query params):
  ```
  bookId=14
  ```
- **成功返回实例**:
  ```json
  {
    "status": "ok"
  }
  ```

---

### 4.2 查看购物车
- **Method**: GET
- **Path**: `/dangdang/cart/showCart`
- **Body 实例**: 无（从 Session 获取）
- **成功返回实例**:
  ```json
  {
    "buyBooks": {
      "14": {
        "bookId": 14,
        "bookName": "红楼梦",
        "dprice": 88.0,
        "price": 100.0,
        "cover": "hlm.jpg",
        "count": 2
      }
    },
    "saveMoney": 24.0,
    "totalMoney": 176.0
  }
  ```

---

### 4.3 从购物车删除商品
- **Method**: GET/POST
- **Path**: `/dangdang/cart/deleteCart`
- **Body 实例** (query params):
  ```
  bookId=14
  ```
- **成功返回实例**:
  ```json
  {
    "status": "ok"
  }
  ```

---

### 4.4 修改购物车商品数量
- **Method**: GET/POST
- **Path**: `/dangdang/cart/updateCartCount`
- **Body 实例** (query params):
  ```
  bookId=14&count=3
  ```
- **成功返回实例**:
  ```json
  {
    "status": "ok",
    "message": "修改成功"
  }
  ```

---

## 五、收货地址模块 (Address Module)

### 5.1 获取当前用户收货地址
- **Method**: GET
- **Path**: `/dangdang/address/show`
- **Body 实例**: 无（从 Session 获取用户ID）
- **成功返回实例**:
  ```json
  [
    {
      "addressId": 1,
      "name": "chenpx",
      "mobile": "13271565362",
      "province": "河南",
      "city": "郑州",
      "district": "惠济区",
      "town": "南阳路",
      "address": "升龙天汇广场",
      "userId": 1
    },
    {
      "addressId": 2,
      "name": "cpx",
      "mobile": "13271565363",
      "province": "河南",
      "city": "郑州",
      "district": "惠济区",
      "town": "南阳路",
      "address": "刘寨社区",
      "userId": 1
    }
  ]
  ```

---

## 六、订单模块 (Order Module)

### 6.1 创建订单
- **Method**: GET/POST
- **Path**: `/dangdang/order/addOrder`
- **Body 实例** (query params):
  ```
  addressId=1
  ```
- **成功返回实例**:
  ```json
  {
    "status": "ok",
    "orderId": "1523456789012345678",
    "order": {
      "orderId": 1523456789012345678,
      "total": 176.0,
      "status": "UNPAID",
      "name": "chenpx",
      "mobile": "13271565362",
      "province": "河南",
      "city": "郑州",
      "district": "惠济区",
      "town": "南阳路",
      "address": "升龙天汇广场",
      "createDate": "2026-05-30",
      "userId": 1
    }
  }
  ```
- **说明**: 创建订单时从 Session 中获取购物车内容和用户信息，生成雪花ID作为订单号，同时更新库存。

---

### 6.2 查询订单详情
- **Method**: GET
- **Path**: `/dangdang/order/getPaidOrderInfo`
- **Body 实例** (query params):
  ```
  orderId=1523456789012345678
  ```
- **成功返回实例**:
  ```json
  {
    "orderId": 1523456789012345678,
    "total": 176.0,
    "status": "PAID",
    "name": "chenpx",
    "mobile": "13271565362",
    "province": "河南",
    "city": "郑州",
    "district": "惠济区",
    "town": "南阳路",
    "address": "升龙天汇广场",
    "createDate": "2026-05-30",
    "userId": 1
  }
  ```

---

## 七、支付模块 (Payment Module)

> 注：支付模块使用原生 Servlet（`@WebServlet`），非 Spring MVC Controller。

### 7.1 发起支付宝支付
- **Method**: POST
- **Path**: `/dangdang/trade/pay`
- **Body 实例** (form-data):
  ```
  orderId=1523456789012345678&amount=176.0&subject=当当网订单&body=红楼梦 x2&userId=1
  ```
- **成功返回**: 支付宝支付页面 HTML 表单（自动跳转至支付宝收银台）

---

### 7.2 支付宝同步回调（支付完成跳转）
- **Method**: GET/POST
- **Path**: `/dangdang/trade/return`
- **说明**: 支付成功后支付宝自动回调，更新订单状态为 PAID，更新支付状态，关闭浏览器弹窗

---

### 7.3 支付宝异步通知
- **Method**: POST
- **Path**: `/dangdang/trade/notify`
- **说明**: 支付宝异步通知接口，处理支付成功后的业务逻辑

---

### 7.4 查询支付结果
- **Method**: POST
- **Path**: `/dangdang/trade/pay/query`
- **Body 实例** (form-data):
  ```
  WIDTQout_trade_no=1523456789012345678
  ```
- **成功返回**: 支付宝返回的 JSON 格式支付状态信息

---

### 7.5 关闭交易
- **Method**: POST
- **Path**: `/dangdang/trade/close`
- **Body 实例** (form-data):
  ```
  WIDTCout_trade_no=1523456789012345678
  ```
- **成功返回**: 支付宝返回的 JSON 格式关闭结果

---

### 7.6 退款
- **Method**: POST
- **Path**: `/dangdang/trade/refund`
- **Body 实例** (form-data):
  ```
  WIDTRout_trade_no=1523456789012345678&WIDTRrefund_amount=176.0&WIDTRrefund_reason=用户取消订单&WIDTRout_request_no=REQ001
  ```
- **成功返回**: 支付宝返回的 JSON 格式退款结果

---

### 7.7 查询退款结果
- **Method**: POST
- **Path**: `/dangdang/trade/refund/query`
- **Body 实例** (form-data):
  ```
  WIDRQout_trade_no=1523456789012345678&WIDRQout_request_no=REQ001
  ```
- **成功返回**: 支付宝返回的 JSON 格式退款查询结果
