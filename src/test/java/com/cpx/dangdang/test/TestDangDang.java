package com.cpx.dangdang.test;

import com.cpx.dangdang.dao.UserDao;
import com.cpx.dangdang.entity.Book;
import com.cpx.dangdang.entity.Cart;
import com.cpx.dangdang.entity.CartItem;
import com.cpx.dangdang.entity.Order;
import com.cpx.dangdang.entity.User;
import com.cpx.dangdang.service.*;
import com.github.pagehelper.PageInfo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

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
        user.setEmail("t" + System.currentTimeMillis() / 1000 + "@q.com");
        user.setCode("122343");
        user.setSalt("1234");
        user.setNickname("testuser");
        user.setCreateDate(new Date());
        user.setStatus(0);
        user.setPassword("123456");
        userService.register(user);
        System.out.println("注册成功");
    }

    @Autowired
    private UserDao userDao;

    @Test
    public void testValidateEmail(){
        // 先注册新用户
        User user = new User();
        String email = "v" + System.currentTimeMillis() / 1000 + "@q.com";
        user.setEmail(email);
        user.setPassword("123456");
        user.setSalt("1234");
        user.setNickname("validatetest");
        user.setCreateDate(new Date());
        user.setStatus(0);
        user.setCode("tmp");
        userService.register(user);
        // register() 内部会用随机码覆盖 code，需从数据库读取真实激活码
        User dbUser = userDao.selectUserByEmail(email);
        userService.validateEmail(email, dbUser.getCode());
        System.out.println("激活成功");
    }


    @Autowired
    private OrderService orderService;

    @Test
    public void testSaveOrder(){
        // 构造 mock HTTP session，因为 saveOrder 依赖从 session 获取购物车和用户
        MockHttpSession session = new MockHttpSession();
        User user = new User();
        user.setUserId(1);
        user.setEmail("xiaobai@qq.com");
        session.setAttribute("user", user);

        Cart cart = new Cart();
        cart.getBuyBooks().put(14, new CartItem(14, "红楼梦", 88.0, 100.0, "hlm.jpg", 1));
        cart.setTotalMoney(88.0);
        cart.setSaveMoney(12.0);
        session.setAttribute("cart", cart);

        MockHttpServletRequest request = new MockHttpServletRequest();
        request.setSession(session);
        RequestContextHolder.setRequestAttributes(new ServletRequestAttributes(request));

        Order order = orderService.saveOrder(1);
        System.out.println("order = " + order);
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
