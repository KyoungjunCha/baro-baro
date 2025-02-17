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
	
	/* 캘린더 오늘날짜 */
	.fc-today {
    background-color: yellow !important;
    color: black !important;
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
		text-align: left !important;
		padding-left: 5px;  /* 왼쪽 여백을 추가하여 텍스트가 너무 붙지 않도록 할 수 있습니다 */
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
    
    <style>
	   /* 댓글 전체 스타일을 조금 더 세밀하게 조정 */
	.comment-container {
	    width: 100%;
	    max-width: 600px; /* 댓글 등록 폼과 크기를 동일하게 맞추기 위해 max-width 설정 */
	    margin: 0 auto;
	}
	
	/* 댓글 테이블 크기 조정 */
	.comment-table {
	    width: 100%;
	    border-collapse: collapse;
	    margin-top: 10px;
	    font-size: 0.9em; /* 글씨 크기를 조금 작게 조정 */
	}
	
	/* 댓글 항목의 크기 줄이기 */
	.comment-table td {
	    padding: 8px 10px; /* 패딩 줄여서 크기 조정 */
	    border-bottom: 1px solid #ccc;
	    vertical-align: top;
	}
	
	/* 최상위 댓글 스타일 */
	.comment-item {
	    background-color: #ffffff;
	    border-left: 4px solid #007BFF;
	    padding-left: 10px;
	    font-size: 0.9em; /* 댓글 내용 글씨 크기 줄이기 */
	}
	
	/* 대댓글 스타일 */
	.reply-item {
	    background-color: #f1f1f1;
	    border-left: 4px solid #28a745;
	    padding-left: 20px;
	    font-size: 0.9em; /* 대댓글 글씨 크기 줄이기 */
	}
	
	/* 댓글 내용 줄이기 */
	.comment-content {
	    margin-top: 5px;
	    font-size: 0.9em; /* 내용의 폰트 크기 줄이기 */
	}
	
	/* 댓글 작성 폼과 테이블 간 간격 좁히기 */
	#commentInsertForm {
	    margin-bottom: 20px;
	}
	/* 댓글 입력 폼 */
	#commentInsertForm input[type="text"] {
	    width: 100%; /* 너비를 100%로 설정하여 부모 요소에 맞추기 */
	    padding: 10px; /* 안쪽 여백을 늘려서 입력 공간을 키움 */
	    font-size: 1em; /* 폰트 크기 조정 */
	    height: 40px; /* 높이를 설정하여 더 넓은 입력란을 만듦 */
	    border: 1px solid #ccc; /* 테두리 추가 */
	    border-radius: 5px; /* 테두리 모서리를 둥글게 */
	    box-sizing: border-box; /* 패딩과 테두리를 포함하여 전체 크기를 계산 */
	}
	
	#commentInsertForm label {
	    font-size: 0.9em; /* 라벨 폰트 크기 조금 줄이기 */
	}
	
	#commentInsertForm input[type="button"] {
	    padding: 10px 20px; /* 버튼 크기 조정 */
	    font-size: 1em; /* 버튼 폰트 크기 */
	}
	/* 댓글 입력 폼 내의 비밀댓글 체크박스와 댓글 등록 버튼을 오른쪽 정렬 */
	#commentInsertForm .comment-options {
	    display: flex;
	    justify-content: flex-end; /* 요소들을 오른쪽 정렬 */
	    align-items: center; /* 세로로 가운데 정렬 */
	    margin-top: 10px; /* 위쪽 마진 추가 */
	}
	
	#commentInsertForm .comment-options input[type="checkbox"] {
	    margin-right: 10px; /* 체크박스와 버튼 사이의 간격을 좀 더 추가 */
	}
	
	#commentInsertForm input[type="button"] {
	    padding: 10px 20px; /* 버튼 크기 조정 */
	    font-size: 1em; /* 버튼 폰트 크기 */
	}
	
	/* 대댓글 텍스트 입력란 크기 키우기 */
	.reply-content {
	    width: 100%; /* 입력란 너비를 100%로 설정 */
	    height: 50px; /* 입력란 높이 설정 */
	    font-size: 1.2em; /* 글씨 크기 설정 */
	    padding: 10px; /* 여백 추가 */
	    box-sizing: border-box; /* 여백이 포함된 크기로 설정 */
	    border-radius: 5px; /* 모서리 둥글게 */
	    border: 1px solid #ccc; /* 테두리 스타일 */
	}
	
	.reply-options {
	    display: flex;
	    justify-content: flex-end; /* 오른쪽 정렬 */
	    align-items: center; /* 세로로 가운데 정렬 */
	    margin-top: 10px; /* 위쪽 여백 */
	}
	
	.reply-options input[type="checkbox"] {
	    margin-right: 10px; /* 체크박스와 버튼 사이의 간격 */
	}
	
	.reply-options input[type="button"] {
	    padding: 8px 16px; /* 버튼 크기 조정 */
	    font-size: 1em; /* 버튼 폰트 크기 */
	}

	
	
	</style>
	
	
    <style>
    	/* 신고 모달 스타일 지정 */
