<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 작성</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script> <!-- jQuery 라이브러리 로드 -->
    <style>
        /* 모달 창 스타일 */
        .modal {
            display: none; 
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
            padding-top: 60px;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        
        #additional-items {
            margin-left: 10px;
        }
    </style>
</head>

<body>    
    <div id="create-post-container" style="display: flex; justify-content: center; align-items: center; height: 100vh;">
        <form id="create-post-form" enctype="multipart/form-data" method="POST" action="/post/create">
            <table id="post-table">
                <caption>게시글 작성2</caption>
                <tr>
                    <td><label for="title">제목</label></td>
                    <td><input type="text" id="title" name="title" required></td>
                </tr>
                <tr>
                	<td><label for="category">카테고리</label></td>
          			<td>
		                <select id="category" name="category" required>
							<c:choose>
                <c:when test="${not empty categories}">
                    <c:forEach var="item" items="${categories}">
                        <option value="${item.categorySeq}">${item.categoryName}</option>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <option value="">카테고리가 없습니다.</option>
                </c:otherwise>
            </c:choose>
		                </select>
            		</td>
                </tr>
                <tr>
                    <td><label for="ufile">관련 이미지</label></td>
                    <td><input type="file" id="ufile" name="ufile" multiple></td>
                </tr>
                <tr>
                    <td><label for="product_name">제품명 상세 이름</label></td>
                    <td><input type="text" id="product_name" name="product_name" required></td>
                </tr>
                <tr>
                    <td><label for="item_content">상품에 관한 설명</label></td>
                    <td><input type="text" id="item_content" name="item_content" required></td>
                </tr>
                <tr>
                    <td><label for="rent_content">대여에 관한 설명</label></td>
                    <td><input type="text" id="rent_content" name="rent_content" required></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <button type="button" id="add-item-button">대여 일정 추가</button> 
                    </td>
                </tr>
                <tr id="additional-items">
                    <!-- 추가된 항목들이 들어갈 곳 -->
                </tr>
                <tr>
                    <td colspan="2">
                        <button type="submit">게시글 작성</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <!-- 모달 창 -->
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>대여 일정 입력</h2>
            <form id="modal-form">
                <label for="rent_at">대여일:</label>
                <input type="datetime-local" id="rent_at" name="rent_at" required>
                <br><br>
                <label for="return_at">반납일:</label>
                <input type="datetime-local" id="return_at" name="return_at" required>
                <br><br>
                <label for="price">대여비:</label>
                <input type="number" id="price" name="price" required>
                <br><br><br><br>
                <div id="map" style="width:500px;height:400px;"></div>
                <br><br>
                <button type="button" id="add-item-modal">대여 일자 추가</button>
            </form>
        </div>
    </div>

    <script type="text/javascript">
        // 동적으로 카카오 API 로드하기
        function loadKakaoMapAPI(callback) {
            var script = document.createElement('script');
            script.type = 'text/javascript';
            script.src = 'https://dapi.kakao.com/v2/maps/sdk.js?appkey=c60b5a80c355b99117a9426ef4296a8c&autoload=false&libraries=services,clusterer,drawing';
            script.onload = callback; // API가 로드되면 콜백 함수 실행
            document.head.appendChild(script); // 문서에 스크립트 추가
        }

        /* // 폼 제출 시 jQuery를 이용해 AJAX로 RESTful 요청 보내기
        $('#create-post-form').on('submit', function(event) {
            event.preventDefault(); // 기본 폼 제출 동작 막기

            var formData = new FormData(this); // 폼 데이터 수집
			console.log(formData);
            $.ajax({
                url: '/post/create', // API 엔드포인트 (서버에서 설정한 URL로 변경)
                type: 'POST',
                data: formData,
                processData: false, // 파일 전송을 위한 설정
                contentType: false, // 파일 전송을 위한 설정
                success: function(response) {
                    console.log('게시글 작성 성공', response);
                    alert('게시글 작성이 완료되었습니다!');
                },
                error: function(error) {
                    console.error('게시글 작성 실패', error);
                    alert('게시글 작성에 실패했습니다.');
                }
            });
        }); */

        // 모달 창 관련 처리
        var modal = document.getElementById("myModal");
        var btn = document.getElementById("add-item-button");
        var span = document.getElementsByClassName("close")[0];
        var marker1, marker2; 
        // 추가 버튼 클릭 시 모달 띄우기
        btn.onclick = function() {
            modal.style.display = "block";
            setTimeout(function() {
            	// 카카오 맵 API 로드 후 실행
                loadKakaoMapAPI(function() {
                    kakao.maps.load(function() {
                    	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                        mapOption = { 
                            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                            level: 3 // 지도의 확대 레벨
                        };

                    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

                    // 마커가 표시될 위치입니다 
                    var markerPosition1 = new kakao.maps.LatLng(33.450701, 126.570667); 
                    var imageSrc1 = 'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FB9H3a%2FbtsL1rLr5SF%2FwBDG93KWdsxiN8XRiaGYI0%2Fimg.png', // 마커이미지의 주소입니다    
                    imageSize1 = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
                    imageOption1 = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
                      
	                // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	                var markerImage1 = new kakao.maps.MarkerImage(imageSrc1, imageSize1, imageOption1);

                    // 마커를 생성합니다
                    // 대여장소
                    marker1 = new kakao.maps.Marker({
                        position: markerPosition1,
                        image: markerImage1
                    });
                    // 마커가 지도 위에 표시되도록 설정합니다
                    marker1.setMap(map);

                    // 마커가 드래그 가능하도록 설정합니다 
                    marker1.setDraggable(true); 
                    
                    

                    var markerPosition2 = new kakao.maps.LatLng(33.450701, 126.570667); 
                    var imageSrc2 = 'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2F2hoOn%2FbtsL1DY49q9%2F9bZVPkpSALn7VDKDkK5oC1%2Fimg.png', // 마커이미지의 주소입니다    
                    imageSize2 = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
                    imageOption2 = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
                      
	                // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	                var markerImage2 = new kakao.maps.MarkerImage(imageSrc2, imageSize2, imageOption2);
                    //반납장소
                    marker2 = new kakao.maps.Marker({
                        position: markerPosition2,
                        image: markerImage2
                    });
                    
                    marker2.setMap(map);

                    // 마커가 드래그 가능하도록 설정합니다 
                    marker2.setDraggable(true); 
                    });
                });
            }, 500); // 500ms (0.5초) 후에 relayout을 실행
        }

        // 모달 닫기
        span.onclick = function() {
            modal.style.display = "none";
        }

        // 모달 외부 클릭 시 닫기
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }

        // 항목 추가 처리
        $('#add-item-modal').click(function() {
	    var geocoder = new kakao.maps.services.Geocoder();
	    
	    var getLocation = function(marker) {
	        return new Promise(function(resolve, reject) {
	            geocoder.coord2RegionCode(marker.getPosition().La, marker.getPosition().Ma, function(result, status) {
	                if (status === kakao.maps.services.Status.OK) {
	                    resolve(result[0].address_name);
	                } else {
	                    reject("주소 변환 실패");
	                }
	            });
	        });
	    };
	
	    var rentAt = $('#rent_at').val();
	    var returnAt = $('#return_at').val();
	    var rentRotateX = marker1.getPosition().Ma;
	    var rentRotateY = marker1.getPosition().La;
	    var returnRotateX = marker2.getPosition().Ma;
	    var returnRotateY = marker2.getPosition().La;
	    var price = $('#price').val();
	
	    Promise.all([getLocation(marker1), getLocation(marker2)])
	        .then(function(locations) {
	            var rentLocation = locations[0];
	            var returnLocation = locations[1];
	
	            if (rentAt && returnAt && rentLocation && rentRotateX && rentRotateY && returnLocation && returnRotateX && returnRotateY) {
	                // 새로운 행 추가
	                var newRow = $('<tr>').append(
	                    $('<td>').text(rentAt),
	                    $('<td>').text(returnAt),
	                    $('<td>').text(price),
	                    $('<td>').text(rentLocation),
	                    $('<td>').text(rentRotateX),
	                    $('<td>').text(rentRotateY),
	                    $('<td>').text(returnLocation),
	                    $('<td>').text(returnRotateX),
	                    $('<td>').text(returnRotateY)
	                );
	                $('#additional-items').append(newRow);  // '대여 일정 추가' 버튼 오른쪽에 추가
	
	                // 추가된 대여 일정을 폼에 숨겨진 입력 필드로 추가
	                var rentAtInput = $('<input>').attr('type', 'hidden').attr('name', 'rent_at[]').val(rentAt);
	                var returnAtInput = $('<input>').attr('type', 'hidden').attr('name', 'return_at[]').val(returnAt);
	                var priceInput = $('<input>').attr('type', 'hidden').attr('name', 'price[]').val(price);
	                var rentLocationInput = $('<input>').attr('type', 'hidden').attr('name', 'rent_location[]').val(rentLocation);
	                var rentRotateXInput = $('<input>').attr('type', 'hidden').attr('name', 'rent_rotate_x[]').val(rentRotateX);
	                var rentRotateYInput = $('<input>').attr('type', 'hidden').attr('name', 'rent_rotate_y[]').val(rentRotateY);
	                var returnLocationInput = $('<input>').attr('type', 'hidden').attr('name', 'return_location[]').val(returnLocation);
	                var returnRotateXInput = $('<input>').attr('type', 'hidden').attr('name', 'return_rotate_x[]').val(returnRotateX);
	                var returnRotateYInput = $('<input>').attr('type', 'hidden').attr('name', 'return_rotate_y[]').val(returnRotateY);
	
	                // 폼에 숨겨진 필드 추가
	                $('#create-post-form').append(rentAtInput, returnAtInput, priceInput, rentLocationInput, rentRotateXInput, rentRotateYInput, returnLocationInput, returnRotateXInput, returnRotateYInput);
	
	                modal.style.display = "none"; // 모달 닫기
	            } else {
	                alert("모든 항목을 입력하세요.");
	            }
	        })
	        .catch(function(error) {
	            console.log(error);
	        });
	    
	    $('#create-post-form').on('submit', function(event) {
	        // 기본 폼 제출 동작을 막지 않음 (AJAX 통신을 막는 부분을 제거)
	        // event.preventDefault(); // 기본 폼 제출 동작을 막기 위해 주석 처리

	        // 각 입력 값 추출
	        var title = $('#title').val();
	        var category = $('#category').val();
	        var ufile = $('#ufile')[0].files; // 파일은 배열 형태로 받음
	        var productName = $('#product_name').val();
	        var itemContent = $('#item_content').val();
	        var rentContent = $('#rent_content').val();

	        // 대여 일정 항목 추출
	        var rentAt = [];
	        var returnAt = [];
	        var price = [];
	        var rentLocation = [];
	        var rentRotateX = [];
	        var rentRotateY = [];
	        var returnLocation = [];
	        var returnRotateX = [];
	        var returnRotateY = [];

	        // 추가된 대여 일정 항목들 추출
	        $('#additional-items tr').each(function() {
	            rentAt.push($(this).find('td').eq(0).text());
	            returnAt.push($(this).find('td').eq(1).text());
	            price.push($(this).find('td').eq(2).text());
	            rentLocation.push($(this).find('td').eq(3).text());
	            rentRotateX.push($(this).find('td').eq(4).text());
	            rentRotateY.push($(this).find('td').eq(5).text());
	            returnLocation.push($(this).find('td').eq(6).text());
	            returnRotateX.push($(this).find('td').eq(7).text());
	            returnRotateY.push($(this).find('td').eq(8).text());
	        });

	        // 전송할 데이터 객체 구성
	        var formData = new FormData();
	        formData.append('title', title);
	        formData.append('category', category);

	        // 여러 파일을 지원하려면 for문을 사용하여 추가 (선택된 파일이 여러 개라면)
	        for (var i = 0; i < ufile.length; i++) {
	            formData.append('ufile[]', ufile[i]); // 'ufile[]'로 배열 형태로 서버에 전달
	        }

	        formData.append('product_name', productName);
	        formData.append('item_content', itemContent);
	        formData.append('rent_content', rentContent);

	        // 대여 일정 정보 추가
	        rentAt.forEach(function(rent, index) {
	            formData.append('rent_at[]', rentAt[index]);
	            formData.append('return_at[]', returnAt[index]);
	            formData.append('price[]', price[index]);
	            formData.append('rent_location[]', rentLocation[index]);
	            formData.append('rent_rotate_x[]', rentRotateX[index]);
	            formData.append('rent_rotate_y[]', rentRotateY[index]);
	            formData.append('return_location[]', returnLocation[index]);
	            formData.append('return_rotate_x[]', returnRotateX[index]);
	            formData.append('return_rotate_y[]', returnRotateY[index]);
	        });

	        //$('#create-post-form')[0].submit();
	        $('#create-post-form').submit();
	    });
	    
	    
	    /* $('#create-post-form').on('submit', function(event) {
	        //event.preventDefault(); // 기본 폼 제출 동작 막기

	        // 각 입력 값 추출
	        var title = $('#title').val();
	        var category = $('#category').val();
	        var ufile = $('#ufile')[0].files; // 파일은 배열 형태로 받음
	        var productName = $('#product_name').val();
	        var itemContent = $('#item_content').val();
	        var rentContent = $('#rent_content').val();

	        // 대여 일정 항목 추출
	        var rentAt = [];
	        var returnAt = [];
	        var price = [];
	        var rentLocation = [];
	        var rentRotateX = [];
	        var rentRotateY = [];
	        var returnLocation = [];
	        var returnRotateX = [];
	        var returnRotateY = [];

	        // 추가된 대여 일정 항목들 추출
	        $('#additional-items tr').each(function() {
	            rentAt.push($(this).find('td').eq(0).text());
	            returnAt.push($(this).find('td').eq(1).text());
	            price.push($(this).find('td').eq(2).text());
	            rentLocation.push($(this).find('td').eq(3).text());
	            rentRotateX.push($(this).find('td').eq(4).text());
	            rentRotateY.push($(this).find('td').eq(5).text());
	            returnLocation.push($(this).find('td').eq(6).text());
	            returnRotateX.push($(this).find('td').eq(7).text());
	            returnRotateY.push($(this).find('td').eq(8).text());
	        });

	        // 전송할 데이터 객체 구성
	        var formData = new FormData();
	        formData.append('title', title);
	        formData.append('category', category);
	        //for (var i = 0; i < ufile.length; i++) {
	        //    formData.append('ufile[]', ufile[i]); // 'ufile[]'로 배열 형태로 서버에 전달
	        //}
	        formData.append('ufile[]', ufile[0]);
	        formData.append('product_name', productName);
	        formData.append('item_content', itemContent);
	        formData.append('rent_content', rentContent);

	        // 대여 일정 정보 추가
	        rentAt.forEach(function(rent, index) {
	            formData.append('rent_at[]', rentAt[index]);
	            formData.append('return_at[]', returnAt[index]);
	            formData.append('price[]', price[index]);
	            formData.append('rent_location[]', rentLocation[index]);
	            formData.append('rent_rotate_x[]', rentRotateX[index]);
	            formData.append('rent_rotate_y[]', rentRotateY[index]);
	            formData.append('return_location[]', returnLocation[index]);
	            formData.append('return_rotate_x[]', returnRotateX[index]);
	            formData.append('return_rotate_y[]', returnRotateY[index]);
	        });

	        // AJAX로 전송
	        $.ajax({
	            url: '/post/create', // 서버의 요청 URL
	            type: 'POST',
	            data: formData,
	            processData: false, // 데이터 처리 방식을 자동으로 설정하지 않음
	            contentType: false, // 파일 업로드를 위해 설정
	            success: function(response) {
	                console.log('게시글 작성 성공', response);
	                alert('게시글 작성이 완료되었습니다!');
	            },
	            error: function(error) {
	                console.error('게시글 작성 실패', error);
	                alert('게시글 작성에 실패했습니다.');
	            }
	        });
	    }); */
	});
   </script>
</body>
</html>