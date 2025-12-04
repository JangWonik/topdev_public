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
		});//ready

		$(document).ready(function(){

			$.ajaxSetup({cache:false});

			$(".hrefLink").mouseover(function(){
				$(this).css("color", "red");
			});
			$(".hrefLink").mouseout(function(){
				$(this).css("color", "#0000cc");
			});

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
						<div class="guestcnt4" style="display:block;">
							<input type="hidden" id="board_no" name="board_no" value="${boardDetail.board_no}">
							<input type="hidden" name="user_no" value="${boardDetail.user_no}">
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
										<td>${boardDetail.ptnr_name}</td>
										<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">1종 / 4종 구분</td>
										<td colspan="3">${boardDetail.title_classify_nm}</td>
									</tr>
									<tr>
										<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">자 료 종 류</td>
										<td>${boardDetail.type_classify_nm}</td>
										<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">해 당 연 도</td>
										<td colspan="3">${boardDetail.year_classify} 년</td>
									</tr>
									<tr>
										<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">제 목</td>
										<td colspan="5">${boardDetail.title}</td>
									</tr>
									<tr>
										<td bgcolor="#e7ecf1" style="text-align:center;">내 용</td>
										<td colspan="5">${boardDetail.contents}</td>
									</tr>
									<tr>
										<td bgcolor="#e7ecf1" style="text-align:center;">첨부 파일</td>
										<td colspan="5">
											<c:forEach items="${boardFileList}" var="boardFileList">
												<p>
													<a href="./commonFileDownload?fileName=${boardFileList.encodedFilePathName}">
														<font color="#0000cc" class="hrefLink">${boardFileList.file_name}</font>
													</a>
												</p>
											</c:forEach>
										</td>
									</tr>
								</table>
							</div>
							<p style="text-align:center;margin-top:10px;">
								<a href="./referencePtnrBoardListPop?boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&reqPgNo=${reqPgNo}&ptnrSearch=${searchVO.ptnrSearch}&ptnrGubun=${searchVO.ptnrGubun}&titleSearch=${searchVO.titleSearch}&typeSearch=${searchVO.typeSearch}&yearSearch=${searchVO.yearSearch}">
									<img src="./resources/ls_img/ls_board/btn_list.gif" />
								</a>
							</p>
							<br />
							<!-- memo -->
							<input type="hidden" id="targetStr" value="referencePtnr" />
							<input type="hidden" id="linkNo" value="${boardDetail.board_no}" />
							<c:import url="../brd_common/board_memo_1.jsp"></c:import>
							<!-- //memo -->
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
