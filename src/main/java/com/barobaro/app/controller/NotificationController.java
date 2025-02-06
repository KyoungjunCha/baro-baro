package com.barobaro.app.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.barobaro.app.common.CommonCode.Role;
import com.barobaro.app.common.CommonCode.UserInfo;
import com.barobaro.app.common.CommonCode.UserStatus;
import com.barobaro.app.service.NotificationService;
import com.barobaro.app.vo.NotificationVO;

@RestController
@RequestMapping("/notification")
public class NotificationController {
	@Autowired
	private NotificationService service;

	// 세션 userSeq 
	@RequestMapping(value = "/getUserSeq", method = RequestMethod.GET)
	@ResponseBody
	public Long getUserSeq(HttpSession session) {
		UserInfo userInfo = (UserInfo) session.getAttribute("user_info");
	    if (userInfo == null) {
	        userInfo = new UserInfo(1001, "test@test.com", "test nickname", "", UserStatus.ACTIVE, Role.ADMIN);
	        session.setAttribute("user_info", userInfo);
	    }
	    return userInfo.getUserSeq();
	}
	
	@CrossOrigin(origins = "http://localhost:8089")
	@RequestMapping(value = "/subscribe", method = RequestMethod.GET)
	public SseEmitter subscribe(HttpSession session) {
		session.setAttribute("user_info", new UserInfo(1001, "test@test.com", "test nickname","", UserStatus.ACTIVE, Role.ADMIN));
		UserInfo userInfo = (UserInfo) session.getAttribute("user_info");
		long userSeq = userInfo.getUserSeq();
		return service.subscribe((int) userSeq);
	}

	@RequestMapping(value = "/send", method = RequestMethod.POST)
	public void sendNotification(@RequestBody NotificationVO nvo) {
		service.sendNotification(nvo);
	}

	@RequestMapping(value = "/notification-list", method = RequestMethod.GET)
//	public List<NotificationVO> getAllNotifications(Model model, @RequestParam("userSeq") int userSeq) {
	public List<NotificationVO> getAllNotifications(Model model, HttpSession session) {
		session.setAttribute("user_info", new UserInfo(1001, "test@test.com", "test nickname","", UserStatus.ACTIVE, Role.ADMIN));
		UserInfo userInfo = (UserInfo) session.getAttribute("user_info");
		long userSeq = userInfo.getUserSeq();
		List<NotificationVO> list = service.getAllNotifications((int) userSeq);
		return list;
	}

	@RequestMapping(value = "/mark-read/{notificationSeq}", method = RequestMethod.POST)
	public ResponseEntity<String> markAsRead(@PathVariable int notificationSeq, @RequestParam boolean isRead) {
		service.markNotificationAsRead(notificationSeq, isRead);
		return ResponseEntity.ok("알람 읽음 처리 완료");
	}

	@RequestMapping(value = "/mark-all-read", method = RequestMethod.POST)
	// public ResponseEntity<String> markAllAsRead(@RequestParam int userSeq) {
	public ResponseEntity<String> markAllAsRead(HttpSession session) {
		session.setAttribute("user_info", new UserInfo(1001, "test@test.com", "test nickname","", UserStatus.ACTIVE, Role.ADMIN));
		UserInfo userInfo = (UserInfo) session.getAttribute("user_info");
		long userSeq = userInfo.getUserSeq();
		service.markAllAsRead((int) userSeq);
		return ResponseEntity.ok("모든 알림이 읽음 처리되었습니다.");
	}
}
