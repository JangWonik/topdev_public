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
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script>
		$(document).ready(function(){			

			$.ajaxSetup({cache:false});
			
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
				window.location.assign("./logout");
			}

			if('${boardWriteSuccess}' == '1'){
				alert("게시글 저장에 성공 하였습니다.");
			}

			if('${boardUpdateSuccess}' == '1'){
				alert("게시글 수정에 성공 하였습니다.");
			}
			
			$("#cateSelect").select2();

			$("#boardSrcBtn").click(function(){
				if($(":radio[name=boardSrcType]:checked").val() != '1'
					&& $(":radio[name=boardSrcType]:checked").val() != '2'
					&& $(":radio[name=boardSrcType]:checked").val() != '3'){
						alert("검색 대상을 입력해주세요.");
						return;
				}				
				$("#cateSearch").val($("#cateSelect").val());
				boardSrcForm.submit();
			});
			
			$("#cateSelect").change(function(){
				$("#boardSrcBtn").click();				
			});
			
			//게시판 목록을 불러온다.
			getSupportBoardList();

		});//ready
		
		
		//목록 불러오기
		function getSupportBoardList(){
			
			var formData = $("#boardSrcForm").serialize();
			
			$.ajax({
				type : "post",
				//url : "noticeTopBoardListAjax",
				url : "supportTopBoardListAjax",
				data : formData,
				success : function(result){			
					//날짜수정 페이지를 가져온다.				
					$("#boardBody").html(result);	 				
				},
				error: function (request, status, error) {			
					console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
				}
			});
			
		}
		
		//페이징 이동
		function reqPgNoClick(pgNo){			
			boardSrcForm.reqPgNo.value = pgNo;
			getSupportBoardList();
		}
		
		//다중첨부파일 다운로드
		function doViewModal( p_bkey ){			
			
			var url = "./supportTopBoardDetailModal";
				
			var param = {};
			param.board_no  = p_bkey;			
			
			//모달창 불러오기
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){        	
		        	$("#board-detail-dialog").html();
		        	$("#board-detail-dialog").html(data);
					$("#board-detail-dialog").dialog({
						height: 250,
						width: 450,
						closeOnEscape : true,
						draggable : true,
						title: "첨부파일 상세보기",
						modal: true,
						buttons:{						
							"닫기" : function(){
								$(this).dialog("close");
							}
						},
						overlay:{ opacity: 0., background: '#000000'}
					});		
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });
		}

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
			width:50px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
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
				<div class="centercnt_bot1-2">											
					<div class="guest">
						<div style="height: 30px;float:left;font-size:15px;color:#0404B4;font-weight: bold;">
				       		<img width="12" height="12" src="./resources/ls_img/dotte.gif" border="0">&nbsp;
				       		자주 찾는 질문 TOP5
						</div>
						<div class="tableStyle2" style="border-top:0px;">
							<table>
								<tr>
									<th width="10%" style="background:#F7D358;">분류</th>
									<th width="85%" style="background:#F7D358;">제목</th>
									<th width="5%" style="background:#F7D358;">첨부</th>
								</tr>
								<c:forEach items="${bestBoardList}" var="best">
									<tr>										
										<td width="10%" style="background:#F7F8E0;font-weight: bold;">${best.category_id_nm}</td>										
										<td width="85%" style="text-align:left;padding-left:10px;letter-spacing:0px;background:#F7F8E0;font-weight: bold;">
											<div style="width:700px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
											<a href="./supportTopBoardDetail?boardNo=${best.board_no}&boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&cateSearch=${searchVO.cateSearch}&reqPgNo=${reqPgNoInt1}">
												${best.title}							
											</a>
											</div>						
										</td>
										<td width="5%" style="background:#F7F8E0;">
											<c:choose>
												<c:when test="${best.file_cnt eq 1}">
													<a href="./brdSupportTopFileDownload?fileNo=${best.board_file_no}" title="바로다운로드">
														<img src="./resources/ls_img/icon_disket.gif">
													</a>
												</c:when>
												<c:when test="${best.file_cnt > 1}">
													<a href="#" onclick="javascript:doViewModal('${best.board_no}');" title="총 ${best.file_cnt} 개의 첨부파일이 존재합니다.">
														<img src="./resources/ls_img/bt_icon.gif">
													</a>
												</c:when>
											</c:choose>						
										</td>					
									</tr>
								</c:forEach>
							</table>
						</div>
						<!-- 글목록 시작 -->
						<div class="guestcnt4" style="display:block;">
							<div class="tableStyle2" style="padding-bottom:10px;">
							<table>
								<tr>									
									<th width="20%">분류</th>									
									<th width="80%"></th>
								</tr>												
								<tr>	
									<td>
										<select id="cateSelect" name="cateSelect" style="width:90%;">
											<c:forEach items="${categoryList}" var = "titleVo">
												<option value="${titleVo.col_cd}"
													<c:if test="${searchVO.cateSearch == titleVo.col_cd}">selected</c:if> > ${titleVo.col_val} </option>
											</c:forEach>
										</select>
									</td>
									<td style="text-align:right;padding-right:5px;">
										<form method="get" name="boardSrcForm" id="boardSrcForm" action="./supportTopBoardList">
											<input type="radio" name="boardSrcType" value="1"
												<c:if test="${searchVO.boardSrcType == ''}">checked</c:if>
												<c:if test="${searchVO.boardSrcType == '1'}">checked</c:if> />&nbsp;제목&nbsp;
											<input type="radio" name="boardSrcType" value="2"
												<c:if test="${searchVO.boardSrcType == '2'}">checked</c:if> />&nbsp;제목+내용&nbsp;
											<input type="radio" name="boardSrcType" value="3"
												<c:if test="${searchVO.boardSrcType == '3'}">checked</c:if> />&nbsp;이름&nbsp;
											<input type="text" id="boardSrcWord" name="boardSrcWord" value="${searchVO.boardSrcWord}" size="30" onchange="changeSqlRemoveText(this);" />&nbsp;																							
											<input type="hidden" id="reqPgNo" name="reqPgNo" value="${searchVO.reqPgNo}"/>
											<input type="hidden" id="cateSearch" name="cateSearch" value="${searchVO.cateSearch}" />
											&nbsp;<a class="btn-vacation-aprv" id="boardSrcBtn" href="#noloc">검색</a>
											<c:if test="${mbrVo_Session.user_state == 9}">
											&nbsp;<a href="./supportTopBoardWriteForm" class="btn-vacation-aprv" id="boardSrcAddBtn" style="background:#CEE3F6;">등록</a>
											</c:if>
										</form>							
									</td>
								</tr>
							</table>						
						</div>
						<!-- 검색창 끝 -->						
						<div class="tableStyle2" style="border-top:0px;">
							<table>									
								<tr>
									<th width="5%">번호</th>
									<th width="15%">분류</th>
									<th width="75%">제목</th>
									<th width="5%">첨부</th>									
								</tr>							
							</table>
						</div>
						<div id="boardBody"></div>
						</div>
					</div>
				</div>
				<!-- 글목록 끝 -->				
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
<div id="board-detail-dialog" title="첨부자료 다운로드" style="font-size: 15px;display:none;" align="center"></div>
</body>
</html>
