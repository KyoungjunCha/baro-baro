package com.barobaro.app.vo;

import lombok.Builder;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatRoomMemberVO {
	private long chatRoomMemberSeq;
	private long joinUserSeq;
	private Date joinAt;
	private long chatRoomSeq;
}
