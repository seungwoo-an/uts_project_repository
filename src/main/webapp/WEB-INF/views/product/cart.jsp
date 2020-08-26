<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    <%@ taglib uri = "http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="<c:url value='/resources/css/product/cart.css'/>" />
</head>
<body>
<c:set var="member_id">
	<sec:authentication property="principal.username"/>
</c:set>
<jsp:include page="../header&footer/header.jsp"></jsp:include>
<div id=cart_div>
<div>
<div ID=cart_table_div>
<h1>장바구니</h1>
<h5>주문하실 상품명 및 수량을 정확하게 확인해 주세요.</h5>
<table id="outerTable">
	<tr id="outerTable_first_tr">
		<th><label>&nbsp;<input type="checkbox" class="checkAll">&nbsp;&nbsp;전체선택(<span class="checkedLength"></span>/<span class="restListLength"></span>)</label></th>		
		<th>상품정보</th>
		<th>수량</th>
		<th>금액</th>
		<th></th>
	</tr>
	<tr id="emptyList" style="display:none;">
		<td colspan="6" align="center" id="td_emptyList">장바구니에 등록된 상품이 없습니다.</td>
	</tr>
	<c:forEach var="cartList" items="${cartLists}" varStatus="status">
	<tr>
		<td colspan="5" id=subTable>
			<table class="innerTable"  id="${status.index}" >
				<c:set var="totalPriceForEachCompany" value="0"/>
				<c:forEach var="cart" items="${cartList}">
				<tr class="trForEachCompany">
					<th>
						<input type="checkbox" class="checkOne">
					</th>
					<td>
						<img src="/project/product/img/${cart.product_id}" width="200px">
					</td>
					<td>
						<span><h4>[${cart.seller_company_name}]${cart.product_name}</h4></span><br>
						<span class="productPrice"><fmt:formatNumber value="${cart.product_price}" pattern="#,###"/> 원</span>
					</td>
					<td>
						<section id=product_section_css>
						<input type="button" value="-" class="minusBtn">
						<input type="text" class="cartProductCount" value="${cart.cart_product_count}">
						<input type="button" value="+" class="plusBtn">
						<input type="hidden" value="${status.index}" class="innerTableId">
						</section>
					</td>
					<td>
						<span class="productTotalPrice">
							<fmt:formatNumber value="${cart.product_total_price}" pattern="#,###"/> 원
						</span>
					</td>
					<th>
						<input type="button" value="x" class="deleteOne">
						<input type="hidden" value="${cart.product_id}" class="product_ids">
					</th>
				</tr>
				<c:set var="totalPriceForEachCompany" value="${totalPriceForEachCompany+cart.product_total_price}"/>
				</c:forEach>
<!-- 				<tr> -->
<!-- 					<td colspan="6" style="padding-left: 20px;"> -->
<!-- 						<label id=select_all_label><input type="checkbox" class="checkAll"> &nbsp;전체선택(<span class="checkedLength"></span>/<span class="restListLength"></span>)</label> -->
<!-- 					</td> -->
<!-- 				</tr> -->
				<tr>
					<td colspan="6">
					<section>
					<section>
					<div>
						<div>
						상품 가격 : &nbsp;&nbsp;
							<span class="totalPriceForEachCompany">
								<fmt:formatNumber value="${totalPriceForEachCompany}" pattern="#,###"/>
							</span>원<br>
						</div>
					</div>
					<div>
						<div>
						<span id="del_tit">배송비:</span>
							<span class="productDeliveryPrice" style="display:none;">
								<fmt:formatNumber value="${cartList[0].product_delivery_price}" pattern="#,###"/>
							</span><span class="freeDeliveryWon" style="display: none;">원</span>
						<span class="freeDelivery" style="display:none;">
							무료배송
						</span>
						</div>
					</div>
					<div>
					
					</div>
					</section>
					</section>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	</c:forEach>
</table>
</div>
<div id="div_btn">
	<input type="button" class="cart_btn" id="deleteSelected" value="선택삭제">
</div>
<div>
	<div id="notEmptyList">
		<table id="total_price_table">
			<tr>
				<td> 상품금액</td>
				<td><span id="totalPriceWithoutDel"></span>원</td>
			</tr>
			<tr>
				<td>+ 배송비</td>
				<td><span id="totalDel"></span>원</td>
			</tr>
			<tr>
				<td>결제예정금액</td>
				<td><span id="totalPriceWithDel"></span>원</td>
			</tr>
		</table>
	</div>
	<div align="center">
		<input type="button" class="cart_btn" value="주문하기" id="orderBtn">
	</div>
