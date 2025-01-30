package com.barobaro.app.service;

import java.util.List;

import com.barobaro.app.vo.NotificationVO;

public interface NotificationService {
	public void addNotification(NotificationVO nvo);
	public List<NotificationVO> getUnreadNotifications(int userSeq);
	public void markNotificationAsRead(int notificationSeq);
}
