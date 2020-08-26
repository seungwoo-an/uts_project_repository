<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="<c:url value='/resources/css/member/list.css'/>" />
<style type="text/css">
</style>

</head>
<body>
	<div id="loding">
        <div></div>
    </div>
    
	<jsp:include page="../header&footer/header.jsp"></jsp:include>
	
    
	<div id=memberlist_menu_div>
	 	<div id=memberlist_menubar>
	    	<ul>
	        	<li><a>회원 관리</a></li>
	            <li><a>회원 상세정보</a></li>
	        </ul>
	        <span id="bar"></span>
	    </div>
	 </div>
	 
	 <div id=memberlist_div>
        <div>
            <h2>회원 검색</h2>
            <div id=member_option_div>
                <table>
                    <tr>
                        <td>검색어</td>
                        <td>
                            <select id="select_option">
                                <option value="select_all" selected="selected">-전체검색-</option>
                                <option value="member_name"> 이름 </option>
                                <option value="member_tel"> 전화번호 </option>
                                <option value="member_email"> Email </option>
                            </select>
                            <input type="text" id="member_select_word">
                        </td>
                        <td>회원 권한</td>
                        <td>
                            <input type="radio" id=auth_all name="auth" checked>
                            <label for="auth_all">All</label>
                            <input type="radio" id=customer name="auth">
                            <label for="customer">Customer</label>
                            <input type="radio" id=seller name="auth">
                            <label for="seller">Seller</label>
                        </td>
                    </tr>
                    <tr>
                        <td>승인 여부</td>
                        <td>
                            <input type="radio" id=enabled_all name="enabled" checked>
                            <label for="enabled_all">전체</label>
                            <input type="radio" id=true name="enabled">
                            <label for="true">승인</label>
                            <input type="radio" id=false name="enabled">
                            <label for="false">미승인</label>
                        </td>
                        <td>회원 등급</td>
                        <td>
                            <p id=member_LV>Silver</p>
                        	<select id=level>
                                <option value="Silver"> Silver </option>
                                <option value="Gold"> Gold </option>
                                <option value="Platinum"> Platinum </option>
                                <option value="VIP"> VIP </option>
                            </select>
                        </td>
                    </tr>
                </table>
                <div>
                    <input type="button" value="Select" onclick="member_select()">
                </div>
            </div>
        </div>
    </div>

	<div id=memberlist_table_div>
        <div>
            <div id=member_table_div>
                <div>
                    <input type="button" value="선택 삭제" id="deleteSelectedMembers">
                </div>
                <div>
                    <table id="list_table">
                        <tr>
                            <th>
                            	<label class="checkbox member_label"> 
								<input type="checkbox" id="Check_All"> 
								<span class="member_icon icon"></span> 
								</label>
							</th>
							<th>Num</th>
                            <th>ID <br> Name </th>
                            <th>Tel</th>
                            <th>Address</th>
                            <th>Email</th>
                            <th>Auth</th>
                            <th>Enabled</th>
                            <th>기타</th>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    
	<div id=memberinfo_div>
		 <div>
            <div id=member_table_div>
                <div>
                    <table id="info_table">
                        <tr>
							<th>Num</th>
                            <th>ID <br> Name </th>
                            <th>Tel</th>
                            <th>Address</th>
                            <th>Email</th>
                            <th>Auth</th>
                            <th>Enabled</th>
                            <th>상세정보</th>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page ="../header&footer/footer.jsp"/>
	<script type="text/javascript">
	//선택삭제 메서드
	$("#deleteSelectedMembers").on("click",function(){
		let member_ids = []
		$(".CheckEach").each(function(){
			if($(this).prop("checked")){
				let idx =$(".CheckEach").index(this);
				member_ids.push($(".CheckEach_member_id").get(idx).value);
			}
		});
// 		console.log(member_ids);//삭제할 멤버 아이디 배열 확인
		$.ajax({
			url:'/project/member/rest/deleteSelectedMembers',
			type:'POST',
			data:{
				member_ids:member_ids
			},success:function(){
				console.log(save_pagingManager.totalPage)
				console.log(selectVO.page)
				
				console.log($(".CheckEach").length)
				console.log(member_ids.length)
            	selectVO.page = save_delete_pagein;
            	if(save_pagingManager.totalPage == selectVO.page && $(".CheckEach").length==member_ids.length){
            		selectVO.page = selectVO.page-1
            		save_page -= 1;
            	}
				$("#list_table tr:nth-child(n+2)").remove();
            	$("#list_table").off();
            	document.getElementById("Check_All").checked = false;
            	check_in_out = true;
				load_list_ajax(selectVO);
			},error:function(e){
				alert("error : "+e)
			}
		})
	});
	</script>
    
	<script>
		$("#memberinfo_div").hide();
		$("#memberlist_menubar>ul>li a").click(function() {
			$(this).addClass("on");
			$(this).parent().siblings().children().removeClass("on");
			if($("#memberlist_menubar>ul>li:nth-child(1) a").attr("class") != "on"){
// 				회원 상세정보 클릭시
				$("#bar").animate({"left" :"450px", "width" : "150px"},1000);
				$("#memberlist_table_div").hide();
				$("#info_table tr:nth-child(n+2)").remove();
	        	$("#info_table").off();
	        	
				save_page = 1;
	        	selectVO = {
	            	page:1
	            }
				load_list_ajax(selectVO);
				document.getElementById("auth_all").checked =true;
	        	document.getElementById("enabled_all").checked =true;
	        	document.getElementById("select_option")[0].selected = true;
	        	
				$("#memberinfo_div").show();
			}else{
// 				회원관리 클릭시
				$("#bar").animate({"left" :"110px" , "width" : "130px"},1000);
				$("#memberinfo_div").hide();
				$("#list_table tr:nth-child(n+2)").remove();
	        	$("#list_table").off();
	        	document.getElementById("Check_All").checked = false;
	        	check_in_out = true;
	        	
	        	save_page = 1;
	        	selectVO = {
	            	page:1
	            }
	   			load_list_ajax(selectVO);
	        	document.getElementById("auth_all").checked =true;
	        	document.getElementById("enabled_all").checked =true;
	        	document.getElementById("select_option")[0].selected = true;
	        	
				$("#memberlist_table_div").show();
			}
		})
	</script>
	
	<script>
	//checkbox select event
		    let check_in_out = true
		    let check_count = 0;
		    document.getElementById("Check_All").onclick = function () {
		        let length = document.getElementsByClassName("CheckEach").length;
		        if (check_in_out) {
		            for (var i = 0; i < length; i++) {
		                document.getElementsByClassName("CheckEach")[i].checked = true;
		            }
					check_count = 10;
		            check_in_out = false;
		        } else {
		            for (var i = 0; i < length; i++) {
		                document.getElementsByClassName("CheckEach")[i].checked = false;
		            }
		            check_count = 0;
		            check_in_out = true;
		        }
		    };
		    
	</script>
	
	<script>
	
	
	</script>
	
	
	
	
	
	
	<script>
	//select button click event
		function member_select(){
		if($("#memberlist_menubar>ul>li:nth-child(1) a").attr("class") == "on"){
			$("#list_table tr:nth-child(n+2)").remove();
        	$("#list_table").off();
        	document.getElementById("Check_All").checked = false;
        	check_in_out = true;
        	
        	let select_word = (function(){
        		if(document.getElementById("member_select_word").value==""){
        			return null;	
        		}else{
        			return document.getElementById("member_select_word").value;
        		}
        	})()
        	let select_option =(function() {
        		if(document.getElementById("select_option").value == "select_all"){
        			return null;
        		}else{
        			return document.getElementById("select_option").value;
        		}
        	})()
        	let select_auth = (function(){
        		for(var i = 0 ; i < document.getElementsByName("auth").length ; i ++){
	        		if(document.getElementsByName("auth")[i].checked == true){
	        			if(document.getElementsByName("auth")[i].getAttribute("id") == "auth_all"){
	        				return null;
	        			}else if(document.getElementsByName("auth")[i].getAttribute("id") == "customer"){
	        				return "ROLE_CUSTOMER";
	        			}else{
	        				return "ROLE_SELLER";
	        			}
	        				
	        		}
        		} 
        	})()
        	let select_enabled = (function(){
        		for(var i = 0 ; i < document.getElementsByName("enabled").length ; i ++){
	        		if(document.getElementsByName("enabled")[i].checked == true){
	        			if(document.getElementsByName("enabled")[i].getAttribute("id") == "true"){
	        				return 1	
	        			}else if(document.getElementsByName("enabled")[i].getAttribute("id") == "false"){
	        				return 0
	        			}else{
	        				return null;
	        			}
	        		}
        		} 
        	})()	
        	selectVO = {
        		page:1,
        		select_word:select_word,
        		select_option:select_option,
        		select_auth:select_auth,
        		select_enabled:select_enabled
        	}
        	load_list_ajax(selectVO);
		}else{
// 			상세정보 select button click
		}
	}
	
	</script>

	
	<script>
		let selectVO = {
			page:1
		}
		$(window).on("load" , function(){
			load_list_ajax(selectVO);
		});
		
		let save_page = 1;
		
		$("#memberlist_menubar>ul>li:nth-child(1) a").addClass("on");
		
		let save_delete_pagein = 1;
		let save_pagingManager = null;
		
		
		
		
		
		function load_list_ajax(selectVO){
			var xhr = new XMLHttpRequest();
	        xhr.open("post", "/project/member/rest/list");
	        xhr.setRequestHeader("content-type", "application/json");
			xhr.send(JSON.stringify(selectVO));
			xhr.onreadystatechange = function () {
                if (xhr.readyState === xhr.LOADING) {
                    $("#loding").show();
                }
                if (xhr.readyState === xhr.DONE) {
                    if (xhr.status === 200 || xhr.status === 201) {
                    	$("#loding").hide();
                    	let result = JSON.parse(xhr.responseText);
                    	for(var i = 0 ; i < result.length ; i++){
	                    	let enabled_text
	                    	
	                    	if(result[i].member_enabled == "0"){enabled_text = "미승인"}
	                    	else{enabled_text = "승인"}
	                    	
	                    	let memberlist = "<tr>"+
		                        
		                        (function(){
		                        	if($("#memberlist_menubar>ul>li:nth-child(1) a").attr("class") == "on"){
		                        		return "<th>"+
		                        		"<label class='checkbox member_label'>"+
		                        		"<input type='checkbox' class='CheckEach'>"+
		                        		"<span class='member_icon icon'><input type='hidden' value='"+result[i].member_id+"' class='CheckEach_member_id'></span>"+
		                        		"</label>"+
		                        		"</th>"
		                        	}
		                        })()+
		                        "<th>"+result[i].rn+"</th>"+
		                        "<th>"+result[i].member_id+"<br>"+result[i].member_name+"</th>"+
		                        "<th>"+result[i].member_tel+"</th>"+
		                        "<th>"+result[i].member_main_addr+"</th>"+
		                        "<th>"+result[i].member_email+"</th>"+
		                        "<th>"+result[i].member_auth+"</th>"+
		                        "<th>"+enabled_text+"</th>"+
		                        "<th>"+
		                        (function(){
		                        	if($("#memberlist_menubar>ul>li:nth-child(1) a").attr("class") == "on"){
		                        		return (function(){
		                        			if(enabled_text == "승인"){
				                        		return "<input type='button' value='정지' class='enabled'>"+"<input type='button' value='삭제' class='delete'>"
					                        }else{
					                            return "<input type='button' value='승인' class='enabled'>"+"<input type='button' value='삭제' class='delete'>"
					                        }
		                        		})()
		                        	}else{
		                        		return "<input type='button' value='상세정보' class='information'>"
		                        	}
		                        })()+
		                        "</th>"+
	                    	"</tr>"
	                    	
	                    	if($("#memberlist_menubar>ul>li:nth-child(1) a").attr("class") == "on"){
		                    	$("#list_table").append(memberlist);
	                    	}else{
		                    	$("#info_table").append(memberlist);
	                    	}
                    	}
                    	
                    	//delete click event add
                    	$("#list_table").on("click",".delete.on", function(){
                    		let member_id = (result[$(".delete").index(this)].member_id);
                    		var xhr = new XMLHttpRequest();
                	        xhr.open("POST", "/project/member/rest/choice_delete");
                	        xhr.setRequestHeader("content-type", "application/josn");
//                 	        xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
                			xhr.send(member_id);
                			xhr.onreadystatechange = function () {
                                if (xhr.readyState === xhr.LOADING) {
                                    $("#loding").show();
                                }
                                if (xhr.readyState === xhr.DONE) {
                                    if (xhr.status === 200 || xhr.status === 201) {
                                    	$("#loding").hide();
                                    	$("#list_table tr:nth-child(n+2)").remove();
                                    	$("#list_table").off();
                                    	document.getElementById("Check_All").checked = false;
                                    	check_in_out = true;
                                    	load_list_ajax(selectVO);
                                    }
                                }
                			}
                    	});
                   		$(".delete").addClass("on");
                   		
                    	//enabled click event add
                    	$("#list_table").on("click",".enabled.on", function(){
                    		let member_id = (result[$(".enabled").index(this)].member_id);
                    		let member_enabled = result[$(".enabled").index(this)].member_enabled;
                    		let member = {
                    			member_id:member_id,
                    			member_enabled:member_enabled
                    		}
                    		var xhr = new XMLHttpRequest();
                	        xhr.open("post", "/project/member/rest/member_enable");
                	        xhr.setRequestHeader("content-type", "application/json");
                	        xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
                			xhr.send(JSON.stringify(member));
                			xhr.onreadystatechange = function () {
                                if (xhr.readyState === xhr.LOADING) {
                                    $("#loding").show();
                                }
                                if (xhr.readyState === xhr.DONE) {
                                    if (xhr.status === 200 || xhr.status === 201) {
                                    	$("#loding").hide();
                                    	$("#list_table tr:nth-child(n+2)").remove();
                                    	$("#list_table").off();
                                    	document.getElementById("Check_All").checked = false;
                                    	check_in_out = true;
                                    	load_list_ajax(selectVO);
                                    }
                                }
                			}
                    	});
                   		$(".enabled").addClass("on");
                   		
                   		
                   		//check_box click event add
	                   	$("#list_table").on("click",".CheckEach.on", function(){
	         				let check_index = $(".CheckEach").index(this);
	         				if (document.getElementsByClassName("CheckEach")[check_index].checked == true) {
	         			    	check_count++;
	         			    } else {
	         			        check_count--;
	         			    }
	         				if (check_count == 10) {
	         			    	document.getElementById("Check_All").checked = true;
	         			        check_in_out = false;
	         				} else {
	         			    	document.getElementById("Check_All").checked = false;
	         			        check_in_out = true;
	         				}
	         			});
	         			$(".CheckEach").addClass("on");
                    }
                    paging_ajax(selectVO);
                    
                }
            }
		}
		
		
		
		function paging_ajax(selectVO){
		//page numbering ajax
	    	var xhr = new XMLHttpRequest();
	        xhr.open("POST", "/project/member/rest/page_numbering");
	        xhr.setRequestHeader("content-type", "application/json");
			xhr.send(JSON.stringify(selectVO));
			xhr.onreadystatechange = function () {
	            if (xhr.readyState === xhr.LOADING) {
	                $("#loding").show();
	            }
	            if (xhr.readyState === xhr.DONE) {
	                if (xhr.status === 200 || xhr.status === 201) {
	                	$("#loding").hide();
	                	let pagingManager= JSON.parse(xhr.responseText);
	                	save_pagingManager = pagingManager;
	                	 let paging =null;
	                	(function(){
	                		if(pagingManager.totalPage != 0){
			                	return paging = "<tr>"+
				            		"<th  colspan='9'>"+
				            		"<div>"+
						            "<span id='first'>처음</span>"+
				            		(function(){
					            		if(pagingManager.nowBlock > 1){
											return "<span id='back'>이전</span>"     			
					            		}else{
					            			return ""
					            		}
				            		})()
				            		+
				            		(function(){
				            			var a_paging = ""
				            			for(var i = pagingManager.startPage ; i <= pagingManager.endPage ; i++){
											a_paging += "<span class='paging_span'>"+i+"</span>"    				
				            			}
				            			return a_paging;
				            		})()
				            		+
				            		(function(){
					            		if(pagingManager.nowBlock >= pagingManager.totalBlock){
											return ""     			
					            		}else{
					            			return "<span id='next'>다음</span>"
					            		}
				            		})()
				            		+
					            	"<span id='last'>끝</span>"+
				            		"</div>"+
				            		"</th>"+
				            		"</tr>"
	                		}else{
	                			return paging = "";
	                		}
	                	})()
	            	
	                	if($("#memberlist_menubar>ul>li:nth-child(1) a").attr("class") == "on"){
	                		$("#list_table").append(paging);
                    	}else{
	                    	$("#info_table").append(paging);
                    	}
	                	
	                	
	            	if(pagingManager.totalPage != 0){
	            		console.log(save_page)
		            	document.getElementsByClassName("paging_span")[save_page-1].style.backgroundColor = "#2a365c";
		            	document.getElementsByClassName("paging_span")[save_page-1].style.color = "white";
	            	}
	            	
	                $("#list_table").on("click",".paging_span.on", function(){
                    	let now_page = ($(".paging_span").index(this)+1);
                    	save_page = now_page;
                    	let select_page = document.getElementsByClassName("paging_span")[now_page-1].innerText;
                   		$("#list_table tr:nth-child(n+2)").remove();
                   		$("#list_table").off();
                   		document.getElementById("Check_All").checked = false;
                       	check_in_out = true;
                       	console.log(selectVO)
                       	selectVO={
                       		page : select_page,
                       		select_word:selectVO.select_word,
                    		select_option:selectVO.select_option,
                    		select_auth:selectVO.select_auth,
                    		select_enabled:selectVO.select_enabled
                       	}
                       	save_delete_pagein = selectVO.page
                   		load_list_ajax(selectVO);						
                   	});
	                
	                $("#list_table").on("click","#first.on", function(){
                    	save_page = 1;
                   		$("#list_table tr:nth-child(n+2)").remove();
                   		$("#list_table").off();
                   		document.getElementById("Check_All").checked = false;
                       	check_in_out = true;
                       	selectVO={
                            page : 1,
                            select_word:selectVO.select_word,
                    		select_option:selectVO.select_option,
                    		select_auth:selectVO.select_auth,
                    		select_enabled:selectVO.select_enabled
                        }
                       	save_delete_pagein = selectVO.page
                   		load_list_ajax(selectVO);						
                   	});
	                
	                $("#list_table").on("click","#next.on", function(){
                   		$("#list_table tr:nth-child(n+2)").remove();
                   		$("#list_table").off();
                   		document.getElementById("Check_All").checked = false;
                       	check_in_out = true;
                       	save_page = 1;
                       	selectVO={
                           	page : pagingManager.nowBlock * 10 + 1,
                           	select_word:selectVO.select_word,
                    		select_option:selectVO.select_option,
                    		select_auth:selectVO.select_auth,
                    		select_enabled:selectVO.select_enabled
						}
                       	save_delete_pagein = selectVO.page
                   		load_list_ajax(selectVO);						
                   	});
	                
	                $("#list_table").on("click","#back.on", function(){
                   		$("#list_table tr:nth-child(n+2)").remove();
                   		$("#list_table").off();
                   		document.getElementById("Check_All").checked = false;
                       	check_in_out = true;
                       	save_page = 1;
                    	selectVO={
							page : (pagingManager.nowBlock -1) * 10 - 9,
							select_word:selectVO.select_word,
                    		select_option:selectVO.select_option,
                    		select_auth:selectVO.select_auth,
                    		select_enabled:selectVO.select_enabled
    					}
                    	save_delete_pagein = selectVO.page
                   		load_list_ajax(selectVO);						
                   	});
	                
	                $("#list_table").on("click","#last.on", function(){
                   		$("#list_table tr:nth-child(n+2)").remove();
                   		$("#list_table").off();
                   		document.getElementById("Check_All").checked = false;
                       	check_in_out = true;
                       	save_page = pagingManager.totalPage - (pagingManager.totalBlock - 1) * 10 
                       	selectVO={
							page : pagingManager.totalPage,
							select_word:selectVO.select_word,
                    		select_option:selectVO.select_option,
                    		select_auth:selectVO.select_auth,
                    		select_enabled:selectVO.select_enabled
    					}
                       	save_delete_pagein = selectVO.page
                   		load_list_ajax(selectVO);						
                   	});
	                
                   		$(".paging_span").addClass("on");
                   		$("#first").addClass("on");
                   		$("#next").addClass("on");
                   		$("#back").addClass("on");
                   		$("#last").addClass("on");
	                }
	            }
			}
		}
		
	</script>
	
	
	<script>
