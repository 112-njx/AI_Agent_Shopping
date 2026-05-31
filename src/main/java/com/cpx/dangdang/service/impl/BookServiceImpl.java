package com.cpx.dangdang.service.impl;

import com.cpx.dangdang.dao.BookDao;
import com.cpx.dangdang.entity.Book;
import com.cpx.dangdang.service.BookService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@Transactional
public class BookServiceImpl implements BookService {
    @Autowired
    private BookDao bookDao;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public List<Book> selectCommentedBook() {
        return bookDao.selectCommentedBook();

    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public List<Book> selectHotSaleBook() {
        return bookDao.selectHotSaleBook();
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public List<Book> selectNewGroundingBook() {
        Date time = new Date(new Date().getTime() - 30L * 24 * 60 * 60 * 1000);
        return bookDao.selectNewGroundingBook(time);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public List<Book> selectNewHotBook() {
        Date time = new Date(new Date().getTime() - 30L * 24 * 60 * 60 * 1000);
        return bookDao.selectNewHotBook(time);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public PageInfo<Book> searchBook(String name, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<Book> books = bookDao.searchBook(name);

        PageInfo<Book> pageInfo = new PageInfo<>(books);

        return pageInfo;
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public Book selectBookById(int id) {
        return bookDao.selectBookById(id);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public PageInfo<Book> selectBookByCategoryId(Integer pid,Integer cid, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<Book> books = bookDao.selectBookByCategoryId(pid,cid);

        PageInfo<Book> pageInfo = new PageInfo<>(books);
        return pageInfo;
    }
}
