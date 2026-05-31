package com.cpx.dangdang.service;


import com.cpx.dangdang.entity.Address;

import java.util.List;

public interface AddressService {
    List<Address> selectAll(Integer userId);
}
