<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	
	<form id="vacationActionFrm">
		<input type="hidden" id="serial_no" name="serial_no" value="${leaveInfo.serial_no}"/>
		<input type="hidden" id="approval_state" name="approval_state" value="${leaveInfo.approval_state}"/>
		<input type="hidden" id="leave_type" name="leave_type" value="${leaveInfo.leave_type}"/>
		<input type="hidden" id="leave_interval" name="leave_interval" value="${leaveInfo.leave_interval}"/>
		<input type="hidden" id="user_no" name="user_no" value="${leaveInfo.user_no}"/>
		<input type="hidden" id="leave_sdate" name="leave_sdate" value="${leaveInfo.sdate}"/>		
		<!-- 신규 파라미터 끝 -->				
		<div id="vacation-detail-dialog" title="휴직 결재" style="font-size: 12px;" align="center">
			<br/>
			<div class="tableStyle2" style="width: 100%;">
				<table class="vacation-ins-table">
						<tr>
							<th rowspan="2">신청자<br/><br/>정보</th>
							<th>센터명</th>
							<th>부서명</th>
							<th>이름</th>
							<th>신청일</th>
						</tr>				
						<tr>
							<td>${leaveInfo.center_name}</td>
							<td>${leaveInfo.team_name}</td>
							<td>${leaveInfo.user_name}</td>
							<td>${leaveInfo.regdate}</td>														
						</tr>
						<tr>
							<th rowspan="2">신청내용</th>
							<th>휴직유형</th>
							<th>기간</th>
							<th>사유</th>														
							<th>상태</th>							
						</tr>
						<tr>
							<td>${leaveInfo.leave_type_val}</td>
							<td>${leaveInfo.sdate} ~ ${leaveInfo.edate}</td>
							<td>${leaveInfo.leave_content}</td>
							<td>${leaveInfo.approval_state_val}</td>
						</tr>																		
						<c:choose>
							<c:when test="${view_type eq 'view'}">
								<tr>
									<th>결재 내역</th>
									<td style="text-align:left;padding-left: 20px;" colspan="4">
										<c:choose>
											<c:when test="${leaveInfo.approval_state eq 20 }">
												<c:if test="${!empty leaveInfo.ap_date_01}">
													<font color='blue'>[1차 결재 승인] ${leaveInfo.approvaler_01_val} (${leaveInfo.ap_date_01}) ${leaveInfo.ap_comment_01}</font>
												</c:if>												
											</c:when>
											<c:when test="${leaveInfo.approval_state eq 30 }">
												<%-- <c:if test="${!empty leaveInfo.ap_date_01}"> --%>
													[1차 결재 승인] ${leaveInfo.approvaler_01_val} (${leaveInfo.ap_date_01}) ${leaveInfo.ap_comment_01}<br/>
												<%-- </c:if> --%>																								
											</c:when>
											<c:when test="${leaveInfo.approval_state eq 31 }">
												<c:if test="${!empty leaveInfo.ap_date_01}">
													[1차 결재 승인] ${leaveInfo.approvaler_01_val} (${leaveInfo.ap_date_01}) ${leaveInfo.ap_comment_01}<br/>
												</c:if>																								
												<c:if test="${!empty leaveInfo.ap_date_03}">
													<font color='blue'>[인사총무팀 승인] ${leaveInfo.approvaler_03_val} (${leaveInfo.ap_date_03}) ${leaveInfo.ap_comment_03}</font>
												</c:if>												
											</c:when>
											<c:when test="${leaveInfo.approval_state eq 12 }">
												<font color='red'>[1차 결재 반려] ${leaveInfo.approvaler_01_val} (${leaveInfo.ap_date_01}) ${leaveInfo.ap_comment_01}</font>
											</c:when>
											<c:when test="${leaveInfo.approval_state eq 22 }">
												<c:if test="${!empty vacationInfo.ap_date_01}">
													[1차 결재 승인] ${leaveInfo.approvaler_01_val} (${leaveInfo.ap_date_01}) ${leaveInfo.ap_comment_01}<br/>
												</c:if>																								
											</c:when>
											<c:when test="${leaveInfo.approval_state eq 32 }">
												<c:if test="${!empty leaveInfo.ap_date_01}">
													[1차 결재 승인] ${leaveInfo.approvaler_01_val} (${leaveInfo.ap_date_01}) ${leaveInfo.ap_comment_01}<br/>
												</c:if>												
												<c:if test="${!empty leaveInfo.ap_date_03}">
													<font color='red'>[인사총무팀 반려] ${leaveInfo.approvaler_03_val} (${leaveInfo.ap_date_03}) ${leaveInfo.ap_comment_03}</font>
												</c:if>
											</c:when>
										</c:choose>
									</td>							
								</tr>
								<%--결재취소가 가능한경우 보여준다 --%>
								<c:if test="${cancel_auth eq 1}">
								<tr>
									<td colspan="5">										
										<a href="#noloc" class="btn-vacation-aprv" id="btn-Aprovalcancel-detail" style="background:#c25757;color:#ffffff !important;" >결재취소</a>																						
									</td>
								</tr>
								</c:if>
							</c:when>
							<c:otherwise>
								<%--최종확인단계에서는 결재내역을 보여준다. --%>
								<c:if test="${leaveInfo.approval_state eq 30 }">
									<tr>
									<th>결재 내역</th>
										<td style="text-align:left;padding-left: 20px;" colspan="4">
											<font color='blue'>[1차 결재 승인] ${leaveInfo.approvaler_01_val} (${leaveInfo.ap_date_01}) ${leaveInfo.ap_comment_01}</font>
										</td>
									</tr>
								</c:if>
																
								<tr>									
									<th>결재자 의견</th>
									<td style="text-align:left;padding-left: 20px;" colspan="4">
										<input type="text" id="ap_comment" name="ap_comment" maxlength="100" style="width:560px;"/>
									</td>							
								</tr>
								<tr>
									<td colspan="5">
										<a href="#noloc" class="btn-vacation-aprv" id="btn-aprv-detail" style="background:#5792c2;color:#ffffff !important;">승인</a>
										&nbsp;&nbsp;&nbsp;
										<a href="#noloc" class="btn-vacation-aprv" id="btn-cancel-detail" style="background:#c25757;color:#ffffff !important;" >반려</a>												
									</td>
								</tr>
							</c:otherwise>
						</c:choose>																																																	
				</table>
			</div>
		</div>
	</form>	
	
	<script>
		$(document).ready( function(){									
			_initButton();
		});
		
		//버튼 이벤트
	    function _initButton() {
			$("#btn-aprv-detail").on("click",function(){
				if (confirm("휴직을 승인하시겠습니까?")){					
					fnVacationDetailAction("A");
				}
			});

			$("#btn-cancel-detail").on("click",function(){
				if (confirm("휴직을 반려하시겠습니까?")){
					
					var ap_comment_val = $("#ap_comment").val();					
					
					if( ap_comment_val == "" ){
						alert("반려시에는 결재자 의견이 입력되어야 합니다.");
						return;
					}
					
					fnVacationDetailAction("C");
				}
			});
			
			$("#btn-Aprovalcancel-detail").on("click",function(){
				if (confirm("결재를 취소하시겠습니까?")){										
					//승인취소
					fnVacationDetailAction("AC");
				}
			});
		}
		
	    function fnVacationDetailAction(action){
	    	
			var url = "actionLeaveApproval";
			var param = new FormData();
			
			if( action == "AC" ){
				url = "actionLeaveManagerCancel";
			}
			
			param.append("action",action);
			param.append("serial_no",$("#serial_no").val());
			param.append("user_no",$("#user_no").val());
			param.append("approval_state",$("#approval_state").val());
			param.append("leave_type",$("#leave_type").val());
			param.append("leave_interval",$("#leave_interval").val());
			param.append("ap_comment",$("#ap_comment").val());
			param.append("leave_sdate",$("#leave_sdate").val());			
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        timeout: 20000,
		        processData: false,
		    	contentType: false,		        
		        dataType: "JSON", 
		        success: function(data){		        	
	        		alert('신청이 취소되었습니다.');	        		
	        		location.href="./leaveManager";
	        		return;
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });
			
		}
		
		
	</script>