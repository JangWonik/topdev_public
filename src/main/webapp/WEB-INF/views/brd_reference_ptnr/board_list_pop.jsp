<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
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
			});//$("#boardSrcBtn").click

			$("#ptnrSelect").change(function(){
				$("#ptnrSearch").val($("#ptnrSelect option:selected").val());
				$("#ptnrGubun").val($("#ptnrSelect option:selected").text().indexOf("└"));
				boardSrcForm.submit();
			});//$("#ptnrSelect").change

			$("#titleSelect").change(function(){
				$("#titleSearch").val($("#titleSelect option:selected").val());
				boardSrcForm.submit();
			});//$("#titleSelect").change

			$("#typeSelect").change(function(){
				$("#typeSearch").val($("#typeSelect option:selected").val());
				boardSrcForm.submit();
			});//$("#typeSelect").change

			$("#yearSelect").change(function(){
				$("#yearSearch").val($("#yearSelect option:selected").val());
				boardSrcForm.submit();
			});//$("#yearSelect").change

		});//ready

	</script>
</head>

<body>

	<!-- header -->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 보험사 자료실</span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->

	<!-- center -->
	<div id ="container">
		<div class="contetnsPop">
			<div class="center_cnt">
				<div class="centercnt_bot1-3">
					<div class="guest">

						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">보험사 자료실</a></li>
							</ul>
						</div>
						<div class="guestcnt5" style="display:block;">
							<div class="tableStyle2">
								<table>
									<tr>
										<th>보 험 사</th>
										<th>종 구분</th>
										<th>자 료 종 류</th>
										<th>해 당 연 도</th>
									</tr>
									<tr>
										<td>
											<select id="ptnrSelect" name="ptnrSelect" style="width:90%;">
												<option value="0" selected>전체</option>
												<c:forEach items="${ptnrList}" var = "ptnrVo">
													<option value="${ptnrVo.ptnr_id}"
														<c:if test="${searchVO.ptnrSearch == ptnrVo.ptnr_id}">selected</c:if>
													>
														<c:if test="${ptnrVo.ptnr_level == 1}">&nbsp;└</c:if>
														${ptnrVo.ptnr_nick}
													</option>
												</c:forEach>
											</select>
										</td>
										<td>
											<select id="titleSelect" name="titleSelect" style="width:90%;">
												<c:forEach items="${titleClassifyList}" var = "titleVo">
													<option value="${titleVo.col_cd}"
														<c:if test="${searchVO.titleSearch == titleVo.col_cd}">selected</c:if> > ${titleVo.col_val} </option>
												</c:forEach>
											</select>
										</td>
										<td>
											<select id="typeSelect" name="typeSelect" style="width:90%;">
												<option value="0" selected>전체</option>
												<c:forEach items="${typeList}" var = "typeVo">
													<option value="${typeVo.col_cd}"
														<c:if test="${searchVO.typeSearch == typeVo.col_cd}">selected</c:if> > ${typeVo.col_val} </option>
												</c:forEach>
											</select>
										</td>
										<td>
											<select id="yearSelect" name="yearSelect" style="width:90%;">
												<option value="0" selected>전체</option>
												<c:forEach var="yearVar" begin="2010" end="2020" step="1">
													<option value="${yearVar}"
														<c:if test="${searchVO.yearSearch == yearVar}">selected</c:if> > ${yearVar} 년 </option>
												</c:forEach>
											</select>
										</td>
									</tr>
								</table>
							</div><!-- //tableStyle2 -->
							<br />
							<div class="tableStyle2">
								<table>
									<thead>
										<tr>
											<th width="5%">번호</th>
											<th width="15%">보험사</th>
											<th width="5%">구분</th>
											<th width="15%">종류</th>
											<th width="5%">연도</th>
											<th width="15%">제목</th>
											<th width="5%">첨부</th>
											<th width="15%">작성자</th>
											<th width="15%">작성일</th>
											<th width="5%">조회</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${boardList}" var="boardList">
											<tr>
													<!--번호-->
													<td>${boardList.board_no}</td>
													<!--보험사-->
													<td>${boardList.ptnr_name}</td>
													<!--구분-->
													<td>${boardList.title_classify_nm}</td>
													<!--종류-->
													<td>${boardList.type_classify_nm}</td>
													<!--연도-->
													<td>${boardList.year_classify} 년</td>
													<!--제목-->
													<td style="text-align:left;padding-left:7px;">
														<a href="./referencePtnrBoardDetailPop?boardNo=${boardList.board_no}&boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&reqPgNo=${reqPgNoInt1}&ptnrSearch=${searchVO.ptnrSearch}&ptnrGubun=${searchVO.ptnrGubun}&titleSearch=${searchVO.titleSearch}&typeSearch=${searchVO.typeSearch}&yearSearch=${searchVO.yearSearch}">
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
										<form method="get" name="boardSrcForm" action="./referencePtnrBoardListPop">
											<input type="radio" name="boardSrcType" value="1"
												<c:if test="${searchVO.boardSrcType == ''}">checked</c:if>
												<c:if test="${searchVO.boardSrcType == '1'}">checked</c:if> />제목&nbsp;
											<input type="radio" name="boardSrcType" value="2"
												<c:if test="${searchVO.boardSrcType == '2'}">checked</c:if> />제목+내용&nbsp;
											<input type="radio" name="boardSrcType" value="3"
												<c:if test="${searchVO.boardSrcType == '3'}">checked</c:if> />이름&nbsp;
											<input type="text" id="boardSrcWord" name="boardSrcWord" value="${searchVO.boardSrcWord}" size="30" onchange="changeSqlRemoveText(this);" />&nbsp;
											<img src="./resources/ls_img/ls_board/btn_src.gif" id="boardSrcBtn" name="boardSrcBtn" />&nbsp;
											<a href="./referencePtnrBoardListPop"><img src="./resources/ls_img/ls_board/btn_src_cancel.gif" /></a>
											<input type="hidden" id="reqPgNo" name="reqPgNo" />
											<input type="hidden" id="ptnrSearch" name="ptnrSearch" value="${searchVO.ptnrSearch}" />
											<input type="hidden" id="ptnrGubun" name="ptnrGubun" value="${searchVO.ptnrGubun}" />
											<input type="hidden" id="titleSearch" name="titleSearch" value="${searchVO.titleSearch}" />
											<input type="hidden" id="typeSearch" name="typeSearch" value="${searchVO.typeSearch}" />
											<input type="hidden" id="yearSearch" name="yearSearch" value="${searchVO.yearSearch}" />
										</form>
									</td>
									<td align="center">
										<!-- page -->
										<c:import url="../brd_common/board_page_1.jsp"></c:import>
										<!-- //page -->
									</td>
									<td width="10%">
									</td>
								</tr>
							</table>
						</div>

					</div><!-- //guest -->
				</div><!-- //bot1-3 -->
			</div><!-- //center_cnt -->
		</div><!-- //contetnsPop -->
	</div>
	<!--//center -->

	<!-- footer -->
	<c:import url="../top_main/top_pop_footer.jsp"></c:import>
	<!-- //footer -->

</body>

</html>
