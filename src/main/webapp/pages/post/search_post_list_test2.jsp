<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="KO">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ashion Template">
    <meta name="keywords" content="Ashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>바로바로 | baro-borrow</title>

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
.sort-button {
  background-color: #e3f2fd;  /* 연한 하늘색 배경 */
  color: #0277bd;            /* 짙은 하늘색 글자 */
  border: 1px solid #81d4fa; /* 테두리 하늘색 */
  border-radius: 8px;        /* 모서리 둥글게 */
  padding: 10px 20px;        /* 안쪽 여백 */
  font-size: 16px;           /* 글자 크기 */
  cursor: pointer;           /* 마우스 오버 시 포인터 */
  transition: all 0.3s ease; /* 부드러운 전환 효과 */
}

.sort-button:hover {
  background-color: #bbdefb; /* 호버 시 약간 진한 하늘색 */
  border-color: #4fc3f7;    /* 테두리 더 진한 하늘색 */
}

.sort-button.active {
  background-color: #0288d1; /* 활성화 시 진한 하늘색 */
  color: #ffffff;            /* 글자 색상 흰색 */
  border-color: #0277bd;     /* 테두리 짙은 하늘색 */
}

.price-filter {
            width: 300px;
            padding: 20px;
        }
        
        .price-button {
            display: block;
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: none;
            border-radius: 20px;
            background-color: #f5f5f5;
            text-align: left;
            cursor: pointer;
        }
        
        .price-button.active {
            background-color: #333;
            color: white;
        }
        
        .price-range {
            margin-top: 20px;
        }
        
        .price-range input {
            width: 100px;
            padding: 5px;
            margin-right: 10px;
        }
        
        .apply-button {
            margin-top: 10px;
            padding: 8px 15px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            cursor: pointer;
        }
</style>
</head>

<body>
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Offcanvas Menu Begin -->
    <div class="offcanvas-menu-overlay"></div>
    <div class="offcanvas-menu-wrapper">
        <div class="offcanvas__close">+</div>
        <ul class="offcanvas__widget">
            <li><span class="icon_search search-switch"></span></li>
            <li><a href="#"><span class="icon_heart_alt"></span>
                <div class="tip">2</div>
            </a></li>
            <li><a href="#"><span class="icon_bag_alt"></span>
                <div class="tip">2</div>
            </a></li>
        </ul>
        <div class="offcanvas__logo">
            <a href="./index.html"><img src="/img/logo.png" alt=""></a>
        </div>
        <div id="mobile-menu-wrap"></div>
        <div class="offcanvas__auth">
            <a href="#">Login</a>
            <a href="#">Register</a>
        </div>
    </div>
    <!-- Offcanvas Menu End -->




<!-- 수정 ************************************************************************** -->
    <jsp:include page="/pages/common/header_test_sh.jsp" />
