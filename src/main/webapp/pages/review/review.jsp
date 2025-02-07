<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>바로바로 | baro-borrow</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="/css/review.css">
</head>
<body>
	<jsp:include page="/pages/common/header_test_sh.jsp" />

	<div class="container mt-5">
		<h3 class="text-start ms-3">
			(유저 닉네임)님,<br> (상대방 닉네임)님과 거래가 어떠셨나요?
		</h3>

		<!-- 유저 평가 -->
		<div class="card p-4 mt-4">
			<h4 class="mb-3">어떤 점이 최고였나요?</h4>
			<div class="mb-3">
				<div class="form-check">
					<input class="form-check-input" type="checkbox" id="descAccurate"
						name="userReview" value="물품 설명이 자세해요"> <label
						class="form-check-label" for="descAccurate">물품 설명이 자세해요</label>
				</div>
				<div class="form-check">
					<input class="form-check-input" type="checkbox" id="condMatch"
						name="userReview" value="물품 상태가 설명한 것과 같아요"> <label
						class="form-check-label" for="condMatch">물품 상태가 설명한 것과 같아요</label>
				</div>
				<div class="form-check">
					<input class="form-check-input" type="checkbox" id="shared"
						name="userReview" value="나눔을 해주셨어요"> <label
						class="form-check-label" for="shared">나눔을 해주셨어요</label>
				</div>
				<div class="form-check">
					<input class="form-check-input" type="checkbox" id="keptPromise"
						name="userReview" value="약속을 잘 지켜요"> <label
						class="form-check-label" for="keptPromise">약속을 잘 지켜요</label>
				</div>
			</div>
		</div>

		<!-- 대여 물품 평가 -->
		<div class="card p-4 mt-4">
			<h4 class="mb-3">따뜻한 대여 경험을 알려주세요!</h4>
			<div class="mb-3">
				<div class="star-rating">
				    <i class="bi bi-star-fill" data-value="1"></i>
				    <i class="bi bi-star" data-value="2"></i>
				    <i class="bi bi-star" data-value="3"></i>
				    <i class="bi bi-star" data-value="4"></i>
				    <i class="bi bi-star" data-value="5"></i>
				</div>
				<input type="hidden" id="ratingValue" name="ratingValue">
			</div>
			<div class="mb-3 position-relative">
				<textarea class="form-control" id="itemReview" name="itemReview"
					rows="5" placeholder="여기에 적어주세요.(선택사항)" style="resize: none;"></textarea>
				<i class="bi bi-camera-fill fs-3 camera-icon"></i>
			</div>
		</div>

		<div class="text-center mt-4">
			<button type="submit" class="btn main-color me-3">리뷰 작성</button>
			<button type="button" class="btn cancel-btn">취소</button>
		</div>
	</div>


	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		$(document).ready(function () {
		    $(".star-rating .bi").click(function () {
		        let value = $(this).data("value"); // 클릭한 별의 값 가져오기
		        $("#ratingValue").val(value); // 숨겨진 input에 값 저장
		
		        // 모든 별 회색으로 초기화
		        $(".star-rating .bi").removeClass("selected").addClass("bi-star").removeClass("bi-star-fill");
		
		        // 선택한 별과 이전 별들을 노란색으로 변경
		        $(".star-rating .bi").each(function () {
		            if ($(this).data("value") <= value) {
		                $(this).removeClass("bi-star").addClass("bi-star-fill selected");
		            }
		        });
		    });
		    
		    $(".cancel-btn").click(function () {
		        history.back();
		    });
		});
	</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>