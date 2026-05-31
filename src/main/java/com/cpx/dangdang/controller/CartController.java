package com.cpx.dangdang.controller;

import com.cpx.dangdang.entity.Book;
import com.cpx.dangdang.entity.Cart;
import com.cpx.dangdang.entity.CartItem;
import com.cpx.dangdang.entity.User;
import com.cpx.dangdang.service.BookService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("cart")
public class CartController {
    @Autowired
    private BookService bookService;

    @RequestMapping("putCart")
    public Map putCart(Integer bookId, HttpSession session){
        //从session中获取用户信息
        User user = (User) session.getAttribute("user");

        Map map = new HashMap();
        try {
            //从redis中获取购物车
            Cart cart = (Cart) session.getAttribute("cart");

            Book book = bookService.selectBookById(bookId);

            //分情况 1. 没有购物车  2. 存在购物车
            if (cart != null) {//2. 存在购物车
                Map<Integer, CartItem> buyBooks = cart.getBuyBooks();
                //1. 购物车中已经存在此书
                if (buyBooks.containsKey(bookId)) {
                    CartItem cartItem = buyBooks.get(bookId);
                    cartItem.setCount(cartItem.getCount() + 1);
                    buyBooks.put(bookId, cartItem);
                } else {//2. 购物车中没有此书
                    buyBooks.put(bookId, new CartItem(bookId, book.getBookName(), book.getDprice(), book.getPrice(), book.getCover(), 1));
                }
            } else {//1. 没有购物车
                cart = new Cart();
                Map<Integer, CartItem> buyBooks = cart.getBuyBooks();
                //1. 购买的图书
                buyBooks.put(bookId, new CartItem(bookId, book.getBookName(), book.getDprice(), book.getPrice(), book.getCover(), 1));
            }
            //通过方法计算金额
            getMoney(cart);
            session.setAttribute("cart",cart);
            map.put("status","ok");
        }catch (Exception e){
            e.printStackTrace();
            map.put("status","error");
        }

        return map;
    }

    @RequestMapping("showCart")
    public Cart showCart(HttpSession session){
        //从session中获取用户信息
        User user = (User) session.getAttribute("user");
        return (Cart) session.getAttribute("cart");
    }

    @RequestMapping("deleteCart")
    public Map deleteCart(Integer bookId,HttpSession session){
        Map map = new HashMap();
        try {
            //从session中获取用户信息
            User user = (User) session.getAttribute("user");
            Cart cart = (Cart) session.getAttribute("cart");
            Map<Integer, CartItem> buyBooks = cart.getBuyBooks();
            if (buyBooks.containsKey(bookId)) {
                //在集合中删除键值对
                buyBooks.remove(bookId);
                getMoney(cart);
                session.setAttribute("cart",new Cart());
                map.put("status","ok");
            }
        }catch (Exception e){
            e.printStackTrace();
            map.put("status","error");
        }

        return map;
    }
    //计算总金额和节省金额
    public void getMoney(Cart cart){
        Map<Integer, CartItem> buyBooks = cart.getBuyBooks();
        double totalMoney = 0.0;
        double saveMoney = 0.0;
        Collection<CartItem> values = buyBooks.values();
        for (CartItem cartItem : values) {
            Double price = cartItem.getPrice();
            Double dprice = cartItem.getDprice();
            Integer count = cartItem.getCount();
            //2. 节省金额
            saveMoney += (price - dprice) * count;
            //3. 总金额
            totalMoney += dprice * count;
        }
        cart.setSaveMoney(saveMoney);
        cart.setTotalMoney(totalMoney);
    }

    @RequestMapping("updateCartCount")
    public Map<String,String> updateCartCount(HttpSession session,int bookId,int count){
        Map<String,String> map = new HashMap<>();
        try {
            //从session中获取用户信息
            User user = (User) session.getAttribute("user");

            Cart cart = (Cart) session.getAttribute("cart");
            CartItem cartItem = cart.getBuyBooks().get(bookId);
            System.out.println("cartItem = " + cartItem);
            cartItem.setCount(count);
            getMoney(cart);

            map.put("status","ok");
            map.put("message","修改成功");
        }catch (Exception e){
            map.put("status","error");
            map.put("message","修改失败");
            e.printStackTrace();
        }
        return map;
    }
}
