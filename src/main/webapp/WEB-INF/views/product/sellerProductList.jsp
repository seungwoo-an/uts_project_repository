<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품조회</title>
<script src="https://kit.fontawesome.com/c2524284bc.js" crossorigin="anonymous"></script>
</head>
<script src="http://code.jquery.com/jquery-3.1.0.min.js"></script>
<body>
	<div>상품 목록</div>
	<div>
		총 등록상품<span id="total_product_count">${totalCount}</span>개
	</div>
	<form action="/project/product/deleteSellerPoduct" method="post">
	<table border="1" style="border-collapse: collapse;">
		<tr>
			<td colspan="7">
				<input type="submit" value="삭제" id="btn_delete">
			</td> 
		</tr>
		<tr>
			<th>번호</th>
			<th>
				<input type="checkbox" id="checkAll">
			</th>	
			<th>제품명</th>
			<th>상품가격</th>
			<th>재고</th>
			<th>등록일</th>
			<th>수정</th>
		</tr>
			<c:forEach var="product" items="${productList}">
		<tr>
				<td>${product.product_rn }</td>
				<td><input type="checkbox" name="checkOne" class="checkOne"> ${product.product_id} </td>
				<td>
					<img src='<c:url value="/product/img/${product.product_id}"/>' width="80px"> 
					<sapn>${product.product_name}</sapn>
					<input type="hidden" value="${product.product_id }" class="hidden_product_id" name="product_ids">
				</td>
				<td>${product.product_price}</td>
				<td>${product.product_count}</td>
				<td>${product.product_upload_date}</td>
				<td><input type="button" value="수정" ></td>
		</tr>
			</c:forEach>
			<tr id="emptyProduct" style="display: none;">
				<td colspan="7">등록된 상품이 없습니다.</td>
			</tr>
	</table>
	</form>
	                  <c:if test="${pagingManager.nowPage ne 1}">
                     <a class="a_paging" href="/project/product/sellerProductList?page=1">
                    	 <i class="fas fa-angle-double-left"></i>
                     </a>
                  </c:if> 
                  <c:if test="${pagingManager.nowBlock gt 1 }">
                     <a class="a_paging" href='/project/product/sellerProductList?page=${pagingManager.startPage-1}'>
                    	 <i class="fas fa-angle-left"></i>
                     </a>
                  </c:if> 
                  <c:forEach var="i" begin="${pagingManager.startPage}" end="${pagingManager.endPage}">
                      <a class="a_paging a_num" href='/project/product/sellerProductList?page=${i}' onclick="change_color_pagingBtn()">
                      	${i}
                      </a>
                  </c:forEach> 
                  <c:if test="${pagingManager.nowBlock lt pagingManager.totalBlock}">
                     <a class="a_paging" href="/project/product/sellerProductList?page=${pagingManager.endPage+1}">
                     	<i class="fas fa-angle-right"></i>
                     </a>
                  </c:if> 
                  <c:if test="${pagingManager.nowPage ne pagingManager.totalPage}">
                     <a class="a_paging end_paging " href="/project/product/sellerProductList?page=${pagingManager.totalPage}">
                     	<i class="fas fa-angle-double-right"></i>
                     </a>
                  </c:if>
	
	<script type="text/javascript">
		$(document).ready(function(){
			if(${totalCount eq 0}){
				$("#emptyProduct").show();
			}
			else{
				$("#emptyProduct").hide();
			}
		});
		
		//전체 선택===========================================
		let checkCnt = 0;
		$("#checkAll").click(function(){
			if($("#checkAll").prop("checked")){
				$("input[name=checkOne]").prop("checked", true);
				checkCnt = $("input[name=checkOne]").length;
				console.log(checkCnt)
			}else{
				$("input[name=checkOne]").prop("checked", false);
				checkCnt = 0;
			}
		});
		//개별 선택===========================================
		$(".checkOne").click(function(){
			if($(this).prop("checked"))checkCnt++;
			else checkCnt--;
			console.log("개별 선택 checkCnt:"+checkCnt);
			if(checkCnt==$("input[name=checkOne]").length)$("#checkAll").prop("checked",true);
			else $("#checkAll").prop("checked",false);
			
		});
		//삭제 버튼 클릭 ===========================================
		let product_ids = [];
		$("#btn_delete").click(function(){
			$(".checkOne").each(function(){
				if(!$(this).prop("checked")){
					let idx = $(".checkOne").index(this);
// 					product_ids.push(parseInt($(".hidden_product_id").get(idx).value));	
// 					console.log("idx:"+$(".hidden_product_id").get(idx).value)
					$(".hidden_product_id").get(idx).setAttribute('disabled', false);
				}
			});
			
// 			$.ajax({
// 				url: "/project/product/rest/deleteSellerProduct",
// 				type: "POST",
// 				data : {
// 					product_ids : product_ids
// 					},
// 				success : function(){
// 					$(product_ids).each(function(i) {
// 						console.log("deleted product_id : " + product_ids[i]);
// 						$(".hidden_product_id").each(function(j) {
// 							if ($(this).val() == product_ids[i]) {
// 								$(this).parent().parent().remove();
// 							}
// 						});
// 					});
// 					$("#total_product_count").text($(".checkOne").length);
// 					if($(".checkOne").length == 0){
// 						$("#emptyProduct").show();
// 						$("#checkAll").prop("checked",false);
// 					}
// 				}
// 			});
		});					
		
		
		
		
	</script>
</body>
</html>