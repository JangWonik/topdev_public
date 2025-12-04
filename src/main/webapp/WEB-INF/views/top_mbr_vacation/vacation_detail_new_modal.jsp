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
		<input type="hidden" id="serial_no" name="serial_no" value="${vacationInfo.serial_no}"/>
		<input type="hidden" id="approval_state" name="approval_state" value="${vacationInfo.approval_state}"/>
		<input type="hidden" id="vacation_type" name="vacation_type" value="${vacationInfo.vacation_type}"/>
		<input type="hidden" id="vacation_interval" name="vacation_interval" value="${vacationInfo.vacation_interval}"/>
		<input type="hidden" id="user_no" name="user_no" value="${vacationInfo.user_no}"/>
		<input type="hidden" id="vacation_sdate" name="vacation_sdate" value="${vacationInfo.sdate}"/>
		<input type="hidden" id="vacation_org_file" name="vacation_org_file" value="${vacationInfo.vacation_org_file}"/>
		<!-- 신규 파라미터 끝 -->				
		<div id="vacation-detail-dialog" title="휴가 결재" style="font-size: 12px;" align="center">
			<br/>
			<div class="tableStyle2" style="width: 700px;">
				<table class="vacation-ins-table">
					<colgroup>
						<col width="10%"/>
						<col width="18%"/>
						<col width="20%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="12%"/>															
					</colgroup>					
					<tbody>						
						<tr>
							<th rowspan="2">신청자<br/><br/></th>
							<th>센터명</th>
							<th>부서명</th>
							<th colspan="2">이름</th>
							<th>신청일</th>
						</tr>				
						<tr>
							<td>${vacationInfo.center_name}</td>
							<td>${vacationInfo.team_name}</td>
							<td colspan="2">${vacationInfo.user_name}</td>
							<td>${vacationInfo.regdate}</td>														
						</tr>
						<!-- 신청자 연차정보시작 -->
						<tr>
							<th rowspan="2">신청자<br/><br/>연차정보</th>
							<th>연차사용기간</th>
							<th>연차부여일</th>							
							<c:choose>
								<c:when test="${vacationInfo.approval_state eq 10 or  vacationInfo.approval_state eq 30}">
									<th>총 연차사용일</th>
									<th>결재 전<br/>잔여일 </th>
									<th>결재 후<br/>잔여일</th>		
								</c:when>
								<c:otherwise>
									<th colspan="2">총 연차사용일</th>
									<th>잔여일 </th>
								</c:otherwise>
							</c:choose>
						</tr>
						<!-- 예상잔여연차 계산시작 -->
						<c:choose>
							<c:when test="${vacationInfo.vacation_type eq 100 or vacationInfo.vacation_type eq 200 or vacationInfo.vacation_type eq 210 }">
								<c:set var="intervalCal" value="${vacationInfo.vacation_interval}"></c:set>
							</c:when>
							<c:otherwise>
								<c:set var="intervalCal" value="0"></c:set>
							</c:otherwise>
						</c:choose>
						<c:set var="remainCal" value="${vacationUse.annual_set - vacationUse.annual_use - intervalCal}"></c:set>
						<!-- 예상잔여연차 계산 끝 -->
						<tr>
							<td>${vacationUse.annual_start_date} ~ ${vacationUse.annual_end_date}</td>
							<td>${vacationUse.annual_set}</td>							
							<c:choose>
								<c:when test="${vacationInfo.approval_state eq 10 or  vacationInfo.approval_state eq 30}">
									<td><fmt:formatNumber value="${vacationUse.annual_use}" pattern="0.00"/></td>							
									<td>
										<%-- <fmt:formatNumber value="${vacationUse.annual_set - vacationUse.annual_use}" pattern="0.00"/> --%>
										<fmt:formatNumber value="${vacationInfo.remain_vacation_use}" pattern="0.00"/>
									</td>
									<td>
										<c:choose>
											<c:when test="${remainCal < 0}"><b><font color="red"><fmt:formatNumber value="${remainCal}" pattern="0.00"/></font></b></c:when>
											<c:otherwise><b><font color="blue"><fmt:formatNumber value="${remainCal}" pattern="0.00"/></font></b></c:otherwise>
										</c:choose>
									</td>
								</c:when>
								<c:otherwise>
									<td colspan="2"><fmt:formatNumber value="${vacationUse.annual_use}" pattern="0.00"/></td>							
									<td><fmt:formatNumber value="${vacationUse.annual_set - vacationUse.annual_use}" pattern="0.00"/></td>									
								</c:otherwise>
							</c:choose>
						</tr>	
						<!-- 신청자 연차정보 끝 -->
						<tr>
							<th>구분</th>
							<th>기간</th>
							<th>사유</th>
							<th>사용일</th>
							<th>차감일</th>
							<th>상태</th>							
						</tr>
						<tr>
							<td>								
								${vacationInfo.vacation_type_val}
								<c:if test="${not empty vacationInfo.vacation_option_val}">
									<br/>[${vacationInfo.vacation_option_val}]
								</c:if>
							</td>
							<td>${vacationInfo.sdate} ~ ${vacationInfo.edate}</td>
							<td>${vacationInfo.vacation_content}</td>							
							<td>${vacationInfo.vacation_interval} 일</td>							
							<td>${intervalCal} 일</td>
							<td>${vacationInfo.approval_state_val}</td>
						</tr>
						<c:if test="${vacationInfo.vacation_type eq 700}">
						<tr>
							<th>증적자료</th>
							<td style="text-align:left;padding-left: 20px;" colspan="5">
								<a href="/vacationFileDownNew?serial_no=${vacationInfo.serial_no}">${vacationInfo.vacation_org_file}</a>								
							</td>							
						</tr>
						</c:if>												
						<c:choose>
							<c:when test="${view_type eq 'view'}">
								<tr>
									<th>결재 내역</th>
									<td style="text-align:left;padding-left: 20px;" colspan="5">
										<!-- 1단계 결재방식에 따라 내역 표시 방식 변경 -->
										<c:choose>
											<c:when test="${!empty vacationInfo.ap_date_01 and vacationInfo.approval_state eq 31}">
												<font color='blue'>[1차 결재 승인] ${vacationInfo.approvaler_01_val} (${vacationInfo.ap_date_01}) ${vacationInfo.ap_comment_01}</font><br/>
												<font color='blue'>[인사총무팀 승인] ${vacationInfo.approvaler_03_val} (${vacationInfo.ap_date_03}) ${vacationInfo.ap_comment_03}</font>
											</c:when>
											<c:when test="${!empty vacationInfo.ap_date_01 and vacationInfo.approval_state eq 32}">
												<font color='blue'>[1차 결재 승인] ${vacationInfo.approvaler_01_val} (${vacationInfo.ap_date_01}) ${vacationInfo.ap_comment_01}</font><br/>
												<font color='red'>[인사총무팀 반려] ${vacationInfo.approvaler_03_val} (${vacationInfo.ap_date_03}) ${vacationInfo.ap_comment_03}</font>
											</c:when>
											<c:when test="${vacationInfo.approval_state eq 31 }">
												<font color='blue'>[결재승인] ${vacationInfo.approvaler_03_val} (${vacationInfo.ap_date_03}) ${vacationInfo.ap_comment_03}</font>
											</c:when>
											<c:when test="${vacationInfo.approval_state eq 32 }">
												<font color='red'>[결재반려] ${vacationInfo.approvaler_03_val} (${vacationInfo.ap_date_03}) ${vacationInfo.ap_comment_03}</font>
											</c:when>
										</c:choose>
										<%-- <c:choose>
											<c:when test="${vacationInfo.approval_state eq 20 }">
												<c:if test="${!empty vacationInfo.ap_date_01}">
													<font color='blue'>[1차 결재 승인] ${vacationInfo.approvaler_01_val} (${vacationInfo.ap_date_01}) ${vacationInfo.ap_comment_01}</font>
												</c:if>												
											</c:when>
											<c:when test="${vacationInfo.approval_state eq 30 }">
												<c:if test="${!empty vacationInfo.ap_date_01}">
													[1차 결재 승인] ${vacationInfo.approvaler_01_val} (${vacationInfo.ap_date_01}) ${vacationInfo.ap_comment_01}<br/>
												</c:if>																								
											</c:when>
											<c:when test="${vacationInfo.approval_state eq 31 }">
												<c:if test="${!empty vacationInfo.ap_date_01}">
													[1차 결재 승인] ${vacationInfo.approvaler_01_val} (${vacationInfo.ap_date_01}) ${vacationInfo.ap_comment_01}<br/>
												</c:if>																								
												<c:if test="${!empty vacationInfo.ap_date_03}">
													<font color='blue'>[인사총무팀 승인] ${vacationInfo.approvaler_03_val} (${vacationInfo.ap_date_03}) ${vacationInfo.ap_comment_03}</font>
												</c:if>												
											</c:when>
											<c:when test="${vacationInfo.approval_state eq 12 }">
												<font color='red'>[1차 결재 반려] ${vacationInfo.approvaler_01_val} (${vacationInfo.ap_date_01}) ${vacationInfo.ap_comment_01}</font>
											</c:when>
											<c:when test="${vacationInfo.approval_state eq 22 }">
												<c:if test="${!empty vacationInfo.ap_date_01}">
													[1차 결재 승인] ${vacationInfo.approvaler_01_val} (${vacationInfo.ap_date_01}) ${vacationInfo.ap_comment_01}<br/>
												</c:if>																								
											</c:when>
											<c:when test="${vacationInfo.approval_state eq 32 }">
												<c:if test="${!empty vacationInfo.ap_date_01}">
													[1차 결재 승인] ${vacationInfo.approvaler_01_val} (${vacationInfo.ap_date_01}) ${vacationInfo.ap_comment_01}<br/>
												</c:if>												
												<c:if test="${!empty vacationInfo.ap_date_03}">
													<font color='red'>[인사총무팀 반려] ${vacationInfo.approvaler_03_val} (${vacationInfo.ap_date_03}) ${vacationInfo.ap_comment_03}</font>
												</c:if>
											</c:when>
										</c:choose> --%>
									</td>							
								</tr>
								<%--결재취소가 가능한경우 보여준다 --%>
								<c:if test="${cancel_auth eq 1}">
								<tr>
									<td colspan="6">										
										<a href="#noloc" class="btn-vacation-aprv" id="btn-Aprovalcancel-detail" style="background:#c25757;color:#ffffff !important;" >결재취소</a>												
									</td>
								</tr>
								</c:if>
							</c:when>
							<c:otherwise>
								<%--최종확인단계에서는 결재내역을 보여준다. --%>
								<!-- 1단계 결재 방식으로 변경에 따라 결재 대기에서는 내역을 보여주지 않는다 -->
								<%-- <c:if test="${vacationInfo.approval_state eq 30 }">
									<tr>
									<th>결재 내역</th>
										<td style="text-align:left;padding-left: 20px;" colspan="5">
											<font color='blue'>[1차 결재 승인] ${vacationInfo.approvaler_01_val} (${vacationInfo.ap_date_01}) ${vacationInfo.ap_comment_01}</font>
										</td>
									</tr>
								</c:if> --%>
																
								<tr>									
									<th>결재자 의견</th>
									<td style="text-align:left;padding-left: 20px;" colspan="5">
										<input type="text" id="ap_comment" name="ap_comment" maxlength="100" style="width:560px;"/>
									</td>							
								</tr>
								<tr>
									<td colspan="6">
										<a href="#noloc" class="btn-vacation-aprv" id="btn-aprv-detail" style="background:#5792c2;color:#ffffff !important;">승인</a>
										&nbsp;&nbsp;&nbsp;
										<a href="#noloc" class="btn-vacation-aprv" id="btn-cancel-detail" style="background:#c25757;color:#ffffff !important;" >반려</a>												
									</td>
								</tr>
							</c:otherwise>
						</c:choose>						
					</tbody>																																																							
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
				if (confirm("휴가를 승인하시겠습니까?")){					
					fnVacationDetailAction("A");
				}
			});

			$("#btn-cancel-detail").on("click",function(){
				if (confirm("휴가를 반려하시겠습니까?")){
					
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
			
			var url = "actionVacationApproval";			
			var param = new FormData();
			
			param.append("action",action);
			param.append("serial_no",$("#serial_no").val());
			param.append("user_no",$("#user_no").val());
			param.append("approval_state",$("#approval_state").val());
			param.append("vacation_type",$("#vacation_type").val());
			param.append("vacation_interval",$("#vacation_interval").val());
			param.append("ap_comment",$("#ap_comment").val());
			param.append("vacation_sdate",$("#vacation_sdate").val());			
			
			$.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        timeout: 20000,
		        processData: false,
		    	contentType: false,		        
		        dataType: "JSON", 
		        success: function(data){
	        		alert(data.msg);
	        		if (data.result == "0000" ){//
		        		//location.reload();
	        			location.href="./vacationApproval";
		        	}	        		
	        		return;
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });
			
		}
		
		
	</script>