// 		memberlist
	    $(function(){
	        $("#level").change(function(){
	        	if($(this).val() == "Gold"){
		            $("#member_LV").css({"color" : "gold" , "border-color" : "gold"})
	        	}
	        	if($(this).val() == "Silver"){
		            $("#member_LV").css({"color" : "Silver" , "border-color" : "Silver"})
	        	}
	        	if($(this).val() == "Platinum"){
		            $("#member_LV").css({"color" : "mediumpurple" , "border-color" : "mediumpurple"})
	        	}
	        	if($(this).val() == "VIP"){
		            $("#member_LV").css({"color" : "tomato" , "border-color" : "tomato"})
	        	}
	            $("#member_LV").text($(this).val());
	        });
	    });
	    
    </script>
    
    
    
    
    
	<script type="text/javascript">
// 	// 쿠키 스크립트
// 	var setCookie = function(name, value, day) {
//         var date = new Date();
//         date.setTime(date.getTime() + day * 60 * 60 * 24 * 1000);
//         document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
//     };
	
//     var getCookie = function(name) {
//         var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
//         return value? value[2] : null;
//     };
    
//     var deleteCookie = function(name) {
//         var date = new Date();
//         document.cookie = name + "= " + "; expires=" + date.toUTCString() + "; path=/";
//     }
	</script>
	
	

	
</body>
</html>
