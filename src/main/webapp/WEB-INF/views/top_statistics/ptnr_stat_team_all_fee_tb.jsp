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
   				<!-- 센터별 계를 만들기 위한 변수 -->
   				<c:set var="teamAllCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 센터명 -->
   				<c:set var="preteamName" value=""></c:set>
   				
   				<!-- 센터별 계 -->
	            <c:set var="feeTeamAllSum_12_5" value="0"></c:set>
	            <c:set var="feeTeamAllSum_11_5" value="0"></c:set>
	            <c:set var="feeTeamAllSum_10_5" value="0"></c:set>
	            <c:set var="feeTeamAllSum_09_5" value="0"></c:set>
	            <c:set var="feeTeamAllSum_08_5" value="0"></c:set>
	            <c:set var="feeTeamAllSum_07_5" value="0"></c:set>
	            <c:set var="feeTeamAllSum_06_5" value="0"></c:set>
	            <c:set var="feeTeamAllSum_05_5" value="0"></c:set>
	            <c:set var="feeTeamAllSum_04_5" value="0"></c:set>
	            <c:set var="feeTeamAllSum_03_5" value="0"></c:set>
	            <c:set var="feeTeamAllSum_02_5" value="0"></c:set>
	            <c:set var="feeTeamAllSum_01_5" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="feeTeamAllTotalSum_12_5" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_11_5" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_10_5" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_09_5" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_08_5" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_07_5" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_06_5" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_05_5" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_04_5" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_03_5" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_02_5" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_01_5" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="feeColTeamAllTotalSum_5" value="0"></c:set>
   				    			
    			<c:forEach var="vo" items="${ptnrStatTeamAllFeeList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowTeamAll}">
		                    	1종 조사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo.rowCnt == 1}">
		                		<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>		                				                		
		                		<td onclick="goPtnrStatMember(${vo.ptnrId},${vo.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.teamName}</td>
		                		<td style="width:150px;">${vo.ptnrIdSubNm}</td>
		                		<!-- 센터별 계 초기화 -->
					            <c:set var="feeTeamAllSum_12_5" value="0"></c:set>
					            <c:set var="feeTeamAllSum_11_5" value="0"></c:set>
					            <c:set var="feeTeamAllSum_10_5" value="0"></c:set>
					            <c:set var="feeTeamAllSum_09_5" value="0"></c:set>
					            <c:set var="feeTeamAllSum_08_5" value="0"></c:set>
					            <c:set var="feeTeamAllSum_07_5" value="0"></c:set>
					            <c:set var="feeTeamAllSum_06_5" value="0"></c:set>
					            <c:set var="feeTeamAllSum_05_5" value="0"></c:set>
					            <c:set var="feeTeamAllSum_04_5" value="0"></c:set>
					            <c:set var="feeTeamAllSum_03_5" value="0"></c:set>
					            <c:set var="feeTeamAllSum_02_5" value="0"></c:set>
					            <c:set var="feeTeamAllSum_01_5" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${teamAllCnt == 1 and vo.teamName != preteamName}">
		                				<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>
		                				<td onclick="goPtnrStatMember(${vo.ptnrId},${vo.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${vo.rowCnt+1}">${vo.teamName}</td>
		                				<td style="width:150px;">${vo.ptnrIdSubNm}</td>		                				
		                				<c:set var="preteamName" value="${vo.teamName}"></c:set>
		                			</c:when>
		                			<c:otherwise>
		                				<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>		                				
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
	    				<c:set var="feeTeamAllSum_12_5" value="${feeTeamAllSum_12_5+fee12_5}"></c:set>
			            <c:set var="feeTeamAllSum_11_5" value="${feeTeamAllSum_11_5+fee11_5}"></c:set>
			            <c:set var="feeTeamAllSum_10_5" value="${feeTeamAllSum_10_5+fee10_5}"></c:set>
			            <c:set var="feeTeamAllSum_09_5" value="${feeTeamAllSum_09_5+fee09_5}"></c:set>
			            <c:set var="feeTeamAllSum_08_5" value="${feeTeamAllSum_08_5+fee08_5}"></c:set>
			            <c:set var="feeTeamAllSum_07_5" value="${feeTeamAllSum_07_5+fee07_5}"></c:set>
			            <c:set var="feeTeamAllSum_06_5" value="${feeTeamAllSum_06_5+fee06_5}"></c:set>
			            <c:set var="feeTeamAllSum_05_5" value="${feeTeamAllSum_05_5+fee05_5}"></c:set>
			            <c:set var="feeTeamAllSum_04_5" value="${feeTeamAllSum_04_5+fee04_5}"></c:set>
			            <c:set var="feeTeamAllSum_03_5" value="${feeTeamAllSum_03_5+fee03_5}"></c:set>
			            <c:set var="feeTeamAllSum_02_5" value="${feeTeamAllSum_02_5+fee02_5}"></c:set>
			            <c:set var="feeTeamAllSum_01_5" value="${feeTeamAllSum_01_5+fee01_5}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="feeTeamAllTotalSum_12_5" value="${feeTeamAllTotalSum_12_5 + fee12_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_11_5" value="${feeTeamAllTotalSum_11_5 + fee11_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_10_5" value="${feeTeamAllTotalSum_10_5 + fee10_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_09_5" value="${feeTeamAllTotalSum_09_5 + fee09_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_08_5" value="${feeTeamAllTotalSum_08_5 + fee08_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_07_5" value="${feeTeamAllTotalSum_07_5 + fee07_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_06_5" value="${feeTeamAllTotalSum_06_5 + fee06_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_05_5" value="${feeTeamAllTotalSum_05_5 + fee05_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_04_5" value="${feeTeamAllTotalSum_04_5 + fee04_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_03_5" value="${feeTeamAllTotalSum_03_5 + fee03_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_02_5" value="${feeTeamAllTotalSum_02_5 + fee02_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_01_5" value="${feeTeamAllTotalSum_01_5 + fee01_5}"></c:set>
		    		</tr>
		    		<!-- 센터별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamAllCnt == vo.rowCnt and vo.rowCnt > 1}">
		    				<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- fee12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_12_5}" pattern="#,##0.##"/></td>
			                <!-- fee11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_11_5}" pattern="#,##0.##"/></td>
			                <!-- fee10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_10_5}" pattern="#,##0.##"/></td>
			                <!-- fee09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_09_5}" pattern="#,##0.##"/></td>
			                <!-- fee08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_08_5}" pattern="#,##0.##"/></td>
			                <!-- fee07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_07_5}" pattern="#,##0.##"/></td>
			                <!-- fee06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_06_5}" pattern="#,##0.##"/></td>
			                <!-- fee05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_05_5}" pattern="#,##0.##"/></td>
			                <!-- fee04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_04_5}" pattern="#,##0.##"/></td>
			                <!-- fee03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_03_5}" pattern="#,##0.##"/></td>
			                <!-- fee02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_02_5}" pattern="#,##0.##"/></td>
			                <!-- fee01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_01_5}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="feeTeamAllColSum_5" value="${feeTeamAllSum_12_5 + feeTeamAllSum_11_5 + feeTeamAllSum_10_5 + feeTeamAllSum_09_5 + feeTeamAllSum_08_5 + feeTeamAllSum_07_5 + feeTeamAllSum_06_5 + feeTeamAllSum_05_5 + feeTeamAllSum_04_5 + feeTeamAllSum_03_5 + feeTeamAllSum_02_5 + feeTeamAllSum_01_5}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllColSum_5}" pattern="#,##0.##"/></td>
			                
							<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="teamAllCnt" value="1"></c:set>										                		    				
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="feeTeamAllSum_12_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_11_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_10_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_09_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_08_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_07_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_06_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_05_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_04_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_03_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_02_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_01_5" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo.rowCnt == 1}">
		    				<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="teamAllCnt" value="1"></c:set>
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="feeTeamAllSum_12_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_11_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_10_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_09_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_08_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_07_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_06_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_05_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_04_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_03_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_02_5" value="0"></c:set>
				            <c:set var="feeTeamAllSum_01_5" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 센터별 계 카운트 증가 -->
		    				<c:set var="teamAllCnt" value="${teamAllCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 센터별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 조사 소계 시작 -->
		    	<c:if test="${ptnrStatTeamAllFeeList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="4" style="height:25px;">1종 조사 소계</th>
	                <!-- fee12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_12_5}" pattern="#,##0.##"/></th>
	                <!-- fee11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_11_5}" pattern="#,##0.##"/></th>
	                <!-- fee10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_10_5}" pattern="#,##0.##"/></th>
	                <!-- fee09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_09_5}" pattern="#,##0.##"/></th>
	                <!-- fee08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_08_5}" pattern="#,##0.##"/></th>
	                <!-- fee07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_07_5}" pattern="#,##0.##"/></th>
	                <!-- fee06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_06_5}" pattern="#,##0.##"/></th>
	                <!-- fee05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_05_5}" pattern="#,##0.##"/></th>
	                <!-- fee04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_04_5}" pattern="#,##0.##"/></th>
	                <!-- fee03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_03_5}" pattern="#,##0.##"/></th>
	                <!-- fee02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_02_5}" pattern="#,##0.##"/></th>
	                <!-- fee01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_01_5}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="feeColTotalSum_5" value="${feeTeamAllTotalSum_12_5 + feeTeamAllTotalSum_11_5 + feeTeamAllTotalSum_10_5 + feeTeamAllTotalSum_09_5 + feeTeamAllTotalSum_08_5 + feeTeamAllTotalSum_07_5 + feeTeamAllTotalSum_06_5 + feeTeamAllTotalSum_05_5 + feeTeamAllTotalSum_04_5 + feeTeamAllTotalSum_03_5 + feeTeamAllTotalSum_02_5 + feeTeamAllTotalSum_01_5}"></c:set>
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
   				<c:set var="teamAllCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 센터명 -->
   				<c:set var="preteamName" value=""></c:set>
   				
   				<!-- 센터별 계 -->
	            <c:set var="feeTeamAllSum_12_10" value="0"></c:set>
	            <c:set var="feeTeamAllSum_11_10" value="0"></c:set>
	            <c:set var="feeTeamAllSum_10_10" value="0"></c:set>
	            <c:set var="feeTeamAllSum_09_10" value="0"></c:set>
	            <c:set var="feeTeamAllSum_08_10" value="0"></c:set>
	            <c:set var="feeTeamAllSum_07_10" value="0"></c:set>
	            <c:set var="feeTeamAllSum_06_10" value="0"></c:set>
	            <c:set var="feeTeamAllSum_05_10" value="0"></c:set>
	            <c:set var="feeTeamAllSum_04_10" value="0"></c:set>
	            <c:set var="feeTeamAllSum_03_10" value="0"></c:set>
	            <c:set var="feeTeamAllSum_02_10" value="0"></c:set>
	            <c:set var="feeTeamAllSum_01_10" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="feeTeamAllTotalSum_12_10" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_11_10" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_10_10" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_09_10" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_08_10" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_07_10" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_06_10" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_05_10" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_04_10" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_03_10" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_02_10" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_01_10" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="feeColTeamAllTotalSum_10" value="0"></c:set>
   				    			
    			<c:forEach var="vo1" items="${ptnrStatTeamAllFeeList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowTeamAll_10}">
		                    	1종 심사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo1.rowCnt == 1}">
		                		<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>		                				                		
		                		<td onclick="goPtnrStatMember(${vo1.ptnrId},${vo1.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.teamName}</td>
		                		<td style="width:150px;">${vo1.ptnrIdSubNm}</td>
		                		<!-- 센터별 계 초기화 -->
					            <c:set var="feeTeamAllSum_12_10" value="0"></c:set>
					            <c:set var="feeTeamAllSum_11_10" value="0"></c:set>
					            <c:set var="feeTeamAllSum_10_10" value="0"></c:set>
					            <c:set var="feeTeamAllSum_09_10" value="0"></c:set>
					            <c:set var="feeTeamAllSum_08_10" value="0"></c:set>
					            <c:set var="feeTeamAllSum_07_10" value="0"></c:set>
					            <c:set var="feeTeamAllSum_06_10" value="0"></c:set>
					            <c:set var="feeTeamAllSum_05_10" value="0"></c:set>
					            <c:set var="feeTeamAllSum_04_10" value="0"></c:set>
					            <c:set var="feeTeamAllSum_03_10" value="0"></c:set>
					            <c:set var="feeTeamAllSum_02_10" value="0"></c:set>
					            <c:set var="feeTeamAllSum_01_10" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${teamAllCnt == 1 and vo1.teamName != preteamName}">
		                				<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>
		                				<td onclick="goPtnrStatMember(${vo1.ptnrId},${vo1.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${vo1.rowCnt+1}">${vo1.teamName}</td>
		                				<td style="width:150px;">${vo1.ptnrIdSubNm}</td>		                				
		                				<c:set var="preteamName" value="${vo1.teamName}"></c:set>
		                			</c:when>
		                			<c:otherwise>
		                				<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>		                				
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
	    				<c:set var="feeTeamAllSum_12_10" value="${feeTeamAllSum_12_10+fee12_10}"></c:set>
			            <c:set var="feeTeamAllSum_11_10" value="${feeTeamAllSum_11_10+fee11_10}"></c:set>
			            <c:set var="feeTeamAllSum_10_10" value="${feeTeamAllSum_10_10+fee10_10}"></c:set>
			            <c:set var="feeTeamAllSum_09_10" value="${feeTeamAllSum_09_10+fee09_10}"></c:set>
			            <c:set var="feeTeamAllSum_08_10" value="${feeTeamAllSum_08_10+fee08_10}"></c:set>
			            <c:set var="feeTeamAllSum_07_10" value="${feeTeamAllSum_07_10+fee07_10}"></c:set>
			            <c:set var="feeTeamAllSum_06_10" value="${feeTeamAllSum_06_10+fee06_10}"></c:set>
			            <c:set var="feeTeamAllSum_05_10" value="${feeTeamAllSum_05_10+fee05_10}"></c:set>
			            <c:set var="feeTeamAllSum_04_10" value="${feeTeamAllSum_04_10+fee04_10}"></c:set>
			            <c:set var="feeTeamAllSum_03_10" value="${feeTeamAllSum_03_10+fee03_10}"></c:set>
			            <c:set var="feeTeamAllSum_02_10" value="${feeTeamAllSum_02_10+fee02_10}"></c:set>
			            <c:set var="feeTeamAllSum_01_10" value="${feeTeamAllSum_01_10+fee01_10}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="feeTeamAllTotalSum_12_10" value="${feeTeamAllTotalSum_12_10 + fee12_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_11_10" value="${feeTeamAllTotalSum_11_10 + fee11_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_10_10" value="${feeTeamAllTotalSum_10_10 + fee10_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_09_10" value="${feeTeamAllTotalSum_09_10 + fee09_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_08_10" value="${feeTeamAllTotalSum_08_10 + fee08_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_07_10" value="${feeTeamAllTotalSum_07_10 + fee07_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_06_10" value="${feeTeamAllTotalSum_06_10 + fee06_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_05_10" value="${feeTeamAllTotalSum_05_10 + fee05_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_04_10" value="${feeTeamAllTotalSum_04_10 + fee04_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_03_10" value="${feeTeamAllTotalSum_03_10 + fee03_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_02_10" value="${feeTeamAllTotalSum_02_10 + fee02_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_01_10" value="${feeTeamAllTotalSum_01_10 + fee01_10}"></c:set>
		    		</tr>
		    		<!-- 센터별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamAllCnt == vo1.rowCnt and vo1.rowCnt > 1}">
		    				<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- fee12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_12_10}" pattern="#,##0.##"/></td>
			                <!-- fee11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_11_10}" pattern="#,##0.##"/></td>
			                <!-- fee10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_10_10}" pattern="#,##0.##"/></td>
			                <!-- fee09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_09_10}" pattern="#,##0.##"/></td>
			                <!-- fee08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_08_10}" pattern="#,##0.##"/></td>
			                <!-- fee07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_07_10}" pattern="#,##0.##"/></td>
			                <!-- fee06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_06_10}" pattern="#,##0.##"/></td>
			                <!-- fee05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_05_10}" pattern="#,##0.##"/></td>
			                <!-- fee04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_04_10}" pattern="#,##0.##"/></td>
			                <!-- fee03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_03_10}" pattern="#,##0.##"/></td>
			                <!-- fee02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_02_10}" pattern="#,##0.##"/></td>
			                <!-- fee01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_01_10}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="feeTeamAllColSum_10" value="${feeTeamAllSum_12_10 + feeTeamAllSum_11_10 + feeTeamAllSum_10_10 + feeTeamAllSum_09_10 + feeTeamAllSum_08_10 + feeTeamAllSum_07_10 + feeTeamAllSum_06_10 + feeTeamAllSum_05_10 + feeTeamAllSum_04_10 + feeTeamAllSum_03_10 + feeTeamAllSum_02_10 + feeTeamAllSum_01_10}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllColSum_10}" pattern="#,##0.##"/></td>
			                
							<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="teamAllCnt" value="1"></c:set>										                		    				
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="feeTeamAllSum_12_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_11_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_10_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_09_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_08_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_07_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_06_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_05_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_04_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_03_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_02_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_01_10" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo1.rowCnt == 1}">
		    				<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="teamAllCnt" value="1"></c:set>
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="feeTeamAllSum_12_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_11_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_10_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_09_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_08_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_07_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_06_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_05_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_04_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_03_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_02_10" value="0"></c:set>
				            <c:set var="feeTeamAllSum_01_10" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 센터별 계 카운트 증가 -->
		    				<c:set var="teamAllCnt" value="${teamAllCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 센터별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 심사 소계 시작 -->
		    	<c:if test="${ptnrStatTeamAllFeeList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="4" style="height:25px;">1종 심사 소계</th>
	                <!-- fee12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_12_10}" pattern="#,##0.##"/></th>
	                <!-- fee11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_11_10}" pattern="#,##0.##"/></th>
	                <!-- fee10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_10_10}" pattern="#,##0.##"/></th>
	                <!-- fee09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_09_10}" pattern="#,##0.##"/></th>
	                <!-- fee08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_08_10}" pattern="#,##0.##"/></th>
	                <!-- fee07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_07_10}" pattern="#,##0.##"/></th>
	                <!-- fee06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_06_10}" pattern="#,##0.##"/></th>
	                <!-- fee05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_05_10}" pattern="#,##0.##"/></th>
	                <!-- fee04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_04_10}" pattern="#,##0.##"/></th>
	                <!-- fee03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_03_10}" pattern="#,##0.##"/></th>
	                <!-- fee02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_02_10}" pattern="#,##0.##"/></th>
	                <!-- fee01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_01_10}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="feeColTotalSum_10" value="${feeTeamAllTotalSum_12_10 + feeTeamAllTotalSum_11_10 + feeTeamAllTotalSum_10_10 + feeTeamAllTotalSum_09_10 + feeTeamAllTotalSum_08_10 + feeTeamAllTotalSum_07_10 + feeTeamAllTotalSum_06_10 + feeTeamAllTotalSum_05_10 + feeTeamAllTotalSum_04_10 + feeTeamAllTotalSum_03_10 + feeTeamAllTotalSum_02_10 + feeTeamAllTotalSum_01_10}"></c:set>
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
   				<c:set var="teamAllCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 센터명 -->
   				<c:set var="preteamName" value=""></c:set>
   				
   				<!-- 센터별 계 -->
	            <c:set var="feeTeamAllSum_12_15" value="0"></c:set>
	            <c:set var="feeTeamAllSum_11_15" value="0"></c:set>
	            <c:set var="feeTeamAllSum_10_15" value="0"></c:set>
	            <c:set var="feeTeamAllSum_09_15" value="0"></c:set>
	            <c:set var="feeTeamAllSum_08_15" value="0"></c:set>
	            <c:set var="feeTeamAllSum_07_15" value="0"></c:set>
	            <c:set var="feeTeamAllSum_06_15" value="0"></c:set>
	            <c:set var="feeTeamAllSum_05_15" value="0"></c:set>
	            <c:set var="feeTeamAllSum_04_15" value="0"></c:set>
	            <c:set var="feeTeamAllSum_03_15" value="0"></c:set>
	            <c:set var="feeTeamAllSum_02_15" value="0"></c:set>
	            <c:set var="feeTeamAllSum_01_15" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="feeTeamAllTotalSum_12_15" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_11_15" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_10_15" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_09_15" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_08_15" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_07_15" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_06_15" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_05_15" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_04_15" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_03_15" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_02_15" value="0"></c:set>
	            <c:set var="feeTeamAllTotalSum_01_15" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="feeColTeamAllTotalSum_15" value="0"></c:set>
   				    			
    			<c:forEach var="vo2" items="${ptnrStatTeamAllFeeList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCenterFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowTeamAll_15}">
		                    	1종 기타
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo2.rowCnt == 1}">
		                		<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>		                				                		
		                		<td onclick="goPtnrStatMember(${vo2.ptnrId},${vo2.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.teamName}</td>
		                		<td style="width:150px;">${vo2.ptnrIdSubNm}</td>
		                		<!-- 센터별 계 초기화 -->
					            <c:set var="feeTeamAllSum_12_15" value="0"></c:set>
					            <c:set var="feeTeamAllSum_11_15" value="0"></c:set>
					            <c:set var="feeTeamAllSum_10_15" value="0"></c:set>
					            <c:set var="feeTeamAllSum_09_15" value="0"></c:set>
					            <c:set var="feeTeamAllSum_08_15" value="0"></c:set>
					            <c:set var="feeTeamAllSum_07_15" value="0"></c:set>
					            <c:set var="feeTeamAllSum_06_15" value="0"></c:set>
					            <c:set var="feeTeamAllSum_05_15" value="0"></c:set>
					            <c:set var="feeTeamAllSum_04_15" value="0"></c:set>
					            <c:set var="feeTeamAllSum_03_15" value="0"></c:set>
					            <c:set var="feeTeamAllSum_02_15" value="0"></c:set>
					            <c:set var="feeTeamAllSum_01_15" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${teamAllCnt == 1 and vo2.teamName != preteamName}">
		                				<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>
		                				<td onclick="goPtnrStatMember(${vo2.ptnrId},${vo2.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${vo2.rowCnt+1}">${vo2.teamName}</td>
		                				<td style="width:150px;">${vo2.ptnrIdSubNm}</td>		                				
		                				<c:set var="preteamName" value="${vo2.teamName}"></c:set>
		                			</c:when>
		                			<c:otherwise>
		                				<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>		                				
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
	    				<c:set var="feeTeamAllSum_12_15" value="${feeTeamAllSum_12_15+fee12_15}"></c:set>
			            <c:set var="feeTeamAllSum_11_15" value="${feeTeamAllSum_11_15+fee11_15}"></c:set>
			            <c:set var="feeTeamAllSum_10_15" value="${feeTeamAllSum_10_15+fee10_15}"></c:set>
			            <c:set var="feeTeamAllSum_09_15" value="${feeTeamAllSum_09_15+fee09_15}"></c:set>
			            <c:set var="feeTeamAllSum_08_15" value="${feeTeamAllSum_08_15+fee08_15}"></c:set>
			            <c:set var="feeTeamAllSum_07_15" value="${feeTeamAllSum_07_15+fee07_15}"></c:set>
			            <c:set var="feeTeamAllSum_06_15" value="${feeTeamAllSum_06_15+fee06_15}"></c:set>
			            <c:set var="feeTeamAllSum_05_15" value="${feeTeamAllSum_05_15+fee05_15}"></c:set>
			            <c:set var="feeTeamAllSum_04_15" value="${feeTeamAllSum_04_15+fee04_15}"></c:set>
			            <c:set var="feeTeamAllSum_03_15" value="${feeTeamAllSum_03_15+fee03_15}"></c:set>
			            <c:set var="feeTeamAllSum_02_15" value="${feeTeamAllSum_02_15+fee02_15}"></c:set>
			            <c:set var="feeTeamAllSum_01_15" value="${feeTeamAllSum_01_15+fee01_15}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="feeTeamAllTotalSum_12_15" value="${feeTeamAllTotalSum_12_15 + fee12_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_11_15" value="${feeTeamAllTotalSum_11_15 + fee11_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_10_15" value="${feeTeamAllTotalSum_10_15 + fee10_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_09_15" value="${feeTeamAllTotalSum_09_15 + fee09_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_08_15" value="${feeTeamAllTotalSum_08_15 + fee08_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_07_15" value="${feeTeamAllTotalSum_07_15 + fee07_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_06_15" value="${feeTeamAllTotalSum_06_15 + fee06_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_05_15" value="${feeTeamAllTotalSum_05_15 + fee05_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_04_15" value="${feeTeamAllTotalSum_04_15 + fee04_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_03_15" value="${feeTeamAllTotalSum_03_15 + fee03_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_02_15" value="${feeTeamAllTotalSum_02_15 + fee02_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_01_15" value="${feeTeamAllTotalSum_01_15 + fee01_15}"></c:set>
		    		</tr>
		    		<!-- 센터별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamAllCnt == vo2.rowCnt and vo2.rowCnt > 1}">
		    				<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- fee12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_12_15}" pattern="#,##0.##"/></td>
			                <!-- fee11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_11_15}" pattern="#,##0.##"/></td>
			                <!-- fee10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_10_15}" pattern="#,##0.##"/></td>
			                <!-- fee09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_09_15}" pattern="#,##0.##"/></td>
			                <!-- fee08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_08_15}" pattern="#,##0.##"/></td>
			                <!-- fee07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_07_15}" pattern="#,##0.##"/></td>
			                <!-- fee06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_06_15}" pattern="#,##0.##"/></td>
			                <!-- fee05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_05_15}" pattern="#,##0.##"/></td>
			                <!-- fee04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_04_15}" pattern="#,##0.##"/></td>
			                <!-- fee03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_03_15}" pattern="#,##0.##"/></td>
			                <!-- fee02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_02_15}" pattern="#,##0.##"/></td>
			                <!-- fee01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllSum_01_15}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="feeTeamAllColSum_15" value="${feeTeamAllSum_12_15 + feeTeamAllSum_11_15 + feeTeamAllSum_10_15 + feeTeamAllSum_09_15 + feeTeamAllSum_08_15 + feeTeamAllSum_07_15 + feeTeamAllSum_06_15 + feeTeamAllSum_05_15 + feeTeamAllSum_04_15 + feeTeamAllSum_03_15 + feeTeamAllSum_02_15 + feeTeamAllSum_01_15}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${feeTeamAllColSum_15}" pattern="#,##0.##"/></td>
			                
							<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="teamAllCnt" value="1"></c:set>										                		    				
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="feeTeamAllSum_12_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_11_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_10_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_09_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_08_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_07_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_06_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_05_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_04_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_03_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_02_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_01_15" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo2.rowCnt == 1}">
		    				<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="teamAllCnt" value="1"></c:set>
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="feeTeamAllSum_12_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_11_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_10_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_09_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_08_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_07_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_06_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_05_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_04_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_03_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_02_15" value="0"></c:set>
				            <c:set var="feeTeamAllSum_01_15" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 센터별 계 카운트 증가 -->
		    				<c:set var="teamAllCnt" value="${teamAllCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 센터별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 기타 소계 시작 -->
		    	<c:if test="${ptnrStatTeamAllFeeList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="4" style="height:25px;">1종 기타 소계</th>
	                <!-- fee12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_12_15}" pattern="#,##0.##"/></th>
	                <!-- fee11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_11_15}" pattern="#,##0.##"/></th>
	                <!-- fee10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_10_15}" pattern="#,##0.##"/></th>
	                <!-- fee09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_09_15}" pattern="#,##0.##"/></th>
	                <!-- fee08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_08_15}" pattern="#,##0.##"/></th>
	                <!-- fee07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_07_15}" pattern="#,##0.##"/></th>
	                <!-- fee06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_06_15}" pattern="#,##0.##"/></th>
	                <!-- fee05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_05_15}" pattern="#,##0.##"/></th>
	                <!-- fee04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_04_15}" pattern="#,##0.##"/></th>
	                <!-- fee03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_03_15}" pattern="#,##0.##"/></th>
	                <!-- fee02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_02_15}" pattern="#,##0.##"/></th>
	                <!-- fee01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${feeTeamAllTotalSum_01_15}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="feeColTotalSum_15" value="${feeTeamAllTotalSum_12_15 + feeTeamAllTotalSum_11_15 + feeTeamAllTotalSum_10_15 + feeTeamAllTotalSum_09_15 + feeTeamAllTotalSum_08_15 + feeTeamAllTotalSum_07_15 + feeTeamAllTotalSum_06_15 + feeTeamAllTotalSum_05_15 + feeTeamAllTotalSum_04_15 + feeTeamAllTotalSum_03_15 + feeTeamAllTotalSum_02_15 + feeTeamAllTotalSum_01_15}"></c:set>
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
    <c:set var="feeTeamAllTotalSum_12_all" value="${feeTeamAllTotalSum_12_5 + feeTeamAllTotalSum_12_10 + feeTeamAllTotalSum_12_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_11_all" value="${feeTeamAllTotalSum_11_5 + feeTeamAllTotalSum_11_10 + feeTeamAllTotalSum_11_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_10_all" value="${feeTeamAllTotalSum_10_5 + feeTeamAllTotalSum_10_10 + feeTeamAllTotalSum_10_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_09_all" value="${feeTeamAllTotalSum_09_5 + feeTeamAllTotalSum_09_10 + feeTeamAllTotalSum_09_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_08_all" value="${feeTeamAllTotalSum_08_5 + feeTeamAllTotalSum_08_10 + feeTeamAllTotalSum_08_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_07_all" value="${feeTeamAllTotalSum_07_5 + feeTeamAllTotalSum_07_10 + feeTeamAllTotalSum_07_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_06_all" value="${feeTeamAllTotalSum_06_5 + feeTeamAllTotalSum_06_10 + feeTeamAllTotalSum_06_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_05_all" value="${feeTeamAllTotalSum_05_5 + feeTeamAllTotalSum_05_10 + feeTeamAllTotalSum_05_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_04_all" value="${feeTeamAllTotalSum_04_5 + feeTeamAllTotalSum_04_10 + feeTeamAllTotalSum_04_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_03_all" value="${feeTeamAllTotalSum_03_5 + feeTeamAllTotalSum_03_10 + feeTeamAllTotalSum_03_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_02_all" value="${feeTeamAllTotalSum_02_5 + feeTeamAllTotalSum_02_10 + feeTeamAllTotalSum_02_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_01_all" value="${feeTeamAllTotalSum_01_5 + feeTeamAllTotalSum_01_10 + feeTeamAllTotalSum_01_15}"></c:set>        
    <c:set var="feeTeamAllTotalSum_col_all" value="${feeTeamAllTotalSum_12_all + feeTeamAllTotalSum_11_all + feeTeamAllTotalSum_10_all + feeTeamAllTotalSum_09_all + feeTeamAllTotalSum_08_all + feeTeamAllTotalSum_07_all + feeTeamAllTotalSum_06_all + feeTeamAllTotalSum_05_all + feeTeamAllTotalSum_04_all + feeTeamAllTotalSum_03_all + feeTeamAllTotalSum_02_all + feeTeamAllTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 530px;height:25px;">전체합계</th>    			
    			<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamAllTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamAllTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamAllTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamAllTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamAllTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamAllTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamAllTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamAllTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamAllTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamAllTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamAllTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamAllTotalSum_01_all}" pattern="#,##0.##"/></th>
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${feeTeamAllTotalSum_col_all}" pattern="#,##0.##"/></th>    			
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>