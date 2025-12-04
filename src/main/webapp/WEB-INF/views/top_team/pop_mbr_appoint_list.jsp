<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
	.select2-results__option{
		padding : 5px;
		font-size: 11px;
	}
</style>
<script>

	$(document).ready(function(){
		$(".select2").select2();
	});//$(document).ready
	
	//육아근로기간 단축 함수시작
	
	// 추가 화면 열기
	function fnCareAddView(type){
		$("#"+type+"_add").show();		
	}
	
	// 추가 화면 닫기
	function fnCareAddUndo(type){
		$("#"+type+"_add").hide();
	}
	
	// 수정 화면 열기
	function fnCareModView(careNo, type){		
		$("#"+type+"_view_"+careNo).hide();
		$("#"+type+"_edit_"+careNo).show();
	}
	
	// 수정 화면 닫기
	function fnCareModUndo(careNo, type){
		$("#"+type+"_view_"+careNo).show();
		$("#"+type+"_edit_"+careNo).hide();
	}
	
	//육아근로기간 단축 함수 끝
	
	// 추가 화면 열기
	function fnAppointAddView(type){
		$("#"+type+"_add").show();		
	}
	
	// 추가 화면 닫기
	function fnAppointAddUndo(type){
		$("#"+type+"_add").hide();
	}
	
	// 수정 화면 열기
	function fnAppointModView(appointNo, type){
		$("#"+type+"_view_"+appointNo).hide();
		$("#"+type+"_edit_"+appointNo).show();
	}
	
	// 수정 화면 닫기
	function fnAppointModUndo(appointNo, type){
		$("#"+type+"_view_"+appointNo).show();
		$("#"+type+"_edit_"+appointNo).hide();
	}
	
	// 추가
	function fnAppointAdd(type){
		if ( fnAppointValid("add", type) ){
			return;
		}
		
		var param ={};
		var alertComment = "";
		param.action = "C";
		param.type = type;
		param.userNo = $("#user_no").val();
		
		if (type == "appoint"){			
			param.appointDate = $("#appoint_date_add").val();
			param.appointDepart = $("#appoint_depart_add option:selected").attr("txt");
			param.appointDepartCd = $("#appoint_depart_add option:selected").val();
			param.appointWorkLevel = $("#appoint_work_level_add option:selected").text(); 
			param.appointWorkLevelCd = $("#appoint_work_level_add option:selected").val(); 
			param.appointWorkRank = $("#appoint_work_rank_add option:selected").text();
			param.appointWorkRankCd = $("#appoint_work_rank_add option:selected").val();
			param.appointWorkType = $("#appoint_work_type_add option:selected").text();
			param.appointWorkTypeCd = $("#appoint_work_type_add option:selected").val();
			param.appointWorkJob = $("#appoint_work_job_add option:selected").text();
			param.appointWorkJobCd = $("#appoint_work_job_add option:selected").val();
			param.appointWorkJobTmType = $("#appoint_work_job_add option:selected").attr("tmType");
			param.appointPlace = $("#appoint_place_add").val(); 			
			param.appointComment = $("#appoint_comment_add").val(); 			
			param.appointEtc = $("#appoint_etc_add").val(); 
			alertComment = "입력 하신 발령사항을 저장 하시겠습니까?\n\n※ 입력하신 내용대로 사원정보가 수정됩니다.";
			
		}else if(type == "position"){
			param.positionDate = $("#position_date_add").val();
			param.positionDepart = $("#position_depart_add option:selected").attr("txt");
			param.positionDepartCd = $("#position_depart_add option:selected").val();
			param.positionWorkLevel = $("#position_work_level_add option:selected").text(); 
			param.positionWorkLevelCd = $("#position_work_level_add option:selected").val(); 
			param.positionWorkRank = $("#position_work_rank_add option:selected").text();
			param.positionWorkRankCd = $("#position_work_rank_add option:selected").val();
			param.positionWorkType = $("#position_work_type_add option:selected").text();
			param.positionWorkTypeCd = $("#position_work_type_add option:selected").val();
			param.positionPlace = $("#position_place_add").val(); 			
			param.positionComment = $("#position_comment_add").val(); 			
			param.positionEtc = $("#position_etc_add").val(); 			
			
			if ( $("#position_comment_add").val() == "면수습" ){
				alertComment = "입력 하신 진급사항을 저장 하시겠습니까?\n\n※ 발령 내용이 면수습일 경우, 해당 직원의 면수습일이 발령일자로 변경됩니다.";
			}else{
				alertComment = "입력 하신 진급사항을 저장 하시겠습니까?";
			}
			
		}else if(type == "work"){		//휴 복직 추가
			//추가항목
			param.workTeamId = $("#work_team_id_add").val();
			param.workLevel = $("#work_level_add").val();
			param.workSdate = $("#work_sdate_add").val();
			param.workEdate = $("#work_edate_add").val();
			param.leaveType = $("#leave_type_add").val();			
			param.workComment = $("#work_comment_add").val();			
			param.workEtc = $("#work_etc_add").val();
			
			if( $("#work_sdate_add").val() == '' ){
				alert("휴직 시작일자를 입력해주세요.");
				return;
			}
			
			/* if( $("#work_edate_add").val() == '' ){
				alert("휴직 종료일자를 입력해주세요.");
				return;
			} */
			
			if( $("#work_team_id_add").val() == 0 ){
				alert("부서를 선택해주세요.");
				return;
			}
			
			if( $("#work_level_add").val() == 0 ){
				alert("직위를 선택해주세요.");
				return;
			}
			
			if( $("#leave_type_add").val() == '' ){
				alert("휴직유형을 선택해주세요.");
				return;
			}
			
			if( $("#work_comment_add").val() == '' ){
				alert("휴 복직 사유를 입력해주세요.");
				return;
			}
			
			alertComment = "입력 하신 휴직사항을 저장하시겠습니까?";
			
		}else if(type == "care"){
			
			//추가항목
			param.careTeamId = $("#care_team_id_add").val();
			param.careLevel = $("#care_level_add").val();
			param.careSdate = $("#care_sdate_add").val();
			param.careEdate = $("#care_edate_add").val();
			param.careWorktime = $("#care_worktime_add").val();			
			param.careComment = $("#care_comment_add").val();			
			param.careEtc = $("#care_etc_add").val();
			
			if( $("#care_sdate_add").val() == '' ){
				alert("육아근로기간단축 시작일자를 입력해주세요.");
				return;
			}
			
			if( $("#care_edate_add").val() == '' ){
				alert("육아근로기간단축 종료일자를 입력해주세요.");
				return;
			}
			
			if( $("#care_team_id_add").val() == 0 ){
				alert("부서를 선택해주세요.");
				return;
			}
			
			if( $("#care_level_add").val() == 0 ){
				alert("직위를 선택해주세요.");
				return;
			}
			
			if( $("#care_worktime_add").val() == 0 ||  $("#care_worktime_add").val() == '' ){
				alert("육아근로기간단축 일일근무시간을 입력해주세요.");
				$("#care_worktime_add").focus();
				return;
			}
			
			if( !($("#care_worktime_add").val() > 3 && $("#care_worktime_add").val() < 8) ){
				alert("육아근로기간단축 일일근무시간은 4~7시간으로 입력해주세요.");
				$("#care_worktime_add").focus();
				return;
			}
			
			if( $("#care_comment_add").val() == '' ){
				alert("육아근로기간단축 사유를 입력해주세요.");
				return;
			}
			
			alertComment = "입력 하신 육아근로기간단축을 저장하시겠습니까?";			
			
		}else{
			alert("처리에 문제가 발생 하였습니다.\nIT지원파트에 문의 해 주세요..");
			return;
		}
		
		var r = confirm(alertComment);
		if (!r) {
			return;
		}
		
		fnAppointAction(param);
	}
	
	//text내 불필요문자제거
	function removeText(param){
		var reText = param.replace(/\s/gi, "").replace('└',"");		
		return reText;		
	}
	
	// 수정
	function fnAppointUdt(no, type){
		if ( fnAppointValid(no, type) ){
			return;
		}
		
		var param ={};
		param.action = "U";
		param.type = type;
		param.userNo = $("#user_no").val();
		
		if (type == "appoint"){
			param.appointNo = no;
			param.appointDate = $("#appoint_date_mod_"+no).val();			
			param.appointDepart = removeText( $("#appoint_depart_mod_"+no+" :selected").text() );			
			param.appointTeamId = $("#appoint_depart_mod_"+no).val();
			param.appointWorkLevel = removeText( $("#appoint_work_level_mod_"+no+" :selected").text() );
			param.appointWorkLevelCd = $("#appoint_work_level_mod_"+no).val();			
			param.appointWorkRank = removeText( $("#appoint_work_rank_mod_"+no+" :selected").text() );
			param.appointWorkRankCd = $("#appoint_work_rank_mod_"+no).val();			
			param.appointWorkType = $("#appoint_work_type_mod_"+no+" :selected").text();
			param.appointWorkTypeCd = $("#appoint_work_type_mod_"+no).val();			
			param.appointWorkJob = removeText( $("#appoint_work_job_mod_"+no+" :selected").text() );
			param.appointWorkJobCd = $("#appoint_work_job_mod_"+no).val();
			param.appointPlace = $("#appoint_place_mod_"+no).val();
			param.appointComment = $("#appoint_comment_mod_"+no).val(); 
			param.appointEtc = $("#appoint_etc_mod_"+no).val();
			
			var r = confirm("발령사항을 수정 하시겠습니까?");
			if (!r) {
				return;
			}
			
		}else if (type == "position"){
			param.positionNo = no;
			param.positionDate = $("#position_date_mod_"+no).val();
			param.positionDepart = removeText( $("#position_depart_mod_"+no+" :selected").text() );
			param.positionDepartCd = $("#position_depart_mod_"+no).val();			
			param.positionWorkLevel = removeText( $("#position_work_level_mod_"+no+" :selected").text() );
			param.positionWorkLevelCd = $("#position_work_level_mod_"+no).val();			
			param.positionWorkRank = removeText( $("#position_work_rank_mod_"+no+" :selected").text() );
			param.positionWorkRankCd = $("#position_work_rank_mod_"+no).val();			
			param.positionWorkType =  $("#position_work_type_mod_"+no+" :selected").text();
			param.positionWorkTypeCd = $("#position_work_type_mod_"+no).val();			
			param.positionPlace = $("#position_place_mod_"+no).val(); 			
			param.positionComment = $("#position_comment_mod_"+no).val(); 			
			param.positionEtc = $("#position_etc_mod_"+no).val(); 	
			
			var r = confirm("진급사항을 수정 하시겠습니까?");
			if (!r) {
				return;
			}
		}else if( type == "work"){
			param.workNo = no;
			param.workTeamId = $("#work_team_id_mod_"+no).val();
			param.workLevel = $("#work_level_mod_"+no).val();
			param.workSdate = $("#work_sdate_mod_"+no).val();
			param.workEdate = $("#work_edate_mod_"+no).val();
			param.leaveType = $("#leave_type_mod_"+no).val();			
			param.workComment = $("#work_comment_mod_"+no).val();			
			param.workEtc = $("#work_etc_mod_"+no).val();
			
			var r = confirm("휴직사항을 수정 하시겠습니까?");
			if (!r) {
				return;
			}
		}else if( type == "care" ){
			param.careNo =  no;
			param.careTeamId = $("#care_team_id_mod_"+no).val();
			param.careLevel = $("#care_level_mod_"+no).val();
			param.careSdate = $("#care_sdate_mod_"+no).val();
			param.careEdate = $("#care_edate_mod_"+no).val();
			param.careWorktime = $("#care_worktime_mod_"+no).val();
			param.careComment = $("#care_comment_mod_"+no).val();			
			param.careEtc = $("#care_etc_mod_"+no).val();
			
			if( !($("#care_worktime_mod_"+no).val() > 3 && $("#care_worktime_mod_"+no).val() < 8) ){
				alert("육아근로기간단축 일일근무시간은 4~7시간으로 입력해주세요.");
				$("#care_worktime_mod_"+no).focus();
				return;
			}
			
			var r = confirm("육아근로기간 단축사항을 수정 하시겠습니까?");
			if (!r) {
				return;
			}
		}
		
		fnAppointAction(param);
	}
	
	// 삭제
	function fnAppointDelete(no, type){
		var r = confirm("해당 내용을 삭제 하시겠습니까?");
		if (!r){
			return;
		}
		
		var param = {};
		param.action = "D";
		param.type = type;
		param.userNo = $("#user_no").val();
		
		if (type == "appoint"){
			param.appointNo = no;
		}else if (type == "position"){
			param.positionNo = no;
		}else if(type == "work"){
			param.workNo = no;
		}else if(type == "care"){
			param.careNo = no;
		}
		
		fnAppointAction(param);
	}	
	
	// 유효성 체크
	function fnAppointValid(gubun, type){
		if( $("#"+type+"_date_"+gubun).val() == "" ){			
			if( type == 'work' ){
				alert("휴복직일자를 입력 해 주세요..");
				return true;
			}else{
				alert("발령일자를 입력 해 주세요..");
				return true;
			}
		}

		if ( $("#"+type+"_depart_"+gubun).val() == 0 ){
			alert("발령 부서를 선택 해 주세요..");
			return true;
		}
		
		if ( gubun == "add"){
			if ( $("#"+type+"_work_level_"+gubun).val() == 0 ){
				alert("직위를 선택 해 주세요..");
				return true;
			}
			
			if ( $("#"+type+"_work_rank_"+gubun).val() == '' ){
				alert("직급을 선택 해 주세요..");
				return true;
			}
			
			if ( $("#"+type+"_work_type_"+gubun).val() == 0 ){
				alert("직책을 선택 해 주세요..");
				return true;
			}
			
			if (type == "appoint"){
				if ( $("#appoint_work_job_"+gubun).val() == 0 ){
					alert("직무를 선택 해 주세요..");
					return true;
				}
			}
			
		}
		
		return false;
	}
	
	function fnAppointAction(param){
		
	    var url = "/MbrAppointAction";
	    
	    $.ajax({
	        type: "POST",
	        url: url,
	        data: param,
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        timeout: 20000,
	        dataType: "JSON", 
	        success: function(data){
	        	if ( data.succCnt == 1){
	        		
	        		var succComment = "";
	 				if (param.action == "C"){
	 					succComment = "입력에 성공하였습니다..";
	 				}else if(param.action == "U"){
	 					succComment = "수정에 성공하였습니다..";
	 				}else if(param.action == "D"){
	 					succComment = "삭제에 성공하였습니다..";	 					
	 				}
	 				alert(succComment);
	 				
	 				popMbrDetail.tabGubun.value = "appoint";
	 				popMbrDetail.submit();
	 				
	        	}else{
	        		alert("처리에 실패 하였습니다.\nIT지원파트에 문의 해 주세요..");
	        	}
	        }
	        ,error: function(e){
	            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	        }
	    });
	}
	
	//상/벌 추가 폼 열기
	function fnAwardAddView(){
		$("#tr_award_add_form").show();
	}
	
	//상/벌 추가 폼 닫기
	function fnAwardAddCancel(){
		$("#tr_award_add_form").hide();
	}
	
	//상/벌 수정 폼 열기
	function fnAwardModView( p_akey ){
		$("#award_view_"+p_akey).hide();
		$("#award_edit_"+p_akey).show();
	}
	
	//상/벌 수정폼 닫기
	function fnAwardModCancel( p_akey ){
		$("#award_edit_"+p_akey).hide();
		$("#award_view_"+p_akey).show();		
	}
	
	//상/벌 추가내용 저장
	function fnAwardAction( p_action, p_akey ){
		
		var akey_val = p_akey;
		var user_no_val = $("#user_no").val();
		var award_date_val = "";
		var team_id_val = "";
		var work_level_val = "";
		var award_flag_val = "";
		var award_content_val = "";
		var award_memo_val = "";
		var award_file_val = "";
		
		if( p_action == 'C' ){		//추가
			award_date_val = $("#award_date_add").val();
			team_id_val = $("#award_team_id_add").val();
			work_level_val = $("#award_work_level_add").val();
			award_flag_val = $("#award_flag_add").val();
			award_content_val = $("#award_content_add").val();
			award_memo_val = $("#award_memo_add").val();
			award_file_val = $('#award_file_add')[0].files[0];					//첨부파일 추가
		}
		
		if( p_action == 'U' ){		//수정
			award_date_val = $("#award_date_mod_"+p_akey).val();
			team_id_val = $("#award_team_id_mod_"+p_akey).val();
			work_level_val = $("#award_work_level_mod_"+p_akey).val();
			award_flag_val = $("#award_flag_mod_"+p_akey).val();
			award_content_val = $("#award_content_mod_"+p_akey).val();
			award_memo_val = $("#award_memo_mod_"+p_akey).val();
			
			if( $("#award_file_mod_"+p_akey).val() != '' ){										//수정할 파일이 있는경우만 처리한다.
				award_file_val = $("#award_file_mod_"+p_akey)[0].files[0];					//첨부파일 수정	
			}			
		}
		
		//필수값 체크 시작
		if( p_action == 'C' || p_action == 'U' ){		//추가 또는 수정인 경우 확인
			
			if( award_date_val == '' ){
				alert("상/벌 일자를 입력해 주세요.");
				return;
			}
		
			if( team_id_val == 0 ){
				alert("부서를 선택해 주세요.");
				return;
			}
			
			if( work_level_val == 0 ){
				alert("직위를 선택해 주세요.");
				return;
			}
			
			if( award_flag_val == 0 ){
				alert("상/벌 여부를 선택해주세요.");
				return;
			}
		
		}
		
		//삭제인 경우
		if( p_action == 'D' ){
			if( !confirm('해당 상벌사항을 삭제하시겠습니까?') ){
				return;
			}
		}
		
		//첨부파일 삭제인 경우
		if( p_action == 'FD' ){
			if( !confirm('해당 상벌사항의 첨부파일을 삭제하시겠습니까?') ){
				return;
			}
		}
		
		var sUrl = "mbrAwardAction";
		
		var param = new FormData();
		
		param.append("action_flag",p_action);
		param.append("akey",akey_val);
		param.append("user_no",user_no_val);
		param.append("team_id",team_id_val);
		param.append("work_level",work_level_val);
		param.append("award_flag",award_flag_val);
		param.append("award_content",award_content_val);
		param.append("award_memo",award_memo_val);
		param.append("award_date",award_date_val);
		param.append("awardFile",award_file_val);			//파일추가
		
		$.ajax({
	        type: "POST",
	        url: sUrl,
	        data: param,
	        timeout: 20000,
	        processData: false,
	        contentType: false,
	        dataType: "JSON",
	        //contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	        success: function(data){
	        	if ( data.succCnt == 1){	        			        		
	        		var succComment = "";
	 				if (p_action == "C"){
	 					succComment = "입력에 성공하였습니다..";
	 				}else if(p_action == "U"){
	 					succComment = "수정에 성공하였습니다..";
	 				}else if(p_action == "D"){
	 					succComment = "삭제에 성공하였습니다..";	 					
	 				}else if(p_action == "FD"){
	 					succComment = "첨부파일 삭제에 성공하였습니다..";
	 				}
	 				alert(succComment);
	 				
	 				popMbrDetail.tabGubun.value = "appoint";
	 				popMbrDetail.submit();	 				
	 				
	        	}else{
	        		alert("처리에 실패 하였습니다.\nIT지원파트에 문의 해 주세요..");
	        	}
	        }
	        ,error: function(e){
	            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	        }
	    });
		
	}
	
