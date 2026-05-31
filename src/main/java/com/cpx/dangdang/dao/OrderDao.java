package com.cpx.dangdang.dao;


import com.cpx.dangdang.entity.Order;

public interface OrderDao {
    void insertOrder(Order order);

    Order selectOrderById(Long orderId);

    void updateOrderStatus(Long orderId);


}