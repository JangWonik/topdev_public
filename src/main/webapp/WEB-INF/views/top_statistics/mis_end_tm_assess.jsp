<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE HTML>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css">
	<!--<link rel="stylesheet" type="text/css" href="./resources/ne_css/style2.css">-->
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
	<script src="./resources/ne_js/calendar.js"></script><!-- calendar -->
	<script src="./resources/wm_js/common.js"></script>

	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_21}' == 0){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}
		});//ready

		$(document).ready(function(){
			/*
		    $("#yearprev").click(function(){
		        var imsiyeartxt = $("#yeartxt").text();
		        $("#yeartxt").text(--imsiyeartxt);
	        	$("#viewFromDate").val(--imsiyeartxt+"-12-16");
	        	$("#viewToDate").val($("#yeartxt").text()+"-12-16");
		        misSearchForm.submit();
		    });
		    $("#yearnext").click(function(){
		        var imsiyeartxt = $("#yeartxt").text();
		        $("#yeartxt").text(++imsiyeartxt);
	        	$("#viewFromDate").val($("#yeartxt").text()+"-12-16");
	        	$("#viewToDate").val(imsiyeartxt+"-12-16");
		        misSearchForm.submit();
		    });
		    $("#yeartxt").click(function(){
		        var imsiyeartxt = $("#yeartxt").text();
	        	$("#viewFromDate").val(--imsiyeartxt+"-12-16");
	        	$("#viewToDate").val($("#yeartxt").text()+"-12-16");
		        misSearchForm.submit();
		    });

		    //월별 선택 버튼 클릭시 해당월에 해당하는 날짜 text 입력
		    $(".monthbtn").click(function(){
		    	var imsimonth = $(this).attr("id");
		    	var imsiMonthStart = imsimonth -1;
		    	if(imsimonth.length < 2) imsimonth = "0"+imsimonth;
		    	var imsiMonthStartStr = "0"+imsiMonthStart;
		    	if(imsiMonthStartStr.length > 2) imsiMonthStartStr = imsiMonthStartStr.substring(1, imsiMonthStartStr.length);
		        	$("#viewFromDate").val($("#yeartxt").text()+"-"+imsiMonthStartStr +"-"+ "16");
		        	$("#viewToDate").val($("#yeartxt").text()+"-"+imsimonth+"-"+ "16");
		        if(imsimonth == 1){
		        	$("#viewFromDate").val(($("#yeartxt").text()-1)+"-"+"12" +"-"+ "16");
		        }
		        misSearchForm.submit();
		    });//monthbtn.click

			$("#btn_excel").click(function(){alert(123);
				var data = $("#dataTable").html();
				$("#hidtab").attr('value',data);
				$("#excelform").submit();
			});
		    */
		});//$(document).ready

		//팀기준
		function goMisEndTm(viewFromDate, viewToDate){
			srchFrm.action = "./MisEndTm";
			srchFrm.stdBgnde.value = viewFromDate;
			srchFrm.stdEndde.value = viewToDate;
			srchFrm.submit();
		}

		function goMisEndTmAssess(viewFromDate, viewToDate){
			srchFrm.action = "./MisEndTmAssess";
			srchFrm.stdBgnde.value = viewFromDate;
			srchFrm.stdEndde.value = viewToDate;
			srchFrm.submit();
		}
		
		function goMisEndTmTime(viewFromDate, viewToDate){
			srchFrm.action = "./MisEndTmTime";
			srchFrm.stdBgnde.value = viewFromDate;
			srchFrm.stdEndde.value = viewToDate;
			srchFrm.submit();
		}
		
		function goMisEndTmTraffic(viewFromDate, viewToDate){
			srchFrm.action = "./MisEndTmTraffic";
			srchFrm.stdBgnde.value = viewFromDate;
			srchFrm.stdEndde.value = viewToDate;
			srchFrm.submit();
		}
		
		function goMisEndTmQr(viewFromDate, viewToDate){
			srchFrm.action = "./MisEndTmQr";
			srchFrm.stdBgnde.value = viewFromDate;
			srchFrm.stdEndde.value = viewToDate;
			srchFrm.submit();
		}
		
		function goMisEndTmTotal(viewFromDate, viewToDate){
			srchFrm.action = "./MisEndTmTotal";
			srchFrm.stdBgnde.value = viewFromDate;
			srchFrm.stdEndde.value = viewToDate;
			srchFrm.submit();
		}
		
		
		
		//개인기준
		function goMisEndTmMbr(viewFromDate, viewToDate, team_id, team_type){
			srchFrm.action = "./MisEndTmMbr";
			srchFrm.stdBgnde.value 	= viewFromDate;
			srchFrm.stdEndde.value 	= viewToDate;
			srchFrm.team_id.value 	= team_id;
			srchFrm.team_type.value = team_type;
			srchFrm.submit();
		}
		
		function goMisEndTmAssessMbr(viewFromDate, viewToDate, team_id, team_type){
			srchFrm.action = "./MisEndTmMbrAssess";
			srchFrm.stdBgnde.value = viewFromDate;
			srchFrm.stdEndde.value = viewToDate;
			srchFrm.team_id.value = team_id;
			srchFrm.team_type.value = team_type;			
			srchFrm.submit();
		}		
		
		function goMisEndTmTimeMbr(viewFromDate, viewToDate, team_id, team_type){
			srchFrm.action = "./MisEndTmMbrTime";
			srchFrm.stdBgnde.value = viewFromDate;
			srchFrm.stdEndde.value = viewToDate;
			srchFrm.team_id.value = team_id;
			srchFrm.team_type.value = team_type;			
			srchFrm.submit();
		}		
		
		function goMisEndTmTrafficMbr(viewFromDate, viewToDate, team_id, team_type){
			srchFrm.action = "./MisEndTmMbrTraffic";
			srchFrm.stdBgnde.value = viewFromDate;
			srchFrm.stdEndde.value = viewToDate;
			srchFrm.team_id.value = team_id;
			srchFrm.team_type.value = team_type;			
			srchFrm.submit();
		}		
		
		function goMisEndTmQrMbr(viewFromDate, viewToDate, team_id, team_type){
			srchFrm.action = "./MisEndTmMbrQr";
			srchFrm.stdBgnde.value = viewFromDate;
			srchFrm.stdEndde.value = viewToDate;
			srchFrm.team_id.value = team_id;
			srchFrm.team_type.value = team_type;			
			srchFrm.submit();
		}		
		
		function goMisEndTmTotalMbr(viewFromDate, viewToDate, team_id, team_type){
			srchFrm.action = "./MisEndTmMbrTotal";
			srchFrm.stdBgnde.value = viewFromDate;
			srchFrm.stdEndde.value = viewToDate;
			srchFrm.team_id.value = team_id;
			srchFrm.team_type.value = team_type;			
			srchFrm.submit();
		}			

	</script>

