<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>즐겨찾기 목록</title>
<style>
body {
			font-family: 'Arial', sans-serif;
			background-color: #f8f9fa;
			margin: 0;
			padding: 0;
		}

		h2 {
			text-align: center;
			color: #333;
			margin: 20px 0;
		}

		/* 테이블 스타일 */
		table {
			width: 90%;
			margin: 30px auto;
			border-collapse: collapse;
			background-color: #fff;
			border-radius: 8px;
			box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
		}

		th, td {
			border-bottom: 1px solid #ddd;
			padding: 15px;
			text-align: left;
		}

		th {
			background-color: #f1f1f1;
			color: #333;
			font-weight: bold;
		}

		/* 테이블 hover */
		table tr:hover {
			background-color: #f9f9f9;
			cursor: pointer;
		}

		/* 가격 컬러 */
		.price {
			color: #e74c3c;
			font-weight: bold;
		}

		/* 하트 버튼 스타일 */
		.heart {
			cursor: pointer;
			color: #e74c3c;
			font-size: 1.5rem;
			transition: transform 0.2s ease-in-out;
		}

		.heart:hover {
			transform: scale(1.2);
		}

		/* 이미지 */
		.image {
			width: 100px;
			height: 100px;
			object-fit: cover;
			border-radius: 8px;
		}

		/* 즐겨찾기 목록이 없을 때 */
		.no-favorites {
			text-align: center;
			font-size: 1.2rem;
			color: #666;
			margin-top: 30px;
		}

		/* 모바일 대응 */
		@media (max-width: 768px) {
			table {
				width: 100%;
			}
		}
</style>
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
	<c:choose>
		<c:when test="${empty favoriteList }">
			<p class="no-favorites">즐겨찾기한 게시물이 없습니다.</p>
		</c:when>
		<c:otherwise>

			<table>
				<thead>
					<tr>
						<th>제목</th>
						<th>상품명</th>
						<th>평균 가격</th>
						<th>상품 설명</th>
						<th>이미지</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="post" items="${favoriteList}">
						<tr>
							<td><a href="/post/post/${post.postSeq}">${post.title}</a></td>
							<td>${post.productName}</td>
							<td class="price">${post.pricePerTenMinute}원</td>
							<td>${post.itemContent}</td>
							<td>
								<img src="${post.postImage.storagePath}" alt="상품 이미지" class="image">
							</td>
							<td><i class="heart bi bi-heart-fill"
								data-user-seq="${post.userSeq}" data-post-seq="${post.postSeq}"></i></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

		</c:otherwise>
	</c:choose>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script>
	$(document).ready(function() {
		const userSeq = '${sessionScope.user_info.userSeq}';
		
		$.ajax({
			url: '/favorite/list',
			method: 'GET',
			success: function(res) {
				const favoritePostSeqs = res;
				
				$('.heart').each(function() {
					const postSeq = $(this).data('post-seq');
					
					if(favoritePostSeqs.includes(postSeq)) {
						$(this).removeClass('bi-heart').addClass('bi-heart-fill');
					}
				});
			},
			error: function() {
	            console.error('즐겨찾기 목록을 불러오는 데 실패했습니다.');
	        }
		});
		
		// 하트 클릭 시 토글 처리
	    $('.heart').click(function() {
	        const $icon = $(this);
	        const postSeq = $icon.data('post-seq');
	        
	        // 즐겨찾기 해제 또는 추가
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
	                error: function() {
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
	                error: function() {
	                    alert('즐겨찾기 추가에 실패했습니다.');
	                }
	            });
	        }
	    });
	});
 
	</script>
</body>
</html>
