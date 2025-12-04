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
			color:#696969  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
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
					$.post("./helpDeskBoardDelete",
							{	boardNo:$("#board_no").val()
							},
							function(data,status){
								if(status == "success"){
									if(data.length == 0){alert(data);
										alert("게시글 삭제를 실패 하였습니다.");
									}else{
										alert("게시글 삭제를 성공 하였습니다.");
										window.location.assign("./helpDeskBoardList?boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&reqPgNo=${reqPgNo}");
									}//if(data.length == 0){
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							}
					);//post
				}

			});//$("#boardDeleteBtn").click

			$("#acceptBtn").click(function(){

				var tmp = window.confirm("게시글을 접수 하시겠습니까?");
				if(tmp == false){
					return;
				}else if(tmp == true){
					$.post("./helpDeskAccept",
							{	board_no:$("#board_no").val()
								,accept_classify:$("#acceptGubun").val()
							},
							function(data,status){
								if(status == "success"){
									if(data.length == 0){alert(data);
										alert("게시글 접수를 실패 하였습니다.");
									}else{
										alert("게시글 접수를 성공 하였습니다.");
										window.location.assign("./helpDeskBoardList?boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&reqPgNo=${reqPgNo}");
									}//if(data.length == 0){
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							}
					);//post
				}

			});//$("#acceptBtn").click

			$("#solveBtn").click(function(){
				
				var solveMemoData = $("#solveMemo").val();				
				
				if( solveMemoData == "" ){
					alert("조치내용을 입력하세요.");					
				 	return;
				}

				var tmp = window.confirm("게시글을 종결 하시겠습니까?");
				if(tmp == false){
					return;
				}else if(tmp == true){
					$.post("./helpDeskSolve",
							{	board_no:$("#board_no").val(),
								title:$("#title").val(),
								solve_memo:solveMemoData
							},
							function(data,status){
								if(status == "success"){
									if(data.length == 0){alert(data);
										alert("게시글 종결을 실패 하였습니다.");
									}else{
										alert("게시글 종결을 성공 하였습니다.");
										window.location.assign("./helpDeskBoardList?boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&reqPgNo=${reqPgNo}");
									}//if(data.length == 0){
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							}
					);//post
				}

			});//$("#solveBtn").click
			
			//전산권한 결재요청 시작
			$("#authBtn").click(function(){
				
				var authMemoData = $("#authMemo").val();
				
				if( authMemoData == "" ){
					alert("요청내용을 입력하세요.");					
				 	return;
				}
				
				var authType = $(":input:radio[name=authType]:checked").val();
				
				if( typeof authType == "undefined" ){
					alert("결재자를 선택해주세요.");
					$("#authType_1").focus();
					return;
				}				

				var tmp = window.confirm("결재요청 하시겠습니까?");
				if(tmp == false){
					return;
				}else if(tmp == true){
					$.post("./helpDeskAuth",
							{	board_no:$("#board_no").val()
								,auth_memo:authMemoData
								,auth_type:authType
								,solve_state:$("#solve_state").val()
							},
							function(data,status){
								if(status == "success"){
									if(data.length == 0){alert(data);
										alert("결재요청을 실패 하였습니다.");
									}else{
										alert("결재요청하였습니다.");
										window.location.assign("./helpDeskBoardList?boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&reqPgNo=${reqPgNo}");
									}//if(data.length == 0){
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							}
					);//post
				}

			});//$("#solveBtn").click
			
			$("#btn-aprv-detail").click( function(){				
				if(confirm("승인하시겠습니까?")){
					$.post("./helpDeskApproval",
							{	board_no:$("#board_no").val()
								,approval_comment:$("#approvalComment").val()
								//,approval_type:"approval"								
								,solve_state:"4"			//결재완료
							},
							function(data,status){
								if(status == "success"){
									if(data.length == 0){																			
										alert("결재를 실패 하였습니다.");
									}else{
										alert("결재하였습니다.");
										window.location.assign("./helpDeskBoardList?boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&reqPgNo=${reqPgNo}");
									}//if(data.length == 0){
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							}
					);//post
				}						
			});
			
			$("#btn-reject-detail").click( function(){
				if(confirm("반려하시겠습니까?")){
					
					if( $("#approvalComment").val() == "" ){
						alert("반려의 경우 결재의견이 입력되어야 합니다.");
						$("#approvalComment").focus();
						return;
					}
				
					$.post("./helpDeskApproval",
							{	board_no:$("#board_no").val()
								,approval_comment:$("#approvalComment").val()															
								,solve_state:"5"			//반려
							},
							function(data,status){
								if(status == "success"){
									if(data.length == 0){																			
										alert("결재(반려) 를 실패 하였습니다.");
									}else{
										alert("결재(반려)를 하였습니다.");
										window.location.assign("./helpDeskBoardList?boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&reqPgNo=${reqPgNo}");
									}//if(data.length == 0){
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							}
					);//post
				}
						
			});
			
			$("#btn-cancel-detail").click( function(){
				if(confirm("결재(반려)를 취소 하시겠습니까?\n취소 후 결재대기상태로 변경됩니다.")){
					$.post("./helpDeskApproval",
							{	board_no:$("#board_no").val()								
								//,approval_type:"approval"								
								,solve_state:"3"			//결재완료
							},
							function(data,status){
								if(status == "success"){
									if(data.length == 0){																			
										alert("결재(반려) 취소를 실패 하였습니다.");
									}else{
										alert("결재(반려)를 취소하였습니다.");
										window.location.assign("./helpDeskBoardList?boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&reqPgNo=${reqPgNo}");
									}//if(data.length == 0){
								}else{
									alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
								}
							}
					);//post
				}
						
			});

		});//ready

		function boardPrintPop(boardNo){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('./helpDeskBoardPrint?boardNo='+boardNo,'top','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
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
								<li class="on"><a href="#">Help Desk</a></li>
							</ul>
						</div>
						<div class="guestcnt4" style="display:block;">
							<input type="hidden" id="board_no" name="board_no" value="${boardDetail.board_no}">
							<input type="hidden" name="user_no" value="${boardDetail.user_no}">
							<input type="hidden" id="title" name="title" value="${boardDetail.title}">
							<div class="tableStyle21">
								<table>
									<tr>
										<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">요청부서</td>
										<td width="15%">${boardDetail.team_name}</td>
										<td width="10%" bgcolor="#e7ecf1" style="text-align:center;">요청자</td>
										<td width="15%">${boardDetail.user_nm}</td>
										<td width="10%" bgcolor="#e7ecf1" style="text-align:center;">요청일</td>
										<td width="15%">${boardDetail.reg_date_fmt}</td>
										<td width="10%" bgcolor="#e7ecf1" style="text-align:center;">조회수</td>
										<td width="10%" style="text-align:center;">${boardDetail.view_cnt}</td>
									</tr>
									<tr>
										<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">제 목</td>
										<td colspan="7">${boardDetail.title}</td>
									</tr>
									<tr>
										<td bgcolor="#e7ecf1" style="text-align:center;">내 용</td>
										<td colspan="7">${boardDetail.contents}</td>
									</tr>
									<tr>
										<td bgcolor="#e7ecf1" style="text-align:center;">첨부 파일</td>
										<td colspan="7">
											<c:forEach items="${boardFileList}" var="boardFileList">
												<p>
<%-- 													<a href="./commonFileDownload?fileName=${boardFileList.encodedFilePathName}"> --%>
<%-- 														<font color="#0000cc" class="hrefLink">${boardFileList.file_name}</font> --%>
<!-- 													</a> -->
													<a href="./brdHelpDeskFileDownload?fileNo=${boardFileList.board_file_no}">
														<font color="#0000cc" class="hrefLink">${boardFileList.file_name}</font>
													</a>
												</p>
											</c:forEach>
										</td>
									</tr>
									<tr>
										<td bgcolor="#e7ecf1" style="text-align:center;">진 행 상 태</td>
										<td colspan="7">
											${boardDetail.solve_state_nm}
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											*** 주의!!! 진행 상태가 요청인 경우에만 요청 게시글에 대한 수정 / 삭제가 가능합니다.
										</td>
									</tr>
									<c:if test="${boardDetail.solve_state > 0}">
										<tr>
											<td bgcolor="#e7ecf1" style="text-align:center;">접 수 구 분</td>
											<td>${boardDetail.accept_classify_nm}</td>
											<td bgcolor="#e7ecf1" style="text-align:center;">접 수 자</td>
											<td>${boardDetail.accept_user_nm}</td>
											<td bgcolor="#e7ecf1" style="text-align:center;">접 수 일</td>
											<td colspan="3">${boardDetail.accept_date_fmt}</td>
										</tr>
									</c:if>
									<c:if test="${boardDetail.solve_state == 2}">
										<tr>
											<td bgcolor="#e7ecf1" style="text-align:center;">조 치 완 료</td>
											<td>${boardDetail.solve_user_nm}</td>
											<td bgcolor="#e7ecf1" style="text-align:center;">조 치 일</td>
											<td>${boardDetail.solve_date_fmt}</td>
											<td bgcolor="#e7ecf1" style="text-align:center;">조 치 내 용</td>
											<td colspan="3">${boardDetail.solve_memo}</td>
										</tr>
									</c:if>
								</table>
							</div>
							<p style="text-align:center;margin-top:10px;">
								<c:if test="${boardDetail.solve_state eq 0}">
									<c:if test="${mbrVo_Session.user_no eq boardDetail.user_no}">
										<a href="./helpDeskBoardUpdateForm?boardNo=${boardDetail.board_no}&boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&reqPgNo=${reqPgNo}"><img src="./resources/ls_img/ls_board/btn_modify.gif" /></a>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<a href="#"><img src="./resources/ls_img/ls_board/btn_del.gif" id="boardDeleteBtn" /></a>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</c:if>
								</c:if>
								<a href="./helpDeskBoardList?boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&reqPgNo=${reqPgNo}"><img src="./resources/ls_img/ls_board/btn_list.gif" /></a>
							</p>
							<!-- accept -->
							<c:if test="${boardDetail.solve_state eq 0 && mbrVo_Session.user_state == 9}">
								<br />
								<div class="tableStyle21">
									<table>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">접 수 구 분</td>
											<td>
												<select id="acceptGubun" style="width:90%;">
													<option value="1"> [ 인 트 라 넷 ] </option>
													<option value="2"> [ P&nbsp;&nbsp;&nbsp;C ] </option>
													<option value="3"> [ 전 화 ] </option>
													<option value="4"> [ 보 안 ] </option>
													<option value="5"> [ 기 타 ] </option>
													<option value="6"> [ 이 메 일 ] </option>
													<option value="7"> [ 전 산 권 한 ] </option>
													<option value="8"> [ 장 비 신 청 ] </option>
												</select>
											</td>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">접 수 자</td>
											<td>${mbrVo_Session.user_name}</td>
											<td width="10%" style="text-align:center;">
												<input type="button" id="acceptBtn" value=" 접 수 " />
											</td>
										</tr>
									</table>
								</div>
							</c:if>
							<!-- //accept -->
							<!-- solve -->
							<!-- 전산권한신청이 아닌경우만 바로 조치완료 폼을 보여준다. -->
							<c:if test="${( boardDetail.solve_state eq 1 || boardDetail.solve_state eq 4 || boardDetail.solve_state eq 5 ) && mbrVo_Session.user_state == 9}">
								<br />
								<div class="tableStyle21">
									<table>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">조 치 완 료</td>
											<td width="15%">${mbrVo_Session.user_name}</td>
											<td width="10%" bgcolor="#e7ecf1" style="text-align:center;">조 치 내 용</td>
											<td width="50%">
												<textarea id="solveMemo" name="solveMemo" rows="3" cols="70" style="padding:5px;">요청하신 사항이 정상적으로 처리되었습니다.</textarea>
												<!-- <script>
													CKEDITOR.replace('solveMemo',{height:60,removePlugins:'toolbar,elementspath,resize'});
												</script> -->
											</td>
											<td width="10%" style="text-align:center;">
												<input type="button" id="solveBtn" value="완 료 " style="width:60px;height:40px;"/>
											</td>
										</tr>
									</table>
								</div>
							</c:if>
							<!-- 전산권한신청이면서 접수된 상태인 경우 결재요청폼 시작 -->
							<c:if test="${boardDetail.solve_state eq 1 && mbrVo_Session.user_state == 9 && boardDetail.accept_classify eq 7}">
								<input type="hidden" id="solve_state" name="solve_state" value="3"/>
								<br />
								<div class="tableStyle21">
									<table>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">결 재 요 청</td>
											<td width="35%">${mbrVo_Session.user_name}</td>											
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">결 재 자</td>
											<td width="35%">
												<input type="radio" name="authType" id="authType_1" value="1" /> 물보험본부 &nbsp;&nbsp; 
												<input type="radio" name="authType" id="authType_4" value="4" /> 인보험본부											
											</td>
										</tr>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">요 청 내 용</td>
											<td width="50%" colspan="2">
												<textarea id="authMemo" name="authMemo" rows="3" cols="70" style="padding:5px;"></textarea>
												<!-- <script>
													CKEDITOR.replace('authMemo',{height:60,width:700,removePlugins:'toolbar,elementspath,resize'});
												</script> -->
											</td>
											<td width="10%" style="text-align:right;">
												<input type="button" id="authBtn" value="결재요청" style="width:80px;height:60px;"/>
											</td>
										</tr>
									</table>
								</div>
							</c:if>
							<!-- 전산권한신청이면서 접수된 상태인 경우 결재요청폼 끝 -->
							
							<!-- 전산권한신청이면서 결재대기 상태인 경우 결재폼 시작 -->							
							<c:if test="${boardDetail.solve_state eq 3 && boardDetail.accept_classify eq 7 && (auth_approval eq boardDetail.auth_type || auth_approval eq 5)}">
							<br />
								<div class="tableStyle21">
									<table>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">결재 요청자</td>
											<td width="85%">${boardDetail.drafter_nm}</td>											
										</tr>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">요 청 내 용</td>
											<td width="85%">${boardDetail.auth_memo}</td>											
										</tr>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">결 재 의 견</td>
											<td width="85%">
												<input type="text" id="approvalComment" name="approvalComment" size="100"/>
												&nbsp;&nbsp;<a class="btn-vacation-aprv" id="btn-aprv-detail" style="background: rgb(87, 146, 194); color: rgb(255, 255, 255) !important;" href="#noloc">승인</a>
												&nbsp;<a class="btn-vacation-aprv" id="btn-reject-detail" style="background: rgb(194, 87, 87); color: rgb(255, 255, 255) !important;" href="#noloc">반려</a>
											</td>											
										</tr>
									</table>
								</div>						
							</c:if>
							<!-- 전산권한신청이면서 결재대기 상태인 경우 결재폼 끝 -->
							
							<!-- 전산권한신청이면서 결재완료 또는 반려 상태인 경우 결재취소할수 있는 폼 시작 -->
							<c:if test="${(boardDetail.solve_state eq 4 || boardDetail.solve_state eq 5) && boardDetail.accept_classify eq 7 && (auth_approval eq boardDetail.auth_type || auth_approval eq 5)}">
								<br />
								<div class="tableStyle21">
									<table>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">결 재 요 청 자</td>
											<td>${boardDetail.drafter_nm}</td>
										</tr>
										<tr>																						
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">요 청 내 용</td>
											<td>${boardDetail.auth_memo}</td>
										</tr>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">결 재 자</td>
											<td>${boardDetail.approval_nm}</td>																						
										</tr>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">결 재 시 간</td>
											<td>${boardDetail.approval_date_fmt}</td>
										</tr>
										<tr>																						
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">결 재 의 견</td>
											<td>
											<c:choose>
												<c:when test="${empty boardDetail.approval_comment}">결재의견없음</c:when>
												<c:otherwise>${boardDetail.approval_comment}</c:otherwise>
											</c:choose>											
											</td>
										</tr>
										<tr>
											<c:choose>
												<c:when test="${boardDetail.solve_state eq 4}">
													<td colspan="2" style="text-align:center;">
														<a class="btn-vacation-aprv" id="btn-cancel-detail" style="background: rgb(87, 146, 194); color: rgb(255, 255, 255) !important;" href="#noloc">결재취소</a>	
													</td>
												</c:when>
												<c:otherwise>
													<td colspan="2" style="text-align:center;">
														<a class="btn-vacation-aprv" id="btn-cancel-detail" style="background: rgb(194, 87, 87); color: rgb(255, 255, 255) !important;" href="#noloc">반려취소</a>	
													</td>
												</c:otherwise>
											</c:choose>																						
										</tr>										
									</table>
								</div>
							</c:if>
							<!-- 전산권한신청이면서 결재완료 또는 반려 상태인 경우 결재취소할수 있는 폼 끝 -->
							
							<!-- 전산권한신청이면서 결재완료된경우 전산팀 조회용 테이블 시작-->
							<%-- <c:if test="${(boardDetail.solve_state eq 4 || boardDetail.solve_state eq 4 || boardDetail.solve_state eq 5) && boardDetail.accept_classify eq 7 && mbrVo_Session.user_state == 9}"> --%>
							<c:if test="${boardDetail.accept_classify eq 7 && mbrVo_Session.user_state == 9}">
								<br />
								<div class="tableStyle21">
									<table>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">결 재 요 청 자</td>
											<td>${boardDetail.drafter_nm}</td>
										</tr>
										<tr>																						
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">요 청 내 용</td>
											<td>${boardDetail.auth_memo}</td>
										</tr>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">결 재 자</td>
											<td>${boardDetail.approval_nm}</td>																						
										</tr>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">결재(반려) 시간</td>
											<td>${boardDetail.approval_date_fmt}</td>
										</tr>
										<tr>																						
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">결재(반려) 의견</td>
											<td>
											<c:choose>
												<c:when test="${empty boardDetail.approval_comment}">결재(반려)의견없음</c:when>
												<c:otherwise>${boardDetail.approval_comment}</c:otherwise>
											</c:choose>											
											</td>
										</tr>																				
									</table>
								</div>
							</c:if>
							<!-- 전산권한신청이면서 결재완료된경우 전산팀 조회용 테이블 끝-->
							
							<!-- 전산권한신청이면서 결재완료 후 전산팀 처리까지 완료된상태 시작 -->
							<c:if test="${ boardDetail.solve_state eq 2 && boardDetail.accept_classify eq 7 && (auth_approval eq boardDetail.auth_type || auth_approval eq 5)}">
							<br />
								<div class="tableStyle21">
									<table>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">결 재 요 청 자</td>
											<td>${boardDetail.drafter_nm}</td>
										</tr>
										<tr>																						
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">요 청 내 용</td>
											<td>${boardDetail.auth_memo}</td>
										</tr>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">결 재 자</td>
											<td>${boardDetail.approval_nm}</td>																						
										</tr>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">결 재 시 간</td>
											<td>${boardDetail.approval_date_fmt}</td>
										</tr>
										<tr>																						
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">결 재 의 견</td>
											<td>
											<c:choose>
												<c:when test="${empty boardDetail.approval_comment}">결재의견없음</c:when>
												<c:otherwise>${boardDetail.approval_comment}</c:otherwise>
											</c:choose>											
											</td>
										</tr>
										<tr>
											<td width="15%" bgcolor="#e7ecf1" style="text-align:center;">완 료 시 간</td>
											<td>${boardDetail.solve_date_fmt}</td>
										</tr>
									</table>
								</div>
							</c:if>
							<!-- 전산권한신청이면서 결재완료 후 전산팀 처리까지 완료된상태 끝 -->
							
							<!-- //solve -->							
							<br />
							<!-- memo -->
							<input type="hidden" id="targetStr" value="helpDesk" />
							<input type="hidden" id="linkNo" value="${boardDetail.board_no}" />
							<c:import url="../brd_common/board_memo_1.jsp"></c:import>
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
