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
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_11}' == 0){
				window.location.assign("./logout");
			}

			if('${boardUpdateFailFlag}' != null && '${boardUpdateFailFlag}' != ''){
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
					$.post("./noticePtnr1BoardFileDelete",
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
								<li class="on"><a href="#">보험사공지(1종)</a></li>
							</ul>
						</div>
						<div class="guestcnt4" style="display:block;">
							<form id="uploadForm" name="uploadForm" action="./noticePtnr1BoardUpdate" method="post" enctype="multipart/form-data">
								<input type="hidden" id="board_no" name="board_no" value="${boardDetail.board_no}">
								<input type="hidden" name="user_no" value="${boardDetail.user_no}">
								<input type="hidden" name="user_nm" value="${boardDetail.user_nm}">
								<input type="hidden" name="ptnr_id" value="${boardDetail.ptnr_id}">
								<input type="hidden" name="ptnr_name" value="${boardDetail.ptnr_name}">
								<input type="hidden" name="reg_date" value="${boardDetail.reg_date}">
								<input type="hidden" name="reg_date_fmt" value="${boardDetail.reg_date_fmt}">
								<input type="hidden" name="view_cnt" value="${boardDetail.view_cnt}">
								<input type="hidden" name="boardSrcType" value="${searchVO.boardSrcType}">
								<input type="hidden" name="boardSrcWord" value="${searchVO.boardSrcWord}">
								<input type="hidden" name="reqPgNo" value="${reqPgNo}">
								<div class="tableStyle21">
									<table>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">작성자</td>
											<td width="25%">${boardDetail.user_nm}</td>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">작성일</td>
											<td width="25%">${boardDetail.reg_date_fmt}</td>
											<td width="10%" bgcolor="#e7ecf1" style="text-align:center;">조회수</td>
											<td width="10%" style="text-align:center;">${boardDetail.view_cnt}</td>
										</tr>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">보 험 사</td>
											<td colspan="5" style="text-align:left;padding-left:7px;">
												${boardDetail.ptnr_name}
											</td>
										</tr>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">제 목</td>
											<td colspan="5"><input type="text" id="title" name="title" value="${boardDetail.title}" style="width:100%;"></td>
										</tr>
										<tr>
											<td bgcolor="#e7ecf1" style="text-align:center;">내 용</td>
											<td colspan="5">
												<textarea id="contents" name="contents" rows="15" cols="130">${boardDetail.contents}</textarea>
												<script>
													CKEDITOR.replace('contents', {filebrowserUploadUrl:'./ckeditorUpload?tmpNo=${mbrVo_Session.user_no}'});
												</script>
											</td>
										</tr>
										<tr>
											<td bgcolor="#e7ecf1" style="text-align:center;">첨부 파일</td>
											<td colspan="5">
												<c:forEach items="${boardFileList}" var="boardFileList" varStatus="status">
													<p id="fileP${status.index}">
														<a href="./commonFileDownload?fileName=${boardFileList.file_path}${boardFileList.file_name}">
															<font color="#0000cc" class="hrefLink">${boardFileList.file_name}</font>
														</a>
														<a href="#">
															<input type="hidden" id="filePath${status.index}" value="${boardFileList.file_path}" />
															<input type="hidden" id="fileName${status.index}" value="${boardFileList.file_name}" />
															<input type="hidden" id="fileNo${status.index}" value="${boardFileList.board_file_no}" />
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
							<p style="text-align:center;margin-top:10px;">
								<a href="#"><img src="./resources/ls_img/ls_board/btn_write_ok.gif" id="uploadFormSendBtn" /></a>
								<a href="./noticePtnr1BoardDetail?insu=${boardDetail.ptnr_id}&boardNo=${boardDetail.board_no}&boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&reqPgNo=${reqPgNo}"><img src="./resources/ls_img/ls_board/btn_write_cancel.gif" /></a>
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
