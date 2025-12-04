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
	
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=20170411111520" />
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
    <script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
    <script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->

    <script src="./resources/wm_js/common.js"></script>
    <script src="./resources/cmm/js/common.js"></script>

	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	
	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || ('${mbrAuthVo_Session.mbr_pms_14}' == 0 && '${mbrAuthVo_Session.mbr_pms_15}' == 0)){
				window.location.assign("./logout");
			}

			$.ajaxSetup({cache:false});
			
			$("#srchTeamType").select2();
			$("#srchTeamId").select2();
			$("#srchCertiClass").select2();			
			$("#srchUserState").select2();
			$("#srchUserName").focus();
			
			//$("#srchUserState").val(0).trigger('change');
			
			doSearch();

		});//$(document).ready		
		
		function doSearch(){
			
			var formData = $("#searchFrm").serialize();
			$("#loading").show();
			
			$.ajax({
				type : "post",
				url : "insaCertiMemberAjax",				
				data : formData,
				success : function(result){			
					$("#loading").hide();
					$("#memberList").html(result);				
				},
				error: function (request, status, error) {			
					console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
				}
			});			
		}
		
		function doExcelDown(){			
			$("#searchFrm").attr("action","insaCertiMemberExcel");
			$("#searchFrm").submit();			
		}
		
		function popMbrDetail(user_no){
			
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
			var sw=1500; //띄울 창의 넓이
			var sh=900;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치			
			
			window.open('popMbrDetail?user_no='+user_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',scrollbars=yes,resizable=yes');
			
		}
		
		function enterKey(){			
			if(event.keyCode == 13){				
				event.preventDefault();
				//doSearch();
			}
		}
		
	</script>
	
	<style>
		.tableStyle2 td {letter-spacing: 0;}
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
		
		/* 모달창 셀렉트 박스 */
		.select2-container--default{
			text-align : left;
			font-color:#444;
			font-size:12px;
		}
		
		.buttonDiaAll{
			width:150px;
			height:23px;
		    background-color:#4a6b86;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 12px;
		    cursor: pointer;
		    font-weight: bold;
		    text-decoration:none;
		    border: none;
		    }
		    
		.buttonDiaAll:hover{
			background-color:#FFA500;
			}
		
		.tableStyle2.tableStyle2 th, .tableStyle2 td {height:35px;padding:0 0 0 0;}		
		
		.guest .guestcnt_1300_dx {display:block;margin-top:10px;padding:0 0 10px 0;} 
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

			<!-- centercnt_top -->
			<div class="center_cnt_1300_ds">
				<!-- centercnt_bot -->
				<div class="centercnt_1300_bot1-2_ds">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on" id="memberTab"><a href="#">직원별</a></li>
								<!-- <li id="certiTab"><a href="#">자격별</a></li>
								<li id="zoneTab"><a href="#">지역별</a></li> -->																
							</ul>
						</div>
						
						<div class="guestcnt0" id="memberView" style="display:block;padding-top:10px;">
							<div style="text-align:right;padding-bottom:5px;">
								<img src="./resources/ls_img/ls_invoice/btn_excel.gif" style='cursor:pointer;' id="certiMemberExcel" onclick="javascript:doExcelDown();"/>
							</div>							
							<div class= "tableStyle2" style="border-top:0px;">
							<!-- 검색창 시작 -->
								<form id="searchFrm" method="POST">
									<input type="hidden" id="view_type" name="view_type" value="search" />
									<input type="hidden" id="pageIdxSearch" name="pageIdxSearch" />
									<input type="hidden" id="srchUserState" name="srchUserState" value="0"/><!-- 재직상태만 다운로드 방식으로 변경 -->																		
									<div id="search-box"  align="center">
										<table style="width: 100%;" align="center">											
											<tr>
												<th width="6%">본부구분</th>
												<td width="12%">
													<select id="srchTeamType" name="srchTeamType" style="width: 140px;">
														<option value="5" <c:if test="${srchTeamType eq 5}">selected</c:if> >- 전체 -</option>
														<option value="1" <c:if test="${srchTeamType eq 1}">selected</c:if> >물보험본부</option>
														<option value="4" <c:if test="${srchTeamType eq 4}">selected</c:if> >인보험본부</option>
													</select>
												</td>
												<th width="6%">부서명</th>
												<td width="16%">
													<span style="text-align: left !important;">
														<select id="srchTeamId" name="srchTeamId" style="width: 200px;">
															<option value="0">- 전체 -</option>
															<c:forEach items="${teamList}" var="teamVo">
																<c:choose>
																	<c:when test="${srchParam.srchTeamId == teamVo.team_id}">
																		<option value="${teamVo.team_id}" selected="selected">
																	</c:when>
																	<c:otherwise>
																		<option value="${teamVo.team_id}">
																	</c:otherwise>
																</c:choose>																
																	<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
																	<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
																	${teamVo.team_name}																
															</c:forEach>
														</select>
													</span>
												</td>
												<th width="6%">등록구분</th>
												<td width="14%">
													<select id="srchCertiClass" name="srchCertiClass" style="width: 160px;">
														<option value="">- 전체 -</option>
														<option value="0">미등록</option>
														<option value="1">보조인 자격 충족</option>
														<option value="2">보조인 자격 불충족</option>
														<option value="3">비대상</option>
														<option value="4">손해사정사</option>
														<option value="6">손해사정사+보조인</option>
													</select>
												</td>
												<th width="6%">이름</th>
												<td width="10%">
													<input type="text" id="srchUserName" name="srchUserName" value="${srchParam.srchUserName}" onkeydown="javascript:enterKey();" style="width:100px;"/>
												</td>
												<%-- <th width="8%">재직상태</th>
												<td width="8%">
													<select id="srchUserState" name="srchUserState" style="width: 80px;">
														<option value="" <c:if test="${srchUserState eq 4}">selected</c:if> >전체</option>
														<option value="0" <c:if test="${srchUserState eq 5}">selected</c:if> >재직자</option>
														<option value="1" <c:if test="${srchUserState eq 1}">selected</c:if> >퇴사자</option>														
													</select>
												</td> --%>
												<td width="8%">
													<a href="#noloc" class="btn-vacation-aprv" onclick="javascript:doSearch();">검색</a>
												</td>												
											</tr>
										</table>
										<br/>
									</div> 
								</form>
							</div>							
							<div id="memberList"></div>
							<!-- 직원별 목록끝 -->
						</div>
						<!-- 검색창 끝 -->
					</div>				
				</div>
			<!-- //center_cnt -->
			</div>
		</div>	
		<!-- //contents -->
		<!-- footer -->
		<c:import url="../top_main/top_main_footer.jsp"></c:import>
		<!-- //footer -->
	</div>
</div>
<!-- //wrapper -->
</body>
</html>
