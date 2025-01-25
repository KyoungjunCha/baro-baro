package com.barobaro.app.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.barobaro.app.common.CommonCode.SocialType;
import com.barobaro.app.mapper.UserMapper;
import com.barobaro.app.service.Oauth;
import com.barobaro.app.service.OauthService;
import com.barobaro.app.vo.UsersOauthVO;
import com.barobaro.app.vo.UsersTblVO;

import java.util.List;
import java.util.Map;


@Service
public class OauthServiceImpl implements OauthService{  // implemenets OauthService {
	@Autowired
	private List<Oauth> socialOauthList;    

	@Autowired
	private UserMapper userMapper;
	
	//OAuth :: GOOGLE/KAKAO/NAVER Oauth 클래스 인스턴스 가져오기 - (JDK1.8이상)
	@Override
	public Oauth getSocialInstance(SocialType socialType) {
//		return socialOauthList.stream()
//				.filter(x -> x.type() == socialType)
//				.findFirst()
//				.orElseThrow(() -> new IllegalArgumentException("Unknown SocialType"));
//		throw new IllegalArgumentException("Unknown SocialType");
		try {
			for (Oauth oauth : socialOauthList) {
			    if (oauth.type() == socialType) {
		            return oauth;
		        }
		    }
			throw new IllegalArgumentException("Unknown SocialType");
		} catch (IllegalArgumentException e) {
	        throw e; 
	    }
	}

	
	
	
	//OAuth :: 로그인창 URL 가져오기
	@Override
	public String svcLoginFormURL(SocialType socialType) {
		//Oauth socialOauth = new GoogleOauth();  //다형성
		//Oauth socialOauth = new KakaoOauth();   //다형성
		Oauth socialOauth = getSocialInstance(socialType);
		return socialOauth.getLoginFormURL();
	}

	//OAuth :: 콜백URL을 통한 엑세스 토근 발급
	@Override
	public Map<String, String> svcRequestAccessToken(SocialType socialType, String code, String state) {
		Oauth socialOauth = getSocialInstance(socialType);
		return socialOauth.requestAccessToken(code);
	}

	//OAuth :: 엑세스 토근을 사용한 구글서비스(profile) 가져오기
	@Override
	public Map<String, String> svcRequestUserInfo(SocialType socialType, String accessToken) {
		Oauth socialOauth = getSocialInstance(socialType);
		return socialOauth.getUserInfo(accessToken);
	}
	
	//OAuth :: 기존회원/신규회원 구분을 위한 DB조회
	@Override
	public UsersTblVO svcCheckExistUser(String email) {
		UsersTblVO existingUserVO  = userMapper.findUserByEmail(email);
		return existingUserVO;
	}
	
	//OAuth :: 신규회원: 3.회원정보저장 -->  3.토큰저장  (1: [0,1])
	@Override
	public int svcInsertToken(UsersTblVO usersTblVO) {
		userMapper.insertUsersTbl(usersTblVO);
        System.out.println("SEQ CURRVAL:" + usersTblVO.getUserSeq());
        
        //user_tbl에 입력한 user_seq 시퀀스번호를 user_oauth의 user_seq값으로 사용
        usersTblVO.getUsersOauthVO().setUserSeq(usersTblVO.getUserSeq());
        userMapper.insertUsersOauthTbl(usersTblVO.getUsersOauthVO());
        return usersTblVO.getUserSeq();
	}
		
	//OAuth :: 기존회원:토큰갱신
	@Override
	public void svcUpdateToken(UsersOauthVO usersOauthVO) {
		userMapper.updateUserOauthTbl(usersOauthVO);
	}
	
	
	//일반유저 회원가입
	@Override
	public void svcFormJoin(UsersTblVO usersTblVO) {
		userMapper.formJoin(usersTblVO);
		
	}
	
	//일반유저 로그인
	@Override
	public UsersTblVO svcFormLogin(UsersTblVO usersTblVO) {
		return userMapper.formLogin(usersTblVO);
		
	}
	
}