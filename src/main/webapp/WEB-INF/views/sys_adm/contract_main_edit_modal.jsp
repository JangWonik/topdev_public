<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("CR", "\r"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" type="text/css" href="./resources/wm_css/rpt_issue.css?v=20181204?v=2018"/>
<script src="./resources/ne_js/calendar.js"></script>
<script src="./resources/jquery/jquery.mask.min.js"></script>
<script>
$(document).ready(function () {	
	//select2 값 셋팅
	$("#editConType").select2({
		dropdownParent: $("#contract-edit-dialog")	
	});
	
	$("#editTeamType").select2({
		dropdownParent: $("#contract-edit-dialog")	
	});
	
	$("#editConArea").select2({
		dropdownParent: $("#contract-edit-dialog")	
	});
	
	$("#editConType").val(${contractEditMap.c_type});
	$("#editConType").trigger('change');
	
	$("#editTeamType").val(${contractEditMap.team_type});
	$("#editTeamType").trigger('change');
		
	$("#editConArea").val(${contractEditMap.c_area});
	$("#editConArea").trigger('change');	
	
	//달력 셋팅	
	_initDatePicker();
    _initMask();
    
    //파일 업로드
    $("#contract_file_edit").change(function(){		
		doFileUpload();
	});
});

function _initDatePicker(){    	 
	$('.classCalendar').datepicker({
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
	
/* mask 처리 */
function _initMask(){
    var options = {
        onKeyPress : function(cep, event, currentField, options){
            var tid = event.currentTarget.id;
            var tidx = tid.substr(tid.length - 1, 1);            
        },
        reverse : true
    };

    $('input.classCalendar').mask('0000-00-00',options);
}

</script>
<!-- 계약서 수정폼 시작 -->
<form id="contractMainEditActionFrm">
	<input type="hidden" id="edit_tkey" name="edit_tkey" value="${contractEditMap.tkey}"/>				
	<div id="contract-edit-dialog" title="계약서 정보 수정" style="font-size: 15px;" align="center">
		<br/>
		<div class="tableStyle2" style="width: 750px;">
			<table class="vacation-ins-table">								
				<tr>
					<th width="15%" height="25px"><font color="red">*</font> 계약서 종류</th>
					<td width="35%">
						<select id="editConType" name="editConType" style="width:240px;text-align:left;">
							<option value="0"> - 선택 - </option>
							<c:forEach items="${conTypeList}" var="item" >
								<option value="${item.ckey}">${item.code_name}</option>									
							</c:forEach>										
						</select>
					</td>
					<th width="15%"><font color="red">*</font> 계약명</th>
					<td width="35%">
						<input type="text" id="edit_t_subject" name="edit_t_subject" maxlength="50" style="width:240px;text-align:left;" value="${contractEditMap.t_subject}">							
					</td>						
				</tr>
				<tr>
					<th width="15%" height="25px"><font color="red">*</font> 본부구분</th>
					<td>
						<select id="editTeamType" name="editTeamType" style="width:240px;text-align:left;">
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
						<select id="editConArea" name="editConArea" style="width:240px;text-align:left;">
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
						<input type="text" id="edit_t_username" name="edit_t_username" maxlength="50" style="width:240px;text-align:left;" value="${contractEditMap.t_username}">
					</td>
					<th><font color="red">*</font> 계약체결일</th>
					<td>
						<input type="text" class="classCalendar" id="edit_sign_date" name="edit_sign_date" style="width:120px;" maxlength="10" value="${contractEditMap.sign_date_fmt}"/>
					</td>						
				</tr>
				<tr>
					<th width="15%" height="25px"><font color="red">*</font> 계약시기</th>
					<td>
						<input type="text" class="classCalendar" id="edit_con_sdate" name="edit_con_sdate" style="width:120px;" maxlength="10" value="${contractEditMap.con_sdate_fmt}"/>
					</td>
					<th>계약종기</th>
					<td>
						<input type="text" class="classCalendar" id="edit_con_edate" name="edit_con_edate" style="width:120px;" maxlength="10" value="${contractEditMap.con_edate_fmt}"/>
					</td>						
				</tr>
				<tr>
					<th width="15%" height="35px">첨부된 파일</th>
					<td colspan="3" style="text-align:left;padding-left:10px;">
						<c:choose>
							<c:when test="${contractFileList.size() == 0 }">첨부된 파일이 없습니다.</c:when>
							<c:otherwise>
								<c:forEach var="items" items="${contractFileList}" varStatus="status">
									<div style="padding-top:5px;">
										<a href="#" onclick="javascript:fnFileDown('${items.fkey}')">
											${items.file_org_name} &nbsp;<img src="./resources/ls_img/icon_disket.gif" title="파일다운로드">
										</a>
										<a href="#" onclick="javascript:fnFileDel('${contractEditMap.tkey}','${items.fkey}','${items.file_org_name}')">
											&nbsp;<img src="./resources/ls_img/btn_del_s.gif" title="파일삭제">
										</a>
									</div>
								</c:forEach>								
							</c:otherwise>
						</c:choose>						
					</td>
				</tr>
				<tr>
					<th width="15%" height="35px">파일추가</th>
					<td colspan="3" style="text-align:left;padding-left:10px;">
						<!-- 파일 업로드 창 시작 -->
						<input type="file" id="contract_file_edit" name="contract_file_edit" style="width: 80%;">
						<!-- 파일 업로드 창 끝 -->
					</td>
				</tr>					
				<tr>
					<th width="15%" height="100">비고</th>
					<td colspan="3" align="left" style="text-align:left;padding-left:10px;">
						<textarea rows="6" cols="78" id="edit_t_content" name="edit_t_content">${fn:replace(fn:replace(contractEditMap.t_content , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
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
<!-- 계약서 수정폼 끝 -->
<!-- 계약서 첨부파일 업로드 폼 -->