package com.barobaro.app.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.barobaro.app.common.CommonCode.UserInfo;
import com.barobaro.app.common.CommonCode.UserStatus;
import com.barobaro.app.service.CategoryService;
import com.barobaro.app.service.PostService;
import com.barobaro.app.vo.PostFileVO;
import com.barobaro.app.vo.PostVO;
import com.barobaro.app.vo.RentTimeSlotVO;

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
		session.setAttribute("user_info", new UserInfo(1001, "test@test.com", "test nickname", UserStatus.ACTIVE));
//		model.addAttribute("categories", categoryService.getAllCategoryNameAndSeq());
		ModelAndView mav = new ModelAndView();
		mav.addObject("categories", categoryService.getAllCategoryNameAndSeq());
//		System.out.println(categoryService.getAllCategoryNameAndSeq());
		mav.setViewName("pages/post/create_post");
		return mav;
//		return "redirect: /pages/post/create_post.jsp";
	}
	
	@RequestMapping(value =  "/create", method = RequestMethod.POST)
	public ResponseEntity<?> createPost(HttpSession session,
			@RequestParam("title") String title,
            @RequestParam("category") String category,
            @RequestParam("product_name") String productName,
            @RequestParam("item_content") String itemContent,
            @RequestParam("rent_content") String rentContent,
            @RequestParam(value = "rent_at[]", required = false) List<String> rentAt,             
            @RequestParam(value = "return_at[]", required = false) List<String> returnAt,             
            @RequestParam(value = "price[]", required = false) List<Integer> prices,             
            @RequestParam(value = "rent_location[]", required = false) List<String> rentLocations,             
            @RequestParam(value = "rent_rotate_x[]", required = false) List<Double> rentRotateX,             
            @RequestParam(value = "rent_rotate_y[]", required = false) List<Double> rentRotateY,             
            @RequestParam(value = "return_location[]", required = false) List<String> returnLocations,             
            @RequestParam(value = "return_rotate_x[]", required = false) List<Double> returnRotateX,             
            @RequestParam(value = "return_rotate_y[]", required = false) List<Double> returnRotateY,
            @RequestParam("ufile") List<MultipartFile> files
            ) {
		System.out.println("요청은 온다~~~ @!#!@#");
		session.setAttribute("user_info", new UserInfo(1001, "test@test.com", "test nickname", UserStatus.ACTIVE));
		UserInfo userInfo = (UserInfo)session.getAttribute("user_info");
		PostVO postVO = PostVO.builder()
				.title(title)
				.itemContent(itemContent)
				.rentContent(rentContent)
				.productName(productName)
				.userSeq(userInfo.getUserSeq())
				.categoryName(category)
				.postImages(new ArrayList<>())
				.renttimes(new ArrayList<>())
				.build();
		if(prices != null) {
			for(int i = 0; i < prices.size(); i++) {
				postVO.getRenttimes().add(RentTimeSlotVO.builder()
						.rent_at(rentAt.get(i))
						.return_at(returnAt.get(i))
						.price(prices.get(i))
						.rent_location(rentLocations.get(i))
						.rent_rotate_x(rentRotateX.get(i))
						.rent_rotate_y(rentRotateY.get(i))
						.return_location(rentLocations.get(i))
						.return_rotate_x(returnRotateX.get(i))
						.return_rotate_y(rentRotateY.get(i))
						.build());
			}
		}
		files.forEach(e -> {
			postVO.getPostImages().add(PostFileVO.builder()
					.name(e.getOriginalFilename())
					.build());
		});
		
		System.out.println(postVO);
		
		postService.createPost(postVO, files);
		
        // 실제 로직 수행 후 결과 반환
		return new ResponseEntity<>(HttpStatus.CREATED);
	}
	
	@RequestMapping(value =  "/post/{postSeq}", method = RequestMethod.GET)
	public ModelAndView getPostPage(@PathVariable("postSeq") long postSeq){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pages/post/detail_post");
//		KEY_POST
		return mav;
	}
	
}