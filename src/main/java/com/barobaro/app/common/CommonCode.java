package com.barobaro.app.common;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

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
	public static class UserInfo{
		private long userSeq;
		private String email;
		private String nickname;
		private UserStatus userStatus;
	}
}
