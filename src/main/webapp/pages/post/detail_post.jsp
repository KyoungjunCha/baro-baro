<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c60b5a80c355b99117a9426ef4296a8c&autoload=false&libraries=services,clusterer,drawing"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>바로바로 | baro-borrow</title>
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet" />
<style>
	/* 캘린더 전체요소 */
	#calendar-container{
	    position: absolute;
		display: flex; 					/* 자식 요소들을 수평으로 한줄배치 */
		left: 30;
    	justify-content: flex-start;
	}
	
	/* 캘린더 달력 부분 */
	#calendar {
		max-width: 800px;
		top: 500px; 					/* 원하는 위치 조정 */
    	width: 500px; 					/* 캘린더 크기 조절 */
		display: flex; 					/* 자식 요소들을 수평으로 배치 */
    	justify-content: flex-start; 	/* 자식 요소들을 왼쪽으로 정렬 (기본값) */
	}
	
	/* 캘린더 날짜칸 안의 날짜 요소 */
	.fc-daygrid-day-number {
	    color: black;  					/* 검정색 글자 */
	    font-weight: bold;  			/* 굵게 */
	    text-align: left !important;  	/* 왼쪽 정렬 */
    	padding-left: 5px;  
	}
	
	/* 캘린더 비활성화된 날짜칸 */
	.fc-daygrid-day.disabled {
		background-color: #f0f0f0 !important; /* 회색 배경 */
		pointer-events: none; 				  /* 마우스 클릭 방지 */
		opacity: 0.6; 						  /* 투명도 조정 */
		color: #a0a0a0 !important; 			  /* 텍스트 색상 변경 */
	}
	
	/* 타임슬롯 테이블 */
	#timeSlotTable {
	    position: relative; /* 부모 요소 기준 배치 */
	    top: 0;
	    left: 200px; /* 달력 오른쪽으로 배치 */
	    width: 600px; /* 필요에 따라 조정 */
	    background: white;
	    z-index: 10; /* 달력보다 낮게 설정 */
	    box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
	}
	
	#timeSlotTable th, #timeSlotTable td {
	    border: 1px solid #ddd;
	    padding: 12px;
	    text-align: center;
	    font-size: 16px;
	}
	
	#timeSlotTable th {
	    background-color: #12C1C0;  /* 헤더 배경색 민트 */
	    color: white; 				/* 헤더 글씨 흰색 */
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
<style>
	/* 이미지 조회 */
	.post-images {
		position: relative;
		width: 65%;
		height: 560px;
	    max-width: 500px;
	    overflow: hidden;
	    display:flex;
	}
	.post-images img {
		width: 100%;
		border-radius: 8px;
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
</style>
<style>
	/* 게시글 */
	* {
		margin: 0;
		padding: 0;
		box-sizing: border-box;
	}

	body {
		font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
		color: #212529;
		line-height: 1.5;
	}

	.header-button {
		background-color: #ff6f0f;
		color: white;
		border: none;
		padding: 8px 16px;
		border-radius: 4px;
		cursor: pointer;
	}

	/* 메인 컨테이너 */
	.container {
		max-width: 1024px;
		margin: 0 auto;
		padding: 24px;
	}

	.breadcrumb {
		color: #868e96;
		font-size: 14px;
		margin-bottom: 20px;
		
		display: flex;
	    justify-content: space-between;
	    align-items: center; 
	}

	/* 상품 상세 */
	.product-detail {
		display: flex; 
		gap: 40px;
	}

	.product-images {
		position: relative;
		width: 50%;
	}

	.product-images img {
		width: 100%;
		border-radius: 8px;
	}

	.image-next {
		position: absolute;
		right: 16px;
		top: 50%;
		transform: translateY(-50%);
		background: rgba(255,255,255,0.8);
		border: none;
		width: 40px;
		height: 40px;
		border-radius: 50%;
		cursor: pointer;
	}

	.product-info {
		flex: 1;
	}

	.product-title {
		font-size: 36px;
		margin-bottom: 8px;
		border
	}

	.product-meta {
		color: #868e96;
		font-size: 14px;
		margin-bottom: 16px;
	}

	.product-price {
		font-size: 28px;
		font-weight: bold;
		margin-bottom: 24px;
	}

	.product-description {
	    display: flex;
	    flex-direction: column;
	    gap: 15px; 							/* 박스 간 간격 */
	    max-width: 600px; 					/* 최대 너비 제한 */
	/*     margin: 20px auto; 					/* 가운데 정렬 */ */
	}
	
	.info-box1 {
		height: 200px; 						/* 원하는 높이(px 단위) */
	    background: #ffffff; 				/* 배경색 */
	    border: 1px solid #ddd; 			/* 테두리 */
	    border-radius: 10px; 				/* 둥근 모서리 */
	    padding: 15px; 						/* 내부 여백 */
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	    /* white-space:pre; */
	}
	
	.review-summary-box1 {
		height: 200px; 						/* 원하는 높이(px 단위) */
	    background: #ffffff; 				/* 배경색 */
	    border: 1px solid #ddd; 			/* 테두리 */
	    border-radius: 10px; 				/* 둥근 모서리 */
	    padding: 15px; 						/* 내부 여백 */
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	}
	
	.info-box2 {
	    background: #ffffff; 				/* 배경색 */
	    border: 1px solid #ddd; 			/* 테두리 */
	    border-radius: 10px; 				/* 둥근 모서리 */
	    padding: 15px; 						/* 내부 여백 */
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	    /* white-space:pre; */
	}
	.review-summary-box3 {
		height: 200px; 						/* 원하는 높이(px 단위) */
	    background: #ffffff; 				/* 배경색 */
	    border: 1px solid #ddd; 			/* 테두리 */
	    border-radius: 10px; 				/* 둥근 모서리 */
	    padding: 15px; 						/* 내부 여백 */
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	    display:flex; 
	    gap:20px;
	    width: 1140px;
	}
	.for-review-border {
		border: 1px solid gray;
	}
	
	h5 {
	    margin-top: 0;
	    color: #333;
	    font-weight: bold;
	}
	
	p {
	    margin: 5px 0 0;
	    color: #666;
	    line-height: 1.5;
	}

	.product-meta-info {
		color: #868e96;
		font-size: 14px;
		margin-bottom: 24px;
	}

	.chat-button {
		width: 600px;
		background-color: #12C1C0;
		color: white;
		border: none;
		padding: 16px;
		border-radius: 4px;
		font-size: 16px;
		font-weight: bold;
		cursor: pointer;
	}
	
	.heart {
		cursor: pointer;
		color: #e74c3c;
		font-size: 1.5rem;
		transition: transform 0.2s ease-in-out;
		bottom: 20px; /* 화면 하단에서 20px */
   		right: 20px; /* 화면 우측에서 20px */
	}
	
	.heart:hover {
		transform: scale(1.2);
	}
	.modify-post-button {
		width: 120px;
		background-color: #12C1C0;
		color: white;
		border: none;
		padding: 8px;
		border-radius: 4px;
		font-size: 16px;
		font-weight: bold;
		cursor: pointer;
		right: 20px;
	}
	.user-profile-img {
		widht: 200px;
		height: 120px;
	}
</style>

<style>
   		/* 알림창 배경 */
        #customAlert {
            display: none; /* 기본적으로 숨겨짐 */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
            justify-content: center;
            align-items: center;
            z-index: 9999; /* 다른 콘텐츠 위에 표시 */
        }

        /* 알림창 내용 */
        .alert-content {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            width: 300px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .alert .alert-content button {
        	background: #12c1c0;
			border: none;
			color: white;
			padding: 10px 15px;
			border-radius: 20px;
			cursor: pointer;
			font-size: 16px;
        }
    </style>
    <script>
        // 알림창을 보여주는 함수
        function showAlert(message) {
            document.getElementById('alertMessage').innerText = message;  // 메시지 설정
            document.getElementById('customAlert').style.display = 'flex'; // 알림창 표시
        }

        // 알림창을 닫는 함수
        function closeAlert() {
            document.getElementById('customAlert').style.display = 'none'; // 알림창 숨기기
        }
    </script>
</head>

<body>
	<!-- 알림창 -->
    <div id="customAlert" class="alert">
        <div class="alert-content">
            <p id="alertMessage">알림 메시지가 여기에 표시됩니다.</p>
            <button onclick="closeAlert()">닫기</button>
        </div>
    </div>

	<!-- 공통헤더 -->
	<jsp:include page="/pages/common/header_test_sh.jsp" />
	
	<!-- 메인 -->
	<main class="container">
		<!-- 브래드 크럼 -->
        <div class="breadcrumb" style="width:1140px">
            <a>카테고리 [ ${KEY_POST.categoryName} ]
            <c:if test="${KEY_POST.userSeq == sessionScope.user_info.userSeq}"><button class="modify-post-button">게시글 수정</button></c:if>
            </a>
            <i class="heart bi bi-heart"
							data-post-seq="${KEY_POST.postSeq}"></i>
			
        </div>
		
		<!-- 상품 디테일 [이미지 + 설명] -->
        <div class="product-detail">
        	<!-- 이미지 -->
            <div class="post-images">
	            <c:forEach var="image" items="${KEY_POST.postImages}" varStatus="status">
	                <img src="${image.storagePath.replace('c:\\uploads', '/uploads')}" alt="Post image" class="${status.index == 0 ? 'active' : ''}" />
	            </c:forEach>
	            <div class="post-image-buttons">
	                <button onclick="changeImage(-1)">◁</button>
	                <button onclick="changeImage(1)">▷</button>
	            </div>
	        </div>
			<!-- 설명 -->
            <div class="product-info">
                <h1 class="product-title">${KEY_POST.title}</h1>
                <p class="product-meta">상품 : ${KEY_POST.productName} · 게시글 등록일시 : <fmt:formatDate value="${KEY_POST.postAt}" pattern="yyyy-MM-dd · HH시 mm분"/></p>
                <p class="product-price">10분당 평균 대여가격: ${KEY_POST.pricePerTenMinute}원</p>
                
                <div class="product-description">
				    <div class="info-box1">
				        <h5>상세정보</h5>
				        <pre><p>${KEY_POST.itemContent}</p><pre>
				    </div>
				    <div class="info-box2">
				        <h5>예약방법</h5>
				        <pre><p>${KEY_POST.rentContent}</p></pre>
				    </div>
				</div>

                <div class="product-meta-info" style="height:20px">
                    <br>
                    <span>채팅 ${KEY_POST.existChats}</span> · <span>즐겨찾기 ${KEY_POST.favorites}</span> · <span>조회 ${KEY_POST.count}</span>
                	<br>
                </div>

                <button class="chat-button" type="button" onclick="window.location.href='/chat/createRoom/${KEY_POST.userSeq}'">판매자에게 채팅하기</button>
            </div>
        </div>
        <br>
        <c:if test="${KEY_POST.averageProductReviewScore != null || KEY_POST.productReviewCount != null}">
        	<div class="review-summary-box3">
        		<div style="width: 220px">
        			<img class="user-profile-img" alt="유저 프로필" src="${KEY_POST.userProfile}">
        			<p>${KEY_POST.userNickname}<br/>
        			유저 점수: ${KEY_POST.userScore} 점</p>
        			
        		</div>
        		<div class="for-review-border"></div>
				<div>
					<c:forEach var="i" begin="1" end="${KEY_POST.averageProductReviewScore.intValue()}">
				    	<img src="/icons/star_icon.png" width="20" height="20" />
					</c:forEach>&nbsp;
					<span style="font-weight: bold; font-size:18px">${KEY_POST.averageProductReviewScore}점</span>
					<br/>
					<p style="font-family: Montserrat, sans-serif;font-size: 14px;">
						${KEY_POST.productReviewCount} 건의 리뷰가 있습니다.
					</p>
				</div>
				<div class="for-review-border"></div>
				<div>
					<c:forEach var="i" begin="1" end="${KEY_POST.sampleProductReviewScore.intValue()}">
				    	<img src="/icons/star_icon.png" width="20" height="20" />
					</c:forEach>&nbsp;
					<span style="font-weight: bold; font-size:18px">${KEY_POST.sampleProductReviewScore}점</span>
					<br/>
					${KEY_POST.sampleProductReviewContent}
				</div>
			</div>
        </c:if>
        <c:if test="${KEY_POST.averageProductReviewScore == null || KEY_POST.productReviewCount == null}">
        	<div class="review-summary-box3">
				<div>
					<div style="width: 220px">
	        			<img class="user-profile-img" alt="유저 프로필" src="${KEY_POST.userProfile}">
	        			<p>${KEY_POST.userNickname}<br/>
	        			유저 점수: ${KEY_POST.userScore} 점</p>
	        		</div>
	        		<div class="for-review-border"></div>
					<p style="font-family: Montserrat, sans-serif;font-size: 14px;">
						아직 작성된 리뷰가 없습니다. 첫 고객이 되어보세요
					</p>
				</div>
			</div>
        </c:if>
        <%-- <div class="info-box1" style="width:1140px">
	        <c:set var="score" value="6" />
	        <c:forEach var="i" begin="1" end="${score}">
			    <img src="/icons/star_icon.png" width="20" height="20" />
			</c:forEach>&nbsp;
			<span style="font-weight: bold; font-size:18px">${score}점</span>
			
			<br>
	        	여기 좋아요..
	        	방콕의 라따나코신 지구에 위치한 람부뜨리 빌리지 호텔에 머무르세요. 루프탑 수영장, 테라스, 레스토랑이 있어 두 명의 여행자에게 완벽합니다. 문화 활동, 밤문화, 카오산 로드를 탐험하세요. 여기서 방콕의 최고를 경험해보세요. 람부뜨리 빌리지 호텔은 방콕의 활기찬 배낭여행자 지구인 카오산에 위치하며, 멋진 도시 전망을 감상할 수 있는 루프탑 수영장, 루프탑 테라스, 가이드 투어, 무료 Wi-Fi가 제공되는 에어컨 객실, 금
        </div> --%>
        <br>
        <div class="product-detail" style="display:flex;gap:20px;">
        	
            <div style="flex-bias:600px; min-height: 500px; display: flex; flex-direction: column; overflow: hidden;">
            	<!-- 달력 -->
		        <font color='white'>_______________________________________________</font>
				<div id="calendar-container" >
			        <div id="calendar"></div>
				</div>
            </div>
		
			<div class="product-info">
				<!-- 타임슬롯 테이블 -->
				<table id="timeSlotTable" width="742px">
					<thead>
						<tr>
							<th>대여정보</th>
							<th>반납정보</th>
							<th>가격</th>
						</tr>
					</thead>
					<tbody id="timeSlotBody">
						<tr>
							<td colspan="6">원하시는 날짜를 선택한 후 사용할 시간대를 선택하여 주세요.</td>
						</tr>
					</tbody>
				</table>
            </div>
            
        </div>
    </main>

	<!-- 숨겨진 input 요소 -->
	<input type="hidden" id="selected_date" name="selected_date">
	<input type="hidden" id="post_seq" 	 	name="post_seq" 	value="${KEY_POST.postSeq}">
	
	<!-- jQuery 로드 (FullCalendar보다 먼저 로드하기) -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
	<!-- FullCalendar 로드 -->
	<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
	
	<!-- 이미지 변경 슬라이더 -->
	<script>
        let currentImageIndex = 0;
        const images = document.querySelectorAll('.post-images img');

        function changeImage(direction) {
            images[currentImageIndex].classList.remove('active');
            currentImageIndex = (currentImageIndex + direction + images.length) % images.length;
            images[currentImageIndex].classList.add('active');
        }
    </script>
    
    <!-- 지도, 달력, 타임슬롯 -->
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
                clickedDate.setHours(0, 0, 0, 0);   // 시간을 00:00:00:000으로 설정하여 날짜만 비교

                const today = new Date();
                today.setHours(0, 0, 0, 0);  		// 오늘 날짜의 시간 부분을 00:00:00:000으로 설정
                
                const year = clickedDate.getFullYear();  	// 연도
                const month = clickedDate.getMonth() + 1;  	// 월 (0부터 시작하므로 +1)
                const day = clickedDate.getDate();  		// 일
                const clickedDayStr = year+'-'+month+'-'+day;

                // 오늘 이전 날짜 클릭 방지
                if (clickedDate < today) return;
                // availableDates 배열에 해당 날짜가 없으면 클릭 방지
                if (!availableDates.includes(clickedDayStr)) {
                    info.jsEvent.preventDefault();  		// 클릭 이벤트 취소
                    showAlert("해당날짜에 예약 가능한 시간이 없습니다.");
                } else {
                    selectedDateEl.value = info.dateStr; 	// 선택한 날짜 저장
                 	// 선택한 날짜에 해당하는 시간대 조회
                    fetchTimeSlots(clickedDate);
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
          	    $("#timeSlotBody").empty().append('<tr><td colspan="6">원하시는 날짜를 선택한 후 사용할 시간대를 선택하여 주세요.</td></tr>');
            }
      });
		calendar.render();
	});
	
	// 선택한 날짜에 해당하는 시간대 조회
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

	            var $table = $("#timeSlotTable").css("width", "600px"); // 테이블 너비 600px 설정

	            var $tr = $("<tr></tr>");

	            // 1번째 <td>: 대여정보 + 대여장소
	            var $rentalTd = $("<td></td>").css("font-size", "14px").append(
	                $("<span></span>").css("color", "#12C1C0").text(rentAtTime.toLocaleString('ko-KR')), "<br>",
	                element.rent_location, "<br>"
	            );
	            $rentalTd.append(rentLoc);

	            // 2번째 <td>: 반납정보 + 반납장소
	            var $returnTd = $("<td></td>").css("font-size", "14px").append(
	                $("<span></span>").css("color", "#12C1C0").text(returnAtTime.toLocaleString('ko-KR')), "<br>",
	                element.return_location, "<br>"
	            );
	            $returnTd.append(returnLoc);

	            // 3번째 <td>: 가격 + 버튼
	            var $priceTd = $("<td></td>").css("font-size", "14px").append(
	                element.price + "원", "<br>",
	                button
	            );

	            // <tr>에 <td> 추가
	            $tr.append($rentalTd);
	            $tr.append($returnTd);
	            $tr.append($priceTd);

	            // 테이블에 추가
	            $("#timeSlotBody").append($tr);

	            
	            
	            //원래코드
