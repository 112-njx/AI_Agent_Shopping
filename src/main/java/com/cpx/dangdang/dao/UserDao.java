package com.cpx.dangdang.dao;

import com.cpx.dangdang.entity.User;
import org.apache.ibatis.annotations.Param;

public interface UserDao {
    User selectUserByEmailAndPassword(@Param("email") String email, @Param("password") String password);
    void insertUser(User user);
    User selectUserByEmail(String email);

    void updateStatus(String email);
}