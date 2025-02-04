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
</head>
<body>
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

<form method="post" action="/updateUserInfo">
    <input type="hidden" name="email" value="${sessionScope['SESS_EMAIL']}">
    <label for="phone">전화번호:</label>
    <input type="text" name="phone" value="${user.phone}" required><br>

    <label for="address">주소:</label>
    <input type="text" name="address" id = "streetAdr" value="${user.address}" required><br>

	<div>
 	        <button type="button" onclick="searchAddress()">주소찾기</button>
    </div>

    <input type="submit" value="회원정보 수정">    
    
</form>
	

	<!-- Daum 주소 검색 iframe -->
	<div id="addressWrap" style="width: 100%; height: 50px;"></div>


<form method="post" action="/form_logout_process">
	<input type="submit" value="로그아웃">
</form>	



<table id="postTable">
	<thead>
		<tr>
			<th>대여품 번호</th>
			<th>대여품 제목</th>
			<th>대여품 아이템스펙</th>
			<th>대여품 내용</th>
			<th>대여품 작성시간</th>
			<th>대여품 조회수</th>
			<th>대여품 이름</th>
			<th>대여품 카테고리</th>
		</tr>
	</thead>
	<tbody>
	
	</tbody>
</table>




<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function searchAddress() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 선택한 도로명 주소를 'streetAdr' 필드에 입력
                document.getElementById('streetAdr').value = data.roadAddress;
            },
            embed: true, // 페이지 내에서 주소 검색
            width: '100%',
            height: '100%'
        }).embed(document.getElementById('addressWrap'));
    }
</script>

<script>
    // 주소 검색 함수
    function searchAddress() {
        new daum.Postcode({
            oncomplete: function(data) {
                document.getElementById('streetAdr').value = data.roadAddress;
            },
            embed: true, 
            width: '100%',
            height: '100%'
        }).embed(document.getElementById('addressWrap'));
    }

    // AJAX 요청으로 게시물 목록을 가져오는 함수
    function loadPosts() {
        fetch('/myposts') // 서버로 AJAX 요청 보내기
            .then(response => response.json())  // JSON 형식으로 응답 받기
            .then(posts => {
                const postTable = document.querySelector('#postTable tbody');
                postTable.innerHTML = ''; // 기존 게시물 목록 초기화

                // 가져온 게시물 목록을 테이블에 추가
                posts.forEach(post => {
                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td>${post.postSeq}</td>
                        <td>${post.title}</td>
                        <td>${post.itemContent}</td>
                        <td>${post.rentContent}</td>
                        <td>${post.postAt}</td>
                        <td>${post.count}</td>
                        <td>${post.productName}</td>
                        <td>${post.categorySeq}</td>
                    `;
                    postTable.appendChild(row);
                });
            })
            .catch(error => console.error('Error loading posts:', error));
    }

    // 페이지 로드 시 게시물 목록을 자동으로 가져오기
    window.onload = loadPosts;
</script>


</body>
</html>