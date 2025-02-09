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
	//내가 받은 유저 관련 칭찬 리뷰
	private List<ReceivedUserReview> receivedUserReviews;
	private List<ReceivedPostReview> receivedPostReviews;
	private List<SendedPostReview> sendedPostReviews;
	
	@Data
	@Builder
	@NoArgsConstructor
	@AllArgsConstructor
	public static class ReceivedUserReview{
		//리뷰의 종류 (약속을잘지켜요, 등등 )
		private String userReview;
		//해당 종류의 리뷰를 몇번 받았는지
	    private int receivedReviewCount;
	}
	
	@Data
	@Builder
	@NoArgsConstructor
	@AllArgsConstructor
	//자기가 작성한게시글의 리뷰들 (다른사람들이 평가한 내제품)
	public static class ReceivedPostReview{
		private int postSeq;
	    private String title;
	    //게시글 물품명
	    private String productName;
	    private int userSeq;
	    //리뷰등록일
	    private String regDate;
	    //별점? 개별 평점
	    private float ratingValue;
	    //상세리뷰 내용
	    private String itemReview;
	}
	
	@Data
	@Builder
	@NoArgsConstructor
	@AllArgsConstructor
	// 자기가 작성한 게시글 리뷰 (자기가 쓴 리뷰)
	public static class SendedPostReview{
		private String regDate;
	    private int postSeq;
	    private float ratingValue;
	    private String itemReview;
	}
}



