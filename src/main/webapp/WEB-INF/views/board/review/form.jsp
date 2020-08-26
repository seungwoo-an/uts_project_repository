<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 쓰기</title>

<link rel="stylesheet" href="<c:url value='/resources/css/board/review/form.css'/>" />
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<body>
 <form id="reviewUploadForm" action="<c:url value='/board/review/new'/>" method="POST" onsubmit="return reviewFormCheck()" enctype="multipart/form-data">
    <table class="review_write_table">
        <tr>
            <th>
                <div class="review_write_tlt">후기 쓰기</div>
                <input type="hidden" name="order_number" value="${order.order_number}">
                <input type="hidden" name="member_id" value="${order.member_id}">
                <input type="hidden" name="purchase_date" value="${order.order_date}">
            </th>
        </tr>
        <tr>
            <td>
                <div class="inner_table">
                    <table >
                        <tr>
                            <td>
                                <img src="/project/product/img/${order.product_id}" style="width:100px; height:100px;">
                                <input type="hidden" name="product_id" value="${order.product_id}">
                            </td>
                            <td style="padding-bottom: 25px;">
                                <div class="div_tlt_pro_name">
                                    ${order.product_name}                    					
                                </div>
                                <div class="div_tlt">
                                    <span>수량 :</span> <span>${order.order_product_count}</span><span> 개</span>
                                    <input type="hidden" name="order_product_count" value="${order.order_product_count}">
                                </div>
                                <div class="div_tlt" >
                                    <span>무게 :</span> <span>${order.product_weight}</span><span> kg</span>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td>
            <input type="hidden" name="review_score" id="review_score">
                <div class="sub_tlt">제품 만족도</div>
                <div>
                    <p id="star_grade">
                        <a href="#" class="on">★</a>
                        <a href="#">★</a>
                        <a href="#">★</a>
                        <a href="#">★</a>
                        <a href="#">★</a>
                    </p>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="sub_tlt textarea_tit">제목</div>
                <input type="text" name="review_title" class="review_title" id="review_title">
            </td>   
        </tr>	     
        <tr>
            <td>
                <div class="sub_tlt textarea_tit">구매 후기</div>
                <div><textarea name="review_content" id="review_content" cols="30" rows="10"
                        placeholder="최소 10자 이상 입력해주세요."></textarea>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="wrpper_file">
                    <input type="file" name="file">
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="review_witre_btn">
                    <input type="button" value="취소" class="review_btn review_cancel_btn">
                    <input type="button" value="확인" class="review_btn review_upload_btn" id="review_upload_btn">
                </div>
            </td>
        </tr>
    </table>
</form>

<script>
$("#review_upload_btn").on("click",function(){
    let review_title = $("#review_title").val();
    let review_content = $("#review_content").val();
    
    
    if(review_title.trime==""){
        alert("제목을 입력하세요.");
    }else if(review_content.trim()==""){
        alert("구매 후기를 입력하세요.");
    }else if(review_content.length < 10){
        alert("구매 후기를 10자 이상 입력하세요.");
    }else{
        $("#review_score").val($(".on").length);
        let form = $("#reviewUploadForm")[0];
        console.log(form);
        let formData = new FormData(form);
        console.log(formData);
        $.ajax({
            url:'<c:url value="/board/rest/review/upload"/>',
            type:'POST',
            data:formData,
            contentType:false,
            processData:false,
            success:function(){
            	$(opener.location).attr("href", "javascript:pro_info(${order_group_number},${table_number_index});");
                self.close();
            }
        });
    }
});
    
    $('#star_grade a').click(function () {
        $(this).parent().children("a").removeClass("on");  /* 별점의 on 클래스 전부 제거 */
        $(this).addClass("on").prevAll("a").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
        return false;
    });
</script>
</body>
</html>