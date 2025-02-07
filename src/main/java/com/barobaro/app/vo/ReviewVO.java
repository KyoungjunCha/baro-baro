package com.barobaro.app.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReviewVO {
	private Long reviewSeq;
    private Integer ratingValue;
    private String itemReview;
    private List<String> userReview;
    private Long postSeq;
}
