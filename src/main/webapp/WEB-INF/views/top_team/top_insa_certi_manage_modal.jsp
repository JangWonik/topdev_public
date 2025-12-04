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
<div id="certi-manager-dialog" title="손해사정사 자격관리" style="font-size: 12px;" align="center">
	<br/>
	<div class="tableStyle2" style="width: 860px;">
	<form id="addCertiManageForm" name="addCertiManageForm" method="post">
		<table class="vacation-ins-table">
			<tr>
				<th width="20%">이름</th>
				<!-- <th width="20%">등록보종</th> -->
				<th width="15%">등록보종</th>
				<!-- <th width="23%">등록번호</th> -->
				<th width="18%">등록번호</th>
				<th width="15%">등록일자</th>
				<th width="20%">지점연락처</th>
				<td width="12%" rowspan="2">
					<input type="button" value="추 가" class="buttonAssistanceEmail" id="btn-search" onclick="doAddCertiInfo();">
				</td>				
			</tr>
			<tr>				
				<td>					
					<select id="addUserNo" name="addUserNo" style="width:150px;">
						<option value="0">- 선택 -</option>
						<c:forEach items="${srchUserNoList}" var="userVo">							
							<option value="${userVo.user_no}">${userVo.user_name}</option>	
						</c:forEach>
					</select>
				</td>				
				<td>
					<select id="addCertiType" name="addCertiType" style="width:100px;">
						<option value="">- 선택 -</option>
						<c:forEach items="${srchCertiTypeList}" var="cTypeVo">							
							<option value="${cTypeVo.certi_type}">${cTypeVo.certi_type_nm}</option>	
						</c:forEach>
					</select>
				</td>				
				<td>
					<input type="text" style="width:140px;" id="addCertiNumber" name="addCertiNumber">
				</td>
				<td>
					<input type="text" style="width:80px;" id="addCertiDate" name="addCertidate" class="calendar" maxlength="10">
				</td>
				<td>
					<input type="text" id="addCertiPhone1" name="addCertiPhone1" style="width:30px;" maxlength="3"> - 
					<input type="text" id="addCertiPhone2" name="addCertiPhone2" style="width:40px;" maxlength="4"> - 
					<input type="text" id="addCertiPhone3" name="addCertiPhone3" style="width:40px;" maxlength="4">
				</td>				
			</tr>
		</table>
	</form>
		<br/>
		<div id="certiManagerList"></div>
	</div>
	<!-- 손해사정사 삭제 모달창 시작 -->
	<div id="certi-delete-dialog" title="담당 손해사정사 별 보조인현황 관리" style="font-size: 15px;display:none;" align="center"></div>		
	<!-- 손해사정사 삭제 모달창 끝 -->
</div>
<script type="text/javascript">
$(document).ready(function () {
	$("#addUserNo").select2({
		dropdownParent: $("#certi-manager-dialog")
	});
	
	$("#addCertiType").select2({
		dropdownParent: $("#certi-manager-dialog")
	});
	
	$("#addUserNo").val(${srchParam.user_no}).trigger('change');
	
	getManagerListAjax();
	
	_initCalendar();
	_initMask();
	
});

function _initMask(){
    var options = {
        onKeyPress : function(cep, event, currentField, options){
            var tid = event.currentTarget.id;
            var tidx = tid.substr(tid.length - 1, 1);                
        },
        reverse : true
    };
    
    $('input.calendar').mask('0000-00-00',options);
    
}

function _initCalendar(){    	 
	$('.calendar').datepicker({
		showOn: 'button',
		buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		buttonImageOnly: true,
		buttonText: "달력", 
		changeMonth: true,
		changeYear: true,	    	   
		showButtonPanel: false,
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		dateFormat: 'yy-mm-dd',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: true
    }); 		
	
}

//손해사정사 추가하기
function doAddCertiInfo(){
	
	var userNoVal = $("#addUserNo").val();
	var certiTypeVal = $("#addCertiType").val();
	var certiNumberVal = $("#addCertiNumber").val();
	
	var certiPhoneVal1 = $("#addCertiPhone1").val();
	var certiPhoneVal2 = $("#addCertiPhone2").val();
	var certiPhoneVal3 = $("#addCertiPhone3").val();	
	
	var certiPhoneVal;
	
	var certiDateVal = $("#addCertiDate").val();
	
	if( certiPhoneVal1 == '' && certiPhoneVal2 == '' && certiPhoneVal3 == '' ){
		certiPhoneVal = "";
	}else{
		certiPhoneVal = certiPhoneVal1+"-"+certiPhoneVal2+"-"+certiPhoneVal3;
	}
		
	if( userNoVal == 0 ){
		alert("이름을 선택해주세요.");
		$("#addUserNo").focus();
		return;
	}
	
	if( certiTypeVal == '' ){
		alert("등록보종을 선택해주세요.");
		$("#addCertiType").focus();
		return;
	}
	
	if( certiNumberVal == '' ){
		alert("등록번호를 입력해주세요.");
		$("#addCertiNumber").focus();
		return;
	}
	
	var param = {};
	
	param.user_no = userNoVal;
	param.certi_type = certiTypeVal;
	param.certi_number = certiNumberVal;
	param.work_phone = certiPhoneVal;
	param.certi_class = "2";			//손해사정사로 고정
	param.certi_date = certiDateVal;
	param.action_flag = "Add";
	
	$.ajax({
		type : "post",
		data : param,		
		url : "actionCertiManageData",
		success : function(result){
			
			if( result == 9 ){
				alert("이미 존재하는 등록번호입니다.");				
			}else if( result == 1 ){			//추가 성공
				alert("손해사정사 정보를 추가하였습니다.");
				//추가 폼 초기화
				$("#addCertiType").val(0).trigger('change');
				$("#addCertiNumber").val('');
				$("#addCertiPhone1").val('');
				$("#addCertiPhone2").val('');
				$("#addCertiPhone3").val('');
				$("#addCertiDate").val('');
				
				//목록 새로고침
				getManagerListAjax();				
			}else{
				alert("손해사정사 정보 추가에 실패하였습니다.");	
			}
			
		},
		error: function (request, status, error) {			
			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
		}
		
	});
	
}

