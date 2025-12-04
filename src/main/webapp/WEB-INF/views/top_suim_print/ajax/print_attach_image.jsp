<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>
    <colgroup>
        <col width="10%">
        <col width="60%">
        <col width="21%">
        <col width="9%">
    </colgroup>
    <tr>
        <th>순서</th>
        <th>설명</th>
        <th>파일명</th>
        <th>-</th>
    </tr>
    <c:forEach var="item" items="${reportAttachImageList}" varStatus="status">
        <tr id="tr_attach_image_view${status.index}">
            <td>${item.imgRank}</td>
            <td>${item.imgMemo}</td>
            <td>${item.imgName}</td>
            <td>
                <a href="#noloc" onclick="fnAttachImageEdit('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
                <a href="#noloc" onclick="fnAttachImageDelete('${status.index}');"><img src='./resources/ls_img/btn_del_s.gif'></a>
            </td>
        </tr>
        <tr id="tr_attach_image_edit${status.index}" style="display: none;">
            <td>
                <input type="hidden" id="ai_serial_no${status.index}" value="${item.serialNo}">
                <input type="text" id="ai_img_rank${status.index}" value="${item.imgRank}" onkeyup="digitOnly(this);">
            </td>
            <td><input type="text" id="ai_img_memo${status.index}" value="${item.imgMemo}"></td>
            <td>${item.imgName}</td>
            <td>
                <a href="#noloc" onclick="fnAttachImageUpdate('${status.index}');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                <a href="#noloc" onclick="fnAttachImageClose('${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
            </td>
        </tr>
    </c:forEach>
</table>