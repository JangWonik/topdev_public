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
    <style>
		.btn-vacation-aprv {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:5px;
			-webkit-border-radius:5px;
			border-radius:5px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:12px;
			color:#696969;
			width:40px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
		}
	</style>
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
                                <li class="on"><a href="#noloc">사내규정 · 지침</a></li>
                            </ul>
                        </div>
                        <div class="guestcnt4" style="display:block;">
                            <form id="newFrm" name="newFrm" method="post" action="/brd_guide_insert" enctype="multipart/form-data">
                            <div class="tableStyle2">
                                <table>
                                    <colgroup>
										<col style="width:15%">
										<col style="width:35%">
										<col style="width:15%">
										<col style="width:35%">
									</colgroup>
                                    <tr>
                                        <th>제목</th>
                                        <td colspan="3"><input type="text" id="title" name="title" value="" style="width:98%;" maxlength="100"></td>
                                    </tr>
                                    <tr>
                                        <th>분류</th>
                                        <td style="text-align: left; padding-left: 7px;">
                                            <select id="guide_type" name="guide_type" style="width:95%">
                                                    <option value="0">[ 전  체]</option>
                                                    <option value="1">[ 1 종 ]</option>
                                                    <option value="4">[ 4 종 ]</option>
                                            </select>
                                        </td>                                    
                                        <th>사용여부</th>
                                        <td style="text-align: center;">
                                            <select id="use_at" name="use_at" style="width:95%">
                                                <option value="Y">예</option>
                                                <option value="N">아니요</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>내용</th>
                                        <td colspan="3">
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
                                        <td id="addFileFormDiv" colspan="3"></td>
                                    </tr>
                                </table>
                            </div>
                            </form>                            
                            <p style="text-align:right;margin-top:10px;">
								<a href="#noloc" class="btn-vacation-aprv" id="btn_save" style="background:#CEE3F6;">저장</a>
								<a href="./brdGuideBoardList" class="btn-vacation-aprv" style="background:#F6CED8;">취소</a>								
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
