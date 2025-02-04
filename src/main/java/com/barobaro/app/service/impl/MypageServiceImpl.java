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
		System.out.println("유저 seq : " + userSeq);
		System.out.println("제대로 나오나1 : " + userMapper.allPosts(userSeq));
		return userMapper.allPosts(userSeq);
	}

	@Override
	public List<NotificationVO> svcGetAllMyNotifications() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<UserReviewAnswerVO> svcGetAllMyReviews() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<FavoriteVO> svcGetAllMyFavorites() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<CommentVO> svcGetAllMyComments() {
		// TODO Auto-generated method stub
		return null;
	}	
}