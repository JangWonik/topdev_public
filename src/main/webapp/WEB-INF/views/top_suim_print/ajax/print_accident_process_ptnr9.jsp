<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table class="center">
    <col width="15%">
    <col width="10%">
    <col width="21%">
    <col width="20%">
    <col width="15%">
    <col width="10%">
    <col width="9%">
    <tr>
        <th>일자</th>
        <th>일수</th>
        <th>업무내용</th>
        <th>세부내용</th>
        <th>지연주체</th>
        <th>지연일수</th>
        <th>-</th>
    </tr>
    <c:forEach var="item" items="${reportAccidentProcessList}" varStatus="status">
        <tr id="tr_accident_process_view${status.index}">
            <td>${item.controlDate}</td>
            <td>${item.controlDateCnt}일</td>
            <td>${item.controlSubject}</td>
            <td>${item.controlMemo}</td>
            <td>
                <c:choose>
                    <c:when test="${item.controlDelayAgent == 1}">보험사</c:when>
                    <c:when test="${item.controlDelayAgent == 2}">수익자</c:when>
                    <c:when test="${item.controlDelayAgent == 3}">계약자</c:when>
                    <c:when test="${item.controlDelayAgent == 4}">피보험자</c:when>
                </c:choose>
            </td>
            <td>${item.controlDelayCnt}일</td>
            <td>
                <a href="#noloc" onclick="fnAccidentProcessEdit('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
                <a href="#noloc" onclick="fnAccidentProcessDelete('${status.index}');"><img src='./resources/ls_img/btn_del_s.gif'></a>
            </td>
        </tr>
        <tr id="tr_accident_process_edit${status.index}" style="display: none;">
            <td>
                <input type="hidden" id="ap_serial_no${status.index}" value="${item.serialNo}">
                <input type="text" id="ap_control_date${status.index}" class="calendar" value="${item.controlDate}" style="width: 80%;" maxlength="10"/> ~ <br/>
                <input type="text" id="ap_control_end_date${status.index}" onchange="fnAccidentProcessCalcDate('${status.index}');" class="calendar" value="${item.controlEndDate}" style="width: 80%;" maxlength="10"/>
            </td>
            <td><input type="text" id="ap_control_date_cnt${status.index}" class="money" style="text-align: right" value="${item.controlDateCnt}" maxlength="10"></td>
            <td>
                <select id="ap_control_subject${status.index}" onchange="fnAPSubjectChange(this,'${status.index}');">
                    <option value="0">--선택--</option>
                    <c:set var="ap_subject_selected" value="0"/>
                    <c:forEach var="item_subject" items="${reportWorkCodeList}">
                        <c:if test="${item.controlSubject == item_subject}">
                            <c:set var="ap_subject_selected" value="1"/>
                        </c:if>
                        <option value="${item_subject}" <c:if test="${item.controlSubject == item_subject}">selected</c:if>>${item_subject}</option>
                    </c:forEach>
                    <option value="999" <c:if test="${ap_subject_selected == 0}">selected</c:if>>직접입력</option>
                </select>
                <c:if test="${ap_subject_selected == 0}">
                    <input type="text" id="ap_control_subject_etc${status.index}" value="${item.controlSubject}" maxlength="80">
                </c:if>
                <c:if test="${ap_subject_selected != 0}">
                    <input type="text" id="ap_control_subject_etc${status.index}" style="display: none;" maxlength="80">
                </c:if>
            </td>
            <td>
                <select id="ap_control_memo${status.index}" onchange="fnAPMemoChange(this,'${status.index}');">
                    <option value="0">--선택--</option>
                    <c:set var="ap_memo_selected" value="0"/>
                    <c:forEach var="item_memo" items="${reportMemoCodeList}">
                        <c:if test="${item.controlMemo == item_memo.colVal}">
                            <c:set var="ap_memo_selected" value="1"/>
                        </c:if>
                        <option value="${item_memo.colVal}" <c:if test="${item.controlMemo == item_memo.colVal}">selected</c:if>>${item_memo.colVal}</option>
                    </c:forEach>
                    <option value="999" <c:if test="${ap_memo_selected == 0}">selected</c:if>>직접입력</option>
                </select>
                <c:if test="${ap_subject_selected == 0}">
                    <input type="text" id="ap_control_memo_etc${status.index}" value="${item.controlMemo}" maxlength="80">
                </c:if>
                <c:if test="${ap_subject_selected != 0}">
                    <input type="text" id="ap_control_memo_etc${status.index}" style="display: none;" maxlength="80">
                </c:if>
            </td>
            <td>
                <select id="ap_control_delay_agent${status.index}">
                    <option value="0">--선택--</option>
                    <option value="1" <c:if test="${item.controlDelayAgent == '1'}">selected</c:if>>보험사</option>
                    <option value="2" <c:if test="${item.controlDelayAgent == '2'}">selected</c:if>>수익자</option>
                    <option value="3" <c:if test="${item.controlDelayAgent == '3'}">selected</c:if>>계약자</option>
                    <option value="4" <c:if test="${item.controlDelayAgent == '4'}">selected</c:if>>피보험자</option>
                </select>
            </td>
            <td><input type="text" id="ap_control_delay_cnt${status.index}" class="money" style="text-align: right" value="${item.controlDelayCnt}" maxlength="10"></td>
            <td>
                <a href="#noloc" onclick="fnAccidentProcessSave('${status.index}', 'U')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                <a href="#noloc" onclick="fnAccidentProcessClose('${status.index}')"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
            </td>
        </tr>
    </c:forEach>
    <tr id="tr_accident_process_add" style="display: none;">
        <td>
            <input type="text" id="ap_control_date" class="calendar" value="" style="width: 80%;" maxlength="10"/> ~ <br/>
            <input type="text" id="ap_control_end_date" class="calendar" onchange="fnAccidentProcessCalcDate('');" value="" style="width: 80%;" maxlength="10"/>
        </td>
        <td><input type="text" id="ap_control_date_cnt" class="money" style="text-align: right" maxlength="10"></td>
        <td>
            <select id="ap_control_subject" onchange="fnAPSubjectChange(this,'');">
                <option value="0">--선택--</option>
                <c:forEach var="item" items="${reportWorkCodeList}" varStatus="status">
                    <option value="${item}">${item}</option>
                </c:forEach>
                <option value="999">직접입력</option>
            </select><br>
            <input type="text" id="ap_control_subject_etc" style="display: none" maxlength="80">

        </td>
        <td>
            <select id="ap_control_memo" onchange="fnAPMemoChange(this,'');">
                <option value="0">--선택--</option>
                <c:forEach var="item" items="${reportMemoCodeList}" varStatus="status">
                    <option value="${item.colVal}">${item.colVal}</option>
                </c:forEach>
                <option value="999">직접입력</option>
            </select>
            <input type="text" id="ap_control_memo_etc" style="display: none" maxlength="80">
        </td>
        <td>
            <select id="ap_control_delay_agent">
                <option value="0">--선택--</option>
                <option value="1">보험사</option>
                <option value="2">수익자</option>
                <option value="3">계약자</option>
                <option value="4">피보험자</option>
            </select>
        </td>
        <td><input type="text" id="ap_control_delay_cnt" class="money" style="text-align: right" maxlength="10"></td>
        <td>
            <a href="#noloc" onclick="fnAccidentProcessSave('', 'C');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
            <a href="#noloc" onclick="fnAccidentProcessCancel('');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
        </td>
    </tr>
    <tfoot id="tfoot_accident_process_view">
    <tr>
        <th colspan="5">
            <span style="color: red">총지연일수</span>
        </th>
        <td>${reportPrint1.printctrlAllDelayCnt}일</td>
        <td rowspan="3"><a href="#noloc" onclick="fnAccidentProcessTfootEdit();"><img src='./resources/ls_img/btn_edit_s.gif'></a></td>
    </tr>
    <tr>
        <th colspan="5">
            <span style="color: red">계약자, 피보험자, 수익자의 책임있는 사유 조사 지연일수</span>
        </th>
        <td>${reportPrint1.printctrlNotinsuDelayCnt}일</td>
    </tr>
    <tr>
        <th colspan="5" style="background-color: yellow">
            <span style="color: red">보험사 지연일수</span>
        </th>
        <td>${reportPrint1.printctrlInsuDelayCnt}일</td>
    </tr>
    </tfoot>
    <tfoot id="tfoot_accident_process_edit" style="display: none">
    <tr>
        <th colspan="5">
            <span style="color: red">총지연일수</span>
        </th>
        <td><input type="text" id="printctrl_all_delay_cnt" value="${reportPrint1.printctrlAllDelayCnt}" class="money" style="text-align: right" maxlength="10"></td>
        <td rowspan="3">
            <a href="#noloc" onclick="fnAccidentProcessTfootUpdate();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
            <a href="#noloc" onclick="fnAccidentProcessTfootClose();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
        </td>
    </tr>
    <tr>
        <th colspan="5">
            <span style="color: red">계약자, 피보험자, 수익자의 책임있는 사유 조사 지연일수</span>
        </th>
        <td><input type="text" id="printctrl_notinsu_delay_cnt" value="${reportPrint1.printctrlNotinsuDelayCnt}" class="money" style="text-align: right" maxlength="10"></td>
    </tr>
    <tr>
        <th colspan="5" style="background-color: yellow">
            <span style="color: red">보험사 지연일수</span>
        </th>
        <td><input type="text" id="printctrl_insu_delay_cnt" value="${reportPrint1.printctrlInsuDelayCnt}" class="money" style="text-align: right" maxlength="10"></td>
    </tr>
    </tfoot>
</table>