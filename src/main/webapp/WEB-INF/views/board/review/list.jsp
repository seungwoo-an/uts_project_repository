<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>reviewList</title>
<link rel="stylesheet"
	href="<c:url value='/resources/css/board/list.css'/>" />
<script src="https://kit.fontawesome.com/c2524284bc.js" crossorigin="anonymous"></script>
</head>
<body>
	<jsp:include page="../../header&footer/header.jsp" />
	<div class="noice_section">
		<div style="padding-bottom: 45px;">
			<h2 class="tit">review</h2>
			<span class="tit_sub">review 게시판입니다</span>
		</div>
		<div align="center">
			<form action="">
				<sec:authorize access="hasRole('ROLE_MASTER,ROLE_CUSTOMER')">
					<div class="btn_write">
						<a href="<c:url value='/board/notice/form'/>">글 쓰기</a>
					</div>
				</sec:authorize>
				<table class="notice_table">
					<thead>
						<tr class="tr_notice th_notice">
							<th style="width: 70px;">글번호</th>
							<th>제 목</th>
							<th style="width: 130px;">작성일</th>
							<th style="width: 70px;">조회</th>
						</tr>
					</thead>
					<!-- 	 varStatus="status" 이용시 idx 가져오기 가능-->
					<tbody>
						<c:forEach var="list" items="${reviewList}" varStatus="status">
							<tr class="tr_notice">
								<td>${list.review_rn}</td>
								<td class="td_title"><a
									href='<c:url value="/board/review/${list.review_rn}"/>'>${list.review_title}</a></td>
								<td>${list.review_date}</td>
								<td>${list.review_views}</td>
							</tr>
						</c:forEach>
					</tbody>
					<tr>
						<td colspan="4">
							<div class="notice_paging">
								<div style="display: flex; border-left: 1px solid #ddd;">
									<c:if test="${pagingManager.nowPage ne 1}">
										<a class="a_paging"
											href="<c:url value='/board/review/list?page=1'/>">처음</a>
									</c:if>
									<c:if test="${pagingManager.nowBlock gt 1 }">
										<a class="a_paging"
											href='<c:url value="/board/review/list?page=${pagingManager.startPage-1}"/>'>이전</a>
									</c:if>
									<c:forEach var="i" begin="${pagingManager.startPage}"
										end="${pagingManager.endPage}">
										<a class="a_paging"
											href='<c:url value="/board/review/list?page=${i}"/>'>${i}</a>
									</c:forEach>
									<c:if
										test="${pagingManager.nowBlock lt pagingManager.totalBlock}">
										<a class="a_paging"
											href="<c:url value='/board/review/list?page=${pagingManager.endPage+1}'/>">다음</a>
									</c:if>
									<c:if
										test="${pagingManager.nowPage ne pagingManager.totalPage}">
										<a class="a_paging end_paging "
											href="<c:url value='/board/review/list?page=${pagingManager.totalPage}'/>">끝</a>
									</c:if>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="width: 130px;">> 검색어</td>
						<td align="left" style="width: 300px;"><input type="checkbox"
							name="search_title"> 제목 &nbsp;&nbsp; <input
							type="checkbox" name="search_content"> 내용</td>
						<td colspan="2">
							<div class="notice_search">
								<input type="text"
									style="height: 40px; width: 270px; border: 1px solid #d3d3d3;">
								<div class="search_img" align="center">
									<i class="fas fa-search"></i>
								</div>
							</div>

						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<jsp:include page="../../header&footer/footer.jsp" />
</body>
</html>