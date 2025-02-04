package com.barobaro.app.service.impl;

import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.FormHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.stereotype.Component;
//import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.barobaro.app.common.CommonCode.SocialType;
import com.barobaro.app.common.CommonCode.UserInfo;
import com.barobaro.app.common.CommonCode;

import com.barobaro.app.service.Oauth;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;


@Component
@RequiredArgsConstructor
public class NaverOauth implements Oauth {
	@Value("${naver.loginform.url}")
	private String LOGIN_FORM_URL;
	@Value("${naver.client.id}")
	private String CLIENT_ID;
	
	@Value("${naver.client.pw}")
	private String CLIENT_PW;
	
	@Value("${naver.redirect.uri}")
	private String CALLBACK_URL;
	@Value("${naver.endpoint.token}")
	private String ENDPOINT_URL_TOKEN;
	@Value("${naver.endpoint.userinfo}")
	private String ENDPOINT_URL_USERINFO;
	private String ACCESS_TOKEN  = "";
    
	//	public static String commonBuildQueryString(Map<String, Object> params) {
	//		StringBuilder queryString = new StringBuilder();
	//		try {
	//			for (Map.Entry<String, Object> entry : params.entrySet()) {
	//				if (queryString.length() > 0) {
	//					queryString.append("&");
	//				}
	//				queryString.append(URLEncoder.encode(entry.getKey(), "UTF-8"))
	//				.append("=")
	//				.append(URLEncoder.encode(entry.getValue().toString(), "UTF-8"));
	//			}
	//		} catch(UnsupportedEncodingException e) {
	//			e.printStackTrace();
	//		}
	//		return queryString.toString();
	//	}

	/** 
	 * 네이버의 로그인창 주소
	 */
	@Override
	public String getLoginFormURL(SocialType socialType, String state) {
		Map<String, Object> params = new HashMap<>();
		params.put("response_type"	, "code");
		params.put("client_id"		, CLIENT_ID);
		params.put("client_secret", CLIENT_PW);
		params.put("redirect_uri"	, CALLBACK_URL);
		params.put("state", state);
		params.put("scope"			, "profile_nickname%20profile_image");
		params.put("access_type"	, "offline");		
		params.put("prompt"			, "consent");



		//String parameterString = commonBuildQueryString(params);
		String parameterString = params.entrySet().stream()
				.map(x -> x.getKey() + "=" + x.getValue())
				.collect(Collectors.joining("&"));  
		
		System.out.println("naverOauth : "+ parameterString);
		//https://accounts.google.com/o/oauth2/v2/auth?client_id=__&redirect_uri=__&response_type=code&scope=email profile openid&access_type=offline
		return LOGIN_FORM_URL + "?" + parameterString;
	}

	/** 
	 * AccessToken 받기
	 */
	@Override
	public Map<String, String> requestAccessToken(String code) {
	    System.out.println("Received authorization code: " + code);

	    // OAuth 요청에 필요한 파라미터들
	    MultiValueMap<String, String> bodys = new LinkedMultiValueMap<>();
	    bodys.add("code", code);
	    bodys.add("client_id", CLIENT_ID);
		bodys.add("client_secret", CLIENT_PW);
	    bodys.add("redirect_uri", CALLBACK_URL);
	    bodys.add("grant_type", "authorization_code");
	    bodys.add("state", "state");

	    HttpHeaders headers = new HttpHeaders();
	    headers.set("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");  // Content-Type 설정

	    // HttpEntity에 파라미터와 헤더를 함께 전달
	    HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(bodys, headers);

	    // RestTemplate 설정
	    RestTemplate restTemplate = new RestTemplate();
	    restTemplate.getMessageConverters().add(new FormHttpMessageConverter());  // 폼 데이터 처리를 위한 FormHttpMessageConverter 추가
	    restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter()); // JSON 추가

