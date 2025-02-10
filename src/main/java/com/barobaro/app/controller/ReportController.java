package com.barobaro.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.barobaro.app.common.CommonCode.Role;
import com.barobaro.app.common.CommonCode.UserInfo;
import com.barobaro.app.common.CommonCode.UserStatus;
import com.barobaro.app.service.ReportService;
import com.barobaro.app.vo.CommentVO;

@Controller
@RequestMapping("post")
public class ReportController {
	
	@Autowired
	ReportService reportService;
	
	// 신고 등록
	@RequestMapping(value = "/report_post_submit", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, String>> reportPostSubmit(
			@RequestParam String reportCategory,		// 신고사유
			@RequestParam String reportReason,			// 신고 상세
			//@RequestParam int userSeq,  // JSP에서 userSeq를 전달받음
			@RequestParam(required = false) Integer reportUser,	// 신고할 유저
			@RequestParam(required = false) Integer reportPost,// 신고할 게시물
			HttpSession session
			) { // 세션 추가
		
		// 세션에 user 정보 저장 (예제 사용자)
		UserInfo userInfo = new UserInfo(1002, "jemu@example.com", "이제무", "", UserStatus.ACTIVE, Role.GENERAL);
        session.setAttribute("user_info", userInfo);

        // 세션에서 userSeq 가져오기
        long userSeq = userInfo.getUserSeq();
		System.out.println("ReportController reportPostSubmit : 신고등록");
		
	    System.out.println("reportCategory: " + reportCategory);
	    System.out.println("reportReason: " + reportReason);
	    System.out.println("userSeq: " + userSeq);
	    System.out.println("reportUser: " + reportUser);
	    System.out.println("reportPost: " + reportPost);
		
	    // 나중에 세션에서 userSeq를 가져오도록 변경 가능
		// Integer userSeq = (Integer) session.getAttribute("userSeq");

		// 필수 필드 검증 (JSP에서도 처리하겠지만, 서버에서도 검증하는 것이 안전함)
		if (reportCategory == null || reportCategory.trim().isEmpty()) {
			Map<String, String> response = new HashMap<String, String>();
	        response.put("message", "카테고리를 선택하세요.");
	        return ResponseEntity.badRequest().body(response);
		}
		if (userSeq <= 0) {
			Map<String, String> response = new HashMap<String, String>();
	        response.put("message", "잘못된 사용자 정보입니다.");
	        return ResponseEntity.badRequest().body(response);
		}

		// 신고 등록 처리
	    try {
	        reportService.insertReport(reportCategory, reportReason, userSeq, reportUser, reportPost);
	    } catch (IllegalArgumentException e) {
	        // 중복 신고 예외 처리
	    	System.out.println("catch문 실행");
	        if (e.getMessage().equals("이미신고한게시물")) {
	        	System.out.println("신고한 게시물");
	        	Map<String, String> response = new HashMap<String, String>();
	            response.put("message", "이미 신고한 게시물입니다.");
	            return ResponseEntity.badRequest().body(response);
	        }
	        System.out.println("신고한 게시물이 아닐");
	        Map<String, String> response = new HashMap<String, String>();
	        response.put("message", "게시물 신고 중 오류가 발생했습니다. 다시 실행해주세요.");
	        return ResponseEntity.badRequest().body(response);
	    }
	    Map<String, String> response = new HashMap<String, String>();
	    response.put("message", "신고가 정상적으로 접수되었습니다.");
	    return ResponseEntity.ok(response);
		
	}
}

