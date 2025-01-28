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
	public  void	createTimeSlot(RentTimeSlotVO timeVO);
	public List<RentTimeSlotVO> getTimeSlot(long postSeq, long rentAt);
	public 	boolean requestReservation(int timeSlotSeq);
}
