package com.barobaro.app.service;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.barobaro.app.vo.RentTimeSlotVO;
import com.barobaro.app.vo.ReservationVO;

public interface ReservationService {
	public void createTimeSlot(RentTimeSlotVO timeVO);
	public List<RentTimeSlotVO> getTimeSlot(long postSeq, Date rentAt);
	public int requestReservation(@Param("time_slot_seq") long timeSlotSeq);
	public int acceptReservation(@Param("reservation_seq") long reservationSeq);
	public int refuseReservation(@Param("reservation_seq") long reservationSeq);
}
