<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<style>
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
			color:#696969;
			width:50px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
		}	
		/*등록 버튼*/
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
			width:80px;
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
	</style>	

	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_state}' == 9 || '${mbrVo_Session.user_no}' == 215
					|| '${mbrVo_Session.user_no}' == 4 || '${mbrVo_Session.user_no}' == 62){
				//ok
			}else{
				alert("권한이 없습니다.");
				window.self.close();
			}

			$("#rptEditCheckAll").change(function(){
				if($("#rptEditCheckAllFlag").val() == 0){
					$("#rptEditCheckAllFlag").val("1")
					for(i = 0; i < rptEditForm.cb_rpt_edit.length; i++){
						rptEditForm.cb_rpt_edit[i].checked = true;
					}
				}else{
					$("#rptEditCheckAllFlag").val("0")
					for(i = 0; i < rptEditForm.cb_rpt_edit.length; i++){
						rptEditForm.cb_rpt_edit[i].checked = false;
					}
				}
			});

			$("#rptLsAdmin7CheckAll").change(function(){
				if($("#rptLsAdmin7CheckAllFlag").val() == 0){
					$("#rptLsAdmin7CheckAllFlag").val("1")
					for(i = 0; i < rptLsAdmin7Form.cb_ls_admin7.length; i++){
						rptLsAdmin7Form.cb_ls_admin7[i].checked = true;
					}
				}else{
					$("#rptLsAdmin7CheckAllFlag").val("0")
					for(i = 0; i < rptLsAdmin7Form.cb_ls_admin7.length; i++){
						rptLsAdmin7Form.cb_ls_admin7[i].checked = false;
					}
				}
			});

			$("#rptLsAdmin9CheckAll").change(function(){
				if($("#rptLsAdmin9CheckAllFlag").val() == 0){
					$("#rptLsAdmin9CheckAllFlag").val("1")
					for(i = 0; i < rptLsAdmin9Form.cb_ls_admin9.length; i++){
						rptLsAdmin9Form.cb_ls_admin9[i].checked = true;
					}
				}else{
					$("#rptLsAdmin9CheckAllFlag").val("0")
					for(i = 0; i < rptLsAdmin9Form.cb_ls_admin9.length; i++){
						rptLsAdmin9Form.cb_ls_admin9[i].checked = false;
					}
				}
			});

			$("#rptLsAdmin10CheckAll").change(function(){
				if($("#rptLsAdmin10CheckAllFlag").val() == 0){
					$("#rptLsAdmin10CheckAllFlag").val("1")
					for(i = 0; i < rptLsAdmin10Form.cb_ls_admin10.length; i++){
						rptLsAdmin10Form.cb_ls_admin10[i].checked = true;
					}
				}else{
					$("#rptLsAdmin10CheckAllFlag").val("0")
					for(i = 0; i < rptLsAdmin10Form.cb_ls_admin10.length; i++){
						rptLsAdmin10Form.cb_ls_admin10[i].checked = false;
					}
				}
			});

			$("#rptLsAdmin11CheckAll").change(function(){
				if($("#rptLsAdmin11CheckAllFlag").val() == 0){
					$("#rptLsAdmin11CheckAllFlag").val("1")
					for(i = 0; i < rptLsAdmin11Form.cb_ls_admin11.length; i++){
						rptLsAdmin11Form.cb_ls_admin11[i].checked = true;
					}
				}else{
					$("#rptLsAdmin11CheckAllFlag").val("0")
					for(i = 0; i < rptLsAdmin11Form.cb_ls_admin11.length; i++){
						rptLsAdmin11Form.cb_ls_admin11[i].checked = false;
					}
				}
			});
			
			$("#rptLsAdmin22CheckAll").change(function(){
				if($("#rptLsAdmin22CheckAllFlag").val() == 0){
					$("#rptLsAdmin22CheckAllFlag").val("1")
					for(i = 0; i < rptLsAdmin22Form.cb_ls_admin22.length; i++){
						rptLsAdmin22Form.cb_ls_admin22[i].checked = true;
					}
				}else{
					$("#rptLsAdmin22CheckAllFlag").val("0")
					for(i = 0; i < rptLsAdmin22Form.cb_ls_admin22.length; i++){
						rptLsAdmin22Form.cb_ls_admin22[i].checked = false;
					}
				}
			});
			
			$("#rptLsAdmin23CheckAll").change(function(){
				if($("#rptLsAdmin23CheckAllFlag").val() == 0){
					$("#rptLsAdmin23CheckAllFlag").val("1")
					for(i = 0; i < rptLsAdmin23Form.cb_ls_admin23.length; i++){
						rptLsAdmin23Form.cb_ls_admin23[i].checked = true;
					}
				}else{
					$("#rptLsAdmin23CheckAllFlag").val("0")
					for(i = 0; i < rptLsAdmin23Form.cb_ls_admin23.length; i++){
						rptLsAdmin23Form.cb_ls_admin23[i].checked = false;
					}
				}
			});
			
			$("#rptLsAdmin24CheckAll").change(function(){
				if($("#rptLsAdmin24CheckAllFlag").val() == 0){
					$("#rptLsAdmin24CheckAllFlag").val("1")
					for(i = 0; i < rptLsAdmin24Form.cb_ls_admin24.length; i++){
						rptLsAdmin24Form.cb_ls_admin24[i].checked = true;
					}
				}else{
					$("#rptLsAdmin24CheckAllFlag").val("0")
					for(i = 0; i < rptLsAdmin24Form.cb_ls_admin24.length; i++){
						rptLsAdmin24Form.cb_ls_admin24[i].checked = false;
					}
				}
			});
			
			$("#rptLsAdminQuickCheckAll").change(function(){
				if($("#rptLsAdminQuickCheckAllFlag").val() == 0){
					$("#rptLsAdminQuickCheckAllFlag").val("1")
					for(i = 0; i < rptLsAdminQuickForm.cb_ls_admin_quick.length; i++){
						rptLsAdminQuickForm.cb_ls_admin_quick[i].checked = true;
					}
				}else{
					$("#rptLsAdminQuickCheckAllFlag").val("0")
					for(i = 0; i < rptLsAdminQuickForm.cb_ls_admin_quick.length; i++){
						rptLsAdminQuickForm.cb_ls_admin_quick[i].checked = false;
					}
				}
			});
			
			$("#rptLsAdminVacation1CheckAll").change(function(){
				if($("#rptLsAdminVacation1CheckAllFlag").val() == 0){
					$("#rptLsAdminVacation1CheckAllFlag").val("1")
					for(i = 0; i < rptLsAdminVacation1Form.cb_ls_admin_vacation1.length; i++){
						rptLsAdminVacation1Form.cb_ls_admin_vacation1[i].checked = true;
					}
				}else{
					$("#rptLsAdminVacation1CheckAllFlag").val("0")
					for(i = 0; i < rptLsAdminVacation1Form.cb_ls_admin_vacation1.length; i++){
						rptLsAdminVacation1Form.cb_ls_admin_vacation1[i].checked = false;
					}
				}
			});
			
			$("#rptLsAdminNoSendCheckAll").change(function(){
				if($("#rptLsAdminNoSendCheckAllFlag").val() == 0){
					$("#rptLsAdminNoSendCheckAllFlag").val("1")
					for(i = 0; i < rptLsAdminNoSendForm.cb_ls_admin_nosend.length; i++){
						rptLsAdminNoSendForm.cb_ls_admin_nosend[i].checked = true;
					}
				}else{
					$("#rptLsAdminNoSendCheckAllFlag").val("0")
					for(i = 0; i < rptLsAdminNoSendForm.cb_ls_admin_nosend.length; i++){
						rptLsAdminNoSendForm.cb_ls_admin_nosend[i].checked = false;
					}
				}
			});
			
			$("#rptLsAdminVacation2CheckAll").change(function(){
				if($("#rptLsAdminVacation2CheckAllFlag").val() == 0){
					$("#rptLsAdminVacation2CheckAllFlag").val("1")
					for(i = 0; i < rptLsAdminVacation2Form.cb_ls_admin_vacation2.length; i++){
						rptLsAdminVacation2Form.cb_ls_admin_vacation2[i].checked = true;
					}
				}else{
					$("#rptLsAdminVacation2CheckAllFlag").val("0")
					for(i = 0; i < rptLsAdminVacation2Form.cb_ls_admin_vacation2.length; i++){
						rptLsAdminVacation2Form.cb_ls_admin_vacation2[i].checked = false;
					}
				}
			});
			
			$("#rptLsApprovalSiteCheckAll").change(function(){
				if($("#rptLsApprovalSiteCheckAllFlag").val() == 0){
					$("#rptLsApprovalSiteCheckAllFlag").val("1")
					for(i = 0; i < rptLsApprovalSiteForm.cb_ls_approval_site.length; i++){
						rptLsApprovalSiteForm.cb_ls_approval_site[i].checked = true;
					}
				}else{
					$("#rptLsApprovalSiteCheckAllFlag").val("0")
					for(i = 0; i < rptLsApprovalSiteForm.cb_ls_approval_site.length; i++){
						rptLsApprovalSiteForm.cb_ls_approval_site[i].checked = false;
					}
				}
			});
			
			$("#rptLsTodayVacationCheckAll").change(function(){
				if($("#rptLsTodayVacationCheckAllFlag").val() == 0){
					$("#rptLsTodayVacationCheckAllFlag").val("1")
					for(i = 0; i < rptLsTodayVacationForm.cb_ls_today_vacation.length; i++){
						rptLsTodayVacationForm.cb_ls_today_vacation[i].checked = true;
					}
				}else{
					$("#rptLsTodayVacationCheckAllFlag").val("0")
					for(i = 0; i < rptLsTodayVacationForm.cb_ls_today_vacation.length; i++){
						rptLsTodayVacationForm.cb_ls_today_vacation[i].checked = false;
					}
				}
			});
			
			$("#rptCancelApprovalAll").change(function(){
				if($("#rptCancelApprovalAllFlag").val() == 0){
					$("#rptCancelApprovalAllFlag").val("1")
					for(i = 0; i < rptCancelApprovalForm.cb_ls_rpt_cancel_approval.length; i++){
						rptCancelApprovalForm.cb_ls_rpt_cancel_approval[i].checked = true;
					}
				}else{
					$("#rptCancelApprovalAllFlag").val("0")
					for(i = 0; i < rptCancelApprovalForm.cb_ls_rpt_cancel_approval.length; i++){
						rptCancelApprovalForm.cb_ls_rpt_cancel_approval[i].checked = false;
					}
				}
			});
			
			
			$(".chkAllGubun").click(function(){
				var gubun = $(this).attr("gubun");
				var chkbox = $("#"+gubun+" input[type='checkbox']");
				
				if( $(this).is(":checked") ){
					for(var i=0; i < chkbox.length ;i++){
						chkbox[i].checked = true;
					}
				}else{
					for(var i=0; i < chkbox.length ;i++){
						chkbox[i].checked = false;
					}
				}
				
			});
			
			//관리자(IT) 메모 목록을 물러온다.
			doSearchMemo();

		});//ready
		
		//메모추가 시작	
		function memoAdd(){
			memoFormClear();
			$("#addMemoButton").hide();
			$("#memoAddForm").show();
		}
		
		//메모추가취소
		function memoCancel(){
			memoFormClear();
			$("#addMemoButton").show();
			$("#memoAddForm").hide();
		}
		
		//메모 추가저장
		function memoSave(){
			
			var addMemoContent = $("#memo_content_add").val();		//메모내용
			var addFkey = $("#user_no_memo").val();
			
			if( addMemoContent == "" ){
				alert("메모 내용을 입력해주세요.");
				$("#memo_content_add").focus();
				return;
			}
			
			var param = {};
			
			param.action = "I";							//Insert
			param.category_type = "2";				//2 : 사용자 전산권한 관리
			param.memo_content = addMemoContent;
			param.writer_user_no = ${mbrVo_Session.user_no};		//작성자 사번
			param.fkey = addFkey;					//외래키:팀아이디
			
			var url = "./memoItAction";			//개별등록

		    $.ajax({
				type: "POST",
				url: url,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "html",			
				timeout: 20000,
				success: function(data){
					if( data ){		//1인 경우 성공 
						alert("메모를 추가하였습니다.");
						memoFormClear();
						$("#addMemoButton").show();
						$("#memoAddForm").hide();
						doSearchMemo();
					}
				}                
		    });		
		}
		
		function doSearchMemo(){
			
			var selFkey = $("#user_no_memo").val();	
			
			var param = {};
			
			param.fkey = selFkey;
			param.category_type = "2";
			
			var sUrl = "./getItMemoInfo";			//개별목록가져오기
			
			$.ajax({
	    		type: "POST",
	    		url: sUrl,
	    		data: param,
	    		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	    		dataType: "html",
	    		timeout: 20000,    		         
	    		success: function(data){    			
	    			$("#memoList").html(data);    			
	    		},            		
	    		error: function (request, status, error) {
	    			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
	    		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	    		}            		
	    	});		
			
		}
		
		//메모 삭제
		function doMemoDelete( p_pkey , p_memo_content ){
			
			if( !confirm( p_memo_content+" \n메모를 삭제하시겠습니까?") ){
				return;	
			}		
			
			var param = {};		
			
			param.action = "D";				//Delete
			param.pkey = p_pkey;		
					
			var url = "./memoItAction";

		    $.ajax({
				type: "POST",
				url: url,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "html",			
				timeout: 20000,
				success: function(data){
					if( data ){		//1인 경우 성공 
						alert("메모를 삭제하였습니다.");					
						doSearchMemo();
					}
				}                
		    });
		}
		
		//메모 수정
		function doMemoModify( p_pkey ){		
			$("#memo_view_"+p_pkey).hide();
			$("#memo_edit_"+p_pkey).show();
			$("#memo_content_edit_"+p_pkey).focus();
		}
		
		//메모 수정 취소
		function doMemoEditCancel( p_pkey ){
			$("#memo_view_"+p_pkey).show();
			$("#memo_edit_"+p_pkey).hide();		
		}
		
		//메모 수정 저장
		function doMemoEditSave( p_pkey ){
			var param = {};		
			
			param.action = "U";				//Update
			param.pkey = p_pkey;
			param.memo_content = $("#memo_content_edit_"+p_pkey).val();
			param.writer_user_no = ${mbrVo_Session.user_no};
			
			var url = "./memoItAction";			//개별등록

		    $.ajax({
				type: "POST",
				url: url,
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "html",			
				timeout: 20000,
				success: function(data){
					if( data ){		//1인 경우 성공 
						alert("메모를 수정하였습니다.");					
						doSearchMemo();
					}
				}                
		    });
		}
		
		function memoFormClear(){
			$("#memo_content_add").val("");		
		}
		
		function subMenuShow(){			
			$("#subMenu").show();
		}
		
		function subMenuHide(){			
			$("#subMenu").hide();
		}
		
		//메모추가 끝
	</script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
