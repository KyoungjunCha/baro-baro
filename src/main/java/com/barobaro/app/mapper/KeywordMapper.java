package com.barobaro.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.barobaro.app.vo.FavoriteVO;
import com.barobaro.app.vo.KeywordVO;

@Repository
@Mapper
public interface KeywordMapper {
	public void insertKeyword(KeywordVO kvo);
	public List<KeywordVO> selectKeywordByUserSeq(int userSeq);
	public KeywordVO selectKeywordBySeq(int keywordSeq);
	public List<KeywordVO> selectAllKeywords();
	public void updateKeyword(@Param("contents") String contents, @Param("keywordSeq") int keywordSeq);
	public void deleteKeyword(int keywordSeq);
}
