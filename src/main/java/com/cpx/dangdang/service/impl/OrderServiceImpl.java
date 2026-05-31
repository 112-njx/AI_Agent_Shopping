package com.cpx.dangdang.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.IdUtil;
import com.cpx.dangdang.dao.AddressDao;
import com.cpx.dangdang.dao.BookDao;
import com.cpx.dangdang.dao.ItemDao;
import com.cpx.dangdang.dao.OrderDao;
import com.cpx.dangdang.entity.*;
import com.cpx.dangdang.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.Map;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {
    @Autowired
    private AddressDao addressDao;
    @Autowired
    private OrderDao orderDao;
    @Autowired
    private ItemDao itemDao;
    @Autowired
    private BookDao bookDao;

    @Override
    public Order saveOrder(Integer addressId) {
        HttpSession session = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
        //获取session
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        Cart cart = (Cart) requestAttributes.getAttribute("cart", RequestAttributes.SCOPE_SESSION);//从session作用域获取数据
        User user = (User) requestAttributes.getAttribute("user", RequestAttributes.SCOPE_SESSION);

        //添加订单
        Order order = new Order();
        //获取id
        long id = IdUtil.getSnowflake(1, 1).nextId();
        order.setOrderId(id);
        order.setTotal(cart.getTotalMoney());
        order.setStatus("UNPAID");//默认值:未支付  已支付  未发货  已发货
        order.setCreateDate(new Date());
        order.setUserId(user.getUserId());

        //获取地址信息  将地址信息逐个存入order中
        Address address = addressDao.selectById(addressId);
        /*
            order.setName(address.getName());
            order.setMobile(address.getMobile);
            .....
        */
        //将address对象中的属性赋值给order  忽略掉userId
        BeanUtil.copyProperties(address,order,"userId");

        System.out.println("order = " + order);

        //添加order信息到数据库
        orderDao.insertOrder(order);

        //添加订单详情
        Map<Integer, CartItem> buyBooks = cart.getBuyBooks();
        //CartItem  bookId  bookName .... count
        for (CartItem it : buyBooks.values()) {
            Integer bookId = it.getBookId();
            Integer count = it.getCount();
            Item item = new Item();
            item.setBookId(bookId);
            item.setCount(count);
            item.setCreateDate(new Date());
            item.setOrderId(order.getOrderId());
            //将订单详情添加到表中
            itemDao.insertItem(item);//问题：性能差  解决：批量插入  mapper文件中使用forEach标签

            //更新图书的库存
            Book book = bookDao.selectBookById(bookId);
            bookDao.updateCount(bookId,book.getStock()-count);
        }

        //清空购物车
        session.setAttribute("cart",new Cart());
        return order;
    }

    @Override
    public Order selectOrderById(Long orderId) {
        return orderDao.selectOrderById(orderId);
    }

    @Override
    public void updateOrderStatus(Long orderId) {
        orderDao.updateOrderStatus(orderId);
    }
}
