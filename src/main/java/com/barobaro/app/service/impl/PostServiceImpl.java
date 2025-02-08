package com.barobaro.app.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.barobaro.app.mapper.PostMapper;
import com.barobaro.app.service.PostService;
import com.barobaro.app.vo.PostFileVO;
import com.barobaro.app.vo.PostVO;
import com.barobaro.app.vo.ReviewVO;
import com.barobaro.app.vo.SearchVO;

@Service
public class PostServiceImpl implements PostService{
	
	@Autowired
	PostMapper postMapper;
	
	@Override
	public void createPost(PostVO postVO, List<MultipartFile> files) {
		
		postMapper.insertPostByPostVO(postVO);
		postVO.getRentTimes().forEach(e -> {
			e.setPost_seq((int)postVO.getPostSeq());
			postMapper.insertRentTimeSlotByRentTimeSlotVO(e);
		});
		
		
		try {
			String baseDirectoryPath = "c:/uploads/post/";  // 기본 디렉토리 경로
			
			for(MultipartFile file : files) {
				String originalFileName = file.getOriginalFilename();
				if (originalFileName != null && !originalFileName.isEmpty()) {
					// UUID로 디렉토리 이름 생성
					String uuidDirectoryName = UUID.randomUUID().toString();
					
					// 디렉토리 경로 설정 (UUID 디렉토리 생성)
					File directory = new File(baseDirectoryPath + uuidDirectoryName);
					
					// 디렉토리가 없으면 생성
					if (!directory.exists()) {
						directory.mkdirs();
					}

					// 파일을 UUID 디렉토리에 원본 파일 이름으로 저장
					File destFile = new File(directory.getAbsolutePath() + File.separator + originalFileName);

					// 파일 저장
					file.transferTo(destFile);
					
					postVO.getPostImages().add(PostFileVO.builder()
							.name(originalFileName)
							.storagePath(destFile.getAbsolutePath())
							.postSeq(postVO.getPostSeq())
							.build());
				} else {
					throw new IOException("파일이 비어 있습니다.");
				}
			}
		} catch (IllegalStateException | IOException e) {
			System.out.println("게시물 저장 중 에러 발생: " + e.getMessage());
		}
		
		postVO.getPostImages().forEach(e->
			postMapper.insertPostFileByPostFileVO(e)
		);
		
	}

	@Override
	public PostVO getPostByPostSeq(long postSeq) {
		if(postMapper.incrementPostViewCount(postSeq) != 1) {
			throw new RuntimeException("뭐여");
		}
		return postMapper.selectPostByPostSeq(postSeq);
	}

	@Override
	public List<PostVO> getPostBySearchCondition(SearchVO searchVO) {
		return postMapper.selectPostBySearchCondition(searchVO);
	}

	@Override
	public void updatePost(PostVO postVO, List<MultipartFile> files) {
		postMapper.updatePostByPostVO(postVO);
		postVO.getRentTimes().forEach(e -> {
			e.setPost_seq((int)postVO.getPostSeq());
			postMapper.insertRentTimeSlotByRentTimeSlotVO(e);
		});
		
		if(postVO.getPostImages() == null || postVO.getPostImages().size() == 0) return;
		postMapper.deletePostFileByPostSeq(postVO.getPostSeq());
		try {
			String baseDirectoryPath = "c:/uploads/post/";  // 기본 디렉토리 경로
			
			for(MultipartFile file : files) {
				String originalFileName = file.getOriginalFilename();
				if (originalFileName != null && !originalFileName.isEmpty()) {
					// UUID로 디렉토리 이름 생성
					String uuidDirectoryName = UUID.randomUUID().toString();
					
					// 디렉토리 경로 설정 (UUID 디렉토리 생성)
					File directory = new File(baseDirectoryPath + uuidDirectoryName);
					
					// 디렉토리가 없으면 생성
					if (!directory.exists()) {
						directory.mkdirs();
					}

					// 파일을 UUID 디렉토리에 원본 파일 이름으로 저장
					File destFile = new File(directory.getAbsolutePath() + File.separator + originalFileName);

					// 파일 저장
					file.transferTo(destFile);
					
					postVO.getPostImages().add(PostFileVO.builder()
							.name(originalFileName)
							.storagePath(destFile.getAbsolutePath())
							.postSeq(postVO.getPostSeq())
							.build());
				} else {
					throw new IOException("파일이 비어 있습니다.");
				}
			}
		} catch (IllegalStateException | IOException e) {
			System.out.println("게시물 저장 중 에러 발생: " + e.getMessage());
		}
		
		postVO.getPostImages().forEach(e->
			postMapper.insertPostFileByPostFileVO(e)
		);
	}

	@Override
	public void createReview(ReviewVO reviewVO, long userSeq) {
		postMapper.insertReview(reviewVO, userSeq);
		if(reviewVO.getUserReview() == null || reviewVO.getUserReview().size() == 0) return ;
		reviewVO.getUserReview().forEach(e -> {
			postMapper.insertReviewDetail(e, reviewVO.getReviewSeq());
		});
		
	}
	
	
}
