<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${title_Session}</title>	
	<form id="cardActionFrm">
		<input type="hidden" id="ckey_val" name="ckey_val"/>		
		<div id="card-action-dialog" title="카드등록" style="font-size: 15px;display:none;" align="center">
			<br/>
			<div class="tableStyle2" style="width: 750px;">
				<table class="vacation-ins-table">					
					<tbody>					
						<tr>
							<th width="20%">카드 사용자</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">								
								<select id="srchUserNo" name="srchUserNo" style="width:200px;text-align:left;">
									<option value="0"> - 미등록 - </option>
									<option value="99999"> - 공용 - </option>
									<c:forEach items="${memberList}" var="item" >
										<option value="${item.userNo}">${item.userName}</option>									
									</c:forEach>
								</select>
							</td>						
							<th width="20%">카드 사용 부서</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">								
								<select id="tmSearch" name="tmSearch" style="width:200px;text-align:left;">
								<option value="9999" selected> - 미지정 - </option>
								<c:forEach items="${teamList}" var = "teamVo">
									<option value="${teamVo.teamId}">
										<c:if test="${teamVo.teamLevel == 1}">&nbsp;└</c:if>
										<c:if test="${teamVo.teamLevel == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
										${teamVo.teamName}
									</option>
								</c:forEach>
							</select>
							</td>											
						</tr>
						<tr>
							<th width="20%" height="30"><font color="red">*</font> 카드 종류</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								<select id="srchCardType" name="srchCardType" style="width:200px;text-align:left;">
									<option value=""> - 선택 - </option>
									<c:forEach items="${cardTypeList}" var="item" >
										<option value="${item.col_cd}">${item.col_val}</option>									
									</c:forEach>										
								</select>
							</td>
							<th width="20%"><font color="red">*</font> 카드 상태</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								<select id="srchCardState" name="srchCardState" style="width:200px;text-align:left;">
									<option value=""> - 선택 - </option>
									<c:forEach items="${cardStateList}" var="item" >
										<option value="${item.col_cd}">${item.col_val}</option>									
									</c:forEach>										
								</select>
							</td>
						</tr>
						<tr>
							<th width="20%" height="30">등록일</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="text" class="classCalendar" id="reg_date" name="reg_date" style="width:120px;"/>
							</td>
							<th width="20%" height="30">최종 수정일</th>
							<td style="text-align:left;padding-left:5px;">
								<span id="mod_date"></span>
								<!-- <input type="text" class="classCalendar" id="mod_date" name="mod_date" style="width:120px;"/> -->
							</td>							
						</tr>
						<tr>
							<th width="20%" height="30"><font color="red">*</font> 카드 번호</th>
							<td align="left" style="text-align:left;padding-left:5px;">
								<input type="text" id="card_number" name="card_number" maxlength="15" style="width:200px;">																
							</td>
							<th width="20%" height="30"> 카드 별칭(공용)</th>
							<td align="left" style="text-align:left;padding-left:5px;">
								<input type="text" id="card_uid" name="card_uid" maxlength="30" style="width:200px;">																
							</td>
						</tr>
						<tr>
							<th width="20%" height="30"> 카드 시리얼 번호</th>
							<td align="left" style="text-align:left;padding-left:5px;">
								<input type="text" id="card_serial_no" name="card_serial_no" maxlength="15" style="width:200px;">																
							</td>
							<th width="20%" height="30"><font color="red">*</font> 카드 사용지점</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								<select id="srchCardZone" name="srchCardZone" style="width:200px;text-align:left;">
									<option value=""> - 선택 - </option>
									<c:forEach items="${cardZoneList}" var="item" >
										<option value="${item.col_cd}">${item.col_val}</option>									
									</c:forEach>										
								</select>
							</td>
						</tr>						
						<tr>
							<th width="20%" height="200">카드 메모</th>
							<td colspan="3" align="left" style="text-align:left;padding-left:5px;">
								<textarea rows="12" cols="72" id="card_memo" name="card_memo"></textarea>
							</td>
						</tr>						
					</tbody>																																																							
				</table>
				<div style="text-align:left;padding-left:5px;padding-top:5px;font-size:12px;">
					<font color="red">*</font> 필수 입력 값
				</div>
			</div>
		</div>
	</form>
	
	<form id="cardLabelPrintFrm">
		<input type="hidden" id="ckey_array"/>
		<input type="hidden" id="chkCkeyVal"/>
		<input type="hidden" id="downType"/>
		<div id="card-label-print-dialog" title="장비 라벨 출력" style="font-size: 15px;display:none;" align="center">
			<br/>
			<div class="tableStyle2" style="width: 350px;">
				<table class="vacation-ins-table">					
					<tbody>
						<tr>																				
							<th width="40%">체크 된 카드 수</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								<span id="chkCkey">0</span> 개																
							</td>											
						</tr>
						<tr>																				
							<th width="40%">사진 표시여부</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								<input type="radio" id = "label_photo_check_1" name="label_photo_check" value="1" checked /> 표시함 &nbsp;&nbsp;
								<input type="radio" id = "label_photo_check_0" name="label_photo_check" value="0" disabled/> 표시안함																	
							</td>											
						</tr>
					</tbody>																																																							
				</table>				
			</div>
		</div>
	</form>
	
	<form id="cardLabelPrintDown" name="cardLabelPrintDown" action="card_label_print" method="POST" target="_blank">
		<input type="hidden" id="label_ckey_cnt" name="label_ckey_cnt"/>
		<input type="hidden" id="label_ckey_array" name="label_ckey_array"/>		
		<input type="hidden" id="label_photo_chk" name="label_photo_chk"/>
		<input type="hidden" id="label_down_type" name="label_down_type"/>		
	</form>
	
	<script type='text/javascript'>
		
		function fnCardAction( action ){			
			
			var sUrl = "card_action";
			
			var ckey_val = $("#ckey_val").val();
			var user_no_val = $("#srchUserNo").val();
			var team_id_val = $("#tmSearch").val();			
			var card_type_val = $("#srchCardType").val();
			var card_state_val = $("#srchCardState").val();
			var card_zone_val = $("#srchCardZone").val();
			var reg_date_val = $("#reg_date").val();
			var mod_date_val = $("#mod_date").val();
			var card_number_val = $("#card_number").val();
			var card_uid_val = $("#card_uid").val();
			var card_serial_no_val = $("#card_serial_no").val();
			var card_memo_val = $("#card_memo").val();			
			
			var param = {};
			
			param.ckey = ckey_val;
			param.user_no = user_no_val;
			param.team_id = team_id_val;
			param.card_type = card_type_val;
			param.card_state = card_state_val;
			param.card_zone = card_zone_val;
			param.reg_date = reg_date_val;
			param.mod_date = mod_date_val;
			param.card_number = card_number_val;
			param.card_uid = card_uid_val;
			param.card_serial_no = card_serial_no_val;		
			param.card_memo = card_memo_val;
			param.action = action;			
									
			if( action == "I" || action == "U" ){				//장비등록 또는 수정인 경우
				
				if( card_type_val == "" ){
					alert("카드 종류를 선택해 주세요.");
					$("#srchCardType").focus();
					return;
				}
				
				if( card_state_val == "" ){		//선택안한경우
					alert("카드 상태를 선택해 주세요.");
					$("#srchCardState").focus();
					return;
				}
				
				if( card_zone_val == "" ){		//선택안한경우
					alert("카드 사용지점을 선택해 주세요.");
					$("#srchCardZone").focus();
					return;
				}
				
				if( card_number_val == "" ){
					alert("카드 일련번호를 입력해주세요.");
					$("#card_number").focus();
					return;
				}
				
			}else if( action == "D" ){			//카드 삭제(D)				
				if( !confirm("카드를 삭제하시겠습니까?") ){
					return;
				}			
			}
			
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
						alert("카드를 등록하였습니다.");
						$("#card-action-dialog").dialog("close");							
						$("#searchFrm").submit();
       	        	}else if(data == 2){
       	        		alert("카드정보를 수정하였습니다.");
						$("#card-action-dialog").dialog("close");							
						$("#searchFrm").submit();
       	        	}else if(data == 3){
       	        		alert("카드정보를 삭제하였습니다.");
						$("#card-action-dialog").dialog("close");							
						$("#searchFrm").submit();
       	        	}else if(data == 9){
       	        		alert("동일한 카드번호가 존재합니다.");
       	        		return;
       	        	}else{
       	        		alert("필수입력값이 없어 실패하였습니다.");
       	        		return;
       	        	}
       	        },
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}
			});			
		}
		
		//인사관리쪽 등록 Action
		function popCardAction( action ){			
			
			var sUrl = "card_action";
			
			var ckey_val = $("#ckey_val").val();
			var user_no_val = $("#srchUserNo").val();
			var team_id_val = $("#tmSearch").val();			
			var card_type_val = $("#srchCardType").val();
			var card_state_val = $("#srchCardState").val();
			var card_zone_val = $("#srchCardZone").val();
			var reg_date_val = $("#reg_date").val();						
			var card_number_val = $("#card_number").val();
			var card_uid_val = $("#card_uid").val();
			var card_serial_no_val = $("#card_serial_no").val();
			var card_memo_val = $("#card_memo").val();			
			
			var param = {};
			
			param.ckey = ckey_val;
			param.user_no = user_no_val;
			param.team_id = team_id_val;
			param.card_type = card_type_val;
			param.card_state = card_state_val;
			param.card_zone = card_zone_val;
			param.reg_date = reg_date_val;			
			param.card_number = card_number_val;
			param.card_uid = card_uid_val;
			param.card_serial_no = card_serial_no_val;
			param.card_memo = card_memo_val;
			param.action = action;			
									
			if( action == "I" || action == "U" ){				//장비등록 또는 수정인 경우
				
				if( card_type_val == "" ){
					alert("카드 종류를 선택해 주세요.");
					$("#srchCardType").focus();
					return;
				}
				
				if( card_state_val == "" ){		//선택안한경우
					alert("카드 상태를 선택해 주세요.");
					$("#srchCardState").focus();
					return;
				}
				
				if( card_zone_val == "" ){		//선택안한경우
					alert("카드 사용지점을 선택해 주세요.");
					$("#srchCardZone").focus();
					return;
				}
				
				if( card_number_val == "" ){
					alert("카드 일련번호를 입력해주세요.");
					$("#card_number").focus();
					return;
				}
				
			}else if( action == "D" ){			//카드 삭제(D)				
				if( !confirm("카드를 삭제하시겠습니까?") ){
					return;
				}			
			}
			
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
						alert("카드를 등록하였습니다.");
						$("#card-action-dialog").dialog("close");							
						location.reload();
       	        	}else if(data == 2){
       	        		alert("카드정보를 수정하였습니다.");
						$("#card-action-dialog").dialog("close");							
						location.reload();
       	        	}else if(data == 3){
       	        		alert("카드정보를 삭제하였습니다.");
						$("#card-action-dialog").dialog("close");							
						location.reload();
       	        	}else if(data == 9){
       	        		alert("동일한 카드번호가 존재합니다.");
       	        		return;
       	        	}else{
       	        		alert("필수입력값이 없어 실패하였습니다.");
       	        		return;
       	        	}
       	        },
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}
			});
			
		}
		
		
		//카드 수정 폼
		function fnCardMod( ckey ){
			
			var sUrl = "get_card_info";
			
			var param = {};
			param.ckey = ckey;			
			
			$.ajax({
		        type: "POST",
		        url: sUrl,
		        data: param,		         
		        dataType: "JSON", 
		        success: function(data){
	        		
	        		//수정폼 설정
	        		$("#ckey_val").val(data.ckey);
	    			$("#srchUserNo").val(data.user_no);
	    			$("#tmSearch").val(data.team_id);
	    			$("#srchCardType").val(data.card_type);
	    			$("#srchCardState").val(data.card_state);
	    			$("#srchCardZone").val(data.card_zone);
	    			$("#reg_date").val(data.reg_date);
	    			$("#mod_date").text(data.mod_date);
	    			$("#card_number").val(data.card_number);	    			
	    			$("#card_memo").val(data.card_memo);
	    			$("#card_uid").val(data.card_uid);
	    			$("#card_serial_no").val(data.card_serial_no);
	        		
	    			$("#card-action-dialog").dialog({
	    				height: 550,
	    				width: 800,
	    				closeOnEscape : true,
	    				draggable : true,
	    				appendTo : "#cardActionFrm",
	    				title: "카드 수정",
	    				buttons:{
	    					"카드 삭제" : function(){
	    						var action = fnCardAction('D');		//삭제
	    						if (action){
	    							$(this).dialog("close");
	    						}
	    					},
	    					"카드 수정" : function(){
	    						var action = fnCardAction('U');		//수정
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
	    			
	    			$("#srchUserNo").select2({
	    				dropdownParent: $("#card-action-dialog")	
	    			});
	    			
	    			$("#tmSearch").select2({
	    				dropdownParent: $("#card-action-dialog")	
	    			});
	    			
	    			$("#srchCardType").select2({
	    				dropdownParent: $("#card-action-dialog")	
	    			});
	    			
	    			$("#srchCardState").select2({
	    				dropdownParent: $("#card-action-dialog")	
	    			});
	    			
	    			$("#srchCardZone").select2({
	    				dropdownParent: $("#card-action-dialog")	
	    			});
	    			
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });
		}
		
		//카드 등록 폼
		function fnCardIns(){
			
			//등록폼 초기화
			$("#srchUserNo option:eq(0)").prop('selected', true);
			$("#tmSearch option:eq(0)").prop('selected', true);
			$("#srchCardType option:eq(0)").prop('selected', true);
			$("#srchCardState option:eq(0)").prop('selected', true);
			$("#srchCardZone option:eq(0)").prop('selected', true);
			$("#reg_date").val('');
			$("#card_number").val('');
			$("#card_uid").val('');
			$("#card_serial_no").val('');
			$("#card_memo").val('');
			
			$("#card-action-dialog").dialog({
				height: 550,
				width: 800,
				closeOnEscape : true,
				draggable : true,
				appendTo : "#cardActionFrm",
				title: "카드 등록",
				buttons:{
					"카드 등록" : function(){
						var action = fnCardAction('I');		//등록
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
			
			$("#srchUserNo").select2({
				dropdownParent: $("#card-action-dialog")	
			});
			
			$("#tmSearch").select2({
				dropdownParent: $("#card-action-dialog")	
			});
			
			$("#srchCardType").select2({
				dropdownParent: $("#card-action-dialog")	
			});
			
			$("#srchCardState").select2({
				dropdownParent: $("#card-action-dialog")	
			});
			
			$("#srchCardZone").select2({
				dropdownParent: $("#card-action-dialog")	
			});
		}
		
		//카드 라벨 출력 폼
		function fnCardLabelPrint( ckey ){
						
			$("#ckey_array").val(ckey);						
			
			$("#card-label-print-dialog").dialog({
				height: 240,
				width: 400,
				closeOnEscape : true,
				draggable : true,
				appendTo : "#cardLabelPrintFrm",
				title: "카드 라벨 관리",
				buttons:{					
					"라벨 프린트" : function(){
						var action = fnCardLabelPrintOk();		//라벨출력
						$("#downType").val("print");
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
		
		//카드 라벨 출력
		function fnCardLabelPrintOk(){
			
			var ckey_array = $("#ckey_array").val();		//체크된 카드 ckey
			var ckey_cnt = $("#chkCkeyVal").val();			//체크된 카드수			
			var labelPhotoChk = $('input[name=label_photo_check]:checked').val();
			var downTypeVal = $("#downType").val();
			
			$("#label_ckey_cnt").val(ckey_cnt);
			$("#label_ckey_array").val(ckey_array);			
			$("#label_photo_chk").val(labelPhotoChk);
			$("#label_down_type").val(downTypeVal);
			
			$("#card-label-print-dialog").dialog("close");
			
			$("#cardLabelPrintDown").submit();			
		}
	</script>