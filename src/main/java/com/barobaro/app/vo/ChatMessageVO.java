package com.barobaro.app.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ChatMessageVO {
    private long messageId;
    private long roomId;
    private long sender;
    private String content;
    private Date regdate;
}