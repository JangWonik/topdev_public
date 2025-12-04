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
	            <c:set var="cntFeeCenterSum_12_5" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_11_5" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_10_5" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_09_5" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_08_5" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_07_5" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_06_5" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_05_5" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_04_5" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_03_5" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_02_5" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_01_5" value="0"></c:set>
	            
	            <!-- 센터별 평균 계 초기화 -->
				<c:set var="feeCenterSum_12_5" value="0"></c:set>
				<c:set var="feeCenterSum_11_5" value="0"></c:set>
				<c:set var="feeCenterSum_10_5" value="0"></c:set>
				<c:set var="feeCenterSum_09_5" value="0"></c:set>
				<c:set var="feeCenterSum_08_5" value="0"></c:set>
				<c:set var="feeCenterSum_07_5" value="0"></c:set>
				<c:set var="feeCenterSum_06_5" value="0"></c:set>
				<c:set var="feeCenterSum_05_5" value="0"></c:set>
				<c:set var="feeCenterSum_04_5" value="0"></c:set>
				<c:set var="feeCenterSum_03_5" value="0"></c:set>
				<c:set var="feeCenterSum_02_5" value="0"></c:set>
				<c:set var="feeCenterSum_01_5" value="0"></c:set>
								    
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
	            <c:set var="cntFeeCenterTotalSum_12_5" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_11_5" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_10_5" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_09_5" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_08_5" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_07_5" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_06_5" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_05_5" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_04_5" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_03_5" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_02_5" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_01_5" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntFeeColCenterTotalSum_5" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="feeCenterTotalSum_12_5" value="0"></c:set>
				<c:set var="feeCenterTotalSum_11_5" value="0"></c:set>
				<c:set var="feeCenterTotalSum_10_5" value="0"></c:set>
				<c:set var="feeCenterTotalSum_09_5" value="0"></c:set>
				<c:set var="feeCenterTotalSum_08_5" value="0"></c:set>
				<c:set var="feeCenterTotalSum_07_5" value="0"></c:set>
				<c:set var="feeCenterTotalSum_06_5" value="0"></c:set>
				<c:set var="feeCenterTotalSum_05_5" value="0"></c:set>
				<c:set var="feeCenterTotalSum_04_5" value="0"></c:set>
				<c:set var="feeCenterTotalSum_03_5" value="0"></c:set>
				<c:set var="feeCenterTotalSum_02_5" value="0"></c:set>
				<c:set var="feeCenterTotalSum_01_5" value="0"></c:set>
				
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
   				    			
    			<c:forEach var="vo" items="${ptnrStatCntFeeList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCntFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
		                    	1종 조사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatTeam(${vo.ptnrId},${vo.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo.centerName}</td>
		                		<td style="width:150px;">${vo.ptnrIdSubNm}</td>
		                		<!-- 센터별 계 초기화 -->
					            <c:set var="cntFeeCenterSum_12_5" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_11_5" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_10_5" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_09_5" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_08_5" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_07_5" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_06_5" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_05_5" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_04_5" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_03_5" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_02_5" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_01_5" value="0"></c:set>
					            
					            <!-- 센터별 평균 계 초기화 -->
								<c:set var="feeCenterSum_12_5" value="0"></c:set>
								<c:set var="feeCenterSum_11_5" value="0"></c:set>
								<c:set var="feeCenterSum_10_5" value="0"></c:set>
								<c:set var="feeCenterSum_09_5" value="0"></c:set>
								<c:set var="feeCenterSum_08_5" value="0"></c:set>
								<c:set var="feeCenterSum_07_5" value="0"></c:set>
								<c:set var="feeCenterSum_06_5" value="0"></c:set>
								<c:set var="feeCenterSum_05_5" value="0"></c:set>
								<c:set var="feeCenterSum_04_5" value="0"></c:set>
								<c:set var="feeCenterSum_03_5" value="0"></c:set>
								<c:set var="feeCenterSum_02_5" value="0"></c:set>
								<c:set var="feeCenterSum_01_5" value="0"></c:set>
												    
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
		                
		                <!-- 센터별 계 합산 -->
	    				<c:set var="cntFeeCenterSum_12_5" value="${cntFeeCenterSum_12_5+cntFee12_5}"></c:set>
			            <c:set var="cntFeeCenterSum_11_5" value="${cntFeeCenterSum_11_5+cntFee11_5}"></c:set>
			            <c:set var="cntFeeCenterSum_10_5" value="${cntFeeCenterSum_10_5+cntFee10_5}"></c:set>
			            <c:set var="cntFeeCenterSum_09_5" value="${cntFeeCenterSum_09_5+cntFee09_5}"></c:set>
			            <c:set var="cntFeeCenterSum_08_5" value="${cntFeeCenterSum_08_5+cntFee08_5}"></c:set>
			            <c:set var="cntFeeCenterSum_07_5" value="${cntFeeCenterSum_07_5+cntFee07_5}"></c:set>
			            <c:set var="cntFeeCenterSum_06_5" value="${cntFeeCenterSum_06_5+cntFee06_5}"></c:set>
			            <c:set var="cntFeeCenterSum_05_5" value="${cntFeeCenterSum_05_5+cntFee05_5}"></c:set>
			            <c:set var="cntFeeCenterSum_04_5" value="${cntFeeCenterSum_04_5+cntFee04_5}"></c:set>
			            <c:set var="cntFeeCenterSum_03_5" value="${cntFeeCenterSum_03_5+cntFee03_5}"></c:set>
			            <c:set var="cntFeeCenterSum_02_5" value="${cntFeeCenterSum_02_5+cntFee02_5}"></c:set>
			            <c:set var="cntFeeCenterSum_01_5" value="${cntFeeCenterSum_01_5+cntFee01_5}"></c:set>
			            
			            <!-- 센터별 계 평균용 변수 -->
						<c:set var="feeCenterSum_12_5" value="${feeCenterSum_12_5+fee12_5}"></c:set>
			            <c:set var="feeCenterSum_11_5" value="${feeCenterSum_11_5+fee11_5}"></c:set>
			            <c:set var="feeCenterSum_10_5" value="${feeCenterSum_10_5+fee10_5}"></c:set>
			            <c:set var="feeCenterSum_09_5" value="${feeCenterSum_09_5+fee09_5}"></c:set>
			            <c:set var="feeCenterSum_08_5" value="${feeCenterSum_08_5+fee08_5}"></c:set>
			            <c:set var="feeCenterSum_07_5" value="${feeCenterSum_07_5+fee07_5}"></c:set>
			            <c:set var="feeCenterSum_06_5" value="${feeCenterSum_06_5+fee06_5}"></c:set>
			            <c:set var="feeCenterSum_05_5" value="${feeCenterSum_05_5+fee05_5}"></c:set>
			            <c:set var="feeCenterSum_04_5" value="${feeCenterSum_04_5+fee04_5}"></c:set>
			            <c:set var="feeCenterSum_03_5" value="${feeCenterSum_03_5+fee03_5}"></c:set>
			            <c:set var="feeCenterSum_02_5" value="${feeCenterSum_02_5+fee02_5}"></c:set>
			            <c:set var="feeCenterSum_01_5" value="${feeCenterSum_01_5+fee01_5}"></c:set>
				    
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
	                    <c:set var="cntFeeCenterTotalSum_12_5" value="${cntFeeCenterTotalSum_12_5 + cntFee12_5}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_11_5" value="${cntFeeCenterTotalSum_11_5 + cntFee11_5}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_10_5" value="${cntFeeCenterTotalSum_10_5 + cntFee10_5}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_09_5" value="${cntFeeCenterTotalSum_09_5 + cntFee09_5}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_08_5" value="${cntFeeCenterTotalSum_08_5 + cntFee08_5}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_07_5" value="${cntFeeCenterTotalSum_07_5 + cntFee07_5}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_06_5" value="${cntFeeCenterTotalSum_06_5 + cntFee06_5}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_05_5" value="${cntFeeCenterTotalSum_05_5 + cntFee05_5}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_04_5" value="${cntFeeCenterTotalSum_04_5 + cntFee04_5}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_03_5" value="${cntFeeCenterTotalSum_03_5 + cntFee03_5}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_02_5" value="${cntFeeCenterTotalSum_02_5 + cntFee02_5}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_01_5" value="${cntFeeCenterTotalSum_01_5 + cntFee01_5}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="feeCenterTotalSum_12_5" value="${feeCenterTotalSum_12_5 + fee12_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_11_5" value="${feeCenterTotalSum_11_5 + fee11_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_10_5" value="${feeCenterTotalSum_10_5 + fee10_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_09_5" value="${feeCenterTotalSum_09_5 + fee09_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_08_5" value="${feeCenterTotalSum_08_5 + fee08_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_07_5" value="${feeCenterTotalSum_07_5 + fee07_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_06_5" value="${feeCenterTotalSum_06_5 + fee06_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_05_5" value="${feeCenterTotalSum_05_5 + fee05_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_04_5" value="${feeCenterTotalSum_04_5 + fee04_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_03_5" value="${feeCenterTotalSum_03_5 + fee03_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_02_5" value="${feeCenterTotalSum_02_5 + fee02_5}"></c:set>
	                    <c:set var="feeCenterTotalSum_01_5" value="${feeCenterTotalSum_01_5 + fee01_5}"></c:set>

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
		    					<c:when test="${feeCenterSum_12_5 eq 0 or endCenterSum_12_5 eq 0}">
		    						<c:set var="arvCenterSum_12_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_12_5" value="${feeCenterSum_12_5 / endCenterSum_12_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_11_5 eq 0 or endCenterSum_11_5 eq 0}">
		    						<c:set var="arvCenterSum_11_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_11_5" value="${feeCenterSum_11_5 / endCenterSum_11_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_10_5 eq 0 or endCenterSum_10_5 eq 0}">
		    						<c:set var="arvCenterSum_10_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_10_5" value="${feeCenterSum_10_5 / endCenterSum_10_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_09_5 eq 0 or endCenterSum_09_5 eq 0}">
		    						<c:set var="arvCenterSum_09_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_09_5" value="${feeCenterSum_09_5 / endCenterSum_09_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_08_5 eq 0 or endCenterSum_08_5 eq 0}">
		    						<c:set var="arvCenterSum_08_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_08_5" value="${feeCenterSum_08_5 / endCenterSum_08_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_07_5 eq 0 or endCenterSum_07_5 eq 0}">
		    						<c:set var="arvCenterSum_07_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_07_5" value="${feeCenterSum_07_5 / endCenterSum_07_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_06_5 eq 0 or endCenterSum_06_5 eq 0}">
		    						<c:set var="arvCenterSum_06_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_06_5" value="${feeCenterSum_06_5 / endCenterSum_06_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_05_5 eq 0 or endCenterSum_05_5 eq 0}">
		    						<c:set var="arvCenterSum_05_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_05_5" value="${feeCenterSum_05_5 / endCenterSum_05_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_04_5 eq 0 or endCenterSum_04_5 eq 0}">
		    						<c:set var="arvCenterSum_04_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_04_5" value="${feeCenterSum_04_5 / endCenterSum_04_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_03_5 eq 0 or endCenterSum_03_5 eq 0}">
		    						<c:set var="arvCenterSum_03_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_03_5" value="${feeCenterSum_03_5 / endCenterSum_03_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_02_5 eq 0 or endCenterSum_02_5 eq 0}">
		    						<c:set var="arvCenterSum_02_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_02_5" value="${feeCenterSum_02_5 / endCenterSum_02_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_01_5 eq 0 or endCenterSum_01_5 eq 0}">
		    						<c:set var="arvCenterSum_01_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_01_5" value="${feeCenterSum_01_5 / endCenterSum_01_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 센터별 평균 계산 끝 -->
		    						    				
		    				<!-- cntFee12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_12_5}" pattern="#,##0.##"/></td>
		    				<!-- cntFee11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_11_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_10_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_09_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_08_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_07_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_06_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_05_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_04_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_03_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_02_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_01_5}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="feeCenterColSum_5" value="${feeCenterSum_12_5 + feeCenterSum_11_5 + feeCenterSum_10_5 + feeCenterSum_09_5 + feeCenterSum_08_5 + feeCenterSum_07_5 + feeCenterSum_06_5 + feeCenterSum_05_5 + feeCenterSum_04_5 + feeCenterSum_03_5 + feeCenterSum_02_5 + feeCenterSum_01_5}"></c:set>
			                <c:set var="endCenterColSum_5" value="${endCenterSum_12_5 + endCenterSum_11_5 + endCenterSum_10_5 + endCenterSum_09_5 + endCenterSum_08_5 + endCenterSum_07_5 + endCenterSum_06_5 + endCenterSum_05_5 + endCenterSum_04_5 + endCenterSum_03_5 + endCenterSum_02_5 + endCenterSum_01_5}"></c:set>			                
			                <c:choose>
			                	<c:when test="${feeCenterColSum_5 eq 0 or endCenterColSum_5 eq 0}">
			                		<c:set var="arvCenterColSum_5" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvCenterColSum_5" value="${feeCenterColSum_5 / endCenterColSum_5}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterColSum_5}" pattern="#,##0.##"/></td>
		    				
							<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>										                		    				
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="cntFeeCenterSum_12_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_11_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_10_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_09_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_08_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_07_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_06_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_05_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_04_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_03_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_02_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_01_5" value="0"></c:set>
				            
				            <!-- 센터별 평균 계 초기화 -->
							<c:set var="feeCenterSum_12_5" value="0"></c:set>
							<c:set var="feeCenterSum_11_5" value="0"></c:set>
							<c:set var="feeCenterSum_10_5" value="0"></c:set>
							<c:set var="feeCenterSum_09_5" value="0"></c:set>
							<c:set var="feeCenterSum_08_5" value="0"></c:set>
							<c:set var="feeCenterSum_07_5" value="0"></c:set>
							<c:set var="feeCenterSum_06_5" value="0"></c:set>
							<c:set var="feeCenterSum_05_5" value="0"></c:set>
							<c:set var="feeCenterSum_04_5" value="0"></c:set>
							<c:set var="feeCenterSum_03_5" value="0"></c:set>
							<c:set var="feeCenterSum_02_5" value="0"></c:set>
							<c:set var="feeCenterSum_01_5" value="0"></c:set>
											    
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
				            <c:set var="cntFeeCenterSum_12_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_11_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_10_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_09_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_08_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_07_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_06_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_05_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_04_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_03_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_02_5" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_01_5" value="0"></c:set>
				            
				            <!-- 센터별 평균 계 초기화 -->
							<c:set var="feeCenterSum_12_5" value="0"></c:set>
							<c:set var="feeCenterSum_11_5" value="0"></c:set>
							<c:set var="feeCenterSum_10_5" value="0"></c:set>
							<c:set var="feeCenterSum_09_5" value="0"></c:set>
							<c:set var="feeCenterSum_08_5" value="0"></c:set>
							<c:set var="feeCenterSum_07_5" value="0"></c:set>
							<c:set var="feeCenterSum_06_5" value="0"></c:set>
							<c:set var="feeCenterSum_05_5" value="0"></c:set>
							<c:set var="feeCenterSum_04_5" value="0"></c:set>
							<c:set var="feeCenterSum_03_5" value="0"></c:set>
							<c:set var="feeCenterSum_02_5" value="0"></c:set>
							<c:set var="feeCenterSum_01_5" value="0"></c:set>
											    
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
		    	<c:if test="${ptnrStatCntFeeList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 조사 평균</th>
	                <c:choose>
    					<c:when test="${feeCenterTotalSum_12_5 eq 0 or endCenterTotalSum_12_5 eq 0}">
    						<c:set var="arvCenterTotalSum_12_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_12_5" value="${feeCenterTotalSum_12_5 / endCenterTotalSum_12_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_11_5 eq 0 or endCenterTotalSum_11_5 eq 0}">
    						<c:set var="arvCenterTotalSum_11_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_11_5" value="${feeCenterTotalSum_11_5 / endCenterTotalSum_11_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_10_5 eq 0 or endCenterTotalSum_10_5 eq 0}">
    						<c:set var="arvCenterTotalSum_10_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_10_5" value="${feeCenterTotalSum_10_5 / endCenterTotalSum_10_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_09_5 eq 0 or endCenterTotalSum_09_5 eq 0}">
    						<c:set var="arvCenterTotalSum_09_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_09_5" value="${feeCenterTotalSum_09_5 / endCenterTotalSum_09_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_08_5 eq 0 or endCenterTotalSum_08_5 eq 0}">
    						<c:set var="arvCenterTotalSum_08_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_08_5" value="${feeCenterTotalSum_08_5 / endCenterTotalSum_08_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_07_5 eq 0 or endCenterTotalSum_07_5 eq 0}">
    						<c:set var="arvCenterTotalSum_07_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_07_5" value="${feeCenterTotalSum_07_5 / endCenterTotalSum_07_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_06_5 eq 0 or endCenterTotalSum_06_5 eq 0}">
    						<c:set var="arvCenterTotalSum_06_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_06_5" value="${feeCenterTotalSum_06_5 / endCenterTotalSum_06_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_05_5 eq 0 or endCenterTotalSum_05_5 eq 0}">
    						<c:set var="arvCenterTotalSum_05_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_05_5" value="${feeCenterTotalSum_05_5 / endCenterTotalSum_05_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_04_5 eq 0 or endCenterTotalSum_04_5 eq 0}">
    						<c:set var="arvCenterTotalSum_04_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_04_5" value="${feeCenterTotalSum_04_5 / endCenterTotalSum_04_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_03_5 eq 0 or endCenterTotalSum_03_5 eq 0}">
    						<c:set var="arvCenterTotalSum_03_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_03_5" value="${feeCenterTotalSum_03_5 / endCenterTotalSum_03_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_02_5 eq 0 or endCenterTotalSum_02_5 eq 0}">
    						<c:set var="arvCenterTotalSum_02_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_02_5" value="${feeCenterTotalSum_02_5 / endCenterTotalSum_02_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_01_5 eq 0 or endCenterTotalSum_01_5 eq 0}">
    						<c:set var="arvCenterTotalSum_01_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_01_5" value="${feeCenterTotalSum_01_5 / endCenterTotalSum_01_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 센터별 평균 계산 끝 -->
    						    				
    				<!-- cntFee12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_12_5}" pattern="#,##0.##"/></th>
    				<!-- cntFee11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_11_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_10_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_09_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_08_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_07_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_06_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_05_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_04_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_03_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_02_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_01_5}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="feeColCenterTotalSum_5" value="${feeCenterTotalSum_12_5 + feeCenterTotalSum_11_5 + feeCenterTotalSum_10_5 + feeCenterTotalSum_09_5 + feeCenterTotalSum_08_5 + feeCenterTotalSum_07_5 + feeCenterTotalSum_06_5 + feeCenterTotalSum_05_5 + feeCenterTotalSum_04_5 + feeCenterTotalSum_03_5 + feeCenterTotalSum_02_5 + feeCenterTotalSum_01_5}"></c:set>
	                <c:set var="endColCenterTotalSum_5" value="${endCenterTotalSum_12_5 + endCenterTotalSum_11_5 + endCenterTotalSum_10_5 + endCenterTotalSum_09_5 + endCenterTotalSum_08_5 + endCenterTotalSum_07_5 + endCenterTotalSum_06_5 + endCenterTotalSum_05_5 + endCenterTotalSum_04_5 + endCenterTotalSum_03_5 + endCenterTotalSum_02_5 + endCenterTotalSum_01_5}"></c:set>
					<c:choose>
	                	<c:when test="${feeColCenterTotalSum_5 eq 0 or endColCenterTotalSum_5 eq 0}">
	                		<c:set var="arvColCenterTotalSum_5" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColCenterTotalSum_5" value="${feeColCenterTotalSum_5 / endColCenterTotalSum_5}"/>
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
	            <c:set var="cntFeeCenterSum_12_10" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_11_10" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_10_10" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_09_10" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_08_10" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_07_10" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_06_10" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_05_10" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_04_10" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_03_10" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_02_10" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_01_10" value="0"></c:set>
	            
	            <!-- 센터별 평균 계 초기화 -->
				<c:set var="feeCenterSum_12_10" value="0"></c:set>
				<c:set var="feeCenterSum_11_10" value="0"></c:set>
				<c:set var="feeCenterSum_10_10" value="0"></c:set>
				<c:set var="feeCenterSum_09_10" value="0"></c:set>
				<c:set var="feeCenterSum_08_10" value="0"></c:set>
				<c:set var="feeCenterSum_07_10" value="0"></c:set>
				<c:set var="feeCenterSum_06_10" value="0"></c:set>
				<c:set var="feeCenterSum_05_10" value="0"></c:set>
				<c:set var="feeCenterSum_04_10" value="0"></c:set>
				<c:set var="feeCenterSum_03_10" value="0"></c:set>
				<c:set var="feeCenterSum_02_10" value="0"></c:set>
				<c:set var="feeCenterSum_01_10" value="0"></c:set>
								    
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
	            <c:set var="cntFeeCenterTotalSum_12_10" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_11_10" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_10_10" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_09_10" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_08_10" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_07_10" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_06_10" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_05_10" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_04_10" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_03_10" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_02_10" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_01_10" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntFeeColCenterTotalSum_10" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="feeCenterTotalSum_12_10" value="0"></c:set>
				<c:set var="feeCenterTotalSum_11_10" value="0"></c:set>
				<c:set var="feeCenterTotalSum_10_10" value="0"></c:set>
				<c:set var="feeCenterTotalSum_09_10" value="0"></c:set>
				<c:set var="feeCenterTotalSum_08_10" value="0"></c:set>
				<c:set var="feeCenterTotalSum_07_10" value="0"></c:set>
				<c:set var="feeCenterTotalSum_06_10" value="0"></c:set>
				<c:set var="feeCenterTotalSum_05_10" value="0"></c:set>
				<c:set var="feeCenterTotalSum_04_10" value="0"></c:set>
				<c:set var="feeCenterTotalSum_03_10" value="0"></c:set>
				<c:set var="feeCenterTotalSum_02_10" value="0"></c:set>
				<c:set var="feeCenterTotalSum_01_10" value="0"></c:set>
				
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
   				    			
    			<c:forEach var="vo1" items="${ptnrStatCntFeeList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCntFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
		                    	1종 심사
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo1.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatTeam(${vo1.ptnrId},${vo1.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo1.centerName}</td>
		                		<td style="width:150px;">${vo1.ptnrIdSubNm}</td>
		                		<!-- 센터별 계 초기화 -->
					            <c:set var="cntFeeCenterSum_12_10" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_11_10" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_10_10" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_09_10" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_08_10" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_07_10" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_06_10" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_05_10" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_04_10" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_03_10" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_02_10" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_01_10" value="0"></c:set>
					            
					            <!-- 센터별 평균 계 초기화 -->
								<c:set var="feeCenterSum_12_10" value="0"></c:set>
								<c:set var="feeCenterSum_11_10" value="0"></c:set>
								<c:set var="feeCenterSum_10_10" value="0"></c:set>
								<c:set var="feeCenterSum_09_10" value="0"></c:set>
								<c:set var="feeCenterSum_08_10" value="0"></c:set>
								<c:set var="feeCenterSum_07_10" value="0"></c:set>
								<c:set var="feeCenterSum_06_10" value="0"></c:set>
								<c:set var="feeCenterSum_05_10" value="0"></c:set>
								<c:set var="feeCenterSum_04_10" value="0"></c:set>
								<c:set var="feeCenterSum_03_10" value="0"></c:set>
								<c:set var="feeCenterSum_02_10" value="0"></c:set>
								<c:set var="feeCenterSum_01_10" value="0"></c:set>
												    
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
		                
		                <!-- 센터별 계 합산 -->
	    				<c:set var="cntFeeCenterSum_12_10" value="${cntFeeCenterSum_12_10+cntFee12_10}"></c:set>
			            <c:set var="cntFeeCenterSum_11_10" value="${cntFeeCenterSum_11_10+cntFee11_10}"></c:set>
			            <c:set var="cntFeeCenterSum_10_10" value="${cntFeeCenterSum_10_10+cntFee10_10}"></c:set>
			            <c:set var="cntFeeCenterSum_09_10" value="${cntFeeCenterSum_09_10+cntFee09_10}"></c:set>
			            <c:set var="cntFeeCenterSum_08_10" value="${cntFeeCenterSum_08_10+cntFee08_10}"></c:set>
			            <c:set var="cntFeeCenterSum_07_10" value="${cntFeeCenterSum_07_10+cntFee07_10}"></c:set>
			            <c:set var="cntFeeCenterSum_06_10" value="${cntFeeCenterSum_06_10+cntFee06_10}"></c:set>
			            <c:set var="cntFeeCenterSum_05_10" value="${cntFeeCenterSum_05_10+cntFee05_10}"></c:set>
			            <c:set var="cntFeeCenterSum_04_10" value="${cntFeeCenterSum_04_10+cntFee04_10}"></c:set>
			            <c:set var="cntFeeCenterSum_03_10" value="${cntFeeCenterSum_03_10+cntFee03_10}"></c:set>
			            <c:set var="cntFeeCenterSum_02_10" value="${cntFeeCenterSum_02_10+cntFee02_10}"></c:set>
			            <c:set var="cntFeeCenterSum_01_10" value="${cntFeeCenterSum_01_10+cntFee01_10}"></c:set>
			            
			            <!-- 센터별 계 평균용 변수 -->
						<c:set var="feeCenterSum_12_10" value="${feeCenterSum_12_10+fee12_10}"></c:set>
			            <c:set var="feeCenterSum_11_10" value="${feeCenterSum_11_10+fee11_10}"></c:set>
			            <c:set var="feeCenterSum_10_10" value="${feeCenterSum_10_10+fee10_10}"></c:set>
			            <c:set var="feeCenterSum_09_10" value="${feeCenterSum_09_10+fee09_10}"></c:set>
			            <c:set var="feeCenterSum_08_10" value="${feeCenterSum_08_10+fee08_10}"></c:set>
			            <c:set var="feeCenterSum_07_10" value="${feeCenterSum_07_10+fee07_10}"></c:set>
			            <c:set var="feeCenterSum_06_10" value="${feeCenterSum_06_10+fee06_10}"></c:set>
			            <c:set var="feeCenterSum_05_10" value="${feeCenterSum_05_10+fee05_10}"></c:set>
			            <c:set var="feeCenterSum_04_10" value="${feeCenterSum_04_10+fee04_10}"></c:set>
			            <c:set var="feeCenterSum_03_10" value="${feeCenterSum_03_10+fee03_10}"></c:set>
			            <c:set var="feeCenterSum_02_10" value="${feeCenterSum_02_10+fee02_10}"></c:set>
			            <c:set var="feeCenterSum_01_10" value="${feeCenterSum_01_10+fee01_10}"></c:set>
				    
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
	                    <c:set var="cntFeeCenterTotalSum_12_10" value="${cntFeeCenterTotalSum_12_10 + cntFee12_10}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_11_10" value="${cntFeeCenterTotalSum_11_10 + cntFee11_10}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_10_10" value="${cntFeeCenterTotalSum_10_10 + cntFee10_10}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_09_10" value="${cntFeeCenterTotalSum_09_10 + cntFee09_10}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_08_10" value="${cntFeeCenterTotalSum_08_10 + cntFee08_10}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_07_10" value="${cntFeeCenterTotalSum_07_10 + cntFee07_10}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_06_10" value="${cntFeeCenterTotalSum_06_10 + cntFee06_10}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_05_10" value="${cntFeeCenterTotalSum_05_10 + cntFee05_10}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_04_10" value="${cntFeeCenterTotalSum_04_10 + cntFee04_10}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_03_10" value="${cntFeeCenterTotalSum_03_10 + cntFee03_10}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_02_10" value="${cntFeeCenterTotalSum_02_10 + cntFee02_10}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_01_10" value="${cntFeeCenterTotalSum_01_10 + cntFee01_10}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="feeCenterTotalSum_12_10" value="${feeCenterTotalSum_12_10 + fee12_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_11_10" value="${feeCenterTotalSum_11_10 + fee11_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_10_10" value="${feeCenterTotalSum_10_10 + fee10_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_09_10" value="${feeCenterTotalSum_09_10 + fee09_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_08_10" value="${feeCenterTotalSum_08_10 + fee08_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_07_10" value="${feeCenterTotalSum_07_10 + fee07_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_06_10" value="${feeCenterTotalSum_06_10 + fee06_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_05_10" value="${feeCenterTotalSum_05_10 + fee05_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_04_10" value="${feeCenterTotalSum_04_10 + fee04_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_03_10" value="${feeCenterTotalSum_03_10 + fee03_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_02_10" value="${feeCenterTotalSum_02_10 + fee02_10}"></c:set>
	                    <c:set var="feeCenterTotalSum_01_10" value="${feeCenterTotalSum_01_10 + fee01_10}"></c:set>

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
		    					<c:when test="${feeCenterSum_12_10 eq 0 or endCenterSum_12_10 eq 0}">
		    						<c:set var="arvCenterSum_12_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_12_10" value="${feeCenterSum_12_10 / endCenterSum_12_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_11_10 eq 0 or endCenterSum_11_10 eq 0}">
		    						<c:set var="arvCenterSum_11_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_11_10" value="${feeCenterSum_11_10 / endCenterSum_11_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_10_10 eq 0 or endCenterSum_10_10 eq 0}">
		    						<c:set var="arvCenterSum_10_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_10_10" value="${feeCenterSum_10_10 / endCenterSum_10_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_09_10 eq 0 or endCenterSum_09_10 eq 0}">
		    						<c:set var="arvCenterSum_09_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_09_10" value="${feeCenterSum_09_10 / endCenterSum_09_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_08_10 eq 0 or endCenterSum_08_10 eq 0}">
		    						<c:set var="arvCenterSum_08_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_08_10" value="${feeCenterSum_08_10 / endCenterSum_08_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_07_10 eq 0 or endCenterSum_07_10 eq 0}">
		    						<c:set var="arvCenterSum_07_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_07_10" value="${feeCenterSum_07_10 / endCenterSum_07_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_06_10 eq 0 or endCenterSum_06_10 eq 0}">
		    						<c:set var="arvCenterSum_06_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_06_10" value="${feeCenterSum_06_10 / endCenterSum_06_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_05_10 eq 0 or endCenterSum_05_10 eq 0}">
		    						<c:set var="arvCenterSum_05_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_05_10" value="${feeCenterSum_05_10 / endCenterSum_05_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_04_10 eq 0 or endCenterSum_04_10 eq 0}">
		    						<c:set var="arvCenterSum_04_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_04_10" value="${feeCenterSum_04_10 / endCenterSum_04_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_03_10 eq 0 or endCenterSum_03_10 eq 0}">
		    						<c:set var="arvCenterSum_03_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_03_10" value="${feeCenterSum_03_10 / endCenterSum_03_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_02_10 eq 0 or endCenterSum_02_10 eq 0}">
		    						<c:set var="arvCenterSum_02_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_02_10" value="${feeCenterSum_02_10 / endCenterSum_02_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_01_10 eq 0 or endCenterSum_01_10 eq 0}">
		    						<c:set var="arvCenterSum_01_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_01_10" value="${feeCenterSum_01_10 / endCenterSum_01_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 센터별 평균 계산 끝 -->
		    						    				
		    				<!-- cntFee12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_12_10}" pattern="#,##0.##"/></td>
		    				<!-- cntFee11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_11_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_10_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_09_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_08_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_07_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_06_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_05_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_04_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_03_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_02_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_01_10}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="feeCenterColSum_10" value="${feeCenterSum_12_10 + feeCenterSum_11_10 + feeCenterSum_10_10 + feeCenterSum_09_10 + feeCenterSum_08_10 + feeCenterSum_07_10 + feeCenterSum_06_10 + feeCenterSum_05_10 + feeCenterSum_04_10 + feeCenterSum_03_10 + feeCenterSum_02_10 + feeCenterSum_01_10}"></c:set>
			                <c:set var="endCenterColSum_10" value="${endCenterSum_12_10 + endCenterSum_11_10 + endCenterSum_10_10 + endCenterSum_09_10 + endCenterSum_08_10 + endCenterSum_07_10 + endCenterSum_06_10 + endCenterSum_05_10 + endCenterSum_04_10 + endCenterSum_03_10 + endCenterSum_02_10 + endCenterSum_01_10}"></c:set>			                
			                <c:choose>
			                	<c:when test="${feeCenterColSum_10 eq 0 or endCenterColSum_10 eq 0}">
			                		<c:set var="arvCenterColSum_10" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvCenterColSum_10" value="${feeCenterColSum_10 / endCenterColSum_10}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterColSum_10}" pattern="#,##0.##"/></td>
		    				
							<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>										                		    				
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="cntFeeCenterSum_12_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_11_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_10_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_09_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_08_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_07_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_06_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_05_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_04_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_03_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_02_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_01_10" value="0"></c:set>
				            
				            <!-- 센터별 평균 계 초기화 -->
							<c:set var="feeCenterSum_12_10" value="0"></c:set>
							<c:set var="feeCenterSum_11_10" value="0"></c:set>
							<c:set var="feeCenterSum_10_10" value="0"></c:set>
							<c:set var="feeCenterSum_09_10" value="0"></c:set>
							<c:set var="feeCenterSum_08_10" value="0"></c:set>
							<c:set var="feeCenterSum_07_10" value="0"></c:set>
							<c:set var="feeCenterSum_06_10" value="0"></c:set>
							<c:set var="feeCenterSum_05_10" value="0"></c:set>
							<c:set var="feeCenterSum_04_10" value="0"></c:set>
							<c:set var="feeCenterSum_03_10" value="0"></c:set>
							<c:set var="feeCenterSum_02_10" value="0"></c:set>
							<c:set var="feeCenterSum_01_10" value="0"></c:set>
											    
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
				            <c:set var="cntFeeCenterSum_12_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_11_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_10_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_09_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_08_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_07_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_06_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_05_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_04_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_03_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_02_10" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_01_10" value="0"></c:set>
				            
				            <!-- 센터별 평균 계 초기화 -->
							<c:set var="feeCenterSum_12_10" value="0"></c:set>
							<c:set var="feeCenterSum_11_10" value="0"></c:set>
							<c:set var="feeCenterSum_10_10" value="0"></c:set>
							<c:set var="feeCenterSum_09_10" value="0"></c:set>
							<c:set var="feeCenterSum_08_10" value="0"></c:set>
							<c:set var="feeCenterSum_07_10" value="0"></c:set>
							<c:set var="feeCenterSum_06_10" value="0"></c:set>
							<c:set var="feeCenterSum_05_10" value="0"></c:set>
							<c:set var="feeCenterSum_04_10" value="0"></c:set>
							<c:set var="feeCenterSum_03_10" value="0"></c:set>
							<c:set var="feeCenterSum_02_10" value="0"></c:set>
							<c:set var="feeCenterSum_01_10" value="0"></c:set>
											    
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
		    	<c:if test="${ptnrStatCntFeeList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 심사 평균</th>
	                <c:choose>
    					<c:when test="${feeCenterTotalSum_12_10 eq 0 or endCenterTotalSum_12_10 eq 0}">
    						<c:set var="arvCenterTotalSum_12_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_12_10" value="${feeCenterTotalSum_12_10 / endCenterTotalSum_12_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_11_10 eq 0 or endCenterTotalSum_11_10 eq 0}">
    						<c:set var="arvCenterTotalSum_11_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_11_10" value="${feeCenterTotalSum_11_10 / endCenterTotalSum_11_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_10_10 eq 0 or endCenterTotalSum_10_10 eq 0}">
    						<c:set var="arvCenterTotalSum_10_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_10_10" value="${feeCenterTotalSum_10_10 / endCenterTotalSum_10_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_09_10 eq 0 or endCenterTotalSum_09_10 eq 0}">
    						<c:set var="arvCenterTotalSum_09_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_09_10" value="${feeCenterTotalSum_09_10 / endCenterTotalSum_09_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_08_10 eq 0 or endCenterTotalSum_08_10 eq 0}">
    						<c:set var="arvCenterTotalSum_08_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_08_10" value="${feeCenterTotalSum_08_10 / endCenterTotalSum_08_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_07_10 eq 0 or endCenterTotalSum_07_10 eq 0}">
    						<c:set var="arvCenterTotalSum_07_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_07_10" value="${feeCenterTotalSum_07_10 / endCenterTotalSum_07_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_06_10 eq 0 or endCenterTotalSum_06_10 eq 0}">
    						<c:set var="arvCenterTotalSum_06_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_06_10" value="${feeCenterTotalSum_06_10 / endCenterTotalSum_06_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_05_10 eq 0 or endCenterTotalSum_05_10 eq 0}">
    						<c:set var="arvCenterTotalSum_05_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_05_10" value="${feeCenterTotalSum_05_10 / endCenterTotalSum_05_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_04_10 eq 0 or endCenterTotalSum_04_10 eq 0}">
    						<c:set var="arvCenterTotalSum_04_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_04_10" value="${feeCenterTotalSum_04_10 / endCenterTotalSum_04_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_03_10 eq 0 or endCenterTotalSum_03_10 eq 0}">
    						<c:set var="arvCenterTotalSum_03_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_03_10" value="${feeCenterTotalSum_03_10 / endCenterTotalSum_03_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_02_10 eq 0 or endCenterTotalSum_02_10 eq 0}">
    						<c:set var="arvCenterTotalSum_02_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_02_10" value="${feeCenterTotalSum_02_10 / endCenterTotalSum_02_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_01_10 eq 0 or endCenterTotalSum_01_10 eq 0}">
    						<c:set var="arvCenterTotalSum_01_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_01_10" value="${feeCenterTotalSum_01_10 / endCenterTotalSum_01_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 센터별 평균 계산 끝 -->
    						    				
    				<!-- cntFee12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_12_10}" pattern="#,##0.##"/></th>
    				<!-- cntFee11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_11_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_10_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_09_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_08_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_07_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_06_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_05_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_04_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_03_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_02_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_01_10}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="feeColCenterTotalSum_10" value="${feeCenterTotalSum_12_10 + feeCenterTotalSum_11_10 + feeCenterTotalSum_10_10 + feeCenterTotalSum_09_10 + feeCenterTotalSum_08_10 + feeCenterTotalSum_07_10 + feeCenterTotalSum_06_10 + feeCenterTotalSum_05_10 + feeCenterTotalSum_04_10 + feeCenterTotalSum_03_10 + feeCenterTotalSum_02_10 + feeCenterTotalSum_01_10}"></c:set>
	                <c:set var="endColCenterTotalSum_10" value="${endCenterTotalSum_12_10 + endCenterTotalSum_11_10 + endCenterTotalSum_10_10 + endCenterTotalSum_09_10 + endCenterTotalSum_08_10 + endCenterTotalSum_07_10 + endCenterTotalSum_06_10 + endCenterTotalSum_05_10 + endCenterTotalSum_04_10 + endCenterTotalSum_03_10 + endCenterTotalSum_02_10 + endCenterTotalSum_01_10}"></c:set>
					<c:choose>
	                	<c:when test="${feeColCenterTotalSum_10 eq 0 or endColCenterTotalSum_10 eq 0}">
	                		<c:set var="arvColCenterTotalSum_10" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColCenterTotalSum_10" value="${feeColCenterTotalSum_10 / endColCenterTotalSum_10}"/>
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
	            <c:set var="cntFeeCenterSum_12_15" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_11_15" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_10_15" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_09_15" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_08_15" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_07_15" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_06_15" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_05_15" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_04_15" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_03_15" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_02_15" value="0"></c:set>
	            <c:set var="cntFeeCenterSum_01_15" value="0"></c:set>
	            
	            <!-- 센터별 평균 계 초기화 -->
				<c:set var="feeCenterSum_12_15" value="0"></c:set>
				<c:set var="feeCenterSum_11_15" value="0"></c:set>
				<c:set var="feeCenterSum_10_15" value="0"></c:set>
				<c:set var="feeCenterSum_09_15" value="0"></c:set>
				<c:set var="feeCenterSum_08_15" value="0"></c:set>
				<c:set var="feeCenterSum_07_15" value="0"></c:set>
				<c:set var="feeCenterSum_06_15" value="0"></c:set>
				<c:set var="feeCenterSum_05_15" value="0"></c:set>
				<c:set var="feeCenterSum_04_15" value="0"></c:set>
				<c:set var="feeCenterSum_03_15" value="0"></c:set>
				<c:set var="feeCenterSum_02_15" value="0"></c:set>
				<c:set var="feeCenterSum_01_15" value="0"></c:set>
								    
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
	            <c:set var="cntFeeCenterTotalSum_12_15" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_11_15" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_10_15" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_09_15" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_08_15" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_07_15" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_06_15" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_05_15" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_04_15" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_03_15" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_02_15" value="0"></c:set>
	            <c:set var="cntFeeCenterTotalSum_01_15" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntFeeColCenterTotalSum_15" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="feeCenterTotalSum_12_15" value="0"></c:set>
				<c:set var="feeCenterTotalSum_11_15" value="0"></c:set>
				<c:set var="feeCenterTotalSum_10_15" value="0"></c:set>
				<c:set var="feeCenterTotalSum_09_15" value="0"></c:set>
				<c:set var="feeCenterTotalSum_08_15" value="0"></c:set>
				<c:set var="feeCenterTotalSum_07_15" value="0"></c:set>
				<c:set var="feeCenterTotalSum_06_15" value="0"></c:set>
				<c:set var="feeCenterTotalSum_05_15" value="0"></c:set>
				<c:set var="feeCenterTotalSum_04_15" value="0"></c:set>
				<c:set var="feeCenterTotalSum_03_15" value="0"></c:set>
				<c:set var="feeCenterTotalSum_02_15" value="0"></c:set>
				<c:set var="feeCenterTotalSum_01_15" value="0"></c:set>
				
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
   				    			
    			<c:forEach var="vo2" items="${ptnrStatCntFeeList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <td onclick="goPtnrStatMenu('ptnrStatCntFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
		                    	1종 기타
		                    </td>
		                </c:if>
		                <c:choose>
		                	<c:when test="${vo2.rowCnt == 1}">		                				                		
		                		<td onclick="goPtnrStatTeam(${vo2.ptnrId},${vo2.teamCenter});" style="width:150px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">${vo2.centerName}</td>
		                		<td style="width:150px;">${vo2.ptnrIdSubNm}</td>
		                		<!-- 센터별 계 초기화 -->
					            <c:set var="cntFeeCenterSum_12_15" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_11_15" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_10_15" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_09_15" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_08_15" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_07_15" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_06_15" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_05_15" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_04_15" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_03_15" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_02_15" value="0"></c:set>
					            <c:set var="cntFeeCenterSum_01_15" value="0"></c:set>
					            
					            <!-- 센터별 평균 계 초기화 -->
								<c:set var="feeCenterSum_12_15" value="0"></c:set>
								<c:set var="feeCenterSum_11_15" value="0"></c:set>
								<c:set var="feeCenterSum_10_15" value="0"></c:set>
								<c:set var="feeCenterSum_09_15" value="0"></c:set>
								<c:set var="feeCenterSum_08_15" value="0"></c:set>
								<c:set var="feeCenterSum_07_15" value="0"></c:set>
								<c:set var="feeCenterSum_06_15" value="0"></c:set>
								<c:set var="feeCenterSum_05_15" value="0"></c:set>
								<c:set var="feeCenterSum_04_15" value="0"></c:set>
								<c:set var="feeCenterSum_03_15" value="0"></c:set>
								<c:set var="feeCenterSum_02_15" value="0"></c:set>
								<c:set var="feeCenterSum_01_15" value="0"></c:set>
												    
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
		                
		                <!-- 센터별 계 합산 -->
	    				<c:set var="cntFeeCenterSum_12_15" value="${cntFeeCenterSum_12_15+cntFee12_15}"></c:set>
			            <c:set var="cntFeeCenterSum_11_15" value="${cntFeeCenterSum_11_15+cntFee11_15}"></c:set>
			            <c:set var="cntFeeCenterSum_10_15" value="${cntFeeCenterSum_10_15+cntFee10_15}"></c:set>
			            <c:set var="cntFeeCenterSum_09_15" value="${cntFeeCenterSum_09_15+cntFee09_15}"></c:set>
			            <c:set var="cntFeeCenterSum_08_15" value="${cntFeeCenterSum_08_15+cntFee08_15}"></c:set>
			            <c:set var="cntFeeCenterSum_07_15" value="${cntFeeCenterSum_07_15+cntFee07_15}"></c:set>
			            <c:set var="cntFeeCenterSum_06_15" value="${cntFeeCenterSum_06_15+cntFee06_15}"></c:set>
			            <c:set var="cntFeeCenterSum_05_15" value="${cntFeeCenterSum_05_15+cntFee05_15}"></c:set>
			            <c:set var="cntFeeCenterSum_04_15" value="${cntFeeCenterSum_04_15+cntFee04_15}"></c:set>
			            <c:set var="cntFeeCenterSum_03_15" value="${cntFeeCenterSum_03_15+cntFee03_15}"></c:set>
			            <c:set var="cntFeeCenterSum_02_15" value="${cntFeeCenterSum_02_15+cntFee02_15}"></c:set>
			            <c:set var="cntFeeCenterSum_01_15" value="${cntFeeCenterSum_01_15+cntFee01_15}"></c:set>
			            
			            <!-- 센터별 계 평균용 변수 -->
						<c:set var="feeCenterSum_12_15" value="${feeCenterSum_12_15+fee12_15}"></c:set>
			            <c:set var="feeCenterSum_11_15" value="${feeCenterSum_11_15+fee11_15}"></c:set>
			            <c:set var="feeCenterSum_10_15" value="${feeCenterSum_10_15+fee10_15}"></c:set>
			            <c:set var="feeCenterSum_09_15" value="${feeCenterSum_09_15+fee09_15}"></c:set>
			            <c:set var="feeCenterSum_08_15" value="${feeCenterSum_08_15+fee08_15}"></c:set>
			            <c:set var="feeCenterSum_07_15" value="${feeCenterSum_07_15+fee07_15}"></c:set>
			            <c:set var="feeCenterSum_06_15" value="${feeCenterSum_06_15+fee06_15}"></c:set>
			            <c:set var="feeCenterSum_05_15" value="${feeCenterSum_05_15+fee05_15}"></c:set>
			            <c:set var="feeCenterSum_04_15" value="${feeCenterSum_04_15+fee04_15}"></c:set>
			            <c:set var="feeCenterSum_03_15" value="${feeCenterSum_03_15+fee03_15}"></c:set>
			            <c:set var="feeCenterSum_02_15" value="${feeCenterSum_02_15+fee02_15}"></c:set>
			            <c:set var="feeCenterSum_01_15" value="${feeCenterSum_01_15+fee01_15}"></c:set>
				    
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
	                    <c:set var="cntFeeCenterTotalSum_12_15" value="${cntFeeCenterTotalSum_12_15 + cntFee12_15}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_11_15" value="${cntFeeCenterTotalSum_11_15 + cntFee11_15}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_10_15" value="${cntFeeCenterTotalSum_10_15 + cntFee10_15}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_09_15" value="${cntFeeCenterTotalSum_09_15 + cntFee09_15}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_08_15" value="${cntFeeCenterTotalSum_08_15 + cntFee08_15}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_07_15" value="${cntFeeCenterTotalSum_07_15 + cntFee07_15}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_06_15" value="${cntFeeCenterTotalSum_06_15 + cntFee06_15}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_05_15" value="${cntFeeCenterTotalSum_05_15 + cntFee05_15}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_04_15" value="${cntFeeCenterTotalSum_04_15 + cntFee04_15}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_03_15" value="${cntFeeCenterTotalSum_03_15 + cntFee03_15}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_02_15" value="${cntFeeCenterTotalSum_02_15 + cntFee02_15}"></c:set>
	                    <c:set var="cntFeeCenterTotalSum_01_15" value="${cntFeeCenterTotalSum_01_15 + cntFee01_15}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="feeCenterTotalSum_12_15" value="${feeCenterTotalSum_12_15 + fee12_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_11_15" value="${feeCenterTotalSum_11_15 + fee11_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_10_15" value="${feeCenterTotalSum_10_15 + fee10_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_09_15" value="${feeCenterTotalSum_09_15 + fee09_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_08_15" value="${feeCenterTotalSum_08_15 + fee08_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_07_15" value="${feeCenterTotalSum_07_15 + fee07_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_06_15" value="${feeCenterTotalSum_06_15 + fee06_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_05_15" value="${feeCenterTotalSum_05_15 + fee05_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_04_15" value="${feeCenterTotalSum_04_15 + fee04_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_03_15" value="${feeCenterTotalSum_03_15 + fee03_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_02_15" value="${feeCenterTotalSum_02_15 + fee02_15}"></c:set>
	                    <c:set var="feeCenterTotalSum_01_15" value="${feeCenterTotalSum_01_15 + fee01_15}"></c:set>

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
		    					<c:when test="${feeCenterSum_12_15 eq 0 or endCenterSum_12_15 eq 0}">
		    						<c:set var="arvCenterSum_12_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_12_15" value="${feeCenterSum_12_15 / endCenterSum_12_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_11_15 eq 0 or endCenterSum_11_15 eq 0}">
		    						<c:set var="arvCenterSum_11_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_11_15" value="${feeCenterSum_11_15 / endCenterSum_11_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_10_15 eq 0 or endCenterSum_10_15 eq 0}">
		    						<c:set var="arvCenterSum_10_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_10_15" value="${feeCenterSum_10_15 / endCenterSum_10_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_09_15 eq 0 or endCenterSum_09_15 eq 0}">
		    						<c:set var="arvCenterSum_09_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_09_15" value="${feeCenterSum_09_15 / endCenterSum_09_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_08_15 eq 0 or endCenterSum_08_15 eq 0}">
		    						<c:set var="arvCenterSum_08_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_08_15" value="${feeCenterSum_08_15 / endCenterSum_08_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_07_15 eq 0 or endCenterSum_07_15 eq 0}">
		    						<c:set var="arvCenterSum_07_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_07_15" value="${feeCenterSum_07_15 / endCenterSum_07_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_06_15 eq 0 or endCenterSum_06_15 eq 0}">
		    						<c:set var="arvCenterSum_06_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_06_15" value="${feeCenterSum_06_15 / endCenterSum_06_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_05_15 eq 0 or endCenterSum_05_15 eq 0}">
		    						<c:set var="arvCenterSum_05_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_05_15" value="${feeCenterSum_05_15 / endCenterSum_05_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_04_15 eq 0 or endCenterSum_04_15 eq 0}">
		    						<c:set var="arvCenterSum_04_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_04_15" value="${feeCenterSum_04_15 / endCenterSum_04_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_03_15 eq 0 or endCenterSum_03_15 eq 0}">
		    						<c:set var="arvCenterSum_03_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_03_15" value="${feeCenterSum_03_15 / endCenterSum_03_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_02_15 eq 0 or endCenterSum_02_15 eq 0}">
		    						<c:set var="arvCenterSum_02_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_02_15" value="${feeCenterSum_02_15 / endCenterSum_02_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeCenterSum_01_15 eq 0 or endCenterSum_01_15 eq 0}">
		    						<c:set var="arvCenterSum_01_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvCenterSum_01_15" value="${feeCenterSum_01_15 / endCenterSum_01_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 센터별 평균 계산 끝 -->
		    						    				
		    				<!-- cntFee12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_12_15}" pattern="#,##0.##"/></td>
		    				<!-- cntFee11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_11_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_10_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_09_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_08_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_07_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_06_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_05_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_04_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_03_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_02_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterSum_01_15}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="feeCenterColSum_15" value="${feeCenterSum_12_15 + feeCenterSum_11_15 + feeCenterSum_10_15 + feeCenterSum_09_15 + feeCenterSum_08_15 + feeCenterSum_07_15 + feeCenterSum_06_15 + feeCenterSum_05_15 + feeCenterSum_04_15 + feeCenterSum_03_15 + feeCenterSum_02_15 + feeCenterSum_01_15}"></c:set>
			                <c:set var="endCenterColSum_15" value="${endCenterSum_12_15 + endCenterSum_11_15 + endCenterSum_10_15 + endCenterSum_09_15 + endCenterSum_08_15 + endCenterSum_07_15 + endCenterSum_06_15 + endCenterSum_05_15 + endCenterSum_04_15 + endCenterSum_03_15 + endCenterSum_02_15 + endCenterSum_01_15}"></c:set>			                
			                <c:choose>
			                	<c:when test="${feeCenterColSum_15 eq 0 or endCenterColSum_15 eq 0}">
			                		<c:set var="arvCenterColSum_15" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvCenterColSum_15" value="${feeCenterColSum_15 / endCenterColSum_15}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvCenterColSum_15}" pattern="#,##0.##"/></td>
		    				
							<!-- 센터별 계 카운트 초기화 -->
		    				<c:set var="centerCnt" value="1"></c:set>										                		    				
		    				<!-- 센터별 계 초기화 -->
				            <c:set var="cntFeeCenterSum_12_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_11_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_10_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_09_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_08_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_07_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_06_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_05_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_04_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_03_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_02_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_01_15" value="0"></c:set>
				            
				            <!-- 센터별 평균 계 초기화 -->
							<c:set var="feeCenterSum_12_15" value="0"></c:set>
							<c:set var="feeCenterSum_11_15" value="0"></c:set>
							<c:set var="feeCenterSum_10_15" value="0"></c:set>
							<c:set var="feeCenterSum_09_15" value="0"></c:set>
							<c:set var="feeCenterSum_08_15" value="0"></c:set>
							<c:set var="feeCenterSum_07_15" value="0"></c:set>
							<c:set var="feeCenterSum_06_15" value="0"></c:set>
							<c:set var="feeCenterSum_05_15" value="0"></c:set>
							<c:set var="feeCenterSum_04_15" value="0"></c:set>
							<c:set var="feeCenterSum_03_15" value="0"></c:set>
							<c:set var="feeCenterSum_02_15" value="0"></c:set>
							<c:set var="feeCenterSum_01_15" value="0"></c:set>
											    
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
				            <c:set var="cntFeeCenterSum_12_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_11_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_10_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_09_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_08_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_07_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_06_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_05_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_04_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_03_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_02_15" value="0"></c:set>
				            <c:set var="cntFeeCenterSum_01_15" value="0"></c:set>
				            
				            <!-- 센터별 평균 계 초기화 -->
							<c:set var="feeCenterSum_12_15" value="0"></c:set>
							<c:set var="feeCenterSum_11_15" value="0"></c:set>
							<c:set var="feeCenterSum_10_15" value="0"></c:set>
							<c:set var="feeCenterSum_09_15" value="0"></c:set>
							<c:set var="feeCenterSum_08_15" value="0"></c:set>
							<c:set var="feeCenterSum_07_15" value="0"></c:set>
							<c:set var="feeCenterSum_06_15" value="0"></c:set>
							<c:set var="feeCenterSum_05_15" value="0"></c:set>
							<c:set var="feeCenterSum_04_15" value="0"></c:set>
							<c:set var="feeCenterSum_03_15" value="0"></c:set>
							<c:set var="feeCenterSum_02_15" value="0"></c:set>
							<c:set var="feeCenterSum_01_15" value="0"></c:set>
											    
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
		    	<c:if test="${ptnrStatCntFeeList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 기타 평균</th>
	                <c:choose>
    					<c:when test="${feeCenterTotalSum_12_15 eq 0 or endCenterTotalSum_12_15 eq 0}">
    						<c:set var="arvCenterTotalSum_12_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_12_15" value="${feeCenterTotalSum_12_15 / endCenterTotalSum_12_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_11_15 eq 0 or endCenterTotalSum_11_15 eq 0}">
    						<c:set var="arvCenterTotalSum_11_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_11_15" value="${feeCenterTotalSum_11_15 / endCenterTotalSum_11_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_10_15 eq 0 or endCenterTotalSum_10_15 eq 0}">
    						<c:set var="arvCenterTotalSum_10_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_10_15" value="${feeCenterTotalSum_10_15 / endCenterTotalSum_10_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_09_15 eq 0 or endCenterTotalSum_09_15 eq 0}">
    						<c:set var="arvCenterTotalSum_09_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_09_15" value="${feeCenterTotalSum_09_15 / endCenterTotalSum_09_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_08_15 eq 0 or endCenterTotalSum_08_15 eq 0}">
    						<c:set var="arvCenterTotalSum_08_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_08_15" value="${feeCenterTotalSum_08_15 / endCenterTotalSum_08_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_07_15 eq 0 or endCenterTotalSum_07_15 eq 0}">
    						<c:set var="arvCenterTotalSum_07_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_07_15" value="${feeCenterTotalSum_07_15 / endCenterTotalSum_07_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_06_15 eq 0 or endCenterTotalSum_06_15 eq 0}">
    						<c:set var="arvCenterTotalSum_06_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_06_15" value="${feeCenterTotalSum_06_15 / endCenterTotalSum_06_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_05_15 eq 0 or endCenterTotalSum_05_15 eq 0}">
    						<c:set var="arvCenterTotalSum_05_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_05_15" value="${feeCenterTotalSum_05_15 / endCenterTotalSum_05_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_04_15 eq 0 or endCenterTotalSum_04_15 eq 0}">
    						<c:set var="arvCenterTotalSum_04_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_04_15" value="${feeCenterTotalSum_04_15 / endCenterTotalSum_04_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_03_15 eq 0 or endCenterTotalSum_03_15 eq 0}">
    						<c:set var="arvCenterTotalSum_03_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_03_15" value="${feeCenterTotalSum_03_15 / endCenterTotalSum_03_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_02_15 eq 0 or endCenterTotalSum_02_15 eq 0}">
    						<c:set var="arvCenterTotalSum_02_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_02_15" value="${feeCenterTotalSum_02_15 / endCenterTotalSum_02_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeCenterTotalSum_01_15 eq 0 or endCenterTotalSum_01_15 eq 0}">
    						<c:set var="arvCenterTotalSum_01_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvCenterTotalSum_01_15" value="${feeCenterTotalSum_01_15 / endCenterTotalSum_01_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 센터별 평균 계산 끝 -->
    						    				
    				<!-- cntFee12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_12_15}" pattern="#,##0.##"/></th>
    				<!-- cntFee11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_11_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_10_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_09_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_08_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_07_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_06_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_05_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_04_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_03_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_02_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvCenterTotalSum_01_15}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="feeColCenterTotalSum_15" value="${feeCenterTotalSum_12_15 + feeCenterTotalSum_11_15 + feeCenterTotalSum_10_15 + feeCenterTotalSum_09_15 + feeCenterTotalSum_08_15 + feeCenterTotalSum_07_15 + feeCenterTotalSum_06_15 + feeCenterTotalSum_05_15 + feeCenterTotalSum_04_15 + feeCenterTotalSum_03_15 + feeCenterTotalSum_02_15 + feeCenterTotalSum_01_15}"></c:set>
	                <c:set var="endColCenterTotalSum_15" value="${endCenterTotalSum_12_15 + endCenterTotalSum_11_15 + endCenterTotalSum_10_15 + endCenterTotalSum_09_15 + endCenterTotalSum_08_15 + endCenterTotalSum_07_15 + endCenterTotalSum_06_15 + endCenterTotalSum_05_15 + endCenterTotalSum_04_15 + endCenterTotalSum_03_15 + endCenterTotalSum_02_15 + endCenterTotalSum_01_15}"></c:set>
					<c:choose>
	                	<c:when test="${feeColCenterTotalSum_15 eq 0 or endColCenterTotalSum_15 eq 0}">
	                		<c:set var="arvColCenterTotalSum_15" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColCenterTotalSum_15" value="${feeColCenterTotalSum_15 / endColCenterTotalSum_15}"/>
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
    <c:set var="cntFeeCenterTotalSum_12_all" value="${cntFeeCenterTotalSum_12_5 + cntFeeCenterTotalSum_12_10 + cntFeeCenterTotalSum_12_15}"></c:set>
    <c:set var="cntFeeCenterTotalSum_11_all" value="${cntFeeCenterTotalSum_11_5 + cntFeeCenterTotalSum_11_10 + cntFeeCenterTotalSum_11_15}"></c:set>
    <c:set var="cntFeeCenterTotalSum_10_all" value="${cntFeeCenterTotalSum_10_5 + cntFeeCenterTotalSum_10_10 + cntFeeCenterTotalSum_10_15}"></c:set>
    <c:set var="cntFeeCenterTotalSum_09_all" value="${cntFeeCenterTotalSum_09_5 + cntFeeCenterTotalSum_09_10 + cntFeeCenterTotalSum_09_15}"></c:set>
    <c:set var="cntFeeCenterTotalSum_08_all" value="${cntFeeCenterTotalSum_08_5 + cntFeeCenterTotalSum_08_10 + cntFeeCenterTotalSum_08_15}"></c:set>
    <c:set var="cntFeeCenterTotalSum_07_all" value="${cntFeeCenterTotalSum_07_5 + cntFeeCenterTotalSum_07_10 + cntFeeCenterTotalSum_07_15}"></c:set>
    <c:set var="cntFeeCenterTotalSum_06_all" value="${cntFeeCenterTotalSum_06_5 + cntFeeCenterTotalSum_06_10 + cntFeeCenterTotalSum_06_15}"></c:set>
    <c:set var="cntFeeCenterTotalSum_05_all" value="${cntFeeCenterTotalSum_05_5 + cntFeeCenterTotalSum_05_10 + cntFeeCenterTotalSum_05_15}"></c:set>
    <c:set var="cntFeeCenterTotalSum_04_all" value="${cntFeeCenterTotalSum_04_5 + cntFeeCenterTotalSum_04_10 + cntFeeCenterTotalSum_04_15}"></c:set>
    <c:set var="cntFeeCenterTotalSum_03_all" value="${cntFeeCenterTotalSum_03_5 + cntFeeCenterTotalSum_03_10 + cntFeeCenterTotalSum_03_15}"></c:set>
    <c:set var="cntFeeCenterTotalSum_02_all" value="${cntFeeCenterTotalSum_02_5 + cntFeeCenterTotalSum_02_10 + cntFeeCenterTotalSum_02_15}"></c:set>
    <c:set var="cntFeeCenterTotalSum_01_all" value="${cntFeeCenterTotalSum_01_5 + cntFeeCenterTotalSum_01_10 + cntFeeCenterTotalSum_01_15}"></c:set>        
    <c:set var="cntFeeCenterTotalSum_col_all" value="${cntFeeCenterTotalSum_12_all + cntFeeCenterTotalSum_11_all + cntFeeCenterTotalSum_10_all + cntFeeCenterTotalSum_09_all + cntFeeCenterTotalSum_08_all + cntFeeCenterTotalSum_07_all + cntFeeCenterTotalSum_06_all + cntFeeCenterTotalSum_05_all + cntFeeCenterTotalSum_04_all + cntFeeCenterTotalSum_03_all + cntFeeCenterTotalSum_02_all + cntFeeCenterTotalSum_01_all}"></c:set>
    
    <c:set var="feeCenterTotalSum_12_all" value="${feeCenterTotalSum_12_5 + feeCenterTotalSum_12_10 + feeCenterTotalSum_12_15}"></c:set>
    <c:set var="feeCenterTotalSum_11_all" value="${feeCenterTotalSum_11_5 + feeCenterTotalSum_11_10 + feeCenterTotalSum_11_15}"></c:set>
    <c:set var="feeCenterTotalSum_10_all" value="${feeCenterTotalSum_10_5 + feeCenterTotalSum_10_10 + feeCenterTotalSum_10_15}"></c:set>
    <c:set var="feeCenterTotalSum_09_all" value="${feeCenterTotalSum_09_5 + feeCenterTotalSum_09_10 + feeCenterTotalSum_09_15}"></c:set>
    <c:set var="feeCenterTotalSum_08_all" value="${feeCenterTotalSum_08_5 + feeCenterTotalSum_08_10 + feeCenterTotalSum_08_15}"></c:set>
    <c:set var="feeCenterTotalSum_07_all" value="${feeCenterTotalSum_07_5 + feeCenterTotalSum_07_10 + feeCenterTotalSum_07_15}"></c:set>
    <c:set var="feeCenterTotalSum_06_all" value="${feeCenterTotalSum_06_5 + feeCenterTotalSum_06_10 + feeCenterTotalSum_06_15}"></c:set>
    <c:set var="feeCenterTotalSum_05_all" value="${feeCenterTotalSum_05_5 + feeCenterTotalSum_05_10 + feeCenterTotalSum_05_15}"></c:set>
    <c:set var="feeCenterTotalSum_04_all" value="${feeCenterTotalSum_04_5 + feeCenterTotalSum_04_10 + feeCenterTotalSum_04_15}"></c:set>
    <c:set var="feeCenterTotalSum_03_all" value="${feeCenterTotalSum_03_5 + feeCenterTotalSum_03_10 + feeCenterTotalSum_03_15}"></c:set>
    <c:set var="feeCenterTotalSum_02_all" value="${feeCenterTotalSum_02_5 + feeCenterTotalSum_02_10 + feeCenterTotalSum_02_15}"></c:set>
    <c:set var="feeCenterTotalSum_01_all" value="${feeCenterTotalSum_01_5 + feeCenterTotalSum_01_10 + feeCenterTotalSum_01_15}"></c:set>
    
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
		<c:when test="${feeCenterTotalSum_12_all eq 0 or endCenterTotalSum_12_all eq 0}">
			<c:set var="arvCenterTotalSum_12_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_12_all" value="${feeCenterTotalSum_12_all / endCenterTotalSum_12_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeCenterTotalSum_11_all eq 0 or endCenterTotalSum_11_all eq 0}">
			<c:set var="arvCenterTotalSum_11_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_11_all" value="${feeCenterTotalSum_11_all / endCenterTotalSum_11_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeCenterTotalSum_10_all eq 0 or endCenterTotalSum_10_all eq 0}">
			<c:set var="arvCenterTotalSum_10_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_10_all" value="${feeCenterTotalSum_10_all / endCenterTotalSum_10_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeCenterTotalSum_09_all eq 0 or endCenterTotalSum_09_all eq 0}">
			<c:set var="arvCenterTotalSum_09_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_09_all" value="${feeCenterTotalSum_09_all / endCenterTotalSum_09_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeCenterTotalSum_08_all eq 0 or endCenterTotalSum_08_all eq 0}">
			<c:set var="arvCenterTotalSum_08_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_08_all" value="${feeCenterTotalSum_08_all / endCenterTotalSum_08_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeCenterTotalSum_07_all eq 0 or endCenterTotalSum_07_all eq 0}">
			<c:set var="arvCenterTotalSum_07_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_07_all" value="${feeCenterTotalSum_07_all / endCenterTotalSum_07_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeCenterTotalSum_06_all eq 0 or endCenterTotalSum_06_all eq 0}">
			<c:set var="arvCenterTotalSum_06_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_06_all" value="${feeCenterTotalSum_06_all / endCenterTotalSum_06_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeCenterTotalSum_05_all eq 0 or endCenterTotalSum_05_all eq 0}">
			<c:set var="arvCenterTotalSum_05_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_05_all" value="${feeCenterTotalSum_05_all / endCenterTotalSum_05_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeCenterTotalSum_04_all eq 0 or endCenterTotalSum_04_all eq 0}">
			<c:set var="arvCenterTotalSum_04_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_04_all" value="${feeCenterTotalSum_04_all / endCenterTotalSum_04_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeCenterTotalSum_03_all eq 0 or endCenterTotalSum_03_all eq 0}">
			<c:set var="arvCenterTotalSum_03_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_03_all" value="${feeCenterTotalSum_03_all / endCenterTotalSum_03_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeCenterTotalSum_02_all eq 0 or endCenterTotalSum_02_all eq 0}">
			<c:set var="arvCenterTotalSum_02_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_02_all" value="${feeCenterTotalSum_02_all / endCenterTotalSum_02_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeCenterTotalSum_01_all eq 0 or endCenterTotalSum_01_all eq 0}">
			<c:set var="arvCenterTotalSum_01_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvCenterTotalSum_01_all" value="${feeCenterTotalSum_01_all / endCenterTotalSum_01_all}"></c:set>
		</c:otherwise>
	</c:choose>
	
	<!-- 가로 합계 -->
	<c:set var="feeColCenterTotalSum_all" value="${feeCenterTotalSum_12_all + feeCenterTotalSum_11_all + feeCenterTotalSum_10_all + feeCenterTotalSum_09_all + feeCenterTotalSum_08_all + feeCenterTotalSum_07_all + feeCenterTotalSum_06_all + feeCenterTotalSum_05_all + feeCenterTotalSum_04_all + feeCenterTotalSum_03_all + feeCenterTotalSum_02_all + feeCenterTotalSum_01_all}"></c:set>
	<c:set var="endColCenterTotalSum_all" value="${endCenterTotalSum_12_all + endCenterTotalSum_11_all + endCenterTotalSum_10_all + endCenterTotalSum_09_all + endCenterTotalSum_08_all + endCenterTotalSum_07_all + endCenterTotalSum_06_all + endCenterTotalSum_05_all + endCenterTotalSum_04_all + endCenterTotalSum_03_all + endCenterTotalSum_02_all + endCenterTotalSum_01_all}"></c:set>
	<c:choose>
		<c:when test="${feeColCenterTotalSum_all eq 0 or endColCenterTotalSum_all eq 0}">
			<c:set var="arvColCenterTotalSum_all" value="0"/>
		</c:when>
		<c:otherwise>
			<c:set var="arvColCenterTotalSum_all" value="${feeColCenterTotalSum_all / endColCenterTotalSum_all}"/>
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