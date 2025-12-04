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
   				<c:set var="preTeamAllName" value=""></c:set>
   				
   				<!-- 팀별 계 -->
	            <c:set var="cntTimeTeamAllSum_12_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_11_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_10_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_09_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_08_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_07_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_06_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_05_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_04_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_03_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_02_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_01_5" value="0"></c:set>
	            
	            <!-- 팀별 평균 계 초기화 -->
				<c:set var="timeTeamAllSum_12_5" value="0"></c:set>
				<c:set var="timeTeamAllSum_11_5" value="0"></c:set>
				<c:set var="timeTeamAllSum_10_5" value="0"></c:set>
				<c:set var="timeTeamAllSum_09_5" value="0"></c:set>
				<c:set var="timeTeamAllSum_08_5" value="0"></c:set>
				<c:set var="timeTeamAllSum_07_5" value="0"></c:set>
				<c:set var="timeTeamAllSum_06_5" value="0"></c:set>
				<c:set var="timeTeamAllSum_05_5" value="0"></c:set>
				<c:set var="timeTeamAllSum_04_5" value="0"></c:set>
				<c:set var="timeTeamAllSum_03_5" value="0"></c:set>
				<c:set var="timeTeamAllSum_02_5" value="0"></c:set>
				<c:set var="timeTeamAllSum_01_5" value="0"></c:set>
								    
				<c:set var="endTeamAllSum_12_5" value="0"></c:set>
				<c:set var="endTeamAllSum_11_5" value="0"></c:set>
				<c:set var="endTeamAllSum_10_5" value="0"></c:set>
				<c:set var="endTeamAllSum_09_5" value="0"></c:set>
				<c:set var="endTeamAllSum_08_5" value="0"></c:set>
				<c:set var="endTeamAllSum_07_5" value="0"></c:set>
				<c:set var="endTeamAllSum_06_5" value="0"></c:set>
				<c:set var="endTeamAllSum_05_5" value="0"></c:set>
				<c:set var="endTeamAllSum_04_5" value="0"></c:set>
				<c:set var="endTeamAllSum_03_5" value="0"></c:set>
				<c:set var="endTeamAllSum_02_5" value="0"></c:set>
				<c:set var="endTeamAllSum_01_5" value="0"></c:set>
				
	            <!-- Type 별 총 합계 -->
	            <c:set var="cntTimeTeamAllTotalSum_12_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_11_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_10_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_09_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_08_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_07_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_06_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_05_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_04_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_03_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_02_5" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_01_5" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntTimeColTeamAllTotalSum_5" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="timeTeamAllTotalSum_12_5" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_11_5" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_10_5" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_09_5" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_08_5" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_07_5" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_06_5" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_05_5" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_04_5" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_03_5" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_02_5" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_01_5" value="0"></c:set>
				
				<c:set var="endTeamAllTotalSum_12_5" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_11_5" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_10_5" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_09_5" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_08_5" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_07_5" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_06_5" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_05_5" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_04_5" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_03_5" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_02_5" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_01_5" value="0"></c:set>	            
   				    			
    			<c:forEach var="vo" items="${ptnrStatTeamAllCntTimeList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCntTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowTeamAll}">
		                    	1종 조사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo.rowCnt == 1}">
		                		<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>		                				                		
		                		<td onclick="goPtnrStatMember(${vo.ptnrId},${vo.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.teamName}</td>
		                		<td style="width:150px;">${vo.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="cntTimeTeamAllSum_12_5" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_11_5" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_10_5" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_09_5" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_08_5" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_07_5" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_06_5" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_05_5" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_04_5" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_03_5" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_02_5" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_01_5" value="0"></c:set>
					            
					            <!-- 팀별 평균 계 초기화 -->
								<c:set var="timeTeamAllSum_12_5" value="0"></c:set>
								<c:set var="timeTeamAllSum_11_5" value="0"></c:set>
								<c:set var="timeTeamAllSum_10_5" value="0"></c:set>
								<c:set var="timeTeamAllSum_09_5" value="0"></c:set>
								<c:set var="timeTeamAllSum_08_5" value="0"></c:set>
								<c:set var="timeTeamAllSum_07_5" value="0"></c:set>
								<c:set var="timeTeamAllSum_06_5" value="0"></c:set>
								<c:set var="timeTeamAllSum_05_5" value="0"></c:set>
								<c:set var="timeTeamAllSum_04_5" value="0"></c:set>
								<c:set var="timeTeamAllSum_03_5" value="0"></c:set>
								<c:set var="timeTeamAllSum_02_5" value="0"></c:set>
								<c:set var="timeTeamAllSum_01_5" value="0"></c:set>
												    
								<c:set var="endTeamAllSum_12_5" value="0"></c:set>
								<c:set var="endTeamAllSum_11_5" value="0"></c:set>
								<c:set var="endTeamAllSum_10_5" value="0"></c:set>
								<c:set var="endTeamAllSum_09_5" value="0"></c:set>
								<c:set var="endTeamAllSum_08_5" value="0"></c:set>
								<c:set var="endTeamAllSum_07_5" value="0"></c:set>
								<c:set var="endTeamAllSum_06_5" value="0"></c:set>
								<c:set var="endTeamAllSum_05_5" value="0"></c:set>
								<c:set var="endTeamAllSum_04_5" value="0"></c:set>
								<c:set var="endTeamAllSum_03_5" value="0"></c:set>
								<c:set var="endTeamAllSum_02_5" value="0"></c:set>
								<c:set var="endTeamAllSum_01_5" value="0"></c:set>
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
	    				<c:set var="cntTimeTeamAllSum_12_5" value="${cntTimeTeamAllSum_12_5+cntTime12_5}"></c:set>
			            <c:set var="cntTimeTeamAllSum_11_5" value="${cntTimeTeamAllSum_11_5+cntTime11_5}"></c:set>
			            <c:set var="cntTimeTeamAllSum_10_5" value="${cntTimeTeamAllSum_10_5+cntTime10_5}"></c:set>
			            <c:set var="cntTimeTeamAllSum_09_5" value="${cntTimeTeamAllSum_09_5+cntTime09_5}"></c:set>
			            <c:set var="cntTimeTeamAllSum_08_5" value="${cntTimeTeamAllSum_08_5+cntTime08_5}"></c:set>
			            <c:set var="cntTimeTeamAllSum_07_5" value="${cntTimeTeamAllSum_07_5+cntTime07_5}"></c:set>
			            <c:set var="cntTimeTeamAllSum_06_5" value="${cntTimeTeamAllSum_06_5+cntTime06_5}"></c:set>
			            <c:set var="cntTimeTeamAllSum_05_5" value="${cntTimeTeamAllSum_05_5+cntTime05_5}"></c:set>
			            <c:set var="cntTimeTeamAllSum_04_5" value="${cntTimeTeamAllSum_04_5+cntTime04_5}"></c:set>
			            <c:set var="cntTimeTeamAllSum_03_5" value="${cntTimeTeamAllSum_03_5+cntTime03_5}"></c:set>
			            <c:set var="cntTimeTeamAllSum_02_5" value="${cntTimeTeamAllSum_02_5+cntTime02_5}"></c:set>
			            <c:set var="cntTimeTeamAllSum_01_5" value="${cntTimeTeamAllSum_01_5+cntTime01_5}"></c:set>
			            
			            <!-- 팀별 계 평균용 변수 -->
						<c:set var="timeTeamAllSum_12_5" value="${timeTeamAllSum_12_5+time12_5}"></c:set>
			            <c:set var="timeTeamAllSum_11_5" value="${timeTeamAllSum_11_5+time11_5}"></c:set>
			            <c:set var="timeTeamAllSum_10_5" value="${timeTeamAllSum_10_5+time10_5}"></c:set>
			            <c:set var="timeTeamAllSum_09_5" value="${timeTeamAllSum_09_5+time09_5}"></c:set>
			            <c:set var="timeTeamAllSum_08_5" value="${timeTeamAllSum_08_5+time08_5}"></c:set>
			            <c:set var="timeTeamAllSum_07_5" value="${timeTeamAllSum_07_5+time07_5}"></c:set>
			            <c:set var="timeTeamAllSum_06_5" value="${timeTeamAllSum_06_5+time06_5}"></c:set>
			            <c:set var="timeTeamAllSum_05_5" value="${timeTeamAllSum_05_5+time05_5}"></c:set>
			            <c:set var="timeTeamAllSum_04_5" value="${timeTeamAllSum_04_5+time04_5}"></c:set>
			            <c:set var="timeTeamAllSum_03_5" value="${timeTeamAllSum_03_5+time03_5}"></c:set>
			            <c:set var="timeTeamAllSum_02_5" value="${timeTeamAllSum_02_5+time02_5}"></c:set>
			            <c:set var="timeTeamAllSum_01_5" value="${timeTeamAllSum_01_5+time01_5}"></c:set>
				    
						<c:set var="endTeamAllSum_12_5" value="${endTeamAllSum_12_5+end12_5}"></c:set>
			            <c:set var="endTeamAllSum_11_5" value="${endTeamAllSum_11_5+end11_5}"></c:set>
			            <c:set var="endTeamAllSum_10_5" value="${endTeamAllSum_10_5+end10_5}"></c:set>
			            <c:set var="endTeamAllSum_09_5" value="${endTeamAllSum_09_5+end09_5}"></c:set>
			            <c:set var="endTeamAllSum_08_5" value="${endTeamAllSum_08_5+end08_5}"></c:set>
			            <c:set var="endTeamAllSum_07_5" value="${endTeamAllSum_07_5+end07_5}"></c:set>
			            <c:set var="endTeamAllSum_06_5" value="${endTeamAllSum_06_5+end06_5}"></c:set>
			            <c:set var="endTeamAllSum_05_5" value="${endTeamAllSum_05_5+end05_5}"></c:set>
			            <c:set var="endTeamAllSum_04_5" value="${endTeamAllSum_04_5+end04_5}"></c:set>
			            <c:set var="endTeamAllSum_03_5" value="${endTeamAllSum_03_5+end03_5}"></c:set>
			            <c:set var="endTeamAllSum_02_5" value="${endTeamAllSum_02_5+end02_5}"></c:set>
			            <c:set var="endTeamAllSum_01_5" value="${endTeamAllSum_01_5+end01_5}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="cntTimeTeamAllTotalSum_12_5" value="${cntTimeTeamAllTotalSum_12_5 + cntTime12_5}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_11_5" value="${cntTimeTeamAllTotalSum_11_5 + cntTime11_5}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_10_5" value="${cntTimeTeamAllTotalSum_10_5 + cntTime10_5}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_09_5" value="${cntTimeTeamAllTotalSum_09_5 + cntTime09_5}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_08_5" value="${cntTimeTeamAllTotalSum_08_5 + cntTime08_5}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_07_5" value="${cntTimeTeamAllTotalSum_07_5 + cntTime07_5}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_06_5" value="${cntTimeTeamAllTotalSum_06_5 + cntTime06_5}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_05_5" value="${cntTimeTeamAllTotalSum_05_5 + cntTime05_5}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_04_5" value="${cntTimeTeamAllTotalSum_04_5 + cntTime04_5}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_03_5" value="${cntTimeTeamAllTotalSum_03_5 + cntTime03_5}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_02_5" value="${cntTimeTeamAllTotalSum_02_5 + cntTime02_5}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_01_5" value="${cntTimeTeamAllTotalSum_01_5 + cntTime01_5}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="timeTeamAllTotalSum_12_5" value="${timeTeamAllTotalSum_12_5 + time12_5}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_11_5" value="${timeTeamAllTotalSum_11_5 + time11_5}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_10_5" value="${timeTeamAllTotalSum_10_5 + time10_5}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_09_5" value="${timeTeamAllTotalSum_09_5 + time09_5}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_08_5" value="${timeTeamAllTotalSum_08_5 + time08_5}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_07_5" value="${timeTeamAllTotalSum_07_5 + time07_5}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_06_5" value="${timeTeamAllTotalSum_06_5 + time06_5}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_05_5" value="${timeTeamAllTotalSum_05_5 + time05_5}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_04_5" value="${timeTeamAllTotalSum_04_5 + time04_5}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_03_5" value="${timeTeamAllTotalSum_03_5 + time03_5}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_02_5" value="${timeTeamAllTotalSum_02_5 + time02_5}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_01_5" value="${timeTeamAllTotalSum_01_5 + time01_5}"></c:set>

						<c:set var="endTeamAllTotalSum_12_5" value="${endTeamAllTotalSum_12_5 + end12_5}"></c:set>
	                    <c:set var="endTeamAllTotalSum_11_5" value="${endTeamAllTotalSum_11_5 + end11_5}"></c:set>
	                    <c:set var="endTeamAllTotalSum_10_5" value="${endTeamAllTotalSum_10_5 + end10_5}"></c:set>
	                    <c:set var="endTeamAllTotalSum_09_5" value="${endTeamAllTotalSum_09_5 + end09_5}"></c:set>
	                    <c:set var="endTeamAllTotalSum_08_5" value="${endTeamAllTotalSum_08_5 + end08_5}"></c:set>
	                    <c:set var="endTeamAllTotalSum_07_5" value="${endTeamAllTotalSum_07_5 + end07_5}"></c:set>
	                    <c:set var="endTeamAllTotalSum_06_5" value="${endTeamAllTotalSum_06_5 + end06_5}"></c:set>
	                    <c:set var="endTeamAllTotalSum_05_5" value="${endTeamAllTotalSum_05_5 + end05_5}"></c:set>
	                    <c:set var="endTeamAllTotalSum_04_5" value="${endTeamAllTotalSum_04_5 + end04_5}"></c:set>
	                    <c:set var="endTeamAllTotalSum_03_5" value="${endTeamAllTotalSum_03_5 + end03_5}"></c:set>
	                    <c:set var="endTeamAllTotalSum_02_5" value="${endTeamAllTotalSum_02_5 + end02_5}"></c:set>
	                    <c:set var="endTeamAllTotalSum_01_5" value="${endTeamAllTotalSum_01_5 + end01_5}"></c:set>
		    		</tr>
		    		<!-- 팀별 소계 시작 -->
		    		
		    		<!-- 팀별 평균 계산 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo.rowCnt and vo.rowCnt > 1}">
		    				<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>
		    				<td style="width:150px;" class="sum-level-2">${vo.teamName} 평균</td>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_12_5 eq 0 or endTeamAllSum_12_5 eq 0}">
		    						<c:set var="arvTeamAllSum_12_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_12_5" value="${timeTeamAllSum_12_5 / endTeamAllSum_12_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_11_5 eq 0 or endTeamAllSum_11_5 eq 0}">
		    						<c:set var="arvTeamAllSum_11_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_11_5" value="${timeTeamAllSum_11_5 / endTeamAllSum_11_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_10_5 eq 0 or endTeamAllSum_10_5 eq 0}">
		    						<c:set var="arvTeamAllSum_10_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_10_5" value="${timeTeamAllSum_10_5 / endTeamAllSum_10_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_09_5 eq 0 or endTeamAllSum_09_5 eq 0}">
		    						<c:set var="arvTeamAllSum_09_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_09_5" value="${timeTeamAllSum_09_5 / endTeamAllSum_09_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_08_5 eq 0 or endTeamAllSum_08_5 eq 0}">
		    						<c:set var="arvTeamAllSum_08_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_08_5" value="${timeTeamAllSum_08_5 / endTeamAllSum_08_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_07_5 eq 0 or endTeamAllSum_07_5 eq 0}">
		    						<c:set var="arvTeamAllSum_07_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_07_5" value="${timeTeamAllSum_07_5 / endTeamAllSum_07_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_06_5 eq 0 or endTeamAllSum_06_5 eq 0}">
		    						<c:set var="arvTeamAllSum_06_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_06_5" value="${timeTeamAllSum_06_5 / endTeamAllSum_06_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_05_5 eq 0 or endTeamAllSum_05_5 eq 0}">
		    						<c:set var="arvTeamAllSum_05_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_05_5" value="${timeTeamAllSum_05_5 / endTeamAllSum_05_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_04_5 eq 0 or endTeamAllSum_04_5 eq 0}">
		    						<c:set var="arvTeamAllSum_04_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_04_5" value="${timeTeamAllSum_04_5 / endTeamAllSum_04_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_03_5 eq 0 or endTeamAllSum_03_5 eq 0}">
		    						<c:set var="arvTeamAllSum_03_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_03_5" value="${timeTeamAllSum_03_5 / endTeamAllSum_03_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_02_5 eq 0 or endTeamAllSum_02_5 eq 0}">
		    						<c:set var="arvTeamAllSum_02_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_02_5" value="${timeTeamAllSum_02_5 / endTeamAllSum_02_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_01_5 eq 0 or endTeamAllSum_01_5 eq 0}">
		    						<c:set var="arvTeamAllSum_01_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_01_5" value="${timeTeamAllSum_01_5 / endTeamAllSum_01_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 팀별 평균 계산 끝 -->
		    						    				
		    				<!-- cntTime12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_12_5}" pattern="#,##0.##"/></td>
		    				<!-- cntTime11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_11_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_10_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_09_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_08_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_07_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_06_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_05_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_04_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_03_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_02_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_01_5}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="timeTeamAllColSum_5" value="${timeTeamAllSum_12_5 + timeTeamAllSum_11_5 + timeTeamAllSum_10_5 + timeTeamAllSum_09_5 + timeTeamAllSum_08_5 + timeTeamAllSum_07_5 + timeTeamAllSum_06_5 + timeTeamAllSum_05_5 + timeTeamAllSum_04_5 + timeTeamAllSum_03_5 + timeTeamAllSum_02_5 + timeTeamAllSum_01_5}"></c:set>
			                <c:set var="endTeamAllColSum_5" value="${endTeamAllSum_12_5 + endTeamAllSum_11_5 + endTeamAllSum_10_5 + endTeamAllSum_09_5 + endTeamAllSum_08_5 + endTeamAllSum_07_5 + endTeamAllSum_06_5 + endTeamAllSum_05_5 + endTeamAllSum_04_5 + endTeamAllSum_03_5 + endTeamAllSum_02_5 + endTeamAllSum_01_5}"></c:set>			                
			                <c:choose>
			                	<c:when test="${timeTeamAllColSum_5 eq 0 or endTeamAllColSum_5 eq 0}">
			                		<c:set var="arvTeamAllColSum_5" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvTeamAllColSum_5" value="${timeTeamAllColSum_5 / endTeamAllColSum_5}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllColSum_5}" pattern="#,##0.##"/></td>
		    				
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="cntTimeTeamAllSum_12_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_11_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_10_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_09_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_08_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_07_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_06_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_05_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_04_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_03_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_02_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_01_5" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="timeTeamAllSum_12_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_11_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_10_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_09_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_08_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_07_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_06_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_05_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_04_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_03_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_02_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_01_5" value="0"></c:set>
											    
							<c:set var="endTeamAllSum_12_5" value="0"></c:set>
							<c:set var="endTeamAllSum_11_5" value="0"></c:set>
							<c:set var="endTeamAllSum_10_5" value="0"></c:set>
							<c:set var="endTeamAllSum_09_5" value="0"></c:set>
							<c:set var="endTeamAllSum_08_5" value="0"></c:set>
							<c:set var="endTeamAllSum_07_5" value="0"></c:set>
							<c:set var="endTeamAllSum_06_5" value="0"></c:set>
							<c:set var="endTeamAllSum_05_5" value="0"></c:set>
							<c:set var="endTeamAllSum_04_5" value="0"></c:set>
							<c:set var="endTeamAllSum_03_5" value="0"></c:set>
							<c:set var="endTeamAllSum_02_5" value="0"></c:set>
							<c:set var="endTeamAllSum_01_5" value="0"></c:set>				            				            
		    			</c:when>
		    			<c:when test="${vo.rowCnt == 1}">
		    				<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="cntTimeTeamAllSum_12_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_11_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_10_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_09_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_08_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_07_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_06_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_05_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_04_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_03_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_02_5" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_01_5" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="timeTeamAllSum_12_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_11_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_10_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_09_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_08_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_07_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_06_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_05_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_04_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_03_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_02_5" value="0"></c:set>
							<c:set var="timeTeamAllSum_01_5" value="0"></c:set>
											    
							<c:set var="endTeamAllSum_12_5" value="0"></c:set>
							<c:set var="endTeamAllSum_11_5" value="0"></c:set>
							<c:set var="endTeamAllSum_10_5" value="0"></c:set>
							<c:set var="endTeamAllSum_09_5" value="0"></c:set>
							<c:set var="endTeamAllSum_08_5" value="0"></c:set>
							<c:set var="endTeamAllSum_07_5" value="0"></c:set>
							<c:set var="endTeamAllSum_06_5" value="0"></c:set>
							<c:set var="endTeamAllSum_05_5" value="0"></c:set>
							<c:set var="endTeamAllSum_04_5" value="0"></c:set>
							<c:set var="endTeamAllSum_03_5" value="0"></c:set>
							<c:set var="endTeamAllSum_02_5" value="0"></c:set>
							<c:set var="endTeamAllSum_01_5" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 팀별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 팀별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 조사 소계 시작 -->
		    	<c:if test="${ptnrStatTeamAllCntTimeList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="4" style="height:25px;">1종 조사 평균</th>
	                <c:choose>
    					<c:when test="${timeTeamAllTotalSum_12_5 eq 0 or endTeamAllTotalSum_12_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_12_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_12_5" value="${timeTeamAllTotalSum_12_5 / endTeamAllTotalSum_12_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_11_5 eq 0 or endTeamAllTotalSum_11_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_11_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_11_5" value="${timeTeamAllTotalSum_11_5 / endTeamAllTotalSum_11_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_10_5 eq 0 or endTeamAllTotalSum_10_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_10_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_10_5" value="${timeTeamAllTotalSum_10_5 / endTeamAllTotalSum_10_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_09_5 eq 0 or endTeamAllTotalSum_09_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_09_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_09_5" value="${timeTeamAllTotalSum_09_5 / endTeamAllTotalSum_09_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_08_5 eq 0 or endTeamAllTotalSum_08_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_08_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_08_5" value="${timeTeamAllTotalSum_08_5 / endTeamAllTotalSum_08_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_07_5 eq 0 or endTeamAllTotalSum_07_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_07_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_07_5" value="${timeTeamAllTotalSum_07_5 / endTeamAllTotalSum_07_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_06_5 eq 0 or endTeamAllTotalSum_06_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_06_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_06_5" value="${timeTeamAllTotalSum_06_5 / endTeamAllTotalSum_06_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_05_5 eq 0 or endTeamAllTotalSum_05_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_05_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_05_5" value="${timeTeamAllTotalSum_05_5 / endTeamAllTotalSum_05_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_04_5 eq 0 or endTeamAllTotalSum_04_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_04_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_04_5" value="${timeTeamAllTotalSum_04_5 / endTeamAllTotalSum_04_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_03_5 eq 0 or endTeamAllTotalSum_03_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_03_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_03_5" value="${timeTeamAllTotalSum_03_5 / endTeamAllTotalSum_03_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_02_5 eq 0 or endTeamAllTotalSum_02_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_02_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_02_5" value="${timeTeamAllTotalSum_02_5 / endTeamAllTotalSum_02_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_01_5 eq 0 or endTeamAllTotalSum_01_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_01_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_01_5" value="${timeTeamAllTotalSum_01_5 / endTeamAllTotalSum_01_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 팀별 평균 계산 끝 -->
    						    				
    				<!-- cntTime12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_12_5}" pattern="#,##0.##"/></th>
    				<!-- cntTime11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_11_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_10_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_09_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_08_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_07_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_06_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_05_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_04_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_03_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_02_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_01_5}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="timeColTeamAllTotalSum_5" value="${timeTeamAllTotalSum_12_5 + timeTeamAllTotalSum_11_5 + timeTeamAllTotalSum_10_5 + timeTeamAllTotalSum_09_5 + timeTeamAllTotalSum_08_5 + timeTeamAllTotalSum_07_5 + timeTeamAllTotalSum_06_5 + timeTeamAllTotalSum_05_5 + timeTeamAllTotalSum_04_5 + timeTeamAllTotalSum_03_5 + timeTeamAllTotalSum_02_5 + timeTeamAllTotalSum_01_5}"></c:set>
	                <c:set var="endColTeamAllTotalSum_5" value="${endTeamAllTotalSum_12_5 + endTeamAllTotalSum_11_5 + endTeamAllTotalSum_10_5 + endTeamAllTotalSum_09_5 + endTeamAllTotalSum_08_5 + endTeamAllTotalSum_07_5 + endTeamAllTotalSum_06_5 + endTeamAllTotalSum_05_5 + endTeamAllTotalSum_04_5 + endTeamAllTotalSum_03_5 + endTeamAllTotalSum_02_5 + endTeamAllTotalSum_01_5}"></c:set>
					<c:choose>
	                	<c:when test="${timeColTeamAllTotalSum_5 eq 0 or endColTeamAllTotalSum_5 eq 0}">
	                		<c:set var="arvColTeamAllTotalSum_5" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColTeamAllTotalSum_5" value="${timeColTeamAllTotalSum_5 / endColTeamAllTotalSum_5}"/>
	                	</c:otherwise>
					</c:choose>
	                
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvColTeamAllTotalSum_5}" pattern="#,##0.##"/></th>
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
	            <c:set var="cntTimeTeamAllSum_12_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_11_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_10_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_09_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_08_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_07_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_06_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_05_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_04_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_03_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_02_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_01_10" value="0"></c:set>
	            
	            <!-- 팀별 평균 계 초기화 -->
				<c:set var="timeTeamAllSum_12_10" value="0"></c:set>
				<c:set var="timeTeamAllSum_11_10" value="0"></c:set>
				<c:set var="timeTeamAllSum_10_10" value="0"></c:set>
				<c:set var="timeTeamAllSum_09_10" value="0"></c:set>
				<c:set var="timeTeamAllSum_08_10" value="0"></c:set>
				<c:set var="timeTeamAllSum_07_10" value="0"></c:set>
				<c:set var="timeTeamAllSum_06_10" value="0"></c:set>
				<c:set var="timeTeamAllSum_05_10" value="0"></c:set>
				<c:set var="timeTeamAllSum_04_10" value="0"></c:set>
				<c:set var="timeTeamAllSum_03_10" value="0"></c:set>
				<c:set var="timeTeamAllSum_02_10" value="0"></c:set>
				<c:set var="timeTeamAllSum_01_10" value="0"></c:set>
								    
				<c:set var="endTeamAllSum_12_10" value="0"></c:set>
				<c:set var="endTeamAllSum_11_10" value="0"></c:set>
				<c:set var="endTeamAllSum_10_10" value="0"></c:set>
				<c:set var="endTeamAllSum_09_10" value="0"></c:set>
				<c:set var="endTeamAllSum_08_10" value="0"></c:set>
				<c:set var="endTeamAllSum_07_10" value="0"></c:set>
				<c:set var="endTeamAllSum_06_10" value="0"></c:set>
				<c:set var="endTeamAllSum_05_10" value="0"></c:set>
				<c:set var="endTeamAllSum_04_10" value="0"></c:set>
				<c:set var="endTeamAllSum_03_10" value="0"></c:set>
				<c:set var="endTeamAllSum_02_10" value="0"></c:set>
				<c:set var="endTeamAllSum_01_10" value="0"></c:set>
				
	            <!-- Type 별 총 합계 -->
	            <c:set var="cntTimeTeamAllTotalSum_12_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_11_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_10_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_09_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_08_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_07_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_06_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_05_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_04_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_03_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_02_10" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_01_10" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntTimeColTeamAllTotalSum_10" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="timeTeamAllTotalSum_12_10" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_11_10" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_10_10" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_09_10" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_08_10" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_07_10" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_06_10" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_05_10" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_04_10" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_03_10" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_02_10" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_01_10" value="0"></c:set>
				
				<c:set var="endTeamAllTotalSum_12_10" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_11_10" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_10_10" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_09_10" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_08_10" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_07_10" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_06_10" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_05_10" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_04_10" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_03_10" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_02_10" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_01_10" value="0"></c:set>	            
   				    			
    			<c:forEach var="vo1" items="${ptnrStatTeamAllCntTimeList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCntTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowTeamAll_10}">
		                    	1종 심사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo1.rowCnt == 1}">
		                		<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>		                				                		
		                		<td onclick="goPtnrStatMember(${vo1.ptnrId},${vo1.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.teamName}</td>
		                		<td style="width:150px;">${vo1.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="cntTimeTeamAllSum_12_10" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_11_10" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_10_10" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_09_10" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_08_10" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_07_10" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_06_10" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_05_10" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_04_10" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_03_10" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_02_10" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_01_10" value="0"></c:set>
					            
					            <!-- 팀별 평균 계 초기화 -->
								<c:set var="timeTeamAllSum_12_10" value="0"></c:set>
								<c:set var="timeTeamAllSum_11_10" value="0"></c:set>
								<c:set var="timeTeamAllSum_10_10" value="0"></c:set>
								<c:set var="timeTeamAllSum_09_10" value="0"></c:set>
								<c:set var="timeTeamAllSum_08_10" value="0"></c:set>
								<c:set var="timeTeamAllSum_07_10" value="0"></c:set>
								<c:set var="timeTeamAllSum_06_10" value="0"></c:set>
								<c:set var="timeTeamAllSum_05_10" value="0"></c:set>
								<c:set var="timeTeamAllSum_04_10" value="0"></c:set>
								<c:set var="timeTeamAllSum_03_10" value="0"></c:set>
								<c:set var="timeTeamAllSum_02_10" value="0"></c:set>
								<c:set var="timeTeamAllSum_01_10" value="0"></c:set>
												    
								<c:set var="endTeamAllSum_12_10" value="0"></c:set>
								<c:set var="endTeamAllSum_11_10" value="0"></c:set>
								<c:set var="endTeamAllSum_10_10" value="0"></c:set>
								<c:set var="endTeamAllSum_09_10" value="0"></c:set>
								<c:set var="endTeamAllSum_08_10" value="0"></c:set>
								<c:set var="endTeamAllSum_07_10" value="0"></c:set>
								<c:set var="endTeamAllSum_06_10" value="0"></c:set>
								<c:set var="endTeamAllSum_05_10" value="0"></c:set>
								<c:set var="endTeamAllSum_04_10" value="0"></c:set>
								<c:set var="endTeamAllSum_03_10" value="0"></c:set>
								<c:set var="endTeamAllSum_02_10" value="0"></c:set>
								<c:set var="endTeamAllSum_01_10" value="0"></c:set>
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
	    				<c:set var="cntTimeTeamAllSum_12_10" value="${cntTimeTeamAllSum_12_10+cntTime12_10}"></c:set>
			            <c:set var="cntTimeTeamAllSum_11_10" value="${cntTimeTeamAllSum_11_10+cntTime11_10}"></c:set>
			            <c:set var="cntTimeTeamAllSum_10_10" value="${cntTimeTeamAllSum_10_10+cntTime10_10}"></c:set>
			            <c:set var="cntTimeTeamAllSum_09_10" value="${cntTimeTeamAllSum_09_10+cntTime09_10}"></c:set>
			            <c:set var="cntTimeTeamAllSum_08_10" value="${cntTimeTeamAllSum_08_10+cntTime08_10}"></c:set>
			            <c:set var="cntTimeTeamAllSum_07_10" value="${cntTimeTeamAllSum_07_10+cntTime07_10}"></c:set>
			            <c:set var="cntTimeTeamAllSum_06_10" value="${cntTimeTeamAllSum_06_10+cntTime06_10}"></c:set>
			            <c:set var="cntTimeTeamAllSum_05_10" value="${cntTimeTeamAllSum_05_10+cntTime05_10}"></c:set>
			            <c:set var="cntTimeTeamAllSum_04_10" value="${cntTimeTeamAllSum_04_10+cntTime04_10}"></c:set>
			            <c:set var="cntTimeTeamAllSum_03_10" value="${cntTimeTeamAllSum_03_10+cntTime03_10}"></c:set>
			            <c:set var="cntTimeTeamAllSum_02_10" value="${cntTimeTeamAllSum_02_10+cntTime02_10}"></c:set>
			            <c:set var="cntTimeTeamAllSum_01_10" value="${cntTimeTeamAllSum_01_10+cntTime01_10}"></c:set>
			            
			            <!-- 팀별 계 평균용 변수 -->
						<c:set var="timeTeamAllSum_12_10" value="${timeTeamAllSum_12_10+time12_10}"></c:set>
			            <c:set var="timeTeamAllSum_11_10" value="${timeTeamAllSum_11_10+time11_10}"></c:set>
			            <c:set var="timeTeamAllSum_10_10" value="${timeTeamAllSum_10_10+time10_10}"></c:set>
			            <c:set var="timeTeamAllSum_09_10" value="${timeTeamAllSum_09_10+time09_10}"></c:set>
			            <c:set var="timeTeamAllSum_08_10" value="${timeTeamAllSum_08_10+time08_10}"></c:set>
			            <c:set var="timeTeamAllSum_07_10" value="${timeTeamAllSum_07_10+time07_10}"></c:set>
			            <c:set var="timeTeamAllSum_06_10" value="${timeTeamAllSum_06_10+time06_10}"></c:set>
			            <c:set var="timeTeamAllSum_05_10" value="${timeTeamAllSum_05_10+time05_10}"></c:set>
			            <c:set var="timeTeamAllSum_04_10" value="${timeTeamAllSum_04_10+time04_10}"></c:set>
			            <c:set var="timeTeamAllSum_03_10" value="${timeTeamAllSum_03_10+time03_10}"></c:set>
			            <c:set var="timeTeamAllSum_02_10" value="${timeTeamAllSum_02_10+time02_10}"></c:set>
			            <c:set var="timeTeamAllSum_01_10" value="${timeTeamAllSum_01_10+time01_10}"></c:set>
				    
						<c:set var="endTeamAllSum_12_10" value="${endTeamAllSum_12_10+end12_10}"></c:set>
			            <c:set var="endTeamAllSum_11_10" value="${endTeamAllSum_11_10+end11_10}"></c:set>
			            <c:set var="endTeamAllSum_10_10" value="${endTeamAllSum_10_10+end10_10}"></c:set>
			            <c:set var="endTeamAllSum_09_10" value="${endTeamAllSum_09_10+end09_10}"></c:set>
			            <c:set var="endTeamAllSum_08_10" value="${endTeamAllSum_08_10+end08_10}"></c:set>
			            <c:set var="endTeamAllSum_07_10" value="${endTeamAllSum_07_10+end07_10}"></c:set>
			            <c:set var="endTeamAllSum_06_10" value="${endTeamAllSum_06_10+end06_10}"></c:set>
			            <c:set var="endTeamAllSum_05_10" value="${endTeamAllSum_05_10+end05_10}"></c:set>
			            <c:set var="endTeamAllSum_04_10" value="${endTeamAllSum_04_10+end04_10}"></c:set>
			            <c:set var="endTeamAllSum_03_10" value="${endTeamAllSum_03_10+end03_10}"></c:set>
			            <c:set var="endTeamAllSum_02_10" value="${endTeamAllSum_02_10+end02_10}"></c:set>
			            <c:set var="endTeamAllSum_01_10" value="${endTeamAllSum_01_10+end01_10}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="cntTimeTeamAllTotalSum_12_10" value="${cntTimeTeamAllTotalSum_12_10 + cntTime12_10}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_11_10" value="${cntTimeTeamAllTotalSum_11_10 + cntTime11_10}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_10_10" value="${cntTimeTeamAllTotalSum_10_10 + cntTime10_10}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_09_10" value="${cntTimeTeamAllTotalSum_09_10 + cntTime09_10}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_08_10" value="${cntTimeTeamAllTotalSum_08_10 + cntTime08_10}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_07_10" value="${cntTimeTeamAllTotalSum_07_10 + cntTime07_10}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_06_10" value="${cntTimeTeamAllTotalSum_06_10 + cntTime06_10}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_05_10" value="${cntTimeTeamAllTotalSum_05_10 + cntTime05_10}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_04_10" value="${cntTimeTeamAllTotalSum_04_10 + cntTime04_10}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_03_10" value="${cntTimeTeamAllTotalSum_03_10 + cntTime03_10}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_02_10" value="${cntTimeTeamAllTotalSum_02_10 + cntTime02_10}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_01_10" value="${cntTimeTeamAllTotalSum_01_10 + cntTime01_10}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="timeTeamAllTotalSum_12_10" value="${timeTeamAllTotalSum_12_10 + time12_10}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_11_10" value="${timeTeamAllTotalSum_11_10 + time11_10}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_10_10" value="${timeTeamAllTotalSum_10_10 + time10_10}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_09_10" value="${timeTeamAllTotalSum_09_10 + time09_10}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_08_10" value="${timeTeamAllTotalSum_08_10 + time08_10}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_07_10" value="${timeTeamAllTotalSum_07_10 + time07_10}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_06_10" value="${timeTeamAllTotalSum_06_10 + time06_10}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_05_10" value="${timeTeamAllTotalSum_05_10 + time05_10}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_04_10" value="${timeTeamAllTotalSum_04_10 + time04_10}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_03_10" value="${timeTeamAllTotalSum_03_10 + time03_10}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_02_10" value="${timeTeamAllTotalSum_02_10 + time02_10}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_01_10" value="${timeTeamAllTotalSum_01_10 + time01_10}"></c:set>

						<c:set var="endTeamAllTotalSum_12_10" value="${endTeamAllTotalSum_12_10 + end12_10}"></c:set>
	                    <c:set var="endTeamAllTotalSum_11_10" value="${endTeamAllTotalSum_11_10 + end11_10}"></c:set>
	                    <c:set var="endTeamAllTotalSum_10_10" value="${endTeamAllTotalSum_10_10 + end10_10}"></c:set>
	                    <c:set var="endTeamAllTotalSum_09_10" value="${endTeamAllTotalSum_09_10 + end09_10}"></c:set>
	                    <c:set var="endTeamAllTotalSum_08_10" value="${endTeamAllTotalSum_08_10 + end08_10}"></c:set>
	                    <c:set var="endTeamAllTotalSum_07_10" value="${endTeamAllTotalSum_07_10 + end07_10}"></c:set>
	                    <c:set var="endTeamAllTotalSum_06_10" value="${endTeamAllTotalSum_06_10 + end06_10}"></c:set>
	                    <c:set var="endTeamAllTotalSum_05_10" value="${endTeamAllTotalSum_05_10 + end05_10}"></c:set>
	                    <c:set var="endTeamAllTotalSum_04_10" value="${endTeamAllTotalSum_04_10 + end04_10}"></c:set>
	                    <c:set var="endTeamAllTotalSum_03_10" value="${endTeamAllTotalSum_03_10 + end03_10}"></c:set>
	                    <c:set var="endTeamAllTotalSum_02_10" value="${endTeamAllTotalSum_02_10 + end02_10}"></c:set>
	                    <c:set var="endTeamAllTotalSum_01_10" value="${endTeamAllTotalSum_01_10 + end01_10}"></c:set>
		    		</tr>
		    		<!-- 팀별 소계 시작 -->
		    		
		    		<!-- 팀별 평균 계산 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo1.rowCnt and vo1.rowCnt > 1}">
		    				<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>
		    				<td style="width:150px;" class="sum-level-2">${vo1.teamName} 평균</td>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_12_10 eq 0 or endTeamAllSum_12_10 eq 0}">
		    						<c:set var="arvTeamAllSum_12_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_12_10" value="${timeTeamAllSum_12_10 / endTeamAllSum_12_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_11_10 eq 0 or endTeamAllSum_11_10 eq 0}">
		    						<c:set var="arvTeamAllSum_11_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_11_10" value="${timeTeamAllSum_11_10 / endTeamAllSum_11_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_10_10 eq 0 or endTeamAllSum_10_10 eq 0}">
		    						<c:set var="arvTeamAllSum_10_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_10_10" value="${timeTeamAllSum_10_10 / endTeamAllSum_10_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_09_10 eq 0 or endTeamAllSum_09_10 eq 0}">
		    						<c:set var="arvTeamAllSum_09_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_09_10" value="${timeTeamAllSum_09_10 / endTeamAllSum_09_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_08_10 eq 0 or endTeamAllSum_08_10 eq 0}">
		    						<c:set var="arvTeamAllSum_08_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_08_10" value="${timeTeamAllSum_08_10 / endTeamAllSum_08_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_07_10 eq 0 or endTeamAllSum_07_10 eq 0}">
		    						<c:set var="arvTeamAllSum_07_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_07_10" value="${timeTeamAllSum_07_10 / endTeamAllSum_07_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_06_10 eq 0 or endTeamAllSum_06_10 eq 0}">
		    						<c:set var="arvTeamAllSum_06_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_06_10" value="${timeTeamAllSum_06_10 / endTeamAllSum_06_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_05_10 eq 0 or endTeamAllSum_05_10 eq 0}">
		    						<c:set var="arvTeamAllSum_05_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_05_10" value="${timeTeamAllSum_05_10 / endTeamAllSum_05_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_04_10 eq 0 or endTeamAllSum_04_10 eq 0}">
		    						<c:set var="arvTeamAllSum_04_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_04_10" value="${timeTeamAllSum_04_10 / endTeamAllSum_04_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_03_10 eq 0 or endTeamAllSum_03_10 eq 0}">
		    						<c:set var="arvTeamAllSum_03_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_03_10" value="${timeTeamAllSum_03_10 / endTeamAllSum_03_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_02_10 eq 0 or endTeamAllSum_02_10 eq 0}">
		    						<c:set var="arvTeamAllSum_02_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_02_10" value="${timeTeamAllSum_02_10 / endTeamAllSum_02_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_01_10 eq 0 or endTeamAllSum_01_10 eq 0}">
		    						<c:set var="arvTeamAllSum_01_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_01_10" value="${timeTeamAllSum_01_10 / endTeamAllSum_01_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 팀별 평균 계산 끝 -->
		    						    				
		    				<!-- cntTime12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_12_10}" pattern="#,##0.##"/></td>
		    				<!-- cntTime11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_11_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_10_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_09_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_08_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_07_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_06_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_05_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_04_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_03_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_02_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_01_10}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="timeTeamAllColSum_10" value="${timeTeamAllSum_12_10 + timeTeamAllSum_11_10 + timeTeamAllSum_10_10 + timeTeamAllSum_09_10 + timeTeamAllSum_08_10 + timeTeamAllSum_07_10 + timeTeamAllSum_06_10 + timeTeamAllSum_05_10 + timeTeamAllSum_04_10 + timeTeamAllSum_03_10 + timeTeamAllSum_02_10 + timeTeamAllSum_01_10}"></c:set>
			                <c:set var="endTeamAllColSum_10" value="${endTeamAllSum_12_10 + endTeamAllSum_11_10 + endTeamAllSum_10_10 + endTeamAllSum_09_10 + endTeamAllSum_08_10 + endTeamAllSum_07_10 + endTeamAllSum_06_10 + endTeamAllSum_05_10 + endTeamAllSum_04_10 + endTeamAllSum_03_10 + endTeamAllSum_02_10 + endTeamAllSum_01_10}"></c:set>			                
			                <c:choose>
			                	<c:when test="${timeTeamAllColSum_10 eq 0 or endTeamAllColSum_10 eq 0}">
			                		<c:set var="arvTeamAllColSum_10" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvTeamAllColSum_10" value="${timeTeamAllColSum_10 / endTeamAllColSum_10}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllColSum_10}" pattern="#,##0.##"/></td>
		    				
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="cntTimeTeamAllSum_12_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_11_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_10_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_09_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_08_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_07_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_06_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_05_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_04_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_03_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_02_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_01_10" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="timeTeamAllSum_12_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_11_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_10_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_09_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_08_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_07_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_06_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_05_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_04_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_03_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_02_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_01_10" value="0"></c:set>
											    
							<c:set var="endTeamAllSum_12_10" value="0"></c:set>
							<c:set var="endTeamAllSum_11_10" value="0"></c:set>
							<c:set var="endTeamAllSum_10_10" value="0"></c:set>
							<c:set var="endTeamAllSum_09_10" value="0"></c:set>
							<c:set var="endTeamAllSum_08_10" value="0"></c:set>
							<c:set var="endTeamAllSum_07_10" value="0"></c:set>
							<c:set var="endTeamAllSum_06_10" value="0"></c:set>
							<c:set var="endTeamAllSum_05_10" value="0"></c:set>
							<c:set var="endTeamAllSum_04_10" value="0"></c:set>
							<c:set var="endTeamAllSum_03_10" value="0"></c:set>
							<c:set var="endTeamAllSum_02_10" value="0"></c:set>
							<c:set var="endTeamAllSum_01_10" value="0"></c:set>				            				            
		    			</c:when>
		    			<c:when test="${vo1.rowCnt == 1}">
		    				<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="cntTimeTeamAllSum_12_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_11_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_10_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_09_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_08_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_07_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_06_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_05_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_04_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_03_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_02_10" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_01_10" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="timeTeamAllSum_12_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_11_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_10_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_09_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_08_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_07_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_06_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_05_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_04_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_03_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_02_10" value="0"></c:set>
							<c:set var="timeTeamAllSum_01_10" value="0"></c:set>
											    
							<c:set var="endTeamAllSum_12_10" value="0"></c:set>
							<c:set var="endTeamAllSum_11_10" value="0"></c:set>
							<c:set var="endTeamAllSum_10_10" value="0"></c:set>
							<c:set var="endTeamAllSum_09_10" value="0"></c:set>
							<c:set var="endTeamAllSum_08_10" value="0"></c:set>
							<c:set var="endTeamAllSum_07_10" value="0"></c:set>
							<c:set var="endTeamAllSum_06_10" value="0"></c:set>
							<c:set var="endTeamAllSum_05_10" value="0"></c:set>
							<c:set var="endTeamAllSum_04_10" value="0"></c:set>
							<c:set var="endTeamAllSum_03_10" value="0"></c:set>
							<c:set var="endTeamAllSum_02_10" value="0"></c:set>
							<c:set var="endTeamAllSum_01_10" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 팀별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 팀별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 심사 소계 시작 -->
		    	<c:if test="${ptnrStatTeamAllCntTimeList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="4" style="height:25px;">1종 심사 평균</th>
	                <c:choose>
    					<c:when test="${timeTeamAllTotalSum_12_10 eq 0 or endTeamAllTotalSum_12_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_12_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_12_10" value="${timeTeamAllTotalSum_12_10 / endTeamAllTotalSum_12_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_11_10 eq 0 or endTeamAllTotalSum_11_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_11_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_11_10" value="${timeTeamAllTotalSum_11_10 / endTeamAllTotalSum_11_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_10_10 eq 0 or endTeamAllTotalSum_10_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_10_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_10_10" value="${timeTeamAllTotalSum_10_10 / endTeamAllTotalSum_10_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_09_10 eq 0 or endTeamAllTotalSum_09_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_09_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_09_10" value="${timeTeamAllTotalSum_09_10 / endTeamAllTotalSum_09_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_08_10 eq 0 or endTeamAllTotalSum_08_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_08_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_08_10" value="${timeTeamAllTotalSum_08_10 / endTeamAllTotalSum_08_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_07_10 eq 0 or endTeamAllTotalSum_07_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_07_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_07_10" value="${timeTeamAllTotalSum_07_10 / endTeamAllTotalSum_07_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_06_10 eq 0 or endTeamAllTotalSum_06_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_06_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_06_10" value="${timeTeamAllTotalSum_06_10 / endTeamAllTotalSum_06_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_05_10 eq 0 or endTeamAllTotalSum_05_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_05_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_05_10" value="${timeTeamAllTotalSum_05_10 / endTeamAllTotalSum_05_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_04_10 eq 0 or endTeamAllTotalSum_04_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_04_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_04_10" value="${timeTeamAllTotalSum_04_10 / endTeamAllTotalSum_04_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_03_10 eq 0 or endTeamAllTotalSum_03_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_03_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_03_10" value="${timeTeamAllTotalSum_03_10 / endTeamAllTotalSum_03_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_02_10 eq 0 or endTeamAllTotalSum_02_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_02_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_02_10" value="${timeTeamAllTotalSum_02_10 / endTeamAllTotalSum_02_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_01_10 eq 0 or endTeamAllTotalSum_01_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_01_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_01_10" value="${timeTeamAllTotalSum_01_10 / endTeamAllTotalSum_01_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 팀별 평균 계산 끝 -->
    						    				
    				<!-- cntTime12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_12_10}" pattern="#,##0.##"/></th>
    				<!-- cntTime11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_11_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_10_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_09_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_08_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_07_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_06_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_05_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_04_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_03_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_02_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_01_10}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="timeColTeamAllTotalSum_10" value="${timeTeamAllTotalSum_12_10 + timeTeamAllTotalSum_11_10 + timeTeamAllTotalSum_10_10 + timeTeamAllTotalSum_09_10 + timeTeamAllTotalSum_08_10 + timeTeamAllTotalSum_07_10 + timeTeamAllTotalSum_06_10 + timeTeamAllTotalSum_05_10 + timeTeamAllTotalSum_04_10 + timeTeamAllTotalSum_03_10 + timeTeamAllTotalSum_02_10 + timeTeamAllTotalSum_01_10}"></c:set>
	                <c:set var="endColTeamAllTotalSum_10" value="${endTeamAllTotalSum_12_10 + endTeamAllTotalSum_11_10 + endTeamAllTotalSum_10_10 + endTeamAllTotalSum_09_10 + endTeamAllTotalSum_08_10 + endTeamAllTotalSum_07_10 + endTeamAllTotalSum_06_10 + endTeamAllTotalSum_05_10 + endTeamAllTotalSum_04_10 + endTeamAllTotalSum_03_10 + endTeamAllTotalSum_02_10 + endTeamAllTotalSum_01_10}"></c:set>
					<c:choose>
	                	<c:when test="${timeColTeamAllTotalSum_10 eq 0 or endColTeamAllTotalSum_10 eq 0}">
	                		<c:set var="arvColTeamAllTotalSum_10" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColTeamAllTotalSum_10" value="${timeColTeamAllTotalSum_10 / endColTeamAllTotalSum_10}"/>
	                	</c:otherwise>
					</c:choose>
	                
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvColTeamAllTotalSum_10}" pattern="#,##0.##"/></th>
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
	            <c:set var="cntTimeTeamAllSum_12_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_11_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_10_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_09_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_08_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_07_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_06_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_05_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_04_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_03_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_02_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllSum_01_15" value="0"></c:set>
	            
	            <!-- 팀별 평균 계 초기화 -->
				<c:set var="timeTeamAllSum_12_15" value="0"></c:set>
				<c:set var="timeTeamAllSum_11_15" value="0"></c:set>
				<c:set var="timeTeamAllSum_10_15" value="0"></c:set>
				<c:set var="timeTeamAllSum_09_15" value="0"></c:set>
				<c:set var="timeTeamAllSum_08_15" value="0"></c:set>
				<c:set var="timeTeamAllSum_07_15" value="0"></c:set>
				<c:set var="timeTeamAllSum_06_15" value="0"></c:set>
				<c:set var="timeTeamAllSum_05_15" value="0"></c:set>
				<c:set var="timeTeamAllSum_04_15" value="0"></c:set>
				<c:set var="timeTeamAllSum_03_15" value="0"></c:set>
				<c:set var="timeTeamAllSum_02_15" value="0"></c:set>
				<c:set var="timeTeamAllSum_01_15" value="0"></c:set>
								    
				<c:set var="endTeamAllSum_12_15" value="0"></c:set>
				<c:set var="endTeamAllSum_11_15" value="0"></c:set>
				<c:set var="endTeamAllSum_10_15" value="0"></c:set>
				<c:set var="endTeamAllSum_09_15" value="0"></c:set>
				<c:set var="endTeamAllSum_08_15" value="0"></c:set>
				<c:set var="endTeamAllSum_07_15" value="0"></c:set>
				<c:set var="endTeamAllSum_06_15" value="0"></c:set>
				<c:set var="endTeamAllSum_05_15" value="0"></c:set>
				<c:set var="endTeamAllSum_04_15" value="0"></c:set>
				<c:set var="endTeamAllSum_03_15" value="0"></c:set>
				<c:set var="endTeamAllSum_02_15" value="0"></c:set>
				<c:set var="endTeamAllSum_01_15" value="0"></c:set>
				
	            <!-- Type 별 총 합계 -->
	            <c:set var="cntTimeTeamAllTotalSum_12_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_11_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_10_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_09_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_08_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_07_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_06_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_05_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_04_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_03_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_02_15" value="0"></c:set>
	            <c:set var="cntTimeTeamAllTotalSum_01_15" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntTimeColTeamAllTotalSum_15" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="timeTeamAllTotalSum_12_15" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_11_15" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_10_15" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_09_15" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_08_15" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_07_15" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_06_15" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_05_15" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_04_15" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_03_15" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_02_15" value="0"></c:set>
				<c:set var="timeTeamAllTotalSum_01_15" value="0"></c:set>
				
				<c:set var="endTeamAllTotalSum_12_15" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_11_15" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_10_15" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_09_15" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_08_15" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_07_15" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_06_15" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_05_15" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_04_15" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_03_15" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_02_15" value="0"></c:set>
				<c:set var="endTeamAllTotalSum_01_15" value="0"></c:set>	            
   				    			
    			<c:forEach var="vo2" items="${ptnrStatTeamAllCntTimeList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCntTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowTeamAll_15}">
		                    	1종 기타
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo2.rowCnt == 1}">
		                		<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>		                				                		
		                		<td onclick="goPtnrStatMember(${vo2.ptnrId},${vo2.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.teamName}</td>
		                		<td style="width:150px;">${vo2.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="cntTimeTeamAllSum_12_15" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_11_15" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_10_15" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_09_15" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_08_15" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_07_15" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_06_15" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_05_15" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_04_15" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_03_15" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_02_15" value="0"></c:set>
					            <c:set var="cntTimeTeamAllSum_01_15" value="0"></c:set>
					            
					            <!-- 팀별 평균 계 초기화 -->
								<c:set var="timeTeamAllSum_12_15" value="0"></c:set>
								<c:set var="timeTeamAllSum_11_15" value="0"></c:set>
								<c:set var="timeTeamAllSum_10_15" value="0"></c:set>
								<c:set var="timeTeamAllSum_09_15" value="0"></c:set>
								<c:set var="timeTeamAllSum_08_15" value="0"></c:set>
								<c:set var="timeTeamAllSum_07_15" value="0"></c:set>
								<c:set var="timeTeamAllSum_06_15" value="0"></c:set>
								<c:set var="timeTeamAllSum_05_15" value="0"></c:set>
								<c:set var="timeTeamAllSum_04_15" value="0"></c:set>
								<c:set var="timeTeamAllSum_03_15" value="0"></c:set>
								<c:set var="timeTeamAllSum_02_15" value="0"></c:set>
								<c:set var="timeTeamAllSum_01_15" value="0"></c:set>
												    
								<c:set var="endTeamAllSum_12_15" value="0"></c:set>
								<c:set var="endTeamAllSum_11_15" value="0"></c:set>
								<c:set var="endTeamAllSum_10_15" value="0"></c:set>
								<c:set var="endTeamAllSum_09_15" value="0"></c:set>
								<c:set var="endTeamAllSum_08_15" value="0"></c:set>
								<c:set var="endTeamAllSum_07_15" value="0"></c:set>
								<c:set var="endTeamAllSum_06_15" value="0"></c:set>
								<c:set var="endTeamAllSum_05_15" value="0"></c:set>
								<c:set var="endTeamAllSum_04_15" value="0"></c:set>
								<c:set var="endTeamAllSum_03_15" value="0"></c:set>
								<c:set var="endTeamAllSum_02_15" value="0"></c:set>
								<c:set var="endTeamAllSum_01_15" value="0"></c:set>
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
	    				<c:set var="cntTimeTeamAllSum_12_15" value="${cntTimeTeamAllSum_12_15+cntTime12_15}"></c:set>
			            <c:set var="cntTimeTeamAllSum_11_15" value="${cntTimeTeamAllSum_11_15+cntTime11_15}"></c:set>
			            <c:set var="cntTimeTeamAllSum_10_15" value="${cntTimeTeamAllSum_10_15+cntTime10_15}"></c:set>
			            <c:set var="cntTimeTeamAllSum_09_15" value="${cntTimeTeamAllSum_09_15+cntTime09_15}"></c:set>
			            <c:set var="cntTimeTeamAllSum_08_15" value="${cntTimeTeamAllSum_08_15+cntTime08_15}"></c:set>
			            <c:set var="cntTimeTeamAllSum_07_15" value="${cntTimeTeamAllSum_07_15+cntTime07_15}"></c:set>
			            <c:set var="cntTimeTeamAllSum_06_15" value="${cntTimeTeamAllSum_06_15+cntTime06_15}"></c:set>
			            <c:set var="cntTimeTeamAllSum_05_15" value="${cntTimeTeamAllSum_05_15+cntTime05_15}"></c:set>
			            <c:set var="cntTimeTeamAllSum_04_15" value="${cntTimeTeamAllSum_04_15+cntTime04_15}"></c:set>
			            <c:set var="cntTimeTeamAllSum_03_15" value="${cntTimeTeamAllSum_03_15+cntTime03_15}"></c:set>
			            <c:set var="cntTimeTeamAllSum_02_15" value="${cntTimeTeamAllSum_02_15+cntTime02_15}"></c:set>
			            <c:set var="cntTimeTeamAllSum_01_15" value="${cntTimeTeamAllSum_01_15+cntTime01_15}"></c:set>
			            
			            <!-- 팀별 계 평균용 변수 -->
						<c:set var="timeTeamAllSum_12_15" value="${timeTeamAllSum_12_15+time12_15}"></c:set>
			            <c:set var="timeTeamAllSum_11_15" value="${timeTeamAllSum_11_15+time11_15}"></c:set>
			            <c:set var="timeTeamAllSum_10_15" value="${timeTeamAllSum_10_15+time10_15}"></c:set>
			            <c:set var="timeTeamAllSum_09_15" value="${timeTeamAllSum_09_15+time09_15}"></c:set>
			            <c:set var="timeTeamAllSum_08_15" value="${timeTeamAllSum_08_15+time08_15}"></c:set>
			            <c:set var="timeTeamAllSum_07_15" value="${timeTeamAllSum_07_15+time07_15}"></c:set>
			            <c:set var="timeTeamAllSum_06_15" value="${timeTeamAllSum_06_15+time06_15}"></c:set>
			            <c:set var="timeTeamAllSum_05_15" value="${timeTeamAllSum_05_15+time05_15}"></c:set>
			            <c:set var="timeTeamAllSum_04_15" value="${timeTeamAllSum_04_15+time04_15}"></c:set>
			            <c:set var="timeTeamAllSum_03_15" value="${timeTeamAllSum_03_15+time03_15}"></c:set>
			            <c:set var="timeTeamAllSum_02_15" value="${timeTeamAllSum_02_15+time02_15}"></c:set>
			            <c:set var="timeTeamAllSum_01_15" value="${timeTeamAllSum_01_15+time01_15}"></c:set>
				    
						<c:set var="endTeamAllSum_12_15" value="${endTeamAllSum_12_15+end12_15}"></c:set>
			            <c:set var="endTeamAllSum_11_15" value="${endTeamAllSum_11_15+end11_15}"></c:set>
			            <c:set var="endTeamAllSum_10_15" value="${endTeamAllSum_10_15+end10_15}"></c:set>
			            <c:set var="endTeamAllSum_09_15" value="${endTeamAllSum_09_15+end09_15}"></c:set>
			            <c:set var="endTeamAllSum_08_15" value="${endTeamAllSum_08_15+end08_15}"></c:set>
			            <c:set var="endTeamAllSum_07_15" value="${endTeamAllSum_07_15+end07_15}"></c:set>
			            <c:set var="endTeamAllSum_06_15" value="${endTeamAllSum_06_15+end06_15}"></c:set>
			            <c:set var="endTeamAllSum_05_15" value="${endTeamAllSum_05_15+end05_15}"></c:set>
			            <c:set var="endTeamAllSum_04_15" value="${endTeamAllSum_04_15+end04_15}"></c:set>
			            <c:set var="endTeamAllSum_03_15" value="${endTeamAllSum_03_15+end03_15}"></c:set>
			            <c:set var="endTeamAllSum_02_15" value="${endTeamAllSum_02_15+end02_15}"></c:set>
			            <c:set var="endTeamAllSum_01_15" value="${endTeamAllSum_01_15+end01_15}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="cntTimeTeamAllTotalSum_12_15" value="${cntTimeTeamAllTotalSum_12_15 + cntTime12_15}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_11_15" value="${cntTimeTeamAllTotalSum_11_15 + cntTime11_15}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_10_15" value="${cntTimeTeamAllTotalSum_10_15 + cntTime10_15}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_09_15" value="${cntTimeTeamAllTotalSum_09_15 + cntTime09_15}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_08_15" value="${cntTimeTeamAllTotalSum_08_15 + cntTime08_15}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_07_15" value="${cntTimeTeamAllTotalSum_07_15 + cntTime07_15}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_06_15" value="${cntTimeTeamAllTotalSum_06_15 + cntTime06_15}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_05_15" value="${cntTimeTeamAllTotalSum_05_15 + cntTime05_15}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_04_15" value="${cntTimeTeamAllTotalSum_04_15 + cntTime04_15}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_03_15" value="${cntTimeTeamAllTotalSum_03_15 + cntTime03_15}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_02_15" value="${cntTimeTeamAllTotalSum_02_15 + cntTime02_15}"></c:set>
	                    <c:set var="cntTimeTeamAllTotalSum_01_15" value="${cntTimeTeamAllTotalSum_01_15 + cntTime01_15}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="timeTeamAllTotalSum_12_15" value="${timeTeamAllTotalSum_12_15 + time12_15}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_11_15" value="${timeTeamAllTotalSum_11_15 + time11_15}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_10_15" value="${timeTeamAllTotalSum_10_15 + time10_15}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_09_15" value="${timeTeamAllTotalSum_09_15 + time09_15}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_08_15" value="${timeTeamAllTotalSum_08_15 + time08_15}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_07_15" value="${timeTeamAllTotalSum_07_15 + time07_15}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_06_15" value="${timeTeamAllTotalSum_06_15 + time06_15}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_05_15" value="${timeTeamAllTotalSum_05_15 + time05_15}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_04_15" value="${timeTeamAllTotalSum_04_15 + time04_15}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_03_15" value="${timeTeamAllTotalSum_03_15 + time03_15}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_02_15" value="${timeTeamAllTotalSum_02_15 + time02_15}"></c:set>
	                    <c:set var="timeTeamAllTotalSum_01_15" value="${timeTeamAllTotalSum_01_15 + time01_15}"></c:set>

						<c:set var="endTeamAllTotalSum_12_15" value="${endTeamAllTotalSum_12_15 + end12_15}"></c:set>
	                    <c:set var="endTeamAllTotalSum_11_15" value="${endTeamAllTotalSum_11_15 + end11_15}"></c:set>
	                    <c:set var="endTeamAllTotalSum_10_15" value="${endTeamAllTotalSum_10_15 + end10_15}"></c:set>
	                    <c:set var="endTeamAllTotalSum_09_15" value="${endTeamAllTotalSum_09_15 + end09_15}"></c:set>
	                    <c:set var="endTeamAllTotalSum_08_15" value="${endTeamAllTotalSum_08_15 + end08_15}"></c:set>
	                    <c:set var="endTeamAllTotalSum_07_15" value="${endTeamAllTotalSum_07_15 + end07_15}"></c:set>
	                    <c:set var="endTeamAllTotalSum_06_15" value="${endTeamAllTotalSum_06_15 + end06_15}"></c:set>
	                    <c:set var="endTeamAllTotalSum_05_15" value="${endTeamAllTotalSum_05_15 + end05_15}"></c:set>
	                    <c:set var="endTeamAllTotalSum_04_15" value="${endTeamAllTotalSum_04_15 + end04_15}"></c:set>
	                    <c:set var="endTeamAllTotalSum_03_15" value="${endTeamAllTotalSum_03_15 + end03_15}"></c:set>
	                    <c:set var="endTeamAllTotalSum_02_15" value="${endTeamAllTotalSum_02_15 + end02_15}"></c:set>
	                    <c:set var="endTeamAllTotalSum_01_15" value="${endTeamAllTotalSum_01_15 + end01_15}"></c:set>
		    		</tr>
		    		<!-- 팀별 소계 시작 -->
		    		
		    		<!-- 팀별 평균 계산 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${teamCnt == vo2.rowCnt and vo2.rowCnt > 1}">
		    				<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>
		    				<td style="width:150px;" class="sum-level-2">${vo2.teamName} 평균</td>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_12_15 eq 0 or endTeamAllSum_12_15 eq 0}">
		    						<c:set var="arvTeamAllSum_12_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_12_15" value="${timeTeamAllSum_12_15 / endTeamAllSum_12_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_11_15 eq 0 or endTeamAllSum_11_15 eq 0}">
		    						<c:set var="arvTeamAllSum_11_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_11_15" value="${timeTeamAllSum_11_15 / endTeamAllSum_11_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_10_15 eq 0 or endTeamAllSum_10_15 eq 0}">
		    						<c:set var="arvTeamAllSum_10_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_10_15" value="${timeTeamAllSum_10_15 / endTeamAllSum_10_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_09_15 eq 0 or endTeamAllSum_09_15 eq 0}">
		    						<c:set var="arvTeamAllSum_09_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_09_15" value="${timeTeamAllSum_09_15 / endTeamAllSum_09_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_08_15 eq 0 or endTeamAllSum_08_15 eq 0}">
		    						<c:set var="arvTeamAllSum_08_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_08_15" value="${timeTeamAllSum_08_15 / endTeamAllSum_08_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_07_15 eq 0 or endTeamAllSum_07_15 eq 0}">
		    						<c:set var="arvTeamAllSum_07_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_07_15" value="${timeTeamAllSum_07_15 / endTeamAllSum_07_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_06_15 eq 0 or endTeamAllSum_06_15 eq 0}">
		    						<c:set var="arvTeamAllSum_06_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_06_15" value="${timeTeamAllSum_06_15 / endTeamAllSum_06_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_05_15 eq 0 or endTeamAllSum_05_15 eq 0}">
		    						<c:set var="arvTeamAllSum_05_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_05_15" value="${timeTeamAllSum_05_15 / endTeamAllSum_05_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_04_15 eq 0 or endTeamAllSum_04_15 eq 0}">
		    						<c:set var="arvTeamAllSum_04_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_04_15" value="${timeTeamAllSum_04_15 / endTeamAllSum_04_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_03_15 eq 0 or endTeamAllSum_03_15 eq 0}">
		    						<c:set var="arvTeamAllSum_03_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_03_15" value="${timeTeamAllSum_03_15 / endTeamAllSum_03_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_02_15 eq 0 or endTeamAllSum_02_15 eq 0}">
		    						<c:set var="arvTeamAllSum_02_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_02_15" value="${timeTeamAllSum_02_15 / endTeamAllSum_02_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeTeamAllSum_01_15 eq 0 or endTeamAllSum_01_15 eq 0}">
		    						<c:set var="arvTeamAllSum_01_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_01_15" value="${timeTeamAllSum_01_15 / endTeamAllSum_01_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 팀별 평균 계산 끝 -->
		    						    				
		    				<!-- cntTime12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_12_15}" pattern="#,##0.##"/></td>
		    				<!-- cntTime11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_11_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_10_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_09_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_08_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_07_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_06_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_05_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_04_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_03_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_02_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_01_15}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="timeTeamAllColSum_15" value="${timeTeamAllSum_12_15 + timeTeamAllSum_11_15 + timeTeamAllSum_10_15 + timeTeamAllSum_09_15 + timeTeamAllSum_08_15 + timeTeamAllSum_07_15 + timeTeamAllSum_06_15 + timeTeamAllSum_05_15 + timeTeamAllSum_04_15 + timeTeamAllSum_03_15 + timeTeamAllSum_02_15 + timeTeamAllSum_01_15}"></c:set>
			                <c:set var="endTeamAllColSum_15" value="${endTeamAllSum_12_15 + endTeamAllSum_11_15 + endTeamAllSum_10_15 + endTeamAllSum_09_15 + endTeamAllSum_08_15 + endTeamAllSum_07_15 + endTeamAllSum_06_15 + endTeamAllSum_05_15 + endTeamAllSum_04_15 + endTeamAllSum_03_15 + endTeamAllSum_02_15 + endTeamAllSum_01_15}"></c:set>			                
			                <c:choose>
			                	<c:when test="${timeTeamAllColSum_15 eq 0 or endTeamAllColSum_15 eq 0}">
			                		<c:set var="arvTeamAllColSum_15" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvTeamAllColSum_15" value="${timeTeamAllColSum_15 / endTeamAllColSum_15}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllColSum_15}" pattern="#,##0.##"/></td>
		    				
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="cntTimeTeamAllSum_12_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_11_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_10_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_09_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_08_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_07_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_06_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_05_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_04_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_03_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_02_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_01_15" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="timeTeamAllSum_12_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_11_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_10_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_09_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_08_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_07_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_06_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_05_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_04_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_03_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_02_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_01_15" value="0"></c:set>
											    
							<c:set var="endTeamAllSum_12_15" value="0"></c:set>
							<c:set var="endTeamAllSum_11_15" value="0"></c:set>
							<c:set var="endTeamAllSum_10_15" value="0"></c:set>
							<c:set var="endTeamAllSum_09_15" value="0"></c:set>
							<c:set var="endTeamAllSum_08_15" value="0"></c:set>
							<c:set var="endTeamAllSum_07_15" value="0"></c:set>
							<c:set var="endTeamAllSum_06_15" value="0"></c:set>
							<c:set var="endTeamAllSum_05_15" value="0"></c:set>
							<c:set var="endTeamAllSum_04_15" value="0"></c:set>
							<c:set var="endTeamAllSum_03_15" value="0"></c:set>
							<c:set var="endTeamAllSum_02_15" value="0"></c:set>
							<c:set var="endTeamAllSum_01_15" value="0"></c:set>				            				            
		    			</c:when>
		    			<c:when test="${vo2.rowCnt == 1}">
		    				<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="cntTimeTeamAllSum_12_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_11_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_10_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_09_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_08_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_07_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_06_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_05_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_04_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_03_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_02_15" value="0"></c:set>
				            <c:set var="cntTimeTeamAllSum_01_15" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="timeTeamAllSum_12_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_11_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_10_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_09_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_08_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_07_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_06_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_05_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_04_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_03_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_02_15" value="0"></c:set>
							<c:set var="timeTeamAllSum_01_15" value="0"></c:set>
											    
							<c:set var="endTeamAllSum_12_15" value="0"></c:set>
							<c:set var="endTeamAllSum_11_15" value="0"></c:set>
							<c:set var="endTeamAllSum_10_15" value="0"></c:set>
							<c:set var="endTeamAllSum_09_15" value="0"></c:set>
							<c:set var="endTeamAllSum_08_15" value="0"></c:set>
							<c:set var="endTeamAllSum_07_15" value="0"></c:set>
							<c:set var="endTeamAllSum_06_15" value="0"></c:set>
							<c:set var="endTeamAllSum_05_15" value="0"></c:set>
							<c:set var="endTeamAllSum_04_15" value="0"></c:set>
							<c:set var="endTeamAllSum_03_15" value="0"></c:set>
							<c:set var="endTeamAllSum_02_15" value="0"></c:set>
							<c:set var="endTeamAllSum_01_15" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 팀별 계 카운트 증가 -->
		    				<c:set var="teamCnt" value="${teamCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 팀별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 기타 소계 시작 -->
		    	<c:if test="${ptnrStatTeamAllCntTimeList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="4" style="height:25px;">1종 기타 평균</th>
	                <c:choose>
    					<c:when test="${timeTeamAllTotalSum_12_15 eq 0 or endTeamAllTotalSum_12_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_12_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_12_15" value="${timeTeamAllTotalSum_12_15 / endTeamAllTotalSum_12_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_11_15 eq 0 or endTeamAllTotalSum_11_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_11_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_11_15" value="${timeTeamAllTotalSum_11_15 / endTeamAllTotalSum_11_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_10_15 eq 0 or endTeamAllTotalSum_10_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_10_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_10_15" value="${timeTeamAllTotalSum_10_15 / endTeamAllTotalSum_10_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_09_15 eq 0 or endTeamAllTotalSum_09_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_09_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_09_15" value="${timeTeamAllTotalSum_09_15 / endTeamAllTotalSum_09_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_08_15 eq 0 or endTeamAllTotalSum_08_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_08_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_08_15" value="${timeTeamAllTotalSum_08_15 / endTeamAllTotalSum_08_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_07_15 eq 0 or endTeamAllTotalSum_07_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_07_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_07_15" value="${timeTeamAllTotalSum_07_15 / endTeamAllTotalSum_07_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_06_15 eq 0 or endTeamAllTotalSum_06_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_06_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_06_15" value="${timeTeamAllTotalSum_06_15 / endTeamAllTotalSum_06_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_05_15 eq 0 or endTeamAllTotalSum_05_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_05_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_05_15" value="${timeTeamAllTotalSum_05_15 / endTeamAllTotalSum_05_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_04_15 eq 0 or endTeamAllTotalSum_04_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_04_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_04_15" value="${timeTeamAllTotalSum_04_15 / endTeamAllTotalSum_04_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_03_15 eq 0 or endTeamAllTotalSum_03_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_03_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_03_15" value="${timeTeamAllTotalSum_03_15 / endTeamAllTotalSum_03_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_02_15 eq 0 or endTeamAllTotalSum_02_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_02_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_02_15" value="${timeTeamAllTotalSum_02_15 / endTeamAllTotalSum_02_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeTeamAllTotalSum_01_15 eq 0 or endTeamAllTotalSum_01_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_01_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_01_15" value="${timeTeamAllTotalSum_01_15 / endTeamAllTotalSum_01_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 팀별 평균 계산 끝 -->
    						    				
    				<!-- cntTime12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_12_15}" pattern="#,##0.##"/></th>
    				<!-- cntTime11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_11_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_10_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_09_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_08_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_07_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_06_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_05_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_04_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_03_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_02_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_01_15}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="timeColTeamAllTotalSum_15" value="${timeTeamAllTotalSum_12_15 + timeTeamAllTotalSum_11_15 + timeTeamAllTotalSum_10_15 + timeTeamAllTotalSum_09_15 + timeTeamAllTotalSum_08_15 + timeTeamAllTotalSum_07_15 + timeTeamAllTotalSum_06_15 + timeTeamAllTotalSum_05_15 + timeTeamAllTotalSum_04_15 + timeTeamAllTotalSum_03_15 + timeTeamAllTotalSum_02_15 + timeTeamAllTotalSum_01_15}"></c:set>
	                <c:set var="endColTeamAllTotalSum_15" value="${endTeamAllTotalSum_12_15 + endTeamAllTotalSum_11_15 + endTeamAllTotalSum_10_15 + endTeamAllTotalSum_09_15 + endTeamAllTotalSum_08_15 + endTeamAllTotalSum_07_15 + endTeamAllTotalSum_06_15 + endTeamAllTotalSum_05_15 + endTeamAllTotalSum_04_15 + endTeamAllTotalSum_03_15 + endTeamAllTotalSum_02_15 + endTeamAllTotalSum_01_15}"></c:set>
					<c:choose>
	                	<c:when test="${timeColTeamAllTotalSum_15 eq 0 or endColTeamAllTotalSum_15 eq 0}">
	                		<c:set var="arvColTeamAllTotalSum_15" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColTeamAllTotalSum_15" value="${timeColTeamAllTotalSum_15 / endColTeamAllTotalSum_15}"/>
	                	</c:otherwise>
					</c:choose>
	                
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvColTeamAllTotalSum_15}" pattern="#,##0.##"/></th>
	            </tr>
	            </c:if>
		    	<!-- 1종 기타 소계 끝 -->
    		</tbody>
    	</table>
    	<!-- 1종 기타 끝 -->  	        
    </div>    
    <!-- 총 합계 시작 -->
    <!-- 총 합계 변수 시작 -->
    <c:set var="cntTimeTeamAllTotalSum_12_all" value="${cntTimeTeamAllTotalSum_12_5 + cntTimeTeamAllTotalSum_12_10 + cntTimeTeamAllTotalSum_12_15}"></c:set>
    <c:set var="cntTimeTeamAllTotalSum_11_all" value="${cntTimeTeamAllTotalSum_11_5 + cntTimeTeamAllTotalSum_11_10 + cntTimeTeamAllTotalSum_11_15}"></c:set>
    <c:set var="cntTimeTeamAllTotalSum_10_all" value="${cntTimeTeamAllTotalSum_10_5 + cntTimeTeamAllTotalSum_10_10 + cntTimeTeamAllTotalSum_10_15}"></c:set>
    <c:set var="cntTimeTeamAllTotalSum_09_all" value="${cntTimeTeamAllTotalSum_09_5 + cntTimeTeamAllTotalSum_09_10 + cntTimeTeamAllTotalSum_09_15}"></c:set>
    <c:set var="cntTimeTeamAllTotalSum_08_all" value="${cntTimeTeamAllTotalSum_08_5 + cntTimeTeamAllTotalSum_08_10 + cntTimeTeamAllTotalSum_08_15}"></c:set>
    <c:set var="cntTimeTeamAllTotalSum_07_all" value="${cntTimeTeamAllTotalSum_07_5 + cntTimeTeamAllTotalSum_07_10 + cntTimeTeamAllTotalSum_07_15}"></c:set>
    <c:set var="cntTimeTeamAllTotalSum_06_all" value="${cntTimeTeamAllTotalSum_06_5 + cntTimeTeamAllTotalSum_06_10 + cntTimeTeamAllTotalSum_06_15}"></c:set>
    <c:set var="cntTimeTeamAllTotalSum_05_all" value="${cntTimeTeamAllTotalSum_05_5 + cntTimeTeamAllTotalSum_05_10 + cntTimeTeamAllTotalSum_05_15}"></c:set>
    <c:set var="cntTimeTeamAllTotalSum_04_all" value="${cntTimeTeamAllTotalSum_04_5 + cntTimeTeamAllTotalSum_04_10 + cntTimeTeamAllTotalSum_04_15}"></c:set>
    <c:set var="cntTimeTeamAllTotalSum_03_all" value="${cntTimeTeamAllTotalSum_03_5 + cntTimeTeamAllTotalSum_03_10 + cntTimeTeamAllTotalSum_03_15}"></c:set>
    <c:set var="cntTimeTeamAllTotalSum_02_all" value="${cntTimeTeamAllTotalSum_02_5 + cntTimeTeamAllTotalSum_02_10 + cntTimeTeamAllTotalSum_02_15}"></c:set>
    <c:set var="cntTimeTeamAllTotalSum_01_all" value="${cntTimeTeamAllTotalSum_01_5 + cntTimeTeamAllTotalSum_01_10 + cntTimeTeamAllTotalSum_01_15}"></c:set>        
    <c:set var="cntTimeTeamAllTotalSum_col_all" value="${cntTimeTeamAllTotalSum_12_all + cntTimeTeamAllTotalSum_11_all + cntTimeTeamAllTotalSum_10_all + cntTimeTeamAllTotalSum_09_all + cntTimeTeamAllTotalSum_08_all + cntTimeTeamAllTotalSum_07_all + cntTimeTeamAllTotalSum_06_all + cntTimeTeamAllTotalSum_05_all + cntTimeTeamAllTotalSum_04_all + cntTimeTeamAllTotalSum_03_all + cntTimeTeamAllTotalSum_02_all + cntTimeTeamAllTotalSum_01_all}"></c:set>
    
    <c:set var="timeTeamAllTotalSum_12_all" value="${timeTeamAllTotalSum_12_5 + timeTeamAllTotalSum_12_10 + timeTeamAllTotalSum_12_15}"></c:set>
    <c:set var="timeTeamAllTotalSum_11_all" value="${timeTeamAllTotalSum_11_5 + timeTeamAllTotalSum_11_10 + timeTeamAllTotalSum_11_15}"></c:set>
    <c:set var="timeTeamAllTotalSum_10_all" value="${timeTeamAllTotalSum_10_5 + timeTeamAllTotalSum_10_10 + timeTeamAllTotalSum_10_15}"></c:set>
    <c:set var="timeTeamAllTotalSum_09_all" value="${timeTeamAllTotalSum_09_5 + timeTeamAllTotalSum_09_10 + timeTeamAllTotalSum_09_15}"></c:set>
    <c:set var="timeTeamAllTotalSum_08_all" value="${timeTeamAllTotalSum_08_5 + timeTeamAllTotalSum_08_10 + timeTeamAllTotalSum_08_15}"></c:set>
    <c:set var="timeTeamAllTotalSum_07_all" value="${timeTeamAllTotalSum_07_5 + timeTeamAllTotalSum_07_10 + timeTeamAllTotalSum_07_15}"></c:set>
    <c:set var="timeTeamAllTotalSum_06_all" value="${timeTeamAllTotalSum_06_5 + timeTeamAllTotalSum_06_10 + timeTeamAllTotalSum_06_15}"></c:set>
    <c:set var="timeTeamAllTotalSum_05_all" value="${timeTeamAllTotalSum_05_5 + timeTeamAllTotalSum_05_10 + timeTeamAllTotalSum_05_15}"></c:set>
    <c:set var="timeTeamAllTotalSum_04_all" value="${timeTeamAllTotalSum_04_5 + timeTeamAllTotalSum_04_10 + timeTeamAllTotalSum_04_15}"></c:set>
    <c:set var="timeTeamAllTotalSum_03_all" value="${timeTeamAllTotalSum_03_5 + timeTeamAllTotalSum_03_10 + timeTeamAllTotalSum_03_15}"></c:set>
    <c:set var="timeTeamAllTotalSum_02_all" value="${timeTeamAllTotalSum_02_5 + timeTeamAllTotalSum_02_10 + timeTeamAllTotalSum_02_15}"></c:set>
    <c:set var="timeTeamAllTotalSum_01_all" value="${timeTeamAllTotalSum_01_5 + timeTeamAllTotalSum_01_10 + timeTeamAllTotalSum_01_15}"></c:set>
    
    <c:set var="endTeamAllTotalSum_12_all" value="${endTeamAllTotalSum_12_5 + endTeamAllTotalSum_12_10 + endTeamAllTotalSum_12_15}"></c:set>
    <c:set var="endTeamAllTotalSum_11_all" value="${endTeamAllTotalSum_11_5 + endTeamAllTotalSum_11_10 + endTeamAllTotalSum_11_15}"></c:set>
    <c:set var="endTeamAllTotalSum_10_all" value="${endTeamAllTotalSum_10_5 + endTeamAllTotalSum_10_10 + endTeamAllTotalSum_10_15}"></c:set>
    <c:set var="endTeamAllTotalSum_09_all" value="${endTeamAllTotalSum_09_5 + endTeamAllTotalSum_09_10 + endTeamAllTotalSum_09_15}"></c:set>
    <c:set var="endTeamAllTotalSum_08_all" value="${endTeamAllTotalSum_08_5 + endTeamAllTotalSum_08_10 + endTeamAllTotalSum_08_15}"></c:set>
    <c:set var="endTeamAllTotalSum_07_all" value="${endTeamAllTotalSum_07_5 + endTeamAllTotalSum_07_10 + endTeamAllTotalSum_07_15}"></c:set>
    <c:set var="endTeamAllTotalSum_06_all" value="${endTeamAllTotalSum_06_5 + endTeamAllTotalSum_06_10 + endTeamAllTotalSum_06_15}"></c:set>
    <c:set var="endTeamAllTotalSum_05_all" value="${endTeamAllTotalSum_05_5 + endTeamAllTotalSum_05_10 + endTeamAllTotalSum_05_15}"></c:set>
    <c:set var="endTeamAllTotalSum_04_all" value="${endTeamAllTotalSum_04_5 + endTeamAllTotalSum_04_10 + endTeamAllTotalSum_04_15}"></c:set>
    <c:set var="endTeamAllTotalSum_03_all" value="${endTeamAllTotalSum_03_5 + endTeamAllTotalSum_03_10 + endTeamAllTotalSum_03_15}"></c:set>
    <c:set var="endTeamAllTotalSum_02_all" value="${endTeamAllTotalSum_02_5 + endTeamAllTotalSum_02_10 + endTeamAllTotalSum_02_15}"></c:set>
    <c:set var="endTeamAllTotalSum_01_all" value="${endTeamAllTotalSum_01_5 + endTeamAllTotalSum_01_10 + endTeamAllTotalSum_01_15}"></c:set>
    
    <c:choose>
		<c:when test="${timeTeamAllTotalSum_12_all eq 0 or endTeamAllTotalSum_12_all eq 0}">
			<c:set var="arvTeamAllTotalSum_12_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_12_all" value="${timeTeamAllTotalSum_12_all / endTeamAllTotalSum_12_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamAllTotalSum_11_all eq 0 or endTeamAllTotalSum_11_all eq 0}">
			<c:set var="arvTeamAllTotalSum_11_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_11_all" value="${timeTeamAllTotalSum_11_all / endTeamAllTotalSum_11_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamAllTotalSum_10_all eq 0 or endTeamAllTotalSum_10_all eq 0}">
			<c:set var="arvTeamAllTotalSum_10_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_10_all" value="${timeTeamAllTotalSum_10_all / endTeamAllTotalSum_10_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamAllTotalSum_09_all eq 0 or endTeamAllTotalSum_09_all eq 0}">
			<c:set var="arvTeamAllTotalSum_09_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_09_all" value="${timeTeamAllTotalSum_09_all / endTeamAllTotalSum_09_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamAllTotalSum_08_all eq 0 or endTeamAllTotalSum_08_all eq 0}">
			<c:set var="arvTeamAllTotalSum_08_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_08_all" value="${timeTeamAllTotalSum_08_all / endTeamAllTotalSum_08_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamAllTotalSum_07_all eq 0 or endTeamAllTotalSum_07_all eq 0}">
			<c:set var="arvTeamAllTotalSum_07_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_07_all" value="${timeTeamAllTotalSum_07_all / endTeamAllTotalSum_07_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamAllTotalSum_06_all eq 0 or endTeamAllTotalSum_06_all eq 0}">
			<c:set var="arvTeamAllTotalSum_06_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_06_all" value="${timeTeamAllTotalSum_06_all / endTeamAllTotalSum_06_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamAllTotalSum_05_all eq 0 or endTeamAllTotalSum_05_all eq 0}">
			<c:set var="arvTeamAllTotalSum_05_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_05_all" value="${timeTeamAllTotalSum_05_all / endTeamAllTotalSum_05_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamAllTotalSum_04_all eq 0 or endTeamAllTotalSum_04_all eq 0}">
			<c:set var="arvTeamAllTotalSum_04_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_04_all" value="${timeTeamAllTotalSum_04_all / endTeamAllTotalSum_04_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamAllTotalSum_03_all eq 0 or endTeamAllTotalSum_03_all eq 0}">
			<c:set var="arvTeamAllTotalSum_03_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_03_all" value="${timeTeamAllTotalSum_03_all / endTeamAllTotalSum_03_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamAllTotalSum_02_all eq 0 or endTeamAllTotalSum_02_all eq 0}">
			<c:set var="arvTeamAllTotalSum_02_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_02_all" value="${timeTeamAllTotalSum_02_all / endTeamAllTotalSum_02_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeTeamAllTotalSum_01_all eq 0 or endTeamAllTotalSum_01_all eq 0}">
			<c:set var="arvTeamAllTotalSum_01_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_01_all" value="${timeTeamAllTotalSum_01_all / endTeamAllTotalSum_01_all}"></c:set>
		</c:otherwise>
	</c:choose>
	
	<!-- 가로 합계 -->
	<c:set var="timeColTeamAllTotalSum_all" value="${timeTeamAllTotalSum_12_all + timeTeamAllTotalSum_11_all + timeTeamAllTotalSum_10_all + timeTeamAllTotalSum_09_all + timeTeamAllTotalSum_08_all + timeTeamAllTotalSum_07_all + timeTeamAllTotalSum_06_all + timeTeamAllTotalSum_05_all + timeTeamAllTotalSum_04_all + timeTeamAllTotalSum_03_all + timeTeamAllTotalSum_02_all + timeTeamAllTotalSum_01_all}"></c:set>
	<c:set var="endColTeamAllTotalSum_all" value="${endTeamAllTotalSum_12_all + endTeamAllTotalSum_11_all + endTeamAllTotalSum_10_all + endTeamAllTotalSum_09_all + endTeamAllTotalSum_08_all + endTeamAllTotalSum_07_all + endTeamAllTotalSum_06_all + endTeamAllTotalSum_05_all + endTeamAllTotalSum_04_all + endTeamAllTotalSum_03_all + endTeamAllTotalSum_02_all + endTeamAllTotalSum_01_all}"></c:set>
	<c:choose>
		<c:when test="${timeColTeamAllTotalSum_all eq 0 or endColTeamAllTotalSum_all eq 0}">
			<c:set var="arvColTeamAllTotalSum_all" value="0"/>
		</c:when>
		<c:otherwise>
			<c:set var="arvColTeamAllTotalSum_all" value="${timeColTeamAllTotalSum_all / endColTeamAllTotalSum_all}"/>
		</c:otherwise>
	</c:choose>
	    
    <!-- 총 합계 변수 끝 -->
    <div style="padding-right: 17px;background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 530px;height:25px;">전체평균</th>    			    			
    			<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamAllTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamAllTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamAllTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamAllTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamAllTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamAllTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamAllTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamAllTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamAllTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamAllTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamAllTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvTeamAllTotalSum_01_all}" pattern="#,##0.##"/></th>				    			
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvColTeamAllTotalSum_all}" pattern="#,##0.##"/></th>
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>