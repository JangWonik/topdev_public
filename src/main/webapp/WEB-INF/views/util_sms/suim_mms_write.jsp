<%--
  Created by IntelliJ IDEA.
  User: kohyeonseok
  Date: 2017. 8. 10.
  Time: 오후 2:20
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>MMS 발송</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" /><!--2016.01.14.rjh.수정.교체.-->
    <link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
    <script src="./resources/jquery/jquery.min_1_12.js"></script>
    <script src="./resources/cmm/js/common.js"></script>
    <style>
        #tbl_mms tr {height: 30px;}
        #tbl_mms tr:last-child {height: 100px;}
        #tbl_mms td {padding: 5px; text-align: left;}
        #tbl_mms tr:last-child td {vertical-align: top;}

    </style>
</head>
<body>
<c:choose>
    <c:when test="${auth == 0}">
        <script type="text/javascript">
            $(document).ready(function () {
                _initButton();
            });

            //버튼 이벤트
            function _initButton() {
                $("#btn_send").on("click", function () {
                    fnSend();
                });

                $("#btn_cancel").on("click", function () {
                    fnCancel();
                });
            }            
            
            function fnCancel() {
                self.close();
            }
            
            function fnSend() {

                if ($("#call_to").val() == ''){
                    alert("수신자 번호를 입력해 주세요.");
                    $("#call_to").focus();
                    return;
                }

                if ($("#call_from").val() == ''){
                    alert("송신자 번호를 입력해 주세요.");
                    $("#call_from").focus();
                    return;
                }

                if (!$("#call_to").val().isMobile()){
                    alert("수신자 번호 형식이 잘못됐습니다.");
                    $("#call_to").focus();
                    return;
                }

                if (!$("#call_from").val().isMobile()){
                    alert("송신자 번호 형식이 잘못됐습니다.");
                    $("#call_from").focus();
                    return;
                }

                var param = {};
                param.suim_rpt_no  = '${param.suim_rpt_no}';
                param.type         = '${param.type}';
                param.call_to      = $("#call_to").val();
                param.call_from    = $("#call_from").val();

                var url = "./suim_mms_insert";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "json",
                    timeout: 20000,
                    success: function(data){
                        if(data.RSLT_CODE == 0){
                            alert("MMS 문자를 발송했습니다.");
                        }else{
                            alert("MMS 발송에 실패했습니다. \n관리자에게 문의 바랍니다.");
                        }
                        self.close();
                    },
                    error: function(xhr, status, error){
                        if(xhr.status == "901"){
                            self.close();
                        }else{
                            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                        }
                    },
                    beforeSend : function(xmlHttpRequest){
                        xmlHttpRequest.setRequestHeader("AJAX", "true");
                    }
                });
            }
            
        </script>
        <input type="hidden" id="suim_rpt_no" value="${param.suim_rpt_no}">
        <input type="hidden" id="type" value="${param.type}">
        <div class="tableStyle2" style="margin: 5px 5px;">
            <table id="tbl_mms" align="center">
                <col width="20%">
                <col width="80%">
                <tr>
                    <th>수신인</th>
                    <td>
                        <c:choose>
                            <c:when test="${param.type == '1'}">보험사 담당자</c:when>
                            <c:when test="${param.type == '2'}">계약자</c:when>
                            <c:when test="${param.type == '3'}">피보험자</c:when>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>수신번호</th>
                    <td>
                        <c:choose>
                            <c:when test="${param.type == '1'}">
                                <input type="text" id="call_to" name="call_to" value="${fn:replace(suimVo.ptnrMbrHp,'-','')}" onkeyup="digitOnly(this);" maxlength="11">
                            </c:when>
                            <c:when test="${param.type == '2'}">
                                <input type="text" id="call_to" name="call_to" value="${fn:replace(suimVo.policyholderTel,'-','')}" onkeyup="digitOnly(this);" maxlength="11">
                            </c:when>
                            <c:when test="${param.type == '3'}">
                                <input type="text" id="call_to" name="call_to" value="${fn:replace(suimVo.beneficiaryTel,'-','')}" onkeyup="digitOnly(this);" maxlength="11">
                            </c:when>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>송신번호</th>
                    <td>
                        <input type="text" id="call_from" name="call_from" value="${fn:replace(memberVo.handphone,'-','')}" onkeyup="digitOnly(this);" maxlength="11">
                    </td>
                </tr>
                <tr>
                    <th>MMS 이미지</th>
                    <td><img src="${mmsImageBase64}" width="220" height="184"></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>${message}</td>
                </tr>
            </table>
            <p align="center" style="margin-top: 10px;">
                <a href="#noloc" id="btn_send"><img src="./resources/ls_img/btn_sms_s.gif" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="#noloc" id="btn_cancel"><img src="./resources/ls_img/report/btn_cancel.gif" border="0"></a>
            </p>
        </div>
        <div id="div_send_list" class="tableStyle2" style="margin: 10px 5px; height: 180px; overflow-y: auto;">
            <table>
                <col width="20%">
                <col width="20%">
                <col width="20%">
                <col width="20%">
                <col width="20%">
                <tr>
                    <th>발송일자</th>
                    <th>발송시간</th>
                    <th>발송구분</th>
                    <th>수신번호</th>
                    <th>발송번호</th>
                </tr>
                <c:forEach var="item" items="${sendList}" varStatus="status">
                    <tr>
                        <td>${item.regDate}</td>
                        <td>${item.regTime}</td>
                        <td>
                            <c:choose>
                                <c:when test="${item.sndngType == '1'}">보험사 담당자</c:when>
                                <c:when test="${item.sndngType == '2'}">계약자</c:when>
                                <c:when test="${item.sndngType == '3'}">피보험자</c:when>
                            </c:choose>
                        </td>
                        <td>${item.recptnMbtlnum}</td>
                        <td>${item.sndngMbtlnum}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </c:when>
    <c:when test="${auth == 1}">
        <script type="text/javascript">
            alert("처리 담당자가 아님니다.");
            self.close();
        </script>
    </c:when>
    <c:when test="${auth == 2}">
        <script type="text/javascript">
            alert("MMS 발송 이미지가 등록되어 있지 않습니다.\nMyMenu > 정보수정 에서 먼저 이미지를 등록해 주세요.");
            self.close();
        </script>
    </c:when>
    <c:otherwise>
        <script type="text/javascript">
            alert("잘못된 경로로 접근중입니다.");
            self.close();
        </script>
    </c:otherwise>
</c:choose>
</body>
</html>
