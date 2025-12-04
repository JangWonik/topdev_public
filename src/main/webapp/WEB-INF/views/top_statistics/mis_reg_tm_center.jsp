<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2">
    <div style="padding-right: 17px;background: #e7ecf1;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
            <colgroup>
                <col width="65">
                <col width="130">                
                <col width="65">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
            </colgroup>
            <thead>
            <tr>
                <th rowspan="2">구분</th>
                <th rowspan="2">센터명 (인원)</th>
                <th rowspan="2">구분</th>
                <th colspan="2">합계</th>
                <th colspan="2">${nowVO.monBefore11.substring(0,7)}</th>
                <th colspan="2">${nowVO.monBefore10.substring(0,7)}</th>
                <th colspan="2">${nowVO.monBefore9.substring(0,7)}</th>
                <th colspan="2">${nowVO.monBefore8.substring(0,7)}</th>
                <th colspan="2">${nowVO.monBefore7.substring(0,7)}</th>
                <th colspan="2">${nowVO.monBefore6.substring(0,7)}</th>
                <th colspan="2">${nowVO.monBefore5.substring(0,7)}</th>
                <th colspan="2">${nowVO.monBefore4.substring(0,7)}</th>
                <th colspan="2">${nowVO.monBefore3.substring(0,7)}</th>
                <th colspan="2">${nowVO.monBefore2.substring(0,7)}</th>
                <th colspan="2">${nowVO.monBefore1.substring(0,7)}</th>
                <th colspan="2">${nowVO.monBefore0.substring(0,7)}</th>                
            </tr>
            <tr>
            	<th>전체</th>
            	<th>인당<br/>평균</th>
                <th>전체</th>
            	<th>인당<br/>평균</th>
                <th>전체</th>
            	<th>인당<br/>평균</th>
                <th>전체</th>
            	<th>인당<br/>평균</th>
                <th>전체</th>
            	<th>인당<br/>평균</th>
                <th>전체</th>
            	<th>인당<br/>평균</th>
                <th>전체</th>
            	<th>인당<br/>평균</th>
                <th>전체</th>
            	<th>인당<br/>평균</th>
                <th>전체</th>
            	<th>인당<br/>평균</th>
                <th>전체</th>
            	<th>인당<br/>평균</th>
                <th>전체</th>
            	<th>인당<br/>평균</th>
                <th>전체</th>
            	<th>인당<br/>평균</th>
                <th>전체</th>
            	<th>인당<br/>평균</th>    	
            </tr>
            </thead>
        </table>
    </div>
    <div style="height:654px; overflow-x: hidden; overflow-y: auto;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
            <colgroup>
                <col width="65">
                <col width="130">                
                <col width="65">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
                <col width="40">
            </colgroup>

            <tbody>
            	<c:set var="center1row" value="10"/>            
            	<c:forEach var="center" items="${TeamCenterListVO}" varStatus="status">            		            		
	            	<tr>
	            		<c:if test="${status.index == 0}">
                        	<td id="center_row">물보험</td>
                    	</c:if>
                    	<!-- 기타는 제외하고 표시한다. -->                    	
                    	<c:if test="${center.team_center ne 999 && center.team_center ne 51 && center.team_center ne 52 && center.team_center ne 101 && center.team_center ne 102 && center.team_center ne 103}">
                    	<c:set var="center1row" value="${center1row+1}"/>
                    	<!-- 센터 조사 합계 시작 기타는 제외하고 더한다.(999)-->		            	
		            	<c:set var="sumReg_center_mid_12" value="${sumReg_center_mid_12 + center.reg_12 - center.reg_wc_12}" />
						<c:set var="sumReg_center_mid_11" value="${sumReg_center_mid_11 + center.reg_11 - center.reg_wc_11}" />
						<c:set var="sumReg_center_mid_10" value="${sumReg_center_mid_10 + center.reg_10 - center.reg_wc_10}" />
						<c:set var="sumReg_center_mid_9" value="${sumReg_center_mid_9 + center.reg_9 - center.reg_wc_9}" />
						<c:set var="sumReg_center_mid_8" value="${sumReg_center_mid_8 + center.reg_8 - center.reg_wc_8}" />
						<c:set var="sumReg_center_mid_7" value="${sumReg_center_mid_7 + center.reg_7 - center.reg_wc_7}" />
						<c:set var="sumReg_center_mid_6" value="${sumReg_center_mid_6 + center.reg_6 - center.reg_wc_6}" />
						<c:set var="sumReg_center_mid_5" value="${sumReg_center_mid_5 + center.reg_5 - center.reg_wc_5}" />
						<c:set var="sumReg_center_mid_4" value="${sumReg_center_mid_4 + center.reg_4 - center.reg_wc_4}" />
						<c:set var="sumReg_center_mid_3" value="${sumReg_center_mid_3 + center.reg_3 - center.reg_wc_3}" />
						<c:set var="sumReg_center_mid_2" value="${sumReg_center_mid_2 + center.reg_2 - center.reg_wc_2}" />
						<c:set var="sumReg_center_mid_1" value="${sumReg_center_mid_1 + center.reg_1 - center.reg_wc_1}" />
						<c:set var="sumReg_center_mid_sum" value="${sumReg_center_mid_sum + center.reg_12+center.reg_11+center.reg_10+center.reg_9+center.reg_8+center.reg_7+center.reg_6+center.reg_5+center.reg_4+center.reg_3+center.reg_2+center.reg_1-center.reg_wc_12-center.reg_wc_11-center.reg_wc_10-center.reg_wc_9-center.reg_wc_8-center.reg_wc_7-center.reg_wc_6-center.reg_wc_5-center.reg_wc_4-center.reg_wc_3-center.reg_wc_2-center.reg_wc_1}" />
						<c:set var="sumCls_center_mid_12" value="${sumCls_center_mid_12 + center.cls_12 - center.cls_wc_12}" />
						<c:set var="sumCls_center_mid_11" value="${sumCls_center_mid_11 + center.cls_11 - center.cls_wc_11}" />
						<c:set var="sumCls_center_mid_10" value="${sumCls_center_mid_10 + center.cls_10 - center.cls_wc_10}" />
						<c:set var="sumCls_center_mid_9" value="${sumCls_center_mid_9 + center.cls_9 - center.cls_wc_9}" />
						<c:set var="sumCls_center_mid_8" value="${sumCls_center_mid_8 + center.cls_8 - center.cls_wc_8}" />
						<c:set var="sumCls_center_mid_7" value="${sumCls_center_mid_7 + center.cls_7 - center.cls_wc_7}" />
						<c:set var="sumCls_center_mid_6" value="${sumCls_center_mid_6 + center.cls_6 - center.cls_wc_6}" />
						<c:set var="sumCls_center_mid_5" value="${sumCls_center_mid_5 + center.cls_5 - center.cls_wc_5}" />
						<c:set var="sumCls_center_mid_4" value="${sumCls_center_mid_4 + center.cls_4 - center.cls_wc_4}" />
						<c:set var="sumCls_center_mid_3" value="${sumCls_center_mid_3 + center.cls_3 - center.cls_wc_3}" />
						<c:set var="sumCls_center_mid_2" value="${sumCls_center_mid_2 + center.cls_2 - center.cls_wc_2}" />
						<c:set var="sumCls_center_mid_1" value="${sumCls_center_mid_1 + center.cls_1 - center.cls_wc_1}" />
						<c:set var="sumCls_center_mid_sum" value="${sumCls_center_mid_sum + center.cls_12+center.cls_11+center.cls_10+center.cls_9+center.cls_8+center.cls_7+center.cls_6+center.cls_5+center.cls_4+center.cls_3+center.cls_2+center.cls_1- center.cls_wc_12-center.cls_wc_11-center.cls_wc_10-center.cls_wc_9-center.cls_wc_8-center.cls_wc_7-center.cls_wc_6-center.cls_wc_5-center.cls_wc_4-center.cls_wc_3-center.cls_wc_2-center.cls_wc_1}" />					
						<c:set var="sumCenter_mid_member_cnt" value="${sumCenter_mid_member_cnt + center.member_cnt}" />
						
						<c:set var="reg_center_mid_12" value="${center.reg_12 - center.reg_wc_12}" />
						<c:set var="reg_center_mid_11" value="${center.reg_11 - center.reg_wc_11}" />
						<c:set var="reg_center_mid_10" value="${center.reg_10 - center.reg_wc_10}" />
						<c:set var="reg_center_mid_9" value="${center.reg_9 - center.reg_wc_9}" />
						<c:set var="reg_center_mid_8" value="${center.reg_8 - center.reg_wc_8}" />
						<c:set var="reg_center_mid_7" value="${center.reg_7 - center.reg_wc_7}" />
						<c:set var="reg_center_mid_6" value="${center.reg_6 - center.reg_wc_6}" />
						<c:set var="reg_center_mid_5" value="${center.reg_5 - center.reg_wc_5}" />
						<c:set var="reg_center_mid_4" value="${center.reg_4 - center.reg_wc_4}" />
						<c:set var="reg_center_mid_3" value="${center.reg_3 - center.reg_wc_3}" />
						<c:set var="reg_center_mid_2" value="${center.reg_2 - center.reg_wc_2}" />
						<c:set var="reg_center_mid_1" value="${center.reg_1 - center.reg_wc_1}" />
						<c:set var="reg_center_mid_sum" value="${reg_center_mid_12+reg_center_mid_11+reg_center_mid_10+reg_center_mid_9+reg_center_mid_8+reg_center_mid_7+reg_center_mid_6+reg_center_mid_5+reg_center_mid_4+reg_center_mid_3+reg_center_mid_2+reg_center_mid_1}" />
						
						<c:set var="cls_center_mid_12" value="${center.cls_12 - center.cls_wc_12}" />
						<c:set var="cls_center_mid_11" value="${center.cls_11 - center.cls_wc_11}" />
						<c:set var="cls_center_mid_10" value="${center.cls_10 - center.cls_wc_10}" />
						<c:set var="cls_center_mid_9" value="${center.cls_9 - center.cls_wc_9}" />
						<c:set var="cls_center_mid_8" value="${center.cls_8 - center.cls_wc_8}" />
						<c:set var="cls_center_mid_7" value="${center.cls_7 - center.cls_wc_7}" />
						<c:set var="cls_center_mid_6" value="${center.cls_6 - center.cls_wc_6}" />
						<c:set var="cls_center_mid_5" value="${center.cls_5 - center.cls_wc_5}" />
						<c:set var="cls_center_mid_4" value="${center.cls_4 - center.cls_wc_4}" />
						<c:set var="cls_center_mid_3" value="${center.cls_3 - center.cls_wc_3}" />
						<c:set var="cls_center_mid_2" value="${center.cls_2 - center.cls_wc_2}" />
						<c:set var="cls_center_mid_1" value="${center.cls_1 - center.cls_wc_1}" />
						<c:set var="cls_center_mid_sum" value="${cls_center_mid_12+cls_center_mid_11+cls_center_mid_10+cls_center_mid_9+cls_center_mid_8+cls_center_mid_7+cls_center_mid_6+cls_center_mid_5+cls_center_mid_4+cls_center_mid_3+cls_center_mid_2+cls_center_mid_1}" />
												
						<c:set var="center_member_cnt" value="${center.member_cnt}" />
		            	<!-- 센터 조사 합계 끝 -->                    	
                    		<td>${center.team_center_val} (${center_member_cnt})</td>                    		
		            		<td>수임<br /><br />종결</td>
		            		<td bgcolor="#faebd7">
		            				${reg_center_mid_sum}
									<br /><br />									
									${cls_center_mid_sum}
		                    </td>
		                    <td bgcolor="#faebd7">		                    	
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_sum eq 0 && cls_center_mid_sum ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center_mid_sum / center_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_sum ne 0 && cls_center_mid_sum eq 0}">
		                    			<fmt:formatNumber value="${reg_center_mid_sum / center_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center_mid_sum / center_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center_mid_sum / center_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
							<td>${reg_center_mid_12}<br /><br />${cls_center_mid_12}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_12 eq 0 && cls_center_mid_12 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center_mid_12 / center_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_12 ne 0 && cls_center_mid_12 eq 0}">
		                    			<fmt:formatNumber value="${reg_center_mid_12 / center_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center_mid_12 / center_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center_mid_12 / center_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td> 
		                    <td>${reg_center_mid_11}<br /><br />${cls_center_mid_11}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_11 eq 0 && cls_center_mid_11 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center_mid_11 / center_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_11 ne 0 && cls_center_mid_11 eq 0}">
		                    			<fmt:formatNumber value="${reg_center_mid_11 / center_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center_mid_11 / center_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center_mid_11 / center_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_center_mid_10}<br /><br />${cls_center_mid_10}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_10 eq 0 && cls_center_mid_10 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center_mid_10 / center_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_10 ne 0 && cls_center_mid_10 eq 0}">
		                    			<fmt:formatNumber value="${reg_center_mid_10 / center_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center_mid_10 / center_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center_mid_10 / center_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_center_mid_9}<br /><br />${cls_center_mid_9}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_9 eq 0 && cls_center_mid_9 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center_mid_9 / center_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_9 ne 0 && cls_center_mid_9 eq 0}">
		                    			<fmt:formatNumber value="${reg_center_mid_9 / center_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center_mid_9 / center_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center_mid_9 / center_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_center_mid_8}<br /><br />${cls_center_mid_8}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_8 eq 0 && cls_center_mid_8 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center_mid_8 / center_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_8 ne 0 && cls_center_mid_8 eq 0}">
		                    			<fmt:formatNumber value="${reg_center_mid_8 / center_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center_mid_8 / center_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center_mid_8 / center_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_center_mid_7}<br /><br />${cls_center_mid_7}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_7 eq 0 && cls_center_mid_7 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center_mid_7 / center_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_7 ne 0 && cls_center_mid_7 eq 0}">
		                    			<fmt:formatNumber value="${reg_center_mid_7 / center_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center_mid_7 / center_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center_mid_7 / center_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_center_mid_6}<br /><br />${cls_center_mid_6}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_6 eq 0 && cls_center_mid_6 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center_mid_6 / center_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_6 ne 0 && cls_center_mid_6 eq 0}">
		                    			<fmt:formatNumber value="${reg_center_mid_6 / center_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center_mid_6 / center_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center_mid_6 / center_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_center_mid_5}<br /><br />${cls_center_mid_5}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_5 eq 0 && cls_center_mid_5 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center_mid_5 / center_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_5 ne 0 && cls_center_mid_5 eq 0}">
		                    			<fmt:formatNumber value="${reg_center_mid_5 / center_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center_mid_5 / center_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center_mid_5 / center_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_center_mid_4}<br /><br />${cls_center_mid_4}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_4 eq 0 && cls_center_mid_4 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center_mid_4 / center_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_4 ne 0 && cls_center_mid_4 eq 0}">
		                    			<fmt:formatNumber value="${reg_center_mid_4 / center_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center_mid_4 / center_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center_mid_4 / center_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_center_mid_3}<br /><br />${cls_center_mid_3}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_3 eq 0 && cls_center_mid_3 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center_mid_3 / center_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_3 ne 0 && cls_center_mid_3 eq 0}">
		                    			<fmt:formatNumber value="${reg_center_mid_3 / center_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center_mid_3 / center_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center_mid_3 / center_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_center_mid_2}<br /><br />${cls_center_mid_2}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_2 eq 0 && cls_center_mid_2 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center_mid_2 / center_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_2 ne 0 && cls_center_mid_2 eq 0}">
		                    			<fmt:formatNumber value="${reg_center_mid_2 / center_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center_mid_2 / center_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center_mid_2 / center_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_center_mid_1}<br /><br />${cls_center_mid_1}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_1 eq 0 && cls_center_mid_1 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center_mid_1 / center_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center_mid_1 ne 0 && cls_center_mid_1 eq 0}">
		                    			<fmt:formatNumber value="${reg_center_mid_1 / center_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center_mid_1 / center_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center_mid_1 / center_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>		                    
		                </c:if>            
		            	</tr>
		            	<!-- 센터 전체 합계 시작 -->		            	
		            	<c:set var="sumReg_center_12" value="${sumReg_center_12 + center.reg_12}" />
						<c:set var="sumReg_center_11" value="${sumReg_center_11 + center.reg_11}" />
						<c:set var="sumReg_center_10" value="${sumReg_center_10 + center.reg_10}" />
						<c:set var="sumReg_center_9" value="${sumReg_center_9 + center.reg_9}" />
						<c:set var="sumReg_center_8" value="${sumReg_center_8 + center.reg_8}" />
						<c:set var="sumReg_center_7" value="${sumReg_center_7 + center.reg_7}" />
						<c:set var="sumReg_center_6" value="${sumReg_center_6 + center.reg_6}" />
						<c:set var="sumReg_center_5" value="${sumReg_center_5 + center.reg_5}" />
						<c:set var="sumReg_center_4" value="${sumReg_center_4 + center.reg_4}" />
						<c:set var="sumReg_center_3" value="${sumReg_center_3 + center.reg_3}" />
						<c:set var="sumReg_center_2" value="${sumReg_center_2 + center.reg_2}" />
						<c:set var="sumReg_center_1" value="${sumReg_center_1 + center.reg_1}" />
						<c:set var="sumReg_center_sum" value="${sumReg_center_sum + center.reg_12+center.reg_11+center.reg_10+center.reg_9+center.reg_8+center.reg_7+center.reg_6+center.reg_5+center.reg_4+center.reg_3+center.reg_2+center.reg_1}" />
						<c:set var="sumCls_center_12" value="${sumCls_center_12 + center.cls_12}" />
						<c:set var="sumCls_center_11" value="${sumCls_center_11 + center.cls_11}" />
						<c:set var="sumCls_center_10" value="${sumCls_center_10 + center.cls_10}" />
						<c:set var="sumCls_center_9" value="${sumCls_center_9 + center.cls_9}" />
						<c:set var="sumCls_center_8" value="${sumCls_center_8 + center.cls_8}" />
						<c:set var="sumCls_center_7" value="${sumCls_center_7 + center.cls_7}" />
						<c:set var="sumCls_center_6" value="${sumCls_center_6 + center.cls_6}" />
						<c:set var="sumCls_center_5" value="${sumCls_center_5 + center.cls_5}" />
						<c:set var="sumCls_center_4" value="${sumCls_center_4 + center.cls_4}" />
						<c:set var="sumCls_center_3" value="${sumCls_center_3 + center.cls_3}" />
						<c:set var="sumCls_center_2" value="${sumCls_center_2 + center.cls_2}" />
						<c:set var="sumCls_center_1" value="${sumCls_center_1 + center.cls_1}" />
						<c:set var="sumCls_center_sum" value="${sumCls_center_sum + center.cls_12+center.cls_11+center.cls_10+center.cls_9+center.cls_8+center.cls_7+center.cls_6+center.cls_5+center.cls_4+center.cls_3+center.cls_2+center.cls_1}" />
						<c:set var="sumCenter_member_cnt" value="${sumCenter_member_cnt + center.member_cnt}" />
						<!-- 센터 전체 합계 끝 -->					
            	</c:forEach>
            	<!-- 센터(조사)소계 시작 -->
            	<tr bgcolor="#E7ECF1">
	                <td>물보험 센터 (조사)소계<br/>(${sumCenter_mid_member_cnt})</td>
	                <td>수임<br /><br />종결</td>
	                <td>${sumReg_center_mid_sum}<br /><br />${sumCls_center_mid_sum}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_mid_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_sum eq 0 && sumCls_center_mid_sum ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_mid_sum / sumCenter_mid_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_sum ne 0 && sumCls_center_mid_sum eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_mid_sum / sumCenter_mid_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_mid_sum / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_mid_sum / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_mid_12}<br /><br />${sumCls_center_mid_12}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_mid_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_12 eq 0 && sumCls_center_mid_12 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_mid_12 / sumCenter_mid_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_12 ne 0 && sumCls_center_mid_12 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_mid_12 / sumCenter_mid_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_mid_12 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_mid_12 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_mid_11}<br /><br />${sumCls_center_mid_11}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_mid_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_11 eq 0 && sumCls_center_mid_11 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_mid_11 / sumCenter_mid_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_11 ne 0 && sumCls_center_mid_11 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_mid_11 / sumCenter_mid_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_mid_11 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_mid_11 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_mid_10}<br /><br />${sumCls_center_mid_10}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_mid_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_10 eq 0 && sumCls_center_mid_10 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_mid_10 / sumCenter_mid_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_10 ne 0 && sumCls_center_mid_10 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_mid_10 / sumCenter_mid_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_mid_10 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_mid_10 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_mid_9}<br /><br />${sumCls_center_mid_9}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_mid_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_9 eq 0 && sumCls_center_mid_9 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_mid_9 / sumCenter_mid_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_9 ne 0 && sumCls_center_mid_9 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_mid_9 / sumCenter_mid_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_mid_9 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_mid_9 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_mid_8}<br /><br />${sumCls_center_mid_8}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_mid_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_8 eq 0 && sumCls_center_mid_8 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_mid_8 / sumCenter_mid_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_8 ne 0 && sumCls_center_mid_8 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_mid_8 / sumCenter_mid_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_mid_8 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_mid_8 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_mid_7}<br /><br />${sumCls_center_mid_7}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_mid_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_7 eq 0 && sumCls_center_mid_7 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_mid_7 / sumCenter_mid_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_7 ne 0 && sumCls_center_mid_7 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_mid_7 / sumCenter_mid_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_mid_7 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_mid_7 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_mid_6}<br /><br />${sumCls_center_mid_6}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_mid_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_6 eq 0 && sumCls_center_mid_6 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_mid_6 / sumCenter_mid_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_6 ne 0 && sumCls_center_mid_6 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_mid_6 / sumCenter_mid_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_mid_6 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_mid_6 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_mid_5}<br /><br />${sumCls_center_mid_5}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_mid_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_5 eq 0 && sumCls_center_mid_5 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_mid_5 / sumCenter_mid_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_5 ne 0 && sumCls_center_mid_5 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_mid_5 / sumCenter_mid_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_mid_5 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_mid_5 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_mid_4}<br /><br />${sumCls_center_mid_4}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_mid_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_4 eq 0 && sumCls_center_mid_4 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_mid_4 / sumCenter_mid_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_4 ne 0 && sumCls_center_mid_4 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_mid_4 / sumCenter_mid_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_mid_4 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_mid_4 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_mid_3}<br /><br />${sumCls_center_mid_3}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_mid_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_3 eq 0 && sumCls_center_mid_3 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_mid_3 / sumCenter_mid_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_3 ne 0 && sumCls_center_mid_3 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_mid_3 / sumCenter_mid_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_mid_3 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_mid_3 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_mid_2}<br /><br />${sumCls_center_mid_2}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_mid_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_2 eq 0 && sumCls_center_mid_2 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_mid_2 / sumCenter_mid_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_2 ne 0 && sumCls_center_mid_2 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_mid_2 / sumCenter_mid_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_mid_2 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_mid_2 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_mid_1}<br /><br />${sumCls_center_mid_1}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_mid_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_1 eq 0 && sumCls_center_mid_1 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_mid_1 / sumCenter_mid_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_mid_1 ne 0 && sumCls_center_mid_1 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_mid_1 / sumCenter_mid_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_mid_1 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_mid_1 / sumCenter_mid_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>	                
	            </tr> 
            	<!-- 센터(조사)소계 끝 -->
            	
            	<!-- 물보험 심사 건수 시작 -->
            	<c:forEach var="center" items="${TeamCenterListVO}" varStatus="status">            	
            		<c:if test="${center.team_center eq 51 || center.team_center eq 52}">
            		<c:set var="center1row" value="${center1row+1}"/>
            		<!-- 물보험 심사 소계계산 시작 -->
	                 <c:set var="sumReg_center_etc_12" value="${sumReg_center_etc_12 + center.reg_12}" />
					<c:set var="sumReg_center_etc_11" value="${sumReg_center_etc_11 + center.reg_11}" />
					<c:set var="sumReg_center_etc_10" value="${sumReg_center_etc_10 + center.reg_10}" />
					<c:set var="sumReg_center_etc_9" value="${sumReg_center_etc_9 + center.reg_9}" />
					<c:set var="sumReg_center_etc_8" value="${sumReg_center_etc_8 + center.reg_8}" />
					<c:set var="sumReg_center_etc_7" value="${sumReg_center_etc_7 + center.reg_7}" />
					<c:set var="sumReg_center_etc_6" value="${sumReg_center_etc_6 + center.reg_6}" />
					<c:set var="sumReg_center_etc_5" value="${sumReg_center_etc_5 + center.reg_5}" />
					<c:set var="sumReg_center_etc_4" value="${sumReg_center_etc_4 + center.reg_4}" />
					<c:set var="sumReg_center_etc_3" value="${sumReg_center_etc_3 + center.reg_3}" />
					<c:set var="sumReg_center_etc_2" value="${sumReg_center_etc_2 + center.reg_2}" />
					<c:set var="sumReg_center_etc_1" value="${sumReg_center_etc_1 + center.reg_1}" />
					<c:set var="sumReg_center_etc_sum" value="${sumReg_center_etc_sum + center.reg_12+center.reg_11+center.reg_10+center.reg_9+center.reg_8+center.reg_7+center.reg_6+center.reg_5+center.reg_4+center.reg_3+center.reg_2+center.reg_1}" />
					<c:set var="sumCls_center_etc_12" value="${sumCls_center_etc_12 + center.cls_12}" />
					<c:set var="sumCls_center_etc_11" value="${sumCls_center_etc_11 + center.cls_11}" />
					<c:set var="sumCls_center_etc_10" value="${sumCls_center_etc_10 + center.cls_10}" />
					<c:set var="sumCls_center_etc_9" value="${sumCls_center_etc_9 + center.cls_9}" />
					<c:set var="sumCls_center_etc_8" value="${sumCls_center_etc_8 + center.cls_8}" />
					<c:set var="sumCls_center_etc_7" value="${sumCls_center_etc_7 + center.cls_7}" />
					<c:set var="sumCls_center_etc_6" value="${sumCls_center_etc_6 + center.cls_6}" />
					<c:set var="sumCls_center_etc_5" value="${sumCls_center_etc_5 + center.cls_5}" />
					<c:set var="sumCls_center_etc_4" value="${sumCls_center_etc_4 + center.cls_4}" />
					<c:set var="sumCls_center_etc_3" value="${sumCls_center_etc_3 + center.cls_3}" />
					<c:set var="sumCls_center_etc_2" value="${sumCls_center_etc_2 + center.cls_2}" />
					<c:set var="sumCls_center_etc_1" value="${sumCls_center_etc_1 + center.cls_1}" />
					<c:set var="sumCls_center_etc_sum" value="${sumCls_center_etc_sum + center.cls_12+center.cls_11+center.cls_10+center.cls_9+center.cls_8+center.cls_7+center.cls_6+center.cls_5+center.cls_4+center.cls_3+center.cls_2+center.cls_1}" />
					
					<c:set var="sumCenter_etc_member_cnt" value="${sumCenter_etc_member_cnt + center.member_cnt}" />
										
					<c:set var="reg_center_etc_12" value="${center.reg_12}" />
					<c:set var="reg_center_etc_11" value="${center.reg_11}" />
					<c:set var="reg_center_etc_10" value="${center.reg_10}" />
					<c:set var="reg_center_etc_9" value="${center.reg_9}" />
					<c:set var="reg_center_etc_8" value="${center.reg_8}" />
					<c:set var="reg_center_etc_7" value="${center.reg_7}" />
					<c:set var="reg_center_etc_6" value="${center.reg_6}" />
					<c:set var="reg_center_etc_5" value="${center.reg_5}" />
					<c:set var="reg_center_etc_4" value="${center.reg_4}" />
					<c:set var="reg_center_etc_3" value="${center.reg_3}" />
					<c:set var="reg_center_etc_2" value="${center.reg_2}" />
					<c:set var="reg_center_etc_1" value="${center.reg_1}" />
					<c:set var="reg_center_etc_sum" value="${reg_center_etc_12+reg_center_etc_11+reg_center_etc_10+reg_center_etc_9+reg_center_etc_8+reg_center_etc_7+reg_center_etc_6+reg_center_etc_5+reg_center_etc_4+reg_center_etc_3+reg_center_etc_2+reg_center_etc_1}" />
					
					<c:set var="cls_center_etc_12" value="${center.cls_12}" />
					<c:set var="cls_center_etc_11" value="${center.cls_11}" />
					<c:set var="cls_center_etc_10" value="${center.cls_10}" />
					<c:set var="cls_center_etc_9" value="${center.cls_9}" />
					<c:set var="cls_center_etc_8" value="${center.cls_8}" />
					<c:set var="cls_center_etc_7" value="${center.cls_7}" />
					<c:set var="cls_center_etc_6" value="${center.cls_6}" />
					<c:set var="cls_center_etc_5" value="${center.cls_5}" />
					<c:set var="cls_center_etc_4" value="${center.cls_4}" />
					<c:set var="cls_center_etc_3" value="${center.cls_3}" />
					<c:set var="cls_center_etc_2" value="${center.cls_2}" />
					<c:set var="cls_center_etc_1" value="${center.cls_1}" />
					<c:set var="cls_center_etc_sum" value="${cls_center_etc_12+cls_center_etc_11+cls_center_etc_10+cls_center_etc_9+cls_center_etc_8+cls_center_etc_7+cls_center_etc_6+cls_center_etc_5+cls_center_etc_4+cls_center_etc_3+cls_center_etc_2+cls_center_etc_1}" />
					
					<c:set var="center_member_cnt" value="${center.member_cnt}" />
	                 <!-- 물보험 심사 소계계산 끝 -->
            		<tr>            		
	            		<td>${center.team_center_val} (${center_member_cnt})</td>
	            		<td>수임<br /><br />종결</td>
	            		<td bgcolor="#faebd7">
	            			${reg_center_etc_sum}
							<br /><br />
	                        ${cls_center_etc_sum}
	                    </td>
	                    <td bgcolor="#faebd7">		                    	
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_sum eq 0 && cls_center_etc_sum ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_etc_sum / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_sum ne 0 && cls_center_etc_sum eq 0}">
	                    			<fmt:formatNumber value="${reg_center_etc_sum / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_etc_sum / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_etc_sum / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_etc_12}<br /><br />${cls_center_etc_12}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_12 eq 0 && cls_center_etc_12 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_etc_12 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_12 ne 0 && cls_center_etc_12 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_etc_12 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_etc_12 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_etc_12 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td> 
	                    <td>${reg_center_etc_11}<br /><br />${cls_center_etc_11}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_11 eq 0 && cls_center_etc_11 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_etc_11 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_11 ne 0 && cls_center_etc_11 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_etc_11 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_etc_11 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_etc_11 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_etc_10}<br /><br />${cls_center_etc_10}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_10 eq 0 && cls_center_etc_10 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_etc_10 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_10 ne 0 && cls_center_etc_10 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_etc_10 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_etc_10 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_etc_10 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_etc_9}<br /><br />${cls_center_etc_9}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_9 eq 0 && cls_center_etc_9 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_etc_9 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_9 ne 0 && cls_center_etc_9 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_etc_9 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_etc_9 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_etc_9 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_etc_8}<br /><br />${cls_center_etc_8}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_8 eq 0 && cls_center_etc_8 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_etc_8 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_8 ne 0 && cls_center_etc_8 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_etc_8 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_etc_8 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_etc_8 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_etc_7}<br /><br />${cls_center_etc_7}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_7 eq 0 && cls_center_etc_7 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_etc_7 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_7 ne 0 && cls_center_etc_7 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_etc_7 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_etc_7 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_etc_7 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_etc_6}<br /><br />${cls_center_etc_6}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_6 eq 0 && cls_center_etc_6 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_etc_6 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_6 ne 0 && cls_center_etc_6 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_etc_6 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_etc_6 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_etc_6 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_etc_5}<br /><br />${cls_center_etc_5}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_5 eq 0 && cls_center_etc_5 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_etc_5 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_5 ne 0 && cls_center_etc_5 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_etc_5 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_etc_5 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_etc_5 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_etc_4}<br /><br />${cls_center_etc_4}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_4 eq 0 && cls_center_etc_4 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_etc_4 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_4 ne 0 && cls_center_etc_4 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_etc_4 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_etc_4 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_etc_4 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_etc_3}<br /><br />${cls_center_etc_3}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_3 eq 0 && cls_center_etc_3 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_etc_3 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_3 ne 0 && cls_center_etc_3 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_etc_3 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_etc_3 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_etc_3 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_etc_2}<br /><br />${cls_center_etc_2}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_2 eq 0 && cls_center_etc_2 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_etc_2 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_2 ne 0 && cls_center_etc_2 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_etc_2 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_etc_2 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_etc_2 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_etc_1}<br /><br />${cls_center_etc_1}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_1 eq 0 && cls_center_etc_1 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_etc_1 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_etc_1 ne 0 && cls_center_etc_1 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_etc_1 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_etc_1 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_etc_1 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>	                    
	                 </tr>	                 	                 
                    </c:if>
            	</c:forEach>
            	<!-- 물보험 심사 소계 표시 시작 -->
            	<tr bgcolor="#E7ECF1">   
                    <td>물보험심사센터 소계 (${sumCenter_etc_member_cnt})</td>
            		<td>수임<br /><br />종결</td>            		
                    <td>${sumReg_center_etc_sum}<br /><br />${sumCls_center_etc_sum}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_etc_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_sum eq 0 && sumCls_center_etc_sum ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_etc_sum / sumCenter_etc_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_sum ne 0 && sumCls_center_etc_sum eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_etc_sum / sumCenter_etc_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_etc_sum / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_etc_sum / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_etc_12}<br /><br />${sumCls_center_etc_12}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_etc_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_12 eq 0 && sumCls_center_etc_12 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_etc_12 / sumCenter_etc_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_12 ne 0 && sumCls_center_etc_12 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_etc_12 / sumCenter_etc_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_etc_12 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_etc_12 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_etc_11}<br /><br />${sumCls_center_etc_11}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_etc_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_11 eq 0 && sumCls_center_etc_11 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_etc_11 / sumCenter_etc_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_11 ne 0 && sumCls_center_etc_11 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_etc_11 / sumCenter_etc_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_etc_11 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_etc_11 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_etc_10}<br /><br />${sumCls_center_etc_10}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_etc_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_10 eq 0 && sumCls_center_etc_10 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_etc_10 / sumCenter_etc_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_10 ne 0 && sumCls_center_etc_10 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_etc_10 / sumCenter_etc_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_etc_10 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_etc_10 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_etc_9}<br /><br />${sumCls_center_etc_9}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_etc_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_9 eq 0 && sumCls_center_etc_9 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_etc_9 / sumCenter_etc_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_9 ne 0 && sumCls_center_etc_9 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_etc_9 / sumCenter_etc_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_etc_9 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_etc_9 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_etc_8}<br /><br />${sumCls_center_etc_8}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_etc_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_8 eq 0 && sumCls_center_etc_8 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_etc_8 / sumCenter_etc_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_8 ne 0 && sumCls_center_etc_8 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_etc_8 / sumCenter_etc_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_etc_8 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_etc_8 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_etc_7}<br /><br />${sumCls_center_etc_7}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_etc_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_7 eq 0 && sumCls_center_etc_7 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_etc_7 / sumCenter_etc_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_7 ne 0 && sumCls_center_etc_7 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_etc_7 / sumCenter_etc_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_etc_7 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_etc_7 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_etc_6}<br /><br />${sumCls_center_etc_6}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_etc_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_6 eq 0 && sumCls_center_etc_6 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_etc_6 / sumCenter_etc_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_6 ne 0 && sumCls_center_etc_6 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_etc_6 / sumCenter_etc_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_etc_6 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_etc_6 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_etc_5}<br /><br />${sumCls_center_etc_5}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_etc_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_5 eq 0 && sumCls_center_etc_5 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_etc_5 / sumCenter_etc_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_5 ne 0 && sumCls_center_etc_5 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_etc_5 / sumCenter_etc_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_etc_5 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_etc_5 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_etc_4}<br /><br />${sumCls_center_etc_4}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_etc_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_4 eq 0 && sumCls_center_etc_4 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_etc_4 / sumCenter_etc_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_4 ne 0 && sumCls_center_etc_4 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_etc_4 / sumCenter_etc_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_etc_4 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_etc_4 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_etc_3}<br /><br />${sumCls_center_etc_3}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_etc_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_3 eq 0 && sumCls_center_etc_3 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_etc_3 / sumCenter_etc_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_3 ne 0 && sumCls_center_etc_3 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_etc_3 / sumCenter_etc_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_etc_3 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_etc_3 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_etc_2}<br /><br />${sumCls_center_etc_2}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_etc_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_2 eq 0 && sumCls_center_etc_2 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_etc_2 / sumCenter_etc_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_2 ne 0 && sumCls_center_etc_2 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_etc_2 / sumCenter_etc_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_etc_2 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_etc_2 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_etc_1}<br /><br />${sumCls_center_etc_1}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_etc_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_1 eq 0 && sumCls_center_etc_1 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_etc_1 / sumCenter_etc_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_etc_1 ne 0 && sumCls_center_etc_1 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_etc_1 / sumCenter_etc_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_etc_1 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_etc_1 / sumCenter_etc_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>                    
                 </tr>
            	<!-- 물보험 심사 소계 표시 끝 -->            	
            	<!-- 물보험 심사 건수 끝 -->            	
            	
            	<!-- 센터(심사)건수 시작 -->
            	<c:forEach var="center" items="${TeamCenterListVO}" varStatus="status">
            		<c:if test="${center.wc_center_flag eq 1 && center.team_center ne 999}">
            			<c:set var="center1row" value="${center1row+1}"/>
            			<tr>
		            		<td>${center.team_center_val}(서면심사)</td>
		            		<td>수임<br /><br />종결</td>
		            		<td bgcolor="#faebd7">${center.reg_wc_12+center.reg_wc_11+center.reg_wc_10+center.reg_wc_9+center.reg_wc_8+center.reg_wc_7+center.reg_wc_6+center.reg_wc_5+center.reg_wc_4+center.reg_wc_3+center.reg_wc_2+center.reg_wc_1}
								<br /><br />
		                        ${center.cls_wc_12+center.cls_wc_11+center.cls_wc_10+center.cls_wc_9+center.cls_wc_8+center.cls_wc_7+center.cls_wc_6+center.cls_wc_5+center.cls_wc_4+center.cls_wc_3+center.cls_wc_2+center.cls_wc_1}
		                    </td>
		                    <td bgcolor="#faebd7">-<br /><br />-</td>
		                    <td>${center.reg_wc_12}<br /><br />${center.cls_wc_12}</td>
		                    <td>-<br /><br />-</td> 
		                    <td>${center.reg_wc_11}<br /><br />${center.cls_wc_11}</td>
		                    <td>-<br /><br />-</td>
		                    <td>${center.reg_wc_10}<br /><br />${center.cls_wc_10}</td>
		                    <td>-<br /><br />-</td>
		                    <td>${center.reg_wc_9}<br /><br />${center.cls_wc_9}</td>
		                    <td>-<br /><br />-</td>
		                    <td>${center.reg_wc_8}<br /><br />${center.cls_wc_8}</td>
		                    <td>-<br /><br />-</td>
		                    <td>${center.reg_wc_7}<br /><br />${center.cls_wc_7}</td>
		                    <td>-<br /><br />-</td>
		                    <td>${center.reg_wc_6}<br /><br />${center.cls_wc_6}</td>
		                    <td>-<br /><br />-</td>
		                    <td>${center.reg_wc_5}<br /><br />${center.cls_wc_5}</td>
		                    <td>-<br /><br />-</td>
		                    <td>${center.reg_wc_4}<br /><br />${center.cls_wc_4}</td>
		                    <td>-<br /><br />-</td>
		                    <td>${center.reg_wc_3}<br /><br />${center.cls_wc_3}</td>
		                    <td>-<br /><br />-</td>
		                    <td>${center.reg_wc_2}<br /><br />${center.cls_wc_2}</td>
		                    <td>-<br /><br />-</td>
		                    <td>${center.reg_wc_1}<br /><br />${center.cls_wc_1}</td>
		                    <td>-<br /><br />-</td>		                    	                	
	            		</tr>
	            		<!-- 센터(심사)소계 시작 -->	            		
	            		<c:set var="sumReg_center_wc_12" value="${sumReg_center_wc_12 + center.reg_wc_12}" />
						<c:set var="sumReg_center_wc_11" value="${sumReg_center_wc_11 + center.reg_wc_11}" />
						<c:set var="sumReg_center_wc_10" value="${sumReg_center_wc_10 + center.reg_wc_10}" />
						<c:set var="sumReg_center_wc_9" value="${sumReg_center_wc_9 + center.reg_wc_9}" />
						<c:set var="sumReg_center_wc_8" value="${sumReg_center_wc_8 + center.reg_wc_8}" />
						<c:set var="sumReg_center_wc_7" value="${sumReg_center_wc_7 + center.reg_wc_7}" />
						<c:set var="sumReg_center_wc_6" value="${sumReg_center_wc_6 + center.reg_wc_6}" />
						<c:set var="sumReg_center_wc_5" value="${sumReg_center_wc_5 + center.reg_wc_5}" />
						<c:set var="sumReg_center_wc_4" value="${sumReg_center_wc_4 + center.reg_wc_4}" />
						<c:set var="sumReg_center_wc_3" value="${sumReg_center_wc_3 + center.reg_wc_3}" />
						<c:set var="sumReg_center_wc_2" value="${sumReg_center_wc_2 + center.reg_wc_2}" />
						<c:set var="sumReg_center_wc_1" value="${sumReg_center_wc_1 + center.reg_wc_1}" />
						<c:set var="sumReg_center_wc_sum" value="${sumReg_center_wc_sum + center.reg_wc_12+center.reg_wc_11+center.reg_wc_10+center.reg_wc_9+center.reg_wc_8+center.reg_wc_7+center.reg_wc_6+center.reg_wc_5+center.reg_wc_4+center.reg_wc_3+center.reg_wc_2+center.reg_wc_1}" />
						<c:set var="sumCls_center_wc_12" value="${sumCls_center_wc_12 + center.cls_wc_12}" />
						<c:set var="sumCls_center_wc_11" value="${sumCls_center_wc_11 + center.cls_wc_11}" />
						<c:set var="sumCls_center_wc_10" value="${sumCls_center_wc_10 + center.cls_wc_10}" />
						<c:set var="sumCls_center_wc_9" value="${sumCls_center_wc_9 + center.cls_wc_9}" />
						<c:set var="sumCls_center_wc_8" value="${sumCls_center_wc_8 + center.cls_wc_8}" />
						<c:set var="sumCls_center_wc_7" value="${sumCls_center_wc_7 + center.cls_wc_7}" />
						<c:set var="sumCls_center_wc_6" value="${sumCls_center_wc_6 + center.cls_wc_6}" />
						<c:set var="sumCls_center_wc_5" value="${sumCls_center_wc_5 + center.cls_wc_5}" />
						<c:set var="sumCls_center_wc_4" value="${sumCls_center_wc_4 + center.cls_wc_4}" />
						<c:set var="sumCls_center_wc_3" value="${sumCls_center_wc_3 + center.cls_wc_3}" />
						<c:set var="sumCls_center_wc_2" value="${sumCls_center_wc_2 + center.cls_wc_2}" />
						<c:set var="sumCls_center_wc_1" value="${sumCls_center_wc_1 + center.cls_wc_1}" />
						<c:set var="sumCls_center_wc_sum" value="${sumCls_center_wc_sum + center.cls_wc_12+center.cls_wc_11+center.cls_wc_10+center.cls_wc_9+center.cls_wc_8+center.cls_wc_7+center.cls_wc_6+center.cls_wc_5+center.cls_wc_4+center.cls_wc_3+center.cls_wc_2+center.cls_wc_1}" />						
	            		<!-- 센터(심사)소계 끝 -->
            		</c:if>
            	</c:forEach>
            	<tr bgcolor="#E7ECF1">
	                <td>물보험 센터 (서면심사)소계</td>
	                <td>수임<br /><br />종결</td>
	                <td>${sumReg_center_wc_sum}<br /><br />${sumCls_center_wc_sum}</td>
	                <td>-<br /><br />-</td>
	                <td>${sumReg_center_wc_12}<br /><br />${sumCls_center_wc_12}</td>
	                <td>-<br /><br />-</td>
	                <td>${sumReg_center_wc_11}<br /><br />${sumCls_center_wc_11}</td>
	                <td>-<br /><br />-</td>
	                <td>${sumReg_center_wc_10}<br /><br />${sumCls_center_wc_10}</td>
	                <td>-<br /><br />-</td>
	                <td>${sumReg_center_wc_9}<br /><br />${sumCls_center_wc_9}</td>
	                <td>-<br /><br />-</td>
	                <td>${sumReg_center_wc_8}<br /><br />${sumCls_center_wc_8}</td>
	                <td>-<br /><br />-</td>
	                <td>${sumReg_center_wc_7}<br /><br />${sumCls_center_wc_7}</td>
	                <td>-<br /><br />-</td>
	                <td>${sumReg_center_wc_6}<br /><br />${sumCls_center_wc_6}</td>
	                <td>-<br /><br />-</td>
	                <td>${sumReg_center_wc_5}<br /><br />${sumCls_center_wc_5}</td>
	                <td>-<br /><br />-</td>
	                <td>${sumReg_center_wc_4}<br /><br />${sumCls_center_wc_4}</td>
	                <td>-<br /><br />-</td>
	                <td>${sumReg_center_wc_3}<br /><br />${sumCls_center_wc_3}</td>
	                <td>-<br /><br />-</td>
	                <td>${sumReg_center_wc_2}<br /><br />${sumCls_center_wc_2}</td>
	                <td>-<br /><br />-</td>
	                <td>${sumReg_center_wc_1}<br /><br />${sumCls_center_wc_1}</td>
	                <td>-<br /><br />-</td>	                
	            </tr>            	
            	<!-- 센터(심사)건수 끝 -->
            	 
            	<!-- 기타(999)건수 시작 -->
            	<c:forEach var="center" items="${TeamCenterListVO}" varStatus="status">            	
            		<c:if test="${center.team_center eq 999}">
            		<c:set var="center1row" value="${center1row+1}"/>
            		<c:set var="reg_center_12" value="${center.reg_12}" />
					<c:set var="reg_center_11" value="${center.reg_11}" />
					<c:set var="reg_center_10" value="${center.reg_10}" />
					<c:set var="reg_center_9" value="${center.reg_9}" />
					<c:set var="reg_center_8" value="${center.reg_8}" />
					<c:set var="reg_center_7" value="${center.reg_7}" />
					<c:set var="reg_center_6" value="${center.reg_6}" />
					<c:set var="reg_center_5" value="${center.reg_5}" />
					<c:set var="reg_center_4" value="${center.reg_4}" />
					<c:set var="reg_center_3" value="${center.reg_3}" />
					<c:set var="reg_center_2" value="${center.reg_2}" />
					<c:set var="reg_center_1" value="${center.reg_1}" />
					<c:set var="reg_center_sum" value="${reg_center_12+reg_center_11+reg_center_10+reg_center_9+reg_center_8+reg_center_7+reg_center_6+reg_center_5+reg_center_4+reg_center_3+reg_center_2+reg_center_1}" />
					
					<c:set var="cls_center_12" value="${center.cls_12}" />
					<c:set var="cls_center_11" value="${center.cls_11}" />
					<c:set var="cls_center_10" value="${center.cls_10}" />
					<c:set var="cls_center_9" value="${center.cls_9}" />
					<c:set var="cls_center_8" value="${center.cls_8}" />
					<c:set var="cls_center_7" value="${center.cls_7}" />
					<c:set var="cls_center_6" value="${center.cls_6}" />
					<c:set var="cls_center_5" value="${center.cls_5}" />
					<c:set var="cls_center_4" value="${center.cls_4}" />
					<c:set var="cls_center_3" value="${center.cls_3}" />
					<c:set var="cls_center_2" value="${center.cls_2}" />
					<c:set var="cls_center_1" value="${center.cls_1}" />
					<c:set var="cls_center_sum" value="${cls_center_12+cls_center_11+cls_center_10+cls_center_9+cls_center_8+cls_center_7+cls_center_6+cls_center_5+cls_center_4+cls_center_3+cls_center_2+cls_center_1}" />
            		
            		<c:set var="center_member_cnt" value="${center.member_cnt}" />
            		<tr>            		
	            		<td>${center.team_center_val} (${center_member_cnt})</td>
	            		<td>수임<br /><br />종결</td>
	            		<td bgcolor="#faebd7">
	            			${reg_center_sum}
							<br /><br />
	                        ${cls_center_sum}
	                    </td>
	                    <td bgcolor="#faebd7">		                    	
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_sum eq 0 && cls_center_sum ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_sum / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_sum ne 0 && cls_center_sum eq 0}">
	                    			<fmt:formatNumber value="${reg_center_sum / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_sum / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_sum / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_12}<br /><br />${cls_center_12}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_12 eq 0 && cls_center_12 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_12 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_12 ne 0 && cls_center_12 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_12 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_12 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_12 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td> 
	                    <td>${reg_center_11}<br /><br />${cls_center_11}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_11 eq 0 && cls_center_11 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_11 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_11 ne 0 && cls_center_11 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_11 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_11 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_11 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_10}<br /><br />${cls_center_10}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_10 eq 0 && cls_center_10 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_10 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_10 ne 0 && cls_center_10 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_10 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_10 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_10 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_9}<br /><br />${cls_center_9}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_9 eq 0 && cls_center_9 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_9 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_9 ne 0 && cls_center_9 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_9 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_9 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_9 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_8}<br /><br />${cls_center_8}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_8 eq 0 && cls_center_8 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_8 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_8 ne 0 && cls_center_8 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_8 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_8 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_8 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_7}<br /><br />${cls_center_7}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_7 eq 0 && cls_center_7 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_7 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_7 ne 0 && cls_center_7 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_7 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_7 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_7 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_6}<br /><br />${cls_center_6}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_6 eq 0 && cls_center_6 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_6 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_6 ne 0 && cls_center_6 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_6 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_6 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_6 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_5}<br /><br />${cls_center_5}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_5 eq 0 && cls_center_5 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_5 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_5 ne 0 && cls_center_5 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_5 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_5 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_5 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_4}<br /><br />${cls_center_4}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_4 eq 0 && cls_center_4 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_4 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_4 ne 0 && cls_center_4 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_4 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_4 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_4 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_3}<br /><br />${cls_center_3}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_3 eq 0 && cls_center_3 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_3 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_3 ne 0 && cls_center_3 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_3 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_3 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_3 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_2}<br /><br />${cls_center_2}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_2 eq 0 && cls_center_2 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_2 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_2 ne 0 && cls_center_2 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_2 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_2 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_2 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_1}<br /><br />${cls_center_1}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_1 eq 0 && cls_center_1 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_1 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_1 ne 0 && cls_center_1 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_1 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_1 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_1 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>	                    
	                 </tr>
	                 <tr bgcolor="#E7ECF1">   
	                    <td>${center.team_center_val} 소계 (${center_member_cnt})</td>
	            		<td>수임<br /><br />종결</td>
	            		<td>
	            			${reg_center_sum}
							<br /><br />
	                        ${cls_center_sum}
	                    </td>
	                    <td>		                    	
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_sum eq 0 && cls_center_sum ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_sum / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_sum ne 0 && cls_center_sum eq 0}">
	                    			<fmt:formatNumber value="${reg_center_sum / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_sum / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_sum / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_12}<br /><br />${cls_center_12}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_12 eq 0 && cls_center_12 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_12 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_12 ne 0 && cls_center_12 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_12 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_12 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_12 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td> 
	                    <td>${reg_center_11}<br /><br />${cls_center_11}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_11 eq 0 && cls_center_11 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_11 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_11 ne 0 && cls_center_11 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_11 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_11 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_11 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_10}<br /><br />${cls_center_10}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_10 eq 0 && cls_center_10 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_10 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_10 ne 0 && cls_center_10 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_10 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_10 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_10 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_9}<br /><br />${cls_center_9}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_9 eq 0 && cls_center_9 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_9 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_9 ne 0 && cls_center_9 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_9 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_9 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_9 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_8}<br /><br />${cls_center_8}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_8 eq 0 && cls_center_8 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_8 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_8 ne 0 && cls_center_8 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_8 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_8 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_8 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_7}<br /><br />${cls_center_7}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_7 eq 0 && cls_center_7 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_7 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_7 ne 0 && cls_center_7 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_7 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_7 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_7 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_6}<br /><br />${cls_center_6}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_6 eq 0 && cls_center_6 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_6 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_6 ne 0 && cls_center_6 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_6 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_6 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_6 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_5}<br /><br />${cls_center_5}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_5 eq 0 && cls_center_5 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_5 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_5 ne 0 && cls_center_5 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_5 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_5 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_5 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_4}<br /><br />${cls_center_4}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_4 eq 0 && cls_center_4 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_4 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_4 ne 0 && cls_center_4 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_4 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_4 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_4 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_3}<br /><br />${cls_center_3}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_3 eq 0 && cls_center_3 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_3 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_3 ne 0 && cls_center_3 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_3 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_3 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_3 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_2}<br /><br />${cls_center_2}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_2 eq 0 && cls_center_2 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_2 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_2 ne 0 && cls_center_2 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_2 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_2 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_2 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center_1}<br /><br />${cls_center_1}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center_1 eq 0 && cls_center_1 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center_1 / center_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center_1 ne 0 && cls_center_1 eq 0}">
	                    			<fmt:formatNumber value="${reg_center_1 / center_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center_1 / center_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center_1 / center_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>	                    
                    </tr>
                    </c:if>
            	</c:forEach>            	
            	<!-- 기타(999)건수 끝 -->
            	
            	<tr bgcolor="#E7ECF1">
	                <td colspan="2">물보험 소계 (${sumCenter_member_cnt})</td>
	                <td>수임<br /><br />종결</td>
	                <td>${sumReg_center_sum}<br /><br />${sumCls_center_sum}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_sum eq 0 && sumCls_center_sum ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_sum / sumCenter_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_sum ne 0 && sumCls_center_sum eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_sum / sumCenter_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_sum / sumCenter_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_sum / sumCenter_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_12}<br /><br />${sumCls_center_12}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_12 eq 0 && sumCls_center_12 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_12 / sumCenter_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_12 ne 0 && sumCls_center_12 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_12 / sumCenter_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_12 / sumCenter_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_12 / sumCenter_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_11}<br /><br />${sumCls_center_11}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_11 eq 0 && sumCls_center_11 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_11 / sumCenter_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_11 ne 0 && sumCls_center_11 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_11 / sumCenter_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_11 / sumCenter_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_11 / sumCenter_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_10}<br /><br />${sumCls_center_10}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_10 eq 0 && sumCls_center_10 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_10 / sumCenter_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_10 ne 0 && sumCls_center_10 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_10 / sumCenter_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_10 / sumCenter_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_10 / sumCenter_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_9}<br /><br />${sumCls_center_9}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_9 eq 0 && sumCls_center_9 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_9 / sumCenter_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_9 ne 0 && sumCls_center_9 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_9 / sumCenter_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_9 / sumCenter_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_9 / sumCenter_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_8}<br /><br />${sumCls_center_8}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_8 eq 0 && sumCls_center_8 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_8 / sumCenter_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_8 ne 0 && sumCls_center_8 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_8 / sumCenter_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_8 / sumCenter_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_8 / sumCenter_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_7}<br /><br />${sumCls_center_7}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_7 eq 0 && sumCls_center_7 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_7 / sumCenter_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_7 ne 0 && sumCls_center_7 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_7 / sumCenter_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_7 / sumCenter_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_7 / sumCenter_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_6}<br /><br />${sumCls_center_6}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_6 eq 0 && sumCls_center_6 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_6 / sumCenter_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_6 ne 0 && sumCls_center_6 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_6 / sumCenter_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_6 / sumCenter_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_6 / sumCenter_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_5}<br /><br />${sumCls_center_5}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_5 eq 0 && sumCls_center_5 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_5 / sumCenter_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_5 ne 0 && sumCls_center_5 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_5 / sumCenter_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_5 / sumCenter_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_5 / sumCenter_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_4}<br /><br />${sumCls_center_4}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_4 eq 0 && sumCls_center_4 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_4 / sumCenter_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_4 ne 0 && sumCls_center_4 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_4 / sumCenter_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_4 / sumCenter_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_4 / sumCenter_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_3}<br /><br />${sumCls_center_3}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_3 eq 0 && sumCls_center_3 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_3 / sumCenter_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_3 ne 0 && sumCls_center_3 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_3 / sumCenter_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_3 / sumCenter_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_3 / sumCenter_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_2}<br /><br />${sumCls_center_2}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_2 eq 0 && sumCls_center_2 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_2 / sumCenter_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_2 ne 0 && sumCls_center_2 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_2 / sumCenter_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_2 / sumCenter_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_2 / sumCenter_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center_1}<br /><br />${sumCls_center_1}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center_1 eq 0 && sumCls_center_1 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center_1 / sumCenter_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center_1 ne 0 && sumCls_center_1 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center_1 / sumCenter_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center_1 / sumCenter_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center_1 / sumCenter_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>	                
	            </tr>
	            
	            
	            <!-- 인보험 조사심사 시작 -->
	            <c:forEach var="center4" items="${TeamCenter4ListVO}" varStatus="status">	            	
            		<c:if test="${center4.team_center eq 101 || center4.team_center eq 102 || center4.team_center eq 103}">
            		<!-- 인보험 조사심사 소계 시작 -->
            		<c:set var="sumReg_center4_12" value="${sumReg_center4_12 + center4.reg_12}" />
					<c:set var="sumReg_center4_11" value="${sumReg_center4_11 + center4.reg_11}" />
					<c:set var="sumReg_center4_10" value="${sumReg_center4_10 + center4.reg_10}" />
					<c:set var="sumReg_center4_9" value="${sumReg_center4_9 + center4.reg_9}" />
					<c:set var="sumReg_center4_8" value="${sumReg_center4_8 + center4.reg_8}" />
					<c:set var="sumReg_center4_7" value="${sumReg_center4_7 + center4.reg_7}" />
					<c:set var="sumReg_center4_6" value="${sumReg_center4_6 + center4.reg_6}" />
					<c:set var="sumReg_center4_5" value="${sumReg_center4_5 + center4.reg_5}" />
					<c:set var="sumReg_center4_4" value="${sumReg_center4_4 + center4.reg_4}" />
					<c:set var="sumReg_center4_3" value="${sumReg_center4_3 + center4.reg_3}" />
					<c:set var="sumReg_center4_2" value="${sumReg_center4_2 + center4.reg_2}" />
					<c:set var="sumReg_center4_1" value="${sumReg_center4_1 + center4.reg_1}" />
					<c:set var="sumReg_center4_sum" value="${sumReg_center4_sum + center4.reg_12+center4.reg_11+center4.reg_10+center4.reg_9+center4.reg_8+center4.reg_7+center4.reg_6+center4.reg_5+center4.reg_4+center4.reg_3+center4.reg_2+center4.reg_1}" />
					<c:set var="sumCls_center4_12" value="${sumCls_center4_12 + center4.cls_12}" />
					<c:set var="sumCls_center4_11" value="${sumCls_center4_11 + center4.cls_11}" />
					<c:set var="sumCls_center4_10" value="${sumCls_center4_10 + center4.cls_10}" />
					<c:set var="sumCls_center4_9" value="${sumCls_center4_9 + center4.cls_9}" />
					<c:set var="sumCls_center4_8" value="${sumCls_center4_8 + center4.cls_8}" />
					<c:set var="sumCls_center4_7" value="${sumCls_center4_7 + center4.cls_7}" />
					<c:set var="sumCls_center4_6" value="${sumCls_center4_6 + center4.cls_6}" />
					<c:set var="sumCls_center4_5" value="${sumCls_center4_5 + center4.cls_5}" />
					<c:set var="sumCls_center4_4" value="${sumCls_center4_4 + center4.cls_4}" />
					<c:set var="sumCls_center4_3" value="${sumCls_center4_3 + center4.cls_3}" />
					<c:set var="sumCls_center4_2" value="${sumCls_center4_2 + center4.cls_2}" />
					<c:set var="sumCls_center4_1" value="${sumCls_center4_1 + center4.cls_1}" />
					<c:set var="sumCls_center4_sum" value="${sumCls_center4_sum + center4.cls_12+center4.cls_11+center4.cls_10+center4.cls_9+center4.cls_8+center4.cls_7+center4.cls_6+center4.cls_5+center4.cls_4+center4.cls_3+center4.cls_2+center4.cls_1}" />
					
					<c:set var="sumCenter4_member_mid_cnt" value="${sumCenter4_member_mid_cnt + center4.member_cnt}" />
					<!-- 인보험 조사심사 소계 끝 -->
            		
            		<c:set var="reg_center4_12" value="${center4.reg_12}" />
					<c:set var="reg_center4_11" value="${center4.reg_11}" />
					<c:set var="reg_center4_10" value="${center4.reg_10}" />
					<c:set var="reg_center4_9" value="${center4.reg_9}" />
					<c:set var="reg_center4_8" value="${center4.reg_8}" />
					<c:set var="reg_center4_7" value="${center4.reg_7}" />
					<c:set var="reg_center4_6" value="${center4.reg_6}" />
					<c:set var="reg_center4_5" value="${center4.reg_5}" />
					<c:set var="reg_center4_4" value="${center4.reg_4}" />
					<c:set var="reg_center4_3" value="${center4.reg_3}" />
					<c:set var="reg_center4_2" value="${center4.reg_2}" />
					<c:set var="reg_center4_1" value="${center4.reg_1}" />
					<c:set var="reg_center4_sum" value="${reg_center4_12+reg_center4_11+reg_center4_10+reg_center4_9+reg_center4_8+reg_center4_7+reg_center4_6+reg_center4_5+reg_center4_4+reg_center4_3+reg_center4_2+reg_center4_1}" />
					
					<c:set var="cls_center4_12" value="${center4.cls_12}" />
					<c:set var="cls_center4_11" value="${center4.cls_11}" />
					<c:set var="cls_center4_10" value="${center4.cls_10}" />
					<c:set var="cls_center4_9" value="${center4.cls_9}" />
					<c:set var="cls_center4_8" value="${center4.cls_8}" />
					<c:set var="cls_center4_7" value="${center4.cls_7}" />
					<c:set var="cls_center4_6" value="${center4.cls_6}" />
					<c:set var="cls_center4_5" value="${center4.cls_5}" />
					<c:set var="cls_center4_4" value="${center4.cls_4}" />
					<c:set var="cls_center4_3" value="${center4.cls_3}" />
					<c:set var="cls_center4_2" value="${center4.cls_2}" />
					<c:set var="cls_center4_1" value="${center4.cls_1}" />
					<c:set var="cls_center4_sum" value="${cls_center4_12+cls_center4_11+cls_center4_10+cls_center4_9+cls_center4_8+cls_center4_7+cls_center4_6+cls_center4_5+cls_center4_4+cls_center4_3+cls_center4_2+cls_center4_1}" />
					
					<c:set var="center4_member_cnt" value="${center4.member_cnt}" />
            			<tr>
            				<c:if test="${center4.team_center eq 101}">
            				<td rowspan="6">인보험</td>
            				</c:if>
		            		<td>${center4.team_center_val} (${center4_member_cnt})</td>
		            		<td>수임<br /><br />종결</td>
		            		<td bgcolor="#faebd7">
		            			${reg_center4_sum}
								<br /><br />
		                        ${cls_center4_sum}
		                    </td>
		                    <td bgcolor="#faebd7">		                    	
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_sum eq 0 && cls_center4_sum ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center4_sum / center4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_sum ne 0 && cls_center4_sum eq 0}">
		                    			<fmt:formatNumber value="${reg_center4_sum / center4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center4_sum / center4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center4_sum / center4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_center4_12}<br /><br />${cls_center4_12}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_12 eq 0 && cls_center4_12 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center4_12 / center4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_12 ne 0 && cls_center4_12 eq 0}">
		                    			<fmt:formatNumber value="${reg_center4_12 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center4_12 / center4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center4_12 / center4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td> 
		                    <td>${reg_center4_11}<br /><br />${cls_center4_11}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_11 eq 0 && cls_center4_11 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center4_11 / center4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_11 ne 0 && cls_center4_11 eq 0}">
		                    			<fmt:formatNumber value="${reg_center4_11 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center4_11 / center4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center4_11 / center4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_center4_10}<br /><br />${cls_center4_10}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_10 eq 0 && cls_center4_10 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center4_10 / center4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_10 ne 0 && cls_center4_10 eq 0}">
		                    			<fmt:formatNumber value="${reg_center4_10 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center4_10 / center4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center4_10 / center4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_center4_9}<br /><br />${cls_center4_9}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_9 eq 0 && cls_center4_9 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center4_9 / center4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_9 ne 0 && cls_center4_9 eq 0}">
		                    			<fmt:formatNumber value="${reg_center4_9 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center4_9 / center4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center4_9 / center4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_center4_8}<br /><br />${cls_center4_8}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_8 eq 0 && cls_center4_8 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center4_8 / center4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_8 ne 0 && cls_center4_8 eq 0}">
		                    			<fmt:formatNumber value="${reg_center4_8 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center4_8 / center4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center4_8 / center4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_center4_7}<br /><br />${cls_center4_7}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_7 eq 0 && cls_center4_7 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center4_7 / center4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_7 ne 0 && cls_center4_7 eq 0}">
		                    			<fmt:formatNumber value="${reg_center4_7 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center4_7 / center4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center4_7 / center4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_center4_6}<br /><br />${cls_center4_6}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_6 eq 0 && cls_center4_6 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center4_6 / center4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_6 ne 0 && cls_center4_6 eq 0}">
		                    			<fmt:formatNumber value="${reg_center4_6 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center4_6 / center4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center4_6 / center4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_center4_5}<br /><br />${cls_center4_5}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_5 eq 0 && cls_center4_5 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center4_5 / center4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_5 ne 0 && cls_center4_5 eq 0}">
		                    			<fmt:formatNumber value="${reg_center4_5 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center4_5 / center4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center4_5 / center4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_center4_4}<br /><br />${cls_center4_4}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_4 eq 0 && cls_center4_4 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center4_4 / center4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_4 ne 0 && cls_center4_4 eq 0}">
		                    			<fmt:formatNumber value="${reg_center4_4 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center4_4 / center4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center4_4 / center4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_center4_3}<br /><br />${cls_center4_3}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_3 eq 0 && cls_center4_3 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center4_3 / center4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_3 ne 0 && cls_center4_3 eq 0}">
		                    			<fmt:formatNumber value="${reg_center4_3 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center4_3 / center4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center4_3 / center4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_center4_2}<br /><br />${cls_center4_2}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_2 eq 0 && cls_center4_2 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center4_2 / center4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_2 ne 0 && cls_center4_2 eq 0}">
		                    			<fmt:formatNumber value="${reg_center4_2 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center4_2 / center4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center4_2 / center4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_center4_1}<br /><br />${cls_center4_1}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ center4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_1 eq 0 && cls_center4_1 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_center4_1 / center4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_center4_1 ne 0 && cls_center4_1 eq 0}">
		                    			<fmt:formatNumber value="${reg_center4_1 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_center4_1 / center4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_center4_1 / center4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>		                    	                	
	            		</tr>
	            		<!-- 인보험 조사심사 소계 시작 -->	            								
	            	<!-- 인보험 조사심사 소계 끝 -->	            		
            		</c:if>
            		<!-- 인보험 전체 합계 시작 -->
            		<c:set var="sumReg4_center_12" value="${sumReg4_center_12 + center4.reg_12}" />
					<c:set var="sumReg4_center_11" value="${sumReg4_center_11 + center4.reg_11}" />
					<c:set var="sumReg4_center_10" value="${sumReg4_center_10 + center4.reg_10}" />
					<c:set var="sumReg4_center_9" value="${sumReg4_center_9 + center4.reg_9}" />
					<c:set var="sumReg4_center_8" value="${sumReg4_center_8 + center4.reg_8}" />
					<c:set var="sumReg4_center_7" value="${sumReg4_center_7 + center4.reg_7}" />
					<c:set var="sumReg4_center_6" value="${sumReg4_center_6 + center4.reg_6}" />
					<c:set var="sumReg4_center_5" value="${sumReg4_center_5 + center4.reg_5}" />
					<c:set var="sumReg4_center_4" value="${sumReg4_center_4 + center4.reg_4}" />
					<c:set var="sumReg4_center_3" value="${sumReg4_center_3 + center4.reg_3}" />
					<c:set var="sumReg4_center_2" value="${sumReg4_center_2 + center4.reg_2}" />
					<c:set var="sumReg4_center_1" value="${sumReg4_center_1 + center4.reg_1}" />
					<c:set var="sumReg4_center_sum" value="${sumReg4_center_sum + center4.reg_12+center4.reg_11+center4.reg_10+center4.reg_9+center4.reg_8+center4.reg_7+center4.reg_6+center4.reg_5+center4.reg_4+center4.reg_3+center4.reg_2+center4.reg_1}" />
					<c:set var="sumCls4_center_12" value="${sumCls4_center_12 + center4.cls_12}" />
					<c:set var="sumCls4_center_11" value="${sumCls4_center_11 + center4.cls_11}" />
					<c:set var="sumCls4_center_10" value="${sumCls4_center_10 + center4.cls_10}" />
					<c:set var="sumCls4_center_9" value="${sumCls4_center_9 + center4.cls_9}" />
					<c:set var="sumCls4_center_8" value="${sumCls4_center_8 + center4.cls_8}" />
					<c:set var="sumCls4_center_7" value="${sumCls4_center_7 + center4.cls_7}" />
					<c:set var="sumCls4_center_6" value="${sumCls4_center_6 + center4.cls_6}" />
					<c:set var="sumCls4_center_5" value="${sumCls4_center_5 + center4.cls_5}" />
					<c:set var="sumCls4_center_4" value="${sumCls4_center_4 + center4.cls_4}" />
					<c:set var="sumCls4_center_3" value="${sumCls4_center_3 + center4.cls_3}" />
					<c:set var="sumCls4_center_2" value="${sumCls4_center_2 + center4.cls_2}" />
					<c:set var="sumCls4_center_1" value="${sumCls4_center_1 + center4.cls_1}" />
					<c:set var="sumCls4_center_sum" value="${sumCls4_center_sum + center4.cls_12+center4.cls_11+center4.cls_10+center4.cls_9+center4.cls_8+center4.cls_7+center4.cls_6+center4.cls_5+center4.cls_4+center4.cls_3+center4.cls_2+center4.cls_1}" />
					<c:set var="sumCenter4_member_cnt" value="${sumCenter4_member_cnt + center4.member_cnt}" />
            		<!-- 인보험 전체 합계 끝 -->
            	</c:forEach>
            	<!-- 인보험 조사심사 소계 표시 시작 -->
            	<tr bgcolor="#E7ECF1">
	                <td>인보험 조사심사 소계 (${sumCenter4_member_mid_cnt})</td>
	                <td>수임<br /><br />종결</td>
	                <td>${sumReg_center4_sum}<br /><br />${sumCls_center4_sum}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_sum eq 0 && sumCls_center4_sum ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center4_sum / sumCenter4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_sum ne 0 && sumCls_center4_sum eq 0}">
                    			<fmt:formatNumber value="${sumReg_center4_sum / sumCenter4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center4_sum / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center4_sum / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center4_12}<br /><br />${sumCls_center4_12}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_12 eq 0 && sumCls_center4_12 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center4_12 / sumCenter4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_12 ne 0 && sumCls_center4_12 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center4_12 / sumCenter4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center4_12 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center4_12 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center4_11}<br /><br />${sumCls_center4_11}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_11 eq 0 && sumCls_center4_11 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center4_11 / sumCenter4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_11 ne 0 && sumCls_center4_11 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center4_11 / sumCenter4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center4_11 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center4_11 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center4_10}<br /><br />${sumCls_center4_10}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_10 eq 0 && sumCls_center4_10 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center4_10 / sumCenter4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_10 ne 0 && sumCls_center4_10 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center4_10 / sumCenter4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center4_10 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center4_10 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center4_9}<br /><br />${sumCls_center4_9}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_9 eq 0 && sumCls_center4_9 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center4_9 / sumCenter4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_9 ne 0 && sumCls_center4_9 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center4_9 / sumCenter4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center4_9 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center4_9 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center4_8}<br /><br />${sumCls_center4_8}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_8 eq 0 && sumCls_center4_8 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center4_8 / sumCenter4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_8 ne 0 && sumCls_center4_8 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center4_8 / sumCenter4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center4_8 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center4_8 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center4_7}<br /><br />${sumCls_center4_7}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_7 eq 0 && sumCls_center4_7 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center4_7 / sumCenter4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_7 ne 0 && sumCls_center4_7 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center4_7 / sumCenter4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center4_7 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center4_7 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center4_6}<br /><br />${sumCls_center4_6}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_6 eq 0 && sumCls_center4_6 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center4_6 / sumCenter4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_6 ne 0 && sumCls_center4_6 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center4_6 / sumCenter4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center4_6 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center4_6 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center4_5}<br /><br />${sumCls_center4_5}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_5 eq 0 && sumCls_center4_5 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center4_5 / sumCenter4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_5 ne 0 && sumCls_center4_5 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center4_5 / sumCenter4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center4_5 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center4_5 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center4_4}<br /><br />${sumCls_center4_4}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_4 eq 0 && sumCls_center4_4 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center4_4 / sumCenter4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_4 ne 0 && sumCls_center4_4 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center4_4 / sumCenter4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center4_4 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center4_4 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center4_3}<br /><br />${sumCls_center4_3}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_3 eq 0 && sumCls_center4_3 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center4_3 / sumCenter4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_3 ne 0 && sumCls_center4_3 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center4_3 / sumCenter4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center4_3 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center4_3 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center4_2}<br /><br />${sumCls_center4_2}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_2 eq 0 && sumCls_center4_2 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center4_2 / sumCenter4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_2 ne 0 && sumCls_center4_2 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center4_2 / sumCenter4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center4_2 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center4_2 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_center4_1}<br /><br />${sumCls_center4_1}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_1 eq 0 && sumCls_center4_1 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_center4_1 / sumCenter4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_center4_1 ne 0 && sumCls_center4_1 eq 0}">
                    			<fmt:formatNumber value="${sumReg_center4_1 / sumCenter4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_center4_1 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_center4_1 / sumCenter4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>	                
	            </tr>            	
            	<!-- 인보험 조사심사 소계 표시 끝 -->
            	
            	<!-- 인보험 기타 부문 시작 -->
            	<c:forEach var="center4" items="${TeamCenter4ListVO}" varStatus="status">            	
            		<c:if test="${center4.team_center eq 999}">
            		<c:set var="reg_center4_12" value="${center4.reg_12}" />
					<c:set var="reg_center4_11" value="${center4.reg_11}" />
					<c:set var="reg_center4_10" value="${center4.reg_10}" />
					<c:set var="reg_center4_9" value="${center4.reg_9}" />
					<c:set var="reg_center4_8" value="${center4.reg_8}" />
					<c:set var="reg_center4_7" value="${center4.reg_7}" />
					<c:set var="reg_center4_6" value="${center4.reg_6}" />
					<c:set var="reg_center4_5" value="${center4.reg_5}" />
					<c:set var="reg_center4_4" value="${center4.reg_4}" />
					<c:set var="reg_center4_3" value="${center4.reg_3}" />
					<c:set var="reg_center4_2" value="${center4.reg_2}" />
					<c:set var="reg_center4_1" value="${center4.reg_1}" />
					<c:set var="reg_center4_sum" value="${reg_center4_12+reg_center4_11+reg_center4_10+reg_center4_9+reg_center4_8+reg_center4_7+reg_center4_6+reg_center4_5+reg_center4_4+reg_center4_3+reg_center4_2+reg_center4_1}" />
					
					<c:set var="cls_center4_12" value="${center4.cls_12}" />
					<c:set var="cls_center4_11" value="${center4.cls_11}" />
					<c:set var="cls_center4_10" value="${center4.cls_10}" />
					<c:set var="cls_center4_9" value="${center4.cls_9}" />
					<c:set var="cls_center4_8" value="${center4.cls_8}" />
					<c:set var="cls_center4_7" value="${center4.cls_7}" />
					<c:set var="cls_center4_6" value="${center4.cls_6}" />
					<c:set var="cls_center4_5" value="${center4.cls_5}" />
					<c:set var="cls_center4_4" value="${center4.cls_4}" />
					<c:set var="cls_center4_3" value="${center4.cls_3}" />
					<c:set var="cls_center4_2" value="${center4.cls_2}" />
					<c:set var="cls_center4_1" value="${center4.cls_1}" />
					<c:set var="cls_center4_sum" value="${cls_center4_12+cls_center4_11+cls_center4_10+cls_center4_9+cls_center4_8+cls_center4_7+cls_center4_6+cls_center4_5+cls_center4_4+cls_center4_3+cls_center4_2+cls_center4_1}" />
            		
            		<c:set var="center4_member_cnt" value="${center4.member_cnt}" />
            		<tr>            		
	            		<td>${center4.team_center_val} (${center4_member_cnt})</td>
	            		<td>수임<br /><br />종결</td>
	            		<td bgcolor="#faebd7">
	            			${reg_center4_sum}
							<br /><br />
	                        ${cls_center4_sum}
	                    </td>
	                    <td bgcolor="#faebd7">		                    	
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_sum eq 0 && cls_center4_sum ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_sum / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_sum ne 0 && cls_center4_sum eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_sum / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_sum / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_sum / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_12}<br /><br />${cls_center4_12}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_12 eq 0 && cls_center4_12 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_12 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_12 ne 0 && cls_center4_12 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_12 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_12 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_12 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td> 
	                    <td>${reg_center4_11}<br /><br />${cls_center4_11}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_11 eq 0 && cls_center4_11 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_11 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_11 ne 0 && cls_center4_11 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_11 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_11 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_11 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_10}<br /><br />${cls_center4_10}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_10 eq 0 && cls_center4_10 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_10 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_10 ne 0 && cls_center4_10 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_10 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_10 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_10 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_9}<br /><br />${cls_center4_9}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_9 eq 0 && cls_center4_9 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_9 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_9 ne 0 && cls_center4_9 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_9 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_9 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_9 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_8}<br /><br />${cls_center4_8}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_8 eq 0 && cls_center4_8 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_8 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_8 ne 0 && cls_center4_8 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_8 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_8 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_8 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_7}<br /><br />${cls_center4_7}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_7 eq 0 && cls_center4_7 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_7 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_7 ne 0 && cls_center4_7 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_7 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_7 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_7 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_6}<br /><br />${cls_center4_6}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_6 eq 0 && cls_center4_6 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_6 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_6 ne 0 && cls_center4_6 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_6 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_6 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_6 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_5}<br /><br />${cls_center4_5}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_5 eq 0 && cls_center4_5 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_5 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_5 ne 0 && cls_center4_5 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_5 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_5 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_5 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_4}<br /><br />${cls_center4_4}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_4 eq 0 && cls_center4_4 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_4 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_4 ne 0 && cls_center4_4 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_4 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_4 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_4 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_3}<br /><br />${cls_center4_3}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_3 eq 0 && cls_center4_3 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_3 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_3 ne 0 && cls_center4_3 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_3 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_3 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_3 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_2}<br /><br />${cls_center4_2}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_2 eq 0 && cls_center4_2 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_2 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_2 ne 0 && cls_center4_2 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_2 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_2 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_2 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_1}<br /><br />${cls_center4_1}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_1 eq 0 && cls_center4_1 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_1 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_1 ne 0 && cls_center4_1 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_1 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_1 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_1 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>	                    
	                 </tr>
	                 <tr bgcolor="#E7ECF1">   
	                    <td>${center4.team_center_val} 소계 (${center4_member_cnt})</td>
	            		<td>수임<br /><br />종결</td>
	            		<td>
	            			${reg_center4_sum}
							<br /><br />
	                        ${cls_center4_sum}
	                    </td>
	                    <td>		                    	
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_sum eq 0 && cls_center4_sum ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_sum / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_sum ne 0 && cls_center4_sum eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_sum / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_sum / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_sum / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_12}<br /><br />${cls_center4_12}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_12 eq 0 && cls_center4_12 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_12 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_12 ne 0 && cls_center4_12 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_12 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_12 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_12 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td> 
	                    <td>${reg_center4_11}<br /><br />${cls_center4_11}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_11 eq 0 && cls_center4_11 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_11 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_11 ne 0 && cls_center4_11 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_11 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_11 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_11 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_10}<br /><br />${cls_center4_10}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_10 eq 0 && cls_center4_10 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_10 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_10 ne 0 && cls_center4_10 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_10 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_10 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_10 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_9}<br /><br />${cls_center4_9}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_9 eq 0 && cls_center4_9 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_9 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_9 ne 0 && cls_center4_9 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_9 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_9 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_9 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_8}<br /><br />${cls_center4_8}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_8 eq 0 && cls_center4_8 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_8 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_8 ne 0 && cls_center4_8 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_8 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_8 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_8 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_7}<br /><br />${cls_center4_7}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_7 eq 0 && cls_center4_7 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_7 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_7 ne 0 && cls_center4_7 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_7 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_7 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_7 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_6}<br /><br />${cls_center4_6}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_6 eq 0 && cls_center4_6 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_6 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_6 ne 0 && cls_center4_6 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_6 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_6 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_6 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_5}<br /><br />${cls_center4_5}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_5 eq 0 && cls_center4_5 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_5 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_5 ne 0 && cls_center4_5 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_5 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_5 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_5 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_4}<br /><br />${cls_center4_4}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_4 eq 0 && cls_center4_4 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_4 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_4 ne 0 && cls_center4_4 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_4 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_4 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_4 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_3}<br /><br />${cls_center4_3}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_3 eq 0 && cls_center4_3 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_3 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_3 ne 0 && cls_center4_3 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_3 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_3 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_3 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_2}<br /><br />${cls_center4_2}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_2 eq 0 && cls_center4_2 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_2 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_2 ne 0 && cls_center4_2 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_2 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_2 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_2 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_center4_1}<br /><br />${cls_center4_1}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ center4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_1 eq 0 && cls_center4_1 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_center4_1 / center4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_center4_1 ne 0 && cls_center4_1 eq 0}">
	                    			<fmt:formatNumber value="${reg_center4_1 / center4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_center4_1 / center4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_center4_1 / center4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>	                    
                    </tr>
                    </c:if>
            	</c:forEach>
            	<!-- 인보험 기타 부문 끝 -->            	            	
	            <!-- 인보험 조사심사 끝 -->
	            <tr bgcolor="#E7ECF1">
	                <td colspan="2">인보험 소계 (${sumCenter4_member_cnt})</td>
	                <td>수임<br /><br />종결</td>
	                <td>${sumReg4_center_sum}<br /><br />${sumCls4_center_sum}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_sum eq 0 && sumCls4_center_sum ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_center_sum / sumCenter4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_sum ne 0 && sumCls4_center_sum eq 0}">
                    			<fmt:formatNumber value="${sumReg4_center_sum / sumCenter4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_center_sum / sumCenter4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_center_sum / sumCenter4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_center_12}<br /><br />${sumCls4_center_12}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_12 eq 0 && sumCls4_center_12 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_center_12 / sumCenter4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_12 ne 0 && sumCls4_center_12 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_center_12 / sumCenter4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_center_12 / sumCenter4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_center_12 / sumCenter4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_center_11}<br /><br />${sumCls4_center_11}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_11 eq 0 && sumCls4_center_11 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_center_11 / sumCenter4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_11 ne 0 && sumCls4_center_11 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_center_11 / sumCenter4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_center_11 / sumCenter4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_center_11 / sumCenter4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_center_10}<br /><br />${sumCls4_center_10}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_10 eq 0 && sumCls4_center_10 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_center_10 / sumCenter4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_10 ne 0 && sumCls4_center_10 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_center_10 / sumCenter4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_center_10 / sumCenter4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_center_10 / sumCenter4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_center_9}<br /><br />${sumCls4_center_9}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_9 eq 0 && sumCls4_center_9 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_center_9 / sumCenter4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_9 ne 0 && sumCls4_center_9 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_center_9 / sumCenter4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_center_9 / sumCenter4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_center_9 / sumCenter4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_center_8}<br /><br />${sumCls4_center_8}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_8 eq 0 && sumCls4_center_8 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_center_8 / sumCenter4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_8 ne 0 && sumCls4_center_8 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_center_8 / sumCenter4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_center_8 / sumCenter4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_center_8 / sumCenter4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_center_7}<br /><br />${sumCls4_center_7}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_7 eq 0 && sumCls4_center_7 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_center_7 / sumCenter4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_7 ne 0 && sumCls4_center_7 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_center_7 / sumCenter4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_center_7 / sumCenter4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_center_7 / sumCenter4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_center_6}<br /><br />${sumCls4_center_6}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_6 eq 0 && sumCls4_center_6 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_center_6 / sumCenter4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_6 ne 0 && sumCls4_center_6 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_center_6 / sumCenter4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_center_6 / sumCenter4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_center_6 / sumCenter4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_center_5}<br /><br />${sumCls4_center_5}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_5 eq 0 && sumCls4_center_5 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_center_5 / sumCenter4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_5 ne 0 && sumCls4_center_5 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_center_5 / sumCenter4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_center_5 / sumCenter4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_center_5 / sumCenter4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_center_4}<br /><br />${sumCls4_center_4}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_4 eq 0 && sumCls4_center_4 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_center_4 / sumCenter4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_4 ne 0 && sumCls4_center_4 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_center_4 / sumCenter4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_center_4 / sumCenter4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_center_4 / sumCenter4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_center_3}<br /><br />${sumCls4_center_3}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_3 eq 0 && sumCls4_center_3 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_center_3 / sumCenter4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_3 ne 0 && sumCls4_center_3 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_center_3 / sumCenter4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_center_3 / sumCenter4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_center_3 / sumCenter4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_center_2}<br /><br />${sumCls4_center_2}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_2 eq 0 && sumCls4_center_2 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_center_2 / sumCenter4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_2 ne 0 && sumCls4_center_2 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_center_2 / sumCenter4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_center_2 / sumCenter4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_center_2 / sumCenter4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_center_1}<br /><br />${sumCls4_center_1}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumCenter4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_1 eq 0 && sumCls4_center_1 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_center_1 / sumCenter4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_center_1 ne 0 && sumCls4_center_1 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_center_1 / sumCenter4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_center_1 / sumCenter4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_center_1 / sumCenter4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>	                
	            </tr>
	            
	            <!-- 전체 합계 시작 -->
	            <tr bgcolor="#E7ECF1">
	            	<c:set var="allMember_cnt" value="${sumCenter_member_cnt+sumCenter4_member_cnt}" />
	            	<c:set var="allSumReg_12" value="${sumReg_center_12+sumReg4_center_12}" />
	            	<c:set var="allSumReg_11" value="${sumReg_center_11+sumReg4_center_11}" />
	            	<c:set var="allSumReg_10" value="${sumReg_center_10+sumReg4_center_10}" />
	            	<c:set var="allSumReg_9" value="${sumReg_center_9+sumReg4_center_9}" />
	            	<c:set var="allSumReg_8" value="${sumReg_center_8+sumReg4_center_8}" />
	            	<c:set var="allSumReg_7" value="${sumReg_center_7+sumReg4_center_7}" />
	            	<c:set var="allSumReg_6" value="${sumReg_center_6+sumReg4_center_6}" />
	            	<c:set var="allSumReg_5" value="${sumReg_center_5+sumReg4_center_5}" />
	            	<c:set var="allSumReg_4" value="${sumReg_center_4+sumReg4_center_4}" />
	            	<c:set var="allSumReg_3" value="${sumReg_center_3+sumReg4_center_3}" />
	            	<c:set var="allSumReg_2" value="${sumReg_center_2+sumReg4_center_2}" />
	            	<c:set var="allSumReg_1" value="${sumReg_center_1+sumReg4_center_1}" />
	            	<c:set var="allSumReg_sum" value="${sumReg_center_sum+sumReg4_center_sum}" />
	            	
	            	<c:set var="allSumCls_12" value="${sumCls_center_12+sumCls4_center_12}" />
	            	<c:set var="allSumCls_11" value="${sumCls_center_11+sumCls4_center_11}" />
	            	<c:set var="allSumCls_10" value="${sumCls_center_10+sumCls4_center_10}" />
	            	<c:set var="allSumCls_9" value="${sumCls_center_9+sumCls4_center_9}" />
	            	<c:set var="allSumCls_8" value="${sumCls_center_8+sumCls4_center_8}" />
	            	<c:set var="allSumCls_7" value="${sumCls_center_7+sumCls4_center_7}" />
	            	<c:set var="allSumCls_6" value="${sumCls_center_6+sumCls4_center_6}" />
	            	<c:set var="allSumCls_5" value="${sumCls_center_5+sumCls4_center_5}" />
	            	<c:set var="allSumCls_4" value="${sumCls_center_4+sumCls4_center_4}" />
	            	<c:set var="allSumCls_3" value="${sumCls_center_3+sumCls4_center_3}" />
	            	<c:set var="allSumCls_2" value="${sumCls_center_2+sumCls4_center_2}" />
	            	<c:set var="allSumCls_1" value="${sumCls_center_1+sumCls4_center_1}" />
	            	<c:set var="allSumCls_sum" value="${sumCls_center_sum+sumCls4_center_sum}" />
	            	
	                <th colspan="2">전체합계 (${allMember_cnt})</th>
	                <th>수임<br /><br />종결</th>
	                <th>${allSumReg_sum}<br /><br />${allSumCls_sum}</th>
	                <th>
	                	<font color="blue">
							<c:choose>
								<c:when test="${ allMember_cnt eq 0}">
									0<br /><br />0			
								</c:when>
								<c:when test="${ allSumReg_sum eq 0 && allSumCls_sum ne 0}">
									0<br /><br /><fmt:formatNumber value="${allSumCls_sum / allMember_cnt}" pattern="#.#"/>			
								</c:when>
								<c:when test="${ allSumReg_sum ne 0 && allSumCls_sum eq 0}">
									<fmt:formatNumber value="${allSumReg_sum / allMember_cnt}" pattern="#.#"/><br /><br />0			
								</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${allSumReg_sum / allMember_cnt}" pattern="#.#"/>
									<br/><br/>
									<fmt:formatNumber value="${allSumCls_sum / allMember_cnt}" pattern="#.#"/>
								</c:otherwise>
							</c:choose>
						</font>
	                </th>
	                <th>${allSumReg_12}<br /><br />${allSumCls_12}</th>                
	                <th>
	                	<font color="blue">
							<c:choose>
								<c:when test="${ allMember_cnt eq 0}">
									0<br /><br />0			
								</c:when>
								<c:when test="${ allSumReg_12 eq 0 && allSumCls_12 ne 0}">
									0<br /><br /><fmt:formatNumber value="${allSumCls_12 / allMember_cnt}" pattern="#.#"/>			
								</c:when>
								<c:when test="${ allSumReg_12 ne 0 && allSumCls_12 eq 0}">
									<fmt:formatNumber value="${allSumReg_12 / allMember_cnt}" pattern="#.#"/><br /><br />0			
								</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${allSumReg_12 / allMember_cnt}" pattern="#.#"/>
									<br/><br/>
									<fmt:formatNumber value="${allSumCls_12 / allMember_cnt}" pattern="#.#"/>
								</c:otherwise>
							</c:choose>
						</font>
	                </th>
	                <th>${allSumReg_11}<br /><br />${allSumCls_11}</th>
	                <th>
	                	<font color="blue">
							<c:choose>
								<c:when test="${ allMember_cnt eq 0}">
									0<br /><br />0			
								</c:when>
								<c:when test="${ allSumReg_11 eq 0 && allSumCls_11 ne 0}">
									0<br /><br /><fmt:formatNumber value="${allSumCls_11 / allMember_cnt}" pattern="#.#"/>			
								</c:when>
								<c:when test="${ allSumReg_11 ne 0 && allSumCls_11 eq 0}">
									<fmt:formatNumber value="${allSumReg_11 / allMember_cnt}" pattern="#.#"/><br /><br />0			
								</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${allSumReg_11 / allMember_cnt}" pattern="#.#"/>
									<br/><br/>
									<fmt:formatNumber value="${allSumCls_11 / allMember_cnt}" pattern="#.#"/>
								</c:otherwise>
							</c:choose>
						</font>
	                </th>
	                <th>${allSumReg_10}<br /><br />${allSumCls_10}</th>
	                <th>
	                	<font color="blue">
							<c:choose>
								<c:when test="${ allMember_cnt eq 0}">
									0<br /><br />0			
								</c:when>
								<c:when test="${ allSumReg_10 eq 0 && allSumCls_10 ne 0}">
									0<br /><br /><fmt:formatNumber value="${allSumCls_10 / allMember_cnt}" pattern="#.#"/>			
								</c:when>
								<c:when test="${ allSumReg_10 ne 0 && allSumCls_10 eq 0}">
									<fmt:formatNumber value="${allSumReg_10 / allMember_cnt}" pattern="#.#"/><br /><br />0			
								</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${allSumReg_10 / allMember_cnt}" pattern="#.#"/>
									<br/><br/>
									<fmt:formatNumber value="${allSumCls_10 / allMember_cnt}" pattern="#.#"/>
								</c:otherwise>
							</c:choose>
						</font>
	                </th>
	                <th>${allSumReg_9}<br /><br />${allSumCls_9}</th>
	                <th>
	                	<font color="blue">
							<c:choose>
								<c:when test="${ allMember_cnt eq 0}">
									0<br /><br />0			
								</c:when>
								<c:when test="${ allSumReg_9 eq 0 && allSumCls_9 ne 0}">
									0<br /><br /><fmt:formatNumber value="${allSumCls_9 / allMember_cnt}" pattern="#.#"/>			
								</c:when>
								<c:when test="${ allSumReg_9 ne 0 && allSumCls_9 eq 0}">
									<fmt:formatNumber value="${allSumReg_9 / allMember_cnt}" pattern="#.#"/><br /><br />0			
								</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${allSumReg_9 / allMember_cnt}" pattern="#.#"/>
									<br/><br/>
									<fmt:formatNumber value="${allSumCls_9 / allMember_cnt}" pattern="#.#"/>
								</c:otherwise>
							</c:choose>
						</font>
	                </th>
	                <th>${allSumReg_8}<br /><br />${allSumCls_8}</th>
	                <th>
	                	<font color="blue">
							<c:choose>
								<c:when test="${ allMember_cnt eq 0}">
									0<br /><br />0			
								</c:when>
								<c:when test="${ allSumReg_8 eq 0 && allSumCls_8 ne 0}">
									0<br /><br /><fmt:formatNumber value="${allSumCls_8 / allMember_cnt}" pattern="#.#"/>			
								</c:when>
								<c:when test="${ allSumReg_8 ne 0 && allSumCls_8 eq 0}">
									<fmt:formatNumber value="${allSumReg_8 / allMember_cnt}" pattern="#.#"/><br /><br />0			
								</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${allSumReg_8 / allMember_cnt}" pattern="#.#"/>
									<br/><br/>
									<fmt:formatNumber value="${allSumCls_8 / allMember_cnt}" pattern="#.#"/>
								</c:otherwise>
							</c:choose>
						</font>
	                </th>
	                <th>${allSumReg_7}<br /><br />${allSumCls_7}</th>
	                <th>
	                	<font color="blue">
							<c:choose>
								<c:when test="${ allMember_cnt eq 0}">
									0<br /><br />0			
								</c:when>
								<c:when test="${ allSumReg_7 eq 0 && allSumCls_7 ne 0}">
									0<br /><br /><fmt:formatNumber value="${allSumCls_7 / allMember_cnt}" pattern="#.#"/>			
								</c:when>
								<c:when test="${ allSumReg_7 ne 0 && allSumCls_7 eq 0}">
									<fmt:formatNumber value="${allSumReg_7 / allMember_cnt}" pattern="#.#"/><br /><br />0			
								</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${allSumReg_7 / allMember_cnt}" pattern="#.#"/>
									<br/><br/>
									<fmt:formatNumber value="${allSumCls_7 / allMember_cnt}" pattern="#.#"/>
								</c:otherwise>
							</c:choose>
						</font>
	                </th>
	                <th>${allSumReg_6}<br /><br />${allSumCls_6}</th>
	                <th>
	                	<font color="blue">
							<c:choose>
								<c:when test="${ allMember_cnt eq 0}">
									0<br /><br />0			
								</c:when>
								<c:when test="${ allSumReg_6 eq 0 && allSumCls_6 ne 0}">
									0<br /><br /><fmt:formatNumber value="${allSumCls_6 / allMember_cnt}" pattern="#.#"/>			
								</c:when>
								<c:when test="${ allSumReg_6 ne 0 && allSumCls_6 eq 0}">
									<fmt:formatNumber value="${allSumReg_6 / allMember_cnt}" pattern="#.#"/><br /><br />0			
								</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${allSumReg_6 / allMember_cnt}" pattern="#.#"/>
									<br/><br/>
									<fmt:formatNumber value="${allSumCls_6 / allMember_cnt}" pattern="#.#"/>
								</c:otherwise>
							</c:choose>
						</font>
	                </th>
	                <th>${allSumReg_5}<br /><br />${allSumCls_5}</th>
	                <th>
	                	<font color="blue">
							<c:choose>
								<c:when test="${ allMember_cnt eq 0}">
									0<br /><br />0			
								</c:when>
								<c:when test="${ allSumReg_5 eq 0 && allSumCls_5 ne 0}">
									0<br /><br /><fmt:formatNumber value="${allSumCls_5 / allMember_cnt}" pattern="#.#"/>			
								</c:when>
								<c:when test="${ allSumReg_5 ne 0 && allSumCls_5 eq 0}">
									<fmt:formatNumber value="${allSumReg_5 / allMember_cnt}" pattern="#.#"/><br /><br />0			
								</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${allSumReg_5 / allMember_cnt}" pattern="#.#"/>
									<br/><br/>
									<fmt:formatNumber value="${allSumCls_5 / allMember_cnt}" pattern="#.#"/>
								</c:otherwise>
							</c:choose>
						</font>
	                </th>
	                <th>${allSumReg_4}<br /><br />${allSumCls_4}</th>
	                <th>
	                	<font color="blue">
							<c:choose>
								<c:when test="${ allMember_cnt eq 0}">
									0<br /><br />0			
								</c:when>
								<c:when test="${ allSumReg_4 eq 0 && allSumCls_4 ne 0}">
									0<br /><br /><fmt:formatNumber value="${allSumCls_4 / allMember_cnt}" pattern="#.#"/>			
								</c:when>
								<c:when test="${ allSumReg_4 ne 0 && allSumCls_4 eq 0}">
									<fmt:formatNumber value="${allSumReg_4 / allMember_cnt}" pattern="#.#"/><br /><br />0			
								</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${allSumReg_4 / allMember_cnt}" pattern="#.#"/>
									<br/><br/>
									<fmt:formatNumber value="${allSumCls_4 / allMember_cnt}" pattern="#.#"/>
								</c:otherwise>
							</c:choose>
						</font>
	                </th>
	                <th>${allSumReg_3}<br /><br />${allSumCls_3}</th>
	                <th>
	                	<font color="blue">
							<c:choose>
								<c:when test="${ allMember_cnt eq 0}">
									0<br /><br />0			
								</c:when>
								<c:when test="${ allSumReg_3 eq 0 && allSumCls_3 ne 0}">
									0<br /><br /><fmt:formatNumber value="${allSumCls_3 / allMember_cnt}" pattern="#.#"/>			
								</c:when>
								<c:when test="${ allSumReg_3 ne 0 && allSumCls_3 eq 0}">
									<fmt:formatNumber value="${allSumReg_3 / allMember_cnt}" pattern="#.#"/><br /><br />0			
								</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${allSumReg_3 / allMember_cnt}" pattern="#.#"/>
									<br/><br/>
									<fmt:formatNumber value="${allSumCls_3 / allMember_cnt}" pattern="#.#"/>
								</c:otherwise>
							</c:choose>
						</font>
	                </th>
	                <th>${allSumReg_2}<br /><br />${allSumCls_2}</th>
	                <th>
	                	<font color="blue">
							<c:choose>
								<c:when test="${ allMember_cnt eq 0}">
									0<br /><br />0			
								</c:when>
								<c:when test="${ allSumReg_2 eq 0 && allSumCls_2 ne 0}">
									0<br /><br /><fmt:formatNumber value="${allSumCls_2 / allMember_cnt}" pattern="#.#"/>			
								</c:when>
								<c:when test="${ allSumReg_2 ne 0 && allSumCls_2 eq 0}">
									<fmt:formatNumber value="${allSumReg_2 / allMember_cnt}" pattern="#.#"/><br /><br />0			
								</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${allSumReg_2 / allMember_cnt}" pattern="#.#"/>
									<br/><br/>
									<fmt:formatNumber value="${allSumCls_2 / allMember_cnt}" pattern="#.#"/>
								</c:otherwise>
							</c:choose>
						</font>
	                </th>
	                <th>${allSumReg_1}<br /><br />${allSumCls_1}</th>
	                <th>
	                	<font color="blue">
							<c:choose>
								<c:when test="${ allMember_cnt eq 0}">
									0<br /><br />0			
								</c:when>
								<c:when test="${ allSumReg_1 eq 0 && allSumCls_1 ne 0}">
									0<br /><br /><fmt:formatNumber value="${allSumCls_1 / allMember_cnt}" pattern="#.#"/>			
								</c:when>
								<c:when test="${ allSumReg_1 ne 0 && allSumCls_1 eq 0}">
									<fmt:formatNumber value="${allSumReg_1 / allMember_cnt}" pattern="#.#"/><br /><br />0			
								</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${allSumReg_1 / allMember_cnt}" pattern="#.#"/>
									<br/><br/>
									<fmt:formatNumber value="${allSumCls_1 / allMember_cnt}" pattern="#.#"/>
								</c:otherwise>
							</c:choose>
						</font>
	                </th>                
	            </tr>	            
	            <!-- 전체 합계 끝 --> 
            </tbody>
        </table>
    </div>
</div>
<script>
$(document).ready(function () {
	//좌측 row 수가 가변적이므로 수정함.
    $("#center_row").attr('rowspan',${center1row});
});
</script>