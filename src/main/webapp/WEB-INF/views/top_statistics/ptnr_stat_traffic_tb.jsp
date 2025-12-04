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
            <c:set var="traffic12_5" value="0"></c:set>
            <c:set var="traffic11_5" value="0"></c:set>
            <c:set var="traffic10_5" value="0"></c:set>
            <c:set var="traffic09_5" value="0"></c:set>
            <c:set var="traffic08_5" value="0"></c:set>
            <c:set var="traffic07_5" value="0"></c:set>
            <c:set var="traffic06_5" value="0"></c:set>
            <c:set var="traffic05_5" value="0"></c:set>
            <c:set var="traffic04_5" value="0"></c:set>
            <c:set var="traffic03_5" value="0"></c:set>
            <c:set var="traffic02_5" value="0"></c:set>
            <c:set var="traffic01_5" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="trafficPeriodSum_12_5" value="0"></c:set>
            <c:set var="trafficPeriodSum_11_5" value="0"></c:set>
            <c:set var="trafficPeriodSum_10_5" value="0"></c:set>
            <c:set var="trafficPeriodSum_09_5" value="0"></c:set>
            <c:set var="trafficPeriodSum_08_5" value="0"></c:set>
            <c:set var="trafficPeriodSum_07_5" value="0"></c:set>
            <c:set var="trafficPeriodSum_06_5" value="0"></c:set>
            <c:set var="trafficPeriodSum_05_5" value="0"></c:set>
            <c:set var="trafficPeriodSum_04_5" value="0"></c:set>
            <c:set var="trafficPeriodSum_03_5" value="0"></c:set>
            <c:set var="trafficPeriodSum_02_5" value="0"></c:set>
            <c:set var="trafficPeriodSum_01_5" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="trafficPtnrSum_12_5" value="0"></c:set>
            <c:set var="trafficPtnrSum_11_5" value="0"></c:set>
            <c:set var="trafficPtnrSum_10_5" value="0"></c:set>
            <c:set var="trafficPtnrSum_09_5" value="0"></c:set>
            <c:set var="trafficPtnrSum_08_5" value="0"></c:set>
            <c:set var="trafficPtnrSum_07_5" value="0"></c:set>
            <c:set var="trafficPtnrSum_06_5" value="0"></c:set>
            <c:set var="trafficPtnrSum_05_5" value="0"></c:set>
            <c:set var="trafficPtnrSum_04_5" value="0"></c:set>
            <c:set var="trafficPtnrSum_03_5" value="0"></c:set>
            <c:set var="trafficPtnrSum_02_5" value="0"></c:set>
            <c:set var="trafficPtnrSum_01_5" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="trafficColSum_5" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="trafficPtnrColSum_5" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="trafficTotalSum_12_5" value="0"></c:set>
            <c:set var="trafficTotalSum_11_5" value="0"></c:set>
            <c:set var="trafficTotalSum_10_5" value="0"></c:set>
            <c:set var="trafficTotalSum_09_5" value="0"></c:set>
            <c:set var="trafficTotalSum_08_5" value="0"></c:set>
            <c:set var="trafficTotalSum_07_5" value="0"></c:set>
            <c:set var="trafficTotalSum_06_5" value="0"></c:set>
            <c:set var="trafficTotalSum_05_5" value="0"></c:set>
            <c:set var="trafficTotalSum_04_5" value="0"></c:set>
            <c:set var="trafficTotalSum_03_5" value="0"></c:set>
            <c:set var="trafficTotalSum_02_5" value="0"></c:set>
            <c:set var="trafficTotalSum_01_5" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="trafficColTotalSum_5" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo" items="${ptnrStatTrafficList}" varStatus="status">            
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
						            <c:set var="trafficPtnrSum_12_5" value="0"></c:set>
						            <c:set var="trafficPtnrSum_11_5" value="0"></c:set>
						            <c:set var="trafficPtnrSum_10_5" value="0"></c:set>
						            <c:set var="trafficPtnrSum_09_5" value="0"></c:set>
						            <c:set var="trafficPtnrSum_08_5" value="0"></c:set>
						            <c:set var="trafficPtnrSum_07_5" value="0"></c:set>
						            <c:set var="trafficPtnrSum_06_5" value="0"></c:set>
						            <c:set var="trafficPtnrSum_05_5" value="0"></c:set>
						            <c:set var="trafficPtnrSum_04_5" value="0"></c:set>
						            <c:set var="trafficPtnrSum_03_5" value="0"></c:set>
						            <c:set var="trafficPtnrSum_02_5" value="0"></c:set>
						            <c:set var="trafficPtnrSum_01_5" value="0"></c:set>
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
                    		<c:set var="traffic12_5" value="${trafficPeriodSum_12_5}"></c:set>
		                    <c:set var="traffic11_5" value="${trafficPeriodSum_11_5}"></c:set>
		                    <c:set var="traffic10_5" value="${trafficPeriodSum_10_5}"></c:set>
		                    <c:set var="traffic09_5" value="${trafficPeriodSum_09_5}"></c:set>
		                    <c:set var="traffic08_5" value="${trafficPeriodSum_08_5}"></c:set>
		                    <c:set var="traffic07_5" value="${trafficPeriodSum_07_5}"></c:set>
		                    <c:set var="traffic06_5" value="${trafficPeriodSum_06_5}"></c:set>
		                    <c:set var="traffic05_5" value="${trafficPeriodSum_05_5}"></c:set>
		                    <c:set var="traffic04_5" value="${trafficPeriodSum_04_5}"></c:set>
		                    <c:set var="traffic03_5" value="${trafficPeriodSum_03_5}"></c:set>
		                    <c:set var="traffic02_5" value="${trafficPeriodSum_02_5}"></c:set>
		                    <c:set var="traffic01_5" value="${trafficPeriodSum_01_5}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="traffic12_5" value="${vo.traffic12}"></c:set>
		                    <c:set var="traffic11_5" value="${vo.traffic11}"></c:set>
		                    <c:set var="traffic10_5" value="${vo.traffic10}"></c:set>
		                    <c:set var="traffic09_5" value="${vo.traffic09}"></c:set>
		                    <c:set var="traffic08_5" value="${vo.traffic08}"></c:set>
		                    <c:set var="traffic07_5" value="${vo.traffic07}"></c:set>
		                    <c:set var="traffic06_5" value="${vo.traffic06}"></c:set>
		                    <c:set var="traffic05_5" value="${vo.traffic05}"></c:set>
		                    <c:set var="traffic04_5" value="${vo.traffic04}"></c:set>
		                    <c:set var="traffic03_5" value="${vo.traffic03}"></c:set>
		                    <c:set var="traffic02_5" value="${vo.traffic02}"></c:set>
		                    <c:set var="traffic01_5" value="${vo.traffic01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="trafficPeriodSum_12_5" value="${trafficPeriodSum_12_5 + vo.traffic12}"></c:set>
		                    <c:set var="trafficPeriodSum_11_5" value="${trafficPeriodSum_11_5 + vo.traffic11}"></c:set>
		                    <c:set var="trafficPeriodSum_10_5" value="${trafficPeriodSum_10_5 + vo.traffic10}"></c:set>
		                    <c:set var="trafficPeriodSum_09_5" value="${trafficPeriodSum_09_5 + vo.traffic09}"></c:set>
		                    <c:set var="trafficPeriodSum_08_5" value="${trafficPeriodSum_08_5 + vo.traffic08}"></c:set>
		                    <c:set var="trafficPeriodSum_07_5" value="${trafficPeriodSum_07_5 + vo.traffic07}"></c:set>
		                    <c:set var="trafficPeriodSum_06_5" value="${trafficPeriodSum_06_5 + vo.traffic06}"></c:set>
		                    <c:set var="trafficPeriodSum_05_5" value="${trafficPeriodSum_05_5 + vo.traffic05}"></c:set>
		                    <c:set var="trafficPeriodSum_04_5" value="${trafficPeriodSum_04_5 + vo.traffic04}"></c:set>
		                    <c:set var="trafficPeriodSum_03_5" value="${trafficPeriodSum_03_5 + vo.traffic03}"></c:set>
		                    <c:set var="trafficPeriodSum_02_5" value="${trafficPeriodSum_02_5 + vo.traffic02}"></c:set>
		                    <c:set var="trafficPeriodSum_01_5" value="${trafficPeriodSum_01_5 + vo.traffic01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="trafficPtnrSum_12_5" value="${trafficPtnrSum_12_5 + vo.traffic12}"></c:set>
		                    <c:set var="trafficPtnrSum_11_5" value="${trafficPtnrSum_11_5 + vo.traffic11}"></c:set>
		                    <c:set var="trafficPtnrSum_10_5" value="${trafficPtnrSum_10_5 + vo.traffic10}"></c:set>
		                    <c:set var="trafficPtnrSum_09_5" value="${trafficPtnrSum_09_5 + vo.traffic09}"></c:set>
		                    <c:set var="trafficPtnrSum_08_5" value="${trafficPtnrSum_08_5 + vo.traffic08}"></c:set>
		                    <c:set var="trafficPtnrSum_07_5" value="${trafficPtnrSum_07_5 + vo.traffic07}"></c:set>
		                    <c:set var="trafficPtnrSum_06_5" value="${trafficPtnrSum_06_5 + vo.traffic06}"></c:set>
		                    <c:set var="trafficPtnrSum_05_5" value="${trafficPtnrSum_05_5 + vo.traffic05}"></c:set>
		                    <c:set var="trafficPtnrSum_04_5" value="${trafficPtnrSum_04_5 + vo.traffic04}"></c:set>
		                    <c:set var="trafficPtnrSum_03_5" value="${trafficPtnrSum_03_5 + vo.traffic03}"></c:set>
		                    <c:set var="trafficPtnrSum_02_5" value="${trafficPtnrSum_02_5 + vo.traffic02}"></c:set>
		                    <c:set var="trafficPtnrSum_01_5" value="${trafficPtnrSum_01_5 + vo.traffic01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="trafficTotalSum_12_5" value="${trafficTotalSum_12_5 + vo.traffic12}"></c:set>
		                    <c:set var="trafficTotalSum_11_5" value="${trafficTotalSum_11_5 + vo.traffic11}"></c:set>
		                    <c:set var="trafficTotalSum_10_5" value="${trafficTotalSum_10_5 + vo.traffic10}"></c:set>
		                    <c:set var="trafficTotalSum_09_5" value="${trafficTotalSum_09_5 + vo.traffic09}"></c:set>
		                    <c:set var="trafficTotalSum_08_5" value="${trafficTotalSum_08_5 + vo.traffic08}"></c:set>
		                    <c:set var="trafficTotalSum_07_5" value="${trafficTotalSum_07_5 + vo.traffic07}"></c:set>
		                    <c:set var="trafficTotalSum_06_5" value="${trafficTotalSum_06_5 + vo.traffic06}"></c:set>
		                    <c:set var="trafficTotalSum_05_5" value="${trafficTotalSum_05_5 + vo.traffic05}"></c:set>
		                    <c:set var="trafficTotalSum_04_5" value="${trafficTotalSum_04_5 + vo.traffic04}"></c:set>
		                    <c:set var="trafficTotalSum_03_5" value="${trafficTotalSum_03_5 + vo.traffic03}"></c:set>
		                    <c:set var="trafficTotalSum_02_5" value="${trafficTotalSum_02_5 + vo.traffic02}"></c:set>
		                    <c:set var="trafficTotalSum_01_5" value="${trafficTotalSum_01_5 + vo.traffic01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="trafficColSum_5" value="${traffic12_5 + traffic11_5 + traffic10_5 + traffic09_5 + traffic08_5 + traffic07_5 + traffic06_5 + traffic05_5 + traffic04_5 + traffic03_5 + traffic02_5 + traffic01_5}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo.periodFlagNm == "소계"}'>
							<!-- traffic12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1"><fmt:formatNumber value="${traffic12_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic11_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic10_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic09_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic08_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic07_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic06_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic05_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic04_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic03_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic02_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic01_5}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${trafficColSum_5}" pattern="#,##0.##"/></td>
						</c:when>
						<c:otherwise>
							<!-- traffic12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${traffic12_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic11_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic10_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic09_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic08_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic07_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic06_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic05_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic04_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic03_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic02_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic01_5}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficColSum_5}" pattern="#,##0.##"/></td>
						</c:otherwise>
					</c:choose>  
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo.periodFlagCode == 3}">
                    	<c:set var="trafficPeriodSum_12_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_11_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_10_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_09_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_08_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_07_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_06_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_05_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_04_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_03_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_02_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_01_5" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo.ptnrRowCnt > 1}">
                	<c:if test="${vo.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="trafficPeriodSum_12_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_11_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_10_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_09_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_08_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_07_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_06_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_05_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_04_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_03_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_02_5" value="0"></c:set>
			            <c:set var="trafficPeriodSum_01_5" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- traffic12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_12_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_11_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_10_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_09_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_08_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_07_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_06_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_05_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_04_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_03_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_02_5}" pattern="#,##0.##"/></td>
		                    <!-- traffic01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_01_5}" pattern="#,##0.##"/></td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="trafficPtnrColSum_5" value="${trafficPtnrSum_12_5 + trafficPtnrSum_11_5 + trafficPtnrSum_10_5 + trafficPtnrSum_09_5 + trafficPtnrSum_08_5 + trafficPtnrSum_07_5 + trafficPtnrSum_06_5 + trafficPtnrSum_05_5 + trafficPtnrSum_04_5 + trafficPtnrSum_03_5 + trafficPtnrSum_02_5 + trafficPtnrSum_01_5}"></c:set>
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficPtnrColSum_5}" pattern="#,##0.##"/></td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 조사 소계</th>
                <!-- traffic12 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_12_5}" pattern="#,##0.##"/></th>
                <!-- traffic11 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_11_5}" pattern="#,##0.##"/></th>
                <!-- traffic10 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_10_5}" pattern="#,##0.##"/></th>
                <!-- traffic09 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_09_5}" pattern="#,##0.##"/></th>
                <!-- traffic08 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_08_5}" pattern="#,##0.##"/></th>
                <!-- traffic07 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_07_5}" pattern="#,##0.##"/></th>
                <!-- traffic06 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_06_5}" pattern="#,##0.##"/></th>
                <!-- traffic05 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_05_5}" pattern="#,##0.##"/></th>
                <!-- traffic04 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_04_5}" pattern="#,##0.##"/></th>
                <!-- traffic03 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_03_5}" pattern="#,##0.##"/></th>
                <!-- traffic02 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_02_5}" pattern="#,##0.##"/></th>
                <!-- traffic01 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_01_5}" pattern="#,##0.##"/></th>
                <!-- 가로열 합계 -->
                <c:set var="trafficColTotalSum_5" value="${trafficTotalSum_12_5 + trafficTotalSum_11_5 + trafficTotalSum_10_5 + trafficTotalSum_09_5 + trafficTotalSum_08_5 + trafficTotalSum_07_5 + trafficTotalSum_06_5 + trafficTotalSum_05_5 + trafficTotalSum_04_5 + trafficTotalSum_03_5 + trafficTotalSum_02_5 + trafficTotalSum_01_5}"></c:set>
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficColTotalSum_5}" pattern="#,##0.##"/></th>
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
            <c:set var="traffic12_10" value="0"></c:set>
            <c:set var="traffic11_10" value="0"></c:set>
            <c:set var="traffic10_10" value="0"></c:set>
            <c:set var="traffic09_10" value="0"></c:set>
            <c:set var="traffic08_10" value="0"></c:set>
            <c:set var="traffic07_10" value="0"></c:set>
            <c:set var="traffic06_10" value="0"></c:set>
            <c:set var="traffic05_10" value="0"></c:set>
            <c:set var="traffic04_10" value="0"></c:set>
            <c:set var="traffic03_10" value="0"></c:set>
            <c:set var="traffic02_10" value="0"></c:set>
            <c:set var="traffic01_10" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="trafficPeriodSum_12_10" value="0"></c:set>
            <c:set var="trafficPeriodSum_11_10" value="0"></c:set>
            <c:set var="trafficPeriodSum_10_10" value="0"></c:set>
            <c:set var="trafficPeriodSum_09_10" value="0"></c:set>
            <c:set var="trafficPeriodSum_08_10" value="0"></c:set>
            <c:set var="trafficPeriodSum_07_10" value="0"></c:set>
            <c:set var="trafficPeriodSum_06_10" value="0"></c:set>
            <c:set var="trafficPeriodSum_05_10" value="0"></c:set>
            <c:set var="trafficPeriodSum_04_10" value="0"></c:set>
            <c:set var="trafficPeriodSum_03_10" value="0"></c:set>
            <c:set var="trafficPeriodSum_02_10" value="0"></c:set>
            <c:set var="trafficPeriodSum_01_10" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="trafficPtnrSum_12_10" value="0"></c:set>
            <c:set var="trafficPtnrSum_11_10" value="0"></c:set>
            <c:set var="trafficPtnrSum_10_10" value="0"></c:set>
            <c:set var="trafficPtnrSum_09_10" value="0"></c:set>
            <c:set var="trafficPtnrSum_08_10" value="0"></c:set>
            <c:set var="trafficPtnrSum_07_10" value="0"></c:set>
            <c:set var="trafficPtnrSum_06_10" value="0"></c:set>
            <c:set var="trafficPtnrSum_05_10" value="0"></c:set>
            <c:set var="trafficPtnrSum_04_10" value="0"></c:set>
            <c:set var="trafficPtnrSum_03_10" value="0"></c:set>
            <c:set var="trafficPtnrSum_02_10" value="0"></c:set>
            <c:set var="trafficPtnrSum_01_10" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="trafficColSum_10" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="trafficPtnrColSum_10" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="trafficTotalSum_12_10" value="0"></c:set>
            <c:set var="trafficTotalSum_11_10" value="0"></c:set>
            <c:set var="trafficTotalSum_10_10" value="0"></c:set>
            <c:set var="trafficTotalSum_09_10" value="0"></c:set>
            <c:set var="trafficTotalSum_08_10" value="0"></c:set>
            <c:set var="trafficTotalSum_07_10" value="0"></c:set>
            <c:set var="trafficTotalSum_06_10" value="0"></c:set>
            <c:set var="trafficTotalSum_05_10" value="0"></c:set>
            <c:set var="trafficTotalSum_04_10" value="0"></c:set>
            <c:set var="trafficTotalSum_03_10" value="0"></c:set>
            <c:set var="trafficTotalSum_02_10" value="0"></c:set>
            <c:set var="trafficTotalSum_01_10" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="trafficColTotalSum_10" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo1" items="${ptnrStatTrafficList_10}" varStatus="status">            
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
						            <c:set var="trafficPtnrSum_12_10" value="0"></c:set>
						            <c:set var="trafficPtnrSum_11_10" value="0"></c:set>
						            <c:set var="trafficPtnrSum_10_10" value="0"></c:set>
						            <c:set var="trafficPtnrSum_09_10" value="0"></c:set>
						            <c:set var="trafficPtnrSum_08_10" value="0"></c:set>
						            <c:set var="trafficPtnrSum_07_10" value="0"></c:set>
						            <c:set var="trafficPtnrSum_06_10" value="0"></c:set>
						            <c:set var="trafficPtnrSum_05_10" value="0"></c:set>
						            <c:set var="trafficPtnrSum_04_10" value="0"></c:set>
						            <c:set var="trafficPtnrSum_03_10" value="0"></c:set>
						            <c:set var="trafficPtnrSum_02_10" value="0"></c:set>
						            <c:set var="trafficPtnrSum_01_10" value="0"></c:set>
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
                    		<c:set var="traffic12_10" value="${trafficPeriodSum_12_10}"></c:set>
		                    <c:set var="traffic11_10" value="${trafficPeriodSum_11_10}"></c:set>
		                    <c:set var="traffic10_10" value="${trafficPeriodSum_10_10}"></c:set>
		                    <c:set var="traffic09_10" value="${trafficPeriodSum_09_10}"></c:set>
		                    <c:set var="traffic08_10" value="${trafficPeriodSum_08_10}"></c:set>
		                    <c:set var="traffic07_10" value="${trafficPeriodSum_07_10}"></c:set>
		                    <c:set var="traffic06_10" value="${trafficPeriodSum_06_10}"></c:set>
		                    <c:set var="traffic05_10" value="${trafficPeriodSum_05_10}"></c:set>
		                    <c:set var="traffic04_10" value="${trafficPeriodSum_04_10}"></c:set>
		                    <c:set var="traffic03_10" value="${trafficPeriodSum_03_10}"></c:set>
		                    <c:set var="traffic02_10" value="${trafficPeriodSum_02_10}"></c:set>
		                    <c:set var="traffic01_10" value="${trafficPeriodSum_01_10}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="traffic12_10" value="${vo1.traffic12}"></c:set>
		                    <c:set var="traffic11_10" value="${vo1.traffic11}"></c:set>
		                    <c:set var="traffic10_10" value="${vo1.traffic10}"></c:set>
		                    <c:set var="traffic09_10" value="${vo1.traffic09}"></c:set>
		                    <c:set var="traffic08_10" value="${vo1.traffic08}"></c:set>
		                    <c:set var="traffic07_10" value="${vo1.traffic07}"></c:set>
		                    <c:set var="traffic06_10" value="${vo1.traffic06}"></c:set>
		                    <c:set var="traffic05_10" value="${vo1.traffic05}"></c:set>
		                    <c:set var="traffic04_10" value="${vo1.traffic04}"></c:set>
		                    <c:set var="traffic03_10" value="${vo1.traffic03}"></c:set>
		                    <c:set var="traffic02_10" value="${vo1.traffic02}"></c:set>
		                    <c:set var="traffic01_10" value="${vo1.traffic01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="trafficPeriodSum_12_10" value="${trafficPeriodSum_12_10 + vo1.traffic12}"></c:set>
		                    <c:set var="trafficPeriodSum_11_10" value="${trafficPeriodSum_11_10 + vo1.traffic11}"></c:set>
		                    <c:set var="trafficPeriodSum_10_10" value="${trafficPeriodSum_10_10 + vo1.traffic10}"></c:set>
		                    <c:set var="trafficPeriodSum_09_10" value="${trafficPeriodSum_09_10 + vo1.traffic09}"></c:set>
		                    <c:set var="trafficPeriodSum_08_10" value="${trafficPeriodSum_08_10 + vo1.traffic08}"></c:set>
		                    <c:set var="trafficPeriodSum_07_10" value="${trafficPeriodSum_07_10 + vo1.traffic07}"></c:set>
		                    <c:set var="trafficPeriodSum_06_10" value="${trafficPeriodSum_06_10 + vo1.traffic06}"></c:set>
		                    <c:set var="trafficPeriodSum_05_10" value="${trafficPeriodSum_05_10 + vo1.traffic05}"></c:set>
		                    <c:set var="trafficPeriodSum_04_10" value="${trafficPeriodSum_04_10 + vo1.traffic04}"></c:set>
		                    <c:set var="trafficPeriodSum_03_10" value="${trafficPeriodSum_03_10 + vo1.traffic03}"></c:set>
		                    <c:set var="trafficPeriodSum_02_10" value="${trafficPeriodSum_02_10 + vo1.traffic02}"></c:set>
		                    <c:set var="trafficPeriodSum_01_10" value="${trafficPeriodSum_01_10 + vo1.traffic01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="trafficPtnrSum_12_10" value="${trafficPtnrSum_12_10 + vo1.traffic12}"></c:set>
		                    <c:set var="trafficPtnrSum_11_10" value="${trafficPtnrSum_11_10 + vo1.traffic11}"></c:set>
		                    <c:set var="trafficPtnrSum_10_10" value="${trafficPtnrSum_10_10 + vo1.traffic10}"></c:set>
		                    <c:set var="trafficPtnrSum_09_10" value="${trafficPtnrSum_09_10 + vo1.traffic09}"></c:set>
		                    <c:set var="trafficPtnrSum_08_10" value="${trafficPtnrSum_08_10 + vo1.traffic08}"></c:set>
		                    <c:set var="trafficPtnrSum_07_10" value="${trafficPtnrSum_07_10 + vo1.traffic07}"></c:set>
		                    <c:set var="trafficPtnrSum_06_10" value="${trafficPtnrSum_06_10 + vo1.traffic06}"></c:set>
		                    <c:set var="trafficPtnrSum_05_10" value="${trafficPtnrSum_05_10 + vo1.traffic05}"></c:set>
		                    <c:set var="trafficPtnrSum_04_10" value="${trafficPtnrSum_04_10 + vo1.traffic04}"></c:set>
		                    <c:set var="trafficPtnrSum_03_10" value="${trafficPtnrSum_03_10 + vo1.traffic03}"></c:set>
		                    <c:set var="trafficPtnrSum_02_10" value="${trafficPtnrSum_02_10 + vo1.traffic02}"></c:set>
		                    <c:set var="trafficPtnrSum_01_10" value="${trafficPtnrSum_01_10 + vo1.traffic01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="trafficTotalSum_12_10" value="${trafficTotalSum_12_10 + vo1.traffic12}"></c:set>
		                    <c:set var="trafficTotalSum_11_10" value="${trafficTotalSum_11_10 + vo1.traffic11}"></c:set>
		                    <c:set var="trafficTotalSum_10_10" value="${trafficTotalSum_10_10 + vo1.traffic10}"></c:set>
		                    <c:set var="trafficTotalSum_09_10" value="${trafficTotalSum_09_10 + vo1.traffic09}"></c:set>
		                    <c:set var="trafficTotalSum_08_10" value="${trafficTotalSum_08_10 + vo1.traffic08}"></c:set>
		                    <c:set var="trafficTotalSum_07_10" value="${trafficTotalSum_07_10 + vo1.traffic07}"></c:set>
		                    <c:set var="trafficTotalSum_06_10" value="${trafficTotalSum_06_10 + vo1.traffic06}"></c:set>
		                    <c:set var="trafficTotalSum_05_10" value="${trafficTotalSum_05_10 + vo1.traffic05}"></c:set>
		                    <c:set var="trafficTotalSum_04_10" value="${trafficTotalSum_04_10 + vo1.traffic04}"></c:set>
		                    <c:set var="trafficTotalSum_03_10" value="${trafficTotalSum_03_10 + vo1.traffic03}"></c:set>
		                    <c:set var="trafficTotalSum_02_10" value="${trafficTotalSum_02_10 + vo1.traffic02}"></c:set>
		                    <c:set var="trafficTotalSum_01_10" value="${trafficTotalSum_01_10 + vo1.traffic01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="trafficColSum_10" value="${traffic12_10 + traffic11_10 + traffic10_10 + traffic09_10 + traffic08_10 + traffic07_10 + traffic06_10 + traffic05_10 + traffic04_10 + traffic03_10 + traffic02_10 + traffic01_10}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo1.periodFlagNm == "소계"}'>
							<!-- traffic12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1"><fmt:formatNumber value="${traffic12_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic11_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic10_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic09_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic08_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic07_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic06_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic05_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic04_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic03_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic02_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic01_10}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${trafficColSum_10}" pattern="#,##0.##"/></td>
						</c:when>
						<c:otherwise>
							<!-- traffic12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${traffic12_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic11_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic10_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic09_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic08_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic07_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic06_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic05_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic04_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic03_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic02_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic01_10}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficColSum_10}" pattern="#,##0.##"/></td>
						</c:otherwise>
					</c:choose>  
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo1.periodFlagCode == 3}">
                    	<c:set var="trafficPeriodSum_12_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_11_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_10_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_09_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_08_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_07_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_06_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_05_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_04_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_03_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_02_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_01_10" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo1.ptnrRowCnt > 1}">
                	<c:if test="${vo1.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="trafficPeriodSum_12_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_11_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_10_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_09_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_08_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_07_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_06_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_05_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_04_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_03_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_02_10" value="0"></c:set>
			            <c:set var="trafficPeriodSum_01_10" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- traffic12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_12_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_11_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_10_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_09_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_08_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_07_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_06_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_05_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_04_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_03_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_02_10}" pattern="#,##0.##"/></td>
		                    <!-- traffic01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_01_10}" pattern="#,##0.##"/></td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="trafficPtnrColSum_10" value="${trafficPtnrSum_12_10 + trafficPtnrSum_11_10 + trafficPtnrSum_10_10 + trafficPtnrSum_09_10 + trafficPtnrSum_08_10 + trafficPtnrSum_07_10 + trafficPtnrSum_06_10 + trafficPtnrSum_05_10 + trafficPtnrSum_04_10 + trafficPtnrSum_03_10 + trafficPtnrSum_02_10 + trafficPtnrSum_01_10}"></c:set>
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrColSum_10}" pattern="#,##0.##"/></td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 심사 소계</th>
                <!-- traffic12 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_12_10}" pattern="#,##0.##"/></th>
                <!-- traffic11 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_11_10}" pattern="#,##0.##"/></th>
                <!-- traffic10 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_10_10}" pattern="#,##0.##"/></th>
                <!-- traffic09 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_09_10}" pattern="#,##0.##"/></th>
                <!-- traffic08 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_08_10}" pattern="#,##0.##"/></th>
                <!-- traffic07 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_07_10}" pattern="#,##0.##"/></th>
                <!-- traffic06 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_06_10}" pattern="#,##0.##"/></th>
                <!-- traffic05 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_05_10}" pattern="#,##0.##"/></th>
                <!-- traffic04 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_04_10}" pattern="#,##0.##"/></th>
                <!-- traffic03 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_03_10}" pattern="#,##0.##"/></th>
                <!-- traffic02 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_02_10}" pattern="#,##0.##"/></th>
                <!-- traffic01 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_01_10}" pattern="#,##0.##"/></th>
                <!-- 가로열 합계 -->
                <c:set var="trafficColTotalSum_10" value="${trafficTotalSum_12_10 + trafficTotalSum_11_10 + trafficTotalSum_10_10 + trafficTotalSum_09_10 + trafficTotalSum_08_10 + trafficTotalSum_07_10 + trafficTotalSum_06_10 + trafficTotalSum_05_10 + trafficTotalSum_04_10 + trafficTotalSum_03_10 + trafficTotalSum_02_10 + trafficTotalSum_01_10}"></c:set>
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficColTotalSum_10}" pattern="#,##0.##"/></th>
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
            <c:set var="traffic12_15" value="0"></c:set>
            <c:set var="traffic11_15" value="0"></c:set>
            <c:set var="traffic10_15" value="0"></c:set>
            <c:set var="traffic09_15" value="0"></c:set>
            <c:set var="traffic08_15" value="0"></c:set>
            <c:set var="traffic07_15" value="0"></c:set>
            <c:set var="traffic06_15" value="0"></c:set>
            <c:set var="traffic05_15" value="0"></c:set>
            <c:set var="traffic04_15" value="0"></c:set>
            <c:set var="traffic03_15" value="0"></c:set>
            <c:set var="traffic02_15" value="0"></c:set>
            <c:set var="traffic01_15" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="trafficPeriodSum_12_15" value="0"></c:set>
            <c:set var="trafficPeriodSum_11_15" value="0"></c:set>
            <c:set var="trafficPeriodSum_10_15" value="0"></c:set>
            <c:set var="trafficPeriodSum_09_15" value="0"></c:set>
            <c:set var="trafficPeriodSum_08_15" value="0"></c:set>
            <c:set var="trafficPeriodSum_07_15" value="0"></c:set>
            <c:set var="trafficPeriodSum_06_15" value="0"></c:set>
            <c:set var="trafficPeriodSum_05_15" value="0"></c:set>
            <c:set var="trafficPeriodSum_04_15" value="0"></c:set>
            <c:set var="trafficPeriodSum_03_15" value="0"></c:set>
            <c:set var="trafficPeriodSum_02_15" value="0"></c:set>
            <c:set var="trafficPeriodSum_01_15" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="trafficPtnrSum_12_15" value="0"></c:set>
            <c:set var="trafficPtnrSum_11_15" value="0"></c:set>
            <c:set var="trafficPtnrSum_10_15" value="0"></c:set>
            <c:set var="trafficPtnrSum_09_15" value="0"></c:set>
            <c:set var="trafficPtnrSum_08_15" value="0"></c:set>
            <c:set var="trafficPtnrSum_07_15" value="0"></c:set>
            <c:set var="trafficPtnrSum_06_15" value="0"></c:set>
            <c:set var="trafficPtnrSum_05_15" value="0"></c:set>
            <c:set var="trafficPtnrSum_04_15" value="0"></c:set>
            <c:set var="trafficPtnrSum_03_15" value="0"></c:set>
            <c:set var="trafficPtnrSum_02_15" value="0"></c:set>
            <c:set var="trafficPtnrSum_01_15" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="trafficColSum_15" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="trafficPtnrColSum_15" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="trafficTotalSum_12_15" value="0"></c:set>
            <c:set var="trafficTotalSum_11_15" value="0"></c:set>
            <c:set var="trafficTotalSum_10_15" value="0"></c:set>
            <c:set var="trafficTotalSum_09_15" value="0"></c:set>
            <c:set var="trafficTotalSum_08_15" value="0"></c:set>
            <c:set var="trafficTotalSum_07_15" value="0"></c:set>
            <c:set var="trafficTotalSum_06_15" value="0"></c:set>
            <c:set var="trafficTotalSum_05_15" value="0"></c:set>
            <c:set var="trafficTotalSum_04_15" value="0"></c:set>
            <c:set var="trafficTotalSum_03_15" value="0"></c:set>
            <c:set var="trafficTotalSum_02_15" value="0"></c:set>
            <c:set var="trafficTotalSum_01_15" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="trafficColTotalSum_15" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo2" items="${ptnrStatTrafficList_15}" varStatus="status">            
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
						            <c:set var="trafficPtnrSum_12_15" value="0"></c:set>
						            <c:set var="trafficPtnrSum_11_15" value="0"></c:set>
						            <c:set var="trafficPtnrSum_10_15" value="0"></c:set>
						            <c:set var="trafficPtnrSum_09_15" value="0"></c:set>
						            <c:set var="trafficPtnrSum_08_15" value="0"></c:set>
						            <c:set var="trafficPtnrSum_07_15" value="0"></c:set>
						            <c:set var="trafficPtnrSum_06_15" value="0"></c:set>
						            <c:set var="trafficPtnrSum_05_15" value="0"></c:set>
						            <c:set var="trafficPtnrSum_04_15" value="0"></c:set>
						            <c:set var="trafficPtnrSum_03_15" value="0"></c:set>
						            <c:set var="trafficPtnrSum_02_15" value="0"></c:set>
						            <c:set var="trafficPtnrSum_01_15" value="0"></c:set>
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
                    		<c:set var="traffic12_15" value="${trafficPeriodSum_12_15}"></c:set>
		                    <c:set var="traffic11_15" value="${trafficPeriodSum_11_15}"></c:set>
		                    <c:set var="traffic10_15" value="${trafficPeriodSum_10_15}"></c:set>
		                    <c:set var="traffic09_15" value="${trafficPeriodSum_09_15}"></c:set>
		                    <c:set var="traffic08_15" value="${trafficPeriodSum_08_15}"></c:set>
		                    <c:set var="traffic07_15" value="${trafficPeriodSum_07_15}"></c:set>
		                    <c:set var="traffic06_15" value="${trafficPeriodSum_06_15}"></c:set>
		                    <c:set var="traffic05_15" value="${trafficPeriodSum_05_15}"></c:set>
		                    <c:set var="traffic04_15" value="${trafficPeriodSum_04_15}"></c:set>
		                    <c:set var="traffic03_15" value="${trafficPeriodSum_03_15}"></c:set>
		                    <c:set var="traffic02_15" value="${trafficPeriodSum_02_15}"></c:set>
		                    <c:set var="traffic01_15" value="${trafficPeriodSum_01_15}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="traffic12_15" value="${vo2.traffic12}"></c:set>
		                    <c:set var="traffic11_15" value="${vo2.traffic11}"></c:set>
		                    <c:set var="traffic10_15" value="${vo2.traffic10}"></c:set>
		                    <c:set var="traffic09_15" value="${vo2.traffic09}"></c:set>
		                    <c:set var="traffic08_15" value="${vo2.traffic08}"></c:set>
		                    <c:set var="traffic07_15" value="${vo2.traffic07}"></c:set>
		                    <c:set var="traffic06_15" value="${vo2.traffic06}"></c:set>
		                    <c:set var="traffic05_15" value="${vo2.traffic05}"></c:set>
		                    <c:set var="traffic04_15" value="${vo2.traffic04}"></c:set>
		                    <c:set var="traffic03_15" value="${vo2.traffic03}"></c:set>
		                    <c:set var="traffic02_15" value="${vo2.traffic02}"></c:set>
		                    <c:set var="traffic01_15" value="${vo2.traffic01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="trafficPeriodSum_12_15" value="${trafficPeriodSum_12_15 + vo2.traffic12}"></c:set>
		                    <c:set var="trafficPeriodSum_11_15" value="${trafficPeriodSum_11_15 + vo2.traffic11}"></c:set>
		                    <c:set var="trafficPeriodSum_10_15" value="${trafficPeriodSum_10_15 + vo2.traffic10}"></c:set>
		                    <c:set var="trafficPeriodSum_09_15" value="${trafficPeriodSum_09_15 + vo2.traffic09}"></c:set>
		                    <c:set var="trafficPeriodSum_08_15" value="${trafficPeriodSum_08_15 + vo2.traffic08}"></c:set>
		                    <c:set var="trafficPeriodSum_07_15" value="${trafficPeriodSum_07_15 + vo2.traffic07}"></c:set>
		                    <c:set var="trafficPeriodSum_06_15" value="${trafficPeriodSum_06_15 + vo2.traffic06}"></c:set>
		                    <c:set var="trafficPeriodSum_05_15" value="${trafficPeriodSum_05_15 + vo2.traffic05}"></c:set>
		                    <c:set var="trafficPeriodSum_04_15" value="${trafficPeriodSum_04_15 + vo2.traffic04}"></c:set>
		                    <c:set var="trafficPeriodSum_03_15" value="${trafficPeriodSum_03_15 + vo2.traffic03}"></c:set>
		                    <c:set var="trafficPeriodSum_02_15" value="${trafficPeriodSum_02_15 + vo2.traffic02}"></c:set>
		                    <c:set var="trafficPeriodSum_01_15" value="${trafficPeriodSum_01_15 + vo2.traffic01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="trafficPtnrSum_12_15" value="${trafficPtnrSum_12_15 + vo2.traffic12}"></c:set>
		                    <c:set var="trafficPtnrSum_11_15" value="${trafficPtnrSum_11_15 + vo2.traffic11}"></c:set>
		                    <c:set var="trafficPtnrSum_10_15" value="${trafficPtnrSum_10_15 + vo2.traffic10}"></c:set>
		                    <c:set var="trafficPtnrSum_09_15" value="${trafficPtnrSum_09_15 + vo2.traffic09}"></c:set>
		                    <c:set var="trafficPtnrSum_08_15" value="${trafficPtnrSum_08_15 + vo2.traffic08}"></c:set>
		                    <c:set var="trafficPtnrSum_07_15" value="${trafficPtnrSum_07_15 + vo2.traffic07}"></c:set>
		                    <c:set var="trafficPtnrSum_06_15" value="${trafficPtnrSum_06_15 + vo2.traffic06}"></c:set>
		                    <c:set var="trafficPtnrSum_05_15" value="${trafficPtnrSum_05_15 + vo2.traffic05}"></c:set>
		                    <c:set var="trafficPtnrSum_04_15" value="${trafficPtnrSum_04_15 + vo2.traffic04}"></c:set>
		                    <c:set var="trafficPtnrSum_03_15" value="${trafficPtnrSum_03_15 + vo2.traffic03}"></c:set>
		                    <c:set var="trafficPtnrSum_02_15" value="${trafficPtnrSum_02_15 + vo2.traffic02}"></c:set>
		                    <c:set var="trafficPtnrSum_01_15" value="${trafficPtnrSum_01_15 + vo2.traffic01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="trafficTotalSum_12_15" value="${trafficTotalSum_12_15 + vo2.traffic12}"></c:set>
		                    <c:set var="trafficTotalSum_11_15" value="${trafficTotalSum_11_15 + vo2.traffic11}"></c:set>
		                    <c:set var="trafficTotalSum_10_15" value="${trafficTotalSum_10_15 + vo2.traffic10}"></c:set>
		                    <c:set var="trafficTotalSum_09_15" value="${trafficTotalSum_09_15 + vo2.traffic09}"></c:set>
		                    <c:set var="trafficTotalSum_08_15" value="${trafficTotalSum_08_15 + vo2.traffic08}"></c:set>
		                    <c:set var="trafficTotalSum_07_15" value="${trafficTotalSum_07_15 + vo2.traffic07}"></c:set>
		                    <c:set var="trafficTotalSum_06_15" value="${trafficTotalSum_06_15 + vo2.traffic06}"></c:set>
		                    <c:set var="trafficTotalSum_05_15" value="${trafficTotalSum_05_15 + vo2.traffic05}"></c:set>
		                    <c:set var="trafficTotalSum_04_15" value="${trafficTotalSum_04_15 + vo2.traffic04}"></c:set>
		                    <c:set var="trafficTotalSum_03_15" value="${trafficTotalSum_03_15 + vo2.traffic03}"></c:set>
		                    <c:set var="trafficTotalSum_02_15" value="${trafficTotalSum_02_15 + vo2.traffic02}"></c:set>
		                    <c:set var="trafficTotalSum_01_15" value="${trafficTotalSum_01_15 + vo2.traffic01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="trafficColSum_15" value="${traffic12_15 + traffic11_15 + traffic10_15 + traffic09_15 + traffic08_15 + traffic07_15 + traffic06_15 + traffic05_15 + traffic04_15 + traffic03_15 + traffic02_15 + traffic01_15}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo2.periodFlagNm == "소계"}'>
							<!-- traffic12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1"><fmt:formatNumber value="${traffic12_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic11_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic10_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic09_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic08_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic07_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic06_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic05_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic04_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic03_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic02_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${traffic01_15}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${trafficColSum_15}" pattern="#,##0.##"/></td>
						</c:when>
						<c:otherwise>
							<!-- traffic12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${traffic12_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic11_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic10_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic09_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic08_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic07_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic06_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic05_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic04_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic03_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic02_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic01_15}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficColSum_15}" pattern="#,##0.##"/></td>
						</c:otherwise>
					</c:choose>  
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo2.periodFlagCode == 3}">
                    	<c:set var="trafficPeriodSum_12_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_11_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_10_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_09_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_08_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_07_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_06_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_05_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_04_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_03_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_02_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_01_15" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo2.ptnrRowCnt > 1}">
                	<c:if test="${vo2.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="trafficPeriodSum_12_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_11_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_10_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_09_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_08_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_07_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_06_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_05_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_04_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_03_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_02_15" value="0"></c:set>
			            <c:set var="trafficPeriodSum_01_15" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- traffic12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_12_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_11_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_10_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_09_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_08_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_07_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_06_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_05_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_04_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_03_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_02_15}" pattern="#,##0.##"/></td>
		                    <!-- traffic01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrSum_01_15}" pattern="#,##0.##"/></td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="trafficPtnrColSum_15" value="${trafficPtnrSum_12_15 + trafficPtnrSum_11_15 + trafficPtnrSum_10_15 + trafficPtnrSum_09_15 + trafficPtnrSum_08_15 + trafficPtnrSum_07_15 + trafficPtnrSum_06_15 + trafficPtnrSum_05_15 + trafficPtnrSum_04_15 + trafficPtnrSum_03_15 + trafficPtnrSum_02_15 + trafficPtnrSum_01_15}"></c:set>
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficPtnrColSum_15}" pattern="#,##0.##"/></td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 기타 소계</th>
                <!-- traffic12 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_12_15}" pattern="#,##0.##"/></th>
                <!-- traffic11 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_11_15}" pattern="#,##0.##"/></th>
                <!-- traffic10 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_10_15}" pattern="#,##0.##"/></th>
                <!-- traffic09 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_09_15}" pattern="#,##0.##"/></th>
                <!-- traffic08 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_08_15}" pattern="#,##0.##"/></th>
                <!-- traffic07 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_07_15}" pattern="#,##0.##"/></th>
                <!-- traffic06 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_06_15}" pattern="#,##0.##"/></th>
                <!-- traffic05 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_05_15}" pattern="#,##0.##"/></th>
                <!-- traffic04 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_04_15}" pattern="#,##0.##"/></th>
                <!-- traffic03 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_03_15}" pattern="#,##0.##"/></th>
                <!-- traffic02 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_02_15}" pattern="#,##0.##"/></th>
                <!-- traffic01 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTotalSum_01_15}" pattern="#,##0.##"/></th>
                <!-- 가로열 합계 -->
                <c:set var="trafficColTotalSum_15" value="${trafficTotalSum_12_15 + trafficTotalSum_11_15 + trafficTotalSum_10_15 + trafficTotalSum_09_15 + trafficTotalSum_08_15 + trafficTotalSum_07_15 + trafficTotalSum_06_15 + trafficTotalSum_05_15 + trafficTotalSum_04_15 + trafficTotalSum_03_15 + trafficTotalSum_02_15 + trafficTotalSum_01_15}"></c:set>
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficColTotalSum_15}" pattern="#,##0.##"/></th>
            </tr>						
			</tbody>
		</table>		
		<!-- 1종 기타 끝 -->
    </div>    
    <!-- 총 합계 시작 -->
    <!-- 총 합계 변수 시작 -->
    <c:set var="trafficTotalSum_12_all" value="${trafficTotalSum_12_5 + trafficTotalSum_12_10 + trafficTotalSum_12_15}"></c:set>
    <c:set var="trafficTotalSum_11_all" value="${trafficTotalSum_11_5 + trafficTotalSum_11_10 + trafficTotalSum_11_15}"></c:set>
    <c:set var="trafficTotalSum_10_all" value="${trafficTotalSum_10_5 + trafficTotalSum_10_10 + trafficTotalSum_10_15}"></c:set>
    <c:set var="trafficTotalSum_09_all" value="${trafficTotalSum_09_5 + trafficTotalSum_09_10 + trafficTotalSum_09_15}"></c:set>
    <c:set var="trafficTotalSum_08_all" value="${trafficTotalSum_08_5 + trafficTotalSum_08_10 + trafficTotalSum_08_15}"></c:set>
    <c:set var="trafficTotalSum_07_all" value="${trafficTotalSum_07_5 + trafficTotalSum_07_10 + trafficTotalSum_07_15}"></c:set>
    <c:set var="trafficTotalSum_06_all" value="${trafficTotalSum_06_5 + trafficTotalSum_06_10 + trafficTotalSum_06_15}"></c:set>
    <c:set var="trafficTotalSum_05_all" value="${trafficTotalSum_05_5 + trafficTotalSum_05_10 + trafficTotalSum_05_15}"></c:set>
    <c:set var="trafficTotalSum_04_all" value="${trafficTotalSum_04_5 + trafficTotalSum_04_10 + trafficTotalSum_04_15}"></c:set>
    <c:set var="trafficTotalSum_03_all" value="${trafficTotalSum_03_5 + trafficTotalSum_03_10 + trafficTotalSum_03_15}"></c:set>
    <c:set var="trafficTotalSum_02_all" value="${trafficTotalSum_02_5 + trafficTotalSum_02_10 + trafficTotalSum_02_15}"></c:set>
    <c:set var="trafficTotalSum_01_all" value="${trafficTotalSum_01_5 + trafficTotalSum_01_10 + trafficTotalSum_01_15}"></c:set>        
    <c:set var="trafficTotalSum_col_all" value="${trafficTotalSum_12_all + trafficTotalSum_11_all + trafficTotalSum_10_all + trafficTotalSum_09_all + trafficTotalSum_08_all + trafficTotalSum_07_all + trafficTotalSum_06_all + trafficTotalSum_05_all + trafficTotalSum_04_all + trafficTotalSum_03_all + trafficTotalSum_02_all + trafficTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체합계</th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTotalSum_01_all}" pattern="#,##0.##"/></th>
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTotalSum_col_all}" pattern="#,##0.##"/></th>
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>
