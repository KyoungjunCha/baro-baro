package com.barobaro.app.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.barobaro.app.mapper.ReportMapper;
import com.barobaro.app.service.ReportService;
import com.barobaro.app.vo.ReportVO;

@Service
public class ReportServiceImpl implements ReportService{
	
	@Autowired
	private ReportMapper reportMapper;
	
	// 신고등록
	@Override
	public void insertReport(String reportCategory, String reportReason, long userSeq, Integer reportUser, Integer reportPost) {
		
		System.out.println("ReportServiceImpl insertReport 호출 : 신고 등록");
		
		System.out.println("reportCategory: " + reportCategory);
	    System.out.println("reportReason: " + reportReason);
	    System.out.println("userSeq: " + userSeq);
	    System.out.println("reportUser: " + reportUser);
	    System.out.println("reportPost: " + reportPost);
	    
		// 게시물 중복 신고 체크
		int duplicateCount = reportMapper.checkDuplicateReport(userSeq, reportPost);
		System.out.println("중복 신고 개수 : " + duplicateCount);
	    if (duplicateCount > 0) {
	    	System.out.println("중복개수 판별");
	    	throw new IllegalArgumentException("이미신고한게시물");
	    }
	    
		ReportVO reportVO = new ReportVO();
		reportVO.setReportCategory(reportCategory);
		reportVO.setReportReason(reportReason);
		reportVO.setUserSeq(userSeq);
		reportVO.setReportUser(reportUser);
		reportVO.setReportPost(reportPost);
		
		int row = reportMapper.insertReport(reportVO);
		System.out.println("신고 " + row + "건 정상 입력!");	
	}
}