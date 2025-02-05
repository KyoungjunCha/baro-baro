package com.barobaro.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.barobaro.app.mapper.FavoriteMapper;
import com.barobaro.app.service.FavoriteService;
import com.barobaro.app.vo.FavoriteVO;
import com.barobaro.app.vo.PostVO;

@Service
public class FavoriteServiceImpl implements FavoriteService {
	@Autowired
	private FavoriteMapper mapper;

	@Override
	public List<FavoriteVO> favoriteListByUser(int userSeq) {
		return mapper.favoriteListByUser(userSeq);
	}

	@Override
	public boolean isFavorite(int userSeq, int postSeq) {
		return mapper.checkFavorite(userSeq, postSeq) > 0;
	}

	@Override
	public void favoriteInsert(FavoriteVO fvo) {
		mapper.favoriteInsert(fvo);
	}

	@Override
	public void favoriteDelete(int userSeq, int postSeq) {
		mapper.favoriteDelete(userSeq, postSeq);
	}

	@Override
	public List<PostVO> favoriteListInfo(long userSeq) {
		return mapper.favoriteListInfo(userSeq);
	}
}
