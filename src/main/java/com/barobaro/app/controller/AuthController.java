package com.barobaro.app.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.barobaro.app.common.CommonCode;
import com.barobaro.app.common.CommonCode.Role;
import com.barobaro.app.common.CommonCode.SocialType;
import com.barobaro.app.common.CommonCode.UserInfo;
import com.barobaro.app.common.CommonCode.UserStatus;
import com.barobaro.app.common.StateGenerator;
import com.barobaro.app.service.OauthService;
import com.barobaro.app.vo.UsersOauthVO;
import com.barobaro.app.vo.UsersTblVO;

@Controller
public class AuthController {

	@Autowired
	private OauthService oauthService;
	
	
	
	
	//관리자
	// 관리자 페이지로 이동 (유저 목록 조회)
    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String viewAdminPage(Model model, HttpServletRequest request) {
        // 세션에서 관리자 권한 확인
    	Role userRole = (Role) request.getSession().getAttribute("SESS_ROLE");

    	if (userRole != null && "ADMIN".equals(userRole.name())) {  // name()을 사용하여 비교
            // 관리자라면 유저 관리 페이지로 이동
            List<UsersTblVO> users = oauthService.svcGetAllUsers();
            model.addAttribute("users", users); // 모델에 유저 목록을 담
            return "lec_oauth/admin_page";  // 관리자 페이지 JSP로 리다이렉트
    	}else {
    		 // 관리자가 아니면 접근 제한
            return "lec_oauth/main";
    	}
    }

    // 유저 정보 수정 (상태와 권한 변경)
    @RequestMapping(value = "/admin/updateUser", method = RequestMethod.POST)
    public String updateUser(@ModelAttribute UsersTblVO updatedUser, HttpServletRequest request) {
        // 세션에서 관리자가 맞는지 확인
    	Role userRole = (Role) request.getSession().getAttribute("SESS_ROLE");
        
    	
//    	if (userRole == null || !userRole.equals(CommonCode.Role.ADMIN.name())) {
//            return "redirect:/main"; // 관리자 권한이 없는 경우 메인 페이지로 리다이렉트
//        }

    	if (userRole == null && !"ADMIN".equals(userRole.name())) {  // name()을 사용하여 비교
            return "lec_oauth/main";  // 관리자 페이지 JSP로 리다이렉트
    	}
        
        // 유저 정보 업데이트
        int result = oauthService.svcUpdateAdminUserInfo(updatedUser);

        if (result > 0) {
        	System.out.println("유저정보 바꿨냐 ? : " + result);
            return "redirect:/admin"; // 수정 후 관리자 페이지로 리다이렉트
        } else {
            return "redirect:/admin?error=true"; // 수정 실패 시 에러 표시
        }
    }
	
	
	
	

	// 로그아웃
	@RequestMapping(value = "/form_logout_process", method = RequestMethod.POST)
	public String ctlFormLoginProcess(Model model, HttpServletRequest request) {
		request.getSession().invalidate();
		request.getSession().setMaxInactiveInterval(0);
		return "lec_oauth/main";
	}
	
	//마이페이지
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String ctlViewMypage(Model model, HttpServletRequest request) {
	    // 세션에서 이메일 가져오기
	    String email = (String) request.getSession().getAttribute("SESS_EMAIL");
	    System.out.println("업데이트되는 이메일 세션에서 가져옴 : " + email);
	    String nickname = (String) request.getSession().getAttribute("SESS_PROFILE_NICKNAME");
	    System.out.println("업데이트되는 닉네임 세션에서 가져옴 : " + nickname);
	    
	    
	    UserInfo userInfo = (UserInfo) request.getSession().getAttribute("user_info");
	    
	    if (email == null || nickname == null) {
	        // 이메일혹은 닉네임 없으면 로그인 페이지로 리다이렉트
	        return "redirect:/login_page";
	    }

	    // 이메일로 해당 유저 정보 확인
//	    UserInfo user2 = oauthService.svcCheckExistUser(email, nickname);
	    UsersTblVO user = oauthService.svcCheckExistUser(email, nickname); // DB에서 이메일로 유저 조회
	    System.out.println("그러면 여기에 userseq 도 담겨 오려나: " + user);
	    System.out.println("이렇게 써야하는건가 ? : " + user.getUserSeq());
	    if (userInfo != null) {
	        // 사용자 정보를 마이페이지에서 보여줌
	        model.addAttribute("user", user);
//	        model.addAttribute("user", userInfo);
	    } else {
	        // 유저가 없으면 오류 처리 또는 로그인 페이지로 리다이렉트
	        return "redirect:/login_page";
	    }

	    return "lec_oauth/mypage"; // 마이페이지로 이동
	}

