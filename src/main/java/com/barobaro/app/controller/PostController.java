package com.barobaro.app.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.barobaro.app.common.CommonCode.UserInfo;
import com.barobaro.app.common.CommonCode.UserStatus;
import com.barobaro.app.mapper.PostMapper;
import com.barobaro.app.service.CategoryService;
import com.barobaro.app.service.PostService;
import com.barobaro.app.vo.LocationVO;
import com.barobaro.app.vo.PostFileVO;
import com.barobaro.app.vo.PostVO;
import com.barobaro.app.vo.RentTimeSlotVO;
import com.barobaro.app.vo.SearchVO;

@Controller
@RequestMapping("/post")
public class PostController {
	
	@Autowired
	CategoryService categoryService;
	
	@Autowired
	PostService postService;

	
//	@Autowired
//	PostMapper testMapper;
//	
//	@GetMapping("/test")
//	public ModelAndView test() {
//		System.out.println(testMapper.selectPostByPostSeq(1));
//		ModelAndView mav = new ModelAndView();
//		
//		return mav;
//	}
	
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
		ModelAndView mav = new ModelAndView();
		mav.addObject("categories", categoryService.getAllCategoryNameAndSeq());
		mav.setViewName("pages/post/create_post");
		return mav;
	}
	
	@RequestMapping(value =  "/create", method = RequestMethod.POST)
	public ModelAndView createPost(HttpSession session,
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
				.rentTimes(new ArrayList<>())
				.build();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
		if(prices != null) {
			for(int i = 0; i < prices.size(); i++) {
				try {
					postVO.getRentTimes().add(RentTimeSlotVO.builder()
							.rent_at(sdf.parse(rentAt.get(i)))
							.return_at(sdf.parse(returnAt.get(i)))
							.price(prices.get(i))
							.rent_location(rentLocations.get(i))
							.rent_rotate_x(rentRotateX.get(i))
							.rent_rotate_y(rentRotateY.get(i))
							.return_location(rentLocations.get(i))
							.return_rotate_x(returnRotateX.get(i))
							.return_rotate_y(rentRotateY.get(i))
							.regid(userInfo.getNickname())
							.build());
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
		}
		postService.createPost(postVO, files);
		ModelAndView mav = new ModelAndView();

		mav.setStatus(HttpStatus.CREATED);
		mav.setViewName("redirect:/post/post/" + postVO.getPostSeq());
		return mav;
	}
	
	@RequestMapping(value =  "/post/{postSeq}", method = RequestMethod.GET)
	public ModelAndView getPostPage(@PathVariable("postSeq") long postSeq){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pages/post/detail_post");
		PostVO postVO = postService.getPostByPostSeq(postSeq);
		mav.addObject("KEY_POST", postVO);
		ObjectMapper om = new ObjectMapper();
		mav.addObject("categories", categoryService.getAllCategoryNameAndSeq());
		try {
			mav.addObject("KEY_POST_JSON", om.writeValueAsString(postVO));
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return mav;
	}
	
	@RequestMapping(value =  "/post/{postSeq}/update", method = RequestMethod.GET)
	public ModelAndView updatePostPage(@PathVariable("postSeq") long postSeq){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pages/post/update_post");
		PostVO postVO = postService.getPostByPostSeq(postSeq);
		mav.addObject("KEY_POST", postVO);
		ObjectMapper om = new ObjectMapper();
		mav.addObject("categories", categoryService.getAllCategoryNameAndSeq());
		try {
			mav.addObject("KEY_POST_JSON", om.writeValueAsString(postVO));
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return mav;
	}
	
	
//						/post/posts
	@RequestMapping(value = "/posts", method = RequestMethod.GET)
	public ModelAndView searchPost( @ModelAttribute SearchVO svo ) {
		String searchKeyword = svo.getSearchKeyword();
		String searchType = svo.getSearchType();
		int categorySeq = svo.getCategorySeq();
		String availableOnly = svo.getAvailableOnly();
		
        Double latitude = svo.getLatitude();
        Double longitude = svo.getLongitude();
        
		System.out.println("검색타입 : " + searchType + ", 검색어 : " + searchKeyword + ", 카테고리 선택 : " + categorySeq);
		System.out.println("availableOnly : " + availableOnly);
        System.out.println("받은 사용자 위치 정보:");
        System.out.println("위도: " + latitude);
        System.out.println("경도: " + longitude);
        
		List<PostVO> plist = postService.getPostBySearchCondition(searchKeyword, searchType, categorySeq, availableOnly, latitude, longitude);
		
		System.out.println(plist.toString());
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pages/post/search_post_list_test2");
		mav.addObject("KEY_PLIST", plist);
		mav.addObject("KEY_SEARCH", svo);
		mav.addObject("availableOnly", availableOnly);
		
		return mav;
	}
	
//						/post/location   사용자 위치 받아오기 테스트
	@RequestMapping(value = "/location", method = RequestMethod.POST)
    public void receiveLocation(@RequestBody LocationVO locationVO) {

        Double latitude = locationVO.getLatitude();
        Double longitude = locationVO.getLongitude();

        if (latitude != null && longitude != null) {
            System.out.println("받은 사용자 위치 정보:");
            System.out.println("위도: " + latitude);
            System.out.println("경도: " + longitude);
        }
	}
}