</div>
</div>
</div>
<jsp:include page ="../header&footer/footer.jsp"/>
<script type="text/javascript">
	let member_id = '${member_id}';
	let checkOneLength = $(".checkOne").length;
	console.log("first checkOneLength : "+checkOneLength);
	$(document).ready(function(){
		$(".checkAll").prop("checked",true);
		$(".checkOne").prop("checked",true);
		documentCheck();
	});
	function documentCheck(){
		let totalPriceWithoutDel=0;
		let totalDel=0;
		let totalPriceWithDel=0;
		let checkedLength=0;
		if($(".checkOne").length==0){
			$(".checkAll").prop("disabled",true);
			$("#orderBtn").prop("disabled",true);
			$("#orderBtn").css("backgroundColor","#ddd");
			$("#orderBtn").css("border","none");
			$("#deleteSelected").prop("disabled",true);
			$("#deleteSelected").css("backgroundColor","#ddd");
			$("#deleteSelected").css("border","none");
			$("#notEmptyList").hide();
			$("#emptyList").show();
		}
		$(".restListLength").text($(".checkOne").length);
		$(".checkOne").each(function(){
			if($(this).prop("checked")){
				checkedLength++;
			}
		});
		$(".checkedLength").text(checkedLength);
		$("table table").each(function(){
			let idx = $(this).attr("id");
			console.log("idx : " +$(this).attr("id"));
			let totalPriceForEachCompany=0;
			$("table table#"+idx+" input:checkbox.checkOne").each(function(){
				if($(this).prop("checked")){
					let checkIdx = $("table table#"+idx+" input:checkbox.checkOne").index(this);
					totalPriceForEachCompany+=parseInt($("table table#"+idx+" span.productTotalPrice").get(checkIdx).innerText.replace(/,/gi,""));
				}
			});
			console.log(totalPriceForEachCompany)
			$("table table#"+idx+" .totalPriceForEachCompany").text(totalPriceForEachCompany.toLocaleString());
			totalPriceWithoutDel+=totalPriceForEachCompany;
		});		
		
		$(".totalPriceForEachCompany").each(function(){
				let idx = $(".totalPriceForEachCompany").index(this);
				let productDeliveryPrice = parseInt($(".productDeliveryPrice").get(idx).innerText.replace(/,/gi,""));
			if($(this).text().replace(/,/gi,"")>=50000){
				$(".productDeliveryPrice").get(idx).style.display="none";
				$(".freeDelivery").get(idx).style.display="inline-block";
				$(".freeDeliveryWon").get(idx).style.display="none";
			}else if(0<$(this).text().replace(/,/gi,"") && $(this).text().replace(/,/gi,"")<50000){
				$(".productDeliveryPrice").get(idx).style.display="inline-block";
				$(".freeDelivery").get(idx).style.display="none";
				$(".freeDeliveryWon").get(idx).style.display="inline-block";
			//상점당 총액이 0일때
			}else{
				$(".productDeliveryPrice").get(idx).style.display="none";
				$(".freeDelivery").get(idx).style.display="inline-block";
				$(".freeDeliveryWon").get(idx).style.display="none";
			}
		});
		$(".productDeliveryPrice").each(function(){
			let idx =$(".productDeliveryPrice").index(this);
			if($(".freeDelivery").get(idx).style.display=="none"){
				totalDel+=parseInt($(this).text().replace(/,/gi,""));
			}
		});
		totalPriceWithDel = totalPriceWithoutDel+totalDel;
		$("#totalPriceWithoutDel").text(totalPriceWithoutDel.toLocaleString());
		$("#totalDel").text(totalDel.toLocaleString());
		$("#totalPriceWithDel").text(totalPriceWithDel.toLocaleString());
	}
	//plus 버튼 조작
	$(".plusBtn").on("click",function(){
		let idx =$(".plusBtn").index(this);
		let cnt = parseInt($(".cartProductCount").get(idx).value);
		if(cnt<10){
			let productTotalPrice = parseInt($(".productTotalPrice").get(idx).innerText.replace(/,/gi,""));
			let productPrice = parseInt($(".productPrice").get(idx).innerText.replace(/,/gi,""));
			let innerTableId = $(".innerTableId").get(idx).value;
			let totalPriceForEachCompany = parseInt($(".innerTable#"+innerTableId+" tr:last-child span.totalPriceForEachCompany").text().trim().replace(/,/gi,""));
			//갯수 변경
			cnt++;
			$(".cartProductCount").get(idx).value=cnt;
			//상품 개당 총금액 변경
			$(".productTotalPrice").get(idx).innerText=(productTotalPrice+productPrice).toLocaleString()+" 원";
			//상점 당 금액 변경
			documentCheck();
		}
	});
	//minus 버튼 조작
	$(".minusBtn").on("click",function(){
		let idx =$(".minusBtn").index(this); 
		let cnt = parseInt($(".cartProductCount").get(idx).value);
		if(cnt>1){
			let productTotalPrice = parseInt($(".productTotalPrice").get(idx).innerText.replace(/,/gi,""));
			let productPrice = parseInt($(".productPrice").get(idx).innerText.replace(/,/gi,""));
			let innerTableId = $(".innerTableId").get(idx).value;
			let totalPriceForEachCompany = parseInt($(".innerTable#"+innerTableId+" tr:last-child span.totalPriceForEachCompany").text().trim().replace(/,/gi,""));
			//갯수 변경
			cnt--;
			$(".cartProductCount").get(idx).value=cnt;
			//상품 개당 총금액 변경
			$(".productTotalPrice").get(idx).innerText=(productTotalPrice-productPrice).toLocaleString()+" 원";
			//상점 당 금액 변경
			documentCheck();
		}
	});
	//개별 삭제
	$(".deleteOne").on("click",function(){
		let idx =$(".deleteOne").index(this);
		let product_ids = [];
		product_ids.push(parseInt($(".product_ids").get(idx).value));
		$.ajax({
			url:'/project/product/rest/deleteFromCart',
			type:'POST',
			data:{
				member_id:member_id,
				product_ids:product_ids
			},success:function(){
				//테이블 길이 확인
				let innerTableId = $(".innerTableId").get(idx).value;
				let innerTableLength = $(".innerTable#"+innerTableId+" tr.trForEachCompany").length;
				//전체 상품가격에서 차감
				if($(".checkOne").get(idx).checked){
					let productTotalPrice = parseInt($(".productTotalPrice").get(idx).innerText.replace(/,/gi,""));
					let totalPriceForEachCompany = parseInt($(".innerTable#"+innerTableId+" tr:last-child span.totalPriceForEachCompany").text().trim().replace(/,/gi,""));
					$(".innerTable#"+innerTableId+" tr:last-child span.totalPriceForEachCompany").text((totalPriceForEachCompany-productTotalPrice).toLocaleString());
				}
				//해당 열 삭제
				$(".trForEachCompany").get(idx).remove();
				if(innerTableLength-1==0){
					$(".innerTable#"+innerTableId).remove();
				}
				checkOneLength--;
				console.log("checkOneLength: "+checkOneLength);
				documentCheck();
			},error:function(){
				alert("no~~");
			}
		})
	});
	//선택 삭제
	$("#deleteSelected").on("click",function(){
		let product_ids = [];
		$(".checkOne").each(function(){
			if($(this).prop("checked")){
				let idx = $(".checkOne").index(this);
				product_ids.push(parseInt($(".product_ids").get(idx).value));
			}
		});
		console.log("product_ids : "+product_ids);
		if(product_ids.length!=0){
			$.ajax({
				url:'/project/product/rest/deleteFromCart',
				type:'POST',
				data:{
					member_id:member_id,
					product_ids:product_ids
				},success:function(){
					$(product_ids).each(function(i){
						$(".product_ids").each(function(j){
							if($(this).val()==product_ids[i]){
								let innerTableId = $(".innerTableId").get(j).value;
								let innerTableLength = $(".innerTable#"+innerTableId+" tr.trForEachCompany").length;
								$(".trForEachCompany").get(j).remove();
								if(innerTableLength-1==0){
									$(".innerTable#"+innerTableId).remove();
								}
							}
						});
					});
					checkOneLength-=product_ids.length;
					console.log("checkOneLenghth : "+checkOneLength);
					documentCheck();
				},error:function(){
					alert("no~~");
				}
			});
		}
	});
	$(".checkAll").on("click",function(){
		if($(this).prop("checked")){
			$(".checkOne").prop("checked",true);
			$(".checkAll").prop("checked",true);
			checkOneLength = $(".checkOne").length;
		}else{
			$(".checkOne").prop("checked",false);
			$(".checkAll").prop("checked",false);
			checkOneLength = 0;
		}
		documentCheck();
	});
	$(".checkOne").on("click",function(){
		if($(this).prop("checked"))checkOneLength++;
		else checkOneLength--;
		if(checkOneLength==$(".checkOne").length)$(".checkAll").prop("checked",true);
		else $(".checkAll").prop("checked",false);
		documentCheck();
	});
	$("#orderBtn").on("click",function(){
		let product_ids = [];
		let cart_product_counts = [];
		let cart_delivery_price= parseInt($("#totalDel").text().replace(/,/gi,""));
		$(".checkOne").each(function(){
			if($(this).prop("checked")){
				let idx = $(".checkOne").index(this);
				product_ids.push(parseInt($(".product_ids").get(idx).value));
				cart_product_counts.push(parseInt($(".cartProductCount").get(idx).value));
			}
		});
		$.ajax({
			url:"/project/product/rest/updateCart",
			type:"POST",
			data:{
				member_id:member_id,
				product_ids:product_ids,
				cart_product_counts:cart_product_counts,
				cart_delivery_price:cart_delivery_price
			},success:function(){
				 let order_form = document.createElement("form");
				 order_form.name = "order_form";
	             order_form.action = '/project/product/ordersheet';
	             order_form.method = "post";
	             let input_product_ids = document.createElement("input");
	             let input_member_id = document.createElement("input");
	             input_product_ids.setAttribute("type", 'hidden');
	             input_member_id.setAttribute("type", 'hidden');
	             input_product_ids.setAttribute("name","product_ids");
	             input_member_id.setAttribute("name","member_id");
	             input_product_ids.setAttribute("value",product_ids);
	             input_member_id.setAttribute("value",member_id);
	             order_form.appendChild(input_product_ids);
	             order_form.appendChild(input_member_id);
	             document.body.appendChild(order_form);
	             order_form.submit();
			},error:function(e){
				alert("error"+e)
			}
		});
	});
</script>
</body>
</html>