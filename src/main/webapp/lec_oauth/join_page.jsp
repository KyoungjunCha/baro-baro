<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<!-- 세션 값 출력 -->
<p>세션 이메일: ${sessionScope['SESS_EMAIL']}</p>
<p>세션 닉네임: ${sessionScope['SESS_NICKNAME']}</p>
<p>세션 역할: ${sessionScope['SESS_ROLE']}</p>
<p>세션 상태: ${sessionScope['SESS_STATUS']}</p>
<p>프로필 닉네임: ${sessionScope['SESS_PROFILE_NICKNAME']}</p>
<p>액세스 토큰: ${sessionScope['SESS_ACCESS_TOKEN']}</p>
<p>리프레시 토큰: ${sessionScope['SESS_REFRESH_TOKEN']}</p>
<p>소셜 타입: ${sessionScope['SESS_PROVIDER']}</p>



<h1>추가 정보 기입</h1><hr>

<h2>회원가입</h2>
    <form action="/oauth_join_process" method="POST">
    	<h2>회원가입 추가정보 기입하기</h2>
        <label for="email">이메일:</label>
        <input type="text" id="userEmail" name="email" value="${sessionScope['SESS_EMAIL']}" required/><br/><br/>
        
<!--         <label for="nickname">닉네임:</label>
        <input type="text" id="nickname" name="nickname" required/><br/><br/> -->
        
        <label for="phone">전화번호:</label>
        <input type="text" id="phone" name="phone"/><br/><br/>
        
        <!-- 도로명 주소 입력 필드 -->
        <div class="form-group row" >
            <div class="col-sm-6 mb-3 mb-sm-0">
                <input type="text" class="form-control form-control-user" id="streetAdr" name="address" placeholder="도로명 주소" readonly style="width: 20%;">
            </div>
        </div>

        <!-- 주소 찾기 버튼 -->
        <div>
            <button type="button" onclick="searchAddress()">주소찾기</button>
        </div>
                
        <button type="submit">회원가입</button>
    </form>

    <!-- Daum 주소 검색 iframe -->
    <div id="addressWrap" style="width: 100%; height: 400px;"></div>

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

</body>
</html>
