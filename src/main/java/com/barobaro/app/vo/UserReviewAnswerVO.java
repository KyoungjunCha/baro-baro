package com.barobaro.app.vo;

import java.util.Date;
import org.springframework.stereotype.Component;
import lombok.Data;

@Component   
@Data     
public class UserReviewAnswerVO {
	private int 	reviewSeq;
	private int 	revieweeSeq; //userSeq 
	private int 	reviewerSeq; //userSeq 리뷰한사람 (자신)
	private int 	userReviewAnswerSeq;
	private String 	content;
}
