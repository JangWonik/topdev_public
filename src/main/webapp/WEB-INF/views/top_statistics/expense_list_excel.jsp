<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%
    response.setHeader("Content-Disposition", "attachment; filename=expense_list_"+pageContext.getAttribute("today")+".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
    <div class="tableStyle2" id="area_excel">
    	<div style="padding-right: 17px;background: #e7ecf1;">        
            <div class="contetns2">
                <div class="center_cnt2">                    
                    <%--본문 영역--%>
                    <div class="centercnt_bot2">
                        <div class="guest">
                            <div class="guestTap">                                
                            	<!-- 내용 테이블 시작 -->
								<div class="tableStyle2">
								    <table cellpadding="0" cellspacing="0" width="1060" align="center" border="1">								        
								        <tr>
								        	<th class="border-right" rowspan="2">센터명</th>
								        	<th class="border-right" rowspan="2">팀명</th>
								            <th class="border-right" rowspan="2">이름</th>
								            <th class="border-right" rowspan="2">직급</th>								            
								            <th class="border-right" rowspan="2">평균팀원</th>								            
								            <th class="border-right" rowspan="2">간접비</th>
								            <th class="border-right" rowspan="2">수수료매출</th>
								            <th class="border-right" colspan="4">기준업무량</th>
								            <th class="border-right" colspan="3">기준업무량(예외처리)</th>
								         	<th class="border-right" colspan="3">일비</th>	      
								         	<th class="border-right" rowspan="2">센터품질<br/>관리비</th>
								         	<th class="border-right" rowspan="2">서면심사<br/>(물보험서면심사외)</th>
								         	<th class="border-right" rowspan="2">양식보험<br/>승선지원비</th>
								         	<th class="border-right" rowspan="2">가축재해<br/>이재조사비</th>
								         	<th class="border-right" rowspan="2">교통비</th>
								         	<th class="border-right" colspan="4">수동입력항목 (클릭시입력가능)</th>      
								        </tr>								        
								        <tr>
								        	<th class="border-right">년 목표</th>
								        	<th class="border-right">월 목표</th>
								        	<th class="border-right">월 달성량</th>
								        	<th class="border-right">월 달성율</th>
								        	<th class="border-right">서면심사(WC)</th>
								        	<th class="border-right">서면심사<br/>(맥도날드)</th>
								        	<th class="border-right">서면심사<br/>(스마트스코어)</th>								        	
								        	<th class="border-right">당월종결</th>
								        	<th class="border-right">공동실적</th>
								        	<th class="border-right">합계</th>
								        	<th class="border-right">농협보험<br/>이재조사비</th>
								        	<th class="border-right">파견수당</th>
								        	<th class="border-right">품위유지비</th>
								        	<th class="border-right">차감액</th>								        	
								        </tr>
								        <c:choose>
								        	<c:when test="${expenseList.size() eq 0}">
								        		<tr>
										        		<td class="border-right" colspan="25">
										        			<a href="javascript:goExpenseMain();">
										        			${baseYear}년 ${baseMonth}월 이재조사비 정보가 없습니다. 작업페이지로 이동하여 데이터를 갱신해주세요. [클릭]
										        			</a>
										        		</td>
										        </tr>
								        	</c:when>
								        	<c:otherwise>
								        		<c:forEach var="items" items="${expenseList}" varStatus="status">
										        	<c:choose>
								                		<c:when test="${items.workType eq 14}"><tr bgcolor="orange"></c:when>
								                		<c:when test="${items.workType eq 3}"><tr bgcolor="yellow"></c:when>
								                		<c:otherwise><tr></c:otherwise>
								                	</c:choose>								        	
										        		<td class="border-right">${items.centerName}</td>
										                <td class="border-right">${items.teamName}</td>
										                <td class="border-right">${items.userName}</td>
										                <td class="border-right">${items.workLevelNm}</td>										                
										                <td class="border-right">										                
										                ${items.memberAvg}								                	
										                </td>
										                <td class="border-right">${items.insideCost}</td>
										                <td class="border-right">${items.sumAmtBasic}</td>										                
										                <td class="border-right">${items.workloadYear}</td>
										                <td class="border-right">${items.workloadMonth}</td>
										                <td class="border-right">${items.workloadCal}</td>
										                <td class="border-right">${items.workloadPer}</td>
										                <td class="border-right">${items.wcCost}</td>
										                <td class="border-right">${items.mcCost}</td>
										                <td class="border-right">${items.ssCost}</td>
										                <td class="border-right">${items.amtDaily}</td>
										                <td class="border-right">${items.shareAmtDaily}</td>
										                <td class="border-right">${items.sumAmtDaily}</td>
										                <td class="border-right">${items.centerManageCost}</td>
										                <td class="border-right">${items.extraCost}</td>
										                <td class="border-right">${items.suhypCost}</td>
										                <td class="border-right">${items.cowCost}</td>
										                <td class="border-right">${items.trafficCost}</td>
										                <td class="border-right">${items.nonghypCost}</td>
										                <td class="border-right">${items.dispatchCost}</td>
										                <td class="border-right">${items.eleganceCost}</td>
										                <td class="border-right">${items.deductionCost}</td>										                
													</tr>
										        </c:forEach>
								        	</c:otherwise>
								        </c:choose>								        								        								        
								    </table>
								</div>                            	
                            </div>
                        </div>
                    </div>
                    <!-- 내용 테이블 끝 -->
                </div>
            </div>
        </div>        
    </div>
</body>
</html>