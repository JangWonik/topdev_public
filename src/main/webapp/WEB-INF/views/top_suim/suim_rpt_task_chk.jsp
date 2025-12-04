<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<script>
	
	$(document).ready(function(){
		
		$("#contactYn option[value='"+"${suimRptTaskChkVo.contactYnCode}"+"']").attr("selected", true);
		$("#faceYn option[value='${suimRptTaskChkVo.faceYnCode}']").attr("selected", true);
		$("#interimYn option[value='${suimRptTaskChkVo.interimYnCode}']").attr("selected", true);
		
	});
	
	/*  */
	function taskEdite(gubun){
		
		if(gubun == 'Contract'){
			$("#contactYnSpan").hide();
			$("#contactYn").show();
			
			$("#contactMemoSpan").hide();
			$("#contactMemo").show();
			
			$("#taskContractEditeBtn").hide();
			$("#taskContractEditeOkBtn").show();
			
		}else if(gubun == 'Face'){
			$("#faceYnSpan").hide();
			$("#faceYn").show();
			
			$("#faceMemoSpan").hide();
			$("#faceMemo").show();

			$("#taskFaceEditeBtn").hide();
			$("#taskFaceEditeOkBtn").show();
			
		}else if(gubun == 'Interim'){
			$("#interimYnSpan").hide();
			$("#interimYn").show();
			
			$("#interimMemoSpan").hide();
			$("#interimMemo").show();

			$("#taskInterimEditeBtn").hide();
			$("#taskInterimEditeOkBtn").show();
			
		}
		
	}
	
	function taskEditeOk(gubun){
		
		var checkYn = "";
		var checkMemo = "";
		
		if(gubun == 'Contract'){
			checkYn = $("#contactYn option:selected").val();
			checkMemo = $("#contactMemo").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;');
		}else if(gubun == 'Face'){
			checkYn = $("#faceYn option:selected").val();
			checkMemo = $("#faceMemo").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;');
		}else if(gubun == 'Interim'){
			checkYn = $("#interimYn option:selected").val();
			checkMemo = $("#interimMemo").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;');
		}

		$.post("./taskCheckUdt",
				{	
					 gubun 	  	:gubun  //
					,suimRptNo	:"${suimVO.suim_rpt_no}" 
					,checkYn	:checkYn
					,checkMemo  :checkMemo 
					
				},
				function(data,status){
					if(status == "success"){
						if(data == 0){
							alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
						}else{
							
							if(gubun == "Contract"){
								
								$("#contactYnSpan").show();
								$("#contactYn").hide();
								
								$("#contactMemo").hide();
								$("#contactMemoSpan").show();
								
								$("#taskContractEditeBtn").show();
								$("#taskContractEditeOkBtn").hide();
								
								$("#contactYn option[value='"+checkYn+"']").attr("selected", true);
								$("#contactYnSpan").html($("#contactYn option:selected").text());
								$("#contactMemoSpan").html(checkMemo);
								
								$("#taskFaceEditeBtn").show();
								
							}else if(gubun == "Face"){
								
								$("#faceYnSpan").show();
								$("#faceYn").hide();
								
								$("#faceMemo").hide();
								$("#faceMemoSpan").show();
								
								$("#taskFaceEditeBtn").show();
								$("#taskFaceEditeOkBtn").hide();
								
								$("#faceYn option[value='"+checkYn+"']").attr("selected", true);
								$("#faceYnSpan").html($("#faceYn option:selected").text());
								$("#faceMemoSpan").html(checkMemo);
								
								$("#taskInterimEditeBtn").show();
								
							}else if(gubun == "Interim"){
								
								$("#interimYnSpan").show();
								$("#interimYn").hide();
								
								$("#interimMemo").hide();
								$("#interimMemoSpan").show();
								
								$("#taskInterimEditeBtn").show();
								$("#taskInterimEditeOkBtn").hide();
								
								$("#interimYn option[value='"+checkYn+"']").attr("selected", true);
								$("#interimYnSpan").html($("#interimYn option:selected").text());
								$("#interimMemoSpan").html(checkMemo);
								
							}
						}
					}else{
						alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
					}
				}
		);//post
		
	}
	
	
	
