<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품등록</title>
<link rel="stylesheet" href="<c:url value='/resources/css/product/upload.css'/>" />

<!-- include libraries(jQuery, bootstrap) --> 
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet"> 
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<!-- include summernote css/js--> 
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet"> 
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
<script src="/project/resources/js/summernote-ko-KR.js"></script>

</head>
<body>
	 <div class="wrapper_div">
	 	<div id=upload>
		<div id="upload_tit">상품 ${msg eq 'update' ? '수정':'등록'}</div>
			<c:set var="member_id">
				<sec:authentication property="principal.username"/>
			</c:set>
			<form method="post"  enctype="multipart/form-data" id="fileUploadForm">
	      <c:if test="${msg eq 'update'}">
	       <input type="hidden" name="product_id" value='${product.product_id}'>
	      </c:if>
	       <table id="upload_table">
	          <tr>
	              <th>상품 이미지</th>
	              <td>
	              	<div>
	              	<input type="file" name="file" id="file_upload" value="${product.product_img_name}"></div>
	              	<img id="pre_view" width="200" height="auto" <c:if test="${not empty product}">src='/project/product/img/${product.product_id}'</c:if>/>
	              	<input type="hidden" id="member_id" name="member_id" value="${member_id}">
	              </td>        
	          </tr>
	          <tr>
	              <th>상품명</th>
	              <td><input type="text" id="product_name" name="product_name" class="input_text" value="${product.product_name}"></td>        
	          </tr>
	          <tr>
	              <th>상품 판매가</th>
	              <td><input type="text" id="product_price" name="product_price" class="input_text" value="${product.product_price}"></td>        
	          </tr>
	          <tr>
	              <th>상품 무게(kg)</th>
	              <td><input type="text" id="product_weight" name="product_weight" class="input_text" value="${product.product_weight}"></td>        
	          </tr>
	          <tr>
	              <th>상품 수량</th>
	              <td><input type="text" id="product_count" name="product_count" class="input_text" value="${product.product_count}"></td>        
	          </tr>
	          <tr>
	              <th>상세 설명</th>
	              <td class="td_detail">
	            	  <textarea name="product_info" id="product_info">${product.product_info}</textarea>
	              </td>        
	          </tr>
	          <tr>
	              <th colspan="2">
	                  <div id="div_btn" >
	                      <input type="button" value=" ${msg eq 'update' ? '수정':'등록'}" id="submitBtn" onclick="productCheck(this.form)">
	                      <input type="button" value="취소" id="resetBtn" onclick="window.close()">
	                    </div>
	                </th>
	            </tr>
	            </table>
	         </form>
		</div>
	</div>
    	
<script>
let fileCheck=false;
$(document).ready(function(){
	if('${product}'!="")fileCheck=true;
})
$("#file_upload").change(function(){
	fileCheck=false;
   readURL(this);
});
function readURL(input) {
	console.log("input : " + input);
	console.log("input.files : " + input.files);
	console.log("input.files[0] : "+input.files[0]);
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function (e) {
			//img id:pre_view에 src 값 넣어줌
			if(e.target.result.substring(5,10)!='image'){
				$("#file_upload").val("")
				$('#pre_view').attr('src', "");  
				alert("이미지만 선택 가능합니다.");
				return;
			}else{
				$('#pre_view').attr('src', e.target.result);  
				fileCheck=true;
			}
		};
		reader.readAsDataURL(input.files[0]);
	}
}
$(document).ready(function() {
  $('#product_info').summernote({
	    	placeholder: '글 내용을 입력해주세요.(최대 2048자)',
        minHeight: 370,
        maxHeight: null,
        width:900,
        focus: true, 
        lang : 'ko-KR',
        toolbar: [
             // [groupName, [list of button]]
             ['fontname', ['fontname']],
             ['fontsize', ['fontsize']],
             ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
             ['color', ['forecolor','color']],
             ['table', ['table']],
             ['para', ['ul', 'ol', 'paragraph']],
             ['height', ['height']],
             ['insert',['picture','link','video']],
             ['view', ['fullscreen', 'help']]
           ],
         fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
         fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
  });
});
// 등록 버튼 클릭 시
function productCheck(form) {
	event.preventDefault();
	var product_name = document.getElementById('product_name').value;
	var product_price = document.getElementById('product_price').value;
	var product_count = document.getElementById('product_count').value;
	var product_weight = document.getElementById('product_weight').value;
	var product_info = document.getElementById('product_info').value;
	var form = $('#fileUploadForm')[0];
	var formData = new FormData(form);
	if (product_name.trim() == ''){
		return false;
	}
	if (product_count.trim() == ''){
		return false;
	}
	if (product_price.trim() == ''){
		return false;
	}
	if (product_weight.trim() == ''){
		return false;
	}
	if (product_info.trim() == ''){
		return false;
	}
// 	if(!fileCheck){
// 		return false;
// 	}
	let message = "${msg}";
	if(message == 'update'){
		$.ajax({
			url : '/project/product/rest/update',	
			method : 'post',
			enctype : "multipart/form-data",
			contentType: false,
			processData: false,
			data : formData,
			success : function(){
				alert("성공")
			 	window.opener.document.location.href = window.opener.document.URL;
			 	window.close();
			},error : function(){
				alert("실패")
			}
		});
	}else{
		$.ajax({
			url : '/project/product/rest/upload',
			method : 'post',
			enctype : "multipart/form-data",
			contentType: false,
			processData: false,
			data : formData,
			success : function(){
				alert("성공")
			 	window.opener.document.location.href = window.opener.document.URL;
			 	window.close();
			},error : function(){
				alert("실패")
			}
		});
	}
}
</script>
</body>
</html>