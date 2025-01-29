package com.barobaro.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.barobaro.app.mapper.NotificationMapper;
import com.barobaro.app.service.NotificationService;
import com.barobaro.app.vo.NotificationVO;

@Service
public class NotificationServiceImpl implements NotificationService {
	@Autowired
	private NotificationMapper mapper;
	
	@Override
	public void addNotification(NotificationVO nvo) {
		mapper.insertNotification(nvo);
	}

	@Override
	public List<NotificationVO> getUnreadNotifications(int userSeq) {
		return mapper.selectUnreadNotifications(userSeq);
	}

	@Override
	public void markNotificationAsRead(int notificationSeq) {
		mapper.markAsRead(notificationSeq);
	}

}