</script>

		<div class= "tableStyle2">
		<!-- 검색 결과 테이블 시작-->
		<table>
			<colgroup>
					<col width="10%">
					<col width="15%">
					<col width="8%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="7%">
			</colgroup>
			<thead>
				<tr>
					<th colspan="10">
						발령사항	
						<i class="fas fa-plus-square fa-lg" style="cursor:pointer;color:#0000ce;" onclick="fnAppointAddView('appoint');"></i>
					</th>
				</tr>
				
				<tr>
					<th>발령일자</th>
					<th>부서</th>
					<th>직위</th>
					<th>직급
						<input type="button" class="pop" onclick="fnCodeDsc();" value="설명" />
					</th>
					<th>직책</th>
					<th>직무</th>
					<th>근무지</th>
					<th>발령내용</th>
					<th>비고</th>
					<th> - </th>
				</tr>

				<tr id="appoint_add" style="border:2px solid #0000ce; display:none;">
					<td style="letter-spacing: 0px;">
						<!-- 발령일자 -->
						<input type="text" id="appoint_date_add" class="classCalendar" name="appoint_date" value="" style="width: 70%;"/>
					</td>
					<td style="text-align: left;">
						<!-- 부서 -->
						<select class="select2" id="appoint_depart_add" style="width: 100%;">
							<option value="0">선택</option>
							<c:forEach items="${teamList}" var = "teamVo">
								<option value="${teamVo.team_id}" txt="${teamVo.team_name}">
									<c:if test="${teamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
									<c:if test="${teamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
									${teamVo.team_name}
								</option>
							</c:forEach>
						</select>							
					</td>
					
					<td style="text-align: left;">
						<!-- 직위 -->
						<select class="select2" id="appoint_work_level_add" style="width: 100%;">
							<c:forEach items="${workLevelList}" var = "item">
								<option value="${item.col_cd}">${item.col_val}</option>
							</c:forEach>
						</select>		
						
					</td>
					
					<td style="text-align: left;">
						<!-- 직급 -->
						<select class="select2" id="appoint_work_rank_add" style="width:100%;">
							<option value="">선택</option>
							<c:forEach var="item" items="${workRankList}">
								<option value="${item.col_cd}">${item.col_val}</option>
							</c:forEach>
						</select>	
					</td>
					
					<td style="text-align: left;">
						<!-- 직책 -->
						<select class="select2" id="appoint_work_type_add" style="width:100%;">
							<c:forEach var="item" items="${workTypeList}">
								<option value="${item.col_cd}">${item.col_val}</option>
							</c:forEach>
						</select>	
					</td>
					
					<td style="text-align: left;">
						<!-- 직무 -->
						<select class="select2" id="appoint_work_job_add" style="width:100%;">
							<option value="0">선택</option>
							<c:forEach var="item" items="${workJobList}">
								<option value="${item.col_cd2}" tmType="${item.col_cd1}"> ${item.col_val}</option>
							</c:forEach>
						</select>	
					</td>
					  
					<td style="text-align: left;">
						<!-- 근무지 -->
						<select class="select2" id="appoint_place_add" name="appoint_place" style="width: 100%;">
							<option value="본사(서울)">본사(서울)</option>
							<option value="수원">수원</option>
							<option value="인천">인천</option>
							<option value="강원">강원</option>
							<option value="부산">부산</option>
							<option value="대전">대전</option>
							<option value="대구">대구</option>
							<option value="창원">창원</option>
							<option value="순천">순천</option>
							<option value="광주">광주</option>
							<option value="전주">전주</option>
							<option value="제주">제주</option>
						</select>
