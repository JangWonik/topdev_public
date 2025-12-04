<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="tableStyle2">
    <div style="background: #e7ecf1;<c:if test='${MemberList.size() > 21}'>padding-right: 17px;</c:if>">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
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
            </colgroup>
            <thead>
            <tr>
                <th rowspan="2">팀</th>
                <th rowspan="2">이름</th>
                <th rowspan="2">구분</th>
                <th rowspan="2">접수번호</th>
                <th rowspan="2">종결번호</th>
                <th rowspan="2">보험사</th>
                <th rowspan="2">보험팀</th>
                <th rowspan="2">보험담당</th>
                <th rowspan="2">처리팀</th>
                <th rowspan="2">계약자</th>
                <th rowspan="2">피보험자</th>
                <th rowspan="2">피해자</th>
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
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
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
                        <td rowspan="${ReportList.size()}">
                        <a href="javascript:goTeamMember('${team_id}','${team_name}','${team_type}');">
                        <c:if test="${team_name eq ''}">${vo.teamName}</c:if>
                        ${team_name}
                        </a>
                        </td>                        
                    </c:if>
                    <td>${vo.userName}</td>
                    <td>${vo.suimRptType1Nm}</td>
                    <td><a href="javascript:viewPopup('${vo.suimRptNo}','${vo.delDate}')">${vo.suimAcceptNo}</a></td>
                    <td><a href="javascript:viewPopup('${vo.suimRptNo}','${vo.delDate}')">${vo.suimCloseNo}</a></td>
                    <td>${vo.ptnrNick}</td>
                    <td>${vo.ptnrDeptNm}</td>
                    <td>${vo.ptnrMbrNm}</td>
                    <td>${vo.teamName}</td>
                    <td>${vo.policyholderNm}</td>
                    <td>${vo.beneficiaryNm}</td>
                    <td>${vo.damagedNm}</td>
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
                    	<a href="javascript:viewPopup('${vo.suimRptNo}','${vo.delDate}')">
                    	<c:if test="${vo.compCnt eq 0}"><font color="red">미완료</font></c:if>
                    	<c:if test="${vo.compCnt eq 1}"><font color="blue">완료</font></c:if>
                    	</a>
                    </td>                    
                </tr>                
            </c:forEach>            
            </tbody>
        </table>
    </div>
</div>