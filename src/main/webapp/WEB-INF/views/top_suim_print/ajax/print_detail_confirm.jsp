<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<c:forEach  var="itemEtc" items="${reportDetailConfirmList}" varStatus="status">
    <div id="div_detail_confirm99${status.index}" style="border: 1px solid #000000; margin-top: 10px;"> <!--기타 Loop -->
        <div id="div_detail_confirm_view99${status.index}">
            <div class="display-table" style="height: 40px; background-color:#ececec;">
                <div id="div_detail_confirm_view_title99${status.index}" class="display-cell panel-title" style="padding-left: 10px;">
                        ${itemEtc.detailTitle}
                </div>
            </div>
            <div class="display-table" style="border-top: 1px solid #000000; height: 100px;">
                <div id="div_detail_confirm_view_txt99${status.index}" class="display-cell" style="width: 91%; padding: 5px; vertical-align: top;">
                        ${itemEtc.detailContent}
                </div>
                <div class="display-cell text-center" style="width: 9%;">
                    <a href="#noloc" onclick="fnDetailConfirmEdit('99${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
                    <a href="#noloc" onclick="fnDetailConfirmDel('99${status.index}');"><img src='./resources/ls_img/btn_del_s.gif'></a>
                </div>
            </div>
        </div>
        <div id="div_detail_confirm_edit99${status.index}" style="display: none;">
            <div class="display-table" style="height: 40px; background-color:#ececec;">
                <div class="display-cell panel-title" style="padding-left: 10px;">
                    <input type="hidden" id="d_serial_no99${status.index}" value="${itemEtc.serialNo}">
                    <input type="text" id="detail_title99${status.index}" value="${itemEtc.detailTitle}" style="width: 80%;">
                </div>
            </div>
            <div class="display-table" style="border-top: 1px solid #000000;">
                <div class="display-cell" style="width: 91%; padding: 5px;">
                    <textarea id="detail_content99${status.index}" style="height: 150px;">${fn:replace(fn:replace(itemEtc.detailContent,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
                </div>
                <div class="display-cell text-center" style="width: 9%;">
                    <a href="#noloc" onclick="fnDetailConfirmUpdate('99${status.index}','Y');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                    <a href="#noloc" onclick="fnDetailConfirmClose('99${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                </div>
            </div>
        </div>
    </div>
</c:forEach>
<div id="div_detail_confirm_add" style="border: 1px solid #000000; margin-top: 10px; display: none;"> <!--기타 추가 -->
    <div class="display-table" style="height: 40px; background-color:#ececec;">
        <div class="display-cell panel-title" style="padding-left: 10px;">
            <input type="text" id="detail_title" style="width: 80%;" maxlength="80">
        </div>
    </div>
    <div class="display-table" style="border-top: 1px solid #000000;">
        <div class="display-cell" style="width: 91%; padding: 5px;">
            <textarea id="detail_content" style="height: 150px;"></textarea>
        </div>
        <div class="display-cell text-center" style="width: 9%;">
            <a href="#noloc" onclick="fnDetailConfirmSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
            <a href="#noloc" onclick="fnDetailConfirmCancel();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
        </div>
    </div>
</div>