</script>
</head>
<body>
	<!-- 처리내용 확인 입력 --> 
	<table align="center" cellpadding="0" cellspacing="0" width="600" style="margin-top:10px;">
		<tr>
			<td height="25">
				<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 처리내용 확인사항 : <font color="999999">수임일 기준 ${suimVO.pastDays} 일 경과</font></b>
			</td>
		</tr>
	</table>
	<table cellSpacing="0" cellPadding="0" width="600" align="center">
		<tr align="center" bgcolor="#EDEDED">
			<th class="td" width="15%">확인항목</th>
			<th class="td" width="10%">확인유무</th>
			<th class="td" width="70%">비고</th>
			<th class="td" width="5%">-</th>
		</tr>
		<tr align="center">
			<td class="td" nowrap>컨텍 여부</td>
			<td class="td" nowrap>
				<span id="contactYnSpan" class="taskChkSpanClass">
				<c:if test="${suimRptTaskChkVo.contactDate ne '1970-01-01'}">
					${suimRptTaskChkVo.contactYn}				
				</c:if>
				</span>
				<select id="contactYn" style="display:none;" class="taskChkInputClass">
					<option value="0">미확인</option>
					<option value="1">완료</option>
					<option value="9">미시행</option>
				</select>
			</td>
			<td class="td" align="left">
				<span id = "contactMemoSpan">
					${suimRptTaskChkVo.contactMemoSpan}
				</span>
				<textarea id="contactMemo" cols="70" rows="3" style="display:none;">${suimRptTaskChkVo.contactMemo}</textarea>
			</td>
			<td class="td" nowrap>
				<img id ="taskContractEditeBtn" src="./resources/ls_img/btn_edit_s.gif" onclick="taskEdite('Contract');" title="수정" style='cursor:pointer;' />
				<img id ="taskContractEditeOkBtn" src='./resources/ls_img/btn_check_s.gif' onclick="taskEditeOk('Contract');" title='수정 완료' style='display:none;cursor:pointer;'  />
			</td>
		</tr>
		<tr align="center">
			<td class="td" nowrap>면담 여부</td>
			<td class="td" nowrap>
				<span id="faceYnSpan" class="taskChkSpanClass">
					<c:if test="${suimRptTaskChkVo.faceDate ne '1970-01-01'}">
						${suimRptTaskChkVo.faceYn}				
					</c:if>
				</span>
				<select id="faceYn" style="display:none;" class="taskChkInputClass">
					<option value="0">미확인</option>
					<option value="1">완료</option>
					<option value="9">미시행</option>
				</select>
			</td>
			<td class="td" align="left">
				<span id = "faceMemoSpan">
					${suimRptTaskChkVo.faceMemoSpan}
				</span>
				<textarea id="faceMemo" cols="70" rows="3" style="display:none;">${suimRptTaskChkVo.faceMemo}</textarea>
			</td>
			<td class="td" nowrap>
			<c:choose>
				<c:when test="${suimRptTaskChkVo.contactDate ne '1970-01-01'}">
					<img id ="taskFaceEditeBtn" src="./resources/ls_img/btn_edit_s.gif" onclick="taskEdite('Face');" title="수정" style='cursor:pointer;' />
					<img id ="taskFaceEditeOkBtn" src='./resources/ls_img/btn_check_s.gif' onclick="taskEditeOk('Face');" title='수정 완료' style='display:none;cursor:pointer;'  />
				</c:when>
				<c:otherwise>
					<img id ="taskFaceEditeBtn" src="./resources/ls_img/btn_edit_s.gif" onclick="taskEdite('Face');" title="수정" style='cursor:pointer; display:none;' />
					<img id ="taskFaceEditeOkBtn" src='./resources/ls_img/btn_check_s.gif' onclick="taskEditeOk('Face');" title='수정 완료' style='display:none;cursor:pointer;'  />
				</c:otherwise>
			</c:choose>
			</td>
		</tr>
		<tr align="center">
			<td class="td" nowrap>중간 보고</td>
			<td class="td" nowrap>
				<span id="interimYnSpan" class="taskChkSpanClass">
					<c:if test="${suimRptTaskChkVo.interimDate ne '1970-01-01'}">
						${suimRptTaskChkVo.interimYn}				
					</c:if>
				</span>
				<select id="interimYn" style="display:none;" class="taskChkInputClass">
					<option value="0">미확인</option>
					<option value="1">완료</option>
					<option value="9">미시행</option>
				</select>
			</td>
			<td class="td" align="left">
				<span id = "interimMemoSpan">
					${suimRptTaskChkVo.interimMemoSpan}
				</span>
				<textarea id="interimMemo" cols="70" rows="3" style="display:none;">${suimRptTaskChkVo.interimMemo}</textarea>
			</td>
			<td class="td" nowrap>
				<c:choose>
					<c:when test="${suimRptTaskChkVo.contactDate ne '1970-01-01'}">
						<img id ="taskInterimEditeBtn" src="./resources/ls_img/btn_edit_s.gif" onclick="taskEdite('Interim');" title="수정" style='cursor:pointer;' />
						<img id ="taskInterimEditeOkBtn" src='./resources/ls_img/btn_check_s.gif' onclick="taskEditeOk('Interim');" title='수정 완료' style='display:none;cursor:pointer;'  />
					</c:when>
					<c:otherwise>
						<img id ="taskInterimEditeBtn" src="./resources/ls_img/btn_edit_s.gif" onclick="taskEdite('Interim');" title="수정" style='cursor:pointer; display:none;' />
						<img id ="taskInterimEditeOkBtn" src='./resources/ls_img/btn_check_s.gif' onclick="taskEditeOk('Interim');" title='수정 완료' style='display:none;cursor:pointer;'  />
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
	</table>
</body>