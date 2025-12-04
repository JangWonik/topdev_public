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
			<col width="10%">
			<col width="15%">
			<col width="75%">
		</colgroup>                
		<tbody>
		<tr>
		 	<th colspan="2"><b>구분</b></th>
		 	<th><b>계약사항</b></th>
	 	</tr>
	 	<tr>
		    <th colspan="2"><b>보험종목 / 증권번호</b></th>
		    <td style="text-align: left;padding-left:5px;">${rptIssueMain.insuranceNm} / ${rptIssueMain.policyNo}</td>                    
		</tr>   
		<tr>
			<th colspan="2"><b>계약자 / 피보험자</b></th>
			<td style="text-align: left;padding-left:5px;">${suimVO.getPolicyholder_nm()} / ${suimVO.getBeneficiary_nm()}</td>                    
		</tr>
		<c:if test="${ctype eq 'B' || ctype eq 'C'}">		                    
		<tr>
			<th colspan="2"><b>소재지</b></th>
			<td style="text-align: left;padding-left:5px;">						
			<span id="vAddress">${ rptIssue.suimAddress }</span><br/>					    
			</td>
		</tr>
		</c:if>
		<tr>
			<th colspan="2"><b>보험기간</b></th>
			<td style="text-align: left;padding-left:5px;"><span id="vInsuterm">${suimVO.insuTerm}</span></td>                    
		</tr>
		<c:if test="${ rowSpan eq 0 }">
	        <tr>
				<th rowspan="${rowSpan}">
				<b>
				<c:if test="${ctype eq 'C'}">
					보험<br/>목적물
				</c:if>
				<c:if test="${ctype eq 'B' || ctype eq 'T'}">
					계약약관
				</c:if>
				</b>						                	
				</th>
				<th>
				<b>-</b>						
				</th>
				<td  style="text-align: left;padding-left:5px;">-</td>										
			</tr>
		</c:if>				
		<c:forEach items="${rptIssueContList}" var="item" varStatus="status">
			<tr>
			<c:if test="${ status.index == 0 }">			
				<th rowspan="${rowSpan}">
					<b>
					<c:if test="${ctype eq 'C'}">
						보험<br/>목적물
					</c:if>
					<c:if test="${ctype eq 'B' || ctype eq 'T'}">
						계약약관
					</c:if>
					</b>						                	
				</th>
			</c:if>
			<th>
				<b>${ item.contCate }</b>						
			</th>                
			<td  style="text-align: left;padding-left:5px;">${ item.contContent }</td>										
			</tr>
		</c:forEach>
	</table>
</c:if>

