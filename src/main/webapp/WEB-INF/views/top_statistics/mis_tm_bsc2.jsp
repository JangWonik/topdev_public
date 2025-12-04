<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2">
	<div style="padding-right: 20px; background: #e7ecf1;">
        <table cellpadding="0" cellspacing="0" width="1060" summary="팀 기본통계 1종">
            <colgroup>
                <col width="130">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
            </colgroup>
            <thead>
            <tr style="bgcolor: #E7ECF1;">
                <td class="td" bgcolor="#E7ECF1" rowspan="3">
                    <p align="center"><B>팀명</B></p>
                </td>
                <td class="td" bgcolor="#E7ECF1" colspan="2">
                    <p align="center"><B>수임현황</B></p>
                </td>
                <td class="td" bgcolor="#E7ECF1" colspan="2">
                    <p align="center"><B>종결현황</B></p>
                </td>
                <td class="td" colspan="2" bgcolor="#E7ECF1" rowspan="2">
                    <p align="center"><b>처리율(%)</b></p>
                </td>
                <td class="td" bgcolor="#E7ECF1" colspan="2">
                    <p align="center"><B>미결현황</B></p>
                </td>
                <td class="td" bgcolor="#E7ECF1" colspan="2">
                    <p align="center"><B>종결평가</B></p>
                </td>
                <td class="td" bgcolor="#E7ECF1" colspan="7">
                    <p align="center"><b>공동수행자의 비율 및 금액을 반영한 결과<font color="red">(반영안함!)</font></b></p>
                </td>
                <td class="td" bgcolor="#E7ECF1" rowspan="3">
                    <p align="center"><B>미수금</B></p>
                </td>
            </tr>
            <tr>
                <td class="td" bgcolor="#E7ECF1" colspan="2">
                    <p align="center"><B>절대건수</B></p>
                </td>
                <td class="td" bgcolor="#E7ECF1" colspan="2">
                    <p align="center"><B>절대건수</B></p>
                </td>
                <td class="td" bgcolor="#E7ECF1" colspan="2">
                    <p align="center"><B>절대건수</B></p>
                </td>
                <td class="td" bgcolor="#E7ECF1" colspan="2">
                    <p align="center"><B>평가건수</B></p>
                </td>
                <td class="td" bgcolor="#E7ECF1" colspan="7">
                    <p align="center"><B>인보이스 현황<font color="red"><B>(당월)</B></font></p>
                </td>
            </tr>
            <tr>
                <th>당월</th>
                <th>년누계</th>
                <th>당월</th>
                <th>년누계</th>
                <th>당월</th>
                <th>년누계</th>
                <th>현재</th>
                <th>30,15</th>
                <th>당월</th>
                <th>년누계</th>
                <th>기본료</th>
                <th>일비</th>
                <th>소계<br />(기본+일)</th>
                <th>교통비</th>
                <th>자문료</th>
                <th>기타</th>
                <th>합계</th>
            </tr>
            </thead>
        </table>
    </div>
    <div style="height:540px; overflow-x: hidden; overflow-y: auto;">
        <table cellpadding="0" cellspacing="0" width="1060" summary="팀 기본통계 1종">
            <caption>팀 기본통계</caption>
            <colgroup>
                <col width="130">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
            </colgroup>

            <tbody>
            <c:forEach var="vo" items="${getMisTmBsc1}" varStatus="status">
                <tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <td><p><a href="javascript:goMisTmBscMbr('${vo.team_id}','${vo.team_name}','${vo.team_type}');"><c:out value="${vo.getTeam_name()}" /></a></p></td>
                    <td><fmt:formatNumber value="${vo.reg_m}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.reg_y}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.end_m}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.end_y}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.proc_m}" pattern="#,##0.##"/>%</td>
                    <td><fmt:formatNumber value="${vo.proc_y}" pattern="#,##0.##"/>%</td>
                    <td><fmt:formatNumber value="${vo.nend_p}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.nend_30r}" pattern="#,##0.##"/>%</td>
                    <td><fmt:formatNumber value="${vo.endea_m}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.endea_y}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_assess}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_time}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_sum_little}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_traffic}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_question}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_receipt}" pattern="#,##0.##"/></td>
                    <td><fmt:formatNumber value="${vo.price_sum_hap}" pattern="#,##0.##"/></td>
                    <td><font color="red"><fmt:formatNumber value="${vo.no_settle}" pattern="#,##0.##"/></font></td>
                    <c:set var="sumReg_m1" value="${vo.reg_m + sumReg_m1}" />
                    <c:set var="sumReg_y1" value="${vo.reg_y + sumReg_y1}" />
                    <c:set var="sumEnd_m1" value="${vo.end_m + sumEnd_m1}" />
                    <c:set var="sumEnd_y1" value="${vo.end_y + sumEnd_y1}" />
                    <c:set var="sumProc_m1" value="${vo.proc_m + sumProc_m1}" />
                    <c:set var="sumProc_y1" value="${vo.proc_y + sumProc_y1}" />
                    <c:set var="sumNend_p1" value="${vo.nend_p + sumNend_p1}" />
                    <c:set var="sumNend_30r1" value="${vo.nend_30r + sumNend_30r1}" />
                    <c:set var="sumEndea_m1" value="${vo.endea_m + sumEndea_m1}" />
                    <c:set var="sumEndea_y1" value="${vo.endea_y + sumEndea_y1}" />
                    <c:set var="sumPrice_assess1" value="${vo.price_assess + sumPrice_assess1}" />
                    <c:set var="sumPrice_time1" value="${vo.price_time + sumPrice_time1}" />
                    <c:set var="sumPrice_sum_little1" value="${vo.price_sum_little + sumPrice_sum_little1}" />
                    <c:set var="sumPrice_traffic1" value="${vo.price_traffic + sumPrice_traffic1}" />
                    <c:set var="sumPrice_question1" value="${vo.price_question + sumPrice_question1}" />
                    <c:set var="sumPrice_receipt1" value="${vo.price_receipt + sumPrice_receipt1}" />
                    <c:set var="sumPrice_sum_hap1" value="${vo.price_sum_hap + sumPrice_sum_hap1}" />
                    <c:set var="sumNo_settle1" value="${vo.no_settle + sumNo_settle1}" />
                </tr>
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td>1종 합계</td>
                <td><fmt:formatNumber value="${sumReg_m1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumReg_y1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_m1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEnd_y1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumProc_m1}" pattern="#,##0.##"/>%</td>
                <td><fmt:formatNumber value="${sumProc_y1}" pattern="#,##0.##"/>%</td>
                <td><fmt:formatNumber value="${sumNend_p1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumNend_30r1}" pattern="#,##0.##"/>%</td>
                <td><fmt:formatNumber value="${sumEndea_m1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumEndea_y1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_assess1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_time1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_sum_little1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_traffic1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_question1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_receipt1}" pattern="#,##0.##"/></td>
                <td><fmt:formatNumber value="${sumPrice_sum_hap1}" pattern="#,##0.##"/></td>
                <td><font color="red"><fmt:formatNumber value="${sumNo_settle1}" pattern="#,##0.##"/></font></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
