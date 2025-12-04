<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>
    <colgroup>
        <col width="11%">
        <col width="20%">
        <col width="20%">
        <col width="20%">
        <col width="20%">
        <col width="9%">
    </colgroup>
    <tr>
        <th>번호</th>
        <th>병.의원명</th>
        <th>소재지역</th>
        <th>연락처</th>
        <th>확인결과</th>
        <th>-</th>
    </tr>
    <c:forEach  var="item" items="${reportHospitalQuestionList}" varStatus="status">
        <tr id="tr_hospital_question_view${status.index}">
            <td style="text-align: center">${status.count}</td>
            <td><c:out value="${item.hsptName}"/></td>
            <td><c:out value="${item.hsptAddress}"/></td>
            <td><c:out value="${item.hsptTel}"/></td>
            <td><c:out value="${item.hsptConfirm}"/></td>
            <td style="text-align: center">
                <a href="#noloc" onclick="fnHospitalQuestionEdit('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
                <a href="#noloc" onclick="fnHospitalQuestionDelete('${status.index}');"><img src='./resources/ls_img/btn_del_s.gif'></a>
            </td>
        </tr>
        <tr id="tr_hospital_question_edit${status.index}" style="display: none;">
            <td style="text-align: center">${status.count}</td>
            <td>
                <input type="hidden" id="hq_serial_no${status.index}" value="${item.serialNo}">
                <input type="text" id="hq_hspt_name${status.index}" value="${item.hsptName}" maxlength="80">
            </td>
            <td>
                <input type="text" id="hq_hspt_address${status.index}" value="${item.hsptAddress}" maxlength="150">
            </td>
            <td>
                <input type="text" id="hq_hspt_tel${status.index}" value="${item.hsptTel}" maxlength="40">
            </td>
            <td>
                <input type="text" id="hq_hspt_confirm${status.index}" value="${item.hsptConfirm}" maxlength="250">
            </td>
            <td style="text-align: center">
                <a href="#noloc" onclick="fnHospitalQuestionSave('${status.index}','U');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                <a href="#noloc" onclick="fnHospitalQuestionClose('${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
            </td>
        </tr>
    </c:forEach>
    <tr id="tr_hospital_question_add" style="display: none;">
        <td style="text-align: center">-</td>
        <td>
            <input type="text" id="hq_hspt_name" value="" maxlength="80">
        </td>
        <td>
            <input type="text" id="hq_hspt_address" value="" maxlength="150">
        </td>
        <td>
            <input type="text" id="hq_hspt_tel" value="" maxlength="40">
        </td>
        <td>
            <input type="text" id="hq_hspt_confirm" value="" maxlength="250">
        </td>
        <td style="text-align: center">
            <a href="#noloc" onclick="fnHospitalQuestionSave('','C');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
            <a href="#noloc" onclick="fnHospitalQuestionCancel('');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
        </td>
    </tr>
</table>