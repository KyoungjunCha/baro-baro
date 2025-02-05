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
import com.barobaro.app.vo.CommentVO;
import com.barobaro.app.vo.FavoriteVO;
import com.barobaro.app.vo.NotificationVO;
import com.barobaro.app.vo.PostVO;
import com.barobaro.app.vo.UserReviewAnswerVO;

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
		
		System.out.println("상태좀1 : " + mypageService.svcGetAllMyPosts(userSeq));
		
		//유저 상태가 active 일 경우
		if(status != null && "ACTIVE".equals(status.name())) {
			List<PostVO> posts = mypageService.svcGetAllMyPosts(userSeq);
			return posts;
		}else {
			return Collections.emptyList();
		}
	}
    
    

    // 마이페이지 예약관리
    /* 나의 대여 예약 현황 (RESERVATION_HISTORY)
     *                     [버튼에 들어갈 글자]         비고 란에
     * 예약을 요청 상태(STATUS=1) = 예약 요청중            => 물품주인이 대여 요청을 수락 시, 예약이 확정됩니다! 📢
     * 예약을 수락 상태(STATUS=2) = 예약 확정됨            => [예약 취소 요청]🫥 버튼 활성화 (rent_at 3일전까지)
     * 예약을 거절 상태(STATUS=3) = 예약 거절됨           => 물품주인이 대여 요청을 거절하였어요 😂
     * 예약을 취소요청 상태(STATUS=4) = 예약 취소 요청중     => 물품주인이 대여 취소요청을 수락 시, 취소가 확정됩니다! 📢
     * 취소요청 수락 상태(STATUS=5) = 예약 취소 요청 수락됨  => 물품주인이 대여 취소요청을 수락하였어요 👌
     * 거래 완료 상태(STATUS=6)    = 거래 완료                => 거래가 완료된 항목입니다 ❤
     * 
     * */
    //나의 대여 예약 현황 
    @RequestMapping(value = "/myposts/reservation", method = RequestMethod.GET, produces="application/json")
	@ResponseBody
    public List<PostVO> ctlMyPostReservationList(HttpServletRequest request) {
		int userSeq = (Integer)request.getSession().getAttribute("SESS_USER_SEQ");
    	UserStatus status = (UserStatus) request.getSession().getAttribute("SESS_STATUS");
    	String usernickname = (String) request.getSession().getAttribute("SESS_PROFILE_NICKNAME");
    	
    	System.out.println("내 유저 상태 : " + status);
		System.out.println("내 유저 Seq : " + userSeq);
		System.out.println("내 유저 닉네임 : " + usernickname);
		
		//유저 상태가 active 일 경우
		if(status != null && "ACTIVE".equals(status.name())) {
			List<PostVO> posts = mypageService.svcGetAllUserPostRent(usernickname);
			System.out.println(posts);
			return posts;
		}else {
			return Collections.emptyList();
		}
	}

    
    /*     ● 나의 등록 물품의 요청 현황  (RENT_TIME_SLOT) 등록자가 예약 시간 관리를 위한 테이블
     * 		post table - 원래는 regid -> sess_nickname 여러시간테이블상에 예약을 전부 가져와야하기에
     * 		
     * */
    //내가 대여해준 품목
    @RequestMapping(value = "/myposts/rentlist", method = RequestMethod.GET, produces="application/json")
   	@ResponseBody
       public List<PostVO> ctlMyPostRentList(HttpServletRequest request) {
   		int userSeq = (Integer)request.getSession().getAttribute("SESS_USER_SEQ");
       	UserStatus status = (UserStatus) request.getSession().getAttribute("SESS_STATUS");
       	
       	System.out.println("내 유저 상태 : " + status);
   		System.out.println("내 유저 Seq : " + userSeq);
   		

   		//유저 상태가 active 일 경우
   		if(status != null && "ACTIVE".equals(status.name())) {
   			List<PostVO> posts = mypageService.svcGetAllMyPosts(userSeq);
   			return posts;
   		}else {
   			return Collections.emptyList();
   		}
   	}
	
    
    // 내 알림 목록 보기
    @RequestMapping(value = "/mynotification", method = RequestMethod.GET, produces="application/json")
	@ResponseBody
    public List<NotificationVO> ctlMyNotificationList(HttpServletRequest request) {
		int userSeq = (Integer)request.getSession().getAttribute("SESS_USER_SEQ");
    	UserStatus status = (UserStatus) request.getSession().getAttribute("SESS_STATUS");
    	
    	System.out.println("내 유저 상태 : " + status);
		System.out.println("내 유저 Seq : " + userSeq);
		
		System.out.println("상태좀2 : " + mypageService.svcGetAllMyNotifications(userSeq));
		
		//유저 상태가 active 일 경우
		if(status != null && "ACTIVE".equals(status.name())) {
			List<NotificationVO> notifications = mypageService.svcGetAllMyNotifications(userSeq);
			return notifications;
		}else {
			return Collections.emptyList();
		}
	}  
    
    
  // 내 즐겨찾기 목록 보기
    @RequestMapping(value = "/myfavorite", method = RequestMethod.GET, produces="application/json")
	@ResponseBody
    public List<FavoriteVO> ctlMyFavoriteList(HttpServletRequest request) {
		int userSeq = (Integer)request.getSession().getAttribute("SESS_USER_SEQ");
    	UserStatus status = (UserStatus) request.getSession().getAttribute("SESS_STATUS");
    	
    	System.out.println("내 유저 상태 : " + status);
		System.out.println("내 유저 Seq : " + userSeq);
		
		System.out.println("상태좀3 : " + mypageService.svcGetAllMyFavorites(userSeq));
		
		//유저 상태가 active 일 경우
		if(status != null && "ACTIVE".equals(status.name())) {
			List<FavoriteVO> favorites = mypageService.svcGetAllMyFavorites(userSeq);
			System.out.println("즐겨찾기" + favorites);
			return favorites;
		}else {
			return Collections.emptyList();
		}
	}
	
    
 // 내 댓 목록 보기
