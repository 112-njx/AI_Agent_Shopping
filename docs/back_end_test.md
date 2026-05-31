# 后端调试记录

## 2026-05-31：所有注解无法解析符号（@SpringBootApplication / @RestController / @Autowired 等）

### 问题现象

在 IDE（IntelliJ IDEA）中打开项目后，所有 Java 文件中的注解全部报红，提示"无法解析符号"（Cannot resolve symbol），包括但不限于：
- `@SpringBootApplication`
- `@RestController` / `@RequestMapping`
- `@Service` / `@Autowired` / `@Transactional`
- `@Data` / `@AllArgsConstructor`（Lombok）
- `@MapperScan` / `@WebServlet`

### 根本原因

**Maven 依赖未下载。** 当前系统中没有安装 Maven（执行 `mvn -v` 提示 `command not found`），所有 `pom.xml` 中声明的第三方依赖（Spring Boot、MyBatis、Lombok、支付宝 SDK 等）都没有被下载到本地 Maven 仓库（`~/.m2/repository/`）。

Java 项目中的注解类（如 `@SpringBootApplication`）来自这些 JAR 包，依赖缺失时 IDE 无法找到它们，所以全部报红。

### 解决方案

**方案一（推荐）：使用 IntelliJ IDEA 内置 Maven**

IntelliJ IDEA 自带 Maven 发行版，无需系统安装：

1. 在 IDEA 中右键点击项目根目录的 `pom.xml` → **"Add as Maven Project"**（如果已有则跳过）
2. 打开 IDEA 右侧 **Maven 工具窗口**（View → Tool Windows → Maven）
3. 点击 Maven 面板左上角的 **刷新按钮**（Reload All Maven Projects，图标为 🔄）
4. 等待 IDEA 下载所有依赖，右下角进度条走完后，所有红色报错应自动消失
5. 如果下载速度慢，在 `pom.xml` 所在目录下创建或检查 Maven 的 `settings.xml`，配置国内镜像

**方案二：命令行安装 Maven 并手动下载依赖**

```bash
# macOS
brew install maven
# Windows (使用 Chocolatey)
choco install maven
# Windows (手动)
# 从 https://maven.apache.org/download.cgi 下载，解压后添加到 PATH

# 安装后，在项目根目录执行：
cd C:\Users\112\Desktop\AI_Agent_Shopping
mvn clean compile -U
```

**方案三：如果 IDEA 内置 Maven 下载失败（部分依赖找不到）**

项目使用的 `alipay-sdk-java` 版本 `4.10.81.ALL` 较老，Maven 中央仓库可能已不包含此版本。此时会报类似以下错误：
```
Could not find artifact com.alipay.sdk:alipay-sdk-java:jar:4.10.81.ALL
```

解决办法：
1. 从阿里云 Maven 仓库镜像下载（配置 `settings.xml` 中 mirror 指向 `https://maven.aliyun.com/repository/public`）
2. 或从 `target/` 目录中查找已编译好的 JAR 包手动安装到本地仓库
3. 或升级 `pom.xml` 中支付宝 SDK 版本到最新版（如 `alipay-sdk-java` 最新稳定版）

### Maven settings.xml 镜像配置（可选但推荐）

在 `~/.m2/settings.xml`（Windows 为 `C:\Users\112\.m2\settings.xml`）中添加阿里云镜像加速下载：

```xml
<settings>
  <mirrors>
    <mirror>
      <id>aliyun</id>
      <mirrorOf>central</mirrorOf>
      <name>Aliyun Maven</name>
      <url>https://maven.aliyun.com/repository/public</url>
    </mirror>
  </mirrors>
</settings>
```

### 额外提醒：Lombok 插件

即使依赖下载成功，`@Data` 等 Lombok 注解可能仍然报错。这是因为 IntelliJ IDEA 需要额外安装 **Lombok 插件**：

