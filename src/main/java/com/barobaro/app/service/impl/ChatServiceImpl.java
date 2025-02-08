package com.barobaro.app.service.impl;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.barobaro.app.mapper.ChatMapper;
import com.barobaro.app.service.ChatService;
import com.barobaro.app.vo.ChatMessageVO;
import com.barobaro.app.vo.ChatRoomVO;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class ChatServiceImpl implements ChatService {

	private final Map<Long, Set<SseEmitter>> emitters = new ConcurrentHashMap<>();
	private final Map<Long, Set<SseEmitter>> chatIconemitters = new ConcurrentHashMap<>();
	
	@Autowired
    private ChatMapper chatMapper;
	


	@Override
	public SseEmitter add(long userSeq, SseEmitter emitter) {
		emitters.computeIfAbsent(userSeq, k -> ConcurrentHashMap.newKeySet()).add(emitter);
		emitter.onCompletion(() -> removeEmitter(userSeq, emitter));
        emitter.onTimeout(() -> removeEmitter(userSeq, emitter));
  
        return emitter; 
	}
	
	@Override
	public SseEmitter chatIconAddSseEmitter(long userSeq, SseEmitter emitter) {
		emitters.computeIfAbsent(userSeq, k -> ConcurrentHashMap.newKeySet()).add(emitter);
		emitter.onCompletion(() -> removeEmitter(userSeq, emitter));
        emitter.onTimeout(() -> removeEmitter(userSeq, emitter));
  
        return emitter;
	}
	
	
	@Override
	public long createOrGetChatRoomSeq(long requestUserSeq, long targetPostSeq) {
		ChatRoomVO chatRoomVO = chatMapper.getChatRoomByUserSeqAndPostSeq(requestUserSeq, targetPostSeq);
		if(chatRoomVO != null) return chatRoomVO.getChatRoomSeq();
		chatRoomVO = ChatRoomVO.builder().requestUserSeq(requestUserSeq).postSeq(targetPostSeq).build();
		chatMapper.createChatRoomByChatRoomVO(chatRoomVO);
		return chatRoomVO.getChatRoomSeq();
	}
	
	@Override
	public void insertChatMessageVO(ChatMessageVO chatMessageVO) {
		chatMapper.insertChatMessage(chatMessageVO);
		ChatMessageVO chatMessageVO2 =
				chatMapper.getRelativeUsersByChatMessage(chatMessageVO.getChatRoomSeq());
		chatNotificateAboutNewChat(chatMessageVO2.getPostOwnerSeq(), chatMessageVO);
		chatNotificateAboutNewChat(chatMessageVO2.getRequestUserSeq(), chatMessageVO);
	}

	@Override
	public List<ChatRoomVO> getAllRoomsWithMessagesByUserSeq(long userSeq) {
		return chatMapper.getAllRoomsWithMessagesByUserSeq(userSeq);
	}
	
	
	
	private void removeEmitter(Long userId, SseEmitter emitter) {
        Set<SseEmitter> userEmitters = emitters.get(userId);
        if (userEmitters != null) {
            userEmitters.remove(emitter);
            if (userEmitters.isEmpty()) {
                emitters.remove(userId);
            }
        }
    }

	@Override
	public void chatNotificateAboutNewChat(Long userSeq, ChatMessageVO chatMessageVO) {
		Set<SseEmitter> userEmitters = emitters.get(userSeq);
		if (userEmitters != null) {
	        for (SseEmitter emitter : userEmitters) {
	            try {
	                // 메시지 전송
	                emitter.send(SseEmitter.event()
	                        .name("newChat")
	                        .data(new ObjectMapper().writeValueAsString(chatMessageVO)));
	            } catch (IOException e) {
	                // 오류 처리
	                emitter.completeWithError(e);
	                emitters.get(userSeq).remove(emitter);
	            }
	        }
	    }
		
	}

	@Override
	public int getNotReadChatMessage(Long userSeq) {
		return chatMapper.getNotReadChatCount(userSeq);
	}

	

	
}
