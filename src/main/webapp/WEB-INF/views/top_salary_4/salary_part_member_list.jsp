<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
<script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->
<script src="./resources/ne_js/ne_number.js"></script>
<style>
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
			background: #e1e1e1;
		}
		
		.btn-vacation-detail {
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
			background: #CEE3F6;
		}

		.btn-vacation-aprv:active {
			position:relative;
			top:4px
		}
		
		/* 모달 버튼 */
		.ui-button-text-only {
			height:2.1em !important;
		}
		
		.buttonMini{
			width:40px;
			height:20px;
		    background-color:#CEE3F6;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 10px;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 1px grey;		    
		}
</style>
<script>
	$(document).ready(function () {		
		//폼에서 엔터 입력방지
		$('input[type="text"]').keydown(function() {
		    if (event.keyCode === 13) {
		        event.preventDefault();
		    }
		});
		
		//페이지 로딩 후 검색
		$("#srchPartUserState").select2();
		$("#srchPartTeamId").select2();
		$("#srchPartState").select2();
		doPartMemberSearch();
	});
	
	function doPartMemberSearch(){
		var formData = $("#searchPartMemberFrm").serialize();
		
		$.ajax({
			type : "post",
			url : "salaryPartMemberListAjax",
			data : formData,
			success : function(result){			
				//날짜수정 페이지를 가져온다.				
				$("#salaryPartMemberList").html(result);	 				
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});		
	}
	
	//보험사 선택 변경 시	직무 수정
	function doPartInsuChange( p_user_no ){		
		
		var insu_key_name = $("#sel_part_insu_"+p_user_no).val();		
		
		var param = {};
		param.ikey = insu_key_name;
		
		var sUrl = "getSalaryPartList";
		
		$.ajax({
	        type: "POST",
	        url: sUrl,
	        data: param,		         
	        dataType: "JSON", 
	        success: function(data,status){	        	
	        	console.log("msg = "+JSON.stringify(data));
	        	$("#sel_part_"+p_user_no).empty();
	        	if(data.length == 0){
	        		$("#sel_part_"+p_user_no).append(
						"<option value='0'>"
							+"직무 없음"
						+"</option>"
					);
	        	}else{
	        		
	        		$.each(data, function(index, entry) {
                    	
	        			$("#sel_part_"+p_user_no).append(
	    						"<option value='"+entry.pkey+"'>"
	    							+entry.part_name
	    						+"</option>"
						);
                		
					});//each
	        	}
	        },	        
	        error: function(e){
	            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	        }
	        
		});		
		
	}
	
	//직원 직무 수정
	function doMemberPartMod( p_user_no ){		
		$("#sel_part_insu_"+p_user_no).select2();
		$("#sel_part_"+p_user_no).select2();
		
		$("#part_member_view_"+p_user_no).hide();
		$("#part_member_edit_"+p_user_no).show();
	}	
	
	function doMemberPartCancel( p_user_no ){
		$("#part_member_edit_"+p_user_no).hide();
		$("#part_member_view_"+p_user_no).show();		
	}
	
	function doMemberPartSave( p_user_no ){		
		var s_user_no_val = p_user_no;
		var salary_4_insu_val = $("#sel_part_insu_"+p_user_no).val();
		var salary_4_part_val = $("#sel_part_"+p_user_no).val();		
		
		if( salary_4_insu_val == 0 ){
			alert("직원의 보험사를 설정해주세요.");
			$("#sel_part_insu_"+p_user_no).focus();
			return;
		}
		
		if( salary_4_part_val == 0 ){
			alert("직원의 직무를 설정해주세요.");
			$("#sel_part_"+p_user_no).focus();
			return;
		}
		
		var sUrl = "updateTopMbrSalary4Part";
		
		var param = {};
		
		param.user_no = s_user_no_val;
		param.salary_4_insu = salary_4_insu_val;
		param.salary_4_part = salary_4_part_val;		
		
		$.ajax({
	        type: "POST",
	        url: sUrl,
	        data: param,		         
	        dataType: "JSON", 
	        success: function(data){
	        	
	        	if( data.result == 'Success' ){
	        		alert('직원의 직무를 설정하였습니다.');	        		
	        		doPartMemberSearch();	        			        		
	        	}else if( data.result == 'Empty' ){
	        		alert('해당 보험사에 존재하지 않는 직무가 선택되었습니다.\n보험사 부터 다시 선택 후 저장해주세요.');	        		
	        	}
	        	
	        },	        
	        error: function(e){
	            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	        }
	        
		});
		
	}
</script>

<!-- 검색창 추가시 사용 -->
<form id="searchPartMemberFrm" name="searchPartMemberFrm" method="post">
<div class="tableStyle99">
	<table>											
		<tr>			
			<th width="8%">
				부서
			</th>
			<td width="17%" style="text-align:center;">	
				<select id="srchPartTeamId" name="srchPartTeamId" style="width: 195px;">
					<option value="0">- 전체 -</option>
					<c:forEach items="${teamList}" var="teamVo">
						<c:choose>
							<c:when test="${srchPartTeamId == teamVo.team_id}">
								<option value="${teamVo.team_id}" selected="selected">
							</c:when>
							<c:otherwise>
								<option value="${teamVo.team_id}">
							</c:otherwise>
						</c:choose>																
							<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
							<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
							${teamVo.team_name}																
					</c:forEach>
				</select>					
			</td>
			<th width="8%">
				이름
			</th>			
			<td width="17%" style="text-align:left;padding-left:10px;">
				<input type="text" style="width: 190px;" id="srchPartUserName" name="srchPartUserName" value="${srchParam.srchPartUserName }"/>
			</td>
			<th width="8%">
				재직상태
			</th>
			<td width="12%" style="text-align:center;">
				<select id="srchPartUserState" name="srchPartUserState" style="width: 140px;">																											
					<option value="99" <c:if test="${srchParam.srchPartUserState eq '99'}">selected</c:if> >- 전체 -</option>
					<option value="0" <c:if test="${srchParam.srchPartUserState eq '0'}">selected</c:if>>근무자</option>
					<option value="2" <c:if test="${srchParam.srchPartUserState eq '2'}">selected</c:if>>대기자</option>
					<option value="1"<c:if test="${srchParam.srchPartUserState eq '1'}">selected</c:if>>퇴사자</option>
					<option value="9" <c:if test="${srchParam.srchPartUserState eq '9'}">selected</c:if>>SA</option>													
				</select>						
			</td>
			<th width="8%">
				성과급 설정
			</th>
			<td width="12%" style="text-align:center;">
				<select id="srchPartState" name="srchPartState" style="width: 140px;">																											
					<option value="99" <c:if test="${srchParam.srchPartState eq '99'}">selected</c:if> >- 전체 -</option>
					<option value="0" <c:if test="${srchParam.srchPartState eq '0'}">selected</c:if>>설정</option>					
					<option value="1"<c:if test="${srchParam.srchPartState eq '1'}">selected</c:if>>미설정</option>																	
				</select>						
			</td>
			<td align="center" width="10%">
				<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick='doPartMemberSearch();'>검색</a>
			</td>
		</tr>
	</table>
</div>	
</form>
<br/>
<!-- 성과급 직무 설정 시작 -->
<div class="tableStyle99">
	<table>
		<tr>
			<th rowspan="2" width="5%">No</th>
			<th rowspan="2" width="15%">센터명</th>
			<th rowspan="2" width="15%">팀명</th>
			<th rowspan="2" width="6%">직급</th>
			<th rowspan="2" width="12%">이름</th>
			<th rowspan="2" width="10%">입사일자</th>
			<th colspan="2" width="30%">성과급 설정</th>			
			<th rowspan="2" width="12%">-</th>
		</tr>
		<tr>
			<th>보험사</th>
			<th>직무</th>
		</tr>
	</table>
	<div id="salaryPartMemberList"></div>
</div>	
<!-- 성과급 직무 설정 끝 -->