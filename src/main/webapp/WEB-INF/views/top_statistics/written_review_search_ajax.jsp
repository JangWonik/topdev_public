<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<c:choose>
	<%-- 전체목록인 경우 --%>
	<c:when test="${empty s_team_id }">
		<c:forEach var="teams" items="${teamList}" varStatus="status">
		<div style="float: left;padding:10px 0 10px;"><img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" >
		&nbsp;<b>${teams.teamName}</b>
		</div>
			<table>
				<c:set var="totalYearEa" value="0"/>
				<c:set var="total_bmSuimCnt" value="0"/>
				<c:set var="total_tmSuimCnt" value="0"/>								
				<c:set var="total_cmSuimCnt" value="0"/>								
				<c:set var="total_bwSuimCnt" value="0"/>
				<c:set var="total_twSuimCnt" value="0"/>				
				<c:set var="total_cwSuimCnt" value="0"/>
				
				<c:set var="total_bmEndCnt" value="0"/>
				<c:set var="total_tmEndCnt" value="0"/>								
				<c:set var="total_cmEndCnt" value="0"/>								
				<c:set var="total_bwEndCnt" value="0"/>
				<c:set var="total_twEndCnt" value="0"/>				
				<c:set var="total_cwEndCnt" value="0"/>
				
				<c:set var="total_bmUnsolveCnt" value="0"/>
				<c:set var="total_tmUnsolveCnt" value="0"/>								
				<c:set var="total_cmUnsolveCnt" value="0"/>								
				<c:set var="total_bwUnsolveCnt" value="0"/>
				<c:set var="total_twUnsolveCnt" value="0"/>				
				<c:set var="total_cwUnsolveCnt" value="0"/>
				<tr>									
					<th rowspan="2" width="10%">부서명</th>
					<th rowspan="2" width="9%">담당자명</th>
					<th rowspan="2" width="6%">직급</th>
					<!-- <th rowspan="2" width="4%">표준업무</th> -->
					<th colspan="6" width="25%">배당(접수) 건수</th>
					<th colspan="6" width="25%">처리 건수</th>
					<th colspan="6" width="25%">미결 건수</th>									
				</tr>
				<tr>
					<th>전월</th>
					<th>당월</th>
					<th>증감</th>
					<th>전주</th>
					<th>금주</th>
					<th>증감</th>
					
					<th>전월</th>
					<th>당월</th>
					<th>증감</th>
					<th>전주</th>
					<th>금주</th>
					<th>증감</th>
					
					<th>전월</th>
					<th>당월</th>
					<th>증감</th>
					<th>전주</th>
					<th>금주</th>
					<th>증감</th>
				</tr>
			</table>
			<table>
			<c:forEach var="items" items="${writtenList}" varStatus="status">
				<c:if test="${teams.teamId eq items.teamId}">
					<tr>
						<td width="10%" align="center">${items.teamName}</td>
						<td width="9%" align="center">${items.userName}</td>
						<td width="6%" align="center">${items.workLevelCd}</td>
						<%-- <td width="4%" align="right" style="padding-right:5px;">
							<fmt:formatNumber value="${items.yearEa}" pattern="0.0"/>
						</td> --%>						
						<td align="right" style="padding-right:5px;">${items.bmSuimCnt}</td>
						<td align="right" style="padding-right:5px;">${items.tmSuimCnt}</td>
						<c:set var="cmSuimCnt" value="${items.tmSuimCnt - items.bmSuimCnt}"/>						
						<td align="right" style="padding-right:5px;">
							<c:choose>
								<c:when test="${cmSuimCnt < 0}"><font color="red">${cmSuimCnt}</font></c:when>
								<c:otherwise>${cmSuimCnt}</c:otherwise>
							</c:choose>							
						</td>
						<td align="right" style="padding-right:5px;">${items.bwSuimCnt}</td>
						<td align="right" style="padding-right:5px;">${items.twSuimCnt}</td>
						<c:set var="cwSuimCnt" value="${items.twSuimCnt - items.bwSuimCnt}"/>
						<td align="right" style="padding-right:5px;">
							<c:choose>
								<c:when test="${cwSuimCnt < 0}"><font color="red">${cwSuimCnt}</font></c:when>
								<c:otherwise>${cwSuimCnt}</c:otherwise>
							</c:choose>							
						</td>
						<td align="right" style="padding-right:5px;">${items.bmEndCnt}</td>
						<td align="right" style="padding-right:5px;">${items.tmEndCnt}</td>
						<c:set var="cmEndCnt" value="${items.tmEndCnt - items.bmEndCnt}"/>
						<td align="right" style="padding-right:5px;">
							<c:choose>
								<c:when test="${cmEndCnt < 0}"><font color="red">${cmEndCnt}</font></c:when>
								<c:otherwise>${cmEndCnt}</c:otherwise>
							</c:choose>							
						</td>						
						<td align="right" style="padding-right:5px;">${items.bwEndCnt}</td>
						<td align="right" style="padding-right:5px;">${items.twEndCnt}</td>
						<c:set var="cwEndCnt" value="${items.twEndCnt - items.bwEndCnt}"/>
						<td align="right" style="padding-right:5px;">
							<c:choose>
								<c:when test="${cwEndCnt < 0}"><font color="red">${cwEndCnt}</font></c:when>
								<c:otherwise>${cwEndCnt}</c:otherwise>
							</c:choose>							
						</td>
						<td align="right" style="padding-right:5px;">${items.bmUnsolveCnt}</td>
						<td align="right" style="padding-right:5px;">${items.tmUnsolveCnt}</td>
						<c:set var="cmUnsolveCnt" value="${items.tmUnsolveCnt - items.bmUnsolveCnt}"/>
						<td align="right" style="padding-right:5px;">
							<c:choose>
								<c:when test="${cmUnsolveCnt < 0}"><font color="red">${cmUnsolveCnt}</font></c:when>
								<c:otherwise>${cmUnsolveCnt}</c:otherwise>
							</c:choose>							
						</td>						
						<td align="right" style="padding-right:5px;">${items.bwUnsolveCnt}</td>
						<td align="right" style="padding-right:5px;">${items.twUnsolveCnt}</td>
						<c:set var="cwUnsolveCnt" value="${items.twUnsolveCnt - items.bwUnsolveCnt}"/>
						<td align="right" style="padding-right:5px;">
							<c:choose>
								<c:when test="${cwUnsolveCnt < 0}"><font color="red">${cwUnsolveCnt}</font></c:when>
								<c:otherwise>${cwUnsolveCnt}</c:otherwise>
							</c:choose>							
						</td>											
					</tr>
					<c:set var="totalYearEa" value="${totalYearEa+items.yearEa}"/>
					
					<c:set var="total_bmSuimCnt" value="${total_bmSuimCnt+items.bmSuimCnt}"/>
					<c:set var="total_tmSuimCnt" value="${total_tmSuimCnt+items.tmSuimCnt}"/>
					<c:set var="total_cmSuimCnt" value="${total_cmSuimCnt+cmSuimCnt}"/>
					<c:set var="total_bwSuimCnt" value="${total_bwSuimCnt+items.bwSuimCnt}"/>
					<c:set var="total_twSuimCnt" value="${total_twSuimCnt+items.twSuimCnt}"/>
					<c:set var="total_cwSuimCnt" value="${total_cwSuimCnt+cwSuimCnt}"/>
					
					<c:set var="total_bmEndCnt" value="${total_bmEndCnt+items.bmEndCnt}"/>
					<c:set var="total_tmEndCnt" value="${total_tmEndCnt+items.tmEndCnt}"/>
					<c:set var="total_cmEndCnt" value="${total_cmEndCnt+cmEndCnt}"/>
					<c:set var="total_bwEndCnt" value="${total_bwEndCnt+items.bwEndCnt}"/>
					<c:set var="total_twEndCnt" value="${total_twEndCnt+items.twEndCnt}"/>
					<c:set var="total_cwEndCnt" value="${total_cwEndCnt+cwEndCnt}"/>
					
					<c:set var="total_bmUnsolveCnt" value="${total_bmUnsolveCnt+items.bmUnsolveCnt}"/>
					<c:set var="total_tmUnsolveCnt" value="${total_tmUnsolveCnt+items.tmUnsolveCnt}"/>
					<c:set var="total_cmUnsolveCnt" value="${total_cmUnsolveCnt+cmUnsolveCnt}"/>
					<c:set var="total_bwUnsolveCnt" value="${total_bwUnsolveCnt+items.bwUnsolveCnt}"/>
					<c:set var="total_twUnsolveCnt" value="${total_twUnsolveCnt+items.twUnsolveCnt}"/>
					<c:set var="total_cwUnsolveCnt" value="${total_cwUnsolveCnt+cwUnsolveCnt}"/>					
				</c:if>			
			</c:forEach>			
				<tr>
					<th width="25%" colspan="3">합 계</th>
					<%-- <td align="right" style="padding-right:5px;"><font color="blue"><b><fmt:formatNumber value="${totalYearEa}" pattern="0.0"/></b></font></td> --%>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_bmSuimCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_tmSuimCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_cmSuimCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_bwSuimCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_twSuimCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_cwSuimCnt}</b></font></td>
					
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_bmEndCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_tmEndCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_cmEndCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_bwEndCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_twEndCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_cwEndCnt}</b></font></td>
					
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_bmUnsolveCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_tmUnsolveCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_cmUnsolveCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_bwUnsolveCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_twUnsolveCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_cwUnsolveCnt}</b></font></td>										
				</tr>
			</table>						
			<br/>
		</c:forEach>		
	</c:when>
	<%-- 특정 팀만 가져오는 경우 --%>
	<c:otherwise>
		<div style="float: left;padding:10px 0 10px;"><img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" >
		&nbsp;<b>${teamName}</b>
		</div>
		<table>
			<tr>									
				<th rowspan="2" width="10%">부서명</th>
				<th rowspan="2" width="9%">담당자명</th>
				<th rowspan="2" width="6%">직급</th>
				<!-- <th rowspan="2" width="4%">표준업무</th> -->
				<th colspan="6" width="25%">배당(접수) 건수</th>
				<th colspan="6" width="25%">처리 건수</th>
				<th colspan="6" width="25%">미결 건수</th>									
			</tr>
			<tr>
				<th>전월</th>
				<th>당월</th>
				<th>증감</th>
				<th>전주</th>
				<th>금주</th>
				<th>증감</th>
				
				<th>전월</th>
				<th>당월</th>
				<th>증감</th>
				<th>전주</th>
				<th>금주</th>
				<th>증감</th>
				
				<th>전월</th>
				<th>당월</th>
				<th>증감</th>
				<th>전주</th>
				<th>금주</th>
				<th>증감</th>
			</tr>
		</table>
		<c:choose>
			<c:when test="${writtenList.size() == 0}">
			<table>
				<tr>
					<td colspan="22" align="center">조회결과값이 없습니다.</td>
				</tr>
			</table>			
		</c:when>
		<c:otherwise>			
			<input type="hidden" id="written_total_size" value="${writtenList.size()}"/>			
			<table>	
				<c:set var="totalYearEa" value="0"/>
				<c:set var="total_bmSuimCnt" value="0"/>
				<c:set var="total_tmSuimCnt" value="0"/>								
				<c:set var="total_cmSuimCnt" value="0"/>								
				<c:set var="total_bwSuimCnt" value="0"/>
				<c:set var="total_twSuimCnt" value="0"/>				
				<c:set var="total_cwSuimCnt" value="0"/>
				
				<c:set var="total_bmEndCnt" value="0"/>
				<c:set var="total_tmEndCnt" value="0"/>								
				<c:set var="total_cmEndCnt" value="0"/>								
				<c:set var="total_bwEndCnt" value="0"/>
				<c:set var="total_twEndCnt" value="0"/>				
				<c:set var="total_cwEndCnt" value="0"/>
				
				<c:set var="total_bmUnsolveCnt" value="0"/>
				<c:set var="total_tmUnsolveCnt" value="0"/>								
				<c:set var="total_cmUnsolveCnt" value="0"/>								
				<c:set var="total_bwUnsolveCnt" value="0"/>
				<c:set var="total_twUnsolveCnt" value="0"/>				
				<c:set var="total_cwUnsolveCnt" value="0"/>	
				
				<c:forEach var="items" items="${writtenList}" varStatus="status">				
					<tr>
						<td width="10%" align="center">${items.teamName}</td>
						<td width="9%" align="center">${items.userName}</td>
						<td width="6%" align="center">${items.workLevelCd}</td>
						<%-- <td width="4%" align="right" style="padding-right:5px;">
							<fmt:formatNumber value="${items.yearEa}" pattern="0.0"/>
						</td> --%>						
						<td align="right" style="padding-right:5px;">${items.bmSuimCnt}</td>
						<td align="right" style="padding-right:5px;">${items.tmSuimCnt}</td>
						<c:set var="cmSuimCnt" value="${items.tmSuimCnt - items.bmSuimCnt}"/>						
						<td align="right" style="padding-right:5px;">
							<c:choose>
								<c:when test="${cmSuimCnt < 0}"><font color="red">${cmSuimCnt}</font></c:when>
								<c:otherwise>${cmSuimCnt}</c:otherwise>
							</c:choose>							
						</td>
						<td align="right" style="padding-right:5px;">${items.bwSuimCnt}</td>
						<td align="right" style="padding-right:5px;">${items.twSuimCnt}</td>
						<c:set var="cwSuimCnt" value="${items.twSuimCnt - items.bwSuimCnt}"/>
						<td align="right" style="padding-right:5px;">
							<c:choose>
								<c:when test="${cwSuimCnt < 0}"><font color="red">${cwSuimCnt}</font></c:when>
								<c:otherwise>${cwSuimCnt}</c:otherwise>
							</c:choose>							
						</td>
						<td align="right" style="padding-right:5px;">${items.bmEndCnt}</td>
						<td align="right" style="padding-right:5px;">${items.tmEndCnt}</td>
						<c:set var="cmEndCnt" value="${items.tmEndCnt - items.bmEndCnt}"/>
						<td align="right" style="padding-right:5px;">
							<c:choose>
								<c:when test="${cmEndCnt < 0}"><font color="red">${cmEndCnt}</font></c:when>
								<c:otherwise>${cmEndCnt}</c:otherwise>
							</c:choose>							
						</td>						
						<td align="right" style="padding-right:5px;">${items.bwEndCnt}</td>
						<td align="right" style="padding-right:5px;">${items.twEndCnt}</td>
						<c:set var="cwEndCnt" value="${items.twEndCnt - items.bwEndCnt}"/>
						<td align="right" style="padding-right:5px;">
							<c:choose>
								<c:when test="${cwEndCnt < 0}"><font color="red">${cwEndCnt}</font></c:when>
								<c:otherwise>${cwEndCnt}</c:otherwise>
							</c:choose>							
						</td>
						<td align="right" style="padding-right:5px;">${items.bmUnsolveCnt}</td>
						<td align="right" style="padding-right:5px;">${items.tmUnsolveCnt}</td>
						<c:set var="cmUnsolveCnt" value="${items.tmUnsolveCnt - items.bmUnsolveCnt}"/>
						<td align="right" style="padding-right:5px;">
							<c:choose>
								<c:when test="${cmUnsolveCnt < 0}"><font color="red">${cmUnsolveCnt}</font></c:when>
								<c:otherwise>${cmUnsolveCnt}</c:otherwise>
							</c:choose>							
						</td>						
						<td align="right" style="padding-right:5px;">${items.bwUnsolveCnt}</td>
						<td align="right" style="padding-right:5px;">${items.twUnsolveCnt}</td>
						<c:set var="cwUnsolveCnt" value="${items.twUnsolveCnt - items.bwUnsolveCnt}"/>
						<td align="right" style="padding-right:5px;">
							<c:choose>
								<c:when test="${cwUnsolveCnt < 0}"><font color="red">${cwUnsolveCnt}</font></c:when>
								<c:otherwise>${cwUnsolveCnt}</c:otherwise>
							</c:choose>							
						</td>					
					</tr>
					<c:set var="totalYearEa" value="${totalYearEa+items.yearEa}"/>
					
					<c:set var="total_bmSuimCnt" value="${total_bmSuimCnt+items.bmSuimCnt}"/>
					<c:set var="total_tmSuimCnt" value="${total_tmSuimCnt+items.tmSuimCnt}"/>
					<c:set var="total_cmSuimCnt" value="${total_cmSuimCnt+cmSuimCnt}"/>
					<c:set var="total_bwSuimCnt" value="${total_bwSuimCnt+items.bwSuimCnt}"/>
					<c:set var="total_twSuimCnt" value="${total_twSuimCnt+items.twSuimCnt}"/>
					<c:set var="total_cwSuimCnt" value="${total_cwSuimCnt+cwSuimCnt}"/>
					
					<c:set var="total_bmEndCnt" value="${total_bmEndCnt+items.bmEndCnt}"/>
					<c:set var="total_tmEndCnt" value="${total_tmEndCnt+items.tmEndCnt}"/>
					<c:set var="total_cmEndCnt" value="${total_cmEndCnt+cmEndCnt}"/>
					<c:set var="total_bwEndCnt" value="${total_bwEndCnt+items.bwEndCnt}"/>
					<c:set var="total_twEndCnt" value="${total_twEndCnt+items.twEndCnt}"/>
					<c:set var="total_cwEndCnt" value="${total_cwEndCnt+cwEndCnt}"/>
					
					<c:set var="total_bmUnsolveCnt" value="${total_bmUnsolveCnt+items.bmUnsolveCnt}"/>
					<c:set var="total_tmUnsolveCnt" value="${total_tmUnsolveCnt+items.tmUnsolveCnt}"/>
					<c:set var="total_cmUnsolveCnt" value="${total_cmUnsolveCnt+cmUnsolveCnt}"/>
					<c:set var="total_bwUnsolveCnt" value="${total_bwUnsolveCnt+items.bwUnsolveCnt}"/>
					<c:set var="total_twUnsolveCnt" value="${total_twUnsolveCnt+items.twUnsolveCnt}"/>
					<c:set var="total_cwUnsolveCnt" value="${total_cwUnsolveCnt+cwUnsolveCnt}"/>				
														
				</c:forEach>
				<tr>
					<th width="25%" colspan="3">합 계</th>
					<%-- <td align="right" style="padding-right:5px;"><font color="blue"><b><fmt:formatNumber value="${totalYearEa}" pattern="0.0"/></b></font></td> --%>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_bmSuimCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_tmSuimCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_cmSuimCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_bwSuimCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_twSuimCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_cwSuimCnt}</b></font></td>
					
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_bmEndCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_tmEndCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_cmEndCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_bwEndCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_twEndCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_cwEndCnt}</b></font></td>
					
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_bmUnsolveCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_tmUnsolveCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_cmUnsolveCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_bwUnsolveCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_twUnsolveCnt}</b></font></td>
					<td align="right" style="padding-right:5px;"><font color="blue"><b>${total_cwUnsolveCnt}</b></font></td>										
				</tr>
			</table>
		</c:otherwise>		
		</c:choose>
	</c:otherwise>
</c:choose>

<script>
$(document).ready(function(){
	$("#top_loading").hide();	
});
</script>