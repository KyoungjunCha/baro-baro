package com.barobaro.app.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ChatMessageVO {
	private Long chatMessageSeq; 
    private Long chatRoomSeq;    
    private Long senderSeq;      
    private String content;
    
    private Long postOwnerSeq;
    private Long requestUserSeq;
}
