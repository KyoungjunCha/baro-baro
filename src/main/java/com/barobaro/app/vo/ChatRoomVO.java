package com.barobaro.app.vo;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatRoomVO {
    private Long chatRoomSeq;                
    private Date regdate;                    
    private Long postSeq;
    private Long requestUserSeq;
    private Integer chatRoomStatus;          
    private Long firstMessageSeq;            
    private Long notReadCountPoster;
    private Long notReadCountRequester;	
    
    //다른 테이블
    private String postTitle;
    private String productName;
    private Integer postStatus;
    private String postStoragePath;
    private Long postOwnerSeq;
    private String requestUserNickname;
    private String requestUserProfileImage;
    private String postOwnerNickname;
    private String postOwnerProfileImage;
    
    //화면에 뿌리기용
    private String latestMessage;
    
    private List<ChatMessageVO> chatMessages; 
}