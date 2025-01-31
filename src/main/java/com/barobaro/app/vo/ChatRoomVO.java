package com.barobaro.app.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ChatRoomVO {
	 private long roomId;
	 private String title;
	 private Date regdate;
}