<!-- 수정 ************************************************************************** -->




    <!-- Breadcrumb Begin -->
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__links">
                        <a href="/index.html"><i class="fa fa-home"></i> Home</a>
                        
                        <span id="searchInfo" 
						      data-search-type="${KEY_SEARCH.searchType}" 
						      data-search-keyword="${KEY_SEARCH.searchKeyword}">
						    "${KEY_SEARCH.searchKeyword}"  검색결과
						</span>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Shop Section Begin -->
    
    <section class="shop spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-3">
                    <div class="shop__sidebar">
                        <div class="sidebar__categories">
                        
                        <!-- 예약 가능한 항목만 보기 -->
                        <label>
						    <input type="checkbox" id="availableOnlyCheckbox"> 예약 가능만 보기
						</label>
                        

                        <!-- 거리순 정렬 버튼(사용자 웹브라우저의 위치 받기) -->
    					<button class="sort-button" id="sortByDistance">가까운 거리순 정렬</button>
     
    					
                            <div class="section-title">
                                <h4>카테고리</h4>
                            </div>
                            <div class="categories__accordion">
                                <div class="accordion" id="accordionExample">
									<div class="card">
									    <div class="card-heading active">

										<c:set var="selectedCategory" value="${param.categorySeq}" />
										<c:forEach var="category" items="${categories}">
										    <input type="radio" name="category" class="category" 
										    	data-category-seq="${category.categorySeq}"
										    	<c:if test="${category.categorySeq == selectedCategory}">checked</c:if>
										    	/>
										    	${category.categoryName} 
    											<br/>  
										</c:forEach>
											
									    </div>
									</div>
                                </div>
                            </div>
                        </div>
						<div class="price-filter">
					        <h3>가격</h3>
					        <button class="price-button" data-price="5000" onclick="selectPrice(this)">5,000원 이하</button>
					        <button class="price-button" data-price="10000" onclick="selectPrice(this)">10,000원 이하</button>
					        <button class="price-button" data-price="20000" onclick="selectPrice(this)">20,000원 이하</button>
					        
					        <div class="price-range">
					            <input type="number" id="minPrice" placeholder="0" value="0">
					            -
					            <input type="number" id="maxPrice" placeholder="999999" value="999999">
					        </div>
					        
					        <button class="apply-button" onclick="applyFilter()">적용하기</button>
					    </div>
                    </div>
                </div>
                
                
                
                
                <div class="col-lg-9 col-md-9">
                    <div class="row">
                    
	                <!-- 게시글 목록 부분 -->
	                <c:forEach var="post" items="${KEY_PLIST}">
	                
                        <div class="col-lg-4 col-md-6">
                            <div class="product__item">
                            
                            	<!-- 게시글 사진 부분 start -->
                                <div class="product__item__pic set-bg" data-setbg="${post.postImage.storagePath.replace('c:\\uploads', '/uploads')}">
                                    <div class="label new">New</div>
                                    <ul class="product__hover">
                                    	<!-- 하트(즐겨찾기) -->
                                        <li><a href="#"><span class="icon_heart_alt"></span></a></li>
                                    </ul>
                                </div>
                                <!-- 게시글 사진 부분 end -->
                                
                                <div class="product__item__text">
                                    <h6><a href="/post/post/${post.postSeq}"> ${post.title} </a></h6>
                                    <!-- 별점 개수 -->
                                    <div class="rating">
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                    </div>
                                    <div class="product__price">${post.categoryName}</div>
                                    <div class="product__price">10분당 대여가격 : ${post.pricePerTenMinute}원</div>
                                    <div>조회수: ${post.count} 회</div>
                                </div>
                            </div>
                        </div>
                        
  					</c:forEach>
  					<!-- 게시글 목록 부분 -->
  				
  					<!-- 페이지네이션 -->
                        <div class="col-lg-12 text-center">
                            <div class="pagination__option">
                                <a href="#">1</a>
                                <a href="#">2</a>
                                <a href="#">3</a>
                                <a href="#"><i class="fa fa-angle-right"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Shop Section End -->

    <!-- Footer Section Begin -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-6 col-sm-7">
                    <div class="footer__about">
                        <div class="footer__logo">
                            <a href="./index.html"><img src="/img/logo.png" alt=""></a>
                        </div>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt
                        cilisis.</p>
                        <div class="footer__payment">
                            <a href="#"><img src="/img/payment/payment-1.png" alt=""></a>
                            <a href="#"><img src="/img/payment/payment-2.png" alt=""></a>
                            <a href="#"><img src="/img/payment/payment-3.png" alt=""></a>
                            <a href="#"><img src="img/payment/payment-4.png" alt=""></a>
                            <a href="#"><img src="img/payment/payment-5.png" alt=""></a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-5">
                    <div class="footer__widget">
                        <h6>Quick links</h6>
                        <ul>
                            <li><a href="#">About</a></li>
                            <li><a href="#">Blogs</a></li>
                            <li><a href="#">Contact</a></li>
                            <li><a href="#">FAQ</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4">
                    <div class="footer__widget">
                        <h6>Account</h6>
                        <ul>
                            <li><a href="#">My Account</a></li>
                            <li><a href="#">Orders Tracking</a></li>
                            <li><a href="#">Checkout</a></li>
                            <li><a href="#">Wishlist</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4 col-md-8 col-sm-8">
                    <div class="footer__newslatter">
                        <h6>NEWSLETTER</h6>
                        <form action="#">
                            <input type="text" placeholder="Email">
                            <button type="submit" class="site-btn">Subscribe</button>
                        </form>
                        <div class="footer__social">
                            <a href="#"><i class="fa fa-facebook"></i></a>
                            <a href="#"><i class="fa fa-twitter"></i></a>
                            <a href="#"><i class="fa fa-youtube-play"></i></a>
                            <a href="#"><i class="fa fa-instagram"></i></a>
                            <a href="#"><i class="fa fa-pinterest"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                    <div class="footer__copyright__text">
                        <p>Copyright &copy; <script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a></p>
                    </div>
                    <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                </div>
            </div>
        </div>
    </footer>
    <!-- Footer Section End -->

    <!-- Search Begin -->
    <div class="search-model">
        <div class="h-100 d-flex align-items-center justify-content-center">
            <div class="search-close-switch">+</div>
            <form class="search-model-form">
                <input type="text" id="search-input" placeholder="Search here.....">
            </form>
        </div>
    </div>
    <!-- Search End -->
    

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
    
    <script>
        function selectPrice(button) {
            // 모든 버튼의 active 클래스 제거
            document.querySelectorAll('.price-button').forEach(btn => {
                btn.classList.remove('active');
            });
            
            // 선택된 버튼에 active 클래스 추가
            button.classList.add('active');
            
            // 가격 범위 입력란 초기화
            document.getElementById('minPrice').value = '0';
            
            // 선택된 가격에 따라 최대 가격 설정
            let maxPrice = button.getAttribute('data-price');
            document.getElementById('maxPrice').value = maxPrice;
        }
        
        function applyFilter() {
        	var searchInfo = document.getElementById("searchInfo");
            var searchType = searchInfo.dataset.searchType;
            var searchKeyword = searchInfo.dataset.searchKeyword;
            
        	// 페이지 로드 시 URL 파라미터에서 availableOnly 값을 확인하여 체크박스 상태 설정
            const urlParams = new URLSearchParams(window.location.search);
            
            let minPrice = document.getElementById('minPrice').value;
            let maxPrice = document.getElementById('maxPrice').value;
            
            const categorySeq = urlParams.get('categorySeq') || '';
            const availableOnly = availableOnlyCheckbox.checked ? 'true' : '';
            const url = "/post/posts?searchType=" + searchType +
                        "&searchKeyword=" + searchKeyword +
                        (categorySeq ? "&categorySeq=" + categorySeq : "") +
                        (availableOnly ? "&availableOnly=true" : "") +
                        "&minPrice=" + minPrice + 
                        "&maxPrice=" + maxPrice;
            window.location.href = url;
        }
    </script>
	
	<script>
    document.addEventListener("DOMContentLoaded", function() {
    	
        var searchInfo = document.getElementById("searchInfo");
        var searchType = searchInfo.dataset.searchType;
        var searchKeyword = searchInfo.dataset.searchKeyword;
        console.log(searchType);
        console.log(searchKeyword);
     	
        // 페이지 로드 시 URL 파라미터에서 availableOnly 값을 확인하여 체크박스 상태 설정
        const urlParams = new URLSearchParams(window.location.search);
        
     	//min,maxprice initial
     	var minPriceEL = document.getElementById("minPrice");
     	var maxPriceEL = document.getElementById("maxPrice");
     	minPriceEL.value = urlParams.get('minPrice') ? urlParams.get('minPrice') : 0;
     	maxPriceEL.value = urlParams.get('maxPrice') ? urlParams.get('maxPrice') : 0;
     
     
        // 체크박스 요소 가져오기
        var availableOnlyCheckbox = document.getElementById("availableOnlyCheckbox");

        // 체크박스 변경 시 이벤트 처리
        availableOnlyCheckbox.addEventListener("change", function() {
            const availableOnly = availableOnlyCheckbox.checked;  // 체크 상태 확인

            // URL을 작성하여 페이지 리디렉션
            const url = "/post/posts?searchType=" + searchType +
                        "&searchKeyword=" + searchKeyword +
                        (availableOnly ? "&availableOnly=true" : "");
            
            console.log("체크박스 클릭 후 URL:", url);  // 디버깅용 로그
            window.location.href = url;  // 페이지 리디렉션
        });
        
        
        // 카테고리 클릭 시 리디렉션
        document.querySelectorAll(".category").forEach(category => {
            category.addEventListener("click", function() {
                
            	// HTML 요소에서 data-category-seq 값 가져오기
            	const categorySeq = this.dataset.categorySeq;
                console.log("선택한 카테고리:", categorySeq);
				
                const availableOnly = availableOnlyCheckbox.checked;  // 체크박스 상태 유지
                
                // URL을 한번에 작성하여 페이지 리디렉션
                const url = "/post/posts?searchType=" + searchType +
                			"&searchKeyword=" + searchKeyword +
                			"&categorySeq=" + categorySeq +
                			(availableOnly ? "&availableOnly=true" : "");
                window.location.href = url;  // 페이지 리디렉션
            });
        });
        
        
        
        if (urlParams.get('availableOnly') === 'true') {
            availableOnlyCheckbox.checked = true;  // 체크박스 체크 상태 유지
        }
        
        // 거리순 정렬 버튼 (sortByDistance) 클릭 시 위치 기반 정렬
        document.getElementById('sortByDistance').addEventListener('click', function() {
            const userConsent = confirm("나의 현재 위치를 제공하는 것에 동의하십니까?");

            if (userConsent) {
                navigator.geolocation.getCurrentPosition((position) => {
                    const latitude = position.coords.latitude;
                    const longitude = position.coords.longitude;

                    console.log("위도:", latitude);
                    console.log("경도:", longitude);

                    // 선택된 카테고리 및 체크박스 상태 유지
                    const categorySeq = urlParams.get('categorySeq') || '';
                    const availableOnly = availableOnlyCheckbox.checked ? 'true' : '';

                    let minPrice = document.getElementById('minPrice').value;
                    let maxPrice = document.getElementById('maxPrice').value;
                    
                    // 위치 정보와 함께 URL 작성 후 리디렉션
                    const url = "/post/posts?searchType=" + searchType +
                                "&searchKeyword=" + searchKeyword +
                                (categorySeq ? "&categorySeq=" + categorySeq : "") +
                                (availableOnly ? "&availableOnly=true" : "") +
                                "&latitude=" + latitude + 
                                "&longitude=" + longitude
                                + (minPrice ? "&minPrice=" + minPrice : "")
                                + (maxPrice ? "&maxPrice=" + maxPrice : "")
                                ;

                    console.log("위치 기반 정렬 URL:", url);
                    window.location.href = url;
                }, (error) => {
                    console.error("위치 정보를 가져오는 데 실패했습니다:", error);
                    alert("위치 정보를 가져오는 데 실패했습니다. 위치 설정을 확인하세요.");
                });
            } else {
                alert("위치 정보 제공을 거부하셨습니다.");
            }
        });
    });
	</script>
	



</body>

</html>