<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

	<style>
		.td-overflow-none{
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
		}
		
		.vacation-ins-table tr{
			height: 50px;
		}
		.vacation-ins-kind li {
			float:left;			
			width:100px;
			padding:0 10px; 	
			text-align: left;
		}
		.ui-button-text-only {
			height:2.1em !important;
		}
		
		.vacation-btn {
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
			width:63px;
			height:0px;
			padding:13px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
		}

		.vacation-btn:active {
			position:relative;
			top:4px
		}
		
	</style>	
	
	<form id="leaveActionFrm">
	
		<!-- 기존 파라미터 시작 -->
		<input type="hidden" id="leave_user_no"  name="leave_user_no" value="${srchParam.userNo}" />
		<input type="hidden" id="leave_team_id" name="leave_team_id" value="${srchParam.teamId}" />
		<input type="hidden" id="leave_team_type" name="leave_team_type" value="${srchParam.teamType}" />				
		<input type="hidden" id="leave_cnt" name="leave_cnt" value="0" />		
		<input type="hidden" id="leave_mod_no" name="leave_mod_no" value=""/>
		<input type="hidden" id="leave_mod_state" name="leave_mod_state" />
		<!-- 기존 파라미터 끝 -->
		<!-- 신규 파라미터 시작 -->
		<input type="hidden" id="checkedLeaveVal" name="checkedLeaveVal" />
		<input type="hidden" id="vacationIntervalVal" name="vacationIntervalVal" />
		<input type="hidden" id="leaveIntervalVal" name="leaveIntervalVal" />				
		<input type="hidden" id="approval_state" name="approval_state"/>	
		<input type="hidden" id="leave_serial_no" name="leave_serial_no"/>		
		<input type="hidden" id="leave_type" name="leave_type"/>
		<input type="hidden" id="notApproval" name="notApproval" value="${notApproval}"/>
		<!-- 신규 파라미터 끝 -->
					
		<!-- 수정후 신규 파라미터 시작 -->
		<!-- 기본(1차결재자) -->
		<input type="hidden" id="approvaler_01" name="approvaler_01" value="${approvaler_01}"/>
		<input type="hidden" id="approvaler_03" name="approvaler_03" value="${approvaler_03}"/>
		<!-- 결재자유무(1:최종결재단계로 넘어감, 0:결재1차) -->
		<input type="hidden" id="pass_approval" name="pass_approval" value="${pass_approval}"/>		
		<!-- 수정후 신규 파라미터 끝 -->
		<div id="leave-action-dialog" title="휴직 신청" style="font-size: 15px;display:none;" align="center">
			<br/>
			<div class="tableStyle2" style="width: 780px;">
				<table class="vacation-ins-table">					
					<tbody>					
						<tr id="leave_state">
							<th>결재상태</th>
							<td style="text-align:left;padding-left: 30px;font-weight:bold;" colspan="4">
								<span id="leave_state_val"></span>
							</td>											
						</tr>
						
						<tr class="tr_leave_add">
							<th>휴직유형</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<input type="radio" name="leave_kind" id="leave_kind_0" value="1001" checked="checked"> 육아휴직 &nbsp;								
								<input type="radio" name="leave_kind" id="leave_kind_1" value="2001"> 가족돌봄휴직 &nbsp;
								<!-- 산재휴직 질병상해휴직 추가 -->
								<input type="radio" name="leave_kind" id="leave_kind_2" value="3001"> 산재승인휴직 &nbsp;
								<input type="radio" name="leave_kind" id="leave_kind_3" value="4001"> 상해/질병휴직 &nbsp;
								<input type="radio" name="leave_kind" id="leave_kind_4" value="9001"> 기타 휴직
							</td>
						</tr>
						
						<tr class="tr_leave_add">
							<th>휴직안내</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">								
								<span id="leave_info_text"><b>육아휴직</b> : 남녀고용평등과 일&middot;가정양립지원에 관한 법률 제19조1항에 따른 육아휴직 (최대 1년) </span>
							</td>
						</tr>
						
						<tr class="tr_leave_add">
							<th>사유</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<input type="text" id="leave_comment" name="leave_comment" style="width:480px;" />								
							</td>
						</tr>
						
						<tr class="tr_leave_add">
							<th>기간</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<input type="text" class="classCalendar" id="leave_start_date" name="leave_start_date" style="width: 100px;"/>
								&nbsp;~&nbsp;
								<input type="text" class="classCalendar" id="leave_end_date" name="leave_end_date" style="width: 100px;"/>
								&nbsp; <!-- <font style="font-weight:bold;color:blue;">( 근무일 기준 : <span id="vacation_interval">0</span> ) 일</font> &nbsp; -->
								<font style="font-weight:bold;color:green;">( 총 : <span id="leave_interval_all">0</span> ) 일</font>  								
							</td>
						</tr>
						
						<tr  class="tr_leave_add">
							<th rowspan="2">결재</th>	
							<c:choose>
								<c:when test="${pass_approval eq '1'}">
									<th colspan="4">최종 확인</th>
								</c:when>
								<c:otherwise>
									<th colspan="2">결재자</th>							
									<th colspan="2">최종 확인</th>	
								</c:otherwise>
							</c:choose>			
						</tr>
						
						<tr class="tr_leave_add">
							<c:choose>
							<%-- 최종결재자만 표시되는 경우--%>
							<c:when test="${pass_approval eq '1' }">
								<td colspan="4">
									<c:choose>
										<c:when test="${approvalList3.size() > 0}">
											인사총무팀
											<%-- <c:forEach items="${approvalList3}" var="item" varStatus="status">
												${item.user_name} <br/>
											</c:forEach> --%>
										</c:when>
										<c:otherwise>
											최종 확인자가 없습니다.
										</c:otherwise>
									</c:choose>
								</td>
							</c:when>
							<c:otherwise>
								<%-- 결재자 --%>								
								<td colspan="2">
									${approvaler_name_01}
								</td>
								<%-- 최종결재자 --%>
								<td colspan="2">
									<c:choose>
										<c:when test="${approvalList3.size() > 0}">
											인사총무팀
											<%-- <c:forEach items="${approvalList3}" var="item" varStatus="status">
												${item.user_name} <br/>
											</c:forEach> --%>
										</c:when>
										<c:otherwise>
											최종 확인자가 없습니다.
										</c:otherwise>
									</c:choose>
								</td>
							</c:otherwise>
						</c:choose>						
						</tr>
						
						<tr  class="tr_leave_add">
							<th>유의사항</th>	
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<span id="leave_upload_text">
									1. 인트라넷 휴직 신청 전 자료실 인사총무서식 <b>'2022년 인사서식 제12호 [육아휴직신청서]'</b> 서식 작성,<br/>상급자 서면 결재 상신 &nbsp;<input class="buttonEduView" onclick="javascript:goBoard(575,3);" type="button" value="자료실 바로가기"><br/>
								</span>								
								2. 휴직신청서 서면 결재 완료 후 인트라넷 휴직 신청(입력)
							</td>			
						</tr>
						
						<tr class="tr_leave_add">
							<th>휴직 후<br/>연차유급휴가<br/>부여기준</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">								
								<span id="leave_set_text">육아 휴직 기간 중 소정근로일수(근로자와 사용자가 근로하기로 정한 날)에 대해 출근한 것으로 보아 15일의 <br/>유급휴가 부여 (3년 이상 계속 근로한 근로자에게는 최초 1년을 초과하는 계속 근로 연수 매 2년에 대하여 1일을 <br/>가산한 유급휴가 부여)<br/>
								※ 1년간 80퍼센트 이상 출근한 근로자의 연차유급휴가 부여기준과 동일하게 적용
								</span>
							</td>
						</tr>
						
						<tr class="tr_leave_view">
							<th>휴직종류</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<span id="leave_kind_val"></span>
							</td>
						</tr>						
						
						<tr class="tr_leave_view">
							<th>사유</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<span id="leave_comment_val"></span>								
							</td>
						</tr>											
						
						<tr class="tr_leave_view">
							<th>기간</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<span id="leave_start_date_val"></span>&nbsp;~&nbsp;<span id="leave_end_date_val"></span>								
								&nbsp; <font style="font-weight:bold;color:blue;">( <span id="leave_interval_val">0</span> ) 일간</font>
							</td>
						</tr>						
						
						<tr class="tr_leave_view">
							<th rowspan="2">결재</th>
							<c:choose>
								<c:when test="${pass_approval eq '1'}">
									<th colspan="4">최종 확인</th>
								</c:when>
								<c:otherwise>
									<th colspan="2">결재자</th>							
									<th colspan="2">최종 확인</th>	
								</c:otherwise>
							</c:choose>																					
						</tr>
						<tr class="tr_leave_view">
							<c:choose>
							<%-- 최종결재자만 표시되는 경우--%>
							<c:when test="${pass_approval eq '1' }">
								<td colspan="4">
									<c:choose>
										<c:when test="${approvalList3.size() > 0}">
											인사총무팀
											<%-- <c:forEach items="${approvalList3}" var="item" varStatus="status">
												${item.user_name} <br/>
											</c:forEach> --%>
										</c:when>
										<c:otherwise>
											최종 확인자가 없습니다.
										</c:otherwise>
									</c:choose>
								</td>
							</c:when>
							<c:otherwise>
								<%-- 결재자 --%>								
								<td colspan="2">
									${approvaler_name_01}
								</td>
								<%-- 최종결재자 --%>
								<td colspan="2">
									<c:choose>
										<c:when test="${approvalList3.size() > 0}">
											인사총무팀
											<%-- <c:forEach items="${approvalList3}" var="item" varStatus="status">
												${item.user_name} <br/>
											</c:forEach> --%>
										</c:when>
										<c:otherwise>
											최종 확인자가 없습니다.
										</c:otherwise>
									</c:choose>
								</td>
							</c:otherwise>
						</c:choose>						
						</tr>
						
						<tr id="return_comment_tr" style="display: none;">
							<th>결재 내역</th>
							<td  style="text-align:left;padding-left: 30px;" id="return_comment"  colspan="4"></td>
						</tr>						
					</tbody>																																																							
				</table>
			</div>
		</div>
	</form>									
	
	<script>
		$(document).ready( function(){			
			
			$("input:radio[name=leave_kind]").click(function(){
				var chkVal = $("input:radio[name=leave_kind]:checked").val();
				$("#checkedVacationVal").val(chkVal);			//체크한 휴가코드를 Set 한다. (휴직코드로 변경필요)				
				
				//휴직안내 기능추가
				if( chkVal == '1001' ){
					$("#leave_info_text").html("<b>육아휴직</b> : 남녀고용평등과 일·가정양립지원에 관한 법률 제19조1항에 따른 육아휴직 (최대 1년)");
				}else if(chkVal == '2001'){
					$("#leave_info_text").html("<b>가족돌봄휴직</b> : 남녀고용평등과 일ㆍ가정양립지원에 관한 법률 제22조의 2에 따른 휴직 (최대 90일)");
				}else if(chkVal == '3001'){
					$("#leave_info_text").html("<b>산재승인휴직</b> : 산업재해보상보헙법상 업무상 재해(질병 등)으로 인정되어 산재가 승인된 기간에 대한 휴직");					
				}else if(chkVal == '4001'){
					$("#leave_info_text").html("<b>상해/질병휴직</b> : 산업재해보상보헙법상 업무상 재해(질병 등)를 제외한 상해/질병에 따른 휴직");					
				}else if(chkVal == '9001'){
					$("#leave_info_text").html("<b>기타 휴직</b> : 1~4항에 해당하지 아니하는 휴직(본인신청과 회사승인에 따른 휴직)");					
				}
				
				//휴직 후 연차유급휴가 부여기준 추가
				if( chkVal == '1001' ){
					$("#leave_set_text").html("육아 휴직 기간 중 소정근로일수(근로자와 사용자가 근로하기로 정한 날)에 대해 출근한 것으로 보아 15일의 <br/>유급휴가 부여 (3년 이상 계속 근로한 근로자에게는 최초 1년을 초과하는 계속 근로 연수 매 2년에 대하여 1일을 <br/>가산한 유급휴가 부여)<br/>※ 1년간 80퍼센트 이상 출근한 근로자의 연차유급휴가 부여기준과 동일하게 적용");
				}else if(chkVal == '2001'){
					$("#leave_set_text").html("가족 돌봄 휴직 기간을 제외한 나머지 소정근로일수(근로자와 사용자가 근로하기로 정한 날)의 출근율을 가지고 산정하며, 연차유급휴가 일수는 가족 돌봄 휴직 기간을 제외한 나머지 소정근로일수와 연간 총 소정근로일수의 비율에 따라 산정.<br/>단, 가족 돌봄 휴직 기간을 제외한 나머지 소정근로일수와 연간 총 소정근로일수의 비율이 80퍼센트 이상인 경우,<br/>15일의 유급휴가 부여<br/>(3년 이상 계속 근로한 근로자에게는 최초 1년을 초과하는 계속 근로 연수 매 2년에 대하여 1일을 가산한 유급휴가 부여)");
				}else if(chkVal == '3001'){
					$("#leave_set_text").html("산재승인휴직 연차부여기준");
				}else if(chkVal == '4001'){
					$("#leave_set_text").html("상해/질병휴직 연차부여기준");
				}else if(chkVal == '9001'){
					$("#leave_set_text").html("기타 휴직 기간을 제외한 나머지 소정근로일수와 연간 총 소정근로일수의 비율이 80퍼센트 이상인 경우 15일의 유급휴가 부여 (3년 이상 계속 근로한 근로자에게는 최초 1년을 초과하는 계속 근로 연수 매 2년에 대하여 1일을 가산한 유급휴가 부여), 80퍼센트 미만인 경우 1개월 개근 시 1일의 유급휴가 부여");					
				}
				
				//휴직 게시물 기능 추가
				if( chkVal == '1001' ){
					$("#leave_upload_text").html("1. 인트라넷 휴직 신청 전 자료실 인사총무서식 <b>'2022년 인사서식 제12호 [육아휴직신청서]'</b> 서식 작성,<br/>상급자 서면 결재 상신 &nbsp;<input class='buttonEduView' onclick='javascript:goBoard(575,3);' type='button' value='자료실 바로가기'><br/>");
				}else if(chkVal == '2001'){
					$("#leave_upload_text").html("1. 인트라넷 휴직 신청 전 자료실 인사총무서식 <b>'2022년 인사서식 제13호 [가족돌봄휴직신청서]'</b> 서식 작성,<br/>상급자 서면 결재 상신 &nbsp;<input class='buttonEduView' onclick='javascript:goBoard(576,3);' type='button' value='자료실 바로가기'><br/>");
				}else if(chkVal == '3001'){
					$("#leave_upload_text").html("1. 산재승인휴직 게시물<br/>");
				}else if(chkVal == '4001'){
					$("#leave_upload_text").html("1. 상해/질병휴직 게시물<br/>");
				}else if(chkVal == '9001'){
					$("#leave_upload_text").html("1. 인트라넷 휴직 신청 전 자료실 인사총무서식 <b>'2022년 인사서식 제3호 [휴직신청서(육아휴직, 가족돌봄휴직 제외)]'</b> 서식 작성, 상급자 서면 결재 상신 &nbsp;<input class='buttonEduView' onclick='javascript:goBoard(574,3);' type='button' value='자료실 바로가기'><br/>");					
				}
				
				//기간이 선택된 상태에서 휴가종류를 바꾼경우
				if( $("#leave_end_date").val() != "" && $("#leave_start_date").val() != "" ){
					doVacationCal();
					doLeaveCal();
				}
				
			});			
			
			
			$("#leave_start_date").change( function(){				
				if( $("#leave_end_date").val() != "" ){					
					doVacationCal();
					doLeaveCal();
				}
			});
			
			$("#leave_end_date").change( function(){				
				if( $("#leave_start_date").val() != "" ){					
					doVacationCal();
					doLeaveCal();
				}
			});			
			
		});
		
		
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
		
		
		function doVacationCal(){
			
			var vacationStartdate =  $("#leave_start_date").val();
			var vacationEnddate = $("#leave_end_date").val();				
			
			var param = {};
			param.vacationStartDate       = vacationStartdate;
			param.vacationEndDate			= vacationEnddate;
			param.checkedVacationVal				= $("#checkedVacationVal").val();		//휴직코드 (1001: 1년, 2001: 90일까지 가능함)
			
			//종료날짜가 시작날짜보다 이전일자인지 체크한다.
			if( dateChk( vacationStartdate,  vacationEnddate) ){
				alert('휴직 시작일자가 종료일자보다 작아야합니다. ');
				return;
			}			
			
			var url = "./countVacation";

			$.ajax({
			    type: "POST",
			    url: url,
			    data: param,
			    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			    dataType: "html",
			    traditional: true,						//배열허용
			    timeout: 20000,
			    success: function(data){            	
					if( data ){		//1인 경우 성공						
						$("#vacation_interval").text(data);						
						//계산된 실제휴가일수를 넣어준다. (연차소모일과  상관없음)
						$("#vacationIntervalVal").val(data);					
					}                	
			    }                
			});
			
		}
		
		function doLeaveCal(){
			
			var vacationStartdate =  $("#leave_start_date").val();
			var vacationEnddate = $("#leave_end_date").val();				
			
			var param = {};
			param.vacationStartDate       = vacationStartdate;
			param.vacationEndDate			= vacationEnddate;
			param.checkedVacationVal				= $("#checkedVacationVal").val();		//휴직코드 (1001: 1년, 2001: 90일까지 가능함)
			
			//종료날짜가 시작날짜보다 이전일자인지 체크한다.
			if( dateChk( vacationStartdate,  vacationEnddate) ){
				alert('휴직 시작일자가 종료일자보다 작아야합니다. ');
				return;
			}			
			
			var url = "./countLeave";
			
			//총 휴가 신청일수
			$.ajax({
			    type: "POST",
			    url: url,
			    data: param,
			    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			    dataType: "html",
			    traditional: true,						//배열허용
			    timeout: 20000,
			    success: function(data){            	
					if( data ){		//1인 경우 성공						
						$("#leave_interval_all").text(data);						
						//계산된 실제휴가일수를 넣어준다. (연차소모일과  상관없음)
						$("#leaveIntervalVal").val(data);						
					}                	
			    }                
			});
			
		}
		
		//휴직신청 Modal
		function fnLeaveIns(){
			
        	$("#leave_start_date").val("");
        	$("#leave_end_date").val("");
        	$("#leave_comment").val("");        	
        	$("#leave_mod_no").val("");
        	$("#leave_mod_state").val("");
        	$("#leave_state").hide();
        	
        	$("#leave_start_date").prop("disabled",false);
        	$("#leave_end_date").prop("disabled",false);
        	$("#leave_comment").prop("disabled",false);        	
        	
        	//휴가타입 초기화
        	var chkVal = $("input:radio[name=leave_kind]:checked").val();
			$("#checkedVacationVal").val(chkVal);
        	
			$(".tr_leave_add").show();
			$(".tr_leave_view").hide();			
			
			//신청일 경우 결재내역을 가린다.
			$("#return_comment_tr").hide();
			$("#leave_state").hide();
			
			//결재자없는 경우 체크			
			//alert("notapproval="+$("#notApproval").val());			
        	
			$("#leave-action-dialog").dialog({
				height: 650,
				width: 820,
				closeOnEscape : true,
				draggable : true,
				resizable : true,
				//appendTo : "#vacationActionFrm",
				appendTo : "#leaveActionFrm",
				title: "휴직 신청",
				buttons:{
					"휴직 신청" : function(){
						var action = fnLeaveAction('C');
						if (action){
							$(this).dialog("close");
						}
					},
					"취소" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});
		}
		
		
		
		function fnLeaveMod(){
			var label2 = "신청 취소";
			var label3 = "창닫기";
			var modalButtons = {};			
				
			//1차결재 대기인경우만 취소가 가능하다.
			if( $("#approval_state").val() == 10 ){
				modalButtons[label2] = function(){ if(!confirm("신청 취소 하시겠습니까?"))return; fnLeaveAction('D') };
				modalButtons[label3] = function(){ $(this).dialog("close") };
			}else{
				modalButtons[label3] = function(){ $(this).dialog("close") };
			}
			
			//휴가신청일을 셋팅해준다.			
			$("#leave_interval_info").text($("#leaveIntervalVal").val());
			
			$("#leave-action-dialog").dialog({
				height: 550,
				width: 820,
				closeOnEscape : true,
				draggable : true,
				resizable : true,
				appendTo : "#leaveActionFrm",
				title: "휴직 상세보기",
				buttons : modalButtons,
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});			
		}
		
		//휴직신청버튼클릭
		function fnLeaveAction(action){
			
			var vacationStartdate =  $("#leave_start_date").val();
			var vacationEnddate = $("#leave_end_date").val();
						
			if (action == "C" || action == "U"){
								
				if ( !$("input:radio[name='leave_kind']").is(":checked") ){
					alert("휴직의 종류를 선택 해 주세요.");
					return false;
				}
				
				if ( $("#leave_comment").val() == "" ){
					alert("휴직 사유를 입력 해 주세요.");
					return false;
				}				
				
				if ( vacationStartdate == "" ){
					alert("휴직 시작일을 입력 해 주세요.");
					return false;
				}
				
				if ( vacationEnddate == "" ){
					alert("휴직 종료일을 입력 해 주세요.");
					return false;
				}
				
				//육아휴직의 경우 1년			
				if ( $("input:radio[name=leave_kind]:checked").val() == 1001){					
					
					if($("#leaveIntervalVal").val() > 366 ){
						alert('육아휴직는 최대 1년까지 신청이 가능합니다.');
						return;
					}
					
				}
				
				//가족돌봄휴직의 경우 90일
				if ( $("input:radio[name=leave_kind]:checked").val() == 2001){					
					
					if($("#leaveIntervalVal").val() > 90 ){
						alert('가족돌봄휴직은 90일까지 신청이 가능합니다.');
						return;
					}
					
				}
				
				//종료날짜가 시작날짜보다 이전일자인지 체크한다.
				if( dateChk( vacationStartdate,  vacationEnddate) ){
					alert('휴직 시작일자가 종료일자보다 작아야합니다. ');
					return;
				}
			}
			
			var url = "/actionLeave";
			
			if( action == "D" ){
				url = "/actionLeaveCancel";
			}			
			
		    var param = new FormData();		    
		    		    
		    param.append("action",action);
		    
		    if (action == 'U'|| action == 'D' ||action == 'FD'){
		    	param.append("serial_no", $("#leave_serial_no").val());
		    }
		    
		    param.append("userNo", $("#vacation_user_no").val());
		    param.append("teamId", $("#vacation_team_id").val());
		    param.append("leave_basedate", $("#leave_start_date_val").text());		    	//취소시 사용하는 base_date
		    		    
		    param.append("leaveTeamType", $("#leave_team_type").val());
		    param.append("vacationStartDate", vacationStartdate);
		    param.append("vacationEndDate", vacationEnddate);
		    param.append("leaveComment", $("#leave_comment").val());
		    param.append("leaveKind", $("input:radio[name='leave_kind']:checked").val());		    
		    param.append("leaveType", $("#leave_type").val());
		    		    
		    param.append("teamManager", $("#teamManager").val());
		    param.append("teamManagerYn", $("#teamManagerYn").val());
		    param.append("centerManager", $("#centerManager").val());
		    
		    param.append("vacationIntervalVal",$("#vacationIntervalVal").val());		//근무일제외 휴직신청일수 추가
		    param.append("leaveIntervalVal",$("#leaveIntervalVal").val());		//총휴직 신청일수 추가
		   	param.append("notApproval",$("#notApproval").val());							//결재자없는경우 예외처리 플래그
		   	
		   	param.append("passApproval",$("#pass_approval").val());				//passApproval : 0 (정상결재), 1: 부문장 또는 결재대상이 없어 최종결재로 넘어감
		   	param.append("approvaler_01",$("#approvaler_01").val());				//결재자(1차): passApproval 이 1인 경우는 없을수도 있음
		   	param.append("approvaler_03",$("#approvaler_03").val());				//결재자(1차): passApproval 이 1인 경우는 없을수도 있음
		   				
			var pageIdx = $("#currPageIdx").val();
		    $.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        timeout: 20000,
		        processData: false,
		        contentType: false,
		        dataType: "JSON", 
		        success: function(data){
		        	
		        	if (data.result == "0000" ){//신청
		        		alert("휴직 신청이 완료되었습니다.");
		        		location.href="./myLeaveMain";
		        	}else if (data.result == "0010"){//수정
		        		fnGoPage(pageIdx);
		        		$("#leave-action-dialog").dialog("close");		        		
		        	}else if (data.result == "0020"){//취소
		        		alert("휴직 신청취소가 완료되었습니다.");
		        		fnGoPage(pageIdx);
		        		$("#leave-action-dialog").dialog("close");		        		
		        	}else if(data.result == "900"){		        		
		        		alert("신청하신 휴직일정이 기존에 신청한 휴직기간과 중복됩니다.");
		        	}else if(data.result == "999"){
		        		alert("결재자가 지정되어있지 않아 휴직을 신청할수 없습니다. 관리자에게 문의하세요.");
		        	}
		        	
	        		return;
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });
		}	
	
	
	</script>
