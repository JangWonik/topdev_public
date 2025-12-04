<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<!-- modal용 css 시작 -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<!-- modal용 css 끝 -->
	
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script>
		$(document).ready(function(){
			
			//목록불러오기
			getTemplateList();
			
			//서식 등록
			$("#template-add").on("click", function () {	        	
				fnTemplateIns();
	        });
			
			//검색
			$("#approval-all-btn-search").on("click",function(){					
				$("#searchForm").submit();
			});
			
			//분류 관리
			$("#template_list").on("click", function () {	        	
				location.href = "./insu4Templist";
	        });
			
		});//ready
		
		function getTemplateList(){
			
			var formData = $("#searchForm").serialize();
						
	 		$.ajax({
	 			type : "post",	 			
	 			//url : "/templateList4Ajax",
	 			url : "/templateCategoryList4Ajax",
	 			data : formData,
	 			success : function(result){			
	 				//날짜수정 페이지를 가져온다.				
	 				$("#templateList").html(result);	 				
	 			},
	 			error: function (request, status, error) {			
	 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
	 			}
	 		});
			
		}
		
		//분류수정 팝업호출
		function fnCategoryModify(p_category_cd, p_category_val){
			
			//기존 입력값 초기화
			$("#mod_category_name").val('');
			
			$("#mod_category_cd").val(p_category_cd);
			$("#before_category_val").text(p_category_val);
			
			//수정창을 생성한다			
			$("#category-mod-dialog").dialog({
				height: 200,
				width: 400,
				closeOnEscape : true,
				draggable : true,				
				appendTo : "#category4ModFrm",
				title: "자료 분류 수정",
				buttons:{
					"수정" : function(){						
						var action = fnTemplateModAction();
						if (action){
							$(this).dialog("close");
						}
					},
					"취소" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});
		}
		
		//분류삭제전 파일 체크
		function fnCategoryDel(p_category_cd){
			
			var param = {};
			param.category_id = p_category_cd;
			
			if(confirm('해당 자료분류명을 삭제 하시겠습니까?')){
				//해당 자료 분류에 속한 파일이 있는지 확인한다.
				
				$.ajax({
		 			type : "post",
		 			url : "/getCategoryList4Cnt",
		 			data : param,
		 			success : function(result){			
		 				if( result == 0 ){
		 					//자료분류명을 삭제 한다.
		 					actionCategoryDel(p_category_cd);
		 				}else{
		 					alert("총 "+result+"개의 자료가 등록되어있어 삭제가 불가능합니다. \n자료삭제 후 삭제가 가능합니다.");
		 					return;
		 				}
		 			},
		 			error: function (request, status, error) {			
		 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
		 			}
		 		});				
			}			
		}
		
		//실제자료분류명 삭제
		function actionCategoryDel(p_category_cd){
			var param = {};
			param.category_id = p_category_cd;
			
			$.ajax({
	 			type : "post",
	 			url : "/actionDelCategoryList4",
	 			data : param,
	 			success : function(result){			
	 				if( result == 1 ){
	 					alert("자료분류명을 삭제하였습니다.");
	 					//목록불러오기
	 					getTemplateList();
	 				}	 				
	 			},
	 			error: function (request, status, error) {			
	 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
	 			}
	 		});
			
		}
		
		//서식등록 
		function fnTemplateIns(){
			
			//초기화
			$("#category_name").val('');
			
			$("#category-action-dialog").dialog({
				height: 200,
				width: 400,
				closeOnEscape : true,
				draggable : true,				
				appendTo : "#category4ActionFrm",
				title: "자료 분류 등록",
				buttons:{
					"등록" : function(){
						var action = fnTemplateAction();
						if (action){
							$(this).dialog("close");
						}
					},
					"취소" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});
			
			//diaglog 내 select2 활성화
			$("#addTeamType").select2({
				dropdownParent: $("#template-action-dialog")				
			});
			
			$("#addCategoryType").select2({
				dropdownParent: $("#template-action-dialog")	
			});
		}
		
		
		
		//서식삭제
		function fnTemplateDelete(p_tkey){
			
			//var url = "/actionTemplateDel";
			var url = "/actionTemplate4Del";
			
			var param = {};
			
			param.tkey = p_tkey;			
			
			if( confirm('해당 자료를 삭제하시겠습니까?') ){
				
				$.ajax({
					type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000, 
			        success: function(data){
			        	
			        	if(data == 1){
			        		alert("자료가 삭제되었습니다.");
			        		//목록 새로고침
			        		getTemplateList();
			        	}
			        	
			        },
			        error: function(e){
			            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
			        }
			    });	
				
			}
			
		}
		
		//카테고리 수정
		function fnTemplateModAction(){
			
			//var url = "/actionTemplate4CategoryNew";
			var url = "/actionTemplate4CategoryModNew";
			
			var category_cd = $("#mod_category_cd").val();
			var category_name = $("#mod_category_name").val();
			
			var param = {};
		    
			param.category_cd = category_cd;
		    param.category_name = category_name;
		    
		    $.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        timeout: 20000,		        
		        dataType: "JSON", 
		        success: function(data){		        	
		        	if(data.result == 1){
		        		alert("자료분류가 수정되었습니다.");
		        		$("#category-mod-dialog").dialog("close");		        		
		        		//목록 새로고침
		        		getTemplateList();
		        	}
		        	
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });
			
		}
		
		//서식등록
		function fnTemplateAction(){
			
			var category_name = $("#category_name").val();			
			
			//var url = "/actionTemplate4New";
			var url = "/actionTemplate4CategoryNew";
			
			if( category_name == ''){
				alert("자료분류명을 입력해 주세요.");
				return;
			}						
			
		    var param = {};
		    
		    param.category_name = category_name;
		    
		    $.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        timeout: 20000,		        
		        dataType: "JSON", 
		        success: function(data){		        	
		        	if(data.result == 1){
		        		alert("자료분류가 등록되었습니다.");
		        		$("#category-action-dialog").dialog("close");		        		
		        		//목록 새로고침
		        		getTemplateList();
		        	}
		        	
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });
		}
	</script>
	<style>
		/* 모달창 셀렉트 박스 */
		.select2-container--default{
			text-align : left;
			font-color:#444;
			font-size:12px;
		}
		
		.btn-vacation-aprv {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:5px;
			-webkit-border-radius:5px;
			border-radius:5px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:12px;
			color:#696969  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
		}
		
		/*수정 버튼*/
		.btn-equipment-mod-s {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:5px;
			-webkit-border-radius:5px;
			border-radius:5px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:12px;
			color:#FFFFFF  !important;
			width:30px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #6633FF;
		}
		
		.btn-equipment-del-s {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:5px;
			-webkit-border-radius:5px;
			border-radius:5px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:12px;
			color:#FFFFFF  !important;
			width:30px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #FF3333;
		}			
	</style>
