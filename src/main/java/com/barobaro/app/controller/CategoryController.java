package com.barobaro.app.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.barobaro.app.service.CategoryService;
import com.barobaro.app.vo.CategoryVO;

@RestController
public class CategoryController {
	@Autowired
	private CategoryService service;
	
	@RequestMapping(value = "/categories", method = RequestMethod.GET)
	public ResponseEntity<List<CategoryVO>> getAllCategories() {
		List<CategoryVO> list = service.getAllCategoryNameAndSeq();
		return ResponseEntity.ok(list);
	}
}
