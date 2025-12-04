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
   				<c:set var="preuserName" value=""></c:set>
   				
   				<!-- 직원별 계 -->
	            <c:set var="regMemberSum_12_5" value="0"></c:set>
	            <c:set var="regMemberSum_11_5" value="0"></c:set>
	            <c:set var="regMemberSum_10_5" value="0"></c:set>
	            <c:set var="regMemberSum_09_5" value="0"></c:set>
	            <c:set var="regMemberSum_08_5" value="0"></c:set>
	            <c:set var="regMemberSum_07_5" value="0"></c:set>
	            <c:set var="regMemberSum_06_5" value="0"></c:set>
	            <c:set var="regMemberSum_05_5" value="0"></c:set>
	            <c:set var="regMemberSum_04_5" value="0"></c:set>
	            <c:set var="regMemberSum_03_5" value="0"></c:set>
	            <c:set var="regMemberSum_02_5" value="0"></c:set>
	            <c:set var="regMemberSum_01_5" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="regMemberTotalSum_12_5" value="0"></c:set>
	            <c:set var="regMemberTotalSum_11_5" value="0"></c:set>
	            <c:set var="regMemberTotalSum_10_5" value="0"></c:set>
	            <c:set var="regMemberTotalSum_09_5" value="0"></c:set>
	            <c:set var="regMemberTotalSum_08_5" value="0"></c:set>
	            <c:set var="regMemberTotalSum_07_5" value="0"></c:set>
	            <c:set var="regMemberTotalSum_06_5" value="0"></c:set>
	            <c:set var="regMemberTotalSum_05_5" value="0"></c:set>
	            <c:set var="regMemberTotalSum_04_5" value="0"></c:set>
	            <c:set var="regMemberTotalSum_03_5" value="0"></c:set>
	            <c:set var="regMemberTotalSum_02_5" value="0"></c:set>
	            <c:set var="regMemberTotalSum_01_5" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="regColMemberTotalSum_5" value="0"></c:set>
   				    			
    			<c:forEach var="vo" items="${ptnrStatRegList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		    				<c:choose>
		    					<c:when test='${srchArg.tabMenu eq "team"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterMain');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
				                    	1종 조사
				                    </td>
		    					</c:when>
		    					<c:when test='${srchArg.tabMenu eq "member"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterMain');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
				                    	1종 조사
				                    </td>
		    					</c:when>
		    					<c:otherwise>
		    						<td onclick="goPtnrStatMenu('ptnrStatTeamMain');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
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
					            <c:set var="regMemberSum_12_5" value="0"></c:set>
					            <c:set var="regMemberSum_11_5" value="0"></c:set>
					            <c:set var="regMemberSum_10_5" value="0"></c:set>
					            <c:set var="regMemberSum_09_5" value="0"></c:set>
					            <c:set var="regMemberSum_08_5" value="0"></c:set>
					            <c:set var="regMemberSum_07_5" value="0"></c:set>
					            <c:set var="regMemberSum_06_5" value="0"></c:set>
					            <c:set var="regMemberSum_05_5" value="0"></c:set>
					            <c:set var="regMemberSum_04_5" value="0"></c:set>
					            <c:set var="regMemberSum_03_5" value="0"></c:set>
					            <c:set var="regMemberSum_02_5" value="0"></c:set>
					            <c:set var="regMemberSum_01_5" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${memberCnt == 1 and vo.userName != preuserName}">
		                				<td style="width:150px;" rowspan="${vo.rowCnt+1}">${vo.userName}</td>
		                				<td style="width:150px;">${vo.ptnrIdSubNm}</td>		                				
		                				<c:set var="preuserName" value="${vo.userName}"></c:set>
		                			</c:when>
		                			<c:otherwise>		                				
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
		                
		                <!-- 직원별 계 합산 -->
	    				<c:set var="regMemberSum_12_5" value="${regMemberSum_12_5+reg12_5}"></c:set>
			            <c:set var="regMemberSum_11_5" value="${regMemberSum_11_5+reg11_5}"></c:set>
			            <c:set var="regMemberSum_10_5" value="${regMemberSum_10_5+reg10_5}"></c:set>
			            <c:set var="regMemberSum_09_5" value="${regMemberSum_09_5+reg09_5}"></c:set>
			            <c:set var="regMemberSum_08_5" value="${regMemberSum_08_5+reg08_5}"></c:set>
			            <c:set var="regMemberSum_07_5" value="${regMemberSum_07_5+reg07_5}"></c:set>
			            <c:set var="regMemberSum_06_5" value="${regMemberSum_06_5+reg06_5}"></c:set>
			            <c:set var="regMemberSum_05_5" value="${regMemberSum_05_5+reg05_5}"></c:set>
			            <c:set var="regMemberSum_04_5" value="${regMemberSum_04_5+reg04_5}"></c:set>
			            <c:set var="regMemberSum_03_5" value="${regMemberSum_03_5+reg03_5}"></c:set>
			            <c:set var="regMemberSum_02_5" value="${regMemberSum_02_5+reg02_5}"></c:set>
			            <c:set var="regMemberSum_01_5" value="${regMemberSum_01_5+reg01_5}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="regMemberTotalSum_12_5" value="${regMemberTotalSum_12_5 + reg12_5}"></c:set>
	                    <c:set var="regMemberTotalSum_11_5" value="${regMemberTotalSum_11_5 + reg11_5}"></c:set>
	                    <c:set var="regMemberTotalSum_10_5" value="${regMemberTotalSum_10_5 + reg10_5}"></c:set>
	                    <c:set var="regMemberTotalSum_09_5" value="${regMemberTotalSum_09_5 + reg09_5}"></c:set>
	                    <c:set var="regMemberTotalSum_08_5" value="${regMemberTotalSum_08_5 + reg08_5}"></c:set>
	                    <c:set var="regMemberTotalSum_07_5" value="${regMemberTotalSum_07_5 + reg07_5}"></c:set>
	                    <c:set var="regMemberTotalSum_06_5" value="${regMemberTotalSum_06_5 + reg06_5}"></c:set>
	                    <c:set var="regMemberTotalSum_05_5" value="${regMemberTotalSum_05_5 + reg05_5}"></c:set>
	                    <c:set var="regMemberTotalSum_04_5" value="${regMemberTotalSum_04_5 + reg04_5}"></c:set>
	                    <c:set var="regMemberTotalSum_03_5" value="${regMemberTotalSum_03_5 + reg03_5}"></c:set>
	                    <c:set var="regMemberTotalSum_02_5" value="${regMemberTotalSum_02_5 + reg02_5}"></c:set>
	                    <c:set var="regMemberTotalSum_01_5" value="${regMemberTotalSum_01_5 + reg01_5}"></c:set>
		    		</tr>
		    		<!-- 직원별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${memberCnt == vo.rowCnt and vo.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- reg12 -->
			                <td style="width: 80px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2">${regMemberSum_12_5}</td>
			                <!-- reg11 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_11_5}</td>
			                <!-- reg10 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_10_5}</td>
			                <!-- reg09 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_09_5}</td>
			                <!-- reg08 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_08_5}</td>
			                <!-- reg07 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_07_5}</td>
			                <!-- reg06 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_06_5}</td>
			                <!-- reg05 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_05_5}</td>
			                <!-- reg04 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_04_5}</td>
			                <!-- reg03 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_03_5}</td>
			                <!-- reg02 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_02_5}</td>
			                <!-- reg01 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_01_5}</td>
			                <!-- 가로 합계 -->
			                <c:set var="regMemberColSum_5" value="${regMemberSum_12_5 + regMemberSum_11_5 + regMemberSum_10_5 + regMemberSum_09_5 + regMemberSum_08_5 + regMemberSum_07_5 + regMemberSum_06_5 + regMemberSum_05_5 + regMemberSum_04_5 + regMemberSum_03_5 + regMemberSum_02_5 + regMemberSum_01_5}"></c:set>                    
			                <td style="width: 80px;" class="sum-level-2">${regMemberColSum_5}</td>
			                
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="regMemberSum_12_5" value="0"></c:set>
				            <c:set var="regMemberSum_11_5" value="0"></c:set>
				            <c:set var="regMemberSum_10_5" value="0"></c:set>
				            <c:set var="regMemberSum_09_5" value="0"></c:set>
				            <c:set var="regMemberSum_08_5" value="0"></c:set>
				            <c:set var="regMemberSum_07_5" value="0"></c:set>
				            <c:set var="regMemberSum_06_5" value="0"></c:set>
				            <c:set var="regMemberSum_05_5" value="0"></c:set>
				            <c:set var="regMemberSum_04_5" value="0"></c:set>
				            <c:set var="regMemberSum_03_5" value="0"></c:set>
				            <c:set var="regMemberSum_02_5" value="0"></c:set>
				            <c:set var="regMemberSum_01_5" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo.rowCnt == 1}">
		    				<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="regMemberSum_12_5" value="0"></c:set>
				            <c:set var="regMemberSum_11_5" value="0"></c:set>
				            <c:set var="regMemberSum_10_5" value="0"></c:set>
				            <c:set var="regMemberSum_09_5" value="0"></c:set>
				            <c:set var="regMemberSum_08_5" value="0"></c:set>
				            <c:set var="regMemberSum_07_5" value="0"></c:set>
				            <c:set var="regMemberSum_06_5" value="0"></c:set>
				            <c:set var="regMemberSum_05_5" value="0"></c:set>
				            <c:set var="regMemberSum_04_5" value="0"></c:set>
				            <c:set var="regMemberSum_03_5" value="0"></c:set>
				            <c:set var="regMemberSum_02_5" value="0"></c:set>
				            <c:set var="regMemberSum_01_5" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 직원별 계 카운트 증가 -->
		    				<c:set var="memberCnt" value="${memberCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 직원별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 조사 소계 시작 -->
		    	<c:if test="${ptnrStatRegList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 조사 소계</th>
	                <!-- reg12 -->
	                <th>${regMemberTotalSum_12_5}</th>
	                <!-- reg11 -->
	                <th>${regMemberTotalSum_11_5}</th>
	                <!-- reg10 -->
	                <th>${regMemberTotalSum_10_5}</th>
	                <!-- reg09 -->
	                <th>${regMemberTotalSum_09_5}</th>
	                <!-- reg08 -->
	                <th>${regMemberTotalSum_08_5}</th>
	                <!-- reg07 -->
	                <th>${regMemberTotalSum_07_5}</th>
	                <!-- reg06 -->
	                <th>${regMemberTotalSum_06_5}</th>
	                <!-- reg05 -->
	                <th>${regMemberTotalSum_05_5}</th>
	                <!-- reg04 -->
	                <th>${regMemberTotalSum_04_5}</th>
	                <!-- reg03 -->
	                <th>${regMemberTotalSum_03_5}</th>
	                <!-- reg02 -->
	                <th>${regMemberTotalSum_02_5}</th>
	                <!-- reg01 -->
	                <th>${regMemberTotalSum_01_5}</th>
	                <!-- 가로열 합계 -->
	                <c:set var="regColTotalSum_5" value="${regMemberTotalSum_12_5 + regMemberTotalSum_11_5 + regMemberTotalSum_10_5 + regMemberTotalSum_09_5 + regMemberTotalSum_08_5 + regMemberTotalSum_07_5 + regMemberTotalSum_06_5 + regMemberTotalSum_05_5 + regMemberTotalSum_04_5 + regMemberTotalSum_03_5 + regMemberTotalSum_02_5 + regMemberTotalSum_01_5}"></c:set>
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
   				<!-- 직원별 계를 만들기 위한 변수 -->
   				<c:set var="memberCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 직원명 -->
   				<c:set var="preuserName" value=""></c:set>
   				
   				<!-- 직원별 계 -->
	            <c:set var="regMemberSum_12_10" value="0"></c:set>
	            <c:set var="regMemberSum_11_10" value="0"></c:set>
	            <c:set var="regMemberSum_10_10" value="0"></c:set>
	            <c:set var="regMemberSum_09_10" value="0"></c:set>
	            <c:set var="regMemberSum_08_10" value="0"></c:set>
	            <c:set var="regMemberSum_07_10" value="0"></c:set>
	            <c:set var="regMemberSum_06_10" value="0"></c:set>
	            <c:set var="regMemberSum_05_10" value="0"></c:set>
	            <c:set var="regMemberSum_04_10" value="0"></c:set>
	            <c:set var="regMemberSum_03_10" value="0"></c:set>
	            <c:set var="regMemberSum_02_10" value="0"></c:set>
	            <c:set var="regMemberSum_01_10" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="regMemberTotalSum_12_10" value="0"></c:set>
	            <c:set var="regMemberTotalSum_11_10" value="0"></c:set>
	            <c:set var="regMemberTotalSum_10_10" value="0"></c:set>
	            <c:set var="regMemberTotalSum_09_10" value="0"></c:set>
	            <c:set var="regMemberTotalSum_08_10" value="0"></c:set>
	            <c:set var="regMemberTotalSum_07_10" value="0"></c:set>
	            <c:set var="regMemberTotalSum_06_10" value="0"></c:set>
	            <c:set var="regMemberTotalSum_05_10" value="0"></c:set>
	            <c:set var="regMemberTotalSum_04_10" value="0"></c:set>
	            <c:set var="regMemberTotalSum_03_10" value="0"></c:set>
	            <c:set var="regMemberTotalSum_02_10" value="0"></c:set>
	            <c:set var="regMemberTotalSum_01_10" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="regColMemberTotalSum_10" value="0"></c:set>
   				    			
    			<c:forEach var="vo1" items="${ptnrStatRegList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
			    			<c:choose>
		    					<c:when test='${srchArg.tabMenu eq "team"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterMain');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
				                    	1종 심사
				                    </td>
		    					</c:when>
		    					<c:when test='${srchArg.tabMenu eq "member"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterMain');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
				                    	1종 심사
				                    </td>
		    					</c:when>
		    					<c:otherwise>
		    						<td onclick="goPtnrStatMenu('ptnrStatTeamMain');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
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
					            <c:set var="regMemberSum_12_10" value="0"></c:set>
					            <c:set var="regMemberSum_11_10" value="0"></c:set>
					            <c:set var="regMemberSum_10_10" value="0"></c:set>
					            <c:set var="regMemberSum_09_10" value="0"></c:set>
					            <c:set var="regMemberSum_08_10" value="0"></c:set>
					            <c:set var="regMemberSum_07_10" value="0"></c:set>
					            <c:set var="regMemberSum_06_10" value="0"></c:set>
					            <c:set var="regMemberSum_05_10" value="0"></c:set>
					            <c:set var="regMemberSum_04_10" value="0"></c:set>
					            <c:set var="regMemberSum_03_10" value="0"></c:set>
					            <c:set var="regMemberSum_02_10" value="0"></c:set>
					            <c:set var="regMemberSum_01_10" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${memberCnt == 1 and vo1.userName != preuserName}">
		                				<td style="width:150px;" rowspan="${vo1.rowCnt+1}">${vo1.userName}</td>
		                				<td style="width:150px;">${vo1.ptnrIdSubNm}</td>		                				
		                				<c:set var="preuserName" value="${vo1.userName}"></c:set>
		                			</c:when>
		                			<c:otherwise>		                				
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
		                
		                <!-- 직원별 계 합산 -->
	    				<c:set var="regMemberSum_12_10" value="${regMemberSum_12_10+reg12_10}"></c:set>
			            <c:set var="regMemberSum_11_10" value="${regMemberSum_11_10+reg11_10}"></c:set>
			            <c:set var="regMemberSum_10_10" value="${regMemberSum_10_10+reg10_10}"></c:set>
			            <c:set var="regMemberSum_09_10" value="${regMemberSum_09_10+reg09_10}"></c:set>
			            <c:set var="regMemberSum_08_10" value="${regMemberSum_08_10+reg08_10}"></c:set>
			            <c:set var="regMemberSum_07_10" value="${regMemberSum_07_10+reg07_10}"></c:set>
			            <c:set var="regMemberSum_06_10" value="${regMemberSum_06_10+reg06_10}"></c:set>
			            <c:set var="regMemberSum_05_10" value="${regMemberSum_05_10+reg05_10}"></c:set>
			            <c:set var="regMemberSum_04_10" value="${regMemberSum_04_10+reg04_10}"></c:set>
			            <c:set var="regMemberSum_03_10" value="${regMemberSum_03_10+reg03_10}"></c:set>
			            <c:set var="regMemberSum_02_10" value="${regMemberSum_02_10+reg02_10}"></c:set>
			            <c:set var="regMemberSum_01_10" value="${regMemberSum_01_10+reg01_10}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="regMemberTotalSum_12_10" value="${regMemberTotalSum_12_10 + reg12_10}"></c:set>
	                    <c:set var="regMemberTotalSum_11_10" value="${regMemberTotalSum_11_10 + reg11_10}"></c:set>
	                    <c:set var="regMemberTotalSum_10_10" value="${regMemberTotalSum_10_10 + reg10_10}"></c:set>
	                    <c:set var="regMemberTotalSum_09_10" value="${regMemberTotalSum_09_10 + reg09_10}"></c:set>
	                    <c:set var="regMemberTotalSum_08_10" value="${regMemberTotalSum_08_10 + reg08_10}"></c:set>
	                    <c:set var="regMemberTotalSum_07_10" value="${regMemberTotalSum_07_10 + reg07_10}"></c:set>
	                    <c:set var="regMemberTotalSum_06_10" value="${regMemberTotalSum_06_10 + reg06_10}"></c:set>
	                    <c:set var="regMemberTotalSum_05_10" value="${regMemberTotalSum_05_10 + reg05_10}"></c:set>
	                    <c:set var="regMemberTotalSum_04_10" value="${regMemberTotalSum_04_10 + reg04_10}"></c:set>
	                    <c:set var="regMemberTotalSum_03_10" value="${regMemberTotalSum_03_10 + reg03_10}"></c:set>
	                    <c:set var="regMemberTotalSum_02_10" value="${regMemberTotalSum_02_10 + reg02_10}"></c:set>
	                    <c:set var="regMemberTotalSum_01_10" value="${regMemberTotalSum_01_10 + reg01_10}"></c:set>
		    		</tr>
		    		<!-- 직원별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${memberCnt == vo1.rowCnt and vo1.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- reg12 -->
			                <td style="width: 80px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2">${regMemberSum_12_10}</td>
			                <!-- reg11 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_11_10}</td>
			                <!-- reg10 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_10_10}</td>
			                <!-- reg09 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_09_10}</td>
			                <!-- reg08 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_08_10}</td>
			                <!-- reg07 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_07_10}</td>
			                <!-- reg06 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_06_10}</td>
			                <!-- reg05 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_05_10}</td>
			                <!-- reg04 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_04_10}</td>
			                <!-- reg03 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_03_10}</td>
			                <!-- reg02 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_02_10}</td>
			                <!-- reg01 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_01_10}</td>
			                <!-- 가로 합계 -->
			                <c:set var="regMemberColSum_10" value="${regMemberSum_12_10 + regMemberSum_11_10 + regMemberSum_10_10 + regMemberSum_09_10 + regMemberSum_08_10 + regMemberSum_07_10 + regMemberSum_06_10 + regMemberSum_05_10 + regMemberSum_04_10 + regMemberSum_03_10 + regMemberSum_02_10 + regMemberSum_01_10}"></c:set>                    
			                <td style="width: 80px;" class="sum-level-2">${regMemberColSum_10}</td>
			                
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="regMemberSum_12_10" value="0"></c:set>
				            <c:set var="regMemberSum_11_10" value="0"></c:set>
				            <c:set var="regMemberSum_10_10" value="0"></c:set>
				            <c:set var="regMemberSum_09_10" value="0"></c:set>
				            <c:set var="regMemberSum_08_10" value="0"></c:set>
				            <c:set var="regMemberSum_07_10" value="0"></c:set>
				            <c:set var="regMemberSum_06_10" value="0"></c:set>
				            <c:set var="regMemberSum_05_10" value="0"></c:set>
				            <c:set var="regMemberSum_04_10" value="0"></c:set>
				            <c:set var="regMemberSum_03_10" value="0"></c:set>
				            <c:set var="regMemberSum_02_10" value="0"></c:set>
				            <c:set var="regMemberSum_01_10" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo1.rowCnt == 1}">
		    				<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="regMemberSum_12_10" value="0"></c:set>
				            <c:set var="regMemberSum_11_10" value="0"></c:set>
				            <c:set var="regMemberSum_10_10" value="0"></c:set>
				            <c:set var="regMemberSum_09_10" value="0"></c:set>
				            <c:set var="regMemberSum_08_10" value="0"></c:set>
				            <c:set var="regMemberSum_07_10" value="0"></c:set>
				            <c:set var="regMemberSum_06_10" value="0"></c:set>
				            <c:set var="regMemberSum_05_10" value="0"></c:set>
				            <c:set var="regMemberSum_04_10" value="0"></c:set>
				            <c:set var="regMemberSum_03_10" value="0"></c:set>
				            <c:set var="regMemberSum_02_10" value="0"></c:set>
				            <c:set var="regMemberSum_01_10" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 직원별 계 카운트 증가 -->
		    				<c:set var="memberCnt" value="${memberCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 직원별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 심사 소계 시작 -->
		    	<c:if test="${ptnrStatRegList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 심사 소계</th>
	                <!-- reg12 -->
	                <th>${regMemberTotalSum_12_10}</th>
	                <!-- reg11 -->
	                <th>${regMemberTotalSum_11_10}</th>
	                <!-- reg10 -->
	                <th>${regMemberTotalSum_10_10}</th>
	                <!-- reg09 -->
	                <th>${regMemberTotalSum_09_10}</th>
	                <!-- reg08 -->
	                <th>${regMemberTotalSum_08_10}</th>
	                <!-- reg07 -->
	                <th>${regMemberTotalSum_07_10}</th>
	                <!-- reg06 -->
	                <th>${regMemberTotalSum_06_10}</th>
	                <!-- reg05 -->
	                <th>${regMemberTotalSum_05_10}</th>
	                <!-- reg04 -->
	                <th>${regMemberTotalSum_04_10}</th>
	                <!-- reg03 -->
	                <th>${regMemberTotalSum_03_10}</th>
	                <!-- reg02 -->
	                <th>${regMemberTotalSum_02_10}</th>
	                <!-- reg01 -->
	                <th>${regMemberTotalSum_01_10}</th>
	                <!-- 가로열 합계 -->
	                <c:set var="regColTotalSum_10" value="${regMemberTotalSum_12_10 + regMemberTotalSum_11_10 + regMemberTotalSum_10_10 + regMemberTotalSum_09_10 + regMemberTotalSum_08_10 + regMemberTotalSum_07_10 + regMemberTotalSum_06_10 + regMemberTotalSum_05_10 + regMemberTotalSum_04_10 + regMemberTotalSum_03_10 + regMemberTotalSum_02_10 + regMemberTotalSum_01_10}"></c:set>
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
   				<!-- 직원별 계를 만들기 위한 변수 -->
   				<c:set var="memberCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 직원명 -->
   				<c:set var="preuserName" value=""></c:set>
   				
   				<!-- 직원별 계 -->
	            <c:set var="regMemberSum_12_15" value="0"></c:set>
	            <c:set var="regMemberSum_11_15" value="0"></c:set>
	            <c:set var="regMemberSum_10_15" value="0"></c:set>
	            <c:set var="regMemberSum_09_15" value="0"></c:set>
	            <c:set var="regMemberSum_08_15" value="0"></c:set>
	            <c:set var="regMemberSum_07_15" value="0"></c:set>
	            <c:set var="regMemberSum_06_15" value="0"></c:set>
	            <c:set var="regMemberSum_05_15" value="0"></c:set>
	            <c:set var="regMemberSum_04_15" value="0"></c:set>
	            <c:set var="regMemberSum_03_15" value="0"></c:set>
	            <c:set var="regMemberSum_02_15" value="0"></c:set>
	            <c:set var="regMemberSum_01_15" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="regMemberTotalSum_12_15" value="0"></c:set>
	            <c:set var="regMemberTotalSum_11_15" value="0"></c:set>
	            <c:set var="regMemberTotalSum_10_15" value="0"></c:set>
	            <c:set var="regMemberTotalSum_09_15" value="0"></c:set>
	            <c:set var="regMemberTotalSum_08_15" value="0"></c:set>
	            <c:set var="regMemberTotalSum_07_15" value="0"></c:set>
	            <c:set var="regMemberTotalSum_06_15" value="0"></c:set>
	            <c:set var="regMemberTotalSum_05_15" value="0"></c:set>
	            <c:set var="regMemberTotalSum_04_15" value="0"></c:set>
	            <c:set var="regMemberTotalSum_03_15" value="0"></c:set>
	            <c:set var="regMemberTotalSum_02_15" value="0"></c:set>
	            <c:set var="regMemberTotalSum_01_15" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="regColMemberTotalSum_15" value="0"></c:set>
   				    			
    			<c:forEach var="vo2" items="${ptnrStatRegList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <c:choose>
		    					<c:when test='${srchArg.tabMenu eq "team"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterMain');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
				                    	1종 기타
				                    </td>
		    					</c:when>
		    					<c:when test='${srchArg.tabMenu eq "member"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterMain');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
				                    	1종 기타
				                    </td>
		    					</c:when>
		    					<c:otherwise>
		    						<td onclick="goPtnrStatMenu('ptnrStatTeamMain');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
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
					            <c:set var="regMemberSum_12_15" value="0"></c:set>
					            <c:set var="regMemberSum_11_15" value="0"></c:set>
					            <c:set var="regMemberSum_10_15" value="0"></c:set>
					            <c:set var="regMemberSum_09_15" value="0"></c:set>
					            <c:set var="regMemberSum_08_15" value="0"></c:set>
					            <c:set var="regMemberSum_07_15" value="0"></c:set>
					            <c:set var="regMemberSum_06_15" value="0"></c:set>
					            <c:set var="regMemberSum_05_15" value="0"></c:set>
					            <c:set var="regMemberSum_04_15" value="0"></c:set>
					            <c:set var="regMemberSum_03_15" value="0"></c:set>
					            <c:set var="regMemberSum_02_15" value="0"></c:set>
					            <c:set var="regMemberSum_01_15" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${memberCnt == 1 and vo2.userName != preuserName}">
		                				<td style="width:150px;" rowspan="${vo2.rowCnt+1}">${vo2.userName}</td>
		                				<td style="width:150px;">${vo2.ptnrIdSubNm}</td>		                				
		                				<c:set var="preuserName" value="${vo2.userName}"></c:set>
		                			</c:when>
		                			<c:otherwise>		                				
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
		                
		                <!-- 직원별 계 합산 -->
	    				<c:set var="regMemberSum_12_15" value="${regMemberSum_12_15+reg12_15}"></c:set>
			            <c:set var="regMemberSum_11_15" value="${regMemberSum_11_15+reg11_15}"></c:set>
			            <c:set var="regMemberSum_10_15" value="${regMemberSum_10_15+reg10_15}"></c:set>
			            <c:set var="regMemberSum_09_15" value="${regMemberSum_09_15+reg09_15}"></c:set>
			            <c:set var="regMemberSum_08_15" value="${regMemberSum_08_15+reg08_15}"></c:set>
			            <c:set var="regMemberSum_07_15" value="${regMemberSum_07_15+reg07_15}"></c:set>
			            <c:set var="regMemberSum_06_15" value="${regMemberSum_06_15+reg06_15}"></c:set>
			            <c:set var="regMemberSum_05_15" value="${regMemberSum_05_15+reg05_15}"></c:set>
			            <c:set var="regMemberSum_04_15" value="${regMemberSum_04_15+reg04_15}"></c:set>
			            <c:set var="regMemberSum_03_15" value="${regMemberSum_03_15+reg03_15}"></c:set>
			            <c:set var="regMemberSum_02_15" value="${regMemberSum_02_15+reg02_15}"></c:set>
			            <c:set var="regMemberSum_01_15" value="${regMemberSum_01_15+reg01_15}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="regMemberTotalSum_12_15" value="${regMemberTotalSum_12_15 + reg12_15}"></c:set>
	                    <c:set var="regMemberTotalSum_11_15" value="${regMemberTotalSum_11_15 + reg11_15}"></c:set>
	                    <c:set var="regMemberTotalSum_10_15" value="${regMemberTotalSum_10_15 + reg10_15}"></c:set>
	                    <c:set var="regMemberTotalSum_09_15" value="${regMemberTotalSum_09_15 + reg09_15}"></c:set>
	                    <c:set var="regMemberTotalSum_08_15" value="${regMemberTotalSum_08_15 + reg08_15}"></c:set>
	                    <c:set var="regMemberTotalSum_07_15" value="${regMemberTotalSum_07_15 + reg07_15}"></c:set>
	                    <c:set var="regMemberTotalSum_06_15" value="${regMemberTotalSum_06_15 + reg06_15}"></c:set>
	                    <c:set var="regMemberTotalSum_05_15" value="${regMemberTotalSum_05_15 + reg05_15}"></c:set>
	                    <c:set var="regMemberTotalSum_04_15" value="${regMemberTotalSum_04_15 + reg04_15}"></c:set>
	                    <c:set var="regMemberTotalSum_03_15" value="${regMemberTotalSum_03_15 + reg03_15}"></c:set>
	                    <c:set var="regMemberTotalSum_02_15" value="${regMemberTotalSum_02_15 + reg02_15}"></c:set>
	                    <c:set var="regMemberTotalSum_01_15" value="${regMemberTotalSum_01_15 + reg01_15}"></c:set>
		    		</tr>
		    		<!-- 직원별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${memberCnt == vo2.rowCnt and vo2.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">계</td>
		    				<!-- reg12 -->
			                <td style="width: 80px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2">${regMemberSum_12_15}</td>
			                <!-- reg11 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_11_15}</td>
			                <!-- reg10 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_10_15}</td>
			                <!-- reg09 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_09_15}</td>
			                <!-- reg08 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_08_15}</td>
			                <!-- reg07 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_07_15}</td>
			                <!-- reg06 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_06_15}</td>
			                <!-- reg05 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_05_15}</td>
			                <!-- reg04 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_04_15}</td>
			                <!-- reg03 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_03_15}</td>
			                <!-- reg02 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_02_15}</td>
			                <!-- reg01 -->
			                <td style="width: 80px;" class="sum-level-2">${regMemberSum_01_15}</td>
			                <!-- 가로 합계 -->
			                <c:set var="regMemberColSum_15" value="${regMemberSum_12_15 + regMemberSum_11_15 + regMemberSum_10_15 + regMemberSum_09_15 + regMemberSum_08_15 + regMemberSum_07_15 + regMemberSum_06_15 + regMemberSum_05_15 + regMemberSum_04_15 + regMemberSum_03_15 + regMemberSum_02_15 + regMemberSum_01_15}"></c:set>                    
			                <td style="width: 80px;" class="sum-level-2">${regMemberColSum_15}</td>
			                
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="regMemberSum_12_15" value="0"></c:set>
				            <c:set var="regMemberSum_11_15" value="0"></c:set>
				            <c:set var="regMemberSum_10_15" value="0"></c:set>
				            <c:set var="regMemberSum_09_15" value="0"></c:set>
				            <c:set var="regMemberSum_08_15" value="0"></c:set>
				            <c:set var="regMemberSum_07_15" value="0"></c:set>
				            <c:set var="regMemberSum_06_15" value="0"></c:set>
				            <c:set var="regMemberSum_05_15" value="0"></c:set>
				            <c:set var="regMemberSum_04_15" value="0"></c:set>
				            <c:set var="regMemberSum_03_15" value="0"></c:set>
				            <c:set var="regMemberSum_02_15" value="0"></c:set>
				            <c:set var="regMemberSum_01_15" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo2.rowCnt == 1}">
		    				<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="regMemberSum_12_15" value="0"></c:set>
				            <c:set var="regMemberSum_11_15" value="0"></c:set>
				            <c:set var="regMemberSum_10_15" value="0"></c:set>
				            <c:set var="regMemberSum_09_15" value="0"></c:set>
				            <c:set var="regMemberSum_08_15" value="0"></c:set>
				            <c:set var="regMemberSum_07_15" value="0"></c:set>
				            <c:set var="regMemberSum_06_15" value="0"></c:set>
				            <c:set var="regMemberSum_05_15" value="0"></c:set>
				            <c:set var="regMemberSum_04_15" value="0"></c:set>
				            <c:set var="regMemberSum_03_15" value="0"></c:set>
				            <c:set var="regMemberSum_02_15" value="0"></c:set>
				            <c:set var="regMemberSum_01_15" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 직원별 계 카운트 증가 -->
		    				<c:set var="memberCnt" value="${memberCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 직원별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 기타 소계 시작 -->
		    	<c:if test="${ptnrStatRegList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 기타 소계</th>
	                <!-- reg12 -->
	                <th>${regMemberTotalSum_12_15}</th>
	                <!-- reg11 -->
	                <th>${regMemberTotalSum_11_15}</th>
	                <!-- reg10 -->
	                <th>${regMemberTotalSum_10_15}</th>
	                <!-- reg09 -->
	                <th>${regMemberTotalSum_09_15}</th>
	                <!-- reg08 -->
	                <th>${regMemberTotalSum_08_15}</th>
	                <!-- reg07 -->
	                <th>${regMemberTotalSum_07_15}</th>
	                <!-- reg06 -->
	                <th>${regMemberTotalSum_06_15}</th>
	                <!-- reg05 -->
	                <th>${regMemberTotalSum_05_15}</th>
	                <!-- reg04 -->
	                <th>${regMemberTotalSum_04_15}</th>
	                <!-- reg03 -->
	                <th>${regMemberTotalSum_03_15}</th>
	                <!-- reg02 -->
	                <th>${regMemberTotalSum_02_15}</th>
	                <!-- reg01 -->
	                <th>${regMemberTotalSum_01_15}</th>
	                <!-- 가로열 합계 -->
	                <c:set var="regColTotalSum_15" value="${regMemberTotalSum_12_15 + regMemberTotalSum_11_15 + regMemberTotalSum_10_15 + regMemberTotalSum_09_15 + regMemberTotalSum_08_15 + regMemberTotalSum_07_15 + regMemberTotalSum_06_15 + regMemberTotalSum_05_15 + regMemberTotalSum_04_15 + regMemberTotalSum_03_15 + regMemberTotalSum_02_15 + regMemberTotalSum_01_15}"></c:set>
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
    <c:set var="regMemberTotalSum_12_all" value="${regMemberTotalSum_12_5 + regMemberTotalSum_12_10 + regMemberTotalSum_12_15}"></c:set>
    <c:set var="regMemberTotalSum_11_all" value="${regMemberTotalSum_11_5 + regMemberTotalSum_11_10 + regMemberTotalSum_11_15}"></c:set>
    <c:set var="regMemberTotalSum_10_all" value="${regMemberTotalSum_10_5 + regMemberTotalSum_10_10 + regMemberTotalSum_10_15}"></c:set>
    <c:set var="regMemberTotalSum_09_all" value="${regMemberTotalSum_09_5 + regMemberTotalSum_09_10 + regMemberTotalSum_09_15}"></c:set>
    <c:set var="regMemberTotalSum_08_all" value="${regMemberTotalSum_08_5 + regMemberTotalSum_08_10 + regMemberTotalSum_08_15}"></c:set>
    <c:set var="regMemberTotalSum_07_all" value="${regMemberTotalSum_07_5 + regMemberTotalSum_07_10 + regMemberTotalSum_07_15}"></c:set>
    <c:set var="regMemberTotalSum_06_all" value="${regMemberTotalSum_06_5 + regMemberTotalSum_06_10 + regMemberTotalSum_06_15}"></c:set>
    <c:set var="regMemberTotalSum_05_all" value="${regMemberTotalSum_05_5 + regMemberTotalSum_05_10 + regMemberTotalSum_05_15}"></c:set>
    <c:set var="regMemberTotalSum_04_all" value="${regMemberTotalSum_04_5 + regMemberTotalSum_04_10 + regMemberTotalSum_04_15}"></c:set>
    <c:set var="regMemberTotalSum_03_all" value="${regMemberTotalSum_03_5 + regMemberTotalSum_03_10 + regMemberTotalSum_03_15}"></c:set>
    <c:set var="regMemberTotalSum_02_all" value="${regMemberTotalSum_02_5 + regMemberTotalSum_02_10 + regMemberTotalSum_02_15}"></c:set>
    <c:set var="regMemberTotalSum_01_all" value="${regMemberTotalSum_01_5 + regMemberTotalSum_01_10 + regMemberTotalSum_01_15}"></c:set>        
    <c:set var="regMemberTotalSum_col_all" value="${regMemberTotalSum_12_all + regMemberTotalSum_11_all + regMemberTotalSum_10_all + regMemberTotalSum_09_all + regMemberTotalSum_08_all + regMemberTotalSum_07_all + regMemberTotalSum_06_all + regMemberTotalSum_05_all + regMemberTotalSum_04_all + regMemberTotalSum_03_all + regMemberTotalSum_02_all + regMemberTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체합계</th>
                <th style="width: 80px;color:blue;">${regMemberTotalSum_12_all}</th>
                <th style="width: 80px;color:blue;">${regMemberTotalSum_11_all}</th>
                <th style="width: 80px;color:blue;">${regMemberTotalSum_10_all}</th>
                <th style="width: 80px;color:blue;">${regMemberTotalSum_09_all}</th>
                <th style="width: 80px;color:blue;">${regMemberTotalSum_08_all}</th>
                <th style="width: 80px;color:blue;">${regMemberTotalSum_07_all}</th>
                <th style="width: 80px;color:blue;">${regMemberTotalSum_06_all}</th>
                <th style="width: 80px;color:blue;">${regMemberTotalSum_05_all}</th>
                <th style="width: 80px;color:blue;">${regMemberTotalSum_04_all}</th>
                <th style="width: 80px;color:blue;">${regMemberTotalSum_03_all}</th>
                <th style="width: 80px;color:blue;">${regMemberTotalSum_02_all}</th>
                <th style="width: 80px;color:blue;">${regMemberTotalSum_01_all}</th>
				<th style="width: 80px;color:blue;">${regMemberTotalSum_col_all}</th>
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>
