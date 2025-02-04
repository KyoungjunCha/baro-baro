package com.barobaro.app.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NotificationVO {
	private int notificationSeq;
	private String notificationType;
	private String title;
	private String contents;
	private int isRead;
	private Date createdAt;
	private String link;
	private int userSeq;
}
