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
                <th style="width: 80px;">가로열 평균</th>
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
	            <c:set var="cntTimeCenterSum_12_5" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_11_5" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_10_5" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_09_5" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_08_5" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_07_5" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_06_5" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_05_5" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_04_5" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_03_5" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_02_5" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_01_5" value="0"></c:set>
	            
	            <!-- 센터별 평균 계 초기화 -->
				<c:set var="timeCenterSum_12_5" value="0"></c:set>
				<c:set var="timeCenterSum_11_5" value="0"></c:set>
				<c:set var="timeCenterSum_10_5" value="0"></c:set>
				<c:set var="timeCenterSum_09_5" value="0"></c:set>
				<c:set var="timeCenterSum_08_5" value="0"></c:set>
				<c:set var="timeCenterSum_07_5" value="0"></c:set>
				<c:set var="timeCenterSum_06_5" value="0"></c:set>
				<c:set var="timeCenterSum_05_5" value="0"></c:set>
				<c:set var="timeCenterSum_04_5" value="0"></c:set>
				<c:set var="timeCenterSum_03_5" value="0"></c:set>
				<c:set var="timeCenterSum_02_5" value="0"></c:set>
				<c:set var="timeCenterSum_01_5" value="0"></c:set>
								    
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
	            <c:set var="cntTimeCenterTotalSum_12_5" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_11_5" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_10_5" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_09_5" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_08_5" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_07_5" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_06_5" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_05_5" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_04_5" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_03_5" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_02_5" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_01_5" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntTimeColCenterTotalSum_5" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="timeCenterTotalSum_12_5" value="0"></c:set>
				<c:set var="timeCenterTotalSum_11_5" value="0"></c:set>
				<c:set var="timeCenterTotalSum_10_5" value="0"></c:set>
				<c:set var="timeCenterTotalSum_09_5" value="0"></c:set>
				<c:set var="timeCenterTotalSum_08_5" value="0"></c:set>
				<c:set var="timeCenterTotalSum_07_5" value="0"></c:set>
				<c:set var="timeCenterTotalSum_06_5" value="0"></c:set>
				<c:set var="timeCenterTotalSum_05_5" value="0"></c:set>
				<c:set var="timeCenterTotalSum_04_5" value="0"></c:set>
				<c:set var="timeCenterTotalSum_03_5" value="0"></c:set>
				<c:set var="timeCenterTotalSum_02_5" value="0"></c:set>
				<c:set var="timeCenterTotalSum_01_5" value="0"></c:set>
				
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
   				    			
    			<c:forEach var="vo" items="${ptnrStatCntTimeList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCntTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
		                    	1종 조사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>
		                		<td style="width:150px;">${vo.ptnrIdSubNm}</td>
		                		<!-- 센터별 계 초기화 -->
					            <c:set var="cntTimeCenterSum_12_5" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_11_5" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_10_5" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_09_5" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_08_5" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_07_5" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_06_5" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_05_5" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_04_5" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_03_5" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_02_5" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_01_5" value="0"></c:set>
					            
					            <!-- 센터별 평균 계 초기화 -->
								<c:set var="timeCenterSum_12_5" value="0"></c:set>
								<c:set var="timeCenterSum_11_5" value="0"></c:set>
								<c:set var="timeCenterSum_10_5" value="0"></c:set>
								<c:set var="timeCenterSum_09_5" value="0"></c:set>
								<c:set var="timeCenterSum_08_5" value="0"></c:set>
								<c:set var="timeCenterSum_07_5" value="0"></c:set>
								<c:set var="timeCenterSum_06_5" value="0"></c:set>
								<c:set var="timeCenterSum_05_5" value="0"></c:set>
								<c:set var="timeCenterSum_04_5" value="0"></c:set>
								<c:set var="timeCenterSum_03_5" value="0"></c:set>
								<c:set var="timeCenterSum_02_5" value="0"></c:set>
								<c:set var="timeCenterSum_01_5" value="0"></c:set>
												    
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
			    		<c:set var="cntTime12_5" value="${vo.cntTime12}"></c:set>
			            <c:set var="cntTime11_5" value="${vo.cntTime11}"></c:set>
			            <c:set var="cntTime10_5" value="${vo.cntTime10}"></c:set>
			            <c:set var="cntTime09_5" value="${vo.cntTime09}"></c:set>
			            <c:set var="cntTime08_5" value="${vo.cntTime08}"></c:set>
			            <c:set var="cntTime07_5" value="${vo.cntTime07}"></c:set>
			            <c:set var="cntTime06_5" value="${vo.cntTime06}"></c:set>
			            <c:set var="cntTime05_5" value="${vo.cntTime05}"></c:set>
			            <c:set var="cntTime04_5" value="${vo.cntTime04}"></c:set>
			            <c:set var="cntTime03_5" value="${vo.cntTime03}"></c:set>
			            <c:set var="cntTime02_5" value="${vo.cntTime02}"></c:set>
			            <c:set var="cntTime01_5" value="${vo.cntTime01}"></c:set>
			            
			            <!-- 소계 평균용 변수 -->
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
			            
			            <!-- cntTime12 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${cntTime12_5}" pattern="#,##0.##"/></td>
	                    <!-- cntTime11 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime11_5}" pattern="#,##0.##"/></td>
	                    <!-- cntTime10 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime10_5}" pattern="#,##0.##"/></td>
	                    <!-- cntTime09 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime09_5}" pattern="#,##0.##"/></td>
	                    <!-- cntTime08 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime08_5}" pattern="#,##0.##"/></td>
	                    <!-- cntTime07 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime07_5}" pattern="#,##0.##"/></td>
	                    <!-- cntTime06 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime06_5}" pattern="#,##0.##"/></td>
	                    <!-- cntTime05 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime05_5}" pattern="#,##0.##"/></td>
	                    <!-- cntTime04 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime04_5}" pattern="#,##0.##"/></td>
	                    <!-- cntTime03 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime03_5}" pattern="#,##0.##"/></td>
	                    <!-- cntTime02 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime02_5}" pattern="#,##0.##"/></td>
	                    <!-- cntTime01 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime01_5}" pattern="#,##0.##"/></td>
		                <!-- 가로 합계 -->
		                <c:set var="timeColSum_5" value="${time12_5 + time11_5 + time10_5 + time09_5 + time08_5 + time07_5 + time06_5 + time05_5 + time04_5 + time03_5 + time02_5 + time01_5}"></c:set>
		                <c:set var="endColSum_5" value="${end12_5 + end11_5 + end10_5 + end09_5 + end08_5 + end07_5 + end06_5 + end05_5 + end04_5 + end03_5 + end02_5 + end01_5}"></c:set>
		               	<c:choose>
		               		<c:when test="${timeColSum_5 eq 0 or endColSum_5 eq 0}">
		               			<c:set var="arvColSum_5" value="0"></c:set>
		               		</c:when>
		               		<c:otherwise>
		               			<c:set var="arvColSum_5" value="${timeColSum_5 / endColSum_5}"></c:set>
		               		</c:otherwise>
		               	</c:choose> 
		                <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvColSum_5}" pattern="#,##0.##"/></td>		                
		                
		                <!-- 센터별 계 합산 -->
	    				<c:set var="cntTimeCenterSum_12_5" value="${cntTimeCenterSum_12_5+cntTime12_5}"></c:set>
			            <c:set var="cntTimeCenterSum_11_5" value="${cntTimeCenterSum_11_5+cntTime11_5}"></c:set>
			            <c:set var="cntTimeCenterSum_10_5" value="${cntTimeCenterSum_10_5+cntTime10_5}"></c:set>
			            <c:set var="cntTimeCenterSum_09_5" value="${cntTimeCenterSum_09_5+cntTime09_5}"></c:set>
			            <c:set var="cntTimeCenterSum_08_5" value="${cntTimeCenterSum_08_5+cntTime08_5}"></c:set>
			            <c:set var="cntTimeCenterSum_07_5" value="${cntTimeCenterSum_07_5+cntTime07_5}"></c:set>
			            <c:set var="cntTimeCenterSum_06_5" value="${cntTimeCenterSum_06_5+cntTime06_5}"></c:set>
			            <c:set var="cntTimeCenterSum_05_5" value="${cntTimeCenterSum_05_5+cntTime05_5}"></c:set>
			            <c:set var="cntTimeCenterSum_04_5" value="${cntTimeCenterSum_04_5+cntTime04_5}"></c:set>
			            <c:set var="cntTimeCenterSum_03_5" value="${cntTimeCenterSum_03_5+cntTime03_5}"></c:set>
			            <c:set var="cntTimeCenterSum_02_5" value="${cntTimeCenterSum_02_5+cntTime02_5}"></c:set>
			            <c:set var="cntTimeCenterSum_01_5" value="${cntTimeCenterSum_01_5+cntTime01_5}"></c:set>
			            
			            <!-- 센터별 계 평균용 변수 -->
						<c:set var="timeCenterSum_12_5" value="${timeCenterSum_12_5+time12_5}"></c:set>
			            <c:set var="timeCenterSum_11_5" value="${timeCenterSum_11_5+time11_5}"></c:set>
			            <c:set var="timeCenterSum_10_5" value="${timeCenterSum_10_5+time10_5}"></c:set>
			            <c:set var="timeCenterSum_09_5" value="${timeCenterSum_09_5+time09_5}"></c:set>
			            <c:set var="timeCenterSum_08_5" value="${timeCenterSum_08_5+time08_5}"></c:set>
			            <c:set var="timeCenterSum_07_5" value="${timeCenterSum_07_5+time07_5}"></c:set>
			            <c:set var="timeCenterSum_06_5" value="${timeCenterSum_06_5+time06_5}"></c:set>
			            <c:set var="timeCenterSum_05_5" value="${timeCenterSum_05_5+time05_5}"></c:set>
			            <c:set var="timeCenterSum_04_5" value="${timeCenterSum_04_5+time04_5}"></c:set>
			            <c:set var="timeCenterSum_03_5" value="${timeCenterSum_03_5+time03_5}"></c:set>
			            <c:set var="timeCenterSum_02_5" value="${timeCenterSum_02_5+time02_5}"></c:set>
			            <c:set var="timeCenterSum_01_5" value="${timeCenterSum_01_5+time01_5}"></c:set>
				    
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
	                    <c:set var="cntTimeCenterTotalSum_12_5" value="${cntTimeCenterTotalSum_12_5 + cntTime12_5}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_11_5" value="${cntTimeCenterTotalSum_11_5 + cntTime11_5}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_10_5" value="${cntTimeCenterTotalSum_10_5 + cntTime10_5}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_09_5" value="${cntTimeCenterTotalSum_09_5 + cntTime09_5}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_08_5" value="${cntTimeCenterTotalSum_08_5 + cntTime08_5}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_07_5" value="${cntTimeCenterTotalSum_07_5 + cntTime07_5}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_06_5" value="${cntTimeCenterTotalSum_06_5 + cntTime06_5}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_05_5" value="${cntTimeCenterTotalSum_05_5 + cntTime05_5}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_04_5" value="${cntTimeCenterTotalSum_04_5 + cntTime04_5}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_03_5" value="${cntTimeCenterTotalSum_03_5 + cntTime03_5}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_02_5" value="${cntTimeCenterTotalSum_02_5 + cntTime02_5}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_01_5" value="${cntTimeCenterTotalSum_01_5 + cntTime01_5}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="timeCenterTotalSum_12_5" value="${timeCenterTotalSum_12_5 + time12_5}"></c:set>
	                    <c:set var="timeCenterTotalSum_11_5" value="${timeCenterTotalSum_11_5 + time11_5}"></c:set>
	                    <c:set var="timeCenterTotalSum_10_5" value="${timeCenterTotalSum_10_5 + time10_5}"></c:set>
	                    <c:set var="timeCenterTotalSum_09_5" value="${timeCenterTotalSum_09_5 + time09_5}"></c:set>
	                    <c:set var="timeCenterTotalSum_08_5" value="${timeCenterTotalSum_08_5 + time08_5}"></c:set>
	                    <c:set var="timeCenterTotalSum_07_5" value="${timeCenterTotalSum_07_5 + time07_5}"></c:set>
	                    <c:set var="timeCenterTotalSum_06_5" value="${timeCenterTotalSum_06_5 + time06_5}"></c:set>
	                    <c:set var="timeCenterTotalSum_05_5" value="${timeCenterTotalSum_05_5 + time05_5}"></c:set>
	                    <c:set var="timeCenterTotalSum_04_5" value="${timeCenterTotalSum_04_5 + time04_5}"></c:set>
	                    <c:set var="timeCenterTotalSum_03_5" value="${timeCenterTotalSum_03_5 + time03_5}"></c:set>
	                    <c:set var="timeCenterTotalSum_02_5" value="${timeCenterTotalSum_02_5 + time02_5}"></c:set>
	                    <c:set var="timeCenterTotalSum_01_5" value="${timeCenterTotalSum_01_5 + time01_5}"></c:set>

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
		    		
		    		<!-- 센터별 평균 계산 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${centerCnt == vo.rowCnt and vo.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">${vo.centerName} 평균</td>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_12_5 eq 0 or endCenterSum_12_5 eq 0}">
		    						<c:set var="arvCenterSum_12_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_12_5" value="${timeCenterSum_12_5 / endCenterSum_12_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_11_5 eq 0 or endCenterSum_11_5 eq 0}">
		    						<c:set var="arvCenterSum_11_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_11_5" value="${timeCenterSum_11_5 / endCenterSum_11_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_10_5 eq 0 or endCenterSum_10_5 eq 0}">
		    						<c:set var="arvCenterSum_10_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_10_5" value="${timeCenterSum_10_5 / endCenterSum_10_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_09_5 eq 0 or endCenterSum_09_5 eq 0}">
		    						<c:set var="arvCenterSum_09_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_09_5" value="${timeCenterSum_09_5 / endCenterSum_09_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_08_5 eq 0 or endCenterSum_08_5 eq 0}">
		    						<c:set var="arvCenterSum_08_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_08_5" value="${timeCenterSum_08_5 / endCenterSum_08_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_07_5 eq 0 or endCenterSum_07_5 eq 0}">
		    						<c:set var="arvCenterSum_07_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_07_5" value="${timeCenterSum_07_5 / endCenterSum_07_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_06_5 eq 0 or endCenterSum_06_5 eq 0}">
		    						<c:set var="arvCenterSum_06_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_06_5" value="${timeCenterSum_06_5 / endCenterSum_06_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_05_5 eq 0 or endCenterSum_05_5 eq 0}">
		    						<c:set var="arvCenterSum_05_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_05_5" value="${timeCenterSum_05_5 / endCenterSum_05_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_04_5 eq 0 or endCenterSum_04_5 eq 0}">
		    						<c:set var="arvCenterSum_04_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_04_5" value="${timeCenterSum_04_5 / endCenterSum_04_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_03_5 eq 0 or endCenterSum_03_5 eq 0}">
		    						<c:set var="arvCenterSum_03_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_03_5" value="${timeCenterSum_03_5 / endCenterSum_03_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_02_5 eq 0 or endCenterSum_02_5 eq 0}">
		    						<c:set var="arvCenterSum_02_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_02_5" value="${timeCenterSum_02_5 / endCenterSum_02_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_01_5 eq 0 or endCenterSum_01_5 eq 0}">
		    						<c:set var="arvCenterSum_01_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_01_5" value="${timeCenterSum_01_5 / endCenterSum_01_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 센터별 평균 계산 끝 -->
		    						    				
		    				<!-- cntTime12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_12_5}" pattern="#,##0.##"/></td>
		    				<!-- cntTime11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_11_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_10_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_09_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_08_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_07_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_06_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_05_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_04_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_03_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_02_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_01_5}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="timeCenterColSum_5" value="${timeCenterSum_12_5 + timeCenterSum_11_5 + timeCenterSum_10_5 + timeCenterSum_09_5 + timeCenterSum_08_5 + timeCenterSum_07_5 + timeCenterSum_06_5 + timeCenterSum_05_5 + timeCenterSum_04_5 + timeCenterSum_03_5 + timeCenterSum_02_5 + timeCenterSum_01_5}"></c:set>
			                <c:set var="endCenterColSum_5" value="${endCenterSum_12_5 + endCenterSum_11_5 + endCenterSum_10_5 + endCenterSum_09_5 + endCenterSum_08_5 + endCenterSum_07_5 + endCenterSum_06_5 + endCenterSum_05_5 + endCenterSum_04_5 + endCenterSum_03_5 + endCenterSum_02_5 + endCenterSum_01_5}"></c:set>			                
			                <c:choose>
			                	<c:when test="${timeCenterColSum_5 eq 0 or endCenterColSum_5 eq 0}">
			                		<c:set var="arvCenterColSum_5" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvCenterColSum_5" value="${timeCenterColSum_5 / endCenterColSum_5}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterColSum_5}" pattern="#,##0.##"/></td>
		    				
							<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>										                		    				
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="cntTimeCenterSum_12_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_11_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_10_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_09_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_08_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_07_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_06_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_05_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_04_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_03_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_02_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_01_5" value="0"></c:set>
				            
				            <!-- 센터별 평균 계 초기화 -->
							<c:set var="timeCenterSum_12_5" value="0"></c:set>
							<c:set var="timeCenterSum_11_5" value="0"></c:set>
							<c:set var="timeCenterSum_10_5" value="0"></c:set>
							<c:set var="timeCenterSum_09_5" value="0"></c:set>
							<c:set var="timeCenterSum_08_5" value="0"></c:set>
							<c:set var="timeCenterSum_07_5" value="0"></c:set>
							<c:set var="timeCenterSum_06_5" value="0"></c:set>
							<c:set var="timeCenterSum_05_5" value="0"></c:set>
							<c:set var="timeCenterSum_04_5" value="0"></c:set>
							<c:set var="timeCenterSum_03_5" value="0"></c:set>
							<c:set var="timeCenterSum_02_5" value="0"></c:set>
							<c:set var="timeCenterSum_01_5" value="0"></c:set>
											    
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
				            <c:set var="cntTimeCenterSum_12_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_11_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_10_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_09_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_08_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_07_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_06_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_05_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_04_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_03_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_02_5" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_01_5" value="0"></c:set>
				            
				            <!-- 센터별 평균 계 초기화 -->
							<c:set var="timeCenterSum_12_5" value="0"></c:set>
							<c:set var="timeCenterSum_11_5" value="0"></c:set>
							<c:set var="timeCenterSum_10_5" value="0"></c:set>
							<c:set var="timeCenterSum_09_5" value="0"></c:set>
							<c:set var="timeCenterSum_08_5" value="0"></c:set>
							<c:set var="timeCenterSum_07_5" value="0"></c:set>
							<c:set var="timeCenterSum_06_5" value="0"></c:set>
							<c:set var="timeCenterSum_05_5" value="0"></c:set>
							<c:set var="timeCenterSum_04_5" value="0"></c:set>
							<c:set var="timeCenterSum_03_5" value="0"></c:set>
							<c:set var="timeCenterSum_02_5" value="0"></c:set>
							<c:set var="timeCenterSum_01_5" value="0"></c:set>
											    
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
		    	<c:if test="${ptnrStatCntTimeList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 조사 평균</th>
	                <c:choose>
    					<c:when test="${timeCenterTotalSum_12_5 eq 0 or endCenterTotalSum_12_5 eq 0}">
    						<c:set var="arvCenterTotalSum_12_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_12_5" value="${timeCenterTotalSum_12_5 / endCenterTotalSum_12_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_11_5 eq 0 or endCenterTotalSum_11_5 eq 0}">
    						<c:set var="arvCenterTotalSum_11_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_11_5" value="${timeCenterTotalSum_11_5 / endCenterTotalSum_11_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_10_5 eq 0 or endCenterTotalSum_10_5 eq 0}">
    						<c:set var="arvCenterTotalSum_10_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_10_5" value="${timeCenterTotalSum_10_5 / endCenterTotalSum_10_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_09_5 eq 0 or endCenterTotalSum_09_5 eq 0}">
    						<c:set var="arvCenterTotalSum_09_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_09_5" value="${timeCenterTotalSum_09_5 / endCenterTotalSum_09_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_08_5 eq 0 or endCenterTotalSum_08_5 eq 0}">
    						<c:set var="arvCenterTotalSum_08_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_08_5" value="${timeCenterTotalSum_08_5 / endCenterTotalSum_08_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_07_5 eq 0 or endCenterTotalSum_07_5 eq 0}">
    						<c:set var="arvCenterTotalSum_07_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_07_5" value="${timeCenterTotalSum_07_5 / endCenterTotalSum_07_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_06_5 eq 0 or endCenterTotalSum_06_5 eq 0}">
    						<c:set var="arvCenterTotalSum_06_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_06_5" value="${timeCenterTotalSum_06_5 / endCenterTotalSum_06_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_05_5 eq 0 or endCenterTotalSum_05_5 eq 0}">
    						<c:set var="arvCenterTotalSum_05_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_05_5" value="${timeCenterTotalSum_05_5 / endCenterTotalSum_05_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_04_5 eq 0 or endCenterTotalSum_04_5 eq 0}">
    						<c:set var="arvCenterTotalSum_04_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_04_5" value="${timeCenterTotalSum_04_5 / endCenterTotalSum_04_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_03_5 eq 0 or endCenterTotalSum_03_5 eq 0}">
    						<c:set var="arvCenterTotalSum_03_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_03_5" value="${timeCenterTotalSum_03_5 / endCenterTotalSum_03_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_02_5 eq 0 or endCenterTotalSum_02_5 eq 0}">
    						<c:set var="arvCenterTotalSum_02_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_02_5" value="${timeCenterTotalSum_02_5 / endCenterTotalSum_02_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_01_5 eq 0 or endCenterTotalSum_01_5 eq 0}">
    						<c:set var="arvCenterTotalSum_01_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_01_5" value="${timeCenterTotalSum_01_5 / endCenterTotalSum_01_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 센터별 평균 계산 끝 -->
    						    				
    				<!-- cntTime12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_12_5}" pattern="#,##0.##"/></th>
    				<!-- cntTime11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_11_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_10_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_09_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_08_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_07_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_06_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_05_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_04_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_03_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_02_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_01_5}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="timeColCenterTotalSum_5" value="${timeCenterTotalSum_12_5 + timeCenterTotalSum_11_5 + timeCenterTotalSum_10_5 + timeCenterTotalSum_09_5 + timeCenterTotalSum_08_5 + timeCenterTotalSum_07_5 + timeCenterTotalSum_06_5 + timeCenterTotalSum_05_5 + timeCenterTotalSum_04_5 + timeCenterTotalSum_03_5 + timeCenterTotalSum_02_5 + timeCenterTotalSum_01_5}"></c:set>
	                <c:set var="endColCenterTotalSum_5" value="${endCenterTotalSum_12_5 + endCenterTotalSum_11_5 + endCenterTotalSum_10_5 + endCenterTotalSum_09_5 + endCenterTotalSum_08_5 + endCenterTotalSum_07_5 + endCenterTotalSum_06_5 + endCenterTotalSum_05_5 + endCenterTotalSum_04_5 + endCenterTotalSum_03_5 + endCenterTotalSum_02_5 + endCenterTotalSum_01_5}"></c:set>
					<c:choose>
	                	<c:when test="${timeColCenterTotalSum_5 eq 0 or endColCenterTotalSum_5 eq 0}">
	                		<c:set var="arvColCenterTotalSum_5" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColCenterTotalSum_5" value="${timeColCenterTotalSum_5 / endColCenterTotalSum_5}"/>
	                	</c:otherwise>
					</c:choose>
	                
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvColCenterTotalSum_5}" pattern="#,##0.##"/></th>
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
	            <c:set var="cntTimeCenterSum_12_10" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_11_10" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_10_10" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_09_10" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_08_10" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_07_10" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_06_10" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_05_10" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_04_10" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_03_10" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_02_10" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_01_10" value="0"></c:set>
	            
	            <!-- 센터별 평균 계 초기화 -->
				<c:set var="timeCenterSum_12_10" value="0"></c:set>
				<c:set var="timeCenterSum_11_10" value="0"></c:set>
				<c:set var="timeCenterSum_10_10" value="0"></c:set>
				<c:set var="timeCenterSum_09_10" value="0"></c:set>
				<c:set var="timeCenterSum_08_10" value="0"></c:set>
				<c:set var="timeCenterSum_07_10" value="0"></c:set>
				<c:set var="timeCenterSum_06_10" value="0"></c:set>
				<c:set var="timeCenterSum_05_10" value="0"></c:set>
				<c:set var="timeCenterSum_04_10" value="0"></c:set>
				<c:set var="timeCenterSum_03_10" value="0"></c:set>
				<c:set var="timeCenterSum_02_10" value="0"></c:set>
				<c:set var="timeCenterSum_01_10" value="0"></c:set>
								    
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
	            <c:set var="cntTimeCenterTotalSum_12_10" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_11_10" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_10_10" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_09_10" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_08_10" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_07_10" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_06_10" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_05_10" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_04_10" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_03_10" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_02_10" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_01_10" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntTimeColCenterTotalSum_10" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="timeCenterTotalSum_12_10" value="0"></c:set>
				<c:set var="timeCenterTotalSum_11_10" value="0"></c:set>
				<c:set var="timeCenterTotalSum_10_10" value="0"></c:set>
				<c:set var="timeCenterTotalSum_09_10" value="0"></c:set>
				<c:set var="timeCenterTotalSum_08_10" value="0"></c:set>
				<c:set var="timeCenterTotalSum_07_10" value="0"></c:set>
				<c:set var="timeCenterTotalSum_06_10" value="0"></c:set>
				<c:set var="timeCenterTotalSum_05_10" value="0"></c:set>
				<c:set var="timeCenterTotalSum_04_10" value="0"></c:set>
				<c:set var="timeCenterTotalSum_03_10" value="0"></c:set>
				<c:set var="timeCenterTotalSum_02_10" value="0"></c:set>
				<c:set var="timeCenterTotalSum_01_10" value="0"></c:set>
				
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
   				    			
    			<c:forEach var="vo1" items="${ptnrStatCntTimeList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCntTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
		                    	1종 심사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo1.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>
		                		<td style="width:150px;">${vo1.ptnrIdSubNm}</td>
		                		<!-- 센터별 계 초기화 -->
					            <c:set var="cntTimeCenterSum_12_10" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_11_10" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_10_10" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_09_10" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_08_10" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_07_10" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_06_10" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_05_10" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_04_10" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_03_10" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_02_10" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_01_10" value="0"></c:set>
					            
					            <!-- 센터별 평균 계 초기화 -->
								<c:set var="timeCenterSum_12_10" value="0"></c:set>
								<c:set var="timeCenterSum_11_10" value="0"></c:set>
								<c:set var="timeCenterSum_10_10" value="0"></c:set>
								<c:set var="timeCenterSum_09_10" value="0"></c:set>
								<c:set var="timeCenterSum_08_10" value="0"></c:set>
								<c:set var="timeCenterSum_07_10" value="0"></c:set>
								<c:set var="timeCenterSum_06_10" value="0"></c:set>
								<c:set var="timeCenterSum_05_10" value="0"></c:set>
								<c:set var="timeCenterSum_04_10" value="0"></c:set>
								<c:set var="timeCenterSum_03_10" value="0"></c:set>
								<c:set var="timeCenterSum_02_10" value="0"></c:set>
								<c:set var="timeCenterSum_01_10" value="0"></c:set>
												    
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
			    		<c:set var="cntTime12_10" value="${vo1.cntTime12}"></c:set>
			            <c:set var="cntTime11_10" value="${vo1.cntTime11}"></c:set>
			            <c:set var="cntTime10_10" value="${vo1.cntTime10}"></c:set>
			            <c:set var="cntTime09_10" value="${vo1.cntTime09}"></c:set>
			            <c:set var="cntTime08_10" value="${vo1.cntTime08}"></c:set>
			            <c:set var="cntTime07_10" value="${vo1.cntTime07}"></c:set>
			            <c:set var="cntTime06_10" value="${vo1.cntTime06}"></c:set>
			            <c:set var="cntTime05_10" value="${vo1.cntTime05}"></c:set>
			            <c:set var="cntTime04_10" value="${vo1.cntTime04}"></c:set>
			            <c:set var="cntTime03_10" value="${vo1.cntTime03}"></c:set>
			            <c:set var="cntTime02_10" value="${vo1.cntTime02}"></c:set>
			            <c:set var="cntTime01_10" value="${vo1.cntTime01}"></c:set>
			            
			            <!-- 소계 평균용 변수 -->
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
			            
			            <!-- cntTime12 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${cntTime12_10}" pattern="#,##0.##"/></td>
	                    <!-- cntTime11 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime11_10}" pattern="#,##0.##"/></td>
	                    <!-- cntTime10 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime10_10}" pattern="#,##0.##"/></td>
	                    <!-- cntTime09 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime09_10}" pattern="#,##0.##"/></td>
	                    <!-- cntTime08 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime08_10}" pattern="#,##0.##"/></td>
	                    <!-- cntTime07 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime07_10}" pattern="#,##0.##"/></td>
	                    <!-- cntTime06 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime06_10}" pattern="#,##0.##"/></td>
	                    <!-- cntTime05 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime05_10}" pattern="#,##0.##"/></td>
	                    <!-- cntTime04 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime04_10}" pattern="#,##0.##"/></td>
	                    <!-- cntTime03 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime03_10}" pattern="#,##0.##"/></td>
	                    <!-- cntTime02 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime02_10}" pattern="#,##0.##"/></td>
	                    <!-- cntTime01 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime01_10}" pattern="#,##0.##"/></td>
		                <!-- 가로 합계 -->
		                <c:set var="timeColSum_10" value="${time12_10 + time11_10 + time10_10 + time09_10 + time08_10 + time07_10 + time06_10 + time05_10 + time04_10 + time03_10 + time02_10 + time01_10}"></c:set>
		                <c:set var="endColSum_10" value="${end12_10 + end11_10 + end10_10 + end09_10 + end08_10 + end07_10 + end06_10 + end05_10 + end04_10 + end03_10 + end02_10 + end01_10}"></c:set>
		               	<c:choose>
		               		<c:when test="${timeColSum_10 eq 0 or endColSum_10 eq 0}">
		               			<c:set var="arvColSum_10" value="0"></c:set>
		               		</c:when>
		               		<c:otherwise>
		               			<c:set var="arvColSum_10" value="${timeColSum_10 / endColSum_10}"></c:set>
		               		</c:otherwise>
		               	</c:choose>
		               	<td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvColSum_10}" pattern="#,##0.##"/></td>		                
		                
		                <!-- 센터별 계 합산 -->
	    				<c:set var="cntTimeCenterSum_12_10" value="${cntTimeCenterSum_12_10+cntTime12_10}"></c:set>
			            <c:set var="cntTimeCenterSum_11_10" value="${cntTimeCenterSum_11_10+cntTime11_10}"></c:set>
			            <c:set var="cntTimeCenterSum_10_10" value="${cntTimeCenterSum_10_10+cntTime10_10}"></c:set>
			            <c:set var="cntTimeCenterSum_09_10" value="${cntTimeCenterSum_09_10+cntTime09_10}"></c:set>
			            <c:set var="cntTimeCenterSum_08_10" value="${cntTimeCenterSum_08_10+cntTime08_10}"></c:set>
			            <c:set var="cntTimeCenterSum_07_10" value="${cntTimeCenterSum_07_10+cntTime07_10}"></c:set>
			            <c:set var="cntTimeCenterSum_06_10" value="${cntTimeCenterSum_06_10+cntTime06_10}"></c:set>
			            <c:set var="cntTimeCenterSum_05_10" value="${cntTimeCenterSum_05_10+cntTime05_10}"></c:set>
			            <c:set var="cntTimeCenterSum_04_10" value="${cntTimeCenterSum_04_10+cntTime04_10}"></c:set>
			            <c:set var="cntTimeCenterSum_03_10" value="${cntTimeCenterSum_03_10+cntTime03_10}"></c:set>
			            <c:set var="cntTimeCenterSum_02_10" value="${cntTimeCenterSum_02_10+cntTime02_10}"></c:set>
			            <c:set var="cntTimeCenterSum_01_10" value="${cntTimeCenterSum_01_10+cntTime01_10}"></c:set>
			            
			            <!-- 센터별 계 평균용 변수 -->
						<c:set var="timeCenterSum_12_10" value="${timeCenterSum_12_10+time12_10}"></c:set>
			            <c:set var="timeCenterSum_11_10" value="${timeCenterSum_11_10+time11_10}"></c:set>
			            <c:set var="timeCenterSum_10_10" value="${timeCenterSum_10_10+time10_10}"></c:set>
			            <c:set var="timeCenterSum_09_10" value="${timeCenterSum_09_10+time09_10}"></c:set>
			            <c:set var="timeCenterSum_08_10" value="${timeCenterSum_08_10+time08_10}"></c:set>
			            <c:set var="timeCenterSum_07_10" value="${timeCenterSum_07_10+time07_10}"></c:set>
			            <c:set var="timeCenterSum_06_10" value="${timeCenterSum_06_10+time06_10}"></c:set>
			            <c:set var="timeCenterSum_05_10" value="${timeCenterSum_05_10+time05_10}"></c:set>
			            <c:set var="timeCenterSum_04_10" value="${timeCenterSum_04_10+time04_10}"></c:set>
			            <c:set var="timeCenterSum_03_10" value="${timeCenterSum_03_10+time03_10}"></c:set>
			            <c:set var="timeCenterSum_02_10" value="${timeCenterSum_02_10+time02_10}"></c:set>
			            <c:set var="timeCenterSum_01_10" value="${timeCenterSum_01_10+time01_10}"></c:set>
				    
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
	                    <c:set var="cntTimeCenterTotalSum_12_10" value="${cntTimeCenterTotalSum_12_10 + cntTime12_10}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_11_10" value="${cntTimeCenterTotalSum_11_10 + cntTime11_10}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_10_10" value="${cntTimeCenterTotalSum_10_10 + cntTime10_10}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_09_10" value="${cntTimeCenterTotalSum_09_10 + cntTime09_10}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_08_10" value="${cntTimeCenterTotalSum_08_10 + cntTime08_10}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_07_10" value="${cntTimeCenterTotalSum_07_10 + cntTime07_10}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_06_10" value="${cntTimeCenterTotalSum_06_10 + cntTime06_10}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_05_10" value="${cntTimeCenterTotalSum_05_10 + cntTime05_10}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_04_10" value="${cntTimeCenterTotalSum_04_10 + cntTime04_10}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_03_10" value="${cntTimeCenterTotalSum_03_10 + cntTime03_10}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_02_10" value="${cntTimeCenterTotalSum_02_10 + cntTime02_10}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_01_10" value="${cntTimeCenterTotalSum_01_10 + cntTime01_10}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="timeCenterTotalSum_12_10" value="${timeCenterTotalSum_12_10 + time12_10}"></c:set>
	                    <c:set var="timeCenterTotalSum_11_10" value="${timeCenterTotalSum_11_10 + time11_10}"></c:set>
	                    <c:set var="timeCenterTotalSum_10_10" value="${timeCenterTotalSum_10_10 + time10_10}"></c:set>
	                    <c:set var="timeCenterTotalSum_09_10" value="${timeCenterTotalSum_09_10 + time09_10}"></c:set>
	                    <c:set var="timeCenterTotalSum_08_10" value="${timeCenterTotalSum_08_10 + time08_10}"></c:set>
	                    <c:set var="timeCenterTotalSum_07_10" value="${timeCenterTotalSum_07_10 + time07_10}"></c:set>
	                    <c:set var="timeCenterTotalSum_06_10" value="${timeCenterTotalSum_06_10 + time06_10}"></c:set>
	                    <c:set var="timeCenterTotalSum_05_10" value="${timeCenterTotalSum_05_10 + time05_10}"></c:set>
	                    <c:set var="timeCenterTotalSum_04_10" value="${timeCenterTotalSum_04_10 + time04_10}"></c:set>
	                    <c:set var="timeCenterTotalSum_03_10" value="${timeCenterTotalSum_03_10 + time03_10}"></c:set>
	                    <c:set var="timeCenterTotalSum_02_10" value="${timeCenterTotalSum_02_10 + time02_10}"></c:set>
	                    <c:set var="timeCenterTotalSum_01_10" value="${timeCenterTotalSum_01_10 + time01_10}"></c:set>

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
		    		
		    		<!-- 센터별 평균 계산 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${centerCnt == vo1.rowCnt and vo1.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">${vo1.centerName} 평균</td>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_12_10 eq 0 or endCenterSum_12_10 eq 0}">
		    						<c:set var="arvCenterSum_12_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_12_10" value="${timeCenterSum_12_10 / endCenterSum_12_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_11_10 eq 0 or endCenterSum_11_10 eq 0}">
		    						<c:set var="arvCenterSum_11_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_11_10" value="${timeCenterSum_11_10 / endCenterSum_11_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_10_10 eq 0 or endCenterSum_10_10 eq 0}">
		    						<c:set var="arvCenterSum_10_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_10_10" value="${timeCenterSum_10_10 / endCenterSum_10_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_09_10 eq 0 or endCenterSum_09_10 eq 0}">
		    						<c:set var="arvCenterSum_09_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_09_10" value="${timeCenterSum_09_10 / endCenterSum_09_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_08_10 eq 0 or endCenterSum_08_10 eq 0}">
		    						<c:set var="arvCenterSum_08_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_08_10" value="${timeCenterSum_08_10 / endCenterSum_08_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_07_10 eq 0 or endCenterSum_07_10 eq 0}">
		    						<c:set var="arvCenterSum_07_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_07_10" value="${timeCenterSum_07_10 / endCenterSum_07_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_06_10 eq 0 or endCenterSum_06_10 eq 0}">
		    						<c:set var="arvCenterSum_06_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_06_10" value="${timeCenterSum_06_10 / endCenterSum_06_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_05_10 eq 0 or endCenterSum_05_10 eq 0}">
		    						<c:set var="arvCenterSum_05_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_05_10" value="${timeCenterSum_05_10 / endCenterSum_05_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_04_10 eq 0 or endCenterSum_04_10 eq 0}">
		    						<c:set var="arvCenterSum_04_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_04_10" value="${timeCenterSum_04_10 / endCenterSum_04_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_03_10 eq 0 or endCenterSum_03_10 eq 0}">
		    						<c:set var="arvCenterSum_03_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_03_10" value="${timeCenterSum_03_10 / endCenterSum_03_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_02_10 eq 0 or endCenterSum_02_10 eq 0}">
		    						<c:set var="arvCenterSum_02_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_02_10" value="${timeCenterSum_02_10 / endCenterSum_02_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_01_10 eq 0 or endCenterSum_01_10 eq 0}">
		    						<c:set var="arvCenterSum_01_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_01_10" value="${timeCenterSum_01_10 / endCenterSum_01_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 센터별 평균 계산 끝 -->
		    						    				
		    				<!-- cntTime12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_12_10}" pattern="#,##0.##"/></td>
		    				<!-- cntTime11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_11_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_10_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_09_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_08_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_07_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_06_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_05_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_04_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_03_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_02_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_01_10}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="timeCenterColSum_10" value="${timeCenterSum_12_10 + timeCenterSum_11_10 + timeCenterSum_10_10 + timeCenterSum_09_10 + timeCenterSum_08_10 + timeCenterSum_07_10 + timeCenterSum_06_10 + timeCenterSum_05_10 + timeCenterSum_04_10 + timeCenterSum_03_10 + timeCenterSum_02_10 + timeCenterSum_01_10}"></c:set>
			                <c:set var="endCenterColSum_10" value="${endCenterSum_12_10 + endCenterSum_11_10 + endCenterSum_10_10 + endCenterSum_09_10 + endCenterSum_08_10 + endCenterSum_07_10 + endCenterSum_06_10 + endCenterSum_05_10 + endCenterSum_04_10 + endCenterSum_03_10 + endCenterSum_02_10 + endCenterSum_01_10}"></c:set>			                
			                <c:choose>
			                	<c:when test="${timeCenterColSum_10 eq 0 or endCenterColSum_10 eq 0}">
			                		<c:set var="arvCenterColSum_10" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvCenterColSum_10" value="${timeCenterColSum_10 / endCenterColSum_10}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterColSum_10}" pattern="#,##0.##"/></td>
		    				
							<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>										                		    				
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="cntTimeCenterSum_12_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_11_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_10_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_09_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_08_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_07_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_06_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_05_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_04_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_03_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_02_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_01_10" value="0"></c:set>
				            
				            <!-- 센터별 평균 계 초기화 -->
							<c:set var="timeCenterSum_12_10" value="0"></c:set>
							<c:set var="timeCenterSum_11_10" value="0"></c:set>
							<c:set var="timeCenterSum_10_10" value="0"></c:set>
							<c:set var="timeCenterSum_09_10" value="0"></c:set>
							<c:set var="timeCenterSum_08_10" value="0"></c:set>
							<c:set var="timeCenterSum_07_10" value="0"></c:set>
							<c:set var="timeCenterSum_06_10" value="0"></c:set>
							<c:set var="timeCenterSum_05_10" value="0"></c:set>
							<c:set var="timeCenterSum_04_10" value="0"></c:set>
							<c:set var="timeCenterSum_03_10" value="0"></c:set>
							<c:set var="timeCenterSum_02_10" value="0"></c:set>
							<c:set var="timeCenterSum_01_10" value="0"></c:set>
											    
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
				            <c:set var="cntTimeCenterSum_12_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_11_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_10_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_09_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_08_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_07_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_06_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_05_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_04_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_03_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_02_10" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_01_10" value="0"></c:set>
				            
				            <!-- 센터별 평균 계 초기화 -->
							<c:set var="timeCenterSum_12_10" value="0"></c:set>
							<c:set var="timeCenterSum_11_10" value="0"></c:set>
							<c:set var="timeCenterSum_10_10" value="0"></c:set>
							<c:set var="timeCenterSum_09_10" value="0"></c:set>
							<c:set var="timeCenterSum_08_10" value="0"></c:set>
							<c:set var="timeCenterSum_07_10" value="0"></c:set>
							<c:set var="timeCenterSum_06_10" value="0"></c:set>
							<c:set var="timeCenterSum_05_10" value="0"></c:set>
							<c:set var="timeCenterSum_04_10" value="0"></c:set>
							<c:set var="timeCenterSum_03_10" value="0"></c:set>
							<c:set var="timeCenterSum_02_10" value="0"></c:set>
							<c:set var="timeCenterSum_01_10" value="0"></c:set>
											    
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
		    	<c:if test="${ptnrStatCntTimeList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 심사 평균</th>
	                <c:choose>
    					<c:when test="${timeCenterTotalSum_12_10 eq 0 or endCenterTotalSum_12_10 eq 0}">
    						<c:set var="arvCenterTotalSum_12_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_12_10" value="${timeCenterTotalSum_12_10 / endCenterTotalSum_12_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_11_10 eq 0 or endCenterTotalSum_11_10 eq 0}">
    						<c:set var="arvCenterTotalSum_11_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_11_10" value="${timeCenterTotalSum_11_10 / endCenterTotalSum_11_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_10_10 eq 0 or endCenterTotalSum_10_10 eq 0}">
    						<c:set var="arvCenterTotalSum_10_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_10_10" value="${timeCenterTotalSum_10_10 / endCenterTotalSum_10_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_09_10 eq 0 or endCenterTotalSum_09_10 eq 0}">
    						<c:set var="arvCenterTotalSum_09_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_09_10" value="${timeCenterTotalSum_09_10 / endCenterTotalSum_09_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_08_10 eq 0 or endCenterTotalSum_08_10 eq 0}">
    						<c:set var="arvCenterTotalSum_08_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_08_10" value="${timeCenterTotalSum_08_10 / endCenterTotalSum_08_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_07_10 eq 0 or endCenterTotalSum_07_10 eq 0}">
    						<c:set var="arvCenterTotalSum_07_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_07_10" value="${timeCenterTotalSum_07_10 / endCenterTotalSum_07_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_06_10 eq 0 or endCenterTotalSum_06_10 eq 0}">
    						<c:set var="arvCenterTotalSum_06_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_06_10" value="${timeCenterTotalSum_06_10 / endCenterTotalSum_06_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_05_10 eq 0 or endCenterTotalSum_05_10 eq 0}">
    						<c:set var="arvCenterTotalSum_05_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_05_10" value="${timeCenterTotalSum_05_10 / endCenterTotalSum_05_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_04_10 eq 0 or endCenterTotalSum_04_10 eq 0}">
    						<c:set var="arvCenterTotalSum_04_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_04_10" value="${timeCenterTotalSum_04_10 / endCenterTotalSum_04_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_03_10 eq 0 or endCenterTotalSum_03_10 eq 0}">
    						<c:set var="arvCenterTotalSum_03_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_03_10" value="${timeCenterTotalSum_03_10 / endCenterTotalSum_03_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_02_10 eq 0 or endCenterTotalSum_02_10 eq 0}">
    						<c:set var="arvCenterTotalSum_02_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_02_10" value="${timeCenterTotalSum_02_10 / endCenterTotalSum_02_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_01_10 eq 0 or endCenterTotalSum_01_10 eq 0}">
    						<c:set var="arvCenterTotalSum_01_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_01_10" value="${timeCenterTotalSum_01_10 / endCenterTotalSum_01_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 센터별 평균 계산 끝 -->
    						    				
    				<!-- cntTime12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_12_10}" pattern="#,##0.##"/></th>
    				<!-- cntTime11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_11_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_10_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_09_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_08_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_07_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_06_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_05_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_04_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_03_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_02_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_01_10}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="timeColCenterTotalSum_10" value="${timeCenterTotalSum_12_10 + timeCenterTotalSum_11_10 + timeCenterTotalSum_10_10 + timeCenterTotalSum_09_10 + timeCenterTotalSum_08_10 + timeCenterTotalSum_07_10 + timeCenterTotalSum_06_10 + timeCenterTotalSum_05_10 + timeCenterTotalSum_04_10 + timeCenterTotalSum_03_10 + timeCenterTotalSum_02_10 + timeCenterTotalSum_01_10}"></c:set>
	                <c:set var="endColCenterTotalSum_10" value="${endCenterTotalSum_12_10 + endCenterTotalSum_11_10 + endCenterTotalSum_10_10 + endCenterTotalSum_09_10 + endCenterTotalSum_08_10 + endCenterTotalSum_07_10 + endCenterTotalSum_06_10 + endCenterTotalSum_05_10 + endCenterTotalSum_04_10 + endCenterTotalSum_03_10 + endCenterTotalSum_02_10 + endCenterTotalSum_01_10}"></c:set>
					<c:choose>
	                	<c:when test="${timeColCenterTotalSum_10 eq 0 or endColCenterTotalSum_10 eq 0}">
	                		<c:set var="arvColCenterTotalSum_10" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColCenterTotalSum_10" value="${timeColCenterTotalSum_10 / endColCenterTotalSum_10}"/>
	                	</c:otherwise>
					</c:choose>
	                
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvColCenterTotalSum_10}" pattern="#,##0.##"/></th>
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
	            <c:set var="cntTimeCenterSum_12_15" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_11_15" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_10_15" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_09_15" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_08_15" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_07_15" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_06_15" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_05_15" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_04_15" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_03_15" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_02_15" value="0"></c:set>
	            <c:set var="cntTimeCenterSum_01_15" value="0"></c:set>
	            
	            <!-- 센터별 평균 계 초기화 -->
				<c:set var="timeCenterSum_12_15" value="0"></c:set>
				<c:set var="timeCenterSum_11_15" value="0"></c:set>
				<c:set var="timeCenterSum_10_15" value="0"></c:set>
				<c:set var="timeCenterSum_09_15" value="0"></c:set>
				<c:set var="timeCenterSum_08_15" value="0"></c:set>
				<c:set var="timeCenterSum_07_15" value="0"></c:set>
				<c:set var="timeCenterSum_06_15" value="0"></c:set>
				<c:set var="timeCenterSum_05_15" value="0"></c:set>
				<c:set var="timeCenterSum_04_15" value="0"></c:set>
				<c:set var="timeCenterSum_03_15" value="0"></c:set>
				<c:set var="timeCenterSum_02_15" value="0"></c:set>
				<c:set var="timeCenterSum_01_15" value="0"></c:set>
								    
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
	            <c:set var="cntTimeCenterTotalSum_12_15" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_11_15" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_10_15" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_09_15" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_08_15" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_07_15" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_06_15" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_05_15" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_04_15" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_03_15" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_02_15" value="0"></c:set>
	            <c:set var="cntTimeCenterTotalSum_01_15" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntTimeColCenterTotalSum_15" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="timeCenterTotalSum_12_15" value="0"></c:set>
				<c:set var="timeCenterTotalSum_11_15" value="0"></c:set>
				<c:set var="timeCenterTotalSum_10_15" value="0"></c:set>
				<c:set var="timeCenterTotalSum_09_15" value="0"></c:set>
				<c:set var="timeCenterTotalSum_08_15" value="0"></c:set>
				<c:set var="timeCenterTotalSum_07_15" value="0"></c:set>
				<c:set var="timeCenterTotalSum_06_15" value="0"></c:set>
				<c:set var="timeCenterTotalSum_05_15" value="0"></c:set>
				<c:set var="timeCenterTotalSum_04_15" value="0"></c:set>
				<c:set var="timeCenterTotalSum_03_15" value="0"></c:set>
				<c:set var="timeCenterTotalSum_02_15" value="0"></c:set>
				<c:set var="timeCenterTotalSum_01_15" value="0"></c:set>
				
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
   				    			
    			<c:forEach var="vo2" items="${ptnrStatCntTimeList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCntTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
		                    	1종 기타
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo2.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>
		                		<td style="width:150px;">${vo2.ptnrIdSubNm}</td>
		                		<!-- 센터별 계 초기화 -->
					            <c:set var="cntTimeCenterSum_12_15" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_11_15" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_10_15" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_09_15" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_08_15" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_07_15" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_06_15" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_05_15" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_04_15" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_03_15" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_02_15" value="0"></c:set>
					            <c:set var="cntTimeCenterSum_01_15" value="0"></c:set>
					            
					            <!-- 센터별 평균 계 초기화 -->
								<c:set var="timeCenterSum_12_15" value="0"></c:set>
								<c:set var="timeCenterSum_11_15" value="0"></c:set>
								<c:set var="timeCenterSum_10_15" value="0"></c:set>
								<c:set var="timeCenterSum_09_15" value="0"></c:set>
								<c:set var="timeCenterSum_08_15" value="0"></c:set>
								<c:set var="timeCenterSum_07_15" value="0"></c:set>
								<c:set var="timeCenterSum_06_15" value="0"></c:set>
								<c:set var="timeCenterSum_05_15" value="0"></c:set>
								<c:set var="timeCenterSum_04_15" value="0"></c:set>
								<c:set var="timeCenterSum_03_15" value="0"></c:set>
								<c:set var="timeCenterSum_02_15" value="0"></c:set>
								<c:set var="timeCenterSum_01_15" value="0"></c:set>
												    
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
			    		<c:set var="cntTime12_15" value="${vo2.cntTime12}"></c:set>
			            <c:set var="cntTime11_15" value="${vo2.cntTime11}"></c:set>
			            <c:set var="cntTime10_15" value="${vo2.cntTime10}"></c:set>
			            <c:set var="cntTime09_15" value="${vo2.cntTime09}"></c:set>
			            <c:set var="cntTime08_15" value="${vo2.cntTime08}"></c:set>
			            <c:set var="cntTime07_15" value="${vo2.cntTime07}"></c:set>
			            <c:set var="cntTime06_15" value="${vo2.cntTime06}"></c:set>
			            <c:set var="cntTime05_15" value="${vo2.cntTime05}"></c:set>
			            <c:set var="cntTime04_15" value="${vo2.cntTime04}"></c:set>
			            <c:set var="cntTime03_15" value="${vo2.cntTime03}"></c:set>
			            <c:set var="cntTime02_15" value="${vo2.cntTime02}"></c:set>
			            <c:set var="cntTime01_15" value="${vo2.cntTime01}"></c:set>
			            
			            <!-- 소계 평균용 변수 -->
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
			            
			            <!-- cntTime12 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${cntTime12_15}" pattern="#,##0.##"/></td>
	                    <!-- cntTime11 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime11_15}" pattern="#,##0.##"/></td>
	                    <!-- cntTime10 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime10_15}" pattern="#,##0.##"/></td>
	                    <!-- cntTime09 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime09_15}" pattern="#,##0.##"/></td>
	                    <!-- cntTime08 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime08_15}" pattern="#,##0.##"/></td>
	                    <!-- cntTime07 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime07_15}" pattern="#,##0.##"/></td>
	                    <!-- cntTime06 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime06_15}" pattern="#,##0.##"/></td>
	                    <!-- cntTime05 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime05_15}" pattern="#,##0.##"/></td>
	                    <!-- cntTime04 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime04_15}" pattern="#,##0.##"/></td>
	                    <!-- cntTime03 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime03_15}" pattern="#,##0.##"/></td>
	                    <!-- cntTime02 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime02_15}" pattern="#,##0.##"/></td>
	                    <!-- cntTime01 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntTime01_15}" pattern="#,##0.##"/></td>
		                <!-- 가로 합계 -->
		                <c:set var="timeColSum_15" value="${time12_15 + time11_15 + time10_15 + time09_15 + time08_15 + time07_15 + time06_15 + time05_15 + time04_15 + time03_15 + time02_15 + time01_15}"></c:set>
		                <c:set var="endColSum_15" value="${end12_15 + end11_15 + end10_15 + end09_15 + end08_15 + end07_15 + end06_15 + end05_15 + end04_15 + end03_15 + end02_15 + end01_15}"></c:set>
		               	<c:choose>
		               		<c:when test="${timeColSum_15 eq 0 or endColSum_15 eq 0}">
		               			<c:set var="arvColSum_15" value="0"></c:set>
		               		</c:when>
		               		<c:otherwise>
		               			<c:set var="arvColSum_15" value="${timeColSum_15 / endColSum_15}"></c:set>
		               		</c:otherwise>
		               	</c:choose>
		               	<td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvColSum_15}" pattern="#,##0.##"/></td>		                
		                
		                <!-- 센터별 계 합산 -->
	    				<c:set var="cntTimeCenterSum_12_15" value="${cntTimeCenterSum_12_15+cntTime12_15}"></c:set>
			            <c:set var="cntTimeCenterSum_11_15" value="${cntTimeCenterSum_11_15+cntTime11_15}"></c:set>
			            <c:set var="cntTimeCenterSum_10_15" value="${cntTimeCenterSum_10_15+cntTime10_15}"></c:set>
			            <c:set var="cntTimeCenterSum_09_15" value="${cntTimeCenterSum_09_15+cntTime09_15}"></c:set>
			            <c:set var="cntTimeCenterSum_08_15" value="${cntTimeCenterSum_08_15+cntTime08_15}"></c:set>
			            <c:set var="cntTimeCenterSum_07_15" value="${cntTimeCenterSum_07_15+cntTime07_15}"></c:set>
			            <c:set var="cntTimeCenterSum_06_15" value="${cntTimeCenterSum_06_15+cntTime06_15}"></c:set>
			            <c:set var="cntTimeCenterSum_05_15" value="${cntTimeCenterSum_05_15+cntTime05_15}"></c:set>
			            <c:set var="cntTimeCenterSum_04_15" value="${cntTimeCenterSum_04_15+cntTime04_15}"></c:set>
			            <c:set var="cntTimeCenterSum_03_15" value="${cntTimeCenterSum_03_15+cntTime03_15}"></c:set>
			            <c:set var="cntTimeCenterSum_02_15" value="${cntTimeCenterSum_02_15+cntTime02_15}"></c:set>
			            <c:set var="cntTimeCenterSum_01_15" value="${cntTimeCenterSum_01_15+cntTime01_15}"></c:set>
			            
			            <!-- 센터별 계 평균용 변수 -->
						<c:set var="timeCenterSum_12_15" value="${timeCenterSum_12_15+time12_15}"></c:set>
			            <c:set var="timeCenterSum_11_15" value="${timeCenterSum_11_15+time11_15}"></c:set>
			            <c:set var="timeCenterSum_10_15" value="${timeCenterSum_10_15+time10_15}"></c:set>
			            <c:set var="timeCenterSum_09_15" value="${timeCenterSum_09_15+time09_15}"></c:set>
			            <c:set var="timeCenterSum_08_15" value="${timeCenterSum_08_15+time08_15}"></c:set>
			            <c:set var="timeCenterSum_07_15" value="${timeCenterSum_07_15+time07_15}"></c:set>
			            <c:set var="timeCenterSum_06_15" value="${timeCenterSum_06_15+time06_15}"></c:set>
			            <c:set var="timeCenterSum_05_15" value="${timeCenterSum_05_15+time05_15}"></c:set>
			            <c:set var="timeCenterSum_04_15" value="${timeCenterSum_04_15+time04_15}"></c:set>
			            <c:set var="timeCenterSum_03_15" value="${timeCenterSum_03_15+time03_15}"></c:set>
			            <c:set var="timeCenterSum_02_15" value="${timeCenterSum_02_15+time02_15}"></c:set>
			            <c:set var="timeCenterSum_01_15" value="${timeCenterSum_01_15+time01_15}"></c:set>
				    
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
	                    <c:set var="cntTimeCenterTotalSum_12_15" value="${cntTimeCenterTotalSum_12_15 + cntTime12_15}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_11_15" value="${cntTimeCenterTotalSum_11_15 + cntTime11_15}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_10_15" value="${cntTimeCenterTotalSum_10_15 + cntTime10_15}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_09_15" value="${cntTimeCenterTotalSum_09_15 + cntTime09_15}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_08_15" value="${cntTimeCenterTotalSum_08_15 + cntTime08_15}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_07_15" value="${cntTimeCenterTotalSum_07_15 + cntTime07_15}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_06_15" value="${cntTimeCenterTotalSum_06_15 + cntTime06_15}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_05_15" value="${cntTimeCenterTotalSum_05_15 + cntTime05_15}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_04_15" value="${cntTimeCenterTotalSum_04_15 + cntTime04_15}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_03_15" value="${cntTimeCenterTotalSum_03_15 + cntTime03_15}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_02_15" value="${cntTimeCenterTotalSum_02_15 + cntTime02_15}"></c:set>
	                    <c:set var="cntTimeCenterTotalSum_01_15" value="${cntTimeCenterTotalSum_01_15 + cntTime01_15}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="timeCenterTotalSum_12_15" value="${timeCenterTotalSum_12_15 + time12_15}"></c:set>
	                    <c:set var="timeCenterTotalSum_11_15" value="${timeCenterTotalSum_11_15 + time11_15}"></c:set>
	                    <c:set var="timeCenterTotalSum_10_15" value="${timeCenterTotalSum_10_15 + time10_15}"></c:set>
	                    <c:set var="timeCenterTotalSum_09_15" value="${timeCenterTotalSum_09_15 + time09_15}"></c:set>
	                    <c:set var="timeCenterTotalSum_08_15" value="${timeCenterTotalSum_08_15 + time08_15}"></c:set>
	                    <c:set var="timeCenterTotalSum_07_15" value="${timeCenterTotalSum_07_15 + time07_15}"></c:set>
	                    <c:set var="timeCenterTotalSum_06_15" value="${timeCenterTotalSum_06_15 + time06_15}"></c:set>
	                    <c:set var="timeCenterTotalSum_05_15" value="${timeCenterTotalSum_05_15 + time05_15}"></c:set>
	                    <c:set var="timeCenterTotalSum_04_15" value="${timeCenterTotalSum_04_15 + time04_15}"></c:set>
	                    <c:set var="timeCenterTotalSum_03_15" value="${timeCenterTotalSum_03_15 + time03_15}"></c:set>
	                    <c:set var="timeCenterTotalSum_02_15" value="${timeCenterTotalSum_02_15 + time02_15}"></c:set>
	                    <c:set var="timeCenterTotalSum_01_15" value="${timeCenterTotalSum_01_15 + time01_15}"></c:set>

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
		    		
		    		<!-- 센터별 평균 계산 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${centerCnt == vo2.rowCnt and vo2.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">${vo2.centerName} 평균</td>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_12_15 eq 0 or endCenterSum_12_15 eq 0}">
		    						<c:set var="arvCenterSum_12_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_12_15" value="${timeCenterSum_12_15 / endCenterSum_12_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_11_15 eq 0 or endCenterSum_11_15 eq 0}">
		    						<c:set var="arvCenterSum_11_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_11_15" value="${timeCenterSum_11_15 / endCenterSum_11_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_10_15 eq 0 or endCenterSum_10_15 eq 0}">
		    						<c:set var="arvCenterSum_10_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_10_15" value="${timeCenterSum_10_15 / endCenterSum_10_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_09_15 eq 0 or endCenterSum_09_15 eq 0}">
		    						<c:set var="arvCenterSum_09_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_09_15" value="${timeCenterSum_09_15 / endCenterSum_09_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_08_15 eq 0 or endCenterSum_08_15 eq 0}">
		    						<c:set var="arvCenterSum_08_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_08_15" value="${timeCenterSum_08_15 / endCenterSum_08_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_07_15 eq 0 or endCenterSum_07_15 eq 0}">
		    						<c:set var="arvCenterSum_07_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_07_15" value="${timeCenterSum_07_15 / endCenterSum_07_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_06_15 eq 0 or endCenterSum_06_15 eq 0}">
		    						<c:set var="arvCenterSum_06_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_06_15" value="${timeCenterSum_06_15 / endCenterSum_06_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_05_15 eq 0 or endCenterSum_05_15 eq 0}">
		    						<c:set var="arvCenterSum_05_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_05_15" value="${timeCenterSum_05_15 / endCenterSum_05_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_04_15 eq 0 or endCenterSum_04_15 eq 0}">
		    						<c:set var="arvCenterSum_04_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_04_15" value="${timeCenterSum_04_15 / endCenterSum_04_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_03_15 eq 0 or endCenterSum_03_15 eq 0}">
		    						<c:set var="arvCenterSum_03_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_03_15" value="${timeCenterSum_03_15 / endCenterSum_03_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_02_15 eq 0 or endCenterSum_02_15 eq 0}">
		    						<c:set var="arvCenterSum_02_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_02_15" value="${timeCenterSum_02_15 / endCenterSum_02_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeCenterSum_01_15 eq 0 or endCenterSum_01_15 eq 0}">
		    						<c:set var="arvCenterSum_01_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_01_15" value="${timeCenterSum_01_15 / endCenterSum_01_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 센터별 평균 계산 끝 -->
		    						    				
		    				<!-- cntTime12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_12_15}" pattern="#,##0.##"/></td>
		    				<!-- cntTime11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_11_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_10_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_09_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_08_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_07_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_06_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_05_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_04_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_03_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_02_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_01_15}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="timeCenterColSum_15" value="${timeCenterSum_12_15 + timeCenterSum_11_15 + timeCenterSum_10_15 + timeCenterSum_09_15 + timeCenterSum_08_15 + timeCenterSum_07_15 + timeCenterSum_06_15 + timeCenterSum_05_15 + timeCenterSum_04_15 + timeCenterSum_03_15 + timeCenterSum_02_15 + timeCenterSum_01_15}"></c:set>
			                <c:set var="endCenterColSum_15" value="${endCenterSum_12_15 + endCenterSum_11_15 + endCenterSum_10_15 + endCenterSum_09_15 + endCenterSum_08_15 + endCenterSum_07_15 + endCenterSum_06_15 + endCenterSum_05_15 + endCenterSum_04_15 + endCenterSum_03_15 + endCenterSum_02_15 + endCenterSum_01_15}"></c:set>			                
			                <c:choose>
			                	<c:when test="${timeCenterColSum_15 eq 0 or endCenterColSum_15 eq 0}">
			                		<c:set var="arvCenterColSum_15" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvCenterColSum_15" value="${timeCenterColSum_15 / endCenterColSum_15}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterColSum_15}" pattern="#,##0.##"/></td>
		    				
							<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>										                		    				
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="cntTimeCenterSum_12_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_11_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_10_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_09_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_08_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_07_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_06_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_05_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_04_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_03_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_02_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_01_15" value="0"></c:set>
				            
				            <!-- 센터별 평균 계 초기화 -->
							<c:set var="timeCenterSum_12_15" value="0"></c:set>
							<c:set var="timeCenterSum_11_15" value="0"></c:set>
							<c:set var="timeCenterSum_10_15" value="0"></c:set>
							<c:set var="timeCenterSum_09_15" value="0"></c:set>
							<c:set var="timeCenterSum_08_15" value="0"></c:set>
							<c:set var="timeCenterSum_07_15" value="0"></c:set>
							<c:set var="timeCenterSum_06_15" value="0"></c:set>
							<c:set var="timeCenterSum_05_15" value="0"></c:set>
							<c:set var="timeCenterSum_04_15" value="0"></c:set>
							<c:set var="timeCenterSum_03_15" value="0"></c:set>
							<c:set var="timeCenterSum_02_15" value="0"></c:set>
							<c:set var="timeCenterSum_01_15" value="0"></c:set>
											    
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
				            <c:set var="cntTimeCenterSum_12_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_11_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_10_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_09_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_08_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_07_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_06_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_05_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_04_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_03_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_02_15" value="0"></c:set>
				            <c:set var="cntTimeCenterSum_01_15" value="0"></c:set>
				            
				            <!-- 센터별 평균 계 초기화 -->
							<c:set var="timeCenterSum_12_15" value="0"></c:set>
							<c:set var="timeCenterSum_11_15" value="0"></c:set>
							<c:set var="timeCenterSum_10_15" value="0"></c:set>
							<c:set var="timeCenterSum_09_15" value="0"></c:set>
							<c:set var="timeCenterSum_08_15" value="0"></c:set>
							<c:set var="timeCenterSum_07_15" value="0"></c:set>
							<c:set var="timeCenterSum_06_15" value="0"></c:set>
							<c:set var="timeCenterSum_05_15" value="0"></c:set>
							<c:set var="timeCenterSum_04_15" value="0"></c:set>
							<c:set var="timeCenterSum_03_15" value="0"></c:set>
							<c:set var="timeCenterSum_02_15" value="0"></c:set>
							<c:set var="timeCenterSum_01_15" value="0"></c:set>
											    
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
		    	<c:if test="${ptnrStatCntTimeList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 기타 평균</th>
	                <c:choose>
    					<c:when test="${timeCenterTotalSum_12_15 eq 0 or endCenterTotalSum_12_15 eq 0}">
    						<c:set var="arvCenterTotalSum_12_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_12_15" value="${timeCenterTotalSum_12_15 / endCenterTotalSum_12_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_11_15 eq 0 or endCenterTotalSum_11_15 eq 0}">
    						<c:set var="arvCenterTotalSum_11_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_11_15" value="${timeCenterTotalSum_11_15 / endCenterTotalSum_11_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_10_15 eq 0 or endCenterTotalSum_10_15 eq 0}">
    						<c:set var="arvCenterTotalSum_10_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_10_15" value="${timeCenterTotalSum_10_15 / endCenterTotalSum_10_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_09_15 eq 0 or endCenterTotalSum_09_15 eq 0}">
    						<c:set var="arvCenterTotalSum_09_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_09_15" value="${timeCenterTotalSum_09_15 / endCenterTotalSum_09_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_08_15 eq 0 or endCenterTotalSum_08_15 eq 0}">
    						<c:set var="arvCenterTotalSum_08_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_08_15" value="${timeCenterTotalSum_08_15 / endCenterTotalSum_08_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_07_15 eq 0 or endCenterTotalSum_07_15 eq 0}">
    						<c:set var="arvCenterTotalSum_07_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_07_15" value="${timeCenterTotalSum_07_15 / endCenterTotalSum_07_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_06_15 eq 0 or endCenterTotalSum_06_15 eq 0}">
    						<c:set var="arvCenterTotalSum_06_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_06_15" value="${timeCenterTotalSum_06_15 / endCenterTotalSum_06_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_05_15 eq 0 or endCenterTotalSum_05_15 eq 0}">
    						<c:set var="arvCenterTotalSum_05_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_05_15" value="${timeCenterTotalSum_05_15 / endCenterTotalSum_05_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_04_15 eq 0 or endCenterTotalSum_04_15 eq 0}">
    						<c:set var="arvCenterTotalSum_04_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_04_15" value="${timeCenterTotalSum_04_15 / endCenterTotalSum_04_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_03_15 eq 0 or endCenterTotalSum_03_15 eq 0}">
    						<c:set var="arvCenterTotalSum_03_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_03_15" value="${timeCenterTotalSum_03_15 / endCenterTotalSum_03_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_02_15 eq 0 or endCenterTotalSum_02_15 eq 0}">
    						<c:set var="arvCenterTotalSum_02_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_02_15" value="${timeCenterTotalSum_02_15 / endCenterTotalSum_02_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeCenterTotalSum_01_15 eq 0 or endCenterTotalSum_01_15 eq 0}">
    						<c:set var="arvCenterTotalSum_01_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_01_15" value="${timeCenterTotalSum_01_15 / endCenterTotalSum_01_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 센터별 평균 계산 끝 -->
    						    				
    				<!-- cntTime12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_12_15}" pattern="#,##0.##"/></th>
    				<!-- cntTime11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_11_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_10_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_09_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_08_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_07_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_06_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_05_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_04_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_03_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_02_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_01_15}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="timeColCenterTotalSum_15" value="${timeCenterTotalSum_12_15 + timeCenterTotalSum_11_15 + timeCenterTotalSum_10_15 + timeCenterTotalSum_09_15 + timeCenterTotalSum_08_15 + timeCenterTotalSum_07_15 + timeCenterTotalSum_06_15 + timeCenterTotalSum_05_15 + timeCenterTotalSum_04_15 + timeCenterTotalSum_03_15 + timeCenterTotalSum_02_15 + timeCenterTotalSum_01_15}"></c:set>
	                <c:set var="endColCenterTotalSum_15" value="${endCenterTotalSum_12_15 + endCenterTotalSum_11_15 + endCenterTotalSum_10_15 + endCenterTotalSum_09_15 + endCenterTotalSum_08_15 + endCenterTotalSum_07_15 + endCenterTotalSum_06_15 + endCenterTotalSum_05_15 + endCenterTotalSum_04_15 + endCenterTotalSum_03_15 + endCenterTotalSum_02_15 + endCenterTotalSum_01_15}"></c:set>
					<c:choose>
	                	<c:when test="${timeColCenterTotalSum_15 eq 0 or endColCenterTotalSum_15 eq 0}">
	                		<c:set var="arvColCenterTotalSum_15" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColCenterTotalSum_15" value="${timeColCenterTotalSum_15 / endColCenterTotalSum_15}"/>
	                	</c:otherwise>
					</c:choose>
	                
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvColCenterTotalSum_15}" pattern="#,##0.##"/></th>
	            </tr>
	            </c:if>
		    	<!-- 1종 기타 소계 끝 -->
    		</tbody>
    	</table>
    	<!-- 1종 기타 끝 -->  	        
    </div>    
    <!-- 총 합계 시작 -->
    <!-- 총 합계 변수 시작 -->
    <c:set var="cntTimeCenterTotalSum_12_all" value="${cntTimeCenterTotalSum_12_5 + cntTimeCenterTotalSum_12_10 + cntTimeCenterTotalSum_12_15}"></c:set>
    <c:set var="cntTimeCenterTotalSum_11_all" value="${cntTimeCenterTotalSum_11_5 + cntTimeCenterTotalSum_11_10 + cntTimeCenterTotalSum_11_15}"></c:set>
    <c:set var="cntTimeCenterTotalSum_10_all" value="${cntTimeCenterTotalSum_10_5 + cntTimeCenterTotalSum_10_10 + cntTimeCenterTotalSum_10_15}"></c:set>
    <c:set var="cntTimeCenterTotalSum_09_all" value="${cntTimeCenterTotalSum_09_5 + cntTimeCenterTotalSum_09_10 + cntTimeCenterTotalSum_09_15}"></c:set>
    <c:set var="cntTimeCenterTotalSum_08_all" value="${cntTimeCenterTotalSum_08_5 + cntTimeCenterTotalSum_08_10 + cntTimeCenterTotalSum_08_15}"></c:set>
    <c:set var="cntTimeCenterTotalSum_07_all" value="${cntTimeCenterTotalSum_07_5 + cntTimeCenterTotalSum_07_10 + cntTimeCenterTotalSum_07_15}"></c:set>
    <c:set var="cntTimeCenterTotalSum_06_all" value="${cntTimeCenterTotalSum_06_5 + cntTimeCenterTotalSum_06_10 + cntTimeCenterTotalSum_06_15}"></c:set>
    <c:set var="cntTimeCenterTotalSum_05_all" value="${cntTimeCenterTotalSum_05_5 + cntTimeCenterTotalSum_05_10 + cntTimeCenterTotalSum_05_15}"></c:set>
    <c:set var="cntTimeCenterTotalSum_04_all" value="${cntTimeCenterTotalSum_04_5 + cntTimeCenterTotalSum_04_10 + cntTimeCenterTotalSum_04_15}"></c:set>
    <c:set var="cntTimeCenterTotalSum_03_all" value="${cntTimeCenterTotalSum_03_5 + cntTimeCenterTotalSum_03_10 + cntTimeCenterTotalSum_03_15}"></c:set>
    <c:set var="cntTimeCenterTotalSum_02_all" value="${cntTimeCenterTotalSum_02_5 + cntTimeCenterTotalSum_02_10 + cntTimeCenterTotalSum_02_15}"></c:set>
    <c:set var="cntTimeCenterTotalSum_01_all" value="${cntTimeCenterTotalSum_01_5 + cntTimeCenterTotalSum_01_10 + cntTimeCenterTotalSum_01_15}"></c:set>        
    <c:set var="cntTimeCenterTotalSum_col_all" value="${cntTimeCenterTotalSum_12_all + cntTimeCenterTotalSum_11_all + cntTimeCenterTotalSum_10_all + cntTimeCenterTotalSum_09_all + cntTimeCenterTotalSum_08_all + cntTimeCenterTotalSum_07_all + cntTimeCenterTotalSum_06_all + cntTimeCenterTotalSum_05_all + cntTimeCenterTotalSum_04_all + cntTimeCenterTotalSum_03_all + cntTimeCenterTotalSum_02_all + cntTimeCenterTotalSum_01_all}"></c:set>
    
    <c:set var="timeCenterTotalSum_12_all" value="${timeCenterTotalSum_12_5 + timeCenterTotalSum_12_10 + timeCenterTotalSum_12_15}"></c:set>
    <c:set var="timeCenterTotalSum_11_all" value="${timeCenterTotalSum_11_5 + timeCenterTotalSum_11_10 + timeCenterTotalSum_11_15}"></c:set>
    <c:set var="timeCenterTotalSum_10_all" value="${timeCenterTotalSum_10_5 + timeCenterTotalSum_10_10 + timeCenterTotalSum_10_15}"></c:set>
    <c:set var="timeCenterTotalSum_09_all" value="${timeCenterTotalSum_09_5 + timeCenterTotalSum_09_10 + timeCenterTotalSum_09_15}"></c:set>
    <c:set var="timeCenterTotalSum_08_all" value="${timeCenterTotalSum_08_5 + timeCenterTotalSum_08_10 + timeCenterTotalSum_08_15}"></c:set>
    <c:set var="timeCenterTotalSum_07_all" value="${timeCenterTotalSum_07_5 + timeCenterTotalSum_07_10 + timeCenterTotalSum_07_15}"></c:set>
    <c:set var="timeCenterTotalSum_06_all" value="${timeCenterTotalSum_06_5 + timeCenterTotalSum_06_10 + timeCenterTotalSum_06_15}"></c:set>
    <c:set var="timeCenterTotalSum_05_all" value="${timeCenterTotalSum_05_5 + timeCenterTotalSum_05_10 + timeCenterTotalSum_05_15}"></c:set>
    <c:set var="timeCenterTotalSum_04_all" value="${timeCenterTotalSum_04_5 + timeCenterTotalSum_04_10 + timeCenterTotalSum_04_15}"></c:set>
    <c:set var="timeCenterTotalSum_03_all" value="${timeCenterTotalSum_03_5 + timeCenterTotalSum_03_10 + timeCenterTotalSum_03_15}"></c:set>
    <c:set var="timeCenterTotalSum_02_all" value="${timeCenterTotalSum_02_5 + timeCenterTotalSum_02_10 + timeCenterTotalSum_02_15}"></c:set>
    <c:set var="timeCenterTotalSum_01_all" value="${timeCenterTotalSum_01_5 + timeCenterTotalSum_01_10 + timeCenterTotalSum_01_15}"></c:set>
    
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
    
    <c:choose>
		<c:when test="${timeCenterTotalSum_12_all eq 0 or endCenterTotalSum_12_all eq 0}">
			<c:set var="arvCenterTotalSum_12_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_12_all" value="${timeCenterTotalSum_12_all / endCenterTotalSum_12_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeCenterTotalSum_11_all eq 0 or endCenterTotalSum_11_all eq 0}">
			<c:set var="arvCenterTotalSum_11_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_11_all" value="${timeCenterTotalSum_11_all / endCenterTotalSum_11_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeCenterTotalSum_10_all eq 0 or endCenterTotalSum_10_all eq 0}">
			<c:set var="arvCenterTotalSum_10_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_10_all" value="${timeCenterTotalSum_10_all / endCenterTotalSum_10_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeCenterTotalSum_09_all eq 0 or endCenterTotalSum_09_all eq 0}">
			<c:set var="arvCenterTotalSum_09_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_09_all" value="${timeCenterTotalSum_09_all / endCenterTotalSum_09_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeCenterTotalSum_08_all eq 0 or endCenterTotalSum_08_all eq 0}">
			<c:set var="arvCenterTotalSum_08_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_08_all" value="${timeCenterTotalSum_08_all / endCenterTotalSum_08_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeCenterTotalSum_07_all eq 0 or endCenterTotalSum_07_all eq 0}">
			<c:set var="arvCenterTotalSum_07_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_07_all" value="${timeCenterTotalSum_07_all / endCenterTotalSum_07_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeCenterTotalSum_06_all eq 0 or endCenterTotalSum_06_all eq 0}">
			<c:set var="arvCenterTotalSum_06_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_06_all" value="${timeCenterTotalSum_06_all / endCenterTotalSum_06_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeCenterTotalSum_05_all eq 0 or endCenterTotalSum_05_all eq 0}">
			<c:set var="arvCenterTotalSum_05_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_05_all" value="${timeCenterTotalSum_05_all / endCenterTotalSum_05_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeCenterTotalSum_04_all eq 0 or endCenterTotalSum_04_all eq 0}">
			<c:set var="arvCenterTotalSum_04_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_04_all" value="${timeCenterTotalSum_04_all / endCenterTotalSum_04_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeCenterTotalSum_03_all eq 0 or endCenterTotalSum_03_all eq 0}">
			<c:set var="arvCenterTotalSum_03_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_03_all" value="${timeCenterTotalSum_03_all / endCenterTotalSum_03_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeCenterTotalSum_02_all eq 0 or endCenterTotalSum_02_all eq 0}">
			<c:set var="arvCenterTotalSum_02_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_02_all" value="${timeCenterTotalSum_02_all / endCenterTotalSum_02_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeCenterTotalSum_01_all eq 0 or endCenterTotalSum_01_all eq 0}">
			<c:set var="arvCenterTotalSum_01_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_01_all" value="${timeCenterTotalSum_01_all / endCenterTotalSum_01_all}"></c:set>
		</c:otherwise>
	</c:choose>
	
	<!-- 가로 합계 -->
	<c:set var="timeColCenterTotalSum_all" value="${timeCenterTotalSum_12_all + timeCenterTotalSum_11_all + timeCenterTotalSum_10_all + timeCenterTotalSum_09_all + timeCenterTotalSum_08_all + timeCenterTotalSum_07_all + timeCenterTotalSum_06_all + timeCenterTotalSum_05_all + timeCenterTotalSum_04_all + timeCenterTotalSum_03_all + timeCenterTotalSum_02_all + timeCenterTotalSum_01_all}"></c:set>
	<c:set var="endColCenterTotalSum_all" value="${endCenterTotalSum_12_all + endCenterTotalSum_11_all + endCenterTotalSum_10_all + endCenterTotalSum_09_all + endCenterTotalSum_08_all + endCenterTotalSum_07_all + endCenterTotalSum_06_all + endCenterTotalSum_05_all + endCenterTotalSum_04_all + endCenterTotalSum_03_all + endCenterTotalSum_02_all + endCenterTotalSum_01_all}"></c:set>
	<c:choose>
		<c:when test="${timeColCenterTotalSum_all eq 0 or endColCenterTotalSum_all eq 0}">
			<c:set var="arvColCenterTotalSum_all" value="0"/>
		</c:when>
		<c:otherwise>
			<c:set var="arvColCenterTotalSum_all" value="${timeColCenterTotalSum_all / endColCenterTotalSum_all}"/>
		</c:otherwise>
	</c:choose>
	    
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px; background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체평균</th>    			    			
    			<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvCenterTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvCenterTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvCenterTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvCenterTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvCenterTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvCenterTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvCenterTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvCenterTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvCenterTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvCenterTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvCenterTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvCenterTotalSum_01_all}" pattern="#,##0.##"/></th>				    			
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvColCenterTotalSum_all}" pattern="#,##0.##"/></th>
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>