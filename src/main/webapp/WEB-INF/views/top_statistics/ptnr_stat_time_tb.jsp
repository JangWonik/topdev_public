<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="tableStyle2">
    <div style="padding-right: 17px; background: #e7ecf1;">
        <table>            
            <tr>
                <th style="width: 80px;height:25px;">Type</th>
                <th style="width: 100px;">보험사</th>
                <th style="width: 200px;">구분</th>
                <th style="width: 80px;">${nowVO.monBefore11.substring(0,7)}</th>
                <th style="width: 80px;">${nowVO.monBefore10.substring(0,7)}</th>
                <th style="width: 80px;">${nowVO.monBefore9.substring(0,7)}</th>
                <th style="width: 80px;">${nowVO.monBefore8.substring(0,7)}</th>
                <th style="width: 80px;">${nowVO.monBefore7.substring(0,7)}</th>
                <th style="width: 80px;">${nowVO.monBefore6.substring(0,7)}</th>
                <th style="width: 80px;">${nowVO.monBefore5.substring(0,7)}</th>
                <th style="width: 80px;">${nowVO.monBefore4.substring(0,7)}</th>
                <th style="width: 80px;">${nowVO.monBefore3.substring(0,7)}</th>
                <th style="width: 80px;">${nowVO.monBefore2.substring(0,7)}</th>
                <th style="width: 80px;">${nowVO.monBefore1.substring(0,7)}</th>
                <th style="width: 80px;">${nowVO.monBefore0.substring(0,7)}</th>
                <th style="width: 80px;">합계</th>
            </tr>            
        </table>
    </div>
    <div style="height:600px; overflow-x: hidden; overflow-y: auto;">
    	<!-- 1종 조사 시작 -->
        <table>
            <tbody>            
            <!-- 보험사 row를 만들기위한 변수 -->            
            <c:set var="beforePtnrId" value="0"></c:set>
            <!-- 보험사 세부 소계 row를 만들기 위한 변수 -->
            <c:set var="ptnrSubRow" value="1"></c:set>
            <!-- 통계변수 시작 -->
            <c:set var="time12_5" value="0"></c:set>
            <c:set var="time11_5" value="0"></c:set>
            <c:set var="time10_5" value="0"></c:set>
            <c:set var="time09_5" value="0"></c:set>
            <c:set var="time08_5" value="0"></c:set>
            <c:set var="time07_5" value="0"></c:set>
            <c:set var="time06_5" value="0"></c:set>
            <c:set var="time05_5" value="0"></c:set>
            <c:set var="time04_5" value="0"></c:set>
            <c:set var="time03_5" value="0"></c:set>
            <c:set var="time02_5" value="0"></c:set>
            <c:set var="time01_5" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="timePeriodSum_12_5" value="0"></c:set>
            <c:set var="timePeriodSum_11_5" value="0"></c:set>
            <c:set var="timePeriodSum_10_5" value="0"></c:set>
            <c:set var="timePeriodSum_09_5" value="0"></c:set>
            <c:set var="timePeriodSum_08_5" value="0"></c:set>
            <c:set var="timePeriodSum_07_5" value="0"></c:set>
            <c:set var="timePeriodSum_06_5" value="0"></c:set>
            <c:set var="timePeriodSum_05_5" value="0"></c:set>
            <c:set var="timePeriodSum_04_5" value="0"></c:set>
            <c:set var="timePeriodSum_03_5" value="0"></c:set>
            <c:set var="timePeriodSum_02_5" value="0"></c:set>
            <c:set var="timePeriodSum_01_5" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="timePtnrSum_12_5" value="0"></c:set>
            <c:set var="timePtnrSum_11_5" value="0"></c:set>
            <c:set var="timePtnrSum_10_5" value="0"></c:set>
            <c:set var="timePtnrSum_09_5" value="0"></c:set>
            <c:set var="timePtnrSum_08_5" value="0"></c:set>
            <c:set var="timePtnrSum_07_5" value="0"></c:set>
            <c:set var="timePtnrSum_06_5" value="0"></c:set>
            <c:set var="timePtnrSum_05_5" value="0"></c:set>
            <c:set var="timePtnrSum_04_5" value="0"></c:set>
            <c:set var="timePtnrSum_03_5" value="0"></c:set>
            <c:set var="timePtnrSum_02_5" value="0"></c:set>
            <c:set var="timePtnrSum_01_5" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="timeColSum_5" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="timePtnrColSum_5" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="timeTotalSum_12_5" value="0"></c:set>
            <c:set var="timeTotalSum_11_5" value="0"></c:set>
            <c:set var="timeTotalSum_10_5" value="0"></c:set>
            <c:set var="timeTotalSum_09_5" value="0"></c:set>
            <c:set var="timeTotalSum_08_5" value="0"></c:set>
            <c:set var="timeTotalSum_07_5" value="0"></c:set>
            <c:set var="timeTotalSum_06_5" value="0"></c:set>
            <c:set var="timeTotalSum_05_5" value="0"></c:set>
            <c:set var="timeTotalSum_04_5" value="0"></c:set>
            <c:set var="timeTotalSum_03_5" value="0"></c:set>
            <c:set var="timeTotalSum_02_5" value="0"></c:set>
            <c:set var="timeTotalSum_01_5" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="timeColTotalSum_5" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo" items="${ptnrStatTimeList}" varStatus="status">            
                <tr>
                    <c:if test="${status.index == 0}">
                        <td style="width: 80px;" rowspan="${rowCnt}">1종 조사</td>
                    </c:if>
                    
                    <c:choose>
                    	<c:when test="${vo.ptnrRowCnt == 1}">			<!-- 보험사 세부분류가 없는 경우 -->
                    		<td colspan="3" onclick="goPtnrStatCenter(${vo.ptnrId});" style="width: 300px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    			${vo.ptnrNick}
                    		</td>
                    	</c:when>
                    	<c:otherwise>												<!-- 보험사 세부분류가 있는 경우 -->
                    		<c:choose>
		                    	<c:when test="${vo.ptnrId !=  beforePtnrId and vo.ptnrRowCnt > 1}">                    	
		                    		<td rowspan="${vo.ptnrRowCnt+1}" onclick="goPtnrStatCenter(${vo.ptnrId});" style="width: 100px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.ptnrNick}</td>                    		
				                   	<c:set var="beforePtnrId" value="${vo.ptnrId}"></c:set>
				                   	<c:set var="ptnrSubRow" value="1"></c:set>
				                   	
				                   	<!-- 보험사 변경 시 보험사 누적합계 초기화 -->
						            <c:set var="timePtnrSum_12_5" value="0"></c:set>
						            <c:set var="timePtnrSum_11_5" value="0"></c:set>
						            <c:set var="timePtnrSum_10_5" value="0"></c:set>
						            <c:set var="timePtnrSum_09_5" value="0"></c:set>
						            <c:set var="timePtnrSum_08_5" value="0"></c:set>
						            <c:set var="timePtnrSum_07_5" value="0"></c:set>
						            <c:set var="timePtnrSum_06_5" value="0"></c:set>
						            <c:set var="timePtnrSum_05_5" value="0"></c:set>
						            <c:set var="timePtnrSum_04_5" value="0"></c:set>
						            <c:set var="timePtnrSum_03_5" value="0"></c:set>
						            <c:set var="timePtnrSum_02_5" value="0"></c:set>
						            <c:set var="timePtnrSum_01_5" value="0"></c:set>
		                    	</c:when>
		                    	<c:when test="${vo.ptnrId !=  beforePtnrId and vo.ptnrRowCnt == 1}">
		                    		<td style="width: 100px;">${vo.ptnrNick}</td>                    		
				                   	<c:set var="beforePtnrId" value="${vo.ptnrId}"></c:set>
				                   	<c:set var="ptnrSubRow" value="1"></c:set>
		                    	</c:when>
		                    	<c:otherwise>
		                    		<c:set var="ptnrSubRow" value="${ptnrSubRow+1}"></c:set>
		                    	</c:otherwise>
		                    </c:choose>                                        
		                    
		                    <c:choose>
		                    	<c:when test="${vo.periodFlagCode == 0}">
		                    		<td colspan="2" style="width:200px;">${vo.ptnrIdSubNm}</td>
		                    	</c:when>
		                    	<c:otherwise>
		                    		<c:if test="${vo.periodFlagCode == 1 }">
		                    			<td rowspan="3" style="width: 100px;">${vo.ptnrIdSubNm}</td>	
		                    		</c:if>
		                    		<c:choose>
										<c:when test='${vo.periodFlagNm == "소계"}'>
											<td style="width: 100px;" class="sum-level-1">${vo.periodFlagNm}</td>
										</c:when>
										<c:otherwise>
											<td style="width: 100px;">${vo.periodFlagNm}</td>
										</c:otherwise>
									</c:choose>
		                    	</c:otherwise>
		                    </c:choose>
                    	</c:otherwise>
                    </c:choose>
                    <!-- 소계 열인 경우 통계값에 합산값을 넣어준다. -->  
                    <c:choose>
                    	<c:when test="${vo.periodFlagCode == 3}">
                    		<c:set var="time12_5" value="${timePeriodSum_12_5}"></c:set>
		                    <c:set var="time11_5" value="${timePeriodSum_11_5}"></c:set>
		                    <c:set var="time10_5" value="${timePeriodSum_10_5}"></c:set>
		                    <c:set var="time09_5" value="${timePeriodSum_09_5}"></c:set>
		                    <c:set var="time08_5" value="${timePeriodSum_08_5}"></c:set>
		                    <c:set var="time07_5" value="${timePeriodSum_07_5}"></c:set>
		                    <c:set var="time06_5" value="${timePeriodSum_06_5}"></c:set>
		                    <c:set var="time05_5" value="${timePeriodSum_05_5}"></c:set>
		                    <c:set var="time04_5" value="${timePeriodSum_04_5}"></c:set>
		                    <c:set var="time03_5" value="${timePeriodSum_03_5}"></c:set>
		                    <c:set var="time02_5" value="${timePeriodSum_02_5}"></c:set>
		                    <c:set var="time01_5" value="${timePeriodSum_01_5}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="time12_5" value="${vo.time12}"></c:set>
		                    <c:set var="time11_5" value="${vo.time11}"></c:set>
		                    <c:set var="time10_5" value="${vo.time10}"></c:set>
		                    <c:set var="time09_5" value="${vo.time09}"></c:set>
		                    <c:set var="time08_5" value="${vo.time08}"></c:set>
		                    <c:set var="time07_5" value="${vo.time07}"></c:set>
		                    <c:set var="time06_5" value="${vo.time06}"></c:set>
		                    <c:set var="time05_5" value="${vo.time05}"></c:set>
		                    <c:set var="time04_5" value="${vo.time04}"></c:set>
		                    <c:set var="time03_5" value="${vo.time03}"></c:set>
		                    <c:set var="time02_5" value="${vo.time02}"></c:set>
		                    <c:set var="time01_5" value="${vo.time01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="timePeriodSum_12_5" value="${timePeriodSum_12_5 + vo.time12}"></c:set>
		                    <c:set var="timePeriodSum_11_5" value="${timePeriodSum_11_5 + vo.time11}"></c:set>
		                    <c:set var="timePeriodSum_10_5" value="${timePeriodSum_10_5 + vo.time10}"></c:set>
		                    <c:set var="timePeriodSum_09_5" value="${timePeriodSum_09_5 + vo.time09}"></c:set>
		                    <c:set var="timePeriodSum_08_5" value="${timePeriodSum_08_5 + vo.time08}"></c:set>
		                    <c:set var="timePeriodSum_07_5" value="${timePeriodSum_07_5 + vo.time07}"></c:set>
		                    <c:set var="timePeriodSum_06_5" value="${timePeriodSum_06_5 + vo.time06}"></c:set>
		                    <c:set var="timePeriodSum_05_5" value="${timePeriodSum_05_5 + vo.time05}"></c:set>
		                    <c:set var="timePeriodSum_04_5" value="${timePeriodSum_04_5 + vo.time04}"></c:set>
		                    <c:set var="timePeriodSum_03_5" value="${timePeriodSum_03_5 + vo.time03}"></c:set>
		                    <c:set var="timePeriodSum_02_5" value="${timePeriodSum_02_5 + vo.time02}"></c:set>
		                    <c:set var="timePeriodSum_01_5" value="${timePeriodSum_01_5 + vo.time01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="timePtnrSum_12_5" value="${timePtnrSum_12_5 + vo.time12}"></c:set>
		                    <c:set var="timePtnrSum_11_5" value="${timePtnrSum_11_5 + vo.time11}"></c:set>
		                    <c:set var="timePtnrSum_10_5" value="${timePtnrSum_10_5 + vo.time10}"></c:set>
		                    <c:set var="timePtnrSum_09_5" value="${timePtnrSum_09_5 + vo.time09}"></c:set>
		                    <c:set var="timePtnrSum_08_5" value="${timePtnrSum_08_5 + vo.time08}"></c:set>
		                    <c:set var="timePtnrSum_07_5" value="${timePtnrSum_07_5 + vo.time07}"></c:set>
		                    <c:set var="timePtnrSum_06_5" value="${timePtnrSum_06_5 + vo.time06}"></c:set>
		                    <c:set var="timePtnrSum_05_5" value="${timePtnrSum_05_5 + vo.time05}"></c:set>
		                    <c:set var="timePtnrSum_04_5" value="${timePtnrSum_04_5 + vo.time04}"></c:set>
		                    <c:set var="timePtnrSum_03_5" value="${timePtnrSum_03_5 + vo.time03}"></c:set>
		                    <c:set var="timePtnrSum_02_5" value="${timePtnrSum_02_5 + vo.time02}"></c:set>
		                    <c:set var="timePtnrSum_01_5" value="${timePtnrSum_01_5 + vo.time01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="timeTotalSum_12_5" value="${timeTotalSum_12_5 + vo.time12}"></c:set>
		                    <c:set var="timeTotalSum_11_5" value="${timeTotalSum_11_5 + vo.time11}"></c:set>
		                    <c:set var="timeTotalSum_10_5" value="${timeTotalSum_10_5 + vo.time10}"></c:set>
		                    <c:set var="timeTotalSum_09_5" value="${timeTotalSum_09_5 + vo.time09}"></c:set>
		                    <c:set var="timeTotalSum_08_5" value="${timeTotalSum_08_5 + vo.time08}"></c:set>
		                    <c:set var="timeTotalSum_07_5" value="${timeTotalSum_07_5 + vo.time07}"></c:set>
		                    <c:set var="timeTotalSum_06_5" value="${timeTotalSum_06_5 + vo.time06}"></c:set>
		                    <c:set var="timeTotalSum_05_5" value="${timeTotalSum_05_5 + vo.time05}"></c:set>
		                    <c:set var="timeTotalSum_04_5" value="${timeTotalSum_04_5 + vo.time04}"></c:set>
		                    <c:set var="timeTotalSum_03_5" value="${timeTotalSum_03_5 + vo.time03}"></c:set>
		                    <c:set var="timeTotalSum_02_5" value="${timeTotalSum_02_5 + vo.time02}"></c:set>
		                    <c:set var="timeTotalSum_01_5" value="${timeTotalSum_01_5 + vo.time01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="timeColSum_5" value="${time12_5 + time11_5 + time10_5 + time09_5 + time08_5 + time07_5 + time06_5 + time05_5 + time04_5 + time03_5 + time02_5 + time01_5}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo.periodFlagNm == "소계"}'>
							<!-- time12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1"><fmt:formatNumber value="${time12_5}" pattern="#,##0.##"/></td>
		                    <!-- time11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time11_5}" pattern="#,##0.##"/></td>
		                    <!-- time10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time10_5}" pattern="#,##0.##"/></td>
		                    <!-- time09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time09_5}" pattern="#,##0.##"/></td>
		                    <!-- time08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time08_5}" pattern="#,##0.##"/></td>
		                    <!-- time07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time07_5}" pattern="#,##0.##"/></td>
		                    <!-- time06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time06_5}" pattern="#,##0.##"/></td>
		                    <!-- time05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time05_5}" pattern="#,##0.##"/></td>
		                    <!-- time04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time04_5}" pattern="#,##0.##"/></td>
		                    <!-- time03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time03_5}" pattern="#,##0.##"/></td>
		                    <!-- time02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time02_5}" pattern="#,##0.##"/></td>
		                    <!-- time01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time01_5}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${timeColSum_5}" pattern="#,##0.##"/></td>
						</c:when>
						<c:otherwise>
							<!-- time12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${time12_5}" pattern="#,##0.##"/></td>
		                    <!-- time11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time11_5}" pattern="#,##0.##"/></td>
		                    <!-- time10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time10_5}" pattern="#,##0.##"/></td>
		                    <!-- time09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time09_5}" pattern="#,##0.##"/></td>
		                    <!-- time08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time08_5}" pattern="#,##0.##"/></td>
		                    <!-- time07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time07_5}" pattern="#,##0.##"/></td>
		                    <!-- time06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time06_5}" pattern="#,##0.##"/></td>
		                    <!-- time05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time05_5}" pattern="#,##0.##"/></td>
		                    <!-- time04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time04_5}" pattern="#,##0.##"/></td>
		                    <!-- time03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time03_5}" pattern="#,##0.##"/></td>
		                    <!-- time02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time02_5}" pattern="#,##0.##"/></td>
		                    <!-- time01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time01_5}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeColSum_5}" pattern="#,##0.##"/></td>
						</c:otherwise>
					</c:choose>  
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo.periodFlagCode == 3}">
                    	<c:set var="timePeriodSum_12_5" value="0"></c:set>
			            <c:set var="timePeriodSum_11_5" value="0"></c:set>
			            <c:set var="timePeriodSum_10_5" value="0"></c:set>
			            <c:set var="timePeriodSum_09_5" value="0"></c:set>
			            <c:set var="timePeriodSum_08_5" value="0"></c:set>
			            <c:set var="timePeriodSum_07_5" value="0"></c:set>
			            <c:set var="timePeriodSum_06_5" value="0"></c:set>
			            <c:set var="timePeriodSum_05_5" value="0"></c:set>
			            <c:set var="timePeriodSum_04_5" value="0"></c:set>
			            <c:set var="timePeriodSum_03_5" value="0"></c:set>
			            <c:set var="timePeriodSum_02_5" value="0"></c:set>
			            <c:set var="timePeriodSum_01_5" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo.ptnrRowCnt > 1}">
                	<c:if test="${vo.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="timePeriodSum_12_5" value="0"></c:set>
			            <c:set var="timePeriodSum_11_5" value="0"></c:set>
			            <c:set var="timePeriodSum_10_5" value="0"></c:set>
			            <c:set var="timePeriodSum_09_5" value="0"></c:set>
			            <c:set var="timePeriodSum_08_5" value="0"></c:set>
			            <c:set var="timePeriodSum_07_5" value="0"></c:set>
			            <c:set var="timePeriodSum_06_5" value="0"></c:set>
			            <c:set var="timePeriodSum_05_5" value="0"></c:set>
			            <c:set var="timePeriodSum_04_5" value="0"></c:set>
			            <c:set var="timePeriodSum_03_5" value="0"></c:set>
			            <c:set var="timePeriodSum_02_5" value="0"></c:set>
			            <c:set var="timePeriodSum_01_5" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- time12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_12_5}" pattern="#,##0.##"/></td>
		                    <!-- time11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_11_5}" pattern="#,##0.##"/></td>
		                    <!-- time10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_10_5}" pattern="#,##0.##"/></td>
		                    <!-- time09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_09_5}" pattern="#,##0.##"/></td>
		                    <!-- time08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_08_5}" pattern="#,##0.##"/></td>
		                    <!-- time07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_07_5}" pattern="#,##0.##"/></td>
		                    <!-- time06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_06_5}" pattern="#,##0.##"/></td>
		                    <!-- time05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_05_5}" pattern="#,##0.##"/></td>
		                    <!-- time04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_04_5}" pattern="#,##0.##"/></td>
		                    <!-- time03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_03_5}" pattern="#,##0.##"/></td>
		                    <!-- time02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_02_5}" pattern="#,##0.##"/></td>
		                    <!-- time01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_01_5}" pattern="#,##0.##"/></td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="timePtnrColSum_5" value="${timePtnrSum_12_5 + timePtnrSum_11_5 + timePtnrSum_10_5 + timePtnrSum_09_5 + timePtnrSum_08_5 + timePtnrSum_07_5 + timePtnrSum_06_5 + timePtnrSum_05_5 + timePtnrSum_04_5 + timePtnrSum_03_5 + timePtnrSum_02_5 + timePtnrSum_01_5}"></c:set>
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrColSum_5}" pattern="#,##0.##"/></td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 조사 소계</th>
                <!-- time12 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_12_5}" pattern="#,##0.##"/></th>
                <!-- time11 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_11_5}" pattern="#,##0.##"/></th>
                <!-- time10 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_10_5}" pattern="#,##0.##"/></th>
                <!-- time09 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_09_5}" pattern="#,##0.##"/></th>
                <!-- time08 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_08_5}" pattern="#,##0.##"/></th>
                <!-- time07 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_07_5}" pattern="#,##0.##"/></th>
                <!-- time06 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_06_5}" pattern="#,##0.##"/></th>
                <!-- time05 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_05_5}" pattern="#,##0.##"/></th>
                <!-- time04 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_04_5}" pattern="#,##0.##"/></th>
                <!-- time03 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_03_5}" pattern="#,##0.##"/></th>
                <!-- time02 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_02_5}" pattern="#,##0.##"/></th>
                <!-- time01 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_01_5}" pattern="#,##0.##"/></th>
                <!-- 가로열 합계 -->
                <c:set var="timeColTotalSum_5" value="${timeTotalSum_12_5 + timeTotalSum_11_5 + timeTotalSum_10_5 + timeTotalSum_09_5 + timeTotalSum_08_5 + timeTotalSum_07_5 + timeTotalSum_06_5 + timeTotalSum_05_5 + timeTotalSum_04_5 + timeTotalSum_03_5 + timeTotalSum_02_5 + timeTotalSum_01_5}"></c:set>
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeColTotalSum_5}" pattern="#,##0.##"/></th>
            </tr>						
			</tbody>
		</table>
		<!-- 1종 조사 끝 -->
		
		<!-- 1종 심사 시작 -->
        <table>
            <tbody>            
            <!-- 보험사 row를 만들기위한 변수 -->            
            <c:set var="beforePtnrId" value="0"></c:set>
            <!-- 보험사 세부 소계 row를 만들기 위한 변수 -->
            <c:set var="ptnrSubRow" value="1"></c:set>
            <!-- 통계변수 시작 -->
            <c:set var="time12_10" value="0"></c:set>
            <c:set var="time11_10" value="0"></c:set>
            <c:set var="time10_10" value="0"></c:set>
            <c:set var="time09_10" value="0"></c:set>
            <c:set var="time08_10" value="0"></c:set>
            <c:set var="time07_10" value="0"></c:set>
            <c:set var="time06_10" value="0"></c:set>
            <c:set var="time05_10" value="0"></c:set>
            <c:set var="time04_10" value="0"></c:set>
            <c:set var="time03_10" value="0"></c:set>
            <c:set var="time02_10" value="0"></c:set>
            <c:set var="time01_10" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="timePeriodSum_12_10" value="0"></c:set>
            <c:set var="timePeriodSum_11_10" value="0"></c:set>
            <c:set var="timePeriodSum_10_10" value="0"></c:set>
            <c:set var="timePeriodSum_09_10" value="0"></c:set>
            <c:set var="timePeriodSum_08_10" value="0"></c:set>
            <c:set var="timePeriodSum_07_10" value="0"></c:set>
            <c:set var="timePeriodSum_06_10" value="0"></c:set>
            <c:set var="timePeriodSum_05_10" value="0"></c:set>
            <c:set var="timePeriodSum_04_10" value="0"></c:set>
            <c:set var="timePeriodSum_03_10" value="0"></c:set>
            <c:set var="timePeriodSum_02_10" value="0"></c:set>
            <c:set var="timePeriodSum_01_10" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="timePtnrSum_12_10" value="0"></c:set>
            <c:set var="timePtnrSum_11_10" value="0"></c:set>
            <c:set var="timePtnrSum_10_10" value="0"></c:set>
            <c:set var="timePtnrSum_09_10" value="0"></c:set>
            <c:set var="timePtnrSum_08_10" value="0"></c:set>
            <c:set var="timePtnrSum_07_10" value="0"></c:set>
            <c:set var="timePtnrSum_06_10" value="0"></c:set>
            <c:set var="timePtnrSum_05_10" value="0"></c:set>
            <c:set var="timePtnrSum_04_10" value="0"></c:set>
            <c:set var="timePtnrSum_03_10" value="0"></c:set>
            <c:set var="timePtnrSum_02_10" value="0"></c:set>
            <c:set var="timePtnrSum_01_10" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="timeColSum_10" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="timePtnrColSum_10" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="timeTotalSum_12_10" value="0"></c:set>
            <c:set var="timeTotalSum_11_10" value="0"></c:set>
            <c:set var="timeTotalSum_10_10" value="0"></c:set>
            <c:set var="timeTotalSum_09_10" value="0"></c:set>
            <c:set var="timeTotalSum_08_10" value="0"></c:set>
            <c:set var="timeTotalSum_07_10" value="0"></c:set>
            <c:set var="timeTotalSum_06_10" value="0"></c:set>
            <c:set var="timeTotalSum_05_10" value="0"></c:set>
            <c:set var="timeTotalSum_04_10" value="0"></c:set>
            <c:set var="timeTotalSum_03_10" value="0"></c:set>
            <c:set var="timeTotalSum_02_10" value="0"></c:set>
            <c:set var="timeTotalSum_01_10" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="timeColTotalSum_10" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo1" items="${ptnrStatTimeList_10}" varStatus="status">            
                <tr>
                    <c:if test="${status.index == 0}">
                        <td style="width: 80px;" rowspan="${rowCnt}">1종 심사</td>
                    </c:if>
                    
                    <c:choose>
                    	<c:when test="${vo1.ptnrRowCnt == 1}">			<!-- 보험사 세부분류가 없는 경우 -->
                    		<td colspan="3" onclick="goPtnrStatCenter(${vo1.ptnrId});" style="width: 300px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    			${vo1.ptnrNick}
                    		</td>
                    	</c:when>
                    	<c:otherwise>												<!-- 보험사 세부분류가 있는 경우 -->
                    		<c:choose>
		                    	<c:when test="${vo1.ptnrId !=  beforePtnrId and vo1.ptnrRowCnt > 1}">                    	
		                    		<td rowspan="${vo1.ptnrRowCnt+1}" onclick="goPtnrStatCenter(${vo1.ptnrId});" style="width: 100px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.ptnrNick}</td>                    		
				                   	<c:set var="beforePtnrId" value="${vo1.ptnrId}"></c:set>
				                   	<c:set var="ptnrSubRow" value="1"></c:set>
				                   	
				                   	<!-- 보험사 변경 시 보험사 누적합계 초기화 -->
						            <c:set var="timePtnrSum_12_10" value="0"></c:set>
						            <c:set var="timePtnrSum_11_10" value="0"></c:set>
						            <c:set var="timePtnrSum_10_10" value="0"></c:set>
						            <c:set var="timePtnrSum_09_10" value="0"></c:set>
						            <c:set var="timePtnrSum_08_10" value="0"></c:set>
						            <c:set var="timePtnrSum_07_10" value="0"></c:set>
						            <c:set var="timePtnrSum_06_10" value="0"></c:set>
						            <c:set var="timePtnrSum_05_10" value="0"></c:set>
						            <c:set var="timePtnrSum_04_10" value="0"></c:set>
						            <c:set var="timePtnrSum_03_10" value="0"></c:set>
						            <c:set var="timePtnrSum_02_10" value="0"></c:set>
						            <c:set var="timePtnrSum_01_10" value="0"></c:set>
		                    	</c:when>
		                    	<c:when test="${vo1.ptnrId !=  beforePtnrId and vo1.ptnrRowCnt == 1}">
		                    		<td style="width: 100px;">${vo1.ptnrNick}</td>                    		
				                   	<c:set var="beforePtnrId" value="${vo1.ptnrId}"></c:set>
				                   	<c:set var="ptnrSubRow" value="1"></c:set>
		                    	</c:when>
		                    	<c:otherwise>
		                    		<c:set var="ptnrSubRow" value="${ptnrSubRow+1}"></c:set>
		                    	</c:otherwise>
		                    </c:choose>                                        
		                    
		                    <c:choose>
		                    	<c:when test="${vo1.periodFlagCode == 0}">
		                    		<td colspan="2" style="width:200px;">${vo1.ptnrIdSubNm}</td>
		                    	</c:when>
		                    	<c:otherwise>
		                    		<c:if test="${vo1.periodFlagCode == 1 }">
		                    			<td rowspan="3" style="width: 100px;">${vo1.ptnrIdSubNm}</td>	
		                    		</c:if>
		                    		<c:choose>
										<c:when test='${vo1.periodFlagNm == "소계"}'>
											<td style="width: 100px;" class="sum-level-1">${vo1.periodFlagNm}</td>
										</c:when>
										<c:otherwise>
											<td style="width: 100px;">${vo1.periodFlagNm}</td>
										</c:otherwise>
									</c:choose>
		                    	</c:otherwise>
		                    </c:choose>
                    	</c:otherwise>
                    </c:choose>
                    <!-- 소계 열인 경우 통계값에 합산값을 넣어준다. -->  
                    <c:choose>
                    	<c:when test="${vo1.periodFlagCode == 3}">
                    		<c:set var="time12_10" value="${timePeriodSum_12_10}"></c:set>
		                    <c:set var="time11_10" value="${timePeriodSum_11_10}"></c:set>
		                    <c:set var="time10_10" value="${timePeriodSum_10_10}"></c:set>
		                    <c:set var="time09_10" value="${timePeriodSum_09_10}"></c:set>
		                    <c:set var="time08_10" value="${timePeriodSum_08_10}"></c:set>
		                    <c:set var="time07_10" value="${timePeriodSum_07_10}"></c:set>
		                    <c:set var="time06_10" value="${timePeriodSum_06_10}"></c:set>
		                    <c:set var="time05_10" value="${timePeriodSum_05_10}"></c:set>
		                    <c:set var="time04_10" value="${timePeriodSum_04_10}"></c:set>
		                    <c:set var="time03_10" value="${timePeriodSum_03_10}"></c:set>
		                    <c:set var="time02_10" value="${timePeriodSum_02_10}"></c:set>
		                    <c:set var="time01_10" value="${timePeriodSum_01_10}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="time12_10" value="${vo1.time12}"></c:set>
		                    <c:set var="time11_10" value="${vo1.time11}"></c:set>
		                    <c:set var="time10_10" value="${vo1.time10}"></c:set>
		                    <c:set var="time09_10" value="${vo1.time09}"></c:set>
		                    <c:set var="time08_10" value="${vo1.time08}"></c:set>
		                    <c:set var="time07_10" value="${vo1.time07}"></c:set>
		                    <c:set var="time06_10" value="${vo1.time06}"></c:set>
		                    <c:set var="time05_10" value="${vo1.time05}"></c:set>
		                    <c:set var="time04_10" value="${vo1.time04}"></c:set>
		                    <c:set var="time03_10" value="${vo1.time03}"></c:set>
		                    <c:set var="time02_10" value="${vo1.time02}"></c:set>
		                    <c:set var="time01_10" value="${vo1.time01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="timePeriodSum_12_10" value="${timePeriodSum_12_10 + vo1.time12}"></c:set>
		                    <c:set var="timePeriodSum_11_10" value="${timePeriodSum_11_10 + vo1.time11}"></c:set>
		                    <c:set var="timePeriodSum_10_10" value="${timePeriodSum_10_10 + vo1.time10}"></c:set>
		                    <c:set var="timePeriodSum_09_10" value="${timePeriodSum_09_10 + vo1.time09}"></c:set>
		                    <c:set var="timePeriodSum_08_10" value="${timePeriodSum_08_10 + vo1.time08}"></c:set>
		                    <c:set var="timePeriodSum_07_10" value="${timePeriodSum_07_10 + vo1.time07}"></c:set>
		                    <c:set var="timePeriodSum_06_10" value="${timePeriodSum_06_10 + vo1.time06}"></c:set>
		                    <c:set var="timePeriodSum_05_10" value="${timePeriodSum_05_10 + vo1.time05}"></c:set>
		                    <c:set var="timePeriodSum_04_10" value="${timePeriodSum_04_10 + vo1.time04}"></c:set>
		                    <c:set var="timePeriodSum_03_10" value="${timePeriodSum_03_10 + vo1.time03}"></c:set>
		                    <c:set var="timePeriodSum_02_10" value="${timePeriodSum_02_10 + vo1.time02}"></c:set>
		                    <c:set var="timePeriodSum_01_10" value="${timePeriodSum_01_10 + vo1.time01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="timePtnrSum_12_10" value="${timePtnrSum_12_10 + vo1.time12}"></c:set>
		                    <c:set var="timePtnrSum_11_10" value="${timePtnrSum_11_10 + vo1.time11}"></c:set>
		                    <c:set var="timePtnrSum_10_10" value="${timePtnrSum_10_10 + vo1.time10}"></c:set>
		                    <c:set var="timePtnrSum_09_10" value="${timePtnrSum_09_10 + vo1.time09}"></c:set>
		                    <c:set var="timePtnrSum_08_10" value="${timePtnrSum_08_10 + vo1.time08}"></c:set>
		                    <c:set var="timePtnrSum_07_10" value="${timePtnrSum_07_10 + vo1.time07}"></c:set>
		                    <c:set var="timePtnrSum_06_10" value="${timePtnrSum_06_10 + vo1.time06}"></c:set>
		                    <c:set var="timePtnrSum_05_10" value="${timePtnrSum_05_10 + vo1.time05}"></c:set>
		                    <c:set var="timePtnrSum_04_10" value="${timePtnrSum_04_10 + vo1.time04}"></c:set>
		                    <c:set var="timePtnrSum_03_10" value="${timePtnrSum_03_10 + vo1.time03}"></c:set>
		                    <c:set var="timePtnrSum_02_10" value="${timePtnrSum_02_10 + vo1.time02}"></c:set>
		                    <c:set var="timePtnrSum_01_10" value="${timePtnrSum_01_10 + vo1.time01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="timeTotalSum_12_10" value="${timeTotalSum_12_10 + vo1.time12}"></c:set>
		                    <c:set var="timeTotalSum_11_10" value="${timeTotalSum_11_10 + vo1.time11}"></c:set>
		                    <c:set var="timeTotalSum_10_10" value="${timeTotalSum_10_10 + vo1.time10}"></c:set>
		                    <c:set var="timeTotalSum_09_10" value="${timeTotalSum_09_10 + vo1.time09}"></c:set>
		                    <c:set var="timeTotalSum_08_10" value="${timeTotalSum_08_10 + vo1.time08}"></c:set>
		                    <c:set var="timeTotalSum_07_10" value="${timeTotalSum_07_10 + vo1.time07}"></c:set>
		                    <c:set var="timeTotalSum_06_10" value="${timeTotalSum_06_10 + vo1.time06}"></c:set>
		                    <c:set var="timeTotalSum_05_10" value="${timeTotalSum_05_10 + vo1.time05}"></c:set>
		                    <c:set var="timeTotalSum_04_10" value="${timeTotalSum_04_10 + vo1.time04}"></c:set>
		                    <c:set var="timeTotalSum_03_10" value="${timeTotalSum_03_10 + vo1.time03}"></c:set>
		                    <c:set var="timeTotalSum_02_10" value="${timeTotalSum_02_10 + vo1.time02}"></c:set>
		                    <c:set var="timeTotalSum_01_10" value="${timeTotalSum_01_10 + vo1.time01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="timeColSum_10" value="${time12_10 + time11_10 + time10_10 + time09_10 + time08_10 + time07_10 + time06_10 + time05_10 + time04_10 + time03_10 + time02_10 + time01_10}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo1.periodFlagNm == "소계"}'>
							<!-- time12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1"><fmt:formatNumber value="${time12_10}" pattern="#,##0.##"/></td>
		                    <!-- time11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time11_10}" pattern="#,##0.##"/></td>
		                    <!-- time10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time10_10}" pattern="#,##0.##"/></td>
		                    <!-- time09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time09_10}" pattern="#,##0.##"/></td>
		                    <!-- time08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time08_10}" pattern="#,##0.##"/></td>
		                    <!-- time07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time07_10}" pattern="#,##0.##"/></td>
		                    <!-- time06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time06_10}" pattern="#,##0.##"/></td>
		                    <!-- time05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time05_10}" pattern="#,##0.##"/></td>
		                    <!-- time04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time04_10}" pattern="#,##0.##"/></td>
		                    <!-- time03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time03_10}" pattern="#,##0.##"/></td>
		                    <!-- time02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time02_10}" pattern="#,##0.##"/></td>
		                    <!-- time01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time01_10}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${timeColSum_10}" pattern="#,##0.##"/></td>
						</c:when>
						<c:otherwise>
							<!-- time12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${time12_10}" pattern="#,##0.##"/></td>
		                    <!-- time11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time11_10}" pattern="#,##0.##"/></td>
		                    <!-- time10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time10_10}" pattern="#,##0.##"/></td>
		                    <!-- time09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time09_10}" pattern="#,##0.##"/></td>
		                    <!-- time08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time08_10}" pattern="#,##0.##"/></td>
		                    <!-- time07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time07_10}" pattern="#,##0.##"/></td>
		                    <!-- time06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time06_10}" pattern="#,##0.##"/></td>
		                    <!-- time05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time05_10}" pattern="#,##0.##"/></td>
		                    <!-- time04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time04_10}" pattern="#,##0.##"/></td>
		                    <!-- time03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time03_10}" pattern="#,##0.##"/></td>
		                    <!-- time02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time02_10}" pattern="#,##0.##"/></td>
		                    <!-- time01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time01_10}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeColSum_10}" pattern="#,##0.##"/></td>
						</c:otherwise>
					</c:choose>  
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo1.periodFlagCode == 3}">
                    	<c:set var="timePeriodSum_12_10" value="0"></c:set>
			            <c:set var="timePeriodSum_11_10" value="0"></c:set>
			            <c:set var="timePeriodSum_10_10" value="0"></c:set>
			            <c:set var="timePeriodSum_09_10" value="0"></c:set>
			            <c:set var="timePeriodSum_08_10" value="0"></c:set>
			            <c:set var="timePeriodSum_07_10" value="0"></c:set>
			            <c:set var="timePeriodSum_06_10" value="0"></c:set>
			            <c:set var="timePeriodSum_05_10" value="0"></c:set>
			            <c:set var="timePeriodSum_04_10" value="0"></c:set>
			            <c:set var="timePeriodSum_03_10" value="0"></c:set>
			            <c:set var="timePeriodSum_02_10" value="0"></c:set>
			            <c:set var="timePeriodSum_01_10" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo1.ptnrRowCnt > 1}">
                	<c:if test="${vo1.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="timePeriodSum_12_10" value="0"></c:set>
			            <c:set var="timePeriodSum_11_10" value="0"></c:set>
			            <c:set var="timePeriodSum_10_10" value="0"></c:set>
			            <c:set var="timePeriodSum_09_10" value="0"></c:set>
			            <c:set var="timePeriodSum_08_10" value="0"></c:set>
			            <c:set var="timePeriodSum_07_10" value="0"></c:set>
			            <c:set var="timePeriodSum_06_10" value="0"></c:set>
			            <c:set var="timePeriodSum_05_10" value="0"></c:set>
			            <c:set var="timePeriodSum_04_10" value="0"></c:set>
			            <c:set var="timePeriodSum_03_10" value="0"></c:set>
			            <c:set var="timePeriodSum_02_10" value="0"></c:set>
			            <c:set var="timePeriodSum_01_10" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- time12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_12_10}" pattern="#,##0.##"/></td>
		                    <!-- time11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_11_10}" pattern="#,##0.##"/></td>
		                    <!-- time10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_10_10}" pattern="#,##0.##"/></td>
		                    <!-- time09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_09_10}" pattern="#,##0.##"/></td>
		                    <!-- time08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_08_10}" pattern="#,##0.##"/></td>
		                    <!-- time07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_07_10}" pattern="#,##0.##"/></td>
		                    <!-- time06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_06_10}" pattern="#,##0.##"/></td>
		                    <!-- time05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_05_10}" pattern="#,##0.##"/></td>
		                    <!-- time04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_04_10}" pattern="#,##0.##"/></td>
		                    <!-- time03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_03_10}" pattern="#,##0.##"/></td>
		                    <!-- time02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_02_10}" pattern="#,##0.##"/></td>
		                    <!-- time01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_01_10}" pattern="#,##0.##"/></td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="timePtnrColSum_10" value="${timePtnrSum_12_10 + timePtnrSum_11_10 + timePtnrSum_10_10 + timePtnrSum_09_10 + timePtnrSum_08_10 + timePtnrSum_07_10 + timePtnrSum_06_10 + timePtnrSum_05_10 + timePtnrSum_04_10 + timePtnrSum_03_10 + timePtnrSum_02_10 + timePtnrSum_01_10}"></c:set>
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrColSum_10}" pattern="#,##0.##"/></td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 심사 소계</th>
                <!-- time12 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_12_10}" pattern="#,##0.##"/></th>
                <!-- time11 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_11_10}" pattern="#,##0.##"/></th>
                <!-- time10 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_10_10}" pattern="#,##0.##"/></th>
                <!-- time09 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_09_10}" pattern="#,##0.##"/></th>
                <!-- time08 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_08_10}" pattern="#,##0.##"/></th>
                <!-- time07 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_07_10}" pattern="#,##0.##"/></th>
                <!-- time06 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_06_10}" pattern="#,##0.##"/></th>
                <!-- time05 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_05_10}" pattern="#,##0.##"/></th>
                <!-- time04 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_04_10}" pattern="#,##0.##"/></th>
                <!-- time03 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_03_10}" pattern="#,##0.##"/></th>
                <!-- time02 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_02_10}" pattern="#,##0.##"/></th>
                <!-- time01 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_01_10}" pattern="#,##0.##"/></th>
                <!-- 가로열 합계 -->
                <c:set var="timeColTotalSum_10" value="${timeTotalSum_12_10 + timeTotalSum_11_10 + timeTotalSum_10_10 + timeTotalSum_09_10 + timeTotalSum_08_10 + timeTotalSum_07_10 + timeTotalSum_06_10 + timeTotalSum_05_10 + timeTotalSum_04_10 + timeTotalSum_03_10 + timeTotalSum_02_10 + timeTotalSum_01_10}"></c:set>
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeColTotalSum_10}" pattern="#,##0.##"/></th>
            </tr>						
			</tbody>
		</table>
		<!-- 1종 심사 끝 -->
		
		<!-- 1종 기타 시작 -->
		<table>
            <tbody>            
            <!-- 보험사 row를 만들기위한 변수 -->            
            <c:set var="beforePtnrId" value="0"></c:set>
            <!-- 보험사 세부 소계 row를 만들기 위한 변수 -->
            <c:set var="ptnrSubRow" value="1"></c:set>
            <!-- 통계변수 시작 -->
            <c:set var="time12_15" value="0"></c:set>
            <c:set var="time11_15" value="0"></c:set>
            <c:set var="time10_15" value="0"></c:set>
            <c:set var="time09_15" value="0"></c:set>
            <c:set var="time08_15" value="0"></c:set>
            <c:set var="time07_15" value="0"></c:set>
            <c:set var="time06_15" value="0"></c:set>
            <c:set var="time05_15" value="0"></c:set>
            <c:set var="time04_15" value="0"></c:set>
            <c:set var="time03_15" value="0"></c:set>
            <c:set var="time02_15" value="0"></c:set>
            <c:set var="time01_15" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="timePeriodSum_12_15" value="0"></c:set>
            <c:set var="timePeriodSum_11_15" value="0"></c:set>
            <c:set var="timePeriodSum_10_15" value="0"></c:set>
            <c:set var="timePeriodSum_09_15" value="0"></c:set>
            <c:set var="timePeriodSum_08_15" value="0"></c:set>
            <c:set var="timePeriodSum_07_15" value="0"></c:set>
            <c:set var="timePeriodSum_06_15" value="0"></c:set>
            <c:set var="timePeriodSum_05_15" value="0"></c:set>
            <c:set var="timePeriodSum_04_15" value="0"></c:set>
            <c:set var="timePeriodSum_03_15" value="0"></c:set>
            <c:set var="timePeriodSum_02_15" value="0"></c:set>
            <c:set var="timePeriodSum_01_15" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="timePtnrSum_12_15" value="0"></c:set>
            <c:set var="timePtnrSum_11_15" value="0"></c:set>
            <c:set var="timePtnrSum_10_15" value="0"></c:set>
            <c:set var="timePtnrSum_09_15" value="0"></c:set>
            <c:set var="timePtnrSum_08_15" value="0"></c:set>
            <c:set var="timePtnrSum_07_15" value="0"></c:set>
            <c:set var="timePtnrSum_06_15" value="0"></c:set>
            <c:set var="timePtnrSum_05_15" value="0"></c:set>
            <c:set var="timePtnrSum_04_15" value="0"></c:set>
            <c:set var="timePtnrSum_03_15" value="0"></c:set>
            <c:set var="timePtnrSum_02_15" value="0"></c:set>
            <c:set var="timePtnrSum_01_15" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="timeColSum_15" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="timePtnrColSum_15" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="timeTotalSum_12_15" value="0"></c:set>
            <c:set var="timeTotalSum_11_15" value="0"></c:set>
            <c:set var="timeTotalSum_10_15" value="0"></c:set>
            <c:set var="timeTotalSum_09_15" value="0"></c:set>
            <c:set var="timeTotalSum_08_15" value="0"></c:set>
            <c:set var="timeTotalSum_07_15" value="0"></c:set>
            <c:set var="timeTotalSum_06_15" value="0"></c:set>
            <c:set var="timeTotalSum_05_15" value="0"></c:set>
            <c:set var="timeTotalSum_04_15" value="0"></c:set>
            <c:set var="timeTotalSum_03_15" value="0"></c:set>
            <c:set var="timeTotalSum_02_15" value="0"></c:set>
            <c:set var="timeTotalSum_01_15" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="timeColTotalSum_15" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo2" items="${ptnrStatTimeList_15}" varStatus="status">            
                <tr>
                    <c:if test="${status.index == 0}">
                        <td style="width: 80px;" rowspan="${rowCnt}">1종 기타</td>
                    </c:if>
                    
                    <c:choose>
                    	<c:when test="${vo2.ptnrRowCnt == 1}">			<!-- 보험사 세부분류가 없는 경우 -->
                    		<td colspan="3" onclick="goPtnrStatCenter(${vo2.ptnrId});" style="width: 300px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    			${vo2.ptnrNick}
                    		</td>
                    	</c:when>
                    	<c:otherwise>												<!-- 보험사 세부분류가 있는 경우 -->
                    		<c:choose>
		                    	<c:when test="${vo2.ptnrId !=  beforePtnrId and vo2.ptnrRowCnt > 1}">                    	
		                    		<td rowspan="${vo2.ptnrRowCnt+1}" onclick="goPtnrStatCenter(${vo2.ptnrId});" style="width: 100px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.ptnrNick}</td>                    		
				                   	<c:set var="beforePtnrId" value="${vo2.ptnrId}"></c:set>
				                   	<c:set var="ptnrSubRow" value="1"></c:set>
				                   	
				                   	<!-- 보험사 변경 시 보험사 누적합계 초기화 -->
						            <c:set var="timePtnrSum_12_15" value="0"></c:set>
						            <c:set var="timePtnrSum_11_15" value="0"></c:set>
						            <c:set var="timePtnrSum_10_15" value="0"></c:set>
						            <c:set var="timePtnrSum_09_15" value="0"></c:set>
						            <c:set var="timePtnrSum_08_15" value="0"></c:set>
						            <c:set var="timePtnrSum_07_15" value="0"></c:set>
						            <c:set var="timePtnrSum_06_15" value="0"></c:set>
						            <c:set var="timePtnrSum_05_15" value="0"></c:set>
						            <c:set var="timePtnrSum_04_15" value="0"></c:set>
						            <c:set var="timePtnrSum_03_15" value="0"></c:set>
						            <c:set var="timePtnrSum_02_15" value="0"></c:set>
						            <c:set var="timePtnrSum_01_15" value="0"></c:set>
		                    	</c:when>
		                    	<c:when test="${vo2.ptnrId !=  beforePtnrId and vo2.ptnrRowCnt == 1}">
		                    		<td style="width: 100px;">${vo2.ptnrNick}</td>                    		
				                   	<c:set var="beforePtnrId" value="${vo2.ptnrId}"></c:set>
				                   	<c:set var="ptnrSubRow" value="1"></c:set>
		                    	</c:when>
		                    	<c:otherwise>
		                    		<c:set var="ptnrSubRow" value="${ptnrSubRow+1}"></c:set>
		                    	</c:otherwise>
		                    </c:choose>                                        
		                    
		                    <c:choose>
		                    	<c:when test="${vo2.periodFlagCode == 0}">
		                    		<td colspan="2" style="width:200px;">${vo2.ptnrIdSubNm}</td>
		                    	</c:when>
		                    	<c:otherwise>
		                    		<c:if test="${vo2.periodFlagCode == 1 }">
		                    			<td rowspan="3" style="width: 100px;">${vo2.ptnrIdSubNm}</td>	
		                    		</c:if>
		                    		<c:choose>
										<c:when test='${vo2.periodFlagNm == "소계"}'>
											<td style="width: 100px;" class="sum-level-1">${vo2.periodFlagNm}</td>
										</c:when>
										<c:otherwise>
											<td style="width: 100px;">${vo2.periodFlagNm}</td>
										</c:otherwise>
									</c:choose>
		                    	</c:otherwise>
		                    </c:choose>
                    	</c:otherwise>
                    </c:choose>
                    <!-- 소계 열인 경우 통계값에 합산값을 넣어준다. -->  
                    <c:choose>
                    	<c:when test="${vo2.periodFlagCode == 3}">
                    		<c:set var="time12_15" value="${timePeriodSum_12_15}"></c:set>
		                    <c:set var="time11_15" value="${timePeriodSum_11_15}"></c:set>
		                    <c:set var="time10_15" value="${timePeriodSum_10_15}"></c:set>
		                    <c:set var="time09_15" value="${timePeriodSum_09_15}"></c:set>
		                    <c:set var="time08_15" value="${timePeriodSum_08_15}"></c:set>
		                    <c:set var="time07_15" value="${timePeriodSum_07_15}"></c:set>
		                    <c:set var="time06_15" value="${timePeriodSum_06_15}"></c:set>
		                    <c:set var="time05_15" value="${timePeriodSum_05_15}"></c:set>
		                    <c:set var="time04_15" value="${timePeriodSum_04_15}"></c:set>
		                    <c:set var="time03_15" value="${timePeriodSum_03_15}"></c:set>
		                    <c:set var="time02_15" value="${timePeriodSum_02_15}"></c:set>
		                    <c:set var="time01_15" value="${timePeriodSum_01_15}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="time12_15" value="${vo2.time12}"></c:set>
		                    <c:set var="time11_15" value="${vo2.time11}"></c:set>
		                    <c:set var="time10_15" value="${vo2.time10}"></c:set>
		                    <c:set var="time09_15" value="${vo2.time09}"></c:set>
		                    <c:set var="time08_15" value="${vo2.time08}"></c:set>
		                    <c:set var="time07_15" value="${vo2.time07}"></c:set>
		                    <c:set var="time06_15" value="${vo2.time06}"></c:set>
		                    <c:set var="time05_15" value="${vo2.time05}"></c:set>
		                    <c:set var="time04_15" value="${vo2.time04}"></c:set>
		                    <c:set var="time03_15" value="${vo2.time03}"></c:set>
		                    <c:set var="time02_15" value="${vo2.time02}"></c:set>
		                    <c:set var="time01_15" value="${vo2.time01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="timePeriodSum_12_15" value="${timePeriodSum_12_15 + vo2.time12}"></c:set>
		                    <c:set var="timePeriodSum_11_15" value="${timePeriodSum_11_15 + vo2.time11}"></c:set>
		                    <c:set var="timePeriodSum_10_15" value="${timePeriodSum_10_15 + vo2.time10}"></c:set>
		                    <c:set var="timePeriodSum_09_15" value="${timePeriodSum_09_15 + vo2.time09}"></c:set>
		                    <c:set var="timePeriodSum_08_15" value="${timePeriodSum_08_15 + vo2.time08}"></c:set>
		                    <c:set var="timePeriodSum_07_15" value="${timePeriodSum_07_15 + vo2.time07}"></c:set>
		                    <c:set var="timePeriodSum_06_15" value="${timePeriodSum_06_15 + vo2.time06}"></c:set>
		                    <c:set var="timePeriodSum_05_15" value="${timePeriodSum_05_15 + vo2.time05}"></c:set>
		                    <c:set var="timePeriodSum_04_15" value="${timePeriodSum_04_15 + vo2.time04}"></c:set>
		                    <c:set var="timePeriodSum_03_15" value="${timePeriodSum_03_15 + vo2.time03}"></c:set>
		                    <c:set var="timePeriodSum_02_15" value="${timePeriodSum_02_15 + vo2.time02}"></c:set>
		                    <c:set var="timePeriodSum_01_15" value="${timePeriodSum_01_15 + vo2.time01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="timePtnrSum_12_15" value="${timePtnrSum_12_15 + vo2.time12}"></c:set>
		                    <c:set var="timePtnrSum_11_15" value="${timePtnrSum_11_15 + vo2.time11}"></c:set>
		                    <c:set var="timePtnrSum_10_15" value="${timePtnrSum_10_15 + vo2.time10}"></c:set>
		                    <c:set var="timePtnrSum_09_15" value="${timePtnrSum_09_15 + vo2.time09}"></c:set>
		                    <c:set var="timePtnrSum_08_15" value="${timePtnrSum_08_15 + vo2.time08}"></c:set>
		                    <c:set var="timePtnrSum_07_15" value="${timePtnrSum_07_15 + vo2.time07}"></c:set>
		                    <c:set var="timePtnrSum_06_15" value="${timePtnrSum_06_15 + vo2.time06}"></c:set>
		                    <c:set var="timePtnrSum_05_15" value="${timePtnrSum_05_15 + vo2.time05}"></c:set>
		                    <c:set var="timePtnrSum_04_15" value="${timePtnrSum_04_15 + vo2.time04}"></c:set>
		                    <c:set var="timePtnrSum_03_15" value="${timePtnrSum_03_15 + vo2.time03}"></c:set>
		                    <c:set var="timePtnrSum_02_15" value="${timePtnrSum_02_15 + vo2.time02}"></c:set>
		                    <c:set var="timePtnrSum_01_15" value="${timePtnrSum_01_15 + vo2.time01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="timeTotalSum_12_15" value="${timeTotalSum_12_15 + vo2.time12}"></c:set>
		                    <c:set var="timeTotalSum_11_15" value="${timeTotalSum_11_15 + vo2.time11}"></c:set>
		                    <c:set var="timeTotalSum_10_15" value="${timeTotalSum_10_15 + vo2.time10}"></c:set>
		                    <c:set var="timeTotalSum_09_15" value="${timeTotalSum_09_15 + vo2.time09}"></c:set>
		                    <c:set var="timeTotalSum_08_15" value="${timeTotalSum_08_15 + vo2.time08}"></c:set>
		                    <c:set var="timeTotalSum_07_15" value="${timeTotalSum_07_15 + vo2.time07}"></c:set>
		                    <c:set var="timeTotalSum_06_15" value="${timeTotalSum_06_15 + vo2.time06}"></c:set>
		                    <c:set var="timeTotalSum_05_15" value="${timeTotalSum_05_15 + vo2.time05}"></c:set>
		                    <c:set var="timeTotalSum_04_15" value="${timeTotalSum_04_15 + vo2.time04}"></c:set>
		                    <c:set var="timeTotalSum_03_15" value="${timeTotalSum_03_15 + vo2.time03}"></c:set>
		                    <c:set var="timeTotalSum_02_15" value="${timeTotalSum_02_15 + vo2.time02}"></c:set>
		                    <c:set var="timeTotalSum_01_15" value="${timeTotalSum_01_15 + vo2.time01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="timeColSum_15" value="${time12_15 + time11_15 + time10_15 + time09_15 + time08_15 + time07_15 + time06_15 + time05_15 + time04_15 + time03_15 + time02_15 + time01_15}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo2.periodFlagNm == "소계"}'>
							<!-- time12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1"><fmt:formatNumber value="${time12_15}" pattern="#,##0.##"/></td>
		                    <!-- time11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time11_15}" pattern="#,##0.##"/></td>
		                    <!-- time10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time10_15}" pattern="#,##0.##"/></td>
		                    <!-- time09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time09_15}" pattern="#,##0.##"/></td>
		                    <!-- time08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time08_15}" pattern="#,##0.##"/></td>
		                    <!-- time07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time07_15}" pattern="#,##0.##"/></td>
		                    <!-- time06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time06_15}" pattern="#,##0.##"/></td>
		                    <!-- time05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time05_15}" pattern="#,##0.##"/></td>
		                    <!-- time04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time04_15}" pattern="#,##0.##"/></td>
		                    <!-- time03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time03_15}" pattern="#,##0.##"/></td>
		                    <!-- time02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time02_15}" pattern="#,##0.##"/></td>
		                    <!-- time01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${time01_15}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${timeColSum_15}" pattern="#,##0.##"/></td>
						</c:when>
						<c:otherwise>
							<!-- time12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${time12_15}" pattern="#,##0.##"/></td>
		                    <!-- time11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time11_15}" pattern="#,##0.##"/></td>
		                    <!-- time10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time10_15}" pattern="#,##0.##"/></td>
		                    <!-- time09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time09_15}" pattern="#,##0.##"/></td>
		                    <!-- time08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time08_15}" pattern="#,##0.##"/></td>
		                    <!-- time07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time07_15}" pattern="#,##0.##"/></td>
		                    <!-- time06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time06_15}" pattern="#,##0.##"/></td>
		                    <!-- time05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time05_15}" pattern="#,##0.##"/></td>
		                    <!-- time04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time04_15}" pattern="#,##0.##"/></td>
		                    <!-- time03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time03_15}" pattern="#,##0.##"/></td>
		                    <!-- time02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time02_15}" pattern="#,##0.##"/></td>
		                    <!-- time01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time01_15}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeColSum_15}" pattern="#,##0.##"/></td>
						</c:otherwise>
					</c:choose>  
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo2.periodFlagCode == 3}">
                    	<c:set var="timePeriodSum_12_15" value="0"></c:set>
			            <c:set var="timePeriodSum_11_15" value="0"></c:set>
			            <c:set var="timePeriodSum_10_15" value="0"></c:set>
			            <c:set var="timePeriodSum_09_15" value="0"></c:set>
			            <c:set var="timePeriodSum_08_15" value="0"></c:set>
			            <c:set var="timePeriodSum_07_15" value="0"></c:set>
			            <c:set var="timePeriodSum_06_15" value="0"></c:set>
			            <c:set var="timePeriodSum_05_15" value="0"></c:set>
			            <c:set var="timePeriodSum_04_15" value="0"></c:set>
			            <c:set var="timePeriodSum_03_15" value="0"></c:set>
			            <c:set var="timePeriodSum_02_15" value="0"></c:set>
			            <c:set var="timePeriodSum_01_15" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo2.ptnrRowCnt > 1}">
                	<c:if test="${vo2.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="timePeriodSum_12_15" value="0"></c:set>
			            <c:set var="timePeriodSum_11_15" value="0"></c:set>
			            <c:set var="timePeriodSum_10_15" value="0"></c:set>
			            <c:set var="timePeriodSum_09_15" value="0"></c:set>
			            <c:set var="timePeriodSum_08_15" value="0"></c:set>
			            <c:set var="timePeriodSum_07_15" value="0"></c:set>
			            <c:set var="timePeriodSum_06_15" value="0"></c:set>
			            <c:set var="timePeriodSum_05_15" value="0"></c:set>
			            <c:set var="timePeriodSum_04_15" value="0"></c:set>
			            <c:set var="timePeriodSum_03_15" value="0"></c:set>
			            <c:set var="timePeriodSum_02_15" value="0"></c:set>
			            <c:set var="timePeriodSum_01_15" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- time12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_12_15}" pattern="#,##0.##"/></td>
		                    <!-- time11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_11_15}" pattern="#,##0.##"/></td>
		                    <!-- time10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_10_15}" pattern="#,##0.##"/></td>
		                    <!-- time09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_09_15}" pattern="#,##0.##"/></td>
		                    <!-- time08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_08_15}" pattern="#,##0.##"/></td>
		                    <!-- time07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_07_15}" pattern="#,##0.##"/></td>
		                    <!-- time06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_06_15}" pattern="#,##0.##"/></td>
		                    <!-- time05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_05_15}" pattern="#,##0.##"/></td>
		                    <!-- time04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_04_15}" pattern="#,##0.##"/></td>
		                    <!-- time03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_03_15}" pattern="#,##0.##"/></td>
		                    <!-- time02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_02_15}" pattern="#,##0.##"/></td>
		                    <!-- time01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrSum_01_15}" pattern="#,##0.##"/></td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="timePtnrColSum_15" value="${timePtnrSum_12_15 + timePtnrSum_11_15 + timePtnrSum_10_15 + timePtnrSum_09_15 + timePtnrSum_08_15 + timePtnrSum_07_15 + timePtnrSum_06_15 + timePtnrSum_05_15 + timePtnrSum_04_15 + timePtnrSum_03_15 + timePtnrSum_02_15 + timePtnrSum_01_15}"></c:set>
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timePtnrColSum_15}" pattern="#,##0.##"/></td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 기타 소계</th>
                <!-- time12 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_12_15}" pattern="#,##0.##"/></th>
                <!-- time11 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_11_15}" pattern="#,##0.##"/></th>
                <!-- time10 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_10_15}" pattern="#,##0.##"/></th>
                <!-- time09 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_09_15}" pattern="#,##0.##"/></th>
                <!-- time08 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_08_15}" pattern="#,##0.##"/></th>
                <!-- time07 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_07_15}" pattern="#,##0.##"/></th>
                <!-- time06 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_06_15}" pattern="#,##0.##"/></th>
                <!-- time05 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_05_15}" pattern="#,##0.##"/></th>
                <!-- time04 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_04_15}" pattern="#,##0.##"/></th>
                <!-- time03 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_03_15}" pattern="#,##0.##"/></th>
                <!-- time02 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_02_15}" pattern="#,##0.##"/></th>
                <!-- time01 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeTotalSum_01_15}" pattern="#,##0.##"/></th>
                <!-- 가로열 합계 -->
                <c:set var="timeColTotalSum_15" value="${timeTotalSum_12_15 + timeTotalSum_11_15 + timeTotalSum_10_15 + timeTotalSum_09_15 + timeTotalSum_08_15 + timeTotalSum_07_15 + timeTotalSum_06_15 + timeTotalSum_05_15 + timeTotalSum_04_15 + timeTotalSum_03_15 + timeTotalSum_02_15 + timeTotalSum_01_15}"></c:set>
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeColTotalSum_15}" pattern="#,##0.##"/></th>
            </tr>						
			</tbody>
		</table>		
		<!-- 1종 기타 끝 -->
    </div>    
    <!-- 총 합계 시작 -->
    <!-- 총 합계 변수 시작 -->
    <c:set var="timeTotalSum_12_all" value="${timeTotalSum_12_5 + timeTotalSum_12_10 + timeTotalSum_12_15}"></c:set>
    <c:set var="timeTotalSum_11_all" value="${timeTotalSum_11_5 + timeTotalSum_11_10 + timeTotalSum_11_15}"></c:set>
    <c:set var="timeTotalSum_10_all" value="${timeTotalSum_10_5 + timeTotalSum_10_10 + timeTotalSum_10_15}"></c:set>
    <c:set var="timeTotalSum_09_all" value="${timeTotalSum_09_5 + timeTotalSum_09_10 + timeTotalSum_09_15}"></c:set>
    <c:set var="timeTotalSum_08_all" value="${timeTotalSum_08_5 + timeTotalSum_08_10 + timeTotalSum_08_15}"></c:set>
    <c:set var="timeTotalSum_07_all" value="${timeTotalSum_07_5 + timeTotalSum_07_10 + timeTotalSum_07_15}"></c:set>
    <c:set var="timeTotalSum_06_all" value="${timeTotalSum_06_5 + timeTotalSum_06_10 + timeTotalSum_06_15}"></c:set>
    <c:set var="timeTotalSum_05_all" value="${timeTotalSum_05_5 + timeTotalSum_05_10 + timeTotalSum_05_15}"></c:set>
    <c:set var="timeTotalSum_04_all" value="${timeTotalSum_04_5 + timeTotalSum_04_10 + timeTotalSum_04_15}"></c:set>
    <c:set var="timeTotalSum_03_all" value="${timeTotalSum_03_5 + timeTotalSum_03_10 + timeTotalSum_03_15}"></c:set>
    <c:set var="timeTotalSum_02_all" value="${timeTotalSum_02_5 + timeTotalSum_02_10 + timeTotalSum_02_15}"></c:set>
    <c:set var="timeTotalSum_01_all" value="${timeTotalSum_01_5 + timeTotalSum_01_10 + timeTotalSum_01_15}"></c:set>        
    <c:set var="timeTotalSum_col_all" value="${timeTotalSum_12_all + timeTotalSum_11_all + timeTotalSum_10_all + timeTotalSum_09_all + timeTotalSum_08_all + timeTotalSum_07_all + timeTotalSum_06_all + timeTotalSum_05_all + timeTotalSum_04_all + timeTotalSum_03_all + timeTotalSum_02_all + timeTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체합계</th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeTotalSum_01_all}" pattern="#,##0.##"/></th>
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeTotalSum_col_all}" pattern="#,##0.##"/></th>
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>
