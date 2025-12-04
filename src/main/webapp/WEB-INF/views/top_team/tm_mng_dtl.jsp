<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>	
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
			$("#team_manager").select2();
			$("#written_ptnr_id").select2();
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_13}' == 0){
				window.location.assign("./logout");
			}
			
			//서면심사 팀인 경우 저장된 보험사를 selected 한다.			
			if( '${teamVO.team_written}' == '1'){				
				$("#selWrittenPtnrIdZone").show();
				$("#written_ptnr_id").val(${teamVO.written_ptnr_id});
				$("#written_ptnr_id").trigger("change");
			}else{
				$("#selWrittenPtnrIdZone").hide();
			}
			
			//서면심사팀인 경우만 보험선택박스를 보여준다.
			$("input[name='team_written']:radio").change(function () {
		        if($(":radio[name=team_written]:checked").val() == 1){
		        	$("#selWrittenPtnrIdZone").show();
		        }else{
		        	$("#selWrittenPtnrIdZone").hide();
		        }
		        
			});
			
			//관리자(IT) 메모 목록을 물러온다.
			doSearchMemo();
			
		});//ready

	function codeCheck(){
		var team_id = document.formtag.team_id.value;
		var myCode = document.formtag.originTeamCode.value;
		
		if((myCode != team_id)){
		 	$.ajax({
		           type:"post",
		           url:"idcheck.do",
		           data: {team_id : team_id},
		           success : function(data) {
		        	   
		        	   if(data != "null"){
							$("#chkId").html("\'"+data+"\'"+" 이(가) 이미 사용중입니다.");
							document.formtag.blockFlag.value = "block";
						}else{
							$("#chkId").html("");
							document.formtag.blockFlag.value = "";
						}
		           }
		     }); 			
		}
	}//end codeCheck

	function SubmitAdd(){
		
		var subOk = 0;
		var subOkFromAjax= document.formtag.blockFlag.value;
		
		if( document.formtag.team_id.value == ""){
			subOk++;
			alert("CODE 는 필수 입력 사항입니다.");
			return;
		}
		if( document.formtag.team_group_order.value ==""){
			subOk++;
			alert("그룹순서 는 필수 입력 사항입니다.");
			return;
		}
		if( document.formtag.team_order.value ==""){
			subOk++;
			alert("팀 순서는 필수 입력 사항입니다.");
			return;
		}
		if( document.formtag.team_type.value ==""){
			subOk++;
			alert("업종은 필수 입력 사항입니다.");
			return;
		}
		if( document.formtag.team_name.value ==""){
			subOk++;
			alert("팀명은 필수 입력 사항입니다.");
			return;
		}
		
		var sManager = $("#team_manager").val();
		
		if( sManager == "" ){
			alert("팀장은 필수 입력 사항입니다.");
			return;
		}
		
		//서면심사팀인 경우 보험사 선택을 확인한다.
		
		var team_written_flag = $(":radio[name=team_written]:checked").val();
		
		if( team_written_flag != "" && team_written_flag == 1){
        	
        	if( $("#written_ptnr_id").val() == 0 ){
				alert("보험사를 선택해주세요.");					
				$("#written_ptnr_id").focus();
				subOk++;
        	}
        }else{
        	$("#written_ptnr_id").val(0);
        }
		
		if( (subOk == 0) && (subOkFromAjax != "block") ){
			document.formtag.submit();			
		}else if(subOkFromAjax == "block"){
			alert("CODE 를 재입력하세요.");
			return;
		}
		
		//document.formtag.submit();
		
	}
	
	//function SubmitDo(obj){		
	function SubmitModify(){
		
		var subOk = 0;
		var subOkFromAjax= document.formtag.blockFlag.value;
		
		if( document.formtag.team_id.value == ""){
			subOk++;
			alert("CODE 는 필수 입력 사항입니다.");
		}
		if( document.formtag.team_group_order.value ==""){
			subOk++;
			alert("그룹순서 는 필수 입력 사항입니다.");
		}
		if( document.formtag.team_order.value ==""){
			subOk++;
			alert("팀 순서는 필수 입력 사항입니다.");
		}
		if( document.formtag.team_type.value ==""){
			subOk++;
			alert("업종은 필수 입력 사항입니다.");
		}
		if( document.formtag.team_name.value ==""){
			subOk++;
			alert("팀명은 필수 입력 사항입니다.");
		}
		
		//서면심사팀인 경우 보험사 선택을 확인한다.
		if($(":radio[name=team_written]:checked").val() == 1){
        	
        	if( $("#written_ptnr_id").val() == 0 ){
				alert("보험사를 선택해주세요.");					
				$("#written_ptnr_id").focus();
				subOk++;
        	}
        }else{
        	$("#written_ptnr_id").val(0);
        }
		
		if( (subOk == 0) && (subOkFromAjax != "block") ){
			document.formtag.submit();		
		}else if(subOkFromAjax == "block"){
			alert("CODE 를 재입력하세요.");
		}
		
	}
	
	function SubmitDel(){
		document.all.action.value = "delete";
		var result = confirm("해당 팀을 정말 삭제하시겠습니까?");
		
		if(result != 0){
			document.formtag.submit();				
		}
	}
	
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
		var addFkey = $("#team_id_memo").val();
		
		if( addMemoContent == "" ){
			alert("메모 내용을 입력해주세요.");
			$("#memo_content_add").focus();
			return;
		}
		
		var param = {};
		
		param.action = "I";							//Insert
		param.category_type = "1";				//1 : 팀관리
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
		
		var selFkey = $("#team_id_memo").val();	
		
		var param = {};
		
		param.fkey = selFkey;
		param.category_type = "1";
		
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
	//메모추가 끝
