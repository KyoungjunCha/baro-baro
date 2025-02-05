package com.barobaro.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.barobaro.app.vo.RentTimeSlotVO;
import com.barobaro.app.vo.ReservationVO;

@Repository
@Mapper
public interface ReservationMapper {
	public void requestReservation(@Param("time_slot_seq") long timeSlotSeq);
	public int acceptReservation(@Param("reservation_seq") long reservationSeq);
	public int refuseReservation(@Param("reservation_seq") long reservationSeq);
	public int cancleRequest(@Param("reservation_seq") long reservationSeq);
	public int cancleAccept(@Param("reservation_seq") long reservationSeq);
	public int done(@Param("reservation_seq") long reservationSeq);
	public int cancleReject(@Param("reservation_seq") long reservationSeq);
	
	public int updateStatusAvailableByReservationSeq(@Param("reservation_seq") long reservationSeq);
	public int updateStatusAvailableByTimeSlotSeq(@Param("time_slot_seq") long timeSlotSeq);
	public int updateStatusUnavailable(@Param("time_slot_seq") long timeSlotSeq);
	
	public List<RentTimeSlotVO> getAllTimeSlots(@Param("userSeq") long userSeq);
	public List<RentTimeSlotVO> getAllReservation(@Param("userSeq") long userSeq);
}
