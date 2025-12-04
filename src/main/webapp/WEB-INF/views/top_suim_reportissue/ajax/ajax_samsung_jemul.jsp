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
		
		//입력값에 '~' 있으면 분리해서 넣어준다.
		var sDate = '${suimVO.insuTerm}';		
		
		if( sDate.indexOf("~") > -1 ){
			var bDate = sDate.split("~");			
			$("#sdate").val(bDate[0]);
			$("#edate").val(bDate[1]);
		}
		
		if($("#cont_edit_type").val() == 'edit'){
			//우편번호 추가
			$("#postCodeBtnRptUdt").click(function(){		
				var themeObj = {
						   bgColor: "#C00C0C", //바탕 배경색				   
						   emphTextColor: "#C01160" //강조 글자색				   
						};
				new daum.Postcode({
					theme: themeObj,
					oncomplete: function(data) {
						$("#postcode_rptUdt").val(data.zonecode);
						$("#addr_rptUdt_1").val(data.roadAddress);
					}
				}).open();
			});
			
			_initCalendar();	
		}				
	});	
	
</script>
</head>
<c:if test="${ cont_edit_type eq 'view' }">
	<table id="table_issue_contract_view" style="border: 1px solid currentColor;">
		<colgroup>
			<col width="15%">			
			<col width="85%">
		</colgroup>                
		<tbody>
		<tr>
		 	<th><b>구분</b></th>
		 	<th><b>계약사항</b></th>
	 	</tr>
	 	<tr>
		    <th><b>보험종목</b></th>
		    <td style="text-align: left;padding-left:5px;">${rptIssueMain.insuranceNm}</td>                    
		</tr>
		<tr>
		    <th><b>증권번호</b></th>
		    <td style="text-align: left;padding-left:5px;">${rptIssueMain.policyNo}</td>                    
		</tr>
		<tr>
		    <th><b>계 약 자</b></th>
		    <td style="text-align: left;padding-left:5px;">${suimVO.getPolicyholder_nm()}</td>                    
		</tr>
		<tr>
		    <th><b>피보험자</b></th>
		    <td style="text-align: left;padding-left:5px;">${suimVO.getBeneficiary_nm()}</td>                    
		</tr>
		<c:if test="${ctype eq 'C' || ctype eq 'B' }">
		<tr>
		    <th><b>소 재 지</b></th>
		    <td style="text-align: left;padding-left:5px;"><span id="addr_rptUdt_1_text">${ rptIssue.suimAddress }</span></td>                    
		</tr>
		</c:if>
		<tr>
		    <th><b>보험기간</b></th>
		    <td style="text-align: left;padding-left:5px;">${suimVO.insuTerm}</td>                    
		</tr>			
	</table>
</c:if>

<c:if test="${ cont_edit_type eq 'edit' }">
	<form name="contEditForm" id="contEditForm" method="post">
	<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suimVO.suim_rpt_no}">
	<input type="hidden" id="cont_edit_type" name="cont_edit_type" value="view">
	<input type="hidden" id="ctype" name="ctype" value="C">
	<table id="table_issue_contract_view" style="border: 1px solid currentColor;">
		<colgroup>
			<col width="15%">			
			<col width="85%">
		</colgroup>                
		<tbody>
		<tr>
		 	<th><b>구분</b></th>
		 	<th><b>계약사항</b></th>
	 	</tr>
	 	<tr>
		    <th><b>보험종목</b></th>
		    <td style="text-align: left;padding-left:5px;">${rptIssueMain.insuranceNm}</td>                    
		</tr>
		<tr>
		    <th><b>증권번호</b></th>
		    <td style="text-align: left;padding-left:5px;">${rptIssueMain.policyNo}</td>                    
		</tr>
		<tr>
		    <th><b>계 약 자</b></th>
		    <td style="text-align: left;padding-left:5px;">${suimVO.getPolicyholder_nm()}</td>                    
		</tr>
		<tr>
		    <th><b>피보험자</b></th>
		    <td style="text-align: left;padding-left:5px;">${suimVO.getBeneficiary_nm()}</td>                    
		</tr>
		<c:if test="${ctype eq 'C' || ctype eq 'B' }">
		<tr>
		    <th><b>소 재 지</b></th>
		    <td style="text-align: left;padding-left:5px;">		    	
				<input type="button" id="postCodeBtnRptUdt" value="우편번호 찾기">
				<input type="text" id="addr_rptUdt_1" style="width: 46%" value="${ rptIssue.suimAddress }" readonly />
		    </td>                    
		</tr>
		</c:if>
		<tr>
		    <th><b>보험기간</b></th>
		    <td style="text-align: left;padding-left:5px;">
			    <input class="calendar" type="text" id="sdate" name="sdate" value="" style="width: 25%;"/>                    	
				    &nbsp;~&nbsp;
				<input class="calendar" type="text" id="edate" name="edate" value="" style="width: 25%;"/>
				<input type="hidden" id = "insuTerm" />
		    </td>                    
		</tr>			
	</table>
	</form>
</c:if>