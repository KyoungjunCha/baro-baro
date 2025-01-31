package com.barobaro.app.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.barobaro.app.mapper.ChatMapper;
import com.barobaro.app.vo.ChatMessageVO;

public class ChatWebSocketHandler extends TextWebSocketHandler {
	 // roomId별로 접속 사용자의 세션을 보관
    private final Map<Long, List<WebSocketSession>> roomSessions = new HashMap<>();

    @Autowired
    private ChatMapper chatMapper; // DAO 대신 Mapper 인터페이스

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        // 연결만 유지
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        Map<String,String> parsed = parsePayload(payload);
        
        Long roomId = Long.valueOf(parsed.get("roomId"));
        String sender = parsed.get("sender");
        String content = parsed.get("content");

        // DB 저장
        ChatMessageVO chatMessage = new ChatMessageVO();
        chatMessage.setRoomId(roomId);
        chatMessage.setSender(Long.parseLong(sender));
        chatMessage.setContent(content);
        chatMapper.insertChatMessage(chatMessage);

        // 현재 채팅방에 연결된 사용자에게만 브로드캐스팅
        List<WebSocketSession> sessions = roomSessions.getOrDefault(roomId, new ArrayList<>());
        TextMessage echo = new TextMessage(sender + ": " + content);
        for (WebSocketSession s : sessions) {
            s.sendMessage(echo);
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
        roomSessions.values().forEach(list -> list.remove(session));
    }

    private Map<String,String> parsePayload(String p) {
        Map<String,String> map = new HashMap<>();
        String[] tokens = p.split("&");
        for(String t : tokens) {
            String[] kv = t.split("=");
            map.put(kv[0], kv[1]);
        }
        Long rid = Long.valueOf(map.get("roomId"));
        return map;
    }
}
