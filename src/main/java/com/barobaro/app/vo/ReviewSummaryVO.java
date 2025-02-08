package com.barobaro.app.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReviewSummaryVO {
	private List<ReceivedUserReview> receivedUserReviews;
	private List<ReceivedPostReview> receivedPostReviews;
	private List<SendedPostReview> sendedPostReviews;
	
	@Data
	@Builder
	@NoArgsConstructor
	@AllArgsConstructor
	public static class ReceivedUserReview{
		private String userReview;
	    private int receivedReviewCount;
	}
	
	@Data
	@Builder
	@NoArgsConstructor
	@AllArgsConstructor
	public static class ReceivedPostReview{
		private int postSeq;
	    private String title;
	    private String productName;
	    private int userSeq;
	    private String regDate;
	    private float ratingValue;
	    private String itemReview;
	}
	
	@Data
	@Builder
	@NoArgsConstructor
	@AllArgsConstructor
	public static class SendedPostReview{
		private String regDate;
	    private int postSeq;
	    private float ratingValue;
	    private String itemReview;
	}
}