</head>

<body>
	<!-- header -->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 전산 권한 수정 </span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->
	
	<!-- center -->
	<div id ="container">
		<div class="contetnsPop">
			<div class="center_cnt">
				<div class="centercnt_bot3" style="width:1000px;">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#" onclick="javascript:subMenuShow();">전산 권한 수정</a></li>								
								<li><a href="#" onclick="javascript:subMenuHide();">전산 권한 메모</a></li>
							</ul>
						</div>						
						
							<div id="subMenu" class= "tableStyle2" style="padding-top:7px;">
								<table>
									<tr>
										<td style="cursor: pointer;" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''" onclick="location.href='#00'">보고서 편집 및 열람</td>
										<td style="cursor: pointer;" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''" onclick="location.href='#01'">보고서 종결</td>
										<td style="cursor: pointer;" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''" onclick="location.href='#02'">보고서 작성인 변경</td>
										<td style="cursor: pointer;" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''" onclick="location.href='#03'">보험사 담당자 변경</td>
										<td style="cursor: pointer;" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''" onclick="location.href='#04'">총무 경리 열람</td>
										<td style="cursor: pointer;" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''" onclick="location.href='#05'">수정 후 종결</td>
										<td style="cursor: pointer;" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''" onclick="location.href='#06'">담당 관리 부서</td>										
									</tr>
									<tr>
										<!-- <td style="cursor: pointer;" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''" onclick="location.href='#06'">담당 관리 부서</td> -->
										<td style="cursor: pointer;" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''" onclick="location.href='#07'">보고서 필수업무<br/>프로세스 편집</td>
										<td style="cursor: pointer;" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''" onclick="location.href='#08'">보고서 빠른결재<br/>프로세스 편집</td>
										<td style="cursor: pointer;" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''" onclick="location.href='#09'">휴가 사용대장 조회권한<br/>설정 편집</td>
										<td style="cursor: pointer;" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''" onclick="location.href='#10'">손해사정서 미교부현황<br/>팝업 조회권한</td>
										<td style="cursor: pointer;" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''" onclick="location.href='#11'">현장보고서 겸직자<br/>결재팀 설정</td>
										<td style="cursor: pointer;" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''" onclick="location.href='#12'">오늘 휴가자<br/>조회팀 설정</td>
										<td style="cursor: pointer;" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''" onclick="location.href='#13'">보고서 위임취소<br/>결재권한</td>
									</tr>									
								</table>
							</div>

						<div class="guestcnt4" style="display:block;height:680px;">
							<div class= "tableStyle4">

								<form name="rptEditForm" method="post" action='popMbrAuth2DtlIns'>
									<table>
										<colgroup>
											<col width="30%">
											<col width="35%">
											<col width="35%">
										</colgroup>
										<thead>
											<tr>
												<td colspan="3"><a name="00"><b>보고서 편집 및 열람</b></a>
													<input type="submit" value=" 저 장 " />
													<br />전체
													<input type="checkbox" id="rptEditCheckAll" />
													<input type="hidden" id="rptEditCheckAllFlag" value="0" />
												</td>
											</tr>
											<tr bgcolor="#E7ECF1">
												<td>
													본사 사업부
													<input type="checkbox" class="chkAllGubun" id="rpt_edit_head_chk" gubun="rpt_edit_head" />
												</td>
												<td>
													1종 사업부
													<input type="checkbox" class="chkAllGubun" id="rpt_edit_kind1_chk" gubun="rpt_edit_kind1" />
												</td>
												<td>
													4종 사업부
													<input type="checkbox" class="chkAllGubun" id="rpt_edit_kind4_chk" gubun="rpt_edit_kind4" />
												</td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td id="rpt_edit_head">
													<c:forEach var="vo" items="${authTeamlist0}" varStatus="status">
														<input type="checkbox" name="cb_rpt_edit" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name} <br />
													</c:forEach>
												</td>
												<td id="rpt_edit_kind1">
													<c:forEach var="vo" items="${authTeamlist1}" varStatus="status">
														<input type="checkbox" name="cb_rpt_edit" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 3 == 0}"><br /></c:if>
													</c:forEach>
												</td>
												<td id="rpt_edit_kind4">
													<c:forEach var="vo" items="${authTeamlist4}" varStatus="status">
														<input type="checkbox" name="cb_rpt_edit" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 2 == 0}"><br /></c:if>
													</c:forEach>
												</td>
											</tr>
										</tbody>
									</table>
									<input type="hidden" name="user_no" value="${user_no}" />
								</form>
