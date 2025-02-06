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

<style>
table {
	width: 80%;
	margin: auto;
	border-collapse: collapse;
	text-align: left;
}

th, td {
	border-bottom: 1px solid #ddd;
	padding: 10px;
}

th {
	background-color: #f4f4f4;
}

table tr:hover {
	cursor: pointer;
	background-color: #f1f1f1; 
	transition: background-color 0.3s ease; 
}

.price {
	color: red;
	font-weight: bold;
}

.heart {
	cursor: pointer;
	color: red;
}

.heart:hover {
	transform: scale(1.2);
}

.image {
	width: 100px;
}
</style>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
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
<p>유저 시퀀스 : ${sessionScope['SESS_USER_SEQ']}</p>
<br><br><br>
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

<!-- <button id="mypostBtn" onClick="loadPosts()">
	내 글 정보 가져오기
</button> -->

<h3>나의 대여품 리스트</h3>
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


<br>

<a href = "/keyword/list/${sessionScope['SESS_USER_SEQ']}">나의 알림 및 키워드 설정 하러 가기</a>

<br>



<h3>즐겨찾기 목록</h3>
<table id="favoriteTable">
	<thead>
		<tr>
			<th>게시글이미지</th>
			<th>게시글번호 post_seq</th>
			<th>게시글 제목 title</th>
			<th>대여 장소 rent_location</th>
<!-- 		<th>대여자닉네임 user_seq 를 사용한 user_table nickname</th> -->
			<th>조회수 count post에 있음</th>
			<th>즐겨찾기토글</th>
		</tr>
	</thead>
	<tbody>
<%-- 		<c:forEach var="favorite" items="${favorites}">
				<c:forEach var="post" items="${favorite.postList}">
					<tr>
						<td></td>
						<td>favorite.postSeq</td>
						<td>
							<a href="/post/post/${post.postSeq}" style="text-decoration: none; color: inherit;">
								${post.title}
							</a>
						</td>
						<td>${post.rentLocation}</td>
						<td>${post.count}</td>
						<td><i class="heart bi bi-heart-fill"
							data-user-seq="${post.userSeq}" data-post-seq="${post.postSeq}"></i>
						</td>
					</tr>
				</c:forEach>
			</c:forEach> --%>
	</tbody>
</table>



<a href = "/pages/post/my_rent_post.jsp">나의 대여 예약현황</a>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
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
$(document).ready(function(){
	loadPosts();
	getPostImage();
//	loadFavorites(postImages);
})

function getPostImage() {
			$.ajax({
				url: '/mypostimage', // 서버에서 즐겨찾기 토글 처리
                type: 'GET',
                contentType: 'application/json',
                success: function(postImages) {
                    console.log("사진테스트 : " ,postImages); // 받아온 게시물 로그 출력
					loadFavorites(postImages);
                },
                error: function () {
                    alert('상품 사진 불러오기 실패');
                }
			});
		}

function loadPosts() {
    // AJAX로 데이터를 가져옵니다
    $.ajax({
        url: '/myposts', // 서버에서 게시물 목록을 받아올 URL
        method: 'GET',  // GET 요청
        success: function(posts) {
            console.log("게시글로그",posts); // 받아온 게시물 로그 출력

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

/* 이렇게 못쓰나봐 씨앙 */
/* function loadFavorites(){
	$.ajax({
		url:'/myfavorite',
		method: 'GET',
		success: function(favorites){
		
			favorites.forEach(favorite =>{
				const userSeq = favorite.userSeq;
				const postSeq = favorite.postSeq;
				const title	  = favorite.postList[0].title;
				const count   = favorite.postList[0].count;
				const rentLocation = favorite.postList[0].rentLocation;
				
				
			})
		
		}
	})
} */

function loadFavorites(postImages) {
    // AJAX로 데이터를 가져옵니다
    $.ajax({
        url: '/myfavorite', // 서버에서 게시물 목록을 받아올 URL
        method: 'GET',  // GET 요청
        success: function(favorites) {
            console.log("즐겨찾기 로그 : ",favorites); // 받아온 게시물 로그 출력

            
            
            // 테이블의 tbody를 비우고 새롭게 데이터 추가
            const postTable = $('#favoriteTable tbody');
            postTable.empty();

            // 게시물 데이터를 테이블에 추가
            favorites.forEach(favorite => {
               
		        const rentLocation = favorite.postList[0].rentLocation;
            	
                const row = $('<tr>');  // 새 행(<t>) 생성

				const userSeq = favorite.userSeq;
				
				const postSeq = favorite.postSeq;
				console.log(postSeq);
				
	        	const postImage = postImages.find(image => image.postSeq === postSeq);
				console.log("나와라 포스트 이미지 : ",postImage);
	            const imageUrl = postImage ? postImage.storagePath : '/img/logo.png'; // 이미지가 있으면 storagePath, 없으면 기본 이미지

				
                row.append(`
                   	<td><img src=${'${imageUrl}'} alt="이미지" class="image"/></td>
                	<td>${'${favorite.postSeq}'}</td>
           
                    <td><a href = "/post/post/${'${favorite.postSeq}'}"> ${'${favorite.postList[0].title}'}</a></td>
                    <td>${'${favorite.postList[0].rentLocation}'}</td>
                    <td>${'${favorite.postList[0].count}'}</td>
                    

                	
                	<td>
                		<i class="heart bi bi-heart-fill"
						data-user-seq=${'${favorite.userSeq}'} 
                		data-post-seq=${'${favorite.postSeq}'}>
						</i>
					</td>
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



//진아님 하트 토글 이거 쓰고싶어요
// 쓰게 해드렸습니다~
$(document).ready(function() {
	    $(document).on('click','.heart',function() {
	        const $icon = $(this);
	        const userSeq = $icon.data('user-seq');
	        console.log(userSeq);
	        const postSeq = $icon.data('post-seq');
	        console.log(postSeq);
	        // 하트를 클릭할 때마다 빨간 하트와 빈 하트를 토글
	        if ($icon.hasClass('bi-heart-fill')) {
	            // 즐겨찾기 해제
	            $.ajax({
	                url: '/favorite/toggle', // 서버에서 즐겨찾기 토글 처리
	                type: 'POST',
	                contentType: 'application/json',
	                data: JSON.stringify({
	                    userSeq: userSeq,
	                    postSeq: postSeq
	                }),
	                success: function(response) {
	                    if (response === 'deleted') {
	                        $icon.removeClass('bi-heart-fill').addClass('bi-heart');
	                    }
	                },
	                error: function () {
	                    alert('즐겨찾기 해제에 실패했습니다.');
	                }
	            });
	        } else {
	            // 즐겨찾기 추가
	            $.ajax({
	                url: '/favorite/toggle', // 서버에서 즐겨찾기 토글 처리
	                type: 'POST',
	                contentType: 'application/json',
	                data: JSON.stringify({
	                    userSeq: userSeq,
	                    postSeq: postSeq
	                }),
	                success: function(response) {
	                    if (response === 'added') {
	                        $icon.removeClass('bi-heart').addClass('bi-heart-fill');
	                    }
	                },
	                error: function () {
	                    alert('즐겨찾기 추가에 실패했습니다.');
	                }
	            });
	        }
	    });
	});
	

		
		
	
</script>



</body>
</html>