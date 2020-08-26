<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/infoservice.css'/>" />

</head>
<body>
<div class="secondsection">
   <div>
       <div>
           <p>나의 메뉴</p>
           <ul>
               <li>
                   <a href="<c:url value='/product/orderlist/${member.member_id }'/>" onClick="orderLists()">나의 주문 내역<p>></p></a>
               </li>
               <li>
                   <a href="#myinfomodifyform" onClick="myinfomodify()">개인 정보 수정<p>></p></a>
               </li>
               <li>
                   <a href="#" onClick="showmenubar()">상품 관리<p>></p></a>
               </li>
               <li >
               	<a href="#">상품 조회 / 수정</a>
               </li>
               <li>
               	<a href="#">상품 등록</a>
               </li>
               <li>
                   <a href="#" >주문 관리<p>></p></a>
               </li>
<!--                         <li> -->
<!--                         	<a href="#">신규 주문()</a> -->
<!--                         </li> -->
<!--                         <li> -->
<!--                         	<a href="#">주문 취소()</a> -->
<!--                         </li> -->
<!--                         <li> -->
<!--                         	<a href="#">상품준비 완료시 배송상태()</a> -->
<!--                         </li> -->
               <li>
                   <a href="#">판매자 정보 수정<p>></p></a>
               </li>
           </ul>
       </div>
       <div>
        <p id="infotitle"></p>
        <hr>
        <ul>
        	<li id="orderlist" style="display: none">
                   <div>
                   	<iframe src="<c:url value='http://www.naver.com'/>">dsaf</iframe>
                   </div>
               </li>
        	<li id="myinfomodify" style="display: none">
         	<div id="myinfomodifysubtitle">
           		<h2>비밀번호 재확인</h2>
           		<h5>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인해주세요.</h5>
           	    <hr>
                   </div>
                   <form action="<c:url value='/member/checkpwd'/>" method="post">
                    <div id="myinfomodifyform" >
                        <div id="myinfomodifyframe">
                            <div class="frameA ">
                                <input type="hidden" name="member_id" value="${member.member_id}">
                                <input type="password" name="member_pw" placeholder="비밀번호를 입력해주세요">
                            </div>
                            <div class="frameA">
                                <input type="submit" value="전송">
                            </div>
                        </div>
                    </div>
                   </form>
                   <hr>
         	</li>
        </ul>
       </div>
   </div>
</div>




	



    <script>
//         let Scroll_sangtae;
//         $(window).scroll(function (event) {
//             Scroll_sangtae = true;
//         });

//         let save_scroll;
//         setInterval(function () {
//             if (Scroll_sangtae) {
//                 Scrolled();
//                 Scroll_sangtae = false;
//             }
//         }, 250);



//         function Scrolled() {
//             let scrolltop = $(this).scrollTop();
//             if (scrolltop >= 200) {
//                 document.getElementById("sidebar_back").style.animationDuration = "1s"
//                 document.getElementById("sidebar_back").style.animationName = "sidebar_down"
//                 document.getElementById("sidebar_back").style.animationFillMode = "forwards"
//             } else if (scrolltop <= 200 && save_scroll >= 200) {
//                 document.getElementById("sidebar_back").style.animationDuration = "1s"
//                 document.getElementById("sidebar_back").style.animationName = "sidebar_up"
//                 document.getElementById("sidebar_back").style.animationFillMode = "forwards"
//             }
//             save_scroll = scrolltop;
//         }

     </script>

    <script>
//         $("#header_icon").click(function () {
//             document.getElementById("sidebar").style.animationDuration = "1s";
//             document.getElementById("sidebar").style.animationName = "header_sidebar_on";
//             document.getElementById("sidebar").style.animationFillMode = "forwards";
//             document.getElementById("header_icon_box").style.display = "block"
//             $(".sidebar_check").prop("checked", true);
//         })

//         $("#header_icon_box").click(function () {
//             document.getElementById("sidebar").style.animationDuration = "1s";
//             document.getElementById("sidebar").style.animationName = "header_sidebar_off";
//             document.getElementById("sidebar").style.animationFillMode = "forwards";
//             document.getElementById("header_icon_box").style.display = "none"
//             $(".sidebar_check").prop("checked", false);
//         })


//         $("#sidebar_icon").click(function () {
//             if ($(".sidebar_check").prop("checked")) {
//                 $(".sidebar_check").prop("checked", false);
//                 document.getElementById("sidebar").style.animationDuration = "1s";
//                 document.getElementById("sidebar").style.animationName = "sidebar_off";
//                 document.getElementById("sidebar").style.animationFillMode = "forwards";

//                 document.getElementById("sidebar_icon").style.animationDuration = "1s";
//                 document.getElementById("sidebar_icon").style.animationName = "sidebar_icon_off";
//                 document.getElementById("sidebar_icon").style.animationFillMode = "forwards";

//             } else {
//                 $(".sidebar_check").prop("checked", true);
//                 document.getElementById("sidebar").style.animationDuration = "1s";
//                 document.getElementById("sidebar").style.animationName = "sidebar_on";
//                 document.getElementById("sidebar").style.animationFillMode = "forwards";
//                 document.getElementById("header_icon_box").style.display = "none"

//                 document.getElementById("sidebar_icon").style.animationDuration = "1s";
//                 document.getElementById("sidebar_icon").style.animationName = "sidebar_icon_on";
//                 document.getElementById("sidebar_icon").style.animationFillMode = "forwards";
//             }
//         })

//         $(window).on("scroll", function () {
//             if ($(".sidebar_check").prop("checked")) {
//                 $(".sidebar_check").prop("checked", false);
//                 document.getElementById("sidebar").style.animationDuration = "1s";
//                 document.getElementById("sidebar").style.animationName = "sidebar_off";
//                 document.getElementById("sidebar").style.animationFillMode = "forwards";

//                 document.getElementById("sidebar_icon").style.animationDuration = "1s";
//                 document.getElementById("sidebar_icon").style.animationName = "sidebar_icon_off";
//                 document.getElementById("sidebar_icon").style.animationFillMode = "forwards";
//                 document.getElementById("sidebar_icon").style.zIndex = "none";
//             }
//         })
     </script>

	<script type="text/javascript">
// 		$(function() {
// 			// 화면의 높이와 너비 
// 			var maskHeight = $(window).height();
// 			var maskWidth = $(window).width();

// 			// 전체화면을 채운다
// 			$('#mask').css({
// 				'width' : maskWidth,
// 				'height' : maskHeight
// 			});
// 		});
	</script>
</body>
</html>