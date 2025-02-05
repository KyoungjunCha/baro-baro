package com.barobaro.app.service;

import java.util.List;

import com.barobaro.app.vo.RentTimeSlotVO;
import com.barobaro.app.vo.ReservationVO;

public interface ReservationService {
	public int processReservation(long timeSlotSeq);
	public int acceptReservation(long reservationSeq);
	public int processRefuseReservation(long reservationSeq);
	public int cancleRequest(long reservationSeq);
	public int processCancleAccept(long reservationSeq);
	public int done(long reservationSeq);
	public int processCancleReject(long reservationSeq);
	
	public List<RentTimeSlotVO> getAllTimeSlots(long userSeq);
	public List<RentTimeSlotVO> getAllReservation(long userSeq);
}
