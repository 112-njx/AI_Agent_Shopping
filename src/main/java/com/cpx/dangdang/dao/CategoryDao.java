package com.cpx.dangdang.dao;

import com.cpx.dangdang.dto.CategoryDTO;
import com.cpx.dangdang.entity.Category;

import java.util.List;

public interface CategoryDao {
    List<CategoryDTO> selectParentCategoryWithChildCategory();

    List<Category> selectCategoryByPid(int pid);
}