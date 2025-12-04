<%--
  Created by IntelliJ IDEA.
  User: kohyeonseok
  Date: 2017. 6. 28.
  Time: 오전 9:18
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
    <title>${title_Session}</title>
    <link rel="stylesheet" type="text/css" href="/resources/wm_css/style.css" />
    <script src="/resources/jquery/jquery.min_1_12.js"></script>
    <script src="/resources/wm_js/common.js"></script>
    <script src="/resources/ckeditor/ckeditor.js"></script>


</head>
<body>
<div id="wrapper"><!-- wrapper -->
    <!-- skipnavi --><!-- header -->
    <c:import url="../top_main/top_main_menu.jsp"></c:import>
    <!-- contents -->
    <div id="container">
        <div class="contetns">
            <!-- left_cnt -->
            <c:import url="/top_main_left"></c:import>
            <!-- //left_cnt -->
            <!-- centercnt_top -->
            <div class="center_cnt">
                <!-- centercnt_bot -->
                <div class="centercnt_bot1-2">

                    <div class="guest">
                        <div class="guestTap">
                            <ul>
                                <li class="on"><a href="#noloc">FAQ 글수정</a></li>
                            </ul>
                        </div>
                        <div class="guestcnt4" style="display:block;">
                            <form id="newFrm" name="newFrm" method="post" action="/brd_faq_update" enctype="multipart/form-data">
                            <input type="hidden" id="faq_no" name="faq_no" value="${faqVo.faqNo}"/>
                            <div class="tableStyle2">
                                <table>
                                    <colgroup>
                                        <col width="20%">
                                        <col width="80%">
                                    </colgroup>
                                    <tr>
                                        <th>제목</th>
                                        <td><input type="text" id="title" name="title" value='<c:out value="${faqVo.title}"/>' style="width:98%;" maxlength="100"></td>
                                    </tr>
                                    <tr>
                                        <th>분류</th>
                                        <td style="text-align: left; padding-left: 5px;">
                                            <select id="faq_type" name="faq_type">
                                                <c:forEach  var="item" items="${codeList}" varStatus="status">
                                                    <option value="${item.col_cd}" <c:if test="${faqVo.faqType == item.col_cd}">selected</c:if>>${item.col_val}</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>베스트여부</th>
                                        <td style="text-align: left; padding-left: 5px;">
                                            <select id="best_at" name="best_at">
                                                <option value="N" <c:if test="${faqVo.bestAt == 'N'}">selected</c:if>>아니요</option>
                                                <option value="Y" <c:if test="${faqVo.bestAt == 'Y'}">selected</c:if>>예</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>사용여부</th>
                                        <td style="text-align: left; padding-left: 5px;">
                                            <select id="use_at" name="use_at">
                                                <option value="Y" <c:if test="${faqVo.useAt == 'Y'}">selected</c:if>>예</option>
                                                <option value="N" <c:if test="${faqVo.useAt == 'N'}">selected</c:if>>아니요</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>내용</th>
                                        <td>
                                            <textarea id="contents" name="contents" rows="15" style="width: 98%">${faqVo.contents}</textarea>
                                            <script type="text/javascript">
                                            CKEDITOR.replace('contents', {filebrowserUploadUrl:'./ckeditorUpload?tmpNo=${mbrVo_Session.user_no}'});
                                            </script>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>첨부파일</th>
                                        <td colspan="3" style="text-align: left; padding-left: 5px;">
                                            <c:forEach  var="item" items="${fileList}" varStatus="status">
                                                <p id="p_file${status.index}">
                                                    <a href="/brd_faq_file_down?file_no=${item.fileNo}">${item.orignlFileNm}</a>&nbsp;&nbsp;&nbsp;
                                                    <a href="#noloc" onclick="fnFileDel('${item.fileNo}','${status.index}')">
                                                        <img src="./resources/ls_img/ls_board/btn_s_del.gif"/>
                                                    </a>
                                                </p>

                                            </c:forEach>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th style="vertical-align:top;">
                                            <input type="button" id="btn_add_file" value="첨부파일추가" />
                                        </th>
                                        <td id="addFileFormDiv"></td>
                                    </tr>
                                </table>
                            </div>
                            </form>
                            <p style="text-align:center;margin-top:10px;">
                                <a id="btn_save" href="#noloc"><img src="./resources/ls_img/ls_board/btn_write_ok.gif"/></a>
                                <a href="./brd_faq_list"><img src="./resources/ls_img/ls_board/btn_write_cancel.gif" /></a>
                            </p>
                        </div>
                    </div>

                </div>
                <!-- banner -->
                <c:import url="../top_main/top_main_banner.jsp"></c:import>
                <!-- //banner -->
            </div>
        </div>
    </div>
    <!-- footer -->
    <c:import url="../top_main/top_main_footer.jsp"></c:import>
    <!-- //footer -->
</div>
<script type="text/javascript">
    var fileNo = 1;
    $(document).ready(function () {
        _initButton();
    });

    //버튼 이벤트
    function _initButton() {
        $("#btn_save").on("click", function () {
            fnSave();
        });
        $("#btn_add_file").on("click", function () {
            fnAddFileForm();
        });
    }

    function fnSave() {
        if ($("#title").val() == '') {
            alert("제목을 입력해 주세요.");
            $("#title").focus();
            return;
        }

        var ckeditor = CKEDITOR.instances['contents'];
        if (ckeditor.getData()=="")
        {
            alert("내용을 입력해 주세요.");
            ckeditor.focus();
            return;
        }

//        if ($("#contents").val() == '') {
//            alert("내용을 입력해 주세요.");
//            $("#contents").focus();
//            return;
//        }

        $("#newFrm").submit();
    }

    function fnAddFileForm() {
        $("#addFileFormDiv").append(
                "첨부파일추가 "+fileNo+" : <input type='file' name='upfile"+fileNo+"' style='width:80%;'><br /><br />"
        );
        fileNo = fileNo + 1;
    }


    function fnFileDel(fileNo, idx) {

        if (confirm("첨부파일을 삭제하시겠습니까?")){
            var param = {};
            param.file_no           = fileNo;

            var url = "./brd_faq_file_delete";

            $.ajax({
                type: "POST",
                url: url,
                data: param,
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                dataType: "json",
                timeout: 20000,
                success: function(data){
                    if (data.Authorize == 'T' && data.Result == "success"){
                        alert("첨부파일 삭제를 성공 하였습니다.");
                        $("#p_file" + idx).remove();
                    }else{
                        alert("첨부파일 삭제를 실패 하였습니다.");
                    }
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

    function fnWinClose(){
        window.location.href = "/";
    }
</script>
</body>
</html>
