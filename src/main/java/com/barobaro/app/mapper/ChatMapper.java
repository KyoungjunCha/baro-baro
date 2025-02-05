package com.barobaro.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.barobaro.app.vo.ChatMessageVO;
import com.barobaro.app.vo.ChatRoomVO;

@Mapper
public interface ChatMapper {
    int insertChatMessage(ChatMessageVO message);
    List<ChatMessageVO> selectMessagesByRoomSeq(@Param("roomSeq")long roomSeq);
    int createRoom(ChatRoomVO vo);
    List<ChatRoomVO> getRoomsByUserSeq(@Param("userSeq")long userSeq);
    ChatRoomVO findChatRoomByUsers(@Param("senderSeq")long senderSeq, @Param("targetUserSeq")long targetUserSeq);
    int createRoomMember(@Param("userSeq")long userSeq, @Param("chatRoomSeq")long chatRoomSeq);
}