<br />
								<form name="rptLsAdmin7Form" method="post" action='popMbrAuth2DtlLsAdmin7Ins'>
									<table>
										<colgroup>
											<col width="30%">
											<col width="35%">
											<col width="35%">
										</colgroup>
										<thead>
											<tr>
												<td colspan="3"><a name="01"><b>보고서 종결</b></a>
													<input type="submit" value=" 저 장 " />
													<br />전체
													<input type="checkbox" id="rptLsAdmin7CheckAll" />
													<input type="hidden" id="rptLsAdmin7CheckAllFlag" value="0" />
												</td>
											</tr>
											<tr bgcolor="#E7ECF1">
												<td>
													본사 사업부
													<input type="checkbox" class="chkAllGubun" id="admin7_head_chk" gubun="admin7_head" />
												</td>
												<td>
													1종 사업부
													<input type="checkbox" class="chkAllGubun" id="admin7_kind1_chk" gubun="admin7_kind1"/>
												</td>
												<td>
													4종 사업부
													<input type="checkbox" class="chkAllGubun" id="admin7_kind4_chk" gubun="admin7_kind4"/>
												</td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td id="admin7_head">
													<c:forEach var="vo" items="${authTeamlist0LsAdmin7}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin7" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name} <br />
													</c:forEach>
												</td>
												<td id="admin7_kind1">
													<c:forEach var="vo" items="${authTeamlist1LsAdmin7}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin7" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 3 == 0}"><br /></c:if>
													</c:forEach>
												</td>
												<td id="admin7_kind4">
													<c:forEach var="vo" items="${authTeamlist4LsAdmin7}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin7" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 2 == 0}"><br /></c:if>
													</c:forEach>
												</td>
											</tr>
										</tbody>
									</table>
									<input type="hidden" name="user_no" value="${user_no}" />
								</form>
