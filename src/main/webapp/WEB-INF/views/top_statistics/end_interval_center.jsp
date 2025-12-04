<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2">
    <div style="background: #e7ecf1;">
        <table>
            <tr>
                <th>센터명</th>            	            	
            	<th>평균처리일</th>
            	<th>종결건수</th>
            	<!-- <th>전체처리일</th> -->
            </tr>            
        </table>
    </div>
    <div style="height:630px; overflow-x: hidden; overflow-y: auto;">
        <table>            
            <c:forEach var="center" items="${centerList}" varStatus="status">            	
                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                	<td width="100px">${center.center_name}</td>                	                	
                	<td width="100px"><font color="blue">${center.end_average_cnt}</font></td>
                	<td width="100px">${center.all_end_total_cnt}</td>
                	<%-- <td width="100px">${center.all_total_period_date}</td> --%>
                	<c:set var="ct_sum_end_average_cnt" value="${ct_sum_end_average_cnt + center.end_average_cnt}"/>
                	<c:set var="ct_sum_all_end_total_cnt" value="${ct_sum_all_end_total_cnt + center.all_end_total_cnt}"/>
                	<c:set var="ct_sum_all_total_period_date" value="${ct_sum_all_total_period_date + center.all_total_period_date}"/>                	                	
                </tr>
			</c:forEach>
			<tr>
				<th>합계</th>
				<c:choose>
					<c:when test="${center.all_end_total_cnt == 0}">
						<th>0</th>
						<th>0</th>
						<!-- <th>0</th> -->
					</c:when>
					<c:otherwise>
						<th>
							<font color="blue">
								<fmt:formatNumber value="${ct_sum_end_average_cnt / centerList.size()}" pattern="#,###"/>
							</font>
						</th>
						<th>${ct_sum_all_end_total_cnt }</th>
						<%-- <th>${ct_sum_all_total_period_date}</th> --%>
					</c:otherwise>
				</c:choose>				
			</tr>    
        </table>
    </div>
</div>