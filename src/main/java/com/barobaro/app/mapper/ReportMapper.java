package com.barobaro.app.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.barobaro.app.vo.ReportVO;

@Mapper
public interface ReportMapper {
	
	// 사용자 기능
	public int insertReport(ReportVO reportVO);  // 신고 작성
	public int checkDuplicateReport(@Param("userSeq") long userSeq, @Param("reportPost") Integer reportPost);
	//public int checkDuplicateUser(@Param("userSeq") int userSeq, @Param("reportUser") Integer reportUser);
//	// 관리자 기능
//    public List<ReportVO> getReportList();  // 관리자: 전체 신고 목록 조회
//    public void updateReportStatus(@Param("reportSeq") int reportSeq, @Param("reportStatus") String reportStatus);  // 신고 처리 상태 변경

}