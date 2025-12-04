<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
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

			$.ajaxSetup({cache:false});

			if('${mbrAuthVo_Session.user_no}' == null){
				window.opener.location.assign("./logout");
				window.self.close();
			}
		});//ready
	</script>
</head>

<body>
	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 게시판 상세 팝업</span></b></font>
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
								<li class="on"><a href="#">게시판 상세 팝업</a></li>
							</ul>
						</div><!-- //guestTap -->

						<div class="guestcnt4" style="display:block;">
							<form id="uploadForm" id="uploadForm" name="uploadForm" action="./freeBoardWrite" method="post" enctype="multipart/form-data">
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
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">제 목</td>
											<td colspan="4">${boardDetail.title}</td>
											<td><a href="javascript:print();"><img src="./resources/ls_img/ls_board/icon_print.gif" /></a></td>
										</tr>
										<tr>
											<td bgcolor="#e7ecf1" style="text-align:center;">내 용</td>
											<td colspan="5">${boardDetail.contents}</td>
										</tr>
									</table>
								</div>
							</form>
							<p style="text-align:center;margin-top:10px;">
								<a href="JavaScript:window.close()"><img src="./resources/ls_img/ls_board/icon_close.gif" /></a>
							</p>
						</div>

					</div><!-- //guest -->
				</div><!-- //bot1-3 -->
			</div>
		</div>
	</div>
	<!--//center -->

	<!-- footer -->
	<c:import url="../top_main/top_pop_footer.jsp"></c:import>
	<!-- //footer -->

	<script language="JavaScript">
		window.print();
	</script>

</body>
