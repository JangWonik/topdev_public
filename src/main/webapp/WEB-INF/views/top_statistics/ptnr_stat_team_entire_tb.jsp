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
	            <c:set var="entireTeamSum_12_5" value="0"></c:set>
	            <c:set var="entireTeamSum_11_5" value="0"></c:set>
	            <c:set var="entireTeamSum_10_5" value="0"></c:set>
	            <c:set var="entireTeamSum_09_5" value="0"></c:set>
	            <c:set var="entireTeamSum_08_5" value="0"></c:set>
	            <c:set var="entireTeamSum_07_5" value="0"></c:set>
	            <c:set var="entireTeamSum_06_5" value="0"></c:set>
	            <c:set var="entireTeamSum_05_5" value="0"></c:set>
	            <c:set var="entireTeamSum_04_5" value="0"></c:set>
	            <c:set var="entireTeamSum_03_5" value="0"></c:set>
	            <c:set var="entireTeamSum_02_5" value="0"></c:set>
	            <c:set var="entireTeamSum_01_5" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="entireTeamTotalSum_12_5" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_11_5" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_10_5" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_09_5" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_08_5" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_07_5" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_06_5" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_05_5" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_04_5" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_03_5" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_02_5" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_01_5" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="entireColTeamTotalSum_5" value="0"></c:set>
   				    			
    			<c:forEach var="vo" items="${ptnrStatEntireList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCenterEntire');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
		                    	1종 조사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatMember(${vo.ptnrId},${vo.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.teamName}</td>
		                		<td style="width:150px;">${vo.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="entireTeamSum_12_5" value="0"></c:set>
					            <c:set var="entireTeamSum_11_5" value="0"></c:set>
					            <c:set var="entireTeamSum_10_5" value="0"></c:set>
					            <c:set var="entireTeamSum_09_5" value="0"></c:set>
					            <c:set var="entireTeamSum_08_5" value="0"></c:set>
					            <c:set var="entireTeamSum_07_5" value="0"></c:set>
					            <c:set var="entireTeamSum_06_5" value="0"></c:set>
					            <c:set var="entireTeamSum_05_5" value="0"></c:set>
					            <c:set var="entireTeamSum_04_5" value="0"></c:set>
					            <c:set var="entireTeamSum_03_5" value="0"></c:set>
					            <c:set var="entireTeamSum_02_5" value="0"></c:set>
					            <c:set var="entireTeamSum_01_5" value="0"></c:set>
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
			    		<c:set var="entire12_5" value="${vo.entire12}"></c:set>
			            <c:set var="entire11_5" value="${vo.entire11}"></c:set>
			            <c:set var="entire10_5" value="${vo.entire10}"></c:set>
			            <c:set var="entire09_5" value="${vo.entire09}"></c:set>
			            <c:set var="entire08_5" value="${vo.entire08}"></c:set>
			            <c:set var="entire07_5" value="${vo.entire07}"></c:set>
			            <c:set var="entire06_5" value="${vo.entire06}"></c:set>
			            <c:set var="entire05_5" value="${vo.entire05}"></c:set>
			            <c:set var="entire04_5" value="${vo.entire04}"></c:set>
			            <c:set var="entire03_5" value="${vo.entire03}"></c:set>
			            <c:set var="entire02_5" value="${vo.entire02}"></c:set>
			            <c:set var="entire01_5" value="${vo.entire01}"></c:set>
			            
			            <!-- entire12 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${entire12_5}" pattern="#,##0.##"/></td>
	                    <!-- entire11 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire11_5}" pattern="#,##0.##"/></td>
	                    <!-- entire10 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire10_5}" pattern="#,##0.##"/></td>
	                    <!-- entire09 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire09_5}" pattern="#,##0.##"/></td>
	                    <!-- entire08 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire08_5}" pattern="#,##0.##"/></td>
	                    <!-- entire07 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire07_5}" pattern="#,##0.##"/></td>
	                    <!-- entire06 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire06_5}" pattern="#,##0.##"/></td>
	                    <!-- entire05 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire05_5}" pattern="#,##0.##"/></td>
	                    <!-- entire04 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire04_5}" pattern="#,##0.##"/></td>
	                    <!-- entire03 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire03_5}" pattern="#,##0.##"/></td>
	                    <!-- entire02 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire02_5}" pattern="#,##0.##"/></td>
	                    <!-- entire01 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire01_5}" pattern="#,##0.##"/></td>
		                <!-- 가로 합계 -->
		                <c:set var="entireColSum_5" value="${entire12_5 + entire11_5 + entire10_5 + entire09_5 + entire08_5 + entire07_5 + entire06_5 + entire05_5 + entire04_5 + entire03_5 + entire02_5 + entire01_5}"></c:set>                    
		                <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireColSum_5}" pattern="#,##0.##"/></td>
		                
		                <!-- 팀별 계 합산 -->
	    				<c:set var="entireTeamSum_12_5" value="${entireTeamSum_12_5+entire12_5}"></c:set>
			            <c:set var="entireTeamSum_11_5" value="${entireTeamSum_11_5+entire11_5}"></c:set>
			            <c:set var="entireTeamSum_10_5" value="${entireTeamSum_10_5+entire10_5}"></c:set>
			            <c:set var="entireTeamSum_09_5" value="${entireTeamSum_09_5+entire09_5}"></c:set>
			            <c:set var="entireTeamSum_08_5" value="${entireTeamSum_08_5+entire08_5}"></c:set>
			            <c:set var="entireTeamSum_07_5" value="${entireTeamSum_07_5+entire07_5}"></c:set>
			            <c:set var="entireTeamSum_06_5" value="${entireTeamSum_06_5+entire06_5}"></c:set>
			            <c:set var="entireTeamSum_05_5" value="${entireTeamSum_05_5+entire05_5}"></c:set>
			            <c:set var="entireTeamSum_04_5" value="${entireTeamSum_04_5+entire04_5}"></c:set>
			            <c:set var="entireTeamSum_03_5" value="${entireTeamSum_03_5+entire03_5}"></c:set>
			            <c:set var="entireTeamSum_02_5" value="${entireTeamSum_02_5+entire02_5}"></c:set>
			            <c:set var="entireTeamSum_01_5" value="${entireTeamSum_01_5+entire01_5}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="entireTeamTotalSum_12_5" value="${entireTeamTotalSum_12_5 + entire12_5}"></c:set>
	                    <c:set var="entireTeamTotalSum_11_5" value="${entireTeamTotalSum_11_5 + entire11_5}"></c:set>
	                    <c:set var="entireTeamTotalSum_10_5" value="${entireTeamTotalSum_10_5 + entire10_5}"></c:set>
	                    <c:set var="entireTeamTotalSum_09_5" value="${entireTeamTotalSum_09_5 + entire09_5}"></c:set>
	                    <c:set var="entireTeamTotalSum_08_5" value="${entireTeamTotalSum_08_5 + entire08_5}"></c:set>
	                    <c:set var="entireTeamTotalSum_07_5" value="${entireTeamTotalSum_07_5 + entire07_5}"></c:set>
	                    <c:set var="entireTeamTotalSum_06_5" value="${entireTeamTotalSum_06_5 + entire06_5}"></c:set>
	                    <c:set var="entireTeamTotalSum_05_5" value="${entireTeamTotalSum_05_5 + entire05_5}"></c:set>
	                    <c:set var="entireTeamTotalSum_04_5" value="${entireTeamTotalSum_04_5 + entire04_5}"></c:set>
	                    <c:set var="entireTeamTotalSum_03_5" value="${entireTeamTotalSum_03_5 + entire03_5}"></c:set>
	                    <c:set var="entireTeamTotalSum_02_5" value="${entireTeamTotalSum_02_5 + entire02_5}"></c:set>
	                    <c:set var="entireTeamTotalSum_01_5" value="${entireTeamTotalSum_01_5 + entire01_5}"></c:set>
		    		</tr>
		    		<!-- 팀별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo.rowCnt and vo.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- entire12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_12_5}" pattern="#,##0.##"/></td>
			                <!-- entire11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_11_5}" pattern="#,##0.##"/></td>
			                <!-- entire10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_10_5}" pattern="#,##0.##"/></td>
			                <!-- entire09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_09_5}" pattern="#,##0.##"/></td>
			                <!-- entire08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_08_5}" pattern="#,##0.##"/></td>
			                <!-- entire07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_07_5}" pattern="#,##0.##"/></td>
			                <!-- entire06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_06_5}" pattern="#,##0.##"/></td>
			                <!-- entire05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_05_5}" pattern="#,##0.##"/></td>
			                <!-- entire04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_04_5}" pattern="#,##0.##"/></td>
			                <!-- entire03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_03_5}" pattern="#,##0.##"/></td>
			                <!-- entire02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_02_5}" pattern="#,##0.##"/></td>
			                <!-- entire01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_01_5}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="entireTeamColSum_5" value="${entireTeamSum_12_5 + entireTeamSum_11_5 + entireTeamSum_10_5 + entireTeamSum_09_5 + entireTeamSum_08_5 + entireTeamSum_07_5 + entireTeamSum_06_5 + entireTeamSum_05_5 + entireTeamSum_04_5 + entireTeamSum_03_5 + entireTeamSum_02_5 + entireTeamSum_01_5}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamColSum_5}" pattern="#,##0.##"/></td>
			                
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="entireTeamSum_12_5" value="0"></c:set>
				            <c:set var="entireTeamSum_11_5" value="0"></c:set>
				            <c:set var="entireTeamSum_10_5" value="0"></c:set>
				            <c:set var="entireTeamSum_09_5" value="0"></c:set>
				            <c:set var="entireTeamSum_08_5" value="0"></c:set>
				            <c:set var="entireTeamSum_07_5" value="0"></c:set>
				            <c:set var="entireTeamSum_06_5" value="0"></c:set>
				            <c:set var="entireTeamSum_05_5" value="0"></c:set>
				            <c:set var="entireTeamSum_04_5" value="0"></c:set>
				            <c:set var="entireTeamSum_03_5" value="0"></c:set>
				            <c:set var="entireTeamSum_02_5" value="0"></c:set>
				            <c:set var="entireTeamSum_01_5" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo.rowCnt == 1}">
		    				<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="entireTeamSum_12_5" value="0"></c:set>
				            <c:set var="entireTeamSum_11_5" value="0"></c:set>
				            <c:set var="entireTeamSum_10_5" value="0"></c:set>
				            <c:set var="entireTeamSum_09_5" value="0"></c:set>
				            <c:set var="entireTeamSum_08_5" value="0"></c:set>
				            <c:set var="entireTeamSum_07_5" value="0"></c:set>
				            <c:set var="entireTeamSum_06_5" value="0"></c:set>
				            <c:set var="entireTeamSum_05_5" value="0"></c:set>
				            <c:set var="entireTeamSum_04_5" value="0"></c:set>
				            <c:set var="entireTeamSum_03_5" value="0"></c:set>
				            <c:set var="entireTeamSum_02_5" value="0"></c:set>
				            <c:set var="entireTeamSum_01_5" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 팀별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 팀별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 조사 소계 시작 -->
		    	<c:if test="${ptnrStatEntireList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 조사 소계</th>
	                <!-- entire12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_12_5}" pattern="#,##0.##"/></th>
	                <!-- entire11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_11_5}" pattern="#,##0.##"/></th>
	                <!-- entire10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_10_5}" pattern="#,##0.##"/></th>
	                <!-- entire09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_09_5}" pattern="#,##0.##"/></th>
	                <!-- entire08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_08_5}" pattern="#,##0.##"/></th>
	                <!-- entire07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_07_5}" pattern="#,##0.##"/></th>
	                <!-- entire06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_06_5}" pattern="#,##0.##"/></th>
	                <!-- entire05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_05_5}" pattern="#,##0.##"/></th>
	                <!-- entire04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_04_5}" pattern="#,##0.##"/></th>
	                <!-- entire03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_03_5}" pattern="#,##0.##"/></th>
	                <!-- entire02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_02_5}" pattern="#,##0.##"/></th>
	                <!-- entire01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_01_5}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="entireColTotalSum_5" value="${entireTeamTotalSum_12_5 + entireTeamTotalSum_11_5 + entireTeamTotalSum_10_5 + entireTeamTotalSum_09_5 + entireTeamTotalSum_08_5 + entireTeamTotalSum_07_5 + entireTeamTotalSum_06_5 + entireTeamTotalSum_05_5 + entireTeamTotalSum_04_5 + entireTeamTotalSum_03_5 + entireTeamTotalSum_02_5 + entireTeamTotalSum_01_5}"></c:set>
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireColTotalSum_5}" pattern="#,##0.##"/></th>	                
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
	            <c:set var="entireTeamSum_12_10" value="0"></c:set>
	            <c:set var="entireTeamSum_11_10" value="0"></c:set>
	            <c:set var="entireTeamSum_10_10" value="0"></c:set>
	            <c:set var="entireTeamSum_09_10" value="0"></c:set>
	            <c:set var="entireTeamSum_08_10" value="0"></c:set>
	            <c:set var="entireTeamSum_07_10" value="0"></c:set>
	            <c:set var="entireTeamSum_06_10" value="0"></c:set>
	            <c:set var="entireTeamSum_05_10" value="0"></c:set>
	            <c:set var="entireTeamSum_04_10" value="0"></c:set>
	            <c:set var="entireTeamSum_03_10" value="0"></c:set>
	            <c:set var="entireTeamSum_02_10" value="0"></c:set>
	            <c:set var="entireTeamSum_01_10" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="entireTeamTotalSum_12_10" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_11_10" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_10_10" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_09_10" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_08_10" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_07_10" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_06_10" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_05_10" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_04_10" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_03_10" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_02_10" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_01_10" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="entireColTeamTotalSum_10" value="0"></c:set>
   				    			
    			<c:forEach var="vo1" items="${ptnrStatEntireList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCenterEntire');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
		                    	1종 심사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo1.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatMember(${vo1.ptnrId},${vo1.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.teamName}</td>
		                		<td style="width:150px;">${vo1.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="entireTeamSum_12_10" value="0"></c:set>
					            <c:set var="entireTeamSum_11_10" value="0"></c:set>
					            <c:set var="entireTeamSum_10_10" value="0"></c:set>
					            <c:set var="entireTeamSum_09_10" value="0"></c:set>
					            <c:set var="entireTeamSum_08_10" value="0"></c:set>
					            <c:set var="entireTeamSum_07_10" value="0"></c:set>
					            <c:set var="entireTeamSum_06_10" value="0"></c:set>
					            <c:set var="entireTeamSum_05_10" value="0"></c:set>
					            <c:set var="entireTeamSum_04_10" value="0"></c:set>
					            <c:set var="entireTeamSum_03_10" value="0"></c:set>
					            <c:set var="entireTeamSum_02_10" value="0"></c:set>
					            <c:set var="entireTeamSum_01_10" value="0"></c:set>
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
			    		<c:set var="entire12_10" value="${vo1.entire12}"></c:set>
			            <c:set var="entire11_10" value="${vo1.entire11}"></c:set>
			            <c:set var="entire10_10" value="${vo1.entire10}"></c:set>
			            <c:set var="entire09_10" value="${vo1.entire09}"></c:set>
			            <c:set var="entire08_10" value="${vo1.entire08}"></c:set>
			            <c:set var="entire07_10" value="${vo1.entire07}"></c:set>
			            <c:set var="entire06_10" value="${vo1.entire06}"></c:set>
			            <c:set var="entire05_10" value="${vo1.entire05}"></c:set>
			            <c:set var="entire04_10" value="${vo1.entire04}"></c:set>
			            <c:set var="entire03_10" value="${vo1.entire03}"></c:set>
			            <c:set var="entire02_10" value="${vo1.entire02}"></c:set>
			            <c:set var="entire01_10" value="${vo1.entire01}"></c:set>
			            
			            <!-- entire12 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${entire12_10}" pattern="#,##0.##"/></td>
	                    <!-- entire11 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire11_10}" pattern="#,##0.##"/></td>
	                    <!-- entire10 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire10_10}" pattern="#,##0.##"/></td>
	                    <!-- entire09 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire09_10}" pattern="#,##0.##"/></td>
	                    <!-- entire08 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire08_10}" pattern="#,##0.##"/></td>
	                    <!-- entire07 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire07_10}" pattern="#,##0.##"/></td>
	                    <!-- entire06 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire06_10}" pattern="#,##0.##"/></td>
	                    <!-- entire05 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire05_10}" pattern="#,##0.##"/></td>
	                    <!-- entire04 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire04_10}" pattern="#,##0.##"/></td>
	                    <!-- entire03 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire03_10}" pattern="#,##0.##"/></td>
	                    <!-- entire02 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire02_10}" pattern="#,##0.##"/></td>
	                    <!-- entire01 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire01_10}" pattern="#,##0.##"/></td>
	                    <!-- 가로 합계 -->
	                    <c:set var="entireColSum_10" value="${entire12_10 + entire11_10 + entire10_10 + entire09_10 + entire08_10 + entire07_10 + entire06_10 + entire05_10 + entire04_10 + entire03_10 + entire02_10 + entire01_10}"></c:set>                    
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireColSum_10}" pattern="#,##0.##"/></td>
		                
		                <!-- 팀별 계 합산 -->
	    				<c:set var="entireTeamSum_12_10" value="${entireTeamSum_12_10+entire12_10}"></c:set>
			            <c:set var="entireTeamSum_11_10" value="${entireTeamSum_11_10+entire11_10}"></c:set>
			            <c:set var="entireTeamSum_10_10" value="${entireTeamSum_10_10+entire10_10}"></c:set>
			            <c:set var="entireTeamSum_09_10" value="${entireTeamSum_09_10+entire09_10}"></c:set>
			            <c:set var="entireTeamSum_08_10" value="${entireTeamSum_08_10+entire08_10}"></c:set>
			            <c:set var="entireTeamSum_07_10" value="${entireTeamSum_07_10+entire07_10}"></c:set>
			            <c:set var="entireTeamSum_06_10" value="${entireTeamSum_06_10+entire06_10}"></c:set>
			            <c:set var="entireTeamSum_05_10" value="${entireTeamSum_05_10+entire05_10}"></c:set>
			            <c:set var="entireTeamSum_04_10" value="${entireTeamSum_04_10+entire04_10}"></c:set>
			            <c:set var="entireTeamSum_03_10" value="${entireTeamSum_03_10+entire03_10}"></c:set>
			            <c:set var="entireTeamSum_02_10" value="${entireTeamSum_02_10+entire02_10}"></c:set>
			            <c:set var="entireTeamSum_01_10" value="${entireTeamSum_01_10+entire01_10}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="entireTeamTotalSum_12_10" value="${entireTeamTotalSum_12_10 + entire12_10}"></c:set>
	                    <c:set var="entireTeamTotalSum_11_10" value="${entireTeamTotalSum_11_10 + entire11_10}"></c:set>
	                    <c:set var="entireTeamTotalSum_10_10" value="${entireTeamTotalSum_10_10 + entire10_10}"></c:set>
	                    <c:set var="entireTeamTotalSum_09_10" value="${entireTeamTotalSum_09_10 + entire09_10}"></c:set>
	                    <c:set var="entireTeamTotalSum_08_10" value="${entireTeamTotalSum_08_10 + entire08_10}"></c:set>
	                    <c:set var="entireTeamTotalSum_07_10" value="${entireTeamTotalSum_07_10 + entire07_10}"></c:set>
	                    <c:set var="entireTeamTotalSum_06_10" value="${entireTeamTotalSum_06_10 + entire06_10}"></c:set>
	                    <c:set var="entireTeamTotalSum_05_10" value="${entireTeamTotalSum_05_10 + entire05_10}"></c:set>
	                    <c:set var="entireTeamTotalSum_04_10" value="${entireTeamTotalSum_04_10 + entire04_10}"></c:set>
	                    <c:set var="entireTeamTotalSum_03_10" value="${entireTeamTotalSum_03_10 + entire03_10}"></c:set>
	                    <c:set var="entireTeamTotalSum_02_10" value="${entireTeamTotalSum_02_10 + entire02_10}"></c:set>
	                    <c:set var="entireTeamTotalSum_01_10" value="${entireTeamTotalSum_01_10 + entire01_10}"></c:set>
		    		</tr>
		    		<!-- 팀별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo1.rowCnt and vo1.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- entire12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_12_10}" pattern="#,##0.##"/></td>
			                <!-- entire11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_11_10}" pattern="#,##0.##"/></td>
			                <!-- entire10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_10_10}" pattern="#,##0.##"/></td>
			                <!-- entire09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_09_10}" pattern="#,##0.##"/></td>
			                <!-- entire08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_08_10}" pattern="#,##0.##"/></td>
			                <!-- entire07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_07_10}" pattern="#,##0.##"/></td>
			                <!-- entire06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_06_10}" pattern="#,##0.##"/></td>
			                <!-- entire05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_05_10}" pattern="#,##0.##"/></td>
			                <!-- entire04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_04_10}" pattern="#,##0.##"/></td>
			                <!-- entire03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_03_10}" pattern="#,##0.##"/></td>
			                <!-- entire02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_02_10}" pattern="#,##0.##"/></td>
			                <!-- entire01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_01_10}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="entireTeamColSum_10" value="${entireTeamSum_12_10 + entireTeamSum_11_10 + entireTeamSum_10_10 + entireTeamSum_09_10 + entireTeamSum_08_10 + entireTeamSum_07_10 + entireTeamSum_06_10 + entireTeamSum_05_10 + entireTeamSum_04_10 + entireTeamSum_03_10 + entireTeamSum_02_10 + entireTeamSum_01_10}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamColSum_10}" pattern="#,##0.##"/></td>
			                
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="entireTeamSum_12_10" value="0"></c:set>
				            <c:set var="entireTeamSum_11_10" value="0"></c:set>
				            <c:set var="entireTeamSum_10_10" value="0"></c:set>
				            <c:set var="entireTeamSum_09_10" value="0"></c:set>
				            <c:set var="entireTeamSum_08_10" value="0"></c:set>
				            <c:set var="entireTeamSum_07_10" value="0"></c:set>
				            <c:set var="entireTeamSum_06_10" value="0"></c:set>
				            <c:set var="entireTeamSum_05_10" value="0"></c:set>
				            <c:set var="entireTeamSum_04_10" value="0"></c:set>
				            <c:set var="entireTeamSum_03_10" value="0"></c:set>
				            <c:set var="entireTeamSum_02_10" value="0"></c:set>
				            <c:set var="entireTeamSum_01_10" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo1.rowCnt == 1}">
		    				<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="entireTeamSum_12_10" value="0"></c:set>
				            <c:set var="entireTeamSum_11_10" value="0"></c:set>
				            <c:set var="entireTeamSum_10_10" value="0"></c:set>
				            <c:set var="entireTeamSum_09_10" value="0"></c:set>
				            <c:set var="entireTeamSum_08_10" value="0"></c:set>
				            <c:set var="entireTeamSum_07_10" value="0"></c:set>
				            <c:set var="entireTeamSum_06_10" value="0"></c:set>
				            <c:set var="entireTeamSum_05_10" value="0"></c:set>
				            <c:set var="entireTeamSum_04_10" value="0"></c:set>
				            <c:set var="entireTeamSum_03_10" value="0"></c:set>
				            <c:set var="entireTeamSum_02_10" value="0"></c:set>
				            <c:set var="entireTeamSum_01_10" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 팀별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 팀별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 심사 소계 시작 -->
		    	<c:if test="${ptnrStatEntireList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 심사 소계</th>
	                <!-- entire12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_12_10}" pattern="#,##0.##"/></th>
	                <!-- entire11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_11_10}" pattern="#,##0.##"/></th>
	                <!-- entire10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_10_10}" pattern="#,##0.##"/></th>
	                <!-- entire09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_09_10}" pattern="#,##0.##"/></th>
	                <!-- entire08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_08_10}" pattern="#,##0.##"/></th>
	                <!-- entire07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_07_10}" pattern="#,##0.##"/></th>
	                <!-- entire06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_06_10}" pattern="#,##0.##"/></th>
	                <!-- entire05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_05_10}" pattern="#,##0.##"/></th>
	                <!-- entire04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_04_10}" pattern="#,##0.##"/></th>
	                <!-- entire03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_03_10}" pattern="#,##0.##"/></th>
	                <!-- entire02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_02_10}" pattern="#,##0.##"/></th>
	                <!-- entire01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_01_10}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="entireColTotalSum_10" value="${entireTeamTotalSum_12_10 + entireTeamTotalSum_11_10 + entireTeamTotalSum_10_10 + entireTeamTotalSum_09_10 + entireTeamTotalSum_08_10 + entireTeamTotalSum_07_10 + entireTeamTotalSum_06_10 + entireTeamTotalSum_05_10 + entireTeamTotalSum_04_10 + entireTeamTotalSum_03_10 + entireTeamTotalSum_02_10 + entireTeamTotalSum_01_10}"></c:set>
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireColTotalSum_10}" pattern="#,##0.##"/></th>	                
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
	            <c:set var="entireTeamSum_12_15" value="0"></c:set>
	            <c:set var="entireTeamSum_11_15" value="0"></c:set>
	            <c:set var="entireTeamSum_10_15" value="0"></c:set>
	            <c:set var="entireTeamSum_09_15" value="0"></c:set>
	            <c:set var="entireTeamSum_08_15" value="0"></c:set>
	            <c:set var="entireTeamSum_07_15" value="0"></c:set>
	            <c:set var="entireTeamSum_06_15" value="0"></c:set>
	            <c:set var="entireTeamSum_05_15" value="0"></c:set>
	            <c:set var="entireTeamSum_04_15" value="0"></c:set>
	            <c:set var="entireTeamSum_03_15" value="0"></c:set>
	            <c:set var="entireTeamSum_02_15" value="0"></c:set>
	            <c:set var="entireTeamSum_01_15" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="entireTeamTotalSum_12_15" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_11_15" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_10_15" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_09_15" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_08_15" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_07_15" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_06_15" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_05_15" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_04_15" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_03_15" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_02_15" value="0"></c:set>
	            <c:set var="entireTeamTotalSum_01_15" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="entireColTeamTotalSum_15" value="0"></c:set>
   				    			
    			<c:forEach var="vo2" items="${ptnrStatEntireList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCenterEntire');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
		                    	1종 기타
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo2.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatMember(${vo2.ptnrId},${vo2.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.teamName}</td>
		                		<td style="width:150px;">${vo2.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="entireTeamSum_12_15" value="0"></c:set>
					            <c:set var="entireTeamSum_11_15" value="0"></c:set>
					            <c:set var="entireTeamSum_10_15" value="0"></c:set>
					            <c:set var="entireTeamSum_09_15" value="0"></c:set>
					            <c:set var="entireTeamSum_08_15" value="0"></c:set>
					            <c:set var="entireTeamSum_07_15" value="0"></c:set>
					            <c:set var="entireTeamSum_06_15" value="0"></c:set>
					            <c:set var="entireTeamSum_05_15" value="0"></c:set>
					            <c:set var="entireTeamSum_04_15" value="0"></c:set>
					            <c:set var="entireTeamSum_03_15" value="0"></c:set>
					            <c:set var="entireTeamSum_02_15" value="0"></c:set>
					            <c:set var="entireTeamSum_01_15" value="0"></c:set>
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
			    		<c:set var="entire12_15" value="${vo2.entire12}"></c:set>
			            <c:set var="entire11_15" value="${vo2.entire11}"></c:set>
			            <c:set var="entire10_15" value="${vo2.entire10}"></c:set>
			            <c:set var="entire09_15" value="${vo2.entire09}"></c:set>
			            <c:set var="entire08_15" value="${vo2.entire08}"></c:set>
			            <c:set var="entire07_15" value="${vo2.entire07}"></c:set>
			            <c:set var="entire06_15" value="${vo2.entire06}"></c:set>
			            <c:set var="entire05_15" value="${vo2.entire05}"></c:set>
			            <c:set var="entire04_15" value="${vo2.entire04}"></c:set>
			            <c:set var="entire03_15" value="${vo2.entire03}"></c:set>
			            <c:set var="entire02_15" value="${vo2.entire02}"></c:set>
			            <c:set var="entire01_15" value="${vo2.entire01}"></c:set>
			            
			            <!-- entire12 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${entire12_15}" pattern="#,##0.##"/></td>
	                    <!-- entire11 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire11_15}" pattern="#,##0.##"/></td>
	                    <!-- entire10 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire10_15}" pattern="#,##0.##"/></td>
	                    <!-- entire09 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire09_15}" pattern="#,##0.##"/></td>
	                    <!-- entire08 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire08_15}" pattern="#,##0.##"/></td>
	                    <!-- entire07 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire07_15}" pattern="#,##0.##"/></td>
	                    <!-- entire06 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire06_15}" pattern="#,##0.##"/></td>
	                    <!-- entire05 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire05_15}" pattern="#,##0.##"/></td>
	                    <!-- entire04 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire04_15}" pattern="#,##0.##"/></td>
	                    <!-- entire03 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire03_15}" pattern="#,##0.##"/></td>
	                    <!-- entire02 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire02_15}" pattern="#,##0.##"/></td>
	                    <!-- entire01 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entire01_15}" pattern="#,##0.##"/></td>
	                    <!-- 가로 합계 -->
	                    <c:set var="entireColSum_15" value="${entire12_15 + entire11_15 + entire10_15 + entire09_15 + entire08_15 + entire07_15 + entire06_15 + entire05_15 + entire04_15 + entire03_15 + entire02_15 + entire01_15}"></c:set>                    
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireColSum_15}" pattern="#,##0.##"/></td>
		                
		                <!-- 팀별 계 합산 -->
	    				<c:set var="entireTeamSum_12_15" value="${entireTeamSum_12_15+entire12_15}"></c:set>
			            <c:set var="entireTeamSum_11_15" value="${entireTeamSum_11_15+entire11_15}"></c:set>
			            <c:set var="entireTeamSum_10_15" value="${entireTeamSum_10_15+entire10_15}"></c:set>
			            <c:set var="entireTeamSum_09_15" value="${entireTeamSum_09_15+entire09_15}"></c:set>
			            <c:set var="entireTeamSum_08_15" value="${entireTeamSum_08_15+entire08_15}"></c:set>
			            <c:set var="entireTeamSum_07_15" value="${entireTeamSum_07_15+entire07_15}"></c:set>
			            <c:set var="entireTeamSum_06_15" value="${entireTeamSum_06_15+entire06_15}"></c:set>
			            <c:set var="entireTeamSum_05_15" value="${entireTeamSum_05_15+entire05_15}"></c:set>
			            <c:set var="entireTeamSum_04_15" value="${entireTeamSum_04_15+entire04_15}"></c:set>
			            <c:set var="entireTeamSum_03_15" value="${entireTeamSum_03_15+entire03_15}"></c:set>
			            <c:set var="entireTeamSum_02_15" value="${entireTeamSum_02_15+entire02_15}"></c:set>
			            <c:set var="entireTeamSum_01_15" value="${entireTeamSum_01_15+entire01_15}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="entireTeamTotalSum_12_15" value="${entireTeamTotalSum_12_15 + entire12_15}"></c:set>
	                    <c:set var="entireTeamTotalSum_11_15" value="${entireTeamTotalSum_11_15 + entire11_15}"></c:set>
	                    <c:set var="entireTeamTotalSum_10_15" value="${entireTeamTotalSum_10_15 + entire10_15}"></c:set>
	                    <c:set var="entireTeamTotalSum_09_15" value="${entireTeamTotalSum_09_15 + entire09_15}"></c:set>
	                    <c:set var="entireTeamTotalSum_08_15" value="${entireTeamTotalSum_08_15 + entire08_15}"></c:set>
	                    <c:set var="entireTeamTotalSum_07_15" value="${entireTeamTotalSum_07_15 + entire07_15}"></c:set>
	                    <c:set var="entireTeamTotalSum_06_15" value="${entireTeamTotalSum_06_15 + entire06_15}"></c:set>
	                    <c:set var="entireTeamTotalSum_05_15" value="${entireTeamTotalSum_05_15 + entire05_15}"></c:set>
	                    <c:set var="entireTeamTotalSum_04_15" value="${entireTeamTotalSum_04_15 + entire04_15}"></c:set>
	                    <c:set var="entireTeamTotalSum_03_15" value="${entireTeamTotalSum_03_15 + entire03_15}"></c:set>
	                    <c:set var="entireTeamTotalSum_02_15" value="${entireTeamTotalSum_02_15 + entire02_15}"></c:set>
	                    <c:set var="entireTeamTotalSum_01_15" value="${entireTeamTotalSum_01_15 + entire01_15}"></c:set>
		    		</tr>
		    		<!-- 팀별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo2.rowCnt and vo2.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- entire12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_12_15}" pattern="#,##0.##"/></td>
			                <!-- entire11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_11_15}" pattern="#,##0.##"/></td>
			                <!-- entire10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_10_15}" pattern="#,##0.##"/></td>
			                <!-- entire09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_09_15}" pattern="#,##0.##"/></td>
			                <!-- entire08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_08_15}" pattern="#,##0.##"/></td>
			                <!-- entire07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_07_15}" pattern="#,##0.##"/></td>
			                <!-- entire06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_06_15}" pattern="#,##0.##"/></td>
			                <!-- entire05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_05_15}" pattern="#,##0.##"/></td>
			                <!-- entire04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_04_15}" pattern="#,##0.##"/></td>
			                <!-- entire03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_03_15}" pattern="#,##0.##"/></td>
			                <!-- entire02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_02_15}" pattern="#,##0.##"/></td>
			                <!-- entire01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamSum_01_15}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="entireTeamColSum_15" value="${entireTeamSum_12_15 + entireTeamSum_11_15 + entireTeamSum_10_15 + entireTeamSum_09_15 + entireTeamSum_08_15 + entireTeamSum_07_15 + entireTeamSum_06_15 + entireTeamSum_05_15 + entireTeamSum_04_15 + entireTeamSum_03_15 + entireTeamSum_02_15 + entireTeamSum_01_15}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${entireTeamColSum_15}" pattern="#,##0.##"/></td>
			                
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="entireTeamSum_12_15" value="0"></c:set>
				            <c:set var="entireTeamSum_11_15" value="0"></c:set>
				            <c:set var="entireTeamSum_10_15" value="0"></c:set>
				            <c:set var="entireTeamSum_09_15" value="0"></c:set>
				            <c:set var="entireTeamSum_08_15" value="0"></c:set>
				            <c:set var="entireTeamSum_07_15" value="0"></c:set>
				            <c:set var="entireTeamSum_06_15" value="0"></c:set>
				            <c:set var="entireTeamSum_05_15" value="0"></c:set>
				            <c:set var="entireTeamSum_04_15" value="0"></c:set>
				            <c:set var="entireTeamSum_03_15" value="0"></c:set>
				            <c:set var="entireTeamSum_02_15" value="0"></c:set>
				            <c:set var="entireTeamSum_01_15" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo2.rowCnt == 1}">
		    				<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="entireTeamSum_12_15" value="0"></c:set>
				            <c:set var="entireTeamSum_11_15" value="0"></c:set>
				            <c:set var="entireTeamSum_10_15" value="0"></c:set>
				            <c:set var="entireTeamSum_09_15" value="0"></c:set>
				            <c:set var="entireTeamSum_08_15" value="0"></c:set>
				            <c:set var="entireTeamSum_07_15" value="0"></c:set>
				            <c:set var="entireTeamSum_06_15" value="0"></c:set>
				            <c:set var="entireTeamSum_05_15" value="0"></c:set>
				            <c:set var="entireTeamSum_04_15" value="0"></c:set>
				            <c:set var="entireTeamSum_03_15" value="0"></c:set>
				            <c:set var="entireTeamSum_02_15" value="0"></c:set>
				            <c:set var="entireTeamSum_01_15" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 팀별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 팀별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 기타 소계 시작 -->
		    	<c:if test="${ptnrStatEntireList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 기타 소계</th>
	                <!-- entire12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_12_15}" pattern="#,##0.##"/></th>
	                <!-- entire11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_11_15}" pattern="#,##0.##"/></th>
	                <!-- entire10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_10_15}" pattern="#,##0.##"/></th>
	                <!-- entire09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_09_15}" pattern="#,##0.##"/></th>
	                <!-- entire08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_08_15}" pattern="#,##0.##"/></th>
	                <!-- entire07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_07_15}" pattern="#,##0.##"/></th>
	                <!-- entire06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_06_15}" pattern="#,##0.##"/></th>
	                <!-- entire05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_05_15}" pattern="#,##0.##"/></th>
	                <!-- entire04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_04_15}" pattern="#,##0.##"/></th>
	                <!-- entire03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_03_15}" pattern="#,##0.##"/></th>
	                <!-- entire02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_02_15}" pattern="#,##0.##"/></th>
	                <!-- entire01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireTeamTotalSum_01_15}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="entireColTotalSum_15" value="${entireTeamTotalSum_12_15 + entireTeamTotalSum_11_15 + entireTeamTotalSum_10_15 + entireTeamTotalSum_09_15 + entireTeamTotalSum_08_15 + entireTeamTotalSum_07_15 + entireTeamTotalSum_06_15 + entireTeamTotalSum_05_15 + entireTeamTotalSum_04_15 + entireTeamTotalSum_03_15 + entireTeamTotalSum_02_15 + entireTeamTotalSum_01_15}"></c:set>
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${entireColTotalSum_15}" pattern="#,##0.##"/></th>	                
	            </tr>
	            </c:if>
		    	<!-- 1종 기타 소계 끝 -->
    		</tbody>
    	</table>
    	<!-- 1종 기타 끝 -->  	        
    </div>    
    <!-- 총 합계 시작 -->
    <!-- 총 합계 변수 시작 -->
    <c:set var="entireTeamTotalSum_12_all" value="${entireTeamTotalSum_12_5 + entireTeamTotalSum_12_10 + entireTeamTotalSum_12_15}"></c:set>
    <c:set var="entireTeamTotalSum_11_all" value="${entireTeamTotalSum_11_5 + entireTeamTotalSum_11_10 + entireTeamTotalSum_11_15}"></c:set>
    <c:set var="entireTeamTotalSum_10_all" value="${entireTeamTotalSum_10_5 + entireTeamTotalSum_10_10 + entireTeamTotalSum_10_15}"></c:set>
    <c:set var="entireTeamTotalSum_09_all" value="${entireTeamTotalSum_09_5 + entireTeamTotalSum_09_10 + entireTeamTotalSum_09_15}"></c:set>
    <c:set var="entireTeamTotalSum_08_all" value="${entireTeamTotalSum_08_5 + entireTeamTotalSum_08_10 + entireTeamTotalSum_08_15}"></c:set>
    <c:set var="entireTeamTotalSum_07_all" value="${entireTeamTotalSum_07_5 + entireTeamTotalSum_07_10 + entireTeamTotalSum_07_15}"></c:set>
    <c:set var="entireTeamTotalSum_06_all" value="${entireTeamTotalSum_06_5 + entireTeamTotalSum_06_10 + entireTeamTotalSum_06_15}"></c:set>
    <c:set var="entireTeamTotalSum_05_all" value="${entireTeamTotalSum_05_5 + entireTeamTotalSum_05_10 + entireTeamTotalSum_05_15}"></c:set>
    <c:set var="entireTeamTotalSum_04_all" value="${entireTeamTotalSum_04_5 + entireTeamTotalSum_04_10 + entireTeamTotalSum_04_15}"></c:set>
    <c:set var="entireTeamTotalSum_03_all" value="${entireTeamTotalSum_03_5 + entireTeamTotalSum_03_10 + entireTeamTotalSum_03_15}"></c:set>
    <c:set var="entireTeamTotalSum_02_all" value="${entireTeamTotalSum_02_5 + entireTeamTotalSum_02_10 + entireTeamTotalSum_02_15}"></c:set>
    <c:set var="entireTeamTotalSum_01_all" value="${entireTeamTotalSum_01_5 + entireTeamTotalSum_01_10 + entireTeamTotalSum_01_15}"></c:set>        
    <c:set var="entireTeamTotalSum_col_all" value="${entireTeamTotalSum_12_all + entireTeamTotalSum_11_all + entireTeamTotalSum_10_all + entireTeamTotalSum_09_all + entireTeamTotalSum_08_all + entireTeamTotalSum_07_all + entireTeamTotalSum_06_all + entireTeamTotalSum_05_all + entireTeamTotalSum_04_all + entireTeamTotalSum_03_all + entireTeamTotalSum_02_all + entireTeamTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체합계</th>    			
    			<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTeamTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTeamTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTeamTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTeamTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTeamTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTeamTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTeamTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTeamTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTeamTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTeamTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTeamTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTeamTotalSum_01_all}" pattern="#,##0.##"/></th>
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${entireTeamTotalSum_col_all}" pattern="#,##0.##"/></th>    			
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>