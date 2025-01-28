<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>예약 시간 목록 조회</title>
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet" />
<style>
body {
	font-family: Arial, sans-serif;
	display: flex;
	justify-content: center;
	align-items: flex-start;
	gap: 20px;
	margin-top: 40px;
}

#calendar {
	max-width: 800px;
	width: 60%;
}

#schedule {
	width: 30%;
	padding: 20px;
	border: 1px solid #ccc;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

#schedule h3 {
	margin-top: 0;
}

.fc-daygrid-day.disabled {
	background-color: #f0f0f0 !important; /* 회색 배경 */
	pointer-events: none; /* 마우스 클릭 방지 */
	opacity: 0.6; /* 투명도 조정 */
}

.fc-daygrid-day.disabled * {
	color: #a0a0a0 !important; /* 텍스트 색상 변경 */
}

/* FullCalendar 날짜 숫자 색상을 검정색으로 변경 */
.fc-daygrid-day-number {
    color: black !important;  /* 글자색을 완전 검정색으로 변경 */
    font-weight: bold;  /* 글자를 더 진하게 */
}

#timeSlotTable {
    width: 100%;
    border-collapse: collapse; /* 테두리 겹침 */
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* 표 그림자 효과 */
}

#timeSlotTable th, #timeSlotTable td {
    border: 1px solid #ddd;
    padding: 12px;
    text-align: center;
    font-size: 16px;
}

#timeSlotTable th {
    background-color: #007bff; /* 헤더 배경색 (파란색) */
    color: white; /* 헤더 글씨 흰색 */
    font-weight: bold;
}

#timeSlotTable tbody tr:nth-child(even) {
    background-color: #f9f9f9; /* 짝수 행 배경색 */
}

#timeSlotTable tbody tr:hover {
    background-color: #f1f1f1; /* 마우스 호버 시 색상 변경 */
    transition: background-color 0.2s ease-in-out;
}

</style>
</head>

