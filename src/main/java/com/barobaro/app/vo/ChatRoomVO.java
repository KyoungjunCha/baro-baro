package com.barobaro.app.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ChatRoomVO {
	 private long chatRoomSeq;
	 private Date regdate;
	 //detail 정보
	 private long userSeq;
	 private String userNickName;
	 private String profileImage;
}
