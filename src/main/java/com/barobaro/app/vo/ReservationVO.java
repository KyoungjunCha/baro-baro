package com.barobaro.app.vo;

public class ReservationVO {
	
	private int reservation_seq;		//예약 히스토리 항목 식별자
//	private Date created_at;			//예약 처음 생성된 시점
//	private Date updated_at;			//예약 상태 마지막으로 변경된 시점
	private int status;					//예약 상태값 
	private int time_slot_seq;			//예약 가능한 항목 식별자
}
