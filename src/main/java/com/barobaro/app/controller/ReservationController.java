package com.barobaro.app.controller;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import com.barobaro.app.service.ReservationService;
import com.barobaro.app.vo.RentTimeSlotVO;
import com.barobaro.app.vo.ReservationVO;

@Controller
@RequestMapping("/reservation")
public class ReservationController {
	
	@Autowired
	@Qualifier("reservationServiceImpl")
	private ReservationService reservationSvc;
	
	// 특정날짜 선택시 시간목록 조회하기
	@RequestMapping(value="/time-slot-list", method = RequestMethod.GET)
	@ResponseBody
    public ResponseEntity<?> getTimeSlots( 
					    		@RequestParam("post_seq") int postSeq , 
					    		@RequestParam("selected_date") String selectedDate) {
		System.out.println("컨트롤러 호출됨");
        List<RentTimeSlotVO> timeSlotList = reservationSvc.getTimeSlots(postSeq, selectedDate);
        return new ResponseEntity<>(timeSlotList, HttpStatus.OK);
    }
	
	// 예약 요청하기
	@RequestMapping(value = "/request-Reservation", method = RequestMethod.POST)
    public ResponseEntity<String> requestReservation(@RequestBody ReservationVO reservation) {
		System.out.println("컨트롤러 호출됨");
		boolean isRequested = reservationSvc.requestReservation(reservation);
        if (isRequested) {
            return new ResponseEntity<String>("예약 요청이 완료되었습니다.", HttpStatus.OK);
        } else {
            return new ResponseEntity<String>("예약 요청에 실패했습니다. 이미 다른 사용자에 의해 요청 완료된 시간일 수 있습니다.", HttpStatus.BAD_REQUEST);
        }
    }
	
	// 에약 수락하기
	// 예약 거절하기
	// 예약 취소요청하기
	// 예약 취소요청 수락하기
	// 거래 완료시
	
    
}
