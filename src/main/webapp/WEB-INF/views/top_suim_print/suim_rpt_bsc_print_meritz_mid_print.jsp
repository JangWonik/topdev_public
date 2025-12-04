<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<!DOCTYPE html>
<html>
<head>
    <title>보고서 상세</title>
    <link rel="stylesheet" type="text/css" href="../resources/wm_css/meritz_report.css?v=20171204"/>
</head>
<body>

<div class="reportWrap">
    <div class="reportContent">        
        
        <div style="margin-top:30px;">
        	<div class="text-center" style="margin-bottom: 30px;">
        		<b><font size="5" color="BLACK">메리츠화재(주) 중간보고서</font></b>
        	</div>
       	</div>
       	        
        <div class="display-table" style="margin-top: 30px;">
        	<div class="display-cell">
				<p class="subtitle">◆ 사고관련 사항</p>			
			</div>        	
        </div>
        	<table id=table_issue_contract_view>
        		<tr>
        			<th><b>사고번호</b></th>
        			<td>${reportBscInfo.accidentNo}</td>
        			<th><b>증권번호</b></th>
        			<td>${reportBscInfo.policyNo}</td>        			
        		</tr>
        		<tr>
        			<th><b>피보험자</b></th>
        			<td>${reportBscInfo.beneficiaryNm}</td>
        			<th><b>계 약 자</b></th>
        			<td>${reportBscInfo.policyholderNm}</td>
        		</tr>
        	</table>
        
        <div class="display-table" style="margin-top: 30px;">	    	    	
	        <div class="display-cell">
				<p class="subtitle">◆ 현장 진행사항</p>			
			</div>				       	
       	</div>
       	<table id=table_issue_contract_view>
			<tr>
				<th width="17%"><b>진행일자</b></th>
				<th width="17%"><b>대상자</b></th>
				<th width="16%"><b>접촉방법</b></th>
				<th width="50%"><b>진행내용</b></th>					
		   	</tr>
		   	
		   	<c:forEach items="${sagoList}" var="item" varStatus="status">   			
		   		<tr>
			   		<td>${item.controlDate}</td>
			   		<td>${item.controlWho}</td>
			   		<td>${item.controlContact}</td>
			   		<td style="text-align:left;padding-left:10px;">${item.controlMemo}</td>
			   	</tr>
		   	</c:forEach>
		   	<c:if test="${sagoList.size() == 0}">   			
		   		<tr>
					<td colspan="4">입력된 현장 진행사항이 없습니다.</td>
				</tr>
		   	</c:if>   		
		</table>
       	
       	<div class="display-table" style="margin-top: 30px;">	    	    	
	        <div class="display-cell">
				<p class="subtitle">◆ 특이사항 및 민원예방활동</p>			
			</div>				       	
       	</div>
       	<table id=table_issue_contract_view>   	
		   	<c:forEach items="${sagoMidList}" var="item" varStatus="status">   			
		   		<tr>
			   		<td style="text-align:left;padding-left:10px;padding-top:10px;padding-bottom:10px;">	   				   			
			   			${fn:replace(item.minwonActComment , CRLF , '<br/>')}	   			
			   		</td>
			   	</tr>
		   	</c:forEach>
		   	<c:if test="${sagoMidList.size() == 0}">   			
		   		<tr>
					<td height="100" style="text-align:left;padding-left:10px;">입력된 특이사항 및 민원예방활동 정보가 없습니다.</td>
				</tr>
		   	</c:if>	
		</table>
       	
       	<div class="display-table" style="margin-top: 30px;">	    	    	
	        <div class="display-cell">							
			</div>				       	
       	</div>
       	<div style="margin-top:10px;">
			<div class="text-center">
		    	<b><font size="3" color="BLACK">제출일 : ${fn:substring(reportDate,0,10)}</font></b>
		    	<img src="" width="20" style="vertical-align:middle;" />     	
			</div>
		</div>
       	
       	<div style="margin-top:10px;">
        	<div class="text-center">
        		<c:choose>
        			<c:when test="${empty reportInvgUser.userName}">조사자(처리담당자) 정보가 없습니다. 보고서 기본정보에서 입력해주세요.</c:when>
        			<c:when test="${empty userSignPath}">
        				<b><font size="3" color="BLACK">조사자 : ${reportInvgUser.userName}</font></b>
        			</c:when>
        			<c:otherwise>        				
    					<b><font size="3" color="BLACK">조사자 : ${reportInvgUser.userName}</font></b>    					        					
    					<img src="${userSignPath}" width="50" height="50" style="vertical-align:middle;" />        					        				        				
        			</c:otherwise>
        		</c:choose>
        	</div>
       	</div>
	</div>
</div>      

<script type="text/javascript">
    window.print();
</script>
</body>
</html>
