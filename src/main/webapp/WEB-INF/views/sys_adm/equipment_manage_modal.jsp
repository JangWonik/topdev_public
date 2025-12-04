<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${title_Session}</title>	
	<form id="equipmentActionFrm">
		<input type="hidden" id="serial_no_val" name="serial_no_val"/>		
		<div id="equipment-action-dialog" title="장비등록" style="font-size: 15px;display:none;" align="center">
			<br/>
			<div class="tableStyle2" style="width: 750px;">
				<table class="vacation-ins-table">					
					<tbody>					
						<tr>
							<th width="20%">장비 사용자</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">								
								<select id="srchUserNo" name="srchUserNo" style="width:200px;text-align:left;">
									<option value="0"> - 미등록 - </option>
									<option value="99999"> - 공용 - </option>
									<c:forEach items="${memberList}" var="item" >
										<option value="${item.userNo}">${item.userName}</option>									
									</c:forEach>										
								</select>
							</td>						
							<th width="20%">장비 사용 부서</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">								
								<select id="tmSearch" name="tmSearch" style="width:200px;text-align:left;">
								<option value="9999" selected> - 서버실 - </option>
								<c:forEach items="${teamList}" var = "teamVo">
									<option value="${teamVo.teamId}"
										<%-- <c:if test="${searchVO.tmSearch == teamVo.team_id}">selected</c:if> --%>>
										<c:if test="${teamVo.teamLevel == 1}">&nbsp;└</c:if>
										<c:if test="${teamVo.teamLevel == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
										${teamVo.teamName}
									</option>
								</c:forEach>
							</select>
							</td>											
						</tr>
						<tr>
							<th width="20%" height="30"><font color="red">*</font> 장비 종류</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								<select id="srchEqType" name="srchEqType" style="width:200px;text-align:left;">
									<option value="0"> - 선택 - </option>
									<c:forEach items="${eqTypeList}" var="item" >
										<option value="${item.col_cd}">${item.col_val}</option>									
									</c:forEach>										
								</select>
							</td>
							<th width="20%"><font color="red">*</font> 장비 상태</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								<select id="srchEqState" name="srchEqState" style="width:200px;text-align:left;">
									<option value="0"> - 선택 - </option>
									<c:forEach items="${eqStateList}" var="item" >
										<option value="${item.col_cd}">${item.col_val}</option>									
									</c:forEach>										
								</select>
							</td>
						</tr>
					</table>
					
					<!-- cpu info, memory size 입력 시작 -->
					<div id="pcInfoDetail" style="display:none;">
						<table  class="vacation-ins-table">	
							<tr>
								<th width="20%" height="30">CPU 종류</th>									
								<td style="text-align:left;padding-left: 5px;font-weight:bold;">
									<select id="cpuInfoType" name="cpuInfoType" style="width:200px;text-align:left;">
										<option value="0"> - 선택 - </option>
										<c:forEach items="${cpuInfoList}" var="item" >
											<option value="${item.col_cd}">${item.col_val}</option>									
										</c:forEach>										
									</select>								
								</td>
								<th width="20%" height="30">RAM 크기</th>
								<td style="text-align:left;padding-left:5px;">
									<input type="text" id="memorySize" name="memorySize" value="0" maxlength="3" style="width:100px;"/> GByte
								</td>
							</tr>
						</table>						
					</div>
					<!-- cpu info, memory size 입력 끝 -->
						
					<table  class="vacation-ins-table">	
						<tr>
							<th width="20%" height="30">등록일</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="text" class="classCalendar" id="reg_date" name="reg_date" style="width:120px;"/>
							</td>
							<th width="20%" height="30">폐기일</th>
							<td style="text-align:left;padding-left:5px;">
								<input type="text" class="classCalendar" id="close_date" name="close_date" style="width:120px;"/>
							</td>
						</tr>
						<tr>
							<th width="20%" height="30"><font color="red">*</font> 장비 일련번호</th>
							<td colspan="3" align="left" style="text-align:left;padding-left:5px;">
								<input type="text" id="eq_no" name="eq_no" maxlength="30" style="width:200px;">
								&nbsp;<a href="#noloc" class="btn-vacation-list-ins" id="btn-auto-create">자동생성</a>								
							</td>
						</tr>
						<tr>
							<th width="20%" height="30">장비 가격</th>
							<td colspan="3" align="left" style="text-align:left;padding-left:5px;">
								<input type="text" id="eq_price" name="eq_price" maxlength="30" style="width:200px;text-align:right;" value="0"> 원																
							</td>
						</tr>
						<tr>
							<th width="20%" height="200">장비 메모</th>
							<td colspan="3" align="left" style="text-align:left;padding-left:5px;">
								<textarea rows="12" cols="73" id="eq_memo" name="eq_memo"></textarea>
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
	
	<form id="equipmentActionAllFrm">
		<input type="hidden" id="serial_no_array"/>
		<div id="equipment-action-all-dialog" title="장비일괄수정" style="font-size: 15px;display:none;" align="center">
			<br/>
			<div class="tableStyle2" style="width: 350px;">
				<table class="vacation-ins-table">					
					<tbody>					
						<tr>													
							<th width="30%">장비 사용 부서</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">								
								<select id="tmSearchAll" name="tmSearchAll" style="width:200px;text-align:left;">
								<option value="9999" selected> - 서버실 - </option>
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
					</tbody>																																																							
				</table>				
			</div>
		</div>
	</form>
	
	<form id="equipmentLabelPrintFrm">
		<input type="hidden" id="serial_no_array"/>
		<input type="hidden" id="chkSerialNoVal"/>
		<input type="hidden" id="downType"/>
		<div id="equipment-label-print-dialog" title="장비 라벨 출력" style="font-size: 15px;display:none;" align="center">
			<br/>
			<div class="tableStyle2" style="width: 350px;">
				<table class="vacation-ins-table">					
					<tbody>
						<tr>																				
							<th width="40%">체크 된 장비 수</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								<span id="chkSerialNo">0</span> 개																
							</td>											
						</tr>					
						<tr>																				
							<th width="40%">확 인 일 자</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								<input type="text" class="classCalendar" id="chkDate" name="chkDate" style="width:100px;"/>
							</td>											
						</tr>
						<tr>																				
							<th width="40%">장비메모 표시여부</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								<input type="radio" id = "label_memo_check_0" name="label_memo_check" value="0" checked/> 표시안함 &nbsp;&nbsp;
								<input type="radio" id = "label_memo_check_1" name="label_memo_check" value="1" /> 표시함									
							</td>											
						</tr>
					</tbody>																																																							
				</table>				
			</div>
		</div>
	</form>
	
	<form id="equipmentLabelPrintDown" name="equipmentLabelPrintDown" action="equipment_label_print" method="POST" target="_blank">
		<input type="hidden" id="label_serial_no_cnt" name="label_serial_no_cnt"/>
		<input type="hidden" id="label_serial_no_array" name="label_serial_no_array"/>
		<input type="hidden" id="label_chk_date" name="label_chk_date"/>
		<input type="hidden" id="label_memo_chk" name="label_memo_chk"/>
		<input type="hidden" id="label_down_type" name="label_down_type"/>		
	</form>
	
	<script type='text/javascript'>
		$("#btn-auto-create").click(function(){
			var makeKey = makeRandam();
			$("#eq_no").val(makeKey);			
		});
		
		
		//장비가 데스크 탑인 경우 CPU와 MEMORY SIZE 입력
		$("#srchEqType").change(function(){
			
			var eqTypeVal = $("#srchEqType").val();			
			
			if( eqTypeVal == 1 ){
				$("#pcInfoDetail").show();
			}else{
				//PC정보 초기화
				$("#cpuInfoType option:eq(0)").prop('selected', true);
				$("#memorySize").val('0');
				$("#pcInfoDetail").hide();
			}
		});
		
		//랜덤 키 생성 함수 
		function makeRandam(){
			var tail_key = Math.floor(Math.random() * 100) + 1;
			var today = new Date();
			var dd = today.getDate();
			var mm = today.getMonth()+1;
			var yyyy = today.getFullYear();
			if(dd < 10) {
			    dd = '0'+dd
			}
			if(mm < 10) {
			    mm = '0'+mm
			}
			
			today = yyyy+mm+dd;
			
			//장비종류를 확인하여 모니터면 key 앞에 M을 붙여준다.
			var eq_type_val = $("#srchEqType").val();			
			
			if( eq_type_val == 2 ){		//장비가 모니터인 경우
				today = "M"+today.toString().substring(2)+tail_key;
			}else{
				today = today.toString().substring(2)+tail_key;	
			}
			
			return today;
		}
		
		function fnEquipmentLabelPrintOk(){
						
			var serial_no_array = $("#serial_no_array").val();		//체크된 장비 Serial_no
			var serial_no_cnt = $("#chkSerialNoVal").val();			//체크된 장비수
			var chk_date_val = $("#chkDate").val();
			var labelMemoChk = $('input[name=label_memo_check]:checked').val();
			var downTypeVal = $("#downType").val();			
			
			$("#label_serial_no_cnt").val(serial_no_cnt);
			$("#label_serial_no_array").val(serial_no_array);
			$("#label_chk_date").val(chk_date_val);
			$("#label_memo_chk").val(labelMemoChk);
			$("#label_down_type").val(downTypeVal);
			
			$("#equipment-label-print-dialog").dialog("close");
			
			$("#equipmentLabelPrintDown").submit();			
		}
		
		function fnEquipmentActionAll( action ){
			
			var sUrl = "equipment_action_all";
			
			var team_id_val = $("#tmSearchAll").val();
			var serial_no_array = $("#serial_no_array").val();
			
			var param = {};			
			param.serial_no = serial_no_array;		//콤마로 구분된 serial_no (1개의 경우 콤마 없음)
			param.team_id = team_id_val;
			
			if( action == "AU" ){			//일괄 수정
				
				param.action = "AU";
				
				if(confirm("선택하신 장비사용부서로 체크된 장비를 이동하시겠습니까?")){
					
					$.ajax({
						type: "POST",
		       	        url: sUrl,
		       	        data: param,
		       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		       	        timeout: 20000,
		       	        async: false,
		       	        dataType: "html", 
		       	        success: function(data){		       	        	
		       	        	if (data > 0){
								alert(data+"건의 장비를 수정하였습니다.");
								$("#equipment-action-all-dialog").dialog("close");								
								//재검색
								$("#searchFrm").submit();
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
			
			}else if( action == "AC"){
				
				param.action = "AC";
				
				if(confirm("선택하신 장비를 폐기하시겠습니까?")){

					$.ajax({
						type: "POST",
		       	        url: sUrl,
		       	        data: param,
		       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		       	        timeout: 20000,
		       	        async: false,
		       	        dataType: "html", 
		       	        success: function(data){		       	        	
		       	        	if (data > 0){
								alert(data+"건의 장비를 폐기하였습니다.");
								//재검색
								$("#searchFrm").submit();
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
				
			}else if( action == "AD"){
				
				param.action = "AD";
				
				if(confirm("선택하신 장비를 삭제시겠습니까?\n삭제된 장비는 조회만 가능합니다.")){

					$.ajax({
						type: "POST",
		       	        url: sUrl,
		       	        data: param,
		       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		       	        timeout: 20000,
		       	        async: false,
		       	        dataType: "html", 
		       	        success: function(data){		       	        	
		       	        	if (data > 0){
								alert(data+"건의 장비를 삭제하였습니다.");
								//재검색
								$("#searchFrm").submit();
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
			}
		}
		
		function fnEquipmentAction( action ){			
			
			var sUrl = "equipment_action";
			
			var serial_no_val = $("#serial_no_val").val();
			var user_no_val = $("#srchUserNo").val();
			var team_id_val = $("#tmSearch").val();			
			var eq_type_val = $("#srchEqType").val();
			var eq_state_val = $("#srchEqState").val();			
			var reg_date_val = $("#reg_date").val();
			var close_date_val = $("#close_date").val();			
			var eq_no_val = $("#eq_no").val();
			var eq_price_val = $("#eq_price").val();
			var eq_memo_val = $("#eq_memo").val();			
			var cpu_info_val = $("#cpuInfoType").val();
			var memory_size_val = $("#memorySize").val();
			
			var param = {};
			
			param.serial_no = serial_no_val;
			param.user_no = user_no_val;
			param.team_id = team_id_val;
			param.eq_type = eq_type_val;
			param.eq_state = eq_state_val;
			param.reg_date = reg_date_val;
			param.close_date = close_date_val;
			param.eq_no = eq_no_val;
			param.eq_price = eq_price_val;
			param.eq_memo = eq_memo_val;
			param.cpu_info = cpu_info_val;
			param.memory_size = memory_size_val;
			
			param.action = action;
			
			//alert("수정시작");
			//return;
									
			if( action == "I" || action == "U" ){				//장비등록 또는 수정인 경우				
				
				//장비종류는 필수 입력값
				if( eq_type_val == "0" ){
					alert("장비 종류를 선택해 주세요.");
					$("#srchEqType").focus();
					return;
				}
				if( eq_state_val == "0" ){		//선택안한경우
					alert("장비 상태를 선택해 주세요.");
					$("#srchEqState").focus();
					return;
				}				
				
				if( eq_no_val == "" ){
					alert("장비 일련번호를 입력해주세요.");
					$("#eq_no").focus();
					return;
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
							alert("장비를 등록하였습니다.");
							$("#equipment-action-dialog").dialog("close");
							//location.href="./equipment_manage_main";
							//재검색
							$("#searchFrm").submit();
	       	        	}else if(data == 2){
	       	        		alert("장비정보를 수정하였습니다.");
							$("#equipment-action-dialog").dialog("close");
							//location.href="./equipment_manage_main";
							//재검색
							$("#searchFrm").submit();
	       	        	}else if(data == 9){
	       	        		alert("동일한 장비일련번호가 존재합니다.");
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
			
		}
		
		//장비 일괄 삭제
		function fnEquipmentDeleteAll( serial_no ){			
			$("#serial_no_array").val(serial_no);			
			fnEquipmentActionAll('AD');		//일괄 삭제
		}
		
		//장비 일괄 폐기
		function fnEquipmentCloseAll( serial_no ){			
			$("#serial_no_array").val(serial_no);			
			fnEquipmentActionAll('AC');		//일괄 수정
		}
		
		//장비 라벨 출력 폼
		function fnEquipmentLabelPrint( serial_no ){
						
			$("#serial_no_array").val(serial_no);						
			
			$("#equipment-label-print-dialog").dialog({
				height: 240,
				width: 400,
				closeOnEscape : true,
				draggable : true,
				appendTo : "#equipmentLabelPrintFrm",
				title: "장비 라벨 관리",
				buttons:{
					"엑셀 다운로드" : function(){
						$("#downType").val("excel");
						var action = fnEquipmentLabelPrintOk();		//엑셀다운로드
						if (action){
							$(this).dialog("close");
						}
					},
					"라벨 프린트" : function(){
						var action = fnEquipmentLabelPrintOk();		//라벨출력
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
		
		//장비 일괄 수정 폼
		function fnEquipmentModAll( serial_no ){
						
			$("#serial_no_array").val(serial_no);
			
			$("#equipment-action-all-dialog").dialog({
				height: 300,
				width: 400,
				closeOnEscape : true,
				draggable : true,
				appendTo : "#equipmentActionAllFrm",
				title: "장비 일괄 수정",
				buttons:{
					"일괄 수정" : function(){
						var action = fnEquipmentActionAll('AU');		//일괄 수정
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
			
			$("#tmSearchAll").select2({
				dropdownParent: $("#equipment-action-all-dialog")	
			});
			
		}
		
		//장비 수정 폼
		function fnEquipmentMod( serial_no ){
			
			var sUrl = "get_equipment_info";
			
			var param = {};
			param.serial_no = serial_no;			
			
			$.ajax({
		        type: "POST",
		        url: sUrl,
		        data: param,		         
		        dataType: "JSON", 
		        success: function(data){	        		
	        		//alert(JSON.stringify(data));
	        		//alert("data="+data.user_no);
	        		
	        		//수정폼 설정
	        		$("#serial_no_val").val(data.serial_no);
	    			$("#srchUserNo").val(data.user_no);
	    			$("#tmSearch").val(data.team_id);
	    			$("#srchEqType").val(data.eq_type);
	    			$("#srchEqState").val(data.eq_state);
	    			$("#reg_date").val(data.reg_date);
	    			$("#close_date").val(data.close_date);
	    			$("#eq_no").val(data.eq_no);
	    			$("#eq_price").val(data.eq_price);
	    			$("#eq_memo").val(data.eq_memo);
	    			
	    			$("#cpuInfoType").val(data.cpu_info);
	    			$("#memorySize").val(data.memory_size);
	    			
	    			//CPU, Memory 정보 조회 여부 확인
	    			if( data.eq_type == 1 ){
	    				$("#pcInfoDetail").show();
	    			}else{
	    				$("#pcInfoDetail").hide();
	    			}
	        		
	    			$("#equipment-action-dialog").dialog({
	    				height: 600,
	    				width: 800,
	    				closeOnEscape : true,
	    				draggable : true,
	    				appendTo : "#equipmentActionFrm",
	    				title: "장비 수정",
	    				buttons:{
	    					"장비 수정" : function(){
	    						var action = fnEquipmentAction('U');		//수정
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
	    				dropdownParent: $("#equipment-action-dialog")	
	    			});
	    			
	    			$("#tmSearch").select2({
	    				dropdownParent: $("#equipment-action-dialog")	
	    			});
	    			
	    			$("#srchEqType").select2({
	    				dropdownParent: $("#equipment-action-dialog")	
	    			});
	    			
	    			$("#srchEqState").select2({
	    				dropdownParent: $("#equipment-action-dialog")	
	    			});
	    			
	    			$("#cpuInfoType").select2({
	    				dropdownParent: $("#equipment-action-dialog")	
	    			});
	    			
		        },
		        error: function(e){
		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		        }
		    });
		}
		
		//장비 등록 폼
		function fnEquipmentIns(){
			
			//등록폼 초기화
			$("#srchUserNo option:eq(0)").prop('selected', true);
			$("#tmSearch option:eq(0)").prop('selected', true);
			$("#srchEqType option:eq(0)").prop('selected', true);
			$("#srchEqState option:eq(0)").prop('selected', true);
			$("#reg_date").val('');
			$("#close_date").val('');
			$("#eq_no").val('');
			$("#eq_price").val('0');
			$("#eq_memo").val('');
			
			$("#cpuInfoType option:eq(0)").prop('selected', true);
			$("#memorySize").val('0');
			
			$("#equipment-action-dialog").dialog({
				height: 600,
				width: 800,
				closeOnEscape : true,
				draggable : true,
				appendTo : "#equipmentActionFrm",
				title: "장비 등록",
				buttons:{
					"장비 등록" : function(){
						var action = fnEquipmentAction('I');		//등록
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
				dropdownParent: $("#equipment-action-dialog")	
			});
			
			$("#tmSearch").select2({
				dropdownParent: $("#equipment-action-dialog")	
			});
			
			$("#srchEqType").select2({
				dropdownParent: $("#equipment-action-dialog")	
			});
			
			$("#srchEqState").select2({
				dropdownParent: $("#equipment-action-dialog")	
			});
			
			$("#cpuInfoType").select2({
				dropdownParent: $("#equipment-action-dialog")	
			});
		}		
	</script>