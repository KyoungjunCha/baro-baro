package com.barobaro.app.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommentVO {
    private int commentSeq;
    private Integer parentSeq = null; // 기본값 null로 변경 (최상위 댓글일 경우 null)
    private String content;
    private Integer secret = null; 		// 비밀글 여부
    private int status = 0; 		// 댓글 상태 (예: 활성화/비활성화)
    private String createdAt;
    private String updatedAt;
    private int postSeq; 		// 연결된 게시물
    private long userSeq; 		// 댓글 작성자 정보
    
    private List<CommentVO> replies;  // 대댓글 목록 추가
    
    public boolean canViewSecret;	// 비밀글 판별
    
    private String nickname; // 닉네임 추가
    
    // parentSeq가 null일 경우 0을 반환하는 getter (예외 방지)
    public Integer getParentSeq() {
        return parentSeq == null ? null : parentSeq;
    } 
}