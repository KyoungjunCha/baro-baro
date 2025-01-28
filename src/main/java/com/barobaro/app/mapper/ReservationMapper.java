package com.barobaro.app.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.barobaro.app.vo.RentTimeSlotVO;
import com.barobaro.app.vo.ReservationVO;

@Repository
@Mapper
public interface ReservationMapper {
	public void createTimeSlot(RentTimeSlotVO timeVO);
	public List<RentTimeSlotVO> getTimeSlot(long postSeq, Date rentAt);
	
	public void requestReservation(@Param("time_slot_seq") long timeSlotSeq);
	public int acceptReservation(@Param("reservation_seq") long reservationSeq);
	public int refuseReservation(@Param("reservation_seq") long reservationSeq);
	public int cancleRequest(@Param("reservation_seq") long reservationSeq);
	public int cancleAccept(@Param("reservation_seq") long reservationSeq);
	public int done(@Param("reservation_seq") long reservationSeq);
	
	public int updateStatusAvailable(@Param("time_slot_seq") long timeSlotSeq);
	public int updateStatusUnavailable(@Param("time_slot_seq") long timeSlotSeq);
}
