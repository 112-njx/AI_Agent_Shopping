package com.cpx.dangdang.dao;


import com.cpx.dangdang.entity.Pay;

public interface PayDao {
    void insertPay(Pay pay);
    void updateStatus(Long orderId);
}