//손해사정사 정보 수정내역 저장하기
function doInfoEditSave( p_ckey ){
	
	var certiTypeVal = $("#editCertiType_"+p_ckey).val();
	var certiNumberVal = $("#editCertiNumber_"+p_ckey).val();
	var certiPhoneVal1 = $("#editCertiPhone1_"+p_ckey).val();
	var certiPhoneVal2 = $("#editCertiPhone2_"+p_ckey).val();
	var certiPhoneVal3 = $("#editCertiPhone3_"+p_ckey).val();	
	
	var certiPhoneVal;
	
	var certiDateVal = $("#editCertiDate_"+p_ckey).val();
	
	if( certiPhoneVal1 == '' && certiPhoneVal2 == '' && certiPhoneVal3 == '' ){
		certiPhoneVal = "";
	}else{
		certiPhoneVal = certiPhoneVal1+"-"+certiPhoneVal2+"-"+certiPhoneVal3;
	}	
	
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
	
	var param = {};
	
	param.ckey = p_ckey;
	param.certi_type = certiTypeVal;
	param.certi_number = certiNumberVal;
	param.work_phone = certiPhoneVal;
	param.certi_date = certiDateVal;
	param.action_flag = "Update";
	
	$.ajax({
		type : "post",
		data : param,
		url : "actionCertiManageData",
		success : function(result){
			
			if( result == 9 ){
				alert("이미 존재하는 등록번호입니다.");				
			}else if( result == 1 ){			//수정 성공
				alert("손해사정사 정보를 수정하였습니다.");
				//목록 새로고침
				getManagerListAjax();				
			}else{
				alert("손해사정사 정보 수정에 실패하였습니다.");	
			}
			
		},
		error: function (request, status, error) {			
			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
		}
		
	});
	
}

//손해사정사 정보 DB삭제=
function doInfoDeleteAction( p_ckey , p_user_no, p_action_flag){
	
	var param = {};
	param.ckey = p_ckey;
	param.user_no = p_user_no;
	param.action_flag = p_action_flag;
	
	$.ajax({
		type : "post",
		data : param,
		url : "actionCertiManageData",
		success : function(result){
			
			if( result == 1 ){			//삭제 성공
				alert("손해사정사 정보를 삭제하였습니다.");
				//목록 새로고침
				getManagerListAjax();				
			}else{
				alert("손해사정사 정보 삭제를 실패하였습니다.");	
			}
			
		},
		error: function (request, status, error) {			
			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
		}
		
	});
	
	
}

//손해사정사 정보 삭제하기 (소속 보조인 인원 체크 로직 제외로 해당함수 미사용)
/**
function doInfoDelete( p_ckey , p_user_no ){
	
	var param = {};
	param.ckey = p_ckey;
	param.user_no = p_user_no;
	
	$.ajax({
		type : "post",
		data : param,
		url : "getCertiManageMemberCnt",
		success : function(result){
						
			if( result == 0 ){				
				doInfoDeleteAction( p_ckey , p_user_no, "Delete");				
			}else{
				//삭제 대상자 모달창을 보여준다.				
				doInfoDeleteModal( p_ckey , p_user_no );
			}
			
		},
		error: function (request, status, error) {			
			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
		}		
	});	
}
**/

//손해사정사 정보 및 삭제 대상(보조인)자 명단 조회
function doInfoDeleteModal( p_ckey , p_user_no ){	

	var url = "getCertiManagerDeleteInfoList";
	
	var param = {};
	param.ckey = p_ckey;
	param.user_no = p_user_no;
	param.manual_text = "1";						//기능버튼 안내문구 표시
	
	$.ajax({
		type: "POST",
		url: url,
		data: param,
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		timeout: 20000,
		dataType: "HTML", 
		success: function(data){			
			$("#certi-delete-dialog").html();
			$("#certi-delete-dialog").html(data);					
				$("#certi-delete-dialog").dialog({
					height: 450,
					width: 550,
					closeOnEscape : true,
					draggable : true,
					title: "담당 손해사정사 별 보조인현황 관리",					
					modal: true,											
					buttons:{
						"삭제" : function(){
							doInfoDeleteAction( p_ckey , p_user_no , "DeleteAll");
							$(this).dialog("close");
							//목록을 다시불러온다.
							getManagerListAjax();
						},
						"취소" : function(){
							$(this).dialog("close");							
						}
					},
					overlay:{ opacity: 0., background: '#000000'}
				});		
		},
		error: function(e){
		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		}
		
	});	
	
}

//손해사정사 정보 수정하기
function doInfoModify( p_ckey ){		
	$("#tr_certi_view_"+p_ckey).hide();
	$("#tr_certi_edit_"+p_ckey).show();
	_initCalendar();
	_initMask();
}

//손해사정사 수정 취소하기
function doInfoEditCancel( p_ckey ){
	$("#tr_certi_edit_"+p_ckey).hide();
	$("#tr_certi_view_"+p_ckey).show();
}

//목록 불러오기
function getManagerListAjax(){
	
	$.ajax({
		type : "post",
		url : "topCertiManagerListAjax",		
		success : function(result){					
			$("#certiManagerList").html(result);				
		},
		error: function (request, status, error) {			
			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
		}
	});
	
}
</script>