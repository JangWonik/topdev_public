<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>공개교육관리</title>
    <link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=20170411111520" />
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->

    <script src="./resources/jquery/jquery.min_1_12.js"></script>
    <script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
    <script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->
    <script src="./resources/jquery/jquery.mask.min.js"></script>

    <script src="./resources/wm_js/common.js"></script>
    <script src="./resources/cmm/js/common.js"></script>

	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	<style>
	
		/* 모달창 셀렉트 박스 */
		.select2-container--default{
			text-align : left;
			font-color:#444;
			font-size:12px;
		}
		
		/*상세보기 버튼*/
		.btn-equipment-view {
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
		
		/*보기 녹색 버튼*/
		.btn-equipment-green {
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
			width:100px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #009966;
		}
		
		/*수정 버튼*/
		.btn-equipment-mod {
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
			width:100px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #0033FF;
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
		
		.btn-equipment-cancel-s {
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
			background: #FF0099;
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
		
		/*저장 버튼*/
		.btn-equipment-save {
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
			width:100px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #3399FF;
		}
		
		/*저장 버튼*/
		.btn-equipment-save-s {
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
			background: #3399FF;
		}
		
		/*취소 버튼*/
		.btn-equipment-cancel {
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
			width:50px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #FF3333;
		}
	
		.td-overflow-none{
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
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

		.btn-vacation-aprv:active {
			position:relative;
			top:4px
		}
		
		/* 모달 버튼 */
		.ui-button-text-only {
			height:2.1em !important;
		}
	</style>
	<script>
	$(document).ready(function(){		
		doSearchList();
	});
	
	function doSearchList(){
		
		var param = {};
		
		var sUrl = "./getLectureOpenListAjax";
		
		$.ajax({
			type: "POST",
			url: sUrl,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "html",
			timeout: 20000,
			success: function(data){				
				$("#lectureOpenList").html(data);    			
			},            		
			error: function (request, status, error) {
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
			}
		});
		
	}
	
	//공개교육추가
	function openAdd(){
		//등록폼 초기화
		$("#team_type").val('').select2();
		$("#category_type").val('').select2();
		$("#subject").val('');
		$("#introduce").val('');
		$("#manager_name").val('');
		$("#link_path").val('');
		$("#attach_file").val('');
		$("#attach_file_form").hide();
		
		$("#open-action-dialog").dialog({
			height: 350,
			width: 650,
			closeOnEscape : true,
			draggable : true,
			appendTo : "#openLectureActionFrm",
			title: "공개교육등록",
			buttons:{
				"교육등록" : function(){
					var action = fnOpenAction('I');		//등록
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
		$("#team_type").select2({
			dropdownParent: $("#open-action-dialog")				
		});
		
		$("#category_type").select2({
			dropdownParent: $("#open-action-dialog")				
		});
	}
	
	//공개교육 수정
	function doOpenModify( p_okey ){
		
		var sUrl = "getLectureOpenInfo";
		
		var param = {};
		param.okey = p_okey;
		
		$.ajax({
	        type: "POST",
	        url: sUrl,
	        data: param,		         
	        dataType: "JSON", 
	        success: function(data){	        		
	    		//alert(JSON.stringify(data));
	    		//alert("data="+data.manager_pwd);
	    		
	    		//수정폼 설정
	    		$("#okey_val").val(data.okey);        		
	    		$("#team_type").val(data.team_type).select2();
	    		$("#category_type").val(data.ckey).select2();
	    		$("#subject").val(data.subject);
	    		$("#introduce").val(data.introduce);
	    		$("#manager_name").val(data.manager_name);
	    		$("#link_path").val(data.link_path);	    		
	    		
	    		if( data.file_org_name == '' || data.file_org_name == 'null' ){
	    			$("#attach_file").val('');
	    			$("#attach_file").show();
	    			$("#attach_file_form").hide();
	    		}else{
	    			$("#attach_file").hide();
	    			var attach_url = "<a href='oOpenFileDownload?okey="+data.okey+"'>"
	    					+data.file_org_name+"</a>&nbsp;<img src='./resources/ls_img/btn_del_s.gif' class='btn_file_del' style='cursor:pointer' onclick='javascript:doOpenAttachDeleteModal("+data.okey+");'/>";	    			
	    			$("#attach_file_form").html(attach_url);
	    			$("#attach_file_form").show();
	    		}
	    		
				$("#open-action-dialog").dialog({
					height: 350,
					width: 650,
					closeOnEscape : true,
					draggable : true,
					appendTo : "#openLectureActionFrm",
					title: "공개교육수정",
					buttons:{
						"교육수정" : function(){
							var action = fnOpenAction('U');		//수정
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
	        },
	        error: function(e){
	            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	        }
	        
		});
		
		//diaglog 내 select2 활성화
		$("#team_type").select2({
			dropdownParent: $("#open-action-dialog")				
		});
		
		$("#category_type").select2({
			dropdownParent: $("#open-action-dialog")				
		});
	}
	
	//공개교육삭제
	function doOpenDelete( p_okey , p_subject ){
		
		if( !confirm( p_subject+" 교육를 삭제하시겠습니까?") ){
			return;
		}		
		
		var param = {};		
		
		param.action = "D";
		param.okey = p_okey;		
				
		var url = "./lectureOpenAction";

	    $.ajax({
			type: "POST",
			url: url,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "html",			
			timeout: 20000,
			success: function(data){
				if( data ){		//1인 경우 성공 
					alert("공개교육정보를 삭제하였습니다.");					
					doSearchList();
				}
			}                
	    });
	}
	
	//모달창 첨부파일 삭제
	function doOpenAttachDeleteModal( p_okey ){
		
		if( !confirm( "첨부된 파일을 삭제하시겠습니까?") ){
			return;
		}		
		
		var param = {};		
		
		param.action = "DF";				//첨부파일만 삭제하는 경우
		param.okey = p_okey;		
				
		var url = "./lectureOpenAction";

	    $.ajax({
			type: "POST",
			url: url,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "html",			
			timeout: 20000,
			success: function(data){
				if( data ){		//1인 경우 성공 
					$("#open-action-dialog").dialog("close");
					doSearchList();					
					doOpenModify( p_okey );
				}
			}                
	    });
	}
	
	//첨부파일만 삭제
	function doOpenAttachDelete( p_okey , p_filename){
		
		if( !confirm( p_filename+" 첨부된 파일을 삭제하시겠습니까?") ){
			return;
		}		
		
		var param = {};		
		
		param.action = "DF";				//첨부파일만 삭제하는 경우
		param.okey = p_okey;		
				
		var url = "./lectureOpenAction";

	    $.ajax({
			type: "POST",
			url: url,
			data: param,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "html",			
			timeout: 20000,
			success: function(data){
				if( data ){		//1인 경우 성공 
					alert("첨부파일을 삭제하였습니다.");					
					doSearchList();
				}
			}                
	    });
	}
	
	function fnOpenAction( p_action ){
		
		var okeyVal = $("#okey_val").val();
		var teamTypeVal = $("#team_type").val();
		var categoryTypeVal = $("#category_type").val();
		var subjectVal = $("#subject").val();
		var introduceVal = $("#introduce").val();
		var managerNameVal = $("#manager_name").val();
		var linkPathVal = $("#link_path").val();		
		
		if( p_action == 'I' || p_action == 'U' ){			//등록저장 또는 수정인 경우 유효성 체크
			
			if( teamTypeVal == '' ){
				alert('교육 구분을 선택해주세요');
				$("#team_type").focus();
				return;
			}
		
			if( categoryTypeVal == '' ){
				alert('교육 분류를 선택해주세요');
				$("#category_type").focus();
				return;
			}
			
			if( subjectVal == '' ){
				alert('강의명을 입력해주세요');
				$("#subejct").focus();
				return;
			}
			
			if( introduceVal == ''){
				alert('강의 설명을 입력해주세요');
				$("#introduce").focus();
				return;
			}
			
			if( managerNameVal == '' ){
				alert('강사명을 입력해주세요');
				$("#manager_name").val();
				return;
			}
			
			if( linkPathVal == '' ){
				alert('링크주소를 입력해주세요');
				$("#link_path").focus();
				return;
			}
		
		}
		
		var param = new FormData();
		
		param.append("okey", okeyVal);
		param.append("action", p_action);
		param.append("team_type", teamTypeVal);
		param.append("ckey", categoryTypeVal);
		param.append("subject", subjectVal);
		param.append("introduce", introduceVal);
		param.append("manager_name", managerNameVal);
		param.append("link_path", linkPathVal);
		param.append("attach_file", $("#attach_file")[0].files[0]);
		
		var sUrl = "./lectureOpenAction";
		
		$.ajax({
			type: "POST",
	        url: sUrl,
	        data: param,
	        timeout: 20000,
	        processData: false,
	        contentType: false,
	        dataType: "JSON",
			success: function(data){
				if( data ){		//1인 경우 추가 
					alert("공개교육정보를 추가하였습니다.");
					$("#open-action-dialog").dialog("close");
					doSearchList();					
				}
			}                
	    });		
		
	}
	</script>
</head>
<body>
<div id="wrapper">
	<!-- top menu import -->
	<c:import url="../top_lecture/lecture_menu.jsp"></c:import>
	<!-- contents -->
	<div id="container">
		<div class="contetns">
		<!-- centercnt_top -->
			<div class="center_cnt_1300">
				<!-- centercnt_bot -->
				<div class="center_cnt_vacation" >
					<div class="guest">
						<div style="float: left;padding:10px 0 10px;">
							<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" >
							&nbsp;&nbsp;<b>공개교육관리</b>								
                          	</div>
					</div>
					<!-- 탭 메뉴 시작 -->
					<div class="centercnt_bot2">
						<div class="guest">															
							<div class="guestcnt2">									
								<!-- 교육정보 시작 -->
									<div id="addInfoButton" style="text-align:right;padding:0 0 5px 0;">
										<a href="#noloc" class="btn-equipment-save" id="btn-search" onclick='javascript:openAdd();'>공개교육등록</a>
									</div>
									<div class="tableStyle99">
										<table>
											<tr>
												<th width="7%">No</th>
												<th width="7%">교육구분</th>
												<th width="10%">교육분류</th>
												<th width="20%">강의명</th>
												<th width="10%">강사명</th>
												<th width="10%">링크주소</th>												
												<th width="8%">등록일</th>			
												<th width="18%">첨부파일</th>
												<th width="10%">-</th>
											</tr>		
										</table>
									<div id="lectureOpenList"></div>
								</div>	
							</div>							
						</div>
					</div>					
					<!-- 탭 메뉴 끝 -->
				</div>
			</div>
		</div>
		<!-- //통합로딩바 -->
		<div id="top_loading" style="display: none;">
			<img id="loading-image" src="/resources/cmm/images/spinner.gif" alt="Loading..." />
		</div>
		<!-- //통합로딩바끝 -->
	</div>
	<!-- 공개교육 등록폼 시작 -->
	<form id="openLectureActionFrm">
	<input type="hidden" id="okey_val" name="okey_val"/>		
	<div id="open-action-dialog" title="공개교육등록" style="font-size: 15px;display:none;" align="center">		
		<br/>
		<div class="tableStyle2" style="width: 620px;">
			<table class="vacation-ins-table">
				<colgroup>
					<col style="width:15%;">
					<col style="width:35%;">
					<col style="width:15%;">
					<col style="width:35%;">										
				</colgroup>
				<tbody>
				<tr>
					<th>교육구분</th>
					<td style="text-align:left;padding-left: 5px;font-weight:bold;">
						<select id="team_type" name="team_type" style="width:200px;">
							<option value="">전체</option>
							<option value="0">공통</option>
							<option value="1">물보험</option>
							<option value="4">인보험</option>
						</select>
					</td>
					<th>교육분류</th>
					<td style="text-align:left;padding-left: 5px;font-weight:bold;">
						<select id="category_type" name="category_type" style="width: 200px;">
							<option value="">- 전체 -</option>
							<c:forEach items="${selCategoryList}" var="categoryVo">
								<option value="${categoryVo.ckey}" >${categoryVo.category_name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>강의명</th>
					<td colspan="3" style="text-align:left;padding-left: 5px;font-weight:bold;">
						<input type="text" id="subject" name="subject" style="width:500px;"/>
					</td>
				</tr>
				<tr>
					<th>강의설명</th>
					<td colspan="3" style="text-align:left;padding-left: 5px;font-weight:bold;">
						<input type="text" id="introduce" name="introduce" style="width:500px;"/>
					</td>
				</tr>
				<tr>
					<th>강사명</th>
					<td colspan="3" style="text-align:left;padding-left: 5px;font-weight:bold;">
						<input type="text" id="manager_name" name="manager_name" style="width:500px;"/>
					</td>
				</tr>
				<tr>
					<th>링크주소</th>
					<td colspan="3" style="text-align:left;padding-left: 5px;font-weight:bold;">
						<input type="text" id="link_path" name="link_path" style="width:500px;"/>
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td colspan="3" style="text-align:left;padding-left: 5px;font-weight:bold;">
						<input type="file" id="attach_file" name="attach_file" style="width: 90%;">
						<span id="attach_file_form"></span>
					</td>
				</tr>
				</tbody>																																																		
				</table>
			</div>			
		</div>		
	</form>
	<!-- 공개교육 등록 폼 끝 -->
</div>
</body>
</html>