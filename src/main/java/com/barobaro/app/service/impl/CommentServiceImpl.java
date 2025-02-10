package com.barobaro.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.barobaro.app.mapper.CommentMapper;
import com.barobaro.app.service.CommentService;
import com.barobaro.app.vo.CommentVO;
import com.barobaro.app.vo.PostVO3;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentMapper commentMapper;
    
    // 게시물 전체 조회
    @Override
    public List<PostVO3> getAllPosts() {
    	System.out.println("CommentServiceImpl getAllPosts 출력 테스트");
        return commentMapper.getAllPosts();
    }

    // 게시물 상세 조회
    @Override
    public PostVO3 getPostDetail(int postSeq) {
    	System.out.println("PostServiceImpl getPostDetail 호출 : 게시물 상세 조회");
    	
    	PostVO3 postVO = commentMapper.getPostDetail(postSeq);
    	System.out.println(postVO.toString());
    	
        return postVO;
    }

    // ---------------------------------------------- 댓글 ----------------------------------------------
    // 댓글 상세 조회
    @Override
	public List<CommentVO> getPostComment(int postSeq, long userSeq) {
	    System.out.println("PostServiceImpl getPostComment 호출 : 댓글 상세 조회");
	    
	    // 게시물 정보 조회 (게시물 작성자 정보 포함)
	    PostVO3 postVO = commentMapper.getPostDetail(postSeq);  // 게시물의 상세 정보 조회
	    int postAuthorSeq = postVO.getUserSeq();  // 게시물 작성자의 userSeq 가져오기

	    // 게시물에 달린 최상위 댓글들 조회
	    List<CommentVO> topComment = commentMapper.getTopLevelComments(postSeq);  // 최상위 댓글 목록 가져오기

	    // 각 최상위 댓글에 대해 대댓글을 처리
	    for (CommentVO comment : topComment) {
	        List<CommentVO> replies = commentMapper.getReplies(comment.getCommentSeq());  // 해당 댓글에 달린 대댓글 조회

	        // 대댓글에 대해 비밀글 처리 추가
	        for (CommentVO reply : replies) {
	        	System.out.println("comment.getUserSeq() : " + comment.getUserSeq());	// 댓글 등록자 		: 2
	        	System.out.println("postAuthorSeq : " + postAuthorSeq);					// 게시글 등록자		: 1
	        	System.out.println("userSeq : " + userSeq);								// 현재 로그인한 사용자 	: 1
	        	System.out.println("comment.getContent() : " + comment.getContent());	// 댓글 내용			: hi
	        	System.out.println("comment.getContent() : " + comment.getNickname());
	            // 대댓글이 비밀글인지 확인 (secret이 1이면 비밀글)
	            if (reply.getSecret() == 1) {
	                // 대댓글의 작성자나 게시물 작성자만 비밀글을 볼 수 있도록 처리
	                boolean canViewSecret = (reply.getUserSeq() == userSeq || postAuthorSeq == userSeq);
	                reply.setCanViewSecret(canViewSecret);  // 비밀글 여부 설정
	            }
	        }
	        
	        // 해당 최상위 댓글에 대댓글 목록을 설정
	        comment.setReplies(replies);
	        
	        // 최상위 댓글에 대한 비밀글 처리
	        if (comment.getSecret() == 1) {  // 댓글이 비밀글인 경우
	            // 댓글 작성자나 게시물 작성자만 비밀글을 볼 수 있도록 처리
	            boolean canViewSecret = (comment.getUserSeq() == userSeq || postAuthorSeq == userSeq);
	            comment.setCanViewSecret(canViewSecret);  // 비밀글 여부 설정
	        }
	    }
	    
	    // 최종적으로 게시물에 달린 댓글 목록을 반환
	    System.out.println("게시물에 달린 댓글 목록 : " + topComment + "건 출력");
	    return topComment;  // 댓글 목록 반환
	}

	    
	// 댓글 입력
	@Override
	public void commentInsert(int postSeq, Integer parentSeq, String content, long userSeq, Integer secret) {
		System.out.println("PostServiceImpl commentInsert 호출 : 댓글 입력");

	    // CommentVO 객체 생성 및 설정
	    CommentVO comment = new CommentVO();
	    comment.setPostSeq(postSeq);
	    comment.setParentSeq(parentSeq);  // 0이면 최상위 댓글, 그렇지 않으면 대댓글
	    comment.setContent(content);
	    comment.setUserSeq(userSeq);
	    comment.setSecret(secret);

	    //System.out.println("getParentSeq : " + comment.getParentSeq());

	    // DB에 댓글 입력
	    int row = commentMapper.insertComment(comment);
	    System.out.println("댓글 " + row + "건 입력");
		
	}
	

	// 댓글 삭제 처리 (상위 댓글 및 하위 댓글 포함)
	@Override
    public boolean commentDelete(int commentSeq, long userSeq) {
    	System.out.println("PostServiceImpl deleteComment 호출 : 댓글 삭제");
	
		// 댓글 작성자 확인
        CommentVO commentVO = commentMapper.getCommentBySeq(commentSeq);
        System.out.println("댓글 작성자 확인 : " + commentVO.getUserSeq());
        System.out.println("getCommentSeq : " + commentVO.getCommentSeq());
        
        if (commentVO != null && commentVO.getUserSeq() == userSeq) {
        	
        	// 댓글이 상위 댓글일 경우 하위 댓글도 삭제 상태로 변경
            if (commentVO.getParentSeq() == null) {  		// 상위 댓글인 경우
            	System.out.println("최상위댓글 삭제");
            	commentMapper.deleteAllComment(commentSeq);  	// 하위 댓글 모두 삭제
            } else {  										// 대댓글인 경우
            	System.out.println("하위댓글 삭제");
            	commentMapper.deleteChildComment(commentSeq);  // 대댓글만 삭제 상태로 변경
            }
            return true;
        }else {        	
        	return false; // 작성자만 삭제 가능
        }
    }

	@Override
	public void updateComment(int commentSeq, String content, Integer secret, long userSeq) {
		System.out.println("PostServiceImpl updateComment 호출 : 댓글 수정");
		
		CommentVO comment = commentMapper.getCommentBySeq(commentSeq);

	    // 작성자만 수정 가능
	    if (comment != null && comment.getUserSeq() == userSeq) {
	        comment.setContent(content);
	        comment.setSecret(secret);
	        
	        // 댓글 수정
	        commentMapper.updateComment(comment);
	    }
	}
	
}