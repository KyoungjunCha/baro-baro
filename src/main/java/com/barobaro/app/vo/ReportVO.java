package com.barobaro.app.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReportVO {
	private int reportSeq;			// 신고 SEQ
    private String reportCategory;	// 신고 카테고리 선택
    private String reportReason;	// 신고 사유
    private String reportStatus;	// 신고 상태
    private String reportRegdate;	// 신고 일시
    private Integer reportUser;		// 신고 대상 유저 SEQ : null이 들어올 수 있어서 Integer
    private Integer reportPost; 	// 신고 대상 게시물 : : null이 들어올 수 있어서 Integer
    private long userSeq;			// 신고하는 유저 SEQ
}