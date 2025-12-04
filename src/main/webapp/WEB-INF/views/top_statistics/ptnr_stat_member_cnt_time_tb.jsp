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
                <th style="width: 80px;">가로열 평균</th>
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
	            <c:set var="cntTimeMemberSum_12_5" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_11_5" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_10_5" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_09_5" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_08_5" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_07_5" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_06_5" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_05_5" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_04_5" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_03_5" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_02_5" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_01_5" value="0"></c:set>
	            
	            <!-- 직원별 평균 계 초기화 -->
				<c:set var="timeMemberSum_12_5" value="0"></c:set>
				<c:set var="timeMemberSum_11_5" value="0"></c:set>
				<c:set var="timeMemberSum_10_5" value="0"></c:set>
				<c:set var="timeMemberSum_09_5" value="0"></c:set>
				<c:set var="timeMemberSum_08_5" value="0"></c:set>
				<c:set var="timeMemberSum_07_5" value="0"></c:set>
				<c:set var="timeMemberSum_06_5" value="0"></c:set>
				<c:set var="timeMemberSum_05_5" value="0"></c:set>
				<c:set var="timeMemberSum_04_5" value="0"></c:set>
				<c:set var="timeMemberSum_03_5" value="0"></c:set>
				<c:set var="timeMemberSum_02_5" value="0"></c:set>
				<c:set var="timeMemberSum_01_5" value="0"></c:set>
								    
				<c:set var="endMemberSum_12_5" value="0"></c:set>
				<c:set var="endMemberSum_11_5" value="0"></c:set>
				<c:set var="endMemberSum_10_5" value="0"></c:set>
				<c:set var="endMemberSum_09_5" value="0"></c:set>
				<c:set var="endMemberSum_08_5" value="0"></c:set>
				<c:set var="endMemberSum_07_5" value="0"></c:set>
				<c:set var="endMemberSum_06_5" value="0"></c:set>
				<c:set var="endMemberSum_05_5" value="0"></c:set>
				<c:set var="endMemberSum_04_5" value="0"></c:set>
				<c:set var="endMemberSum_03_5" value="0"></c:set>
				<c:set var="endMemberSum_02_5" value="0"></c:set>
				<c:set var="endMemberSum_01_5" value="0"></c:set>
				
	            <!-- Type 별 총 합계 -->
	            <c:set var="cntTimeMemberTotalSum_12_5" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_11_5" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_10_5" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_09_5" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_08_5" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_07_5" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_06_5" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_05_5" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_04_5" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_03_5" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_02_5" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_01_5" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntTimeColMemberTotalSum_5" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="timeMemberTotalSum_12_5" value="0"></c:set>
				<c:set var="timeMemberTotalSum_11_5" value="0"></c:set>
				<c:set var="timeMemberTotalSum_10_5" value="0"></c:set>
				<c:set var="timeMemberTotalSum_09_5" value="0"></c:set>
				<c:set var="timeMemberTotalSum_08_5" value="0"></c:set>
				<c:set var="timeMemberTotalSum_07_5" value="0"></c:set>
				<c:set var="timeMemberTotalSum_06_5" value="0"></c:set>
				<c:set var="timeMemberTotalSum_05_5" value="0"></c:set>
				<c:set var="timeMemberTotalSum_04_5" value="0"></c:set>
				<c:set var="timeMemberTotalSum_03_5" value="0"></c:set>
				<c:set var="timeMemberTotalSum_02_5" value="0"></c:set>
				<c:set var="timeMemberTotalSum_01_5" value="0"></c:set>
				
				<c:set var="endMemberTotalSum_12_5" value="0"></c:set>
				<c:set var="endMemberTotalSum_11_5" value="0"></c:set>
				<c:set var="endMemberTotalSum_10_5" value="0"></c:set>
				<c:set var="endMemberTotalSum_09_5" value="0"></c:set>
				<c:set var="endMemberTotalSum_08_5" value="0"></c:set>
				<c:set var="endMemberTotalSum_07_5" value="0"></c:set>
				<c:set var="endMemberTotalSum_06_5" value="0"></c:set>
				<c:set var="endMemberTotalSum_05_5" value="0"></c:set>
				<c:set var="endMemberTotalSum_04_5" value="0"></c:set>
				<c:set var="endMemberTotalSum_03_5" value="0"></c:set>
				<c:set var="endMemberTotalSum_02_5" value="0"></c:set>
				<c:set var="endMemberTotalSum_01_5" value="0"></c:set>	            
   				    			
    			<c:forEach var="vo" items="${ptnrStatCntTimeList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <c:choose>
		    					<c:when test='${srchArg.tabMenu eq "team"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterCntTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
				                    	1종 조사
				                    </td>
		    					</c:when>
		    					<c:when test='${srchArg.tabMenu eq "member"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterCntTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
				                    	1종 조사
				                    </td>
		    					</c:when>
		    					<c:otherwise>
		    						<td onclick="goPtnrStatMenu('ptnrStatTeamCntTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
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
					            <c:set var="cntTimeMemberSum_12_5" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_11_5" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_10_5" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_09_5" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_08_5" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_07_5" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_06_5" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_05_5" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_04_5" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_03_5" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_02_5" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_01_5" value="0"></c:set>
					            
					            <!-- 직원별 평균 계 초기화 -->
								<c:set var="timeMemberSum_12_5" value="0"></c:set>
								<c:set var="timeMemberSum_11_5" value="0"></c:set>
								<c:set var="timeMemberSum_10_5" value="0"></c:set>
								<c:set var="timeMemberSum_09_5" value="0"></c:set>
								<c:set var="timeMemberSum_08_5" value="0"></c:set>
								<c:set var="timeMemberSum_07_5" value="0"></c:set>
								<c:set var="timeMemberSum_06_5" value="0"></c:set>
								<c:set var="timeMemberSum_05_5" value="0"></c:set>
								<c:set var="timeMemberSum_04_5" value="0"></c:set>
								<c:set var="timeMemberSum_03_5" value="0"></c:set>
								<c:set var="timeMemberSum_02_5" value="0"></c:set>
								<c:set var="timeMemberSum_01_5" value="0"></c:set>
												    
								<c:set var="endMemberSum_12_5" value="0"></c:set>
								<c:set var="endMemberSum_11_5" value="0"></c:set>
								<c:set var="endMemberSum_10_5" value="0"></c:set>
								<c:set var="endMemberSum_09_5" value="0"></c:set>
								<c:set var="endMemberSum_08_5" value="0"></c:set>
								<c:set var="endMemberSum_07_5" value="0"></c:set>
								<c:set var="endMemberSum_06_5" value="0"></c:set>
								<c:set var="endMemberSum_05_5" value="0"></c:set>
								<c:set var="endMemberSum_04_5" value="0"></c:set>
								<c:set var="endMemberSum_03_5" value="0"></c:set>
								<c:set var="endMemberSum_02_5" value="0"></c:set>
								<c:set var="endMemberSum_01_5" value="0"></c:set>
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
		                
		                <!-- 직원별 계 합산 -->
	    				<c:set var="cntTimeMemberSum_12_5" value="${cntTimeMemberSum_12_5+cntTime12_5}"></c:set>
			            <c:set var="cntTimeMemberSum_11_5" value="${cntTimeMemberSum_11_5+cntTime11_5}"></c:set>
			            <c:set var="cntTimeMemberSum_10_5" value="${cntTimeMemberSum_10_5+cntTime10_5}"></c:set>
			            <c:set var="cntTimeMemberSum_09_5" value="${cntTimeMemberSum_09_5+cntTime09_5}"></c:set>
			            <c:set var="cntTimeMemberSum_08_5" value="${cntTimeMemberSum_08_5+cntTime08_5}"></c:set>
			            <c:set var="cntTimeMemberSum_07_5" value="${cntTimeMemberSum_07_5+cntTime07_5}"></c:set>
			            <c:set var="cntTimeMemberSum_06_5" value="${cntTimeMemberSum_06_5+cntTime06_5}"></c:set>
			            <c:set var="cntTimeMemberSum_05_5" value="${cntTimeMemberSum_05_5+cntTime05_5}"></c:set>
			            <c:set var="cntTimeMemberSum_04_5" value="${cntTimeMemberSum_04_5+cntTime04_5}"></c:set>
			            <c:set var="cntTimeMemberSum_03_5" value="${cntTimeMemberSum_03_5+cntTime03_5}"></c:set>
			            <c:set var="cntTimeMemberSum_02_5" value="${cntTimeMemberSum_02_5+cntTime02_5}"></c:set>
			            <c:set var="cntTimeMemberSum_01_5" value="${cntTimeMemberSum_01_5+cntTime01_5}"></c:set>
			            
			            <!-- 직원별 계 평균용 변수 -->
						<c:set var="timeMemberSum_12_5" value="${timeMemberSum_12_5+time12_5}"></c:set>
			            <c:set var="timeMemberSum_11_5" value="${timeMemberSum_11_5+time11_5}"></c:set>
			            <c:set var="timeMemberSum_10_5" value="${timeMemberSum_10_5+time10_5}"></c:set>
			            <c:set var="timeMemberSum_09_5" value="${timeMemberSum_09_5+time09_5}"></c:set>
			            <c:set var="timeMemberSum_08_5" value="${timeMemberSum_08_5+time08_5}"></c:set>
			            <c:set var="timeMemberSum_07_5" value="${timeMemberSum_07_5+time07_5}"></c:set>
			            <c:set var="timeMemberSum_06_5" value="${timeMemberSum_06_5+time06_5}"></c:set>
			            <c:set var="timeMemberSum_05_5" value="${timeMemberSum_05_5+time05_5}"></c:set>
			            <c:set var="timeMemberSum_04_5" value="${timeMemberSum_04_5+time04_5}"></c:set>
			            <c:set var="timeMemberSum_03_5" value="${timeMemberSum_03_5+time03_5}"></c:set>
			            <c:set var="timeMemberSum_02_5" value="${timeMemberSum_02_5+time02_5}"></c:set>
			            <c:set var="timeMemberSum_01_5" value="${timeMemberSum_01_5+time01_5}"></c:set>
				    
						<c:set var="endMemberSum_12_5" value="${endMemberSum_12_5+end12_5}"></c:set>
			            <c:set var="endMemberSum_11_5" value="${endMemberSum_11_5+end11_5}"></c:set>
			            <c:set var="endMemberSum_10_5" value="${endMemberSum_10_5+end10_5}"></c:set>
			            <c:set var="endMemberSum_09_5" value="${endMemberSum_09_5+end09_5}"></c:set>
			            <c:set var="endMemberSum_08_5" value="${endMemberSum_08_5+end08_5}"></c:set>
			            <c:set var="endMemberSum_07_5" value="${endMemberSum_07_5+end07_5}"></c:set>
			            <c:set var="endMemberSum_06_5" value="${endMemberSum_06_5+end06_5}"></c:set>
			            <c:set var="endMemberSum_05_5" value="${endMemberSum_05_5+end05_5}"></c:set>
			            <c:set var="endMemberSum_04_5" value="${endMemberSum_04_5+end04_5}"></c:set>
			            <c:set var="endMemberSum_03_5" value="${endMemberSum_03_5+end03_5}"></c:set>
			            <c:set var="endMemberSum_02_5" value="${endMemberSum_02_5+end02_5}"></c:set>
			            <c:set var="endMemberSum_01_5" value="${endMemberSum_01_5+end01_5}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="cntTimeMemberTotalSum_12_5" value="${cntTimeMemberTotalSum_12_5 + cntTime12_5}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_11_5" value="${cntTimeMemberTotalSum_11_5 + cntTime11_5}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_10_5" value="${cntTimeMemberTotalSum_10_5 + cntTime10_5}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_09_5" value="${cntTimeMemberTotalSum_09_5 + cntTime09_5}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_08_5" value="${cntTimeMemberTotalSum_08_5 + cntTime08_5}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_07_5" value="${cntTimeMemberTotalSum_07_5 + cntTime07_5}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_06_5" value="${cntTimeMemberTotalSum_06_5 + cntTime06_5}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_05_5" value="${cntTimeMemberTotalSum_05_5 + cntTime05_5}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_04_5" value="${cntTimeMemberTotalSum_04_5 + cntTime04_5}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_03_5" value="${cntTimeMemberTotalSum_03_5 + cntTime03_5}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_02_5" value="${cntTimeMemberTotalSum_02_5 + cntTime02_5}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_01_5" value="${cntTimeMemberTotalSum_01_5 + cntTime01_5}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="timeMemberTotalSum_12_5" value="${timeMemberTotalSum_12_5 + time12_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_11_5" value="${timeMemberTotalSum_11_5 + time11_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_10_5" value="${timeMemberTotalSum_10_5 + time10_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_09_5" value="${timeMemberTotalSum_09_5 + time09_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_08_5" value="${timeMemberTotalSum_08_5 + time08_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_07_5" value="${timeMemberTotalSum_07_5 + time07_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_06_5" value="${timeMemberTotalSum_06_5 + time06_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_05_5" value="${timeMemberTotalSum_05_5 + time05_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_04_5" value="${timeMemberTotalSum_04_5 + time04_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_03_5" value="${timeMemberTotalSum_03_5 + time03_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_02_5" value="${timeMemberTotalSum_02_5 + time02_5}"></c:set>
	                    <c:set var="timeMemberTotalSum_01_5" value="${timeMemberTotalSum_01_5 + time01_5}"></c:set>

						<c:set var="endMemberTotalSum_12_5" value="${endMemberTotalSum_12_5 + end12_5}"></c:set>
	                    <c:set var="endMemberTotalSum_11_5" value="${endMemberTotalSum_11_5 + end11_5}"></c:set>
	                    <c:set var="endMemberTotalSum_10_5" value="${endMemberTotalSum_10_5 + end10_5}"></c:set>
	                    <c:set var="endMemberTotalSum_09_5" value="${endMemberTotalSum_09_5 + end09_5}"></c:set>
	                    <c:set var="endMemberTotalSum_08_5" value="${endMemberTotalSum_08_5 + end08_5}"></c:set>
	                    <c:set var="endMemberTotalSum_07_5" value="${endMemberTotalSum_07_5 + end07_5}"></c:set>
	                    <c:set var="endMemberTotalSum_06_5" value="${endMemberTotalSum_06_5 + end06_5}"></c:set>
	                    <c:set var="endMemberTotalSum_05_5" value="${endMemberTotalSum_05_5 + end05_5}"></c:set>
	                    <c:set var="endMemberTotalSum_04_5" value="${endMemberTotalSum_04_5 + end04_5}"></c:set>
	                    <c:set var="endMemberTotalSum_03_5" value="${endMemberTotalSum_03_5 + end03_5}"></c:set>
	                    <c:set var="endMemberTotalSum_02_5" value="${endMemberTotalSum_02_5 + end02_5}"></c:set>
	                    <c:set var="endMemberTotalSum_01_5" value="${endMemberTotalSum_01_5 + end01_5}"></c:set>
		    		</tr>
		    		<!-- 직원별 소계 시작 -->
		    		
		    		<!-- 직원별 평균 계산 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${memberCnt == vo.rowCnt and vo.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">${vo.userName} 평균</td>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_12_5 eq 0 or endMemberSum_12_5 eq 0}">
		    						<c:set var="arvMemberSum_12_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_12_5" value="${timeMemberSum_12_5 / endMemberSum_12_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_11_5 eq 0 or endMemberSum_11_5 eq 0}">
		    						<c:set var="arvMemberSum_11_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_11_5" value="${timeMemberSum_11_5 / endMemberSum_11_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_10_5 eq 0 or endMemberSum_10_5 eq 0}">
		    						<c:set var="arvMemberSum_10_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_10_5" value="${timeMemberSum_10_5 / endMemberSum_10_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_09_5 eq 0 or endMemberSum_09_5 eq 0}">
		    						<c:set var="arvMemberSum_09_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_09_5" value="${timeMemberSum_09_5 / endMemberSum_09_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_08_5 eq 0 or endMemberSum_08_5 eq 0}">
		    						<c:set var="arvMemberSum_08_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_08_5" value="${timeMemberSum_08_5 / endMemberSum_08_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_07_5 eq 0 or endMemberSum_07_5 eq 0}">
		    						<c:set var="arvMemberSum_07_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_07_5" value="${timeMemberSum_07_5 / endMemberSum_07_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_06_5 eq 0 or endMemberSum_06_5 eq 0}">
		    						<c:set var="arvMemberSum_06_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_06_5" value="${timeMemberSum_06_5 / endMemberSum_06_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_05_5 eq 0 or endMemberSum_05_5 eq 0}">
		    						<c:set var="arvMemberSum_05_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_05_5" value="${timeMemberSum_05_5 / endMemberSum_05_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_04_5 eq 0 or endMemberSum_04_5 eq 0}">
		    						<c:set var="arvMemberSum_04_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_04_5" value="${timeMemberSum_04_5 / endMemberSum_04_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_03_5 eq 0 or endMemberSum_03_5 eq 0}">
		    						<c:set var="arvMemberSum_03_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_03_5" value="${timeMemberSum_03_5 / endMemberSum_03_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_02_5 eq 0 or endMemberSum_02_5 eq 0}">
		    						<c:set var="arvMemberSum_02_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_02_5" value="${timeMemberSum_02_5 / endMemberSum_02_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_01_5 eq 0 or endMemberSum_01_5 eq 0}">
		    						<c:set var="arvMemberSum_01_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_01_5" value="${timeMemberSum_01_5 / endMemberSum_01_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 직원별 평균 계산 끝 -->
		    						    				
		    				<!-- cntTime12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_12_5}" pattern="#,##0.##"/></td>
		    				<!-- cntTime11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_11_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_10_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_09_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_08_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_07_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_06_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_05_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_04_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_03_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_02_5}" pattern="#,##0.##"/></td>
			                <!-- cntTime01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_01_5}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="timeMemberColSum_5" value="${timeMemberSum_12_5 + timeMemberSum_11_5 + timeMemberSum_10_5 + timeMemberSum_09_5 + timeMemberSum_08_5 + timeMemberSum_07_5 + timeMemberSum_06_5 + timeMemberSum_05_5 + timeMemberSum_04_5 + timeMemberSum_03_5 + timeMemberSum_02_5 + timeMemberSum_01_5}"></c:set>
			                <c:set var="endMemberColSum_5" value="${endMemberSum_12_5 + endMemberSum_11_5 + endMemberSum_10_5 + endMemberSum_09_5 + endMemberSum_08_5 + endMemberSum_07_5 + endMemberSum_06_5 + endMemberSum_05_5 + endMemberSum_04_5 + endMemberSum_03_5 + endMemberSum_02_5 + endMemberSum_01_5}"></c:set>			                
			                <c:choose>
			                	<c:when test="${timeMemberColSum_5 eq 0 or endMemberColSum_5 eq 0}">
			                		<c:set var="arvMemberColSum_5" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvMemberColSum_5" value="${timeMemberColSum_5 / endMemberColSum_5}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberColSum_5}" pattern="#,##0.##"/></td>
		    				
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="cntTimeMemberSum_12_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_11_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_10_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_09_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_08_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_07_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_06_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_05_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_04_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_03_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_02_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_01_5" value="0"></c:set>
				            
				            <!-- 직원별 평균 계 초기화 -->
							<c:set var="timeMemberSum_12_5" value="0"></c:set>
							<c:set var="timeMemberSum_11_5" value="0"></c:set>
							<c:set var="timeMemberSum_10_5" value="0"></c:set>
							<c:set var="timeMemberSum_09_5" value="0"></c:set>
							<c:set var="timeMemberSum_08_5" value="0"></c:set>
							<c:set var="timeMemberSum_07_5" value="0"></c:set>
							<c:set var="timeMemberSum_06_5" value="0"></c:set>
							<c:set var="timeMemberSum_05_5" value="0"></c:set>
							<c:set var="timeMemberSum_04_5" value="0"></c:set>
							<c:set var="timeMemberSum_03_5" value="0"></c:set>
							<c:set var="timeMemberSum_02_5" value="0"></c:set>
							<c:set var="timeMemberSum_01_5" value="0"></c:set>
											    
							<c:set var="endMemberSum_12_5" value="0"></c:set>
							<c:set var="endMemberSum_11_5" value="0"></c:set>
							<c:set var="endMemberSum_10_5" value="0"></c:set>
							<c:set var="endMemberSum_09_5" value="0"></c:set>
							<c:set var="endMemberSum_08_5" value="0"></c:set>
							<c:set var="endMemberSum_07_5" value="0"></c:set>
							<c:set var="endMemberSum_06_5" value="0"></c:set>
							<c:set var="endMemberSum_05_5" value="0"></c:set>
							<c:set var="endMemberSum_04_5" value="0"></c:set>
							<c:set var="endMemberSum_03_5" value="0"></c:set>
							<c:set var="endMemberSum_02_5" value="0"></c:set>
							<c:set var="endMemberSum_01_5" value="0"></c:set>				            				            
		    			</c:when>
		    			<c:when test="${vo.rowCnt == 1}">
		    				<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="cntTimeMemberSum_12_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_11_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_10_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_09_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_08_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_07_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_06_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_05_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_04_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_03_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_02_5" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_01_5" value="0"></c:set>
				            
				            <!-- 직원별 평균 계 초기화 -->
							<c:set var="timeMemberSum_12_5" value="0"></c:set>
							<c:set var="timeMemberSum_11_5" value="0"></c:set>
							<c:set var="timeMemberSum_10_5" value="0"></c:set>
							<c:set var="timeMemberSum_09_5" value="0"></c:set>
							<c:set var="timeMemberSum_08_5" value="0"></c:set>
							<c:set var="timeMemberSum_07_5" value="0"></c:set>
							<c:set var="timeMemberSum_06_5" value="0"></c:set>
							<c:set var="timeMemberSum_05_5" value="0"></c:set>
							<c:set var="timeMemberSum_04_5" value="0"></c:set>
							<c:set var="timeMemberSum_03_5" value="0"></c:set>
							<c:set var="timeMemberSum_02_5" value="0"></c:set>
							<c:set var="timeMemberSum_01_5" value="0"></c:set>
											    
							<c:set var="endMemberSum_12_5" value="0"></c:set>
							<c:set var="endMemberSum_11_5" value="0"></c:set>
							<c:set var="endMemberSum_10_5" value="0"></c:set>
							<c:set var="endMemberSum_09_5" value="0"></c:set>
							<c:set var="endMemberSum_08_5" value="0"></c:set>
							<c:set var="endMemberSum_07_5" value="0"></c:set>
							<c:set var="endMemberSum_06_5" value="0"></c:set>
							<c:set var="endMemberSum_05_5" value="0"></c:set>
							<c:set var="endMemberSum_04_5" value="0"></c:set>
							<c:set var="endMemberSum_03_5" value="0"></c:set>
							<c:set var="endMemberSum_02_5" value="0"></c:set>
							<c:set var="endMemberSum_01_5" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 직원별 계 카운트 증가 -->
		    				<c:set var="memberCnt" value="${memberCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 직원별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 조사 소계 시작 -->
		    	<c:if test="${ptnrStatCntTimeList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 조사 평균</th>
	                <c:choose>
    					<c:when test="${timeMemberTotalSum_12_5 eq 0 or endMemberTotalSum_12_5 eq 0}">
    						<c:set var="arvMemberTotalSum_12_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_12_5" value="${timeMemberTotalSum_12_5 / endMemberTotalSum_12_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_11_5 eq 0 or endMemberTotalSum_11_5 eq 0}">
    						<c:set var="arvMemberTotalSum_11_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_11_5" value="${timeMemberTotalSum_11_5 / endMemberTotalSum_11_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_10_5 eq 0 or endMemberTotalSum_10_5 eq 0}">
    						<c:set var="arvMemberTotalSum_10_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_10_5" value="${timeMemberTotalSum_10_5 / endMemberTotalSum_10_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_09_5 eq 0 or endMemberTotalSum_09_5 eq 0}">
    						<c:set var="arvMemberTotalSum_09_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_09_5" value="${timeMemberTotalSum_09_5 / endMemberTotalSum_09_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_08_5 eq 0 or endMemberTotalSum_08_5 eq 0}">
    						<c:set var="arvMemberTotalSum_08_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_08_5" value="${timeMemberTotalSum_08_5 / endMemberTotalSum_08_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_07_5 eq 0 or endMemberTotalSum_07_5 eq 0}">
    						<c:set var="arvMemberTotalSum_07_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_07_5" value="${timeMemberTotalSum_07_5 / endMemberTotalSum_07_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_06_5 eq 0 or endMemberTotalSum_06_5 eq 0}">
    						<c:set var="arvMemberTotalSum_06_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_06_5" value="${timeMemberTotalSum_06_5 / endMemberTotalSum_06_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_05_5 eq 0 or endMemberTotalSum_05_5 eq 0}">
    						<c:set var="arvMemberTotalSum_05_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_05_5" value="${timeMemberTotalSum_05_5 / endMemberTotalSum_05_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_04_5 eq 0 or endMemberTotalSum_04_5 eq 0}">
    						<c:set var="arvMemberTotalSum_04_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_04_5" value="${timeMemberTotalSum_04_5 / endMemberTotalSum_04_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_03_5 eq 0 or endMemberTotalSum_03_5 eq 0}">
    						<c:set var="arvMemberTotalSum_03_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_03_5" value="${timeMemberTotalSum_03_5 / endMemberTotalSum_03_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_02_5 eq 0 or endMemberTotalSum_02_5 eq 0}">
    						<c:set var="arvMemberTotalSum_02_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_02_5" value="${timeMemberTotalSum_02_5 / endMemberTotalSum_02_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_01_5 eq 0 or endMemberTotalSum_01_5 eq 0}">
    						<c:set var="arvMemberTotalSum_01_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_01_5" value="${timeMemberTotalSum_01_5 / endMemberTotalSum_01_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 직원별 평균 계산 끝 -->
    						    				
    				<!-- cntTime12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_12_5}" pattern="#,##0.##"/></th>
    				<!-- cntTime11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_11_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_10_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_09_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_08_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_07_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_06_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_05_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_04_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_03_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_02_5}" pattern="#,##0.##"/></th>
	                <!-- cntTime01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_01_5}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="timeColMemberTotalSum_5" value="${timeMemberTotalSum_12_5 + timeMemberTotalSum_11_5 + timeMemberTotalSum_10_5 + timeMemberTotalSum_09_5 + timeMemberTotalSum_08_5 + timeMemberTotalSum_07_5 + timeMemberTotalSum_06_5 + timeMemberTotalSum_05_5 + timeMemberTotalSum_04_5 + timeMemberTotalSum_03_5 + timeMemberTotalSum_02_5 + timeMemberTotalSum_01_5}"></c:set>
	                <c:set var="endColMemberTotalSum_5" value="${endMemberTotalSum_12_5 + endMemberTotalSum_11_5 + endMemberTotalSum_10_5 + endMemberTotalSum_09_5 + endMemberTotalSum_08_5 + endMemberTotalSum_07_5 + endMemberTotalSum_06_5 + endMemberTotalSum_05_5 + endMemberTotalSum_04_5 + endMemberTotalSum_03_5 + endMemberTotalSum_02_5 + endMemberTotalSum_01_5}"></c:set>
					<c:choose>
	                	<c:when test="${timeColMemberTotalSum_5 eq 0 or endColMemberTotalSum_5 eq 0}">
	                		<c:set var="arvColMemberTotalSum_5" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColMemberTotalSum_5" value="${timeColMemberTotalSum_5 / endColMemberTotalSum_5}"/>
	                	</c:otherwise>
					</c:choose>
	                
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvColMemberTotalSum_5}" pattern="#,##0.##"/></th>
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
	            <c:set var="cntTimeMemberSum_12_10" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_11_10" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_10_10" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_09_10" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_08_10" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_07_10" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_06_10" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_05_10" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_04_10" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_03_10" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_02_10" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_01_10" value="0"></c:set>
	            
	            <!-- 직원별 평균 계 초기화 -->
				<c:set var="timeMemberSum_12_10" value="0"></c:set>
				<c:set var="timeMemberSum_11_10" value="0"></c:set>
				<c:set var="timeMemberSum_10_10" value="0"></c:set>
				<c:set var="timeMemberSum_09_10" value="0"></c:set>
				<c:set var="timeMemberSum_08_10" value="0"></c:set>
				<c:set var="timeMemberSum_07_10" value="0"></c:set>
				<c:set var="timeMemberSum_06_10" value="0"></c:set>
				<c:set var="timeMemberSum_05_10" value="0"></c:set>
				<c:set var="timeMemberSum_04_10" value="0"></c:set>
				<c:set var="timeMemberSum_03_10" value="0"></c:set>
				<c:set var="timeMemberSum_02_10" value="0"></c:set>
				<c:set var="timeMemberSum_01_10" value="0"></c:set>
								    
				<c:set var="endMemberSum_12_10" value="0"></c:set>
				<c:set var="endMemberSum_11_10" value="0"></c:set>
				<c:set var="endMemberSum_10_10" value="0"></c:set>
				<c:set var="endMemberSum_09_10" value="0"></c:set>
				<c:set var="endMemberSum_08_10" value="0"></c:set>
				<c:set var="endMemberSum_07_10" value="0"></c:set>
				<c:set var="endMemberSum_06_10" value="0"></c:set>
				<c:set var="endMemberSum_05_10" value="0"></c:set>
				<c:set var="endMemberSum_04_10" value="0"></c:set>
				<c:set var="endMemberSum_03_10" value="0"></c:set>
				<c:set var="endMemberSum_02_10" value="0"></c:set>
				<c:set var="endMemberSum_01_10" value="0"></c:set>
				
	            <!-- Type 별 총 합계 -->
	            <c:set var="cntTimeMemberTotalSum_12_10" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_11_10" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_10_10" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_09_10" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_08_10" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_07_10" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_06_10" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_05_10" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_04_10" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_03_10" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_02_10" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_01_10" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntTimeColMemberTotalSum_10" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="timeMemberTotalSum_12_10" value="0"></c:set>
				<c:set var="timeMemberTotalSum_11_10" value="0"></c:set>
				<c:set var="timeMemberTotalSum_10_10" value="0"></c:set>
				<c:set var="timeMemberTotalSum_09_10" value="0"></c:set>
				<c:set var="timeMemberTotalSum_08_10" value="0"></c:set>
				<c:set var="timeMemberTotalSum_07_10" value="0"></c:set>
				<c:set var="timeMemberTotalSum_06_10" value="0"></c:set>
				<c:set var="timeMemberTotalSum_05_10" value="0"></c:set>
				<c:set var="timeMemberTotalSum_04_10" value="0"></c:set>
				<c:set var="timeMemberTotalSum_03_10" value="0"></c:set>
				<c:set var="timeMemberTotalSum_02_10" value="0"></c:set>
				<c:set var="timeMemberTotalSum_01_10" value="0"></c:set>
				
				<c:set var="endMemberTotalSum_12_10" value="0"></c:set>
				<c:set var="endMemberTotalSum_11_10" value="0"></c:set>
				<c:set var="endMemberTotalSum_10_10" value="0"></c:set>
				<c:set var="endMemberTotalSum_09_10" value="0"></c:set>
				<c:set var="endMemberTotalSum_08_10" value="0"></c:set>
				<c:set var="endMemberTotalSum_07_10" value="0"></c:set>
				<c:set var="endMemberTotalSum_06_10" value="0"></c:set>
				<c:set var="endMemberTotalSum_05_10" value="0"></c:set>
				<c:set var="endMemberTotalSum_04_10" value="0"></c:set>
				<c:set var="endMemberTotalSum_03_10" value="0"></c:set>
				<c:set var="endMemberTotalSum_02_10" value="0"></c:set>
				<c:set var="endMemberTotalSum_01_10" value="0"></c:set>	            
   				    			
    			<c:forEach var="vo1" items="${ptnrStatCntTimeList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <c:choose>
		                    	<c:when test='${srchArg.tabMenu eq "team"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterCntTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
				                    	1종 심사
				                    </td>
		    					</c:when>
		    					<c:when test='${srchArg.tabMenu eq "member"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterCntTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
				                    	1종 심사
				                    </td>
		    					</c:when>
		    					<c:otherwise>
		    						<td onclick="goPtnrStatMenu('ptnrStatTeamCntTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
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
					            <c:set var="cntTimeMemberSum_12_10" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_11_10" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_10_10" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_09_10" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_08_10" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_07_10" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_06_10" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_05_10" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_04_10" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_03_10" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_02_10" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_01_10" value="0"></c:set>
					            
					            <!-- 직원별 평균 계 초기화 -->
								<c:set var="timeMemberSum_12_10" value="0"></c:set>
								<c:set var="timeMemberSum_11_10" value="0"></c:set>
								<c:set var="timeMemberSum_10_10" value="0"></c:set>
								<c:set var="timeMemberSum_09_10" value="0"></c:set>
								<c:set var="timeMemberSum_08_10" value="0"></c:set>
								<c:set var="timeMemberSum_07_10" value="0"></c:set>
								<c:set var="timeMemberSum_06_10" value="0"></c:set>
								<c:set var="timeMemberSum_05_10" value="0"></c:set>
								<c:set var="timeMemberSum_04_10" value="0"></c:set>
								<c:set var="timeMemberSum_03_10" value="0"></c:set>
								<c:set var="timeMemberSum_02_10" value="0"></c:set>
								<c:set var="timeMemberSum_01_10" value="0"></c:set>
												    
								<c:set var="endMemberSum_12_10" value="0"></c:set>
								<c:set var="endMemberSum_11_10" value="0"></c:set>
								<c:set var="endMemberSum_10_10" value="0"></c:set>
								<c:set var="endMemberSum_09_10" value="0"></c:set>
								<c:set var="endMemberSum_08_10" value="0"></c:set>
								<c:set var="endMemberSum_07_10" value="0"></c:set>
								<c:set var="endMemberSum_06_10" value="0"></c:set>
								<c:set var="endMemberSum_05_10" value="0"></c:set>
								<c:set var="endMemberSum_04_10" value="0"></c:set>
								<c:set var="endMemberSum_03_10" value="0"></c:set>
								<c:set var="endMemberSum_02_10" value="0"></c:set>
								<c:set var="endMemberSum_01_10" value="0"></c:set>
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
		                
		                <!-- 직원별 계 합산 -->
	    				<c:set var="cntTimeMemberSum_12_10" value="${cntTimeMemberSum_12_10+cntTime12_10}"></c:set>
			            <c:set var="cntTimeMemberSum_11_10" value="${cntTimeMemberSum_11_10+cntTime11_10}"></c:set>
			            <c:set var="cntTimeMemberSum_10_10" value="${cntTimeMemberSum_10_10+cntTime10_10}"></c:set>
			            <c:set var="cntTimeMemberSum_09_10" value="${cntTimeMemberSum_09_10+cntTime09_10}"></c:set>
			            <c:set var="cntTimeMemberSum_08_10" value="${cntTimeMemberSum_08_10+cntTime08_10}"></c:set>
			            <c:set var="cntTimeMemberSum_07_10" value="${cntTimeMemberSum_07_10+cntTime07_10}"></c:set>
			            <c:set var="cntTimeMemberSum_06_10" value="${cntTimeMemberSum_06_10+cntTime06_10}"></c:set>
			            <c:set var="cntTimeMemberSum_05_10" value="${cntTimeMemberSum_05_10+cntTime05_10}"></c:set>
			            <c:set var="cntTimeMemberSum_04_10" value="${cntTimeMemberSum_04_10+cntTime04_10}"></c:set>
			            <c:set var="cntTimeMemberSum_03_10" value="${cntTimeMemberSum_03_10+cntTime03_10}"></c:set>
			            <c:set var="cntTimeMemberSum_02_10" value="${cntTimeMemberSum_02_10+cntTime02_10}"></c:set>
			            <c:set var="cntTimeMemberSum_01_10" value="${cntTimeMemberSum_01_10+cntTime01_10}"></c:set>
			            
			            <!-- 직원별 계 평균용 변수 -->
						<c:set var="timeMemberSum_12_10" value="${timeMemberSum_12_10+time12_10}"></c:set>
			            <c:set var="timeMemberSum_11_10" value="${timeMemberSum_11_10+time11_10}"></c:set>
			            <c:set var="timeMemberSum_10_10" value="${timeMemberSum_10_10+time10_10}"></c:set>
			            <c:set var="timeMemberSum_09_10" value="${timeMemberSum_09_10+time09_10}"></c:set>
			            <c:set var="timeMemberSum_08_10" value="${timeMemberSum_08_10+time08_10}"></c:set>
			            <c:set var="timeMemberSum_07_10" value="${timeMemberSum_07_10+time07_10}"></c:set>
			            <c:set var="timeMemberSum_06_10" value="${timeMemberSum_06_10+time06_10}"></c:set>
			            <c:set var="timeMemberSum_05_10" value="${timeMemberSum_05_10+time05_10}"></c:set>
			            <c:set var="timeMemberSum_04_10" value="${timeMemberSum_04_10+time04_10}"></c:set>
			            <c:set var="timeMemberSum_03_10" value="${timeMemberSum_03_10+time03_10}"></c:set>
			            <c:set var="timeMemberSum_02_10" value="${timeMemberSum_02_10+time02_10}"></c:set>
			            <c:set var="timeMemberSum_01_10" value="${timeMemberSum_01_10+time01_10}"></c:set>
				    
						<c:set var="endMemberSum_12_10" value="${endMemberSum_12_10+end12_10}"></c:set>
			            <c:set var="endMemberSum_11_10" value="${endMemberSum_11_10+end11_10}"></c:set>
			            <c:set var="endMemberSum_10_10" value="${endMemberSum_10_10+end10_10}"></c:set>
			            <c:set var="endMemberSum_09_10" value="${endMemberSum_09_10+end09_10}"></c:set>
			            <c:set var="endMemberSum_08_10" value="${endMemberSum_08_10+end08_10}"></c:set>
			            <c:set var="endMemberSum_07_10" value="${endMemberSum_07_10+end07_10}"></c:set>
			            <c:set var="endMemberSum_06_10" value="${endMemberSum_06_10+end06_10}"></c:set>
			            <c:set var="endMemberSum_05_10" value="${endMemberSum_05_10+end05_10}"></c:set>
			            <c:set var="endMemberSum_04_10" value="${endMemberSum_04_10+end04_10}"></c:set>
			            <c:set var="endMemberSum_03_10" value="${endMemberSum_03_10+end03_10}"></c:set>
			            <c:set var="endMemberSum_02_10" value="${endMemberSum_02_10+end02_10}"></c:set>
			            <c:set var="endMemberSum_01_10" value="${endMemberSum_01_10+end01_10}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="cntTimeMemberTotalSum_12_10" value="${cntTimeMemberTotalSum_12_10 + cntTime12_10}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_11_10" value="${cntTimeMemberTotalSum_11_10 + cntTime11_10}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_10_10" value="${cntTimeMemberTotalSum_10_10 + cntTime10_10}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_09_10" value="${cntTimeMemberTotalSum_09_10 + cntTime09_10}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_08_10" value="${cntTimeMemberTotalSum_08_10 + cntTime08_10}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_07_10" value="${cntTimeMemberTotalSum_07_10 + cntTime07_10}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_06_10" value="${cntTimeMemberTotalSum_06_10 + cntTime06_10}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_05_10" value="${cntTimeMemberTotalSum_05_10 + cntTime05_10}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_04_10" value="${cntTimeMemberTotalSum_04_10 + cntTime04_10}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_03_10" value="${cntTimeMemberTotalSum_03_10 + cntTime03_10}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_02_10" value="${cntTimeMemberTotalSum_02_10 + cntTime02_10}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_01_10" value="${cntTimeMemberTotalSum_01_10 + cntTime01_10}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="timeMemberTotalSum_12_10" value="${timeMemberTotalSum_12_10 + time12_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_11_10" value="${timeMemberTotalSum_11_10 + time11_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_10_10" value="${timeMemberTotalSum_10_10 + time10_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_09_10" value="${timeMemberTotalSum_09_10 + time09_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_08_10" value="${timeMemberTotalSum_08_10 + time08_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_07_10" value="${timeMemberTotalSum_07_10 + time07_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_06_10" value="${timeMemberTotalSum_06_10 + time06_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_05_10" value="${timeMemberTotalSum_05_10 + time05_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_04_10" value="${timeMemberTotalSum_04_10 + time04_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_03_10" value="${timeMemberTotalSum_03_10 + time03_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_02_10" value="${timeMemberTotalSum_02_10 + time02_10}"></c:set>
	                    <c:set var="timeMemberTotalSum_01_10" value="${timeMemberTotalSum_01_10 + time01_10}"></c:set>

						<c:set var="endMemberTotalSum_12_10" value="${endMemberTotalSum_12_10 + end12_10}"></c:set>
	                    <c:set var="endMemberTotalSum_11_10" value="${endMemberTotalSum_11_10 + end11_10}"></c:set>
	                    <c:set var="endMemberTotalSum_10_10" value="${endMemberTotalSum_10_10 + end10_10}"></c:set>
	                    <c:set var="endMemberTotalSum_09_10" value="${endMemberTotalSum_09_10 + end09_10}"></c:set>
	                    <c:set var="endMemberTotalSum_08_10" value="${endMemberTotalSum_08_10 + end08_10}"></c:set>
	                    <c:set var="endMemberTotalSum_07_10" value="${endMemberTotalSum_07_10 + end07_10}"></c:set>
	                    <c:set var="endMemberTotalSum_06_10" value="${endMemberTotalSum_06_10 + end06_10}"></c:set>
	                    <c:set var="endMemberTotalSum_05_10" value="${endMemberTotalSum_05_10 + end05_10}"></c:set>
	                    <c:set var="endMemberTotalSum_04_10" value="${endMemberTotalSum_04_10 + end04_10}"></c:set>
	                    <c:set var="endMemberTotalSum_03_10" value="${endMemberTotalSum_03_10 + end03_10}"></c:set>
	                    <c:set var="endMemberTotalSum_02_10" value="${endMemberTotalSum_02_10 + end02_10}"></c:set>
	                    <c:set var="endMemberTotalSum_01_10" value="${endMemberTotalSum_01_10 + end01_10}"></c:set>
		    		</tr>
		    		<!-- 직원별 소계 시작 -->
		    		
		    		<!-- 직원별 평균 계산 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${memberCnt == vo1.rowCnt and vo1.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">${vo1.userName} 평균</td>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_12_10 eq 0 or endMemberSum_12_10 eq 0}">
		    						<c:set var="arvMemberSum_12_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_12_10" value="${timeMemberSum_12_10 / endMemberSum_12_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_11_10 eq 0 or endMemberSum_11_10 eq 0}">
		    						<c:set var="arvMemberSum_11_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_11_10" value="${timeMemberSum_11_10 / endMemberSum_11_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_10_10 eq 0 or endMemberSum_10_10 eq 0}">
		    						<c:set var="arvMemberSum_10_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_10_10" value="${timeMemberSum_10_10 / endMemberSum_10_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_09_10 eq 0 or endMemberSum_09_10 eq 0}">
		    						<c:set var="arvMemberSum_09_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_09_10" value="${timeMemberSum_09_10 / endMemberSum_09_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_08_10 eq 0 or endMemberSum_08_10 eq 0}">
		    						<c:set var="arvMemberSum_08_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_08_10" value="${timeMemberSum_08_10 / endMemberSum_08_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_07_10 eq 0 or endMemberSum_07_10 eq 0}">
		    						<c:set var="arvMemberSum_07_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_07_10" value="${timeMemberSum_07_10 / endMemberSum_07_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_06_10 eq 0 or endMemberSum_06_10 eq 0}">
		    						<c:set var="arvMemberSum_06_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_06_10" value="${timeMemberSum_06_10 / endMemberSum_06_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_05_10 eq 0 or endMemberSum_05_10 eq 0}">
		    						<c:set var="arvMemberSum_05_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_05_10" value="${timeMemberSum_05_10 / endMemberSum_05_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_04_10 eq 0 or endMemberSum_04_10 eq 0}">
		    						<c:set var="arvMemberSum_04_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_04_10" value="${timeMemberSum_04_10 / endMemberSum_04_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_03_10 eq 0 or endMemberSum_03_10 eq 0}">
		    						<c:set var="arvMemberSum_03_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_03_10" value="${timeMemberSum_03_10 / endMemberSum_03_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_02_10 eq 0 or endMemberSum_02_10 eq 0}">
		    						<c:set var="arvMemberSum_02_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_02_10" value="${timeMemberSum_02_10 / endMemberSum_02_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_01_10 eq 0 or endMemberSum_01_10 eq 0}">
		    						<c:set var="arvMemberSum_01_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_01_10" value="${timeMemberSum_01_10 / endMemberSum_01_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 직원별 평균 계산 끝 -->
		    						    				
		    				<!-- cntTime12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_12_10}" pattern="#,##0.##"/></td>
		    				<!-- cntTime11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_11_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_10_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_09_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_08_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_07_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_06_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_05_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_04_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_03_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_02_10}" pattern="#,##0.##"/></td>
			                <!-- cntTime01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_01_10}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="timeMemberColSum_10" value="${timeMemberSum_12_10 + timeMemberSum_11_10 + timeMemberSum_10_10 + timeMemberSum_09_10 + timeMemberSum_08_10 + timeMemberSum_07_10 + timeMemberSum_06_10 + timeMemberSum_05_10 + timeMemberSum_04_10 + timeMemberSum_03_10 + timeMemberSum_02_10 + timeMemberSum_01_10}"></c:set>
			                <c:set var="endMemberColSum_10" value="${endMemberSum_12_10 + endMemberSum_11_10 + endMemberSum_10_10 + endMemberSum_09_10 + endMemberSum_08_10 + endMemberSum_07_10 + endMemberSum_06_10 + endMemberSum_05_10 + endMemberSum_04_10 + endMemberSum_03_10 + endMemberSum_02_10 + endMemberSum_01_10}"></c:set>			                
			                <c:choose>
			                	<c:when test="${timeMemberColSum_10 eq 0 or endMemberColSum_10 eq 0}">
			                		<c:set var="arvMemberColSum_10" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvMemberColSum_10" value="${timeMemberColSum_10 / endMemberColSum_10}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberColSum_10}" pattern="#,##0.##"/></td>
		    				
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="cntTimeMemberSum_12_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_11_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_10_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_09_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_08_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_07_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_06_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_05_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_04_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_03_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_02_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_01_10" value="0"></c:set>
				            
				            <!-- 직원별 평균 계 초기화 -->
							<c:set var="timeMemberSum_12_10" value="0"></c:set>
							<c:set var="timeMemberSum_11_10" value="0"></c:set>
							<c:set var="timeMemberSum_10_10" value="0"></c:set>
							<c:set var="timeMemberSum_09_10" value="0"></c:set>
							<c:set var="timeMemberSum_08_10" value="0"></c:set>
							<c:set var="timeMemberSum_07_10" value="0"></c:set>
							<c:set var="timeMemberSum_06_10" value="0"></c:set>
							<c:set var="timeMemberSum_05_10" value="0"></c:set>
							<c:set var="timeMemberSum_04_10" value="0"></c:set>
							<c:set var="timeMemberSum_03_10" value="0"></c:set>
							<c:set var="timeMemberSum_02_10" value="0"></c:set>
							<c:set var="timeMemberSum_01_10" value="0"></c:set>
											    
							<c:set var="endMemberSum_12_10" value="0"></c:set>
							<c:set var="endMemberSum_11_10" value="0"></c:set>
							<c:set var="endMemberSum_10_10" value="0"></c:set>
							<c:set var="endMemberSum_09_10" value="0"></c:set>
							<c:set var="endMemberSum_08_10" value="0"></c:set>
							<c:set var="endMemberSum_07_10" value="0"></c:set>
							<c:set var="endMemberSum_06_10" value="0"></c:set>
							<c:set var="endMemberSum_05_10" value="0"></c:set>
							<c:set var="endMemberSum_04_10" value="0"></c:set>
							<c:set var="endMemberSum_03_10" value="0"></c:set>
							<c:set var="endMemberSum_02_10" value="0"></c:set>
							<c:set var="endMemberSum_01_10" value="0"></c:set>				            				            
		    			</c:when>
		    			<c:when test="${vo1.rowCnt == 1}">
		    				<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="cntTimeMemberSum_12_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_11_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_10_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_09_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_08_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_07_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_06_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_05_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_04_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_03_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_02_10" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_01_10" value="0"></c:set>
				            
				            <!-- 직원별 평균 계 초기화 -->
							<c:set var="timeMemberSum_12_10" value="0"></c:set>
							<c:set var="timeMemberSum_11_10" value="0"></c:set>
							<c:set var="timeMemberSum_10_10" value="0"></c:set>
							<c:set var="timeMemberSum_09_10" value="0"></c:set>
							<c:set var="timeMemberSum_08_10" value="0"></c:set>
							<c:set var="timeMemberSum_07_10" value="0"></c:set>
							<c:set var="timeMemberSum_06_10" value="0"></c:set>
							<c:set var="timeMemberSum_05_10" value="0"></c:set>
							<c:set var="timeMemberSum_04_10" value="0"></c:set>
							<c:set var="timeMemberSum_03_10" value="0"></c:set>
							<c:set var="timeMemberSum_02_10" value="0"></c:set>
							<c:set var="timeMemberSum_01_10" value="0"></c:set>
											    
							<c:set var="endMemberSum_12_10" value="0"></c:set>
							<c:set var="endMemberSum_11_10" value="0"></c:set>
							<c:set var="endMemberSum_10_10" value="0"></c:set>
							<c:set var="endMemberSum_09_10" value="0"></c:set>
							<c:set var="endMemberSum_08_10" value="0"></c:set>
							<c:set var="endMemberSum_07_10" value="0"></c:set>
							<c:set var="endMemberSum_06_10" value="0"></c:set>
							<c:set var="endMemberSum_05_10" value="0"></c:set>
							<c:set var="endMemberSum_04_10" value="0"></c:set>
							<c:set var="endMemberSum_03_10" value="0"></c:set>
							<c:set var="endMemberSum_02_10" value="0"></c:set>
							<c:set var="endMemberSum_01_10" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 직원별 계 카운트 증가 -->
		    				<c:set var="memberCnt" value="${memberCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 직원별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 심사 소계 시작 -->
		    	<c:if test="${ptnrStatCntTimeList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 심사 평균</th>
	                <c:choose>
    					<c:when test="${timeMemberTotalSum_12_10 eq 0 or endMemberTotalSum_12_10 eq 0}">
    						<c:set var="arvMemberTotalSum_12_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_12_10" value="${timeMemberTotalSum_12_10 / endMemberTotalSum_12_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_11_10 eq 0 or endMemberTotalSum_11_10 eq 0}">
    						<c:set var="arvMemberTotalSum_11_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_11_10" value="${timeMemberTotalSum_11_10 / endMemberTotalSum_11_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_10_10 eq 0 or endMemberTotalSum_10_10 eq 0}">
    						<c:set var="arvMemberTotalSum_10_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_10_10" value="${timeMemberTotalSum_10_10 / endMemberTotalSum_10_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_09_10 eq 0 or endMemberTotalSum_09_10 eq 0}">
    						<c:set var="arvMemberTotalSum_09_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_09_10" value="${timeMemberTotalSum_09_10 / endMemberTotalSum_09_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_08_10 eq 0 or endMemberTotalSum_08_10 eq 0}">
    						<c:set var="arvMemberTotalSum_08_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_08_10" value="${timeMemberTotalSum_08_10 / endMemberTotalSum_08_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_07_10 eq 0 or endMemberTotalSum_07_10 eq 0}">
    						<c:set var="arvMemberTotalSum_07_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_07_10" value="${timeMemberTotalSum_07_10 / endMemberTotalSum_07_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_06_10 eq 0 or endMemberTotalSum_06_10 eq 0}">
    						<c:set var="arvMemberTotalSum_06_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_06_10" value="${timeMemberTotalSum_06_10 / endMemberTotalSum_06_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_05_10 eq 0 or endMemberTotalSum_05_10 eq 0}">
    						<c:set var="arvMemberTotalSum_05_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_05_10" value="${timeMemberTotalSum_05_10 / endMemberTotalSum_05_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_04_10 eq 0 or endMemberTotalSum_04_10 eq 0}">
    						<c:set var="arvMemberTotalSum_04_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_04_10" value="${timeMemberTotalSum_04_10 / endMemberTotalSum_04_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_03_10 eq 0 or endMemberTotalSum_03_10 eq 0}">
    						<c:set var="arvMemberTotalSum_03_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_03_10" value="${timeMemberTotalSum_03_10 / endMemberTotalSum_03_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_02_10 eq 0 or endMemberTotalSum_02_10 eq 0}">
    						<c:set var="arvMemberTotalSum_02_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_02_10" value="${timeMemberTotalSum_02_10 / endMemberTotalSum_02_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_01_10 eq 0 or endMemberTotalSum_01_10 eq 0}">
    						<c:set var="arvMemberTotalSum_01_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_01_10" value="${timeMemberTotalSum_01_10 / endMemberTotalSum_01_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 직원별 평균 계산 끝 -->
    						    				
    				<!-- cntTime12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_12_10}" pattern="#,##0.##"/></th>
    				<!-- cntTime11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_11_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_10_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_09_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_08_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_07_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_06_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_05_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_04_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_03_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_02_10}" pattern="#,##0.##"/></th>
	                <!-- cntTime01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_01_10}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="timeColMemberTotalSum_10" value="${timeMemberTotalSum_12_10 + timeMemberTotalSum_11_10 + timeMemberTotalSum_10_10 + timeMemberTotalSum_09_10 + timeMemberTotalSum_08_10 + timeMemberTotalSum_07_10 + timeMemberTotalSum_06_10 + timeMemberTotalSum_05_10 + timeMemberTotalSum_04_10 + timeMemberTotalSum_03_10 + timeMemberTotalSum_02_10 + timeMemberTotalSum_01_10}"></c:set>
	                <c:set var="endColMemberTotalSum_10" value="${endMemberTotalSum_12_10 + endMemberTotalSum_11_10 + endMemberTotalSum_10_10 + endMemberTotalSum_09_10 + endMemberTotalSum_08_10 + endMemberTotalSum_07_10 + endMemberTotalSum_06_10 + endMemberTotalSum_05_10 + endMemberTotalSum_04_10 + endMemberTotalSum_03_10 + endMemberTotalSum_02_10 + endMemberTotalSum_01_10}"></c:set>
					<c:choose>
	                	<c:when test="${timeColMemberTotalSum_10 eq 0 or endColMemberTotalSum_10 eq 0}">
	                		<c:set var="arvColMemberTotalSum_10" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColMemberTotalSum_10" value="${timeColMemberTotalSum_10 / endColMemberTotalSum_10}"/>
	                	</c:otherwise>
					</c:choose>
	                
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvColMemberTotalSum_10}" pattern="#,##0.##"/></th>
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
	            <c:set var="cntTimeMemberSum_12_15" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_11_15" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_10_15" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_09_15" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_08_15" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_07_15" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_06_15" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_05_15" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_04_15" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_03_15" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_02_15" value="0"></c:set>
	            <c:set var="cntTimeMemberSum_01_15" value="0"></c:set>
	            
	            <!-- 직원별 평균 계 초기화 -->
				<c:set var="timeMemberSum_12_15" value="0"></c:set>
				<c:set var="timeMemberSum_11_15" value="0"></c:set>
				<c:set var="timeMemberSum_10_15" value="0"></c:set>
				<c:set var="timeMemberSum_09_15" value="0"></c:set>
				<c:set var="timeMemberSum_08_15" value="0"></c:set>
				<c:set var="timeMemberSum_07_15" value="0"></c:set>
				<c:set var="timeMemberSum_06_15" value="0"></c:set>
				<c:set var="timeMemberSum_05_15" value="0"></c:set>
				<c:set var="timeMemberSum_04_15" value="0"></c:set>
				<c:set var="timeMemberSum_03_15" value="0"></c:set>
				<c:set var="timeMemberSum_02_15" value="0"></c:set>
				<c:set var="timeMemberSum_01_15" value="0"></c:set>
								    
				<c:set var="endMemberSum_12_15" value="0"></c:set>
				<c:set var="endMemberSum_11_15" value="0"></c:set>
				<c:set var="endMemberSum_10_15" value="0"></c:set>
				<c:set var="endMemberSum_09_15" value="0"></c:set>
				<c:set var="endMemberSum_08_15" value="0"></c:set>
				<c:set var="endMemberSum_07_15" value="0"></c:set>
				<c:set var="endMemberSum_06_15" value="0"></c:set>
				<c:set var="endMemberSum_05_15" value="0"></c:set>
				<c:set var="endMemberSum_04_15" value="0"></c:set>
				<c:set var="endMemberSum_03_15" value="0"></c:set>
				<c:set var="endMemberSum_02_15" value="0"></c:set>
				<c:set var="endMemberSum_01_15" value="0"></c:set>
				
	            <!-- Type 별 총 합계 -->
	            <c:set var="cntTimeMemberTotalSum_12_15" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_11_15" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_10_15" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_09_15" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_08_15" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_07_15" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_06_15" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_05_15" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_04_15" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_03_15" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_02_15" value="0"></c:set>
	            <c:set var="cntTimeMemberTotalSum_01_15" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntTimeColMemberTotalSum_15" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="timeMemberTotalSum_12_15" value="0"></c:set>
				<c:set var="timeMemberTotalSum_11_15" value="0"></c:set>
				<c:set var="timeMemberTotalSum_10_15" value="0"></c:set>
				<c:set var="timeMemberTotalSum_09_15" value="0"></c:set>
				<c:set var="timeMemberTotalSum_08_15" value="0"></c:set>
				<c:set var="timeMemberTotalSum_07_15" value="0"></c:set>
				<c:set var="timeMemberTotalSum_06_15" value="0"></c:set>
				<c:set var="timeMemberTotalSum_05_15" value="0"></c:set>
				<c:set var="timeMemberTotalSum_04_15" value="0"></c:set>
				<c:set var="timeMemberTotalSum_03_15" value="0"></c:set>
				<c:set var="timeMemberTotalSum_02_15" value="0"></c:set>
				<c:set var="timeMemberTotalSum_01_15" value="0"></c:set>
				
				<c:set var="endMemberTotalSum_12_15" value="0"></c:set>
				<c:set var="endMemberTotalSum_11_15" value="0"></c:set>
				<c:set var="endMemberTotalSum_10_15" value="0"></c:set>
				<c:set var="endMemberTotalSum_09_15" value="0"></c:set>
				<c:set var="endMemberTotalSum_08_15" value="0"></c:set>
				<c:set var="endMemberTotalSum_07_15" value="0"></c:set>
				<c:set var="endMemberTotalSum_06_15" value="0"></c:set>
				<c:set var="endMemberTotalSum_05_15" value="0"></c:set>
				<c:set var="endMemberTotalSum_04_15" value="0"></c:set>
				<c:set var="endMemberTotalSum_03_15" value="0"></c:set>
				<c:set var="endMemberTotalSum_02_15" value="0"></c:set>
				<c:set var="endMemberTotalSum_01_15" value="0"></c:set>	            
   				    			
    			<c:forEach var="vo2" items="${ptnrStatCntTimeList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <c:choose>
		                    	<c:when test='${srchArg.tabMenu eq "team"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterCntTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
				                    	1종 기타
				                    </td>
		    					</c:when>
		    					<c:when test='${srchArg.tabMenu eq "member"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterCntTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
				                    	1종 기타
				                    </td>
		    					</c:when>
		    					<c:otherwise>
		    						<td onclick="goPtnrStatMenu('ptnrStatTeamCntTime');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
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
					            <c:set var="cntTimeMemberSum_12_15" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_11_15" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_10_15" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_09_15" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_08_15" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_07_15" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_06_15" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_05_15" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_04_15" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_03_15" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_02_15" value="0"></c:set>
					            <c:set var="cntTimeMemberSum_01_15" value="0"></c:set>
					            
					            <!-- 직원별 평균 계 초기화 -->
								<c:set var="timeMemberSum_12_15" value="0"></c:set>
								<c:set var="timeMemberSum_11_15" value="0"></c:set>
								<c:set var="timeMemberSum_10_15" value="0"></c:set>
								<c:set var="timeMemberSum_09_15" value="0"></c:set>
								<c:set var="timeMemberSum_08_15" value="0"></c:set>
								<c:set var="timeMemberSum_07_15" value="0"></c:set>
								<c:set var="timeMemberSum_06_15" value="0"></c:set>
								<c:set var="timeMemberSum_05_15" value="0"></c:set>
								<c:set var="timeMemberSum_04_15" value="0"></c:set>
								<c:set var="timeMemberSum_03_15" value="0"></c:set>
								<c:set var="timeMemberSum_02_15" value="0"></c:set>
								<c:set var="timeMemberSum_01_15" value="0"></c:set>
												    
								<c:set var="endMemberSum_12_15" value="0"></c:set>
								<c:set var="endMemberSum_11_15" value="0"></c:set>
								<c:set var="endMemberSum_10_15" value="0"></c:set>
								<c:set var="endMemberSum_09_15" value="0"></c:set>
								<c:set var="endMemberSum_08_15" value="0"></c:set>
								<c:set var="endMemberSum_07_15" value="0"></c:set>
								<c:set var="endMemberSum_06_15" value="0"></c:set>
								<c:set var="endMemberSum_05_15" value="0"></c:set>
								<c:set var="endMemberSum_04_15" value="0"></c:set>
								<c:set var="endMemberSum_03_15" value="0"></c:set>
								<c:set var="endMemberSum_02_15" value="0"></c:set>
								<c:set var="endMemberSum_01_15" value="0"></c:set>
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
		                
		                <!-- 직원별 계 합산 -->
	    				<c:set var="cntTimeMemberSum_12_15" value="${cntTimeMemberSum_12_15+cntTime12_15}"></c:set>
			            <c:set var="cntTimeMemberSum_11_15" value="${cntTimeMemberSum_11_15+cntTime11_15}"></c:set>
			            <c:set var="cntTimeMemberSum_10_15" value="${cntTimeMemberSum_10_15+cntTime10_15}"></c:set>
			            <c:set var="cntTimeMemberSum_09_15" value="${cntTimeMemberSum_09_15+cntTime09_15}"></c:set>
			            <c:set var="cntTimeMemberSum_08_15" value="${cntTimeMemberSum_08_15+cntTime08_15}"></c:set>
			            <c:set var="cntTimeMemberSum_07_15" value="${cntTimeMemberSum_07_15+cntTime07_15}"></c:set>
			            <c:set var="cntTimeMemberSum_06_15" value="${cntTimeMemberSum_06_15+cntTime06_15}"></c:set>
			            <c:set var="cntTimeMemberSum_05_15" value="${cntTimeMemberSum_05_15+cntTime05_15}"></c:set>
			            <c:set var="cntTimeMemberSum_04_15" value="${cntTimeMemberSum_04_15+cntTime04_15}"></c:set>
			            <c:set var="cntTimeMemberSum_03_15" value="${cntTimeMemberSum_03_15+cntTime03_15}"></c:set>
			            <c:set var="cntTimeMemberSum_02_15" value="${cntTimeMemberSum_02_15+cntTime02_15}"></c:set>
			            <c:set var="cntTimeMemberSum_01_15" value="${cntTimeMemberSum_01_15+cntTime01_15}"></c:set>
			            
			            <!-- 직원별 계 평균용 변수 -->
						<c:set var="timeMemberSum_12_15" value="${timeMemberSum_12_15+time12_15}"></c:set>
			            <c:set var="timeMemberSum_11_15" value="${timeMemberSum_11_15+time11_15}"></c:set>
			            <c:set var="timeMemberSum_10_15" value="${timeMemberSum_10_15+time10_15}"></c:set>
			            <c:set var="timeMemberSum_09_15" value="${timeMemberSum_09_15+time09_15}"></c:set>
			            <c:set var="timeMemberSum_08_15" value="${timeMemberSum_08_15+time08_15}"></c:set>
			            <c:set var="timeMemberSum_07_15" value="${timeMemberSum_07_15+time07_15}"></c:set>
			            <c:set var="timeMemberSum_06_15" value="${timeMemberSum_06_15+time06_15}"></c:set>
			            <c:set var="timeMemberSum_05_15" value="${timeMemberSum_05_15+time05_15}"></c:set>
			            <c:set var="timeMemberSum_04_15" value="${timeMemberSum_04_15+time04_15}"></c:set>
			            <c:set var="timeMemberSum_03_15" value="${timeMemberSum_03_15+time03_15}"></c:set>
			            <c:set var="timeMemberSum_02_15" value="${timeMemberSum_02_15+time02_15}"></c:set>
			            <c:set var="timeMemberSum_01_15" value="${timeMemberSum_01_15+time01_15}"></c:set>
				    
						<c:set var="endMemberSum_12_15" value="${endMemberSum_12_15+end12_15}"></c:set>
			            <c:set var="endMemberSum_11_15" value="${endMemberSum_11_15+end11_15}"></c:set>
			            <c:set var="endMemberSum_10_15" value="${endMemberSum_10_15+end10_15}"></c:set>
			            <c:set var="endMemberSum_09_15" value="${endMemberSum_09_15+end09_15}"></c:set>
			            <c:set var="endMemberSum_08_15" value="${endMemberSum_08_15+end08_15}"></c:set>
			            <c:set var="endMemberSum_07_15" value="${endMemberSum_07_15+end07_15}"></c:set>
			            <c:set var="endMemberSum_06_15" value="${endMemberSum_06_15+end06_15}"></c:set>
			            <c:set var="endMemberSum_05_15" value="${endMemberSum_05_15+end05_15}"></c:set>
			            <c:set var="endMemberSum_04_15" value="${endMemberSum_04_15+end04_15}"></c:set>
			            <c:set var="endMemberSum_03_15" value="${endMemberSum_03_15+end03_15}"></c:set>
			            <c:set var="endMemberSum_02_15" value="${endMemberSum_02_15+end02_15}"></c:set>
			            <c:set var="endMemberSum_01_15" value="${endMemberSum_01_15+end01_15}"></c:set>	
			            
			            <!-- Type 합계 누적 -->
	                    <c:set var="cntTimeMemberTotalSum_12_15" value="${cntTimeMemberTotalSum_12_15 + cntTime12_15}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_11_15" value="${cntTimeMemberTotalSum_11_15 + cntTime11_15}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_10_15" value="${cntTimeMemberTotalSum_10_15 + cntTime10_15}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_09_15" value="${cntTimeMemberTotalSum_09_15 + cntTime09_15}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_08_15" value="${cntTimeMemberTotalSum_08_15 + cntTime08_15}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_07_15" value="${cntTimeMemberTotalSum_07_15 + cntTime07_15}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_06_15" value="${cntTimeMemberTotalSum_06_15 + cntTime06_15}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_05_15" value="${cntTimeMemberTotalSum_05_15 + cntTime05_15}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_04_15" value="${cntTimeMemberTotalSum_04_15 + cntTime04_15}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_03_15" value="${cntTimeMemberTotalSum_03_15 + cntTime03_15}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_02_15" value="${cntTimeMemberTotalSum_02_15 + cntTime02_15}"></c:set>
	                    <c:set var="cntTimeMemberTotalSum_01_15" value="${cntTimeMemberTotalSum_01_15 + cntTime01_15}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="timeMemberTotalSum_12_15" value="${timeMemberTotalSum_12_15 + time12_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_11_15" value="${timeMemberTotalSum_11_15 + time11_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_10_15" value="${timeMemberTotalSum_10_15 + time10_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_09_15" value="${timeMemberTotalSum_09_15 + time09_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_08_15" value="${timeMemberTotalSum_08_15 + time08_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_07_15" value="${timeMemberTotalSum_07_15 + time07_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_06_15" value="${timeMemberTotalSum_06_15 + time06_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_05_15" value="${timeMemberTotalSum_05_15 + time05_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_04_15" value="${timeMemberTotalSum_04_15 + time04_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_03_15" value="${timeMemberTotalSum_03_15 + time03_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_02_15" value="${timeMemberTotalSum_02_15 + time02_15}"></c:set>
	                    <c:set var="timeMemberTotalSum_01_15" value="${timeMemberTotalSum_01_15 + time01_15}"></c:set>

						<c:set var="endMemberTotalSum_12_15" value="${endMemberTotalSum_12_15 + end12_15}"></c:set>
	                    <c:set var="endMemberTotalSum_11_15" value="${endMemberTotalSum_11_15 + end11_15}"></c:set>
	                    <c:set var="endMemberTotalSum_10_15" value="${endMemberTotalSum_10_15 + end10_15}"></c:set>
	                    <c:set var="endMemberTotalSum_09_15" value="${endMemberTotalSum_09_15 + end09_15}"></c:set>
	                    <c:set var="endMemberTotalSum_08_15" value="${endMemberTotalSum_08_15 + end08_15}"></c:set>
	                    <c:set var="endMemberTotalSum_07_15" value="${endMemberTotalSum_07_15 + end07_15}"></c:set>
	                    <c:set var="endMemberTotalSum_06_15" value="${endMemberTotalSum_06_15 + end06_15}"></c:set>
	                    <c:set var="endMemberTotalSum_05_15" value="${endMemberTotalSum_05_15 + end05_15}"></c:set>
	                    <c:set var="endMemberTotalSum_04_15" value="${endMemberTotalSum_04_15 + end04_15}"></c:set>
	                    <c:set var="endMemberTotalSum_03_15" value="${endMemberTotalSum_03_15 + end03_15}"></c:set>
	                    <c:set var="endMemberTotalSum_02_15" value="${endMemberTotalSum_02_15 + end02_15}"></c:set>
	                    <c:set var="endMemberTotalSum_01_15" value="${endMemberTotalSum_01_15 + end01_15}"></c:set>
		    		</tr>
		    		<!-- 직원별 소계 시작 -->
		    		
		    		<!-- 직원별 평균 계산 시작 -->		    		
		    		<c:choose>
		    			<c:when test="${memberCnt == vo2.rowCnt and vo2.rowCnt > 1}">
		    				<td style="width:150px;" class="sum-level-2">${vo2.userName} 평균</td>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_12_15 eq 0 or endMemberSum_12_15 eq 0}">
		    						<c:set var="arvMemberSum_12_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_12_15" value="${timeMemberSum_12_15 / endMemberSum_12_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_11_15 eq 0 or endMemberSum_11_15 eq 0}">
		    						<c:set var="arvMemberSum_11_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_11_15" value="${timeMemberSum_11_15 / endMemberSum_11_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_10_15 eq 0 or endMemberSum_10_15 eq 0}">
		    						<c:set var="arvMemberSum_10_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_10_15" value="${timeMemberSum_10_15 / endMemberSum_10_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_09_15 eq 0 or endMemberSum_09_15 eq 0}">
		    						<c:set var="arvMemberSum_09_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_09_15" value="${timeMemberSum_09_15 / endMemberSum_09_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_08_15 eq 0 or endMemberSum_08_15 eq 0}">
		    						<c:set var="arvMemberSum_08_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_08_15" value="${timeMemberSum_08_15 / endMemberSum_08_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_07_15 eq 0 or endMemberSum_07_15 eq 0}">
		    						<c:set var="arvMemberSum_07_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_07_15" value="${timeMemberSum_07_15 / endMemberSum_07_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_06_15 eq 0 or endMemberSum_06_15 eq 0}">
		    						<c:set var="arvMemberSum_06_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_06_15" value="${timeMemberSum_06_15 / endMemberSum_06_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_05_15 eq 0 or endMemberSum_05_15 eq 0}">
		    						<c:set var="arvMemberSum_05_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_05_15" value="${timeMemberSum_05_15 / endMemberSum_05_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_04_15 eq 0 or endMemberSum_04_15 eq 0}">
		    						<c:set var="arvMemberSum_04_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_04_15" value="${timeMemberSum_04_15 / endMemberSum_04_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_03_15 eq 0 or endMemberSum_03_15 eq 0}">
		    						<c:set var="arvMemberSum_03_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_03_15" value="${timeMemberSum_03_15 / endMemberSum_03_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_02_15 eq 0 or endMemberSum_02_15 eq 0}">
		    						<c:set var="arvMemberSum_02_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_02_15" value="${timeMemberSum_02_15 / endMemberSum_02_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${timeMemberSum_01_15 eq 0 or endMemberSum_01_15 eq 0}">
		    						<c:set var="arvMemberSum_01_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_01_15" value="${timeMemberSum_01_15 / endMemberSum_01_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 직원별 평균 계산 끝 -->
		    						    				
		    				<!-- cntTime12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_12_15}" pattern="#,##0.##"/></td>
		    				<!-- cntTime11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_11_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_10_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_09_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_08_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_07_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_06_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_05_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_04_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_03_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_02_15}" pattern="#,##0.##"/></td>
			                <!-- cntTime01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_01_15}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="timeMemberColSum_15" value="${timeMemberSum_12_15 + timeMemberSum_11_15 + timeMemberSum_10_15 + timeMemberSum_09_15 + timeMemberSum_08_15 + timeMemberSum_07_15 + timeMemberSum_06_15 + timeMemberSum_05_15 + timeMemberSum_04_15 + timeMemberSum_03_15 + timeMemberSum_02_15 + timeMemberSum_01_15}"></c:set>
			                <c:set var="endMemberColSum_15" value="${endMemberSum_12_15 + endMemberSum_11_15 + endMemberSum_10_15 + endMemberSum_09_15 + endMemberSum_08_15 + endMemberSum_07_15 + endMemberSum_06_15 + endMemberSum_05_15 + endMemberSum_04_15 + endMemberSum_03_15 + endMemberSum_02_15 + endMemberSum_01_15}"></c:set>			                
			                <c:choose>
			                	<c:when test="${timeMemberColSum_15 eq 0 or endMemberColSum_15 eq 0}">
			                		<c:set var="arvMemberColSum_15" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvMemberColSum_15" value="${timeMemberColSum_15 / endMemberColSum_15}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberColSum_15}" pattern="#,##0.##"/></td>
		    				
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="cntTimeMemberSum_12_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_11_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_10_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_09_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_08_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_07_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_06_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_05_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_04_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_03_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_02_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_01_15" value="0"></c:set>
				            
				            <!-- 직원별 평균 계 초기화 -->
							<c:set var="timeMemberSum_12_15" value="0"></c:set>
							<c:set var="timeMemberSum_11_15" value="0"></c:set>
							<c:set var="timeMemberSum_10_15" value="0"></c:set>
							<c:set var="timeMemberSum_09_15" value="0"></c:set>
							<c:set var="timeMemberSum_08_15" value="0"></c:set>
							<c:set var="timeMemberSum_07_15" value="0"></c:set>
							<c:set var="timeMemberSum_06_15" value="0"></c:set>
							<c:set var="timeMemberSum_05_15" value="0"></c:set>
							<c:set var="timeMemberSum_04_15" value="0"></c:set>
							<c:set var="timeMemberSum_03_15" value="0"></c:set>
							<c:set var="timeMemberSum_02_15" value="0"></c:set>
							<c:set var="timeMemberSum_01_15" value="0"></c:set>
											    
							<c:set var="endMemberSum_12_15" value="0"></c:set>
							<c:set var="endMemberSum_11_15" value="0"></c:set>
							<c:set var="endMemberSum_10_15" value="0"></c:set>
							<c:set var="endMemberSum_09_15" value="0"></c:set>
							<c:set var="endMemberSum_08_15" value="0"></c:set>
							<c:set var="endMemberSum_07_15" value="0"></c:set>
							<c:set var="endMemberSum_06_15" value="0"></c:set>
							<c:set var="endMemberSum_05_15" value="0"></c:set>
							<c:set var="endMemberSum_04_15" value="0"></c:set>
							<c:set var="endMemberSum_03_15" value="0"></c:set>
							<c:set var="endMemberSum_02_15" value="0"></c:set>
							<c:set var="endMemberSum_01_15" value="0"></c:set>				            				            
		    			</c:when>
		    			<c:when test="${vo2.rowCnt == 1}">
		    				<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="cntTimeMemberSum_12_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_11_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_10_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_09_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_08_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_07_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_06_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_05_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_04_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_03_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_02_15" value="0"></c:set>
				            <c:set var="cntTimeMemberSum_01_15" value="0"></c:set>
				            
				            <!-- 직원별 평균 계 초기화 -->
							<c:set var="timeMemberSum_12_15" value="0"></c:set>
							<c:set var="timeMemberSum_11_15" value="0"></c:set>
							<c:set var="timeMemberSum_10_15" value="0"></c:set>
							<c:set var="timeMemberSum_09_15" value="0"></c:set>
							<c:set var="timeMemberSum_08_15" value="0"></c:set>
							<c:set var="timeMemberSum_07_15" value="0"></c:set>
							<c:set var="timeMemberSum_06_15" value="0"></c:set>
							<c:set var="timeMemberSum_05_15" value="0"></c:set>
							<c:set var="timeMemberSum_04_15" value="0"></c:set>
							<c:set var="timeMemberSum_03_15" value="0"></c:set>
							<c:set var="timeMemberSum_02_15" value="0"></c:set>
							<c:set var="timeMemberSum_01_15" value="0"></c:set>
											    
							<c:set var="endMemberSum_12_15" value="0"></c:set>
							<c:set var="endMemberSum_11_15" value="0"></c:set>
							<c:set var="endMemberSum_10_15" value="0"></c:set>
							<c:set var="endMemberSum_09_15" value="0"></c:set>
							<c:set var="endMemberSum_08_15" value="0"></c:set>
							<c:set var="endMemberSum_07_15" value="0"></c:set>
							<c:set var="endMemberSum_06_15" value="0"></c:set>
							<c:set var="endMemberSum_05_15" value="0"></c:set>
							<c:set var="endMemberSum_04_15" value="0"></c:set>
							<c:set var="endMemberSum_03_15" value="0"></c:set>
							<c:set var="endMemberSum_02_15" value="0"></c:set>
							<c:set var="endMemberSum_01_15" value="0"></c:set>
		    			</c:when>
		    			<c:otherwise>
		    				<!-- 직원별 계 카운트 증가 -->
		    				<c:set var="memberCnt" value="${memberCnt+1}"></c:set>		    							            		    				
		    			</c:otherwise>
		    		</c:choose>
		    		<!-- 직원별 소계 끝 -->
		    	</c:forEach>
		    	<!-- 1종 기타 소계 시작 -->
		    	<c:if test="${ptnrStatCntTimeList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 기타 평균</th>
	                <c:choose>
    					<c:when test="${timeMemberTotalSum_12_15 eq 0 or endMemberTotalSum_12_15 eq 0}">
    						<c:set var="arvMemberTotalSum_12_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_12_15" value="${timeMemberTotalSum_12_15 / endMemberTotalSum_12_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_11_15 eq 0 or endMemberTotalSum_11_15 eq 0}">
    						<c:set var="arvMemberTotalSum_11_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_11_15" value="${timeMemberTotalSum_11_15 / endMemberTotalSum_11_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_10_15 eq 0 or endMemberTotalSum_10_15 eq 0}">
    						<c:set var="arvMemberTotalSum_10_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_10_15" value="${timeMemberTotalSum_10_15 / endMemberTotalSum_10_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_09_15 eq 0 or endMemberTotalSum_09_15 eq 0}">
    						<c:set var="arvMemberTotalSum_09_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_09_15" value="${timeMemberTotalSum_09_15 / endMemberTotalSum_09_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_08_15 eq 0 or endMemberTotalSum_08_15 eq 0}">
    						<c:set var="arvMemberTotalSum_08_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_08_15" value="${timeMemberTotalSum_08_15 / endMemberTotalSum_08_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_07_15 eq 0 or endMemberTotalSum_07_15 eq 0}">
    						<c:set var="arvMemberTotalSum_07_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_07_15" value="${timeMemberTotalSum_07_15 / endMemberTotalSum_07_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_06_15 eq 0 or endMemberTotalSum_06_15 eq 0}">
    						<c:set var="arvMemberTotalSum_06_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_06_15" value="${timeMemberTotalSum_06_15 / endMemberTotalSum_06_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_05_15 eq 0 or endMemberTotalSum_05_15 eq 0}">
    						<c:set var="arvMemberTotalSum_05_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_05_15" value="${timeMemberTotalSum_05_15 / endMemberTotalSum_05_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_04_15 eq 0 or endMemberTotalSum_04_15 eq 0}">
    						<c:set var="arvMemberTotalSum_04_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_04_15" value="${timeMemberTotalSum_04_15 / endMemberTotalSum_04_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_03_15 eq 0 or endMemberTotalSum_03_15 eq 0}">
    						<c:set var="arvMemberTotalSum_03_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_03_15" value="${timeMemberTotalSum_03_15 / endMemberTotalSum_03_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_02_15 eq 0 or endMemberTotalSum_02_15 eq 0}">
    						<c:set var="arvMemberTotalSum_02_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_02_15" value="${timeMemberTotalSum_02_15 / endMemberTotalSum_02_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${timeMemberTotalSum_01_15 eq 0 or endMemberTotalSum_01_15 eq 0}">
    						<c:set var="arvMemberTotalSum_01_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_01_15" value="${timeMemberTotalSum_01_15 / endMemberTotalSum_01_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 직원별 평균 계산 끝 -->
    						    				
    				<!-- cntTime12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_12_15}" pattern="#,##0.##"/></th>
    				<!-- cntTime11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_11_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_10_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_09_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_08_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_07_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_06_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_05_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_04_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_03_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_02_15}" pattern="#,##0.##"/></th>
	                <!-- cntTime01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_01_15}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="timeColMemberTotalSum_15" value="${timeMemberTotalSum_12_15 + timeMemberTotalSum_11_15 + timeMemberTotalSum_10_15 + timeMemberTotalSum_09_15 + timeMemberTotalSum_08_15 + timeMemberTotalSum_07_15 + timeMemberTotalSum_06_15 + timeMemberTotalSum_05_15 + timeMemberTotalSum_04_15 + timeMemberTotalSum_03_15 + timeMemberTotalSum_02_15 + timeMemberTotalSum_01_15}"></c:set>
	                <c:set var="endColMemberTotalSum_15" value="${endMemberTotalSum_12_15 + endMemberTotalSum_11_15 + endMemberTotalSum_10_15 + endMemberTotalSum_09_15 + endMemberTotalSum_08_15 + endMemberTotalSum_07_15 + endMemberTotalSum_06_15 + endMemberTotalSum_05_15 + endMemberTotalSum_04_15 + endMemberTotalSum_03_15 + endMemberTotalSum_02_15 + endMemberTotalSum_01_15}"></c:set>
					<c:choose>
	                	<c:when test="${timeColMemberTotalSum_15 eq 0 or endColMemberTotalSum_15 eq 0}">
	                		<c:set var="arvColMemberTotalSum_15" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColMemberTotalSum_15" value="${timeColMemberTotalSum_15 / endColMemberTotalSum_15}"/>
	                	</c:otherwise>
					</c:choose>
	                
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvColMemberTotalSum_15}" pattern="#,##0.##"/></th>
	            </tr>
	            </c:if>
		    	<!-- 1종 기타 소계 끝 -->
    		</tbody>
    	</table>
    	<!-- 1종 기타 끝 -->  	        
    </div>    
    <!-- 총 합계 시작 -->
    <!-- 총 합계 변수 시작 -->
    <c:set var="cntTimeMemberTotalSum_12_all" value="${cntTimeMemberTotalSum_12_5 + cntTimeMemberTotalSum_12_10 + cntTimeMemberTotalSum_12_15}"></c:set>
    <c:set var="cntTimeMemberTotalSum_11_all" value="${cntTimeMemberTotalSum_11_5 + cntTimeMemberTotalSum_11_10 + cntTimeMemberTotalSum_11_15}"></c:set>
    <c:set var="cntTimeMemberTotalSum_10_all" value="${cntTimeMemberTotalSum_10_5 + cntTimeMemberTotalSum_10_10 + cntTimeMemberTotalSum_10_15}"></c:set>
    <c:set var="cntTimeMemberTotalSum_09_all" value="${cntTimeMemberTotalSum_09_5 + cntTimeMemberTotalSum_09_10 + cntTimeMemberTotalSum_09_15}"></c:set>
    <c:set var="cntTimeMemberTotalSum_08_all" value="${cntTimeMemberTotalSum_08_5 + cntTimeMemberTotalSum_08_10 + cntTimeMemberTotalSum_08_15}"></c:set>
    <c:set var="cntTimeMemberTotalSum_07_all" value="${cntTimeMemberTotalSum_07_5 + cntTimeMemberTotalSum_07_10 + cntTimeMemberTotalSum_07_15}"></c:set>
    <c:set var="cntTimeMemberTotalSum_06_all" value="${cntTimeMemberTotalSum_06_5 + cntTimeMemberTotalSum_06_10 + cntTimeMemberTotalSum_06_15}"></c:set>
    <c:set var="cntTimeMemberTotalSum_05_all" value="${cntTimeMemberTotalSum_05_5 + cntTimeMemberTotalSum_05_10 + cntTimeMemberTotalSum_05_15}"></c:set>
    <c:set var="cntTimeMemberTotalSum_04_all" value="${cntTimeMemberTotalSum_04_5 + cntTimeMemberTotalSum_04_10 + cntTimeMemberTotalSum_04_15}"></c:set>
    <c:set var="cntTimeMemberTotalSum_03_all" value="${cntTimeMemberTotalSum_03_5 + cntTimeMemberTotalSum_03_10 + cntTimeMemberTotalSum_03_15}"></c:set>
    <c:set var="cntTimeMemberTotalSum_02_all" value="${cntTimeMemberTotalSum_02_5 + cntTimeMemberTotalSum_02_10 + cntTimeMemberTotalSum_02_15}"></c:set>
    <c:set var="cntTimeMemberTotalSum_01_all" value="${cntTimeMemberTotalSum_01_5 + cntTimeMemberTotalSum_01_10 + cntTimeMemberTotalSum_01_15}"></c:set>        
    <c:set var="cntTimeMemberTotalSum_col_all" value="${cntTimeMemberTotalSum_12_all + cntTimeMemberTotalSum_11_all + cntTimeMemberTotalSum_10_all + cntTimeMemberTotalSum_09_all + cntTimeMemberTotalSum_08_all + cntTimeMemberTotalSum_07_all + cntTimeMemberTotalSum_06_all + cntTimeMemberTotalSum_05_all + cntTimeMemberTotalSum_04_all + cntTimeMemberTotalSum_03_all + cntTimeMemberTotalSum_02_all + cntTimeMemberTotalSum_01_all}"></c:set>
    
    <c:set var="timeMemberTotalSum_12_all" value="${timeMemberTotalSum_12_5 + timeMemberTotalSum_12_10 + timeMemberTotalSum_12_15}"></c:set>
    <c:set var="timeMemberTotalSum_11_all" value="${timeMemberTotalSum_11_5 + timeMemberTotalSum_11_10 + timeMemberTotalSum_11_15}"></c:set>
    <c:set var="timeMemberTotalSum_10_all" value="${timeMemberTotalSum_10_5 + timeMemberTotalSum_10_10 + timeMemberTotalSum_10_15}"></c:set>
    <c:set var="timeMemberTotalSum_09_all" value="${timeMemberTotalSum_09_5 + timeMemberTotalSum_09_10 + timeMemberTotalSum_09_15}"></c:set>
    <c:set var="timeMemberTotalSum_08_all" value="${timeMemberTotalSum_08_5 + timeMemberTotalSum_08_10 + timeMemberTotalSum_08_15}"></c:set>
    <c:set var="timeMemberTotalSum_07_all" value="${timeMemberTotalSum_07_5 + timeMemberTotalSum_07_10 + timeMemberTotalSum_07_15}"></c:set>
    <c:set var="timeMemberTotalSum_06_all" value="${timeMemberTotalSum_06_5 + timeMemberTotalSum_06_10 + timeMemberTotalSum_06_15}"></c:set>
    <c:set var="timeMemberTotalSum_05_all" value="${timeMemberTotalSum_05_5 + timeMemberTotalSum_05_10 + timeMemberTotalSum_05_15}"></c:set>
    <c:set var="timeMemberTotalSum_04_all" value="${timeMemberTotalSum_04_5 + timeMemberTotalSum_04_10 + timeMemberTotalSum_04_15}"></c:set>
    <c:set var="timeMemberTotalSum_03_all" value="${timeMemberTotalSum_03_5 + timeMemberTotalSum_03_10 + timeMemberTotalSum_03_15}"></c:set>
    <c:set var="timeMemberTotalSum_02_all" value="${timeMemberTotalSum_02_5 + timeMemberTotalSum_02_10 + timeMemberTotalSum_02_15}"></c:set>
    <c:set var="timeMemberTotalSum_01_all" value="${timeMemberTotalSum_01_5 + timeMemberTotalSum_01_10 + timeMemberTotalSum_01_15}"></c:set>
    
    <c:set var="endMemberTotalSum_12_all" value="${endMemberTotalSum_12_5 + endMemberTotalSum_12_10 + endMemberTotalSum_12_15}"></c:set>
    <c:set var="endMemberTotalSum_11_all" value="${endMemberTotalSum_11_5 + endMemberTotalSum_11_10 + endMemberTotalSum_11_15}"></c:set>
    <c:set var="endMemberTotalSum_10_all" value="${endMemberTotalSum_10_5 + endMemberTotalSum_10_10 + endMemberTotalSum_10_15}"></c:set>
    <c:set var="endMemberTotalSum_09_all" value="${endMemberTotalSum_09_5 + endMemberTotalSum_09_10 + endMemberTotalSum_09_15}"></c:set>
    <c:set var="endMemberTotalSum_08_all" value="${endMemberTotalSum_08_5 + endMemberTotalSum_08_10 + endMemberTotalSum_08_15}"></c:set>
    <c:set var="endMemberTotalSum_07_all" value="${endMemberTotalSum_07_5 + endMemberTotalSum_07_10 + endMemberTotalSum_07_15}"></c:set>
    <c:set var="endMemberTotalSum_06_all" value="${endMemberTotalSum_06_5 + endMemberTotalSum_06_10 + endMemberTotalSum_06_15}"></c:set>
    <c:set var="endMemberTotalSum_05_all" value="${endMemberTotalSum_05_5 + endMemberTotalSum_05_10 + endMemberTotalSum_05_15}"></c:set>
    <c:set var="endMemberTotalSum_04_all" value="${endMemberTotalSum_04_5 + endMemberTotalSum_04_10 + endMemberTotalSum_04_15}"></c:set>
    <c:set var="endMemberTotalSum_03_all" value="${endMemberTotalSum_03_5 + endMemberTotalSum_03_10 + endMemberTotalSum_03_15}"></c:set>
    <c:set var="endMemberTotalSum_02_all" value="${endMemberTotalSum_02_5 + endMemberTotalSum_02_10 + endMemberTotalSum_02_15}"></c:set>
    <c:set var="endMemberTotalSum_01_all" value="${endMemberTotalSum_01_5 + endMemberTotalSum_01_10 + endMemberTotalSum_01_15}"></c:set>
    
    <c:choose>
		<c:when test="${timeMemberTotalSum_12_all eq 0 or endMemberTotalSum_12_all eq 0}">
			<c:set var="arvMemberTotalSum_12_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_12_all" value="${timeMemberTotalSum_12_all / endMemberTotalSum_12_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeMemberTotalSum_11_all eq 0 or endMemberTotalSum_11_all eq 0}">
			<c:set var="arvMemberTotalSum_11_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_11_all" value="${timeMemberTotalSum_11_all / endMemberTotalSum_11_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeMemberTotalSum_10_all eq 0 or endMemberTotalSum_10_all eq 0}">
			<c:set var="arvMemberTotalSum_10_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_10_all" value="${timeMemberTotalSum_10_all / endMemberTotalSum_10_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeMemberTotalSum_09_all eq 0 or endMemberTotalSum_09_all eq 0}">
			<c:set var="arvMemberTotalSum_09_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_09_all" value="${timeMemberTotalSum_09_all / endMemberTotalSum_09_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeMemberTotalSum_08_all eq 0 or endMemberTotalSum_08_all eq 0}">
			<c:set var="arvMemberTotalSum_08_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_08_all" value="${timeMemberTotalSum_08_all / endMemberTotalSum_08_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeMemberTotalSum_07_all eq 0 or endMemberTotalSum_07_all eq 0}">
			<c:set var="arvMemberTotalSum_07_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_07_all" value="${timeMemberTotalSum_07_all / endMemberTotalSum_07_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeMemberTotalSum_06_all eq 0 or endMemberTotalSum_06_all eq 0}">
			<c:set var="arvMemberTotalSum_06_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_06_all" value="${timeMemberTotalSum_06_all / endMemberTotalSum_06_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeMemberTotalSum_05_all eq 0 or endMemberTotalSum_05_all eq 0}">
			<c:set var="arvMemberTotalSum_05_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_05_all" value="${timeMemberTotalSum_05_all / endMemberTotalSum_05_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeMemberTotalSum_04_all eq 0 or endMemberTotalSum_04_all eq 0}">
			<c:set var="arvMemberTotalSum_04_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_04_all" value="${timeMemberTotalSum_04_all / endMemberTotalSum_04_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeMemberTotalSum_03_all eq 0 or endMemberTotalSum_03_all eq 0}">
			<c:set var="arvMemberTotalSum_03_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_03_all" value="${timeMemberTotalSum_03_all / endMemberTotalSum_03_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeMemberTotalSum_02_all eq 0 or endMemberTotalSum_02_all eq 0}">
			<c:set var="arvMemberTotalSum_02_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_02_all" value="${timeMemberTotalSum_02_all / endMemberTotalSum_02_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${timeMemberTotalSum_01_all eq 0 or endMemberTotalSum_01_all eq 0}">
			<c:set var="arvMemberTotalSum_01_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_01_all" value="${timeMemberTotalSum_01_all / endMemberTotalSum_01_all}"></c:set>
		</c:otherwise>
	</c:choose>
	
	<!-- 가로 합계 -->
	<c:set var="timeColMemberTotalSum_all" value="${timeMemberTotalSum_12_all + timeMemberTotalSum_11_all + timeMemberTotalSum_10_all + timeMemberTotalSum_09_all + timeMemberTotalSum_08_all + timeMemberTotalSum_07_all + timeMemberTotalSum_06_all + timeMemberTotalSum_05_all + timeMemberTotalSum_04_all + timeMemberTotalSum_03_all + timeMemberTotalSum_02_all + timeMemberTotalSum_01_all}"></c:set>
	<c:set var="endColMemberTotalSum_all" value="${endMemberTotalSum_12_all + endMemberTotalSum_11_all + endMemberTotalSum_10_all + endMemberTotalSum_09_all + endMemberTotalSum_08_all + endMemberTotalSum_07_all + endMemberTotalSum_06_all + endMemberTotalSum_05_all + endMemberTotalSum_04_all + endMemberTotalSum_03_all + endMemberTotalSum_02_all + endMemberTotalSum_01_all}"></c:set>
	<c:choose>
		<c:when test="${timeColMemberTotalSum_all eq 0 or endColMemberTotalSum_all eq 0}">
			<c:set var="arvColMemberTotalSum_all" value="0"/>
		</c:when>
		<c:otherwise>
			<c:set var="arvColMemberTotalSum_all" value="${timeColMemberTotalSum_all / endColMemberTotalSum_all}"/>
		</c:otherwise>
	</c:choose>
	    
    <!-- 총 합계 변수 끝 -->
    <div style="background: #e7ecf1;">    	
    	<table>
    		<tr>    			
    			<th style="width: 380px;height:25px;">전체평균</th>    			    			
    			<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvMemberTotalSum_12_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvMemberTotalSum_11_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvMemberTotalSum_10_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvMemberTotalSum_09_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvMemberTotalSum_08_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvMemberTotalSum_07_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvMemberTotalSum_06_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvMemberTotalSum_05_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvMemberTotalSum_04_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvMemberTotalSum_03_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvMemberTotalSum_02_all}" pattern="#,##0.##"/></th>
                <th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvMemberTotalSum_01_all}" pattern="#,##0.##"/></th>				    			
				<th style="width: 75px;text-align:right;padding-right:5px;color:blue;"><fmt:formatNumber value="${arvColMemberTotalSum_all}" pattern="#,##0.##"/></th>
    		</tr>
    	</table>
    </div>
    <!-- 총합계 끝 -->
</div>