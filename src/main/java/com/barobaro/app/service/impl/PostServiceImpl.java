package com.barobaro.app.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.barobaro.app.service.PostService;
import com.barobaro.app.vo.PostVO;

@Service
public class PostServiceImpl implements PostService{

	@Override
	public void createPost(PostVO postVO, List<MultipartFile> files) {
		
		
	}

}
