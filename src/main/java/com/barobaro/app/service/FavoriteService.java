package com.barobaro.app.service;

import java.util.List;

import com.barobaro.app.vo.FavoriteVO;

public interface FavoriteService {
	public List<FavoriteVO> favoriteListByUser(int userSeq);
	// 즐겨찾기 상태 확인
	public boolean isFavorite(int userSeq, int postSeq);
	public void favoriteInsert(FavoriteVO fvo);
	public void favoriteDelete(int userSeq, int postSeq);
}
