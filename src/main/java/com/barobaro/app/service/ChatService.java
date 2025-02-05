package com.barobaro.app.service;

import java.util.List;

import com.barobaro.app.vo.ChatMessageVO;
import com.barobaro.app.vo.ChatRoomVO;

public interface ChatService {
	long createOrGetChatRoomSeq(long senderSeq, long targetUserSeq);
	List<ChatRoomVO> getRoomsByUserSeq(long userSeq);
	List<ChatMessageVO> selectMessagesByRoomSeq(long roomSeq);
}
