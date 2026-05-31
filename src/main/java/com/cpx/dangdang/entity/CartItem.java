package com.cpx.dangdang.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartItem {
    private Integer bookId;
    private String bookName;
    private Double dprice;
    private Double price;
    private String cover;
    private Integer count;
}
