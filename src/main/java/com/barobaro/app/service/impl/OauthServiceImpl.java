package com.barobaro.app.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.barobaro.app.common.CommonCode.SocialType;
import com.barobaro.app.common.CommonCode.UserInfo;
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
		System.out.println("OauthServiceImpl1" + socialType);
//		return socialOauthList.stream()
//				.filter(x -> x.type() == socialType)
//				.findFirst()
//				.orElseThrow(() -> new IllegalArgumentException("Unknown SocialType"));
//		throw new IllegalArgumentException("Unknown SocialType");
		try {
			for (Oauth oauth : socialOauthList) {
			    if (oauth.type() == socialType) {
			    	System.out.println("OauthServiceImpl2 : " + oauth);
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
	public String svcLoginFormURL(SocialType socialType, String state) {
		//Oauth socialOauth = new GoogleOauth();  //다형성
		//Oauth socialOauth = new KakaoOauth();   //다형성
		
		Oauth socialOauth = getSocialInstance(socialType);
		System.out.println("OauthServiceImpl3" + socialOauth);
		return socialOauth.getLoginFormURL(socialType, state);
	}

	//OAuth :: 콜백URL을 통한 엑세스 토근 발급
	@Override
	public Map<String, String> svcRequestAccessToken(SocialType socialType, String code, String state) {
		Oauth socialOauth = getSocialInstance(socialType);
		return socialOauth.requestAccessToken(code);
	}

	//OAuth :: 엑세스 토근을 사용한 구글서비스(profile) 가져오기
//	@Override
//	public Map<String, String> svcRequestUserInfo(SocialType socialType, String accessToken) {
//		Oauth socialOauth = getSocialInstance(socialType);
//		return socialOauth.getUserInfo(accessToken);
//	}
	
	//OAuth :: 엑세스 토큰을 사용한 카카오/네이버(profile) 가져오기
	@Override
	public UserInfo svcRequestUserInfo(SocialType socialType, String accessToken) {
		Oauth socialOauth = getSocialInstance(socialType);
		return socialOauth.getUserInfo2(accessToken);
	}
	
	
	//OAuth :: 기존회원/신규회원 구분을 위한 DB조회
	@Override
	public UsersTblVO svcCheckExistUser(String email, String nickname) {
		UsersTblVO existingUserVO = null;

	    if (email == null || email.isEmpty()) {
	        // 이메일이 없으면 닉네임으로 찾기
	        System.out.println("카카오는 이메일이 없어 nickname으로 확인");
	        existingUserVO = userMapper.findUserByNickname(nickname);  // nickname으로 조회
	        System.out.println("카카오 nickname 으로 확인한 값들 : " + existingUserVO);
	    } else {
	        // 이메일이 있으면 이메일로 조회
	        existingUserVO = userMapper.findUserByEmail(email);
	        System.out.println("현재 카카오 또는 네이버 유저 확인: " + email);
	        System.out.println("유저 정보: " + existingUserVO);
	    }

	    return existingUserVO;
	    
	}
	
	
	
	
	//OAuth :: 신규회원: 3.회원정보저장 -->  3.토큰저장  (1: [0,1])
	@Override
	public int svcInsertToken(UsersTblVO usersTblVO) {
		
		// 이메일이 없으면 profile_nickname을 이메일 대신 사용
	    if (usersTblVO.getEmail() == null || usersTblVO.getEmail().isEmpty()) {
	    	System.out.println("이메일값 없음");
	    	usersTblVO.setEmail(usersTblVO.getEmail());
	    }
	    System.out.println("저장 뭘로 되냐 : " + usersTblVO);
		
	    // 프로필 닉네임을 nickname 컬럼에 저장
	    usersTblVO.setNickname(usersTblVO.getNickname());
	    
		userMapper.insertUsersTbl(usersTblVO);
        System.out.println("SEQ CURRVAL:" + usersTblVO.getUserSeq());
        
        //user_tbl에 입력한 user_seq 시퀀스번호를 user_oauth의 user_seq값으로 사용
        usersTblVO.getUsersOauthVO().setUserSeq(usersTblVO.getUserSeq());
        usersTblVO.getUsersOauthVO().setUserDetailSeq(usersTblVO.getUserSeq());
        
        userMapper.insertUsersOauthTbl(usersTblVO.getUsersOauthVO());
        return usersTblVO.getUserSeq();
	}
	

	
		
	@Override
	public void svcUpdateToken(UsersOauthVO usersOauthVO) {
		userMapper.updateUserOauthTbl(usersOauthVO);
	}
	
	
	@Override
    public int svcUpdateUserInfo(UsersTblVO usersTblVO) {
        return userMapper.updateUsersTbl(usersTblVO);  // DB에서 수정된 행 수 반환
    }


	
	// 관리자 유저 목록 조회
	@Override
    public List<UsersTblVO> svcGetAllUsers() {
        return userMapper.allUser();  // 모든 유저 조회
    }

    // 관리자 유저 정보 업데이트
	@Override
	public int svcUpdateAdminUserInfo(UsersTblVO updatedUser) {
        return userMapper.updateAdminUsersTbl(updatedUser); 
    }
	

	
}