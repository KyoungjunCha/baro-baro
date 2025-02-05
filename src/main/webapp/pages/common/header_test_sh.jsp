<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ashion Template">
    <meta name="keywords" content="Ashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Ashion | Template</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap"
    rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/css/header.css" type="text/css">
    <link rel="stylesheet" href="/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="/css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="/css/style.css" type="text/css">
    <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
	<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    
    <style>
        .search-container {
		    display: flex;
		    align-items: center;
		    background: white;
		    padding: 10px;
		    border-radius: 25px;
		    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
		    position: relative;

		}
        .search-type-button {
            background: #ddd;
            border: none;
            padding: 10px;
            border-radius: 10px;
            cursor: pointer;
            margin-right: 10px;
            position: relative;
        }
        .search-type-dropdown {
            display: none;
            position: absolute;
            top: 40px;
            left: 0;
            background: white;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            width: 120px;
        }
        .search-type-dropdown span {
            display: block;
            padding: 10px;
            cursor: pointer;
        }
        .search-type-dropdown span:hover {
            background: #007bff;
            color: white;
        }
		.search-input {
		    border: none;
		    outline: none;
		    padding: 10px;
		    /* width: 250px; */
		    width:100%
		    font-size: 16px;
		    border-radius: 20px;
		    margin-right: 40px; /* 버튼과 간격을 위한 여백 */
		}
		
		.search-button {
		    background: #12C1C0;
		    border: none;
		    color: white;
		    padding: 10px 15px;
		    border-radius: 20px;
		    cursor: pointer;
		    font-size: 16px;
		    position: absolute; /* 절대 위치 설정 */
		    right: 10px; /* 오른쪽 끝에 고정 */
		}
    </style>
</head>

