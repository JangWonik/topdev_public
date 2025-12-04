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
            <c:set var="end12_5" value="0"></c:set>
            <c:set var="end11_5" value="0"></c:set>
            <c:set var="end10_5" value="0"></c:set>
            <c:set var="end09_5" value="0"></c:set>
            <c:set var="end08_5" value="0"></c:set>
            <c:set var="end07_5" value="0"></c:set>
            <c:set var="end06_5" value="0"></c:set>
            <c:set var="end05_5" value="0"></c:set>
            <c:set var="end04_5" value="0"></c:set>
            <c:set var="end03_5" value="0"></c:set>
            <c:set var="end02_5" value="0"></c:set>
            <c:set var="end01_5" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="endPeriodSum_12_5" value="0"></c:set>
            <c:set var="endPeriodSum_11_5" value="0"></c:set>
            <c:set var="endPeriodSum_10_5" value="0"></c:set>
            <c:set var="endPeriodSum_09_5" value="0"></c:set>
            <c:set var="endPeriodSum_08_5" value="0"></c:set>
            <c:set var="endPeriodSum_07_5" value="0"></c:set>
            <c:set var="endPeriodSum_06_5" value="0"></c:set>
            <c:set var="endPeriodSum_05_5" value="0"></c:set>
            <c:set var="endPeriodSum_04_5" value="0"></c:set>
            <c:set var="endPeriodSum_03_5" value="0"></c:set>
            <c:set var="endPeriodSum_02_5" value="0"></c:set>
            <c:set var="endPeriodSum_01_5" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="endPtnrSum_12_5" value="0"></c:set>
            <c:set var="endPtnrSum_11_5" value="0"></c:set>
            <c:set var="endPtnrSum_10_5" value="0"></c:set>
            <c:set var="endPtnrSum_09_5" value="0"></c:set>
            <c:set var="endPtnrSum_08_5" value="0"></c:set>
            <c:set var="endPtnrSum_07_5" value="0"></c:set>
            <c:set var="endPtnrSum_06_5" value="0"></c:set>
            <c:set var="endPtnrSum_05_5" value="0"></c:set>
            <c:set var="endPtnrSum_04_5" value="0"></c:set>
            <c:set var="endPtnrSum_03_5" value="0"></c:set>
            <c:set var="endPtnrSum_02_5" value="0"></c:set>
            <c:set var="endPtnrSum_01_5" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="endColSum_5" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="endPtnrColSum_5" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="endTotalSum_12_5" value="0"></c:set>
            <c:set var="endTotalSum_11_5" value="0"></c:set>
            <c:set var="endTotalSum_10_5" value="0"></c:set>
            <c:set var="endTotalSum_09_5" value="0"></c:set>
            <c:set var="endTotalSum_08_5" value="0"></c:set>
            <c:set var="endTotalSum_07_5" value="0"></c:set>
            <c:set var="endTotalSum_06_5" value="0"></c:set>
            <c:set var="endTotalSum_05_5" value="0"></c:set>
            <c:set var="endTotalSum_04_5" value="0"></c:set>
            <c:set var="endTotalSum_03_5" value="0"></c:set>
            <c:set var="endTotalSum_02_5" value="0"></c:set>
            <c:set var="endTotalSum_01_5" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="endColTotalSum_5" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo" items="${ptnrStatEndList}" varStatus="status">            
                <tr>
                    <c:if test="${status.index == 0}">
                        <td style="width: 80px;" rowspan="${rowCnt}">1종 조사</td>
                    </c:if>
                    
                    <c:choose>
                    	<c:when test="${vo.ptnrRowCnt == 1}">			<!-- 보험사 세부분류가 없는 경우 -->
                    		<td onclick="goPtnrStatCenter(${vo.ptnrId});" colspan="3"  style="width: 300px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
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
						            <c:set var="endPtnrSum_12_5" value="0"></c:set>
						            <c:set var="endPtnrSum_11_5" value="0"></c:set>
						            <c:set var="endPtnrSum_10_5" value="0"></c:set>
						            <c:set var="endPtnrSum_09_5" value="0"></c:set>
						            <c:set var="endPtnrSum_08_5" value="0"></c:set>
						            <c:set var="endPtnrSum_07_5" value="0"></c:set>
						            <c:set var="endPtnrSum_06_5" value="0"></c:set>
						            <c:set var="endPtnrSum_05_5" value="0"></c:set>
						            <c:set var="endPtnrSum_04_5" value="0"></c:set>
						            <c:set var="endPtnrSum_03_5" value="0"></c:set>
						            <c:set var="endPtnrSum_02_5" value="0"></c:set>
						            <c:set var="endPtnrSum_01_5" value="0"></c:set>
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
                    		<c:set var="end12_5" value="${endPeriodSum_12_5}"></c:set>
		                    <c:set var="end11_5" value="${endPeriodSum_11_5}"></c:set>
		                    <c:set var="end10_5" value="${endPeriodSum_10_5}"></c:set>
		                    <c:set var="end09_5" value="${endPeriodSum_09_5}"></c:set>
		                    <c:set var="end08_5" value="${endPeriodSum_08_5}"></c:set>
		                    <c:set var="end07_5" value="${endPeriodSum_07_5}"></c:set>
		                    <c:set var="end06_5" value="${endPeriodSum_06_5}"></c:set>
		                    <c:set var="end05_5" value="${endPeriodSum_05_5}"></c:set>
		                    <c:set var="end04_5" value="${endPeriodSum_04_5}"></c:set>
		                    <c:set var="end03_5" value="${endPeriodSum_03_5}"></c:set>
		                    <c:set var="end02_5" value="${endPeriodSum_02_5}"></c:set>
		                    <c:set var="end01_5" value="${endPeriodSum_01_5}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="end12_5" value="${vo.end12}"></c:set>
		                    <c:set var="end11_5" value="${vo.end11}"></c:set>
		                    <c:set var="end10_5" value="${vo.end10}"></c:set>
		                    <c:set var="end09_5" value="${vo.end09}"></c:set>
		                    <c:set var="end08_5" value="${vo.end08}"></c:set>
		                    <c:set var="end07_5" value="${vo.end07}"></c:set>
		                    <c:set var="end06_5" value="${vo.end06}"></c:set>
		                    <c:set var="end05_5" value="${vo.end05}"></c:set>
		                    <c:set var="end04_5" value="${vo.end04}"></c:set>
		                    <c:set var="end03_5" value="${vo.end03}"></c:set>
		                    <c:set var="end02_5" value="${vo.end02}"></c:set>
		                    <c:set var="end01_5" value="${vo.end01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="endPeriodSum_12_5" value="${endPeriodSum_12_5 + vo.end12}"></c:set>
		                    <c:set var="endPeriodSum_11_5" value="${endPeriodSum_11_5 + vo.end11}"></c:set>
		                    <c:set var="endPeriodSum_10_5" value="${endPeriodSum_10_5 + vo.end10}"></c:set>
		                    <c:set var="endPeriodSum_09_5" value="${endPeriodSum_09_5 + vo.end09}"></c:set>
		                    <c:set var="endPeriodSum_08_5" value="${endPeriodSum_08_5 + vo.end08}"></c:set>
		                    <c:set var="endPeriodSum_07_5" value="${endPeriodSum_07_5 + vo.end07}"></c:set>
		                    <c:set var="endPeriodSum_06_5" value="${endPeriodSum_06_5 + vo.end06}"></c:set>
		                    <c:set var="endPeriodSum_05_5" value="${endPeriodSum_05_5 + vo.end05}"></c:set>
		                    <c:set var="endPeriodSum_04_5" value="${endPeriodSum_04_5 + vo.end04}"></c:set>
		                    <c:set var="endPeriodSum_03_5" value="${endPeriodSum_03_5 + vo.end03}"></c:set>
		                    <c:set var="endPeriodSum_02_5" value="${endPeriodSum_02_5 + vo.end02}"></c:set>
		                    <c:set var="endPeriodSum_01_5" value="${endPeriodSum_01_5 + vo.end01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="endPtnrSum_12_5" value="${endPtnrSum_12_5 + vo.end12}"></c:set>
		                    <c:set var="endPtnrSum_11_5" value="${endPtnrSum_11_5 + vo.end11}"></c:set>
		                    <c:set var="endPtnrSum_10_5" value="${endPtnrSum_10_5 + vo.end10}"></c:set>
		                    <c:set var="endPtnrSum_09_5" value="${endPtnrSum_09_5 + vo.end09}"></c:set>
		                    <c:set var="endPtnrSum_08_5" value="${endPtnrSum_08_5 + vo.end08}"></c:set>
		                    <c:set var="endPtnrSum_07_5" value="${endPtnrSum_07_5 + vo.end07}"></c:set>
		                    <c:set var="endPtnrSum_06_5" value="${endPtnrSum_06_5 + vo.end06}"></c:set>
		                    <c:set var="endPtnrSum_05_5" value="${endPtnrSum_05_5 + vo.end05}"></c:set>
		                    <c:set var="endPtnrSum_04_5" value="${endPtnrSum_04_5 + vo.end04}"></c:set>
		                    <c:set var="endPtnrSum_03_5" value="${endPtnrSum_03_5 + vo.end03}"></c:set>
		                    <c:set var="endPtnrSum_02_5" value="${endPtnrSum_02_5 + vo.end02}"></c:set>
		                    <c:set var="endPtnrSum_01_5" value="${endPtnrSum_01_5 + vo.end01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="endTotalSum_12_5" value="${endTotalSum_12_5 + vo.end12}"></c:set>
		                    <c:set var="endTotalSum_11_5" value="${endTotalSum_11_5 + vo.end11}"></c:set>
		                    <c:set var="endTotalSum_10_5" value="${endTotalSum_10_5 + vo.end10}"></c:set>
		                    <c:set var="endTotalSum_09_5" value="${endTotalSum_09_5 + vo.end09}"></c:set>
		                    <c:set var="endTotalSum_08_5" value="${endTotalSum_08_5 + vo.end08}"></c:set>
		                    <c:set var="endTotalSum_07_5" value="${endTotalSum_07_5 + vo.end07}"></c:set>
		                    <c:set var="endTotalSum_06_5" value="${endTotalSum_06_5 + vo.end06}"></c:set>
		                    <c:set var="endTotalSum_05_5" value="${endTotalSum_05_5 + vo.end05}"></c:set>
		                    <c:set var="endTotalSum_04_5" value="${endTotalSum_04_5 + vo.end04}"></c:set>
		                    <c:set var="endTotalSum_03_5" value="${endTotalSum_03_5 + vo.end03}"></c:set>
		                    <c:set var="endTotalSum_02_5" value="${endTotalSum_02_5 + vo.end02}"></c:set>
		                    <c:set var="endTotalSum_01_5" value="${endTotalSum_01_5 + vo.end01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="endColSum_5" value="${end12_5 + end11_5 + end10_5 + end09_5 + end08_5 + end07_5 + end06_5 + end05_5 + end04_5 + end03_5 + end02_5 + end01_5}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo.periodFlagNm == "소계"}'>
							<!-- end12 -->
		                    <td style="width: 80px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1">${end12_5}</td>
		                    <!-- end11 -->
		                    <td style="width: 80px;" class="sum-level-1">${end11_5}</td>
		                    <!-- end10 -->
		                    <td style="width: 80px;" class="sum-level-1">${end10_5}</td>
		                    <!-- end09 -->
		                    <td style="width: 80px;" class="sum-level-1">${end09_5}</td>
		                    <!-- end08 -->
		                    <td style="width: 80px;" class="sum-level-1">${end08_5}</td>
		                    <!-- end07 -->
		                    <td style="width: 80px;" class="sum-level-1">${end07_5}</td>
		                    <!-- end06 -->
		                    <td style="width: 80px;" class="sum-level-1">${end06_5}</td>
		                    <!-- end05 -->
		                    <td style="width: 80px;" class="sum-level-1">${end05_5}</td>
		                    <!-- end04 -->
		                    <td style="width: 80px;" class="sum-level-1">${end04_5}</td>
		                    <!-- end03 -->
		                    <td style="width: 80px;" class="sum-level-1">${end03_5}</td>
		                    <!-- end02 -->
		                    <td style="width: 80px;" class="sum-level-1">${end02_5}</td>
		                    <!-- end01 -->
		                    <td style="width: 80px;" class="sum-level-1">${end01_5}</td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 80px;" class="sum-level-1">${endColSum_5}</td>
						</c:when>
						<c:otherwise>
							<!-- end12 -->
		                    <td style="width: 80px;border-left:0.2em solid #b9b9b9 !important;">${end12_5}</td>
		                    <!-- end11 -->
		                    <td style="width: 80px;">${end11_5}</td>
		                    <!-- end10 -->
		                    <td style="width: 80px;">${end10_5}</td>
		                    <!-- end09 -->
		                    <td style="width: 80px;">${end09_5}</td>
		                    <!-- end08 -->
		                    <td style="width: 80px;">${end08_5}</td>
		                    <!-- end07 -->
		                    <td style="width: 80px;">${end07_5}</td>
		                    <!-- end06 -->
		                    <td style="width: 80px;">${end06_5}</td>
		                    <!-- end05 -->
		                    <td style="width: 80px;">${end05_5}</td>
		                    <!-- end04 -->
		                    <td style="width: 80px;">${end04_5}</td>
		                    <!-- end03 -->
		                    <td style="width: 80px;">${end03_5}</td>
		                    <!-- end02 -->
		                    <td style="width: 80px;">${end02_5}</td>
		                    <!-- end01 -->
		                    <td style="width: 80px;">${end01_5}</td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 80px;">${endColSum_5}</td>
						</c:otherwise>
					</c:choose>
                                        
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo.periodFlagCode == 3}">
                    	<c:set var="endPeriodSum_12_5" value="0"></c:set>
			            <c:set var="endPeriodSum_11_5" value="0"></c:set>
			            <c:set var="endPeriodSum_10_5" value="0"></c:set>
			            <c:set var="endPeriodSum_09_5" value="0"></c:set>
			            <c:set var="endPeriodSum_08_5" value="0"></c:set>
			            <c:set var="endPeriodSum_07_5" value="0"></c:set>
			            <c:set var="endPeriodSum_06_5" value="0"></c:set>
			            <c:set var="endPeriodSum_05_5" value="0"></c:set>
			            <c:set var="endPeriodSum_04_5" value="0"></c:set>
			            <c:set var="endPeriodSum_03_5" value="0"></c:set>
			            <c:set var="endPeriodSum_02_5" value="0"></c:set>
			            <c:set var="endPeriodSum_01_5" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo.ptnrRowCnt > 1}">
                	<c:if test="${vo.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="endPeriodSum_12_5" value="0"></c:set>
			            <c:set var="endPeriodSum_11_5" value="0"></c:set>
			            <c:set var="endPeriodSum_10_5" value="0"></c:set>
			            <c:set var="endPeriodSum_09_5" value="0"></c:set>
			            <c:set var="endPeriodSum_08_5" value="0"></c:set>
			            <c:set var="endPeriodSum_07_5" value="0"></c:set>
			            <c:set var="endPeriodSum_06_5" value="0"></c:set>
			            <c:set var="endPeriodSum_05_5" value="0"></c:set>
			            <c:set var="endPeriodSum_04_5" value="0"></c:set>
			            <c:set var="endPeriodSum_03_5" value="0"></c:set>
			            <c:set var="endPeriodSum_02_5" value="0"></c:set>
			            <c:set var="endPeriodSum_01_5" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- end12 -->
		                    <td style="border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2">${endPtnrSum_12_5}</td>
		                    <!-- end11 -->
		                    <td class="sum-level-2">${endPtnrSum_11_5}</td>
		                    <!-- end10 -->
		                    <td class="sum-level-2">${endPtnrSum_10_5}</td>
		                    <!-- end09 -->
		                    <td class="sum-level-2">${endPtnrSum_09_5}</td>
		                    <!-- end08 -->
		                    <td class="sum-level-2">${endPtnrSum_08_5}</td>
		                    <!-- end07 -->
		                    <td class="sum-level-2">${endPtnrSum_07_5}</td>
		                    <!-- end06 -->
		                    <td class="sum-level-2">${endPtnrSum_06_5}</td>
		                    <!-- end05 -->
		                    <td class="sum-level-2">${endPtnrSum_05_5}</td>
		                    <!-- end04 -->
		                    <td class="sum-level-2">${endPtnrSum_04_5}</td>
		                    <!-- end03 -->
		                    <td class="sum-level-2">${endPtnrSum_03_5}</td>
		                    <!-- end02 -->
		                    <td class="sum-level-2">${endPtnrSum_02_5}</td>
		                    <!-- end01 -->
		                    <td class="sum-level-2">${endPtnrSum_01_5}</td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="endPtnrColSum_5" value="${endPtnrSum_12_5 + endPtnrSum_11_5 + endPtnrSum_10_5 + endPtnrSum_09_5 + endPtnrSum_08_5 + endPtnrSum_07_5 + endPtnrSum_06_5 + endPtnrSum_05_5 + endPtnrSum_04_5 + endPtnrSum_03_5 + endPtnrSum_02_5 + endPtnrSum_01_5}"></c:set>
		                    <td class="sum-level-2">${endPtnrColSum_5}</td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 조사 소계</th>
                <!-- end12 -->
                <th>${endTotalSum_12_5}</th>
                <!-- end11 -->
                <th>${endTotalSum_11_5}</th>
                <!-- end10 -->
                <th>${endTotalSum_10_5}</th>
                <!-- end09 -->
                <th>${endTotalSum_09_5}</th>
                <!-- end08 -->
                <th>${endTotalSum_08_5}</th>
                <!-- end07 -->
                <th>${endTotalSum_07_5}</th>
                <!-- end06 -->
                <th>${endTotalSum_06_5}</th>
                <!-- end05 -->
                <th>${endTotalSum_05_5}</th>
                <!-- end04 -->
                <th>${endTotalSum_04_5}</th>
                <!-- end03 -->
                <th>${endTotalSum_03_5}</th>
                <!-- end02 -->
                <th>${endTotalSum_02_5}</th>
                <!-- end01 -->
                <th>${endTotalSum_01_5}</th>
                <!-- 가로열 합계 -->
                <c:set var="endColTotalSum_5" value="${endTotalSum_12_5 + endTotalSum_11_5 + endTotalSum_10_5 + endTotalSum_09_5 + endTotalSum_08_5 + endTotalSum_07_5 + endTotalSum_06_5 + endTotalSum_05_5 + endTotalSum_04_5 + endTotalSum_03_5 + endTotalSum_02_5 + endTotalSum_01_5}"></c:set>
                <th>${endColTotalSum_5}</th>
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
            <c:set var="end12_10" value="0"></c:set>
            <c:set var="end11_10" value="0"></c:set>
            <c:set var="end10_10" value="0"></c:set>
            <c:set var="end09_10" value="0"></c:set>
            <c:set var="end08_10" value="0"></c:set>
            <c:set var="end07_10" value="0"></c:set>
            <c:set var="end06_10" value="0"></c:set>
            <c:set var="end05_10" value="0"></c:set>
            <c:set var="end04_10" value="0"></c:set>
            <c:set var="end03_10" value="0"></c:set>
            <c:set var="end02_10" value="0"></c:set>
            <c:set var="end01_10" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="endPeriodSum_12_10" value="0"></c:set>
            <c:set var="endPeriodSum_11_10" value="0"></c:set>
            <c:set var="endPeriodSum_10_10" value="0"></c:set>
            <c:set var="endPeriodSum_09_10" value="0"></c:set>
            <c:set var="endPeriodSum_08_10" value="0"></c:set>
            <c:set var="endPeriodSum_07_10" value="0"></c:set>
            <c:set var="endPeriodSum_06_10" value="0"></c:set>
            <c:set var="endPeriodSum_05_10" value="0"></c:set>
            <c:set var="endPeriodSum_04_10" value="0"></c:set>
            <c:set var="endPeriodSum_03_10" value="0"></c:set>
            <c:set var="endPeriodSum_02_10" value="0"></c:set>
            <c:set var="endPeriodSum_01_10" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="endPtnrSum_12_10" value="0"></c:set>
            <c:set var="endPtnrSum_11_10" value="0"></c:set>
            <c:set var="endPtnrSum_10_10" value="0"></c:set>
            <c:set var="endPtnrSum_09_10" value="0"></c:set>
            <c:set var="endPtnrSum_08_10" value="0"></c:set>
            <c:set var="endPtnrSum_07_10" value="0"></c:set>
            <c:set var="endPtnrSum_06_10" value="0"></c:set>
            <c:set var="endPtnrSum_05_10" value="0"></c:set>
            <c:set var="endPtnrSum_04_10" value="0"></c:set>
            <c:set var="endPtnrSum_03_10" value="0"></c:set>
            <c:set var="endPtnrSum_02_10" value="0"></c:set>
            <c:set var="endPtnrSum_01_10" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="endColSum_10" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="endPtnrColSum_10" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="endTotalSum_12_10" value="0"></c:set>
            <c:set var="endTotalSum_11_10" value="0"></c:set>
            <c:set var="endTotalSum_10_10" value="0"></c:set>
            <c:set var="endTotalSum_09_10" value="0"></c:set>
            <c:set var="endTotalSum_08_10" value="0"></c:set>
            <c:set var="endTotalSum_07_10" value="0"></c:set>
            <c:set var="endTotalSum_06_10" value="0"></c:set>
            <c:set var="endTotalSum_05_10" value="0"></c:set>
            <c:set var="endTotalSum_04_10" value="0"></c:set>
            <c:set var="endTotalSum_03_10" value="0"></c:set>
            <c:set var="endTotalSum_02_10" value="0"></c:set>
            <c:set var="endTotalSum_01_10" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="endColTotalSum_10" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo1" items="${ptnrStatEndList_10}" varStatus="status">            
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
		                    		<td onclick="goPtnrStatCenter(${vo1.ptnrId});" rowspan="${vo1.ptnrRowCnt+1}" style="width: 100px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.ptnrNick}</td>                    		
				                   	<c:set var="beforePtnrId" value="${vo1.ptnrId}"></c:set>
				                   	<c:set var="ptnrSubRow" value="1"></c:set>
				                   	
				                   	<!-- 보험사 변경 시 보험사 누적합계 초기화 -->
						            <c:set var="endPtnrSum_12_10" value="0"></c:set>
						            <c:set var="endPtnrSum_11_10" value="0"></c:set>
						            <c:set var="endPtnrSum_10_10" value="0"></c:set>
						            <c:set var="endPtnrSum_09_10" value="0"></c:set>
						            <c:set var="endPtnrSum_08_10" value="0"></c:set>
						            <c:set var="endPtnrSum_07_10" value="0"></c:set>
						            <c:set var="endPtnrSum_06_10" value="0"></c:set>
						            <c:set var="endPtnrSum_05_10" value="0"></c:set>
						            <c:set var="endPtnrSum_04_10" value="0"></c:set>
						            <c:set var="endPtnrSum_03_10" value="0"></c:set>
						            <c:set var="endPtnrSum_02_10" value="0"></c:set>
						            <c:set var="endPtnrSum_01_10" value="0"></c:set>
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
                    		<c:set var="end12_10" value="${endPeriodSum_12_10}"></c:set>
		                    <c:set var="end11_10" value="${endPeriodSum_11_10}"></c:set>
		                    <c:set var="end10_10" value="${endPeriodSum_10_10}"></c:set>
		                    <c:set var="end09_10" value="${endPeriodSum_09_10}"></c:set>
		                    <c:set var="end08_10" value="${endPeriodSum_08_10}"></c:set>
		                    <c:set var="end07_10" value="${endPeriodSum_07_10}"></c:set>
		                    <c:set var="end06_10" value="${endPeriodSum_06_10}"></c:set>
		                    <c:set var="end05_10" value="${endPeriodSum_05_10}"></c:set>
		                    <c:set var="end04_10" value="${endPeriodSum_04_10}"></c:set>
		                    <c:set var="end03_10" value="${endPeriodSum_03_10}"></c:set>
		                    <c:set var="end02_10" value="${endPeriodSum_02_10}"></c:set>
		                    <c:set var="end01_10" value="${endPeriodSum_01_10}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="end12_10" value="${vo1.end12}"></c:set>
		                    <c:set var="end11_10" value="${vo1.end11}"></c:set>
		                    <c:set var="end10_10" value="${vo1.end10}"></c:set>
		                    <c:set var="end09_10" value="${vo1.end09}"></c:set>
		                    <c:set var="end08_10" value="${vo1.end08}"></c:set>
		                    <c:set var="end07_10" value="${vo1.end07}"></c:set>
		                    <c:set var="end06_10" value="${vo1.end06}"></c:set>
		                    <c:set var="end05_10" value="${vo1.end05}"></c:set>
		                    <c:set var="end04_10" value="${vo1.end04}"></c:set>
		                    <c:set var="end03_10" value="${vo1.end03}"></c:set>
		                    <c:set var="end02_10" value="${vo1.end02}"></c:set>
		                    <c:set var="end01_10" value="${vo1.end01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="endPeriodSum_12_10" value="${endPeriodSum_12_10 + vo1.end12}"></c:set>
		                    <c:set var="endPeriodSum_11_10" value="${endPeriodSum_11_10 + vo1.end11}"></c:set>
		                    <c:set var="endPeriodSum_10_10" value="${endPeriodSum_10_10 + vo1.end10}"></c:set>
		                    <c:set var="endPeriodSum_09_10" value="${endPeriodSum_09_10 + vo1.end09}"></c:set>
		                    <c:set var="endPeriodSum_08_10" value="${endPeriodSum_08_10 + vo1.end08}"></c:set>
		                    <c:set var="endPeriodSum_07_10" value="${endPeriodSum_07_10 + vo1.end07}"></c:set>
		                    <c:set var="endPeriodSum_06_10" value="${endPeriodSum_06_10 + vo1.end06}"></c:set>
		                    <c:set var="endPeriodSum_05_10" value="${endPeriodSum_05_10 + vo1.end05}"></c:set>
		                    <c:set var="endPeriodSum_04_10" value="${endPeriodSum_04_10 + vo1.end04}"></c:set>
		                    <c:set var="endPeriodSum_03_10" value="${endPeriodSum_03_10 + vo1.end03}"></c:set>
		                    <c:set var="endPeriodSum_02_10" value="${endPeriodSum_02_10 + vo1.end02}"></c:set>
		                    <c:set var="endPeriodSum_01_10" value="${endPeriodSum_01_10 + vo1.end01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="endPtnrSum_12_10" value="${endPtnrSum_12_10 + vo1.end12}"></c:set>
		                    <c:set var="endPtnrSum_11_10" value="${endPtnrSum_11_10 + vo1.end11}"></c:set>
		                    <c:set var="endPtnrSum_10_10" value="${endPtnrSum_10_10 + vo1.end10}"></c:set>
		                    <c:set var="endPtnrSum_09_10" value="${endPtnrSum_09_10 + vo1.end09}"></c:set>
		                    <c:set var="endPtnrSum_08_10" value="${endPtnrSum_08_10 + vo1.end08}"></c:set>
		                    <c:set var="endPtnrSum_07_10" value="${endPtnrSum_07_10 + vo1.end07}"></c:set>
		                    <c:set var="endPtnrSum_06_10" value="${endPtnrSum_06_10 + vo1.end06}"></c:set>
		                    <c:set var="endPtnrSum_05_10" value="${endPtnrSum_05_10 + vo1.end05}"></c:set>
		                    <c:set var="endPtnrSum_04_10" value="${endPtnrSum_04_10 + vo1.end04}"></c:set>
		                    <c:set var="endPtnrSum_03_10" value="${endPtnrSum_03_10 + vo1.end03}"></c:set>
		                    <c:set var="endPtnrSum_02_10" value="${endPtnrSum_02_10 + vo1.end02}"></c:set>
		                    <c:set var="endPtnrSum_01_10" value="${endPtnrSum_01_10 + vo1.end01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="endTotalSum_12_10" value="${endTotalSum_12_10 + vo1.end12}"></c:set>
		                    <c:set var="endTotalSum_11_10" value="${endTotalSum_11_10 + vo1.end11}"></c:set>
		                    <c:set var="endTotalSum_10_10" value="${endTotalSum_10_10 + vo1.end10}"></c:set>
		                    <c:set var="endTotalSum_09_10" value="${endTotalSum_09_10 + vo1.end09}"></c:set>
		                    <c:set var="endTotalSum_08_10" value="${endTotalSum_08_10 + vo1.end08}"></c:set>
		                    <c:set var="endTotalSum_07_10" value="${endTotalSum_07_10 + vo1.end07}"></c:set>
		                    <c:set var="endTotalSum_06_10" value="${endTotalSum_06_10 + vo1.end06}"></c:set>
		                    <c:set var="endTotalSum_05_10" value="${endTotalSum_05_10 + vo1.end05}"></c:set>
		                    <c:set var="endTotalSum_04_10" value="${endTotalSum_04_10 + vo1.end04}"></c:set>
		                    <c:set var="endTotalSum_03_10" value="${endTotalSum_03_10 + vo1.end03}"></c:set>
		                    <c:set var="endTotalSum_02_10" value="${endTotalSum_02_10 + vo1.end02}"></c:set>
		                    <c:set var="endTotalSum_01_10" value="${endTotalSum_01_10 + vo1.end01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="endColSum_10" value="${end12_10 + end11_10 + end10_10 + end09_10 + end08_10 + end07_10 + end06_10 + end05_10 + end04_10 + end03_10 + end02_10 + end01_10}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo1.periodFlagNm == "소계"}'>
							<!-- end12 -->
		                    <td style="width: 80px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1">${end12_10}</td>
		                    <!-- end11 -->
		                    <td style="width: 80px;" class="sum-level-1">${end11_10}</td>
		                    <!-- end10 -->
		                    <td style="width: 80px;" class="sum-level-1">${end10_10}</td>
		                    <!-- end09 -->
		                    <td style="width: 80px;" class="sum-level-1">${end09_10}</td>
		                    <!-- end08 -->
		                    <td style="width: 80px;" class="sum-level-1">${end08_10}</td>
		                    <!-- end07 -->
		                    <td style="width: 80px;" class="sum-level-1">${end07_10}</td>
		                    <!-- end06 -->
		                    <td style="width: 80px;" class="sum-level-1">${end06_10}</td>
		                    <!-- end05 -->
		                    <td style="width: 80px;" class="sum-level-1">${end05_10}</td>
		                    <!-- end04 -->
		                    <td style="width: 80px;" class="sum-level-1">${end04_10}</td>
		                    <!-- end03 -->
		                    <td style="width: 80px;" class="sum-level-1">${end03_10}</td>
		                    <!-- end02 -->
		                    <td style="width: 80px;" class="sum-level-1">${end02_10}</td>
		                    <!-- end01 -->
		                    <td style="width: 80px;" class="sum-level-1">${end01_10}</td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 80px;" class="sum-level-1">${endColSum_10}</td>
						</c:when>
						<c:otherwise>
							<!-- end12 -->
		                    <td style="width: 80px;border-left:0.2em solid #b9b9b9 !important;">${end12_10}</td>
		                    <!-- end11 -->
		                    <td style="width: 80px;">${end11_10}</td>
		                    <!-- end10 -->
		                    <td style="width: 80px;">${end10_10}</td>
		                    <!-- end09 -->
		                    <td style="width: 80px;">${end09_10}</td>
		                    <!-- end08 -->
		                    <td style="width: 80px;">${end08_10}</td>
		                    <!-- end07 -->
		                    <td style="width: 80px;">${end07_10}</td>
		                    <!-- end06 -->
		                    <td style="width: 80px;">${end06_10}</td>
		                    <!-- end05 -->
		                    <td style="width: 80px;">${end05_10}</td>
		                    <!-- end04 -->
		                    <td style="width: 80px;">${end04_10}</td>
		                    <!-- end03 -->
		                    <td style="width: 80px;">${end03_10}</td>
		                    <!-- end02 -->
		                    <td style="width: 80px;">${end02_10}</td>
		                    <!-- end01 -->
		                    <td style="width: 80px;">${end01_10}</td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 80px;">${endColSum_10}</td>
						</c:otherwise>
					</c:choose>                                        
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo1.periodFlagCode == 3}">
                    	<c:set var="endPeriodSum_12_10" value="0"></c:set>
			            <c:set var="endPeriodSum_11_10" value="0"></c:set>
			            <c:set var="endPeriodSum_10_10" value="0"></c:set>
			            <c:set var="endPeriodSum_09_10" value="0"></c:set>
			            <c:set var="endPeriodSum_08_10" value="0"></c:set>
			            <c:set var="endPeriodSum_07_10" value="0"></c:set>
			            <c:set var="endPeriodSum_06_10" value="0"></c:set>
			            <c:set var="endPeriodSum_05_10" value="0"></c:set>
			            <c:set var="endPeriodSum_04_10" value="0"></c:set>
			            <c:set var="endPeriodSum_03_10" value="0"></c:set>
			            <c:set var="endPeriodSum_02_10" value="0"></c:set>
			            <c:set var="endPeriodSum_01_10" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo1.ptnrRowCnt > 1}">
                	<c:if test="${vo1.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="endPeriodSum_12_10" value="0"></c:set>
			            <c:set var="endPeriodSum_11_10" value="0"></c:set>
			            <c:set var="endPeriodSum_10_10" value="0"></c:set>
			            <c:set var="endPeriodSum_09_10" value="0"></c:set>
			            <c:set var="endPeriodSum_08_10" value="0"></c:set>
			            <c:set var="endPeriodSum_07_10" value="0"></c:set>
			            <c:set var="endPeriodSum_06_10" value="0"></c:set>
			            <c:set var="endPeriodSum_05_10" value="0"></c:set>
			            <c:set var="endPeriodSum_04_10" value="0"></c:set>
			            <c:set var="endPeriodSum_03_10" value="0"></c:set>
			            <c:set var="endPeriodSum_02_10" value="0"></c:set>
			            <c:set var="endPeriodSum_01_10" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- end12 -->
		                    <td style="border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2">${endPtnrSum_12_10}</td>
		                    <!-- end11 -->
		                    <td class="sum-level-2">${endPtnrSum_11_10}</td>
		                    <!-- end10 -->
		                    <td class="sum-level-2">${endPtnrSum_10_10}</td>
		                    <!-- end09 -->
		                    <td class="sum-level-2">${endPtnrSum_09_10}</td>
		                    <!-- end08 -->
		                    <td class="sum-level-2">${endPtnrSum_08_10}</td>
		                    <!-- end07 -->
		                    <td class="sum-level-2">${endPtnrSum_07_10}</td>
		                    <!-- end06 -->
		                    <td class="sum-level-2">${endPtnrSum_06_10}</td>
		                    <!-- end05 -->
		                    <td class="sum-level-2">${endPtnrSum_05_10}</td>
		                    <!-- end04 -->
		                    <td class="sum-level-2">${endPtnrSum_04_10}</td>
		                    <!-- end03 -->
		                    <td class="sum-level-2">${endPtnrSum_03_10}</td>
		                    <!-- end02 -->
		                    <td class="sum-level-2">${endPtnrSum_02_10}</td>
		                    <!-- end01 -->
		                    <td class="sum-level-2">${endPtnrSum_01_10}</td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="endPtnrColSum_10" value="${endPtnrSum_12_10 + endPtnrSum_11_10 + endPtnrSum_10_10 + endPtnrSum_09_10 + endPtnrSum_08_10 + endPtnrSum_07_10 + endPtnrSum_06_10 + endPtnrSum_05_10 + endPtnrSum_04_10 + endPtnrSum_03_10 + endPtnrSum_02_10 + endPtnrSum_01_10}"></c:set>
		                    <td class="sum-level-2">${endPtnrColSum_10}</td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 심사 소계</th>
                <!-- end12 -->
                <th>${endTotalSum_12_10}</th>
                <!-- end11 -->
                <th>${endTotalSum_11_10}</th>
                <!-- end10 -->
                <th>${endTotalSum_10_10}</th>
                <!-- end09 -->
                <th>${endTotalSum_09_10}</th>
                <!-- end08 -->
                <th>${endTotalSum_08_10}</th>
                <!-- end07 -->
                <th>${endTotalSum_07_10}</th>
                <!-- end06 -->
                <th>${endTotalSum_06_10}</th>
                <!-- end05 -->
                <th>${endTotalSum_05_10}</th>
                <!-- end04 -->
                <th>${endTotalSum_04_10}</th>
                <!-- end03 -->
                <th>${endTotalSum_03_10}</th>
                <!-- end02 -->
                <th>${endTotalSum_02_10}</th>
                <!-- end01 -->
                <th>${endTotalSum_01_10}</th>
                <!-- 가로열 합계 -->
                <c:set var="endColTotalSum_10" value="${endTotalSum_12_10 + endTotalSum_11_10 + endTotalSum_10_10 + endTotalSum_09_10 + endTotalSum_08_10 + endTotalSum_07_10 + endTotalSum_06_10 + endTotalSum_05_10 + endTotalSum_04_10 + endTotalSum_03_10 + endTotalSum_02_10 + endTotalSum_01_10}"></c:set>
                <th>${endColTotalSum_10}</th>
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
            <c:set var="end12_15" value="0"></c:set>
            <c:set var="end11_15" value="0"></c:set>
            <c:set var="end10_15" value="0"></c:set>
            <c:set var="end09_15" value="0"></c:set>
            <c:set var="end08_15" value="0"></c:set>
            <c:set var="end07_15" value="0"></c:set>
            <c:set var="end06_15" value="0"></c:set>
            <c:set var="end05_15" value="0"></c:set>
            <c:set var="end04_15" value="0"></c:set>
            <c:set var="end03_15" value="0"></c:set>
            <c:set var="end02_15" value="0"></c:set>
            <c:set var="end01_15" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="endPeriodSum_12_15" value="0"></c:set>
            <c:set var="endPeriodSum_11_15" value="0"></c:set>
            <c:set var="endPeriodSum_10_15" value="0"></c:set>
            <c:set var="endPeriodSum_09_15" value="0"></c:set>
            <c:set var="endPeriodSum_08_15" value="0"></c:set>
            <c:set var="endPeriodSum_07_15" value="0"></c:set>
            <c:set var="endPeriodSum_06_15" value="0"></c:set>
            <c:set var="endPeriodSum_05_15" value="0"></c:set>
            <c:set var="endPeriodSum_04_15" value="0"></c:set>
            <c:set var="endPeriodSum_03_15" value="0"></c:set>
            <c:set var="endPeriodSum_02_15" value="0"></c:set>
            <c:set var="endPeriodSum_01_15" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="endPtnrSum_12_15" value="0"></c:set>
            <c:set var="endPtnrSum_11_15" value="0"></c:set>
            <c:set var="endPtnrSum_10_15" value="0"></c:set>
            <c:set var="endPtnrSum_09_15" value="0"></c:set>
            <c:set var="endPtnrSum_08_15" value="0"></c:set>
            <c:set var="endPtnrSum_07_15" value="0"></c:set>
            <c:set var="endPtnrSum_06_15" value="0"></c:set>
            <c:set var="endPtnrSum_05_15" value="0"></c:set>
            <c:set var="endPtnrSum_04_15" value="0"></c:set>
            <c:set var="endPtnrSum_03_15" value="0"></c:set>
            <c:set var="endPtnrSum_02_15" value="0"></c:set>
            <c:set var="endPtnrSum_01_15" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="endColSum_15" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="endPtnrColSum_15" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="endTotalSum_12_15" value="0"></c:set>
            <c:set var="endTotalSum_11_15" value="0"></c:set>
            <c:set var="endTotalSum_10_15" value="0"></c:set>
            <c:set var="endTotalSum_09_15" value="0"></c:set>
            <c:set var="endTotalSum_08_15" value="0"></c:set>
            <c:set var="endTotalSum_07_15" value="0"></c:set>
            <c:set var="endTotalSum_06_15" value="0"></c:set>
            <c:set var="endTotalSum_05_15" value="0"></c:set>
            <c:set var="endTotalSum_04_15" value="0"></c:set>
            <c:set var="endTotalSum_03_15" value="0"></c:set>
            <c:set var="endTotalSum_02_15" value="0"></c:set>
            <c:set var="endTotalSum_01_15" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="endColTotalSum_15" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo2" items="${ptnrStatEndList_15}" varStatus="status">            
                <tr>  
                    <c:if test="${status.index == 0}">
                        <td style="width: 80px;" rowspan="${rowCnt}">1종 기타</td>
                    </c:if>
                    
                    <c:choose>
                    	<c:when test="${vo2.ptnrRowCnt == 1}">			<!-- 보험사 세부분류가 없는 경우 -->
                    		<td onclick="goPtnrStatCenter(${vo2.ptnrId});" colspan="3"  style="width: 300px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
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
						            <c:set var="endPtnrSum_12_15" value="0"></c:set>
						            <c:set var="endPtnrSum_11_15" value="0"></c:set>
						            <c:set var="endPtnrSum_10_15" value="0"></c:set>
						            <c:set var="endPtnrSum_09_15" value="0"></c:set>
						            <c:set var="endPtnrSum_08_15" value="0"></c:set>
						            <c:set var="endPtnrSum_07_15" value="0"></c:set>
						            <c:set var="endPtnrSum_06_15" value="0"></c:set>
						            <c:set var="endPtnrSum_05_15" value="0"></c:set>
						            <c:set var="endPtnrSum_04_15" value="0"></c:set>
						            <c:set var="endPtnrSum_03_15" value="0"></c:set>
						            <c:set var="endPtnrSum_02_15" value="0"></c:set>
						            <c:set var="endPtnrSum_01_15" value="0"></c:set>
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
                    		<c:set var="end12_15" value="${endPeriodSum_12_15}"></c:set>
		                    <c:set var="end11_15" value="${endPeriodSum_11_15}"></c:set>
		                    <c:set var="end10_15" value="${endPeriodSum_10_15}"></c:set>
		                    <c:set var="end09_15" value="${endPeriodSum_09_15}"></c:set>
		                    <c:set var="end08_15" value="${endPeriodSum_08_15}"></c:set>
		                    <c:set var="end07_15" value="${endPeriodSum_07_15}"></c:set>
		                    <c:set var="end06_15" value="${endPeriodSum_06_15}"></c:set>
		                    <c:set var="end05_15" value="${endPeriodSum_05_15}"></c:set>
		                    <c:set var="end04_15" value="${endPeriodSum_04_15}"></c:set>
		                    <c:set var="end03_15" value="${endPeriodSum_03_15}"></c:set>
		                    <c:set var="end02_15" value="${endPeriodSum_02_15}"></c:set>
		                    <c:set var="end01_15" value="${endPeriodSum_01_15}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="end12_15" value="${vo2.end12}"></c:set>
		                    <c:set var="end11_15" value="${vo2.end11}"></c:set>
		                    <c:set var="end10_15" value="${vo2.end10}"></c:set>
		                    <c:set var="end09_15" value="${vo2.end09}"></c:set>
		                    <c:set var="end08_15" value="${vo2.end08}"></c:set>
		                    <c:set var="end07_15" value="${vo2.end07}"></c:set>
		                    <c:set var="end06_15" value="${vo2.end06}"></c:set>
		                    <c:set var="end05_15" value="${vo2.end05}"></c:set>
		                    <c:set var="end04_15" value="${vo2.end04}"></c:set>
		                    <c:set var="end03_15" value="${vo2.end03}"></c:set>
		                    <c:set var="end02_15" value="${vo2.end02}"></c:set>
		                    <c:set var="end01_15" value="${vo2.end01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="endPeriodSum_12_15" value="${endPeriodSum_12_15 + vo2.end12}"></c:set>
		                    <c:set var="endPeriodSum_11_15" value="${endPeriodSum_11_15 + vo2.end11}"></c:set>
		                    <c:set var="endPeriodSum_10_15" value="${endPeriodSum_10_15 + vo2.end10}"></c:set>
		                    <c:set var="endPeriodSum_09_15" value="${endPeriodSum_09_15 + vo2.end09}"></c:set>
		                    <c:set var="endPeriodSum_08_15" value="${endPeriodSum_08_15 + vo2.end08}"></c:set>
		                    <c:set var="endPeriodSum_07_15" value="${endPeriodSum_07_15 + vo2.end07}"></c:set>
		                    <c:set var="endPeriodSum_06_15" value="${endPeriodSum_06_15 + vo2.end06}"></c:set>
		                    <c:set var="endPeriodSum_05_15" value="${endPeriodSum_05_15 + vo2.end05}"></c:set>
		                    <c:set var="endPeriodSum_04_15" value="${endPeriodSum_04_15 + vo2.end04}"></c:set>
		                    <c:set var="endPeriodSum_03_15" value="${endPeriodSum_03_15 + vo2.end03}"></c:set>
		                    <c:set var="endPeriodSum_02_15" value="${endPeriodSum_02_15 + vo2.end02}"></c:set>
		                    <c:set var="endPeriodSum_01_15" value="${endPeriodSum_01_15 + vo2.end01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="endPtnrSum_12_15" value="${endPtnrSum_12_15 + vo2.end12}"></c:set>
		                    <c:set var="endPtnrSum_11_15" value="${endPtnrSum_11_15 + vo2.end11}"></c:set>
		                    <c:set var="endPtnrSum_10_15" value="${endPtnrSum_10_15 + vo2.end10}"></c:set>
		                    <c:set var="endPtnrSum_09_15" value="${endPtnrSum_09_15 + vo2.end09}"></c:set>
		                    <c:set var="endPtnrSum_08_15" value="${endPtnrSum_08_15 + vo2.end08}"></c:set>
		                    <c:set var="endPtnrSum_07_15" value="${endPtnrSum_07_15 + vo2.end07}"></c:set>
		                    <c:set var="endPtnrSum_06_15" value="${endPtnrSum_06_15 + vo2.end06}"></c:set>
		                    <c:set var="endPtnrSum_05_15" value="${endPtnrSum_05_15 + vo2.end05}"></c:set>
		                    <c:set var="endPtnrSum_04_15" value="${endPtnrSum_04_15 + vo2.end04}"></c:set>
		                    <c:set var="endPtnrSum_03_15" value="${endPtnrSum_03_15 + vo2.end03}"></c:set>
		                    <c:set var="endPtnrSum_02_15" value="${endPtnrSum_02_15 + vo2.end02}"></c:set>
		                    <c:set var="endPtnrSum_01_15" value="${endPtnrSum_01_15 + vo2.end01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="endTotalSum_12_15" value="${endTotalSum_12_15 + vo2.end12}"></c:set>
		                    <c:set var="endTotalSum_11_15" value="${endTotalSum_11_15 + vo2.end11}"></c:set>
		                    <c:set var="endTotalSum_10_15" value="${endTotalSum_10_15 + vo2.end10}"></c:set>
		                    <c:set var="endTotalSum_09_15" value="${endTotalSum_09_15 + vo2.end09}"></c:set>
		                    <c:set var="endTotalSum_08_15" value="${endTotalSum_08_15 + vo2.end08}"></c:set>
		                    <c:set var="endTotalSum_07_15" value="${endTotalSum_07_15 + vo2.end07}"></c:set>
		                    <c:set var="endTotalSum_06_15" value="${endTotalSum_06_15 + vo2.end06}"></c:set>
		                    <c:set var="endTotalSum_05_15" value="${endTotalSum_05_15 + vo2.end05}"></c:set>
		                    <c:set var="endTotalSum_04_15" value="${endTotalSum_04_15 + vo2.end04}"></c:set>
		                    <c:set var="endTotalSum_03_15" value="${endTotalSum_03_15 + vo2.end03}"></c:set>
		                    <c:set var="endTotalSum_02_15" value="${endTotalSum_02_15 + vo2.end02}"></c:set>
		                    <c:set var="endTotalSum_01_15" value="${endTotalSum_01_15 + vo2.end01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    
                    <!-- 가로 합계 -->
                    <c:set var="endColSum_15" value="${end12_15 + end11_15 + end10_15 + end09_15 + end08_15 + end07_15 + end06_15 + end05_15 + end04_15 + end03_15 + end02_15 + end01_15}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo2.periodFlagNm == "소계"}'>
							<!-- end12 -->
		                    <td style="width: 80px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1">${end12_15}</td>
		                    <!-- end11 -->
		                    <td style="width: 80px;" class="sum-level-1">${end11_15}</td>
		                    <!-- end10 -->
		                    <td style="width: 80px;" class="sum-level-1">${end10_15}</td>
		                    <!-- end09 -->
		                    <td style="width: 80px;" class="sum-level-1">${end09_15}</td>
		                    <!-- end08 -->
		                    <td style="width: 80px;" class="sum-level-1">${end08_15}</td>
		                    <!-- end07 -->
		                    <td style="width: 80px;" class="sum-level-1">${end07_15}</td>
		                    <!-- end06 -->
		                    <td style="width: 80px;" class="sum-level-1">${end06_15}</td>
		                    <!-- end05 -->
		                    <td style="width: 80px;" class="sum-level-1">${end05_15}</td>
		                    <!-- end04 -->
		                    <td style="width: 80px;" class="sum-level-1">${end04_15}</td>
		                    <!-- end03 -->
		                    <td style="width: 80px;" class="sum-level-1">${end03_15}</td>
		                    <!-- end02 -->
		                    <td style="width: 80px;" class="sum-level-1">${end02_15}</td>
		                    <!-- end01 -->
		                    <td style="width: 80px;" class="sum-level-1">${end01_15}</td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 80px;" class="sum-level-1">${endColSum_15}</td>
						</c:when>
						<c:otherwise>
							<!-- end12 -->
		                    <td style="width: 80px;border-left:0.2em solid #b9b9b9 !important;">${end12_15}</td>
		                    <!-- end11 -->
		                    <td style="width: 80px;">${end11_15}</td>
		                    <!-- end10 -->
		                    <td style="width: 80px;">${end10_15}</td>
		                    <!-- end09 -->
		                    <td style="width: 80px;">${end09_15}</td>
		                    <!-- end08 -->
		                    <td style="width: 80px;">${end08_15}</td>
		                    <!-- end07 -->
		                    <td style="width: 80px;">${end07_15}</td>
		                    <!-- end06 -->
		                    <td style="width: 80px;">${end06_15}</td>
		                    <!-- end05 -->
		                    <td style="width: 80px;">${end05_15}</td>
		                    <!-- end04 -->
		                    <td style="width: 80px;">${end04_15}</td>
		                    <!-- end03 -->
		                    <td style="width: 80px;">${end03_15}</td>
		                    <!-- end02 -->
		                    <td style="width: 80px;">${end02_15}</td>
		                    <!-- end01 -->
		                    <td style="width: 80px;">${end01_15}</td>
		                    <!-- 가로 합계 -->                    
		                    <td style="width: 80px;">${endColSum_15}</td>
						</c:otherwise>
					</c:choose>  
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo2.periodFlagCode == 3}">
                    	<c:set var="endPeriodSum_12_15" value="0"></c:set>
			            <c:set var="endPeriodSum_11_15" value="0"></c:set>
			            <c:set var="endPeriodSum_10_15" value="0"></c:set>
			            <c:set var="endPeriodSum_09_15" value="0"></c:set>
			            <c:set var="endPeriodSum_08_15" value="0"></c:set>
			            <c:set var="endPeriodSum_07_15" value="0"></c:set>
			            <c:set var="endPeriodSum_06_15" value="0"></c:set>
			            <c:set var="endPeriodSum_05_15" value="0"></c:set>
			            <c:set var="endPeriodSum_04_15" value="0"></c:set>
			            <c:set var="endPeriodSum_03_15" value="0"></c:set>
			            <c:set var="endPeriodSum_02_15" value="0"></c:set>
			            <c:set var="endPeriodSum_01_15" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo2.ptnrRowCnt > 1}">
                	<c:if test="${vo2.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="endPeriodSum_12_15" value="0"></c:set>
			            <c:set var="endPeriodSum_11_15" value="0"></c:set>
			            <c:set var="endPeriodSum_10_15" value="0"></c:set>
			            <c:set var="endPeriodSum_09_15" value="0"></c:set>
			            <c:set var="endPeriodSum_08_15" value="0"></c:set>
			            <c:set var="endPeriodSum_07_15" value="0"></c:set>
			            <c:set var="endPeriodSum_06_15" value="0"></c:set>
			            <c:set var="endPeriodSum_05_15" value="0"></c:set>
			            <c:set var="endPeriodSum_04_15" value="0"></c:set>
			            <c:set var="endPeriodSum_03_15" value="0"></c:set>
			            <c:set var="endPeriodSum_02_15" value="0"></c:set>
			            <c:set var="endPeriodSum_01_15" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- end12 -->
		                    <td style="border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2">${endPtnrSum_12_15}</td>
		                    <!-- end11 -->
		                    <td class="sum-level-2">${endPtnrSum_11_15}</td>
		                    <!-- end10 -->
		                    <td class="sum-level-2">${endPtnrSum_10_15}</td>
		                    <!-- end09 -->
		                    <td class="sum-level-2">${endPtnrSum_09_15}</td>
		                    <!-- end08 -->
		                    <td class="sum-level-2">${endPtnrSum_08_15}</td>
		                    <!-- end07 -->
		                    <td class="sum-level-2">${endPtnrSum_07_15}</td>
		                    <!-- end06 -->
		                    <td class="sum-level-2">${endPtnrSum_06_15}</td>
		                    <!-- end05 -->
		                    <td class="sum-level-2">${endPtnrSum_05_15}</td>
		                    <!-- end04 -->
		                    <td class="sum-level-2">${endPtnrSum_04_15}</td>
		                    <!-- end03 -->
		                    <td class="sum-level-2">${endPtnrSum_03_15}</td>
		                    <!-- end02 -->
		                    <td class="sum-level-2">${endPtnrSum_02_15}</td>
		                    <!-- end01 -->
		                    <td class="sum-level-2">${endPtnrSum_01_15}</td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="endPtnrColSum_15" value="${endPtnrSum_12_15 + endPtnrSum_11_15 + endPtnrSum_10_15 + endPtnrSum_09_15 + endPtnrSum_08_15 + endPtnrSum_07_15 + endPtnrSum_06_15 + endPtnrSum_05_15 + endPtnrSum_04_15 + endPtnrSum_03_15 + endPtnrSum_02_15 + endPtnrSum_01_15}"></c:set>
		                    <td class="sum-level-2">${endPtnrColSum_15}</td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 기타 소계</th>
                <!-- end12 -->
                <th>${endTotalSum_12_15}</th>
                <!-- end11 -->
                <th>${endTotalSum_11_15}</th>
                <!-- end10 -->
                <th>${endTotalSum_10_15}</th>
                <!-- end09 -->
                <th>${endTotalSum_09_15}</th>
                <!-- end08 -->
                <th>${endTotalSum_08_15}</th>
                <!-- end07 -->
                <th>${endTotalSum_07_15}</th>
                <!-- end06 -->
                <th>${endTotalSum_06_15}</th>
                <!-- end05 -->
                <th>${endTotalSum_05_15}</th>
                <!-- end04 -->
                <th>${endTotalSum_04_15}</th>
                <!-- end03 -->
                <th>${endTotalSum_03_15}</th>
                <!-- end02 -->
                <th>${endTotalSum_02_15}</th>
                <!-- end01 -->
                <th>${endTotalSum_01_15}</th>
                <!-- 가로열 합계 -->
                <c:set var="endColTotalSum_15" value="${endTotalSum_12_15 + endTotalSum_11_15 + endTotalSum_10_15 + endTotalSum_09_15 + endTotalSum_08_15 + endTotalSum_07_15 + endTotalSum_06_15 + endTotalSum_05_15 + endTotalSum_04_15 + endTotalSum_03_15 + endTotalSum_02_15 + endTotalSum_01_15}"></c:set>
                <th>${endColTotalSum_15}</th>
            </tr>						
			</tbody>
		</table>		
		<!-- 1종 기타 끝 -->
    </div>    
    <!-- 총 합계 시작 -->
    <!-- 총 합계 변수 시작 -->
    <c:set var="endTotalSum_12_all" value="${endTotalSum_12_5 + endTotalSum_12_10 + endTotalSum_12_15}"></c:set>
    <c:set var="endTotalSum_11_all" value="${endTotalSum_11_5 + endTotalSum_11_10 + endTotalSum_11_15}"></c:set>
    <c:set var="endTotalSum_10_all" value="${endTotalSum_10_5 + endTotalSum_10_10 + endTotalSum_10_15}"></c:set>
    <c:set var="endTotalSum_09_all" value="${endTotalSum_09_5 + endTotalSum_09_10 + endTotalSum_09_15}"></c:set>
    <c:set var="endTotalSum_08_all" value="${endTotalSum_08_5 + endTotalSum_08_10 + endTotalSum_08_15}"></c:set>
    <c:set var="endTotalSum_07_all" value="${endTotalSum_07_5 + endTotalSum_07_10 + endTotalSum_07_15}"></c:set>
    <c:set var="endTotalSum_06_all" value="${endTotalSum_06_5 + endTotalSum_06_10 + endTotalSum_06_15}"></c:set>
    <c:set var="endTotalSum_05_all" value="${endTotalSum_05_5 + endTotalSum_05_10 + endTotalSum_05_15}"></c:set>
    <c:set var="endTotalSum_04_all" value="${endTotalSum_04_5 + endTotalSum_04_10 + endTotalSum_04_15}"></c:set>
    <c:set var="endTotalSum_03_all" value="${endTotalSum_03_5 + endTotalSum_03_10 + endTotalSum_03_15}"></c:set>
    <c:set var="endTotalSum_02_all" value="${endTotalSum_02_5 + endTotalSum_02_10 + endTotalSum_02_15}"></c:set>
    <c:set var="endTotalSum_01_all" value="${endTotalSum_01_5 + endTotalSum_01_10 + endTotalSum_01_15}"></c:set>        
    <c:set var="endTotalSum_col_all" value="${endTotalSum_12_all + endTotalSum_11_all + endTotalSum_10_all + endTotalSum_09_all + endTotalSum_08_all + endTotalSum_07_all + endTotalSum_06_all + endTotalSum_05_all + endTotalSum_04_all + endTotalSum_03_all + endTotalSum_02_all + endTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체합계</th>
                <th style="width: 80px;color:blue;">${endTotalSum_12_all}</th>
                <th style="width: 80px;color:blue;">${endTotalSum_11_all}</th>
                <th style="width: 80px;color:blue;">${endTotalSum_10_all}</th>
                <th style="width: 80px;color:blue;">${endTotalSum_09_all}</th>
                <th style="width: 80px;color:blue;">${endTotalSum_08_all}</th>
                <th style="width: 80px;color:blue;">${endTotalSum_07_all}</th>
                <th style="width: 80px;color:blue;">${endTotalSum_06_all}</th>
                <th style="width: 80px;color:blue;">${endTotalSum_05_all}</th>
                <th style="width: 80px;color:blue;">${endTotalSum_04_all}</th>
                <th style="width: 80px;color:blue;">${endTotalSum_03_all}</th>
                <th style="width: 80px;color:blue;">${endTotalSum_02_all}</th>
                <th style="width: 80px;color:blue;">${endTotalSum_01_all}</th>
				<th style="width: 80px;color:blue;">${endTotalSum_col_all}</th>
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>
