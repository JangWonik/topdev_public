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
    <link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>	
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
    <c:import url="../top_lecture/lecture_menu.jsp"></c:import>
    <!-- contents -->
    <div id="container">
        <div class="contetns">
           <!-- centercnt_top -->
			<div class="center_cnt_1300">				
				<!-- 탭메뉴 시작 -->				
				<div class="center_cnt_vacation" style="margin:0 auto;">
                    <div class="guest">
                        <div class="guestTap">
                            <ul>
                                <li class="on"><a href="#noloc">TOP Edu 교육자료실</a></li>
                            </ul>
                        </div>
                        <div class="guestcnt4" style="display:block;">                            
                            <form id="newFrm" name="newFrm" method="post" action="./lectureBoardDataWrite" enctype="multipart/form-data">
                            <input type="hidden" id="boardType" name="boardType" value="1"/>
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
								<a href="./brdLectureBoardList?titleSearch=${searchVO.titleSearch}&boardType=${searchVO.boardType}" class="btn-vacation-aprv" style="background:#F6CED8;">취소</a>								
							</p>
                        </div>
                    </div>

                </div>                                
            </div>
        </div>
    </div>    
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
