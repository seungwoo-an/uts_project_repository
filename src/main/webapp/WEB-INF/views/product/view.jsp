<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/product/view.css'/>" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
     .star_review_score span{
        text-decoration: none;
        color: gray;
        font-size: 20px;
    }
</style>
</head>
<body>
    <jsp:include page="../header&footer/header.jsp"></jsp:include>
    <sec:authorize access="isAuthenticated()">
	    <c:set var="member_id">
	    	<sec:authentication property="principal.username"/>
	    </c:set>
    </sec:authorize>
     <section id="view_section">
        <div class="p_product_main">
            <div class="p_product_collection">
                <div class="p_product_desc">
                    <div class="p_product_explain">
                        <div class="p_product_title">
                            <span id="title"><span id="titletext">[${sellerInfo.seller_company_name}] ${product.product_name}</span></span>
                        </div>
                        <div id="product_price_tit">
<!--                             <span class="id_product_price_won">상품 가격</span> -->
                        	<span class="id_product_price_won"><span id="id_product_price"><fmt:formatNumber value="${product.product_price}" pattern="#,###"/></span><span>원</span></span>
                        </div>
                        <div class="explain_row">
                            <span id="key"><span id="keytext">판매 단위</span></span>
                            <span id="value"><span id="text">KG</span></span>
                        </div>
                        <div class="explain_row">
                            <span id="key"><span id="keytext">판매 중량</span></span>
                            <span id="value"><span id="text">${product.product_weight}kg</span></span>
                        </div>
                        <div class="explain_row">
                            <span id="key"><span id="keytext">배송구분</span></span>
                            <span id="value"><span id="text">택배배송/퀵서비스</span></span>
                        </div>
                        <div class="explain_row">
                            <span id="key"><span id="keytext">원산지</span></span>
                            <span id="value"><span id="text">국산</span></span>
                        </div>
                        <div class="explain_row">
                            <span id="key"><span id="keytext">포장타입</span></span>
                            <span id="value"><span id="text">냉동/비닐포장</span></span>
                        </div>
                        <div class="explain_row">
                            <span id="key"><span id="keytext">유통기한</span></span>
                            <span id="value"><span id="text">수산물이므로 꼭 하루를 넘기지 마십쇼잉</span></span>
                        </div>
                        <div class="explain_row">
                           	<span id="key"><span id="keytext">구매수량</span></span>
                           	<span id="value">
                           		<span id="text">
		                            <input id="p_minus_btn" type="button" value ="-" onclick="p_count_minus()" disabled="disabled">
									<label>&nbsp;<span id="p_count_num">1</span>&nbsp;</label>
									<input id="p_plus_btn" type="button" value ="+" onclick="p_count_plus()">
								</span>
							</span>
                        </div>
                        <div class="explain_row">
                            <span id="key"><span id="keytext">배송비</span></span>
                            <span id="value">
                            	<span id="text"> 
	                        			<span id="p_delivery_price"><fmt:formatNumber value="${sellerInfo.product_delivery_price}" pattern="#,### 원"/></span>
	                        			<span id="free_del_condition">( 5만원 이상 구매 시 무료배송 )</span>
                            	</span>
                            </span>
                        </div>
                        <div id="second_div">
                        	<span class="total_price_tit">총 상품 금액 : &nbsp;
	                       		<span id= "p_tprice_value"><fmt:formatNumber value="${product.product_price}" pattern="#,###"/></span>원</span>
                        		
                        </div>
						<div align="right">
							<form name='myForm'>
								<input type="hidden" id = "pOrder_product_id" name="product_id" value="${product.product_id}">
								<input type="hidden" id = "pOrder_count" name="pOrder_count" value="">
								<input type="hidden" id = "pOrder_member_id" name="member_id" value="${member_id}">
								<input type="hidden" id="pOrder_delivery_price" name="delivery_price" value="${sellerInfo.product_delivery_price}">
								<input class="btn" type="button" value ="주문하기" onclick="redirectOrder()"> 
								<input class="btn" type="button" value ="장바구니담기" onclick="redirectInsertCart()"> 
							</form>
						</div>
                    </div>
                </div>
                <div class="p_product_pic">
                    <div class="p_pic_setting">
                        <img src='<c:url value="/product/img/${product.product_id}"/>'>
                    </div>
                </div>
            </div>
        </div>
		<div class= "p_product_explain2">
			<nav class="container">
			   <div class="tab_class" id="tab1"></div> 
			   <ul class="tab">
			      <li><a href="#tab1" class="on">상품 설명</a></li>
			      <li><a href="#tab2">업체 정보</a></li>
			      <li><a href="#tab3">고객 후기(<span id="reviewCounts">${reviewPagingManager.totalCount}</span>)</a></li>
			      <li><a href="#tab4">상품 문의()</a></li>
			   </ul>
			    <ul class="panel">
			         <li>${product.product_info }</li>
			    </ul>
			   <div class="tab_class" id="tab2"></div>
			   <ul class="tab">
			      <li><a href="#tab1" >상품 설명</a></li>
			      <li><a href="#tab2" class="on">업체 정보</a></li>
			      <li><a href="#tab3">고객 후기(<span id="reviewCounts">${reviewPagingManager.totalCount}</span>)</a></li>
			      <li><a href="#tab4">상품 문의()</a></li>
			   </ul>
			    <ul class="panel">
			         <li>
			         	<div class="sub_title">▶ 업체 정보</div>
						<table class="table_seller_info" border="1">
							<tr>
								<td>사업자 등록 번호</td>
								<td>${sellerInfo.seller_reg_num}</td>
							</tr>
							<tr>
								<td>사업장명</td>
								<td>${sellerInfo.seller_company_name}</td>
							</tr>
							<tr>
								<td>대표</td>
								<td>${sellerInfo.seller_company_head_name}</td>
							</tr>
							<tr>
								<td>회사 안내 사항</td>
								<td>${sellerInfo.seller_company_info}</td>
							</tr>
							<tr>
								<td>고객 상담 센터</td>
								<td>${sellerInfo.seller_company_tel}</td>
							</tr>
							<tr>
								<td>이메일 문의</td>
								<td>${sellerInfo.seller_company_email }</td>
							</tr>
							<tr>
								<td>주소</td>
								<td>${sellerInfo.seller_company_main_address} ${sellerInfo.seller_company_sub_address }</td>
							</tr>
						</table>
						
						
						
			         </li>
			    </ul>
			   <div class="tab_class" id="tab3"></div>
			   <ul class="tab">
			      <li><a href="#tab1" >상품 설명</a></li>
			      <li><a href="#tab2">업체 정보</a></li>
			      <li><a href="#tab3" class="on">고객 후기(<span id="reviewCounts">${reviewPagingManager.totalCount}</span>)</a></li>
			      <li><a href="#tab4">상품 문의()</a></li>
			   </ul>
			   <script type="text/javascript">
			   $(window).on("load",function(){
					let reviewRequest = '${reviewRequest}';
					let qnaRequest = '${qnaRequest}';
					if(reviewRequest=="reviewRequest"){
						location.href="#tab3";
					}
					if(qnaRequest=='qnaRequest'){
						location.href="#tab4";
					}
				});
			   </script>
			   <ul class="panel" id=custommer_ul>
		         <li> 
		         <div class="sub_title" >▶ 고객 후기</div>
	         		<table class ="table_review">
	         			<tr class="view_tr">
	         				<th>번호</th>
	         				<th>별점</th>
	         				<th>제목</th>
	         				<th>작성자</th>
	         				<th>작성일</th>
	         				<th>조회</th>
	         			</tr>
			         	<tbody id="tbody">
				         	<c:forEach var="review" items="${reviewList}">
				         		<tr>
				         			<td id="tr_review_number" align="center">${review.review_number }</td>
				         			<td align="center">
				         				<input type="hidden" value="${review.review_score}" class="review_score">
					         			<p class="star_review_score">
									        <span>★</span>
									        <span>★</span>
									        <span>★</span>
									        <span>★</span>
									        <span>★</span>
									    </p>
								    <script type="text/javascript">
								    $(document).ready(function(){
							            $(".star_review_score").each(function(){
							            	var idx = $(".star_review_score").index(this);
							            	var review_score = $(".review_score").get(idx).value;
							            	for(var i=0;i<review_score;i++){
							            		$(this).children("span")[i].style.color="#eabf0f";
							            	}
							            });
							        });
								    </script>
				         			</td>
				         			<td class="class_review_tit">${review.review_title}</td>
				         			<td align="center">${review.member_id }</td>
				         			<td align="center">
				         			<fmt:formatDate value="${review.review_date }" pattern="yyyy.MM.dd HH:mm"/>
				         			</td>
				         			<td align="center">${review.review_views }</td>
				         		</tr>
				         		<tr style="display:none" class="class_review_content">
				         			<td colspan="6" align="left" style="padding: 20px;">
				         				<c:if test="${not empty review.review_img}">
				         					<img src="<c:url value='/board/review/img?product_id=${product.product_id}&review_number=${review.review_number}'/>" width="100px" height="100px"/>
				         				</c:if>
				         				${review.review_content}
				         			</td>
				         		</tr>
				         	</c:forEach>
			         	</tbody>
			         	<tr>
			         		<td colspan="6" align="center">
			         		<div>
			         			<c:if test="${reviewPagingManager.nowPage gt 1 }">
			         				<a class="a_paging" href = '<c:url value="/product/${product.product_id}?reviewPage=1"/>'>처음</a>
				                </c:if>
				                <c:if test="${reviewPagingManager.nowBlock gt 1 }">
			         				<a class="a_paging" href = '<c:url value="/product/${product.product_id}?reviewPage=${reviewPagingManager.startPage-1}"/>'>이전</a>
				                </c:if>
				                <c:forEach var="i" begin="${reviewPagingManager.startPage}" end="${reviewPagingManager.endPage}">
			         				<a class="a_paging a_num" href = '<c:url value="/product/${product.product_id}?reviewPage=${i}"/>'>${i}</a>
				                </c:forEach> 
				                <c:if test="${reviewPagingManager.nowBlock lt reviewPagingManager.totalBlock}">
			         				<a class="a_paging" href = '<c:url value="/product/${product.product_id}?reviewPage=${reviewPagingManager.endPage+1}"/>'>다음</a>
				                </c:if>
				                <c:if test="${reviewPagingManager.nowPage lt reviewPagingManager.totalPage}">
			         				<a href = '<c:url value="/product/${product.product_id}?reviewPage=${reviewPagingManager.totalPage}"/>'>끝</a>
				                </c:if>
				            </div>
			         		</td>
			         	</tr>
	         		</table>
		          </li>
			   </ul>
			   <div class="tab_class" id="tab4"></div>
			   <ul class="tab">
			      <li><a href="#tab1">상품 설명</a></li>
			      <li><a href="#tab2">업체 정보</a></li>
			      <li><a href="#tab3">고객 후기(<span id="reviewCounts">${reviewPagingManager.totalCount}</span>)</a></li>
			      <li><a href="#tab4" class="on">상품 문의()</a></li>
			   </ul>
			   <ul class="panel" id=product_Q_N_A>
			         <li>
			         	<div id=qna_title>
				         	<h3>PRODUCT Q&A</h3>
			         	</div>
						<div id=insert_qna>
	         				<input type="button" onclick="qnaPop()" value="상품문의">
						</div>
						<table>
		         			<tr>
		         				<th>번호</th>
		         				<th>카테고리</th>
		         				<th width="400">제목</th>
		         				<th>작성자</th>
		         				<th>작성일</th>
		         			</tr>
			         		<c:forEach var="qna" items="${qnaList}">
			         		<tr>
								<td>${qna.q_rn}</td>
								<td>${qna.q_category}</td>
								<td>${qna.q_title}</td>
								<td>${qna.member_id}</td>
								<td>${qna.q_date}</td>
			         		</tr>
			         		</c:forEach>
				         	<tr>
				         		<td colspan="6">
						         	<div>
				         			<c:if test="${qnaPagingManager.nowPage gt 1 }">
				         				<a href = '<c:url value="/product/${product.product_id}?qnaPage=1"/>'>처음</a>
					                </c:if>
					                <c:if test="${qnaPagingManager.nowBlock gt 1 }">
				         				<a href = '<c:url value="/product/${product.product_id}?qnaPage=${qnaPagingManager.startPage-1}"/>'>이전</a>
					                </c:if>
					                <c:forEach var="i" begin="${qnaPagingManager.startPage}" end="${qnaPagingManager.endPage}">
				         				<a href = '<c:url value="/product/${product.product_id}?qnaPage=${i}"/>'>${i}</a>
					                </c:forEach> 
					                <c:if test="${qnaPagingManager.nowBlock lt qnaPagingManager.totalBlock}">
				         				<a href = '<c:url value="/product/${product.product_id}?qnaPage=${qnaPagingManager.endPage+1}"/>'>다음</a>
					                </c:if>
					                <c:if test="${qnaPagingManager.nowPage lt qnaPagingManager.totalPage}">
				         				<a href = '<c:url value="/product/${product.product_id}?qnaPage=${qnaPagingManager.totalPage}"/>'>끝</a>
					                </c:if>
					         		</div>
				         		</td>
				         	</tr>
		         		</table>
		         		<div id=qna_desc>
		         			상품에 대한 문의를 남기는 공간입니다.<br>
		         			 해당 게시판의 성격과 다른 글은 사전동의 없이 담당 게시판으로 이동될 수 있습니다.<br>
							배송관련, 주문(취소/교환/환불)관련 문의 및 요청사항은 마이컬리 내 1:1 문의에 남겨주세요.
		         		</div>
		         		
			         </li>
			   </ul>
			</nav>
        </div>
        	
    </section>
