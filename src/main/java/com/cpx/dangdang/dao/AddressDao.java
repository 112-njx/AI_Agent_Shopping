package com.cpx.dangdang.dao;


import com.cpx.dangdang.entity.Address;

import java.util.List;

public interface AddressDao {
    List<Address> selectAllAddress(Integer userId);
    Address selectById(int id);
}