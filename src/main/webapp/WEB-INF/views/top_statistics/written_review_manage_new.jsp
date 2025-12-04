<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>서면심사팀 실적관리</title>
    <link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=20170411111520" />
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->

    <script src="./resources/jquery/jquery.min_1_12.js"></script>
    <script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
    <script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->
    <script src="./resources/jquery/jquery.mask.min.js"></script>

    <script src="./resources/wm_js/common.js"></script>
    <script src="./resources/cmm/js/common.js"></script>

	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	<style>
	
		/* 모달창 셀렉트 박스 */
		.select2-container--default{
			text-align : left;
			font-color:#444;
			font-size:12px;
		}
		
		/*상세보기 버튼*/
		.btn-equipment-view {
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
		
		/*수정 버튼*/
		.btn-equipment-mod {
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
			color:#FFFFFF  !important;
			width:70px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #0033FF;
		}
		
		/*저장 버튼*/
		.btn-equipment-save {
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
			color:#FFFFFF  !important;
			width:70px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #3399FF;
		}
		
		/*취소 버튼*/
		.btn-equipment-cancel {
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
			color:#FFFFFF  !important;
			width:50px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #FF3333;
		}
	
		.td-overflow-none{
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
		}		
		
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

		.btn-vacation-aprv:active {
			position:relative;
			top:4px
		}
		
		/* 모달 버튼 */
		.ui-button-text-only {
			height:2.1em !important;
		}
	</style>
	<script>
	$(document).ready(function(){
		$("#tmSearchMain").select2();
		$("#written_ptnr_id").select2();
		$("#srchUserNoMain").select2();
		$("#tmSearchSub").select2({
			placeholder: " 검색할 팀을 선택해주세요. (검색어가 없으면 전체로 검색됩니다.)",
		    allowClear: true
		});
		
		//사용자 검색에 퇴직자 포함할것인지 여부
		$("#outUserChk").change(function(){		
			
			if( $('input:checkbox[id="outUserChk"]').is(":checked") ){			
				$("#s_out_user").val(1);			
			}else{			
				$("#s_out_user").val(0);			
			}
			
			var p_team_id = $("#tmSearchMain").val();
			var p_ptnr_id = $("#written_ptnr_id").val();
			var p_user_no = $("#srchUserNoMain").val();
			var p_sbasedate = $("#sbaseDate").val();
			var p_ebasedate = $("#ebaseDate").val();			
			
			$("#s_team_id").val(p_team_id);
			$("#p_ptnr_id").val(p_ptnr_id);
			$("#s_user_no").val(p_user_no);
			$("#s_base_date").val(p_sbasedate);
			$("#e_base_date").val(p_ebasedate);			
			
			//검색페이지까지 리프레쉬
			$("#searchForm").submit();
			
		});
		
		$("#btn_year_prev").on("click", function () {
			fnYearPrev();
		});
		
		$("#btn_year_next").on("click", function () {
			fnYearNext();
		});
	     
		//월별 선택 버튼 클릭시 해당월에 해당하는 날짜 text 입력
		$(".monthbtn").click(function(){
		
		    var imsimonth = $(this).attr("id");
		    
		    var imsiMonthStart = imsimonth -1;
		
		    if(imsimonth.length < 2){
		        imsimonth = "0" + imsimonth;
		    }
		
		    var imsiMonthStartStr = "0" + imsiMonthStart;
		
		    if(imsiMonthStartStr.length > 2) {
		        imsiMonthStartStr = imsiMonthStartStr.substring(1, imsiMonthStartStr.length);
		    }
		
		    $("#sbaseDate").val($("#year_txt").text() + "-" + imsiMonthStartStr + "-" + "16");
		    $("#ebaseDate").val($("#year_txt").text() + "-" + imsimonth + "-" + "15");
		    
		    $("#sbaseDateSub").val($("#year_txt").text() + "-" + imsiMonthStartStr + "-" + "16");
		    $("#ebaseDateSub").val($("#year_txt").text() + "-" + imsimonth + "-" + "15");
		    
		
		    if(imsimonth == 1){
		    	$("#sbaseDate").val(($("#year_txt").text()-1) + "-" + "12" + "-" + "16");
		        $("#sbaseDateSub").val(($("#year_txt").text()-1) + "-" + "12" + "-" + "16");
		    }
		
		    doSearch();
		    doSearchTeam();
		    
		});
	});
	
	
	function doDownLoad(){				
		
		$('#excelForm [name="s_team_id"]').val($("#tmSearchMain").val());
		$('#excelForm [name="s_ptnr_id"]').val($("#written_ptnr_id").val());
		$('#excelForm [name="s_user_no"]').val($("#srchUserNoMain").val());
		$('#excelForm [name="s_out_user"]').val($("#s_out_user").val());
		$('#excelForm [name="s_base_date"]').val($("#sbaseDate").val());
		$('#excelForm [name="e_base_date"]').val($("#ebaseDate").val());
		
		$("#excelForm").submit();
	}
	
	function doDownLoadTeam(){				
		
		$('#excelTeamForm [name="s_team_id"]').val($("#tmSearchMain").val());		
		$('#excelTeamForm [name="s_user_no"]').val($("#srchUserNoMain").val());
		$('#excelTeamForm [name="s_out_user"]').val($("#s_out_user").val());
		$('#excelTeamForm [name="s_base_date"]').val($("#sbaseDate").val());
		$('#excelTeamForm [name="e_base_date"]').val($("#ebaseDate").val());
		$('#excelTeamForm [name="s_team_id_sub"]').val($("#tmSearchSub").val());
		
		$("#excelTeamForm").submit();
	}
	
	function doSearchTeam(){
		
		var sUrl = "./getWrittenTeamListNew";
		
		var param = {};		
		param.s_team_id = $("#tmSearchMain").val();		
		param.s_user_no = $("#srchUserNoMain").val();
		param.s_out_user = $("#s_out_user").val();
		param.s_base_date = $("#sbaseDateSub").val();
		param.e_base_date = $("#ebaseDateSub").val();
		
		param.s_team_id_sub = $("#tmSearchSub").val();		
		
		$("#top_loading").show();		
		
		//검색결과 페이지를 가져온다.
		$.ajax({
    		type: "POST",
    		url: sUrl,
    		data: param,
    		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    		dataType: "html",
    		traditional: true,						//배열허용
    		timeout: 20000,    		         
    		success: function(data){
    			$("#writtenTeamList").html(data);    			
    		},            		
    		error: function (request, status, error) {
    			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
    		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
    		}            		
    	});
	}
	
	function doSearch(){
		
		var sUrl = "./getWrittenListNew";		
		
		var param = {};		
		param.s_team_id = $("#tmSearchMain").val();
		param.s_ptnr_id = $("#written_ptnr_id").val();
		param.s_user_no = $("#srchUserNoMain").val();
		param.s_out_user = $("#s_out_user").val();
		param.s_base_date = $("#sbaseDate").val();
		param.e_base_date = $("#ebaseDate").val();
		
		param.s_team_id_sub = $("#tmSearchSub").val();		
		
		$("#top_loading").show();
		
		//검색결과 페이지를 가져온다.
		$.ajax({
    		type: "POST",
    		url: sUrl,
    		data: param,
    		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    		dataType: "html",
    		traditional: true,						//배열허용
    		timeout: 20000,    		         
    		success: function(data){    			
    			$("#writtenList").html(data);    			
    		},            		
    		error: function (request, status, error) {
    			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
    		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
    		}            		
    	});
	}
	
	 
     
    function fnYearPrev(){
        var imsiyeartxt = $("#year_txt").text();
        $("#year_txt").text(--imsiyeartxt);        
        $("#sbaseDate").val(--imsiyeartxt+"-12-16");
        $("#sbaseDateSub").val($("#sbaseDate").val());        
        $("#ebaseDate").val($("#year_txt").text()+"-12-15");
        $("#ebaseDateSub").val($("#ebaseDate").val());        

        doSearch();
        doSearchTeam();
    }

    function fnYearNext(){
        var imsiyeartxt = $("#year_txt").text();
        $("#year_txt").text(++imsiyeartxt);
        $("#sbaseDate").val(--imsiyeartxt + "-12-16");
        $("#sbaseDateSub").val($("#sbaseDate").val());        
        $("#ebaseDate").val($("#year_txt").text()+"-12-15");
        $("#ebaseDateSub").val($("#ebaseDate").val());
        
        doSearch();
        doSearchTeam();

    }
	</script>
</head>
<body>
<div id="wrapper">
	<!-- top menu import -->
	<c:import url="../top_statistics/statistics_menu.jsp"></c:import>
	<!-- contents -->
	<div id="container">
		<div class="contetns">
		<!-- centercnt_top -->
			<div class="center_cnt_1300">
				<!-- centercnt_bot -->
				<div class="center_cnt_vacation" >
					<div class="guest">
						<div style="float: left;padding:10px 0 10px;">
							<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" >
							&nbsp;&nbsp;<b>서면심사(물) 실적통계</b>								
                          	</div>
					</div>
					<!-- 월달력 시작 -->		
					<div style="text-align: right;padding-right:20px;">
						<a id="btn_year_prev" href="#noloc">
                            <img src="./resources/ne_img/icon_prev.gif" width="17" height="13" border="0">
                        </a>
                        <a id="year_txt" href="#noloc;">${fn:substring(e_base_date,0,4)}</a>
                        <a id="btn_year_next" href="#noloc">
                            <img src="./resources/ne_img/icon_next.gif" width="17" height="13" border="0">
                        </a>
                        <c:forEach var="i" begin="1" end="12" step="1" varStatus="">
                            <input id="${i}" class="monthbtn" type="button" value="${i}월" />
                        </c:forEach>
					</div>
					<!-- 월달력 끝  -->			
						<div class="guest">	
							<div class="guestTap">
								<ul>
									<li class="on"><a href="#">개인별 실적통계</a></li>
									<li><a href="#">팀별 실적통계</a></li>
								</ul>							
							</div>
							
							<div class="guestcnt2">												
								<form id="searchForm" name="searchForm" method="post" action="writtenReviewManageNew">
								<input type="hidden" id="s_out_user" name="s_out_user" value="0" />
								<input type="hidden" id="s_team_id" name="s_team_id" value="0" />
								<input type="hidden" id="s_ptnr_id" name="s_ptnr_id" value="0" />
								<input type="hidden" id="s_user_no" name="s_user_no" />
								<input type="hidden" id="s_base_date" name="s_base_date" />
								<input type="hidden" id="e_base_date" name="e_base_date" />																							
								<div class="tableStyle99">							
									<table style="width: 100%;height:30px;" align="center">								
										<tr>
											<th width="60px;">보험사</th>
											<td width="120px;" style="text-align:center;">
												<select id="written_ptnr_id" name="written_ptnr_id" style="width:110px;">
													<option value="0">- 전체 -</option>
													<c:forEach items="${writtenPtnrIdList}" var="ptnrInfo" varStatus="status">														
														<option value="${ptnrInfo.ptnr_id}">${ptnrInfo.ptnr_nick}</option>																											
													</c:forEach>
												</select>																				
											</td>									
											<th width="60px;">부 서 명</th>
											<td width="140px;" style="text-align:center;">
												<select id="tmSearchMain" name="tmSearchMain" style="width:130px;text-align:left;">
													<option value="" <c:if test="${empty s_team_id}">selected</c:if> > - 전체 - </option>										
													<c:forEach items="${teamList}" var = "teamVo">
														<option value="${teamVo.teamId}"
															<c:if test="${s_team_id eq teamVo.teamId}">selected</c:if>>
															<c:if test="${teamVo.teamLevel == 1}">&nbsp;└</c:if>
															<c:if test="${teamVo.teamLevel == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
															${teamVo.teamName}
														</option>
													</c:forEach>
												</select>										
											</td>
											<th width="60px;">
												이 름
											</th>
											<td width="200px;" style="text-align:center;">
												<select id="srchUserNoMain" name="srchUserNoMain" style="width:100px;text-align:left;">
													<option value="" <c:if test="${empty s_user_no}">selected</c:if> > - 전체 - </option>											
													<c:forEach items="${memberList}" var="item" >
														<option value="${item.userNo}" <c:if test="${s_user_no == item.userNo}">selected</c:if> >${item.userName}</option>									
													</c:forEach>										
												</select>			
												&nbsp;&nbsp;<input type="checkbox" id="outUserChk" <c:if test="${s_out_user eq 1}">checked</c:if>> 퇴직자포함							
											</td>
											<th width="60px;">기준일</th>
											<td width="250px;" style="text-align:center;">
												<input type="text" class="classCalendar" id="sbaseDate" name="sbaseDate" style="width:100px;" value="${s_base_date}"/> ~ 
												<input type="text" class="classCalendar" id="ebaseDate" name="ebaseDate" style="width:100px;" value="${e_base_date}"/>										 
											</td>									
											<td style="text-align:center;"  width="200px;">
												<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick='javascript:doSearch();'>검색</a>&nbsp;&nbsp;
												<img id="exceldown" src="/resources/ls_img/btn_excel.gif" alt="엑셀다운로드" onclick="javascript:doDownLoad();" style="cursor:pointer;"/>
											</td>									
										</tr>
									</table>					
									<br/>					
									<table>
										<tr>
											<th width="120px;">보험사</th>
											<th width="150px;">센터명</th>
											<th width="150px;">부서명</th>
											<th width="120px;">이 름</th>
											<th width="85px;">수임건수</th>
											<th width="85px;">종결건수</th>
											<th width="85px;">취소건수</th>
											<th width="85px;">이&middot;내첩건수</th>
											<th width="85px;">미결건수</th>
											<th width="110px;">기준일</th>
											<th width="110px;">등록일</th>
											<th width="15px;"></th>
										</tr>								
									</table>
									<div id="writtenList" style="overflow:scroll; width:1260px; height:692px;"></div>
								</div>
								</form>
							</div>
							
							<div class="guestcnt2" style="display:block;">
								<!-- 팀별통계시작 -->
									<form id="teamSearchForm" name="teamSearchForm" method="post" action="writtenReviewManageNew">
									<input type="hidden" id="s_out_user" name="s_out_user" value="0" />
									<input type="hidden" id="s_team_id" name="s_team_id" value="0" />
									<input type="hidden" id="s_user_no" name="s_user_no" />
									<input type="hidden" id="s_base_date" name="s_base_date" />
									<input type="hidden" id="e_base_date" name="e_base_date" />																							
									<div class="tableStyle99">							
										<table style="width: 100%;height:30px;" align="center">								
											<tr>									
												<th width="80px;">부 서 명</th>
												<td width="480px;" style="text-align:center;">
													<select id="tmSearchSub" name="tmSearchSub" style="width:480px;text-align:left;" multiple="multiple">
														<option value="9999"> - 전체 - </option>										
														<c:forEach items="${teamList}" var = "teamVo">
															<option value="${teamVo.teamId}"
																<c:if test="${s_team_id eq teamVo.teamId}">selected</c:if>>
																<c:if test="${teamVo.teamLevel == 1}">&nbsp;└</c:if>
																<c:if test="${teamVo.teamLevel == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
																${teamVo.teamName}
															</option>
														</c:forEach>
													</select>										
												</td>												
												<th width="80px;">기준일</th>
												<td width="300px;" style="text-align:center;">
													<input type="text" class="classCalendar" id="sbaseDateSub" name="sbaseDateSub" style="width:100px;" value="${s_base_date}"/> ~ 
													<input type="text" class="classCalendar" id="ebaseDateSub" name="ebaseDateSub" style="width:100px;" value="${e_base_date}"/>										 
												</td>									
												<td style="text-align:center;"  width="200px;">
													<a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick='javascript:doSearchTeam();'>검색</a>&nbsp;&nbsp;
													<img id="exceldown" src="/resources/ls_img/btn_excel.gif" alt="엑셀다운로드" onclick="javascript:doDownLoadTeam();" style="cursor:pointer;"/>
												</td>									
											</tr>
										</table>					
										<br/>					
										<table>
											<tr>
												<th width="150px;">보험사</th>
												<th width="150px;">센터명</th>
												<th width="150px;">부서명</th>												
												<th width="85px;">수임건수</th>
												<th width="85px;">종결건수</th>
												<th width="85px;">취소건수</th>
												<th width="85px;">이&middot;내첩건수</th>
												<th width="85px;">미결건수</th>
												<th width="110px;">기준일</th>
												<th width="110px;">등록일</th>
												<th width="15px;"></th>
											</tr>								
										</table>
										<div id="writtenTeamList" style="overflow:scroll; width:1260px; height:692px;"></div>
									</div>
									</form>
								</div>
								<!-- 팀별통계끝 -->
							</div>	
						</div><!-- //guest -->
					<!-- 검색 창 시작 -->
					
					<!-- 일괄등록 검색 창 시작 -->
				</div>
			</div>
		</div>
		<!-- //통합로딩바 -->
		<div id="top_loading" style="display: none;">
			<img id="loading-image" src="/resources/cmm/images/spinner.gif" alt="Loading..." />
		</div>
		<!-- //통합로딩바끝 -->
	</div>
<form id="excelForm" name="excelForm" action="getWrittenListNewExcel" method="post">
	<input type="hidden" id="s_team_id" name="s_team_id"/>
	<input type="hidden" id="s_ptnr_id" name="s_ptnr_id"/>
	<input type="hidden" id="s_user_no" name="s_user_no"/>
	<input type="hidden" id="s_out_user" name="s_out_user"/>
	<input type="hidden" id="s_base_date" name="s_base_date"/>
	<input type="hidden" id="e_base_date" name="e_base_date"/>
</form>

<form id="excelTeamForm" name="excelTeamForm" action="getWrittenTeamListNewExcel" method="post">
	<input type="hidden" id="s_team_id" name="s_team_id"/>
	<input type="hidden" id="s_ptnr_id" name="s_ptnr_id"/>
	<input type="hidden" id="s_user_no" name="s_user_no"/>
	<input type="hidden" id="s_out_user" name="s_out_user"/>
	<input type="hidden" id="s_base_date" name="s_base_date"/>
	<input type="hidden" id="e_base_date" name="e_base_date"/>
	<input type="hidden" id="s_team_id_sub" name="s_team_id_sub"/>
</form>
</body>
</html>