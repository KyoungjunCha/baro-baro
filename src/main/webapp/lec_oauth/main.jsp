<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Main Page</title>
</head>
<body>

<h1>Welcome to the Main Page</h1>

<p>세션 이메일: ${sessionScope['SESS_EMAIL']}</p>
<p>세션 닉네임: ${sessionScope['SESS_NICKNAME']}</p>
<p>세션 역할: ${sessionScope['SESS_ROLE']}</p>
<p>세션 상태: ${sessionScope['SESS_STATUS']}</p>
<p>프로필 닉네임: ${sessionScope['SESS_PROFILE_NICKNAME']}</p>
<p>액세스 토큰: ${sessionScope['SESS_ACCESS_TOKEN']}</p>
<p>리프레시 토큰: ${sessionScope['SESS_REFRESH_TOKEN']}</p>
<p>소셜 타입: ${sessionScope['SESS_PROVIDER']}</p>
<p>유저 seq: ${sessionScope['SESS_USER_SEQ']}</p>


<!-- 로그인 여부에 따른 페이지 분기 -->
<c:choose>
    <c:when test="${empty sessionScope['SESS_EMAIL']}">
        <a href="/login_page">로그인</a> <!-- 로그인되지 않은 사용자는 로그인 페이지로 이동 -->
    </c:when>
    <c:otherwise>
        <a href="/mypage">마이페이지</a> <!-- 로그인된 사용자는 마이페이지로 이동 -->
        <form action="/form_logout_process" method="POST">
            <input type="submit" value="로그아웃">
        </form>
    </c:otherwise>
</c:choose>

</body>
</html>
