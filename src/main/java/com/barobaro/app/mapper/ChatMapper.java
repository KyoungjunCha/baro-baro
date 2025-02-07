package com.barobaro.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.barobaro.app.vo.ChatMessageVO;
import com.barobaro.app.vo.ChatRoomVO;

@Mapper
public interface ChatMapper {

	int insertChatMessage(ChatMessageVO chatMessageVO);
    ChatRoomVO getChatRoomByUserSeqAndPostSeq(@Param("requestUserSeq")long requestUserSeq, @Param("targetPostSeq")long targetPostSeq);
    int createChatRoomByChatRoomVO(ChatRoomVO chatRoomVO);
    ChatMessageVO getRelativeUsersByChatMessage(@Param("roomSeq")long roomSeq);
    List<ChatRoomVO> getAllRoomsWithMessagesByUserSeq(@Param("userSeq")long userSeq);
}