<!-- 						<input type="text" id="appoint_place_add" name="appoint_place" style="width: 95%;"/> -->
					</td>
					<td style="text-align: left;">
						<!-- 발령내용 -->
						<select class="select2" id="appoint_comment_add" name="appoint_comment" style="width: 100%;">
							<option value="신규발령">신규발령</option>
							<option value="인사이동">인사이동</option>
						</select>
<!-- 						<input type="text" id="appoint_comment_add" name="appoint_comment" style="width: 95%;"/> -->
					</td>
					<td>
						<!-- 비고 -->
						<input type="text" id="appoint_etc_add" name="appoint_etc" style="width: 95%;"/>
					</td>
					<td>
						<!-- 버튼 -->
						<i class="fas fa-save fa-2x" data-fa-transform="shrink-6" data-fa-mask="fas fa-square" style="cursor:pointer;color:#7777ea;" onclick="fnAppointAdd('appoint');" ></i>
						<i class="fas fa-undo fa-2x" data-fa-transform="shrink-6" data-fa-mask="fas fa-square" style="cursor:pointer;" onclick="fnAppointAddUndo('appoint');"></i>
					</td>		
				</tr>
				 
				<c:forEach items="${getMbrAppoint}" var="item" varStatus="status">
					<tr id="appoint_view_${item.appoint_no}">
						<td style="letter-spacing: 0px;">${item.appoint_date}</td> <!-- 발령일자 -->
						<td>${item.appoint_depart}</td>		<!-- 부서 -->
						<td>${item.appoint_work_level}</td>		<!-- 직위 -->
						<td style="letter-spacing: 0;">${item.appoint_work_rank}</td>		<!-- 직급 -->
						<td>${item.appoint_work_type}</td>		<!-- 직책 -->
						<td>${item.appoint_work_job}</td>	<!-- 직무 -->
						<td>${item.appoint_place}</td>		<!-- 근무지 -->
						<td>${item.appoint_comment}</td>	<!-- 발령내용 -->
						<td>${item.appoint_etc}</td>		<!-- 비고 -->
						<!-- 버튼 -->
						<td>
							<i class="fas fa-pen-square fa-2x" style="cursor:pointer;color:#ffca00;" onclick="fnAppointModView(${item.appoint_no},'appoint');"></i>	
							<i class="fas fa-minus-square fa-2x" style="cursor:pointer;color:#dc0000;" onclick="fnAppointDelete(${item.appoint_no},'appoint');"></i>	
