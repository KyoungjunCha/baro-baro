package com.barobaro.app.vo;

import java.util.Date;
import org.springframework.stereotype.Component;
import lombok.Data;

@Component   
@Data     
public class CommentVO {
	private int 	commentSeq;
	private int 	parentSeq;
	private String 	content;
	private int 	secret;
	private int 	status;
	private Date	createAt;
	private Date	updateAt;
	private int		postSeq;
	private int		userSeq;
}
