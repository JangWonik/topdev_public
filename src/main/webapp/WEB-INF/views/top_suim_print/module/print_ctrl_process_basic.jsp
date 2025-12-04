<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
    function fnAccidentProcessAdd(){
        $("#btn_accident_process_add").hide();
        $("#tr_accident_process_add").show();
    }

    function fnAccidentProcessCancel(){
        $("#btn_accident_process_add").show();
        $("#tr_accident_process_add").hide();
    }

    function fnAccidentProcessRefresh(){

    }


    function fnAccidentProcessSave(idx, cmd){

        if($("#ap_control_date" + idx).val() == ""){
            alert("시작일자를 입력해주세요.");
            $("#ap_control_date" + idx).focus();
            return;
        }

        var subject = $("#ap_control_subject" + idx + " option:selected").val();     //업무내용
        if(subject == "0" || (subject == "999" && $("#ap_control_subject_etc" + idx).val() == "" )){
            alert("업무내용을 선택해 주세요.");
            if (subject == "999"){
                $("#ap_control_subject_etc" + idx).focus();
            }else{
                $("#ap_control_subject" + idx).focus();
            }
            return;
        }

        var memo = $("#ap_control_memo" + idx + " option:selected").val();           //세부내용
        if(memo == "0" || (memo == "999" && $("#ap_control_memo_etc" + idx).val() == "" )){
            alert("세부내용을 선택해 주세요.");
            if (memo == "999"){
                $("#ap_control_memo_etc" + idx).focus();
            }else{
                $("#ap_control_memo" + idx).focus();
            }
            return;
        }

        /** 넘길 데이터 정리  **/
        var param = {};
        param.suim_rpt_no               = $("#suim_rpt_no").val();
        param.rpt_print_no              = $("#rpt_print_no").val();
        param.cmd                       = cmd;
        if (cmd == 'U' || cmd == 'D' ){
            param.serial_no             = $("#ap_serial_no" + idx).val();
        }

        param.control_date              = $("#ap_control_date" + idx).val();

        if(subject == "999"){
            param.control_subject       = $("#ap_control_subject_etc" + idx).val();
        }else{
            param.control_subject       = subject;
        }

        if(memo == "999"){
            param.control_memo          = $("#ap_control_memo_etc" + idx).val();
        }else{
            param.control_memo          = memo;
        }

        var url = "./report_accident_process";

        $.ajax({
            type: "POST",
            url: url,
            data: param,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "html",
            timeout: 20000,
            success: function(data){
                $("#div_accident_process").html(data);
                fnAccidentProcessCancel();
                _initDatePicker();
                _initMask();
            },
            error: function(xhr, status, error){
                if(xhr.status == "901"){
                    fnWinClose();
                }else{
                    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                }
            },
            beforeSend : function(xmlHttpRequest){
                xmlHttpRequest.setRequestHeader("AJAX", "true");
            }
        });

    }

    function fnAccidentProcessEdit(idx){
        $("#tr_accident_process_view" + idx).hide();
        $("#tr_accident_process_edit" + idx).show();
    }

    function fnAccidentProcessClose(idx){
        $("#tr_accident_process_view" + idx).show();
        $("#tr_accident_process_edit" + idx).hide();
    }

    function fnAccidentProcessDelete(idx){
        if(confirm("삭제하시겠습니까?")){
            var param = {};
            param.suim_rpt_no     = $("#suim_rpt_no").val();
            param.rpt_print_no    = $("#rpt_print_no").val();
            param.cmd             = 'D';
            param.serial_no       = $("#ap_serial_no" + idx).val();

            var url = "./report_accident_process";

            $.ajax({
                type: "POST",
                url: url,
                data: param,
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                dataType: "html",
                timeout: 20000,
                success: function(data){
                    $("#div_accident_process").html(data);
                    fnAccidentProcessCancel();
                    _initDatePicker();
                    _initMask();
                },
                error: function(xhr, status, error){
                    if(xhr.status == "901"){
                        fnWinClose();
                    }else{
                        alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                    }
                },
                beforeSend : function(xmlHttpRequest){
                    xmlHttpRequest.setRequestHeader("AJAX", "true");
                }
            });
        }
    }

    function fnAPSubjectChange(that, idx) {
        if(that.value == '999'){
            $("#ap_control_subject_etc" + idx).show();
        }else{
            $("#ap_control_subject_etc" + idx).hide();
        }
    }

    function fnAPMemoChange(that, idx) {
        if(that.value == '999'){
            $("#ap_control_memo_etc" + idx).show();
        }else{
            $("#ap_control_memo_etc" + idx).hide();
        }
    }
</script>
<div id="div_accident_process">
    <table class="center">
        <col width="21%">
        <col width="35%">
        <col width="35%">
        <col width="9%">
        <tr>
            <th>일자</th>
            <th>업무내용</th>
            <th>세부내용</th>
            <th>-</th>
        </tr>
        <c:forEach var="item" items="${reportAccidentProcessList}" varStatus="status">
            <tr id="tr_accident_process_view${status.index}">
                <td>${item.controlDate}</td>
                <td>${item.controlSubject}</td>
                <td>${item.controlMemo}</td>
                <td>
                    <a href="#noloc" onclick="fnAccidentProcessEdit('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
                    <a href="#noloc" onclick="fnAccidentProcessDelete('${status.index}');"><img src='./resources/ls_img/btn_del_s.gif'></a>
                </td>
            </tr>
            <tr id="tr_accident_process_edit${status.index}" style="display: none;">
                <td>
                    <input type="hidden" id="ap_serial_no${status.index}" value="${item.serialNo}">
                    <input type="text" id="ap_control_date${status.index}" class="calendar" value="${item.controlDate}" style="width: 80%;" maxlength="10"/>
                </td>
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
                    <a href="#noloc" onclick="fnAccidentProcessSave('${status.index}', 'U')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                    <a href="#noloc" onclick="fnAccidentProcessClose('${status.index}')"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                </td>
            </tr>
        </c:forEach>
        <tr id="tr_accident_process_add" style="display: none;">
            <td>
                <input type="text" id="ap_control_date" class="calendar" value="" style="width: 80%;" maxlength="10"/>
            </td>
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
                <a href="#noloc" onclick="fnAccidentProcessSave('', 'C');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                <a href="#noloc" onclick="fnAccidentProcessCancel('');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
            </td>
        </tr>
    </table>
</div>