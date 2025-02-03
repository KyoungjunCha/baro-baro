<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>실시간 알림</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
/* 알림을 오른쪽 상단에 고정 */
#notification-container {
	position: fixed;
	top: 20px;
	right: 20px;
	width: 300px;
	z-index: 9999;
}

.notification {
	background-color: #f8d7da;
	border: 1px solid #f5c6cb;
	color: #721c24;
	padding: 10px;
	margin: 5px 0;
	border-radius: 5px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	animation: fadeIn 0.5s ease-in-out;
}

.notification a {
	color: #0056b3;
	text-decoration: none;
}

.notification .close-btn {
	background: none;
	border: none;
	font-size: 16px;
	cursor: pointer;
}

@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(-20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

</style>
</head>
<body>
	<h1>SSE Notifications</h1>
	<!-- 알림 표시를 위한 컨테이너 -->
	<div id="notification-container"></div>

	<script>
		// 테스트용 사용자 시퀀스 값, 실제로는 로그인 사용자에 맞게 동적으로 설정해야 함
		const userSeq = 1;

		 // SSE 연결 설정
		const eventSource = new EventSource(
				"http://localhost:8081/notification/subscribe/" + userSeq);

		// SSE 연결이 열릴 때
		eventSource.onopen = function() {
			console.log("SSE connection opened.");
		};
		
		// SSE 연결에 오류가 있을 때
		eventSource.onerror = function() {
			console.error("SSE connection error.", event);
			
			// 연결이 닫혔을 경우 다시 연결 시도
		    if (event.target.readyState === EventSource.CLOSED) {
		        console.log("🔄 SSE 연결 재시도...");
		        setTimeout(() => {
		            eventSource = new EventSource("http://localhost:8081/notification/subscribe/" + userSeq);
		        }, 5000);
		    }
		};

		// 알림이 오면 오른쪽 상단에 표시
		eventSource.addEventListener('notification', function(event) {
	    console.log("알림 데이터: ", event.data);
	    try {
	        const notification = JSON.parse(event.data);
	        console.log("알림 객체:", notification);
	        // alert("알림: " + notification.title + " - " + notification.contents);
	        
	        console.log("알림 텍스트: " + notification.title + " - " + notification.contents);
	        
	     	// 알림 요소 만들기
	        const notificationElement = `
	            <div class="notification">
	                <span>\${notification.title}: \${notification.contents}</span>
	                <button class="close-btn">X</button>
	            </div>
	        `;
	        
	        // 알림을 컨테이너에 추가
	        $('#notification-container').append(notificationElement);
	        
	        // 알림 닫기 버튼 클릭 시 해당 알림을 제거
	        $('.notification .close-btn').click(function() {
	            $(this).parent().remove();
	        });
	
	        // 일정 시간이 지나면 알림을 자동으로 닫기 (5초)
	        setTimeout(() => {
	            $('.notification').first().remove();
	        }, 5000);
	    } catch (error) {
	        console.error("알림 처리 중 오류 발생:", error);
	    }
	});



		
	</script>
</body>
</html>
