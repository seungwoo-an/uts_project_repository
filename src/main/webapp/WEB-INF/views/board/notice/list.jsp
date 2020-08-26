<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice list</title>
<link rel="stylesheet" href="<c:url value='/resources/css/board/notice/list.css'/>" />
<script src="https://kit.fontawesome.com/c2524284bc.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
   <jsp:include page="../../header&footer/header.jsp" />
      <div id=center_div>
        <div>
            <div>
                <h1>고객센터</h1>
                <section id=center_menu_section>
                    <ul>
                        <li><a>&nbsp;&nbsp;공지사항</a>>&nbsp;&nbsp;</li>
                        <li><a>&nbsp;&nbsp;자주하는 질문</a>>&nbsp;&nbsp;</li>
                        <li><a>&nbsp;&nbsp;1:1문의하기</a>>&nbsp;&nbsp;</li>
                    </ul>
                </section>
            </div>

            <div id=contents_div>
                <div>
                    <h2>공지사항</h2>
                    <h4>UTS의 새로운 소식들과 유용한 정보들을 한곳에서 확인하세요</h4>
                    <div id=contents_notis_table>
                        <table>
                            <tr>
                                <th>--</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>작성일</th>
                                <th>조회</th>
                            </tr>
                          	<c:forEach var="list" items="${noticeList}" varStatus="status">
		                  		<tr>
			                    	<th>${list.notice_number}</th>
			                     	<th class="td_title">
		                       			<a href='<c:url value="/board/notice/${list.notice_rn}"/>' class="a_title">${list.notice_title}</a>
		                     		</th>
		                     		<th>Master</th>
				                    <th>${list.notice_date}</th>
				                    <th>${list.notice_views}</th>
		                  		</tr>
		               		</c:forEach>
		               		<tr>
		               			<th colspan="5">
		               			<div>
								<c:if test="${notice_pagingManager.nowPage ne 1}">
				                     <a class="a_paging" href="<c:url value='/board/notice/list?notice_page=1'/>">처음</a>
				                </c:if> 
				                <c:if test="${notice_pagingManager.nowBlock gt 1 }">
				                     <a class="a_paging" href='<c:url value="/board/notice/list?notice_page=${notice_pagingManager.startPage-1}"/>'>이전</a>
				                </c:if> 
				                <c:forEach var="i" begin="${notice_pagingManager.startPage}" end="${notice_pagingManager.endPage}">
				                      <a class="a_paging a_num" href='<c:url value="/board/notice/list?notice_page=${i}"/>' onclick="change_color_pagingBtn()">${i}</a>
				                </c:forEach>       
				                <c:if test="${notice_pagingManager.nowBlock lt notice_pagingManager.totalBlock}">
				                     <a class="a_paging" href="<c:url value='/board/notice/list?notice_page=${notice_pagingManager.endPage+1}'/>">다음</a>
				                </c:if> 
				                <c:if test="${notice_pagingManager.nowPage ne notice_pagingManager.totalPage}">
				                     <a href="<c:url value='/board/notice/list?notice_page=${notice_pagingManager.totalPage}'/>">끝</a>
				                </c:if>
				                </div>
				                </th>
		               		</tr>
                        </table>    
                        <sec:authorize access="hasRole('ROLE_MASTER')">
			           		<div id=notice_form><button onclick="location.href='/project/board/notice/form'">글쓰기</button></div>
			        	</sec:authorize>
                    </div>
                </div>
                <div>
                    <h2>자주하는 질문</h2>
                    <h4>고객님들께서 가장 자주하시는 질문을 모두 모았습니다</h4>
                    <div id=frequently_asked_questions>
                        <select name="">
                            <option value="">선택</option>
                            <option value="">회원문의</option>
                            <option value="">주문/결제</option>
                            <option value="">취소문의</option>
                            <option value="">배송문의</option>
                            <option value="">기타</option>
                        </select>
                    </div>
                    <div id=contents_fre_table>
                        <table>
                            <tr>
                                <th>번호</th>
                                <th>카테고리</th>
                                <th>제목</th>
                            </tr>
                            <c:forEach var="list" items="${faqList}" varStatus="status">
		                  		<tr onclick="content(${list.fre_number},${status.index}+1)">
			                    	<th>${list.fre_number}</th>
			                     	<th>${list.fre_category}</th>
				                    <th>${list.fre_title}</th>
		                  		</tr>
		               		</c:forEach>
		               		<tr>
		               			<th colspan="5">
		               			<div>
								<c:if test="${fre_PagingManager.nowPage ne 1}">
				                     <a class="a_paging" href="<c:url value='/board/notice/list?fre_page=1&fre=fre'/>">처음</a>
				                </c:if> 
				                <c:if test="${fre_PagingManager.nowBlock gt 1 }">
				                     <a class="a_paging" href='<c:url value="/board/notice/list?fre_page=${fre_PagingManager.startPage-1}&fre=fre"/>'>이전</a>
				                </c:if> 
				                <c:forEach var="i" begin="${fre_PagingManager.startPage}" end="${fre_PagingManager.endPage}">
				                      <a class="a_paging a_num" href='<c:url value="/board/notice/list?fre_page=${i}&fre=fre"/>' onclick="change_color_pagingBtn()">${i}</a>
				                </c:forEach> 
				                <c:if test="${fre_PagingManager.nowBlock lt fre_PagingManager.totalBlock}">
				                     <a class="a_paging" href="<c:url value='/board/notice/list?fre_page=${fre_PagingManager.endPage+1}&fre=fre'/>">다음</a>
				                </c:if> 
				                <c:if test="${fre_PagingManager.nowPage ne fre_PagingManager.totalPage}">
				                     <a class="a_paging end_paging " href="<c:url value='/board/notice/list?fre_page=${fre_PagingManager.totalPage}&fre=fre'/>">끝</a>
				                </c:if>
				                </div>
				                </th>
		               		</tr>
                        </table>
                    </div>
                </div>
                <div>
                    <h2>1:1문의하기</h2>
                    <h4></h4>
                </div>
            </div>
        </div>
    </div>
    
   <script>
   if(${!empty freMessage}){
        $("#center_menu_section>ul li:nth-child(2)").addClass("on");
        $("#contents_div>div:nth-child(2)").css({"display" : "block"})
   }else{
        $("#center_menu_section>ul li:nth-child(1)").addClass("on");
        $("#contents_div>div:nth-child(1)").css({"display" : "block"})
   }

        $("#center_menu_section>ul li").click(function() {
			$(this).addClass("on");
			$(this).siblings().removeClass("on");
            let contents_div_index = $("#center_menu_section>ul li").index(this) + 1;
            let li_count = $("#center_menu_section>ul li").length + 1;
            for(var i = 1 ; i < li_count ; i++){
                $("#contents_div>div:nth-child("+i+")").css({"display" : "none"})
            }
            $("#contents_div>div:nth-child("+contents_div_index+")").css({"display" : "block"})
        })
    </script>
    
    <script>

		function content(fre_number , tr_num){
			if($("#content_data").length != 0){
				$("#content_data").remove();
			}
			var xhr = new XMLHttpRequest();
	        xhr.open("get", "/project/board/rest/fre_content?fre_number="+fre_number);
	        xhr.setRequestHeader("content-type", "application/json");
			xhr.send();
			xhr.onreadystatechange = function () {
                if (xhr.readyState === xhr.LOADING) {
//                     $("#loding").show();
                }
                if (xhr.readyState === xhr.DONE) {
                    if (xhr.status === 200 || xhr.status === 201) {
                    	console.log(xhr.responseText)
                    	let add_div = "<tr id='content_data'>"+
              						  "<td colspan='3' style='padding: 0 0 0 100px;'>"+
          							  "<div style='height:100px;padding:30px 0 0 0'>"+
          							  " >> " +xhr.responseText+
          							  "</div>"+
				   					  "</td>"+
          							  "</tr>"
						$("#contents_fre_table tr:nth-child("+(tr_num+1)+")").after(add_div);      
          						
                    }
                }
            }
		}
    
    </script>
    
   
   <jsp:include page="../../header&footer/footer.jsp"/>
	<script type="text/javascript">
// 	let index = 0;
// 		$(".a_num").click(function() {
// 			index = $(this).index()
// 			$.cookie("change_color", index);
// 		});
// // 		$.cookie("change_color")
		
// // 		if($.cookie("change_color"))
// 		function change_color_pagingBtn() {
// 		$(".a_num").get(index).css({"background-color" : "#f7f7f7"})
// 		}
	</script>
</body>
</html>