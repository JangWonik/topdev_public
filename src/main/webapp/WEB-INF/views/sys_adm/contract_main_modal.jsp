<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${title_Session}</title>	
	<form id="contractMainActionFrm">				
		<div id="contract-main-dialog" title="계약서 등록" style="font-size: 15px;display:none;" align="center">
			<br/>
			<div class="tableStyle2" style="width: 750px;">
				<table class="vacation-ins-table">
					<tr>
						<th width="15%" height="25px"><font color="red">*</font> 계약서 종류</th>
						<td width="35%">
							<select id="addConType" name="addConType" style="width:240px;text-align:left;">
								<option value="0"> - 선택 - </option>			
								<c:forEach items="${conTypeList}" var="item" >
									<option value="${item.ckey}">${item.code_name}</option>									
								</c:forEach>										
							</select>
						</td>
						<th width="15%"><font color="red">*</font> 계약명</th>
						<td width="35%">
							<input type="text" id="add_t_subject" name="add_t_subject" maxlength="50" style="width:240px;text-align:left;">							
						</td>						
					</tr>
					<tr>
						<th width="15%" height="25px"><font color="red">*</font> 본부구분</th>
						<td>
							<select id="addTeamType" name="addTeamType" style="width:240px;text-align:left;">
								<option value="9"> - 선택 - </option>
								<option value="0">공통</option>
								<c:choose>								
									<c:when test="${sContractAuth eq 1}">
										<option value="1">1종</option>
									</c:when>
									<c:when test="${sContractAuth eq 4}">
										<option value="4">4종</option>
									</c:when>
									<c:otherwise>
										<option value="1">1종</option>
										<option value="4">4종</option>
									</c:otherwise>
								</c:choose>			
							</select>
						</td>
						<th><font color="red">*</font> 지점구분</th>
						<td>
							<select id="addConArea" name="addConArea" style="width:240px;text-align:left;">
								<option value="0"> - 선택 - </option>			
								<c:forEach items="${conAreaList}" var="item" >
									<option value="${item.ckey}">${item.code_name}</option>									
								</c:forEach>										
							</select>
						</td>						
					</tr>
					<tr>
						<th width="15%" height="25px"><font color="red">*</font> 계약자명</th>
						<td>
							<input type="text" id="add_t_username" name="add_t_username" maxlength="50" style="width:240px;text-align:left;">
						</td>
						<th><font color="red">*</font> 계약체결일</th>
						<td>
							<input type="text" class="classCalendar" id="add_sign_date" name="add_sign_date" style="width:120px;" maxlength="10"/>
						</td>						
					</tr>
					<tr>
						<th width="15%" height="25px"><font color="red">*</font> 계약시기</th>
						<td>
							<input type="text" class="classCalendar" id="add_con_sdate" name="add_con_sdate" style="width:120px;" maxlength="10"/>
						</td>
						<th>계약종기</th>
						<td>
							<input type="text" class="classCalendar" id="add_con_edate" name="add_con_edate" style="width:120px;" maxlength="10"/>
						</td>						
					</tr>
					<tr>
						<th width="15%" height="35px">파일첨부</th>
						<td colspan="3" style="text-align:left;padding-left:10px;">
							<input type="file" id="contract_file_add" name="contract_file_add" style="width: 55%;">
						</td>
					</tr>					
					<tr>
						<th width="15%" height="100">비고</th>
						<td colspan="3" align="left" style="text-align:left;padding-left:10px;">
							<textarea rows="6" cols="78" id="add_t_content" name="add_t_content"></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="4" style="text-align:left;padding-left:10px;">
							<b>&#8251; <font color="red">*</font> 항목은 필수 입력 값 입니다.</b>
						</td>
					</tr>
				</table>				
			</div>
		</div>
	</form>
	<div id="contract-detail-dialog" title="계약서 정보 조회" style="font-size: 15px;display:none;" align="center"></div>
	<div id="contract-edit-dialog" title="계약서 정보 수정" style="font-size: 15px;display:none;" align="center"></div>	
		
