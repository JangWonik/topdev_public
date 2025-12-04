<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE HTML>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css">	
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
	<script src="./resources/ne_js/calendar.js"></script><!-- calendar -->
	<script src="./resources/wm_js/common.js"></script>
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	<style>
		td{
				letter-spacing: 0px !important;
			}
			
		.buttonAssistanceEmail{
			width:120px;
			height:50px;
		    background-color:darkCyan;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 15px;
		    font-weight: bold;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		}		
	</style>
	<script>
	$(document).ready(function () {
		
		_initCalendar();
		$("#srchTeamType").select2();
		$("#srchPtnrId").select2();
		$("#srchUserNo").select2();
	});
	
	function _initCalendar(){    	 
  		$('.calendar').datepicker({
  			showOn: 'button',
  			buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
  			buttonImageOnly: true,
  			buttonText: "달력", 
  			changeMonth: true,
  			changeYear: true,	    	   
  			showButtonPanel: false,
  			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
  			dayNamesMin: ['일','월','화','수','목','금','토'],
  			dateFormat: 'yy-mm-dd',
  			firstDay: 0,
  			isRTL: false,
  			showMonthAfterYear: true
  	    }); 		
  		
  	}
	
	//검색
	function doSearch(){		
		
		//보험사를 선택해야 조회됨 (전체는 DB부하문제 있을수 있음)		
		var srchPtnrIdVal = $("#srchPtnrId").val();
		var srchPtnrNickName = $("#srchPtnrId option:selected").text();
		srchPtnrNickName = "(보험사 : "+srchPtnrNickName.replace("└","").trim()+")";
		
		var srchSdateVal = $("#srchSdate").val();
		var srchEdateVal = $("#srchEdate").val();		
		
		//if( srchPtnrIdVal == 0 ){
			//alert("보험사를 선택해 주세요.");
			//$("#srchPtnrId").focus();
			//return;
		//}
		
		if( srchSdateVal == "" ){
			alert("조회기간 시작일을 입력해 주세요.");
			$("#srchSdate").focus();
			return;
		}
		
		if( srchEdateVal == "" ){
			alert("조회기간 시작일을 입력해 주세요.");
			$("#srchEdate").focus();
			return;
		}
		
		$("#searchButton").hide();
		$("#top_loading").show();
		$("#ptnrNickName").html(srchPtnrNickName);
		
		var formData = $("#searchFrm").serialize();
		
		$.ajax({
			type : "post",			
			url : "getSuimReportPtnrAjax",
			data : formData,
			success : function(result){				
				$("#ptnrList").html(result);
				$("#top_loading").hide();
				$("#searchButton").show();
			},
			error: function (request, status, error) {			
				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
			}
		});
	}
	
	//다운로드
	function doDown(){
		
		//보험사를 선택해야 조회됨 (전체는 DB부하문제 있을수 있음)		
		var srchPtnrIdVal = $("#srchPtnrId").val();
		var srchPtnrNickName = $("#srchPtnrId option:selected").text();
		srchPtnrNickName = "(보험사 : "+srchPtnrNickName.replace("└","").trim()+")";
		
		var srchSdateVal = $("#srchSdate").val();
		var srchEdateVal = $("#srchEdate").val();
				
		//if( srchPtnrIdVal == 0 ){
			//alert("보험사를 선택해 주세요.");
			//$("#srchPtnrId").focus();
			//return;
		//}
		
		if( srchSdateVal == "" ){
			alert("조회기간 시작일을 입력해 주세요.");
			$("#srchSdate").focus();
			return;
		}
		
		if( srchEdateVal == "" ){
			alert("조회기간 시작일을 입력해 주세요.");
			$("#srchEdate").focus();
			return;
		}		
				
		$("#ptnrNickName").html(srchPtnrNickName+" 엑셀다운로드");
		
		var srchFrm = document.getElementById("searchFrm");
		srchFrm.action = "./getSuimReportPtnrExcel";		
		srchFrm.submit();
		
	}
	
	//보고서 새창띄우기
	function viewPopup(reportNo,delDate){			
		var suim_rpt_no = reportNo;
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		var sw=1010; //띄울 창의 넓이
		var sh=screen.availHeight;  //띄울 창의 높이 740
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		//창띄우기 전에 스크립트 초기화 by top3009			
		localStorage.setItem('activeTab','2');
		window.open('suimRptBscDtl?suim_rpt_no='+suim_rpt_no, suim_rpt_no,'width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=yes,scrollbars=yes');
	}
	
	</script>