<hr>
</body>
<script type="text/javascript">
		let product_id = document.getElementById("pOrder_product_id").value;
		let member_id = document.getElementById("pOrder_member_id").value;
		let p_num = parseInt(document.getElementById("p_count_num").innerText);
		let originalPrice = parseInt('${product.product_price}');
		let deliveryPrice = parseInt('${sellerInfo.product_delivery_price}');
		console.log("product_id : " + product_id);
		console.log("member_id : "+member_id);
		console.log("p_num : "+p_num);
		console.log("originalPrice : " + originalPrice);
	function p_count_plus() {
		document.getElementById("p_minus_btn").disabled=false;
		p_num += 1;
		document.getElementById("p_count_num").innerText=p_num;
		document.getElementById("p_tprice_value").innerText=(originalPrice*p_num).toLocaleString()+" 원";
		if(originalPrice*p_num>=50000){
			document.getElementById("p_delivery_price").innerText='무료배송';
			document.getElementById("free_del_condition").innerText='';
			document.getElementById("pOrder_delivery_price").value=0;
		}
	}
	function p_count_minus() {
		if(p_num > 1){
			p_num -= 1;
			if(p_num == 1){
			document.getElementById("p_minus_btn").disabled="disabled";
			}
		document.getElementById("p_count_num").innerText=p_num;
		document.getElementById("p_tprice_value").innerText=(originalPrice*parseInt(p_num)).toLocaleString();
		if(originalPrice*p_num<50000){
			document.getElementById("p_delivery_price").innerText=deliveryPrice.toLocaleString()+" 원";
			document.getElementById("free_del_condition").innerText='( 5만원 이상 구매 시 무료배송 )';
			document.getElementById("pOrder_delivery_price").value=deliveryPrice;
		}
		}
	}
	function redirectOrder(){
//	 	주문서로 이동하는 JS 메소드
//		주문 전 카트에 해당 상품이 저장되어있는지 확인
		$.ajax({
			url:'<c:url value="/product/rest/cartCheck"/>',
			type:'POST',
			data : {
				member_id : member_id,
				product_id : product_id
			},
			success:function(data){
				if(data==1){
					document.getElementById("pOrder_count").value = p_num;
					document.myForm.action = '<c:url value="/product/ordersheet"/>';
					document.myForm.method = 'post';
					document.myForm.submit();
				}else{
					let ans = confirm("이미 동일한 상품이 장바구니에 존재합니다.\n장바구니로 이동하시겠습니까?");
					if(ans){
						location.href="<c:url value='/product/cart/'/>";
					}
				}
			},
			error:function(){
				alert("오류")
			}
		})
	}
	
	function redirectInsertCart(){
		var cartData = $("form[name=myForm]").serialize();
		$.ajax({
			url: '<c:url value="/product/rest/insertCart"/>',
			type : "POST",
			data : {
				"member_id" : member_id,
				"product_id" : product_id,
				"pOrder_count" : p_num,
				pOrder_delivery_price : deliveryPrice
				
			},
			success : function(data){
				if(data==1){
					let ans = confirm("장바구니 담기에 성공했습니다.\n장바구니로 이동하시겠습니까?");
					if(ans){
						location.href="<c:url value='/product/cart/'/>";
					}
				}else{
					alert("이미 동일한 상품이 장바구니에 존재합니다.");
				}
				// 자바스크립트 모션넣어주세요!!
			},error : function(){
				alert("오류")
			}
		});
	};
	$(".class_review_tit").on("click",function(){
		if($(this).parent().next().attr("style")=="display:none"){
			console.log($(this).parent().next().attr("style"));
			$(this).parent().next().attr("style","display:");
		}else{
			console.log($(this).parent().next().attr("style"));
			$(this).parent().next().attr("style","display:none");
		}
	});
	function qnaPop(){
		window.open("/project/board/qna/form/"+product_id,"page", "width=600, height=800, resizable = no, scrollbars = no");  
	}
	
	
</script>
</html>