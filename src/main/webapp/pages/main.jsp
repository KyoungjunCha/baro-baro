<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>바로바로 | baro-borrow</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/main.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Gasoek+One&family=Gowun+Dodum&family=Jua&display=swap" rel="stylesheet">
	
    <style>
    	.button-container-main-el {
	    	position: absolute;
			top: 0;
			left: 0;
			right: 0;
			bottom: 0;
			display: flex;
			flex-direction: column;
			justify-content: space-between; 
			align-items: center; 
    	}
    	.button-container-main-el div {
		    padding: 12px 20px; /* 버튼 크기 조정 */
		    margin: 5px 0; /* 버튼 간격 조정 */
		    border: none; /* 기본 테두리 제거 */
		    border-radius: 15px; /* 버튼 테두리 둥글게 */
		    font-size: 24px; /* 버튼 텍스트 크기 */
		    cursor: pointer; /* 마우스 커서 변경 */
		    transition: background-color 0.3s; /* 배경색 변화 애니메이션 */
		    
		    background-color: transparent; /* 버튼 배경색 */
		    color: black; /* 버튼 텍스트 색상 */
		    /* font-weight: 600; */
		    letter-spacing: 1px;
		    font-family: 'Gasoek One', sans-serif; 
		}
    </style>
</head>
<body>
	<jsp:include page="/pages/common/header_test_sh.jsp" />
    <!-- 상단 배너 -->
    <section class="hero-section text-center text-md-start" style="background: #12c1c0;">
        <div class="container">
            <div class="row align-items-stretch">
                <!-- 왼쪽 텍스트 -->
                <div class="col-md-6 d-flex flex-column justify-content-center">
                    <h1 class="hero-text text-light">필요한 건 빌려서,<br>&nbsp;&nbsp;삶을 더 자유롭게</h1>
                    <p class="hero-subtext mt-3" style="padding-left: 20px;color: #ebebe9;">물건을 소유하는 대신, <br>&nbsp;&nbsp;필요한 순간에만 빌려 쓰는 새로운 라이프스타일을 제안합니다.
                    	<br/>불필요한 부담을 덜고, <br>&nbsp;&nbsp;더 가볍고 자유로운 삶을 경험해보세요.
                    </p>
                </div>
                <!-- 오른쪽 이미지 -->
                <div class="col-md-6 d-flex align-items-center">
                    <!-- <img src="/resources/images/banner.jpg" alt="배너 이미지" class="img-fluid"> -->
                    <div class="button-container-main-el">
                    	<div style="width: 400px;font-family: 'Black Han Sans', sans-serif;" onclick="location.href='/post/posts';">물품/장소 대여받으러 가기</div>
                    	<div style="width: 400px;font-family: 'Jua', sans-serif;" onclick="location.href='/post/posts';">물품/장소 대여받으러 가기</div>
                    	<div style="width: 400px;font-family: 'Gowun Dodum', sans-serif;" onclick="location.href='/post/posts';">물품/장소 대여받으러 가기</div>
                    	<div style="width: 400px;font-family: 'Black Han Sans', sans-serif;" onclick="location.href='/post/create_page';">물품/장소 대여하고 수익 창출하러 가기</div>
                    </div>
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
		                            '<a style="cursor: pointer;" href="/post/posts?category=' + category.categorySeq + '"><img src="/resources/images/category' + (j + 1) + '.png" alt="' + category.categoryName + '"></a>' +
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
