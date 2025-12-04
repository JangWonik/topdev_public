<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2">
    <div style="padding-right: 17px; background: #e7ecf1;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
            <colgroup>
                <col width="65">
                <col width="130">
                <col width="65">
                <col width="65">
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
                <th rowspan="2" colspan="3">팀 (인원)</th>
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
                <col width="65">
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
            <c:forEach var="vo" items="${getMisRegTm1}" varStatus="status">
            	<c:set var="sumReg_12" value="${sumReg_12 + vo.reg_12}" />
                <c:set var="sumReg_11" value="${sumReg_11 + vo.reg_11}" />
                <c:set var="sumReg_10" value="${sumReg_10 + vo.reg_10}" />
                <c:set var="sumReg_9" value="${sumReg_9 + vo.reg_9}" />
                <c:set var="sumReg_8" value="${sumReg_8 + vo.reg_8}" />
                <c:set var="sumReg_7" value="${sumReg_7 + vo.reg_7}" />
                <c:set var="sumReg_6" value="${sumReg_6 + vo.reg_6}" />
                <c:set var="sumReg_5" value="${sumReg_5 + vo.reg_5}" />
                <c:set var="sumReg_4" value="${sumReg_4 + vo.reg_4}" />
                <c:set var="sumReg_3" value="${sumReg_3 + vo.reg_3}" />
                <c:set var="sumReg_2" value="${sumReg_2 + vo.reg_2}" />
                <c:set var="sumReg_1" value="${sumReg_1 + vo.reg_1}" />
                <c:set var="sumReg_sum" value="${sumReg_sum + vo.reg_12+vo.reg_11+vo.reg_10+vo.reg_9+vo.reg_8+vo.reg_7+vo.reg_6+vo.reg_5+vo.reg_4+vo.reg_3+vo.reg_2+vo.reg_1}" />
                <c:set var="sumReg_ex" value="${vo.reg_12+vo.reg_11+vo.reg_10+vo.reg_9+vo.reg_8+vo.reg_7+vo.reg_6+vo.reg_5+vo.reg_4+vo.reg_3+vo.reg_2+vo.reg_1}" />
                <c:set var="sumCls_12" value="${sumCls_12 + vo.cls_12}" />
                <c:set var="sumCls_11" value="${sumCls_11 + vo.cls_11}" />
                <c:set var="sumCls_10" value="${sumCls_10 + vo.cls_10}" />
                <c:set var="sumCls_9" value="${sumCls_9 + vo.cls_9}" />
                <c:set var="sumCls_8" value="${sumCls_8 + vo.cls_8}" />
                <c:set var="sumCls_7" value="${sumCls_7 + vo.cls_7}" />
                <c:set var="sumCls_6" value="${sumCls_6 + vo.cls_6}" />
                <c:set var="sumCls_5" value="${sumCls_5 + vo.cls_5}" />
                <c:set var="sumCls_4" value="${sumCls_4 + vo.cls_4}" />
                <c:set var="sumCls_3" value="${sumCls_3 + vo.cls_3}" />
                <c:set var="sumCls_2" value="${sumCls_2 + vo.cls_2}" />
                <c:set var="sumCls_1" value="${sumCls_1 + vo.cls_1}" />
                <c:set var="sumCls_sum" value="${sumCls_sum + vo.cls_12+vo.cls_11+vo.cls_10+vo.cls_9+vo.cls_8+vo.cls_7+vo.cls_6+vo.cls_5+vo.cls_4+vo.cls_3+vo.cls_2+vo.cls_1}" />
                <c:set var="sumCls_ex" value="${vo.cls_12+vo.cls_11+vo.cls_10+vo.cls_9+vo.cls_8+vo.cls_7+vo.cls_6+vo.cls_5+vo.cls_4+vo.cls_3+vo.cls_2+vo.cls_1}" />
                <c:set var="member_cnt" value="${vo.member_cnt}" />
                <c:set var="sumMember_cnt" value="${sumMember_cnt + member_cnt}" />
                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${getMisRegTm1.size() + 1}">물보험</td>
                    </c:if>
                    <td>${vo.team_name} (${member_cnt})</td>
                    <td><a href="javascript:goMisRegTmMbr('${vo.team_id}','${vo.team_name}','${vo.team_type}');">개인별</a></td>
                    <td><a href="javascript:goMisRegTmPtnr('${vo.team_id}','${vo.team_name}','${vo.team_type}');">보험사별</a></td>
                    <td>수임<br /><br />종결</td>
                    <td bgcolor="#faebd7">
                    	${sumReg_ex}
                        <br /><br />
                        ${sumCls_ex}
                    </td>
                    <td bgcolor="#faebd7">
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_ex eq 0 && sumCls_ex ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_ex / member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_ex ne 0 && sumCls_ex eq 0}">
                    			<fmt:formatNumber value="${sumReg_ex / member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_ex / member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_ex / member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_12}<br /><br />${vo.cls_12}</td>                    
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_12 eq 0 && vo.cls_12 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_12 / member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_12 ne 0 && vo.cls_12 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_12 / member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_12 / member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_12 / member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_11}<br /><br />${vo.cls_11}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_11 eq 0 && vo.cls_11 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_11 / member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_11 ne 0 && vo.cls_11 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_11 / member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_11 / member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_11 / member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_10}<br /><br />${vo.cls_10}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_10 eq 0 && vo.cls_10 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_10 / member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_10 ne 0 && vo.cls_10 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_10 / member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_10 / member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_10 / member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_9}<br /><br />${vo.cls_9}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_9 eq 0 && vo.cls_9 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_9 / member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_9 ne 0 && vo.cls_9 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_9 / member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_9 / member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_9 / member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_8}<br /><br />${vo.cls_8}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_8 eq 0 && vo.cls_8 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_9 / member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_8 ne 0 && vo.cls_8 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_8 / member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_8 / member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_8 / member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_7}<br /><br />${vo.cls_7}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_7 eq 0 && vo.cls_7 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_7 / member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_7 ne 0 && vo.cls_7 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_7 / member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_7 / member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_7 / member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_6}<br /><br />${vo.cls_6}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_6 eq 0 && vo.cls_6 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_6 / member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_6 ne 0 && vo.cls_6 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_6 / member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_6 / member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_6 / member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_5}<br /><br />${vo.cls_5}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_5 eq 0 && vo.cls_5 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_6 / member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_5 ne 0 && vo.cls_5 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_5 / member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_5 / member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_5 / member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_4}<br /><br />${vo.cls_4}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_4 eq 0 && vo.cls_4 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_4 / member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_4 ne 0 && vo.cls_4 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_4 / member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_4 / member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_4 / member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_3}<br /><br />${vo.cls_3}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_3 eq 0 && vo.cls_3 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_3 / member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_3 ne 0 && vo.cls_3 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_3 / member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_3 / member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_3 / member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_2}<br /><br />${vo.cls_2}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_2 eq 0 && vo.cls_2 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_2 / member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_2 ne 0 && vo.cls_2 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_2 / member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_2 / member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_2 / member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_1}<br /><br />${vo.cls_1}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_1 eq 0 && vo.cls_1 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_1 / member_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_1 ne 0 && vo.cls_1 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_1 / member_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_1 / member_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_1 / member_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>                    
                </tr>                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="3">물보험 소계 (${sumMember_cnt})</td>
                <td>수임<br /><br />종결</td>
                <td>${sumReg_sum}<br /><br />${sumCls_sum}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_sum eq 0 && sumCls_sum ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_sum / sumMember_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_sum ne 0 && sumCls_sum eq 0}">
                    			<fmt:formatNumber value="${sumReg_sum / sumMember_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_sum / sumMember_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_sum / sumMember_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td> 
                <td>${sumReg_12}<br /><br />${sumCls_12}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_12 eq 0 && sumCls_12 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_12 / sumMember_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_12 ne 0 && sumCls_12 eq 0}">
                    			<fmt:formatNumber value="${sumReg_12 / sumMember_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_12 / sumMember_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_12 / sumMember_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg_11}<br /><br />${sumCls_11}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_11 eq 0 && sumCls_11 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_11 / sumMember_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_11 ne 0 && sumCls_11 eq 0}">
                    			<fmt:formatNumber value="${sumReg_11 / sumMember_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_11 / sumMember_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_11 / sumMember_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg_10}<br /><br />${sumCls_10}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_10 eq 0 && sumCls_10 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_10 / sumMember_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_10 ne 0 && sumCls_10 eq 0}">
                    			<fmt:formatNumber value="${sumReg_10 / sumMember_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_10 / sumMember_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_10 / sumMember_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg_9}<br /><br />${sumCls_9}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_9 eq 0 && sumCls_9 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_9 / sumMember_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_9 ne 0 && sumCls_9 eq 0}">
                    			<fmt:formatNumber value="${sumReg_9 / sumMember_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_9 / sumMember_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_9 / sumMember_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg_8}<br /><br />${sumCls_8}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_8 eq 0 && sumCls_8 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_8 / sumMember_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_8 ne 0 && sumCls_8 eq 0}">
                    			<fmt:formatNumber value="${sumReg_8 / sumMember_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_8 / sumMember_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_8 / sumMember_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg_7}<br /><br />${sumCls_7}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_7 eq 0 && sumCls_7 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_7 / sumMember_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_7 ne 0 && sumCls_7 eq 0}">
                    			<fmt:formatNumber value="${sumReg_7 / sumMember_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_7 / sumMember_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_7 / sumMember_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg_6}<br /><br />${sumCls_6}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_6 eq 0 && sumCls_6 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_6 / sumMember_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_6 ne 0 && sumCls_6 eq 0}">
                    			<fmt:formatNumber value="${sumReg_6 / sumMember_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_6 / sumMember_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_6 / sumMember_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg_5}<br /><br />${sumCls_5}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_5 eq 0 && sumCls_5 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_5 / sumMember_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_5 ne 0 && sumCls_5 eq 0}">
                    			<fmt:formatNumber value="${sumReg_5 / sumMember_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_5 / sumMember_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_5 / sumMember_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg_4}<br /><br />${sumCls_4}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_4 eq 0 && sumCls_4 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_4 / sumMember_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_4 ne 0 && sumCls_4 eq 0}">
                    			<fmt:formatNumber value="${sumReg_4 / sumMember_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_4 / sumMember_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_4 / sumMember_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg_3}<br /><br />${sumCls_3}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_3 eq 0 && sumCls_3 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_3 / sumMember_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_3 ne 0 && sumCls_3 eq 0}">
                    			<fmt:formatNumber value="${sumReg_3 / sumMember_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_3 / sumMember_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_3 / sumMember_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg_2}<br /><br />${sumCls_2}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_2 eq 0 && sumCls_2 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_2 / sumMember_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_2 ne 0 && sumCls_2 eq 0}">
                    			<fmt:formatNumber value="${sumReg_2 / sumMember_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_2 / sumMember_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_2 / sumMember_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg_1}<br /><br />${sumCls_1}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg_1 eq 0 && sumCls_1 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls_1 / sumMember_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg_1 ne 0 && sumCls_1 eq 0}">
                    			<fmt:formatNumber value="${sumReg_1 / sumMember_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg_1 / sumMember_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls_1 / sumMember_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>               
            </tr>
            
            <c:forEach var="vo" items="${getMisRegTm4}" varStatus="status">
            	<c:set var="sumReg4_12" value="${sumReg4_12 + vo.reg_12}" />
                <c:set var="sumReg4_11" value="${sumReg4_11 + vo.reg_11}" />
                <c:set var="sumReg4_10" value="${sumReg4_10 + vo.reg_10}" />
                <c:set var="sumReg4_9" value="${sumReg4_9 + vo.reg_9}" />
                <c:set var="sumReg4_8" value="${sumReg4_8 + vo.reg_8}" />
                <c:set var="sumReg4_7" value="${sumReg4_7 + vo.reg_7}" />
                <c:set var="sumReg4_6" value="${sumReg4_6 + vo.reg_6}" />
                <c:set var="sumReg4_5" value="${sumReg4_5 + vo.reg_5}" />
                <c:set var="sumReg4_4" value="${sumReg4_4 + vo.reg_4}" />
                <c:set var="sumReg4_3" value="${sumReg4_3 + vo.reg_3}" />
                <c:set var="sumReg4_2" value="${sumReg4_2 + vo.reg_2}" />
                <c:set var="sumReg4_1" value="${sumReg4_1 + vo.reg_1}" />
                <c:set var="sumReg4_sum" value="${sumReg4_sum + vo.reg_12+vo.reg_11+vo.reg_10+vo.reg_9+vo.reg_8+vo.reg_7+vo.reg_6+vo.reg_5+vo.reg_4+vo.reg_3+vo.reg_2+vo.reg_1}" />
                <c:set var="sumReg4_ex" value="${vo.reg_12+vo.reg_11+vo.reg_10+vo.reg_9+vo.reg_8+vo.reg_7+vo.reg_6+vo.reg_5+vo.reg_4+vo.reg_3+vo.reg_2+vo.reg_1}" />
                <c:set var="sumCls4_12" value="${sumCls4_12 + vo.cls_12}" />
                <c:set var="sumCls4_11" value="${sumCls4_11 + vo.cls_11}" />
                <c:set var="sumCls4_10" value="${sumCls4_10 + vo.cls_10}" />
                <c:set var="sumCls4_9" value="${sumCls4_9 + vo.cls_9}" />
                <c:set var="sumCls4_8" value="${sumCls4_8 + vo.cls_8}" />
                <c:set var="sumCls4_7" value="${sumCls4_7 + vo.cls_7}" />
                <c:set var="sumCls4_6" value="${sumCls4_6 + vo.cls_6}" />
                <c:set var="sumCls4_5" value="${sumCls4_5 + vo.cls_5}" />
                <c:set var="sumCls4_4" value="${sumCls4_4 + vo.cls_4}" />
                <c:set var="sumCls4_3" value="${sumCls4_3 + vo.cls_3}" />
                <c:set var="sumCls4_2" value="${sumCls4_2 + vo.cls_2}" />
                <c:set var="sumCls4_1" value="${sumCls4_1 + vo.cls_1}" />
                <c:set var="sumCls4_sum" value="${sumCls4_sum + vo.cls_12+vo.cls_11+vo.cls_10+vo.cls_9+vo.cls_8+vo.cls_7+vo.cls_6+vo.cls_5+vo.cls_4+vo.cls_3+vo.cls_2+vo.cls_1}" />
                <c:set var="sumCls4_ex" value="${vo.cls_12+vo.cls_11+vo.cls_10+vo.cls_9+vo.cls_8+vo.cls_7+vo.cls_6+vo.cls_5+vo.cls_4+vo.cls_3+vo.cls_2+vo.cls_1}" />
                <c:set var="member4_cnt" value="${vo.member_cnt}" />
                <c:set var="sumMember4_cnt" value="${sumMember4_cnt + member4_cnt}" />
                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${getMisRegTm4.size() + 1}">인보험</td>
                    </c:if>
                    <td>${vo.team_name} (${member4_cnt})</td>
                    <td><a href="javascript:goMisRegTmMbr('${vo.team_id}','${vo.team_name}','${vo.team_type}');">개인별</a></td>
                    <td><a href="javascript:goMisRegTmPtnr('${vo.team_id}','${vo.team_name}','${vo.team_type}');">보험사별</a></td>
                    <td>수임<br /><br />종결</td>
                    <td bgcolor="#faebd7">
                    	${sumReg4_ex}
                        <br /><br />
                        ${sumCls4_ex}
                    </td>
                    <td bgcolor="#faebd7">
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_ex eq 0 && sumCls4_ex ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_ex / member4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_ex ne 0 && sumCls4_ex eq 0}">
                    			<fmt:formatNumber value="${sumReg4_ex / member4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_ex / member4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_ex / member4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_12}<br /><br />${vo.cls_12}</td>                    
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_12 eq 0 && vo.cls_12 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_12 / member4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_12 ne 0 && vo.cls_12 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_12 / member4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_12 / member4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_12 / member4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_11}<br /><br />${vo.cls_11}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_11 eq 0 && vo.cls_11 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_11 / member4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_11 ne 0 && vo.cls_11 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_11 / member4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_11 / member4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_11 / member4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_10}<br /><br />${vo.cls_10}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_10 eq 0 && vo.cls_10 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_10 / member4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_10 ne 0 && vo.cls_10 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_10 / member4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_10 / member4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_10 / member4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_9}<br /><br />${vo.cls_9}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_9 eq 0 && vo.cls_9 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_9 / member4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_9 ne 0 && vo.cls_9 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_9 / member4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_9 / member4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_9 / member4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_8}<br /><br />${vo.cls_8}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_8 eq 0 && vo.cls_8 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_9 / member4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_8 ne 0 && vo.cls_8 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_8 / member4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_8 / member4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_8 / member4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_7}<br /><br />${vo.cls_7}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_7 eq 0 && vo.cls_7 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_7 / member4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_7 ne 0 && vo.cls_7 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_7 / member4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_7 / member4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_7 / member4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_6}<br /><br />${vo.cls_6}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_6 eq 0 && vo.cls_6 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_6 / member4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_6 ne 0 && vo.cls_6 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_6 / member4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_6 / member4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_6 / member4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_5}<br /><br />${vo.cls_5}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_5 eq 0 && vo.cls_5 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_6 / member4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_5 ne 0 && vo.cls_5 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_5 / member4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_5 / member4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_5 / member4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_4}<br /><br />${vo.cls_4}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_4 eq 0 && vo.cls_4 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_4 / member4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_4 ne 0 && vo.cls_4 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_4 / member4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_4 / member4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_4 / member4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_3}<br /><br />${vo.cls_3}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_3 eq 0 && vo.cls_3 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_3 / member4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_3 ne 0 && vo.cls_3 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_3 / member4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_3 / member4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_3 / member4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_2}<br /><br />${vo.cls_2}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_2 eq 0 && vo.cls_2 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_2 / member4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_2 ne 0 && vo.cls_2 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_2 / member4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_2 / member4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_2 / member4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                    <td>${vo.reg_1}<br /><br />${vo.cls_1}</td>
                    <td>
                    	<font color="blue">
                    	<c:choose>
                    		<c:when test="${ member4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ vo.reg_1 eq 0 && vo.cls_1 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${vo.cls_1 / member4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ vo.reg_1 ne 0 && vo.cls_1 eq 0}">
                    			<fmt:formatNumber value="${vo.reg_1 / member4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${vo.reg_1 / member4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${vo.cls_1 / member4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>                    
                </tr>                
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="3">인보험 소계 (${sumMember4_cnt})</td>
                <td>수임<br /><br />종결</td>
                <td>${sumReg4_sum}<br /><br />${sumCls4_sum}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_sum eq 0 && sumCls4_sum ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_sum / sumMember4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_sum ne 0 && sumCls4_sum eq 0}">
                    			<fmt:formatNumber value="${sumReg4_sum / sumMember4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_sum / sumMember4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_sum / sumMember4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td> 
                <td>${sumReg4_12}<br /><br />${sumCls4_12}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_12 eq 0 && sumCls4_12 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_12 / sumMember4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_12 ne 0 && sumCls4_12 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_12 / sumMember4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_12 / sumMember4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_12 / sumMember4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg4_11}<br /><br />${sumCls4_11}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_11 eq 0 && sumCls4_11 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_11 / sumMember4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_11 ne 0 && sumCls4_11 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_11 / sumMember4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_11 / sumMember4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_11 / sumMember4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg4_10}<br /><br />${sumCls4_10}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_10 eq 0 && sumCls4_10 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_10 / sumMember4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_10 ne 0 && sumCls4_10 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_10 / sumMember4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_10 / sumMember4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_10 / sumMember4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg4_9}<br /><br />${sumCls4_9}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_9 eq 0 && sumCls4_9 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_9 / sumMember4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_9 ne 0 && sumCls4_9 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_9 / sumMember4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_9 / sumMember4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_9 / sumMember4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg4_8}<br /><br />${sumCls4_8}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_8 eq 0 && sumCls4_8 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_8 / sumMember4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_8 ne 0 && sumCls4_8 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_8 / sumMember4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_8 / sumMember4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_8 / sumMember4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg4_7}<br /><br />${sumCls4_7}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_7 eq 0 && sumCls4_7 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_7 / sumMember4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_7 ne 0 && sumCls4_7 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_7 / sumMember4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_7 / sumMember4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_7 / sumMember4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg4_6}<br /><br />${sumCls4_6}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_6 eq 0 && sumCls4_6 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_6 / sumMember4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_6 ne 0 && sumCls4_6 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_6 / sumMember4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_6 / sumMember4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_6 / sumMember4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg4_5}<br /><br />${sumCls4_5}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_5 eq 0 && sumCls4_5 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_5 / sumMember4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_5 ne 0 && sumCls4_5 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_5 / sumMember4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_5 / sumMember4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_5 / sumMember4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg4_4}<br /><br />${sumCls4_4}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_4 eq 0 && sumCls4_4 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_4 / sumMember4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_4 ne 0 && sumCls4_4 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_4 / sumMember4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_4 / sumMember4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_4 / sumMember4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg4_3}<br /><br />${sumCls4_3}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_3 eq 0 && sumCls4_3 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_3 / sumMember4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_3 ne 0 && sumCls4_3 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_3 / sumMember4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_3 / sumMember4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_3 / sumMember4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg4_2}<br /><br />${sumCls4_2}</td>
                <td>
                    <font color="blue">
                    	<c:choose>
                    		<c:when test="${ sumMember4_cnt eq 0}">
                    			0<br /><br />0			
                    		</c:when>
                    		<c:when test="${ sumReg4_2 eq 0 && sumCls4_2 ne 0}">
                    			0<br /><br /><fmt:formatNumber value="${sumCls4_2 / sumMember4_cnt}" pattern="#.#"/>			
                    		</c:when>
                    		<c:when test="${ sumReg4_2 ne 0 && sumCls4_2 eq 0}">
                    			<fmt:formatNumber value="${sumReg4_2 / sumMember4_cnt}" pattern="#.#"/><br /><br />0			
                    		</c:when>
                    		<c:otherwise>
                    			<fmt:formatNumber value="${sumReg4_2 / sumMember4_cnt}" pattern="#.#"/>
                    			<br/><br/>
                    			<fmt:formatNumber value="${sumCls4_2 / sumMember4_cnt}" pattern="#.#"/>
                    		</c:otherwise>
                    	</c:choose>
                    	</font>
                    </td>
                <td>${sumReg4_1}<br /><br />${sumCls4_1}</td>
                <td>
					<font color="blue">
						<c:choose>
							<c:when test="${ sumMember4_cnt eq 0}">
								0<br /><br />0			
							</c:when>
							<c:when test="${ sumReg4_1 eq 0 && sumCls4_1 ne 0}">
								0<br /><br /><fmt:formatNumber value="${sumCls4_1 / sumMember4_cnt}" pattern="#.#"/>			
							</c:when>
							<c:when test="${ sumReg4_1 ne 0 && sumCls4_1 eq 0}">
								<fmt:formatNumber value="${sumReg4_1 / sumMember4_cnt}" pattern="#.#"/><br /><br />0			
							</c:when>
							<c:otherwise>
								<fmt:formatNumber value="${sumReg4_1 / sumMember4_cnt}" pattern="#.#"/>
								<br/><br/>
								<fmt:formatNumber value="${sumCls4_1 / sumMember4_cnt}" pattern="#.#"/>
							</c:otherwise>
						</c:choose>
					</font>
				</td>               
            </tr>
            <tr bgcolor="#E7ECF1">
            	<c:set var="allMember_cnt" value="${sumMember_cnt+sumMember4_cnt}" />
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
            	
                <th colspan="4">전체합계 (${allMember_cnt})</th>
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
            <%-- <c:forEach var="vo" items="${getMisRegTm4}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${getMisRegTm4.size() + 1}">인보험</td>
                    </c:if>
                    <td>${vo.team_name}</td>
                    <td><a href="javascript:goMisRegTmMbr('${vo.team_id}','${vo.team_name}','${vo.team_type}');">개인별</a></td>
                    <td><a href="javascript:goMisRegTmPtnr('${vo.team_id}','${vo.team_name}','${vo.team_type}');">보험사별</a></td>
                    <td>수임<br /><br />종결</td>
                    <td>${vo.reg_12}<br /><br />${vo.cls_12}</td>
                    <td>${vo.reg_11}<br /><br />${vo.cls_11}</td>
                    <td>${vo.reg_10}<br /><br />${vo.cls_10}</td>
                    <td>${vo.reg_9}<br /><br />${vo.cls_9}</td>
                    <td>${vo.reg_8}<br /><br />${vo.cls_8}</td>
                    <td>${vo.reg_7}<br /><br />${vo.cls_7}</td>
                    <td>${vo.reg_6}<br /><br />${vo.cls_6}</td>
                    <td>${vo.reg_5}<br /><br />${vo.cls_5}</td>
                    <td>${vo.reg_4}<br /><br />${vo.cls_4}</td>
                    <td>${vo.reg_3}<br /><br />${vo.cls_3}</td>
                    <td>${vo.reg_2}<br /><br />${vo.cls_2}</td>
                    <td>${vo.reg_1}<br /><br />${vo.cls_1}</td>
                    <td>${vo.reg_12+vo.reg_11+vo.reg_10+vo.reg_9+vo.reg_8+vo.reg_7+vo.reg_6+vo.reg_5+vo.reg_4+vo.reg_3+vo.reg_2+vo.reg_1}
                        <br /><br />
                            ${vo.cls_12+vo.cls_11+vo.cls_10+vo.cls_9+vo.cls_8+vo.cls_7+vo.cls_6+vo.cls_5+vo.cls_4+vo.cls_3+vo.cls_2+vo.cls_1}
                    </td>
                </tr>
                <c:set var="sumReg4_12" value="${sumReg4_12 + vo.reg_12}" />
                <c:set var="sumReg4_11" value="${sumReg4_11 + vo.reg_11}" />
                <c:set var="sumReg4_10" value="${sumReg4_10 + vo.reg_10}" />
                <c:set var="sumReg4_9" value="${sumReg4_9 + vo.reg_9}" />
                <c:set var="sumReg4_8" value="${sumReg4_8 + vo.reg_8}" />
                <c:set var="sumReg4_7" value="${sumReg4_7 + vo.reg_7}" />
                <c:set var="sumReg4_6" value="${sumReg4_6 + vo.reg_6}" />
                <c:set var="sumReg4_5" value="${sumReg4_5 + vo.reg_5}" />
                <c:set var="sumReg4_4" value="${sumReg4_4 + vo.reg_4}" />
                <c:set var="sumReg4_3" value="${sumReg4_3 + vo.reg_3}" />
                <c:set var="sumReg4_2" value="${sumReg4_2 + vo.reg_2}" />
                <c:set var="sumReg4_1" value="${sumReg4_1 + vo.reg_1}" />
                <c:set var="sumReg4_sum" value="${sumReg4_sum + vo.reg_12+vo.reg_11+vo.reg_10+vo.reg_9+vo.reg_8+vo.reg_7+vo.reg_6+vo.reg_5+vo.reg_4+vo.reg_3+vo.reg_2+vo.reg_1}" />
                <c:set var="sumCls4_12" value="${sumCls4_12 + vo.cls_12}" />
                <c:set var="sumCls4_11" value="${sumCls4_11 + vo.cls_11}" />
                <c:set var="sumCls4_10" value="${sumCls4_10 + vo.cls_10}" />
                <c:set var="sumCls4_9" value="${sumCls4_9 + vo.cls_9}" />
                <c:set var="sumCls4_8" value="${sumCls4_8 + vo.cls_8}" />
                <c:set var="sumCls4_7" value="${sumCls4_7 + vo.cls_7}" />
                <c:set var="sumCls4_6" value="${sumCls4_6 + vo.cls_6}" />
                <c:set var="sumCls4_5" value="${sumCls4_5 + vo.cls_5}" />
                <c:set var="sumCls4_4" value="${sumCls4_4 + vo.cls_4}" />
                <c:set var="sumCls4_3" value="${sumCls4_3 + vo.cls_3}" />
                <c:set var="sumCls4_2" value="${sumCls4_2 + vo.cls_2}" />
                <c:set var="sumCls4_1" value="${sumCls4_1 + vo.cls_1}" />
                <c:set var="sumCls4_sum" value="${sumCls4_sum + vo.cls_12+vo.cls_11+vo.cls_10+vo.cls_9+vo.cls_8+vo.cls_7+vo.cls_6+vo.cls_5+vo.cls_4+vo.cls_3+vo.cls_2+vo.cls_1}" />
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="3">인보험 소계</td>
                <td>수임<br /><br />종결</td>
                <td>${sumReg4_12}<br /><br />${sumCls4_12}</td>
                <td>${sumReg4_11}<br /><br />${sumCls4_11}</td>
                <td>${sumReg4_10}<br /><br />${sumCls4_10}</td>
                <td>${sumReg4_9}<br /><br />${sumCls4_9}</td>
                <td>${sumReg4_8}<br /><br />${sumCls4_8}</td>
                <td>${sumReg4_7}<br /><br />${sumCls4_7}</td>
                <td>${sumReg4_6}<br /><br />${sumCls4_6}</td>
                <td>${sumReg4_5}<br /><br />${sumCls4_5}</td>
                <td>${sumReg4_4}<br /><br />${sumCls4_4}</td>
                <td>${sumReg4_3}<br /><br />${sumCls4_3}</td>
                <td>${sumReg4_2}<br /><br />${sumCls4_2}</td>
                <td>${sumReg4_1}<br /><br />${sumCls4_1}</td>
                <td>${sumReg4_sum}<br /><br />${sumCls4_sum}</td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="4">합계</td>
                <td>수임<br /><br />종결</td>
                <td>${sumReg_12+sumReg4_12}<br /><br />${sumCls_12+sumCls4_12}</td>
                <td>${sumReg_11+sumReg4_11}<br /><br />${sumCls_11+sumCls4_11}</td>
                <td>${sumReg_10+sumReg4_10}<br /><br />${sumCls_10+sumCls4_10}</td>
                <td>${sumReg_9+sumReg4_9}<br /><br />${sumCls_9+sumCls4_9}</td>
                <td>${sumReg_8+sumReg4_8}<br /><br />${sumCls_8+sumCls4_8}</td>
                <td>${sumReg_7+sumReg4_7}<br /><br />${sumCls_7+sumCls4_7}</td>
                <td>${sumReg_6+sumReg4_6}<br /><br />${sumCls_6+sumCls4_6}</td>
                <td>${sumReg_5+sumReg4_5}<br /><br />${sumCls_5+sumCls4_5}</td>
                <td>${sumReg_4+sumReg4_4}<br /><br />${sumCls_4+sumCls4_4}</td>
                <td>${sumReg_3+sumReg4_3}<br /><br />${sumCls_3+sumCls4_3}</td>
                <td>${sumReg_2+sumReg4_2}<br /><br />${sumCls_2+sumCls4_2}</td>
                <td>${sumReg_1+sumReg4_1}<br /><br />${sumCls_1+sumCls4_1}</td>
                <td>${sumReg_sum+sumReg4_sum}<br /><br />${sumCls_sum+sumCls4_sum}</td>
            </tr> --%>
            </tbody>
        </table>
    </div>
</div>
