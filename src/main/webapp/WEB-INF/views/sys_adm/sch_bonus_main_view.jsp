<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
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
	<style>
		.btn-vacation-aprv {
			font-weight:bold;
			text-decoration:none;			
			text-indent:0px;
			line-height:0px;			;
			border-radius:5px;
			text-align:center;			
			display:inline-block;
			font-size:11px;
			color:#696969  !important;
			width:40px;			
			padding:1px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #E0F2F7;			
		}
		
		.buttonAssistanceEmail{
			    width: 90px;
			    height: 50px;
			    background-color: darkCyan;
			    color: #FFFFFF;
			    text-align: center;
			    border-radius: 5px;
			    font-size: 15px;
			    font-weight: bold;
			    cursor: pointer;
			    text-decoration: none;
			    border: none;
		}
		
		.tableStyle2 td{
			letter-spacing:0px;
		}		
	</style>
	<script language="javascript">
		$(document).ready( function(){
			$("#srchBaseYear").select2();
			$("#srchQuaterFlag").select2();
			$("#srchSectorList").select2();
			$("#srchCenterList").select2();
			$("#tmSearchMain").select2();
			$("#srchUserState").select2();
			
		});
		
		//검색
		function fnSearch(){			
			var formData = $("#searchFrm").serialize();
			$.ajax({
	 			type : "post",	 			
	 			url : "/getSchBonusListAjax",
	 			data : formData,
	 			success : function(result){			
	 				//날짜수정 페이지를 가져온다.	 				
	 				$("#divMemberList").html(result);	 				
	 			},
	 			error: function (request, status, error) {			
	 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
	 			}
	 		});
		}
		
		//엑셀다운로드
		function doDownload(){
			$("#searchFrm").attr("action","schBonusListExcel");
			$("#searchFrm").submit();
		}
		
		//수정 모달창 띄우기
		function fnModifyModal( p_skey ){
			
			var url = "/schUpdateModal";
			
			var param = {};
			param.skey = p_skey;
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){
		        	$("#sch-detail-dialog").html();
		        	$("#sch-detail-dialog").html(data);
					$("#sch-detail-dialog").dialog({
						height: 330,
						width: 750,
						closeOnEscape : true,
						draggable : true,
						title: "스케줄러수정",						
						modal: true,
						buttons:{
							"수정" : function(){
								var action = fnSchAction('U');
								if (action){
									$(this).dialog("close");
								}
							},
							"취소" : function(){
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
		
		function fnSchAction( p_action ){
			
			$("#actionFlag").val(p_action);
			
			var formData = $("#schActionFrm").serialize();
			
			$.ajax({
	 			type : "post",
	 			url : "/updateSchInfoAction",
	 			data : formData,
	 			success : function(result){	 				
	 				//창 닫고 새로고침
	 				alert("수정되었습니다.");
					$("#sch-detail-dialog").dialog('close');
					//재검색
					fnSearch();
	 			},
	 			error: function (request, status, error) {			
	 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
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
			<!-- centercnt_top -->
			<div class="center_cnt_1300">
				<!-- centercnt_bot -->
				<div class="center_cnt_vacation" >
					<div class="guest">
						<div class="guestTap">
							<ul>								
								<li class="on" id="mainTab"><a href="#">개인기준 성과급 스케줄러</a></li>																								
							</ul>
						</div>
						<!-- 검색 창 시작 -->
						<div class= "tableStyle2" style="border-top: 0px;">
							<form id="searchFrm">								
								<div style="float: right;padding:5px 0 5px 0;">
									<div style="text-align: right;">								
										<img alt="Exceldownload" src="/resources/ls_img/ls_invoice/btn_excel.gif" onclick="javascript:doDownload();" style="cursor:pointer;">&nbsp;
									</div>
								</div>												
								<div id="search-box"  align="center">
									<!-- 검색 창 시작 -->
									<table style="width: 100%;height:60px;" align="center">
										<tr>
											<th width="100px;">기준연도</th>
											<td width="120px;">
												<select id="srchBaseYear" name="srchBaseYear" style="width: 100px;">
													<option value="9999">- 전체 -</option>
													<option value="2025">2025</option>
													<option value="2024">2024</option>
													<option value="2023">2023</option>																																		
												</select>											
											</td>
											<th width="100px;">분기구분</th>
											<td width="120px;">
												<select id="srchQuaterFlag" name="srchQuaterFlag" style="width: 100px;">
													<option value="9">- 전체 -</option>
													<option value="1"> 1 </option>
													<option value="2"> 2 </option>
													<option value="3"> 3 </option>
													<option value="4"> 4 </option>
												</select>
											</td>
											<th width="100px;">부문명</th>
											<td width="200px;">
												<select id="srchSectorList" name="srchSectorList" style="width:190px;text-align:left;">
													<option value=""> - 전체 - </option>													
													<c:forEach items="${sectorList}" var="sectorVo">
														<option value="${sectorVo.teamSector}">${sectorVo.sectorName}</option>
													</c:forEach>
												</select>
											</td>
											<th width="100px;">센터명</th>
											<td width="200px;">
												<select id="srchCenterList" name="srchCenterList" style="width:190px;text-align:left;">
													<option value=""> - 전체 - </option>													
													<c:forEach items="${centerList}" var="centerVo">
														<option value="${centerVo.teamCenter}">${centerVo.centerName}</option>
													</c:forEach>
												</select>
											</td>
											<td width="100px;" rowspan="2">												
												<input title="검색" class="buttonAssistanceEmail" type="button" value="검 색" id="searchBtn" onclick='javascript:fnSearch();'>
											</td>	
										</tr>
										<tr>
											<th>재직상태</th>
											<td>
												<select id="srchUserState" name="srchUserState" style="width: 100px;">
													<option value="9">- 전체 -</option>
													<option value="0">재직자</option>
													<option value="1">퇴사자 </option>													
												</select>
											</td>
											<th>이름</th>
											<td>
												<input type="text" id="srchUserName" name="srchUserName" style="width:100px;"/>	
											</td>
											<th>팀명</th>
											<td>
												<select id="tmSearchMain" name="tmSearchMain" style="width:190px;text-align:left;">
													<option value="" <c:if test="${empty tmSearchMain}">selected</c:if> > - 전체 - </option>													
													<c:forEach items="${teamList}" var = "teamVo">
														<option value="${teamVo.teamId}"
															<c:if test="${tmSearchMain eq teamVo.teamId}">selected</c:if>>
															<c:if test="${teamVo.teamLevel == 1}">&nbsp;└</c:if>
															<c:if test="${teamVo.teamLevel == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
															${teamVo.teamName}
														</option>
													</c:forEach>
												</select>
											</td>
											<th>기준일자</th>
											<td>
												<input type="text" class="classCalendar" id="srchSdate" name="srchSdate" style="width:70px;" value="${baseDate}"/> ~
												<input type="text" class="classCalendar" id="srchEdate" name="srchEdate" style="width:70px;" value="${baseDate}"/>
											</td>											
										</tr>																																					
									</table>
									<!-- 검색 창 끝 -->
									<!-- 목록 시작 -->
									<div class="guestcnt4" style="display:block;height:750px;">
										<div class="tableStyle2">
											<table>									
												<tr>
													<th width="50px;">순번</th>
													<th width="100px;">부문명</th>
													<th width="100px;">센터명</th>
													<th width="100px;">팀명</th>
													<th width="100px;">성명</th>
													<th width="50px;">직급</th>
													<th width="100px;">실적</th>													
													<th width="50px;">기준일</th>
													<th width="50px;">근무일</th>
													<th width="50px;">근무율</th>
													<th width="90px;">목표건</th>
													<th width="90px;">실적건</th>
													<th width="90px;">성과율</th>
													<th width="90px;">기준일자</th>
													<c:if test="${mbrVo_Session.user_state == 9}">
														<th width="50px;"></th>						
													</c:if>							
													<th width="15px;"></th>													
												</tr>
											</table>									
											<div id="divMemberList" style="overflow:auto;width:100%; height:660px;"></div>
										</div><!-- //tableStyle2 -->							
									</div>
									<!-- 목록 끝 -->
								</div> 
							</form>
						</div>
						<!-- 검색 창 끝 -->						
					</div>
				</div>
				<!-- 스케줄러 수정 모달 -->					
				<div id="sch-detail-dialog" title="스케줄러수정" style="font-size: 15px;display:none;" align="center"></div>											
				<!-- //centercnt_bot -->
			<!-- //center_cnt -->
			</div>
		</div>
		<!-- //contents -->
	</div>
</div>
<!-- //wrapper -->
</body>
</html>
