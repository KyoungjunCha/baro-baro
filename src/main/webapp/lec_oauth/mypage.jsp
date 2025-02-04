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

			<th>대여품 제목</th>
			<th>대여품 아이템스펙</th>
			<th>대여품 공지사항</th>
			<th>대여품 작성시간</th>
			<th>대여품 조회수</th>
			<th>대여품 이름</th>
			<th>대여품 카테고리</th>
			<th>대여품 코멘트</th>
			<th>대여품 이미지1</th>
			<th>대여시작일</th>
			<th>대여반납일</th>
		</tr>
	</thead>
	<tbody>
		
	</tbody>
</table>


<table id="favoriteTable">
	<thead>
		<tr>

			<th>대여품 제목</th>
			<th>대여품 아이템스펙</th>
			<th>대여품 공지사항</th>
			<th>대여품 작성시간</th>
			<th>대여품 조회수</th>
			<th>대여품 이름</th>
			<th>대여품 카테고리</th>
			<th>대여품 코멘트</th>
			<th>대여품 이미지1</th>
			<th>대여시작일</th>
			<th>대여반납일</th>
		</tr>
	</thead>
	<tbody>
		
	</tbody>
</table>



<a href = "/pages/post/my_rent_post.jsp">나의 대여 예약현황</a>

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
</script>
    
<script>    
function loadPosts() {
    // AJAX로 데이터를 가져옵니다
    $.ajax({
        url: '/myposts', // 서버에서 게시물 목록을 받아올 URL
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

/*                 <td>${'${post.postSeq}'}</td>
                <td>${'${post.userSeq}'}</td> */
                // 데이터 추가
                row.append(`
                    <td><a href = "/post/post/${'${post.postSeq}'}"> ${'${post.title}'}</a></td>
                    <td>${'${post.itemContent}'}</td>
                    <td>${'${post.rentContent}'}</td>
                    <td>${'${formattedDate}'}</td>
                    <td>${'${post.count}'}</td>
                    <td>${'${post.productName}'}</td>
                    <td>${'${post.categoryName}'}</td>
                    <td>${'${post.comment || "없음"}'}</td>  <!-- 댓글이 비어 있으면 '없음' 표시 -->
                    <td>${'${post.postImage || "없음"}'}</td> <!-- 이미지가 비어 있으면 '없음' 표시 -->
                    <td>${'${formattedRentAt.length ? formattedRentAt : "없음"}'}</td> <!-- 첫 번째 대여 시간 또는 '없음' 표시 -->
                    <td>${'${formattedReturnAt.length ? formattedReturnAt : "없음"}'}</td> <!-- 첫 번째 대여 시간 또는 '없음' 표시 -->
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


function loadFavorites() {
    // AJAX로 데이터를 가져옵니다
    $.ajax({
        url: '/myfavorite', // 서버에서 게시물 목록을 받아올 URL
        method: 'GET',  // GET 요청
        success: function(favorites) {
            console.log(favorites); // 받아온 게시물 로그 출력

            // 테이블의 tbody를 비우고 새롭게 데이터 추가
            const postTable = $('#favoriteTable tbody');
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

/*                 <td>${'${post.postSeq}'}</td>
                <td>${'${post.userSeq}'}</td> */
                // 데이터 추가
                row.append(`
                    <td><a href = "/post/post/${'${post.postSeq}'}"> ${'${post.title}'}</a></td>
                    <td>${'${favorite.itemContent}'}</td>
                    <td>${'${post.rentContent}'}</td>
                    <td>${'${formattedDate}'}</td>
                    <td>${'${post.count}'}</td>
                    <td>${'${post.productName}'}</td>
                    <td>${'${post.categoryName}'}</td>
                    <td>${'${post.comment || "없음"}'}</td>  <!-- 댓글이 비어 있으면 '없음' 표시 -->
                    <td>${'${post.postImage || "없음"}'}</td> <!-- 이미지가 비어 있으면 '없음' 표시 -->
                    <td>${'${formattedRentAt.length ? formattedRentAt : "없음"}'}</td> <!-- 첫 번째 대여 시간 또는 '없음' 표시 -->
                    <td>${'${formattedReturnAt.length ? formattedReturnAt : "없음"}'}</td> <!-- 첫 번째 대여 시간 또는 '없음' 표시 -->
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