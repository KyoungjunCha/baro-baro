package com.barobaro.app.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.barobaro.app.common.CommonCode.SocialType;
import com.barobaro.app.common.CommonCode.UserInfo;
import com.barobaro.app.mapper.FavoriteMapper;
import com.barobaro.app.mapper.NotificationMapper;
import com.barobaro.app.mapper.PostMapper;
import com.barobaro.app.mapper.UserMapper;
import com.barobaro.app.service.MypageService;
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


@Service
public class MypageServiceImpl implements MypageService {

//	@Autowired
//	private UserMapper userMapper;
	
	@Autowired
	private PostMapper postMapper;
	
	@Autowired
	private NotificationMapper notificationMapper;
	
	@Autowired
	private FavoriteMapper favoriteMapper;
	
//	@Autowired
//	private UserReviewAnswer

//	@Autowired
//	private CommentMapper commentMapper;
	
	
	
	@Override
	public List<PostVO> svcGetAllMyPosts(int userSeq) {
		return postMapper.selectUserPostByPostSeq(userSeq);
	}
	
	@Override
	public List<PostVO> svcGetAllUserPostRent(String usernickname){
		return postMapper.selectUserPostRent(usernickname);
	}
	
	
//	@Override
//	public List<NotificationVO> svcGetAllMyNotifications(int userSeq) {
//		return notificationMapper.allNotifications(userSeq);
//	}


	@Override
	public List<FavoriteVO> svcGetAllMyFavorites(int userSeq) {
		return favoriteMapper.favoriteListByUser2(userSeq);
	}



//	@Override
//	public List<CommentVO> svcGetAllMyComments(int userSeq) {
//		return userMapper.allComments(userSeq);
//	}

	
//	@Override
//	public List<UserReviewAnswerVO> svcGetAllMyReviews(int userSeq) {
//		return reviewMapper.allAnswers(userSeq);
//	}
	
	@Override
	public ReviewSummaryVO getReviewSummar(long userSeq) {
		// Create a new ReviewSummaryVO to hold the results
        ReviewSummaryVO reviewSummary = new ReviewSummaryVO();

        // Fetch Received User Reviews
        List<ReviewSummaryVO.ReceivedUserReview> receivedUserReviews = postMapper.getReceivedUserReview(userSeq);
        reviewSummary.setReceivedUserReviews(receivedUserReviews);

        // Fetch Received Post Reviews
        List<ReviewSummaryVO.ReceivedPostReview> receivedPostReviews = postMapper.getReceivedPostReview(userSeq);
        reviewSummary.setReceivedPostReviews(receivedPostReviews);

        // Fetch Sended Post Reviews
        List<ReviewSummaryVO.SendedPostReview> sendedPostReviews = postMapper.getSendedPostReview(userSeq);
        reviewSummary.setSendedPostReviews(sendedPostReviews);

        return reviewSummary;
	}
	
}