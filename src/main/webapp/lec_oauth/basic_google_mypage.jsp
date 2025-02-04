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
<h1>My Page</h1><hr>

<img src="${KEY_USERINFO_PICTURE}" width=100 height=100><br>
이메일 :  ${KEY_USERINFO_EMAIL}  <br>
이름 : ${KEY_USERINFO_NAME}
<br><br>

<form method="post" action="/basic_google_logout">
	<input type="submit" value="로그아웃">
</form>	
    
</body>
</html>