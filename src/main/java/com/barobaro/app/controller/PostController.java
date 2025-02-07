package com.barobaro.app.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.barobaro.app.common.CommonCode.Role;
import com.barobaro.app.common.CommonCode.UserInfo;
import com.barobaro.app.common.CommonCode.UserStatus;
import com.barobaro.app.mapper.PostMapper;
import com.barobaro.app.service.CategoryService;
import com.barobaro.app.service.KeywordService;
import com.barobaro.app.service.NotificationService;
import com.barobaro.app.service.PostService;
import com.barobaro.app.vo.CategoryVO;
import com.barobaro.app.vo.KeywordVO;
import com.barobaro.app.vo.NotificationVO;
import com.barobaro.app.vo.LocationVO;
import com.barobaro.app.vo.PostFileVO;
import com.barobaro.app.vo.PostVO;
import com.barobaro.app.vo.RentTimeSlotVO;
import com.barobaro.app.vo.ReviewVO;
import com.barobaro.app.vo.SearchVO;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/post")
public class PostController {

	@Autowired
	CategoryService categoryService;

	@Autowired
	PostService postService;

	@Autowired
	private NotificationService notificationService;

	@Autowired
	private KeywordService keywordService;

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
	
	@RequestMapping(value = "/create_page", method = RequestMethod.GET)
	public ModelAndView getCreatePostPage(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("categories", categoryService.getAllCategoryNameAndSeq());
		mav.setViewName("pages/post/create_post");
		return mav;
	}

	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public ModelAndView createPost(HttpSession session, @RequestParam("title") String title,
			@RequestParam("category") String category, @RequestParam("product_name") String productName,
			@RequestParam("item_content") String itemContent, @RequestParam("rent_content") String rentContent,
			@RequestParam(value = "rent_at[]", required = false) List<String> rentAt,
			@RequestParam(value = "return_at[]", required = false) List<String> returnAt,
			@RequestParam(value = "price[]", required = false) List<Integer> prices,
			@RequestParam(value = "rent_location[]", required = false) List<String> rentLocations,
			@RequestParam(value = "rent_rotate_x[]", required = false) List<Double> rentRotateX,
			@RequestParam(value = "rent_rotate_y[]", required = false) List<Double> rentRotateY,
			@RequestParam(value = "return_location[]", required = false) List<String> returnLocations,
			@RequestParam(value = "return_rotate_x[]", required = false) List<Double> returnRotateX,
			@RequestParam(value = "return_rotate_y[]", required = false) List<Double> returnRotateY,
			@RequestParam("ufile") List<MultipartFile> files,
			@RequestParam(value = "isUpdate", required = false, defaultValue = "0")long isUpdate) {
		session.setAttribute("user_info",
				new UserInfo(1005, "test@test.com", "test nickname", "", UserStatus.ACTIVE, Role.ADMIN));
		UserInfo userInfo = (UserInfo) session.getAttribute("user_info");
		PostVO postVO = PostVO.builder().title(title).itemContent(itemContent).rentContent(rentContent)
				.productName(productName).userSeq(userInfo.getUserSeq()).categoryName(category)
				.postImages(new ArrayList<>()).rentTimes(new ArrayList<>()).build();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
		if (prices != null) {
			for (int i = 0; i < prices.size(); i++) {
				try {
					postVO.getRentTimes()
						.add(RentTimeSlotVO.builder().rent_at(sdf.parse(rentAt.get(i)))
								.return_at(sdf.parse(returnAt.get(i))).price(prices.get(i))
								.rent_location(rentLocations.get(i)).rent_rotate_x(rentRotateX.get(i))
								.rent_rotate_y(rentRotateY.get(i)).return_location(rentLocations.get(i))
								.return_rotate_x(returnRotateX.get(i)).return_rotate_y(rentRotateY.get(i))
								.regid(userInfo.getProfile_nickname()).build());
				} catch (ParseException e) {
					e.printStackTrace();
				} catch (NullPointerException e) {
					e.printStackTrace();
					continue;
				}
			}
		}
		if(isUpdate != 0) {
			postVO.setPostSeq(isUpdate);
			postService.updatePost(postVO, files);
		} else {
			postService.createPost(postVO, files);
		}
		ModelAndView mav = new ModelAndView();

		mav.setStatus(HttpStatus.CREATED);
		mav.setViewName("redirect:/post/post/" + postVO.getPostSeq());

		// 관심 키워드 알림
		// List<KeywordVO> keywordList = keywordService.getKeywordsByUserSeq(1001); // 해당 카테고리를 가진 모든 userSeq에게 알림 보내기(수정사항)
		List<KeywordVO> keywordList = keywordService.getAllKeywords();
		
		for (KeywordVO kvo : keywordList) {
			// 게시글에 키워드가 포함되어 있으면
			if (postVO.getTitle().contains(kvo.getContents())) {
				NotificationVO notification = new NotificationVO();

				// 키워드 설정한 사용자에게 알림
				notification.setUserSeq(kvo.getUserSeq());
				notification.setTitle("관심 키워드 알림");
				notification.setContents(kvo.getContents() + " - " + postVO.getTitle());
				notification.setNotificationType("KEYWORD_MATCH");
				notification.setIsRead(0);
				notification.setCreatedAt(new Date(System.currentTimeMillis()));
				
				notificationService.sendNotification(notification);
			}
		}

		return mav;
	}

