<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>
    <colgroup>
        <col width="25%">
        <col width="25%">
        <col width="41%">
        <col width="9%">
    </colgroup>
    <tr>
        <th>보험사</th>
        <th>계약내용</th>
        <th>중요사항</th>
        <th>-</th>
    </tr>
    <c:forEach  var="item" items="${reportOtherInsuList}" varStatus="status">
        <tr id="tr_other_insu_view${status.index}">
            <td>${item.otherInsuCom}</td>
            <td>${item.otherInsuDtl}</td>
            <td>${item.otherInsuContract}</td>
            <td style="text-align: center">
                <a href="#noloc" id="btn_insure_edit${status.index}" onclick="fnOtherInsuEdit('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
                <a href="#noloc" id="btn_insure_delete${status.index}" onclick="fnOtherInsuDelete('${status.index}');"><img src='./resources/ls_img/btn_del_s.gif'></a>
            </td>
        </tr>
        <tr id="tr_other_insu_edit${status.index}" style="display: none;">
            <td>
                <input type="text" id="o_other_insu_com${status.index}" value="${item.otherInsuCom}" maxlength="60">
                <input type="hidden" id="o_serial_no${status.index}" value="${item.serialNo}"/>
            </td>
            <td>
                <input type="text" id="o_other_insu_dtl${status.index}" value="${item.otherInsuDtl}">
            </td>
            <td>
                <input type="text" id="o_other_insu_contract${status.index}" value="${item.otherInsuContract}" maxlength="120">
            </td>
            <td style="text-align: center">
                <a href="#noloc" id="btn_insure_update${status.index}" onclick="fnOtherInsuUpdate('${status.index}');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                <a href="#noloc" id="btn_insure_close${status.index}" onclick="fnOtherInsuClose('${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
            </td>
        </tr>
    </c:forEach>
    <tr id="tr_other_insu_add" style="display: none;">
        <td>
            <input type="text" id="o_other_insu_com" value="" maxlength="60">
        </td>
        <td>
            <input type="text" id="o_other_insu_dtl" value="" >
        </td>
        <td>
            <input type="text" id="o_other_insu_contract" value="" maxlength="120">
        </td>
        <td style="text-align: center">
            <a href="#noloc" id="btn_insure_save" onclick="fnOtherInsuSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
            <a href="#noloc" id="btn_insure_cancel" onclick="fnOtherInsuCancel();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
        </td>
    </tr>
</table>