1. File → Settings → Plugins → 搜索 "Lombok"
2. 安装 Lombok 插件并重启 IDEA
3. 确保 Settings → Build, Execution, Deployment → Compiler → Annotation Processors 中勾选 **"Enable annotation processing"**

---

## 2026-05-30：项目初始检查与问题修复

### 问题1：MyBatis Mapper XML 文件缺失（已修复）

**问题描述**：`src/main/resources/` 下仅有空的 `xxxMapper.xml`，所有 MyBatis 映射文件（UserMapper.xml、BookMapper.xml、CategoryMapper.xml、OrderMapper.xml、ItemMapper.xml、AddressMapper.xml、PayMapper.xml）仅存在于 `target/classes/com/cpx/dang/mapper/` 编译目录中，源码目录缺失。

**修复**：从 `target/classes/com/cpx/dang/mapper/` 下恢复全部7个 Mapper XML 文件到 `src/main/resources/com/cpx/dang/mapper/`。

**修复过程中同时处理的 bug**：
- `UserMapper.xml`：`insertUser` 原使用 `<select>` 标签，改为 `<insert>`
- `OrderMapper.xml`：原 `#{order_id}` 改为 `#{orderId}`，与 DAO 接口参数名一致

---

### 问题2：application.yml 中 mapper-locations 路径错误（已修复）

**问题描述**：原配置 `mapper-locations: com/cpx/dang/mapper/*Mapper.xml` 路径正确但源码中无对应文件。初次修复错误地改为 `classpath:xxxMapper.xml`。

**最终修复**：恢复 Mapper XML 文件后，mapper-locations 设置为 `com/cpx/dang/mapper/*Mapper.xml`，与编译目录结构一致。

---

### 问题3：CartController 中未使用的内部类导入（已修复）

**问题描述**：`CartController.java` 第8行导入了 `com.sun.xml.internal.ws.client.sei.SEIStub`，此为 JDK 内部类，不应在应用代码中使用且未被实际使用。

**修复**：删除该 import 语句。

---

### 问题4：CartController.deleteCart 疑似 Bug（待确认）

**位置**：`CartController.java` 第84行

**问题描述**：删除购物车中某商品后，执行 `session.setAttribute("cart", new Cart())` 将整个购物车替换为空购物车，而非使用更新后的 cart。
```java
buyBooks.remove(bookId);
getMoney(cart);
session.setAttribute("cart", new Cart()); // 应该是 cart，不是 new Cart()
```

**建议**：改为 `session.setAttribute("cart", cart);`

---

### 问题5：SendEmailUtil 硬编码邮箱凭证（安全风险）

**位置**：`SendEmailUtil.java`

**问题描述**：QQ 邮箱账号和授权码硬编码在代码中：
```java
public static String username = "1061349616@qq.com";
private static String password = "lwcxhklslyfpbbed";
```

**建议**：移至 `application.yml` 配置文件中，通过 `@Value` 注入。

---

### 问题6：AlipayConfig 硬编码支付宝密钥（安全风险）

**位置**：`AlipayConfig.java`

**问题描述**：支付宝 APP ID、商户私钥、支付宝公钥全部硬编码。

**建议**：移至配置文件，通过环境变量或配置中心管理。

---

### 需要用户配置的环境

1. **MySQL 数据库**：确保本地 MySQL 运行在 `localhost:3306`，创建数据库 `dangdang`，执行 `docs/dangdang.sql` 初始化表结构和数据。用户名/密码默认为 `root/root`，如有不同需修改 `application.yml`。

2. **支付宝沙箱环境**：`AlipayConfig.java` 中的 APP ID 和密钥需要替换为用户自己的支付宝沙箱账号信息。

3. **邮件服务**：`SendEmailUtil.java` 中的 QQ 邮箱和授权码需要替换。

4. **Maven 依赖**：运行 `mvn clean compile` 确保所有依赖下载成功。部分依赖（如 `alipay-sdk-java`）可能需要手动安装到本地仓库。

5. **Java 版本**：项目使用 Java 8，确保 `JAVA_HOME` 指向 JDK 8。
