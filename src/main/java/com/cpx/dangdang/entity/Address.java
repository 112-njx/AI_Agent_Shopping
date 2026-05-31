package com.cpx.dangdang.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Address implements Serializable {
    private Integer addressId;

    private String name;

    private String mobile;

    private String province;

    private String city;

    private String district;

    private String town;

    private String address;

    private Integer userId;

}