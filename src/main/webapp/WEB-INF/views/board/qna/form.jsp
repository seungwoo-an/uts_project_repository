<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<body>
<c:set var="member_id">
	<sec:authentication property="principal.username"/>
</c:set>
<div>
	<h1>상품문의 게시판</h1>
	상품에 대해서 궁금한 것이 있으면 언제든지 문의하세요. 빠르게 답변 드리겠습니다.
</div>
<div>
	<img src="<c:url value='/product/img/${product.product_id}'/>">
	<span>상품명 : [${sellerInfo.seller_company_name}]${product.product_name}</span>
	<span>상품 가격 : <fmt:formatNumber value="${product.product_price}" pattern="#,###"/></span>
</div>
<div>
	<form id="qnaForm">
		<table>
			<tr>
				<th>*제목</th>
				<td><input type="text" name="q_title" value="상품 문의입니다."></td>
				<th>*카테고리</th>
				<td>
					<select name="q_category">
						<option value="상품" selected>상품</option>
						<option value="배송">배송</option>
						<option value="기타">기타</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>*내용</th>
				<td colspan="3"><textarea name="q_content"></textarea></td>
			</tr>
			<tr>
				<td><input type="button" id="qnaInsertBtn" value="작성완료"></td>
			</tr>
		</table>
	</form>
</div>
<jsp:include page="../../header&footer/footer.jsp"/>
<script type="text/javascript">
$("#qnaInsertBtn").on("click",function(){
	let q_title = $("input[name=q_title]").val();
	let q_category = $("select option:selected").val();
	let q_content = $("textarea").val();
	let member_id = '${member_id}';
	let product_id = '${product.product_id}';
	console.log(q_title);
	console.log(q_category);
	console.log(q_content);
	if(q_title.trim()==""){
		return;
	}
	if(q_category.trim()==""){
		return;
	}
	if(q_content.trim()==""){
		return;
	}
	let qnaForm = $("form#qnaForm")[0];
	console.log(qnaForm);
	let formData = new FormData(qnaForm);
	console.log(formData);
$.ajax({
    url:'<c:url value="/board/rest/qna/insert"/>',
    type:'POST',
    data:{
    	q_title:q_title,
    	q_category:q_category,
    	q_content:q_content,
    	member_id:member_id,
    	product_id:product_id
    },
    success:function(){
    	opener.location.reload();
        self.close();
    },error:function(e){
    	console.log("error : "+e)
    }
});
});
</script>
</body>
</html>