	@RequestMapping(value = "/updateUserInfo", method = RequestMethod.POST)
	public String ctlUpdateUserInfo(@ModelAttribute UsersTblVO updatedUser, HttpServletRequest request) {
	    // 세션에서 이메일 가져오기
	    String email = (String) request.getSession().getAttribute("SESS_EMAIL");
	    System.out.println("업데이트되는 이메일 세션에서 가져옴 : " + email);
	    String nickname = (String) request.getSession().getAttribute("SESS_PROFILE_NICKNAME");
	    System.out.println("업데이트되는 닉네임 세션에서 가져옴 : " + nickname);
	    
	    
	    if (email == null || nickname == null) {
	        // 이메일이 없으면 로그인 페이지로 리다이렉트
	        return "redirect:/form_logout_process";
	    }

	    // 이메일로 해당 유저 정보 확인
	    UsersTblVO existingUser = oauthService.svcCheckExistUser(email, nickname);

	    if (existingUser != null) {
	        // 유저가 맞으면 정보 업데이트
	        updatedUser.setEmail(existingUser.getEmail());  // 기존 이메일 유지
	        int result = oauthService.svcUpdateUserInfo(updatedUser);  // DB에 정보 업데이트

	        if (result > 0) {
	            // 수정 성공시 재로그인 리다이렉트
	        	request.getSession().invalidate();
	    		request.getSession().setMaxInactiveInterval(0);
	        	System.out.println("여기는 성공 : " + result);
	            return "redirect:/login_page";
	        } else {
	            // 수정 실패 시 오류 메시지 표시
	        	System.out.println("여기는 실패");
	            return "redirect:/mypage?error=true";
	        }
	    } else {
	        // 유저가 없으면 로그인 페이지로 리다이렉트
        	System.out.println("여기는 유저없음");
	        return "redirect:/login_page";
	    }
	}


	// 로그인 페이지
	@RequestMapping(value = "/login_page", method = RequestMethod.GET)
	public String ctlViewLoginPage(Model model, HttpServletRequest request) {
//		 String email = (String) request.getSession().getAttribute("SESS_EMAIL");
//	        if (email != null) {
//	            return "redirect:/mypage"; // 이미 로그인 된 경우 마이페이지로 이동  // 여기 바뀜
//	        }
	        return "lec_oauth/login_page"; // 로그인 페이지  // 여기 바뀜
	}

	/**
	 * 구글/네이버/카카오로 로그인 시 로그인창 이동 --> 회원 동의 후 /oauth2callback 자동 호출
	 * @param socialType (GOOGLE, NAVER, KAKAO)
	 */
	@RequestMapping(value = "/login/{socialType}", method = RequestMethod.GET)
	public String loginForm(Model model, @PathVariable("socialType") SocialType socialType, HttpServletRequest request) {
		System.out.println("뭘로 들어옴? : " + socialType);
		
		String state = StateGenerator.generateState();
		System.out.println("네이버를 위한 생성된 state 인데 찍히는가 : " + state);
		
		request.getSession().setAttribute("SESS_SOCIALTYPE", socialType);
		request.getSession().setAttribute("state", state);
		System.out.println("세션에 저장된 state 값 : " + request.getSession().getAttribute("state"));  // 세션에 저장된 state 값 로그
		
		String loginFormUrl = oauthService.svcLoginFormURL(socialType,state);
		System.out.println("세션에 넣고난 뒤에 state 값은 ? : " + loginFormUrl);

		return "redirect:" + loginFormUrl;
	}

