package com.barobaro.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.barobaro.app.mapper.ChatMapper;
import com.barobaro.app.service.ChatService;
import com.barobaro.app.vo.ChatMessageVO;
import com.barobaro.app.vo.ChatRoomVO;

@Service
public class ChatServiceImpl implements ChatService{

	@Autowired
    private ChatMapper chatMapper;
	
	@Override
	public long createOrGetChatRoomSeq(long senderSeq, long targetUserSeq) {
		ChatRoomVO chatRoomVO = chatMapper.findChatRoomByUsers(senderSeq, targetUserSeq);
		if(chatRoomVO != null) return chatRoomVO.getChatRoomSeq();
		chatRoomVO = new ChatRoomVO();
		chatMapper.createRoom(chatRoomVO);
		chatMapper.createRoomMember(senderSeq, chatRoomVO.getChatRoomSeq());
		chatMapper.createRoomMember(targetUserSeq, chatRoomVO.getChatRoomSeq());
		return chatRoomVO.getChatRoomSeq();
	}

	@Override
	public List<ChatRoomVO> getRoomsByUserSeq(long userSeq) {
		return chatMapper.getRoomsByUserSeq(userSeq);
	}

	@Override
	public List<ChatMessageVO> selectMessagesByRoomSeq(long roomSeq) {
		return chatMapper.selectMessagesByRoomSeq(roomSeq);
	}

}
