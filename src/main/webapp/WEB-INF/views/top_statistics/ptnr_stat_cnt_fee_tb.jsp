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
            <c:set var="cntFee12_5" value="0"></c:set>
            <c:set var="cntFee11_5" value="0"></c:set>
            <c:set var="cntFee10_5" value="0"></c:set>
            <c:set var="cntFee09_5" value="0"></c:set>
            <c:set var="cntFee08_5" value="0"></c:set>
            <c:set var="cntFee07_5" value="0"></c:set>
            <c:set var="cntFee06_5" value="0"></c:set>
            <c:set var="cntFee05_5" value="0"></c:set>
            <c:set var="cntFee04_5" value="0"></c:set>
            <c:set var="cntFee03_5" value="0"></c:set>
            <c:set var="cntFee02_5" value="0"></c:set>
            <c:set var="cntFee01_5" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="cntFeePeriodSum_12_5" value="0"></c:set>
            <c:set var="cntFeePeriodSum_11_5" value="0"></c:set>
            <c:set var="cntFeePeriodSum_10_5" value="0"></c:set>
            <c:set var="cntFeePeriodSum_09_5" value="0"></c:set>
            <c:set var="cntFeePeriodSum_08_5" value="0"></c:set>
            <c:set var="cntFeePeriodSum_07_5" value="0"></c:set>
            <c:set var="cntFeePeriodSum_06_5" value="0"></c:set>
            <c:set var="cntFeePeriodSum_05_5" value="0"></c:set>
            <c:set var="cntFeePeriodSum_04_5" value="0"></c:set>
            <c:set var="cntFeePeriodSum_03_5" value="0"></c:set>
            <c:set var="cntFeePeriodSum_02_5" value="0"></c:set>
            <c:set var="cntFeePeriodSum_01_5" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="cntFeePtnrSum_12_5" value="0"></c:set>
            <c:set var="cntFeePtnrSum_11_5" value="0"></c:set>
            <c:set var="cntFeePtnrSum_10_5" value="0"></c:set>
            <c:set var="cntFeePtnrSum_09_5" value="0"></c:set>
            <c:set var="cntFeePtnrSum_08_5" value="0"></c:set>
            <c:set var="cntFeePtnrSum_07_5" value="0"></c:set>
            <c:set var="cntFeePtnrSum_06_5" value="0"></c:set>
            <c:set var="cntFeePtnrSum_05_5" value="0"></c:set>
            <c:set var="cntFeePtnrSum_04_5" value="0"></c:set>
            <c:set var="cntFeePtnrSum_03_5" value="0"></c:set>
            <c:set var="cntFeePtnrSum_02_5" value="0"></c:set>
            <c:set var="cntFeePtnrSum_01_5" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="cntFeeColSum_5" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="cntFeePtnrColSum_5" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="cntFeeTotalSum_12_5" value="0"></c:set>
            <c:set var="cntFeeTotalSum_11_5" value="0"></c:set>
            <c:set var="cntFeeTotalSum_10_5" value="0"></c:set>
            <c:set var="cntFeeTotalSum_09_5" value="0"></c:set>
            <c:set var="cntFeeTotalSum_08_5" value="0"></c:set>
            <c:set var="cntFeeTotalSum_07_5" value="0"></c:set>
            <c:set var="cntFeeTotalSum_06_5" value="0"></c:set>
            <c:set var="cntFeeTotalSum_05_5" value="0"></c:set>
            <c:set var="cntFeeTotalSum_04_5" value="0"></c:set>
            <c:set var="cntFeeTotalSum_03_5" value="0"></c:set>
            <c:set var="cntFeeTotalSum_02_5" value="0"></c:set>
            <c:set var="cntFeeTotalSum_01_5" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="cntFeeColTotalSum_5" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo" items="${ptnrStatCntFeeList}" varStatus="status">            
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
						            <c:set var="cntFeePtnrSum_12_5" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_11_5" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_10_5" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_09_5" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_08_5" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_07_5" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_06_5" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_05_5" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_04_5" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_03_5" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_02_5" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_01_5" value="0"></c:set>
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
                    		<c:set var="cntFee12_5" value="${cntFeePeriodSum_12_5}"></c:set>
		                    <c:set var="cntFee11_5" value="${cntFeePeriodSum_11_5}"></c:set>
		                    <c:set var="cntFee10_5" value="${cntFeePeriodSum_10_5}"></c:set>
		                    <c:set var="cntFee09_5" value="${cntFeePeriodSum_09_5}"></c:set>
		                    <c:set var="cntFee08_5" value="${cntFeePeriodSum_08_5}"></c:set>
		                    <c:set var="cntFee07_5" value="${cntFeePeriodSum_07_5}"></c:set>
		                    <c:set var="cntFee06_5" value="${cntFeePeriodSum_06_5}"></c:set>
		                    <c:set var="cntFee05_5" value="${cntFeePeriodSum_05_5}"></c:set>
		                    <c:set var="cntFee04_5" value="${cntFeePeriodSum_04_5}"></c:set>
		                    <c:set var="cntFee03_5" value="${cntFeePeriodSum_03_5}"></c:set>
		                    <c:set var="cntFee02_5" value="${cntFeePeriodSum_02_5}"></c:set>
		                    <c:set var="cntFee01_5" value="${cntFeePeriodSum_01_5}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="cntFee12_5" value="${vo.cntFee12}"></c:set>
		                    <c:set var="cntFee11_5" value="${vo.cntFee11}"></c:set>
		                    <c:set var="cntFee10_5" value="${vo.cntFee10}"></c:set>
		                    <c:set var="cntFee09_5" value="${vo.cntFee09}"></c:set>
		                    <c:set var="cntFee08_5" value="${vo.cntFee08}"></c:set>
		                    <c:set var="cntFee07_5" value="${vo.cntFee07}"></c:set>
		                    <c:set var="cntFee06_5" value="${vo.cntFee06}"></c:set>
		                    <c:set var="cntFee05_5" value="${vo.cntFee05}"></c:set>
		                    <c:set var="cntFee04_5" value="${vo.cntFee04}"></c:set>
		                    <c:set var="cntFee03_5" value="${vo.cntFee03}"></c:set>
		                    <c:set var="cntFee02_5" value="${vo.cntFee02}"></c:set>
		                    <c:set var="cntFee01_5" value="${vo.cntFee01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="cntFeePeriodSum_12_5" value="${cntFeePeriodSum_12_5 + vo.cntFee12}"></c:set>
		                    <c:set var="cntFeePeriodSum_11_5" value="${cntFeePeriodSum_11_5 + vo.cntFee11}"></c:set>
		                    <c:set var="cntFeePeriodSum_10_5" value="${cntFeePeriodSum_10_5 + vo.cntFee10}"></c:set>
		                    <c:set var="cntFeePeriodSum_09_5" value="${cntFeePeriodSum_09_5 + vo.cntFee09}"></c:set>
		                    <c:set var="cntFeePeriodSum_08_5" value="${cntFeePeriodSum_08_5 + vo.cntFee08}"></c:set>
		                    <c:set var="cntFeePeriodSum_07_5" value="${cntFeePeriodSum_07_5 + vo.cntFee07}"></c:set>
		                    <c:set var="cntFeePeriodSum_06_5" value="${cntFeePeriodSum_06_5 + vo.cntFee06}"></c:set>
		                    <c:set var="cntFeePeriodSum_05_5" value="${cntFeePeriodSum_05_5 + vo.cntFee05}"></c:set>
		                    <c:set var="cntFeePeriodSum_04_5" value="${cntFeePeriodSum_04_5 + vo.cntFee04}"></c:set>
		                    <c:set var="cntFeePeriodSum_03_5" value="${cntFeePeriodSum_03_5 + vo.cntFee03}"></c:set>
		                    <c:set var="cntFeePeriodSum_02_5" value="${cntFeePeriodSum_02_5 + vo.cntFee02}"></c:set>
		                    <c:set var="cntFeePeriodSum_01_5" value="${cntFeePeriodSum_01_5 + vo.cntFee01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="cntFeePtnrSum_12_5" value="${cntFeePtnrSum_12_5 + vo.cntFee12}"></c:set>
		                    <c:set var="cntFeePtnrSum_11_5" value="${cntFeePtnrSum_11_5 + vo.cntFee11}"></c:set>
		                    <c:set var="cntFeePtnrSum_10_5" value="${cntFeePtnrSum_10_5 + vo.cntFee10}"></c:set>
		                    <c:set var="cntFeePtnrSum_09_5" value="${cntFeePtnrSum_09_5 + vo.cntFee09}"></c:set>
		                    <c:set var="cntFeePtnrSum_08_5" value="${cntFeePtnrSum_08_5 + vo.cntFee08}"></c:set>
		                    <c:set var="cntFeePtnrSum_07_5" value="${cntFeePtnrSum_07_5 + vo.cntFee07}"></c:set>
		                    <c:set var="cntFeePtnrSum_06_5" value="${cntFeePtnrSum_06_5 + vo.cntFee06}"></c:set>
		                    <c:set var="cntFeePtnrSum_05_5" value="${cntFeePtnrSum_05_5 + vo.cntFee05}"></c:set>
		                    <c:set var="cntFeePtnrSum_04_5" value="${cntFeePtnrSum_04_5 + vo.cntFee04}"></c:set>
		                    <c:set var="cntFeePtnrSum_03_5" value="${cntFeePtnrSum_03_5 + vo.cntFee03}"></c:set>
		                    <c:set var="cntFeePtnrSum_02_5" value="${cntFeePtnrSum_02_5 + vo.cntFee02}"></c:set>
		                    <c:set var="cntFeePtnrSum_01_5" value="${cntFeePtnrSum_01_5 + vo.cntFee01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="cntFeeTotalSum_12_5" value="${cntFeeTotalSum_12_5 + vo.cntFee12}"></c:set>
		                    <c:set var="cntFeeTotalSum_11_5" value="${cntFeeTotalSum_11_5 + vo.cntFee11}"></c:set>
		                    <c:set var="cntFeeTotalSum_10_5" value="${cntFeeTotalSum_10_5 + vo.cntFee10}"></c:set>
		                    <c:set var="cntFeeTotalSum_09_5" value="${cntFeeTotalSum_09_5 + vo.cntFee09}"></c:set>
		                    <c:set var="cntFeeTotalSum_08_5" value="${cntFeeTotalSum_08_5 + vo.cntFee08}"></c:set>
		                    <c:set var="cntFeeTotalSum_07_5" value="${cntFeeTotalSum_07_5 + vo.cntFee07}"></c:set>
		                    <c:set var="cntFeeTotalSum_06_5" value="${cntFeeTotalSum_06_5 + vo.cntFee06}"></c:set>
		                    <c:set var="cntFeeTotalSum_05_5" value="${cntFeeTotalSum_05_5 + vo.cntFee05}"></c:set>
		                    <c:set var="cntFeeTotalSum_04_5" value="${cntFeeTotalSum_04_5 + vo.cntFee04}"></c:set>
		                    <c:set var="cntFeeTotalSum_03_5" value="${cntFeeTotalSum_03_5 + vo.cntFee03}"></c:set>
		                    <c:set var="cntFeeTotalSum_02_5" value="${cntFeeTotalSum_02_5 + vo.cntFee02}"></c:set>
		                    <c:set var="cntFeeTotalSum_01_5" value="${cntFeeTotalSum_01_5 + vo.cntFee01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="cntFeeColSum_5" value="${cntFee12_5 + cntFee11_5 + cntFee10_5 + cntFee09_5 + cntFee08_5 + cntFee07_5 + cntFee06_5 + cntFee05_5 + cntFee04_5 + cntFee03_5 + cntFee02_5 + cntFee01_5}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo.periodFlagNm == "소계"}'>
							<!-- cntFee12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1"><fmt:formatNumber value="${cntFee12_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee11_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee10_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee09_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee08_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee07_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee06_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee05_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee04_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee03_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee02_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee01_5}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFeeColSum_5}" pattern="#,##0.##"/></td>
						</c:when>
						<c:otherwise>
							<!-- cntFee12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${cntFee12_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee11_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee10_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee09_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee08_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee07_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee06_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee05_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee04_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee03_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee02_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee01_5}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeColSum_5}" pattern="#,##0.##"/></td>
						</c:otherwise>
					</c:choose>                    
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo.periodFlagCode == 3}">
                    	<c:set var="cntFeePeriodSum_12_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_11_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_10_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_09_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_08_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_07_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_06_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_05_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_04_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_03_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_02_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_01_5" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo.ptnrRowCnt > 1}">
                	<c:if test="${vo.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="cntFeePeriodSum_12_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_11_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_10_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_09_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_08_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_07_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_06_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_05_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_04_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_03_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_02_5" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_01_5" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- cntFee12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_12_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_11_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_10_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_09_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_08_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_07_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_06_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_05_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_04_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_03_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_02_5}" pattern="#,##0.##"/></td>
		                    <!-- cntFee01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_01_5}" pattern="#,##0.##"/></td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="cntFeePtnrColSum_5" value="${cntFeePtnrSum_12_5 + cntFeePtnrSum_11_5 + cntFeePtnrSum_10_5 + cntFeePtnrSum_09_5 + cntFeePtnrSum_08_5 + cntFeePtnrSum_07_5 + cntFeePtnrSum_06_5 + cntFeePtnrSum_05_5 + cntFeePtnrSum_04_5 + cntFeePtnrSum_03_5 + cntFeePtnrSum_02_5 + cntFeePtnrSum_01_5}"></c:set>
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrColSum_5}" pattern="#,##0.##"/></td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 조사 소계</th>
                <!-- cntFee12 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_12_5}" pattern="#,##0.##"/></th>
                <!-- cntFee11 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_11_5}" pattern="#,##0.##"/></th>
                <!-- cntFee10 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_10_5}" pattern="#,##0.##"/></th>
                <!-- cntFee09 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_09_5}" pattern="#,##0.##"/></th>
                <!-- cntFee08 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_08_5}" pattern="#,##0.##"/></th>
                <!-- cntFee07 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_07_5}" pattern="#,##0.##"/></th>
                <!-- cntFee06 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_06_5}" pattern="#,##0.##"/></th>
                <!-- cntFee05 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_05_5}" pattern="#,##0.##"/></th>
                <!-- cntFee04 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_04_5}" pattern="#,##0.##"/></th>
                <!-- cntFee03 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_03_5}" pattern="#,##0.##"/></th>
                <!-- cntFee02 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_02_5}" pattern="#,##0.##"/></th>
                <!-- cntFee01 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_01_5}" pattern="#,##0.##"/></th>
                <!-- 가로열 합계 -->
                <c:set var="cntFeeColTotalSum_5" value="${cntFeeTotalSum_12_5 + cntFeeTotalSum_11_5 + cntFeeTotalSum_10_5 + cntFeeTotalSum_09_5 + cntFeeTotalSum_08_5 + cntFeeTotalSum_07_5 + cntFeeTotalSum_06_5 + cntFeeTotalSum_05_5 + cntFeeTotalSum_04_5 + cntFeeTotalSum_03_5 + cntFeeTotalSum_02_5 + cntFeeTotalSum_01_5}"></c:set>
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeColTotalSum_5}" pattern="#,##0.##"/></th>
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
            <c:set var="cntFee12_10" value="0"></c:set>
            <c:set var="cntFee11_10" value="0"></c:set>
            <c:set var="cntFee10_10" value="0"></c:set>
            <c:set var="cntFee09_10" value="0"></c:set>
            <c:set var="cntFee08_10" value="0"></c:set>
            <c:set var="cntFee07_10" value="0"></c:set>
            <c:set var="cntFee06_10" value="0"></c:set>
            <c:set var="cntFee05_10" value="0"></c:set>
            <c:set var="cntFee04_10" value="0"></c:set>
            <c:set var="cntFee03_10" value="0"></c:set>
            <c:set var="cntFee02_10" value="0"></c:set>
            <c:set var="cntFee01_10" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="cntFeePeriodSum_12_10" value="0"></c:set>
            <c:set var="cntFeePeriodSum_11_10" value="0"></c:set>
            <c:set var="cntFeePeriodSum_10_10" value="0"></c:set>
            <c:set var="cntFeePeriodSum_09_10" value="0"></c:set>
            <c:set var="cntFeePeriodSum_08_10" value="0"></c:set>
            <c:set var="cntFeePeriodSum_07_10" value="0"></c:set>
            <c:set var="cntFeePeriodSum_06_10" value="0"></c:set>
            <c:set var="cntFeePeriodSum_05_10" value="0"></c:set>
            <c:set var="cntFeePeriodSum_04_10" value="0"></c:set>
            <c:set var="cntFeePeriodSum_03_10" value="0"></c:set>
            <c:set var="cntFeePeriodSum_02_10" value="0"></c:set>
            <c:set var="cntFeePeriodSum_01_10" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="cntFeePtnrSum_12_10" value="0"></c:set>
            <c:set var="cntFeePtnrSum_11_10" value="0"></c:set>
            <c:set var="cntFeePtnrSum_10_10" value="0"></c:set>
            <c:set var="cntFeePtnrSum_09_10" value="0"></c:set>
            <c:set var="cntFeePtnrSum_08_10" value="0"></c:set>
            <c:set var="cntFeePtnrSum_07_10" value="0"></c:set>
            <c:set var="cntFeePtnrSum_06_10" value="0"></c:set>
            <c:set var="cntFeePtnrSum_05_10" value="0"></c:set>
            <c:set var="cntFeePtnrSum_04_10" value="0"></c:set>
            <c:set var="cntFeePtnrSum_03_10" value="0"></c:set>
            <c:set var="cntFeePtnrSum_02_10" value="0"></c:set>
            <c:set var="cntFeePtnrSum_01_10" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="cntFeeColSum_10" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="cntFeePtnrColSum_10" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="cntFeeTotalSum_12_10" value="0"></c:set>
            <c:set var="cntFeeTotalSum_11_10" value="0"></c:set>
            <c:set var="cntFeeTotalSum_10_10" value="0"></c:set>
            <c:set var="cntFeeTotalSum_09_10" value="0"></c:set>
            <c:set var="cntFeeTotalSum_08_10" value="0"></c:set>
            <c:set var="cntFeeTotalSum_07_10" value="0"></c:set>
            <c:set var="cntFeeTotalSum_06_10" value="0"></c:set>
            <c:set var="cntFeeTotalSum_05_10" value="0"></c:set>
            <c:set var="cntFeeTotalSum_04_10" value="0"></c:set>
            <c:set var="cntFeeTotalSum_03_10" value="0"></c:set>
            <c:set var="cntFeeTotalSum_02_10" value="0"></c:set>
            <c:set var="cntFeeTotalSum_01_10" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="cntFeeColTotalSum_10" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo1" items="${ptnrStatCntFeeList_10}" varStatus="status">            
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
						            <c:set var="cntFeePtnrSum_12_10" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_11_10" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_10_10" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_09_10" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_08_10" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_07_10" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_06_10" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_05_10" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_04_10" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_03_10" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_02_10" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_01_10" value="0"></c:set>
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
                    		<c:set var="cntFee12_10" value="${cntFeePeriodSum_12_10}"></c:set>
		                    <c:set var="cntFee11_10" value="${cntFeePeriodSum_11_10}"></c:set>
		                    <c:set var="cntFee10_10" value="${cntFeePeriodSum_10_10}"></c:set>
		                    <c:set var="cntFee09_10" value="${cntFeePeriodSum_09_10}"></c:set>
		                    <c:set var="cntFee08_10" value="${cntFeePeriodSum_08_10}"></c:set>
		                    <c:set var="cntFee07_10" value="${cntFeePeriodSum_07_10}"></c:set>
		                    <c:set var="cntFee06_10" value="${cntFeePeriodSum_06_10}"></c:set>
		                    <c:set var="cntFee05_10" value="${cntFeePeriodSum_05_10}"></c:set>
		                    <c:set var="cntFee04_10" value="${cntFeePeriodSum_04_10}"></c:set>
		                    <c:set var="cntFee03_10" value="${cntFeePeriodSum_03_10}"></c:set>
		                    <c:set var="cntFee02_10" value="${cntFeePeriodSum_02_10}"></c:set>
		                    <c:set var="cntFee01_10" value="${cntFeePeriodSum_01_10}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="cntFee12_10" value="${vo1.cntFee12}"></c:set>
		                    <c:set var="cntFee11_10" value="${vo1.cntFee11}"></c:set>
		                    <c:set var="cntFee10_10" value="${vo1.cntFee10}"></c:set>
		                    <c:set var="cntFee09_10" value="${vo1.cntFee09}"></c:set>
		                    <c:set var="cntFee08_10" value="${vo1.cntFee08}"></c:set>
		                    <c:set var="cntFee07_10" value="${vo1.cntFee07}"></c:set>
		                    <c:set var="cntFee06_10" value="${vo1.cntFee06}"></c:set>
		                    <c:set var="cntFee05_10" value="${vo1.cntFee05}"></c:set>
		                    <c:set var="cntFee04_10" value="${vo1.cntFee04}"></c:set>
		                    <c:set var="cntFee03_10" value="${vo1.cntFee03}"></c:set>
		                    <c:set var="cntFee02_10" value="${vo1.cntFee02}"></c:set>
		                    <c:set var="cntFee01_10" value="${vo1.cntFee01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="cntFeePeriodSum_12_10" value="${cntFeePeriodSum_12_10 + vo1.cntFee12}"></c:set>
		                    <c:set var="cntFeePeriodSum_11_10" value="${cntFeePeriodSum_11_10 + vo1.cntFee11}"></c:set>
		                    <c:set var="cntFeePeriodSum_10_10" value="${cntFeePeriodSum_10_10 + vo1.cntFee10}"></c:set>
		                    <c:set var="cntFeePeriodSum_09_10" value="${cntFeePeriodSum_09_10 + vo1.cntFee09}"></c:set>
		                    <c:set var="cntFeePeriodSum_08_10" value="${cntFeePeriodSum_08_10 + vo1.cntFee08}"></c:set>
		                    <c:set var="cntFeePeriodSum_07_10" value="${cntFeePeriodSum_07_10 + vo1.cntFee07}"></c:set>
		                    <c:set var="cntFeePeriodSum_06_10" value="${cntFeePeriodSum_06_10 + vo1.cntFee06}"></c:set>
		                    <c:set var="cntFeePeriodSum_05_10" value="${cntFeePeriodSum_05_10 + vo1.cntFee05}"></c:set>
		                    <c:set var="cntFeePeriodSum_04_10" value="${cntFeePeriodSum_04_10 + vo1.cntFee04}"></c:set>
		                    <c:set var="cntFeePeriodSum_03_10" value="${cntFeePeriodSum_03_10 + vo1.cntFee03}"></c:set>
		                    <c:set var="cntFeePeriodSum_02_10" value="${cntFeePeriodSum_02_10 + vo1.cntFee02}"></c:set>
		                    <c:set var="cntFeePeriodSum_01_10" value="${cntFeePeriodSum_01_10 + vo1.cntFee01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="cntFeePtnrSum_12_10" value="${cntFeePtnrSum_12_10 + vo1.cntFee12}"></c:set>
		                    <c:set var="cntFeePtnrSum_11_10" value="${cntFeePtnrSum_11_10 + vo1.cntFee11}"></c:set>
		                    <c:set var="cntFeePtnrSum_10_10" value="${cntFeePtnrSum_10_10 + vo1.cntFee10}"></c:set>
		                    <c:set var="cntFeePtnrSum_09_10" value="${cntFeePtnrSum_09_10 + vo1.cntFee09}"></c:set>
		                    <c:set var="cntFeePtnrSum_08_10" value="${cntFeePtnrSum_08_10 + vo1.cntFee08}"></c:set>
		                    <c:set var="cntFeePtnrSum_07_10" value="${cntFeePtnrSum_07_10 + vo1.cntFee07}"></c:set>
		                    <c:set var="cntFeePtnrSum_06_10" value="${cntFeePtnrSum_06_10 + vo1.cntFee06}"></c:set>
		                    <c:set var="cntFeePtnrSum_05_10" value="${cntFeePtnrSum_05_10 + vo1.cntFee05}"></c:set>
		                    <c:set var="cntFeePtnrSum_04_10" value="${cntFeePtnrSum_04_10 + vo1.cntFee04}"></c:set>
		                    <c:set var="cntFeePtnrSum_03_10" value="${cntFeePtnrSum_03_10 + vo1.cntFee03}"></c:set>
		                    <c:set var="cntFeePtnrSum_02_10" value="${cntFeePtnrSum_02_10 + vo1.cntFee02}"></c:set>
		                    <c:set var="cntFeePtnrSum_01_10" value="${cntFeePtnrSum_01_10 + vo1.cntFee01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="cntFeeTotalSum_12_10" value="${cntFeeTotalSum_12_10 + vo1.cntFee12}"></c:set>
		                    <c:set var="cntFeeTotalSum_11_10" value="${cntFeeTotalSum_11_10 + vo1.cntFee11}"></c:set>
		                    <c:set var="cntFeeTotalSum_10_10" value="${cntFeeTotalSum_10_10 + vo1.cntFee10}"></c:set>
		                    <c:set var="cntFeeTotalSum_09_10" value="${cntFeeTotalSum_09_10 + vo1.cntFee09}"></c:set>
		                    <c:set var="cntFeeTotalSum_08_10" value="${cntFeeTotalSum_08_10 + vo1.cntFee08}"></c:set>
		                    <c:set var="cntFeeTotalSum_07_10" value="${cntFeeTotalSum_07_10 + vo1.cntFee07}"></c:set>
		                    <c:set var="cntFeeTotalSum_06_10" value="${cntFeeTotalSum_06_10 + vo1.cntFee06}"></c:set>
		                    <c:set var="cntFeeTotalSum_05_10" value="${cntFeeTotalSum_05_10 + vo1.cntFee05}"></c:set>
		                    <c:set var="cntFeeTotalSum_04_10" value="${cntFeeTotalSum_04_10 + vo1.cntFee04}"></c:set>
		                    <c:set var="cntFeeTotalSum_03_10" value="${cntFeeTotalSum_03_10 + vo1.cntFee03}"></c:set>
		                    <c:set var="cntFeeTotalSum_02_10" value="${cntFeeTotalSum_02_10 + vo1.cntFee02}"></c:set>
		                    <c:set var="cntFeeTotalSum_01_10" value="${cntFeeTotalSum_01_10 + vo1.cntFee01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="cntFeeColSum_10" value="${cntFee12_10 + cntFee11_10 + cntFee10_10 + cntFee09_10 + cntFee08_10 + cntFee07_10 + cntFee06_10 + cntFee05_10 + cntFee04_10 + cntFee03_10 + cntFee02_10 + cntFee01_10}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo1.periodFlagNm == "소계"}'>
							<!-- cntFee12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1"><fmt:formatNumber value="${cntFee12_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee11_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee10_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee09_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee08_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee07_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee06_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee05_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee04_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee03_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee02_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee01_10}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFeeColSum_10}" pattern="#,##0.##"/></td>
						</c:when>
						<c:otherwise>
							<!-- cntFee12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${cntFee12_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee11_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee10_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee09_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee08_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee07_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee06_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee05_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee04_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee03_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee02_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee01_10}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeColSum_10}" pattern="#,##0.##"/></td>
						</c:otherwise>
					</c:choose>  
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo1.periodFlagCode == 3}">
                    	<c:set var="cntFeePeriodSum_12_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_11_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_10_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_09_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_08_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_07_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_06_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_05_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_04_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_03_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_02_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_01_10" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo1.ptnrRowCnt > 1}">
                	<c:if test="${vo1.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="cntFeePeriodSum_12_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_11_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_10_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_09_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_08_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_07_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_06_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_05_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_04_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_03_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_02_10" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_01_10" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- cntFee12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_12_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_11_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_10_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_09_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_08_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_07_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_06_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_05_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_04_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_03_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_02_10}" pattern="#,##0.##"/></td>
		                    <!-- cntFee01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_01_10}" pattern="#,##0.##"/></td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="cntFeePtnrColSum_10" value="${cntFeePtnrSum_12_10 + cntFeePtnrSum_11_10 + cntFeePtnrSum_10_10 + cntFeePtnrSum_09_10 + cntFeePtnrSum_08_10 + cntFeePtnrSum_07_10 + cntFeePtnrSum_06_10 + cntFeePtnrSum_05_10 + cntFeePtnrSum_04_10 + cntFeePtnrSum_03_10 + cntFeePtnrSum_02_10 + cntFeePtnrSum_01_10}"></c:set>
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrColSum_10}" pattern="#,##0.##"/></td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 심사 소계</th>
                <!-- cntFee12 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_12_10}" pattern="#,##0.##"/></th>
                <!-- cntFee11 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_11_10}" pattern="#,##0.##"/></th>
                <!-- cntFee10 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_10_10}" pattern="#,##0.##"/></th>
                <!-- cntFee09 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_09_10}" pattern="#,##0.##"/></th>
                <!-- cntFee08 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_08_10}" pattern="#,##0.##"/></th>
                <!-- cntFee07 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_07_10}" pattern="#,##0.##"/></th>
                <!-- cntFee06 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_06_10}" pattern="#,##0.##"/></th>
                <!-- cntFee05 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_05_10}" pattern="#,##0.##"/></th>
                <!-- cntFee04 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_04_10}" pattern="#,##0.##"/></th>
                <!-- cntFee03 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_03_10}" pattern="#,##0.##"/></th>
                <!-- cntFee02 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_02_10}" pattern="#,##0.##"/></th>
                <!-- cntFee01 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_01_10}" pattern="#,##0.##"/></th>
                <!-- 가로열 합계 -->
                <c:set var="cntFeeColTotalSum_10" value="${cntFeeTotalSum_12_10 + cntFeeTotalSum_11_10 + cntFeeTotalSum_10_10 + cntFeeTotalSum_09_10 + cntFeeTotalSum_08_10 + cntFeeTotalSum_07_10 + cntFeeTotalSum_06_10 + cntFeeTotalSum_05_10 + cntFeeTotalSum_04_10 + cntFeeTotalSum_03_10 + cntFeeTotalSum_02_10 + cntFeeTotalSum_01_10}"></c:set>
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeColTotalSum_10}" pattern="#,##0.##"/></th>
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
            <c:set var="cntFee12_15" value="0"></c:set>
            <c:set var="cntFee11_15" value="0"></c:set>
            <c:set var="cntFee10_15" value="0"></c:set>
            <c:set var="cntFee09_15" value="0"></c:set>
            <c:set var="cntFee08_15" value="0"></c:set>
            <c:set var="cntFee07_15" value="0"></c:set>
            <c:set var="cntFee06_15" value="0"></c:set>
            <c:set var="cntFee05_15" value="0"></c:set>
            <c:set var="cntFee04_15" value="0"></c:set>
            <c:set var="cntFee03_15" value="0"></c:set>
            <c:set var="cntFee02_15" value="0"></c:set>
            <c:set var="cntFee01_15" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="cntFeePeriodSum_12_15" value="0"></c:set>
            <c:set var="cntFeePeriodSum_11_15" value="0"></c:set>
            <c:set var="cntFeePeriodSum_10_15" value="0"></c:set>
            <c:set var="cntFeePeriodSum_09_15" value="0"></c:set>
            <c:set var="cntFeePeriodSum_08_15" value="0"></c:set>
            <c:set var="cntFeePeriodSum_07_15" value="0"></c:set>
            <c:set var="cntFeePeriodSum_06_15" value="0"></c:set>
            <c:set var="cntFeePeriodSum_05_15" value="0"></c:set>
            <c:set var="cntFeePeriodSum_04_15" value="0"></c:set>
            <c:set var="cntFeePeriodSum_03_15" value="0"></c:set>
            <c:set var="cntFeePeriodSum_02_15" value="0"></c:set>
            <c:set var="cntFeePeriodSum_01_15" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="cntFeePtnrSum_12_15" value="0"></c:set>
            <c:set var="cntFeePtnrSum_11_15" value="0"></c:set>
            <c:set var="cntFeePtnrSum_10_15" value="0"></c:set>
            <c:set var="cntFeePtnrSum_09_15" value="0"></c:set>
            <c:set var="cntFeePtnrSum_08_15" value="0"></c:set>
            <c:set var="cntFeePtnrSum_07_15" value="0"></c:set>
            <c:set var="cntFeePtnrSum_06_15" value="0"></c:set>
            <c:set var="cntFeePtnrSum_05_15" value="0"></c:set>
            <c:set var="cntFeePtnrSum_04_15" value="0"></c:set>
            <c:set var="cntFeePtnrSum_03_15" value="0"></c:set>
            <c:set var="cntFeePtnrSum_02_15" value="0"></c:set>
            <c:set var="cntFeePtnrSum_01_15" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="cntFeeColSum_15" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="cntFeePtnrColSum_15" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="cntFeeTotalSum_12_15" value="0"></c:set>
            <c:set var="cntFeeTotalSum_11_15" value="0"></c:set>
            <c:set var="cntFeeTotalSum_10_15" value="0"></c:set>
            <c:set var="cntFeeTotalSum_09_15" value="0"></c:set>
            <c:set var="cntFeeTotalSum_08_15" value="0"></c:set>
            <c:set var="cntFeeTotalSum_07_15" value="0"></c:set>
            <c:set var="cntFeeTotalSum_06_15" value="0"></c:set>
            <c:set var="cntFeeTotalSum_05_15" value="0"></c:set>
            <c:set var="cntFeeTotalSum_04_15" value="0"></c:set>
            <c:set var="cntFeeTotalSum_03_15" value="0"></c:set>
            <c:set var="cntFeeTotalSum_02_15" value="0"></c:set>
            <c:set var="cntFeeTotalSum_01_15" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="cntFeeColTotalSum_15" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo2" items="${ptnrStatCntFeeList_15}" varStatus="status">            
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
						            <c:set var="cntFeePtnrSum_12_15" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_11_15" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_10_15" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_09_15" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_08_15" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_07_15" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_06_15" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_05_15" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_04_15" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_03_15" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_02_15" value="0"></c:set>
						            <c:set var="cntFeePtnrSum_01_15" value="0"></c:set>
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
                    		<c:set var="cntFee12_15" value="${cntFeePeriodSum_12_15}"></c:set>
		                    <c:set var="cntFee11_15" value="${cntFeePeriodSum_11_15}"></c:set>
		                    <c:set var="cntFee10_15" value="${cntFeePeriodSum_10_15}"></c:set>
		                    <c:set var="cntFee09_15" value="${cntFeePeriodSum_09_15}"></c:set>
		                    <c:set var="cntFee08_15" value="${cntFeePeriodSum_08_15}"></c:set>
		                    <c:set var="cntFee07_15" value="${cntFeePeriodSum_07_15}"></c:set>
		                    <c:set var="cntFee06_15" value="${cntFeePeriodSum_06_15}"></c:set>
		                    <c:set var="cntFee05_15" value="${cntFeePeriodSum_05_15}"></c:set>
		                    <c:set var="cntFee04_15" value="${cntFeePeriodSum_04_15}"></c:set>
		                    <c:set var="cntFee03_15" value="${cntFeePeriodSum_03_15}"></c:set>
		                    <c:set var="cntFee02_15" value="${cntFeePeriodSum_02_15}"></c:set>
		                    <c:set var="cntFee01_15" value="${cntFeePeriodSum_01_15}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="cntFee12_15" value="${vo2.cntFee12}"></c:set>
		                    <c:set var="cntFee11_15" value="${vo2.cntFee11}"></c:set>
		                    <c:set var="cntFee10_15" value="${vo2.cntFee10}"></c:set>
		                    <c:set var="cntFee09_15" value="${vo2.cntFee09}"></c:set>
		                    <c:set var="cntFee08_15" value="${vo2.cntFee08}"></c:set>
		                    <c:set var="cntFee07_15" value="${vo2.cntFee07}"></c:set>
		                    <c:set var="cntFee06_15" value="${vo2.cntFee06}"></c:set>
		                    <c:set var="cntFee05_15" value="${vo2.cntFee05}"></c:set>
		                    <c:set var="cntFee04_15" value="${vo2.cntFee04}"></c:set>
		                    <c:set var="cntFee03_15" value="${vo2.cntFee03}"></c:set>
		                    <c:set var="cntFee02_15" value="${vo2.cntFee02}"></c:set>
		                    <c:set var="cntFee01_15" value="${vo2.cntFee01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="cntFeePeriodSum_12_15" value="${cntFeePeriodSum_12_15 + vo2.cntFee12}"></c:set>
		                    <c:set var="cntFeePeriodSum_11_15" value="${cntFeePeriodSum_11_15 + vo2.cntFee11}"></c:set>
		                    <c:set var="cntFeePeriodSum_10_15" value="${cntFeePeriodSum_10_15 + vo2.cntFee10}"></c:set>
		                    <c:set var="cntFeePeriodSum_09_15" value="${cntFeePeriodSum_09_15 + vo2.cntFee09}"></c:set>
		                    <c:set var="cntFeePeriodSum_08_15" value="${cntFeePeriodSum_08_15 + vo2.cntFee08}"></c:set>
		                    <c:set var="cntFeePeriodSum_07_15" value="${cntFeePeriodSum_07_15 + vo2.cntFee07}"></c:set>
		                    <c:set var="cntFeePeriodSum_06_15" value="${cntFeePeriodSum_06_15 + vo2.cntFee06}"></c:set>
		                    <c:set var="cntFeePeriodSum_05_15" value="${cntFeePeriodSum_05_15 + vo2.cntFee05}"></c:set>
		                    <c:set var="cntFeePeriodSum_04_15" value="${cntFeePeriodSum_04_15 + vo2.cntFee04}"></c:set>
		                    <c:set var="cntFeePeriodSum_03_15" value="${cntFeePeriodSum_03_15 + vo2.cntFee03}"></c:set>
		                    <c:set var="cntFeePeriodSum_02_15" value="${cntFeePeriodSum_02_15 + vo2.cntFee02}"></c:set>
		                    <c:set var="cntFeePeriodSum_01_15" value="${cntFeePeriodSum_01_15 + vo2.cntFee01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="cntFeePtnrSum_12_15" value="${cntFeePtnrSum_12_15 + vo2.cntFee12}"></c:set>
		                    <c:set var="cntFeePtnrSum_11_15" value="${cntFeePtnrSum_11_15 + vo2.cntFee11}"></c:set>
		                    <c:set var="cntFeePtnrSum_10_15" value="${cntFeePtnrSum_10_15 + vo2.cntFee10}"></c:set>
		                    <c:set var="cntFeePtnrSum_09_15" value="${cntFeePtnrSum_09_15 + vo2.cntFee09}"></c:set>
		                    <c:set var="cntFeePtnrSum_08_15" value="${cntFeePtnrSum_08_15 + vo2.cntFee08}"></c:set>
		                    <c:set var="cntFeePtnrSum_07_15" value="${cntFeePtnrSum_07_15 + vo2.cntFee07}"></c:set>
		                    <c:set var="cntFeePtnrSum_06_15" value="${cntFeePtnrSum_06_15 + vo2.cntFee06}"></c:set>
		                    <c:set var="cntFeePtnrSum_05_15" value="${cntFeePtnrSum_05_15 + vo2.cntFee05}"></c:set>
		                    <c:set var="cntFeePtnrSum_04_15" value="${cntFeePtnrSum_04_15 + vo2.cntFee04}"></c:set>
		                    <c:set var="cntFeePtnrSum_03_15" value="${cntFeePtnrSum_03_15 + vo2.cntFee03}"></c:set>
		                    <c:set var="cntFeePtnrSum_02_15" value="${cntFeePtnrSum_02_15 + vo2.cntFee02}"></c:set>
		                    <c:set var="cntFeePtnrSum_01_15" value="${cntFeePtnrSum_01_15 + vo2.cntFee01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="cntFeeTotalSum_12_15" value="${cntFeeTotalSum_12_15 + vo2.cntFee12}"></c:set>
		                    <c:set var="cntFeeTotalSum_11_15" value="${cntFeeTotalSum_11_15 + vo2.cntFee11}"></c:set>
		                    <c:set var="cntFeeTotalSum_10_15" value="${cntFeeTotalSum_10_15 + vo2.cntFee10}"></c:set>
		                    <c:set var="cntFeeTotalSum_09_15" value="${cntFeeTotalSum_09_15 + vo2.cntFee09}"></c:set>
		                    <c:set var="cntFeeTotalSum_08_15" value="${cntFeeTotalSum_08_15 + vo2.cntFee08}"></c:set>
		                    <c:set var="cntFeeTotalSum_07_15" value="${cntFeeTotalSum_07_15 + vo2.cntFee07}"></c:set>
		                    <c:set var="cntFeeTotalSum_06_15" value="${cntFeeTotalSum_06_15 + vo2.cntFee06}"></c:set>
		                    <c:set var="cntFeeTotalSum_05_15" value="${cntFeeTotalSum_05_15 + vo2.cntFee05}"></c:set>
		                    <c:set var="cntFeeTotalSum_04_15" value="${cntFeeTotalSum_04_15 + vo2.cntFee04}"></c:set>
		                    <c:set var="cntFeeTotalSum_03_15" value="${cntFeeTotalSum_03_15 + vo2.cntFee03}"></c:set>
		                    <c:set var="cntFeeTotalSum_02_15" value="${cntFeeTotalSum_02_15 + vo2.cntFee02}"></c:set>
		                    <c:set var="cntFeeTotalSum_01_15" value="${cntFeeTotalSum_01_15 + vo2.cntFee01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="cntFeeColSum_15" value="${cntFee12_15 + cntFee11_15 + cntFee10_15 + cntFee09_15 + cntFee08_15 + cntFee07_15 + cntFee06_15 + cntFee05_15 + cntFee04_15 + cntFee03_15 + cntFee02_15 + cntFee01_15}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo2.periodFlagNm == "소계"}'>
							<!-- cntFee12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1"><fmt:formatNumber value="${cntFee12_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee11_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee10_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee09_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee08_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee07_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee06_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee05_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee04_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee03_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee02_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFee01_15}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${cntFeeColSum_15}" pattern="#,##0.##"/></td>
						</c:when>
						<c:otherwise>
							<!-- cntFee12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${cntFee12_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee11_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee10_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee09_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee08_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee07_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee06_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee05_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee04_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee03_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee02_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee01_15}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeColSum_15}" pattern="#,##0.##"/></td>
						</c:otherwise>
					</c:choose>  
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo2.periodFlagCode == 3}">
                    	<c:set var="cntFeePeriodSum_12_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_11_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_10_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_09_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_08_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_07_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_06_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_05_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_04_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_03_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_02_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_01_15" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo2.ptnrRowCnt > 1}">
                	<c:if test="${vo2.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="cntFeePeriodSum_12_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_11_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_10_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_09_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_08_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_07_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_06_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_05_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_04_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_03_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_02_15" value="0"></c:set>
			            <c:set var="cntFeePeriodSum_01_15" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- cntFee12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_12_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_11_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_15_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_09_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_08_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_07_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_06_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_05_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_04_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_03_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_02_15}" pattern="#,##0.##"/></td>
		                    <!-- cntFee01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrSum_01_15}" pattern="#,##0.##"/></td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="cntFeePtnrColSum_15" value="${cntFeePtnrSum_12_15 + cntFeePtnrSum_11_15 + cntFeePtnrSum_15_15 + cntFeePtnrSum_09_15 + cntFeePtnrSum_08_15 + cntFeePtnrSum_07_15 + cntFeePtnrSum_06_15 + cntFeePtnrSum_05_15 + cntFeePtnrSum_04_15 + cntFeePtnrSum_03_15 + cntFeePtnrSum_02_15 + cntFeePtnrSum_01_15}"></c:set>
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${cntFeePtnrColSum_15}" pattern="#,##0.##"/></td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 기타 소계</th>
                <!-- cntFee12 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_12_15}" pattern="#,##0.##"/></th>
                <!-- cntFee11 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_11_15}" pattern="#,##0.##"/></th>
                <!-- cntFee10 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_15_15}" pattern="#,##0.##"/></th>
                <!-- cntFee09 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_09_15}" pattern="#,##0.##"/></th>
                <!-- cntFee08 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_08_15}" pattern="#,##0.##"/></th>
                <!-- cntFee07 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_07_15}" pattern="#,##0.##"/></th>
                <!-- cntFee06 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_06_15}" pattern="#,##0.##"/></th>
                <!-- cntFee05 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_05_15}" pattern="#,##0.##"/></th>
                <!-- cntFee04 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_04_15}" pattern="#,##0.##"/></th>
                <!-- cntFee03 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_03_15}" pattern="#,##0.##"/></th>
                <!-- cntFee02 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_02_15}" pattern="#,##0.##"/></th>
                <!-- cntFee01 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeTotalSum_01_15}" pattern="#,##0.##"/></th>
                <!-- 가로열 합계 -->
                <c:set var="cntFeeColTotalSum_15" value="${cntFeeTotalSum_12_15 + cntFeeTotalSum_11_15 + cntFeeTotalSum_15_15 + cntFeeTotalSum_09_15 + cntFeeTotalSum_08_15 + cntFeeTotalSum_07_15 + cntFeeTotalSum_06_15 + cntFeeTotalSum_05_15 + cntFeeTotalSum_04_15 + cntFeeTotalSum_03_15 + cntFeeTotalSum_02_15 + cntFeeTotalSum_01_15}"></c:set>
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFeeColTotalSum_15}" pattern="#,##0.##"/></th>
            </tr>						
			</tbody>
		</table>		
		<!-- 1종 기타 끝 -->
    </div>    
    <!-- 총 합계 시작 -->
    <!-- 총 합계 변수 시작 -->
    <c:set var="cntFeeTotalSum_12_all" value="${cntFeeTotalSum_12_5 + cntFeeTotalSum_12_10 + cntFeeTotalSum_12_15}"></c:set>
    <c:set var="cntFeeTotalSum_11_all" value="${cntFeeTotalSum_11_5 + cntFeeTotalSum_11_10 + cntFeeTotalSum_11_15}"></c:set>
    <c:set var="cntFeeTotalSum_10_all" value="${cntFeeTotalSum_10_5 + cntFeeTotalSum_10_10 + cntFeeTotalSum_10_15}"></c:set>
    <c:set var="cntFeeTotalSum_09_all" value="${cntFeeTotalSum_09_5 + cntFeeTotalSum_09_10 + cntFeeTotalSum_09_15}"></c:set>
    <c:set var="cntFeeTotalSum_08_all" value="${cntFeeTotalSum_08_5 + cntFeeTotalSum_08_10 + cntFeeTotalSum_08_15}"></c:set>
    <c:set var="cntFeeTotalSum_07_all" value="${cntFeeTotalSum_07_5 + cntFeeTotalSum_07_10 + cntFeeTotalSum_07_15}"></c:set>
    <c:set var="cntFeeTotalSum_06_all" value="${cntFeeTotalSum_06_5 + cntFeeTotalSum_06_10 + cntFeeTotalSum_06_15}"></c:set>
    <c:set var="cntFeeTotalSum_05_all" value="${cntFeeTotalSum_05_5 + cntFeeTotalSum_05_10 + cntFeeTotalSum_05_15}"></c:set>
    <c:set var="cntFeeTotalSum_04_all" value="${cntFeeTotalSum_04_5 + cntFeeTotalSum_04_10 + cntFeeTotalSum_04_15}"></c:set>
    <c:set var="cntFeeTotalSum_03_all" value="${cntFeeTotalSum_03_5 + cntFeeTotalSum_03_10 + cntFeeTotalSum_03_15}"></c:set>
    <c:set var="cntFeeTotalSum_02_all" value="${cntFeeTotalSum_02_5 + cntFeeTotalSum_02_10 + cntFeeTotalSum_02_15}"></c:set>
    <c:set var="cntFeeTotalSum_01_all" value="${cntFeeTotalSum_01_5 + cntFeeTotalSum_01_10 + cntFeeTotalSum_01_15}"></c:set>        
    <c:set var="cntFeeTotalSum_col_all" value="${cntFeeTotalSum_12_all + cntFeeTotalSum_11_all + cntFeeTotalSum_10_all + cntFeeTotalSum_09_all + cntFeeTotalSum_08_all + cntFeeTotalSum_07_all + cntFeeTotalSum_06_all + cntFeeTotalSum_05_all + cntFeeTotalSum_04_all + cntFeeTotalSum_03_all + cntFeeTotalSum_02_all + cntFeeTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체합계</th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntFeeTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntFeeTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntFeeTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntFeeTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntFeeTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntFeeTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntFeeTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntFeeTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntFeeTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntFeeTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntFeeTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntFeeTotalSum_01_all}" pattern="#,##0.##"/></th>
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${cntFeeTotalSum_col_all}" pattern="#,##0.##"/></th>
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>
