<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<script src="./resources/ckeditor/ckeditor.js"></script>
	<script>
		var fileNo = 1;

		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
				window.location.assign("./logout");
			}

			if('${boardWriteFailVO}' != null && '${boardWriteFailVO}' != ''){
				alert("게시글 저장에 실패 하였습니다.\n잠시 후 다시 시도해 주시거나,\n시스템 관리자에게 문의해 주세요.");
			}
		});//ready

		$(document).ready(function(){

			$.ajaxSetup({cache:false});

			$("#addFileFormBtn").click(function(){
				$("#addFileFormDiv").append(
						"첨부파일추가 "+fileNo+" : <input type='file' name='upfile"+fileNo+"' style='width:80%;'><br /><br />"
				);
				fileNo = fileNo + 1;
			});//$("#addFileFormBtn").click

			$("#uploadFormSendBtn").click(function(){
				
				if($("#title").val().trim() == "")
				{
					alert("글 제목을 입력하세요.");
					$("#title").focus();
					return;
				}
				var ckeditor = CKEDITOR.instances['contents'];
				if (ckeditor.getData()=="")
				{
					alert("글 내용을 입력하세요.");
					ckeditor.focus();
					return;
				}

				var tmp = window.confirm("게시글을 입력 하시겠습니까?");
				if(tmp == false){
					return;
				}else if(tmp == true){
					$("#uploadForm").submit();
				}

			});//$("#uploadFormSendBtn").click

		});//ready
	</script>	
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

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">

			<!-- left_cnt -->
			<c:import url="../top_main/top_main_left.jsp"></c:import>
			<!-- //left_cnt -->

			<!-- centercnt_top -->
			<div class="center_cnt">

				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">중요공지</a></li>
							</ul>
						</div>
						<div class="guestcnt4" style="display:block;">
							<form id="uploadForm" name="uploadForm" action="./noticeTopBoardWrite" method="post" enctype="multipart/form-data">
								<div class="tableStyle2">
									<table>
										<tr>
											<td width="15%" bgcolor="#e7ecf1">분 류</td>
											<td style="text-align:left;padding-left:7px;">
												<select id="title_classify" name="title_classify" style="width:30%;">
													<c:forEach items="${titleClassifyList}" var = "titleClassifyList">
														<option value="${titleClassifyList.col_cd}"
															<c:if test="${boardWriteFailVO.title_classify == titleClassifyList.col_cd}">selected</c:if> > ${titleClassifyList.col_val} </option>
													</c:forEach>
												</select>
											</td>
										</tr>
										<tr>
											<td width="15%" bgcolor="#e7ecf1">제 목</td>
											<td><input type="text" id="title" name="title" value="${boardWriteFailVO.title}" style="width:98%;"></td>
										</tr>
										<tr>
											<td bgcolor="#e7ecf1">내 용</td>
											<td>
												<textarea id="contents" name="contents" rows="15" cols="130">${boardWriteFailVO.contents}</textarea>
												<script>
													CKEDITOR.replace('contents', {filebrowserUploadUrl:'./ckeditorUpload?tmpNo=${mbrVo_Session.user_no}'});
												</script>
											</td>
										</tr>
										<tr>
											<td bgcolor="#e7ecf1" style="vertical-align:top;">
												<input type="button" id="addFileFormBtn" name="addFileFormBtn" value="첨부파일추가" />
											</td>
											<td id="addFileFormDiv"></td>
										</tr>
									</table>
								</div>
							</form>							
							<p style="text-align:right;margin-top:10px;">
								<a href="#noloc" class="btn-vacation-aprv" id="uploadFormSendBtn" style="background:#CEE3F6;">저장</a>
								<a href="./noticeTopBoardList" class="btn-vacation-aprv" style="background:#F6CED8;">취소</a>								
							</p>
						</div>
					</div>
				</div>
				<!-- //centercnt_bot -->
				<!-- banner -->
				<c:import url="../top_main/top_main_banner.jsp"></c:import>
				<!-- //banner -->
			</div>
			<!-- //center_cnt -->
		</div>
	</div>
	<!-- //contents -->

	<!-- footer -->
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->

</div>
<!-- //wrapper -->

</body>
</html>
