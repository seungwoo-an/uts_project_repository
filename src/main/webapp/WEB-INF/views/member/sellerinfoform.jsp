	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 주소 찾기 api -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<%-- <jsp:include page="../header&footer/header.jsp" /> --%>

<%-- ${sellerInfo.member_id}<br> --%>
<%-- ${sellerInfo.seller_reg_num}<br> --%>
<%-- ${sellerInfo.seller_company_info}<br> --%>
<%-- ${sellerInfo.seller_company_tel}<br> --%>
<%-- ${sellerInfo.seller_company_main_address }<br> --%>
<%-- ${sellerInfo.seller_company_sub_address }<br> --%>
<%-- ${sellerInfo.seller_company_email }<br> --%>
<%-- ${sellerInfo.seller_company_name}<br> --%>
<%-- ${sellerInfo.seller_company_head_name}<br> --%>

<form action='<c:url value="/member/sellerinfoupdate"/>' method="post">
<table border="1" style="border-collapse:collapse;">
	<tr>
		<th>사업자등록번호</th>
		<td>
			${sellerInfo.seller_reg_num}
			<input type="hidden" name="seller_reg_num" value="${sellerInfo.seller_reg_num}">
			<input type="hidden" name="member_id" value="${sellerInfo.member_id}">
		</td>
	</tr>
	<tr>
		<th>상호명</th>
		<td>
			<input type="text" name="seller_company_name" value="${sellerInfo.seller_company_name}" ${empty sellerInfo.seller_company_name ? "":"readonly"}>
			<span id="span_seller_company_name"></span>
		</td>
	</tr>
	<tr>
		<th>사업장 대표명</th>
		<td>
			<input type="text" name="seller_company_head_name" value="${sellerInfo.seller_company_head_name}">
			<span id="span_seller_company_head_name"></span>	
		</td>
	</tr>
	<tr>
		<th>사업장 주소</th>
		<td>
			<div>
				<input type="text" name="seller_company_main_address" readonly id="seller_company_main_address" value="${sellerInfo.seller_company_main_address}">
				<input type="button" value="주소 검색" onclick="execPostCode();">
				<span id="span_seller_company_main_address"></span>
			</div>
			<div>
				<input type="text" name="seller_company_sub_address" placeholder="상세 주소를 입력하세요 *(없으면 생략가능)" value="${sellerInfo.seller_company_sub_address}">
			</div>
		</td>
	</tr>
	<tr>
		<th>대표 이메일</th>
		<td>
			<input type="text" name="seller_company_email" value="${sellerInfo.seller_company_email}">
			<span id="span_seller_company_email"></span>
		</td>
	</tr>
	<tr>
		<th>대표 전화</th>
		<td>
			<input type="text" name="seller_company_tel" value="${sellerInfo.seller_company_tel}">
			<span id="span_seller_company_tel"></span>
		</td>
	</tr>
	<tr>
		<th>상품 배송비</th>
		<td>
			<input type="text" name="product_delivery_price" value="${sellerInfo.product_delivery_price}" placeholder="미입력 시 기본 배송료 0원">
		</td>
	</tr>
	<tr>
		<th>회사 소개</th>
		<td>
			<textarea rows="30" cols="30" name="seller_company_info" id="seller_company_info">
				${sellerInfo.seller_company_info}
			</textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2"><input type="button" value="저장" onclick="sellerInfoOk(this.form)"><input type="reset" value="취소"></td>
	</tr>
</table>
</form>
<jsp:include page ="../header&footer/footer.jsp"/>
<script type="text/javascript">
function sellerInfoOk(form){
	let nameCheck = false;
	let headNameCheck = false;
	let mainAddrCheck = false;
	let emailCheck = false;
	let telCheck = false;
	
	let seller_company_name = form.seller_company_name.value;
	let seller_company_head_name = form.seller_company_head_name.value;
	let seller_company_main_address = form.seller_company_main_address.value;
	let seller_company_email = form.seller_company_email.value;
	let seller_company_tel = form.seller_company_tel.value;
	let product_delivery_price = form.product_delivery_price.value;
	
	if(seller_company_name.trim()==""){
		document.getElementById("span_seller_company_name").innerText="필수항목입니다.";
		document.getElementById("span_seller_company_name").style.color="red";
		nameCheck = false;
	}else{
		document.getElementById("span_seller_company_name").innerText="";
		nameCheck = true;
	}
	
	if(seller_company_head_name.trim()==""){
		document.getElementById("span_seller_company_head_name").innerText="필수항목입니다.";
		document.getElementById("span_seller_company_head_name").style.color="red";
		headNameCheck = false;	
	}else{
		document.getElementById("span_seller_company_head_name").innerText="";
		headNameCheck = true;
	}
	
	if(seller_company_main_address.trim()==""){
		document.getElementById("span_seller_company_main_address").innerText="필수항목입니다.";
		document.getElementById("span_seller_company_main_address").style.color="red";
		mainAddrCheck = false;
	}else{
		document.getElementById("span_seller_company_main_address").innerText="";
		mainAddrCheck = true;
	}
	
	if(seller_company_email.trim()==""){
		document.getElementById("span_seller_company_email").innerText="필수항목입니다.";
		document.getElementById("span_seller_company_email").style.color="red";
		emailCheck = false;
	}else if(!/^[a-z0-9._%+-]+@[a-z]+\.[a-z]{2,3}$/.test(seller_company_email)){
		document.getElementById("span_seller_company_email").innerText="올바르지 않은 이메일 형식입니다.";
		document.getElementById("span_seller_company_email").style.color="red";
		emailCheck = false;
	}else{
		document.getElementById("span_seller_company_email").innerText="";
		emailCheck = true;
	}
	
	if(seller_company_tel.trim()==""){
		document.getElementById("span_seller_company_tel").innerText="필수항목입니다.";
		document.getElementById("span_seller_company_tel").style.color="red";
		telCheck = false;
	}else if(!/^[0][1]\d{1}\d{3,4}\d{4}$/.test(seller_company_tel)){
		document.getElementById("span_seller_company_tel").innerText="올바르지 않은 전화번호 형식입니다.";
		document.getElementById("span_seller_company_tel").style.color="red";
		telCheck = false;
	}else{
		document.getElementById("span_seller_company_tel").innerText="";
		telCheck = true;
	}if(product_delivery_price.trim()==""){
		form.product_delivery_price.value=0;
	}
	if(nameCheck&&headNameCheck&&mainAddrCheck&&emailCheck&&telCheck)form.submit();
}

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
            document.getElementById('seller_company_main_address').value = fullRoadAddr;
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            // $("[name=addr1]").val(data.zonecode);
            // $("[name=addr2]").val(fullRoadAddr);
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            // document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
            // document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress;
        }
    }).open();
}
</script>
</body>
</html>