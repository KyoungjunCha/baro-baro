package com.barobaro.app.service;

import java.util.List;

import com.barobaro.app.vo.CategoryVO;

public interface CategoryService {
	List<CategoryVO> getAllCategoryNameAndSeq();
}