<!-- 							<input type="image" src="./resources/ls_img/btn_edit_s.gif" style="cursor:pointer;" /> 	수정화면 -->
<%-- 							<input type="image" src="./resources/ls_img/btn_del_s.gif" style="cursor:pointer;" value="${status.index}"/>	<!-- 삭제 --> --%>
						</td>
					</tr>
					
					<!-- 발령사항 수정 by top3009 -->
					<tr id="appoint_edit_${item.appoint_no}" style="border:2px solid #0000ce; display:none;">
						<td style="letter-spacing: 0px;">
							<!-- 발령일자 -->
							<input type="text" id="appoint_date_mod_${item.appoint_no}" name="appoint_date_mod" class="classCalendar" value="${item.appoint_date}" style="width: 70%;"/>
						</td>
						<td>
							<!-- 부서 -->
							<select class="select2" id="appoint_depart_mod_${item.appoint_no}" style="width: 100%;">
								<option value="0">선택</option>
								<c:forEach items="${teamList}" var = "teamVo">
									<option value="${teamVo.team_id}" txt="${teamVo.team_name}">
										<c:if test="${teamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
										<c:if test="${teamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
										${teamVo.team_name}
									</option>
								</c:forEach>
							</select>
							<script>
								$("#appoint_depart_mod_${item.appoint_no}").val('${item.appoint_team_id}');
								$("#appoint_depart_mod_${item.appoint_no}").trigger('change');
							</script>
						</td>
						<td style="text-align: left;">
						<!-- 직위 -->
							<select class="select2" id="appoint_work_level_mod_${item.appoint_no}" style="width: 100%;">
								<c:forEach items="${workLevelList}" var = "items">
									<option value="${items.col_cd}">${items.col_val}</option>
								</c:forEach>
							</select>
							<script>
								$("#appoint_work_level_mod_${item.appoint_no}").val('${item.appoint_work_level_cd}');
								$("#appoint_work_level_mod_${item.appoint_no}").trigger('change');
							</script>
						</td>
						<td style="text-align: left;">
							<!-- 직급 -->
							<select class="select2" id="appoint_work_rank_mod_${item.appoint_no}" style="width:100%;">
								<option value="">선택</option>
								<c:forEach var="items" items="${workRankList}">
									<option value="${items.col_cd}">${items.col_val}</option>
								</c:forEach>
							</select>
							<script>
								$("#appoint_work_rank_mod_${item.appoint_no}").val('${item.appoint_work_rank_cd}');
								$("#appoint_work_rank_mod_${item.appoint_no}").trigger('change');
							</script>
						</td>
						<td style="text-align: left;">
							<!-- 직책 -->
							<select class="select2" id="appoint_work_type_mod_${item.appoint_no}" style="width:100%;">
								<c:forEach var="items" items="${workTypeList}">
									<option value="${items.col_cd}">${items.col_val}</option>
								</c:forEach>
							</select>
							<script>
								$("#appoint_work_type_mod_${item.appoint_no}").val('${item.appoint_work_type_cd}');
								$("#appoint_work_type_mod_${item.appoint_no}").trigger('change');
							</script>	
						</td>
						<td style="text-align: left;">
						<!-- 직무 -->
							<select class="select2" id="appoint_work_job_mod_${item.appoint_no}" style="width:100%;">
								<option value="0">선택</option>
								<c:forEach var="items" items="${workJobList}">
									<option value="${items.col_cd2}" tmType="${items.col_cd1}"> ${items.col_val}</option>
								</c:forEach>
							</select>
							<script>
								$("#appoint_work_job_mod_${item.appoint_no}").val('${item.appoint_work_job_cd}');
								$("#appoint_work_job_mod_${item.appoint_no}").trigger('change');
							</script>
						</td>
						<td style="text-align: left;">
						<!-- 근무지 -->
							<select class="select2" id="appoint_place_mod_${item.appoint_no}" name="appoint_place" style="width: 100%;">
								<option value="본사(서울)">본사(서울)</option>
								<option value="수원">수원</option>
								<option value="인천">인천</option>
								<option value="강원">강원</option>
								<option value="부산">부산</option>
								<option value="대전">대전</option>
								<option value="대구">대구</option>
								<option value="창원">창원</option>
								<option value="순천">순천</option>
								<option value="광주">광주</option>
								<option value="전주">전주</option>
								<option value="제주">제주</option>
							</select>
							<script>
								$("#appoint_place_mod_${item.appoint_no}").val('${item.appoint_place}');
								$("#appoint_place_mod_${item.appoint_no}").trigger('change');
							</script>
						</td>
						<td style="text-align: left;">
							<!-- 발령내용 -->
							<select class="select2" id="appoint_comment_mod_${item.appoint_no}" name="appoint_comment" style="width: 100%;">
								<option value="신규발령">신규발령</option>
								<option value="인사이동">인사이동</option>
							</select>
							<script>
								$("#appoint_comment_mod_${item.appoint_no}").val('${item.appoint_comment}');
								$("#appoint_comment_mod_${item.appoint_no}").trigger('change');
							</script>
						</td>
						<td>
							<!-- 비고 -->
							<input type="text" id="appoint_etc_mod_${item.appoint_no}" name="appoint_etc" value="${item.appoint_etc}" style="width: 95%;"/>
						</td>
						<td>
							<!-- 버튼 -->							
							<i class="fas fa-save fa-2x" data-fa-transform="shrink-6" data-fa-mask="fas fa-square" style="cursor:pointer;color:#7777ea;" onclick="fnAppointUdt(${item.appoint_no},'appoint')"></i>
							<i class="fas fa-undo fa-2x" data-fa-transform="shrink-6" data-fa-mask="fas fa-square" style="cursor:pointer;" onclick="fnAppointModUndo(${item.appoint_no},'appoint');"></i>
						</td>
					</tr>	
				</c:forEach>
				
			</thead>
		</table>
		
		<br>

		<!-- 진급사항 -->
		<table>
			<colgroup>
					<col width="10%">
					<col width="15%">
					<col width="8%">
					<col width="12%">
					<col width="12%">
					<col width="12%">
					<col width="12%">
					<col width="12%">
					<col width="7%">
			</colgroup>
			<thead>
				<tr>
					<th colspan="9">
						진급사항	
						<i class="fas fa-plus-square fa-lg" style="cursor:pointer;color:#0000ce;" onclick="fnAppointAddView('position');"></i>
					</th>
				</tr>
				
				<tr>
					<th>발령일자</th>
					<th>부서</th>
					<th>직위</th>
					<th>직급
						<input type="button" class="pop" onclick="fnCodeDsc();" value="설명" />
					</th>
					<th>직책</th>
					<th>근무지</th>
					<th>발령내용</th>
					<th>비고</th>
					<th> - </th>
				</tr>

				<tr id="position_add" style="border:2px solid #0000ce; display:none;">
					<td style="letter-spacing: 0px;">
						<!-- 발령일자 -->
						<input type="text" id="position_date_add" class="classCalendar" name="position_date" value="" style="width: 70%;"/>
					</td>
					<td style="text-align: left;">
						<!-- 부서 -->
						<select class="select2" id="position_depart_add" style="width: 100%;">
							<option value="0">선택</option>
							<c:forEach items="${teamList}" var = "teamVo">
								<option value="${teamVo.team_id}" txt="${teamVo.team_name}">
									<c:if test="${teamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
									<c:if test="${teamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
									${teamVo.team_name}
								</option>
							</c:forEach>
						</select>							
					</td>
					
					<td style="text-align: left;">
						<!-- 직위 -->
						<select class="select2" id="position_work_level_add" style="width: 100%;">
							<c:forEach items="${workLevelList}" var = "item">
								<option value="${item.col_cd}">${item.col_val}</option>
							</c:forEach>
						</select>		
						
					</td>
					
					<td style="text-align: left;">
						<!-- 직급 -->
						<select class="select2" id="position_work_rank_add" style="width:100%;">
							<option value="">선택</option>
							<c:forEach var="item" items="${workRankList}">
								<option value="${item.col_cd}">${item.col_val}</option>
							</c:forEach>
						</select>	
					</td>
					
					<td style="text-align: left;">
						<!-- 직책 -->
						<select class="select2" id="position_work_type_add" style="width:100%;">
							<c:forEach var="item" items="${workTypeList}">
								<option value="${item.col_cd}">${item.col_val}</option>
							</c:forEach>
						</select>	
					</td>
					
					<td style="text-align: left;">
						<!-- 근무지 -->
						<select class="select2" id="position_place_add" name="position_place" style="width: 100%;">
							<option value="본사(서울)">본사(서울)</option>
							<option value="수원">수원</option>
							<option value="인천">인천</option>
							<option value="강원">강원</option>
							<option value="부산">부산</option>
							<option value="대전">대전</option>
							<option value="대구">대구</option>
							<option value="창원">창원</option>
							<option value="순천">순천</option>
							<option value="광주">광주</option>
							<option value="전주">전주</option>
							<option value="제주">제주</option>
						</select>
