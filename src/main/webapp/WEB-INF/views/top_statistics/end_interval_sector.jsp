<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2">
    <div style="background: #e7ecf1;">
        <table>
            <tr>
                <th>부문명</th>            	            	
            	<th>평균처리일</th>
            	<th>종결건수</th>
            	<!-- <th>전체처리일</th> -->
            </tr>            
        </table>
    </div>
    <div style="height:630px; overflow-x: hidden; overflow-y: auto;">
        <table>            
            <c:forEach var="sector" items="${sectorList}" varStatus="status">            	
                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                	<td width="100px">${sector.sector_name}</td>                	                	
                	<td width="100px"><font color="blue">${sector.end_average_cnt}</font></td>
                	<td width="100px">${sector.all_end_total_cnt}</td>
                	<%-- <td width="100px">${sector.all_total_period_date}</td> --%>
                	<c:set var="se_sum_end_average_cnt" value="${se_sum_end_average_cnt + sector.end_average_cnt}"/>
                	<c:set var="se_sum_all_end_total_cnt" value="${se_sum_all_end_total_cnt + sector.all_end_total_cnt}"/>
                	<c:set var="se_sum_all_total_period_date" value="${se_sum_all_total_period_date + sector.all_total_period_date}"/>                	                	
                </tr>
			</c:forEach>
			<tr>
				<th>합계</th>
				<c:choose>
					<c:when test="${sector.all_end_total_cnt == 0}">
						<th>0</th>
						<th>0</th>
						<!-- <th>0</th> -->
					</c:when>
					<c:otherwise>
						<th>
							<font color="blue">
								<fmt:formatNumber value="${se_sum_end_average_cnt / sectorList.size()}" pattern="#,###"/>
							</font>
						</th>
						<th>${se_sum_all_end_total_cnt }</th>
						<%-- <th>${se_sum_all_total_period_date}</th> --%>
					</c:otherwise>
				</c:choose>				
			</tr>
        </table>
    </div>
</div>