<script type='text/javascript'>
//계약서 등록폼
function fnContractIns(){
	
	//등록폼 초기화
	$("#addConType option:eq(0)").prop('selected', true);
	$("#add_t_subject").val('');
	$("#addTeamType option:eq(0)").prop('selected', true);
	$("#addConArea option:eq(0)").prop('selected', true);
	$("#add_t_username").val('');
	$("#add_sign_date").val('');
	$("#add_con_sdate").val('');
	$("#add_con_edate").val('');
	$("#contract_file_add").val('');
	$("#add_t_content").val('');	
	
	$("#contract-main-dialog").dialog({
		height: 500,
		width: 800,
		closeOnEscape : true,
		draggable : true,
		appendTo : "#contractMainActionFrm",
		title: "계약서 등록",
		buttons:{
			"등록" : function(){
				var action = fnContractAction('I');		//등록
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
	
	$("#addConType").select2({
		dropdownParent: $("#contract-main-dialog")	
	});
	
	$("#addTeamType").select2({
		dropdownParent: $("#contract-main-dialog")	
	});
	
	$("#addConArea").select2({
		dropdownParent: $("#contract-main-dialog")	
	});
}

function fnContractEditAction( action_flag ){	
	var action_type = action_flag;
	
	var editTkey = $("#edit_tkey").val();
	var editConType = $("#editConType").val();
	var editTSubject = $("#edit_t_subject").val();
	var editTeamType = $("#editTeamType").val();
	var editConArea = $("#editConArea").val();
	var editTUserName = $("#edit_t_username").val();
	var editSignDate = $("#edit_sign_date").val();
	var editConSdate = $("#edit_con_sdate").val();
	var editConEdate = $("#edit_con_edate").val();				//계약종기가 없는 경우는 무기한 계약으로 허용함.
	var editTContent = $("#edit_t_content").val();
	
	if( editTkey == "" ){
		alert("정보수정의 필수 입력값이 없습니다.\nIT정보보호파트로 연락해주세요.");
		return;
	}
	
	//유효성 체크
	if( editConType == 0 ){
		alert("계약서 종류를 선택해 주세요.");
		$("#editConType").focus();
		return;
	}
	
	if( editTSubject == "" ){
		alert("계약명을 입력해주세요.");
		$("#edit_t_subject").focus();
		return;
	}
	
	if( editTeamType == 9 ){
		alert("본부구분을 선택해주세요.");
		$("#editTeamType").focus();
		return;
	}
	
	if( editConArea == 0 ){
		alert("지점구분을 선택해주세요.");
		$("#editConArea").focus();
		return;
	}
	
	if( editTUserName == "" ){
		alert("계약자명을 입력해주세요.");
		$("#edit_t_username").focus();
		return;
	}
	
	if( editSignDate == "" ){
		alert("계약체결일을 입력해주세요.");
		$("#edit_con_sdate").focus();
		return;
	}
	
	var param = new FormData();
	
	param.append("tkey",editTkey);
	param.append("action", action_type);
	param.append("team_type", editTeamType);
	param.append("c_type", editConType);
	param.append("t_subject", editTSubject);
	param.append("t_username", editTUserName);
	param.append("con_sdate", editConSdate);
	param.append("con_edate", editConEdate);
	param.append("sign_date", editSignDate);
	param.append("c_area", editConArea);
	param.append("t_content", editTContent);
	
	var url = "./contractMainAction";			//계약 정보 갱신
	
	$.ajax({
		type: "POST",
		url: url,
		data: param,
		timeout: 20000,
		processData: false,
		contentType: false,
		dataType: "JSON",
		success: function(data){
			if( data ){		//1인 경우 성공 
				alert("계약 정보가 수정되었습니다.");
				$("#contract-edit-dialog").dialog("close");
				$("#searchBtn").click();
			}
		}                
    });
	
}

//계약서 등록
function fnContractAction( action_flag ){
	
	var action_type = action_flag;
	
	var addConType = $("#addConType").val();
	var addTSubject = $("#add_t_subject").val();
	var addTeamType = $("#addTeamType").val();
	var addConArea = $("#addConArea").val();
	var addTUserName = $("#add_t_username").val();
	var addSignDate = $("#add_sign_date").val();
	var addConSdate = $("#add_con_sdate").val();
	var addConEdate = $("#add_con_edate").val();				//계약종기가 없는 경우는 무기한 계약으로 허용함.
	var addContractFileAdd = $("#contract_file_add")[0].files[0];		//파일 없는경우 null
	var addTContent = $("#add_t_content").val();
	
	//유효성 체크
	if( addConType == 0 ){
		alert("계약서 종류를 선택해 주세요.");
		$("#addConType").focus();
		return;
	}
	
	if( addTSubject == "" ){
		alert("계약명을 입력해주세요.");
		$("#add_t_subject").focus();
		return;
	}
	
	if( addTeamType == 9 ){
		alert("본부구분을 선택해주세요.");
		$("#addTeamType").focus();
		return;
	}
	
	if( addConArea == 0 ){
		alert("지점구분을 선택해주세요.");
		$("#addConArea").focus();
		return;
	}
	
	if( addTUserName == "" ){
		alert("계약자명을 입력해주세요.");
		$("#add_t_username").focus();
		return;
	}
	
	if( addSignDate == "" ){
		alert("계약체결일을 입력해주세요.");
		$("#add_con_sdate").focus();
		return;
	}
	
	var param = new FormData();
	
	param.append("action", action_type);
	param.append("team_type", addTeamType);
	param.append("c_type", addConType);
	param.append("t_subject", addTSubject);
	param.append("t_username", addTUserName);
	param.append("con_sdate", addConSdate);
	param.append("con_edate", addConEdate);
	param.append("sign_date", addSignDate);
	param.append("c_area", addConArea);
	param.append("attath_file", addContractFileAdd);
	param.append("t_content", addTContent);
	
	var url = "./contractMainAction";			//계약 정보 갱신
	
	$.ajax({
		type: "POST",
		url: url,
		data: param,
		timeout: 20000,
		processData: false,
		contentType: false,
		dataType: "JSON",
		success: function(data){
			if( data ){		//1인 경우 성공 
				alert("계약 정보를 추가하였습니다.");
				$("#contract-main-dialog").dialog("close");
				$("#searchBtn").click();
			}
		}                
    });	
}

//계약서 완전 삭제
function doDeleteAll( p_tkey , p_subject ){
	
	var sMsg = p_subject +" 계약정보를 삭제하시겠습니까?\n삭제 후엔 복구가 불가합니다.";
	
	if( !confirm( sMsg ) ){		
		return;
	}
	
	var action_type = "D";		//계약서 완전삭제	
	
	var param = new FormData();
	
	param.append("action", action_type);
	param.append("tkey", p_tkey);
	
	var url = "./contractMainAction";			//계약 정보 갱신
	
	$.ajax({
		type: "POST",
	url: url,
	data: param,
	timeout: 20000,
	processData: false,
	contentType: false,
	dataType: "JSON",
		success: function(data){
			if( data ){		//1인 경우 성공 
				alert("계약 정보를 삭제하였습니다.");				
				$("#searchBtn").click();
			}
		}                
    });
}

//계약서 첨부파일만 삭제
function fnFileDel( p_tkey, p_fkey , p_filename ){
	var sMsg = "첨부된 "+p_filename +" 파일을 삭제하시겠습니까?\n삭제 후엔 복구가 불가합니다.";
	
	if( !confirm( sMsg ) ){		
		return;
	}
	
	var action_type = "DF";		//계약서 완전삭제	
	
	var param = new FormData();
	
	param.append("action", action_type);
	param.append("tkey", p_tkey);
	param.append("fkey", p_fkey);
	
	var url = "./contractMainAction";			//계약 정보 갱신
	
	$.ajax({
		type: "POST",
	url: url,
	data: param,
	timeout: 20000,
	processData: false,
	contentType: false,
	dataType: "JSON",
		success: function(data){
			if( data ){		//1인 경우 성공 
				alert("첨부된 파일을 삭제 하였습니다.");
				//목록 새로 불러오기
				$("#searchBtn").click();
				//모달창 새로 열기
				doEditModal(p_tkey);
			}
		}                
    });
	
}

function doEditModal( p_tkey ){
	
	var url = "./contractEditModal";
		
	var param = {};
	param.tkey  = p_tkey;			
	
	//모달창 불러오기
	$.ajax({
        type: "POST",
        url: url,
        data: param,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        timeout: 20000,
        dataType: "HTML", 
        success: function(data){        	
        	$("#contract-edit-dialog").html();
        	$("#contract-edit-dialog").html(data);
			$("#contract-edit-dialog").dialog({
				height: 550,
				width: 800,
				closeOnEscape : true,
				draggable : true,
				title: "계약서 정보수정",
				modal: true,
				buttons:{						
					"수정" : function(){
						var action = fnContractEditAction('U');		//수정
						if (action){
							$(this).dialog("close");
						}
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

function doViewModal( p_tkey ){
	
	var url = "./contractDetailModal";
		
	var param = {};
	param.tkey  = p_tkey;			
	
	//모달창 불러오기
	$.ajax({
        type: "POST",
        url: url,
        data: param,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        timeout: 20000,
        dataType: "HTML", 
        success: function(data){        	
        	$("#contract-detail-dialog").html();
        	$("#contract-detail-dialog").html(data);
			$("#contract-detail-dialog").dialog({
				height: 450,
				width: 800,
				closeOnEscape : true,
				draggable : true,
				title: "계약서 정보 상세보기",
				modal: true,
				buttons:{						
					"닫기" : function(){
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

//수정창에서 파일 업로드 하기
function doFileUpload(){
	
	var edit_tkey = $("#edit_tkey").val();
	var editContractFile = $("#contract_file_edit")[0].files[0];
	
	var action_type = "DA";		//계약서 첨부파일 추가	
	
	var param = new FormData();
	
	param.append("action", action_type);
	param.append("tkey", edit_tkey);	
	param.append("attath_file", editContractFile);
	
	var url = "./contractMainAction";			//계약 정보 갱신
	
	$.ajax({
		type: "POST",
	url: url,
	data: param,
	timeout: 20000,
	processData: false,
	contentType: false,
	dataType: "JSON",
		success: function(data){
			if( data ){		//1인 경우 성공
				//목록 새로 불러오기
				$("#searchBtn").click();
				//모달창 새로 열기
				doEditModal(edit_tkey);
			}
		}                
    });
}
</script>