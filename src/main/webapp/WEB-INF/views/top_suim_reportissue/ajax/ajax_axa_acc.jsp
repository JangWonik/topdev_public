<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	$(document).ready(function(){	
		$("#acc_cont_sel").change( function(){		//사고원인 변경에 따른 수정
			if( $("#acc_cont_sel").val() == 'direct' ){		//직접입력
				if( confirm("기존에 입력된 사고원인이 삭제됩니다.\n진행하시겠습니까?") ){
					$("#acc_facts").val('');
					$("#acc_facts").focus();
				}
			}else if( $("#acc_cont_sel").val() == 'basic' ){					//기본으로 설정한경우
				$("#acc_facts").val("건강정보 등의 민간정보가 포함되어 보험업법 시행령 제99조에 의거 이를 제외하고 교부합니다.");
			}
		});
		
		if($("#acc_edit_type").val() == 'edit'){
			//우편번호 추가
			$("#postCodeBtnRptUdt").click(function(){ 		
				var themeObj = {
						   bgColor: "#C00C0C", //바탕 배경색				   
						   emphTextColor: "#C01160" //강조 글자색				   
						};
				new daum.Postcode({
					theme: themeObj,
					oncomplete: function(data) {
						$("#investigate_addr1").val(data.roadAddress);
					}
				}).open();
			});
			
			_initCalendar();	
		}
		
	});	
	
</script>
</head>
<c:if test="${ acc_edit_type eq 'view' }">
<table id="table_issue_contract_view" style="border: 1px solid currentColor;">
	<colgroup>
	    <col width="25%">
	    <col width="75%">                    
	</colgroup>                
	<tbody>
	<tr>
		<th><b>구 분</b></th>
		<th><b>상 세 내 용</b></th>                	
	</tr>
	<tr>
	    <th><b>사 고 일 시</b></th>
	    <td  style="text-align: left;padding-left:5px;">${suimVO.accident_date}</td>                    
	</tr>
	<tr>
	    <th><b>사 고 장 소</b></th>
	    <td  style="text-align: left;padding-left:5px;">			
			<c:out value="${suimVO.investigate_addr1}"/><c:out value="${suimVO.investigate_addr2}"/>			
	    </td>
	</tr>   
	<tr>
	    <th><b>사 고 원 인</b></th>
	    <td  style="text-align: left;padding-left:5px;">
		<c:out value="${rptIssue.insuContent}"/>
	    </td>
	</tr>
	<tr>
	    <th><b>사 고 경 위</b></th>
	    <td  style="text-align: left;padding-left:5px;">
	    ${fn:replace(rptIssue.insuSequence , LF , '<br>')}		
	    </td>
	</tr>
	<tr>
	    <th><b>피 해 자 ( 피 해 물 )</b></th>
	    <td  style="text-align: left;padding-left:5px;">
		<c:out value="${suimVO.damagedNm}"/>
	    </td>
	</tr>
    </tbody>
</table>
</c:if>

<c:if test="${ acc_edit_type eq 'edit' }">
<table id="table_issue_contract_edit" style="border: 1px solid currentColor;">
	<colgroup>
	    <col width="25%">
	    <col width="75%">                    
	</colgroup>                
	<tbody>
	<tr>
		<th><b>구 분</b></th>
		<th><b>상 세 내 용</b></th>                	
	</tr>
	<tr>
	    <th><b>사 고 일 시</b></th>
	    <td  style="text-align: left;padding-left:5px;"><input type="text" id="acc_date" value="${suimVO.accident_date}" class="calendar" style="width: 25%;"></td>                    
	</tr>
	<tr>
	    <th><b>사 고 장 소</b></th>
	    <td  style="text-align: left;padding-left:5px;">
			<input type="button" id="postCodeBtnRptUdt" value="우편번호 찾기">
			<input type="text" id="investigate_addr1" style="width: 60%" value="${suimVO.investigate_addr1}" readonly />
			<!-- 소재지 주소와 동일 기능 추가-->
			<input type="button" class="buttonMini" value="소재지주소와동일" style="width:100px;" onclick="javascript:fnSameAddress();">
			<%-- <input type="text" id="investigate_addr2" style="width: 40%" value="${suimVO.investigate_addr2}" readonly /> --%>    	
	    </td>
	</tr>   
	<tr>
	    <th><b>사 고 원 인</b></th>
	    <td  style="text-align: left;padding-left:5px;">
	    <select id="acc_cont_sel" name="acc_cont_sel" style="width:100px;height:25px;">						
	    	<option value="" selected>입력선택</option>
			<option value="basic">기본입력</option>
			<option value="direct">직접입력</option>
		</select>
		<textarea id="acc_facts" rows="2" cols="100" style="width:425px;">${rptIssue.insuContent}</textarea>
		<%-- <c:out value="${suimVO.getAccident_facts()}"/> --%>
	    </td>
	</tr>
	<tr>
	    <th><b>사 고 경 위</b></th>
	    <td  style="text-align: left;padding-left:5px;">	    
		<textarea id="acc_insu_sequence" name="acc_insu_sequence" rows="2" cols="100" style="width:425px;">${rptIssue.insuSequence}</textarea>		
	    </td>
	</tr>
	<tr>
		<th><b>피 해 자 ( 피 해 물 )</b></th>
	    <td  style="text-align: left;padding-left:5px;">
			<input type="text" style="width: 90%;" id="damaged_nm" name="damaged_nm" value="${suimVO.damagedNm}"/>
	    </td>
	</tr>
    </tbody>
</table>
</c:if>