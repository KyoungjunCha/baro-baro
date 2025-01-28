package com.barobaro.app.service.impl;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.barobaro.app.mapper.ReservationMapper;
import com.barobaro.app.service.ReservationService;
import com.barobaro.app.vo.RentTimeSlotVO;
import com.barobaro.app.vo.ReservationVO;

@Service("reservationServiceImpl")
public class ReservationServiceImpl implements ReservationService {
	
	@Autowired
	private ReservationMapper Mapper;
	
	@Override
	public void createTimeSlot(RentTimeSlotVO timeVO) {
		Mapper.createTimeSlot(timeVO);
	}

	@Override
	public List<RentTimeSlotVO> getTimeSlot(long postSeq, Date rentAt) {
		return Mapper.getTimeSlot(postSeq, rentAt);
	}
	
	@Override
	public int requestReservation(@Param("time_slot_seq") long timeSlotSeq) {
		return Mapper.requestReservation(timeSlotSeq);
	}

	@Override
	public int acceptReservation(@Param("reservation_seq") long reservationSeq) {
		return Mapper.acceptReservation(reservationSeq);
	}

	@Override
	public int refuseReservation(@Param("reservation_seq") long reservationSeq) {
		return Mapper.refuseReservation(reservationSeq);
	}
}
