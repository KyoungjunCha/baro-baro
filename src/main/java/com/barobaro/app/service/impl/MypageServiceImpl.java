package com.barobaro.app.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.barobaro.app.common.CommonCode.SocialType;
import com.barobaro.app.common.CommonCode.UserInfo;
import com.barobaro.app.mapper.UserMapper;
import com.barobaro.app.service.MypageService;
import com.barobaro.app.vo.CommentVO;
import com.barobaro.app.vo.FavoriteVO;
import com.barobaro.app.vo.NotificationVO;
import com.barobaro.app.vo.PostVO;
import com.barobaro.app.vo.UserReviewAnswerVO;
import com.barobaro.app.vo.UsersOauthVO;
import com.barobaro.app.vo.UsersTblVO;

import java.util.List;
import java.util.Map;


@Service
public class MypageServiceImpl implements MypageService {

	@Autowired
	private UserMapper userMapper;
	
	@Override
	public List<PostVO> svcGetAllMyPosts(int userSeq) {
		return userMapper.allPosts(userSeq);
	}

	@Override
	public List<NotificationVO> svcGetAllMyNotifications(int userSeq) {
		return userMapper.allNotifications(userSeq);
	}

	@Override
	public List<UserReviewAnswerVO> svcGetAllMyReviews(int userSeq) {
		return userMapper.allAnswers(userSeq);
	}

	@Override
	public List<FavoriteVO> svcGetAllMyFavorites(int userSeq) {
		return userMapper.allFavorites(userSeq);
	}

	@Override
	public List<CommentVO> svcGetAllMyComments(int userSeq) {
		return userMapper.allComments(userSeq);
	}	
}