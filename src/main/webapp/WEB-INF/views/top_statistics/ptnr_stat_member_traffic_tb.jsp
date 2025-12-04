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
                <th style="width: 150px;">직원명</th>
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
   				<!-- 직원별 계를 만들기 위한 변수 -->
   				<c:set var="memberCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 직원명 -->
   				<c:set var="preUserName" value=""></c:set>
   				
   				<!-- 직원별 계 -->
	            <c:set var="trafficMemberSum_12_5" value="0"></c:set>
	            <c:set var="trafficMemberSum_11_5" value="0"></c:set>
	            <c:set var="trafficMemberSum_10_5" value="0"></c:set>
	            <c:set var="trafficMemberSum_09_5" value="0"></c:set>
	            <c:set var="trafficMemberSum_08_5" value="0"></c:set>
	            <c:set var="trafficMemberSum_07_5" value="0"></c:set>
	            <c:set var="trafficMemberSum_06_5" value="0"></c:set>
	            <c:set var="trafficMemberSum_05_5" value="0"></c:set>
	            <c:set var="trafficMemberSum_04_5" value="0"></c:set>
	            <c:set var="trafficMemberSum_03_5" value="0"></c:set>
	            <c:set var="trafficMemberSum_02_5" value="0"></c:set>
	            <c:set var="trafficMemberSum_01_5" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="trafficMemberTotalSum_12_5" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_11_5" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_10_5" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_09_5" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_08_5" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_07_5" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_06_5" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_05_5" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_04_5" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_03_5" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_02_5" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_01_5" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="trafficColMemberTotalSum_5" value="0"></c:set>
   				    			
    			<c:forEach var="vo" items="${ptnrStatTrafficList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		    				<c:choose>
		    					<c:when test='${srchArg.tabMenu eq "team"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterTraffic');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
				                    	1종 조사
				                    </td>
		    					</c:when>
		    					<c:when test='${srchArg.tabMenu eq "member"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterTraffic');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
				                    	1종 조사
				                    </td>
		    					</c:when>
		    					<c:otherwise>
		    						<td onclick="goPtnrStatMenu('ptnrStatTeamTraffic');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
				                    	1종 조사
				                    </td>
		    					</c:otherwise>
		    				</c:choose>		    				
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo.rowCnt == 1}">
		                		<td style="width:150px;">${vo.userName}</td>
		                		<td style="width:150px;">${vo.ptnrIdSubNm}</td>		                		
		                		<!-- 직원별 계 초기화 -->
					            <c:set var="trafficMemberSum_12_5" value="0"></c:set>
					            <c:set var="trafficMemberSum_11_5" value="0"></c:set>
					            <c:set var="trafficMemberSum_10_5" value="0"></c:set>
					            <c:set var="trafficMemberSum_09_5" value="0"></c:set>
					            <c:set var="trafficMemberSum_08_5" value="0"></c:set>
					            <c:set var="trafficMemberSum_07_5" value="0"></c:set>
					            <c:set var="trafficMemberSum_06_5" value="0"></c:set>
					            <c:set var="trafficMemberSum_05_5" value="0"></c:set>
					            <c:set var="trafficMemberSum_04_5" value="0"></c:set>
					            <c:set var="trafficMemberSum_03_5" value="0"></c:set>
					            <c:set var="trafficMemberSum_02_5" value="0"></c:set>
					            <c:set var="trafficMemberSum_01_5" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${memberCnt == 1 and vo.userName != preUserName}">
		                				<td style="width:150px;" rowspan="${vo.rowCnt+1}">${vo.userName}</td>
		                				<td style="width:150px;">${vo.ptnrIdSubNm}</td>		                				
		                				<c:set var="preUserName" value="${vo.userName}"></c:set>
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
		                
		                <!-- 직원별 계 합산 -->
	    				<c:set var="trafficMemberSum_12_5" value="${trafficMemberSum_12_5+traffic12_5}"></c:set>
			            <c:set var="trafficMemberSum_11_5" value="${trafficMemberSum_11_5+traffic11_5}"></c:set>
			            <c:set var="trafficMemberSum_10_5" value="${trafficMemberSum_10_5+traffic10_5}"></c:set>
			            <c:set var="trafficMemberSum_09_5" value="${trafficMemberSum_09_5+traffic09_5}"></c:set>
			            <c:set var="trafficMemberSum_08_5" value="${trafficMemberSum_08_5+traffic08_5}"></c:set>
			            <c:set var="trafficMemberSum_07_5" value="${trafficMemberSum_07_5+traffic07_5}"></c:set>
			            <c:set var="trafficMemberSum_06_5" value="${trafficMemberSum_06_5+traffic06_5}"></c:set>
			            <c:set var="trafficMemberSum_05_5" value="${trafficMemberSum_05_5+traffic05_5}"></c:set>
			            <c:set var="trafficMemberSum_04_5" value="${trafficMemberSum_04_5+traffic04_5}"></c:set>
			            <c:set var="trafficMemberSum_03_5" value="${trafficMemberSum_03_5+traffic03_5}"></c:set>
			            <c:set var="trafficMemberSum_02_5" value="${trafficMemberSum_02_5+traffic02_5}"></c:set>
			            <c:set var="trafficMemberSum_01_5" value="${trafficMemberSum_01_5+traffic01_5}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="trafficMemberTotalSum_12_5" value="${trafficMemberTotalSum_12_5 + traffic12_5}"></c:set>
	                    <c:set var="trafficMemberTotalSum_11_5" value="${trafficMemberTotalSum_11_5 + traffic11_5}"></c:set>
	                    <c:set var="trafficMemberTotalSum_10_5" value="${trafficMemberTotalSum_10_5 + traffic10_5}"></c:set>
	                    <c:set var="trafficMemberTotalSum_09_5" value="${trafficMemberTotalSum_09_5 + traffic09_5}"></c:set>
	                    <c:set var="trafficMemberTotalSum_08_5" value="${trafficMemberTotalSum_08_5 + traffic08_5}"></c:set>
	                    <c:set var="trafficMemberTotalSum_07_5" value="${trafficMemberTotalSum_07_5 + traffic07_5}"></c:set>
	                    <c:set var="trafficMemberTotalSum_06_5" value="${trafficMemberTotalSum_06_5 + traffic06_5}"></c:set>
	                    <c:set var="trafficMemberTotalSum_05_5" value="${trafficMemberTotalSum_05_5 + traffic05_5}"></c:set>
	                    <c:set var="trafficMemberTotalSum_04_5" value="${trafficMemberTotalSum_04_5 + traffic04_5}"></c:set>
	                    <c:set var="trafficMemberTotalSum_03_5" value="${trafficMemberTotalSum_03_5 + traffic03_5}"></c:set>
	                    <c:set var="trafficMemberTotalSum_02_5" value="${trafficMemberTotalSum_02_5 + traffic02_5}"></c:set>
	                    <c:set var="trafficMemberTotalSum_01_5" value="${trafficMemberTotalSum_01_5 + traffic01_5}"></c:set>
		    		</tr>
		    		<!-- 직원별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${memberCnt == vo.rowCnt and vo.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- traffic12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_12_5}" pattern="#,##0.##"/></td>
			                <!-- traffic11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_11_5}" pattern="#,##0.##"/></td>
			                <!-- traffic10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_10_5}" pattern="#,##0.##"/></td>
			                <!-- traffic09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_09_5}" pattern="#,##0.##"/></td>
			                <!-- traffic08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_08_5}" pattern="#,##0.##"/></td>
			                <!-- traffic07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_07_5}" pattern="#,##0.##"/></td>
			                <!-- traffic06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_06_5}" pattern="#,##0.##"/></td>
			                <!-- traffic05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_05_5}" pattern="#,##0.##"/></td>
			                <!-- traffic04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_04_5}" pattern="#,##0.##"/></td>
			                <!-- traffic03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_03_5}" pattern="#,##0.##"/></td>
			                <!-- traffic02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_02_5}" pattern="#,##0.##"/></td>
			                <!-- traffic01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_01_5}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="trafficMemberColSum_5" value="${trafficMemberSum_12_5 + trafficMemberSum_11_5 + trafficMemberSum_10_5 + trafficMemberSum_09_5 + trafficMemberSum_08_5 + trafficMemberSum_07_5 + trafficMemberSum_06_5 + trafficMemberSum_05_5 + trafficMemberSum_04_5 + trafficMemberSum_03_5 + trafficMemberSum_02_5 + trafficMemberSum_01_5}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberColSum_5}" pattern="#,##0.##"/></td>
			                
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="trafficMemberSum_12_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_11_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_10_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_09_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_08_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_07_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_06_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_05_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_04_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_03_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_02_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_01_5" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo.rowCnt == 1}">
		    				<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="trafficMemberSum_12_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_11_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_10_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_09_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_08_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_07_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_06_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_05_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_04_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_03_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_02_5" value="0"></c:set>
				            <c:set var="trafficMemberSum_01_5" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 직원별 계 카운트 증가 -->
		    				<c:set var="memberCnt" value="${memberCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 직원별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 조사 소계 시작 -->
		    	<c:if test="${ptnrStatTrafficList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 조사 소계</th>
	                <!-- traffic12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_12_5}" pattern="#,##0.##"/></th>
	                <!-- traffic11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_11_5}" pattern="#,##0.##"/></th>
	                <!-- traffic10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_10_5}" pattern="#,##0.##"/></th>
	                <!-- traffic09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_09_5}" pattern="#,##0.##"/></th>
	                <!-- traffic08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_08_5}" pattern="#,##0.##"/></th>
	                <!-- traffic07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_07_5}" pattern="#,##0.##"/></th>
	                <!-- traffic06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_06_5}" pattern="#,##0.##"/></th>
	                <!-- traffic05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_05_5}" pattern="#,##0.##"/></th>
	                <!-- traffic04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_04_5}" pattern="#,##0.##"/></th>
	                <!-- traffic03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_03_5}" pattern="#,##0.##"/></th>
	                <!-- traffic02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_02_5}" pattern="#,##0.##"/></th>
	                <!-- traffic01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_01_5}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="trafficColTotalSum_5" value="${trafficMemberTotalSum_12_5 + trafficMemberTotalSum_11_5 + trafficMemberTotalSum_10_5 + trafficMemberTotalSum_09_5 + trafficMemberTotalSum_08_5 + trafficMemberTotalSum_07_5 + trafficMemberTotalSum_06_5 + trafficMemberTotalSum_05_5 + trafficMemberTotalSum_04_5 + trafficMemberTotalSum_03_5 + trafficMemberTotalSum_02_5 + trafficMemberTotalSum_01_5}"></c:set>
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
   				<!-- 직원별 계를 만들기 위한 변수 -->
   				<c:set var="memberCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 직원명 -->
   				<c:set var="preUserName" value=""></c:set>
   				
   				<!-- 직원별 계 -->
	            <c:set var="trafficMemberSum_12_10" value="0"></c:set>
	            <c:set var="trafficMemberSum_11_10" value="0"></c:set>
	            <c:set var="trafficMemberSum_10_10" value="0"></c:set>
	            <c:set var="trafficMemberSum_09_10" value="0"></c:set>
	            <c:set var="trafficMemberSum_08_10" value="0"></c:set>
	            <c:set var="trafficMemberSum_07_10" value="0"></c:set>
	            <c:set var="trafficMemberSum_06_10" value="0"></c:set>
	            <c:set var="trafficMemberSum_05_10" value="0"></c:set>
	            <c:set var="trafficMemberSum_04_10" value="0"></c:set>
	            <c:set var="trafficMemberSum_03_10" value="0"></c:set>
	            <c:set var="trafficMemberSum_02_10" value="0"></c:set>
	            <c:set var="trafficMemberSum_01_10" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="trafficMemberTotalSum_12_10" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_11_10" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_10_10" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_09_10" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_08_10" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_07_10" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_06_10" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_05_10" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_04_10" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_03_10" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_02_10" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_01_10" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="trafficColMemberTotalSum_10" value="0"></c:set>
   				    			
    			<c:forEach var="vo1" items="${ptnrStatTrafficList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <c:choose>
		    					<c:when test='${srchArg.tabMenu eq "team"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterTraffic');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
				                    	1종 심사
				                    </td>
		    					</c:when>
		    					<c:when test='${srchArg.tabMenu eq "member"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterTraffic');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
				                    	1종 심사
				                    </td>
		    					</c:when>
		    					<c:otherwise>
		    						<td onclick="goPtnrStatMenu('ptnrStatTeamTraffic');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
				                    	1종 심사
				                    </td>
		    					</c:otherwise>
		    				</c:choose>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo1.rowCnt == 1}">
		                		<td style="width:150px;">${vo1.userName}</td>
		                		<td style="width:150px;">${vo1.ptnrIdSubNm}</td>		                		
		                		<!-- 직원별 계 초기화 -->
					            <c:set var="trafficMemberSum_12_10" value="0"></c:set>
					            <c:set var="trafficMemberSum_11_10" value="0"></c:set>
					            <c:set var="trafficMemberSum_10_10" value="0"></c:set>
					            <c:set var="trafficMemberSum_09_10" value="0"></c:set>
					            <c:set var="trafficMemberSum_08_10" value="0"></c:set>
					            <c:set var="trafficMemberSum_07_10" value="0"></c:set>
					            <c:set var="trafficMemberSum_06_10" value="0"></c:set>
					            <c:set var="trafficMemberSum_05_10" value="0"></c:set>
					            <c:set var="trafficMemberSum_04_10" value="0"></c:set>
					            <c:set var="trafficMemberSum_03_10" value="0"></c:set>
					            <c:set var="trafficMemberSum_02_10" value="0"></c:set>
					            <c:set var="trafficMemberSum_01_10" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${memberCnt == 1 and vo1.userName != preUserName}">
		                				<td style="width:150px;" rowspan="${vo1.rowCnt+1}">${vo1.userName}</td>
		                				<td style="width:150px;">${vo1.ptnrIdSubNm}</td>		                				
		                				<c:set var="preUserName" value="${vo1.userName}"></c:set>
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
		                
		                <!-- 직원별 계 합산 -->
	    				<c:set var="trafficMemberSum_12_10" value="${trafficMemberSum_12_10+traffic12_10}"></c:set>
			            <c:set var="trafficMemberSum_11_10" value="${trafficMemberSum_11_10+traffic11_10}"></c:set>
			            <c:set var="trafficMemberSum_10_10" value="${trafficMemberSum_10_10+traffic10_10}"></c:set>
			            <c:set var="trafficMemberSum_09_10" value="${trafficMemberSum_09_10+traffic09_10}"></c:set>
			            <c:set var="trafficMemberSum_08_10" value="${trafficMemberSum_08_10+traffic08_10}"></c:set>
			            <c:set var="trafficMemberSum_07_10" value="${trafficMemberSum_07_10+traffic07_10}"></c:set>
			            <c:set var="trafficMemberSum_06_10" value="${trafficMemberSum_06_10+traffic06_10}"></c:set>
			            <c:set var="trafficMemberSum_05_10" value="${trafficMemberSum_05_10+traffic05_10}"></c:set>
			            <c:set var="trafficMemberSum_04_10" value="${trafficMemberSum_04_10+traffic04_10}"></c:set>
			            <c:set var="trafficMemberSum_03_10" value="${trafficMemberSum_03_10+traffic03_10}"></c:set>
			            <c:set var="trafficMemberSum_02_10" value="${trafficMemberSum_02_10+traffic02_10}"></c:set>
			            <c:set var="trafficMemberSum_01_10" value="${trafficMemberSum_01_10+traffic01_10}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="trafficMemberTotalSum_12_10" value="${trafficMemberTotalSum_12_10 + traffic12_10}"></c:set>
	                    <c:set var="trafficMemberTotalSum_11_10" value="${trafficMemberTotalSum_11_10 + traffic11_10}"></c:set>
	                    <c:set var="trafficMemberTotalSum_10_10" value="${trafficMemberTotalSum_10_10 + traffic10_10}"></c:set>
	                    <c:set var="trafficMemberTotalSum_09_10" value="${trafficMemberTotalSum_09_10 + traffic09_10}"></c:set>
	                    <c:set var="trafficMemberTotalSum_08_10" value="${trafficMemberTotalSum_08_10 + traffic08_10}"></c:set>
	                    <c:set var="trafficMemberTotalSum_07_10" value="${trafficMemberTotalSum_07_10 + traffic07_10}"></c:set>
	                    <c:set var="trafficMemberTotalSum_06_10" value="${trafficMemberTotalSum_06_10 + traffic06_10}"></c:set>
	                    <c:set var="trafficMemberTotalSum_05_10" value="${trafficMemberTotalSum_05_10 + traffic05_10}"></c:set>
	                    <c:set var="trafficMemberTotalSum_04_10" value="${trafficMemberTotalSum_04_10 + traffic04_10}"></c:set>
	                    <c:set var="trafficMemberTotalSum_03_10" value="${trafficMemberTotalSum_03_10 + traffic03_10}"></c:set>
	                    <c:set var="trafficMemberTotalSum_02_10" value="${trafficMemberTotalSum_02_10 + traffic02_10}"></c:set>
	                    <c:set var="trafficMemberTotalSum_01_10" value="${trafficMemberTotalSum_01_10 + traffic01_10}"></c:set>
		    		</tr>
		    		<!-- 직원별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${memberCnt == vo1.rowCnt and vo1.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- traffic12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_12_10}" pattern="#,##0.##"/></td>
			                <!-- traffic11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_11_10}" pattern="#,##0.##"/></td>
			                <!-- traffic10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_10_10}" pattern="#,##0.##"/></td>
			                <!-- traffic09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_09_10}" pattern="#,##0.##"/></td>
			                <!-- traffic08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_08_10}" pattern="#,##0.##"/></td>
			                <!-- traffic07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_07_10}" pattern="#,##0.##"/></td>
			                <!-- traffic06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_06_10}" pattern="#,##0.##"/></td>
			                <!-- traffic05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_05_10}" pattern="#,##0.##"/></td>
			                <!-- traffic04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_04_10}" pattern="#,##0.##"/></td>
			                <!-- traffic03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_03_10}" pattern="#,##0.##"/></td>
			                <!-- traffic02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_02_10}" pattern="#,##0.##"/></td>
			                <!-- traffic01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_01_10}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="trafficMemberColSum_10" value="${trafficMemberSum_12_10 + trafficMemberSum_11_10 + trafficMemberSum_10_10 + trafficMemberSum_09_10 + trafficMemberSum_08_10 + trafficMemberSum_07_10 + trafficMemberSum_06_10 + trafficMemberSum_05_10 + trafficMemberSum_04_10 + trafficMemberSum_03_10 + trafficMemberSum_02_10 + trafficMemberSum_01_10}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberColSum_10}" pattern="#,##0.##"/></td>
			                
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="trafficMemberSum_12_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_11_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_10_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_09_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_08_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_07_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_06_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_05_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_04_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_03_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_02_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_01_10" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo1.rowCnt == 1}">
		    				<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="trafficMemberSum_12_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_11_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_10_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_09_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_08_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_07_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_06_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_05_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_04_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_03_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_02_10" value="0"></c:set>
				            <c:set var="trafficMemberSum_01_10" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 직원별 계 카운트 증가 -->
		    				<c:set var="memberCnt" value="${memberCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 직원별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 심사 소계 시작 -->
		    	<c:if test="${ptnrStatTrafficList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 심사 소계</th>
	                <!-- traffic12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_12_10}" pattern="#,##0.##"/></th>
	                <!-- traffic11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_11_10}" pattern="#,##0.##"/></th>
	                <!-- traffic10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_10_10}" pattern="#,##0.##"/></th>
	                <!-- traffic09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_09_10}" pattern="#,##0.##"/></th>
	                <!-- traffic08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_08_10}" pattern="#,##0.##"/></th>
	                <!-- traffic07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_07_10}" pattern="#,##0.##"/></th>
	                <!-- traffic06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_06_10}" pattern="#,##0.##"/></th>
	                <!-- traffic05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_05_10}" pattern="#,##0.##"/></th>
	                <!-- traffic04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_04_10}" pattern="#,##0.##"/></th>
	                <!-- traffic03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_03_10}" pattern="#,##0.##"/></th>
	                <!-- traffic02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_02_10}" pattern="#,##0.##"/></th>
	                <!-- traffic01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_01_10}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="trafficColTotalSum_10" value="${trafficMemberTotalSum_12_10 + trafficMemberTotalSum_11_10 + trafficMemberTotalSum_10_10 + trafficMemberTotalSum_09_10 + trafficMemberTotalSum_08_10 + trafficMemberTotalSum_07_10 + trafficMemberTotalSum_06_10 + trafficMemberTotalSum_05_10 + trafficMemberTotalSum_04_10 + trafficMemberTotalSum_03_10 + trafficMemberTotalSum_02_10 + trafficMemberTotalSum_01_10}"></c:set>
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
   				<!-- 직원별 계를 만들기 위한 변수 -->
   				<c:set var="memberCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 직원명 -->
   				<c:set var="preUserName" value=""></c:set>
   				
   				<!-- 직원별 계 -->
	            <c:set var="trafficMemberSum_12_15" value="0"></c:set>
	            <c:set var="trafficMemberSum_11_15" value="0"></c:set>
	            <c:set var="trafficMemberSum_10_15" value="0"></c:set>
	            <c:set var="trafficMemberSum_09_15" value="0"></c:set>
	            <c:set var="trafficMemberSum_08_15" value="0"></c:set>
	            <c:set var="trafficMemberSum_07_15" value="0"></c:set>
	            <c:set var="trafficMemberSum_06_15" value="0"></c:set>
	            <c:set var="trafficMemberSum_05_15" value="0"></c:set>
	            <c:set var="trafficMemberSum_04_15" value="0"></c:set>
	            <c:set var="trafficMemberSum_03_15" value="0"></c:set>
	            <c:set var="trafficMemberSum_02_15" value="0"></c:set>
	            <c:set var="trafficMemberSum_01_15" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="trafficMemberTotalSum_12_15" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_11_15" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_10_15" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_09_15" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_08_15" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_07_15" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_06_15" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_05_15" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_04_15" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_03_15" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_02_15" value="0"></c:set>
	            <c:set var="trafficMemberTotalSum_01_15" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="trafficColMemberTotalSum_15" value="0"></c:set>
   				    			
    			<c:forEach var="vo2" items="${ptnrStatTrafficList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <c:choose>
		    					<c:when test='${srchArg.tabMenu eq "team"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterTraffic');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
				                    	1종 기타
				                    </td>
		    					</c:when>
		    					<c:when test='${srchArg.tabMenu eq "member"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterTraffic');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
				                    	1종 기타
				                    </td>
		    					</c:when>
		    					<c:otherwise>
		    						<td onclick="goPtnrStatMenu('ptnrStatTeamTraffic');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
				                    	1종 기타
				                    </td>
		    					</c:otherwise>
		    				</c:choose>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo2.rowCnt == 1}">
		                		<td style="width:150px;">${vo2.userName}</td>
		                		<td style="width:150px;">${vo2.ptnrIdSubNm}</td>		                		
		                		<!-- 직원별 계 초기화 -->
					            <c:set var="trafficMemberSum_12_15" value="0"></c:set>
					            <c:set var="trafficMemberSum_11_15" value="0"></c:set>
					            <c:set var="trafficMemberSum_10_15" value="0"></c:set>
					            <c:set var="trafficMemberSum_09_15" value="0"></c:set>
					            <c:set var="trafficMemberSum_08_15" value="0"></c:set>
					            <c:set var="trafficMemberSum_07_15" value="0"></c:set>
					            <c:set var="trafficMemberSum_06_15" value="0"></c:set>
					            <c:set var="trafficMemberSum_05_15" value="0"></c:set>
					            <c:set var="trafficMemberSum_04_15" value="0"></c:set>
					            <c:set var="trafficMemberSum_03_15" value="0"></c:set>
					            <c:set var="trafficMemberSum_02_15" value="0"></c:set>
					            <c:set var="trafficMemberSum_01_15" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${memberCnt == 1 and vo2.userName != preUserName}">
		                				<td style="width:150px;" rowspan="${vo2.rowCnt+1}">${vo2.userName}</td>
		                				<td style="width:150px;">${vo2.ptnrIdSubNm}</td>		                				
		                				<c:set var="preUserName" value="${vo2.userName}"></c:set>
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
		                
		                <!-- 직원별 계 합산 -->
	    				<c:set var="trafficMemberSum_12_15" value="${trafficMemberSum_12_15+traffic12_15}"></c:set>
			            <c:set var="trafficMemberSum_11_15" value="${trafficMemberSum_11_15+traffic11_15}"></c:set>
			            <c:set var="trafficMemberSum_10_15" value="${trafficMemberSum_10_15+traffic10_15}"></c:set>
			            <c:set var="trafficMemberSum_09_15" value="${trafficMemberSum_09_15+traffic09_15}"></c:set>
			            <c:set var="trafficMemberSum_08_15" value="${trafficMemberSum_08_15+traffic08_15}"></c:set>
			            <c:set var="trafficMemberSum_07_15" value="${trafficMemberSum_07_15+traffic07_15}"></c:set>
			            <c:set var="trafficMemberSum_06_15" value="${trafficMemberSum_06_15+traffic06_15}"></c:set>
			            <c:set var="trafficMemberSum_05_15" value="${trafficMemberSum_05_15+traffic05_15}"></c:set>
			            <c:set var="trafficMemberSum_04_15" value="${trafficMemberSum_04_15+traffic04_15}"></c:set>
			            <c:set var="trafficMemberSum_03_15" value="${trafficMemberSum_03_15+traffic03_15}"></c:set>
			            <c:set var="trafficMemberSum_02_15" value="${trafficMemberSum_02_15+traffic02_15}"></c:set>
			            <c:set var="trafficMemberSum_01_15" value="${trafficMemberSum_01_15+traffic01_15}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="trafficMemberTotalSum_12_15" value="${trafficMemberTotalSum_12_15 + traffic12_15}"></c:set>
	                    <c:set var="trafficMemberTotalSum_11_15" value="${trafficMemberTotalSum_11_15 + traffic11_15}"></c:set>
	                    <c:set var="trafficMemberTotalSum_10_15" value="${trafficMemberTotalSum_10_15 + traffic10_15}"></c:set>
	                    <c:set var="trafficMemberTotalSum_09_15" value="${trafficMemberTotalSum_09_15 + traffic09_15}"></c:set>
	                    <c:set var="trafficMemberTotalSum_08_15" value="${trafficMemberTotalSum_08_15 + traffic08_15}"></c:set>
	                    <c:set var="trafficMemberTotalSum_07_15" value="${trafficMemberTotalSum_07_15 + traffic07_15}"></c:set>
	                    <c:set var="trafficMemberTotalSum_06_15" value="${trafficMemberTotalSum_06_15 + traffic06_15}"></c:set>
	                    <c:set var="trafficMemberTotalSum_05_15" value="${trafficMemberTotalSum_05_15 + traffic05_15}"></c:set>
	                    <c:set var="trafficMemberTotalSum_04_15" value="${trafficMemberTotalSum_04_15 + traffic04_15}"></c:set>
	                    <c:set var="trafficMemberTotalSum_03_15" value="${trafficMemberTotalSum_03_15 + traffic03_15}"></c:set>
	                    <c:set var="trafficMemberTotalSum_02_15" value="${trafficMemberTotalSum_02_15 + traffic02_15}"></c:set>
	                    <c:set var="trafficMemberTotalSum_01_15" value="${trafficMemberTotalSum_01_15 + traffic01_15}"></c:set>
		    		</tr>
		    		<!-- 직원별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${memberCnt == vo2.rowCnt and vo2.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- traffic12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_12_15}" pattern="#,##0.##"/></td>
			                <!-- traffic11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_11_15}" pattern="#,##0.##"/></td>
			                <!-- traffic10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_10_15}" pattern="#,##0.##"/></td>
			                <!-- traffic09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_09_15}" pattern="#,##0.##"/></td>
			                <!-- traffic08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_08_15}" pattern="#,##0.##"/></td>
			                <!-- traffic07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_07_15}" pattern="#,##0.##"/></td>
			                <!-- traffic06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_06_15}" pattern="#,##0.##"/></td>
			                <!-- traffic05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_05_15}" pattern="#,##0.##"/></td>
			                <!-- traffic04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_04_15}" pattern="#,##0.##"/></td>
			                <!-- traffic03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_03_15}" pattern="#,##0.##"/></td>
			                <!-- traffic02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_02_15}" pattern="#,##0.##"/></td>
			                <!-- traffic01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberSum_01_15}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="trafficMemberColSum_15" value="${trafficMemberSum_12_15 + trafficMemberSum_11_15 + trafficMemberSum_10_15 + trafficMemberSum_09_15 + trafficMemberSum_08_15 + trafficMemberSum_07_15 + trafficMemberSum_06_15 + trafficMemberSum_05_15 + trafficMemberSum_04_15 + trafficMemberSum_03_15 + trafficMemberSum_02_15 + trafficMemberSum_01_15}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${trafficMemberColSum_15}" pattern="#,##0.##"/></td>
			                
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="trafficMemberSum_12_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_11_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_10_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_09_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_08_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_07_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_06_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_05_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_04_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_03_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_02_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_01_15" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo2.rowCnt == 1}">
		    				<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="trafficMemberSum_12_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_11_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_10_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_09_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_08_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_07_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_06_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_05_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_04_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_03_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_02_15" value="0"></c:set>
				            <c:set var="trafficMemberSum_01_15" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 직원별 계 카운트 증가 -->
		    				<c:set var="memberCnt" value="${memberCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 직원별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 기타 소계 시작 -->
		    	<c:if test="${ptnrStatTrafficList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 기타 소계</th>
	                <!-- traffic12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_12_15}" pattern="#,##0.##"/></th>
	                <!-- traffic11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_11_15}" pattern="#,##0.##"/></th>
	                <!-- traffic10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_10_15}" pattern="#,##0.##"/></th>
	                <!-- traffic09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_09_15}" pattern="#,##0.##"/></th>
	                <!-- traffic08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_08_15}" pattern="#,##0.##"/></th>
	                <!-- traffic07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_07_15}" pattern="#,##0.##"/></th>
	                <!-- traffic06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_06_15}" pattern="#,##0.##"/></th>
	                <!-- traffic05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_05_15}" pattern="#,##0.##"/></th>
	                <!-- traffic04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_04_15}" pattern="#,##0.##"/></th>
	                <!-- traffic03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_03_15}" pattern="#,##0.##"/></th>
	                <!-- traffic02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_02_15}" pattern="#,##0.##"/></th>
	                <!-- traffic01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${trafficMemberTotalSum_01_15}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="trafficColTotalSum_15" value="${trafficMemberTotalSum_12_15 + trafficMemberTotalSum_11_15 + trafficMemberTotalSum_10_15 + trafficMemberTotalSum_09_15 + trafficMemberTotalSum_08_15 + trafficMemberTotalSum_07_15 + trafficMemberTotalSum_06_15 + trafficMemberTotalSum_05_15 + trafficMemberTotalSum_04_15 + trafficMemberTotalSum_03_15 + trafficMemberTotalSum_02_15 + trafficMemberTotalSum_01_15}"></c:set>
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
    <c:set var="trafficMemberTotalSum_12_all" value="${trafficMemberTotalSum_12_5 + trafficMemberTotalSum_12_10 + trafficMemberTotalSum_12_15}"></c:set>
    <c:set var="trafficMemberTotalSum_11_all" value="${trafficMemberTotalSum_11_5 + trafficMemberTotalSum_11_10 + trafficMemberTotalSum_11_15}"></c:set>
    <c:set var="trafficMemberTotalSum_10_all" value="${trafficMemberTotalSum_10_5 + trafficMemberTotalSum_10_10 + trafficMemberTotalSum_10_15}"></c:set>
    <c:set var="trafficMemberTotalSum_09_all" value="${trafficMemberTotalSum_09_5 + trafficMemberTotalSum_09_10 + trafficMemberTotalSum_09_15}"></c:set>
    <c:set var="trafficMemberTotalSum_08_all" value="${trafficMemberTotalSum_08_5 + trafficMemberTotalSum_08_10 + trafficMemberTotalSum_08_15}"></c:set>
    <c:set var="trafficMemberTotalSum_07_all" value="${trafficMemberTotalSum_07_5 + trafficMemberTotalSum_07_10 + trafficMemberTotalSum_07_15}"></c:set>
    <c:set var="trafficMemberTotalSum_06_all" value="${trafficMemberTotalSum_06_5 + trafficMemberTotalSum_06_10 + trafficMemberTotalSum_06_15}"></c:set>
    <c:set var="trafficMemberTotalSum_05_all" value="${trafficMemberTotalSum_05_5 + trafficMemberTotalSum_05_10 + trafficMemberTotalSum_05_15}"></c:set>
    <c:set var="trafficMemberTotalSum_04_all" value="${trafficMemberTotalSum_04_5 + trafficMemberTotalSum_04_10 + trafficMemberTotalSum_04_15}"></c:set>
    <c:set var="trafficMemberTotalSum_03_all" value="${trafficMemberTotalSum_03_5 + trafficMemberTotalSum_03_10 + trafficMemberTotalSum_03_15}"></c:set>
    <c:set var="trafficMemberTotalSum_02_all" value="${trafficMemberTotalSum_02_5 + trafficMemberTotalSum_02_10 + trafficMemberTotalSum_02_15}"></c:set>
    <c:set var="trafficMemberTotalSum_01_all" value="${trafficMemberTotalSum_01_5 + trafficMemberTotalSum_01_10 + trafficMemberTotalSum_01_15}"></c:set>        
    <c:set var="trafficMemberTotalSum_col_all" value="${trafficMemberTotalSum_12_all + trafficMemberTotalSum_11_all + trafficMemberTotalSum_10_all + trafficMemberTotalSum_09_all + trafficMemberTotalSum_08_all + trafficMemberTotalSum_07_all + trafficMemberTotalSum_06_all + trafficMemberTotalSum_05_all + trafficMemberTotalSum_04_all + trafficMemberTotalSum_03_all + trafficMemberTotalSum_02_all + trafficMemberTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체합계</th>    			
    			<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficMemberTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficMemberTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficMemberTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficMemberTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficMemberTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficMemberTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficMemberTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficMemberTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficMemberTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficMemberTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficMemberTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficMemberTotalSum_01_all}" pattern="#,##0.##"/></th>
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${trafficMemberTotalSum_col_all}" pattern="#,##0.##"/></th>    			
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>