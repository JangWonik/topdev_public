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
                <th style="width: 80px;">가로열 평균</th>
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
	            <c:set var="cntTimeTeamSum_12_5" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_11_5" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_10_5" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_09_5" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_08_5" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_07_5" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_06_5" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_05_5" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_04_5" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_03_5" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_02_5" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_01_5" value="0"></c:set>
	            
	            <!-- 팀별 평균 계 초기화 -->
				<c:set var="timeTeamSum_12_5" value="0"></c:set>
				<c:set var="timeTeamSum_11_5" value="0"></c:set>
				<c:set var="timeTeamSum_10_5" value="0"></c:set>
				<c:set var="timeTeamSum_09_5" value="0"></c:set>
				<c:set var="timeTeamSum_08_5" value="0"></c:set>
				<c:set var="timeTeamSum_07_5" value="0"></c:set>
				<c:set var="timeTeamSum_06_5" value="0"></c:set>
				<c:set var="timeTeamSum_05_5" value="0"></c:set>
				<c:set var="timeTeamSum_04_5" value="0"></c:set>
				<c:set var="timeTeamSum_03_5" value="0"></c:set>
				<c:set var="timeTeamSum_02_5" value="0"></c:set>
				<c:set var="timeTeamSum_01_5" value="0"></c:set>
								    
				<c:set var="endTeamSum_12_5" value="0"></c:set>
				<c:set var="endTeamSum_11_5" value="0"></c:set>
				<c:set var="endTeamSum_10_5" value="0"></c:set>
				<c:set var="endTeamSum_09_5" value="0"></c:set>
				<c:set var="endTeamSum_08_5" value="0"></c:set>
				<c:set var="endTeamSum_07_5" value="0"></c:set>
				<c:set var="endTeamSum_06_5" value="0"></c:set>
				<c:set var="endTeamSum_05_5" value="0"></c:set>
				<c:set var="endTeamSum_04_5" value="0"></c:set>
				<c:set var="endTeamSum_03_5" value="0"></c:set>
				<c:set var="endTeamSum_02_5" value="0"></c:set>
				<c:set var="endTeamSum_01_5" value="0"></c:set>
				
	            <!-- Type 별 총 합계 -->
	            <c:set var="cntTimeTeamTotalSum_12_5" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_11_5" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_10_5" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_09_5" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_08_5" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_07_5" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_06_5" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_05_5" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_04_5" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_03_5" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_02_5" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_01_5" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntTimeColTeamTotalSum_5" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="timeTeamTotalSum_12_5" value="0"></c:set>
				<c:set var="timeTeamTotalSum_11_5" value="0"></c:set>
				<c:set var="timeTeamTotalSum_10_5" value="0"></c:set>
				<c:set var="timeTeamTotalSum_09_5" value="0"></c:set>
				<c:set var="timeTeamTotalSum_08_5" value="0"></c:set>
				<c:set var="timeTeamTotalSum_07_5" value="0"></c:set>
				<c:set var="timeTeamTotalSum_06_5" value="0"></c:set>
				<c:set var="timeTeamTotalSum_05_5" value="0"></c:set>
				<c:set var="timeTeamTotalSum_04_5" value="0"></c:set>
				<c:set var="timeTeamTotalSum_03_5" value="0"></c:set>
				<c:set var="timeTeamTotalSum_02_5" value="0"></c:set>
				<c:set var="timeTeamTotalSum_01_5" value="0"></c:set>
				
				<c:set var="endTeamTotalSum_12_5" value="0"></c:set>
				<c:set var="endTeamTotalSum_11_5" value="0"></c:set>
				<c:set var="endTeamTotalSum_10_5" value="0"></c:set>
				<c:set var="endTeamTotalSum_09_5" value="0"></c:set>
				<c:set var="endTeamTotalSum_08_5" value="0"></c:set>
				<c:set var="endTeamTotalSum_07_5" value="0"></c:set>
				<c:set var="endTeamTotalSum_06_5" value="0"></c:set>
				<c:set var="endTeamTotalSum_05_5" value="0"></c:set>
				<c:set var="endTeamTotalSum_04_5" value="0"></c:set>
				<c:set var="endTeamTotalSum_03_5" value="0"></c:set>
				<c:set var="endTeamTotalSum_02_5" value="0"></c:set>
				<c:set var="endTeamTotalSum_01_5" value="0"></c:set>	            
   				    			
    			<c:forEach var="vo" items="${ptnrStatCntTimeList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCenterCntTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
		                    	1종 조사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatMember(${vo.ptnrId},${vo.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.teamName}</td>
		                		<td style="width:150px;">${vo.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="cntTimeTeamSum_12_5" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_11_5" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_10_5" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_09_5" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_08_5" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_07_5" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_06_5" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_05_5" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_04_5" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_03_5" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_02_5" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_01_5" value="0"></c:set>
					            
					            <!-- 팀별 평균 계 초기화 -->
								<c:set var="timeTeamSum_12_5" value="0"></c:set>
								<c:set var="timeTeamSum_11_5" value="0"></c:set>
								<c:set var="timeTeamSum_10_5" value="0"></c:set>
								<c:set var="timeTeamSum_09_5" value="0"></c:set>
								<c:set var="timeTeamSum_08_5" value="0"></c:set>
								<c:set var="timeTeamSum_07_5" value="0"></c:set>
								<c:set var="timeTeamSum_06_5" value="0"></c:set>
								<c:set var="timeTeamSum_05_5" value="0"></c:set>
								<c:set var="timeTeamSum_04_5" value="0"></c:set>
								<c:set var="timeTeamSum_03_5" value="0"></c:set>
								<c:set var="timeTeamSum_02_5" value="0"></c:set>
								<c:set var="timeTeamSum_01_5" value="0"></c:set>
												    
								<c:set var="endTeamSum_12_5" value="0"></c:set>
								<c:set var="endTeamSum_11_5" value="0"></c:set>
								<c:set var="endTeamSum_10_5" value="0"></c:set>
								<c:set var="endTeamSum_09_5" value="0"></c:set>
								<c:set var="endTeamSum_08_5" value="0"></c:set>
								<c:set var="endTeamSum_07_5" value="0"></c:set>
								<c:set var="endTeamSum_06_5" value="0"></c:set>
								<c:set var="endTeamSum_05_5" value="0"></c:set>
								<c:set var="endTeamSum_04_5" value="0"></c:set>
								<c:set var="endTeamSum_03_5" value="0"></c:set>
								<c:set var="endTeamSum_02_5" value="0"></c:set>
								<c:set var="endTeamSum_01_5" value="0"></c:set>
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
		                
		                <!-- 팀별 계 합산 -->
	    				<c:set var="cntTimeTeamSum_12_5" value="${cntTimeTeamSum_12_5+cntTime12_5}"></c:set>
			            <c:set var="cntTimeTeamSum_11_5" value="${cntTimeTeamSum_11_5+cntTime11_5}"></c:set>
			            <c:set var="cntTimeTeamSum_10_5" value="${cntTimeTeamSum_10_5+cntTime10_5}"></c:set>
			            <c:set var="cntTimeTeamSum_09_5" value="${cntTimeTeamSum_09_5+cntTime09_5}"></c:set>
			            <c:set var="cntTimeTeamSum_08_5" value="${cntTimeTeamSum_08_5+cntTime08_5}"></c:set>
			            <c:set var="cntTimeTeamSum_07_5" value="${cntTimeTeamSum_07_5+cntTime07_5}"></c:set>
			            <c:set var="cntTimeTeamSum_06_5" value="${cntTimeTeamSum_06_5+cntTime06_5}"></c:set>
			            <c:set var="cntTimeTeamSum_05_5" value="${cntTimeTeamSum_05_5+cntTime05_5}"></c:set>
			            <c:set var="cntTimeTeamSum_04_5" value="${cntTimeTeamSum_04_5+cntTime04_5}"></c:set>
			            <c:set var="cntTimeTeamSum_03_5" value="${cntTimeTeamSum_03_5+cntTime03_5}"></c:set>
			            <c:set var="cntTimeTeamSum_02_5" value="${cntTimeTeamSum_02_5+cntTime02_5}"></c:set>
			            <c:set var="cntTimeTeamSum_01_5" value="${cntTimeTeamSum_01_5+cntTime01_5}"></c:set>
			            
			            <!-- 팀별 계 평균용 변수 -->
						<c:set var="timeTeamSum_12_5" value="${timeTeamSum_12_5+time12_5}"></c:set>
			            <c:set var="timeTeamSum_11_5" value="${timeTeamSum_11_5+time11_5}"></c:set>
			            <c:set var="timeTeamSum_10_5" value="${timeTeamSum_10_5+time10_5}"></c:set>
			            <c:set var="timeTeamSum_09_5" value="${timeTeamSum_09_5+time09_5}"></c:set>
			            <c:set var="timeTeamSum_08_5" value="${timeTeamSum_08_5+time08_5}"></c:set>
			            <c:set var="timeTeamSum_07_5" value="${timeTeamSum_07_5+time07_5}"></c:set>
			            <c:set var="timeTeamSum_06_5" value="${timeTeamSum_06_5+time06_5}"></c:set>
			            <c:set var="timeTeamSum_05_5" value="${timeTeamSum_05_5+time05_5}"></c:set>
			            <c:set var="timeTeamSum_04_5" value="${timeTeamSum_04_5+time04_5}"></c:set>
			            <c:set var="timeTeamSum_03_5" value="${timeTeamSum_03_5+time03_5}"></c:set>
			            <c:set var="timeTeamSum_02_5" value="${timeTeamSum_02_5+time02_5}"></c:set>
			            <c:set var="timeTeamSum_01_5" value="${timeTeamSum_01_5+time01_5}"></c:set>
				    
						<c:set var="endTeamSum_12_5" value="${endTeamSum_12_5+end12_5}"></c:set>
			            <c:set var="endTeamSum_11_5" value="${endTeamSum_11_5+end11_5}"></c:set>
			            <c:set var="endTeamSum_10_5" value="${endTeamSum_10_5+end10_5}"></c:set>
			            <c:set var="endTeamSum_09_5" value="${endTeamSum_09_5+end09_5}"></c:set>
			            <c:set var="endTeamSum_08_5" value="${endTeamSum_08_5+end08_5}"></c:set>
			            <c:set var="endTeamSum_07_5" value="${endTeamSum_07_5+end07_5}"></c:set>
			            <c:set var="endTeamSum_06_5" value="${endTeamSum_06_5+end06_5}"></c:set>
			            <c:set var="endTeamSum_05_5" value="${endTeamSum_05_5+end05_5}"></c:set>
			            <c:set var="endTeamSum_04_5" value="${endTeamSum_04_5+end04_5}"></c:set>
			            <c:set var="endTeamSum_03_5" value="${endTeamSum_03_5+end03_5}"></c:set>
			            <c:set var="endTeamSum_02_5" value="${endTeamSum_02_5+end02_5}"></c:set>
			            <c:set var="endTeamSum_01_5" value="${endTeamSum_01_5+end01_5}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="cntTimeTeamTotalSum_12_5" value="${cntTimeTeamTotalSum_12_5 + cntTime12_5}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_11_5" value="${cntTimeTeamTotalSum_11_5 + cntTime11_5}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_10_5" value="${cntTimeTeamTotalSum_10_5 + cntTime10_5}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_09_5" value="${cntTimeTeamTotalSum_09_5 + cntTime09_5}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_08_5" value="${cntTimeTeamTotalSum_08_5 + cntTime08_5}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_07_5" value="${cntTimeTeamTotalSum_07_5 + cntTime07_5}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_06_5" value="${cntTimeTeamTotalSum_06_5 + cntTime06_5}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_05_5" value="${cntTimeTeamTotalSum_05_5 + cntTime05_5}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_04_5" value="${cntTimeTeamTotalSum_04_5 + cntTime04_5}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_03_5" value="${cntTimeTeamTotalSum_03_5 + cntTime03_5}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_02_5" value="${cntTimeTeamTotalSum_02_5 + cntTime02_5}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_01_5" value="${cntTimeTeamTotalSum_01_5 + cntTime01_5}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="timeTeamTotalSum_12_5" value="${timeTeamTotalSum_12_5 + time12_5}"></c:set>
	                    <c:set var="timeTeamTotalSum_11_5" value="${timeTeamTotalSum_11_5 + time11_5}"></c:set>
	                    <c:set var="timeTeamTotalSum_10_5" value="${timeTeamTotalSum_10_5 + time10_5}"></c:set>
	                    <c:set var="timeTeamTotalSum_09_5" value="${timeTeamTotalSum_09_5 + time09_5}"></c:set>
	                    <c:set var="timeTeamTotalSum_08_5" value="${timeTeamTotalSum_08_5 + time08_5}"></c:set>
	                    <c:set var="timeTeamTotalSum_07_5" value="${timeTeamTotalSum_07_5 + time07_5}"></c:set>
	                    <c:set var="timeTeamTotalSum_06_5" value="${timeTeamTotalSum_06_5 + time06_5}"></c:set>
	                    <c:set var="timeTeamTotalSum_05_5" value="${timeTeamTotalSum_05_5 + time05_5}"></c:set>
	                    <c:set var="timeTeamTotalSum_04_5" value="${timeTeamTotalSum_04_5 + time04_5}"></c:set>
	                    <c:set var="timeTeamTotalSum_03_5" value="${timeTeamTotalSum_03_5 + time03_5}"></c:set>
	                    <c:set var="timeTeamTotalSum_02_5" value="${timeTeamTotalSum_02_5 + time02_5}"></c:set>
	                    <c:set var="timeTeamTotalSum_01_5" value="${timeTeamTotalSum_01_5 + time01_5}"></c:set>

						<c:set var="endTeamTotalSum_12_5" value="${endTeamTotalSum_12_5 + end12_5}"></c:set>
	                    <c:set var="endTeamTotalSum_11_5" value="${endTeamTotalSum_11_5 + end11_5}"></c:set>
	                    <c:set var="endTeamTotalSum_10_5" value="${endTeamTotalSum_10_5 + end10_5}"></c:set>
	                    <c:set var="endTeamTotalSum_09_5" value="${endTeamTotalSum_09_5 + end09_5}"></c:set>
	                    <c:set var="endTeamTotalSum_08_5" value="${endTeamTotalSum_08_5 + end08_5}"></c:set>
	                    <c:set var="endTeamTotalSum_07_5" value="${endTeamTotalSum_07_5 + end07_5}"></c:set>
	                    <c:set var="endTeamTotalSum_06_5" value="${endTeamTotalSum_06_5 + end06_5}"></c:set>
	                    <c:set var="endTeamTotalSum_05_5" value="${endTeamTotalSum_05_5 + end05_5}"></c:set>
	                    <c:set var="endTeamTotalSum_04_5" value="${endTeamTotalSum_04_5 + end04_5}"></c:set>
	                    <c:set var="endTeamTotalSum_03_5" value="${endTeamTotalSum_03_5 + end03_5}"></c:set>
	                    <c:set var="endTeamTotalSum_02_5" value="${endTeamTotalSum_02_5 + end02_5}"></c:set>
	                    <c:set var="endTeamTotalSum_01_5" value="${endTeamTotalSum_01_5 + end01_5}"></c:set>
		    		</tr>
		    		<!-- 팀별 소계 시작 -->
		    		
		    		<!-- 팀별 평균 계산 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo.rowCnt and vo.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">${vo.teamName} 평균</td>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_12_5 eq 0 or endTeamSum_12_5 eq 0}">
		    						<c:set var="arvTeamSum_12_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_12_5" value="${timeTeamSum_12_5 / endTeamSum_12_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_11_5 eq 0 or endTeamSum_11_5 eq 0}">
		    						<c:set var="arvTeamSum_11_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_11_5" value="${timeTeamSum_11_5 / endTeamSum_11_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_10_5 eq 0 or endTeamSum_10_5 eq 0}">
		    						<c:set var="arvTeamSum_10_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_10_5" value="${timeTeamSum_10_5 / endTeamSum_10_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_09_5 eq 0 or endTeamSum_09_5 eq 0}">
		    						<c:set var="arvTeamSum_09_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_09_5" value="${timeTeamSum_09_5 / endTeamSum_09_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_08_5 eq 0 or endTeamSum_08_5 eq 0}">
		    						<c:set var="arvTeamSum_08_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_08_5" value="${timeTeamSum_08_5 / endTeamSum_08_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_07_5 eq 0 or endTeamSum_07_5 eq 0}">
		    						<c:set var="arvTeamSum_07_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_07_5" value="${timeTeamSum_07_5 / endTeamSum_07_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_06_5 eq 0 or endTeamSum_06_5 eq 0}">
		    						<c:set var="arvTeamSum_06_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_06_5" value="${timeTeamSum_06_5 / endTeamSum_06_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_05_5 eq 0 or endTeamSum_05_5 eq 0}">
		    						<c:set var="arvTeamSum_05_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_05_5" value="${timeTeamSum_05_5 / endTeamSum_05_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_04_5 eq 0 or endTeamSum_04_5 eq 0}">
		    						<c:set var="arvTeamSum_04_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_04_5" value="${timeTeamSum_04_5 / endTeamSum_04_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_03_5 eq 0 or endTeamSum_03_5 eq 0}">
		    						<c:set var="arvTeamSum_03_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_03_5" value="${timeTeamSum_03_5 / endTeamSum_03_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_02_5 eq 0 or endTeamSum_02_5 eq 0}">
		    						<c:set var="arvTeamSum_02_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_02_5" value="${timeTeamSum_02_5 / endTeamSum_02_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_01_5 eq 0 or endTeamSum_01_5 eq 0}">
		    						<c:set var="arvTeamSum_01_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_01_5" value="${timeTeamSum_01_5 / endTeamSum_01_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 팀별 평균 계산 끝 -->
		    						    				
		    				<!-- cntTime12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_12_5}" pattern="#,##0.##"/></td>
		    				<!-- cntTime11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_11_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_10_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_09_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_08_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_07_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_06_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_05_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_04_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_03_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_02_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_01_5}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="timeTeamColSum_5" value="${timeTeamSum_12_5 + timeTeamSum_11_5 + timeTeamSum_10_5 + timeTeamSum_09_5 + timeTeamSum_08_5 + timeTeamSum_07_5 + timeTeamSum_06_5 + timeTeamSum_05_5 + timeTeamSum_04_5 + timeTeamSum_03_5 + timeTeamSum_02_5 + timeTeamSum_01_5}"></c:set>
			                <c:set var="endTeamColSum_5" value="${endTeamSum_12_5 + endTeamSum_11_5 + endTeamSum_10_5 + endTeamSum_09_5 + endTeamSum_08_5 + endTeamSum_07_5 + endTeamSum_06_5 + endTeamSum_05_5 + endTeamSum_04_5 + endTeamSum_03_5 + endTeamSum_02_5 + endTeamSum_01_5}"></c:set>			                
			                <c:choose>
			                	<c:when test="${timeTeamColSum_5 eq 0 or endTeamColSum_5 eq 0}">
			                		<c:set var="arvTeamColSum_5" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvTeamColSum_5" value="${timeTeamColSum_5 / endTeamColSum_5}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamColSum_5}" pattern="#,##0.##"/></td>
		    				
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="cntTimeTeamSum_12_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_11_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_10_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_09_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_08_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_07_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_06_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_05_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_04_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_03_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_02_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_01_5" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="timeTeamSum_12_5" value="0"></c:set>
							<c:set var="timeTeamSum_11_5" value="0"></c:set>
							<c:set var="timeTeamSum_10_5" value="0"></c:set>
							<c:set var="timeTeamSum_09_5" value="0"></c:set>
							<c:set var="timeTeamSum_08_5" value="0"></c:set>
							<c:set var="timeTeamSum_07_5" value="0"></c:set>
							<c:set var="timeTeamSum_06_5" value="0"></c:set>
							<c:set var="timeTeamSum_05_5" value="0"></c:set>
							<c:set var="timeTeamSum_04_5" value="0"></c:set>
							<c:set var="timeTeamSum_03_5" value="0"></c:set>
							<c:set var="timeTeamSum_02_5" value="0"></c:set>
							<c:set var="timeTeamSum_01_5" value="0"></c:set>
											    
							<c:set var="endTeamSum_12_5" value="0"></c:set>
							<c:set var="endTeamSum_11_5" value="0"></c:set>
							<c:set var="endTeamSum_10_5" value="0"></c:set>
							<c:set var="endTeamSum_09_5" value="0"></c:set>
							<c:set var="endTeamSum_08_5" value="0"></c:set>
							<c:set var="endTeamSum_07_5" value="0"></c:set>
							<c:set var="endTeamSum_06_5" value="0"></c:set>
							<c:set var="endTeamSum_05_5" value="0"></c:set>
							<c:set var="endTeamSum_04_5" value="0"></c:set>
							<c:set var="endTeamSum_03_5" value="0"></c:set>
							<c:set var="endTeamSum_02_5" value="0"></c:set>
							<c:set var="endTeamSum_01_5" value="0"></c:set>				            				            
		    			</c:when>
		    			<c:when test="${vo.rowCnt == 1}">
		    				<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="cntTimeTeamSum_12_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_11_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_10_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_09_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_08_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_07_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_06_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_05_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_04_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_03_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_02_5" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_01_5" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="timeTeamSum_12_5" value="0"></c:set>
							<c:set var="timeTeamSum_11_5" value="0"></c:set>
							<c:set var="timeTeamSum_10_5" value="0"></c:set>
							<c:set var="timeTeamSum_09_5" value="0"></c:set>
							<c:set var="timeTeamSum_08_5" value="0"></c:set>
							<c:set var="timeTeamSum_07_5" value="0"></c:set>
							<c:set var="timeTeamSum_06_5" value="0"></c:set>
							<c:set var="timeTeamSum_05_5" value="0"></c:set>
							<c:set var="timeTeamSum_04_5" value="0"></c:set>
							<c:set var="timeTeamSum_03_5" value="0"></c:set>
							<c:set var="timeTeamSum_02_5" value="0"></c:set>
							<c:set var="timeTeamSum_01_5" value="0"></c:set>
											    
							<c:set var="endTeamSum_12_5" value="0"></c:set>
							<c:set var="endTeamSum_11_5" value="0"></c:set>
							<c:set var="endTeamSum_10_5" value="0"></c:set>
							<c:set var="endTeamSum_09_5" value="0"></c:set>
							<c:set var="endTeamSum_08_5" value="0"></c:set>
							<c:set var="endTeamSum_07_5" value="0"></c:set>
							<c:set var="endTeamSum_06_5" value="0"></c:set>
							<c:set var="endTeamSum_05_5" value="0"></c:set>
							<c:set var="endTeamSum_04_5" value="0"></c:set>
							<c:set var="endTeamSum_03_5" value="0"></c:set>
							<c:set var="endTeamSum_02_5" value="0"></c:set>
							<c:set var="endTeamSum_01_5" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 팀별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 팀별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 조사 소계 시작 -->
		    	<c:if test="${ptnrStatCntTimeList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 조사 평균</th>
	                <c:choose>
    					<c:when test="${timeTeamTotalSum_12_5 eq 0 or endTeamTotalSum_12_5 eq 0}">
    						<c:set var="arvTeamTotalSum_12_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_12_5" value="${timeTeamTotalSum_12_5 / endTeamTotalSum_12_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_11_5 eq 0 or endTeamTotalSum_11_5 eq 0}">
    						<c:set var="arvTeamTotalSum_11_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_11_5" value="${timeTeamTotalSum_11_5 / endTeamTotalSum_11_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_10_5 eq 0 or endTeamTotalSum_10_5 eq 0}">
    						<c:set var="arvTeamTotalSum_10_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_10_5" value="${timeTeamTotalSum_10_5 / endTeamTotalSum_10_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_09_5 eq 0 or endTeamTotalSum_09_5 eq 0}">
    						<c:set var="arvTeamTotalSum_09_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_09_5" value="${timeTeamTotalSum_09_5 / endTeamTotalSum_09_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_08_5 eq 0 or endTeamTotalSum_08_5 eq 0}">
    						<c:set var="arvTeamTotalSum_08_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_08_5" value="${timeTeamTotalSum_08_5 / endTeamTotalSum_08_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_07_5 eq 0 or endTeamTotalSum_07_5 eq 0}">
    						<c:set var="arvTeamTotalSum_07_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_07_5" value="${timeTeamTotalSum_07_5 / endTeamTotalSum_07_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_06_5 eq 0 or endTeamTotalSum_06_5 eq 0}">
    						<c:set var="arvTeamTotalSum_06_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_06_5" value="${timeTeamTotalSum_06_5 / endTeamTotalSum_06_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_05_5 eq 0 or endTeamTotalSum_05_5 eq 0}">
    						<c:set var="arvTeamTotalSum_05_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_05_5" value="${timeTeamTotalSum_05_5 / endTeamTotalSum_05_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_04_5 eq 0 or endTeamTotalSum_04_5 eq 0}">
    						<c:set var="arvTeamTotalSum_04_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_04_5" value="${timeTeamTotalSum_04_5 / endTeamTotalSum_04_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_03_5 eq 0 or endTeamTotalSum_03_5 eq 0}">
    						<c:set var="arvTeamTotalSum_03_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_03_5" value="${timeTeamTotalSum_03_5 / endTeamTotalSum_03_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_02_5 eq 0 or endTeamTotalSum_02_5 eq 0}">
    						<c:set var="arvTeamTotalSum_02_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_02_5" value="${timeTeamTotalSum_02_5 / endTeamTotalSum_02_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_01_5 eq 0 or endTeamTotalSum_01_5 eq 0}">
    						<c:set var="arvTeamTotalSum_01_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_01_5" value="${timeTeamTotalSum_01_5 / endTeamTotalSum_01_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 팀별 평균 계산 끝 -->
    						    				
    				<!-- cntTime12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_12_5}" pattern="#,##0.##"/></th>
    				<!-- cntTime11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_11_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_10_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_09_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_08_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_07_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_06_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_05_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_04_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_03_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_02_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_01_5}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="timeColTeamTotalSum_5" value="${timeTeamTotalSum_12_5 + timeTeamTotalSum_11_5 + timeTeamTotalSum_10_5 + timeTeamTotalSum_09_5 + timeTeamTotalSum_08_5 + timeTeamTotalSum_07_5 + timeTeamTotalSum_06_5 + timeTeamTotalSum_05_5 + timeTeamTotalSum_04_5 + timeTeamTotalSum_03_5 + timeTeamTotalSum_02_5 + timeTeamTotalSum_01_5}"></c:set>
	                <c:set var="endColTeamTotalSum_5" value="${endTeamTotalSum_12_5 + endTeamTotalSum_11_5 + endTeamTotalSum_10_5 + endTeamTotalSum_09_5 + endTeamTotalSum_08_5 + endTeamTotalSum_07_5 + endTeamTotalSum_06_5 + endTeamTotalSum_05_5 + endTeamTotalSum_04_5 + endTeamTotalSum_03_5 + endTeamTotalSum_02_5 + endTeamTotalSum_01_5}"></c:set>
					<c:choose>
	                	<c:when test="${timeColTeamTotalSum_5 eq 0 or endColTeamTotalSum_5 eq 0}">
	                		<c:set var="arvColTeamTotalSum_5" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColTeamTotalSum_5" value="${timeColTeamTotalSum_5 / endColTeamTotalSum_5}"/>
	                	</c:otherwise>
					</c:choose>
	                
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvColTeamTotalSum_5}" pattern="#,##0.##"/></th>
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
	            <c:set var="cntTimeTeamSum_12_10" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_11_10" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_10_10" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_09_10" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_08_10" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_07_10" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_06_10" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_05_10" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_04_10" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_03_10" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_02_10" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_01_10" value="0"></c:set>
	            
	            <!-- 팀별 평균 계 초기화 -->
				<c:set var="timeTeamSum_12_10" value="0"></c:set>
				<c:set var="timeTeamSum_11_10" value="0"></c:set>
				<c:set var="timeTeamSum_10_10" value="0"></c:set>
				<c:set var="timeTeamSum_09_10" value="0"></c:set>
				<c:set var="timeTeamSum_08_10" value="0"></c:set>
				<c:set var="timeTeamSum_07_10" value="0"></c:set>
				<c:set var="timeTeamSum_06_10" value="0"></c:set>
				<c:set var="timeTeamSum_05_10" value="0"></c:set>
				<c:set var="timeTeamSum_04_10" value="0"></c:set>
				<c:set var="timeTeamSum_03_10" value="0"></c:set>
				<c:set var="timeTeamSum_02_10" value="0"></c:set>
				<c:set var="timeTeamSum_01_10" value="0"></c:set>
								    
				<c:set var="endTeamSum_12_10" value="0"></c:set>
				<c:set var="endTeamSum_11_10" value="0"></c:set>
				<c:set var="endTeamSum_10_10" value="0"></c:set>
				<c:set var="endTeamSum_09_10" value="0"></c:set>
				<c:set var="endTeamSum_08_10" value="0"></c:set>
				<c:set var="endTeamSum_07_10" value="0"></c:set>
				<c:set var="endTeamSum_06_10" value="0"></c:set>
				<c:set var="endTeamSum_05_10" value="0"></c:set>
				<c:set var="endTeamSum_04_10" value="0"></c:set>
				<c:set var="endTeamSum_03_10" value="0"></c:set>
				<c:set var="endTeamSum_02_10" value="0"></c:set>
				<c:set var="endTeamSum_01_10" value="0"></c:set>
				
	            <!-- Type 별 총 합계 -->
	            <c:set var="cntTimeTeamTotalSum_12_10" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_11_10" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_10_10" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_09_10" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_08_10" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_07_10" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_06_10" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_05_10" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_04_10" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_03_10" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_02_10" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_01_10" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntTimeColTeamTotalSum_10" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="timeTeamTotalSum_12_10" value="0"></c:set>
				<c:set var="timeTeamTotalSum_11_10" value="0"></c:set>
				<c:set var="timeTeamTotalSum_10_10" value="0"></c:set>
				<c:set var="timeTeamTotalSum_09_10" value="0"></c:set>
				<c:set var="timeTeamTotalSum_08_10" value="0"></c:set>
				<c:set var="timeTeamTotalSum_07_10" value="0"></c:set>
				<c:set var="timeTeamTotalSum_06_10" value="0"></c:set>
				<c:set var="timeTeamTotalSum_05_10" value="0"></c:set>
				<c:set var="timeTeamTotalSum_04_10" value="0"></c:set>
				<c:set var="timeTeamTotalSum_03_10" value="0"></c:set>
				<c:set var="timeTeamTotalSum_02_10" value="0"></c:set>
				<c:set var="timeTeamTotalSum_01_10" value="0"></c:set>
				
				<c:set var="endTeamTotalSum_12_10" value="0"></c:set>
				<c:set var="endTeamTotalSum_11_10" value="0"></c:set>
				<c:set var="endTeamTotalSum_10_10" value="0"></c:set>
				<c:set var="endTeamTotalSum_09_10" value="0"></c:set>
				<c:set var="endTeamTotalSum_08_10" value="0"></c:set>
				<c:set var="endTeamTotalSum_07_10" value="0"></c:set>
				<c:set var="endTeamTotalSum_06_10" value="0"></c:set>
				<c:set var="endTeamTotalSum_05_10" value="0"></c:set>
				<c:set var="endTeamTotalSum_04_10" value="0"></c:set>
				<c:set var="endTeamTotalSum_03_10" value="0"></c:set>
				<c:set var="endTeamTotalSum_02_10" value="0"></c:set>
				<c:set var="endTeamTotalSum_01_10" value="0"></c:set>	            
   				    			
    			<c:forEach var="vo1" items="${ptnrStatCntTimeList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCenterCntTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
		                    	1종 심사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo1.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatMember(${vo1.ptnrId},${vo1.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.teamName}</td>
		                		<td style="width:150px;">${vo1.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="cntTimeTeamSum_12_10" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_11_10" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_10_10" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_09_10" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_08_10" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_07_10" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_06_10" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_05_10" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_04_10" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_03_10" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_02_10" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_01_10" value="0"></c:set>
					            
					            <!-- 팀별 평균 계 초기화 -->
								<c:set var="timeTeamSum_12_10" value="0"></c:set>
								<c:set var="timeTeamSum_11_10" value="0"></c:set>
								<c:set var="timeTeamSum_10_10" value="0"></c:set>
								<c:set var="timeTeamSum_09_10" value="0"></c:set>
								<c:set var="timeTeamSum_08_10" value="0"></c:set>
								<c:set var="timeTeamSum_07_10" value="0"></c:set>
								<c:set var="timeTeamSum_06_10" value="0"></c:set>
								<c:set var="timeTeamSum_05_10" value="0"></c:set>
								<c:set var="timeTeamSum_04_10" value="0"></c:set>
								<c:set var="timeTeamSum_03_10" value="0"></c:set>
								<c:set var="timeTeamSum_02_10" value="0"></c:set>
								<c:set var="timeTeamSum_01_10" value="0"></c:set>
												    
								<c:set var="endTeamSum_12_10" value="0"></c:set>
								<c:set var="endTeamSum_11_10" value="0"></c:set>
								<c:set var="endTeamSum_10_10" value="0"></c:set>
								<c:set var="endTeamSum_09_10" value="0"></c:set>
								<c:set var="endTeamSum_08_10" value="0"></c:set>
								<c:set var="endTeamSum_07_10" value="0"></c:set>
								<c:set var="endTeamSum_06_10" value="0"></c:set>
								<c:set var="endTeamSum_05_10" value="0"></c:set>
								<c:set var="endTeamSum_04_10" value="0"></c:set>
								<c:set var="endTeamSum_03_10" value="0"></c:set>
								<c:set var="endTeamSum_02_10" value="0"></c:set>
								<c:set var="endTeamSum_01_10" value="0"></c:set>
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
		                
		                <!-- 팀별 계 합산 -->
	    				<c:set var="cntTimeTeamSum_12_10" value="${cntTimeTeamSum_12_10+cntTime12_10}"></c:set>
			            <c:set var="cntTimeTeamSum_11_10" value="${cntTimeTeamSum_11_10+cntTime11_10}"></c:set>
			            <c:set var="cntTimeTeamSum_10_10" value="${cntTimeTeamSum_10_10+cntTime10_10}"></c:set>
			            <c:set var="cntTimeTeamSum_09_10" value="${cntTimeTeamSum_09_10+cntTime09_10}"></c:set>
			            <c:set var="cntTimeTeamSum_08_10" value="${cntTimeTeamSum_08_10+cntTime08_10}"></c:set>
			            <c:set var="cntTimeTeamSum_07_10" value="${cntTimeTeamSum_07_10+cntTime07_10}"></c:set>
			            <c:set var="cntTimeTeamSum_06_10" value="${cntTimeTeamSum_06_10+cntTime06_10}"></c:set>
			            <c:set var="cntTimeTeamSum_05_10" value="${cntTimeTeamSum_05_10+cntTime05_10}"></c:set>
			            <c:set var="cntTimeTeamSum_04_10" value="${cntTimeTeamSum_04_10+cntTime04_10}"></c:set>
			            <c:set var="cntTimeTeamSum_03_10" value="${cntTimeTeamSum_03_10+cntTime03_10}"></c:set>
			            <c:set var="cntTimeTeamSum_02_10" value="${cntTimeTeamSum_02_10+cntTime02_10}"></c:set>
			            <c:set var="cntTimeTeamSum_01_10" value="${cntTimeTeamSum_01_10+cntTime01_10}"></c:set>
			            
			            <!-- 팀별 계 평균용 변수 -->
						<c:set var="timeTeamSum_12_10" value="${timeTeamSum_12_10+time12_10}"></c:set>
			            <c:set var="timeTeamSum_11_10" value="${timeTeamSum_11_10+time11_10}"></c:set>
			            <c:set var="timeTeamSum_10_10" value="${timeTeamSum_10_10+time10_10}"></c:set>
			            <c:set var="timeTeamSum_09_10" value="${timeTeamSum_09_10+time09_10}"></c:set>
			            <c:set var="timeTeamSum_08_10" value="${timeTeamSum_08_10+time08_10}"></c:set>
			            <c:set var="timeTeamSum_07_10" value="${timeTeamSum_07_10+time07_10}"></c:set>
			            <c:set var="timeTeamSum_06_10" value="${timeTeamSum_06_10+time06_10}"></c:set>
			            <c:set var="timeTeamSum_05_10" value="${timeTeamSum_05_10+time05_10}"></c:set>
			            <c:set var="timeTeamSum_04_10" value="${timeTeamSum_04_10+time04_10}"></c:set>
			            <c:set var="timeTeamSum_03_10" value="${timeTeamSum_03_10+time03_10}"></c:set>
			            <c:set var="timeTeamSum_02_10" value="${timeTeamSum_02_10+time02_10}"></c:set>
			            <c:set var="timeTeamSum_01_10" value="${timeTeamSum_01_10+time01_10}"></c:set>
				    
						<c:set var="endTeamSum_12_10" value="${endTeamSum_12_10+end12_10}"></c:set>
			            <c:set var="endTeamSum_11_10" value="${endTeamSum_11_10+end11_10}"></c:set>
			            <c:set var="endTeamSum_10_10" value="${endTeamSum_10_10+end10_10}"></c:set>
			            <c:set var="endTeamSum_09_10" value="${endTeamSum_09_10+end09_10}"></c:set>
			            <c:set var="endTeamSum_08_10" value="${endTeamSum_08_10+end08_10}"></c:set>
			            <c:set var="endTeamSum_07_10" value="${endTeamSum_07_10+end07_10}"></c:set>
			            <c:set var="endTeamSum_06_10" value="${endTeamSum_06_10+end06_10}"></c:set>
			            <c:set var="endTeamSum_05_10" value="${endTeamSum_05_10+end05_10}"></c:set>
			            <c:set var="endTeamSum_04_10" value="${endTeamSum_04_10+end04_10}"></c:set>
			            <c:set var="endTeamSum_03_10" value="${endTeamSum_03_10+end03_10}"></c:set>
			            <c:set var="endTeamSum_02_10" value="${endTeamSum_02_10+end02_10}"></c:set>
			            <c:set var="endTeamSum_01_10" value="${endTeamSum_01_10+end01_10}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="cntTimeTeamTotalSum_12_10" value="${cntTimeTeamTotalSum_12_10 + cntTime12_10}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_11_10" value="${cntTimeTeamTotalSum_11_10 + cntTime11_10}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_10_10" value="${cntTimeTeamTotalSum_10_10 + cntTime10_10}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_09_10" value="${cntTimeTeamTotalSum_09_10 + cntTime09_10}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_08_10" value="${cntTimeTeamTotalSum_08_10 + cntTime08_10}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_07_10" value="${cntTimeTeamTotalSum_07_10 + cntTime07_10}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_06_10" value="${cntTimeTeamTotalSum_06_10 + cntTime06_10}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_05_10" value="${cntTimeTeamTotalSum_05_10 + cntTime05_10}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_04_10" value="${cntTimeTeamTotalSum_04_10 + cntTime04_10}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_03_10" value="${cntTimeTeamTotalSum_03_10 + cntTime03_10}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_02_10" value="${cntTimeTeamTotalSum_02_10 + cntTime02_10}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_01_10" value="${cntTimeTeamTotalSum_01_10 + cntTime01_10}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="timeTeamTotalSum_12_10" value="${timeTeamTotalSum_12_10 + time12_10}"></c:set>
	                    <c:set var="timeTeamTotalSum_11_10" value="${timeTeamTotalSum_11_10 + time11_10}"></c:set>
	                    <c:set var="timeTeamTotalSum_10_10" value="${timeTeamTotalSum_10_10 + time10_10}"></c:set>
	                    <c:set var="timeTeamTotalSum_09_10" value="${timeTeamTotalSum_09_10 + time09_10}"></c:set>
	                    <c:set var="timeTeamTotalSum_08_10" value="${timeTeamTotalSum_08_10 + time08_10}"></c:set>
	                    <c:set var="timeTeamTotalSum_07_10" value="${timeTeamTotalSum_07_10 + time07_10}"></c:set>
	                    <c:set var="timeTeamTotalSum_06_10" value="${timeTeamTotalSum_06_10 + time06_10}"></c:set>
	                    <c:set var="timeTeamTotalSum_05_10" value="${timeTeamTotalSum_05_10 + time05_10}"></c:set>
	                    <c:set var="timeTeamTotalSum_04_10" value="${timeTeamTotalSum_04_10 + time04_10}"></c:set>
	                    <c:set var="timeTeamTotalSum_03_10" value="${timeTeamTotalSum_03_10 + time03_10}"></c:set>
	                    <c:set var="timeTeamTotalSum_02_10" value="${timeTeamTotalSum_02_10 + time02_10}"></c:set>
	                    <c:set var="timeTeamTotalSum_01_10" value="${timeTeamTotalSum_01_10 + time01_10}"></c:set>

						<c:set var="endTeamTotalSum_12_10" value="${endTeamTotalSum_12_10 + end12_10}"></c:set>
	                    <c:set var="endTeamTotalSum_11_10" value="${endTeamTotalSum_11_10 + end11_10}"></c:set>
	                    <c:set var="endTeamTotalSum_10_10" value="${endTeamTotalSum_10_10 + end10_10}"></c:set>
	                    <c:set var="endTeamTotalSum_09_10" value="${endTeamTotalSum_09_10 + end09_10}"></c:set>
	                    <c:set var="endTeamTotalSum_08_10" value="${endTeamTotalSum_08_10 + end08_10}"></c:set>
	                    <c:set var="endTeamTotalSum_07_10" value="${endTeamTotalSum_07_10 + end07_10}"></c:set>
	                    <c:set var="endTeamTotalSum_06_10" value="${endTeamTotalSum_06_10 + end06_10}"></c:set>
	                    <c:set var="endTeamTotalSum_05_10" value="${endTeamTotalSum_05_10 + end05_10}"></c:set>
	                    <c:set var="endTeamTotalSum_04_10" value="${endTeamTotalSum_04_10 + end04_10}"></c:set>
	                    <c:set var="endTeamTotalSum_03_10" value="${endTeamTotalSum_03_10 + end03_10}"></c:set>
	                    <c:set var="endTeamTotalSum_02_10" value="${endTeamTotalSum_02_10 + end02_10}"></c:set>
	                    <c:set var="endTeamTotalSum_01_10" value="${endTeamTotalSum_01_10 + end01_10}"></c:set>
		    		</tr>
		    		<!-- 팀별 소계 시작 -->
		    		
		    		<!-- 팀별 평균 계산 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo1.rowCnt and vo1.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">${vo1.teamName} 평균</td>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_12_10 eq 0 or endTeamSum_12_10 eq 0}">
		    						<c:set var="arvTeamSum_12_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_12_10" value="${timeTeamSum_12_10 / endTeamSum_12_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_11_10 eq 0 or endTeamSum_11_10 eq 0}">
		    						<c:set var="arvTeamSum_11_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_11_10" value="${timeTeamSum_11_10 / endTeamSum_11_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_10_10 eq 0 or endTeamSum_10_10 eq 0}">
		    						<c:set var="arvTeamSum_10_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_10_10" value="${timeTeamSum_10_10 / endTeamSum_10_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_09_10 eq 0 or endTeamSum_09_10 eq 0}">
		    						<c:set var="arvTeamSum_09_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_09_10" value="${timeTeamSum_09_10 / endTeamSum_09_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_08_10 eq 0 or endTeamSum_08_10 eq 0}">
		    						<c:set var="arvTeamSum_08_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_08_10" value="${timeTeamSum_08_10 / endTeamSum_08_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_07_10 eq 0 or endTeamSum_07_10 eq 0}">
		    						<c:set var="arvTeamSum_07_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_07_10" value="${timeTeamSum_07_10 / endTeamSum_07_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_06_10 eq 0 or endTeamSum_06_10 eq 0}">
		    						<c:set var="arvTeamSum_06_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_06_10" value="${timeTeamSum_06_10 / endTeamSum_06_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_05_10 eq 0 or endTeamSum_05_10 eq 0}">
		    						<c:set var="arvTeamSum_05_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_05_10" value="${timeTeamSum_05_10 / endTeamSum_05_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_04_10 eq 0 or endTeamSum_04_10 eq 0}">
		    						<c:set var="arvTeamSum_04_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_04_10" value="${timeTeamSum_04_10 / endTeamSum_04_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_03_10 eq 0 or endTeamSum_03_10 eq 0}">
		    						<c:set var="arvTeamSum_03_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_03_10" value="${timeTeamSum_03_10 / endTeamSum_03_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_02_10 eq 0 or endTeamSum_02_10 eq 0}">
		    						<c:set var="arvTeamSum_02_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_02_10" value="${timeTeamSum_02_10 / endTeamSum_02_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_01_10 eq 0 or endTeamSum_01_10 eq 0}">
		    						<c:set var="arvTeamSum_01_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_01_10" value="${timeTeamSum_01_10 / endTeamSum_01_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 팀별 평균 계산 끝 -->
		    						    				
		    				<!-- cntTime12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_12_10}" pattern="#,##0.##"/></td>
		    				<!-- cntTime11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_11_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_10_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_09_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_08_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_07_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_06_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_05_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_04_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_03_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_02_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_01_10}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="timeTeamColSum_10" value="${timeTeamSum_12_10 + timeTeamSum_11_10 + timeTeamSum_10_10 + timeTeamSum_09_10 + timeTeamSum_08_10 + timeTeamSum_07_10 + timeTeamSum_06_10 + timeTeamSum_05_10 + timeTeamSum_04_10 + timeTeamSum_03_10 + timeTeamSum_02_10 + timeTeamSum_01_10}"></c:set>
			                <c:set var="endTeamColSum_10" value="${endTeamSum_12_10 + endTeamSum_11_10 + endTeamSum_10_10 + endTeamSum_09_10 + endTeamSum_08_10 + endTeamSum_07_10 + endTeamSum_06_10 + endTeamSum_05_10 + endTeamSum_04_10 + endTeamSum_03_10 + endTeamSum_02_10 + endTeamSum_01_10}"></c:set>			                
			                <c:choose>
			                	<c:when test="${timeTeamColSum_10 eq 0 or endTeamColSum_10 eq 0}">
			                		<c:set var="arvTeamColSum_10" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvTeamColSum_10" value="${timeTeamColSum_10 / endTeamColSum_10}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamColSum_10}" pattern="#,##0.##"/></td>
		    				
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="cntTimeTeamSum_12_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_11_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_10_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_09_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_08_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_07_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_06_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_05_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_04_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_03_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_02_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_01_10" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="timeTeamSum_12_10" value="0"></c:set>
							<c:set var="timeTeamSum_11_10" value="0"></c:set>
							<c:set var="timeTeamSum_10_10" value="0"></c:set>
							<c:set var="timeTeamSum_09_10" value="0"></c:set>
							<c:set var="timeTeamSum_08_10" value="0"></c:set>
							<c:set var="timeTeamSum_07_10" value="0"></c:set>
							<c:set var="timeTeamSum_06_10" value="0"></c:set>
							<c:set var="timeTeamSum_05_10" value="0"></c:set>
							<c:set var="timeTeamSum_04_10" value="0"></c:set>
							<c:set var="timeTeamSum_03_10" value="0"></c:set>
							<c:set var="timeTeamSum_02_10" value="0"></c:set>
							<c:set var="timeTeamSum_01_10" value="0"></c:set>
											    
							<c:set var="endTeamSum_12_10" value="0"></c:set>
							<c:set var="endTeamSum_11_10" value="0"></c:set>
							<c:set var="endTeamSum_10_10" value="0"></c:set>
							<c:set var="endTeamSum_09_10" value="0"></c:set>
							<c:set var="endTeamSum_08_10" value="0"></c:set>
							<c:set var="endTeamSum_07_10" value="0"></c:set>
							<c:set var="endTeamSum_06_10" value="0"></c:set>
							<c:set var="endTeamSum_05_10" value="0"></c:set>
							<c:set var="endTeamSum_04_10" value="0"></c:set>
							<c:set var="endTeamSum_03_10" value="0"></c:set>
							<c:set var="endTeamSum_02_10" value="0"></c:set>
							<c:set var="endTeamSum_01_10" value="0"></c:set>				            				            
		    			</c:when>
		    			<c:when test="${vo1.rowCnt == 1}">
		    				<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="cntTimeTeamSum_12_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_11_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_10_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_09_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_08_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_07_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_06_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_05_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_04_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_03_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_02_10" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_01_10" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="timeTeamSum_12_10" value="0"></c:set>
							<c:set var="timeTeamSum_11_10" value="0"></c:set>
							<c:set var="timeTeamSum_10_10" value="0"></c:set>
							<c:set var="timeTeamSum_09_10" value="0"></c:set>
							<c:set var="timeTeamSum_08_10" value="0"></c:set>
							<c:set var="timeTeamSum_07_10" value="0"></c:set>
							<c:set var="timeTeamSum_06_10" value="0"></c:set>
							<c:set var="timeTeamSum_05_10" value="0"></c:set>
							<c:set var="timeTeamSum_04_10" value="0"></c:set>
							<c:set var="timeTeamSum_03_10" value="0"></c:set>
							<c:set var="timeTeamSum_02_10" value="0"></c:set>
							<c:set var="timeTeamSum_01_10" value="0"></c:set>
											    
							<c:set var="endTeamSum_12_10" value="0"></c:set>
							<c:set var="endTeamSum_11_10" value="0"></c:set>
							<c:set var="endTeamSum_10_10" value="0"></c:set>
							<c:set var="endTeamSum_09_10" value="0"></c:set>
							<c:set var="endTeamSum_08_10" value="0"></c:set>
							<c:set var="endTeamSum_07_10" value="0"></c:set>
							<c:set var="endTeamSum_06_10" value="0"></c:set>
							<c:set var="endTeamSum_05_10" value="0"></c:set>
							<c:set var="endTeamSum_04_10" value="0"></c:set>
							<c:set var="endTeamSum_03_10" value="0"></c:set>
							<c:set var="endTeamSum_02_10" value="0"></c:set>
							<c:set var="endTeamSum_01_10" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 팀별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 팀별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 심사 소계 시작 -->
		    	<c:if test="${ptnrStatCntTimeList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 심사 평균</th>
	                <c:choose>
    					<c:when test="${timeTeamTotalSum_12_10 eq 0 or endTeamTotalSum_12_10 eq 0}">
    						<c:set var="arvTeamTotalSum_12_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_12_10" value="${timeTeamTotalSum_12_10 / endTeamTotalSum_12_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_11_10 eq 0 or endTeamTotalSum_11_10 eq 0}">
    						<c:set var="arvTeamTotalSum_11_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_11_10" value="${timeTeamTotalSum_11_10 / endTeamTotalSum_11_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_10_10 eq 0 or endTeamTotalSum_10_10 eq 0}">
    						<c:set var="arvTeamTotalSum_10_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_10_10" value="${timeTeamTotalSum_10_10 / endTeamTotalSum_10_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_09_10 eq 0 or endTeamTotalSum_09_10 eq 0}">
    						<c:set var="arvTeamTotalSum_09_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_09_10" value="${timeTeamTotalSum_09_10 / endTeamTotalSum_09_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_08_10 eq 0 or endTeamTotalSum_08_10 eq 0}">
    						<c:set var="arvTeamTotalSum_08_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_08_10" value="${timeTeamTotalSum_08_10 / endTeamTotalSum_08_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_07_10 eq 0 or endTeamTotalSum_07_10 eq 0}">
    						<c:set var="arvTeamTotalSum_07_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_07_10" value="${timeTeamTotalSum_07_10 / endTeamTotalSum_07_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_06_10 eq 0 or endTeamTotalSum_06_10 eq 0}">
    						<c:set var="arvTeamTotalSum_06_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_06_10" value="${timeTeamTotalSum_06_10 / endTeamTotalSum_06_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_05_10 eq 0 or endTeamTotalSum_05_10 eq 0}">
    						<c:set var="arvTeamTotalSum_05_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_05_10" value="${timeTeamTotalSum_05_10 / endTeamTotalSum_05_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_04_10 eq 0 or endTeamTotalSum_04_10 eq 0}">
    						<c:set var="arvTeamTotalSum_04_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_04_10" value="${timeTeamTotalSum_04_10 / endTeamTotalSum_04_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_03_10 eq 0 or endTeamTotalSum_03_10 eq 0}">
    						<c:set var="arvTeamTotalSum_03_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_03_10" value="${timeTeamTotalSum_03_10 / endTeamTotalSum_03_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_02_10 eq 0 or endTeamTotalSum_02_10 eq 0}">
    						<c:set var="arvTeamTotalSum_02_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_02_10" value="${timeTeamTotalSum_02_10 / endTeamTotalSum_02_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_01_10 eq 0 or endTeamTotalSum_01_10 eq 0}">
    						<c:set var="arvTeamTotalSum_01_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_01_10" value="${timeTeamTotalSum_01_10 / endTeamTotalSum_01_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 팀별 평균 계산 끝 -->
    						    				
    				<!-- cntTime12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_12_10}" pattern="#,##0.##"/></th>
    				<!-- cntTime11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_11_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_10_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_09_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_08_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_07_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_06_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_05_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_04_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_03_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_02_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_01_10}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="timeColTeamTotalSum_10" value="${timeTeamTotalSum_12_10 + timeTeamTotalSum_11_10 + timeTeamTotalSum_10_10 + timeTeamTotalSum_09_10 + timeTeamTotalSum_08_10 + timeTeamTotalSum_07_10 + timeTeamTotalSum_06_10 + timeTeamTotalSum_05_10 + timeTeamTotalSum_04_10 + timeTeamTotalSum_03_10 + timeTeamTotalSum_02_10 + timeTeamTotalSum_01_10}"></c:set>
	                <c:set var="endColTeamTotalSum_10" value="${endTeamTotalSum_12_10 + endTeamTotalSum_11_10 + endTeamTotalSum_10_10 + endTeamTotalSum_09_10 + endTeamTotalSum_08_10 + endTeamTotalSum_07_10 + endTeamTotalSum_06_10 + endTeamTotalSum_05_10 + endTeamTotalSum_04_10 + endTeamTotalSum_03_10 + endTeamTotalSum_02_10 + endTeamTotalSum_01_10}"></c:set>
					<c:choose>
	                	<c:when test="${timeColTeamTotalSum_10 eq 0 or endColTeamTotalSum_10 eq 0}">
	                		<c:set var="arvColTeamTotalSum_10" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColTeamTotalSum_10" value="${timeColTeamTotalSum_10 / endColTeamTotalSum_10}"/>
	                	</c:otherwise>
					</c:choose>
	                
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvColTeamTotalSum_10}" pattern="#,##0.##"/></th>
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
	            <c:set var="cntTimeTeamSum_12_15" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_11_15" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_10_15" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_09_15" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_08_15" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_07_15" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_06_15" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_05_15" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_04_15" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_03_15" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_02_15" value="0"></c:set>
	            <c:set var="cntTimeTeamSum_01_15" value="0"></c:set>
	            
	            <!-- 팀별 평균 계 초기화 -->
				<c:set var="timeTeamSum_12_15" value="0"></c:set>
				<c:set var="timeTeamSum_11_15" value="0"></c:set>
				<c:set var="timeTeamSum_10_15" value="0"></c:set>
				<c:set var="timeTeamSum_09_15" value="0"></c:set>
				<c:set var="timeTeamSum_08_15" value="0"></c:set>
				<c:set var="timeTeamSum_07_15" value="0"></c:set>
				<c:set var="timeTeamSum_06_15" value="0"></c:set>
				<c:set var="timeTeamSum_05_15" value="0"></c:set>
				<c:set var="timeTeamSum_04_15" value="0"></c:set>
				<c:set var="timeTeamSum_03_15" value="0"></c:set>
				<c:set var="timeTeamSum_02_15" value="0"></c:set>
				<c:set var="timeTeamSum_01_15" value="0"></c:set>
								    
				<c:set var="endTeamSum_12_15" value="0"></c:set>
				<c:set var="endTeamSum_11_15" value="0"></c:set>
				<c:set var="endTeamSum_10_15" value="0"></c:set>
				<c:set var="endTeamSum_09_15" value="0"></c:set>
				<c:set var="endTeamSum_08_15" value="0"></c:set>
				<c:set var="endTeamSum_07_15" value="0"></c:set>
				<c:set var="endTeamSum_06_15" value="0"></c:set>
				<c:set var="endTeamSum_05_15" value="0"></c:set>
				<c:set var="endTeamSum_04_15" value="0"></c:set>
				<c:set var="endTeamSum_03_15" value="0"></c:set>
				<c:set var="endTeamSum_02_15" value="0"></c:set>
				<c:set var="endTeamSum_01_15" value="0"></c:set>
				
	            <!-- Type 별 총 합계 -->
	            <c:set var="cntTimeTeamTotalSum_12_15" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_11_15" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_10_15" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_09_15" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_08_15" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_07_15" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_06_15" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_05_15" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_04_15" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_03_15" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_02_15" value="0"></c:set>
	            <c:set var="cntTimeTeamTotalSum_01_15" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntTimeColTeamTotalSum_15" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="timeTeamTotalSum_12_15" value="0"></c:set>
				<c:set var="timeTeamTotalSum_11_15" value="0"></c:set>
				<c:set var="timeTeamTotalSum_10_15" value="0"></c:set>
				<c:set var="timeTeamTotalSum_09_15" value="0"></c:set>
				<c:set var="timeTeamTotalSum_08_15" value="0"></c:set>
				<c:set var="timeTeamTotalSum_07_15" value="0"></c:set>
				<c:set var="timeTeamTotalSum_06_15" value="0"></c:set>
				<c:set var="timeTeamTotalSum_05_15" value="0"></c:set>
				<c:set var="timeTeamTotalSum_04_15" value="0"></c:set>
				<c:set var="timeTeamTotalSum_03_15" value="0"></c:set>
				<c:set var="timeTeamTotalSum_02_15" value="0"></c:set>
				<c:set var="timeTeamTotalSum_01_15" value="0"></c:set>
				
				<c:set var="endTeamTotalSum_12_15" value="0"></c:set>
				<c:set var="endTeamTotalSum_11_15" value="0"></c:set>
				<c:set var="endTeamTotalSum_10_15" value="0"></c:set>
				<c:set var="endTeamTotalSum_09_15" value="0"></c:set>
				<c:set var="endTeamTotalSum_08_15" value="0"></c:set>
				<c:set var="endTeamTotalSum_07_15" value="0"></c:set>
				<c:set var="endTeamTotalSum_06_15" value="0"></c:set>
				<c:set var="endTeamTotalSum_05_15" value="0"></c:set>
				<c:set var="endTeamTotalSum_04_15" value="0"></c:set>
				<c:set var="endTeamTotalSum_03_15" value="0"></c:set>
				<c:set var="endTeamTotalSum_02_15" value="0"></c:set>
				<c:set var="endTeamTotalSum_01_15" value="0"></c:set>	            
   				    			
    			<c:forEach var="vo2" items="${ptnrStatCntTimeList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCenterCntTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
		                    	1종 기타
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo2.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatMember(${vo2.ptnrId},${vo2.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.teamName}</td>
		                		<td style="width:150px;">${vo2.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="cntTimeTeamSum_12_15" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_11_15" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_10_15" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_09_15" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_08_15" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_07_15" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_06_15" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_05_15" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_04_15" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_03_15" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_02_15" value="0"></c:set>
					            <c:set var="cntTimeTeamSum_01_15" value="0"></c:set>
					            
					            <!-- 팀별 평균 계 초기화 -->
								<c:set var="timeTeamSum_12_15" value="0"></c:set>
								<c:set var="timeTeamSum_11_15" value="0"></c:set>
								<c:set var="timeTeamSum_10_15" value="0"></c:set>
								<c:set var="timeTeamSum_09_15" value="0"></c:set>
								<c:set var="timeTeamSum_08_15" value="0"></c:set>
								<c:set var="timeTeamSum_07_15" value="0"></c:set>
								<c:set var="timeTeamSum_06_15" value="0"></c:set>
								<c:set var="timeTeamSum_05_15" value="0"></c:set>
								<c:set var="timeTeamSum_04_15" value="0"></c:set>
								<c:set var="timeTeamSum_03_15" value="0"></c:set>
								<c:set var="timeTeamSum_02_15" value="0"></c:set>
								<c:set var="timeTeamSum_01_15" value="0"></c:set>
												    
								<c:set var="endTeamSum_12_15" value="0"></c:set>
								<c:set var="endTeamSum_11_15" value="0"></c:set>
								<c:set var="endTeamSum_10_15" value="0"></c:set>
								<c:set var="endTeamSum_09_15" value="0"></c:set>
								<c:set var="endTeamSum_08_15" value="0"></c:set>
								<c:set var="endTeamSum_07_15" value="0"></c:set>
								<c:set var="endTeamSum_06_15" value="0"></c:set>
								<c:set var="endTeamSum_05_15" value="0"></c:set>
								<c:set var="endTeamSum_04_15" value="0"></c:set>
								<c:set var="endTeamSum_03_15" value="0"></c:set>
								<c:set var="endTeamSum_02_15" value="0"></c:set>
								<c:set var="endTeamSum_01_15" value="0"></c:set>
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
		                
		                <!-- 팀별 계 합산 -->
	    				<c:set var="cntTimeTeamSum_12_15" value="${cntTimeTeamSum_12_15+cntTime12_15}"></c:set>
			            <c:set var="cntTimeTeamSum_11_15" value="${cntTimeTeamSum_11_15+cntTime11_15}"></c:set>
			            <c:set var="cntTimeTeamSum_10_15" value="${cntTimeTeamSum_10_15+cntTime10_15}"></c:set>
			            <c:set var="cntTimeTeamSum_09_15" value="${cntTimeTeamSum_09_15+cntTime09_15}"></c:set>
			            <c:set var="cntTimeTeamSum_08_15" value="${cntTimeTeamSum_08_15+cntTime08_15}"></c:set>
			            <c:set var="cntTimeTeamSum_07_15" value="${cntTimeTeamSum_07_15+cntTime07_15}"></c:set>
			            <c:set var="cntTimeTeamSum_06_15" value="${cntTimeTeamSum_06_15+cntTime06_15}"></c:set>
			            <c:set var="cntTimeTeamSum_05_15" value="${cntTimeTeamSum_05_15+cntTime05_15}"></c:set>
			            <c:set var="cntTimeTeamSum_04_15" value="${cntTimeTeamSum_04_15+cntTime04_15}"></c:set>
			            <c:set var="cntTimeTeamSum_03_15" value="${cntTimeTeamSum_03_15+cntTime03_15}"></c:set>
			            <c:set var="cntTimeTeamSum_02_15" value="${cntTimeTeamSum_02_15+cntTime02_15}"></c:set>
			            <c:set var="cntTimeTeamSum_01_15" value="${cntTimeTeamSum_01_15+cntTime01_15}"></c:set>
			            
			            <!-- 팀별 계 평균용 변수 -->
						<c:set var="timeTeamSum_12_15" value="${timeTeamSum_12_15+time12_15}"></c:set>
			            <c:set var="timeTeamSum_11_15" value="${timeTeamSum_11_15+time11_15}"></c:set>
			            <c:set var="timeTeamSum_10_15" value="${timeTeamSum_10_15+time10_15}"></c:set>
			            <c:set var="timeTeamSum_09_15" value="${timeTeamSum_09_15+time09_15}"></c:set>
			            <c:set var="timeTeamSum_08_15" value="${timeTeamSum_08_15+time08_15}"></c:set>
			            <c:set var="timeTeamSum_07_15" value="${timeTeamSum_07_15+time07_15}"></c:set>
			            <c:set var="timeTeamSum_06_15" value="${timeTeamSum_06_15+time06_15}"></c:set>
			            <c:set var="timeTeamSum_05_15" value="${timeTeamSum_05_15+time05_15}"></c:set>
			            <c:set var="timeTeamSum_04_15" value="${timeTeamSum_04_15+time04_15}"></c:set>
			            <c:set var="timeTeamSum_03_15" value="${timeTeamSum_03_15+time03_15}"></c:set>
			            <c:set var="timeTeamSum_02_15" value="${timeTeamSum_02_15+time02_15}"></c:set>
			            <c:set var="timeTeamSum_01_15" value="${timeTeamSum_01_15+time01_15}"></c:set>
				    
						<c:set var="endTeamSum_12_15" value="${endTeamSum_12_15+end12_15}"></c:set>
			            <c:set var="endTeamSum_11_15" value="${endTeamSum_11_15+end11_15}"></c:set>
			            <c:set var="endTeamSum_10_15" value="${endTeamSum_10_15+end10_15}"></c:set>
			            <c:set var="endTeamSum_09_15" value="${endTeamSum_09_15+end09_15}"></c:set>
			            <c:set var="endTeamSum_08_15" value="${endTeamSum_08_15+end08_15}"></c:set>
			            <c:set var="endTeamSum_07_15" value="${endTeamSum_07_15+end07_15}"></c:set>
			            <c:set var="endTeamSum_06_15" value="${endTeamSum_06_15+end06_15}"></c:set>
			            <c:set var="endTeamSum_05_15" value="${endTeamSum_05_15+end05_15}"></c:set>
			            <c:set var="endTeamSum_04_15" value="${endTeamSum_04_15+end04_15}"></c:set>
			            <c:set var="endTeamSum_03_15" value="${endTeamSum_03_15+end03_15}"></c:set>
			            <c:set var="endTeamSum_02_15" value="${endTeamSum_02_15+end02_15}"></c:set>
			            <c:set var="endTeamSum_01_15" value="${endTeamSum_01_15+end01_15}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="cntTimeTeamTotalSum_12_15" value="${cntTimeTeamTotalSum_12_15 + cntTime12_15}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_11_15" value="${cntTimeTeamTotalSum_11_15 + cntTime11_15}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_10_15" value="${cntTimeTeamTotalSum_10_15 + cntTime10_15}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_09_15" value="${cntTimeTeamTotalSum_09_15 + cntTime09_15}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_08_15" value="${cntTimeTeamTotalSum_08_15 + cntTime08_15}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_07_15" value="${cntTimeTeamTotalSum_07_15 + cntTime07_15}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_06_15" value="${cntTimeTeamTotalSum_06_15 + cntTime06_15}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_05_15" value="${cntTimeTeamTotalSum_05_15 + cntTime05_15}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_04_15" value="${cntTimeTeamTotalSum_04_15 + cntTime04_15}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_03_15" value="${cntTimeTeamTotalSum_03_15 + cntTime03_15}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_02_15" value="${cntTimeTeamTotalSum_02_15 + cntTime02_15}"></c:set>
	                    <c:set var="cntTimeTeamTotalSum_01_15" value="${cntTimeTeamTotalSum_01_15 + cntTime01_15}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="timeTeamTotalSum_12_15" value="${timeTeamTotalSum_12_15 + time12_15}"></c:set>
	                    <c:set var="timeTeamTotalSum_11_15" value="${timeTeamTotalSum_11_15 + time11_15}"></c:set>
	                    <c:set var="timeTeamTotalSum_10_15" value="${timeTeamTotalSum_10_15 + time10_15}"></c:set>
	                    <c:set var="timeTeamTotalSum_09_15" value="${timeTeamTotalSum_09_15 + time09_15}"></c:set>
	                    <c:set var="timeTeamTotalSum_08_15" value="${timeTeamTotalSum_08_15 + time08_15}"></c:set>
	                    <c:set var="timeTeamTotalSum_07_15" value="${timeTeamTotalSum_07_15 + time07_15}"></c:set>
	                    <c:set var="timeTeamTotalSum_06_15" value="${timeTeamTotalSum_06_15 + time06_15}"></c:set>
	                    <c:set var="timeTeamTotalSum_05_15" value="${timeTeamTotalSum_05_15 + time05_15}"></c:set>
	                    <c:set var="timeTeamTotalSum_04_15" value="${timeTeamTotalSum_04_15 + time04_15}"></c:set>
	                    <c:set var="timeTeamTotalSum_03_15" value="${timeTeamTotalSum_03_15 + time03_15}"></c:set>
	                    <c:set var="timeTeamTotalSum_02_15" value="${timeTeamTotalSum_02_15 + time02_15}"></c:set>
	                    <c:set var="timeTeamTotalSum_01_15" value="${timeTeamTotalSum_01_15 + time01_15}"></c:set>

						<c:set var="endTeamTotalSum_12_15" value="${endTeamTotalSum_12_15 + end12_15}"></c:set>
	                    <c:set var="endTeamTotalSum_11_15" value="${endTeamTotalSum_11_15 + end11_15}"></c:set>
	                    <c:set var="endTeamTotalSum_10_15" value="${endTeamTotalSum_10_15 + end10_15}"></c:set>
	                    <c:set var="endTeamTotalSum_09_15" value="${endTeamTotalSum_09_15 + end09_15}"></c:set>
	                    <c:set var="endTeamTotalSum_08_15" value="${endTeamTotalSum_08_15 + end08_15}"></c:set>
	                    <c:set var="endTeamTotalSum_07_15" value="${endTeamTotalSum_07_15 + end07_15}"></c:set>
	                    <c:set var="endTeamTotalSum_06_15" value="${endTeamTotalSum_06_15 + end06_15}"></c:set>
	                    <c:set var="endTeamTotalSum_05_15" value="${endTeamTotalSum_05_15 + end05_15}"></c:set>
	                    <c:set var="endTeamTotalSum_04_15" value="${endTeamTotalSum_04_15 + end04_15}"></c:set>
	                    <c:set var="endTeamTotalSum_03_15" value="${endTeamTotalSum_03_15 + end03_15}"></c:set>
	                    <c:set var="endTeamTotalSum_02_15" value="${endTeamTotalSum_02_15 + end02_15}"></c:set>
	                    <c:set var="endTeamTotalSum_01_15" value="${endTeamTotalSum_01_15 + end01_15}"></c:set>
		    		</tr>
		    		<!-- 팀별 소계 시작 -->
		    		
		    		<!-- 팀별 평균 계산 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo2.rowCnt and vo2.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">${vo2.teamName} 평균</td>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_12_15 eq 0 or endTeamSum_12_15 eq 0}">
		    						<c:set var="arvTeamSum_12_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_12_15" value="${timeTeamSum_12_15 / endTeamSum_12_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_11_15 eq 0 or endTeamSum_11_15 eq 0}">
		    						<c:set var="arvTeamSum_11_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_11_15" value="${timeTeamSum_11_15 / endTeamSum_11_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_10_15 eq 0 or endTeamSum_10_15 eq 0}">
		    						<c:set var="arvTeamSum_10_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_10_15" value="${timeTeamSum_10_15 / endTeamSum_10_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_09_15 eq 0 or endTeamSum_09_15 eq 0}">
		    						<c:set var="arvTeamSum_09_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_09_15" value="${timeTeamSum_09_15 / endTeamSum_09_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_08_15 eq 0 or endTeamSum_08_15 eq 0}">
		    						<c:set var="arvTeamSum_08_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_08_15" value="${timeTeamSum_08_15 / endTeamSum_08_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_07_15 eq 0 or endTeamSum_07_15 eq 0}">
		    						<c:set var="arvTeamSum_07_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_07_15" value="${timeTeamSum_07_15 / endTeamSum_07_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_06_15 eq 0 or endTeamSum_06_15 eq 0}">
		    						<c:set var="arvTeamSum_06_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_06_15" value="${timeTeamSum_06_15 / endTeamSum_06_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_05_15 eq 0 or endTeamSum_05_15 eq 0}">
		    						<c:set var="arvTeamSum_05_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_05_15" value="${timeTeamSum_05_15 / endTeamSum_05_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_04_15 eq 0 or endTeamSum_04_15 eq 0}">
		    						<c:set var="arvTeamSum_04_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_04_15" value="${timeTeamSum_04_15 / endTeamSum_04_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_03_15 eq 0 or endTeamSum_03_15 eq 0}">
		    						<c:set var="arvTeamSum_03_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_03_15" value="${timeTeamSum_03_15 / endTeamSum_03_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_02_15 eq 0 or endTeamSum_02_15 eq 0}">
		    						<c:set var="arvTeamSum_02_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_02_15" value="${timeTeamSum_02_15 / endTeamSum_02_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamSum_01_15 eq 0 or endTeamSum_01_15 eq 0}">
		    						<c:set var="arvTeamSum_01_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_01_15" value="${timeTeamSum_01_15 / endTeamSum_01_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 팀별 평균 계산 끝 -->
		    						    				
		    				<!-- cntTime12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_12_15}" pattern="#,##0.##"/></td>
		    				<!-- cntTime11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_11_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_10_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_09_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_08_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_07_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_06_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_05_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_04_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_03_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_02_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_01_15}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="timeTeamColSum_15" value="${timeTeamSum_12_15 + timeTeamSum_11_15 + timeTeamSum_10_15 + timeTeamSum_09_15 + timeTeamSum_08_15 + timeTeamSum_07_15 + timeTeamSum_06_15 + timeTeamSum_05_15 + timeTeamSum_04_15 + timeTeamSum_03_15 + timeTeamSum_02_15 + timeTeamSum_01_15}"></c:set>
			                <c:set var="endTeamColSum_15" value="${endTeamSum_12_15 + endTeamSum_11_15 + endTeamSum_10_15 + endTeamSum_09_15 + endTeamSum_08_15 + endTeamSum_07_15 + endTeamSum_06_15 + endTeamSum_05_15 + endTeamSum_04_15 + endTeamSum_03_15 + endTeamSum_02_15 + endTeamSum_01_15}"></c:set>			                
			                <c:choose>
			                	<c:when test="${timeTeamColSum_15 eq 0 or endTeamColSum_15 eq 0}">
			                		<c:set var="arvTeamColSum_15" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvTeamColSum_15" value="${timeTeamColSum_15 / endTeamColSum_15}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamColSum_15}" pattern="#,##0.##"/></td>
		    				
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="cntTimeTeamSum_12_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_11_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_10_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_09_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_08_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_07_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_06_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_05_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_04_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_03_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_02_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_01_15" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="timeTeamSum_12_15" value="0"></c:set>
							<c:set var="timeTeamSum_11_15" value="0"></c:set>
							<c:set var="timeTeamSum_10_15" value="0"></c:set>
							<c:set var="timeTeamSum_09_15" value="0"></c:set>
							<c:set var="timeTeamSum_08_15" value="0"></c:set>
							<c:set var="timeTeamSum_07_15" value="0"></c:set>
							<c:set var="timeTeamSum_06_15" value="0"></c:set>
							<c:set var="timeTeamSum_05_15" value="0"></c:set>
							<c:set var="timeTeamSum_04_15" value="0"></c:set>
							<c:set var="timeTeamSum_03_15" value="0"></c:set>
							<c:set var="timeTeamSum_02_15" value="0"></c:set>
							<c:set var="timeTeamSum_01_15" value="0"></c:set>
											    
							<c:set var="endTeamSum_12_15" value="0"></c:set>
							<c:set var="endTeamSum_11_15" value="0"></c:set>
							<c:set var="endTeamSum_10_15" value="0"></c:set>
							<c:set var="endTeamSum_09_15" value="0"></c:set>
							<c:set var="endTeamSum_08_15" value="0"></c:set>
							<c:set var="endTeamSum_07_15" value="0"></c:set>
							<c:set var="endTeamSum_06_15" value="0"></c:set>
							<c:set var="endTeamSum_05_15" value="0"></c:set>
							<c:set var="endTeamSum_04_15" value="0"></c:set>
							<c:set var="endTeamSum_03_15" value="0"></c:set>
							<c:set var="endTeamSum_02_15" value="0"></c:set>
							<c:set var="endTeamSum_01_15" value="0"></c:set>				            				            
		    			</c:when>
		    			<c:when test="${vo2.rowCnt == 1}">
		    				<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="cntTimeTeamSum_12_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_11_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_10_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_09_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_08_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_07_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_06_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_05_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_04_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_03_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_02_15" value="0"></c:set>
				            <c:set var="cntTimeTeamSum_01_15" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="timeTeamSum_12_15" value="0"></c:set>
							<c:set var="timeTeamSum_11_15" value="0"></c:set>
							<c:set var="timeTeamSum_10_15" value="0"></c:set>
							<c:set var="timeTeamSum_09_15" value="0"></c:set>
							<c:set var="timeTeamSum_08_15" value="0"></c:set>
							<c:set var="timeTeamSum_07_15" value="0"></c:set>
							<c:set var="timeTeamSum_06_15" value="0"></c:set>
							<c:set var="timeTeamSum_05_15" value="0"></c:set>
							<c:set var="timeTeamSum_04_15" value="0"></c:set>
							<c:set var="timeTeamSum_03_15" value="0"></c:set>
							<c:set var="timeTeamSum_02_15" value="0"></c:set>
							<c:set var="timeTeamSum_01_15" value="0"></c:set>
											    
							<c:set var="endTeamSum_12_15" value="0"></c:set>
							<c:set var="endTeamSum_11_15" value="0"></c:set>
							<c:set var="endTeamSum_10_15" value="0"></c:set>
							<c:set var="endTeamSum_09_15" value="0"></c:set>
							<c:set var="endTeamSum_08_15" value="0"></c:set>
							<c:set var="endTeamSum_07_15" value="0"></c:set>
							<c:set var="endTeamSum_06_15" value="0"></c:set>
							<c:set var="endTeamSum_05_15" value="0"></c:set>
							<c:set var="endTeamSum_04_15" value="0"></c:set>
							<c:set var="endTeamSum_03_15" value="0"></c:set>
							<c:set var="endTeamSum_02_15" value="0"></c:set>
							<c:set var="endTeamSum_01_15" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 팀별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 팀별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 기타 소계 시작 -->
		    	<c:if test="${ptnrStatCntTimeList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 기타 평균</th>
	                <c:choose>
    					<c:when test="${timeTeamTotalSum_12_15 eq 0 or endTeamTotalSum_12_15 eq 0}">
    						<c:set var="arvTeamTotalSum_12_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_12_15" value="${timeTeamTotalSum_12_15 / endTeamTotalSum_12_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_11_15 eq 0 or endTeamTotalSum_11_15 eq 0}">
    						<c:set var="arvTeamTotalSum_11_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_11_15" value="${timeTeamTotalSum_11_15 / endTeamTotalSum_11_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_10_15 eq 0 or endTeamTotalSum_10_15 eq 0}">
    						<c:set var="arvTeamTotalSum_10_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_10_15" value="${timeTeamTotalSum_10_15 / endTeamTotalSum_10_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_09_15 eq 0 or endTeamTotalSum_09_15 eq 0}">
    						<c:set var="arvTeamTotalSum_09_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_09_15" value="${timeTeamTotalSum_09_15 / endTeamTotalSum_09_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_08_15 eq 0 or endTeamTotalSum_08_15 eq 0}">
    						<c:set var="arvTeamTotalSum_08_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_08_15" value="${timeTeamTotalSum_08_15 / endTeamTotalSum_08_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_07_15 eq 0 or endTeamTotalSum_07_15 eq 0}">
    						<c:set var="arvTeamTotalSum_07_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_07_15" value="${timeTeamTotalSum_07_15 / endTeamTotalSum_07_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_06_15 eq 0 or endTeamTotalSum_06_15 eq 0}">
    						<c:set var="arvTeamTotalSum_06_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_06_15" value="${timeTeamTotalSum_06_15 / endTeamTotalSum_06_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_05_15 eq 0 or endTeamTotalSum_05_15 eq 0}">
    						<c:set var="arvTeamTotalSum_05_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_05_15" value="${timeTeamTotalSum_05_15 / endTeamTotalSum_05_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_04_15 eq 0 or endTeamTotalSum_04_15 eq 0}">
    						<c:set var="arvTeamTotalSum_04_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_04_15" value="${timeTeamTotalSum_04_15 / endTeamTotalSum_04_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_03_15 eq 0 or endTeamTotalSum_03_15 eq 0}">
    						<c:set var="arvTeamTotalSum_03_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_03_15" value="${timeTeamTotalSum_03_15 / endTeamTotalSum_03_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_02_15 eq 0 or endTeamTotalSum_02_15 eq 0}">
    						<c:set var="arvTeamTotalSum_02_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_02_15" value="${timeTeamTotalSum_02_15 / endTeamTotalSum_02_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamTotalSum_01_15 eq 0 or endTeamTotalSum_01_15 eq 0}">
    						<c:set var="arvTeamTotalSum_01_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_01_15" value="${timeTeamTotalSum_01_15 / endTeamTotalSum_01_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 팀별 평균 계산 끝 -->
    						    				
    				<!-- cntTime12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_12_15}" pattern="#,##0.##"/></th>
    				<!-- cntTime11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_11_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_10_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_09_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_08_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_07_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_06_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_05_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_04_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_03_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_02_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_01_15}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="timeColTeamTotalSum_15" value="${timeTeamTotalSum_12_15 + timeTeamTotalSum_11_15 + timeTeamTotalSum_10_15 + timeTeamTotalSum_09_15 + timeTeamTotalSum_08_15 + timeTeamTotalSum_07_15 + timeTeamTotalSum_06_15 + timeTeamTotalSum_05_15 + timeTeamTotalSum_04_15 + timeTeamTotalSum_03_15 + timeTeamTotalSum_02_15 + timeTeamTotalSum_01_15}"></c:set>
	                <c:set var="endColTeamTotalSum_15" value="${endTeamTotalSum_12_15 + endTeamTotalSum_11_15 + endTeamTotalSum_10_15 + endTeamTotalSum_09_15 + endTeamTotalSum_08_15 + endTeamTotalSum_07_15 + endTeamTotalSum_06_15 + endTeamTotalSum_05_15 + endTeamTotalSum_04_15 + endTeamTotalSum_03_15 + endTeamTotalSum_02_15 + endTeamTotalSum_01_15}"></c:set>
					<c:choose>
	                	<c:when test="${timeColTeamTotalSum_15 eq 0 or endColTeamTotalSum_15 eq 0}">
	                		<c:set var="arvColTeamTotalSum_15" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColTeamTotalSum_15" value="${timeColTeamTotalSum_15 / endColTeamTotalSum_15}"/>
	                	</c:otherwise>
					</c:choose>
	                
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvColTeamTotalSum_15}" pattern="#,##0.##"/></th>
	            </tr>
	            </c:if>
		    	<!-- 1종 기타 소계 끝 -->
    		</tbody>
    	</table>
    	<!-- 1종 기타 끝 -->  	        
    </div>    
    <!-- 총 합계 시작 -->
    <!-- 총 합계 변수 시작 -->
    <c:set var="cntTimeTeamTotalSum_12_all" value="${cntTimeTeamTotalSum_12_5 + cntTimeTeamTotalSum_12_10 + cntTimeTeamTotalSum_12_15}"></c:set>
    <c:set var="cntTimeTeamTotalSum_11_all" value="${cntTimeTeamTotalSum_11_5 + cntTimeTeamTotalSum_11_10 + cntTimeTeamTotalSum_11_15}"></c:set>
    <c:set var="cntTimeTeamTotalSum_10_all" value="${cntTimeTeamTotalSum_10_5 + cntTimeTeamTotalSum_10_10 + cntTimeTeamTotalSum_10_15}"></c:set>
    <c:set var="cntTimeTeamTotalSum_09_all" value="${cntTimeTeamTotalSum_09_5 + cntTimeTeamTotalSum_09_10 + cntTimeTeamTotalSum_09_15}"></c:set>
    <c:set var="cntTimeTeamTotalSum_08_all" value="${cntTimeTeamTotalSum_08_5 + cntTimeTeamTotalSum_08_10 + cntTimeTeamTotalSum_08_15}"></c:set>
    <c:set var="cntTimeTeamTotalSum_07_all" value="${cntTimeTeamTotalSum_07_5 + cntTimeTeamTotalSum_07_10 + cntTimeTeamTotalSum_07_15}"></c:set>
    <c:set var="cntTimeTeamTotalSum_06_all" value="${cntTimeTeamTotalSum_06_5 + cntTimeTeamTotalSum_06_10 + cntTimeTeamTotalSum_06_15}"></c:set>
    <c:set var="cntTimeTeamTotalSum_05_all" value="${cntTimeTeamTotalSum_05_5 + cntTimeTeamTotalSum_05_10 + cntTimeTeamTotalSum_05_15}"></c:set>
    <c:set var="cntTimeTeamTotalSum_04_all" value="${cntTimeTeamTotalSum_04_5 + cntTimeTeamTotalSum_04_10 + cntTimeTeamTotalSum_04_15}"></c:set>
    <c:set var="cntTimeTeamTotalSum_03_all" value="${cntTimeTeamTotalSum_03_5 + cntTimeTeamTotalSum_03_10 + cntTimeTeamTotalSum_03_15}"></c:set>
    <c:set var="cntTimeTeamTotalSum_02_all" value="${cntTimeTeamTotalSum_02_5 + cntTimeTeamTotalSum_02_10 + cntTimeTeamTotalSum_02_15}"></c:set>
    <c:set var="cntTimeTeamTotalSum_01_all" value="${cntTimeTeamTotalSum_01_5 + cntTimeTeamTotalSum_01_10 + cntTimeTeamTotalSum_01_15}"></c:set>        
    <c:set var="cntTimeTeamTotalSum_col_all" value="${cntTimeTeamTotalSum_12_all + cntTimeTeamTotalSum_11_all + cntTimeTeamTotalSum_10_all + cntTimeTeamTotalSum_09_all + cntTimeTeamTotalSum_08_all + cntTimeTeamTotalSum_07_all + cntTimeTeamTotalSum_06_all + cntTimeTeamTotalSum_05_all + cntTimeTeamTotalSum_04_all + cntTimeTeamTotalSum_03_all + cntTimeTeamTotalSum_02_all + cntTimeTeamTotalSum_01_all}"></c:set>
    
    <c:set var="timeTeamTotalSum_12_all" value="${timeTeamTotalSum_12_5 + timeTeamTotalSum_12_10 + timeTeamTotalSum_12_15}"></c:set>
    <c:set var="timeTeamTotalSum_11_all" value="${timeTeamTotalSum_11_5 + timeTeamTotalSum_11_10 + timeTeamTotalSum_11_15}"></c:set>
    <c:set var="timeTeamTotalSum_10_all" value="${timeTeamTotalSum_10_5 + timeTeamTotalSum_10_10 + timeTeamTotalSum_10_15}"></c:set>
    <c:set var="timeTeamTotalSum_09_all" value="${timeTeamTotalSum_09_5 + timeTeamTotalSum_09_10 + timeTeamTotalSum_09_15}"></c:set>
    <c:set var="timeTeamTotalSum_08_all" value="${timeTeamTotalSum_08_5 + timeTeamTotalSum_08_10 + timeTeamTotalSum_08_15}"></c:set>
    <c:set var="timeTeamTotalSum_07_all" value="${timeTeamTotalSum_07_5 + timeTeamTotalSum_07_10 + timeTeamTotalSum_07_15}"></c:set>
    <c:set var="timeTeamTotalSum_06_all" value="${timeTeamTotalSum_06_5 + timeTeamTotalSum_06_10 + timeTeamTotalSum_06_15}"></c:set>
    <c:set var="timeTeamTotalSum_05_all" value="${timeTeamTotalSum_05_5 + timeTeamTotalSum_05_10 + timeTeamTotalSum_05_15}"></c:set>
    <c:set var="timeTeamTotalSum_04_all" value="${timeTeamTotalSum_04_5 + timeTeamTotalSum_04_10 + timeTeamTotalSum_04_15}"></c:set>
    <c:set var="timeTeamTotalSum_03_all" value="${timeTeamTotalSum_03_5 + timeTeamTotalSum_03_10 + timeTeamTotalSum_03_15}"></c:set>
    <c:set var="timeTeamTotalSum_02_all" value="${timeTeamTotalSum_02_5 + timeTeamTotalSum_02_10 + timeTeamTotalSum_02_15}"></c:set>
    <c:set var="timeTeamTotalSum_01_all" value="${timeTeamTotalSum_01_5 + timeTeamTotalSum_01_10 + timeTeamTotalSum_01_15}"></c:set>
    
    <c:set var="endTeamTotalSum_12_all" value="${endTeamTotalSum_12_5 + endTeamTotalSum_12_10 + endTeamTotalSum_12_15}"></c:set>
    <c:set var="endTeamTotalSum_11_all" value="${endTeamTotalSum_11_5 + endTeamTotalSum_11_10 + endTeamTotalSum_11_15}"></c:set>
    <c:set var="endTeamTotalSum_10_all" value="${endTeamTotalSum_10_5 + endTeamTotalSum_10_10 + endTeamTotalSum_10_15}"></c:set>
    <c:set var="endTeamTotalSum_09_all" value="${endTeamTotalSum_09_5 + endTeamTotalSum_09_10 + endTeamTotalSum_09_15}"></c:set>
    <c:set var="endTeamTotalSum_08_all" value="${endTeamTotalSum_08_5 + endTeamTotalSum_08_10 + endTeamTotalSum_08_15}"></c:set>
    <c:set var="endTeamTotalSum_07_all" value="${endTeamTotalSum_07_5 + endTeamTotalSum_07_10 + endTeamTotalSum_07_15}"></c:set>
    <c:set var="endTeamTotalSum_06_all" value="${endTeamTotalSum_06_5 + endTeamTotalSum_06_10 + endTeamTotalSum_06_15}"></c:set>
    <c:set var="endTeamTotalSum_05_all" value="${endTeamTotalSum_05_5 + endTeamTotalSum_05_10 + endTeamTotalSum_05_15}"></c:set>
    <c:set var="endTeamTotalSum_04_all" value="${endTeamTotalSum_04_5 + endTeamTotalSum_04_10 + endTeamTotalSum_04_15}"></c:set>
    <c:set var="endTeamTotalSum_03_all" value="${endTeamTotalSum_03_5 + endTeamTotalSum_03_10 + endTeamTotalSum_03_15}"></c:set>
    <c:set var="endTeamTotalSum_02_all" value="${endTeamTotalSum_02_5 + endTeamTotalSum_02_10 + endTeamTotalSum_02_15}"></c:set>
    <c:set var="endTeamTotalSum_01_all" value="${endTeamTotalSum_01_5 + endTeamTotalSum_01_10 + endTeamTotalSum_01_15}"></c:set>
    
    <c:choose>
		<c:when test="${timeTeamTotalSum_12_all eq 0 or endTeamTotalSum_12_all eq 0}">
			<c:set var="arvTeamTotalSum_12_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_12_all" value="${timeTeamTotalSum_12_all / endTeamTotalSum_12_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamTotalSum_11_all eq 0 or endTeamTotalSum_11_all eq 0}">
			<c:set var="arvTeamTotalSum_11_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_11_all" value="${timeTeamTotalSum_11_all / endTeamTotalSum_11_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamTotalSum_10_all eq 0 or endTeamTotalSum_10_all eq 0}">
			<c:set var="arvTeamTotalSum_10_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_10_all" value="${timeTeamTotalSum_10_all / endTeamTotalSum_10_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamTotalSum_09_all eq 0 or endTeamTotalSum_09_all eq 0}">
			<c:set var="arvTeamTotalSum_09_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_09_all" value="${timeTeamTotalSum_09_all / endTeamTotalSum_09_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamTotalSum_08_all eq 0 or endTeamTotalSum_08_all eq 0}">
			<c:set var="arvTeamTotalSum_08_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_08_all" value="${timeTeamTotalSum_08_all / endTeamTotalSum_08_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamTotalSum_07_all eq 0 or endTeamTotalSum_07_all eq 0}">
			<c:set var="arvTeamTotalSum_07_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_07_all" value="${timeTeamTotalSum_07_all / endTeamTotalSum_07_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamTotalSum_06_all eq 0 or endTeamTotalSum_06_all eq 0}">
			<c:set var="arvTeamTotalSum_06_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_06_all" value="${timeTeamTotalSum_06_all / endTeamTotalSum_06_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamTotalSum_05_all eq 0 or endTeamTotalSum_05_all eq 0}">
			<c:set var="arvTeamTotalSum_05_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_05_all" value="${timeTeamTotalSum_05_all / endTeamTotalSum_05_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamTotalSum_04_all eq 0 or endTeamTotalSum_04_all eq 0}">
			<c:set var="arvTeamTotalSum_04_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_04_all" value="${timeTeamTotalSum_04_all / endTeamTotalSum_04_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamTotalSum_03_all eq 0 or endTeamTotalSum_03_all eq 0}">
			<c:set var="arvTeamTotalSum_03_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_03_all" value="${timeTeamTotalSum_03_all / endTeamTotalSum_03_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamTotalSum_02_all eq 0 or endTeamTotalSum_02_all eq 0}">
			<c:set var="arvTeamTotalSum_02_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_02_all" value="${timeTeamTotalSum_02_all / endTeamTotalSum_02_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamTotalSum_01_all eq 0 or endTeamTotalSum_01_all eq 0}">
			<c:set var="arvTeamTotalSum_01_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_01_all" value="${timeTeamTotalSum_01_all / endTeamTotalSum_01_all}"></c:set>
		</c:otherwise>
	</c:choose>
	
	<!-- 가로 합계 -->
	<c:set var="timeColTeamTotalSum_all" value="${timeTeamTotalSum_12_all + timeTeamTotalSum_11_all + timeTeamTotalSum_10_all + timeTeamTotalSum_09_all + timeTeamTotalSum_08_all + timeTeamTotalSum_07_all + timeTeamTotalSum_06_all + timeTeamTotalSum_05_all + timeTeamTotalSum_04_all + timeTeamTotalSum_03_all + timeTeamTotalSum_02_all + timeTeamTotalSum_01_all}"></c:set>
	<c:set var="endColTeamTotalSum_all" value="${endTeamTotalSum_12_all + endTeamTotalSum_11_all + endTeamTotalSum_10_all + endTeamTotalSum_09_all + endTeamTotalSum_08_all + endTeamTotalSum_07_all + endTeamTotalSum_06_all + endTeamTotalSum_05_all + endTeamTotalSum_04_all + endTeamTotalSum_03_all + endTeamTotalSum_02_all + endTeamTotalSum_01_all}"></c:set>
	<c:choose>
		<c:when test="${timeColTeamTotalSum_all eq 0 or endColTeamTotalSum_all eq 0}">
			<c:set var="arvColTeamTotalSum_all" value="0"/>
		</c:when>
		<c:otherwise>
			<c:set var="arvColTeamTotalSum_all" value="${timeColTeamTotalSum_all / endColTeamTotalSum_all}"/>
		</c:otherwise>
	</c:choose>
	    
    <!-- 총 합계 변수 끝 -->
    <div style="background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체평균</th>    			    			
    			<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamTotalSum_01_all}" pattern="#,##0.##"/></th>				    			
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvColTeamTotalSum_all}" pattern="#,##0.##"/></th>
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>