<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/product/list.css'/>" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
    <jsp:include page="../header&footer/header.jsp"/>
    <section>
        <h1 class="productstitle">상 품 리 스 트</h1>
        <div class="main">
        <c:forEach var="product" items="${productList}">
	             <div class="productframe">
	                <div class="imgframe">
	                    <a href='<c:url value="/product/${product.product_id}"/>'>
	                    	<img class="productimg" src='<c:url value="/product/img/${product.product_id}"/>'>
	                    </a>	
	                </div>
	                <div class="productname">
	                    <label id="productname">
		                    <a href='<c:url value="/product/${product.product_id}"/>'>
		                    	${product.product_name}
		                    </a>
	                    </label>
	                </div>
	                <div class="productprice">
	                    <label id="productprice">
	                    <fmt:formatNumber value="${product.product_price }" pattern="#,###"/>원
	                    </label>
	                </div>
	            </div>
        </c:forEach>
        </div>
    </section>
    <jsp:include page ="../header&footer/footer.jsp"/>
<%-- <img class="productimg" src='<c:url value="/product/img/${product.product_id}"/>'> --%>
</body>
</html>