package com.barobaro.app.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.barobaro.app.common.CommonCode.UserInfo;
import com.barobaro.app.common.CommonCode.UserStatus;
import com.barobaro.app.service.CategoryService;
import com.barobaro.app.service.PostService;
import com.barobaro.app.vo.PostVO;

@Controller
@RequestMapping("/post")
public class PostController {
	
	@Autowired
	CategoryService categoryService;
	
	@Autowired
	PostService postService;
	
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
	
	@RequestMapping(value =  "/create_page", method = RequestMethod.GET)
	public ModelAndView getCreatePostPage(HttpSession session) {
		session.setAttribute("user_info", new UserInfo(1, "test@test.com", "test nickname", UserStatus.ACTIVE));
//		model.addAttribute("categories", categoryService.getAllCategoryNameAndSeq());
		ModelAndView mav = new ModelAndView();
		mav.addObject("categories", categoryService.getAllCategoryNameAndSeq());
		mav.setViewName("pages/post/create_post");
		return mav;
//		return "redirect: /pages/post/create_post.jsp";
	}
	
	@RequestMapping(value =  "/create", method = RequestMethod.POST)
	public ResponseEntity<?> createPost(HttpSession session,
			@RequestParam("ufile") List<MultipartFile> files,
            @RequestParam("title") String title,
            @RequestParam("product_name") String productName,
            @RequestParam("item_content") String itemContent,
            @RequestParam("rent_content") String rentContent,
            @RequestParam("category") long category
            ) {
		UserInfo userInfo = (UserInfo)session.getAttribute("user_info");
		postService.createPost(PostVO.builder()
				
				.build());
		
		return new ResponseEntity<>(HttpStatus.CREATED);
	}
	
	@RequestMapping(value =  "/{postSeq}", method = RequestMethod.GET)
	public ModelAndView getPostPage(@PathVariable("postSeq") long postSeq){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pages/post/detail_post");
		return mav;
	}
	
}