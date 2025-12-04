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
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<script src="./resources/ckeditor/ckeditor.js"></script>
	<script>
		var fileNo = 1;

		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
				window.location.assign("./logout");
			}

			if('${freeBoardUpdateFailFlag}' != null && '${freeBoardUpdateFailFlag}' != ''){
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

				var tmp = window.confirm("게시글을 수정 하시겠습니까?");
				if(tmp == false){
					return;
				}else if(tmp == true){
					$("#uploadForm").submit();
				}

			});//$("#uploadFormSendBtn").click

		});//ready

		$(document).ready(function(){
			$(".hrefLink").mouseover(function(){
				$(this).css("color", "red");
			});
			$(".hrefLink").mouseout(function(){
				$(this).css("color", "#0000cc");
			});

			$(".fileDelBtn").click(function(){

				var tmp = window.confirm("첨부파일을 삭제 하시겠습니까?");
				if(tmp == false){
					return;
				}else if(tmp == true){
					lineNo = $(this).attr("name");
					$.post("./freeBoardFileDelete",
							{	fileNo:$("#fileNo"+lineNo).val()
								,filePath:$("#filePath"+lineNo).val()
								,fileName:$("#fileName"+lineNo).val()
							},
							function(data,status){
								if(status == "success"){
									if(data.length == 0){
										alert("첨부파일 삭제를 실패 하였습니다.");
									}else{
										alert("첨부파일 삭제를 성공 하였습니다.");
										$("#fileP"+lineNo).remove();
									}//if(data.length == 0){
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							}
					);//post
				}

			});//$(".fileDelBtn").click

		});//ready
	</script>
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
								<li class="on"><a href="#">자유게시판</a></li>
							</ul>
						</div>
						<div class="guestcnt4" style="display:block;">
							<form id="uploadForm" name="uploadForm" action="./freeBoardUpdate" method="post" enctype="multipart/form-data">
								<input type="hidden" id="board_no" name="board_no" value="${freeBoardDetail.board_no}">
								<input type="hidden" name="user_no" value="${freeBoardDetail.user_no}">
								<input type="hidden" name="user_nm" value="${freeBoardDetail.user_nm}">
								<input type="hidden" name="reg_date" value="${freeBoardDetail.reg_date}">
								<input type="hidden" name="reg_date_fmt" value="${freeBoardDetail.reg_date_fmt}">
								<input type="hidden" name="view_cnt" value="${freeBoardDetail.view_cnt}">
								<input type="hidden" name="boardSrcType" value="${searchVO.boardSrcType}">
								<input type="hidden" name="boardSrcWord" value="${searchVO.boardSrcWord}">
								<input type="hidden" name="reqPgNo" value="${reqPgNo}">
								<div class="tableStyle21">
									<table>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">작성자</td>
											<td width="25%">${freeBoardDetail.user_nm}</td>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">작성일</td>
											<td width="25%">${freeBoardDetail.reg_date_fmt}</td>
											<td width="10%" bgcolor="#e7ecf1" style="text-align:center;">조회수</td>
											<td width="10%" style="text-align:center;">${freeBoardDetail.view_cnt}</td>
										</tr>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">제 목</td>
											<td colspan="5"><input type="text" id="title" name="title" value="${freeBoardDetail.title}" style="width:100%;"></td>
										</tr>
										<tr>
											<td bgcolor="#e7ecf1" style="text-align:center;">내 용</td>
											<td colspan="5">
												<textarea id="contents" name="contents" rows="15" cols="130">${freeBoardDetail.contents}</textarea>
												<script>
													CKEDITOR.replace('contents', {filebrowserUploadUrl:'./ckeditorUpload?tmpNo=${mbrVo_Session.user_no}'});
												</script>
											</td>
										</tr>
										<tr>
											<td bgcolor="#e7ecf1" style="text-align:center;">첨부 파일</td>
											<td colspan="5">
												<c:forEach items="${boardFreeFileList}" var="boardFreeFileList" varStatus="status">
													<p id="fileP${status.index}">
														<a href="./commonFileDownload?fileName=${boardFreeFileList.file_path}${boardFreeFileList.file_name}">
															<font color="#0000cc" class="hrefLink">${boardFreeFileList.file_name}</font>
														</a>
														<a href="#">
															<input type="hidden" id="filePath${status.index}" value="${boardFreeFileList.file_path}" />
															<input type="hidden" id="fileName${status.index}" value="${boardFreeFileList.file_name}" />
															<input type="hidden" id="fileNo${status.index}" value="${boardFreeFileList.board_file_no}" />
															&nbsp;
															<img src="./resources/ls_img/ls_board/btn_s_del.gif" class="fileDelBtn" name="${status.index}" />
														</a>
													</p>
												</c:forEach>
											</td>
										</tr>
										<tr>
											<td bgcolor="#e7ecf1" style="vertical-align:top;text-align:center;">
												<input type="button" id="addFileFormBtn" name="addFileFormBtn" value="첨부파일추가" />
											</td>
											<td id="addFileFormDiv" colspan="5"></td>
										</tr>
									</table>
								</div>
							</form>							
							<p style="text-align:right;margin-top:10px;">								
								<a href="#noloc" class="btn-vacation-aprv" id="uploadFormSendBtn" style="background:#CEE3F6;">저장</a>
								<a href="./freeBoardDetail?boardNo=${freeBoardDetail.board_no}&boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&reqPgNo=${reqPgNo}" class="btn-vacation-aprv" style="background:#F6CED8;">취소</a>
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
