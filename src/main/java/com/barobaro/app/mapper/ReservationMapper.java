package com.barobaro.app.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface ReservationMapper {
	public void requestReservation(@Param("time_slot_seq") long timeSlotSeq);
	public int acceptReservation(@Param("reservation_seq") long reservationSeq);
	public int refuseReservation(@Param("reservation_seq") long reservationSeq);
	public int cancleRequest(@Param("reservation_seq") long reservationSeq);
	public int cancleAccept(@Param("reservation_seq") long reservationSeq);
	public int done(@Param("reservation_seq") long reservationSeq);
	
	public int updateStatusAvailableByReservationSeq(@Param("reservation_seq") long reservationSeq);
	public int updateStatusAvailableByTimeSlotSeq(@Param("time_slot_seq") long timeSlotSeq);
	public int updateStatusUnavailable(@Param("time_slot_seq") long timeSlotSeq);
}
