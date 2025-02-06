<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
    
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c60b5a80c355b99117a9426ef4296a8c&autoload=false&libraries=services,clusterer,drawing"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>바로바로 | Mypage</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet" />

<style>
        /* 링크들을 가로로 나열하기 위한 스타일 */
        .nav-links {
            display: flex;
            gap: 20px; /* 각 항목 간의 간격 */
        }

        .nav-links a {
            cursor: pointer;
            text-decoration: none;
            color: #007bff;
            font-size: 18px;
        }

        .nav-links a:hover {
            color: #0056b3;
        }

        /* 각 섹션을 숨기기 위한 스타일 */
        .section {
            display: none;
        }

        /* 활성화된 섹션만 표시 */
        .active {
            display: block;
        }

        /* 테이블 스타일 */
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
<jsp:include page="/pages/common/header_test_sh.jsp" />

<!-- 이부분 헤더에서 -->
<%-- <form method="post" action="/form_logout_process">
	<input type="submit" value="로그아웃">
</form>	 --%>

<!--  <a href = "/pages/post/my_rent_post.jsp">나의 대여 예약현황</a> -->

<br><br><br>

<div class="card" id="mypage-userInfo">
	<h3>유저 정보</h3>
	<p>로그인 소셜 타입 : ${sessionScope['SESS_PROVIDER']}</p>
	<img src="${sessionScope.SESS_PROFILE_IMAGE}" width=100 height=100/>
	닉네임 :  ${sessionScope.SESS_PROFILE_NICKNAME}  <br>
	이메일 : ${sessionScope.SESS_EMAIL}
	
	<div class="card" id="mypage-change-userInfo">
		<form method="post" action="/updateUserInfo">
		    <input type="hidden" name="email" value="${sessionScope['SESS_EMAIL']}">
		    <div class="form-group">
		    	<label for="phone">전화번호:</label>
		    	<input type="text" name="phone" value="${user.phone}" required><br>
			</div>
			<div class="form-group">
			    <label for="address">주소:</label> <button type="button" onclick="searchAddress()">주소찾기</button>
			    <input type="text" name="address" id = "streetAdr" value="${user.address}" required><br>
				<div id="addressWrap" style="width: 30%; height: 30%;"></div>
		    </div>
		    <input type="submit" value="회원정보 수정">    
		</form>
	</div>
</div>	





----------------------------------------나누기---------------------------------------------

<%-- <div class="nav-links">
	<div><a href = "/keyword/list/${sessionScope['SESS_USER_SEQ']}">알림&키워드🔔</a></div>
	<div><a href = "/lec_oauth/mypage_test_sh.jsp">대여관리✅</a></div>
	<div><a href = "/test">즐겨찾기</a><div>
	<div><a href = "/test">댓글</a></div>
	<div><a href = "/test">리뷰</a></div>
</div> --%>
<div class="nav-links">
        <a onclick="showSection('keyword')">알림&키워드🔔</a>
        <a onclick="showSection('rental')">대여관리✅</a>
        <a onclick="showSection('favorites')">즐겨찾기</a>
        <a onclick="showSection('comments')">댓글</a>
        <a onclick="showSection('reviews')">리뷰</a>
 </div>



<!-- <h3>나의 대여품 리스트</h3>
<table class="section" id="postTable">
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
</table> -->




<div class="section" id="favorites">
<h3>즐겨찾기 목록</h3>
	<table id="favoriteTable">
		<thead>
			<tr>
				<th>게시글이미지</th>
				<th>게시글번호</th>
				<th>10분당 가격</th>
				<th>게시글 제목</th>
				<th>대여 장소</th>
				<th>조회수</th>
				<th>즐겨찾기토글</th>
			</tr>
		</thead>
		<tbody>
			<!-- 즐겨찾기 목록 javascript 로딩 -->
		</tbody>
	</table>
</div>

<!-- 나머지 섹션들 -->
<div class="section" id="keyword">
    <h3>알림&키워드🔔</h3>
    <p>알림과 키워드 관련 설정을 할 수 있습니다.</p>
    <jsp:include page="/pages/notification/keyword2.jsp" />
</div>

<div class="section" id="rental">
    <h3>대여관리✅</h3>
    <a href="/lec_oauth/mypage_test_sh.jsp">대여세부보기</a>
	<jsp:include page="/lec_oauth/mypage_test_sh.jsp" />
	<br><br>
    <table id="postTable">
	<thead>
		<tr>
			<th>대여품</th>
			<th>공지사항</th>
			<th>대여품 작성시간</th>
			<th>대여품 조회수</th>
			<th>대여품 이름</th>
			<th>대여품 카테고리</th>
			<th>대여품 이미지1</th>
		</tr>
	</thead>
	<tbody>
		<!-- javaScript 로 그림 -->
	</tbody>
	</table>
</div>

