package com.barobaro.app.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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

import com.barobaro.app.service.NotificationService;
import com.barobaro.app.vo.NotificationVO;

@Controller
@RequestMapping("/notification")
public class NotificationController {
	@Autowired
	private NotificationService service;

	@CrossOrigin(origins = "http://localhost:8081")
	@RequestMapping(value = "/subscribe/{userSeq}", method = RequestMethod.GET)
	@ResponseBody
	public SseEmitter subscribe(@PathVariable int userSeq) {
		return service.subscribe(userSeq);
	}

	@RequestMapping(value = "/send", method = RequestMethod.POST)
	@ResponseBody
	public void sendNotification(@RequestBody NotificationVO nvo) {
		service.sendNotification(nvo);
	}
	
	@RequestMapping(value = "/notification-list", method = RequestMethod.GET)
	@ResponseBody
	public List<NotificationVO> getAllNotifications(Model model, @RequestParam("userSeq") int userSeq) {
		List<NotificationVO> list = service.getAllNotifications(userSeq);
		return list;
	}
	
	@RequestMapping(value = "/mark-read/{notificationSeq}", method = RequestMethod.POST)
	public String markAsRead(@PathVariable int notificationSeq) {
		service.markNotificationAsRead(notificationSeq);
		return "redirect:/notification/notification-list";
	}
	

}
