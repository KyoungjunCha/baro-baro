package com.barobaro.app.service;

import java.util.Map;

import com.barobaro.app.common.CommonCode.SocialType;
import com.barobaro.app.common.CommonCode.UserInfo;
//import com.barobaro.app.service.impl.GoogleOauth;
import com.barobaro.app.service.impl.KakaoOauth;
import com.barobaro.app.service.impl.NaverOauth;

public interface Oauth {
    
	
	public String getLoginFormURL(SocialType socialType, String state);
    public Map<String, String> requestAccessToken(String code);
    public Map<String, String> getUserInfo(String accessToken);
    public UserInfo getUserInfo2(String accessToken);
    public boolean isTokenExpired(String accessToken);
	public String getAccessTokenByRefreshToken(String refreshToken);
		
    default SocialType type() {
//        if (this instanceof GoogleOauth) {
//            return SocialType.GOOGLE;
//        }else 
    	if (this instanceof NaverOauth) {
            return SocialType.NAVER;
        } else if (this instanceof KakaoOauth) {
            return SocialType.KAKAO;
        } else {
            return null;
        }
    }
}