package com.cpx.dangdang.service;


import com.cpx.dangdang.dto.CategoryDTO;
import com.cpx.dangdang.entity.Category;

import java.util.List;

public interface CategoryService {
    List<CategoryDTO> selectParentCategoryWithChildCategory();

    List<Category> selectCategoryByPid(int pid);
}
