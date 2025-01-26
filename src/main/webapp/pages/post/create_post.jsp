<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=c60b5a80c355b99117a9426ef4296a8c&autoload=false"></script>
</head>
<body>
	
	<div id="create-post-container" style="display: flex; justify-content: center; align-items: center; height: 100vh;">
        <h2>게시글 작성3</h2>
        <form id="create-post-form" enctype="multipart/form-data">
            <table>
                <tr>
                    <td><label for="title">제목</label></td>
                    <td><input type="text" id="title" name="title" required></td>
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
                    <td><label for="rent_location">대여 위치(도로명 주소로 입력)</label></td>
                    <td><input type="text" id="rent_location" name="rent_location" required></td>
                </tr>
                <tr>
                    <td><label for="ufile">첨부파일</label></td>
                    <td><input type="file" id="ufile" name="ufile" multiple></td>
                </tr>
                <tr>
                	<td><div id="map" style="width:500px;height:400px;"></div></td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="게시글 작성"></td>
                </tr>
            </table>
        </form>
    </div>
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script>
		window.onload = function() {
	        // Kakao Maps API 로드가 완료된 후 실행
	        kakao.maps.load(function() {
	            var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	            var options = { //지도를 생성할 때 필요한 기본 옵션
	                center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표
	                level: 3 //지도의 레벨(확대, 축소 정도)
	            };
	
	            var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	        });
	    };
    </script>
</body>
</html>
