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
			
			$("#titleSelect").select2();

			$("#boardSrcBtn").click(function(){
				if($(":radio[name=boardSrcType]:checked").val() != '1'
					&& $(":radio[name=boardSrcType]:checked").val() != '2'
					&& $(":radio[name=boardSrcType]:checked").val() != '3'){
						alert("검색 대상을 입력해주세요.");
						return;
				}				
				$("#titleSearch").val($("#titleSelect").val());				
				getNoticeBoardList();				
			});
			
			$("#titleSelect").change(function(){
				$("#boardSrcBtn").click();				
			});//$("#titleSelect").change
			
			//게시판 목록을 불러온다.
			getNoticeBoardList();

		});//ready
		
		
		//목록 불러오기
		function getNoticeBoardList(){			
			
			var param = {};
			param.titleSearch = $("#titleSearch").val();
			param.reqPgNo = $("#reqPgNo").val();			
			param.boardSrcType = $("input[name='boardSrcType']:checked").val();			
			param.boardSrcWord = $("#boardSrcWord").val();
			
			$.ajax({
				type : "post",
				url : "brdLectureBoardListAjax",
				//data : formData,
				data : param,
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
			getNoticeBoardList();
		}
		
		//다중첨부파일 다운로드
		function doViewModal( p_bkey ){		
			
			var url = "./brdGuideBoardDetailModal";
				
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
		
		//글쓰기 페이지로 이동
		function doWrite(){			
			$("#pkeyVal").val( $("#titleSelect").val() );
			$("#goWriteForm").submit();
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
								<li id="tabMenu1" class="on"><a href="#">TOP Edu Q&#38;A</a></li>								
							</ul>
						</div>
						<div class="guestcnt2">
							<!-- 게시판 시작 -->
								<div class="tableStyle2" style="padding-bottom:10px;">
									<table>
										<tr>									
											<th width="40%">교육과정 명</th>									
											<th width="60%"></th>
										</tr>												
										<tr>	
											<td>
												<select id="titleSelect" name="titleSelect" style="width:90%;">
													<option value="0">- 전체 -</option>
													<c:forEach items="${qnaLectureList}" var = "titleVo">														
														<option value="${titleVo.pkey}"
															<c:if test="${searchVO.titleSearch == titleVo.pkey}">selected</c:if> > ${titleVo.p_title}</option>
													</c:forEach>
												</select>
											</td>
											<td style="text-align:right;padding-right:5px;">
												<form method="get" name="boardSrcForm" id="boardSrcForm">
													<input type="radio" name="boardSrcType" value="1"
														<c:if test="${searchVO.boardSrcType == ''}">checked</c:if>
														<c:if test="${searchVO.boardSrcType == '1'}">checked</c:if> />&nbsp;제목&nbsp;
													<input type="radio" name="boardSrcType" value="2"
														<c:if test="${searchVO.boardSrcType == '2'}">checked</c:if> />&nbsp;제목+내용&nbsp;
													<input type="radio" name="boardSrcType" value="3"
														<c:if test="${searchVO.boardSrcType == '3'}">checked</c:if> />&nbsp;이름&nbsp;
													<input type="text" id="boardSrcWord" name="boardSrcWord" value="${searchVO.boardSrcWord}" size="30" onchange="changeSqlRemoveText(this);" />&nbsp;																							
													<input type="hidden" id="reqPgNo" name="reqPgNo" value="${searchVO.reqPgNo}"/>
													<input type="hidden" id="titleSearch" name="titleSearch" value="${searchVO.titleSearch}" />													
													&nbsp;<a class="btn-vacation-aprv" id="boardSrcBtn" href="#noloc">검색</a>
													<c:if test="${mbrVo_Session.user_state == 9 || mbrAuthVo_Session.mbr_pms_26 == 1}">
													&nbsp;<a href="javascript:doWrite();" class="btn-vacation-aprv" id="boardSrcAddBtn" style="background:#CEE3F6;">등록</a>
													</c:if>
												</form>							
											</td>
										</tr>
									</table>						
								</div>
								<!-- 검색창 끝 -->						
								<div class="tableStyle2">
									<table>									
										<tr>
											<th width="5%">번호</th>
											<th width="24%">교육과정명</th>
											<th width="40%">제목</th>
											<th width="5%">첨부</th>
											<th width="10%">작성자</th>
											<th width="10%">작성일</th>
											<th width="8%">답변</th>
											<th width="8%">조회</th>
										</tr>							
									</table>
								</div>
								<div id="boardBody"></div>						
							<!-- 게시판 끝 -->	
						</div>
					</div>
				</div>
				<!-- 탭메뉴 끝 -->
			</div>
		</div>
	</div>
</div>
<form id="goWriteForm" name="goWriteForm" method="post" action="brd_lecture_write">
<input type="hidden" id="pkeyVal" name="pkeyVal"/>
</form>
</body>
</html>