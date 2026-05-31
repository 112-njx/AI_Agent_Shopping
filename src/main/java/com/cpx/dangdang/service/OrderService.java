package com.cpx.dangdang.service;


import com.cpx.dangdang.entity.Order;

public interface OrderService {
    Order saveOrder(Integer addressId);

    Order selectOrderById(Long orderId);

    void updateOrderStatus(Long orderId);
}
