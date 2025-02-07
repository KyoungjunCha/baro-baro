package com.barobaro.app.service;

import java.util.List;

import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.barobaro.app.vo.ChatMessageVO;
import com.barobaro.app.vo.ChatRoomVO;

public interface ChatService {
	long createOrGetChatRoomSeq(long requestUserSeq, long targetPostSeq);
	List<ChatRoomVO> getAllRoomsWithMessagesByUserSeq(long userSeq);
	void insertChatMessageVO(ChatMessageVO chatMessageVO);
	//List<ChatRoomVO> getRoomsByUserSeq(long userSeq);
	//List<ChatMessageVO> selectMessagesByRoomSeq(long roomSeq);
	SseEmitter add(long userSeq, SseEmitter emitter);
	void chatNotificateAboutNewChat(Long userSeq, ChatMessageVO chatMessageVO);
}
