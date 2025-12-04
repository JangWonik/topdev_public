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
	            <c:set var="feeCenterSum_12_5" value="0"></c:set>
	            <c:set var="feeCenterSum_11_5" value="0"></c:set>
	            <c:set var="feeCenterSum_10_5" value="0"></c:set>
	            <c:set var="feeCenterSum_09_5" value="0"></c:set>
	            <c:set var="feeCenterSum_08_5" value="0"></c:set>
	            <c:set var="feeCenterSum_07_5" value="0"></c:set>
	            <c:set var="feeCenterSum_06_5" value="0"></c:set>
	            <c:set var="feeCenterSum_05_5" value="0"></c:set>
	            <c:set var="feeCenterSum_04_5" value="0"></c:set>
	            <c:set var="feeCenterSum_03_5" value="0"></c:set>
	            <c:set var="feeCenterSum_02_5" value="0"></c:set>
	            <c:set var="feeCenterSum_01_5" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="feeCenterTotalSum_12_5" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_11_5" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_10_5" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_09_5" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_08_5" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_07_5" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_06_5" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_05_5" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_04_5" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_03_5" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_02_5" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_01_5" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="feeColCenterTotalSum_5" value="0"></c:set>
   				    			
    			<c:forEach var="vo" items="${ptnrStatFeeList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
		                    	1종 조사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>
		                		<td style="width:150px;">${vo.ptnrIdSubNm}</td>
		                		<!-- 센터별 계 초기화 -->
					            <c:set var="feeCenterSum_12_5" value="0"></c:set>
					            <c:set var="feeCenterSum_11_5" value="0"></c:set>
					            <c:set var="feeCenterSum_10_5" value="0"></c:set>
					            <c:set var="feeCenterSum_09_5" value="0"></c:set>
					            <c:set var="feeCenterSum_08_5" value="0"></c:set>
					            <c:set var="feeCenterSum_07_5" value="0"></c:set>
					            <c:set var="feeCenterSum_06_5" value="0"></c:set>
					            <c:set var="feeCenterSum_05_5" value="0"></c:set>
					            <c:set var="feeCenterSum_04_5" value="0"></c:set>
					            <c:set var="feeCenterSum_03_5" value="0"></c:set>
					            <c:set var="feeCenterSum_02_5" value="0"></c:set>
					            <c:set var="feeCenterSum_01_5" value="0"></c:set>
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
			            
			            <!-- fee12 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${fee12_5}" pattern="#,##0.##"/></td>
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
		                <c:set var="feeColSum_5" value="${fee12_5 + fee11_5 + fee10_5 + fee09_5 + fee08_5 + fee07_5 + fee06_5 + fee05_5 + fee04_5 + fee03_5 + fee02_5 + fee01_5}"></c:set>                    
		                <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeColSum_5}" pattern="#,##0.##"/></td>
		                
		                <!-- 센터별 계 합산 -->
	    				<c:set var="feeCenterSum_12_5" value="${feeCenterSum_12_5+fee12_5}"></c:set>
			            <c:set var="feeCenterSum_11_5" value="${feeCenterSum_11_5+fee11_5}"></c:set>
			            <c:set var="feeCenterSum_10_5" value="${feeCenterSum_10_5+fee10_5}"></c:set>
			            <c:set var="feeCenterSum_09_5" value="${feeCenterSum_09_5+fee09_5}"></c:set>
			            <c:set var="feeCenterSum_08_5" value="${feeCenterSum_08_5+fee08_5}"></c:set>
			            <c:set var="feeCenterSum_07_5" value="${feeCenterSum_07_5+fee07_5}"></c:set>
			            <c:set var="feeCenterSum_06_5" value="${feeCenterSum_06_5+fee06_5}"></c:set>
			            <c:set var="feeCenterSum_05_5" value="${feeCenterSum_05_5+fee05_5}"></c:set>
			            <c:set var="feeCenterSum_04_5" value="${feeCenterSum_04_5+fee04_5}"></c:set>
			            <c:set var="feeCenterSum_03_5" value="${feeCenterSum_03_5+fee03_5}"></c:set>
			            <c:set var="feeCenterSum_02_5" value="${feeCenterSum_02_5+fee02_5}"></c:set>
			            <c:set var="feeCenterSum_01_5" value="${feeCenterSum_01_5+fee01_5}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="feeCenterTotalSum_12_5" value="${feeCenterTotalSum_12_5 + fee12_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_11_5" value="${feeCenterTotalSum_11_5 + fee11_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_10_5" value="${feeCenterTotalSum_10_5 + fee10_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_09_5" value="${feeCenterTotalSum_09_5 + fee09_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_08_5" value="${feeCenterTotalSum_08_5 + fee08_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_07_5" value="${feeCenterTotalSum_07_5 + fee07_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_06_5" value="${feeCenterTotalSum_06_5 + fee06_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_05_5" value="${feeCenterTotalSum_05_5 + fee05_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_04_5" value="${feeCenterTotalSum_04_5 + fee04_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_03_5" value="${feeCenterTotalSum_03_5 + fee03_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_02_5" value="${feeCenterTotalSum_02_5 + fee02_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_01_5" value="${feeCenterTotalSum_01_5 + fee01_5}"></c:set>
		    		</tr>
		    		<!-- 센터별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${centerCnt == vo.rowCnt and vo.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- fee12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_12_5}" pattern="#,##0.##"/></td>
			                <!-- fee11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_11_5}" pattern="#,##0.##"/></td>
			                <!-- fee10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_10_5}" pattern="#,##0.##"/></td>
			                <!-- fee09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_09_5}" pattern="#,##0.##"/></td>
			                <!-- fee08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_08_5}" pattern="#,##0.##"/></td>
			                <!-- fee07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_07_5}" pattern="#,##0.##"/></td>
			                <!-- fee06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_06_5}" pattern="#,##0.##"/></td>
			                <!-- fee05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_05_5}" pattern="#,##0.##"/></td>
			                <!-- fee04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_04_5}" pattern="#,##0.##"/></td>
			                <!-- fee03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_03_5}" pattern="#,##0.##"/></td>
			                <!-- fee02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_02_5}" pattern="#,##0.##"/></td>
			                <!-- fee01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_01_5}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="feeCenterColSum_5" value="${feeCenterSum_12_5 + feeCenterSum_11_5 + feeCenterSum_10_5 + feeCenterSum_09_5 + feeCenterSum_08_5 + feeCenterSum_07_5 + feeCenterSum_06_5 + feeCenterSum_05_5 + feeCenterSum_04_5 + feeCenterSum_03_5 + feeCenterSum_02_5 + feeCenterSum_01_5}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterColSum_5}" pattern="#,##0.##"/></td>
			                
							<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>										                		    				
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="feeCenterSum_12_5" value="0"></c:set>
				            <c:set var="feeCenterSum_11_5" value="0"></c:set>
				            <c:set var="feeCenterSum_10_5" value="0"></c:set>
				            <c:set var="feeCenterSum_09_5" value="0"></c:set>
				            <c:set var="feeCenterSum_08_5" value="0"></c:set>
				            <c:set var="feeCenterSum_07_5" value="0"></c:set>
				            <c:set var="feeCenterSum_06_5" value="0"></c:set>
				            <c:set var="feeCenterSum_05_5" value="0"></c:set>
				            <c:set var="feeCenterSum_04_5" value="0"></c:set>
				            <c:set var="feeCenterSum_03_5" value="0"></c:set>
				            <c:set var="feeCenterSum_02_5" value="0"></c:set>
				            <c:set var="feeCenterSum_01_5" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo.rowCnt == 1}">
		    				<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="feeCenterSum_12_5" value="0"></c:set>
				            <c:set var="feeCenterSum_11_5" value="0"></c:set>
				            <c:set var="feeCenterSum_10_5" value="0"></c:set>
				            <c:set var="feeCenterSum_09_5" value="0"></c:set>
				            <c:set var="feeCenterSum_08_5" value="0"></c:set>
				            <c:set var="feeCenterSum_07_5" value="0"></c:set>
				            <c:set var="feeCenterSum_06_5" value="0"></c:set>
				            <c:set var="feeCenterSum_05_5" value="0"></c:set>
				            <c:set var="feeCenterSum_04_5" value="0"></c:set>
				            <c:set var="feeCenterSum_03_5" value="0"></c:set>
				            <c:set var="feeCenterSum_02_5" value="0"></c:set>
				            <c:set var="feeCenterSum_01_5" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 센터별 계 카운트 증가 -->
		    				<c:set var="centerCnt" value="${centerCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 센터별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 조사 소계 시작 -->
		    	<c:if test="${ptnrStatFeeList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 조사 소계</th>
	                <!-- fee12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_12_5}" pattern="#,##0.##"/></th>
	                <!-- fee11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_11_5}" pattern="#,##0.##"/></th>
	                <!-- fee10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_10_5}" pattern="#,##0.##"/></th>
	                <!-- fee09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_09_5}" pattern="#,##0.##"/></th>
	                <!-- fee08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_08_5}" pattern="#,##0.##"/></th>
	                <!-- fee07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_07_5}" pattern="#,##0.##"/></th>
	                <!-- fee06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_06_5}" pattern="#,##0.##"/></th>
	                <!-- fee05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_05_5}" pattern="#,##0.##"/></th>
	                <!-- fee04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_04_5}" pattern="#,##0.##"/></th>
	                <!-- fee03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_03_5}" pattern="#,##0.##"/></th>
	                <!-- fee02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_02_5}" pattern="#,##0.##"/></th>
	                <!-- fee01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_01_5}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="feeColTotalSum_5" value="${feeCenterTotalSum_12_5 + feeCenterTotalSum_11_5 + feeCenterTotalSum_10_5 + feeCenterTotalSum_09_5 + feeCenterTotalSum_08_5 + feeCenterTotalSum_07_5 + feeCenterTotalSum_06_5 + feeCenterTotalSum_05_5 + feeCenterTotalSum_04_5 + feeCenterTotalSum_03_5 + feeCenterTotalSum_02_5 + feeCenterTotalSum_01_5}"></c:set>
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeColTotalSum_5}" pattern="#,##0.##"/></th>	                
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
	            <c:set var="feeCenterSum_12_10" value="0"></c:set>
	            <c:set var="feeCenterSum_11_10" value="0"></c:set>
	            <c:set var="feeCenterSum_10_10" value="0"></c:set>
	            <c:set var="feeCenterSum_09_10" value="0"></c:set>
	            <c:set var="feeCenterSum_08_10" value="0"></c:set>
	            <c:set var="feeCenterSum_07_10" value="0"></c:set>
	            <c:set var="feeCenterSum_06_10" value="0"></c:set>
	            <c:set var="feeCenterSum_05_10" value="0"></c:set>
	            <c:set var="feeCenterSum_04_10" value="0"></c:set>
	            <c:set var="feeCenterSum_03_10" value="0"></c:set>
	            <c:set var="feeCenterSum_02_10" value="0"></c:set>
	            <c:set var="feeCenterSum_01_10" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="feeCenterTotalSum_12_10" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_11_10" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_10_10" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_09_10" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_08_10" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_07_10" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_06_10" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_05_10" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_04_10" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_03_10" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_02_10" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_01_10" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="feeColCenterTotalSum_10" value="0"></c:set>
   				    			
    			<c:forEach var="vo1" items="${ptnrStatFeeList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
		                    	1종 심사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo1.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>
		                		<td style="width:150px;">${vo1.ptnrIdSubNm}</td>
		                		<!-- 센터별 계 초기화 -->
					            <c:set var="feeCenterSum_12_10" value="0"></c:set>
					            <c:set var="feeCenterSum_11_10" value="0"></c:set>
					            <c:set var="feeCenterSum_10_10" value="0"></c:set>
					            <c:set var="feeCenterSum_09_10" value="0"></c:set>
					            <c:set var="feeCenterSum_08_10" value="0"></c:set>
					            <c:set var="feeCenterSum_07_10" value="0"></c:set>
					            <c:set var="feeCenterSum_06_10" value="0"></c:set>
					            <c:set var="feeCenterSum_05_10" value="0"></c:set>
					            <c:set var="feeCenterSum_04_10" value="0"></c:set>
					            <c:set var="feeCenterSum_03_10" value="0"></c:set>
					            <c:set var="feeCenterSum_02_10" value="0"></c:set>
					            <c:set var="feeCenterSum_01_10" value="0"></c:set>
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
			            
			            <!-- fee12 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${fee12_10}" pattern="#,##0.##"/></td>
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
	                    <c:set var="feeColSum_10" value="${fee12_10 + fee11_10 + fee10_10 + fee09_10 + fee08_10 + fee07_10 + fee06_10 + fee05_10 + fee04_10 + fee03_10 + fee02_10 + fee01_10}"></c:set>                    
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeColSum_10}" pattern="#,##0.##"/></td>
		                
		                <!-- 센터별 계 합산 -->
	    				<c:set var="feeCenterSum_12_10" value="${feeCenterSum_12_10+fee12_10}"></c:set>
			            <c:set var="feeCenterSum_11_10" value="${feeCenterSum_11_10+fee11_10}"></c:set>
			            <c:set var="feeCenterSum_10_10" value="${feeCenterSum_10_10+fee10_10}"></c:set>
			            <c:set var="feeCenterSum_09_10" value="${feeCenterSum_09_10+fee09_10}"></c:set>
			            <c:set var="feeCenterSum_08_10" value="${feeCenterSum_08_10+fee08_10}"></c:set>
			            <c:set var="feeCenterSum_07_10" value="${feeCenterSum_07_10+fee07_10}"></c:set>
			            <c:set var="feeCenterSum_06_10" value="${feeCenterSum_06_10+fee06_10}"></c:set>
			            <c:set var="feeCenterSum_05_10" value="${feeCenterSum_05_10+fee05_10}"></c:set>
			            <c:set var="feeCenterSum_04_10" value="${feeCenterSum_04_10+fee04_10}"></c:set>
			            <c:set var="feeCenterSum_03_10" value="${feeCenterSum_03_10+fee03_10}"></c:set>
			            <c:set var="feeCenterSum_02_10" value="${feeCenterSum_02_10+fee02_10}"></c:set>
			            <c:set var="feeCenterSum_01_10" value="${feeCenterSum_01_10+fee01_10}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="feeCenterTotalSum_12_10" value="${feeCenterTotalSum_12_10 + fee12_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_11_10" value="${feeCenterTotalSum_11_10 + fee11_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_10_10" value="${feeCenterTotalSum_10_10 + fee10_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_09_10" value="${feeCenterTotalSum_09_10 + fee09_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_08_10" value="${feeCenterTotalSum_08_10 + fee08_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_07_10" value="${feeCenterTotalSum_07_10 + fee07_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_06_10" value="${feeCenterTotalSum_06_10 + fee06_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_05_10" value="${feeCenterTotalSum_05_10 + fee05_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_04_10" value="${feeCenterTotalSum_04_10 + fee04_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_03_10" value="${feeCenterTotalSum_03_10 + fee03_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_02_10" value="${feeCenterTotalSum_02_10 + fee02_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_01_10" value="${feeCenterTotalSum_01_10 + fee01_10}"></c:set>
		    		</tr>
		    		<!-- 센터별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${centerCnt == vo1.rowCnt and vo1.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- fee12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_12_10}" pattern="#,##0.##"/></td>
			                <!-- fee11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_11_10}" pattern="#,##0.##"/></td>
			                <!-- fee10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_10_10}" pattern="#,##0.##"/></td>
			                <!-- fee09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_09_10}" pattern="#,##0.##"/></td>
			                <!-- fee08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_08_10}" pattern="#,##0.##"/></td>
			                <!-- fee07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_07_10}" pattern="#,##0.##"/></td>
			                <!-- fee06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_06_10}" pattern="#,##0.##"/></td>
			                <!-- fee05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_05_10}" pattern="#,##0.##"/></td>
			                <!-- fee04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_04_10}" pattern="#,##0.##"/></td>
			                <!-- fee03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_03_10}" pattern="#,##0.##"/></td>
			                <!-- fee02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_02_10}" pattern="#,##0.##"/></td>
			                <!-- fee01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_01_10}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="feeCenterColSum_10" value="${feeCenterSum_12_10 + feeCenterSum_11_10 + feeCenterSum_10_10 + feeCenterSum_09_10 + feeCenterSum_08_10 + feeCenterSum_07_10 + feeCenterSum_06_10 + feeCenterSum_05_10 + feeCenterSum_04_10 + feeCenterSum_03_10 + feeCenterSum_02_10 + feeCenterSum_01_10}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterColSum_10}" pattern="#,##0.##"/></td>
			                
							<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>										                		    				
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="feeCenterSum_12_10" value="0"></c:set>
				            <c:set var="feeCenterSum_11_10" value="0"></c:set>
				            <c:set var="feeCenterSum_10_10" value="0"></c:set>
				            <c:set var="feeCenterSum_09_10" value="0"></c:set>
				            <c:set var="feeCenterSum_08_10" value="0"></c:set>
				            <c:set var="feeCenterSum_07_10" value="0"></c:set>
				            <c:set var="feeCenterSum_06_10" value="0"></c:set>
				            <c:set var="feeCenterSum_05_10" value="0"></c:set>
				            <c:set var="feeCenterSum_04_10" value="0"></c:set>
				            <c:set var="feeCenterSum_03_10" value="0"></c:set>
				            <c:set var="feeCenterSum_02_10" value="0"></c:set>
				            <c:set var="feeCenterSum_01_10" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo1.rowCnt == 1}">
		    				<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="feeCenterSum_12_10" value="0"></c:set>
				            <c:set var="feeCenterSum_11_10" value="0"></c:set>
				            <c:set var="feeCenterSum_10_10" value="0"></c:set>
				            <c:set var="feeCenterSum_09_10" value="0"></c:set>
				            <c:set var="feeCenterSum_08_10" value="0"></c:set>
				            <c:set var="feeCenterSum_07_10" value="0"></c:set>
				            <c:set var="feeCenterSum_06_10" value="0"></c:set>
				            <c:set var="feeCenterSum_05_10" value="0"></c:set>
				            <c:set var="feeCenterSum_04_10" value="0"></c:set>
				            <c:set var="feeCenterSum_03_10" value="0"></c:set>
				            <c:set var="feeCenterSum_02_10" value="0"></c:set>
				            <c:set var="feeCenterSum_01_10" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 센터별 계 카운트 증가 -->
		    				<c:set var="centerCnt" value="${centerCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 센터별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 심사 소계 시작 -->
		    	<c:if test="${ptnrStatFeeList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 심사 소계</th>
	                <!-- fee12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_12_10}" pattern="#,##0.##"/></th>
	                <!-- fee11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_11_10}" pattern="#,##0.##"/></th>
	                <!-- fee10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_10_10}" pattern="#,##0.##"/></th>
	                <!-- fee09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_09_10}" pattern="#,##0.##"/></th>
	                <!-- fee08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_08_10}" pattern="#,##0.##"/></th>
	                <!-- fee07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_07_10}" pattern="#,##0.##"/></th>
	                <!-- fee06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_06_10}" pattern="#,##0.##"/></th>
	                <!-- fee05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_05_10}" pattern="#,##0.##"/></th>
	                <!-- fee04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_04_10}" pattern="#,##0.##"/></th>
	                <!-- fee03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_03_10}" pattern="#,##0.##"/></th>
	                <!-- fee02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_02_10}" pattern="#,##0.##"/></th>
	                <!-- fee01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_01_10}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="feeColTotalSum_10" value="${feeCenterTotalSum_12_10 + feeCenterTotalSum_11_10 + feeCenterTotalSum_10_10 + feeCenterTotalSum_09_10 + feeCenterTotalSum_08_10 + feeCenterTotalSum_07_10 + feeCenterTotalSum_06_10 + feeCenterTotalSum_05_10 + feeCenterTotalSum_04_10 + feeCenterTotalSum_03_10 + feeCenterTotalSum_02_10 + feeCenterTotalSum_01_10}"></c:set>
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeColTotalSum_10}" pattern="#,##0.##"/></th>	                
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
	            <c:set var="feeCenterSum_12_15" value="0"></c:set>
	            <c:set var="feeCenterSum_11_15" value="0"></c:set>
	            <c:set var="feeCenterSum_10_15" value="0"></c:set>
	            <c:set var="feeCenterSum_09_15" value="0"></c:set>
	            <c:set var="feeCenterSum_08_15" value="0"></c:set>
	            <c:set var="feeCenterSum_07_15" value="0"></c:set>
	            <c:set var="feeCenterSum_06_15" value="0"></c:set>
	            <c:set var="feeCenterSum_05_15" value="0"></c:set>
	            <c:set var="feeCenterSum_04_15" value="0"></c:set>
	            <c:set var="feeCenterSum_03_15" value="0"></c:set>
	            <c:set var="feeCenterSum_02_15" value="0"></c:set>
	            <c:set var="feeCenterSum_01_15" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="feeCenterTotalSum_12_15" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_11_15" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_10_15" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_09_15" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_08_15" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_07_15" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_06_15" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_05_15" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_04_15" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_03_15" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_02_15" value="0"></c:set>
	            <c:set var="feeCenterTotalSum_01_15" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="feeColCenterTotalSum_15" value="0"></c:set>
   				    			
    			<c:forEach var="vo2" items="${ptnrStatFeeList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
		                    	1종 기타
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo2.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>
		                		<td style="width:150px;">${vo2.ptnrIdSubNm}</td>
		                		<!-- 센터별 계 초기화 -->
					            <c:set var="feeCenterSum_12_15" value="0"></c:set>
					            <c:set var="feeCenterSum_11_15" value="0"></c:set>
					            <c:set var="feeCenterSum_10_15" value="0"></c:set>
					            <c:set var="feeCenterSum_09_15" value="0"></c:set>
					            <c:set var="feeCenterSum_08_15" value="0"></c:set>
					            <c:set var="feeCenterSum_07_15" value="0"></c:set>
					            <c:set var="feeCenterSum_06_15" value="0"></c:set>
					            <c:set var="feeCenterSum_05_15" value="0"></c:set>
					            <c:set var="feeCenterSum_04_15" value="0"></c:set>
					            <c:set var="feeCenterSum_03_15" value="0"></c:set>
					            <c:set var="feeCenterSum_02_15" value="0"></c:set>
					            <c:set var="feeCenterSum_01_15" value="0"></c:set>
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
			            
			            <!-- fee12 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${fee12_15}" pattern="#,##0.##"/></td>
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
	                    <c:set var="feeColSum_15" value="${fee12_15 + fee11_15 + fee10_15 + fee09_15 + fee08_15 + fee07_15 + fee06_15 + fee05_15 + fee04_15 + fee03_15 + fee02_15 + fee01_15}"></c:set>                    
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeColSum_15}" pattern="#,##0.##"/></td>
		                
		                <!-- 센터별 계 합산 -->
	    				<c:set var="feeCenterSum_12_15" value="${feeCenterSum_12_15+fee12_15}"></c:set>
			            <c:set var="feeCenterSum_11_15" value="${feeCenterSum_11_15+fee11_15}"></c:set>
			            <c:set var="feeCenterSum_10_15" value="${feeCenterSum_10_15+fee10_15}"></c:set>
			            <c:set var="feeCenterSum_09_15" value="${feeCenterSum_09_15+fee09_15}"></c:set>
			            <c:set var="feeCenterSum_08_15" value="${feeCenterSum_08_15+fee08_15}"></c:set>
			            <c:set var="feeCenterSum_07_15" value="${feeCenterSum_07_15+fee07_15}"></c:set>
			            <c:set var="feeCenterSum_06_15" value="${feeCenterSum_06_15+fee06_15}"></c:set>
			            <c:set var="feeCenterSum_05_15" value="${feeCenterSum_05_15+fee05_15}"></c:set>
			            <c:set var="feeCenterSum_04_15" value="${feeCenterSum_04_15+fee04_15}"></c:set>
			            <c:set var="feeCenterSum_03_15" value="${feeCenterSum_03_15+fee03_15}"></c:set>
			            <c:set var="feeCenterSum_02_15" value="${feeCenterSum_02_15+fee02_15}"></c:set>
			            <c:set var="feeCenterSum_01_15" value="${feeCenterSum_01_15+fee01_15}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="feeCenterTotalSum_12_15" value="${feeCenterTotalSum_12_15 + fee12_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_11_15" value="${feeCenterTotalSum_11_15 + fee11_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_10_15" value="${feeCenterTotalSum_10_15 + fee10_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_09_15" value="${feeCenterTotalSum_09_15 + fee09_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_08_15" value="${feeCenterTotalSum_08_15 + fee08_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_07_15" value="${feeCenterTotalSum_07_15 + fee07_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_06_15" value="${feeCenterTotalSum_06_15 + fee06_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_05_15" value="${feeCenterTotalSum_05_15 + fee05_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_04_15" value="${feeCenterTotalSum_04_15 + fee04_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_03_15" value="${feeCenterTotalSum_03_15 + fee03_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_02_15" value="${feeCenterTotalSum_02_15 + fee02_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_01_15" value="${feeCenterTotalSum_01_15 + fee01_15}"></c:set>
		    		</tr>
		    		<!-- 센터별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${centerCnt == vo2.rowCnt and vo2.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- fee12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_12_15}" pattern="#,##0.##"/></td>
			                <!-- fee11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_11_15}" pattern="#,##0.##"/></td>
			                <!-- fee10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_10_15}" pattern="#,##0.##"/></td>
			                <!-- fee09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_09_15}" pattern="#,##0.##"/></td>
			                <!-- fee08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_08_15}" pattern="#,##0.##"/></td>
			                <!-- fee07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_07_15}" pattern="#,##0.##"/></td>
			                <!-- fee06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_06_15}" pattern="#,##0.##"/></td>
			                <!-- fee05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_05_15}" pattern="#,##0.##"/></td>
			                <!-- fee04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_04_15}" pattern="#,##0.##"/></td>
			                <!-- fee03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_03_15}" pattern="#,##0.##"/></td>
			                <!-- fee02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_02_15}" pattern="#,##0.##"/></td>
			                <!-- fee01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterSum_01_15}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="feeCenterColSum_15" value="${feeCenterSum_12_15 + feeCenterSum_11_15 + feeCenterSum_10_15 + feeCenterSum_09_15 + feeCenterSum_08_15 + feeCenterSum_07_15 + feeCenterSum_06_15 + feeCenterSum_05_15 + feeCenterSum_04_15 + feeCenterSum_03_15 + feeCenterSum_02_15 + feeCenterSum_01_15}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeCenterColSum_15}" pattern="#,##0.##"/></td>
			                
							<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>										                		    				
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="feeCenterSum_12_15" value="0"></c:set>
				            <c:set var="feeCenterSum_11_15" value="0"></c:set>
				            <c:set var="feeCenterSum_10_15" value="0"></c:set>
				            <c:set var="feeCenterSum_09_15" value="0"></c:set>
				            <c:set var="feeCenterSum_08_15" value="0"></c:set>
				            <c:set var="feeCenterSum_07_15" value="0"></c:set>
				            <c:set var="feeCenterSum_06_15" value="0"></c:set>
				            <c:set var="feeCenterSum_05_15" value="0"></c:set>
				            <c:set var="feeCenterSum_04_15" value="0"></c:set>
				            <c:set var="feeCenterSum_03_15" value="0"></c:set>
				            <c:set var="feeCenterSum_02_15" value="0"></c:set>
				            <c:set var="feeCenterSum_01_15" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo2.rowCnt == 1}">
		    				<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="feeCenterSum_12_15" value="0"></c:set>
				            <c:set var="feeCenterSum_11_15" value="0"></c:set>
				            <c:set var="feeCenterSum_10_15" value="0"></c:set>
				            <c:set var="feeCenterSum_09_15" value="0"></c:set>
				            <c:set var="feeCenterSum_08_15" value="0"></c:set>
				            <c:set var="feeCenterSum_07_15" value="0"></c:set>
				            <c:set var="feeCenterSum_06_15" value="0"></c:set>
				            <c:set var="feeCenterSum_05_15" value="0"></c:set>
				            <c:set var="feeCenterSum_04_15" value="0"></c:set>
				            <c:set var="feeCenterSum_03_15" value="0"></c:set>
				            <c:set var="feeCenterSum_02_15" value="0"></c:set>
				            <c:set var="feeCenterSum_01_15" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 센터별 계 카운트 증가 -->
		    				<c:set var="centerCnt" value="${centerCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 센터별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 기타 소계 시작 -->
		    	<c:if test="${ptnrStatFeeList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 기타 소계</th>
	                <!-- fee12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_12_15}" pattern="#,##0.##"/></th>
	                <!-- fee11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_11_15}" pattern="#,##0.##"/></th>
	                <!-- fee10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_10_15}" pattern="#,##0.##"/></th>
	                <!-- fee09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_09_15}" pattern="#,##0.##"/></th>
	                <!-- fee08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_08_15}" pattern="#,##0.##"/></th>
	                <!-- fee07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_07_15}" pattern="#,##0.##"/></th>
	                <!-- fee06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_06_15}" pattern="#,##0.##"/></th>
	                <!-- fee05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_05_15}" pattern="#,##0.##"/></th>
	                <!-- fee04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_04_15}" pattern="#,##0.##"/></th>
	                <!-- fee03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_03_15}" pattern="#,##0.##"/></th>
	                <!-- fee02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_02_15}" pattern="#,##0.##"/></th>
	                <!-- fee01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeCenterTotalSum_01_15}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="feeColTotalSum_15" value="${feeCenterTotalSum_12_15 + feeCenterTotalSum_11_15 + feeCenterTotalSum_10_15 + feeCenterTotalSum_09_15 + feeCenterTotalSum_08_15 + feeCenterTotalSum_07_15 + feeCenterTotalSum_06_15 + feeCenterTotalSum_05_15 + feeCenterTotalSum_04_15 + feeCenterTotalSum_03_15 + feeCenterTotalSum_02_15 + feeCenterTotalSum_01_15}"></c:set>
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeColTotalSum_15}" pattern="#,##0.##"/></th>	                
	            </tr>
	            </c:if>
		    	<!-- 1종 기타 소계 끝 -->
    		</tbody>
    	</table>
    	<!-- 1종 기타 끝 -->  	        
    </div>    
    <!-- 총 합계 시작 -->
    <!-- 총 합계 변수 시작 -->
    <c:set var="feeCenterTotalSum_12_all" value="${feeCenterTotalSum_12_5 + feeCenterTotalSum_12_10 + feeCenterTotalSum_12_15}"></c:set>
    <c:set var="feeCenterTotalSum_11_all" value="${feeCenterTotalSum_11_5 + feeCenterTotalSum_11_10 + feeCenterTotalSum_11_15}"></c:set>
    <c:set var="feeCenterTotalSum_10_all" value="${feeCenterTotalSum_10_5 + feeCenterTotalSum_10_10 + feeCenterTotalSum_10_15}"></c:set>
    <c:set var="feeCenterTotalSum_09_all" value="${feeCenterTotalSum_09_5 + feeCenterTotalSum_09_10 + feeCenterTotalSum_09_15}"></c:set>
    <c:set var="feeCenterTotalSum_08_all" value="${feeCenterTotalSum_08_5 + feeCenterTotalSum_08_10 + feeCenterTotalSum_08_15}"></c:set>
    <c:set var="feeCenterTotalSum_07_all" value="${feeCenterTotalSum_07_5 + feeCenterTotalSum_07_10 + feeCenterTotalSum_07_15}"></c:set>
    <c:set var="feeCenterTotalSum_06_all" value="${feeCenterTotalSum_06_5 + feeCenterTotalSum_06_10 + feeCenterTotalSum_06_15}"></c:set>
    <c:set var="feeCenterTotalSum_05_all" value="${feeCenterTotalSum_05_5 + feeCenterTotalSum_05_10 + feeCenterTotalSum_05_15}"></c:set>
    <c:set var="feeCenterTotalSum_04_all" value="${feeCenterTotalSum_04_5 + feeCenterTotalSum_04_10 + feeCenterTotalSum_04_15}"></c:set>
    <c:set var="feeCenterTotalSum_03_all" value="${feeCenterTotalSum_03_5 + feeCenterTotalSum_03_10 + feeCenterTotalSum_03_15}"></c:set>
    <c:set var="feeCenterTotalSum_02_all" value="${feeCenterTotalSum_02_5 + feeCenterTotalSum_02_10 + feeCenterTotalSum_02_15}"></c:set>
    <c:set var="feeCenterTotalSum_01_all" value="${feeCenterTotalSum_01_5 + feeCenterTotalSum_01_10 + feeCenterTotalSum_01_15}"></c:set>        
    <c:set var="feeCenterTotalSum_col_all" value="${feeCenterTotalSum_12_all + feeCenterTotalSum_11_all + feeCenterTotalSum_10_all + feeCenterTotalSum_09_all + feeCenterTotalSum_08_all + feeCenterTotalSum_07_all + feeCenterTotalSum_06_all + feeCenterTotalSum_05_all + feeCenterTotalSum_04_all + feeCenterTotalSum_03_all + feeCenterTotalSum_02_all + feeCenterTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체합계</th>    			
    			<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeCenterTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeCenterTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeCenterTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeCenterTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeCenterTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeCenterTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeCenterTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeCenterTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeCenterTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeCenterTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeCenterTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeCenterTotalSum_01_all}" pattern="#,##0.##"/></th>
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeCenterTotalSum_col_all}" pattern="#,##0.##"/></th>    			
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>