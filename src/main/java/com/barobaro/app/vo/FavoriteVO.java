package com.barobaro.app.vo;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FavoriteVO {
	private int favoriteSeq;
	private Date createdAt;
	private int userSeq;
	private int postSeq;
	
	private List<PostVO2> postList;
}
