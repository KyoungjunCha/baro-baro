package com.barobaro.app.vo;

import java.util.Date;
import org.springframework.stereotype.Component;
import lombok.Data;

@Component   
@Data     
public class UserReviewAnswerVO {
	private int 	postSeq;
	private String 	title;
	private String 	itemContent;
	private String 	rentContent;
	private String 	postAt;
	private int		count;
	private String	productName;
	private int		userSeq;
	private int		categorySeq;
}
