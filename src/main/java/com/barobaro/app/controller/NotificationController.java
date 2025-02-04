package com.barobaro.app.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.barobaro.app.service.NotificationService;
import com.barobaro.app.vo.NotificationVO;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
@RequestMapping("/notification")
public class NotificationController {
	@Autowired
	private NotificationService service;

	// 클라이언트별 SSE 연결 관리
	private Map<Integer, SseEmitter> emitters = new HashMap<Integer, SseEmitter>();
	private ExecutorService executor = Executors.newCachedThreadPool();

	@CrossOrigin(origins = "http://localhost:8081")
	@RequestMapping(value = "/subscribe/{userSeq}", method = RequestMethod.GET)
	public SseEmitter subscribe(@PathVariable int userSeq) {
		SseEmitter emitter = new SseEmitter(30 * 60 * 1000L); // 30분 타임아웃
		emitters.put(userSeq, emitter);

		final int finalUserSeq = userSeq;

		// 타임아웃 시 emitter 제거
		emitter.onTimeout(new Runnable() {
			@Override
			public void run() {
				emitters.remove(finalUserSeq);
			}
		});
		
		// 연결 완료 시 emitter 제거
		emitter.onCompletion(new Runnable() {
			@Override
			public void run() {
				emitters.remove(finalUserSeq);
			}
		});

		 // 서버 로그로 확인
	    System.out.println("SSE 연결이 열렸습니다. 사용자 ID: " + userSeq);
		
		return emitter;
	}

	@RequestMapping(value = "/send", method = RequestMethod.POST)
	public void sendNotification(@RequestBody NotificationVO nvo) {
		//service.addNotification(nvo); // DB에 알림 저장
		
		// 사용자에게 SSE로 알림 전송
		SseEmitter emitter = emitters.get(nvo.getUserSeq());
		final SseEmitter finalEmitter = emitter;
		final NotificationVO finalNvo = nvo;
		
		if(emitter != null) {
			executor.execute(new Runnable() {
				@Override
				public void run() {
					try {
						String notificationJson = new ObjectMapper().writeValueAsString(finalNvo);  // NotificationVO 객체를 JSON으로 직렬화
						finalEmitter.send(SseEmitter.event()
								.name("notification")
								.data(notificationJson)); // 알림 데이터 전송
						System.out.println("Notification sent to user: " + finalNvo.getUserSeq());  // 디버그용 로그
						System.out.println("알림 전송 데이터: " + notificationJson);  // 서버에서 전송되는 알림 데이터 확인
					} catch (IOException e) {
						System.err.println("Error sending notification: " + e.getMessage());
						emitters.remove(finalNvo.getUserSeq());
					}	
				}
			});
		} else {
	        System.err.println("Emitter not found for user: " + nvo.getUserSeq());
	    }
		
	}

}
