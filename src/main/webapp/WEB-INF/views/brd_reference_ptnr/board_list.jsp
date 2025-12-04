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
			
			//선택박스 초기화
			$("#ptnrSelect").select2();
			$("#titleSelect").select2();
			$("#typeSelect").select2();
			$("#yearSelect").select2();
			
			$("#boardSrcBtn").click(function(){
				if($(":radio[name=boardSrcType]:checked").val() != '1'
					&& $(":radio[name=boardSrcType]:checked").val() != '2'
					&& $(":radio[name=boardSrcType]:checked").val() != '3'){
						alert("검색 대상을 입력해주세요.");
						return;
				}			
				
				//$("#ptnrSearch").val($("#ptnrSelect").val());
				boardSrcForm.ptnrSearch.value=$("#ptnrSelect option:selected").val();
				boardSrcForm.ptnrGubun.value=$("#ptnrSelect option:selected").text().indexOf("└");
				
				$("#titleSearch").val($("#titleSelect").val());
				$("#typeSearch").val($("#typeSelect").val());
				$("#yearSearch").val($("#yearSelect").val());
				
				boardSrcForm.reqPgNo.value = 1;
				getReferencePtnrBoardList();
			});//$("#boardSrcBtn").click

			$("#ptnrSelect").change(function(){
				$("#boardSrcBtn").click();				
			});//$("#ptnrSelect").change

			$("#titleSelect").change(function(){
				$("#boardSrcBtn").click();				
			});//$("#titleSelect").change

			$("#typeSelect").change(function(){
				$("#boardSrcBtn").click();
			});//$("#typeSelect").change

			$("#yearSelect").change(function(){
				$("#boardSrcBtn").click();
			});//$("#yearSelect").change
			
			//카테고리 추가시작			
			//기본 탭 설정
			if( "${searchVO.cateSearch}" == "1" ){
				$("#cate_1").click();				
				tabClick(1);
			}else if( "${searchVO.cateSearch}" == "2" ){
				$("#cate_2").click();
				tabClick(2);
			}else{
				//최초 로딩시 실행
				$("#cate_0").click();
				tabClick(0);
			}
			
			$("#cate_0").click(function(){
				$("#cateSearch").val(0);
				boardSrcForm.reqPgNo.value = 1;				
				getReferencePtnrBoardList();				
			});
			
			$("#cate_1").click(function(){
				$("#cateSearch").val(1);
				boardSrcForm.reqPgNo.value = 1;
				getReferencePtnrBoardList();
			});
			
			$("#cate_2").click(function(){
				$("#cateSearch").val(2);
				boardSrcForm.reqPgNo.value = 1;
				getReferencePtnrBoardList();
			});
			
			//글등록 페이지 이동
			$("#boardSrcAddBtn").click(function(){				
				var cateVal = $("#cateSearch").val();
				if( cateVal == '' ){
					$("#cateSearch").val(0);
				}
				
				$("#boardSrcForm").attr("action","./referencePtnrBoardWriteForm");
				$("#boardSrcForm").submit();
			});
			//카테고리 추가 끝
			
			getReferencePtnrBoardList();

		});//ready
		
		function tabClick( p_val ){
			$("#cateSearch").val(p_val);			
			boardSrcForm.reqPgNo.value = 1;						
			getReferencePtnrBoardList();
		}
		
		//목록 불러오기
		function getReferencePtnrBoardList(){
			
			var formData = $("#boardSrcForm").serialize();
			
			$.ajax({
				type : "post",
				url : "topReferencePtnrBoardListAjax",
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
			getReferencePtnrBoardList();
		}
		
		//다중첨부파일 다운로드
		function doViewModal( p_bkey ){			
			
			//var url = "./noticeTopBoardDetailModal";
			var url = "./referencePtnrBoardDetailModal";
				
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
			width:40px;
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

				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<!-- <li class="on"><a href="#">보험사 공지·자료실</a></li> -->
								<li id="cate_0" class="on"><a href="#">보험사 공지·자료실</a></li>
								<li id="cate_1" class=""><a href="#">보험사 평가기준</a></li>
								<li id="cate_2" class=""><a href="#">보험사 평가결과</a></li>								
							</ul>						
							<br/>
							<div class="tableStyle2" style="padding-bottom:10px;">
								<table>
									<tr>
										<th width="28%">보 험 사</th>
										<th width="12%">종 구분</th>
										<th width="16%">자료종류</th>
										<th width="12%">해당연도</th>
										<th width="52%"></th>
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
											<!-- 현재부터 과거 10년까지로 변경 시작 by top3009-->											
											<jsp:useBean id="now" class="java.util.Date" />
											<fmt:formatDate value="${now}" pattern="yyyy" var="yearVar"/>
											<c:set var="yearVarPlus" value="${yearVar+1}"/>											 
											<select id="yearSelect" name="yearSelect" style="width:90%;">
												<option value="0" selected>전체</option>												
												<c:forEach begin="0" end="10" var="result" step="1">
													<option value="${yearVarPlus - result}"
														<c:if test="${searchVO.yearSearch == yearVarPlus - result}">selected</c:if> > ${yearVarPlus-result} 년 </option>
												</c:forEach>
											</select>
											<!-- 현재부터 과거 10년까지로 변경 끝 by top3009-->
										</td>
										<td>
											<form method="get" name="boardSrcForm" id="boardSrcForm" action="./referencePtnrBoardList">											
												<input type="radio" name="boardSrcType" value="1"
													<c:if test="${searchVO.boardSrcType == ''}">checked</c:if>
													<c:if test="${searchVO.boardSrcType == '1'}">checked</c:if> />제목&nbsp;
												<input type="radio" name="boardSrcType" value="2"
													<c:if test="${searchVO.boardSrcType == '2'}">checked</c:if> />제목+내용&nbsp;
												<input type="radio" name="boardSrcType" value="3"
													<c:if test="${searchVO.boardSrcType == '3'}">checked</c:if> />이름&nbsp;
												<input type="text" id="boardSrcWord" name="boardSrcWord" value="${searchVO.boardSrcWord}" size="15" onchange="changeSqlRemoveText(this);" />&nbsp;
												<a class="btn-vacation-aprv" id="boardSrcBtn" href="#noloc">검색</a>
												<a class="btn-vacation-aprv" id="boardSrcAddBtn" href="#noloc" style="background:#CEE3F6;">등록</a>																								
												<input type="hidden" id="reqPgNo" name="reqPgNo" />
												<input type="hidden" id="ptnrSearch" name="ptnrSearch" value="${searchVO.ptnrSearch}" />
												<input type="hidden" id="ptnrGubun" name="ptnrGubun" value="${searchVO.ptnrGubun}" />
												<input type="hidden" id="titleSearch" name="titleSearch" value="${searchVO.titleSearch}" />
												<input type="hidden" id="typeSearch" name="typeSearch" value="${searchVO.typeSearch}" />
												<input type="hidden" id="yearSearch" name="yearSearch" value="${searchVO.yearSearch}" />
												<input type="hidden" id="cateSearch" name="cateSearch" value="${searchVO.cateSearch}" />												
											</form>
										</td>
									</tr>
								</table>
							</div><!-- //tableStyle2 -->							
							<div class="tableStyle2">
								<table>									
									<tr>
										<th width="5%">번호</th>
										<th width="15%">보험사</th>
										<th width="6%">구분</th>
										<th width="9%">종류</th>
										<th width="5%">연도</th>
										<th width="35%">제목</th>
										<th width="3%">첨부</th>
										<th width="10%">작성자</th>
										<th width="8%">작성일</th>
										<th width="4%">조회</th>
									</tr>							
								</table>
							</div>
							<div id="boardBody"></div>							
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
