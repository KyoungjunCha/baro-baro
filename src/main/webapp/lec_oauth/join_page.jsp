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
    <title>회원가입</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet" />
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
        crossorigin="anonymous"/>
    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 0;
        }

        .join-container {
            max-width: 600px;
            margin: 40px auto;
            padding: 40px;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h3 {
            font-size: 24px;
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }

        label {
            font-size: 16px;
            color: #495057;
            margin-bottom: 8px;
        }

        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            font-size: 16px;
            border: 1px solid #ced4da;
            border-radius: 8px;
            box-sizing: border-box;
        }

        button {
            background-color: #12c1c0;
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
        }

        button:hover {
            background-color: #0fa3a2;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .address-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        #streetAdr {
            width: 80%;
            padding: 12px;
            font-size: 16px;
            border: 1px solid #ced4da;
            border-radius: 8px;
            height: 40px;  /* 입력 필드의 높이 지정 */
        }

        button[type="button"] {
            background-color: #f2f2f2;
            color: #495057;
            border: 1px solid #ced4da;
            padding: 12px 15px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            height: 40px;  /* 버튼의 높이 지정 */
        }

        button[type="button"]:hover {
            background-color: #e0e0e0;
        }

        #addressWrap {
            width: 100%;
            height: 300px;
            margin-top: 10px;
        }

        /* 반응형 디자인: 작은 화면에서 더 나은 레이아웃 */
        @media (max-width: 768px) {
            .join-container {
                padding: 20px;
                max-width: 100%;
            }

            input[type="text"], input[type="email"], input[type="password"], button {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/pages/common/header_test_sh.jsp" />

<div class="join-container">
    <h3>추가적인 정보를 입력해 주세요.</h3>
    <form action="/oauth_join_process" method="POST">
        <div class="form-group">
            <label for="email">이메일:</label>
            <input type="text" id="userEmail" name="email" value="${sessionScope['SESS_EMAIL']}" required/>
        </div>

        <!-- 전화번호 입력 -->
        <div class="form-group">
            <label for="phone">전화번호:</label>
            <input type="text" id="phone" name="phone"/>
        </div>

        <!-- 도로명 주소 입력 필드 -->
        <div class="form-group address-container">
            <input type="text" class="form-control" id="streetAdr" name="address" placeholder="도로명 주소" readonly />
            <button type="button" style="width:100px; height: 40px; margin-bottom:20px;" onclick="searchAddress()">주소찾기</button>
        </div>

        <div class="form-group">
            <button type="submit">회원가입</button>
        </div>
    </form>
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function searchAddress() {
        new daum.Postcode({
            oncomplete: function(data) {
                document.getElementById('streetAdr').value = data.roadAddress;
            },
            width: '100%',
            height: '100%'
        }).open();
    }
</script>
</body>
</html>
