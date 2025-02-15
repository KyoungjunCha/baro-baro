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
    	table {
	width: 80%;
	margin: auto;
	border-collapse: collapse;
	text-align: left;
}

th, td {
	border-bottom: 1px solid #ddd;
	padding: 10px;
}

th {
	background-color: #f4f4f4;
}

table tr:hover {
	cursor: pointer;
	background-color: #f1f1f1; 
	transition: background-color 0.3s ease; 
}
    
    
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
            background: #ff6f61;
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
            <input type="hidden" name="userSeq" value=${sessionScope['SESS_USER_SEQ']}>
            <input type="text" name="contents" placeholder="키워드를 입력하세요" required>
            <button type="submit">추가</button>
        </form>
		<input type="hidden" name="userSeq" value=${sessionScope['SESS_USER_SEQ']}>
        <!-- 관심 키워드 목록 -->
        <div class="keyword-list">
            <c:forEach var="keyword" items="${KEYWORD_LIST}">
                <div class="keyword-item">
                    <span>${keyword.contents}</span>
						<input type="hidden" name="userSeq" value=${sessionScope['SESS_USER_SEQ']}> 
                        <button class="delete-btn" data-seq="${keyword.keywordSeq }">X</button>
                </div>
            </c:forEach>
        </div>
    </div>
    
    <!-- 여기에 알림들 보여주려구요 25.02.05 -->
    <div>
    	<h3>알림종합 목록</h3>
		<table id="notificationTable">
			<thead>
				<tr>
					<th>알림번호</th>
					<th>알림타입</th>
					<th>알림제목</th>
					<th>알림내용</th>
					<th>읽음여부</th>
					<th>알림생성시간</th>
					<th>링크</th>
					<th>유저넘버</th>
				</tr>
			</thead>
			<tbody>
					
			</tbody>
		</table>
    </div>
    
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
    	$(document).ready(function() {
    		$('.delete-btn').click(function(e) {
    			e.preventDefault();
    			
    			let keywordItem = $(this).closest('.keyword-item');
    			let keywordSeq = $(this).data('seq');
    			let userSeq = ${sessionScope['SESS_USER_SEQ']}
    			console.log(${sessionScope['SESS_USER_SEQ']});

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
 
    		$.ajax({
    			url: '/notification-list', // 서버에서 즐겨찾기 토글 처리
                type: 'GET',
                contentType: 'application/json',
                success: function(notificationList) {
                    console.log("알림테스트 : " ,notificationList); // 받아온 알림 로그 출력
					
                    // 테이블의 tbody를 비우고 새롭게 데이터 추가
                    const notificationTable = $('#notificationTable tbody');
                    notificationTable.empty();

                    // 게시물 데이터를 테이블에 추가
                    notificationList.forEach(noti => {
                        const notiDate = new Date(noti.createdAt);
                        const formattednotiDate = notiDate.toLocaleString();  // 사용자 지역에 맞는 형식으로 변환
						
                        const row = $('<tr>');
                        row.append(`
                        	<td>${'${noti.notificationSeq}'}</td>
                        	<td>${'${noti.notificationType}'}</td>
                        	<td>${'${noti.title}'}</td>
                        	<td>${'${noti.contents}'}</td>
                        	<td>${'${noti.isRead}'}</td>
                        	<td>${'${formattednotiDate}'}</td>
                        	<td>${'${noti.link}'}</td>
                        	<td>${'${noti.userSeq}'}</td>
                        `);
                        
                        notificationTable.append(row);
                	});
                
             	},
	             error: function (error) {
	                 alert('알림리스트 불러오기 실패');
	             }
 		});
    	});
	</script>
</body>
</html>
