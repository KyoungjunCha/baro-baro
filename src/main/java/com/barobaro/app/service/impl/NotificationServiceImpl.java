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
			System.out.println("기존 SSE 연결 종료: " + userSeq);
			try {
	            oldEmitter.complete(); // 기존 Emitter를 명확히 종료
	        } catch (Exception e) {
	            System.out.println("기존 Emitter 종료 중 오류 발생: " + e.getMessage());
	        }
	        emitters.remove(userSeq);
		}

		SseEmitter emitter = new SseEmitter(60 * 60 * 1000L); // 1시간 타임아웃 60 * 60 * 1000L
		emitters.put(userSeq, emitter);

		emitter.onCompletion(() -> {
			System.out.println("SSE 연결 종료: " + userSeq);
			emitters.remove(userSeq);
			//subscribe(userSeq);
		});
		emitter.onTimeout(() -> {
			System.out.println("SSE 연결 타임아웃: " + userSeq);
			emitters.remove(userSeq);
			//subscribe(userSeq);
		});

		System.out.println("SSE 연결이 열렸습니다. 사용자 ID: " + userSeq);
		
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
			System.err.println("Emitter 없음. 사용자: " + nvo.getUserSeq());
			//emitter = subscribe(nvo.getUserSeq());
			return;
		}

		try {
			addNotification(nvo);
			System.out.println("알림 저장: " + nvo.getTitle());
			
			final SseEmitter finalEmitter = emitter;
			executor.execute(() -> {
				try {
					if (!emitters.containsKey(nvo.getUserSeq())) {
	                    System.out.println("SSE 연결이 종료되어 알림을 보낼 수 없습니다.");
	                    return;
	                }
					String notificationJson = new ObjectMapper().writeValueAsString(nvo);
					finalEmitter.send(SseEmitter.event().name("notification").data(notificationJson));
					System.out.println("알림 전송 완료: " + nvo.getUserSeq());
				} catch (IOException | IllegalStateException e) {
					System.err.println("알림 전송 오류: " + e.getMessage());
					emitters.remove(nvo.getUserSeq());
				}
			});
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@PreDestroy
	public void shutdownExecutor() {
		System.out.println("ExecutorService 종료");
		executor.shutdown();
	}

	@Override
	public List<NotificationVO> getAllNotifications(int userSeq) {
		return mapper.selectAllNotifications(userSeq);
	}

	@Override
	public void markAllAsRead(int userSeq) {
		mapper.markAllAsRead(userSeq);
	}

}
