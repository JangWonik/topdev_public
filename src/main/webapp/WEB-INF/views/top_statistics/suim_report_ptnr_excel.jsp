<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%
    response.setHeader("Content-Disposition", "attachment; filename=statistics_team_"+pageContext.getAttribute("today")+".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>
<html>    
	<table cellpadding="0" cellspacing="0" width="1060" align="center" border="1">            
	    <tr> 
	    	<th rowspan="2">No</th>
	    	<th rowspan="2">보험사</th>               
	        <th rowspan="2">사고접수번호<br/>(보험사)</th>
	        <th rowspan="2">사고접수번호<br/>(top)</th>
	        <th rowspan="2">증권번호</th>
	        <th rowspan="2">보험종목</th>
	        <th rowspan="2">계약자</th>
	        <th rowspan="2">피보험자</th>
	        <th rowspan="2">피해자/물</th>
	        <th rowspan="2">사고일자</th>
	        <th rowspan="2">수임일자</th>
	        <th rowspan="2">최종서류접수일</th>
	        <th rowspan="2">종결일자</th>
	        <th rowspan="2">사고내용</th>
	        <th rowspan="2">손해사정서<br/>교부동의서</th>
	        <th colspan="4">손해사정서교부결과</th>                        
	    </tr>
	    <tr>            	       
	        <th>계약자</th>
	        <th>피보험자</th>
	        <th>보험청구권자</th>
	        <th>교부상태</th>                                                
	    </tr>
	    <c:if test="${ReportList.size() == 0 }">
	    <tr>
	    	<td colspan="19">조회결과가 없습니다.</td>
	    </tr>
	    </c:if>
	    <c:forEach var="vo" items="${ReportList}" varStatus="status">
	        <tr>
	        	<td>${ReportList.size() - status.index}</td>
	        	<td>${vo.ptnrNick}</td>                    
	            <td>${vo.accidentNo}</td>
	            <td>${vo.suimAcceptNo}</td>
	            <td style="mso-number-format:'\@';">${vo.policyNo }</td>
	            <td>${vo.suimRptType1Nm}</td>
	            <td>${vo.policyholderNm}</td>
	            <td>${vo.beneficiaryNm}</td>
	            <td>${vo.damagedNm}</td>
	            <td>${vo.accidentDate}</td>
	            <td>${vo.regDate}</td>
	            <td></td>
	            <td>${vo.closeDate}</td>
	            <td title="${vo.accidentFacts}">${fn:substring(vo.accidentFacts,0,10)}</td>                    
	            <td>
	            	<c:if test="${vo.fileChk eq 0}"><font color="red">미교부</font></c:if>
	            	<c:if test="${vo.fileChk eq 1}"><font color="blue">교부</font></c:if>
	            </td>
	            <td>
	            	<c:choose>                    		
	            		<c:when test="${vo.conMethod eq 'mobile'}"><font color="green">휴대폰교부</font></c:when>
	            		<c:when test="${vo.conMethod eq 'fax'}"><font color="green">팩스교부</font></c:when>
	            		<c:when test="${vo.conMethod eq 'email'}"><font color="green">이메일교부</font></c:when>
	            		<c:when test="${vo.conMethod eq 'disagree'}"><font color="orange">비 동의</font></c:when>
	            		<c:when test="${vo.conMethod eq ''}">미교부</c:when>
                    	<c:otherwise>2건 이상</c:otherwise>
	            	</c:choose>                    
	            </td>
	            <td>
	            	<c:choose>                    		
	            		<c:when test="${vo.insMethod eq 'mobile'}"><font color="green">휴대폰교부</font></c:when>
	            		<c:when test="${vo.insMethod eq 'fax'}"><font color="green">팩스교부</font></c:when>
	            		<c:when test="${vo.insMethod eq 'email'}"><font color="green">이메일교부</font></c:when>
	            		<c:when test="${vo.insMethod eq 'disagree'}"><font color="orange">비 동의</font></c:when>                    		
	            		<c:when test="${vo.insMethod eq ''}">미교부</c:when>
                    	<c:otherwise>2건 이상</c:otherwise>
	            	</c:choose>                    
	            </td>
	            <td>
	            	<c:choose>                    		
	            		<c:when test="${vo.claMethod eq 'mobile'}"><font color="green">휴대폰교부</font></c:when>
	            		<c:when test="${vo.claMethod eq 'fax'}"><font color="green">팩스교부</font></c:when>
	            		<c:when test="${vo.claMethod eq 'email'}"><font color="green">이메일교부</font></c:when>
	            		<c:when test="${vo.claMethod eq 'disagree'}"><font color="orange">비 동의</font></c:when>                    		
	            		<c:when test="${vo.claMethod eq ''}">미교부</c:when>
                    	<c:otherwise>2건 이상</c:otherwise>                    		
	            	</c:choose>
	            </td>                    
	            <td>                    	
	            	<c:if test="${vo.compCnt eq 0}"><font color="red">미완료</font></c:if>
	            	<c:if test="${vo.compCnt eq 1}"><font color="blue">완료</font></c:if>                    	
	            </td>                    
	        </tr>                
	    </c:forEach>
	</table>    
</html>