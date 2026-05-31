package com.cpx.dangdang.service.impl;

import com.cpx.dangdang.dao.CategoryDao;
import com.cpx.dangdang.dto.CategoryDTO;
import com.cpx.dangdang.entity.Category;
import com.cpx.dangdang.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class CategoryServiceImpl implements CategoryService {
    @Autowired
    private CategoryDao categoryDao;

    @Transactional(readOnly = true,propagation = Propagation.SUPPORTS)
    @Override
    public List<CategoryDTO> selectParentCategoryWithChildCategory() {
        return categoryDao.selectParentCategoryWithChildCategory();
    }

    @Override
    public List<Category> selectCategoryByPid(int pid) {
        return categoryDao.selectCategoryByPid(pid);
    }
}
