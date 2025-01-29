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
	private ReservationMapper reservationMapper;

	// 대여희망자가 예약을 요청
	@Override
	public int processReservation(@Param("time_slot_seq") long timeSlotSeq) {
			       reservationMapper.requestReservation(timeSlotSeq);
		int rows = reservationMapper.updateStatusUnavailable(timeSlotSeq);
		return rows;
	}
	
	// 물품등록자가 예약을 수락
	@Override
	public int acceptReservation(@Param("reservation_seq") long reservationSeq) {
		return reservationMapper.acceptReservation(reservationSeq);
	}
	
	// 물품등록자가 예약을 거절
	@Override
	public int processRefuseReservation(@Param("reservation_seq") long reservationSeq) {
			       reservationMapper.refuseReservation(reservationSeq);
		int rows = reservationMapper.updateStatusAvailableByReservationSeq(reservationSeq);
		return rows;
	}
	
	// 대여희망자가 예약을 취소요청
	@Override
	public int cancleRequest(@Param("reservation_seq") long reservationSeq) {
		return reservationMapper.cancleRequest(reservationSeq);
	}
	
	// 물품등록자가 예약 취소요청을 수락
	@Override
	public int processCancleAccept(@Param("reservation_seq") long reservationSeq) {
				   reservationMapper.cancleAccept(reservationSeq);
		int rows = reservationMapper.updateStatusAvailableByReservationSeq(reservationSeq);
		return rows;
	}

	// 거래 완료됨
	@Override
	public int done(@Param("reservation_seq") long reservationSeq) {
		return reservationMapper.done(reservationSeq);
	}
}
