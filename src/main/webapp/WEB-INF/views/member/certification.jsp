<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="<c:url value='/resources/css/member/certification.css'/>" />
<body onload="changePage()">
<jsp:include page="../header&footer/header.jsp"></jsp:include>
<section>
        <div class = "findidpwdmain">
            <div class = "findidpwdform">
                <div class = "findidpwdtitle">
                    <h3 id= "findidpwdtitlemsg">비밀번호 찾기</h3>
                </div>
                <form action="<c:url value='/member/findsendemail'/>" method="post">
                    <div class="collectionfinder">
                        <div class="textbox">
                        	<div class="imgframe">
                        		<img src="https://cdn2.iconfinder.com/data/icons/connectivity/32/sent-128.png">
                        	</div>
                        </div>
                        <div class="textframe">
	                       	<p  id="fristtxt">이메일로 인증 완료후</p>
	                       	<p  id="secondtxt">비밀번호를 다시설정하세요!</p>
	                       	<p  id="thridtxt">입력하신 <font>${findInfo.member_email }</font> 으로 인증번호가 발송되며
	                       	인증 후 <font id="thirdfont"></font> 전송량이 많은 경우 이메일 전송이 지연될 수 있습니다.</p>
	                    </div>
                        <div class="emailfind">
                            <input type="hidden" name="member_name" value="${findInfo.member_name }">
                            <input type="hidden" name="member_id"  value="${findInfo.member_id }">
                            <input type="hidden" name="member_email" value="${findInfo.member_email }">
                            <input type="hidden" name="choice" value="${choice}">
                        </div>
                        <div class="findbtn">
                            <input type="submit" value="인증번호 발송">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <jsp:include page ="../header&footer/footer.jsp"/>
    <script type="text/javascript">
    let choice = "${choice}";
    let title = document.getElementById('findidpwdtitlemsg');
    console.log(choice);
    function changePage() {
		if(choice == "id"){
			title.innerText = "아이디 찾기";
			document.getElementById('secondtxt').innerText = "아이디를 찾을 수 있습니다.";
			document.getElementById('thirdfont').innerText = "아이디를 찾을 수 있습니다.";
		}else{
			title.innerText = "비밀번호 찾기";
			document.getElementById('secondtxt').innerText = "비밀번호를 다시설정하세요!";
			document.getElementById('thirdfont').innerText = "비밀번호가 재발급됩니다.";
		}	
	}
    
//     choice,findInfo
    
    </script>
</body>
</html>