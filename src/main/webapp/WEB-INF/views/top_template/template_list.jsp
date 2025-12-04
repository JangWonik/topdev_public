<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
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
			//선택박스 활성화
			$("#srchTeamType").select2();
			$("#srchPtnrType").select2();
			$("#srchCategoryType").select2();
			
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
			
			//라디오버튼체크변경여부
			$("input[name='nofileChk']").change(function(){					
				
				var chk_flag = $("input[name='nofileChk']:checked").val();
				
				if( chk_flag == 1){
					$("#nofile_hide").hide();
					$("#nofile_select").show();
				}else{
					$("#nofile_hide").show();
					$("#nofile_select").hide();
				}
									
			});
				
		});
		
		
		function getTemplateList(){
			
			var formData = $("#searchForm").serialize();
						
	 		$.ajax({
	 			type : "post",
	 			url : "/templateListAjax",					
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
		
		//서식등록 
		function fnTemplateIns(){
			
			$("#template-action-dialog").dialog({
				height: 420,
				width: 800,
				closeOnEscape : true,
				draggable : true,
				appendTo : "#templateActionFrm",
				title: "서식 등록",
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
			
			$("#addPtnrType").select2({
				dropdownParent: $("#template-action-dialog")	
			});
			
			$("#addCategoryType").select2({
				dropdownParent: $("#template-action-dialog")	
			});			
			
			$("#addNoFileContent").select2({
				dropdownParent: $("#template-action-dialog")	
			});
			
		}
		
		//등록창 초기화 함수
		function fnClear(){
			//$("#addTeamType").val('');
			//$("#addPtnrType").val('');
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
		
		//서식등록
		function fnTemplateAction(action){
			
			var team_type = $("#addTeamType").val();
			var ptnr_type = $("#addPtnrType").val();
			var category_type = $("#addCategoryType").val();
			var user_no = $("#addUserNo").val();
			
			var file_name = $('#template_file').val();
			
			//안내문구 사용여부			
			var chk_flag = $("input[name='nofileChk']:checked").val();
			var nofile_content = $("#addNoFileContent").val();
			
			//var url = "/actionVacationNew";
			var url = "/actionTemplateNew";
			
			if( action == "D" ){
				url = "/actionVacationCancel";	
			}
			
			if( team_type == 0 ){
				alert("구분값을 선택해주세요.");
				return;
			}
			
			if( ptnr_type == 0 ){
				alert("보험사명을 선택해주세요.");
				return;
			}
			
			if( category_type == 0 ){
				alert("서식을 선택해주세요.");
				return;
			}
			
			if( chk_flag == 0 ){
				if( file_name == '' ){
					alert("파일을 선택해주세요.");
					return;
				}
				//안내문구 0으로 초기화
				nofile_content = 0;
			}else{
				if( nofile_content == 0 ){
					alert("안내문구를 선택해주세요.");
					return;
				}
			}
			
		    var param = new FormData();
		    
		    var templateFile = $('#template_file')[0].files[0];
		    param.append('templateFile', templateFile);
		    
		    //첨부파일
		    param.append("action",action);
		    
		    if (action == 'U'|| action == 'D' ||action == 'FD'){
		    	param.append("tkey", $("#tkey").val());
		    }
		    
		    param.append("user_no", user_no);
		    param.append("team_type", team_type);
		    param.append("ptnr_type", ptnr_type);
		    param.append("category_type", category_type);
		    param.append("nofile_content", nofile_content);
		    
			//var pageIdx = $("#currPageIdx").val();
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
		        		alert("서식이 등록되었습니다.");
		        		$("#template-action-dialog").dialog("close");
		        		fnClear();
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
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">보험사 서식관리</a></li>
							</ul>
						</div>
						<!-- 검색창 시작 -->						
						<form id="searchForm" name="searchForm" method="post" action="insuTemplist">
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
									<th width="10%">보험사명</th>
									<td width="25%">										
										<select id="srchPtnrType" name="srchPtnrType" style="width: 170px;">
											<option value="0">- 전체 -</option>
											<c:forEach items="${ptnrListForSearch}" var="ptnrVo">
												<option value="${ptnrVo.ptnr_id}"
													<c:if test="${ptnrVo.ptnr_id == searchParam.srchPtnrType}">selected</c:if>>
													<c:if test="${ptnrVo.ptnr_level == 1}">&nbsp;└</c:if>
													${ptnrVo.ptnr_nick}
												</option>
											</c:forEach>
										</select>
									</td>
									<th width="10%">서식종류</th>
									<td width="25%">
										<select id="srchCategoryType" name="srchCategoryType" style="width: 190px;">
											<option value="0">- 전체 -</option>
											<c:forEach items="${categoryListForSearch}" var="categoryVo">
												<option value="${categoryVo.col_cd}" <c:if test="${categoryVo.col_cd == searchParam.srchCategoryType}">selected</c:if>>${categoryVo.col_val}</option>
											</c:forEach>
										</select>
									</td>
									<td width="10%">
										<a class="btn-vacation-aprv" id="approval-all-btn-search" href="#noloc">검색</a>
									</td>
								</tr>
							</table>
						</div>
						</form>
						<!-- 검색창 끝 -->
						<!-- 버튼목록 시작 -->
						<div id="function-box"  align="right" style="padding-top:10px;padding-right:5px;">
							<a class="btn-vacation-aprv" id="template-add" href="#noloc">서식 등록</a>
						</div>
						<!-- 버튼목록 끝 -->												
						<div class="guestcnt4" style="display:block;">
							<div class="tableStyle2">
								<table>									
									<tr>
										<th width="5%">구분</th>
										<th width="15%">보험사명</th>
										<th width="15%">서식종류</th>
										<th width="35%">파일명</th>
										<th width="10%">등록일</th>
										<th width="10%">등록자</th>
										<th width="10%">기능</th>
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
	<form id="templateActionFrm" name="templateActionFrm" method="post">
		<input type="hidden" id="addUserNo" name="addUserNo" value="${mbrVo_Session.user_no}"/>
		<!-- 서식등록 팝업시작 -->		
		<div id="template-action-dialog" title="서식등록" style="font-size: 15px;display:none;" align="center">
		<br/>
			<div class="tableStyle2">
				<table class="vacation-ins-table">					
					<tbody>
						<tr>
							<th width="15%">구분</th>
							<td width="25%">
								<select id="addTeamType" name="addTeamType" style="width: 80px;">
									<c:choose>
										<c:when test="${authTeamType eq 1}">
											<option value="1">1종</option>
										</c:when>
										<c:when test="${authTeamType eq 4}">
											<option value="4">4종</option>
										</c:when>
										<c:otherwise>
											<option value="0">- 선택 -</option>
											<option value="1">1종</option>
											<option value="4">4종</option>
										</c:otherwise>
									</c:choose>																																		
								</select>
							</td>
							<th width="20%">보험사명</th>
							<td width="40%">										
								<select id="addPtnrType" name="addPtnrType" style="width: 280px;">
									<option value="0">- 선택 -</option>
									<c:forEach items="${ptnrListForSearch}" var="ptnrVo">
										<option value="${ptnrVo.ptnr_id}"
											<c:if test="${ptnrVo.ptnr_id == ptnrSrc}">selected</c:if>
										>
											<c:if test="${ptnrVo.ptnr_level == 1}">&nbsp;└</c:if>
											${ptnrVo.ptnr_nick}
										</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th width="15%">등록자</th>
							<td width="25%">${mbrVo_Session.user_name}</td>							
							<th width="20%">서식</th>
							<td width="40%">
								<select id="addCategoryType" name="addCategoryType" style="width: 280px;">
									<option value="0">- 선택 -</option>
									<c:forEach items="${categoryListForSearch}" var="categoryVo">
										<option value="${categoryVo.col_cd}">${categoryVo.col_val}</option>
									</c:forEach>
								</select>
							</td>					
						</tr>
						<tr>
							<th width="15%">표시방법</th>
							<td>
								<input type="radio" name="nofileChk" id="nofileChk_0" value="0" checked> 파일다운로드<br/>
								<input type="radio" name="nofileChk" id="nofileChk_1" value="1"> 안내문구표시
							</td>
							<th>안내문구</th>
							<td>
								<div id="nofile_hide">첨부된 파일명으로 표시됩니다.</div>
								<div id="nofile_select" style="display:none;">							
									<select id="addNoFileContent" name="addNoFileContent" style="width: 280px;">
										<option value="0">- 선택하세요. -</option>
										<c:forEach items="${noFileContentListForSearch}" var="noFileVo">
											<option value="${noFileVo.col_cd}">${noFileVo.col_val}</option>
										</c:forEach>
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<th height="25px;">파일</th>
							<td style="text-align:left;padding-left: 30px;" colspan="3">
								<input type="file" id="template_file" name="template_file" style="width: 90%;">
							</td>
						</tr>					
					</tbody>																																																							
				</table>
			</div>
		</div>
		<!-- 서식등록 팝업끝 -->
	</form>
	<form id="filedownForm" name="filedownForm" action="insuTemplateFiledown">
		<input type="hidden" id="tkey" name="tkey"/>
	</form>

</div>
<!-- //wrapper -->

</body>
</html>