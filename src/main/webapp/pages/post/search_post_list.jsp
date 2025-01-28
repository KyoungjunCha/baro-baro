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

    <jsp:include page="/pages/common/header.jsp" />

    <!-- Breadcrumb Begin -->
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__links">
                        <a href="/index.html"><i class="fa fa-home"></i> Home</a>
                        <span>Shop</span>
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
                            <div class="section-title">
                                <h4>Categories</h4>
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
									        <a data-toggle="collapse" data-target="#collapseFive">출산/유아동</a>
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
									
									<div class="card">
									    <div class="card-heading">
									        <a data-toggle="collapse" data-target="#collapseSix">모바일 및 태블릿</a>
									    </div>
									    <div id="collapseSix" class="collapse" data-parent="#accordionExample">
									        <div class="card-body">
									            <ul>
									                <li><a href="#">스마트폰</a></li>
									                <li><a href="#">태블릿PC</a></li>
									            </ul>
									        </div>
									    </div>
									</div>
									
									<div class="card">
									    <div class="card-heading">
									        <a data-toggle="collapse" data-target="#collapseSeven">가전제품</a>
									    </div>
									    <div id="collapseSeven" class="collapse" data-parent="#accordionExample">
									        <div class="card-body">
									            <ul>
									                <li><a href="#">냉장고</a></li>
									                <li><a href="#">TV</a></li>
									                <li><a href="#">세탁기</a></li>
									            </ul>
									        </div>
									    </div>
									</div>
									
									<div class="card">
									    <div class="card-heading">
									        <a data-toggle="collapse" data-target="#collapseEight">노트북 및 PC</a>
									    </div>
									    <div id="collapseEight" class="collapse" data-parent="#accordionExample">
									        <div class="card-body">
									            <ul>
									                <li><a href="#">노트북</a></li>
									                <li><a href="#">데스크탑</a></li>
									            </ul>
									        </div>
									    </div> 
									</div>
									
									<div class="card">
									    <div class="card-heading">
									        <a data-toggle="collapse" data-target="#collapseNine">카메라 및 캠코더</a>
									    </div>
									    <div id="collapseNine" class="collapse" data-parent="#accordionExample">
									        <div class="card-body">
									            <ul>
									                <li><a href="#">DSLR</a></li>
									                <li><a href="#">미러리스</a></li>
									            </ul>
									        </div>
									    </div>
									</div>
									
									<div class="card">
									    <div class="card-heading">
									        <a data-toggle="collapse" data-target="#collapseTen">가구 및 인테리어</a>
									    </div>
									    <div id="collapseTen" class="collapse" data-parent="#accordionExample">
									        <div class="card-body">
									            <ul>
									                <li><a href="#">침실가구 (침대 등)</a></li>
									                <li><a href="#">거실가구</a></li>
									            </ul>
									        </div>
									    </div>
									</div>
									
									<div class="card">
									    <div class="card-heading">
									        <a data-toggle="collapse" data-target="#collapseEleven">리빙 및 생활용품</a>
									    </div>
									    <div id="collapseEleven" class="collapse" data-parent="#accordionExample">
									        <div class="card-body">
									            <ul>
									                <li><a href="#">주방용품 (조리도구 등)</a></li>
									            </ul>
									        </div>
									    </div>
									</div>
									
									<div class="card">
									    <div class="card-heading">
									        <a data-toggle="collapse" data-target="#collapseTwelve">게임</a>
									    </div>
									    <div id="collapseTwelve" class="collapse" data-parent="#accordionExample">
									        <div class="card-body">
									            <ul>
									                <li><a href="#">PC게임</a></li>
									                <li><a href="#">콘솔게임 (플레이스테이션 등)</a></li>
									            </ul>
									        </div>
									    </div>
									</div>
									
									<div class="card">
									    <div class="card-heading">
									        <a data-toggle="collapse" data-target="#collapseThirteen">반려동물 및 취미</a>
									    </div>
									    <div id="collapseThirteen" class="collapse" data-parent="#accordionExample">
									        <div class="card-body">
									            <ul>
									                <li><a href="#">반려동물 용품 (강아지용품 등)</a></li>
									                <li><a href="#">키덜트 (피규어 등)</a></li>
									            </ul>
									        </div>
									    </div>
									</div>
									
									<div class="card">
									    <div class="card-heading">
									        <a data-toggle="collapse" data-target="#collapseFourteen">도서 및 문구</a>
									    </div>
									    <div id="collapseFourteen" class="collapse" data-parent="#accordionExample">
									        <div class="card-body">
									            <ul>
									                <li><a href="#">유아동 도서</a></li>
									                <li><a href="#">학습서 및 참고서</a></li>
									            </ul>
									        </div>
									    </div>
									</div>
									
									<div class="card">
									    <div class="card-heading">
									        <a data-toggle="collapse" data-target="#collapseFifteen">스포츠</a>
									    </div>
									    <div id="collapseFifteen" class="collapse" data-parent="#accordionExample">
									        <div class="card-body">
									            <ul>
									                <li><a href="#">골프 용품</a></li>
									                <li><a href="#">자전거</a></li>
									            </ul>
									        </div>
									    </div>
									</div>
									
									<div class="card">
									    <div class="card-heading">
									        <a data-toggle="collapse" data-target="#collapseSixteen">레저 및 여행</a>
									    </div>
									    <div id="collapseSixteen" class="collapse" data-parent="#accordionExample">
									        <div class="card-body">
									            <ul>
									                <li><a href="#">캠핑용품 (텐트 등)</a></li>
									            </ul>
									        </div>
									    </div> 
									</div>
									
									<div class="card">
									    <div class="card-heading">
									        <a data-toggle="collapse" data-target="#collapseSeventeen">오토바이</a>
									    </div>
									    <div id="collapseSeventeen" class="collapse" data-parent="#accordionExample">
									        <div class="card-body">
									            <ul>
									                <li><a href="#">125cc 이하 오토바이</a></li> 
									            </ul> 
									        </div> 
									    </div> 
									</div>
									
									<div class="card">
									    <div class="card-heading">
									        <a data-toggle="collapse" data-target="#collapseEighteen">공구 및 산업용품</a> 
									    </div> 
									    <div id="collapseEighteen" class="collapse" data-parent="#accordionExample"> 
									        <div class="card-body"> 
									            <ul> 
									                <li><a href="#">전동공구</a></li> 
									            </ul> 
									        </div> 
									    </div> 
									</div> 

                                    
                                    
                                </div>
                            </div>
                        </div>
                        <div class="sidebar__filter">
                            <div class="section-title">
                                <h4>Shop by price</h4>
                            </div>
                            <div class="filter-range-wrap">
                                <div class="price-range ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content"
                                data-min="0" data-max="999999999"></div>
                                <div class="range-slider">
                                    <div class="price-input">
                                        <p>Price:</p>
                                        <input type="text" id="minamount">
                                        <input type="text" id="maxamount">
                                    </div>
                                </div>
                            </div>
                            <br/>
                            <a href="#">Filter</a>
                        </div>
                        <div class="sidebar__sizes">
                            <div class="section-title">
                                <h4>Shop by size</h4>
                            </div>
                            <div class="size__list">
                                <label for="xxs">
                                    xxs
                                    <input type="checkbox" id="xxs">
                                    <span class="checkmark"></span>
                                </label>
                                <label for="xs">
                                    xs
                                    <input type="checkbox" id="xs">
                                    <span class="checkmark"></span>
                                </label>
                                <label for="xss">
                                    xs-s
                                    <input type="checkbox" id="xss">
                                    <span class="checkmark"></span>
                                </label>
                                <label for="s">
                                    s
                                    <input type="checkbox" id="s">
                                    <span class="checkmark"></span>
                                </label>
                                <label for="m">
                                    m
                                    <input type="checkbox" id="m">
                                    <span class="checkmark"></span>
                                </label>
                                <label for="ml">
                                    m-l
                                    <input type="checkbox" id="ml">
                                    <span class="checkmark"></span>
                                </label>
                                <label for="l">
                                    l
                                    <input type="checkbox" id="l">
                                    <span class="checkmark"></span>
                                </label>
                                <label for="xl">
                                    xl
                                    <input type="checkbox" id="xl">
                                    <span class="checkmark"></span>
                                </label>
                            </div>
                        </div>
                        <div class="sidebar__color">
                            <div class="section-title">
                                <h4>Shop by size</h4>
                            </div>
                            <div class="size__list color__list">
                                <label for="black">
                                    Blacks
                                    <input type="checkbox" id="black">
                                    <span class="checkmark"></span>
                                </label>
                                <label for="whites">
                                    Whites
                                    <input type="checkbox" id="whites">
                                    <span class="checkmark"></span>
                                </label>
                                <label for="reds">
                                    Reds
                                    <input type="checkbox" id="reds">
                                    <span class="checkmark"></span>
                                </label>
                                <label for="greys">
                                    Greys
                                    <input type="checkbox" id="greys">
                                    <span class="checkmark"></span>
                                </label>
                                <label for="blues">
                                    Blues
                                    <input type="checkbox" id="blues">
                                    <span class="checkmark"></span>
                                </label>
                                <label for="beige">
                                    Beige Tones
                                    <input type="checkbox" id="beige">
                                    <span class="checkmark"></span>
                                </label>
                                <label for="greens">
                                    Greens
                                    <input type="checkbox" id="greens">
                                    <span class="checkmark"></span>
                                </label>
                                <label for="yellows">
                                    Yellows
                                    <input type="checkbox" id="yellows">
                                    <span class="checkmark"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-9 col-md-9">
                    <div class="row">
                        <div class="col-lg-4 col-md-6">
                            <div class="product__item">
                                <div class="product__item__pic set-bg" data-setbg="/img/shop/shop-1.jpg">
                                    <div class="label new">New</div>
                                    <ul class="product__hover">
                                        <li><a href="/img/shop/shop-1.jpg" class="image-popup"><span class="arrow_expand"></span></a></li>
                                        <li><a href="#"><span class="icon_heart_alt"></span></a></li>
                                        <li><a href="#"><span class="icon_bag_alt"></span></a></li>
                                    </ul>
                                </div>
                                <div class="product__item__text">
                                    <h6><a href="#">Furry hooded parka</a></h6>
                                    <div class="rating">
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                    </div>
                                    <div class="product__price">$ 59.0</div>
                                </div>
                            </div>
                        </div>
                        
                        
                        <div class="col-lg-4 col-md-6">
                            <div class="product__item sale">
                                <div class="product__item__pic set-bg" data-setbg="/img/shop/shop-5.jpg">
                                    <div class="label">Sale</div>
                                    <ul class="product__hover">
                                        <li><a href="/img/shop/shop-5.jpg" class="image-popup"><span class="arrow_expand"></span></a></li>
                                        <li><a href="#"><span class="icon_heart_alt"></span></a></li>
                                        <li><a href="#"><span class="icon_bag_alt"></span></a></li>
                                    </ul>
                                </div>
                                <div class="product__item__text">
                                    <h6><a href="#">Ankle-cuff sandals</a></h6>
                                    <div class="rating">
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                    </div>
                                    <div class="product__price">$ 49.0 <span>$ 59.0</span></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="product__item">
                                <div class="product__item__pic set-bg" data-setbg="/img/shop/shop-8.jpg">
                                    <div class="label stockout stockblue">Out Of Stock</div>
                                    <ul class="product__hover">
                                        <li><a href="/img/shop/shop-8.jpg" class="image-popup"><span class="arrow_expand"></span></a></li>
                                        <li><a href="#"><span class="icon_heart_alt"></span></a></li>
                                        <li><a href="#"><span class="icon_bag_alt"></span></a></li>
                                    </ul>
                                </div>
                                <div class="product__item__text">
                                    <h6><a href="#">Cotton T-Shirt</a></h6>
                                    <div class="rating">
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                    </div>
                                    <div class="product__price">$ 59.0</div>
                                </div>
                            </div>
                        </div>
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
</body>

</html>