<!-- 						<input type="text" id="appoint_place_add" name="appoint_place" style="width: 95%;"/> -->
					</td>
					
					<td style="text-align: left;">
						<!-- 발령내용 -->
						<select class="select2" id="position_comment_add" name="position_comment" style="width: 100%;">
							<option value="신규발령">신규발령</option>
							<option value="보직변경">보직변경</option>
							<option value="인사이동">인사이동</option>
							<option value="직급승급">직급승급</option>
							<option value="직위승진">직위승진</option>
							<option value="면수습">면수습</option>
						</select>
<!-- 						<input type="text" id="position_comment_add" name="position_comment" style="width: 95%;"/> -->
					</td>
					<td>
						<!-- 비고 -->
						<input type="text" id="position_etc_add" name="position_etc" style="width: 95%;"/>
					</td>
					<td>
						<!-- 버튼 -->
						<i class="fas fa-save fa-2x" data-fa-transform="shrink-6" data-fa-mask="fas fa-square" style="cursor:pointer;color:#7777ea;" onclick="fnAppointAdd('position');" ></i>
						<i class="fas fa-undo fa-2x" data-fa-transform="shrink-6" data-fa-mask="fas fa-square" style="cursor:pointer;" onclick="fnAppointAddUndo('position');"></i>
					</td>		
				</tr>
				 
				 
				<c:forEach items="${getMbrPosition}" var="item" varStatus="status">
					<tr id="position_view_${item.position_no}">
						<td style="letter-spacing: 0px;">${item.position_date}</td> <!-- 발령일자 -->
						<td>${item.position_depart}</td>		<!-- 부서 -->
						<td>${item.position_work_level}</td>		<!-- 직위 -->
						<td style="letter-spacing: 0px;">${item.position_work_rank}</td>		<!-- 직급 -->
						<td>${item.position_work_type}</td>		<!-- 직책 -->
						<td>${item.position_place}</td>		<!-- 근무지 -->
						<td>${item.position_comment}</td>	<!-- 발령내용 -->
						<td>${item.position_etc}</td>		<!-- 비고 -->
						<!-- 버튼 -->
						<td>
							<i class="fas fa-pen-square fa-2x" style="cursor:pointer;color:#ffca00;" onclick="fnAppointModView(${item.position_no},'position');"></i>	
							<i class="fas fa-minus-square fa-2x" style="cursor:pointer;color:#dc0000;" onclick="fnAppointDelete(${item.position_no},'position');"></i>	
