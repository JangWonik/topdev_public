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
			<col width="25%">			
			<col width="75%">
		</colgroup>                
		<tbody>
		<tr>
		 	<th><b>구 분</b></th>
		 	<th><b>내 용</b></th>
	 	</tr>
	 	<tr>
		    <th><b>증 권 번 호</b></th>
		    <td style="text-align: left;padding-left:5px;">${rptIssueMain.policyNo}</td>                    
		</tr>
		<tr>
		    <th><b>보 험 기 간</b></th>
		    <td style="text-align: left;padding-left:5px;">${suimVO.insuTerm}</td>                    
		</tr>
		<tr>
		    <th><b>담 보 명</b></th>
		    <td style="text-align: left;padding-left:5px;">${rptIssueMain.guaranteeTitle}</td>                    
		</tr>
	 	<tr>
		    <th><b>가입금액 (보상한도액)</b></th>
		    <td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${rptIssueMain.amtSelfPay}" pattern="#,###" /> 원</td>                    
		</tr>		
		<tr>
		    <th><b>자 기 부 담 금</b></th>
		    <td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${rptIssueMain.amtCompensationLimit}" pattern="#,###" /> 원</td>                    
		</tr>
		<tr>
		    <th><b>계약자 / 피보험자</b></th>
		    <td style="text-align: left;padding-left:5px;">${suimVO.getPolicyholder_nm()} / ${suimVO.getBeneficiary_nm()}</td>                    
		</tr>
		<tr>
		    <th><b>소 재 지 ( 목 적 물 )</b></th>
		    <td style="text-align: left;padding-left:5px;"><%-- ${rptIssue.suimZipcode} --%>
		    <span id="addr_rptUdt_1_text">${rptIssue.suimAddress}</span></td>                    
		</tr>
		<tr>
		    <th><b>사 고 접 수 번 호</b></th>
		    <td style="text-align: left;padding-left:5px;">${rptIssueMain.accidentNo}</td>                    
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
			<col width="25%">			
			<col width="75%">
		</colgroup>                
		<tbody>
		<tr>
		 	<th><b>구 분</b></th>
		 	<th><b>내 용</b></th>
	 	</tr>
	 	<tr>
		    <th><b>증권번호</b></th>
		    <td style="text-align: left;padding-left:5px;">		    	
		    	<input type="text" style="width: 90%;" id="policy_no" name="policy_no" value="${rptIssueMain.policyNo}"/>
		    </td>                    
		</tr>
	 	<tr>
		    <th><b>보험기간</b></th>
		    <td style="text-align: left;padding-left:5px;">
			    <input class="calendar" type="text" id="sdate" name="sdate" value="" style="width: 25%;"/>                    	
				    &nbsp;~&nbsp;
				<input class="calendar" type="text" id="edate" name="edate" value="" style="width: 25%;"/>				
		    </td>                    
		</tr>
		<tr>
		    <th><b>담 보 명</b></th>
		    <td style="text-align: left;padding-left:5px;">
		    	<input type="text" style="width: 90%;" id="guarantee_title" name="guarantee_title" value="${rptIssueMain.guaranteeTitle}"/>
		    </td>		                        
		</tr>	
		<tr>
		    <th><b>가입금액 (보상한도액)</b></th>
		    <td style="text-align: left;padding-left:5px;">		    	
		    	<input type="text" class="money" style="text-align:right;" id="amt_self_pay" name="amt_self_pay" value="${rptIssueMain.amtSelfPay}"/> 원
		   	</td>                    
		</tr>		
		<tr>
		    <th><b>자 기 부 담 금</b></th>
		    <td style="text-align: left;padding-left:5px;">		    	
		    	<input type="text" class="money" style="text-align:right;" id="amt_compensation_limit" name="amt_compensation_limit" value="${rptIssueMain.amtCompensationLimit}"/> 원
		   	</td>                    
		</tr>
		<tr>
		    <th><b>계약자 / 피보험자</b></th>
		    <td style="text-align: left;padding-left:5px;">
		    	<input type="text" style="width: 40%;" id="policyholder_nm" name="policyholder_nm" value="${suimVO.getPolicyholder_nm()}"/> / 	    
		    	<input type="text" style="width: 40%;" id="beneficiary_nm" name="beneficiary_nm" value="${suimVO.getBeneficiary_nm()}"/>		    
		    </td>                    
		</tr>
		<tr>
		    <th><b>소 재 지 ( 목 적 물 )</b></th>
		    <td style="text-align: left;padding-left:5px;">
		    	<input type="button" id="postCodeBtnRptUdt" value="우편번호 찾기">&nbsp;
				<input type="hidden" id="postcode_rptUdt" name="postcode_rptUdt" value="${ rptIssue.suimZipcode }"/>
				<input type="text" id="addr_rptUdt_1" name="addr_rptUdt_1" style="width: 72%" value="${ rptIssue.suimAddress }" readonly />
		    </td>                    
		</tr>
		<tr>
		    <th><b>사 고 접 수 번 호</b></th>
		    <td style="text-align: left;padding-left:5px;">
		    	<input type="text" style="width: 90%;" id="accident_no" name="accident_no" value="${rptIssueMain.accidentNo}"/>		    
		    </td>                    
		</tr>
	</table>
	</form>
</c:if>