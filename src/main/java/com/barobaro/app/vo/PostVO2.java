package com.barobaro.app.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PostVO2 {
	private int postSeq;
	private String title;
	private String itemContent;
	private String rentContent;
	private String rentLocation;
	private Date postAt;
	private Long rotateX;
	private Long rotateY;
	private int count;
	private String productName;
	private int userSeq;
	private int categorySeq;
}
