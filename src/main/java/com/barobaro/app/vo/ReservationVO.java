package com.barobaro.app.vo;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReservationVO {
	private int 	reservation_seq;	//예약 히스토리 항목 식별자
	private Date 	created_at;			//예약 처음 생성된 시점
	private Date 	updated_at;			//예약 상태가 마지막으로 변경된 시점
	private int 	status;				//예약 상태 (1:예약대기중, 2:예약승인, 3:예약거절, 4:예약취소요청, 5:예약취소완료, 6:거래완료)
	private int 	time_slot_seq;		//타임 항목 식별자
}