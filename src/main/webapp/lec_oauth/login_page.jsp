<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="/css/style.css" type="text/css">

    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        .login-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 30px;
            background: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            text-align: center;
        }

        .login-container h2 {
            font-size: 24px;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .login-container .login-options a {
            display: inline-block;
            margin: 10px;
        }

        .login-container .login-options img {
            width: 200px;
           	height: 50px;
            cursor: pointer;
        }

        .footer {
            text-align: center;
            margin-top: 50px;
        }

        .footer p {
            font-size: 16px;
            color: #333;
        }
    </style>
</head>

<body>
<jsp:include page="/pages/common/header_test_sh.jsp" />
    <div class="login-container">
        <h2>로그인</h2>

        <!-- 카카오와 네이버 로그인 버튼 -->
        <div class="login-options">
            <a href="/login/KAKAO">
                <img src="/resources/images/kakao_login_btn.png" alt="카카오 로그인"/>
            </a>
            <a href="/login/NAVER">
                <img src="/resources/images/naver_login_btn.png" alt="네이버 로그인"/>
            </a>
        </div>
    </div>

    <div class="footer">
        <p>카카오 또는 네이버 계정을 사용하여 로그인해주세요.</p>
    </div>

</body>
</html>
