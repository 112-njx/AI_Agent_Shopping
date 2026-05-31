package com.cpx.dangdang.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User implements Serializable {
    private Integer userId;

    private String email;

    private String password;

    private String salt;

    private String nickname;

    private Integer status;

    private String code;

    private Date createDate;
}