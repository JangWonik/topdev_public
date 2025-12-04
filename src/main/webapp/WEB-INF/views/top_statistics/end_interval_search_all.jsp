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
			
			//탭메뉴 선택
			showView( '${viewType}' );
			
			//년도선택박스
			$("#year_txt").on("click", function () {
	            fnYear();
	        });
			$("#btn_year_prev").on("click", function () {
				fnYearPrev();
	        });
	        $("#btn_year_next").on("click", function () {
				fnYearNext();
	        });
	        
	        
	      //월별 선택 버튼 클릭시 해당월에 해당하는 날짜 text 입력 (선택한 월의 다음달 15일로 기준일자를 정한다.)
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

	            $("#start_date").val($("#year_txt").text() + "-" + imsiMonthStartStr + "-" + "16");
	            $("#end_date").val($("#year_txt").text() + "-" + imsimonth + "-" + "15");

	            if(imsimonth == 1){
	                $("#start_date").val(($("#year_txt").text()-1) + "-" + "12" + "-" + "16");
	            }

	            fnSearch();
	        });
			
		});//ready
		
		
		//검색버튼 클릭시
		function fnSearch(){
			
			var start_date = $("#start_date").val();
			var end_date = $("#end_date").val();
			
			if( start_date == '' ){
				alert("검색 시작 일자를 입력해주세요.");
				$("#start_date").focus();
				return;
			}
			
			if( end_date == '' ){
				alert("검색 종료 일자를 입력해주세요.");
				$("#end_date").focus();
				return;
			}
			
			$("#excelYN").val('N');			
			$("#srchFrm").submit();			
			
		}
		
		//탭메뉴 선택시
		function showView( p_type ){
			
			$("#viewType").val( p_type );
			
			if( p_type == 'sector' ){						//부문으로 선택되어 있는경우
				$("#memberView").hide();
				$("#teamView").hide();
				$("#sectorView").show();
				$("#centerView").hide();
				$("#memberTab").attr("class","");
				$("#teamTab").attr("class","");
				$("#sectorTab").attr("class","on");
				$("#centerTab").attr("class","");
				$("#exelType").val('Sector');
			}else if( p_type == 'center' ){				//센터로 선택되어 있는경우
				$("#memberView").hide();
				$("#teamView").hide();
				$("#sectorView").hide();
				$("#centerView").show();
				$("#memberTab").attr("class","");
				$("#teamTab").attr("class","");
				$("#sectorTab").attr("class","");
				$("#centerTab").attr("class","on");
				$("#exelType").val('Center');
			}else if( p_type == 'team' ){				//팀으로 선택되어 있는경우
				$("#memberView").hide();
				$("#teamView").show();
				$("#sectorView").hide();
				$("#centerView").hide();
				$("#memberTab").attr("class","");
				$("#teamTab").attr("class","on");
				$("#sectorTab").attr("class","");
				$("#centerTab").attr("class","");
				$("#exelType").val('Team');
			}else{														//개인으로 선택되어있는경우
				$("#memberView").show();
				$("#teamView").hide();
				$("#sectorView").hide();
				$("#centerView").hide();
				$("#memberTab").attr("class","on");
				$("#teamTab").attr("class","");
				$("#sectorTab").attr("class","");
				$("#centerTab").attr("class","");
				$("#exelType").val('Member');
			}
		}
		
		function fnYear(){			
	        var imsiyeartxt = $("#year_txt").text();
	        $("#start_date").val(--imsiyeartxt+"-12-16");
	        $("#end_date").val($("#year_txt").text()+"-12-15");

	        fnSearch();
	    }

	    function fnYearPrev(){
	        var imsiyeartxt = $("#year_txt").text();
	        $("#year_txt").text(--imsiyeartxt);
	        $("#start_date").val(--imsiyeartxt+"-12-16");
	        $("#end_date").val($("#year_txt").text()+"-12-15");

	        fnSearch();
	    }

	    function fnYearNext(){
	        var imsiyeartxt = $("#year_txt").text();
	        $("#year_txt").text(++imsiyeartxt);
	        $("#start_date").val(--imsiyeartxt + "-12-16");
	        $("#end_date").val($("#year_txt").text()+"-12-15");

	        fnSearch();

	    }
		
		//엑셀 다운로드
		function doDownExcel(){
			
			var start_date = $("#start_date").val();
			var end_date = $("#end_date").val();
			
			if( start_date == '' ){
				alert("검색 시작 일자를 입력해주세요.");
				$("#start_date").focus();
				return;
			}
			
			if( end_date == '' ){
				alert("검색 종료 일자를 입력해주세요.");
				$("#end_date").focus();
				return;
			}			
						
			$("#excelYN").val('Y');			
			$("#srchFrm").submit();			
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
				<%--검색 영역--%>
				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							<div style="float: left;">
								<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" >
								&nbsp;&nbsp;<b>평균처리일 현황</b>								
                           	</div>
                           
                           	<div style="text-align: right;">
								<a id="btn_year_prev" href="#noloc">
                                   <img src="./resources/ne_img/icon_prev.gif" width="17" height="13" border="0">
                               </a>
                               &nbsp;
                               <a id="year_txt" href="#noloc;">${fn:substring(srchArg.end_date,0,4)}</a>
                               &nbsp;
                               <a id="btn_year_next" href="#noloc">
                                   <img src="./resources/ne_img/icon_next.gif" width="17" height="13" border="0">
                               </a>
                               <c:forEach var="i" begin="1" end="12" step="1" varStatus="">
                                   <input id="${i}" class="monthbtn" type="button" value="${i}월" />
                               </c:forEach>
							</div>							                           
							<br/>
							<form id="srchFrm" name="srchFrm" method="post" action="./getEndIntervalSearch">
							<div>
								<input type="text" class="classCalendar" id="start_date"  name="start_date" size="10"  value="${srchArg.start_date}" maxlength="10"/>&nbsp;부터&nbsp;&nbsp;
								<input type="text" class="classCalendar" id="end_date"  name="end_date" size="10"  value="${srchArg.end_date}" maxlength="10"/>&nbsp;까지																
								<input class="btn-vacation-list-ins" type="button" onclick="javascript:fnSearch()" value="조회하기" style="background:#A9D0F5;width:100px;cursor:pointer;">
								<input type="hidden" id="viewType" name="viewType" value="${viewType}"/>                               	
                               	<input type="hidden" id="excelYN" name="excelYN" value="N">
                               	<input type="hidden" id="exelType" name="exelType">                               	
							</div>
							</form>
						</div>						
					</div>
				</div>				

				<div class="centercnt_bot2" style="margin:0 auto;">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li id="memberTab" class="on"><a href="#" onclick="javascript:showView('member');">개인별 평균처리일</a></li>
								<li id="teamTab"><a href="#" onclick="javascript:showView('team');">팀별 평균처리일</a></li>
								<li id="centerTab"><a href="#" onclick="javascript:showView('center');">센터별 평균처리일</a></li>
								<li id="sectorTab"><a href="#" onclick="javascript:showView('sector');">부문별 평균처리일</a></li>
							</ul>							
						</div>
						<div style="width:100%;">
							<div style="padding-top:10px;font-weight:bold;">
								<table>
									<tr>
										<td><font color="blue">&#8251; 평균 처리일 : 보고서 1건에 대한 수임 일로부터 종결일까지의 평균 처리 기간</font></td>
										<td rowspan="2" align="right">
											<a href="#noloc" id="btn_excel" onclick="javascript:doDownExcel();">
												<img src="./resources/ls_img/btn_excel.gif">
											</a>
										</td>
									</tr>
									<tr>
										<td><font color="blue">&#8251; 종결건수 : 업무프로세스 대상,현장+과정관리에 한함</font></td>
									</tr>
								</table>																
							</div>							
						</div>				
						<div class="guestcnt2" style="display:block;" id="memberView">
							<c:import url="./end_interval_member.jsp"></c:import>							
						</div>
						<div class="guestcnt2" style="display:none;" id="teamView">
							<c:import url="./end_interval_team.jsp"></c:import>
						</div>						
						<div class="guestcnt2" style="display:none;" id="centerView">							
							<c:import url="./end_interval_center.jsp"></c:import>
						</div>
						<div class="guestcnt2" style="display:none" id="sectorView">
							<c:import url="./end_interval_sector.jsp"></c:import>
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

</body>

</html>
