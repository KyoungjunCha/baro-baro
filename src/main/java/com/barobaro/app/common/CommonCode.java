package com.barobaro.app.common;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

public class CommonCode {

	public static enum SocialType {
		GOOGLE,
	    KAKAO,
	    NAVER
	}
	
	@AllArgsConstructor
	@Getter
	public static enum Role {
		GENERAL(1, "일반 유저"),
		ADMIN(2, "관리자");
		
		private int code; 
		private String desc;
	}
	
	@AllArgsConstructor
	@Getter
	public static enum UserStatus {
		ACTIVE(1, "활성"),
		INACTIVE(2, "휴면"),
		DELETE(3, "삭제");
		
		
		private int code; 
		private String desc;
	}
	
	//session, addAttribute("user_info", userinfo)
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class UserInfo{
		private long userSeq;
		private String email;
		private String profile_nickname;
		private String profile_image;
		private UserStatus userStatus;
		private Role userRole;
	}
//	@AllArgsConstructor
//	public static class UserInfo{
//		private long userSeq;
//		private String email;
//		private String nickname;
//		private UserStatus userStatus;
//	}
	
	
	@AllArgsConstructor
	@Getter
	public static enum ReservationHistoryStatus {
		REQUESTED(1, "예약대기중"),
		ACCEPTED(2, "예약승인"),
		REFUSED(3, "예약거절"),
		CANCLE_REQUESTED(4, "예약취소요청"),
		CANCLE_COMPLETED(5, "예약취소완료"),
		DONE(6, "거래완료"),
		CANCLE_REJECTED(7, "예약취소요청 거절됨");
		
		private int code; 
		private String desc;
	}
	
	@AllArgsConstructor
	@Getter
	public static enum ReservationAvailableStatus {
		AVAILABLE(1, "예약가능"),
		NOAVAILABLE(2, "예약불가능");
		
		private int code; 
		private String desc;
	}
	
}
