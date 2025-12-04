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
                <th rowspan="2">부문명 (인원)</th>
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
            	<c:forEach var="sector" items="${TeamSectorListVO}" varStatus="status">
            		<tr>
	            		<c:if test="${status.index == 0}">
                        	<%-- <td rowspan="${TeamSectorListVO.size() + 9}">물보험</td> --%>
                        	<td rowspan="${TeamSectorListVO.size() + 8}">물보험</td>
                    	</c:if>
                    	<c:if test="${sector.team_sector eq 1 || sector.team_sector eq 2 || sector.team_sector eq 3 || sector.team_sector eq 7}">
                    	<!-- 정책, 재물, 배상부문 소계 계산시작 -->
                    	<c:set var="sumReg_mid_12" value="${sumReg_mid_12 + sector.reg_12 - sector.reg_wc_12}" />
						<c:set var="sumReg_mid_11" value="${sumReg_mid_11 + sector.reg_11 - sector.reg_wc_11}" />
						<c:set var="sumReg_mid_10" value="${sumReg_mid_10 + sector.reg_10 - sector.reg_wc_10}" />
						<c:set var="sumReg_mid_9" value="${sumReg_mid_9 + sector.reg_9 - sector.reg_wc_9}" />
						<c:set var="sumReg_mid_8" value="${sumReg_mid_8 + sector.reg_8 - sector.reg_wc_8}" />
						<c:set var="sumReg_mid_7" value="${sumReg_mid_7 + sector.reg_7 - sector.reg_wc_7}" />
						<c:set var="sumReg_mid_6" value="${sumReg_mid_6 + sector.reg_6 - sector.reg_wc_6}" />
						<c:set var="sumReg_mid_5" value="${sumReg_mid_5 + sector.reg_5 - sector.reg_wc_5}" />
						<c:set var="sumReg_mid_4" value="${sumReg_mid_4 + sector.reg_4 - sector.reg_wc_4}" />
						<c:set var="sumReg_mid_3" value="${sumReg_mid_3 + sector.reg_3 - sector.reg_wc_3}" />
						<c:set var="sumReg_mid_2" value="${sumReg_mid_2 + sector.reg_2 - sector.reg_wc_2}" />
						<c:set var="sumReg_mid_1" value="${sumReg_mid_1 + sector.reg_1 - sector.reg_wc_1}" />
						<c:set var="sumReg_mid_sum" value="${sumReg_mid_sum + sector.reg_12+sector.reg_11+sector.reg_10+sector.reg_9+sector.reg_8+sector.reg_7+sector.reg_6+sector.reg_5+sector.reg_4+sector.reg_3+sector.reg_2+sector.reg_1-sector.reg_wc_12-sector.reg_wc_11-sector.reg_wc_10-sector.reg_wc_9-sector.reg_wc_8-sector.reg_wc_7-sector.reg_wc_6-sector.reg_wc_5-sector.reg_wc_4-sector.reg_wc_3-sector.reg_wc_2-sector.reg_wc_1}" />
						<c:set var="sumCls_mid_12" value="${sumCls_mid_12 + sector.cls_12 - sector.cls_wc_12}" />
						<c:set var="sumCls_mid_11" value="${sumCls_mid_11 + sector.cls_11 - sector.cls_wc_11}" />
						<c:set var="sumCls_mid_10" value="${sumCls_mid_10 + sector.cls_10 - sector.cls_wc_10}" />
						<c:set var="sumCls_mid_9" value="${sumCls_mid_9 + sector.cls_9 - sector.cls_wc_9}" />
						<c:set var="sumCls_mid_8" value="${sumCls_mid_8 + sector.cls_8 - sector.cls_wc_8}" />
						<c:set var="sumCls_mid_7" value="${sumCls_mid_7 + sector.cls_7 - sector.cls_wc_7}" />
						<c:set var="sumCls_mid_6" value="${sumCls_mid_6 + sector.cls_6 - sector.cls_wc_6}" />
						<c:set var="sumCls_mid_5" value="${sumCls_mid_5 + sector.cls_5 - sector.cls_wc_5}" />
						<c:set var="sumCls_mid_4" value="${sumCls_mid_4 + sector.cls_4 - sector.cls_wc_4}" />
						<c:set var="sumCls_mid_3" value="${sumCls_mid_3 + sector.cls_3 - sector.cls_wc_3}" />
						<c:set var="sumCls_mid_2" value="${sumCls_mid_2 + sector.cls_2 - sector.cls_wc_2}" />
						<c:set var="sumCls_mid_1" value="${sumCls_mid_1 + sector.cls_1 - sector.cls_wc_1}" />
						<c:set var="sumCls_mid_sum" value="${sumCls_mid_sum + sector.cls_12+sector.cls_11+sector.cls_10+sector.cls_9+sector.cls_8+sector.cls_7+sector.cls_6+sector.cls_5+sector.cls_4+sector.cls_3+sector.cls_2+sector.cls_1- sector.cls_wc_12-sector.cls_wc_11-sector.cls_wc_10-sector.cls_wc_9-sector.cls_wc_8-sector.cls_wc_7-sector.cls_wc_6-sector.cls_wc_5-sector.cls_wc_4-sector.cls_wc_3-sector.cls_wc_2-sector.cls_wc_1}" />					
						<c:set var="sumSector_mid_member_cnt" value="${sumSector_mid_member_cnt + sector.member_cnt}" />
						
						<c:set var="reg_mid_12" value="${sector.reg_12 - sector.reg_wc_12}" />
						<c:set var="reg_mid_11" value="${sector.reg_11 - sector.reg_wc_11}" />
						<c:set var="reg_mid_10" value="${sector.reg_10 - sector.reg_wc_10}" />
						<c:set var="reg_mid_9" value="${sector.reg_9 - sector.reg_wc_9}" />
						<c:set var="reg_mid_8" value="${sector.reg_8 - sector.reg_wc_8}" />
						<c:set var="reg_mid_7" value="${sector.reg_7 - sector.reg_wc_7}" />
						<c:set var="reg_mid_6" value="${sector.reg_6 - sector.reg_wc_6}" />
						<c:set var="reg_mid_5" value="${sector.reg_5 - sector.reg_wc_5}" />
						<c:set var="reg_mid_4" value="${sector.reg_4 - sector.reg_wc_4}" />
						<c:set var="reg_mid_3" value="${sector.reg_3 - sector.reg_wc_3}" />
						<c:set var="reg_mid_2" value="${sector.reg_2 - sector.reg_wc_2}" />
						<c:set var="reg_mid_1" value="${sector.reg_1 - sector.reg_wc_1}" />
						<c:set var="reg_mid_sum" value="${reg_mid_12+reg_mid_11+reg_mid_10+reg_mid_9+reg_mid_8+reg_mid_7+reg_mid_6+reg_mid_5+reg_mid_4+reg_mid_3+reg_mid_2+reg_mid_1}" />
						
						<c:set var="cls_mid_12" value="${sector.cls_12 - sector.cls_wc_12}" />
						<c:set var="cls_mid_11" value="${sector.cls_11 - sector.cls_wc_11}" />
						<c:set var="cls_mid_10" value="${sector.cls_10 - sector.cls_wc_10}" />
						<c:set var="cls_mid_9" value="${sector.cls_9 - sector.cls_wc_9}" />
						<c:set var="cls_mid_8" value="${sector.cls_8 - sector.cls_wc_8}" />
						<c:set var="cls_mid_7" value="${sector.cls_7 - sector.cls_wc_7}" />
						<c:set var="cls_mid_6" value="${sector.cls_6 - sector.cls_wc_6}" />
						<c:set var="cls_mid_5" value="${sector.cls_5 - sector.cls_wc_5}" />
						<c:set var="cls_mid_4" value="${sector.cls_4 - sector.cls_wc_4}" />
						<c:set var="cls_mid_3" value="${sector.cls_3 - sector.cls_wc_3}" />
						<c:set var="cls_mid_2" value="${sector.cls_2 - sector.cls_wc_2}" />
						<c:set var="cls_mid_1" value="${sector.cls_1 - sector.cls_wc_1}" />
						<c:set var="cls_mid_sum" value="${cls_mid_12+cls_mid_11+cls_mid_10+cls_mid_9+cls_mid_8+cls_mid_7+cls_mid_6+cls_mid_5+cls_mid_4+cls_mid_3+cls_mid_2+cls_mid_1}" />
												
						<c:set var="member_cnt" value="${sector.member_cnt}" />                    	
                    	<!-- 정책, 재물, 배상부문 소계 계산끝 -->
                    	
                    	<td>${sector.team_sector_val} (${member_cnt})</td>
                    	<td>수임<br /><br />종결</td>                    		            		
	                    <td bgcolor="#faebd7">
		            				${reg_mid_sum}
									<br /><br />									
									${cls_mid_sum}
	                    </td>
	                    <td bgcolor="#faebd7">		                    	
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_sum eq 0 && cls_mid_sum ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_mid_sum / member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_sum ne 0 && cls_mid_sum eq 0}">
	                    			<fmt:formatNumber value="${reg_mid_sum / member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_mid_sum / member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_mid_sum / member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
						<td>${reg_mid_12}<br /><br />${cls_mid_12}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_12 eq 0 && cls_mid_12 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_mid_12 / member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_12 ne 0 && cls_mid_12 eq 0}">
	                    			<fmt:formatNumber value="${reg_mid_12 / member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_mid_12 / member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_mid_12 / member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td> 
	                    <td>${reg_mid_11}<br /><br />${cls_mid_11}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_11 eq 0 && cls_mid_11 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_mid_11 / member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_11 ne 0 && cls_mid_11 eq 0}">
	                    			<fmt:formatNumber value="${reg_mid_11 / member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_mid_11 / member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_mid_11 / member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_mid_10}<br /><br />${cls_mid_10}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_10 eq 0 && cls_mid_10 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_mid_10 / member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_10 ne 0 && cls_mid_10 eq 0}">
	                    			<fmt:formatNumber value="${reg_mid_10 / member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_mid_10 / member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_mid_10 / member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_mid_9}<br /><br />${cls_mid_9}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_9 eq 0 && cls_mid_9 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_mid_9 / member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_9 ne 0 && cls_mid_9 eq 0}">
	                    			<fmt:formatNumber value="${reg_mid_9 / member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_mid_9 / member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_mid_9 / member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_mid_8}<br /><br />${cls_mid_8}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_8 eq 0 && cls_mid_8 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_mid_8 / member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_8 ne 0 && cls_mid_8 eq 0}">
	                    			<fmt:formatNumber value="${reg_mid_8 / member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_mid_8 / member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_mid_8 / member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_mid_7}<br /><br />${cls_mid_7}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_7 eq 0 && cls_mid_7 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_mid_7 / member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_7 ne 0 && cls_mid_7 eq 0}">
	                    			<fmt:formatNumber value="${reg_mid_7 / member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_mid_7 / member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_mid_7 / member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_mid_6}<br /><br />${cls_mid_6}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_6 eq 0 && cls_mid_6 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_mid_6 / member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_6 ne 0 && cls_mid_6 eq 0}">
	                    			<fmt:formatNumber value="${reg_mid_6 / member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_mid_6 / member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_mid_6 / member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_mid_5}<br /><br />${cls_mid_5}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_5 eq 0 && cls_mid_5 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_mid_5 / member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_5 ne 0 && cls_mid_5 eq 0}">
	                    			<fmt:formatNumber value="${reg_mid_5 / member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_mid_5 / member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_mid_5 / member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_mid_4}<br /><br />${cls_mid_4}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_4 eq 0 && cls_mid_4 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_mid_4 / member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_4 ne 0 && cls_mid_4 eq 0}">
	                    			<fmt:formatNumber value="${reg_mid_4 / member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_mid_4 / member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_mid_4 / member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_mid_3}<br /><br />${cls_mid_3}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_3 eq 0 && cls_mid_3 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_mid_3 / member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_3 ne 0 && cls_mid_3 eq 0}">
	                    			<fmt:formatNumber value="${reg_mid_3 / member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_mid_3 / member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_mid_3 / member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_mid_2}<br /><br />${cls_mid_2}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_2 eq 0 && cls_mid_2 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_mid_2 / member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_2 ne 0 && cls_mid_2 eq 0}">
	                    			<fmt:formatNumber value="${reg_mid_2 / member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_mid_2 / member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_mid_2 / member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_mid_1}<br /><br />${cls_mid_1}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_1 eq 0 && cls_mid_1 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_mid_1 / member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_mid_1 ne 0 && cls_mid_1 eq 0}">
	                    			<fmt:formatNumber value="${reg_mid_1 / member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_mid_1 / member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_mid_1 / member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <!-- 서면심사 포함한 부문 끝 -->	                    	
	                    </c:if>
	                    
	                    <!-- 총 합(전체) 계산시작 -->
	                    <c:set var="sumReg_12" value="${sumReg_12 + sector.reg_12}" />
						<c:set var="sumReg_11" value="${sumReg_11 + sector.reg_11}" />
						<c:set var="sumReg_10" value="${sumReg_10 + sector.reg_10}" />
						<c:set var="sumReg_9" value="${sumReg_9 + sector.reg_9}" />
						<c:set var="sumReg_8" value="${sumReg_8 + sector.reg_8}" />
						<c:set var="sumReg_7" value="${sumReg_7 + sector.reg_7}" />
						<c:set var="sumReg_6" value="${sumReg_6 + sector.reg_6}" />
						<c:set var="sumReg_5" value="${sumReg_5 + sector.reg_5}" />
						<c:set var="sumReg_4" value="${sumReg_4 + sector.reg_4}" />
						<c:set var="sumReg_3" value="${sumReg_3 + sector.reg_3}" />
						<c:set var="sumReg_2" value="${sumReg_2 + sector.reg_2}" />
						<c:set var="sumReg_1" value="${sumReg_1 + sector.reg_1}" />
						<c:set var="sumReg_sum" value="${sumReg_sum + sector.reg_12+sector.reg_11+sector.reg_10+sector.reg_9+sector.reg_8+sector.reg_7+sector.reg_6+sector.reg_5+sector.reg_4+sector.reg_3+sector.reg_2+sector.reg_1}" />
						<c:set var="sumCls_12" value="${sumCls_12 + sector.cls_12}" />
						<c:set var="sumCls_11" value="${sumCls_11 + sector.cls_11}" />
						<c:set var="sumCls_10" value="${sumCls_10 + sector.cls_10}" />
						<c:set var="sumCls_9" value="${sumCls_9 + sector.cls_9}" />
						<c:set var="sumCls_8" value="${sumCls_8 + sector.cls_8}" />
						<c:set var="sumCls_7" value="${sumCls_7 + sector.cls_7}" />
						<c:set var="sumCls_6" value="${sumCls_6 + sector.cls_6}" />
						<c:set var="sumCls_5" value="${sumCls_5 + sector.cls_5}" />
						<c:set var="sumCls_4" value="${sumCls_4 + sector.cls_4}" />
						<c:set var="sumCls_3" value="${sumCls_3 + sector.cls_3}" />
						<c:set var="sumCls_2" value="${sumCls_2 + sector.cls_2}" />
						<c:set var="sumCls_1" value="${sumCls_1 + sector.cls_1}" />
						<c:set var="sumCls_sum" value="${sumCls_sum + sector.cls_12+sector.cls_11+sector.cls_10+sector.cls_9+sector.cls_8+sector.cls_7+sector.cls_6+sector.cls_5+sector.cls_4+sector.cls_3+sector.cls_2+sector.cls_1}" />
						<c:set var="sumSector_member_cnt" value="${sumSector_member_cnt + sector.member_cnt}" />
	                    <!-- 총 합(전체) 계산끝 -->
	                    
	                    <!-- 정책, 재물, 배상부분 소계 표시 시작 -->
	                    <c:if test="${status.index == 2}">
	                    <tr bgcolor="#E7ECF1">
			                <td>부문(조사) 소계 (${sumSector_member_cnt})</td>
			                <td>수임<br /><br />종결</td>
			                <td>${sumReg_mid_sum}<br /><br />${sumCls_mid_sum}</td>
			                <td>		                    	
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sumSector_mid_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_sum eq 0 && sumCls_mid_sum ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${sumCls_mid_sum / sumSector_mid_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_sum ne 0 && sumCls_mid_sum eq 0}">
		                    			<fmt:formatNumber value="${sumReg_mid_sum / sumSector_mid_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${sumReg_mid_sum / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${sumCls_mid_sum / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
			                <td>${sumReg_mid_12}<br /><br />${sumCls_mid_12}</td>
			                <td>		                    	
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sumSector_mid_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_12 eq 0 && sumCls_mid_12 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${sumCls_mid_12 / sumSector_mid_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_12 ne 0 && sumCls_mid_12 eq 0}">
		                    			<fmt:formatNumber value="${sumReg_mid_12 / sumSector_mid_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${sumReg_mid_12 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${sumCls_mid_12 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
			                <td>${sumReg_mid_11}<br /><br />${sumCls_mid_11}</td>
			                <td>		                    	
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sumSector_mid_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_11 eq 0 && sumCls_mid_11 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${sumCls_mid_11 / sumSector_mid_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_11 ne 0 && sumCls_mid_11 eq 0}">
		                    			<fmt:formatNumber value="${sumReg_mid_11 / sumSector_mid_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${sumReg_mid_11 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${sumCls_mid_11 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
			                <td>${sumReg_mid_10}<br /><br />${sumCls_mid_10}</td>
			                <td>		                    	
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sumSector_mid_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_10 eq 0 && sumCls_mid_10 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${sumCls_mid_10 / sumSector_mid_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_10 ne 0 && sumCls_mid_10 eq 0}">
		                    			<fmt:formatNumber value="${sumReg_mid_10 / sumSector_mid_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${sumReg_mid_10 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${sumCls_mid_10 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
			                <td>${sumReg_mid_9}<br /><br />${sumCls_mid_9}</td>
			                <td>		                    	
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sumSector_mid_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_9 eq 0 && sumCls_mid_9 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${sumCls_mid_9 / sumSector_mid_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_9 ne 0 && sumCls_mid_9 eq 0}">
		                    			<fmt:formatNumber value="${sumReg_mid_9 / sumSector_mid_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${sumReg_mid_9 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${sumCls_mid_9 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
			                <td>${sumReg_mid_8}<br /><br />${sumCls_mid_8}</td>
			                <td>		                    	
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sumSector_mid_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_8 eq 0 && sumCls_mid_8 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${sumCls_mid_8 / sumSector_mid_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_8 ne 0 && sumCls_mid_8 eq 0}">
		                    			<fmt:formatNumber value="${sumReg_mid_8 / sumSector_mid_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${sumReg_mid_8 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${sumCls_mid_8 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
			                <td>${sumReg_mid_7}<br /><br />${sumCls_mid_7}</td>
			                <td>		                    	
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sumSector_mid_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_7 eq 0 && sumCls_mid_7 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${sumCls_mid_7 / sumSector_mid_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_7 ne 0 && sumCls_mid_7 eq 0}">
		                    			<fmt:formatNumber value="${sumReg_mid_7 / sumSector_mid_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${sumReg_mid_7 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${sumCls_mid_7 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
			                <td>${sumReg_mid_6}<br /><br />${sumCls_mid_6}</td>
			                <td>		                    	
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sumSector_mid_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_6 eq 0 && sumCls_mid_6 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${sumCls_mid_6 / sumSector_mid_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_6 ne 0 && sumCls_mid_6 eq 0}">
		                    			<fmt:formatNumber value="${sumReg_mid_6 / sumSector_mid_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${sumReg_mid_6 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${sumCls_mid_6 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
			                <td>${sumReg_mid_5}<br /><br />${sumCls_mid_5}</td>
			                <td>		                    	
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sumSector_mid_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_5 eq 0 && sumCls_mid_5 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${sumCls_mid_5 / sumSector_mid_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_5 ne 0 && sumCls_mid_5 eq 0}">
		                    			<fmt:formatNumber value="${sumReg_mid_5 / sumSector_mid_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${sumReg_mid_5 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${sumCls_mid_5 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
			                <td>${sumReg_mid_4}<br /><br />${sumCls_mid_4}</td>
			                <td>		                    	
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sumSector_mid_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_4 eq 0 && sumCls_mid_4 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${sumCls_mid_4 / sumSector_mid_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_4 ne 0 && sumCls_mid_4 eq 0}">
		                    			<fmt:formatNumber value="${sumReg_mid_4 / sumSector_mid_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${sumReg_mid_4 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${sumCls_mid_4 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
			                <td>${sumReg_mid_3}<br /><br />${sumCls_mid_3}</td>
			                <td>		                    	
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sumSector_mid_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_3 eq 0 && sumCls_mid_3 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${sumCls_mid_3 / sumSector_mid_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_3 ne 0 && sumCls_mid_3 eq 0}">
		                    			<fmt:formatNumber value="${sumReg_mid_3 / sumSector_mid_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${sumReg_mid_3 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${sumCls_mid_3 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
			                <td>${sumReg_mid_2}<br /><br />${sumCls_mid_2}</td>
			                <td>		                    	
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sumSector_mid_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_2 eq 0 && sumCls_mid_2 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${sumCls_mid_2 / sumSector_mid_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_2 ne 0 && sumCls_mid_2 eq 0}">
		                    			<fmt:formatNumber value="${sumReg_mid_2 / sumSector_mid_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${sumReg_mid_2 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${sumCls_mid_2 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
			                <td>${sumReg_mid_1}<br /><br />${sumCls_mid_1}</td>
			                <td>		                    	
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sumSector_mid_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_1 eq 0 && sumCls_mid_1 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${sumCls_mid_1 / sumSector_mid_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ sumReg_mid_1 ne 0 && sumCls_mid_1 eq 0}">
		                    			<fmt:formatNumber value="${sumReg_mid_1 / sumSector_mid_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${sumReg_mid_1 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${sumCls_mid_1 / sumSector_mid_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
			            </tr>
	                    </c:if>
	                    <!-- 정책, 재물, 배상부분 소계 표시 끝 -->
	               </tr>            	
            	</c:forEach>            	
            	
	            <!-- 물보험 심사부문 시작 (조사,심사 포함)-->
	            <c:forEach var="sector" items="${TeamSectorListVO}" varStatus="status">
	            	<c:if test="${sector.team_sector eq 4}">
	            		<c:set var="reg_12" value="${sector.reg_12}" />
						<c:set var="reg_11" value="${sector.reg_11}" />
						<c:set var="reg_10" value="${sector.reg_10}" />
						<c:set var="reg_9" value="${sector.reg_9}" />
						<c:set var="reg_8" value="${sector.reg_8}" />
						<c:set var="reg_7" value="${sector.reg_7}" />
						<c:set var="reg_6" value="${sector.reg_6}" />
						<c:set var="reg_5" value="${sector.reg_5}" />
						<c:set var="reg_4" value="${sector.reg_4}" />
						<c:set var="reg_3" value="${sector.reg_3}" />
						<c:set var="reg_2" value="${sector.reg_2}" />
						<c:set var="reg_1" value="${sector.reg_1}" />
						<c:set var="reg_sum" value="${reg_12+reg_11+reg_10+reg_9+reg_8+reg_7+reg_6+reg_5+reg_4+reg_3+reg_2+reg_1}" />
						
						<c:set var="cls_12" value="${sector.cls_12}" />
						<c:set var="cls_11" value="${sector.cls_11}" />
						<c:set var="cls_10" value="${sector.cls_10}" />
						<c:set var="cls_9" value="${sector.cls_9}" />
						<c:set var="cls_8" value="${sector.cls_8}" />
						<c:set var="cls_7" value="${sector.cls_7}" />
						<c:set var="cls_6" value="${sector.cls_6}" />
						<c:set var="cls_5" value="${sector.cls_5}" />
						<c:set var="cls_4" value="${sector.cls_4}" />
						<c:set var="cls_3" value="${sector.cls_3}" />
						<c:set var="cls_2" value="${sector.cls_2}" />
						<c:set var="cls_1" value="${sector.cls_1}" />
						<c:set var="cls_sum" value="${cls_12+cls_11+cls_10+cls_9+cls_8+cls_7+cls_6+cls_5+cls_4+cls_3+cls_2+cls_1}" />
	            		
	            		<c:set var="member_cnt" value="${sector.member_cnt}" />	            		
	            		
	            		<tr>
	            			<td>${sector.team_sector_val} (${member_cnt}) <%-- // 고기 ${sector.team_sector} // ${sector.wc_sector_flag} --%></td>
	                    	<td>수임<br /><br />종결</td> 
	                    	<td bgcolor="#faebd7">
		            			${reg_sum}
								<br /><br />
		                        ${cls_sum}
		                    </td>
		                    <td bgcolor="#faebd7">		                    	
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sum eq 0 && cls_sum ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sum / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sum ne 0 && cls_sum eq 0}">
		                    			<fmt:formatNumber value="${reg_sum / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sum / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sum / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_12}<br /><br />${cls_12}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_12 eq 0 && cls_12 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_12 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_12 ne 0 && cls_12 eq 0}">
		                    			<fmt:formatNumber value="${reg_12 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_12 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_12 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td> 
		                    <td>${reg_11}<br /><br />${cls_11}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_11 eq 0 && cls_11 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_11 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_11 ne 0 && cls_11 eq 0}">
		                    			<fmt:formatNumber value="${reg_11 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_11 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_11 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_10}<br /><br />${cls_10}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_10 eq 0 && cls_10 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_10 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_10 ne 0 && cls_10 eq 0}">
		                    			<fmt:formatNumber value="${reg_10 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_10 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_10 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_9}<br /><br />${cls_9}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_9 eq 0 && cls_9 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_9 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_9 ne 0 && cls_9 eq 0}">
		                    			<fmt:formatNumber value="${reg_9 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_9 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_9 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_8}<br /><br />${cls_8}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_8 eq 0 && cls_8 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_8 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_8 ne 0 && cls_8 eq 0}">
		                    			<fmt:formatNumber value="${reg_8 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_8 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_8 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_7}<br /><br />${cls_7}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_7 eq 0 && cls_7 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_7 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_7 ne 0 && cls_7 eq 0}">
		                    			<fmt:formatNumber value="${reg_7 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_7 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_7 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_6}<br /><br />${cls_6}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_6 eq 0 && cls_6 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_6 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_6 ne 0 && cls_6 eq 0}">
		                    			<fmt:formatNumber value="${reg_6 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_6 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_6 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_5}<br /><br />${cls_5}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_5 eq 0 && cls_5 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_5 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_5 ne 0 && cls_5 eq 0}">
		                    			<fmt:formatNumber value="${reg_5 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_5 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_5 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_4}<br /><br />${cls_4}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_4 eq 0 && cls_4 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_4 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_4 ne 0 && cls_4 eq 0}">
		                    			<fmt:formatNumber value="${reg_4 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_4 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_4 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_3}<br /><br />${cls_3}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_3 eq 0 && cls_3 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_3 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_3 ne 0 && cls_3 eq 0}">
		                    			<fmt:formatNumber value="${reg_3 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_3 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_3 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_2}<br /><br />${cls_2}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_2 eq 0 && cls_2 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_2 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_2 ne 0 && cls_2 eq 0}">
		                    			<fmt:formatNumber value="${reg_2 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_2 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_2 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_1}<br /><br />${cls_1}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_1 eq 0 && cls_1 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_1 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_1 ne 0 && cls_1 eq 0}">
		                    			<fmt:formatNumber value="${reg_1 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_1 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_1 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		               </tr>
		               <tr bgcolor="#E7ECF1">
	                    	<td>${sector.team_sector_val} 소계 (${member_cnt})</td>
	                    	<td>수임<br /><br />종결</td>
	                    	<td>
		            			${reg_sum}
								<br /><br />
		                        ${cls_sum}
		                    </td>                    		            		
		                    <td>		                    	
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sum eq 0 && cls_sum ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sum / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sum ne 0 && cls_sum eq 0}">
		                    			<fmt:formatNumber value="${reg_sum / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sum / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sum / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_12}<br /><br />${cls_12}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_12 eq 0 && cls_12 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_12 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_12 ne 0 && cls_12 eq 0}">
		                    			<fmt:formatNumber value="${reg_12 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_12 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_12 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td> 
		                    <td>${reg_11}<br /><br />${cls_11}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_11 eq 0 && cls_11 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_11 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_11 ne 0 && cls_11 eq 0}">
		                    			<fmt:formatNumber value="${reg_11 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_11 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_11 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_10}<br /><br />${cls_10}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_10 eq 0 && cls_10 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_10 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_10 ne 0 && cls_10 eq 0}">
		                    			<fmt:formatNumber value="${reg_10 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_10 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_10 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_9}<br /><br />${cls_9}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_9 eq 0 && cls_9 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_9 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_9 ne 0 && cls_9 eq 0}">
		                    			<fmt:formatNumber value="${reg_9 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_9 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_9 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_8}<br /><br />${cls_8}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_8 eq 0 && cls_8 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_8 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_8 ne 0 && cls_8 eq 0}">
		                    			<fmt:formatNumber value="${reg_8 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_8 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_8 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_7}<br /><br />${cls_7}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_7 eq 0 && cls_7 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_7 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_7 ne 0 && cls_7 eq 0}">
		                    			<fmt:formatNumber value="${reg_7 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_7 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_7 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_6}<br /><br />${cls_6}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_6 eq 0 && cls_6 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_6 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_6 ne 0 && cls_6 eq 0}">
		                    			<fmt:formatNumber value="${reg_6 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_6 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_6 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_5}<br /><br />${cls_5}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_5 eq 0 && cls_5 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_5 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_5 ne 0 && cls_5 eq 0}">
		                    			<fmt:formatNumber value="${reg_5 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_5 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_5 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_4}<br /><br />${cls_4}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_4 eq 0 && cls_4 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_4 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_4 ne 0 && cls_4 eq 0}">
		                    			<fmt:formatNumber value="${reg_4 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_4 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_4 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_3}<br /><br />${cls_3}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_3 eq 0 && cls_3 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_3 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_3 ne 0 && cls_3 eq 0}">
		                    			<fmt:formatNumber value="${reg_3 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_3 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_3 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_2}<br /><br />${cls_2}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_2 eq 0 && cls_2 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_2 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_2 ne 0 && cls_2 eq 0}">
		                    			<fmt:formatNumber value="${reg_2 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_2 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_2 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_1}<br /><br />${cls_1}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_1 eq 0 && cls_1 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_1 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_1 ne 0 && cls_1 eq 0}">
		                    			<fmt:formatNumber value="${reg_1 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_1 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_1 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		               </tr>
	                 </c:if>
	            </c:forEach>
	            <!-- 물보험 심사부문 끝 -->	            
	            <!-- 부문(심사) 시작 team_sector : 2(재물), 3(배상), 4(물보험심사)-->
            	<c:forEach var="sector" items="${TeamSectorListVO}" varStatus="status">            		
            		<c:if test="${sector.wc_sector_flag eq 1 && (sector.team_sector eq 2 || sector.team_sector eq 3 || sector.team_sector eq 7)}">            		
            			<tr>
	            			<td>${sector.team_sector_val}(서면심사)</td>
	                    	<td>수임<br /><br />종결</td>
	                    	<td bgcolor="#faebd7">${sector.reg_wc_12+sector.reg_wc_11+sector.reg_wc_10+sector.reg_wc_9+sector.reg_wc_8+sector.reg_wc_7+sector.reg_wc_6+sector.reg_wc_5+sector.reg_wc_4+sector.reg_wc_3+sector.reg_wc_2+sector.reg_wc_1}
								<br /><br />
		                        ${sector.cls_wc_12+sector.cls_wc_11+sector.cls_wc_10+sector.cls_wc_9+sector.cls_wc_8+sector.cls_wc_7+sector.cls_wc_6+sector.cls_wc_5+sector.cls_wc_4+sector.cls_wc_3+sector.cls_wc_2+sector.cls_wc_1}
		                    </td>
		                    <td bgcolor="#faebd7">-<br /><br />-</td>                    		            		
		                    <td>${sector.reg_wc_12}<br /><br />${sector.cls_wc_12}</td>
		                    <td>-<br /><br />-</td>
		                    <td>${sector.reg_wc_11}<br /><br />${sector.cls_wc_11}</td>
		                    <td>-<br /><br />-</td>
		                    <td>${sector.reg_wc_10}<br /><br />${sector.cls_wc_10}</td>
		                    <td>-<br /><br />-</td>
		                    <td>${sector.reg_wc_9}<br /><br />${sector.cls_wc_9}</td>
		                    <td>-<br /><br />-</td>
		                    <td>${sector.reg_wc_8}<br /><br />${sector.cls_wc_8}</td>
		                    <td>-<br /><br />-</td>
		                    <td>${sector.reg_wc_7}<br /><br />${sector.cls_wc_7}</td>
		                    <td>-<br /><br />-</td>
		                    <td>${sector.reg_wc_6}<br /><br />${sector.cls_wc_6}</td>
		                    <td>-<br /><br />-</td>
		                    <td>${sector.reg_wc_5}<br /><br />${sector.cls_wc_5}</td>
		                    <td>-<br /><br />-</td>
		                    <td>${sector.reg_wc_4}<br /><br />${sector.cls_wc_4}</td>
		                    <td>-<br /><br />-</td>
		                    <td>${sector.reg_wc_3}<br /><br />${sector.cls_wc_3}</td>
		                    <td>-<br /><br />-</td>
		                    <td>${sector.reg_wc_2}<br /><br />${sector.cls_wc_2}</td>
		                    <td>-<br /><br />-</td>
		                    <td>${sector.reg_wc_1}<br /><br />${sector.cls_wc_1}</td>
		                    <td>-<br /><br />-</td>		                    
	                    </tr>
	                    <!-- 서면심사 소계 시작 -->
	                    <c:set var="sumReg_wc_12" value="${sumReg_wc_12 + sector.reg_wc_12}" />
	                    <c:set var="sumReg_wc_11" value="${sumReg_wc_11 + sector.reg_wc_11}" />
	                    <c:set var="sumReg_wc_10" value="${sumReg_wc_10 + sector.reg_wc_10}" />
	                    <c:set var="sumReg_wc_9" value="${sumReg_wc_9 + sector.reg_wc_9}" />
	                    <c:set var="sumReg_wc_8" value="${sumReg_wc_8 + sector.reg_wc_8}" />
	                    <c:set var="sumReg_wc_7" value="${sumReg_wc_7 + sector.reg_wc_7}" />
	                    <c:set var="sumReg_wc_6" value="${sumReg_wc_6 + sector.reg_wc_6}" />
	                    <c:set var="sumReg_wc_5" value="${sumReg_wc_5 + sector.reg_wc_5}" />
	                    <c:set var="sumReg_wc_4" value="${sumReg_wc_4 + sector.reg_wc_4}" />
	                    <c:set var="sumReg_wc_3" value="${sumReg_wc_3 + sector.reg_wc_3}" />
	                    <c:set var="sumReg_wc_2" value="${sumReg_wc_2 + sector.reg_wc_2}" />
	                    <c:set var="sumReg_wc_1" value="${sumReg_wc_1 + sector.reg_wc_1}" />
	                    <c:set var="sumReg_wc_sum" value="${sumReg_wc_sum+sector.reg_wc_12+sector.reg_wc_11+sector.reg_wc_10+sector.reg_wc_9+sector.reg_wc_8+sector.reg_wc_7+sector.reg_wc_6+sector.reg_wc_5+sector.reg_wc_4+sector.reg_wc_3+sector.reg_wc_2+sector.reg_wc_1}" />
	                    
	                    <c:set var="sumCls_wc_12" value="${sumCls_wc_12 + sector.cls_wc_12}" />
	                    <c:set var="sumCls_wc_11" value="${sumCls_wc_11 + sector.cls_wc_11}" />
	                    <c:set var="sumCls_wc_10" value="${sumCls_wc_10 + sector.cls_wc_10}" />
	                    <c:set var="sumCls_wc_9" value="${sumCls_wc_9 + sector.cls_wc_9}" />
	                    <c:set var="sumCls_wc_8" value="${sumCls_wc_8 + sector.cls_wc_8}" />
	                    <c:set var="sumCls_wc_7" value="${sumCls_wc_7 + sector.cls_wc_7}" />
	                    <c:set var="sumCls_wc_6" value="${sumCls_wc_6 + sector.cls_wc_6}" />
	                    <c:set var="sumCls_wc_5" value="${sumCls_wc_5 + sector.cls_wc_5}" />
	                    <c:set var="sumCls_wc_4" value="${sumCls_wc_4 + sector.cls_wc_4}" />
	                    <c:set var="sumCls_wc_3" value="${sumCls_wc_3 + sector.cls_wc_3}" />
	                    <c:set var="sumCls_wc_2" value="${sumCls_wc_2 + sector.cls_wc_2}" />
	                    <c:set var="sumCls_wc_1" value="${sumCls_wc_1 + sector.cls_wc_1}" />
	                    <c:set var="sumCls_wc_sum" value="${sumCls_wc_sum+sector.cls_wc_12+sector.cls_wc_11+sector.cls_wc_10+sector.cls_wc_9+sector.cls_wc_8+sector.cls_wc_7+sector.cls_wc_6+sector.cls_wc_5+sector.cls_wc_4+sector.cls_wc_3+sector.cls_wc_2+sector.cls_wc_1}"/>	                    
	                    <!-- 서면심사 소계 끝 -->            		
            		</c:if>
            	</c:forEach>
	            	<tr bgcolor="#E7ECF1">
		                <td>부문(서면심사) 소계</td>
		                <td>수임<br /><br />종결</td>
		                <td>${sumReg_wc_sum}<br /><br />${sumCls_wc_sum}</td>
		                <td>-<br /><br />-</td>
		                <td>${sumReg_wc_12}<br /><br />${sumCls_wc_12}</td>
		                <td>-<br /><br />-</td>
		                <td>${sumReg_wc_11}<br /><br />${sumCls_wc_11}</td>
		                <td>-<br /><br />-</td>
		                <td>${sumReg_wc_10}<br /><br />${sumCls_wc_10}</td>
		                <td>-<br /><br />-</td>
		                <td>${sumReg_wc_9}<br /><br />${sumCls_wc_9}</td>
		                <td>-<br /><br />-</td>
		                <td>${sumReg_wc_8}<br /><br />${sumCls_wc_8}</td>
		                <td>-<br /><br />-</td>
		                <td>${sumReg_wc_7}<br /><br />${sumCls_wc_7}</td>
		                <td>-<br /><br />-</td>
		                <td>${sumReg_wc_6}<br /><br />${sumCls_wc_6}</td>
		                <td>-<br /><br />-</td>
		                <td>${sumReg_wc_5}<br /><br />${sumCls_wc_5}</td>
		                <td>-<br /><br />-</td>
		                <td>${sumReg_wc_4}<br /><br />${sumCls_wc_4}</td>
		                <td>-<br /><br />-</td>
		                <td>${sumReg_wc_3}<br /><br />${sumCls_wc_3}</td>
		                <td>-<br /><br />-</td>
		                <td>${sumReg_wc_2}<br /><br />${sumCls_wc_2}</td>
		                <td>-<br /><br />-</td>
		                <td>${sumReg_wc_1}<br /><br />${sumCls_wc_1}</td>
		                <td>-<br /><br />-</td>		                
		            </tr>            		                    
	            <!-- 부문(심사) 끝 -->  
	            	            
	            <!-- 기타(물보험) 부문 시작 -->
	            <c:forEach var="sector" items="${TeamSectorListVO}" varStatus="status">	            	
	            	<c:if test="${sector.team_sector eq 9}">
	            		<c:set var="reg_12" value="${sector.reg_12}" />
						<c:set var="reg_11" value="${sector.reg_11}" />
						<c:set var="reg_10" value="${sector.reg_10}" />
						<c:set var="reg_9" value="${sector.reg_9}" />
						<c:set var="reg_8" value="${sector.reg_8}" />
						<c:set var="reg_7" value="${sector.reg_7}" />
						<c:set var="reg_6" value="${sector.reg_6}" />
						<c:set var="reg_5" value="${sector.reg_5}" />
						<c:set var="reg_4" value="${sector.reg_4}" />
						<c:set var="reg_3" value="${sector.reg_3}" />
						<c:set var="reg_2" value="${sector.reg_2}" />
						<c:set var="reg_1" value="${sector.reg_1}" />
						<c:set var="reg_sum" value="${reg_12+reg_11+reg_10+reg_9+reg_8+reg_7+reg_6+reg_5+reg_4+reg_3+reg_2+reg_1}" />
						
						<c:set var="cls_12" value="${sector.cls_12}" />
						<c:set var="cls_11" value="${sector.cls_11}" />
						<c:set var="cls_10" value="${sector.cls_10}" />
						<c:set var="cls_9" value="${sector.cls_9}" />
						<c:set var="cls_8" value="${sector.cls_8}" />
						<c:set var="cls_7" value="${sector.cls_7}" />
						<c:set var="cls_6" value="${sector.cls_6}" />
						<c:set var="cls_5" value="${sector.cls_5}" />
						<c:set var="cls_4" value="${sector.cls_4}" />
						<c:set var="cls_3" value="${sector.cls_3}" />
						<c:set var="cls_2" value="${sector.cls_2}" />
						<c:set var="cls_1" value="${sector.cls_1}" />
						<c:set var="cls_sum" value="${cls_12+cls_11+cls_10+cls_9+cls_8+cls_7+cls_6+cls_5+cls_4+cls_3+cls_2+cls_1}" />
	            		
	            		<c:set var="member_cnt" value="${sector.member_cnt}" />
	            		<tr>
	                    	<td>${sector.team_sector_val} (${member_cnt})</td>
	                    	<td>수임<br /><br />종결</td>                    		            		
		                    <td bgcolor="#faebd7">
		            			${reg_sum}
								<br /><br />
		                        ${cls_sum}
		                    </td>
		                    <td bgcolor="#faebd7">		                    	
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sum eq 0 && cls_sum ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sum / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sum ne 0 && cls_sum eq 0}">
		                    			<fmt:formatNumber value="${reg_sum / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sum / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sum / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_12}<br /><br />${cls_12}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_12 eq 0 && cls_12 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_12 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_12 ne 0 && cls_12 eq 0}">
		                    			<fmt:formatNumber value="${reg_12 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_12 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_12 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td> 
		                    <td>${reg_11}<br /><br />${cls_11}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_11 eq 0 && cls_11 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_11 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_11 ne 0 && cls_11 eq 0}">
		                    			<fmt:formatNumber value="${reg_11 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_11 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_11 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_10}<br /><br />${cls_10}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_10 eq 0 && cls_10 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_10 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_10 ne 0 && cls_10 eq 0}">
		                    			<fmt:formatNumber value="${reg_10 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_10 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_10 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_9}<br /><br />${cls_9}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_9 eq 0 && cls_9 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_9 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_9 ne 0 && cls_9 eq 0}">
		                    			<fmt:formatNumber value="${reg_9 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_9 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_9 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_8}<br /><br />${cls_8}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_8 eq 0 && cls_8 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_8 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_8 ne 0 && cls_8 eq 0}">
		                    			<fmt:formatNumber value="${reg_8 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_8 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_8 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_7}<br /><br />${cls_7}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_7 eq 0 && cls_7 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_7 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_7 ne 0 && cls_7 eq 0}">
		                    			<fmt:formatNumber value="${reg_7 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_7 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_7 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_6}<br /><br />${cls_6}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_6 eq 0 && cls_6 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_6 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_6 ne 0 && cls_6 eq 0}">
		                    			<fmt:formatNumber value="${reg_6 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_6 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_6 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_5}<br /><br />${cls_5}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_5 eq 0 && cls_5 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_5 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_5 ne 0 && cls_5 eq 0}">
		                    			<fmt:formatNumber value="${reg_5 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_5 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_5 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_4}<br /><br />${cls_4}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_4 eq 0 && cls_4 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_4 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_4 ne 0 && cls_4 eq 0}">
		                    			<fmt:formatNumber value="${reg_4 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_4 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_4 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_3}<br /><br />${cls_3}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_3 eq 0 && cls_3 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_3 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_3 ne 0 && cls_3 eq 0}">
		                    			<fmt:formatNumber value="${reg_3 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_3 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_3 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_2}<br /><br />${cls_2}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_2 eq 0 && cls_2 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_2 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_2 ne 0 && cls_2 eq 0}">
		                    			<fmt:formatNumber value="${reg_2 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_2 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_2 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_1}<br /><br />${cls_1}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_1 eq 0 && cls_1 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_1 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_1 ne 0 && cls_1 eq 0}">
		                    			<fmt:formatNumber value="${reg_1 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_1 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_1 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		               </tr>
		               <tr bgcolor="#E7ECF1">
	                    	<td>${sector.team_sector_val} 소계 (${member_cnt})</td>
	                    	<td>수임<br /><br />종결</td>                    		            		
		                    <td>
		            			${reg_sum}
								<br /><br />
		                        ${cls_sum}
		                    </td>
		                    <td>		                    	
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sum eq 0 && cls_sum ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sum / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sum ne 0 && cls_sum eq 0}">
		                    			<fmt:formatNumber value="${reg_sum / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sum / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sum / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_12}<br /><br />${cls_12}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_12 eq 0 && cls_12 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_12 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_12 ne 0 && cls_12 eq 0}">
		                    			<fmt:formatNumber value="${reg_12 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_12 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_12 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td> 
		                    <td>${reg_11}<br /><br />${cls_11}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_11 eq 0 && cls_11 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_11 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_11 ne 0 && cls_11 eq 0}">
		                    			<fmt:formatNumber value="${reg_11 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_11 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_11 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_10}<br /><br />${cls_10}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_10 eq 0 && cls_10 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_10 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_10 ne 0 && cls_10 eq 0}">
		                    			<fmt:formatNumber value="${reg_10 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_10 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_10 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_9}<br /><br />${cls_9}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_9 eq 0 && cls_9 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_9 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_9 ne 0 && cls_9 eq 0}">
		                    			<fmt:formatNumber value="${reg_9 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_9 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_9 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_8}<br /><br />${cls_8}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_8 eq 0 && cls_8 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_8 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_8 ne 0 && cls_8 eq 0}">
		                    			<fmt:formatNumber value="${reg_8 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_8 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_8 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_7}<br /><br />${cls_7}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_7 eq 0 && cls_7 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_7 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_7 ne 0 && cls_7 eq 0}">
		                    			<fmt:formatNumber value="${reg_7 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_7 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_7 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_6}<br /><br />${cls_6}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_6 eq 0 && cls_6 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_6 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_6 ne 0 && cls_6 eq 0}">
		                    			<fmt:formatNumber value="${reg_6 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_6 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_6 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_5}<br /><br />${cls_5}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_5 eq 0 && cls_5 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_5 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_5 ne 0 && cls_5 eq 0}">
		                    			<fmt:formatNumber value="${reg_5 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_5 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_5 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_4}<br /><br />${cls_4}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_4 eq 0 && cls_4 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_4 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_4 ne 0 && cls_4 eq 0}">
		                    			<fmt:formatNumber value="${reg_4 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_4 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_4 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_3}<br /><br />${cls_3}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_3 eq 0 && cls_3 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_3 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_3 ne 0 && cls_3 eq 0}">
		                    			<fmt:formatNumber value="${reg_3 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_3 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_3 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_2}<br /><br />${cls_2}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_2 eq 0 && cls_2 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_2 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_2 ne 0 && cls_2 eq 0}">
		                    			<fmt:formatNumber value="${reg_2 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_2 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_2 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_1}<br /><br />${cls_1}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_1 eq 0 && cls_1 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_1 / member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_1 ne 0 && cls_1 eq 0}">
		                    			<fmt:formatNumber value="${reg_1 / member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_1 / member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_1 / member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		               </tr>
	                 </c:if>
	            </c:forEach>
	            <!-- 기타(물보험)부문 끝 -->
	            
	            <!-- 물보험 합계 시작 -->
	            <tr bgcolor="#E7ECF1">
	                <td colspan="2">물보험 소계 (${sumSector_member_cnt})</td>
	                <td>수임<br /><br />종결</td>
	                <td>${sumReg_sum}<br /><br />${sumCls_sum}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_sum eq 0 && sumCls_sum ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_sum / sumSector_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_sum ne 0 && sumCls_sum eq 0}">
                    			<fmt:formatNumber value="${sumReg_sum / sumSector_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_sum / sumSector_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_sum / sumSector_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_12}<br /><br />${sumCls_12}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_12 eq 0 && sumCls_12 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_12 / sumSector_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_12 ne 0 && sumCls_12 eq 0}">
                    			<fmt:formatNumber value="${sumReg_12 / sumSector_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_12 / sumSector_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_12 / sumSector_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_11}<br /><br />${sumCls_11}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_11 eq 0 && sumCls_11 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_11 / sumSector_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_11 ne 0 && sumCls_11 eq 0}">
                    			<fmt:formatNumber value="${sumReg_11 / sumSector_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_11 / sumSector_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_11 / sumSector_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_10}<br /><br />${sumCls_10}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_10 eq 0 && sumCls_10 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_10 / sumSector_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_10 ne 0 && sumCls_10 eq 0}">
                    			<fmt:formatNumber value="${sumReg_10 / sumSector_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_10 / sumSector_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_10 / sumSector_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_9}<br /><br />${sumCls_9}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_9 eq 0 && sumCls_9 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_9 / sumSector_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_9 ne 0 && sumCls_9 eq 0}">
                    			<fmt:formatNumber value="${sumReg_9 / sumSector_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_9 / sumSector_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_9 / sumSector_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_8}<br /><br />${sumCls_8}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_8 eq 0 && sumCls_8 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_8 / sumSector_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_8 ne 0 && sumCls_8 eq 0}">
                    			<fmt:formatNumber value="${sumReg_8 / sumSector_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_8 / sumSector_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_8 / sumSector_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_7}<br /><br />${sumCls_7}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_7 eq 0 && sumCls_7 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_7 / sumSector_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_7 ne 0 && sumCls_7 eq 0}">
                    			<fmt:formatNumber value="${sumReg_7 / sumSector_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_7 / sumSector_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_7 / sumSector_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_6}<br /><br />${sumCls_6}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_6 eq 0 && sumCls_6 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_6 / sumSector_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_6 ne 0 && sumCls_6 eq 0}">
                    			<fmt:formatNumber value="${sumReg_6 / sumSector_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_6 / sumSector_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_6 / sumSector_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_5}<br /><br />${sumCls_5}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_5 eq 0 && sumCls_5 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_5 / sumSector_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_5 ne 0 && sumCls_5 eq 0}">
                    			<fmt:formatNumber value="${sumReg_5 / sumSector_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_5 / sumSector_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_5 / sumSector_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_4}<br /><br />${sumCls_4}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_4 eq 0 && sumCls_4 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_4 / sumSector_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_4 ne 0 && sumCls_4 eq 0}">
                    			<fmt:formatNumber value="${sumReg_4 / sumSector_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_4 / sumSector_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_4 / sumSector_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_3}<br /><br />${sumCls_3}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_3 eq 0 && sumCls_3 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_3 / sumSector_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_3 ne 0 && sumCls_3 eq 0}">
                    			<fmt:formatNumber value="${sumReg_3 / sumSector_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_3 / sumSector_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_3 / sumSector_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_2}<br /><br />${sumCls_2}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_2 eq 0 && sumCls_2 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_2 / sumSector_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_2 ne 0 && sumCls_2 eq 0}">
                    			<fmt:formatNumber value="${sumReg_2 / sumSector_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_2 / sumSector_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_2 / sumSector_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_1}<br /><br />${sumCls_1}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_1 eq 0 && sumCls_1 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_1 / sumSector_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_1 ne 0 && sumCls_1 eq 0}">
                    			<fmt:formatNumber value="${sumReg_1 / sumSector_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_1 / sumSector_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_1 / sumSector_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	            </tr>	            
	            <!-- 물보험 총 합계 끝 -->
	            
	            
	            <!-- 인보험(4종) 조사 심사 시작 -->
	            <c:forEach var="sector4" items="${TeamSector4ListVO}" varStatus="status">	            	
	            	<c:if test="${sector4.team_sector eq 5 || sector4.team_sector eq 6}">
	            	<!-- 인보험 조사심사 소계 시작 -->
            		<c:set var="sumReg_sector4_12" value="${sumReg_sector4_12 + sector4.reg_12}" />
					<c:set var="sumReg_sector4_11" value="${sumReg_sector4_11 + sector4.reg_11}" />
					<c:set var="sumReg_sector4_10" value="${sumReg_sector4_10 + sector4.reg_10}" />
					<c:set var="sumReg_sector4_9" value="${sumReg_sector4_9 + sector4.reg_9}" />
					<c:set var="sumReg_sector4_8" value="${sumReg_sector4_8 + sector4.reg_8}" />
					<c:set var="sumReg_sector4_7" value="${sumReg_sector4_7 + sector4.reg_7}" />
					<c:set var="sumReg_sector4_6" value="${sumReg_sector4_6 + sector4.reg_6}" />
					<c:set var="sumReg_sector4_5" value="${sumReg_sector4_5 + sector4.reg_5}" />
					<c:set var="sumReg_sector4_4" value="${sumReg_sector4_4 + sector4.reg_4}" />
					<c:set var="sumReg_sector4_3" value="${sumReg_sector4_3 + sector4.reg_3}" />
					<c:set var="sumReg_sector4_2" value="${sumReg_sector4_2 + sector4.reg_2}" />
					<c:set var="sumReg_sector4_1" value="${sumReg_sector4_1 + sector4.reg_1}" />
					<c:set var="sumReg_sector4_sum" value="${sumReg_sector4_sum + sector4.reg_12+sector4.reg_11+sector4.reg_10+sector4.reg_9+sector4.reg_8+sector4.reg_7+sector4.reg_6+sector4.reg_5+sector4.reg_4+sector4.reg_3+sector4.reg_2+sector4.reg_1}" />
					<c:set var="sumCls_sector4_12" value="${sumCls_sector4_12 + sector4.cls_12}" />
					<c:set var="sumCls_sector4_11" value="${sumCls_sector4_11 + sector4.cls_11}" />
					<c:set var="sumCls_sector4_10" value="${sumCls_sector4_10 + sector4.cls_10}" />
					<c:set var="sumCls_sector4_9" value="${sumCls_sector4_9 + sector4.cls_9}" />
					<c:set var="sumCls_sector4_8" value="${sumCls_sector4_8 + sector4.cls_8}" />
					<c:set var="sumCls_sector4_7" value="${sumCls_sector4_7 + sector4.cls_7}" />
					<c:set var="sumCls_sector4_6" value="${sumCls_sector4_6 + sector4.cls_6}" />
					<c:set var="sumCls_sector4_5" value="${sumCls_sector4_5 + sector4.cls_5}" />
					<c:set var="sumCls_sector4_4" value="${sumCls_sector4_4 + sector4.cls_4}" />
					<c:set var="sumCls_sector4_3" value="${sumCls_sector4_3 + sector4.cls_3}" />
					<c:set var="sumCls_sector4_2" value="${sumCls_sector4_2 + sector4.cls_2}" />
					<c:set var="sumCls_sector4_1" value="${sumCls_sector4_1 + sector4.cls_1}" />
					<c:set var="sumCls_sector4_sum" value="${sumCls_sector4_sum + sector4.cls_12+sector4.cls_11+sector4.cls_10+sector4.cls_9+sector4.cls_8+sector4.cls_7+sector4.cls_6+sector4.cls_5+sector4.cls_4+sector4.cls_3+sector4.cls_2+sector4.cls_1}" />
					
					<c:set var="sumSector4_member_mid_cnt" value="${sumSector4_member_mid_cnt + sector4.member_cnt}" />
					<!-- 인보험 조사심사 소계 끝 -->
            		
            		<c:set var="reg_sector4_12" value="${sector4.reg_12}" />
					<c:set var="reg_sector4_11" value="${sector4.reg_11}" />
					<c:set var="reg_sector4_10" value="${sector4.reg_10}" />
					<c:set var="reg_sector4_9" value="${sector4.reg_9}" />
					<c:set var="reg_sector4_8" value="${sector4.reg_8}" />
					<c:set var="reg_sector4_7" value="${sector4.reg_7}" />
					<c:set var="reg_sector4_6" value="${sector4.reg_6}" />
					<c:set var="reg_sector4_5" value="${sector4.reg_5}" />
					<c:set var="reg_sector4_4" value="${sector4.reg_4}" />
					<c:set var="reg_sector4_3" value="${sector4.reg_3}" />
					<c:set var="reg_sector4_2" value="${sector4.reg_2}" />
					<c:set var="reg_sector4_1" value="${sector4.reg_1}" />
					<c:set var="reg_sector4_sum" value="${reg_sector4_12+reg_sector4_11+reg_sector4_10+reg_sector4_9+reg_sector4_8+reg_sector4_7+reg_sector4_6+reg_sector4_5+reg_sector4_4+reg_sector4_3+reg_sector4_2+reg_sector4_1}" />
					
					<c:set var="cls_sector4_12" value="${sector4.cls_12}" />
					<c:set var="cls_sector4_11" value="${sector4.cls_11}" />
					<c:set var="cls_sector4_10" value="${sector4.cls_10}" />
					<c:set var="cls_sector4_9" value="${sector4.cls_9}" />
					<c:set var="cls_sector4_8" value="${sector4.cls_8}" />
					<c:set var="cls_sector4_7" value="${sector4.cls_7}" />
					<c:set var="cls_sector4_6" value="${sector4.cls_6}" />
					<c:set var="cls_sector4_5" value="${sector4.cls_5}" />
					<c:set var="cls_sector4_4" value="${sector4.cls_4}" />
					<c:set var="cls_sector4_3" value="${sector4.cls_3}" />
					<c:set var="cls_sector4_2" value="${sector4.cls_2}" />
					<c:set var="cls_sector4_1" value="${sector4.cls_1}" />
					<c:set var="cls_sector4_sum" value="${cls_sector4_12+cls_sector4_11+cls_sector4_10+cls_sector4_9+cls_sector4_8+cls_sector4_7+cls_sector4_6+cls_sector4_5+cls_sector4_4+cls_sector4_3+cls_sector4_2+cls_sector4_1}" />
					
					<c:set var="sector4_member_cnt" value="${sector4.member_cnt}" />	            	
	            	
	            	<tr>
	            		<c:if test="${sector4.team_sector eq 5}">	            		
                       		<td rowspan="5">인보험</td>                   	
                       	</c:if>
                    	<td>${sector4.team_sector_val} (${sector4_member_cnt})</td>
                    	<td>수임<br /><br />종결</td>                    		            		
	                    <td bgcolor="#faebd7">
	            			${reg_sector4_sum}
							<br /><br />
	                        ${cls_sector4_sum}
	                    </td>
	                    <td bgcolor="#faebd7">		                    	
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ sector4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_sum eq 0 && cls_sector4_sum ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_sum / sector4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_sum ne 0 && cls_sector4_sum eq 0}">
	                    			<fmt:formatNumber value="${reg_sector4_sum / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_sector4_sum / sector4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_sector4_sum / sector4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_sector4_12}<br /><br />${cls_sector4_12}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ sector4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_12 eq 0 && cls_sector4_12 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_12 / sector4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_12 ne 0 && cls_sector4_12 eq 0}">
	                    			<fmt:formatNumber value="${reg_sector4_12 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_sector4_12 / sector4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_sector4_12 / sector4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td> 
	                    <td>${reg_sector4_11}<br /><br />${cls_sector4_11}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ sector4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_11 eq 0 && cls_sector4_11 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_11 / sector4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_11 ne 0 && cls_sector4_11 eq 0}">
	                    			<fmt:formatNumber value="${reg_sector4_11 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_sector4_11 / sector4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_sector4_11 / sector4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_sector4_10}<br /><br />${cls_sector4_10}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ sector4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_10 eq 0 && cls_sector4_10 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_10 / sector4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_10 ne 0 && cls_sector4_10 eq 0}">
	                    			<fmt:formatNumber value="${reg_sector4_10 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_sector4_10 / sector4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_sector4_10 / sector4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_sector4_9}<br /><br />${cls_sector4_9}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ sector4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_9 eq 0 && cls_sector4_9 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_9 / sector4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_9 ne 0 && cls_sector4_9 eq 0}">
	                    			<fmt:formatNumber value="${reg_sector4_9 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_sector4_9 / sector4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_sector4_9 / sector4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_sector4_8}<br /><br />${cls_sector4_8}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ sector4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_8 eq 0 && cls_sector4_8 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_8 / sector4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_8 ne 0 && cls_sector4_8 eq 0}">
	                    			<fmt:formatNumber value="${reg_sector4_8 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_sector4_8 / sector4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_sector4_8 / sector4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_sector4_7}<br /><br />${cls_sector4_7}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ sector4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_7 eq 0 && cls_sector4_7 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_7 / sector4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_7 ne 0 && cls_sector4_7 eq 0}">
	                    			<fmt:formatNumber value="${reg_sector4_7 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_sector4_7 / sector4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_sector4_7 / sector4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_sector4_6}<br /><br />${cls_sector4_6}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ sector4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_6 eq 0 && cls_sector4_6 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_6 / sector4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_6 ne 0 && cls_sector4_6 eq 0}">
	                    			<fmt:formatNumber value="${reg_sector4_6 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_sector4_6 / sector4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_sector4_6 / sector4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_sector4_5}<br /><br />${cls_sector4_5}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ sector4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_5 eq 0 && cls_sector4_5 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_5 / sector4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_5 ne 0 && cls_sector4_5 eq 0}">
	                    			<fmt:formatNumber value="${reg_sector4_5 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_sector4_5 / sector4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_sector4_5 / sector4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_sector4_4}<br /><br />${cls_sector4_4}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ sector4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_4 eq 0 && cls_sector4_4 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_4 / sector4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_4 ne 0 && cls_sector4_4 eq 0}">
	                    			<fmt:formatNumber value="${reg_sector4_4 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_sector4_4 / sector4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_sector4_4 / sector4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_sector4_3}<br /><br />${cls_sector4_3}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ sector4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_3 eq 0 && cls_sector4_3 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_3 / sector4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_3 ne 0 && cls_sector4_3 eq 0}">
	                    			<fmt:formatNumber value="${reg_sector4_3 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_sector4_3 / sector4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_sector4_3 / sector4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_sector4_2}<br /><br />${cls_sector4_2}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ sector4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_2 eq 0 && cls_sector4_2 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_2 / sector4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_2 ne 0 && cls_sector4_2 eq 0}">
	                    			<fmt:formatNumber value="${reg_sector4_2 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_sector4_2 / sector4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_sector4_2 / sector4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>
	                    <td>${reg_sector4_1}<br /><br />${cls_sector4_1}</td>
	                    <td>
	                    	<font color="blue">
	                    	<c:choose>
	                    		<c:when test="${ sector4_member_cnt eq 0}">
	                    			0<br /><br />0			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_1 eq 0 && cls_sector4_1 ne 0}">
	                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_1 / sector4_member_cnt}" pattern="#.#"/>			
	                    		</c:when>
	                    		<c:when test="${ reg_sector4_1 ne 0 && cls_sector4_1 eq 0}">
	                    			<fmt:formatNumber value="${reg_sector4_1 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
	                    		</c:when>
	                    		<c:otherwise>
	                    			<fmt:formatNumber value="${reg_sector4_1 / sector4_member_cnt}" pattern="#.#"/>
	                    			<br/><br/>
	                    			<fmt:formatNumber value="${cls_sector4_1 / sector4_member_cnt}" pattern="#.#"/>
	                    		</c:otherwise>
	                    	</c:choose>
	                    	</font>
	                    </td>                
	            	</tr>
	            	</c:if>	            		            	
	            	<!-- 인보험 소계 시작 -->
                    <c:set var="sumReg4_12" value="${sumReg4_12 + sector4.reg_12}" />
                    <c:set var="sumReg4_11" value="${sumReg4_11 + sector4.reg_11}" />
                    <c:set var="sumReg4_10" value="${sumReg4_10 + sector4.reg_10}" />
                    <c:set var="sumReg4_9" value="${sumReg4_9 + sector4.reg_9}" />
                    <c:set var="sumReg4_8" value="${sumReg4_8 + sector4.reg_8}" />
                    <c:set var="sumReg4_7" value="${sumReg4_7 + sector4.reg_7}" />
                    <c:set var="sumReg4_6" value="${sumReg4_6 + sector4.reg_6}" />
                    <c:set var="sumReg4_5" value="${sumReg4_5 + sector4.reg_5}" />
                    <c:set var="sumReg4_4" value="${sumReg4_4 + sector4.reg_4}" />
                    <c:set var="sumReg4_3" value="${sumReg4_3 + sector4.reg_3}" />
                    <c:set var="sumReg4_2" value="${sumReg4_2 + sector4.reg_2}" />
                    <c:set var="sumReg4_1" value="${sumReg4_1 + sector4.reg_1}" />
                    <c:set var="sumReg4_sum" value="${sumReg4_sum+sector4.reg_12+sector4.reg_11+sector4.reg_10+sector4.reg_9+sector4.reg_8+sector4.reg_7+sector4.reg_6+sector4.reg_5+sector4.reg_4+sector4.reg_3+sector4.reg_2+sector4.reg_1}" />
                    
                    <c:set var="sumCls4_12" value="${sumCls4_12 + sector4.cls_12}" />
                    <c:set var="sumCls4_11" value="${sumCls4_11 + sector4.cls_11}" />
                    <c:set var="sumCls4_10" value="${sumCls4_10 + sector4.cls_10}" />
                    <c:set var="sumCls4_9" value="${sumCls4_9 + sector4.cls_9}" />
                    <c:set var="sumCls4_8" value="${sumCls4_8 + sector4.cls_8}" />
                    <c:set var="sumCls4_7" value="${sumCls4_7 + sector4.cls_7}" />
                    <c:set var="sumCls4_6" value="${sumCls4_6 + sector4.cls_6}" />
                    <c:set var="sumCls4_5" value="${sumCls4_5 + sector4.cls_5}" />
                    <c:set var="sumCls4_4" value="${sumCls4_4 + sector4.cls_4}" />
                    <c:set var="sumCls4_3" value="${sumCls4_3 + sector4.cls_3}" />
                    <c:set var="sumCls4_2" value="${sumCls4_2 + sector4.cls_2}" />
                    <c:set var="sumCls4_1" value="${sumCls4_1 + sector4.cls_1}" />
                    <c:set var="sumCls4_sum" value="${sumCls4_sum+sector4.cls_12+sector4.cls_11+sector4.cls_10+sector4.cls_9+sector4.cls_8+sector4.cls_7+sector4.cls_6+sector4.cls_5+sector4.cls_4+sector4.cls_3+sector4.cls_2+sector4.cls_1}"/>
                    
                    <c:set var="sumSector4_member_cnt" value="${sumSector4_member_cnt + sector4.member_cnt}" />
                    
                    <!-- 인보험 소계 끝 -->	
	            </c:forEach>
	              	            
	            <!-- 인보험 조사심사 소계 표시 시작 -->
	            <tr bgcolor="#E7ECF1">
	                <td>인보험 조사심사 소계 (${sumSector4_member_mid_cnt})</td>
	                <td>수임<br /><br />종결</td>
	                <td>${sumReg_sector4_sum}<br /><br />${sumCls_sector4_sum}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_sum eq 0 && sumCls_sector4_sum ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_sector4_sum / sumSector4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_sum ne 0 && sumCls_sector4_sum eq 0}">
                    			<fmt:formatNumber value="${sumReg_sector4_sum / sumSector4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_sector4_sum / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_sector4_sum / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_sector4_12}<br /><br />${sumCls_sector4_12}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_12 eq 0 && sumCls_sector4_12 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_sector4_12 / sumSector4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_12 ne 0 && sumCls_sector4_12 eq 0}">
                    			<fmt:formatNumber value="${sumReg_sector4_12 / sumSector4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_sector4_12 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_sector4_12 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_sector4_11}<br /><br />${sumCls_sector4_11}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_11 eq 0 && sumCls_sector4_11 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_sector4_11 / sumSector4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_11 ne 0 && sumCls_sector4_11 eq 0}">
                    			<fmt:formatNumber value="${sumReg_sector4_11 / sumSector4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_sector4_11 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_sector4_11 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_sector4_10}<br /><br />${sumCls_sector4_10}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_10 eq 0 && sumCls_sector4_10 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_sector4_10 / sumSector4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_10 ne 0 && sumCls_sector4_10 eq 0}">
                    			<fmt:formatNumber value="${sumReg_sector4_10 / sumSector4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_sector4_10 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_sector4_10 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_sector4_9}<br /><br />${sumCls_sector4_9}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_9 eq 0 && sumCls_sector4_9 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_sector4_9 / sumSector4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_9 ne 0 && sumCls_sector4_9 eq 0}">
                    			<fmt:formatNumber value="${sumReg_sector4_9 / sumSector4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_sector4_9 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_sector4_9 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_sector4_8}<br /><br />${sumCls_sector4_8}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_8 eq 0 && sumCls_sector4_8 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_sector4_8 / sumSector4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_8 ne 0 && sumCls_sector4_8 eq 0}">
                    			<fmt:formatNumber value="${sumReg_sector4_8 / sumSector4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_sector4_8 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_sector4_8 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_sector4_7}<br /><br />${sumCls_sector4_7}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_7 eq 0 && sumCls_sector4_7 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_sector4_7 / sumSector4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_7 ne 0 && sumCls_sector4_7 eq 0}">
                    			<fmt:formatNumber value="${sumReg_sector4_7 / sumSector4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_sector4_7 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_sector4_7 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_sector4_6}<br /><br />${sumCls_sector4_6}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_6 eq 0 && sumCls_sector4_6 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_sector4_6 / sumSector4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_6 ne 0 && sumCls_sector4_6 eq 0}">
                    			<fmt:formatNumber value="${sumReg_sector4_6 / sumSector4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_sector4_6 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_sector4_6 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_sector4_5}<br /><br />${sumCls_sector4_5}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_5 eq 0 && sumCls_sector4_5 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_sector4_5 / sumSector4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_5 ne 0 && sumCls_sector4_5 eq 0}">
                    			<fmt:formatNumber value="${sumReg_sector4_5 / sumSector4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_sector4_5 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_sector4_5 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_sector4_4}<br /><br />${sumCls_sector4_4}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_4 eq 0 && sumCls_sector4_4 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_sector4_4 / sumSector4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_4 ne 0 && sumCls_sector4_4 eq 0}">
                    			<fmt:formatNumber value="${sumReg_sector4_4 / sumSector4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_sector4_4 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_sector4_4 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_sector4_3}<br /><br />${sumCls_sector4_3}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_3 eq 0 && sumCls_sector4_3 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_sector4_3 / sumSector4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_3 ne 0 && sumCls_sector4_3 eq 0}">
                    			<fmt:formatNumber value="${sumReg_sector4_3 / sumSector4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_sector4_3 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_sector4_3 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_sector4_2}<br /><br />${sumCls_sector4_2}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_2 eq 0 && sumCls_sector4_2 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_sector4_2 / sumSector4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_2 ne 0 && sumCls_sector4_2 eq 0}">
                    			<fmt:formatNumber value="${sumReg_sector4_2 / sumSector4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_sector4_2 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_sector4_2 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg_sector4_1}<br /><br />${sumCls_sector4_1}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_mid_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_1 eq 0 && sumCls_sector4_1 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_sector4_1 / sumSector4_member_mid_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_sector4_1 ne 0 && sumCls_sector4_1 eq 0}">
                    			<fmt:formatNumber value="${sumReg_sector4_1 / sumSector4_member_mid_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_sector4_1 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_sector4_1 / sumSector4_member_mid_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>	                
	            </tr>
	            <!-- 인보험 조사심사 소계 표시 끝 -->
	          	
	            <!-- 기타(인보험) 부문 시작 -->
	            <c:forEach var="sector4" items="${TeamSector4ListVO}" varStatus="status">	            	
	            	<c:if test="${sector4.team_sector eq 9}">
	            		<c:set var="reg_sector4_12" value="${sector4.reg_12}" />
						<c:set var="reg_sector4_11" value="${sector4.reg_11}" />
						<c:set var="reg_sector4_10" value="${sector4.reg_10}" />
						<c:set var="reg_sector4_9" value="${sector4.reg_9}" />
						<c:set var="reg_sector4_8" value="${sector4.reg_8}" />
						<c:set var="reg_sector4_7" value="${sector4.reg_7}" />
						<c:set var="reg_sector4_6" value="${sector4.reg_6}" />
						<c:set var="reg_sector4_5" value="${sector4.reg_5}" />
						<c:set var="reg_sector4_4" value="${sector4.reg_4}" />
						<c:set var="reg_sector4_3" value="${sector4.reg_3}" />
						<c:set var="reg_sector4_2" value="${sector4.reg_2}" />
						<c:set var="reg_sector4_1" value="${sector4.reg_1}" />
						<c:set var="reg_sector4_sum" value="${reg_sector4_12+reg_sector4_11+reg_sector4_10+reg_sector4_9+reg_sector4_8+reg_sector4_7+reg_sector4_6+reg_sector4_5+reg_sector4_4+reg_sector4_3+reg_sector4_2+reg_sector4_1}" />
						
						<c:set var="cls_sector4_12" value="${sector4.cls_12}" />
						<c:set var="cls_sector4_11" value="${sector4.cls_11}" />
						<c:set var="cls_sector4_10" value="${sector4.cls_10}" />
						<c:set var="cls_sector4_9" value="${sector4.cls_9}" />
						<c:set var="cls_sector4_8" value="${sector4.cls_8}" />
						<c:set var="cls_sector4_7" value="${sector4.cls_7}" />
						<c:set var="cls_sector4_6" value="${sector4.cls_6}" />
						<c:set var="cls_sector4_5" value="${sector4.cls_5}" />
						<c:set var="cls_sector4_4" value="${sector4.cls_4}" />
						<c:set var="cls_sector4_3" value="${sector4.cls_3}" />
						<c:set var="cls_sector4_2" value="${sector4.cls_2}" />
						<c:set var="cls_sector4_1" value="${sector4.cls_1}" />
						<c:set var="cls_sector4_sum" value="${cls_sector4_12+cls_sector4_11+cls_sector4_10+cls_sector4_9+cls_sector4_8+cls_sector4_7+cls_sector4_6+cls_sector4_5+cls_sector4_4+cls_sector4_3+cls_sector4_2+cls_sector4_1}" />
	            		
	            		<c:set var="sector4_member_cnt" value="${sector4.member_cnt}" />
	            		<tr>
	                    	<td>${sector4.team_sector_val} (${sector4_member_cnt})</td>
	                    	<td>수임<br /><br />종결</td>                    		            		
		                    <td bgcolor="#faebd7">
	            			${reg_sector4_sum}
							<br /><br />
	                        ${cls_sector4_sum}
		                    </td>
		                    <td bgcolor="#faebd7">		                    	
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_sum eq 0 && cls_sector4_sum ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_sum / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_sum ne 0 && cls_sector4_sum eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_sum / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_sum / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_sum / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_12}<br /><br />${cls_sector4_12}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_12 eq 0 && cls_sector4_12 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_12 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_12 ne 0 && cls_sector4_12 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_12 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_12 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_12 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td> 
		                    <td>${reg_sector4_11}<br /><br />${cls_sector4_11}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_11 eq 0 && cls_sector4_11 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_11 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_11 ne 0 && cls_sector4_11 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_11 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_11 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_11 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_10}<br /><br />${cls_sector4_10}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_10 eq 0 && cls_sector4_10 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_10 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_10 ne 0 && cls_sector4_10 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_10 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_10 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_10 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_9}<br /><br />${cls_sector4_9}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_9 eq 0 && cls_sector4_9 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_9 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_9 ne 0 && cls_sector4_9 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_9 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_9 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_9 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_8}<br /><br />${cls_sector4_8}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_8 eq 0 && cls_sector4_8 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_8 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_8 ne 0 && cls_sector4_8 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_8 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_8 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_8 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_7}<br /><br />${cls_sector4_7}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_7 eq 0 && cls_sector4_7 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_7 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_7 ne 0 && cls_sector4_7 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_7 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_7 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_7 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_6}<br /><br />${cls_sector4_6}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_6 eq 0 && cls_sector4_6 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_6 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_6 ne 0 && cls_sector4_6 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_6 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_6 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_6 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_5}<br /><br />${cls_sector4_5}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_5 eq 0 && cls_sector4_5 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_5 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_5 ne 0 && cls_sector4_5 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_5 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_5 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_5 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_4}<br /><br />${cls_sector4_4}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_4 eq 0 && cls_sector4_4 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_4 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_4 ne 0 && cls_sector4_4 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_4 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_4 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_4 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_3}<br /><br />${cls_sector4_3}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_3 eq 0 && cls_sector4_3 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_3 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_3 ne 0 && cls_sector4_3 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_3 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_3 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_3 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_2}<br /><br />${cls_sector4_2}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_2 eq 0 && cls_sector4_2 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_2 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_2 ne 0 && cls_sector4_2 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_2 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_2 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_2 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_1}<br /><br />${cls_sector4_1}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_1 eq 0 && cls_sector4_1 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_1 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_1 ne 0 && cls_sector4_1 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_1 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_1 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_1 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		               </tr>
		               <tr bgcolor="#E7ECF1">
	                    	<td>${sector4.team_sector_val} 소계 (${sector4_member_cnt})</td>
	                    	<td>수임<br /><br />종결</td>                    		            		
		                    <td>
		            			${reg_sector4_sum}
								<br /><br />
		                        ${cls_sector4_sum}
		                    </td>
		                    <td>		                    	
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_sum eq 0 && cls_sector4_sum ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_sum / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_sum ne 0 && cls_sector4_sum eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_sum / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_sum / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_sum / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_12}<br /><br />${cls_sector4_12}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_12 eq 0 && cls_sector4_12 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_12 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_12 ne 0 && cls_sector4_12 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_12 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_12 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_12 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td> 
		                    <td>${reg_sector4_11}<br /><br />${cls_sector4_11}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_11 eq 0 && cls_sector4_11 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_11 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_11 ne 0 && cls_sector4_11 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_11 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_11 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_11 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_10}<br /><br />${cls_sector4_10}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_10 eq 0 && cls_sector4_10 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_10 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_10 ne 0 && cls_sector4_10 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_10 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_10 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_10 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_9}<br /><br />${cls_sector4_9}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_9 eq 0 && cls_sector4_9 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_9 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_9 ne 0 && cls_sector4_9 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_9 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_9 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_9 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_8}<br /><br />${cls_sector4_8}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_8 eq 0 && cls_sector4_8 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_8 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_8 ne 0 && cls_sector4_8 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_8 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_8 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_8 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_7}<br /><br />${cls_sector4_7}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_7 eq 0 && cls_sector4_7 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_7 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_7 ne 0 && cls_sector4_7 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_7 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_7 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_7 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_6}<br /><br />${cls_sector4_6}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_6 eq 0 && cls_sector4_6 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_6 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_6 ne 0 && cls_sector4_6 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_6 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_6 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_6 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_5}<br /><br />${cls_sector4_5}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_5 eq 0 && cls_sector4_5 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_5 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_5 ne 0 && cls_sector4_5 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_5 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_5 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_5 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_4}<br /><br />${cls_sector4_4}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_4 eq 0 && cls_sector4_4 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_4 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_4 ne 0 && cls_sector4_4 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_4 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_4 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_4 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_3}<br /><br />${cls_sector4_3}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_3 eq 0 && cls_sector4_3 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_3 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_3 ne 0 && cls_sector4_3 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_3 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_3 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_3 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_2}<br /><br />${cls_sector4_2}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_2 eq 0 && cls_sector4_2 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_2 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_2 ne 0 && cls_sector4_2 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_2 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_2 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_2 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		                    <td>${reg_sector4_1}<br /><br />${cls_sector4_1}</td>
		                    <td>
		                    	<font color="blue">
		                    	<c:choose>
		                    		<c:when test="${ sector4_member_cnt eq 0}">
		                    			0<br /><br />0			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_1 eq 0 && cls_sector4_1 ne 0}">
		                    			0<br /><br /><fmt:formatNumber value="${cls_sector4_1 / sector4_member_cnt}" pattern="#.#"/>			
		                    		</c:when>
		                    		<c:when test="${ reg_sector4_1 ne 0 && cls_sector4_1 eq 0}">
		                    			<fmt:formatNumber value="${reg_sector4_1 / sector4_member_cnt}" pattern="#.#"/><br /><br />0			
		                    		</c:when>
		                    		<c:otherwise>
		                    			<fmt:formatNumber value="${reg_sector4_1 / sector4_member_cnt}" pattern="#.#"/>
		                    			<br/><br/>
		                    			<fmt:formatNumber value="${cls_sector4_1 / sector4_member_cnt}" pattern="#.#"/>
		                    		</c:otherwise>
		                    	</c:choose>
		                    	</font>
		                    </td>
		               </tr>
	                 </c:if>
	            </c:forEach>
	            <!-- 기타(인보험)부문 끝 -->
	            
	            <!-- 인보험 합계 표시 시작 -->
	            <tr bgcolor="#E7ECF1">
	                <td colspan="2">인보험 소계 (${sumSector4_member_cnt})</td>
	                <td>수임<br /><br />종결</td>
	                <td>${sumReg4_sum}<br /><br />${sumCls4_sum}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_sum eq 0 && sumCls4_sum ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_sum / sumSector4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_sum ne 0 && sumCls4_sum eq 0}">
                    			<fmt:formatNumber value="${sumReg4_sum / sumSector4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_sum / sumSector4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_sum / sumSector4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_12}<br /><br />${sumCls4_12}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_12 eq 0 && sumCls4_12 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_12 / sumSector4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_12 ne 0 && sumCls4_12 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_12 / sumSector4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_12 / sumSector4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_12 / sumSector4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_11}<br /><br />${sumCls4_11}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_11 eq 0 && sumCls4_11 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_11 / sumSector4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_11 ne 0 && sumCls4_11 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_11 / sumSector4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_11 / sumSector4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_11 / sumSector4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_10}<br /><br />${sumCls4_10}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_10 eq 0 && sumCls4_10 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_10 / sumSector4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_10 ne 0 && sumCls4_10 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_10 / sumSector4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_10 / sumSector4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_10 / sumSector4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_9}<br /><br />${sumCls4_9}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_9 eq 0 && sumCls4_9 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_9 / sumSector4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_9 ne 0 && sumCls4_9 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_9 / sumSector4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_9 / sumSector4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_9 / sumSector4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_8}<br /><br />${sumCls4_8}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_8 eq 0 && sumCls4_8 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_8 / sumSector4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_8 ne 0 && sumCls4_8 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_8 / sumSector4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_8 / sumSector4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_8 / sumSector4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_7}<br /><br />${sumCls4_7}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_7 eq 0 && sumCls4_7 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_7 / sumSector4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_7 ne 0 && sumCls4_7 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_7 / sumSector4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_7 / sumSector4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_7 / sumSector4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_6}<br /><br />${sumCls4_6}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_6 eq 0 && sumCls4_6 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_6 / sumSector4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_6 ne 0 && sumCls4_6 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_6 / sumSector4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_6 / sumSector4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_6 / sumSector4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_5}<br /><br />${sumCls4_5}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_5 eq 0 && sumCls4_5 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_5 / sumSector4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_5 ne 0 && sumCls4_5 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_5 / sumSector4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_5 / sumSector4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_5 / sumSector4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_4}<br /><br />${sumCls4_4}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_4 eq 0 && sumCls4_4 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_4 / sumSector4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_4 ne 0 && sumCls4_4 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_4 / sumSector4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_4 / sumSector4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_4 / sumSector4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_3}<br /><br />${sumCls4_3}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_3 eq 0 && sumCls4_3 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_3 / sumSector4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_3 ne 0 && sumCls4_3 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_3 / sumSector4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_3 / sumSector4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_3 / sumSector4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_2}<br /><br />${sumCls4_2}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_2 eq 0 && sumCls4_2 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_2 / sumSector4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_2 ne 0 && sumCls4_2 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_2 / sumSector4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_2 / sumSector4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_2 / sumSector4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
	                <td>${sumReg4_1}<br /><br />${sumCls4_1}</td>
	                <td>		                    	
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumSector4_member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_1 eq 0 && sumCls4_1 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_1 / sumSector4_member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_1 ne 0 && sumCls4_1 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_1 / sumSector4_member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_1 / sumSector4_member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_1 / sumSector4_member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>	                
	            </tr>
	            <!-- 인보험 합계 표시 끝 -->
	            	            
	            <!-- 인보험(4종) 끝 -->	            
	            <!-- 전체 합계 시작 -->
	            <c:set var="allMember_cnt" value="${sumSector_member_cnt+sumSector4_member_cnt}" />
            	<c:set var="allSumReg_12" value="${sumReg_12+sumReg4_12}" />
            	<c:set var="allSumReg_11" value="${sumReg_11+sumReg4_11}" />
            	<c:set var="allSumReg_10" value="${sumReg_10+sumReg4_10}" />
            	<c:set var="allSumReg_9" value="${sumReg_9+sumReg4_9}" />
            	<c:set var="allSumReg_8" value="${sumReg_8+sumReg4_8}" />
            	<c:set var="allSumReg_7" value="${sumReg_7+sumReg4_7}" />
            	<c:set var="allSumReg_6" value="${sumReg_6+sumReg4_6}" />
            	<c:set var="allSumReg_5" value="${sumReg_5+sumReg4_5}" />
            	<c:set var="allSumReg_4" value="${sumReg_4+sumReg4_4}" />
            	<c:set var="allSumReg_3" value="${sumReg_3+sumReg4_3}" />
            	<c:set var="allSumReg_2" value="${sumReg_2+sumReg4_2}" />
            	<c:set var="allSumReg_1" value="${sumReg_1+sumReg4_1}" />
            	<c:set var="allSumReg_sum" value="${sumReg_sum+sumReg4_sum}" />
            	
            	<c:set var="allSumCls_12" value="${sumCls_12+sumCls4_12}" />
            	<c:set var="allSumCls_11" value="${sumCls_11+sumCls4_11}" />
            	<c:set var="allSumCls_10" value="${sumCls_10+sumCls4_10}" />
            	<c:set var="allSumCls_9" value="${sumCls_9+sumCls4_9}" />
            	<c:set var="allSumCls_8" value="${sumCls_8+sumCls4_8}" />
            	<c:set var="allSumCls_7" value="${sumCls_7+sumCls4_7}" />
            	<c:set var="allSumCls_6" value="${sumCls_6+sumCls4_6}" />
            	<c:set var="allSumCls_5" value="${sumCls_5+sumCls4_5}" />
            	<c:set var="allSumCls_4" value="${sumCls_4+sumCls4_4}" />
            	<c:set var="allSumCls_3" value="${sumCls_3+sumCls4_3}" />
            	<c:set var="allSumCls_2" value="${sumCls_2+sumCls4_2}" />
            	<c:set var="allSumCls_1" value="${sumCls_1+sumCls4_1}" />
            	<c:set var="allSumCls_sum" value="${sumCls_sum+sumCls4_sum}" />
            	
	            <tr bgcolor="#E7ECF1">
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