	    try {
	        // 네이버 토큰 엔드포인트로 액세스 토큰 요청
	        ResponseEntity<Map<String, String>> responseEntity = restTemplate.exchange(
	            ENDPOINT_URL_TOKEN,    // 네이버의 토큰 엔드포인트
	            HttpMethod.POST,       // POST 방식
	            entity,                // 요청 본문
	            new ParameterizedTypeReference<Map<String, String>>() {}  // 응답 타입
	        );

	        // 액세스 토큰 추출
	        Map<String, String> responseBody = responseEntity.getBody();
	        this.ACCESS_TOKEN = responseBody.get("access_token");

	        System.out.println("naverOauth.requestAccessToken() accessToken: " + this.ACCESS_TOKEN);

	        System.out.println("naverOauth : " + responseBody);
	        
	        return responseBody;  // 응답 본문을 그대로 반환
	    } catch (HttpClientErrorException e) {
	        // 오류 메시지 출력
	        System.out.println("Error: " + e.getMessage());
	        System.out.println("Error Response: " + e.getResponseBodyAsString());
	        throw new RuntimeException("네이버 토큰 요청에 실패했습니다.");
	    }
	}






	/** 
	 * AccessToken을 사용해 유저정보 받기
	 */
	public Map<String, String> getUserInfo(String accessToken) {
		
		 //필수 헤더 정보
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "Bearer " + this.ACCESS_TOKEN);
		HttpEntity<Map<String, String>> entity = new HttpEntity<>(headers);
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<Map<String, String>> responseEntity = restTemplate.exchange(
				ENDPOINT_URL_USERINFO,
			    HttpMethod.GET,
			    entity,
			    new ParameterizedTypeReference<Map<String, String>>() {}
			);		
		System.out.println("4.유저정보 응답:" +responseEntity.getBody().toString());    
		
		return responseEntity.getBody();
	}
	
	
	public UserInfo getUserInfo2(String accessToken) {
	    HttpHeaders headers = new HttpHeaders();
	    headers.set("Authorization", "Bearer " + accessToken);
	    HttpEntity<Map<String, Object>> entity = new HttpEntity<>(headers);
	    
	    RestTemplate restTemplate = new RestTemplate();
	    ResponseEntity<Map<String, Object>> responseEntity = restTemplate.exchange(
	        ENDPOINT_URL_USERINFO, // 네이버 유저 정보 API 엔드포인트
	        HttpMethod.GET,
	        entity,
	        new ParameterizedTypeReference<Map<String, Object>>() {}
	    );
	    
	 // 응답에서 사용자 정보를 추출
	    Map<String, Object> responseBody = responseEntity.getBody();
	    System.out.println("네이버 유저 정보 응답: " + responseBody);
	    
	    if (responseBody == null || !responseBody.containsKey("response")) {
	        throw new RuntimeException("유저 정보 응답이 유효하지 않거나 누락되었습니다.");
	    }
	    
	    // 'response' 키에서 유저 정보 추출
	    Map<String, Object> response = (Map<String, Object>) responseBody.get("response");

	    // null 체크 후 값 추출
	    String nickname = (String) response.getOrDefault("nickname", "Unknown");
	    String email = (String) response.getOrDefault("email", "Unknown");
	    String profileImage = (String) response.getOrDefault("profile_image", "");
	    System.out.println("!!!!!" + profileImage);

	    UserInfo userInfo = new UserInfo();
	    userInfo.setProfile_nickname(nickname);
	    userInfo.setEmail(email);
	    userInfo.setProfile_image(profileImage);
	    userInfo.setUserStatus(CommonCode.UserStatus.ACTIVE); // 상태 값은 적절하게 처리 필요
	    userInfo.setUserRole(CommonCode.Role.GENERAL); // 역할 값은 적절하게 처리 필요
	    System.out.println("여기때문에세션에 안나오냐? : " + userInfo);
	    return userInfo;
	}

	/** 
	 * refreshToken을 사용해 AccessToken 재발급 받기
	 */
	public String getAccessTokenByRefreshToken(String refreshToken) {
		Map<String, String> bodys = new HashMap<>();
		bodys.put("client_id"     , CLIENT_ID);
		bodys.put("client_secret" , CLIENT_PW);
		bodys.put("refresh_token" , refreshToken);
		bodys.put("grant_type"    , "refresh_token");
        
        // HttpEntity (바디) 생성
		RestTemplate restTemplate = new RestTemplate();
		HttpEntity<Map<String, String>> entity = new HttpEntity<>(bodys);
        ResponseEntity<Map<String, String>> responseEntity = restTemplate.exchange(
        		ENDPOINT_URL_TOKEN,
			    HttpMethod.POST,
			    entity,
			    new ParameterizedTypeReference<Map<String, String>>() {}
			);
        System.out.println("4.토큰재발급 응답(body):" + responseEntity.getBody().toString());
        String accessToken= responseEntity.getBody().get("access_token");
        System.out.println("4.토큰요청 응답(갱신된access_token): " + accessToken);
        return accessToken;
	}

	/** 
	 * AccessToken 만료 여부 체크
	 */
	public boolean isTokenExpired(String accessToken) {

		try {
			HttpHeaders headers = new HttpHeaders();
			headers.set("Authorization", "Bearer " + accessToken);
			HttpEntity<String> entity = new HttpEntity<>(headers);
			
			RestTemplate restTemplate = new RestTemplate();
			ResponseEntity<Map<String, String>> responseEntity = restTemplate.exchange(
					ENDPOINT_URL_USERINFO,
				    HttpMethod.POST,
				    entity,
				    new ParameterizedTypeReference<Map<String, String>>() {}
				);
			System.out.println("5.유저정보 응답:" + responseEntity.getBody().toString());
			return false; // 요청 성공 -> 토큰 유효
		} catch (HttpClientErrorException e) {
			if (e.getStatusCode().value() == 401) {
				return true; // 401 Unauthorized -> 토큰 만료
			}
			throw e; // 다른 오류는 예외로 처리
		}
	}




}