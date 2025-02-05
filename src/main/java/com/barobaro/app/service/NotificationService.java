package com.barobaro.app.service;

import java.util.List;

import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.barobaro.app.vo.NotificationVO;

public interface NotificationService {
	public void addNotification(NotificationVO nvo);
	public List<NotificationVO> getUnreadNotifications(int userSeq);
	public void markNotificationAsRead(int notificationSeq, boolean isRead);
	public SseEmitter subscribe(int userSeq);
	public void sendNotification(NotificationVO nvo);
	public List<NotificationVO> getAllNotifications(int userSeq);
	public void markAllAsRead(int userSeq);
}
