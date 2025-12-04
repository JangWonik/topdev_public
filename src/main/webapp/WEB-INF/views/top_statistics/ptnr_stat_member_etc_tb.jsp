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
	            <c:set var="etcMemberSum_12_5" value="0"></c:set>
	            <c:set var="etcMemberSum_11_5" value="0"></c:set>
	            <c:set var="etcMemberSum_10_5" value="0"></c:set>
	            <c:set var="etcMemberSum_09_5" value="0"></c:set>
	            <c:set var="etcMemberSum_08_5" value="0"></c:set>
	            <c:set var="etcMemberSum_07_5" value="0"></c:set>
	            <c:set var="etcMemberSum_06_5" value="0"></c:set>
	            <c:set var="etcMemberSum_05_5" value="0"></c:set>
	            <c:set var="etcMemberSum_04_5" value="0"></c:set>
	            <c:set var="etcMemberSum_03_5" value="0"></c:set>
	            <c:set var="etcMemberSum_02_5" value="0"></c:set>
	            <c:set var="etcMemberSum_01_5" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="etcMemberTotalSum_12_5" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_11_5" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_10_5" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_09_5" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_08_5" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_07_5" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_06_5" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_05_5" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_04_5" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_03_5" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_02_5" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_01_5" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="etcColMemberTotalSum_5" value="0"></c:set>
   				    			
    			<c:forEach var="vo" items="${ptnrStatEtcList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		    				<c:choose>
		    					<c:when test='${srchArg.tabMenu eq "team"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterEtc');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
				                    	1종 조사
				                    </td>
		    					</c:when>
		    					<c:when test='${srchArg.tabMenu eq "member"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterEtc');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
				                    	1종 조사
				                    </td>
		    					</c:when>
		    					<c:otherwise>
		    						<td onclick="goPtnrStatMenu('ptnrStatTeamEtc');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
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
					            <c:set var="etcMemberSum_12_5" value="0"></c:set>
					            <c:set var="etcMemberSum_11_5" value="0"></c:set>
					            <c:set var="etcMemberSum_10_5" value="0"></c:set>
					            <c:set var="etcMemberSum_09_5" value="0"></c:set>
					            <c:set var="etcMemberSum_08_5" value="0"></c:set>
					            <c:set var="etcMemberSum_07_5" value="0"></c:set>
					            <c:set var="etcMemberSum_06_5" value="0"></c:set>
					            <c:set var="etcMemberSum_05_5" value="0"></c:set>
					            <c:set var="etcMemberSum_04_5" value="0"></c:set>
					            <c:set var="etcMemberSum_03_5" value="0"></c:set>
					            <c:set var="etcMemberSum_02_5" value="0"></c:set>
					            <c:set var="etcMemberSum_01_5" value="0"></c:set>
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
		                
		                <!-- 직원별 계 합산 -->
	    				<c:set var="etcMemberSum_12_5" value="${etcMemberSum_12_5+etc12_5}"></c:set>
			            <c:set var="etcMemberSum_11_5" value="${etcMemberSum_11_5+etc11_5}"></c:set>
			            <c:set var="etcMemberSum_10_5" value="${etcMemberSum_10_5+etc10_5}"></c:set>
			            <c:set var="etcMemberSum_09_5" value="${etcMemberSum_09_5+etc09_5}"></c:set>
			            <c:set var="etcMemberSum_08_5" value="${etcMemberSum_08_5+etc08_5}"></c:set>
			            <c:set var="etcMemberSum_07_5" value="${etcMemberSum_07_5+etc07_5}"></c:set>
			            <c:set var="etcMemberSum_06_5" value="${etcMemberSum_06_5+etc06_5}"></c:set>
			            <c:set var="etcMemberSum_05_5" value="${etcMemberSum_05_5+etc05_5}"></c:set>
			            <c:set var="etcMemberSum_04_5" value="${etcMemberSum_04_5+etc04_5}"></c:set>
			            <c:set var="etcMemberSum_03_5" value="${etcMemberSum_03_5+etc03_5}"></c:set>
			            <c:set var="etcMemberSum_02_5" value="${etcMemberSum_02_5+etc02_5}"></c:set>
			            <c:set var="etcMemberSum_01_5" value="${etcMemberSum_01_5+etc01_5}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="etcMemberTotalSum_12_5" value="${etcMemberTotalSum_12_5 + etc12_5}"></c:set>
	                    <c:set var="etcMemberTotalSum_11_5" value="${etcMemberTotalSum_11_5 + etc11_5}"></c:set>
	                    <c:set var="etcMemberTotalSum_10_5" value="${etcMemberTotalSum_10_5 + etc10_5}"></c:set>
	                    <c:set var="etcMemberTotalSum_09_5" value="${etcMemberTotalSum_09_5 + etc09_5}"></c:set>
	                    <c:set var="etcMemberTotalSum_08_5" value="${etcMemberTotalSum_08_5 + etc08_5}"></c:set>
	                    <c:set var="etcMemberTotalSum_07_5" value="${etcMemberTotalSum_07_5 + etc07_5}"></c:set>
	                    <c:set var="etcMemberTotalSum_06_5" value="${etcMemberTotalSum_06_5 + etc06_5}"></c:set>
	                    <c:set var="etcMemberTotalSum_05_5" value="${etcMemberTotalSum_05_5 + etc05_5}"></c:set>
	                    <c:set var="etcMemberTotalSum_04_5" value="${etcMemberTotalSum_04_5 + etc04_5}"></c:set>
	                    <c:set var="etcMemberTotalSum_03_5" value="${etcMemberTotalSum_03_5 + etc03_5}"></c:set>
	                    <c:set var="etcMemberTotalSum_02_5" value="${etcMemberTotalSum_02_5 + etc02_5}"></c:set>
	                    <c:set var="etcMemberTotalSum_01_5" value="${etcMemberTotalSum_01_5 + etc01_5}"></c:set>
		    		</tr>
		    		<!-- 직원별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${memberCnt == vo.rowCnt and vo.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- etc12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_12_5}" pattern="#,##0.##"/></td>
			                <!-- etc11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_11_5}" pattern="#,##0.##"/></td>
			                <!-- etc10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_10_5}" pattern="#,##0.##"/></td>
			                <!-- etc09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_09_5}" pattern="#,##0.##"/></td>
			                <!-- etc08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_08_5}" pattern="#,##0.##"/></td>
			                <!-- etc07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_07_5}" pattern="#,##0.##"/></td>
			                <!-- etc06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_06_5}" pattern="#,##0.##"/></td>
			                <!-- etc05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_05_5}" pattern="#,##0.##"/></td>
			                <!-- etc04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_04_5}" pattern="#,##0.##"/></td>
			                <!-- etc03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_03_5}" pattern="#,##0.##"/></td>
			                <!-- etc02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_02_5}" pattern="#,##0.##"/></td>
			                <!-- etc01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_01_5}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="etcMemberColSum_5" value="${etcMemberSum_12_5 + etcMemberSum_11_5 + etcMemberSum_10_5 + etcMemberSum_09_5 + etcMemberSum_08_5 + etcMemberSum_07_5 + etcMemberSum_06_5 + etcMemberSum_05_5 + etcMemberSum_04_5 + etcMemberSum_03_5 + etcMemberSum_02_5 + etcMemberSum_01_5}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberColSum_5}" pattern="#,##0.##"/></td>
			                
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="etcMemberSum_12_5" value="0"></c:set>
				            <c:set var="etcMemberSum_11_5" value="0"></c:set>
				            <c:set var="etcMemberSum_10_5" value="0"></c:set>
				            <c:set var="etcMemberSum_09_5" value="0"></c:set>
				            <c:set var="etcMemberSum_08_5" value="0"></c:set>
				            <c:set var="etcMemberSum_07_5" value="0"></c:set>
				            <c:set var="etcMemberSum_06_5" value="0"></c:set>
				            <c:set var="etcMemberSum_05_5" value="0"></c:set>
				            <c:set var="etcMemberSum_04_5" value="0"></c:set>
				            <c:set var="etcMemberSum_03_5" value="0"></c:set>
				            <c:set var="etcMemberSum_02_5" value="0"></c:set>
				            <c:set var="etcMemberSum_01_5" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo.rowCnt == 1}">
		    				<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="etcMemberSum_12_5" value="0"></c:set>
				            <c:set var="etcMemberSum_11_5" value="0"></c:set>
				            <c:set var="etcMemberSum_10_5" value="0"></c:set>
				            <c:set var="etcMemberSum_09_5" value="0"></c:set>
				            <c:set var="etcMemberSum_08_5" value="0"></c:set>
				            <c:set var="etcMemberSum_07_5" value="0"></c:set>
				            <c:set var="etcMemberSum_06_5" value="0"></c:set>
				            <c:set var="etcMemberSum_05_5" value="0"></c:set>
				            <c:set var="etcMemberSum_04_5" value="0"></c:set>
				            <c:set var="etcMemberSum_03_5" value="0"></c:set>
				            <c:set var="etcMemberSum_02_5" value="0"></c:set>
				            <c:set var="etcMemberSum_01_5" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 직원별 계 카운트 증가 -->
		    				<c:set var="memberCnt" value="${memberCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 직원별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 조사 소계 시작 -->
		    	<c:if test="${ptnrStatEtcList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 조사 소계</th>
	                <!-- etc12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_12_5}" pattern="#,##0.##"/></th>
	                <!-- etc11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_11_5}" pattern="#,##0.##"/></th>
	                <!-- etc10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_10_5}" pattern="#,##0.##"/></th>
	                <!-- etc09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_09_5}" pattern="#,##0.##"/></th>
	                <!-- etc08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_08_5}" pattern="#,##0.##"/></th>
	                <!-- etc07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_07_5}" pattern="#,##0.##"/></th>
	                <!-- etc06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_06_5}" pattern="#,##0.##"/></th>
	                <!-- etc05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_05_5}" pattern="#,##0.##"/></th>
	                <!-- etc04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_04_5}" pattern="#,##0.##"/></th>
	                <!-- etc03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_03_5}" pattern="#,##0.##"/></th>
	                <!-- etc02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_02_5}" pattern="#,##0.##"/></th>
	                <!-- etc01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_01_5}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="etcColTotalSum_5" value="${etcMemberTotalSum_12_5 + etcMemberTotalSum_11_5 + etcMemberTotalSum_10_5 + etcMemberTotalSum_09_5 + etcMemberTotalSum_08_5 + etcMemberTotalSum_07_5 + etcMemberTotalSum_06_5 + etcMemberTotalSum_05_5 + etcMemberTotalSum_04_5 + etcMemberTotalSum_03_5 + etcMemberTotalSum_02_5 + etcMemberTotalSum_01_5}"></c:set>
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
   				<!-- 직원별 계를 만들기 위한 변수 -->
   				<c:set var="memberCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 직원명 -->
   				<c:set var="preUserName" value=""></c:set>
   				
   				<!-- 직원별 계 -->
	            <c:set var="etcMemberSum_12_10" value="0"></c:set>
	            <c:set var="etcMemberSum_11_10" value="0"></c:set>
	            <c:set var="etcMemberSum_10_10" value="0"></c:set>
	            <c:set var="etcMemberSum_09_10" value="0"></c:set>
	            <c:set var="etcMemberSum_08_10" value="0"></c:set>
	            <c:set var="etcMemberSum_07_10" value="0"></c:set>
	            <c:set var="etcMemberSum_06_10" value="0"></c:set>
	            <c:set var="etcMemberSum_05_10" value="0"></c:set>
	            <c:set var="etcMemberSum_04_10" value="0"></c:set>
	            <c:set var="etcMemberSum_03_10" value="0"></c:set>
	            <c:set var="etcMemberSum_02_10" value="0"></c:set>
	            <c:set var="etcMemberSum_01_10" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="etcMemberTotalSum_12_10" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_11_10" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_10_10" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_09_10" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_08_10" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_07_10" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_06_10" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_05_10" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_04_10" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_03_10" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_02_10" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_01_10" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="etcColMemberTotalSum_10" value="0"></c:set>
   				    			
    			<c:forEach var="vo1" items="${ptnrStatEtcList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <c:choose>
		    					<c:when test='${srchArg.tabMenu eq "team"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterEtc');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
				                    	1종 심사
				                    </td>
		    					</c:when>
		    					<c:when test='${srchArg.tabMenu eq "member"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterEtc');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
				                    	1종 심사
				                    </td>
		    					</c:when>
		    					<c:otherwise>
		    						<td onclick="goPtnrStatMenu('ptnrStatTeamEtc');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
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
					            <c:set var="etcMemberSum_12_10" value="0"></c:set>
					            <c:set var="etcMemberSum_11_10" value="0"></c:set>
					            <c:set var="etcMemberSum_10_10" value="0"></c:set>
					            <c:set var="etcMemberSum_09_10" value="0"></c:set>
					            <c:set var="etcMemberSum_08_10" value="0"></c:set>
					            <c:set var="etcMemberSum_07_10" value="0"></c:set>
					            <c:set var="etcMemberSum_06_10" value="0"></c:set>
					            <c:set var="etcMemberSum_05_10" value="0"></c:set>
					            <c:set var="etcMemberSum_04_10" value="0"></c:set>
					            <c:set var="etcMemberSum_03_10" value="0"></c:set>
					            <c:set var="etcMemberSum_02_10" value="0"></c:set>
					            <c:set var="etcMemberSum_01_10" value="0"></c:set>
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
		                
		                <!-- 직원별 계 합산 -->
	    				<c:set var="etcMemberSum_12_10" value="${etcMemberSum_12_10+etc12_10}"></c:set>
			            <c:set var="etcMemberSum_11_10" value="${etcMemberSum_11_10+etc11_10}"></c:set>
			            <c:set var="etcMemberSum_10_10" value="${etcMemberSum_10_10+etc10_10}"></c:set>
			            <c:set var="etcMemberSum_09_10" value="${etcMemberSum_09_10+etc09_10}"></c:set>
			            <c:set var="etcMemberSum_08_10" value="${etcMemberSum_08_10+etc08_10}"></c:set>
			            <c:set var="etcMemberSum_07_10" value="${etcMemberSum_07_10+etc07_10}"></c:set>
			            <c:set var="etcMemberSum_06_10" value="${etcMemberSum_06_10+etc06_10}"></c:set>
			            <c:set var="etcMemberSum_05_10" value="${etcMemberSum_05_10+etc05_10}"></c:set>
			            <c:set var="etcMemberSum_04_10" value="${etcMemberSum_04_10+etc04_10}"></c:set>
			            <c:set var="etcMemberSum_03_10" value="${etcMemberSum_03_10+etc03_10}"></c:set>
			            <c:set var="etcMemberSum_02_10" value="${etcMemberSum_02_10+etc02_10}"></c:set>
			            <c:set var="etcMemberSum_01_10" value="${etcMemberSum_01_10+etc01_10}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="etcMemberTotalSum_12_10" value="${etcMemberTotalSum_12_10 + etc12_10}"></c:set>
	                    <c:set var="etcMemberTotalSum_11_10" value="${etcMemberTotalSum_11_10 + etc11_10}"></c:set>
	                    <c:set var="etcMemberTotalSum_10_10" value="${etcMemberTotalSum_10_10 + etc10_10}"></c:set>
	                    <c:set var="etcMemberTotalSum_09_10" value="${etcMemberTotalSum_09_10 + etc09_10}"></c:set>
	                    <c:set var="etcMemberTotalSum_08_10" value="${etcMemberTotalSum_08_10 + etc08_10}"></c:set>
	                    <c:set var="etcMemberTotalSum_07_10" value="${etcMemberTotalSum_07_10 + etc07_10}"></c:set>
	                    <c:set var="etcMemberTotalSum_06_10" value="${etcMemberTotalSum_06_10 + etc06_10}"></c:set>
	                    <c:set var="etcMemberTotalSum_05_10" value="${etcMemberTotalSum_05_10 + etc05_10}"></c:set>
	                    <c:set var="etcMemberTotalSum_04_10" value="${etcMemberTotalSum_04_10 + etc04_10}"></c:set>
	                    <c:set var="etcMemberTotalSum_03_10" value="${etcMemberTotalSum_03_10 + etc03_10}"></c:set>
	                    <c:set var="etcMemberTotalSum_02_10" value="${etcMemberTotalSum_02_10 + etc02_10}"></c:set>
	                    <c:set var="etcMemberTotalSum_01_10" value="${etcMemberTotalSum_01_10 + etc01_10}"></c:set>
		    		</tr>
		    		<!-- 직원별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${memberCnt == vo1.rowCnt and vo1.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- etc12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_12_10}" pattern="#,##0.##"/></td>
			                <!-- etc11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_11_10}" pattern="#,##0.##"/></td>
			                <!-- etc10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_10_10}" pattern="#,##0.##"/></td>
			                <!-- etc09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_09_10}" pattern="#,##0.##"/></td>
			                <!-- etc08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_08_10}" pattern="#,##0.##"/></td>
			                <!-- etc07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_07_10}" pattern="#,##0.##"/></td>
			                <!-- etc06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_06_10}" pattern="#,##0.##"/></td>
			                <!-- etc05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_05_10}" pattern="#,##0.##"/></td>
			                <!-- etc04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_04_10}" pattern="#,##0.##"/></td>
			                <!-- etc03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_03_10}" pattern="#,##0.##"/></td>
			                <!-- etc02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_02_10}" pattern="#,##0.##"/></td>
			                <!-- etc01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_01_10}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="etcMemberColSum_10" value="${etcMemberSum_12_10 + etcMemberSum_11_10 + etcMemberSum_10_10 + etcMemberSum_09_10 + etcMemberSum_08_10 + etcMemberSum_07_10 + etcMemberSum_06_10 + etcMemberSum_05_10 + etcMemberSum_04_10 + etcMemberSum_03_10 + etcMemberSum_02_10 + etcMemberSum_01_10}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberColSum_10}" pattern="#,##0.##"/></td>
			                
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="etcMemberSum_12_10" value="0"></c:set>
				            <c:set var="etcMemberSum_11_10" value="0"></c:set>
				            <c:set var="etcMemberSum_10_10" value="0"></c:set>
				            <c:set var="etcMemberSum_09_10" value="0"></c:set>
				            <c:set var="etcMemberSum_08_10" value="0"></c:set>
				            <c:set var="etcMemberSum_07_10" value="0"></c:set>
				            <c:set var="etcMemberSum_06_10" value="0"></c:set>
				            <c:set var="etcMemberSum_05_10" value="0"></c:set>
				            <c:set var="etcMemberSum_04_10" value="0"></c:set>
				            <c:set var="etcMemberSum_03_10" value="0"></c:set>
				            <c:set var="etcMemberSum_02_10" value="0"></c:set>
				            <c:set var="etcMemberSum_01_10" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo1.rowCnt == 1}">
		    				<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="etcMemberSum_12_10" value="0"></c:set>
				            <c:set var="etcMemberSum_11_10" value="0"></c:set>
				            <c:set var="etcMemberSum_10_10" value="0"></c:set>
				            <c:set var="etcMemberSum_09_10" value="0"></c:set>
				            <c:set var="etcMemberSum_08_10" value="0"></c:set>
				            <c:set var="etcMemberSum_07_10" value="0"></c:set>
				            <c:set var="etcMemberSum_06_10" value="0"></c:set>
				            <c:set var="etcMemberSum_05_10" value="0"></c:set>
				            <c:set var="etcMemberSum_04_10" value="0"></c:set>
				            <c:set var="etcMemberSum_03_10" value="0"></c:set>
				            <c:set var="etcMemberSum_02_10" value="0"></c:set>
				            <c:set var="etcMemberSum_01_10" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 직원별 계 카운트 증가 -->
		    				<c:set var="memberCnt" value="${memberCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 직원별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 심사 소계 시작 -->
		    	<c:if test="${ptnrStatEtcList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 심사 소계</th>
	                <!-- etc12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_12_10}" pattern="#,##0.##"/></th>
	                <!-- etc11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_11_10}" pattern="#,##0.##"/></th>
	                <!-- etc10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_10_10}" pattern="#,##0.##"/></th>
	                <!-- etc09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_09_10}" pattern="#,##0.##"/></th>
	                <!-- etc08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_08_10}" pattern="#,##0.##"/></th>
	                <!-- etc07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_07_10}" pattern="#,##0.##"/></th>
	                <!-- etc06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_06_10}" pattern="#,##0.##"/></th>
	                <!-- etc05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_05_10}" pattern="#,##0.##"/></th>
	                <!-- etc04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_04_10}" pattern="#,##0.##"/></th>
	                <!-- etc03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_03_10}" pattern="#,##0.##"/></th>
	                <!-- etc02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_02_10}" pattern="#,##0.##"/></th>
	                <!-- etc01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_01_10}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="etcColTotalSum_10" value="${etcMemberTotalSum_12_10 + etcMemberTotalSum_11_10 + etcMemberTotalSum_10_10 + etcMemberTotalSum_09_10 + etcMemberTotalSum_08_10 + etcMemberTotalSum_07_10 + etcMemberTotalSum_06_10 + etcMemberTotalSum_05_10 + etcMemberTotalSum_04_10 + etcMemberTotalSum_03_10 + etcMemberTotalSum_02_10 + etcMemberTotalSum_01_10}"></c:set>
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
   				<!-- 직원별 계를 만들기 위한 변수 -->
   				<c:set var="memberCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 직원명 -->
   				<c:set var="preUserName" value=""></c:set>
   				
   				<!-- 직원별 계 -->
	            <c:set var="etcMemberSum_12_15" value="0"></c:set>
	            <c:set var="etcMemberSum_11_15" value="0"></c:set>
	            <c:set var="etcMemberSum_10_15" value="0"></c:set>
	            <c:set var="etcMemberSum_09_15" value="0"></c:set>
	            <c:set var="etcMemberSum_08_15" value="0"></c:set>
	            <c:set var="etcMemberSum_07_15" value="0"></c:set>
	            <c:set var="etcMemberSum_06_15" value="0"></c:set>
	            <c:set var="etcMemberSum_05_15" value="0"></c:set>
	            <c:set var="etcMemberSum_04_15" value="0"></c:set>
	            <c:set var="etcMemberSum_03_15" value="0"></c:set>
	            <c:set var="etcMemberSum_02_15" value="0"></c:set>
	            <c:set var="etcMemberSum_01_15" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="etcMemberTotalSum_12_15" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_11_15" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_10_15" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_09_15" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_08_15" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_07_15" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_06_15" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_05_15" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_04_15" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_03_15" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_02_15" value="0"></c:set>
	            <c:set var="etcMemberTotalSum_01_15" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="etcColMemberTotalSum_15" value="0"></c:set>
   				    			
    			<c:forEach var="vo2" items="${ptnrStatEtcList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <c:choose>
		    					<c:when test='${srchArg.tabMenu eq "team"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterEtc');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
				                    	1종 기타
				                    </td>
		    					</c:when>
		    					<c:when test='${srchArg.tabMenu eq "member"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterEtc');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
				                    	1종 기타
				                    </td>
		    					</c:when>
		    					<c:otherwise>
		    						<td onclick="goPtnrStatMenu('ptnrStatTeamEtc');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
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
					            <c:set var="etcMemberSum_12_15" value="0"></c:set>
					            <c:set var="etcMemberSum_11_15" value="0"></c:set>
					            <c:set var="etcMemberSum_10_15" value="0"></c:set>
					            <c:set var="etcMemberSum_09_15" value="0"></c:set>
					            <c:set var="etcMemberSum_08_15" value="0"></c:set>
					            <c:set var="etcMemberSum_07_15" value="0"></c:set>
					            <c:set var="etcMemberSum_06_15" value="0"></c:set>
					            <c:set var="etcMemberSum_05_15" value="0"></c:set>
					            <c:set var="etcMemberSum_04_15" value="0"></c:set>
					            <c:set var="etcMemberSum_03_15" value="0"></c:set>
					            <c:set var="etcMemberSum_02_15" value="0"></c:set>
					            <c:set var="etcMemberSum_01_15" value="0"></c:set>
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
		                
		                <!-- 직원별 계 합산 -->
	    				<c:set var="etcMemberSum_12_15" value="${etcMemberSum_12_15+etc12_15}"></c:set>
			            <c:set var="etcMemberSum_11_15" value="${etcMemberSum_11_15+etc11_15}"></c:set>
			            <c:set var="etcMemberSum_10_15" value="${etcMemberSum_10_15+etc10_15}"></c:set>
			            <c:set var="etcMemberSum_09_15" value="${etcMemberSum_09_15+etc09_15}"></c:set>
			            <c:set var="etcMemberSum_08_15" value="${etcMemberSum_08_15+etc08_15}"></c:set>
			            <c:set var="etcMemberSum_07_15" value="${etcMemberSum_07_15+etc07_15}"></c:set>
			            <c:set var="etcMemberSum_06_15" value="${etcMemberSum_06_15+etc06_15}"></c:set>
			            <c:set var="etcMemberSum_05_15" value="${etcMemberSum_05_15+etc05_15}"></c:set>
			            <c:set var="etcMemberSum_04_15" value="${etcMemberSum_04_15+etc04_15}"></c:set>
			            <c:set var="etcMemberSum_03_15" value="${etcMemberSum_03_15+etc03_15}"></c:set>
			            <c:set var="etcMemberSum_02_15" value="${etcMemberSum_02_15+etc02_15}"></c:set>
			            <c:set var="etcMemberSum_01_15" value="${etcMemberSum_01_15+etc01_15}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="etcMemberTotalSum_12_15" value="${etcMemberTotalSum_12_15 + etc12_15}"></c:set>
	                    <c:set var="etcMemberTotalSum_11_15" value="${etcMemberTotalSum_11_15 + etc11_15}"></c:set>
	                    <c:set var="etcMemberTotalSum_10_15" value="${etcMemberTotalSum_10_15 + etc10_15}"></c:set>
	                    <c:set var="etcMemberTotalSum_09_15" value="${etcMemberTotalSum_09_15 + etc09_15}"></c:set>
	                    <c:set var="etcMemberTotalSum_08_15" value="${etcMemberTotalSum_08_15 + etc08_15}"></c:set>
	                    <c:set var="etcMemberTotalSum_07_15" value="${etcMemberTotalSum_07_15 + etc07_15}"></c:set>
	                    <c:set var="etcMemberTotalSum_06_15" value="${etcMemberTotalSum_06_15 + etc06_15}"></c:set>
	                    <c:set var="etcMemberTotalSum_05_15" value="${etcMemberTotalSum_05_15 + etc05_15}"></c:set>
	                    <c:set var="etcMemberTotalSum_04_15" value="${etcMemberTotalSum_04_15 + etc04_15}"></c:set>
	                    <c:set var="etcMemberTotalSum_03_15" value="${etcMemberTotalSum_03_15 + etc03_15}"></c:set>
	                    <c:set var="etcMemberTotalSum_02_15" value="${etcMemberTotalSum_02_15 + etc02_15}"></c:set>
	                    <c:set var="etcMemberTotalSum_01_15" value="${etcMemberTotalSum_01_15 + etc01_15}"></c:set>
		    		</tr>
		    		<!-- 직원별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${memberCnt == vo2.rowCnt and vo2.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- etc12 -->
			                <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_12_15}" pattern="#,##0.##"/></td>
			                <!-- etc11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_11_15}" pattern="#,##0.##"/></td>
			                <!-- etc10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_10_15}" pattern="#,##0.##"/></td>
			                <!-- etc09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_09_15}" pattern="#,##0.##"/></td>
			                <!-- etc08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_08_15}" pattern="#,##0.##"/></td>
			                <!-- etc07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_07_15}" pattern="#,##0.##"/></td>
			                <!-- etc06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_06_15}" pattern="#,##0.##"/></td>
			                <!-- etc05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_05_15}" pattern="#,##0.##"/></td>
			                <!-- etc04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_04_15}" pattern="#,##0.##"/></td>
			                <!-- etc03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_03_15}" pattern="#,##0.##"/></td>
			                <!-- etc02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_02_15}" pattern="#,##0.##"/></td>
			                <!-- etc01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberSum_01_15}" pattern="#,##0.##"/></td>
			                <!-- 가로 합계 -->
			                <c:set var="etcMemberColSum_15" value="${etcMemberSum_12_15 + etcMemberSum_11_15 + etcMemberSum_10_15 + etcMemberSum_09_15 + etcMemberSum_08_15 + etcMemberSum_07_15 + etcMemberSum_06_15 + etcMemberSum_05_15 + etcMemberSum_04_15 + etcMemberSum_03_15 + etcMemberSum_02_15 + etcMemberSum_01_15}"></c:set>                    
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${etcMemberColSum_15}" pattern="#,##0.##"/></td>
			                
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="etcMemberSum_12_15" value="0"></c:set>
				            <c:set var="etcMemberSum_11_15" value="0"></c:set>
				            <c:set var="etcMemberSum_10_15" value="0"></c:set>
				            <c:set var="etcMemberSum_09_15" value="0"></c:set>
				            <c:set var="etcMemberSum_08_15" value="0"></c:set>
				            <c:set var="etcMemberSum_07_15" value="0"></c:set>
				            <c:set var="etcMemberSum_06_15" value="0"></c:set>
				            <c:set var="etcMemberSum_05_15" value="0"></c:set>
				            <c:set var="etcMemberSum_04_15" value="0"></c:set>
				            <c:set var="etcMemberSum_03_15" value="0"></c:set>
				            <c:set var="etcMemberSum_02_15" value="0"></c:set>
				            <c:set var="etcMemberSum_01_15" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo2.rowCnt == 1}">
		    				<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="etcMemberSum_12_15" value="0"></c:set>
				            <c:set var="etcMemberSum_11_15" value="0"></c:set>
				            <c:set var="etcMemberSum_10_15" value="0"></c:set>
				            <c:set var="etcMemberSum_09_15" value="0"></c:set>
				            <c:set var="etcMemberSum_08_15" value="0"></c:set>
				            <c:set var="etcMemberSum_07_15" value="0"></c:set>
				            <c:set var="etcMemberSum_06_15" value="0"></c:set>
				            <c:set var="etcMemberSum_05_15" value="0"></c:set>
				            <c:set var="etcMemberSum_04_15" value="0"></c:set>
				            <c:set var="etcMemberSum_03_15" value="0"></c:set>
				            <c:set var="etcMemberSum_02_15" value="0"></c:set>
				            <c:set var="etcMemberSum_01_15" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 직원별 계 카운트 증가 -->
		    				<c:set var="memberCnt" value="${memberCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 직원별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 기타 소계 시작 -->
		    	<c:if test="${ptnrStatEtcList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 기타 소계</th>
	                <!-- etc12 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_12_15}" pattern="#,##0.##"/></th>
	                <!-- etc11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_11_15}" pattern="#,##0.##"/></th>
	                <!-- etc10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_10_15}" pattern="#,##0.##"/></th>
	                <!-- etc09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_09_15}" pattern="#,##0.##"/></th>
	                <!-- etc08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_08_15}" pattern="#,##0.##"/></th>
	                <!-- etc07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_07_15}" pattern="#,##0.##"/></th>
	                <!-- etc06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_06_15}" pattern="#,##0.##"/></th>
	                <!-- etc05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_05_15}" pattern="#,##0.##"/></th>
	                <!-- etc04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_04_15}" pattern="#,##0.##"/></th>
	                <!-- etc03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_03_15}" pattern="#,##0.##"/></th>
	                <!-- etc02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_02_15}" pattern="#,##0.##"/></th>
	                <!-- etc01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${etcMemberTotalSum_01_15}" pattern="#,##0.##"/></th>
	                <!-- 가로열 합계 -->
	                <c:set var="etcColTotalSum_15" value="${etcMemberTotalSum_12_15 + etcMemberTotalSum_11_15 + etcMemberTotalSum_10_15 + etcMemberTotalSum_09_15 + etcMemberTotalSum_08_15 + etcMemberTotalSum_07_15 + etcMemberTotalSum_06_15 + etcMemberTotalSum_05_15 + etcMemberTotalSum_04_15 + etcMemberTotalSum_03_15 + etcMemberTotalSum_02_15 + etcMemberTotalSum_01_15}"></c:set>
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
    <c:set var="etcMemberTotalSum_12_all" value="${etcMemberTotalSum_12_5 + etcMemberTotalSum_12_10 + etcMemberTotalSum_12_15}"></c:set>
    <c:set var="etcMemberTotalSum_11_all" value="${etcMemberTotalSum_11_5 + etcMemberTotalSum_11_10 + etcMemberTotalSum_11_15}"></c:set>
    <c:set var="etcMemberTotalSum_10_all" value="${etcMemberTotalSum_10_5 + etcMemberTotalSum_10_10 + etcMemberTotalSum_10_15}"></c:set>
    <c:set var="etcMemberTotalSum_09_all" value="${etcMemberTotalSum_09_5 + etcMemberTotalSum_09_10 + etcMemberTotalSum_09_15}"></c:set>
    <c:set var="etcMemberTotalSum_08_all" value="${etcMemberTotalSum_08_5 + etcMemberTotalSum_08_10 + etcMemberTotalSum_08_15}"></c:set>
    <c:set var="etcMemberTotalSum_07_all" value="${etcMemberTotalSum_07_5 + etcMemberTotalSum_07_10 + etcMemberTotalSum_07_15}"></c:set>
    <c:set var="etcMemberTotalSum_06_all" value="${etcMemberTotalSum_06_5 + etcMemberTotalSum_06_10 + etcMemberTotalSum_06_15}"></c:set>
    <c:set var="etcMemberTotalSum_05_all" value="${etcMemberTotalSum_05_5 + etcMemberTotalSum_05_10 + etcMemberTotalSum_05_15}"></c:set>
    <c:set var="etcMemberTotalSum_04_all" value="${etcMemberTotalSum_04_5 + etcMemberTotalSum_04_10 + etcMemberTotalSum_04_15}"></c:set>
    <c:set var="etcMemberTotalSum_03_all" value="${etcMemberTotalSum_03_5 + etcMemberTotalSum_03_10 + etcMemberTotalSum_03_15}"></c:set>
    <c:set var="etcMemberTotalSum_02_all" value="${etcMemberTotalSum_02_5 + etcMemberTotalSum_02_10 + etcMemberTotalSum_02_15}"></c:set>
    <c:set var="etcMemberTotalSum_01_all" value="${etcMemberTotalSum_01_5 + etcMemberTotalSum_01_10 + etcMemberTotalSum_01_15}"></c:set>        
    <c:set var="etcMemberTotalSum_col_all" value="${etcMemberTotalSum_12_all + etcMemberTotalSum_11_all + etcMemberTotalSum_10_all + etcMemberTotalSum_09_all + etcMemberTotalSum_08_all + etcMemberTotalSum_07_all + etcMemberTotalSum_06_all + etcMemberTotalSum_05_all + etcMemberTotalSum_04_all + etcMemberTotalSum_03_all + etcMemberTotalSum_02_all + etcMemberTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체합계</th>    			
    			<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcMemberTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcMemberTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcMemberTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcMemberTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcMemberTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcMemberTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcMemberTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcMemberTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcMemberTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcMemberTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcMemberTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcMemberTotalSum_01_all}" pattern="#,##0.##"/></th>
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${etcMemberTotalSum_col_all}" pattern="#,##0.##"/></th>    			
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>