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
	
	<form id="vacationActionFrm">
		<input type="hidden" id="vacation_user_no"  name="vacation_user_no" value="${srchParam.userNo}" />
		<input type="hidden" id="vacation_team_id" name="vacation_team_id" value="${srchParam.teamId}" />
		<input type="hidden" id="vacation_team_type" name="vacation_team_type" value="${srchParam.teamType}" />
		<input type="hidden" id="vacation_year" name="vacation_year" value="${srchParam.year}" />
		<input type="hidden" id="vacation_remain_cnt" name="vacation_remain_cnt" value="${11 - srchParam.vacationUseCnt}" />
		<%-- <input type="hidden" id="vacation_remain_cnt" name="vacation_remain_cnt" value="${srchParam.vacationDayCnt - srchParam.vacationUseCnt}" /> --%>
		<input type="hidden" id="vacation_cnt" name="vacation_cnt" value="0" />
		
		
<%-- 		<input type="text" value="${srchParam.vacationDayCnt}"/> --%>
<%-- 		<input type="text" value="${srchParam.vacationUseCnt}"/> --%>
		
		<input type="hidden" id="vacation_mod_no" name="vacation_mod_no" value=""/>
		<input type="hidden" id="vacation_mod_state" name="vacation_mod_state" />
				
		<div id="vacation-action-dialog" title="휴가 신청" style="font-size: 15px;display:none;" align="center">
			<br/>
			<div class="tableStyle2" style="width: 650px;">
				<table class="vacation-ins-table">
					<colgroup>
						<col width="100"/>
						<col width="550"/>
					</colgroup>
					<tbody>
					
						<tr id="vacation_state" style="display: none;">
							<th>상태</th>
							<td style="padding-left: 30px;">
							</td>											
						</tr>		
						
						<tr id="return_comment_tr" style="display: none;">
							<th>반려사유</th>
							<td style="padding-left: 30px;" id="return_comment">
								
							</td>											
						</tr>		
									
						<tr>
							<th>종류</th>
							<td style="padding-left: 30px;">
								<ul class="vacation-ins-kind">
									<c:forEach items="${vacationKindList}" var="item" varStatus="status">
										<c:if test="${ item.col_cd ne '35'}">
											<li>
												<input type="radio" class="vacation_kind" name="vacation_kind" id="vacation_kind_${status.count}" value="${item.col_cd}"><label for="vacation_kind_${status.count}">${item.col_val}</label>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</td>											
						</tr>
						<tr>
							<th>사유</th>
							<td>
								<input type="text" id="vacation_comment" name="vacation_comment" style="width:480px;" />
								<br/>
								<font color="red"><b>사유 간략히 기재, 단 "월차","정기휴가" 라고 입력하지 말 것</b></font>
							</td>
						</tr>
						<tr id="tr_vacation_file" style="display: none;">
							<th>파일첨부</th>
							<td>
								<span id="file_down_span">
									<a href="/" >
										<span id="file_name"></span>
									</a>
									&nbsp;<img class="btn_file_del" src="./resources/ls_img/btn_del_s.gif" alt="삭제" style="cursor:pointer" />							
								</span>
								
								<span id="file_up_span">
									<input type="file" id="vacation_file" name="vacation_file" style="width: 90%;">
								</span>
							</td>
						</tr>						
						<tr>
							<th>기간</th>
							<td style="padding-left: 30px;">
								<input type="text" class="classCalendar" id="vacation_start_date" name="vacation_start_date" style="width: 70px;"/>
								&nbsp;~&nbsp;
								<input type="text" class="classCalendar" id="vacation_end_date" name="vacation_end_date" style="width: 70px;"/>
							</td>
						</tr>
						<tr>
							<th>근무부서</th>
							<td style="padding-left: 30px;">
								${vacationInsBasicData.teamName}
							</td>
						</tr>
						<tr>
							<th>이름</th>
							<td style="padding-left: 30px;">
								${vacationInsBasicData.userName} ${vacationInsBasicData.workLevelNm}
							</td>
						</tr>
						<tr>
							<th>주소</th>
							<td style="padding-left: 30px;">
								${vacationInsBasicData.teamAddr}
							</td>
						</tr>
						<tr>
							<th>결재자</th>
							<td style="padding-left: 30px;">
								<c:choose>
									<c:when test="${vacationInsBasicData.teamManagerYn != 0 and vacationInsBasicData.teamType != 4}">
										${vacationInsBasicData.centerManagerNm}	
									</c:when>
									<c:otherwise>
										${vacationInsBasicData.teamManagerNm}
									</c:otherwise>
								</c:choose>
								
								<input type="hidden" id="teamManager" name="teamManager" value="${vacationInsBasicData.teamManager}" />
								<input type="hidden" id="centerManager" name="centerManager" value="${vacationInsBasicData.centerManager}" />
								<input type="hidden" id="teamManagerYn" name="teamManagerYn" value="${vacationInsBasicData.teamManagerYn}" />
								
							</td>
						</tr>
					</tbody>																																																							
				</table>
			</div>
		</div>
	</form>									
	
	<script>
		function fnVacationIns(){
			// 모달 초기화
        	$("#vacation_start_date").val("");
        	$("#vacation_end_date").val("");
        	$("#vacation_comment").val("");
        	$("input:radio[name='vacation_kind']").prop('checked', false);
        	$("#vacation_mod_no").val("");
        	$("#vacation_mod_state").val("");
        	$("#vacation_state").hide();
        	
        	$("#vacation_start_date").prop("disabled",false);
        	$("#vacation_end_date").prop("disabled",false);
        	$("#vacation_comment").prop("disabled",false);
        	$("input:radio[name='vacation_kind']").prop("disabled",false);
        	
        	// 파일 업로드 부분 초기화
        	$("#tr_vacation_file").hide();
        	$("#file_name").html("");
        	$("#file_up_span").show();
			$("#file_down_span").hide();	
        	
			$("#vacation-action-dialog").dialog({
				height: 600,
				width: 800,
				closeOnEscape : true,
				draggable : false,
				appendTo : "#vacationActionFrm",
				title: "휴가 신청",
				buttons:{
					"휴가 신청" : function(){
						var action = fnVacationAction('C');
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
		
		
		
		function fnVacationMod(){
			var label1 = "내용 수정";
			var label2 = "신청 취소";
			var label3 = "창닫기";
			var modalButtons = {};
			if ( $("#vacation_mod_state").val() == 0){
				modalButtons[label1] = function(){ if(!confirm("수정 하시겠습니까?"))return;  fnVacationAction('U') };
				modalButtons[label2] = function(){ if(!confirm("신청 취소 하시겠습니까?"))return; fnVacationAction('D') };
				modalButtons[label3] = function(){ $(this).dialog("close") };
			}else if( $("#vacation_mod_state").val() == 1 ){
				modalButtons[label2] = function(){ if(!confirm("신청 취소 하시겠습니까?"))return; fnVacationAction('D') };
				modalButtons[label3] = function(){ $(this).dialog("close") };
			}else{
				modalButtons[label3] = function(){ $(this).dialog("close") };
			}
			
			$("#vacation-action-dialog").dialog({
				height: 600,
				width: 800,
				closeOnEscape : true,
				draggable : false,
				appendTo : "#vacationActionFrm",
				title: "휴가 내용 수정",
				buttons : modalButtons,
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});			
		}
		
		function fnVacationAction(action,vacationState){
			
			if (action == "C" || action == "U"){
				if ( !$("input:radio[name='vacation_kind']").is(":checked") ){
					alert("휴가 종류를 선택 해 주세요..");
					return false;
				}
				
				if ( $("#vacation_comment").val() == "" ){
					alert("휴가 사유를 입력 해 주세요..");
					return false;
				}
				
				if ( $("#vacation_start_date").val() == "" ){
					alert("휴가 시작일을 입력 해 주세요..");
					return false;
				}
				
				if ( $("#vacation_end_date").val() == "" ){
					alert("휴가 종료일을 입력 해 주세요..");
					return false;
				}
				
				if ( $("input:radio[name='vacation_kind']:checked").val() == 5
					&& ( $("#vacation_start_date").val() != $("#vacation_end_date").val() )	){
					alert("반차는 시작일과 종료일이 같아야 합니다..");
					return false;
				}				
				
				if ( $("input:radio[name='vacation_kind']:checked").val() == 30 && $("#vacation_file").val() == ""){
					alert("예비군(민방위)의 경우 반드시 증적자료를 첨부하셔야 합니다.");					 
					return false;
					
				}
			}
			
			var url = "/actionVacation";

			
		    var param = new FormData();
		    
		    var vacationFile = $('#vacation_file')[0].files[0];
		    param.append('vacationFile', vacationFile);
		    
		    param.append("action",action);
		    
		    if (action == 'U'|| action == 'D' ||action == 'FD'){
		    	param.append("vacationNo", $("#vacation_mod_no").val());
		    }		    
		    
		    param.append("userNo", $("#vacation_user_no").val());
		    param.append("teamId", $("#vacation_team_id").val());
		    
		    param.append("vacationTeamType", $("#vacation_team_type").val());
		    param.append("vacationStartDate", $("#vacation_start_date").val().replace(/-/gi,""));
		    param.append("vacationEndDate", $("#vacation_end_date").val().replace(/-/gi,""));
		    param.append("vacationComment", $("#vacation_comment").val());
		    param.append("vacationKind", $("input:radio[name='vacation_kind']:checked").val());
		    
		    param.append("teamManager", $("#teamManager").val());
		    param.append("teamManagerYn", $("#teamManagerYn").val());
		    param.append("centerManager", $("#centerManager").val());		    
		    
		    //재기동 이후 수정필요 else if 문 by top3009 
			if ($("#vacation_remain_cnt").val() <= 0){
			    param.append("vacationRemainCnt", 0);
			}else{
				param.append("vacationRemainCnt", $("#vacation_remain_cnt").val());
			}
			
			
		    /*
 		    var param = {};
		    param.action = action;
		    
		    if (action == 'U'||action == 'D'){
		    	param.vacationNo = $("#vacation_mod_no").val();
		    }
		    
		    param.userNo = $("#vacation_user_no").val();
		    param.teamId = $("#vacation_team_id").val();
		    
		    param.vacationTeamType= $("#vacation_team_type").val();
		    param.vacationStartDate = $("#vacation_start_date").val().replace(/-/gi,"");
		    param.vacationEndDate = $("#vacation_end_date").val().replace(/-/gi,"");
		    param.vacationComment = $("#vacation_comment").val();
		    param.vacationKind= $("input:radio[name='vacation_kind']:checked").val();
		    
		    param.teamManager =$("#teamManager").val();
		    param.teamManagerYn =$("#teamManagerYn").val();
		    param.centerManager =$("#centerManager").val();
		    
			if ($("#vacation_remain_cnt").val() <= 0){
			    param.vacationRemainCnt = 0;
			}else{
				param.vacationRemainCnt = $("#vacation_remain_cnt").val();
			}
			*/
			
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
		        	
		        	if (data.result != "0100" ){
		        		alert(data.msg);
		        	}
		        	
		        	if (data.result == "0000" ){//신청
		        		location.reload();
		        	
		        	}else if (data.result == "0010"){//수정
		        		fnGoPage(pageIdx);
		        		$("#vacation-action-dialog").dialog("close");
		        		
		        	}else if (data.result == "0020"){//취소
		        		fnGoPage(pageIdx);
		        		$("#vacation-action-dialog").dialog("close");
		        		
		        	}else if (data.result == "0100"){//파일 삭제
			        	$("#file_name").html("");
			        	$("#file_up_span").show();
						$("#file_down_span").hide();
		        	}
		        	
	        		return;
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });
		}	
	
	
	</script>
