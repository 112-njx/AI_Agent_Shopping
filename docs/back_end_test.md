# 后端调试记录

## 2026-05-31：测试错误修复

**现象**：3 个测试失败（testRegister、testSaveOrder、testValidateEmail）

**原因与修复**：
1. `testRegister`：邮箱 `varchar(20)` 超限 → 缩短为 `"t" + ts/1000 + "@q.com"`
2. `testSaveOrder`：缺少 HTTP session → 用 `MockHttpSession` + `MockHttpServletRequest` 模拟
3. `testValidateEmail`：注册时会覆盖外部传入的 code → 注册后用 `userDao.selectUserByEmail()` 读取真实 code

---

## 2026-05-31：项目启动失败

**需用户检查**：
1. MySQL 必须运行在 `localhost:3306`，数据库 `dangdang` 已创建，已执行 `docs/dangdang.sql`
2. 端口 `8989` 未被占用
3. `JAVA_HOME` 环境变量需指向 JDK 23 安装路径

---

## 2026-05-31：Maven 编译"找不到符号"（已修复）

**原因**：JDK 23 下 Lombok 注解处理器不自动生效；`javax.annotation.Resource` 在 JDK 11+ 中被移除。

**修复**：
- `pom.xml`：配置 `maven-compiler-plugin` 的 `annotationProcessorPaths` 指向 Lombok；新增 `javax.annotation-api` 依赖
- `UserServiceImpl.java`：`@Resource` → `@Autowired`
- `~/.m2/settings.xml`：添加阿里云镜像

---

## 2026-05-30：Mapper XML 缺失与路径错误（已修复）

**原因**：7 个 Mapper XML 仅存于 `target/`，源码目录缺失。

**修复**：从 `target/` 恢复到 `src/main/resources/com/cpx/dang/mapper/`；修正 `application.yml` 的 mapper 路径。

**同步修复的 bug**：
- `UserMapper.xml`：`<select>` → `<insert>`
- `OrderMapper.xml`：`#{order_id}` → `#{orderId}`
- `CartController.java`：删除未使用的 `com.sun.*` 内部类导入
