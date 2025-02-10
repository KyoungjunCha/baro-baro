package com.barobaro.app.service;

public interface ReportService {
	
	// 신고 등록
	public void insertReport(String reportCategory, String reportReason, long userSeq, Integer reportUser, Integer reportPost);

}