<body>
    <!-- Header Section Begin -->
    <header class="header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xl-3 col-lg-2">
                    <div class="header__logo">
                        <a href="/index.html"><img src="/img/logo.png" alt=""></a>
                    </div>
                </div>
                <div class="col-xl-6 col-lg-7">
                    <nav class="header__menu">
						
					    <div class="search-container">
					        <form action="/post/posts" method="get">
					            <select name="searchType" class="search-type-button" aria-label="검색 유형 선택">
					                <option value="product">제품 및 장소 검색</option>
					                <option value="user">회원 닉네임 검색</option>
					            </select>
					            <input type="search" name="searchKeyword" class="search-input" placeholder="검색어를 입력하세요" value="${param.searchKeyword}">
					        	<input type="hidden" name="availableOnly" id="availableOnly" value="${availableOnly}">
					            <button class="search-button" type="submit">검색</button>
					        </form>
					    </div>
						
                    </nav>
                </div>
                <div class="col-lg-3">
                    <div class="header__right">
                        <div class="header__right__auth">
                            <a href="#">Login</a>
                            <a href="#">Register</a>
                        </div>
                        <ul class="header__right__widget">
                            <li><span class="icon_search search-switch"></span></li>
                            <li><a href="#"><span class="icon_heart_alt"></span>
                                <div class="tip">2</div>
                            </a></li>
                            <!-- 알림 -->
                            <li class="notification-container">
                            	<!-- 알림 아이콘 -->
                            	<a href="#" id="notification-bell">
                            		<i class="bi bi-bell"></i>
                                	<div class="tip" id="notification-count">0</div>
                            	</a>
                            	<!-- 알림 목록 -->
                            	<div id="notification-dropdown">
                            		<div class="notification-header">알림</div>
                            		<ul id="notification-list">
                            			<li class="notification unread">
							                <strong>알림 제목</strong>
							                <p>알림 내용</p>
							                <small>2025-02-03 15:30</small>
							            </li>
							            <!-- 예시로 읽지 않은 알림 하나 추가 -->
							            <li class="notification read">
							                <strong>읽은 알림 제목</strong>
							                <p>읽은 알림 내용</p>
							                <small>2025-02-02 10:15</small>
							            </li>
                            		</ul>
                            	</div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="canvas__open">
                <i class="fa fa-bars"></i>
            </div>
        </div>
    </header>
    <!-- Header Section End -->

    <!-- Js Plugins -->
    <script src="/js/jquery-3.3.1.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/jquery.magnific-popup.min.js"></script>
    <script src="/js/jquery-ui.min.js"></script>
    <script src="/js/mixitup.min.js"></script>
    <script src="/js/jquery.countdown.min.js"></script>
    <script src="/js/jquery.slicknav.js"></script>
    <script src="/js/owl.carousel.min.js"></script>
    <script src="/js/jquery.nicescroll.min.js"></script>
    <script src="/js/main.js"></script>
    <script>
	    $(document).ready(function () {
	    	// 알림 목록 가져오기
	        $.ajax({
	            url: '/notification/notification-list',
	            method: 'GET',
	            data: {userSeq: 1001},
	            success: function(data) {
	            	console.log("data: " , data);
	                const notificationList = $('#notification-list');
	                const notificationCount = $('#notification-count');
	                notificationList.empty();  // 기존 목록 초기화
	
	                let unreadCount = 0;
	                
	                $.each(data, function(index, notification) {
	                    const notificationElement = $('<li></li>').addClass('notification').attr('data-id', notification.notificationSeq);
	
	                    // 읽지 않은 알림에 파란 점 표시
	                    if (notification.isRead === 0) {
	                        notificationElement.addClass('unread');
	                        unreadCount++;
	                    } else {
	                        notificationElement.addClass('read');
	                    }
	                    
	                    const createdAt = new Date(notification.createdAt).toLocaleString();
	
	                    notificationElement.html(
	                    	    '<p>' + notification.contents + '</p>' +
	                    	    '<small>' + createdAt + '</small>'
	                    	);
	
	                    notificationList.append(notificationElement);
	                });
	
	                // 읽지 않은 알림 개수 업데이트
	                notificationCount.text(unreadCount);
	            },
	            error: function(xhr, status, error) {
	                console.error('알림 데이터를 가져오는 중 오류 발생:', error);
	            }
	        });
	    	
	    	// 알림 읽음 상태 처리
	    	
	    	
	    	$.ajax({
	    		 url: '/notification/mark-read/' + notificationSeq,
		            method: 'POST',
		            success: function(data) {
		            	
		            },
		            error: function(xhr, status, error) {
		                console.error('알림 읽음 처리 오류 발생:', error);
		            }
	    		
	    	});
	     
	        const userSeq = 1001; // 로그인된 사용자 ID (서버에서 동적으로 설정해야 함)
	
	        // SSE 연결
	        const eventSource = new EventSource("http://localhost:8081/notification/subscribe/" + userSeq);
	
	     	// SSE 연결에 오류가 있을 때
	    	eventSource.onerror = function(event) {
	    		console.error("SSE 연결 오류 발생", event);
	    		
	    		// 연결이 닫혔을 경우 다시 연결 시도
	    	    if (event.target.readyState === EventSource.CLOSED) {
	    	        console.log("SSE 연결 재시도...");
	    	        setTimeout(() => {
	    	            eventSource = new EventSource("http://localhost:8081/notification/subscribe/" + userSeq);
	    	        }, 5000);
	    	    }
	    	};
	        
	        // 알림 수신 시 이벤트 처리
	        eventSource.addEventListener('notification', function(event) {
	            const notification = JSON.parse(event.data);
	            console.log(notification);
	            
	            addNotification(notification);
	        });
	
	        // 알림 추가 함수
	        function addNotification(notification) {
	        	let keyword = notification.contents.split('-')[0].trim(); // 키워드 추출
	        	let boldContents = notification.contents.replace(keyword, "<strong>" + keyword + "</strong>");
	        	
	        	const createdAt = new Date(notification.createdAt).toLocaleString();
	        	
	        	const notificationItem = 
	        	    '<li onclick="markAsRead(\'' + notification.notificationSeq + '\', \'' + notification.link + '\')">' +
	        	        '<p>' + boldContents + '</p>' +
	        	        '<small>' + createdAt + '</small>' +
	        	    '</li>';

	            $("#notification-list").prepend(notificationItem);
	
	            // 알림 개수 업데이트
	            let count = parseInt($("#notification-count").text()) + 1;
	            $("#notification-count").text(count).show();
	        }
	
	        // 알림 읽음 처리 & 이동
	        window.markAsRead = function(id, link) {
	            // 서버에 읽음 처리 요청
	            $.post(`/notification/read/${id}`, function() {
	                window.location.href = link; // 페이지 이동
	            });
	        };
	
	        // 종 아이콘 클릭 시 알림 목록 토글
	        $("#notification-bell").click(function (e) {
	            e.preventDefault();
	            $("#notification-dropdown").toggle();
	            $("#notification-count").text("0").hide(); // 개수 초기화
	        });
	
	        // 드롭다운 외부 클릭 시 닫기
	        $(document).click(function (e) {
	            if (!$(e.target).closest(".notification-container").length) {
	                $("#notification-dropdown").hide();
	            }
	        });
	    });
    </script>
</body>

</html>