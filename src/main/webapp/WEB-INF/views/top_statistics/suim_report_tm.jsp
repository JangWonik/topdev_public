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
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>

	<script>
		//보험사별 목록페이지로 이동 
		function goInsuList(){
			srchFrm.action = "./getSuimReportTm";			
			srchFrm.view_type.value = 'Insu';
			$("#srchExcelYN").val("N");			
			srchFrm.submit();
		}
		
		//보험사별 세부페이지로 이동
		function goInsuDetail(type,ptnr_id,ptnr_nick){
			srchFrm.action = "./getSuimReportTm";			
			srchFrm.view_type.value = 'InsuDetail';
			srchFrm.ptnr_id.value = ptnr_id;
			srchFrm.ptnr_nick.value = ptnr_nick;
			srchFrm.insu_type.value = type;		//1종 4종 구분값
			$("#srchExcelYN").val("N");
			srchFrm.submit();
		}
	
		//팀의 개인 페이지로 이동 
		function goTeamMember(id, nm, type){
			srchFrm.action = "./getSuimReportTm";
			srchFrm.team_id.value = id;
			srchFrm.team_name.value = nm;
			srchFrm.team_type.value = type;
			srchFrm.view_type.value = 'Member';
			$("#srchExcelYN").val("N");
			//alert(id+" : "+nm+" : "+type+" : "+srchFrm.view_type.value );
			srchFrm.submit();
		}
		
		//팀록록 페이지로 이동
		function goTeamList(){
			$("#srchExcelYN").val("N");
			srchFrm.action = "./getSuimReportTm";			
			srchFrm.view_type.value = 'Team';			
			srchFrm.submit();
		}
		
		//개인 수임목록 페이지로 이동
		function goPersonList(id, name,team_name){
			$("#srchExcelYN").val("N");
			srchFrm.action = "./getSuimReportTm";			
			srchFrm.user_no.value = id;
			srchFrm.user_name.value = name;
			srchFrm.team_name.value = team_name;
			srchFrm.view_type.value = 'Person';			
			//alert("id="+srchFrm.user_no.value+" : "+srchFrm.user_name.value);			
			srchFrm.submit();
		}
		
		function popSuimDtl(suim_rpt_no, delDate){
			/* if(delDate < 0){
				alert("삭제된 보고서 입니다.");
				return;
			} */	
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=screen.availHeight;  //띄울 창의 높이 740
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			//창띄우기 전에 스크립트 초기화 by top3009
			localStorage.setItem('activeTab','1');
			window.open('suimRptBscDtl?suim_rpt_no='+suim_rpt_no, suim_rpt_no,'width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=yes,scrollbars=yes');
		}
		
		function viewPopup(reportNo,delDate){
			/* if(delDate > 0){
				alert("삭제된 보고서 입니다.");
				return;
			} */	
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
								&nbsp;&nbsp;<b>손해사정서 교부현황</b>&nbsp;&nbsp;
								<c:choose>
									<c:when test='${srchArg.menuId eq "old"}'>
										<font color="red">( 종결일자 기준 2025.09.31 이전 데이터 )</font>
									</c:when>
									<c:otherwise>
										<font color="blue">( 종결일자 기준 2025.09.31 이후 데이터 )</font>
									</c:otherwise>
								</c:choose>
								<!-- <font color="red">*주의* 접수건중 반송&취소건은 제외된 건수입니다!</font> -->
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
							<form id="srchFrm" name="srchFrm" method="post" action="./getSuimReportTm">
								<input type="hidden" id="menuId" name="menuId" value="${srchArg.menuId}"/>
								<input type="hidden" id="chkDate" name="chkDate" value="${srchArg.chkDate}"/>
								<input type="hidden" id="team_id" name="team_id" value="${team_id}"/>
								<input type="hidden" id="ptnr_id" name="ptnr_id" value="${ptnr_id}"/>
								<input type="hidden" id="ptnr_nick" name="ptnr_nick" value="${ptnr_nick}"/>
								<input type="hidden" id="insu_type" name="insu_type" value="${insu_type}"/>
								<input type="hidden" id="user_no" name="user_no" value="${user_no}"/>
								<input type="hidden" id="user_name" name="user_name" value="${user_name}"/>
								<input type="hidden" id="team_name" name="team_name" value="${team_name}"/>
								<input type="hidden" id="team_type" name="team_type" />
								<input type="hidden" id="view_type" name="view_type" value="${view_type}"/>
								<input type="hidden" id="viewFromDate" name="viewFromDate" value="${srchArg.stdBgnde}" />
								<input type="hidden" id="viewToDate" name="viewToDate" value="${srchArg.stdEndde}" />
				                                
                               	<input type="hidden" id="srchBasicYN" name="basicYN" value="${srchArg.basicYN}"/>
                               	<input type="hidden" id="srchPrimYN" name="primYN" value="${srchArg.primYN}"/>
                               	<input type="hidden" id="srchContractYN" name="contractYN" value="${srchArg.contractYN}"/>
                               	<input type="hidden" id="srchExcelYN" name="excelYN" value="N">	
                               	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="text" id="stdBgnde"  name="stdBgnde" size="10"  value="${srchArg.stdBgnde}" maxlength="10" readonly="readonly"/>
								<span style="color:#0066CC">부터</span>&nbsp;&nbsp;&nbsp;
								<input type="text" id="stdEndde"  name="stdEndde" size="10"  value="${srchArg.stdEndde}" maxlength="10" readonly="readonly"/>
								<span style="color:#0066CC">까지</span>&nbsp;&nbsp;&nbsp;
								<%-- <input type="checkbox" id="basicYN" <c:if test="${srchArg.basicYN == 'Y'}">checked</c:if> /> <label for="basicYN">기본수임</label>&nbsp;&nbsp;
								<input type="checkbox" id="primYN"  <c:if test="${srchArg.primYN == 'Y'}">checked</c:if> /> <label for="primYN">농작물</label>&nbsp;&nbsp; --%>								
								<input type="hidden" id="basicYN" value="Y"/>
								<input type="hidden" id="primYN"  value="Y"/>
								
								<select id="srchUserNo" name="srchUserNo">
									<option value="0"> - 직원검색 - </option>									
									<c:forEach items="${memberSelList}" var="item" >
										<%-- <option value="${item.userNo}">${item.userName}</option> --%>
										<option <c:if test="${ item.userNo eq user_no}" >selected</c:if>  value="${item.userNo}">${item.userName}</option>									
									</c:forEach>										
								</select>
								<a id="btn_search" href="#noloc">
									<img src="./resources/ne_img/icon_log_src.gif" width="110" height="22" border="0">
								</a>
								<p style="display: inline; float: right;">
									<c:if test="${mbrVo_Session.user_state eq 9}">
										<a id="btn_excel" href="#noloc">                                
		                                    <img src="./resources/ls_img/btn_excel.gif">
		                                </a>
	                                </c:if>
                                </p>
								<br>
							</form>
						</div>
					</div>
				</div>
				<c:choose>
					<c:when test="${view_type eq 'Insu'}">
						<div class="centercnt_bot2" style="margin:0 auto;">
							<div class="guest">
								<div class="guestTap">
									<ul>
										<li id="tabMenu1"><a href="#">팀별 교부현황</a></li>
										<li id="tabMenu2" class="on"><a href="#">보험사별 교부현황</a></li>
									</ul>
								</div>								
								<div class="guestcnt2">									
										<c:import url="./suim_report_insu.jsp"></c:import>									
								</div>
							</div>
						</div>								
					</c:when>
					<c:when test="${view_type eq 'InsuDetail'}">
						<div class="centercnt_bot2" style="margin:0 auto;">
							<div class="guest">
								<div class="guestTap">
									<ul>
										<li id="tabMenu1"><a href="#">팀별 교부현황</a></li>
										<li id="tabMenu2" class="on"><a href="#">보험사별 교부현황</a></li>
									</ul>
								</div>								
								<div class="guestcnt2">									
										<c:import url="./suim_report_insu_detail.jsp"></c:import>									
								</div>
							</div>
						</div>								
					</c:when>
					<c:otherwise>						
						<div class="centercnt_bot2" style="margin:0 auto;">
						<div class="guest">
							<div class="guestTap">
									<ul>
										<li id="tabMenu1" class="on"><a href="#">팀별 교부현황 (<span id="listCnt"></span>)</a></li>
										<li id="tabMenu2"><a href="#">보험사별 교부현황</a></li>
									</ul>
								</div>
								<div class="guestcnt2">
									<c:if test="${view_type eq 'Person'}">
										<c:import url="./suim_report_person.jsp"></c:import>
									</c:if>
									<c:if test="${view_type eq 'Member'}">
										<c:import url="./suim_report_mbr.jsp"></c:import>
									</c:if>
									<c:if test="${view_type eq 'Team'}">
										<c:import url="./suim_report_tm1.jsp"></c:import>
									</c:if>																							
								</div>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
				<%-- <div class="centercnt_bot2" style="margin:0 auto;">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<c:choose>
									<c:when test="${view_type eq 'Insu'}">
										<li id="tabMenu1"><a href="#">팀별 교부현황</a></li>
										<li id="tabMenu2" class="on"><a href="#">보험사별 교부현황</a></li>										
									</c:when>
									<c:otherwise>
										<li id="tabMenu1" class="on"><a href="#">팀별 교부현황 (<span id="listCnt"></span>)</a></li>
										<li id="tabMenu2"><a href="#">보험사별 교부현황</a></li>
									</c:otherwise>
								</c:choose>
							</ul>
						</div>
						<div class="guestcnt2" style="display:block;">
								<c:if test="${view_type eq 'Person'}">
									<c:import url="./suim_report_person.jsp"></c:import>
								</c:if>
								<c:if test="${view_type eq 'Member'}">
									<c:import url="./suim_report_mbr.jsp"></c:import>
								</c:if>
								<c:if test="${view_type eq 'Team'}">
									<c:import url="./suim_report_tm1.jsp"></c:import>
								</c:if>																							
						</div>
						<div class="guestcnt2" style="display:none;">
							<c:if test="${view_type eq 'Insu'}">							
								<c:import url="./suim_report_insu.jsp"></c:import>
							</c:if>							
						</div>						
					</div><!-- //guest -->
				</div><!-- centercnt_bot2 --> --%>
			</div><!-- //center_cnt -->
		</div><!-- //contents -->
	</div><!-- //container -->
	
	<script type='text/javascript'>	
	    $(document).ready(function () {
	    	
	    	if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_21}' == 0){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}    	
	    	
	    	_initButton();
			$("#listCnt").text($("#totCnt").val());			
			$("#srchUserNo").select2();			
			
	    });
	    
	    $("#tabMenu1").click(function(){
			$("#view_type").val('Team');
			goTeamList();			
		});
		
		$("#tabMenu2").click(function(){
			$("#top_loading").show();
			$("#view_type").val('Insu');
			goInsuList();			
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
	    
	    function fnExcel(){
	        //$("#srchExcelYN").val("Y");
	        var frm = document.getElementById("srchFrm");
	        frm.excelYN.value = "Y";
	        frm.action = "./getSuimReportTm";
	        frm.submit();
	    }
	
	    function fnSearch(){
	        //$("#loading").show();
	        
	        $("#srchExcelYN").val("N");
	        var frm = document.getElementById("srchFrm");
	        frm.action = "./getSuimReportTm";
	        
			//직원 선택 검색 추가
	    	if ( $("#srchUserNo").val() != 0){	            
	            frm.user_no.value = $("#srchUserNo").val();	            
	            frm.view_type.value = "Person";	          
	    	}			
			
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

	<!-- footer -->
	<c:import url="../top_statistics/statistics_footer.jsp"></c:import>
	<!-- //footer -->

</div>
<!-- //wrapper -->

</body>

</html>
