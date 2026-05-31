package com.cpx.dangdang.controller;

import com.cpx.dangdang.entity.Book;
import com.cpx.dangdang.service.BookService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("book")
public class BookController {
    @Autowired
    private BookService bookService;

    @RequestMapping("listCommented")
    public List<Book> listCommentedBook(){
        return bookService.selectCommentedBook();
    }

    @RequestMapping("listHotSale")
    public List<Book> listHotSaleBook(){
        return bookService.selectHotSaleBook();
    }

    @RequestMapping("listNewGrounding")
    public List<Book> listNewGrounding(){
        return bookService.selectNewGroundingBook();
    }

    @RequestMapping("listNewSale")
    public List<Book> listNewSaleBook(){
        return bookService.selectNewHotBook();
    }

    @RequestMapping("search")
    public PageInfo<Book> search(String name,Integer pageNum,Integer pageSize){
        return bookService.searchBook(name,pageNum,pageSize);
    }

    @RequestMapping("showBook")
    public Book showBook(int bookId){
        return bookService.selectBookById(bookId);
    }

    @RequestMapping("showBookByCategoryId")
    public PageInfo<Book> selectBookByCategoryId(Integer pid,Integer cid,Integer pageNum,Integer pageSize){
        return bookService.selectBookByCategoryId(pid,cid,pageNum,pageSize);
    }


}
