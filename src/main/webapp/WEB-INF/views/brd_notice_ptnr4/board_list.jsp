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
	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_12}' == 0){
				window.location.assign("./logout");
			}

			if('${boardWriteSuccess}' == '1'){
				alert("게시글 저장에 성공 하였습니다.");
			}

			if('${boardUpdateSuccess}' == '1'){
				alert("게시글 수정에 성공 하였습니다.");
			}

		});//ready

		$(document).ready(function(){

			$.ajaxSetup({cache:false});

			$("#boardSrcBtn").click(function(){
				if($(":radio[name=boardSrcType]:checked").val() != '1'
					&& $(":radio[name=boardSrcType]:checked").val() != '2'
					&& $(":radio[name=boardSrcType]:checked").val() != '3'){
						alert("검색 대상을 입력해주세요.");
						return;
				}
				if($("#boardSrcWord").val().trim() == ''){
					alert("검색어를 입력해주세요.");
					$("#boardSrcWord").focus();
					return;
				}
				boardSrcForm.submit();
			});

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
								<li class="on"><a href="#">보험사공지(4종)</a></li>
							</ul>
						</div>
						<div class="guestcnt4" style="display:block;">
							<div class="tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="10%">번호</th>
											<th>${insuNm} 공지(4종) 제목</th>
											<th width="5%">첨부</th>
											<th width="15%">작성자</th>
											<th width="15%">작성일</th>
											<th width="10%">조회</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${boardList}" var="boardList">
											<tr>
													<!--번호-->
													<td>${boardList.board_no}</td>
													<!--제목-->
													<td style="text-align:left;padding-left:7px;">
														<a href="./noticePtnr4BoardDetail?boardNo=${boardList.board_no}&insu=${searchVO.insu}&boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&reqPgNo=${reqPgNoInt1}">
															${boardList.title}
														</a>
													</td>
													<!--첨부-->
													<td>
														<c:if test="${boardList.file_cnt > 0}">
															<img alt="" src="./resources/ls_img/ls_board/icon_disket.gif">
														</c:if>
													</td>
													<!--작성자-->
													<td>${boardList.user_nm}</td>
													<!--작성일-->
													<td>${boardList.reg_date_fmt}</td>
													<!--조회-->
													<td>${boardList.view_cnt}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<table border="0" style="margin-top:7px;">
								<tr>
									<td width="50%">
										<form method="get" name="boardSrcForm" action="./noticePtnr4BoardList">
											<input type="radio" name="boardSrcType" value="1"
												<c:if test="${searchVO.boardSrcType == ''}">checked</c:if>
												<c:if test="${searchVO.boardSrcType == '1'}">checked</c:if> />제목&nbsp;
											<input type="radio" name="boardSrcType" value="2"
												<c:if test="${searchVO.boardSrcType == '2'}">checked</c:if> />제목+내용&nbsp;
											<input type="radio" name="boardSrcType" value="3"
												<c:if test="${searchVO.boardSrcType == '3'}">checked</c:if> />이름&nbsp;
											<input type="text" id="boardSrcWord" name="boardSrcWord" value="${searchVO.boardSrcWord}" size="30" onchange="changeSqlRemoveText(this);" />&nbsp;
											<img src="./resources/ls_img/ls_board/btn_src.gif" id="boardSrcBtn" name="boardSrcBtn" />&nbsp;
											<a href="./noticePtnr4BoardList?insu=${searchVO.insu}"><img src="./resources/ls_img/ls_board/btn_src_cancel.gif" /></a>
											<input type="hidden" id="insu" name="insu" value="${searchVO.insu}" />
											<input type="hidden" id="reqPgNo" name="reqPgNo" />
										</form>
									</td>
									<td align="center">
										<!-- page -->
										<c:import url="../brd_common/board_page_1.jsp"></c:import>
										<!-- //page -->
									</td>
									<td width="20%">
										<p style="text-align:right;">
											<a href="./noticePtnr4BoardWriteForm?insu=${searchVO.insu}"><img src="./resources/ls_img/ls_board/btn_write.gif" /></a>
											<a href="./noticePtnr4Board"><img src="./resources/ls_img/ls_board/btn_write_cancel.gif" /></a>
										</p>
									</td>
								</tr>
							</table>
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