<br />
								<form name="rptLsAdmin9Form" method="post" action='popMbrAuth2DtlLsAdmin9Ins'>
									<table>
										<colgroup>
											<col width="30%">
											<col width="35%">
											<col width="35%">
										</colgroup>
										<thead>
											<tr>
												<td colspan="3"><a name="02"><b>보고서 작성인 변경</b></a>
													<input type="submit" value=" 저 장 " />
													<br />전체
													<input type="checkbox" id="rptLsAdmin9CheckAll" />
													<input type="hidden" id="rptLsAdmin9CheckAllFlag" value="0" />
												</td>
											</tr>
											<tr bgcolor="#E7ECF1">
												<td>
													본사 사업부
													<input type="checkbox" class="chkAllGubun" id="admin9_head_chk" gubun="admin9_head" />
												</td>
												<td>
													1종 사업부
													<input type="checkbox" class="chkAllGubun" id="admin9_kind1_chk" gubun="admin9_kind1"/>
												</td>
												<td>
													4종 사업부
													<input type="checkbox" class="chkAllGubun" id="admin9_kind4_chk" gubun="admin9_kind4"/>
												</td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td id="admin9_head">
													<c:forEach var="vo" items="${authTeamlist0LsAdmin9}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin9" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name} <br />
													</c:forEach>
												</td>
												<td id="admin9_kind1">
													<c:forEach var="vo" items="${authTeamlist1LsAdmin9}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin9" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 3 == 0}"><br /></c:if>
													</c:forEach>
												</td>
												<td id="admin9_kind4">
													<c:forEach var="vo" items="${authTeamlist4LsAdmin9}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin9" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 2 == 0}"><br /></c:if>
													</c:forEach>
												</td>
											</tr>
										</tbody>
									</table>
									<input type="hidden" name="user_no" value="${user_no}" />
								</form>
<br />
								<form name="rptLsAdmin10Form" method="post" action='popMbrAuth2DtlLsAdmin10Ins'>
									<table>
										<colgroup>
											<col width="30%">
											<col width="35%">
											<col width="35%">
										</colgroup>
										<thead>
											<tr>
												<td colspan="3"><a name="03"><b>보험사 담당자 변경</b></a>
													<input type="submit" value=" 저 장 " />
													<br />전체
													<input type="checkbox" id="rptLsAdmin10CheckAll" />
													<input type="hidden" id="rptLsAdmin10CheckAllFlag" value="0" />
												</td>
											</tr>
											<tr bgcolor="#E7ECF1">
												<td>
													본사 사업부
													<input type="checkbox" class="chkAllGubun" id="admin10_head_chk" gubun="admin10_head" />
												</td>
												<td>
													1종 사업부
													<input type="checkbox" class="chkAllGubun" id="admin10_kind1_chk" gubun="admin10_kind1"/>
												</td>
												<td>
													4종 사업부
													<input type="checkbox" class="chkAllGubun" id="admin10_kind4_chk" gubun="admin10_kind4"/>
												</td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td id="admin10_head">
													<c:forEach var="vo" items="${authTeamlist0LsAdmin10}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin10" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name} <br />
													</c:forEach>
												</td>
												<td id="admin10_kind1">
													<c:forEach var="vo" items="${authTeamlist1LsAdmin10}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin10" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 3 == 0}"><br /></c:if>
													</c:forEach>
												</td>
												<td id="admin10_kind4">
													<c:forEach var="vo" items="${authTeamlist4LsAdmin10}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin10" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 2 == 0}"><br /></c:if>
													</c:forEach>
												</td>
											</tr>
										</tbody>
									</table>
									<input type="hidden" name="user_no" value="${user_no}" />
								</form>
