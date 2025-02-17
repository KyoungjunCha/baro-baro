package com.barobaro.app.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.barobaro.app.common.CommonCode.SocialType;
import com.barobaro.app.common.CommonCode.UserInfo;
import com.barobaro.app.vo.CommentVO;
import com.barobaro.app.vo.FavoriteVO;
import com.barobaro.app.vo.NotificationVO;
import com.barobaro.app.vo.PostVO;
import com.barobaro.app.vo.ReviewSummaryVO;
import com.barobaro.app.vo.UserReviewAnswerVO;
import com.barobaro.app.vo.UsersOauthVO;
import com.barobaro.app.vo.UsersTblVO;

import java.util.List;
import java.util.Map;


public interface MypageService { 
	
	//내가 등록한 대여글
	public List<PostVO> svcGetAllMyPosts(int userSeq);
	
	//나의 대여 예약 현황
	public List<PostVO> svcGetAllUserPostRent(String usernickname);
	
	
//	//나에게 오는 모든 알림
//	public List<NotificationVO> svcGetAllMyNotifications(int userSeq);
//	
	
	//내가 추가한 즐겨찾기
	public List<FavoriteVO> svcGetAllMyFavorites(int userSeq);
	
	
	//내가 작성한 댓글
//	public List<CommentVO> svcGetAllMyComments(int userSeq);

	//내가 작성한 리뷰
//	public List<UserReviewAnswerVO> svcGetAllMyReviews(int userSeq);

	
//	public List<>
	
	public ReviewSummaryVO getReviewSummar(long userSeq);
	
	//남들이 해준 내리뷰총점
	public List<ReviewSummaryVO.ReceivedUserReview> getReceivedUserReviews(long userSeq);

	//받은 리뷰
    public List<ReviewSummaryVO.ReceivedPostReview> getReceivedPostReviews(long userSeq);
    
    //내가 작성한 리뷰
    public List<ReviewSummaryVO.SendedPostReview> getSendedPostReviews(long userSeq);
	
}