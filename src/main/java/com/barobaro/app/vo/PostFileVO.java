package com.barobaro.app.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PostFileVO {
	private long fileSeq;
	private String name;
	private String storagePath;
	private long postSeq;
	
}
