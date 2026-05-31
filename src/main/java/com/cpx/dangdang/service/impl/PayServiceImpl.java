package com.cpx.dangdang.service.impl;

import com.cpx.dangdang.dao.PayDao;
import com.cpx.dangdang.entity.Pay;
import com.cpx.dangdang.service.PayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class PayServiceImpl implements PayService {
    @Autowired
    private PayDao payDao;
    @Override
    public void savePay(Pay pay) {
        payDao.insertPay(pay);
    }

    @Override
    public void updateStatus(Long orderId) {
        payDao.updateStatus(orderId);
    }
}