</head>

<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">

			<!-- left_cnt -->
			<c:import url="../top_main/top_main_left.jsp"></c:import>
			<!-- //left_cnt -->

			<!-- centercnt_top -->
			<div class="center_cnt">

				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div style="float: left;">
								<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">
								<b>(인)보험 자료실 분류 관리</b>
						</div>
						<!-- 버튼목록 시작 -->
						<table>
							<tr>
								<td>
									<div id="function-box"  align="left" style="padding-top:10px;padding-left:5px;display: inline-block">
										<a class="btn-vacation-aprv" id="template_list" href="#noloc">목록으로</a>
									</div>
								</td>
								<td align="right">
									<div id="function-box"  align="right" style="padding-top:10px;padding-right:5px;display: inline-block">
										<a class="btn-vacation-aprv" id="template-add" href="#noloc">분류 등록</a>
									</div>
								</td>
							</tr>
						</table>						
						<!-- 버튼목록 끝 -->												
						<div class="guestcnt4" style="display:block;">
							<div class="tableStyle2">
								<table>									
									<tr>
										<th width="10%">순번</th>										
										<th width="75%">자료분류명</th>										
										<th width="15%">기능</th>
									</tr>
								</table>									
								<div id="templateList" style="overflow:auto;width:100%; height:490px;"></div>
							</div><!-- //tableStyle2 -->							
						</div><!-- //guestcnt4 -->
					</div>
				</div>
				<!-- //centercnt_bot -->
				<!-- banner -->
				<c:import url="../top_main/top_main_banner.jsp"></c:import>
				<!-- //banner -->
			</div>
			<!-- //center_cnt -->
		</div>
	</div>
	<!-- //contents -->

	<!-- footer -->
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->
	
	<!-- 자료등록 팝업시작 -->
	<form id="category4ActionFrm" name="category4ActionFrm" method="post">
		<div id="category-action-dialog" title="서식등록" style="font-size: 15px;display:none;" align="center">
		<br/>
			<div class="tableStyle2">
				<table class="vacation-ins-table">					
					<tbody>
						<tr>
							<th height="40" width="40%">자료 분류명</th>
							<td width="60%">
								<input type="text" name="category_name" id="category_name" style="width:200px;" maxlength="30"/>
							</td>							
						</tr>											
					</tbody>																																																							
				</table>
			</div>
		</div>		
	</form>
	<!-- 자료분류 등록 팝업끝 -->
	
	<!-- 자료분류 수정 팝업 시작 -->
	<form id="category4ModFrm" name="category4ModFrm" method="post">
		<input type="hidden" id="mod_category_cd" name="mod_category_cd"/>		
		<!-- 서식등록 팝업시작 -->		
		<div id="category-mod-dialog" title="서식수정" style="font-size: 15px;display:none;" align="center">
		<br/>
			<div class="tableStyle2">
				<table class="vacation-ins-table">					
					<tbody>
						<tr>
							<th height="30" width="40%">기존 자료 분류명</th>
							<td width="60%">
								<span id="before_category_val" name="before_category_val" style="color:blue;"></span>
							</td>							
						</tr>
						<tr>
							<th height="30" width="40%">수정 할 자료 분류명</th>
							<td width="60%">
								<input type="text" name="mod_category_name" id="mod_category_name" style="width:200px;" maxlength="30"/>
							</td>							
						</tr>											
					</tbody>																																																							
				</table>
			</div>
		</div>		
	</form>
	<!-- 자료분류 수정 팝업 끝 -->
</div>
<!-- //wrapper -->

</body>
</html>