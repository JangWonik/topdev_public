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
		
		/* 모달창 셀렉트 박스 */
		.select2-container--default{
			text-align : center;
			font-color:#444;
			font-size:12px;
		}
		
	</style>	
	
	<form id="vacationActionFrm">
		<input type="hidden" id="serial_no" name="serial_no" value="${vacationInfo.serial_no}"/>
		<input type="hidden" id="approval_now_val" name="approval_now_val" value="${vacationInfo.approvaler_now}"/>		
		<!-- 신규 파라미터 끝 -->				
		<div id="vacation-detail-dialog" title="현재 결재자 수정" style="font-size: 12px;" align="center">
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
							<th rowspan="2">신청자<br/><br/>정보</th>
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
						<tr>
							<th>구분</th>
							<th>기간</th>
							<th>사유</th>
							<th colspan="2"><font color="blue">현재결재자</font></th>							
							<th>상태</th>							
						</tr>
						<tr>
							<td>${vacationInfo.vacation_type_val}</td>
							<td>${vacationInfo.sdate} ~ ${vacationInfo.edate}</td>
							<td>${vacationInfo.vacation_content}</td>
							<td colspan="2"><font color="blue">${vacationInfo.approvaler_now_name}</font></td>							
							<td>${vacationInfo.approval_state_val}</td>							
						</tr>	
						<tr>
							<th colspan="2">변경 할 결재자 선택</th>
							<td colspan="4">
								<select id="approval_now" name="approval_now">									
									<c:forEach items="${memberList}" var="item" >
										<option value="${item.userNo}">${item.userName}</option>									
									</c:forEach>										
								</select>
							</td>
						</tr>			
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
			
			$("#btn-Aprovalcancel-detail").on("click",function(){
				if (confirm("결재를 취소하시겠습니까?")){										
					//승인취소
					fnVacationDetailAction("AC");
				}
			});
		}
		
	    function fnVacationApprovalNowUpdate(){
			
			var sUrl = "updateVacationApprovalNow";			
			var param = {};
			
			param.serial_no = $("#serial_no").val();
			param.approvaler_now = $("#approval_now").val();			
			
			$.ajax({
				type: "POST",
       	        url: sUrl,
       	        data: param,
       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       	        timeout: 20000,
       	        async: false,
       	        dataType: "html", 
       	        success: function(data){
       	        	if (data == 1){
						alert("현재결재자를 수정하였습니다.");
						$("#vacation-detail-dialog").dialog("close");
						//재검색
						$("#approval-all-btn-search").click();
       	        	}
       	        },
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}
			});
			
		}
		
		
	</script>