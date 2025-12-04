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
            <c:set var="cntTime12_5" value="0"></c:set>
            <c:set var="cntTime11_5" value="0"></c:set>
            <c:set var="cntTime10_5" value="0"></c:set>
            <c:set var="cntTime09_5" value="0"></c:set>
            <c:set var="cntTime08_5" value="0"></c:set>
            <c:set var="cntTime07_5" value="0"></c:set>
            <c:set var="cntTime06_5" value="0"></c:set>
            <c:set var="cntTime05_5" value="0"></c:set>
            <c:set var="cntTime04_5" value="0"></c:set>
            <c:set var="cntTime03_5" value="0"></c:set>
            <c:set var="cntTime02_5" value="0"></c:set>
            <c:set var="cntTime01_5" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="cntTimePeriodSum_12_5" value="0"></c:set>
            <c:set var="cntTimePeriodSum_11_5" value="0"></c:set>
            <c:set var="cntTimePeriodSum_10_5" value="0"></c:set>
            <c:set var="cntTimePeriodSum_09_5" value="0"></c:set>
            <c:set var="cntTimePeriodSum_08_5" value="0"></c:set>
            <c:set var="cntTimePeriodSum_07_5" value="0"></c:set>
            <c:set var="cntTimePeriodSum_06_5" value="0"></c:set>
            <c:set var="cntTimePeriodSum_05_5" value="0"></c:set>
            <c:set var="cntTimePeriodSum_04_5" value="0"></c:set>
            <c:set var="cntTimePeriodSum_03_5" value="0"></c:set>
            <c:set var="cntTimePeriodSum_02_5" value="0"></c:set>
            <c:set var="cntTimePeriodSum_01_5" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="cntTimePtnrSum_12_5" value="0"></c:set>
            <c:set var="cntTimePtnrSum_11_5" value="0"></c:set>
            <c:set var="cntTimePtnrSum_10_5" value="0"></c:set>
            <c:set var="cntTimePtnrSum_09_5" value="0"></c:set>
            <c:set var="cntTimePtnrSum_08_5" value="0"></c:set>
            <c:set var="cntTimePtnrSum_07_5" value="0"></c:set>
            <c:set var="cntTimePtnrSum_06_5" value="0"></c:set>
            <c:set var="cntTimePtnrSum_05_5" value="0"></c:set>
            <c:set var="cntTimePtnrSum_04_5" value="0"></c:set>
            <c:set var="cntTimePtnrSum_03_5" value="0"></c:set>
            <c:set var="cntTimePtnrSum_02_5" value="0"></c:set>
            <c:set var="cntTimePtnrSum_01_5" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="cntTimeColSum_5" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="cntTimePtnrColSum_5" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="cntTimeTotalSum_12_5" value="0"></c:set>
            <c:set var="cntTimeTotalSum_11_5" value="0"></c:set>
            <c:set var="cntTimeTotalSum_10_5" value="0"></c:set>
            <c:set var="cntTimeTotalSum_09_5" value="0"></c:set>
            <c:set var="cntTimeTotalSum_08_5" value="0"></c:set>
            <c:set var="cntTimeTotalSum_07_5" value="0"></c:set>
            <c:set var="cntTimeTotalSum_06_5" value="0"></c:set>
            <c:set var="cntTimeTotalSum_05_5" value="0"></c:set>
            <c:set var="cntTimeTotalSum_04_5" value="0"></c:set>
            <c:set var="cntTimeTotalSum_03_5" value="0"></c:set>
            <c:set var="cntTimeTotalSum_02_5" value="0"></c:set>
            <c:set var="cntTimeTotalSum_01_5" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="cntTimeColTotalSum_5" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo" items="${ptnrStatCntTimeList}" varStatus="status">            
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
						            <c:set var="cntTimePtnrSum_12_5" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_11_5" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_10_5" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_09_5" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_08_5" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_07_5" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_06_5" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_05_5" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_04_5" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_03_5" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_02_5" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_01_5" value="0"></c:set>
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
                    		<c:set var="cntTime12_5" value="${cntTimePeriodSum_12_5}"></c:set>
		                    <c:set var="cntTime11_5" value="${cntTimePeriodSum_11_5}"></c:set>
		                    <c:set var="cntTime10_5" value="${cntTimePeriodSum_10_5}"></c:set>
		                    <c:set var="cntTime09_5" value="${cntTimePeriodSum_09_5}"></c:set>
		                    <c:set var="cntTime08_5" value="${cntTimePeriodSum_08_5}"></c:set>
		                    <c:set var="cntTime07_5" value="${cntTimePeriodSum_07_5}"></c:set>
		                    <c:set var="cntTime06_5" value="${cntTimePeriodSum_06_5}"></c:set>
		                    <c:set var="cntTime05_5" value="${cntTimePeriodSum_05_5}"></c:set>
		                    <c:set var="cntTime04_5" value="${cntTimePeriodSum_04_5}"></c:set>
		                    <c:set var="cntTime03_5" value="${cntTimePeriodSum_03_5}"></c:set>
		                    <c:set var="cntTime02_5" value="${cntTimePeriodSum_02_5}"></c:set>
		                    <c:set var="cntTime01_5" value="${cntTimePeriodSum_01_5}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="cntTime12_5" value="${vo.cntTime12}"></c:set>
		                    <c:set var="cntTime11_5" value="${vo.cntTime11}"></c:set>
		                    <c:set var="cntTime10_5" value="${vo.cntTime10}"></c:set>
		                    <c:set var="cntTime09_5" value="${vo.cntTime09}"></c:set>
		                    <c:set var="cntTime08_5" value="${vo.cntTime08}"></c:set>
		                    <c:set var="cntTime07_5" value="${vo.cntTime07}"></c:set>
		                    <c:set var="cntTime06_5" value="${vo.cntTime06}"></c:set>
		                    <c:set var="cntTime05_5" value="${vo.cntTime05}"></c:set>
		                    <c:set var="cntTime04_5" value="${vo.cntTime04}"></c:set>
		                    <c:set var="cntTime03_5" value="${vo.cntTime03}"></c:set>
		                    <c:set var="cntTime02_5" value="${vo.cntTime02}"></c:set>
		                    <c:set var="cntTime01_5" value="${vo.cntTime01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="cntTimePeriodSum_12_5" value="${cntTimePeriodSum_12_5 + vo.cntTime12}"></c:set>
		                    <c:set var="cntTimePeriodSum_11_5" value="${cntTimePeriodSum_11_5 + vo.cntTime11}"></c:set>
		                    <c:set var="cntTimePeriodSum_10_5" value="${cntTimePeriodSum_10_5 + vo.cntTime10}"></c:set>
		                    <c:set var="cntTimePeriodSum_09_5" value="${cntTimePeriodSum_09_5 + vo.cntTime09}"></c:set>
		                    <c:set var="cntTimePeriodSum_08_5" value="${cntTimePeriodSum_08_5 + vo.cntTime08}"></c:set>
		                    <c:set var="cntTimePeriodSum_07_5" value="${cntTimePeriodSum_07_5 + vo.cntTime07}"></c:set>
		                    <c:set var="cntTimePeriodSum_06_5" value="${cntTimePeriodSum_06_5 + vo.cntTime06}"></c:set>
		                    <c:set var="cntTimePeriodSum_05_5" value="${cntTimePeriodSum_05_5 + vo.cntTime05}"></c:set>
		                    <c:set var="cntTimePeriodSum_04_5" value="${cntTimePeriodSum_04_5 + vo.cntTime04}"></c:set>
		                    <c:set var="cntTimePeriodSum_03_5" value="${cntTimePeriodSum_03_5 + vo.cntTime03}"></c:set>
		                    <c:set var="cntTimePeriodSum_02_5" value="${cntTimePeriodSum_02_5 + vo.cntTime02}"></c:set>
		                    <c:set var="cntTimePeriodSum_01_5" value="${cntTimePeriodSum_01_5 + vo.cntTime01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="cntTimePtnrSum_12_5" value="${cntTimePtnrSum_12_5 + vo.cntTime12}"></c:set>
		                    <c:set var="cntTimePtnrSum_11_5" value="${cntTimePtnrSum_11_5 + vo.cntTime11}"></c:set>
		                    <c:set var="cntTimePtnrSum_10_5" value="${cntTimePtnrSum_10_5 + vo.cntTime10}"></c:set>
		                    <c:set var="cntTimePtnrSum_09_5" value="${cntTimePtnrSum_09_5 + vo.cntTime09}"></c:set>
		                    <c:set var="cntTimePtnrSum_08_5" value="${cntTimePtnrSum_08_5 + vo.cntTime08}"></c:set>
		                    <c:set var="cntTimePtnrSum_07_5" value="${cntTimePtnrSum_07_5 + vo.cntTime07}"></c:set>
		                    <c:set var="cntTimePtnrSum_06_5" value="${cntTimePtnrSum_06_5 + vo.cntTime06}"></c:set>
		                    <c:set var="cntTimePtnrSum_05_5" value="${cntTimePtnrSum_05_5 + vo.cntTime05}"></c:set>
		                    <c:set var="cntTimePtnrSum_04_5" value="${cntTimePtnrSum_04_5 + vo.cntTime04}"></c:set>
		                    <c:set var="cntTimePtnrSum_03_5" value="${cntTimePtnrSum_03_5 + vo.cntTime03}"></c:set>
		                    <c:set var="cntTimePtnrSum_02_5" value="${cntTimePtnrSum_02_5 + vo.cntTime02}"></c:set>
		                    <c:set var="cntTimePtnrSum_01_5" value="${cntTimePtnrSum_01_5 + vo.cntTime01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="cntTimeTotalSum_12_5" value="${cntTimeTotalSum_12_5 + vo.cntTime12}"></c:set>
		                    <c:set var="cntTimeTotalSum_11_5" value="${cntTimeTotalSum_11_5 + vo.cntTime11}"></c:set>
		                    <c:set var="cntTimeTotalSum_10_5" value="${cntTimeTotalSum_10_5 + vo.cntTime10}"></c:set>
		                    <c:set var="cntTimeTotalSum_09_5" value="${cntTimeTotalSum_09_5 + vo.cntTime09}"></c:set>
		                    <c:set var="cntTimeTotalSum_08_5" value="${cntTimeTotalSum_08_5 + vo.cntTime08}"></c:set>
		                    <c:set var="cntTimeTotalSum_07_5" value="${cntTimeTotalSum_07_5 + vo.cntTime07}"></c:set>
		                    <c:set var="cntTimeTotalSum_06_5" value="${cntTimeTotalSum_06_5 + vo.cntTime06}"></c:set>
		                    <c:set var="cntTimeTotalSum_05_5" value="${cntTimeTotalSum_05_5 + vo.cntTime05}"></c:set>
		                    <c:set var="cntTimeTotalSum_04_5" value="${cntTimeTotalSum_04_5 + vo.cntTime04}"></c:set>
		                    <c:set var="cntTimeTotalSum_03_5" value="${cntTimeTotalSum_03_5 + vo.cntTime03}"></c:set>
		                    <c:set var="cntTimeTotalSum_02_5" value="${cntTimeTotalSum_02_5 + vo.cntTime02}"></c:set>
		                    <c:set var="cntTimeTotalSum_01_5" value="${cntTimeTotalSum_01_5 + vo.cntTime01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="cntTimeColSum_5" value="${cntTime12_5 + cntTime11_5 + cntTime10_5 + cntTime09_5 + cntTime08_5 + cntTime07_5 + cntTime06_5 + cntTime05_5 + cntTime04_5 + cntTime03_5 + cntTime02_5 + cntTime01_5}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo.periodFlagNm == "소계"}'>
							<!-- cntTime12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1"><fmt:formatNumber value="${cntTime12_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime11_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime10_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime09_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime08_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime07_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime06_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime05_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime04_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime03_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime02_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime01_5}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTimeColSum_5}" pattern="#,##0.##"/></td>
						</c:when>
						<c:otherwise>
							<!-- cntTime12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${cntTime12_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime11_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime10_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime09_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime08_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime07_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime06_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime05_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime04_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime03_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime02_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime01_5}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeColSum_5}" pattern="#,##0.##"/></td>
						</c:otherwise>
					</c:choose>
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo.periodFlagCode == 3}">
                    	<c:set var="cntTimePeriodSum_12_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_11_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_10_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_09_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_08_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_07_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_06_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_05_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_04_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_03_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_02_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_01_5" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo.ptnrRowCnt > 1}">
                	<c:if test="${vo.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="cntTimePeriodSum_12_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_11_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_10_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_09_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_08_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_07_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_06_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_05_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_04_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_03_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_02_5" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_01_5" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- cntTime12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_12_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_11_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_10_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_09_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_08_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_07_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_06_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_05_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_04_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_03_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_02_5}" pattern="#,##0.##"/></td>
		                    <!-- cntTime01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_01_5}" pattern="#,##0.##"/></td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="cntTimePtnrColSum_5" value="${cntTimePtnrSum_12_5 + cntTimePtnrSum_11_5 + cntTimePtnrSum_10_5 + cntTimePtnrSum_09_5 + cntTimePtnrSum_08_5 + cntTimePtnrSum_07_5 + cntTimePtnrSum_06_5 + cntTimePtnrSum_05_5 + cntTimePtnrSum_04_5 + cntTimePtnrSum_03_5 + cntTimePtnrSum_02_5 + cntTimePtnrSum_01_5}"></c:set>
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrColSum_5}" pattern="#,##0.##"/></td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 조사 소계</th>
                <!-- cntTime12 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_12_5}" pattern="#,##0.##"/></th>
                <!-- cntTime11 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_11_5}" pattern="#,##0.##"/></th>
                <!-- cntTime10 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_10_5}" pattern="#,##0.##"/></th>
                <!-- cntTime09 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_09_5}" pattern="#,##0.##"/></th>
                <!-- cntTime08 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_08_5}" pattern="#,##0.##"/></th>
                <!-- cntTime07 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_07_5}" pattern="#,##0.##"/></th>
                <!-- cntTime06 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_06_5}" pattern="#,##0.##"/></th>
                <!-- cntTime05 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_05_5}" pattern="#,##0.##"/></th>
                <!-- cntTime04 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_04_5}" pattern="#,##0.##"/></th>
                <!-- cntTime03 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_03_5}" pattern="#,##0.##"/></th>
                <!-- cntTime02 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_02_5}" pattern="#,##0.##"/></th>
                <!-- cntTime01 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_01_5}" pattern="#,##0.##"/></th>
                <!-- 가로열 합계 -->
                <c:set var="cntTimeColTotalSum_5" value="${cntTimeTotalSum_12_5 + cntTimeTotalSum_11_5 + cntTimeTotalSum_10_5 + cntTimeTotalSum_09_5 + cntTimeTotalSum_08_5 + cntTimeTotalSum_07_5 + cntTimeTotalSum_06_5 + cntTimeTotalSum_05_5 + cntTimeTotalSum_04_5 + cntTimeTotalSum_03_5 + cntTimeTotalSum_02_5 + cntTimeTotalSum_01_5}"></c:set>
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeColTotalSum_5}" pattern="#,##0.##"/></th>
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
            <c:set var="cntTime12_10" value="0"></c:set>
            <c:set var="cntTime11_10" value="0"></c:set>
            <c:set var="cntTime10_10" value="0"></c:set>
            <c:set var="cntTime09_10" value="0"></c:set>
            <c:set var="cntTime08_10" value="0"></c:set>
            <c:set var="cntTime07_10" value="0"></c:set>
            <c:set var="cntTime06_10" value="0"></c:set>
            <c:set var="cntTime05_10" value="0"></c:set>
            <c:set var="cntTime04_10" value="0"></c:set>
            <c:set var="cntTime03_10" value="0"></c:set>
            <c:set var="cntTime02_10" value="0"></c:set>
            <c:set var="cntTime01_10" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="cntTimePeriodSum_12_10" value="0"></c:set>
            <c:set var="cntTimePeriodSum_11_10" value="0"></c:set>
            <c:set var="cntTimePeriodSum_10_10" value="0"></c:set>
            <c:set var="cntTimePeriodSum_09_10" value="0"></c:set>
            <c:set var="cntTimePeriodSum_08_10" value="0"></c:set>
            <c:set var="cntTimePeriodSum_07_10" value="0"></c:set>
            <c:set var="cntTimePeriodSum_06_10" value="0"></c:set>
            <c:set var="cntTimePeriodSum_05_10" value="0"></c:set>
            <c:set var="cntTimePeriodSum_04_10" value="0"></c:set>
            <c:set var="cntTimePeriodSum_03_10" value="0"></c:set>
            <c:set var="cntTimePeriodSum_02_10" value="0"></c:set>
            <c:set var="cntTimePeriodSum_01_10" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="cntTimePtnrSum_12_10" value="0"></c:set>
            <c:set var="cntTimePtnrSum_11_10" value="0"></c:set>
            <c:set var="cntTimePtnrSum_10_10" value="0"></c:set>
            <c:set var="cntTimePtnrSum_09_10" value="0"></c:set>
            <c:set var="cntTimePtnrSum_08_10" value="0"></c:set>
            <c:set var="cntTimePtnrSum_07_10" value="0"></c:set>
            <c:set var="cntTimePtnrSum_06_10" value="0"></c:set>
            <c:set var="cntTimePtnrSum_05_10" value="0"></c:set>
            <c:set var="cntTimePtnrSum_04_10" value="0"></c:set>
            <c:set var="cntTimePtnrSum_03_10" value="0"></c:set>
            <c:set var="cntTimePtnrSum_02_10" value="0"></c:set>
            <c:set var="cntTimePtnrSum_01_10" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="cntTimeColSum_10" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="cntTimePtnrColSum_10" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="cntTimeTotalSum_12_10" value="0"></c:set>
            <c:set var="cntTimeTotalSum_11_10" value="0"></c:set>
            <c:set var="cntTimeTotalSum_10_10" value="0"></c:set>
            <c:set var="cntTimeTotalSum_09_10" value="0"></c:set>
            <c:set var="cntTimeTotalSum_08_10" value="0"></c:set>
            <c:set var="cntTimeTotalSum_07_10" value="0"></c:set>
            <c:set var="cntTimeTotalSum_06_10" value="0"></c:set>
            <c:set var="cntTimeTotalSum_05_10" value="0"></c:set>
            <c:set var="cntTimeTotalSum_04_10" value="0"></c:set>
            <c:set var="cntTimeTotalSum_03_10" value="0"></c:set>
            <c:set var="cntTimeTotalSum_02_10" value="0"></c:set>
            <c:set var="cntTimeTotalSum_01_10" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="cntTimeColTotalSum_10" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo1" items="${ptnrStatCntTimeList_10}" varStatus="status">            
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
						            <c:set var="cntTimePtnrSum_12_10" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_11_10" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_10_10" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_09_10" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_08_10" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_07_10" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_06_10" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_05_10" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_04_10" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_03_10" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_02_10" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_01_10" value="0"></c:set>
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
                    		<c:set var="cntTime12_10" value="${cntTimePeriodSum_12_10}"></c:set>
		                    <c:set var="cntTime11_10" value="${cntTimePeriodSum_11_10}"></c:set>
		                    <c:set var="cntTime10_10" value="${cntTimePeriodSum_10_10}"></c:set>
		                    <c:set var="cntTime09_10" value="${cntTimePeriodSum_09_10}"></c:set>
		                    <c:set var="cntTime08_10" value="${cntTimePeriodSum_08_10}"></c:set>
		                    <c:set var="cntTime07_10" value="${cntTimePeriodSum_07_10}"></c:set>
		                    <c:set var="cntTime06_10" value="${cntTimePeriodSum_06_10}"></c:set>
		                    <c:set var="cntTime05_10" value="${cntTimePeriodSum_05_10}"></c:set>
		                    <c:set var="cntTime04_10" value="${cntTimePeriodSum_04_10}"></c:set>
		                    <c:set var="cntTime03_10" value="${cntTimePeriodSum_03_10}"></c:set>
		                    <c:set var="cntTime02_10" value="${cntTimePeriodSum_02_10}"></c:set>
		                    <c:set var="cntTime01_10" value="${cntTimePeriodSum_01_10}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="cntTime12_10" value="${vo1.cntTime12}"></c:set>
		                    <c:set var="cntTime11_10" value="${vo1.cntTime11}"></c:set>
		                    <c:set var="cntTime10_10" value="${vo1.cntTime10}"></c:set>
		                    <c:set var="cntTime09_10" value="${vo1.cntTime09}"></c:set>
		                    <c:set var="cntTime08_10" value="${vo1.cntTime08}"></c:set>
		                    <c:set var="cntTime07_10" value="${vo1.cntTime07}"></c:set>
		                    <c:set var="cntTime06_10" value="${vo1.cntTime06}"></c:set>
		                    <c:set var="cntTime05_10" value="${vo1.cntTime05}"></c:set>
		                    <c:set var="cntTime04_10" value="${vo1.cntTime04}"></c:set>
		                    <c:set var="cntTime03_10" value="${vo1.cntTime03}"></c:set>
		                    <c:set var="cntTime02_10" value="${vo1.cntTime02}"></c:set>
		                    <c:set var="cntTime01_10" value="${vo1.cntTime01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="cntTimePeriodSum_12_10" value="${cntTimePeriodSum_12_10 + vo1.cntTime12}"></c:set>
		                    <c:set var="cntTimePeriodSum_11_10" value="${cntTimePeriodSum_11_10 + vo1.cntTime11}"></c:set>
		                    <c:set var="cntTimePeriodSum_10_10" value="${cntTimePeriodSum_10_10 + vo1.cntTime10}"></c:set>
		                    <c:set var="cntTimePeriodSum_09_10" value="${cntTimePeriodSum_09_10 + vo1.cntTime09}"></c:set>
		                    <c:set var="cntTimePeriodSum_08_10" value="${cntTimePeriodSum_08_10 + vo1.cntTime08}"></c:set>
		                    <c:set var="cntTimePeriodSum_07_10" value="${cntTimePeriodSum_07_10 + vo1.cntTime07}"></c:set>
		                    <c:set var="cntTimePeriodSum_06_10" value="${cntTimePeriodSum_06_10 + vo1.cntTime06}"></c:set>
		                    <c:set var="cntTimePeriodSum_05_10" value="${cntTimePeriodSum_05_10 + vo1.cntTime05}"></c:set>
		                    <c:set var="cntTimePeriodSum_04_10" value="${cntTimePeriodSum_04_10 + vo1.cntTime04}"></c:set>
		                    <c:set var="cntTimePeriodSum_03_10" value="${cntTimePeriodSum_03_10 + vo1.cntTime03}"></c:set>
		                    <c:set var="cntTimePeriodSum_02_10" value="${cntTimePeriodSum_02_10 + vo1.cntTime02}"></c:set>
		                    <c:set var="cntTimePeriodSum_01_10" value="${cntTimePeriodSum_01_10 + vo1.cntTime01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="cntTimePtnrSum_12_10" value="${cntTimePtnrSum_12_10 + vo1.cntTime12}"></c:set>
		                    <c:set var="cntTimePtnrSum_11_10" value="${cntTimePtnrSum_11_10 + vo1.cntTime11}"></c:set>
		                    <c:set var="cntTimePtnrSum_10_10" value="${cntTimePtnrSum_10_10 + vo1.cntTime10}"></c:set>
		                    <c:set var="cntTimePtnrSum_09_10" value="${cntTimePtnrSum_09_10 + vo1.cntTime09}"></c:set>
		                    <c:set var="cntTimePtnrSum_08_10" value="${cntTimePtnrSum_08_10 + vo1.cntTime08}"></c:set>
		                    <c:set var="cntTimePtnrSum_07_10" value="${cntTimePtnrSum_07_10 + vo1.cntTime07}"></c:set>
		                    <c:set var="cntTimePtnrSum_06_10" value="${cntTimePtnrSum_06_10 + vo1.cntTime06}"></c:set>
		                    <c:set var="cntTimePtnrSum_05_10" value="${cntTimePtnrSum_05_10 + vo1.cntTime05}"></c:set>
		                    <c:set var="cntTimePtnrSum_04_10" value="${cntTimePtnrSum_04_10 + vo1.cntTime04}"></c:set>
		                    <c:set var="cntTimePtnrSum_03_10" value="${cntTimePtnrSum_03_10 + vo1.cntTime03}"></c:set>
		                    <c:set var="cntTimePtnrSum_02_10" value="${cntTimePtnrSum_02_10 + vo1.cntTime02}"></c:set>
		                    <c:set var="cntTimePtnrSum_01_10" value="${cntTimePtnrSum_01_10 + vo1.cntTime01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="cntTimeTotalSum_12_10" value="${cntTimeTotalSum_12_10 + vo1.cntTime12}"></c:set>
		                    <c:set var="cntTimeTotalSum_11_10" value="${cntTimeTotalSum_11_10 + vo1.cntTime11}"></c:set>
		                    <c:set var="cntTimeTotalSum_10_10" value="${cntTimeTotalSum_10_10 + vo1.cntTime10}"></c:set>
		                    <c:set var="cntTimeTotalSum_09_10" value="${cntTimeTotalSum_09_10 + vo1.cntTime09}"></c:set>
		                    <c:set var="cntTimeTotalSum_08_10" value="${cntTimeTotalSum_08_10 + vo1.cntTime08}"></c:set>
		                    <c:set var="cntTimeTotalSum_07_10" value="${cntTimeTotalSum_07_10 + vo1.cntTime07}"></c:set>
		                    <c:set var="cntTimeTotalSum_06_10" value="${cntTimeTotalSum_06_10 + vo1.cntTime06}"></c:set>
		                    <c:set var="cntTimeTotalSum_05_10" value="${cntTimeTotalSum_05_10 + vo1.cntTime05}"></c:set>
		                    <c:set var="cntTimeTotalSum_04_10" value="${cntTimeTotalSum_04_10 + vo1.cntTime04}"></c:set>
		                    <c:set var="cntTimeTotalSum_03_10" value="${cntTimeTotalSum_03_10 + vo1.cntTime03}"></c:set>
		                    <c:set var="cntTimeTotalSum_02_10" value="${cntTimeTotalSum_02_10 + vo1.cntTime02}"></c:set>
		                    <c:set var="cntTimeTotalSum_01_10" value="${cntTimeTotalSum_01_10 + vo1.cntTime01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="cntTimeColSum_10" value="${cntTime12_10 + cntTime11_10 + cntTime10_10 + cntTime09_10 + cntTime08_10 + cntTime07_10 + cntTime06_10 + cntTime05_10 + cntTime04_10 + cntTime03_10 + cntTime02_10 + cntTime01_10}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo1.periodFlagNm == "소계"}'>
							<!-- cntTime12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1"><fmt:formatNumber value="${cntTime12_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime11_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime10_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime09_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime08_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime07_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime06_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime05_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime04_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime03_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime02_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime01_10}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTimeColSum_10}" pattern="#,##0.##"/></td>
						</c:when>
						<c:otherwise>
							<!-- cntTime12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${cntTime12_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime11_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime10_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime09_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime08_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime07_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime06_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime05_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime04_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime03_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime02_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime01_10}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeColSum_10}" pattern="#,##0.##"/></td>
						</c:otherwise>
					</c:choose>  
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo1.periodFlagCode == 3}">
                    	<c:set var="cntTimePeriodSum_12_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_11_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_10_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_09_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_08_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_07_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_06_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_05_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_04_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_03_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_02_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_01_10" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo1.ptnrRowCnt > 1}">
                	<c:if test="${vo1.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="cntTimePeriodSum_12_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_11_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_10_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_09_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_08_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_07_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_06_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_05_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_04_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_03_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_02_10" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_01_10" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- cntTime12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_12_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_11_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_10_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_09_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_08_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_07_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_06_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_05_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_04_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_03_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_02_10}" pattern="#,##0.##"/></td>
		                    <!-- cntTime01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_01_10}" pattern="#,##0.##"/></td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="cntTimePtnrColSum_10" value="${cntTimePtnrSum_12_10 + cntTimePtnrSum_11_10 + cntTimePtnrSum_10_10 + cntTimePtnrSum_09_10 + cntTimePtnrSum_08_10 + cntTimePtnrSum_07_10 + cntTimePtnrSum_06_10 + cntTimePtnrSum_05_10 + cntTimePtnrSum_04_10 + cntTimePtnrSum_03_10 + cntTimePtnrSum_02_10 + cntTimePtnrSum_01_10}"></c:set>
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrColSum_10}" pattern="#,##0.##"/></td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 심사 소계</th>
                <!-- cntTime12 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_12_10}" pattern="#,##0.##"/></th>
                <!-- cntTime11 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_11_10}" pattern="#,##0.##"/></th>
                <!-- cntTime10 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_10_10}" pattern="#,##0.##"/></th>
                <!-- cntTime09 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_09_10}" pattern="#,##0.##"/></th>
                <!-- cntTime08 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_08_10}" pattern="#,##0.##"/></th>
                <!-- cntTime07 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_07_10}" pattern="#,##0.##"/></th>
                <!-- cntTime06 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_06_10}" pattern="#,##0.##"/></th>
                <!-- cntTime05 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_05_10}" pattern="#,##0.##"/></th>
                <!-- cntTime04 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_04_10}" pattern="#,##0.##"/></th>
                <!-- cntTime03 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_03_10}" pattern="#,##0.##"/></th>
                <!-- cntTime02 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_02_10}" pattern="#,##0.##"/></th>
                <!-- cntTime01 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_01_10}" pattern="#,##0.##"/></th>
                <!-- 가로열 합계 -->
                <c:set var="cntTimeColTotalSum_10" value="${cntTimeTotalSum_12_10 + cntTimeTotalSum_11_10 + cntTimeTotalSum_10_10 + cntTimeTotalSum_09_10 + cntTimeTotalSum_08_10 + cntTimeTotalSum_07_10 + cntTimeTotalSum_06_10 + cntTimeTotalSum_05_10 + cntTimeTotalSum_04_10 + cntTimeTotalSum_03_10 + cntTimeTotalSum_02_10 + cntTimeTotalSum_01_10}"></c:set>
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeColTotalSum_10}" pattern="#,##0.##"/></th>
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
            <c:set var="cntTime12_15" value="0"></c:set>
            <c:set var="cntTime11_15" value="0"></c:set>
            <c:set var="cntTime10_15" value="0"></c:set>
            <c:set var="cntTime09_15" value="0"></c:set>
            <c:set var="cntTime08_15" value="0"></c:set>
            <c:set var="cntTime07_15" value="0"></c:set>
            <c:set var="cntTime06_15" value="0"></c:set>
            <c:set var="cntTime05_15" value="0"></c:set>
            <c:set var="cntTime04_15" value="0"></c:set>
            <c:set var="cntTime03_15" value="0"></c:set>
            <c:set var="cntTime02_15" value="0"></c:set>
            <c:set var="cntTime01_15" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="cntTimePeriodSum_12_15" value="0"></c:set>
            <c:set var="cntTimePeriodSum_11_15" value="0"></c:set>
            <c:set var="cntTimePeriodSum_10_15" value="0"></c:set>
            <c:set var="cntTimePeriodSum_09_15" value="0"></c:set>
            <c:set var="cntTimePeriodSum_08_15" value="0"></c:set>
            <c:set var="cntTimePeriodSum_07_15" value="0"></c:set>
            <c:set var="cntTimePeriodSum_06_15" value="0"></c:set>
            <c:set var="cntTimePeriodSum_05_15" value="0"></c:set>
            <c:set var="cntTimePeriodSum_04_15" value="0"></c:set>
            <c:set var="cntTimePeriodSum_03_15" value="0"></c:set>
            <c:set var="cntTimePeriodSum_02_15" value="0"></c:set>
            <c:set var="cntTimePeriodSum_01_15" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="cntTimePtnrSum_12_15" value="0"></c:set>
            <c:set var="cntTimePtnrSum_11_15" value="0"></c:set>
            <c:set var="cntTimePtnrSum_10_15" value="0"></c:set>
            <c:set var="cntTimePtnrSum_09_15" value="0"></c:set>
            <c:set var="cntTimePtnrSum_08_15" value="0"></c:set>
            <c:set var="cntTimePtnrSum_07_15" value="0"></c:set>
            <c:set var="cntTimePtnrSum_06_15" value="0"></c:set>
            <c:set var="cntTimePtnrSum_05_15" value="0"></c:set>
            <c:set var="cntTimePtnrSum_04_15" value="0"></c:set>
            <c:set var="cntTimePtnrSum_03_15" value="0"></c:set>
            <c:set var="cntTimePtnrSum_02_15" value="0"></c:set>
            <c:set var="cntTimePtnrSum_01_15" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="cntTimeColSum_15" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="cntTimePtnrColSum_15" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="cntTimeTotalSum_12_15" value="0"></c:set>
            <c:set var="cntTimeTotalSum_11_15" value="0"></c:set>
            <c:set var="cntTimeTotalSum_10_15" value="0"></c:set>
            <c:set var="cntTimeTotalSum_09_15" value="0"></c:set>
            <c:set var="cntTimeTotalSum_08_15" value="0"></c:set>
            <c:set var="cntTimeTotalSum_07_15" value="0"></c:set>
            <c:set var="cntTimeTotalSum_06_15" value="0"></c:set>
            <c:set var="cntTimeTotalSum_05_15" value="0"></c:set>
            <c:set var="cntTimeTotalSum_04_15" value="0"></c:set>
            <c:set var="cntTimeTotalSum_03_15" value="0"></c:set>
            <c:set var="cntTimeTotalSum_02_15" value="0"></c:set>
            <c:set var="cntTimeTotalSum_01_15" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="cntTimeColTotalSum_15" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo2" items="${ptnrStatCntTimeList_15}" varStatus="status">            
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
						            <c:set var="cntTimePtnrSum_12_15" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_11_15" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_10_15" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_09_15" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_08_15" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_07_15" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_06_15" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_05_15" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_04_15" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_03_15" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_02_15" value="0"></c:set>
						            <c:set var="cntTimePtnrSum_01_15" value="0"></c:set>
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
                    		<c:set var="cntTime12_15" value="${cntTimePeriodSum_12_15}"></c:set>
		                    <c:set var="cntTime11_15" value="${cntTimePeriodSum_11_15}"></c:set>
		                    <c:set var="cntTime10_15" value="${cntTimePeriodSum_10_15}"></c:set>
		                    <c:set var="cntTime09_15" value="${cntTimePeriodSum_09_15}"></c:set>
		                    <c:set var="cntTime08_15" value="${cntTimePeriodSum_08_15}"></c:set>
		                    <c:set var="cntTime07_15" value="${cntTimePeriodSum_07_15}"></c:set>
		                    <c:set var="cntTime06_15" value="${cntTimePeriodSum_06_15}"></c:set>
		                    <c:set var="cntTime05_15" value="${cntTimePeriodSum_05_15}"></c:set>
		                    <c:set var="cntTime04_15" value="${cntTimePeriodSum_04_15}"></c:set>
		                    <c:set var="cntTime03_15" value="${cntTimePeriodSum_03_15}"></c:set>
		                    <c:set var="cntTime02_15" value="${cntTimePeriodSum_02_15}"></c:set>
		                    <c:set var="cntTime01_15" value="${cntTimePeriodSum_01_15}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="cntTime12_15" value="${vo2.cntTime12}"></c:set>
		                    <c:set var="cntTime11_15" value="${vo2.cntTime11}"></c:set>
		                    <c:set var="cntTime10_15" value="${vo2.cntTime10}"></c:set>
		                    <c:set var="cntTime09_15" value="${vo2.cntTime09}"></c:set>
		                    <c:set var="cntTime08_15" value="${vo2.cntTime08}"></c:set>
		                    <c:set var="cntTime07_15" value="${vo2.cntTime07}"></c:set>
		                    <c:set var="cntTime06_15" value="${vo2.cntTime06}"></c:set>
		                    <c:set var="cntTime05_15" value="${vo2.cntTime05}"></c:set>
		                    <c:set var="cntTime04_15" value="${vo2.cntTime04}"></c:set>
		                    <c:set var="cntTime03_15" value="${vo2.cntTime03}"></c:set>
		                    <c:set var="cntTime02_15" value="${vo2.cntTime02}"></c:set>
		                    <c:set var="cntTime01_15" value="${vo2.cntTime01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="cntTimePeriodSum_12_15" value="${cntTimePeriodSum_12_15 + vo2.cntTime12}"></c:set>
		                    <c:set var="cntTimePeriodSum_11_15" value="${cntTimePeriodSum_11_15 + vo2.cntTime11}"></c:set>
		                    <c:set var="cntTimePeriodSum_10_15" value="${cntTimePeriodSum_10_15 + vo2.cntTime10}"></c:set>
		                    <c:set var="cntTimePeriodSum_09_15" value="${cntTimePeriodSum_09_15 + vo2.cntTime09}"></c:set>
		                    <c:set var="cntTimePeriodSum_08_15" value="${cntTimePeriodSum_08_15 + vo2.cntTime08}"></c:set>
		                    <c:set var="cntTimePeriodSum_07_15" value="${cntTimePeriodSum_07_15 + vo2.cntTime07}"></c:set>
		                    <c:set var="cntTimePeriodSum_06_15" value="${cntTimePeriodSum_06_15 + vo2.cntTime06}"></c:set>
		                    <c:set var="cntTimePeriodSum_05_15" value="${cntTimePeriodSum_05_15 + vo2.cntTime05}"></c:set>
		                    <c:set var="cntTimePeriodSum_04_15" value="${cntTimePeriodSum_04_15 + vo2.cntTime04}"></c:set>
		                    <c:set var="cntTimePeriodSum_03_15" value="${cntTimePeriodSum_03_15 + vo2.cntTime03}"></c:set>
		                    <c:set var="cntTimePeriodSum_02_15" value="${cntTimePeriodSum_02_15 + vo2.cntTime02}"></c:set>
		                    <c:set var="cntTimePeriodSum_01_15" value="${cntTimePeriodSum_01_15 + vo2.cntTime01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="cntTimePtnrSum_12_15" value="${cntTimePtnrSum_12_15 + vo2.cntTime12}"></c:set>
		                    <c:set var="cntTimePtnrSum_11_15" value="${cntTimePtnrSum_11_15 + vo2.cntTime11}"></c:set>
		                    <c:set var="cntTimePtnrSum_10_15" value="${cntTimePtnrSum_10_15 + vo2.cntTime10}"></c:set>
		                    <c:set var="cntTimePtnrSum_09_15" value="${cntTimePtnrSum_09_15 + vo2.cntTime09}"></c:set>
		                    <c:set var="cntTimePtnrSum_08_15" value="${cntTimePtnrSum_08_15 + vo2.cntTime08}"></c:set>
		                    <c:set var="cntTimePtnrSum_07_15" value="${cntTimePtnrSum_07_15 + vo2.cntTime07}"></c:set>
		                    <c:set var="cntTimePtnrSum_06_15" value="${cntTimePtnrSum_06_15 + vo2.cntTime06}"></c:set>
		                    <c:set var="cntTimePtnrSum_05_15" value="${cntTimePtnrSum_05_15 + vo2.cntTime05}"></c:set>
		                    <c:set var="cntTimePtnrSum_04_15" value="${cntTimePtnrSum_04_15 + vo2.cntTime04}"></c:set>
		                    <c:set var="cntTimePtnrSum_03_15" value="${cntTimePtnrSum_03_15 + vo2.cntTime03}"></c:set>
		                    <c:set var="cntTimePtnrSum_02_15" value="${cntTimePtnrSum_02_15 + vo2.cntTime02}"></c:set>
		                    <c:set var="cntTimePtnrSum_01_15" value="${cntTimePtnrSum_01_15 + vo2.cntTime01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="cntTimeTotalSum_12_15" value="${cntTimeTotalSum_12_15 + vo2.cntTime12}"></c:set>
		                    <c:set var="cntTimeTotalSum_11_15" value="${cntTimeTotalSum_11_15 + vo2.cntTime11}"></c:set>
		                    <c:set var="cntTimeTotalSum_10_15" value="${cntTimeTotalSum_10_15 + vo2.cntTime10}"></c:set>
		                    <c:set var="cntTimeTotalSum_09_15" value="${cntTimeTotalSum_09_15 + vo2.cntTime09}"></c:set>
		                    <c:set var="cntTimeTotalSum_08_15" value="${cntTimeTotalSum_08_15 + vo2.cntTime08}"></c:set>
		                    <c:set var="cntTimeTotalSum_07_15" value="${cntTimeTotalSum_07_15 + vo2.cntTime07}"></c:set>
		                    <c:set var="cntTimeTotalSum_06_15" value="${cntTimeTotalSum_06_15 + vo2.cntTime06}"></c:set>
		                    <c:set var="cntTimeTotalSum_05_15" value="${cntTimeTotalSum_05_15 + vo2.cntTime05}"></c:set>
		                    <c:set var="cntTimeTotalSum_04_15" value="${cntTimeTotalSum_04_15 + vo2.cntTime04}"></c:set>
		                    <c:set var="cntTimeTotalSum_03_15" value="${cntTimeTotalSum_03_15 + vo2.cntTime03}"></c:set>
		                    <c:set var="cntTimeTotalSum_02_15" value="${cntTimeTotalSum_02_15 + vo2.cntTime02}"></c:set>
		                    <c:set var="cntTimeTotalSum_01_15" value="${cntTimeTotalSum_01_15 + vo2.cntTime01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="cntTimeColSum_15" value="${cntTime12_15 + cntTime11_15 + cntTime10_15 + cntTime09_15 + cntTime08_15 + cntTime07_15 + cntTime06_15 + cntTime05_15 + cntTime04_15 + cntTime03_15 + cntTime02_15 + cntTime01_15}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo2.periodFlagNm == "소계"}'>
							<!-- cntTime12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1"><fmt:formatNumber value="${cntTime12_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime11_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime10_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime09_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime08_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime07_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime06_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime05_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime04_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime03_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime02_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTime01_15}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntTimeColSum_15}" pattern="#,##0.##"/></td>
						</c:when>
						<c:otherwise>
							<!-- cntTime12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${cntTime12_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime11_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime10_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime09_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime08_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime07_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime06_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime05_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime04_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime03_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime02_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime01_15}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeColSum_15}" pattern="#,##0.##"/></td>		
						</c:otherwise>
					</c:choose>
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo2.periodFlagCode == 3}">
                    	<c:set var="cntTimePeriodSum_12_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_11_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_10_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_09_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_08_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_07_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_06_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_05_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_04_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_03_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_02_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_01_15" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo2.ptnrRowCnt > 1}">
                	<c:if test="${vo2.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="cntTimePeriodSum_12_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_11_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_10_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_09_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_08_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_07_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_06_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_05_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_04_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_03_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_02_15" value="0"></c:set>
			            <c:set var="cntTimePeriodSum_01_15" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- cntTime12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_12_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_11_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_10_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_09_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_08_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_07_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_06_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_05_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_04_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_03_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_02_15}" pattern="#,##0.##"/></td>
		                    <!-- cntTime01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrSum_01_15}" pattern="#,##0.##"/></td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="cntTimePtnrColSum_15" value="${cntTimePtnrSum_12_15 + cntTimePtnrSum_11_15 + cntTimePtnrSum_10_15 + cntTimePtnrSum_09_15 + cntTimePtnrSum_08_15 + cntTimePtnrSum_07_15 + cntTimePtnrSum_06_15 + cntTimePtnrSum_05_15 + cntTimePtnrSum_04_15 + cntTimePtnrSum_03_15 + cntTimePtnrSum_02_15 + cntTimePtnrSum_01_15}"></c:set>
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntTimePtnrColSum_15}" pattern="#,##0.##"/></td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 기타 소계</th>
                <!-- cntTime12 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_12_15}" pattern="#,##0.##"/></th>
                <!-- cntTime11 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_11_15}" pattern="#,##0.##"/></th>
                <!-- cntTime10 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_10_15}" pattern="#,##0.##"/></th>
                <!-- cntTime09 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_09_15}" pattern="#,##0.##"/></th>
                <!-- cntTime08 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_08_15}" pattern="#,##0.##"/></th>
                <!-- cntTime07 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_07_15}" pattern="#,##0.##"/></th>
                <!-- cntTime06 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_06_15}" pattern="#,##0.##"/></th>
                <!-- cntTime05 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_05_15}" pattern="#,##0.##"/></th>
                <!-- cntTime04 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_04_15}" pattern="#,##0.##"/></th>
                <!-- cntTime03 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_03_15}" pattern="#,##0.##"/></th>
                <!-- cntTime02 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_02_15}" pattern="#,##0.##"/></th>
                <!-- cntTime01 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeTotalSum_01_15}" pattern="#,##0.##"/></th>
                <!-- 가로열 합계 -->
                <c:set var="cntTimeColTotalSum_15" value="${cntTimeTotalSum_12_15 + cntTimeTotalSum_11_15 + cntTimeTotalSum_10_15 + cntTimeTotalSum_09_15 + cntTimeTotalSum_08_15 + cntTimeTotalSum_07_15 + cntTimeTotalSum_06_15 + cntTimeTotalSum_05_15 + cntTimeTotalSum_04_15 + cntTimeTotalSum_03_15 + cntTimeTotalSum_02_15 + cntTimeTotalSum_01_15}"></c:set>
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTimeColTotalSum_15}" pattern="#,##0.##"/></th>
            </tr>						
			</tbody>
		</table>		
		<!-- 1종 기타 끝 -->
    </div>    
    <!-- 총 합계 시작 -->
    <!-- 총 합계 변수 시작 -->
    <c:set var="cntTimeTotalSum_12_all" value="${cntTimeTotalSum_12_5 + cntTimeTotalSum_12_10 + cntTimeTotalSum_12_15}"></c:set>
    <c:set var="cntTimeTotalSum_11_all" value="${cntTimeTotalSum_11_5 + cntTimeTotalSum_11_10 + cntTimeTotalSum_11_15}"></c:set>
    <c:set var="cntTimeTotalSum_10_all" value="${cntTimeTotalSum_10_5 + cntTimeTotalSum_10_10 + cntTimeTotalSum_10_15}"></c:set>
    <c:set var="cntTimeTotalSum_09_all" value="${cntTimeTotalSum_09_5 + cntTimeTotalSum_09_10 + cntTimeTotalSum_09_15}"></c:set>
    <c:set var="cntTimeTotalSum_08_all" value="${cntTimeTotalSum_08_5 + cntTimeTotalSum_08_10 + cntTimeTotalSum_08_15}"></c:set>
    <c:set var="cntTimeTotalSum_07_all" value="${cntTimeTotalSum_07_5 + cntTimeTotalSum_07_10 + cntTimeTotalSum_07_15}"></c:set>
    <c:set var="cntTimeTotalSum_06_all" value="${cntTimeTotalSum_06_5 + cntTimeTotalSum_06_10 + cntTimeTotalSum_06_15}"></c:set>
    <c:set var="cntTimeTotalSum_05_all" value="${cntTimeTotalSum_05_5 + cntTimeTotalSum_05_10 + cntTimeTotalSum_05_15}"></c:set>
    <c:set var="cntTimeTotalSum_04_all" value="${cntTimeTotalSum_04_5 + cntTimeTotalSum_04_10 + cntTimeTotalSum_04_15}"></c:set>
    <c:set var="cntTimeTotalSum_03_all" value="${cntTimeTotalSum_03_5 + cntTimeTotalSum_03_10 + cntTimeTotalSum_03_15}"></c:set>
    <c:set var="cntTimeTotalSum_02_all" value="${cntTimeTotalSum_02_5 + cntTimeTotalSum_02_10 + cntTimeTotalSum_02_15}"></c:set>
    <c:set var="cntTimeTotalSum_01_all" value="${cntTimeTotalSum_01_5 + cntTimeTotalSum_01_10 + cntTimeTotalSum_01_15}"></c:set>        
    <c:set var="cntTimeTotalSum_col_all" value="${cntTimeTotalSum_12_all + cntTimeTotalSum_11_all + cntTimeTotalSum_10_all + cntTimeTotalSum_09_all + cntTimeTotalSum_08_all + cntTimeTotalSum_07_all + cntTimeTotalSum_06_all + cntTimeTotalSum_05_all + cntTimeTotalSum_04_all + cntTimeTotalSum_03_all + cntTimeTotalSum_02_all + cntTimeTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체합계</th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntTimeTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntTimeTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntTimeTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntTimeTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntTimeTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntTimeTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntTimeTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntTimeTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntTimeTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntTimeTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntTimeTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntTimeTotalSum_01_all}" pattern="#,##0.##"/></th>
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntTimeTotalSum_col_all}" pattern="#,##0.##"/></th>
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>
