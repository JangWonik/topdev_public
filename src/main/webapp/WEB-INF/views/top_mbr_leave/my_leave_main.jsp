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
		.buttonEduView{
			width:100px;
			height:23px;
		    background-color:#3232FF;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
	</style>
	<script>
		$(document).ready(function(){
			_initBtn();			
			//$("#listFrm").submit();
			//fnSearch();
		});
		
		/* 검색 */
		function fnSearch(){			
			$("#listFrm").submit();
		}
		
		/* 휴직신청 게시글(자료실)페이지 이동 */
		function goBoard(p_brdNo, p_cateNo){
			$("#boardNo").val(p_brdNo);
			$("#cateSearch").val(p_cateNo);
			$("#brdForm").submit();			
		}
		
		/* 페이지 이동 */
		function fnGoPage(pageIdx) {
			
	        $("#pageIdx").val(pageIdx);
	        $("#listFrm").submit();	        
				        
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
			//휴직코드 설명 모달창
			$("#vacation_code_info").on("click", function(){				
				
				$("#vacation-code-dialog").dialog({
					height: 750,
					width: 850,
					closeOnEscape : true,
					draggable : false,					
					title: "휴직 설명",
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
				fnLeaveIns();
	        });
	        
	        //휴가 검색 버튼클릭
	        $("#myVacationSearch").on("click",function(){
	        	$("#listFrm").submit();	        	
	        });
	        
	        $(".btn-vacation-mod").on("click", function () {	        	
	        	
	        	var no = $(this).attr("data-vacation-no");
	        	var sdate = $("#sdate_"+no).val();
	        	var edate = $("#edate_"+no).val();	        	
	        	var leave_type = $("#leave_type_"+no).val();
	        	var leave_type_val = $("#leave_type_val_"+no).val();
	        	var leave_content = $("#leave_content_"+no).val();	        	
	        	var approval_state = $("#approval_state_"+no).val();
	        	var approval_state_val = $("#approval_state_val_"+no).val();	        	
	        	var leave_interval = $("#leave_interval_"+no).val();
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
	        	
     			//var msg = "<font color='red'> ※신청 상태가 아니므로 수정이 불가합니다.</font>";
				//stateValue += msg;
				$("#vacation_start_date").prop("disabled",true);
				$("#vacation_end_date").prop("disabled",true);				
				$("#leave_comment").prop("disabled",true);												

				if ( approval_state == 99 || approval_state == 10 ) {		//신청취소 또는 1차결재 대기가 아닌경우
					$("#return_comment_tr").hide();									
				} else {
					$("#return_comment_tr").show();
					$("#return_comment").html(approval_msg);
				}

				$("#leave_state").show();
				$("#leave_state_val").text(approval_state_val);
				$("#leave_start_date_val").text(sdate);
				$("#leave_end_date_val").text(edate);
				$("#leave_comment").val(leave_content);								
				$("#leave_mod_no").val(no);
				$("#leave_interval_val").text(leave_interval);
				$("#leaveIntervalVal").val(leave_interval);
				$("#form_type").val(form_type);
				
				$(".tr_leave_add").hide();
				$(".tr_leave_view").show();
				
				$("#leave_kind_val").text(leave_type_val);
				$("#leave_comment_val").text(leave_content);								
				$("#approval_state").val(approval_state);
				$("#leave_serial_no").val(no);
				$("#leave_type").val(leave_type);								

				fnLeaveMod();
			});
	        
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
								<li class="on" id="listTab"><a href="#">나의 휴직 신청 내역</a></li>								
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
									<a href="#noloc" class="btn-vacation-list-ins" id="btn-vacation-list-ins">휴직 신청</a>
								</div>
							</div>
							<div id="vacationListTable" class="tableStyle2" style="border-top: 0px;">
								<form id="listFrm" action="myLeaveMain" method="POST">
									<input type="hidden" id="pageIdx" name="pageIdx" />
									<input type="hidden" id="tab" name="tab" value="list" />
									<input type="hidden" id="form_type" name="form_type"/>
								<div id="vacation_code_info" style="cursor:pointer;">																										
								<table>									
									<tr>
										<th width="20%">휴직코드</th>
										<th width="30%">휴직유형</th>										
										<th width="50%">설명 [자세히]</th>
									</tr>
										<c:if test="${vCodeList.size() > 0 }">
											<c:forEach items="${vCodeList}" var="item" varStatus="status">
												<tr>
													<td>${item.leave_code}</td>
													<td>${item.leave_type}</td>													
													<td style="text-align:left;padding-left:10px;">${item.leave_content}</td>
												</tr>			
											</c:forEach>
										</c:if>
										<c:if test="${vCodeList.size() == 0 }">
											<tr>
												<td colspan="4">등록된 휴직 코드가 없습니다.</td>												
											</tr>
										</c:if>									
								</table>
								</div>								
								<br/>							
								
								<div style="float: left; height: 25px;" >
						       		<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">&nbsp;
						       		<b>휴직 사용내역</b>						       		
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
										<col width="10%" />
										<col width="30%" /> 
										<col width="10%" />										
										<col width="15%" />
										<col width="10%" />
										<col width="10%" />
										<col width="10%" />
									</colgroup>
									<thead>
										<tr>
											<th>No.</th>											
											<th>종류</th>
											<th>사유</th>
											<th>기간</th>
											<th>사용일</th>											
											<th>신청일</th>
											<th>상태</th>
											<th>비고</th>
										</tr>
									</thead>									
									<tbody>										
										<c:forEach items="${leaveList}" var="item" varStatus="status">
											<tr <c:if test="${item.next_use eq 1}"> style='background-color:#E5EBFF;' </c:if> >
												<td>${pageInfo.totalRecordCount - (pageInfo.recordCountPerPage * (pageInfo.currentPageNo-1)) - status.index}</td>
												<td>${item.leave_type_val}</td>
												<td style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">${item.leave_content}</td>												
												<td>${item.leave_interval} 일</td>
												<td style="letter-spacing: 0px;">${item.sdate} ~ ${item.edate}</td>
												<td>${item.regdate}</td>
												<td>${item.approval_state_val}</td>
												<td>
													<a href="#noloc" class="btn-vacation-mod" data-vacation-no="${item.serial_no}">상세보기</a>
													<input type="hidden" id="sdate_${item.serial_no}" value="${item.sdate}"/>
													<input type="hidden" id="edate_${item.serial_no}" value="${item.edate}"/>
													<input type="hidden" id="leave_type_${item.serial_no}" value="${item.leave_type}"/>
													<input type="hidden" id="leave_type_val_${item.serial_no}" value="${item.leave_type_val}"/>
													<input type="hidden" id="leave_content_${item.serial_no}" value="${item.leave_content}"/>
													<input type="hidden" id="approval_state_${item.serial_no}" value="${item.approval_state}"/>
													<input type="hidden" id="approval_state_val_${item.serial_no}" value="${item.approval_state_val}"/>													
													<input type="hidden" id="leave_interval_${item.serial_no}" value="${item.leave_interval}"/>
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
						        	<c:import url="/page_navi">
						            	<c:param name="beginIdx" value="${pageInfo.firstPageNoOnPageList}"/>
						                <c:param name="endIdx" value="${pageInfo.lastPageNoOnPageList}"/>
						                <c:param name="currentIdx" value="${pageInfo.currentPageNo}"/>
						                <c:param name="totalPageCnt" value="${pageInfo.totalPageCount}"/>
									</c:import>								
						      	</div>
						      	</form>	
							</div>
						</div>
						<!-- 휴가메인 목록 끝 -->
						
						<!-- 휴직 모달 창 시작 -->
						<div id="vacation-code-dialog" title="휴직 신청" style="font-size: 15px;display:none;" align="center">
							<br/>
							<div class="tableStyle2" style="width: 800px;">
								<table class="vacation-ins-table">									
									<tbody>													
										<tr>
											<th width="30%" colspan="2">구분</th>
											<th width="70%">설명</th>											
										</tr>
										<tr>
											<th colspan="2">육아휴직</th>
											<td style="text-align:left;padding-left: 10px;">남녀고용평등과 일&middot;가정양립지원에 관한 법률 제19조1항에 따른 육아휴직</td>											
										</tr>
										<tr>
											<th colspan="2">가족돌봄휴직</th>
											<td style="text-align:left;padding-left: 10px;">남녀고용평등과 일&middot;가정양립지원에 관한 법률 제22의 2에 따른 휴직</td>
										</tr>
										<!-- 산재휴직, 질병상해휴직 추가 시작-->
										<tr>
											<th colspan="2">산재승인휴직</th>
											<td style="text-align:left;padding-left: 10px;">산업재해보상보헙법상 업무상 재해(질병 등)으로 인정되어 산재가 승인된 기간에 대한 휴직</td>
										</tr>
										<tr>
											<th colspan="2">상해/질병휴직</th>
											<td style="text-align:left;padding-left: 10px;">산업재해보상보헙법상 업무상 재해(질병 등)를 제외한 상해/질병에 따른 휴직</td>
										</tr>
										<!-- 산재휴직, 질병상해휴직 추가 끝-->
										<tr>
											<th colspan="2">기타휴직</th>
											<td style="text-align:left;padding-left: 10px;">1~2항에 해당하지 아니하는 휴직(본인신청과 회사승인에 따른 휴직)</td>
										</tr>										
									</tbody>																																																							
								</table>
								<br/>
								<table class="vacation-ins-table">
									<tr>
										<td style="text-align:left;padding-left: 10px;">
											1. 육아휴직 : 인트라넷 휴직 신청 전 자료실 인사총무서식 <b>'2022년 인사서식 제12호 [육아휴직신청서]'</b> 서식 작성,<br/>상급자 서면 결재 상신 &nbsp;<input class='buttonEduView' onclick='javascript:goBoard(575,3);' type='button' value='자료실 바로가기'><br/>
											2. 가족돌봄휴직 : 인트라넷 휴직 신청 전 자료실 인사총무서식 <b>'2022년 인사서식 제13호 [가족돌봄휴직신청서]'</b> 서식 작성,<br/>상급자 서면 결재 상신 &nbsp;<input class='buttonEduView' onclick='javascript:goBoard(576,3);' type='button' value='자료실 바로가기'><br/>
											3. 산재승인휴직 : <br/>
											4. 상해/질병휴직 : <br/>
											5. 기타휴직 : 인트라넷 휴직 신청 전 자료실 인사총무서식 <b>'2022년 인사서식 제3호 [휴직신청서(육아휴직, 가족돌봄휴직 제외)]'</b> 서식 작성, <br/>상급자 서면 결재 상신 &nbsp;<input class='buttonEduView' onclick='javascript:goBoard(574,3);' type='button' value='자료실 바로가기'><br/>
											6. 휴직신청서 서면 결재 완료 후 인트라넷 휴직 신청(입력)
										</td>
									</tr>
								</table>
							</div>
						</div>
						<!-- 휴가 모달 창 끝 -->						
						
						<!-- 휴직 Action Modal  -->
						<%-- <c:import url="/vacationActionModalNew"></c:import> --%>
						<c:import url="/leaveActionModal"></c:import>
						<!-- //휴직 Action Modal  -->
						
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
	<!-- 게시글 이동 폼 시작-->
	<form id="brdForm" name="brdForm" action="referenceTopBoardDetailNew" target="_blank">
		<input type="hidden" name="boardNo" id="boardNo"/>
		<input type="hidden" name="cateSearch" id="cateSearch"/>
	</form>
	<!-- 게시글 이동 폼 끝-->
</body>
</html>