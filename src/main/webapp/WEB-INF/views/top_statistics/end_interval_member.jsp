<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2">
    <div style="padding-right: 17px; background: #e7ecf1;">
        <table>
            <tr>
                <th>센터명</th>
            	<th>팀명</th>
            	<th>이름</th>
            	<th>평균처리일</th>
            	<th>종결건수</th>
            	<!-- <th>전체처리일</th> -->
            </tr>            
        </table>
    </div>
    <div style="height:630px; overflow-x: hidden; overflow-y: auto;">
        <table>            
            <c:forEach var="member" items="${memberList}" varStatus="status">            	
                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                	<td width="100px">${member.center_name}</td>
                	<td width="100px">${member.team_name}</td>
                	<td width="100px">${member.user_name}</td>
                	<td width="100px"><font color="blue">${member.end_average_cnt}</font></td>
                	<td width="100px">${member.all_end_total_cnt}</td>
                	<%-- <td width="100px">${member.all_total_period_date}</td> --%>
                	<c:set var="sum_end_average_cnt" value="${sum_end_average_cnt + member.end_average_cnt}"/>
                	<c:set var="sum_all_end_total_cnt" value="${sum_all_end_total_cnt + member.all_end_total_cnt}"/>
                	<c:set var="sum_all_total_period_date" value="${sum_all_total_period_date + member.all_total_period_date}"/>                	                	
                </tr>
			</c:forEach>
			<tr>
				<th colspan="3">합계</th>
				<c:choose>
					<c:when test="${member.all_end_total_cnt == 0}">
						<th>0</th>
						<th>0</th>
						<!-- <th>0</th> -->
					</c:when>
					<c:otherwise>
						<th>
							<font color="blue">
								<fmt:formatNumber value="${sum_end_average_cnt / memberList.size()}" pattern="#,###"/>
							</font>
						</th>
						<th>${sum_all_end_total_cnt }</th>
						<%-- <th>${sum_all_total_period_date}</th> --%>
					</c:otherwise>
				</c:choose>				
			</tr>
        </table>
    </div>
</div>