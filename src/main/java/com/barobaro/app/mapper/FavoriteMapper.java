package com.barobaro.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.barobaro.app.vo.FavoriteVO;

@Repository
@Mapper
public interface FavoriteMapper {
	public List<FavoriteVO> favoriteListByUser(int userSeq);
	public int checkFavorite(@Param("userSeq") int userSeq, @Param("postSeq") int postSeq);
	public int favoriteInsert(FavoriteVO fvo);
	public int favoriteDelete(@Param("userSeq") int userSeq, @Param("postSeq") int postSeq);
}
