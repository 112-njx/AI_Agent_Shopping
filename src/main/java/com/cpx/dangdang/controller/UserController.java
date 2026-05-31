package com.cpx.dangdang.controller;

import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.LineCaptcha;
import com.cpx.dangdang.entity.User;
import com.cpx.dangdang.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("login")
    public Map login(String email, String password, HttpSession session){
        User user = userService.login(email, password);
        Map map = new HashMap<>();
        if(user!=null){
            map.put("status","ok");
            map.put("message","登录成功！");
            session.setAttribute("user",user);
        }else{
            map.put("status","error");
            map.put("message","登录失败！");
        }
        return map;
    }

    @RequestMapping("register")
    public Map register(String email,String password,String nickname,HttpSession session,String code){
        String imageCode = (String) session.getAttribute("code");
        System.out.println("imageCode = " + imageCode);
        System.out.println("code = " + code);
        Map map = new HashMap();
        if(imageCode!="" && imageCode!=null && imageCode.equals(code)){
            try {
                User user = new User(null,email,password,"",nickname,0,"",null);
                userService.register(user);
                session.setAttribute("user",user);
                map.put("status","ok");
                map.put("message","注册成功！");
            }catch (Exception e){
                map.put("status","error");
                map.put("message","邮箱已存在！");
            }
        }else{
            map.put("status","errorCode");
            map.put("message","验证码输入有误！");
        }
        return map;
    }

    @RequestMapping("validateEmail")
    public Map validateEmail(String email,String activeCode){
        Map map = new HashMap();
        try {
            userService.validateEmail(email, activeCode);
            map.put("status","ok");
            map.put("message","激活成功");
        }catch (Exception e){
            e.printStackTrace();
            map.put("status","error");
            map.put("message","激活失败");
        }
        return map;
    }

    @RequestMapping("showUser")
    public User showUser(HttpSession session){
        User user = (User) session.getAttribute("user");
        return user;
    }

    @RequestMapping("validateCode")
    public void validateCode(HttpSession session, HttpServletResponse response) throws IOException {
        //参数1：宽度  参数2：高度  参数3：验证码数量  参数4：干扰线数量
        LineCaptcha lineCaptcha = CaptchaUtil.createLineCaptcha(200, 35, 4, 4);

        //获取图片中的验证码
        String code = lineCaptcha.getCode();
        System.out.println("code = " + code);
        //将验证码存入session作用域
        session.setAttribute("code",code);

        OutputStream os = response.getOutputStream();

        //使用工具将验证码响应到浏览器
        lineCaptcha.write(os);
    }
}
