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
            <c:set var="reg12_5" value="0"></c:set>
            <c:set var="reg11_5" value="0"></c:set>
            <c:set var="reg10_5" value="0"></c:set>
            <c:set var="reg09_5" value="0"></c:set>
            <c:set var="reg08_5" value="0"></c:set>
            <c:set var="reg07_5" value="0"></c:set>
            <c:set var="reg06_5" value="0"></c:set>
            <c:set var="reg05_5" value="0"></c:set>
            <c:set var="reg04_5" value="0"></c:set>
            <c:set var="reg03_5" value="0"></c:set>
            <c:set var="reg02_5" value="0"></c:set>
            <c:set var="reg01_5" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="regPeriodSum_12_5" value="0"></c:set>
            <c:set var="regPeriodSum_11_5" value="0"></c:set>
            <c:set var="regPeriodSum_10_5" value="0"></c:set>
            <c:set var="regPeriodSum_09_5" value="0"></c:set>
            <c:set var="regPeriodSum_08_5" value="0"></c:set>
            <c:set var="regPeriodSum_07_5" value="0"></c:set>
            <c:set var="regPeriodSum_06_5" value="0"></c:set>
            <c:set var="regPeriodSum_05_5" value="0"></c:set>
            <c:set var="regPeriodSum_04_5" value="0"></c:set>
            <c:set var="regPeriodSum_03_5" value="0"></c:set>
            <c:set var="regPeriodSum_02_5" value="0"></c:set>
            <c:set var="regPeriodSum_01_5" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="regPtnrSum_12_5" value="0"></c:set>
            <c:set var="regPtnrSum_11_5" value="0"></c:set>
            <c:set var="regPtnrSum_10_5" value="0"></c:set>
            <c:set var="regPtnrSum_09_5" value="0"></c:set>
            <c:set var="regPtnrSum_08_5" value="0"></c:set>
            <c:set var="regPtnrSum_07_5" value="0"></c:set>
            <c:set var="regPtnrSum_06_5" value="0"></c:set>
            <c:set var="regPtnrSum_05_5" value="0"></c:set>
            <c:set var="regPtnrSum_04_5" value="0"></c:set>
            <c:set var="regPtnrSum_03_5" value="0"></c:set>
            <c:set var="regPtnrSum_02_5" value="0"></c:set>
            <c:set var="regPtnrSum_01_5" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="regColSum_5" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="regPtnrColSum_5" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="regTotalSum_12_5" value="0"></c:set>
            <c:set var="regTotalSum_11_5" value="0"></c:set>
            <c:set var="regTotalSum_10_5" value="0"></c:set>
            <c:set var="regTotalSum_09_5" value="0"></c:set>
            <c:set var="regTotalSum_08_5" value="0"></c:set>
            <c:set var="regTotalSum_07_5" value="0"></c:set>
            <c:set var="regTotalSum_06_5" value="0"></c:set>
            <c:set var="regTotalSum_05_5" value="0"></c:set>
            <c:set var="regTotalSum_04_5" value="0"></c:set>
            <c:set var="regTotalSum_03_5" value="0"></c:set>
            <c:set var="regTotalSum_02_5" value="0"></c:set>
            <c:set var="regTotalSum_01_5" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="regColTotalSum_5" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo" items="${ptnrStatRegList}" varStatus="status">            
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
						            <c:set var="regPtnrSum_12_5" value="0"></c:set>
						            <c:set var="regPtnrSum_11_5" value="0"></c:set>
						            <c:set var="regPtnrSum_10_5" value="0"></c:set>
						            <c:set var="regPtnrSum_09_5" value="0"></c:set>
						            <c:set var="regPtnrSum_08_5" value="0"></c:set>
						            <c:set var="regPtnrSum_07_5" value="0"></c:set>
						            <c:set var="regPtnrSum_06_5" value="0"></c:set>
						            <c:set var="regPtnrSum_05_5" value="0"></c:set>
						            <c:set var="regPtnrSum_04_5" value="0"></c:set>
						            <c:set var="regPtnrSum_03_5" value="0"></c:set>
						            <c:set var="regPtnrSum_02_5" value="0"></c:set>
						            <c:set var="regPtnrSum_01_5" value="0"></c:set>
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
                    		<c:set var="reg12_5" value="${regPeriodSum_12_5}"></c:set>
		                    <c:set var="reg11_5" value="${regPeriodSum_11_5}"></c:set>
		                    <c:set var="reg10_5" value="${regPeriodSum_10_5}"></c:set>
		                    <c:set var="reg09_5" value="${regPeriodSum_09_5}"></c:set>
		                    <c:set var="reg08_5" value="${regPeriodSum_08_5}"></c:set>
		                    <c:set var="reg07_5" value="${regPeriodSum_07_5}"></c:set>
		                    <c:set var="reg06_5" value="${regPeriodSum_06_5}"></c:set>
		                    <c:set var="reg05_5" value="${regPeriodSum_05_5}"></c:set>
		                    <c:set var="reg04_5" value="${regPeriodSum_04_5}"></c:set>
		                    <c:set var="reg03_5" value="${regPeriodSum_03_5}"></c:set>
		                    <c:set var="reg02_5" value="${regPeriodSum_02_5}"></c:set>
		                    <c:set var="reg01_5" value="${regPeriodSum_01_5}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="reg12_5" value="${vo.reg12}"></c:set>
		                    <c:set var="reg11_5" value="${vo.reg11}"></c:set>
		                    <c:set var="reg10_5" value="${vo.reg10}"></c:set>
		                    <c:set var="reg09_5" value="${vo.reg09}"></c:set>
		                    <c:set var="reg08_5" value="${vo.reg08}"></c:set>
		                    <c:set var="reg07_5" value="${vo.reg07}"></c:set>
		                    <c:set var="reg06_5" value="${vo.reg06}"></c:set>
		                    <c:set var="reg05_5" value="${vo.reg05}"></c:set>
		                    <c:set var="reg04_5" value="${vo.reg04}"></c:set>
		                    <c:set var="reg03_5" value="${vo.reg03}"></c:set>
		                    <c:set var="reg02_5" value="${vo.reg02}"></c:set>
		                    <c:set var="reg01_5" value="${vo.reg01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="regPeriodSum_12_5" value="${regPeriodSum_12_5 + vo.reg12}"></c:set>
		                    <c:set var="regPeriodSum_11_5" value="${regPeriodSum_11_5 + vo.reg11}"></c:set>
		                    <c:set var="regPeriodSum_10_5" value="${regPeriodSum_10_5 + vo.reg10}"></c:set>
		                    <c:set var="regPeriodSum_09_5" value="${regPeriodSum_09_5 + vo.reg09}"></c:set>
		                    <c:set var="regPeriodSum_08_5" value="${regPeriodSum_08_5 + vo.reg08}"></c:set>
		                    <c:set var="regPeriodSum_07_5" value="${regPeriodSum_07_5 + vo.reg07}"></c:set>
		                    <c:set var="regPeriodSum_06_5" value="${regPeriodSum_06_5 + vo.reg06}"></c:set>
		                    <c:set var="regPeriodSum_05_5" value="${regPeriodSum_05_5 + vo.reg05}"></c:set>
		                    <c:set var="regPeriodSum_04_5" value="${regPeriodSum_04_5 + vo.reg04}"></c:set>
		                    <c:set var="regPeriodSum_03_5" value="${regPeriodSum_03_5 + vo.reg03}"></c:set>
		                    <c:set var="regPeriodSum_02_5" value="${regPeriodSum_02_5 + vo.reg02}"></c:set>
		                    <c:set var="regPeriodSum_01_5" value="${regPeriodSum_01_5 + vo.reg01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="regPtnrSum_12_5" value="${regPtnrSum_12_5 + vo.reg12}"></c:set>
		                    <c:set var="regPtnrSum_11_5" value="${regPtnrSum_11_5 + vo.reg11}"></c:set>
		                    <c:set var="regPtnrSum_10_5" value="${regPtnrSum_10_5 + vo.reg10}"></c:set>
		                    <c:set var="regPtnrSum_09_5" value="${regPtnrSum_09_5 + vo.reg09}"></c:set>
		                    <c:set var="regPtnrSum_08_5" value="${regPtnrSum_08_5 + vo.reg08}"></c:set>
		                    <c:set var="regPtnrSum_07_5" value="${regPtnrSum_07_5 + vo.reg07}"></c:set>
		                    <c:set var="regPtnrSum_06_5" value="${regPtnrSum_06_5 + vo.reg06}"></c:set>
		                    <c:set var="regPtnrSum_05_5" value="${regPtnrSum_05_5 + vo.reg05}"></c:set>
		                    <c:set var="regPtnrSum_04_5" value="${regPtnrSum_04_5 + vo.reg04}"></c:set>
		                    <c:set var="regPtnrSum_03_5" value="${regPtnrSum_03_5 + vo.reg03}"></c:set>
		                    <c:set var="regPtnrSum_02_5" value="${regPtnrSum_02_5 + vo.reg02}"></c:set>
		                    <c:set var="regPtnrSum_01_5" value="${regPtnrSum_01_5 + vo.reg01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="regTotalSum_12_5" value="${regTotalSum_12_5 + vo.reg12}"></c:set>
		                    <c:set var="regTotalSum_11_5" value="${regTotalSum_11_5 + vo.reg11}"></c:set>
		                    <c:set var="regTotalSum_10_5" value="${regTotalSum_10_5 + vo.reg10}"></c:set>
		                    <c:set var="regTotalSum_09_5" value="${regTotalSum_09_5 + vo.reg09}"></c:set>
		                    <c:set var="regTotalSum_08_5" value="${regTotalSum_08_5 + vo.reg08}"></c:set>
		                    <c:set var="regTotalSum_07_5" value="${regTotalSum_07_5 + vo.reg07}"></c:set>
		                    <c:set var="regTotalSum_06_5" value="${regTotalSum_06_5 + vo.reg06}"></c:set>
		                    <c:set var="regTotalSum_05_5" value="${regTotalSum_05_5 + vo.reg05}"></c:set>
		                    <c:set var="regTotalSum_04_5" value="${regTotalSum_04_5 + vo.reg04}"></c:set>
		                    <c:set var="regTotalSum_03_5" value="${regTotalSum_03_5 + vo.reg03}"></c:set>
		                    <c:set var="regTotalSum_02_5" value="${regTotalSum_02_5 + vo.reg02}"></c:set>
		                    <c:set var="regTotalSum_01_5" value="${regTotalSum_01_5 + vo.reg01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                                        
                    <!-- 가로 합계 -->
                    <c:set var="regColSum_5" value="${reg12_5 + reg11_5 + reg10_5 + reg09_5 + reg08_5 + reg07_5 + reg06_5 + reg05_5 + reg04_5 + reg03_5 + reg02_5 + reg01_5}"></c:set>
                    
                    <c:choose>
						<c:when test='${vo.periodFlagNm == "소계"}'>							
							<!-- reg12 -->
		                    <td style="width: 80px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1">${reg12_5}</td>
		                    <!-- reg11 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg11_5}</td>
		                    <!-- reg10 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg10_5}</td>
		                    <!-- reg09 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg09_5}</td>
		                    <!-- reg08 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg08_5}</td>
		                    <!-- reg07 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg07_5}</td>
		                    <!-- reg06 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg06_5}</td>
		                    <!-- reg05 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg05_5}</td>
		                    <!-- reg04 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg04_5}</td>
		                    <!-- reg03 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg03_5}</td>
		                    <!-- reg02 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg02_5}</td>
		                    <!-- reg01 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg01_5}</td>
							<!-- 가로열 합계 -->
		                    <td style="width: 80px;" class="sum-level-1">${regColSum_5}</td>
						</c:when>
						<c:otherwise>
							<!-- reg12 -->
		                    <td style="width: 80px;border-left:0.2em solid #b9b9b9 !important;">${reg12_5}</td>
		                    <!-- reg11 -->
		                    <td style="width: 80px;">${reg11_5}</td>
		                    <!-- reg10 -->
		                    <td style="width: 80px;">${reg10_5}</td>
		                    <!-- reg09 -->
		                    <td style="width: 80px;">${reg09_5}</td>
		                    <!-- reg08 -->
		                    <td style="width: 80px;">${reg08_5}</td>
		                    <!-- reg07 -->
		                    <td style="width: 80px;">${reg07_5}</td>
		                    <!-- reg06 -->
		                    <td style="width: 80px;">${reg06_5}</td>
		                    <!-- reg05 -->
		                    <td style="width: 80px;">${reg05_5}</td>
		                    <!-- reg04 -->
		                    <td style="width: 80px;">${reg04_5}</td>
		                    <!-- reg03 -->
		                    <td style="width: 80px;">${reg03_5}</td>
		                    <!-- reg02 -->
		                    <td style="width: 80px;">${reg02_5}</td>
		                    <!-- reg01 -->
		                    <td style="width: 80px;">${reg01_5}</td>
							<!-- 가로열 합계 -->
		                    <td style="width: 80px;">${regColSum_5}</td>
						</c:otherwise>
					</c:choose>  
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo.periodFlagCode == 3}">
                    	<c:set var="regPeriodSum_12_5" value="0"></c:set>
			            <c:set var="regPeriodSum_11_5" value="0"></c:set>
			            <c:set var="regPeriodSum_10_5" value="0"></c:set>
			            <c:set var="regPeriodSum_09_5" value="0"></c:set>
			            <c:set var="regPeriodSum_08_5" value="0"></c:set>
			            <c:set var="regPeriodSum_07_5" value="0"></c:set>
			            <c:set var="regPeriodSum_06_5" value="0"></c:set>
			            <c:set var="regPeriodSum_05_5" value="0"></c:set>
			            <c:set var="regPeriodSum_04_5" value="0"></c:set>
			            <c:set var="regPeriodSum_03_5" value="0"></c:set>
			            <c:set var="regPeriodSum_02_5" value="0"></c:set>
			            <c:set var="regPeriodSum_01_5" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo.ptnrRowCnt > 1}">
                	<c:if test="${vo.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="regPeriodSum_12_5" value="0"></c:set>
			            <c:set var="regPeriodSum_11_5" value="0"></c:set>
			            <c:set var="regPeriodSum_10_5" value="0"></c:set>
			            <c:set var="regPeriodSum_09_5" value="0"></c:set>
			            <c:set var="regPeriodSum_08_5" value="0"></c:set>
			            <c:set var="regPeriodSum_07_5" value="0"></c:set>
			            <c:set var="regPeriodSum_06_5" value="0"></c:set>
			            <c:set var="regPeriodSum_05_5" value="0"></c:set>
			            <c:set var="regPeriodSum_04_5" value="0"></c:set>
			            <c:set var="regPeriodSum_03_5" value="0"></c:set>
			            <c:set var="regPeriodSum_02_5" value="0"></c:set>
			            <c:set var="regPeriodSum_01_5" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- reg12 -->
		                    <td style="border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2">${regPtnrSum_12_5}</td>
		                    <!-- reg11 -->
		                    <td class="sum-level-2">${regPtnrSum_11_5}</td>
		                    <!-- reg10 -->
		                    <td class="sum-level-2">${regPtnrSum_10_5}</td>
		                    <!-- reg09 -->
		                    <td class="sum-level-2">${regPtnrSum_09_5}</td>
		                    <!-- reg08 -->
		                    <td class="sum-level-2">${regPtnrSum_08_5}</td>
		                    <!-- reg07 -->
		                    <td class="sum-level-2">${regPtnrSum_07_5}</td>
		                    <!-- reg06 -->
		                    <td class="sum-level-2">${regPtnrSum_06_5}</td>
		                    <!-- reg05 -->
		                    <td class="sum-level-2">${regPtnrSum_05_5}</td>
		                    <!-- reg04 -->
		                    <td class="sum-level-2">${regPtnrSum_04_5}</td>
		                    <!-- reg03 -->
		                    <td class="sum-level-2">${regPtnrSum_03_5}</td>
		                    <!-- reg02 -->
		                    <td class="sum-level-2">${regPtnrSum_02_5}</td>
		                    <!-- reg01 -->
		                    <td class="sum-level-2">${regPtnrSum_01_5}</td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="regPtnrColSum_5" value="${regPtnrSum_12_5 + regPtnrSum_11_5 + regPtnrSum_10_5 + regPtnrSum_09_5 + regPtnrSum_08_5 + regPtnrSum_07_5 + regPtnrSum_06_5 + regPtnrSum_05_5 + regPtnrSum_04_5 + regPtnrSum_03_5 + regPtnrSum_02_5 + regPtnrSum_01_5}"></c:set>
		                    <td class="sum-level-2">${regPtnrColSum_5}</td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 조사 소계</th>
                <!-- reg12 -->
                <th>${regTotalSum_12_5}</th>
                <!-- reg11 -->
                <th>${regTotalSum_11_5}</th>
                <!-- reg10 -->
                <th>${regTotalSum_10_5}</th>
                <!-- reg09 -->
                <th>${regTotalSum_09_5}</th>
                <!-- reg08 -->
                <th>${regTotalSum_08_5}</th>
                <!-- reg07 -->
                <th>${regTotalSum_07_5}</th>
                <!-- reg06 -->
                <th>${regTotalSum_06_5}</th>
                <!-- reg05 -->
                <th>${regTotalSum_05_5}</th>
                <!-- reg04 -->
                <th>${regTotalSum_04_5}</th>
                <!-- reg03 -->
                <th>${regTotalSum_03_5}</th>
                <!-- reg02 -->
                <th>${regTotalSum_02_5}</th>
                <!-- reg01 -->
                <th>${regTotalSum_01_5}</th>
                <!-- 가로열 합계 -->
                <c:set var="regColTotalSum_5" value="${regTotalSum_12_5 + regTotalSum_11_5 + regTotalSum_10_5 + regTotalSum_09_5 + regTotalSum_08_5 + regTotalSum_07_5 + regTotalSum_06_5 + regTotalSum_05_5 + regTotalSum_04_5 + regTotalSum_03_5 + regTotalSum_02_5 + regTotalSum_01_5}"></c:set>
                <th>${regColTotalSum_5}</th>
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
            <c:set var="reg12_10" value="0"></c:set>
            <c:set var="reg11_10" value="0"></c:set>
            <c:set var="reg10_10" value="0"></c:set>
            <c:set var="reg09_10" value="0"></c:set>
            <c:set var="reg08_10" value="0"></c:set>
            <c:set var="reg07_10" value="0"></c:set>
            <c:set var="reg06_10" value="0"></c:set>
            <c:set var="reg05_10" value="0"></c:set>
            <c:set var="reg04_10" value="0"></c:set>
            <c:set var="reg03_10" value="0"></c:set>
            <c:set var="reg02_10" value="0"></c:set>
            <c:set var="reg01_10" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="regPeriodSum_12_10" value="0"></c:set>
            <c:set var="regPeriodSum_11_10" value="0"></c:set>
            <c:set var="regPeriodSum_10_10" value="0"></c:set>
            <c:set var="regPeriodSum_09_10" value="0"></c:set>
            <c:set var="regPeriodSum_08_10" value="0"></c:set>
            <c:set var="regPeriodSum_07_10" value="0"></c:set>
            <c:set var="regPeriodSum_06_10" value="0"></c:set>
            <c:set var="regPeriodSum_05_10" value="0"></c:set>
            <c:set var="regPeriodSum_04_10" value="0"></c:set>
            <c:set var="regPeriodSum_03_10" value="0"></c:set>
            <c:set var="regPeriodSum_02_10" value="0"></c:set>
            <c:set var="regPeriodSum_01_10" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="regPtnrSum_12_10" value="0"></c:set>
            <c:set var="regPtnrSum_11_10" value="0"></c:set>
            <c:set var="regPtnrSum_10_10" value="0"></c:set>
            <c:set var="regPtnrSum_09_10" value="0"></c:set>
            <c:set var="regPtnrSum_08_10" value="0"></c:set>
            <c:set var="regPtnrSum_07_10" value="0"></c:set>
            <c:set var="regPtnrSum_06_10" value="0"></c:set>
            <c:set var="regPtnrSum_05_10" value="0"></c:set>
            <c:set var="regPtnrSum_04_10" value="0"></c:set>
            <c:set var="regPtnrSum_03_10" value="0"></c:set>
            <c:set var="regPtnrSum_02_10" value="0"></c:set>
            <c:set var="regPtnrSum_01_10" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="regColSum_10" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="regPtnrColSum_10" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="regTotalSum_12_10" value="0"></c:set>
            <c:set var="regTotalSum_11_10" value="0"></c:set>
            <c:set var="regTotalSum_10_10" value="0"></c:set>
            <c:set var="regTotalSum_09_10" value="0"></c:set>
            <c:set var="regTotalSum_08_10" value="0"></c:set>
            <c:set var="regTotalSum_07_10" value="0"></c:set>
            <c:set var="regTotalSum_06_10" value="0"></c:set>
            <c:set var="regTotalSum_05_10" value="0"></c:set>
            <c:set var="regTotalSum_04_10" value="0"></c:set>
            <c:set var="regTotalSum_03_10" value="0"></c:set>
            <c:set var="regTotalSum_02_10" value="0"></c:set>
            <c:set var="regTotalSum_01_10" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="regColTotalSum_10" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo1" items="${ptnrStatRegList_10}" varStatus="status">            
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
						            <c:set var="regPtnrSum_12_10" value="0"></c:set>
						            <c:set var="regPtnrSum_11_10" value="0"></c:set>
						            <c:set var="regPtnrSum_10_10" value="0"></c:set>
						            <c:set var="regPtnrSum_09_10" value="0"></c:set>
						            <c:set var="regPtnrSum_08_10" value="0"></c:set>
						            <c:set var="regPtnrSum_07_10" value="0"></c:set>
						            <c:set var="regPtnrSum_06_10" value="0"></c:set>
						            <c:set var="regPtnrSum_05_10" value="0"></c:set>
						            <c:set var="regPtnrSum_04_10" value="0"></c:set>
						            <c:set var="regPtnrSum_03_10" value="0"></c:set>
						            <c:set var="regPtnrSum_02_10" value="0"></c:set>
						            <c:set var="regPtnrSum_01_10" value="0"></c:set>
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
                    		<c:set var="reg12_10" value="${regPeriodSum_12_10}"></c:set>
		                    <c:set var="reg11_10" value="${regPeriodSum_11_10}"></c:set>
		                    <c:set var="reg10_10" value="${regPeriodSum_10_10}"></c:set>
		                    <c:set var="reg09_10" value="${regPeriodSum_09_10}"></c:set>
		                    <c:set var="reg08_10" value="${regPeriodSum_08_10}"></c:set>
		                    <c:set var="reg07_10" value="${regPeriodSum_07_10}"></c:set>
		                    <c:set var="reg06_10" value="${regPeriodSum_06_10}"></c:set>
		                    <c:set var="reg05_10" value="${regPeriodSum_05_10}"></c:set>
		                    <c:set var="reg04_10" value="${regPeriodSum_04_10}"></c:set>
		                    <c:set var="reg03_10" value="${regPeriodSum_03_10}"></c:set>
		                    <c:set var="reg02_10" value="${regPeriodSum_02_10}"></c:set>
		                    <c:set var="reg01_10" value="${regPeriodSum_01_10}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="reg12_10" value="${vo1.reg12}"></c:set>
		                    <c:set var="reg11_10" value="${vo1.reg11}"></c:set>
		                    <c:set var="reg10_10" value="${vo1.reg10}"></c:set>
		                    <c:set var="reg09_10" value="${vo1.reg09}"></c:set>
		                    <c:set var="reg08_10" value="${vo1.reg08}"></c:set>
		                    <c:set var="reg07_10" value="${vo1.reg07}"></c:set>
		                    <c:set var="reg06_10" value="${vo1.reg06}"></c:set>
		                    <c:set var="reg05_10" value="${vo1.reg05}"></c:set>
		                    <c:set var="reg04_10" value="${vo1.reg04}"></c:set>
		                    <c:set var="reg03_10" value="${vo1.reg03}"></c:set>
		                    <c:set var="reg02_10" value="${vo1.reg02}"></c:set>
		                    <c:set var="reg01_10" value="${vo1.reg01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="regPeriodSum_12_10" value="${regPeriodSum_12_10 + vo1.reg12}"></c:set>
		                    <c:set var="regPeriodSum_11_10" value="${regPeriodSum_11_10 + vo1.reg11}"></c:set>
		                    <c:set var="regPeriodSum_10_10" value="${regPeriodSum_10_10 + vo1.reg10}"></c:set>
		                    <c:set var="regPeriodSum_09_10" value="${regPeriodSum_09_10 + vo1.reg09}"></c:set>
		                    <c:set var="regPeriodSum_08_10" value="${regPeriodSum_08_10 + vo1.reg08}"></c:set>
		                    <c:set var="regPeriodSum_07_10" value="${regPeriodSum_07_10 + vo1.reg07}"></c:set>
		                    <c:set var="regPeriodSum_06_10" value="${regPeriodSum_06_10 + vo1.reg06}"></c:set>
		                    <c:set var="regPeriodSum_05_10" value="${regPeriodSum_05_10 + vo1.reg05}"></c:set>
		                    <c:set var="regPeriodSum_04_10" value="${regPeriodSum_04_10 + vo1.reg04}"></c:set>
		                    <c:set var="regPeriodSum_03_10" value="${regPeriodSum_03_10 + vo1.reg03}"></c:set>
		                    <c:set var="regPeriodSum_02_10" value="${regPeriodSum_02_10 + vo1.reg02}"></c:set>
		                    <c:set var="regPeriodSum_01_10" value="${regPeriodSum_01_10 + vo1.reg01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="regPtnrSum_12_10" value="${regPtnrSum_12_10 + vo1.reg12}"></c:set>
		                    <c:set var="regPtnrSum_11_10" value="${regPtnrSum_11_10 + vo1.reg11}"></c:set>
		                    <c:set var="regPtnrSum_10_10" value="${regPtnrSum_10_10 + vo1.reg10}"></c:set>
		                    <c:set var="regPtnrSum_09_10" value="${regPtnrSum_09_10 + vo1.reg09}"></c:set>
		                    <c:set var="regPtnrSum_08_10" value="${regPtnrSum_08_10 + vo1.reg08}"></c:set>
		                    <c:set var="regPtnrSum_07_10" value="${regPtnrSum_07_10 + vo1.reg07}"></c:set>
		                    <c:set var="regPtnrSum_06_10" value="${regPtnrSum_06_10 + vo1.reg06}"></c:set>
		                    <c:set var="regPtnrSum_05_10" value="${regPtnrSum_05_10 + vo1.reg05}"></c:set>
		                    <c:set var="regPtnrSum_04_10" value="${regPtnrSum_04_10 + vo1.reg04}"></c:set>
		                    <c:set var="regPtnrSum_03_10" value="${regPtnrSum_03_10 + vo1.reg03}"></c:set>
		                    <c:set var="regPtnrSum_02_10" value="${regPtnrSum_02_10 + vo1.reg02}"></c:set>
		                    <c:set var="regPtnrSum_01_10" value="${regPtnrSum_01_10 + vo1.reg01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="regTotalSum_12_10" value="${regTotalSum_12_10 + vo1.reg12}"></c:set>
		                    <c:set var="regTotalSum_11_10" value="${regTotalSum_11_10 + vo1.reg11}"></c:set>
		                    <c:set var="regTotalSum_10_10" value="${regTotalSum_10_10 + vo1.reg10}"></c:set>
		                    <c:set var="regTotalSum_09_10" value="${regTotalSum_09_10 + vo1.reg09}"></c:set>
		                    <c:set var="regTotalSum_08_10" value="${regTotalSum_08_10 + vo1.reg08}"></c:set>
		                    <c:set var="regTotalSum_07_10" value="${regTotalSum_07_10 + vo1.reg07}"></c:set>
		                    <c:set var="regTotalSum_06_10" value="${regTotalSum_06_10 + vo1.reg06}"></c:set>
		                    <c:set var="regTotalSum_05_10" value="${regTotalSum_05_10 + vo1.reg05}"></c:set>
		                    <c:set var="regTotalSum_04_10" value="${regTotalSum_04_10 + vo1.reg04}"></c:set>
		                    <c:set var="regTotalSum_03_10" value="${regTotalSum_03_10 + vo1.reg03}"></c:set>
		                    <c:set var="regTotalSum_02_10" value="${regTotalSum_02_10 + vo1.reg02}"></c:set>
		                    <c:set var="regTotalSum_01_10" value="${regTotalSum_01_10 + vo1.reg01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    <!-- 가로 합계 -->
                    <c:set var="regColSum_10" value="${reg12_10 + reg11_10 + reg10_10 + reg09_10 + reg08_10 + reg07_10 + reg06_10 + reg05_10 + reg04_10 + reg03_10 + reg02_10 + reg01_10}"></c:set>
                    
                    <c:choose>
                    	<c:when test='${vo1.periodFlagNm == "소계"}'>
                    		<!-- reg12 -->
		                    <td style="width: 80px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1">${reg12_10}</td>
		                    <!-- reg11 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg11_10}</td>
		                    <!-- reg10 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg10_10}</td>
		                    <!-- reg09 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg09_10}</td>
		                    <!-- reg08 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg08_10}</td>
		                    <!-- reg07 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg07_10}</td>
		                    <!-- reg06 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg06_10}</td>
		                    <!-- reg05 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg05_10}</td>
		                    <!-- reg04 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg04_10}</td>
		                    <!-- reg03 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg03_10}</td>
		                    <!-- reg02 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg02_10}</td>
		                    <!-- reg01 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg01_10}</td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 80px;" class="sum-level-1">${regColSum_10}</td>
                    	</c:when>
                    	<c:otherwise>
                    		<!-- reg12 -->
		                    <td style="width: 80px;border-left:0.2em solid #b9b9b9 !important;">${reg12_10}</td>
		                    <!-- reg11 -->
		                    <td style="width: 80px;">${reg11_10}</td>
		                    <!-- reg10 -->
		                    <td style="width: 80px;">${reg10_10}</td>
		                    <!-- reg09 -->
		                    <td style="width: 80px;">${reg09_10}</td>
		                    <!-- reg08 -->
		                    <td style="width: 80px;">${reg08_10}</td>
		                    <!-- reg07 -->
		                    <td style="width: 80px;">${reg07_10}</td>
		                    <!-- reg06 -->
		                    <td style="width: 80px;">${reg06_10}</td>
		                    <!-- reg05 -->
		                    <td style="width: 80px;">${reg05_10}</td>
		                    <!-- reg04 -->
		                    <td style="width: 80px;">${reg04_10}</td>
		                    <!-- reg03 -->
		                    <td style="width: 80px;">${reg03_10}</td>
		                    <!-- reg02 -->
		                    <td style="width: 80px;">${reg02_10}</td>
		                    <!-- reg01 -->
		                    <td style="width: 80px;">${reg01_10}</td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 80px;">${regColSum_10}</td>
                    	</c:otherwise>
                    </c:choose>                    
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo1.periodFlagCode == 3}">
                    	<c:set var="regPeriodSum_12_10" value="0"></c:set>
			            <c:set var="regPeriodSum_11_10" value="0"></c:set>
			            <c:set var="regPeriodSum_10_10" value="0"></c:set>
			            <c:set var="regPeriodSum_09_10" value="0"></c:set>
			            <c:set var="regPeriodSum_08_10" value="0"></c:set>
			            <c:set var="regPeriodSum_07_10" value="0"></c:set>
			            <c:set var="regPeriodSum_06_10" value="0"></c:set>
			            <c:set var="regPeriodSum_05_10" value="0"></c:set>
			            <c:set var="regPeriodSum_04_10" value="0"></c:set>
			            <c:set var="regPeriodSum_03_10" value="0"></c:set>
			            <c:set var="regPeriodSum_02_10" value="0"></c:set>
			            <c:set var="regPeriodSum_01_10" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo1.ptnrRowCnt > 1}">
                	<c:if test="${vo1.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="regPeriodSum_12_10" value="0"></c:set>
			            <c:set var="regPeriodSum_11_10" value="0"></c:set>
			            <c:set var="regPeriodSum_10_10" value="0"></c:set>
			            <c:set var="regPeriodSum_09_10" value="0"></c:set>
			            <c:set var="regPeriodSum_08_10" value="0"></c:set>
			            <c:set var="regPeriodSum_07_10" value="0"></c:set>
			            <c:set var="regPeriodSum_06_10" value="0"></c:set>
			            <c:set var="regPeriodSum_05_10" value="0"></c:set>
			            <c:set var="regPeriodSum_04_10" value="0"></c:set>
			            <c:set var="regPeriodSum_03_10" value="0"></c:set>
			            <c:set var="regPeriodSum_02_10" value="0"></c:set>
			            <c:set var="regPeriodSum_01_10" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- reg12 -->
		                    <td style="border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2">${regPtnrSum_12_10}</td>
		                    <!-- reg11 -->
		                    <td class="sum-level-2">${regPtnrSum_11_10}</td>
		                    <!-- reg10 -->
		                    <td class="sum-level-2">${regPtnrSum_10_10}</td>
		                    <!-- reg09 -->
		                    <td class="sum-level-2">${regPtnrSum_09_10}</td>
		                    <!-- reg08 -->
		                    <td class="sum-level-2">${regPtnrSum_08_10}</td>
		                    <!-- reg07 -->
		                    <td class="sum-level-2">${regPtnrSum_07_10}</td>
		                    <!-- reg06 -->
		                    <td class="sum-level-2">${regPtnrSum_06_10}</td>
		                    <!-- reg05 -->
		                    <td class="sum-level-2">${regPtnrSum_05_10}</td>
		                    <!-- reg04 -->
		                    <td class="sum-level-2">${regPtnrSum_04_10}</td>
		                    <!-- reg03 -->
		                    <td class="sum-level-2">${regPtnrSum_03_10}</td>
		                    <!-- reg02 -->
		                    <td class="sum-level-2">${regPtnrSum_02_10}</td>
		                    <!-- reg01 -->
		                    <td class="sum-level-2">${regPtnrSum_01_10}</td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="regPtnrColSum_10" value="${regPtnrSum_12_10 + regPtnrSum_11_10 + regPtnrSum_10_10 + regPtnrSum_09_10 + regPtnrSum_08_10 + regPtnrSum_07_10 + regPtnrSum_06_10 + regPtnrSum_05_10 + regPtnrSum_04_10 + regPtnrSum_03_10 + regPtnrSum_02_10 + regPtnrSum_01_10}"></c:set>
		                    <td class="sum-level-2">${regPtnrColSum_10}</td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 심사 소계</th>
                <!-- reg12 -->
                <th>${regTotalSum_12_10}</th>
                <!-- reg11 -->
                <th>${regTotalSum_11_10}</th>
                <!-- reg10 -->
                <th>${regTotalSum_10_10}</th>
                <!-- reg09 -->
                <th>${regTotalSum_09_10}</th>
                <!-- reg08 -->
                <th>${regTotalSum_08_10}</th>
                <!-- reg07 -->
                <th>${regTotalSum_07_10}</th>
                <!-- reg06 -->
                <th>${regTotalSum_06_10}</th>
                <!-- reg05 -->
                <th>${regTotalSum_05_10}</th>
                <!-- reg04 -->
                <th>${regTotalSum_04_10}</th>
                <!-- reg03 -->
                <th>${regTotalSum_03_10}</th>
                <!-- reg02 -->
                <th>${regTotalSum_02_10}</th>
                <!-- reg01 -->
                <th>${regTotalSum_01_10}</th>
                <!-- 가로열 합계 -->
                <c:set var="regColTotalSum_10" value="${regTotalSum_12_10 + regTotalSum_11_10 + regTotalSum_10_10 + regTotalSum_09_10 + regTotalSum_08_10 + regTotalSum_07_10 + regTotalSum_06_10 + regTotalSum_05_10 + regTotalSum_04_10 + regTotalSum_03_10 + regTotalSum_02_10 + regTotalSum_01_10}"></c:set>
                <th>${regColTotalSum_10}</th>
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
            <c:set var="reg12_15" value="0"></c:set>
            <c:set var="reg11_15" value="0"></c:set>
            <c:set var="reg10_15" value="0"></c:set>
            <c:set var="reg09_15" value="0"></c:set>
            <c:set var="reg08_15" value="0"></c:set>
            <c:set var="reg07_15" value="0"></c:set>
            <c:set var="reg06_15" value="0"></c:set>
            <c:set var="reg05_15" value="0"></c:set>
            <c:set var="reg04_15" value="0"></c:set>
            <c:set var="reg03_15" value="0"></c:set>
            <c:set var="reg02_15" value="0"></c:set>
            <c:set var="reg01_15" value="0"></c:set>
            <!-- 소계 합계 -->
            <c:set var="regPeriodSum_12_15" value="0"></c:set>
            <c:set var="regPeriodSum_11_15" value="0"></c:set>
            <c:set var="regPeriodSum_10_15" value="0"></c:set>
            <c:set var="regPeriodSum_09_15" value="0"></c:set>
            <c:set var="regPeriodSum_08_15" value="0"></c:set>
            <c:set var="regPeriodSum_07_15" value="0"></c:set>
            <c:set var="regPeriodSum_06_15" value="0"></c:set>
            <c:set var="regPeriodSum_05_15" value="0"></c:set>
            <c:set var="regPeriodSum_04_15" value="0"></c:set>
            <c:set var="regPeriodSum_03_15" value="0"></c:set>
            <c:set var="regPeriodSum_02_15" value="0"></c:set>
            <c:set var="regPeriodSum_01_15" value="0"></c:set>
            <!-- 보험사 합계 -->
            <c:set var="regPtnrSum_12_15" value="0"></c:set>
            <c:set var="regPtnrSum_11_15" value="0"></c:set>
            <c:set var="regPtnrSum_10_15" value="0"></c:set>
            <c:set var="regPtnrSum_09_15" value="0"></c:set>
            <c:set var="regPtnrSum_08_15" value="0"></c:set>
            <c:set var="regPtnrSum_07_15" value="0"></c:set>
            <c:set var="regPtnrSum_06_15" value="0"></c:set>
            <c:set var="regPtnrSum_05_15" value="0"></c:set>
            <c:set var="regPtnrSum_04_15" value="0"></c:set>
            <c:set var="regPtnrSum_03_15" value="0"></c:set>
            <c:set var="regPtnrSum_02_15" value="0"></c:set>
            <c:set var="regPtnrSum_01_15" value="0"></c:set>
            <!-- 기본 통계 값 가로열 합계 -->
            <c:set var="regColSum_15" value="0"></c:set>
            <!-- 보험사 계 가로열 합계 --> 
            <c:set var="regPtnrColSum_15" value="0"></c:set>
            
            <!-- Type 별 총 합계 -->
            <c:set var="regTotalSum_12_15" value="0"></c:set>
            <c:set var="regTotalSum_11_15" value="0"></c:set>
            <c:set var="regTotalSum_10_15" value="0"></c:set>
            <c:set var="regTotalSum_09_15" value="0"></c:set>
            <c:set var="regTotalSum_08_15" value="0"></c:set>
            <c:set var="regTotalSum_07_15" value="0"></c:set>
            <c:set var="regTotalSum_06_15" value="0"></c:set>
            <c:set var="regTotalSum_05_15" value="0"></c:set>
            <c:set var="regTotalSum_04_15" value="0"></c:set>
            <c:set var="regTotalSum_03_15" value="0"></c:set>
            <c:set var="regTotalSum_02_15" value="0"></c:set>
            <c:set var="regTotalSum_01_15" value="0"></c:set>
            <!-- Type 별 가로열 합계 -->
            <c:set var="regColTotalSum_15" value="0"></c:set>
            <!-- 통계변수 끝 -->
            
            <c:forEach var="vo2" items="${ptnrStatRegList_15}" varStatus="status">            
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
		                    		<td rowspan="${vo2.ptnrRowCnt+1}" onclick="goPtnrStatCenter(${vo.ptnrId});" style="width: 100px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.ptnrNick}</td>                    		
				                   	<c:set var="beforePtnrId" value="${vo2.ptnrId}"></c:set>
				                   	<c:set var="ptnrSubRow" value="1"></c:set>
				                   	
				                   	<!-- 보험사 변경 시 보험사 누적합계 초기화 -->
						            <c:set var="regPtnrSum_12_15" value="0"></c:set>
						            <c:set var="regPtnrSum_11_15" value="0"></c:set>
						            <c:set var="regPtnrSum_10_15" value="0"></c:set>
						            <c:set var="regPtnrSum_09_15" value="0"></c:set>
						            <c:set var="regPtnrSum_08_15" value="0"></c:set>
						            <c:set var="regPtnrSum_07_15" value="0"></c:set>
						            <c:set var="regPtnrSum_06_15" value="0"></c:set>
						            <c:set var="regPtnrSum_05_15" value="0"></c:set>
						            <c:set var="regPtnrSum_04_15" value="0"></c:set>
						            <c:set var="regPtnrSum_03_15" value="0"></c:set>
						            <c:set var="regPtnrSum_02_15" value="0"></c:set>
						            <c:set var="regPtnrSum_01_15" value="0"></c:set>
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
                    		<c:set var="reg12_15" value="${regPeriodSum_12_15}"></c:set>
		                    <c:set var="reg11_15" value="${regPeriodSum_11_15}"></c:set>
		                    <c:set var="reg10_15" value="${regPeriodSum_10_15}"></c:set>
		                    <c:set var="reg09_15" value="${regPeriodSum_09_15}"></c:set>
		                    <c:set var="reg08_15" value="${regPeriodSum_08_15}"></c:set>
		                    <c:set var="reg07_15" value="${regPeriodSum_07_15}"></c:set>
		                    <c:set var="reg06_15" value="${regPeriodSum_06_15}"></c:set>
		                    <c:set var="reg05_15" value="${regPeriodSum_05_15}"></c:set>
		                    <c:set var="reg04_15" value="${regPeriodSum_04_15}"></c:set>
		                    <c:set var="reg03_15" value="${regPeriodSum_03_15}"></c:set>
		                    <c:set var="reg02_15" value="${regPeriodSum_02_15}"></c:set>
		                    <c:set var="reg01_15" value="${regPeriodSum_01_15}"></c:set>
                    	</c:when>
                    	<c:otherwise>
                    		<c:set var="reg12_15" value="${vo2.reg12}"></c:set>
		                    <c:set var="reg11_15" value="${vo2.reg11}"></c:set>
		                    <c:set var="reg10_15" value="${vo2.reg10}"></c:set>
		                    <c:set var="reg09_15" value="${vo2.reg09}"></c:set>
		                    <c:set var="reg08_15" value="${vo2.reg08}"></c:set>
		                    <c:set var="reg07_15" value="${vo2.reg07}"></c:set>
		                    <c:set var="reg06_15" value="${vo2.reg06}"></c:set>
		                    <c:set var="reg05_15" value="${vo2.reg05}"></c:set>
		                    <c:set var="reg04_15" value="${vo2.reg04}"></c:set>
		                    <c:set var="reg03_15" value="${vo2.reg03}"></c:set>
		                    <c:set var="reg02_15" value="${vo2.reg02}"></c:set>
		                    <c:set var="reg01_15" value="${vo2.reg01}"></c:set>
		                    
		                    <!-- 소계 합계 누적-->
		                    <c:set var="regPeriodSum_12_15" value="${regPeriodSum_12_15 + vo2.reg12}"></c:set>
		                    <c:set var="regPeriodSum_11_15" value="${regPeriodSum_11_15 + vo2.reg11}"></c:set>
		                    <c:set var="regPeriodSum_10_15" value="${regPeriodSum_10_15 + vo2.reg10}"></c:set>
		                    <c:set var="regPeriodSum_09_15" value="${regPeriodSum_09_15 + vo2.reg09}"></c:set>
		                    <c:set var="regPeriodSum_08_15" value="${regPeriodSum_08_15 + vo2.reg08}"></c:set>
		                    <c:set var="regPeriodSum_07_15" value="${regPeriodSum_07_15 + vo2.reg07}"></c:set>
		                    <c:set var="regPeriodSum_06_15" value="${regPeriodSum_06_15 + vo2.reg06}"></c:set>
		                    <c:set var="regPeriodSum_05_15" value="${regPeriodSum_05_15 + vo2.reg05}"></c:set>
		                    <c:set var="regPeriodSum_04_15" value="${regPeriodSum_04_15 + vo2.reg04}"></c:set>
		                    <c:set var="regPeriodSum_03_15" value="${regPeriodSum_03_15 + vo2.reg03}"></c:set>
		                    <c:set var="regPeriodSum_02_15" value="${regPeriodSum_02_15 + vo2.reg02}"></c:set>
		                    <c:set var="regPeriodSum_01_15" value="${regPeriodSum_01_15 + vo2.reg01}"></c:set>
		                    
		                    <!-- 보험사 합계 누적-->
		                    <c:set var="regPtnrSum_12_15" value="${regPtnrSum_12_15 + vo2.reg12}"></c:set>
		                    <c:set var="regPtnrSum_11_15" value="${regPtnrSum_11_15 + vo2.reg11}"></c:set>
		                    <c:set var="regPtnrSum_10_15" value="${regPtnrSum_10_15 + vo2.reg10}"></c:set>
		                    <c:set var="regPtnrSum_09_15" value="${regPtnrSum_09_15 + vo2.reg09}"></c:set>
		                    <c:set var="regPtnrSum_08_15" value="${regPtnrSum_08_15 + vo2.reg08}"></c:set>
		                    <c:set var="regPtnrSum_07_15" value="${regPtnrSum_07_15 + vo2.reg07}"></c:set>
		                    <c:set var="regPtnrSum_06_15" value="${regPtnrSum_06_15 + vo2.reg06}"></c:set>
		                    <c:set var="regPtnrSum_05_15" value="${regPtnrSum_05_15 + vo2.reg05}"></c:set>
		                    <c:set var="regPtnrSum_04_15" value="${regPtnrSum_04_15 + vo2.reg04}"></c:set>
		                    <c:set var="regPtnrSum_03_15" value="${regPtnrSum_03_15 + vo2.reg03}"></c:set>
		                    <c:set var="regPtnrSum_02_15" value="${regPtnrSum_02_15 + vo2.reg02}"></c:set>
		                    <c:set var="regPtnrSum_01_15" value="${regPtnrSum_01_15 + vo2.reg01}"></c:set>
		                    
		                    <!-- Type 합계 누적 -->
		                    <c:set var="regTotalSum_12_15" value="${regTotalSum_12_15 + vo2.reg12}"></c:set>
		                    <c:set var="regTotalSum_11_15" value="${regTotalSum_11_15 + vo2.reg11}"></c:set>
		                    <c:set var="regTotalSum_10_15" value="${regTotalSum_10_15 + vo2.reg10}"></c:set>
		                    <c:set var="regTotalSum_09_15" value="${regTotalSum_09_15 + vo2.reg09}"></c:set>
		                    <c:set var="regTotalSum_08_15" value="${regTotalSum_08_15 + vo2.reg08}"></c:set>
		                    <c:set var="regTotalSum_07_15" value="${regTotalSum_07_15 + vo2.reg07}"></c:set>
		                    <c:set var="regTotalSum_06_15" value="${regTotalSum_06_15 + vo2.reg06}"></c:set>
		                    <c:set var="regTotalSum_05_15" value="${regTotalSum_05_15 + vo2.reg05}"></c:set>
		                    <c:set var="regTotalSum_04_15" value="${regTotalSum_04_15 + vo2.reg04}"></c:set>
		                    <c:set var="regTotalSum_03_15" value="${regTotalSum_03_15 + vo2.reg03}"></c:set>
		                    <c:set var="regTotalSum_02_15" value="${regTotalSum_02_15 + vo2.reg02}"></c:set>
		                    <c:set var="regTotalSum_01_15" value="${regTotalSum_01_15 + vo2.reg01}"></c:set>
                    	</c:otherwise>
                    </c:choose>
                    <!-- 가로 합계 -->
                    <c:set var="regColSum_15" value="${reg12_15 + reg11_15 + reg10_15 + reg09_15 + reg08_15 + reg07_15 + reg06_15 + reg05_15 + reg04_15 + reg03_15 + reg02_15 + reg01_15}"></c:set>
					
					<c:choose>
						<c:when test='${vo2.periodFlagNm == "소계"}'>
							<!-- reg12 -->
		                    <td style="width: 80px;border-left:0.2em solid #b9b9b9 !important;" class="sum-level-1">${reg12_15}</td>
		                    <!-- reg11 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg11_15}</td>
		                    <!-- reg10 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg10_15}</td>
		                    <!-- reg09 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg09_15}</td>
		                    <!-- reg08 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg08_15}</td>
		                    <!-- reg07 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg07_15}</td>
		                    <!-- reg06 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg06_15}</td>
		                    <!-- reg05 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg05_15}</td>
		                    <!-- reg04 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg04_15}</td>
		                    <!-- reg03 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg03_15}</td>
		                    <!-- reg02 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg02_15}</td>
		                    <!-- reg01 -->
		                    <td style="width: 80px;" class="sum-level-1">${reg01_15}</td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 80px;" class="sum-level-1">${regColSum_15}</td>
						</c:when>
						<c:otherwise>
							<!-- reg12 -->
		                    <td style="width: 80px;border-left:0.2em solid #b9b9b9 !important;">${reg12_15}</td>
		                    <!-- reg11 -->
		                    <td style="width: 80px;">${reg11_15}</td>
		                    <!-- reg10 -->
		                    <td style="width: 80px;">${reg10_15}</td>
		                    <!-- reg09 -->
		                    <td style="width: 80px;">${reg09_15}</td>
		                    <!-- reg08 -->
		                    <td style="width: 80px;">${reg08_15}</td>
		                    <!-- reg07 -->
		                    <td style="width: 80px;">${reg07_15}</td>
		                    <!-- reg06 -->
		                    <td style="width: 80px;">${reg06_15}</td>
		                    <!-- reg05 -->
		                    <td style="width: 80px;">${reg05_15}</td>
		                    <!-- reg04 -->
		                    <td style="width: 80px;">${reg04_15}</td>
		                    <!-- reg03 -->
		                    <td style="width: 80px;">${reg03_15}</td>
		                    <!-- reg02 -->
		                    <td style="width: 80px;">${reg02_15}</td>
		                    <!-- reg01 -->
		                    <td style="width: 80px;">${reg01_15}</td>
		                    <!-- 가로 합계 -->                                        
		                    <td style="width: 80px;">${regColSum_15}</td>
						</c:otherwise>
					</c:choose>
                    
                    <!-- 소계로 표시 이후는  소계 합산값 변수를 초기화 한다.-->
                    <c:if test="${vo2.periodFlagCode == 3}">
                    	<c:set var="regPeriodSum_12_15" value="0"></c:set>
			            <c:set var="regPeriodSum_11_15" value="0"></c:set>
			            <c:set var="regPeriodSum_10_15" value="0"></c:set>
			            <c:set var="regPeriodSum_09_15" value="0"></c:set>
			            <c:set var="regPeriodSum_08_15" value="0"></c:set>
			            <c:set var="regPeriodSum_07_15" value="0"></c:set>
			            <c:set var="regPeriodSum_06_15" value="0"></c:set>
			            <c:set var="regPeriodSum_05_15" value="0"></c:set>
			            <c:set var="regPeriodSum_04_15" value="0"></c:set>
			            <c:set var="regPeriodSum_03_15" value="0"></c:set>
			            <c:set var="regPeriodSum_02_15" value="0"></c:set>
			            <c:set var="regPeriodSum_01_15" value="0"></c:set>
                    </c:if>
                </tr>
                <!-- 보험사 별 소계 시작 -->
                <c:if test="${vo2.ptnrRowCnt > 1}">
                	<c:if test="${vo2.ptnrRowCnt == ptnrSubRow}">
                		<!-- 보험사가 변경되면 소계 항목도 초기화한다. -->
                		<c:set var="regPeriodSum_12_15" value="0"></c:set>
			            <c:set var="regPeriodSum_11_15" value="0"></c:set>
			            <c:set var="regPeriodSum_10_15" value="0"></c:set>
			            <c:set var="regPeriodSum_09_15" value="0"></c:set>
			            <c:set var="regPeriodSum_08_15" value="0"></c:set>
			            <c:set var="regPeriodSum_07_15" value="0"></c:set>
			            <c:set var="regPeriodSum_06_15" value="0"></c:set>
			            <c:set var="regPeriodSum_05_15" value="0"></c:set>
			            <c:set var="regPeriodSum_04_15" value="0"></c:set>
			            <c:set var="regPeriodSum_03_15" value="0"></c:set>
			            <c:set var="regPeriodSum_02_15" value="0"></c:set>
			            <c:set var="regPeriodSum_01_15" value="0"></c:set>
                		<tr>
	                		<td colspan="2" class="sum-level-2">계</td>
	                		<!-- reg12 -->
		                    <td style="border-left:0.2em solid #b9b9b9 !important;"  class="sum-level-2">${regPtnrSum_12_15}</td>
		                    <!-- reg11 -->
		                    <td class="sum-level-2">${regPtnrSum_11_15}</td>
		                    <!-- reg10 -->
		                    <td class="sum-level-2">${regPtnrSum_10_15}</td>
		                    <!-- reg09 -->
		                    <td class="sum-level-2">${regPtnrSum_09_15}</td>
		                    <!-- reg08 -->
		                    <td class="sum-level-2">${regPtnrSum_08_15}</td>
		                    <!-- reg07 -->
		                    <td class="sum-level-2">${regPtnrSum_07_15}</td>
		                    <!-- reg06 -->
		                    <td class="sum-level-2">${regPtnrSum_06_15}</td>
		                    <!-- reg05 -->
		                    <td class="sum-level-2">${regPtnrSum_05_15}</td>
		                    <!-- reg04 -->
		                    <td class="sum-level-2">${regPtnrSum_04_15}</td>
		                    <!-- reg03 -->
		                    <td class="sum-level-2">${regPtnrSum_03_15}</td>
		                    <!-- reg02 -->
		                    <td class="sum-level-2">${regPtnrSum_02_15}</td>
		                    <!-- reg01 -->
		                    <td class="sum-level-2">${regPtnrSum_01_15}</td>
		                    <!-- 가로열 합계 -->
		                    <c:set var="regPtnrColSum_15" value="${regPtnrSum_12_15 + regPtnrSum_11_15 + regPtnrSum_10_15 + regPtnrSum_09_15 + regPtnrSum_08_15 + regPtnrSum_07_15 + regPtnrSum_06_15 + regPtnrSum_05_15 + regPtnrSum_04_15 + regPtnrSum_03_15 + regPtnrSum_02_15 + regPtnrSum_01_15}"></c:set>
		                    <td class="sum-level-2">${regPtnrColSum_15}</td>
						</tr>						
                	</c:if>                	
                </c:if>                           
                <!-- 보험사 별 소계 끝 -->                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="4" style="height:25px;">1종 기타 소계</th>
                <!-- reg12 -->
                <th>${regTotalSum_12_15}</th>
                <!-- reg11 -->
                <th>${regTotalSum_11_15}</th>
                <!-- reg10 -->
                <th>${regTotalSum_10_15}</th>
                <!-- reg09 -->
                <th>${regTotalSum_09_15}</th>
                <!-- reg08 -->
                <th>${regTotalSum_08_15}</th>
                <!-- reg07 -->
                <th>${regTotalSum_07_15}</th>
                <!-- reg06 -->
                <th>${regTotalSum_06_15}</th>
                <!-- reg05 -->
                <th>${regTotalSum_05_15}</th>
                <!-- reg04 -->
                <th>${regTotalSum_04_15}</th>
                <!-- reg03 -->
                <th>${regTotalSum_03_15}</th>
                <!-- reg02 -->
                <th>${regTotalSum_02_15}</th>
                <!-- reg01 -->
                <th>${regTotalSum_01_15}</th>
                <!-- 가로열 합계 -->
                <c:set var="regColTotalSum_15" value="${regTotalSum_12_15 + regTotalSum_11_15 + regTotalSum_10_15 + regTotalSum_09_15 + regTotalSum_08_15 + regTotalSum_07_15 + regTotalSum_06_15 + regTotalSum_05_15 + regTotalSum_04_15 + regTotalSum_03_15 + regTotalSum_02_15 + regTotalSum_01_15}"></c:set>
                <th>${regColTotalSum_15}</th>
            </tr>						
			</tbody>
		</table>		
		<!-- 1종 기타 끝 -->
    </div>    
    <!-- 총 합계 시작 -->
    <!-- 총 합계 변수 시작 -->
    <c:set var="regTotalSum_12_all" value="${regTotalSum_12_5 + regTotalSum_12_10 + regTotalSum_12_15}"></c:set>
    <c:set var="regTotalSum_11_all" value="${regTotalSum_11_5 + regTotalSum_11_10 + regTotalSum_11_15}"></c:set>
    <c:set var="regTotalSum_10_all" value="${regTotalSum_10_5 + regTotalSum_10_10 + regTotalSum_10_15}"></c:set>
    <c:set var="regTotalSum_09_all" value="${regTotalSum_09_5 + regTotalSum_09_10 + regTotalSum_09_15}"></c:set>
    <c:set var="regTotalSum_08_all" value="${regTotalSum_08_5 + regTotalSum_08_10 + regTotalSum_08_15}"></c:set>
    <c:set var="regTotalSum_07_all" value="${regTotalSum_07_5 + regTotalSum_07_10 + regTotalSum_07_15}"></c:set>
    <c:set var="regTotalSum_06_all" value="${regTotalSum_06_5 + regTotalSum_06_10 + regTotalSum_06_15}"></c:set>
    <c:set var="regTotalSum_05_all" value="${regTotalSum_05_5 + regTotalSum_05_10 + regTotalSum_05_15}"></c:set>
    <c:set var="regTotalSum_04_all" value="${regTotalSum_04_5 + regTotalSum_04_10 + regTotalSum_04_15}"></c:set>
    <c:set var="regTotalSum_03_all" value="${regTotalSum_03_5 + regTotalSum_03_10 + regTotalSum_03_15}"></c:set>
    <c:set var="regTotalSum_02_all" value="${regTotalSum_02_5 + regTotalSum_02_10 + regTotalSum_02_15}"></c:set>
    <c:set var="regTotalSum_01_all" value="${regTotalSum_01_5 + regTotalSum_01_10 + regTotalSum_01_15}"></c:set>        
    <c:set var="regTotalSum_col_all" value="${regTotalSum_12_all + regTotalSum_11_all + regTotalSum_10_all + regTotalSum_09_all + regTotalSum_08_all + regTotalSum_07_all + regTotalSum_06_all + regTotalSum_05_all + regTotalSum_04_all + regTotalSum_03_all + regTotalSum_02_all + regTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체합계</th>
                <th style="width: 80px;color:blue;">${regTotalSum_12_all}</th>
                <th style="width: 80px;color:blue;">${regTotalSum_11_all}</th>
                <th style="width: 80px;color:blue;">${regTotalSum_10_all}</th>
                <th style="width: 80px;color:blue;">${regTotalSum_09_all}</th>
                <th style="width: 80px;color:blue;">${regTotalSum_08_all}</th>
                <th style="width: 80px;color:blue;">${regTotalSum_07_all}</th>
                <th style="width: 80px;color:blue;">${regTotalSum_06_all}</th>
                <th style="width: 80px;color:blue;">${regTotalSum_05_all}</th>
                <th style="width: 80px;color:blue;">${regTotalSum_04_all}</th>
                <th style="width: 80px;color:blue;">${regTotalSum_03_all}</th>
                <th style="width: 80px;color:blue;">${regTotalSum_02_all}</th>
                <th style="width: 80px;color:blue;">${regTotalSum_01_all}</th>
				<th style="width: 80px;color:blue;">${regTotalSum_col_all}</th>
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>