<body>
	<h1>대여 타임 조회</h1>
	<div id="calendar"></div>
	<div id="schedule">
		<h3>대여 타임 슬롯</h3>
		<table id="timeSlotTable">
			<thead>
				<tr>
					<th>대여 시간</th>
					<th>반납 시간</th>
					<th>가격</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody id="timeSlotBody">
				<tr>
					<td colspan="4">날짜를 선택하세요.</td>
				</tr>
			</tbody>
		</table>
	</div>

	<!-- 숨겨진 input 요소 -->
	<input type="hidden" id="selected_date" name="selected_date">
	<input type="hidden" id="post_seq" name="post_seq" value="${KEY_POST.postSeq}">

	<!-- jQuery 로드 (FullCalendar보다 먼저) -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<!-- FullCalendar 로드-->
	<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>

	<script>
	document.addEventListener('DOMContentLoaded', function () {
	    const calendarEl     = document.getElementById('calendar');
	    const timeSlotsEl    = document.getElementById('timeSlots');
	    const selectedDateEl = document.getElementById('selected_date'); // 선택한 날짜 저장
	    const postSeq        = $("#post_seq").val();
	    var postJsonKey      = ${KEY_POST_JSON};
	    
	    // 서버에서 받은 rentTimes 데이터를 활용하여 availableDates 배열 생성
	    var rentTimes = postJsonKey.rentTimes; // rentTimes 리스트
	    var availableDates = [];
	    
	    var standardDate = new Date();
	    
        // rentTimes에서 rent_at만 추출하여 availableDates 배열에 저장
        rentTimes.forEach(function(slot) {
           var rentDate = new Date(slot.rent_at);
           //const year = rentDate.getFullYear();  // 연도
           //const month = rentDate.getMonth() + 1;  // 월 (0부터 시작하므로 +1)
           //const day = rentDate.getDate();  // 일
           //rentDate >= new Date()
           
           //standardDate.getFullYear() <= rentDate.getFullYear()
        	//	&& standardDate.getMonth() <= rentDate.getMonth()
        		//&& standardDate.getDate() <= rentDate.getDate()
           if (standardDate <= rentDate) { // 오늘 날짜 이후의 rent_at만 활성화
        		const year = rentDate.getFullYear();  // 연도
               const month = rentDate.getMonth() + 1;  // 월 (0부터 시작하므로 +1)
               const day = rentDate.getDate();  // 일
               if (!availableDates.includes(year+'-'+month+'-'+day)) {
                  availableDates.push(year+'-'+month+'-'+day);
               }
           }
        });
        // FullCalendar 초기화
        const calendar = new FullCalendar.Calendar(calendarEl, {
        	locale: 'ko',  							// 달력 한국어로 설정
            initialView: 'dayGridMonth',
            selectable: true,
            editable: false,
            showNonCurrentDates: false,  			// 현재 달력에서 현재달에 해당하지않는 날짜는 숨기기
            fixedWeekCount: false,		 			// 불필요한 행 없애기
            validRange: { start: new Date() },   	// 유효범위 : 과거 날짜 선택 불가
            dateClick: function (info) {
                const clickedDate = new Date(info.date);
                clickedDate.setHours(0, 0, 0, 0);  // 시간을 00:00:00:000으로 설정하여 날짜만 비교

                const today = new Date();
                today.setHours(0, 0, 0, 0);  // 오늘 날짜의 시간 부분을 00:00:00:000으로 설정
                
                const year = clickedDate.getFullYear();  // 연도
                const month = clickedDate.getMonth() + 1;  // 월 (0부터 시작하므로 +1)
                const day = clickedDate.getDate();  // 일
                const clickedDayStr = year+'-'+month+'-'+day;

                // 오늘 이전 날짜 클릭 방지
                if (clickedDate < today) return;
				//console.log("avail: " + availableDates + " / " + clickedDate);
                // availableDates 배열에 해당 날짜가 없으면 클릭 방지
                if (!availableDates.includes(clickedDayStr)) {
                    info.jsEvent.preventDefault();  // 클릭 이벤트 취소
                    alert("해당날짜에 예약 가능한 시간이 없습니다.");
                } else {
                    selectedDateEl.value = info.dateStr; 	// 선택한 날짜 저장
                    
                    fetchTimeSlots(clickedDate); 	   // 선택한 날짜에 해당하는 시간대 조회
                }
            },
            dayCellDidMount: function (info) {
            	const year = info.date.getFullYear();  // 연도
                const month = info.date.getMonth() + 1;  // 월 (0부터 시작하므로 +1)
                const day = info.date.getDate();  // 일
                const clickedDayStr = year+'-'+month+'-'+day;
            	

                if (!availableDates.includes(clickedDayStr)) {
                    info.el.style.backgroundColor = "#f0f0f0"; // 배경색 변경 (회색)
                    info.el.style.color = "#bbb"; // 글자색 연하게
                    info.el.style.pointerEvents = "none"; // 클릭 방지
                    info.el.style.opacity = "0.5"; // 반투명 효과
                }
            },
            datesSet: function() {
          	    // 달력 페이지 변경 시 기존 타임슬롯 데이터만 지우고 테이블 구조는 유지
          	    $("#timeSlotBody").empty().append('<tr><td colspan="4">날짜를 선택하세요.</td></tr>');
            }
      });
	    calendar.render();
	});

	// fetchTimeSlots 함수 (document.ready() 필요 없음)
	function fetchTimeSlots(selectedDate) {
		// KEY_POST_JSON.rentTimes를 JavaScript 객체로 변환
	    var postJsonKey = ${KEY_POST_JSON};
	    var rentTimes   = postJsonKey.rentTimes;
	    //console.log(rentTimes);
	    
	    $("#timeSlotBody").empty();
	    
	    rentTimes.forEach((element) => {
	    	const rentAt = new Date(element.rent_at)
	    	if(
	    			selectedDate.getFullYear() == rentAt.getFullYear()
	            	&& selectedDate.getMonth() == rentAt.getMonth()
	            	&& selectedDate.getDate() == rentAt.getDate()
	    	){
	    	//if (new Date(element.rent_at).toISOString().split('T')[0] == selectedDate) {
	    		//var rentAt   = new Date(element.rent_at);
		        var returnAt = new Date(element.return_at);
		        var status   = element.status === 1 ? "예약 가능" : "예약 불가능";
	    		// 시간 값 포맷팅 (ISO 문자열을 활용하여 시각 정보 추출 HH:mm 형식)
		        var rentAtTime   = rentAt;
		        var returnAtTime = returnAt;
		        //console.log(rentAtTime, returnAtTime, status);  // 시간값 확인
		        
		        var button;
	            if (element.status === 1) {
	                button = "<button class=\"request-btn\" data-time-slot-seq=\"" + element.time_slot_seq + "\" style=\"background-color: blue; color: white; padding: 5px 10px; border: none; border-radius: 5px; cursor: pointer;\">대여 가능</button>";
	            } else {
	                button = "<button style=\"background-color: red; color: white; padding: 5px 10px; border: none; border-radius: 5px;\" disabled>대여 불가능</button>";
	            }
		        
		        
		        var row = "<tr>" +
		        "<td>" + rentAtTime.toLocaleString('ko-KR') + "</td>" +
		        "<td>" + returnAtTime.toLocaleString('ko-KR') + "</td>" +
		        "<td>" + element.price + "원</td>" +
		        "<td>" + button + "</td>" +
		        "</tr>";

		        $("#timeSlotBody").append(row);
		    }
		});
	    $(document).on("click", ".request-btn", function () {
	        var timeSlotSeq = $(this).data("time-slot-seq");

	        // 확인 알림창 띄우기
	        if (confirm("예약을 요청보낼까요?")) {
	            $.ajax({
	                url: "/reservation/request-reservation",
	                type: "POST",
	                data: { timeSlotSeq: timeSlotSeq },
	                success: function (response) {
						console.log(response);	                	
	                    alert(response);
	                    //location.reload(); // 페이지 새로고침 (필요 시)
	                },
	                error: function (xhr, status, error) {
	                    alert("예약 요청에 실패했습니다." + xhr.responseText);
	                }
	            });
	        }
	    });
	}
</script>

</body>
</html>