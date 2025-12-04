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
	
	<style>
		.ignoreBrd td{
			border : 1px solid #000 !important;
		}
		
		.buttonMini{
			width:40px;
			height:20px;
		    background-color:#CEE3F6;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 11px;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 1px grey;		    
		}
		
		.buttonMiniPrint{
			width:80px;
			height:20px;
		    background-color:#e1e1e1;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 11px;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 1px grey;		    
		}
	</style>	
	
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

			$("#boardDeleteBtn").click(function(){

				var tmp = window.confirm("게시글을 삭제 하시겠습니까?");
				if(tmp == false){
					return;
				}else if(tmp == true){
					$.post("./lectureBoardDelete",
							{	boardNo:$("#board_no").val()
							},
							function(data,status){
								if(status == "success"){
									if(data.length == 0){alert(data);
										alert("게시글 삭제를 실패 하였습니다.");
									}else{
										alert("게시글 삭제를 성공 하였습니다.");
										window.location.assign("./brdLectureBoardList?boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&titleSearch=${searchVO.titleSearch}&reqPgNo=${reqPgNo}&boardType=${searchVO.boardType}");
									}//if(data.length == 0){
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							}
					);//post
				}

			});//$("#noticeTopBoardDeleteBtn").click

		});//ready

		function boardPrintPop(boardNo){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치			
			window.open('./lectureBoardPrint?boardNo='+boardNo,'top','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
	</script>
</head>

<body>

<!-- wrapper -->
<div id="wrapper">
	<!-- top menu import -->
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
								<c:choose>
									<c:when test="${searchVO.boardType eq 1}">
										<li id="tabMenu1" class="on"><a href="#">TOP Edu 교육자료실</a></li>
									</c:when>
									<c:otherwise>
										<li id="tabMenu1" class="on"><a href="#">TOP Edu Q&#38;A</a></li>		
									</c:otherwise>
								</c:choose>
							</ul>
						</div>
						<div class="guestcnt4" style="display:block;">
							<input type="hidden" id="board_no" name="board_no" value="${boardDetail.board_no}">
							<input type="hidden" id="user_no" name="user_no" value="${boardDetail.user_no}">
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
									<c:if test="${searchVO.boardType ne 1}">
									<tr>
										<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">교육과정 명</td>
										<td colspan="5">																						
											${boardDetail.pkey_nm}
										</td>										
									</tr>
									</c:if>
									<tr>
										<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">제 목</td>
										<td colspan="3">																						
											${boardDetail.title}
										</td>
										<td colspan="2" style="text-align:right;">											
											<a href="javascript:boardPrintPop(${boardDetail.board_no});"><input class="buttonMiniPrint" type="button" value="인쇄하기"></a>
										</td>
									</tr>
									<tr>
										<td bgcolor="#e7ecf1" style="text-align:center;">내 용</td>
										<td colspan="5">
											<span class="ignoreBrd">
												${boardDetail.contents}
											</span>
										</td>
									</tr>
									<tr>
										<td bgcolor="#e7ecf1" style="text-align:center;">첨부 파일</td>
										<td colspan="5">
											<c:forEach items="${boardFileList}" var="boardFileList">
												<p>
													<a href="./lectureTopFileDownload?fileNo=${boardFileList.board_file_no}">
														<font color="#0000cc" class="hrefLink">${boardFileList.file_name}</font>
													</a>
												</p>
											</c:forEach>
										</td>
									</tr>
								</table>
							</div>
							<p style="text-align:right;margin-top:10px;">
								<c:if test="${mbrVo_Session.user_no eq boardDetail.user_no or mbrVo_Session.user_state eq '9' or mbrVo_Session.user_no eq '215'}">																		
									<a href="./lectureBoardUpdateForm?boardNo=${boardDetail.board_no}&boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&titleSearch=${searchVO.titleSearch}&reqPgNo=${reqPgNo}&boardType=${searchVO.boardType}" class="btn-vacation-aprv" style="background:#CEE3F6;">수정</a>
									<a href="#noloc" class="btn-vacation-aprv" id="boardDeleteBtn" style="background:#F6CED8;">삭제</a>
								</c:if>								
								<a href="./brdLectureBoardList?boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&titleSearch=${searchVO.titleSearch}&reqPgNo=${reqPgNo}&boardType=${searchVO.boardType}" class="btn-vacation-aprv" id="boardSrcBtn">목록</a>
							</p>
							<br />
							<!-- memo -->
							<input type="hidden" id="targetStr" value="lectureQna" />
							<input type="hidden" id="linkNo" value="${boardDetail.board_no}" />
							<c:import url="../brd_common/board_memo_qna.jsp"></c:import>
							<!-- //memo -->
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