</head>

<body>

<!-- wrapper -->
<div id="wrapper">

	<!-- header -->
	<c:import url="../top_statistics/statistics_menu.jsp"></c:import>
	<!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns2">
			<div class="center_cnt2">

<%--
				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">

							<div style="float: left;">
								<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">
								&nbsp;<b>팀&개인 종결 현황</b>
							</div>
							<div style="text-align: right;">
								<img id="yearprev" src="./resources/ne_img/icon_prev.gif" width="17" height="13" border="0">
								<a id="yeartxt" href="#">${inVO.viewToDate.substring(0,4)}</a>
								<img id="yearnext" src="./resources/ne_img/icon_next.gif" width="17" height="13" border="0">
								<c:forEach var="i" begin="1" end="12" step="1" varStatus="">
									<input id="${i}" class="monthbtn" type="button" value="${i}월" />
								</c:forEach>
							</div>

							<form name="misSearchForm" id="misSearchForm" method="GET" action="./MisEndTmAssess">
								<input type="hidden" id="viewFromDate" name="viewFromDate" value="${inVO.viewFromDate}" />
								<input type="hidden" id="viewToDate" name="viewToDate" value="${inVO.viewToDate}" />
								<input type="hidden" id="team_id" name="team_id" value="${inVO.team_id}" />
								<input type="hidden" id="team_name" name="team_name" value="${inVO.team_name}" />
								<input type="hidden" id="team_type" name="team_type" value="${inVO.team_type}" />
								<input type="hidden" id="ptnr_id" name="ptnr_id" value="${inVO.ptnr_id}" />
								<input type="hidden" id="ptnr_nick" name="ptnr_nick" value="${inVO.ptnr_nick}" />
							</form>
							
						</div>
					</div>
				</div><!-- //centercnt_top -->
 --%>
 				
				<%-- 검색 영역 --%>
				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							<div style="float: left;">
								<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" >
								&nbsp;<b>팀별 종결 현황</b>
                           	</div>
                           
                           	<div style="text-align: right;">
								<a id="btn_year_prev" href="#noloc">
                                   <img src="./resources/ne_img/icon_prev.gif" width="17" height="13" border="0">
                               </a>
                               <a id="year_txt" href="#noloc;">${fn:substring(srchArg.stdEndde,0,4)}</a>
                               <a id="btn_year_next" href="#noloc">
                                   <img src="./resources/ne_img/icon_next.gif" width="17" height="13" border="0">
                               </a>
                               <c:forEach var="i" begin="1" end="12" step="1" varStatus="">
                                   <input id="${i}" class="monthbtn" type="button" value="${i}월" />
                               </c:forEach>
							</div>
                           
							<br/>
                           
							<form id="srchFrm" name="srchFrm" method="post" action="./MisEndTmAssess">
								<input type="hidden" id="team_id" name="team_id" value="${srchArg.team_id}" />
								<input type="hidden" id="team_name" name="team_name" value="${srchArg.team_name}" />
								<input type="hidden" id="team_type" name="team_type" value="${srchArg.team_type}" />
								<input type="hidden" id="viewFromDate" name="viewFromDate" value="${srchArg.stdBgnde}" />
								<input type="hidden" id="viewToDate" name="viewToDate" value="${srchArg.stdEndde}" />
				                                
                               	<input type="hidden" id="srchBasicYN" name="basicYN" value="${srchArg.basicYN}"/>
                               	<input type="hidden" id="srchPrimYN" name="primYN" value="${srchArg.primYN}"/>
                               	<input type="hidden" id="srchExcelYN" name="excelYN" value="N">	
                               	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   
								<input type="text" id="stdBgnde"  name="stdBgnde" size="10"  value="${srchArg.stdBgnde}" maxlength="10" readonly="readonly"/>
								<span style="color:#0066CC">부터</span>&nbsp;&nbsp;&nbsp;
								<input type="text" id="stdEndde"  name="stdEndde" size="10"  value="${srchArg.stdEndde}" maxlength="10" readonly="readonly"/>
								<span style="color:#0066CC">까지</span>&nbsp;&nbsp;&nbsp;

								<input type="checkbox" id="basicYN" <c:if test="${srchArg.basicYN == 'Y'}">checked</c:if> /> <label for="basicYN">기본수임</label>&nbsp;&nbsp;

								<input type="checkbox" id="primYN"  <c:if test="${srchArg.primYN == 'Y'}">checked</c:if> /> <label for="primYN">농작물</label>&nbsp;&nbsp;

								<a id="btn_search" href="#noloc">
									<img src="./resources/ne_img/icon_log_src.gif" width="110" height="22" border="0">
								</a>
								<br>
							</form>
						</div>
					</div>
				</div>					

				<div class="centercnt_bot2" style="margin:0 auto;">
					<div class="guest">
						<div style="text-align: right;">
							<b><a href="#noloc" onclick="javascript:goMisEndTm('${srchArg.stdBgnde}','${srchArg.stdEndde}');">절대건수</a></b>&nbsp;&nbsp;&nbsp;
							<b><a href="#noloc" onclick="javascript:goMisEndTmAssess('${srchArg.stdBgnde}','${srchArg.stdEndde}');">순수 피(Fee)</a></b>&nbsp;&nbsp;&nbsp;
							<b><a href="#noloc" onclick="javascript:goMisEndTmTime('${srchArg.stdBgnde}','${srchArg.stdEndde}');">일비</a></b>&nbsp;&nbsp;&nbsp;
							<b><a href="#noloc" onclick="javascript:goMisEndTmTraffic('${srchArg.stdBgnde}','${srchArg.stdEndde}');">교통비</a></b>&nbsp;&nbsp;&nbsp;
							<b><a href="#noloc" onclick="javascript:goMisEndTmQr('${srchArg.stdBgnde}','${srchArg.stdEndde}');">자문료+기타</a></b>&nbsp;&nbsp;&nbsp;
							<b><a href="#noloc" onclick="javascript:goMisEndTmTotal('${srchArg.stdBgnde}','${srchArg.stdEndde}');">총합계</a></b>&nbsp;&nbsp;&nbsp;
						</div>
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">순수 피(Fee)</a></li>
							</ul>
						</div>
						<div class="guestcnt2" style="display:block;">
							<c:import url="./mis_end_tm_assess1.jsp"></c:import>
						</div>

					</div><!-- //guest -->
				</div><!-- centercnt_bot2 -->

			</div><!-- //center_cnt -->
		</div><!-- //contents -->
	</div><!-- //container -->

	<!-- footer -->
	<c:import url="../top_statistics/statistics_footer.jsp"></c:import>
	<!-- //footer -->

