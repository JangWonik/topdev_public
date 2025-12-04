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
	            <c:set var="endMemberAllSum_12_5" value="0"></c:set>
	            <c:set var="endMemberAllSum_11_5" value="0"></c:set>
	            <c:set var="endMemberAllSum_10_5" value="0"></c:set>
	            <c:set var="endMemberAllSum_09_5" value="0"></c:set>
	            <c:set var="endMemberAllSum_08_5" value="0"></c:set>
	            <c:set var="endMemberAllSum_07_5" value="0"></c:set>
	            <c:set var="endMemberAllSum_06_5" value="0"></c:set>
	            <c:set var="endMemberAllSum_05_5" value="0"></c:set>
	            <c:set var="endMemberAllSum_04_5" value="0"></c:set>
	            <c:set var="endMemberAllSum_03_5" value="0"></c:set>
	            <c:set var="endMemberAllSum_02_5" value="0"></c:set>
	            <c:set var="endMemberAllSum_01_5" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="endMemberAllTotalSum_12_5" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_11_5" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_10_5" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_09_5" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_08_5" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_07_5" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_06_5" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_05_5" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_04_5" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_03_5" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_02_5" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_01_5" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="endColMemberAllTotalSum_5" value="0"></c:set>
   				    			
    			<c:forEach var="vo" items="${ptnrStatMemberAllEndList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">		    				
    						<td onclick="goPtnrStatMenu('ptnrStatEnd');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowMemberAll}">
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
					            <c:set var="endMemberAllSum_12_5" value="0"></c:set>
					            <c:set var="endMemberAllSum_11_5" value="0"></c:set>
					            <c:set var="endMemberAllSum_10_5" value="0"></c:set>
					            <c:set var="endMemberAllSum_09_5" value="0"></c:set>
					            <c:set var="endMemberAllSum_08_5" value="0"></c:set>
					            <c:set var="endMemberAllSum_07_5" value="0"></c:set>
					            <c:set var="endMemberAllSum_06_5" value="0"></c:set>
					            <c:set var="endMemberAllSum_05_5" value="0"></c:set>
					            <c:set var="endMemberAllSum_04_5" value="0"></c:set>
					            <c:set var="endMemberAllSum_03_5" value="0"></c:set>
					            <c:set var="endMemberAllSum_02_5" value="0"></c:set>
					            <c:set var="endMemberAllSum_01_5" value="0"></c:set>
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
		                <td style="width: 80px;">${end12_5}</td>
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
		                
		                <!-- 직원별 계 합산 -->
	    				<c:set var="endMemberAllSum_12_5" value="${endMemberAllSum_12_5+end12_5}"></c:set>
			            <c:set var="endMemberAllSum_11_5" value="${endMemberAllSum_11_5+end11_5}"></c:set>
			            <c:set var="endMemberAllSum_10_5" value="${endMemberAllSum_10_5+end10_5}"></c:set>
			            <c:set var="endMemberAllSum_09_5" value="${endMemberAllSum_09_5+end09_5}"></c:set>
			            <c:set var="endMemberAllSum_08_5" value="${endMemberAllSum_08_5+end08_5}"></c:set>
			            <c:set var="endMemberAllSum_07_5" value="${endMemberAllSum_07_5+end07_5}"></c:set>
			            <c:set var="endMemberAllSum_06_5" value="${endMemberAllSum_06_5+end06_5}"></c:set>
			            <c:set var="endMemberAllSum_05_5" value="${endMemberAllSum_05_5+end05_5}"></c:set>
			            <c:set var="endMemberAllSum_04_5" value="${endMemberAllSum_04_5+end04_5}"></c:set>
			            <c:set var="endMemberAllSum_03_5" value="${endMemberAllSum_03_5+end03_5}"></c:set>
			            <c:set var="endMemberAllSum_02_5" value="${endMemberAllSum_02_5+end02_5}"></c:set>
			            <c:set var="endMemberAllSum_01_5" value="${endMemberAllSum_01_5+end01_5}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="endMemberAllTotalSum_12_5" value="${endMemberAllTotalSum_12_5 + end12_5}"></c:set>
	                    <c:set var="endMemberAllTotalSum_11_5" value="${endMemberAllTotalSum_11_5 + end11_5}"></c:set>
	                    <c:set var="endMemberAllTotalSum_10_5" value="${endMemberAllTotalSum_10_5 + end10_5}"></c:set>
	                    <c:set var="endMemberAllTotalSum_09_5" value="${endMemberAllTotalSum_09_5 + end09_5}"></c:set>
	                    <c:set var="endMemberAllTotalSum_08_5" value="${endMemberAllTotalSum_08_5 + end08_5}"></c:set>
	                    <c:set var="endMemberAllTotalSum_07_5" value="${endMemberAllTotalSum_07_5 + end07_5}"></c:set>
	                    <c:set var="endMemberAllTotalSum_06_5" value="${endMemberAllTotalSum_06_5 + end06_5}"></c:set>
	                    <c:set var="endMemberAllTotalSum_05_5" value="${endMemberAllTotalSum_05_5 + end05_5}"></c:set>
	                    <c:set var="endMemberAllTotalSum_04_5" value="${endMemberAllTotalSum_04_5 + end04_5}"></c:set>
	                    <c:set var="endMemberAllTotalSum_03_5" value="${endMemberAllTotalSum_03_5 + end03_5}"></c:set>
	                    <c:set var="endMemberAllTotalSum_02_5" value="${endMemberAllTotalSum_02_5 + end02_5}"></c:set>
	                    <c:set var="endMemberAllTotalSum_01_5" value="${endMemberAllTotalSum_01_5 + end01_5}"></c:set>
		    		</tr>
		    		<!-- 직원별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${memberCnt == vo.rowCnt and vo.rowCnt > 1}">
		    				<td onclick="goPtnrStatTeam( '${vo.ptnrId}', '${vo.teamCenter}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>
							<td onclick="goPtnrStatMember( '${vo.ptnrId}', '${vo.teamId}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.teamName}</td>
		    				<td style="width:150px;">계</td>
		    				<!-- end12 -->
			                <td style="width: 80px;">${endMemberAllSum_12_5}</td>
			                <!-- end11 -->
			                <td style="width: 80px;">${endMemberAllSum_11_5}</td>
			                <!-- end10 -->
			                <td style="width: 80px;">${endMemberAllSum_10_5}</td>
			                <!-- end09 -->
			                <td style="width: 80px;">${endMemberAllSum_09_5}</td>
			                <!-- end08 -->
			                <td style="width: 80px;">${endMemberAllSum_08_5}</td>
			                <!-- end07 -->
			                <td style="width: 80px;">${endMemberAllSum_07_5}</td>
			                <!-- end06 -->
			                <td style="width: 80px;">${endMemberAllSum_06_5}</td>
			                <!-- end05 -->
			                <td style="width: 80px;">${endMemberAllSum_05_5}</td>
			                <!-- end04 -->
			                <td style="width: 80px;">${endMemberAllSum_04_5}</td>
			                <!-- end03 -->
			                <td style="width: 80px;">${endMemberAllSum_03_5}</td>
			                <!-- end02 -->
			                <td style="width: 80px;">${endMemberAllSum_02_5}</td>
			                <!-- end01 -->
			                <td style="width: 80px;">${endMemberAllSum_01_5}</td>
			                <!-- 가로 합계 -->
			                <c:set var="endMemberAllColSum_5" value="${endMemberAllSum_12_5 + endMemberAllSum_11_5 + endMemberAllSum_10_5 + endMemberAllSum_09_5 + endMemberAllSum_08_5 + endMemberAllSum_07_5 + endMemberAllSum_06_5 + endMemberAllSum_05_5 + endMemberAllSum_04_5 + endMemberAllSum_03_5 + endMemberAllSum_02_5 + endMemberAllSum_01_5}"></c:set>                    
			                <td style="width: 80px;">${endMemberAllColSum_5}</td>
			                
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="endMemberAllSum_12_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_11_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_10_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_09_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_08_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_07_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_06_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_05_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_04_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_03_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_02_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_01_5" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo.rowCnt == 1}">
		    				<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="endMemberAllSum_12_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_11_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_10_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_09_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_08_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_07_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_06_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_05_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_04_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_03_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_02_5" value="0"></c:set>
				            <c:set var="endMemberAllSum_01_5" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 직원별 계 카운트 증가 -->
		    				<c:set var="memberCnt" value="${memberCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 직원별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 조사 소계 시작 -->
		    	<c:if test="${ptnrStatMemberAllEndList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="5" style="height:25px;">1종 조사 소계</th>
	                <!-- end12 -->
	                <th>${endMemberAllTotalSum_12_5}</th>
	                <!-- end11 -->
	                <th>${endMemberAllTotalSum_11_5}</th>
	                <!-- end10 -->
	                <th>${endMemberAllTotalSum_10_5}</th>
	                <!-- end09 -->
	                <th>${endMemberAllTotalSum_09_5}</th>
	                <!-- end08 -->
	                <th>${endMemberAllTotalSum_08_5}</th>
	                <!-- end07 -->
	                <th>${endMemberAllTotalSum_07_5}</th>
	                <!-- end06 -->
	                <th>${endMemberAllTotalSum_06_5}</th>
	                <!-- end05 -->
	                <th>${endMemberAllTotalSum_05_5}</th>
	                <!-- end04 -->
	                <th>${endMemberAllTotalSum_04_5}</th>
	                <!-- end03 -->
	                <th>${endMemberAllTotalSum_03_5}</th>
	                <!-- end02 -->
	                <th>${endMemberAllTotalSum_02_5}</th>
	                <!-- end01 -->
	                <th>${endMemberAllTotalSum_01_5}</th>
	                <!-- 가로열 합계 -->
	                <c:set var="endColTotalSum_5" value="${endMemberAllTotalSum_12_5 + endMemberAllTotalSum_11_5 + endMemberAllTotalSum_10_5 + endMemberAllTotalSum_09_5 + endMemberAllTotalSum_08_5 + endMemberAllTotalSum_07_5 + endMemberAllTotalSum_06_5 + endMemberAllTotalSum_05_5 + endMemberAllTotalSum_04_5 + endMemberAllTotalSum_03_5 + endMemberAllTotalSum_02_5 + endMemberAllTotalSum_01_5}"></c:set>
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
   				<!-- 직원별 계를 만들기 위한 변수 -->
   				<c:set var="memberCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 직원명 -->
   				<c:set var="preUserName" value=""></c:set>
   				
   				<!-- 직원별 계 -->
	            <c:set var="endMemberAllSum_12_10" value="0"></c:set>
	            <c:set var="endMemberAllSum_11_10" value="0"></c:set>
	            <c:set var="endMemberAllSum_10_10" value="0"></c:set>
	            <c:set var="endMemberAllSum_09_10" value="0"></c:set>
	            <c:set var="endMemberAllSum_08_10" value="0"></c:set>
	            <c:set var="endMemberAllSum_07_10" value="0"></c:set>
	            <c:set var="endMemberAllSum_06_10" value="0"></c:set>
	            <c:set var="endMemberAllSum_05_10" value="0"></c:set>
	            <c:set var="endMemberAllSum_04_10" value="0"></c:set>
	            <c:set var="endMemberAllSum_03_10" value="0"></c:set>
	            <c:set var="endMemberAllSum_02_10" value="0"></c:set>
	            <c:set var="endMemberAllSum_01_10" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="endMemberAllTotalSum_12_10" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_11_10" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_10_10" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_09_10" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_08_10" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_07_10" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_06_10" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_05_10" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_04_10" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_03_10" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_02_10" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_01_10" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="endColMemberAllTotalSum_10" value="0"></c:set>
   				    			
    			<c:forEach var="vo1" items="${ptnrStatMemberAllEndList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatEnd');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowMemberAll_10}">
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
					            <c:set var="endMemberAllSum_12_10" value="0"></c:set>
					            <c:set var="endMemberAllSum_11_10" value="0"></c:set>
					            <c:set var="endMemberAllSum_10_10" value="0"></c:set>
					            <c:set var="endMemberAllSum_09_10" value="0"></c:set>
					            <c:set var="endMemberAllSum_08_10" value="0"></c:set>
					            <c:set var="endMemberAllSum_07_10" value="0"></c:set>
					            <c:set var="endMemberAllSum_06_10" value="0"></c:set>
					            <c:set var="endMemberAllSum_05_10" value="0"></c:set>
					            <c:set var="endMemberAllSum_04_10" value="0"></c:set>
					            <c:set var="endMemberAllSum_03_10" value="0"></c:set>
					            <c:set var="endMemberAllSum_02_10" value="0"></c:set>
					            <c:set var="endMemberAllSum_01_10" value="0"></c:set>
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
		                <td style="width: 80px;">${end12_10}</td>
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
		                
		                <!-- 직원별 계 합산 -->
	    				<c:set var="endMemberAllSum_12_10" value="${endMemberAllSum_12_10+end12_10}"></c:set>
			            <c:set var="endMemberAllSum_11_10" value="${endMemberAllSum_11_10+end11_10}"></c:set>
			            <c:set var="endMemberAllSum_10_10" value="${endMemberAllSum_10_10+end10_10}"></c:set>
			            <c:set var="endMemberAllSum_09_10" value="${endMemberAllSum_09_10+end09_10}"></c:set>
			            <c:set var="endMemberAllSum_08_10" value="${endMemberAllSum_08_10+end08_10}"></c:set>
			            <c:set var="endMemberAllSum_07_10" value="${endMemberAllSum_07_10+end07_10}"></c:set>
			            <c:set var="endMemberAllSum_06_10" value="${endMemberAllSum_06_10+end06_10}"></c:set>
			            <c:set var="endMemberAllSum_05_10" value="${endMemberAllSum_05_10+end05_10}"></c:set>
			            <c:set var="endMemberAllSum_04_10" value="${endMemberAllSum_04_10+end04_10}"></c:set>
			            <c:set var="endMemberAllSum_03_10" value="${endMemberAllSum_03_10+end03_10}"></c:set>
			            <c:set var="endMemberAllSum_02_10" value="${endMemberAllSum_02_10+end02_10}"></c:set>
			            <c:set var="endMemberAllSum_01_10" value="${endMemberAllSum_01_10+end01_10}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="endMemberAllTotalSum_12_10" value="${endMemberAllTotalSum_12_10 + end12_10}"></c:set>
	                    <c:set var="endMemberAllTotalSum_11_10" value="${endMemberAllTotalSum_11_10 + end11_10}"></c:set>
	                    <c:set var="endMemberAllTotalSum_10_10" value="${endMemberAllTotalSum_10_10 + end10_10}"></c:set>
	                    <c:set var="endMemberAllTotalSum_09_10" value="${endMemberAllTotalSum_09_10 + end09_10}"></c:set>
	                    <c:set var="endMemberAllTotalSum_08_10" value="${endMemberAllTotalSum_08_10 + end08_10}"></c:set>
	                    <c:set var="endMemberAllTotalSum_07_10" value="${endMemberAllTotalSum_07_10 + end07_10}"></c:set>
	                    <c:set var="endMemberAllTotalSum_06_10" value="${endMemberAllTotalSum_06_10 + end06_10}"></c:set>
	                    <c:set var="endMemberAllTotalSum_05_10" value="${endMemberAllTotalSum_05_10 + end05_10}"></c:set>
	                    <c:set var="endMemberAllTotalSum_04_10" value="${endMemberAllTotalSum_04_10 + end04_10}"></c:set>
	                    <c:set var="endMemberAllTotalSum_03_10" value="${endMemberAllTotalSum_03_10 + end03_10}"></c:set>
	                    <c:set var="endMemberAllTotalSum_02_10" value="${endMemberAllTotalSum_02_10 + end02_10}"></c:set>
	                    <c:set var="endMemberAllTotalSum_01_10" value="${endMemberAllTotalSum_01_10 + end01_10}"></c:set>
		    		</tr>
		    		<!-- 직원별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${memberCnt == vo1.rowCnt and vo1.rowCnt > 1}">
		    				<td onclick="goPtnrStatTeam( '${vo1.ptnrId}', '${vo1.teamCenter}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>
							<td onclick="goPtnrStatMember( '${vo1.ptnrId}', '${vo1.teamId}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.teamName}</td>
		    				<td style="width:150px;">계</td>
		    				<!-- end12 -->
			                <td style="width: 80px;">${endMemberAllSum_12_10}</td>
			                <!-- end11 -->
			                <td style="width: 80px;">${endMemberAllSum_11_10}</td>
			                <!-- end10 -->
			                <td style="width: 80px;">${endMemberAllSum_10_10}</td>
			                <!-- end09 -->
			                <td style="width: 80px;">${endMemberAllSum_09_10}</td>
			                <!-- end08 -->
			                <td style="width: 80px;">${endMemberAllSum_08_10}</td>
			                <!-- end07 -->
			                <td style="width: 80px;">${endMemberAllSum_07_10}</td>
			                <!-- end06 -->
			                <td style="width: 80px;">${endMemberAllSum_06_10}</td>
			                <!-- end05 -->
			                <td style="width: 80px;">${endMemberAllSum_05_10}</td>
			                <!-- end04 -->
			                <td style="width: 80px;">${endMemberAllSum_04_10}</td>
			                <!-- end03 -->
			                <td style="width: 80px;">${endMemberAllSum_03_10}</td>
			                <!-- end02 -->
			                <td style="width: 80px;">${endMemberAllSum_02_10}</td>
			                <!-- end01 -->
			                <td style="width: 80px;">${endMemberAllSum_01_10}</td>
			                <!-- 가로 합계 -->
			                <c:set var="endMemberAllColSum_10" value="${endMemberAllSum_12_10 + endMemberAllSum_11_10 + endMemberAllSum_10_10 + endMemberAllSum_09_10 + endMemberAllSum_08_10 + endMemberAllSum_07_10 + endMemberAllSum_06_10 + endMemberAllSum_05_10 + endMemberAllSum_04_10 + endMemberAllSum_03_10 + endMemberAllSum_02_10 + endMemberAllSum_01_10}"></c:set>                    
			                <td style="width: 80px;">${endMemberAllColSum_10}</td>
			                
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="endMemberAllSum_12_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_11_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_10_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_09_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_08_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_07_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_06_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_05_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_04_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_03_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_02_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_01_10" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo1.rowCnt == 1}">
		    				<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="endMemberAllSum_12_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_11_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_10_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_09_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_08_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_07_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_06_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_05_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_04_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_03_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_02_10" value="0"></c:set>
				            <c:set var="endMemberAllSum_01_10" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 직원별 계 카운트 증가 -->
		    				<c:set var="memberCnt" value="${memberCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 직원별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 심사 소계 시작 -->
		    	<c:if test="${ptnrStatMemberAllEndList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="5" style="height:25px;">1종 심사 소계</th>
	                <!-- end12 -->
	                <th>${endMemberAllTotalSum_12_10}</th>
	                <!-- end11 -->
	                <th>${endMemberAllTotalSum_11_10}</th>
	                <!-- end10 -->
	                <th>${endMemberAllTotalSum_10_10}</th>
	                <!-- end09 -->
	                <th>${endMemberAllTotalSum_09_10}</th>
	                <!-- end08 -->
	                <th>${endMemberAllTotalSum_08_10}</th>
	                <!-- end07 -->
	                <th>${endMemberAllTotalSum_07_10}</th>
	                <!-- end06 -->
	                <th>${endMemberAllTotalSum_06_10}</th>
	                <!-- end05 -->
	                <th>${endMemberAllTotalSum_05_10}</th>
	                <!-- end04 -->
	                <th>${endMemberAllTotalSum_04_10}</th>
	                <!-- end03 -->
	                <th>${endMemberAllTotalSum_03_10}</th>
	                <!-- end02 -->
	                <th>${endMemberAllTotalSum_02_10}</th>
	                <!-- end01 -->
	                <th>${endMemberAllTotalSum_01_10}</th>
	                <!-- 가로열 합계 -->
	                <c:set var="endColTotalSum_10" value="${endMemberAllTotalSum_12_10 + endMemberAllTotalSum_11_10 + endMemberAllTotalSum_10_10 + endMemberAllTotalSum_09_10 + endMemberAllTotalSum_08_10 + endMemberAllTotalSum_07_10 + endMemberAllTotalSum_06_10 + endMemberAllTotalSum_05_10 + endMemberAllTotalSum_04_10 + endMemberAllTotalSum_03_10 + endMemberAllTotalSum_02_10 + endMemberAllTotalSum_01_10}"></c:set>
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
   				<!-- 직원별 계를 만들기 위한 변수 -->
   				<c:set var="memberCnt" value="1"></c:set>
   				<!-- 앞줄에 있는 직원명 -->
   				<c:set var="preUserName" value=""></c:set>
   				
   				<!-- 직원별 계 -->
	            <c:set var="endMemberAllSum_12_15" value="0"></c:set>
	            <c:set var="endMemberAllSum_11_15" value="0"></c:set>
	            <c:set var="endMemberAllSum_10_15" value="0"></c:set>
	            <c:set var="endMemberAllSum_09_15" value="0"></c:set>
	            <c:set var="endMemberAllSum_08_15" value="0"></c:set>
	            <c:set var="endMemberAllSum_07_15" value="0"></c:set>
	            <c:set var="endMemberAllSum_06_15" value="0"></c:set>
	            <c:set var="endMemberAllSum_05_15" value="0"></c:set>
	            <c:set var="endMemberAllSum_04_15" value="0"></c:set>
	            <c:set var="endMemberAllSum_03_15" value="0"></c:set>
	            <c:set var="endMemberAllSum_02_15" value="0"></c:set>
	            <c:set var="endMemberAllSum_01_15" value="0"></c:set>
	            
	            <!-- Type 별 총 합계 -->
	            <c:set var="endMemberAllTotalSum_12_15" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_11_15" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_10_15" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_09_15" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_08_15" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_07_15" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_06_15" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_05_15" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_04_15" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_03_15" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_02_15" value="0"></c:set>
	            <c:set var="endMemberAllTotalSum_01_15" value="0"></c:set>
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="endColMemberAllTotalSum_15" value="0"></c:set>
   				    			
    			<c:forEach var="vo2" items="${ptnrStatMemberAllEndList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">		                    
    						<td onclick="goPtnrStatMenu('ptnrStatEnd');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowMemberAll_15}">
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
					            <c:set var="endMemberAllSum_12_15" value="0"></c:set>
					            <c:set var="endMemberAllSum_11_15" value="0"></c:set>
					            <c:set var="endMemberAllSum_10_15" value="0"></c:set>
					            <c:set var="endMemberAllSum_09_15" value="0"></c:set>
					            <c:set var="endMemberAllSum_08_15" value="0"></c:set>
					            <c:set var="endMemberAllSum_07_15" value="0"></c:set>
					            <c:set var="endMemberAllSum_06_15" value="0"></c:set>
					            <c:set var="endMemberAllSum_05_15" value="0"></c:set>
					            <c:set var="endMemberAllSum_04_15" value="0"></c:set>
					            <c:set var="endMemberAllSum_03_15" value="0"></c:set>
					            <c:set var="endMemberAllSum_02_15" value="0"></c:set>
					            <c:set var="endMemberAllSum_01_15" value="0"></c:set>
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
		                <td style="width: 80px;">${end12_15}</td>
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
		                <!-- end04 
		                -->
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
		                
		                <!-- 직원별 계 합산 -->
	    				<c:set var="endMemberAllSum_12_15" value="${endMemberAllSum_12_15+end12_15}"></c:set>
			            <c:set var="endMemberAllSum_11_15" value="${endMemberAllSum_11_15+end11_15}"></c:set>
			            <c:set var="endMemberAllSum_10_15" value="${endMemberAllSum_10_15+end10_15}"></c:set>
			            <c:set var="endMemberAllSum_09_15" value="${endMemberAllSum_09_15+end09_15}"></c:set>
			            <c:set var="endMemberAllSum_08_15" value="${endMemberAllSum_08_15+end08_15}"></c:set>
			            <c:set var="endMemberAllSum_07_15" value="${endMemberAllSum_07_15+end07_15}"></c:set>
			            <c:set var="endMemberAllSum_06_15" value="${endMemberAllSum_06_15+end06_15}"></c:set>
			            <c:set var="endMemberAllSum_05_15" value="${endMemberAllSum_05_15+end05_15}"></c:set>
			            <c:set var="endMemberAllSum_04_15" value="${endMemberAllSum_04_15+end04_15}"></c:set>
			            <c:set var="endMemberAllSum_03_15" value="${endMemberAllSum_03_15+end03_15}"></c:set>
			            <c:set var="endMemberAllSum_02_15" value="${endMemberAllSum_02_15+end02_15}"></c:set>
			            <c:set var="endMemberAllSum_01_15" value="${endMemberAllSum_01_15+end01_15}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="endMemberAllTotalSum_12_15" value="${endMemberAllTotalSum_12_15 + end12_15}"></c:set>
	                    <c:set var="endMemberAllTotalSum_11_15" value="${endMemberAllTotalSum_11_15 + end11_15}"></c:set>
	                    <c:set var="endMemberAllTotalSum_10_15" value="${endMemberAllTotalSum_10_15 + end10_15}"></c:set>
	                    <c:set var="endMemberAllTotalSum_09_15" value="${endMemberAllTotalSum_09_15 + end09_15}"></c:set>
	                    <c:set var="endMemberAllTotalSum_08_15" value="${endMemberAllTotalSum_08_15 + end08_15}"></c:set>
	                    <c:set var="endMemberAllTotalSum_07_15" value="${endMemberAllTotalSum_07_15 + end07_15}"></c:set>
	                    <c:set var="endMemberAllTotalSum_06_15" value="${endMemberAllTotalSum_06_15 + end06_15}"></c:set>
	                    <c:set var="endMemberAllTotalSum_05_15" value="${endMemberAllTotalSum_05_15 + end05_15}"></c:set>
	                    <c:set var="endMemberAllTotalSum_04_15" value="${endMemberAllTotalSum_04_15 + end04_15}"></c:set>
	                    <c:set var="endMemberAllTotalSum_03_15" value="${endMemberAllTotalSum_03_15 + end03_15}"></c:set>
	                    <c:set var="endMemberAllTotalSum_02_15" value="${endMemberAllTotalSum_02_15 + end02_15}"></c:set>
	                    <c:set var="endMemberAllTotalSum_01_15" value="${endMemberAllTotalSum_01_15 + end01_15}"></c:set>
		    		</tr>
		    		<!-- 직원별 소계 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${memberCnt == vo2.rowCnt and vo2.rowCnt > 1}">
		    				<td onclick="goPtnrStatTeam( '${vo2.ptnrId}', '${vo2.teamCenter}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>
							<td onclick="goPtnrStatMember( '${vo2.ptnrId}', '${vo2.teamId}' )" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.teamName}</td>
		    				<td style="width:150px;">계</td>
		    				<!-- end12 -->
			                <td style="width: 80px;">${endMemberAllSum_12_15}</td>
			                <!-- end11 -->
			                <td style="width: 80px;">${endMemberAllSum_11_15}</td>
			                <!-- end10 -->
			                <td style="width: 80px;">${endMemberAllSum_10_15}</td>
			                <!-- end09 -->
			                <td style="width: 80px;">${endMemberAllSum_09_15}</td>
			                <!-- end08 -->
			                <td style="width: 80px;">${endMemberAllSum_08_15}</td>
			                <!-- end07 -->
			                <td style="width: 80px;">${endMemberAllSum_07_15}</td>
			                <!-- end06 -->
			                <td style="width: 80px;">${endMemberAllSum_06_15}</td>
			                <!-- end05 -->
			                <td style="width: 80px;">${endMemberAllSum_05_15}</td>
			                <!-- end04 -->
			                <td style="width: 80px;">${endMemberAllSum_04_15}</td>
			                <!-- end03 -->
			                <td style="width: 80px;">${endMemberAllSum_03_15}</td>
			                <!-- end02 -->
			                <td style="width: 80px;">${endMemberAllSum_02_15}</td>
			                <!-- end01 -->
			                <td style="width: 80px;">${endMemberAllSum_01_15}</td>
			                <!-- 가로 합계 -->
			                <c:set var="endMemberAllColSum_15" value="${endMemberAllSum_12_15 + endMemberAllSum_11_15 + endMemberAllSum_10_15 + endMemberAllSum_09_15 + endMemberAllSum_08_15 + endMemberAllSum_07_15 + endMemberAllSum_06_15 + endMemberAllSum_05_15 + endMemberAllSum_04_15 + endMemberAllSum_03_15 + endMemberAllSum_02_15 + endMemberAllSum_01_15}"></c:set>                    
			                <td style="width: 80px;">${endMemberAllColSum_15}</td>
			                
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="endMemberAllSum_12_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_11_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_10_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_09_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_08_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_07_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_06_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_05_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_04_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_03_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_02_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_01_15" value="0"></c:set>				            
		    			</c:when>
		    			<c:when test="${vo2.rowCnt == 1}">
		    				<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="endMemberAllSum_12_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_11_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_10_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_09_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_08_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_07_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_06_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_05_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_04_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_03_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_02_15" value="0"></c:set>
				            <c:set var="endMemberAllSum_01_15" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 직원별 계 카운트 증가 -->
		    				<c:set var="memberCnt" value="${memberCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 직원별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 기타 소계 시작 -->
		    	<c:if test="${ptnrStatMemberAllEndList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="5" style="height:25px;">1종 기타 소계</th>
	                <!-- end12 -->
	                <th>${endMemberAllTotalSum_12_15}</th>
	                <!-- end11 -->
	                <th>${endMemberAllTotalSum_11_15}</th>
	                <!-- end10 -->
	                <th>${endMemberAllTotalSum_10_15}</th>
	                <!-- end09 -->
	                <th>${endMemberAllTotalSum_09_15}</th>
	                <!-- end08 -->
	                <th>${endMemberAllTotalSum_08_15}</th>
	                <!-- end07 -->
	                <th>${endMemberAllTotalSum_07_15}</th>
	                <!-- end06 -->
	                <th>${endMemberAllTotalSum_06_15}</th>
	                <!-- end05 -->
	                <th>${endMemberAllTotalSum_05_15}</th>
	                <!-- end04 -->
	                <th>${endMemberAllTotalSum_04_15}</th>
	                <!-- end03 -->
	                <th>${endMemberAllTotalSum_03_15}</th>
	                <!-- end02 -->
	                <th>${endMemberAllTotalSum_02_15}</th>
	                <!-- end01 -->
	                <th>${endMemberAllTotalSum_01_15}</th>
	                <!-- 가로열 합계 -->
	                <c:set var="endColTotalSum_15" value="${endMemberAllTotalSum_12_15 + endMemberAllTotalSum_11_15 + endMemberAllTotalSum_10_15 + endMemberAllTotalSum_09_15 + endMemberAllTotalSum_08_15 + endMemberAllTotalSum_07_15 + endMemberAllTotalSum_06_15 + endMemberAllTotalSum_05_15 + endMemberAllTotalSum_04_15 + endMemberAllTotalSum_03_15 + endMemberAllTotalSum_02_15 + endMemberAllTotalSum_01_15}"></c:set>
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
    <c:set var="endMemberAllTotalSum_12_all" value="${endMemberAllTotalSum_12_5 + endMemberAllTotalSum_12_10 + endMemberAllTotalSum_12_15}"></c:set>
    <c:set var="endMemberAllTotalSum_11_all" value="${endMemberAllTotalSum_11_5 + endMemberAllTotalSum_11_10 + endMemberAllTotalSum_11_15}"></c:set>
    <c:set var="endMemberAllTotalSum_10_all" value="${endMemberAllTotalSum_10_5 + endMemberAllTotalSum_10_10 + endMemberAllTotalSum_10_15}"></c:set>
    <c:set var="endMemberAllTotalSum_09_all" value="${endMemberAllTotalSum_09_5 + endMemberAllTotalSum_09_10 + endMemberAllTotalSum_09_15}"></c:set>
    <c:set var="endMemberAllTotalSum_08_all" value="${endMemberAllTotalSum_08_5 + endMemberAllTotalSum_08_10 + endMemberAllTotalSum_08_15}"></c:set>
    <c:set var="endMemberAllTotalSum_07_all" value="${endMemberAllTotalSum_07_5 + endMemberAllTotalSum_07_10 + endMemberAllTotalSum_07_15}"></c:set>
    <c:set var="endMemberAllTotalSum_06_all" value="${endMemberAllTotalSum_06_5 + endMemberAllTotalSum_06_10 + endMemberAllTotalSum_06_15}"></c:set>
    <c:set var="endMemberAllTotalSum_05_all" value="${endMemberAllTotalSum_05_5 + endMemberAllTotalSum_05_10 + endMemberAllTotalSum_05_15}"></c:set>
    <c:set var="endMemberAllTotalSum_04_all" value="${endMemberAllTotalSum_04_5 + endMemberAllTotalSum_04_10 + endMemberAllTotalSum_04_15}"></c:set>
    <c:set var="endMemberAllTotalSum_03_all" value="${endMemberAllTotalSum_03_5 + endMemberAllTotalSum_03_10 + endMemberAllTotalSum_03_15}"></c:set>
    <c:set var="endMemberAllTotalSum_02_all" value="${endMemberAllTotalSum_02_5 + endMemberAllTotalSum_02_10 + endMemberAllTotalSum_02_15}"></c:set>
    <c:set var="endMemberAllTotalSum_01_all" value="${endMemberAllTotalSum_01_5 + endMemberAllTotalSum_01_10 + endMemberAllTotalSum_01_15}"></c:set>        
    <c:set var="endMemberAllTotalSum_col_all" value="${endMemberAllTotalSum_12_all + endMemberAllTotalSum_11_all + endMemberAllTotalSum_10_all + endMemberAllTotalSum_09_all + endMemberAllTotalSum_08_all + endMemberAllTotalSum_07_all + endMemberAllTotalSum_06_all + endMemberAllTotalSum_05_all + endMemberAllTotalSum_04_all + endMemberAllTotalSum_03_all + endMemberAllTotalSum_02_all + endMemberAllTotalSum_01_all}"></c:set>
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 680px;height:25px;">전체합계</th>
                <th style="width: 80px;color:blue;">${endMemberAllTotalSum_12_all}</th>
                <th style="width: 80px;color:blue;">${endMemberAllTotalSum_11_all}</th>
                <th style="width: 80px;color:blue;">${endMemberAllTotalSum_10_all}</th>
                <th style="width: 80px;color:blue;">${endMemberAllTotalSum_09_all}</th>
                <th style="width: 80px;color:blue;">${endMemberAllTotalSum_08_all}</th>
                <th style="width: 80px;color:blue;">${endMemberAllTotalSum_07_all}</th>
                <th style="width: 80px;color:blue;">${endMemberAllTotalSum_06_all}</th>
                <th style="width: 80px;color:blue;">${endMemberAllTotalSum_05_all}</th>
                <th style="width: 80px;color:blue;">${endMemberAllTotalSum_04_all}</th>
                <th style="width: 80px;color:blue;">${endMemberAllTotalSum_03_all}</th>
                <th style="width: 80px;color:blue;">${endMemberAllTotalSum_02_all}</th>
                <th style="width: 80px;color:blue;">${endMemberAllTotalSum_01_all}</th>
				<th style="width: 80px;color:blue;">${endMemberAllTotalSum_col_all}</th>
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>