<div class="section" id="comments">
    <h3>✏️댓글✏️</h3>
	<table id="commentTable">
	<thead>
		<tr>
			<th>댓글번호</th>
			<th>작성자</th>
			<th>비밀글여부</th>
			<th>댓글</th>
			<th>작성일</th>
		</tr>
	</thead>
	<tbody>
		<!-- javaScript 로 그림 -->
	</tbody>
	</table>
</div>

<div class="section" id="reviews">
     <h3>📝리뷰📝️</h3>
	<table id="reviewTable">
	<thead>
		<tr>
			<th>리뷰번호</th>
			<th>리뷰사진</th>
			<th>리뷰상품명</th>
			<th>리뷰자명</th>
			<th>리뷰날짜</th>
			<th>리뷰내용</th>
		</tr>
	</thead>
	<tbody>
		<!-- javaScript 로 그림 -->
	</tbody>
	</table>
</div>



<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous">
</script>
	
<script>
    // 주소 검색 함수
    function searchAddress() {
        new daum.Postcode({
            oncomplete: function(data) {
                document.getElementById('streetAdr').value = data.roadAddress;
            },
//            embed: true, 
            width: '100%',
            height: '100%'
        }).open();  //embed(document.getElementById('addressWrap'));
    }
</script>	
	
	
	
	
<script>
	// 각 섹션을 토글하여 보여주는 함수
	function showSection(sectionId) {
	    // 모든 섹션을 숨긴다
	    const sections = document.querySelectorAll('.section');
	    sections.forEach(section => section.classList.remove('active'));
	
	    // 클릭된 섹션만 보이도록
	    const activeSection = document.getElementById(sectionId);
	    activeSection.classList.add('active');
	
	    
	    // 각 섹션에 대한 처리
	    if (sectionId === 'favorites') {
	        loadFavorites();  // 즐겨찾기 목록 로드
	    } else if (sectionId === 'rental') {
	        getPostImage();  // 대여 관리 관련 데이터 로드
	    } else if (sectionId === 'keyword') {
	        // 알림&키워드 처리
	    } else if (sectionId === 'comments') {
	        loadComment();  // 댓글 섹션 로드
	    } else if (sectionId === 'reviews') {
	        loadReview();  // 리뷰 섹션 로드
	    }
	}
	
	 // 기본적으로 'favorites' 섹션을 보이도록 설정
	document.addEventListener('DOMContentLoaded', function() {
	    showSection('favorites');
	});
</script>	
	
	

    
<script>    
 /* $(document).ready(function(){
	loadPosts();
	getPostImage();
//	loadFavorites(postImages);
})  */
 
