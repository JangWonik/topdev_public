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
   				<c:set var="preTeamName" value=""></c:set>
   				
   				<!-- 팀별 계 -->
	            <c:set var="regTeamSum_12_5" value="0"></c:set>
	            <c:set var="regTeamSum_11_5" value="0"></c:set>
	            <c:set var="regTeamSum_10_5" value="0"></c:set>
	            <c:set var="regTeamSum_09_5" value="0"></c:set>
	            <c:set var="regTeamSum_08_5" value="0"></c:set>
	            <c:set var="regTeamSum_07_5" value="0"></c:set>
	            <c:set var="regTeamSum_06_5" value="0"></c:set>
	            <c:set var="regTeamSum_05_5" value="0"></c:set>
	            <c:set var="regTeamSum_04_5" value="0"></c:set>
	            <c:set var="regTeamSum_03_5" value="0"></c:set>
	            <c:set var="regTeamSum_02_5" value="0"></c:set>
	            <c:set var="regTeamSum_01_5" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="regTeamTotalSum_12_5" value="0"></c:set>
	            <c:set var="regTeamTotalSum_11_5" value="0"></c:set>
	            <c:set var="regTeamTotalSum_10_5" value="0"></c:set>
	            <c:set var="regTeamTotalSum_09_5" value="0"></c:set>
	            <c:set var="regTeamTotalSum_08_5" value="0"></c:set>
	            <c:set var="regTeamTotalSum_07_5" value="0"></c:set>
	            <c:set var="regTeamTotalSum_06_5" value="0"></c:set>
	            <c:set var="regTeamTotalSum_05_5" value="0"></c:set>
	            <c:set var="regTeamTotalSum_04_5" value="0"></c:set>
	            <c:set var="regTeamTotalSum_03_5" value="0"></c:set>
	            <c:set var="regTeamTotalSum_02_5" value="0"></c:set>
	            <c:set var="regTeamTotalSum_01_5" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="regColTeamTotalSum_5" value="0"></c:set>
   				    			
    			<c:forEach var="vo" items="${ptnrStatTeamAllRegList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatMain');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowTeamAll}">
		                    	1종 조사
		                    </td>		                    
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo.rowCnt == 1}">		                		
		                		<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>
		                		<td onclick="goPtnrStatMember(${vo.ptnrId},${vo.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.teamName}</td>
		                		<td style="width:150px;">${vo.ptnrIdSubNm}</td>              		
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="regTeamSum_12_5" value="0"></c:set>
					            <c:set var="regTeamSum_11_5" value="0"></c:set>
					            <c:set var="regTeamSum_10_5" value="0"></c:set>
					            <c:set var="regTeamSum_09_5" value="0"></c:set>
					            <c:set var="regTeamSum_08_5" value="0"></c:set>
					            <c:set var="regTeamSum_07_5" value="0"></c:set>
					            <c:set var="regTeamSum_06_5" value="0"></c:set>
					            <c:set var="regTeamSum_05_5" value="0"></c:set>
					            <c:set var="regTeamSum_04_5" value="0"></c:set>
					            <c:set var="regTeamSum_03_5" value="0"></c:set>
					            <c:set var="regTeamSum_02_5" value="0"></c:set>
					            <c:set var="regTeamSum_01_5" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${teamCnt == 1 and vo.teamName != preTeamName}">
		                				<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>
		                				<td onclick="goPtnrStatMember(${vo.ptnrId},${vo.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${vo.rowCnt+1}">${vo.teamName}</td>
		                				<td style="width:150px;">${vo.ptnrIdSubNm}</td>		                				
		                				<c:set var="preTeamName" value="${vo.teamName}"></c:set>
		                			</c:when>
		                			<c:otherwise>		              
		                				<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>  				
	                					<td style="width:150px;">${vo.ptnrIdSubNm}</td>	                					
		                			</c:otherwise>
		                		</c:choose>                				               		      		
		                	</c:otherwise>
		                </c:choose>
		                <!-- 각 수임건 -->    		
			    		<c:set var="reg12_5" value="${vo.reg12}"></c:set>
			            <c:set var="reg11_5" value="${vo.reg11}"></c:set>
			            <c:set var="reg10_5" value="${vo.reg10}"></c:set>
			            <c:set var="reg09_5" value="${vo.reg09}"></c:set>
			            <c:set var="reg08_5" value="${vo.reg08}"></c:set>
			            <c:set var="reg07_5" value="${vo.reg07}"></c:set>
			            <c:set var="reg06_5" value="${vo.reg06}"></c:set>
			            <c:set var="reg05_5" value="${vo.reg05}"></c:set>
			            <c:set var="reg04_5" value="${vo.reg04}"></c:set>
			            <c:set var="reg03_5" value="${vo.reg03}"></c:set>
			            <c:set var="reg02_5" value="${vo.reg02}"></c:set>
			            <c:set var="reg01_5" value="${vo.reg01}"></c:set>
			            
			            <!-- reg12 -->
		                <td style="width: 80px; border-left:0.2em solid #b9b9b9 !important;">${reg12_5}</td>
		                <!-- reg11 -->
		                <td style="width: 80px;">${reg11_5}</td>
		                <!-- reg10 -->
		                <td style="width: 80px;">${reg10_5}</td>
		                <!-- reg09 -->
		                <td style="width: 80px;">${reg09_5}</td>
		                <!-- reg08 -->
		                <td style="width: 80px;">${reg08_5}</td>
		                <!-- reg07 -->
		                <td style="width: 80px;">${reg07_5}</td>
		                <!-- reg06 -->
		                <td style="width: 80px;">${reg06_5}</td>
		                <!-- reg05 -->
		                <td style="width: 80px;">${reg05_5}</td>
		                <!-- reg04 -->
		                <td style="width: 80px;">${reg04_5}</td>
		                <!-- reg03 -->
		                <td style="width: 80px;">${reg03_5}</td>
		                <!-- reg02 -->
		                <td style="width: 80px;">${reg02_5}</td>
		                <!-- reg01 -->
		                <td style="width: 80px;">${reg01_5}</td>
		                <!-- 가로 합계 -->
		                <c:set var="regColSum_5" value="${reg12_5 + reg11_5 + reg10_5 + reg09_5 + reg08_5 + reg07_5 + reg06_5 + reg05_5 + reg04_5 + reg03_5 + reg02_5 + reg01_5}"></c:set>                    
		                <td style="width: 80px;">${regColSum_5}</td>
		                
		                <!-- 팀별 계 합산 -->
	    				<c:set var="regTeamSum_12_5" value="${regTeamSum_12_5+reg12_5}"></c:set>
			            <c:set var="regTeamSum_11_5" value="${regTeamSum_11_5+reg11_5}"></c:set>
			            <c:set var="regTeamSum_10_5" value="${regTeamSum_10_5+reg10_5}"></c:set>
			            <c:set var="regTeamSum_09_5" value="${regTeamSum_09_5+reg09_5}"></c:set>
			            <c:set var="regTeamSum_08_5" value="${regTeamSum_08_5+reg08_5}"></c:set>
			            <c:set var="regTeamSum_07_5" value="${regTeamSum_07_5+reg07_5}"></c:set>
			            <c:set var="regTeamSum_06_5" value="${regTeamSum_06_5+reg06_5}"></c:set>
			            <c:set var="regTeamSum_05_5" value="${regTeamSum_05_5+reg05_5}"></c:set>
			            <c:set var="regTeamSum_04_5" value="${regTeamSum_04_5+reg04_5}"></c:set>
			            <c:set var="regTeamSum_03_5" value="${regTeamSum_03_5+reg03_5}"></c:set>
			            <c:set var="regTeamSum_02_5" value="${regTeamSum_02_5+reg02_5}"></c:set>
			            <c:set var="regTeamSum_01_5" value="${regTeamSum_01_5+reg01_5}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="regTeamTotalSum_12_5" value="${regTeamTotalSum_12_5 + reg12_5}"></c:set>
	                    <c:set var="regTeamTotalSum_11_5" value="${regTeamTotalSum_11_5 + reg11_5}"></c:set>
	                    <c:set var="regTeamTotalSum_10_5" value="${regTeamTotalSum_10_5 + reg10_5}"></c:set>
	                    <c:set var="regTeamTotalSum_09_5" value="${regTeamTotalSum_09_5 + reg09_5}"></c:set>
	                    <c:set var="regTeamTotalSum_08_5" value="${regTeamTotalSum_08_5 + reg08_5}"></c:set>
	                    <c:set var="regTeamTotalSum_07_5" value="${regTeamTotalSum_07_5 + reg07_5}"></c:set>
	                    <c:set var="regTeamTotalSum_06_5" value="${regTeamTotalSum_06_5 + reg06_5}"></c:set>
	                    <c:set var="regTeamTotalSum_05_5" value="${regTeamTotalSum_05_5 + reg05_5}"></c:set>
	                    <c:set var="regTeamTotalSum_04_5" value="${regTeamTotalSum_04_5 + reg04_5}"></c:set>
	                    <c:set var="regTeamTotalSum_03_5" value="${regTeamTotalSum_03_5 + reg03_5}"></c:set>
	                    <c:set var="regTeamTotalSum_02_5" value="${regTeamTotalSum_02_5 + reg02_5}"></c:set>
	                    <c:set var="regTeamTotalSum_01_5" value="${regTeamTotalSum_01_5 + reg01_5}"></c:set>
		    		</tr>
		    		<!-- 팀별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo.rowCnt and vo.rowCnt > 1}">
		    				<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- reg12 -->
			                <td style="width: 80px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2">${regTeamSum_12_5}</td>
			                <!-- reg11 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_11_5}</td>
			                <!-- reg10 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_10_5}</td>
			                <!-- reg09 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_09_5}</td>
			                <!-- reg08 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_08_5}</td>
			                <!-- reg07 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_07_5}</td>
			                <!-- reg06 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_06_5}</td>
			                <!-- reg05 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_05_5}</td>
			                <!-- reg04 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_04_5}</td>
			                <!-- reg03 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_03_5}</td>
			                <!-- reg02 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_02_5}</td>
			                <!-- reg01 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_01_5}</td>
			                <!-- 가로 합계 -->
			                <c:set var="regTeamColSum_5" value="${regTeamSum_12_5 + regTeamSum_11_5 + regTeamSum_10_5 + regTeamSum_09_5 + regTeamSum_08_5 + regTeamSum_07_5 + regTeamSum_06_5 + regTeamSum_05_5 + regTeamSum_04_5 + regTeamSum_03_5 + regTeamSum_02_5 + regTeamSum_01_5}"></c:set>                    
			                <td style="width: 80px;" class="sum-level-2">${regTeamColSum_5}</td>
			                
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="regTeamSum_12_5" value="0"></c:set>
				            <c:set var="regTeamSum_11_5" value="0"></c:set>
				            <c:set var="regTeamSum_10_5" value="0"></c:set>
				            <c:set var="regTeamSum_09_5" value="0"></c:set>
				            <c:set var="regTeamSum_08_5" value="0"></c:set>
				            <c:set var="regTeamSum_07_5" value="0"></c:set>
				            <c:set var="regTeamSum_06_5" value="0"></c:set>
				            <c:set var="regTeamSum_05_5" value="0"></c:set>
				            <c:set var="regTeamSum_04_5" value="0"></c:set>
				            <c:set var="regTeamSum_03_5" value="0"></c:set>
				            <c:set var="regTeamSum_02_5" value="0"></c:set>
				            <c:set var="regTeamSum_01_5" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo.rowCnt == 1}">
		    				<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="regTeamSum_12_5" value="0"></c:set>
				            <c:set var="regTeamSum_11_5" value="0"></c:set>
				            <c:set var="regTeamSum_10_5" value="0"></c:set>
				            <c:set var="regTeamSum_09_5" value="0"></c:set>
				            <c:set var="regTeamSum_08_5" value="0"></c:set>
				            <c:set var="regTeamSum_07_5" value="0"></c:set>
				            <c:set var="regTeamSum_06_5" value="0"></c:set>
				            <c:set var="regTeamSum_05_5" value="0"></c:set>
				            <c:set var="regTeamSum_04_5" value="0"></c:set>
				            <c:set var="regTeamSum_03_5" value="0"></c:set>
				            <c:set var="regTeamSum_02_5" value="0"></c:set>
				            <c:set var="regTeamSum_01_5" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 팀별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 팀별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 조사 소계 시작 -->
		    	<c:if test="${ptnrStatTeamAllRegList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="4" style="height:25px;">1종 조사 소계</th>
	                <!-- reg12 -->
	                <th>${regTeamTotalSum_12_5}</th>
	                <!-- reg11 -->
	                <th>${regTeamTotalSum_11_5}</th>
	                <!-- reg10 -->
	                <th>${regTeamTotalSum_10_5}</th>
	                <!-- reg09 -->
	                <th>${regTeamTotalSum_09_5}</th>
	                <!-- reg08 -->
	                <th>${regTeamTotalSum_08_5}</th>
	                <!-- reg07 -->
	                <th>${regTeamTotalSum_07_5}</th>
	                <!-- reg06 -->
	                <th>${regTeamTotalSum_06_5}</th>
	                <!-- reg05 -->
	                <th>${regTeamTotalSum_05_5}</th>
	                <!-- reg04 -->
	                <th>${regTeamTotalSum_04_5}</th>
	                <!-- reg03 -->
	                <th>${regTeamTotalSum_03_5}</th>
	                <!-- reg02 -->
	                <th>${regTeamTotalSum_02_5}</th>
	                <!-- reg01 -->
	                <th>${regTeamTotalSum_01_5}</th>
	                <!-- 가로열 합계 -->
	                <c:set var="regColTotalSum_5" value="${regTeamTotalSum_12_5 + regTeamTotalSum_11_5 + regTeamTotalSum_10_5 + regTeamTotalSum_09_5 + regTeamTotalSum_08_5 + regTeamTotalSum_07_5 + regTeamTotalSum_06_5 + regTeamTotalSum_05_5 + regTeamTotalSum_04_5 + regTeamTotalSum_03_5 + regTeamTotalSum_02_5 + regTeamTotalSum_01_5}"></c:set>
	                <th>${regColTotalSum_5}</th>
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
	            <c:set var="regTeamSum_12_10" value="0"></c:set>
	            <c:set var="regTeamSum_11_10" value="0"></c:set>
	            <c:set var="regTeamSum_10_10" value="0"></c:set>
	            <c:set var="regTeamSum_09_10" value="0"></c:set>
	            <c:set var="regTeamSum_08_10" value="0"></c:set>
	            <c:set var="regTeamSum_07_10" value="0"></c:set>
	            <c:set var="regTeamSum_06_10" value="0"></c:set>
	            <c:set var="regTeamSum_05_10" value="0"></c:set>
	            <c:set var="regTeamSum_04_10" value="0"></c:set>
	            <c:set var="regTeamSum_03_10" value="0"></c:set>
	            <c:set var="regTeamSum_02_10" value="0"></c:set>
	            <c:set var="regTeamSum_01_10" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="regTeamTotalSum_12_10" value="0"></c:set>
	            <c:set var="regTeamTotalSum_11_10" value="0"></c:set>
	            <c:set var="regTeamTotalSum_10_10" value="0"></c:set>
	            <c:set var="regTeamTotalSum_09_10" value="0"></c:set>
	            <c:set var="regTeamTotalSum_08_10" value="0"></c:set>
	            <c:set var="regTeamTotalSum_07_10" value="0"></c:set>
	            <c:set var="regTeamTotalSum_06_10" value="0"></c:set>
	            <c:set var="regTeamTotalSum_05_10" value="0"></c:set>
	            <c:set var="regTeamTotalSum_04_10" value="0"></c:set>
	            <c:set var="regTeamTotalSum_03_10" value="0"></c:set>
	            <c:set var="regTeamTotalSum_02_10" value="0"></c:set>
	            <c:set var="regTeamTotalSum_01_10" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="regColTeamTotalSum_10" value="0"></c:set>
   				    			
    			<c:forEach var="vo1" items="${ptnrStatTeamAllRegList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatMain');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowTeamAll_10}">
		                    	1종 심사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo1.rowCnt == 1}">
		                		<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>
		                		<td onclick="goPtnrStatMember(${vo1.ptnrId},${vo1.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.teamName}</td>
		                		<td style="width:150px;">${vo1.ptnrIdSubNm}</td>		                		
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="regTeamSum_12_10" value="0"></c:set>
					            <c:set var="regTeamSum_11_10" value="0"></c:set>
					            <c:set var="regTeamSum_10_10" value="0"></c:set>
					            <c:set var="regTeamSum_09_10" value="0"></c:set>
					            <c:set var="regTeamSum_08_10" value="0"></c:set>
					            <c:set var="regTeamSum_07_10" value="0"></c:set>
					            <c:set var="regTeamSum_06_10" value="0"></c:set>
					            <c:set var="regTeamSum_05_10" value="0"></c:set>
					            <c:set var="regTeamSum_04_10" value="0"></c:set>
					            <c:set var="regTeamSum_03_10" value="0"></c:set>
					            <c:set var="regTeamSum_02_10" value="0"></c:set>
					            <c:set var="regTeamSum_01_10" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${teamCnt == 1 and vo1.teamName != preTeamName}">
		                				<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>
		                				<td onclick="goPtnrStatMember(${vo1.ptnrId},${vo1.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${vo1.rowCnt+1}">${vo1.teamName}</td>
		                				<td style="width:150px;">${vo1.ptnrIdSubNm}</td>		                				
		                				<c:set var="preTeamName" value="${vo1.teamName}"></c:set>
		                			</c:when>
		                			<c:otherwise>
		                				<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>		                				
	                					<td style="width:150px;">${vo1.ptnrIdSubNm}</td>	                					
		                			</c:otherwise>
		                		</c:choose>                				               		      		
		                	</c:otherwise>
		                </c:choose>
		                <!-- 각 수임건 -->    		
			    		<c:set var="reg12_10" value="${vo1.reg12}"></c:set>
			            <c:set var="reg11_10" value="${vo1.reg11}"></c:set>
			            <c:set var="reg10_10" value="${vo1.reg10}"></c:set>
			            <c:set var="reg09_10" value="${vo1.reg09}"></c:set>
			            <c:set var="reg08_10" value="${vo1.reg08}"></c:set>
			            <c:set var="reg07_10" value="${vo1.reg07}"></c:set>
			            <c:set var="reg06_10" value="${vo1.reg06}"></c:set>
			            <c:set var="reg05_10" value="${vo1.reg05}"></c:set>
			            <c:set var="reg04_10" value="${vo1.reg04}"></c:set>
			            <c:set var="reg03_10" value="${vo1.reg03}"></c:set>
			            <c:set var="reg02_10" value="${vo1.reg02}"></c:set>
			            <c:set var="reg01_10" value="${vo1.reg01}"></c:set>
			            
			            <!-- reg12 -->
		                <td style="width: 80px; border-left:0.2em solid #b9b9b9 !important;">${reg12_10}</td>
		                <!-- reg11 -->
		                <td style="width: 80px;">${reg11_10}</td>
		                <!-- reg10 -->
		                <td style="width: 80px;">${reg10_10}</td>
		                <!-- reg09 -->
		                <td style="width: 80px;">${reg09_10}</td>
		                <!-- reg08 -->
		                <td style="width: 80px;">${reg08_10}</td>
		                <!-- reg07 -->
		                <td style="width: 80px;">${reg07_10}</td>
		                <!-- reg06 -->
		                <td style="width: 80px;">${reg06_10}</td>
		                <!-- reg05 -->
		                <td style="width: 80px;">${reg05_10}</td>
		                <!-- reg04 -->
		                <td style="width: 80px;">${reg04_10}</td>
		                <!-- reg03 -->
		                <td style="width: 80px;">${reg03_10}</td>
		                <!-- reg02 -->
		                <td style="width: 80px;">${reg02_10}</td>
		                <!-- reg01 -->
		                <td style="width: 80px;">${reg01_10}</td>
		                <!-- 가로 합계 -->
		                <c:set var="regColSum_10" value="${reg12_10 + reg11_10 + reg10_10 + reg09_10 + reg08_10 + reg07_10 + reg06_10 + reg05_10 + reg04_10 + reg03_10 + reg02_10 + reg01_10}"></c:set>                    
		                <td style="width: 80px;">${regColSum_10}</td>
		                
		                <!-- 팀별 계 합산 -->
	    				<c:set var="regTeamSum_12_10" value="${regTeamSum_12_10+reg12_10}"></c:set>
			            <c:set var="regTeamSum_11_10" value="${regTeamSum_11_10+reg11_10}"></c:set>
			            <c:set var="regTeamSum_10_10" value="${regTeamSum_10_10+reg10_10}"></c:set>
			            <c:set var="regTeamSum_09_10" value="${regTeamSum_09_10+reg09_10}"></c:set>
			            <c:set var="regTeamSum_08_10" value="${regTeamSum_08_10+reg08_10}"></c:set>
			            <c:set var="regTeamSum_07_10" value="${regTeamSum_07_10+reg07_10}"></c:set>
			            <c:set var="regTeamSum_06_10" value="${regTeamSum_06_10+reg06_10}"></c:set>
			            <c:set var="regTeamSum_05_10" value="${regTeamSum_05_10+reg05_10}"></c:set>
			            <c:set var="regTeamSum_04_10" value="${regTeamSum_04_10+reg04_10}"></c:set>
			            <c:set var="regTeamSum_03_10" value="${regTeamSum_03_10+reg03_10}"></c:set>
			            <c:set var="regTeamSum_02_10" value="${regTeamSum_02_10+reg02_10}"></c:set>
			            <c:set var="regTeamSum_01_10" value="${regTeamSum_01_10+reg01_10}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="regTeamTotalSum_12_10" value="${regTeamTotalSum_12_10 + reg12_10}"></c:set>
	                    <c:set var="regTeamTotalSum_11_10" value="${regTeamTotalSum_11_10 + reg11_10}"></c:set>
	                    <c:set var="regTeamTotalSum_10_10" value="${regTeamTotalSum_10_10 + reg10_10}"></c:set>
	                    <c:set var="regTeamTotalSum_09_10" value="${regTeamTotalSum_09_10 + reg09_10}"></c:set>
	                    <c:set var="regTeamTotalSum_08_10" value="${regTeamTotalSum_08_10 + reg08_10}"></c:set>
	                    <c:set var="regTeamTotalSum_07_10" value="${regTeamTotalSum_07_10 + reg07_10}"></c:set>
	                    <c:set var="regTeamTotalSum_06_10" value="${regTeamTotalSum_06_10 + reg06_10}"></c:set>
	                    <c:set var="regTeamTotalSum_05_10" value="${regTeamTotalSum_05_10 + reg05_10}"></c:set>
	                    <c:set var="regTeamTotalSum_04_10" value="${regTeamTotalSum_04_10 + reg04_10}"></c:set>
	                    <c:set var="regTeamTotalSum_03_10" value="${regTeamTotalSum_03_10 + reg03_10}"></c:set>
	                    <c:set var="regTeamTotalSum_02_10" value="${regTeamTotalSum_02_10 + reg02_10}"></c:set>
	                    <c:set var="regTeamTotalSum_01_10" value="${regTeamTotalSum_01_10 + reg01_10}"></c:set>
		    		</tr>
		    		<!-- 팀별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo1.rowCnt and vo1.rowCnt > 1}">
		    				<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- reg12 -->
			                <td style="width: 80px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2">${regTeamSum_12_10}</td>
			                <!-- reg11 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_11_10}</td>
			                <!-- reg10 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_10_10}</td>
			                <!-- reg09 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_09_10}</td>
			                <!-- reg08 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_08_10}</td>
			                <!-- reg07 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_07_10}</td>
			                <!-- reg06 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_06_10}</td>
			                <!-- reg05 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_05_10}</td>
			                <!-- reg04 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_04_10}</td>
			                <!-- reg03 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_03_10}</td>
			                <!-- reg02 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_02_10}</td>
			                <!-- reg01 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_01_10}</td>
			                <!-- 가로 합계 -->
			                <c:set var="regTeamColSum_10" value="${regTeamSum_12_10 + regTeamSum_11_10 + regTeamSum_10_10 + regTeamSum_09_10 + regTeamSum_08_10 + regTeamSum_07_10 + regTeamSum_06_10 + regTeamSum_05_10 + regTeamSum_04_10 + regTeamSum_03_10 + regTeamSum_02_10 + regTeamSum_01_10}"></c:set>                    
			                <td style="width: 80px;" class="sum-level-2">${regTeamColSum_10}</td>
			                
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="regTeamSum_12_10" value="0"></c:set>
				            <c:set var="regTeamSum_11_10" value="0"></c:set>
				            <c:set var="regTeamSum_10_10" value="0"></c:set>
				            <c:set var="regTeamSum_09_10" value="0"></c:set>
				            <c:set var="regTeamSum_08_10" value="0"></c:set>
				            <c:set var="regTeamSum_07_10" value="0"></c:set>
				            <c:set var="regTeamSum_06_10" value="0"></c:set>
				            <c:set var="regTeamSum_05_10" value="0"></c:set>
				            <c:set var="regTeamSum_04_10" value="0"></c:set>
				            <c:set var="regTeamSum_03_10" value="0"></c:set>
				            <c:set var="regTeamSum_02_10" value="0"></c:set>
				            <c:set var="regTeamSum_01_10" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo1.rowCnt == 1}">
		    				<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="regTeamSum_12_10" value="0"></c:set>
				            <c:set var="regTeamSum_11_10" value="0"></c:set>
				            <c:set var="regTeamSum_10_10" value="0"></c:set>
				            <c:set var="regTeamSum_09_10" value="0"></c:set>
				            <c:set var="regTeamSum_08_10" value="0"></c:set>
				            <c:set var="regTeamSum_07_10" value="0"></c:set>
				            <c:set var="regTeamSum_06_10" value="0"></c:set>
				            <c:set var="regTeamSum_05_10" value="0"></c:set>
				            <c:set var="regTeamSum_04_10" value="0"></c:set>
				            <c:set var="regTeamSum_03_10" value="0"></c:set>
				            <c:set var="regTeamSum_02_10" value="0"></c:set>
				            <c:set var="regTeamSum_01_10" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 팀별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 팀별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 심사 소계 시작 -->
		    	<c:if test="${ptnrStatTeamAllRegList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="4" style="height:25px;">1종 심사 소계</th>
	                <!-- reg12 -->
	                <th>${regTeamTotalSum_12_10}</th>
	                <!-- reg11 -->
	                <th>${regTeamTotalSum_11_10}</th>
	                <!-- reg10 -->
	                <th>${regTeamTotalSum_10_10}</th>
	                <!-- reg09 -->
	                <th>${regTeamTotalSum_09_10}</th>
	                <!-- reg08 -->
	                <th>${regTeamTotalSum_08_10}</th>
	                <!-- reg07 -->
	                <th>${regTeamTotalSum_07_10}</th>
	                <!-- reg06 -->
	                <th>${regTeamTotalSum_06_10}</th>
	                <!-- reg05 -->
	                <th>${regTeamTotalSum_05_10}</th>
	                <!-- reg04 -->
	                <th>${regTeamTotalSum_04_10}</th>
	                <!-- reg03 -->
	                <th>${regTeamTotalSum_03_10}</th>
	                <!-- reg02 -->
	                <th>${regTeamTotalSum_02_10}</th>
	                <!-- reg01 -->
	                <th>${regTeamTotalSum_01_10}</th>
	                <!-- 가로열 합계 -->
	                <c:set var="regColTotalSum_10" value="${regTeamTotalSum_12_10 + regTeamTotalSum_11_10 + regTeamTotalSum_10_10 + regTeamTotalSum_09_10 + regTeamTotalSum_08_10 + regTeamTotalSum_07_10 + regTeamTotalSum_06_10 + regTeamTotalSum_05_10 + regTeamTotalSum_04_10 + regTeamTotalSum_03_10 + regTeamTotalSum_02_10 + regTeamTotalSum_01_10}"></c:set>
	                <th>${regColTotalSum_10}</th>
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
	            <c:set var="regTeamSum_12_15" value="0"></c:set>
	            <c:set var="regTeamSum_11_15" value="0"></c:set>
	            <c:set var="regTeamSum_10_15" value="0"></c:set>
	            <c:set var="regTeamSum_09_15" value="0"></c:set>
	            <c:set var="regTeamSum_08_15" value="0"></c:set>
	            <c:set var="regTeamSum_07_15" value="0"></c:set>
	            <c:set var="regTeamSum_06_15" value="0"></c:set>
	            <c:set var="regTeamSum_05_15" value="0"></c:set>
	            <c:set var="regTeamSum_04_15" value="0"></c:set>
	            <c:set var="regTeamSum_03_15" value="0"></c:set>
	            <c:set var="regTeamSum_02_15" value="0"></c:set>
	            <c:set var="regTeamSum_01_15" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="regTeamTotalSum_12_15" value="0"></c:set>
	            <c:set var="regTeamTotalSum_11_15" value="0"></c:set>
	            <c:set var="regTeamTotalSum_10_15" value="0"></c:set>
	            <c:set var="regTeamTotalSum_09_15" value="0"></c:set>
	            <c:set var="regTeamTotalSum_08_15" value="0"></c:set>
	            <c:set var="regTeamTotalSum_07_15" value="0"></c:set>
	            <c:set var="regTeamTotalSum_06_15" value="0"></c:set>
	            <c:set var="regTeamTotalSum_05_15" value="0"></c:set>
	            <c:set var="regTeamTotalSum_04_15" value="0"></c:set>
	            <c:set var="regTeamTotalSum_03_15" value="0"></c:set>
	            <c:set var="regTeamTotalSum_02_15" value="0"></c:set>
	            <c:set var="regTeamTotalSum_01_15" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="regColTeamTotalSum_15" value="0"></c:set>
   				    			
    			<c:forEach var="vo2" items="${ptnrStatTeamAllRegList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatMain');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowTeamAll_15}">1종 기타</td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo2.rowCnt == 1}">
		                		<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>
		                		<td onclick="goPtnrStatMember(${vo2.ptnrId},${vo2.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.teamName}</td>
		                		<td style="width:150px;">${vo2.ptnrIdSubNm}</td>		                		
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="regTeamSum_12_15" value="0"></c:set>
					            <c:set var="regTeamSum_11_15" value="0"></c:set>
					            <c:set var="regTeamSum_10_15" value="0"></c:set>
					            <c:set var="regTeamSum_09_15" value="0"></c:set>
					            <c:set var="regTeamSum_08_15" value="0"></c:set>
					            <c:set var="regTeamSum_07_15" value="0"></c:set>
					            <c:set var="regTeamSum_06_15" value="0"></c:set>
					            <c:set var="regTeamSum_05_15" value="0"></c:set>
					            <c:set var="regTeamSum_04_15" value="0"></c:set>
					            <c:set var="regTeamSum_03_15" value="0"></c:set>
					            <c:set var="regTeamSum_02_15" value="0"></c:set>
					            <c:set var="regTeamSum_01_15" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${teamCnt == 1 and vo2.teamName != preTeamName}">
		                				<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>
		                				<td onclick="goPtnrStatMember(${vo.ptnrId},${vo.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${vo2.rowCnt+1}">${vo2.teamName}</td>
		                				<td style="width:150px;">${vo2.ptnrIdSubNm}</td>		                				
		                				<c:set var="preTeamName" value="${vo2.teamName}"></c:set>
		                			</c:when>
		                			<c:otherwise>
		                				<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>		                				
	                					<td style="width:150px;">${vo2.ptnrIdSubNm}</td>	                					
		                			</c:otherwise>
		                		</c:choose>                				               		      		
		                	</c:otherwise>
		                </c:choose>
		                <!-- 각 수임건 -->    		
			    		<c:set var="reg12_15" value="${vo2.reg12}"></c:set>
			            <c:set var="reg11_15" value="${vo2.reg11}"></c:set>
			            <c:set var="reg10_15" value="${vo2.reg10}"></c:set>
			            <c:set var="reg09_15" value="${vo2.reg09}"></c:set>
			            <c:set var="reg08_15" value="${vo2.reg08}"></c:set>
			            <c:set var="reg07_15" value="${vo2.reg07}"></c:set>
			            <c:set var="reg06_15" value="${vo2.reg06}"></c:set>
			            <c:set var="reg05_15" value="${vo2.reg05}"></c:set>
			            <c:set var="reg04_15" value="${vo2.reg04}"></c:set>
			            <c:set var="reg03_15" value="${vo2.reg03}"></c:set>
			            <c:set var="reg02_15" value="${vo2.reg02}"></c:set>
			            <c:set var="reg01_15" value="${vo2.reg01}"></c:set>
			            
			            <!-- reg12 -->
		                <td style="width: 80px; border-left:0.2em solid #b9b9b9 !important;">${reg12_15}</td>
		                <!-- reg11 -->
		                <td style="width: 80px;">${reg11_15}</td>
		                <!-- reg10 -->
		                <td style="width: 80px;">${reg10_15}</td>
		                <!-- reg09 -->
		                <td style="width: 80px;">${reg09_15}</td>
		                <!-- reg08 -->
		                <td style="width: 80px;">${reg08_15}</td>
		                <!-- reg07 -->
		                <td style="width: 80px;">${reg07_15}</td>
		                <!-- reg06 -->
		                <td style="width: 80px;">${reg06_15}</td>
		                <!-- reg05 -->
		                <td style="width: 80px;">${reg05_15}</td>
		                <!-- reg04 -->
		                <td style="width: 80px;">${reg04_15}</td>
		                <!-- reg03 -->
		                <td style="width: 80px;">${reg03_15}</td>
		                <!-- reg02 -->
		                <td style="width: 80px;">${reg02_15}</td>
		                <!-- reg01 -->
		                <td style="width: 80px;">${reg01_15}</td>
		                <!-- 가로 합계 -->
		                <c:set var="regColSum_15" value="${reg12_15 + reg11_15 + reg10_15 + reg09_15 + reg08_15 + reg07_15 + reg06_15 + reg05_15 + reg04_15 + reg03_15 + reg02_15 + reg01_15}"></c:set>                    
		                <td style="width: 80px;">${regColSum_15}</td>
		                
		                <!-- 팀별 계 합산 -->
	    				<c:set var="regTeamSum_12_15" value="${regTeamSum_12_15+reg12_15}"></c:set>
			            <c:set var="regTeamSum_11_15" value="${regTeamSum_11_15+reg11_15}"></c:set>
			            <c:set var="regTeamSum_10_15" value="${regTeamSum_10_15+reg10_15}"></c:set>
			            <c:set var="regTeamSum_09_15" value="${regTeamSum_09_15+reg09_15}"></c:set>
			            <c:set var="regTeamSum_08_15" value="${regTeamSum_08_15+reg08_15}"></c:set>
			            <c:set var="regTeamSum_07_15" value="${regTeamSum_07_15+reg07_15}"></c:set>
			            <c:set var="regTeamSum_06_15" value="${regTeamSum_06_15+reg06_15}"></c:set>
			            <c:set var="regTeamSum_05_15" value="${regTeamSum_05_15+reg05_15}"></c:set>
			            <c:set var="regTeamSum_04_15" value="${regTeamSum_04_15+reg04_15}"></c:set>
			            <c:set var="regTeamSum_03_15" value="${regTeamSum_03_15+reg03_15}"></c:set>
			            <c:set var="regTeamSum_02_15" value="${regTeamSum_02_15+reg02_15}"></c:set>
			            <c:set var="regTeamSum_01_15" value="${regTeamSum_01_15+reg01_15}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="regTeamTotalSum_12_15" value="${regTeamTotalSum_12_15 + reg12_15}"></c:set>
	                    <c:set var="regTeamTotalSum_11_15" value="${regTeamTotalSum_11_15 + reg11_15}"></c:set>
	                    <c:set var="regTeamTotalSum_10_15" value="${regTeamTotalSum_10_15 + reg10_15}"></c:set>
	                    <c:set var="regTeamTotalSum_09_15" value="${regTeamTotalSum_09_15 + reg09_15}"></c:set>
	                    <c:set var="regTeamTotalSum_08_15" value="${regTeamTotalSum_08_15 + reg08_15}"></c:set>
	                    <c:set var="regTeamTotalSum_07_15" value="${regTeamTotalSum_07_15 + reg07_15}"></c:set>
	                    <c:set var="regTeamTotalSum_06_15" value="${regTeamTotalSum_06_15 + reg06_15}"></c:set>
	                    <c:set var="regTeamTotalSum_05_15" value="${regTeamTotalSum_05_15 + reg05_15}"></c:set>
	                    <c:set var="regTeamTotalSum_04_15" value="${regTeamTotalSum_04_15 + reg04_15}"></c:set>
	                    <c:set var="regTeamTotalSum_03_15" value="${regTeamTotalSum_03_15 + reg03_15}"></c:set>
	                    <c:set var="regTeamTotalSum_02_15" value="${regTeamTotalSum_02_15 + reg02_15}"></c:set>
	                    <c:set var="regTeamTotalSum_01_15" value="${regTeamTotalSum_01_15 + reg01_15}"></c:set>
		    		</tr>
		    		<!-- 팀별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo2.rowCnt and vo2.rowCnt > 1}">
		    				<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- reg12 -->
			                <td style="width: 80px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2">${regTeamSum_12_15}</td>
			                <!-- reg11 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_11_15}</td>
			                <!-- reg10 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_10_15}</td>
			                <!-- reg09 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_09_15}</td>
			                <!-- reg08 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_08_15}</td>
			                <!-- reg07 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_07_15}</td>
			                <!-- reg06 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_06_15}</td>
			                <!-- reg05 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_05_15}</td>
			                <!-- reg04 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_04_15}</td>
			                <!-- reg03 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_03_15}</td>
			                <!-- reg02 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_02_15}</td>
			                <!-- reg01 -->
			                <td style="width: 80px;" class="sum-level-2">${regTeamSum_01_15}</td>
			                <!-- 가로 합계 -->
			                <c:set var="regTeamColSum_15" value="${regTeamSum_12_15 + regTeamSum_11_15 + regTeamSum_10_15 + regTeamSum_09_15 + regTeamSum_08_15 + regTeamSum_07_15 + regTeamSum_06_15 + regTeamSum_05_15 + regTeamSum_04_15 + regTeamSum_03_15 + regTeamSum_02_15 + regTeamSum_01_15}"></c:set>                    
			                <td style="width: 80px;" class="sum-level-2">${regTeamColSum_15}</td>
			                
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="regTeamSum_12_15" value="0"></c:set>
				            <c:set var="regTeamSum_11_15" value="0"></c:set>
				            <c:set var="regTeamSum_10_15" value="0"></c:set>
				            <c:set var="regTeamSum_09_15" value="0"></c:set>
				            <c:set var="regTeamSum_08_15" value="0"></c:set>
				            <c:set var="regTeamSum_07_15" value="0"></c:set>
				            <c:set var="regTeamSum_06_15" value="0"></c:set>
				            <c:set var="regTeamSum_05_15" value="0"></c:set>
				            <c:set var="regTeamSum_04_15" value="0"></c:set>
				            <c:set var="regTeamSum_03_15" value="0"></c:set>
				            <c:set var="regTeamSum_02_15" value="0"></c:set>
				            <c:set var="regTeamSum_01_15" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo2.rowCnt == 1}">
		    				<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="regTeamSum_12_15" value="0"></c:set>
				            <c:set var="regTeamSum_11_15" value="0"></c:set>
				            <c:set var="regTeamSum_10_15" value="0"></c:set>
				            <c:set var="regTeamSum_09_15" value="0"></c:set>
				            <c:set var="regTeamSum_08_15" value="0"></c:set>
				            <c:set var="regTeamSum_07_15" value="0"></c:set>
				            <c:set var="regTeamSum_06_15" value="0"></c:set>
				            <c:set var="regTeamSum_05_15" value="0"></c:set>
				            <c:set var="regTeamSum_04_15" value="0"></c:set>
				            <c:set var="regTeamSum_03_15" value="0"></c:set>
				            <c:set var="regTeamSum_02_15" value="0"></c:set>
				            <c:set var="regTeamSum_01_15" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 팀별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 팀별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 기타 소계 시작 -->
		    	<c:if test="${ptnrStatTeamAllRegList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="4" style="height:25px;">1종 기타 소계</th>
	                <!-- reg12 -->
	                <th>${regTeamTotalSum_12_15}</th>
	                <!-- reg11 -->
	                <th>${regTeamTotalSum_11_15}</th>
	                <!-- reg10 -->
	                <th>${regTeamTotalSum_10_15}</th>
	                <!-- reg09 -->
	                <th>${regTeamTotalSum_09_15}</th>
	                <!-- reg08 -->
	                <th>${regTeamTotalSum_08_15}</th>
	                <!-- reg07 -->
	                <th>${regTeamTotalSum_07_15}</th>
	                <!-- reg06 -->
	                <th>${regTeamTotalSum_06_15}</th>
	                <!-- reg05 -->
	                <th>${regTeamTotalSum_05_15}</th>
	                <!-- reg04 -->
	                <th>${regTeamTotalSum_04_15}</th>
	                <!-- reg03 -->
	                <th>${regTeamTotalSum_03_15}</th>
	                <!-- reg02 -->
	                <th>${regTeamTotalSum_02_15}</th>
	                <!-- reg01 -->
	                <th>${regTeamTotalSum_01_15}</th>
	                <!-- 가로열 합계 -->
	                <c:set var="regColTotalSum_15" value="${regTeamTotalSum_12_15 + regTeamTotalSum_11_15 + regTeamTotalSum_10_15 + regTeamTotalSum_09_15 + regTeamTotalSum_08_15 + regTeamTotalSum_07_15 + regTeamTotalSum_06_15 + regTeamTotalSum_05_15 + regTeamTotalSum_04_15 + regTeamTotalSum_03_15 + regTeamTotalSum_02_15 + regTeamTotalSum_01_15}"></c:set>
	                <th>${regColTotalSum_15}</th>
	            </tr>
	            </c:if>
		    	<!-- 1종 기타 소계 끝 -->
    		</tbody>
    	</table>
    	<!-- 1종 기타 끝 -->  	        
    </div>    
    <!-- 총 합계 시작 -->
    <!-- 총 합계 변수 시작 -->
    <c:set var="regTeamTotalSum_12_all" value="${regTeamTotalSum_12_5 + regTeamTotalSum_12_10 + regTeamTotalSum_12_15}"></c:set>
    <c:set var="regTeamTotalSum_11_all" value="${regTeamTotalSum_11_5 + regTeamTotalSum_11_10 + regTeamTotalSum_11_15}"></c:set>
    <c:set var="regTeamTotalSum_10_all" value="${regTeamTotalSum_10_5 + regTeamTotalSum_10_10 + regTeamTotalSum_10_15}"></c:set>
    <c:set var="regTeamTotalSum_09_all" value="${regTeamTotalSum_09_5 + regTeamTotalSum_09_10 + regTeamTotalSum_09_15}"></c:set>
    <c:set var="regTeamTotalSum_08_all" value="${regTeamTotalSum_08_5 + regTeamTotalSum_08_10 + regTeamTotalSum_08_15}"></c:set>
    <c:set var="regTeamTotalSum_07_all" value="${regTeamTotalSum_07_5 + regTeamTotalSum_07_10 + regTeamTotalSum_07_15}"></c:set>
    <c:set var="regTeamTotalSum_06_all" value="${regTeamTotalSum_06_5 + regTeamTotalSum_06_10 + regTeamTotalSum_06_15}"></c:set>
    <c:set var="regTeamTotalSum_05_all" value="${regTeamTotalSum_05_5 + regTeamTotalSum_05_10 + regTeamTotalSum_05_15}"></c:set>
    <c:set var="regTeamTotalSum_04_all" value="${regTeamTotalSum_04_5 + regTeamTotalSum_04_10 + regTeamTotalSum_04_15}"></c:set>
    <c:set var="regTeamTotalSum_03_all" value="${regTeamTotalSum_03_5 + regTeamTotalSum_03_10 + regTeamTotalSum_03_15}"></c:set>
    <c:set var="regTeamTotalSum_02_all" value="${regTeamTotalSum_02_5 + regTeamTotalSum_02_10 + regTeamTotalSum_02_15}"></c:set>
    <c:set var="regTeamTotalSum_01_all" value="${regTeamTotalSum_01_5 + regTeamTotalSum_01_10 + regTeamTotalSum_01_15}"></c:set>        
    <c:set var="regTeamTotalSum_col_all" value="${regTeamTotalSum_12_all + regTeamTotalSum_11_all + regTeamTotalSum_10_all + regTeamTotalSum_09_all + regTeamTotalSum_08_all + regTeamTotalSum_07_all + regTeamTotalSum_06_all + regTeamTotalSum_05_all + regTeamTotalSum_04_all + regTeamTotalSum_03_all + regTeamTotalSum_02_all + regTeamTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 530px;height:25px;">전체합계</th>
                <th style="width: 80px;color:blue;">${regTeamTotalSum_12_all}</th>
                <th style="width: 80px;color:blue;">${regTeamTotalSum_11_all}</th>
                <th style="width: 80px;color:blue;">${regTeamTotalSum_10_all}</th>
                <th style="width: 80px;color:blue;">${regTeamTotalSum_09_all}</th>
                <th style="width: 80px;color:blue;">${regTeamTotalSum_08_all}</th>
                <th style="width: 80px;color:blue;">${regTeamTotalSum_07_all}</th>
                <th style="width: 80px;color:blue;">${regTeamTotalSum_06_all}</th>
                <th style="width: 80px;color:blue;">${regTeamTotalSum_05_all}</th>
                <th style="width: 80px;color:blue;">${regTeamTotalSum_04_all}</th>
                <th style="width: 80px;color:blue;">${regTeamTotalSum_03_all}</th>
                <th style="width: 80px;color:blue;">${regTeamTotalSum_02_all}</th>
                <th style="width: 80px;color:blue;">${regTeamTotalSum_01_all}</th>
				<th style="width: 80px;color:blue;">${regTeamTotalSum_col_all}</th>
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>
