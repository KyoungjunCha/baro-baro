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
 /* 전체 레이아웃 */
.mypage-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem;
}

/* 유저 정보 카드 */
#mypage-userInfo {
    background: white;
    border-radius: 15px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    padding: 2rem;
    margin-bottom: 2rem;
}

#mypage-userInfo img {
    border-radius: 50%;
    border: 3px solid #12c1c0;
    padding: 3px;
}

#mypage-userInfo h3 {
    color: #333;
    margin-bottom: 1.5rem;
    font-weight: 600;
}

.provider-userInfo {
    display: flex;
    flex-direction: row;  /* 가로로 배치 */
    align-items: center;   /* 세로 중앙 정렬 */
    justify-content: flex-start; /* 가로 좌측 정렬 */
    width: 100%;  /* 부모 요소가 화면 너비를 차지하도록 설정 */
}

.provider-userInfo img {
    margin-right: 10px; /* 이미지와 텍스트 간의 간격을 설정 */
}


/* 회원정보 수정 폼 */
#mypage-change-userInfo {
    background: #f8f9fa;
    border-radius: 10px;
    padding: 1.5rem;
    margin-top: 1rem;
}

.form-group {
    margin-bottom: 1rem;
}

.form-group label {
    display: block;
    margin-bottom: 0.5rem;
    color: #495057;
}

.form-group input[type="text"] {
    width: 100%;
    padding: 0.75rem;
    border: 1px solid #ced4da;
    border-radius: 8px;
    margin-bottom: 1rem;
}

/* 네비게이션 링크 */
.nav-links {
    background: white;
    padding: 1rem;
    border-radius: 10px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
    margin-bottom: 2rem;
}

.nav-links a {
    padding: 0.75rem 1.5rem;
    border-radius: 8px;
    transition: all 0.3s ease;
    font-weight: 500;
}

.nav-links a:hover {
    background: #12c1c0;
    color: white;
}

/* 테이블 디자인 */
table {
    background: white;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    margin-bottom: 2rem;
    width: 100%;
}

th {
    background: #12c1c0;
    color: white;
    font-weight: 500;
    padding: 1rem;
}

td {
    padding: 1rem;
    vertical-align: middle;
}

table img.image {
    width: 80px;
    height: 80px;
    object-fit: cover;
    border-radius: 8px;
}