#reportModal {
    display: none;
    position: fixed;
    z-index: 1000; /* 다른 모달과 겹치지 않도록 z-index 증가 */
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: #fff; /* 전체 배경을 하얀색으로 설정 */
    padding-top: 50px;
    overflow-y: auto;
}

/* 모달 콘텐츠 (모든 내용이 하얀 배경을 가지도록 설정) */
.modal-content {
    background-color: #fff; /* 모달 내용 영역은 하얀색 배경 */
    margin: auto;
    padding: 30px;
    border-radius: 12px;
    max-width: 700px;
    width: 80%; /* 반응형 디자인 */
    max-height: 80vh; /* 최대 높이를 지정하여 화면에 맞게 크기 조절 */
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
    font-family: Arial, sans-serif;
    overflow-y: auto;
}

/* 신고 타이틀 */
h3 {
    font-size: 26px;
    color: #333;
    margin-bottom: 20px;
    font-weight: 600;
}

/* 신고 유형 리스트 */
ul {
    list-style-type: none;
    padding-left: 20px;
    margin: 0;
}

li {
    margin: 12px 0;
    padding: 10px;
    background-color: #f9f9f9;
    border-radius: 8px;
    transition: background-color 0.3s;
}

li:hover {
    background-color: #e6e6e6;
}

/* 신고 유형 클릭시 스타일 */
.toggle {
    font-size: 18px;
    font-weight: bold;
    cursor: pointer;
    color: #1d72b8;
    transition: color 0.3s;
}

.toggle:hover {
    color: #0056a1;
}

/* 서브 항목 스타일 */
.sub-category,
.detail-category {
    display: none;
    padding-left: 30px;
}

.sub-category li,
.detail-category li {
    background-color: #f0f0f0;
    border-radius: 6px;
    padding: 10px;
}

.sub-category li:hover,
.detail-category li:hover {
    background-color: #d1d1d1;
}

/* 선택된 옵션 스타일 */
.selected-option {
    margin-top: 25px;
    padding: 12px;
    background-color: #f1f1f1;
    border-radius: 6px;
    font-style: italic;
    color: #555;
    border: 1px solid #ddd;
}

/* 신고 사유 텍스트영역 */
textarea {
    width: 100%;
    padding: 12px;
    font-size: 16px;
    border: 1px solid #ddd;
    border-radius: 6px;
    margin-top: 12px;
    resize: vertical;
}

textarea:focus {
    outline: none;
    border-color: #1d72b8;
}

/* 신고 버튼 */
#submitReportBtn {
    background-color: #1d72b8;
    color: white;
    padding: 12px 24px;
    font-size: 18px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.3s;
    margin-top: 20px;
}

#submitReportBtn:hover {
    background-color: #0056a1;
}

