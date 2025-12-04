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
	            <c:set var="cntFeeTeamAllSum_12_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_11_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_10_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_09_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_08_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_07_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_06_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_05_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_04_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_03_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_02_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_01_5" value="0"></c:set>
	            
	            <!-- 팀별 평균 계 초기화 -->
				<c:set var="feeTeamAllSum_12_5" value="0"></c:set>
				<c:set var="feeTeamAllSum_11_5" value="0"></c:set>
				<c:set var="feeTeamAllSum_10_5" value="0"></c:set>
				<c:set var="feeTeamAllSum_09_5" value="0"></c:set>
				<c:set var="feeTeamAllSum_08_5" value="0"></c:set>
				<c:set var="feeTeamAllSum_07_5" value="0"></c:set>
				<c:set var="feeTeamAllSum_06_5" value="0"></c:set>
				<c:set var="feeTeamAllSum_05_5" value="0"></c:set>
				<c:set var="feeTeamAllSum_04_5" value="0"></c:set>
				<c:set var="feeTeamAllSum_03_5" value="0"></c:set>
				<c:set var="feeTeamAllSum_02_5" value="0"></c:set>
				<c:set var="feeTeamAllSum_01_5" value="0"></c:set>
								    
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
	            <c:set var="cntFeeTeamAllTotalSum_12_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_11_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_10_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_09_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_08_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_07_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_06_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_05_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_04_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_03_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_02_5" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_01_5" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntFeeColTeamAllTotalSum_5" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="feeTeamAllTotalSum_12_5" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_11_5" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_10_5" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_09_5" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_08_5" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_07_5" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_06_5" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_05_5" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_04_5" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_03_5" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_02_5" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_01_5" value="0"></c:set>
				
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
   				    			
    			<c:forEach var="vo" items="${ptnrStatTeamAllCntFeeList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCntFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowTeamAll}">
		                    	1종 조사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo.rowCnt == 1}">
		                		<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>		                				                		
		                		<td onclick="goPtnrStatMember(${vo.ptnrId},${vo.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.teamName}</td>
		                		<td style="width:150px;">${vo.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="cntFeeTeamAllSum_12_5" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_11_5" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_10_5" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_09_5" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_08_5" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_07_5" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_06_5" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_05_5" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_04_5" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_03_5" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_02_5" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_01_5" value="0"></c:set>
					            
					            <!-- 팀별 평균 계 초기화 -->
								<c:set var="feeTeamAllSum_12_5" value="0"></c:set>
								<c:set var="feeTeamAllSum_11_5" value="0"></c:set>
								<c:set var="feeTeamAllSum_10_5" value="0"></c:set>
								<c:set var="feeTeamAllSum_09_5" value="0"></c:set>
								<c:set var="feeTeamAllSum_08_5" value="0"></c:set>
								<c:set var="feeTeamAllSum_07_5" value="0"></c:set>
								<c:set var="feeTeamAllSum_06_5" value="0"></c:set>
								<c:set var="feeTeamAllSum_05_5" value="0"></c:set>
								<c:set var="feeTeamAllSum_04_5" value="0"></c:set>
								<c:set var="feeTeamAllSum_03_5" value="0"></c:set>
								<c:set var="feeTeamAllSum_02_5" value="0"></c:set>
								<c:set var="feeTeamAllSum_01_5" value="0"></c:set>
												    
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
			    		<c:set var="cntFee12_5" value="${vo.cntFee12}"></c:set>
			            <c:set var="cntFee11_5" value="${vo.cntFee11}"></c:set>
			            <c:set var="cntFee10_5" value="${vo.cntFee10}"></c:set>
			            <c:set var="cntFee09_5" value="${vo.cntFee09}"></c:set>
			            <c:set var="cntFee08_5" value="${vo.cntFee08}"></c:set>
			            <c:set var="cntFee07_5" value="${vo.cntFee07}"></c:set>
			            <c:set var="cntFee06_5" value="${vo.cntFee06}"></c:set>
			            <c:set var="cntFee05_5" value="${vo.cntFee05}"></c:set>
			            <c:set var="cntFee04_5" value="${vo.cntFee04}"></c:set>
			            <c:set var="cntFee03_5" value="${vo.cntFee03}"></c:set>
			            <c:set var="cntFee02_5" value="${vo.cntFee02}"></c:set>
			            <c:set var="cntFee01_5" value="${vo.cntFee01}"></c:set>
			            
			            <!-- 소계 평균용 변수 -->
			            <c:set var="fee12_5" value="${vo.fee12}"></c:set>
			            <c:set var="fee11_5" value="${vo.fee11}"></c:set>
			            <c:set var="fee10_5" value="${vo.fee10}"></c:set>
			            <c:set var="fee09_5" value="${vo.fee09}"></c:set>
			            <c:set var="fee08_5" value="${vo.fee08}"></c:set>
			            <c:set var="fee07_5" value="${vo.fee07}"></c:set>
			            <c:set var="fee06_5" value="${vo.fee06}"></c:set>
			            <c:set var="fee05_5" value="${vo.fee05}"></c:set>
			            <c:set var="fee04_5" value="${vo.fee04}"></c:set>
			            <c:set var="fee03_5" value="${vo.fee03}"></c:set>
			            <c:set var="fee02_5" value="${vo.fee02}"></c:set>
			            <c:set var="fee01_5" value="${vo.fee01}"></c:set>
			            
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
			            
			            <!-- cntFee12 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${cntFee12_5}" pattern="#,##0.##"/></td>
	                    <!-- cntFee11 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee11_5}" pattern="#,##0.##"/></td>
	                    <!-- cntFee10 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee10_5}" pattern="#,##0.##"/></td>
	                    <!-- cntFee09 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee09_5}" pattern="#,##0.##"/></td>
	                    <!-- cntFee08 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee08_5}" pattern="#,##0.##"/></td>
	                    <!-- cntFee07 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee07_5}" pattern="#,##0.##"/></td>
	                    <!-- cntFee06 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee06_5}" pattern="#,##0.##"/></td>
	                    <!-- cntFee05 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee05_5}" pattern="#,##0.##"/></td>
	                    <!-- cntFee04 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee04_5}" pattern="#,##0.##"/></td>
	                    <!-- cntFee03 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee03_5}" pattern="#,##0.##"/></td>
	                    <!-- cntFee02 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee02_5}" pattern="#,##0.##"/></td>
	                    <!-- cntFee01 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee01_5}" pattern="#,##0.##"/></td>
		                <!-- 가로 합계 -->
		                <c:set var="feeColSum_5" value="${fee12_5 + fee11_5 + fee10_5 + fee09_5 + fee08_5 + fee07_5 + fee06_5 + fee05_5 + fee04_5 + fee03_5 + fee02_5 + fee01_5}"></c:set>
		                <c:set var="endColSum_5" value="${end12_5 + end11_5 + end10_5 + end09_5 + end08_5 + end07_5 + end06_5 + end05_5 + end04_5 + end03_5 + end02_5 + end01_5}"></c:set>
		               	<c:choose>
		               		<c:when test="${feeColSum_5 eq 0 or endColSum_5 eq 0}">
		               			<c:set var="arvColSum_5" value="0"></c:set>
		               		</c:when>
		               		<c:otherwise>
		               			<c:set var="arvColSum_5" value="${feeColSum_5 / endColSum_5}"></c:set>
		               		</c:otherwise>
		               	</c:choose> 
		                <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvColSum_5}" pattern="#,##0.##"/></td>		                
		                
		                <!-- 팀별 계 합산 -->
	    				<c:set var="cntFeeTeamAllSum_12_5" value="${cntFeeTeamAllSum_12_5+cntFee12_5}"></c:set>
			            <c:set var="cntFeeTeamAllSum_11_5" value="${cntFeeTeamAllSum_11_5+cntFee11_5}"></c:set>
			            <c:set var="cntFeeTeamAllSum_10_5" value="${cntFeeTeamAllSum_10_5+cntFee10_5}"></c:set>
			            <c:set var="cntFeeTeamAllSum_09_5" value="${cntFeeTeamAllSum_09_5+cntFee09_5}"></c:set>
			            <c:set var="cntFeeTeamAllSum_08_5" value="${cntFeeTeamAllSum_08_5+cntFee08_5}"></c:set>
			            <c:set var="cntFeeTeamAllSum_07_5" value="${cntFeeTeamAllSum_07_5+cntFee07_5}"></c:set>
			            <c:set var="cntFeeTeamAllSum_06_5" value="${cntFeeTeamAllSum_06_5+cntFee06_5}"></c:set>
			            <c:set var="cntFeeTeamAllSum_05_5" value="${cntFeeTeamAllSum_05_5+cntFee05_5}"></c:set>
			            <c:set var="cntFeeTeamAllSum_04_5" value="${cntFeeTeamAllSum_04_5+cntFee04_5}"></c:set>
			            <c:set var="cntFeeTeamAllSum_03_5" value="${cntFeeTeamAllSum_03_5+cntFee03_5}"></c:set>
			            <c:set var="cntFeeTeamAllSum_02_5" value="${cntFeeTeamAllSum_02_5+cntFee02_5}"></c:set>
			            <c:set var="cntFeeTeamAllSum_01_5" value="${cntFeeTeamAllSum_01_5+cntFee01_5}"></c:set>
			            
			            <!-- 팀별 계 평균용 변수 -->
						<c:set var="feeTeamAllSum_12_5" value="${feeTeamAllSum_12_5+fee12_5}"></c:set>
			            <c:set var="feeTeamAllSum_11_5" value="${feeTeamAllSum_11_5+fee11_5}"></c:set>
			            <c:set var="feeTeamAllSum_10_5" value="${feeTeamAllSum_10_5+fee10_5}"></c:set>
			            <c:set var="feeTeamAllSum_09_5" value="${feeTeamAllSum_09_5+fee09_5}"></c:set>
			            <c:set var="feeTeamAllSum_08_5" value="${feeTeamAllSum_08_5+fee08_5}"></c:set>
			            <c:set var="feeTeamAllSum_07_5" value="${feeTeamAllSum_07_5+fee07_5}"></c:set>
			            <c:set var="feeTeamAllSum_06_5" value="${feeTeamAllSum_06_5+fee06_5}"></c:set>
			            <c:set var="feeTeamAllSum_05_5" value="${feeTeamAllSum_05_5+fee05_5}"></c:set>
			            <c:set var="feeTeamAllSum_04_5" value="${feeTeamAllSum_04_5+fee04_5}"></c:set>
			            <c:set var="feeTeamAllSum_03_5" value="${feeTeamAllSum_03_5+fee03_5}"></c:set>
			            <c:set var="feeTeamAllSum_02_5" value="${feeTeamAllSum_02_5+fee02_5}"></c:set>
			            <c:set var="feeTeamAllSum_01_5" value="${feeTeamAllSum_01_5+fee01_5}"></c:set>
				    
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
	                    <c:set var="cntFeeTeamAllTotalSum_12_5" value="${cntFeeTeamAllTotalSum_12_5 + cntFee12_5}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_11_5" value="${cntFeeTeamAllTotalSum_11_5 + cntFee11_5}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_10_5" value="${cntFeeTeamAllTotalSum_10_5 + cntFee10_5}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_09_5" value="${cntFeeTeamAllTotalSum_09_5 + cntFee09_5}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_08_5" value="${cntFeeTeamAllTotalSum_08_5 + cntFee08_5}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_07_5" value="${cntFeeTeamAllTotalSum_07_5 + cntFee07_5}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_06_5" value="${cntFeeTeamAllTotalSum_06_5 + cntFee06_5}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_05_5" value="${cntFeeTeamAllTotalSum_05_5 + cntFee05_5}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_04_5" value="${cntFeeTeamAllTotalSum_04_5 + cntFee04_5}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_03_5" value="${cntFeeTeamAllTotalSum_03_5 + cntFee03_5}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_02_5" value="${cntFeeTeamAllTotalSum_02_5 + cntFee02_5}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_01_5" value="${cntFeeTeamAllTotalSum_01_5 + cntFee01_5}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="feeTeamAllTotalSum_12_5" value="${feeTeamAllTotalSum_12_5 + fee12_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_11_5" value="${feeTeamAllTotalSum_11_5 + fee11_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_10_5" value="${feeTeamAllTotalSum_10_5 + fee10_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_09_5" value="${feeTeamAllTotalSum_09_5 + fee09_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_08_5" value="${feeTeamAllTotalSum_08_5 + fee08_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_07_5" value="${feeTeamAllTotalSum_07_5 + fee07_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_06_5" value="${feeTeamAllTotalSum_06_5 + fee06_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_05_5" value="${feeTeamAllTotalSum_05_5 + fee05_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_04_5" value="${feeTeamAllTotalSum_04_5 + fee04_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_03_5" value="${feeTeamAllTotalSum_03_5 + fee03_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_02_5" value="${feeTeamAllTotalSum_02_5 + fee02_5}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_01_5" value="${feeTeamAllTotalSum_01_5 + fee01_5}"></c:set>

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
		    					<c:when test="${feeTeamAllSum_12_5 eq 0 or endTeamAllSum_12_5 eq 0}">
		    						<c:set var="arvTeamAllSum_12_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_12_5" value="${feeTeamAllSum_12_5 / endTeamAllSum_12_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_11_5 eq 0 or endTeamAllSum_11_5 eq 0}">
		    						<c:set var="arvTeamAllSum_11_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_11_5" value="${feeTeamAllSum_11_5 / endTeamAllSum_11_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_10_5 eq 0 or endTeamAllSum_10_5 eq 0}">
		    						<c:set var="arvTeamAllSum_10_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_10_5" value="${feeTeamAllSum_10_5 / endTeamAllSum_10_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_09_5 eq 0 or endTeamAllSum_09_5 eq 0}">
		    						<c:set var="arvTeamAllSum_09_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_09_5" value="${feeTeamAllSum_09_5 / endTeamAllSum_09_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_08_5 eq 0 or endTeamAllSum_08_5 eq 0}">
		    						<c:set var="arvTeamAllSum_08_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_08_5" value="${feeTeamAllSum_08_5 / endTeamAllSum_08_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_07_5 eq 0 or endTeamAllSum_07_5 eq 0}">
		    						<c:set var="arvTeamAllSum_07_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_07_5" value="${feeTeamAllSum_07_5 / endTeamAllSum_07_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_06_5 eq 0 or endTeamAllSum_06_5 eq 0}">
		    						<c:set var="arvTeamAllSum_06_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_06_5" value="${feeTeamAllSum_06_5 / endTeamAllSum_06_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_05_5 eq 0 or endTeamAllSum_05_5 eq 0}">
		    						<c:set var="arvTeamAllSum_05_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_05_5" value="${feeTeamAllSum_05_5 / endTeamAllSum_05_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_04_5 eq 0 or endTeamAllSum_04_5 eq 0}">
		    						<c:set var="arvTeamAllSum_04_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_04_5" value="${feeTeamAllSum_04_5 / endTeamAllSum_04_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_03_5 eq 0 or endTeamAllSum_03_5 eq 0}">
		    						<c:set var="arvTeamAllSum_03_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_03_5" value="${feeTeamAllSum_03_5 / endTeamAllSum_03_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_02_5 eq 0 or endTeamAllSum_02_5 eq 0}">
		    						<c:set var="arvTeamAllSum_02_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_02_5" value="${feeTeamAllSum_02_5 / endTeamAllSum_02_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_01_5 eq 0 or endTeamAllSum_01_5 eq 0}">
		    						<c:set var="arvTeamAllSum_01_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_01_5" value="${feeTeamAllSum_01_5 / endTeamAllSum_01_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 팀별 평균 계산 끝 -->
		    						    				
		    				<!-- cntFee12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_12_5}" pattern="#,##0.##"/></td>
		    				<!-- cntFee11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_11_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_10_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_09_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_08_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_07_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_06_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_05_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_04_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_03_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_02_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_01_5}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="feeTeamAllColSum_5" value="${feeTeamAllSum_12_5 + feeTeamAllSum_11_5 + feeTeamAllSum_10_5 + feeTeamAllSum_09_5 + feeTeamAllSum_08_5 + feeTeamAllSum_07_5 + feeTeamAllSum_06_5 + feeTeamAllSum_05_5 + feeTeamAllSum_04_5 + feeTeamAllSum_03_5 + feeTeamAllSum_02_5 + feeTeamAllSum_01_5}"></c:set>
			                <c:set var="endTeamAllColSum_5" value="${endTeamAllSum_12_5 + endTeamAllSum_11_5 + endTeamAllSum_10_5 + endTeamAllSum_09_5 + endTeamAllSum_08_5 + endTeamAllSum_07_5 + endTeamAllSum_06_5 + endTeamAllSum_05_5 + endTeamAllSum_04_5 + endTeamAllSum_03_5 + endTeamAllSum_02_5 + endTeamAllSum_01_5}"></c:set>			                
			                <c:choose>
			                	<c:when test="${feeTeamAllColSum_5 eq 0 or endTeamAllColSum_5 eq 0}">
			                		<c:set var="arvTeamAllColSum_5" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvTeamAllColSum_5" value="${feeTeamAllColSum_5 / endTeamAllColSum_5}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllColSum_5}" pattern="#,##0.##"/></td>
		    				
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="cntFeeTeamAllSum_12_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_11_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_10_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_09_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_08_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_07_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_06_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_05_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_04_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_03_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_02_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_01_5" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="feeTeamAllSum_12_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_11_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_10_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_09_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_08_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_07_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_06_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_05_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_04_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_03_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_02_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_01_5" value="0"></c:set>
											    
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
				            <c:set var="cntFeeTeamAllSum_12_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_11_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_10_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_09_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_08_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_07_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_06_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_05_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_04_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_03_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_02_5" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_01_5" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="feeTeamAllSum_12_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_11_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_10_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_09_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_08_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_07_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_06_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_05_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_04_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_03_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_02_5" value="0"></c:set>
							<c:set var="feeTeamAllSum_01_5" value="0"></c:set>
											    
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
		    	<c:if test="${ptnrStatTeamAllCntFeeList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="4" style="height:25px;">1종 조사 평균</th>
	                <c:choose>
    					<c:when test="${feeTeamAllTotalSum_12_5 eq 0 or endTeamAllTotalSum_12_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_12_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_12_5" value="${feeTeamAllTotalSum_12_5 / endTeamAllTotalSum_12_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_11_5 eq 0 or endTeamAllTotalSum_11_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_11_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_11_5" value="${feeTeamAllTotalSum_11_5 / endTeamAllTotalSum_11_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_10_5 eq 0 or endTeamAllTotalSum_10_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_10_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_10_5" value="${feeTeamAllTotalSum_10_5 / endTeamAllTotalSum_10_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_09_5 eq 0 or endTeamAllTotalSum_09_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_09_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_09_5" value="${feeTeamAllTotalSum_09_5 / endTeamAllTotalSum_09_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_08_5 eq 0 or endTeamAllTotalSum_08_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_08_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_08_5" value="${feeTeamAllTotalSum_08_5 / endTeamAllTotalSum_08_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_07_5 eq 0 or endTeamAllTotalSum_07_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_07_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_07_5" value="${feeTeamAllTotalSum_07_5 / endTeamAllTotalSum_07_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_06_5 eq 0 or endTeamAllTotalSum_06_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_06_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_06_5" value="${feeTeamAllTotalSum_06_5 / endTeamAllTotalSum_06_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_05_5 eq 0 or endTeamAllTotalSum_05_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_05_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_05_5" value="${feeTeamAllTotalSum_05_5 / endTeamAllTotalSum_05_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_04_5 eq 0 or endTeamAllTotalSum_04_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_04_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_04_5" value="${feeTeamAllTotalSum_04_5 / endTeamAllTotalSum_04_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_03_5 eq 0 or endTeamAllTotalSum_03_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_03_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_03_5" value="${feeTeamAllTotalSum_03_5 / endTeamAllTotalSum_03_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_02_5 eq 0 or endTeamAllTotalSum_02_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_02_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_02_5" value="${feeTeamAllTotalSum_02_5 / endTeamAllTotalSum_02_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_01_5 eq 0 or endTeamAllTotalSum_01_5 eq 0}">
    						<c:set var="arvTeamAllTotalSum_01_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_01_5" value="${feeTeamAllTotalSum_01_5 / endTeamAllTotalSum_01_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 팀별 평균 계산 끝 -->
    						    				
    				<!-- cntFee12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_12_5}" pattern="#,##0.##"/></th>
    				<!-- cntFee11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_11_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_10_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_09_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_08_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_07_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_06_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_05_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_04_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_03_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_02_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_01_5}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="feeColTeamAllTotalSum_5" value="${feeTeamAllTotalSum_12_5 + feeTeamAllTotalSum_11_5 + feeTeamAllTotalSum_10_5 + feeTeamAllTotalSum_09_5 + feeTeamAllTotalSum_08_5 + feeTeamAllTotalSum_07_5 + feeTeamAllTotalSum_06_5 + feeTeamAllTotalSum_05_5 + feeTeamAllTotalSum_04_5 + feeTeamAllTotalSum_03_5 + feeTeamAllTotalSum_02_5 + feeTeamAllTotalSum_01_5}"></c:set>
	                <c:set var="endColTeamAllTotalSum_5" value="${endTeamAllTotalSum_12_5 + endTeamAllTotalSum_11_5 + endTeamAllTotalSum_10_5 + endTeamAllTotalSum_09_5 + endTeamAllTotalSum_08_5 + endTeamAllTotalSum_07_5 + endTeamAllTotalSum_06_5 + endTeamAllTotalSum_05_5 + endTeamAllTotalSum_04_5 + endTeamAllTotalSum_03_5 + endTeamAllTotalSum_02_5 + endTeamAllTotalSum_01_5}"></c:set>
					<c:choose>
	                	<c:when test="${feeColTeamAllTotalSum_5 eq 0 or endColTeamAllTotalSum_5 eq 0}">
	                		<c:set var="arvColTeamAllTotalSum_5" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColTeamAllTotalSum_5" value="${feeColTeamAllTotalSum_5 / endColTeamAllTotalSum_5}"/>
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
	            <c:set var="cntFeeTeamAllSum_12_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_11_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_10_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_09_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_08_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_07_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_06_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_05_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_04_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_03_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_02_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_01_10" value="0"></c:set>
	            
	            <!-- 팀별 평균 계 초기화 -->
				<c:set var="feeTeamAllSum_12_10" value="0"></c:set>
				<c:set var="feeTeamAllSum_11_10" value="0"></c:set>
				<c:set var="feeTeamAllSum_10_10" value="0"></c:set>
				<c:set var="feeTeamAllSum_09_10" value="0"></c:set>
				<c:set var="feeTeamAllSum_08_10" value="0"></c:set>
				<c:set var="feeTeamAllSum_07_10" value="0"></c:set>
				<c:set var="feeTeamAllSum_06_10" value="0"></c:set>
				<c:set var="feeTeamAllSum_05_10" value="0"></c:set>
				<c:set var="feeTeamAllSum_04_10" value="0"></c:set>
				<c:set var="feeTeamAllSum_03_10" value="0"></c:set>
				<c:set var="feeTeamAllSum_02_10" value="0"></c:set>
				<c:set var="feeTeamAllSum_01_10" value="0"></c:set>
								    
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
	            <c:set var="cntFeeTeamAllTotalSum_12_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_11_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_10_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_09_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_08_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_07_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_06_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_05_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_04_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_03_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_02_10" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_01_10" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntFeeColTeamAllTotalSum_10" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="feeTeamAllTotalSum_12_10" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_11_10" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_10_10" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_09_10" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_08_10" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_07_10" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_06_10" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_05_10" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_04_10" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_03_10" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_02_10" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_01_10" value="0"></c:set>
				
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
   				    			
    			<c:forEach var="vo1" items="${ptnrStatTeamAllCntFeeList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCntFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowTeamAll_10}">
		                    	1종 심사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo1.rowCnt == 1}">
		                		<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>		                				                		
		                		<td onclick="goPtnrStatMember(${vo1.ptnrId},${vo1.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.teamName}</td>
		                		<td style="width:150px;">${vo1.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="cntFeeTeamAllSum_12_10" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_11_10" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_10_10" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_09_10" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_08_10" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_07_10" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_06_10" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_05_10" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_04_10" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_03_10" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_02_10" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_01_10" value="0"></c:set>
					            
					            <!-- 팀별 평균 계 초기화 -->
								<c:set var="feeTeamAllSum_12_10" value="0"></c:set>
								<c:set var="feeTeamAllSum_11_10" value="0"></c:set>
								<c:set var="feeTeamAllSum_10_10" value="0"></c:set>
								<c:set var="feeTeamAllSum_09_10" value="0"></c:set>
								<c:set var="feeTeamAllSum_08_10" value="0"></c:set>
								<c:set var="feeTeamAllSum_07_10" value="0"></c:set>
								<c:set var="feeTeamAllSum_06_10" value="0"></c:set>
								<c:set var="feeTeamAllSum_05_10" value="0"></c:set>
								<c:set var="feeTeamAllSum_04_10" value="0"></c:set>
								<c:set var="feeTeamAllSum_03_10" value="0"></c:set>
								<c:set var="feeTeamAllSum_02_10" value="0"></c:set>
								<c:set var="feeTeamAllSum_01_10" value="0"></c:set>
												    
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
			    		<c:set var="cntFee12_10" value="${vo1.cntFee12}"></c:set>
			            <c:set var="cntFee11_10" value="${vo1.cntFee11}"></c:set>
			            <c:set var="cntFee10_10" value="${vo1.cntFee10}"></c:set>
			            <c:set var="cntFee09_10" value="${vo1.cntFee09}"></c:set>
			            <c:set var="cntFee08_10" value="${vo1.cntFee08}"></c:set>
			            <c:set var="cntFee07_10" value="${vo1.cntFee07}"></c:set>
			            <c:set var="cntFee06_10" value="${vo1.cntFee06}"></c:set>
			            <c:set var="cntFee05_10" value="${vo1.cntFee05}"></c:set>
			            <c:set var="cntFee04_10" value="${vo1.cntFee04}"></c:set>
			            <c:set var="cntFee03_10" value="${vo1.cntFee03}"></c:set>
			            <c:set var="cntFee02_10" value="${vo1.cntFee02}"></c:set>
			            <c:set var="cntFee01_10" value="${vo1.cntFee01}"></c:set>
			            
			            <!-- 소계 평균용 변수 -->
			            <c:set var="fee12_10" value="${vo1.fee12}"></c:set>
			            <c:set var="fee11_10" value="${vo1.fee11}"></c:set>
			            <c:set var="fee10_10" value="${vo1.fee10}"></c:set>
			            <c:set var="fee09_10" value="${vo1.fee09}"></c:set>
			            <c:set var="fee08_10" value="${vo1.fee08}"></c:set>
			            <c:set var="fee07_10" value="${vo1.fee07}"></c:set>
			            <c:set var="fee06_10" value="${vo1.fee06}"></c:set>
			            <c:set var="fee05_10" value="${vo1.fee05}"></c:set>
			            <c:set var="fee04_10" value="${vo1.fee04}"></c:set>
			            <c:set var="fee03_10" value="${vo1.fee03}"></c:set>
			            <c:set var="fee02_10" value="${vo1.fee02}"></c:set>
			            <c:set var="fee01_10" value="${vo1.fee01}"></c:set>
			            
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
			            
			            <!-- cntFee12 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${cntFee12_10}" pattern="#,##0.##"/></td>
	                    <!-- cntFee11 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee11_10}" pattern="#,##0.##"/></td>
	                    <!-- cntFee10 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee10_10}" pattern="#,##0.##"/></td>
	                    <!-- cntFee09 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee09_10}" pattern="#,##0.##"/></td>
	                    <!-- cntFee08 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee08_10}" pattern="#,##0.##"/></td>
	                    <!-- cntFee07 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee07_10}" pattern="#,##0.##"/></td>
	                    <!-- cntFee06 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee06_10}" pattern="#,##0.##"/></td>
	                    <!-- cntFee05 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee05_10}" pattern="#,##0.##"/></td>
	                    <!-- cntFee04 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee04_10}" pattern="#,##0.##"/></td>
	                    <!-- cntFee03 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee03_10}" pattern="#,##0.##"/></td>
	                    <!-- cntFee02 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee02_10}" pattern="#,##0.##"/></td>
	                    <!-- cntFee01 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee01_10}" pattern="#,##0.##"/></td>
		                <!-- 가로 합계 -->
		                <c:set var="feeColSum_10" value="${fee12_10 + fee11_10 + fee10_10 + fee09_10 + fee08_10 + fee07_10 + fee06_10 + fee05_10 + fee04_10 + fee03_10 + fee02_10 + fee01_10}"></c:set>
		                <c:set var="endColSum_10" value="${end12_10 + end11_10 + end10_10 + end09_10 + end08_10 + end07_10 + end06_10 + end05_10 + end04_10 + end03_10 + end02_10 + end01_10}"></c:set>
		               	<c:choose>
		               		<c:when test="${feeColSum_10 eq 0 or endColSum_10 eq 0}">
		               			<c:set var="arvColSum_10" value="0"></c:set>
		               		</c:when>
		               		<c:otherwise>
		               			<c:set var="arvColSum_10" value="${feeColSum_10 / endColSum_10}"></c:set>
		               		</c:otherwise>
		               	</c:choose>
		               	<td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvColSum_10}" pattern="#,##0.##"/></td>		                
		                
		                <!-- 팀별 계 합산 -->
	    				<c:set var="cntFeeTeamAllSum_12_10" value="${cntFeeTeamAllSum_12_10+cntFee12_10}"></c:set>
			            <c:set var="cntFeeTeamAllSum_11_10" value="${cntFeeTeamAllSum_11_10+cntFee11_10}"></c:set>
			            <c:set var="cntFeeTeamAllSum_10_10" value="${cntFeeTeamAllSum_10_10+cntFee10_10}"></c:set>
			            <c:set var="cntFeeTeamAllSum_09_10" value="${cntFeeTeamAllSum_09_10+cntFee09_10}"></c:set>
			            <c:set var="cntFeeTeamAllSum_08_10" value="${cntFeeTeamAllSum_08_10+cntFee08_10}"></c:set>
			            <c:set var="cntFeeTeamAllSum_07_10" value="${cntFeeTeamAllSum_07_10+cntFee07_10}"></c:set>
			            <c:set var="cntFeeTeamAllSum_06_10" value="${cntFeeTeamAllSum_06_10+cntFee06_10}"></c:set>
			            <c:set var="cntFeeTeamAllSum_05_10" value="${cntFeeTeamAllSum_05_10+cntFee05_10}"></c:set>
			            <c:set var="cntFeeTeamAllSum_04_10" value="${cntFeeTeamAllSum_04_10+cntFee04_10}"></c:set>
			            <c:set var="cntFeeTeamAllSum_03_10" value="${cntFeeTeamAllSum_03_10+cntFee03_10}"></c:set>
			            <c:set var="cntFeeTeamAllSum_02_10" value="${cntFeeTeamAllSum_02_10+cntFee02_10}"></c:set>
			            <c:set var="cntFeeTeamAllSum_01_10" value="${cntFeeTeamAllSum_01_10+cntFee01_10}"></c:set>
			            
			            <!-- 팀별 계 평균용 변수 -->
						<c:set var="feeTeamAllSum_12_10" value="${feeTeamAllSum_12_10+fee12_10}"></c:set>
			            <c:set var="feeTeamAllSum_11_10" value="${feeTeamAllSum_11_10+fee11_10}"></c:set>
			            <c:set var="feeTeamAllSum_10_10" value="${feeTeamAllSum_10_10+fee10_10}"></c:set>
			            <c:set var="feeTeamAllSum_09_10" value="${feeTeamAllSum_09_10+fee09_10}"></c:set>
			            <c:set var="feeTeamAllSum_08_10" value="${feeTeamAllSum_08_10+fee08_10}"></c:set>
			            <c:set var="feeTeamAllSum_07_10" value="${feeTeamAllSum_07_10+fee07_10}"></c:set>
			            <c:set var="feeTeamAllSum_06_10" value="${feeTeamAllSum_06_10+fee06_10}"></c:set>
			            <c:set var="feeTeamAllSum_05_10" value="${feeTeamAllSum_05_10+fee05_10}"></c:set>
			            <c:set var="feeTeamAllSum_04_10" value="${feeTeamAllSum_04_10+fee04_10}"></c:set>
			            <c:set var="feeTeamAllSum_03_10" value="${feeTeamAllSum_03_10+fee03_10}"></c:set>
			            <c:set var="feeTeamAllSum_02_10" value="${feeTeamAllSum_02_10+fee02_10}"></c:set>
			            <c:set var="feeTeamAllSum_01_10" value="${feeTeamAllSum_01_10+fee01_10}"></c:set>
				    
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
	                    <c:set var="cntFeeTeamAllTotalSum_12_10" value="${cntFeeTeamAllTotalSum_12_10 + cntFee12_10}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_11_10" value="${cntFeeTeamAllTotalSum_11_10 + cntFee11_10}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_10_10" value="${cntFeeTeamAllTotalSum_10_10 + cntFee10_10}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_09_10" value="${cntFeeTeamAllTotalSum_09_10 + cntFee09_10}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_08_10" value="${cntFeeTeamAllTotalSum_08_10 + cntFee08_10}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_07_10" value="${cntFeeTeamAllTotalSum_07_10 + cntFee07_10}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_06_10" value="${cntFeeTeamAllTotalSum_06_10 + cntFee06_10}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_05_10" value="${cntFeeTeamAllTotalSum_05_10 + cntFee05_10}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_04_10" value="${cntFeeTeamAllTotalSum_04_10 + cntFee04_10}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_03_10" value="${cntFeeTeamAllTotalSum_03_10 + cntFee03_10}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_02_10" value="${cntFeeTeamAllTotalSum_02_10 + cntFee02_10}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_01_10" value="${cntFeeTeamAllTotalSum_01_10 + cntFee01_10}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="feeTeamAllTotalSum_12_10" value="${feeTeamAllTotalSum_12_10 + fee12_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_11_10" value="${feeTeamAllTotalSum_11_10 + fee11_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_10_10" value="${feeTeamAllTotalSum_10_10 + fee10_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_09_10" value="${feeTeamAllTotalSum_09_10 + fee09_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_08_10" value="${feeTeamAllTotalSum_08_10 + fee08_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_07_10" value="${feeTeamAllTotalSum_07_10 + fee07_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_06_10" value="${feeTeamAllTotalSum_06_10 + fee06_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_05_10" value="${feeTeamAllTotalSum_05_10 + fee05_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_04_10" value="${feeTeamAllTotalSum_04_10 + fee04_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_03_10" value="${feeTeamAllTotalSum_03_10 + fee03_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_02_10" value="${feeTeamAllTotalSum_02_10 + fee02_10}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_01_10" value="${feeTeamAllTotalSum_01_10 + fee01_10}"></c:set>

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
		    					<c:when test="${feeTeamAllSum_12_10 eq 0 or endTeamAllSum_12_10 eq 0}">
		    						<c:set var="arvTeamAllSum_12_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_12_10" value="${feeTeamAllSum_12_10 / endTeamAllSum_12_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_11_10 eq 0 or endTeamAllSum_11_10 eq 0}">
		    						<c:set var="arvTeamAllSum_11_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_11_10" value="${feeTeamAllSum_11_10 / endTeamAllSum_11_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_10_10 eq 0 or endTeamAllSum_10_10 eq 0}">
		    						<c:set var="arvTeamAllSum_10_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_10_10" value="${feeTeamAllSum_10_10 / endTeamAllSum_10_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_09_10 eq 0 or endTeamAllSum_09_10 eq 0}">
		    						<c:set var="arvTeamAllSum_09_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_09_10" value="${feeTeamAllSum_09_10 / endTeamAllSum_09_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_08_10 eq 0 or endTeamAllSum_08_10 eq 0}">
		    						<c:set var="arvTeamAllSum_08_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_08_10" value="${feeTeamAllSum_08_10 / endTeamAllSum_08_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_07_10 eq 0 or endTeamAllSum_07_10 eq 0}">
		    						<c:set var="arvTeamAllSum_07_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_07_10" value="${feeTeamAllSum_07_10 / endTeamAllSum_07_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_06_10 eq 0 or endTeamAllSum_06_10 eq 0}">
		    						<c:set var="arvTeamAllSum_06_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_06_10" value="${feeTeamAllSum_06_10 / endTeamAllSum_06_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_05_10 eq 0 or endTeamAllSum_05_10 eq 0}">
		    						<c:set var="arvTeamAllSum_05_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_05_10" value="${feeTeamAllSum_05_10 / endTeamAllSum_05_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_04_10 eq 0 or endTeamAllSum_04_10 eq 0}">
		    						<c:set var="arvTeamAllSum_04_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_04_10" value="${feeTeamAllSum_04_10 / endTeamAllSum_04_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_03_10 eq 0 or endTeamAllSum_03_10 eq 0}">
		    						<c:set var="arvTeamAllSum_03_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_03_10" value="${feeTeamAllSum_03_10 / endTeamAllSum_03_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_02_10 eq 0 or endTeamAllSum_02_10 eq 0}">
		    						<c:set var="arvTeamAllSum_02_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_02_10" value="${feeTeamAllSum_02_10 / endTeamAllSum_02_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_01_10 eq 0 or endTeamAllSum_01_10 eq 0}">
		    						<c:set var="arvTeamAllSum_01_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_01_10" value="${feeTeamAllSum_01_10 / endTeamAllSum_01_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 팀별 평균 계산 끝 -->
		    						    				
		    				<!-- cntFee12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_12_10}" pattern="#,##0.##"/></td>
		    				<!-- cntFee11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_11_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_10_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_09_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_08_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_07_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_06_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_05_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_04_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_03_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_02_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_01_10}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="feeTeamAllColSum_10" value="${feeTeamAllSum_12_10 + feeTeamAllSum_11_10 + feeTeamAllSum_10_10 + feeTeamAllSum_09_10 + feeTeamAllSum_08_10 + feeTeamAllSum_07_10 + feeTeamAllSum_06_10 + feeTeamAllSum_05_10 + feeTeamAllSum_04_10 + feeTeamAllSum_03_10 + feeTeamAllSum_02_10 + feeTeamAllSum_01_10}"></c:set>
			                <c:set var="endTeamAllColSum_10" value="${endTeamAllSum_12_10 + endTeamAllSum_11_10 + endTeamAllSum_10_10 + endTeamAllSum_09_10 + endTeamAllSum_08_10 + endTeamAllSum_07_10 + endTeamAllSum_06_10 + endTeamAllSum_05_10 + endTeamAllSum_04_10 + endTeamAllSum_03_10 + endTeamAllSum_02_10 + endTeamAllSum_01_10}"></c:set>			                
			                <c:choose>
			                	<c:when test="${feeTeamAllColSum_10 eq 0 or endTeamAllColSum_10 eq 0}">
			                		<c:set var="arvTeamAllColSum_10" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvTeamAllColSum_10" value="${feeTeamAllColSum_10 / endTeamAllColSum_10}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllColSum_10}" pattern="#,##0.##"/></td>
		    				
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="cntFeeTeamAllSum_12_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_11_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_10_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_09_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_08_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_07_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_06_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_05_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_04_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_03_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_02_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_01_10" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="feeTeamAllSum_12_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_11_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_10_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_09_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_08_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_07_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_06_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_05_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_04_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_03_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_02_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_01_10" value="0"></c:set>
											    
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
				            <c:set var="cntFeeTeamAllSum_12_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_11_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_10_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_09_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_08_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_07_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_06_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_05_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_04_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_03_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_02_10" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_01_10" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="feeTeamAllSum_12_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_11_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_10_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_09_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_08_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_07_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_06_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_05_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_04_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_03_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_02_10" value="0"></c:set>
							<c:set var="feeTeamAllSum_01_10" value="0"></c:set>
											    
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
		    	<c:if test="${ptnrStatTeamAllCntFeeList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="4" style="height:25px;">1종 심사 평균</th>
	                <c:choose>
    					<c:when test="${feeTeamAllTotalSum_12_10 eq 0 or endTeamAllTotalSum_12_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_12_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_12_10" value="${feeTeamAllTotalSum_12_10 / endTeamAllTotalSum_12_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_11_10 eq 0 or endTeamAllTotalSum_11_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_11_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_11_10" value="${feeTeamAllTotalSum_11_10 / endTeamAllTotalSum_11_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_10_10 eq 0 or endTeamAllTotalSum_10_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_10_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_10_10" value="${feeTeamAllTotalSum_10_10 / endTeamAllTotalSum_10_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_09_10 eq 0 or endTeamAllTotalSum_09_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_09_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_09_10" value="${feeTeamAllTotalSum_09_10 / endTeamAllTotalSum_09_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_08_10 eq 0 or endTeamAllTotalSum_08_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_08_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_08_10" value="${feeTeamAllTotalSum_08_10 / endTeamAllTotalSum_08_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_07_10 eq 0 or endTeamAllTotalSum_07_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_07_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_07_10" value="${feeTeamAllTotalSum_07_10 / endTeamAllTotalSum_07_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_06_10 eq 0 or endTeamAllTotalSum_06_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_06_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_06_10" value="${feeTeamAllTotalSum_06_10 / endTeamAllTotalSum_06_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_05_10 eq 0 or endTeamAllTotalSum_05_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_05_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_05_10" value="${feeTeamAllTotalSum_05_10 / endTeamAllTotalSum_05_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_04_10 eq 0 or endTeamAllTotalSum_04_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_04_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_04_10" value="${feeTeamAllTotalSum_04_10 / endTeamAllTotalSum_04_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_03_10 eq 0 or endTeamAllTotalSum_03_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_03_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_03_10" value="${feeTeamAllTotalSum_03_10 / endTeamAllTotalSum_03_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_02_10 eq 0 or endTeamAllTotalSum_02_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_02_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_02_10" value="${feeTeamAllTotalSum_02_10 / endTeamAllTotalSum_02_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_01_10 eq 0 or endTeamAllTotalSum_01_10 eq 0}">
    						<c:set var="arvTeamAllTotalSum_01_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_01_10" value="${feeTeamAllTotalSum_01_10 / endTeamAllTotalSum_01_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 팀별 평균 계산 끝 -->
    						    				
    				<!-- cntFee12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_12_10}" pattern="#,##0.##"/></th>
    				<!-- cntFee11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_11_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_10_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_09_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_08_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_07_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_06_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_05_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_04_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_03_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_02_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_01_10}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="feeColTeamAllTotalSum_10" value="${feeTeamAllTotalSum_12_10 + feeTeamAllTotalSum_11_10 + feeTeamAllTotalSum_10_10 + feeTeamAllTotalSum_09_10 + feeTeamAllTotalSum_08_10 + feeTeamAllTotalSum_07_10 + feeTeamAllTotalSum_06_10 + feeTeamAllTotalSum_05_10 + feeTeamAllTotalSum_04_10 + feeTeamAllTotalSum_03_10 + feeTeamAllTotalSum_02_10 + feeTeamAllTotalSum_01_10}"></c:set>
	                <c:set var="endColTeamAllTotalSum_10" value="${endTeamAllTotalSum_12_10 + endTeamAllTotalSum_11_10 + endTeamAllTotalSum_10_10 + endTeamAllTotalSum_09_10 + endTeamAllTotalSum_08_10 + endTeamAllTotalSum_07_10 + endTeamAllTotalSum_06_10 + endTeamAllTotalSum_05_10 + endTeamAllTotalSum_04_10 + endTeamAllTotalSum_03_10 + endTeamAllTotalSum_02_10 + endTeamAllTotalSum_01_10}"></c:set>
					<c:choose>
	                	<c:when test="${feeColTeamAllTotalSum_10 eq 0 or endColTeamAllTotalSum_10 eq 0}">
	                		<c:set var="arvColTeamAllTotalSum_10" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColTeamAllTotalSum_10" value="${feeColTeamAllTotalSum_10 / endColTeamAllTotalSum_10}"/>
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
	            <c:set var="cntFeeTeamAllSum_12_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_11_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_10_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_09_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_08_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_07_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_06_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_05_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_04_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_03_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_02_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllSum_01_15" value="0"></c:set>
	            
	            <!-- 팀별 평균 계 초기화 -->
				<c:set var="feeTeamAllSum_12_15" value="0"></c:set>
				<c:set var="feeTeamAllSum_11_15" value="0"></c:set>
				<c:set var="feeTeamAllSum_10_15" value="0"></c:set>
				<c:set var="feeTeamAllSum_09_15" value="0"></c:set>
				<c:set var="feeTeamAllSum_08_15" value="0"></c:set>
				<c:set var="feeTeamAllSum_07_15" value="0"></c:set>
				<c:set var="feeTeamAllSum_06_15" value="0"></c:set>
				<c:set var="feeTeamAllSum_05_15" value="0"></c:set>
				<c:set var="feeTeamAllSum_04_15" value="0"></c:set>
				<c:set var="feeTeamAllSum_03_15" value="0"></c:set>
				<c:set var="feeTeamAllSum_02_15" value="0"></c:set>
				<c:set var="feeTeamAllSum_01_15" value="0"></c:set>
								    
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
	            <c:set var="cntFeeTeamAllTotalSum_12_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_11_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_10_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_09_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_08_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_07_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_06_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_05_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_04_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_03_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_02_15" value="0"></c:set>
	            <c:set var="cntFeeTeamAllTotalSum_01_15" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntFeeColTeamAllTotalSum_15" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="feeTeamAllTotalSum_12_15" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_11_15" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_10_15" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_09_15" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_08_15" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_07_15" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_06_15" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_05_15" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_04_15" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_03_15" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_02_15" value="0"></c:set>
				<c:set var="feeTeamAllTotalSum_01_15" value="0"></c:set>
				
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
   				    			
    			<c:forEach var="vo2" items="${ptnrStatTeamAllCntFeeList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCntFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRowTeamAll_15}">
		                    	1종 기타
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo2.rowCnt == 1}">
		                		<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>		                				                		
		                		<td onclick="goPtnrStatMember(${vo2.ptnrId},${vo2.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.teamName}</td>
		                		<td style="width:150px;">${vo2.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="cntFeeTeamAllSum_12_15" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_11_15" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_10_15" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_09_15" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_08_15" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_07_15" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_06_15" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_05_15" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_04_15" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_03_15" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_02_15" value="0"></c:set>
					            <c:set var="cntFeeTeamAllSum_01_15" value="0"></c:set>
					            
					            <!-- 팀별 평균 계 초기화 -->
								<c:set var="feeTeamAllSum_12_15" value="0"></c:set>
								<c:set var="feeTeamAllSum_11_15" value="0"></c:set>
								<c:set var="feeTeamAllSum_10_15" value="0"></c:set>
								<c:set var="feeTeamAllSum_09_15" value="0"></c:set>
								<c:set var="feeTeamAllSum_08_15" value="0"></c:set>
								<c:set var="feeTeamAllSum_07_15" value="0"></c:set>
								<c:set var="feeTeamAllSum_06_15" value="0"></c:set>
								<c:set var="feeTeamAllSum_05_15" value="0"></c:set>
								<c:set var="feeTeamAllSum_04_15" value="0"></c:set>
								<c:set var="feeTeamAllSum_03_15" value="0"></c:set>
								<c:set var="feeTeamAllSum_02_15" value="0"></c:set>
								<c:set var="feeTeamAllSum_01_15" value="0"></c:set>
												    
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
			    		<c:set var="cntFee12_15" value="${vo2.cntFee12}"></c:set>
			            <c:set var="cntFee11_15" value="${vo2.cntFee11}"></c:set>
			            <c:set var="cntFee10_15" value="${vo2.cntFee10}"></c:set>
			            <c:set var="cntFee09_15" value="${vo2.cntFee09}"></c:set>
			            <c:set var="cntFee08_15" value="${vo2.cntFee08}"></c:set>
			            <c:set var="cntFee07_15" value="${vo2.cntFee07}"></c:set>
			            <c:set var="cntFee06_15" value="${vo2.cntFee06}"></c:set>
			            <c:set var="cntFee05_15" value="${vo2.cntFee05}"></c:set>
			            <c:set var="cntFee04_15" value="${vo2.cntFee04}"></c:set>
			            <c:set var="cntFee03_15" value="${vo2.cntFee03}"></c:set>
			            <c:set var="cntFee02_15" value="${vo2.cntFee02}"></c:set>
			            <c:set var="cntFee01_15" value="${vo2.cntFee01}"></c:set>
			            
			            <!-- 소계 평균용 변수 -->
			            <c:set var="fee12_15" value="${vo2.fee12}"></c:set>
			            <c:set var="fee11_15" value="${vo2.fee11}"></c:set>
			            <c:set var="fee10_15" value="${vo2.fee10}"></c:set>
			            <c:set var="fee09_15" value="${vo2.fee09}"></c:set>
			            <c:set var="fee08_15" value="${vo2.fee08}"></c:set>
			            <c:set var="fee07_15" value="${vo2.fee07}"></c:set>
			            <c:set var="fee06_15" value="${vo2.fee06}"></c:set>
			            <c:set var="fee05_15" value="${vo2.fee05}"></c:set>
			            <c:set var="fee04_15" value="${vo2.fee04}"></c:set>
			            <c:set var="fee03_15" value="${vo2.fee03}"></c:set>
			            <c:set var="fee02_15" value="${vo2.fee02}"></c:set>
			            <c:set var="fee01_15" value="${vo2.fee01}"></c:set>
			            
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
			            
			            <!-- cntFee12 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;"><fmt:formatNumber value="${cntFee12_15}" pattern="#,##0.##"/></td>
	                    <!-- cntFee11 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee11_15}" pattern="#,##0.##"/></td>
	                    <!-- cntFee10 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee10_15}" pattern="#,##0.##"/></td>
	                    <!-- cntFee09 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee09_15}" pattern="#,##0.##"/></td>
	                    <!-- cntFee08 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee08_15}" pattern="#,##0.##"/></td>
	                    <!-- cntFee07 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee07_15}" pattern="#,##0.##"/></td>
	                    <!-- cntFee06 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee06_15}" pattern="#,##0.##"/></td>
	                    <!-- cntFee05 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee05_15}" pattern="#,##0.##"/></td>
	                    <!-- cntFee04 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee04_15}" pattern="#,##0.##"/></td>
	                    <!-- cntFee03 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee03_15}" pattern="#,##0.##"/></td>
	                    <!-- cntFee02 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee02_15}" pattern="#,##0.##"/></td>
	                    <!-- cntFee01 -->
	                    <td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${cntFee01_15}" pattern="#,##0.##"/></td>
		                <!-- 가로 합계 -->
		                <c:set var="feeColSum_15" value="${fee12_15 + fee11_15 + fee10_15 + fee09_15 + fee08_15 + fee07_15 + fee06_15 + fee05_15 + fee04_15 + fee03_15 + fee02_15 + fee01_15}"></c:set>
		                <c:set var="endColSum_15" value="${end12_15 + end11_15 + end10_15 + end09_15 + end08_15 + end07_15 + end06_15 + end05_15 + end04_15 + end03_15 + end02_15 + end01_15}"></c:set>
		               	<c:choose>
		               		<c:when test="${feeColSum_15 eq 0 or endColSum_15 eq 0}">
		               			<c:set var="arvColSum_15" value="0"></c:set>
		               		</c:when>
		               		<c:otherwise>
		               			<c:set var="arvColSum_15" value="${feeColSum_15 / endColSum_15}"></c:set>
		               		</c:otherwise>
		               	</c:choose>
		               	<td style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvColSum_15}" pattern="#,##0.##"/></td>		                
		                
		                <!-- 팀별 계 합산 -->
	    				<c:set var="cntFeeTeamAllSum_12_15" value="${cntFeeTeamAllSum_12_15+cntFee12_15}"></c:set>
			            <c:set var="cntFeeTeamAllSum_11_15" value="${cntFeeTeamAllSum_11_15+cntFee11_15}"></c:set>
			            <c:set var="cntFeeTeamAllSum_10_15" value="${cntFeeTeamAllSum_10_15+cntFee10_15}"></c:set>
			            <c:set var="cntFeeTeamAllSum_09_15" value="${cntFeeTeamAllSum_09_15+cntFee09_15}"></c:set>
			            <c:set var="cntFeeTeamAllSum_08_15" value="${cntFeeTeamAllSum_08_15+cntFee08_15}"></c:set>
			            <c:set var="cntFeeTeamAllSum_07_15" value="${cntFeeTeamAllSum_07_15+cntFee07_15}"></c:set>
			            <c:set var="cntFeeTeamAllSum_06_15" value="${cntFeeTeamAllSum_06_15+cntFee06_15}"></c:set>
			            <c:set var="cntFeeTeamAllSum_05_15" value="${cntFeeTeamAllSum_05_15+cntFee05_15}"></c:set>
			            <c:set var="cntFeeTeamAllSum_04_15" value="${cntFeeTeamAllSum_04_15+cntFee04_15}"></c:set>
			            <c:set var="cntFeeTeamAllSum_03_15" value="${cntFeeTeamAllSum_03_15+cntFee03_15}"></c:set>
			            <c:set var="cntFeeTeamAllSum_02_15" value="${cntFeeTeamAllSum_02_15+cntFee02_15}"></c:set>
			            <c:set var="cntFeeTeamAllSum_01_15" value="${cntFeeTeamAllSum_01_15+cntFee01_15}"></c:set>
			            
			            <!-- 팀별 계 평균용 변수 -->
						<c:set var="feeTeamAllSum_12_15" value="${feeTeamAllSum_12_15+fee12_15}"></c:set>
			            <c:set var="feeTeamAllSum_11_15" value="${feeTeamAllSum_11_15+fee11_15}"></c:set>
			            <c:set var="feeTeamAllSum_10_15" value="${feeTeamAllSum_10_15+fee10_15}"></c:set>
			            <c:set var="feeTeamAllSum_09_15" value="${feeTeamAllSum_09_15+fee09_15}"></c:set>
			            <c:set var="feeTeamAllSum_08_15" value="${feeTeamAllSum_08_15+fee08_15}"></c:set>
			            <c:set var="feeTeamAllSum_07_15" value="${feeTeamAllSum_07_15+fee07_15}"></c:set>
			            <c:set var="feeTeamAllSum_06_15" value="${feeTeamAllSum_06_15+fee06_15}"></c:set>
			            <c:set var="feeTeamAllSum_05_15" value="${feeTeamAllSum_05_15+fee05_15}"></c:set>
			            <c:set var="feeTeamAllSum_04_15" value="${feeTeamAllSum_04_15+fee04_15}"></c:set>
			            <c:set var="feeTeamAllSum_03_15" value="${feeTeamAllSum_03_15+fee03_15}"></c:set>
			            <c:set var="feeTeamAllSum_02_15" value="${feeTeamAllSum_02_15+fee02_15}"></c:set>
			            <c:set var="feeTeamAllSum_01_15" value="${feeTeamAllSum_01_15+fee01_15}"></c:set>
				    
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
	                    <c:set var="cntFeeTeamAllTotalSum_12_15" value="${cntFeeTeamAllTotalSum_12_15 + cntFee12_15}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_11_15" value="${cntFeeTeamAllTotalSum_11_15 + cntFee11_15}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_10_15" value="${cntFeeTeamAllTotalSum_10_15 + cntFee10_15}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_09_15" value="${cntFeeTeamAllTotalSum_09_15 + cntFee09_15}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_08_15" value="${cntFeeTeamAllTotalSum_08_15 + cntFee08_15}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_07_15" value="${cntFeeTeamAllTotalSum_07_15 + cntFee07_15}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_06_15" value="${cntFeeTeamAllTotalSum_06_15 + cntFee06_15}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_05_15" value="${cntFeeTeamAllTotalSum_05_15 + cntFee05_15}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_04_15" value="${cntFeeTeamAllTotalSum_04_15 + cntFee04_15}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_03_15" value="${cntFeeTeamAllTotalSum_03_15 + cntFee03_15}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_02_15" value="${cntFeeTeamAllTotalSum_02_15 + cntFee02_15}"></c:set>
	                    <c:set var="cntFeeTeamAllTotalSum_01_15" value="${cntFeeTeamAllTotalSum_01_15 + cntFee01_15}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="feeTeamAllTotalSum_12_15" value="${feeTeamAllTotalSum_12_15 + fee12_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_11_15" value="${feeTeamAllTotalSum_11_15 + fee11_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_10_15" value="${feeTeamAllTotalSum_10_15 + fee10_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_09_15" value="${feeTeamAllTotalSum_09_15 + fee09_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_08_15" value="${feeTeamAllTotalSum_08_15 + fee08_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_07_15" value="${feeTeamAllTotalSum_07_15 + fee07_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_06_15" value="${feeTeamAllTotalSum_06_15 + fee06_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_05_15" value="${feeTeamAllTotalSum_05_15 + fee05_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_04_15" value="${feeTeamAllTotalSum_04_15 + fee04_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_03_15" value="${feeTeamAllTotalSum_03_15 + fee03_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_02_15" value="${feeTeamAllTotalSum_02_15 + fee02_15}"></c:set>
	                    <c:set var="feeTeamAllTotalSum_01_15" value="${feeTeamAllTotalSum_01_15 + fee01_15}"></c:set>

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
		    					<c:when test="${feeTeamAllSum_12_15 eq 0 or endTeamAllSum_12_15 eq 0}">
		    						<c:set var="arvTeamAllSum_12_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_12_15" value="${feeTeamAllSum_12_15 / endTeamAllSum_12_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_11_15 eq 0 or endTeamAllSum_11_15 eq 0}">
		    						<c:set var="arvTeamAllSum_11_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_11_15" value="${feeTeamAllSum_11_15 / endTeamAllSum_11_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_10_15 eq 0 or endTeamAllSum_10_15 eq 0}">
		    						<c:set var="arvTeamAllSum_10_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_10_15" value="${feeTeamAllSum_10_15 / endTeamAllSum_10_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_09_15 eq 0 or endTeamAllSum_09_15 eq 0}">
		    						<c:set var="arvTeamAllSum_09_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_09_15" value="${feeTeamAllSum_09_15 / endTeamAllSum_09_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_08_15 eq 0 or endTeamAllSum_08_15 eq 0}">
		    						<c:set var="arvTeamAllSum_08_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_08_15" value="${feeTeamAllSum_08_15 / endTeamAllSum_08_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_07_15 eq 0 or endTeamAllSum_07_15 eq 0}">
		    						<c:set var="arvTeamAllSum_07_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_07_15" value="${feeTeamAllSum_07_15 / endTeamAllSum_07_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_06_15 eq 0 or endTeamAllSum_06_15 eq 0}">
		    						<c:set var="arvTeamAllSum_06_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_06_15" value="${feeTeamAllSum_06_15 / endTeamAllSum_06_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_05_15 eq 0 or endTeamAllSum_05_15 eq 0}">
		    						<c:set var="arvTeamAllSum_05_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_05_15" value="${feeTeamAllSum_05_15 / endTeamAllSum_05_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_04_15 eq 0 or endTeamAllSum_04_15 eq 0}">
		    						<c:set var="arvTeamAllSum_04_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_04_15" value="${feeTeamAllSum_04_15 / endTeamAllSum_04_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_03_15 eq 0 or endTeamAllSum_03_15 eq 0}">
		    						<c:set var="arvTeamAllSum_03_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_03_15" value="${feeTeamAllSum_03_15 / endTeamAllSum_03_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_02_15 eq 0 or endTeamAllSum_02_15 eq 0}">
		    						<c:set var="arvTeamAllSum_02_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_02_15" value="${feeTeamAllSum_02_15 / endTeamAllSum_02_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamAllSum_01_15 eq 0 or endTeamAllSum_01_15 eq 0}">
		    						<c:set var="arvTeamAllSum_01_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamAllSum_01_15" value="${feeTeamAllSum_01_15 / endTeamAllSum_01_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 팀별 평균 계산 끝 -->
		    						    				
		    				<!-- cntFee12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_12_15}" pattern="#,##0.##"/></td>
		    				<!-- cntFee11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_11_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_10_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_09_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_08_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_07_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_06_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_05_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_04_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_03_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_02_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllSum_01_15}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="feeTeamAllColSum_15" value="${feeTeamAllSum_12_15 + feeTeamAllSum_11_15 + feeTeamAllSum_10_15 + feeTeamAllSum_09_15 + feeTeamAllSum_08_15 + feeTeamAllSum_07_15 + feeTeamAllSum_06_15 + feeTeamAllSum_05_15 + feeTeamAllSum_04_15 + feeTeamAllSum_03_15 + feeTeamAllSum_02_15 + feeTeamAllSum_01_15}"></c:set>
			                <c:set var="endTeamAllColSum_15" value="${endTeamAllSum_12_15 + endTeamAllSum_11_15 + endTeamAllSum_10_15 + endTeamAllSum_09_15 + endTeamAllSum_08_15 + endTeamAllSum_07_15 + endTeamAllSum_06_15 + endTeamAllSum_05_15 + endTeamAllSum_04_15 + endTeamAllSum_03_15 + endTeamAllSum_02_15 + endTeamAllSum_01_15}"></c:set>			                
			                <c:choose>
			                	<c:when test="${feeTeamAllColSum_15 eq 0 or endTeamAllColSum_15 eq 0}">
			                		<c:set var="arvTeamAllColSum_15" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvTeamAllColSum_15" value="${feeTeamAllColSum_15 / endTeamAllColSum_15}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamAllColSum_15}" pattern="#,##0.##"/></td>
		    				
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="cntFeeTeamAllSum_12_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_11_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_10_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_09_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_08_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_07_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_06_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_05_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_04_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_03_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_02_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_01_15" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="feeTeamAllSum_12_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_11_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_10_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_09_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_08_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_07_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_06_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_05_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_04_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_03_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_02_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_01_15" value="0"></c:set>
											    
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
				            <c:set var="cntFeeTeamAllSum_12_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_11_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_10_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_09_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_08_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_07_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_06_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_05_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_04_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_03_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_02_15" value="0"></c:set>
				            <c:set var="cntFeeTeamAllSum_01_15" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="feeTeamAllSum_12_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_11_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_10_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_09_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_08_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_07_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_06_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_05_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_04_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_03_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_02_15" value="0"></c:set>
							<c:set var="feeTeamAllSum_01_15" value="0"></c:set>
											    
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
		    	<c:if test="${ptnrStatTeamAllCntFeeList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="4" style="height:25px;">1종 기타 평균</th>
	                <c:choose>
    					<c:when test="${feeTeamAllTotalSum_12_15 eq 0 or endTeamAllTotalSum_12_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_12_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_12_15" value="${feeTeamAllTotalSum_12_15 / endTeamAllTotalSum_12_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_11_15 eq 0 or endTeamAllTotalSum_11_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_11_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_11_15" value="${feeTeamAllTotalSum_11_15 / endTeamAllTotalSum_11_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_10_15 eq 0 or endTeamAllTotalSum_10_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_10_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_10_15" value="${feeTeamAllTotalSum_10_15 / endTeamAllTotalSum_10_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_09_15 eq 0 or endTeamAllTotalSum_09_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_09_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_09_15" value="${feeTeamAllTotalSum_09_15 / endTeamAllTotalSum_09_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_08_15 eq 0 or endTeamAllTotalSum_08_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_08_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_08_15" value="${feeTeamAllTotalSum_08_15 / endTeamAllTotalSum_08_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_07_15 eq 0 or endTeamAllTotalSum_07_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_07_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_07_15" value="${feeTeamAllTotalSum_07_15 / endTeamAllTotalSum_07_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_06_15 eq 0 or endTeamAllTotalSum_06_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_06_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_06_15" value="${feeTeamAllTotalSum_06_15 / endTeamAllTotalSum_06_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_05_15 eq 0 or endTeamAllTotalSum_05_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_05_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_05_15" value="${feeTeamAllTotalSum_05_15 / endTeamAllTotalSum_05_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_04_15 eq 0 or endTeamAllTotalSum_04_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_04_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_04_15" value="${feeTeamAllTotalSum_04_15 / endTeamAllTotalSum_04_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_03_15 eq 0 or endTeamAllTotalSum_03_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_03_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_03_15" value="${feeTeamAllTotalSum_03_15 / endTeamAllTotalSum_03_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_02_15 eq 0 or endTeamAllTotalSum_02_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_02_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_02_15" value="${feeTeamAllTotalSum_02_15 / endTeamAllTotalSum_02_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamAllTotalSum_01_15 eq 0 or endTeamAllTotalSum_01_15 eq 0}">
    						<c:set var="arvTeamAllTotalSum_01_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamAllTotalSum_01_15" value="${feeTeamAllTotalSum_01_15 / endTeamAllTotalSum_01_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 팀별 평균 계산 끝 -->
    						    				
    				<!-- cntFee12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_12_15}" pattern="#,##0.##"/></th>
    				<!-- cntFee11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_11_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_10_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_09_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_08_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_07_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_06_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_05_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_04_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_03_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_02_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamAllTotalSum_01_15}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="feeColTeamAllTotalSum_15" value="${feeTeamAllTotalSum_12_15 + feeTeamAllTotalSum_11_15 + feeTeamAllTotalSum_10_15 + feeTeamAllTotalSum_09_15 + feeTeamAllTotalSum_08_15 + feeTeamAllTotalSum_07_15 + feeTeamAllTotalSum_06_15 + feeTeamAllTotalSum_05_15 + feeTeamAllTotalSum_04_15 + feeTeamAllTotalSum_03_15 + feeTeamAllTotalSum_02_15 + feeTeamAllTotalSum_01_15}"></c:set>
	                <c:set var="endColTeamAllTotalSum_15" value="${endTeamAllTotalSum_12_15 + endTeamAllTotalSum_11_15 + endTeamAllTotalSum_10_15 + endTeamAllTotalSum_09_15 + endTeamAllTotalSum_08_15 + endTeamAllTotalSum_07_15 + endTeamAllTotalSum_06_15 + endTeamAllTotalSum_05_15 + endTeamAllTotalSum_04_15 + endTeamAllTotalSum_03_15 + endTeamAllTotalSum_02_15 + endTeamAllTotalSum_01_15}"></c:set>
					<c:choose>
	                	<c:when test="${feeColTeamAllTotalSum_15 eq 0 or endColTeamAllTotalSum_15 eq 0}">
	                		<c:set var="arvColTeamAllTotalSum_15" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColTeamAllTotalSum_15" value="${feeColTeamAllTotalSum_15 / endColTeamAllTotalSum_15}"/>
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
    <c:set var="cntFeeTeamAllTotalSum_12_all" value="${cntFeeTeamAllTotalSum_12_5 + cntFeeTeamAllTotalSum_12_10 + cntFeeTeamAllTotalSum_12_15}"></c:set>
    <c:set var="cntFeeTeamAllTotalSum_11_all" value="${cntFeeTeamAllTotalSum_11_5 + cntFeeTeamAllTotalSum_11_10 + cntFeeTeamAllTotalSum_11_15}"></c:set>
    <c:set var="cntFeeTeamAllTotalSum_10_all" value="${cntFeeTeamAllTotalSum_10_5 + cntFeeTeamAllTotalSum_10_10 + cntFeeTeamAllTotalSum_10_15}"></c:set>
    <c:set var="cntFeeTeamAllTotalSum_09_all" value="${cntFeeTeamAllTotalSum_09_5 + cntFeeTeamAllTotalSum_09_10 + cntFeeTeamAllTotalSum_09_15}"></c:set>
    <c:set var="cntFeeTeamAllTotalSum_08_all" value="${cntFeeTeamAllTotalSum_08_5 + cntFeeTeamAllTotalSum_08_10 + cntFeeTeamAllTotalSum_08_15}"></c:set>
    <c:set var="cntFeeTeamAllTotalSum_07_all" value="${cntFeeTeamAllTotalSum_07_5 + cntFeeTeamAllTotalSum_07_10 + cntFeeTeamAllTotalSum_07_15}"></c:set>
    <c:set var="cntFeeTeamAllTotalSum_06_all" value="${cntFeeTeamAllTotalSum_06_5 + cntFeeTeamAllTotalSum_06_10 + cntFeeTeamAllTotalSum_06_15}"></c:set>
    <c:set var="cntFeeTeamAllTotalSum_05_all" value="${cntFeeTeamAllTotalSum_05_5 + cntFeeTeamAllTotalSum_05_10 + cntFeeTeamAllTotalSum_05_15}"></c:set>
    <c:set var="cntFeeTeamAllTotalSum_04_all" value="${cntFeeTeamAllTotalSum_04_5 + cntFeeTeamAllTotalSum_04_10 + cntFeeTeamAllTotalSum_04_15}"></c:set>
    <c:set var="cntFeeTeamAllTotalSum_03_all" value="${cntFeeTeamAllTotalSum_03_5 + cntFeeTeamAllTotalSum_03_10 + cntFeeTeamAllTotalSum_03_15}"></c:set>
    <c:set var="cntFeeTeamAllTotalSum_02_all" value="${cntFeeTeamAllTotalSum_02_5 + cntFeeTeamAllTotalSum_02_10 + cntFeeTeamAllTotalSum_02_15}"></c:set>
    <c:set var="cntFeeTeamAllTotalSum_01_all" value="${cntFeeTeamAllTotalSum_01_5 + cntFeeTeamAllTotalSum_01_10 + cntFeeTeamAllTotalSum_01_15}"></c:set>        
    <c:set var="cntFeeTeamAllTotalSum_col_all" value="${cntFeeTeamAllTotalSum_12_all + cntFeeTeamAllTotalSum_11_all + cntFeeTeamAllTotalSum_10_all + cntFeeTeamAllTotalSum_09_all + cntFeeTeamAllTotalSum_08_all + cntFeeTeamAllTotalSum_07_all + cntFeeTeamAllTotalSum_06_all + cntFeeTeamAllTotalSum_05_all + cntFeeTeamAllTotalSum_04_all + cntFeeTeamAllTotalSum_03_all + cntFeeTeamAllTotalSum_02_all + cntFeeTeamAllTotalSum_01_all}"></c:set>
    
    <c:set var="feeTeamAllTotalSum_12_all" value="${feeTeamAllTotalSum_12_5 + feeTeamAllTotalSum_12_10 + feeTeamAllTotalSum_12_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_11_all" value="${feeTeamAllTotalSum_11_5 + feeTeamAllTotalSum_11_10 + feeTeamAllTotalSum_11_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_10_all" value="${feeTeamAllTotalSum_10_5 + feeTeamAllTotalSum_10_10 + feeTeamAllTotalSum_10_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_09_all" value="${feeTeamAllTotalSum_09_5 + feeTeamAllTotalSum_09_10 + feeTeamAllTotalSum_09_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_08_all" value="${feeTeamAllTotalSum_08_5 + feeTeamAllTotalSum_08_10 + feeTeamAllTotalSum_08_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_07_all" value="${feeTeamAllTotalSum_07_5 + feeTeamAllTotalSum_07_10 + feeTeamAllTotalSum_07_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_06_all" value="${feeTeamAllTotalSum_06_5 + feeTeamAllTotalSum_06_10 + feeTeamAllTotalSum_06_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_05_all" value="${feeTeamAllTotalSum_05_5 + feeTeamAllTotalSum_05_10 + feeTeamAllTotalSum_05_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_04_all" value="${feeTeamAllTotalSum_04_5 + feeTeamAllTotalSum_04_10 + feeTeamAllTotalSum_04_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_03_all" value="${feeTeamAllTotalSum_03_5 + feeTeamAllTotalSum_03_10 + feeTeamAllTotalSum_03_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_02_all" value="${feeTeamAllTotalSum_02_5 + feeTeamAllTotalSum_02_10 + feeTeamAllTotalSum_02_15}"></c:set>
    <c:set var="feeTeamAllTotalSum_01_all" value="${feeTeamAllTotalSum_01_5 + feeTeamAllTotalSum_01_10 + feeTeamAllTotalSum_01_15}"></c:set>
    
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
		<c:when test="${feeTeamAllTotalSum_12_all eq 0 or endTeamAllTotalSum_12_all eq 0}">
			<c:set var="arvTeamAllTotalSum_12_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_12_all" value="${feeTeamAllTotalSum_12_all / endTeamAllTotalSum_12_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamAllTotalSum_11_all eq 0 or endTeamAllTotalSum_11_all eq 0}">
			<c:set var="arvTeamAllTotalSum_11_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_11_all" value="${feeTeamAllTotalSum_11_all / endTeamAllTotalSum_11_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamAllTotalSum_10_all eq 0 or endTeamAllTotalSum_10_all eq 0}">
			<c:set var="arvTeamAllTotalSum_10_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_10_all" value="${feeTeamAllTotalSum_10_all / endTeamAllTotalSum_10_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamAllTotalSum_09_all eq 0 or endTeamAllTotalSum_09_all eq 0}">
			<c:set var="arvTeamAllTotalSum_09_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_09_all" value="${feeTeamAllTotalSum_09_all / endTeamAllTotalSum_09_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamAllTotalSum_08_all eq 0 or endTeamAllTotalSum_08_all eq 0}">
			<c:set var="arvTeamAllTotalSum_08_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_08_all" value="${feeTeamAllTotalSum_08_all / endTeamAllTotalSum_08_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamAllTotalSum_07_all eq 0 or endTeamAllTotalSum_07_all eq 0}">
			<c:set var="arvTeamAllTotalSum_07_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_07_all" value="${feeTeamAllTotalSum_07_all / endTeamAllTotalSum_07_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamAllTotalSum_06_all eq 0 or endTeamAllTotalSum_06_all eq 0}">
			<c:set var="arvTeamAllTotalSum_06_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_06_all" value="${feeTeamAllTotalSum_06_all / endTeamAllTotalSum_06_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamAllTotalSum_05_all eq 0 or endTeamAllTotalSum_05_all eq 0}">
			<c:set var="arvTeamAllTotalSum_05_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_05_all" value="${feeTeamAllTotalSum_05_all / endTeamAllTotalSum_05_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamAllTotalSum_04_all eq 0 or endTeamAllTotalSum_04_all eq 0}">
			<c:set var="arvTeamAllTotalSum_04_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_04_all" value="${feeTeamAllTotalSum_04_all / endTeamAllTotalSum_04_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamAllTotalSum_03_all eq 0 or endTeamAllTotalSum_03_all eq 0}">
			<c:set var="arvTeamAllTotalSum_03_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_03_all" value="${feeTeamAllTotalSum_03_all / endTeamAllTotalSum_03_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamAllTotalSum_02_all eq 0 or endTeamAllTotalSum_02_all eq 0}">
			<c:set var="arvTeamAllTotalSum_02_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_02_all" value="${feeTeamAllTotalSum_02_all / endTeamAllTotalSum_02_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamAllTotalSum_01_all eq 0 or endTeamAllTotalSum_01_all eq 0}">
			<c:set var="arvTeamAllTotalSum_01_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamAllTotalSum_01_all" value="${feeTeamAllTotalSum_01_all / endTeamAllTotalSum_01_all}"></c:set>
		</c:otherwise>
	</c:choose>
	
	<!-- 가로 합계 -->
	<c:set var="feeColTeamAllTotalSum_all" value="${feeTeamAllTotalSum_12_all + feeTeamAllTotalSum_11_all + feeTeamAllTotalSum_10_all + feeTeamAllTotalSum_09_all + feeTeamAllTotalSum_08_all + feeTeamAllTotalSum_07_all + feeTeamAllTotalSum_06_all + feeTeamAllTotalSum_05_all + feeTeamAllTotalSum_04_all + feeTeamAllTotalSum_03_all + feeTeamAllTotalSum_02_all + feeTeamAllTotalSum_01_all}"></c:set>
	<c:set var="endColTeamAllTotalSum_all" value="${endTeamAllTotalSum_12_all + endTeamAllTotalSum_11_all + endTeamAllTotalSum_10_all + endTeamAllTotalSum_09_all + endTeamAllTotalSum_08_all + endTeamAllTotalSum_07_all + endTeamAllTotalSum_06_all + endTeamAllTotalSum_05_all + endTeamAllTotalSum_04_all + endTeamAllTotalSum_03_all + endTeamAllTotalSum_02_all + endTeamAllTotalSum_01_all}"></c:set>
	<c:choose>
		<c:when test="${feeColTeamAllTotalSum_all eq 0 or endColTeamAllTotalSum_all eq 0}">
			<c:set var="arvColTeamAllTotalSum_all" value="0"/>
		</c:when>
		<c:otherwise>
			<c:set var="arvColTeamAllTotalSum_all" value="${feeColTeamAllTotalSum_all / endColTeamAllTotalSum_all}"/>
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