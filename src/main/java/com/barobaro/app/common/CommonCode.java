package com.barobaro.app.common;

import lombok.AllArgsConstructor;
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
}
