<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=2" />
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<script src="./resources/tooltipsy/tooltipsy.min.js"></script>
	
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	
	<script defer src="./resources/fontawesome_5.0/svg-with-js/js/fontawesome-all.js"></script>
	<style>
		.ui-button-text-only {
			height:2.1em !important;
		}
	</style>
	<script>
		$(document).ready(function(){
			_initBtn();
			
			/* 년도 변경시 수정*/		
			$("#selectYear").change( function(){				
				$("#selectAnnualYear").val($("#selectYear").val());
				$("#listFrm").submit();				
			});
			
		});
		
		/*	휴가사용 대장 불러오기*/		
		function getMyHistoryList(){		
			var formData = $("#historyFrm").serialize();			
			
			$.ajax({
				type : "post",
				//url : "./ajax/ajax_lotte_jemul",
				url : "VacationUseMyHistory",
				data : formData,
				success : function(result){					
					$("#vacation_history_list").html(result);				
				},
				error: function (request, status, error) {			
					console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
				}
			});
		}
		
		/* 페이지 이동 */
		function fnGoPage(pageIdx) {
			
	        $("#pageIdx").val(pageIdx);
	        $("#listFrm").submit();	        
				        
	    }
		
		/* 검색 */
		function fnSearch(){			
	        var param = {};
	        param.pageIdx 	= $("#currPageIdx").val();
	        param.srchYear 	= $("#srchYear option:selected").val();
	       	param.srchKind 	= $("#srchKind option:selected").val();
      		param.srchState = $("#srchState option:selected").val();		
      		fnAction(param);
		}
		
		/* 페이지 Reload Ajax (검색, 페이지이동) */
		function fnAction(param){
			var url = "/myVacationListNew";
			
		    $.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "HTML", 
		        success: function(data){
		        	$("#listCnt").html();
		        	$("#listCnt").html(data);
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });			
		}
		
		function _initBtn(){
			
			//휴가코드 설명 모달창
			$("#vacation_code_info").on("click", function(){				
				
				$("#vacation-code-dialog").dialog({
					height: 630,
					width: 700,
					closeOnEscape : true,
					draggable : false,					
					title: "휴가 설명",
					buttons:{						
						"닫기" : function(){
							$(this).dialog("close");
						}
					},
					modal: true,
					overlay:{ opacity: 0., background: '#000000'}
				});
				
			});
			
	        $("#btn-vacation-list-ins").on("click", function () {	        	
				fnVacationIns();
	        });
	        
	        //휴가 검색 버튼클릭
	        $("#myVacationSearch").on("click",function(){
	        	$("#listFrm").submit();	        	
	        });
	        
	        $("#btn-search").on("click", function () {	        	
	        	fnSearch();
	        });
	        
	        $(".btn-vacation-mod").on("click", function () {
	        	
	        	var no = $(this).attr("data-vacation-no");
	        	var sdate = $("#sdate_"+no).val();
	        	var edate = $("#edate_"+no).val();	        	
	        	var vacation_type = $("#vacation_type_"+no).val();
	        	var vacation_type_val = $("#vacation_type_val_"+no).val();
	        	var vacation_option = $("#vacation_option_val_"+no).val();
	        	var vacation_content = $("#vacation_content_"+no).val();	        	
	        	var approval_state = $("#approval_state_"+no).val();
	        	var approval_state_val = $("#approval_state_val_"+no).val();
	        	var vacation_org_file = $("#vacation_org_file_"+no).val();
	        	var vacation_enc_file = $("#vacation_enc_file_"+no).val();
	        	var vacation_interval = $("#vacation_interval_"+no).val();
	        	var approval_comment_val = $("#approval_comment_val_"+no).val();
	        	
	        	var approvaler_01 =  $("#approvaler_01_"+no).val();
	        	var approvaler_02 =  $("#approvaler_02_"+no).val();
	        	var approvaler_03 =  $("#approvaler_03_"+no).val();	        	
	        	var ap_date_01 = $("#ap_date_01_"+no).val();
	        	var ap_date_02 = $("#ap_date_02_"+no).val();
	        	var ap_date_03 = $("#ap_date_03_"+no).val();	        	
	        	var ap_comment_01 = $("#ap_comment_01_"+no).val();
	        	var ap_comment_02 = $("#ap_comment_02_"+no).val();
	        	var ap_comment_03 = $("#ap_comment_03_"+no).val();
	        	
	        	var form_type = "View";	        	
	        	
	        	//결재정보 msg 만들기
	        	var approval_msg = "";
	        	
	        	if( approval_state == 31  ){
	        		if( ap_date_01 != "" ){
	        			approval_msg += "[1차 결재 승인]  "+approvaler_01+" ("+ap_date_01+") "+ap_comment_01+"<br/>";
	        			approval_msg += "<font color='blue'>[인사총무팀 승인]  "+approvaler_03+" ("+ap_date_03+") "+ap_comment_03+"</font>";	        			
	        		}else{
	        			approval_msg += "<font color='blue'>[결재 승인]  "+approvaler_03+" ("+ap_date_03+") "+ap_comment_03+"</font>";
	        		}
	        	}else if( approval_state == 32 ){
	        		approval_msg += "<font color='red'>[결재 반려]  "+approvaler_03+" ("+ap_date_03+") "+ap_comment_03+"</font>";
	        	}
	        	
	        	/** 2차결재 제거
	        	if( approval_state == 20 ){		//2차 승인대기
	        		if( ap_date_01 != ""){
	        			approval_msg += "<font color='blue'>[1차 결재 승인] "+approvaler_01+" ("+ap_date_01+") "+ap_comment_01+"</font>";	
	        		}	        		
	        	}else if( approval_state == 30 ){		//최종 승인대기
	        		if( ap_date_01 != ""){
	        			approval_msg += "[1차 결재 승인]  "+approvaler_01+" ("+ap_date_01+") "+ap_comment_01+"<br/>";	
	        		}
	        		if( ap_date_02 != ""){
	        			approval_msg += "<font color='blue'>[2차 승인] "+approvaler_02+" ("+ap_date_02+") "+ap_comment_02+"</font>";	
	        		}	        		
	        	}else if( approval_state == 31 ){		//최종승인
	        		if( ap_date_01 != ""){
	        			approval_msg += "[1차 결재 승인]  "+approvaler_01+" ("+ap_date_01+") "+ap_comment_01+"<br/>";	
	        		}
	        		if( ap_date_02 != ""){
	        			approval_msg += "[2차 승인]  "+approvaler_02+" ("+ap_date_02+") "+ap_comment_02+"<br/>";	
	        		}
	        		if( ap_date_03 != ""){
	        			approval_msg += "<font color='blue'>[인사총무팀 승인]  "+approvaler_03+" ("+ap_date_03+") "+ap_comment_03+"</font>";	
	        		}
	        	}else if( approval_state == 12 ){		//결재 반려
	        		if( ap_date_01 != ""){
	        			approval_msg += "<font color='red'>[1차 결재 반려] "+approvaler_01+" ("+ap_date_01+") "+ap_comment_01+"</font>";
	        		}
	        	}else if( approval_state == 22 ){		//2차 반려
	        		if( ap_date_01 != ""){
	        			approval_msg += "[1차 결재 승인]  "+approvaler_01+" ("+ap_date_01+") "+ap_comment_01+"<br/>";	
	        		}
	        		approval_msg += "<font color='red'>[2차 반려] "+approvaler_02+" ("+ap_date_02+") "+ap_comment_02+"</font>";
	        	}else if( approval_state == 32 ){		//최종 반려
	        		if( ap_date_01 != ""){
	        			approval_msg += "[1차 결재 승인]  "+approvaler_01+" ("+ap_date_01+") "+ap_comment_01+"<br/>";	
	        		}	        		
	        		if( ap_date_02 != ""){
	        			approval_msg += "[2차 승인]  "+approvaler_02+" ("+ap_date_02+") "+ap_comment_02+"<br/>";	
	        		}	        		
	        		approval_msg += "<font color='red'>[인사총무팀 반려]  "+approvaler_03+" ("+ap_date_03+") "+ap_comment_03+"</font>";
	        	}
	        	**/
	        	
	        	//alert("approval_msg="+approval_msg);
	        	
	        	//var vacation_comment_val = $("#vacation_comment_val_"+no).val();
	        	//var kind = $("#vacationKind_"+no).val();	        	
	        	//var chkVal = $("#checkedVacationVal").val();	        	
		
				/* console.log("no=" + no + " : sdate="
												+ sdate + " : edate=" + edate
												+ " : vacation_type=" + vacation_type
												+ " : vacation_type_val=" + vacation_type_val
												+ " : vacation_content=" + vacation_content
												+ " : approval_state=" + approval_state
												+ " : approval_state_val=" + approval_state_val
												+ " : vacation_org_file=" + vacation_org_file
												+ " : vacation_enc_file=" + vacation_enc_file); */

								
								//var msg = "<font color='red'> ※신청 상태가 아니므로 수정이 불가합니다.</font>";
								//stateValue += msg;
								$("#vacation_start_date").prop("disabled",true);
								$("#vacation_end_date").prop("disabled",true);
								$("#vacation_comment").prop("disabled",true);									
								$(".btn_file_del").hide();								

								if ( approval_state == 99 || approval_state == 10 ) {		//신청취소 또는 1차결재 대기가 아닌경우
									$("#return_comment_tr").hide();									
								} else {
									$("#return_comment_tr").show();
									$("#return_comment").html(approval_msg);
								}

								//예비군(민방위) 파일 다운로드 활성화								
								if( vacation_type == '700' ){
									$(".tr_vacation_file_view").show();
									$("#file_name_val").html(vacation_org_file);
									
									var href = "/vacationFileDownNew?serial_no="+ no;
									$("#file_name_val").closest("a").attr("href",href);									
								}else{
									$(".tr_vacation_file_view").hide();
								}								

								$("#vacation_state").show();
								$("#vacation_state_val").text(approval_state_val);
								$("#vacation_start_date_val").text(sdate);
								$("#vacation_end_date_val").text(edate);
								$("#vacation_comment").val(vacation_content);								
								$("#vacation_mod_no").val(no);
								$("#vacation_interval_val").text(vacation_interval);
								$("#vacationIntervalVal").val(vacation_interval);
								$("#form_type").val(form_type);
								
								$(".tr_vacation_add").hide();
								$(".tr_vacation_view").show();								
								
								//반차, 반반차 시간설정이 있으면 앞에 표시해준다.
								if( '' != vacation_option ){
									$("#vacation_kind_val").text("["+vacation_option+"] "+vacation_type_val);
								}else{
									$("#vacation_kind_val").text(vacation_type_val);	
								}
								$("#vacation_comment_val").text(vacation_content);								
								$("#approval_state").val(approval_state);
								$("#vacation_serial_no").val(no);
								$("#vacation_type").val(vacation_type);								

								fnVacationMod( no );
							});
	        
	        
	        //휴가사용대장선택시
	        $("#historyTab").click(function(){
	        	//휴가사용대장을 불러온다.
	        	//$("#top_loading").show();
	        	//getHistoryList();
	        	getMyHistoryList();		//나의 휴가사용대장으로 변경
	        });
		}
		
		//휴가사용대장 검색시 (사용안함)
        function doUselistSearch(){
			//완료후 열어
        	//$("#top_loading").show();
        	//getHistoryList();
        	getMyHistoryList();
        }
	</script>	
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
								<li class="on" id="listTab"><a href="#">나의 휴가 신청 내역</a></li>
								<li id="historyTab"><a href="#">나의 휴가 사용 대장</a></li>															
							</ul>
						</div>
						<!-- 휴가메인 목록 시작 -->
						<div class="guestcnt8" style="display:block;" id="listCnt">
							<div style="float: left; height: 25px;" >
					       		<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">&nbsp;
					       		<b>${mbrVo_Session.team_name} ${mbrVo_Session.user_name}</b>
							</div>
							<div style="float: right;">
								<div style="text-align: right;">
									<a href="#noloc" class="btn-vacation-list-ins" id="btn-vacation-list-ins">휴가 신청</a>
								</div>
							</div>
							<div id="vacationListTable" class="tableStyle2" style="border-top: 0px;">
								<form id="listFrm" action="myVacationMainNew" method="POST">
									<input type="hidden" id="pageIdx" name="pageIdx" />
									<input type="hidden" id="tab" name="tab" value="list" />
									<!-- <input type="hidden" id="selectYearVal" name="selectYearVal"/> -->
									<!-- 연차선택년도 -->
									<input type="hidden" id="selectAnnualYear" name="selectAnnualYear" value="${selectAnnualYear}"/>									
									<input type="hidden" id="form_type" name="form_type"/>
								<div id="vacation_code_info" style="cursor:pointer;">																										
								<table>									
									<tr>
										<th width="15%">휴무코드</th>
										<th width="20%">휴무명</th>
										<th width="15%">연차차감</th>
										<th width="50%">설명 [자세히]</th>
									</tr>
										<c:if test="${vCodeList.size() > 0 }">
											<c:forEach items="${vCodeList}" var="item" varStatus="status">
												<c:choose>
													<c:when test="${mbrVo_Session.team_type eq 4}">
														<c:if test="${item.vacation_code ne '200' && item.vacation_code ne '210'}">
															<tr>
																<td>${item.vacation_code}</td>
																<td>${item.vacation_type}</td>
																<td>${item.vacation_point}</td>
																<td style="text-align:left;padding-left:10px;">${item.vacation_content}</td>
															</tr>
														</c:if>
													</c:when>
													<c:otherwise>
														<tr>
															<td>${item.vacation_code}</td>
															<td>${item.vacation_type}</td>
															<td>${item.vacation_point}</td>
															<td style="text-align:left;padding-left:10px;">${item.vacation_content}</td>
														</tr>	
													</c:otherwise>
												</c:choose>			
											</c:forEach>
										</c:if>
										<c:if test="${vCodeList.size() == 0 }">
											<tr>
												<td colspan="4">등록된 휴가 코드가 없습니다.</td>												
											</tr>
										</c:if>									
								</table>
								</div>								
								<br/>								
								<!-- 개인휴가 사용수 시작 -->
								<div style="float: left; height: 25px;" >
						       		<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">&nbsp;
						       		<b>연차 발생내역</b>
								</div>
								<table>									
									<tr>
										<th>연차 발생 년도</th>
										<th>연차 부여 일수</th>
										<th>연차 사용 일수</th>
										<th>연차 잔여 일수</th>										
									</tr>
									<tr>
										<td>
											<!-- 현재부터 2018년까지로 변경 by top3009-->											
											<jsp:useBean id="now" class="java.util.Date" />
											<fmt:formatDate value="${now}" pattern="yyyy" var="yearVar"/>																	 
											<select id="selectYear">																															
												<c:forEach begin="0" end="${yearVar-2018}" var="result" step="1">
													<option value="${yearVar - result}" <c:if test="${selectAnnualYear == (yearVar-result) }">selected="selected"</c:if>>${yearVar-result} 년</option>							
												</c:forEach>
											</select>
											<!-- 현재부터 2018년까지로 변경 끝 by top3009-->
										</td>
										<c:choose>
											<c:when test="${empty vacation}">
												<td colspan="3">해당 년도에 할당 된 연차가 없습니다. (당해년도 입사일전인 경우 작년도 연차를 확인하세요.)</td>
											</c:when>
											<c:otherwise>
												<td>${vacation.annual_set}<%-- <fmt:formatNumber value="${vacation.annual_set}" pattern="0.00"/> --%> 일</td>
												<td><fmt:formatNumber value="${vacation.annual_use}" pattern="0.00"/> 일</td>
												<td><%-- ${vacation.annual_set - vacation.annual_use} --%><fmt:formatNumber value="${vacation.annual_set - vacation.annual_use}" pattern="0.00"/> 일</td>
											</c:otherwise>
										</c:choose>
									</tr>
								</table>
								<br/>															
								<!-- 개인휴가 사용수 끝 -->
								
								<div style="float: left; height: 25px;" >
						       		<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">&nbsp;
						       		<b>휴가 사용내역</b> (선연차 사용분은 파란배경으로 표시됩니다.)						       		
								</div>
								<div style="float: right; height: 25px;" >								
									<input type="text" class="classCalendar" id="searchStartDate" name="searchStartDate" size="10" value="${searchStartDate}" />
									~&nbsp;<input type="text" class="classCalendar" id="searchEndDate" name="searchEndDate" size="10" value="${searchEndDate}" />
									&nbsp;
									<a href="#noloc" class="btn-vacation-list-ins" id="myVacationSearch">조회</a>									
								</div>								
								<table style="width:100%">
									<colgroup>
										<col width="5%" />
										<col width="5%" />
										<col width="10%" /> 
										<col width="25%" />
										<col width="15%" />
										<col width="10%" />
										<col width="10%" />
										<col width="10%" />
										<col width="10%" />
									</colgroup>
									<thead>
										<tr>
											<th>No.</th>
											<th>년도</th>
											<th>종류</th>
											<th>사유</th>
											<th>기간</th>
											<th>사용일</th>
											<th>차감일</th>
											<th>상태</th>
											<th>비고</th>
										</tr>
									</thead>									
									<tbody>										
										<c:forEach items="${vacationList}" var="item" varStatus="status">
											<tr <c:if test="${item.next_use eq 1}"> style='background-color:#E5EBFF;' </c:if> >
												<td>${pageInfo.totalRecordCount - (pageInfo.recordCountPerPage * (pageInfo.currentPageNo-1)) - status.index}</td>												
												<td>${item.base_year} 년</td>
												<td title="${item.vacation_option_val}">${item.vacation_type_val}</td>
												<td style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">${item.vacation_content}</td>
												<td style="letter-spacing: 0px;">${item.sdate} ~ ${item.edate}</td>
												<td>${item.vacation_interval} 일</td>
												<td>
													<c:choose>
														<c:when test="${item.vacation_type eq 100 or item.vacation_type eq 200 or item.vacation_type eq 210}">
															${item.vacation_interval} 일
														</c:when>
														<c:otherwise>
															0.0 일
														</c:otherwise>
													</c:choose>												
												</td>
												<td>${item.approval_state_val}</td>
												<td>
													<a href="#noloc" class="btn-vacation-mod" data-vacation-no="${item.serial_no}">상세보기</a>
													<input type="hidden" id="sdate_${item.serial_no}" value="${item.sdate}"/>
													<input type="hidden" id="edate_${item.serial_no}" value="${item.edate}"/>
													<input type="hidden" id="vacation_type_${item.serial_no}" value="${item.vacation_type}"/>
													<input type="hidden" id="vacation_type_val_${item.serial_no}" value="${item.vacation_type_val}"/>
													<input type="hidden" id="vacation_option_val_${item.serial_no}" value="${item.vacation_option_val}"/>
													<input type="hidden" id="vacation_content_${item.serial_no}" value="${item.vacation_content}"/>
													<input type="hidden" id="approval_state_${item.serial_no}" value="${item.approval_state}"/>
													<input type="hidden" id="approval_state_val_${item.serial_no}" value="${item.approval_state_val}"/>													
													<%-- <input type="hidden" id="approval_comment_val_${item.serial_no}" value="${item.approval_comment_val}"/> --%>													
													<input type="hidden" id="vacation_enc_file_${item.serial_no}" value="${item.vacation_enc_file}"/>
													<input type="hidden" id="vacation_org_file_${item.serial_no}" value="${item.vacation_org_file}"/>
													<input type="hidden" id="vacation_interval_${item.serial_no}" value="${item.vacation_interval}"/>
													<!-- 결재자정보관련 입력폼 -->
													<input type="hidden" id="approvaler_01_${item.serial_no}" value="${item.approvaler_01}"/>													
													<input type="hidden" id="approvaler_02_${item.serial_no}" value="${item.approvaler_02}"/>
													<input type="hidden" id="approvaler_03_${item.serial_no}" value="${item.approvaler_03}"/>
													<input type="hidden" id="ap_date_01_${item.serial_no}" value="${item.ap_date_01}"/>
													<input type="hidden" id="ap_date_02_${item.serial_no}" value="${item.ap_date_02}"/>
													<input type="hidden" id="ap_date_03_${item.serial_no}" value="${item.ap_date_03}"/>
													<input type="hidden" id="ap_comment_01_${item.serial_no}" value="${item.ap_comment_01}"/>
													<input type="hidden" id="ap_comment_02_${item.serial_no}" value="${item.ap_comment_02}"/>
													<input type="hidden" id="ap_comment_03_${item.serial_no}" value="${item.ap_comment_03}"/>
																										
													<input type="hidden" id="currPageIdx" value="${pageInfo.currentPageNo}"/>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<div class="pagingWrap">
						    	<%--<div class="pageContent">--%>
						        	<c:import url="/page_navi">
						            	<c:param name="beginIdx" value="${pageInfo.firstPageNoOnPageList}"/>
						                <c:param name="endIdx" value="${pageInfo.lastPageNoOnPageList}"/>
						                <c:param name="currentIdx" value="${pageInfo.currentPageNo}"/>
						                <c:param name="totalPageCnt" value="${pageInfo.totalPageCount}"/>
									</c:import>
								<%--</div>--%>
						      	</div>
						      	</form>	
							</div>
						</div>
						<!-- 휴가메인 목록 끝 -->
						
						<!-- 휴가 모달 창 시작 -->
						<div id="vacation-code-dialog" title="휴가 신청" style="font-size: 15px;display:none;" align="center">
							<br/>
							<div class="tableStyle2" style="width: 650px;">
								<table class="vacation-ins-table">									
									<tbody>													
										<tr>
											<th width="30%" colspan="2">구분</th>
											<th width="70%">설명</th>											
										</tr>
										<tr>
											<th rowspan="3">경조사</th>
											<th>결혼</th>
											<td style="text-align:left;padding-left: 10px;">본인 5일</td>
										</tr>
										<!-- <tr>
											<th>회갑</th>
											<td style="text-align:left;padding-left: 10px;">본인 및 배우자 2일 / 본인 및 배우자의 부모 1일</td>
										</tr> -->
										<tr>
											<th rowspan="2">사망</th>
											<td style="text-align:left;padding-left: 10px;">배우자 7일 / 본인 및 배우자의 부모 5일 / 본인 및 배우자의 형제자매 3일</td>
										</tr>		
										<tr>
											<td style="text-align:left;padding-left: 10px;">본인 및 배우자의 조부모 2일</td>
										</tr>
										<!-- <tr>
											<th>탈상</th>
											<td style="text-align:left;padding-left: 10px;">배우자 2일 / 본인 및 배우자의 부모 1일 / 본인의 형제자매 1일</td>											
										</tr> -->
										<!-- <tr>
											<th>기타</th>
											<td style="text-align:left;padding-left: 10px;">가정의 중대한 재난 1~3일</td>											
										</tr> -->
										<tr>
											<th colspan="2">배우자 출산</th>
											<td style="text-align:left;padding-left: 10px;">출산(예정)일부터 120일이내 20일 사용(120일이내 3회 분할사용 가능)</td>											
										</tr>
										<tr>
											<th colspan="2" rowspan="2">출산전&middot;후</th>
											<td style="text-align:left;padding-left: 10px;">산&middot;전후 90일(다태아를 임신한 경우 120일)</td>											
										</tr>
										<tr>
											<td style="text-align:left;padding-left: 10px;">(단, 출산 후 45일(다태아 임신의 경우 60일)이상 부여)</td>
										</tr>
										<tr>
											<th colspan="2" rowspan="2">유&middot;사산</th>
											<td style="text-align:left;padding-left: 10px;">임신기간이 11주 이내 5일 / 12주 ~ 15주이내 10일 / 16주 ~ 21주 이내 30일</td>											
										</tr>
										<tr>
											<td style="text-align:left;padding-left: 10px;">22주 ~ 27주 이내 60일 / 29주 이상 90일(단, 모자보건법 14조가 허용하는 사유일 경우)</td>
										</tr>
									</tbody>																																																							
								</table>
							</div>
						</div>
						<!-- 휴가 모달 창 끝 -->
						<!-- 휴가사용 대장 시작 -->
						<div id="vacation_history_list"></div>						
						<!-- 휴가사용 대장 끝 -->
						
						<!-- 휴가 Action Modal  -->
						<c:import url="/vacationActionModalNew"></c:import>
						<!-- //휴가 Action Modal  -->
						
						<!-- 휴가 Action Modal  -->
						<div id="my_vacation_modal_detail"></div>
						<%-- <c:import url="/myVacationModalDetail"></c:import> --%>
						<!-- //휴가 Action Modal  -->						
					</div>
				</div>	
			</div>		
		</div>
	</div>
	<!-- footer -->
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->
	<!-- //통합로딩바 -->
	<div id="top_loading" style="display: none;">
		<img id="loading-image" src="/resources/cmm/images/spinner.gif" alt="Loading..." />
	</div>
	<!-- //통합로딩바끝 -->
</body>
</html>