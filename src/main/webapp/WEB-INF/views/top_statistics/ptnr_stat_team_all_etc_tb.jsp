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
	            <c:set var="etcTeamAllSum_12_5" value="0"></c:set>
	            <c:set var="etcTeamAllSum_11_5" value="0"></c:set>
	            <c:set var="etcTeamAllSum_10_5" value="0"></c:set>
	            <c:set var="etcTeamAllSum_09_5" value="0"></c:set>
	            <c:set var="etcTeamAllSum_08_5" value="0"></c:set>
	            <c:set var="etcTeamAllSum_07_5" value="0"></c:set>
	            <c:set var="etcTeamAllSum_06_5" value="0"></c:set>
	            <c:set var="etcTeamAllSum_05_5" value="0"></c:set>
	            <c:set var="etcTeamAllSum_04_5" value="0"></c:set>
	            <c:set var="etcTeamAllSum_03_5" value="0"></c:set>
	            <c:set var="etcTeamAllSum_02_5" value="0"></c:set>
	            <c:set var="etcTeamAllSum_01_5" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="etcTeamAllTotalSum_12_5" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_11_5" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_10_5" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_09_5" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_08_5" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_07_5" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_06_5" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_05_5" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_04_5" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_03_5" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_02_5" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_01_5" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="etcColTeamAllTotalSum_5" value="0"></c:set>
   				    			
    			<c:forEach var="vo" items="${ptnrStatTeamAllEtcList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatEtc');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowTeamAll}">
		                    	1종 조사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo.rowCnt == 1}">
		                		<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>		                		
		                		<td onclick="goPtnrStatMember(${vo.ptnrId},${vo.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.teamName}</td>
		                		<td style="width:150px;">${vo.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="etcTeamAllSum_12_5" value="0"></c:set>
					            <c:set var="etcTeamAllSum_11_5" value="0"></c:set>
					            <c:set var="etcTeamAllSum_10_5" value="0"></c:set>
					            <c:set var="etcTeamAllSum_09_5" value="0"></c:set>
					            <c:set var="etcTeamAllSum_08_5" value="0"></c:set>
					            <c:set var="etcTeamAllSum_07_5" value="0"></c:set>
					            <c:set var="etcTeamAllSum_06_5" value="0"></c:set>
					            <c:set var="etcTeamAllSum_05_5" value="0"></c:set>
					            <c:set var="etcTeamAllSum_04_5" value="0"></c:set>
					            <c:set var="etcTeamAllSum_03_5" value="0"></c:set>
					            <c:set var="etcTeamAllSum_02_5" value="0"></c:set>
					            <c:set var="etcTeamAllSum_01_5" value="0"></c:set>
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
		                
		                <!-- 팀별 계 합산 -->
	    				<c:set var="etcTeamAllSum_12_5" value="${etcTeamAllSum_12_5+etc12_5}"></c:set>
			            <c:set var="etcTeamAllSum_11_5" value="${etcTeamAllSum_11_5+etc11_5}"></c:set>
			            <c:set var="etcTeamAllSum_10_5" value="${etcTeamAllSum_10_5+etc10_5}"></c:set>
			            <c:set var="etcTeamAllSum_09_5" value="${etcTeamAllSum_09_5+etc09_5}"></c:set>
			            <c:set var="etcTeamAllSum_08_5" value="${etcTeamAllSum_08_5+etc08_5}"></c:set>
			            <c:set var="etcTeamAllSum_07_5" value="${etcTeamAllSum_07_5+etc07_5}"></c:set>
			            <c:set var="etcTeamAllSum_06_5" value="${etcTeamAllSum_06_5+etc06_5}"></c:set>
			            <c:set var="etcTeamAllSum_05_5" value="${etcTeamAllSum_05_5+etc05_5}"></c:set>
			            <c:set var="etcTeamAllSum_04_5" value="${etcTeamAllSum_04_5+etc04_5}"></c:set>
			            <c:set var="etcTeamAllSum_03_5" value="${etcTeamAllSum_03_5+etc03_5}"></c:set>
			            <c:set var="etcTeamAllSum_02_5" value="${etcTeamAllSum_02_5+etc02_5}"></c:set>
			            <c:set var="etcTeamAllSum_01_5" value="${etcTeamAllSum_01_5+etc01_5}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="etcTeamAllTotalSum_12_5" value="${etcTeamAllTotalSum_12_5 + etc12_5}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_11_5" value="${etcTeamAllTotalSum_11_5 + etc11_5}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_10_5" value="${etcTeamAllTotalSum_10_5 + etc10_5}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_09_5" value="${etcTeamAllTotalSum_09_5 + etc09_5}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_08_5" value="${etcTeamAllTotalSum_08_5 + etc08_5}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_07_5" value="${etcTeamAllTotalSum_07_5 + etc07_5}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_06_5" value="${etcTeamAllTotalSum_06_5 + etc06_5}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_05_5" value="${etcTeamAllTotalSum_05_5 + etc05_5}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_04_5" value="${etcTeamAllTotalSum_04_5 + etc04_5}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_03_5" value="${etcTeamAllTotalSum_03_5 + etc03_5}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_02_5" value="${etcTeamAllTotalSum_02_5 + etc02_5}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_01_5" value="${etcTeamAllTotalSum_01_5 + etc01_5}"></c:set>
		    		</tr>
		    		<!-- 팀별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo.rowCnt and vo.rowCnt > 1}">
		    				<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- etc12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_12_5}" pattern="#,##0.##"/></td>
			                <!-- etc11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_11_5}" pattern="#,##0.##"/></td>
			                <!-- etc10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_10_5}" pattern="#,##0.##"/></td>
			                <!-- etc09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_09_5}" pattern="#,##0.##"/></td>
			                <!-- etc08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_08_5}" pattern="#,##0.##"/></td>
			                <!-- etc07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_07_5}" pattern="#,##0.##"/></td>
			                <!-- etc06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_06_5}" pattern="#,##0.##"/></td>
			                <!-- etc05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_05_5}" pattern="#,##0.##"/></td>
			                <!-- etc04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_04_5}" pattern="#,##0.##"/></td>
			                <!-- etc03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_03_5}" pattern="#,##0.##"/></td>
			                <!-- etc02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_02_5}" pattern="#,##0.##"/></td>
			                <!-- etc01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_01_5}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="etcTeamAllColSum_5" value="${etcTeamAllSum_12_5 + etcTeamAllSum_11_5 + etcTeamAllSum_10_5 + etcTeamAllSum_09_5 + etcTeamAllSum_08_5 + etcTeamAllSum_07_5 + etcTeamAllSum_06_5 + etcTeamAllSum_05_5 + etcTeamAllSum_04_5 + etcTeamAllSum_03_5 + etcTeamAllSum_02_5 + etcTeamAllSum_01_5}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllColSum_5}" pattern="#,##0.##"/></td>
			                
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="etcTeamAllSum_12_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_11_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_10_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_09_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_08_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_07_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_06_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_05_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_04_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_03_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_02_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_01_5" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo.rowCnt == 1}">
		    				<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="etcTeamAllSum_12_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_11_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_10_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_09_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_08_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_07_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_06_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_05_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_04_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_03_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_02_5" value="0"></c:set>
				            <c:set var="etcTeamAllSum_01_5" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 팀별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 팀별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 조사 소계 시작 -->
		    	<c:if test="${ptnrStatTeamAllEtcList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="4" style="height:25px;">1종 조사 소계</th>
	                <!-- etc12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_12_5}" pattern="#,##0.##"/></th>
	                <!-- etc11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_11_5}" pattern="#,##0.##"/></th>
	                <!-- etc10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_10_5}" pattern="#,##0.##"/></th>
	                <!-- etc09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_09_5}" pattern="#,##0.##"/></th>
	                <!-- etc08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_08_5}" pattern="#,##0.##"/></th>
	                <!-- etc07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_07_5}" pattern="#,##0.##"/></th>
	                <!-- etc06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_06_5}" pattern="#,##0.##"/></th>
	                <!-- etc05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_05_5}" pattern="#,##0.##"/></th>
	                <!-- etc04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_04_5}" pattern="#,##0.##"/></th>
	                <!-- etc03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_03_5}" pattern="#,##0.##"/></th>
	                <!-- etc02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_02_5}" pattern="#,##0.##"/></th>
	                <!-- etc01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_01_5}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="etcColTotalSum_5" value="${etcTeamAllTotalSum_12_5 + etcTeamAllTotalSum_11_5 + etcTeamAllTotalSum_10_5 + etcTeamAllTotalSum_09_5 + etcTeamAllTotalSum_08_5 + etcTeamAllTotalSum_07_5 + etcTeamAllTotalSum_06_5 + etcTeamAllTotalSum_05_5 + etcTeamAllTotalSum_04_5 + etcTeamAllTotalSum_03_5 + etcTeamAllTotalSum_02_5 + etcTeamAllTotalSum_01_5}"></c:set>
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
   				<!-- 팀별 계를 만들기 위한 변수 -->
   				<c:set var="teamCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 팀명 -->
   				<c:set var="preTeamAllName" value=""></c:set>
   				
   				<!-- 팀별 계 -->
	            <c:set var="etcTeamAllSum_12_10" value="0"></c:set>
	            <c:set var="etcTeamAllSum_11_10" value="0"></c:set>
	            <c:set var="etcTeamAllSum_10_10" value="0"></c:set>
	            <c:set var="etcTeamAllSum_09_10" value="0"></c:set>
	            <c:set var="etcTeamAllSum_08_10" value="0"></c:set>
	            <c:set var="etcTeamAllSum_07_10" value="0"></c:set>
	            <c:set var="etcTeamAllSum_06_10" value="0"></c:set>
	            <c:set var="etcTeamAllSum_05_10" value="0"></c:set>
	            <c:set var="etcTeamAllSum_04_10" value="0"></c:set>
	            <c:set var="etcTeamAllSum_03_10" value="0"></c:set>
	            <c:set var="etcTeamAllSum_02_10" value="0"></c:set>
	            <c:set var="etcTeamAllSum_01_10" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="etcTeamAllTotalSum_12_10" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_11_10" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_10_10" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_09_10" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_08_10" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_07_10" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_06_10" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_05_10" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_04_10" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_03_10" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_02_10" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_01_10" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="etcColTeamAllTotalSum_10" value="0"></c:set>
   				    			
    			<c:forEach var="vo1" items="${ptnrStatTeamAllEtcList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatEtc');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowTeamAll_10}">
		                    	1종 심사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo1.rowCnt == 1}">
		                		<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>		                		
		                		<td onclick="goPtnrStatMember(${vo1.ptnrId},${vo1.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.teamName}</td>
		                		<td style="width:150px;">${vo1.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="etcTeamAllSum_12_10" value="0"></c:set>
					            <c:set var="etcTeamAllSum_11_10" value="0"></c:set>
					            <c:set var="etcTeamAllSum_10_10" value="0"></c:set>
					            <c:set var="etcTeamAllSum_09_10" value="0"></c:set>
					            <c:set var="etcTeamAllSum_08_10" value="0"></c:set>
					            <c:set var="etcTeamAllSum_07_10" value="0"></c:set>
					            <c:set var="etcTeamAllSum_06_10" value="0"></c:set>
					            <c:set var="etcTeamAllSum_05_10" value="0"></c:set>
					            <c:set var="etcTeamAllSum_04_10" value="0"></c:set>
					            <c:set var="etcTeamAllSum_03_10" value="0"></c:set>
					            <c:set var="etcTeamAllSum_02_10" value="0"></c:set>
					            <c:set var="etcTeamAllSum_01_10" value="0"></c:set>
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
		                
		                <!-- 팀별 계 합산 -->
	    				<c:set var="etcTeamAllSum_12_10" value="${etcTeamAllSum_12_10+etc12_10}"></c:set>
			            <c:set var="etcTeamAllSum_11_10" value="${etcTeamAllSum_11_10+etc11_10}"></c:set>
			            <c:set var="etcTeamAllSum_10_10" value="${etcTeamAllSum_10_10+etc10_10}"></c:set>
			            <c:set var="etcTeamAllSum_09_10" value="${etcTeamAllSum_09_10+etc09_10}"></c:set>
			            <c:set var="etcTeamAllSum_08_10" value="${etcTeamAllSum_08_10+etc08_10}"></c:set>
			            <c:set var="etcTeamAllSum_07_10" value="${etcTeamAllSum_07_10+etc07_10}"></c:set>
			            <c:set var="etcTeamAllSum_06_10" value="${etcTeamAllSum_06_10+etc06_10}"></c:set>
			            <c:set var="etcTeamAllSum_05_10" value="${etcTeamAllSum_05_10+etc05_10}"></c:set>
			            <c:set var="etcTeamAllSum_04_10" value="${etcTeamAllSum_04_10+etc04_10}"></c:set>
			            <c:set var="etcTeamAllSum_03_10" value="${etcTeamAllSum_03_10+etc03_10}"></c:set>
			            <c:set var="etcTeamAllSum_02_10" value="${etcTeamAllSum_02_10+etc02_10}"></c:set>
			            <c:set var="etcTeamAllSum_01_10" value="${etcTeamAllSum_01_10+etc01_10}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="etcTeamAllTotalSum_12_10" value="${etcTeamAllTotalSum_12_10 + etc12_10}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_11_10" value="${etcTeamAllTotalSum_11_10 + etc11_10}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_10_10" value="${etcTeamAllTotalSum_10_10 + etc10_10}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_09_10" value="${etcTeamAllTotalSum_09_10 + etc09_10}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_08_10" value="${etcTeamAllTotalSum_08_10 + etc08_10}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_07_10" value="${etcTeamAllTotalSum_07_10 + etc07_10}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_06_10" value="${etcTeamAllTotalSum_06_10 + etc06_10}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_05_10" value="${etcTeamAllTotalSum_05_10 + etc05_10}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_04_10" value="${etcTeamAllTotalSum_04_10 + etc04_10}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_03_10" value="${etcTeamAllTotalSum_03_10 + etc03_10}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_02_10" value="${etcTeamAllTotalSum_02_10 + etc02_10}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_01_10" value="${etcTeamAllTotalSum_01_10 + etc01_10}"></c:set>
		    		</tr>
		    		<!-- 팀별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo1.rowCnt and vo1.rowCnt > 1}">
		    				<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- etc12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_12_10}" pattern="#,##0.##"/></td>
			                <!-- etc11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_11_10}" pattern="#,##0.##"/></td>
			                <!-- etc10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_10_10}" pattern="#,##0.##"/></td>
			                <!-- etc09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_09_10}" pattern="#,##0.##"/></td>
			                <!-- etc08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_08_10}" pattern="#,##0.##"/></td>
			                <!-- etc07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_07_10}" pattern="#,##0.##"/></td>
			                <!-- etc06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_06_10}" pattern="#,##0.##"/></td>
			                <!-- etc05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_05_10}" pattern="#,##0.##"/></td>
			                <!-- etc04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_04_10}" pattern="#,##0.##"/></td>
			                <!-- etc03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_03_10}" pattern="#,##0.##"/></td>
			                <!-- etc02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_02_10}" pattern="#,##0.##"/></td>
			                <!-- etc01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_01_10}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="etcTeamAllColSum_10" value="${etcTeamAllSum_12_10 + etcTeamAllSum_11_10 + etcTeamAllSum_10_10 + etcTeamAllSum_09_10 + etcTeamAllSum_08_10 + etcTeamAllSum_07_10 + etcTeamAllSum_06_10 + etcTeamAllSum_05_10 + etcTeamAllSum_04_10 + etcTeamAllSum_03_10 + etcTeamAllSum_02_10 + etcTeamAllSum_01_10}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllColSum_10}" pattern="#,##0.##"/></td>
			                
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="etcTeamAllSum_12_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_11_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_10_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_09_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_08_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_07_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_06_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_05_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_04_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_03_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_02_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_01_10" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo1.rowCnt == 1}">
		    				<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="etcTeamAllSum_12_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_11_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_10_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_09_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_08_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_07_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_06_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_05_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_04_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_03_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_02_10" value="0"></c:set>
				            <c:set var="etcTeamAllSum_01_10" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 팀별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 팀별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 심사 소계 시작 -->
		    	<c:if test="${ptnrStatTeamAllEtcList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="4" style="height:25px;">1종 심사 소계</th>
	                <!-- etc12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_12_10}" pattern="#,##0.##"/></th>
	                <!-- etc11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_11_10}" pattern="#,##0.##"/></th>
	                <!-- etc10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_10_10}" pattern="#,##0.##"/></th>
	                <!-- etc09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_09_10}" pattern="#,##0.##"/></th>
	                <!-- etc08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_08_10}" pattern="#,##0.##"/></th>
	                <!-- etc07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_07_10}" pattern="#,##0.##"/></th>
	                <!-- etc06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_06_10}" pattern="#,##0.##"/></th>
	                <!-- etc05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_05_10}" pattern="#,##0.##"/></th>
	                <!-- etc04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_04_10}" pattern="#,##0.##"/></th>
	                <!-- etc03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_03_10}" pattern="#,##0.##"/></th>
	                <!-- etc02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_02_10}" pattern="#,##0.##"/></th>
	                <!-- etc01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_01_10}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="etcColTotalSum_10" value="${etcTeamAllTotalSum_12_10 + etcTeamAllTotalSum_11_10 + etcTeamAllTotalSum_10_10 + etcTeamAllTotalSum_09_10 + etcTeamAllTotalSum_08_10 + etcTeamAllTotalSum_07_10 + etcTeamAllTotalSum_06_10 + etcTeamAllTotalSum_05_10 + etcTeamAllTotalSum_04_10 + etcTeamAllTotalSum_03_10 + etcTeamAllTotalSum_02_10 + etcTeamAllTotalSum_01_10}"></c:set>
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
   				<!-- 팀별 계를 만들기 위한 변수 -->
   				<c:set var="teamCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 팀명 -->
   				<c:set var="preTeamAllName" value=""></c:set>
   				
   				<!-- 팀별 계 -->
	            <c:set var="etcTeamAllSum_12_15" value="0"></c:set>
	            <c:set var="etcTeamAllSum_11_15" value="0"></c:set>
	            <c:set var="etcTeamAllSum_10_15" value="0"></c:set>
	            <c:set var="etcTeamAllSum_09_15" value="0"></c:set>
	            <c:set var="etcTeamAllSum_08_15" value="0"></c:set>
	            <c:set var="etcTeamAllSum_07_15" value="0"></c:set>
	            <c:set var="etcTeamAllSum_06_15" value="0"></c:set>
	            <c:set var="etcTeamAllSum_05_15" value="0"></c:set>
	            <c:set var="etcTeamAllSum_04_15" value="0"></c:set>
	            <c:set var="etcTeamAllSum_03_15" value="0"></c:set>
	            <c:set var="etcTeamAllSum_02_15" value="0"></c:set>
	            <c:set var="etcTeamAllSum_01_15" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="etcTeamAllTotalSum_12_15" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_11_15" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_10_15" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_09_15" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_08_15" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_07_15" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_06_15" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_05_15" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_04_15" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_03_15" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_02_15" value="0"></c:set>
	            <c:set var="etcTeamAllTotalSum_01_15" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="etcColTeamAllTotalSum_15" value="0"></c:set>
   				    			
    			<c:forEach var="vo2" items="${ptnrStatTeamAllEtcList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatEtc');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowTeamAll_15}">
		                    	1종 기타
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo2.rowCnt == 1}">
		                		<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>		                		
		                		<td onclick="goPtnrStatMember(${vo2.ptnrId},${vo2.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.teamName}</td>
		                		<td style="width:150px;">${vo2.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="etcTeamAllSum_12_15" value="0"></c:set>
					            <c:set var="etcTeamAllSum_11_15" value="0"></c:set>
					            <c:set var="etcTeamAllSum_10_15" value="0"></c:set>
					            <c:set var="etcTeamAllSum_09_15" value="0"></c:set>
					            <c:set var="etcTeamAllSum_08_15" value="0"></c:set>
					            <c:set var="etcTeamAllSum_07_15" value="0"></c:set>
					            <c:set var="etcTeamAllSum_06_15" value="0"></c:set>
					            <c:set var="etcTeamAllSum_05_15" value="0"></c:set>
					            <c:set var="etcTeamAllSum_04_15" value="0"></c:set>
					            <c:set var="etcTeamAllSum_03_15" value="0"></c:set>
					            <c:set var="etcTeamAllSum_02_15" value="0"></c:set>
					            <c:set var="etcTeamAllSum_01_15" value="0"></c:set>
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
		                
		                <!-- 팀별 계 합산 -->
	    				<c:set var="etcTeamAllSum_12_15" value="${etcTeamAllSum_12_15+etc12_15}"></c:set>
			            <c:set var="etcTeamAllSum_11_15" value="${etcTeamAllSum_11_15+etc11_15}"></c:set>
			            <c:set var="etcTeamAllSum_10_15" value="${etcTeamAllSum_10_15+etc10_15}"></c:set>
			            <c:set var="etcTeamAllSum_09_15" value="${etcTeamAllSum_09_15+etc09_15}"></c:set>
			            <c:set var="etcTeamAllSum_08_15" value="${etcTeamAllSum_08_15+etc08_15}"></c:set>
			            <c:set var="etcTeamAllSum_07_15" value="${etcTeamAllSum_07_15+etc07_15}"></c:set>
			            <c:set var="etcTeamAllSum_06_15" value="${etcTeamAllSum_06_15+etc06_15}"></c:set>
			            <c:set var="etcTeamAllSum_05_15" value="${etcTeamAllSum_05_15+etc05_15}"></c:set>
			            <c:set var="etcTeamAllSum_04_15" value="${etcTeamAllSum_04_15+etc04_15}"></c:set>
			            <c:set var="etcTeamAllSum_03_15" value="${etcTeamAllSum_03_15+etc03_15}"></c:set>
			            <c:set var="etcTeamAllSum_02_15" value="${etcTeamAllSum_02_15+etc02_15}"></c:set>
			            <c:set var="etcTeamAllSum_01_15" value="${etcTeamAllSum_01_15+etc01_15}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="etcTeamAllTotalSum_12_15" value="${etcTeamAllTotalSum_12_15 + etc12_15}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_11_15" value="${etcTeamAllTotalSum_11_15 + etc11_15}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_10_15" value="${etcTeamAllTotalSum_10_15 + etc10_15}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_09_15" value="${etcTeamAllTotalSum_09_15 + etc09_15}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_08_15" value="${etcTeamAllTotalSum_08_15 + etc08_15}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_07_15" value="${etcTeamAllTotalSum_07_15 + etc07_15}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_06_15" value="${etcTeamAllTotalSum_06_15 + etc06_15}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_05_15" value="${etcTeamAllTotalSum_05_15 + etc05_15}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_04_15" value="${etcTeamAllTotalSum_04_15 + etc04_15}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_03_15" value="${etcTeamAllTotalSum_03_15 + etc03_15}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_02_15" value="${etcTeamAllTotalSum_02_15 + etc02_15}"></c:set>
	                    <c:set var="etcTeamAllTotalSum_01_15" value="${etcTeamAllTotalSum_01_15 + etc01_15}"></c:set>
		    		</tr>
		    		<!-- 팀별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo2.rowCnt and vo2.rowCnt > 1}">
		    				<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- etc12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_12_15}" pattern="#,##0.##"/></td>
			                <!-- etc11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_11_15}" pattern="#,##0.##"/></td>
			                <!-- etc10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_10_15}" pattern="#,##0.##"/></td>
			                <!-- etc09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_09_15}" pattern="#,##0.##"/></td>
			                <!-- etc08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_08_15}" pattern="#,##0.##"/></td>
			                <!-- etc07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_07_15}" pattern="#,##0.##"/></td>
			                <!-- etc06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_06_15}" pattern="#,##0.##"/></td>
			                <!-- etc05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_05_15}" pattern="#,##0.##"/></td>
			                <!-- etc04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_04_15}" pattern="#,##0.##"/></td>
			                <!-- etc03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_03_15}" pattern="#,##0.##"/></td>
			                <!-- etc02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_02_15}" pattern="#,##0.##"/></td>
			                <!-- etc01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllSum_01_15}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="etcTeamAllColSum_15" value="${etcTeamAllSum_12_15 + etcTeamAllSum_11_15 + etcTeamAllSum_10_15 + etcTeamAllSum_09_15 + etcTeamAllSum_08_15 + etcTeamAllSum_07_15 + etcTeamAllSum_06_15 + etcTeamAllSum_05_15 + etcTeamAllSum_04_15 + etcTeamAllSum_03_15 + etcTeamAllSum_02_15 + etcTeamAllSum_01_15}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcTeamAllColSum_15}" pattern="#,##0.##"/></td>
			                
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="etcTeamAllSum_12_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_11_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_10_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_09_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_08_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_07_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_06_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_05_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_04_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_03_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_02_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_01_15" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo2.rowCnt == 1}">
		    				<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="etcTeamAllSum_12_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_11_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_10_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_09_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_08_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_07_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_06_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_05_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_04_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_03_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_02_15" value="0"></c:set>
				            <c:set var="etcTeamAllSum_01_15" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 팀별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 팀별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 기타 소계 시작 -->
		    	<c:if test="${ptnrStatTeamAllEtcList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="4" style="height:25px;">1종 기타 소계</th>
	                <!-- etc12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_12_15}" pattern="#,##0.##"/></th>
	                <!-- etc11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_11_15}" pattern="#,##0.##"/></th>
	                <!-- etc10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_10_15}" pattern="#,##0.##"/></th>
	                <!-- etc09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_09_15}" pattern="#,##0.##"/></th>
	                <!-- etc08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_08_15}" pattern="#,##0.##"/></th>
	                <!-- etc07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_07_15}" pattern="#,##0.##"/></th>
	                <!-- etc06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_06_15}" pattern="#,##0.##"/></th>
	                <!-- etc05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_05_15}" pattern="#,##0.##"/></th>
	                <!-- etc04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_04_15}" pattern="#,##0.##"/></th>
	                <!-- etc03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_03_15}" pattern="#,##0.##"/></th>
	                <!-- etc02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_02_15}" pattern="#,##0.##"/></th>
	                <!-- etc01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcTeamAllTotalSum_01_15}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="etcColTotalSum_15" value="${etcTeamAllTotalSum_12_15 + etcTeamAllTotalSum_11_15 + etcTeamAllTotalSum_10_15 + etcTeamAllTotalSum_09_15 + etcTeamAllTotalSum_08_15 + etcTeamAllTotalSum_07_15 + etcTeamAllTotalSum_06_15 + etcTeamAllTotalSum_05_15 + etcTeamAllTotalSum_04_15 + etcTeamAllTotalSum_03_15 + etcTeamAllTotalSum_02_15 + etcTeamAllTotalSum_01_15}"></c:set>
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
    <c:set var="etcTeamAllTotalSum_12_all" value="${etcTeamAllTotalSum_12_5 + etcTeamAllTotalSum_12_10 + etcTeamAllTotalSum_12_15}"></c:set>
    <c:set var="etcTeamAllTotalSum_11_all" value="${etcTeamAllTotalSum_11_5 + etcTeamAllTotalSum_11_10 + etcTeamAllTotalSum_11_15}"></c:set>
    <c:set var="etcTeamAllTotalSum_10_all" value="${etcTeamAllTotalSum_10_5 + etcTeamAllTotalSum_10_10 + etcTeamAllTotalSum_10_15}"></c:set>
    <c:set var="etcTeamAllTotalSum_09_all" value="${etcTeamAllTotalSum_09_5 + etcTeamAllTotalSum_09_10 + etcTeamAllTotalSum_09_15}"></c:set>
    <c:set var="etcTeamAllTotalSum_08_all" value="${etcTeamAllTotalSum_08_5 + etcTeamAllTotalSum_08_10 + etcTeamAllTotalSum_08_15}"></c:set>
    <c:set var="etcTeamAllTotalSum_07_all" value="${etcTeamAllTotalSum_07_5 + etcTeamAllTotalSum_07_10 + etcTeamAllTotalSum_07_15}"></c:set>
    <c:set var="etcTeamAllTotalSum_06_all" value="${etcTeamAllTotalSum_06_5 + etcTeamAllTotalSum_06_10 + etcTeamAllTotalSum_06_15}"></c:set>
    <c:set var="etcTeamAllTotalSum_05_all" value="${etcTeamAllTotalSum_05_5 + etcTeamAllTotalSum_05_10 + etcTeamAllTotalSum_05_15}"></c:set>
    <c:set var="etcTeamAllTotalSum_04_all" value="${etcTeamAllTotalSum_04_5 + etcTeamAllTotalSum_04_10 + etcTeamAllTotalSum_04_15}"></c:set>
    <c:set var="etcTeamAllTotalSum_03_all" value="${etcTeamAllTotalSum_03_5 + etcTeamAllTotalSum_03_10 + etcTeamAllTotalSum_03_15}"></c:set>
    <c:set var="etcTeamAllTotalSum_02_all" value="${etcTeamAllTotalSum_02_5 + etcTeamAllTotalSum_02_10 + etcTeamAllTotalSum_02_15}"></c:set>
    <c:set var="etcTeamAllTotalSum_01_all" value="${etcTeamAllTotalSum_01_5 + etcTeamAllTotalSum_01_10 + etcTeamAllTotalSum_01_15}"></c:set>        
    <c:set var="etcTeamAllTotalSum_col_all" value="${etcTeamAllTotalSum_12_all + etcTeamAllTotalSum_11_all + etcTeamAllTotalSum_10_all + etcTeamAllTotalSum_09_all + etcTeamAllTotalSum_08_all + etcTeamAllTotalSum_07_all + etcTeamAllTotalSum_06_all + etcTeamAllTotalSum_05_all + etcTeamAllTotalSum_04_all + etcTeamAllTotalSum_03_all + etcTeamAllTotalSum_02_all + etcTeamAllTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 530px;height:25px;">전체합계</th>    			
    			<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTeamAllTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTeamAllTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTeamAllTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTeamAllTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTeamAllTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTeamAllTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTeamAllTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTeamAllTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTeamAllTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTeamAllTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTeamAllTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTeamAllTotalSum_01_all}" pattern="#,##0.##"/></th>
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcTeamAllTotalSum_col_all}" pattern="#,##0.##"/></th>    			
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>