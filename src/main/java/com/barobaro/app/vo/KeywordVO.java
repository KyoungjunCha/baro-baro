package com.barobaro.app.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class KeywordVO {
	private int keywordSeq;
	private String contents;
	private int userSeq;
}
