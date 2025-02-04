<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c60b5a80c355b99117a9426ef4296a8c&autoload=false&libraries=services,clusterer,drawing"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>바로바로 | baro-borrow</title>
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
	#detail-post-container{
		width: 1000px;
	}
	.post-images {
	    position: relative;
	    max-width: 500px;
	    margin: auto;
	    overflow: hidden;
	}
	.post-images img {
	    width: 100%;
	    display: none;
	}
	.post-images img.active {
	    display: block;
	}
	.post-image-buttons {
	    position: absolute;
	    top: 50%;
	    width: 100%;
	    display: flex;
	    justify-content: space-between;
	    transform: translateY(-50%);
	}
	.post-image-buttons button {
	    background-color: rgba(0, 0, 0, 0.5);
	    color: white;
	    border: none;
	    padding: 10px;
	    cursor: pointer;
	}
	.post-container {
	    margin: 20px;
	}
	.post-title {
	    font-size: 24px;
	    font-weight: bold;
	}
	.post-content {
	    margin-top: 10px;
	}
	.post-footer {
	    margin-top: 20px;
	    font-size: 14px;
	} 
</style>
</head>

<body>


	<jsp:include page="/pages/common/header_test_sh.jsp" />

	<div id="detail-post-container">
		<div class="post-info-container">
			<h1 class="post-title">${KEY_POST.title}</h1>

	        <div class="post-images">
	            <c:forEach var="image" items="${KEY_POST.postImages}" varStatus="status">
	                <img src="${image.storagePath.replace('c:\\uploads', '/uploads')}" alt="Post image" class="${status.index == 0 ? 'active' : ''}" />
	            </c:forEach>
	            <div class="post-image-buttons">
	                <button onclick="changeImage(-1)">◁</button>
	                <button onclick="changeImage(1)">▷</button>
	            </div>
	        </div>
	
	        <div class="post-content">
	            <h3>Item Content</h3>
	            <p>${KEY_POST.itemContent}</p>
	
	            <h3>Rent Content</h3>
	            <p>${KEY_POST.rentContent}</p>
	        </div>
	
	        <div class="post-footer">
	            <p>Product Name: ${KEY_POST.productName}</p>
	            <p>Category: ${KEY_POST.categoryName}</p>
	            <p>Posted At: ${KEY_POST.postAt}</p>
	            <p>View Count: ${KEY_POST.count}</p>
	        </div>
		</div>
		
		<div class="reservation-container">
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
							<th>대여 장소</th>
							<th>반납 장소</th>
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
		</div>
	</div>

	<!-- 숨겨진 input 요소 -->
	<input type="hidden" id="selected_date" name="selected_date">
	<input type="hidden" id="post_seq" name="post_seq" value="${KEY_POST.postSeq}">
	<!-- jQuery 로드 (FullCalendar보다 먼저) -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- FullCalendar 로드-->
	<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
	<script>
        let currentImageIndex = 0;
        const images = document.querySelectorAll('.post-images img');

        function changeImage(direction) {
            images[currentImageIndex].classList.remove('active');
            currentImageIndex = (currentImageIndex + direction + images.length) % images.length;
            images[currentImageIndex].classList.add('active');
        }
    </script>
	<script>
	
	document.addEventListener('DOMContentLoaded', function () {
		kakao.maps.load(() => {});
	    const calendarEl     = document.getElementById('calendar');
	    const timeSlotsEl    = document.getElementById('timeSlots');
	    const selectedDateEl = document.getElementById('selected_date'); // 선택한 날짜 저장
	    const postSeq        = $("#post_seq").val();
	    var postJsonKey      = ${KEY_POST_JSON};
	    
	    var rentTimes = postJsonKey.rentTimes; // rentTimes 리스트
	    var availableDates = [];
	    
	    var standardDate = new Date();
	    
        rentTimes.forEach(function(slot) {
           var rentDate = new Date(slot.rent_at);
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
          	    $("#timeSlotBody").empty().append('<tr><td colspan="4">날짜를 선택하세요.</td></tr>');
            }
      });
		calendar.render();
	});

	function fetchTimeSlots(selectedDate) {
	    var postJsonKey = ${KEY_POST_JSON};
	    var rentTimes   = postJsonKey.rentTimes;
	    
	    $("#timeSlotBody").empty();
	    
	    rentTimes.forEach((element) => {
	    	const rentAt = new Date(element.rent_at)
	    	if(
	    			selectedDate.getFullYear() == rentAt.getFullYear()
	            	&& selectedDate.getMonth() == rentAt.getMonth()
	            	&& selectedDate.getDate() == rentAt.getDate()
	    	){
		        var returnAt = new Date(element.return_at);
		        var status   = element.status === 1 ? "예약 가능" : "예약 불가능";
		        var rentAtTime   = rentAt;
		        var returnAtTime = returnAt;
		        
		        var button;
	            if (element.status === 1) {
	                button = "<button type=\"button\" class=\"request-btn\" data-time-slot-seq=\"" + element.time_slot_seq + "\" style=\"background-color: blue; color: white; padding: 5px 10px; border: none; border-radius: 5px; cursor: pointer;\">대여 가능</button>";
	            } else {
	                button = "<button style=\"background-color: red; color: white; padding: 5px 10px; border: none; border-radius: 5px;\" disabled>대여 불가능</button>";
	            }
	            
	            
	            
				var rentLoc = document.createElement('div');   
	           	rentLoc.style.width = "200px";   
	           	rentLoc.style.height = "150px";  
	            var returnLoc = document.createElement('div');   
	            returnLoc.style.width = "200px";   
	            returnLoc.style.height = "150px";  
	            
	            
	            var $tr = $("<tr></tr>");
	            $tr.append( $("<td></td>").text(rentAtTime.toLocaleString('ko-KR')) );
	            $tr.append( $("<td></td>").text(returnAtTime.toLocaleString('ko-KR')) );
	            $tr.append( $("<td></td>").text(element.price + "원") );
	            var $rentTd = $("<td></td>").append(element.rent_location);
	            $rentTd.append(rentLoc); // rentLoc는 이미 DOM 요소
	            $tr.append($rentTd);
	            var $returnTd = $("<td></td>").append(element.return_location);
	            $returnTd.append(returnLoc);
	            $tr.append($returnTd);
	            $tr.append( $("<td></td>").html(button) );

	            $("#timeSlotBody").append($tr);
	            
	            
	            var rentMarker = {
	            	    position: new kakao.maps.LatLng(element.rent_rotate_x, element.rent_rotate_y), 
	            	    text: '대여 장소' // text 옵션을 설정하면 마커 위에 텍스트를 함께 표시할 수 있습니다
	            	};
	            
	            var returnMarker = {
	            	    position: new kakao.maps.LatLng(element.return_rotate_x, element.return_rotate_y), 
	            	    text: '반납 장소' // text 옵션을 설정하면 마커 위에 텍스트를 함께 표시할 수 있습니다
	            	};
	            
	            rentStaticMapOption = { 
	                    center: new kakao.maps.LatLng(element.rent_rotate_x, element.rent_rotate_y), // 이미지 지도의 중심좌표
	                    level: 3, // 이미지 지도의 확대 레벨
	                    marker: rentMarker // 이미지 지도에 표시할 마커
	                };
	            returnStaticMapOption = { 
	                    center: new kakao.maps.LatLng(element.return_rotate_x, element.return_rotate_y), // 이미지 지도의 중심좌표
	                    level: 3, // 이미지 지도의 확대 레벨
	                    marker: returnMarker // 이미지 지도에 표시할 마커
	                };
	            
	            var rentMap = new kakao.maps.StaticMap(rentLoc, rentStaticMapOption);
	            var returnMap = new kakao.maps.StaticMap(returnLoc, returnStaticMapOption);
		    }
	    	const buttons = document.querySelectorAll(".request-btn");

	        // 각 버튼에 클릭 이벤트 리스너 추가
	        buttons.forEach(button => {
	          button.addEventListener("click", function() {
	        	var timeSlotSeq = $(this).data("time-slot-seq");  
	        	console.log('히히: ' + timeSlotSeq);
	        	if (confirm("예약을 요청보낼까요?")) {
		            $.ajax({
		                url: "/reservation/request-reservation",
		                type: "POST",
		                data: { timeSlotSeq: timeSlotSeq },
		                success: function (response) {
							console.log(response);	                	
		                    alert(response);
		                    location.reload(); // 페이지 새로고침 (필요 시)
		                },
		                error: function (xhr, status, error) {
		                    alert("예약 요청에 실패했습니다." + xhr.responseText);
		                }
		            });
		        }
	          });
	        });
		});
	    /* $(document).on("click", ".request-btn", function () {
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
	    }); */
	}
</script>

</body>
</html>