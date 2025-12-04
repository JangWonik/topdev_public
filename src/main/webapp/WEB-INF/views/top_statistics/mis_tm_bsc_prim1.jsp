<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2" id="dataTable">
	<div style="padding-right: 20px; background: #e7ecf1;">
		<table cellpadding="0" cellspacing="0" width="1060" summary="팀 기본통계 1종">
			<caption>팀 기본통계</caption>
			<colgroup>
				<col width="65">
				<col width="130">
				<col width="65">
				<col width="65">
				<col width="65">
				<col width="65">
				<col width="65">
				<col width="65">
				<col width="65">
				<col width="65">
				<col width="80">
				<col width="65">
				<col width="65">
				<col width="65">
				<col width="65">
				<col width="65">
				<col width="65">
				<col width="65">
				<col width="80">
			</colgroup>
			<thead>
			<tr align="center" bgcolor="#EFEFEF">
				<td class="td" nowrap rowspan="3"><B>Type</B></td>
				<td class="td" nowrap rowspan="3"><B>팀</B></td>
				<td class="td" nowrap rowspan="3"><B>조사자</B></td>
				<td class="td" nowrap colspan="7">공동수행자의 비율 및 금액을 반영한 결과<B><font color="red">(반영안함!)</font></b></td>
				<td class="td" nowrap rowspan="3">미수금</td>
				<td class="td" nowrap colspan="7">공동수행자의 비율 및 금액을 반영한 결과<B><font color="red">(반영안함!)</font></b></td>
				<td class="td" nowrap rowspan="3">미수금 총합계</td>
			</tr>
			<tr align="center" bgcolor="#EFEFEF">
				<td class="td" nowrap colspan="7">농작물,적부등 인보이스 현황<font color="red">(당월)</font></td>
				<td class="td" nowrap colspan="7">수임대장 + 농작물,적부등 인보이스 현황<font color="red">(당월)</font></td>
			</tr>
			<tr align="center" bgcolor="#EFEFEF">
				<td class="td" nowrap>기본료</td>
				<td class="td" nowrap>일비</td>
				<td class="td" nowrap>소계(기본+일)</td>
				<td class="td" nowrap>교통비</td>
				<td class="td" nowrap>자문료</td>
				<td class="td" nowrap>기타</td>
				<td class="td" nowrap>합계</td>
				<td class="td" nowrap>기본료</td>
				<td class="td" nowrap>일비</td>
				<td class="td" nowrap>소계(기본+일)</td>
				<td class="td" nowrap>교통비</td>
				<td class="td" nowrap>자문료</td>
				<td class="td" nowrap>기타</td>
				<td class="td" nowrap>합계</td>
			</tr>
			</thead>
		</table>
	</div>
    <div style="height:560px; overflow-x: hidden; overflow-y: auto;">
        <table cellpadding="0" cellspacing="0" width="1060" summary="팀 기본통계 1종">
            <caption>팀 기본통계</caption>
            <colgroup>
                <col width="65">
                <col width="130">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="80">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="80">
            </colgroup>
            <tbody>
            <c:forEach var="vo" items="${getMisTmBscPrim1}" varStatus="status">
                <tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${getMisTmBscPrim1.size()}">1종</td>
                    </c:if>
                    <td><p><a href="javascript:goMisTmBscPrimMbr('${vo.team_id}','${vo.team_name}','${vo.team_type}');">${vo.team_name}</a></p></td>
                    <td><a href="javascript:goMisTmBscPrimMbr2('${vo.team_id}','${vo.team_name}','${vo.team_type}');">${vo.tmUserCnt}</a></td>
                    <td><fmt:formatNumber value="${vo.price_assess_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_time_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_sum_little_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_traffic_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_question_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_receipt_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_sum_hap_nsc}" pattern="#,##0.##"/></td>
                    <td><font color="red"><fmt:formatNumber value="${vo.no_settle_nsc}" pattern="#,##0.##"/></font></td>
                    <td><fmt:formatNumber value="${vo.price_assess+vo.price_assess_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_time+vo.price_time_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_sum_little+vo.price_sum_little_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_traffic+vo.price_traffic_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_question+vo.price_question_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_receipt+vo.price_receipt_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_sum_hap+vo.price_sum_hap_nsc}" pattern="#,##0.##"/></td>
                    <td><font color="red"><fmt:formatNumber value="${vo.no_settle+vo.no_settle_nsc}" pattern="#,##0.##"/></font></td>
                    <c:set var="sumTmUserCnt" value="${vo.tmUserCnt + sumTmUserCnt}" />
                    <c:set var="sumPrice_assess1" value="${vo.price_assess_nsc + sumPrice_assess1}" />
                    <c:set var="sumPrice_time1" value="${vo.price_time_nsc + sumPrice_time1}" />
                    <c:set var="sumPrice_sum_little1" value="${vo.price_sum_little_nsc + sumPrice_sum_little1}" />
                    <c:set var="sumPrice_traffic1" value="${vo.price_traffic_nsc + sumPrice_traffic1}" />
                    <c:set var="sumPrice_question1" value="${vo.price_question_nsc + sumPrice_question1}" />
                    <c:set var="sumPrice_receipt1" value="${vo.price_receipt_nsc + sumPrice_receipt1}" />
                    <c:set var="sumPrice_sum_hap1" value="${vo.price_sum_hap_nsc + sumPrice_sum_hap1}" />
                    <c:set var="sumNo_settle1" value="${vo.no_settle_nsc + sumNo_settle1}" />

                    <c:set var="sumPrice_assess1_nsc" value="${vo.price_assess+vo.price_assess_nsc + sumPrice_assess1_nsc}" />
                    <c:set var="sumPrice_time1_nsc" value="${vo.price_time+vo.price_time_nsc + sumPrice_time1_nsc}" />
                    <c:set var="sumPrice_sum_little1_nsc" value="${vo.price_sum_little+vo.price_sum_little_nsc + sumPrice_sum_little1_nsc}" />
                    <c:set var="sumPrice_traffic1_nsc" value="${vo.price_traffic+vo.price_traffic_nsc + sumPrice_traffic1_nsc}" />
                    <c:set var="sumPrice_question1_nsc" value="${vo.price_question+vo.price_question_nsc + sumPrice_question1_nsc}" />
                    <c:set var="sumPrice_receipt1_nsc" value="${vo.price_receipt+vo.price_receipt_nsc + sumPrice_receipt1_nsc}" />
                    <c:set var="sumPrice_sum_hap1_nsc" value="${vo.price_sum_hap+vo.price_sum_hap_nsc + sumPrice_sum_hap1_nsc}" />
                    <c:set var="sumNo_settle1_nsc" value="${vo.no_settle+vo.no_settle_nsc + sumNo_settle1_nsc}" />
                </tr>
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">1종 합계</td>
                <td>${sumTmUserCnt}</td>
                <td><fmt:formatNumber value="${sumPrice_assess1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_time1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_sum_little1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_question1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_receipt1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_sum_hap1}" pattern="#,##0.##"/></td>
                <td><font color="red"><fmt:formatNumber value="${sumNo_settle1}" pattern="#,##0.##"/></font></td>
                <td><fmt:formatNumber value="${sumPrice_assess1_nsc}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_time1_nsc}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_sum_little1_nsc}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic1_nsc}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_question1_nsc}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_receipt1_nsc}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_sum_hap1_nsc}" pattern="#,##0.##"/></td>
                <td><font color="red"><fmt:formatNumber value="${sumNo_settle1_nsc}" pattern="#,##0.##"/></font></td>
            </tr>
            <c:forEach var="vo" items="${getMisTmBscPrim4}" varStatus="status">
                <tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${getMisTmBscPrim4.size()}">4종</td>
                    </c:if>
                    <td><p><a href="javascript:goMisTmBscPrimMbr('${vo.team_id}','${vo.team_name}','${vo.team_type}');">${vo.team_name}</a></p></td>
                    <td><a href="javascript:goMisTmBscPrimMbr2('${vo.team_id}','${vo.team_name}','${vo.team_type}');">${vo.tmUserCnt}</a></td>
                    <td><fmt:formatNumber value="${vo.price_assess_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_time_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_sum_little_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_traffic_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_question_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_receipt_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_sum_hap_nsc}" pattern="#,##0.##"/></td>
                    <td><font color="red"><fmt:formatNumber value="${vo.no_settle_nsc}" pattern="#,##0.##"/></font></td>
                    <td><fmt:formatNumber value="${vo.price_assess+vo.price_assess_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_time+vo.price_time_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_sum_little+vo.price_sum_little_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_traffic+vo.price_traffic_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_question+vo.price_question_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_receipt+vo.price_receipt_nsc}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_sum_hap+vo.price_sum_hap_nsc}" pattern="#,##0.##"/></td>
                    <td><font color="red"><fmt:formatNumber value="${vo.no_settle+vo.no_settle_nsc}" pattern="#,##0.##"/></font></td>
                    <c:set var="sumTmUserCnt4" value="${vo.tmUserCnt + sumTmUserCnt4}" />
                    <c:set var="sumPrice_assess4" value="${vo.price_assess + sumPrice_assess4}" />
                    <c:set var="sumPrice_time4" value="${vo.price_time + sumPrice_time4}" />
                    <c:set var="sumPrice_sum_little4" value="${vo.price_sum_little + sumPrice_sum_little4}" />
                    <c:set var="sumPrice_traffic4" value="${vo.price_traffic + sumPrice_traffic4}" />
                    <c:set var="sumPrice_question4" value="${vo.price_question + sumPrice_question4}" />
                    <c:set var="sumPrice_receipt4" value="${vo.price_receipt + sumPrice_receipt4}" />
                    <c:set var="sumPrice_sum_hap4" value="${vo.price_sum_hap + sumPrice_sum_hap4}" />
                    <c:set var="sumNo_settle4" value="${vo.no_settle + sumNo_settle4}" />
                    <c:set var="sumPrice_assess4_nsc" value="${vo.price_assess+vo.price_assess_nsc + sumPrice_assess4}" />
                    <c:set var="sumPrice_time4_nsc" value="${vo.price_time+vo.price_time_nsc + sumPrice_time4}" />
                    <c:set var="sumPrice_sum_little4_nsc" value="${vo.price_sum_little+vo.price_sum_little_nsc + sumPrice_sum_little4}" />
                    <c:set var="sumPrice_traffic4_nsc" value="${vo.price_traffic+vo.price_traffic_nsc + sumPrice_traffic4}" />
                    <c:set var="sumPrice_question4_nsc" value="${vo.price_question+vo.price_question_nsc + sumPrice_question4}" />
                    <c:set var="sumPrice_receipt4_nsc" value="${vo.price_receipt+vo.price_receipt_nsc + sumPrice_receipt4}" />
                    <c:set var="sumPrice_sum_hap4_nsc" value="${vo.price_sum_hap + vo.price_sum_hap_nsc + sumPrice_sum_hap4_nsc}" />
                    <c:set var="sumNo_settle4_nsc" value="${vo.no_settle+vo.no_settle_nsc + sumNo_settle4}" />
                </tr>
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">4종 합계</td>
                <td>${sumTmUserCnt4}</td>
                <td><fmt:formatNumber value="${sumPrice_assess4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_time4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_sum_little4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_question4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_receipt4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_sum_hap4}" pattern="#,##0.##"/></td>
                <td><font color="red"><fmt:formatNumber value="${sumNo_settle4}" pattern="#,##0.##"/></font></td>
                <td><fmt:formatNumber value="${sumPrice_assess4_nsc}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_time4_nsc}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_sum_little4_nsc}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic4_nsc}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_question4_nsc}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_receipt4_nsc}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_sum_hap4_nsc}" pattern="#,##0.##"/></td>
                <td><font color="red"><fmt:formatNumber value="${sumNo_settle4_nsc}" pattern="#,##0.##"/></font></td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">합계</td>
                <td>${sumTmUserCnt+sumTmUserCnt4}</td>
                <td><fmt:formatNumber value="${sumPrice_assess1+sumPrice_assess4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_time1+sumPrice_time4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_sum_little1+sumPrice_sum_little4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic1+sumPrice_traffic4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_question1+sumPrice_question4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_receipt1+sumPrice_receipt4}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_sum_hap1+sumPrice_sum_hap4}" pattern="#,##0.##"/></td>
                <td><font color="red"><fmt:formatNumber value="${sumNo_settle1+sumNo_settle4}" pattern="#,##0.##"/></font></td>
                <td><fmt:formatNumber value="${sumPrice_assess1_nsc+sumPrice_assess4_nsc}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_time1_nsc+sumPrice_time4_nsc}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_sum_little1_nsc+sumPrice_sum_little4_nsc}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic1_nsc+sumPrice_traffic4_nsc}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_question1_nsc+sumPrice_question4_nsc}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_receipt1_nsc+sumPrice_receipt4_nsc}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_sum_hap1_nsc+sumPrice_sum_hap4_nsc}" pattern="#,##0.##"/></td>
                <td><font color="red"><fmt:formatNumber value="${sumNo_settle1_nsc+sumNo_settle4_nsc}" pattern="#,##0.##"/></font></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
