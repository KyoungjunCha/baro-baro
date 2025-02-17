package com.barobaro.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.barobaro.app.vo.CommentVO;
import com.barobaro.app.vo.PostVO3;

@Mapper
public interface CommentMapper {

    // 게시물 전체 조회
    List<PostVO3> getAllPosts();
    
    // 게시물 상세 조회
    public PostVO3 getPostDetail(int postSeq);

    // ---------------------------------------------- 댓글 ----------------------------------------------
    
    // 댓글 조회
	public List<CommentVO> getTopLevelComments(int postSeq);	// 최상단 댓글 조회
	public List<CommentVO> getReplies(int commentSeq);			// 대댓글 조회

	// 댓글 작성자 조회
	public CommentVO getCommentBySeq(int commentSeq);	// 댓글을 commentSeq로 조회

	// 댓글 입력
	public int insertComment(CommentVO commentVO);

	// 댓글 삭제
	public void deleteAllComment(int commentSeq);	// 최상위 댓글 삭제
	public void deleteChildComment(int commentSeq);	// 하위 댓글 삭제

	// 댓글 수정
	public void updateComment(CommentVO comment);

}