package com.cpx.dangdang.controller.pay;

import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;

import java.io.FileWriter;
import java.io.IOException;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *修改日期：2017-04-05
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
 */

public class AlipayConfig {

//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

	// 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号
	public static String app_id = "9021000141639924";

	// 商户私钥，您的PKCS8格式RSA2私钥
    public static String merchant_private_key = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCxDTMcEzpp1jnCUVYgWgXL+++p75SrLplx1qESUo5rOf7ZkPagIMbihXpvdQbqW1vNBRkt7nN5H2JZPr/4gLd9KNrkla/Soq0tdktAS00818ZGbZiaBGosqUxH81AKxdjBeLLinHujAzAN5POvhWhTsFfkbzfvqmFJvS2dIAiRUNRWZNNNsbYZi6Z75kQWO4SppLHE7+HvvzJognb11GMomuUx30Y8Cw4S6hrGsMvUn2vjfRUztNbYR+LBIyK7P0vv+lDBal2swf7ZYNAroIaTzbxu2qfurIiA7idhAbMJ3DoCctoLYP4nX/U3YFm6aRaKLPw9YzVPM/5xr8RwxjThAgMBAAECggEAKV0LFsELQZSx88rq0y4U8p4OVOZLFl8RrD3XbZ9p9HUdLBko9SoTLPLAMu/lSLVFUjWht1BhG+gQIwd89AKmW5BC62ppJE2rJdbgJ8ov5koG4YdTQpBLedmnn5uhlJK6XCDlsfmbDO9+t5BIujXxtLObJRwytkRY7FBNKstEFSanobDEGs3eiRqczqjJK0ChW+I8vsz6ZOyWZ+dQWi9ftscM3FyRtCU3hDahBfDCv94B/eXS1UWpnC6+Iu5oL2pE92llMDObGLqVgY5pDnsNavyriZqarHPJ5YB8AJGTK94dRzpaihqCFPtw5JH8I+OvMrgxwK5j2wAPEY8eH6/ePQKBgQD16ZJs77epD0tXQRZIt78Zo8bw7rWoPyXUqrZAMob/C52l7U5aqQPZ3F8KfSsMF4gVXOiqFGjTdWY0OWvMi0eGGes0mHWBXoLmWNcdSdFGemrp5/suxrDENsiJzjBafNpjVkOa8+/VTkA0l7Cqo2wVevz4prOb2OaT85I9ReCpdwKBgQC4UH3VYN6oa2RXs8WRdsRNyaoLZASIvmBt1aUm1k0CGRjxBy4FMbPLIymMcMBOwEWjVsfFJCMvWIJfVTq4dC2Jt2Nz0CBk/HDZu5xuf8L6xwFNcp9lxtlmvIFiGXzdMy66tgWmpcucl7Cd3NmfYAYy3Ik9pH6Is7/2rfcCqi+qZwKBgQCRNYJkV01BRCm99U4eVHpAvqgb3ylflyJUqRWDZRK4CfjmYPGysTj37ZwlinHf6wlNbBZrUC/yJdHbJskT+G6crjNoVFqWsONk97LWtZ8hGeqGApkdLvB0fNEAJsQAutcOb4LuPfsyHsnlBGmq6WNKb9xvS6ilb3gAh4SkL94Q0wKBgGcNCe3dhWAg+y9V4eacwtDDKgHIYAiceImwY/A87T15DsrkOsTIrz+qXzaYa80cD1Nt16/PrqRwFiR7IKO0wSk4kbBU82fDBM2X6bSWVkukLIRCzAA5l5+rUaOpoHiEf2IBF1O/awIYhbUdn8dOBuk1CL6gU+bWqUOgrHSe9puNAoGAbyrT8jx7aMbaK9Z8mwK8znWE7yabG2R28Kjy/5Z+Tz4xPrBrpiKFF9aiQwqnisXu4k/z7c4nMHRTRVOwyHqq8Fmj1z57wl+0sAg+kNSrhvvDlgqGU1tYIEFbgl2pnyw6Og7oC8SpCyJd/q/g7FpPbuzbOapmFCT6rEAx+FYFeBY=";
	// 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
    public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqrF+jpatmDO55Okjzi5bKPFvf0Bv+HjEUrGqkDFwWAJwSNcwOqsISnGtWDCC61RN0ZBep5DFy/Czbce85FvWQXWKLhF0pO13DZpn5z8+Y77US9UMYSp6EyRr8pr1ZtAHkG+FqBj7NQJhHPIiJ81filXJAhEEK+XsJMayUMlCFWhcQ5rAO3/WlEcW9IHAOa2DqY7pE6V/XbnkbG3Y566eBa3CIf3A7ONnCpw4GOQbTiUP+VNkHfEmHWGAnI3NpsjARx92+WD8WSb8XaDyZ9b5ggDdGW9YVH4gqV+YlcE06MmnQmoYtiD/3xe1e/4n9Skhnru/GCUVmtTf9EwYLQLFbQIDAQAB";
	// 服务器异步通知页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
//	public static String notify_url = "http://localhost:8080/alipay/notify_url.jsp";
	public static String notify_url = "http://s3685996.natappfree.cc/dangdang/trade/notify";

	// 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
//	public static String return_url = "http://localhost:8080/alipay/return_url.jsp";
    public static String return_url = "http://localhost:8989/dangdang/trade/return";

	// 签名方式
	public static String sign_type = "RSA2";

	// 字符编码格式
	public static String charset = "utf-8";

	// 支付宝网关
	// 请求网关地址  真实环境网关：https://openapi.alipay.com/gateway.do
	//	         沙箱环境网关：https://openapi-sandbox.dl.alipaydev.com/gateway.do
	public static String gatewayUrl = "https://openapi-sandbox.dl.alipaydev.com/gateway.do";

	 //获得初始化的AlipayClient
    public static AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id, AlipayConfig.merchant_private_key, "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);
	// 日志记录目录
	public static String log_path = "C:\\";


//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

    /**
     * 写日志，方便测试（看网站需求，也可以改成把记录存入数据库）
     * @param sWord 要写入日志里的文本内容
     */
    public static void logResult(String sWord) {
        FileWriter writer = null;
        try {
            writer = new FileWriter(log_path + "alipay_log_" + System.currentTimeMillis()+".txt");
            writer.write(sWord);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

