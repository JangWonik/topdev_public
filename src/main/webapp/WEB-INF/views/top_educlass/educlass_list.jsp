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
	<style type="text/css">
		.buttonEduView{
			width:65px;
			height:23px;
		    background-color:#3232FF;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
		.buttonEduDown{
			width:65px;
			height:23px;
		    background-color:#FF0099;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
	</style>		    
	<!-- modal용 css 끝 -->
	
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script>
		$(document).ready(function(){				
			//선택박스 활성화
			$("#srchTeamType").select2();			
			$("#srchCategoryType").select2();
			
			//목록불러오기			
			getEduClassList();
			
			//서식 등록
			$("#template-add").on("click", function () {	        	
				fnTemplateIns();
	        });
			
			//검색
			$("#approval-all-btn-search").on("click",function(){					
				$("#searchForm").submit();
			});			
		});
		
		//새창으로 시청하기
		function openEduView( ekey ){
			$("#ekey").val(ekey);
			
			var viewForm = document.eduViewForm;
			var url = 'eduClassView';
			window.open('', 'popEduView','width=1070,height=830,scrollbars=no,resizable=no,status=yes,menubar=no,toolbar=no,top=50,left=50');
			viewForm.action = url;
			viewForm.method = 'post';
			viewForm.target = 'popEduView';
			viewForm.submit();			
		}
		
		//교육자료 다운받기
		function reportDown( p_ekey ){
			$('#eduFileForm [name="ekey"]').val(p_ekey);
			$('#eduFileForm').submit();
		}
		
		//좌측 교육분류 메뉴 클릭시
		function selEcu( category_key ){			
			$("#srchCategoryType").val(category_key);
			$("#srchCategoryType").trigger('change');
			getEduClassList();
		}
		
		//교육자료 목록 가져오기
		function getEduClassList(){
			var formData = $("#searchForm").serialize();
			$.ajax({
	 			type : "post",
	 			url : "/eduClassListAjax",					
	 			data : formData,
	 			success : function(result){			
	 				//날짜수정 페이지를 가져온다.				
	 				$("#eduClassList").html(result);	 				
	 			},
	 			error: function (request, status, error) {			
	 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
	 			}
	 		});
		}
		
		//서식등록 
		function fnTemplateIns(){
			
			$("#template-action-dialog").dialog({
				height: 400,
				width: 700,
				closeOnEscape : true,
				draggable : true,
				appendTo : "#templateActionFrm",
				title: "교육자료 등록",
				buttons:{
					"등록" : function(){
						var action = fnTemplateAction('C');
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
		
		//등록창 초기화 함수
		function fnClear(){
			$("#addCategoryType").val(0);
			$('#template_file').val('');
		}
		
		//서식다운로드
		function fnTemplateDown(p_tkey){			
			$('#filedownForm [name="tkey"]').val(p_tkey);
			$('#filedownForm').submit();			
		}
		
		//서식삭제
		function fnTemplateDelete(p_tkey){
			
			var url = "/actionTemplateDel";
			
			var param = {};
			
			param.tkey = p_tkey;			
			
			if( confirm('해당 서식을 삭제하시겠습니까?') ){
				
				$.ajax({
					type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000, 
			        success: function(data){
			        	
			        	if(data == 1){
			        		alert("서식이 삭제되었습니다.");
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
		
		//교육자료 등록
		function fnTemplateAction(action){
			
			var team_type = $("#addTeamType").val();			
			var category_id = $("#addCategoryType").val();
			var user_no = $("#addUserNo").val();
			
			var file_path = $("#addFilePath").val();
			var teacher_name = $("#addTeacherName").val();
			var file_name = $("#addFileName").val();						
			
			//var url = "/actionTemplateNew";
			var url = "/actionEduClassNew";
			
			if( action == "D" ){
				//url = "/actionVacationCancel";
				url = "/actionEduClassCancel";
			}
			
			if( category_id == '' ){
				alert("교육분류를 선택해주세요.");
				return;
			}
			
			if( file_path == '' ){
				alert("업로드된 파일명을 입력해주세요.");
				return;
			}
			
			if( teacher_name == '' ){
				alert("강사명을 입력해주세요.");
				return;
			}
			
			if( file_name == '' ){
				alert("교육 과정명을 입력해주세요.");
				return;
			}
			
		    var param = new FormData();
		    
		    param.append("action",action);
		    param.append("team_type", team_type);
		    param.append("category_id", category_id);
		    param.append("user_no", user_no);
		    param.append("file_path", file_path);	
		    param.append("teacher_name", teacher_name);
		    param.append("file_name", file_name);
		    
		    $.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        timeout: 20000,
		        processData: false,
		        contentType: false,
		        dataType: "JSON", 
		        success: function(data){
		        	
		        	if(data.result == 1){
		        		alert("교육자료정보가 등록되었습니다.");
		        		$("#template-action-dialog").dialog("close");
		        		fnClear();
		        		//목록 새로고침
		        		getEduClassList();
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

			<!-- 좌측메뉴 -->
			<c:import url="../top_educlass/top_edu_left.jsp"></c:import>
			<!-- //left_cnt -->

			<!-- centercnt_top -->
			<div class="center_cnt">

				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">교육자료 목록</a></li>
							</ul>
						</div>
						<!-- 검색창 시작 -->						
						<form id="searchForm" name="searchForm" method="post" action="eduClass">
						<div id="search-box"  align="center" style="padding-top:10px;">
							<table style="width: 100%;" align="center" class="tableStyle2">											
								<tr>
									<th width="8%">구분</th>
									<td width="12%">
										<select id="srchTeamType" name="srchTeamType" style="width: 80px;">
											<c:choose>
												<c:when test="${authTeamType eq 1}">
													<option value="1">1종</option>
												</c:when>
												<c:when test="${authTeamType eq 4}">
													<option value="4">4종</option>
												</c:when>
												<c:otherwise>
													<option value="5" <c:if test="${searchParam.srchTeamType == 0}">selected</c:if>>- 전체 -</option>
													<option value="1" <c:if test="${searchParam.srchTeamType == 1}">selected</c:if>>1종</option>
													<option value="4" <c:if test="${searchParam.srchTeamType == 4}">selected</c:if>>4종</option>
												</c:otherwise>
											</c:choose>																						
										</select>
									</td>									
									<th width="8%">분류</th>
									<td width="19%">
										<select id="srchCategoryType" name="srchCategoryType" style="width: 140px;">
											<option value="">- 전체 -</option>
											<c:forEach items="${categoryListForSearch}" var="categoryVo">
												<option value="${categoryVo.col_cd}" <c:if test="${categoryVo.col_cd == searchParam.srchCategoryType}">selected</c:if>>${categoryVo.col_val} 교육</option>
											</c:forEach>
										</select>
									</td>
									<th width="8%">과정명</th>
									<td width="25%"><input type="text" id="srchFileName" name="srchFileName" style="width: 190px;" value="${searchParam.srchFileName}"/></td>
									
									<th width="8%">강사명</th>
									<td width="12%"><input type="text" id="srchTeacherName" name="srchTeacherName" style="width: 90px;" value="${searchParam.srchTeacherName}"/></td>
									<td width="10%">
										<a class="btn-vacation-aprv" id="approval-all-btn-search" href="#noloc">검색</a>
									</td>
								</tr>
							</table>
						</div>
						</form>
						<!-- 전산지원팀만 자료등록 가능 -->						
						<c:if test="${mbrVo_Session.user_state == 9}">
							<div id="function-box"  align="right" style="padding-top:10px;padding-right:5px;">
								<a class="btn-vacation-aprv" id="template-add" href="#noloc">자료 등록</a>
							</div>						
						</c:if>
						<div class="guestcnt4" style="display:block;">
							<div class="tableStyle2">
								<table>									
									<tr>
										<th width="5%">NO</th>
										<th width="15%">분류</th>
										<th width="45%">과정명</th>
										<th width="10%">강사</th>
										<th width="10%">등록일</th>
										<th width="15%">비고</th>
									</tr>
								</table>									
								<div id="eduClassList" style="overflow:auto;width:100%; height:490px;"></div>
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
	<form id="templateActionFrm" name="templateActionFrm" method="post">
		<input type="hidden" id="addUserNo" name="addUserNo" value="${mbrVo_Session.user_no}"/>
		<!-- 서식등록 팝업시작 -->		
		<div id="template-action-dialog" title="교육자료 등록" style="font-size: 15px;display:none;" align="center">
		<br/>
			<div class="tableStyle2">
				<table class="vacation-ins-table">					
					<tbody>
						<tr>
							<th width="15%">구분</th>
							<td width="25%">
								<select id="addTeamType" name="addTeamType" style="width: 120px;">
									<c:choose>
										<c:when test="${authTeamType eq 1}">
											<option value="0">- 공통 -</option>
											<option value="1">1종</option>
										</c:when>
										<c:when test="${authTeamType eq 4}">
											<option value="0">- 공통 -</option>
											<option value="4">4종</option>
										</c:when>
										<c:otherwise>
											<option value="0">- 공통 -</option>
											<option value="1">1종</option>
											<option value="4">4종</option>
										</c:otherwise>
									</c:choose>																																		
								</select>
							</td>
							<th width="15%">교육분류</th>
							<td width="45%" align="left">										
								<select id="addCategoryType" name="addCategoryType" style="width: 260px;">
									<option value="">- 선택 -</option>
									<c:forEach items="${categoryListForSearch}" var="categoryVo">
										<option value="${categoryVo.col_cd}">${categoryVo.col_val} 교육</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th width="15%">등록자</th>
							<td width="25%">${mbrVo_Session.user_name}</td>							
							<th width="15%">링크명</th>
							<td width="45%"><input type="text" id="addFilePath" name="addFilePath" style="width:260px;"/></td>					
						</tr>
						<tr>
							<th width="15%">강사명</th>
							<td width="25%"><input type="text" id="addTeacherName" name="addTeacherName"/></td>							
							<th width="15%">과정명</th>
							<td width="45%"><input type="text" id="addFileName" name="addFileName" style="width:260px;"/></td>					
						</tr>
					</tbody>																																																							
				</table>
				<br/>
				<table class="vacation-ins-table">
					<tr>
						<th style="text-align:left;padding-left:5px;line-height: 1.5em;">
							※ 유튜브 업로드 후  (예 : https://youtu.be/<font color="blue">1KfABxKpLnI</font>) 링크의 파란부분을 입력해 주세요.
						</th>
					</tr>
				</table>				
			</div>
		</div>
	</form>
	<form id="eduViewForm" name="eduViewForm">
		<input type="hidden" id="ekey" name="ekey"/>
	</form>
	<form id="eduFileForm" name="eduFileForm" action="eduClassFiledown">
		<input type="hidden" id="ekey" name="ekey"/>
	</form>
</div>
<!-- //wrapper -->

</body>
</html>