	/**
	 * callback 통해 access token 획득 후 신규회원(회원가입페이지)/기존회원(토큰저장 후 마이페이지) 이동 
	 * @param socialType (GOOGLE, NAVER, KAKAO)
	 */
	@RequestMapping(value = "/oauth2callback/{socialType}", method = RequestMethod.GET)
	public String ctlCallback(Model model, @PathVariable("socialType") SocialType socialType, 
			@RequestParam("code") String code,
			@RequestParam(value = "state", required = false) String state,
			HttpServletRequest request) {

		
		  // 세션에서 저장된 state 값 가져오기
	    String sessionState = (String) request.getSession().getAttribute("state");
	    System.out.println("세션에서 가져온 state 값 : " + sessionState);
	    System.out.println("네이버에서 받은 state 값 : " + state);
	    
	    // state 값 검증 (CSRF 방지)
	    if (sessionState == null || !sessionState.equals(state)) {
	        throw new SecurityException("State value mismatch - CSRF attack possible!");
	    }
		
		// socialType 세션에서 가져오기
		socialType = (SocialType) request.getSession().getAttribute("SESS_SOCIALTYPE");
		System.out.println("ctlCallback!!!" + socialType);
//		System.out.println(socialType + "----" + code);

		// CODE를 사용해 ACCESS TOKEN 받기
		Map<String, String> responseMap = oauthService.svcRequestAccessToken(socialType, code, state);
		String accessToken = (String) responseMap.get("access_token");
		String refreshToken = (String) responseMap.get("refresh_token");
		
		System.out.println("OauthController.ctlCallback() access_token:" + accessToken);
		System.out.println("OauthController.ctlCallback() refresh_token:" + refreshToken);

		// ACCESS TOKEN을 사용해 REST 서비스(유저정보) 받기
		UserInfo userInfo = oauthService.svcRequestUserInfo(socialType, accessToken);
		System.out.println("OauthController.ctlCallback()!!!!:" + userInfo.toString());
		
		

	    System.out.println("사용자 정보: " + userInfo.toString());
	    
	    // 세션에 저장할 UserInfo 객체 생성
	    UserInfo userInfoObject = new UserInfo(
	        userInfo.getUserSeq(),
	        userInfo.getEmail(),
	        userInfo.getProfile_nickname(),
	        refreshToken, 
	        UserStatus.ACTIVE,  // 기본값으로 활성 상태
	        Role.GENERAL
	    );
	    
	    // 세션에 UserInfo 객체 저장
	    HttpSession session = request.getSession();
	    session.setAttribute("user_info", userInfoObject);
		
		
		 // 프로필 닉네임을 올바르게 사용
	    String profileNickname = userInfo.getProfile_nickname();
	    System.out.println("닉네임 카카오 제공 : " + profileNickname);
	    String email = userInfo.getEmail();
	    System.out.println("이메일 카카오 제공 : " + email);
	    String profileImage = userInfo.getProfile_image();
	    long userSeq = userInfo.getUserSeq();
	    System.out.println(userSeq);
		
		 UsersTblVO existingUserVO = oauthService.svcCheckExistUser(email, profileNickname);
		 System.out.println("여기에도 없나? : " + existingUserVO);
	    
	    if (existingUserVO != null) {
	    	request.getSession().setAttribute("SESS_USER_SEQ", existingUserVO.getUserSeq());
	        request.getSession().setAttribute("SESS_EMAIL", existingUserVO.getEmail());
	        request.getSession().setAttribute("SESS_PROFILE_NICKNAME", existingUserVO.getNickname());
	        request.getSession().setAttribute("SESS_PROFILE_IMAGE", existingUserVO.getProfile_image());
	        request.getSession().setAttribute("SESS_STATUS", existingUserVO.getStatus());
	        request.getSession().setAttribute("SESS_ROLE", existingUserVO.getRole());
	        
	        System.out.println("기존 사용자 정보 - 이메일: " + existingUserVO.getEmail());
	        System.out.println("기존 사용자 정보 - 닉네임: " + existingUserVO.getNickname());
	    } else {
	        // 신규회원이면 세션에 정보 저장
	        request.getSession().setAttribute("SESS_EMAIL", email);
	        request.getSession().setAttribute("SESS_PROFILE_NICKNAME", profileNickname);
	        request.getSession().setAttribute("SESS_PROFILE_IMAGE", profileImage);
	        
	    }
	    
		
		// 신규 회원일 경우, 회원가입 페이지로 이동
		String viewPage = "lec_oauth/login_page";
		if (existingUserVO == null) {
			// OAuth :: 신규 회원일 경우 -- accessToken 세션에 담고 추가 회원가입 페이지로 이동
			request.getSession().setAttribute("SESS_EMAIL", email);
			request.getSession().setAttribute("SESS_PROVIDER", socialType);
			request.getSession().setAttribute("SESS_ACCESS_TOKEN", accessToken);
			request.getSession().setAttribute("SESS_REFRESH_TOKEN", refreshToken);
			request.getSession().setAttribute("SESS_PROFILE_NICKNAME", profileNickname);
			request.getSession().setAttribute("SESS_STATUS", CommonCode.UserStatus.ACTIVE); // 기본값: 활성
	        request.getSession().setAttribute("SESS_ROLE", CommonCode.Role.GENERAL); // 기본값: 일반 유저
	        request.getSession().setAttribute("SESS_PROFILE_IMAGE", profileImage);
			viewPage = "lec_oauth/join_page";
		} else {
			// 기존 회원일 경우 -- 토큰만 갱신하고 마이페이지로 이동
			
	        // UsersTblVO에서 UsersOauthVO 가져오기
	        UsersOauthVO usersOauthVO = existingUserVO.getUsersOauthVO();
	        if (usersOauthVO == null) {
	            usersOauthVO = new UsersOauthVO();  // 만약 UsersOauthVO가 null일 경우 초기화
	            existingUserVO.setUsersOauthVO(usersOauthVO);
	            System.out.println("hear : " +  existingUserVO);
	        }

	        // UsersOauthVO에 accessToken과 refreshToken 설정
	        usersOauthVO.setAccessToken(accessToken);
	        usersOauthVO.setRefreshToken(refreshToken);


			// 세션 정보 갱신
	        request.getSession().setAttribute("SESS_USER_SEQ", existingUserVO.getUserSeq());
	        request.getSession().setAttribute("SESS_EMAIL", existingUserVO.getEmail());
			request.getSession().setAttribute("SESS_PROVIDER", socialType);
			request.getSession().setAttribute("SESS_ACCESS_TOKEN", accessToken);
			request.getSession().setAttribute("SESS_REFRESH_TOKEN", refreshToken);
			request.getSession().setAttribute("SESS_PROFILE_NICKNAME", userInfo.getProfile_nickname());
			request.getSession().setAttribute("SESS_PROFILE_IMAGE", userInfo.getProfile_image());
			request.getSession().setAttribute("SESS_STATUS", existingUserVO.getStatus()); // db에서 가져온값 확인
	        request.getSession().setAttribute("SESS_ROLE", existingUserVO.getRole()); // db에서 가져온값 확인
	        viewPage = "/pages/main";  
		}
		return viewPage;
	}

