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
		.sub-p{
			border-top:1px solid #e6e6e6;
		}
	</style>

	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_21}' == 0){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}
		});//ready

		$(document).ready(function(){
		    $("#yearprev").click(function(){
		        var imsiyeartxt = $("#yeartxt").text();
		        $("#yeartxt").text(--imsiyeartxt);
	        	$("#viewFromDate").val(--imsiyeartxt+"-12-16");
	        	$("#viewToDate").val($("#yeartxt").text()+"-12-15");
		        misSearchForm.submit();
		    });
		    $("#yearnext").click(function(){
		        var imsiyeartxt = $("#yeartxt").text();
		        $("#yeartxt").text(++imsiyeartxt);
	        	$("#viewFromDate").val($("#yeartxt").text()+"-12-16");
	        	$("#viewToDate").val(++imsiyeartxt+"-12-15");
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
		        	$("#viewToDate").val($("#yeartxt").text()+"-"+imsimonth+"-"+ "15");
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

		});//$(document).ready

		function goMisAllotTmMbr(id, nm, type, written_flag){
			misSearchForm.action = "./getMisAllotTmMbr";
			misSearchForm.team_id.value = id;
			misSearchForm.team_name.value = nm;
			misSearchForm.team_type.value = type;
			misSearchForm.team_written.value = written_flag;
	        misSearchForm.submit();
		}
		
		//보험사별 일일배당현황 팝업
		function openPtnrByCenterModal( p_ptnrId , p_ptnrName ){
			
			var url = "./openPtnrByCenterModal";
			
			var param = {};
			param.ptnr_id = p_ptnrId;
			param.ptnr_name = p_ptnrName;
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){		        	
		        	$("#ptnr-center-dialog").html();
		        	$("#ptnr-center-dialog").html(data);
					$("#ptnr-center-dialog").dialog({						
						height: 800,
						width: 1600,
						closeOnEscape : true,
						draggable : true,
						title: "보험사 기준 센터별 일일 배당현황",
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
		
		//센터별 보험사 팝업
		function openCenterByPtnrModal( p_centerId , p_centerName ){
			
			//var url = "./openPtnrByCenterModal";
			var url = "./openCenterByPtnrModal";
			
			var param = {};
			param.team_center = p_centerId;
			param.center_name = p_centerName;
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){		        	
		        	$("#ptnr-center-dialog").html();
		        	$("#ptnr-center-dialog").html(data);
					$("#ptnr-center-dialog").dialog({						
						height: 800,
						width: 1600,
						closeOnEscape : true,
						draggable : true,
						title: "센터 기준 보험사별 일일 배당현황",
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

				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">

							<div style="float: left;">
								<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">
								&nbsp;<b><!-- 팀별 일일 배당 현황 -->전체 개인별 일일배당</b>
								<font color="red">*주의* 접수건중 반송&취소건은 제외된 건수입니다!</font>								
							</div>
							<div style="text-align: right;">								
								<b>&middot; 연간수임 :</b> ${nowVO.year_from} ~ ${nowVO.year_to} 의 <b>수임건수</b><br/>
								<b>&middot; 당월종결 :</b> ${nowVO.now_from} ~ ${nowVO.now_to} 의 <b>종결건수</b><br/>
								<b>&middot; 연간종결 :</b> ${nowVO.year_from} ~ ${nowVO.year_to} 의 <b>종결건수</b>								
							</div>
<!-- 							<div style="text-align: right;"> -->
<!-- 								<img id="yearprev" src="./resources/ne_img/icon_prev.gif" width="17" height="13" border="0"> -->
<%-- 								<a id="yeartxt" href="">${inVO.viewToDate.substring(0,4)}</a> --%>
<!-- 								<img id="yearnext" src="./resources/ne_img/icon_next.gif" width="17" height="13" border="0"> -->
<%-- 								<c:forEach var="i" begin="1" end="12" step="1" varStatus=""> --%>
<%-- 									<input id="${i}" class="monthbtn" type="button" value="${i}월" /> --%>
<%-- 								</c:forEach> --%>
<!-- 							</div> -->

							<form name="misSearchForm" id="misSearchForm" method="GET" action="./getMisAllotTmMbr">								
								<input type="hidden" id="viewFromDate" name="viewFromDate" value="${inVO.viewFromDate}" />
								<input type="hidden" id="viewToDate" name="viewToDate" value="${inVO.viewToDate}" />
								<input type="hidden" id="team_id" name="team_id" />
								<input type="hidden" id="team_name" name="team_name" />
								<input type="hidden" id="team_type" name="team_type" />
								<input type="hidden" id="team_written" name="team_written" />

							</form>

<!-- 							<p style="display: inline; float: right;"> -->
<!-- 								<input type=image src="./resources/ls_img/btn_excel.gif" width="70" height="17" border="0" id="btn_excel"> -->
<!-- 							</p> -->

<!-- 							<br/> -->

<!-- 							<form action="./log_member_excel" method="POST" id="excelform"> -->
<!-- 								<input type="hidden" name="hidtab" id="hidtab" /> -->
<!-- 							</form> -->
						</div>
					</div>
				</div><!-- //centercnt_top -->

				<div class="centercnt_bot2" style="margin:0 auto;">
					<div class="guest">

						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">전체 개인별 일일배당</a></li>
								<li><a href="#">팀별 일일 배당 현황</a></li>								
								<li><a href="#">센터별 일일 배당 현황</a></li>
								<li><a href="#">부문별 일일 배당 현황</a></li>
								<li><a href="#">보험사별 일일 배당 현황</a></li>								
							</ul>							
						</div>						
						
						<div class="guestcnt2" style="display:block;">
							<c:import url="./mis_allot_tm_mbr2.jsp"></c:import>
						</div>
						<div class="guestcnt2" style="display:none;">
							<c:import url="./mis_allot_tm1.jsp"></c:import>
						</div>
						<div class="guestcnt2" style="display:none;">
							<c:import url="./mis_allot_center.jsp"></c:import>
						</div>
						<div class="guestcnt2" style="display:none;">
							<c:import url="./mis_allot_sector.jsp"></c:import>
						</div>
						<div class="guestcnt2" style="display:none;">
							<c:import url="./mis_allot_ptnr.jsp"></c:import>
						</div>
						<div id="ptnr-center-dialog" title="보험사별 일일 배당현황 센터별 보기" style="font-size: 12px;" align="center"></div>						
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
