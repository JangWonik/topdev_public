<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="tableStyle2" id="area_excel">
    <div style="padding-right: 17px;background: #e7ecf1;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center" border="1">
            <colgroup>
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">                
            </colgroup>
            <thead>
            <tr>
                <th rowspan="2">보험사명</th>
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
            </thead>
        </table>
    </div>
    <div style="height:654px; overflow-x: hidden; overflow-y: auto;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center" border="1">
            <colgroup>
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
            </colgroup>
            <tbody>
            <input type="hidden" id="totCnt" value="${ReportList.size()}"/>
            <c:if test="${ReportList.size() == 0 }">
            <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
            	<td colspan="16">조회결과가 없습니다.</td>
            </tr>
            </c:if>
            <c:forEach var="vo" items="${ReportList}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${ReportList.size()}">	${vo.ptnrNick}</td>                        
                    </c:if>
                    <td style="mso-number-format:'\@';">${vo.accidentNo}</td>
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
                    <td>${vo.accidentFacts}</td>
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
                    		<c:otherwise>미교부</c:otherwise>                    		
                    	</c:choose>                    
                    </td>
                    <td>
                    	<c:choose>                    		
                    		<c:when test="${vo.insMethod eq 'mobile'}"><font color="green">휴대폰교부</font></c:when>
                    		<c:when test="${vo.insMethod eq 'fax'}"><font color="green">팩스교부</font></c:when>
                    		<c:when test="${vo.insMethod eq 'email'}"><font color="green">이메일교부</font></c:when>
                    		<c:when test="${vo.insMethod eq 'disagree'}"><font color="orange">비 동의</font></c:when>                    		
                    		<c:otherwise>미교부</c:otherwise>                    		
                    	</c:choose>                    
                    </td>
                    <td>
                    	<c:choose>                    		
                    		<c:when test="${vo.claMethod eq 'mobile'}"><font color="green">휴대폰교부</font></c:when>
                    		<c:when test="${vo.claMethod eq 'fax'}"><font color="green">팩스교부</font></c:when>
                    		<c:when test="${vo.claMethod eq 'email'}"><font color="green">이메일교부</font></c:when>
                    		<c:when test="${vo.claMethod eq 'disagree'}"><font color="orange">비 동의</font></c:when>                    		
                    		<c:otherwise>미교부</c:otherwise>                    		
                    	</c:choose>
                    </td>                    
                    <td>                    	
                    	<c:if test="${vo.compCnt eq 0}"><font color="red">미완료</font></c:if>
                    	<c:if test="${vo.compCnt eq 1}"><font color="blue">완료</font></c:if>                    	
                    </td>                    
                </tr>                
            </c:forEach>            
            </tbody>
        </table>
    </div>
</div>