package com.barobaro.app.service;

import java.util.List;

import com.barobaro.app.vo.RentTimeSlotVO;
import com.barobaro.app.vo.ReservationVO;

public interface ReservationService {
	public void createTimeSlot(RentTimeSlotVO timeVO);
	public List<RentTimeSlotVO> getTimeSlot(long postSeq, long rentAt);
	public boolean requestReservation(int timeSlotSeq);
}
