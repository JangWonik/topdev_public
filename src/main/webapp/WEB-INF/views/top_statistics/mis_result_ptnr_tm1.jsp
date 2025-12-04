<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2">
    <div style="padding-right: 20px; background: #e7ecf1;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
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
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
            </colgroup>
            <thead>
            <tr>
                <th>Type</th>
                <th>보험사</th>
                <th>유지/지급</th>
                <th>유지/삭감</th>
                <th>유지/면책</th>
                <th>해지/지급</th>
                <th>해지/삭감</th>
                <th>해지/면책</th>
                <th>부담보/지급</th>
                <th>부담보/삭감</th>
                <th>부담보/면책</th>
                <th>합계</th>
            </tr>
            </thead>
        </table>
    </div>
    <div style="height:632px; overflow-x: hidden; overflow-y: auto;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
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
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
                <col width="65">
            </colgroup>
            <tbody>
            <c:forEach var="vo4" items="${MisResultPtnrTm}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisResultPtnrTm.size() + 1}">4종</td>
                    </c:if>
                    <td><a href="javascript:goMisResultPtnrMbr('${inVO.ptnr_id}','${inVO.ptnr_nick}','${vo4.team_id}','${vo4.team_name}','${inVO.viewFromDate}','${inVO.viewToDate}');">${vo4.team_name}</a></td>
                    <td>
                        <c:out value="${vo4.getResult_1()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getResult_2()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getResult_3()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getResult_4()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getResult_5()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getResult_6()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getResult_7()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getResult_8()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getResult_9()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.result_1+vo4.result_2+vo4.result_3+vo4.result_4+vo4.result_5+vo4.result_6+vo4.result_7+vo4.result_8+vo4.result_9}"	/>
                    </td>
                </tr>
                <c:set var="sumResult_9" value="${sumResult_9 + vo4.result_9}" />
                <c:set var="sumResult_8" value="${sumResult_8 + vo4.result_8}" />
                <c:set var="sumResult_7" value="${sumResult_7 + vo4.result_7}" />
                <c:set var="sumResult_6" value="${sumResult_6 + vo4.result_6}" />
                <c:set var="sumResult_5" value="${sumResult_5 + vo4.result_5}" />
                <c:set var="sumResult_4" value="${sumResult_4 + vo4.result_4}" />
                <c:set var="sumResult_3" value="${sumResult_3 + vo4.result_3}" />
                <c:set var="sumResult_2" value="${sumResult_2 + vo4.result_2}" />
                <c:set var="sumResult_1" value="${sumResult_1 + vo4.result_1}" />
                <c:set var="sumResult_sum" value="${sumResult_sum + vo4.result_1+vo4.result_2+vo4.result_3+vo4.result_4+vo4.result_5+vo4.result_6+vo4.result_7+vo4.result_8+vo4.result_9}" />
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td>합계</td>
                <td>${sumResult_1}</td>
                <td>${sumResult_2}</td>
                <td>${sumResult_3}</td>
                <td>${sumResult_4}</td>
                <td>${sumResult_5}</td>
                <td>${sumResult_6}</td>
                <td>${sumResult_7}</td>
                <td>${sumResult_8}</td>
                <td>${sumResult_9}</td>
                <td>${sumResult_sum}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