//    @RequestMapping(value = "/mycomment", method = RequestMethod.GET, produces="application/json")
//	@ResponseBody
//    public List<CommentVO> ctlMyCommentList(HttpServletRequest request) {
//		int userSeq = (Integer)request.getSession().getAttribute("SESS_USER_SEQ");
//    	UserStatus status = (UserStatus) request.getSession().getAttribute("SESS_STATUS");
//    	
//    	System.out.println("내 유저 상태 : " + status);
//		System.out.println("내 유저 Seq : " + userSeq);
//		
//		System.out.println("상태좀2 : " + mypageService.svcGetAllMyComments(userSeq));
//		
//		//유저 상태가 active 일 경우
//		if(status != null && "ACTIVE".equals(status.name())) {
//			List<CommentVO> comments = mypageService.svcGetAllMyComments(userSeq);
//			return comments;
//		}else {
//			return Collections.emptyList();
//		}
//	}
    
    // 내 리뷰 목록 보기
//    @RequestMapping(value = "/myreview", method = RequestMethod.GET, produces="application/json")
//	@ResponseBody
//    public List<UserReviewAnswerVO> ctlMyReviewList(HttpServletRequest request) {
//		int userSeq = (Integer)request.getSession().getAttribute("SESS_USER_SEQ");
//    	UserStatus status = (UserStatus) request.getSession().getAttribute("SESS_STATUS");
//    	
//    	System.out.println("내 유저 상태 : " + status);
//		System.out.println("내 유저 Seq : " + userSeq);
//		
//		System.out.println("상태좀2 : " + mypageService.svcGetAllMyReviews(userSeq));
//		
//		//유저 상태가 active 일 경우
//		if(status != null && "ACTIVE".equals(status.name())) {
//			List<UserReviewAnswerVO> reviews = mypageService.svcGetAllMyReviews(userSeq);
//			return reviews;
//		}else {
//			return Collections.emptyList();
//		}
//	}
	
	
	
}