	@RequestMapping(value = "/post/{postSeq}", method = RequestMethod.GET)
	public ModelAndView getPostPage(@PathVariable("postSeq") long postSeq, HttpSession session) {
		session.setAttribute("user_info",
				new UserInfo(1005, "test@test.com", "test nickname", "", UserStatus.ACTIVE, Role.ADMIN));
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pages/post/detail_post");
		PostVO postVO = postService.getPostByPostSeq(postSeq);
		mav.addObject("KEY_POST", postVO);
		ObjectMapper om = new ObjectMapper();
		try {
			mav.addObject("KEY_POST_JSON", om.writeValueAsString(postVO));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mav;
	}

//						/post/posts
	@RequestMapping(value = "/posts", method = RequestMethod.GET)
	public ModelAndView searchPost(@ModelAttribute SearchVO svo) {
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

		List<PostVO> plist = postService.getPostBySearchCondition(svo);

		System.out.println(plist.toString());
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pages/post/search_post_list_test2");
		mav.addObject("KEY_PLIST", plist);
		mav.addObject("KEY_SEARCH", svo);
		mav.addObject("availableOnly", availableOnly);
		mav.addObject("categories", categoryService.getAllCategoryNameAndSeq());

		return mav;
	}
	
	@RequestMapping(value = "/update_page/{postSeq}", method = RequestMethod.GET)
	public ModelAndView getUpdatePostPage(@PathVariable("postSeq") long postSeq, HttpSession session) {
		session.setAttribute("user_info",
				new UserInfo(1002, "test@test.com", "test nickname", "", UserStatus.ACTIVE, Role.ADMIN));
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pages/post/update_post");
		PostVO postVO = postService.getPostByPostSeq(postSeq);
		mav.addObject("KEY_POST", postVO);
		ObjectMapper om = new ObjectMapper();
		try {
			mav.addObject("KEY_POST_JSON", om.writeValueAsString(postVO));
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<CategoryVO> categories = categoryService.getAllCategoryNameAndSeq();
		for(int i = 0; i < categories.size(); i++) {
			if(categories.get(i).getCategoryName().equals(postVO.getCategoryName())) {
				CategoryVO target = categories.get(i);
				categories.remove(i);
				categories.add(0, target);
				break;
			}
		}
		mav.addObject("categories", categories);
		
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
	
	@GetMapping("/createReviewPage/{postSeq}")
	public ModelAndView createReviewPage(@PathVariable("postSeq") long postSeq) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pages/review/review");
		mav.addObject("postSeq", postSeq);
		return mav;
	}
	
	@PostMapping("/submitReview")
	@ResponseBody
    public String submitReview(@RequestBody ReviewVO reviewVO, HttpSession session) {
		UserInfo userInfo = (UserInfo) session.getAttribute("user_info");
		postService.createReview(reviewVO, userInfo.getUserSeq());
        return "success";
    }
}