package com.barobaro.app.service.impl;

import java.util.List;
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
	
//	@Override
//	public void createTimeSlot(RentTimeSlotVO timeVO) {
//		Mapper.createTimeSlot(timeVO);
//		
//	}
	
	@Override
	public List<RentTimeSlotVO> getTimeSlots(int post_seq, String selectedDate) {
		System.out.println("서비스 호출됨");
		return Mapper.getTimeSlots(post_seq, selectedDate);
	}


//	@Override
//	public boolean requestReservation(ReservationVO reservation) {
//		return Mapper.requestReservation(reservation);
//	}

}
