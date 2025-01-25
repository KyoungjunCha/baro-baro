package com.barobaro.app.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.barobaro.app.common.CommonCode.UserInfo;
import com.barobaro.app.common.CommonCode.UserStatus;

@Controller
@RequestMapping("/post")
public class PostController {
	// /post/test/login
	@RequestMapping(value = "/test/login", method = RequestMethod.GET)
	public String login(@RequestParam("id") String id, @RequestParam("pw") String pw, HttpSession session) {
		try {
			session.setAttribute("user_info", new UserInfo(1, "test@test.com", "test nickname", UserStatus.ACTIVE));
		}catch(Exception e) {
			return "redirect: /pages/test/login_fail.jsp";
		}
		return "redirect: /pages/test/login_success.jsp";
	}
	// /post/test/login_success
	@GetMapping("/test/login_success")
	@ResponseBody
	public String test(HttpSession session) {
		UserInfo userInfo = (UserInfo)session.getAttribute("user_info");
		System.out.println(userInfo.getEmail());
		return "OK";
	}
	
	@RequestMapping(value =  "/create", method = RequestMethod.GET)
	public String test(HttpSession session, Model model) {
		UserInfo userInfo = (UserInfo)session.getAttribute("user_info");
		
		model.addAttribute("user_info", userInfo);
		
		return "";
	}
}
