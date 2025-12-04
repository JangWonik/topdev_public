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
            <c:set var="entire12_5" value="0"></c:set>
            <c:set var="entire11_5" value="0"></c:set>
            <c:set var="entire10_5" value="0"></c:set>
            <c:set var="entire09_5" value="0"></c:set>
            <c:set var="entire08_5" value="0"></c:set>
            <c:set var="entire07_5" value="0"></c:set>
            <c:set var="entire06_5" value="0"></c:set>
            <c:set var="entire05_5" value="0"></c:set>
            <c:set var="entire04_5" value="0"></c:set>
            <c:set var="entire03_5" value="0"></c:set>
            <c:set var="entire02_5" value="0"></c:set>
            <c:set var="entire01_5" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="entirePeriodSum_12_5" value="0"></c:set>
            <c:set var="entirePeriodSum_11_5" value="0"></c:set>
            <c:set var="entirePeriodSum_10_5" value="0"></c:set>
            <c:set var="entirePeriodSum_09_5" value="0"></c:set>
            <c:set var="entirePeriodSum_08_5" value="0"></c:set>
            <c:set var="entirePeriodSum_07_5" value="0"></c:set>
            <c:set var="entirePeriodSum_06_5" value="0"></c:set>
            <c:set var="entirePeriodSum_05_5" value="0"></c:set>
            <c:set var="entirePeriodSum_04_5" value="0"></c:set>
            <c:set var="entirePeriodSum_03_5" value="0"></c:set>
            <c:set var="entirePeriodSum_02_5" value="0"></c:set>
            <c:set var="entirePeriodSum_01_5" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="entirePtnrSum_12_5" value="0"></c:set>
            <c:set var="entirePtnrSum_11_5" value="0"></c:set>
            <c:set var="entirePtnrSum_10_5" value="0"></c:set>
            <c:set var="entirePtnrSum_09_5" value="0"></c:set>
            <c:set var="entirePtnrSum_08_5" value="0"></c:set>
            <c:set var="entirePtnrSum_07_5" value="0"></c:set>
            <c:set var="entirePtnrSum_06_5" value="0"></c:set>
            <c:set var="entirePtnrSum_05_5" value="0"></c:set>
            <c:set var="entirePtnrSum_04_5" value="0"></c:set>
            <c:set var="entirePtnrSum_03_5" value="0"></c:set>
            <c:set var="entirePtnrSum_02_5" value="0"></c:set>
            <c:set var="entirePtnrSum_01_5" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="entireColSum_5" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="entirePtnrColSum_5" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="entireTotalSum_12_5" value="0"></c:set>
            <c:set var="entireTotalSum_11_5" value="0"></c:set>
            <c:set var="entireTotalSum_10_5" value="0"></c:set>
            <c:set var="entireTotalSum_09_5" value="0"></c:set>
            <c:set var="entireTotalSum_08_5" value="0"></c:set>
            <c:set var="entireTotalSum_07_5" value="0"></c:set>
            <c:set var="entireTotalSum_06_5" value="0"></c:set>
            <c:set var="entireTotalSum_05_5" value="0"></c:set>
            <c:set var="entireTotalSum_04_5" value="0"></c:set>
            <c:set var="entireTotalSum_03_5" value="0"></c:set>
            <c:set var="entireTotalSum_02_5" value="0"></c:set>
            <c:set var="entireTotalSum_01_5" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="entireColTotalSum_5" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo" items="${ptnrStatEntireList}" varStatus="status">            
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
						            <c:set var="entirePtnrSum_12_5" value="0"></c:set>
						            <c:set var="entirePtnrSum_11_5" value="0"></c:set>
						            <c:set var="entirePtnrSum_10_5" value="0"></c:set>
						            <c:set var="entirePtnrSum_09_5" value="0"></c:set>
						            <c:set var="entirePtnrSum_08_5" value="0"></c:set>
						            <c:set var="entirePtnrSum_07_5" value="0"></c:set>
						            <c:set var="entirePtnrSum_06_5" value="0"></c:set>
						            <c:set var="entirePtnrSum_05_5" value="0"></c:set>
						            <c:set var="entirePtnrSum_04_5" value="0"></c:set>
						            <c:set var="entirePtnrSum_03_5" value="0"></c:set>
						            <c:set var="entirePtnrSum_02_5" value="0"></c:set>
						            <c:set var="entirePtnrSum_01_5" value="0"></c:set>
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
                    		<c:set var="entire12_5" value="${entirePeriodSum_12_5}"></c:set>
		                    <c:set var="entire11_5" value="${entirePeriodSum_11_5}"></c:set>
		                    <c:set var="entire10_5" value="${entirePeriodSum_10_5}"></c:set>
		                    <c:set var="entire09_5" value="${entirePeriodSum_09_5}"></c:set>
		                    <c:set var="entire08_5" value="${entirePeriodSum_08_5}"></c:set>
		                    <c:set var="entire07_5" value="${entirePeriodSum_07_5}"></c:set>
		                    <c:set var="entire06_5" value="${entirePeriodSum_06_5}"></c:set>
		                    <c:set var="entire05_5" value="${entirePeriodSum_05_5}"></c:set>
		                    <c:set var="entire04_5" value="${entirePeriodSum_04_5}"></c:set>
		                    <c:set var="entire03_5" value="${entirePeriodSum_03_5}"></c:set>
		                    <c:set var="entire02_5" value="${entirePeriodSum_02_5}"></c:set>
		                    <c:set var="entire01_5" value="${entirePeriodSum_01_5}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="entire12_5" value="${vo.entire12}"></c:set>
		                    <c:set var="entire11_5" value="${vo.entire11}"></c:set>
		                    <c:set var="entire10_5" value="${vo.entire10}"></c:set>
		                    <c:set var="entire09_5" value="${vo.entire09}"></c:set>
		                    <c:set var="entire08_5" value="${vo.entire08}"></c:set>
		                    <c:set var="entire07_5" value="${vo.entire07}"></c:set>
		                    <c:set var="entire06_5" value="${vo.entire06}"></c:set>
		                    <c:set var="entire05_5" value="${vo.entire05}"></c:set>
		                    <c:set var="entire04_5" value="${vo.entire04}"></c:set>
		                    <c:set var="entire03_5" value="${vo.entire03}"></c:set>
		                    <c:set var="entire02_5" value="${vo.entire02}"></c:set>
		                    <c:set var="entire01_5" value="${vo.entire01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="entirePeriodSum_12_5" value="${entirePeriodSum_12_5 + vo.entire12}"></c:set>
		                    <c:set var="entirePeriodSum_11_5" value="${entirePeriodSum_11_5 + vo.entire11}"></c:set>
		                    <c:set var="entirePeriodSum_10_5" value="${entirePeriodSum_10_5 + vo.entire10}"></c:set>
		                    <c:set var="entirePeriodSum_09_5" value="${entirePeriodSum_09_5 + vo.entire09}"></c:set>
		                    <c:set var="entirePeriodSum_08_5" value="${entirePeriodSum_08_5 + vo.entire08}"></c:set>
		                    <c:set var="entirePeriodSum_07_5" value="${entirePeriodSum_07_5 + vo.entire07}"></c:set>
		                    <c:set var="entirePeriodSum_06_5" value="${entirePeriodSum_06_5 + vo.entire06}"></c:set>
		                    <c:set var="entirePeriodSum_05_5" value="${entirePeriodSum_05_5 + vo.entire05}"></c:set>
		                    <c:set var="entirePeriodSum_04_5" value="${entirePeriodSum_04_5 + vo.entire04}"></c:set>
		                    <c:set var="entirePeriodSum_03_5" value="${entirePeriodSum_03_5 + vo.entire03}"></c:set>
		                    <c:set var="entirePeriodSum_02_5" value="${entirePeriodSum_02_5 + vo.entire02}"></c:set>
		                    <c:set var="entirePeriodSum_01_5" value="${entirePeriodSum_01_5 + vo.entire01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="entirePtnrSum_12_5" value="${entirePtnrSum_12_5 + vo.entire12}"></c:set>
		                    <c:set var="entirePtnrSum_11_5" value="${entirePtnrSum_11_5 + vo.entire11}"></c:set>
		                    <c:set var="entirePtnrSum_10_5" value="${entirePtnrSum_10_5 + vo.entire10}"></c:set>
		                    <c:set var="entirePtnrSum_09_5" value="${entirePtnrSum_09_5 + vo.entire09}"></c:set>
		                    <c:set var="entirePtnrSum_08_5" value="${entirePtnrSum_08_5 + vo.entire08}"></c:set>
		                    <c:set var="entirePtnrSum_07_5" value="${entirePtnrSum_07_5 + vo.entire07}"></c:set>
		                    <c:set var="entirePtnrSum_06_5" value="${entirePtnrSum_06_5 + vo.entire06}"></c:set>
		                    <c:set var="entirePtnrSum_05_5" value="${entirePtnrSum_05_5 + vo.entire05}"></c:set>
		                    <c:set var="entirePtnrSum_04_5" value="${entirePtnrSum_04_5 + vo.entire04}"></c:set>
		                    <c:set var="entirePtnrSum_03_5" value="${entirePtnrSum_03_5 + vo.entire03}"></c:set>
		                    <c:set var="entirePtnrSum_02_5" value="${entirePtnrSum_02_5 + vo.entire02}"></c:set>
		                    <c:set var="entirePtnrSum_01_5" value="${entirePtnrSum_01_5 + vo.entire01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="entireTotalSum_12_5" value="${entireTotalSum_12_5 + vo.entire12}"></c:set>
		                    <c:set var="entireTotalSum_11_5" value="${entireTotalSum_11_5 + vo.entire11}"></c:set>
		                    <c:set var="entireTotalSum_10_5" value="${entireTotalSum_10_5 + vo.entire10}"></c:set>
		                    <c:set var="entireTotalSum_09_5" value="${entireTotalSum_09_5 + vo.entire09}"></c:set>
		                    <c:set var="entireTotalSum_08_5" value="${entireTotalSum_08_5 + vo.entire08}"></c:set>
		                    <c:set var="entireTotalSum_07_5" value="${entireTotalSum_07_5 + vo.entire07}"></c:set>
		                    <c:set var="entireTotalSum_06_5" value="${entireTotalSum_06_5 + vo.entire06}"></c:set>
		                    <c:set var="entireTotalSum_05_5" value="${entireTotalSum_05_5 + vo.entire05}"></c:set>
		                    <c:set var="entireTotalSum_04_5" value="${entireTotalSum_04_5 + vo.entire04}"></c:set>
		                    <c:set var="entireTotalSum_03_5" value="${entireTotalSum_03_5 + vo.entire03}"></c:set>
		                    <c:set var="entireTotalSum_02_5" value="${entireTotalSum_02_5 + vo.entire02}"></c:set>
		                    <c:set var="entireTotalSum_01_5" value="${entireTotalSum_01_5 + vo.entire01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="entireColSum_5" value="${entire12_5 + entire11_5 + entire10_5 + entire09_5 + entire08_5 + entire07_5 + entire06_5 + entire05_5 + entire04_5 + entire03_5 + entire02_5 + entire01_5}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo.periodFlagNm == "소계"}'>
							<!-- entire12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1"><fmt:formatNumber value="${entire12_5}" pattern="#,##0.##"/></td>
		                    <!-- entire11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire11_5}" pattern="#,##0.##"/></td>
		                    <!-- entire10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire10_5}" pattern="#,##0.##"/></td>
		                    <!-- entire09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire09_5}" pattern="#,##0.##"/></td>
		                    <!-- entire08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire08_5}" pattern="#,##0.##"/></td>
		                    <!-- entire07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire07_5}" pattern="#,##0.##"/></td>
		                    <!-- entire06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire06_5}" pattern="#,##0.##"/></td>
		                    <!-- entire05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire05_5}" pattern="#,##0.##"/></td>
		                    <!-- entire04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire04_5}" pattern="#,##0.##"/></td>
		                    <!-- entire03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire03_5}" pattern="#,##0.##"/></td>
		                    <!-- entire02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire02_5}" pattern="#,##0.##"/></td>
		                    <!-- entire01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire01_5}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entireColSum_5}" pattern="#,##0.##"/></td>
						</c:when>
						<c:otherwise>
							<!-- entire12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${entire12_5}" pattern="#,##0.##"/></td>
		                    <!-- entire11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire11_5}" pattern="#,##0.##"/></td>
		                    <!-- entire10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire10_5}" pattern="#,##0.##"/></td>
		                    <!-- entire09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire09_5}" pattern="#,##0.##"/></td>
		                    <!-- entire08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire08_5}" pattern="#,##0.##"/></td>
		                    <!-- entire07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire07_5}" pattern="#,##0.##"/></td>
		                    <!-- entire06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire06_5}" pattern="#,##0.##"/></td>
		                    <!-- entire05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire05_5}" pattern="#,##0.##"/></td>
		                    <!-- entire04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire04_5}" pattern="#,##0.##"/></td>
		                    <!-- entire03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire03_5}" pattern="#,##0.##"/></td>
		                    <!-- entire02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire02_5}" pattern="#,##0.##"/></td>
		                    <!-- entire01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire01_5}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireColSum_5}" pattern="#,##0.##"/></td>
						</c:otherwise>
					</c:choose>  
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo.periodFlagCode == 3}">
                    	<c:set var="entirePeriodSum_12_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_11_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_10_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_09_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_08_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_07_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_06_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_05_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_04_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_03_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_02_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_01_5" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo.ptnrRowCnt > 1}">
                	<c:if test="${vo.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="entirePeriodSum_12_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_11_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_10_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_09_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_08_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_07_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_06_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_05_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_04_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_03_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_02_5" value="0"></c:set>
			            <c:set var="entirePeriodSum_01_5" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- entire12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_12_5}" pattern="#,##0.##"/></td>
		                    <!-- entire11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_11_5}" pattern="#,##0.##"/></td>
		                    <!-- entire10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_10_5}" pattern="#,##0.##"/></td>
		                    <!-- entire09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_09_5}" pattern="#,##0.##"/></td>
		                    <!-- entire08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_08_5}" pattern="#,##0.##"/></td>
		                    <!-- entire07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_07_5}" pattern="#,##0.##"/></td>
		                    <!-- entire06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_06_5}" pattern="#,##0.##"/></td>
		                    <!-- entire05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_05_5}" pattern="#,##0.##"/></td>
		                    <!-- entire04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_04_5}" pattern="#,##0.##"/></td>
		                    <!-- entire03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_03_5}" pattern="#,##0.##"/></td>
		                    <!-- entire02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_02_5}" pattern="#,##0.##"/></td>
		                    <!-- entire01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_01_5}" pattern="#,##0.##"/></td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="entirePtnrColSum_5" value="${entirePtnrSum_12_5 + entirePtnrSum_11_5 + entirePtnrSum_10_5 + entirePtnrSum_09_5 + entirePtnrSum_08_5 + entirePtnrSum_07_5 + entirePtnrSum_06_5 + entirePtnrSum_05_5 + entirePtnrSum_04_5 + entirePtnrSum_03_5 + entirePtnrSum_02_5 + entirePtnrSum_01_5}"></c:set>
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrColSum_5}" pattern="#,##0.##"/></td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 조사 소계</th>
                <!-- entire12 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_12_5}" pattern="#,##0.##"/></th>
                <!-- entire11 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_11_5}" pattern="#,##0.##"/></th>
                <!-- entire10 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_10_5}" pattern="#,##0.##"/></th>
                <!-- entire09 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_09_5}" pattern="#,##0.##"/></th>
                <!-- entire08 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_08_5}" pattern="#,##0.##"/></th>
                <!-- entire07 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_07_5}" pattern="#,##0.##"/></th>
                <!-- entire06 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_06_5}" pattern="#,##0.##"/></th>
                <!-- entire05 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_05_5}" pattern="#,##0.##"/></th>
                <!-- entire04 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_04_5}" pattern="#,##0.##"/></th>
                <!-- entire03 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_03_5}" pattern="#,##0.##"/></th>
                <!-- entire02 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_02_5}" pattern="#,##0.##"/></th>
                <!-- entire01 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_01_5}" pattern="#,##0.##"/></th>
                <!-- 가로열 합계 -->
                <c:set var="entireColTotalSum_5" value="${entireTotalSum_12_5 + entireTotalSum_11_5 + entireTotalSum_10_5 + entireTotalSum_09_5 + entireTotalSum_08_5 + entireTotalSum_07_5 + entireTotalSum_06_5 + entireTotalSum_05_5 + entireTotalSum_04_5 + entireTotalSum_03_5 + entireTotalSum_02_5 + entireTotalSum_01_5}"></c:set>
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireColTotalSum_5}" pattern="#,##0.##"/></th>
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
            <c:set var="entire12_10" value="0"></c:set>
            <c:set var="entire11_10" value="0"></c:set>
            <c:set var="entire10_10" value="0"></c:set>
            <c:set var="entire09_10" value="0"></c:set>
            <c:set var="entire08_10" value="0"></c:set>
            <c:set var="entire07_10" value="0"></c:set>
            <c:set var="entire06_10" value="0"></c:set>
            <c:set var="entire05_10" value="0"></c:set>
            <c:set var="entire04_10" value="0"></c:set>
            <c:set var="entire03_10" value="0"></c:set>
            <c:set var="entire02_10" value="0"></c:set>
            <c:set var="entire01_10" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="entirePeriodSum_12_10" value="0"></c:set>
            <c:set var="entirePeriodSum_11_10" value="0"></c:set>
            <c:set var="entirePeriodSum_10_10" value="0"></c:set>
            <c:set var="entirePeriodSum_09_10" value="0"></c:set>
            <c:set var="entirePeriodSum_08_10" value="0"></c:set>
            <c:set var="entirePeriodSum_07_10" value="0"></c:set>
            <c:set var="entirePeriodSum_06_10" value="0"></c:set>
            <c:set var="entirePeriodSum_05_10" value="0"></c:set>
            <c:set var="entirePeriodSum_04_10" value="0"></c:set>
            <c:set var="entirePeriodSum_03_10" value="0"></c:set>
            <c:set var="entirePeriodSum_02_10" value="0"></c:set>
            <c:set var="entirePeriodSum_01_10" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="entirePtnrSum_12_10" value="0"></c:set>
            <c:set var="entirePtnrSum_11_10" value="0"></c:set>
            <c:set var="entirePtnrSum_10_10" value="0"></c:set>
            <c:set var="entirePtnrSum_09_10" value="0"></c:set>
            <c:set var="entirePtnrSum_08_10" value="0"></c:set>
            <c:set var="entirePtnrSum_07_10" value="0"></c:set>
            <c:set var="entirePtnrSum_06_10" value="0"></c:set>
            <c:set var="entirePtnrSum_05_10" value="0"></c:set>
            <c:set var="entirePtnrSum_04_10" value="0"></c:set>
            <c:set var="entirePtnrSum_03_10" value="0"></c:set>
            <c:set var="entirePtnrSum_02_10" value="0"></c:set>
            <c:set var="entirePtnrSum_01_10" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="entireColSum_10" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="entirePtnrColSum_10" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="entireTotalSum_12_10" value="0"></c:set>
            <c:set var="entireTotalSum_11_10" value="0"></c:set>
            <c:set var="entireTotalSum_10_10" value="0"></c:set>
            <c:set var="entireTotalSum_09_10" value="0"></c:set>
            <c:set var="entireTotalSum_08_10" value="0"></c:set>
            <c:set var="entireTotalSum_07_10" value="0"></c:set>
            <c:set var="entireTotalSum_06_10" value="0"></c:set>
            <c:set var="entireTotalSum_05_10" value="0"></c:set>
            <c:set var="entireTotalSum_04_10" value="0"></c:set>
            <c:set var="entireTotalSum_03_10" value="0"></c:set>
            <c:set var="entireTotalSum_02_10" value="0"></c:set>
            <c:set var="entireTotalSum_01_10" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="entireColTotalSum_10" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo1" items="${ptnrStatEntireList_10}" varStatus="status">            
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
						            <c:set var="entirePtnrSum_12_10" value="0"></c:set>
						            <c:set var="entirePtnrSum_11_10" value="0"></c:set>
						            <c:set var="entirePtnrSum_10_10" value="0"></c:set>
						            <c:set var="entirePtnrSum_09_10" value="0"></c:set>
						            <c:set var="entirePtnrSum_08_10" value="0"></c:set>
						            <c:set var="entirePtnrSum_07_10" value="0"></c:set>
						            <c:set var="entirePtnrSum_06_10" value="0"></c:set>
						            <c:set var="entirePtnrSum_05_10" value="0"></c:set>
						            <c:set var="entirePtnrSum_04_10" value="0"></c:set>
						            <c:set var="entirePtnrSum_03_10" value="0"></c:set>
						            <c:set var="entirePtnrSum_02_10" value="0"></c:set>
						            <c:set var="entirePtnrSum_01_10" value="0"></c:set>
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
                    		<c:set var="entire12_10" value="${entirePeriodSum_12_10}"></c:set>
		                    <c:set var="entire11_10" value="${entirePeriodSum_11_10}"></c:set>
		                    <c:set var="entire10_10" value="${entirePeriodSum_10_10}"></c:set>
		                    <c:set var="entire09_10" value="${entirePeriodSum_09_10}"></c:set>
		                    <c:set var="entire08_10" value="${entirePeriodSum_08_10}"></c:set>
		                    <c:set var="entire07_10" value="${entirePeriodSum_07_10}"></c:set>
		                    <c:set var="entire06_10" value="${entirePeriodSum_06_10}"></c:set>
		                    <c:set var="entire05_10" value="${entirePeriodSum_05_10}"></c:set>
		                    <c:set var="entire04_10" value="${entirePeriodSum_04_10}"></c:set>
		                    <c:set var="entire03_10" value="${entirePeriodSum_03_10}"></c:set>
		                    <c:set var="entire02_10" value="${entirePeriodSum_02_10}"></c:set>
		                    <c:set var="entire01_10" value="${entirePeriodSum_01_10}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="entire12_10" value="${vo1.entire12}"></c:set>
		                    <c:set var="entire11_10" value="${vo1.entire11}"></c:set>
		                    <c:set var="entire10_10" value="${vo1.entire10}"></c:set>
		                    <c:set var="entire09_10" value="${vo1.entire09}"></c:set>
		                    <c:set var="entire08_10" value="${vo1.entire08}"></c:set>
		                    <c:set var="entire07_10" value="${vo1.entire07}"></c:set>
		                    <c:set var="entire06_10" value="${vo1.entire06}"></c:set>
		                    <c:set var="entire05_10" value="${vo1.entire05}"></c:set>
		                    <c:set var="entire04_10" value="${vo1.entire04}"></c:set>
		                    <c:set var="entire03_10" value="${vo1.entire03}"></c:set>
		                    <c:set var="entire02_10" value="${vo1.entire02}"></c:set>
		                    <c:set var="entire01_10" value="${vo1.entire01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="entirePeriodSum_12_10" value="${entirePeriodSum_12_10 + vo1.entire12}"></c:set>
		                    <c:set var="entirePeriodSum_11_10" value="${entirePeriodSum_11_10 + vo1.entire11}"></c:set>
		                    <c:set var="entirePeriodSum_10_10" value="${entirePeriodSum_10_10 + vo1.entire10}"></c:set>
		                    <c:set var="entirePeriodSum_09_10" value="${entirePeriodSum_09_10 + vo1.entire09}"></c:set>
		                    <c:set var="entirePeriodSum_08_10" value="${entirePeriodSum_08_10 + vo1.entire08}"></c:set>
		                    <c:set var="entirePeriodSum_07_10" value="${entirePeriodSum_07_10 + vo1.entire07}"></c:set>
		                    <c:set var="entirePeriodSum_06_10" value="${entirePeriodSum_06_10 + vo1.entire06}"></c:set>
		                    <c:set var="entirePeriodSum_05_10" value="${entirePeriodSum_05_10 + vo1.entire05}"></c:set>
		                    <c:set var="entirePeriodSum_04_10" value="${entirePeriodSum_04_10 + vo1.entire04}"></c:set>
		                    <c:set var="entirePeriodSum_03_10" value="${entirePeriodSum_03_10 + vo1.entire03}"></c:set>
		                    <c:set var="entirePeriodSum_02_10" value="${entirePeriodSum_02_10 + vo1.entire02}"></c:set>
		                    <c:set var="entirePeriodSum_01_10" value="${entirePeriodSum_01_10 + vo1.entire01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="entirePtnrSum_12_10" value="${entirePtnrSum_12_10 + vo1.entire12}"></c:set>
		                    <c:set var="entirePtnrSum_11_10" value="${entirePtnrSum_11_10 + vo1.entire11}"></c:set>
		                    <c:set var="entirePtnrSum_10_10" value="${entirePtnrSum_10_10 + vo1.entire10}"></c:set>
		                    <c:set var="entirePtnrSum_09_10" value="${entirePtnrSum_09_10 + vo1.entire09}"></c:set>
		                    <c:set var="entirePtnrSum_08_10" value="${entirePtnrSum_08_10 + vo1.entire08}"></c:set>
		                    <c:set var="entirePtnrSum_07_10" value="${entirePtnrSum_07_10 + vo1.entire07}"></c:set>
		                    <c:set var="entirePtnrSum_06_10" value="${entirePtnrSum_06_10 + vo1.entire06}"></c:set>
		                    <c:set var="entirePtnrSum_05_10" value="${entirePtnrSum_05_10 + vo1.entire05}"></c:set>
		                    <c:set var="entirePtnrSum_04_10" value="${entirePtnrSum_04_10 + vo1.entire04}"></c:set>
		                    <c:set var="entirePtnrSum_03_10" value="${entirePtnrSum_03_10 + vo1.entire03}"></c:set>
		                    <c:set var="entirePtnrSum_02_10" value="${entirePtnrSum_02_10 + vo1.entire02}"></c:set>
		                    <c:set var="entirePtnrSum_01_10" value="${entirePtnrSum_01_10 + vo1.entire01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="entireTotalSum_12_10" value="${entireTotalSum_12_10 + vo1.entire12}"></c:set>
		                    <c:set var="entireTotalSum_11_10" value="${entireTotalSum_11_10 + vo1.entire11}"></c:set>
		                    <c:set var="entireTotalSum_10_10" value="${entireTotalSum_10_10 + vo1.entire10}"></c:set>
		                    <c:set var="entireTotalSum_09_10" value="${entireTotalSum_09_10 + vo1.entire09}"></c:set>
		                    <c:set var="entireTotalSum_08_10" value="${entireTotalSum_08_10 + vo1.entire08}"></c:set>
		                    <c:set var="entireTotalSum_07_10" value="${entireTotalSum_07_10 + vo1.entire07}"></c:set>
		                    <c:set var="entireTotalSum_06_10" value="${entireTotalSum_06_10 + vo1.entire06}"></c:set>
		                    <c:set var="entireTotalSum_05_10" value="${entireTotalSum_05_10 + vo1.entire05}"></c:set>
		                    <c:set var="entireTotalSum_04_10" value="${entireTotalSum_04_10 + vo1.entire04}"></c:set>
		                    <c:set var="entireTotalSum_03_10" value="${entireTotalSum_03_10 + vo1.entire03}"></c:set>
		                    <c:set var="entireTotalSum_02_10" value="${entireTotalSum_02_10 + vo1.entire02}"></c:set>
		                    <c:set var="entireTotalSum_01_10" value="${entireTotalSum_01_10 + vo1.entire01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="entireColSum_10" value="${entire12_10 + entire11_10 + entire10_10 + entire09_10 + entire08_10 + entire07_10 + entire06_10 + entire05_10 + entire04_10 + entire03_10 + entire02_10 + entire01_10}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo1.periodFlagNm == "소계"}'>
							<!-- entire12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1"><fmt:formatNumber value="${entire12_10}" pattern="#,##0.##"/></td>
		                    <!-- entire11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire11_10}" pattern="#,##0.##"/></td>
		                    <!-- entire10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire10_10}" pattern="#,##0.##"/></td>
		                    <!-- entire09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire09_10}" pattern="#,##0.##"/></td>
		                    <!-- entire08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire08_10}" pattern="#,##0.##"/></td>
		                    <!-- entire07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire07_10}" pattern="#,##0.##"/></td>
		                    <!-- entire06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire06_10}" pattern="#,##0.##"/></td>
		                    <!-- entire05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire05_10}" pattern="#,##0.##"/></td>
		                    <!-- entire04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire04_10}" pattern="#,##0.##"/></td>
		                    <!-- entire03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire03_10}" pattern="#,##0.##"/></td>
		                    <!-- entire02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire02_10}" pattern="#,##0.##"/></td>
		                    <!-- entire01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire01_10}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entireColSum_10}" pattern="#,##0.##"/></td>
						</c:when>
						<c:otherwise>
							<!-- entire12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${entire12_10}" pattern="#,##0.##"/></td>
		                    <!-- entire11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire11_10}" pattern="#,##0.##"/></td>
		                    <!-- entire10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire10_10}" pattern="#,##0.##"/></td>
		                    <!-- entire09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire09_10}" pattern="#,##0.##"/></td>
		                    <!-- entire08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire08_10}" pattern="#,##0.##"/></td>
		                    <!-- entire07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire07_10}" pattern="#,##0.##"/></td>
		                    <!-- entire06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire06_10}" pattern="#,##0.##"/></td>
		                    <!-- entire05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire05_10}" pattern="#,##0.##"/></td>
		                    <!-- entire04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire04_10}" pattern="#,##0.##"/></td>
		                    <!-- entire03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire03_10}" pattern="#,##0.##"/></td>
		                    <!-- entire02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire02_10}" pattern="#,##0.##"/></td>
		                    <!-- entire01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire01_10}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireColSum_10}" pattern="#,##0.##"/></td>
						</c:otherwise>
					</c:choose>  
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo1.periodFlagCode == 3}">
                    	<c:set var="entirePeriodSum_12_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_11_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_10_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_09_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_08_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_07_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_06_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_05_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_04_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_03_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_02_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_01_10" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo1.ptnrRowCnt > 1}">
                	<c:if test="${vo1.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="entirePeriodSum_12_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_11_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_10_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_09_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_08_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_07_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_06_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_05_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_04_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_03_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_02_10" value="0"></c:set>
			            <c:set var="entirePeriodSum_01_10" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- entire12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_12_10}" pattern="#,##0.##"/></td>
		                    <!-- entire11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_11_10}" pattern="#,##0.##"/></td>
		                    <!-- entire10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_10_10}" pattern="#,##0.##"/></td>
		                    <!-- entire09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_09_10}" pattern="#,##0.##"/></td>
		                    <!-- entire08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_08_10}" pattern="#,##0.##"/></td>
		                    <!-- entire07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_07_10}" pattern="#,##0.##"/></td>
		                    <!-- entire06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_06_10}" pattern="#,##0.##"/></td>
		                    <!-- entire05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_05_10}" pattern="#,##0.##"/></td>
		                    <!-- entire04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_04_10}" pattern="#,##0.##"/></td>
		                    <!-- entire03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_03_10}" pattern="#,##0.##"/></td>
		                    <!-- entire02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_02_10}" pattern="#,##0.##"/></td>
		                    <!-- entire01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_01_10}" pattern="#,##0.##"/></td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="entirePtnrColSum_10" value="${entirePtnrSum_12_10 + entirePtnrSum_11_10 + entirePtnrSum_10_10 + entirePtnrSum_09_10 + entirePtnrSum_08_10 + entirePtnrSum_07_10 + entirePtnrSum_06_10 + entirePtnrSum_05_10 + entirePtnrSum_04_10 + entirePtnrSum_03_10 + entirePtnrSum_02_10 + entirePtnrSum_01_10}"></c:set>
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrColSum_10}" pattern="#,##0.##"/></td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 심사 소계</th>
                <!-- entire12 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_12_10}" pattern="#,##0.##"/></th>
                <!-- entire11 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_11_10}" pattern="#,##0.##"/></th>
                <!-- entire10 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_10_10}" pattern="#,##0.##"/></th>
                <!-- entire09 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_09_10}" pattern="#,##0.##"/></th>
                <!-- entire08 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_08_10}" pattern="#,##0.##"/></th>
                <!-- entire07 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_07_10}" pattern="#,##0.##"/></th>
                <!-- entire06 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_06_10}" pattern="#,##0.##"/></th>
                <!-- entire05 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_05_10}" pattern="#,##0.##"/></th>
                <!-- entire04 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_04_10}" pattern="#,##0.##"/></th>
                <!-- entire03 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_03_10}" pattern="#,##0.##"/></th>
                <!-- entire02 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_02_10}" pattern="#,##0.##"/></th>
                <!-- entire01 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_01_10}" pattern="#,##0.##"/></th>
                <!-- 가로열 합계 -->
                <c:set var="entireColTotalSum_10" value="${entireTotalSum_12_10 + entireTotalSum_11_10 + entireTotalSum_10_10 + entireTotalSum_09_10 + entireTotalSum_08_10 + entireTotalSum_07_10 + entireTotalSum_06_10 + entireTotalSum_05_10 + entireTotalSum_04_10 + entireTotalSum_03_10 + entireTotalSum_02_10 + entireTotalSum_01_10}"></c:set>
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireColTotalSum_10}" pattern="#,##0.##"/></th>
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
            <c:set var="entire12_15" value="0"></c:set>
            <c:set var="entire11_15" value="0"></c:set>
            <c:set var="entire10_15" value="0"></c:set>
            <c:set var="entire09_15" value="0"></c:set>
            <c:set var="entire08_15" value="0"></c:set>
            <c:set var="entire07_15" value="0"></c:set>
            <c:set var="entire06_15" value="0"></c:set>
            <c:set var="entire05_15" value="0"></c:set>
            <c:set var="entire04_15" value="0"></c:set>
            <c:set var="entire03_15" value="0"></c:set>
            <c:set var="entire02_15" value="0"></c:set>
            <c:set var="entire01_15" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="entirePeriodSum_12_15" value="0"></c:set>
            <c:set var="entirePeriodSum_11_15" value="0"></c:set>
            <c:set var="entirePeriodSum_10_15" value="0"></c:set>
            <c:set var="entirePeriodSum_09_15" value="0"></c:set>
            <c:set var="entirePeriodSum_08_15" value="0"></c:set>
            <c:set var="entirePeriodSum_07_15" value="0"></c:set>
            <c:set var="entirePeriodSum_06_15" value="0"></c:set>
            <c:set var="entirePeriodSum_05_15" value="0"></c:set>
            <c:set var="entirePeriodSum_04_15" value="0"></c:set>
            <c:set var="entirePeriodSum_03_15" value="0"></c:set>
            <c:set var="entirePeriodSum_02_15" value="0"></c:set>
            <c:set var="entirePeriodSum_01_15" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="entirePtnrSum_12_15" value="0"></c:set>
            <c:set var="entirePtnrSum_11_15" value="0"></c:set>
            <c:set var="entirePtnrSum_10_15" value="0"></c:set>
            <c:set var="entirePtnrSum_09_15" value="0"></c:set>
            <c:set var="entirePtnrSum_08_15" value="0"></c:set>
            <c:set var="entirePtnrSum_07_15" value="0"></c:set>
            <c:set var="entirePtnrSum_06_15" value="0"></c:set>
            <c:set var="entirePtnrSum_05_15" value="0"></c:set>
            <c:set var="entirePtnrSum_04_15" value="0"></c:set>
            <c:set var="entirePtnrSum_03_15" value="0"></c:set>
            <c:set var="entirePtnrSum_02_15" value="0"></c:set>
            <c:set var="entirePtnrSum_01_15" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="entireColSum_15" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="entirePtnrColSum_15" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="entireTotalSum_12_15" value="0"></c:set>
            <c:set var="entireTotalSum_11_15" value="0"></c:set>
            <c:set var="entireTotalSum_10_15" value="0"></c:set>
            <c:set var="entireTotalSum_09_15" value="0"></c:set>
            <c:set var="entireTotalSum_08_15" value="0"></c:set>
            <c:set var="entireTotalSum_07_15" value="0"></c:set>
            <c:set var="entireTotalSum_06_15" value="0"></c:set>
            <c:set var="entireTotalSum_05_15" value="0"></c:set>
            <c:set var="entireTotalSum_04_15" value="0"></c:set>
            <c:set var="entireTotalSum_03_15" value="0"></c:set>
            <c:set var="entireTotalSum_02_15" value="0"></c:set>
            <c:set var="entireTotalSum_01_15" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="entireColTotalSum_15" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo2" items="${ptnrStatEntireList_15}" varStatus="status">            
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
						            <c:set var="entirePtnrSum_12_15" value="0"></c:set>
						            <c:set var="entirePtnrSum_11_15" value="0"></c:set>
						            <c:set var="entirePtnrSum_10_15" value="0"></c:set>
						            <c:set var="entirePtnrSum_09_15" value="0"></c:set>
						            <c:set var="entirePtnrSum_08_15" value="0"></c:set>
						            <c:set var="entirePtnrSum_07_15" value="0"></c:set>
						            <c:set var="entirePtnrSum_06_15" value="0"></c:set>
						            <c:set var="entirePtnrSum_05_15" value="0"></c:set>
						            <c:set var="entirePtnrSum_04_15" value="0"></c:set>
						            <c:set var="entirePtnrSum_03_15" value="0"></c:set>
						            <c:set var="entirePtnrSum_02_15" value="0"></c:set>
						            <c:set var="entirePtnrSum_01_15" value="0"></c:set>
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
                    		<c:set var="entire12_15" value="${entirePeriodSum_12_15}"></c:set>
		                    <c:set var="entire11_15" value="${entirePeriodSum_11_15}"></c:set>
		                    <c:set var="entire10_15" value="${entirePeriodSum_10_15}"></c:set>
		                    <c:set var="entire09_15" value="${entirePeriodSum_09_15}"></c:set>
		                    <c:set var="entire08_15" value="${entirePeriodSum_08_15}"></c:set>
		                    <c:set var="entire07_15" value="${entirePeriodSum_07_15}"></c:set>
		                    <c:set var="entire06_15" value="${entirePeriodSum_06_15}"></c:set>
		                    <c:set var="entire05_15" value="${entirePeriodSum_05_15}"></c:set>
		                    <c:set var="entire04_15" value="${entirePeriodSum_04_15}"></c:set>
		                    <c:set var="entire03_15" value="${entirePeriodSum_03_15}"></c:set>
		                    <c:set var="entire02_15" value="${entirePeriodSum_02_15}"></c:set>
		                    <c:set var="entire01_15" value="${entirePeriodSum_01_15}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="entire12_15" value="${vo2.entire12}"></c:set>
		                    <c:set var="entire11_15" value="${vo2.entire11}"></c:set>
		                    <c:set var="entire10_15" value="${vo2.entire10}"></c:set>
		                    <c:set var="entire09_15" value="${vo2.entire09}"></c:set>
		                    <c:set var="entire08_15" value="${vo2.entire08}"></c:set>
		                    <c:set var="entire07_15" value="${vo2.entire07}"></c:set>
		                    <c:set var="entire06_15" value="${vo2.entire06}"></c:set>
		                    <c:set var="entire05_15" value="${vo2.entire05}"></c:set>
		                    <c:set var="entire04_15" value="${vo2.entire04}"></c:set>
		                    <c:set var="entire03_15" value="${vo2.entire03}"></c:set>
		                    <c:set var="entire02_15" value="${vo2.entire02}"></c:set>
		                    <c:set var="entire01_15" value="${vo2.entire01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="entirePeriodSum_12_15" value="${entirePeriodSum_12_15 + vo2.entire12}"></c:set>
		                    <c:set var="entirePeriodSum_11_15" value="${entirePeriodSum_11_15 + vo2.entire11}"></c:set>
		                    <c:set var="entirePeriodSum_10_15" value="${entirePeriodSum_10_15 + vo2.entire10}"></c:set>
		                    <c:set var="entirePeriodSum_09_15" value="${entirePeriodSum_09_15 + vo2.entire09}"></c:set>
		                    <c:set var="entirePeriodSum_08_15" value="${entirePeriodSum_08_15 + vo2.entire08}"></c:set>
		                    <c:set var="entirePeriodSum_07_15" value="${entirePeriodSum_07_15 + vo2.entire07}"></c:set>
		                    <c:set var="entirePeriodSum_06_15" value="${entirePeriodSum_06_15 + vo2.entire06}"></c:set>
		                    <c:set var="entirePeriodSum_05_15" value="${entirePeriodSum_05_15 + vo2.entire05}"></c:set>
		                    <c:set var="entirePeriodSum_04_15" value="${entirePeriodSum_04_15 + vo2.entire04}"></c:set>
		                    <c:set var="entirePeriodSum_03_15" value="${entirePeriodSum_03_15 + vo2.entire03}"></c:set>
		                    <c:set var="entirePeriodSum_02_15" value="${entirePeriodSum_02_15 + vo2.entire02}"></c:set>
		                    <c:set var="entirePeriodSum_01_15" value="${entirePeriodSum_01_15 + vo2.entire01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="entirePtnrSum_12_15" value="${entirePtnrSum_12_15 + vo2.entire12}"></c:set>
		                    <c:set var="entirePtnrSum_11_15" value="${entirePtnrSum_11_15 + vo2.entire11}"></c:set>
		                    <c:set var="entirePtnrSum_10_15" value="${entirePtnrSum_10_15 + vo2.entire10}"></c:set>
		                    <c:set var="entirePtnrSum_09_15" value="${entirePtnrSum_09_15 + vo2.entire09}"></c:set>
		                    <c:set var="entirePtnrSum_08_15" value="${entirePtnrSum_08_15 + vo2.entire08}"></c:set>
		                    <c:set var="entirePtnrSum_07_15" value="${entirePtnrSum_07_15 + vo2.entire07}"></c:set>
		                    <c:set var="entirePtnrSum_06_15" value="${entirePtnrSum_06_15 + vo2.entire06}"></c:set>
		                    <c:set var="entirePtnrSum_05_15" value="${entirePtnrSum_05_15 + vo2.entire05}"></c:set>
		                    <c:set var="entirePtnrSum_04_15" value="${entirePtnrSum_04_15 + vo2.entire04}"></c:set>
		                    <c:set var="entirePtnrSum_03_15" value="${entirePtnrSum_03_15 + vo2.entire03}"></c:set>
		                    <c:set var="entirePtnrSum_02_15" value="${entirePtnrSum_02_15 + vo2.entire02}"></c:set>
		                    <c:set var="entirePtnrSum_01_15" value="${entirePtnrSum_01_15 + vo2.entire01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="entireTotalSum_12_15" value="${entireTotalSum_12_15 + vo2.entire12}"></c:set>
		                    <c:set var="entireTotalSum_11_15" value="${entireTotalSum_11_15 + vo2.entire11}"></c:set>
		                    <c:set var="entireTotalSum_10_15" value="${entireTotalSum_10_15 + vo2.entire10}"></c:set>
		                    <c:set var="entireTotalSum_09_15" value="${entireTotalSum_09_15 + vo2.entire09}"></c:set>
		                    <c:set var="entireTotalSum_08_15" value="${entireTotalSum_08_15 + vo2.entire08}"></c:set>
		                    <c:set var="entireTotalSum_07_15" value="${entireTotalSum_07_15 + vo2.entire07}"></c:set>
		                    <c:set var="entireTotalSum_06_15" value="${entireTotalSum_06_15 + vo2.entire06}"></c:set>
		                    <c:set var="entireTotalSum_05_15" value="${entireTotalSum_05_15 + vo2.entire05}"></c:set>
		                    <c:set var="entireTotalSum_04_15" value="${entireTotalSum_04_15 + vo2.entire04}"></c:set>
		                    <c:set var="entireTotalSum_03_15" value="${entireTotalSum_03_15 + vo2.entire03}"></c:set>
		                    <c:set var="entireTotalSum_02_15" value="${entireTotalSum_02_15 + vo2.entire02}"></c:set>
		                    <c:set var="entireTotalSum_01_15" value="${entireTotalSum_01_15 + vo2.entire01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="entireColSum_15" value="${entire12_15 + entire11_15 + entire10_15 + entire09_15 + entire08_15 + entire07_15 + entire06_15 + entire05_15 + entire04_15 + entire03_15 + entire02_15 + entire01_15}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo2.periodFlagNm == "소계"}'>
							<!-- entire12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1"><fmt:formatNumber value="${entire12_15}" pattern="#,##0.##"/></td>
		                    <!-- entire11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire11_15}" pattern="#,##0.##"/></td>
		                    <!-- entire10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire10_15}" pattern="#,##0.##"/></td>
		                    <!-- entire09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire09_15}" pattern="#,##0.##"/></td>
		                    <!-- entire08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire08_15}" pattern="#,##0.##"/></td>
		                    <!-- entire07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire07_15}" pattern="#,##0.##"/></td>
		                    <!-- entire06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire06_15}" pattern="#,##0.##"/></td>
		                    <!-- entire05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire05_15}" pattern="#,##0.##"/></td>
		                    <!-- entire04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire04_15}" pattern="#,##0.##"/></td>
		                    <!-- entire03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire03_15}" pattern="#,##0.##"/></td>
		                    <!-- entire02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire02_15}" pattern="#,##0.##"/></td>
		                    <!-- entire01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entire01_15}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${entireColSum_15}" pattern="#,##0.##"/></td>
						</c:when>
						<c:otherwise>
							<!-- entire12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${entire12_15}" pattern="#,##0.##"/></td>
		                    <!-- entire11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire11_15}" pattern="#,##0.##"/></td>
		                    <!-- entire10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire10_15}" pattern="#,##0.##"/></td>
		                    <!-- entire09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire09_15}" pattern="#,##0.##"/></td>
		                    <!-- entire08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire08_15}" pattern="#,##0.##"/></td>
		                    <!-- entire07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire07_15}" pattern="#,##0.##"/></td>
		                    <!-- entire06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire06_15}" pattern="#,##0.##"/></td>
		                    <!-- entire05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire05_15}" pattern="#,##0.##"/></td>
		                    <!-- entire04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire04_15}" pattern="#,##0.##"/></td>
		                    <!-- entire03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire03_15}" pattern="#,##0.##"/></td>
		                    <!-- entire02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire02_15}" pattern="#,##0.##"/></td>
		                    <!-- entire01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire01_15}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireColSum_15}" pattern="#,##0.##"/></td>
						</c:otherwise>
					</c:choose>  
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo2.periodFlagCode == 3}">
                    	<c:set var="entirePeriodSum_12_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_11_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_10_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_09_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_08_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_07_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_06_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_05_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_04_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_03_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_02_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_01_15" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo2.ptnrRowCnt > 1}">
                	<c:if test="${vo2.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="entirePeriodSum_12_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_11_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_10_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_09_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_08_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_07_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_06_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_05_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_04_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_03_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_02_15" value="0"></c:set>
			            <c:set var="entirePeriodSum_01_15" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- entire12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_12_15}" pattern="#,##0.##"/></td>
		                    <!-- entire11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_11_15}" pattern="#,##0.##"/></td>
		                    <!-- entire10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_10_15}" pattern="#,##0.##"/></td>
		                    <!-- entire09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_09_15}" pattern="#,##0.##"/></td>
		                    <!-- entire08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_08_15}" pattern="#,##0.##"/></td>
		                    <!-- entire07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_07_15}" pattern="#,##0.##"/></td>
		                    <!-- entire06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_06_15}" pattern="#,##0.##"/></td>
		                    <!-- entire05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_05_15}" pattern="#,##0.##"/></td>
		                    <!-- entire04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_04_15}" pattern="#,##0.##"/></td>
		                    <!-- entire03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_03_15}" pattern="#,##0.##"/></td>
		                    <!-- entire02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_02_15}" pattern="#,##0.##"/></td>
		                    <!-- entire01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrSum_01_15}" pattern="#,##0.##"/></td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="entirePtnrColSum_15" value="${entirePtnrSum_12_15 + entirePtnrSum_11_15 + entirePtnrSum_10_15 + entirePtnrSum_09_15 + entirePtnrSum_08_15 + entirePtnrSum_07_15 + entirePtnrSum_06_15 + entirePtnrSum_05_15 + entirePtnrSum_04_15 + entirePtnrSum_03_15 + entirePtnrSum_02_15 + entirePtnrSum_01_15}"></c:set>
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entirePtnrColSum_15}" pattern="#,##0.##"/></td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 기타 소계</th>
                <!-- entire12 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_12_15}" pattern="#,##0.##"/></th>
                <!-- entire11 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_11_15}" pattern="#,##0.##"/></th>
                <!-- entire10 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_10_15}" pattern="#,##0.##"/></th>
                <!-- entire09 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_09_15}" pattern="#,##0.##"/></th>
                <!-- entire08 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_08_15}" pattern="#,##0.##"/></th>
                <!-- entire07 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_07_15}" pattern="#,##0.##"/></th>
                <!-- entire06 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_06_15}" pattern="#,##0.##"/></th>
                <!-- entire05 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_05_15}" pattern="#,##0.##"/></th>
                <!-- entire04 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_04_15}" pattern="#,##0.##"/></th>
                <!-- entire03 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_03_15}" pattern="#,##0.##"/></th>
                <!-- entire02 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_02_15}" pattern="#,##0.##"/></th>
                <!-- entire01 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTotalSum_01_15}" pattern="#,##0.##"/></th>
                <!-- 가로열 합계 -->
                <c:set var="entireColTotalSum_15" value="${entireTotalSum_12_15 + entireTotalSum_11_15 + entireTotalSum_10_15 + entireTotalSum_09_15 + entireTotalSum_08_15 + entireTotalSum_07_15 + entireTotalSum_06_15 + entireTotalSum_05_15 + entireTotalSum_04_15 + entireTotalSum_03_15 + entireTotalSum_02_15 + entireTotalSum_01_15}"></c:set>
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireColTotalSum_15}" pattern="#,##0.##"/></th>
            </tr>						
			</tbody>
		</table>		
		<!-- 1종 기타 끝 -->
    </div>    
    <!-- 총 합계 시작 -->
    <!-- 총 합계 변수 시작 -->
    <c:set var="entireTotalSum_12_all" value="${entireTotalSum_12_5 + entireTotalSum_12_10 + entireTotalSum_12_15}"></c:set>
    <c:set var="entireTotalSum_11_all" value="${entireTotalSum_11_5 + entireTotalSum_11_10 + entireTotalSum_11_15}"></c:set>
    <c:set var="entireTotalSum_10_all" value="${entireTotalSum_10_5 + entireTotalSum_10_10 + entireTotalSum_10_15}"></c:set>
    <c:set var="entireTotalSum_09_all" value="${entireTotalSum_09_5 + entireTotalSum_09_10 + entireTotalSum_09_15}"></c:set>
    <c:set var="entireTotalSum_08_all" value="${entireTotalSum_08_5 + entireTotalSum_08_10 + entireTotalSum_08_15}"></c:set>
    <c:set var="entireTotalSum_07_all" value="${entireTotalSum_07_5 + entireTotalSum_07_10 + entireTotalSum_07_15}"></c:set>
    <c:set var="entireTotalSum_06_all" value="${entireTotalSum_06_5 + entireTotalSum_06_10 + entireTotalSum_06_15}"></c:set>
    <c:set var="entireTotalSum_05_all" value="${entireTotalSum_05_5 + entireTotalSum_05_10 + entireTotalSum_05_15}"></c:set>
    <c:set var="entireTotalSum_04_all" value="${entireTotalSum_04_5 + entireTotalSum_04_10 + entireTotalSum_04_15}"></c:set>
    <c:set var="entireTotalSum_03_all" value="${entireTotalSum_03_5 + entireTotalSum_03_10 + entireTotalSum_03_15}"></c:set>
    <c:set var="entireTotalSum_02_all" value="${entireTotalSum_02_5 + entireTotalSum_02_10 + entireTotalSum_02_15}"></c:set>
    <c:set var="entireTotalSum_01_all" value="${entireTotalSum_01_5 + entireTotalSum_01_10 + entireTotalSum_01_15}"></c:set>        
    <c:set var="entireTotalSum_col_all" value="${entireTotalSum_12_all + entireTotalSum_11_all + entireTotalSum_10_all + entireTotalSum_09_all + entireTotalSum_08_all + entireTotalSum_07_all + entireTotalSum_06_all + entireTotalSum_05_all + entireTotalSum_04_all + entireTotalSum_03_all + entireTotalSum_02_all + entireTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체합계</th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTotalSum_01_all}" pattern="#,##0.##"/></th>
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTotalSum_col_all}" pattern="#,##0.##"/></th>
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>
