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
	            <c:set var="cntFeeTeamSum_12_5" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_11_5" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_10_5" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_09_5" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_08_5" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_07_5" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_06_5" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_05_5" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_04_5" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_03_5" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_02_5" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_01_5" value="0"></c:set>
	            
	            <!-- 팀별 평균 계 초기화 -->
				<c:set var="feeTeamSum_12_5" value="0"></c:set>
				<c:set var="feeTeamSum_11_5" value="0"></c:set>
				<c:set var="feeTeamSum_10_5" value="0"></c:set>
				<c:set var="feeTeamSum_09_5" value="0"></c:set>
				<c:set var="feeTeamSum_08_5" value="0"></c:set>
				<c:set var="feeTeamSum_07_5" value="0"></c:set>
				<c:set var="feeTeamSum_06_5" value="0"></c:set>
				<c:set var="feeTeamSum_05_5" value="0"></c:set>
				<c:set var="feeTeamSum_04_5" value="0"></c:set>
				<c:set var="feeTeamSum_03_5" value="0"></c:set>
				<c:set var="feeTeamSum_02_5" value="0"></c:set>
				<c:set var="feeTeamSum_01_5" value="0"></c:set>
								    
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
	            <c:set var="cntFeeTeamTotalSum_12_5" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_11_5" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_10_5" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_09_5" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_08_5" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_07_5" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_06_5" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_05_5" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_04_5" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_03_5" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_02_5" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_01_5" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntFeeColTeamTotalSum_5" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="feeTeamTotalSum_12_5" value="0"></c:set>
				<c:set var="feeTeamTotalSum_11_5" value="0"></c:set>
				<c:set var="feeTeamTotalSum_10_5" value="0"></c:set>
				<c:set var="feeTeamTotalSum_09_5" value="0"></c:set>
				<c:set var="feeTeamTotalSum_08_5" value="0"></c:set>
				<c:set var="feeTeamTotalSum_07_5" value="0"></c:set>
				<c:set var="feeTeamTotalSum_06_5" value="0"></c:set>
				<c:set var="feeTeamTotalSum_05_5" value="0"></c:set>
				<c:set var="feeTeamTotalSum_04_5" value="0"></c:set>
				<c:set var="feeTeamTotalSum_03_5" value="0"></c:set>
				<c:set var="feeTeamTotalSum_02_5" value="0"></c:set>
				<c:set var="feeTeamTotalSum_01_5" value="0"></c:set>
				
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
   				    			
    			<c:forEach var="vo" items="${ptnrStatCntFeeList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCenterCntFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
		                    	1종 조사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatMember(${vo.ptnrId},${vo.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.teamName}</td>
		                		<td style="width:150px;">${vo.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="cntFeeTeamSum_12_5" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_11_5" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_10_5" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_09_5" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_08_5" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_07_5" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_06_5" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_05_5" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_04_5" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_03_5" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_02_5" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_01_5" value="0"></c:set>
					            
					            <!-- 팀별 평균 계 초기화 -->
								<c:set var="feeTeamSum_12_5" value="0"></c:set>
								<c:set var="feeTeamSum_11_5" value="0"></c:set>
								<c:set var="feeTeamSum_10_5" value="0"></c:set>
								<c:set var="feeTeamSum_09_5" value="0"></c:set>
								<c:set var="feeTeamSum_08_5" value="0"></c:set>
								<c:set var="feeTeamSum_07_5" value="0"></c:set>
								<c:set var="feeTeamSum_06_5" value="0"></c:set>
								<c:set var="feeTeamSum_05_5" value="0"></c:set>
								<c:set var="feeTeamSum_04_5" value="0"></c:set>
								<c:set var="feeTeamSum_03_5" value="0"></c:set>
								<c:set var="feeTeamSum_02_5" value="0"></c:set>
								<c:set var="feeTeamSum_01_5" value="0"></c:set>
												    
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
	    				<c:set var="cntFeeTeamSum_12_5" value="${cntFeeTeamSum_12_5+cntFee12_5}"></c:set>
			            <c:set var="cntFeeTeamSum_11_5" value="${cntFeeTeamSum_11_5+cntFee11_5}"></c:set>
			            <c:set var="cntFeeTeamSum_10_5" value="${cntFeeTeamSum_10_5+cntFee10_5}"></c:set>
			            <c:set var="cntFeeTeamSum_09_5" value="${cntFeeTeamSum_09_5+cntFee09_5}"></c:set>
			            <c:set var="cntFeeTeamSum_08_5" value="${cntFeeTeamSum_08_5+cntFee08_5}"></c:set>
			            <c:set var="cntFeeTeamSum_07_5" value="${cntFeeTeamSum_07_5+cntFee07_5}"></c:set>
			            <c:set var="cntFeeTeamSum_06_5" value="${cntFeeTeamSum_06_5+cntFee06_5}"></c:set>
			            <c:set var="cntFeeTeamSum_05_5" value="${cntFeeTeamSum_05_5+cntFee05_5}"></c:set>
			            <c:set var="cntFeeTeamSum_04_5" value="${cntFeeTeamSum_04_5+cntFee04_5}"></c:set>
			            <c:set var="cntFeeTeamSum_03_5" value="${cntFeeTeamSum_03_5+cntFee03_5}"></c:set>
			            <c:set var="cntFeeTeamSum_02_5" value="${cntFeeTeamSum_02_5+cntFee02_5}"></c:set>
			            <c:set var="cntFeeTeamSum_01_5" value="${cntFeeTeamSum_01_5+cntFee01_5}"></c:set>
			            
			            <!-- 팀별 계 평균용 변수 -->
						<c:set var="feeTeamSum_12_5" value="${feeTeamSum_12_5+fee12_5}"></c:set>
			            <c:set var="feeTeamSum_11_5" value="${feeTeamSum_11_5+fee11_5}"></c:set>
			            <c:set var="feeTeamSum_10_5" value="${feeTeamSum_10_5+fee10_5}"></c:set>
			            <c:set var="feeTeamSum_09_5" value="${feeTeamSum_09_5+fee09_5}"></c:set>
			            <c:set var="feeTeamSum_08_5" value="${feeTeamSum_08_5+fee08_5}"></c:set>
			            <c:set var="feeTeamSum_07_5" value="${feeTeamSum_07_5+fee07_5}"></c:set>
			            <c:set var="feeTeamSum_06_5" value="${feeTeamSum_06_5+fee06_5}"></c:set>
			            <c:set var="feeTeamSum_05_5" value="${feeTeamSum_05_5+fee05_5}"></c:set>
			            <c:set var="feeTeamSum_04_5" value="${feeTeamSum_04_5+fee04_5}"></c:set>
			            <c:set var="feeTeamSum_03_5" value="${feeTeamSum_03_5+fee03_5}"></c:set>
			            <c:set var="feeTeamSum_02_5" value="${feeTeamSum_02_5+fee02_5}"></c:set>
			            <c:set var="feeTeamSum_01_5" value="${feeTeamSum_01_5+fee01_5}"></c:set>
				    
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
	                    <c:set var="cntFeeTeamTotalSum_12_5" value="${cntFeeTeamTotalSum_12_5 + cntFee12_5}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_11_5" value="${cntFeeTeamTotalSum_11_5 + cntFee11_5}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_10_5" value="${cntFeeTeamTotalSum_10_5 + cntFee10_5}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_09_5" value="${cntFeeTeamTotalSum_09_5 + cntFee09_5}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_08_5" value="${cntFeeTeamTotalSum_08_5 + cntFee08_5}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_07_5" value="${cntFeeTeamTotalSum_07_5 + cntFee07_5}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_06_5" value="${cntFeeTeamTotalSum_06_5 + cntFee06_5}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_05_5" value="${cntFeeTeamTotalSum_05_5 + cntFee05_5}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_04_5" value="${cntFeeTeamTotalSum_04_5 + cntFee04_5}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_03_5" value="${cntFeeTeamTotalSum_03_5 + cntFee03_5}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_02_5" value="${cntFeeTeamTotalSum_02_5 + cntFee02_5}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_01_5" value="${cntFeeTeamTotalSum_01_5 + cntFee01_5}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="feeTeamTotalSum_12_5" value="${feeTeamTotalSum_12_5 + fee12_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_11_5" value="${feeTeamTotalSum_11_5 + fee11_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_10_5" value="${feeTeamTotalSum_10_5 + fee10_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_09_5" value="${feeTeamTotalSum_09_5 + fee09_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_08_5" value="${feeTeamTotalSum_08_5 + fee08_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_07_5" value="${feeTeamTotalSum_07_5 + fee07_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_06_5" value="${feeTeamTotalSum_06_5 + fee06_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_05_5" value="${feeTeamTotalSum_05_5 + fee05_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_04_5" value="${feeTeamTotalSum_04_5 + fee04_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_03_5" value="${feeTeamTotalSum_03_5 + fee03_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_02_5" value="${feeTeamTotalSum_02_5 + fee02_5}"></c:set>
	                    <c:set var="feeTeamTotalSum_01_5" value="${feeTeamTotalSum_01_5 + fee01_5}"></c:set>

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
		    					<c:when test="${feeTeamSum_12_5 eq 0 or endTeamSum_12_5 eq 0}">
		    						<c:set var="arvTeamSum_12_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_12_5" value="${feeTeamSum_12_5 / endTeamSum_12_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_11_5 eq 0 or endTeamSum_11_5 eq 0}">
		    						<c:set var="arvTeamSum_11_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_11_5" value="${feeTeamSum_11_5 / endTeamSum_11_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_10_5 eq 0 or endTeamSum_10_5 eq 0}">
		    						<c:set var="arvTeamSum_10_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_10_5" value="${feeTeamSum_10_5 / endTeamSum_10_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_09_5 eq 0 or endTeamSum_09_5 eq 0}">
		    						<c:set var="arvTeamSum_09_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_09_5" value="${feeTeamSum_09_5 / endTeamSum_09_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_08_5 eq 0 or endTeamSum_08_5 eq 0}">
		    						<c:set var="arvTeamSum_08_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_08_5" value="${feeTeamSum_08_5 / endTeamSum_08_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_07_5 eq 0 or endTeamSum_07_5 eq 0}">
		    						<c:set var="arvTeamSum_07_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_07_5" value="${feeTeamSum_07_5 / endTeamSum_07_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_06_5 eq 0 or endTeamSum_06_5 eq 0}">
		    						<c:set var="arvTeamSum_06_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_06_5" value="${feeTeamSum_06_5 / endTeamSum_06_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_05_5 eq 0 or endTeamSum_05_5 eq 0}">
		    						<c:set var="arvTeamSum_05_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_05_5" value="${feeTeamSum_05_5 / endTeamSum_05_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_04_5 eq 0 or endTeamSum_04_5 eq 0}">
		    						<c:set var="arvTeamSum_04_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_04_5" value="${feeTeamSum_04_5 / endTeamSum_04_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_03_5 eq 0 or endTeamSum_03_5 eq 0}">
		    						<c:set var="arvTeamSum_03_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_03_5" value="${feeTeamSum_03_5 / endTeamSum_03_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_02_5 eq 0 or endTeamSum_02_5 eq 0}">
		    						<c:set var="arvTeamSum_02_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_02_5" value="${feeTeamSum_02_5 / endTeamSum_02_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_01_5 eq 0 or endTeamSum_01_5 eq 0}">
		    						<c:set var="arvTeamSum_01_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_01_5" value="${feeTeamSum_01_5 / endTeamSum_01_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 팀별 평균 계산 끝 -->
		    						    				
		    				<!-- cntFee12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_12_5}" pattern="#,##0.##"/></td>
		    				<!-- cntFee11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_11_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_10_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_09_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_08_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_07_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_06_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_05_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_04_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_03_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_02_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_01_5}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="feeTeamColSum_5" value="${feeTeamSum_12_5 + feeTeamSum_11_5 + feeTeamSum_10_5 + feeTeamSum_09_5 + feeTeamSum_08_5 + feeTeamSum_07_5 + feeTeamSum_06_5 + feeTeamSum_05_5 + feeTeamSum_04_5 + feeTeamSum_03_5 + feeTeamSum_02_5 + feeTeamSum_01_5}"></c:set>
			                <c:set var="endTeamColSum_5" value="${endTeamSum_12_5 + endTeamSum_11_5 + endTeamSum_10_5 + endTeamSum_09_5 + endTeamSum_08_5 + endTeamSum_07_5 + endTeamSum_06_5 + endTeamSum_05_5 + endTeamSum_04_5 + endTeamSum_03_5 + endTeamSum_02_5 + endTeamSum_01_5}"></c:set>			                
			                <c:choose>
			                	<c:when test="${feeTeamColSum_5 eq 0 or endTeamColSum_5 eq 0}">
			                		<c:set var="arvTeamColSum_5" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvTeamColSum_5" value="${feeTeamColSum_5 / endTeamColSum_5}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamColSum_5}" pattern="#,##0.##"/></td>
		    				
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="cntFeeTeamSum_12_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_11_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_10_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_09_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_08_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_07_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_06_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_05_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_04_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_03_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_02_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_01_5" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="feeTeamSum_12_5" value="0"></c:set>
							<c:set var="feeTeamSum_11_5" value="0"></c:set>
							<c:set var="feeTeamSum_10_5" value="0"></c:set>
							<c:set var="feeTeamSum_09_5" value="0"></c:set>
							<c:set var="feeTeamSum_08_5" value="0"></c:set>
							<c:set var="feeTeamSum_07_5" value="0"></c:set>
							<c:set var="feeTeamSum_06_5" value="0"></c:set>
							<c:set var="feeTeamSum_05_5" value="0"></c:set>
							<c:set var="feeTeamSum_04_5" value="0"></c:set>
							<c:set var="feeTeamSum_03_5" value="0"></c:set>
							<c:set var="feeTeamSum_02_5" value="0"></c:set>
							<c:set var="feeTeamSum_01_5" value="0"></c:set>
											    
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
				            <c:set var="cntFeeTeamSum_12_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_11_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_10_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_09_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_08_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_07_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_06_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_05_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_04_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_03_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_02_5" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_01_5" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="feeTeamSum_12_5" value="0"></c:set>
							<c:set var="feeTeamSum_11_5" value="0"></c:set>
							<c:set var="feeTeamSum_10_5" value="0"></c:set>
							<c:set var="feeTeamSum_09_5" value="0"></c:set>
							<c:set var="feeTeamSum_08_5" value="0"></c:set>
							<c:set var="feeTeamSum_07_5" value="0"></c:set>
							<c:set var="feeTeamSum_06_5" value="0"></c:set>
							<c:set var="feeTeamSum_05_5" value="0"></c:set>
							<c:set var="feeTeamSum_04_5" value="0"></c:set>
							<c:set var="feeTeamSum_03_5" value="0"></c:set>
							<c:set var="feeTeamSum_02_5" value="0"></c:set>
							<c:set var="feeTeamSum_01_5" value="0"></c:set>
											    
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
		    	<c:if test="${ptnrStatCntFeeList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 조사 평균</th>
	                <c:choose>
    					<c:when test="${feeTeamTotalSum_12_5 eq 0 or endTeamTotalSum_12_5 eq 0}">
    						<c:set var="arvTeamTotalSum_12_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_12_5" value="${feeTeamTotalSum_12_5 / endTeamTotalSum_12_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_11_5 eq 0 or endTeamTotalSum_11_5 eq 0}">
    						<c:set var="arvTeamTotalSum_11_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_11_5" value="${feeTeamTotalSum_11_5 / endTeamTotalSum_11_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_10_5 eq 0 or endTeamTotalSum_10_5 eq 0}">
    						<c:set var="arvTeamTotalSum_10_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_10_5" value="${feeTeamTotalSum_10_5 / endTeamTotalSum_10_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_09_5 eq 0 or endTeamTotalSum_09_5 eq 0}">
    						<c:set var="arvTeamTotalSum_09_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_09_5" value="${feeTeamTotalSum_09_5 / endTeamTotalSum_09_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_08_5 eq 0 or endTeamTotalSum_08_5 eq 0}">
    						<c:set var="arvTeamTotalSum_08_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_08_5" value="${feeTeamTotalSum_08_5 / endTeamTotalSum_08_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_07_5 eq 0 or endTeamTotalSum_07_5 eq 0}">
    						<c:set var="arvTeamTotalSum_07_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_07_5" value="${feeTeamTotalSum_07_5 / endTeamTotalSum_07_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_06_5 eq 0 or endTeamTotalSum_06_5 eq 0}">
    						<c:set var="arvTeamTotalSum_06_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_06_5" value="${feeTeamTotalSum_06_5 / endTeamTotalSum_06_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_05_5 eq 0 or endTeamTotalSum_05_5 eq 0}">
    						<c:set var="arvTeamTotalSum_05_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_05_5" value="${feeTeamTotalSum_05_5 / endTeamTotalSum_05_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_04_5 eq 0 or endTeamTotalSum_04_5 eq 0}">
    						<c:set var="arvTeamTotalSum_04_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_04_5" value="${feeTeamTotalSum_04_5 / endTeamTotalSum_04_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_03_5 eq 0 or endTeamTotalSum_03_5 eq 0}">
    						<c:set var="arvTeamTotalSum_03_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_03_5" value="${feeTeamTotalSum_03_5 / endTeamTotalSum_03_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_02_5 eq 0 or endTeamTotalSum_02_5 eq 0}">
    						<c:set var="arvTeamTotalSum_02_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_02_5" value="${feeTeamTotalSum_02_5 / endTeamTotalSum_02_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_01_5 eq 0 or endTeamTotalSum_01_5 eq 0}">
    						<c:set var="arvTeamTotalSum_01_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_01_5" value="${feeTeamTotalSum_01_5 / endTeamTotalSum_01_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 팀별 평균 계산 끝 -->
    						    				
    				<!-- cntFee12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_12_5}" pattern="#,##0.##"/></th>
    				<!-- cntFee11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_11_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_10_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_09_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_08_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_07_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_06_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_05_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_04_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_03_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_02_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_01_5}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="feeColTeamTotalSum_5" value="${feeTeamTotalSum_12_5 + feeTeamTotalSum_11_5 + feeTeamTotalSum_10_5 + feeTeamTotalSum_09_5 + feeTeamTotalSum_08_5 + feeTeamTotalSum_07_5 + feeTeamTotalSum_06_5 + feeTeamTotalSum_05_5 + feeTeamTotalSum_04_5 + feeTeamTotalSum_03_5 + feeTeamTotalSum_02_5 + feeTeamTotalSum_01_5}"></c:set>
	                <c:set var="endColTeamTotalSum_5" value="${endTeamTotalSum_12_5 + endTeamTotalSum_11_5 + endTeamTotalSum_10_5 + endTeamTotalSum_09_5 + endTeamTotalSum_08_5 + endTeamTotalSum_07_5 + endTeamTotalSum_06_5 + endTeamTotalSum_05_5 + endTeamTotalSum_04_5 + endTeamTotalSum_03_5 + endTeamTotalSum_02_5 + endTeamTotalSum_01_5}"></c:set>
					<c:choose>
	                	<c:when test="${feeColTeamTotalSum_5 eq 0 or endColTeamTotalSum_5 eq 0}">
	                		<c:set var="arvColTeamTotalSum_5" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColTeamTotalSum_5" value="${feeColTeamTotalSum_5 / endColTeamTotalSum_5}"/>
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
	            <c:set var="cntFeeTeamSum_12_10" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_11_10" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_10_10" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_09_10" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_08_10" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_07_10" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_06_10" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_05_10" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_04_10" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_03_10" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_02_10" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_01_10" value="0"></c:set>
	            
	            <!-- 팀별 평균 계 초기화 -->
				<c:set var="feeTeamSum_12_10" value="0"></c:set>
				<c:set var="feeTeamSum_11_10" value="0"></c:set>
				<c:set var="feeTeamSum_10_10" value="0"></c:set>
				<c:set var="feeTeamSum_09_10" value="0"></c:set>
				<c:set var="feeTeamSum_08_10" value="0"></c:set>
				<c:set var="feeTeamSum_07_10" value="0"></c:set>
				<c:set var="feeTeamSum_06_10" value="0"></c:set>
				<c:set var="feeTeamSum_05_10" value="0"></c:set>
				<c:set var="feeTeamSum_04_10" value="0"></c:set>
				<c:set var="feeTeamSum_03_10" value="0"></c:set>
				<c:set var="feeTeamSum_02_10" value="0"></c:set>
				<c:set var="feeTeamSum_01_10" value="0"></c:set>
								    
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
	            <c:set var="cntFeeTeamTotalSum_12_10" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_11_10" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_10_10" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_09_10" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_08_10" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_07_10" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_06_10" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_05_10" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_04_10" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_03_10" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_02_10" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_01_10" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntFeeColTeamTotalSum_10" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="feeTeamTotalSum_12_10" value="0"></c:set>
				<c:set var="feeTeamTotalSum_11_10" value="0"></c:set>
				<c:set var="feeTeamTotalSum_10_10" value="0"></c:set>
				<c:set var="feeTeamTotalSum_09_10" value="0"></c:set>
				<c:set var="feeTeamTotalSum_08_10" value="0"></c:set>
				<c:set var="feeTeamTotalSum_07_10" value="0"></c:set>
				<c:set var="feeTeamTotalSum_06_10" value="0"></c:set>
				<c:set var="feeTeamTotalSum_05_10" value="0"></c:set>
				<c:set var="feeTeamTotalSum_04_10" value="0"></c:set>
				<c:set var="feeTeamTotalSum_03_10" value="0"></c:set>
				<c:set var="feeTeamTotalSum_02_10" value="0"></c:set>
				<c:set var="feeTeamTotalSum_01_10" value="0"></c:set>
				
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
   				    			
    			<c:forEach var="vo1" items="${ptnrStatCntFeeList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCenterCntFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
		                    	1종 심사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo1.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatMember(${vo1.ptnrId},${vo1.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.teamName}</td>
		                		<td style="width:150px;">${vo1.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="cntFeeTeamSum_12_10" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_11_10" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_10_10" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_09_10" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_08_10" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_07_10" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_06_10" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_05_10" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_04_10" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_03_10" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_02_10" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_01_10" value="0"></c:set>
					            
					            <!-- 팀별 평균 계 초기화 -->
								<c:set var="feeTeamSum_12_10" value="0"></c:set>
								<c:set var="feeTeamSum_11_10" value="0"></c:set>
								<c:set var="feeTeamSum_10_10" value="0"></c:set>
								<c:set var="feeTeamSum_09_10" value="0"></c:set>
								<c:set var="feeTeamSum_08_10" value="0"></c:set>
								<c:set var="feeTeamSum_07_10" value="0"></c:set>
								<c:set var="feeTeamSum_06_10" value="0"></c:set>
								<c:set var="feeTeamSum_05_10" value="0"></c:set>
								<c:set var="feeTeamSum_04_10" value="0"></c:set>
								<c:set var="feeTeamSum_03_10" value="0"></c:set>
								<c:set var="feeTeamSum_02_10" value="0"></c:set>
								<c:set var="feeTeamSum_01_10" value="0"></c:set>
												    
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
	    				<c:set var="cntFeeTeamSum_12_10" value="${cntFeeTeamSum_12_10+cntFee12_10}"></c:set>
			            <c:set var="cntFeeTeamSum_11_10" value="${cntFeeTeamSum_11_10+cntFee11_10}"></c:set>
			            <c:set var="cntFeeTeamSum_10_10" value="${cntFeeTeamSum_10_10+cntFee10_10}"></c:set>
			            <c:set var="cntFeeTeamSum_09_10" value="${cntFeeTeamSum_09_10+cntFee09_10}"></c:set>
			            <c:set var="cntFeeTeamSum_08_10" value="${cntFeeTeamSum_08_10+cntFee08_10}"></c:set>
			            <c:set var="cntFeeTeamSum_07_10" value="${cntFeeTeamSum_07_10+cntFee07_10}"></c:set>
			            <c:set var="cntFeeTeamSum_06_10" value="${cntFeeTeamSum_06_10+cntFee06_10}"></c:set>
			            <c:set var="cntFeeTeamSum_05_10" value="${cntFeeTeamSum_05_10+cntFee05_10}"></c:set>
			            <c:set var="cntFeeTeamSum_04_10" value="${cntFeeTeamSum_04_10+cntFee04_10}"></c:set>
			            <c:set var="cntFeeTeamSum_03_10" value="${cntFeeTeamSum_03_10+cntFee03_10}"></c:set>
			            <c:set var="cntFeeTeamSum_02_10" value="${cntFeeTeamSum_02_10+cntFee02_10}"></c:set>
			            <c:set var="cntFeeTeamSum_01_10" value="${cntFeeTeamSum_01_10+cntFee01_10}"></c:set>
			            
			            <!-- 팀별 계 평균용 변수 -->
						<c:set var="feeTeamSum_12_10" value="${feeTeamSum_12_10+fee12_10}"></c:set>
			            <c:set var="feeTeamSum_11_10" value="${feeTeamSum_11_10+fee11_10}"></c:set>
			            <c:set var="feeTeamSum_10_10" value="${feeTeamSum_10_10+fee10_10}"></c:set>
			            <c:set var="feeTeamSum_09_10" value="${feeTeamSum_09_10+fee09_10}"></c:set>
			            <c:set var="feeTeamSum_08_10" value="${feeTeamSum_08_10+fee08_10}"></c:set>
			            <c:set var="feeTeamSum_07_10" value="${feeTeamSum_07_10+fee07_10}"></c:set>
			            <c:set var="feeTeamSum_06_10" value="${feeTeamSum_06_10+fee06_10}"></c:set>
			            <c:set var="feeTeamSum_05_10" value="${feeTeamSum_05_10+fee05_10}"></c:set>
			            <c:set var="feeTeamSum_04_10" value="${feeTeamSum_04_10+fee04_10}"></c:set>
			            <c:set var="feeTeamSum_03_10" value="${feeTeamSum_03_10+fee03_10}"></c:set>
			            <c:set var="feeTeamSum_02_10" value="${feeTeamSum_02_10+fee02_10}"></c:set>
			            <c:set var="feeTeamSum_01_10" value="${feeTeamSum_01_10+fee01_10}"></c:set>
				    
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
	                    <c:set var="cntFeeTeamTotalSum_12_10" value="${cntFeeTeamTotalSum_12_10 + cntFee12_10}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_11_10" value="${cntFeeTeamTotalSum_11_10 + cntFee11_10}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_10_10" value="${cntFeeTeamTotalSum_10_10 + cntFee10_10}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_09_10" value="${cntFeeTeamTotalSum_09_10 + cntFee09_10}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_08_10" value="${cntFeeTeamTotalSum_08_10 + cntFee08_10}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_07_10" value="${cntFeeTeamTotalSum_07_10 + cntFee07_10}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_06_10" value="${cntFeeTeamTotalSum_06_10 + cntFee06_10}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_05_10" value="${cntFeeTeamTotalSum_05_10 + cntFee05_10}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_04_10" value="${cntFeeTeamTotalSum_04_10 + cntFee04_10}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_03_10" value="${cntFeeTeamTotalSum_03_10 + cntFee03_10}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_02_10" value="${cntFeeTeamTotalSum_02_10 + cntFee02_10}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_01_10" value="${cntFeeTeamTotalSum_01_10 + cntFee01_10}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="feeTeamTotalSum_12_10" value="${feeTeamTotalSum_12_10 + fee12_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_11_10" value="${feeTeamTotalSum_11_10 + fee11_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_10_10" value="${feeTeamTotalSum_10_10 + fee10_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_09_10" value="${feeTeamTotalSum_09_10 + fee09_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_08_10" value="${feeTeamTotalSum_08_10 + fee08_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_07_10" value="${feeTeamTotalSum_07_10 + fee07_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_06_10" value="${feeTeamTotalSum_06_10 + fee06_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_05_10" value="${feeTeamTotalSum_05_10 + fee05_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_04_10" value="${feeTeamTotalSum_04_10 + fee04_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_03_10" value="${feeTeamTotalSum_03_10 + fee03_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_02_10" value="${feeTeamTotalSum_02_10 + fee02_10}"></c:set>
	                    <c:set var="feeTeamTotalSum_01_10" value="${feeTeamTotalSum_01_10 + fee01_10}"></c:set>

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
		    					<c:when test="${feeTeamSum_12_10 eq 0 or endTeamSum_12_10 eq 0}">
		    						<c:set var="arvTeamSum_12_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_12_10" value="${feeTeamSum_12_10 / endTeamSum_12_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_11_10 eq 0 or endTeamSum_11_10 eq 0}">
		    						<c:set var="arvTeamSum_11_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_11_10" value="${feeTeamSum_11_10 / endTeamSum_11_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_10_10 eq 0 or endTeamSum_10_10 eq 0}">
		    						<c:set var="arvTeamSum_10_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_10_10" value="${feeTeamSum_10_10 / endTeamSum_10_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_09_10 eq 0 or endTeamSum_09_10 eq 0}">
		    						<c:set var="arvTeamSum_09_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_09_10" value="${feeTeamSum_09_10 / endTeamSum_09_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_08_10 eq 0 or endTeamSum_08_10 eq 0}">
		    						<c:set var="arvTeamSum_08_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_08_10" value="${feeTeamSum_08_10 / endTeamSum_08_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_07_10 eq 0 or endTeamSum_07_10 eq 0}">
		    						<c:set var="arvTeamSum_07_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_07_10" value="${feeTeamSum_07_10 / endTeamSum_07_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_06_10 eq 0 or endTeamSum_06_10 eq 0}">
		    						<c:set var="arvTeamSum_06_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_06_10" value="${feeTeamSum_06_10 / endTeamSum_06_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_05_10 eq 0 or endTeamSum_05_10 eq 0}">
		    						<c:set var="arvTeamSum_05_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_05_10" value="${feeTeamSum_05_10 / endTeamSum_05_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_04_10 eq 0 or endTeamSum_04_10 eq 0}">
		    						<c:set var="arvTeamSum_04_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_04_10" value="${feeTeamSum_04_10 / endTeamSum_04_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_03_10 eq 0 or endTeamSum_03_10 eq 0}">
		    						<c:set var="arvTeamSum_03_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_03_10" value="${feeTeamSum_03_10 / endTeamSum_03_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_02_10 eq 0 or endTeamSum_02_10 eq 0}">
		    						<c:set var="arvTeamSum_02_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_02_10" value="${feeTeamSum_02_10 / endTeamSum_02_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_01_10 eq 0 or endTeamSum_01_10 eq 0}">
		    						<c:set var="arvTeamSum_01_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_01_10" value="${feeTeamSum_01_10 / endTeamSum_01_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 팀별 평균 계산 끝 -->
		    						    				
		    				<!-- cntFee12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_12_10}" pattern="#,##0.##"/></td>
		    				<!-- cntFee11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_11_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_10_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_09_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_08_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_07_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_06_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_05_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_04_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_03_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_02_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_01_10}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="feeTeamColSum_10" value="${feeTeamSum_12_10 + feeTeamSum_11_10 + feeTeamSum_10_10 + feeTeamSum_09_10 + feeTeamSum_08_10 + feeTeamSum_07_10 + feeTeamSum_06_10 + feeTeamSum_05_10 + feeTeamSum_04_10 + feeTeamSum_03_10 + feeTeamSum_02_10 + feeTeamSum_01_10}"></c:set>
			                <c:set var="endTeamColSum_10" value="${endTeamSum_12_10 + endTeamSum_11_10 + endTeamSum_10_10 + endTeamSum_09_10 + endTeamSum_08_10 + endTeamSum_07_10 + endTeamSum_06_10 + endTeamSum_05_10 + endTeamSum_04_10 + endTeamSum_03_10 + endTeamSum_02_10 + endTeamSum_01_10}"></c:set>			                
			                <c:choose>
			                	<c:when test="${feeTeamColSum_10 eq 0 or endTeamColSum_10 eq 0}">
			                		<c:set var="arvTeamColSum_10" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvTeamColSum_10" value="${feeTeamColSum_10 / endTeamColSum_10}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamColSum_10}" pattern="#,##0.##"/></td>
		    				
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="cntFeeTeamSum_12_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_11_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_10_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_09_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_08_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_07_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_06_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_05_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_04_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_03_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_02_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_01_10" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="feeTeamSum_12_10" value="0"></c:set>
							<c:set var="feeTeamSum_11_10" value="0"></c:set>
							<c:set var="feeTeamSum_10_10" value="0"></c:set>
							<c:set var="feeTeamSum_09_10" value="0"></c:set>
							<c:set var="feeTeamSum_08_10" value="0"></c:set>
							<c:set var="feeTeamSum_07_10" value="0"></c:set>
							<c:set var="feeTeamSum_06_10" value="0"></c:set>
							<c:set var="feeTeamSum_05_10" value="0"></c:set>
							<c:set var="feeTeamSum_04_10" value="0"></c:set>
							<c:set var="feeTeamSum_03_10" value="0"></c:set>
							<c:set var="feeTeamSum_02_10" value="0"></c:set>
							<c:set var="feeTeamSum_01_10" value="0"></c:set>
											    
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
				            <c:set var="cntFeeTeamSum_12_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_11_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_10_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_09_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_08_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_07_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_06_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_05_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_04_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_03_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_02_10" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_01_10" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="feeTeamSum_12_10" value="0"></c:set>
							<c:set var="feeTeamSum_11_10" value="0"></c:set>
							<c:set var="feeTeamSum_10_10" value="0"></c:set>
							<c:set var="feeTeamSum_09_10" value="0"></c:set>
							<c:set var="feeTeamSum_08_10" value="0"></c:set>
							<c:set var="feeTeamSum_07_10" value="0"></c:set>
							<c:set var="feeTeamSum_06_10" value="0"></c:set>
							<c:set var="feeTeamSum_05_10" value="0"></c:set>
							<c:set var="feeTeamSum_04_10" value="0"></c:set>
							<c:set var="feeTeamSum_03_10" value="0"></c:set>
							<c:set var="feeTeamSum_02_10" value="0"></c:set>
							<c:set var="feeTeamSum_01_10" value="0"></c:set>
											    
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
		    	<c:if test="${ptnrStatCntFeeList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 심사 평균</th>
	                <c:choose>
    					<c:when test="${feeTeamTotalSum_12_10 eq 0 or endTeamTotalSum_12_10 eq 0}">
    						<c:set var="arvTeamTotalSum_12_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_12_10" value="${feeTeamTotalSum_12_10 / endTeamTotalSum_12_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_11_10 eq 0 or endTeamTotalSum_11_10 eq 0}">
    						<c:set var="arvTeamTotalSum_11_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_11_10" value="${feeTeamTotalSum_11_10 / endTeamTotalSum_11_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_10_10 eq 0 or endTeamTotalSum_10_10 eq 0}">
    						<c:set var="arvTeamTotalSum_10_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_10_10" value="${feeTeamTotalSum_10_10 / endTeamTotalSum_10_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_09_10 eq 0 or endTeamTotalSum_09_10 eq 0}">
    						<c:set var="arvTeamTotalSum_09_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_09_10" value="${feeTeamTotalSum_09_10 / endTeamTotalSum_09_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_08_10 eq 0 or endTeamTotalSum_08_10 eq 0}">
    						<c:set var="arvTeamTotalSum_08_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_08_10" value="${feeTeamTotalSum_08_10 / endTeamTotalSum_08_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_07_10 eq 0 or endTeamTotalSum_07_10 eq 0}">
    						<c:set var="arvTeamTotalSum_07_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_07_10" value="${feeTeamTotalSum_07_10 / endTeamTotalSum_07_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_06_10 eq 0 or endTeamTotalSum_06_10 eq 0}">
    						<c:set var="arvTeamTotalSum_06_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_06_10" value="${feeTeamTotalSum_06_10 / endTeamTotalSum_06_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_05_10 eq 0 or endTeamTotalSum_05_10 eq 0}">
    						<c:set var="arvTeamTotalSum_05_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_05_10" value="${feeTeamTotalSum_05_10 / endTeamTotalSum_05_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_04_10 eq 0 or endTeamTotalSum_04_10 eq 0}">
    						<c:set var="arvTeamTotalSum_04_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_04_10" value="${feeTeamTotalSum_04_10 / endTeamTotalSum_04_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_03_10 eq 0 or endTeamTotalSum_03_10 eq 0}">
    						<c:set var="arvTeamTotalSum_03_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_03_10" value="${feeTeamTotalSum_03_10 / endTeamTotalSum_03_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_02_10 eq 0 or endTeamTotalSum_02_10 eq 0}">
    						<c:set var="arvTeamTotalSum_02_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_02_10" value="${feeTeamTotalSum_02_10 / endTeamTotalSum_02_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_01_10 eq 0 or endTeamTotalSum_01_10 eq 0}">
    						<c:set var="arvTeamTotalSum_01_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_01_10" value="${feeTeamTotalSum_01_10 / endTeamTotalSum_01_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 팀별 평균 계산 끝 -->
    						    				
    				<!-- cntFee12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_12_10}" pattern="#,##0.##"/></th>
    				<!-- cntFee11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_11_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_10_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_09_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_08_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_07_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_06_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_05_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_04_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_03_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_02_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_01_10}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="feeColTeamTotalSum_10" value="${feeTeamTotalSum_12_10 + feeTeamTotalSum_11_10 + feeTeamTotalSum_10_10 + feeTeamTotalSum_09_10 + feeTeamTotalSum_08_10 + feeTeamTotalSum_07_10 + feeTeamTotalSum_06_10 + feeTeamTotalSum_05_10 + feeTeamTotalSum_04_10 + feeTeamTotalSum_03_10 + feeTeamTotalSum_02_10 + feeTeamTotalSum_01_10}"></c:set>
	                <c:set var="endColTeamTotalSum_10" value="${endTeamTotalSum_12_10 + endTeamTotalSum_11_10 + endTeamTotalSum_10_10 + endTeamTotalSum_09_10 + endTeamTotalSum_08_10 + endTeamTotalSum_07_10 + endTeamTotalSum_06_10 + endTeamTotalSum_05_10 + endTeamTotalSum_04_10 + endTeamTotalSum_03_10 + endTeamTotalSum_02_10 + endTeamTotalSum_01_10}"></c:set>
					<c:choose>
	                	<c:when test="${feeColTeamTotalSum_10 eq 0 or endColTeamTotalSum_10 eq 0}">
	                		<c:set var="arvColTeamTotalSum_10" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColTeamTotalSum_10" value="${feeColTeamTotalSum_10 / endColTeamTotalSum_10}"/>
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
	            <c:set var="cntFeeTeamSum_12_15" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_11_15" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_10_15" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_09_15" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_08_15" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_07_15" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_06_15" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_05_15" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_04_15" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_03_15" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_02_15" value="0"></c:set>
	            <c:set var="cntFeeTeamSum_01_15" value="0"></c:set>
	            
	            <!-- 팀별 평균 계 초기화 -->
				<c:set var="feeTeamSum_12_15" value="0"></c:set>
				<c:set var="feeTeamSum_11_15" value="0"></c:set>
				<c:set var="feeTeamSum_10_15" value="0"></c:set>
				<c:set var="feeTeamSum_09_15" value="0"></c:set>
				<c:set var="feeTeamSum_08_15" value="0"></c:set>
				<c:set var="feeTeamSum_07_15" value="0"></c:set>
				<c:set var="feeTeamSum_06_15" value="0"></c:set>
				<c:set var="feeTeamSum_05_15" value="0"></c:set>
				<c:set var="feeTeamSum_04_15" value="0"></c:set>
				<c:set var="feeTeamSum_03_15" value="0"></c:set>
				<c:set var="feeTeamSum_02_15" value="0"></c:set>
				<c:set var="feeTeamSum_01_15" value="0"></c:set>
								    
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
	            <c:set var="cntFeeTeamTotalSum_12_15" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_11_15" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_10_15" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_09_15" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_08_15" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_07_15" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_06_15" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_05_15" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_04_15" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_03_15" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_02_15" value="0"></c:set>
	            <c:set var="cntFeeTeamTotalSum_01_15" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntFeeColTeamTotalSum_15" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="feeTeamTotalSum_12_15" value="0"></c:set>
				<c:set var="feeTeamTotalSum_11_15" value="0"></c:set>
				<c:set var="feeTeamTotalSum_10_15" value="0"></c:set>
				<c:set var="feeTeamTotalSum_09_15" value="0"></c:set>
				<c:set var="feeTeamTotalSum_08_15" value="0"></c:set>
				<c:set var="feeTeamTotalSum_07_15" value="0"></c:set>
				<c:set var="feeTeamTotalSum_06_15" value="0"></c:set>
				<c:set var="feeTeamTotalSum_05_15" value="0"></c:set>
				<c:set var="feeTeamTotalSum_04_15" value="0"></c:set>
				<c:set var="feeTeamTotalSum_03_15" value="0"></c:set>
				<c:set var="feeTeamTotalSum_02_15" value="0"></c:set>
				<c:set var="feeTeamTotalSum_01_15" value="0"></c:set>
				
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
   				    			
    			<c:forEach var="vo2" items="${ptnrStatCntFeeList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCenterCntFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
		                    	1종 기타
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo2.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatMember(${vo2.ptnrId},${vo2.teamId});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.teamName}</td>
		                		<td style="width:150px;">${vo2.ptnrIdSubNm}</td>
		                		<!-- 팀별 계 초기화 -->
					            <c:set var="cntFeeTeamSum_12_15" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_11_15" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_10_15" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_09_15" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_08_15" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_07_15" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_06_15" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_05_15" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_04_15" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_03_15" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_02_15" value="0"></c:set>
					            <c:set var="cntFeeTeamSum_01_15" value="0"></c:set>
					            
					            <!-- 팀별 평균 계 초기화 -->
								<c:set var="feeTeamSum_12_15" value="0"></c:set>
								<c:set var="feeTeamSum_11_15" value="0"></c:set>
								<c:set var="feeTeamSum_10_15" value="0"></c:set>
								<c:set var="feeTeamSum_09_15" value="0"></c:set>
								<c:set var="feeTeamSum_08_15" value="0"></c:set>
								<c:set var="feeTeamSum_07_15" value="0"></c:set>
								<c:set var="feeTeamSum_06_15" value="0"></c:set>
								<c:set var="feeTeamSum_05_15" value="0"></c:set>
								<c:set var="feeTeamSum_04_15" value="0"></c:set>
								<c:set var="feeTeamSum_03_15" value="0"></c:set>
								<c:set var="feeTeamSum_02_15" value="0"></c:set>
								<c:set var="feeTeamSum_01_15" value="0"></c:set>
												    
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
	    				<c:set var="cntFeeTeamSum_12_15" value="${cntFeeTeamSum_12_15+cntFee12_15}"></c:set>
			            <c:set var="cntFeeTeamSum_11_15" value="${cntFeeTeamSum_11_15+cntFee11_15}"></c:set>
			            <c:set var="cntFeeTeamSum_10_15" value="${cntFeeTeamSum_10_15+cntFee10_15}"></c:set>
			            <c:set var="cntFeeTeamSum_09_15" value="${cntFeeTeamSum_09_15+cntFee09_15}"></c:set>
			            <c:set var="cntFeeTeamSum_08_15" value="${cntFeeTeamSum_08_15+cntFee08_15}"></c:set>
			            <c:set var="cntFeeTeamSum_07_15" value="${cntFeeTeamSum_07_15+cntFee07_15}"></c:set>
			            <c:set var="cntFeeTeamSum_06_15" value="${cntFeeTeamSum_06_15+cntFee06_15}"></c:set>
			            <c:set var="cntFeeTeamSum_05_15" value="${cntFeeTeamSum_05_15+cntFee05_15}"></c:set>
			            <c:set var="cntFeeTeamSum_04_15" value="${cntFeeTeamSum_04_15+cntFee04_15}"></c:set>
			            <c:set var="cntFeeTeamSum_03_15" value="${cntFeeTeamSum_03_15+cntFee03_15}"></c:set>
			            <c:set var="cntFeeTeamSum_02_15" value="${cntFeeTeamSum_02_15+cntFee02_15}"></c:set>
			            <c:set var="cntFeeTeamSum_01_15" value="${cntFeeTeamSum_01_15+cntFee01_15}"></c:set>
			            
			            <!-- 팀별 계 평균용 변수 -->
						<c:set var="feeTeamSum_12_15" value="${feeTeamSum_12_15+fee12_15}"></c:set>
			            <c:set var="feeTeamSum_11_15" value="${feeTeamSum_11_15+fee11_15}"></c:set>
			            <c:set var="feeTeamSum_10_15" value="${feeTeamSum_10_15+fee10_15}"></c:set>
			            <c:set var="feeTeamSum_09_15" value="${feeTeamSum_09_15+fee09_15}"></c:set>
			            <c:set var="feeTeamSum_08_15" value="${feeTeamSum_08_15+fee08_15}"></c:set>
			            <c:set var="feeTeamSum_07_15" value="${feeTeamSum_07_15+fee07_15}"></c:set>
			            <c:set var="feeTeamSum_06_15" value="${feeTeamSum_06_15+fee06_15}"></c:set>
			            <c:set var="feeTeamSum_05_15" value="${feeTeamSum_05_15+fee05_15}"></c:set>
			            <c:set var="feeTeamSum_04_15" value="${feeTeamSum_04_15+fee04_15}"></c:set>
			            <c:set var="feeTeamSum_03_15" value="${feeTeamSum_03_15+fee03_15}"></c:set>
			            <c:set var="feeTeamSum_02_15" value="${feeTeamSum_02_15+fee02_15}"></c:set>
			            <c:set var="feeTeamSum_01_15" value="${feeTeamSum_01_15+fee01_15}"></c:set>
				    
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
	                    <c:set var="cntFeeTeamTotalSum_12_15" value="${cntFeeTeamTotalSum_12_15 + cntFee12_15}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_11_15" value="${cntFeeTeamTotalSum_11_15 + cntFee11_15}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_10_15" value="${cntFeeTeamTotalSum_10_15 + cntFee10_15}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_09_15" value="${cntFeeTeamTotalSum_09_15 + cntFee09_15}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_08_15" value="${cntFeeTeamTotalSum_08_15 + cntFee08_15}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_07_15" value="${cntFeeTeamTotalSum_07_15 + cntFee07_15}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_06_15" value="${cntFeeTeamTotalSum_06_15 + cntFee06_15}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_05_15" value="${cntFeeTeamTotalSum_05_15 + cntFee05_15}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_04_15" value="${cntFeeTeamTotalSum_04_15 + cntFee04_15}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_03_15" value="${cntFeeTeamTotalSum_03_15 + cntFee03_15}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_02_15" value="${cntFeeTeamTotalSum_02_15 + cntFee02_15}"></c:set>
	                    <c:set var="cntFeeTeamTotalSum_01_15" value="${cntFeeTeamTotalSum_01_15 + cntFee01_15}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="feeTeamTotalSum_12_15" value="${feeTeamTotalSum_12_15 + fee12_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_11_15" value="${feeTeamTotalSum_11_15 + fee11_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_10_15" value="${feeTeamTotalSum_10_15 + fee10_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_09_15" value="${feeTeamTotalSum_09_15 + fee09_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_08_15" value="${feeTeamTotalSum_08_15 + fee08_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_07_15" value="${feeTeamTotalSum_07_15 + fee07_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_06_15" value="${feeTeamTotalSum_06_15 + fee06_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_05_15" value="${feeTeamTotalSum_05_15 + fee05_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_04_15" value="${feeTeamTotalSum_04_15 + fee04_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_03_15" value="${feeTeamTotalSum_03_15 + fee03_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_02_15" value="${feeTeamTotalSum_02_15 + fee02_15}"></c:set>
	                    <c:set var="feeTeamTotalSum_01_15" value="${feeTeamTotalSum_01_15 + fee01_15}"></c:set>

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
		    					<c:when test="${feeTeamSum_12_15 eq 0 or endTeamSum_12_15 eq 0}">
		    						<c:set var="arvTeamSum_12_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_12_15" value="${feeTeamSum_12_15 / endTeamSum_12_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_11_15 eq 0 or endTeamSum_11_15 eq 0}">
		    						<c:set var="arvTeamSum_11_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_11_15" value="${feeTeamSum_11_15 / endTeamSum_11_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_10_15 eq 0 or endTeamSum_10_15 eq 0}">
		    						<c:set var="arvTeamSum_10_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_10_15" value="${feeTeamSum_10_15 / endTeamSum_10_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_09_15 eq 0 or endTeamSum_09_15 eq 0}">
		    						<c:set var="arvTeamSum_09_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_09_15" value="${feeTeamSum_09_15 / endTeamSum_09_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_08_15 eq 0 or endTeamSum_08_15 eq 0}">
		    						<c:set var="arvTeamSum_08_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_08_15" value="${feeTeamSum_08_15 / endTeamSum_08_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_07_15 eq 0 or endTeamSum_07_15 eq 0}">
		    						<c:set var="arvTeamSum_07_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_07_15" value="${feeTeamSum_07_15 / endTeamSum_07_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_06_15 eq 0 or endTeamSum_06_15 eq 0}">
		    						<c:set var="arvTeamSum_06_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_06_15" value="${feeTeamSum_06_15 / endTeamSum_06_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_05_15 eq 0 or endTeamSum_05_15 eq 0}">
		    						<c:set var="arvTeamSum_05_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_05_15" value="${feeTeamSum_05_15 / endTeamSum_05_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_04_15 eq 0 or endTeamSum_04_15 eq 0}">
		    						<c:set var="arvTeamSum_04_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_04_15" value="${feeTeamSum_04_15 / endTeamSum_04_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_03_15 eq 0 or endTeamSum_03_15 eq 0}">
		    						<c:set var="arvTeamSum_03_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_03_15" value="${feeTeamSum_03_15 / endTeamSum_03_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_02_15 eq 0 or endTeamSum_02_15 eq 0}">
		    						<c:set var="arvTeamSum_02_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_02_15" value="${feeTeamSum_02_15 / endTeamSum_02_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeTeamSum_01_15 eq 0 or endTeamSum_01_15 eq 0}">
		    						<c:set var="arvTeamSum_01_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvTeamSum_01_15" value="${feeTeamSum_01_15 / endTeamSum_01_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 팀별 평균 계산 끝 -->
		    						    				
		    				<!-- cntFee12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_12_15}" pattern="#,##0.##"/></td>
		    				<!-- cntFee11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_11_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_10_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_09_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_08_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_07_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_06_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_05_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_04_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_03_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_02_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamSum_01_15}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="feeTeamColSum_15" value="${feeTeamSum_12_15 + feeTeamSum_11_15 + feeTeamSum_10_15 + feeTeamSum_09_15 + feeTeamSum_08_15 + feeTeamSum_07_15 + feeTeamSum_06_15 + feeTeamSum_05_15 + feeTeamSum_04_15 + feeTeamSum_03_15 + feeTeamSum_02_15 + feeTeamSum_01_15}"></c:set>
			                <c:set var="endTeamColSum_15" value="${endTeamSum_12_15 + endTeamSum_11_15 + endTeamSum_10_15 + endTeamSum_09_15 + endTeamSum_08_15 + endTeamSum_07_15 + endTeamSum_06_15 + endTeamSum_05_15 + endTeamSum_04_15 + endTeamSum_03_15 + endTeamSum_02_15 + endTeamSum_01_15}"></c:set>			                
			                <c:choose>
			                	<c:when test="${feeTeamColSum_15 eq 0 or endTeamColSum_15 eq 0}">
			                		<c:set var="arvTeamColSum_15" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvTeamColSum_15" value="${feeTeamColSum_15 / endTeamColSum_15}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvTeamColSum_15}" pattern="#,##0.##"/></td>
		    				
							<!-- 팀별 계 카운트 초기화 -->
		    				<c:set var="teamCnt" value="1"></c:set>										                		    				
		    				<!-- 팀별 계 초기화 -->
				            <c:set var="cntFeeTeamSum_12_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_11_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_10_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_09_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_08_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_07_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_06_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_05_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_04_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_03_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_02_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_01_15" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="feeTeamSum_12_15" value="0"></c:set>
							<c:set var="feeTeamSum_11_15" value="0"></c:set>
							<c:set var="feeTeamSum_10_15" value="0"></c:set>
							<c:set var="feeTeamSum_09_15" value="0"></c:set>
							<c:set var="feeTeamSum_08_15" value="0"></c:set>
							<c:set var="feeTeamSum_07_15" value="0"></c:set>
							<c:set var="feeTeamSum_06_15" value="0"></c:set>
							<c:set var="feeTeamSum_05_15" value="0"></c:set>
							<c:set var="feeTeamSum_04_15" value="0"></c:set>
							<c:set var="feeTeamSum_03_15" value="0"></c:set>
							<c:set var="feeTeamSum_02_15" value="0"></c:set>
							<c:set var="feeTeamSum_01_15" value="0"></c:set>
											    
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
				            <c:set var="cntFeeTeamSum_12_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_11_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_10_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_09_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_08_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_07_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_06_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_05_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_04_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_03_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_02_15" value="0"></c:set>
				            <c:set var="cntFeeTeamSum_01_15" value="0"></c:set>
				            
				            <!-- 팀별 평균 계 초기화 -->
							<c:set var="feeTeamSum_12_15" value="0"></c:set>
							<c:set var="feeTeamSum_11_15" value="0"></c:set>
							<c:set var="feeTeamSum_10_15" value="0"></c:set>
							<c:set var="feeTeamSum_09_15" value="0"></c:set>
							<c:set var="feeTeamSum_08_15" value="0"></c:set>
							<c:set var="feeTeamSum_07_15" value="0"></c:set>
							<c:set var="feeTeamSum_06_15" value="0"></c:set>
							<c:set var="feeTeamSum_05_15" value="0"></c:set>
							<c:set var="feeTeamSum_04_15" value="0"></c:set>
							<c:set var="feeTeamSum_03_15" value="0"></c:set>
							<c:set var="feeTeamSum_02_15" value="0"></c:set>
							<c:set var="feeTeamSum_01_15" value="0"></c:set>
											    
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
		    	<c:if test="${ptnrStatCntFeeList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 기타 평균</th>
	                <c:choose>
    					<c:when test="${feeTeamTotalSum_12_15 eq 0 or endTeamTotalSum_12_15 eq 0}">
    						<c:set var="arvTeamTotalSum_12_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_12_15" value="${feeTeamTotalSum_12_15 / endTeamTotalSum_12_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_11_15 eq 0 or endTeamTotalSum_11_15 eq 0}">
    						<c:set var="arvTeamTotalSum_11_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_11_15" value="${feeTeamTotalSum_11_15 / endTeamTotalSum_11_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_10_15 eq 0 or endTeamTotalSum_10_15 eq 0}">
    						<c:set var="arvTeamTotalSum_10_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_10_15" value="${feeTeamTotalSum_10_15 / endTeamTotalSum_10_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_09_15 eq 0 or endTeamTotalSum_09_15 eq 0}">
    						<c:set var="arvTeamTotalSum_09_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_09_15" value="${feeTeamTotalSum_09_15 / endTeamTotalSum_09_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_08_15 eq 0 or endTeamTotalSum_08_15 eq 0}">
    						<c:set var="arvTeamTotalSum_08_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_08_15" value="${feeTeamTotalSum_08_15 / endTeamTotalSum_08_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_07_15 eq 0 or endTeamTotalSum_07_15 eq 0}">
    						<c:set var="arvTeamTotalSum_07_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_07_15" value="${feeTeamTotalSum_07_15 / endTeamTotalSum_07_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_06_15 eq 0 or endTeamTotalSum_06_15 eq 0}">
    						<c:set var="arvTeamTotalSum_06_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_06_15" value="${feeTeamTotalSum_06_15 / endTeamTotalSum_06_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_05_15 eq 0 or endTeamTotalSum_05_15 eq 0}">
    						<c:set var="arvTeamTotalSum_05_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_05_15" value="${feeTeamTotalSum_05_15 / endTeamTotalSum_05_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_04_15 eq 0 or endTeamTotalSum_04_15 eq 0}">
    						<c:set var="arvTeamTotalSum_04_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_04_15" value="${feeTeamTotalSum_04_15 / endTeamTotalSum_04_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_03_15 eq 0 or endTeamTotalSum_03_15 eq 0}">
    						<c:set var="arvTeamTotalSum_03_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_03_15" value="${feeTeamTotalSum_03_15 / endTeamTotalSum_03_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_02_15 eq 0 or endTeamTotalSum_02_15 eq 0}">
    						<c:set var="arvTeamTotalSum_02_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_02_15" value="${feeTeamTotalSum_02_15 / endTeamTotalSum_02_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeTeamTotalSum_01_15 eq 0 or endTeamTotalSum_01_15 eq 0}">
    						<c:set var="arvTeamTotalSum_01_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvTeamTotalSum_01_15" value="${feeTeamTotalSum_01_15 / endTeamTotalSum_01_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 팀별 평균 계산 끝 -->
    						    				
    				<!-- cntFee12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_12_15}" pattern="#,##0.##"/></th>
    				<!-- cntFee11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_11_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_10_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_09_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_08_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_07_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_06_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_05_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_04_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_03_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_02_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvTeamTotalSum_01_15}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="feeColTeamTotalSum_15" value="${feeTeamTotalSum_12_15 + feeTeamTotalSum_11_15 + feeTeamTotalSum_10_15 + feeTeamTotalSum_09_15 + feeTeamTotalSum_08_15 + feeTeamTotalSum_07_15 + feeTeamTotalSum_06_15 + feeTeamTotalSum_05_15 + feeTeamTotalSum_04_15 + feeTeamTotalSum_03_15 + feeTeamTotalSum_02_15 + feeTeamTotalSum_01_15}"></c:set>
	                <c:set var="endColTeamTotalSum_15" value="${endTeamTotalSum_12_15 + endTeamTotalSum_11_15 + endTeamTotalSum_10_15 + endTeamTotalSum_09_15 + endTeamTotalSum_08_15 + endTeamTotalSum_07_15 + endTeamTotalSum_06_15 + endTeamTotalSum_05_15 + endTeamTotalSum_04_15 + endTeamTotalSum_03_15 + endTeamTotalSum_02_15 + endTeamTotalSum_01_15}"></c:set>
					<c:choose>
	                	<c:when test="${feeColTeamTotalSum_15 eq 0 or endColTeamTotalSum_15 eq 0}">
	                		<c:set var="arvColTeamTotalSum_15" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColTeamTotalSum_15" value="${feeColTeamTotalSum_15 / endColTeamTotalSum_15}"/>
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
    <c:set var="cntFeeTeamTotalSum_12_all" value="${cntFeeTeamTotalSum_12_5 + cntFeeTeamTotalSum_12_10 + cntFeeTeamTotalSum_12_15}"></c:set>
    <c:set var="cntFeeTeamTotalSum_11_all" value="${cntFeeTeamTotalSum_11_5 + cntFeeTeamTotalSum_11_10 + cntFeeTeamTotalSum_11_15}"></c:set>
    <c:set var="cntFeeTeamTotalSum_10_all" value="${cntFeeTeamTotalSum_10_5 + cntFeeTeamTotalSum_10_10 + cntFeeTeamTotalSum_10_15}"></c:set>
    <c:set var="cntFeeTeamTotalSum_09_all" value="${cntFeeTeamTotalSum_09_5 + cntFeeTeamTotalSum_09_10 + cntFeeTeamTotalSum_09_15}"></c:set>
    <c:set var="cntFeeTeamTotalSum_08_all" value="${cntFeeTeamTotalSum_08_5 + cntFeeTeamTotalSum_08_10 + cntFeeTeamTotalSum_08_15}"></c:set>
    <c:set var="cntFeeTeamTotalSum_07_all" value="${cntFeeTeamTotalSum_07_5 + cntFeeTeamTotalSum_07_10 + cntFeeTeamTotalSum_07_15}"></c:set>
    <c:set var="cntFeeTeamTotalSum_06_all" value="${cntFeeTeamTotalSum_06_5 + cntFeeTeamTotalSum_06_10 + cntFeeTeamTotalSum_06_15}"></c:set>
    <c:set var="cntFeeTeamTotalSum_05_all" value="${cntFeeTeamTotalSum_05_5 + cntFeeTeamTotalSum_05_10 + cntFeeTeamTotalSum_05_15}"></c:set>
    <c:set var="cntFeeTeamTotalSum_04_all" value="${cntFeeTeamTotalSum_04_5 + cntFeeTeamTotalSum_04_10 + cntFeeTeamTotalSum_04_15}"></c:set>
    <c:set var="cntFeeTeamTotalSum_03_all" value="${cntFeeTeamTotalSum_03_5 + cntFeeTeamTotalSum_03_10 + cntFeeTeamTotalSum_03_15}"></c:set>
    <c:set var="cntFeeTeamTotalSum_02_all" value="${cntFeeTeamTotalSum_02_5 + cntFeeTeamTotalSum_02_10 + cntFeeTeamTotalSum_02_15}"></c:set>
    <c:set var="cntFeeTeamTotalSum_01_all" value="${cntFeeTeamTotalSum_01_5 + cntFeeTeamTotalSum_01_10 + cntFeeTeamTotalSum_01_15}"></c:set>        
    <c:set var="cntFeeTeamTotalSum_col_all" value="${cntFeeTeamTotalSum_12_all + cntFeeTeamTotalSum_11_all + cntFeeTeamTotalSum_10_all + cntFeeTeamTotalSum_09_all + cntFeeTeamTotalSum_08_all + cntFeeTeamTotalSum_07_all + cntFeeTeamTotalSum_06_all + cntFeeTeamTotalSum_05_all + cntFeeTeamTotalSum_04_all + cntFeeTeamTotalSum_03_all + cntFeeTeamTotalSum_02_all + cntFeeTeamTotalSum_01_all}"></c:set>
    
    <c:set var="feeTeamTotalSum_12_all" value="${feeTeamTotalSum_12_5 + feeTeamTotalSum_12_10 + feeTeamTotalSum_12_15}"></c:set>
    <c:set var="feeTeamTotalSum_11_all" value="${feeTeamTotalSum_11_5 + feeTeamTotalSum_11_10 + feeTeamTotalSum_11_15}"></c:set>
    <c:set var="feeTeamTotalSum_10_all" value="${feeTeamTotalSum_10_5 + feeTeamTotalSum_10_10 + feeTeamTotalSum_10_15}"></c:set>
    <c:set var="feeTeamTotalSum_09_all" value="${feeTeamTotalSum_09_5 + feeTeamTotalSum_09_10 + feeTeamTotalSum_09_15}"></c:set>
    <c:set var="feeTeamTotalSum_08_all" value="${feeTeamTotalSum_08_5 + feeTeamTotalSum_08_10 + feeTeamTotalSum_08_15}"></c:set>
    <c:set var="feeTeamTotalSum_07_all" value="${feeTeamTotalSum_07_5 + feeTeamTotalSum_07_10 + feeTeamTotalSum_07_15}"></c:set>
    <c:set var="feeTeamTotalSum_06_all" value="${feeTeamTotalSum_06_5 + feeTeamTotalSum_06_10 + feeTeamTotalSum_06_15}"></c:set>
    <c:set var="feeTeamTotalSum_05_all" value="${feeTeamTotalSum_05_5 + feeTeamTotalSum_05_10 + feeTeamTotalSum_05_15}"></c:set>
    <c:set var="feeTeamTotalSum_04_all" value="${feeTeamTotalSum_04_5 + feeTeamTotalSum_04_10 + feeTeamTotalSum_04_15}"></c:set>
    <c:set var="feeTeamTotalSum_03_all" value="${feeTeamTotalSum_03_5 + feeTeamTotalSum_03_10 + feeTeamTotalSum_03_15}"></c:set>
    <c:set var="feeTeamTotalSum_02_all" value="${feeTeamTotalSum_02_5 + feeTeamTotalSum_02_10 + feeTeamTotalSum_02_15}"></c:set>
    <c:set var="feeTeamTotalSum_01_all" value="${feeTeamTotalSum_01_5 + feeTeamTotalSum_01_10 + feeTeamTotalSum_01_15}"></c:set>
    
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
		<c:when test="${feeTeamTotalSum_12_all eq 0 or endTeamTotalSum_12_all eq 0}">
			<c:set var="arvTeamTotalSum_12_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_12_all" value="${feeTeamTotalSum_12_all / endTeamTotalSum_12_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamTotalSum_11_all eq 0 or endTeamTotalSum_11_all eq 0}">
			<c:set var="arvTeamTotalSum_11_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_11_all" value="${feeTeamTotalSum_11_all / endTeamTotalSum_11_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamTotalSum_10_all eq 0 or endTeamTotalSum_10_all eq 0}">
			<c:set var="arvTeamTotalSum_10_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_10_all" value="${feeTeamTotalSum_10_all / endTeamTotalSum_10_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamTotalSum_09_all eq 0 or endTeamTotalSum_09_all eq 0}">
			<c:set var="arvTeamTotalSum_09_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_09_all" value="${feeTeamTotalSum_09_all / endTeamTotalSum_09_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamTotalSum_08_all eq 0 or endTeamTotalSum_08_all eq 0}">
			<c:set var="arvTeamTotalSum_08_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_08_all" value="${feeTeamTotalSum_08_all / endTeamTotalSum_08_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamTotalSum_07_all eq 0 or endTeamTotalSum_07_all eq 0}">
			<c:set var="arvTeamTotalSum_07_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_07_all" value="${feeTeamTotalSum_07_all / endTeamTotalSum_07_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamTotalSum_06_all eq 0 or endTeamTotalSum_06_all eq 0}">
			<c:set var="arvTeamTotalSum_06_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_06_all" value="${feeTeamTotalSum_06_all / endTeamTotalSum_06_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamTotalSum_05_all eq 0 or endTeamTotalSum_05_all eq 0}">
			<c:set var="arvTeamTotalSum_05_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_05_all" value="${feeTeamTotalSum_05_all / endTeamTotalSum_05_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamTotalSum_04_all eq 0 or endTeamTotalSum_04_all eq 0}">
			<c:set var="arvTeamTotalSum_04_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_04_all" value="${feeTeamTotalSum_04_all / endTeamTotalSum_04_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamTotalSum_03_all eq 0 or endTeamTotalSum_03_all eq 0}">
			<c:set var="arvTeamTotalSum_03_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_03_all" value="${feeTeamTotalSum_03_all / endTeamTotalSum_03_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamTotalSum_02_all eq 0 or endTeamTotalSum_02_all eq 0}">
			<c:set var="arvTeamTotalSum_02_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_02_all" value="${feeTeamTotalSum_02_all / endTeamTotalSum_02_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeTeamTotalSum_01_all eq 0 or endTeamTotalSum_01_all eq 0}">
			<c:set var="arvTeamTotalSum_01_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvTeamTotalSum_01_all" value="${feeTeamTotalSum_01_all / endTeamTotalSum_01_all}"></c:set>
		</c:otherwise>
	</c:choose>
	
	<!-- 가로 합계 -->
	<c:set var="feeColTeamTotalSum_all" value="${feeTeamTotalSum_12_all + feeTeamTotalSum_11_all + feeTeamTotalSum_10_all + feeTeamTotalSum_09_all + feeTeamTotalSum_08_all + feeTeamTotalSum_07_all + feeTeamTotalSum_06_all + feeTeamTotalSum_05_all + feeTeamTotalSum_04_all + feeTeamTotalSum_03_all + feeTeamTotalSum_02_all + feeTeamTotalSum_01_all}"></c:set>
	<c:set var="endColTeamTotalSum_all" value="${endTeamTotalSum_12_all + endTeamTotalSum_11_all + endTeamTotalSum_10_all + endTeamTotalSum_09_all + endTeamTotalSum_08_all + endTeamTotalSum_07_all + endTeamTotalSum_06_all + endTeamTotalSum_05_all + endTeamTotalSum_04_all + endTeamTotalSum_03_all + endTeamTotalSum_02_all + endTeamTotalSum_01_all}"></c:set>
	<c:choose>
		<c:when test="${feeColTeamTotalSum_all eq 0 or endColTeamTotalSum_all eq 0}">
			<c:set var="arvColTeamTotalSum_all" value="0"/>
		</c:when>
		<c:otherwise>
			<c:set var="arvColTeamTotalSum_all" value="${feeColTeamTotalSum_all / endColTeamTotalSum_all}"/>
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