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
            <c:set var="etc12_5" value="0"></c:set>
            <c:set var="etc11_5" value="0"></c:set>
            <c:set var="etc10_5" value="0"></c:set>
            <c:set var="etc09_5" value="0"></c:set>
            <c:set var="etc08_5" value="0"></c:set>
            <c:set var="etc07_5" value="0"></c:set>
            <c:set var="etc06_5" value="0"></c:set>
            <c:set var="etc05_5" value="0"></c:set>
            <c:set var="etc04_5" value="0"></c:set>
            <c:set var="etc03_5" value="0"></c:set>
            <c:set var="etc02_5" value="0"></c:set>
            <c:set var="etc01_5" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="etcPeriodSum_12_5" value="0"></c:set>
            <c:set var="etcPeriodSum_11_5" value="0"></c:set>
            <c:set var="etcPeriodSum_10_5" value="0"></c:set>
            <c:set var="etcPeriodSum_09_5" value="0"></c:set>
            <c:set var="etcPeriodSum_08_5" value="0"></c:set>
            <c:set var="etcPeriodSum_07_5" value="0"></c:set>
            <c:set var="etcPeriodSum_06_5" value="0"></c:set>
            <c:set var="etcPeriodSum_05_5" value="0"></c:set>
            <c:set var="etcPeriodSum_04_5" value="0"></c:set>
            <c:set var="etcPeriodSum_03_5" value="0"></c:set>
            <c:set var="etcPeriodSum_02_5" value="0"></c:set>
            <c:set var="etcPeriodSum_01_5" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="etcPtnrSum_12_5" value="0"></c:set>
            <c:set var="etcPtnrSum_11_5" value="0"></c:set>
            <c:set var="etcPtnrSum_10_5" value="0"></c:set>
            <c:set var="etcPtnrSum_09_5" value="0"></c:set>
            <c:set var="etcPtnrSum_08_5" value="0"></c:set>
            <c:set var="etcPtnrSum_07_5" value="0"></c:set>
            <c:set var="etcPtnrSum_06_5" value="0"></c:set>
            <c:set var="etcPtnrSum_05_5" value="0"></c:set>
            <c:set var="etcPtnrSum_04_5" value="0"></c:set>
            <c:set var="etcPtnrSum_03_5" value="0"></c:set>
            <c:set var="etcPtnrSum_02_5" value="0"></c:set>
            <c:set var="etcPtnrSum_01_5" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="etcColSum_5" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="etcPtnrColSum_5" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="etcTotalSum_12_5" value="0"></c:set>
            <c:set var="etcTotalSum_11_5" value="0"></c:set>
            <c:set var="etcTotalSum_10_5" value="0"></c:set>
            <c:set var="etcTotalSum_09_5" value="0"></c:set>
            <c:set var="etcTotalSum_08_5" value="0"></c:set>
            <c:set var="etcTotalSum_07_5" value="0"></c:set>
            <c:set var="etcTotalSum_06_5" value="0"></c:set>
            <c:set var="etcTotalSum_05_5" value="0"></c:set>
            <c:set var="etcTotalSum_04_5" value="0"></c:set>
            <c:set var="etcTotalSum_03_5" value="0"></c:set>
            <c:set var="etcTotalSum_02_5" value="0"></c:set>
            <c:set var="etcTotalSum_01_5" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="etcColTotalSum_5" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo" items="${ptnrStatEtcList}" varStatus="status">            
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
						            <c:set var="etcPtnrSum_12_5" value="0"></c:set>
						            <c:set var="etcPtnrSum_11_5" value="0"></c:set>
						            <c:set var="etcPtnrSum_10_5" value="0"></c:set>
						            <c:set var="etcPtnrSum_09_5" value="0"></c:set>
						            <c:set var="etcPtnrSum_08_5" value="0"></c:set>
						            <c:set var="etcPtnrSum_07_5" value="0"></c:set>
						            <c:set var="etcPtnrSum_06_5" value="0"></c:set>
						            <c:set var="etcPtnrSum_05_5" value="0"></c:set>
						            <c:set var="etcPtnrSum_04_5" value="0"></c:set>
						            <c:set var="etcPtnrSum_03_5" value="0"></c:set>
						            <c:set var="etcPtnrSum_02_5" value="0"></c:set>
						            <c:set var="etcPtnrSum_01_5" value="0"></c:set>
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
                    		<c:set var="etc12_5" value="${etcPeriodSum_12_5}"></c:set>
		                    <c:set var="etc11_5" value="${etcPeriodSum_11_5}"></c:set>
		                    <c:set var="etc10_5" value="${etcPeriodSum_10_5}"></c:set>
		                    <c:set var="etc09_5" value="${etcPeriodSum_09_5}"></c:set>
		                    <c:set var="etc08_5" value="${etcPeriodSum_08_5}"></c:set>
		                    <c:set var="etc07_5" value="${etcPeriodSum_07_5}"></c:set>
		                    <c:set var="etc06_5" value="${etcPeriodSum_06_5}"></c:set>
		                    <c:set var="etc05_5" value="${etcPeriodSum_05_5}"></c:set>
		                    <c:set var="etc04_5" value="${etcPeriodSum_04_5}"></c:set>
		                    <c:set var="etc03_5" value="${etcPeriodSum_03_5}"></c:set>
		                    <c:set var="etc02_5" value="${etcPeriodSum_02_5}"></c:set>
		                    <c:set var="etc01_5" value="${etcPeriodSum_01_5}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="etc12_5" value="${vo.etc12}"></c:set>
		                    <c:set var="etc11_5" value="${vo.etc11}"></c:set>
		                    <c:set var="etc10_5" value="${vo.etc10}"></c:set>
		                    <c:set var="etc09_5" value="${vo.etc09}"></c:set>
		                    <c:set var="etc08_5" value="${vo.etc08}"></c:set>
		                    <c:set var="etc07_5" value="${vo.etc07}"></c:set>
		                    <c:set var="etc06_5" value="${vo.etc06}"></c:set>
		                    <c:set var="etc05_5" value="${vo.etc05}"></c:set>
		                    <c:set var="etc04_5" value="${vo.etc04}"></c:set>
		                    <c:set var="etc03_5" value="${vo.etc03}"></c:set>
		                    <c:set var="etc02_5" value="${vo.etc02}"></c:set>
		                    <c:set var="etc01_5" value="${vo.etc01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="etcPeriodSum_12_5" value="${etcPeriodSum_12_5 + vo.etc12}"></c:set>
		                    <c:set var="etcPeriodSum_11_5" value="${etcPeriodSum_11_5 + vo.etc11}"></c:set>
		                    <c:set var="etcPeriodSum_10_5" value="${etcPeriodSum_10_5 + vo.etc10}"></c:set>
		                    <c:set var="etcPeriodSum_09_5" value="${etcPeriodSum_09_5 + vo.etc09}"></c:set>
		                    <c:set var="etcPeriodSum_08_5" value="${etcPeriodSum_08_5 + vo.etc08}"></c:set>
		                    <c:set var="etcPeriodSum_07_5" value="${etcPeriodSum_07_5 + vo.etc07}"></c:set>
		                    <c:set var="etcPeriodSum_06_5" value="${etcPeriodSum_06_5 + vo.etc06}"></c:set>
		                    <c:set var="etcPeriodSum_05_5" value="${etcPeriodSum_05_5 + vo.etc05}"></c:set>
		                    <c:set var="etcPeriodSum_04_5" value="${etcPeriodSum_04_5 + vo.etc04}"></c:set>
		                    <c:set var="etcPeriodSum_03_5" value="${etcPeriodSum_03_5 + vo.etc03}"></c:set>
		                    <c:set var="etcPeriodSum_02_5" value="${etcPeriodSum_02_5 + vo.etc02}"></c:set>
		                    <c:set var="etcPeriodSum_01_5" value="${etcPeriodSum_01_5 + vo.etc01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="etcPtnrSum_12_5" value="${etcPtnrSum_12_5 + vo.etc12}"></c:set>
		                    <c:set var="etcPtnrSum_11_5" value="${etcPtnrSum_11_5 + vo.etc11}"></c:set>
		                    <c:set var="etcPtnrSum_10_5" value="${etcPtnrSum_10_5 + vo.etc10}"></c:set>
		                    <c:set var="etcPtnrSum_09_5" value="${etcPtnrSum_09_5 + vo.etc09}"></c:set>
		                    <c:set var="etcPtnrSum_08_5" value="${etcPtnrSum_08_5 + vo.etc08}"></c:set>
		                    <c:set var="etcPtnrSum_07_5" value="${etcPtnrSum_07_5 + vo.etc07}"></c:set>
		                    <c:set var="etcPtnrSum_06_5" value="${etcPtnrSum_06_5 + vo.etc06}"></c:set>
		                    <c:set var="etcPtnrSum_05_5" value="${etcPtnrSum_05_5 + vo.etc05}"></c:set>
		                    <c:set var="etcPtnrSum_04_5" value="${etcPtnrSum_04_5 + vo.etc04}"></c:set>
		                    <c:set var="etcPtnrSum_03_5" value="${etcPtnrSum_03_5 + vo.etc03}"></c:set>
		                    <c:set var="etcPtnrSum_02_5" value="${etcPtnrSum_02_5 + vo.etc02}"></c:set>
		                    <c:set var="etcPtnrSum_01_5" value="${etcPtnrSum_01_5 + vo.etc01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="etcTotalSum_12_5" value="${etcTotalSum_12_5 + vo.etc12}"></c:set>
		                    <c:set var="etcTotalSum_11_5" value="${etcTotalSum_11_5 + vo.etc11}"></c:set>
		                    <c:set var="etcTotalSum_10_5" value="${etcTotalSum_10_5 + vo.etc10}"></c:set>
		                    <c:set var="etcTotalSum_09_5" value="${etcTotalSum_09_5 + vo.etc09}"></c:set>
		                    <c:set var="etcTotalSum_08_5" value="${etcTotalSum_08_5 + vo.etc08}"></c:set>
		                    <c:set var="etcTotalSum_07_5" value="${etcTotalSum_07_5 + vo.etc07}"></c:set>
		                    <c:set var="etcTotalSum_06_5" value="${etcTotalSum_06_5 + vo.etc06}"></c:set>
		                    <c:set var="etcTotalSum_05_5" value="${etcTotalSum_05_5 + vo.etc05}"></c:set>
		                    <c:set var="etcTotalSum_04_5" value="${etcTotalSum_04_5 + vo.etc04}"></c:set>
		                    <c:set var="etcTotalSum_03_5" value="${etcTotalSum_03_5 + vo.etc03}"></c:set>
		                    <c:set var="etcTotalSum_02_5" value="${etcTotalSum_02_5 + vo.etc02}"></c:set>
		                    <c:set var="etcTotalSum_01_5" value="${etcTotalSum_01_5 + vo.etc01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="etcColSum_5" value="${etc12_5 + etc11_5 + etc10_5 + etc09_5 + etc08_5 + etc07_5 + etc06_5 + etc05_5 + etc04_5 + etc03_5 + etc02_5 + etc01_5}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo.periodFlagNm == "소계"}'>
							<!-- etc12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1"><fmt:formatNumber value="${etc12_5}" pattern="#,##0.##"/></td>
		                    <!-- etc11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc11_5}" pattern="#,##0.##"/></td>
		                    <!-- etc10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc10_5}" pattern="#,##0.##"/></td>
		                    <!-- etc09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc09_5}" pattern="#,##0.##"/></td>
		                    <!-- etc08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc08_5}" pattern="#,##0.##"/></td>
		                    <!-- etc07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc07_5}" pattern="#,##0.##"/></td>
		                    <!-- etc06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc06_5}" pattern="#,##0.##"/></td>
		                    <!-- etc05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc05_5}" pattern="#,##0.##"/></td>
		                    <!-- etc04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc04_5}" pattern="#,##0.##"/></td>
		                    <!-- etc03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc03_5}" pattern="#,##0.##"/></td>
		                    <!-- etc02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc02_5}" pattern="#,##0.##"/></td>
		                    <!-- etc01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc01_5}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etcColSum_5}" pattern="#,##0.##"/></td>
						</c:when>
						<c:otherwise>
							<!-- etc12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${etc12_5}" pattern="#,##0.##"/></td>
		                    <!-- etc11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc11_5}" pattern="#,##0.##"/></td>
		                    <!-- etc10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc10_5}" pattern="#,##0.##"/></td>
		                    <!-- etc09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc09_5}" pattern="#,##0.##"/></td>
		                    <!-- etc08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc08_5}" pattern="#,##0.##"/></td>
		                    <!-- etc07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc07_5}" pattern="#,##0.##"/></td>
		                    <!-- etc06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc06_5}" pattern="#,##0.##"/></td>
		                    <!-- etc05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc05_5}" pattern="#,##0.##"/></td>
		                    <!-- etc04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc04_5}" pattern="#,##0.##"/></td>
		                    <!-- etc03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc03_5}" pattern="#,##0.##"/></td>
		                    <!-- etc02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc02_5}" pattern="#,##0.##"/></td>
		                    <!-- etc01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc01_5}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcColSum_5}" pattern="#,##0.##"/></td>
						</c:otherwise>
					</c:choose>                    
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo.periodFlagCode == 3}">
                    	<c:set var="etcPeriodSum_12_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_11_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_10_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_09_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_08_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_07_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_06_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_05_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_04_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_03_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_02_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_01_5" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo.ptnrRowCnt > 1}">
                	<c:if test="${vo.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="etcPeriodSum_12_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_11_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_10_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_09_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_08_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_07_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_06_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_05_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_04_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_03_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_02_5" value="0"></c:set>
			            <c:set var="etcPeriodSum_01_5" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- etc12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_12_5}" pattern="#,##0.##"/></td>
		                    <!-- etc11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_11_5}" pattern="#,##0.##"/></td>
		                    <!-- etc10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_10_5}" pattern="#,##0.##"/></td>
		                    <!-- etc09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_09_5}" pattern="#,##0.##"/></td>
		                    <!-- etc08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_08_5}" pattern="#,##0.##"/></td>
		                    <!-- etc07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_07_5}" pattern="#,##0.##"/></td>
		                    <!-- etc06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_06_5}" pattern="#,##0.##"/></td>
		                    <!-- etc05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_05_5}" pattern="#,##0.##"/></td>
		                    <!-- etc04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_04_5}" pattern="#,##0.##"/></td>
		                    <!-- etc03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_03_5}" pattern="#,##0.##"/></td>
		                    <!-- etc02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_02_5}" pattern="#,##0.##"/></td>
		                    <!-- etc01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_01_5}" pattern="#,##0.##"/></td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="etcPtnrColSum_5" value="${etcPtnrSum_12_5 + etcPtnrSum_11_5 + etcPtnrSum_10_5 + etcPtnrSum_09_5 + etcPtnrSum_08_5 + etcPtnrSum_07_5 + etcPtnrSum_06_5 + etcPtnrSum_05_5 + etcPtnrSum_04_5 + etcPtnrSum_03_5 + etcPtnrSum_02_5 + etcPtnrSum_01_5}"></c:set>
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrColSum_5}" pattern="#,##0.##"/></td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 조사 소계</th>
                <!-- etc12 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_12_5}" pattern="#,##0.##"/></th>
                <!-- etc11 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_11_5}" pattern="#,##0.##"/></th>
                <!-- etc10 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_10_5}" pattern="#,##0.##"/></th>
                <!-- etc09 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_09_5}" pattern="#,##0.##"/></th>
                <!-- etc08 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_08_5}" pattern="#,##0.##"/></th>
                <!-- etc07 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_07_5}" pattern="#,##0.##"/></th>
                <!-- etc06 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_06_5}" pattern="#,##0.##"/></th>
                <!-- etc05 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_05_5}" pattern="#,##0.##"/></th>
                <!-- etc04 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_04_5}" pattern="#,##0.##"/></th>
                <!-- etc03 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_03_5}" pattern="#,##0.##"/></th>
                <!-- etc02 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_02_5}" pattern="#,##0.##"/></th>
                <!-- etc01 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_01_5}" pattern="#,##0.##"/></th>
                <!-- 가로열 합계 -->
                <c:set var="etcColTotalSum_5" value="${etcTotalSum_12_5 + etcTotalSum_11_5 + etcTotalSum_10_5 + etcTotalSum_09_5 + etcTotalSum_08_5 + etcTotalSum_07_5 + etcTotalSum_06_5 + etcTotalSum_05_5 + etcTotalSum_04_5 + etcTotalSum_03_5 + etcTotalSum_02_5 + etcTotalSum_01_5}"></c:set>
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcColTotalSum_5}" pattern="#,##0.##"/></th>
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
            <c:set var="etc12_10" value="0"></c:set>
            <c:set var="etc11_10" value="0"></c:set>
            <c:set var="etc10_10" value="0"></c:set>
            <c:set var="etc09_10" value="0"></c:set>
            <c:set var="etc08_10" value="0"></c:set>
            <c:set var="etc07_10" value="0"></c:set>
            <c:set var="etc06_10" value="0"></c:set>
            <c:set var="etc05_10" value="0"></c:set>
            <c:set var="etc04_10" value="0"></c:set>
            <c:set var="etc03_10" value="0"></c:set>
            <c:set var="etc02_10" value="0"></c:set>
            <c:set var="etc01_10" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="etcPeriodSum_12_10" value="0"></c:set>
            <c:set var="etcPeriodSum_11_10" value="0"></c:set>
            <c:set var="etcPeriodSum_10_10" value="0"></c:set>
            <c:set var="etcPeriodSum_09_10" value="0"></c:set>
            <c:set var="etcPeriodSum_08_10" value="0"></c:set>
            <c:set var="etcPeriodSum_07_10" value="0"></c:set>
            <c:set var="etcPeriodSum_06_10" value="0"></c:set>
            <c:set var="etcPeriodSum_05_10" value="0"></c:set>
            <c:set var="etcPeriodSum_04_10" value="0"></c:set>
            <c:set var="etcPeriodSum_03_10" value="0"></c:set>
            <c:set var="etcPeriodSum_02_10" value="0"></c:set>
            <c:set var="etcPeriodSum_01_10" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="etcPtnrSum_12_10" value="0"></c:set>
            <c:set var="etcPtnrSum_11_10" value="0"></c:set>
            <c:set var="etcPtnrSum_10_10" value="0"></c:set>
            <c:set var="etcPtnrSum_09_10" value="0"></c:set>
            <c:set var="etcPtnrSum_08_10" value="0"></c:set>
            <c:set var="etcPtnrSum_07_10" value="0"></c:set>
            <c:set var="etcPtnrSum_06_10" value="0"></c:set>
            <c:set var="etcPtnrSum_05_10" value="0"></c:set>
            <c:set var="etcPtnrSum_04_10" value="0"></c:set>
            <c:set var="etcPtnrSum_03_10" value="0"></c:set>
            <c:set var="etcPtnrSum_02_10" value="0"></c:set>
            <c:set var="etcPtnrSum_01_10" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="etcColSum_10" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="etcPtnrColSum_10" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="etcTotalSum_12_10" value="0"></c:set>
            <c:set var="etcTotalSum_11_10" value="0"></c:set>
            <c:set var="etcTotalSum_10_10" value="0"></c:set>
            <c:set var="etcTotalSum_09_10" value="0"></c:set>
            <c:set var="etcTotalSum_08_10" value="0"></c:set>
            <c:set var="etcTotalSum_07_10" value="0"></c:set>
            <c:set var="etcTotalSum_06_10" value="0"></c:set>
            <c:set var="etcTotalSum_05_10" value="0"></c:set>
            <c:set var="etcTotalSum_04_10" value="0"></c:set>
            <c:set var="etcTotalSum_03_10" value="0"></c:set>
            <c:set var="etcTotalSum_02_10" value="0"></c:set>
            <c:set var="etcTotalSum_01_10" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="etcColTotalSum_10" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo1" items="${ptnrStatEtcList_10}" varStatus="status">            
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
						            <c:set var="etcPtnrSum_12_10" value="0"></c:set>
						            <c:set var="etcPtnrSum_11_10" value="0"></c:set>
						            <c:set var="etcPtnrSum_10_10" value="0"></c:set>
						            <c:set var="etcPtnrSum_09_10" value="0"></c:set>
						            <c:set var="etcPtnrSum_08_10" value="0"></c:set>
						            <c:set var="etcPtnrSum_07_10" value="0"></c:set>
						            <c:set var="etcPtnrSum_06_10" value="0"></c:set>
						            <c:set var="etcPtnrSum_05_10" value="0"></c:set>
						            <c:set var="etcPtnrSum_04_10" value="0"></c:set>
						            <c:set var="etcPtnrSum_03_10" value="0"></c:set>
						            <c:set var="etcPtnrSum_02_10" value="0"></c:set>
						            <c:set var="etcPtnrSum_01_10" value="0"></c:set>
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
                    		<c:set var="etc12_10" value="${etcPeriodSum_12_10}"></c:set>
		                    <c:set var="etc11_10" value="${etcPeriodSum_11_10}"></c:set>
		                    <c:set var="etc10_10" value="${etcPeriodSum_10_10}"></c:set>
		                    <c:set var="etc09_10" value="${etcPeriodSum_09_10}"></c:set>
		                    <c:set var="etc08_10" value="${etcPeriodSum_08_10}"></c:set>
		                    <c:set var="etc07_10" value="${etcPeriodSum_07_10}"></c:set>
		                    <c:set var="etc06_10" value="${etcPeriodSum_06_10}"></c:set>
		                    <c:set var="etc05_10" value="${etcPeriodSum_05_10}"></c:set>
		                    <c:set var="etc04_10" value="${etcPeriodSum_04_10}"></c:set>
		                    <c:set var="etc03_10" value="${etcPeriodSum_03_10}"></c:set>
		                    <c:set var="etc02_10" value="${etcPeriodSum_02_10}"></c:set>
		                    <c:set var="etc01_10" value="${etcPeriodSum_01_10}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="etc12_10" value="${vo1.etc12}"></c:set>
		                    <c:set var="etc11_10" value="${vo1.etc11}"></c:set>
		                    <c:set var="etc10_10" value="${vo1.etc10}"></c:set>
		                    <c:set var="etc09_10" value="${vo1.etc09}"></c:set>
		                    <c:set var="etc08_10" value="${vo1.etc08}"></c:set>
		                    <c:set var="etc07_10" value="${vo1.etc07}"></c:set>
		                    <c:set var="etc06_10" value="${vo1.etc06}"></c:set>
		                    <c:set var="etc05_10" value="${vo1.etc05}"></c:set>
		                    <c:set var="etc04_10" value="${vo1.etc04}"></c:set>
		                    <c:set var="etc03_10" value="${vo1.etc03}"></c:set>
		                    <c:set var="etc02_10" value="${vo1.etc02}"></c:set>
		                    <c:set var="etc01_10" value="${vo1.etc01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="etcPeriodSum_12_10" value="${etcPeriodSum_12_10 + vo1.etc12}"></c:set>
		                    <c:set var="etcPeriodSum_11_10" value="${etcPeriodSum_11_10 + vo1.etc11}"></c:set>
		                    <c:set var="etcPeriodSum_10_10" value="${etcPeriodSum_10_10 + vo1.etc10}"></c:set>
		                    <c:set var="etcPeriodSum_09_10" value="${etcPeriodSum_09_10 + vo1.etc09}"></c:set>
		                    <c:set var="etcPeriodSum_08_10" value="${etcPeriodSum_08_10 + vo1.etc08}"></c:set>
		                    <c:set var="etcPeriodSum_07_10" value="${etcPeriodSum_07_10 + vo1.etc07}"></c:set>
		                    <c:set var="etcPeriodSum_06_10" value="${etcPeriodSum_06_10 + vo1.etc06}"></c:set>
		                    <c:set var="etcPeriodSum_05_10" value="${etcPeriodSum_05_10 + vo1.etc05}"></c:set>
		                    <c:set var="etcPeriodSum_04_10" value="${etcPeriodSum_04_10 + vo1.etc04}"></c:set>
		                    <c:set var="etcPeriodSum_03_10" value="${etcPeriodSum_03_10 + vo1.etc03}"></c:set>
		                    <c:set var="etcPeriodSum_02_10" value="${etcPeriodSum_02_10 + vo1.etc02}"></c:set>
		                    <c:set var="etcPeriodSum_01_10" value="${etcPeriodSum_01_10 + vo1.etc01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="etcPtnrSum_12_10" value="${etcPtnrSum_12_10 + vo1.etc12}"></c:set>
		                    <c:set var="etcPtnrSum_11_10" value="${etcPtnrSum_11_10 + vo1.etc11}"></c:set>
		                    <c:set var="etcPtnrSum_10_10" value="${etcPtnrSum_10_10 + vo1.etc10}"></c:set>
		                    <c:set var="etcPtnrSum_09_10" value="${etcPtnrSum_09_10 + vo1.etc09}"></c:set>
		                    <c:set var="etcPtnrSum_08_10" value="${etcPtnrSum_08_10 + vo1.etc08}"></c:set>
		                    <c:set var="etcPtnrSum_07_10" value="${etcPtnrSum_07_10 + vo1.etc07}"></c:set>
		                    <c:set var="etcPtnrSum_06_10" value="${etcPtnrSum_06_10 + vo1.etc06}"></c:set>
		                    <c:set var="etcPtnrSum_05_10" value="${etcPtnrSum_05_10 + vo1.etc05}"></c:set>
		                    <c:set var="etcPtnrSum_04_10" value="${etcPtnrSum_04_10 + vo1.etc04}"></c:set>
		                    <c:set var="etcPtnrSum_03_10" value="${etcPtnrSum_03_10 + vo1.etc03}"></c:set>
		                    <c:set var="etcPtnrSum_02_10" value="${etcPtnrSum_02_10 + vo1.etc02}"></c:set>
		                    <c:set var="etcPtnrSum_01_10" value="${etcPtnrSum_01_10 + vo1.etc01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="etcTotalSum_12_10" value="${etcTotalSum_12_10 + vo1.etc12}"></c:set>
		                    <c:set var="etcTotalSum_11_10" value="${etcTotalSum_11_10 + vo1.etc11}"></c:set>
		                    <c:set var="etcTotalSum_10_10" value="${etcTotalSum_10_10 + vo1.etc10}"></c:set>
		                    <c:set var="etcTotalSum_09_10" value="${etcTotalSum_09_10 + vo1.etc09}"></c:set>
		                    <c:set var="etcTotalSum_08_10" value="${etcTotalSum_08_10 + vo1.etc08}"></c:set>
		                    <c:set var="etcTotalSum_07_10" value="${etcTotalSum_07_10 + vo1.etc07}"></c:set>
		                    <c:set var="etcTotalSum_06_10" value="${etcTotalSum_06_10 + vo1.etc06}"></c:set>
		                    <c:set var="etcTotalSum_05_10" value="${etcTotalSum_05_10 + vo1.etc05}"></c:set>
		                    <c:set var="etcTotalSum_04_10" value="${etcTotalSum_04_10 + vo1.etc04}"></c:set>
		                    <c:set var="etcTotalSum_03_10" value="${etcTotalSum_03_10 + vo1.etc03}"></c:set>
		                    <c:set var="etcTotalSum_02_10" value="${etcTotalSum_02_10 + vo1.etc02}"></c:set>
		                    <c:set var="etcTotalSum_01_10" value="${etcTotalSum_01_10 + vo1.etc01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="etcColSum_10" value="${etc12_10 + etc11_10 + etc10_10 + etc09_10 + etc08_10 + etc07_10 + etc06_10 + etc05_10 + etc04_10 + etc03_10 + etc02_10 + etc01_10}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo1.periodFlagNm == "소계"}'>
							<!-- etc12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1"><fmt:formatNumber value="${etc12_10}" pattern="#,##0.##"/></td>
		                    <!-- etc11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc11_10}" pattern="#,##0.##"/></td>
		                    <!-- etc10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc10_10}" pattern="#,##0.##"/></td>
		                    <!-- etc09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc09_10}" pattern="#,##0.##"/></td>
		                    <!-- etc08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc08_10}" pattern="#,##0.##"/></td>
		                    <!-- etc07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc07_10}" pattern="#,##0.##"/></td>
		                    <!-- etc06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc06_10}" pattern="#,##0.##"/></td>
		                    <!-- etc05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc05_10}" pattern="#,##0.##"/></td>
		                    <!-- etc04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc04_10}" pattern="#,##0.##"/></td>
		                    <!-- etc03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc03_10}" pattern="#,##0.##"/></td>
		                    <!-- etc02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc02_10}" pattern="#,##0.##"/></td>
		                    <!-- etc01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc01_10}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etcColSum_10}" pattern="#,##0.##"/></td>
						</c:when>
						<c:otherwise>
							<!-- etc12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${etc12_10}" pattern="#,##0.##"/></td>
		                    <!-- etc11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc11_10}" pattern="#,##0.##"/></td>
		                    <!-- etc10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc10_10}" pattern="#,##0.##"/></td>
		                    <!-- etc09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc09_10}" pattern="#,##0.##"/></td>
		                    <!-- etc08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc08_10}" pattern="#,##0.##"/></td>
		                    <!-- etc07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc07_10}" pattern="#,##0.##"/></td>
		                    <!-- etc06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc06_10}" pattern="#,##0.##"/></td>
		                    <!-- etc05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc05_10}" pattern="#,##0.##"/></td>
		                    <!-- etc04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc04_10}" pattern="#,##0.##"/></td>
		                    <!-- etc03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc03_10}" pattern="#,##0.##"/></td>
		                    <!-- etc02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc02_10}" pattern="#,##0.##"/></td>
		                    <!-- etc01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc01_10}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcColSum_10}" pattern="#,##0.##"/></td>
						</c:otherwise>
					</c:choose>  
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo1.periodFlagCode == 3}">
                    	<c:set var="etcPeriodSum_12_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_11_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_10_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_09_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_08_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_07_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_06_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_05_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_04_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_03_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_02_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_01_10" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo1.ptnrRowCnt > 1}">
                	<c:if test="${vo1.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="etcPeriodSum_12_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_11_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_10_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_09_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_08_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_07_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_06_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_05_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_04_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_03_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_02_10" value="0"></c:set>
			            <c:set var="etcPeriodSum_01_10" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- etc12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_12_10}" pattern="#,##0.##"/></td>
		                    <!-- etc11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_11_10}" pattern="#,##0.##"/></td>
		                    <!-- etc10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_10_10}" pattern="#,##0.##"/></td>
		                    <!-- etc09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_09_10}" pattern="#,##0.##"/></td>
		                    <!-- etc08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_08_10}" pattern="#,##0.##"/></td>
		                    <!-- etc07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_07_10}" pattern="#,##0.##"/></td>
		                    <!-- etc06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_06_10}" pattern="#,##0.##"/></td>
		                    <!-- etc05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_05_10}" pattern="#,##0.##"/></td>
		                    <!-- etc04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_04_10}" pattern="#,##0.##"/></td>
		                    <!-- etc03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_03_10}" pattern="#,##0.##"/></td>
		                    <!-- etc02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_02_10}" pattern="#,##0.##"/></td>
		                    <!-- etc01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_01_10}" pattern="#,##0.##"/></td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="etcPtnrColSum_10" value="${etcPtnrSum_12_10 + etcPtnrSum_11_10 + etcPtnrSum_10_10 + etcPtnrSum_09_10 + etcPtnrSum_08_10 + etcPtnrSum_07_10 + etcPtnrSum_06_10 + etcPtnrSum_05_10 + etcPtnrSum_04_10 + etcPtnrSum_03_10 + etcPtnrSum_02_10 + etcPtnrSum_01_10}"></c:set>
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrColSum_10}" pattern="#,##0.##"/></td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 심사 소계</th>
                <!-- etc12 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_12_10}" pattern="#,##0.##"/></th>
                <!-- etc11 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_11_10}" pattern="#,##0.##"/></th>
                <!-- etc10 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_10_10}" pattern="#,##0.##"/></th>
                <!-- etc09 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_09_10}" pattern="#,##0.##"/></th>
                <!-- etc08 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_08_10}" pattern="#,##0.##"/></th>
                <!-- etc07 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_07_10}" pattern="#,##0.##"/></th>
                <!-- etc06 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_06_10}" pattern="#,##0.##"/></th>
                <!-- etc05 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_05_10}" pattern="#,##0.##"/></th>
                <!-- etc04 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_04_10}" pattern="#,##0.##"/></th>
                <!-- etc03 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_03_10}" pattern="#,##0.##"/></th>
                <!-- etc02 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_02_10}" pattern="#,##0.##"/></th>
                <!-- etc01 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_01_10}" pattern="#,##0.##"/></th>
                <!-- 가로열 합계 -->
                <c:set var="etcColTotalSum_10" value="${etcTotalSum_12_10 + etcTotalSum_11_10 + etcTotalSum_10_10 + etcTotalSum_09_10 + etcTotalSum_08_10 + etcTotalSum_07_10 + etcTotalSum_06_10 + etcTotalSum_05_10 + etcTotalSum_04_10 + etcTotalSum_03_10 + etcTotalSum_02_10 + etcTotalSum_01_10}"></c:set>
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcColTotalSum_10}" pattern="#,##0.##"/></th>
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
            <c:set var="etc12_15" value="0"></c:set>
            <c:set var="etc11_15" value="0"></c:set>
            <c:set var="etc10_15" value="0"></c:set>
            <c:set var="etc09_15" value="0"></c:set>
            <c:set var="etc08_15" value="0"></c:set>
            <c:set var="etc07_15" value="0"></c:set>
            <c:set var="etc06_15" value="0"></c:set>
            <c:set var="etc05_15" value="0"></c:set>
            <c:set var="etc04_15" value="0"></c:set>
            <c:set var="etc03_15" value="0"></c:set>
            <c:set var="etc02_15" value="0"></c:set>
            <c:set var="etc01_15" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="etcPeriodSum_12_15" value="0"></c:set>
            <c:set var="etcPeriodSum_11_15" value="0"></c:set>
            <c:set var="etcPeriodSum_10_15" value="0"></c:set>
            <c:set var="etcPeriodSum_09_15" value="0"></c:set>
            <c:set var="etcPeriodSum_08_15" value="0"></c:set>
            <c:set var="etcPeriodSum_07_15" value="0"></c:set>
            <c:set var="etcPeriodSum_06_15" value="0"></c:set>
            <c:set var="etcPeriodSum_05_15" value="0"></c:set>
            <c:set var="etcPeriodSum_04_15" value="0"></c:set>
            <c:set var="etcPeriodSum_03_15" value="0"></c:set>
            <c:set var="etcPeriodSum_02_15" value="0"></c:set>
            <c:set var="etcPeriodSum_01_15" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="etcPtnrSum_12_15" value="0"></c:set>
            <c:set var="etcPtnrSum_11_15" value="0"></c:set>
            <c:set var="etcPtnrSum_10_15" value="0"></c:set>
            <c:set var="etcPtnrSum_09_15" value="0"></c:set>
            <c:set var="etcPtnrSum_08_15" value="0"></c:set>
            <c:set var="etcPtnrSum_07_15" value="0"></c:set>
            <c:set var="etcPtnrSum_06_15" value="0"></c:set>
            <c:set var="etcPtnrSum_05_15" value="0"></c:set>
            <c:set var="etcPtnrSum_04_15" value="0"></c:set>
            <c:set var="etcPtnrSum_03_15" value="0"></c:set>
            <c:set var="etcPtnrSum_02_15" value="0"></c:set>
            <c:set var="etcPtnrSum_01_15" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="etcColSum_15" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="etcPtnrColSum_15" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="etcTotalSum_12_15" value="0"></c:set>
            <c:set var="etcTotalSum_11_15" value="0"></c:set>
            <c:set var="etcTotalSum_10_15" value="0"></c:set>
            <c:set var="etcTotalSum_09_15" value="0"></c:set>
            <c:set var="etcTotalSum_08_15" value="0"></c:set>
            <c:set var="etcTotalSum_07_15" value="0"></c:set>
            <c:set var="etcTotalSum_06_15" value="0"></c:set>
            <c:set var="etcTotalSum_05_15" value="0"></c:set>
            <c:set var="etcTotalSum_04_15" value="0"></c:set>
            <c:set var="etcTotalSum_03_15" value="0"></c:set>
            <c:set var="etcTotalSum_02_15" value="0"></c:set>
            <c:set var="etcTotalSum_01_15" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="etcColTotalSum_15" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo2" items="${ptnrStatEtcList_15}" varStatus="status">            
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
						            <c:set var="etcPtnrSum_12_15" value="0"></c:set>
						            <c:set var="etcPtnrSum_11_15" value="0"></c:set>
						            <c:set var="etcPtnrSum_10_15" value="0"></c:set>
						            <c:set var="etcPtnrSum_09_15" value="0"></c:set>
						            <c:set var="etcPtnrSum_08_15" value="0"></c:set>
						            <c:set var="etcPtnrSum_07_15" value="0"></c:set>
						            <c:set var="etcPtnrSum_06_15" value="0"></c:set>
						            <c:set var="etcPtnrSum_05_15" value="0"></c:set>
						            <c:set var="etcPtnrSum_04_15" value="0"></c:set>
						            <c:set var="etcPtnrSum_03_15" value="0"></c:set>
						            <c:set var="etcPtnrSum_02_15" value="0"></c:set>
						            <c:set var="etcPtnrSum_01_15" value="0"></c:set>
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
                    		<c:set var="etc12_15" value="${etcPeriodSum_12_15}"></c:set>
		                    <c:set var="etc11_15" value="${etcPeriodSum_11_15}"></c:set>
		                    <c:set var="etc10_15" value="${etcPeriodSum_10_15}"></c:set>
		                    <c:set var="etc09_15" value="${etcPeriodSum_09_15}"></c:set>
		                    <c:set var="etc08_15" value="${etcPeriodSum_08_15}"></c:set>
		                    <c:set var="etc07_15" value="${etcPeriodSum_07_15}"></c:set>
		                    <c:set var="etc06_15" value="${etcPeriodSum_06_15}"></c:set>
		                    <c:set var="etc05_15" value="${etcPeriodSum_05_15}"></c:set>
		                    <c:set var="etc04_15" value="${etcPeriodSum_04_15}"></c:set>
		                    <c:set var="etc03_15" value="${etcPeriodSum_03_15}"></c:set>
		                    <c:set var="etc02_15" value="${etcPeriodSum_02_15}"></c:set>
		                    <c:set var="etc01_15" value="${etcPeriodSum_01_15}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="etc12_15" value="${vo2.etc12}"></c:set>
		                    <c:set var="etc11_15" value="${vo2.etc11}"></c:set>
		                    <c:set var="etc10_15" value="${vo2.etc10}"></c:set>
		                    <c:set var="etc09_15" value="${vo2.etc09}"></c:set>
		                    <c:set var="etc08_15" value="${vo2.etc08}"></c:set>
		                    <c:set var="etc07_15" value="${vo2.etc07}"></c:set>
		                    <c:set var="etc06_15" value="${vo2.etc06}"></c:set>
		                    <c:set var="etc05_15" value="${vo2.etc05}"></c:set>
		                    <c:set var="etc04_15" value="${vo2.etc04}"></c:set>
		                    <c:set var="etc03_15" value="${vo2.etc03}"></c:set>
		                    <c:set var="etc02_15" value="${vo2.etc02}"></c:set>
		                    <c:set var="etc01_15" value="${vo2.etc01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="etcPeriodSum_12_15" value="${etcPeriodSum_12_15 + vo2.etc12}"></c:set>
		                    <c:set var="etcPeriodSum_11_15" value="${etcPeriodSum_11_15 + vo2.etc11}"></c:set>
		                    <c:set var="etcPeriodSum_10_15" value="${etcPeriodSum_10_15 + vo2.etc10}"></c:set>
		                    <c:set var="etcPeriodSum_09_15" value="${etcPeriodSum_09_15 + vo2.etc09}"></c:set>
		                    <c:set var="etcPeriodSum_08_15" value="${etcPeriodSum_08_15 + vo2.etc08}"></c:set>
		                    <c:set var="etcPeriodSum_07_15" value="${etcPeriodSum_07_15 + vo2.etc07}"></c:set>
		                    <c:set var="etcPeriodSum_06_15" value="${etcPeriodSum_06_15 + vo2.etc06}"></c:set>
		                    <c:set var="etcPeriodSum_05_15" value="${etcPeriodSum_05_15 + vo2.etc05}"></c:set>
		                    <c:set var="etcPeriodSum_04_15" value="${etcPeriodSum_04_15 + vo2.etc04}"></c:set>
		                    <c:set var="etcPeriodSum_03_15" value="${etcPeriodSum_03_15 + vo2.etc03}"></c:set>
		                    <c:set var="etcPeriodSum_02_15" value="${etcPeriodSum_02_15 + vo2.etc02}"></c:set>
		                    <c:set var="etcPeriodSum_01_15" value="${etcPeriodSum_01_15 + vo2.etc01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="etcPtnrSum_12_15" value="${etcPtnrSum_12_15 + vo2.etc12}"></c:set>
		                    <c:set var="etcPtnrSum_11_15" value="${etcPtnrSum_11_15 + vo2.etc11}"></c:set>
		                    <c:set var="etcPtnrSum_10_15" value="${etcPtnrSum_10_15 + vo2.etc10}"></c:set>
		                    <c:set var="etcPtnrSum_09_15" value="${etcPtnrSum_09_15 + vo2.etc09}"></c:set>
		                    <c:set var="etcPtnrSum_08_15" value="${etcPtnrSum_08_15 + vo2.etc08}"></c:set>
		                    <c:set var="etcPtnrSum_07_15" value="${etcPtnrSum_07_15 + vo2.etc07}"></c:set>
		                    <c:set var="etcPtnrSum_06_15" value="${etcPtnrSum_06_15 + vo2.etc06}"></c:set>
		                    <c:set var="etcPtnrSum_05_15" value="${etcPtnrSum_05_15 + vo2.etc05}"></c:set>
		                    <c:set var="etcPtnrSum_04_15" value="${etcPtnrSum_04_15 + vo2.etc04}"></c:set>
		                    <c:set var="etcPtnrSum_03_15" value="${etcPtnrSum_03_15 + vo2.etc03}"></c:set>
		                    <c:set var="etcPtnrSum_02_15" value="${etcPtnrSum_02_15 + vo2.etc02}"></c:set>
		                    <c:set var="etcPtnrSum_01_15" value="${etcPtnrSum_01_15 + vo2.etc01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="etcTotalSum_12_15" value="${etcTotalSum_12_15 + vo2.etc12}"></c:set>
		                    <c:set var="etcTotalSum_11_15" value="${etcTotalSum_11_15 + vo2.etc11}"></c:set>
		                    <c:set var="etcTotalSum_10_15" value="${etcTotalSum_10_15 + vo2.etc10}"></c:set>
		                    <c:set var="etcTotalSum_09_15" value="${etcTotalSum_09_15 + vo2.etc09}"></c:set>
		                    <c:set var="etcTotalSum_08_15" value="${etcTotalSum_08_15 + vo2.etc08}"></c:set>
		                    <c:set var="etcTotalSum_07_15" value="${etcTotalSum_07_15 + vo2.etc07}"></c:set>
		                    <c:set var="etcTotalSum_06_15" value="${etcTotalSum_06_15 + vo2.etc06}"></c:set>
		                    <c:set var="etcTotalSum_05_15" value="${etcTotalSum_05_15 + vo2.etc05}"></c:set>
		                    <c:set var="etcTotalSum_04_15" value="${etcTotalSum_04_15 + vo2.etc04}"></c:set>
		                    <c:set var="etcTotalSum_03_15" value="${etcTotalSum_03_15 + vo2.etc03}"></c:set>
		                    <c:set var="etcTotalSum_02_15" value="${etcTotalSum_02_15 + vo2.etc02}"></c:set>
		                    <c:set var="etcTotalSum_01_15" value="${etcTotalSum_01_15 + vo2.etc01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="etcColSum_15" value="${etc12_15 + etc11_15 + etc10_15 + etc09_15 + etc08_15 + etc07_15 + etc06_15 + etc05_15 + etc04_15 + etc03_15 + etc02_15 + etc01_15}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo2.periodFlagNm == "소계"}'>
							<!-- etc12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1"><fmt:formatNumber value="${etc12_15}" pattern="#,##0.##"/></td>
		                    <!-- etc11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc11_15}" pattern="#,##0.##"/></td>
		                    <!-- etc10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc10_15}" pattern="#,##0.##"/></td>
		                    <!-- etc09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc09_15}" pattern="#,##0.##"/></td>
		                    <!-- etc08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc08_15}" pattern="#,##0.##"/></td>
		                    <!-- etc07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc07_15}" pattern="#,##0.##"/></td>
		                    <!-- etc06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc06_15}" pattern="#,##0.##"/></td>
		                    <!-- etc05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc05_15}" pattern="#,##0.##"/></td>
		                    <!-- etc04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc04_15}" pattern="#,##0.##"/></td>
		                    <!-- etc03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc03_15}" pattern="#,##0.##"/></td>
		                    <!-- etc02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc02_15}" pattern="#,##0.##"/></td>
		                    <!-- etc01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etc01_15}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-1"><fmt:formatNumber value="${etcColSum_15}" pattern="#,##0.##"/></td>
						</c:when>
						<c:otherwise>
							<!-- etc12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${etc12_15}" pattern="#,##0.##"/></td>
		                    <!-- etc11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc11_15}" pattern="#,##0.##"/></td>
		                    <!-- etc10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc10_15}" pattern="#,##0.##"/></td>
		                    <!-- etc09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc09_15}" pattern="#,##0.##"/></td>
		                    <!-- etc08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc08_15}" pattern="#,##0.##"/></td>
		                    <!-- etc07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc07_15}" pattern="#,##0.##"/></td>
		                    <!-- etc06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc06_15}" pattern="#,##0.##"/></td>
		                    <!-- etc05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc05_15}" pattern="#,##0.##"/></td>
		                    <!-- etc04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc04_15}" pattern="#,##0.##"/></td>
		                    <!-- etc03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc03_15}" pattern="#,##0.##"/></td>
		                    <!-- etc02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc02_15}" pattern="#,##0.##"/></td>
		                    <!-- etc01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etc01_15}" pattern="#,##0.##"/></td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcColSum_15}" pattern="#,##0.##"/></td>
						</c:otherwise>
					</c:choose>  
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo2.periodFlagCode == 3}">
                    	<c:set var="etcPeriodSum_12_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_11_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_10_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_09_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_08_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_07_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_06_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_05_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_04_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_03_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_02_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_01_15" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo2.ptnrRowCnt > 1}">
                	<c:if test="${vo2.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="etcPeriodSum_12_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_11_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_10_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_09_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_08_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_07_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_06_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_05_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_04_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_03_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_02_15" value="0"></c:set>
			            <c:set var="etcPeriodSum_01_15" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- etc12 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_12_15}" pattern="#,##0.##"/></td>
		                    <!-- etc11 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_11_15}" pattern="#,##0.##"/></td>
		                    <!-- etc10 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_10_15}" pattern="#,##0.##"/></td>
		                    <!-- etc09 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_09_15}" pattern="#,##0.##"/></td>
		                    <!-- etc08 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_08_15}" pattern="#,##0.##"/></td>
		                    <!-- etc07 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_07_15}" pattern="#,##0.##"/></td>
		                    <!-- etc06 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_06_15}" pattern="#,##0.##"/></td>
		                    <!-- etc05 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_05_15}" pattern="#,##0.##"/></td>
		                    <!-- etc04 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_04_15}" pattern="#,##0.##"/></td>
		                    <!-- etc03 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_03_15}" pattern="#,##0.##"/></td>
		                    <!-- etc02 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_02_15}" pattern="#,##0.##"/></td>
		                    <!-- etc01 -->
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrSum_01_15}" pattern="#,##0.##"/></td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="etcPtnrColSum_15" value="${etcPtnrSum_12_15 + etcPtnrSum_11_15 + etcPtnrSum_10_15 + etcPtnrSum_09_15 + etcPtnrSum_08_15 + etcPtnrSum_07_15 + etcPtnrSum_06_15 + etcPtnrSum_05_15 + etcPtnrSum_04_15 + etcPtnrSum_03_15 + etcPtnrSum_02_15 + etcPtnrSum_01_15}"></c:set>
		                    <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcPtnrColSum_15}" pattern="#,##0.##"/></td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 기타 소계</th>
                <!-- etc12 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_12_15}" pattern="#,##0.##"/></th>
                <!-- etc11 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_11_15}" pattern="#,##0.##"/></th>
                <!-- etc10 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_10_15}" pattern="#,##0.##"/></th>
                <!-- etc09 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_09_15}" pattern="#,##0.##"/></th>
                <!-- etc08 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_08_15}" pattern="#,##0.##"/></th>
                <!-- etc07 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_07_15}" pattern="#,##0.##"/></th>
                <!-- etc06 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_06_15}" pattern="#,##0.##"/></th>
                <!-- etc05 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_05_15}" pattern="#,##0.##"/></th>
                <!-- etc04 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_04_15}" pattern="#,##0.##"/></th>
                <!-- etc03 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_03_15}" pattern="#,##0.##"/></th>
                <!-- etc02 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_02_15}" pattern="#,##0.##"/></th>
                <!-- etc01 -->
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTotalSum_01_15}" pattern="#,##0.##"/></th>
                <!-- 가로열 합계 -->
                <c:set var="etcColTotalSum_15" value="${etcTotalSum_12_15 + etcTotalSum_11_15 + etcTotalSum_10_15 + etcTotalSum_09_15 + etcTotalSum_08_15 + etcTotalSum_07_15 + etcTotalSum_06_15 + etcTotalSum_05_15 + etcTotalSum_04_15 + etcTotalSum_03_15 + etcTotalSum_02_15 + etcTotalSum_01_15}"></c:set>
                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcColTotalSum_15}" pattern="#,##0.##"/></th>
            </tr>						
			</tbody>
		</table>		
		<!-- 1종 기타 끝 -->
    </div>    
    <!-- 총 합계 시작 -->
    <!-- 총 합계 변수 시작 -->
    <c:set var="etcTotalSum_12_all" value="${etcTotalSum_12_5 + etcTotalSum_12_10 + etcTotalSum_12_15}"></c:set>
    <c:set var="etcTotalSum_11_all" value="${etcTotalSum_11_5 + etcTotalSum_11_10 + etcTotalSum_11_15}"></c:set>
    <c:set var="etcTotalSum_10_all" value="${etcTotalSum_10_5 + etcTotalSum_10_10 + etcTotalSum_10_15}"></c:set>
    <c:set var="etcTotalSum_09_all" value="${etcTotalSum_09_5 + etcTotalSum_09_10 + etcTotalSum_09_15}"></c:set>
    <c:set var="etcTotalSum_08_all" value="${etcTotalSum_08_5 + etcTotalSum_08_10 + etcTotalSum_08_15}"></c:set>
    <c:set var="etcTotalSum_07_all" value="${etcTotalSum_07_5 + etcTotalSum_07_10 + etcTotalSum_07_15}"></c:set>
    <c:set var="etcTotalSum_06_all" value="${etcTotalSum_06_5 + etcTotalSum_06_10 + etcTotalSum_06_15}"></c:set>
    <c:set var="etcTotalSum_05_all" value="${etcTotalSum_05_5 + etcTotalSum_05_10 + etcTotalSum_05_15}"></c:set>
    <c:set var="etcTotalSum_04_all" value="${etcTotalSum_04_5 + etcTotalSum_04_10 + etcTotalSum_04_15}"></c:set>
    <c:set var="etcTotalSum_03_all" value="${etcTotalSum_03_5 + etcTotalSum_03_10 + etcTotalSum_03_15}"></c:set>
    <c:set var="etcTotalSum_02_all" value="${etcTotalSum_02_5 + etcTotalSum_02_10 + etcTotalSum_02_15}"></c:set>
    <c:set var="etcTotalSum_01_all" value="${etcTotalSum_01_5 + etcTotalSum_01_10 + etcTotalSum_01_15}"></c:set>        
    <c:set var="etcTotalSum_col_all" value="${etcTotalSum_12_all + etcTotalSum_11_all + etcTotalSum_10_all + etcTotalSum_09_all + etcTotalSum_08_all + etcTotalSum_07_all + etcTotalSum_06_all + etcTotalSum_05_all + etcTotalSum_04_all + etcTotalSum_03_all + etcTotalSum_02_all + etcTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체합계</th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTotalSum_01_all}" pattern="#,##0.##"/></th>
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTotalSum_col_all}" pattern="#,##0.##"/></th>
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>
