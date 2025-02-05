<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<style>
	table {
	    width: 100%;
	    border-collapse: collapse;
	}
	
	th, td {
	    padding: 8px;
	    border: 1px solid #ddd;
	    text-align: left;
	}
</style>
<h1>My Page</h1><hr>

<p>세션 이메일: ${sessionScope['SESS_EMAIL']}</p>
<p>세션 닉네임: ${sessionScope['SESS_NICKNAME']}</p>
<p>세션 역할: ${sessionScope['SESS_ROLE']}</p>
<p>세션 상태: ${sessionScope['SESS_STATUS']}</p>
<p>프로필 닉네임: ${sessionScope['SESS_PROFILE_NICKNAME']}</p>
<p>액세스 토큰: ${sessionScope['SESS_ACCESS_TOKEN']}</p>
<p>리프레시 토큰: ${sessionScope['SESS_REFRESH_TOKEN']}</p>
<p>소셜 타입: ${sessionScope['SESS_PROVIDER']}</p>
<p>유저 seq : ${sessionScop['SESS_USER_SEQ']}

<img src="${sessionScope.SESS_PROFILE_IMAGE}" width=100 height=100><br>
닉네임 :  ${sessionScope.SESS_PROFILE_NICKNAME}  <br>
이메일 : ${sessionScope.SESS_EMAIL}
<br><br>

<form method="post" action="/form_logout_process">
	<input type="submit" value="로그아웃">
</form>	



<h2>예약 요청 상태 현황</h2>
<table id="postTable">
	<thead>
		<tr>
			<th>대여자 이름 (어차피 내 계정이긴함)</th>
			<th>대여품 제목</th>
			<th>대여품 카테고리</th>
			<th>대여품 가격</th>
			<th>대여시작일</th>
			<th>대여반납일</th>
			<th>예약상태</th>
		</tr>
	</thead>
	<tbody>
		
	</tbody>
</table>


<!-- 
예약을 요청 상태	(STATUS=1) = 예약 요청중           => 물품주인이 대여 요청을 수락 시, 예약이 확정됩니다! 📢
예약을 수락 상태	(STATUS=2) = 예약 확정됨           => [예약 취소 요청]🫥 버튼 활성화 (rent_at 3일전까지) , YYYY-MM-DD까지만 취소요청이 가능합니다! 😬
예약을 거절 상태	(STATUS=3) = 예약 거절됨	        => 물품주인이 대여 요청을 거절하였어요 😂
예약을 취소요청 상태	(STATUS=4) = 예약 취소 요청중     	=> 물품주인이 대여 취소요청을 수락 시, 취소가 확정됩니다! 📢
취소요청 수락 상태	(STATUS=5) = 예약 취소 요청 수락됨  	=> 물품주인이 대여 취소요청을 수락하였어요 👌
거래 완료 상태		(STATUS=6) = 거래 완료
예약취소 요청 거절	(STATUS=7) = 예약 취소 요청을 거절함  => 물품주인이 대여 취소요청을 거절하였습니다. 예약이 유지됩니다.
 -->

    
<script>    
$(document).ready(function(){
	loadPosts();	
})

	function loadPosts() {
	    // AJAX로 데이터를 가져옵니다
	    $.ajax({
	        url: '/myposts/reservation', // 서버에서 게시물 목록을 받아올 URL
	        method: 'GET',  // GET 요청
	        success: function(posts) {
	            console.log(posts); // 받아온 게시물 로그 출력
	
	            // 테이블의 tbody를 비우고 새롭게 데이터 추가
	            const postTable = $('#postTable tbody');
	            postTable.empty();
	
	            // 게시물 데이터를 테이블에 추가
	            posts.forEach(post => {
	            	const postDate = new Date(post.postAt);
	                const formattedDate = postDate.toLocaleString();  // 사용자 지역에 맞는 형식으로 변환

	                var rentAt = post.rentTimes[0].rent_at ? new Date(post.rentTimes[0].rent_at).toLocaleString() : '없음';
	                const formattedRentAt = rentAt.toLocaleString();
						
	                var returnAt = post.rentTimes[0].return_at ? new Date(post.rentTimes[0].return_at).toLocaleString() : '없음';
	                const formattedReturnAt = returnAt.toLocaleString();
	                
	                const row = $('<tr>');  // 새 행(<tr>) 생성
	
	                row.append(`
	                	<td>${sessionScope.SESS_PROFILE_NICKNAME}</td>
	                    <td>${'${post.title}'}</td>
	                    <td>${'${post.categoryName}'}</td>
	                    <td>${'${post.rentTimes[0].price}'}</td>
	                    <td>${'${formattedRentAt.length ? formattedRentAt : "없음"}'}</td> 
	                    <td>${'${formattedReturnAt.length ? formattedReturnAt : "없음"}'}</td>
	                    <td>${'${post.rentTimes[0].status}'}</td>
	                `);
	
	                // 행을 테이블에 추가
	                postTable.append(row);
	            });
	        },
	        error: function(error) {
	            console.error('Error loading posts:', error);
	        }
	    });
	}


</script>


</body>
</html>