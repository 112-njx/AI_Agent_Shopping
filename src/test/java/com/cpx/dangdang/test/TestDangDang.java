package com.cpx.dangdang.test;

import com.cpx.dangdang.DangDangApplication;
import com.cpx.dangdang.entity.Book;
import com.cpx.dangdang.entity.Order;
import com.cpx.dangdang.entity.User;
import com.cpx.dangdang.service.*;
import com.github.pagehelper.PageInfo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.Date;

@RunWith(SpringRunner.class)
@SpringBootTest
public class TestDangDang {
    @Autowired
    private BookService bookService;

    @Test
    public void testSelectCommentedBook(){
        bookService.selectCommentedBook().forEach(System.out::println);
    }

    @Test
    public void testSearchBook(){
        PageInfo<Book> pageInfo = bookService.searchBook("上课", 1, 3);
        pageInfo.getList().forEach(System.out::println);
    }

    @Test
    public void testSelectBookById(){
        Book book = bookService.selectBookById(1);
        System.out.println("book = " + book);
    }

    @Test
    public void testSelectBookByCategoryId(){
        PageInfo<Book> pageInfo = bookService.selectBookByCategoryId(1, null, 1, 3);
        pageInfo.getList().forEach(System.out::println);
    }

    @Autowired
    private CategoryService categoryService;

    @Test
    public void testSelectParentCategoryWithChildCategory(){
        categoryService.selectParentCategoryWithChildCategory().forEach(System.out::println);
    }

    @Autowired
    private UserService userService;

    @Test
    public void testLogin(){
        System.out.println(userService.login("cpx@qq.com", "123456"));
    }

    @Test
    public void testRegister(){
        User user = new User();
        user.setEmail("cpx@qq.com");
        user.setCode("122343");
        user.setSalt("1234");
        user.setNickname("cpx");
        user.setCreateDate(new Date());
        user.setStatus(0);
        user.setPassword("123456");
        userService.register(user);
    }

    @Test
    public void testValidateEmail(){
        userService.validateEmail("cpx@qq.com","tl0v6a");
    }


    @Autowired
    private OrderService orderService;

    @Test
    public void testSaveOrder(){
        Order order = orderService.saveOrder(1);

    }

    @Test
    public void testSelectOrderById(){
        Order order = orderService.selectOrderById(3L);
        System.out.println("order = " + order);
    }

    @Test
    public void testUpdateOrderStatus(){
        orderService.updateOrderStatus(3L);
    }
}
