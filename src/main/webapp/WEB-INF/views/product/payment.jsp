<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../header&footer/header.jsp"/>
	<c:set var="member_id" value="<sec:authentication property='principal.username'/>"/>
	<c:set var="totalPrice" value="0"/>
		<c:forEach var="ordered" items="${orderedList}">
			<c:set var="totalPrice" value="${totalPrice+ordered.ordered_price }"/>
		</c:forEach>
	<c:set var="member_id" />
	<div>
	<h1>주문이 확인되었습니다.</h1>
		주문내역 및 배송에 관한 안내는 <a href="/project/member/info">마이메뉴</a>-> 나의 구매 목록을 통하여 확인 가능합니다<br>
		주문번호 : ${orderedList[0].order_group_number}<br>
		주무일자 : ${orderedList[0].order_date}<br>
		입금자 : ${orderedList[0].orderer_name}, 계좌번호 : 신한은행  110-543-634251(언더더씨)<br>
		상품 총 가격 : ${totalPrice}<br>
		배송비 : ${orderedList[0].order_delivery_price}<br>
		결제 예정 가격 : ${totalPrice+orderedList[0].order_delivery_price}
	</div>
	

    <jsp:include page="../header&footer/footer.jsp"/>
</body>
</html>