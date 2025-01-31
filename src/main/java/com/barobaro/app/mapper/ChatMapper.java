package com.barobaro.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.barobaro.app.vo.ChatMessageVO;
import com.barobaro.app.vo.ChatRoomVO;

@Mapper
public interface ChatMapper {
    int insertChatMessage(ChatMessageVO message);
    List<ChatMessageVO> selectMessagesByRoom(Long roomId);
    int createRoom(ChatRoomVO vo);
    List<ChatRoomVO> selectRoomList();
}