// 	            var $tr = $("<tr></tr>");
// 	            $tr.append( $("<td></td>").text(rentAtTime.toLocaleString('ko-KR')) );
// 	            $tr.append( $("<td></td>").text(returnAtTime.toLocaleString('ko-KR')) );
// 	            $tr.append( $("<td></td>").text(element.price + "원") );
// 	            var $rentTd = $("<td></td>").append(element.rent_location);
// 	            $rentTd.append(rentLoc); // rentLoc는 이미 DOM 요소
// 	            $tr.append($rentTd);
// 	            var $returnTd = $("<td></td>").append(element.return_location);
// 	            $returnTd.append(returnLoc);
// 	            $tr.append($returnTd);
// 	            $tr.append( $("<td></td>").html(button) );

// 	            $("#timeSlotBody").append($tr);
	            
	            
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
		        	console.log('타임슬롯번호: ' + timeSlotSeq);
		        	
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
	}
	</script>

	<!-- 즐겨찾기 (하트 누르기, 해제하기) -->
	<script>
	$(document).ready(function() {
		const userSeq = '${sessionScope.user_info.userSeq}';
	
		$.ajax({
			url: '/favorite/list',
			type: 'GET',
			data: {userSeq: userSeq},
			success: function(res) {
				$('.heart').each(function() {
					const postSeq = $(this).data('post-seq');
			        if (res.includes(Number(postSeq))) {
						$(this).removeClass('bi-heart').addClass('bi-heart-fill');
					}
				});
			}, 
			error: function () {
	            console.error('즐겨찾기 목록을 불러오는 데 실패했습니다.');
	        }
		});
		
	    $('.heart').click(function() {
	        const heart = $(this);
	        const postSeq = heart.data('post-seq');
	        
	        console.log('userSeq', userSeq);
	        console.log('postSeq', postSeq);
	        
	        $.ajax({
	            url: '/favorite/toggle',
	            type: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify({
	                userSeq: userSeq,
	                postSeq: postSeq
	            }),
	            success: function(response) {
	                if (response === 'deleted') {
	                	heart.removeClass('bi-heart-fill').addClass('bi-heart');
	                } else if(response === 'added') {
	                	heart.removeClass('bi-heart').addClass('bi-heart-fill');
	                }
	            },
	            error: function () {
	                alert('즐겨찾기 해제에 실패했습니다.');
	            }
	        });
	    });
	});
	
	document.getElementById("modifyPostButton").addEventListener("click", function () {
        window.location.href = "/post/update_page/" + ${KEY_POST_postSeq}; // 이동할 URL
    });
	
	</script>

</body>
</html>