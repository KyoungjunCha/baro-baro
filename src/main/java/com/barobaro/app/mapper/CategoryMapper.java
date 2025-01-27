package com.barobaro.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.barobaro.app.vo.CategoryVO;

@Mapper
public interface CategoryMapper {
	List<CategoryVO> allCategories();
	
}
