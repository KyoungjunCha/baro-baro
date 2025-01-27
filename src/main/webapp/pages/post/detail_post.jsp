<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
	    </style>
	</head>
	
	
	<body>
	    <h1>대여 타임 조회</h1>
	
<!-- 	    <button id="fetchTimeSlots">시간 목록 조회</button> -->
	
	    <div id="calendar"></div>
	    <div id="schedule">
	        <h3>대여 타임 슬롯</h3>
	        <ul id="timeSlotList">
	            <li>날짜를 선택하세요.</li>
	        </ul>
	    </div>
		
		<!-- 숨겨진 input 요소 -->
		<input type="hidden" id="selected_date" name="selected_date">
		<input type="hidden" id="post_seq" name="post_seq" value=1001>
		
		
		<!-- jQuery 로드 -->
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		
		<!-- FullCalendar 로드-->
	    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
	    
	    
	    <script>
	        document.addEventListener('DOMContentLoaded', function () {
	            const calendarEl     = document.getElementById('calendar');
	            const timeSlotsEl    = document.getElementById('timeSlots');
	            const selectedDateEl = document.getElementById('selected_date'); // 선택한 날짜 저장
	            const postSeq = $("#post_seq").val();
	            let selectedDate = "";
	            
	            // 한국 시간(UTC+9) 기준 오늘 날짜를 Date 객체로 반환
	            function getToday() {
	                const now = new Date();
	                now.setHours(now.getHours() + 9); // UTC+9 변환
	                now.setHours(0, 0, 0, 0); // 날짜만 비교하도록 초기화
	                return now;
	            }
	
	            const today = getToday(); // 오늘 날짜 설정
	
	
	            const calendar = new FullCalendar.Calendar(calendarEl, {
	                initialView: 'dayGridMonth',
	                selectable: true,
	                editable: true,
	                validRange: { start: today },   // 과거 날짜 선택 불가 
	                dateClick: function (info) {
	                    const clickedDate = new Date(info.date);
	                    clickedDate.setHours(0, 0, 0, 0); 	// 날짜 비교를 위해 시간 초기화
	                    if (clickedDate < today) return;	// 과거 날짜 클릭 방지
	                    
	                    selectedDate = info.dateStr;
	                	selectedDateEl.value = selectedDate; // 선택한 날짜 요소 업데이트
	                    
	                	// 날짜 클릭 시 자동 조회
	                	fetchTimeSlots(selectedDate, postSeq); 
	                },
	                dayCellDidMount: function (info) {
	                    const cellDate = new Date(info.date);
	                    cellDate.setHours(0, 0, 0, 0); // 날짜만 비교
	
	                    // 오늘 날짜는 활성화, 과거 날짜만 비활성화
	                    if (cellDate < today) {
	                        info.el.classList.add('disabled');
	                    } 

	                },
	                datesSet: function() {
	                    // 달력 페이지가 변경될 때마다 타임슬롯 리스트 비우기
	                    $("#timeSlotList").empty();
	                }
	            });
	
	            calendar.render();

	        });
	    </script>
		
		
		<script>
				// fetchTimeSlots 함수 (document.ready() 필요 없음)
		    	function fetchTimeSlots(selectedDate, postSeq) {
		            $("#selected_date").val(selectedDate); // 히든 필드에 날짜 저장
		
		            if (!postSeq || !selectedDate) {
		                alert("게시물 번호와 날짜를 확인하세요.");
		                return;
		            }
	
	                $.ajax({
	                    url: "/reservation/time-slot-list",
	                    type: "GET",
	                    data: {
	                        post_seq: postSeq,
	                        selected_date: selectedDate
	                    },
	                    dataType: "json",
	                    success: function(response) {
	                        $("#timeSlotList").empty();
	                        if (response.length === 0) {
	                            $("#timeSlotList").append("<p>해당 날짜의 예약 가능한 시간이 없습니다.</p>");
	                        } else {
	                            var table = "<table border='1'><tr><th>대여 시간</th><th>반납 시간</th><th>상태</th></tr>";
	                            $.each(response, function(index, slot) {
	                                table += "<tr>" +
	                                         "<td>" + slot.rent_at.split(".")[0] + "</td>" +
	                                         "<td>" + slot.return_at.split(".")[0] + "</td>" +
	                                         "<td>" + (slot.status === 1 ? "예약 가능" : "예약 불가능") + "</td>" +
	                                         "</tr>";
	                            });
	                            table += "</table>";
	                            $("#timeSlotList").append(table);
	                        }
	                    },
	                    error: function(xhr, status, error) {
	                        console.log("에러 발생: ", error);
	                        alert("시간 목록을 불러오는 중 오류가 발생했습니다.");
	                    }
	                });
	            }
	    </script>
	</body>
</html>
