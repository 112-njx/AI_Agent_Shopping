package com.cpx.dangdang.service.impl;

import com.cpx.dangdang.dao.AddressDao;
import com.cpx.dangdang.entity.Address;
import com.cpx.dangdang.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class AddressServiceImpl implements AddressService {
    @Autowired
    private AddressDao addressDao;
    @Override
    @Transactional(readOnly = true,propagation = Propagation.SUPPORTS)
    public List<Address> selectAll(Integer userId) {
        return addressDao.selectAllAddress(userId);
    }
}
