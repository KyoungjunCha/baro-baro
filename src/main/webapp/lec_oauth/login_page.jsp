<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<p>세션 이메일: ${sessionScope['SESS_EMAIL']}</p>
<p>세션 닉네임: ${sessionScope['SESS_NICKNAME']}</p>
<p>세션 역할: ${sessionScope['SESS_ROLE']}</p>
<p>세션 상태: ${sessionScope['SESS_STATUS']}</p>
<p>프로필 닉네임: ${sessionScope['SESS_PROFILE_NICKNAME']}</p>
<p>액세스 토큰: ${sessionScope['SESS_ACCESS_TOKEN']}</p>
<p>리프레시 토큰: ${sessionScope['SESS_REFRESH_TOKEN']}</p>
<p>소셜 타입: ${sessionScope['SESS_PROVIDER']}</p>

<!--  <form action="/form_login_process" method="POST">
        <label for="userEmail">이메일:</label>
        <input type="text" id="userEmail" name="userEmail" required/><br/><br/>
        
        <label for="userPW">비밀번호:</label>
        <input type="password" id="userPW" name="userPW" required/><br/><br/>
        
        <button type="submit">로그인</button>
</form> -->


<h1>OAuth 로그인</h1><hr>
<a href="/login/GOOGLE">구글 로그인</a><br>
<a href="/login/KAKAO">카카오 로그인</a><br>
<a href="/login/NAVER">네이버 로그인</a><br>
<!-- <a href="/test_naver_loginForm">네이버 로그인</a><br> -->


</body>
</html>