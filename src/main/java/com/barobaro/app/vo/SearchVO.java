package com.barobaro.app.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SearchVO {
	private String searchKeyword;
	private String searchType;
	private int	   categorySeq;
	private String availableOnly;
    private Double latitude;		//위도
    private Double longitude;		//경도
}