<!-- 							<input type="image" src="./resources/ls_img/btn_edit_s.gif" style="cursor:pointer;" /> 	수정화면 -->
<%-- 							<input type="image" src="./resources/ls_img/btn_del_s.gif" style="cursor:pointer;" value="${status.index}"/>	<!-- 삭제 --> --%>
						</td>
					</tr>					
						
					<!-- 진급사항 수정 by top3009 -->
					<tr id="position_edit_${item.position_no}" style="display: none;">
						<td style="letter-spacing: 0px;">
						<!-- 발령일자 -->
						<input type="text" id="position_date_mod_${item.position_no}" class="classCalendar" name="position_date" value="${item.position_date}" style="width: 70%;"/>
						</td>
						<td style="text-align: left;">
							<!-- 부서 -->
							<select class="select2" id="position_depart_mod_${item.position_no}" style="width: 100%;">
								<option value="0">선택</option>
								<c:forEach items="${teamList}" var = "teamVo">
									<option value="${teamVo.team_id}" txt="${teamVo.team_name}">
										<c:if test="${teamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
										<c:if test="${teamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
										${teamVo.team_name}
									</option>
								</c:forEach>
							</select>
							<script>
								$("#position_depart_mod_${item.position_no}").val('${item.position_team_id}');
								$("#position_depart_mod_${item.position_no}").trigger('change');
							</script>
						</td>
						
						<td style="text-align: left;">
							<!-- 직위 -->
							<select class="select2" id="position_work_level_mod_${item.position_no}" style="width: 100%;">
								<c:forEach items="${workLevelList}" var = "items">
									<option value="${items.col_cd}">${items.col_val}</option>
								</c:forEach>
							</select>		
							<script>
								$("#position_work_level_mod_${item.position_no}").val('${item.position_work_level_cd}');
								$("#position_work_level_mod_${item.position_no}").trigger('change');
							</script>
						</td>
						
						<td style="text-align: left;">
							<!-- 직급 -->
							<select class="select2" id="position_work_rank_mod_${item.position_no}" style="width:100%;">
								<option value="">선택</option>
								<c:forEach var="items" items="${workRankList}">
									<option value="${items.col_cd}">${items.col_val}</option>
								</c:forEach>
							</select>
							<script>
								$("#position_work_rank_mod_${item.position_no}").val('${item.position_work_rank_cd}');
								$("#position_work_rank_mod_${item.position_no}").trigger('change');
							</script>	
						</td>
						
						<td style="text-align: left;">
							<!-- 직책 -->
							<select class="select2" id="position_work_type_mod_${item.position_no}" style="width:100%;">
								<c:forEach var="items" items="${workTypeList}">
									<option value="${items.col_cd}">${items.col_val}</option>
								</c:forEach>
							</select>
							<script>
								$("#position_work_type_mod_${item.position_no}").val('${item.position_work_type_cd}');
								$("#position_work_type_mod_${item.position_no}").trigger('change');
							</script>	
						</td>
						
						<td style="text-align: left;">
							<!-- 근무지 -->
							<select class="select2" id="position_place_mod_${item.position_no}" name="position_place" style="width: 100%;">
								<option value="본사(서울)">본사(서울)</option>
								<option value="수원">수원</option>
								<option value="인천">인천</option>
								<option value="강원">강원</option>
								<option value="부산">부산</option>
								<option value="대전">대전</option>
								<option value="대구">대구</option>
								<option value="창원">창원</option>
								<option value="순천">순천</option>
								<option value="광주">광주</option>
								<option value="전주">전주</option>
								<option value="제주">제주</option>
							</select>
	<!-- 						<input type="text" id="appoint_place_add" name="appoint_place" style="width: 95%;"/> -->
							<script>
								$("#position_place_mod_${item.position_no}").val('${item.position_place}');
								$("#position_place_mod_${item.position_no}").trigger('change');
							</script>
						</td>
						
						<td style="text-align: left;">
							<!-- 발령내용 -->
							<select class="select2" id="position_comment_mod_${item.position_no}" name="position_comment" style="width: 100%;">
								<option value="신규발령">신규발령</option>
								<option value="보직변경">보직변경</option>
								<option value="인사이동">인사이동</option>
								<option value="직급승급">직급승급</option>
								<option value="직위승진">직위승진</option>
								<option value="면수습">면수습</option>
							</select>
	<!-- 						<input type="text" id="position_comment_add" name="position_comment" style="width: 95%;"/> -->
							<script>
								$("#position_comment_mod_${item.position_no}").val('${item.position_comment}');
								$("#position_comment_mod_${item.position_no}").trigger('change');
							</script>
						</td>
						<td>
							<!-- 비고 -->
							<input type="text" id="position_etc_mod_${item.position_no}" name="position_etc" value="${item.position_etc}" style="width: 95%;"/>
						</td>
						<td>
							<!-- 버튼 -->
							<i class="fas fa-save fa-2x" data-fa-transform="shrink-6" data-fa-mask="fas fa-square" style="cursor:pointer;color:#7777ea;" onclick="fnAppointUdt(${item.position_no},'position')"></i>
							<i class="fas fa-undo fa-2x" data-fa-transform="shrink-6" data-fa-mask="fas fa-square" style="cursor:pointer;" onclick="fnAppointModUndo(${item.position_no},'position');"></i>
						</td>
					</tr>
				</c:forEach>
				
			</thead>
		</table>
		
		<br>

		<!-- 휴복직현황 시작-->
		<table>			
				<tr>
					<th colspan="9">
						휴직사항
						<i class="fas fa-plus-square fa-lg" style="cursor:pointer;color:#0000ce;" onclick="fnAppointAddView('work');"></i>
					</th>
				</tr>
				
				<tr>
					<th>휴직기간</th>
					<th>부서</th>
					<th>직위</th>
					<th>휴직유형</th>
					<th>휴직일수</th>
					<th>소정근로일수</th>
					<th>사유</th>					
					<th>비고</th>
					<th> - </th>
				</tr>

				<tr id="work_add" style="border:2px solid #0000ce; display:none;">
					<td style="letter-spacing: 0px;">
						<!-- 휴직기간 -->
						<input type="text" id="work_sdate_add" class="classCalendar" name="work_sdate" value="" style="width: 30%;"/> ~
						<input type="text" id="work_edate_add" class="classCalendar" name="work_edate" value="" style="width: 30%;"/>
					</td>
					<td style="text-align: left;">
						<!-- 휴직부서 -->
						<select class="select2" id="work_team_id_add" style="width: 100%;">
							<option value="0">선택</option>
							<c:forEach items="${teamList}" var = "teamVo">
								<option value="${teamVo.team_id}" txt="${teamVo.team_name}">
									<c:if test="${teamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
									<c:if test="${teamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
									${teamVo.team_name}
								</option>
							</c:forEach>
						</select>							
					</td>
					
					<td style="text-align: left;">
						<!-- 휴직직위 -->
						<select class="select2" id="work_level_add" style="width: 100%;">
							<c:forEach items="${workLevelList}" var = "item">
								<option value="${item.col_cd}">${item.col_val}</option>
							</c:forEach>
						</select>		
						
					</td>
					
					<td style="text-align: left;">
						<!-- 휴직유형 -->
						<select class="select2" id="leave_type_add" style="width:100%;">
							<option value="">선택</option>
							<c:forEach var="item" items="${workList}">
								<option value="${item.leave_code}">${item.leave_type}</option>
							</c:forEach>
						</select>	
					</td>
					
					<td style="text-align: center;">기간에 따라 계산됩니다.</td>
					<td style="text-align: center;">기간에 따라 계산됩니다.</td>
					
					<td style="text-align: center;">
						<!-- 휴직사유 -->
						<input type="text" id="work_comment_add" name="work_comment" style="width: 95%;"/>
					</td>
					<td>
						<!-- 비고 -->
						<input type="text" id="work_etc_add" name="work_etc" style="width: 95%;"/>
					</td>
					<td>
						<!-- 버튼 -->
						<i class="fas fa-save fa-2x" data-fa-transform="shrink-6" data-fa-mask="fas fa-square" style="cursor:pointer;color:#7777ea;" onclick="fnAppointAdd('work');" ></i>
						<i class="fas fa-undo fa-2x" data-fa-transform="shrink-6" data-fa-mask="fas fa-square" style="cursor:pointer;" onclick="fnAppointAddUndo('work');"></i>
					</td>		
				</tr>
				 
				<c:forEach items="${getMbrWork}" var="item" varStatus="status">
					<tr id="work_view_${item.work_no}">
						<td style="letter-spacing: 0px;">
						${item.work_sdate_fmt} ~
						<c:choose>
							<c:when test="${empty item.work_edate_fmt}">오늘까지</c:when>
							<c:otherwise>${item.work_edate_fmt}</c:otherwise>
						</c:choose>
						</td> 
						<!-- 휴복직 일자 -->
						<td>${item.work_team_id_val}</td>		<!-- 부서 -->
						<td>${item.work_level_val}</td>		<!-- 직위 -->
						<td>${item.leave_type_val}</td>		<!-- 휴직유형 -->
						<td>${item.leave_interval} 일</td>		<!-- 휴직일수 -->
						<td>${item.work_interval} 일</td>		<!-- 휴직일수 -->
						<td>${item.work_comment}</td>		<!-- 사유 -->						
						<td>${item.work_etc}</td>		<!-- 비고 -->
						<!-- 버튼 -->
						<td>
							<i class="fas fa-pen-square fa-2x" style="cursor:pointer;color:#ffca00;" onclick="fnAppointModView(${item.work_no},'work');"></i>	
							<i class="fas fa-minus-square fa-2x" style="cursor:pointer;color:#dc0000;" onclick="fnAppointDelete(${item.work_no},'work');"></i>
						</td>
					</tr>
					
					<tr id="work_edit_${item.work_no}" style="display: none;">
						<td style="letter-spacing: 0px;">
							<!-- 휴복직일자 -->
							<input type="text" id="work_sdate_mod_${item.work_no}" class="classCalendar" name="work_sdate" value="${item.work_sdate_fmt}" style="width: 40%;"/> ~ 
							<input type="text" id="work_edate_mod_${item.work_no}" class="classCalendar" name="work_edate" value="${item.work_edate_fmt}" style="width: 40%;"/>
						</td>
						<td style="text-align: left;">
							<!-- 휴직부서 -->
							<select class="select2" id="work_team_id_mod_${item.work_no}" style="width: 100%;">
								<option value="0">선택</option>
								<c:forEach items="${teamList}" var = "teamVo">
									<option value="${teamVo.team_id}" txt="${teamVo.team_name}">
										<c:if test="${teamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
										<c:if test="${teamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
										${teamVo.team_name}
									</option>
								</c:forEach>
							</select>
							<script>
								$("#work_team_id_mod_${item.work_no}").val('${item.work_team_id}');
								$("#work_team_id_mod_${item.work_no}").trigger('change');
							</script>
						</td>
						
						<td style="text-align: left;">												
							<!-- 휴직직위 -->
							<select class="select2" id="work_level_mod_${item.work_no}" style="width: 100%;">
								<c:forEach items="${workLevelList}" var = "levelVo">
									<option value="${levelVo.col_cd}">${levelVo.col_val}</option>
								</c:forEach>
							</select>
							<script>						
								$("#work_level_mod_${item.work_no}").val('${item.work_level}');
								$("#work_level_mod_${item.work_no}").trigger('change');
							</script>
						</td>
						
						<td style="text-align: left;">
							<!-- 휴직유형 -->							
							<select class="select2" id="leave_type_mod_${item.work_no}" style="width:100%;">
								<option value="">선택</option>
								<c:forEach items="${workList}" var="levelTypeVo">
									<option value="${levelTypeVo.leave_code}">${levelTypeVo.leave_type}</option>
								</c:forEach>
							</select>
							<script>						
								$("#leave_type_mod_${item.work_no}").val('${item.leave_type}');
								$("#leave_type_mod_${item.work_no}").trigger('change');
							</script>	
						</td>
						
						<td style="text-align: center;">
							<!-- 휴직일수 -->
							기간에 따라 계산됩니다.							
						</td>
						<td style="text-align: center;">
							<!-- 휴직일수 -->
							기간에 따라 계산됩니다.							
						</td>
						
						<td style="text-align: center;">
							<!-- 휴직사유 -->
							<input type="text" id="work_comment_mod_${item.work_no}" name="work_comment" style="width: 95%;" value="${item.work_comment}"/>
						</td>
						
						<td>
							<!-- 비고 -->
							<input type="text" id="work_etc_mod_${item.work_no}" name="work_etc" style="width: 95%;" value="${item.work_etc}"/> 
						</td>
						<td>
							<!-- 버튼 -->							
							<i class="fas fa-save fa-2x" data-fa-transform="shrink-6" data-fa-mask="fas fa-square" style="cursor:pointer;color:#7777ea;" onclick="fnAppointUdt(${item.work_no},'work')"></i>
							<i class="fas fa-undo fa-2x" data-fa-transform="shrink-6" data-fa-mask="fas fa-square" style="cursor:pointer;" onclick="fnAppointModUndo(${item.work_no},'work');"></i>
						</td>
					</tr>	
				</c:forEach>
			
		</table>
		<br/>
		<!-- 휴복직현황 끝 -->
		
		<!-- 육아근로기간단축 설정 시작 -->
		<table>	
			<colgroup>
					<col width="20%">
					<col width="15%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="15%">
					<col width="10%">
					<col width="10%">
			</colgroup>		
				<tr>
					<th colspan="8">
						육아근로기간단축
						<i class="fas fa-plus-square fa-lg" style="cursor:pointer;color:#0000ce;" onclick="fnCareAddView('care');"></i>
					</th>
				</tr>
				
				<tr>
					<th>단축기간</th>
					<th>부서</th>
					<th>직위</th>					
					<th>일일근무시간</th>
					<th>단축근로일수</th>
					<th>사유</th>					
					<th>비고</th>
					<th> - </th>
				</tr>

				<tr id="care_add" style="border:2px solid #0000ce; display:none;">
					<td style="letter-spacing: 0px;">
						<!-- 단축기간 -->
						<input type="text" id="care_sdate_add" class="classCalendar" name="care_sdate" value="" style="width: 35%;"/> ~
						<input type="text" id="care_edate_add" class="classCalendar" name="care_edate" value="" style="width: 35%;"/>
					</td>
					<td style="text-align: left;">
						<!-- 휴직부서 -->
						<select class="select2" id="care_team_id_add" style="width: 100%;">
							<option value="0">선택</option>
							<c:forEach items="${teamList}" var = "teamVo">
								<option value="${teamVo.team_id}" txt="${teamVo.team_name}">
									<c:if test="${teamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
									<c:if test="${teamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
									${teamVo.team_name}
								</option>
							</c:forEach>
						</select>							
					</td>
					
					<td style="text-align: left;">
						<!-- 휴직직위 -->
						<select class="select2" id="care_level_add" style="width: 100%;">
							<c:forEach items="${workLevelList}" var = "item">
								<option value="${item.col_cd}">${item.col_val}</option>
							</c:forEach>
						</select>		
						
					</td>
					
					<td style="text-align: center;">
						<input type="number" id="care_worktime_add" name="care_worktime" min="4" max="7" step="1" value="0" style="width: 50%;"/> / 8시간
					</td>
					<td style="text-align: center;">기간에 따라 계산됩니다.</td>						
					<td style="text-align: center;">
						<!-- 휴직사유 -->
						<input type="text" id="care_comment_add" name="care_comment" style="width: 95%;"/>
					</td>
					<td>
						<!-- 비고 -->
						<input type="text" id="care_etc_add" name="care_etc" style="width: 95%;"/>
					</td>
					<td>
						<!-- 버튼 -->
						<i class="fas fa-save fa-2x" data-fa-transform="shrink-6" data-fa-mask="fas fa-square" style="cursor:pointer;color:#7777ea;" onclick="fnAppointAdd('care');" ></i>
						<i class="fas fa-undo fa-2x" data-fa-transform="shrink-6" data-fa-mask="fas fa-square" style="cursor:pointer;" onclick="fnAppointAddUndo('care');"></i>
					</td>		
				</tr>
				 
				<c:forEach items="${getMbrCare}" var="item" varStatus="status">
					<tr id="care_view_${item.care_no}">
						<td style="letter-spacing: 0px;">
						${item.care_sdate_fmt} ~
						<c:choose>
							<c:when test="${empty item.care_edate_fmt}">오늘까지</c:when>
							<c:otherwise>${item.care_edate_fmt}</c:otherwise>
						</c:choose>
						</td>
						<td>${item.care_team_id_val}</td>		<!-- 부서 -->
						<td>${item.care_level_val}</td>		<!-- 직위 -->						
						<td>${item.care_worktime} 시간</td>		<!-- 일일근무시간 -->
						<td>${item.care_work_interval} 일</td>		<!-- 단축근로일수 -->
						<td>${item.care_comment}</td>		<!-- 사유 -->						
						<td>${item.care_etc}</td>		<!-- 비고 -->
						<!-- 버튼 -->
						<td>
							<i class="fas fa-pen-square fa-2x" style="cursor:pointer;color:#ffca00;" onclick="fnCareModView(${item.care_no},'care');"></i>	
							<i class="fas fa-minus-square fa-2x" style="cursor:pointer;color:#dc0000;" onclick="fnAppointDelete(${item.care_no},'care');"></i>
						</td>
					</tr>
					
					<tr id="care_edit_${item.care_no}" style="display: none;">
						<td style="letter-spacing: 0px;">
							<!-- 근로기간단축일자 -->
							<input type="text" id="care_sdate_mod_${item.care_no}" class="classCalendar" name="care_sdate" value="${item.care_sdate_fmt}" style="width: 35%;"/> ~ 
							<input type="text" id="care_edate_mod_${item.care_no}" class="classCalendar" name="care_edate" value="${item.care_edate_fmt}" style="width: 35%;"/>
						</td>
						<td style="text-align: left;">
							<!-- 휴직부서 -->
							<select class="select2" id="care_team_id_mod_${item.care_no}" style="width: 100%;">
								<option value="0">선택</option>
								<c:forEach items="${teamList}" var = "teamVo">
									<option value="${teamVo.team_id}" txt="${teamVo.team_name}">
										<c:if test="${teamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
										<c:if test="${teamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
										${teamVo.team_name}
									</option>
								</c:forEach>
							</select>
							<script>
								$("#care_team_id_mod_${item.care_no}").val('${item.care_team_id}');
								$("#care_team_id_mod_${item.care_no}").trigger('change');
							</script>
						</td>
						
						<td style="text-align: left;">												
							<!-- 휴직직위 -->
							<select class="select2" id="care_level_mod_${item.care_no}" style="width: 100%;">
								<c:forEach items="${workLevelList}" var = "levelVo">
									<option value="${levelVo.col_cd}">${levelVo.col_val}</option>
								</c:forEach>
							</select>
							<script>						
								$("#care_level_mod_${item.care_no}").val('${item.care_level}');
								$("#care_level_mod_${item.care_no}").trigger('change');
							</script>
						</td>
						
						<td style="text-align: center;">
							<!-- 일일근무시간 -->							
							<input type="number" id="care_worktime_mod_${item.care_no}" name="care_worktime" min="1" max="7" step="1" value="${item.care_worktime}" style="width: 50%;"/> / 8시간							
						</td>
						<td style="text-align: center;">
							<!-- 단축근로일수 -->
							기간에 따라 계산됩니다.							
						</td>
						
						<td style="text-align: center;">
							<!-- 휴직사유 -->
							<input type="text" id="care_comment_mod_${item.care_no}" name="care_comment" style="width: 95%;" value="${item.care_comment}"/>
						</td>
						
						<td>
							<!-- 비고 -->
							<input type="text" id="care_etc_mod_${item.care_no}" name="care_etc" style="width: 95%;" value="${item.care_etc}"/> 
						</td>
						<td>
							<!-- 버튼 -->							
							<i class="fas fa-save fa-2x" data-fa-transform="shrink-6" data-fa-mask="fas fa-square" style="cursor:pointer;color:#7777ea;" onclick="fnAppointUdt(${item.care_no},'care')"></i>
							<i class="fas fa-undo fa-2x" data-fa-transform="shrink-6" data-fa-mask="fas fa-square" style="cursor:pointer;" onclick="fnAppointModUndo(${item.care_no},'care');"></i>
						</td>
					</tr>	
				</c:forEach>
			
		</table>
		<br/>
		<!-- 육아근로기간단축 설정 끝 -->
		
		<!-- 상/벌 현황 시작 -->
		<c:if test="${mbrAuthVo_Session.mbr_pms_41 == 1 }">
		<table>
			<colgroup>
					<col width="8%">
					<col width="9%">
					<col width="15%">
					<col width="8%">
					<col width="15%">
					<col width="15%">
					<col width="20%">
					<col width="10%">					
			</colgroup>
			<thead>
			<tr>
				<th colspan="8">
					상/벌사항	
					<i class="fas fa-plus-square fa-lg" style="cursor:pointer;color:#0000ce;" onclick="fnAwardAddView();"></i>
				</th>
			</tr>
			<tr>
				<th>상/벌 유형</th>
				<th>상/벌 일자</th>
				<th>부서</th>
				<th>직위</th>				
				<th>상/벌 내용</th>
				<th>비고</th>
				<th>첨부파일</th>
				<th>-</th>
			</tr>
			<tr id="tr_award_add_form" style="border:2px solid #0000ce; display:none;">
				<td style="text-align: center;">
					<!-- 상벌 -->
					<select class="select2" id="award_flag_add" style="width: 100%;">
						<option value="0">선택</option>
						<option value="1">상</option>
						<option value="2">벌</option>
					</select>
				</td>
				<td style="letter-spacing: 0px;">
					<!-- 상벌일자 -->
					<input type="text" id="award_date_add" name="award_date_add" class="classCalendar" value="" style="width: 70%;"/>
				</td>
				<td style="text-align: left;">
					<!-- 부서 -->
					<select class="select2" id="award_team_id_add" style="width: 100%;">
						<option value="0">선택</option>
						<c:forEach items="${teamList}" var = "teamVo">
							<option value="${teamVo.team_id}" txt="${teamVo.team_name}">
								<c:if test="${teamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
								<c:if test="${teamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
								${teamVo.team_name}
							</option>
						</c:forEach>
					</select>							
				</td>
				<td style="text-align: left;">
					<!-- 직위 -->
					<select class="select2" id="award_work_level_add" style="width: 100%;">
						<c:forEach items="${workLevelList}" var = "item">
							<option value="${item.col_cd}">${item.col_val}</option>
						</c:forEach>
					</select>
				</td>				
				<td>
					<!-- 상/벌내용 -->
					<input type="text" id="award_content_add" name="award_content_add" style="width: 95%;"/>
				</td>
				<td>
					<!-- 비고 -->
					<input type="text" id="award_memo_add" name="award_content_add" style="width: 95%;"/>
				</td>
				<td>
					<input type="file" id="award_file_add" name="award_file_add" style="width:95%;"/>
				</td>
				<td>
					<!-- 버튼 -->
					<i class="fas fa-save fa-2x" data-fa-transform="shrink-6" data-fa-mask="fas fa-square" style="cursor:pointer;color:#7777ea;" onclick="fnAwardAction('C',0);" ></i>
					<i class="fas fa-undo fa-2x" data-fa-transform="shrink-6" data-fa-mask="fas fa-square" style="cursor:pointer;" onclick="fnAwardAddCancel();"></i>
				</td>
			</tr>
		<c:forEach items="${getAwardList}" var="award" varStatus="status">
			<tr id="award_view_${award.akey}">
				<td>
					<c:if test="${award.award_flag eq 1}">상</c:if>
					<c:if test="${award.award_flag eq 2}">벌</c:if>
				</td>
				<td>${award.award_date_fmt}</td>
				<td>${award.team_name}</td>
				<td>${award.work_level_nm}</td>				
				<td>${award.award_content}</td>
				<td>${award.award_memo}</td>
				<td>
					<c:choose>
						<c:when test="${empty award.award_org_file}"> - </c:when>
						<c:otherwise>
							<a href="/awardFileDown?akey=${award.akey}">${award.award_org_file}&nbsp;</a>							
							<img src="./resources/ls_img/btn_del_s.gif" id="awardFileDel" onclick="fnAwardAction('FD',${award.akey});" style='cursor:pointer;' />
						</c:otherwise>
					</c:choose>
				</td>				
				<!-- 버튼 -->
				<td>
					<i class="fas fa-pen-square fa-2x" style="cursor:pointer;color:#ffca00;" onclick="fnAwardModView('${award.akey}');"></i>	
					<i class="fas fa-minus-square fa-2x" style="cursor:pointer;color:#dc0000;" onclick="fnAwardAction('D','${award.akey}');"></i>
				</td>
			</tr>
			<tr id="award_edit_${award.akey}" style="display:none;">
				<td style="text-align: center;">
					<!-- 상벌 -->
					<select class="select2" id="award_flag_mod_${award.akey}" style="width: 100%;">
						<option value="0">선택</option>
						<option value="1">상</option>
						<option value="2">벌</option>
					</select>
					<script>
						$("#award_flag_mod_${award.akey}").val('${award.award_flag}');
						$("#award_flag_mod_${award.akey}").trigger('change');
					</script>
				</td>
				<td style="letter-spacing: 0px;">
					<!-- 상벌일자 -->
					<input type="text" id="award_date_mod_${award.akey}" value="${award.award_date_fmt}" class="classCalendar" value="" style="width: 70%;"/>
				</td>
				<td style="text-align: left;">
					<!-- 부서 -->
					<select class="select2" id="award_team_id_mod_${award.akey}" style="width: 100%;">
						<option value="0">선택</option>
						<c:forEach items="${teamList}" var = "teamVo">
							<option value="${teamVo.team_id}" txt="${teamVo.team_name}">
								<c:if test="${teamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
								<c:if test="${teamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
								${teamVo.team_name}
							</option>
						</c:forEach>
					</select>
					<script>
						$("#award_team_id_mod_${award.akey}").val('${award.team_id}');
						$("#award_team_id_mod_${award.akey}").trigger('change');
					</script>
				</td>
				<td style="text-align: left;">
					<!-- 직위 -->
					<select class="select2" id="award_work_level_mod_${award.akey}" style="width: 100%;">
						<c:forEach items="${workLevelList}" var = "item">
							<option value="${item.col_cd}">${item.col_val}</option>
						</c:forEach>
					</select>
					<script>
						$("#award_work_level_mod_${award.akey}").val('${award.work_level}');
						$("#award_work_level_mod_${award.akey}").trigger('change');
					</script>
				</td>				
				<td>
					<!-- 상/벌내용 -->
					<input type="text" id="award_content_mod_${award.akey}" value="${award.award_content}" style="width: 95%;"/>
				</td>
				<td>
					<!-- 비고 -->
					<input type="text" id="award_memo_mod_${award.akey}" value="${award.award_memo}" style="width: 95%;"/>
				</td>
				<td>
					<!-- 첨부파일 -->
					<c:choose>
						<c:when test="${empty award.award_org_file}">
							<input type="file" id="award_file_mod_${award.akey}" value="${award.award_org_file}" style="width: 95%;"/>
						</c:when>						
						<c:otherwise>
							<input type="hidden" id="award_file_mod_${award.akey}" value="" style="width: 95%;"/>
							<a href="/awardFileDown?akey=${award.akey}">${award.award_org_file}</a>
							&nbsp;
							<img src="./resources/ls_img/btn_del_s.gif" id="awardFileDel" onclick="fnAwardAction('FD',${award.akey});" style='cursor:pointer;' />
						</c:otherwise>
					</c:choose>					
				</td>
				<td>
					<!-- 버튼 -->
					<i class="fas fa-save fa-2x" data-fa-transform="shrink-6" data-fa-mask="fas fa-square" style="cursor:pointer;color:#7777ea;" onclick="fnAwardAction('U','${award.akey}');" ></i>
					<i class="fas fa-undo fa-2x" data-fa-transform="shrink-6" data-fa-mask="fas fa-square" style="cursor:pointer;" onclick="fnAwardModCancel('${award.akey}');"></i>
				</td>				
			</tr>
		</c:forEach>
		</thead>
		</table>
		<!-- 상/벌 현황 끝 -->
		</c:if>		
	</div>
