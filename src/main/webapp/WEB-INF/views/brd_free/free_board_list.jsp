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
	</style>
	<script>
		$(document).ready(function(){
			
			$.ajaxSetup({cache:false});
			
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
				window.location.assign("./logout");
			}

			if('${boardFreeWriteSuccess}' == '1'){
				alert("게시글 저장에 성공 하였습니다.");
			}

			if('${boardFreeUpdateSuccess}' == '1'){
				alert("게시글 수정에 성공 하였습니다.");
			}

			$("#boardSrcBtn").click(function(){
				if($(":radio[name=boardSrcType]:checked").val() != '1'
					&& $(":radio[name=boardSrcType]:checked").val() != '2'
					&& $(":radio[name=boardSrcType]:checked").val() != '3'){
						alert("검색 대상을 입력해주세요.");
						return;
				}				
				//boardSrcForm.submit();
				getFreeBoardList();
			});
			
			getFreeBoardList();
			
		});//ready
		
		//목록 불러오기
		function getFreeBoardList(){			
			
			var formData = $("#boardSrcForm").serialize();
			
			$.ajax({
				type : "post",				
				url : "freeTopBoardListAjax",
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
			getFreeBoardList();
		}
		
		//다중첨부파일 다운로드
		function doViewModal( p_bkey ){
			
			var url = "./brdFreeBoardDetailModal";
				
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
							<!-- 검색창시작 -->
							<div class="tableStyle2" style="padding-bottom:10px;border-top:0px;">
								<form method="get" name="boardSrcForm" id="boardSrcForm" action="./freeBoardList">
								<table>																					
									<tr>
										<td style="text-align:left;padding-left:25px;border-right:hidden;height:30px;background:#F8FBEF;width:70%;">											
												<input type="radio" name="boardSrcType" value="1"
													<c:if test="${searchVO.boardSrcType == ''}">checked</c:if>
													<c:if test="${searchVO.boardSrcType == '1'}">checked</c:if> />&nbsp;제목&nbsp;
												<input type="radio" name="boardSrcType" value="2"
													<c:if test="${searchVO.boardSrcType == '2'}">checked</c:if> />&nbsp;제목+내용&nbsp;
												<input type="radio" name="boardSrcType" value="3"
													<c:if test="${searchVO.boardSrcType == '3'}">checked</c:if> />&nbsp;이름&nbsp;
												<input type="text" id="boardSrcWord" name="boardSrcWord" value="${searchVO.boardSrcWord}" size="30" onchange="changeSqlRemoveText(this);" />&nbsp;																							
												<input type="hidden" id="reqPgNo" name="reqPgNo" value="${searchVO.reqPgNo}"/>												
												<a class="btn-vacation-aprv" id="boardSrcBtn" href="#noloc">검색</a>																							
										</td>
										<td style="text-align:right;padding-right:5px;background:#F8FBEF;">
											<a href="./freeBoardWriteForm" class="btn-vacation-aprv" id="boardSrcAddBtn" style="background:#CEE3F6;">등록</a>
										</td>
									</tr>
								</table>
								</form>													
							</div>							
							<!-- 검색창끝 -->
							<!-- 게시글 목록 시작 -->
							<div class="tableStyle2">
								<table>									
									<tr>
										<th width="9%">번호</th>
										<th width="50%">제목</th>
										<th width="5%">첨부</th>
										<th width="15%">작성자</th>
										<th width="15%">작성일</th>
										<th width="8%">댓글</th>
										<th width="8%">조회</th>
									</tr>							
								</table>
							</div>
							<div id="boardBody"></div>
							<!-- 게시글 목록 끝 -->							
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
<div id="board-detail-dialog" title="첨부자료 다운로드" style="font-size: 15px;display:none;" align="center"></div>
</body>
</html>
