package com.barobaro.app.service.impl;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.annotation.PreDestroy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.barobaro.app.mapper.NotificationMapper;
import com.barobaro.app.service.NotificationService;
import com.barobaro.app.vo.NotificationVO;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class NotificationServiceImpl implements NotificationService {
	@Autowired
	private NotificationMapper mapper;

	private Map<Integer, SseEmitter> emitters = new ConcurrentHashMap<Integer, SseEmitter>();
	private ExecutorService executor = Executors.newCachedThreadPool();

	@Override
	public void addNotification(NotificationVO nvo) {
		mapper.insertNotification(nvo);
	}

	@Override
	public List<NotificationVO> getUnreadNotifications(int userSeq) {
		return mapper.selectUnreadNotifications(userSeq);
	}

	@Override
	public void markNotificationAsRead(int notificationSeq, boolean isRead) {
		mapper.markAsRead(notificationSeq, isRead ? 1 : 0);
	}

	@Override
	public SseEmitter subscribe(int userSeq) {
		if (emitters.containsKey(userSeq)) {
			SseEmitter oldEmitter = emitters.get(userSeq);
			try {
	            oldEmitter.complete(); // 기존 Emitter를 명확히 종료
	        } catch (Exception e) {
	        }
	        emitters.remove(userSeq);
		}

		SseEmitter emitter = new SseEmitter(60 * 60 * 1000L); // 1시간 타임아웃 60 * 60 * 1000L
		emitters.put(userSeq, emitter);

		emitter.onCompletion(() -> {
			//emitters.remove(userSeq);
		});
		
		emitter.onTimeout(() -> {
			//emitters.remove(userSeq);
		});

		
		return emitter;
	}

//	public void keepAlive(SseEmitter emitter, int userSeq) {
//	    executor.execute(() -> {
//	        while (emitters.containsKey(userSeq)) {
//	            try {
//	                emitter.send(SseEmitter.event().name("keep-alive").data("ping"));
//	                Thread.sleep(30000); // 30초마다 전송
//	            } catch (IOException | InterruptedException e) {
//	                emitters.remove(userSeq);
//	                break;
//	            }
//	        }
//	    });
//	}

	@Override
	public void sendNotification(NotificationVO nvo) {
		// 사용자에게 SSE로 실시간 알림 전송
		SseEmitter emitter = emitters.get(nvo.getUserSeq());

		if (emitter == null) {
			//emitter = subscribe(nvo.getUserSeq());
			return;
		}

		try {
			addNotification(nvo);
			
			final SseEmitter finalEmitter = emitter;
			executor.execute(() -> {
				try {
					if (!emitters.containsKey(nvo.getUserSeq())) {
	                    return;
	                }
					String notificationJson = new ObjectMapper().writeValueAsString(nvo);
					finalEmitter.send(SseEmitter.event().name("notification").data(notificationJson));
				} catch (IOException | IllegalStateException e) {
					emitters.remove(nvo.getUserSeq());
				}
			});
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

//	@PreDestroy
	
//	public void shutdownExecutor() {
//		System.out.println("ExecutorService 종료");
//		executor.shutdown();
//	}

	@Override
	public List<NotificationVO> getAllNotifications(int userSeq) {
		return mapper.selectAllNotifications(userSeq);
	}

	@Override
	public void markAllAsRead(int userSeq) {
		mapper.markAllAsRead(userSeq);
	}

}
