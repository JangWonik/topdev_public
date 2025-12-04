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
                                <li class="on"><a href="#noloc">FAQ 글쓰기</a></li>
                            </ul>
                        </div>
                        <div class="guestcnt4" style="display:block;">
                            <form id="newFrm" name="newFrm" method="post" action="/brd_faq_insert" enctype="multipart/form-data">
                            <div class="tableStyle2">
                                <table>
                                    <colgroup>
                                        <col width="20%">
                                        <col width="80%">
                                    </colgroup>
                                    <tr>
                                        <th>제목</th>
                                        <td><input type="text" id="title" name="title" value="" style="width:98%;" maxlength="100"></td>
                                    </tr>
                                    <tr>
                                        <th>분류</th>
                                        <td style="text-align: left; padding-left: 5px;">
                                            <select id="faq_type" name="faq_type">
                                                <c:forEach  var="item" items="${codeList}" varStatus="status">
                                                    <option value="${item.col_cd}">${item.col_val}</option>
                                                </c:forEach>
                                                <%--<option value="1">PRM</option>--%>
                                                <%--<option value="2">보안</option>--%>
                                                <%--<option value="3">기타</option>--%>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>베스트여부</th>
                                        <td style="text-align: left; padding-left: 5px;">
                                            <select id="best_at" name="best_at">
                                                <option value="N">아니요</option>
                                                <option value="Y">예</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>사용여부</th>
                                        <td style="text-align: left; padding-left: 5px;">
                                            <select id="use_at" name="use_at">
                                                <option value="Y">예</option>
                                                <option value="N">아니요</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>내용</th>
                                        <td>
                                            <textarea id="contents" name="contents" rows="15" style="width: 98%"></textarea>
                                            <script type="text/javascript">
                                                CKEDITOR.replace('contents', {filebrowserUploadUrl:'./ckeditorUpload?tmpNo=${mbrVo_Session.user_no}'});
                                            </script>
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
</script>

</body>
</html>
