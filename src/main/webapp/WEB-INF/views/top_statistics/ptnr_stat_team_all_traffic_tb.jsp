<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2">
    <div style="padding-right: 17px;background: #e7ecf1;">
        <table>            
            <tr>
                <th style="width: 80px;height:25px;">Type</th>
                <th style="width: 150px;">센터명</th>
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
   				<c:set var="preTeamAllName" value=""></c:set>
   				
   				<!-- 팀별 계 -->
	            <c:set var="trafficTeamAllSum_12_5" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_11_5" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_10_5" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_09_5" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_08_5" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_07_5" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_06_5" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_05_5" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_04_5" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_03_5" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_02_5" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_01_5" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="trafficTeamAllTotalSum_12_5" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_11_5" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_10_5" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_09_5" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_08_5" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_07_5" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_06_5" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_05_5" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_04_5" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_03_5" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_02_5" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_01_5" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="trafficColTeamAllTotalSum_5" value="0"></c:set>
   				    			
    			<c:forEach var="vo" items="${ptnrStatTeamAllTrafficList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatTraffic');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowTeamAll}">
		                    	1종 조사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo.rowCnt == 1}">
		                		<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>		                		
		                		<td onclick="goPtnrStatMember(${vo.ptnrId},${vo.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.teamName}</td>
		                		<td style="width:150px;">${vo.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="trafficTeamAllSum_12_5" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_11_5" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_10_5" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_09_5" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_08_5" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_07_5" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_06_5" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_05_5" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_04_5" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_03_5" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_02_5" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_01_5" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${teamCnt == 1 and vo.teamName != preTeamAllName}">
		                				<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>
		                				<td onclick="goPtnrStatMember(${vo.ptnrId},${vo.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${vo.rowCnt+1}">${vo.teamName}</td>
		                				<td style="width:150px;">${vo.ptnrIdSubNm}</td>		                				
		                				<c:set var="preTeamAllName" value="${vo.teamName}"></c:set>
		                			</c:when>
		                			<c:otherwise>
		                				<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>		                				
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
	    				<c:set var="trafficTeamAllSum_12_5" value="${trafficTeamAllSum_12_5+traffic12_5}"></c:set>
			            <c:set var="trafficTeamAllSum_11_5" value="${trafficTeamAllSum_11_5+traffic11_5}"></c:set>
			            <c:set var="trafficTeamAllSum_10_5" value="${trafficTeamAllSum_10_5+traffic10_5}"></c:set>
			            <c:set var="trafficTeamAllSum_09_5" value="${trafficTeamAllSum_09_5+traffic09_5}"></c:set>
			            <c:set var="trafficTeamAllSum_08_5" value="${trafficTeamAllSum_08_5+traffic08_5}"></c:set>
			            <c:set var="trafficTeamAllSum_07_5" value="${trafficTeamAllSum_07_5+traffic07_5}"></c:set>
			            <c:set var="trafficTeamAllSum_06_5" value="${trafficTeamAllSum_06_5+traffic06_5}"></c:set>
			            <c:set var="trafficTeamAllSum_05_5" value="${trafficTeamAllSum_05_5+traffic05_5}"></c:set>
			            <c:set var="trafficTeamAllSum_04_5" value="${trafficTeamAllSum_04_5+traffic04_5}"></c:set>
			            <c:set var="trafficTeamAllSum_03_5" value="${trafficTeamAllSum_03_5+traffic03_5}"></c:set>
			            <c:set var="trafficTeamAllSum_02_5" value="${trafficTeamAllSum_02_5+traffic02_5}"></c:set>
			            <c:set var="trafficTeamAllSum_01_5" value="${trafficTeamAllSum_01_5+traffic01_5}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="trafficTeamAllTotalSum_12_5" value="${trafficTeamAllTotalSum_12_5 + traffic12_5}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_11_5" value="${trafficTeamAllTotalSum_11_5 + traffic11_5}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_10_5" value="${trafficTeamAllTotalSum_10_5 + traffic10_5}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_09_5" value="${trafficTeamAllTotalSum_09_5 + traffic09_5}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_08_5" value="${trafficTeamAllTotalSum_08_5 + traffic08_5}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_07_5" value="${trafficTeamAllTotalSum_07_5 + traffic07_5}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_06_5" value="${trafficTeamAllTotalSum_06_5 + traffic06_5}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_05_5" value="${trafficTeamAllTotalSum_05_5 + traffic05_5}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_04_5" value="${trafficTeamAllTotalSum_04_5 + traffic04_5}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_03_5" value="${trafficTeamAllTotalSum_03_5 + traffic03_5}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_02_5" value="${trafficTeamAllTotalSum_02_5 + traffic02_5}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_01_5" value="${trafficTeamAllTotalSum_01_5 + traffic01_5}"></c:set>
		    		</tr>
		    		<!-- 팀별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo.rowCnt and vo.rowCnt > 1}">
		    				<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- traffic12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_12_5}" pattern="#,##0.##"/></td>
			                <!-- traffic11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_11_5}" pattern="#,##0.##"/></td>
			                <!-- traffic10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_10_5}" pattern="#,##0.##"/></td>
			                <!-- traffic09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_09_5}" pattern="#,##0.##"/></td>
			                <!-- traffic08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_08_5}" pattern="#,##0.##"/></td>
			                <!-- traffic07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_07_5}" pattern="#,##0.##"/></td>
			                <!-- traffic06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_06_5}" pattern="#,##0.##"/></td>
			                <!-- traffic05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_05_5}" pattern="#,##0.##"/></td>
			                <!-- traffic04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_04_5}" pattern="#,##0.##"/></td>
			                <!-- traffic03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_03_5}" pattern="#,##0.##"/></td>
			                <!-- traffic02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_02_5}" pattern="#,##0.##"/></td>
			                <!-- traffic01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_01_5}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="trafficTeamAllColSum_5" value="${trafficTeamAllSum_12_5 + trafficTeamAllSum_11_5 + trafficTeamAllSum_10_5 + trafficTeamAllSum_09_5 + trafficTeamAllSum_08_5 + trafficTeamAllSum_07_5 + trafficTeamAllSum_06_5 + trafficTeamAllSum_05_5 + trafficTeamAllSum_04_5 + trafficTeamAllSum_03_5 + trafficTeamAllSum_02_5 + trafficTeamAllSum_01_5}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllColSum_5}" pattern="#,##0.##"/></td>
			                
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="trafficTeamAllSum_12_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_11_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_10_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_09_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_08_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_07_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_06_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_05_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_04_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_03_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_02_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_01_5" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo.rowCnt == 1}">
		    				<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="trafficTeamAllSum_12_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_11_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_10_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_09_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_08_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_07_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_06_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_05_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_04_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_03_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_02_5" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_01_5" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 팀별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 팀별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 조사 소계 시작 -->
		    	<c:if test="${ptnrStatTeamAllTrafficList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="4" style="height:25px;">1종 조사 소계</th>
	                <!-- traffic12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_12_5}" pattern="#,##0.##"/></th>
	                <!-- traffic11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_11_5}" pattern="#,##0.##"/></th>
	                <!-- traffic10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_10_5}" pattern="#,##0.##"/></th>
	                <!-- traffic09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_09_5}" pattern="#,##0.##"/></th>
	                <!-- traffic08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_08_5}" pattern="#,##0.##"/></th>
	                <!-- traffic07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_07_5}" pattern="#,##0.##"/></th>
	                <!-- traffic06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_06_5}" pattern="#,##0.##"/></th>
	                <!-- traffic05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_05_5}" pattern="#,##0.##"/></th>
	                <!-- traffic04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_04_5}" pattern="#,##0.##"/></th>
	                <!-- traffic03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_03_5}" pattern="#,##0.##"/></th>
	                <!-- traffic02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_02_5}" pattern="#,##0.##"/></th>
	                <!-- traffic01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_01_5}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="trafficColTotalSum_5" value="${trafficTeamAllTotalSum_12_5 + trafficTeamAllTotalSum_11_5 + trafficTeamAllTotalSum_10_5 + trafficTeamAllTotalSum_09_5 + trafficTeamAllTotalSum_08_5 + trafficTeamAllTotalSum_07_5 + trafficTeamAllTotalSum_06_5 + trafficTeamAllTotalSum_05_5 + trafficTeamAllTotalSum_04_5 + trafficTeamAllTotalSum_03_5 + trafficTeamAllTotalSum_02_5 + trafficTeamAllTotalSum_01_5}"></c:set>
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
   				<c:set var="preTeamAllName" value=""></c:set>
   				
   				<!-- 팀별 계 -->
	            <c:set var="trafficTeamAllSum_12_10" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_11_10" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_10_10" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_09_10" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_08_10" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_07_10" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_06_10" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_05_10" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_04_10" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_03_10" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_02_10" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_01_10" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="trafficTeamAllTotalSum_12_10" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_11_10" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_10_10" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_09_10" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_08_10" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_07_10" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_06_10" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_05_10" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_04_10" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_03_10" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_02_10" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_01_10" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="trafficColTeamAllTotalSum_10" value="0"></c:set>
   				    			
    			<c:forEach var="vo1" items="${ptnrStatTeamAllTrafficList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatTraffic');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowTeamAll_10}">
		                    	1종 심사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo1.rowCnt == 1}">
		                		<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>		                		
		                		<td onclick="goPtnrStatMember(${vo1.ptnrId},${vo1.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.teamName}</td>
		                		<td style="width:150px;">${vo1.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="trafficTeamAllSum_12_10" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_11_10" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_10_10" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_09_10" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_08_10" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_07_10" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_06_10" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_05_10" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_04_10" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_03_10" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_02_10" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_01_10" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${teamCnt == 1 and vo1.teamName != preTeamAllName}">
		                				<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>
		                				<td onclick="goPtnrStatMember(${vo1.ptnrId},${vo1.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${vo1.rowCnt+1}">${vo1.teamName}</td>
		                				<td style="width:150px;">${vo1.ptnrIdSubNm}</td>		                				
		                				<c:set var="preTeamAllName" value="${vo1.teamName}"></c:set>
		                			</c:when>
		                			<c:otherwise>
		                				<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>		                				
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
	    				<c:set var="trafficTeamAllSum_12_10" value="${trafficTeamAllSum_12_10+traffic12_10}"></c:set>
			            <c:set var="trafficTeamAllSum_11_10" value="${trafficTeamAllSum_11_10+traffic11_10}"></c:set>
			            <c:set var="trafficTeamAllSum_10_10" value="${trafficTeamAllSum_10_10+traffic10_10}"></c:set>
			            <c:set var="trafficTeamAllSum_09_10" value="${trafficTeamAllSum_09_10+traffic09_10}"></c:set>
			            <c:set var="trafficTeamAllSum_08_10" value="${trafficTeamAllSum_08_10+traffic08_10}"></c:set>
			            <c:set var="trafficTeamAllSum_07_10" value="${trafficTeamAllSum_07_10+traffic07_10}"></c:set>
			            <c:set var="trafficTeamAllSum_06_10" value="${trafficTeamAllSum_06_10+traffic06_10}"></c:set>
			            <c:set var="trafficTeamAllSum_05_10" value="${trafficTeamAllSum_05_10+traffic05_10}"></c:set>
			            <c:set var="trafficTeamAllSum_04_10" value="${trafficTeamAllSum_04_10+traffic04_10}"></c:set>
			            <c:set var="trafficTeamAllSum_03_10" value="${trafficTeamAllSum_03_10+traffic03_10}"></c:set>
			            <c:set var="trafficTeamAllSum_02_10" value="${trafficTeamAllSum_02_10+traffic02_10}"></c:set>
			            <c:set var="trafficTeamAllSum_01_10" value="${trafficTeamAllSum_01_10+traffic01_10}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="trafficTeamAllTotalSum_12_10" value="${trafficTeamAllTotalSum_12_10 + traffic12_10}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_11_10" value="${trafficTeamAllTotalSum_11_10 + traffic11_10}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_10_10" value="${trafficTeamAllTotalSum_10_10 + traffic10_10}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_09_10" value="${trafficTeamAllTotalSum_09_10 + traffic09_10}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_08_10" value="${trafficTeamAllTotalSum_08_10 + traffic08_10}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_07_10" value="${trafficTeamAllTotalSum_07_10 + traffic07_10}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_06_10" value="${trafficTeamAllTotalSum_06_10 + traffic06_10}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_05_10" value="${trafficTeamAllTotalSum_05_10 + traffic05_10}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_04_10" value="${trafficTeamAllTotalSum_04_10 + traffic04_10}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_03_10" value="${trafficTeamAllTotalSum_03_10 + traffic03_10}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_02_10" value="${trafficTeamAllTotalSum_02_10 + traffic02_10}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_01_10" value="${trafficTeamAllTotalSum_01_10 + traffic01_10}"></c:set>
		    		</tr>
		    		<!-- 팀별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo1.rowCnt and vo1.rowCnt > 1}">
		    				<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- traffic12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_12_10}" pattern="#,##0.##"/></td>
			                <!-- traffic11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_11_10}" pattern="#,##0.##"/></td>
			                <!-- traffic10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_10_10}" pattern="#,##0.##"/></td>
			                <!-- traffic09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_09_10}" pattern="#,##0.##"/></td>
			                <!-- traffic08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_08_10}" pattern="#,##0.##"/></td>
			                <!-- traffic07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_07_10}" pattern="#,##0.##"/></td>
			                <!-- traffic06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_06_10}" pattern="#,##0.##"/></td>
			                <!-- traffic05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_05_10}" pattern="#,##0.##"/></td>
			                <!-- traffic04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_04_10}" pattern="#,##0.##"/></td>
			                <!-- traffic03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_03_10}" pattern="#,##0.##"/></td>
			                <!-- traffic02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_02_10}" pattern="#,##0.##"/></td>
			                <!-- traffic01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_01_10}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="trafficTeamAllColSum_10" value="${trafficTeamAllSum_12_10 + trafficTeamAllSum_11_10 + trafficTeamAllSum_10_10 + trafficTeamAllSum_09_10 + trafficTeamAllSum_08_10 + trafficTeamAllSum_07_10 + trafficTeamAllSum_06_10 + trafficTeamAllSum_05_10 + trafficTeamAllSum_04_10 + trafficTeamAllSum_03_10 + trafficTeamAllSum_02_10 + trafficTeamAllSum_01_10}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllColSum_10}" pattern="#,##0.##"/></td>
			                
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="trafficTeamAllSum_12_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_11_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_10_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_09_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_08_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_07_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_06_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_05_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_04_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_03_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_02_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_01_10" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo1.rowCnt == 1}">
		    				<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="trafficTeamAllSum_12_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_11_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_10_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_09_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_08_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_07_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_06_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_05_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_04_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_03_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_02_10" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_01_10" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 팀별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 팀별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 심사 소계 시작 -->
		    	<c:if test="${ptnrStatTeamAllTrafficList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="4" style="height:25px;">1종 심사 소계</th>
	                <!-- traffic12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_12_10}" pattern="#,##0.##"/></th>
	                <!-- traffic11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_11_10}" pattern="#,##0.##"/></th>
	                <!-- traffic10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_10_10}" pattern="#,##0.##"/></th>
	                <!-- traffic09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_09_10}" pattern="#,##0.##"/></th>
	                <!-- traffic08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_08_10}" pattern="#,##0.##"/></th>
	                <!-- traffic07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_07_10}" pattern="#,##0.##"/></th>
	                <!-- traffic06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_06_10}" pattern="#,##0.##"/></th>
	                <!-- traffic05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_05_10}" pattern="#,##0.##"/></th>
	                <!-- traffic04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_04_10}" pattern="#,##0.##"/></th>
	                <!-- traffic03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_03_10}" pattern="#,##0.##"/></th>
	                <!-- traffic02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_02_10}" pattern="#,##0.##"/></th>
	                <!-- traffic01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_01_10}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="trafficColTotalSum_10" value="${trafficTeamAllTotalSum_12_10 + trafficTeamAllTotalSum_11_10 + trafficTeamAllTotalSum_10_10 + trafficTeamAllTotalSum_09_10 + trafficTeamAllTotalSum_08_10 + trafficTeamAllTotalSum_07_10 + trafficTeamAllTotalSum_06_10 + trafficTeamAllTotalSum_05_10 + trafficTeamAllTotalSum_04_10 + trafficTeamAllTotalSum_03_10 + trafficTeamAllTotalSum_02_10 + trafficTeamAllTotalSum_01_10}"></c:set>
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
   				<c:set var="preTeamAllName" value=""></c:set>
   				
   				<!-- 팀별 계 -->
	            <c:set var="trafficTeamAllSum_12_15" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_11_15" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_10_15" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_09_15" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_08_15" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_07_15" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_06_15" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_05_15" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_04_15" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_03_15" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_02_15" value="0"></c:set>
	            <c:set var="trafficTeamAllSum_01_15" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="trafficTeamAllTotalSum_12_15" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_11_15" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_10_15" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_09_15" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_08_15" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_07_15" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_06_15" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_05_15" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_04_15" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_03_15" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_02_15" value="0"></c:set>
	            <c:set var="trafficTeamAllTotalSum_01_15" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="trafficColTeamAllTotalSum_15" value="0"></c:set>
   				    			
    			<c:forEach var="vo2" items="${ptnrStatTeamAllTrafficList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatTraffic');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowTeamAll_15}">
		                    	1종 기타
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo2.rowCnt == 1}">
		                		<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>		                		
		                		<td onclick="goPtnrStatMember(${vo2.ptnrId},${vo2.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.teamName}</td>
		                		<td style="width:150px;">${vo2.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="trafficTeamAllSum_12_15" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_11_15" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_10_15" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_09_15" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_08_15" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_07_15" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_06_15" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_05_15" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_04_15" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_03_15" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_02_15" value="0"></c:set>
					            <c:set var="trafficTeamAllSum_01_15" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${teamCnt == 1 and vo2.teamName != preTeamAllName}">
		                				<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>
		                				<td onclick="goPtnrStatMember(${vo2.ptnrId},${vo2.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${vo2.rowCnt+1}">${vo2.teamName}</td>
		                				<td style="width:150px;">${vo2.ptnrIdSubNm}</td>		                				
		                				<c:set var="preTeamAllName" value="${vo2.teamName}"></c:set>
		                			</c:when>
		                			<c:otherwise>
		                				<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>		                				
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
	    				<c:set var="trafficTeamAllSum_12_15" value="${trafficTeamAllSum_12_15+traffic12_15}"></c:set>
			            <c:set var="trafficTeamAllSum_11_15" value="${trafficTeamAllSum_11_15+traffic11_15}"></c:set>
			            <c:set var="trafficTeamAllSum_10_15" value="${trafficTeamAllSum_10_15+traffic10_15}"></c:set>
			            <c:set var="trafficTeamAllSum_09_15" value="${trafficTeamAllSum_09_15+traffic09_15}"></c:set>
			            <c:set var="trafficTeamAllSum_08_15" value="${trafficTeamAllSum_08_15+traffic08_15}"></c:set>
			            <c:set var="trafficTeamAllSum_07_15" value="${trafficTeamAllSum_07_15+traffic07_15}"></c:set>
			            <c:set var="trafficTeamAllSum_06_15" value="${trafficTeamAllSum_06_15+traffic06_15}"></c:set>
			            <c:set var="trafficTeamAllSum_05_15" value="${trafficTeamAllSum_05_15+traffic05_15}"></c:set>
			            <c:set var="trafficTeamAllSum_04_15" value="${trafficTeamAllSum_04_15+traffic04_15}"></c:set>
			            <c:set var="trafficTeamAllSum_03_15" value="${trafficTeamAllSum_03_15+traffic03_15}"></c:set>
			            <c:set var="trafficTeamAllSum_02_15" value="${trafficTeamAllSum_02_15+traffic02_15}"></c:set>
			            <c:set var="trafficTeamAllSum_01_15" value="${trafficTeamAllSum_01_15+traffic01_15}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="trafficTeamAllTotalSum_12_15" value="${trafficTeamAllTotalSum_12_15 + traffic12_15}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_11_15" value="${trafficTeamAllTotalSum_11_15 + traffic11_15}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_10_15" value="${trafficTeamAllTotalSum_10_15 + traffic10_15}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_09_15" value="${trafficTeamAllTotalSum_09_15 + traffic09_15}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_08_15" value="${trafficTeamAllTotalSum_08_15 + traffic08_15}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_07_15" value="${trafficTeamAllTotalSum_07_15 + traffic07_15}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_06_15" value="${trafficTeamAllTotalSum_06_15 + traffic06_15}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_05_15" value="${trafficTeamAllTotalSum_05_15 + traffic05_15}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_04_15" value="${trafficTeamAllTotalSum_04_15 + traffic04_15}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_03_15" value="${trafficTeamAllTotalSum_03_15 + traffic03_15}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_02_15" value="${trafficTeamAllTotalSum_02_15 + traffic02_15}"></c:set>
	                    <c:set var="trafficTeamAllTotalSum_01_15" value="${trafficTeamAllTotalSum_01_15 + traffic01_15}"></c:set>
		    		</tr>
		    		<!-- 팀별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo2.rowCnt and vo2.rowCnt > 1}">
		    				<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- traffic12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_12_15}" pattern="#,##0.##"/></td>
			                <!-- traffic11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_11_15}" pattern="#,##0.##"/></td>
			                <!-- traffic10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_10_15}" pattern="#,##0.##"/></td>
			                <!-- traffic09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_09_15}" pattern="#,##0.##"/></td>
			                <!-- traffic08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_08_15}" pattern="#,##0.##"/></td>
			                <!-- traffic07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_07_15}" pattern="#,##0.##"/></td>
			                <!-- traffic06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_06_15}" pattern="#,##0.##"/></td>
			                <!-- traffic05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_05_15}" pattern="#,##0.##"/></td>
			                <!-- traffic04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_04_15}" pattern="#,##0.##"/></td>
			                <!-- traffic03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_03_15}" pattern="#,##0.##"/></td>
			                <!-- traffic02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_02_15}" pattern="#,##0.##"/></td>
			                <!-- traffic01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllSum_01_15}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="trafficTeamAllColSum_15" value="${trafficTeamAllSum_12_15 + trafficTeamAllSum_11_15 + trafficTeamAllSum_10_15 + trafficTeamAllSum_09_15 + trafficTeamAllSum_08_15 + trafficTeamAllSum_07_15 + trafficTeamAllSum_06_15 + trafficTeamAllSum_05_15 + trafficTeamAllSum_04_15 + trafficTeamAllSum_03_15 + trafficTeamAllSum_02_15 + trafficTeamAllSum_01_15}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficTeamAllColSum_15}" pattern="#,##0.##"/></td>
			                
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="trafficTeamAllSum_12_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_11_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_10_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_09_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_08_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_07_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_06_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_05_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_04_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_03_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_02_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_01_15" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo2.rowCnt == 1}">
		    				<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="trafficTeamAllSum_12_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_11_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_10_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_09_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_08_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_07_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_06_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_05_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_04_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_03_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_02_15" value="0"></c:set>
				            <c:set var="trafficTeamAllSum_01_15" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 팀별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 팀별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 기타 소계 시작 -->
		    	<c:if test="${ptnrStatTeamAllTrafficList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="4" style="height:25px;">1종 기타 소계</th>
	                <!-- traffic12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_12_15}" pattern="#,##0.##"/></th>
	                <!-- traffic11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_11_15}" pattern="#,##0.##"/></th>
	                <!-- traffic10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_10_15}" pattern="#,##0.##"/></th>
	                <!-- traffic09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_09_15}" pattern="#,##0.##"/></th>
	                <!-- traffic08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_08_15}" pattern="#,##0.##"/></th>
	                <!-- traffic07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_07_15}" pattern="#,##0.##"/></th>
	                <!-- traffic06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_06_15}" pattern="#,##0.##"/></th>
	                <!-- traffic05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_05_15}" pattern="#,##0.##"/></th>
	                <!-- traffic04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_04_15}" pattern="#,##0.##"/></th>
	                <!-- traffic03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_03_15}" pattern="#,##0.##"/></th>
	                <!-- traffic02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_02_15}" pattern="#,##0.##"/></th>
	                <!-- traffic01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficTeamAllTotalSum_01_15}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="trafficColTotalSum_15" value="${trafficTeamAllTotalSum_12_15 + trafficTeamAllTotalSum_11_15 + trafficTeamAllTotalSum_10_15 + trafficTeamAllTotalSum_09_15 + trafficTeamAllTotalSum_08_15 + trafficTeamAllTotalSum_07_15 + trafficTeamAllTotalSum_06_15 + trafficTeamAllTotalSum_05_15 + trafficTeamAllTotalSum_04_15 + trafficTeamAllTotalSum_03_15 + trafficTeamAllTotalSum_02_15 + trafficTeamAllTotalSum_01_15}"></c:set>
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
    <c:set var="trafficTeamAllTotalSum_12_all" value="${trafficTeamAllTotalSum_12_5 + trafficTeamAllTotalSum_12_10 + trafficTeamAllTotalSum_12_15}"></c:set>
    <c:set var="trafficTeamAllTotalSum_11_all" value="${trafficTeamAllTotalSum_11_5 + trafficTeamAllTotalSum_11_10 + trafficTeamAllTotalSum_11_15}"></c:set>
    <c:set var="trafficTeamAllTotalSum_10_all" value="${trafficTeamAllTotalSum_10_5 + trafficTeamAllTotalSum_10_10 + trafficTeamAllTotalSum_10_15}"></c:set>
    <c:set var="trafficTeamAllTotalSum_09_all" value="${trafficTeamAllTotalSum_09_5 + trafficTeamAllTotalSum_09_10 + trafficTeamAllTotalSum_09_15}"></c:set>
    <c:set var="trafficTeamAllTotalSum_08_all" value="${trafficTeamAllTotalSum_08_5 + trafficTeamAllTotalSum_08_10 + trafficTeamAllTotalSum_08_15}"></c:set>
    <c:set var="trafficTeamAllTotalSum_07_all" value="${trafficTeamAllTotalSum_07_5 + trafficTeamAllTotalSum_07_10 + trafficTeamAllTotalSum_07_15}"></c:set>
    <c:set var="trafficTeamAllTotalSum_06_all" value="${trafficTeamAllTotalSum_06_5 + trafficTeamAllTotalSum_06_10 + trafficTeamAllTotalSum_06_15}"></c:set>
    <c:set var="trafficTeamAllTotalSum_05_all" value="${trafficTeamAllTotalSum_05_5 + trafficTeamAllTotalSum_05_10 + trafficTeamAllTotalSum_05_15}"></c:set>
    <c:set var="trafficTeamAllTotalSum_04_all" value="${trafficTeamAllTotalSum_04_5 + trafficTeamAllTotalSum_04_10 + trafficTeamAllTotalSum_04_15}"></c:set>
    <c:set var="trafficTeamAllTotalSum_03_all" value="${trafficTeamAllTotalSum_03_5 + trafficTeamAllTotalSum_03_10 + trafficTeamAllTotalSum_03_15}"></c:set>
    <c:set var="trafficTeamAllTotalSum_02_all" value="${trafficTeamAllTotalSum_02_5 + trafficTeamAllTotalSum_02_10 + trafficTeamAllTotalSum_02_15}"></c:set>
    <c:set var="trafficTeamAllTotalSum_01_all" value="${trafficTeamAllTotalSum_01_5 + trafficTeamAllTotalSum_01_10 + trafficTeamAllTotalSum_01_15}"></c:set>        
    <c:set var="trafficTeamAllTotalSum_col_all" value="${trafficTeamAllTotalSum_12_all + trafficTeamAllTotalSum_11_all + trafficTeamAllTotalSum_10_all + trafficTeamAllTotalSum_09_all + trafficTeamAllTotalSum_08_all + trafficTeamAllTotalSum_07_all + trafficTeamAllTotalSum_06_all + trafficTeamAllTotalSum_05_all + trafficTeamAllTotalSum_04_all + trafficTeamAllTotalSum_03_all + trafficTeamAllTotalSum_02_all + trafficTeamAllTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 530px;height:25px;">전체합계</th>    			
    			<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamAllTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamAllTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamAllTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamAllTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamAllTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamAllTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamAllTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamAllTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamAllTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamAllTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamAllTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamAllTotalSum_01_all}" pattern="#,##0.##"/></th>
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficTeamAllTotalSum_col_all}" pattern="#,##0.##"/></th>    			
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>