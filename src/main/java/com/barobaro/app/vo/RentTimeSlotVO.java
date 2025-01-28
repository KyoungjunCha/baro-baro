package com.barobaro.app.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RentTimeSlotVO {
	private long 	time_slot_seq;		//타임슬롯 식별자
	private Date 	rent_at;			//대여시간
	private Date 	return_at;			//반납시간
	private int 	status;				//상태 (1:예약가능 2:예약불가능)
	private long 	post_seq;			//게시물 식별자
	private Date 	regdate;			//생성일
	private String 	regid;				//등록자 식별자
	private int 	price;				//가격
	private String	rent_location;		//대여장소 주소
	private int		rent_rotate_x;		//대여장소 x좌표
	private int		rent_rotate_y;		//대여장소 y좌표
	private String	return_location;	//반납장소 주소
	private int		return_rotate_x;	//반납장소 x좌표
	private int		return_rotate_y;	//반납장소 y좌표
}