</div>
<!-- //wrapper -->

	<script type='text/javascript'>
	    $(document).ready(function () {
	        _initButton();
	    });
	
	    //버튼 이벤트
	    function _initButton() {
	        $("#btn_search").on("click", function () {
	            fnSearch();
	        });
	
	        $("#btn_excel").on("click", function () {
	            fnExcel();
	        });
	
	        $("#year_txt").on("click", function () {
	            fnYear();
	        });
	
	
	        $("#btn_year_prev").on("click", function () {
	            fnYearPrev();
	        });
	        $("#btn_year_next").on("click", function () {
	            fnYearNext();
	        });
	
	        $("#basicYN").on("click", function () {
	            fnToggle("basicYN","srchBasicYN");
	        });
	
	        $("#primYN").on("click", function () {
	            fnToggle("primYN","srchPrimYN");
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
	
	            $("#stdBgnde").val($("#year_txt").text() + "-" + imsiMonthStartStr + "-" + "16");
	            $("#stdEndde").val($("#year_txt").text() + "-" + imsimonth + "-" + "15");
	            
	
	            if(imsimonth == 1){
	                $("#stdBgnde").val(($("#year_txt").text()-1) + "-" + "12" + "-" + "16");
	            }
	
	            fnSearch();
	        });
	    }
	
	    function fnSearch(){
	        $("#loading").show();
	
	        var frm = document.getElementById("srchFrm");
	        frm.action = "./MisEndTmAssess";
	        frm.submit();
	    }
	
	
	    function fnYear(){
	        var imsiyeartxt = $("#year_txt").text();
	        $("#stdBgnde").val(--imsiyeartxt+"-12-16");
	        $("#stdEndde").val($("#year_txt").text()+"-12-15");
	
	        fnSearch();
	    }
	
	    function fnYearPrev(){
	        var imsiyeartxt = $("#year_txt").text();
	        $("#year_txt").text(--imsiyeartxt);
	        $("#stdBgnde").val(--imsiyeartxt+"-12-16");
	        $("#stdEndde").val($("#year_txt").text()+"-12-15");
	
	        fnSearch();
	
	    }
	
	    function fnYearNext(){
	        var imsiyeartxt = $("#year_txt").text();
	        $("#year_txt").text(++imsiyeartxt);
	        $("#stdBgnde").val(--imsiyeartxt + "-12-16");
	        $("#stdEndde").val($("#year_txt").text()+"-12-15");
	
	        fnSearch();
	
	    }
	
	    function fnToggle(srcId, targetId){
	        if ($("#" + srcId).prop("checked")){
	            $("#" + targetId).val("Y");
	        }else{
	            $("#" + targetId).val("N");
	        }
	    }
	</script>

</body>

</html>
