<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="<c:url value='/resources/css/login.css'/>" />
</head>
<body>
		<sec:authorize access="isAnonymous()">
		<div id="main_menu">
    	<jsp:include page="header&footer/header.jsp"></jsp:include>
		<section>
		<div class = "l_login_all">
			<div class = "l_login_form">
				<div class = "l_login_title">
					<h1 id= "l_login_titlemsg">로 그 인</h1>
				</div>
				<form id="loginForm" name="loginForm" action="<c:url value='/loginProcess'/>" method="post" >
<!-- 				onsubmit="sendit()" -->
					<div class="l_collection_btn">
						<div class="l_login_inputId">
							<input type="text" id="l_id_input" name="id" placeholder="아이디를 입력해주세요." autofocus="autofocus" autocomplete="off">
						</div>
						<div class="l_login_inputPwd">
							<input type="password" id="l_pwd_input" name="pw" placeholder="비밀번호를 입력해주세요.">
						</div>
						<div class="l_login_checkmsg" id="l_login_checkmsg">
							<label id="showMessage">${message}</label>
						</div>
						<div class="l_login_signin">
							<input type="submit" id="l_signin_button" value="로그인">
						</div>
						<div class="l_login_other">
							<div id="l_collection_checkbox">
								<label class="checkbox">
									<input type="checkbox" id="saveid" value="saveOK"> 
									<span class="icon"></span> 
									<span class="text">아이디 기억하기</span>
								</label>
							</div>
							<div id="l_collection_find">
								<a href='<c:url value="/member/findidpwd?choice=id"/>'>아이디 찾기</a> | 
								<a href='<c:url value="/member/findidpwd?choice=pwd"/>'>비밀번호 찾기</a>
							</div>
						</div>
						<div class="l_login_signup">
							<input type="button" id="l_signup_button" value="회원가입" onclick="location.href='<c:url value='/member/form'/>'">
						</div>
					</div>
				</form>
			</div>
		</div>
		</section>
	</div>
	</sec:authorize>
	
	<jsp:include page="header&footer/footer.jsp"/>
</body>
<script type="text/javascript">
	//l_id_input,[id] 아이디 name l_pwd_input[pw] 비밀번호 name [loginForm] form id
	window.onload = function(){
		if(getCookie("userid")){
			document.loginForm.l_id_input.value= getCookie("userid");
			document.loginForm.saveid.checked = true;
		}
	}
	function setCookie(name, value, expiredays){
		var todayDate = new Date();
		todayDate.setDate(todayDate.getDate()+expiredays);
		document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString()+";"
	}
	function getCookie(Name){
		var search = Name + "=";
		if(document.cookie.length > 0){
			offset = document.cookie.indexOf(search);
			if(offset != -1){
				offset += search.length;
				end = document.cookie.indexOf(";",offset);
				if(end == -1){
					end = document.cookie.length;
					return unescape(document.cookie.substring(offset,end));
				}
			}
		}
	}
// 	function sendit(){
// 		var frm = document.loginForm;
// 		if(!frm.l_id_input.value){
// 			frm.l_id_input.focus();
// 			return;
// 		}
// 		if(!frm.l_pwd_input.value){
// 			frm.l_pwd_input.focus();
// 		}
// 		console.log(document.loginForm.saveid.checked);
// 		if(document.loginForm.saveid.checked == true){
// 			setCookie("userid",document.loginForm.l_id_input.value, 7);
// 		} else {
// 			setCookie("userid", document.loginForm.l_id_input.value, 0);
// 		}
// 		document.loginFrom.submit();
// 	}
	
</script>
<c:remove var="message" scope="session"/>
</html>