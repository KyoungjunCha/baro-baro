package com.barobaro.app.controller;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.barobaro.app.common.CommonCode.UserStatus;
import com.barobaro.app.service.MypageService;
import com.barobaro.app.vo.PostVO;

@Controller
public class UserController {

	@Autowired
	private MypageService mypageService;
	
	
	
    //내 post 글 목록 보기
    @RequestMapping(value = "/myposts", method = RequestMethod.GET, produces="application/json")
	@ResponseBody
    public List<PostVO> ctlMyPostList(HttpServletRequest request) {
		int userSeq = (Integer)request.getSession().getAttribute("SESS_USER_SEQ");
    	UserStatus status = (UserStatus) request.getSession().getAttribute("SESS_STATUS");
    	
    	System.out.println("내 유저 상태 : " + status);
		System.out.println("내 유저 Seq : " + userSeq);
		
		System.out.println("상태좀2 : " + mypageService.svcGetAllMyPosts(userSeq));
		
		//유저 상태가 active 일 경우
		if(status != null && "ACTIVE".equals(status.name())) {
			List<PostVO> posts = mypageService.svcGetAllMyPosts(userSeq);
			return posts;
		}else {
			return Collections.emptyList();
		}
	}
	
    
  // 내 즐겨찾기 목록 보기
    @RequestMapping(value = "/myfavorite", method = RequestMethod.GET, produces="application/json")
	@ResponseBody
    public List<PostVO> ctlMyFavoriteList(HttpServletRequest request) {
		int userSeq = (Integer)request.getSession().getAttribute("SESS_USER_SEQ");
    	UserStatus status = (UserStatus) request.getSession().getAttribute("SESS_STATUS");
    	
    	System.out.println("내 유저 상태 : " + status);
		System.out.println("내 유저 Seq : " + userSeq);
		
		System.out.println("상태좀2 : " + mypageService.svcGetAllMyPosts(userSeq));
		
		//유저 상태가 active 일 경우
		if(status != null && "ACTIVE".equals(status.name())) {
			List<PostVO> posts = mypageService.svcGetAllMyPosts(userSeq);
			return posts;
		}else {
			return Collections.emptyList();
		}
	}
	
    
	
	
	
}
