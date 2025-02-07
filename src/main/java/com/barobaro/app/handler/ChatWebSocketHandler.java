package com.barobaro.app.handler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.barobaro.app.mapper.ChatMapper;
import com.barobaro.app.service.ChatService;
import com.barobaro.app.vo.ChatMessageVO;

public class ChatWebSocketHandler extends TextWebSocketHandler {
	 // roomId별로 접속 사용자의 세션을 보관
    private final Map<Long, List<WebSocketSession>> roomSessions = new ConcurrentHashMap<>();
    
    @Autowired
    ChatService chatService;

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        // 연결만 유지
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	String payload = message.getPayload().trim();
        if (payload.toUpperCase().startsWith("CONNECT") 
            || payload.toUpperCase().startsWith("CONNECTED")
            || payload.length() < 1) {
            return; 
        }
        Map<String,String> parsed = parsePayload(payload);
        Long roomId = Long.valueOf(parsed.get("roomId"));
        Long senderSeq = Long.parseLong(parsed.get("sender"));
        String content = parsed.get("content");

        // (1) roomSessions에 세션이 없다면 추가
        roomSessions.computeIfAbsent(roomId, k -> new ArrayList<>());
        List<WebSocketSession> sessions = roomSessions.get(roomId);
        if (!sessions.contains(session)) {
            sessions.add(session);
        }
        ChatMessageVO chatMessageVO = ChatMessageVO.builder()
        		.chatRoomSeq(roomId)
        		.senderSeq(senderSeq)
        		.content(content)
        		.build();
        chatService.insertChatMessageVO(chatMessageVO);

        // 브로드캐스팅
        TextMessage echo = new TextMessage(senderSeq + ": " + content);
        for (WebSocketSession s : sessions) {
            CompletableFuture.runAsync(() -> {
                try {
                    s.sendMessage(echo);
                } catch (IOException e) {
                    // 에러 처리
                }
            });
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
        roomSessions.values().forEach(list -> list.remove(session));
    }

    private Map<String, String> parsePayload(String p) {
        Map<String, String> map = new HashMap<>();
        String[] tokens = p.split("&");
        for (String t : tokens) {
            String[] kv = t.split("=", 2);
            if (kv.length == 2) {
                map.put(kv[0], kv[1]);
            } else {
            }
        }
        return map;
    }

}
