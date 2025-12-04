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
	<style>
		.buttonDiaAll{
			width:100px;
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
	</style>

	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_21}' == 0){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}
			
			_initButton();
	        $("#top_loading").hide();
			
	        //탭메뉴 처리 시작
			var chkTab = $("#tabMenu").val();			
			
			if( chkTab == 'team' ){
				$("#teamTab").attr("class","on");
				$("#memberTab").attr("class","");
				$("#centerTab").attr("class","");
				
				$("#teamView").show();
				$("#memberView").hide();
				$("#centerView").hide();
			}else if( chkTab == 'member' ){
				$("#memberTab").attr("class","on");
				$("#teamTab").attr("class","");				
				$("#centerTab").attr("class","");
				
				$("#memberView").show();
				$("#teamView").hide();				
				$("#centerView").hide();
			}else{
				$("#centerTab").attr("class","on");
				$("#teamTab").attr("class","");
				$("#memberTab").attr("class","");
				
				$("#centerView").show();
				$("#teamView").hide();
				$("#memberView").hide();
			}
			//탭메뉴 처리 끝
			
		});//ready
		
		//상단 탭메뉴 선택
		function goPtnrStatMenu( action ){	
			$("#top_loading").show();
			srchFrm.action = action;
			srchFrm.submit();
		}
		
		//보험사별 팀메뉴로 이동 (보험사 아이디, 센터아이디)
		function goPtnrStatTeam( p_ptnrId, p_teamCenter ){			
			$("#top_loading").show();
			$("#ptnr_id").val(p_ptnrId);
			$("#team_center").val(p_teamCenter);
			srchFrm.action = "ptnrStatTeamTraffic";
			srchFrm.submit();
		}
		
		//보험사별 팀 직원메뉴로 이동 (보험사 아이디, 팀아이디)
		function goPtnrStatMember( p_ptnrId, p_teamId ){
			$("#top_loading").show();
			$("#ptnr_id").val(p_ptnrId);
			$("#team_id").val(p_teamId);
			$("#tabMenu").val("team");
			srchFrm.action = "ptnrStatMemberTraffic";
			srchFrm.submit();
		}
		
		//탭메뉴 처리 시작		
		function centerTabClick(){
			$("#tabMenu").val("center");
		}
		
		function teamTabClick(){
			$("#tabMenu").val("team");			
		}
		
		function memberTabClick(){
			$("#tabMenu").val("member");			
		}
		//탭메뉴 처리 끝
		
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

				<%--검색 영역--%>
				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							<div style="float: left;">
								<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" >
								&nbsp;<b>${ptnrName} 센터별 실적 현황</b>
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
                           
							<form id="srchFrm" name="srchFrm" method="post" action="./ptnrStatCenterTraffic">
								<input type="hidden" id="team_id" name="team_id" value="${srchArg.team_id}" />
								<input type="hidden" id="ptnr_id" name="ptnr_id" value="${srchArg.ptnr_id}" />
								<input type="hidden" id="team_center" name="team_center" value="${srchArg.team_center}" />
								<input type="hidden" id="tabMenu" name="tabMenu" value="${srchArg.tabMenu}" />
								
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
							<input title="수임건수" class="buttonDiaAll" onclick="goPtnrStatMenu('ptnrStatCenterMain');" type="button" value="수임건수">
							<input title="종결건수" class="buttonDiaAll" onclick="goPtnrStatMenu('ptnrStatCenterEnd');" type="button" value="종결건수">
							<input title="순수피(Fee)" class="buttonDiaAll" onclick="goPtnrStatMenu('ptnrStatCenterFee');" type="button" value="순수피(Fee)">
							<input title="건당 순수피" class="buttonDiaAll" onclick="goPtnrStatMenu('ptnrStatCenterCntFee');" type="button" value="건당 순수피">
							<input title="일비" class="buttonDiaAll" onclick="goPtnrStatMenu('ptnrStatCenterTime');" type="button" value="일비">
							<input title="건당 일비" class="buttonDiaAll" onclick="goPtnrStatMenu('ptnrStatCenterCntTime');" type="button" value="건당 일비">
							<input title="교통비" class="buttonDiaAll" style="background-color:#FFA500;" onclick="goPtnrStatMenu('ptnrStatCenterTraffic');" type="button" value="교통비">													
							<input title="자문료+기타" class="buttonDiaAll" onclick="goPtnrStatMenu('ptnrStatCenterEtc');" type="button" value="자문료+기타">
							<input title="총 합계" class="buttonDiaAll" onclick="goPtnrStatMenu('ptnrStatCenterEntire');" type="button" value="총 합계">							
						</div>
						<div class="guestTap">
							<ul>
								<li id="centerTab" onclick="javascript:centerTabClick();"><a href="#">${ptnrName} 센터별 실적현황</a></li>
								<li id="teamTab" onclick="javascript:teamTabClick();"><a href="#">${ptnrName} 팀별 실적현황</a></li>
							</ul>
						</div>
						<div id="centerView" class="guestcnt2">
							<c:import url="./ptnr_stat_center_traffic_tb.jsp"></c:import>							
						</div>						
						<div id="teamView" class="guestcnt2">
							<c:import url="./ptnr_stat_team_all_traffic_tb.jsp"></c:import>							
						</div>
					</div><!-- //guest -->
				</div><!-- centercnt_bot2 -->

			</div><!-- //center_cnt -->
		</div><!-- //contents -->
	</div><!-- //container -->
	<!-- //통합로딩바 -->
	<div id="top_loading" style="display: none;">
		<img id="loading-image" src="/resources/cmm/images/spinner.gif" alt="Loading..." />
	</div>
	<!-- //통합로딩바끝 -->
	<!-- footer -->
	<c:import url="../top_statistics/statistics_footer.jsp"></c:import>
	<!-- //footer -->

</div>
<!-- //wrapper -->

	<script type='text/javascript'>
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
	        $("#top_loading").show();
	        var frm = document.getElementById("srchFrm");
	        frm.action = "./ptnrStatCenterTraffic";
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
