package com.barobaro.app.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
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
		
		
		PostVO pvo = PostVO.builder().rentTimes(new ArrayList<>()).build();
		 // 오늘 날짜 이후로 10개의 예시 데이터 생성
        Calendar calendar = Calendar.getInstance();
        List<RentTimeSlotVO> rentTimes = pvo.getRentTimes();

        // 오늘 날짜 이후로 10개의 RentTimeSlotVO 객체 추가
        for (int i = 0; i < 10; i++) {
            calendar.add(Calendar.HOUR, 2);  // 2시간 간격으로 대여시간 설정
            Date rentAt = calendar.getTime();  // 대여시간

            calendar.add(Calendar.HOUR, 1);  // 1시간 후 반납시간 설정
            Date returnAt = calendar.getTime();  // 반납시간

            RentTimeSlotVO rentTimeSlot = new RentTimeSlotVO();
            rentTimeSlot.setTime_slot_seq(i + 1);  // 타임슬롯 식별자
            rentTimeSlot.setRent_at(rentAt);  // 대여 시간
            rentTimeSlot.setReturn_at(returnAt);  // 반납 시간
            rentTimeSlot.setStatus(1);  // 예약 가능 상태
            rentTimeSlot.setPost_seq(1001);  // 게시물 식별자 (예시)
            rentTimeSlot.setRegdate(new Date());  // 생성일 (현재 시간)
            rentTimeSlot.setRegid("admin");  // 등록자 식별자
            rentTimeSlot.setPrice(50000);  // 가격 (예시)
            rentTimeSlot.setRent_location("서울시 강남구 테헤란로 123");  // 대여 장소
            rentTimeSlot.setRent_rotate_x(127);  // 대여 장소 x 좌표 (예시)
            rentTimeSlot.setRent_rotate_y(37);  // 대여 장소 y 좌표 (예시)
            rentTimeSlot.setReturn_location("서울시 강남구 역삼동 456");  // 반납 장소
            rentTimeSlot.setReturn_rotate_x(127);  // 반납 장소 x 좌표 (예시)
            rentTimeSlot.setReturn_rotate_y(37);  // 반납 장소 y 좌표 (예시)

            // pvo.getRentTimes() 리스트에 추가
            rentTimes.add(rentTimeSlot);
        }
		
		mav.addObject("KEY_POST", pvo);
		ObjectMapper om = new ObjectMapper();
		try {
			mav.addObject("KEY_POST_JSON", om.writeValueAsString(pvo));
		} catch (JsonGenerationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mav;
	}
	
}