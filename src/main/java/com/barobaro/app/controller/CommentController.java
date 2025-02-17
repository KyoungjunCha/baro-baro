package com.barobaro.app.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.barobaro.app.common.CommonCode.Role;
import com.barobaro.app.common.CommonCode.UserInfo;
import com.barobaro.app.common.CommonCode.UserStatus;
import com.barobaro.app.service.CommentService;
import com.barobaro.app.vo.CommentVO;
import com.barobaro.app.vo.PostVO3;

@Controller
@RequestMapping("/post")
public class CommentController {

    @Autowired
    private CommentService commentService;
    
    // 전체 게시물 조회
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ModelAndView getAllPosts(HttpSession session) {
        // 세션에 user 정보 저장 (예제 사용자)
        session.setAttribute("user_info", 
        		new UserInfo(1002, "test@test.com", "test nickname", "", UserStatus.ACTIVE, Role.ADMIN));
        
        // 게시물 목록 조회
        System.out.println("CommentController");
        List<PostVO3> postList = commentService.getAllPosts();
        System.out.println("CommentController getAllPosts : " + postList);

        // ModelAndView 객체 생성 및 설정
        ModelAndView mav = new ModelAndView();
        mav.setViewName("pages/post/post_list"); // JSP 경로 설정
        mav.addObject("POSTLIST", postList); // 게시물 목록 추가

        return mav;
    }

    // 게시물 상세
    @RequestMapping(value = "/detail", method = RequestMethod.GET)
    public ModelAndView getPostDetail(@RequestParam("postSeq") int postSeq, HttpSession session) {
        System.out.println("PostController getPostDetail 호출");

        // 세션에 user 정보 저장 (예제 사용자)
        session.setAttribute("user_info", 
        		new UserInfo(1002, "test@test.com", "test nickname", "", UserStatus.ACTIVE, Role.ADMIN));

        // 게시물 상세 정보 조회
        PostVO3 post = commentService.getPostDetail(postSeq);

        // ModelAndView 객체 생성 및 설정
        ModelAndView mav = new ModelAndView();
        mav.setViewName("pages/post/detail_post"); // JSP 경로 설정
        mav.addObject("POSTDETAIL", post); // 게시물 상세 정보 추가

        return mav;
    }

    
    
    // ---------------------------------------------- 댓글 ----------------------------------------------
    
    // 댓글 목록 조회
    @RequestMapping(value = "/detail_comment", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<List<CommentVO>> getPostCommentList(
            @RequestParam("postSeq") int postSeq, 
            HttpSession session) {

        System.out.println("PostController getPostCommentList");

        // 세션에 user 정보 저장 (예제 사용자)
        UserInfo userInfo = new UserInfo(1002, "test@test.com", "test nickname", "", UserStatus.ACTIVE, Role.ADMIN);
        session.setAttribute("user_info", userInfo);

        // 세션에서 userSeq 가져오기
        long userSeq = userInfo.getUserSeq();

        // 댓글 목록 조회 (비밀글 확인을 위해 userSeq 전달)
        List<CommentVO> commentList = commentService.getPostComment(postSeq, userSeq);

        return new ResponseEntity<List<CommentVO>>(commentList, HttpStatus.OK);
    }
    
    // 댓글 입력 (최상위 댓글 + 대댓글 공통)
    @RequestMapping(value = "/detail_comment_insert", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<List<CommentVO>> commentInsert(
    		@RequestParam int postSeq
    		, @RequestParam(required = false) Integer parentSeq  // null 허용
    		, @RequestParam String content
    		//, @RequestParam int userSeq
    		, @RequestParam(required = false) Integer secret
    		, HttpSession session) {
        
    	System.out.println("PostController commentInsert");
    	
    	// 세션에 user 정보 저장 (예제 사용자)
        UserInfo userInfo = new UserInfo(1002, "test@test.com", "test nickname", "", UserStatus.ACTIVE, Role.ADMIN);
        session.setAttribute("user_info", userInfo);

        // 세션에서 userSeq 가져오기
        long userSeq = userInfo.getUserSeq();
        
    	// 댓글 입력시 최상위 댓글인지 하위 댓글인지 cosole확인
        if (parentSeq == null) {
            System.out.println("getParentSeq : " + parentSeq + "최상위 댓글");
        } else {
            System.out.println("getParentSeq : " + parentSeq + "하위 댓글");
        }
        
        // 비밀글 여부 기본값 설정
        if (secret == null || secret == 0) {	// 클라이언트에 받은 값이 null일때
            secret = 0; 		// 기본값 설정
        }else {
        	secret = 1;
        }
    	
        // 서비스에서 댓글 입력 처리
        commentService.commentInsert(postSeq, parentSeq, content, userSeq, secret);

        // 최신 댓글 목록 반환
        List<CommentVO> updatedComments = commentService.getPostComment(postSeq, userSeq);
        return new ResponseEntity<List<CommentVO>>(updatedComments, HttpStatus.OK);
    }
    
    // 댓글 삭제
    @RequestMapping(value = "/delete_comment", method = RequestMethod.POST)
    @ResponseBody
    public String deleteComment(
    		@RequestParam("commentSeq") int commentSeq
    		//, @RequestParam("userSeq") int userSeq
    		, HttpSession session) {
    	
    	System.out.println("PostController deleteComment");
    	System.out.println("삭제할 댓글의 commentSeq : " + commentSeq);
    	
    	// 세션에 user 정보 저장 (예제 사용자)
        UserInfo userInfo = new UserInfo(1002, "test@test.com", "test nickname", "", UserStatus.ACTIVE, Role.ADMIN);
        session.setAttribute("user_info", userInfo);

        // 세션에서 userSeq 가져오기
        long userSeq = userInfo.getUserSeq();
        
    	boolean deleteResult = commentService.commentDelete(commentSeq, userSeq);
    	
    	if (deleteResult) {
            return "Your comment has been deleted.";
        } else {
            return "You do not have permission to delete comments.";
        }
    }
    
    // 댓글 수정
    @RequestMapping(value = "/update_comment", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<List<CommentVO>> updateComment(
		@RequestParam int postSeq // 게시물 번호 추가
        , @RequestParam int commentSeq
        , @RequestParam String content
        , @RequestParam Integer secret // 비밀글 여부
        //, @RequestParam int userSeq // 댓글 작성자
        , HttpSession session) {
    	
    	// 세션에 user 정보 저장 (예제 사용자)
        UserInfo userInfo = new UserInfo(1002, "test@test.com", "test nickname", "", UserStatus.ACTIVE, Role.ADMIN);
        session.setAttribute("user_info", userInfo);

        // 세션에서 userSeq 가져오기
        long userSeq = userInfo.getUserSeq();
        // 댓글 수정 처리
    	commentService.updateComment(commentSeq, content, secret, userSeq);

        // 수정된 댓글 목록 반환
        List<CommentVO> updatedComments = commentService.getPostComment(postSeq, userSeq);
        return new ResponseEntity<List<CommentVO>>(updatedComments, HttpStatus.OK);
    }

}
