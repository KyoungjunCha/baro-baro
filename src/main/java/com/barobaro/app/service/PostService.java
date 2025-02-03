package com.barobaro.app.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.barobaro.app.vo.PostVO;

public interface PostService {
	void createPost(PostVO postVO, List<MultipartFile> files);
	PostVO getPostByPostSeq(long postSeq);
	List<PostVO> getPostBySearchCondition(String searchKeyword, String searchType, int categorySeq, String availableOnly, Double latitude, Double longitude);
}
