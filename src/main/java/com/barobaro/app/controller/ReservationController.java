package com.barobaro.app.controller;

import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import org.springframework.web.servlet.ModelAndView;

import com.barobaro.app.common.CommonCode.UserInfo;
import com.barobaro.app.common.CommonCode.UserStatus;
import com.barobaro.app.service.ReservationService;
import com.barobaro.app.vo.RentTimeSlotVO;
import com.barobaro.app.vo.ReservationVO;

@Controller
@RequestMapping("/reservation")
public class ReservationController {
	
	@Autowired
	@Qualifier("reservationServiceImpl")
	private ReservationService reservationService;
	
	// 예약 요청 	/reservation/request-reservation  테스트완료
	@RequestMapping(value = "/request-reservation", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
    public ResponseEntity<String> requestReservation(@RequestParam("timeSlotSeq") long timeSlotSeq) {
		System.out.println("컨트롤러 호출됨, timeSlotSeq 는 : " + timeSlotSeq);
		int rows = reservationService.processReservation(timeSlotSeq);
		System.out.println("업데이트한 행 수 : " + rows + "건이 요청됨");
		if (rows == 1) {
			return new ResponseEntity<String>("예약 요청이 완료되었습니다.", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>("예약 요청에 실패했습니다. 이미 다른사용자에 의해 요청이 완료된 시간일 수 있습니다.", HttpStatus.BAD_REQUEST);
		}
	}
	
	// 에약 수락		/reservation/accept-reservation  테스트완료
	@RequestMapping(value = "/accept-reservation", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
    public ResponseEntity<String> acceptReservation(@RequestParam("reservationSeq") long reservationSeq) {
		System.out.println("컨트롤러 호출됨, reservationSeq 는 : " + reservationSeq);
		int rows = reservationService.acceptReservation(reservationSeq);
		System.out.println("업데이트한 행 수 : " + rows + "건이 수락됨");
        if (rows == 1) {
            return new ResponseEntity<String>("수락이 완료되었습니다.", HttpStatus.OK);
        } else {
            return new ResponseEntity<String>("수락에 실패했습니다. 다시 시도해주세요.", HttpStatus.BAD_REQUEST);
        }
    }
	
	// 예약 거절		/reservation/refuse-reservation  테스트완료
	@RequestMapping(value = "/refuse-reservation", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
    public ResponseEntity<String> refuseReservation(@RequestParam("reservationSeq") long reservationSeq) {
		System.out.println("컨트롤러 호출됨, reservationSeq 는 : " + reservationSeq);
		int rows = reservationService.processRefuseReservation(reservationSeq);
		System.out.println("업데이트한 행 수 : " + rows + "건이 거절됨");
        if (rows == 1) {
            return new ResponseEntity<String>("거절이 완료되었습니다.", HttpStatus.OK);
        } else {
            return new ResponseEntity<String>("거절에 실패했습니다. 다시 시도해주세요.", HttpStatus.BAD_REQUEST);
        }
    }
	
	// 예약 취소요청		/reservation/cancle-request  테스트완료
	@RequestMapping(value = "/cancle-request", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
    public ResponseEntity<String> cancleRequest(@RequestParam("reservationSeq") long reservationSeq) {
		System.out.println("컨트롤러 호출됨, reservationSeq 는 : " + reservationSeq);
		int rows = reservationService.cancleRequest(reservationSeq);
		System.out.println("업데이트한 행 수 : " + rows + "건이 취소요청됨");
        if (rows == 1) {
            return new ResponseEntity<String>("취소 요청이 완료되었습니다.", HttpStatus.OK);
        } else {
            return new ResponseEntity<String>("취소 요청이 실패했습니다. 다시 시도해주세요.", HttpStatus.BAD_REQUEST);
        }
    }
	
	// 예약 취소요청 수락		/reservation/cancle-accept  테스트완료
	@RequestMapping(value = "/cancle-accept", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
    public ResponseEntity<String> cancleAccept(@RequestParam("reservationSeq") long reservationSeq) {
		System.out.println("컨트롤러 호출됨, reservationSeq 는 : " + reservationSeq);
		int rows = reservationService.processCancleAccept(reservationSeq);
		System.out.println("업데이트한 행 수 : " + rows + "건이 취소요청 수락됨");
        if (rows == 1) {
            return new ResponseEntity<String>("취소요청을 수락하였습니다.", HttpStatus.OK);
        } else {
            return new ResponseEntity<String>("취소요청을 수락하는데에 실패했습니다. 다시 시도해주세요.", HttpStatus.BAD_REQUEST);
        }
    }
	
	// 거래 완료		/reservation/done  테스트완료
	@RequestMapping(value = "/done", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
    public ResponseEntity<String> done(@RequestParam("reservationSeq") long reservationSeq) {
		System.out.println("컨트롤러 호출됨, reservationSeq 는 : " + reservationSeq);
		int rows = reservationService.done(reservationSeq);
		System.out.println("업데이트한 행 수 : " + rows + "건이 거래완료됨");
        if (rows == 1) {
            return new ResponseEntity<String>("거래 완료", HttpStatus.OK);
        } else {
            return new ResponseEntity<String>("실패했습니다. 다시 시도해주세요.", HttpStatus.BAD_REQUEST);
        }
    }
	
	// 예약 취소요청 거절		/reservation/cancle-reject  테스트완료
	@RequestMapping(value = "/cancle-reject", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
    public ResponseEntity<String> cancleReject(@RequestParam("reservationSeq") long reservationSeq) {
		System.out.println("컨트롤러 호출됨, reservationSeq 는 : " + reservationSeq);
		int rows = reservationService.processCancleReject(reservationSeq);
		System.out.println("업데이트한 행 수 : " + rows + "건이 취소요청 거절됨");
        if (rows == 1) {
            return new ResponseEntity<String>("취소요청을 거절하였습니다.", HttpStatus.OK);
        } else {
            return new ResponseEntity<String>("취소요청을 거절하는데에 실패했습니다. 다시 시도해주세요.", HttpStatus.BAD_REQUEST);
        }
    }
	
	// 로그인유저가 등록한 물품의 타임목록 현황 가져오기  /reservation/getAllTimeSlots
	@RequestMapping(value = "/getAllTimeSlots", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody  //JSON 응답을 반환하도록 설정
	public List<RentTimeSlotVO> getAllTimeSlots(HttpSession session){ //HttpServletRequest request
		
		Logger logger = LoggerFactory.getLogger(this.getClass()); // SLF4J Logger 사용
		
		UserInfo userInfo = (UserInfo) session.getAttribute("user_info");
		long userSeq = userInfo.getUserSeq();
		System.out.println("세션에서 꺼낸 유저시큐는 : " + userSeq);
		
		//250206 유저 seq 등록을 위한 수정 경준작성
		//250209 일단 하드코딩으로 박아둠으로 다시 되돌림 (승희작성)
//		long userSeq = 1001; // (테스트용으로 로그인유저 1001로 설정)
//		int userSeq = (Integer)request.getSession().getAttribute("SESS_USER_SEQ");
//		UserStatus status = (UserStatus) request.getSession().getAttribute("SESS_STATUS");
		
		
		
//	    long userSeq = Long.parseLong(requestData.get("userSeq").toString()); // 요청 받은 userSeq
	    logger.info("✅ 요청받은 userSeq: " + userSeq);
	   
//	    if(status != null && "ACTIVE".equals(status.name())) {\
	    
	    // 유저 시퀀스를 기반으로 타임 목록 조회
		List<RentTimeSlotVO> timeSlotList = reservationService.getAllTimeSlots(userSeq);
		
		logger.info("🔄 조회된 대여 목록: " + timeSlotList.size() + "개"); // 데이터 개수 확인
		for (RentTimeSlotVO slot : timeSlotList) {
		    logger.info("📌 조회된 대여 목록: : " + slot.toString()); // 개별 데이터 확인
		}
		return timeSlotList;
//	    }else {
//	    	
//	    	return Collections.emptyList();
//	    }
	}
	
	// 로그인유저가 예약한 내역 현황 가져오기  /reservation/getAllReservation
	@RequestMapping(value = "/getAllReservation", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody  //JSON 응답을 반환하도록 설정
	public List<RentTimeSlotVO> getAllReservation(HttpSession session){ //HttpServletRequest request) { //) {
		
		Logger logger = LoggerFactory.getLogger(this.getClass()); // SLF4J Logger 사용
		
		UserInfo userInfo = (UserInfo) session.getAttribute("user_info");
		long userSeq = userInfo.getUserSeq();
		
		//250206 세션값에서 userSeq 가져오기 경준
//		long userSeq = 1001; // (테스트용으로 로그인유저 1001로 설정)
//		int userSeq = (Integer) request.getSession().getAttribute("SESS_USER_SEQ");
//		UserStatus status = (UserStatus) request.getSession().getAttribute("SESS_STATUS");
		
		
//	    long userSeq = Long.parseLong(requestData.get("userSeq").toString()); // 요청 받은 userSeq
	    logger.info("✅ 요청받은 userSeq: " + userSeq);
	    
//		if(status != null && "ACTIVE".equals(status.name())) {
	    List<RentTimeSlotVO> reservationList = reservationService.getAllReservation(userSeq);
	    logger.info("🔄 조회된 예약 목록: " + reservationList.size() + "개"); // 데이터 개수 확인
	    for (RentTimeSlotVO rvo : reservationList) {
	        logger.info("📌 예약 정보: " + rvo.toString()); // 개별 데이터 확인
	    }
		    
	    return reservationList; //JSON 리스트 반환
//	    } else {
	    	
//	    	return Collections.emptyList();
//	    }
	}

}