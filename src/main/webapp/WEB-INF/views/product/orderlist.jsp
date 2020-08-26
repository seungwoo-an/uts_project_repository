<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/product/orderlist.css'/>" />
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">

</head>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<body>
   <c:set var="member_id">
        <sec:authentication property="principal.username" />
    </c:set>
<%--     <jsp:include page="../header&footer/header.jsp" /> --%>
    <!-- 주문내역에서 필요한 것들 -->
    <!-- 사진, 결제방법 -->
    <c:set var="totalCost" value="0" />
	    <div class="orderlist_section">
	        <div class="orderlist_tit">주문 내역</div>
	        <c:choose>
	            <c:when test="${not empty orderLists}">
	                <section>
	                    <c:forEach var="orderList" items="${orderLists}">
	                        <c:set var="totalCost" value="0" />
	                        <c:forEach var="order" items="${orderList }">
	                            <c:set var="totalCost" value="${totalCost + order.order_price}" />
	                        </c:forEach>
	                        <table class="orderlist_table" border="1" style="border-collapse: collapse;">
	                            <tr>
	                                <td>
	                                    <span class="order_num">
	                                        주문번호 <span class="order_group_number">${orderList[0].order_group_number}</span>
	                                    </span>
	                                    <i class="fas fa-chevron-right"></i>
	                                </td>
	                            </tr>
	                            <tr>
	                                <td>
	                                    <div>
	                                        <span class="span_order_info span_three">상 품 명  </span><span>${orderList[0].product_name} 외 ${fn:length(orderList)-1}개</span>
	                                    </div>
	                                        <span class="span_order_info">결제 일시 </span> <span class="orderlist_order_date"><fmt:formatDate value="${orderList[0].order_date}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
	                                        <c:set var="order_tel" value="${orderList[0].order_receiver_tel}" />
	                                        <c:set var="order_tel_len" value="${fn:length(order_tel)}" />
	                                        <c:set var="order_tel_len_check" value="${order_tel_len eq 10 ? 6:7}" />
	                                        <c:set var="order_tel_first" value="${fn:substring(order_tel,0,3)}" />
	                                        <c:set var="order_tel_second" value="${fn:substring(order_tel,3,order_tel_len_check)}" />
	                                        <c:set var="order_tel_third" value="${fn:substring(order_tel,order_tel_len_check,order_tel_len)}" />
	                                        <div><span class="span_order_info span_three">연 락 처  </span>${order_tel_first}-${order_tel_second}-${order_tel_third}</div>
	                                        <div><span class="span_order_info span_three">배 송 지  </span>${orderList[0].order_receiver_main_address} ${orderList[0].order_receiver_sub_address}</div>
	                                        <div><span class="span_order_info">결제 금액  </span><fmt:formatNumber value="${totalCost}" pattern="#,###" /></div>
	                                </td>
	                            </tr>
	                        </table>
	                    </c:forEach>
	                </section>
	            </c:when>
	            <c:otherwise>
	                	주문 내역이 없습니다.
	            </c:otherwise>
	        </c:choose>
	    </div>
    <script type="text/javascript">
        $("span.order_num").on("click", function () {
            let order_form = document.createElement("form");
            console.log($(this).children().text());
            let order_group_number = $(this).children().text();
            let member_id = '${member_id}';
            order_form.name = "order_form";
            order_form.action = '<c:url value="/product/orderview"/>';
            order_form.method = "post";
            let input_order_group_number = document.createElement("input");
            let input_member_id = document.createElement("input");
            input_order_group_number.setAttribute("type", 'hidden');
            input_order_group_number.setAttribute("name", "order_group_number");
            input_order_group_number.setAttribute("value", order_group_number);
            input_member_id.setAttribute("type", 'hidden');
            input_member_id.setAttribute("name", "member_id");
            input_member_id.setAttribute("value", member_id);
            order_form.appendChild(input_order_group_number);
            order_form.appendChild(input_member_id);
            document.body.appendChild(order_form);
            order_form.submit();
        });
    </script>
</body>
</html>