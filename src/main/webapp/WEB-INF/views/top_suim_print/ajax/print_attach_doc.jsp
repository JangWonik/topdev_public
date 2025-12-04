<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table style="margin-top: 5px;">
    <colgroup>
        <col width="9%">
        <col width="37%">
        <col width="9%">
        <col width="36%">
        <col width="9%">
    </colgroup>
    <tr>
        <th>순번</th>
        <th>첨부자료</th>
        <th>부수</th>
        <th>비고</th>
        <th>-</th>
    </tr>
    <c:forEach  var="item" items="${reportAttachDocList}" varStatus="status">
        <tr id="tr_attach_doc_view${status.index}" class="tr_attach_doc_view">
            <td style="text-align: center">${status.count}</td>
            <td>${item.attachName}</td>
            <td style="text-align: center">${item.attachCopy}</td>
            <td>${item.attachEtcMemo}</td>
            <td style="text-align: center">
                <a href="#noloc" onclick="fnAttachDocEdit('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
                <a href="#noloc" onclick="fnAttachDocDelete('${status.index}');"><img src='./resources/ls_img/btn_del_s.gif'></a>
            </td>
        </tr>
        <tr id="tr_attach_doc_edit${status.index}" class="tr_attach_doc_edit" style="display: none;">
            <td style="text-align: center">${status.count}</td>
            <td>
                <input type="hidden" id="ad_serial_no${status.index}" value="${item.serialNo}">
                <input type="text" id="ad_attach_name${status.index}" value="${item.attachName}">
            </td>
            <td>
                <input type="text" id="ad_attach_copy${status.index}" class="money" value="${item.attachCopy}" style="text-align: right" maxlength="3">
            </td>
            <td>
                <select id="ad_attach_etc_memo${status.index}" onchange="fnADMemoChange(this,'${status.index}');">
                    <option value="">---선택---</option>
                    <c:set var="ad_memo_selected" value="0"/>
                    <c:forEach var="item_memo" items="${reportAttachDocCodeList}">
                        <c:if test="${item.attachEtcMemo == item_memo}">
                            <c:set var="ad_memo_selected" value="1"/>
                        </c:if>
                        <option value="${item_memo}" <c:if test="${item.attachEtcMemo == item_memo}">selected</c:if>>${item_memo}</option>
                    </c:forEach>
                    <option value="999" <c:if test="${ad_memo_selected == 0}">selected</c:if>>직접입력</option>
                </select>
                <c:if test="${ad_memo_selected == 0}">
                    <input type="text" id="ad_attach_etc_memo_etc${status.index}" value="${item.attachEtcMemo}" maxlength="80">
                </c:if>
                <c:if test="${ad_memo_selected != 0}">
                    <input type="text" id="ad_attach_etc_memo_etc${status.index}" style="display: none;" maxlength="80">
                </c:if>
            </td>
            <td style="text-align: center">
                <a href="#noloc" onclick="fnAttachDocSave('${status.index}','U');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                <a href="#noloc" onclick="fnAttachDocClose('${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
            </td>
        </tr>
    </c:forEach>
    <tr id="tr_attach_doc_add" style="display: none;">
        <td style="text-align: center">${status.count}</td>
        <td>
            <input type="text" id="ad_attach_name" value="" maxlength="80">
        </td>
        <td>
            <input type="text" id="ad_attach_copy" value="" class="money" maxlength="3" style="text-align: right">
        </td>
        <td>
            <select id="ad_attach_etc_memo" onchange="fnADMemoChange(this,'${status.index}');">
                <option value="">---선택---</option>
                <c:forEach var="item_memo" items="${reportAttachDocCodeList}">
                    <option value="${item_memo}">${item_memo}</option>
                </c:forEach>
                <option value="999">직접입력</option>
            </select>
            <input type="text" id="ad_attach_etc_memo_etc" style="display: none;" maxlength="80">
        </td>
        <td style="text-align: center">
            <a href="#noloc" onclick="fnAttachDocSave('','C');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
            <a href="#noloc" onclick="fnAttachDocCancel();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
        </td>
    </tr>
</table>