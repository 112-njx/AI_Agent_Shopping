package com.cpx.dangdang.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Book implements Serializable {
    private Integer bookId;

    private String bookName;

    private String author;

    private String cover;

    private String press;

    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT=+8")
    private Date pressDate;

    private String edition;

    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT=+8")
    private Date printDate;

    private String impression;

    private String isbn;

    private Integer wordNum;

    private Integer pageNum;

    private String sizes;

    private String paper;

    private String pack;

    private Double price;

    private Double dprice;

    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "Asia/Shanghai")
    private Date createDate;

    private String director;

    private String mediaCommentary;

    private Integer categoryId;

    private Integer sale;

    private Integer stock;

    private String editorRecommend;

    private String contentAbstract;

    private String authorAbstract;

}