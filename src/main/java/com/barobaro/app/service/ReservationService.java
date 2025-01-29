package com.barobaro.app.service;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.barobaro.app.vo.RentTimeSlotVO;
import com.barobaro.app.vo.ReservationVO;

public interface ReservationService {
	public int processReservation(@Param("time_slot_seq") long timeSlotSeq);
	public int acceptReservation(@Param("reservation_seq") long reservationSeq);
	public int processRefuseReservation(@Param("reservation_seq") long reservationSeq);
	public int cancleRequest(@Param("reservation_seq") long reservationSeq);
	public int processCancleAccept(@Param("reservation_seq") long reservationSeq);
	public int done(@Param("reservation_seq") long reservationSeq);
}
