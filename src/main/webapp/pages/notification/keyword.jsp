<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관심 키워드</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 400px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        .keyword-list {
            margin-top: 10px;
        }
        .keyword-item {
            background: #f1f3f5;
            padding: 10px;
            border-radius: 5px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 5px;
        }
        .delete-btn {
            background: none;
            border: none;
            color: red;
            font-size: 16px;
            cursor: pointer;
        }
        .add-form {
            display: flex;
            margin-top: 15px;
        }
        .add-form input {
            flex: 1;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .add-form button {
            background: #12C1C0;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            margin-left: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>관심 키워드 관리</h2>

        <!-- 키워드 추가 폼 -->
        <form action="/keyword/add" method="post" class="add-form">
            <%-- <input type="hidden" name="userSeq" value="${sessionScope.userSeq}"> --%>
            <input type="hidden" name="userSeq" value="1">
            <input type="text" name="contents" placeholder="키워드를 입력하세요" required>
            <button type="submit">추가</button>
        </form>
		<input type="hidden" id="userSeq" value="1">
        <!-- 관심 키워드 목록 -->
        <div class="keyword-list">
            <c:forEach var="keyword" items="${KEYWORD_LIST}">
                <div class="keyword-item">
                    <span>${keyword.contents}</span>
                        <button class="delete-btn" data-seq="${keyword.keywordSeq }">X</button>
                </div>
            </c:forEach>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
    	$(document).ready(function() {
    		$('.delete-btn').click(function(e) {
    			e.preventDefault();
    			
    			let keywordItem = $(this).closest('.keyword-item');
    			let keywordSeq = $(this).data('seq');
    			let userSeq = $('#userSeq').val();

    			$.ajax({
    				url: "/keyword/delete/" + keywordSeq,
    				type: "POST",
    				data: {
    					userSeq: userSeq
    				},
    				success: function(res) {
    					keywordItem.remove();
    				},
    				error: function(xhr, status, error) {
                        alert("삭제 실패: " + error);
                    }
    			});
    		});
 
    	});
    </script>
</body>
</html>
