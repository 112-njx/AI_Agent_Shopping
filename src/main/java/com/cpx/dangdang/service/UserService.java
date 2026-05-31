package com.cpx.dangdang.service;


import com.cpx.dangdang.entity.User;

public interface UserService {
    User login(String email, String password);
    void register(User user);

    void validateEmail(String email, String activeCode);
}
