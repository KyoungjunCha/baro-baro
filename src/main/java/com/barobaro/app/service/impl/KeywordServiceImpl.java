package com.barobaro.app.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.barobaro.app.mapper.KeywordMapper;
import com.barobaro.app.service.KeywordService;
import com.barobaro.app.vo.KeywordVO;

@Service
public class KeywordServiceImpl implements KeywordService {
	@Autowired
	private KeywordMapper mapper;

	@Override
	public void addKeyword(KeywordVO kvo) {
		mapper.insertKeyword(kvo);
	}

	@Override
	public List<KeywordVO> getKeywordsByUserSeq(int userSeq) {
		return mapper.selectKeywordByUserSeq(userSeq);
	}

	@Override
	public KeywordVO getKeywordBySeq(int keywordSeq) {
		return mapper.selectKeywordBySeq(keywordSeq);
	}

	@Override
	public void updateKeyword(String contents, int keywordSeq) {
		mapper.updateKeyword(contents, keywordSeq);
	}

	@Override
	public void deleteKeyword(int keywordSeq) {
		mapper.deleteKeyword(keywordSeq);
	}
}
