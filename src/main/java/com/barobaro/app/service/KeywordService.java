package com.barobaro.app.service;

import java.util.List;

import com.barobaro.app.vo.KeywordVO;

public interface KeywordService {
	public void addKeyword(KeywordVO kvo);
	public List<KeywordVO> getKeywordsByUserSeq(int userSeq);
	public KeywordVO getKeywordBySeq(int keywordSeq);
	public List<KeywordVO> getAllKeywords();
	public void updateKeyword(String contents, int keywordSeq);
	public void deleteKeyword(int keywordSeq);
}
