<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2">
    <div style="padding-right: 17px; background: #e7ecf1;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
            <thead>
            <tr>
                <th>Type</th>
                <th style="width: 150px;">보험사</th>
                <th>${nowVO.monBefore11.substring(0,7)}</th>
                <th>${nowVO.monBefore10.substring(0,7)}</th>
                <th>${nowVO.monBefore9.substring(0,7)}</th>
                <th>${nowVO.monBefore8.substring(0,7)}</th>
                <th>${nowVO.monBefore7.substring(0,7)}</th>
                <th>${nowVO.monBefore6.substring(0,7)}</th>
                <th>${nowVO.monBefore5.substring(0,7)}</th>
                <th>${nowVO.monBefore4.substring(0,7)}</th>
                <th>${nowVO.monBefore3.substring(0,7)}</th>
                <th>${nowVO.monBefore2.substring(0,7)}</th>
                <th>${nowVO.monBefore1.substring(0,7)}</th>
                <th>${nowVO.monBefore0.substring(0,7)}</th>
                <th>합계</th>
            </tr>
            </thead>
        </table>
    </div>
    <div style="height:634px; overflow-x: hidden; overflow-y: auto;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
            <tbody>
            <!-- 1종 조사 시작 -->
            <c:forEach var="vo" items="${MisEndPtnr1Main}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center; cursor: pointer;" 
                	onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
                	onclick="goMisEndPtnrTm('${vo.ptnr_id}','MisEndPtnrTm');">
                	
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisEndPtnr1Main.size()}">1종 조사</td>
                    </c:if>
                    <td style="width: 150px;">
                    	${vo.ptnr_nick}
                   	</td>
                    <td>
                        <c:out value="${vo.getEnd_rid12()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid11()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid10()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid9()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid8()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid7()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid6()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid5()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid4()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid3()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid2()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.end_rid12+vo.end_rid11+vo.end_rid10+vo.end_rid9+vo.end_rid8+vo.end_rid7+vo.end_rid6+vo.end_rid5+vo.end_rid4+vo.end_rid3+vo.end_rid2+vo.end_rid}"	/>
                    </td>
                </tr>
                <c:set var="sumEnd_12" value="${sumEnd_12 + vo.end_rid12}" />
                <c:set var="sumEnd_11" value="${sumEnd_11 + vo.end_rid11}" />
                <c:set var="sumEnd_10" value="${sumEnd_10 + vo.end_rid10}" />
                <c:set var="sumEnd_9" value="${sumEnd_9 + vo.end_rid9}" />
                <c:set var="sumEnd_8" value="${sumEnd_8 + vo.end_rid8}" />
                <c:set var="sumEnd_7" value="${sumEnd_7 + vo.end_rid7}" />
                <c:set var="sumEnd_6" value="${sumEnd_6 + vo.end_rid6}" />
                <c:set var="sumEnd_5" value="${sumEnd_5 + vo.end_rid5}" />
                <c:set var="sumEnd_4" value="${sumEnd_4 + vo.end_rid4}" />
                <c:set var="sumEnd_3" value="${sumEnd_3 + vo.end_rid3}" />
                <c:set var="sumEnd_2" value="${sumEnd_2 + vo.end_rid2}" />
                <c:set var="sumEnd" value="${sumEnd + vo.end_rid}" />
                <c:set var="sumEnd_sum" value="${sumEnd_sum + vo.end_rid12+vo.end_rid11+vo.end_rid10+vo.end_rid9+vo.end_rid8+vo.end_rid7+vo.end_rid6+vo.end_rid5+vo.end_rid4+vo.end_rid3+vo.end_rid2+vo.end_rid}" />
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">1종 조사 소계</td>
                <td>${sumEnd_12}</td>
                <td>${sumEnd_11}</td>
                <td>${sumEnd_10}</td>
                <td>${sumEnd_9}</td>
                <td>${sumEnd_8}</td>
                <td>${sumEnd_7}</td>
                <td>${sumEnd_6}</td>
                <td>${sumEnd_5}</td>
                <td>${sumEnd_4}</td>
                <td>${sumEnd_3}</td>
                <td>${sumEnd_2}</td>
                <td>${sumEnd}</td>
                <td>${sumEnd_sum}</td>
            </tr>
			<!-- 1종 조사 끝 -->
			
			<!-- 1종 심사 시작 -->
            <c:forEach var="vo" items="${MisEndPtnr1Written}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center; cursor: pointer;" 
                	onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
                	onclick="goMisEndPtnrTm('${vo.ptnr_id}','MisEndPtnrTm');">
                	
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisEndPtnr1Written.size()}">1종 심사</td>
                    </c:if>
                    <td style="width: 150px;">
                    	${vo.ptnr_nick}
                   	</td>
                    <td>
                        <c:out value="${vo.getEnd_rid12()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid11()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid10()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid9()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid8()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid7()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid6()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid5()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid4()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid3()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid2()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.end_rid12+vo.end_rid11+vo.end_rid10+vo.end_rid9+vo.end_rid8+vo.end_rid7+vo.end_rid6+vo.end_rid5+vo.end_rid4+vo.end_rid3+vo.end_rid2+vo.end_rid}"	/>
                    </td>
                </tr>
                <c:set var="sumEndWritten_12" value="${sumEndWritten_12 + vo.end_rid12}" />
                <c:set var="sumEndWritten_11" value="${sumEndWritten_11 + vo.end_rid11}" />
                <c:set var="sumEndWritten_10" value="${sumEndWritten_10 + vo.end_rid10}" />
                <c:set var="sumEndWritten_9" value="${sumEndWritten_9 + vo.end_rid9}" />
                <c:set var="sumEndWritten_8" value="${sumEndWritten_8 + vo.end_rid8}" />
                <c:set var="sumEndWritten_7" value="${sumEndWritten_7 + vo.end_rid7}" />
                <c:set var="sumEndWritten_6" value="${sumEndWritten_6 + vo.end_rid6}" />
                <c:set var="sumEndWritten_5" value="${sumEndWritten_5 + vo.end_rid5}" />
                <c:set var="sumEndWritten_4" value="${sumEndWritten_4 + vo.end_rid4}" />
                <c:set var="sumEndWritten_3" value="${sumEndWritten_3 + vo.end_rid3}" />
                <c:set var="sumEndWritten_2" value="${sumEndWritten_2 + vo.end_rid2}" />
                <c:set var="sumEndWritten" value="${sumEndWritten + vo.end_rid}" />
                <c:set var="sumEndWritten_sum" value="${sumEndWritten_sum + vo.end_rid12+vo.end_rid11+vo.end_rid10+vo.end_rid9+vo.end_rid8+vo.end_rid7+vo.end_rid6+vo.end_rid5+vo.end_rid4+vo.end_rid3+vo.end_rid2+vo.end_rid}" />
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">1종 심사 소계</td>
                <td>${sumEndWritten_12}</td>
                <td>${sumEndWritten_11}</td>
                <td>${sumEndWritten_10}</td>
                <td>${sumEndWritten_9}</td>
                <td>${sumEndWritten_8}</td>
                <td>${sumEndWritten_7}</td>
                <td>${sumEndWritten_6}</td>
                <td>${sumEndWritten_5}</td>
                <td>${sumEndWritten_4}</td>
                <td>${sumEndWritten_3}</td>
                <td>${sumEndWritten_2}</td>
                <td>${sumEndWritten}</td>
                <td>${sumEndWritten_sum}</td>
            </tr>            
			<!-- 1종 심사 끝 -->
			
			<!-- 1종 소계 시작-->
			<tr bgcolor="#E7ECF1">
                <th colspan="2">1종 소계</th>
                <th>${sumEnd_12 + sumEndWritten_12}</th>
                <th>${sumEnd_11 + sumEndWritten_11}</th>
                <th>${sumEnd_10 + sumEndWritten_10}</th>
                <th>${sumEnd_9 + sumEndWritten_9}</th>
                <th>${sumEnd_8 + sumEndWritten_8}</th>
                <th>${sumEnd_7 + sumEndWritten_7}</th>
                <th>${sumEnd_6 + sumEndWritten_6}</th>
                <th>${sumEnd_5 + sumEndWritten_5}</th>
                <th>${sumEnd_4 + sumEndWritten_4}</th>
                <th>${sumEnd_3 + sumEndWritten_3}</th>
                <th>${sumEnd_2 + sumEndWritten_2}</th>
                <th>${sumEnd + sumEndWritten}</th>
                <th>${sumEnd_sum + sumEndWritten_sum}</th>
            </tr>
			
			<!-- 1종 소계 끝 -->
			
            <c:forEach var="vo4" items="${MisEndPtnr4}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center; cursor: pointer;" 
                	onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
                   	onclick="goMisEndPtnrTm('${vo.ptnr_id}','MisEndPtnrTm');">
                   	
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisEndPtnr4.size()}">4종</td>
                    </c:if>
                    <td><a href="javascript:goMisEndPtnrTm('${vo4.ptnr_id}','${vo4.ptnr_nick}','${inVO.viewFromDate}','${inVO.viewToDate}');">${vo4.ptnr_nick}</a></td>
                    <td>
                        <c:out value="${vo4.getEnd_rid12()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid11()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid10()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid9()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid8()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid7()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid6()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid5()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid4()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid3()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid2()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.end_rid12+vo4.end_rid11+vo4.end_rid10+vo4.end_rid9+vo4.end_rid8+vo4.end_rid7+vo4.end_rid6+vo4.end_rid5+vo4.end_rid4+vo4.end_rid3+vo4.end_rid2+vo4.end_rid}"	/>
                    </td>
                </tr>

                <c:set var="sumEnd4_12" value="${sumEnd4_12 + vo4.end_rid12}" />
                <c:set var="sumEnd4_11" value="${sumEnd4_11 + vo4.end_rid11}" />
                <c:set var="sumEnd4_10" value="${sumEnd4_10 + vo4.end_rid10}" />
                <c:set var="sumEnd4_9" value="${sumEnd4_9 + vo4.end_rid9}" />
                <c:set var="sumEnd4_8" value="${sumEnd4_8 + vo4.end_rid8}" />
                <c:set var="sumEnd4_7" value="${sumEnd4_7 + vo4.end_rid7}" />
                <c:set var="sumEnd4_6" value="${sumEnd4_6 + vo4.end_rid6}" />
                <c:set var="sumEnd4_5" value="${sumEnd4_5 + vo4.end_rid5}" />
                <c:set var="sumEnd4_4" value="${sumEnd4_4 + vo4.end_rid4}" />
                <c:set var="sumEnd4_3" value="${sumEnd4_3 + vo4.end_rid3}" />
                <c:set var="sumEnd4_2" value="${sumEnd4_2 + vo4.end_rid2}" />
                <c:set var="sumEnd4" value="${sumEnd4 + vo4.end_rid}" />
                <c:set var="sumEnd4_sum" value="${sumEnd4_sum + vo4.end_rid12+vo4.end_rid11+vo4.end_rid10+vo4.end_rid9+vo4.end_rid8+vo4.end_rid7+vo4.end_rid6+vo4.end_rid5+vo4.end_rid4+vo4.end_rid3+vo4.end_rid2+vo4.end_rid}" />
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <th colspan="2">4종 소계</th>
                <th>${sumEnd4_12}</th>
                <th>${sumEnd4_11}</th>
                <th>${sumEnd4_10}</th>
                <th>${sumEnd4_9}</th>
                <th>${sumEnd4_8}</th>
                <th>${sumEnd4_7}</th>
                <th>${sumEnd4_6}</th>
                <th>${sumEnd4_5}</th>
                <th>${sumEnd4_4}</th>
                <th>${sumEnd4_3}</th>
                <th>${sumEnd4_2}</th>
                <th>${sumEnd4}</th>
                <th>${sumEnd4_sum}</th>
            </tr>
            <tr bgcolor="#E7ECF1">
                <th style="color:blue;" colspan="2">합 계</th>
                <th style="color:blue;">${sumEnd_12 + sumEndWritten_12 + sumEnd4_12}</th>
                <th style="color:blue;">${sumEnd_11 + sumEndWritten_11 + sumEnd4_11}</th>
                <th style="color:blue;">${sumEnd_10 + sumEndWritten_10 + sumEnd4_10}</th>
                <th style="color:blue;">${sumEnd_9 + sumEndWritten_9 + sumEnd4_9}</th>
                <th style="color:blue;">${sumEnd_8 + sumEndWritten_8 + sumEnd4_8}</th>
                <th style="color:blue;">${sumEnd_7 + sumEndWritten_7 + sumEnd4_7}</th>
                <th style="color:blue;">${sumEnd_6 + sumEndWritten_6 + sumEnd4_6}</th>
                <th style="color:blue;">${sumEnd_5 + sumEndWritten_5 + sumEnd4_5}</th>
                <th style="color:blue;">${sumEnd_4 + sumEndWritten_4 + sumEnd4_4}</th>
                <th style="color:blue;">${sumEnd_3 + sumEndWritten_3 + sumEnd4_3}</th>
                <th style="color:blue;">${sumEnd_2 + sumEndWritten_2 + sumEnd4_2}</th>
                <th style="color:blue;">${sumEnd + sumEndWritten + sumEnd4}</th>
                <th style="color:blue;">${sumEnd_sum + sumEndWritten_sum + sumEnd4_sum}</th>
            </tr>
            </tbody>
        </table>
    </div>
</div>
