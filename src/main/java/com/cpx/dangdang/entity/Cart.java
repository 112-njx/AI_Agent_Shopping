package com.cpx.dangdang.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.LinkedHashMap;
import java.util.Map;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Cart {
    private Map<Integer,CartItem> buyBooks = new LinkedHashMap<>();
    private Double saveMoney;
    private Double totalMoney;
}
