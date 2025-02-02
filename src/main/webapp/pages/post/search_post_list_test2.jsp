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
                        

                        <!-- 거리순 정렬 버튼 실패....(사용자 웹브라우저의 위치 받기) -->
    					<button id="sortByDistance">가까운 거리순 정렬</button>
     
    					
                            <div class="section-title">
                                <h4>카테고리</h4>
                            </div>
                            
                            <div class="categories__accordion">
                                <div class="accordion" id="accordionExample">
									<div class="card">
									    <div class="card-heading active">
									        <a data-toggle="collapse" data-target="#collapseOne">수입명품</a>
									    </div>
									    <div id="collapseOne" class="collapse show" data-parent="#accordionExample">
									        <div class="card-body">
									            <ul>
									                <li><a href="#">여성신발</a></li>
									                <li><a href="#">남성신발</a></li>
									                <li><a href="#">가방/핸드백</a></li>
									                <li><a href="#">지갑/벨트</a></li>
									                <li><a href="#">여성의류</a></li>
									                <li><a href="#">남성의류</a></li>
									            </ul>
									        </div>
									    </div>
									</div>
									
									<div class="card">
									    <div class="card-heading">
									        <a data-toggle="collapse" data-target="#collapseTwo">패션의류</a>
									    </div>
									    <div id="collapseTwo" class="collapse" data-parent="#accordionExample">
									        <div class="card-body">
									            <ul>
									                <li><a href="#">여성의류</a></li>
									                <li><a href="#">남성의류</a></li>
									            </ul>
									        </div>
									    </div>
									</div>
									
									<div class="card">
									    <div class="card-heading">
									        <a data-toggle="collapse" data-target="#collapseThree">패션잡화</a>
									    </div>
									    <div id="collapseThree" class="collapse" data-parent="#accordionExample">
									        <div class="card-body">
									            <ul>
									                <li><a href="#">운동화</a></li>
									                <li><a href="#">여성신발</a></li>
									                <li><a href="#">남성신발</a></li>
									                <li><a href="#">가방</a></li>
									            </ul>
									        </div>
									    </div>
									</div>
									
									<div class="card">
									    <div class="card-heading">
									        <a data-toggle="collapse" data-target="#collapseFour">뷰티</a>
									    </div>
									    <div id="collapseFour" class="collapse" data-parent="#accordionExample">
									        <div class="card-body">
									            <ul>
									                <li><a href="#">스킨케어</a></li>
									                <li><a href="#">메이크업</a></li>
									            </ul>
									        </div>
									    </div>
									</div>
									
									<div class="card">
									    <div class="card-heading">
									        <a data-toggle="collapse" data-target="#collapseFive" class="category" data-category-seq="5">출산/유아동</a>
									    </div>
									    <div id="collapseFive" class="collapse" data-parent="#accordionExample">
									        <div class="card-body">
									            <ul>
									                <li><a href="#">출산용품</a></li>
									                <li><a href="#">유아동 의류</a></li>
									            </ul>
									        </div>
									    </div>
									</div>
									
									

                                    
                                    
                                </div>
                            </div>
                        </div>
                        <div class="sidebar__filter">
                            <div class="section-title">
                                <h4>가격</h4>
                            </div>
                            <div class="filter-range-wrap">
                                <div class="price-range ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content"
                                data-min="0" data-max="999999999"></div>
                                <div class="range-slider">
                                    <div class="price-input">
                                        <p>가격:</p>
                                        <input type="text" id="minamount">
                                        <input type="text" id="maxamount">
                                    </div>
                                </div>
                            </div>
                            <br/>
                            <a href="#">Filter</a>
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
                                <div class="product__item__pic set-bg" data-setbg="${post.postImage}">
                                    <div class="label new">New</div>
                                    <ul class="product__hover">
                                    	<!-- 사진 확대 -->
                                        <li><a href="${post.postImage}" class="image-popup"><span class="arrow_expand"></span></a></li>
                                        <!-- 하트(즐겨찾기) -->
                                        <li><a href="#"><span class="icon_heart_alt"></span></a></li>
                                        <!-- 장바구니 -->
                                        <li><a href="#"><span class="icon_bag_alt"></span></a></li>
                                    </ul>
                                </div>
                                <!-- 게시글 사진 부분 end -->
                                
                                <div class="product__item__text">
                                    <h6><a href="#"> ${post.title} </a></h6>
                                    <!-- 별점 개수 -->
                                    <div class="rating">
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                    </div>
                                    <div class="product__price">${post.categoryName}</div>
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
    document.addEventListener("DOMContentLoaded", function() {
        var searchInfo = document.getElementById("searchInfo");
        var searchType = searchInfo.dataset.searchType;
        var searchKeyword = searchInfo.dataset.searchKeyword;
        console.log(searchType);
        console.log(searchKeyword);
        
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
        
        
        // 페이지 로드 시 URL 파라미터에서 availableOnly 값을 확인하여 체크박스 상태 설정
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('availableOnly') === 'true') {
            availableOnlyCheckbox.checked = true;  // 체크박스 체크 상태 유지
        }
    });
	</script>
	
	<script>
        document.getElementById('sortByDistance').addEventListener('click', function() {
            // 위치정보 제공 동의 여부 확인
            const userConsent = confirm("나의 현재 위치를 제공하는것에 동의하십니까?");

            if (userConsent) {
                // 위치 정보 요청
                navigator.geolocation.getCurrentPosition((position) => {
                    const latitude = position.coords.latitude;
                    const longitude = position.coords.longitude;

                    console.log("위도:", latitude);
                    console.log("경도:", longitude);

                    // 서버로 위치 정보 전송
                    fetch('/post/location', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({
                            latitude: latitude,
                            longitude: longitude
                        })
                    })
                    .then(response => response.text())
                    .then(data => {
                        console.log("서버 응답:", data);
                        // 서버 응답에 따라 페이지 업데이트나 다른 동작 수행 가능
                    })
                    .catch(error => {
                        console.error("에러 발생:", error);
                    });
                }, (error) => {
                    console.error("위치 정보를 가져오는 데 실패했습니다:", error);
                    alert("위치 정보를 가져오는 데 실패했습니다. 위치 설정을 확인하세요.");
                });
            } else {
                alert("위치 정보 제공을 거부하셨습니다.");
            }
        });
    </script>


</body>

</html>