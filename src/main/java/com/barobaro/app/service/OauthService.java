package com.barobaro.app.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.barobaro.app.common.CommonCode.SocialType;
import com.barobaro.app.common.CommonCode.UserInfo;
import com.barobaro.app.vo.UsersOauthVO;
import com.barobaro.app.vo.UsersTblVO;

import java.util.List;
import java.util.Map;


public interface OauthService {  // implemenets OauthService {
	public Oauth getSocialInstance(SocialType socialType);

	
	
	
	//OAuth :: 로그인창 URL 가져오기
	public String svcLoginFormURL(SocialType socialType, String state);

	//OAuth :: 콜백URL을 통한 엑세스 토근 발급
	public Map<String, String> svcRequestAccessToken(SocialType socialType, String code, String state);

	//OAuth :: 엑세스 토근을 사용한 구글서비스(profile) 가져오기
//	public Map<String, String> svcRequestUserInfo(SocialType socialType, String accessToken);
	
	public UserInfo svcRequestUserInfo(SocialType socialType, String accessToken);
	
	
	//OAuth :: 기존회원/신규회원 구분을 위한 DB조회
	public UsersTblVO svcCheckExistUser(String email, String nickname);
	
	
	
	//OAuth :: 신규회원: 3.회원정보저장 -->  3.토큰저장  (1: [0,1])
	public int svcInsertToken(UsersTblVO usersTblVO);
		
	//OAuth :: 기존회원:토큰갱신
	public void svcUpdateToken(UsersOauthVO usersOauthVO);
	
	//유저 정보 업데이트
	public int svcUpdateUserInfo(UsersTblVO usersTblVO);
	
	
	//admin 모든 유저 정보 조회
    public List<UsersTblVO> svcGetAllUsers();

    // 유저 정보 업데이트
    public int svcUpdateAdminUserInfo(UsersTblVO usersTblVO);
	
	
}