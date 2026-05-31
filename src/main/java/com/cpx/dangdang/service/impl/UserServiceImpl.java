package com.cpx.dangdang.service.impl;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.crypto.digest.HMac;
import cn.hutool.crypto.digest.HmacAlgorithm;
import com.cpx.dangdang.dao.UserDao;
import com.cpx.dangdang.entity.User;
import com.cpx.dangdang.service.UserService;
import com.cpx.dangdang.util.SendEmailUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
@Transactional
public class UserServiceImpl implements UserService {
    @Resource
    private UserDao userDao;

    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public User login(String email,String password){
        //从数据库获取盐
        User user = userDao.selectUserByEmail(email);
        if(ObjectUtil.isEmpty(user)){
            return null;
        }

        String salt = user.getSalt();
        //对输入的密码进行再次加密
        byte[] key = salt.getBytes();
        HMac mac = new HMac(HmacAlgorithm.HmacMD5, key);
        //对原始密码进行加密
        String password2 = mac.digestHex(password);
        //将数据库的加密密码和加密之后的密码进行比较
        /*if(password2.equals(user.getPassword())){
            return user;
        }*/
        return userDao.selectUserByEmailAndPassword(email, password2);
    }

    @Override
    public void register(User user) {
        User user1 = userDao.selectUserByEmail(user.getEmail());
        if(user1!=null){
            throw new RuntimeException("邮箱已存在");
        }else {
            //获取随机的6位数 盐
            String salt = RandomUtil.randomString(6);
            //对密码加密
            byte[] key = salt.getBytes();
            HMac mac = new HMac(HmacAlgorithm.HmacMD5, key);
            //对原始密码进行加密
            String password = mac.digestHex(user.getPassword());
            //将加密后的密码存入数据库中
            user.setPassword(password);
            //将盐存入数据库
            user.setSalt(salt);
            String code = RandomUtil.randomString(6);
            //将激活码存入数据库
            user.setCode(code);
            //添加
            userDao.insertUser(user);
            //发送激活码到邮箱中
            SendEmailUtil.sendCode(user.getEmail(),code);
        }
    }

    @Override
    public void validateEmail(String email, String activeCode) {
        //1. 通过email获取用户信息
        User user = userDao.selectUserByEmail(email);
        if(user!=null) {
            //2. 判断两次的激活码是否一致
            if (activeCode != null && activeCode != "" & activeCode.equals(user.getCode())) {
                //3. 将status从0改为1
                userDao.updateStatus(email);
            }else{
                throw new RuntimeException("激活码输入有误");
            }
        }else{
            throw new RuntimeException("用户不存在");
        }
    }

}
