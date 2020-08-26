<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>form</title>
<link rel="stylesheet"	href="<c:url value='/resources/css/board/notice/form.css'/>" />
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<jsp:include page='../../header&footer/header.jsp' />
	<div class="noice_section">
		<div style="padding-bottom: 45px;">
			<h2 class="tit">Event</h2>
			<span class="tit_sub">Event 등록하기</span>
		</div>
		<form action='<c:url value="/board/event/${msg}"/>' method="post" enctype="multipart/form-data">
			<table class="form_table">
				<tr>
					<th >글제목</th>
					<td> 
						<input type="text" name="event_title" class="th_title" value="${event.event_title}">
						<c:if test="${msg eq 'update'}">
							<input type="hidden" name='event_number' value="${event.event_number}">
							<input type="hidden" name='event_rn' value="${event.event_rn}">
						</c:if>
					</td>
				</tr>
				<tr>
					<th >글내용</th>
					<td>
						<textarea rows="30" cols="110" name="event_content" class="td_content">${event.event_content}</textarea>
          			</td>
				</tr>
				<tr>
					<th>파일첨부</th>
					<td><input type="file" name="file"></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="${msg eq 'new'? '등록' : '수정'}" class="btn">
						<input type="reset" value="취소" class="btn" onclick="window.history.back()">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="../../header&footer/footer.jsp" />
</body>
</html>


