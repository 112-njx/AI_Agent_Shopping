package com.cpx.dangdang.service;


import com.cpx.dangdang.entity.Pay;

public interface PayService {
    void savePay(Pay pay);
    void updateStatus(Long orderId);
}
