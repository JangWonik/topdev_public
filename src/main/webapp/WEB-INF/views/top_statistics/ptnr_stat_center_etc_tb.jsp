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
                <th style="width: 150px;">센터명</th>
                <th style="width: 150px;">구분</th>                
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
   				<!-- 센터별 계를 만들기 위한 변수 -->
   				<c:set var="centerCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 센터명 -->
   				<c:set var="preCenterName" value=""></c:set>
   				
   				<!-- 센터별 계 -->
	            <c:set var="etcCenterSum_12_5" value="0"></c:set>
	            <c:set var="etcCenterSum_11_5" value="0"></c:set>
	            <c:set var="etcCenterSum_10_5" value="0"></c:set>
	            <c:set var="etcCenterSum_09_5" value="0"></c:set>
	            <c:set var="etcCenterSum_08_5" value="0"></c:set>
	            <c:set var="etcCenterSum_07_5" value="0"></c:set>
	            <c:set var="etcCenterSum_06_5" value="0"></c:set>
	            <c:set var="etcCenterSum_05_5" value="0"></c:set>
	            <c:set var="etcCenterSum_04_5" value="0"></c:set>
	            <c:set var="etcCenterSum_03_5" value="0"></c:set>
	            <c:set var="etcCenterSum_02_5" value="0"></c:set>
	            <c:set var="etcCenterSum_01_5" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="etcCenterTotalSum_12_5" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_11_5" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_10_5" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_09_5" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_08_5" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_07_5" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_06_5" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_05_5" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_04_5" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_03_5" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_02_5" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_01_5" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="etcColCenterTotalSum_5" value="0"></c:set>
   				    			
    			<c:forEach var="vo" items="${ptnrStatEtcList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatEtc');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
		                    	1종 조사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>
		                		<td style="width:150px;">${vo.ptnrIdSubNm}</td>
		                		<!-- 센터별 계 초기화 -->
					            <c:set var="etcCenterSum_12_5" value="0"></c:set>
					            <c:set var="etcCenterSum_11_5" value="0"></c:set>
					            <c:set var="etcCenterSum_10_5" value="0"></c:set>
					            <c:set var="etcCenterSum_09_5" value="0"></c:set>
					            <c:set var="etcCenterSum_08_5" value="0"></c:set>
					            <c:set var="etcCenterSum_07_5" value="0"></c:set>
					            <c:set var="etcCenterSum_06_5" value="0"></c:set>
					            <c:set var="etcCenterSum_05_5" value="0"></c:set>
					            <c:set var="etcCenterSum_04_5" value="0"></c:set>
					            <c:set var="etcCenterSum_03_5" value="0"></c:set>
					            <c:set var="etcCenterSum_02_5" value="0"></c:set>
					            <c:set var="etcCenterSum_01_5" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${centerCnt == 1 and vo.centerName != preCenterName}">
		                				<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${vo.rowCnt+1}">${vo.centerName}</td>
		                				<td style="width:150px;">${vo.ptnrIdSubNm}</td>		                				
		                				<c:set var="preCenterName" value="${vo.centerName}"></c:set>
		                			</c:when>
		                			<c:otherwise>		                				
	                					<td style="width:150px;">${vo.ptnrIdSubNm}</td>	                					
		                			</c:otherwise>
		                		</c:choose>                				               		      		
		                	</c:otherwise>
		                </c:choose>
		                <!-- 각 수임건 -->    		
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
			            
			            <!-- etc12 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${etc12_5}" pattern="#,##0.##"/></td>
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
		                <c:set var="etcColSum_5" value="${etc12_5 + etc11_5 + etc10_5 + etc09_5 + etc08_5 + etc07_5 + etc06_5 + etc05_5 + etc04_5 + etc03_5 + etc02_5 + etc01_5}"></c:set>                    
		                <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcColSum_5}" pattern="#,##0.##"/></td>
		                
		                <!-- 센터별 계 합산 -->
	    				<c:set var="etcCenterSum_12_5" value="${etcCenterSum_12_5+etc12_5}"></c:set>
			            <c:set var="etcCenterSum_11_5" value="${etcCenterSum_11_5+etc11_5}"></c:set>
			            <c:set var="etcCenterSum_10_5" value="${etcCenterSum_10_5+etc10_5}"></c:set>
			            <c:set var="etcCenterSum_09_5" value="${etcCenterSum_09_5+etc09_5}"></c:set>
			            <c:set var="etcCenterSum_08_5" value="${etcCenterSum_08_5+etc08_5}"></c:set>
			            <c:set var="etcCenterSum_07_5" value="${etcCenterSum_07_5+etc07_5}"></c:set>
			            <c:set var="etcCenterSum_06_5" value="${etcCenterSum_06_5+etc06_5}"></c:set>
			            <c:set var="etcCenterSum_05_5" value="${etcCenterSum_05_5+etc05_5}"></c:set>
			            <c:set var="etcCenterSum_04_5" value="${etcCenterSum_04_5+etc04_5}"></c:set>
			            <c:set var="etcCenterSum_03_5" value="${etcCenterSum_03_5+etc03_5}"></c:set>
			            <c:set var="etcCenterSum_02_5" value="${etcCenterSum_02_5+etc02_5}"></c:set>
			            <c:set var="etcCenterSum_01_5" value="${etcCenterSum_01_5+etc01_5}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="etcCenterTotalSum_12_5" value="${etcCenterTotalSum_12_5 + etc12_5}"></c:set>
	                    <c:set var="etcCenterTotalSum_11_5" value="${etcCenterTotalSum_11_5 + etc11_5}"></c:set>
	                    <c:set var="etcCenterTotalSum_10_5" value="${etcCenterTotalSum_10_5 + etc10_5}"></c:set>
	                    <c:set var="etcCenterTotalSum_09_5" value="${etcCenterTotalSum_09_5 + etc09_5}"></c:set>
	                    <c:set var="etcCenterTotalSum_08_5" value="${etcCenterTotalSum_08_5 + etc08_5}"></c:set>
	                    <c:set var="etcCenterTotalSum_07_5" value="${etcCenterTotalSum_07_5 + etc07_5}"></c:set>
	                    <c:set var="etcCenterTotalSum_06_5" value="${etcCenterTotalSum_06_5 + etc06_5}"></c:set>
	                    <c:set var="etcCenterTotalSum_05_5" value="${etcCenterTotalSum_05_5 + etc05_5}"></c:set>
	                    <c:set var="etcCenterTotalSum_04_5" value="${etcCenterTotalSum_04_5 + etc04_5}"></c:set>
	                    <c:set var="etcCenterTotalSum_03_5" value="${etcCenterTotalSum_03_5 + etc03_5}"></c:set>
	                    <c:set var="etcCenterTotalSum_02_5" value="${etcCenterTotalSum_02_5 + etc02_5}"></c:set>
	                    <c:set var="etcCenterTotalSum_01_5" value="${etcCenterTotalSum_01_5 + etc01_5}"></c:set>
		    		</tr>
		    		<!-- 센터별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${centerCnt == vo.rowCnt and vo.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- etc12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_12_5}" pattern="#,##0.##"/></td>
			                <!-- etc11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_11_5}" pattern="#,##0.##"/></td>
			                <!-- etc10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_10_5}" pattern="#,##0.##"/></td>
			                <!-- etc09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_09_5}" pattern="#,##0.##"/></td>
			                <!-- etc08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_08_5}" pattern="#,##0.##"/></td>
			                <!-- etc07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_07_5}" pattern="#,##0.##"/></td>
			                <!-- etc06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_06_5}" pattern="#,##0.##"/></td>
			                <!-- etc05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_05_5}" pattern="#,##0.##"/></td>
			                <!-- etc04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_04_5}" pattern="#,##0.##"/></td>
			                <!-- etc03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_03_5}" pattern="#,##0.##"/></td>
			                <!-- etc02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_02_5}" pattern="#,##0.##"/></td>
			                <!-- etc01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_01_5}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="etcCenterColSum_5" value="${etcCenterSum_12_5 + etcCenterSum_11_5 + etcCenterSum_10_5 + etcCenterSum_09_5 + etcCenterSum_08_5 + etcCenterSum_07_5 + etcCenterSum_06_5 + etcCenterSum_05_5 + etcCenterSum_04_5 + etcCenterSum_03_5 + etcCenterSum_02_5 + etcCenterSum_01_5}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterColSum_5}" pattern="#,##0.##"/></td>
			                
							<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>										                		    				
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="etcCenterSum_12_5" value="0"></c:set>
				            <c:set var="etcCenterSum_11_5" value="0"></c:set>
				            <c:set var="etcCenterSum_10_5" value="0"></c:set>
				            <c:set var="etcCenterSum_09_5" value="0"></c:set>
				            <c:set var="etcCenterSum_08_5" value="0"></c:set>
				            <c:set var="etcCenterSum_07_5" value="0"></c:set>
				            <c:set var="etcCenterSum_06_5" value="0"></c:set>
				            <c:set var="etcCenterSum_05_5" value="0"></c:set>
				            <c:set var="etcCenterSum_04_5" value="0"></c:set>
				            <c:set var="etcCenterSum_03_5" value="0"></c:set>
				            <c:set var="etcCenterSum_02_5" value="0"></c:set>
				            <c:set var="etcCenterSum_01_5" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo.rowCnt == 1}">
		    				<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="etcCenterSum_12_5" value="0"></c:set>
				            <c:set var="etcCenterSum_11_5" value="0"></c:set>
				            <c:set var="etcCenterSum_10_5" value="0"></c:set>
				            <c:set var="etcCenterSum_09_5" value="0"></c:set>
				            <c:set var="etcCenterSum_08_5" value="0"></c:set>
				            <c:set var="etcCenterSum_07_5" value="0"></c:set>
				            <c:set var="etcCenterSum_06_5" value="0"></c:set>
				            <c:set var="etcCenterSum_05_5" value="0"></c:set>
				            <c:set var="etcCenterSum_04_5" value="0"></c:set>
				            <c:set var="etcCenterSum_03_5" value="0"></c:set>
				            <c:set var="etcCenterSum_02_5" value="0"></c:set>
				            <c:set var="etcCenterSum_01_5" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 센터별 계 카운트 증가 -->
		    				<c:set var="centerCnt" value="${centerCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 센터별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 조사 소계 시작 -->
		    	<c:if test="${ptnrStatEtcList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 조사 소계</th>
	                <!-- etc12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_12_5}" pattern="#,##0.##"/></th>
	                <!-- etc11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_11_5}" pattern="#,##0.##"/></th>
	                <!-- etc10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_10_5}" pattern="#,##0.##"/></th>
	                <!-- etc09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_09_5}" pattern="#,##0.##"/></th>
	                <!-- etc08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_08_5}" pattern="#,##0.##"/></th>
	                <!-- etc07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_07_5}" pattern="#,##0.##"/></th>
	                <!-- etc06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_06_5}" pattern="#,##0.##"/></th>
	                <!-- etc05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_05_5}" pattern="#,##0.##"/></th>
	                <!-- etc04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_04_5}" pattern="#,##0.##"/></th>
	                <!-- etc03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_03_5}" pattern="#,##0.##"/></th>
	                <!-- etc02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_02_5}" pattern="#,##0.##"/></th>
	                <!-- etc01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_01_5}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="etcColTotalSum_5" value="${etcCenterTotalSum_12_5 + etcCenterTotalSum_11_5 + etcCenterTotalSum_10_5 + etcCenterTotalSum_09_5 + etcCenterTotalSum_08_5 + etcCenterTotalSum_07_5 + etcCenterTotalSum_06_5 + etcCenterTotalSum_05_5 + etcCenterTotalSum_04_5 + etcCenterTotalSum_03_5 + etcCenterTotalSum_02_5 + etcCenterTotalSum_01_5}"></c:set>
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcColTotalSum_5}" pattern="#,##0.##"/></th>	                
	            </tr>
	            </c:if>
		    	<!-- 1종 조사 소계 끝 -->
    		</tbody>
    	</table>    	    	
    	<!-- 1종 조사 끝 -->
    	
    	<!-- 1종 심사 시작 -->
    	<table>
    		<tbody>
   				<!-- 센터별 계를 만들기 위한 변수 -->
   				<c:set var="centerCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 센터명 -->
   				<c:set var="preCenterName" value=""></c:set>
   				
   				<!-- 센터별 계 -->
	            <c:set var="etcCenterSum_12_10" value="0"></c:set>
	            <c:set var="etcCenterSum_11_10" value="0"></c:set>
	            <c:set var="etcCenterSum_10_10" value="0"></c:set>
	            <c:set var="etcCenterSum_09_10" value="0"></c:set>
	            <c:set var="etcCenterSum_08_10" value="0"></c:set>
	            <c:set var="etcCenterSum_07_10" value="0"></c:set>
	            <c:set var="etcCenterSum_06_10" value="0"></c:set>
	            <c:set var="etcCenterSum_05_10" value="0"></c:set>
	            <c:set var="etcCenterSum_04_10" value="0"></c:set>
	            <c:set var="etcCenterSum_03_10" value="0"></c:set>
	            <c:set var="etcCenterSum_02_10" value="0"></c:set>
	            <c:set var="etcCenterSum_01_10" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="etcCenterTotalSum_12_10" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_11_10" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_10_10" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_09_10" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_08_10" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_07_10" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_06_10" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_05_10" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_04_10" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_03_10" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_02_10" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_01_10" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="etcColCenterTotalSum_10" value="0"></c:set>
   				    			
    			<c:forEach var="vo1" items="${ptnrStatEtcList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatEtc');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
		                    	1종 심사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo1.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>
		                		<td style="width:150px;">${vo1.ptnrIdSubNm}</td>
		                		<!-- 센터별 계 초기화 -->
					            <c:set var="etcCenterSum_12_10" value="0"></c:set>
					            <c:set var="etcCenterSum_11_10" value="0"></c:set>
					            <c:set var="etcCenterSum_10_10" value="0"></c:set>
					            <c:set var="etcCenterSum_09_10" value="0"></c:set>
					            <c:set var="etcCenterSum_08_10" value="0"></c:set>
					            <c:set var="etcCenterSum_07_10" value="0"></c:set>
					            <c:set var="etcCenterSum_06_10" value="0"></c:set>
					            <c:set var="etcCenterSum_05_10" value="0"></c:set>
					            <c:set var="etcCenterSum_04_10" value="0"></c:set>
					            <c:set var="etcCenterSum_03_10" value="0"></c:set>
					            <c:set var="etcCenterSum_02_10" value="0"></c:set>
					            <c:set var="etcCenterSum_01_10" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${centerCnt == 1 and vo1.centerName != preCenterName}">
		                				<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${vo1.rowCnt+1}">${vo1.centerName}</td>
		                				<td style="width:150px;">${vo1.ptnrIdSubNm}</td>		                				
		                				<c:set var="preCenterName" value="${vo1.centerName}"></c:set>
		                			</c:when>
		                			<c:otherwise>		                				
	                					<td style="width:150px;">${vo1.ptnrIdSubNm}</td>	                					
		                			</c:otherwise>
		                		</c:choose>                				               		      		
		                	</c:otherwise>
		                </c:choose>
		                <!-- 각 수임건 -->    		
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
			            
			            <!-- etc12 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${etc12_10}" pattern="#,##0.##"/></td>
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
	                    <c:set var="etcColSum_10" value="${etc12_10 + etc11_10 + etc10_10 + etc09_10 + etc08_10 + etc07_10 + etc06_10 + etc05_10 + etc04_10 + etc03_10 + etc02_10 + etc01_10}"></c:set>                    
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcColSum_10}" pattern="#,##0.##"/></td>
		                
		                <!-- 센터별 계 합산 -->
	    				<c:set var="etcCenterSum_12_10" value="${etcCenterSum_12_10+etc12_10}"></c:set>
			            <c:set var="etcCenterSum_11_10" value="${etcCenterSum_11_10+etc11_10}"></c:set>
			            <c:set var="etcCenterSum_10_10" value="${etcCenterSum_10_10+etc10_10}"></c:set>
			            <c:set var="etcCenterSum_09_10" value="${etcCenterSum_09_10+etc09_10}"></c:set>
			            <c:set var="etcCenterSum_08_10" value="${etcCenterSum_08_10+etc08_10}"></c:set>
			            <c:set var="etcCenterSum_07_10" value="${etcCenterSum_07_10+etc07_10}"></c:set>
			            <c:set var="etcCenterSum_06_10" value="${etcCenterSum_06_10+etc06_10}"></c:set>
			            <c:set var="etcCenterSum_05_10" value="${etcCenterSum_05_10+etc05_10}"></c:set>
			            <c:set var="etcCenterSum_04_10" value="${etcCenterSum_04_10+etc04_10}"></c:set>
			            <c:set var="etcCenterSum_03_10" value="${etcCenterSum_03_10+etc03_10}"></c:set>
			            <c:set var="etcCenterSum_02_10" value="${etcCenterSum_02_10+etc02_10}"></c:set>
			            <c:set var="etcCenterSum_01_10" value="${etcCenterSum_01_10+etc01_10}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="etcCenterTotalSum_12_10" value="${etcCenterTotalSum_12_10 + etc12_10}"></c:set>
	                    <c:set var="etcCenterTotalSum_11_10" value="${etcCenterTotalSum_11_10 + etc11_10}"></c:set>
	                    <c:set var="etcCenterTotalSum_10_10" value="${etcCenterTotalSum_10_10 + etc10_10}"></c:set>
	                    <c:set var="etcCenterTotalSum_09_10" value="${etcCenterTotalSum_09_10 + etc09_10}"></c:set>
	                    <c:set var="etcCenterTotalSum_08_10" value="${etcCenterTotalSum_08_10 + etc08_10}"></c:set>
	                    <c:set var="etcCenterTotalSum_07_10" value="${etcCenterTotalSum_07_10 + etc07_10}"></c:set>
	                    <c:set var="etcCenterTotalSum_06_10" value="${etcCenterTotalSum_06_10 + etc06_10}"></c:set>
	                    <c:set var="etcCenterTotalSum_05_10" value="${etcCenterTotalSum_05_10 + etc05_10}"></c:set>
	                    <c:set var="etcCenterTotalSum_04_10" value="${etcCenterTotalSum_04_10 + etc04_10}"></c:set>
	                    <c:set var="etcCenterTotalSum_03_10" value="${etcCenterTotalSum_03_10 + etc03_10}"></c:set>
	                    <c:set var="etcCenterTotalSum_02_10" value="${etcCenterTotalSum_02_10 + etc02_10}"></c:set>
	                    <c:set var="etcCenterTotalSum_01_10" value="${etcCenterTotalSum_01_10 + etc01_10}"></c:set>
		    		</tr>
		    		<!-- 센터별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${centerCnt == vo1.rowCnt and vo1.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- etc12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_12_10}" pattern="#,##0.##"/></td>
			                <!-- etc11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_11_10}" pattern="#,##0.##"/></td>
			                <!-- etc10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_10_10}" pattern="#,##0.##"/></td>
			                <!-- etc09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_09_10}" pattern="#,##0.##"/></td>
			                <!-- etc08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_08_10}" pattern="#,##0.##"/></td>
			                <!-- etc07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_07_10}" pattern="#,##0.##"/></td>
			                <!-- etc06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_06_10}" pattern="#,##0.##"/></td>
			                <!-- etc05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_05_10}" pattern="#,##0.##"/></td>
			                <!-- etc04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_04_10}" pattern="#,##0.##"/></td>
			                <!-- etc03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_03_10}" pattern="#,##0.##"/></td>
			                <!-- etc02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_02_10}" pattern="#,##0.##"/></td>
			                <!-- etc01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_01_10}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="etcCenterColSum_10" value="${etcCenterSum_12_10 + etcCenterSum_11_10 + etcCenterSum_10_10 + etcCenterSum_09_10 + etcCenterSum_08_10 + etcCenterSum_07_10 + etcCenterSum_06_10 + etcCenterSum_05_10 + etcCenterSum_04_10 + etcCenterSum_03_10 + etcCenterSum_02_10 + etcCenterSum_01_10}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterColSum_10}" pattern="#,##0.##"/></td>
			                
							<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>										                		    				
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="etcCenterSum_12_10" value="0"></c:set>
				            <c:set var="etcCenterSum_11_10" value="0"></c:set>
				            <c:set var="etcCenterSum_10_10" value="0"></c:set>
				            <c:set var="etcCenterSum_09_10" value="0"></c:set>
				            <c:set var="etcCenterSum_08_10" value="0"></c:set>
				            <c:set var="etcCenterSum_07_10" value="0"></c:set>
				            <c:set var="etcCenterSum_06_10" value="0"></c:set>
				            <c:set var="etcCenterSum_05_10" value="0"></c:set>
				            <c:set var="etcCenterSum_04_10" value="0"></c:set>
				            <c:set var="etcCenterSum_03_10" value="0"></c:set>
				            <c:set var="etcCenterSum_02_10" value="0"></c:set>
				            <c:set var="etcCenterSum_01_10" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo1.rowCnt == 1}">
		    				<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="etcCenterSum_12_10" value="0"></c:set>
				            <c:set var="etcCenterSum_11_10" value="0"></c:set>
				            <c:set var="etcCenterSum_10_10" value="0"></c:set>
				            <c:set var="etcCenterSum_09_10" value="0"></c:set>
				            <c:set var="etcCenterSum_08_10" value="0"></c:set>
				            <c:set var="etcCenterSum_07_10" value="0"></c:set>
				            <c:set var="etcCenterSum_06_10" value="0"></c:set>
				            <c:set var="etcCenterSum_05_10" value="0"></c:set>
				            <c:set var="etcCenterSum_04_10" value="0"></c:set>
				            <c:set var="etcCenterSum_03_10" value="0"></c:set>
				            <c:set var="etcCenterSum_02_10" value="0"></c:set>
				            <c:set var="etcCenterSum_01_10" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 센터별 계 카운트 증가 -->
		    				<c:set var="centerCnt" value="${centerCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 센터별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 심사 소계 시작 -->
		    	<c:if test="${ptnrStatEtcList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 심사 소계</th>
	                <!-- etc12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_12_10}" pattern="#,##0.##"/></th>
	                <!-- etc11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_11_10}" pattern="#,##0.##"/></th>
	                <!-- etc10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_10_10}" pattern="#,##0.##"/></th>
	                <!-- etc09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_09_10}" pattern="#,##0.##"/></th>
	                <!-- etc08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_08_10}" pattern="#,##0.##"/></th>
	                <!-- etc07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_07_10}" pattern="#,##0.##"/></th>
	                <!-- etc06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_06_10}" pattern="#,##0.##"/></th>
	                <!-- etc05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_05_10}" pattern="#,##0.##"/></th>
	                <!-- etc04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_04_10}" pattern="#,##0.##"/></th>
	                <!-- etc03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_03_10}" pattern="#,##0.##"/></th>
	                <!-- etc02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_02_10}" pattern="#,##0.##"/></th>
	                <!-- etc01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_01_10}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="etcColTotalSum_10" value="${etcCenterTotalSum_12_10 + etcCenterTotalSum_11_10 + etcCenterTotalSum_10_10 + etcCenterTotalSum_09_10 + etcCenterTotalSum_08_10 + etcCenterTotalSum_07_10 + etcCenterTotalSum_06_10 + etcCenterTotalSum_05_10 + etcCenterTotalSum_04_10 + etcCenterTotalSum_03_10 + etcCenterTotalSum_02_10 + etcCenterTotalSum_01_10}"></c:set>
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcColTotalSum_10}" pattern="#,##0.##"/></th>	                
	            </tr>
	            </c:if>
		    	<!-- 1종 심사 소계 끝 -->
    		</tbody>
    	</table>    	
    	<!-- 1종 심사 끝 -->  
    	
    	<!-- 1종 기타 시작 -->
    	<table>
    		<tbody>
   				<!-- 센터별 계를 만들기 위한 변수 -->
   				<c:set var="centerCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 센터명 -->
   				<c:set var="preCenterName" value=""></c:set>
   				
   				<!-- 센터별 계 -->
	            <c:set var="etcCenterSum_12_15" value="0"></c:set>
	            <c:set var="etcCenterSum_11_15" value="0"></c:set>
	            <c:set var="etcCenterSum_10_15" value="0"></c:set>
	            <c:set var="etcCenterSum_09_15" value="0"></c:set>
	            <c:set var="etcCenterSum_08_15" value="0"></c:set>
	            <c:set var="etcCenterSum_07_15" value="0"></c:set>
	            <c:set var="etcCenterSum_06_15" value="0"></c:set>
	            <c:set var="etcCenterSum_05_15" value="0"></c:set>
	            <c:set var="etcCenterSum_04_15" value="0"></c:set>
	            <c:set var="etcCenterSum_03_15" value="0"></c:set>
	            <c:set var="etcCenterSum_02_15" value="0"></c:set>
	            <c:set var="etcCenterSum_01_15" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="etcCenterTotalSum_12_15" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_11_15" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_10_15" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_09_15" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_08_15" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_07_15" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_06_15" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_05_15" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_04_15" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_03_15" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_02_15" value="0"></c:set>
	            <c:set var="etcCenterTotalSum_01_15" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="etcColCenterTotalSum_15" value="0"></c:set>
   				    			
    			<c:forEach var="vo2" items="${ptnrStatEtcList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatEtc');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
		                    	1종 기타
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo2.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>
		                		<td style="width:150px;">${vo2.ptnrIdSubNm}</td>
		                		<!-- 센터별 계 초기화 -->
					            <c:set var="etcCenterSum_12_15" value="0"></c:set>
					            <c:set var="etcCenterSum_11_15" value="0"></c:set>
					            <c:set var="etcCenterSum_10_15" value="0"></c:set>
					            <c:set var="etcCenterSum_09_15" value="0"></c:set>
					            <c:set var="etcCenterSum_08_15" value="0"></c:set>
					            <c:set var="etcCenterSum_07_15" value="0"></c:set>
					            <c:set var="etcCenterSum_06_15" value="0"></c:set>
					            <c:set var="etcCenterSum_05_15" value="0"></c:set>
					            <c:set var="etcCenterSum_04_15" value="0"></c:set>
					            <c:set var="etcCenterSum_03_15" value="0"></c:set>
					            <c:set var="etcCenterSum_02_15" value="0"></c:set>
					            <c:set var="etcCenterSum_01_15" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${centerCnt == 1 and vo2.centerName != preCenterName}">
		                				<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${vo2.rowCnt+1}">${vo2.centerName}</td>
		                				<td style="width:150px;">${vo2.ptnrIdSubNm}</td>		                				
		                				<c:set var="preCenterName" value="${vo2.centerName}"></c:set>
		                			</c:when>
		                			<c:otherwise>		                				
	                					<td style="width:150px;">${vo2.ptnrIdSubNm}</td>	                					
		                			</c:otherwise>
		                		</c:choose>                				               		      		
		                	</c:otherwise>
		                </c:choose>
		                <!-- 각 수임건 -->    		
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
			            
			            <!-- etc12 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${etc12_15}" pattern="#,##0.##"/></td>
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
	                    <c:set var="etcColSum_15" value="${etc12_15 + etc11_15 + etc10_15 + etc09_15 + etc08_15 + etc07_15 + etc06_15 + etc05_15 + etc04_15 + etc03_15 + etc02_15 + etc01_15}"></c:set>                    
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcColSum_15}" pattern="#,##0.##"/></td>
		                
		                <!-- 센터별 계 합산 -->
	    				<c:set var="etcCenterSum_12_15" value="${etcCenterSum_12_15+etc12_15}"></c:set>
			            <c:set var="etcCenterSum_11_15" value="${etcCenterSum_11_15+etc11_15}"></c:set>
			            <c:set var="etcCenterSum_10_15" value="${etcCenterSum_10_15+etc10_15}"></c:set>
			            <c:set var="etcCenterSum_09_15" value="${etcCenterSum_09_15+etc09_15}"></c:set>
			            <c:set var="etcCenterSum_08_15" value="${etcCenterSum_08_15+etc08_15}"></c:set>
			            <c:set var="etcCenterSum_07_15" value="${etcCenterSum_07_15+etc07_15}"></c:set>
			            <c:set var="etcCenterSum_06_15" value="${etcCenterSum_06_15+etc06_15}"></c:set>
			            <c:set var="etcCenterSum_05_15" value="${etcCenterSum_05_15+etc05_15}"></c:set>
			            <c:set var="etcCenterSum_04_15" value="${etcCenterSum_04_15+etc04_15}"></c:set>
			            <c:set var="etcCenterSum_03_15" value="${etcCenterSum_03_15+etc03_15}"></c:set>
			            <c:set var="etcCenterSum_02_15" value="${etcCenterSum_02_15+etc02_15}"></c:set>
			            <c:set var="etcCenterSum_01_15" value="${etcCenterSum_01_15+etc01_15}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="etcCenterTotalSum_12_15" value="${etcCenterTotalSum_12_15 + etc12_15}"></c:set>
	                    <c:set var="etcCenterTotalSum_11_15" value="${etcCenterTotalSum_11_15 + etc11_15}"></c:set>
	                    <c:set var="etcCenterTotalSum_10_15" value="${etcCenterTotalSum_10_15 + etc10_15}"></c:set>
	                    <c:set var="etcCenterTotalSum_09_15" value="${etcCenterTotalSum_09_15 + etc09_15}"></c:set>
	                    <c:set var="etcCenterTotalSum_08_15" value="${etcCenterTotalSum_08_15 + etc08_15}"></c:set>
	                    <c:set var="etcCenterTotalSum_07_15" value="${etcCenterTotalSum_07_15 + etc07_15}"></c:set>
	                    <c:set var="etcCenterTotalSum_06_15" value="${etcCenterTotalSum_06_15 + etc06_15}"></c:set>
	                    <c:set var="etcCenterTotalSum_05_15" value="${etcCenterTotalSum_05_15 + etc05_15}"></c:set>
	                    <c:set var="etcCenterTotalSum_04_15" value="${etcCenterTotalSum_04_15 + etc04_15}"></c:set>
	                    <c:set var="etcCenterTotalSum_03_15" value="${etcCenterTotalSum_03_15 + etc03_15}"></c:set>
	                    <c:set var="etcCenterTotalSum_02_15" value="${etcCenterTotalSum_02_15 + etc02_15}"></c:set>
	                    <c:set var="etcCenterTotalSum_01_15" value="${etcCenterTotalSum_01_15 + etc01_15}"></c:set>
		    		</tr>
		    		<!-- 센터별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${centerCnt == vo2.rowCnt and vo2.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- etc12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_12_15}" pattern="#,##0.##"/></td>
			                <!-- etc11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_11_15}" pattern="#,##0.##"/></td>
			                <!-- etc10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_10_15}" pattern="#,##0.##"/></td>
			                <!-- etc09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_09_15}" pattern="#,##0.##"/></td>
			                <!-- etc08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_08_15}" pattern="#,##0.##"/></td>
			                <!-- etc07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_07_15}" pattern="#,##0.##"/></td>
			                <!-- etc06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_06_15}" pattern="#,##0.##"/></td>
			                <!-- etc05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_05_15}" pattern="#,##0.##"/></td>
			                <!-- etc04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_04_15}" pattern="#,##0.##"/></td>
			                <!-- etc03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_03_15}" pattern="#,##0.##"/></td>
			                <!-- etc02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_02_15}" pattern="#,##0.##"/></td>
			                <!-- etc01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterSum_01_15}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="etcCenterColSum_15" value="${etcCenterSum_12_15 + etcCenterSum_11_15 + etcCenterSum_10_15 + etcCenterSum_09_15 + etcCenterSum_08_15 + etcCenterSum_07_15 + etcCenterSum_06_15 + etcCenterSum_05_15 + etcCenterSum_04_15 + etcCenterSum_03_15 + etcCenterSum_02_15 + etcCenterSum_01_15}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcCenterColSum_15}" pattern="#,##0.##"/></td>
			                
							<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>										                		    				
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="etcCenterSum_12_15" value="0"></c:set>
				            <c:set var="etcCenterSum_11_15" value="0"></c:set>
				            <c:set var="etcCenterSum_10_15" value="0"></c:set>
				            <c:set var="etcCenterSum_09_15" value="0"></c:set>
				            <c:set var="etcCenterSum_08_15" value="0"></c:set>
				            <c:set var="etcCenterSum_07_15" value="0"></c:set>
				            <c:set var="etcCenterSum_06_15" value="0"></c:set>
				            <c:set var="etcCenterSum_05_15" value="0"></c:set>
				            <c:set var="etcCenterSum_04_15" value="0"></c:set>
				            <c:set var="etcCenterSum_03_15" value="0"></c:set>
				            <c:set var="etcCenterSum_02_15" value="0"></c:set>
				            <c:set var="etcCenterSum_01_15" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo2.rowCnt == 1}">
		    				<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="etcCenterSum_12_15" value="0"></c:set>
				            <c:set var="etcCenterSum_11_15" value="0"></c:set>
				            <c:set var="etcCenterSum_10_15" value="0"></c:set>
				            <c:set var="etcCenterSum_09_15" value="0"></c:set>
				            <c:set var="etcCenterSum_08_15" value="0"></c:set>
				            <c:set var="etcCenterSum_07_15" value="0"></c:set>
				            <c:set var="etcCenterSum_06_15" value="0"></c:set>
				            <c:set var="etcCenterSum_05_15" value="0"></c:set>
				            <c:set var="etcCenterSum_04_15" value="0"></c:set>
				            <c:set var="etcCenterSum_03_15" value="0"></c:set>
				            <c:set var="etcCenterSum_02_15" value="0"></c:set>
				            <c:set var="etcCenterSum_01_15" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 센터별 계 카운트 증가 -->
		    				<c:set var="centerCnt" value="${centerCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 센터별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 기타 소계 시작 -->
		    	<c:if test="${ptnrStatEtcList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 기타 소계</th>
	                <!-- etc12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_12_15}" pattern="#,##0.##"/></th>
	                <!-- etc11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_11_15}" pattern="#,##0.##"/></th>
	                <!-- etc10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_10_15}" pattern="#,##0.##"/></th>
	                <!-- etc09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_09_15}" pattern="#,##0.##"/></th>
	                <!-- etc08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_08_15}" pattern="#,##0.##"/></th>
	                <!-- etc07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_07_15}" pattern="#,##0.##"/></th>
	                <!-- etc06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_06_15}" pattern="#,##0.##"/></th>
	                <!-- etc05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_05_15}" pattern="#,##0.##"/></th>
	                <!-- etc04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_04_15}" pattern="#,##0.##"/></th>
	                <!-- etc03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_03_15}" pattern="#,##0.##"/></th>
	                <!-- etc02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_02_15}" pattern="#,##0.##"/></th>
	                <!-- etc01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcCenterTotalSum_01_15}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="etcColTotalSum_15" value="${etcCenterTotalSum_12_15 + etcCenterTotalSum_11_15 + etcCenterTotalSum_10_15 + etcCenterTotalSum_09_15 + etcCenterTotalSum_08_15 + etcCenterTotalSum_07_15 + etcCenterTotalSum_06_15 + etcCenterTotalSum_05_15 + etcCenterTotalSum_04_15 + etcCenterTotalSum_03_15 + etcCenterTotalSum_02_15 + etcCenterTotalSum_01_15}"></c:set>
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcColTotalSum_15}" pattern="#,##0.##"/></th>	                
	            </tr>
	            </c:if>
		    	<!-- 1종 기타 소계 끝 -->
    		</tbody>
    	</table>
    	<!-- 1종 기타 끝 -->  	        
    </div>    
    <!-- 총 합계 시작 -->
    <!-- 총 합계 변수 시작 -->
    <c:set var="etcCenterTotalSum_12_all" value="${etcCenterTotalSum_12_5 + etcCenterTotalSum_12_10 + etcCenterTotalSum_12_15}"></c:set>
    <c:set var="etcCenterTotalSum_11_all" value="${etcCenterTotalSum_11_5 + etcCenterTotalSum_11_10 + etcCenterTotalSum_11_15}"></c:set>
    <c:set var="etcCenterTotalSum_10_all" value="${etcCenterTotalSum_10_5 + etcCenterTotalSum_10_10 + etcCenterTotalSum_10_15}"></c:set>
    <c:set var="etcCenterTotalSum_09_all" value="${etcCenterTotalSum_09_5 + etcCenterTotalSum_09_10 + etcCenterTotalSum_09_15}"></c:set>
    <c:set var="etcCenterTotalSum_08_all" value="${etcCenterTotalSum_08_5 + etcCenterTotalSum_08_10 + etcCenterTotalSum_08_15}"></c:set>
    <c:set var="etcCenterTotalSum_07_all" value="${etcCenterTotalSum_07_5 + etcCenterTotalSum_07_10 + etcCenterTotalSum_07_15}"></c:set>
    <c:set var="etcCenterTotalSum_06_all" value="${etcCenterTotalSum_06_5 + etcCenterTotalSum_06_10 + etcCenterTotalSum_06_15}"></c:set>
    <c:set var="etcCenterTotalSum_05_all" value="${etcCenterTotalSum_05_5 + etcCenterTotalSum_05_10 + etcCenterTotalSum_05_15}"></c:set>
    <c:set var="etcCenterTotalSum_04_all" value="${etcCenterTotalSum_04_5 + etcCenterTotalSum_04_10 + etcCenterTotalSum_04_15}"></c:set>
    <c:set var="etcCenterTotalSum_03_all" value="${etcCenterTotalSum_03_5 + etcCenterTotalSum_03_10 + etcCenterTotalSum_03_15}"></c:set>
    <c:set var="etcCenterTotalSum_02_all" value="${etcCenterTotalSum_02_5 + etcCenterTotalSum_02_10 + etcCenterTotalSum_02_15}"></c:set>
    <c:set var="etcCenterTotalSum_01_all" value="${etcCenterTotalSum_01_5 + etcCenterTotalSum_01_10 + etcCenterTotalSum_01_15}"></c:set>        
    <c:set var="etcCenterTotalSum_col_all" value="${etcCenterTotalSum_12_all + etcCenterTotalSum_11_all + etcCenterTotalSum_10_all + etcCenterTotalSum_09_all + etcCenterTotalSum_08_all + etcCenterTotalSum_07_all + etcCenterTotalSum_06_all + etcCenterTotalSum_05_all + etcCenterTotalSum_04_all + etcCenterTotalSum_03_all + etcCenterTotalSum_02_all + etcCenterTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체합계</th>    			
    			<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcCenterTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcCenterTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcCenterTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcCenterTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcCenterTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcCenterTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcCenterTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcCenterTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcCenterTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcCenterTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcCenterTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcCenterTotalSum_01_all}" pattern="#,##0.##"/></th>
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcCenterTotalSum_col_all}" pattern="#,##0.##"/></th>    			
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>