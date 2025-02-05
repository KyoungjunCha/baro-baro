package com.barobaro.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.barobaro.app.vo.FavoriteVO;
import com.barobaro.app.vo.PostVO;

@Repository
@Mapper
public interface FavoriteMapper {
	public List<FavoriteVO> favoriteListByUser(int userSeq);
	public int checkFavorite(@Param("userSeq") int userSeq, @Param("postSeq") int postSeq);
	public int favoriteInsert(FavoriteVO fvo);
	public int favoriteDelete(@Param("userSeq") int userSeq, @Param("postSeq") int postSeq);
	

	public List<FavoriteVO> favoriteListByUser2(@Param("userSeq") int userSeq);
	public List<FavoriteVO> favoritesListByUser(@Param("userSeq") int userSeq);
	public List<PostVO> favoriteListInfo(long userSeq);

}
