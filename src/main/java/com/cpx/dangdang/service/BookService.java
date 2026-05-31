package com.cpx.dangdang.service;

import com.cpx.dangdang.entity.Book;
import com.github.pagehelper.PageInfo;

import java.util.Date;
import java.util.List;

public interface BookService{
    List<Book> selectCommentedBook();
    List<Book> selectHotSaleBook();
    List<Book> selectNewGroundingBook();
    List<Book> selectNewHotBook();
    PageInfo<Book> searchBook(String name, Integer pageNum, Integer pageSize);
    Book selectBookById(int id);
    PageInfo<Book> selectBookByCategoryId(Integer pid,Integer cid,Integer pageNum,Integer pageSize);

}
