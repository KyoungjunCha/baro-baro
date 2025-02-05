package com.barobaro.app.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RentTimeSlotVO {
	private long 	time_slot_seq;		//타임슬롯 식별자
	private Date 	rent_at;			//대여시간
	private Date 	return_at;			//반납시간
	private int 	status;				//상태
	private long 	post_seq;			//게시물 식별자
	private Date 	regdate;			//생성일
	private String 	regid;				//등록자 식별자
	private int 	price;				//가격
	private String	rent_location;		//대여장소 주소
	private double	rent_rotate_x;		//대여장소 x좌표
	private double	rent_rotate_y;		//대여장소 y좌표
	private String	return_location;	//반납장소 주소
	private double	return_rotate_x;	//반납장소 x좌표
	private double	return_rotate_y;	//반납장소 y좌표
	
	private String title;				//게시물 제목
    private String product_name;		//물품명
    private String item_content;		//물품 관련 내용
    private long   reservation_seq;		//예약 히스토리 테이블 식별자
    private String owner_nickname;		//(물품 주인)
    private long   owner_user_seq;		//(물품 주인)
    private String requestor_nickname;  //(대여 요청자)
    private long   requestor_user_seq;	//(대여 요청자)
}
