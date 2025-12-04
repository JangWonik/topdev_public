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
	
	<!-- chart 추가 -->	
	<script src="./resources/chart/Chart.min.js"></script>	
	<script src="./resources/chart/utils.js"></script>
	
	<style>
		.btn-graph {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			box-shadow:inset #fafafa 0px 5px 8px -1px;
			o-box-shadow:inset #fafafa 0px 5px 8px -1px;
			-moz-box-shadow:inset #fafafa 0px 5px 8px -1px;
			-webkit-box-shadow:inset #fafafa 0px 5px 8px -1px;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:3px;
			-webkit-border-radius:3px;
			border-radius:3px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:12px;
			color:#696969  !important;
			width:160px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
		}
	</style>

	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_21}' == 0){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");				
			}
			
			$("#infotext").click(function(){				
				
				$("#info-context-dialog").dialog({
					height: 300,
					width: 700,
					closeOnEscape : true,
					draggable : false,
					position: { 'at' : 'right top' },
					title: "현장보고서 제출현황 설명",					
					buttons:{						
						"닫기" : function(){
							$(this).dialog("close");
						}
					},					
					modal: true,
					overlay:{ opacity: 0., background: '#000000'}
				});
				
			});
			
			//팀별 초과율 그래프 클릭
			$("#teamGraph").click(function(){
				var obj = document.topTeamAllForm;
				$("#tmViewType").val('team_all');
				obj.submit();				
			});
			
			//센터별 초과율 그래프 클릭
			$("#centerGraph").click(function(){
				var obj = document.topCenterAllForm;
				$("#ctViewType").val('center_all');
				obj.submit();
			});
			
			//부문별 초과율 그래프 클릭
			$("#sectorGraph").click(function(){
				var obj = document.topSectorAllForm;
				$("#seViewType").val('sector_all');
				obj.submit();
			});
			
		});//ready
		
		//현장보고서 개인 보고서 조회 팝업창
		function openSiteMemberReport( p_userno, p_menutype, p_end_average ){			
			var pop_title = "memberSiteReport";
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1505; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			
			$("#pop_userno").val(p_userno);
			$("#pop_menutype").val(p_menutype);
			$("#pop_end_average").val(p_end_average);
			
			window.open("","memberSiteRportPopup",'width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=yes,scrollbars=no');
			
			$("#frmPopData").attr("action","memberNoSiteListPop");
			$("#frmPopData").attr("target","memberSiteRportPopup");
			$("#frmPopData").submit();			
		}
		
		//현장보고서 센터 모달창
		function openSiteReportCenter( p_center ){
			
			var url = "./siteReportCenterModal";
			var param = {};
			param.team_center = p_center;			
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){
		        	$("#site-user-dialog").html();
		        	$("#site-user-dialog").html(data);
					$("#site-user-dialog").dialog({						
						height: 800,
						width: 1000,
						closeOnEscape : true,
						draggable : false,
						title: "현장보고서 제출현황",
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
		
		//현장보고서 팀 모달창
		function openSiteReportTeam( p_team ){
			
			var url = "./siteReportTeamModal";
			var param = {};
			param.team_id = p_team;
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){
		        	$("#site-user-dialog").html();
		        	$("#site-user-dialog").html(data);
					$("#site-user-dialog").dialog({						
						height: 800,
						width: 1000,
						closeOnEscape : true,
						draggable : false,
						title: "현장보고서 제출현황",
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
		
		//현장보고서 개인 모달창
		function openSiteReportUser( p_userno ){
			
			var url = "./siteReportUserModal";
			//alert("개인 현장보고서 팝업 : "+ p_userno);
			var param = {};
			param.user_no = p_userno;
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){
		        	$("#site-user-dialog").html();
		        	$("#site-user-dialog").html(data);
					$("#site-user-dialog").dialog({						
						height: 700,
						width: 900,
						closeOnEscape : true,
						draggable : false,
						title: "개인현장보고서 제출현황",
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
		
		//현장 보고서 막대 그래프 창 띄우기
		function openSiteChartBarDetail( p_type, p_center_name, p_team_name, p_user_name, p_key, p_suim, p_sub_3_in, p_sub_3_over, p_not_3_in, p_not_3_over ){	//창타입, 키, 수임건, 3일내제출, 3일초과제출, 3일내 미제출, 3일초과 미제출
			
			//var url = "./siteChartDetailModal";
			var url = "./siteChartBarDetailModal";
			var param = {};
			param.modalType = p_type;
			param.modalCenterName = p_center_name;
			param.modalTeamName = p_team_name;
			param.modalUserName = p_user_name;
			param.modalKey = p_key;
			param.modalSuim = p_suim;
			param.modalSub3In = p_sub_3_in;
			param.modalSub3Over = p_sub_3_over;
			param.modalNot3In = p_not_3_in;
			param.modalNot3Over = p_not_3_over;			
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){
		        	console.log("date : "+data);
		        	$("#site-chart-dialog").html();
		        	$("#site-chart-dialog").html(data);
					$("#site-chart-dialog").dialog({						
						height: 800,
						width: 1000,
						closeOnEscape : true,
						draggable : true,
						title: "현장보고서 제출현황 그래프 보기",
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
								<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" >
								&nbsp;&nbsp;<b>실시간 현장보고서 제출현황</b>								
                           	</div>
                           
                           	<div style="text-align: right;">
                           		<a class="btn-vacation-list-ins" id="infotext" href="#noloc" style="background:#A9D0F5;cursor:pointer;">설명</a>								
							</div>                           
							
						</div>
					</div>
				</div>				

				<div class="centercnt_bot2" style="margin:0 auto;">
					<div class="guest">
						<div class="guestTap">							
							<ul>
								<li id="memberTab" class="on"><a href="#">개인별 제출 현황</a></li>
								<li id="teamTab"><a href="#">팀별 제출 현황</a></li>
								<li id="centerTab"><a href="#">센터별 제출 현황</a></li>
								<li id="sectorTab"><a href="#">부문별 제출 현황</a></li>
							</ul>
						</div>
						<%--개인별 현장보고서 제출 현황 --%>
						<div class="guestcnt2" style="display:block;" id="memberView">							
							<c:import url="./site_report_member.jsp"></c:import>
						</div>
						<%--팀별 현장보고서 제출 현황 --%>
						<div class="guestcnt2" style="display:none;" id="teamView">							
							<c:import url="./site_report_team.jsp"></c:import>							
						</div>
						<%--센터별 현장보고서 제출 현황 --%>						
						<div class="guestcnt2" style="display:none;" id="centerView">							
							<c:import url="./site_report_center.jsp"></c:import>
						</div>
						<%--부문별 현장보고서 제출 현황 --%>
						<div class="guestcnt2" style="display:none" id="sectorView">							
							<c:import url="./site_report_sector.jsp"></c:import>
						</div>
					</div><!-- //guest -->
				</div><!-- centercnt_bot2 -->

			</div><!-- //center_cnt -->
		</div><!-- //contents -->
	</div><!-- //container -->
	<!-- 현장보고서 설명 모달 창 시작 -->
	<div id="info-context-dialog" title="현장보고서 제출현황 설명" style="font-size: 15px;display:none;" align="center">
		<br/>
		<div class="tableStyle99" style="width: 650px;">
			<table class="vacation-ins-table">
				<tr>
					<td style="tex-align:left;padding-left:10px;">
						① 수임건수 : 조회일 기준 직전 30일 내 수임건수 (현장보고서 제출 비대상 클래임 제외) <br/>
						② 제출 3영업일 이내 : 수임일 포함 3영업일 이내 현장보고서 제출건수  <br/>
						③ 제출 3영업일 초과 : 수임일 포함 3영업일 초과 현장보고서 제출건수  <br/>
						④ 미 제출 3영업일 이내 : 수임일 포함 3영업일 이내 현장보고서 미 제출건수  <br/>
						⑤ 미 제출 3영업일 초과 : 수임일 포함 3영업일 초과 현장보고서 미 제출건수  <br/>
						⑥ 기한내 제출율 : (③ 제출 3영업일 초과 + ⑤ 미 제출 3영업일 초과) / ① 수임건수 <br/>
						⑦ 수임 후 현장보고서 1개월 초과 미제출 : 조회일 기준 직전 30일 초과 미결 건 중 현장보고서 미 제출건수<br/>
						⑧ 현장보고서 제출 관리 대상 ${start_date} 이후 종결 건 평균 처리일(현재 날짜 기준)	
					</td>
				</tr>				
			</table>
		</div>	
	</div>
	<!-- 현장보고서 설명 모달 창 끝-->
	
	<script type='text/javascript'>
	    //목록엑셀다운로드
	    function doDownExcel(p_type){
	    	$("#exelType").val(p_type);
	    	$("#siteExcelDown").submit();
	    }
	</script>
	<form id="siteExcelDown" name="siteExcelDown" method="post" action="getSiteExcelDown">
		<input type="hidden" id="exelType" name="exelType">		
	</form>

	<!-- footer -->
	<c:import url="../top_statistics/statistics_footer.jsp"></c:import>
	<!-- //footer -->

</div>
<!-- //wrapper -->
<!-- 개인 현장보고서 제출현황보기 -->
<div id="site-user-dialog" title="개인현장보고서 현황 상세보기" style="font-size: 12px;" align="center"></div>

<!-- 현장 보고서 그래프 보기 모달 -->
<div id="site-chart-dialog" title="현장보고서 제출현황 그래프 보기" style="font-size: 12px;" align="center"></div>

<!-- 개인 현장보고서 팝업 띄우기 -->
<form name="frmPopData" id="frmPopData" method="post" >
<input type="hidden" id="pop_userno" name="pop_userno" />
<input type="hidden" id="pop_menutype" name="pop_menutype" />
<input type="hidden" id="pop_end_average" name="pop_end_average" />
</form>

</body>

</html>
