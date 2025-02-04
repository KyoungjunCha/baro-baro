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

<button id="mypostBtn" onClick="loadPosts()">
	내 글 정보 가져오기
</button>

<table id="postTable">
	<thead>
		<tr>
			<th>대여품 번호</th>
			<th>유저 번호</th>
			<th>대여품 제목</th>
			<th>대여품 아이템스펙</th>
			<th>대여품 내용</th>
			<th>대여품 작성시간</th>
			<th>대여품 조회수</th>
			<th>대여품 이름</th>
			<th>대여품 카테고리</th>
			<th>대여품 코멘트</th>
			<th>대여품 이미지1</th>
			<th>대여품 이미지2</th>
			<th>대여품 대여시간</th>
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
    
    
    function loadPosts() {
        fetch('/myposts') // 서버로 AJAX 요청 보내기
            .then(response => response.json())  // JSON 형식으로 응답 받기
            .then(posts => {
            	console.log("hear1: ",posts);
                const postTable = document.querySelector('#postTable tbody');
                console.log(postTable); // 제대로 선택되었는지 확인
                console.log("hear",posts);
                postTable.innerHTML = ''; // 기존 게시물 목록 초기화

                // 가져온 게시물 목록을 테이블에 추가
                posts.forEach(post => {
                	console.log(post);
                	const postDate = new Date(post.postAt);
                    const formattedDate = postDate.toLocaleString();  // 사용자 지역에 맞는 형식으로 변환
					
                   	console.log(post.title);
                   	console.log(formattedDate);
                   	
                   	
                   	
                    const row = document.createElement('td');
                    row.innerHTML = `
                    	<td>${post.postSeq}</td>
                    	<td>${post.title}</td>
                    	<td>${post.userSeq}</td>
                    	<td>${post.itemContent}</td>
                        <td>${post.rentContent}</td>
                        <td>${formattedDate}</td>
                        <td>${post.count}</td>
                        <td>${post.productName}</td>
                        <td>${post.categoryName}</td>
                    	<td>${post.comment}</td>
                    	<td>${post.postImage}</td>
                    	<td>${post.postImages}</td>
                    	<td>${post.rentTimes}</td>
                    `;
                    postTable.appendChild(row);
                });
            })
            .catch(error => console.error('Error loading posts:', error));
    }

</script>


</body>
</html>