</script>
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
								<li class="on"><a href="#">팀관리 - 팀분류 추가</a></li>
								<li><a href="#">팀관리 - 메모</a></li>
							</ul>
						</div>

						<div class="guestcnt4" style="display:block;"><!-- guestcnt -->							
							<form name="formtag" method="post" action='teamamdOk.do'><!-- onsubmit="return check_submit();" -->
								<input type=hidden name="action" value='${action}'>
								<input type=hidden name="originTeamCode" value='${teamVO.team_id}'>
								<input type=hidden name="blockFlag" >
								<input type="hidden" id="selTab" name="selTab" value="${selTab}">
								<c:if test="${action eq 'add' }">
									<c:choose>
										<c:when test="${parent eq '0'}">
											<c:set var="team_level" value="1"></c:set>
										</c:when>
										<c:when test="${parent eq '1'}">
											<c:set var="team_level" value="2"></c:set>
										</c:when>
										<c:otherwise>
											<c:set var="team_level" value="0"></c:set>
										</c:otherwise>
									</c:choose>
									<input type=hidden name=team_level value='${team_level}'>
								</c:if>
								<c:if test="${action eq 'modify' }">
									<input type=hidden name=team_level value='${teamVO.team_level}'>
								</c:if>

								<%-- 등록될 팀 레벨(추가) : <c:out value="${team_level}"></c:out><br />
								등록될 팀 레벨(수정) : <c:out value="${teamVO.team_level}"></c:out> --%>

								<div class="tableStyle21"><!-- tableStyle21 -->

									<table>
										<tr >
											<th style="text-align:center;" width = "150px;">
												<c:choose>
													<c:when test="${action eq 'add' }">
														<c:set value="${order}" var ="order"></c:set>
														<b>[팀분류 추가하기]</b>
													</c:when>
													<c:when test="${action eq 'modify' }">
														<c:set value="${teamVO.team_group_order}" var ="order"></c:set>
														<b>[팀분류 수정하기]</b>
													</c:when>
												</c:choose>
											</th><!-- 간격 th 삽입-->
											<th width = "450px;"></th>
										</tr>
										<tr>
											<td bgcolor="#EFEFEF"><p align="center"><b>팀번호(CODE)</b></td>
											<td>
												<input type=text name="team_id" value="${teamVO.team_id}" size="30" onblur="codeCheck();">
												<br /><font color="red"><span id = "chkId"></span></font>
											</td>
										</tr>
										<tr>
											<td bgcolor="#EFEFEF"><p align="center">팀명</td>
											<td><input type=text name="team_name" value="${teamVO.team_name}" size="30"></td>
										</tr>
										<tr>
											<td bgcolor="#EFEFEF"><p align="center">그룹순서</td>
											<td><input type=text name="team_group_order" value="${order}" size="30" /></td>
										</tr>
										<tr>
											<td bgcolor="#EFEFEF"><p align="center">업 종</td>
											<td>
												<c:choose>
													<c:when test="${tt == 0}">
														<input type="hidden" name="team_type" value="0" />본사사업부 
													</c:when>
													<c:when test="${tt == 1}">
														<input type="hidden" name="team_type" value="1" />1종사업부 
													</c:when>
													<c:when test="${tt == 4}">
														<input type="hidden" name="team_type" value="4" />4종사업부 
													</c:when>
												</c:choose>
											</td>
										</tr>
										<tr>
											<td bgcolor="#EFEFEF"><p align="center">팀 순서</td>
											<td><input type=text name="team_order" class=input value="${teamVO.team_order}" size="30"></td>
										</tr>
										<tr>
											<td bgcolor="#EFEFEF"><p align="center">수임 코드</td>
											<td><input type=text name="suim_scode" class=input value="${teamVO.suim_scode}" size="30"></td>
										</tr>
										<tr>
											<td bgcolor="#EFEFEF"><p align="center">종결 코드</td>
											<td><input type=text name="suim_ecode" class=input value="${teamVO.suim_ecode}" size="30"></td>
										</tr>
										<tr>
											<td bgcolor="#EFEFEF"><p align="center">인터폰</td>
											<td><input type=text name="team_interphone" class=input size="30" value="${teamVO.team_interphone}"></td>
										</tr>
										<tr>
											<td bgcolor="#EFEFEF"><p align="center">전화번호</td>
											<td><input type=text name="team_telephone" class=input size="30" value="${teamVO.team_telephone }"></td>
										</tr>
										<tr>
											<td bgcolor="#EFEFEF"><p align="center">팩스번호</td>
											<td><input type=text name="team_fax" class=input size="30" value="${teamVO.team_fax}"></td>
										</tr>
										<tr>
											<td bgcolor="#EFEFEF"><p align="center">주소</td>
											<td><input type=text name="team_addr" class=input size="70" value="${teamVO.team_addr}"></td>
										</tr>
										<tr>
											<td bgcolor="#EFEFEF"><p align="center">팀마크</td>
											<td><input type="text" name="team_mark" class=input size="35" value="${teamVO.team_mark}"></td>
										</tr>
										<tr>
											<td bgcolor="#EFEFEF"><p align="center">팀장</td>
											<td>
												<select name="team_manager" id="team_manager" style="width:150px;">
													<c:choose>
														<c:when test="${currentTmMng.get(0).user_no eq '0' or currentTmMng.get(0).user_no eq null}">
															<option selected="selected" value="${currentTmMng.get(0).user_no}">팀장 미지정</option>
														</c:when>
														<c:otherwise>
															<option selected="selected" value="${currentTmMng.get(0).user_no}">${currentTmMng.get(0).user_name}</option>
															<option value="0">팀장 미지정</option>
														</c:otherwise>
													</c:choose>
													
													<c:forEach items="${AllMember}" var="allMemVO" varStatus="status">
														<c:if test="${currentTmMng.get(0).user_no ne allMemVO.user_no}">
															<option value="${allMemVO.user_no}">${allMemVO.user_name}</option>
														</c:if>													
													</c:forEach>
												</select>
											</td>
										</tr>
										
										<tr>
											<td bgcolor="#EFEFEF"><p align="center">1종 통계 노출</p></td>
											<td>
												<c:choose>
													<c:when test="${teamVO.team_statistics1 eq 1}">
														<input type="radio" name="team_statistics1" value="0"  >통계 포함 
														<input type="radio" name="team_statistics1" value="1" checked="checked">통계 제외	
													</c:when>
													<c:otherwise>
														<input type="radio" name="team_statistics1" value="0"  checked="checked">통계 포함 
														<input type="radio" name="team_statistics1" value="1" >통계 제외	
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
										<tr>
											<td bgcolor="#EFEFEF"><p align="center">4종 통계 노출</p></td>
											<td>
												<c:choose>
													<c:when test="${teamVO.team_statistics4 eq 1}">
														<input type="radio" name="team_statistics4" value="0"  >통계 포함 
														<input type="radio" name="team_statistics4" value="1"  checked="checked">통계 제외
													</c:when>
													<c:otherwise>
														<input type="radio" name="team_statistics4" value="0"  checked="checked">통계 포함 
														<input type="radio" name="team_statistics4" value="1" >통계 제외
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
										<tr>
											<td bgcolor="#EFEFEF"><p align="center">인사 포함 여부</p></td>
											<td>
												<c:choose>
													<c:when test="${teamVO.only_statistics eq 1}">
														<input type="radio" name="only_statistics" value="0">포함 
														<input type="radio" name="only_statistics" value="1" checked="checked">제외
													</c:when>
													<c:otherwise>
														<input type="radio" name="only_statistics" value="0" checked="checked">포함 
														<input type="radio" name="only_statistics" value="1">제외
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
										
										<!-- 서면심사 팀 여부 20200319 by top3009 -->
										<tr>
											<td bgcolor="#EFEFEF"><p align="center">서면심사팀 여부</p></td>
											<td height="30px;">
												<div id="writtenCheckZone" style="float:left;width:150px;padding-top:5px;">
												<c:choose>
													<c:when test="${teamVO.team_written eq 1}">
														<input type="radio" name="team_written" value="1" checked="checked">포함 
														<input type="radio" name="team_written" value="0" >제외
													</c:when>
													<c:otherwise>
														<input type="radio" name="team_written" value="1" >포함 
														<input type="radio" name="team_written" value="0" checked="checked">제외
													</c:otherwise>
												</c:choose>
												</div>												
												<!-- 서면심사 팀인경우 보험사 정보 추가 시작 20220209 by top3009 -->
												<div id="selWrittenPtnrIdZone" style="float:left;display:none;">												
													<select id="written_ptnr_id" name="written_ptnr_id" style="width:150px;">
														<option value="0">- 보험사 선택 -</option>
														<c:forEach items="${writtenPtnrIdList}" var="ptnrInfo" varStatus="status">														
															<option value="${ptnrInfo.ptnr_id}">${ptnrInfo.ptnr_nick}</option>																											
														</c:forEach>
													</select>
												</div>																					
												<!-- 서면심사 팀인경우 보험사 정보 추가 끝 20220209 by top3009 -->
											</td>
										</tr>
										<!-- 팀 부문정보 추가 20190708 by top3009 -->
										<tr>
											<td bgcolor="#EFEFEF"><p align="center">부문 설정</p></td>
											<td>
												<select name="team_sector" id="team_sector" style="width:150px;">
													<c:forEach items="${teamSectorList}" var="teamSector" varStatus="status">
														<c:choose>
															<c:when test="${teamVO.team_sector eq teamSector.col_cd}">
																<option value="${teamSector.col_cd}" selected="selected">${teamSector.col_val}</option>
															</c:when>
															<c:otherwise>
																<option value="${teamSector.col_cd}">${teamSector.col_val}</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select>												
											</td>
										</tr>
										
										<!-- 팀 센터정보 추가 20190712 by top3009 -->																		
										<tr>
											<td bgcolor="#EFEFEF"><p align="center">센터 설정</p></td>
											<td>
												<select name="team_center" id="team_center" style="width:150px;">
													<c:forEach items="${teamCenterList}" var="teamCenter" varStatus="status">
														<c:choose>
															<c:when test="${teamVO.team_center eq teamCenter.col_cd}">
																<option value="${teamCenter.col_cd}" selected="selected">${teamCenter.col_val}</option>
															</c:when>
															<c:otherwise>
																<option value="${teamCenter.col_cd}">${teamCenter.col_val}</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select>												
											</td>
										</tr>
										
										<!-- 팀 업무 구분 시작 20220404 by top3009 -->
										<tr>
											<td bgcolor="#EFEFEF"><p align="center">업무 구분 설정</p></td>
											<td height="30px;">
												<div id="partCheckZone" style="float:left;width:400px;padding-top:5px;">
												<c:choose>
													<c:when test="${teamVO.team_part eq 1}">
														<input type="radio" name=team_part value="0">없음 &nbsp;&nbsp; 
														<input type="radio" name="team_part" value="1" checked="checked">실무팀 &nbsp;&nbsp;
														<input type="radio" name="team_part" value="2" >지원팀 &nbsp;&nbsp;
														<input type="radio" name="team_part" value="3" >센터지정 &nbsp;&nbsp;
														<input type="radio" name="team_part" value="4" >부문지정
													</c:when>
													<c:when test="${teamVO.team_part eq 2}">
														<input type="radio" name=team_part value="0">없음 &nbsp;&nbsp; 
														<input type="radio" name="team_part" value="1" >실무팀 &nbsp;&nbsp;
														<input type="radio" name="team_part" value="2" checked="checked">지원팀 &nbsp;&nbsp;
														<input type="radio" name="team_part" value="3" >센터지정 &nbsp;&nbsp;
														<input type="radio" name="team_part" value="4" >부문지정
													</c:when>
													<c:when test="${teamVO.team_part eq 3}">
														<input type="radio" name=team_part value="0">없음 &nbsp;&nbsp; 
														<input type="radio" name="team_part" value="1" >실무팀 &nbsp;&nbsp;
														<input type="radio" name="team_part" value="2" >지원팀 &nbsp;&nbsp;
														<input type="radio" name="team_part" value="3"  checked="checked">센터지정 &nbsp;&nbsp;
														<input type="radio" name="team_part" value="4" >부문지정
													</c:when>
													<c:when test="${teamVO.team_part eq 4}">
														<input type="radio" name=team_part value="0">없음 &nbsp;&nbsp; 
														<input type="radio" name="team_part" value="1" >실무팀 &nbsp;&nbsp;
														<input type="radio" name="team_part" value="2" >지원팀 &nbsp;&nbsp;
														<input type="radio" name="team_part" value="3" >센터지정 &nbsp;&nbsp;
														<input type="radio" name="team_part" value="4" checked="checked">부문지정
													</c:when>
													<c:otherwise>
														<input type="radio" name=team_part value="0" checked="checked">없음 &nbsp;&nbsp; 
														<input type="radio" name="team_part" value="1" >실무팀 &nbsp;&nbsp;
														<input type="radio" name="team_part" value="2" >지원팀 &nbsp;&nbsp;
														<input type="radio" name="team_part" value="3" >센터지정 &nbsp;&nbsp;
														<input type="radio" name="team_part" value="4" >부문지정
													</c:otherwise>
												</c:choose>
												</div>
											</td>
										</tr>
										<!-- 팀 업무 구분 끝 20220404 by top3009 -->
										
										<!-- 팀 지역설정 및 보험사 지정 기능 추가 시작 20220602 by top3009-->
										<tr>
											<td bgcolor="#EFEFEF"><p align="center">지역 설정</p></td>
											<td>
												<select name="team_zone" id="team_zone" style="width:150px;">
													<c:forEach items="${zoneList}" var="teamZone" varStatus="status">
														<c:choose>
															<c:when test="${teamVO.team_zone eq teamZone.col_cd}">
																<option value="${teamZone.col_cd}" selected="selected">${teamZone.col_val}</option>
															</c:when>
															<c:otherwise>
																<option value="${teamZone.col_cd}">${teamZone.col_val}</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select>
											</td>
										</tr>
										
										<tr>
											<td bgcolor="#EFEFEF"><p align="center">보험사 설정</p></td>
											<td>
												<select name="team_ptnr_id" id="team_ptnr_id" style="width:150px;">
													<c:if test='${action eq "add" or teamVO.team_ptnr_id eq 0}'>
														<option value="0" selected="selected">미지정</option>
													</c:if>
													<c:forEach items="${teamPtnrList}" var="teamPtnrId" varStatus="status">
														<c:choose>															
															<c:when test="${teamVO.team_ptnr_id eq teamPtnrId.ptnr_id}">
																<option value="${teamPtnrId.ptnr_id}" selected="selected">${teamPtnrId.ptnr_nick}</option>
															</c:when>
															<c:otherwise>
																<option value="${teamPtnrId.ptnr_id}">${teamPtnrId.ptnr_nick}</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select>
											</td>
										</tr>
										<!-- 팀 지역설정 및 보험사 지정 기능 추가 끝 20220602 by top3009-->
										
									</table>

								</div><!-- //tableStyle21 -->

								<p align="center">&nbsp;</p>
								<p style="text-align:right;padding-right:5px;">
									<c:if test="${action eq 'modify'}">
										<a class="btn-vacation-aprv" id="boardSrcBtn" style="background:#CEE3F6;cursor:pointer;" onclick="javascript:SubmitModify();">수정</a>
										<!-- <img src="./resources/ls_img/top_team/icon_write.gif" onclick="javascript:SubmitDo('modify');" style="cursor:pointer;"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
									</c:if>

									<c:if test="${memberCnt eq 0}">
										<a class="btn-vacation-aprv" id="boardSrcBtn" style="background:#F6CED8;cursor:pointer;" onclick="javascript:SubmitDel();">삭제</a>
										<!-- <img src="./resources/ls_img/top_team/btn_del.gif" onclick="javascript:SubmitDel();" style="cursor:pointer;"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
									</c:if>

									<c:if test="${action eq 'add'}">
									<a class="btn-vacation-aprv" id="boardSrcBtn" style="background:#CEE3F6;cursor:pointer;" onclick="javascript:SubmitAdd();">등록</a>
										<!-- <img src="./resources/ls_img/top_team/btn_ok.gif" onclick="javascript:SubmitAdd();" style="cursor:pointer;"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
									</c:if>
																		
									<a class="btn-vacation-aprv" id="boardSrcBtn" href="./teamlist?selTab=${selTab}">목록</a>
									<!-- <a href="javascript:history.back(-1);">
										<img src="./resources/ls_img/top_team/btn_cancel.gif" border="0">										
									</a> -->
								</p>
							</form>

						</div><!-- //guestcnt -->
						
						<!-- 팀관리 - 메모 시작 -->
						<div class="guestcnt4" style="display:none;">
						
						<input type="hidden" id="team_id_memo" name="team_id_memo" value="${teamVO.team_id}">
						
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

</div>
<!-- //wrapper -->

</body>
</html>
