<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		//이벤트 시작
		$(document).ready(function(){			
			//선택박스 초기화
			$("#eventSelect").select2();
			$("#typeSelect").select2();
			
			//선택박스 변경시 자동 검색
			$("#eventSelect").change(function(){
				$("#boardSrcBtn").click();
			});
			
			$("#typeSelect").change(function(){
				$("#boardSrcBtn").click();
			});
			
			//기본 탭 설정
			if( "${searchVO.cateSearch}" == "1" ){
				$("#cate_1").click();				
			}else if( "${searchVO.cateSearch}" == "2" ){
				$("#cate_2").click();
			}else{
				$("#cate_0").click();				
			}
			
			$("#cate_0").click(function(){
				$("#cateSearch").val(0);
				boardSrcForm.reqPgNo.value = 1;
				getRefBoardList();				
			});
			
			$("#cate_1").click(function(){
				$("#cateSearch").val(1);
				boardSrcForm.reqPgNo.value = 1;
				getRefBoardList();
			});
			
			$("#cate_2").click(function(){
				$("#cateSearch").val(2);				
				boardSrcForm.reqPgNo.value = 1;
				getRefBoardList();
			});
			
			$("#boardSrcBtn").click(function(){
				if($(":radio[name=boardSrcType]:checked").val() != '1'
					&& $(":radio[name=boardSrcType]:checked").val() != '2'
					&& $(":radio[name=boardSrcType]:checked").val() != '3'){
						alert("검색 대상을 입력해주세요.");
						return;
				}
				
				$("#eventSearch").val($("#eventSelect").val());
				$("#typeSearch").val($("#typeSelect").val());
				getRefBoardList();
			});//$("#boardSrcBtn").click
						
			//글등록 페이지 이동
			$("#boardSrcAddBtn").click(function(){				
				var cateVal = $("#cateSearch").val();
				
				if( cateVal == '' ){
					$("#cateSearch").val(0);
				}
				$("#eventSearch").val($("#eventSelect").val());
				$("#typeSearch").val($("#typeSelect").val());
				$("#boardSrcForm").attr("action","./refReportBoardWriteForm");
				$("#boardSrcForm").submit();
			});
			
			//게시판 목록을 불러온다.
			getRefBoardList();
		});		
		
		
		//목록 불러오기
		function getRefBoardList(){
			
			var formData = $("#boardSrcForm").serialize();
			
			$.ajax({
				type : "post",
				//url : "/templateListAjax",
				url : "refBoardListAjax",
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
			getRefBoardList();
		}
		
		function doViewModal( p_bkey ){
			
			var url = "./refReportDetailModal";
				
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

				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li id="cate_0" class="on"><a href="#">물보험자료실</a></li>
								<li id="cate_1" class=""><a href="#">법률자문,판례,분쟁조정</a></li>
								<li id="cate_2" class=""><a href="#">우수보고서</a></li>
							</ul>
						</div>
						<br/>						
						<div class="tableStyle2">
							<table>
								<tr>
									<th width="20%">종목</th>
									<th width="20%">유형</th>
									<th width="42%"></th>
									<th width="18%"></th>
								</tr>
								<tr>
									<td>
										<select id="eventSelect" name="eventSelect" style="width:90%;">
											<c:forEach items="${eventList}" var = "eventVo">
												<option value="${eventVo.col_cd}"
													<c:if test="${searchVO.eventSearch == eventVo.col_cd}">selected</c:if> > ${eventVo.col_val} </option>
											</c:forEach>
										</select>											
									</td>
									<td>
										<select id="typeSelect" name="typeSelect" style="width:90%;">												
											<c:forEach items="${typeList}" var = "typeVo">
												<option value="${typeVo.col_cd}"
													<c:if test="${searchVO.typeSearch == typeVo.col_cd}">selected</c:if> > ${typeVo.col_val} 
												</option>													
											</c:forEach>
										</select>
									</td>
									<td>
										<form method="get" name="boardSrcForm" id="boardSrcForm" action="./refReportBoardList">
											<input type="radio" name="boardSrcType" value="1"
												<c:if test="${searchVO.boardSrcType == ''}">checked</c:if>
												<c:if test="${searchVO.boardSrcType == '1'}">checked</c:if> />&nbsp;제목&nbsp;
											<input type="radio" name="boardSrcType" value="2"
												<c:if test="${searchVO.boardSrcType == '2'}">checked</c:if> />&nbsp;제목+내용&nbsp;
											<input type="radio" name="boardSrcType" value="3"
												<c:if test="${searchVO.boardSrcType == '3'}">checked</c:if> />&nbsp;이름&nbsp;
											<input type="text" id="boardSrcWord" name="boardSrcWord" value="${searchVO.boardSrcWord}" size="30" onchange="changeSqlRemoveText(this);" />&nbsp;
											<!-- <img src="./resources/ls_img/ls_board/btn_src.gif" id="boardSrcBtn" name="boardSrcBtn" />&nbsp; -->												
											<input type="hidden" id="reqPgNo" name="reqPgNo" value="${searchVO.reqPgNo}"/>												
											<input type="hidden" id="cateSearch" name="cateSearch" value="${searchVO.cateSearch}" />
											<input type="hidden" id="typeSearch" name="typeSearch" value="${searchVO.typeSearch}" />
											<input type="hidden" id="eventSearch" name="eventSearch" value="${searchVO.eventSearch}" />												
										</form>											
									</td>
									<td>
										<a class="btn-vacation-aprv" id="boardSrcBtn" href="#noloc">검색</a>
										<c:if test="${mbrAuthVo_Session.mbr_pms_39 == 1}">
											&nbsp;<a class="btn-vacation-aprv" id="boardSrcAddBtn" href="#noloc" style="background:#CEE3F6;">등록</a>
										</c:if>
									</td>
								</tr>
							</table>
						</div><!-- //tableStyle2 -->
						<br />
						<div class="tableStyle2">
							<table>									
								<tr>
									<th width="6%">번호</th>
									<th width="12%">종목</th>
									<th width="12%">유형</th>
									<th width="40%">제목</th>
									<th width="5%">첨부</th>
									<th width="10%">등록자</th>
									<th width="10%">등록일</th>
									<th width="5%">조회</th>
								</tr>
							</table>
						</div>
						<div id="boardBody"></div>
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
