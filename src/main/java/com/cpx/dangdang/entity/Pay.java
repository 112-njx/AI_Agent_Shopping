package com.cpx.dangdang.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Pay implements Serializable {
    private Integer payId;
    private Long orderId;
    private Integer userId;
    private Double amount;
    private Integer payMethod;
    private Integer payStatus;
    private String comeFrom;
    private String returnUrl;
    private Date createTime;
}
