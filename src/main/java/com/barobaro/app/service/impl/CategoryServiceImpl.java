package com.barobaro.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.barobaro.app.mapper.CategoryMapper;
import com.barobaro.app.service.CategoryService;
import com.barobaro.app.vo.CategoryVO;

@Service
public class CategoryServiceImpl implements CategoryService{

	@Autowired
	CategoryMapper categoryMapper;
	
	@Override
	public List<CategoryVO> getAllCategoryNameAndSeq() {
		return categoryMapper.allCategories();
	}

}
