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
public class PostVO {
	private long postSeq;
	private String title;
	private String itemContent;
	private String rentContent;
	private Date postAt;
	private long count;
	private String productName;
	private long userSeq;
	private String categoryName;
	private PostFileVO postImage;
	private List<PostFileVO> postImages;
	private List<CommentTest> comments;
	private List<RentTimeSlotVO> rentTimes; 
	
	public static class CommentTest{
		
	}
}