	// 신규 회원: 회원정보 저장 + 토큰 저장
	@RequestMapping(value = "/oauth_join_process", method = RequestMethod.POST)
	public String ctlOauthJoinProcess(Model model, HttpServletRequest request,
			@ModelAttribute UsersTblVO usersTblVO) {
		
		
		// 세션에서 email 값을 가져와서 usersTblVO에 설정
	    String email = (String) request.getSession().getAttribute("SESS_EMAIL");
	    if (email != null) {
	        usersTblVO.setEmail(email);  // 세션에서 가져온 이메일 값을 설정
	    }
		
		// 로그 찍기 (입력된 값 확인)
		System.out.println("Received user data:");
		System.out.println("Email: " + usersTblVO.getEmail());
		System.out.println("Nickname: " + usersTblVO.getNickname());
		System.out.println("Phone: " + usersTblVO.getPhone());
		System.out.println("Address: " + usersTblVO.getAddress());  // 주소 필드가 있을 경우
		System.out.println("Role: " + usersTblVO.getRole());
		System.out.println("Status: " + usersTblVO.getStatus());
		System.out.println("Provider: " + usersTblVO.getProvider());
		
		UsersOauthVO usersOauthVO = usersTblVO.getUsersOauthVO();
		 
	    if (usersOauthVO == null) {
	        usersOauthVO = new UsersOauthVO(); // 만약 usersOauthVO가 null일 경우 초기화
	        usersTblVO.setUsersOauthVO(usersOauthVO);
	    }
		
	    
	    
		// 세션에서 토큰 정보 가져오기
	    usersOauthVO.setAccessToken((String) request.getSession().getAttribute("SESS_ACCESS_TOKEN"));
	    usersOauthVO.setRefreshToken((String) request.getSession().getAttribute("SESS_REFRESH_TOKEN"));
	    
	    
	    
	    // 세션에서 SocialType 정보 가져오기 (SocialType을 String으로 변환)
	    String provider = ((SocialType) request.getSession().getAttribute("SESS_PROVIDER")).name();
	    
	    usersTblVO.setRole(CommonCode.Role.GENERAL);
	    usersTblVO.setStatus(CommonCode.UserStatus.ACTIVE);
	    usersTblVO.setProvider(provider);  // SocialType을 String으로 변환한 값 사용
	    
	    usersTblVO.setNickname((String) request.getSession().getAttribute("SESS_PROFILE_NICKNAME"));
	    usersTblVO.setProfile_image((String) request.getSession().getAttribute("SESS_PROFILE_IMAGE"));
	    
//	    usersTblVO.setEmail((String) request.getSession().getAttribute("SESS_EMAIL"));
	    
	    System.out.println( "여기 뭐라나옴" + usersTblVO);
		// 회원가입 및 토큰 저장
		int insertUserSeq = oauthService.svcInsertToken(usersTblVO);

		// 회원가입 후 처리
		String viewPage = "lec_oauth/login_page";
		if (insertUserSeq < 0) {
			// 회원가입 실패 시
			request.getSession().invalidate();
		} else {
			// 회원가입 성공 시
			request.getSession().removeAttribute("SESS_EMAIL");
			request.getSession().removeAttribute("SESS_PROVIDER");
			request.getSession().removeAttribute("SESS_ACCESS_TOKEN");
			request.getSession().removeAttribute("SESS_REFRESH_TOKEN");
			request.getSession().removeAttribute("SESS_PROFILE_NICKNAME");
			request.getSession().removeAttribute("SESS_PROFILE_IMAGE");
			request.getSession().removeAttribute("SESS_STATUS");

			// 서비스에 필요한 세션 유지
			
			request.getSession().setAttribute("SESS_ROLE", CommonCode.Role.GENERAL); // 기본값: 일반 유저
//			request.getSession().setAttribute("SESS_NICKNAME", usersTblVO.getNickname());
			viewPage = "lec_oauth/login_page";
		}
		return viewPage;
	}
	
	
	
	
}
