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
	            <c:set var="endCenterSum_12_5" value="0"></c:set>
	            <c:set var="endCenterSum_11_5" value="0"></c:set>
	            <c:set var="endCenterSum_10_5" value="0"></c:set>
	            <c:set var="endCenterSum_09_5" value="0"></c:set>
	            <c:set var="endCenterSum_08_5" value="0"></c:set>
	            <c:set var="endCenterSum_07_5" value="0"></c:set>
	            <c:set var="endCenterSum_06_5" value="0"></c:set>
	            <c:set var="endCenterSum_05_5" value="0"></c:set>
	            <c:set var="endCenterSum_04_5" value="0"></c:set>
	            <c:set var="endCenterSum_03_5" value="0"></c:set>
	            <c:set var="endCenterSum_02_5" value="0"></c:set>
	            <c:set var="endCenterSum_01_5" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="endCenterTotalSum_12_5" value="0"></c:set>
	            <c:set var="endCenterTotalSum_11_5" value="0"></c:set>
	            <c:set var="endCenterTotalSum_10_5" value="0"></c:set>
	            <c:set var="endCenterTotalSum_09_5" value="0"></c:set>
	            <c:set var="endCenterTotalSum_08_5" value="0"></c:set>
	            <c:set var="endCenterTotalSum_07_5" value="0"></c:set>
	            <c:set var="endCenterTotalSum_06_5" value="0"></c:set>
	            <c:set var="endCenterTotalSum_05_5" value="0"></c:set>
	            <c:set var="endCenterTotalSum_04_5" value="0"></c:set>
	            <c:set var="endCenterTotalSum_03_5" value="0"></c:set>
	            <c:set var="endCenterTotalSum_02_5" value="0"></c:set>
	            <c:set var="endCenterTotalSum_01_5" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="endColCenterTotalSum_5" value="0"></c:set>
   				    			
    			<c:forEach var="vo" items="${ptnrStatEndList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatEnd');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
		                    	1종 조사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo.rowCnt == 1}">
		                		<%-- <td colspan="2" onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:300px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td> --%>		                		
		                		<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>
		                		<td style="width:150px;">${vo.ptnrIdSubNm}</td>
		                		<!-- 센터별 계 초기화 -->
					            <c:set var="endCenterSum_12_5" value="0"></c:set>
					            <c:set var="endCenterSum_11_5" value="0"></c:set>
					            <c:set var="endCenterSum_10_5" value="0"></c:set>
					            <c:set var="endCenterSum_09_5" value="0"></c:set>
					            <c:set var="endCenterSum_08_5" value="0"></c:set>
					            <c:set var="endCenterSum_07_5" value="0"></c:set>
					            <c:set var="endCenterSum_06_5" value="0"></c:set>
					            <c:set var="endCenterSum_05_5" value="0"></c:set>
					            <c:set var="endCenterSum_04_5" value="0"></c:set>
					            <c:set var="endCenterSum_03_5" value="0"></c:set>
					            <c:set var="endCenterSum_02_5" value="0"></c:set>
					            <c:set var="endCenterSum_01_5" value="0"></c:set>
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
			    		<c:set var="end12_5" value="${vo.end12}"></c:set>
			            <c:set var="end11_5" value="${vo.end11}"></c:set>
			            <c:set var="end10_5" value="${vo.end10}"></c:set>
			            <c:set var="end09_5" value="${vo.end09}"></c:set>
			            <c:set var="end08_5" value="${vo.end08}"></c:set>
			            <c:set var="end07_5" value="${vo.end07}"></c:set>
			            <c:set var="end06_5" value="${vo.end06}"></c:set>
			            <c:set var="end05_5" value="${vo.end05}"></c:set>
			            <c:set var="end04_5" value="${vo.end04}"></c:set>
			            <c:set var="end03_5" value="${vo.end03}"></c:set>
			            <c:set var="end02_5" value="${vo.end02}"></c:set>
			            <c:set var="end01_5" value="${vo.end01}"></c:set>
			            
			            <!-- end12 -->
		                <td style="width: 80px; border-left:0.2em solid #b9b9b9 !important;">${end12_5}</td>
		                <!-- end11 -->
		                <td style="width: 80px;">${end11_5}</td>
		                <!-- end10 -->
		                <td style="width: 80px;">${end10_5}</td>
		                <!-- end09 -->
		                <td style="width: 80px;">${end09_5}</td>
		                <!-- end08 -->
		                <td style="width: 80px;">${end08_5}</td>
		                <!-- end07 -->
		                <td style="width: 80px;">${end07_5}</td>
		                <!-- end06 -->
		                <td style="width: 80px;">${end06_5}</td>
		                <!-- end05 -->
		                <td style="width: 80px;">${end05_5}</td>
		                <!-- end04 -->
		                <td style="width: 80px;">${end04_5}</td>
		                <!-- end03 -->
		                <td style="width: 80px;">${end03_5}</td>
		                <!-- end02 -->
		                <td style="width: 80px;">${end02_5}</td>
		                <!-- end01 -->
		                <td style="width: 80px;">${end01_5}</td>
		                <!-- 가로 합계 -->
		                <c:set var="endColSum_5" value="${end12_5 + end11_5 + end10_5 + end09_5 + end08_5 + end07_5 + end06_5 + end05_5 + end04_5 + end03_5 + end02_5 + end01_5}"></c:set>                    
		                <td style="width: 80px;">${endColSum_5}</td>
		                
		                <!-- 센터별 계 합산 -->
	    				<c:set var="endCenterSum_12_5" value="${endCenterSum_12_5+end12_5}"></c:set>
			            <c:set var="endCenterSum_11_5" value="${endCenterSum_11_5+end11_5}"></c:set>
			            <c:set var="endCenterSum_10_5" value="${endCenterSum_10_5+end10_5}"></c:set>
			            <c:set var="endCenterSum_09_5" value="${endCenterSum_09_5+end09_5}"></c:set>
			            <c:set var="endCenterSum_08_5" value="${endCenterSum_08_5+end08_5}"></c:set>
			            <c:set var="endCenterSum_07_5" value="${endCenterSum_07_5+end07_5}"></c:set>
			            <c:set var="endCenterSum_06_5" value="${endCenterSum_06_5+end06_5}"></c:set>
			            <c:set var="endCenterSum_05_5" value="${endCenterSum_05_5+end05_5}"></c:set>
			            <c:set var="endCenterSum_04_5" value="${endCenterSum_04_5+end04_5}"></c:set>
			            <c:set var="endCenterSum_03_5" value="${endCenterSum_03_5+end03_5}"></c:set>
			            <c:set var="endCenterSum_02_5" value="${endCenterSum_02_5+end02_5}"></c:set>
			            <c:set var="endCenterSum_01_5" value="${endCenterSum_01_5+end01_5}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="endCenterTotalSum_12_5" value="${endCenterTotalSum_12_5 + end12_5}"></c:set>
	                    <c:set var="endCenterTotalSum_11_5" value="${endCenterTotalSum_11_5 + end11_5}"></c:set>
	                    <c:set var="endCenterTotalSum_10_5" value="${endCenterTotalSum_10_5 + end10_5}"></c:set>
	                    <c:set var="endCenterTotalSum_09_5" value="${endCenterTotalSum_09_5 + end09_5}"></c:set>
	                    <c:set var="endCenterTotalSum_08_5" value="${endCenterTotalSum_08_5 + end08_5}"></c:set>
	                    <c:set var="endCenterTotalSum_07_5" value="${endCenterTotalSum_07_5 + end07_5}"></c:set>
	                    <c:set var="endCenterTotalSum_06_5" value="${endCenterTotalSum_06_5 + end06_5}"></c:set>
	                    <c:set var="endCenterTotalSum_05_5" value="${endCenterTotalSum_05_5 + end05_5}"></c:set>
	                    <c:set var="endCenterTotalSum_04_5" value="${endCenterTotalSum_04_5 + end04_5}"></c:set>
	                    <c:set var="endCenterTotalSum_03_5" value="${endCenterTotalSum_03_5 + end03_5}"></c:set>
	                    <c:set var="endCenterTotalSum_02_5" value="${endCenterTotalSum_02_5 + end02_5}"></c:set>
	                    <c:set var="endCenterTotalSum_01_5" value="${endCenterTotalSum_01_5 + end01_5}"></c:set>
		    		</tr>
		    		<!-- 센터별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${centerCnt == vo.rowCnt and vo.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- end12 -->
			                <td style="width: 80px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2">${endCenterSum_12_5}</td>
			                <!-- end11 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_11_5}</td>
			                <!-- end10 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_10_5}</td>
			                <!-- end09 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_09_5}</td>
			                <!-- end08 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_08_5}</td>
			                <!-- end07 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_07_5}</td>
			                <!-- end06 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_06_5}</td>
			                <!-- end05 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_05_5}</td>
			                <!-- end04 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_04_5}</td>
			                <!-- end03 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_03_5}</td>
			                <!-- end02 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_02_5}</td>
			                <!-- end01 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_01_5}</td>
			                <!-- 가로 합계 -->
			                <c:set var="endCenterColSum_5" value="${endCenterSum_12_5 + endCenterSum_11_5 + endCenterSum_10_5 + endCenterSum_09_5 + endCenterSum_08_5 + endCenterSum_07_5 + endCenterSum_06_5 + endCenterSum_05_5 + endCenterSum_04_5 + endCenterSum_03_5 + endCenterSum_02_5 + endCenterSum_01_5}"></c:set>                    
			                <td style="width: 80px;" class="sum-level-2">${endCenterColSum_5}</td>
			                
							<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>										                		    				
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="endCenterSum_12_5" value="0"></c:set>
				            <c:set var="endCenterSum_11_5" value="0"></c:set>
				            <c:set var="endCenterSum_10_5" value="0"></c:set>
				            <c:set var="endCenterSum_09_5" value="0"></c:set>
				            <c:set var="endCenterSum_08_5" value="0"></c:set>
				            <c:set var="endCenterSum_07_5" value="0"></c:set>
				            <c:set var="endCenterSum_06_5" value="0"></c:set>
				            <c:set var="endCenterSum_05_5" value="0"></c:set>
				            <c:set var="endCenterSum_04_5" value="0"></c:set>
				            <c:set var="endCenterSum_03_5" value="0"></c:set>
				            <c:set var="endCenterSum_02_5" value="0"></c:set>
				            <c:set var="endCenterSum_01_5" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo.rowCnt == 1}">
		    				<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="endCenterSum_12_5" value="0"></c:set>
				            <c:set var="endCenterSum_11_5" value="0"></c:set>
				            <c:set var="endCenterSum_10_5" value="0"></c:set>
				            <c:set var="endCenterSum_09_5" value="0"></c:set>
				            <c:set var="endCenterSum_08_5" value="0"></c:set>
				            <c:set var="endCenterSum_07_5" value="0"></c:set>
				            <c:set var="endCenterSum_06_5" value="0"></c:set>
				            <c:set var="endCenterSum_05_5" value="0"></c:set>
				            <c:set var="endCenterSum_04_5" value="0"></c:set>
				            <c:set var="endCenterSum_03_5" value="0"></c:set>
				            <c:set var="endCenterSum_02_5" value="0"></c:set>
				            <c:set var="endCenterSum_01_5" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 센터별 계 카운트 증가 -->
		    				<c:set var="centerCnt" value="${centerCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 센터별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 조사 소계 시작 -->
		    	<c:if test="${ptnrStatEndList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 조사 소계</th>
	                <!-- end12 -->
	                <th>${endCenterTotalSum_12_5}</th>
	                <!-- end11 -->
	                <th>${endCenterTotalSum_11_5}</th>
	                <!-- end10 -->
	                <th>${endCenterTotalSum_10_5}</th>
	                <!-- end09 -->
	                <th>${endCenterTotalSum_09_5}</th>
	                <!-- end08 -->
	                <th>${endCenterTotalSum_08_5}</th>
	                <!-- end07 -->
	                <th>${endCenterTotalSum_07_5}</th>
	                <!-- end06 -->
	                <th>${endCenterTotalSum_06_5}</th>
	                <!-- end05 -->
	                <th>${endCenterTotalSum_05_5}</th>
	                <!-- end04 -->
	                <th>${endCenterTotalSum_04_5}</th>
	                <!-- end03 -->
	                <th>${endCenterTotalSum_03_5}</th>
	                <!-- end02 -->
	                <th>${endCenterTotalSum_02_5}</th>
	                <!-- end01 -->
	                <th>${endCenterTotalSum_01_5}</th>
	                <!-- 가로열 합계 -->
	                <c:set var="endColTotalSum_5" value="${endCenterTotalSum_12_5 + endCenterTotalSum_11_5 + endCenterTotalSum_10_5 + endCenterTotalSum_09_5 + endCenterTotalSum_08_5 + endCenterTotalSum_07_5 + endCenterTotalSum_06_5 + endCenterTotalSum_05_5 + endCenterTotalSum_04_5 + endCenterTotalSum_03_5 + endCenterTotalSum_02_5 + endCenterTotalSum_01_5}"></c:set>
	                <th>${endColTotalSum_5}</th>
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
	            <c:set var="endCenterSum_12_10" value="0"></c:set>
	            <c:set var="endCenterSum_11_10" value="0"></c:set>
	            <c:set var="endCenterSum_10_10" value="0"></c:set>
	            <c:set var="endCenterSum_09_10" value="0"></c:set>
	            <c:set var="endCenterSum_08_10" value="0"></c:set>
	            <c:set var="endCenterSum_07_10" value="0"></c:set>
	            <c:set var="endCenterSum_06_10" value="0"></c:set>
	            <c:set var="endCenterSum_05_10" value="0"></c:set>
	            <c:set var="endCenterSum_04_10" value="0"></c:set>
	            <c:set var="endCenterSum_03_10" value="0"></c:set>
	            <c:set var="endCenterSum_02_10" value="0"></c:set>
	            <c:set var="endCenterSum_01_10" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="endCenterTotalSum_12_10" value="0"></c:set>
	            <c:set var="endCenterTotalSum_11_10" value="0"></c:set>
	            <c:set var="endCenterTotalSum_10_10" value="0"></c:set>
	            <c:set var="endCenterTotalSum_09_10" value="0"></c:set>
	            <c:set var="endCenterTotalSum_08_10" value="0"></c:set>
	            <c:set var="endCenterTotalSum_07_10" value="0"></c:set>
	            <c:set var="endCenterTotalSum_06_10" value="0"></c:set>
	            <c:set var="endCenterTotalSum_05_10" value="0"></c:set>
	            <c:set var="endCenterTotalSum_04_10" value="0"></c:set>
	            <c:set var="endCenterTotalSum_03_10" value="0"></c:set>
	            <c:set var="endCenterTotalSum_02_10" value="0"></c:set>
	            <c:set var="endCenterTotalSum_01_10" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="endColCenterTotalSum_10" value="0"></c:set>
   				    			
    			<c:forEach var="vo1" items="${ptnrStatEndList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatEnd');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
		                    	1종 심사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo1.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>
		                		<td style="width:150px;">${vo1.ptnrIdSubNm}</td>
		                		<!-- 센터별 계 초기화 -->
					            <c:set var="endCenterSum_12_10" value="0"></c:set>
					            <c:set var="endCenterSum_11_10" value="0"></c:set>
					            <c:set var="endCenterSum_10_10" value="0"></c:set>
					            <c:set var="endCenterSum_09_10" value="0"></c:set>
					            <c:set var="endCenterSum_08_10" value="0"></c:set>
					            <c:set var="endCenterSum_07_10" value="0"></c:set>
					            <c:set var="endCenterSum_06_10" value="0"></c:set>
					            <c:set var="endCenterSum_05_10" value="0"></c:set>
					            <c:set var="endCenterSum_04_10" value="0"></c:set>
					            <c:set var="endCenterSum_03_10" value="0"></c:set>
					            <c:set var="endCenterSum_02_10" value="0"></c:set>
					            <c:set var="endCenterSum_01_10" value="0"></c:set>
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
			    		<c:set var="end12_10" value="${vo1.end12}"></c:set>
			            <c:set var="end11_10" value="${vo1.end11}"></c:set>
			            <c:set var="end10_10" value="${vo1.end10}"></c:set>
			            <c:set var="end09_10" value="${vo1.end09}"></c:set>
			            <c:set var="end08_10" value="${vo1.end08}"></c:set>
			            <c:set var="end07_10" value="${vo1.end07}"></c:set>
			            <c:set var="end06_10" value="${vo1.end06}"></c:set>
			            <c:set var="end05_10" value="${vo1.end05}"></c:set>
			            <c:set var="end04_10" value="${vo1.end04}"></c:set>
			            <c:set var="end03_10" value="${vo1.end03}"></c:set>
			            <c:set var="end02_10" value="${vo1.end02}"></c:set>
			            <c:set var="end01_10" value="${vo1.end01}"></c:set>
			            
			            <!-- end12 -->
		                <td style="width: 80px; border-left:0.2em solid #b9b9b9 !important;">${end12_10}</td>
		                <!-- end11 -->
		                <td style="width: 80px;">${end11_10}</td>
		                <!-- end10 -->
		                <td style="width: 80px;">${end10_10}</td>
		                <!-- end09 -->
		                <td style="width: 80px;">${end09_10}</td>
		                <!-- end08 -->
		                <td style="width: 80px;">${end08_10}</td>
		                <!-- end07 -->
		                <td style="width: 80px;">${end07_10}</td>
		                <!-- end06 -->
		                <td style="width: 80px;">${end06_10}</td>
		                <!-- end05 -->
		                <td style="width: 80px;">${end05_10}</td>
		                <!-- end04 -->
		                <td style="width: 80px;">${end04_10}</td>
		                <!-- end03 -->
		                <td style="width: 80px;">${end03_10}</td>
		                <!-- end02 -->
		                <td style="width: 80px;">${end02_10}</td>
		                <!-- end01 -->
		                <td style="width: 80px;">${end01_10}</td>
		                <!-- 가로 합계 -->
		                <c:set var="endColSum_10" value="${end12_10 + end11_10 + end10_10 + end09_10 + end08_10 + end07_10 + end06_10 + end05_10 + end04_10 + end03_10 + end02_10 + end01_10}"></c:set>                    
		                <td style="width: 80px;">${endColSum_10}</td>
		                
		                <!-- 센터별 계 합산 -->
	    				<c:set var="endCenterSum_12_10" value="${endCenterSum_12_10+end12_10}"></c:set>
			            <c:set var="endCenterSum_11_10" value="${endCenterSum_11_10+end11_10}"></c:set>
			            <c:set var="endCenterSum_10_10" value="${endCenterSum_10_10+end10_10}"></c:set>
			            <c:set var="endCenterSum_09_10" value="${endCenterSum_09_10+end09_10}"></c:set>
			            <c:set var="endCenterSum_08_10" value="${endCenterSum_08_10+end08_10}"></c:set>
			            <c:set var="endCenterSum_07_10" value="${endCenterSum_07_10+end07_10}"></c:set>
			            <c:set var="endCenterSum_06_10" value="${endCenterSum_06_10+end06_10}"></c:set>
			            <c:set var="endCenterSum_05_10" value="${endCenterSum_05_10+end05_10}"></c:set>
			            <c:set var="endCenterSum_04_10" value="${endCenterSum_04_10+end04_10}"></c:set>
			            <c:set var="endCenterSum_03_10" value="${endCenterSum_03_10+end03_10}"></c:set>
			            <c:set var="endCenterSum_02_10" value="${endCenterSum_02_10+end02_10}"></c:set>
			            <c:set var="endCenterSum_01_10" value="${endCenterSum_01_10+end01_10}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="endCenterTotalSum_12_10" value="${endCenterTotalSum_12_10 + end12_10}"></c:set>
	                    <c:set var="endCenterTotalSum_11_10" value="${endCenterTotalSum_11_10 + end11_10}"></c:set>
	                    <c:set var="endCenterTotalSum_10_10" value="${endCenterTotalSum_10_10 + end10_10}"></c:set>
	                    <c:set var="endCenterTotalSum_09_10" value="${endCenterTotalSum_09_10 + end09_10}"></c:set>
	                    <c:set var="endCenterTotalSum_08_10" value="${endCenterTotalSum_08_10 + end08_10}"></c:set>
	                    <c:set var="endCenterTotalSum_07_10" value="${endCenterTotalSum_07_10 + end07_10}"></c:set>
	                    <c:set var="endCenterTotalSum_06_10" value="${endCenterTotalSum_06_10 + end06_10}"></c:set>
	                    <c:set var="endCenterTotalSum_05_10" value="${endCenterTotalSum_05_10 + end05_10}"></c:set>
	                    <c:set var="endCenterTotalSum_04_10" value="${endCenterTotalSum_04_10 + end04_10}"></c:set>
	                    <c:set var="endCenterTotalSum_03_10" value="${endCenterTotalSum_03_10 + end03_10}"></c:set>
	                    <c:set var="endCenterTotalSum_02_10" value="${endCenterTotalSum_02_10 + end02_10}"></c:set>
	                    <c:set var="endCenterTotalSum_01_10" value="${endCenterTotalSum_01_10 + end01_10}"></c:set>
		    		</tr>
		    		<!-- 센터별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${centerCnt == vo1.rowCnt and vo1.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- end12 -->
			                <td style="width: 80px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2">${endCenterSum_12_10}</td>
			                <!-- end11 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_11_10}</td>
			                <!-- end10 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_10_10}</td>
			                <!-- end09 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_09_10}</td>
			                <!-- end08 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_08_10}</td>
			                <!-- end07 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_07_10}</td>
			                <!-- end06 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_06_10}</td>
			                <!-- end05 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_05_10}</td>
			                <!-- end04 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_04_10}</td>
			                <!-- end03 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_03_10}</td>
			                <!-- end02 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_02_10}</td>
			                <!-- end01 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_01_10}</td>
			                <!-- 가로 합계 -->
			                <c:set var="endCenterColSum_10" value="${endCenterSum_12_10 + endCenterSum_11_10 + endCenterSum_10_10 + endCenterSum_09_10 + endCenterSum_08_10 + endCenterSum_07_10 + endCenterSum_06_10 + endCenterSum_05_10 + endCenterSum_04_10 + endCenterSum_03_10 + endCenterSum_02_10 + endCenterSum_01_10}"></c:set>                    
			                <td style="width: 80px;" class="sum-level-2">${endCenterColSum_10}</td>
			                
							<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>										                		    				
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="endCenterSum_12_10" value="0"></c:set>
				            <c:set var="endCenterSum_11_10" value="0"></c:set>
				            <c:set var="endCenterSum_10_10" value="0"></c:set>
				            <c:set var="endCenterSum_09_10" value="0"></c:set>
				            <c:set var="endCenterSum_08_10" value="0"></c:set>
				            <c:set var="endCenterSum_07_10" value="0"></c:set>
				            <c:set var="endCenterSum_06_10" value="0"></c:set>
				            <c:set var="endCenterSum_05_10" value="0"></c:set>
				            <c:set var="endCenterSum_04_10" value="0"></c:set>
				            <c:set var="endCenterSum_03_10" value="0"></c:set>
				            <c:set var="endCenterSum_02_10" value="0"></c:set>
				            <c:set var="endCenterSum_01_10" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo1.rowCnt == 1}">
		    				<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="endCenterSum_12_10" value="0"></c:set>
				            <c:set var="endCenterSum_11_10" value="0"></c:set>
				            <c:set var="endCenterSum_10_10" value="0"></c:set>
				            <c:set var="endCenterSum_09_10" value="0"></c:set>
				            <c:set var="endCenterSum_08_10" value="0"></c:set>
				            <c:set var="endCenterSum_07_10" value="0"></c:set>
				            <c:set var="endCenterSum_06_10" value="0"></c:set>
				            <c:set var="endCenterSum_05_10" value="0"></c:set>
				            <c:set var="endCenterSum_04_10" value="0"></c:set>
				            <c:set var="endCenterSum_03_10" value="0"></c:set>
				            <c:set var="endCenterSum_02_10" value="0"></c:set>
				            <c:set var="endCenterSum_01_10" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 센터별 계 카운트 증가 -->
		    				<c:set var="centerCnt" value="${centerCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 센터별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 심사 소계 시작 -->
		    	<c:if test="${ptnrStatEndList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 심사 소계</th>
	                <!-- end12 -->
	                <th>${endCenterTotalSum_12_10}</th>
	                <!-- end11 -->
	                <th>${endCenterTotalSum_11_10}</th>
	                <!-- end10 -->
	                <th>${endCenterTotalSum_10_10}</th>
	                <!-- end09 -->
	                <th>${endCenterTotalSum_09_10}</th>
	                <!-- end08 -->
	                <th>${endCenterTotalSum_08_10}</th>
	                <!-- end07 -->
	                <th>${endCenterTotalSum_07_10}</th>
	                <!-- end06 -->
	                <th>${endCenterTotalSum_06_10}</th>
	                <!-- end05 -->
	                <th>${endCenterTotalSum_05_10}</th>
	                <!-- end04 -->
	                <th>${endCenterTotalSum_04_10}</th>
	                <!-- end03 -->
	                <th>${endCenterTotalSum_03_10}</th>
	                <!-- end02 -->
	                <th>${endCenterTotalSum_02_10}</th>
	                <!-- end01 -->
	                <th>${endCenterTotalSum_01_10}</th>
	                <!-- 가로열 합계 -->
	                <c:set var="endColTotalSum_10" value="${endCenterTotalSum_12_10 + endCenterTotalSum_11_10 + endCenterTotalSum_10_10 + endCenterTotalSum_09_10 + endCenterTotalSum_08_10 + endCenterTotalSum_07_10 + endCenterTotalSum_06_10 + endCenterTotalSum_05_10 + endCenterTotalSum_04_10 + endCenterTotalSum_03_10 + endCenterTotalSum_02_10 + endCenterTotalSum_01_10}"></c:set>
	                <th>${endColTotalSum_10}</th>
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
	            <c:set var="endCenterSum_12_15" value="0"></c:set>
	            <c:set var="endCenterSum_11_15" value="0"></c:set>
	            <c:set var="endCenterSum_10_15" value="0"></c:set>
	            <c:set var="endCenterSum_09_15" value="0"></c:set>
	            <c:set var="endCenterSum_08_15" value="0"></c:set>
	            <c:set var="endCenterSum_07_15" value="0"></c:set>
	            <c:set var="endCenterSum_06_15" value="0"></c:set>
	            <c:set var="endCenterSum_05_15" value="0"></c:set>
	            <c:set var="endCenterSum_04_15" value="0"></c:set>
	            <c:set var="endCenterSum_03_15" value="0"></c:set>
	            <c:set var="endCenterSum_02_15" value="0"></c:set>
	            <c:set var="endCenterSum_01_15" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="endCenterTotalSum_12_15" value="0"></c:set>
	            <c:set var="endCenterTotalSum_11_15" value="0"></c:set>
	            <c:set var="endCenterTotalSum_10_15" value="0"></c:set>
	            <c:set var="endCenterTotalSum_09_15" value="0"></c:set>
	            <c:set var="endCenterTotalSum_08_15" value="0"></c:set>
	            <c:set var="endCenterTotalSum_07_15" value="0"></c:set>
	            <c:set var="endCenterTotalSum_06_15" value="0"></c:set>
	            <c:set var="endCenterTotalSum_05_15" value="0"></c:set>
	            <c:set var="endCenterTotalSum_04_15" value="0"></c:set>
	            <c:set var="endCenterTotalSum_03_15" value="0"></c:set>
	            <c:set var="endCenterTotalSum_02_15" value="0"></c:set>
	            <c:set var="endCenterTotalSum_01_15" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="endColCenterTotalSum_15" value="0"></c:set>
   				    			
    			<c:forEach var="vo2" items="${ptnrStatEndList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatEnd');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
		                    	1종 기타
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo2.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>
		                		<td style="width:150px;">${vo2.ptnrIdSubNm}</td>
		                		<!-- 센터별 계 초기화 -->
					            <c:set var="endCenterSum_12_15" value="0"></c:set>
					            <c:set var="endCenterSum_11_15" value="0"></c:set>
					            <c:set var="endCenterSum_10_15" value="0"></c:set>
					            <c:set var="endCenterSum_09_15" value="0"></c:set>
					            <c:set var="endCenterSum_08_15" value="0"></c:set>
					            <c:set var="endCenterSum_07_15" value="0"></c:set>
					            <c:set var="endCenterSum_06_15" value="0"></c:set>
					            <c:set var="endCenterSum_05_15" value="0"></c:set>
					            <c:set var="endCenterSum_04_15" value="0"></c:set>
					            <c:set var="endCenterSum_03_15" value="0"></c:set>
					            <c:set var="endCenterSum_02_15" value="0"></c:set>
					            <c:set var="endCenterSum_01_15" value="0"></c:set>
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
			    		<c:set var="end12_15" value="${vo2.end12}"></c:set>
			            <c:set var="end11_15" value="${vo2.end11}"></c:set>
			            <c:set var="end10_15" value="${vo2.end10}"></c:set>
			            <c:set var="end09_15" value="${vo2.end09}"></c:set>
			            <c:set var="end08_15" value="${vo2.end08}"></c:set>
			            <c:set var="end07_15" value="${vo2.end07}"></c:set>
			            <c:set var="end06_15" value="${vo2.end06}"></c:set>
			            <c:set var="end05_15" value="${vo2.end05}"></c:set>
			            <c:set var="end04_15" value="${vo2.end04}"></c:set>
			            <c:set var="end03_15" value="${vo2.end03}"></c:set>
			            <c:set var="end02_15" value="${vo2.end02}"></c:set>
			            <c:set var="end01_15" value="${vo2.end01}"></c:set>
			            
			            <!-- end12 -->
		                <td style="width: 80px; border-left:0.2em solid #b9b9b9 !important;">${end12_15}</td>
		                <!-- end11 -->
		                <td style="width: 80px;">${end11_15}</td>
		                <!-- end10 -->
		                <td style="width: 80px;">${end10_15}</td>
		                <!-- end09 -->
		                <td style="width: 80px;">${end09_15}</td>
		                <!-- end08 -->
		                <td style="width: 80px;">${end08_15}</td>
		                <!-- end07 -->
		                <td style="width: 80px;">${end07_15}</td>
		                <!-- end06 -->
		                <td style="width: 80px;">${end06_15}</td>
		                <!-- end05 -->
		                <td style="width: 80px;">${end05_15}</td>
		                <!-- end04 -->
		                <td style="width: 80px;">${end04_15}</td>
		                <!-- end03 -->
		                <td style="width: 80px;">${end03_15}</td>
		                <!-- end02 -->
		                <td style="width: 80px;">${end02_15}</td>
		                <!-- end01 -->
		                <td style="width: 80px;">${end01_15}</td>
		                <!-- 가로 합계 -->
		                <c:set var="endColSum_15" value="${end12_15 + end11_15 + end10_15 + end09_15 + end08_15 + end07_15 + end06_15 + end05_15 + end04_15 + end03_15 + end02_15 + end01_15}"></c:set>                    
		                <td style="width: 80px;">${endColSum_15}</td>
		                
		                <!-- 센터별 계 합산 -->
	    				<c:set var="endCenterSum_12_15" value="${endCenterSum_12_15+end12_15}"></c:set>
			            <c:set var="endCenterSum_11_15" value="${endCenterSum_11_15+end11_15}"></c:set>
			            <c:set var="endCenterSum_10_15" value="${endCenterSum_10_15+end10_15}"></c:set>
			            <c:set var="endCenterSum_09_15" value="${endCenterSum_09_15+end09_15}"></c:set>
			            <c:set var="endCenterSum_08_15" value="${endCenterSum_08_15+end08_15}"></c:set>
			            <c:set var="endCenterSum_07_15" value="${endCenterSum_07_15+end07_15}"></c:set>
			            <c:set var="endCenterSum_06_15" value="${endCenterSum_06_15+end06_15}"></c:set>
			            <c:set var="endCenterSum_05_15" value="${endCenterSum_05_15+end05_15}"></c:set>
			            <c:set var="endCenterSum_04_15" value="${endCenterSum_04_15+end04_15}"></c:set>
			            <c:set var="endCenterSum_03_15" value="${endCenterSum_03_15+end03_15}"></c:set>
			            <c:set var="endCenterSum_02_15" value="${endCenterSum_02_15+end02_15}"></c:set>
			            <c:set var="endCenterSum_01_15" value="${endCenterSum_01_15+end01_15}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="endCenterTotalSum_12_15" value="${endCenterTotalSum_12_15 + end12_15}"></c:set>
	                    <c:set var="endCenterTotalSum_11_15" value="${endCenterTotalSum_11_15 + end11_15}"></c:set>
	                    <c:set var="endCenterTotalSum_10_15" value="${endCenterTotalSum_10_15 + end10_15}"></c:set>
	                    <c:set var="endCenterTotalSum_09_15" value="${endCenterTotalSum_09_15 + end09_15}"></c:set>
	                    <c:set var="endCenterTotalSum_08_15" value="${endCenterTotalSum_08_15 + end08_15}"></c:set>
	                    <c:set var="endCenterTotalSum_07_15" value="${endCenterTotalSum_07_15 + end07_15}"></c:set>
	                    <c:set var="endCenterTotalSum_06_15" value="${endCenterTotalSum_06_15 + end06_15}"></c:set>
	                    <c:set var="endCenterTotalSum_05_15" value="${endCenterTotalSum_05_15 + end05_15}"></c:set>
	                    <c:set var="endCenterTotalSum_04_15" value="${endCenterTotalSum_04_15 + end04_15}"></c:set>
	                    <c:set var="endCenterTotalSum_03_15" value="${endCenterTotalSum_03_15 + end03_15}"></c:set>
	                    <c:set var="endCenterTotalSum_02_15" value="${endCenterTotalSum_02_15 + end02_15}"></c:set>
	                    <c:set var="endCenterTotalSum_01_15" value="${endCenterTotalSum_01_15 + end01_15}"></c:set>
		    		</tr>
		    		<!-- 센터별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${centerCnt == vo2.rowCnt and vo2.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- end12 -->
			                <td style="width: 80px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2">${endCenterSum_12_15}</td>
			                <!-- end11 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_11_15}</td>
			                <!-- end10 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_10_15}</td>
			                <!-- end09 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_09_15}</td>
			                <!-- end08 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_08_15}</td>
			                <!-- end07 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_07_15}</td>
			                <!-- end06 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_06_15}</td>
			                <!-- end05 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_05_15}</td>
			                <!-- end04 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_04_15}</td>
			                <!-- end03 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_03_15}</td>
			                <!-- end02 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_02_15}</td>
			                <!-- end01 -->
			                <td style="width: 80px;" class="sum-level-2">${endCenterSum_01_15}</td>
			                <!-- 가로 합계 -->
			                <c:set var="endCenterColSum_15" value="${endCenterSum_12_15 + endCenterSum_11_15 + endCenterSum_10_15 + endCenterSum_09_15 + endCenterSum_08_15 + endCenterSum_07_15 + endCenterSum_06_15 + endCenterSum_05_15 + endCenterSum_04_15 + endCenterSum_03_15 + endCenterSum_02_15 + endCenterSum_01_15}"></c:set>                    
			                <td style="width: 80px;" class="sum-level-2">${endCenterColSum_15}</td>
			                
							<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>										                		    				
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="endCenterSum_12_15" value="0"></c:set>
				            <c:set var="endCenterSum_11_15" value="0"></c:set>
				            <c:set var="endCenterSum_10_15" value="0"></c:set>
				            <c:set var="endCenterSum_09_15" value="0"></c:set>
				            <c:set var="endCenterSum_08_15" value="0"></c:set>
				            <c:set var="endCenterSum_07_15" value="0"></c:set>
				            <c:set var="endCenterSum_06_15" value="0"></c:set>
				            <c:set var="endCenterSum_05_15" value="0"></c:set>
				            <c:set var="endCenterSum_04_15" value="0"></c:set>
				            <c:set var="endCenterSum_03_15" value="0"></c:set>
				            <c:set var="endCenterSum_02_15" value="0"></c:set>
				            <c:set var="endCenterSum_01_15" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo2.rowCnt == 1}">
		    				<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="endCenterSum_12_15" value="0"></c:set>
				            <c:set var="endCenterSum_11_15" value="0"></c:set>
				            <c:set var="endCenterSum_10_15" value="0"></c:set>
				            <c:set var="endCenterSum_09_15" value="0"></c:set>
				            <c:set var="endCenterSum_08_15" value="0"></c:set>
				            <c:set var="endCenterSum_07_15" value="0"></c:set>
				            <c:set var="endCenterSum_06_15" value="0"></c:set>
				            <c:set var="endCenterSum_05_15" value="0"></c:set>
				            <c:set var="endCenterSum_04_15" value="0"></c:set>
				            <c:set var="endCenterSum_03_15" value="0"></c:set>
				            <c:set var="endCenterSum_02_15" value="0"></c:set>
				            <c:set var="endCenterSum_01_15" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 센터별 계 카운트 증가 -->
		    				<c:set var="centerCnt" value="${centerCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 센터별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 기타 소계 시작 -->
		    	<c:if test="${ptnrStatEndList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 기타 소계</th>
	                <!-- end12 -->
	                <th>${endCenterTotalSum_12_15}</th>
	                <!-- end11 -->
	                <th>${endCenterTotalSum_11_15}</th>
	                <!-- end10 -->
	                <th>${endCenterTotalSum_10_15}</th>
	                <!-- end09 -->
	                <th>${endCenterTotalSum_09_15}</th>
	                <!-- end08 -->
	                <th>${endCenterTotalSum_08_15}</th>
	                <!-- end07 -->
	                <th>${endCenterTotalSum_07_15}</th>
	                <!-- end06 -->
	                <th>${endCenterTotalSum_06_15}</th>
	                <!-- end05 -->
	                <th>${endCenterTotalSum_05_15}</th>
	                <!-- end04 -->
	                <th>${endCenterTotalSum_04_15}</th>
	                <!-- end03 -->
	                <th>${endCenterTotalSum_03_15}</th>
	                <!-- end02 -->
	                <th>${endCenterTotalSum_02_15}</th>
	                <!-- end01 -->
	                <th>${endCenterTotalSum_01_15}</th>
	                <!-- 가로열 합계 -->
	                <c:set var="endColTotalSum_15" value="${endCenterTotalSum_12_15 + endCenterTotalSum_11_15 + endCenterTotalSum_10_15 + endCenterTotalSum_09_15 + endCenterTotalSum_08_15 + endCenterTotalSum_07_15 + endCenterTotalSum_06_15 + endCenterTotalSum_05_15 + endCenterTotalSum_04_15 + endCenterTotalSum_03_15 + endCenterTotalSum_02_15 + endCenterTotalSum_01_15}"></c:set>
	                <th>${endColTotalSum_15}</th>
	            </tr>
	            </c:if>
		    	<!-- 1종 기타 소계 끝 -->
    		</tbody>
    	</table>
    	<!-- 1종 기타 끝 -->  	        
    </div>    
    <!-- 총 합계 시작 -->
    <!-- 총 합계 변수 시작 -->
    <c:set var="endCenterTotalSum_12_all" value="${endCenterTotalSum_12_5 + endCenterTotalSum_12_10 + endCenterTotalSum_12_15}"></c:set>
    <c:set var="endCenterTotalSum_11_all" value="${endCenterTotalSum_11_5 + endCenterTotalSum_11_10 + endCenterTotalSum_11_15}"></c:set>
    <c:set var="endCenterTotalSum_10_all" value="${endCenterTotalSum_10_5 + endCenterTotalSum_10_10 + endCenterTotalSum_10_15}"></c:set>
    <c:set var="endCenterTotalSum_09_all" value="${endCenterTotalSum_09_5 + endCenterTotalSum_09_10 + endCenterTotalSum_09_15}"></c:set>
    <c:set var="endCenterTotalSum_08_all" value="${endCenterTotalSum_08_5 + endCenterTotalSum_08_10 + endCenterTotalSum_08_15}"></c:set>
    <c:set var="endCenterTotalSum_07_all" value="${endCenterTotalSum_07_5 + endCenterTotalSum_07_10 + endCenterTotalSum_07_15}"></c:set>
    <c:set var="endCenterTotalSum_06_all" value="${endCenterTotalSum_06_5 + endCenterTotalSum_06_10 + endCenterTotalSum_06_15}"></c:set>
    <c:set var="endCenterTotalSum_05_all" value="${endCenterTotalSum_05_5 + endCenterTotalSum_05_10 + endCenterTotalSum_05_15}"></c:set>
    <c:set var="endCenterTotalSum_04_all" value="${endCenterTotalSum_04_5 + endCenterTotalSum_04_10 + endCenterTotalSum_04_15}"></c:set>
    <c:set var="endCenterTotalSum_03_all" value="${endCenterTotalSum_03_5 + endCenterTotalSum_03_10 + endCenterTotalSum_03_15}"></c:set>
    <c:set var="endCenterTotalSum_02_all" value="${endCenterTotalSum_02_5 + endCenterTotalSum_02_10 + endCenterTotalSum_02_15}"></c:set>
    <c:set var="endCenterTotalSum_01_all" value="${endCenterTotalSum_01_5 + endCenterTotalSum_01_10 + endCenterTotalSum_01_15}"></c:set>        
    <c:set var="endCenterTotalSum_col_all" value="${endCenterTotalSum_12_all + endCenterTotalSum_11_all + endCenterTotalSum_10_all + endCenterTotalSum_09_all + endCenterTotalSum_08_all + endCenterTotalSum_07_all + endCenterTotalSum_06_all + endCenterTotalSum_05_all + endCenterTotalSum_04_all + endCenterTotalSum_03_all + endCenterTotalSum_02_all + endCenterTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체합계</th>
                <th style="width: 80px;color:blue;">${endCenterTotalSum_12_all}</th>
                <th style="width: 80px;color:blue;">${endCenterTotalSum_11_all}</th>
                <th style="width: 80px;color:blue;">${endCenterTotalSum_10_all}</th>
                <th style="width: 80px;color:blue;">${endCenterTotalSum_09_all}</th>
                <th style="width: 80px;color:blue;">${endCenterTotalSum_08_all}</th>
                <th style="width: 80px;color:blue;">${endCenterTotalSum_07_all}</th>
                <th style="width: 80px;color:blue;">${endCenterTotalSum_06_all}</th>
                <th style="width: 80px;color:blue;">${endCenterTotalSum_05_all}</th>
                <th style="width: 80px;color:blue;">${endCenterTotalSum_04_all}</th>
                <th style="width: 80px;color:blue;">${endCenterTotalSum_03_all}</th>
                <th style="width: 80px;color:blue;">${endCenterTotalSum_02_all}</th>
                <th style="width: 80px;color:blue;">${endCenterTotalSum_01_all}</th>
				<th style="width: 80px;color:blue;">${endCenterTotalSum_col_all}</th>
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>