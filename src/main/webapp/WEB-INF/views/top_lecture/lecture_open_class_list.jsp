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
			
			$("#teamType").select2();
			$("#categoryType").select2();

			$("#boardSrcBtn").click(function(){
				getNoticeBoardList();
			});
			
			$("#teamType").change(function(){
				$("#boardSrcBtn").click();				
			});
			
			$("#categoryType").change(function(){
				$("#boardSrcBtn").click();				
			});
			
			//게시판 목록을 불러온다.			
			getNoticeBoardList();

		});//ready
		
		//목록 불러오기
		function getNoticeBoardList(){
			
			var formData = $("#boardSrcForm").serialize();
			
			$.ajax({
				type : "post",				
				url : "lectureOpenListAjax",				
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
			getNoticeBoardList();
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
		
		.buttonDoneFlag{
			width:70px;
			height:23px;
		    background-color:#00a000;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
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
								<li id="tabMenu1" class="on"><a href="#">TOP Edu 공개 강의실</a></li>								
							</ul>
						</div>
						<div class="guestcnt2">															
								<!-- 검색창시작 -->
								<div class="tableStyle2" style="padding-bottom:10px;border-top:0px;">
									<form method="get" name="boardSrcForm" id="boardSrcForm" action="./lectureOpenList">
										<input type="hidden" id="reqPgNo" name="reqPgNo" value="${searchVO.reqPgNo}"/>
										<table>
											<tr>
												<th width="10%">교육구분</th>											
												<td width="20%">													
													<select id="teamType" name="teamType" style="width:200px;">
														<option value="" <c:if test='${searchVO.teamType eq ""}'>selected</c:if> >전체</option>
														<option value="0" <c:if test='${searchVO.teamType eq "0"}'>selected</c:if> >공통</option>
														<option value="1" <c:if test='${searchVO.teamType eq "1"}'>selected</c:if> >물보험</option>
														<option value="4" <c:if test='${searchVO.teamType eq "4"}'>selected</c:if> >인보험</option>
													</select>
												</td>
												<th width="10%">교육분류</th>												
												<td width="20%">
													<select id="categoryType" name="categoryType" style="width: 200px;">
														<option value="">- 전체 -</option>
														<c:forEach items="${selCategoryList}" var="categoryVo">															
															<option value="${categoryVo.ckey}" <c:if test='${categoryVo.ckey eq searchVO.categoryType}'>selected</c:if>>${categoryVo.category_name}</option>
														</c:forEach>
													</select>
												</td>
												<th width="10%">강의명</th>
												<td width="20%">													
													<input type="text" id="srchSubject" name="srchSubject" value="${searchVO.subjectSearch}" style="width: 200px;"/>
												</td>
												<td width="10%">
													<a class="btn-vacation-aprv" id="boardSrcBtn" href="#noloc">검색</a>
												</td>
											</tr>																				
										</table>
									</form>													
								</div>							
								<!-- 검색창끝 -->
								<!-- 강의실 목록 시작 -->						
								<div class="tableStyle2">
									<table>									
										<tr>
											<th width="5%">No</th>
											<th width="6%">교육구분</th>
											<th width="9%">교육분류</th>
											<th width="25%">강의명</th>
											<th width="25%">강의설명</th>
											<th width="3%">자료</th>
											<th width="9%">강사명</th>
											<th width="4%">조회수</th>											
											<th width="7%">등록일</th>
											<th width="7%">-</th>
										</tr>							
									</table>
								</div>
								<div id="boardBody"></div>						
								<!-- 강의실 목록 끝 -->									
						</div>
					</div>					
					<!-- 공개강의실 강의정보 조회 -->
					<div id="open-user-dialog" title="공개강의실 정보조회" style="font-size: 12px;" align="center"></div>
				</div>
				<!-- 탭메뉴 끝 -->
			</div>
		</div>
	</div>	
</div>
</body>
</html>