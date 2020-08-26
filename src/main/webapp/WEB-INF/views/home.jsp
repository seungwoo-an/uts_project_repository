<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/home.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/product/list.css'/>" />
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<div id="main_home">
    	<img src=/project/resources/images/sidebar_logo.png>
		<ul>
        	<li><a href="#" class="main_explain">회사소개</a></li>
            <li><a href="#" class="main_explain">인사말</a></li>
            <li><a href="#" class="main_explain">양식과정</a></li>
            <li><a href="#" class="main_explain">오시는길</a></li>
            <li><a href="#" class="main_explain">배달과정</a></li>
        </ul>
        <div id=next>
            <span id=next_page>NEXT</span>
            <span id=next_span1 class="next_span"></span>
            <span id=next_span2 class="next_span"></span>
            <span id=next_span3 class="next_span"></span>
            <span id=next_span4 class="next_span"></span>
            <span id=next_span5 class="next_span"></span>
            <span id=next_span6 class="next_span"></span>
        </div>
        <div id=screen_check>
        	<label>
        		<input type="checkbox" id=screen_checkbox>
        		다시 보지 않기
        	</label>
        </div>
        <div id="section_commonse0" class="section_commonse">
            <div id=exit class="exit">
                <span id=exit_span1></span>
                <span id=exit_span2></span>
            </div>
        </div>
        <div id="section_commonse1" class="section_commonse">
            <div id=exit class="exit">
                <span id=exit_span1></span>
                <span id=exit_span2></span>
            </div>
        </div>
        <div id="section_commonse2" class="section_commonse">
            <div id=exit class="exit">
                <span id=exit_span1></span>
                <span id=exit_span2></span>
            </div>
        </div>
        <div id="section_commonse3" class="section_commonse">
            <div id=exit class="exit">
                <span id=exit_span1></span>
                <span id=exit_span2></span>
            </div>
        </div>
        <div id="section_commonse4" class="section_commonse">
            <div id=exit class="exit">
                <span id=exit_span1></span>
                <span id=exit_span2></span>
            </div>
        </div>
        <video src="/project/resources/배경.mp4" loop muted autoplay></video>
    </div>
    
    <jsp:include page="header&footer/header.jsp"></jsp:include>
    <section id=home_main_section>
    	<div id=home_div_one>
	    	<div>
	    		<img src="/project/resources/images/main_img5.png">
	    		<img src="/project/resources/images/main_img4.png">
	    		<img src="/project/resources/images/main_img1.png">
	    		<img src="/project/resources/images/main_img2.png">
	    		<img src="/project/resources/images/main_img3.png">
	    	</div>
    	</div>
    	
    		<!--      상품리스트 	 -->
    	<div id=home_div_two>
	     <section class="new_product_list">
	        <h1 class="new_product_tit">오늘의 신상품</h1>
	        <fieldset>
	        	<legend><span class="new_product_sub_tit">새로 업로드 된 상품을 지금 바로 만나보세요</span></legend>
	        </fieldset>
	        <div class="product_list_frame">
		        <div class="div_product_list">
			        <c:forEach var="newestProduct" items="${newestProductList}">
				             <div class="productframe">
				                <div class="imgframe">
				                    <a href='<c:url value="/product/${newestProduct.product_id}"/>'>
				                   	 	<img class="productimg" src='/project/product/img/${newestProduct.product_id}'>
				                   	</a>
				                </div>
				                <div class="productname">
				                    <label id="productname">
					                    <a href='<c:url value="/product/${newestProduct.product_id}"/>'>
					                    	[${newestProduct.seller_company_name}]${newestProduct.product_name}
					                    </a>
				                    </label>
				                </div>
				                <div class="productprice">
				                    <label id="productprice">
				                    <fmt:formatNumber value="${newestProduct.product_price }" pattern="#,###"/>원
				                    </label>
				                </div>
				            </div>
			        </c:forEach>
		        </div>
	        </div>
	    </section>
    	</div>
    	
	    <div>
	    	<img src="/project/resources/images/main2.png" style="width: 100%; margin-bottom: 120px;">
	    </div>
    	
    	<div id=home_div_three>
	     <section class="new_product_list">
	        <h1 class="new_product_tit">언더더씨 인기상품</h1>
	        <fieldset>
	        	<legend><span class="new_product_sub_tit">언더더씨에서 가장 많이 팔린 인기상품을 지금 만나보세요</span></legend>
	        </fieldset>
	        <div class="product_list_frame">
		        <div class="div_product_list">
			        <c:forEach var="popularProduct" items="${popularProductList}">
				             <div class="productframe">
				                <div class="imgframe">
				                    <a href='<c:url value="/product/${popularProduct.product_id}"/>'>
				                   	 	<img class="productimg" src='<c:url value="/product/img/${popularProduct.product_id}"/>'>
				                   	</a>
				                </div>
				                <div class="productname">
				                    <label id="productname">
					                    <a href='<c:url value="/product/${popularProduct.product_id}"/>'>
					                    	${popularProduct.product_name}
					                    </a>
				                    </label>
				                </div>
				                <div class="productprice">
				                    <label id="productprice">
				                    <fmt:formatNumber value="${popularProduct.product_price }" pattern="#,###"/>원
				                    </label>
				                </div>
				            </div>
			        </c:forEach>
		        </div>
	        </div>
	    </section>
    	</div>
    <jsp:include page ="header&footer/footer.jsp"/>
    </section>
    
	
	<script type="text/javascript">
		if(sessionStorage.getItem("mineSession")=="screen_off"){
	        $("#main_home").css({"display":"none"});
	        $("#header>div:nth-child(1)").css({"opacity":"1"});
	        $("header").css({"display" : "inline"});
	        $("#home_main_section").css({"opacity":"1"});
	        $("#home_main_section").css({"display" : "flex"});
	        $("#footer").css({"opacity":"1"});
	        $("#footer").css({"display" : "flex"});
	     }
	</script>
    
	<script>
        let index_save;
        $(".main_explain").click(function () {
            if (index_save != undefined) {
                $("#section_commonse" + index_save).css({ "width": "0", "height": "0"})
                $("#section_commonse" + index_save).css({ "border": "none" })
            }
            let index = $(".main_explain").index(this);
            index_save = index
            let cnt = $(".section_commonse").length;
            $("#section_commonse" + index).animate({ "width": "1530px", "height": "850px"})
            $("#section_commonse" + index).css({ "border": "2px solid yellow" })
        })

        $(".exit").click(function () {
            let exit_index = $(".exit").index(this)
            $("#section_commonse" + exit_index).animate({ "width": "0", "height": "0"})
            $("#section_commonse" + exit_index).css({ "border": "none" })
        })
	</script>
    
    <script>
	    $("#next").click(function () {
	        $("#main_home").animate({"opacity":"0"},2000);
	        setTimeout(function(){
	            $("#main_home").css({ "display": "none" });
	            $("header").css({"display" : "inline"});
	            $("#header>div:nth-child(1)").animate({"opacity":"1"},2000);
	            $("body").css({"height" : "2000px"});
	            $("#home_main_section").css({"display" : "flex"});
	            $("#home_main_section").animate({"opacity":"1"},2000);
	            $("#footer").css({"display":"flex"});
	            $("#footer").animate({"opacity":"1"},2000);
	            if($("#screen_checkbox").is(":checked") == true){
		            if(sessionStorage.length == 0){
		            sessionStorage.setItem("mineSession", "screen_off");
		            }
	            }
	        },2000);
	        
	    })
	</script>
	
	<script type="text/javascript">
		let img_total = $("#home_div_one>div:nth-child(1) img").length
	    let index_count = 1;
	    setInterval(function () {
	        $("#home_div_one>div:nth-child(1)>img:nth-child(" + index_count + ")").animate({ "opacity": "0" });
	        $("#home_div_one>div:nth-child(1)>img:nth-child(" + (index_count + 1) + ")").animate({ "opacity": "1" });
	        index_count++;
	        if (index_count == img_total) {
	            let seve = index_count;
	            setTimeout(function(){
	                $("#home_div_one>div:nth-child(1)>img:nth-child(" + (seve) + ")").animate({ "opacity": "0" });
	            },2000);
	            index_count = 0;
	        }
	    }, 2000);
	</script>
	
	

    	
</body>
</html>