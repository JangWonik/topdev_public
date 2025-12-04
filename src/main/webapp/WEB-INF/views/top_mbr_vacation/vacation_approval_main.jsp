<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/vertical.css" />
	
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	
	<script src="./resources/tooltipsy/tooltipsy.min.js"></script>
	
	<%--spiner start--%>
    <script src="/resources/jquery/spin.js"></script>
    <script src="/resources/jquery/jquery.spin.js"></script>
    <%--spiner end --%>
	
	<style>
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
								<li class="on" id="mainTab"><a href="#">휴가 결재 대상건 (${approvalListCnt} 건)</a></li>
								<li id="resultCnt"><a href="#">휴가 결재 내역</a></li>
								<li id="allMonthCnt"><a href="#">휴가 월별 사용 내역</a></li>								
								<li id="allCnt"><a href="#">휴가 전체 내역</a></li>
								<li id="allAnnualSetCnt"><a href="#">연차 부여 / 사용 현황</a></li>								
							</ul>
						</div>
						
						<div class="guestcnt8" id="aprvCnt" style="display:block;margin-top:0;" >
							<c:import url="./vacation_approval_list.jsp"></c:import>
						</div>						
						
						<div class="guestcnt8" id="resultList" style="display:none;" >
							<c:import url="/vacationApprovalResult" ></c:import>
						</div>
						
						<!-- 휴가사용 대장 시작 -->
						<div class="guestcnt8" id="vacation_history_list" style="display:none;"></div>						
						<!-- 휴가사용 대장 끝 -->
						
						<div class="guestcnt8" id="allList" style="display:none;" >
							<c:import url="/vacationApprovalAll" ></c:import>
						</div>
						<div class="guestcnt8" id="allAnnualSetList" style="display:none;" >
							<c:import url="/vacationAnnualSetAll" ></c:import>
						</div>
											
						<div id="vacation-detail-dialog" title="상세 보기" style="font-size: 15px;display:none;" align="center">
						</div>
						<script>
							$(document).ready(function(){
								
								$("#resultCnt").click(function(){									
									$("#resultList").show();
									$("#aprvCnt").hide();
									$("#allMonthList").hide();
									$("#allList").hide();
									$("#allAnnualSetList").hide();
								});
								
								$("#allCnt").click(function(){									
									$("#resultList").hide();
									$("#aprvCnt").hide();
									$("#allMonthList").hide();
									$("#allList").show();
									$("#allAnnualSetList").hide();
								});
								
								$("#allMonthCnt").click(function(){									
									$("#resultList").hide();
									$("#aprvCnt").hide();
									$("#allMonthList").show();
									$("#allList").hide();
									$("#allAnnualSetList").hide();
								});
								
								$("#allAnnualSetCnt").click(function(){									
									$("#resultList").hide();
									$("#aprvCnt").hide();
									$("#allMonthList").hide();
									$("#allList").hide();
									$("#allAnnualSetList").show();
								});
								
								$("#allMonthCnt").click(function(){									
									$("#resultList").hide();
									$("#aprvCnt").hide();
									$("#allMonthList").show();
									$("#allList").hide();
									$("#allAnnualSetList").hide();
									
									$("#top_loading").show();
									getHistoryList();
								});
								
								//휴가전제내역에서 검색을 한경우 탭을 이동한다.
								var viewType = '${view_type}';
								if( viewType == 'search' ){
									$("#resultList").hide();
									$("#aprvCnt").hide();
									$("#allMonthList").hide();
									$("#allList").show();									
									$("#allAnnualSetList").hide();
									
									$("#resultCnt").attr('class','');
									$("#allMonthCnt").attr('class','');
									$("#allCnt").attr('class','on');
									$("#mainTab").attr('class','');			
									$("#allAnnualSetCnt").attr('class','');
								}else if( viewType == 'result' ){
									$("#resultList").show();
									$("#aprvCnt").hide();
									$("#allMonthList").hide();
									$("#allList").show();
									$("#allAnnualSetList").hide();
									
									$("#resultCnt").attr('class','on');
									$("#allMonthCnt").attr('class','');
									$("#mainTab").attr('class','');
									$("#allCnt").attr('class','');
									$("#allAnnualSetCnt").attr('class','');
								}else if( viewType == 'annual'){
									$("#resultList").hide();
									$("#aprvCnt").hide();
									$("#allMonthList").hide();
									$("#allList").hide();
									$("#allAnnualSetList").show();
									
									$("#resultCnt").attr('class','');
									$("#allMonthCnt").attr('class','');
									$("#mainTab").attr('class','');
									$("#allCnt").attr('class','');
									$("#allAnnualSetCnt").attr('class','on');
								}else if(viewType == 'history'){
									$("#top_loading").show();
									
						        	$("#resultList").hide();
									$("#aprvCnt").hide();
									$("#allMonthList").show();
									$("#allList").hide();
									$("#allAnnualSetList").hide();
									
									$("#resultCnt").attr('class','');
									$("#allMonthCnt").attr('class','on');
									$("#mainTab").attr('class','');
									$("#allCnt").attr('class','');
									$("#allAnnualSetCnt").attr('class','');
									
									getHistoryList();
								}else{
									$("#resultList").hide();
									$("#aprvCnt").show();
									$("#allMonthList").hide();
									$("#allList").hide();
									$("#allAnnualSetList").hide();
									
									$("#resultCnt").attr('class','');
									$("#allMonthCnt").attr('class','');
									$("#mainTab").attr('class','on');
									$("#allCnt").attr('class','');
									$("#allAnnualSetCnt").attr('class','');
								}
								
								//휴가전체내역 엑셀 다운로드
								$("#approvalAllexcelBtn").click(function(){				
									$("#searchFrm").attr("action","vacationApprovalAllExcel");
									searchFrm.submit();
								});
								
								//휴가전체내역 엑셀 다운로드
								$("#approval-all-btn-search").click(function(){
									
									var srchSdateVal = $("#srch_sdate").val();
									var srchEdateVal = $("#srch_edate").val();
									
									//검색일자가 둘다 입력된 경우 시작일자와 종료일자 유효성 체크
									if( srchSdateVal != '' && srchEdateVal != '' ){
										if( dateChk( srchSdateVal,  srchEdateVal) ){
											alert('휴가기간 검색 시작일자가 종료일자보다 작거나 같아야 합니다. ');
											return;
										}
									}
									
									$("#searchFrm").attr("action","vacationApproval");
									searchFrm.submit();
								});
								
								//휴가결재 일괄처리
								$("#vacationBtn").click(function(){
									
									//체크박스 전체 수
									var totalChk = $('input:checkbox[name="chkVacationNo"]').length;
									
									//ajax로 넘길 invoice_no
									var arrList = new Array();
									
									//체크여부 확인
									var nChk = $("input:checkbox[name='chkVacationNo']:checked").length;									
									
									if( nChk == 0 ){
										alert("일괄결재 할 휴가 목록을 체크해주세요.");
										return;
									}else{
										var k = 0;
										for( var i=0; i < totalChk; i++){
											//체크표시된경우만 값을 넣는다.
											if( $("input:checkbox[id='chkVacationNo_"+i+"']").is(":checked") == true ){
												arrList[k] = $("input:checkbox[id='chkVacationNo_"+i+"']").val();
												k++;												
											}
										}
										
										var alertMsg = "총 "+k+"건의 휴가를 인사총무팀 승인으로 변경하시겠습니까?";
										
										if( !confirm(alertMsg) ){
											return;
										}
										
										//휴가 일괄결재										
										var url = "/actionVacationApprovalChk";
										
										var param = {};
										param.approvalVacationList = arrList;
										
										$("#top_loading").show();
										
										$.ajax({
											type: "POST",
											url: url,
											data: param,
											contentType: "application/x-www-form-urlencoded; charset=UTF-8",
											dataType: "JSON",
											traditional: true,						//배열허용
											timeout: 20000,
											success: function(data){
												alert(data.msg);
												$("#top_loading").hide();
												location.href="./vacationApproval";
											},
											error: function(e){
											    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
											    $("#top_loading").hide();
											}
											
										});
									}				
									
								});
								
							});
							
							/*	휴가사용 대장 불러오기*/		
							function getHistoryList(){		
								var formData = $("#historyFrm").serialize();
								$.ajax({
									type : "post",									
									url : "VacationUseHistory",
									data : formData,
									success : function(result){					
										$("#vacation_history_list").html(result);				
									},
									error: function (request, status, error) {			
										console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
									}
								});
							}
							
							//휴가사용대장 검색시
					        function doUselistSearch(){			
					        	$("#top_loading").show();
					        	$("#searchActionVal").val(1);
					        	getHistoryList();
					        }
							
							function updateNowApproval(serial_no){
								
								var url = "/vacationUpdateApprovalNowModal";		//현재결재자 수정페이지
								var param = {};
								param.serial_no = serial_no;
								
								$.ajax({
									type: "POST",
									url: url,
									data: param,
									contentType: "application/x-www-form-urlencoded; charset=UTF-8",
									timeout: 20000,
									dataType: "HTML", 
									success: function(data){
										
										$("#vacation-detail-dialog").html();
										$("#vacation-detail-dialog").html(data);										
										
										$("#approval_now").val($("#approval_now_val").val());
										
											$("#vacation-detail-dialog").dialog({
												height: 580,
												width: 800,
												closeOnEscape : true,
												draggable : true,
												title: "현재 결재자 수정",
												//buttons : modalButtons,
												modal: true,
												buttons:{
													"수정" : function(){
														if( confirm("선택한 결재자로 수정하시겠습니까?") ){															
															fnVacationApprovalNowUpdate();															
														}														
													},
													"닫기" : function(){
														$(this).dialog("close");
													}
												},
												overlay:{ opacity: 0., background: '#000000'}
											});
											
											$("#approval_now").select2({
							    				dropdownParent: $("#vacation-detail-dialog")	
							    			});
									},
									error: function(e){
									    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
									}
								    });
								
							}
							
							//휴가 결재 대상건 전체 체크박스 체크한 경우
							function fnAllChk(){																
								if($("#chkAll").is(":checked")){
									$("input[name='chkVacationNo']").prop("checked",true);
								}else{
									$("input[name='chkVacationNo']").prop("checked",false);				
								}			
							}
							
							//두날짜를 비교해서 시작일이 종료일보다 작으면 false, 크면 true
							function dateChk(startDate, endDate){			
								var sDate = new Date(startDate);
								var eDate = new Date(endDate);
								//날짜 비교
								if( sDate.getTime() > eDate.getTime() ){
									return true;
								}else{
									return false;
								}
							}
						</script>
					</div>
				</div>
				<!-- //centercnt_bot -->

			<!-- //center_cnt -->
			</div>
		</div>		
		<!-- //통합로딩바 -->
		<div id="top_loading" style="display: none;">
			<img id="loading-image" src="/resources/cmm/images/spinner.gif" alt="Loading..." />
		</div>
		<!-- //통합로딩바끝 -->
		<!-- //contents -->
	</div>
</div>
<!-- //wrapper -->
<script>
/* 페이지 이동 */
function fnGoPage(pageIdx) {	
    $("#pageIdx").val(pageIdx);    
	$("#listFrm").submit();				        
}

function fnGoResultPage(pageIdx) {	
    $("#pageIdxResult").val(pageIdx);    
	$("#resultFrm").submit();				        
}

function fnGoSearchPage(pageIdx) {	
    $("#pageIdxSearch").val(pageIdx);    
	$("#searchFrm").submit();
}

function fnGoAnnualPage(pageIdx) {	
    $("#pageIdxAnnual").val(pageIdx);    
	$("#annualFrm").submit();
}
</script>
</body>
</html>