<br />
								<form name="rptLsAdmin11Form" method="post" action='popMbrAuth2DtlLsAdmin11Ins'>
									<table>
										<colgroup>
											<col width="30%">
											<col width="35%">
											<col width="35%">
										</colgroup>
										<thead>
											<tr>
												<td colspan="3"><a name="04"><b>총무 경리 열람</b></a>
													<input type="submit" value=" 저 장 " />
													<br />전체
													<input type="checkbox" id="rptLsAdmin11CheckAll" />
													<input type="hidden" id="rptLsAdmin11CheckAllFlag" value="0" />
												</td>
											</tr>
											<tr bgcolor="#E7ECF1">
												<td>
													본사 사업부
													<input type="checkbox" class="chkAllGubun" id="admin11_head_chk" gubun="admin11_head" />
												</td>
												<td>
													1종 사업부
													<input type="checkbox" class="chkAllGubun" id="admin11_kind1_chk" gubun="admin11_kind1"/>
												</td>
												<td>
													4종 사업부
													<input type="checkbox" class="chkAllGubun" id="admin11_kind4_chk" gubun="admin11_kind4"/>
												</td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td id="admin11_head">
													<c:forEach var="vo" items="${authTeamlist0LsAdmin11}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin11" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name} <br />
													</c:forEach>
												</td>
												<td id="admin11_kind1">
													<c:forEach var="vo" items="${authTeamlist1LsAdmin11}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin11" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 3 == 0}"><br /></c:if>
													</c:forEach>
												</td>
												<td id="admin11_kind4">
													<c:forEach var="vo" items="${authTeamlist4LsAdmin11}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin11" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 2 == 0}"><br /></c:if>
													</c:forEach>
												</td>
											</tr>
										</tbody>
									</table>
									<input type="hidden" name="user_no" value="${user_no}" />
								</form>
								
								
								<!-- 종결 후 수정 -->
								<form name="rptLsAdmin22Form" method="post" action='popMbrAuth2DtlLsAdmin22Ins'>
									<table>
										<colgroup>
											<col width="30%">
											<col width="35%">
											<col width="35%">
										</colgroup>
										<thead>
											<tr>
												<td colspan="3"><a name="05"><b>수정 후 종결</b></a>
													<input type="submit" value=" 저 장 " />
													<br />전체
													<input type="checkbox" id="rptLsAdmin22CheckAll" />
													<input type="hidden" id="rptLsAdmin22CheckAllFlag" value="0" />
												</td>
											</tr>
											<tr bgcolor="#E7ECF1">
												<td>
													본사 사업부
													<input type="checkbox" class="chkAllGubun" id="admin22_head_chk" gubun="admin22_head" />
												</td>
												<td>
													1종 사업부
													<input type="checkbox" class="chkAllGubun" id="admin22_kind1_chk" gubun="admin22_kind1"/>
												</td>
												<td>
													4종 사업부
													<input type="checkbox" class="chkAllGubun" id="admin22_kind4_chk" gubun="admin22_kind4"/>
												</td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td id="admin22_head">
													<c:forEach var="vo" items="${authTeamlist0LsAdmin22}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin22" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name} <br />
													</c:forEach>
												</td>
												<td id="admin22_kind1">
													<c:forEach var="vo" items="${authTeamlist1LsAdmin22}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin22" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 3 == 0}"><br /></c:if>
													</c:forEach>
												</td>
												<td id="admin22_kind4">
													<c:forEach var="vo" items="${authTeamlist4LsAdmin22}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin22" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 2 == 0}"><br /></c:if>
													</c:forEach>
												</td>
											</tr>
										</tbody>
									</table>
									<input type="hidden" name="user_no" value="${user_no}" />
								</form>

								<!-- 담당 관리 부서(센터장등..) -->
								<form name="rptLsAdmin23Form" method="post" action='popMbrAuth2DtlLsAdmin23Ins'>
									<table>
										<colgroup>
											<col width="30%">
											<col width="35%">
											<col width="35%">
										</colgroup>
										<thead>
											<tr>
												<td colspan="3"><a name="06"><b>담당 관리 부서</b></a>
													<input type="submit" value=" 저 장 " />
													<br />전체
													<input type="checkbox" id="rptLsAdmin23CheckAll" />
													<input type="hidden" id="rptLsAdmin23CheckAllFlag" value="0" />
												</td>
											</tr>
											<tr bgcolor="#E7ECF1">
												<td>
													본사 사업부
													<input type="checkbox" class="chkAllGubun" id="admin23_head_chk" gubun="admin23_head" />
												</td>
												<td>
													1종 사업부
													<input type="checkbox" class="chkAllGubun" id="admin23_kind1_chk" gubun="admin23_kind1"/>
												</td>
												<td>
													4종 사업부
													<input type="checkbox" class="chkAllGubun" id="admin23_kind4_chk" gubun="admin23_kind4"/>
												</td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td id="admin23_head">
													<c:forEach var="vo" items="${authTeamlist0LsAdmin23}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin23" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name} <br />
													</c:forEach>
												</td>
												<td id="admin23_kind1">
													<c:forEach var="vo" items="${authTeamlist1LsAdmin23}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin23" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 3 == 0}"><br /></c:if>
													</c:forEach>
												</td>
												<td id="admin23_kind4">
													<c:forEach var="vo" items="${authTeamlist4LsAdmin23}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin23" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 2 == 0}"><br /></c:if>
													</c:forEach>
												</td>
											</tr>
										</tbody>
									</table>
									<input type="hidden" name="user_no" value="${user_no}" />
								</form>								
								
