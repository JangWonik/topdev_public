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
   				<!-- 팀별 계를 만들기 위한 변수 -->
   				<c:set var="teamCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 팀명 -->
   				<c:set var="preTeamName" value=""></c:set>
   				
   				<!-- 팀별 계 -->
	            <c:set var="trafficTeamSum_12_5" value="0"></c:set>
	            <c:set var="trafficTeamSum_11_5" value="0"></c:set>
	            <c:set var="trafficTeamSum_10_5" value="0"></c:set>
	            <c:set var="trafficTeamSum_09_5" value="0"></c:set>
	            <c:set var="trafficTeamSum_08_5" value="0"></c:set>
	            <c:set var="trafficTeamSum_07_5" value="0"></c:set>
	            <c:set var="trafficTeamSum_06_5" value="0"></c:set>
	            <c:set var="trafficTeamSum_05_5" value="0"></c:set>
	            <c:set var="trafficTeamSum_04_5" value="0"></c:set>
	            <c:set var="trafficTeamSum_03_5" value="0"></c:set>
	            <c:set var="trafficTeamSum_02_5" value="0"></c:set>
	            <c:set var="trafficTeamSum_01_5" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="trafficTeamTotalSum_12_5" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_11_5" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_10_5" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_09_5" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_08_5" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_07_5" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_06_5" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_05_5" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_04_5" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_03_5" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_02_5" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_01_5" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="trafficColTeamTotalSum_5" value="0"></c:set>
   				    			
    			<c:forEach var="vo" items="${ptnrStatTrafficList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCenterTraffic');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
		                    	1종 조사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatMember(${vo.ptnrId},${vo.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.teamName}</td>
		                		<td style="width:150px;">${vo.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="trafficTeamSum_12_5" value="0"></c:set>
					            <c:set var="trafficTeamSum_11_5" value="0"></c:set>
					            <c:set var="trafficTeamSum_10_5" value="0"></c:set>
					            <c:set var="trafficTeamSum_09_5" value="0"></c:set>
					            <c:set var="trafficTeamSum_08_5" value="0"></c:set>
					            <c:set var="trafficTeamSum_07_5" value="0"></c:set>
					            <c:set var="trafficTeamSum_06_5" value="0"></c:set>
					            <c:set var="trafficTeamSum_05_5" value="0"></c:set>
					            <c:set var="trafficTeamSum_04_5" value="0"></c:set>
					            <c:set var="trafficTeamSum_03_5" value="0"></c:set>
					            <c:set var="trafficTeamSum_02_5" value="0"></c:set>
					            <c:set var="trafficTeamSum_01_5" value="0"></c:set>
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
			    		<c:set var="traffic12_5" value="${vo.traffic12}"></c:set>
			            <c:set var="traffic11_5" value="${vo.traffic11}"></c:set>
			            <c:set var="traffic10_5" value="${vo.traffic10}"></c:set>
			            <c:set var="traffic09_5" value="${vo.traffic09}"></c:set>
			            <c:set var="traffic08_5" value="${vo.traffic08}"></c:set>
			            <c:set var="traffic07_5" value="${vo.traffic07}"></c:set>
			            <c:set var="traffic06_5" value="${vo.traffic06}"></c:set>
			            <c:set var="traffic05_5" value="${vo.traffic05}"></c:set>
			            <c:set var="traffic04_5" value="${vo.traffic04}"></c:set>
			            <c:set var="traffic03_5" value="${vo.traffic03}"></c:set>
			            <c:set var="traffic02_5" value="${vo.traffic02}"></c:set>
			            <c:set var="traffic01_5" value="${vo.traffic01}"></c:set>
			            
			            <!-- traffic12 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${traffic12_5}" pattern="#,##0.##"/></td>
	                    <!-- traffic11 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic11_5}" pattern="#,##0.##"/></td>
	                    <!-- traffic10 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic10_5}" pattern="#,##0.##"/></td>
	                    <!-- traffic09 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic09_5}" pattern="#,##0.##"/></td>
	                    <!-- traffic08 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic08_5}" pattern="#,##0.##"/></td>
	                    <!-- traffic07 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic07_5}" pattern="#,##0.##"/></td>
	                    <!-- traffic06 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic06_5}" pattern="#,##0.##"/></td>
	                    <!-- traffic05 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic05_5}" pattern="#,##0.##"/></td>
	                    <!-- traffic04 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic04_5}" pattern="#,##0.##"/></td>
	                    <!-- traffic03 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic03_5}" pattern="#,##0.##"/></td>
	                    <!-- traffic02 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic02_5}" pattern="#,##0.##"/></td>
	                    <!-- traffic01 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic01_5}" pattern="#,##0.##"/></td>
		                <!-- 가로 합계 -->
		                <c:set var="trafficColSum_5" value="${traffic12_5 + traffic11_5 + traffic10_5 + traffic09_5 + traffic08_5 + traffic07_5 + traffic06_5 + traffic05_5 + traffic04_5 + traffic03_5 + traffic02_5 + traffic01_5}"></c:set>                    
		                <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficColSum_5}" pattern="#,##0.##"/></td>
		                
		                <!-- 팀별 계 합산 -->
	    				<c:set var="trafficTeamSum_12_5" value="${trafficTeamSum_12_5+traffic12_5}"></c:set>
			            <c:set var="trafficTeamSum_11_5" value="${trafficTeamSum_11_5+traffic11_5}"></c:set>
			            <c:set var="trafficTeamSum_10_5" value="${trafficTeamSum_10_5+traffic10_5}"></c:set>
			            <c:set var="trafficTeamSum_09_5" value="${trafficTeamSum_09_5+traffic09_5}"></c:set>
			            <c:set var="trafficTeamSum_08_5" value="${trafficTeamSum_08_5+traffic08_5}"></c:set>
			            <c:set var="trafficTeamSum_07_5" value="${trafficTeamSum_07_5+traffic07_5}"></c:set>
			            <c:set var="trafficTeamSum_06_5" value="${trafficTeamSum_06_5+traffic06_5}"></c:set>
			            <c:set var="trafficTeamSum_05_5" value="${trafficTeamSum_05_5+traffic05_5}"></c:set>
			            <c:set var="trafficTeamSum_04_5" value="${trafficTeamSum_04_5+traffic04_5}"></c:set>
			            <c:set var="trafficTeamSum_03_5" value="${trafficTeamSum_03_5+traffic03_5}"></c:set>
			            <c:set var="trafficTeamSum_02_5" value="${trafficTeamSum_02_5+traffic02_5}"></c:set>
			            <c:set var="trafficTeamSum_01_5" value="${trafficTeamSum_01_5+traffic01_5}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="trafficTeamTotalSum_12_5" value="${trafficTeamTotalSum_12_5 + traffic12_5}"></c:set>
	                    <c:set var="trafficTeamTotalSum_11_5" value="${trafficTeamTotalSum_11_5 + traffic11_5}"></c:set>
	                    <c:set var="trafficTeamTotalSum_10_5" value="${trafficTeamTotalSum_10_5 + traffic10_5}"></c:set>
	                    <c:set var="trafficTeamTotalSum_09_5" value="${trafficTeamTotalSum_09_5 + traffic09_5}"></c:set>
	                    <c:set var="trafficTeamTotalSum_08_5" value="${trafficTeamTotalSum_08_5 + traffic08_5}"></c:set>
	                    <c:set var="trafficTeamTotalSum_07_5" value="${trafficTeamTotalSum_07_5 + traffic07_5}"></c:set>
	                    <c:set var="trafficTeamTotalSum_06_5" value="${trafficTeamTotalSum_06_5 + traffic06_5}"></c:set>
	                    <c:set var="trafficTeamTotalSum_05_5" value="${trafficTeamTotalSum_05_5 + traffic05_5}"></c:set>
	                    <c:set var="trafficTeamTotalSum_04_5" value="${trafficTeamTotalSum_04_5 + traffic04_5}"></c:set>
	                    <c:set var="trafficTeamTotalSum_03_5" value="${trafficTeamTotalSum_03_5 + traffic03_5}"></c:set>
	                    <c:set var="trafficTeamTotalSum_02_5" value="${trafficTeamTotalSum_02_5 + traffic02_5}"></c:set>
	                    <c:set var="trafficTeamTotalSum_01_5" value="${trafficTeamTotalSum_01_5 + traffic01_5}"></c:set>
		    		</tr>
		    		<!-- 팀별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo.rowCnt and vo.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- traffic12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_12_5}" pattern="#,##0.##"/></td>
			                <!-- traffic11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_11_5}" pattern="#,##0.##"/></td>
			                <!-- traffic10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_10_5}" pattern="#,##0.##"/></td>
			                <!-- traffic09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_09_5}" pattern="#,##0.##"/></td>
			                <!-- traffic08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_08_5}" pattern="#,##0.##"/></td>
			                <!-- traffic07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_07_5}" pattern="#,##0.##"/></td>
			                <!-- traffic06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_06_5}" pattern="#,##0.##"/></td>
			                <!-- traffic05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_05_5}" pattern="#,##0.##"/></td>
			                <!-- traffic04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_04_5}" pattern="#,##0.##"/></td>
			                <!-- traffic03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_03_5}" pattern="#,##0.##"/></td>
			                <!-- traffic02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_02_5}" pattern="#,##0.##"/></td>
			                <!-- traffic01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_01_5}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="trafficTeamColSum_5" value="${trafficTeamSum_12_5 + trafficTeamSum_11_5 + trafficTeamSum_10_5 + trafficTeamSum_09_5 + trafficTeamSum_08_5 + trafficTeamSum_07_5 + trafficTeamSum_06_5 + trafficTeamSum_05_5 + trafficTeamSum_04_5 + trafficTeamSum_03_5 + trafficTeamSum_02_5 + trafficTeamSum_01_5}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamColSum_5}" pattern="#,##0.##"/></td>
			                
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="trafficTeamSum_12_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_11_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_10_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_09_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_08_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_07_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_06_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_05_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_04_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_03_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_02_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_01_5" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo.rowCnt == 1}">
		    				<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="trafficTeamSum_12_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_11_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_10_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_09_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_08_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_07_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_06_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_05_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_04_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_03_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_02_5" value="0"></c:set>
				            <c:set var="trafficTeamSum_01_5" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 팀별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 팀별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 조사 소계 시작 -->
		    	<c:if test="${ptnrStatTrafficList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 조사 소계</th>
	                <!-- traffic12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_12_5}" pattern="#,##0.##"/></th>
	                <!-- traffic11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_11_5}" pattern="#,##0.##"/></th>
	                <!-- traffic10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_10_5}" pattern="#,##0.##"/></th>
	                <!-- traffic09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_09_5}" pattern="#,##0.##"/></th>
	                <!-- traffic08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_08_5}" pattern="#,##0.##"/></th>
	                <!-- traffic07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_07_5}" pattern="#,##0.##"/></th>
	                <!-- traffic06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_06_5}" pattern="#,##0.##"/></th>
	                <!-- traffic05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_05_5}" pattern="#,##0.##"/></th>
	                <!-- traffic04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_04_5}" pattern="#,##0.##"/></th>
	                <!-- traffic03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_03_5}" pattern="#,##0.##"/></th>
	                <!-- traffic02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_02_5}" pattern="#,##0.##"/></th>
	                <!-- traffic01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_01_5}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="trafficColTotalSum_5" value="${trafficTeamTotalSum_12_5 + trafficTeamTotalSum_11_5 + trafficTeamTotalSum_10_5 + trafficTeamTotalSum_09_5 + trafficTeamTotalSum_08_5 + trafficTeamTotalSum_07_5 + trafficTeamTotalSum_06_5 + trafficTeamTotalSum_05_5 + trafficTeamTotalSum_04_5 + trafficTeamTotalSum_03_5 + trafficTeamTotalSum_02_5 + trafficTeamTotalSum_01_5}"></c:set>
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficColTotalSum_5}" pattern="#,##0.##"/></th>	                
	            </tr>
	            </c:if>
		    	<!-- 1종 조사 소계 끝 -->
    		</tbody>
    	</table>    	    	
    	<!-- 1종 조사 끝 -->
    	
    	<!-- 1종 심사 시작 -->
    	<table>
    		<tbody>
   				<!-- 팀별 계를 만들기 위한 변수 -->
   				<c:set var="teamCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 팀명 -->
   				<c:set var="preTeamName" value=""></c:set>
   				
   				<!-- 팀별 계 -->
	            <c:set var="trafficTeamSum_12_10" value="0"></c:set>
	            <c:set var="trafficTeamSum_11_10" value="0"></c:set>
	            <c:set var="trafficTeamSum_10_10" value="0"></c:set>
	            <c:set var="trafficTeamSum_09_10" value="0"></c:set>
	            <c:set var="trafficTeamSum_08_10" value="0"></c:set>
	            <c:set var="trafficTeamSum_07_10" value="0"></c:set>
	            <c:set var="trafficTeamSum_06_10" value="0"></c:set>
	            <c:set var="trafficTeamSum_05_10" value="0"></c:set>
	            <c:set var="trafficTeamSum_04_10" value="0"></c:set>
	            <c:set var="trafficTeamSum_03_10" value="0"></c:set>
	            <c:set var="trafficTeamSum_02_10" value="0"></c:set>
	            <c:set var="trafficTeamSum_01_10" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="trafficTeamTotalSum_12_10" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_11_10" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_10_10" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_09_10" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_08_10" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_07_10" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_06_10" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_05_10" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_04_10" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_03_10" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_02_10" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_01_10" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="trafficColTeamTotalSum_10" value="0"></c:set>
   				    			
    			<c:forEach var="vo1" items="${ptnrStatTrafficList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCenterTraffic');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
		                    	1종 심사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo1.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatMember(${vo1.ptnrId},${vo1.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.teamName}</td>
		                		<td style="width:150px;">${vo1.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="trafficTeamSum_12_10" value="0"></c:set>
					            <c:set var="trafficTeamSum_11_10" value="0"></c:set>
					            <c:set var="trafficTeamSum_10_10" value="0"></c:set>
					            <c:set var="trafficTeamSum_09_10" value="0"></c:set>
					            <c:set var="trafficTeamSum_08_10" value="0"></c:set>
					            <c:set var="trafficTeamSum_07_10" value="0"></c:set>
					            <c:set var="trafficTeamSum_06_10" value="0"></c:set>
					            <c:set var="trafficTeamSum_05_10" value="0"></c:set>
					            <c:set var="trafficTeamSum_04_10" value="0"></c:set>
					            <c:set var="trafficTeamSum_03_10" value="0"></c:set>
					            <c:set var="trafficTeamSum_02_10" value="0"></c:set>
					            <c:set var="trafficTeamSum_01_10" value="0"></c:set>
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
			    		<c:set var="traffic12_10" value="${vo1.traffic12}"></c:set>
			            <c:set var="traffic11_10" value="${vo1.traffic11}"></c:set>
			            <c:set var="traffic10_10" value="${vo1.traffic10}"></c:set>
			            <c:set var="traffic09_10" value="${vo1.traffic09}"></c:set>
			            <c:set var="traffic08_10" value="${vo1.traffic08}"></c:set>
			            <c:set var="traffic07_10" value="${vo1.traffic07}"></c:set>
			            <c:set var="traffic06_10" value="${vo1.traffic06}"></c:set>
			            <c:set var="traffic05_10" value="${vo1.traffic05}"></c:set>
			            <c:set var="traffic04_10" value="${vo1.traffic04}"></c:set>
			            <c:set var="traffic03_10" value="${vo1.traffic03}"></c:set>
			            <c:set var="traffic02_10" value="${vo1.traffic02}"></c:set>
			            <c:set var="traffic01_10" value="${vo1.traffic01}"></c:set>
			            
			            <!-- traffic12 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${traffic12_10}" pattern="#,##0.##"/></td>
	                    <!-- traffic11 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic11_10}" pattern="#,##0.##"/></td>
	                    <!-- traffic10 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic10_10}" pattern="#,##0.##"/></td>
	                    <!-- traffic09 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic09_10}" pattern="#,##0.##"/></td>
	                    <!-- traffic08 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic08_10}" pattern="#,##0.##"/></td>
	                    <!-- traffic07 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic07_10}" pattern="#,##0.##"/></td>
	                    <!-- traffic06 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic06_10}" pattern="#,##0.##"/></td>
	                    <!-- traffic05 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic05_10}" pattern="#,##0.##"/></td>
	                    <!-- traffic04 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic04_10}" pattern="#,##0.##"/></td>
	                    <!-- traffic03 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic03_10}" pattern="#,##0.##"/></td>
	                    <!-- traffic02 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic02_10}" pattern="#,##0.##"/></td>
	                    <!-- traffic01 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic01_10}" pattern="#,##0.##"/></td>
	                    <!-- 가로 합계 -->
	                    <c:set var="trafficColSum_10" value="${traffic12_10 + traffic11_10 + traffic10_10 + traffic09_10 + traffic08_10 + traffic07_10 + traffic06_10 + traffic05_10 + traffic04_10 + traffic03_10 + traffic02_10 + traffic01_10}"></c:set>                    
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficColSum_10}" pattern="#,##0.##"/></td>
		                
		                <!-- 팀별 계 합산 -->
	    				<c:set var="trafficTeamSum_12_10" value="${trafficTeamSum_12_10+traffic12_10}"></c:set>
			            <c:set var="trafficTeamSum_11_10" value="${trafficTeamSum_11_10+traffic11_10}"></c:set>
			            <c:set var="trafficTeamSum_10_10" value="${trafficTeamSum_10_10+traffic10_10}"></c:set>
			            <c:set var="trafficTeamSum_09_10" value="${trafficTeamSum_09_10+traffic09_10}"></c:set>
			            <c:set var="trafficTeamSum_08_10" value="${trafficTeamSum_08_10+traffic08_10}"></c:set>
			            <c:set var="trafficTeamSum_07_10" value="${trafficTeamSum_07_10+traffic07_10}"></c:set>
			            <c:set var="trafficTeamSum_06_10" value="${trafficTeamSum_06_10+traffic06_10}"></c:set>
			            <c:set var="trafficTeamSum_05_10" value="${trafficTeamSum_05_10+traffic05_10}"></c:set>
			            <c:set var="trafficTeamSum_04_10" value="${trafficTeamSum_04_10+traffic04_10}"></c:set>
			            <c:set var="trafficTeamSum_03_10" value="${trafficTeamSum_03_10+traffic03_10}"></c:set>
			            <c:set var="trafficTeamSum_02_10" value="${trafficTeamSum_02_10+traffic02_10}"></c:set>
			            <c:set var="trafficTeamSum_01_10" value="${trafficTeamSum_01_10+traffic01_10}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="trafficTeamTotalSum_12_10" value="${trafficTeamTotalSum_12_10 + traffic12_10}"></c:set>
	                    <c:set var="trafficTeamTotalSum_11_10" value="${trafficTeamTotalSum_11_10 + traffic11_10}"></c:set>
	                    <c:set var="trafficTeamTotalSum_10_10" value="${trafficTeamTotalSum_10_10 + traffic10_10}"></c:set>
	                    <c:set var="trafficTeamTotalSum_09_10" value="${trafficTeamTotalSum_09_10 + traffic09_10}"></c:set>
	                    <c:set var="trafficTeamTotalSum_08_10" value="${trafficTeamTotalSum_08_10 + traffic08_10}"></c:set>
	                    <c:set var="trafficTeamTotalSum_07_10" value="${trafficTeamTotalSum_07_10 + traffic07_10}"></c:set>
	                    <c:set var="trafficTeamTotalSum_06_10" value="${trafficTeamTotalSum_06_10 + traffic06_10}"></c:set>
	                    <c:set var="trafficTeamTotalSum_05_10" value="${trafficTeamTotalSum_05_10 + traffic05_10}"></c:set>
	                    <c:set var="trafficTeamTotalSum_04_10" value="${trafficTeamTotalSum_04_10 + traffic04_10}"></c:set>
	                    <c:set var="trafficTeamTotalSum_03_10" value="${trafficTeamTotalSum_03_10 + traffic03_10}"></c:set>
	                    <c:set var="trafficTeamTotalSum_02_10" value="${trafficTeamTotalSum_02_10 + traffic02_10}"></c:set>
	                    <c:set var="trafficTeamTotalSum_01_10" value="${trafficTeamTotalSum_01_10 + traffic01_10}"></c:set>
		    		</tr>
		    		<!-- 팀별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo1.rowCnt and vo1.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- traffic12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_12_10}" pattern="#,##0.##"/></td>
			                <!-- traffic11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_11_10}" pattern="#,##0.##"/></td>
			                <!-- traffic10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_10_10}" pattern="#,##0.##"/></td>
			                <!-- traffic09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_09_10}" pattern="#,##0.##"/></td>
			                <!-- traffic08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_08_10}" pattern="#,##0.##"/></td>
			                <!-- traffic07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_07_10}" pattern="#,##0.##"/></td>
			                <!-- traffic06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_06_10}" pattern="#,##0.##"/></td>
			                <!-- traffic05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_05_10}" pattern="#,##0.##"/></td>
			                <!-- traffic04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_04_10}" pattern="#,##0.##"/></td>
			                <!-- traffic03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_03_10}" pattern="#,##0.##"/></td>
			                <!-- traffic02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_02_10}" pattern="#,##0.##"/></td>
			                <!-- traffic01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_01_10}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="trafficTeamColSum_10" value="${trafficTeamSum_12_10 + trafficTeamSum_11_10 + trafficTeamSum_10_10 + trafficTeamSum_09_10 + trafficTeamSum_08_10 + trafficTeamSum_07_10 + trafficTeamSum_06_10 + trafficTeamSum_05_10 + trafficTeamSum_04_10 + trafficTeamSum_03_10 + trafficTeamSum_02_10 + trafficTeamSum_01_10}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamColSum_10}" pattern="#,##0.##"/></td>
			                
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="trafficTeamSum_12_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_11_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_10_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_09_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_08_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_07_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_06_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_05_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_04_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_03_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_02_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_01_10" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo1.rowCnt == 1}">
		    				<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="trafficTeamSum_12_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_11_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_10_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_09_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_08_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_07_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_06_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_05_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_04_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_03_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_02_10" value="0"></c:set>
				            <c:set var="trafficTeamSum_01_10" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 팀별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 팀별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 심사 소계 시작 -->
		    	<c:if test="${ptnrStatTrafficList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 심사 소계</th>
	                <!-- traffic12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_12_10}" pattern="#,##0.##"/></th>
	                <!-- traffic11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_11_10}" pattern="#,##0.##"/></th>
	                <!-- traffic10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_10_10}" pattern="#,##0.##"/></th>
	                <!-- traffic09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_09_10}" pattern="#,##0.##"/></th>
	                <!-- traffic08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_08_10}" pattern="#,##0.##"/></th>
	                <!-- traffic07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_07_10}" pattern="#,##0.##"/></th>
	                <!-- traffic06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_06_10}" pattern="#,##0.##"/></th>
	                <!-- traffic05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_05_10}" pattern="#,##0.##"/></th>
	                <!-- traffic04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_04_10}" pattern="#,##0.##"/></th>
	                <!-- traffic03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_03_10}" pattern="#,##0.##"/></th>
	                <!-- traffic02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_02_10}" pattern="#,##0.##"/></th>
	                <!-- traffic01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_01_10}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="trafficColTotalSum_10" value="${trafficTeamTotalSum_12_10 + trafficTeamTotalSum_11_10 + trafficTeamTotalSum_10_10 + trafficTeamTotalSum_09_10 + trafficTeamTotalSum_08_10 + trafficTeamTotalSum_07_10 + trafficTeamTotalSum_06_10 + trafficTeamTotalSum_05_10 + trafficTeamTotalSum_04_10 + trafficTeamTotalSum_03_10 + trafficTeamTotalSum_02_10 + trafficTeamTotalSum_01_10}"></c:set>
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficColTotalSum_10}" pattern="#,##0.##"/></th>	                
	            </tr>
	            </c:if>
		    	<!-- 1종 심사 소계 끝 -->
    		</tbody>
    	</table>    	
    	<!-- 1종 심사 끝 -->  
    	
    	<!-- 1종 기타 시작 -->
    	<table>
    		<tbody>
   				<!-- 팀별 계를 만들기 위한 변수 -->
   				<c:set var="teamCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 팀명 -->
   				<c:set var="preTeamName" value=""></c:set>
   				
   				<!-- 팀별 계 -->
	            <c:set var="trafficTeamSum_12_15" value="0"></c:set>
	            <c:set var="trafficTeamSum_11_15" value="0"></c:set>
	            <c:set var="trafficTeamSum_10_15" value="0"></c:set>
	            <c:set var="trafficTeamSum_09_15" value="0"></c:set>
	            <c:set var="trafficTeamSum_08_15" value="0"></c:set>
	            <c:set var="trafficTeamSum_07_15" value="0"></c:set>
	            <c:set var="trafficTeamSum_06_15" value="0"></c:set>
	            <c:set var="trafficTeamSum_05_15" value="0"></c:set>
	            <c:set var="trafficTeamSum_04_15" value="0"></c:set>
	            <c:set var="trafficTeamSum_03_15" value="0"></c:set>
	            <c:set var="trafficTeamSum_02_15" value="0"></c:set>
	            <c:set var="trafficTeamSum_01_15" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="trafficTeamTotalSum_12_15" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_11_15" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_10_15" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_09_15" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_08_15" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_07_15" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_06_15" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_05_15" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_04_15" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_03_15" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_02_15" value="0"></c:set>
	            <c:set var="trafficTeamTotalSum_01_15" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="trafficColTeamTotalSum_15" value="0"></c:set>
   				    			
    			<c:forEach var="vo2" items="${ptnrStatTrafficList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCenterTraffic');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
		                    	1종 기타
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo2.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatMember(${vo2.ptnrId},${vo2.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.teamName}</td>
		                		<td style="width:150px;">${vo2.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="trafficTeamSum_12_15" value="0"></c:set>
					            <c:set var="trafficTeamSum_11_15" value="0"></c:set>
					            <c:set var="trafficTeamSum_10_15" value="0"></c:set>
					            <c:set var="trafficTeamSum_09_15" value="0"></c:set>
					            <c:set var="trafficTeamSum_08_15" value="0"></c:set>
					            <c:set var="trafficTeamSum_07_15" value="0"></c:set>
					            <c:set var="trafficTeamSum_06_15" value="0"></c:set>
					            <c:set var="trafficTeamSum_05_15" value="0"></c:set>
					            <c:set var="trafficTeamSum_04_15" value="0"></c:set>
					            <c:set var="trafficTeamSum_03_15" value="0"></c:set>
					            <c:set var="trafficTeamSum_02_15" value="0"></c:set>
					            <c:set var="trafficTeamSum_01_15" value="0"></c:set>
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
			    		<c:set var="traffic12_15" value="${vo2.traffic12}"></c:set>
			            <c:set var="traffic11_15" value="${vo2.traffic11}"></c:set>
			            <c:set var="traffic10_15" value="${vo2.traffic10}"></c:set>
			            <c:set var="traffic09_15" value="${vo2.traffic09}"></c:set>
			            <c:set var="traffic08_15" value="${vo2.traffic08}"></c:set>
			            <c:set var="traffic07_15" value="${vo2.traffic07}"></c:set>
			            <c:set var="traffic06_15" value="${vo2.traffic06}"></c:set>
			            <c:set var="traffic05_15" value="${vo2.traffic05}"></c:set>
			            <c:set var="traffic04_15" value="${vo2.traffic04}"></c:set>
			            <c:set var="traffic03_15" value="${vo2.traffic03}"></c:set>
			            <c:set var="traffic02_15" value="${vo2.traffic02}"></c:set>
			            <c:set var="traffic01_15" value="${vo2.traffic01}"></c:set>
			            
			            <!-- traffic12 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${traffic12_15}" pattern="#,##0.##"/></td>
	                    <!-- traffic11 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic11_15}" pattern="#,##0.##"/></td>
	                    <!-- traffic10 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic10_15}" pattern="#,##0.##"/></td>
	                    <!-- traffic09 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic09_15}" pattern="#,##0.##"/></td>
	                    <!-- traffic08 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic08_15}" pattern="#,##0.##"/></td>
	                    <!-- traffic07 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic07_15}" pattern="#,##0.##"/></td>
	                    <!-- traffic06 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic06_15}" pattern="#,##0.##"/></td>
	                    <!-- traffic05 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic05_15}" pattern="#,##0.##"/></td>
	                    <!-- traffic04 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic04_15}" pattern="#,##0.##"/></td>
	                    <!-- traffic03 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic03_15}" pattern="#,##0.##"/></td>
	                    <!-- traffic02 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic02_15}" pattern="#,##0.##"/></td>
	                    <!-- traffic01 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${traffic01_15}" pattern="#,##0.##"/></td>
	                    <!-- 가로 합계 -->
	                    <c:set var="trafficColSum_15" value="${traffic12_15 + traffic11_15 + traffic10_15 + traffic09_15 + traffic08_15 + traffic07_15 + traffic06_15 + traffic05_15 + traffic04_15 + traffic03_15 + traffic02_15 + traffic01_15}"></c:set>                    
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficColSum_15}" pattern="#,##0.##"/></td>
		                
		                <!-- 팀별 계 합산 -->
	    				<c:set var="trafficTeamSum_12_15" value="${trafficTeamSum_12_15+traffic12_15}"></c:set>
			            <c:set var="trafficTeamSum_11_15" value="${trafficTeamSum_11_15+traffic11_15}"></c:set>
			            <c:set var="trafficTeamSum_10_15" value="${trafficTeamSum_10_15+traffic10_15}"></c:set>
			            <c:set var="trafficTeamSum_09_15" value="${trafficTeamSum_09_15+traffic09_15}"></c:set>
			            <c:set var="trafficTeamSum_08_15" value="${trafficTeamSum_08_15+traffic08_15}"></c:set>
			            <c:set var="trafficTeamSum_07_15" value="${trafficTeamSum_07_15+traffic07_15}"></c:set>
			            <c:set var="trafficTeamSum_06_15" value="${trafficTeamSum_06_15+traffic06_15}"></c:set>
			            <c:set var="trafficTeamSum_05_15" value="${trafficTeamSum_05_15+traffic05_15}"></c:set>
			            <c:set var="trafficTeamSum_04_15" value="${trafficTeamSum_04_15+traffic04_15}"></c:set>
			            <c:set var="trafficTeamSum_03_15" value="${trafficTeamSum_03_15+traffic03_15}"></c:set>
			            <c:set var="trafficTeamSum_02_15" value="${trafficTeamSum_02_15+traffic02_15}"></c:set>
			            <c:set var="trafficTeamSum_01_15" value="${trafficTeamSum_01_15+traffic01_15}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="trafficTeamTotalSum_12_15" value="${trafficTeamTotalSum_12_15 + traffic12_15}"></c:set>
	                    <c:set var="trafficTeamTotalSum_11_15" value="${trafficTeamTotalSum_11_15 + traffic11_15}"></c:set>
	                    <c:set var="trafficTeamTotalSum_10_15" value="${trafficTeamTotalSum_10_15 + traffic10_15}"></c:set>
	                    <c:set var="trafficTeamTotalSum_09_15" value="${trafficTeamTotalSum_09_15 + traffic09_15}"></c:set>
	                    <c:set var="trafficTeamTotalSum_08_15" value="${trafficTeamTotalSum_08_15 + traffic08_15}"></c:set>
	                    <c:set var="trafficTeamTotalSum_07_15" value="${trafficTeamTotalSum_07_15 + traffic07_15}"></c:set>
	                    <c:set var="trafficTeamTotalSum_06_15" value="${trafficTeamTotalSum_06_15 + traffic06_15}"></c:set>
	                    <c:set var="trafficTeamTotalSum_05_15" value="${trafficTeamTotalSum_05_15 + traffic05_15}"></c:set>
	                    <c:set var="trafficTeamTotalSum_04_15" value="${trafficTeamTotalSum_04_15 + traffic04_15}"></c:set>
	                    <c:set var="trafficTeamTotalSum_03_15" value="${trafficTeamTotalSum_03_15 + traffic03_15}"></c:set>
	                    <c:set var="trafficTeamTotalSum_02_15" value="${trafficTeamTotalSum_02_15 + traffic02_15}"></c:set>
	                    <c:set var="trafficTeamTotalSum_01_15" value="${trafficTeamTotalSum_01_15 + traffic01_15}"></c:set>
		    		</tr>
		    		<!-- 팀별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo2.rowCnt and vo2.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- traffic12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_12_15}" pattern="#,##0.##"/></td>
			                <!-- traffic11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_11_15}" pattern="#,##0.##"/></td>
			                <!-- traffic10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_10_15}" pattern="#,##0.##"/></td>
			                <!-- traffic09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_09_15}" pattern="#,##0.##"/></td>
			                <!-- traffic08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_08_15}" pattern="#,##0.##"/></td>
			                <!-- traffic07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_07_15}" pattern="#,##0.##"/></td>
			                <!-- traffic06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_06_15}" pattern="#,##0.##"/></td>
			                <!-- traffic05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_05_15}" pattern="#,##0.##"/></td>
			                <!-- traffic04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_04_15}" pattern="#,##0.##"/></td>
			                <!-- traffic03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_03_15}" pattern="#,##0.##"/></td>
			                <!-- traffic02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_02_15}" pattern="#,##0.##"/></td>
			                <!-- traffic01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamSum_01_15}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="trafficTeamColSum_15" value="${trafficTeamSum_12_15 + trafficTeamSum_11_15 + trafficTeamSum_10_15 + trafficTeamSum_09_15 + trafficTeamSum_08_15 + trafficTeamSum_07_15 + trafficTeamSum_06_15 + trafficTeamSum_05_15 + trafficTeamSum_04_15 + trafficTeamSum_03_15 + trafficTeamSum_02_15 + trafficTeamSum_01_15}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamColSum_15}" pattern="#,##0.##"/></td>
			                
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="trafficTeamSum_12_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_11_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_10_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_09_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_08_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_07_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_06_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_05_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_04_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_03_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_02_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_01_15" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo2.rowCnt == 1}">
		    				<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="trafficTeamSum_12_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_11_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_10_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_09_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_08_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_07_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_06_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_05_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_04_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_03_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_02_15" value="0"></c:set>
				            <c:set var="trafficTeamSum_01_15" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 팀별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 팀별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 기타 소계 시작 -->
		    	<c:if test="${ptnrStatTrafficList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 기타 소계</th>
	                <!-- traffic12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_12_15}" pattern="#,##0.##"/></th>
	                <!-- traffic11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_11_15}" pattern="#,##0.##"/></th>
	                <!-- traffic10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_10_15}" pattern="#,##0.##"/></th>
	                <!-- traffic09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_09_15}" pattern="#,##0.##"/></th>
	                <!-- traffic08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_08_15}" pattern="#,##0.##"/></th>
	                <!-- traffic07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_07_15}" pattern="#,##0.##"/></th>
	                <!-- traffic06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_06_15}" pattern="#,##0.##"/></th>
	                <!-- traffic05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_05_15}" pattern="#,##0.##"/></th>
	                <!-- traffic04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_04_15}" pattern="#,##0.##"/></th>
	                <!-- traffic03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_03_15}" pattern="#,##0.##"/></th>
	                <!-- traffic02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_02_15}" pattern="#,##0.##"/></th>
	                <!-- traffic01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamTotalSum_01_15}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="trafficColTotalSum_15" value="${trafficTeamTotalSum_12_15 + trafficTeamTotalSum_11_15 + trafficTeamTotalSum_10_15 + trafficTeamTotalSum_09_15 + trafficTeamTotalSum_08_15 + trafficTeamTotalSum_07_15 + trafficTeamTotalSum_06_15 + trafficTeamTotalSum_05_15 + trafficTeamTotalSum_04_15 + trafficTeamTotalSum_03_15 + trafficTeamTotalSum_02_15 + trafficTeamTotalSum_01_15}"></c:set>
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficColTotalSum_15}" pattern="#,##0.##"/></th>	                
	            </tr>
	            </c:if>
		    	<!-- 1종 기타 소계 끝 -->
    		</tbody>
    	</table>
    	<!-- 1종 기타 끝 -->  	        
    </div>    
    <!-- 총 합계 시작 -->
    <!-- 총 합계 변수 시작 -->
    <c:set var="trafficTeamTotalSum_12_all" value="${trafficTeamTotalSum_12_5 + trafficTeamTotalSum_12_10 + trafficTeamTotalSum_12_15}"></c:set>
    <c:set var="trafficTeamTotalSum_11_all" value="${trafficTeamTotalSum_11_5 + trafficTeamTotalSum_11_10 + trafficTeamTotalSum_11_15}"></c:set>
    <c:set var="trafficTeamTotalSum_10_all" value="${trafficTeamTotalSum_10_5 + trafficTeamTotalSum_10_10 + trafficTeamTotalSum_10_15}"></c:set>
    <c:set var="trafficTeamTotalSum_09_all" value="${trafficTeamTotalSum_09_5 + trafficTeamTotalSum_09_10 + trafficTeamTotalSum_09_15}"></c:set>
    <c:set var="trafficTeamTotalSum_08_all" value="${trafficTeamTotalSum_08_5 + trafficTeamTotalSum_08_10 + trafficTeamTotalSum_08_15}"></c:set>
    <c:set var="trafficTeamTotalSum_07_all" value="${trafficTeamTotalSum_07_5 + trafficTeamTotalSum_07_10 + trafficTeamTotalSum_07_15}"></c:set>
    <c:set var="trafficTeamTotalSum_06_all" value="${trafficTeamTotalSum_06_5 + trafficTeamTotalSum_06_10 + trafficTeamTotalSum_06_15}"></c:set>
    <c:set var="trafficTeamTotalSum_05_all" value="${trafficTeamTotalSum_05_5 + trafficTeamTotalSum_05_10 + trafficTeamTotalSum_05_15}"></c:set>
    <c:set var="trafficTeamTotalSum_04_all" value="${trafficTeamTotalSum_04_5 + trafficTeamTotalSum_04_10 + trafficTeamTotalSum_04_15}"></c:set>
    <c:set var="trafficTeamTotalSum_03_all" value="${trafficTeamTotalSum_03_5 + trafficTeamTotalSum_03_10 + trafficTeamTotalSum_03_15}"></c:set>
    <c:set var="trafficTeamTotalSum_02_all" value="${trafficTeamTotalSum_02_5 + trafficTeamTotalSum_02_10 + trafficTeamTotalSum_02_15}"></c:set>
    <c:set var="trafficTeamTotalSum_01_all" value="${trafficTeamTotalSum_01_5 + trafficTeamTotalSum_01_10 + trafficTeamTotalSum_01_15}"></c:set>        
    <c:set var="trafficTeamTotalSum_col_all" value="${trafficTeamTotalSum_12_all + trafficTeamTotalSum_11_all + trafficTeamTotalSum_10_all + trafficTeamTotalSum_09_all + trafficTeamTotalSum_08_all + trafficTeamTotalSum_07_all + trafficTeamTotalSum_06_all + trafficTeamTotalSum_05_all + trafficTeamTotalSum_04_all + trafficTeamTotalSum_03_all + trafficTeamTotalSum_02_all + trafficTeamTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체합계</th>    			
    			<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamTotalSum_01_all}" pattern="#,##0.##"/></th>
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamTotalSum_col_all}" pattern="#,##0.##"/></th>    			
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>