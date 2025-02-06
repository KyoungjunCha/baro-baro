<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>바로바로</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/main.css">
</head>
<body>
	<jsp:include page="/pages/common/header_test_sh.jsp" />
    <!-- 상단 배너 -->
    <section class="hero-section text-center text-md-start">
        <div class="container">
            <div class="row align-items-center">
                <!-- 왼쪽 텍스트 -->
                <div class="col-md-6">
                    <h1 class="hero-text">믿을만한<br>이웃 간 대여</h1>
                    <p class="hero-subtext">동네 주민들과 가깝고 따뜻한 대여를<br>지금 경험해보세요.</p>
                </div>
                <!-- 오른쪽 이미지 -->
                <div class="col-md-6 text-center">
                    <img src="/resources/images/banner.jpg" alt="배너 이미지" class="img-fluid">
                </div>
            </div>
        </div>
    </section>

    <!-- 인기 카테고리 캐러셀 -->
    <section class="container mt-5">
        <h4 class="fw-bold text-left mb-3">인기 카테고리</h4>

        <div id="categoryCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <!-- 첫 번째 슬라이드 -->
                <div class="carousel-item active">
                    <div class="row text-center">
                    </div>
                </div>

                <!-- 두 번째 슬라이드 -->
                <div class="carousel-item">
                    <div class="row text-center"></div>
                 </div>
                    
                    <!-- 세 번째 슬라이드 -->
                <div class="carousel-item">
                    <div class="row text-center"></div>
                </div>
            
            </div>

            <!-- 캐러셀 좌우 버튼 -->
            <button class="carousel-control-prev" type="button" data-bs-target="#categoryCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#categoryCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
            </button>
        </div>
    </section>
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>

	<script>
		$(document).ready(function() {
		    $.ajax({
		        url: '/categories',
		        method: 'GET',
		        success: function(res) {
		        	let categories = res;
		            let itemsPerSlide = 7; // 한 슬라이드에 표시할 카테고리 수
		            let totalSlides = Math.ceil(categories.length / itemsPerSlide); // 총 슬라이드 수

		            let carouselInner = $('.carousel-inner');
		            carouselInner.empty(); // 기존의 슬라이드들 비우기

		            // 카테고리 아이템을 슬라이드에 맞게 분배
		            for (let i = 0; i < totalSlides; i++) {
		                // 새 슬라이드 생성
		                let slide = $('<div class="carousel-item"></div>');
		                
		                // 첫 번째 슬라이드는 'active' 클래스를 추가
		                if (i === 0) {
		                    slide.addClass('active');
		                }
		                
		                // 슬라이드에 카테고리 아이템 추가
		                let row = $('<div class="row text-center"></div>');
		                let startIdx = i * itemsPerSlide;
		                let endIdx = Math.min(startIdx + itemsPerSlide, categories.length);

		                for (let j = startIdx; j < endIdx; j++) {
		                    let category = categories[j];
		                    let categoryHTML = 
		                    	'<div class="col">' +
		                        '<div class="category-icon">' +
		                            '<a href="/post/posts?category=' + category.categorySeq + '"><img src="/resources/images/category' + (j + 1) + '.png" alt="' + category.categoryName + '"></a>' +
		                            /* '<img src="/resources/images/category' + (j + 1) + '.png" alt="' + category.categoryName + '">' + */
		                        '</div>' +
		                        '<p class="fw-bold mt-2">' + category.categoryName + '</p>' +
		                    	'</div>';

		                    row.append(categoryHTML);
		                }

		                slide.append(row);
		                carouselInner.append(slide);
		            }
		        },
		        error: function(err) {
		            console.error("Error fetching categories", err);
		        }
		    });
		});
	</script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
