<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2">
    <div style="background: #e7ecf1;">
        <table>            
            <tr>
                <th style="width: 80px;height:25px;">Type</th>
                <th style="width: 150px;">팀명</th>                
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
   				<c:set var="teamCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 센터명 -->
   				<c:set var="preTeamName" value=""></c:set>
   				
   				<!-- 센터별 계 -->
	            <c:set var="feeTeamSum_12_5" value="0"></c:set>
	            <c:set var="feeTeamSum_11_5" value="0"></c:set>
	            <c:set var="feeTeamSum_10_5" value="0"></c:set>
	            <c:set var="feeTeamSum_09_5" value="0"></c:set>
	            <c:set var="feeTeamSum_08_5" value="0"></c:set>
	            <c:set var="feeTeamSum_07_5" value="0"></c:set>
	            <c:set var="feeTeamSum_06_5" value="0"></c:set>
	            <c:set var="feeTeamSum_05_5" value="0"></c:set>
	            <c:set var="feeTeamSum_04_5" value="0"></c:set>
	            <c:set var="feeTeamSum_03_5" value="0"></c:set>
	            <c:set var="feeTeamSum_02_5" value="0"></c:set>
	            <c:set var="feeTeamSum_01_5" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="feeTeamTotalSum_12_5" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_11_5" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_10_5" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_09_5" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_08_5" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_07_5" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_06_5" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_05_5" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_04_5" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_03_5" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_02_5" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_01_5" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="feeColTeamTotalSum_5" value="0"></c:set>
   				    			
    			<c:forEach var="vo" items="${ptnrStatFeeList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCenterFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
		                    	1종 조사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatMember(${vo.ptnrId},${vo.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.teamName}</td>
		                		<td style="width:150px;">${vo.ptnrIdSubNm}</td>
		                		<!-- 센터별 계 초기화 -->
					            <c:set var="feeTeamSum_12_5" value="0"></c:set>
					            <c:set var="feeTeamSum_11_5" value="0"></c:set>
					            <c:set var="feeTeamSum_10_5" value="0"></c:set>
					            <c:set var="feeTeamSum_09_5" value="0"></c:set>
					            <c:set var="feeTeamSum_08_5" value="0"></c:set>
					            <c:set var="feeTeamSum_07_5" value="0"></c:set>
					            <c:set var="feeTeamSum_06_5" value="0"></c:set>
					            <c:set var="feeTeamSum_05_5" value="0"></c:set>
					            <c:set var="feeTeamSum_04_5" value="0"></c:set>
					            <c:set var="feeTeamSum_03_5" value="0"></c:set>
					            <c:set var="feeTeamSum_02_5" value="0"></c:set>
					            <c:set var="feeTeamSum_01_5" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${teamCnt == 1 and vo.teamName != preTeamName}">
		                				<td onclick="goPtnrStatMember(${vo.ptnrId},${vo.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${vo.rowCnt+1}">${vo.teamName}</td>
		                				<td style="width:150px;">${vo.ptnrIdSubNm}</td>		                				
		                				<c:set var="preTeamName" value="${vo.teamName}"></c:set>
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
	    				<c:set var="feeTeamSum_12_5" value="${feeTeamSum_12_5+fee12_5}"></c:set>
			            <c:set var="feeTeamSum_11_5" value="${feeTeamSum_11_5+fee11_5}"></c:set>
			            <c:set var="feeTeamSum_10_5" value="${feeTeamSum_10_5+fee10_5}"></c:set>
			            <c:set var="feeTeamSum_09_5" value="${feeTeamSum_09_5+fee09_5}"></c:set>
			            <c:set var="feeTeamSum_08_5" value="${feeTeamSum_08_5+fee08_5}"></c:set>
			            <c:set var="feeTeamSum_07_5" value="${feeTeamSum_07_5+fee07_5}"></c:set>
			            <c:set var="feeTeamSum_06_5" value="${feeTeamSum_06_5+fee06_5}"></c:set>
			            <c:set var="feeTeamSum_05_5" value="${feeTeamSum_05_5+fee05_5}"></c:set>
			            <c:set var="feeTeamSum_04_5" value="${feeTeamSum_04_5+fee04_5}"></c:set>
			            <c:set var="feeTeamSum_03_5" value="${feeTeamSum_03_5+fee03_5}"></c:set>
			            <c:set var="feeTeamSum_02_5" value="${feeTeamSum_02_5+fee02_5}"></c:set>
			            <c:set var="feeTeamSum_01_5" value="${feeTeamSum_01_5+fee01_5}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="feeTeamTotalSum_12_5" value="${feeTeamTotalSum_12_5 + fee12_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_11_5" value="${feeTeamTotalSum_11_5 + fee11_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_10_5" value="${feeTeamTotalSum_10_5 + fee10_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_09_5" value="${feeTeamTotalSum_09_5 + fee09_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_08_5" value="${feeTeamTotalSum_08_5 + fee08_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_07_5" value="${feeTeamTotalSum_07_5 + fee07_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_06_5" value="${feeTeamTotalSum_06_5 + fee06_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_05_5" value="${feeTeamTotalSum_05_5 + fee05_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_04_5" value="${feeTeamTotalSum_04_5 + fee04_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_03_5" value="${feeTeamTotalSum_03_5 + fee03_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_02_5" value="${feeTeamTotalSum_02_5 + fee02_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_01_5" value="${feeTeamTotalSum_01_5 + fee01_5}"></c:set>
		    		</tr>
		    		<!-- 센터별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo.rowCnt and vo.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- fee12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_12_5}" pattern="#,##0.##"/></td>
			                <!-- fee11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_11_5}" pattern="#,##0.##"/></td>
			                <!-- fee10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_10_5}" pattern="#,##0.##"/></td>
			                <!-- fee09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_09_5}" pattern="#,##0.##"/></td>
			                <!-- fee08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_08_5}" pattern="#,##0.##"/></td>
			                <!-- fee07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_07_5}" pattern="#,##0.##"/></td>
			                <!-- fee06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_06_5}" pattern="#,##0.##"/></td>
			                <!-- fee05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_05_5}" pattern="#,##0.##"/></td>
			                <!-- fee04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_04_5}" pattern="#,##0.##"/></td>
			                <!-- fee03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_03_5}" pattern="#,##0.##"/></td>
			                <!-- fee02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_02_5}" pattern="#,##0.##"/></td>
			                <!-- fee01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_01_5}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="feeTeamColSum_5" value="${feeTeamSum_12_5 + feeTeamSum_11_5 + feeTeamSum_10_5 + feeTeamSum_09_5 + feeTeamSum_08_5 + feeTeamSum_07_5 + feeTeamSum_06_5 + feeTeamSum_05_5 + feeTeamSum_04_5 + feeTeamSum_03_5 + feeTeamSum_02_5 + feeTeamSum_01_5}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamColSum_5}" pattern="#,##0.##"/></td>
			                
							<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="feeTeamSum_12_5" value="0"></c:set>
				            <c:set var="feeTeamSum_11_5" value="0"></c:set>
				            <c:set var="feeTeamSum_10_5" value="0"></c:set>
				            <c:set var="feeTeamSum_09_5" value="0"></c:set>
				            <c:set var="feeTeamSum_08_5" value="0"></c:set>
				            <c:set var="feeTeamSum_07_5" value="0"></c:set>
				            <c:set var="feeTeamSum_06_5" value="0"></c:set>
				            <c:set var="feeTeamSum_05_5" value="0"></c:set>
				            <c:set var="feeTeamSum_04_5" value="0"></c:set>
				            <c:set var="feeTeamSum_03_5" value="0"></c:set>
				            <c:set var="feeTeamSum_02_5" value="0"></c:set>
				            <c:set var="feeTeamSum_01_5" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo.rowCnt == 1}">
		    				<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="feeTeamSum_12_5" value="0"></c:set>
				            <c:set var="feeTeamSum_11_5" value="0"></c:set>
				            <c:set var="feeTeamSum_10_5" value="0"></c:set>
				            <c:set var="feeTeamSum_09_5" value="0"></c:set>
				            <c:set var="feeTeamSum_08_5" value="0"></c:set>
				            <c:set var="feeTeamSum_07_5" value="0"></c:set>
				            <c:set var="feeTeamSum_06_5" value="0"></c:set>
				            <c:set var="feeTeamSum_05_5" value="0"></c:set>
				            <c:set var="feeTeamSum_04_5" value="0"></c:set>
				            <c:set var="feeTeamSum_03_5" value="0"></c:set>
				            <c:set var="feeTeamSum_02_5" value="0"></c:set>
				            <c:set var="feeTeamSum_01_5" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 센터별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 센터별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 조사 소계 시작 -->
		    	<c:if test="${ptnrStatFeeList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 조사 소계</th>
	                <!-- fee12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_12_5}" pattern="#,##0.##"/></th>
	                <!-- fee11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_11_5}" pattern="#,##0.##"/></th>
	                <!-- fee10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_10_5}" pattern="#,##0.##"/></th>
	                <!-- fee09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_09_5}" pattern="#,##0.##"/></th>
	                <!-- fee08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_08_5}" pattern="#,##0.##"/></th>
	                <!-- fee07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_07_5}" pattern="#,##0.##"/></th>
	                <!-- fee06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_06_5}" pattern="#,##0.##"/></th>
	                <!-- fee05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_05_5}" pattern="#,##0.##"/></th>
	                <!-- fee04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_04_5}" pattern="#,##0.##"/></th>
	                <!-- fee03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_03_5}" pattern="#,##0.##"/></th>
	                <!-- fee02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_02_5}" pattern="#,##0.##"/></th>
	                <!-- fee01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_01_5}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="feeColTotalSum_5" value="${feeTeamTotalSum_12_5 + feeTeamTotalSum_11_5 + feeTeamTotalSum_10_5 + feeTeamTotalSum_09_5 + feeTeamTotalSum_08_5 + feeTeamTotalSum_07_5 + feeTeamTotalSum_06_5 + feeTeamTotalSum_05_5 + feeTeamTotalSum_04_5 + feeTeamTotalSum_03_5 + feeTeamTotalSum_02_5 + feeTeamTotalSum_01_5}"></c:set>
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
   				<c:set var="teamCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 센터명 -->
   				<c:set var="preTeamName" value=""></c:set>
   				
   				<!-- 센터별 계 -->
	            <c:set var="feeTeamSum_12_10" value="0"></c:set>
	            <c:set var="feeTeamSum_11_10" value="0"></c:set>
	            <c:set var="feeTeamSum_10_10" value="0"></c:set>
	            <c:set var="feeTeamSum_09_10" value="0"></c:set>
	            <c:set var="feeTeamSum_08_10" value="0"></c:set>
	            <c:set var="feeTeamSum_07_10" value="0"></c:set>
	            <c:set var="feeTeamSum_06_10" value="0"></c:set>
	            <c:set var="feeTeamSum_05_10" value="0"></c:set>
	            <c:set var="feeTeamSum_04_10" value="0"></c:set>
	            <c:set var="feeTeamSum_03_10" value="0"></c:set>
	            <c:set var="feeTeamSum_02_10" value="0"></c:set>
	            <c:set var="feeTeamSum_01_10" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="feeTeamTotalSum_12_10" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_11_10" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_10_10" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_09_10" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_08_10" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_07_10" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_06_10" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_05_10" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_04_10" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_03_10" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_02_10" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_01_10" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="feeColTeamTotalSum_10" value="0"></c:set>
   				    			
    			<c:forEach var="vo1" items="${ptnrStatFeeList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCenterFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
		                    	1종 심사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo1.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatMember(${vo1.ptnrId},${vo1.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.teamName}</td>
		                		<td style="width:150px;">${vo1.ptnrIdSubNm}</td>
		                		<!-- 센터별 계 초기화 -->
					            <c:set var="feeTeamSum_12_10" value="0"></c:set>
					            <c:set var="feeTeamSum_11_10" value="0"></c:set>
					            <c:set var="feeTeamSum_10_10" value="0"></c:set>
					            <c:set var="feeTeamSum_09_10" value="0"></c:set>
					            <c:set var="feeTeamSum_08_10" value="0"></c:set>
					            <c:set var="feeTeamSum_07_10" value="0"></c:set>
					            <c:set var="feeTeamSum_06_10" value="0"></c:set>
					            <c:set var="feeTeamSum_05_10" value="0"></c:set>
					            <c:set var="feeTeamSum_04_10" value="0"></c:set>
					            <c:set var="feeTeamSum_03_10" value="0"></c:set>
					            <c:set var="feeTeamSum_02_10" value="0"></c:set>
					            <c:set var="feeTeamSum_01_10" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${teamCnt == 1 and vo1.teamName != preTeamName}">
		                				<td onclick="goPtnrStatMember(${vo1.ptnrId},${vo1.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${vo1.rowCnt+1}">${vo1.teamName}</td>
		                				<td style="width:150px;">${vo1.ptnrIdSubNm}</td>		                				
		                				<c:set var="preTeamName" value="${vo1.teamName}"></c:set>
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
	    				<c:set var="feeTeamSum_12_10" value="${feeTeamSum_12_10+fee12_10}"></c:set>
			            <c:set var="feeTeamSum_11_10" value="${feeTeamSum_11_10+fee11_10}"></c:set>
			            <c:set var="feeTeamSum_10_10" value="${feeTeamSum_10_10+fee10_10}"></c:set>
			            <c:set var="feeTeamSum_09_10" value="${feeTeamSum_09_10+fee09_10}"></c:set>
			            <c:set var="feeTeamSum_08_10" value="${feeTeamSum_08_10+fee08_10}"></c:set>
			            <c:set var="feeTeamSum_07_10" value="${feeTeamSum_07_10+fee07_10}"></c:set>
			            <c:set var="feeTeamSum_06_10" value="${feeTeamSum_06_10+fee06_10}"></c:set>
			            <c:set var="feeTeamSum_05_10" value="${feeTeamSum_05_10+fee05_10}"></c:set>
			            <c:set var="feeTeamSum_04_10" value="${feeTeamSum_04_10+fee04_10}"></c:set>
			            <c:set var="feeTeamSum_03_10" value="${feeTeamSum_03_10+fee03_10}"></c:set>
			            <c:set var="feeTeamSum_02_10" value="${feeTeamSum_02_10+fee02_10}"></c:set>
			            <c:set var="feeTeamSum_01_10" value="${feeTeamSum_01_10+fee01_10}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="feeTeamTotalSum_12_10" value="${feeTeamTotalSum_12_10 + fee12_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_11_10" value="${feeTeamTotalSum_11_10 + fee11_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_10_10" value="${feeTeamTotalSum_10_10 + fee10_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_09_10" value="${feeTeamTotalSum_09_10 + fee09_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_08_10" value="${feeTeamTotalSum_08_10 + fee08_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_07_10" value="${feeTeamTotalSum_07_10 + fee07_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_06_10" value="${feeTeamTotalSum_06_10 + fee06_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_05_10" value="${feeTeamTotalSum_05_10 + fee05_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_04_10" value="${feeTeamTotalSum_04_10 + fee04_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_03_10" value="${feeTeamTotalSum_03_10 + fee03_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_02_10" value="${feeTeamTotalSum_02_10 + fee02_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_01_10" value="${feeTeamTotalSum_01_10 + fee01_10}"></c:set>
		    		</tr>
		    		<!-- 센터별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo1.rowCnt and vo1.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- fee12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_12_10}" pattern="#,##0.##"/></td>
			                <!-- fee11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_11_10}" pattern="#,##0.##"/></td>
			                <!-- fee10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_10_10}" pattern="#,##0.##"/></td>
			                <!-- fee09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_09_10}" pattern="#,##0.##"/></td>
			                <!-- fee08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_08_10}" pattern="#,##0.##"/></td>
			                <!-- fee07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_07_10}" pattern="#,##0.##"/></td>
			                <!-- fee06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_06_10}" pattern="#,##0.##"/></td>
			                <!-- fee05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_05_10}" pattern="#,##0.##"/></td>
			                <!-- fee04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_04_10}" pattern="#,##0.##"/></td>
			                <!-- fee03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_03_10}" pattern="#,##0.##"/></td>
			                <!-- fee02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_02_10}" pattern="#,##0.##"/></td>
			                <!-- fee01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_01_10}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="feeTeamColSum_10" value="${feeTeamSum_12_10 + feeTeamSum_11_10 + feeTeamSum_10_10 + feeTeamSum_09_10 + feeTeamSum_08_10 + feeTeamSum_07_10 + feeTeamSum_06_10 + feeTeamSum_05_10 + feeTeamSum_04_10 + feeTeamSum_03_10 + feeTeamSum_02_10 + feeTeamSum_01_10}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamColSum_10}" pattern="#,##0.##"/></td>
			                
							<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="feeTeamSum_12_10" value="0"></c:set>
				            <c:set var="feeTeamSum_11_10" value="0"></c:set>
				            <c:set var="feeTeamSum_10_10" value="0"></c:set>
				            <c:set var="feeTeamSum_09_10" value="0"></c:set>
				            <c:set var="feeTeamSum_08_10" value="0"></c:set>
				            <c:set var="feeTeamSum_07_10" value="0"></c:set>
				            <c:set var="feeTeamSum_06_10" value="0"></c:set>
				            <c:set var="feeTeamSum_05_10" value="0"></c:set>
				            <c:set var="feeTeamSum_04_10" value="0"></c:set>
				            <c:set var="feeTeamSum_03_10" value="0"></c:set>
				            <c:set var="feeTeamSum_02_10" value="0"></c:set>
				            <c:set var="feeTeamSum_01_10" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo1.rowCnt == 1}">
		    				<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="feeTeamSum_12_10" value="0"></c:set>
				            <c:set var="feeTeamSum_11_10" value="0"></c:set>
				            <c:set var="feeTeamSum_10_10" value="0"></c:set>
				            <c:set var="feeTeamSum_09_10" value="0"></c:set>
				            <c:set var="feeTeamSum_08_10" value="0"></c:set>
				            <c:set var="feeTeamSum_07_10" value="0"></c:set>
				            <c:set var="feeTeamSum_06_10" value="0"></c:set>
				            <c:set var="feeTeamSum_05_10" value="0"></c:set>
				            <c:set var="feeTeamSum_04_10" value="0"></c:set>
				            <c:set var="feeTeamSum_03_10" value="0"></c:set>
				            <c:set var="feeTeamSum_02_10" value="0"></c:set>
				            <c:set var="feeTeamSum_01_10" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 센터별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 센터별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 심사 소계 시작 -->
		    	<c:if test="${ptnrStatFeeList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 심사 소계</th>
	                <!-- fee12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_12_10}" pattern="#,##0.##"/></th>
	                <!-- fee11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_11_10}" pattern="#,##0.##"/></th>
	                <!-- fee10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_10_10}" pattern="#,##0.##"/></th>
	                <!-- fee09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_09_10}" pattern="#,##0.##"/></th>
	                <!-- fee08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_08_10}" pattern="#,##0.##"/></th>
	                <!-- fee07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_07_10}" pattern="#,##0.##"/></th>
	                <!-- fee06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_06_10}" pattern="#,##0.##"/></th>
	                <!-- fee05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_05_10}" pattern="#,##0.##"/></th>
	                <!-- fee04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_04_10}" pattern="#,##0.##"/></th>
	                <!-- fee03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_03_10}" pattern="#,##0.##"/></th>
	                <!-- fee02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_02_10}" pattern="#,##0.##"/></th>
	                <!-- fee01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_01_10}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="feeColTotalSum_10" value="${feeTeamTotalSum_12_10 + feeTeamTotalSum_11_10 + feeTeamTotalSum_10_10 + feeTeamTotalSum_09_10 + feeTeamTotalSum_08_10 + feeTeamTotalSum_07_10 + feeTeamTotalSum_06_10 + feeTeamTotalSum_05_10 + feeTeamTotalSum_04_10 + feeTeamTotalSum_03_10 + feeTeamTotalSum_02_10 + feeTeamTotalSum_01_10}"></c:set>
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
   				<c:set var="teamCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 센터명 -->
   				<c:set var="preTeamName" value=""></c:set>
   				
   				<!-- 센터별 계 -->
	            <c:set var="feeTeamSum_12_15" value="0"></c:set>
	            <c:set var="feeTeamSum_11_15" value="0"></c:set>
	            <c:set var="feeTeamSum_10_15" value="0"></c:set>
	            <c:set var="feeTeamSum_09_15" value="0"></c:set>
	            <c:set var="feeTeamSum_08_15" value="0"></c:set>
	            <c:set var="feeTeamSum_07_15" value="0"></c:set>
	            <c:set var="feeTeamSum_06_15" value="0"></c:set>
	            <c:set var="feeTeamSum_05_15" value="0"></c:set>
	            <c:set var="feeTeamSum_04_15" value="0"></c:set>
	            <c:set var="feeTeamSum_03_15" value="0"></c:set>
	            <c:set var="feeTeamSum_02_15" value="0"></c:set>
	            <c:set var="feeTeamSum_01_15" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="feeTeamTotalSum_12_15" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_11_15" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_10_15" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_09_15" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_08_15" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_07_15" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_06_15" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_05_15" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_04_15" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_03_15" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_02_15" value="0"></c:set>
	            <c:set var="feeTeamTotalSum_01_15" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="feeColTeamTotalSum_15" value="0"></c:set>
   				    			
    			<c:forEach var="vo2" items="${ptnrStatFeeList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCenterFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
		                    	1종 기타
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo2.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatMember(${vo2.ptnrId},${vo2.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.teamName}</td>
		                		<td style="width:150px;">${vo2.ptnrIdSubNm}</td>
		                		<!-- 센터별 계 초기화 -->
					            <c:set var="feeTeamSum_12_15" value="0"></c:set>
					            <c:set var="feeTeamSum_11_15" value="0"></c:set>
					            <c:set var="feeTeamSum_10_15" value="0"></c:set>
					            <c:set var="feeTeamSum_09_15" value="0"></c:set>
					            <c:set var="feeTeamSum_08_15" value="0"></c:set>
					            <c:set var="feeTeamSum_07_15" value="0"></c:set>
					            <c:set var="feeTeamSum_06_15" value="0"></c:set>
					            <c:set var="feeTeamSum_05_15" value="0"></c:set>
					            <c:set var="feeTeamSum_04_15" value="0"></c:set>
					            <c:set var="feeTeamSum_03_15" value="0"></c:set>
					            <c:set var="feeTeamSum_02_15" value="0"></c:set>
					            <c:set var="feeTeamSum_01_15" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${teamCnt == 1 and vo2.teamName != preTeamName}">
		                				<td onclick="goPtnrStatMember(${vo2.ptnrId},${vo2.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${vo2.rowCnt+1}">${vo2.teamName}</td>
		                				<td style="width:150px;">${vo2.ptnrIdSubNm}</td>		                				
		                				<c:set var="preTeamName" value="${vo2.teamName}"></c:set>
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
	    				<c:set var="feeTeamSum_12_15" value="${feeTeamSum_12_15+fee12_15}"></c:set>
			            <c:set var="feeTeamSum_11_15" value="${feeTeamSum_11_15+fee11_15}"></c:set>
			            <c:set var="feeTeamSum_10_15" value="${feeTeamSum_10_15+fee10_15}"></c:set>
			            <c:set var="feeTeamSum_09_15" value="${feeTeamSum_09_15+fee09_15}"></c:set>
			            <c:set var="feeTeamSum_08_15" value="${feeTeamSum_08_15+fee08_15}"></c:set>
			            <c:set var="feeTeamSum_07_15" value="${feeTeamSum_07_15+fee07_15}"></c:set>
			            <c:set var="feeTeamSum_06_15" value="${feeTeamSum_06_15+fee06_15}"></c:set>
			            <c:set var="feeTeamSum_05_15" value="${feeTeamSum_05_15+fee05_15}"></c:set>
			            <c:set var="feeTeamSum_04_15" value="${feeTeamSum_04_15+fee04_15}"></c:set>
			            <c:set var="feeTeamSum_03_15" value="${feeTeamSum_03_15+fee03_15}"></c:set>
			            <c:set var="feeTeamSum_02_15" value="${feeTeamSum_02_15+fee02_15}"></c:set>
			            <c:set var="feeTeamSum_01_15" value="${feeTeamSum_01_15+fee01_15}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="feeTeamTotalSum_12_15" value="${feeTeamTotalSum_12_15 + fee12_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_11_15" value="${feeTeamTotalSum_11_15 + fee11_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_10_15" value="${feeTeamTotalSum_10_15 + fee10_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_09_15" value="${feeTeamTotalSum_09_15 + fee09_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_08_15" value="${feeTeamTotalSum_08_15 + fee08_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_07_15" value="${feeTeamTotalSum_07_15 + fee07_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_06_15" value="${feeTeamTotalSum_06_15 + fee06_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_05_15" value="${feeTeamTotalSum_05_15 + fee05_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_04_15" value="${feeTeamTotalSum_04_15 + fee04_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_03_15" value="${feeTeamTotalSum_03_15 + fee03_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_02_15" value="${feeTeamTotalSum_02_15 + fee02_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_01_15" value="${feeTeamTotalSum_01_15 + fee01_15}"></c:set>
		    		</tr>
		    		<!-- 센터별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo2.rowCnt and vo2.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- fee12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_12_15}" pattern="#,##0.##"/></td>
			                <!-- fee11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_11_15}" pattern="#,##0.##"/></td>
			                <!-- fee10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_10_15}" pattern="#,##0.##"/></td>
			                <!-- fee09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_09_15}" pattern="#,##0.##"/></td>
			                <!-- fee08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_08_15}" pattern="#,##0.##"/></td>
			                <!-- fee07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_07_15}" pattern="#,##0.##"/></td>
			                <!-- fee06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_06_15}" pattern="#,##0.##"/></td>
			                <!-- fee05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_05_15}" pattern="#,##0.##"/></td>
			                <!-- fee04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_04_15}" pattern="#,##0.##"/></td>
			                <!-- fee03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_03_15}" pattern="#,##0.##"/></td>
			                <!-- fee02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_02_15}" pattern="#,##0.##"/></td>
			                <!-- fee01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamSum_01_15}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="feeTeamColSum_15" value="${feeTeamSum_12_15 + feeTeamSum_11_15 + feeTeamSum_10_15 + feeTeamSum_09_15 + feeTeamSum_08_15 + feeTeamSum_07_15 + feeTeamSum_06_15 + feeTeamSum_05_15 + feeTeamSum_04_15 + feeTeamSum_03_15 + feeTeamSum_02_15 + feeTeamSum_01_15}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamColSum_15}" pattern="#,##0.##"/></td>
			                
							<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="feeTeamSum_12_15" value="0"></c:set>
				            <c:set var="feeTeamSum_11_15" value="0"></c:set>
				            <c:set var="feeTeamSum_10_15" value="0"></c:set>
				            <c:set var="feeTeamSum_09_15" value="0"></c:set>
				            <c:set var="feeTeamSum_08_15" value="0"></c:set>
				            <c:set var="feeTeamSum_07_15" value="0"></c:set>
				            <c:set var="feeTeamSum_06_15" value="0"></c:set>
				            <c:set var="feeTeamSum_05_15" value="0"></c:set>
				            <c:set var="feeTeamSum_04_15" value="0"></c:set>
				            <c:set var="feeTeamSum_03_15" value="0"></c:set>
				            <c:set var="feeTeamSum_02_15" value="0"></c:set>
				            <c:set var="feeTeamSum_01_15" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo2.rowCnt == 1}">
		    				<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="feeTeamSum_12_15" value="0"></c:set>
				            <c:set var="feeTeamSum_11_15" value="0"></c:set>
				            <c:set var="feeTeamSum_10_15" value="0"></c:set>
				            <c:set var="feeTeamSum_09_15" value="0"></c:set>
				            <c:set var="feeTeamSum_08_15" value="0"></c:set>
				            <c:set var="feeTeamSum_07_15" value="0"></c:set>
				            <c:set var="feeTeamSum_06_15" value="0"></c:set>
				            <c:set var="feeTeamSum_05_15" value="0"></c:set>
				            <c:set var="feeTeamSum_04_15" value="0"></c:set>
				            <c:set var="feeTeamSum_03_15" value="0"></c:set>
				            <c:set var="feeTeamSum_02_15" value="0"></c:set>
				            <c:set var="feeTeamSum_01_15" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 센터별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 센터별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 기타 소계 시작 -->
		    	<c:if test="${ptnrStatFeeList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 기타 소계</th>
	                <!-- fee12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_12_15}" pattern="#,##0.##"/></th>
	                <!-- fee11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_11_15}" pattern="#,##0.##"/></th>
	                <!-- fee10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_10_15}" pattern="#,##0.##"/></th>
	                <!-- fee09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_09_15}" pattern="#,##0.##"/></th>
	                <!-- fee08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_08_15}" pattern="#,##0.##"/></th>
	                <!-- fee07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_07_15}" pattern="#,##0.##"/></th>
	                <!-- fee06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_06_15}" pattern="#,##0.##"/></th>
	                <!-- fee05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_05_15}" pattern="#,##0.##"/></th>
	                <!-- fee04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_04_15}" pattern="#,##0.##"/></th>
	                <!-- fee03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_03_15}" pattern="#,##0.##"/></th>
	                <!-- fee02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_02_15}" pattern="#,##0.##"/></th>
	                <!-- fee01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamTotalSum_01_15}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="feeColTotalSum_15" value="${feeTeamTotalSum_12_15 + feeTeamTotalSum_11_15 + feeTeamTotalSum_10_15 + feeTeamTotalSum_09_15 + feeTeamTotalSum_08_15 + feeTeamTotalSum_07_15 + feeTeamTotalSum_06_15 + feeTeamTotalSum_05_15 + feeTeamTotalSum_04_15 + feeTeamTotalSum_03_15 + feeTeamTotalSum_02_15 + feeTeamTotalSum_01_15}"></c:set>
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
    <c:set var="feeTeamTotalSum_12_all" value="${feeTeamTotalSum_12_5 + feeTeamTotalSum_12_10 + feeTeamTotalSum_12_15}"></c:set>
    <c:set var="feeTeamTotalSum_11_all" value="${feeTeamTotalSum_11_5 + feeTeamTotalSum_11_10 + feeTeamTotalSum_11_15}"></c:set>
    <c:set var="feeTeamTotalSum_10_all" value="${feeTeamTotalSum_10_5 + feeTeamTotalSum_10_10 + feeTeamTotalSum_10_15}"></c:set>
    <c:set var="feeTeamTotalSum_09_all" value="${feeTeamTotalSum_09_5 + feeTeamTotalSum_09_10 + feeTeamTotalSum_09_15}"></c:set>
    <c:set var="feeTeamTotalSum_08_all" value="${feeTeamTotalSum_08_5 + feeTeamTotalSum_08_10 + feeTeamTotalSum_08_15}"></c:set>
    <c:set var="feeTeamTotalSum_07_all" value="${feeTeamTotalSum_07_5 + feeTeamTotalSum_07_10 + feeTeamTotalSum_07_15}"></c:set>
    <c:set var="feeTeamTotalSum_06_all" value="${feeTeamTotalSum_06_5 + feeTeamTotalSum_06_10 + feeTeamTotalSum_06_15}"></c:set>
    <c:set var="feeTeamTotalSum_05_all" value="${feeTeamTotalSum_05_5 + feeTeamTotalSum_05_10 + feeTeamTotalSum_05_15}"></c:set>
    <c:set var="feeTeamTotalSum_04_all" value="${feeTeamTotalSum_04_5 + feeTeamTotalSum_04_10 + feeTeamTotalSum_04_15}"></c:set>
    <c:set var="feeTeamTotalSum_03_all" value="${feeTeamTotalSum_03_5 + feeTeamTotalSum_03_10 + feeTeamTotalSum_03_15}"></c:set>
    <c:set var="feeTeamTotalSum_02_all" value="${feeTeamTotalSum_02_5 + feeTeamTotalSum_02_10 + feeTeamTotalSum_02_15}"></c:set>
    <c:set var="feeTeamTotalSum_01_all" value="${feeTeamTotalSum_01_5 + feeTeamTotalSum_01_10 + feeTeamTotalSum_01_15}"></c:set>        
    <c:set var="feeTeamTotalSum_col_all" value="${feeTeamTotalSum_12_all + feeTeamTotalSum_11_all + feeTeamTotalSum_10_all + feeTeamTotalSum_09_all + feeTeamTotalSum_08_all + feeTeamTotalSum_07_all + feeTeamTotalSum_06_all + feeTeamTotalSum_05_all + feeTeamTotalSum_04_all + feeTeamTotalSum_03_all + feeTeamTotalSum_02_all + feeTeamTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체합계</th>    			
    			<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamTotalSum_01_all}" pattern="#,##0.##"/></th>
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamTotalSum_col_all}" pattern="#,##0.##"/></th>    			
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>