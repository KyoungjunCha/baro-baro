package com.barobaro.app.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.Date;

// 이제무 작성
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PostVO3 {
    private int postSeq;       // 게시글 번호
    private String title;      // 제목
    private String itemContent; // 물품 설명
    private String rentContent; // 대여 관련 설명
    private Date postAt;       // 게시 날짜
    private int count;         // 조회수
    private String productName; // 제품명
    private int userSeq;       // 작성자 (user_table의 user_seq)
    private int categorySeq;   // 카테고리 (category 테이블의 category_seq)
}
