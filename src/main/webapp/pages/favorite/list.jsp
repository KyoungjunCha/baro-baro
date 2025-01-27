<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>즐겨찾기 목록</title>
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

.price {
	color: red;
	font-weight: bold;
}

.heart {
	cursor: pointer;
	color: red;
}

.heart:hover {
	transform: scale(1.2);
}

.image {
	width: 100px;
}
</style>
<script>
        function removeFavorite(postSeq) {
            if (confirm("정말로 이 즐겨찾기를 삭제하시겠습니까?")) {
                fetch(`/favorite/delete?postSeq=${postSeq}`, { method: "POST" })
                    .then(response => {
                        if (response.ok) {
                            alert("삭제되었습니다.");
                            location.reload();
                        } else {
                            alert("삭제에 실패했습니다.");
                        }
                    });
            }
        }
    </script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
</head>
<body>
	<h2 style="text-align: center;">즐겨찾기 목록</h2>
	<table>
		<thead>
			<tr>
				<th>이미지</th>
				<th>품목명</th>
				<th>가격</th>
				<th>위치</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="favorite" items="${favoriteList}">
				<c:forEach var="post" items="${favorite.postList}">
					<tr>
						<td></td>
						<td>${post.title}</td>
						<td></td>
						<td>${post.rentLocation}</td>
						<td>
							<i class="heart bi bi-heart-fill"
							data-user-seq="${post.userSeq}" data-post-seq="${post.postSeq}"></i>
						</td>
					</tr>
				</c:forEach>
			</c:forEach>
		</tbody>
	</table>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script>
	$(document).ready(function() {
	    $('.heart').click(function() {
	        const $icon = $(this);
	        const userSeq = $icon.data('user-seq');
	        const postSeq = $icon.data('post-seq');
	        
	        // 하트를 클릭할 때마다 빨간 하트와 빈 하트를 토글
	        if ($icon.hasClass('bi-heart-fill')) {
	            // 즐겨찾기 해제
	            $.ajax({
	                url: '/favorite/toggle', // 서버에서 즐겨찾기 토글 처리
	                type: 'POST',
	                contentType: 'application/json',
	                data: JSON.stringify({
	                    userSeq: userSeq,
	                    postSeq: postSeq
	                }),
	                success: function(response) {
	                    if (response === 'deleted') {
	                        $icon.removeClass('bi-heart-fill').addClass('bi-heart');
	                    }
	                },
	                error: function () {
	                    alert('즐겨찾기 해제에 실패했습니다.');
	                }
	            });
	        } else {
	            // 즐겨찾기 추가
	            $.ajax({
	                url: '/favorite/toggle', // 서버에서 즐겨찾기 토글 처리
	                type: 'POST',
	                contentType: 'application/json',
	                data: JSON.stringify({
	                    userSeq: userSeq,
	                    postSeq: postSeq
	                }),
	                success: function(response) {
	                    if (response === 'added') {
	                        $icon.removeClass('bi-heart').addClass('bi-heart-fill');
	                    }
	                },
	                error: function () {
	                    alert('즐겨찾기 추가에 실패했습니다.');
	                }
	            });
	        }
	    });
	});

	</script>
</body>
</html>