<c:if test="${ cont_edit_type eq 'edit' }">
	<form name="contEditForm" id="contEditForm" method="post">
	<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suimVO.suim_rpt_no}">
	<input type="hidden" id="cont_edit_type" name="cont_edit_type" value="view">
	<input type="hidden" id="ctype" name="ctype" value="C">
	<table id="table_issue_contract_edit" style="border: 1px solid currentColor;">
		<colgroup>
			<col width="10%">
			<col width="15%">
			<col width="75%">
		</colgroup>                
		<tbody>
		<tr>
			<th colspan="2"><b>구분</b></th>
			<th><b>계약사항</b></th>
		</tr>
		<tr>
		    <th colspan="2"><b>보험종목 / 증권번호</b></th>
		    <td style="text-align: left;padding-left:5px;">${rptIssueMain.insuranceNm} / ${rptIssueMain.policyNo}</td>                    
		</tr>   
		<tr>
			<th colspan="2"><b>계약자 / 피보험자</b></th>
			<td style="text-align: left;padding-left:5px;">${suimVO.getPolicyholder_nm()} / ${suimVO.getBeneficiary_nm()}</td>                    
		</tr>
		<c:if test="${ctype eq 'B' || ctype eq 'C'}">                    
		<tr>
			<th colspan="2"><b>소재지</b></th>
			<td style="text-align: left;padding-left:5px;">                    	 
			<!-- 우편번호 : --><%-- <input type="text" id="postcode_rptUdt" style="width: 30%" value="${ rptIssue.suimZipcode }" readonly/> --%>													  
			<input type="hidden" id="postcode_rptUdt" style="width: 30%" value="${ rptIssue.suimZipcode }" />
			<input type="button" id="postCodeBtnRptUdt" value="우편번호 찾기">
			<input type="text" id="addr_rptUdt_1" style="width: 63%" value="${ rptIssue.suimAddress }" readonly />					    
	    	</td>
		</tr>
		</c:if>
		<tr>
			<th colspan="2"><b>보험기간</b></th>                    
			<td style="text-align: left;padding-left:5px;">
			<input class="calendar" type="text" id="sdate" name="sdate" value="" style="width: 25%;"/>                    	
			    &nbsp;~&nbsp;
			<input class="calendar" type="text" id="edate" name="edate" value="" style="width: 25%;"/>
			<input type="hidden" id = "insuTerm" />
			</td>
		</tr>
		<!-- 보험목적물 시작 -->
		<c:if test="${ rowSpan eq 0 }">
	    <tr name="cont_tr">
			<th rowspan="10">
				<b>
					<c:if test="${ctype eq 'C'}">
						보험<br/>목적물
					</c:if>
					<c:if test="${ctype eq 'B' || ctype eq 'T'}">
						계약약관
					</c:if>
				</b>
				<br/>
				<img src="./resources/ls_img/btn_add_s.gif" border="0" onclick="fnCont_add('${ctype}');" style="cursor:pointer;"/>									                	
			</th>
			<th>
				<input type="text" name="cont_cate" id="cont_cate" maxlength="7">
				<%-- <select name="cont_cate">					
					<c:if test="${ctype eq 'C'}">
						<option value="건물" selected>건물</option>
						<option value="기계">기계</option>
						<option value="동산">동산</option>
					</c:if>
					<c:if test="${ctype eq 'B'}">
						<option value="시설소유자배상" selected>시설소유자배상</option>
						<option value="주차장배상">주차장배상</option>
						<option value="물적확장특약">물적확장특약</option>
					</c:if>
					<c:if test="${ctype eq 'T'}">
						<option value="휴대품손해" selected>휴대품손해</option>						
					</c:if>
				</select> --%>						
			</th>														
				<td  style="text-align: left;padding-left:5px;">
					<input type="text" name="cont_content" value="" style="width:447px" maxlength="50">
				</td>
			</tr>
		</c:if>				
		<c:forEach items="${rptIssueContList}" var="item" varStatus="status">  
			<tr name="cont_tr">
				<c:if test="${ status.index == 0 }">
					<th rowspan="10">
					<b>
						<c:if test="${ctype eq 'C'}">
						보험<br/>목적물
						</c:if>
						<c:if test="${ctype eq 'B' || ctype eq 'T'}">
						계약약관
						</c:if>						
					</b>
					<br/>
					<img src="./resources/ls_img/btn_add_s.gif" border="0" onclick="fnCont_add('${ctype}');" style="cursor:pointer;"/>
					</th>
				</c:if>			
			<th>
				<input type="text" name="cont_cate" id="cont_cate" value="${item.contCate}" maxlength="7">
				<%-- <select name="cont_cate">
					<c:if test="${ctype eq 'C'}">
						<option value="건물" <c:if test="${ item.contCate eq '건물' }">selected</c:if> >건물</option>
						<option value="기계" <c:if test="${ item.contCate eq '기계' }">selected</c:if> >기계</option>
						<option value="동산" <c:if test="${ item.contCate eq '동산' }">selected</c:if> >동산</option>
					</c:if>
					<c:if test="${ctype eq 'B'}">
						<option value="시설소유자배상" <c:if test="${ item.contCate eq '시설소유자배상' }">selected</c:if> >시설소유자배상</option>
						<option value="주차장배상" <c:if test="${ item.contCate eq '주차장배상' }">selected</c:if> >주차장배상</option>
						<option value="물적확장특약" <c:if test="${ item.contCate eq '물적확장특약' }">selected</c:if> >물적확장특약</option>
					</c:if>
					<c:if test="${ctype eq 'T'}">
						<option value="휴대품손해"  <c:if test="${ item.contCate eq '휴대품손해' }">selected</c:if> >휴대품손해</option>						
					</c:if>
				</select> --%>
			</th>                
			<td  style="text-align: left;padding-left:5px;"><input type="text" name="cont_content" value="${ item.contContent }" style="width:447px" maxlength="50">
			<img src="./resources/ls_img/btn_del_s.gif" border="0" onclick="fnCont_del('${item.suimRptNo }','${item.contNo}');" style="cursor:pointer" /></td>
			</tr>
		</c:forEach>				
		<!-- 보험목적물 끝 -->		                                
		</tbody>
	</table>
	</form>
</c:if>