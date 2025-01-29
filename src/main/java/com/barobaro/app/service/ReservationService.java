package com.barobaro.app.service;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.barobaro.app.vo.RentTimeSlotVO;
import com.barobaro.app.vo.ReservationVO;

public interface ReservationService {
	public int processReservation(long timeSlotSeq);
	public int acceptReservation(long reservationSeq);
	public int processRefuseReservation(long reservationSeq);
	public int cancleRequest(long reservationSeq);
	public int processCancleAccept(long reservationSeq);
	public int done(long reservationSeq);
}