/* 섹션 스타일 - 수정된 부분 */
.section {
    display: none; /* 기본적으로 숨김 */
    background: white;
    border-radius: 15px;
    padding: 2rem;
    margin-bottom: 2rem;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.section.active {
    display: block; /* active 클래스가 있을 때만 보임 */
}

.section h3 {
    color: #333;
    margin-bottom: 1.5rem;
    padding-bottom: 0.5rem;
    border-bottom: 2px solid #12c1c0;
}

/* 버튼 스타일 */
button, input[type="submit"] {
    background: #12c1c0;
    color: white;
    border: none;
    padding: 0.75rem 1.5rem;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.3s ease;
}

button:hover, input[type="submit"]:hover {
    background: #0fa3a2;
}

/* 하트 아이콘 */
.heart {
    color: #ff4757;
    font-size: 1.25rem;
    transition: transform 0.3s ease;
}

.heart:hover {
    transform: scale(1.2);
}

/* 반응형 디자인 */
@media (max-width: 768px) {
    .nav-links {
        flex-direction: column;
        gap: 10px;
    }
    
    .table-responsive {
        overflow-x: auto;
        -webkit-overflow-scrolling: touch;
    }
    
    .mypage-container {
        padding: 1rem;
    }
}

</style>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous"/>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
</head>
<body>
<jsp:include page="/pages/common/header_test_sh.jsp" />

<div class="mypage-container">
    

<br><br><br>

<div class="card" id="mypage-userInfo">
	<h3>유저 정보</h3>
	<div id="provider-userInfo">
		<p>로그인 소셜 타입 : ${sessionScope['SESS_PROVIDER']}</p>
    	<c:choose>
    	 <c:when test="${sessionScope['SESS_PROVIDER'] == 'KAKAO'}">
             <img src="/resources/images/kakao_logo.svg" alt="Kakao Login" class="login-logo"/>
         </c:when>
         <c:otherwise>
             <img src="/resources/images/naver_logo.svg" alt="Naver Login" class="login-logo"/>
        </c:otherwise>
       </c:choose>
	</div>
	
	<img src="${sessionScope.SESS_PROFILE_IMAGE}" width=100 height=100/>
	닉네임 :  ${sessionScope.SESS_PROFILE_NICKNAME}  <br>
	이메일 : ${sessionScope.SESS_EMAIL}
	
	<div class="card" id="mypage-change-userInfo">
		<form method="post" action="/updateUserInfo">
		    <input type="hidden" name="email" value="${sessionScope['SESS_EMAIL']}">
		    <div class="form-group">
		    	<label for="phone">전화번호</label>
		    	<input type="text" name="phone" value="${user.phone}" required><br>
			</div>
			<div class="form-group">
			    <label for="address">주소</label> <button type="button" onclick="searchAddress()">주소찾기</button>
			    <input type="text" name="address" id = "streetAdr" value="${user.address}" required><br>
				<div id="addressWrap" style="width: 30%; height: 30%;"></div>
		    </div>
		    <input type="submit" value="회원정보 수정">    
		</form>
	</div>
</div>	








<div class="nav-links">
        <a onclick="showSection('keyword')">알림&키워드🔔</a>
        <a onclick="showSection('rental')">대여관리✅</a>
        <a onclick="showSection('favorites')">즐겨찾기</a>
        <a onclick="showSection('comments')">댓글</a>
        <a onclick="showSection('reviews')">리뷰</a>
</div>






<!-- 섹션들!!! -->
<div class="table-responsive">  
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
</div>





<div class="section" id="keyword">
     <h3>🔍키워드&알림🔔️</h3>
         <p>알림과 키워드 관련 설정을 할 수 있습니다.</p>

	     <div class="container">
	        <h2>관심 키워드 관리</h2>
	
	        <!-- 키워드 추가 폼 -->
	        <form id="addKeywordForm" class="add-form">
	    		<input type="hidden" name="userSeq" value="${sessionScope['SESS_USER_SEQ']}">
	   		 	<input type="text" name="contents" placeholder="키워드를 입력하세요" required>
	   			<button type="button" onclick="addKeyword()">추가</button> <!-- 버튼 클릭 시 addKeyword 함수 실행 -->
			</form>
	        
			<input type="hidden" name="userSeq" value=${sessionScope['SESS_USER_SEQ']}>
	        <!-- 관심 키워드 목록 -->
	        <div class="keyword-list">
	            <!-- javaScript 로 그림 -->
	        </div>
	    </div>
	<table id="notificationTable">
		<thead>
			<tr>
				<th>알림번호</th>
				<th>알림타입</th>
				<th>알림제목</th>
				<th>알림내용</th>
				<th>읽음여부</th>
				<th>알림생성시간</th>
				<th>링크</th>
				<th>유저넘버</th>
			</tr>
		</thead>
		<tbody>
			<!-- javaScript 로 그림 -->
		</tbody>
	</table>
</div>



<div class="section" id="rental">
    <h3>대여관리✅</h3>
	<jsp:include page="/lec_oauth/mypage_test_sh.jsp" />
	<br><br>
    <!-- <table id="postTable">
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
		javaScript 로 그림
	</tbody>
	</table> -->
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
	<!-- <table id="receivedUserReviewTable">
	    <thead>
	        <tr>
	            <th>리뷰 종류</th>
	            <th>리뷰 받은 횟수</th>
	        </tr>
	    </thead>
	    <tbody>
	        데이터가 여기에 추가됩니다
	    </tbody>
	</table> -->

	<h2>내가 작성한 리뷰</h2>
	<table id="receivedPostReviewTable">
	    <thead>
	        <tr>
	            <th>게시물 번호</th>
	            <th>제품명</th>
	            <th>작성일</th>
	            <th>별점</th>
	            <th>상세 리뷰</th>
	        </tr>
	    </thead>
	    <tbody>
	        <!-- 데이터가 여기에 추가됩니다 -->
	    </tbody>
	</table>

	<h2>답변 받은 리뷰</h2>
	<table id="sendedPostReviewTable">
	    <thead>
	        <tr>
	            <th>리뷰 작성일</th>
	            <th>게시물 번호</th>
	            <th>별점</th>
	            <th>상세 리뷰</th>
	        </tr>
	    </thead>
	    <tbody>
	        <!-- 데이터가 여기에 추가됩니다 -->
	    </tbody>
	</table>
</div>




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



//키워드 추가 버튼 클릭 시
function addKeyword(){

	// 폼 데이터 가져오기
	var formData = {
		contents: $("input[name='contents']").val(),
		userSeq: ${sessionScope['SESS_USER_SEQ']}
	};
	console.log("확인 폼데이터 들어간 값 : " + formData);

	// AJAX 요청
	$.ajax({
		url: '/keyword/add',  // 서버의 /keyword/add로 POST 요청
		type: 'POST',
		data: formData,  // 폼 데이터
		success: function(response) {
			// 키워드 추가 성공 시
			loadKeyword();
			console.log("추가된 키워드: ", response);
			// 성공적으로 추가된 키워드 목록에 새 키워드 추가
			$(".keyword-list").append(`
				<div class="keyword-item">
					<span>${'${response.contents}'}</span>
					<button class="delete-btn" data-seq=${'${response.keywordSeq}'}>X</button>
				</div>
			`);
			
			// 키워드 입력란 초기화
			$("input[name='contents']").val('');
			
		},
		error: function(xhr, status, error) {
			alert("키워드 추가 실패: " + error);
		}
	});
	
	
	
};




function loadKeyword() {
    $.ajax({
        url: "/keyword/list",
        type: "GET",
        success: function(list) {
            console.log("키워드 리스트 : ", list);
            const keywordListContainer = $(".keyword-list");
            keywordListContainer.empty(); // 기존 목록 비우기

            list.forEach(function (keyword) {
            	console.log(keyword.keywordSeq);
                keywordListContainer.append(`
                    <div class="keyword-item">
                        <span>${'${keyword.contents}'}</span>
                        <button class="delete-btn" data-seq="${'${keyword.keywordSeq}'}">X</button>
                    </div>
                `);
            });
            
            $(".delete-btn").click(function(e) {
                e.preventDefault();
                
                const keywordItem = $(this).closest('.keyword-item');
                const keywordSeq = $(this).data('seq');
                console.log("키워드 번호 : "+keywordSeq);
                const userSeq = ${sessionScope['SESS_USER_SEQ']};  // 서버에서 받아온 userSeq 사용

                $.ajax({
                    url: "/keyword/delete/" + keywordSeq,
                    type: "POST",
//                    contentType:"application/json",
//                    data: JSON.stringify{
					data:{
                        userSeq: userSeq
                    },
                    success: function(res) {
                    	console.log(res);
                    	if(res === "success"){
                        keywordItem.remove();  // 삭제 성공 시 해당 항목 삭제	
                       	loadKeyword();
                        console.log("동작중인거야아닌거야");
                    	}else{
                    		alert("삭제 실패 : 서버 오류");
                    	}
                    },
                    error: function(xhr, status, error) {
                        alert("삭제 실패: " + error);
                    }
                });
            });
            
        },
        error: function(xhr, status, error) {
            alert("리스트 요청 실패 : " + error);
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
};



 


function getPostImage() {
    $.ajax({
        url: '/mypostimage', // 서버에서 즐겨찾기 토글 처리
        type: 'GET',
        contentType: 'application/json',
        success: function(response) {
            postImages = response;
            console.log("사진테스트 : ", postImages); // 받아온 게시물 로그 출력
            loadFavorites(postImages);
            loadPosts(postImages);
        },
        error: function () {
            alert('상품 사진 불러오기 실패');
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
};

/* 여기부터 리뷰 */
let userSeq = ${sessionScope['SESS_USER_SEQ']}
console.log("도대체 왜 uesrSeq 가 1001? : " + userSeq);

function receivedUserReview(data) {
    const tableBody = document.getElementById('receivedUserReviewTable').querySelector('tbody');
    tableBody.innerHTML = "";  // 기존 테이블 내용 초기화

    if (data.length === 0) {
        const row = document.createElement('tr');
        row.innerHTML = `<td colspan="2">데이터 없음</td>`;
        tableBody.appendChild(row);
    } else {
        data.forEach((review) => {
            const row = document.createElement('tr');
            const userReviewCell = document.createElement('td');
            const receivedReviewCountCell = document.createElement('td');

            userReviewCell.textContent = review.userReview || '데이터 없음';
            receivedReviewCountCell.textContent = review.receivedReviewCount || '데이터 없음';

            row.appendChild(userReviewCell);
            row.appendChild(receivedReviewCountCell);

            tableBody.appendChild(row);
        });
    }
}

function receivedReview(data) {
    const tableBody = document.getElementById('receivedPostReviewTable').querySelector('tbody');
    tableBody.innerHTML = "";  // 기존 테이블 내용 초기화

    if (data.length === 0) {
        const row = document.createElement('tr');
        row.innerHTML = `<td colspan="5">데이터 없음</td>`;
        tableBody.appendChild(row);
    } else {
        data.forEach((review) => {
        	review.receivedPostReviews.forEach((postReview)=>{
            const row = document.createElement('tr');
            const postSeqCell = document.createElement('td');
            const productNameCell = document.createElement('td');
            const regDateCell = document.createElement('td');
            const ratingValueCell = document.createElement('td');
            const itemReviewCell = document.createElement('td');

            postSeqCell.textContent = postReview.postSeq || '데이터 없음';
            productNameCell.textContent = postReview.productName || '데이터 없음';
            regDateCell.textContent = postReview.regDate || '데이터 없음';
            ratingValueCell.textContent = postReview.ratingValue || '데이터 없음';
            itemReviewCell.textContent = postReview.itemReview || '데이터 없음';

            row.appendChild(postSeqCell);
            row.appendChild(productNameCell);
            row.appendChild(regDateCell);
            row.appendChild(ratingValueCell);
            row.appendChild(itemReviewCell);

            tableBody.appendChild(row);
        	});
        });
    }
}

function sendedReview(data) {
	console.log("sendedReview : " + data);
	const tableBody = document.getElementById('sendedPostReviewTable').querySelector('tbody');
    tableBody.innerHTML = "";  // 기존 테이블 내용 초기화

    if (data.length === 0) {
        const row = document.createElement('tr');
        row.innerHTML = `<td colspan="4">데이터 없음</td>`;
        tableBody.appendChild(row);
    } else {
        data.forEach((review) => {
			console.log("my sendedReview review : " + JSON.stringify(review,null,2));
			review.sendedPostReviews.forEach((postReview)=>{
        	const row = document.createElement('tr');
            const regDateCell = document.createElement('td');
            const postSeqCell = document.createElement('td');
            const ratingValueCell = document.createElement('td');
            const itemReviewCell = document.createElement('td');

            regDateCell.textContent = postReview.regDate || '데이터 없음';
            postSeqCell.textContent = postReview.postSeq || '데이터 없음';
            ratingValueCell.textContent = postReview.ratingValue || '데이터 없음';
            itemReviewCell.textContent = postReview.itemReview || '데이터 없음';

            row.appendChild(regDateCell);
            row.appendChild(postSeqCell);
            row.appendChild(ratingValueCell);
            row.appendChild(itemReviewCell);

            tableBody.appendChild(row);
			});
        });
    }
} 

/* function sendedReview(data) {
    const tableBody = document.getElementById('sendedPostReviewTable').querySelector('tbody');
    tableBody.innerHTML = "";  // 기존 테이블 내용 초기화
    if (data.length === 0) {
        const row = document.createElement('tr');
        row.innerHTML = <td colspan="4">데이터 없음</td>;
        tableBody.appendChild(row);
    } else {
        //review 를 뽑아 보자 콘솔로
    	data.forEach((review) => {
        review.forEach((reviewDetail) => {
            const row = document.createElement('tr');
                const regDateCell = document.createElement('td');
                const postSeqCell = document.createElement('td');
                const ratingValueCell = document.createElement('td');
                const itemReviewCell = document.createElement('td');

                regDateCell.textContent = reviewDetail.regDate  '데이터 없음';
                postSeqCell.textContent = reviewDetail.postSeq  '데이터 없음';
                ratingValueCell.textContent = reviewDetail.ratingValue  '데이터 없음';
                itemReviewCell.textContent = reviewDetail.itemReview  '데이터 없음';

                row.appendChild(regDateCell);
                row.appendChild(postSeqCell);
                row.appendChild(ratingValueCell);
                row.appendChild(itemReviewCell);

                tableBody.appendChild(row);

        })

        });
    }
} */



function loadReceivedUserReviews(userSeq) {
	//const userSeq = ${sessionScope['SESS_USER_SEQ']}
	console.log("얼마인지 : " + userSeq);
	$.ajax({
        url: '/sendedPostReviews',
        type: 'GET',
        data: { userSeq: userSeq },
        success: function(data) {
            console.log("받은 유저 리뷰 데이터: ", data);
            receivedUserReview(data);
        },
        error: function(xhr, status, error) {
            console.error('받은 유저 리뷰 불러오기 실패:', error);
        }
    });
}
function loadReceivedPostReviews(userSeq) {
	//const userSeq = ${sessionScope['SESS_USER_SEQ']}
console.log("얼마인지 : " + userSeq);
	$.ajax({
        url: '/sendedPostReviews',
        type: 'GET',
        data: { userSeq: userSeq },
        success: function(data) {
            console.log("받은 게시글 리뷰 데이터: ", data);
            receivedReview(data);
        },
        error: function(xhr, status, error) {
            console.error('받은 게시글 리뷰 불러오기 실패:', error);
        }
    });
}
function loadSendedPostReviews(userSeq) {
	//const userSeq = ${sessionScope['SESS_USER_SEQ']}
console.log("얼마인지 : " + userSeq);
	$.ajax({
        url: '/sendedPostReviews',
        type: 'GET',
        data: { userSeq: userSeq },
        success: function(data) {
            console.log("내가 작성한 게시글 리뷰 데이터: ", data);
            sendedReview(data);
        },
        error: function(xhr, status, error) {
            console.error('내가 작성한 게시글 리뷰 불러오기 실패:', error);
        }
    });
}
/* 리뷰 끝 */

//진아님 하트 토글 이거 쓰고싶어요
//쓰게 해드렸습니다~
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
};


function loadNotification(){
	$.ajax({
		url: '/notification-list', // 서버에서 즐겨찾기 토글 처리
		type: 'GET',
		contentType: 'application/json',
		success: function(notificationList) {
			console.log("알림테스트 : " ,notificationList); // 받아온 알림 로그 출력
			
			// 테이블의 tbody를 비우고 새롭게 데이터 추가
			const notificationTable = $('#notificationTable tbody');
			notificationTable.empty();
	
			// 게시물 데이터를 테이블에 추가
			notificationList.forEach(noti => {
				const notiDate = new Date(noti.createdAt);
				const formattednotiDate = notiDate.toLocaleString();  // 사용자 지역에 맞는 형식으로 변환
				
				let notificationType = noti.notificationType;
                // 알림 타입이 KEYWORD_MATCH일 때 "관심키워드"로 변경
                if (notificationType === 'KEYWORD_MATCH') {
                    notificationType = '관심키워드';
                }else if(notificationType ==='Rental Start'){
                	notificationType = '대여시작!';
                }else{
                	notificationType = '새로운 알림!';
                }
				
				const row = $('<tr>');
				row.append(`
					<td>${'${noti.notificationSeq}'}</td>
					<td>${'${notificationType}'}</td>
					<td>${'${noti.title}'}</td>
					<td>${'${noti.contents}'}</td>
					<td>${'${noti.isRead}'}</td>
					<td>${'${formattednotiDate}'}</td>
					<td>${'${noti.link}'}</td>
					<td>${'${noti.userSeq}'}</td>
				`);
				
				notificationTable.append(row);
			});
		
		},
			error: function (error) {
				alert('알림리스트 불러오기 실패');
			}
	});
};	


//각 섹션을 토글하여 보여주는 함수
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
      // getPostImage();  // 대여 관리 관련 데이터 로드
  } else if (sectionId === 'keyword') {
      loadKeyword();
      loadNotification();
  } else if (sectionId === 'comments') {
      loadComment();  // 댓글 섹션 로드
  } else if (sectionId === 'reviews') {
	  loadReceivedUserReviews(userSeq);
      loadReceivedPostReviews(userSeq);
      loadSendedPostReviews(userSeq); 
  }
};
	//기본적으로 'keyword' 섹션을 보이도록 설정
	document.addEventListener('DOMContentLoaded', function() {
	  showSection('keyword'); // 이벤트 리스너 내에서 showSection을 호출합니다.
	});
</script>


</body>
</html>