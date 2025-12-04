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
            <c:set var="fee12_5" value="0"></c:set>
            <c:set var="fee11_5" value="0"></c:set>
            <c:set var="fee10_5" value="0"></c:set>
            <c:set var="fee09_5" value="0"></c:set>
            <c:set var="fee08_5" value="0"></c:set>
            <c:set var="fee07_5" value="0"></c:set>
            <c:set var="fee06_5" value="0"></c:set>
            <c:set var="fee05_5" value="0"></c:set>
            <c:set var="fee04_5" value="0"></c:set>
            <c:set var="fee03_5" value="0"></c:set>
            <c:set var="fee02_5" value="0"></c:set>
            <c:set var="fee01_5" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="feePeriodSum_12_5" value="0"></c:set>
            <c:set var="feePeriodSum_11_5" value="0"></c:set>
            <c:set var="feePeriodSum_10_5" value="0"></c:set>
            <c:set var="feePeriodSum_09_5" value="0"></c:set>
            <c:set var="feePeriodSum_08_5" value="0"></c:set>
            <c:set var="feePeriodSum_07_5" value="0"></c:set>
            <c:set var="feePeriodSum_06_5" value="0"></c:set>
            <c:set var="feePeriodSum_05_5" value="0"></c:set>
            <c:set var="feePeriodSum_04_5" value="0"></c:set>
            <c:set var="feePeriodSum_03_5" value="0"></c:set>
            <c:set var="feePeriodSum_02_5" value="0"></c:set>
            <c:set var="feePeriodSum_01_5" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="feePtnrSum_12_5" value="0"></c:set>
            <c:set var="feePtnrSum_11_5" value="0"></c:set>
            <c:set var="feePtnrSum_10_5" value="0"></c:set>
            <c:set var="feePtnrSum_09_5" value="0"></c:set>
            <c:set var="feePtnrSum_08_5" value="0"></c:set>
            <c:set var="feePtnrSum_07_5" value="0"></c:set>
            <c:set var="feePtnrSum_06_5" value="0"></c:set>
            <c:set var="feePtnrSum_05_5" value="0"></c:set>
            <c:set var="feePtnrSum_04_5" value="0"></c:set>
            <c:set var="feePtnrSum_03_5" value="0"></c:set>
            <c:set var="feePtnrSum_02_5" value="0"></c:set>
            <c:set var="feePtnrSum_01_5" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="feeColSum_5" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="feePtnrColSum_5" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="feeTotalSum_12_5" value="0"></c:set>
            <c:set var="feeTotalSum_11_5" value="0"></c:set>
            <c:set var="feeTotalSum_10_5" value="0"></c:set>
            <c:set var="feeTotalSum_09_5" value="0"></c:set>
            <c:set var="feeTotalSum_08_5" value="0"></c:set>
            <c:set var="feeTotalSum_07_5" value="0"></c:set>
            <c:set var="feeTotalSum_06_5" value="0"></c:set>
            <c:set var="feeTotalSum_05_5" value="0"></c:set>
            <c:set var="feeTotalSum_04_5" value="0"></c:set>
            <c:set var="feeTotalSum_03_5" value="0"></c:set>
            <c:set var="feeTotalSum_02_5" value="0"></c:set>
            <c:set var="feeTotalSum_01_5" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="feeColTotalSum_5" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo" items="${ptnrStatFeeList}" varStatus="status">            
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
						            <c:set var="feePtnrSum_12_5" value="0"></c:set>
						            <c:set var="feePtnrSum_11_5" value="0"></c:set>
						            <c:set var="feePtnrSum_10_5" value="0"></c:set>
						            <c:set var="feePtnrSum_09_5" value="0"></c:set>
						            <c:set var="feePtnrSum_08_5" value="0"></c:set>
						            <c:set var="feePtnrSum_07_5" value="0"></c:set>
						            <c:set var="feePtnrSum_06_5" value="0"></c:set>
						            <c:set var="feePtnrSum_05_5" value="0"></c:set>
						            <c:set var="feePtnrSum_04_5" value="0"></c:set>
						            <c:set var="feePtnrSum_03_5" value="0"></c:set>
						            <c:set var="feePtnrSum_02_5" value="0"></c:set>
						            <c:set var="feePtnrSum_01_5" value="0"></c:set>
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
                    		<c:set var="fee12_5" value="${feePeriodSum_12_5}"></c:set>
		                    <c:set var="fee11_5" value="${feePeriodSum_11_5}"></c:set>
		                    <c:set var="fee10_5" value="${feePeriodSum_10_5}"></c:set>
		                    <c:set var="fee09_5" value="${feePeriodSum_09_5}"></c:set>
		                    <c:set var="fee08_5" value="${feePeriodSum_08_5}"></c:set>
		                    <c:set var="fee07_5" value="${feePeriodSum_07_5}"></c:set>
		                    <c:set var="fee06_5" value="${feePeriodSum_06_5}"></c:set>
		                    <c:set var="fee05_5" value="${feePeriodSum_05_5}"></c:set>
		                    <c:set var="fee04_5" value="${feePeriodSum_04_5}"></c:set>
		                    <c:set var="fee03_5" value="${feePeriodSum_03_5}"></c:set>
		                    <c:set var="fee02_5" value="${feePeriodSum_02_5}"></c:set>
		                    <c:set var="fee01_5" value="${feePeriodSum_01_5}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="fee12_5" value="${vo.fee12}"></c:set>
		                    <c:set var="fee11_5" value="${vo.fee11}"></c:set>
		                    <c:set var="fee10_5" value="${vo.fee10}"></c:set>
		                    <c:set var="fee09_5" value="${vo.fee09}"></c:set>
		                    <c:set var="fee08_5" value="${vo.fee08}"></c:set>
		                    <c:set var="fee07_5" value="${vo.fee07}"></c:set>
		                    <c:set var="fee06_5" value="${vo.fee06}"></c:set>
		                    <c:set var="fee05_5" value="${vo.fee05}"></c:set>
		                    <c:set var="fee04_5" value="${vo.fee04}"></c:set>
		                    <c:set var="fee03_5" value="${vo.fee03}"></c:set>
		                    <c:set var="fee02_5" value="${vo.fee02}"></c:set>
		                    <c:set var="fee01_5" value="${vo.fee01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="feePeriodSum_12_5" value="${feePeriodSum_12_5 + vo.fee12}"></c:set>
		                    <c:set var="feePeriodSum_11_5" value="${feePeriodSum_11_5 + vo.fee11}"></c:set>
		                    <c:set var="feePeriodSum_10_5" value="${feePeriodSum_10_5 + vo.fee10}"></c:set>
		                    <c:set var="feePeriodSum_09_5" value="${feePeriodSum_09_5 + vo.fee09}"></c:set>
		                    <c:set var="feePeriodSum_08_5" value="${feePeriodSum_08_5 + vo.fee08}"></c:set>
		                    <c:set var="feePeriodSum_07_5" value="${feePeriodSum_07_5 + vo.fee07}"></c:set>
		                    <c:set var="feePeriodSum_06_5" value="${feePeriodSum_06_5 + vo.fee06}"></c:set>
		                    <c:set var="feePeriodSum_05_5" value="${feePeriodSum_05_5 + vo.fee05}"></c:set>
		                    <c:set var="feePeriodSum_04_5" value="${feePeriodSum_04_5 + vo.fee04}"></c:set>
		                    <c:set var="feePeriodSum_03_5" value="${feePeriodSum_03_5 + vo.fee03}"></c:set>
		                    <c:set var="feePeriodSum_02_5" value="${feePeriodSum_02_5 + vo.fee02}"></c:set>
		                    <c:set var="feePeriodSum_01_5" value="${feePeriodSum_01_5 + vo.fee01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="feePtnrSum_12_5" value="${feePtnrSum_12_5 + vo.fee12}"></c:set>
		                    <c:set var="feePtnrSum_11_5" value="${feePtnrSum_11_5 + vo.fee11}"></c:set>
		                    <c:set var="feePtnrSum_10_5" value="${feePtnrSum_10_5 + vo.fee10}"></c:set>
		                    <c:set var="feePtnrSum_09_5" value="${feePtnrSum_09_5 + vo.fee09}"></c:set>
		                    <c:set var="feePtnrSum_08_5" value="${feePtnrSum_08_5 + vo.fee08}"></c:set>
		                    <c:set var="feePtnrSum_07_5" value="${feePtnrSum_07_5 + vo.fee07}"></c:set>
		                    <c:set var="feePtnrSum_06_5" value="${feePtnrSum_06_5 + vo.fee06}"></c:set>
		                    <c:set var="feePtnrSum_05_5" value="${feePtnrSum_05_5 + vo.fee05}"></c:set>
		                    <c:set var="feePtnrSum_04_5" value="${feePtnrSum_04_5 + vo.fee04}"></c:set>
		                    <c:set var="feePtnrSum_03_5" value="${feePtnrSum_03_5 + vo.fee03}"></c:set>
		                    <c:set var="feePtnrSum_02_5" value="${feePtnrSum_02_5 + vo.fee02}"></c:set>
		                    <c:set var="feePtnrSum_01_5" value="${feePtnrSum_01_5 + vo.fee01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="feeTotalSum_12_5" value="${feeTotalSum_12_5 + vo.fee12}"></c:set>
		                    <c:set var="feeTotalSum_11_5" value="${feeTotalSum_11_5 + vo.fee11}"></c:set>
		                    <c:set var="feeTotalSum_10_5" value="${feeTotalSum_10_5 + vo.fee10}"></c:set>
		                    <c:set var="feeTotalSum_09_5" value="${feeTotalSum_09_5 + vo.fee09}"></c:set>
		                    <c:set var="feeTotalSum_08_5" value="${feeTotalSum_08_5 + vo.fee08}"></c:set>
		                    <c:set var="feeTotalSum_07_5" value="${feeTotalSum_07_5 + vo.fee07}"></c:set>
		                    <c:set var="feeTotalSum_06_5" value="${feeTotalSum_06_5 + vo.fee06}"></c:set>
		                    <c:set var="feeTotalSum_05_5" value="${feeTotalSum_05_5 + vo.fee05}"></c:set>
		                    <c:set var="feeTotalSum_04_5" value="${feeTotalSum_04_5 + vo.fee04}"></c:set>
		                    <c:set var="feeTotalSum_03_5" value="${feeTotalSum_03_5 + vo.fee03}"></c:set>
		                    <c:set var="feeTotalSum_02_5" value="${feeTotalSum_02_5 + vo.fee02}"></c:set>
		                    <c:set var="feeTotalSum_01_5" value="${feeTotalSum_01_5 + vo.fee01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="feeColSum_5" value="${fee12_5 + fee11_5 + fee10_5 + fee09_5 + fee08_5 + fee07_5 + fee06_5 + fee05_5 + fee04_5 + fee03_5 + fee02_5 + fee01_5}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo.periodFlagNm == "소계"}'>
							<!-- fee12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1"><fmt:formatNumber value="${fee12_5}" pattern="#,##0.##"/></td>
		                    <!-- fee11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee11_5}" pattern="#,##0.##"/></td>
		                    <!-- fee10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee10_5}" pattern="#,##0.##"/></td>
		                    <!-- fee09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee09_5}" pattern="#,##0.##"/></td>
		                    <!-- fee08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee08_5}" pattern="#,##0.##"/></td>
		                    <!-- fee07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee07_5}" pattern="#,##0.##"/></td>
		                    <!-- fee06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee06_5}" pattern="#,##0.##"/></td>
		                    <!-- fee05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee05_5}" pattern="#,##0.##"/></td>
		                    <!-- fee04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee04_5}" pattern="#,##0.##"/></td>
		                    <!-- fee03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee03_5}" pattern="#,##0.##"/></td>
		                    <!-- fee02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee02_5}" pattern="#,##0.##"/></td>
		                    <!-- fee01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee01_5}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${feeColSum_5}" pattern="#,##0.##"/></td>
						</c:when>
						<c:otherwise>
							<!-- fee12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${fee12_5}" pattern="#,##0.##"/></td>
		                    <!-- fee11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee11_5}" pattern="#,##0.##"/></td>
		                    <!-- fee10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee10_5}" pattern="#,##0.##"/></td>
		                    <!-- fee09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee09_5}" pattern="#,##0.##"/></td>
		                    <!-- fee08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee08_5}" pattern="#,##0.##"/></td>
		                    <!-- fee07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee07_5}" pattern="#,##0.##"/></td>
		                    <!-- fee06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee06_5}" pattern="#,##0.##"/></td>
		                    <!-- fee05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee05_5}" pattern="#,##0.##"/></td>
		                    <!-- fee04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee04_5}" pattern="#,##0.##"/></td>
		                    <!-- fee03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee03_5}" pattern="#,##0.##"/></td>
		                    <!-- fee02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee02_5}" pattern="#,##0.##"/></td>
		                    <!-- fee01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee01_5}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeColSum_5}" pattern="#,##0.##"/></td>
						</c:otherwise>
					</c:choose>                                        
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo.periodFlagCode == 3}">
                    	<c:set var="feePeriodSum_12_5" value="0"></c:set>
			            <c:set var="feePeriodSum_11_5" value="0"></c:set>
			            <c:set var="feePeriodSum_10_5" value="0"></c:set>
			            <c:set var="feePeriodSum_09_5" value="0"></c:set>
			            <c:set var="feePeriodSum_08_5" value="0"></c:set>
			            <c:set var="feePeriodSum_07_5" value="0"></c:set>
			            <c:set var="feePeriodSum_06_5" value="0"></c:set>
			            <c:set var="feePeriodSum_05_5" value="0"></c:set>
			            <c:set var="feePeriodSum_04_5" value="0"></c:set>
			            <c:set var="feePeriodSum_03_5" value="0"></c:set>
			            <c:set var="feePeriodSum_02_5" value="0"></c:set>
			            <c:set var="feePeriodSum_01_5" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo.ptnrRowCnt > 1}">
                	<c:if test="${vo.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="feePeriodSum_12_5" value="0"></c:set>
			            <c:set var="feePeriodSum_11_5" value="0"></c:set>
			            <c:set var="feePeriodSum_10_5" value="0"></c:set>
			            <c:set var="feePeriodSum_09_5" value="0"></c:set>
			            <c:set var="feePeriodSum_08_5" value="0"></c:set>
			            <c:set var="feePeriodSum_07_5" value="0"></c:set>
			            <c:set var="feePeriodSum_06_5" value="0"></c:set>
			            <c:set var="feePeriodSum_05_5" value="0"></c:set>
			            <c:set var="feePeriodSum_04_5" value="0"></c:set>
			            <c:set var="feePeriodSum_03_5" value="0"></c:set>
			            <c:set var="feePeriodSum_02_5" value="0"></c:set>
			            <c:set var="feePeriodSum_01_5" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- fee12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_12_5}" pattern="#,##0.##"/></td>
		                    <!-- fee11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_11_5}" pattern="#,##0.##"/></td>
		                    <!-- fee10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_10_5}" pattern="#,##0.##"/></td>
		                    <!-- fee09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_09_5}" pattern="#,##0.##"/></td>
		                    <!-- fee08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_08_5}" pattern="#,##0.##"/></td>
		                    <!-- fee07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_07_5}" pattern="#,##0.##"/></td>
		                    <!-- fee06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_06_5}" pattern="#,##0.##"/></td>
		                    <!-- fee05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_05_5}" pattern="#,##0.##"/></td>
		                    <!-- fee04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_04_5}" pattern="#,##0.##"/></td>
		                    <!-- fee03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_03_5}" pattern="#,##0.##"/></td>
		                    <!-- fee02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_02_5}" pattern="#,##0.##"/></td>
		                    <!-- fee01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_01_5}" pattern="#,##0.##"/></td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="feePtnrColSum_5" value="${feePtnrSum_12_5 + feePtnrSum_11_5 + feePtnrSum_10_5 + feePtnrSum_09_5 + feePtnrSum_08_5 + feePtnrSum_07_5 + feePtnrSum_06_5 + feePtnrSum_05_5 + feePtnrSum_04_5 + feePtnrSum_03_5 + feePtnrSum_02_5 + feePtnrSum_01_5}"></c:set>
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrColSum_5}" pattern="#,##0.##"/></td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 조사 소계</th>
                <!-- fee12 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_12_5}" pattern="#,##0.##"/></th>
                <!-- fee11 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_11_5}" pattern="#,##0.##"/></th>
                <!-- fee10 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_10_5}" pattern="#,##0.##"/></th>
                <!-- fee09 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_09_5}" pattern="#,##0.##"/></th>
                <!-- fee08 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_08_5}" pattern="#,##0.##"/></th>
                <!-- fee07 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_07_5}" pattern="#,##0.##"/></th>
                <!-- fee06 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_06_5}" pattern="#,##0.##"/></th>
                <!-- fee05 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_05_5}" pattern="#,##0.##"/></th>
                <!-- fee04 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_04_5}" pattern="#,##0.##"/></th>
                <!-- fee03 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_03_5}" pattern="#,##0.##"/></th>
                <!-- fee02 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_02_5}" pattern="#,##0.##"/></th>
                <!-- fee01 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_01_5}" pattern="#,##0.##"/></th>
                <!-- 가로열 합계 -->
                <c:set var="feeColTotalSum_5" value="${feeTotalSum_12_5 + feeTotalSum_11_5 + feeTotalSum_10_5 + feeTotalSum_09_5 + feeTotalSum_08_5 + feeTotalSum_07_5 + feeTotalSum_06_5 + feeTotalSum_05_5 + feeTotalSum_04_5 + feeTotalSum_03_5 + feeTotalSum_02_5 + feeTotalSum_01_5}"></c:set>
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeColTotalSum_5}" pattern="#,##0.##"/></th>
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
            <c:set var="fee12_10" value="0"></c:set>
            <c:set var="fee11_10" value="0"></c:set>
            <c:set var="fee10_10" value="0"></c:set>
            <c:set var="fee09_10" value="0"></c:set>
            <c:set var="fee08_10" value="0"></c:set>
            <c:set var="fee07_10" value="0"></c:set>
            <c:set var="fee06_10" value="0"></c:set>
            <c:set var="fee05_10" value="0"></c:set>
            <c:set var="fee04_10" value="0"></c:set>
            <c:set var="fee03_10" value="0"></c:set>
            <c:set var="fee02_10" value="0"></c:set>
            <c:set var="fee01_10" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="feePeriodSum_12_10" value="0"></c:set>
            <c:set var="feePeriodSum_11_10" value="0"></c:set>
            <c:set var="feePeriodSum_10_10" value="0"></c:set>
            <c:set var="feePeriodSum_09_10" value="0"></c:set>
            <c:set var="feePeriodSum_08_10" value="0"></c:set>
            <c:set var="feePeriodSum_07_10" value="0"></c:set>
            <c:set var="feePeriodSum_06_10" value="0"></c:set>
            <c:set var="feePeriodSum_05_10" value="0"></c:set>
            <c:set var="feePeriodSum_04_10" value="0"></c:set>
            <c:set var="feePeriodSum_03_10" value="0"></c:set>
            <c:set var="feePeriodSum_02_10" value="0"></c:set>
            <c:set var="feePeriodSum_01_10" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="feePtnrSum_12_10" value="0"></c:set>
            <c:set var="feePtnrSum_11_10" value="0"></c:set>
            <c:set var="feePtnrSum_10_10" value="0"></c:set>
            <c:set var="feePtnrSum_09_10" value="0"></c:set>
            <c:set var="feePtnrSum_08_10" value="0"></c:set>
            <c:set var="feePtnrSum_07_10" value="0"></c:set>
            <c:set var="feePtnrSum_06_10" value="0"></c:set>
            <c:set var="feePtnrSum_05_10" value="0"></c:set>
            <c:set var="feePtnrSum_04_10" value="0"></c:set>
            <c:set var="feePtnrSum_03_10" value="0"></c:set>
            <c:set var="feePtnrSum_02_10" value="0"></c:set>
            <c:set var="feePtnrSum_01_10" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="feeColSum_10" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="feePtnrColSum_10" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="feeTotalSum_12_10" value="0"></c:set>
            <c:set var="feeTotalSum_11_10" value="0"></c:set>
            <c:set var="feeTotalSum_10_10" value="0"></c:set>
            <c:set var="feeTotalSum_09_10" value="0"></c:set>
            <c:set var="feeTotalSum_08_10" value="0"></c:set>
            <c:set var="feeTotalSum_07_10" value="0"></c:set>
            <c:set var="feeTotalSum_06_10" value="0"></c:set>
            <c:set var="feeTotalSum_05_10" value="0"></c:set>
            <c:set var="feeTotalSum_04_10" value="0"></c:set>
            <c:set var="feeTotalSum_03_10" value="0"></c:set>
            <c:set var="feeTotalSum_02_10" value="0"></c:set>
            <c:set var="feeTotalSum_01_10" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="feeColTotalSum_10" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo1" items="${ptnrStatFeeList_10}" varStatus="status">            
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
						            <c:set var="feePtnrSum_12_10" value="0"></c:set>
						            <c:set var="feePtnrSum_11_10" value="0"></c:set>
						            <c:set var="feePtnrSum_10_10" value="0"></c:set>
						            <c:set var="feePtnrSum_09_10" value="0"></c:set>
						            <c:set var="feePtnrSum_08_10" value="0"></c:set>
						            <c:set var="feePtnrSum_07_10" value="0"></c:set>
						            <c:set var="feePtnrSum_06_10" value="0"></c:set>
						            <c:set var="feePtnrSum_05_10" value="0"></c:set>
						            <c:set var="feePtnrSum_04_10" value="0"></c:set>
						            <c:set var="feePtnrSum_03_10" value="0"></c:set>
						            <c:set var="feePtnrSum_02_10" value="0"></c:set>
						            <c:set var="feePtnrSum_01_10" value="0"></c:set>
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
                    		<c:set var="fee12_10" value="${feePeriodSum_12_10}"></c:set>
		                    <c:set var="fee11_10" value="${feePeriodSum_11_10}"></c:set>
		                    <c:set var="fee10_10" value="${feePeriodSum_10_10}"></c:set>
		                    <c:set var="fee09_10" value="${feePeriodSum_09_10}"></c:set>
		                    <c:set var="fee08_10" value="${feePeriodSum_08_10}"></c:set>
		                    <c:set var="fee07_10" value="${feePeriodSum_07_10}"></c:set>
		                    <c:set var="fee06_10" value="${feePeriodSum_06_10}"></c:set>
		                    <c:set var="fee05_10" value="${feePeriodSum_05_10}"></c:set>
		                    <c:set var="fee04_10" value="${feePeriodSum_04_10}"></c:set>
		                    <c:set var="fee03_10" value="${feePeriodSum_03_10}"></c:set>
		                    <c:set var="fee02_10" value="${feePeriodSum_02_10}"></c:set>
		                    <c:set var="fee01_10" value="${feePeriodSum_01_10}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="fee12_10" value="${vo1.fee12}"></c:set>
		                    <c:set var="fee11_10" value="${vo1.fee11}"></c:set>
		                    <c:set var="fee10_10" value="${vo1.fee10}"></c:set>
		                    <c:set var="fee09_10" value="${vo1.fee09}"></c:set>
		                    <c:set var="fee08_10" value="${vo1.fee08}"></c:set>
		                    <c:set var="fee07_10" value="${vo1.fee07}"></c:set>
		                    <c:set var="fee06_10" value="${vo1.fee06}"></c:set>
		                    <c:set var="fee05_10" value="${vo1.fee05}"></c:set>
		                    <c:set var="fee04_10" value="${vo1.fee04}"></c:set>
		                    <c:set var="fee03_10" value="${vo1.fee03}"></c:set>
		                    <c:set var="fee02_10" value="${vo1.fee02}"></c:set>
		                    <c:set var="fee01_10" value="${vo1.fee01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="feePeriodSum_12_10" value="${feePeriodSum_12_10 + vo1.fee12}"></c:set>
		                    <c:set var="feePeriodSum_11_10" value="${feePeriodSum_11_10 + vo1.fee11}"></c:set>
		                    <c:set var="feePeriodSum_10_10" value="${feePeriodSum_10_10 + vo1.fee10}"></c:set>
		                    <c:set var="feePeriodSum_09_10" value="${feePeriodSum_09_10 + vo1.fee09}"></c:set>
		                    <c:set var="feePeriodSum_08_10" value="${feePeriodSum_08_10 + vo1.fee08}"></c:set>
		                    <c:set var="feePeriodSum_07_10" value="${feePeriodSum_07_10 + vo1.fee07}"></c:set>
		                    <c:set var="feePeriodSum_06_10" value="${feePeriodSum_06_10 + vo1.fee06}"></c:set>
		                    <c:set var="feePeriodSum_05_10" value="${feePeriodSum_05_10 + vo1.fee05}"></c:set>
		                    <c:set var="feePeriodSum_04_10" value="${feePeriodSum_04_10 + vo1.fee04}"></c:set>
		                    <c:set var="feePeriodSum_03_10" value="${feePeriodSum_03_10 + vo1.fee03}"></c:set>
		                    <c:set var="feePeriodSum_02_10" value="${feePeriodSum_02_10 + vo1.fee02}"></c:set>
		                    <c:set var="feePeriodSum_01_10" value="${feePeriodSum_01_10 + vo1.fee01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="feePtnrSum_12_10" value="${feePtnrSum_12_10 + vo1.fee12}"></c:set>
		                    <c:set var="feePtnrSum_11_10" value="${feePtnrSum_11_10 + vo1.fee11}"></c:set>
		                    <c:set var="feePtnrSum_10_10" value="${feePtnrSum_10_10 + vo1.fee10}"></c:set>
		                    <c:set var="feePtnrSum_09_10" value="${feePtnrSum_09_10 + vo1.fee09}"></c:set>
		                    <c:set var="feePtnrSum_08_10" value="${feePtnrSum_08_10 + vo1.fee08}"></c:set>
		                    <c:set var="feePtnrSum_07_10" value="${feePtnrSum_07_10 + vo1.fee07}"></c:set>
		                    <c:set var="feePtnrSum_06_10" value="${feePtnrSum_06_10 + vo1.fee06}"></c:set>
		                    <c:set var="feePtnrSum_05_10" value="${feePtnrSum_05_10 + vo1.fee05}"></c:set>
		                    <c:set var="feePtnrSum_04_10" value="${feePtnrSum_04_10 + vo1.fee04}"></c:set>
		                    <c:set var="feePtnrSum_03_10" value="${feePtnrSum_03_10 + vo1.fee03}"></c:set>
		                    <c:set var="feePtnrSum_02_10" value="${feePtnrSum_02_10 + vo1.fee02}"></c:set>
		                    <c:set var="feePtnrSum_01_10" value="${feePtnrSum_01_10 + vo1.fee01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="feeTotalSum_12_10" value="${feeTotalSum_12_10 + vo1.fee12}"></c:set>
		                    <c:set var="feeTotalSum_11_10" value="${feeTotalSum_11_10 + vo1.fee11}"></c:set>
		                    <c:set var="feeTotalSum_10_10" value="${feeTotalSum_10_10 + vo1.fee10}"></c:set>
		                    <c:set var="feeTotalSum_09_10" value="${feeTotalSum_09_10 + vo1.fee09}"></c:set>
		                    <c:set var="feeTotalSum_08_10" value="${feeTotalSum_08_10 + vo1.fee08}"></c:set>
		                    <c:set var="feeTotalSum_07_10" value="${feeTotalSum_07_10 + vo1.fee07}"></c:set>
		                    <c:set var="feeTotalSum_06_10" value="${feeTotalSum_06_10 + vo1.fee06}"></c:set>
		                    <c:set var="feeTotalSum_05_10" value="${feeTotalSum_05_10 + vo1.fee05}"></c:set>
		                    <c:set var="feeTotalSum_04_10" value="${feeTotalSum_04_10 + vo1.fee04}"></c:set>
		                    <c:set var="feeTotalSum_03_10" value="${feeTotalSum_03_10 + vo1.fee03}"></c:set>
		                    <c:set var="feeTotalSum_02_10" value="${feeTotalSum_02_10 + vo1.fee02}"></c:set>
		                    <c:set var="feeTotalSum_01_10" value="${feeTotalSum_01_10 + vo1.fee01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="feeColSum_10" value="${fee12_10 + fee11_10 + fee10_10 + fee09_10 + fee08_10 + fee07_10 + fee06_10 + fee05_10 + fee04_10 + fee03_10 + fee02_10 + fee01_10}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo1.periodFlagNm == "소계"}'>
							<!-- fee12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1"><fmt:formatNumber value="${fee12_10}" pattern="#,##0.##"/></td>
		                    <!-- fee11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee11_10}" pattern="#,##0.##"/></td>
		                    <!-- fee10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee10_10}" pattern="#,##0.##"/></td>
		                    <!-- fee09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee09_10}" pattern="#,##0.##"/></td>
		                    <!-- fee08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee08_10}" pattern="#,##0.##"/></td>
		                    <!-- fee07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee07_10}" pattern="#,##0.##"/></td>
		                    <!-- fee06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee06_10}" pattern="#,##0.##"/></td>
		                    <!-- fee05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee05_10}" pattern="#,##0.##"/></td>
		                    <!-- fee04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee04_10}" pattern="#,##0.##"/></td>
		                    <!-- fee03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee03_10}" pattern="#,##0.##"/></td>
		                    <!-- fee02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee02_10}" pattern="#,##0.##"/></td>
		                    <!-- fee01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee01_10}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${feeColSum_10}" pattern="#,##0.##"/></td>
						</c:when>
						<c:otherwise>
							<!-- fee12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${fee12_10}" pattern="#,##0.##"/></td>
		                    <!-- fee11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee11_10}" pattern="#,##0.##"/></td>
		                    <!-- fee10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee10_10}" pattern="#,##0.##"/></td>
		                    <!-- fee09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee09_10}" pattern="#,##0.##"/></td>
		                    <!-- fee08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee08_10}" pattern="#,##0.##"/></td>
		                    <!-- fee07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee07_10}" pattern="#,##0.##"/></td>
		                    <!-- fee06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee06_10}" pattern="#,##0.##"/></td>
		                    <!-- fee05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee05_10}" pattern="#,##0.##"/></td>
		                    <!-- fee04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee04_10}" pattern="#,##0.##"/></td>
		                    <!-- fee03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee03_10}" pattern="#,##0.##"/></td>
		                    <!-- fee02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee02_10}" pattern="#,##0.##"/></td>
		                    <!-- fee01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee01_10}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeColSum_10}" pattern="#,##0.##"/></td>
						</c:otherwise>
					</c:choose>  
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo1.periodFlagCode == 3}">
                    	<c:set var="feePeriodSum_12_10" value="0"></c:set>
			            <c:set var="feePeriodSum_11_10" value="0"></c:set>
			            <c:set var="feePeriodSum_10_10" value="0"></c:set>
			            <c:set var="feePeriodSum_09_10" value="0"></c:set>
			            <c:set var="feePeriodSum_08_10" value="0"></c:set>
			            <c:set var="feePeriodSum_07_10" value="0"></c:set>
			            <c:set var="feePeriodSum_06_10" value="0"></c:set>
			            <c:set var="feePeriodSum_05_10" value="0"></c:set>
			            <c:set var="feePeriodSum_04_10" value="0"></c:set>
			            <c:set var="feePeriodSum_03_10" value="0"></c:set>
			            <c:set var="feePeriodSum_02_10" value="0"></c:set>
			            <c:set var="feePeriodSum_01_10" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo1.ptnrRowCnt > 1}">
                	<c:if test="${vo1.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="feePeriodSum_12_10" value="0"></c:set>
			            <c:set var="feePeriodSum_11_10" value="0"></c:set>
			            <c:set var="feePeriodSum_10_10" value="0"></c:set>
			            <c:set var="feePeriodSum_09_10" value="0"></c:set>
			            <c:set var="feePeriodSum_08_10" value="0"></c:set>
			            <c:set var="feePeriodSum_07_10" value="0"></c:set>
			            <c:set var="feePeriodSum_06_10" value="0"></c:set>
			            <c:set var="feePeriodSum_05_10" value="0"></c:set>
			            <c:set var="feePeriodSum_04_10" value="0"></c:set>
			            <c:set var="feePeriodSum_03_10" value="0"></c:set>
			            <c:set var="feePeriodSum_02_10" value="0"></c:set>
			            <c:set var="feePeriodSum_01_10" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- fee12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_12_10}" pattern="#,##0.##"/></td>
		                    <!-- fee11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_11_10}" pattern="#,##0.##"/></td>
		                    <!-- fee10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_10_10}" pattern="#,##0.##"/></td>
		                    <!-- fee09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_09_10}" pattern="#,##0.##"/></td>
		                    <!-- fee08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_08_10}" pattern="#,##0.##"/></td>
		                    <!-- fee07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_07_10}" pattern="#,##0.##"/></td>
		                    <!-- fee06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_06_10}" pattern="#,##0.##"/></td>
		                    <!-- fee05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_05_10}" pattern="#,##0.##"/></td>
		                    <!-- fee04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_04_10}" pattern="#,##0.##"/></td>
		                    <!-- fee03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_03_10}" pattern="#,##0.##"/></td>
		                    <!-- fee02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_02_10}" pattern="#,##0.##"/></td>
		                    <!-- fee01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_01_10}" pattern="#,##0.##"/></td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="feePtnrColSum_10" value="${feePtnrSum_12_10 + feePtnrSum_11_10 + feePtnrSum_10_10 + feePtnrSum_09_10 + feePtnrSum_08_10 + feePtnrSum_07_10 + feePtnrSum_06_10 + feePtnrSum_05_10 + feePtnrSum_04_10 + feePtnrSum_03_10 + feePtnrSum_02_10 + feePtnrSum_01_10}"></c:set>
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrColSum_10}" pattern="#,##0.##"/></td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 심사 소계</th>
                <!-- fee12 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_12_10}" pattern="#,##0.##"/></th>
                <!-- fee11 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_11_10}" pattern="#,##0.##"/></th>
                <!-- fee10 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_10_10}" pattern="#,##0.##"/></th>
                <!-- fee09 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_09_10}" pattern="#,##0.##"/></th>
                <!-- fee08 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_08_10}" pattern="#,##0.##"/></th>
                <!-- fee07 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_07_10}" pattern="#,##0.##"/></th>
                <!-- fee06 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_06_10}" pattern="#,##0.##"/></th>
                <!-- fee05 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_05_10}" pattern="#,##0.##"/></th>
                <!-- fee04 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_04_10}" pattern="#,##0.##"/></th>
                <!-- fee03 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_03_10}" pattern="#,##0.##"/></th>
                <!-- fee02 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_02_10}" pattern="#,##0.##"/></th>
                <!-- fee01 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_01_10}" pattern="#,##0.##"/></th>
                <!-- 가로열 합계 -->
                <c:set var="feeColTotalSum_10" value="${feeTotalSum_12_10 + feeTotalSum_11_10 + feeTotalSum_10_10 + feeTotalSum_09_10 + feeTotalSum_08_10 + feeTotalSum_07_10 + feeTotalSum_06_10 + feeTotalSum_05_10 + feeTotalSum_04_10 + feeTotalSum_03_10 + feeTotalSum_02_10 + feeTotalSum_01_10}"></c:set>
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeColTotalSum_10}" pattern="#,##0.##"/></th>
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
            <c:set var="fee12_15" value="0"></c:set>
            <c:set var="fee11_15" value="0"></c:set>
            <c:set var="fee10_15" value="0"></c:set>
            <c:set var="fee09_15" value="0"></c:set>
            <c:set var="fee08_15" value="0"></c:set>
            <c:set var="fee07_15" value="0"></c:set>
            <c:set var="fee06_15" value="0"></c:set>
            <c:set var="fee05_15" value="0"></c:set>
            <c:set var="fee04_15" value="0"></c:set>
            <c:set var="fee03_15" value="0"></c:set>
            <c:set var="fee02_15" value="0"></c:set>
            <c:set var="fee01_15" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="feePeriodSum_12_15" value="0"></c:set>
            <c:set var="feePeriodSum_11_15" value="0"></c:set>
            <c:set var="feePeriodSum_10_15" value="0"></c:set>
            <c:set var="feePeriodSum_09_15" value="0"></c:set>
            <c:set var="feePeriodSum_08_15" value="0"></c:set>
            <c:set var="feePeriodSum_07_15" value="0"></c:set>
            <c:set var="feePeriodSum_06_15" value="0"></c:set>
            <c:set var="feePeriodSum_05_15" value="0"></c:set>
            <c:set var="feePeriodSum_04_15" value="0"></c:set>
            <c:set var="feePeriodSum_03_15" value="0"></c:set>
            <c:set var="feePeriodSum_02_15" value="0"></c:set>
            <c:set var="feePeriodSum_01_15" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="feePtnrSum_12_15" value="0"></c:set>
            <c:set var="feePtnrSum_11_15" value="0"></c:set>
            <c:set var="feePtnrSum_10_15" value="0"></c:set>
            <c:set var="feePtnrSum_09_15" value="0"></c:set>
            <c:set var="feePtnrSum_08_15" value="0"></c:set>
            <c:set var="feePtnrSum_07_15" value="0"></c:set>
            <c:set var="feePtnrSum_06_15" value="0"></c:set>
            <c:set var="feePtnrSum_05_15" value="0"></c:set>
            <c:set var="feePtnrSum_04_15" value="0"></c:set>
            <c:set var="feePtnrSum_03_15" value="0"></c:set>
            <c:set var="feePtnrSum_02_15" value="0"></c:set>
            <c:set var="feePtnrSum_01_15" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="feeColSum_15" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="feePtnrColSum_15" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="feeTotalSum_12_15" value="0"></c:set>
            <c:set var="feeTotalSum_11_15" value="0"></c:set>
            <c:set var="feeTotalSum_10_15" value="0"></c:set>
            <c:set var="feeTotalSum_09_15" value="0"></c:set>
            <c:set var="feeTotalSum_08_15" value="0"></c:set>
            <c:set var="feeTotalSum_07_15" value="0"></c:set>
            <c:set var="feeTotalSum_06_15" value="0"></c:set>
            <c:set var="feeTotalSum_05_15" value="0"></c:set>
            <c:set var="feeTotalSum_04_15" value="0"></c:set>
            <c:set var="feeTotalSum_03_15" value="0"></c:set>
            <c:set var="feeTotalSum_02_15" value="0"></c:set>
            <c:set var="feeTotalSum_01_15" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="feeColTotalSum_15" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo2" items="${ptnrStatFeeList_15}" varStatus="status">            
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
						            <c:set var="feePtnrSum_12_15" value="0"></c:set>
						            <c:set var="feePtnrSum_11_15" value="0"></c:set>
						            <c:set var="feePtnrSum_10_15" value="0"></c:set>
						            <c:set var="feePtnrSum_09_15" value="0"></c:set>
						            <c:set var="feePtnrSum_08_15" value="0"></c:set>
						            <c:set var="feePtnrSum_07_15" value="0"></c:set>
						            <c:set var="feePtnrSum_06_15" value="0"></c:set>
						            <c:set var="feePtnrSum_05_15" value="0"></c:set>
						            <c:set var="feePtnrSum_04_15" value="0"></c:set>
						            <c:set var="feePtnrSum_03_15" value="0"></c:set>
						            <c:set var="feePtnrSum_02_15" value="0"></c:set>
						            <c:set var="feePtnrSum_01_15" value="0"></c:set>
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
                    		<c:set var="fee12_15" value="${feePeriodSum_12_15}"></c:set>
		                    <c:set var="fee11_15" value="${feePeriodSum_11_15}"></c:set>
		                    <c:set var="fee10_15" value="${feePeriodSum_10_15}"></c:set>
		                    <c:set var="fee09_15" value="${feePeriodSum_09_15}"></c:set>
		                    <c:set var="fee08_15" value="${feePeriodSum_08_15}"></c:set>
		                    <c:set var="fee07_15" value="${feePeriodSum_07_15}"></c:set>
		                    <c:set var="fee06_15" value="${feePeriodSum_06_15}"></c:set>
		                    <c:set var="fee05_15" value="${feePeriodSum_05_15}"></c:set>
		                    <c:set var="fee04_15" value="${feePeriodSum_04_15}"></c:set>
		                    <c:set var="fee03_15" value="${feePeriodSum_03_15}"></c:set>
		                    <c:set var="fee02_15" value="${feePeriodSum_02_15}"></c:set>
		                    <c:set var="fee01_15" value="${feePeriodSum_01_15}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="fee12_15" value="${vo2.fee12}"></c:set>
		                    <c:set var="fee11_15" value="${vo2.fee11}"></c:set>
		                    <c:set var="fee10_15" value="${vo2.fee10}"></c:set>
		                    <c:set var="fee09_15" value="${vo2.fee09}"></c:set>
		                    <c:set var="fee08_15" value="${vo2.fee08}"></c:set>
		                    <c:set var="fee07_15" value="${vo2.fee07}"></c:set>
		                    <c:set var="fee06_15" value="${vo2.fee06}"></c:set>
		                    <c:set var="fee05_15" value="${vo2.fee05}"></c:set>
		                    <c:set var="fee04_15" value="${vo2.fee04}"></c:set>
		                    <c:set var="fee03_15" value="${vo2.fee03}"></c:set>
		                    <c:set var="fee02_15" value="${vo2.fee02}"></c:set>
		                    <c:set var="fee01_15" value="${vo2.fee01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="feePeriodSum_12_15" value="${feePeriodSum_12_15 + vo2.fee12}"></c:set>
		                    <c:set var="feePeriodSum_11_15" value="${feePeriodSum_11_15 + vo2.fee11}"></c:set>
		                    <c:set var="feePeriodSum_10_15" value="${feePeriodSum_10_15 + vo2.fee10}"></c:set>
		                    <c:set var="feePeriodSum_09_15" value="${feePeriodSum_09_15 + vo2.fee09}"></c:set>
		                    <c:set var="feePeriodSum_08_15" value="${feePeriodSum_08_15 + vo2.fee08}"></c:set>
		                    <c:set var="feePeriodSum_07_15" value="${feePeriodSum_07_15 + vo2.fee07}"></c:set>
		                    <c:set var="feePeriodSum_06_15" value="${feePeriodSum_06_15 + vo2.fee06}"></c:set>
		                    <c:set var="feePeriodSum_05_15" value="${feePeriodSum_05_15 + vo2.fee05}"></c:set>
		                    <c:set var="feePeriodSum_04_15" value="${feePeriodSum_04_15 + vo2.fee04}"></c:set>
		                    <c:set var="feePeriodSum_03_15" value="${feePeriodSum_03_15 + vo2.fee03}"></c:set>
		                    <c:set var="feePeriodSum_02_15" value="${feePeriodSum_02_15 + vo2.fee02}"></c:set>
		                    <c:set var="feePeriodSum_01_15" value="${feePeriodSum_01_15 + vo2.fee01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="feePtnrSum_12_15" value="${feePtnrSum_12_15 + vo2.fee12}"></c:set>
		                    <c:set var="feePtnrSum_11_15" value="${feePtnrSum_11_15 + vo2.fee11}"></c:set>
		                    <c:set var="feePtnrSum_10_15" value="${feePtnrSum_10_15 + vo2.fee10}"></c:set>
		                    <c:set var="feePtnrSum_09_15" value="${feePtnrSum_09_15 + vo2.fee09}"></c:set>
		                    <c:set var="feePtnrSum_08_15" value="${feePtnrSum_08_15 + vo2.fee08}"></c:set>
		                    <c:set var="feePtnrSum_07_15" value="${feePtnrSum_07_15 + vo2.fee07}"></c:set>
		                    <c:set var="feePtnrSum_06_15" value="${feePtnrSum_06_15 + vo2.fee06}"></c:set>
		                    <c:set var="feePtnrSum_05_15" value="${feePtnrSum_05_15 + vo2.fee05}"></c:set>
		                    <c:set var="feePtnrSum_04_15" value="${feePtnrSum_04_15 + vo2.fee04}"></c:set>
		                    <c:set var="feePtnrSum_03_15" value="${feePtnrSum_03_15 + vo2.fee03}"></c:set>
		                    <c:set var="feePtnrSum_02_15" value="${feePtnrSum_02_15 + vo2.fee02}"></c:set>
		                    <c:set var="feePtnrSum_01_15" value="${feePtnrSum_01_15 + vo2.fee01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="feeTotalSum_12_15" value="${feeTotalSum_12_15 + vo2.fee12}"></c:set>
		                    <c:set var="feeTotalSum_11_15" value="${feeTotalSum_11_15 + vo2.fee11}"></c:set>
		                    <c:set var="feeTotalSum_10_15" value="${feeTotalSum_10_15 + vo2.fee10}"></c:set>
		                    <c:set var="feeTotalSum_09_15" value="${feeTotalSum_09_15 + vo2.fee09}"></c:set>
		                    <c:set var="feeTotalSum_08_15" value="${feeTotalSum_08_15 + vo2.fee08}"></c:set>
		                    <c:set var="feeTotalSum_07_15" value="${feeTotalSum_07_15 + vo2.fee07}"></c:set>
		                    <c:set var="feeTotalSum_06_15" value="${feeTotalSum_06_15 + vo2.fee06}"></c:set>
		                    <c:set var="feeTotalSum_05_15" value="${feeTotalSum_05_15 + vo2.fee05}"></c:set>
		                    <c:set var="feeTotalSum_04_15" value="${feeTotalSum_04_15 + vo2.fee04}"></c:set>
		                    <c:set var="feeTotalSum_03_15" value="${feeTotalSum_03_15 + vo2.fee03}"></c:set>
		                    <c:set var="feeTotalSum_02_15" value="${feeTotalSum_02_15 + vo2.fee02}"></c:set>
		                    <c:set var="feeTotalSum_01_15" value="${feeTotalSum_01_15 + vo2.fee01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="feeColSum_15" value="${fee12_15 + fee11_15 + fee10_15 + fee09_15 + fee08_15 + fee07_15 + fee06_15 + fee05_15 + fee04_15 + fee03_15 + fee02_15 + fee01_15}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo2.periodFlagNm == "소계"}'>
							<!-- fee12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1"><fmt:formatNumber value="${fee12_15}" pattern="#,##0.##"/></td>
		                    <!-- fee11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee11_15}" pattern="#,##0.##"/></td>
		                    <!-- fee10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee10_15}" pattern="#,##0.##"/></td>
		                    <!-- fee09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee09_15}" pattern="#,##0.##"/></td>
		                    <!-- fee08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee08_15}" pattern="#,##0.##"/></td>
		                    <!-- fee07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee07_15}" pattern="#,##0.##"/></td>
		                    <!-- fee06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee06_15}" pattern="#,##0.##"/></td>
		                    <!-- fee05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee05_15}" pattern="#,##0.##"/></td>
		                    <!-- fee04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee04_15}" pattern="#,##0.##"/></td>
		                    <!-- fee03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee03_15}" pattern="#,##0.##"/></td>
		                    <!-- fee02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee02_15}" pattern="#,##0.##"/></td>
		                    <!-- fee01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${fee01_15}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${feeColSum_15}" pattern="#,##0.##"/></td>
						</c:when>
						<c:otherwise>
							<!-- fee12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${fee12_15}" pattern="#,##0.##"/></td>
		                    <!-- fee11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee11_15}" pattern="#,##0.##"/></td>
		                    <!-- fee10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee10_15}" pattern="#,##0.##"/></td>
		                    <!-- fee09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee09_15}" pattern="#,##0.##"/></td>
		                    <!-- fee08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee08_15}" pattern="#,##0.##"/></td>
		                    <!-- fee07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee07_15}" pattern="#,##0.##"/></td>
		                    <!-- fee06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee06_15}" pattern="#,##0.##"/></td>
		                    <!-- fee05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee05_15}" pattern="#,##0.##"/></td>
		                    <!-- fee04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee04_15}" pattern="#,##0.##"/></td>
		                    <!-- fee03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee03_15}" pattern="#,##0.##"/></td>
		                    <!-- fee02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee02_15}" pattern="#,##0.##"/></td>
		                    <!-- fee01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${fee01_15}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeColSum_15}" pattern="#,##0.##"/></td>
						</c:otherwise>
					</c:choose>  
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo2.periodFlagCode == 3}">
                    	<c:set var="feePeriodSum_12_15" value="0"></c:set>
			            <c:set var="feePeriodSum_11_15" value="0"></c:set>
			            <c:set var="feePeriodSum_10_15" value="0"></c:set>
			            <c:set var="feePeriodSum_09_15" value="0"></c:set>
			            <c:set var="feePeriodSum_08_15" value="0"></c:set>
			            <c:set var="feePeriodSum_07_15" value="0"></c:set>
			            <c:set var="feePeriodSum_06_15" value="0"></c:set>
			            <c:set var="feePeriodSum_05_15" value="0"></c:set>
			            <c:set var="feePeriodSum_04_15" value="0"></c:set>
			            <c:set var="feePeriodSum_03_15" value="0"></c:set>
			            <c:set var="feePeriodSum_02_15" value="0"></c:set>
			            <c:set var="feePeriodSum_01_15" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo2.ptnrRowCnt > 1}">
                	<c:if test="${vo2.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="feePeriodSum_12_15" value="0"></c:set>
			            <c:set var="feePeriodSum_11_15" value="0"></c:set>
			            <c:set var="feePeriodSum_10_15" value="0"></c:set>
			            <c:set var="feePeriodSum_09_15" value="0"></c:set>
			            <c:set var="feePeriodSum_08_15" value="0"></c:set>
			            <c:set var="feePeriodSum_07_15" value="0"></c:set>
			            <c:set var="feePeriodSum_06_15" value="0"></c:set>
			            <c:set var="feePeriodSum_05_15" value="0"></c:set>
			            <c:set var="feePeriodSum_04_15" value="0"></c:set>
			            <c:set var="feePeriodSum_03_15" value="0"></c:set>
			            <c:set var="feePeriodSum_02_15" value="0"></c:set>
			            <c:set var="feePeriodSum_01_15" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- fee12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_12_15}" pattern="#,##0.##"/></td>
		                    <!-- fee11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_11_15}" pattern="#,##0.##"/></td>
		                    <!-- fee10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_15_15}" pattern="#,##0.##"/></td>
		                    <!-- fee09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_09_15}" pattern="#,##0.##"/></td>
		                    <!-- fee08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_08_15}" pattern="#,##0.##"/></td>
		                    <!-- fee07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_07_15}" pattern="#,##0.##"/></td>
		                    <!-- fee06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_06_15}" pattern="#,##0.##"/></td>
		                    <!-- fee05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_05_15}" pattern="#,##0.##"/></td>
		                    <!-- fee04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_04_15}" pattern="#,##0.##"/></td>
		                    <!-- fee03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_03_15}" pattern="#,##0.##"/></td>
		                    <!-- fee02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_02_15}" pattern="#,##0.##"/></td>
		                    <!-- fee01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrSum_01_15}" pattern="#,##0.##"/></td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="feePtnrColSum_15" value="${feePtnrSum_12_15 + feePtnrSum_11_15 + feePtnrSum_15_15 + feePtnrSum_09_15 + feePtnrSum_08_15 + feePtnrSum_07_15 + feePtnrSum_06_15 + feePtnrSum_05_15 + feePtnrSum_04_15 + feePtnrSum_03_15 + feePtnrSum_02_15 + feePtnrSum_01_15}"></c:set>
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feePtnrColSum_15}" pattern="#,##0.##"/></td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 기타 소계</th>
                <!-- fee12 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_12_15}" pattern="#,##0.##"/></th>
                <!-- fee11 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_11_15}" pattern="#,##0.##"/></th>
                <!-- fee10 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_15_15}" pattern="#,##0.##"/></th>
                <!-- fee09 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_09_15}" pattern="#,##0.##"/></th>
                <!-- fee08 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_08_15}" pattern="#,##0.##"/></th>
                <!-- fee07 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_07_15}" pattern="#,##0.##"/></th>
                <!-- fee06 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_06_15}" pattern="#,##0.##"/></th>
                <!-- fee05 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_05_15}" pattern="#,##0.##"/></th>
                <!-- fee04 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_04_15}" pattern="#,##0.##"/></th>
                <!-- fee03 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_03_15}" pattern="#,##0.##"/></th>
                <!-- fee02 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_02_15}" pattern="#,##0.##"/></th>
                <!-- fee01 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTotalSum_01_15}" pattern="#,##0.##"/></th>
                <!-- 가로열 합계 -->
                <c:set var="feeColTotalSum_15" value="${feeTotalSum_12_15 + feeTotalSum_11_15 + feeTotalSum_15_15 + feeTotalSum_09_15 + feeTotalSum_08_15 + feeTotalSum_07_15 + feeTotalSum_06_15 + feeTotalSum_05_15 + feeTotalSum_04_15 + feeTotalSum_03_15 + feeTotalSum_02_15 + feeTotalSum_01_15}"></c:set>
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeColTotalSum_15}" pattern="#,##0.##"/></th>
            </tr>						
			</tbody>
		</table>		
		<!-- 1종 기타 끝 -->
    </div>    
    <!-- 총 합계 시작 -->
    <!-- 총 합계 변수 시작 -->
    <c:set var="feeTotalSum_12_all" value="${feeTotalSum_12_5 + feeTotalSum_12_10 + feeTotalSum_12_15}"></c:set>
    <c:set var="feeTotalSum_11_all" value="${feeTotalSum_11_5 + feeTotalSum_11_10 + feeTotalSum_11_15}"></c:set>
    <c:set var="feeTotalSum_10_all" value="${feeTotalSum_10_5 + feeTotalSum_10_10 + feeTotalSum_10_15}"></c:set>
    <c:set var="feeTotalSum_09_all" value="${feeTotalSum_09_5 + feeTotalSum_09_10 + feeTotalSum_09_15}"></c:set>
    <c:set var="feeTotalSum_08_all" value="${feeTotalSum_08_5 + feeTotalSum_08_10 + feeTotalSum_08_15}"></c:set>
    <c:set var="feeTotalSum_07_all" value="${feeTotalSum_07_5 + feeTotalSum_07_10 + feeTotalSum_07_15}"></c:set>
    <c:set var="feeTotalSum_06_all" value="${feeTotalSum_06_5 + feeTotalSum_06_10 + feeTotalSum_06_15}"></c:set>
    <c:set var="feeTotalSum_05_all" value="${feeTotalSum_05_5 + feeTotalSum_05_10 + feeTotalSum_05_15}"></c:set>
    <c:set var="feeTotalSum_04_all" value="${feeTotalSum_04_5 + feeTotalSum_04_10 + feeTotalSum_04_15}"></c:set>
    <c:set var="feeTotalSum_03_all" value="${feeTotalSum_03_5 + feeTotalSum_03_10 + feeTotalSum_03_15}"></c:set>
    <c:set var="feeTotalSum_02_all" value="${feeTotalSum_02_5 + feeTotalSum_02_10 + feeTotalSum_02_15}"></c:set>
    <c:set var="feeTotalSum_01_all" value="${feeTotalSum_01_5 + feeTotalSum_01_10 + feeTotalSum_01_15}"></c:set>        
    <c:set var="feeTotalSum_col_all" value="${feeTotalSum_12_all + feeTotalSum_11_all + feeTotalSum_10_all + feeTotalSum_09_all + feeTotalSum_08_all + feeTotalSum_07_all + feeTotalSum_06_all + feeTotalSum_05_all + feeTotalSum_04_all + feeTotalSum_03_all + feeTotalSum_02_all + feeTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체합계</th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTotalSum_01_all}" pattern="#,##0.##"/></th>
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTotalSum_col_all}" pattern="#,##0.##"/></th>
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>
