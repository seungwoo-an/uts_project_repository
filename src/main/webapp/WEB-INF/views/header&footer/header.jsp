<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"   uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/header.css'/>" />

</head>
<body>
   <header id=header>
   <div>
        <div id=header_div>
               <div id="header_img">
                   <a href="/project/"><img src="/project/resources/images/main_logo.png"></a>
               </div>
               <span id=header_search_span>
                   <input type="text" id="header_search" placeholder="검색어를 입력해주세요">
                   <div id="header_search_img">
                       <img src="/project/resources/images/search.png" onclick="headerSearch()">
                   </div>
                   <script type="text/javascript">
                   function headerSearch(){
                	   location.href="/project/product/list?search="+$("#header_search").val();
                   }
                   </script>
               </span>
               <!-- 로그인 사용자 -->
               <div id="header_menu_div">
               <sec:authorize access="isAuthenticated() and hasRole('ROLE_MASTER')">
                      <div id="information_img" title="회원 정보"><a href="/project/member/list"><img src="/project/resources/images/information.png"></a></div>
                  <div id="login_img" title="로그아웃"><a href="/project/logout"><img src="/project/resources/images/login.png"></a></div>
               </sec:authorize>
               <sec:authorize access="isAnonymous()">
                     <div id="information_img" title="내 정보"><a href="/project/member/info"><img src="/project/resources/images/information.png"></a></div>
                     <div id="lastproduct_img" title="장바구니"><a href="/project/product/cart"><img src="/project/resources/images/cart.png"></a></div>
                     <div id="login_img" title="로그인"><a href="/project/login"><img src="/project/resources/images/login.png"></a></div>
               </sec:authorize>
               
               <sec:authorize access="isAuthenticated() and hasAnyRole('ROLE_SELLER' , 'ROLE_CUSTOMER')">
 	                 <div id="information_img" title="내 정보"><a href="/project/member/info"><img src="/project/resources/images/information.png"></a></div>
                     <div id="lastproduct_img" title="장바구니"><a href="/project/product/cart"><img src="/project/resources/images/cart.png"></a></div>
                     <div id="login_img" title="로그아웃"><a href="/project/logout"><img src="/project/resources/images/login.png"></a></div>
               </sec:authorize>
                   <div id="header_icon">
                       <div>
                           <span id=sidebar_span1 class="sidebar_span"></span>
                           <span id=sidebar_span2 class="sidebar_span"></span>
                           <span id=sidebar_span3 class="sidebar_span"></span>
                       </div>
                   </div>
               </div>
            <!-- 익명 사용자 -->
         </div>
   
           <div id="sidebar_back">
               <div id="sidebar_main">
                   <div id="sidebar_logo">
                       <img src="/project/resources/images/header_logo.png" alt="">
                   </div>
               </div>
               <div id=sidebar_icon>
                   <input type="checkbox" hidden class=sidebar_check>
                   <span id=sidebar_span1 class="sidebar_span"></span>
                   <input type="checkbox" hidden class=sidebar_check>
                   <span id=sidebar_span2 class="sidebar_span"></span>
                   <input type="checkbox" hidden class=sidebar_check>
                   <span id=sidebar_span3 class="sidebar_span"></span>
               </div>
               <div id="sidebar">
                   <div id="sidebar_main_logo">
                       <img src="/project/resources/images/sidebar_logo.png">
                   </div>
                        <div id="sidebar_menu_div">
                     <sec:authorize access="hasRole('ROLE_MASTER')">
                        <div>
                           <a href="/project/logout">Logout</a>
                        </div>
                     </sec:authorize>
                        
                     <sec:authorize access="hasAnyRole('ROLE_SELLER' , 'ROLE_CUSTOMER')">
                        <div>
                        	<a href="/project/product/cart">장바구니 보기</a>
                            <a href="/project/logout">로그아웃</a>
                        </div>
                     </sec:authorize>
                        
                     <sec:authorize access="isAnonymous()">
                        <div>
                           <a href="/project/login">로그인</a>
                           <a href="/project/member/info">개인 정보 수정</a>
                           <a href="/project/product/cart">장바구니 보기</a>
                        </div>
                     </sec:authorize>
                  		<div>
                  		<sec:authorize access="!hasRole('ROLE_MASTER')">
                           <h3>내 정보</h3>
                  		</sec:authorize>
                  		<sec:authorize access="hasRole('ROLE_MASTER')">
                           <h3>회원 관리</h3>
                  		</sec:authorize>
                  		
                           <h3>게시판</h3>
                           <h3>고객 센터</h3>
                       </div>
                       <div>
                           <ul>
                               <li><a href="/project/product/list">상품 리스트</a></li>
                           <sec:authorize access="isAnonymous()">
                              <li><a href="/project/member/form">회원 가입</a></li>
                           </sec:authorize>
                           <sec:authorize access="isAuthenticated() and hasAnyRole('ROLE_SELLER' , 'ROLE_CUSTOMER')">
                               <li><a href="/project/member/info">개인 정보 수정</a></li>
                               <li><a href="/project/member/info">나의 구매 내역</a></li>
	                     </sec:authorize>
	                     <sec:authorize access="isAuthenticated() and hasRole('ROLE_SELLER')">
                               <li><a href="/project/member/info">상점 관리</a></li>
                           </sec:authorize>
                           <sec:authorize access="hasRole('ROLE_MASTER')">
							   <li><a href="/project/member/list">회원 리스트</a></li>
	                     </sec:authorize>
                           </ul>
                           <ul>
                               <li><a href="/project/board/event/list">이벤트 게시판</a></li>
                           </ul>
                           <ul>
                               <li><a href="/project/board/notice/list">공지 사항</a></li>
                               <li><a href="/project/board/notice/list">자주하는 질문</a></li>
                               <li><a href="#">1:1 문의</a></li>
                           </ul>
                       </div>
                   </div>
                   <div id=header_icon_div>
                      <div id="header_icon_box">
                          <span id="header_side_icon1" class="header_side_icon"></span>
                          <span id="header_side_icon2" class="header_side_icon"></span>
                      </div>
                   </div>
               </div>
          </div>
      </div>
   </header>



    <script>
        let Scroll_sangtae;
        $(window).scroll(function (event) {
            Scroll_sangtae = true;
        });

        let save_scroll;
        setInterval(function () {
            if (Scroll_sangtae) {
                Scrolled();
                Scroll_sangtae = false;
            }
        }, 250);



        function Scrolled() {
            let scrolltop = $(this).scrollTop();
            if (scrolltop >= 200) {
                document.getElementById("sidebar_back").style.animationDuration = "1s"
                document.getElementById("sidebar_back").style.animationName = "sidebar_down"
                document.getElementById("sidebar_back").style.animationFillMode = "forwards"
            } else if (scrolltop <= 200 && save_scroll >= 200) {
                document.getElementById("sidebar_back").style.animationDuration = "1s"
                document.getElementById("sidebar_back").style.animationName = "sidebar_up"
                document.getElementById("sidebar_back").style.animationFillMode = "forwards"
            }
            save_scroll = scrolltop;
        }

    </script>

    <script>
        $("#header_icon").click(function () {
            document.getElementById("sidebar").style.animationDuration = "1s";
            document.getElementById("sidebar").style.animationName = "header_sidebar_on";
            document.getElementById("sidebar").style.animationFillMode = "forwards";
            document.getElementById("header_icon_box").style.display = "block"
            $(".sidebar_check").prop("checked", true);
        })

        $("#header_icon_box").click(function () {
            document.getElementById("sidebar").style.animationDuration = "1s";
            document.getElementById("sidebar").style.animationName = "header_sidebar_off";
            document.getElementById("sidebar").style.animationFillMode = "forwards";
            document.getElementById("header_icon_box").style.display = "none"
            $(".sidebar_check").prop("checked", false);
        })


        $("#sidebar_icon").click(function () {
            if ($(".sidebar_check").prop("checked")) {
                $(".sidebar_check").prop("checked", false);
                document.getElementById("sidebar").style.animationDuration = "1s";
                document.getElementById("sidebar").style.animationName = "sidebar_off";
                document.getElementById("sidebar").style.animationFillMode = "forwards";

                document.getElementById("sidebar_icon").style.animationDuration = "1s";
                document.getElementById("sidebar_icon").style.animationName = "sidebar_icon_off";
                document.getElementById("sidebar_icon").style.animationFillMode = "forwards";

            } else {
                $(".sidebar_check").prop("checked", true);
                document.getElementById("sidebar").style.animationDuration = "1s";
                document.getElementById("sidebar").style.animationName = "sidebar_on";
                document.getElementById("sidebar").style.animationFillMode = "forwards";
                document.getElementById("header_icon_box").style.display = "none"

                document.getElementById("sidebar_icon").style.animationDuration = "1s";
                document.getElementById("sidebar_icon").style.animationName = "sidebar_icon_on";
                document.getElementById("sidebar_icon").style.animationFillMode = "forwards";
            }
        })

        $(window).on("scroll", function () {
            if ($(".sidebar_check").prop("checked")) {
                $(".sidebar_check").prop("checked", false);
                document.getElementById("sidebar").style.animationDuration = "1s";
                document.getElementById("sidebar").style.animationName = "sidebar_off";
                document.getElementById("sidebar").style.animationFillMode = "forwards";

                document.getElementById("sidebar_icon").style.animationDuration = "1s";
                document.getElementById("sidebar_icon").style.animationName = "sidebar_icon_off";
                document.getElementById("sidebar_icon").style.animationFillMode = "forwards";
                document.getElementById("sidebar_icon").style.zIndex = "none";
            }
        })
    </script>

   <script type="text/javascript">
      $(function() {
         // 화면의 높이와 너비 
         var maskHeight = $(window).height();
         var maskWidth = $(window).width();

         // 전체화면을 채운다
         $('#mask').css({
            'width' : maskWidth,
            'height' : maskHeight
         });
      });
   </script>
</body>
</html>