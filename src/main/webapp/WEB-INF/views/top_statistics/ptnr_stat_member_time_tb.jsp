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
	            <c:set var="timeMemberSum_12_5" value="0"></c:set>
	            <c:set var="timeMemberSum_11_5" value="0"></c:set>
	            <c:set var="timeMemberSum_10_5" value="0"></c:set>
	            <c:set var="timeMemberSum_09_5" value="0"></c:set>
	            <c:set var="timeMemberSum_08_5" value="0"></c:set>
	            <c:set var="timeMemberSum_07_5" value="0"></c:set>
	            <c:set var="timeMemberSum_06_5" value="0"></c:set>
	            <c:set var="timeMemberSum_05_5" value="0"></c:set>
	            <c:set var="timeMemberSum_04_5" value="0"></c:set>
	            <c:set var="timeMemberSum_03_5" value="0"></c:set>
	            <c:set var="timeMemberSum_02_5" value="0"></c:set>
	            <c:set var="timeMemberSum_01_5" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="timeMemberTotalSum_12_5" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_11_5" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_10_5" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_09_5" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_08_5" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_07_5" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_06_5" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_05_5" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_04_5" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_03_5" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_02_5" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_01_5" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="timeColMemberTotalSum_5" value="0"></c:set>
   				    			
    			<c:forEach var="vo" items="${ptnrStatTimeList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		    				<c:choose>
		    					<c:when test='${srchArg.tabMenu eq "team"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
				                    	1종 조사
				                    </td>
		    					</c:when>
		    					<c:when test='${srchArg.tabMenu eq "member"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
				                    	1종 조사
				                    </td>
		    					</c:when>
		    					<c:otherwise>
		    						<td onclick="goPtnrStatMenu('ptnrStatTeamTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
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
					            <c:set var="timeMemberSum_12_5" value="0"></c:set>
					            <c:set var="timeMemberSum_11_5" value="0"></c:set>
					            <c:set var="timeMemberSum_10_5" value="0"></c:set>
					            <c:set var="timeMemberSum_09_5" value="0"></c:set>
					            <c:set var="timeMemberSum_08_5" value="0"></c:set>
					            <c:set var="timeMemberSum_07_5" value="0"></c:set>
					            <c:set var="timeMemberSum_06_5" value="0"></c:set>
					            <c:set var="timeMemberSum_05_5" value="0"></c:set>
					            <c:set var="timeMemberSum_04_5" value="0"></c:set>
					            <c:set var="timeMemberSum_03_5" value="0"></c:set>
					            <c:set var="timeMemberSum_02_5" value="0"></c:set>
					            <c:set var="timeMemberSum_01_5" value="0"></c:set>
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
			    		<c:set var="time12_5" value="${vo.time12}"></c:set>
			            <c:set var="time11_5" value="${vo.time11}"></c:set>
			            <c:set var="time10_5" value="${vo.time10}"></c:set>
			            <c:set var="time09_5" value="${vo.time09}"></c:set>
			            <c:set var="time08_5" value="${vo.time08}"></c:set>
			            <c:set var="time07_5" value="${vo.time07}"></c:set>
			            <c:set var="time06_5" value="${vo.time06}"></c:set>
			            <c:set var="time05_5" value="${vo.time05}"></c:set>
			            <c:set var="time04_5" value="${vo.time04}"></c:set>
			            <c:set var="time03_5" value="${vo.time03}"></c:set>
			            <c:set var="time02_5" value="${vo.time02}"></c:set>
			            <c:set var="time01_5" value="${vo.time01}"></c:set>
			            
			            <!-- time12 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${time12_5}" pattern="#,##0.##"/></td>
	                    <!-- time11 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time11_5}" pattern="#,##0.##"/></td>
	                    <!-- time10 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time10_5}" pattern="#,##0.##"/></td>
	                    <!-- time09 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time09_5}" pattern="#,##0.##"/></td>
	                    <!-- time08 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time08_5}" pattern="#,##0.##"/></td>
	                    <!-- time07 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time07_5}" pattern="#,##0.##"/></td>
	                    <!-- time06 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time06_5}" pattern="#,##0.##"/></td>
	                    <!-- time05 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time05_5}" pattern="#,##0.##"/></td>
	                    <!-- time04 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time04_5}" pattern="#,##0.##"/></td>
	                    <!-- time03 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time03_5}" pattern="#,##0.##"/></td>
	                    <!-- time02 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time02_5}" pattern="#,##0.##"/></td>
	                    <!-- time01 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time01_5}" pattern="#,##0.##"/></td>
		                <!-- 가로 합계 -->
		                <c:set var="timeColSum_5" value="${time12_5 + time11_5 + time10_5 + time09_5 + time08_5 + time07_5 + time06_5 + time05_5 + time04_5 + time03_5 + time02_5 + time01_5}"></c:set>                    
		                <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeColSum_5}" pattern="#,##0.##"/></td>
		                
		                <!-- 직원별 계 합산 -->
	    				<c:set var="timeMemberSum_12_5" value="${timeMemberSum_12_5+time12_5}"></c:set>
			            <c:set var="timeMemberSum_11_5" value="${timeMemberSum_11_5+time11_5}"></c:set>
			            <c:set var="timeMemberSum_10_5" value="${timeMemberSum_10_5+time10_5}"></c:set>
			            <c:set var="timeMemberSum_09_5" value="${timeMemberSum_09_5+time09_5}"></c:set>
			            <c:set var="timeMemberSum_08_5" value="${timeMemberSum_08_5+time08_5}"></c:set>
			            <c:set var="timeMemberSum_07_5" value="${timeMemberSum_07_5+time07_5}"></c:set>
			            <c:set var="timeMemberSum_06_5" value="${timeMemberSum_06_5+time06_5}"></c:set>
			            <c:set var="timeMemberSum_05_5" value="${timeMemberSum_05_5+time05_5}"></c:set>
			            <c:set var="timeMemberSum_04_5" value="${timeMemberSum_04_5+time04_5}"></c:set>
			            <c:set var="timeMemberSum_03_5" value="${timeMemberSum_03_5+time03_5}"></c:set>
			            <c:set var="timeMemberSum_02_5" value="${timeMemberSum_02_5+time02_5}"></c:set>
			            <c:set var="timeMemberSum_01_5" value="${timeMemberSum_01_5+time01_5}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="timeMemberTotalSum_12_5" value="${timeMemberTotalSum_12_5 + time12_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_11_5" value="${timeMemberTotalSum_11_5 + time11_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_10_5" value="${timeMemberTotalSum_10_5 + time10_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_09_5" value="${timeMemberTotalSum_09_5 + time09_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_08_5" value="${timeMemberTotalSum_08_5 + time08_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_07_5" value="${timeMemberTotalSum_07_5 + time07_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_06_5" value="${timeMemberTotalSum_06_5 + time06_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_05_5" value="${timeMemberTotalSum_05_5 + time05_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_04_5" value="${timeMemberTotalSum_04_5 + time04_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_03_5" value="${timeMemberTotalSum_03_5 + time03_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_02_5" value="${timeMemberTotalSum_02_5 + time02_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_01_5" value="${timeMemberTotalSum_01_5 + time01_5}"></c:set>
		    		</tr>
		    		<!-- 직원별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${memberCnt == vo.rowCnt and vo.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- time12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_12_5}" pattern="#,##0.##"/></td>
			                <!-- time11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_11_5}" pattern="#,##0.##"/></td>
			                <!-- time10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_10_5}" pattern="#,##0.##"/></td>
			                <!-- time09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_09_5}" pattern="#,##0.##"/></td>
			                <!-- time08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_08_5}" pattern="#,##0.##"/></td>
			                <!-- time07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_07_5}" pattern="#,##0.##"/></td>
			                <!-- time06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_06_5}" pattern="#,##0.##"/></td>
			                <!-- time05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_05_5}" pattern="#,##0.##"/></td>
			                <!-- time04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_04_5}" pattern="#,##0.##"/></td>
			                <!-- time03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_03_5}" pattern="#,##0.##"/></td>
			                <!-- time02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_02_5}" pattern="#,##0.##"/></td>
			                <!-- time01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_01_5}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="timeMemberColSum_5" value="${timeMemberSum_12_5 + timeMemberSum_11_5 + timeMemberSum_10_5 + timeMemberSum_09_5 + timeMemberSum_08_5 + timeMemberSum_07_5 + timeMemberSum_06_5 + timeMemberSum_05_5 + timeMemberSum_04_5 + timeMemberSum_03_5 + timeMemberSum_02_5 + timeMemberSum_01_5}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberColSum_5}" pattern="#,##0.##"/></td>
			                
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="timeMemberSum_12_5" value="0"></c:set>
				            <c:set var="timeMemberSum_11_5" value="0"></c:set>
				            <c:set var="timeMemberSum_10_5" value="0"></c:set>
				            <c:set var="timeMemberSum_09_5" value="0"></c:set>
				            <c:set var="timeMemberSum_08_5" value="0"></c:set>
				            <c:set var="timeMemberSum_07_5" value="0"></c:set>
				            <c:set var="timeMemberSum_06_5" value="0"></c:set>
				            <c:set var="timeMemberSum_05_5" value="0"></c:set>
				            <c:set var="timeMemberSum_04_5" value="0"></c:set>
				            <c:set var="timeMemberSum_03_5" value="0"></c:set>
				            <c:set var="timeMemberSum_02_5" value="0"></c:set>
				            <c:set var="timeMemberSum_01_5" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo.rowCnt == 1}">
		    				<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="timeMemberSum_12_5" value="0"></c:set>
				            <c:set var="timeMemberSum_11_5" value="0"></c:set>
				            <c:set var="timeMemberSum_10_5" value="0"></c:set>
				            <c:set var="timeMemberSum_09_5" value="0"></c:set>
				            <c:set var="timeMemberSum_08_5" value="0"></c:set>
				            <c:set var="timeMemberSum_07_5" value="0"></c:set>
				            <c:set var="timeMemberSum_06_5" value="0"></c:set>
				            <c:set var="timeMemberSum_05_5" value="0"></c:set>
				            <c:set var="timeMemberSum_04_5" value="0"></c:set>
				            <c:set var="timeMemberSum_03_5" value="0"></c:set>
				            <c:set var="timeMemberSum_02_5" value="0"></c:set>
				            <c:set var="timeMemberSum_01_5" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 직원별 계 카운트 증가 -->
		    				<c:set var="memberCnt" value="${memberCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 직원별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 조사 소계 시작 -->
		    	<c:if test="${ptnrStatTimeList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 조사 소계</th>
	                <!-- time12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_12_5}" pattern="#,##0.##"/></th>
	                <!-- time11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_11_5}" pattern="#,##0.##"/></th>
	                <!-- time10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_10_5}" pattern="#,##0.##"/></th>
	                <!-- time09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_09_5}" pattern="#,##0.##"/></th>
	                <!-- time08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_08_5}" pattern="#,##0.##"/></th>
	                <!-- time07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_07_5}" pattern="#,##0.##"/></th>
	                <!-- time06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_06_5}" pattern="#,##0.##"/></th>
	                <!-- time05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_05_5}" pattern="#,##0.##"/></th>
	                <!-- time04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_04_5}" pattern="#,##0.##"/></th>
	                <!-- time03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_03_5}" pattern="#,##0.##"/></th>
	                <!-- time02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_02_5}" pattern="#,##0.##"/></th>
	                <!-- time01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_01_5}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="timeColTotalSum_5" value="${timeMemberTotalSum_12_5 + timeMemberTotalSum_11_5 + timeMemberTotalSum_10_5 + timeMemberTotalSum_09_5 + timeMemberTotalSum_08_5 + timeMemberTotalSum_07_5 + timeMemberTotalSum_06_5 + timeMemberTotalSum_05_5 + timeMemberTotalSum_04_5 + timeMemberTotalSum_03_5 + timeMemberTotalSum_02_5 + timeMemberTotalSum_01_5}"></c:set>
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeColTotalSum_5}" pattern="#,##0.##"/></th>	                
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
	            <c:set var="timeMemberSum_12_10" value="0"></c:set>
	            <c:set var="timeMemberSum_11_10" value="0"></c:set>
	            <c:set var="timeMemberSum_10_10" value="0"></c:set>
	            <c:set var="timeMemberSum_09_10" value="0"></c:set>
	            <c:set var="timeMemberSum_08_10" value="0"></c:set>
	            <c:set var="timeMemberSum_07_10" value="0"></c:set>
	            <c:set var="timeMemberSum_06_10" value="0"></c:set>
	            <c:set var="timeMemberSum_05_10" value="0"></c:set>
	            <c:set var="timeMemberSum_04_10" value="0"></c:set>
	            <c:set var="timeMemberSum_03_10" value="0"></c:set>
	            <c:set var="timeMemberSum_02_10" value="0"></c:set>
	            <c:set var="timeMemberSum_01_10" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="timeMemberTotalSum_12_10" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_11_10" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_10_10" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_09_10" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_08_10" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_07_10" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_06_10" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_05_10" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_04_10" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_03_10" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_02_10" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_01_10" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="timeColMemberTotalSum_10" value="0"></c:set>
   				    			
    			<c:forEach var="vo1" items="${ptnrStatTimeList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <c:choose>
		    					<c:when test='${srchArg.tabMenu eq "team"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
				                    	1종 심사
				                    </td>
		    					</c:when>
		    					<c:when test='${srchArg.tabMenu eq "member"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
				                    	1종 심사
				                    </td>
		    					</c:when>
		    					<c:otherwise>
		    						<td onclick="goPtnrStatMenu('ptnrStatTeamTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
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
					            <c:set var="timeMemberSum_12_10" value="0"></c:set>
					            <c:set var="timeMemberSum_11_10" value="0"></c:set>
					            <c:set var="timeMemberSum_10_10" value="0"></c:set>
					            <c:set var="timeMemberSum_09_10" value="0"></c:set>
					            <c:set var="timeMemberSum_08_10" value="0"></c:set>
					            <c:set var="timeMemberSum_07_10" value="0"></c:set>
					            <c:set var="timeMemberSum_06_10" value="0"></c:set>
					            <c:set var="timeMemberSum_05_10" value="0"></c:set>
					            <c:set var="timeMemberSum_04_10" value="0"></c:set>
					            <c:set var="timeMemberSum_03_10" value="0"></c:set>
					            <c:set var="timeMemberSum_02_10" value="0"></c:set>
					            <c:set var="timeMemberSum_01_10" value="0"></c:set>
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
			    		<c:set var="time12_10" value="${vo1.time12}"></c:set>
			            <c:set var="time11_10" value="${vo1.time11}"></c:set>
			            <c:set var="time10_10" value="${vo1.time10}"></c:set>
			            <c:set var="time09_10" value="${vo1.time09}"></c:set>
			            <c:set var="time08_10" value="${vo1.time08}"></c:set>
			            <c:set var="time07_10" value="${vo1.time07}"></c:set>
			            <c:set var="time06_10" value="${vo1.time06}"></c:set>
			            <c:set var="time05_10" value="${vo1.time05}"></c:set>
			            <c:set var="time04_10" value="${vo1.time04}"></c:set>
			            <c:set var="time03_10" value="${vo1.time03}"></c:set>
			            <c:set var="time02_10" value="${vo1.time02}"></c:set>
			            <c:set var="time01_10" value="${vo1.time01}"></c:set>
			            
			            <!-- time12 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${time12_10}" pattern="#,##0.##"/></td>
	                    <!-- time11 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time11_10}" pattern="#,##0.##"/></td>
	                    <!-- time10 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time10_10}" pattern="#,##0.##"/></td>
	                    <!-- time09 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time09_10}" pattern="#,##0.##"/></td>
	                    <!-- time08 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time08_10}" pattern="#,##0.##"/></td>
	                    <!-- time07 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time07_10}" pattern="#,##0.##"/></td>
	                    <!-- time06 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time06_10}" pattern="#,##0.##"/></td>
	                    <!-- time05 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time05_10}" pattern="#,##0.##"/></td>
	                    <!-- time04 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time04_10}" pattern="#,##0.##"/></td>
	                    <!-- time03 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time03_10}" pattern="#,##0.##"/></td>
	                    <!-- time02 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time02_10}" pattern="#,##0.##"/></td>
	                    <!-- time01 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time01_10}" pattern="#,##0.##"/></td>
	                    <!-- 가로 합계 -->
	                    <c:set var="timeColSum_10" value="${time12_10 + time11_10 + time10_10 + time09_10 + time08_10 + time07_10 + time06_10 + time05_10 + time04_10 + time03_10 + time02_10 + time01_10}"></c:set>                    
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeColSum_10}" pattern="#,##0.##"/></td>
		                
		                <!-- 직원별 계 합산 -->
	    				<c:set var="timeMemberSum_12_10" value="${timeMemberSum_12_10+time12_10}"></c:set>
			            <c:set var="timeMemberSum_11_10" value="${timeMemberSum_11_10+time11_10}"></c:set>
			            <c:set var="timeMemberSum_10_10" value="${timeMemberSum_10_10+time10_10}"></c:set>
			            <c:set var="timeMemberSum_09_10" value="${timeMemberSum_09_10+time09_10}"></c:set>
			            <c:set var="timeMemberSum_08_10" value="${timeMemberSum_08_10+time08_10}"></c:set>
			            <c:set var="timeMemberSum_07_10" value="${timeMemberSum_07_10+time07_10}"></c:set>
			            <c:set var="timeMemberSum_06_10" value="${timeMemberSum_06_10+time06_10}"></c:set>
			            <c:set var="timeMemberSum_05_10" value="${timeMemberSum_05_10+time05_10}"></c:set>
			            <c:set var="timeMemberSum_04_10" value="${timeMemberSum_04_10+time04_10}"></c:set>
			            <c:set var="timeMemberSum_03_10" value="${timeMemberSum_03_10+time03_10}"></c:set>
			            <c:set var="timeMemberSum_02_10" value="${timeMemberSum_02_10+time02_10}"></c:set>
			            <c:set var="timeMemberSum_01_10" value="${timeMemberSum_01_10+time01_10}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="timeMemberTotalSum_12_10" value="${timeMemberTotalSum_12_10 + time12_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_11_10" value="${timeMemberTotalSum_11_10 + time11_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_10_10" value="${timeMemberTotalSum_10_10 + time10_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_09_10" value="${timeMemberTotalSum_09_10 + time09_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_08_10" value="${timeMemberTotalSum_08_10 + time08_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_07_10" value="${timeMemberTotalSum_07_10 + time07_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_06_10" value="${timeMemberTotalSum_06_10 + time06_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_05_10" value="${timeMemberTotalSum_05_10 + time05_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_04_10" value="${timeMemberTotalSum_04_10 + time04_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_03_10" value="${timeMemberTotalSum_03_10 + time03_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_02_10" value="${timeMemberTotalSum_02_10 + time02_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_01_10" value="${timeMemberTotalSum_01_10 + time01_10}"></c:set>
		    		</tr>
		    		<!-- 직원별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${memberCnt == vo1.rowCnt and vo1.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- time12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_12_10}" pattern="#,##0.##"/></td>
			                <!-- time11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_11_10}" pattern="#,##0.##"/></td>
			                <!-- time10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_10_10}" pattern="#,##0.##"/></td>
			                <!-- time09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_09_10}" pattern="#,##0.##"/></td>
			                <!-- time08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_08_10}" pattern="#,##0.##"/></td>
			                <!-- time07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_07_10}" pattern="#,##0.##"/></td>
			                <!-- time06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_06_10}" pattern="#,##0.##"/></td>
			                <!-- time05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_05_10}" pattern="#,##0.##"/></td>
			                <!-- time04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_04_10}" pattern="#,##0.##"/></td>
			                <!-- time03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_03_10}" pattern="#,##0.##"/></td>
			                <!-- time02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_02_10}" pattern="#,##0.##"/></td>
			                <!-- time01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_01_10}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="timeMemberColSum_10" value="${timeMemberSum_12_10 + timeMemberSum_11_10 + timeMemberSum_10_10 + timeMemberSum_09_10 + timeMemberSum_08_10 + timeMemberSum_07_10 + timeMemberSum_06_10 + timeMemberSum_05_10 + timeMemberSum_04_10 + timeMemberSum_03_10 + timeMemberSum_02_10 + timeMemberSum_01_10}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberColSum_10}" pattern="#,##0.##"/></td>
			                
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="timeMemberSum_12_10" value="0"></c:set>
				            <c:set var="timeMemberSum_11_10" value="0"></c:set>
				            <c:set var="timeMemberSum_10_10" value="0"></c:set>
				            <c:set var="timeMemberSum_09_10" value="0"></c:set>
				            <c:set var="timeMemberSum_08_10" value="0"></c:set>
				            <c:set var="timeMemberSum_07_10" value="0"></c:set>
				            <c:set var="timeMemberSum_06_10" value="0"></c:set>
				            <c:set var="timeMemberSum_05_10" value="0"></c:set>
				            <c:set var="timeMemberSum_04_10" value="0"></c:set>
				            <c:set var="timeMemberSum_03_10" value="0"></c:set>
				            <c:set var="timeMemberSum_02_10" value="0"></c:set>
				            <c:set var="timeMemberSum_01_10" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo1.rowCnt == 1}">
		    				<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="timeMemberSum_12_10" value="0"></c:set>
				            <c:set var="timeMemberSum_11_10" value="0"></c:set>
				            <c:set var="timeMemberSum_10_10" value="0"></c:set>
				            <c:set var="timeMemberSum_09_10" value="0"></c:set>
				            <c:set var="timeMemberSum_08_10" value="0"></c:set>
				            <c:set var="timeMemberSum_07_10" value="0"></c:set>
				            <c:set var="timeMemberSum_06_10" value="0"></c:set>
				            <c:set var="timeMemberSum_05_10" value="0"></c:set>
				            <c:set var="timeMemberSum_04_10" value="0"></c:set>
				            <c:set var="timeMemberSum_03_10" value="0"></c:set>
				            <c:set var="timeMemberSum_02_10" value="0"></c:set>
				            <c:set var="timeMemberSum_01_10" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 직원별 계 카운트 증가 -->
		    				<c:set var="memberCnt" value="${memberCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 직원별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 심사 소계 시작 -->
		    	<c:if test="${ptnrStatTimeList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 심사 소계</th>
	                <!-- time12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_12_10}" pattern="#,##0.##"/></th>
	                <!-- time11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_11_10}" pattern="#,##0.##"/></th>
	                <!-- time10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_10_10}" pattern="#,##0.##"/></th>
	                <!-- time09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_09_10}" pattern="#,##0.##"/></th>
	                <!-- time08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_08_10}" pattern="#,##0.##"/></th>
	                <!-- time07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_07_10}" pattern="#,##0.##"/></th>
	                <!-- time06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_06_10}" pattern="#,##0.##"/></th>
	                <!-- time05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_05_10}" pattern="#,##0.##"/></th>
	                <!-- time04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_04_10}" pattern="#,##0.##"/></th>
	                <!-- time03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_03_10}" pattern="#,##0.##"/></th>
	                <!-- time02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_02_10}" pattern="#,##0.##"/></th>
	                <!-- time01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_01_10}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="timeColTotalSum_10" value="${timeMemberTotalSum_12_10 + timeMemberTotalSum_11_10 + timeMemberTotalSum_10_10 + timeMemberTotalSum_09_10 + timeMemberTotalSum_08_10 + timeMemberTotalSum_07_10 + timeMemberTotalSum_06_10 + timeMemberTotalSum_05_10 + timeMemberTotalSum_04_10 + timeMemberTotalSum_03_10 + timeMemberTotalSum_02_10 + timeMemberTotalSum_01_10}"></c:set>
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeColTotalSum_10}" pattern="#,##0.##"/></th>	                
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
	            <c:set var="timeMemberSum_12_15" value="0"></c:set>
	            <c:set var="timeMemberSum_11_15" value="0"></c:set>
	            <c:set var="timeMemberSum_10_15" value="0"></c:set>
	            <c:set var="timeMemberSum_09_15" value="0"></c:set>
	            <c:set var="timeMemberSum_08_15" value="0"></c:set>
	            <c:set var="timeMemberSum_07_15" value="0"></c:set>
	            <c:set var="timeMemberSum_06_15" value="0"></c:set>
	            <c:set var="timeMemberSum_05_15" value="0"></c:set>
	            <c:set var="timeMemberSum_04_15" value="0"></c:set>
	            <c:set var="timeMemberSum_03_15" value="0"></c:set>
	            <c:set var="timeMemberSum_02_15" value="0"></c:set>
	            <c:set var="timeMemberSum_01_15" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="timeMemberTotalSum_12_15" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_11_15" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_10_15" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_09_15" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_08_15" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_07_15" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_06_15" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_05_15" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_04_15" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_03_15" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_02_15" value="0"></c:set>
	            <c:set var="timeMemberTotalSum_01_15" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="timeColMemberTotalSum_15" value="0"></c:set>
   				    			
    			<c:forEach var="vo2" items="${ptnrStatTimeList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <c:choose>
		    					<c:when test='${srchArg.tabMenu eq "team"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
				                    	1종 기타
				                    </td>
		    					</c:when>
		    					<c:when test='${srchArg.tabMenu eq "member"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
				                    	1종 기타
				                    </td>
		    					</c:when>
		    					<c:otherwise>
		    						<td onclick="goPtnrStatMenu('ptnrStatTeamTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
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
					            <c:set var="timeMemberSum_12_15" value="0"></c:set>
					            <c:set var="timeMemberSum_11_15" value="0"></c:set>
					            <c:set var="timeMemberSum_10_15" value="0"></c:set>
					            <c:set var="timeMemberSum_09_15" value="0"></c:set>
					            <c:set var="timeMemberSum_08_15" value="0"></c:set>
					            <c:set var="timeMemberSum_07_15" value="0"></c:set>
					            <c:set var="timeMemberSum_06_15" value="0"></c:set>
					            <c:set var="timeMemberSum_05_15" value="0"></c:set>
					            <c:set var="timeMemberSum_04_15" value="0"></c:set>
					            <c:set var="timeMemberSum_03_15" value="0"></c:set>
					            <c:set var="timeMemberSum_02_15" value="0"></c:set>
					            <c:set var="timeMemberSum_01_15" value="0"></c:set>
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
			    		<c:set var="time12_15" value="${vo2.time12}"></c:set>
			            <c:set var="time11_15" value="${vo2.time11}"></c:set>
			            <c:set var="time10_15" value="${vo2.time10}"></c:set>
			            <c:set var="time09_15" value="${vo2.time09}"></c:set>
			            <c:set var="time08_15" value="${vo2.time08}"></c:set>
			            <c:set var="time07_15" value="${vo2.time07}"></c:set>
			            <c:set var="time06_15" value="${vo2.time06}"></c:set>
			            <c:set var="time05_15" value="${vo2.time05}"></c:set>
			            <c:set var="time04_15" value="${vo2.time04}"></c:set>
			            <c:set var="time03_15" value="${vo2.time03}"></c:set>
			            <c:set var="time02_15" value="${vo2.time02}"></c:set>
			            <c:set var="time01_15" value="${vo2.time01}"></c:set>
			            
			            <!-- time12 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${time12_15}" pattern="#,##0.##"/></td>
	                    <!-- time11 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time11_15}" pattern="#,##0.##"/></td>
	                    <!-- time10 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time10_15}" pattern="#,##0.##"/></td>
	                    <!-- time09 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time09_15}" pattern="#,##0.##"/></td>
	                    <!-- time08 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time08_15}" pattern="#,##0.##"/></td>
	                    <!-- time07 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time07_15}" pattern="#,##0.##"/></td>
	                    <!-- time06 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time06_15}" pattern="#,##0.##"/></td>
	                    <!-- time05 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time05_15}" pattern="#,##0.##"/></td>
	                    <!-- time04 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time04_15}" pattern="#,##0.##"/></td>
	                    <!-- time03 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time03_15}" pattern="#,##0.##"/></td>
	                    <!-- time02 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time02_15}" pattern="#,##0.##"/></td>
	                    <!-- time01 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${time01_15}" pattern="#,##0.##"/></td>
	                    <!-- 가로 합계 -->
	                    <c:set var="timeColSum_15" value="${time12_15 + time11_15 + time10_15 + time09_15 + time08_15 + time07_15 + time06_15 + time05_15 + time04_15 + time03_15 + time02_15 + time01_15}"></c:set>                    
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeColSum_15}" pattern="#,##0.##"/></td>
		                
		                <!-- 직원별 계 합산 -->
	    				<c:set var="timeMemberSum_12_15" value="${timeMemberSum_12_15+time12_15}"></c:set>
			            <c:set var="timeMemberSum_11_15" value="${timeMemberSum_11_15+time11_15}"></c:set>
			            <c:set var="timeMemberSum_10_15" value="${timeMemberSum_10_15+time10_15}"></c:set>
			            <c:set var="timeMemberSum_09_15" value="${timeMemberSum_09_15+time09_15}"></c:set>
			            <c:set var="timeMemberSum_08_15" value="${timeMemberSum_08_15+time08_15}"></c:set>
			            <c:set var="timeMemberSum_07_15" value="${timeMemberSum_07_15+time07_15}"></c:set>
			            <c:set var="timeMemberSum_06_15" value="${timeMemberSum_06_15+time06_15}"></c:set>
			            <c:set var="timeMemberSum_05_15" value="${timeMemberSum_05_15+time05_15}"></c:set>
			            <c:set var="timeMemberSum_04_15" value="${timeMemberSum_04_15+time04_15}"></c:set>
			            <c:set var="timeMemberSum_03_15" value="${timeMemberSum_03_15+time03_15}"></c:set>
			            <c:set var="timeMemberSum_02_15" value="${timeMemberSum_02_15+time02_15}"></c:set>
			            <c:set var="timeMemberSum_01_15" value="${timeMemberSum_01_15+time01_15}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="timeMemberTotalSum_12_15" value="${timeMemberTotalSum_12_15 + time12_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_11_15" value="${timeMemberTotalSum_11_15 + time11_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_10_15" value="${timeMemberTotalSum_10_15 + time10_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_09_15" value="${timeMemberTotalSum_09_15 + time09_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_08_15" value="${timeMemberTotalSum_08_15 + time08_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_07_15" value="${timeMemberTotalSum_07_15 + time07_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_06_15" value="${timeMemberTotalSum_06_15 + time06_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_05_15" value="${timeMemberTotalSum_05_15 + time05_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_04_15" value="${timeMemberTotalSum_04_15 + time04_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_03_15" value="${timeMemberTotalSum_03_15 + time03_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_02_15" value="${timeMemberTotalSum_02_15 + time02_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_01_15" value="${timeMemberTotalSum_01_15 + time01_15}"></c:set>
		    		</tr>
		    		<!-- 직원별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${memberCnt == vo2.rowCnt and vo2.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- time12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_12_15}" pattern="#,##0.##"/></td>
			                <!-- time11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_11_15}" pattern="#,##0.##"/></td>
			                <!-- time10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_10_15}" pattern="#,##0.##"/></td>
			                <!-- time09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_09_15}" pattern="#,##0.##"/></td>
			                <!-- time08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_08_15}" pattern="#,##0.##"/></td>
			                <!-- time07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_07_15}" pattern="#,##0.##"/></td>
			                <!-- time06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_06_15}" pattern="#,##0.##"/></td>
			                <!-- time05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_05_15}" pattern="#,##0.##"/></td>
			                <!-- time04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_04_15}" pattern="#,##0.##"/></td>
			                <!-- time03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_03_15}" pattern="#,##0.##"/></td>
			                <!-- time02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_02_15}" pattern="#,##0.##"/></td>
			                <!-- time01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberSum_01_15}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="timeMemberColSum_15" value="${timeMemberSum_12_15 + timeMemberSum_11_15 + timeMemberSum_10_15 + timeMemberSum_09_15 + timeMemberSum_08_15 + timeMemberSum_07_15 + timeMemberSum_06_15 + timeMemberSum_05_15 + timeMemberSum_04_15 + timeMemberSum_03_15 + timeMemberSum_02_15 + timeMemberSum_01_15}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${timeMemberColSum_15}" pattern="#,##0.##"/></td>
			                
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="timeMemberSum_12_15" value="0"></c:set>
				            <c:set var="timeMemberSum_11_15" value="0"></c:set>
				            <c:set var="timeMemberSum_10_15" value="0"></c:set>
				            <c:set var="timeMemberSum_09_15" value="0"></c:set>
				            <c:set var="timeMemberSum_08_15" value="0"></c:set>
				            <c:set var="timeMemberSum_07_15" value="0"></c:set>
				            <c:set var="timeMemberSum_06_15" value="0"></c:set>
				            <c:set var="timeMemberSum_05_15" value="0"></c:set>
				            <c:set var="timeMemberSum_04_15" value="0"></c:set>
				            <c:set var="timeMemberSum_03_15" value="0"></c:set>
				            <c:set var="timeMemberSum_02_15" value="0"></c:set>
				            <c:set var="timeMemberSum_01_15" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo2.rowCnt == 1}">
		    				<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="timeMemberSum_12_15" value="0"></c:set>
				            <c:set var="timeMemberSum_11_15" value="0"></c:set>
				            <c:set var="timeMemberSum_10_15" value="0"></c:set>
				            <c:set var="timeMemberSum_09_15" value="0"></c:set>
				            <c:set var="timeMemberSum_08_15" value="0"></c:set>
				            <c:set var="timeMemberSum_07_15" value="0"></c:set>
				            <c:set var="timeMemberSum_06_15" value="0"></c:set>
				            <c:set var="timeMemberSum_05_15" value="0"></c:set>
				            <c:set var="timeMemberSum_04_15" value="0"></c:set>
				            <c:set var="timeMemberSum_03_15" value="0"></c:set>
				            <c:set var="timeMemberSum_02_15" value="0"></c:set>
				            <c:set var="timeMemberSum_01_15" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 직원별 계 카운트 증가 -->
		    				<c:set var="memberCnt" value="${memberCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 직원별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 기타 소계 시작 -->
		    	<c:if test="${ptnrStatTimeList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 기타 소계</th>
	                <!-- time12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_12_15}" pattern="#,##0.##"/></th>
	                <!-- time11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_11_15}" pattern="#,##0.##"/></th>
	                <!-- time10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_10_15}" pattern="#,##0.##"/></th>
	                <!-- time09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_09_15}" pattern="#,##0.##"/></th>
	                <!-- time08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_08_15}" pattern="#,##0.##"/></th>
	                <!-- time07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_07_15}" pattern="#,##0.##"/></th>
	                <!-- time06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_06_15}" pattern="#,##0.##"/></th>
	                <!-- time05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_05_15}" pattern="#,##0.##"/></th>
	                <!-- time04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_04_15}" pattern="#,##0.##"/></th>
	                <!-- time03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_03_15}" pattern="#,##0.##"/></th>
	                <!-- time02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_02_15}" pattern="#,##0.##"/></th>
	                <!-- time01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeMemberTotalSum_01_15}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="timeColTotalSum_15" value="${timeMemberTotalSum_12_15 + timeMemberTotalSum_11_15 + timeMemberTotalSum_10_15 + timeMemberTotalSum_09_15 + timeMemberTotalSum_08_15 + timeMemberTotalSum_07_15 + timeMemberTotalSum_06_15 + timeMemberTotalSum_05_15 + timeMemberTotalSum_04_15 + timeMemberTotalSum_03_15 + timeMemberTotalSum_02_15 + timeMemberTotalSum_01_15}"></c:set>
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${timeColTotalSum_15}" pattern="#,##0.##"/></th>	                
	            </tr>
	            </c:if>
		    	<!-- 1종 기타 소계 끝 -->
    		</tbody>
    	</table>
    	<!-- 1종 기타 끝 -->  	        
    </div>    
    <!-- 총 합계 시작 -->
    <!-- 총 합계 변수 시작 -->
    <c:set var="timeMemberTotalSum_12_all" value="${timeMemberTotalSum_12_5 + timeMemberTotalSum_12_10 + timeMemberTotalSum_12_15}"></c:set>
    <c:set var="timeMemberTotalSum_11_all" value="${timeMemberTotalSum_11_5 + timeMemberTotalSum_11_10 + timeMemberTotalSum_11_15}"></c:set>
    <c:set var="timeMemberTotalSum_10_all" value="${timeMemberTotalSum_10_5 + timeMemberTotalSum_10_10 + timeMemberTotalSum_10_15}"></c:set>
    <c:set var="timeMemberTotalSum_09_all" value="${timeMemberTotalSum_09_5 + timeMemberTotalSum_09_10 + timeMemberTotalSum_09_15}"></c:set>
    <c:set var="timeMemberTotalSum_08_all" value="${timeMemberTotalSum_08_5 + timeMemberTotalSum_08_10 + timeMemberTotalSum_08_15}"></c:set>
    <c:set var="timeMemberTotalSum_07_all" value="${timeMemberTotalSum_07_5 + timeMemberTotalSum_07_10 + timeMemberTotalSum_07_15}"></c:set>
    <c:set var="timeMemberTotalSum_06_all" value="${timeMemberTotalSum_06_5 + timeMemberTotalSum_06_10 + timeMemberTotalSum_06_15}"></c:set>
    <c:set var="timeMemberTotalSum_05_all" value="${timeMemberTotalSum_05_5 + timeMemberTotalSum_05_10 + timeMemberTotalSum_05_15}"></c:set>
    <c:set var="timeMemberTotalSum_04_all" value="${timeMemberTotalSum_04_5 + timeMemberTotalSum_04_10 + timeMemberTotalSum_04_15}"></c:set>
    <c:set var="timeMemberTotalSum_03_all" value="${timeMemberTotalSum_03_5 + timeMemberTotalSum_03_10 + timeMemberTotalSum_03_15}"></c:set>
    <c:set var="timeMemberTotalSum_02_all" value="${timeMemberTotalSum_02_5 + timeMemberTotalSum_02_10 + timeMemberTotalSum_02_15}"></c:set>
    <c:set var="timeMemberTotalSum_01_all" value="${timeMemberTotalSum_01_5 + timeMemberTotalSum_01_10 + timeMemberTotalSum_01_15}"></c:set>        
    <c:set var="timeMemberTotalSum_col_all" value="${timeMemberTotalSum_12_all + timeMemberTotalSum_11_all + timeMemberTotalSum_10_all + timeMemberTotalSum_09_all + timeMemberTotalSum_08_all + timeMemberTotalSum_07_all + timeMemberTotalSum_06_all + timeMemberTotalSum_05_all + timeMemberTotalSum_04_all + timeMemberTotalSum_03_all + timeMemberTotalSum_02_all + timeMemberTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체합계</th>    			
    			<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeMemberTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeMemberTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeMemberTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeMemberTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeMemberTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeMemberTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeMemberTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeMemberTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeMemberTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeMemberTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeMemberTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeMemberTotalSum_01_all}" pattern="#,##0.##"/></th>
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${timeMemberTotalSum_col_all}" pattern="#,##0.##"/></th>    			
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>