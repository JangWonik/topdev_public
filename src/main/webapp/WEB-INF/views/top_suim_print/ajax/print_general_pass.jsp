<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<table>
    <colgroup>
        <col width="9%">
        <col width="25%">
        <col width="41%">
        <col width="14%">
        <col width="9%">
    </colgroup>
    <tr>
        <th>정렬</th>
        <th>일자</th>
        <th>내용</th>
        <th>비고</th>
        <th>-</th>
    </tr>
    <c:forEach  var="item" items="${reportGeneralPassList}" varStatus="status">
        <tr id="tr_general_pass_view${status.index}" style="height: 125px;">
            <td style="text-align: center">${item.sortSn}</td>
            <td style="text-align: center">
                    ${item.investigateToDate}<br> ~ ${item.investigateFromDate}<br> (${item.investigateDateDtl})
            </td>
            <td style="vertical-align: top;">${item.investigateDtl}</td>
            <td>${item.investigateOutline}</td>
            <td style="text-align: center">
                <a href="#noloc" onclick="fnGeneralPassEdit('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
                <a href="#noloc" onclick="fnGeneralPassDelete('${status.index}');"><img src='./resources/ls_img/btn_del_s.gif'></a>
            </td>
        </tr>
        <tr id="tr_general_pass_edit${status.index}" style="display: none">
            <td>
                <input type="text" id="gp_sort_sn${status.index}" name="sort_sn" value="${item.sortSn}" onkeyup="digitOnly(this);" style="text-align: right" maxlength="3">
            </td>
            <td style="text-align: center">
                <input type="hidden" id="g_serial_no${status.index}" value="${item.serialNo}">
                <input type="text" id="investigate_to_date${status.index}" class="calendar" value="${item.investigateToDate}" style="width: 55%;" maxlength="10"/> ~ <br>
                <input type="text" id="investigate_from_date${status.index}" class="calendar" value="${item.investigateFromDate}" style="width: 55%;" maxlength="10"/><br/>
                <input type="radio" id="patientType1${status.index}" name="patientType" onclick="fnGeneralPassType('1','${status.index}');" checked="checked"><label for="patientType1${status.index}">입원</label>&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" id="patientType2${status.index}" name="patientType" onclick="fnGeneralPassType('2','${status.index}');"><label for="patientType2${status.index}">통원</label><br>
                <input type="text" id="investigate_date_dtl${status.index}" value="${item.investigateDateDtl}" maxlength="20"/>
            </td>
            <td>
                <c:set var="investigateDtl" value="${fn:replace(item.investigateDtl, '<br>' , CRLF)}"/>
                <c:set var="investigateDtl" value="${fn:replace(investigateDtl, '&nbsp;' , ' ')}"/>
                <textarea id="investigate_dtl${status.index}" style="height: 100px;">${investigateDtl}</textarea>
            </td>
            <td>
                <input type="text" id="investigate_outline${status.index}" value="${item.investigateOutline}">
            </td>
            <td style="text-align: center">
                <a href="#noloc" id="btn_general_pass_save" onclick="fnGeneralPassSave('U','${status.index}');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                <a href="#noloc" id="btn_general_pass_close" onclick="fnGeneralPassClose('${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
            </td>
        </tr>
    </c:forEach>
    <tr id="tr_general_pass_add" style="display: none">
        <td>
            <input type="text" id="gp_sort_sn" name="sort_sn" onkeyup="digitOnly(this);" style="text-align: right" maxlength="3">
        </td>
        <td style="text-align: center">
            <input type="text" id="investigate_to_date" class="calendar" name="stDate" value="" style="width: 55%;" maxlength="10"/> ~ <br>
            <input type="text" id="investigate_from_date" class="calendar" name="edDate" value="" style="width: 55%;" maxlength="10"/><br/>
            <input type="radio" id="patientType1" name="patientType" onclick="fnGeneralPassType('1','');"><label for="patientType1">입원</label>&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="radio" id="patientType2" name="patientType" onclick="fnGeneralPassType('2','');"><label for="patientType2">통원</label><br>
            <input type="text" id="investigate_date_dtl" value="" maxlength="20"/>
        </td>
        <td>
            <%
                String preTextAreaAddText = "- 내원경위 : \n- 검사사항 : \n- 진단병명 : \n- 치료사항 : \n";
            %>
            <textarea id="investigate_dtl" style="height: 100px;"><%=preTextAreaAddText%></textarea>
        </td>
        <td>
            <input type="text" id="investigate_outline" value="">
        </td>
        <td style="text-align: center">
            <a href="#noloc" onclick="fnGeneralPassSave('C','');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
            <a href="#noloc" onclick="fnGeneralPassCancel();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
        </td>
    </tr>
</table>
