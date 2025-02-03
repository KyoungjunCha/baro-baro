package com.barobaro.app.controller;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.barobaro.app.common.CommonCode;
import com.barobaro.app.common.CommonCode.Role;
import com.barobaro.app.common.CommonCode.SocialType;
import com.barobaro.app.common.CommonCode.UserInfo;
import com.barobaro.app.common.CommonCode.UserStatus;
import com.barobaro.app.common.StateGenerator;
import com.barobaro.app.service.MypageService;
import com.barobaro.app.service.OauthService;
import com.barobaro.app.vo.PostVO;
import com.barobaro.app.vo.UsersOauthVO;
import com.barobaro.app.vo.UsersTblVO;

@Controller
public class UserController {

	@Autowired
	private MypageService mypageService;
	
	
	
    //내 post 글 목록 보기
    @RequestMapping(value = "/myposts", method = RequestMethod.GET, produces="application/json")
	public List<PostVO> ctlMyPostList(HttpServletRequest request) {
		int userSeq = (Integer)request.getSession().getAttribute("SESS_USER_SEQ");
    	UserStatus status = (UserStatus) request.getSession().getAttribute("SESS_STATUS");
    	
    	System.out.println("내 유저 상태 : " + status);
		System.out.println("내 유저 Seq : " + userSeq);
		
		System.out.println("상태좀2 : " + mypageService.svcGetAllMyPosts(userSeq));
		
		//유저 상태가 active 일 경우
		if(status != null && "ACTIVE".equals(status.name())) {
			List<PostVO> posts = mypageService.svcGetAllMyPosts(userSeq);
			System.out.println("yogi : " + posts);
//			model.addAttribute("posts", posts);
			System.out.println("상태좀 : " + mypageService.svcGetAllMyPosts(userSeq));
			return mypageService.svcGetAllMyPosts(userSeq);
		}else {
			return Collections.emptyList();
		}
	}
	
	
    
	
	
	
}
