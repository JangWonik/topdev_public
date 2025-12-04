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
	            var imsiyear = parseInt($("#year_txt").text());
	            
	            var resultMonthVal = "";
	            var resultYearVal = "";
	            
	            if( imsimonth == 12 ){
	            	imsimonth = 1;
	            	imsiyear = imsiyear+1;
	            }else{
	            	imsimonth++;
	            }
	            
	            resultMonthVal = String(imsimonth);
	            resultYearVal = String(imsiyear);
	            
	            if(resultMonthVal.length < 2){
	            	resultMonthVal = "0" + resultMonthVal;	            	
	            }	            
	
	            $("#stdBgnde").val(resultYearVal + "-" + resultMonthVal + "-" + "15");
	
	            fnSearch();
	        });
			
		});//ready
		
		
		//검색버튼 클릭시
		function fnSearch(){
			
			var searchDate = $("#stdBgnde").val();
			
			if( searchDate == '' ){
				alert("기준일자를 입력해주세요.");
				$("#stdBgnde").focus();
				return;
			}else{
				$("#excelYN").val('N');
				$("#searchDateVal").val(searchDate);
				$("#srchFrm").submit();				
			}
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
			}else if( p_type == 'center' ){				//센터로 선택되어 있는경우
				$("#memberView").hide();
				$("#teamView").hide();
				$("#sectorView").hide();
				$("#centerView").show();
				$("#memberTab").attr("class","");
				$("#teamTab").attr("class","");
				$("#sectorTab").attr("class","");
				$("#centerTab").attr("class","on");
			}else if( p_type == 'team' ){				//팀으로 선택되어 있는경우
				$("#memberView").hide();
				$("#teamView").show();
				$("#sectorView").hide();
				$("#centerView").hide();
				$("#memberTab").attr("class","");
				$("#teamTab").attr("class","on");
				$("#sectorTab").attr("class","");
				$("#centerTab").attr("class","");
			}else{														//개인으로 선택되어있는경우
				$("#memberView").show();
				$("#teamView").hide();
				$("#sectorView").hide();
				$("#centerView").hide();
				$("#memberTab").attr("class","on");
				$("#teamTab").attr("class","");
				$("#sectorTab").attr("class","");
				$("#centerTab").attr("class","");
			}
		}
		
		//현재 년도 선택
		function fnYear(){
	        var imsiyeartxt = $("#year_txt").text();
	        $("#stdBgnde").val(imsiyeartxt+"-12-15");
	        fnSearch();
	    }
		
		//전년도로 가기
		function fnYearPrev(){
	        var imsiyeartxt = $("#year_txt").text();
	        $("#year_txt").text(--imsiyeartxt);
	        $("#stdBgnde").val(imsiyeartxt+"-12-15");
	       	fnSearch();
	    }
		
		//내년도로 가기
		function fnYearNext(){
	        var imsiyeartxt = $("#year_txt").text();
	        $("#year_txt").text(++imsiyeartxt);
	        $("#stdBgnde").val(imsiyeartxt + "-12-15");
	        fnSearch();	
	    }
		
		//엑셀 다운로드
		function doDownExcel(){
			
			var searchDate = $("#stdBgnde").val();
			
			if( searchDate == '' ){
				alert("기준일자를 입력해주세요.");
				$("#stdBgnde").focus();
				return;
			}else{
				$("#excelYN").val('Y');
				$("#searchDateVal").val(searchDate);
				$("#srchFrm").submit();				
			}			
		}
		
		//현장보고서 상세보기 모달창		
		function openSiteReportDetail( p_type, p_key, p_date ){		//창타입, 키, 기준일자
			
			var url = "./siteReportDetailModal";
			var param = {};
			param.modalType = p_type;
			param.modalKey = p_key;
			param.modalDate = p_date;
			
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
						height: 280,
						width: 700,
						closeOnEscape : true,
						draggable : true,
						title: "현장보고서 제출현황 상세보기",
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
		
		//현장 보고서 그래프 창 띄우기
		function openSiteChartDetail( p_type, p_key, p_date ){	//창타입, 키, 기준일자
			
			var url = "./siteChartDetailModal";
			var param = {};
			param.modalType = p_type;
			param.modalKey = p_key;
			param.modalDate = p_date;
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){		        	
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
				<%--검색 영역--%>
				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							<div style="float: left;">
								<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" >
								&nbsp;&nbsp;<b>일자별 현장보고서 제출현황</b>								
                           	</div>
                           
                           	<div style="text-align: right;">
								<a id="btn_year_prev" href="#noloc">
                                   <img src="./resources/ne_img/icon_prev.gif" width="17" height="13" border="0">
                               </a>
                               <a id="year_txt" href="#noloc;">${fn:substring(stdBgnde,0,4)}</a>
                               <a id="btn_year_next" href="#noloc">
                                   <img src="./resources/ne_img/icon_next.gif" width="17" height="13" border="0">
                               </a>
                               <c:forEach var="i" begin="1" end="12" step="1" varStatus="">
                                   <input id="${i}" class="monthbtn" type="button" value="${i}월" />
                               </c:forEach>
							</div>							                           
							<br/>
							<div>
								<b>기준일자 : </b><input type="text" id="stdBgnde"  name="stdBgnde" size="10"  value="${stdBgnde}" maxlength="10"/>&nbsp;
								<input class="btn-vacation-list-ins" type="button" onclick="javascript:fnSearch()" value="조회하기" style="background:#A9D0F5;width:100px;cursor:pointer;">
							</div>
							<form id="srchFrm" name="srchFrm" method="post" action="./getSiteReportDaily">
								<input type="hidden" id="viewType" name="viewType" value="${viewType}"/>
                               	<input type="hidden" id="searchDateVal" name="searchDateVal"/>
                               	<input type="hidden" id="excelYN" name="excelYN" value="N">
							</form>
						</div>
					</div>
				</div>				

				<div class="centercnt_bot2" style="margin:0 auto;">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li id="memberTab" class="on"><a href="#" onclick="javascript:showView('member');">개인별 제출 현황</a></li>
								<li id="teamTab"><a href="#" onclick="javascript:showView('team');">팀별 제출 현황</a></li>
								<li id="centerTab"><a href="#" onclick="javascript:showView('center');">센터별 제출 현황</a></li>
								<li id="sectorTab"><a href="#" onclick="javascript:showView('sector');">부문별 제출 현황</a></li>
							</ul>							
						</div>
						<div style="width:100%;padding:8px 0 0 0;">
							<div style="float: left;color:blue;font-weight:bold;">
								&#8251; 목록 내 기한내 제출율을 클릭하면 해당일자의 상세 정보를 확인할 수 있습니다.								
							</div>			
							<div style="text-align: right;">
								<a href="#noloc" id="btn_excel" onclick="javascript:doDownExcel();">
									<img src="./resources/ls_img/btn_excel.gif">
								</a>								
							</div>
						</div>				
						<div class="guestcnt2" style="display:block;" id="memberView">							
							<c:import url="./site_report_daily_member.jsp"></c:import>							
						</div>
						<div class="guestcnt2" style="display:none;" id="teamView">							
							<c:import url="./site_report_daily_team.jsp"></c:import>
						</div>						
						<div class="guestcnt2" style="display:none;" id="centerView">							
							<c:import url="./site_report_daily_center.jsp"></c:import>
						</div>
						<div class="guestcnt2" style="display:none" id="sectorView">
							<c:import url="./site_report_daily_sector.jsp"></c:import>
						</div>
					</div><!-- //guest -->
				</div><!-- centercnt_bot2 -->

			</div><!-- //center_cnt -->
		</div><!-- //contents -->
	</div><!-- //container -->
	
	<!-- 현장 보고서 상세보기 모달 -->	
	<div id="site-user-dialog" title="현장보고서 제출현황 상세보기" style="font-size: 12px;" align="center"></div>
	
	<!-- 현장 보고서 그래프 보기 모달 -->
	<div id="site-chart-dialog" title="현장보고서 제출현황 그래프 보기" style="font-size: 12px;" align="center"></div>
	
	<!-- footer -->
	<c:import url="../top_statistics/statistics_footer.jsp"></c:import>
	<!-- //footer -->

</div>
<!-- //wrapper -->

</body>

</html>
