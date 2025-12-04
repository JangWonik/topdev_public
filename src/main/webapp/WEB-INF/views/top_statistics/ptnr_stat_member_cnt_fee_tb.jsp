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
	            <c:set var="cntFeeMemberSum_12_5" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_11_5" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_10_5" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_09_5" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_08_5" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_07_5" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_06_5" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_05_5" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_04_5" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_03_5" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_02_5" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_01_5" value="0"></c:set>
	            
	            <!-- 직원별 평균 계 초기화 -->
				<c:set var="feeMemberSum_12_5" value="0"></c:set>
				<c:set var="feeMemberSum_11_5" value="0"></c:set>
				<c:set var="feeMemberSum_10_5" value="0"></c:set>
				<c:set var="feeMemberSum_09_5" value="0"></c:set>
				<c:set var="feeMemberSum_08_5" value="0"></c:set>
				<c:set var="feeMemberSum_07_5" value="0"></c:set>
				<c:set var="feeMemberSum_06_5" value="0"></c:set>
				<c:set var="feeMemberSum_05_5" value="0"></c:set>
				<c:set var="feeMemberSum_04_5" value="0"></c:set>
				<c:set var="feeMemberSum_03_5" value="0"></c:set>
				<c:set var="feeMemberSum_02_5" value="0"></c:set>
				<c:set var="feeMemberSum_01_5" value="0"></c:set>
								    
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
	            <c:set var="cntFeeMemberTotalSum_12_5" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_11_5" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_10_5" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_09_5" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_08_5" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_07_5" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_06_5" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_05_5" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_04_5" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_03_5" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_02_5" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_01_5" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntFeeColMemberTotalSum_5" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="feeMemberTotalSum_12_5" value="0"></c:set>
				<c:set var="feeMemberTotalSum_11_5" value="0"></c:set>
				<c:set var="feeMemberTotalSum_10_5" value="0"></c:set>
				<c:set var="feeMemberTotalSum_09_5" value="0"></c:set>
				<c:set var="feeMemberTotalSum_08_5" value="0"></c:set>
				<c:set var="feeMemberTotalSum_07_5" value="0"></c:set>
				<c:set var="feeMemberTotalSum_06_5" value="0"></c:set>
				<c:set var="feeMemberTotalSum_05_5" value="0"></c:set>
				<c:set var="feeMemberTotalSum_04_5" value="0"></c:set>
				<c:set var="feeMemberTotalSum_03_5" value="0"></c:set>
				<c:set var="feeMemberTotalSum_02_5" value="0"></c:set>
				<c:set var="feeMemberTotalSum_01_5" value="0"></c:set>
				
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
   				    			
    			<c:forEach var="vo" items="${ptnrStatCntFeeList}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <c:choose>
		    					<c:when test='${srchArg.tabMenu eq "team"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterCntFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
				                    	1종 조사
				                    </td>
		    					</c:when>
		    					<c:when test='${srchArg.tabMenu eq "member"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterCntFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
				                    	1종 조사
				                    </td>
		    					</c:when>
		    					<c:otherwise>
		    						<td onclick="goPtnrStatMenu('ptnrStatTeamCntFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow}">
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
					            <c:set var="cntFeeMemberSum_12_5" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_11_5" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_10_5" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_09_5" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_08_5" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_07_5" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_06_5" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_05_5" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_04_5" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_03_5" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_02_5" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_01_5" value="0"></c:set>
					            
					            <!-- 직원별 평균 계 초기화 -->
								<c:set var="feeMemberSum_12_5" value="0"></c:set>
								<c:set var="feeMemberSum_11_5" value="0"></c:set>
								<c:set var="feeMemberSum_10_5" value="0"></c:set>
								<c:set var="feeMemberSum_09_5" value="0"></c:set>
								<c:set var="feeMemberSum_08_5" value="0"></c:set>
								<c:set var="feeMemberSum_07_5" value="0"></c:set>
								<c:set var="feeMemberSum_06_5" value="0"></c:set>
								<c:set var="feeMemberSum_05_5" value="0"></c:set>
								<c:set var="feeMemberSum_04_5" value="0"></c:set>
								<c:set var="feeMemberSum_03_5" value="0"></c:set>
								<c:set var="feeMemberSum_02_5" value="0"></c:set>
								<c:set var="feeMemberSum_01_5" value="0"></c:set>
												    
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
		                
		                <!-- 직원별 계 합산 -->
	    				<c:set var="cntFeeMemberSum_12_5" value="${cntFeeMemberSum_12_5+cntFee12_5}"></c:set>
			            <c:set var="cntFeeMemberSum_11_5" value="${cntFeeMemberSum_11_5+cntFee11_5}"></c:set>
			            <c:set var="cntFeeMemberSum_10_5" value="${cntFeeMemberSum_10_5+cntFee10_5}"></c:set>
			            <c:set var="cntFeeMemberSum_09_5" value="${cntFeeMemberSum_09_5+cntFee09_5}"></c:set>
			            <c:set var="cntFeeMemberSum_08_5" value="${cntFeeMemberSum_08_5+cntFee08_5}"></c:set>
			            <c:set var="cntFeeMemberSum_07_5" value="${cntFeeMemberSum_07_5+cntFee07_5}"></c:set>
			            <c:set var="cntFeeMemberSum_06_5" value="${cntFeeMemberSum_06_5+cntFee06_5}"></c:set>
			            <c:set var="cntFeeMemberSum_05_5" value="${cntFeeMemberSum_05_5+cntFee05_5}"></c:set>
			            <c:set var="cntFeeMemberSum_04_5" value="${cntFeeMemberSum_04_5+cntFee04_5}"></c:set>
			            <c:set var="cntFeeMemberSum_03_5" value="${cntFeeMemberSum_03_5+cntFee03_5}"></c:set>
			            <c:set var="cntFeeMemberSum_02_5" value="${cntFeeMemberSum_02_5+cntFee02_5}"></c:set>
			            <c:set var="cntFeeMemberSum_01_5" value="${cntFeeMemberSum_01_5+cntFee01_5}"></c:set>
			            
			            <!-- 직원별 계 평균용 변수 -->
						<c:set var="feeMemberSum_12_5" value="${feeMemberSum_12_5+fee12_5}"></c:set>
			            <c:set var="feeMemberSum_11_5" value="${feeMemberSum_11_5+fee11_5}"></c:set>
			            <c:set var="feeMemberSum_10_5" value="${feeMemberSum_10_5+fee10_5}"></c:set>
			            <c:set var="feeMemberSum_09_5" value="${feeMemberSum_09_5+fee09_5}"></c:set>
			            <c:set var="feeMemberSum_08_5" value="${feeMemberSum_08_5+fee08_5}"></c:set>
			            <c:set var="feeMemberSum_07_5" value="${feeMemberSum_07_5+fee07_5}"></c:set>
			            <c:set var="feeMemberSum_06_5" value="${feeMemberSum_06_5+fee06_5}"></c:set>
			            <c:set var="feeMemberSum_05_5" value="${feeMemberSum_05_5+fee05_5}"></c:set>
			            <c:set var="feeMemberSum_04_5" value="${feeMemberSum_04_5+fee04_5}"></c:set>
			            <c:set var="feeMemberSum_03_5" value="${feeMemberSum_03_5+fee03_5}"></c:set>
			            <c:set var="feeMemberSum_02_5" value="${feeMemberSum_02_5+fee02_5}"></c:set>
			            <c:set var="feeMemberSum_01_5" value="${feeMemberSum_01_5+fee01_5}"></c:set>
				    
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
	                    <c:set var="cntFeeMemberTotalSum_12_5" value="${cntFeeMemberTotalSum_12_5 + cntFee12_5}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_11_5" value="${cntFeeMemberTotalSum_11_5 + cntFee11_5}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_10_5" value="${cntFeeMemberTotalSum_10_5 + cntFee10_5}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_09_5" value="${cntFeeMemberTotalSum_09_5 + cntFee09_5}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_08_5" value="${cntFeeMemberTotalSum_08_5 + cntFee08_5}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_07_5" value="${cntFeeMemberTotalSum_07_5 + cntFee07_5}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_06_5" value="${cntFeeMemberTotalSum_06_5 + cntFee06_5}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_05_5" value="${cntFeeMemberTotalSum_05_5 + cntFee05_5}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_04_5" value="${cntFeeMemberTotalSum_04_5 + cntFee04_5}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_03_5" value="${cntFeeMemberTotalSum_03_5 + cntFee03_5}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_02_5" value="${cntFeeMemberTotalSum_02_5 + cntFee02_5}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_01_5" value="${cntFeeMemberTotalSum_01_5 + cntFee01_5}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="feeMemberTotalSum_12_5" value="${feeMemberTotalSum_12_5 + fee12_5}"></c:set>
	                    <c:set var="feeMemberTotalSum_11_5" value="${feeMemberTotalSum_11_5 + fee11_5}"></c:set>
	                    <c:set var="feeMemberTotalSum_10_5" value="${feeMemberTotalSum_10_5 + fee10_5}"></c:set>
	                    <c:set var="feeMemberTotalSum_09_5" value="${feeMemberTotalSum_09_5 + fee09_5}"></c:set>
	                    <c:set var="feeMemberTotalSum_08_5" value="${feeMemberTotalSum_08_5 + fee08_5}"></c:set>
	                    <c:set var="feeMemberTotalSum_07_5" value="${feeMemberTotalSum_07_5 + fee07_5}"></c:set>
	                    <c:set var="feeMemberTotalSum_06_5" value="${feeMemberTotalSum_06_5 + fee06_5}"></c:set>
	                    <c:set var="feeMemberTotalSum_05_5" value="${feeMemberTotalSum_05_5 + fee05_5}"></c:set>
	                    <c:set var="feeMemberTotalSum_04_5" value="${feeMemberTotalSum_04_5 + fee04_5}"></c:set>
	                    <c:set var="feeMemberTotalSum_03_5" value="${feeMemberTotalSum_03_5 + fee03_5}"></c:set>
	                    <c:set var="feeMemberTotalSum_02_5" value="${feeMemberTotalSum_02_5 + fee02_5}"></c:set>
	                    <c:set var="feeMemberTotalSum_01_5" value="${feeMemberTotalSum_01_5 + fee01_5}"></c:set>

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
		    					<c:when test="${feeMemberSum_12_5 eq 0 or endMemberSum_12_5 eq 0}">
		    						<c:set var="arvMemberSum_12_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_12_5" value="${feeMemberSum_12_5 / endMemberSum_12_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_11_5 eq 0 or endMemberSum_11_5 eq 0}">
		    						<c:set var="arvMemberSum_11_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_11_5" value="${feeMemberSum_11_5 / endMemberSum_11_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_10_5 eq 0 or endMemberSum_10_5 eq 0}">
		    						<c:set var="arvMemberSum_10_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_10_5" value="${feeMemberSum_10_5 / endMemberSum_10_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_09_5 eq 0 or endMemberSum_09_5 eq 0}">
		    						<c:set var="arvMemberSum_09_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_09_5" value="${feeMemberSum_09_5 / endMemberSum_09_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_08_5 eq 0 or endMemberSum_08_5 eq 0}">
		    						<c:set var="arvMemberSum_08_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_08_5" value="${feeMemberSum_08_5 / endMemberSum_08_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_07_5 eq 0 or endMemberSum_07_5 eq 0}">
		    						<c:set var="arvMemberSum_07_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_07_5" value="${feeMemberSum_07_5 / endMemberSum_07_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_06_5 eq 0 or endMemberSum_06_5 eq 0}">
		    						<c:set var="arvMemberSum_06_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_06_5" value="${feeMemberSum_06_5 / endMemberSum_06_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_05_5 eq 0 or endMemberSum_05_5 eq 0}">
		    						<c:set var="arvMemberSum_05_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_05_5" value="${feeMemberSum_05_5 / endMemberSum_05_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_04_5 eq 0 or endMemberSum_04_5 eq 0}">
		    						<c:set var="arvMemberSum_04_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_04_5" value="${feeMemberSum_04_5 / endMemberSum_04_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_03_5 eq 0 or endMemberSum_03_5 eq 0}">
		    						<c:set var="arvMemberSum_03_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_03_5" value="${feeMemberSum_03_5 / endMemberSum_03_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_02_5 eq 0 or endMemberSum_02_5 eq 0}">
		    						<c:set var="arvMemberSum_02_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_02_5" value="${feeMemberSum_02_5 / endMemberSum_02_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_01_5 eq 0 or endMemberSum_01_5 eq 0}">
		    						<c:set var="arvMemberSum_01_5" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_01_5" value="${feeMemberSum_01_5 / endMemberSum_01_5}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 직원별 평균 계산 끝 -->
		    						    				
		    				<!-- cntFee12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_12_5}" pattern="#,##0.##"/></td>
		    				<!-- cntFee11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_11_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_10_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_09_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_08_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_07_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_06_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_05_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_04_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_03_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_02_5}" pattern="#,##0.##"/></td>
			                <!-- cntFee01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_01_5}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="feeMemberColSum_5" value="${feeMemberSum_12_5 + feeMemberSum_11_5 + feeMemberSum_10_5 + feeMemberSum_09_5 + feeMemberSum_08_5 + feeMemberSum_07_5 + feeMemberSum_06_5 + feeMemberSum_05_5 + feeMemberSum_04_5 + feeMemberSum_03_5 + feeMemberSum_02_5 + feeMemberSum_01_5}"></c:set>
			                <c:set var="endMemberColSum_5" value="${endMemberSum_12_5 + endMemberSum_11_5 + endMemberSum_10_5 + endMemberSum_09_5 + endMemberSum_08_5 + endMemberSum_07_5 + endMemberSum_06_5 + endMemberSum_05_5 + endMemberSum_04_5 + endMemberSum_03_5 + endMemberSum_02_5 + endMemberSum_01_5}"></c:set>			                
			                <c:choose>
			                	<c:when test="${feeMemberColSum_5 eq 0 or endMemberColSum_5 eq 0}">
			                		<c:set var="arvMemberColSum_5" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvMemberColSum_5" value="${feeMemberColSum_5 / endMemberColSum_5}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberColSum_5}" pattern="#,##0.##"/></td>
		    				
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="cntFeeMemberSum_12_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_11_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_10_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_09_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_08_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_07_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_06_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_05_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_04_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_03_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_02_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_01_5" value="0"></c:set>
				            
				            <!-- 직원별 평균 계 초기화 -->
							<c:set var="feeMemberSum_12_5" value="0"></c:set>
							<c:set var="feeMemberSum_11_5" value="0"></c:set>
							<c:set var="feeMemberSum_10_5" value="0"></c:set>
							<c:set var="feeMemberSum_09_5" value="0"></c:set>
							<c:set var="feeMemberSum_08_5" value="0"></c:set>
							<c:set var="feeMemberSum_07_5" value="0"></c:set>
							<c:set var="feeMemberSum_06_5" value="0"></c:set>
							<c:set var="feeMemberSum_05_5" value="0"></c:set>
							<c:set var="feeMemberSum_04_5" value="0"></c:set>
							<c:set var="feeMemberSum_03_5" value="0"></c:set>
							<c:set var="feeMemberSum_02_5" value="0"></c:set>
							<c:set var="feeMemberSum_01_5" value="0"></c:set>
											    
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
				            <c:set var="cntFeeMemberSum_12_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_11_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_10_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_09_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_08_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_07_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_06_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_05_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_04_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_03_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_02_5" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_01_5" value="0"></c:set>
				            
				            <!-- 직원별 평균 계 초기화 -->
							<c:set var="feeMemberSum_12_5" value="0"></c:set>
							<c:set var="feeMemberSum_11_5" value="0"></c:set>
							<c:set var="feeMemberSum_10_5" value="0"></c:set>
							<c:set var="feeMemberSum_09_5" value="0"></c:set>
							<c:set var="feeMemberSum_08_5" value="0"></c:set>
							<c:set var="feeMemberSum_07_5" value="0"></c:set>
							<c:set var="feeMemberSum_06_5" value="0"></c:set>
							<c:set var="feeMemberSum_05_5" value="0"></c:set>
							<c:set var="feeMemberSum_04_5" value="0"></c:set>
							<c:set var="feeMemberSum_03_5" value="0"></c:set>
							<c:set var="feeMemberSum_02_5" value="0"></c:set>
							<c:set var="feeMemberSum_01_5" value="0"></c:set>
											    
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
		    	<c:if test="${ptnrStatCntFeeList.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 조사 평균</th>
	                <c:choose>
    					<c:when test="${feeMemberTotalSum_12_5 eq 0 or endMemberTotalSum_12_5 eq 0}">
    						<c:set var="arvMemberTotalSum_12_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_12_5" value="${feeMemberTotalSum_12_5 / endMemberTotalSum_12_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_11_5 eq 0 or endMemberTotalSum_11_5 eq 0}">
    						<c:set var="arvMemberTotalSum_11_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_11_5" value="${feeMemberTotalSum_11_5 / endMemberTotalSum_11_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_10_5 eq 0 or endMemberTotalSum_10_5 eq 0}">
    						<c:set var="arvMemberTotalSum_10_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_10_5" value="${feeMemberTotalSum_10_5 / endMemberTotalSum_10_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_09_5 eq 0 or endMemberTotalSum_09_5 eq 0}">
    						<c:set var="arvMemberTotalSum_09_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_09_5" value="${feeMemberTotalSum_09_5 / endMemberTotalSum_09_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_08_5 eq 0 or endMemberTotalSum_08_5 eq 0}">
    						<c:set var="arvMemberTotalSum_08_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_08_5" value="${feeMemberTotalSum_08_5 / endMemberTotalSum_08_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_07_5 eq 0 or endMemberTotalSum_07_5 eq 0}">
    						<c:set var="arvMemberTotalSum_07_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_07_5" value="${feeMemberTotalSum_07_5 / endMemberTotalSum_07_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_06_5 eq 0 or endMemberTotalSum_06_5 eq 0}">
    						<c:set var="arvMemberTotalSum_06_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_06_5" value="${feeMemberTotalSum_06_5 / endMemberTotalSum_06_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_05_5 eq 0 or endMemberTotalSum_05_5 eq 0}">
    						<c:set var="arvMemberTotalSum_05_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_05_5" value="${feeMemberTotalSum_05_5 / endMemberTotalSum_05_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_04_5 eq 0 or endMemberTotalSum_04_5 eq 0}">
    						<c:set var="arvMemberTotalSum_04_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_04_5" value="${feeMemberTotalSum_04_5 / endMemberTotalSum_04_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_03_5 eq 0 or endMemberTotalSum_03_5 eq 0}">
    						<c:set var="arvMemberTotalSum_03_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_03_5" value="${feeMemberTotalSum_03_5 / endMemberTotalSum_03_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_02_5 eq 0 or endMemberTotalSum_02_5 eq 0}">
    						<c:set var="arvMemberTotalSum_02_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_02_5" value="${feeMemberTotalSum_02_5 / endMemberTotalSum_02_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_01_5 eq 0 or endMemberTotalSum_01_5 eq 0}">
    						<c:set var="arvMemberTotalSum_01_5" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_01_5" value="${feeMemberTotalSum_01_5 / endMemberTotalSum_01_5}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 직원별 평균 계산 끝 -->
    						    				
    				<!-- cntFee12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_12_5}" pattern="#,##0.##"/></th>
    				<!-- cntFee11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_11_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_10_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_09_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_08_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_07_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_06_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_05_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_04_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_03_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_02_5}" pattern="#,##0.##"/></th>
	                <!-- cntFee01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_01_5}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="feeColMemberTotalSum_5" value="${feeMemberTotalSum_12_5 + feeMemberTotalSum_11_5 + feeMemberTotalSum_10_5 + feeMemberTotalSum_09_5 + feeMemberTotalSum_08_5 + feeMemberTotalSum_07_5 + feeMemberTotalSum_06_5 + feeMemberTotalSum_05_5 + feeMemberTotalSum_04_5 + feeMemberTotalSum_03_5 + feeMemberTotalSum_02_5 + feeMemberTotalSum_01_5}"></c:set>
	                <c:set var="endColMemberTotalSum_5" value="${endMemberTotalSum_12_5 + endMemberTotalSum_11_5 + endMemberTotalSum_10_5 + endMemberTotalSum_09_5 + endMemberTotalSum_08_5 + endMemberTotalSum_07_5 + endMemberTotalSum_06_5 + endMemberTotalSum_05_5 + endMemberTotalSum_04_5 + endMemberTotalSum_03_5 + endMemberTotalSum_02_5 + endMemberTotalSum_01_5}"></c:set>
					<c:choose>
	                	<c:when test="${feeColMemberTotalSum_5 eq 0 or endColMemberTotalSum_5 eq 0}">
	                		<c:set var="arvColMemberTotalSum_5" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColMemberTotalSum_5" value="${feeColMemberTotalSum_5 / endColMemberTotalSum_5}"/>
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
	            <c:set var="cntFeeMemberSum_12_10" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_11_10" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_10_10" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_09_10" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_08_10" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_07_10" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_06_10" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_05_10" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_04_10" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_03_10" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_02_10" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_01_10" value="0"></c:set>
	            
	            <!-- 직원별 평균 계 초기화 -->
				<c:set var="feeMemberSum_12_10" value="0"></c:set>
				<c:set var="feeMemberSum_11_10" value="0"></c:set>
				<c:set var="feeMemberSum_10_10" value="0"></c:set>
				<c:set var="feeMemberSum_09_10" value="0"></c:set>
				<c:set var="feeMemberSum_08_10" value="0"></c:set>
				<c:set var="feeMemberSum_07_10" value="0"></c:set>
				<c:set var="feeMemberSum_06_10" value="0"></c:set>
				<c:set var="feeMemberSum_05_10" value="0"></c:set>
				<c:set var="feeMemberSum_04_10" value="0"></c:set>
				<c:set var="feeMemberSum_03_10" value="0"></c:set>
				<c:set var="feeMemberSum_02_10" value="0"></c:set>
				<c:set var="feeMemberSum_01_10" value="0"></c:set>
								    
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
	            <c:set var="cntFeeMemberTotalSum_12_10" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_11_10" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_10_10" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_09_10" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_08_10" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_07_10" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_06_10" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_05_10" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_04_10" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_03_10" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_02_10" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_01_10" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntFeeColMemberTotalSum_10" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="feeMemberTotalSum_12_10" value="0"></c:set>
				<c:set var="feeMemberTotalSum_11_10" value="0"></c:set>
				<c:set var="feeMemberTotalSum_10_10" value="0"></c:set>
				<c:set var="feeMemberTotalSum_09_10" value="0"></c:set>
				<c:set var="feeMemberTotalSum_08_10" value="0"></c:set>
				<c:set var="feeMemberTotalSum_07_10" value="0"></c:set>
				<c:set var="feeMemberTotalSum_06_10" value="0"></c:set>
				<c:set var="feeMemberTotalSum_05_10" value="0"></c:set>
				<c:set var="feeMemberTotalSum_04_10" value="0"></c:set>
				<c:set var="feeMemberTotalSum_03_10" value="0"></c:set>
				<c:set var="feeMemberTotalSum_02_10" value="0"></c:set>
				<c:set var="feeMemberTotalSum_01_10" value="0"></c:set>
				
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
   				    			
    			<c:forEach var="vo1" items="${ptnrStatCntFeeList_10}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <c:choose>
		                    	<c:when test='${srchArg.tabMenu eq "team"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterCntFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
				                    	1종 심사
				                    </td>
		    					</c:when>
		    					<c:when test='${srchArg.tabMenu eq "member"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterCntFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
				                    	1종 심사
				                    </td>
		    					</c:when>
		    					<c:otherwise>
		    						<td onclick="goPtnrStatMenu('ptnrStatTeamCntFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_10}">
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
					            <c:set var="cntFeeMemberSum_12_10" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_11_10" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_10_10" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_09_10" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_08_10" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_07_10" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_06_10" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_05_10" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_04_10" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_03_10" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_02_10" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_01_10" value="0"></c:set>
					            
					            <!-- 직원별 평균 계 초기화 -->
								<c:set var="feeMemberSum_12_10" value="0"></c:set>
								<c:set var="feeMemberSum_11_10" value="0"></c:set>
								<c:set var="feeMemberSum_10_10" value="0"></c:set>
								<c:set var="feeMemberSum_09_10" value="0"></c:set>
								<c:set var="feeMemberSum_08_10" value="0"></c:set>
								<c:set var="feeMemberSum_07_10" value="0"></c:set>
								<c:set var="feeMemberSum_06_10" value="0"></c:set>
								<c:set var="feeMemberSum_05_10" value="0"></c:set>
								<c:set var="feeMemberSum_04_10" value="0"></c:set>
								<c:set var="feeMemberSum_03_10" value="0"></c:set>
								<c:set var="feeMemberSum_02_10" value="0"></c:set>
								<c:set var="feeMemberSum_01_10" value="0"></c:set>
												    
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
		                
		                <!-- 직원별 계 합산 -->
	    				<c:set var="cntFeeMemberSum_12_10" value="${cntFeeMemberSum_12_10+cntFee12_10}"></c:set>
			            <c:set var="cntFeeMemberSum_11_10" value="${cntFeeMemberSum_11_10+cntFee11_10}"></c:set>
			            <c:set var="cntFeeMemberSum_10_10" value="${cntFeeMemberSum_10_10+cntFee10_10}"></c:set>
			            <c:set var="cntFeeMemberSum_09_10" value="${cntFeeMemberSum_09_10+cntFee09_10}"></c:set>
			            <c:set var="cntFeeMemberSum_08_10" value="${cntFeeMemberSum_08_10+cntFee08_10}"></c:set>
			            <c:set var="cntFeeMemberSum_07_10" value="${cntFeeMemberSum_07_10+cntFee07_10}"></c:set>
			            <c:set var="cntFeeMemberSum_06_10" value="${cntFeeMemberSum_06_10+cntFee06_10}"></c:set>
			            <c:set var="cntFeeMemberSum_05_10" value="${cntFeeMemberSum_05_10+cntFee05_10}"></c:set>
			            <c:set var="cntFeeMemberSum_04_10" value="${cntFeeMemberSum_04_10+cntFee04_10}"></c:set>
			            <c:set var="cntFeeMemberSum_03_10" value="${cntFeeMemberSum_03_10+cntFee03_10}"></c:set>
			            <c:set var="cntFeeMemberSum_02_10" value="${cntFeeMemberSum_02_10+cntFee02_10}"></c:set>
			            <c:set var="cntFeeMemberSum_01_10" value="${cntFeeMemberSum_01_10+cntFee01_10}"></c:set>
			            
			            <!-- 직원별 계 평균용 변수 -->
						<c:set var="feeMemberSum_12_10" value="${feeMemberSum_12_10+fee12_10}"></c:set>
			            <c:set var="feeMemberSum_11_10" value="${feeMemberSum_11_10+fee11_10}"></c:set>
			            <c:set var="feeMemberSum_10_10" value="${feeMemberSum_10_10+fee10_10}"></c:set>
			            <c:set var="feeMemberSum_09_10" value="${feeMemberSum_09_10+fee09_10}"></c:set>
			            <c:set var="feeMemberSum_08_10" value="${feeMemberSum_08_10+fee08_10}"></c:set>
			            <c:set var="feeMemberSum_07_10" value="${feeMemberSum_07_10+fee07_10}"></c:set>
			            <c:set var="feeMemberSum_06_10" value="${feeMemberSum_06_10+fee06_10}"></c:set>
			            <c:set var="feeMemberSum_05_10" value="${feeMemberSum_05_10+fee05_10}"></c:set>
			            <c:set var="feeMemberSum_04_10" value="${feeMemberSum_04_10+fee04_10}"></c:set>
			            <c:set var="feeMemberSum_03_10" value="${feeMemberSum_03_10+fee03_10}"></c:set>
			            <c:set var="feeMemberSum_02_10" value="${feeMemberSum_02_10+fee02_10}"></c:set>
			            <c:set var="feeMemberSum_01_10" value="${feeMemberSum_01_10+fee01_10}"></c:set>
				    
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
	                    <c:set var="cntFeeMemberTotalSum_12_10" value="${cntFeeMemberTotalSum_12_10 + cntFee12_10}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_11_10" value="${cntFeeMemberTotalSum_11_10 + cntFee11_10}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_10_10" value="${cntFeeMemberTotalSum_10_10 + cntFee10_10}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_09_10" value="${cntFeeMemberTotalSum_09_10 + cntFee09_10}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_08_10" value="${cntFeeMemberTotalSum_08_10 + cntFee08_10}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_07_10" value="${cntFeeMemberTotalSum_07_10 + cntFee07_10}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_06_10" value="${cntFeeMemberTotalSum_06_10 + cntFee06_10}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_05_10" value="${cntFeeMemberTotalSum_05_10 + cntFee05_10}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_04_10" value="${cntFeeMemberTotalSum_04_10 + cntFee04_10}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_03_10" value="${cntFeeMemberTotalSum_03_10 + cntFee03_10}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_02_10" value="${cntFeeMemberTotalSum_02_10 + cntFee02_10}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_01_10" value="${cntFeeMemberTotalSum_01_10 + cntFee01_10}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="feeMemberTotalSum_12_10" value="${feeMemberTotalSum_12_10 + fee12_10}"></c:set>
	                    <c:set var="feeMemberTotalSum_11_10" value="${feeMemberTotalSum_11_10 + fee11_10}"></c:set>
	                    <c:set var="feeMemberTotalSum_10_10" value="${feeMemberTotalSum_10_10 + fee10_10}"></c:set>
	                    <c:set var="feeMemberTotalSum_09_10" value="${feeMemberTotalSum_09_10 + fee09_10}"></c:set>
	                    <c:set var="feeMemberTotalSum_08_10" value="${feeMemberTotalSum_08_10 + fee08_10}"></c:set>
	                    <c:set var="feeMemberTotalSum_07_10" value="${feeMemberTotalSum_07_10 + fee07_10}"></c:set>
	                    <c:set var="feeMemberTotalSum_06_10" value="${feeMemberTotalSum_06_10 + fee06_10}"></c:set>
	                    <c:set var="feeMemberTotalSum_05_10" value="${feeMemberTotalSum_05_10 + fee05_10}"></c:set>
	                    <c:set var="feeMemberTotalSum_04_10" value="${feeMemberTotalSum_04_10 + fee04_10}"></c:set>
	                    <c:set var="feeMemberTotalSum_03_10" value="${feeMemberTotalSum_03_10 + fee03_10}"></c:set>
	                    <c:set var="feeMemberTotalSum_02_10" value="${feeMemberTotalSum_02_10 + fee02_10}"></c:set>
	                    <c:set var="feeMemberTotalSum_01_10" value="${feeMemberTotalSum_01_10 + fee01_10}"></c:set>

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
		    					<c:when test="${feeMemberSum_12_10 eq 0 or endMemberSum_12_10 eq 0}">
		    						<c:set var="arvMemberSum_12_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_12_10" value="${feeMemberSum_12_10 / endMemberSum_12_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_11_10 eq 0 or endMemberSum_11_10 eq 0}">
		    						<c:set var="arvMemberSum_11_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_11_10" value="${feeMemberSum_11_10 / endMemberSum_11_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_10_10 eq 0 or endMemberSum_10_10 eq 0}">
		    						<c:set var="arvMemberSum_10_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_10_10" value="${feeMemberSum_10_10 / endMemberSum_10_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_09_10 eq 0 or endMemberSum_09_10 eq 0}">
		    						<c:set var="arvMemberSum_09_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_09_10" value="${feeMemberSum_09_10 / endMemberSum_09_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_08_10 eq 0 or endMemberSum_08_10 eq 0}">
		    						<c:set var="arvMemberSum_08_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_08_10" value="${feeMemberSum_08_10 / endMemberSum_08_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_07_10 eq 0 or endMemberSum_07_10 eq 0}">
		    						<c:set var="arvMemberSum_07_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_07_10" value="${feeMemberSum_07_10 / endMemberSum_07_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_06_10 eq 0 or endMemberSum_06_10 eq 0}">
		    						<c:set var="arvMemberSum_06_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_06_10" value="${feeMemberSum_06_10 / endMemberSum_06_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_05_10 eq 0 or endMemberSum_05_10 eq 0}">
		    						<c:set var="arvMemberSum_05_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_05_10" value="${feeMemberSum_05_10 / endMemberSum_05_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_04_10 eq 0 or endMemberSum_04_10 eq 0}">
		    						<c:set var="arvMemberSum_04_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_04_10" value="${feeMemberSum_04_10 / endMemberSum_04_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_03_10 eq 0 or endMemberSum_03_10 eq 0}">
		    						<c:set var="arvMemberSum_03_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_03_10" value="${feeMemberSum_03_10 / endMemberSum_03_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_02_10 eq 0 or endMemberSum_02_10 eq 0}">
		    						<c:set var="arvMemberSum_02_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_02_10" value="${feeMemberSum_02_10 / endMemberSum_02_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_01_10 eq 0 or endMemberSum_01_10 eq 0}">
		    						<c:set var="arvMemberSum_01_10" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_01_10" value="${feeMemberSum_01_10 / endMemberSum_01_10}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 직원별 평균 계산 끝 -->
		    						    				
		    				<!-- cntFee12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_12_10}" pattern="#,##0.##"/></td>
		    				<!-- cntFee11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_11_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_10_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_09_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_08_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_07_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_06_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_05_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_04_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_03_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_02_10}" pattern="#,##0.##"/></td>
			                <!-- cntFee01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_01_10}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="feeMemberColSum_10" value="${feeMemberSum_12_10 + feeMemberSum_11_10 + feeMemberSum_10_10 + feeMemberSum_09_10 + feeMemberSum_08_10 + feeMemberSum_07_10 + feeMemberSum_06_10 + feeMemberSum_05_10 + feeMemberSum_04_10 + feeMemberSum_03_10 + feeMemberSum_02_10 + feeMemberSum_01_10}"></c:set>
			                <c:set var="endMemberColSum_10" value="${endMemberSum_12_10 + endMemberSum_11_10 + endMemberSum_10_10 + endMemberSum_09_10 + endMemberSum_08_10 + endMemberSum_07_10 + endMemberSum_06_10 + endMemberSum_05_10 + endMemberSum_04_10 + endMemberSum_03_10 + endMemberSum_02_10 + endMemberSum_01_10}"></c:set>			                
			                <c:choose>
			                	<c:when test="${feeMemberColSum_10 eq 0 or endMemberColSum_10 eq 0}">
			                		<c:set var="arvMemberColSum_10" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvMemberColSum_10" value="${feeMemberColSum_10 / endMemberColSum_10}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberColSum_10}" pattern="#,##0.##"/></td>
		    				
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="cntFeeMemberSum_12_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_11_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_10_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_09_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_08_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_07_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_06_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_05_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_04_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_03_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_02_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_01_10" value="0"></c:set>
				            
				            <!-- 직원별 평균 계 초기화 -->
							<c:set var="feeMemberSum_12_10" value="0"></c:set>
							<c:set var="feeMemberSum_11_10" value="0"></c:set>
							<c:set var="feeMemberSum_10_10" value="0"></c:set>
							<c:set var="feeMemberSum_09_10" value="0"></c:set>
							<c:set var="feeMemberSum_08_10" value="0"></c:set>
							<c:set var="feeMemberSum_07_10" value="0"></c:set>
							<c:set var="feeMemberSum_06_10" value="0"></c:set>
							<c:set var="feeMemberSum_05_10" value="0"></c:set>
							<c:set var="feeMemberSum_04_10" value="0"></c:set>
							<c:set var="feeMemberSum_03_10" value="0"></c:set>
							<c:set var="feeMemberSum_02_10" value="0"></c:set>
							<c:set var="feeMemberSum_01_10" value="0"></c:set>
											    
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
				            <c:set var="cntFeeMemberSum_12_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_11_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_10_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_09_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_08_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_07_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_06_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_05_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_04_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_03_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_02_10" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_01_10" value="0"></c:set>
				            
				            <!-- 직원별 평균 계 초기화 -->
							<c:set var="feeMemberSum_12_10" value="0"></c:set>
							<c:set var="feeMemberSum_11_10" value="0"></c:set>
							<c:set var="feeMemberSum_10_10" value="0"></c:set>
							<c:set var="feeMemberSum_09_10" value="0"></c:set>
							<c:set var="feeMemberSum_08_10" value="0"></c:set>
							<c:set var="feeMemberSum_07_10" value="0"></c:set>
							<c:set var="feeMemberSum_06_10" value="0"></c:set>
							<c:set var="feeMemberSum_05_10" value="0"></c:set>
							<c:set var="feeMemberSum_04_10" value="0"></c:set>
							<c:set var="feeMemberSum_03_10" value="0"></c:set>
							<c:set var="feeMemberSum_02_10" value="0"></c:set>
							<c:set var="feeMemberSum_01_10" value="0"></c:set>
											    
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
		    	<c:if test="${ptnrStatCntFeeList_10.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 심사 평균</th>
	                <c:choose>
    					<c:when test="${feeMemberTotalSum_12_10 eq 0 or endMemberTotalSum_12_10 eq 0}">
    						<c:set var="arvMemberTotalSum_12_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_12_10" value="${feeMemberTotalSum_12_10 / endMemberTotalSum_12_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_11_10 eq 0 or endMemberTotalSum_11_10 eq 0}">
    						<c:set var="arvMemberTotalSum_11_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_11_10" value="${feeMemberTotalSum_11_10 / endMemberTotalSum_11_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_10_10 eq 0 or endMemberTotalSum_10_10 eq 0}">
    						<c:set var="arvMemberTotalSum_10_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_10_10" value="${feeMemberTotalSum_10_10 / endMemberTotalSum_10_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_09_10 eq 0 or endMemberTotalSum_09_10 eq 0}">
    						<c:set var="arvMemberTotalSum_09_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_09_10" value="${feeMemberTotalSum_09_10 / endMemberTotalSum_09_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_08_10 eq 0 or endMemberTotalSum_08_10 eq 0}">
    						<c:set var="arvMemberTotalSum_08_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_08_10" value="${feeMemberTotalSum_08_10 / endMemberTotalSum_08_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_07_10 eq 0 or endMemberTotalSum_07_10 eq 0}">
    						<c:set var="arvMemberTotalSum_07_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_07_10" value="${feeMemberTotalSum_07_10 / endMemberTotalSum_07_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_06_10 eq 0 or endMemberTotalSum_06_10 eq 0}">
    						<c:set var="arvMemberTotalSum_06_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_06_10" value="${feeMemberTotalSum_06_10 / endMemberTotalSum_06_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_05_10 eq 0 or endMemberTotalSum_05_10 eq 0}">
    						<c:set var="arvMemberTotalSum_05_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_05_10" value="${feeMemberTotalSum_05_10 / endMemberTotalSum_05_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_04_10 eq 0 or endMemberTotalSum_04_10 eq 0}">
    						<c:set var="arvMemberTotalSum_04_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_04_10" value="${feeMemberTotalSum_04_10 / endMemberTotalSum_04_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_03_10 eq 0 or endMemberTotalSum_03_10 eq 0}">
    						<c:set var="arvMemberTotalSum_03_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_03_10" value="${feeMemberTotalSum_03_10 / endMemberTotalSum_03_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_02_10 eq 0 or endMemberTotalSum_02_10 eq 0}">
    						<c:set var="arvMemberTotalSum_02_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_02_10" value="${feeMemberTotalSum_02_10 / endMemberTotalSum_02_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_01_10 eq 0 or endMemberTotalSum_01_10 eq 0}">
    						<c:set var="arvMemberTotalSum_01_10" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_01_10" value="${feeMemberTotalSum_01_10 / endMemberTotalSum_01_10}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 직원별 평균 계산 끝 -->
    						    				
    				<!-- cntFee12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_12_10}" pattern="#,##0.##"/></th>
    				<!-- cntFee11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_11_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_10_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_09_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_08_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_07_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_06_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_05_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_04_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_03_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_02_10}" pattern="#,##0.##"/></th>
	                <!-- cntFee01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_01_10}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="feeColMemberTotalSum_10" value="${feeMemberTotalSum_12_10 + feeMemberTotalSum_11_10 + feeMemberTotalSum_10_10 + feeMemberTotalSum_09_10 + feeMemberTotalSum_08_10 + feeMemberTotalSum_07_10 + feeMemberTotalSum_06_10 + feeMemberTotalSum_05_10 + feeMemberTotalSum_04_10 + feeMemberTotalSum_03_10 + feeMemberTotalSum_02_10 + feeMemberTotalSum_01_10}"></c:set>
	                <c:set var="endColMemberTotalSum_10" value="${endMemberTotalSum_12_10 + endMemberTotalSum_11_10 + endMemberTotalSum_10_10 + endMemberTotalSum_09_10 + endMemberTotalSum_08_10 + endMemberTotalSum_07_10 + endMemberTotalSum_06_10 + endMemberTotalSum_05_10 + endMemberTotalSum_04_10 + endMemberTotalSum_03_10 + endMemberTotalSum_02_10 + endMemberTotalSum_01_10}"></c:set>
					<c:choose>
	                	<c:when test="${feeColMemberTotalSum_10 eq 0 or endColMemberTotalSum_10 eq 0}">
	                		<c:set var="arvColMemberTotalSum_10" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColMemberTotalSum_10" value="${feeColMemberTotalSum_10 / endColMemberTotalSum_10}"/>
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
	            <c:set var="cntFeeMemberSum_12_15" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_11_15" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_10_15" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_09_15" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_08_15" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_07_15" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_06_15" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_05_15" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_04_15" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_03_15" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_02_15" value="0"></c:set>
	            <c:set var="cntFeeMemberSum_01_15" value="0"></c:set>
	            
	            <!-- 직원별 평균 계 초기화 -->
				<c:set var="feeMemberSum_12_15" value="0"></c:set>
				<c:set var="feeMemberSum_11_15" value="0"></c:set>
				<c:set var="feeMemberSum_10_15" value="0"></c:set>
				<c:set var="feeMemberSum_09_15" value="0"></c:set>
				<c:set var="feeMemberSum_08_15" value="0"></c:set>
				<c:set var="feeMemberSum_07_15" value="0"></c:set>
				<c:set var="feeMemberSum_06_15" value="0"></c:set>
				<c:set var="feeMemberSum_05_15" value="0"></c:set>
				<c:set var="feeMemberSum_04_15" value="0"></c:set>
				<c:set var="feeMemberSum_03_15" value="0"></c:set>
				<c:set var="feeMemberSum_02_15" value="0"></c:set>
				<c:set var="feeMemberSum_01_15" value="0"></c:set>
								    
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
	            <c:set var="cntFeeMemberTotalSum_12_15" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_11_15" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_10_15" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_09_15" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_08_15" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_07_15" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_06_15" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_05_15" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_04_15" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_03_15" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_02_15" value="0"></c:set>
	            <c:set var="cntFeeMemberTotalSum_01_15" value="0"></c:set>	            
	            
	            <!-- Type 별 가로열 합계 -->
	            <c:set var="cntFeeColMemberTotalSum_15" value="0"></c:set>
	            
	            <!-- Type별 평균용 변수 초기화 -->
				<c:set var="feeMemberTotalSum_12_15" value="0"></c:set>
				<c:set var="feeMemberTotalSum_11_15" value="0"></c:set>
				<c:set var="feeMemberTotalSum_10_15" value="0"></c:set>
				<c:set var="feeMemberTotalSum_09_15" value="0"></c:set>
				<c:set var="feeMemberTotalSum_08_15" value="0"></c:set>
				<c:set var="feeMemberTotalSum_07_15" value="0"></c:set>
				<c:set var="feeMemberTotalSum_06_15" value="0"></c:set>
				<c:set var="feeMemberTotalSum_05_15" value="0"></c:set>
				<c:set var="feeMemberTotalSum_04_15" value="0"></c:set>
				<c:set var="feeMemberTotalSum_03_15" value="0"></c:set>
				<c:set var="feeMemberTotalSum_02_15" value="0"></c:set>
				<c:set var="feeMemberTotalSum_01_15" value="0"></c:set>
				
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
   				    			
    			<c:forEach var="vo2" items="${ptnrStatCntFeeList_15}" varStatus="status">    				    				
		    		<tr>
		    			<c:if test="${status.index == 0}">
		                    <c:choose>
		                    	<c:when test='${srchArg.tabMenu eq "team"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterCntFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
				                    	1종 기타
				                    </td>
		    					</c:when>
		    					<c:when test='${srchArg.tabMenu eq "member"}'>
		    						<td onclick="goPtnrStatMenu('ptnrStatCenterCntFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
				                    	1종 기타
				                    </td>
		    					</c:when>
		    					<c:otherwise>
		    						<td onclick="goPtnrStatMenu('ptnrStatTeamCntFee');" style="width: 80px;bgcolor: #E7ECF1; text-align: center; cursor: pointer;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" rowspan="${leftRow_15}">
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
					            <c:set var="cntFeeMemberSum_12_15" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_11_15" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_10_15" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_09_15" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_08_15" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_07_15" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_06_15" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_05_15" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_04_15" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_03_15" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_02_15" value="0"></c:set>
					            <c:set var="cntFeeMemberSum_01_15" value="0"></c:set>
					            
					            <!-- 직원별 평균 계 초기화 -->
								<c:set var="feeMemberSum_12_15" value="0"></c:set>
								<c:set var="feeMemberSum_11_15" value="0"></c:set>
								<c:set var="feeMemberSum_10_15" value="0"></c:set>
								<c:set var="feeMemberSum_09_15" value="0"></c:set>
								<c:set var="feeMemberSum_08_15" value="0"></c:set>
								<c:set var="feeMemberSum_07_15" value="0"></c:set>
								<c:set var="feeMemberSum_06_15" value="0"></c:set>
								<c:set var="feeMemberSum_05_15" value="0"></c:set>
								<c:set var="feeMemberSum_04_15" value="0"></c:set>
								<c:set var="feeMemberSum_03_15" value="0"></c:set>
								<c:set var="feeMemberSum_02_15" value="0"></c:set>
								<c:set var="feeMemberSum_01_15" value="0"></c:set>
												    
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
		                
		                <!-- 직원별 계 합산 -->
	    				<c:set var="cntFeeMemberSum_12_15" value="${cntFeeMemberSum_12_15+cntFee12_15}"></c:set>
			            <c:set var="cntFeeMemberSum_11_15" value="${cntFeeMemberSum_11_15+cntFee11_15}"></c:set>
			            <c:set var="cntFeeMemberSum_10_15" value="${cntFeeMemberSum_10_15+cntFee10_15}"></c:set>
			            <c:set var="cntFeeMemberSum_09_15" value="${cntFeeMemberSum_09_15+cntFee09_15}"></c:set>
			            <c:set var="cntFeeMemberSum_08_15" value="${cntFeeMemberSum_08_15+cntFee08_15}"></c:set>
			            <c:set var="cntFeeMemberSum_07_15" value="${cntFeeMemberSum_07_15+cntFee07_15}"></c:set>
			            <c:set var="cntFeeMemberSum_06_15" value="${cntFeeMemberSum_06_15+cntFee06_15}"></c:set>
			            <c:set var="cntFeeMemberSum_05_15" value="${cntFeeMemberSum_05_15+cntFee05_15}"></c:set>
			            <c:set var="cntFeeMemberSum_04_15" value="${cntFeeMemberSum_04_15+cntFee04_15}"></c:set>
			            <c:set var="cntFeeMemberSum_03_15" value="${cntFeeMemberSum_03_15+cntFee03_15}"></c:set>
			            <c:set var="cntFeeMemberSum_02_15" value="${cntFeeMemberSum_02_15+cntFee02_15}"></c:set>
			            <c:set var="cntFeeMemberSum_01_15" value="${cntFeeMemberSum_01_15+cntFee01_15}"></c:set>
			            
			            <!-- 직원별 계 평균용 변수 -->
						<c:set var="feeMemberSum_12_15" value="${feeMemberSum_12_15+fee12_15}"></c:set>
			            <c:set var="feeMemberSum_11_15" value="${feeMemberSum_11_15+fee11_15}"></c:set>
			            <c:set var="feeMemberSum_10_15" value="${feeMemberSum_10_15+fee10_15}"></c:set>
			            <c:set var="feeMemberSum_09_15" value="${feeMemberSum_09_15+fee09_15}"></c:set>
			            <c:set var="feeMemberSum_08_15" value="${feeMemberSum_08_15+fee08_15}"></c:set>
			            <c:set var="feeMemberSum_07_15" value="${feeMemberSum_07_15+fee07_15}"></c:set>
			            <c:set var="feeMemberSum_06_15" value="${feeMemberSum_06_15+fee06_15}"></c:set>
			            <c:set var="feeMemberSum_05_15" value="${feeMemberSum_05_15+fee05_15}"></c:set>
			            <c:set var="feeMemberSum_04_15" value="${feeMemberSum_04_15+fee04_15}"></c:set>
			            <c:set var="feeMemberSum_03_15" value="${feeMemberSum_03_15+fee03_15}"></c:set>
			            <c:set var="feeMemberSum_02_15" value="${feeMemberSum_02_15+fee02_15}"></c:set>
			            <c:set var="feeMemberSum_01_15" value="${feeMemberSum_01_15+fee01_15}"></c:set>
				    
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
	                    <c:set var="cntFeeMemberTotalSum_12_15" value="${cntFeeMemberTotalSum_12_15 + cntFee12_15}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_11_15" value="${cntFeeMemberTotalSum_11_15 + cntFee11_15}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_10_15" value="${cntFeeMemberTotalSum_10_15 + cntFee10_15}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_09_15" value="${cntFeeMemberTotalSum_09_15 + cntFee09_15}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_08_15" value="${cntFeeMemberTotalSum_08_15 + cntFee08_15}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_07_15" value="${cntFeeMemberTotalSum_07_15 + cntFee07_15}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_06_15" value="${cntFeeMemberTotalSum_06_15 + cntFee06_15}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_05_15" value="${cntFeeMemberTotalSum_05_15 + cntFee05_15}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_04_15" value="${cntFeeMemberTotalSum_04_15 + cntFee04_15}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_03_15" value="${cntFeeMemberTotalSum_03_15 + cntFee03_15}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_02_15" value="${cntFeeMemberTotalSum_02_15 + cntFee02_15}"></c:set>
	                    <c:set var="cntFeeMemberTotalSum_01_15" value="${cntFeeMemberTotalSum_01_15 + cntFee01_15}"></c:set>
	                    
	                    <!-- Type발 평균용 변수 -->
						<c:set var="feeMemberTotalSum_12_15" value="${feeMemberTotalSum_12_15 + fee12_15}"></c:set>
	                    <c:set var="feeMemberTotalSum_11_15" value="${feeMemberTotalSum_11_15 + fee11_15}"></c:set>
	                    <c:set var="feeMemberTotalSum_10_15" value="${feeMemberTotalSum_10_15 + fee10_15}"></c:set>
	                    <c:set var="feeMemberTotalSum_09_15" value="${feeMemberTotalSum_09_15 + fee09_15}"></c:set>
	                    <c:set var="feeMemberTotalSum_08_15" value="${feeMemberTotalSum_08_15 + fee08_15}"></c:set>
	                    <c:set var="feeMemberTotalSum_07_15" value="${feeMemberTotalSum_07_15 + fee07_15}"></c:set>
	                    <c:set var="feeMemberTotalSum_06_15" value="${feeMemberTotalSum_06_15 + fee06_15}"></c:set>
	                    <c:set var="feeMemberTotalSum_05_15" value="${feeMemberTotalSum_05_15 + fee05_15}"></c:set>
	                    <c:set var="feeMemberTotalSum_04_15" value="${feeMemberTotalSum_04_15 + fee04_15}"></c:set>
	                    <c:set var="feeMemberTotalSum_03_15" value="${feeMemberTotalSum_03_15 + fee03_15}"></c:set>
	                    <c:set var="feeMemberTotalSum_02_15" value="${feeMemberTotalSum_02_15 + fee02_15}"></c:set>
	                    <c:set var="feeMemberTotalSum_01_15" value="${feeMemberTotalSum_01_15 + fee01_15}"></c:set>

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
		    					<c:when test="${feeMemberSum_12_15 eq 0 or endMemberSum_12_15 eq 0}">
		    						<c:set var="arvMemberSum_12_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_12_15" value="${feeMemberSum_12_15 / endMemberSum_12_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_11_15 eq 0 or endMemberSum_11_15 eq 0}">
		    						<c:set var="arvMemberSum_11_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_11_15" value="${feeMemberSum_11_15 / endMemberSum_11_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_10_15 eq 0 or endMemberSum_10_15 eq 0}">
		    						<c:set var="arvMemberSum_10_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_10_15" value="${feeMemberSum_10_15 / endMemberSum_10_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_09_15 eq 0 or endMemberSum_09_15 eq 0}">
		    						<c:set var="arvMemberSum_09_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_09_15" value="${feeMemberSum_09_15 / endMemberSum_09_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_08_15 eq 0 or endMemberSum_08_15 eq 0}">
		    						<c:set var="arvMemberSum_08_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_08_15" value="${feeMemberSum_08_15 / endMemberSum_08_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_07_15 eq 0 or endMemberSum_07_15 eq 0}">
		    						<c:set var="arvMemberSum_07_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_07_15" value="${feeMemberSum_07_15 / endMemberSum_07_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_06_15 eq 0 or endMemberSum_06_15 eq 0}">
		    						<c:set var="arvMemberSum_06_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_06_15" value="${feeMemberSum_06_15 / endMemberSum_06_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_05_15 eq 0 or endMemberSum_05_15 eq 0}">
		    						<c:set var="arvMemberSum_05_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_05_15" value="${feeMemberSum_05_15 / endMemberSum_05_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_04_15 eq 0 or endMemberSum_04_15 eq 0}">
		    						<c:set var="arvMemberSum_04_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_04_15" value="${feeMemberSum_04_15 / endMemberSum_04_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_03_15 eq 0 or endMemberSum_03_15 eq 0}">
		    						<c:set var="arvMemberSum_03_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_03_15" value="${feeMemberSum_03_15 / endMemberSum_03_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_02_15 eq 0 or endMemberSum_02_15 eq 0}">
		    						<c:set var="arvMemberSum_02_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_02_15" value="${feeMemberSum_02_15 / endMemberSum_02_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<c:choose>
		    					<c:when test="${feeMemberSum_01_15 eq 0 or endMemberSum_01_15 eq 0}">
		    						<c:set var="arvMemberSum_01_15" value="0"></c:set>
		    					</c:when>
		    					<c:otherwise>
		    						<c:set var="arvMemberSum_01_15" value="${feeMemberSum_01_15 / endMemberSum_01_15}"></c:set>
		    					</c:otherwise>
		    				</c:choose>
		    				<!-- 직원별 평균 계산 끝 -->
		    						    				
		    				<!-- cntFee12 -->
		    				<td style="width: 75px;text-align:right;padding-right:5px; border-left:0.2em solid #b9b9b9 !important;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_12_15}" pattern="#,##0.##"/></td>
		    				<!-- cntFee11 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_11_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee10 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_10_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee09 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_09_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee08 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_08_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee07 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_07_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee06 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_06_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee05 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_05_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee04 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_04_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee03 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_03_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee02 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_02_15}" pattern="#,##0.##"/></td>
			                <!-- cntFee01 -->
			                <td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberSum_01_15}" pattern="#,##0.##"/></td>
		    				<!-- 가로 합계 -->
			                <c:set var="feeMemberColSum_15" value="${feeMemberSum_12_15 + feeMemberSum_11_15 + feeMemberSum_10_15 + feeMemberSum_09_15 + feeMemberSum_08_15 + feeMemberSum_07_15 + feeMemberSum_06_15 + feeMemberSum_05_15 + feeMemberSum_04_15 + feeMemberSum_03_15 + feeMemberSum_02_15 + feeMemberSum_01_15}"></c:set>
			                <c:set var="endMemberColSum_15" value="${endMemberSum_12_15 + endMemberSum_11_15 + endMemberSum_10_15 + endMemberSum_09_15 + endMemberSum_08_15 + endMemberSum_07_15 + endMemberSum_06_15 + endMemberSum_05_15 + endMemberSum_04_15 + endMemberSum_03_15 + endMemberSum_02_15 + endMemberSum_01_15}"></c:set>			                
			                <c:choose>
			                	<c:when test="${feeMemberColSum_15 eq 0 or endMemberColSum_15 eq 0}">
			                		<c:set var="arvMemberColSum_15" value="0"/>
			                	</c:when>
			                	<c:otherwise>
			                		<c:set var="arvMemberColSum_15" value="${feeMemberColSum_15 / endMemberColSum_15}"/>
			                	</c:otherwise>
			                </c:choose>
			                
		    				<td style="width: 75px;text-align:right;padding-right:5px;" class="sum-level-2"><fmt:formatNumber value="${arvMemberColSum_15}" pattern="#,##0.##"/></td>
		    				
							<!-- 직원별 계 카운트 초기화 -->
		    				<c:set var="memberCnt" value="1"></c:set>										                		    				
		    				<!-- 직원별 계 초기화 -->
				            <c:set var="cntFeeMemberSum_12_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_11_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_10_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_09_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_08_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_07_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_06_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_05_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_04_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_03_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_02_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_01_15" value="0"></c:set>
				            
				            <!-- 직원별 평균 계 초기화 -->
							<c:set var="feeMemberSum_12_15" value="0"></c:set>
							<c:set var="feeMemberSum_11_15" value="0"></c:set>
							<c:set var="feeMemberSum_10_15" value="0"></c:set>
							<c:set var="feeMemberSum_09_15" value="0"></c:set>
							<c:set var="feeMemberSum_08_15" value="0"></c:set>
							<c:set var="feeMemberSum_07_15" value="0"></c:set>
							<c:set var="feeMemberSum_06_15" value="0"></c:set>
							<c:set var="feeMemberSum_05_15" value="0"></c:set>
							<c:set var="feeMemberSum_04_15" value="0"></c:set>
							<c:set var="feeMemberSum_03_15" value="0"></c:set>
							<c:set var="feeMemberSum_02_15" value="0"></c:set>
							<c:set var="feeMemberSum_01_15" value="0"></c:set>
											    
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
				            <c:set var="cntFeeMemberSum_12_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_11_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_10_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_09_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_08_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_07_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_06_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_05_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_04_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_03_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_02_15" value="0"></c:set>
				            <c:set var="cntFeeMemberSum_01_15" value="0"></c:set>
				            
				            <!-- 직원별 평균 계 초기화 -->
							<c:set var="feeMemberSum_12_15" value="0"></c:set>
							<c:set var="feeMemberSum_11_15" value="0"></c:set>
							<c:set var="feeMemberSum_10_15" value="0"></c:set>
							<c:set var="feeMemberSum_09_15" value="0"></c:set>
							<c:set var="feeMemberSum_08_15" value="0"></c:set>
							<c:set var="feeMemberSum_07_15" value="0"></c:set>
							<c:set var="feeMemberSum_06_15" value="0"></c:set>
							<c:set var="feeMemberSum_05_15" value="0"></c:set>
							<c:set var="feeMemberSum_04_15" value="0"></c:set>
							<c:set var="feeMemberSum_03_15" value="0"></c:set>
							<c:set var="feeMemberSum_02_15" value="0"></c:set>
							<c:set var="feeMemberSum_01_15" value="0"></c:set>
											    
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
		    	<c:if test="${ptnrStatCntFeeList_15.size() > 0 }">
		    	<tr bgcolor="#E7ECF1">
	                <th colspan="3" style="height:25px;">1종 기타 평균</th>
	                <c:choose>
    					<c:when test="${feeMemberTotalSum_12_15 eq 0 or endMemberTotalSum_12_15 eq 0}">
    						<c:set var="arvMemberTotalSum_12_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_12_15" value="${feeMemberTotalSum_12_15 / endMemberTotalSum_12_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_11_15 eq 0 or endMemberTotalSum_11_15 eq 0}">
    						<c:set var="arvMemberTotalSum_11_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_11_15" value="${feeMemberTotalSum_11_15 / endMemberTotalSum_11_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_10_15 eq 0 or endMemberTotalSum_10_15 eq 0}">
    						<c:set var="arvMemberTotalSum_10_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_10_15" value="${feeMemberTotalSum_10_15 / endMemberTotalSum_10_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_09_15 eq 0 or endMemberTotalSum_09_15 eq 0}">
    						<c:set var="arvMemberTotalSum_09_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_09_15" value="${feeMemberTotalSum_09_15 / endMemberTotalSum_09_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_08_15 eq 0 or endMemberTotalSum_08_15 eq 0}">
    						<c:set var="arvMemberTotalSum_08_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_08_15" value="${feeMemberTotalSum_08_15 / endMemberTotalSum_08_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_07_15 eq 0 or endMemberTotalSum_07_15 eq 0}">
    						<c:set var="arvMemberTotalSum_07_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_07_15" value="${feeMemberTotalSum_07_15 / endMemberTotalSum_07_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_06_15 eq 0 or endMemberTotalSum_06_15 eq 0}">
    						<c:set var="arvMemberTotalSum_06_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_06_15" value="${feeMemberTotalSum_06_15 / endMemberTotalSum_06_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_05_15 eq 0 or endMemberTotalSum_05_15 eq 0}">
    						<c:set var="arvMemberTotalSum_05_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_05_15" value="${feeMemberTotalSum_05_15 / endMemberTotalSum_05_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_04_15 eq 0 or endMemberTotalSum_04_15 eq 0}">
    						<c:set var="arvMemberTotalSum_04_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_04_15" value="${feeMemberTotalSum_04_15 / endMemberTotalSum_04_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_03_15 eq 0 or endMemberTotalSum_03_15 eq 0}">
    						<c:set var="arvMemberTotalSum_03_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_03_15" value="${feeMemberTotalSum_03_15 / endMemberTotalSum_03_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_02_15 eq 0 or endMemberTotalSum_02_15 eq 0}">
    						<c:set var="arvMemberTotalSum_02_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_02_15" value="${feeMemberTotalSum_02_15 / endMemberTotalSum_02_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<c:choose>
    					<c:when test="${feeMemberTotalSum_01_15 eq 0 or endMemberTotalSum_01_15 eq 0}">
    						<c:set var="arvMemberTotalSum_01_15" value="0"></c:set>
    					</c:when>
    					<c:otherwise>
    						<c:set var="arvMemberTotalSum_01_15" value="${feeMemberTotalSum_01_15 / endMemberTotalSum_01_15}"></c:set>
    					</c:otherwise>
    				</c:choose>
    				<!-- 직원별 평균 계산 끝 -->
    						    				
    				<!-- cntFee12 -->
    				<th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_12_15}" pattern="#,##0.##"/></th>
    				<!-- cntFee11 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_11_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee10 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_10_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee09 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_09_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee08 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_08_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee07 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_07_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee06 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_06_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee05 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_05_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee04 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_04_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee03 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_03_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee02 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_02_15}" pattern="#,##0.##"/></th>
	                <!-- cntFee01 -->
	                <th style="width: 75px;text-align:right;padding-right:5px;"><fmt:formatNumber value="${arvMemberTotalSum_01_15}" pattern="#,##0.##"/></th>
    				<!-- 가로 합계 -->
	                <c:set var="feeColMemberTotalSum_15" value="${feeMemberTotalSum_12_15 + feeMemberTotalSum_11_15 + feeMemberTotalSum_10_15 + feeMemberTotalSum_09_15 + feeMemberTotalSum_08_15 + feeMemberTotalSum_07_15 + feeMemberTotalSum_06_15 + feeMemberTotalSum_05_15 + feeMemberTotalSum_04_15 + feeMemberTotalSum_03_15 + feeMemberTotalSum_02_15 + feeMemberTotalSum_01_15}"></c:set>
	                <c:set var="endColMemberTotalSum_15" value="${endMemberTotalSum_12_15 + endMemberTotalSum_11_15 + endMemberTotalSum_10_15 + endMemberTotalSum_09_15 + endMemberTotalSum_08_15 + endMemberTotalSum_07_15 + endMemberTotalSum_06_15 + endMemberTotalSum_05_15 + endMemberTotalSum_04_15 + endMemberTotalSum_03_15 + endMemberTotalSum_02_15 + endMemberTotalSum_01_15}"></c:set>
					<c:choose>
	                	<c:when test="${feeColMemberTotalSum_15 eq 0 or endColMemberTotalSum_15 eq 0}">
	                		<c:set var="arvColMemberTotalSum_15" value="0"/>
	                	</c:when>
	                	<c:otherwise>
	                		<c:set var="arvColMemberTotalSum_15" value="${feeColMemberTotalSum_15 / endColMemberTotalSum_15}"/>
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
    <c:set var="cntFeeMemberTotalSum_12_all" value="${cntFeeMemberTotalSum_12_5 + cntFeeMemberTotalSum_12_10 + cntFeeMemberTotalSum_12_15}"></c:set>
    <c:set var="cntFeeMemberTotalSum_11_all" value="${cntFeeMemberTotalSum_11_5 + cntFeeMemberTotalSum_11_10 + cntFeeMemberTotalSum_11_15}"></c:set>
    <c:set var="cntFeeMemberTotalSum_10_all" value="${cntFeeMemberTotalSum_10_5 + cntFeeMemberTotalSum_10_10 + cntFeeMemberTotalSum_10_15}"></c:set>
    <c:set var="cntFeeMemberTotalSum_09_all" value="${cntFeeMemberTotalSum_09_5 + cntFeeMemberTotalSum_09_10 + cntFeeMemberTotalSum_09_15}"></c:set>
    <c:set var="cntFeeMemberTotalSum_08_all" value="${cntFeeMemberTotalSum_08_5 + cntFeeMemberTotalSum_08_10 + cntFeeMemberTotalSum_08_15}"></c:set>
    <c:set var="cntFeeMemberTotalSum_07_all" value="${cntFeeMemberTotalSum_07_5 + cntFeeMemberTotalSum_07_10 + cntFeeMemberTotalSum_07_15}"></c:set>
    <c:set var="cntFeeMemberTotalSum_06_all" value="${cntFeeMemberTotalSum_06_5 + cntFeeMemberTotalSum_06_10 + cntFeeMemberTotalSum_06_15}"></c:set>
    <c:set var="cntFeeMemberTotalSum_05_all" value="${cntFeeMemberTotalSum_05_5 + cntFeeMemberTotalSum_05_10 + cntFeeMemberTotalSum_05_15}"></c:set>
    <c:set var="cntFeeMemberTotalSum_04_all" value="${cntFeeMemberTotalSum_04_5 + cntFeeMemberTotalSum_04_10 + cntFeeMemberTotalSum_04_15}"></c:set>
    <c:set var="cntFeeMemberTotalSum_03_all" value="${cntFeeMemberTotalSum_03_5 + cntFeeMemberTotalSum_03_10 + cntFeeMemberTotalSum_03_15}"></c:set>
    <c:set var="cntFeeMemberTotalSum_02_all" value="${cntFeeMemberTotalSum_02_5 + cntFeeMemberTotalSum_02_10 + cntFeeMemberTotalSum_02_15}"></c:set>
    <c:set var="cntFeeMemberTotalSum_01_all" value="${cntFeeMemberTotalSum_01_5 + cntFeeMemberTotalSum_01_10 + cntFeeMemberTotalSum_01_15}"></c:set>        
    <c:set var="cntFeeMemberTotalSum_col_all" value="${cntFeeMemberTotalSum_12_all + cntFeeMemberTotalSum_11_all + cntFeeMemberTotalSum_10_all + cntFeeMemberTotalSum_09_all + cntFeeMemberTotalSum_08_all + cntFeeMemberTotalSum_07_all + cntFeeMemberTotalSum_06_all + cntFeeMemberTotalSum_05_all + cntFeeMemberTotalSum_04_all + cntFeeMemberTotalSum_03_all + cntFeeMemberTotalSum_02_all + cntFeeMemberTotalSum_01_all}"></c:set>
    
    <c:set var="feeMemberTotalSum_12_all" value="${feeMemberTotalSum_12_5 + feeMemberTotalSum_12_10 + feeMemberTotalSum_12_15}"></c:set>
    <c:set var="feeMemberTotalSum_11_all" value="${feeMemberTotalSum_11_5 + feeMemberTotalSum_11_10 + feeMemberTotalSum_11_15}"></c:set>
    <c:set var="feeMemberTotalSum_10_all" value="${feeMemberTotalSum_10_5 + feeMemberTotalSum_10_10 + feeMemberTotalSum_10_15}"></c:set>
    <c:set var="feeMemberTotalSum_09_all" value="${feeMemberTotalSum_09_5 + feeMemberTotalSum_09_10 + feeMemberTotalSum_09_15}"></c:set>
    <c:set var="feeMemberTotalSum_08_all" value="${feeMemberTotalSum_08_5 + feeMemberTotalSum_08_10 + feeMemberTotalSum_08_15}"></c:set>
    <c:set var="feeMemberTotalSum_07_all" value="${feeMemberTotalSum_07_5 + feeMemberTotalSum_07_10 + feeMemberTotalSum_07_15}"></c:set>
    <c:set var="feeMemberTotalSum_06_all" value="${feeMemberTotalSum_06_5 + feeMemberTotalSum_06_10 + feeMemberTotalSum_06_15}"></c:set>
    <c:set var="feeMemberTotalSum_05_all" value="${feeMemberTotalSum_05_5 + feeMemberTotalSum_05_10 + feeMemberTotalSum_05_15}"></c:set>
    <c:set var="feeMemberTotalSum_04_all" value="${feeMemberTotalSum_04_5 + feeMemberTotalSum_04_10 + feeMemberTotalSum_04_15}"></c:set>
    <c:set var="feeMemberTotalSum_03_all" value="${feeMemberTotalSum_03_5 + feeMemberTotalSum_03_10 + feeMemberTotalSum_03_15}"></c:set>
    <c:set var="feeMemberTotalSum_02_all" value="${feeMemberTotalSum_02_5 + feeMemberTotalSum_02_10 + feeMemberTotalSum_02_15}"></c:set>
    <c:set var="feeMemberTotalSum_01_all" value="${feeMemberTotalSum_01_5 + feeMemberTotalSum_01_10 + feeMemberTotalSum_01_15}"></c:set>
    
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
		<c:when test="${feeMemberTotalSum_12_all eq 0 or endMemberTotalSum_12_all eq 0}">
			<c:set var="arvMemberTotalSum_12_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_12_all" value="${feeMemberTotalSum_12_all / endMemberTotalSum_12_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeMemberTotalSum_11_all eq 0 or endMemberTotalSum_11_all eq 0}">
			<c:set var="arvMemberTotalSum_11_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_11_all" value="${feeMemberTotalSum_11_all / endMemberTotalSum_11_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeMemberTotalSum_10_all eq 0 or endMemberTotalSum_10_all eq 0}">
			<c:set var="arvMemberTotalSum_10_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_10_all" value="${feeMemberTotalSum_10_all / endMemberTotalSum_10_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeMemberTotalSum_09_all eq 0 or endMemberTotalSum_09_all eq 0}">
			<c:set var="arvMemberTotalSum_09_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_09_all" value="${feeMemberTotalSum_09_all / endMemberTotalSum_09_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeMemberTotalSum_08_all eq 0 or endMemberTotalSum_08_all eq 0}">
			<c:set var="arvMemberTotalSum_08_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_08_all" value="${feeMemberTotalSum_08_all / endMemberTotalSum_08_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeMemberTotalSum_07_all eq 0 or endMemberTotalSum_07_all eq 0}">
			<c:set var="arvMemberTotalSum_07_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_07_all" value="${feeMemberTotalSum_07_all / endMemberTotalSum_07_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeMemberTotalSum_06_all eq 0 or endMemberTotalSum_06_all eq 0}">
			<c:set var="arvMemberTotalSum_06_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_06_all" value="${feeMemberTotalSum_06_all / endMemberTotalSum_06_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeMemberTotalSum_05_all eq 0 or endMemberTotalSum_05_all eq 0}">
			<c:set var="arvMemberTotalSum_05_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_05_all" value="${feeMemberTotalSum_05_all / endMemberTotalSum_05_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeMemberTotalSum_04_all eq 0 or endMemberTotalSum_04_all eq 0}">
			<c:set var="arvMemberTotalSum_04_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_04_all" value="${feeMemberTotalSum_04_all / endMemberTotalSum_04_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeMemberTotalSum_03_all eq 0 or endMemberTotalSum_03_all eq 0}">
			<c:set var="arvMemberTotalSum_03_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_03_all" value="${feeMemberTotalSum_03_all / endMemberTotalSum_03_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeMemberTotalSum_02_all eq 0 or endMemberTotalSum_02_all eq 0}">
			<c:set var="arvMemberTotalSum_02_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_02_all" value="${feeMemberTotalSum_02_all / endMemberTotalSum_02_all}"></c:set>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${feeMemberTotalSum_01_all eq 0 or endMemberTotalSum_01_all eq 0}">
			<c:set var="arvMemberTotalSum_01_all" value="0"></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="arvMemberTotalSum_01_all" value="${feeMemberTotalSum_01_all / endMemberTotalSum_01_all}"></c:set>
		</c:otherwise>
	</c:choose>
	
	<!-- 가로 합계 -->
	<c:set var="feeColMemberTotalSum_all" value="${feeMemberTotalSum_12_all + feeMemberTotalSum_11_all + feeMemberTotalSum_10_all + feeMemberTotalSum_09_all + feeMemberTotalSum_08_all + feeMemberTotalSum_07_all + feeMemberTotalSum_06_all + feeMemberTotalSum_05_all + feeMemberTotalSum_04_all + feeMemberTotalSum_03_all + feeMemberTotalSum_02_all + feeMemberTotalSum_01_all}"></c:set>
	<c:set var="endColMemberTotalSum_all" value="${endMemberTotalSum_12_all + endMemberTotalSum_11_all + endMemberTotalSum_10_all + endMemberTotalSum_09_all + endMemberTotalSum_08_all + endMemberTotalSum_07_all + endMemberTotalSum_06_all + endMemberTotalSum_05_all + endMemberTotalSum_04_all + endMemberTotalSum_03_all + endMemberTotalSum_02_all + endMemberTotalSum_01_all}"></c:set>
	<c:choose>
		<c:when test="${feeColMemberTotalSum_all eq 0 or endColMemberTotalSum_all eq 0}">
			<c:set var="arvColMemberTotalSum_all" value="0"/>
		</c:when>
		<c:otherwise>
			<c:set var="arvColMemberTotalSum_all" value="${feeColMemberTotalSum_all / endColMemberTotalSum_all}"/>
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