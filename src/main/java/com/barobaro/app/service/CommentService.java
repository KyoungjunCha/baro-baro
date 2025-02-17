package com.barobaro.app.service;

import java.util.List;

import com.barobaro.app.vo.CommentVO;
import com.barobaro.app.vo.PostVO3;

public interface CommentService {
	
    public List<PostVO3> getAllPosts();			// 전체 게시물
    
    public PostVO3 getPostDetail(int postSeq);	// 상세 게시물
    
    
    // ---------------------------------------------- 댓글 ----------------------------------------------
    
    // 댓글 조회
    public List<CommentVO> getPostComment(int postSeq, long userSeq);
    
    // 댓글 입력
    public void commentInsert(int postSeq, Integer parentSeq, String content, long userSeq, Integer secret);
	
    // 댓글 삭제
    public boolean commentDelete(int commentSeq, long userSeq);
    
    // 댓글 수정
	public void updateComment(int commentSeq, String content, Integer secret, long userSeq);
}