</head>
<body>
<!-- wrapper -->
<div id="wrapper">
	<!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>	
	<!-- //header -->
	<!-- contents -->
	<div id="container">
		<div class="contetns2">
			<div class="center_cnt2">
				<%--검색 영역--%>
				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							<div style="float: left;">
								<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" >
								&nbsp;&nbsp;<b>손해사정서 교부현황 <font color="blue"><span id="ptnrNickName"></span></font></b>								
                           	</div>
                           	<br/><br/>                           	
                           	<!-- 검색창 시작 -->
                           	<!-- search-box -->                           	
							<div class= "tableStyle2" style="border-top: 0px;padding-bottom:10px;">
							<form id="searchFrm" name="searchFrm" method="POST">
								<table style="width: 100%;" align="center">
									<tr>
										<th width="8%">본부구분</th>
										<td width="10%">
											<select id="srchTeamType" name="srchTeamType" style="width: 95%;">
											<c:choose>
												<c:when test="${pms47 eq 1}">
													<option value="1">물보험본부</option>
												</c:when>
												<c:when test="${pms47 eq 4}">
													<option value="4">인보험본부</option>
												</c:when>
												<c:otherwise>
													<option value="5">- 전체 -</option>
													<option value="1">물보험본부</option>
													<option value="4">인보험본부</option>													
												</c:otherwise>											
											</c:choose>												
											</select>
										</td>
										<th width="8%">보험사</th>
										<td width="14%">
											<select id="srchPtnrId" name="srchPtnrId" style="width:95%;">
												<option value="0" selected>- 선택 -</option>
												<c:forEach items="${ptnrList}" var = "ptnrVo">
													<option value="${ptnrVo.ptnr_id}"
														<c:if test="${searchVO.ptnrSearch == ptnrVo.ptnr_id}">selected</c:if>>
														<c:if test="${ptnrVo.ptnr_level == 1}">&nbsp;└</c:if>
														${ptnrVo.ptnr_nick}
													</option>
												</c:forEach>
											</select>
										</td>										
										<th width="8%">조회기간</th>
										<td width="15%">
											<input type="text" class="calendar" id="srchSdate"  name="srchSdate" size="10"  value="${srchSdate}" maxlength="10" readonly="readonly"/> ~ 
											<input type="text" class="calendar" id="srchEdate"  name="srchEdate" size="10"  value="${srchEdate}" maxlength="10" readonly="readonly"/>
										</td>
										<th width="8%">담당자</th>
										<td width="12%">
											<select id="srchUserNo" name="srchUserNo" style="width:95%;">
												<option value="0"> - 전체 - </option>									
												<c:forEach items="${memberSelList}" var="item" >													
													<option <c:if test="${ item.userNo eq user_no}" >selected</c:if>  value="${item.userNo}">${item.userName}</option>									
												</c:forEach>										
											</select>
										</td>
										<td width="17%">
											<input type="button" id="searchButton" style="width:100px;background-color:#2E7EE8;" value="검 색" class="buttonAssistanceEmail" onclick="javascript:doSearch();">&nbsp;
											<input type="button" id="downButton" style="width:100px;" value="엑셀다운" class="buttonAssistanceEmail" onclick="javascript:doDown();">
										</td>
									</tr>
								</table>
								</form>
							</div>
							<!-- 검색창 끝 -->
							<!-- 검색 결과 목록 시작 -->
							<div id="ptnrList" style="height:700px;">
								<div class="tableStyle2" style="border-top: 0px;padding-bottom:10px;" id="infoTable">
									<table>
										<tr>
											<th style="height:25px;"><font color="blue">보험사 검색 또는 다운로드시 보고서 수에 따라 1분이상 시간이 소요될수 있습니다. 잠시 기다려주세요..</font></th>
										</tr>										
									</table>
								</div>
							</div>				
							<!-- 검색 결과 목록 끝 -->
						</div>
					</div>
				</div>
			</div><!-- //center_cnt -->
		</div><!-- //contents -->
	</div><!-- //container -->
	
	<!-- footer -->	
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->

</div>
<!-- //wrapper -->

</body>

</html>
