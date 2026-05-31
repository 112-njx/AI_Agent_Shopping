package com.cpx.dangdang.controller;

import com.cpx.dangdang.dto.CategoryDTO;
import com.cpx.dangdang.entity.Category;
import com.cpx.dangdang.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("category")
public class CategoryController {
    @Autowired
    private CategoryService categoryService;

    @RequestMapping("showCategory")
    public List<CategoryDTO> showCategory(){
        return categoryService.selectParentCategoryWithChildCategory();
    }

    @RequestMapping("selectCategoryByParentId")
    public List<Category> showCategoryById(int pid){
        return categoryService.selectCategoryByPid(pid);
    }
}
