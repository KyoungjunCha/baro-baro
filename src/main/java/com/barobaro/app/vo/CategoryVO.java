package com.barobaro.app.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CategoryVO {
	private long categorySeq;
	private String categoryName;
	private String description;
	private Date createdAt;
	private Date updatedAt;
	private long parentSeq;
}