<br />							
								<form name="rptLsAdmin24Form" method="post" action='popMbrAuth2DtlLsAdmin24Ins'>
									<table>
										<colgroup>
											<col width="30%">
											<col width="35%">
											<col width="35%">
										</colgroup>
										<thead>
											<tr>
												<td colspan="3"><a name="07"><b>보고서 필수업무프로세스 편집</b></a>
													<input type="submit" value=" 저 장 " />
													<br />전체
													<input type="checkbox" id="rptLsAdmin24CheckAll" />
													<input type="hidden" id="rptLsAdmin24CheckAllFlag" value="0" />
												</td>
											</tr>
											<tr bgcolor="#E7ECF1">
												<td>
													본사 사업부
													<input type="checkbox" class="chkAllGubun" id="admin24_head_chk" gubun="admin24_head" />
												</td>
												<td>
													1종 사업부
													<input type="checkbox" class="chkAllGubun" id="admin24_kind1_chk" gubun="admin24_kind1"/>
												</td>
												<td>
													4종 사업부
													<input type="checkbox" class="chkAllGubun" id="admin24_kind4_chk" gubun="admin24_kind4"/>
												</td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td id="admin24_head">
													<c:forEach var="vo" items="${authTeamlist0LsAdmin24}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin24" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name} <br />
													</c:forEach>
												</td>
												<td id="admin24_kind1">
													<c:forEach var="vo" items="${authTeamlist1LsAdmin24}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin24" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 3 == 0}"><br /></c:if>
													</c:forEach>
												</td>
												<td id="admin24_kind4">
													<c:forEach var="vo" items="${authTeamlist4LsAdmin24}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin24" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 2 == 0}"><br /></c:if>
													</c:forEach>
												</td>
											</tr>
										</tbody>
									</table>
									<input type="hidden" name="user_no" value="${user_no}" />
								</form>	
								
