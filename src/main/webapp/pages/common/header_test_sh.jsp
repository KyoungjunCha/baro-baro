<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ashion Template">
    <meta name="keywords" content="Ashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Ashion | Template</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap"
    rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="/css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="/css/style.css" type="text/css">
    
    <style>
        .search-container {
		    display: flex;
		    align-items: center;
		    background: white;
		    padding: 10px;
		    border-radius: 25px;
		    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
		    position: relative;

		}
        .search-type-button {
            background: #ddd;
            border: none;
            padding: 10px;
            border-radius: 10px;
            cursor: pointer;
            margin-right: 10px;
            position: relative;
        }
        .search-type-dropdown {
            display: none;
            position: absolute;
            top: 40px;
            left: 0;
            background: white;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            width: 120px;
        }
        .search-type-dropdown span {
            display: block;
            padding: 10px;
            cursor: pointer;
        }
        .search-type-dropdown span:hover {
            background: #007bff;
            color: white;
        }
		.search-input {
		    border: none;
		    outline: none;
		    padding: 10px;
		    width: 250px;
		    font-size: 16px;
		    border-radius: 20px;
		    margin-right: 40px; /* 버튼과 간격을 위한 여백 */
		}
		
		.search-button {
		    background: #007bff;
		    border: none;
		    color: white;
		    padding: 10px 15px;
		    border-radius: 20px;
		    cursor: pointer;
		    font-size: 16px;
		    position: absolute; /* 절대 위치 설정 */
		    right: 10px; /* 오른쪽 끝에 고정 */
		}
        .search-button:hover {
            background: #0056b3;
        }
    </style>
</head>

<body>
    <!-- Header Section Begin -->
    <header class="header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xl-3 col-lg-2">
                    <div class="header__logo">
                        <a href="/index.html"><img src="/img/logo.png" alt=""></a>
                    </div>
                </div>
                <div class="col-xl-6 col-lg-7">
                    <nav class="header__menu">
						
					    <div class="search-container">
					        <form action="/post/posts" method="get">
					            <select name="searchType" class="search-type-button" aria-label="검색 유형 선택">
					                <option value="product">제품 및 장소 검색</option>
					                <option value="user">회원 닉네임 검색</option>
					            </select>
					            <input type="search" name="searchKeyword" class="search-input" placeholder="검색어를 입력하세요" value="${param.searchKeyword}">
					        	<input type="hidden" name="availableOnly" id="availableOnly" value="${availableOnly}">
					            <button class="search-button" type="submit">검색</button>
					        </form>
					    </div>
						
                    </nav>
                </div>
                <div class="col-lg-3">
                    <div class="header__right">
                        <div class="header__right__auth">
                            <a href="#">Login</a>
                            <a href="#">Register</a>
                        </div>
                        <ul class="header__right__widget">
                            <li><span class="icon_search search-switch"></span></li>
                            <li><a href="#"><span class="icon_heart_alt"></span>
                                <div class="tip">2</div>
                            </a></li>
                            <li><a href="#"><span class="icon_bag_alt"></span>
                                <div class="tip">2</div>
                            </a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="canvas__open">
                <i class="fa fa-bars"></i>
            </div>
        </div>
    </header>
    <!-- Header Section End -->

    <!-- Js Plugins -->
    <script src="/js/jquery-3.3.1.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/jquery.magnific-popup.min.js"></script>
    <script src="/js/jquery-ui.min.js"></script>
    <script src="/js/mixitup.min.js"></script>
    <script src="/js/jquery.countdown.min.js"></script>
    <script src="/js/jquery.slicknav.js"></script>
    <script src="/js/owl.carousel.min.js"></script>
    <script src="/js/jquery.nicescroll.min.js"></script>
    <script src="/js/main.js"></script>
</body>

</html>