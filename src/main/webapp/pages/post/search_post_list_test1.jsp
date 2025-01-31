<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <title>게시글 목록</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .search-box {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<h2>게시글 목록</h2>

<!-- 검색 폼 -->
<div class="search-box">
    <form action="/post/posts" method="get">
        <select name="searchType">
            <option value="product">제품명 검색</option>
            <option value="user">사용자 검색</option>
        </select>
        <input type="text" name="searchKeyword" placeholder="검색어 입력">
        <button type="submit">검색</button>
    </form>
</div>

<!-- 게시글 리스트 -->
<table>
    <thead>
        <tr>
            <th>게시글제목</th>
            <th>제품이름</th>
            <th>제품내용</th>
            <th>거래방식</th>
            <th>카테고리이름</th>
            <th>조회수</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="post" items="${KEY_PLIST}">
            <tr>
                <td>${post.title}</td>
                <td>${post.productName}</td>
                <td>${post.itemContent}</td>
                <td>${post.rentContent}</td>
                <td>${post.categoryName}</td>
                <td>${post.count}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>

</body>
</html>