<br />							
								<form name="rptLsAdminQuickForm" method="post" action='popMbrAuth2DtlLsAdminQuickIns'>
									<table>
										<colgroup>
											<col width="30%">
											<col width="35%">
											<col width="35%">
										</colgroup>
										<thead>
											<tr>
												<td colspan="3"><a name="08"><b>보고서 빠른결재 프로세스 편집</b></a>
													<input type="submit" value=" 저 장 " />
													<br />전체
													<input type="checkbox" id="rptLsAdminQuickCheckAll" />
													<input type="hidden" id="rptLsAdminQuickCheckAllFlag" value="0" />
												</td>
											</tr>
											<tr bgcolor="#E7ECF1">
												<td>
													본사 사업부
													<input type="checkbox" class="chkAllGubun" id="adminQuick_head_chk" gubun="adminQuick_head" />
												</td>
												<td>
													1종 사업부
													<input type="checkbox" class="chkAllGubun" id="adminQuick_kind1_chk" gubun="adminQuick_kind1"/>
												</td>
												<td>
													4종 사업부
													<input type="checkbox" class="chkAllGubun" id="adminQuick_kind4_chk" gubun="adminQuick_kind4"/>
												</td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td id="adminQuick_head">
													<c:forEach var="vo" items="${authTeamlist0LsAdminQuick}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin_quick" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name} <br />
													</c:forEach>
												</td>
												<td id="adminQuick_kind1">
													<c:forEach var="vo" items="${authTeamlist1LsAdminQuick}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin_quick" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 3 == 0}"><br /></c:if>
													</c:forEach>
												</td>
												<td id="adminQuick_kind4">
													<c:forEach var="vo" items="${authTeamlist4LsAdminQuick}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin_quick" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 2 == 0}"><br /></c:if>
													</c:forEach>
												</td>
											</tr>
										</tbody>
									</table>
									<input type="hidden" name="user_no" value="${user_no}" />
								</form>	
								
								<!-- 휴가 1차결재 권한 -->
								<form name="rptLsAdminVacation1Form" method="post" action='popMbrAuth2DtlLsAdminVacation1Ins'>
									<table>
										<colgroup>
											<col width="30%">
											<col width="35%">
											<col width="35%">
										</colgroup>
										<thead>
											<tr>
												<td colspan="3"><a name="09"><b>휴가 사용대장 조회권한 설정 편집<!-- 휴가 1차 결재 권한설정 편집 --></b></a>
													<input type="submit" value=" 저 장 " />
													<br />전체
													<input type="checkbox" id="rptLsAdminVacation1CheckAll" />
													<input type="hidden" id="rptLsAdminVacation1CheckAllFlag" value="0" />
												</td>
											</tr>
											<tr bgcolor="#E7ECF1">
												<td>
													본사 사업부
													<input type="checkbox" class="chkAllGubun" id="adminVacation1_head_chk" gubun="adminVacation1_head" />
												</td>
												<td>
													1종 사업부
													<input type="checkbox" class="chkAllGubun" id="adminVacation1_kind1_chk" gubun="adminVacation1_kind1"/>
												</td>
												<td>
													4종 사업부
													<input type="checkbox" class="chkAllGubun" id="adminVacation1_kind4_chk" gubun="adminVacation1_kind4"/>
												</td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td id="adminVacation1_head">
													<c:forEach var="vo" items="${authTeamlist0LsAdminVacation1}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin_vacation1" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name} <br />
													</c:forEach>
												</td>
												<td id="adminVacation1_kind1">
													<c:forEach var="vo" items="${authTeamlist1LsAdminVacation1}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin_vacation1" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 3 == 0}"><br /></c:if>
													</c:forEach>
												</td>
												<td id="adminVacation1_kind4">
													<c:forEach var="vo" items="${authTeamlist4LsAdminVacation1}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin_vacation1" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 2 == 0}"><br /></c:if>
													</c:forEach>
												</td>
											</tr>
										</tbody>
									</table>
									<input type="hidden" name="user_no" value="${user_no}" />
								</form>
								
								<!-- 손해사정서 미교부현황 팝업 조회권한  -->
								<form name="rptLsAdminNoSendForm" method="post" action='popMbrAuth2DtlLsAdminNoSendIns'>
									<table>
										<colgroup>
											<col width="30%">
											<col width="35%">
											<col width="35%">
										</colgroup>
										<thead>
											<tr>
												<td colspan="3"><a name="10"><b>손해사정서 미교부현황 팝업 조회권한</b></a>
													<input type="submit" value=" 저 장 " />
													<br />전체
													<input type="checkbox" id="rptLsAdminNoSendCheckAll" />
													<input type="hidden" id="rptLsAdminNoSendCheckAllFlag" value="0" />
												</td>
											</tr>
											<tr bgcolor="#E7ECF1">
												<td>
													본사 사업부
													<input type="checkbox" class="chkAllGubun" id="adminNoSend_head_chk" gubun="adminNoSend_head" />
												</td>
												<td>
													1종 사업부
													<input type="checkbox" class="chkAllGubun" id="adminNoSend_kind1_chk" gubun="adminNoSend_kind1"/>
												</td>
												<td>
													4종 사업부
													<input type="checkbox" class="chkAllGubun" id="adminNoSend_kind4_chk" gubun="adminNoSend_kind4"/>
												</td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td id="adminNoSend_head">
													<c:forEach var="vo" items="${authTeamlist0LsAdminNoSend}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin_nosend" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name} <br />
													</c:forEach>
												</td>
												<td id="adminNoSend_kind1">
													<c:forEach var="vo" items="${authTeamlist1LsAdminNoSend}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin_nosend" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 3 == 0}"><br /></c:if>
													</c:forEach>
												</td>
												<td id="adminNoSend_kind4">
													<c:forEach var="vo" items="${authTeamlist4LsAdminNoSend}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin_nosend" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 2 == 0}"><br /></c:if>
													</c:forEach>
												</td>
											</tr>
										</tbody>
									</table>
									<input type="hidden" name="user_no" value="${user_no}" />
								</form>		
								
								<!-- 현장보고서 겸직자 결재팀 설정권한  시작  by top3009 20211228-->
								<form name="rptLsApprovalSiteForm" method="post" action='popMbrAuth2DtlLsApprovalSiteIns'>
									<table>
										<colgroup>
											<col width="30%">
											<col width="35%">
											<col width="35%">
										</colgroup>
										<thead>
											<tr>
												<td colspan="3"><a name="11"><b>현장보고서 겸직자 결재팀 설정</b></a>
													<input type="submit" value=" 저 장 " />
													<br />전체
													<input type="checkbox" id="rptLsApprovalSiteCheckAll" />
													<input type="hidden" id="rptLsApprovalSiteCheckAllFlag" value="0" />
												</td>
											</tr>
											<tr bgcolor="#E7ECF1">
												<td>
													본사 사업부
													<input type="checkbox" class="chkAllGubun" id="approvalSite_head_chk" gubun="approvalSite_head" />
												</td>
												<td>
													1종 사업부
													<input type="checkbox" class="chkAllGubun" id="approvalSite_kind1_chk" gubun="approvalSite_kind1"/>
												</td>
												<td>
													4종 사업부
													<input type="checkbox" class="chkAllGubun" id="approvalSite_kind4_chk" gubun="approvalSite_kind4"/>
												</td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td id="approvalSite_head">
													<c:forEach var="vo" items="${authTeamlist0LsApprovalSite}" varStatus="status">
														<input type="checkbox" name="cb_ls_approval_site" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name} <br />
													</c:forEach>
												</td>
												<td id="approvalSite_kind1">
													<c:forEach var="vo" items="${authTeamlist1LsApprovalSite}" varStatus="status">
														<input type="checkbox" name="cb_ls_approval_site" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 3 == 0}"><br /></c:if>
													</c:forEach>
												</td>
												<td id="approvalSite_kind4">
													<c:forEach var="vo" items="${authTeamlist4LsApprovalSite}" varStatus="status">
														<input type="checkbox" name="cb_ls_approval_site" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 2 == 0}"><br /></c:if>
													</c:forEach>
												</td>
											</tr>
										</tbody>
									</table>
									<input type="hidden" name="user_no" value="${user_no}" />
								</form>
								<!-- 현장보고서 겸직자 결재 조회권한  끝 -->
								
								<!-- 오늘 휴가자 조회권한 시작  by top3009 20240119-->
								<form name="rptLsTodayVacationForm" method="post" action='popMbrAuth2DtlLsTodayVacationIns'>
									<table>
										<colgroup>
											<col width="30%">
											<col width="35%">
											<col width="35%">
										</colgroup>
										<thead>
											<tr>
												<td colspan="3"><a name="12"><b>오늘 휴가자 조회팀 권한설정</b></a>
													<input type="submit" value=" 저 장 " />
													<br />전체
													<input type="checkbox" id="rptLsTodayVacationCheckAll" />
													<input type="hidden" id="rptLsTodayVacationCheckAllFlag" value="0" />
												</td>
											</tr>
											<tr bgcolor="#E7ECF1">
												<td>
													본사 사업부
													<input type="checkbox" class="chkAllGubun" id="todayVacation_head_chk" gubun="todayVacation_head" />
												</td>
												<td>
													1종 사업부
													<input type="checkbox" class="chkAllGubun" id="todayVacation_kind1_chk" gubun="todayVacation_kind1"/>
												</td>
												<td>
													4종 사업부
													<input type="checkbox" class="chkAllGubun" id="todayVacation_kind4_chk" gubun="todayVacation_kind4"/>
												</td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td id="todayVacation_head">
													<c:forEach var="vo" items="${authTeamList0LsTodayVacation}" varStatus="status">
														<input type="checkbox" name="cb_ls_today_vacation" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name} <br />
													</c:forEach>
												</td>
												<td id="todayVacation_kind1">
													<c:forEach var="vo" items="${authTeamList1LsTodayVacation}" varStatus="status">
														<input type="checkbox" name="cb_ls_today_vacation" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 3 == 0}"><br /></c:if>
													</c:forEach>
												</td>
												<td id="todayVacation_kind4">
													<c:forEach var="vo" items="${authTeamList4LsTodayVacation}" varStatus="status">
														<input type="checkbox" name="cb_ls_today_vacation" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 2 == 0}"><br /></c:if>
													</c:forEach>
												</td>
											</tr>
										</tbody>
									</table>
									<input type="hidden" name="user_no" value="${user_no}" />
								</form>
								<!-- 오늘 휴가자 조회권한 끝  by top3009 20240119-->
								
								<!-- 보고서 위임취소 결재권한 시작  by top3009 20240725-->
								<form name="rptCancelApprovalForm" method="post" action='popMbrAuth2DtlLsRptCancelApprovalIns'>
									<table>
										<colgroup>
											<col width="30%">
											<col width="35%">
											<col width="35%">
										</colgroup>
										<thead>
											<tr>
												<td colspan="3"><a name="13"><b>보고서 위임취소 결재권한</b></a>
													<input type="submit" value=" 저 장 " />
													<br />전체
													<input type="checkbox" id="rptCancelApprovalAll" />
													<input type="hidden" id="rptCancelApprovalAllFlag" value="0" />
												</td>
											</tr>
											<tr bgcolor="#E7ECF1">
												<td>
													본사 사업부
													<input type="checkbox" class="chkAllGubun" id="rptCancelApproval_head_chk" gubun="rptCancelApproval_head" />
												</td>
												<td>
													1종 사업부
													<input type="checkbox" class="chkAllGubun" id="rptCancelApproval_kind1_chk" gubun="rptCancelApproval_kind1"/>
												</td>
												<td>
													4종 사업부
													<input type="checkbox" class="chkAllGubun" id="rptCancelApproval_kind4_chk" gubun="rptCancelApproval_kind4"/>
												</td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td id="rptCancelApproval_head">
													<c:forEach var="vo" items="${authTeamList0RptCancelApproval}" varStatus="status">
														<input type="checkbox" name="cb_ls_rpt_cancel_approval" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name} <br />
													</c:forEach>
												</td>
												<td id="rptCancelApproval_kind1">
													<c:forEach var="vo" items="${authTeamList1RptCancelApproval}" varStatus="status">
														<input type="checkbox" name="cb_ls_rpt_cancel_approval" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 3 == 0}"><br /></c:if>
													</c:forEach>
												</td>
												<td id="rptCancelApproval_kind4">
													<c:forEach var="vo" items="${authTeamList4RptCancelApproval}" varStatus="status">
														<input type="checkbox" name="cb_ls_rpt_cancel_approval" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 2 == 0}"><br /></c:if>
													</c:forEach>
												</td>
											</tr>
										</tbody>
									</table>
									<input type="hidden" name="user_no" value="${user_no}" />
								</form>
								<!-- 보고서 위임취소 결재권한 끝  by top3009 20240725-->
								
								
								
								<!-- 휴가 2차결재 권한 안쓴다.. by top3009 20191108-->
								<%-- <form name="rptLsAdminVacation2Form" method="post" action='popMbrAuth2DtlLsAdminVacation2Ins'>
									<table>
										<colgroup>
											<col width="30%">
											<col width="35%">
											<col width="35%">
										</colgroup>
										<thead>
											<tr>
												<td colspan="3"><a name="22"><b>휴가 2차 결재 권한설정 편집</b></a>
													<input type="submit" value=" 저 장 " />
													<br />전체
													<input type="checkbox" id="rptLsAdminVacation2CheckAll" />
													<input type="hidden" id="rptLsAdminVacation2CheckAllFlag" value="0" />
												</td>
											</tr>
											<tr bgcolor="#E7ECF1">
												<td>
													본사 사업부
													<input type="checkbox" class="chkAllGubun" id="adminVacation2_head_chk" gubun="adminVacation2_head" />
												</td>
												<td>
													1종 사업부
													<input type="checkbox" class="chkAllGubun" id="adminVacation2_kind1_chk" gubun="adminVacation2_kind1"/>
												</td>
												<td>
													4종 사업부
													<input type="checkbox" class="chkAllGubun" id="adminVacation2_kind4_chk" gubun="adminVacation2_kind4"/>
												</td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td id="adminVacation2_head">
													<c:forEach var="vo" items="${authTeamlist0LsAdminVacation2}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin_vacation2" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name} <br />
													</c:forEach>
												</td>
												<td id="adminVacation2_kind1">
													<c:forEach var="vo" items="${authTeamlist1LsAdminVacation2}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin_vacation2" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 3 == 0}"><br /></c:if>
													</c:forEach>
												</td>
												<td id="adminVacation2_kind4">
													<c:forEach var="vo" items="${authTeamlist4LsAdminVacation2}" varStatus="status">
														<input type="checkbox" name="cb_ls_admin_vacation2" value="${vo.team_id}"
															<c:if test="${vo.cnt > 0}">checked</c:if> /> ${vo.team_name}
															<c:if test="${status.index % 2 == 0}"><br /></c:if>
													</c:forEach>
												</td>
											</tr>
										</tbody>
									</table>
									<input type="hidden" name="user_no" value="${user_no}" />
								</form>	 --%>
								

							</div><!-- //tableStyle -->

						</div><!-- //guestcnt5 -->
						
						<!-- 팀관리 - 메모 시작 -->
						<div class="guestcnt4" style="display:none;height:770px;">
						
						<input type="hidden" id="user_no_memo" name="user_no_memo" value="${user_no}">
						
						<div id="addMemoButton" style="text-align:right;padding:5px 0 5px 0;">
							<a href="#noloc" class="btn-equipment-save" id="btn-search" onclick='javascript:memoAdd();'>메모추가</a>
						</div>
						
						<div class="tableStyle99" id="memoAddForm" style="display:none;padding:5px 0 5px 0;">														
							<table>
								<tr>									
									<td width="85%" style="padding-left:5px;"><input type="text" id="memo_content_add" name="memo_content_add" style="width:800px;" placeholder="내용을 입력해주세요."/></td>									
									<td width="15%" style="text-align:center;">
										<a href="#noloc" class="btn-equipment-save-s" id="btn-search" onclick='javascript:memoSave();'>저장</a>
										<a href="#noloc" class="btn-equipment-cancel-s" id="btn-search" onclick='javascript:memoCancel();'>취소</a>
									</td>			
								</tr>		
							</table>	
						</div>
							<table class="tableStyle2">
								<tr>
									<th width="5%">순번</th>
									<th width="70%">내용</th>
									<th width="10%">작성자</th>
									<th width="10%">작성일</th>
									<th width="15%">기능</th>
								</tr>								
							</table>
							<div id="memoList"></div>							
						</div>
						<!-- 팀관리 - 메모 끝 -->

					</div><!-- //guest -->
				</div><!-- //bot1-3 -->
			</div>
		</div>
	</div>
	<!--//center -->

	<!-- footer -->
	<%-- <c:import url="../top_main/top_pop_footer.jsp"></c:import> --%>
	<!-- //footer -->

</body>
