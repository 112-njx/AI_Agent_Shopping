package com.cpx.dangdang.dto;

import com.cpx.dangdang.entity.Category;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CategoryDTO extends Category {
    private List<Category> childList;//二级类别的集合

    @Override
    public String toString() {
        return "CategoryDTO{" + "category="+super.toString()+
                ", childList=" + childList +
                '}';
    }
}
