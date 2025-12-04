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
	            <c:set var="regMemberAllSum_12_5" value="0"></c:set>
	            <c:set var="regMemberAllSum_11_5" value="0"></c:set>
	            <c:set var="regMemberAllSum_10_5" value="0"></c:set>
	            <c:set var="regMemberAllSum_09_5" value="0"></c:set>
	            <c:set var="regMemberAllSum_08_5" value="0"></c:set>
	            <c:set var="regMemberAllSum_07_5" value="0"></c:set>
	            <c:set var="regMemberAllSum_06_5" value="0"></c:set>
	            <c:set var="regMemberAllSum_05_5" value="0"></c:set>
	            <c:set var="regMemberAllSum_04_5" value="0"></c:set>
	            <c:set var="regMemberAllSum_03_5" value="0"></c:set>
	            <c:set var="regMemberAllSum_02_5" value="0"></c:set>
	            <c:set var="regMemberAllSum_01_5" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="regMemberAllTotalSum_12_5" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_11_5" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_10_5" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_09_5" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_08_5" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_07_5" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_06_5" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_05_5" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_04_5" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_03_5" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_02_5" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_01_5" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="regColMemberAllTotalSum_5" value="0"></c:set>
   				    			
    			<c:forEach var="vo" items="${ptnrStatMemberAllRegList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">		    				
    						<td onclick="goPtnrStatMenu('ptnrStatMain');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowMemberAll}">
		                    	1종 조사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo.rowCnt == 1}">
		                		<td onclick="goPtnrStatTeam( '${vo.ptnrId}', '${vo.teamCenter}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>
		                		<td onclick="goPtnrStatMember( '${vo.ptnrId}', '${vo.teamId}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.teamName}</td>
		                		<td style="width:150px;">${vo.userName}</td>
		                		<td style="width:150px;">${vo.ptnrIdSubNm}</td>		                		
		                		<!-- 직원별 계 초기화 -->
					            <c:set var="regMemberAllSum_12_5" value="0"></c:set>
					            <c:set var="regMemberAllSum_11_5" value="0"></c:set>
					            <c:set var="regMemberAllSum_10_5" value="0"></c:set>
					            <c:set var="regMemberAllSum_09_5" value="0"></c:set>
					            <c:set var="regMemberAllSum_08_5" value="0"></c:set>
					            <c:set var="regMemberAllSum_07_5" value="0"></c:set>
					            <c:set var="regMemberAllSum_06_5" value="0"></c:set>
					            <c:set var="regMemberAllSum_05_5" value="0"></c:set>
					            <c:set var="regMemberAllSum_04_5" value="0"></c:set>
					            <c:set var="regMemberAllSum_03_5" value="0"></c:set>
					            <c:set var="regMemberAllSum_02_5" value="0"></c:set>
					            <c:set var="regMemberAllSum_01_5" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${memberCnt == 1 and vo.userName != preUserName}">
		                				<td onclick="goPtnrStatTeam( '${vo.ptnrId}', '${vo.teamCenter}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>
										<td onclick="goPtnrStatMember( '${vo.ptnrId}', '${vo.teamId}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.teamName}</td>
		                				<td style="width:150px;" rowspan="${vo.rowCnt+1}">${vo.userName}</td>
		                				<td style="width:150px;">${vo.ptnrIdSubNm}</td>		                				
		                				<c:set var="preUserName" value="${vo.userName}"></c:set>
		                			</c:when>
		                			<c:otherwise>
		                				<td onclick="goPtnrStatTeam( '${vo.ptnrId}', '${vo.teamCenter}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>
										<td onclick="goPtnrStatMember( '${vo.ptnrId}', '${vo.teamId}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.teamName}</td>		                				
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
		                <td style="width: 80px;">${reg12_5}</td>
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
	    				<c:set var="regMemberAllSum_12_5" value="${regMemberAllSum_12_5+reg12_5}"></c:set>
			            <c:set var="regMemberAllSum_11_5" value="${regMemberAllSum_11_5+reg11_5}"></c:set>
			            <c:set var="regMemberAllSum_10_5" value="${regMemberAllSum_10_5+reg10_5}"></c:set>
			            <c:set var="regMemberAllSum_09_5" value="${regMemberAllSum_09_5+reg09_5}"></c:set>
			            <c:set var="regMemberAllSum_08_5" value="${regMemberAllSum_08_5+reg08_5}"></c:set>
			            <c:set var="regMemberAllSum_07_5" value="${regMemberAllSum_07_5+reg07_5}"></c:set>
			            <c:set var="regMemberAllSum_06_5" value="${regMemberAllSum_06_5+reg06_5}"></c:set>
			            <c:set var="regMemberAllSum_05_5" value="${regMemberAllSum_05_5+reg05_5}"></c:set>
			            <c:set var="regMemberAllSum_04_5" value="${regMemberAllSum_04_5+reg04_5}"></c:set>
			            <c:set var="regMemberAllSum_03_5" value="${regMemberAllSum_03_5+reg03_5}"></c:set>
			            <c:set var="regMemberAllSum_02_5" value="${regMemberAllSum_02_5+reg02_5}"></c:set>
			            <c:set var="regMemberAllSum_01_5" value="${regMemberAllSum_01_5+reg01_5}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="regMemberAllTotalSum_12_5" value="${regMemberAllTotalSum_12_5 + reg12_5}"></c:set>
	                    <c:set var="regMemberAllTotalSum_11_5" value="${regMemberAllTotalSum_11_5 + reg11_5}"></c:set>
	                    <c:set var="regMemberAllTotalSum_10_5" value="${regMemberAllTotalSum_10_5 + reg10_5}"></c:set>
	                    <c:set var="regMemberAllTotalSum_09_5" value="${regMemberAllTotalSum_09_5 + reg09_5}"></c:set>
	                    <c:set var="regMemberAllTotalSum_08_5" value="${regMemberAllTotalSum_08_5 + reg08_5}"></c:set>
	                    <c:set var="regMemberAllTotalSum_07_5" value="${regMemberAllTotalSum_07_5 + reg07_5}"></c:set>
	                    <c:set var="regMemberAllTotalSum_06_5" value="${regMemberAllTotalSum_06_5 + reg06_5}"></c:set>
	                    <c:set var="regMemberAllTotalSum_05_5" value="${regMemberAllTotalSum_05_5 + reg05_5}"></c:set>
	                    <c:set var="regMemberAllTotalSum_04_5" value="${regMemberAllTotalSum_04_5 + reg04_5}"></c:set>
	                    <c:set var="regMemberAllTotalSum_03_5" value="${regMemberAllTotalSum_03_5 + reg03_5}"></c:set>
	                    <c:set var="regMemberAllTotalSum_02_5" value="${regMemberAllTotalSum_02_5 + reg02_5}"></c:set>
	                    <c:set var="regMemberAllTotalSum_01_5" value="${regMemberAllTotalSum_01_5 + reg01_5}"></c:set>
		    		</tr>
		    		<!-- 직원별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${memberCnt == vo.rowCnt and vo.rowCnt > 1}">
		    				<td onclick="goPtnrStatTeam( '${vo.ptnrId}', '${vo.teamCenter}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>
							<td onclick="goPtnrStatMember( '${vo.ptnrId}', '${vo.teamId}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.teamName}</td>
		    				<td style="width:150px;">계</td>
		    				<!-- reg12 -->
			                <td style="width: 80px;">${regMemberAllSum_12_5}</td>
			                <!-- reg11 -->
			                <td style="width: 80px;">${regMemberAllSum_11_5}</td>
			                <!-- reg10 -->
			                <td style="width: 80px;">${regMemberAllSum_10_5}</td>
			                <!-- reg09 -->
			                <td style="width: 80px;">${regMemberAllSum_09_5}</td>
			                <!-- reg08 -->
			                <td style="width: 80px;">${regMemberAllSum_08_5}</td>
			                <!-- reg07 -->
			                <td style="width: 80px;">${regMemberAllSum_07_5}</td>
			                <!-- reg06 -->
			                <td style="width: 80px;">${regMemberAllSum_06_5}</td>
			                <!-- reg05 -->
			                <td style="width: 80px;">${regMemberAllSum_05_5}</td>
			                <!-- reg04 -->
			                <td style="width: 80px;">${regMemberAllSum_04_5}</td>
			                <!-- reg03 -->
			                <td style="width: 80px;">${regMemberAllSum_03_5}</td>
			                <!-- reg02 -->
			                <td style="width: 80px;">${regMemberAllSum_02_5}</td>
			                <!-- reg01 -->
			                <td style="width: 80px;">${regMemberAllSum_01_5}</td>
			                <!-- 가로 합계 -->
			                <c:set var="regMemberAllColSum_5" value="${regMemberAllSum_12_5 + regMemberAllSum_11_5 + regMemberAllSum_10_5 + regMemberAllSum_09_5 + regMemberAllSum_08_5 + regMemberAllSum_07_5 + regMemberAllSum_06_5 + regMemberAllSum_05_5 + regMemberAllSum_04_5 + regMemberAllSum_03_5 + regMemberAllSum_02_5 + regMemberAllSum_01_5}"></c:set>                    
			                <td style="width: 80px;">${regMemberAllColSum_5}</td>
			                
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="regMemberAllSum_12_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_11_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_10_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_09_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_08_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_07_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_06_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_05_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_04_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_03_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_02_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_01_5" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo.rowCnt == 1}">
		    				<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="regMemberAllSum_12_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_11_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_10_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_09_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_08_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_07_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_06_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_05_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_04_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_03_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_02_5" value="0"></c:set>
				            <c:set var="regMemberAllSum_01_5" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 직원별 계 카운트 증가 -->
		    				<c:set var="memberCnt" value="${memberCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 직원별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 조사 소계 시작 -->
		    	<c:if test="${ptnrStatMemberAllRegList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="5" style="height:25px;">1종 조사 소계</th>
	                <!-- reg12 -->
	                <th>${regMemberAllTotalSum_12_5}</th>
	                <!-- reg11 -->
	                <th>${regMemberAllTotalSum_11_5}</th>
	                <!-- reg10 -->
	                <th>${regMemberAllTotalSum_10_5}</th>
	                <!-- reg09 -->
	                <th>${regMemberAllTotalSum_09_5}</th>
	                <!-- reg08 -->
	                <th>${regMemberAllTotalSum_08_5}</th>
	                <!-- reg07 -->
	                <th>${regMemberAllTotalSum_07_5}</th>
	                <!-- reg06 -->
	                <th>${regMemberAllTotalSum_06_5}</th>
	                <!-- reg05 -->
	                <th>${regMemberAllTotalSum_05_5}</th>
	                <!-- reg04 -->
	                <th>${regMemberAllTotalSum_04_5}</th>
	                <!-- reg03 -->
	                <th>${regMemberAllTotalSum_03_5}</th>
	                <!-- reg02 -->
	                <th>${regMemberAllTotalSum_02_5}</th>
	                <!-- reg01 -->
	                <th>${regMemberAllTotalSum_01_5}</th>
	                <!-- 가로열 합계 -->
	                <c:set var="regColTotalSum_5" value="${regMemberAllTotalSum_12_5 + regMemberAllTotalSum_11_5 + regMemberAllTotalSum_10_5 + regMemberAllTotalSum_09_5 + regMemberAllTotalSum_08_5 + regMemberAllTotalSum_07_5 + regMemberAllTotalSum_06_5 + regMemberAllTotalSum_05_5 + regMemberAllTotalSum_04_5 + regMemberAllTotalSum_03_5 + regMemberAllTotalSum_02_5 + regMemberAllTotalSum_01_5}"></c:set>
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
   				<c:set var="preUserName" value=""></c:set>
   				
   				<!-- 직원별 계 -->
	            <c:set var="regMemberAllSum_12_10" value="0"></c:set>
	            <c:set var="regMemberAllSum_11_10" value="0"></c:set>
	            <c:set var="regMemberAllSum_10_10" value="0"></c:set>
	            <c:set var="regMemberAllSum_09_10" value="0"></c:set>
	            <c:set var="regMemberAllSum_08_10" value="0"></c:set>
	            <c:set var="regMemberAllSum_07_10" value="0"></c:set>
	            <c:set var="regMemberAllSum_06_10" value="0"></c:set>
	            <c:set var="regMemberAllSum_05_10" value="0"></c:set>
	            <c:set var="regMemberAllSum_04_10" value="0"></c:set>
	            <c:set var="regMemberAllSum_03_10" value="0"></c:set>
	            <c:set var="regMemberAllSum_02_10" value="0"></c:set>
	            <c:set var="regMemberAllSum_01_10" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="regMemberAllTotalSum_12_10" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_11_10" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_10_10" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_09_10" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_08_10" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_07_10" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_06_10" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_05_10" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_04_10" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_03_10" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_02_10" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_01_10" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="regColMemberAllTotalSum_10" value="0"></c:set>
   				    			
    			<c:forEach var="vo1" items="${ptnrStatMemberAllRegList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">			    			
    						<td onclick="goPtnrStatMenu('ptnrStatMain');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowMemberAll_10}">
		                    	1종 심사
		                    </td>		    				    
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo1.rowCnt == 1}">
		                		<td onclick="goPtnrStatTeam( '${vo1.ptnrId}', '${vo1.teamCenter}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>
								<td onclick="goPtnrStatMember( '${vo1.ptnrId}', '${vo1.teamId}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.teamName}</td>
		                		<td style="width:150px;">${vo1.userName}</td>
		                		<td style="width:150px;">${vo1.ptnrIdSubNm}</td>         		
		                		<!-- 직원별 계 초기화 -->
					            <c:set var="regMemberAllSum_12_10" value="0"></c:set>
					            <c:set var="regMemberAllSum_11_10" value="0"></c:set>
					            <c:set var="regMemberAllSum_10_10" value="0"></c:set>
					            <c:set var="regMemberAllSum_09_10" value="0"></c:set>
					            <c:set var="regMemberAllSum_08_10" value="0"></c:set>
					            <c:set var="regMemberAllSum_07_10" value="0"></c:set>
					            <c:set var="regMemberAllSum_06_10" value="0"></c:set>
					            <c:set var="regMemberAllSum_05_10" value="0"></c:set>
					            <c:set var="regMemberAllSum_04_10" value="0"></c:set>
					            <c:set var="regMemberAllSum_03_10" value="0"></c:set>
					            <c:set var="regMemberAllSum_02_10" value="0"></c:set>
					            <c:set var="regMemberAllSum_01_10" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${memberCnt == 1 and vo1.userName != preUserName}">
		                				<td onclick="goPtnrStatTeam( '${vo1.ptnrId}', '${vo1.teamCenter}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>
										<td onclick="goPtnrStatMember( '${vo1.ptnrId}', '${vo1.teamId}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.teamName}</td>
		                				<td style="width:150px;" rowspan="${vo1.rowCnt+1}">${vo1.userName}</td>
		                				<td style="width:150px;">${vo1.ptnrIdSubNm}</td>		                				
		                				<c:set var="preUserName" value="${vo1.userName}"></c:set>
		                			</c:when>
		                			<c:otherwise>
		                				<td onclick="goPtnrStatTeam( '${vo1.ptnrId}', '${vo1.teamCenter}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>
										<td onclick="goPtnrStatMember( '${vo1.ptnrId}', '${vo1.teamId}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.teamName}</td>	                				
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
		                <td style="width: 80px;">${reg12_10}</td>
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
	    				<c:set var="regMemberAllSum_12_10" value="${regMemberAllSum_12_10+reg12_10}"></c:set>
			            <c:set var="regMemberAllSum_11_10" value="${regMemberAllSum_11_10+reg11_10}"></c:set>
			            <c:set var="regMemberAllSum_10_10" value="${regMemberAllSum_10_10+reg10_10}"></c:set>
			            <c:set var="regMemberAllSum_09_10" value="${regMemberAllSum_09_10+reg09_10}"></c:set>
			            <c:set var="regMemberAllSum_08_10" value="${regMemberAllSum_08_10+reg08_10}"></c:set>
			            <c:set var="regMemberAllSum_07_10" value="${regMemberAllSum_07_10+reg07_10}"></c:set>
			            <c:set var="regMemberAllSum_06_10" value="${regMemberAllSum_06_10+reg06_10}"></c:set>
			            <c:set var="regMemberAllSum_05_10" value="${regMemberAllSum_05_10+reg05_10}"></c:set>
			            <c:set var="regMemberAllSum_04_10" value="${regMemberAllSum_04_10+reg04_10}"></c:set>
			            <c:set var="regMemberAllSum_03_10" value="${regMemberAllSum_03_10+reg03_10}"></c:set>
			            <c:set var="regMemberAllSum_02_10" value="${regMemberAllSum_02_10+reg02_10}"></c:set>
			            <c:set var="regMemberAllSum_01_10" value="${regMemberAllSum_01_10+reg01_10}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="regMemberAllTotalSum_12_10" value="${regMemberAllTotalSum_12_10 + reg12_10}"></c:set>
	                    <c:set var="regMemberAllTotalSum_11_10" value="${regMemberAllTotalSum_11_10 + reg11_10}"></c:set>
	                    <c:set var="regMemberAllTotalSum_10_10" value="${regMemberAllTotalSum_10_10 + reg10_10}"></c:set>
	                    <c:set var="regMemberAllTotalSum_09_10" value="${regMemberAllTotalSum_09_10 + reg09_10}"></c:set>
	                    <c:set var="regMemberAllTotalSum_08_10" value="${regMemberAllTotalSum_08_10 + reg08_10}"></c:set>
	                    <c:set var="regMemberAllTotalSum_07_10" value="${regMemberAllTotalSum_07_10 + reg07_10}"></c:set>
	                    <c:set var="regMemberAllTotalSum_06_10" value="${regMemberAllTotalSum_06_10 + reg06_10}"></c:set>
	                    <c:set var="regMemberAllTotalSum_05_10" value="${regMemberAllTotalSum_05_10 + reg05_10}"></c:set>
	                    <c:set var="regMemberAllTotalSum_04_10" value="${regMemberAllTotalSum_04_10 + reg04_10}"></c:set>
	                    <c:set var="regMemberAllTotalSum_03_10" value="${regMemberAllTotalSum_03_10 + reg03_10}"></c:set>
	                    <c:set var="regMemberAllTotalSum_02_10" value="${regMemberAllTotalSum_02_10 + reg02_10}"></c:set>
	                    <c:set var="regMemberAllTotalSum_01_10" value="${regMemberAllTotalSum_01_10 + reg01_10}"></c:set>
		    		</tr>
		    		<!-- 직원별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${memberCnt == vo1.rowCnt and vo1.rowCnt > 1}">
		    				<td onclick="goPtnrStatTeam( '${vo1.ptnrId}', '${vo1.teamCenter}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>
							<td onclick="goPtnrStatMember( '${vo1.ptnrId}', '${vo1.teamId}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.teamName}</td>
		    				<td style="width:150px;">계</td>
		    				<!-- reg12 -->
			                <td style="width: 80px;">${regMemberAllSum_12_10}</td>
			                <!-- reg11 -->
			                <td style="width: 80px;">${regMemberAllSum_11_10}</td>
			                <!-- reg10 -->
			                <td style="width: 80px;">${regMemberAllSum_10_10}</td>
			                <!-- reg09 -->
			                <td style="width: 80px;">${regMemberAllSum_09_10}</td>
			                <!-- reg08 -->
			                <td style="width: 80px;">${regMemberAllSum_08_10}</td>
			                <!-- reg07 -->
			                <td style="width: 80px;">${regMemberAllSum_07_10}</td>
			                <!-- reg06 -->
			                <td style="width: 80px;">${regMemberAllSum_06_10}</td>
			                <!-- reg05 -->
			                <td style="width: 80px;">${regMemberAllSum_05_10}</td>
			                <!-- reg04 -->
			                <td style="width: 80px;">${regMemberAllSum_04_10}</td>
			                <!-- reg03 -->
			                <td style="width: 80px;">${regMemberAllSum_03_10}</td>
			                <!-- reg02 -->
			                <td style="width: 80px;">${regMemberAllSum_02_10}</td>
			                <!-- reg01 -->
			                <td style="width: 80px;">${regMemberAllSum_01_10}</td>
			                <!-- 가로 합계 -->
			                <c:set var="regMemberAllColSum_10" value="${regMemberAllSum_12_10 + regMemberAllSum_11_10 + regMemberAllSum_10_10 + regMemberAllSum_09_10 + regMemberAllSum_08_10 + regMemberAllSum_07_10 + regMemberAllSum_06_10 + regMemberAllSum_05_10 + regMemberAllSum_04_10 + regMemberAllSum_03_10 + regMemberAllSum_02_10 + regMemberAllSum_01_10}"></c:set>                    
			                <td style="width: 80px;">${regMemberAllColSum_10}</td>
			                
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="regMemberAllSum_12_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_11_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_10_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_09_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_08_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_07_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_06_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_05_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_04_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_03_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_02_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_01_10" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo1.rowCnt == 1}">
		    				<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="regMemberAllSum_12_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_11_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_10_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_09_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_08_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_07_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_06_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_05_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_04_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_03_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_02_10" value="0"></c:set>
				            <c:set var="regMemberAllSum_01_10" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 직원별 계 카운트 증가 -->
		    				<c:set var="memberCnt" value="${memberCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 직원별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 심사 소계 시작 -->
		    	<c:if test="${ptnrStatMemberAllRegList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="5" style="height:25px;">1종 심사 소계</th>
	                <!-- reg12 -->
	                <th>${regMemberAllTotalSum_12_10}</th>
	                <!-- reg11 -->
	                <th>${regMemberAllTotalSum_11_10}</th>
	                <!-- reg10 -->
	                <th>${regMemberAllTotalSum_10_10}</th>
	                <!-- reg09 -->
	                <th>${regMemberAllTotalSum_09_10}</th>
	                <!-- reg08 -->
	                <th>${regMemberAllTotalSum_08_10}</th>
	                <!-- reg07 -->
	                <th>${regMemberAllTotalSum_07_10}</th>
	                <!-- reg06 -->
	                <th>${regMemberAllTotalSum_06_10}</th>
	                <!-- reg05 -->
	                <th>${regMemberAllTotalSum_05_10}</th>
	                <!-- reg04 -->
	                <th>${regMemberAllTotalSum_04_10}</th>
	                <!-- reg03 -->
	                <th>${regMemberAllTotalSum_03_10}</th>
	                <!-- reg02 -->
	                <th>${regMemberAllTotalSum_02_10}</th>
	                <!-- reg01 -->
	                <th>${regMemberAllTotalSum_01_10}</th>
	                <!-- 가로열 합계 -->
	                <c:set var="regColTotalSum_10" value="${regMemberAllTotalSum_12_10 + regMemberAllTotalSum_11_10 + regMemberAllTotalSum_10_10 + regMemberAllTotalSum_09_10 + regMemberAllTotalSum_08_10 + regMemberAllTotalSum_07_10 + regMemberAllTotalSum_06_10 + regMemberAllTotalSum_05_10 + regMemberAllTotalSum_04_10 + regMemberAllTotalSum_03_10 + regMemberAllTotalSum_02_10 + regMemberAllTotalSum_01_10}"></c:set>
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
   				<c:set var="preUserName" value=""></c:set>
   				
   				<!-- 직원별 계 -->
	            <c:set var="regMemberAllSum_12_15" value="0"></c:set>
	            <c:set var="regMemberAllSum_11_15" value="0"></c:set>
	            <c:set var="regMemberAllSum_10_15" value="0"></c:set>
	            <c:set var="regMemberAllSum_09_15" value="0"></c:set>
	            <c:set var="regMemberAllSum_08_15" value="0"></c:set>
	            <c:set var="regMemberAllSum_07_15" value="0"></c:set>
	            <c:set var="regMemberAllSum_06_15" value="0"></c:set>
	            <c:set var="regMemberAllSum_05_15" value="0"></c:set>
	            <c:set var="regMemberAllSum_04_15" value="0"></c:set>
	            <c:set var="regMemberAllSum_03_15" value="0"></c:set>
	            <c:set var="regMemberAllSum_02_15" value="0"></c:set>
	            <c:set var="regMemberAllSum_01_15" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="regMemberAllTotalSum_12_15" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_11_15" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_10_15" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_09_15" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_08_15" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_07_15" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_06_15" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_05_15" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_04_15" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_03_15" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_02_15" value="0"></c:set>
	            <c:set var="regMemberAllTotalSum_01_15" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="regColMemberAllTotalSum_15" value="0"></c:set>
   				    			
    			<c:forEach var="vo2" items="${ptnrStatMemberAllRegList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">		                    
    						<td onclick="goPtnrStatMenu('ptnrStatMain');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowMemberAll_15}">
		                    	1종 기타
		                    </td>		    				
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo2.rowCnt == 1}">
		                		<td onclick="goPtnrStatTeam( '${vo2.ptnrId}', '${vo2.teamCenter}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>
								<td onclick="goPtnrStatMember( '${vo2.ptnrId}', '${vo2.teamId}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.teamName}</td>
		                		<td style="width:150px;">${vo2.userName}</td>
		                		<td style="width:150px;">${vo2.ptnrIdSubNm}</td>		                		
		                		<!-- 직원별 계 초기화 -->
					            <c:set var="regMemberAllSum_12_15" value="0"></c:set>
					            <c:set var="regMemberAllSum_11_15" value="0"></c:set>
					            <c:set var="regMemberAllSum_10_15" value="0"></c:set>
					            <c:set var="regMemberAllSum_09_15" value="0"></c:set>
					            <c:set var="regMemberAllSum_08_15" value="0"></c:set>
					            <c:set var="regMemberAllSum_07_15" value="0"></c:set>
					            <c:set var="regMemberAllSum_06_15" value="0"></c:set>
					            <c:set var="regMemberAllSum_05_15" value="0"></c:set>
					            <c:set var="regMemberAllSum_04_15" value="0"></c:set>
					            <c:set var="regMemberAllSum_03_15" value="0"></c:set>
					            <c:set var="regMemberAllSum_02_15" value="0"></c:set>
					            <c:set var="regMemberAllSum_01_15" value="0"></c:set>
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${memberCnt == 1 and vo2.userName != preUserName}">
		                				<td onclick="goPtnrStatTeam( '${vo2.ptnrId}', '${vo2.teamCenter}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>
										<td onclick="goPtnrStatMember( '${vo2.ptnrId}', '${vo2.teamId}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.teamName}</td>
		                				<td style="width:150px;" rowspan="${vo2.rowCnt+1}">${vo2.userName}</td>
		                				<td style="width:150px;">${vo2.ptnrIdSubNm}</td>		                				
		                				<c:set var="preUserName" value="${vo2.userName}"></c:set>
		                			</c:when>
		                			<c:otherwise>
		                				<td onclick="goPtnrStatTeam( '${vo2.ptnrId}', '${vo2.teamCenter}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>
										<td onclick="goPtnrStatMember( '${vo2.ptnrId}', '${vo2.teamId}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.teamName}</td>	                				
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
		                <td style="width: 80px;">${reg12_15}</td>
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
	    				<c:set var="regMemberAllSum_12_15" value="${regMemberAllSum_12_15+reg12_15}"></c:set>
			            <c:set var="regMemberAllSum_11_15" value="${regMemberAllSum_11_15+reg11_15}"></c:set>
			            <c:set var="regMemberAllSum_10_15" value="${regMemberAllSum_10_15+reg10_15}"></c:set>
			            <c:set var="regMemberAllSum_09_15" value="${regMemberAllSum_09_15+reg09_15}"></c:set>
			            <c:set var="regMemberAllSum_08_15" value="${regMemberAllSum_08_15+reg08_15}"></c:set>
			            <c:set var="regMemberAllSum_07_15" value="${regMemberAllSum_07_15+reg07_15}"></c:set>
			            <c:set var="regMemberAllSum_06_15" value="${regMemberAllSum_06_15+reg06_15}"></c:set>
			            <c:set var="regMemberAllSum_05_15" value="${regMemberAllSum_05_15+reg05_15}"></c:set>
			            <c:set var="regMemberAllSum_04_15" value="${regMemberAllSum_04_15+reg04_15}"></c:set>
			            <c:set var="regMemberAllSum_03_15" value="${regMemberAllSum_03_15+reg03_15}"></c:set>
			            <c:set var="regMemberAllSum_02_15" value="${regMemberAllSum_02_15+reg02_15}"></c:set>
			            <c:set var="regMemberAllSum_01_15" value="${regMemberAllSum_01_15+reg01_15}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="regMemberAllTotalSum_12_15" value="${regMemberAllTotalSum_12_15 + reg12_15}"></c:set>
	                    <c:set var="regMemberAllTotalSum_11_15" value="${regMemberAllTotalSum_11_15 + reg11_15}"></c:set>
	                    <c:set var="regMemberAllTotalSum_10_15" value="${regMemberAllTotalSum_10_15 + reg10_15}"></c:set>
	                    <c:set var="regMemberAllTotalSum_09_15" value="${regMemberAllTotalSum_09_15 + reg09_15}"></c:set>
	                    <c:set var="regMemberAllTotalSum_08_15" value="${regMemberAllTotalSum_08_15 + reg08_15}"></c:set>
	                    <c:set var="regMemberAllTotalSum_07_15" value="${regMemberAllTotalSum_07_15 + reg07_15}"></c:set>
	                    <c:set var="regMemberAllTotalSum_06_15" value="${regMemberAllTotalSum_06_15 + reg06_15}"></c:set>
	                    <c:set var="regMemberAllTotalSum_05_15" value="${regMemberAllTotalSum_05_15 + reg05_15}"></c:set>
	                    <c:set var="regMemberAllTotalSum_04_15" value="${regMemberAllTotalSum_04_15 + reg04_15}"></c:set>
	                    <c:set var="regMemberAllTotalSum_03_15" value="${regMemberAllTotalSum_03_15 + reg03_15}"></c:set>
	                    <c:set var="regMemberAllTotalSum_02_15" value="${regMemberAllTotalSum_02_15 + reg02_15}"></c:set>
	                    <c:set var="regMemberAllTotalSum_01_15" value="${regMemberAllTotalSum_01_15 + reg01_15}"></c:set>
		    		</tr>
		    		<!-- 직원별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${memberCnt == vo2.rowCnt and vo2.rowCnt > 1}">
		    				<td onclick="goPtnrStatTeam( '${vo2.ptnrId}', '${vo2.teamCenter}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>
							<td onclick="goPtnrStatMember( '${vo2.ptnrId}', '${vo2.teamId}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.teamName}</td>
		    				<td style="width:150px;">계</td>
		    				<!-- reg12 -->
			                <td style="width: 80px;">${regMemberAllSum_12_15}</td>
			                <!-- reg11 -->
			                <td style="width: 80px;">${regMemberAllSum_11_15}</td>
			                <!-- reg10 -->
			                <td style="width: 80px;">${regMemberAllSum_10_15}</td>
			                <!-- reg09 -->
			                <td style="width: 80px;">${regMemberAllSum_09_15}</td>
			                <!-- reg08 -->
			                <td style="width: 80px;">${regMemberAllSum_08_15}</td>
			                <!-- reg07 -->
			                <td style="width: 80px;">${regMemberAllSum_07_15}</td>
			                <!-- reg06 -->
			                <td style="width: 80px;">${regMemberAllSum_06_15}</td>
			                <!-- reg05 -->
			                <td style="width: 80px;">${regMemberAllSum_05_15}</td>
			                <!-- reg04 -->
			                <td style="width: 80px;">${regMemberAllSum_04_15}</td>
			                <!-- reg03 -->
			                <td style="width: 80px;">${regMemberAllSum_03_15}</td>
			                <!-- reg02 -->
			                <td style="width: 80px;">${regMemberAllSum_02_15}</td>
			                <!-- reg01 -->
			                <td style="width: 80px;">${regMemberAllSum_01_15}</td>
			                <!-- 가로 합계 -->
			                <c:set var="regMemberAllColSum_15" value="${regMemberAllSum_12_15 + regMemberAllSum_11_15 + regMemberAllSum_10_15 + regMemberAllSum_09_15 + regMemberAllSum_08_15 + regMemberAllSum_07_15 + regMemberAllSum_06_15 + regMemberAllSum_05_15 + regMemberAllSum_04_15 + regMemberAllSum_03_15 + regMemberAllSum_02_15 + regMemberAllSum_01_15}"></c:set>                    
			                <td style="width: 80px;">${regMemberAllColSum_15}</td>
			                
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="regMemberAllSum_12_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_11_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_10_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_09_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_08_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_07_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_06_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_05_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_04_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_03_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_02_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_01_15" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo2.rowCnt == 1}">
		    				<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="regMemberAllSum_12_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_11_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_10_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_09_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_08_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_07_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_06_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_05_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_04_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_03_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_02_15" value="0"></c:set>
				            <c:set var="regMemberAllSum_01_15" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 직원별 계 카운트 증가 -->
		    				<c:set var="memberCnt" value="${memberCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 직원별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 기타 소계 시작 -->
		    	<c:if test="${ptnrStatMemberAllRegList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="5" style="height:25px;">1종 기타 소계</th>
	                <!-- reg12 -->
	                <th>${regMemberAllTotalSum_12_15}</th>
	                <!-- reg11 -->
	                <th>${regMemberAllTotalSum_11_15}</th>
	                <!-- reg10 -->
	                <th>${regMemberAllTotalSum_10_15}</th>
	                <!-- reg09 -->
	                <th>${regMemberAllTotalSum_09_15}</th>
	                <!-- reg08 -->
	                <th>${regMemberAllTotalSum_08_15}</th>
	                <!-- reg07 -->
	                <th>${regMemberAllTotalSum_07_15}</th>
	                <!-- reg06 -->
	                <th>${regMemberAllTotalSum_06_15}</th>
	                <!-- reg05 -->
	                <th>${regMemberAllTotalSum_05_15}</th>
	                <!-- reg04 -->
	                <th>${regMemberAllTotalSum_04_15}</th>
	                <!-- reg03 -->
	                <th>${regMemberAllTotalSum_03_15}</th>
	                <!-- reg02 -->
	                <th>${regMemberAllTotalSum_02_15}</th>
	                <!-- reg01 -->
	                <th>${regMemberAllTotalSum_01_15}</th>
	                <!-- 가로열 합계 -->
	                <c:set var="regColTotalSum_15" value="${regMemberAllTotalSum_12_15 + regMemberAllTotalSum_11_15 + regMemberAllTotalSum_10_15 + regMemberAllTotalSum_09_15 + regMemberAllTotalSum_08_15 + regMemberAllTotalSum_07_15 + regMemberAllTotalSum_06_15 + regMemberAllTotalSum_05_15 + regMemberAllTotalSum_04_15 + regMemberAllTotalSum_03_15 + regMemberAllTotalSum_02_15 + regMemberAllTotalSum_01_15}"></c:set>
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
    <c:set var="regMemberAllTotalSum_12_all" value="${regMemberAllTotalSum_12_5 + regMemberAllTotalSum_12_10 + regMemberAllTotalSum_12_15}"></c:set>
    <c:set var="regMemberAllTotalSum_11_all" value="${regMemberAllTotalSum_11_5 + regMemberAllTotalSum_11_10 + regMemberAllTotalSum_11_15}"></c:set>
    <c:set var="regMemberAllTotalSum_10_all" value="${regMemberAllTotalSum_10_5 + regMemberAllTotalSum_10_10 + regMemberAllTotalSum_10_15}"></c:set>
    <c:set var="regMemberAllTotalSum_09_all" value="${regMemberAllTotalSum_09_5 + regMemberAllTotalSum_09_10 + regMemberAllTotalSum_09_15}"></c:set>
    <c:set var="regMemberAllTotalSum_08_all" value="${regMemberAllTotalSum_08_5 + regMemberAllTotalSum_08_10 + regMemberAllTotalSum_08_15}"></c:set>
    <c:set var="regMemberAllTotalSum_07_all" value="${regMemberAllTotalSum_07_5 + regMemberAllTotalSum_07_10 + regMemberAllTotalSum_07_15}"></c:set>
    <c:set var="regMemberAllTotalSum_06_all" value="${regMemberAllTotalSum_06_5 + regMemberAllTotalSum_06_10 + regMemberAllTotalSum_06_15}"></c:set>
    <c:set var="regMemberAllTotalSum_05_all" value="${regMemberAllTotalSum_05_5 + regMemberAllTotalSum_05_10 + regMemberAllTotalSum_05_15}"></c:set>
    <c:set var="regMemberAllTotalSum_04_all" value="${regMemberAllTotalSum_04_5 + regMemberAllTotalSum_04_10 + regMemberAllTotalSum_04_15}"></c:set>
    <c:set var="regMemberAllTotalSum_03_all" value="${regMemberAllTotalSum_03_5 + regMemberAllTotalSum_03_10 + regMemberAllTotalSum_03_15}"></c:set>
    <c:set var="regMemberAllTotalSum_02_all" value="${regMemberAllTotalSum_02_5 + regMemberAllTotalSum_02_10 + regMemberAllTotalSum_02_15}"></c:set>
    <c:set var="regMemberAllTotalSum_01_all" value="${regMemberAllTotalSum_01_5 + regMemberAllTotalSum_01_10 + regMemberAllTotalSum_01_15}"></c:set>        
    <c:set var="regMemberAllTotalSum_col_all" value="${regMemberAllTotalSum_12_all + regMemberAllTotalSum_11_all + regMemberAllTotalSum_10_all + regMemberAllTotalSum_09_all + regMemberAllTotalSum_08_all + regMemberAllTotalSum_07_all + regMemberAllTotalSum_06_all + regMemberAllTotalSum_05_all + regMemberAllTotalSum_04_all + regMemberAllTotalSum_03_all + regMemberAllTotalSum_02_all + regMemberAllTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 680px;height:25px;">전체합계</th>
                <th style="width: 80px;color:blue;">${regMemberAllTotalSum_12_all}</th>
                <th style="width: 80px;color:blue;">${regMemberAllTotalSum_11_all}</th>
                <th style="width: 80px;color:blue;">${regMemberAllTotalSum_10_all}</th>
                <th style="width: 80px;color:blue;">${regMemberAllTotalSum_09_all}</th>
                <th style="width: 80px;color:blue;">${regMemberAllTotalSum_08_all}</th>
                <th style="width: 80px;color:blue;">${regMemberAllTotalSum_07_all}</th>
                <th style="width: 80px;color:blue;">${regMemberAllTotalSum_06_all}</th>
                <th style="width: 80px;color:blue;">${regMemberAllTotalSum_05_all}</th>
                <th style="width: 80px;color:blue;">${regMemberAllTotalSum_04_all}</th>
                <th style="width: 80px;color:blue;">${regMemberAllTotalSum_03_all}</th>
                <th style="width: 80px;color:blue;">${regMemberAllTotalSum_02_all}</th>
                <th style="width: 80px;color:blue;">${regMemberAllTotalSum_01_all}</th>
				<th style="width: 80px;color:blue;">${regMemberAllTotalSum_col_all}</th>
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>
