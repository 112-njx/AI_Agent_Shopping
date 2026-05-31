package com.cpx.dangdang.controller;

import com.cpx.dangdang.entity.Order;
import com.cpx.dangdang.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("order")
public class OrderController {
    @Autowired
    private OrderService orderService;

    @RequestMapping("addOrder")
    public Map addOrder(Integer addressId){
        Map map = new HashMap();
        try {
            Order order = orderService.saveOrder(addressId);
            map.put("status","ok");
            map.put("orderId",order.getOrderId()+"");
            map.put("order",order);
        }catch (Exception e){
            e.printStackTrace();
            map.put("status","error");
        }
        return map;
    }

    @RequestMapping("getPaidOrderInfo")
    public Order getPaidOrderInfo(Long orderId){
        return orderService.selectOrderById(orderId);
    }


}
