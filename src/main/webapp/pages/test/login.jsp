<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
</head>
<body>
    <h2>로그인</h2>
    <form action="/post/test/login" method="get">
        <label for="id">아이디:</label>
        <input type="text" id="id" name="id" required><br><br>
        
        <label for="pw">비밀번호:</label>
        <input type="password" id="pw" name="pw" required><br><br>
        
        <input type="submit" value="로그인">
    </form>

</body>
</html>