/* 신고 버튼 */
.report-btn {
    background-color: #12C1C0; /* 청록색 배경 */
    color: white; /* 글자색 */
    border: none;
    padding: 8px 16px;
    font-size: 14px;
    font-weight: bold;
    border-radius: 20px; /* 둥근 버튼 */
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.report-btn:hover {
    background-color: #0FA8A7; /* 더 진한 청록색 */
    transform: scale(1.05); /* 약간 확대 효과 */
}

.report-btn:active {
    background-color: #0D8F8E; /* 클릭 시 어두운 청록색 */
    transform: scale(0.95); /* 클릭 시 약간 축소 */
}
    	
		    	
	</style>
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
            <c:if test="${KEY_POST.userSeq == sessionScope.user_info.userSeq}">
            	<button class="modify-post-button" onclick="window.location.href='/post/update_page/${KEY_POST.postSeq}'">게시글 수정</button>
            </c:if>
            <c:if test="${reviewIsAvailable}">
            	<button class="modify-post-button" onclick="window.location.href='/post/createReviewPage/${KEY_POST.postSeq}'">리뷰 작성하기</button>
            </c:if>
            </a>
            <i class="heart bi bi-heart"
							data-post-seq="${KEY_POST.postSeq}"></i>
			
        </div>
        
        <!-- 신고 버튼 (오른쪽 정렬 & 스타일 적용) -->
		<div style="width: 1140px; display: flex; justify-content: flex-end; margin-top: 5px;">
		    <button id="reportBtn" class="report-btn">게시글 신고</button>
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

                <button class="chat-button" type="button" onclick="window.location.href='/chat/createRoom/${KEY_POST.postSeq}'">판매자에게 채팅하기</button>
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
                    info.el.style.textAlign = "left"; // 날짜 텍스트 왼쪽 정렬
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
		console.log('userSeqqqq: ', userSeq);
	
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
		
		 $(document).on('click', '.heart', function() {
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
	
	/* document.getElementById("modifyPostButton").addEventListener("click", function () {
        window.location.href = "/post/update_page/" + ${KEY_POST.postSeq}; // 이동할 URL
    }); */

	</script>
	
	<!-- 신고 모달 -->
	<div id="reportModal">
	    <div class="modal-content">
	        <span class="close">&times;</span>
	        <h3>게시글 신고</h3>
	        <form id="reportForm">
	            <label for="reportType" style="font-size: 18px; font-weight: bold;">신고 유형 (필수)</label><br>
	            <div id="reportType">
	                <ul>
	                    <li>
	                        <span class="toggle">1. 거래 금지 물품이에요.</span>
	                        <ul class="sub-category">
	                            <li>
	                                <span class="toggle">의약품 / 의료기기</span>
	                                <ul class="detail-category">
	                                    <li>체온계, 혈압계 제외 / 동물용 의약품, 한약, 다이어트약 포함</li>
	                                </ul>
	                            </li>
	                            <li>
	                                <span class="toggle">상표권 침해 물품</span>
	                                <ul class="detail-category">
	                                    <li>가품, 이미테이션, 위조물품 포함</li>
	                                </ul>
	                            </li>
	                            <li>
	                                <span class="toggle">저작권 침해 물품</span>
	                                <ul class="detail-category">
	                                    <li>불법 개조 물품, 불법 복제 소프트웨어·컨텐츠 포함</li>
	                                </ul>
	                            </li>
	                            <li>
	                                <span class="toggle">개인정보</span>
	                                <ul class="detail-category">
	                                    <li>총포·도검, 화약류, 모의 총포 및 부속품, 레이저 포인터 포함</li>
	                                </ul>
	                            </li>
	                            <li>
	                                <span class="toggle">위험한 물건</span>
	                                <ul class="detail-category">
	                                    <li>가품, 이미테이션, 위조물품 포함</li>
	                                </ul>
	                            </li>
	                            <li>
	                                <span class="toggle">위험한 물질</span>
	                                <ul class="detail-category">
	                                    <li>농약, 유독물, 휘발유, 경유, LPG 포함</li>
	                                </ul>
	                            </li>
	                            <li>
	                                <span class="toggle">군·경찰용품 / 제복류</span>
	                                <ul class="detail-category">
	                                    <li>유사경찰제복, 유사경찰장비, 소방복 및 유사 제복류, 군마트용품 포함</li>
	                                </ul>
	                            </li>
	                            <li>
	                                <span class="toggle">안경 / 콘택트렌즈</span>
	                                <ul class="detail-category">
	                                    <li>서클렌즈, 컬러렌즈, 도수 선글라스, 도수 수경 포함</li>
	                                </ul>
	                            </li>
	                            <li>
	                                <span class="toggle">암표 매매</span>
	                                <ul class="detail-category">
	                                    <li>모든 종류의 암표매매</li>
	                                </ul>
	                            </li>
	                            <li>
	                                <span class="toggle">위해 우려 물품</span>
	                                <ul class="detail-category">
	                                    <li>안전인증 누락, 불법직구 제품, 리콜로 인한 회수·폐기 제품 포함</li>
	                                </ul>
	                            </li>
	                            <li>
	                                <span class="toggle">기타</span>
	                                <ul class="detail-category">
	                                    <li>헌혈증, 종량제, 1,000달러 이상 외환, 100만원 이상 순금, 도난 물품 등</li>
	                                </ul>
	                            </li>
	                        </ul>
	                    </li>
	                    <li>
	                        <span class="toggle">2. 대여 물품 게시글이 아니에요</span>
	                        <ul class="sub-category">
	                            <li>
	                                <span class="toggle">사용자 칭찬, 리뷰 등을 조작하는 게시글이에요</span>
	                                <ul class="detail-category">
	                                    <li>바로바로 서비스가 아닌 다른 서비스의 정보를 조작한다고 하는 경우에도 신고해주세요.</li>
	                                </ul>
	                            </li>
	                            <li>
	                                <span class="toggle">물품을 거래하는 게시글이에요</span>
	                                <ul class="detail-category">
	                                    <li>바로바로에서는 모든 거래는 불가해요.</li>
	                                    <li>예시의 내용말고 모든 종류의 거래를 시도하는 게시물이면 신고해주세요.</li>
	                                    <li>예시 : 부동산 거래, 중고차 판매, 농수산물 판매</li>
	                                </ul>
	                            </li>
	                            <li>
	                                <span class="toggle">구인구직</span>
	                                <ul class="detail-category">
	                                    <li>아르바이트, 기간제, 정규직 등 모든 종류의 구인구직글일 경우 신고해주세요.</li>
	                                </ul>
	                            </li>
	                            <li>
	                                <span class="toggle">과외 / 클래스 모집</span>
	                                <ul class="detail-category">
	                                    <li>모든 종류의 과외 / 클래스 모집글인 경우 신고해주세요.</li>
	                                </ul>
	                            </li>
	                            <li>
	                                <span class="toggle">비방 / 저격</span>
	                                <ul class="detail-category">
	                                    <li>비방 / 저격글일 경우 신고해주세요</li>
	                                </ul>
	                            </li>
	                            <li>
	                                <span class="toggle">일반 게시물</span>
	                                <ul class="detail-category">
	                                    <li>대여와 관련없는 잡담, 질문 등 게시글인 경우 신고해주세요.</li>
	                                </ul>
	                            </li>
	                        </ul>
	                    </li>
	                    <li>
	                        <span class="toggle">3. 사기인 것 같아요.</span>
	                        <ul class="sub-category">
	                            <li>
	                                <span class="toggle">입금했는데 대여자가 물건을 주지 않았어요</span>
	                                <ul class="detail-category">
	                                    <li>입금 후 물건을 대여받지 못한경우 신고해주세요.</li>
	                                </ul>
	                            </li>
	                            <li>
	                                <span class="toggle">바로바로 채팅 밖으로 대화를 유도해요 </span>
	                                <ul class="detail-category">
	                                    <li>바로바로 채팅 외 다른 채팅으로 대화를 요구한다면 신고해주세요.</li>
	                                </ul>
	                            </li>
	                            <li>
	                                <span class="toggle">개인정보를 탈취해요 </span>
	                                <ul class="detail-category">
	                                    <li>개인정보를 요구하는 경우 신고해주세요.</li>
	                                </ul>
	                            </li>
	                            <li>
	                                <span class="toggle">직거래를 거부하고 비대면거래만 유도해요 </span>
	                                <ul class="detail-category">
	                                    <li>직거래를 거부하고 비대면거래만 원하면 신고해주세요.</li>
	                                </ul>
	                            </li>
	                        </ul>
	                    </li>
	                    <li>
	                        <span class="toggle">4. 기타 부적절한 내용/설명이 있어요.</span>
	                        <ul class="sub-category">
	                            <li>
	                                <span class="toggle">사용할 수 없는 상품</span>
	                                <ul class="detail-category">
	                                    <li>물품 및 장소의 상태가 매우 좋지 않거나 연식이 오래되어서 더 이상 사용할 수 없으면 신고해 주세요.</li>
	                                </ul>
	                            </li>
	                            <li>
	                                <span class="toggle">중복 게시글</span>
	                                <ul class="detail-category">
	                                    <li>중복게시물일 경우 신고해주세요.</li>
	                                </ul>
	                            </li>
	                            <li>
	                                <span class="toggle">상품/장소 설명 부족</span>
	                                <ul class="detail-category">
	                                    <li>상품/장소의 설명이 부족한 경우 신고해주세요.</li>
	                                </ul>
	                            </li>
	                            <li>
	                                <span class="toggle">나에게 대여 후 비싸게 재대여</span>
	                                <ul class="detail-category">
	                                    <li>어떠한 경우에도 바로바로에서 대여한 물품 및 장소를 더 높은 가격으로 재거래 할 수 없습니다.</li>
	                                    <li>반복적으로 재거래하는 사용자를 발견한 경우 알려주세요</li>
	                                </ul>
	                            </li>
	                        </ul>
	                    </li>
	                </ul>
	            </div><br>
	
	            <label for="reportReason" style="font-size: 18px; font-weight: bold;">신고 사유 (선택)</label><br>
	            <textarea id="reportReason" name="reportReason" rows="4" placeholder="신고 사유를 입력해주세요."></textarea><br><br>
	
	            <button type="button" id="submitReportBtn">신고하기</button>
	        </form>
	    </div>
	</div>
	
	
	
	
	<!-- 댓글 작성 폼 -->
	<div class="comment-container">
		<!-- 댓글 목록 출력-->
	    <h3>댓글 목록</h3>
	    <div id="commentListDiv"></div>
		
		<!-- 댓글 작성 영역 -->
	    <h3>댓글 작성</h3>
	    <form id="commentInsertForm">
	        <input type="hidden" name="postSeq" id="postSeq" value="${POSTDETAIL.postSeq}">
	        <input type="hidden" name="userSeq" value="1002">
	        
	        <input type="text" name="content" id="content" placeholder="댓글 입력">
	        
	        <div class="comment-options">
	            <label>
	                <input type="checkbox" name="secret" id="secret" value="1"> 비밀댓글
	            </label>
	            <input type="button" id="commentInsertBtn" value="댓글등록">
	        </div>
	    </form>
	</div>
	
	<script>
		$(document).ready(function() {
			// 서버에서 받는 userSeq
			const userSeq = '${sessionScope.user_info.userSeq}';
			
			//--------------------------- 댓글기능 시작 ---------------------------
			
			// 댓글조회
		    function loadComments() {
		        console.log("서버에서 받은 userSeq:", userSeq);
		        $.ajax({
		            method: "GET",
		            url: "${pageContext.request.contextPath}/post/detail_comment",
		            data: { 
		                //postSeq: "${POSTDETAIL.postSeq}",
		                postSeq: 1,
		                userSeq: userSeq // 예시로 1로 설정, 실제로는 로그인된 사용자 ID로 변경 필요
		            },
		success: function(comments) {
		                
		                console.log("서버에서 받은 댓글 목록: ", comments); // 여기 추가!
		                
		                var htmlStr = "<table class='comment-table'>";
		                
		                $(comments).each(function(index, comment) {
		                    htmlStr += "<tr class='comment-item'><td>";
		                    
		                    // 삭제된 댓글 처리
		                    if (comment.status == 1) {
		                        htmlStr += "<span class='deleted-comment'>삭제된 댓글입니다.</span>";
		                    } else if (comment.secret == 1 && !Boolean(comment.canViewSecret)) {
		                        // 비밀글이면서 현재 사용자가 볼 수 없는 경우
		                        htmlStr += "<span class='secret-comment'>비밀글입니다.</span>";
		                    } else {
		                        htmlStr += comment.createdAt + " | ";
		                        htmlStr += comment.nickname + " ";
		                        htmlStr += "<div class='comment-content'>" + comment.content + "</div>";
		
		                        htmlStr += "<div class='button-group'>";
		                        htmlStr += " <input type='button' value='답글' class='reply_show_btn' data-commentSeq='" + comment.commentSeq + "'>";
		
		                        // 댓글 작성자만 수정 및 삭제 버튼 보이기
		                        if (comment.userSeq == userSeq) { // 로그인된 사용자 userSeq가 댓글 작성자와 같을 경우
		                            htmlStr += " <input type='button' value='수정' class='edit-comment-btn' data-commentSeq='" + comment.commentSeq + "'>";
		                            htmlStr += " <input type='button' value='삭제' class='delete-comment-btn' data-commentSeq='" + comment.commentSeq + "'>";
		                        }
		                        htmlStr += "</div>"; // .button-group
		                    }
		                    htmlStr += "</td></tr>";
		                    
		                    // 대댓글 조회
		                    if (comment.replies) {
		                        $(comment.replies).each(function(idx, reply) {
		                            htmlStr += "<tr class='reply-item'><td>";
		                            if (reply.status == 1) {
		                                htmlStr += "<span class='deleted-comment'>삭제된 댓글입니다.</span>";
		                            } else if (reply.secret == 1 && !Boolean(reply.canViewSecret)) {
		                                htmlStr += "<span class='secret-comment'>비밀글입니다.</span>";
		                            } else {
		                            	htmlStr += reply.createdAt + " | "; // 날짜 추가
		                                htmlStr += reply.nickname + " "; // 닉네임 추가
		                                htmlStr += "<div class='comment-content'>" + reply.content + "</div>"; // 내용
		                                
		                                htmlStr += "<div class='button-group'>";
		                                // 대댓글도 작성자만 수정 및 삭제 버튼 보이기
		                                if (reply.userSeq == userSeq) { // 로그인된 사용자 userSeq가 대댓글 작성자와 같을 경우
		                                    htmlStr += " <input type='button' value='수정' class='edit-reply-btn' data-replySeq='" + reply.commentSeq + "'>";
		                                    htmlStr += " <input type='button' value='삭제' class='delete-comment-btn' data-commentSeq='" + reply.commentSeq + "'>";
		                                }
		                                htmlStr += "</div>"; // .button-group
		                            }
		
		                            htmlStr += "</td></tr>";
		                        });
		                    }
		                });
		
		                htmlStr += "</table>";
		                $("#commentListDiv").html(htmlStr);
		            }
		        });
		    }
		
		    loadComments();
		
		    // 댓글 등록
		    $(document).on("click", "#commentInsertBtn", function() {
		        var content = $("#content").val().trim();
		        if (!content) return alert("댓글을 입력하세요.");
		        
		        var secret = $("#secret").prop("checked") ? 1 : 0; // 비밀글 여부 확인
		        $.post("${pageContext.request.contextPath}/post/detail_comment_insert", {
		            //postSeq: "${POSTDETAIL.postSeq}",
		            postSeq: 1,
		            userSeq: userSeq,
		            content: content,
		            parentSeq: null,
		            secret: secret
		        }, function() {
		            loadComments();
		            $("#content").val("");
		        });
		    });
		
		 	// 대댓글 입력 폼 출력
		    $(document).on("click", ".reply_show_btn", function() {
		        var commentSeq = $(this).attr("data-commentSeq");  
		        var replyForm = $("#reply-form-" + commentSeq);
		        console.log("현재 댓글의 commentSeq : ", commentSeq);
		        
		        if (replyForm.length === 0) {
		            $(this).closest("tr").after(
		                "<tr id='reply-form-" + commentSeq + "'>" +
		                "<td>" +
		                "<input type='text' class='reply-content' placeholder='답글 입력'>" +
		                "<div class='reply-options'>" +
		                "<label><input type='checkbox' name='reply-secret' id='reply-secret-" + commentSeq + "' value='1'> 비밀글</label>" +
		                "<input type='button' value='등록' class='reply-insert-btn' data-parentSeq='" + commentSeq + "'>" +
		                "</div>" +
		                "</td>" +
		                "</tr>"
		            );
		        } else {
		            replyForm.toggle();
		        }
		    });
		
		 	// 대댓글 등록(버튼 클릭)
		    $(document).on("click", ".reply-insert-btn", function() {
		        var parentSeq = $(this).attr("data-parentSeq");
		        console.log("대댓글의 parentSeq : ", parentSeq);
		        
		        // .reply-content와 .reply-secret을 정확하게 선택
		        var content = $(this).closest('tr').find(".reply-content").val().trim(); // 대댓글 내용
		        var secret = $(this).closest('tr').find("#reply-secret").prop("checked") ? 1 : 0; // 비밀글 여부
		        
		        if (!content) return alert("답글을 입력하세요.");
		        
		        $.post("${pageContext.request.contextPath}/post/detail_comment_insert", {
		            //postSeq: "${POSTDETAIL.postSeq}",
		            postSeq: 1,
		            userSeq: userSeq,
		            content: content,
		            parentSeq: parentSeq,
		            secret: secret
		        }, function() {
		            loadComments();
		        });
		    });
		
		 	// 댓글 수정 폼 출력
		    $(document).on("click", ".edit-comment-btn", function() {
		        var commentSeq = $(this).attr("data-commentSeq");
		        
		        // 댓글 내용만 추출
		        var commentContent = $(this).closest("tr").find(".comment-content").text().trim(); 
		
		        // 댓글 수정 폼 추가
		        var editForm = "<tr id='edit-form-" + commentSeq + "'>" +
		                        "<td colspan='2'>" +
		                        "<textarea id='edit-content-" + commentSeq + "'>" + commentContent + "</textarea>" +
		                        "<label><input type='checkbox' id='edit-secret-" + commentSeq + "'> 비밀댓글</label>" +
		                        "<input type='button' value='수정 확인' class='confirm-edit-btn' data-commentSeq='" + commentSeq + "'>" +
		                        "<input type='button' value='취소' class='cancel-edit-btn' data-commentSeq='" + commentSeq + "'>" +
		                        "</td></tr>";
		        
		        $(this).closest("tr").after(editForm); // 수정 폼 추가
		    });
		
		    // 댓글 수정 (수정확인 버튼)
		    $(document).on("click", ".confirm-edit-btn", function() {
		        var commentSeq = $(this).attr("data-commentSeq");
		        var newContent = $("#edit-content-" + commentSeq).val().trim();
		        var isSecret = $("#edit-secret-" + commentSeq).prop("checked") ? 1 : 0;
		        /* var userSeq = 1; // 실제 로그인된 사용자 ID로 바꿔야 함. */
		        
		        /* console.log("commentSeq:", commentSeq);
		        console.log("newContent:", newContent);
		        console.log("isSecret:", isSecret);
		        console.log("userSeq:", userSeq); */
		        
		        if (!confirm("댓글을 수정하시겠습니까?")) return;
				
		        $.post("${pageContext.request.contextPath}/post/update_comment", {
		        	//postSeq: "${POSTDETAIL.postSeq}",
		        	postSeq: 1,
		            commentSeq: commentSeq,
		            content: newContent,
		            secret: isSecret,
		            userSeq: userSeq // 실제 로그인된 사용자 ID로 바꿔야 함.
		        }, function(response) {
		            loadComments();  // 수정된 댓글 목록 새로고침
		        });
		    });
		
		    // 댓글 수정 취소
		    $(document).on("click", ".cancel-edit-btn", function() {
		        $("#edit-form-" + $(this).attr("data-commentSeq")).remove(); // 수정 폼 취소
		    });
			
		    
		 	// 대댓글 수정 폼 출력
		    $(document).on("click", ".edit-reply-btn", function() {
		        var replySeq = $(this).attr("data-replySeq"); // 수정할 대댓글 ID
		        var replyRow = $(this).closest("tr"); // 해당 대댓글의 <tr> 요소 가져오기
		        
		        // 대댓글 내용만 추출
		        var replyContent = replyRow.find(".comment-content").text().trim(); 
		
		        var editForm = "<tr id='edit-form-" + replySeq + "'>" +
		                        "<td colspan='2'>" +
		                        "<textarea id='edit-content-" + replySeq + "'>" + replyContent + "</textarea>" +
		                        "<label><input type='checkbox' id='edit-secret-" + replySeq + "'> 비밀 댓글</label>" +
		                        "<input type='button' value='수정 확인' class='confirm-edit-reply-btn' data-replySeq='" + replySeq + "'>" +
		                        "<input type='button' value='취소' class='cancel-edit-reply-btn' data-replySeq='" + replySeq + "'>" +
		                        "</td></tr>";
		
		        replyRow.after(editForm); // 현재 대댓글 아래에 수정 폼 삽입
		    });
			
		 	// 대댓글 수정 (수정확인 버튼)
		    $(document).on("click", ".confirm-edit-reply-btn", function() {
			    var replySeq = $(this).attr("data-replySeq"); // 수정할 대댓글 ID
			    var newContent = $("#edit-content-" + replySeq).val().trim(); // 사용자가 입력한 수정된 내용
			    var isSecret = $("#edit-secret-" + replySeq).prop("checked") ? 1 : 0; // 비밀 댓글 체크 여부 확인
			
			    if (!confirm("대댓글을 수정하시겠습니까?")) return; // 수정 확인 알림창
			
			    $.post("${pageContext.request.contextPath}/post/update_comment", {
			    	//postSeq: "${POSTDETAIL.postSeq}",
			    	postSeq: 1,
			        commentSeq: replySeq, // 수정할 대댓글 ID
			        content: newContent, // 수정된 내용
			        secret: isSecret, // 비밀 댓글 여부 (1: 비밀, 0: 공개)
			        userSeq: userSeq // 로그인한 사용자 ID (세션에서 가져와야 함)
			    }, function(response) {
			        loadComments(); // 댓글 목록 새로고침
			    });
			});
		 	
		 	// 대댓글 수정 취소
		    $(document).on("click", ".cancel-edit-reply-btn", function() {
		        $("#edit-form-" + $(this).attr("data-replySeq")).remove(); // 수정 폼 제거
		    });
		    
		    // 댓글(최상위댓글, 대댓글) 삭제
		    $(document).on("click", ".delete-comment-btn", function() {
		        var commentSeq = $(this).attr("data-commentSeq"); 
		        if (!confirm("정말 댓글을 삭제하시겠습니까?")) {
		            return;
		        }
		
		        $.post("${pageContext.request.contextPath}/post/delete_comment", { 
		        	commentSeq: commentSeq,
		        	userSeq: userSeq  // 하드코딩된 userSeq 값
		        })
		        .done(function(response) {
		            alert(response);
		            loadComments();  // 댓글 목록 새로고침
		        })
		        .fail(function() {
		            alert("댓글 삭제 중 오류 발생");
		        });
		    });
		  	//--------------------------- 댓글기능 끝 ---------------------------
		  	
		  	//--------------------------- 신고기능 시작 ---------------------------
		    // 대분류와 중분류 클릭 시 열고 닫기 처리
		    const toggles = document.querySelectorAll('.toggle');
		    toggles.forEach(toggle => {
		        toggle.addEventListener('click', function() {
		            const subList = this.nextElementSibling;
		            
		            // 대분류를 클릭한 경우
		            if (subList && subList.tagName === 'UL') {
		                const allSubCategories = document.querySelectorAll('.sub-category');
		                allSubCategories.forEach(sub => {
		                    if (sub !== subList) {
		                        sub.style.display = 'none'; // 다른 중분류 닫기
		                    }
		                });
		                subList.style.display = (subList.style.display === 'none' || subList.style.display === '') ? 'block' : 'none';
		            }
		            
		            // 중분류 클릭 시 설명 부분 열기
		            const detailList = this.nextElementSibling ? this.nextElementSibling.querySelectorAll('.detail-category') : [];
		            if (detailList.length > 0) {
		                detailList.forEach(detail => {
		                    detail.style.display = (detail.style.display === 'none' || detail.style.display === '') ? 'block' : 'none';
		                });
		            }
		
		            // 중복으로 열린 중분류 설명을 닫는 기능 추가
		            const allDetails = document.querySelectorAll('.detail-category');
		            allDetails.forEach(detail => {
		                if (!Array.from(detailList).includes(detail)) {
		                    detail.style.display = 'none'; // 해당 항목 제외하고 닫기
		                }
		            });
		        });
		    });
		
		    // 대분류와 중분류 선택 시 선택된 항목 표시
		    const selectedOptionDisplay = document.createElement('div');
		    selectedOptionDisplay.classList.add('selected-option');
		    document.getElementById('reportType').appendChild(selectedOptionDisplay);
		
		    document.querySelectorAll('.toggle').forEach(item => {
		        item.addEventListener('click', function() {
		            selectedOptionDisplay.textContent = '선택된 신고 유형: ' + this.textContent;
		        });
		    });
		
		    // 신고 모달 열기
		    $("#reportBtn").click(function() {
		        $("#reportModal").show();
		    });
		
		    // 신고 모달 닫기
		    $(".close").click(function() {
		        $("#reportModal").hide();
		        $("#reportReason").val(""); // 신고 사유 초기화
		        selectedOptionDisplay.textContent = ''; // 선택된 항목 초기화
		    });
		
		    // 신고 처리
		    $("#submitReportBtn").click(function() {
		        var reportType = selectedOptionDisplay.textContent.replace('선택된 신고 유형: ', '').trim();
		        var reportReason = $("#reportReason").val().trim();
		
		        if (!reportType) {
		            alert("신고 유형을 선택해주세요.");
		            return;
		        }
		
		        if (!confirm("정말 신고하시겠습니까?")) {
		            return;
		        }
		
		        $.post("${pageContext.request.contextPath}/post/report_post_submit", {
		            reportCategory: reportType, 			// 신고사유
		            reportReason: reportReason, 			// 신고상세
		            userSeq: userSeq, 							// 실제 로그인된 사용자 ID로 바꿔야 함.
		            //reportPost: "${POSTDETAIL.postSeq}", 	// 신고할 게시물번호
		            reportPost: 1,
		            reportUser: null						// 신고할 유저
		        }, function(response) {
		        	alert(response.message); // JSON에서 'message'를 직접 사용
		            $("#reportModal").hide();
		            $("#reportReason").val(""); // 신고 사유 초기화
		            selectedOptionDisplay.textContent = ''; // 선택된 항목 초기화
		            
		        }).fail(function(xhr) {
		            try {
		                var responseObj = JSON.parse(xhr.responseText); // 서버에서 JSON 응답 처리
		                alert(responseObj.message); // JSON 응답의 'message' 출력
		            } catch (e) {
		                alert("신고 처리 중 오류 발생");
		            }
		            
		            $("#reportModal").hide();
		            $("#reportReason").val(""); // 신고 사유 초기화
		            selectedOptionDisplay.textContent = ''; // 선택된 항목 초기화
		        });
		    });
			//--------------------------- 신고기능 끝 ---------------------------
		  	
		
		});
		</script>
		
</body>
</html>