function getPostImage() {
			$.ajax({
				url: '/mypostimage', // 서버에서 즐겨찾기 토글 처리
                type: 'GET',
                contentType: 'application/json',
                success: function(response) {
                	postImages=response;
                    console.log("사진테스트 : " ,postImages); // 받아온 게시물 로그 출력
					loadFavorites(postImages);
                    loadPosts(postImages);
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
/*                 <td>${'${formattedRentAt.length ? formattedRentAt : "없음"}'}</td> <!-- 첫 번째 대여 시간 또는 '없음' 표시 -->
                <td>${'${formattedReturnAt.length ? formattedReturnAt : "없음"}'}</td>  <!-- 첫 번째 대여 시간 또는 '없음' 표시 --> 
                <td>${'${post.postImage || "없음"}'}</td>
               	<td><img src=${'${imageUrl}'} alt="이미지" class="image"/></td>*/
				
               	const userSeq = post.userSeq;
				const postSeq = post.postSeq;
                const postImage = postImages.find(image => image.postSeq === postSeq);
	            const imageUrl = postImage ? postImage.storagePath : '/img/logo.png'; // 이미지가 있으면 storagePath, 없으면 기본 이미지 
                
                
                const row = $('<tr>');  // 새 행(<tr>) 생성


                // 데이터 추가
                row.append(`
                    <td><a href = "/post/post/${'${post.postSeq}'}"> ${'${post.title}'}</a></td>
                    <td>${'${post.rentContent}'}</td>
                    <td>${'${formattedDate}'}</td>
                    <td>${'${post.count}'}</td>
                    <td>${'${post.productName}'}</td>
                    <td>${'${post.categoryName}'}</td>
                    <td><img src=${'${imageUrl}'} alt="이미지" class="image"/></td>
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
            console.log("즐겨찾기 로그 : ",favorites); // 받아온 게시물 로그 출력

            
            
            // 테이블의 tbody를 비우고 새롭게 데이터 추가
            const postTable = $('#favoriteTable tbody');
            postTable.empty();

            // 게시물 데이터를 테이블에 추가
            favorites.forEach(favorite => {
               
		       //const rentLocation = favorite.postList[0].rentLocation;
            	
                const row = $('<tr>');  // 새 행(<t>) 생성

				/* const userSeq = favorite.userSeq;
				console.log("favoriteUserSeq",userSeq);
				const postSeq = favorite.postSeq;
				console.log("favoritePostSeq",postSeq);
				
	        	const postImage = postImages.find(image => image.postSeq === postSeq);
	            const imageUrl = postImage ? postImage.storagePath : '/img/logo.png'; // 이미지가 있으면 storagePath, 없으면 기본 이미지 */
				console.log("이렇게 꺼내 쓰면 되나 ",favorite.postSeq);
				console.log("이렇게 꺼내 쓰면 되나2 ",favorite.postImages[0].storagePath);
	            
				
                row.append(`
                   	<td><img src=${'${favorite.postImages[0].storagePath}'} alt="이미지" class="image"/></td>
                	<td>${'${favorite.postSeq}'}</td>
          			<td>${'${favorite.pricePerTenMinute}'},000원</td>
                    <td><a href = "/post/post/${'${favorite.postSeq}'}"> ${'${favorite.title}'}</a></td>
                    <td>${'${favorite.rentTimes[0].rentLocation}'}</td>
                    <td>${'${favorite.count}'}</td>
                    

                	// 하트 클릭시에 추가 삭제
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


//댓글 그리기
function loadComment() {
    // AJAX로 데이터를 가져옵니다
    $.ajax({
        url: '/mycomment', // 서버에서 게시물 목록을 받아올 URL
        method: 'GET',  // GET 요청
        success: function(comments) {
            console.log("댓글 로그 : ",comments); // 받아온 게시물 로그 출력

            
            
            // 테이블의 tbody를 비우고 새롭게 데이터 추가
            const commentTable = $('#commentTable tbody');
            commentTable.empty();

            // 게시물 데이터를 테이블에 추가
            comments.forEach(comment => {
               
		       //const rentLocation = favorite.postList[0].rentLocation;
            	
                const row = $('<tr>');  // 새 행(<t>) 생성

/* 				const userSeq = comment.userSeq;
				const postSeq = comment.postSeq; */
				//comment 체크박스 넣어서 체크시에 status 0 으로 만들어서 삭제 시키는거 만들어야함
				
                row.append(`

                	<td>${'${comment.commentSeq}'}</td>
                    <td><a href = "/post/post/${'${comment.postSeq}'}"> ${'${comment.title}'}</a></td>
                    <td>${'${comment.secret}'}</td>
                    <td>${'${comment.content}'}</td>
                    <td>${'${comment.createAt}'}</td>
                   	
                `);

                // 행을 테이블에 추가
                commentTable.append(row);
            });
        },
        error: function(error) {
            console.error('Error loading posts:', error);
        }
    });
}
    
    
function loadReview() {
    // AJAX로 데이터를 가져옵니다
    $.ajax({
        url: '/myReview', // 서버에서 게시물 목록을 받아올 URL
        method: 'GET',  // GET 요청
        success: function(reviews) {
            console.log("즐겨찾기 로그 : ",reviews); 
            
            
            // 테이블의 tbody를 비우고 새롭게 데이터 추가
            const reviewTable = $('#reviewTable tbody');
            reviewTable.empty();

            // 게시물 데이터를 테이블에 추가
            reviews.forEach(review => {
               
		       //const rentLocation = favorite.postList[0].rentLocation;
            	
                const row = $('<tr>');  // 새 행(<t>) 생성

				/* const userSeq = favorite.userSeq;
				console.log("favoriteUserSeq",userSeq);
				const postSeq = favorite.postSeq;
				console.log("favoritePostSeq",postSeq);
				
	        	const postImage = postImages.find(image => image.postSeq === postSeq);
	            const imageUrl = postImage ? postImage.storagePath : '/img/logo.png'; // 이미지가 있으면 storagePath, 없으면 기본 이미지 */
				console.log("이렇게 꺼내 쓰면 되나 ",review.postSeq);
				console.log("이렇게 꺼내 쓰면 되나2 ",review.postImages[0].storagePath);
	            
				
                row.append(`
                   	<td><img src=${'${review.postImages[0].storagePath}'} alt="이미지" class="image"/></td>
                	<td>${'${review.postSeq}'}</td>
          			<td>${'${review.pricePerTenMinute}'},000원</td>
                    <td><a href = "/post/post/${'${review.postSeq}'}"> ${'${review.title}'}</a></td>
                    <td>${'${review.rentTimes[0].rentLocation}'}</td>
                    <td>${'${review.count}'}</td>
                    

                	// 하트 클릭시에 추가 삭제
                	<td>
                		<i class="heart bi bi-heart-fill"
						data-user-seq=${'${review.userSeq}'} 
                		data-post-seq=${'${review.postSeq}'}>
						</i>
					</td>
                `);

                // 행을 테이블에 추가
                reviewTable.append(row);
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
	                url: '/myfavorite/toggle', // 서버에서 즐겨찾기 토글 처리
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
	                url: '/myfavorite/toggle', // 서버에서 즐겨찾기 토글 처리
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