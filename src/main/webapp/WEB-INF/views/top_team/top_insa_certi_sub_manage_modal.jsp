<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="./resources/select2/select2.min.css" rel="stylesheet" />
<script src="./resources/select2/select2.min.js"></script>
<script src="./resources/jquery/jquery.mask.min.js"></script>
<style>
	.tableStyle2 td{
		letter-spacing : 0px;
	}
	.select2-container--default{
		text-align : left;
		font-color:#444;
		font-size:12px;
	}
	.buttonAssistanceEmail{
		width:80px;
		height:40px;
	    background-color:darkCyan;
	    color:#FFFFFF;
	    text-align: center;
		border-radius:5px;
	    font-size: 15px;
	    font-weight: bold;
	    cursor: pointer;
	    text-decoration:none;
	    border: none;
	}	
</style>
<div id="certi-manager-dialog" title="보조인 등록정보 관리" style="font-size: 12px;" align="center">
	<div style="text-align:left;padding: 5px 0 10px 10px">
		<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">&nbsp;
		<b>${memberVo.team_name} ${memberVo.user_name}</b>
	</div>
	<div class="tableStyle2" style="width: 460px;">
	<form id="addCertiManageForm" name="addCertiManageForm" method="post">
		<input type="hidden" id="addUserNo" name="addUserNo" value="${memberVo.user_no}"/>
		<table class="vacation-ins-table">			
			<tr>								
				<th width="30%">등록보종</th>				
				<th width="40%">등록번호</th>				
				<td width="30%" rowspan="2">
					<input type="button" value="추 가" class="buttonAssistanceEmail" id="btn-search" onclick="doAddCertiSubInfo();">
				</td>				
			</tr>
			<tr>			
				<td>
					<select id="addCertiSubType" name="addCertiSubType" style="width:100px;">
						<option value="">- 선택 -</option>
						<c:forEach items="${srchCertiSubTypeList}" var="cTypeVo">							
							<option value="${cTypeVo.certi_type}">${cTypeVo.certi_type_nm}</option>	
						</c:forEach>
					</select>
				</td>				
				<td>
					<input type="text" style="width:140px;" id="addCertiSubNumber" name="addCertiSubNumber">
				</td>								
			</tr>
		</table>
	</form>
		<br/>
		<div id="certSubManagerList"></div>
	</div>	
</div>
<script type="text/javascript">
$(document).ready(function () {	
	getCertiSubListAjax();
});

//보조인 정보 추가
function doAddCertiSubInfo(){
	var userNoVal = $("#addUserNo").val();
	var certiTypeVal = $("#addCertiSubType").val();
	var certiNumberVal = $("#addCertiSubNumber").val();
	
	if( certiTypeVal == '' ){
		alert("등록보종을 선택해주세요.");
		$("#addCertiSubType").focus();
		return;
	}
	
	if( certiNumberVal == '' ){
		alert("등록번호를 입력해주세요.");
		$("#addCertiSubNumber").focus();
		return;
	}
	
	var param = {};
	
	param.user_no = userNoVal;
	param.certi_type = certiTypeVal;
	param.certi_number = certiNumberVal;	
	param.certi_class = "1";				//보조인 정보	
	param.action_flag = "Add";
	
	$.ajax({
		type : "post",
		data : param,		
		url : "actionCertiSubManageData",
		success : function(result){
			
			if( result == 9 ){
				alert("이미 존재하는 등록번호입니다.");				
			}else if( result == 1 ){			//추가 성공
				alert("보조인 정보를 추가하였습니다.");
				//추가 폼 초기화
				$("#addCertiSubType").val(0).trigger('change');
				$("#addCertiSubNumber").val('');				
				
				//목록 새로고침
				getCertiSubListAjax();				
			}else{
				alert("보조인 정보 추가에 실패하였습니다.");	
			}
			
		},
		error: function (request, status, error) {			
			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
		}
		
	});
}

//보조인 정보 삭제
function doInfoSubDeleteModal( p_ckey, p_certi_number ){
	
	if(!confirm( "등록번호 ["+p_certi_number +"] 를 삭제하시겠습니까?" )){
		return;
	}
	
	var userNoVal = $("#addUserNo").val();
	
	var param = {};
	param.user_no = userNoVal;
	param.ckey = p_ckey;
	param.action_flag = "Del";
	
	$.ajax({
		type : "post",
		data : param,		
		url : "actionCertiSubManageData",
		success : function(result){
			
			if( result == 1 ){			//삭제성공
				alert("보조인 정보를 삭제하였습니다.");
				//목록 새로고침
				getCertiSubListAjax();				
			}else{
				alert("보조인 정보 삭제에 실패하였습니다.");	
			}
			
		},
		error: function (request, status, error) {			
			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
		}
		
	});
	
}

//보조인 정보 수정하기
function doInfoSubModify( p_ckey ){		
	$("#tr_certi_view_"+p_ckey).hide();
	$("#tr_certi_edit_"+p_ckey).show();	
}

//보조인 수정 취소하기
function doInfoSubEditCancel( p_ckey ){
	$("#tr_certi_edit_"+p_ckey).hide();
	$("#tr_certi_view_"+p_ckey).show();
}

//보조인 정보 수정내역 저장하기
function doInfoSubEditSave( p_ckey ){
	
	var certiTypeVal = $("#editCertiType_"+p_ckey).val();
	var certiNumberVal = $("#editCertiNumber_"+p_ckey).val();
	
	if( certiTypeVal == '' ){
		alert("등록보종을 선택해주세요.");
		$("#editCertiType_"+p_ckey).focus();
		return;
	}
	
	if( certiNumberVal == '' ){
		alert("등록번호를 입력해주세요.");
		$("#editCertiNumber_"+p_ckey).focus();
		return;
	}
	
	var userNoVal = $("#addUserNo").val();
	
	var param = {};
	
	param.ckey = p_ckey;
	param.user_no = userNoVal;
	param.certi_type = certiTypeVal;
	param.certi_number = certiNumberVal;	
	param.action_flag = "Update";
	
	$.ajax({
		type : "post",
		data : param,
		url : "actionCertiSubManageData",
		success : function(result){
			
			if( result == 9 ){
				alert("이미 존재하는 등록번호입니다.");				
			}else if( result == 1 ){			//수정 성공
				alert("보조인 정보를 수정하였습니다.");
				//목록 새로고침
				getCertiSubListAjax();
			}else{
				alert("보조인 정보 수정에 실패하였습니다.");	
			}
			
		},
		error: function (request, status, error) {			
			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
		}
		
	});
	
}

//보조인 정보 불러오기
function getCertiSubListAjax(){
	
	var param = {};
	
	param.user_no = ${memberVo.user_no};	
	
	$.ajax({		
		type : "post",
		url : "topCertiSubManagerListAjax",
		data : param,
		success : function(result){					
			$("#certSubManagerList").html(result);				
		},
		error: function (request, status, error) {			
			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
		}
	});
	
}
</script>