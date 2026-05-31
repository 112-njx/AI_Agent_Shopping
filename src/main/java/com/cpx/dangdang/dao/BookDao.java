package com.cpx.dangdang.dao;

import com.cpx.dangdang.entity.Book;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface BookDao {
    List<Book> selectCommentedBook();
    List<Book> selectHotSaleBook();
    List<Book> selectNewGroundingBook(Date time);
    List<Book> selectNewHotBook(Date time);
    List<Book> searchBook(String name);
    Book selectBookById(int id);

    List<Book> selectBookByCategoryId(@Param("pid") Integer pid,@Param("cid") Integer cid);
    void updateCount(@Param("bookId") int bookId,@Param("count") int count);
}