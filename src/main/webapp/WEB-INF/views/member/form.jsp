<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/member/form.css'/>" />
<script src="http://code.jquery.com/jquery-3.1.0.min.js"></script>
<!-- 주소 찾기 api -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
</head>
<body>
	<c:if test="${!empty message}">
    	<jsp:include page="../header&footer/header.jsp"></jsp:include>
   	</c:if>
   	<c:if test="${!empty message}">
        <form action='<c:url value="/member/${message}"/>' method="post" onsubmit="return inputCheck()">
    </c:if>
    <c:if test="${empty message}">
        <form action='<c:url value="/member/update"/>' method="post" onsubmit="return inputCheck()">
    </c:if> 
	        <div class="joinmain">
	            <div class="joinbox">
	                <div class="jointitle">
	                    <h1>회 원 ${message eq 'insert' ? '가 입' : '수 정'}</h1>
	                </div>
	                <div class="joinidinfo">
	                    <div class="joinidinfo2">
	                        <div class="joininfokey">
	                            <input type="text" value="${member.member_id}" name="member_id" id="member_id" ${not empty member ? "readonly":"placeholder='아이디를 입력하세요' autocomplete='off'"}>
	                        </div>
	                        <div class="joininfovalue">
	                        	<font class="joinchecktxt" id="id_check"></font>
	                        </div>
	                        <div class="joininfokey">
	                            <input type="password" name="member_pw" id="member_pw" placeholder='비밀번호를 입력하세요'>
	                        </div>
	                        <div class="joininfovalue">
	                            <font id="pw_check"></font>
	                        </div>
	                        <div class="joininfokey">
	                            <input type="password" id="member_pw_ok" placeholder='비밀번호 확인'>
	                        </div>
	                        <div class="joininfovalue">
	                            <font id="pw_check_msg"></font>
	                        </div>
	                        <div class="joininfokey">
	                            <input type="text" value="${member.member_name}" ${not empty member ? "readonly":"" } name="member_name" id="member_name" autocomplete="off" placeholder='이름을 입력하세요'>
	                        </div>
	                        <div class="joininfovalue">
	                            <font id="name_check"></font>
	                        </div>
	                        <div class="joininfokey">
	                            <input type="text" value="${member.member_tel}" name="member_tel" id="member_tel" autocomplete="off" placeholder='전화번호를 입력하세요. (예 : 01012345678)'>
	                        </div>
	                        <div class="joininfovalue">
	                            <font id="tel_check"></font>
	                        </div>
	                        
	                        <c:choose>
								<c:when test="${empty member }">
									<div class="hidden_addr">
				                        <div class="joininfokey">
				                            <input type="text" name="member_main_addr" placeholder="주소를 입력해주세요" readonly class="member_addr" id="member_addr">
				                        </div>
				                        <div class="joininfovalue">
				                            <input type="button"  id="findaddrbtn" value="주소찾기" onclick="execPostCode();">
				                        </div>
				                        <div class="joininfokey">
				                            <input type="text" name="member_sub_addr" placeholder="상세 주소를 입력하세요 *(없으면 생략가능)" class="member_addr1">
				                        </div>
				                        <div class="joininfovalue">
				                            <font id="addr_check"></font>
				                        </div>
				                   	</div>
								</c:when>
								<c:otherwise>
									<div class="hidden_addr">
				                        <div class="joininfokey">
				                            <input type="text" name="member_main_addr" placeholder="주소를 입력하세요" readonly id="member_addr" value="${member.member_main_addr}">
				                        </div>
				                        <div class="joininfovalue">
				                            <input type="button" id="findaddrbtn" value="주소찾기" onclick="execPostCode();">
				                        </div>
				                        <div class="joininfokey">
				                            <input type="text" name="member_sub_addr" placeholder="상세 주소를 입력하세요 *(없으면 생략가능)" value="${member.member_sub_addr}">
				                        </div>
			                        </div>
								</c:otherwise>
							</c:choose>
	                        <div class="joininfokey">
	                            <input type="text" value="${member.member_email}" name="member_email" id="member_email"  autocomplete="off" ${not empty member ? "readonly":"placeholder='이메일을 입력하세요.(예: huh_say@uts.com)' autocomplete='off'"}>
	                        </div>
	                        <div class="joininfovalue">
	                            <input type=${not empty member ? "hidden":"button"} id="certifyemail" value="중복 확인"  >
	                        </div>
	                        <c:if test="${empty member}">
	                            <sec:authorize access="isAnonymous()">
	                                <div class="selectuser">
	                                    <input type="radio" name="member_auth" id="role_cus" value="ROLE_CUSTOMER" checked><label for="role_cus"> 구매자</label>
	                                    <input type="radio" name="member_auth" id="role_sell" value="ROLE_SELLER"><label for="role_sell"> 판매자</label>
	                                </div>
	                            </sec:authorize>
	                        </c:if>
	                        <div class="forSeller">
		                        <div id="forseller2">
		                            <input type="text" id="sellerbox" placeholder="사업자 등록번호를 입력하세요( '-' 포함)" name="seller_reg_num">
		                        </div>
		                        <div class="findseller">
		                            <input type="button" id="regNumCheckBtn" value="조회">
		                         </div>
		                         <div class="fsellertxt">
	                          	 	<font id="reg_num_check"></font>
	                      		 </div>
	                        </div>
	                        <div class="joininbtn">
		                        <input type="submit" id="${message eq 'insert' ? 'signupbtn':'signupbtn2'}" value="${message eq 'insert' ? '가입완료' : '수정완료'}">
	                        </div>
	                        <div class="joininbtn">
	                        	<input type="button" id="cancelbtn" value="취소" onclick="window.history.back()">
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
        </form>
        <div>
        
        <c:if test="${!empty message}">
        <jsp:include page ="../header&footer/footer.jsp"/>
   		</c:if>
	        
	<script type="text/javascript">
	let member = '${member}';
    let id_check=false;
    let pw_check=false;
    let pw_ok_check=false;
    let name_check=false;
    let tel_check=false;
    let addr_check=false;
    let email_check=false;
    let reg_num_check=true;
    //컴트롤러로부터 넘겨받는 member가 비어있지 않은 경우 아래의 값들을 true로 초기화하여 수정을 하지 않고 수정완료를 누르더라도 수정될 수 있도록.
    if(member!=""){
    	id_check=true;
    	name_check=true;
    	tel_check=true;
    	addr_check=true;
    	email_check=true;
    }
    $(document).ready(function(){
        //inputCheck : 모든 필수입력 확인 및 데이터 형식 확인 후 if(inputCheck){회원가입버튼활성화}else{회원가입버튼 비활성화유지}
        let member_pw="";
        let member_pw_ok="";
        $("#member_id").blur(function(){
                let member_id = document.getElementById("member_id").value;
                if(member==""){
	                if(member_id.length==0){
	                    document.getElementById("id_check").style.color="red";
						document.getElementById("id_check").style.margin="15px 0 0 0";
	                    document.getElementById("id_check").innerText="필수항목 입니다.";
	                    id_check=false;
	                }else if(!/^[a-z0-9]{4,12}$/.test(member_id)){
	                    document.getElementById("id_check").style.color="red";
						document.getElementById("id_check").style.margin="5px 0 0 0";
	                    document.getElementById("id_check").innerText="글자수 4-12, 영문 소문자로 입력해 주세요.";
	                    id_check=false;
	                }else{
	                    $.ajax({
	                        url:'<c:url value="/member/rest/memberCheck?member_id="/>'+member_id,
	                        type:'POST',
	                        success:function(result){
	                            if(result==1){
	                    			document.getElementById("id_check").style.color="red";
									document.getElementById("id_check").style.margin="15px 0 0 0";
	                                document.getElementById("id_check").innerText="이미 가입된 아이디 입니다.";
	                                id_check=false;
	                            }else{
	                    			document.getElementById("id_check").style.color="#2a365c";
									document.getElementById("id_check").style.margin="15px 0 0 0";
	                                document.getElementById("id_check").innerText="사용 가능한 아이디 입니다.";
	                                id_check=true;
	                            }
	                        }
	                    });
	                }
                }
        });
        $("#member_pw").blur(function(){
            member_pw = document.getElementById("member_pw").value;
            if(member_pw.length==0){
				document.getElementById("pw_check").style.color="red";
				document.getElementById("pw_check").style.margin="15px 0 0 0";
                document.getElementById("pw_check").innerText="필수 항목입니다.";
                pw_check=false;
            }else if(!/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#]).{10,15}$/.test(member_pw)){
				document.getElementById("pw_check").style.color="red";
				document.getElementById("pw_check").style.margin="5px 0 0 0";
                document.getElementById("pw_check").innerText="글자수 10-15, 영어 대/소문자,\n 특수문자, 숫자로 입력해주세요.";
                pw_check=false;
            }else{
				document.getElementById("pw_check").style.color="#2a365c";
				document.getElementById("pw_check").style.margin="15px 0 0 0";
                document.getElementById("pw_check").innerText="사용 가능한 비밀번호 입니다.";
                pw_check=true;
            }
            $("#member_pw_ok").trigger("blur");
        });
        $("#member_pw_ok").blur(function(){
            member_pw_ok = document.getElementById("member_pw_ok").value;
                if(member_pw_ok.length==0){
					document.getElementById("pw_check_msg").style.color="red";
                    document.getElementById("pw_check_msg").innerText="비밀번호를 일치시켜주세요.";
                    pw_ok_check=false;
                }
                else if(member_pw != member_pw_ok){
					document.getElementById("pw_check_msg").style.color="red";
                    document.getElementById("pw_check_msg").innerText="비밀번호가 일치하지 않습니다.";
                    pw_ok_check=false;
                }else{
					document.getElementById("pw_check_msg").style.color="#2a365c";
                    document.getElementById("pw_check_msg").innerText="비밀번호가 일치합니다.";
                    pw_ok_check=true;
                }
        });
        
        $("#member_name").blur(function(){
            let member_name = document.getElementById("member_name").value
            if(member_name.length==0){
				document.getElementById("name_check").style.color="red";
                document.getElementById("name_check").innerText="필수 항목입니다.";
                name_check=false;
                
            }else if(!/^[가-힣]+$/.test(member_name)){
				document.getElementById("name_check").style.color="red";
                document.getElementById("name_check").innerText="가 나 다 형식으로 입력해주세요.";
            }
            else{
                document.getElementById("name_check").innerText="";
                name_check=true;
            }
        });
        $("#member_tel").blur(function(){
            let member_tel= document.getElementById("member_tel").value
            if(member_tel.length==0){
				document.getElementById("tel_check").style.color="red";
                document.getElementById("tel_check").innerText="필수 항목입니다.";
                tel_check=false;
            }else if(!/^[0][1]\d{1}\d{3,4}\d{4}$/.test(member_tel)){ //------------------------------------------------**
				document.getElementById("tel_check").style.color="red";
                document.getElementById("tel_check").innerText="잘못된 형식입니다.";
                tel_check=false;
            }else{
                document.getElementById("tel_check").innerText="";
                tel_check=true;
            }
        });
        $("#member_email").blur(function(){
        let member_email = document.getElementById("member_email").value
        if(member_email.length==0){
			document.getElementById("certifyemail").disabled = "disabled";
			document.getElementById("certifyemail").style.opacity = '0.7';
        }else if(!/^[a-z0-9._%+-]+@[a-z]+\.[a-z]{2,3}$/.test(member_email)){//------------------------------------------------**
			document.getElementById("certifyemail").disabled = "disabled";
			document.getElementById("certifyemail").style.opacity = '0.7';
        }else{
			document.getElementById("certifyemail").disabled = false;
			document.getElementById("certifyemail").style.opacity = '1';
			document.getElementById("certifyemail").style.backgroundColor = '#2a365c';
			document.getElementById("certifyemail").style.color = 'white';
			document.getElementById("certifyemail").style.border = 'none';
        	}
        });
    });
    function inputCheck(){
        if(id_check&&pw_check&&pw_ok_check&&name_check&&tel_check&&addr_check&&email_check&&reg_num_check){
        	$("#signupbtn").attr("disabled",true);
            return true;
        }else {
        	console.log("id_check : "+id_check);
        	console.log("pw_check : "+pw_check);
        	console.log("pw_ok_check : "+pw_ok_check);
        	console.log("name_check : "+name_check);
        	console.log("tel_check : "+tel_check);
        	console.log("addr_check : "+addr_check);
        	console.log("email_check : "+email_check);
        	console.log("reg_num_check : "+reg_num_check);
			$("input").each(function(){
				$(this).trigger("blur");
			})
        	//내용이 입력되어 있지 않은 위치로 focus
        	if(!email_check){alert("이메일 인증을 해주세요")}
        	if(!addr_check){alert("주소를 입력해주세요")}
        	if(!tel_check){$("#member_tel").focus();}
        	if(!name_check){$("#member_name").focus();}
        	if(!pw_ok_check){$("#member_pw_ok").focus();}
        	if(!pw_check){$("#member_pw").focus();}
        	if(!id_check){$("#member_id").focus();}
        	if(!reg_num_check){
        		document.getElementById("reg_num_check").style.color="red";
    	        document.getElementById("reg_num_check").innerText="사업자 등록 번호 조회를 해주세요.";
        	}
        	return false;
        }
    }
    $("input:radio").on("click",function(){
    	let selectUser = document.getElementsByClassName("selectuser")[0];
    	if($(this).val()=="ROLE_SELLER"){
    		reg_num_check=false;
	    	$(".forSeller").show();
	    	console.log(selectUser)
	    	selectUser.style.margin='30px 10px 0 80px';
	    	selectUser.style.width='80px';
	    	document.getElementsByClassName("joinbox")[0].style.height='950px';
    	}else{
    		reg_num_check=true;
	    	$(".forSeller").hide();
	    	selectUser.style.margin='30px 0 0 230px';
	    	selectUser.style.width='180px';
	    	document.getElementsByClassName("joinbox")[0].style.height='900px';
    	}
    });
    function execPostCode() {
        new daum.Postcode({
            oncomplete: function (data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if (extraRoadAddr !== '') {
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if (fullRoadAddr !== '') {
                    fullRoadAddr += extraRoadAddr;
                }
                document.getElementById('member_addr').value = fullRoadAddr;
                addr_check=true;
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                // $("[name=addr1]").val(data.zonecode);
                // $("[name=addr2]").val(fullRoadAddr);
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                // document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
                // document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress;
            }
        }).open();
    }
	$("#sellerbox").on("keyup",function(){
		reg_num_check=false;
	});
	$("#regNumCheckBtn").on("click",function(){
		var checkSum = 0;
		var checkID = [1,3,7,1,3,7,1,3,5];
		var seller_reg_num= $('input[name=seller_reg_num]').val(); 
		console.log("entered seller_reg_num : "+seller_reg_num);
		if(reg_num_check){
			document.getElementById("reg_num_check").style.color="red";
		    document.getElementsByClassName("fsellertxt")[0].style.margin="10px 0 10px 230px";
	        document.getElementById("reg_num_check").innerText="이미 인증되었습니다.";
		}else if(seller_reg_num.trim()==""){
			document.getElementById("reg_num_check").style.color="red";
		    document.getElementsByClassName("fsellertxt")[0].style.margin="10px 0 10px 230px";
	        document.getElementById("reg_num_check").innerText="사업자등록번호를 입력해주세요.";
	        reg_num_check=false;
		}else if (!/^[0-9]{3}[-][0-9]{2}[-][0-9]{5}$/.test(seller_reg_num)) { 
			document.getElementById("reg_num_check").style.color="red";
		    document.getElementsByClassName("fsellertxt")[0].style.margin="10px 0 10px 150px";
	        document.getElementById("reg_num_check").innerText="사업자등록번호가 올바르게 입력되었는지 확인해주세요.";
	    	reg_num_check=false; 
		}else{
			var reg_nums = seller_reg_num.replace(/-/gi,'');
			for (var i=0; i<9; i++) {
		    	checkSum += checkID[i] * Number(reg_nums[i]);
			}  
			if (10 - ((checkSum + Math.floor(checkID[8] * Number(reg_nums[8]) / 10)) % 10) != Number(reg_nums[9])) {
				document.getElementById("reg_num_check").style.color="red";
		        document.getElementsByClassName("fsellertxt")[0].style.margin="10px 0 0 150px";
				document.getElementById("reg_num_check").innerText="사업자등록번호가 올바르게 입력되었는지 확인해주세요.";
		   		reg_num_check=false;
			}else {
				$.ajax({
					url : '<c:url  value="/member/rest/regNumCheck" />',
					type: 'post',
					data:{
						seller_reg_num : seller_reg_num
					},
					success : function(result){
						if(result){
							document.getElementById("reg_num_check").style.color="black";
		        			document.getElementById("reg_num_check").innerText="인증되었습니다.";
							reg_num_check=true;
						}else{
							document.getElementById("reg_num_check").style.color="red";
		        			document.getElementById("reg_num_check").innerText="이미 인증된 사업자등록번호입니다.";
							reg_num_check=false;
						}
					}
				})
			}
		}
	});
	$("#certifyemail").on("click", function(){
		let member_email = document.getElementById("member_email").value
		$.ajax({
			url: '<c:url value="/member/rest/checkemail"/>',
			type:"post",
			data:{
				member_email : member_email
			},
			success : function(result){
				if(result == 1){
					alert('중복된 이메일 입니다.');
					email_check = false;
				}else{
					alert('중복되지 않는 이메일입니다.');
					email_check=true;
				}
			}
		})
	})

    </script>
    </div>
<%--     <jsp:include page="../header&footer/footer.jsp"/> --%>
</body>
</html>