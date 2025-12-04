<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<script>
			$(document).ready(function(){
				if ( $("#suimRptState").val() == 2 ) {//종결 상태이면
					$("#allDelayTr").append(
						"<td align='center' class='td'>"
						+	"<span class='printCtrlSpan' id='printCtrlAllDelaySpan'></span>"
						+	"<span class='printCtrlInputSpan' id='printCtrlAllDelayInputSpan' style='display:none;'>"
						+		"<input type='text' id='printCtrlAllDelayTxt' maxlength='4' size='4' value='' />"								
						+	"</span>"                                		
		    			+"</td>"
		    			+"<td rowspan='3' class='td'>"
		    			+	"<p align='center'>"
		   				+		"<span class='passTableSpan' id='ModBtnPrintCtrlDelaySpan' >"
						+			"<img src='./resources/ls_img/btn_edit_s.gif' onclick='javascript:printCtrlDelayModifyView();' style='cursor:pointer;'/>"
						+		"</span>"
						+		"<span class='passTableSpan' id='ModAftSaveBtnPrintCtrlDelaySpan' style='display:none;'>"			
						+			"<img src='./resources/ne_img/btn/btn_save.gif' onclick='javascript:printCtrlDelayUpdate()' style='cursor:pointer;'/>"
						+			"<br/><img src='./resources/ne_img/btn/btn_close.gif' onclick='javascript:printCtrlDelayModifyClose()' style='cursor:pointer;margin-top:5px;'/>"
						+		"</span>"
						+	"</p>"
		    			+"</td>"	
					);
						
					$("#notInsuDelayTr").append(
	               		"<td align='center' class='td'>"
						+	"<span class='printCtrlSpan' id='printCtrlNotInsuSpan'></span>"
						+	"<span class='printCtrlInputSpan' id='printCtrlNotInsuInputSpan' style='display:none;'>"
						+		"<input type='text' id='printCtrlNotInsuTxt' maxlength='4' size='4' value='' />"								
						+	"</span>"                                            		
	            		+"</td>"	
					);
					
					
					$("#insuDelayTr").append(
	               		"<td align='center' class='td'>"
						+	"<span class='printCtrlSpan' id='printCtrlInsuSpan'></span>"
						+	"<span class='printCtrlInputSpan' id='printCtrlInsuInputSpan' style='display:none;'>"
						+		"<input type='text' id='printCtrlInsuTxt' maxlength='4' size='4' value='' />"								
						+	"</span>"                                   		
	            		+"</td>"
					);
					
					var allDelayCnt = $("#allDelayCnt").val(); 
					var notInsuDelayCnt = $("#notInsuDelayCnt").val();
					var insuDelayCnt = $("#insuDelayCnt").val();		
					
					//종결 직후 DB에 저장된 값이 없으면 자동계산
					//계산된 값을 저장을 누른 후에는 저장함.
					if( (allDelayCnt == "" || allDelayCnt == "0") 
						&& (notInsuDelayCnt == "" || notInsuDelayCnt == "0") 
						&& (insuDelayCnt == "" || insuDelayCnt =="0" ) ){
						
						var regDate = $("#regDate").val();
						var closeDate = $("#closeDate").val();
						
						allDelayCnt = getDiffDays(regDate, closeDate) + 1;
						insuDelayCnt = $("#firstInsuDelayCnt").val();
						notInsuDelayCnt = allDelayCnt - insuDelayCnt;
						
						$("#printCtrlAllDelayTxt").val(allDelayCnt);
						$("#printCtrlNotInsuTxt").val(notInsuDelayCnt);
						$("#printCtrlInsuTxt").val(insuDelayCnt);
						
					}else{
						$("#printCtrlAllDelaySpan").html(allDelayCnt + "일");
						$("#printCtrlAllDelayTxt").val(allDelayCnt);
						
						$("#printCtrlNotInsuSpan").html(notInsuDelayCnt + "일");
						$("#printCtrlNotInsuTxt").val(notInsuDelayCnt);
						
						$("#printCtrlInsuSpan").html(insuDelayCnt + "일");
						$("#printCtrlInsuTxt").val(insuDelayCnt);
					}
					
				}else{//미결상태이면
					
					$("#allDelayTr").append("<td colspan='2' align='center' class='td'>미결</td>");
					$("#notInsuDelayTr").append("<td colspan='2' align='center' class='td'>미결</td>"	);		
					$("#insuDelayTr").append("<td colspan='2' align='center' class='td'>미결</td>");
				}
			});
		
			function calcDateCnt(index){
				var startDate = $("#printCtrlDateTxt"+index).val();
				var endDate = $("#printCtrlEndDateTxt"+index).val();
				
				if (endDate >= startDate){
					var dateCnt = getDiffDays(startDate, endDate) + 1;
					$("#printCtrlDateCntTxt"+index).val(dateCnt);
					$("#printCtrlDateCntSpan"+index).html(dateCnt+"일");
					
					$("#printCtrlDelayCntTxt"+index).val(dateCnt);
					$("#printCtrlDelayCntSpan"+index).html(dateCnt+"일");
				}else{
					alert("시작일이 종료일보다 클 수 없습니다.");
					$("#printCtrlEndDateTxt"+index).val("");
					$("#printCtrlEndDateTxt"+index).focus();
				}
			}
			
			
			
		  	//=================================
		  	//	사고처리과정표 - 처리과정
		  	//=================================		
			function fnSelectPick(obj,gubun,index){
				if(gubun == "1"){//사고처리과정표 - 항목
					if(obj.value == "999"){
						$("#printCtrlSubjectTxt"+index).val("");
						$("#printCtrlSubjectTxt"+index).css("display","block");
						$("#printCtrlSubjectTxt"+index).focus();
					}else{
						$("#printCtrlSubjectTxt"+index).val(obj.value);
						$("#printCtrlSubjectTxt"+index).css("display","none");
					}
				}else if(gubun == "2"){//사고처리과정표 - 처리내용
					if(obj.value == "999"){
						$("#printCtrlMemoTxt"+index).val("");
						$("#printCtrlMemoTxt"+index).css("display","block");
						$("#printCtrlMemoTxt"+index).focus();
					}else{
						$("#printCtrlMemoTxt"+index).val(obj.value);
						$("#printCtrlMemoTxt"+index).css("display","none");
					}				
				}else if(gubun == "3"){//첨부류 - 비고
					if(obj.value == "999"){
						$("#sagoDocNoteTxt"+index).val("");
						$("#sagoDocNoteTxt"+index).css("display","block");
						$("#sagoDocNoteTxt"+index).focus();
					}else{
						$("#sagoDocNoteTxt"+index).val(obj.value);
						$("#sagoDocNoteTxt"+index).css("display","none");
					}	
				}
			}
			
		  	
			//추가 - 닫기
			function printCtrlAddClose(index){
		  		$("#printCtrlAddBtn").css("display","block");
		  		$("#printCtrlTr"+index).html("");
			}
			
			//추가 - 저장
			function printCtrlInsert(index, flag){
				
				$.post("./ins9printCtrl"
						,{
							 rptPrintNo : $("#rptPrintNo").val()
							,controlDate: $("#printCtrlDateTxt"+index).val()
							,controlSubject: $("#printCtrlSubjectTxt"+index).val()
							,controlMemo: $("#printCtrlMemoTxt"+index).val()
							,controlEndDate : $("#printCtrlEndDateTxt"+index).val()
							,controlDelayAgent : $("#printCtrlDelayAgentSelect"+index).val()
							,controlDateCnt : $("#printCtrlDateCntTxt"+index).val()
							,controlDelayCnt : $("#printCtrlDelayCntTxt"+index).val()
							,flag : flag
						},
						function(data,status){
							$("#printCtrlAddBtn").css("display","block");
							if (data.trim() != "ERROR" && status == 'success'){
								$("#printCtrlOutSpan").html("");
								$("#printCtrlOutSpan").html(data);
								alert("저장에 성공하였습니다.");
								
							}else{
								alert("저장에 실패하였습니다. 잠시후 시도해주세요..");
							}
						}
				);// $.post("./insPrint1001Three1")
			}
			
			//삭제
			function printCtrlDelete(serialNo,flag){
				var r = confirm("삭제 하시겠습니까?");
				if( r == false){
					return;
				}
				$.post("del9printCtrl",
					{ 
					 	 rptPrintNo : $("#rptPrintNo").val()
						,serialNo : serialNo
						,flag : flag
					},
					function(data,status){
						if (data.trim() != "ERROR" && status == 'success'){
							$("#printCtrlOutSpan").html("");
							$("#printCtrlOutSpan").html(data);
							alert("삭제에 성공하였습니다.");
						}else{
							alert("삭제에 실패하였습니다. 잠시후 시도해주세요..");
						}
					}
				);
			}
			
			function printCtrlModifyView(index,subject,memo,delayAgent){
				//버튼 변경
				$("#ModBtnPrintCtrlSpan"+index).css("display","none");
				$("#ModAftSaveBtnPrintCtrlSpan"+index).css("display","block");
				$("#printCtrlAddBtn").css("display","none");
				
				//입력 화면 출력
				$("#printCtrlDateInputSpan"+index).css("display","block");
				$("#printCtrlSubjectInputSpan"+index).css("display","block");
				$("#printCtrlMemoInputSpan"+index).css("display","block");
				
				//입력완료 화면 삭제
				$("#printCtrlDateSpan"+index).css("display","none");
				$("#printCtrlSubjectSpan"+index).css("display","none");
				$("#printCtrlMemoSpan"+index).css("display","none");
				
				//롯데 초기화
				$("#printCtrlDelayAgentSpan"+index).css("display","none");
				$("#printCtrlDelayAgentInputSpan"+index).css("display","block");
				$("#printCtrlDelayAgentSelect"+index).val(delayAgent);
				
				$("#printCtrlDateCntSpan"+index).css("display","none");
				$("#printCtrlDateCntInputSpan"+index).css("display","block");
				
				$("#printCtrlDelayCntSpan"+index).css("display","none");
				$("#printCtrlDelayCntInputSpan"+index).css("display","block");
				
				
				//DatePicker 로드
				$('#printCtrlDateTxt'+index).datepicker({ 
			    	   showOn: 'button',
			    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
			    	   buttonImageOnly: true,
			    	   buttonText: "달력", 
			    	   changeMonth: true,
			    	   changeYear: true,
			    	   showButtonPanel: false
			    });
				
				//DatePicker 로드
				$('#printCtrlEndDateTxt'+index).datepicker({ 
			    	   showOn: 'button',
			    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
			    	   buttonImageOnly: true,
			    	   buttonText: "달력", 
			    	   changeMonth: true,
			    	   changeYear: true,
			    	   showButtonPanel: false
			    });
				

		  		$.post("getPrintCtrlList"
		  				,{
							 rptPrintNo : $("#rptPrintNo").val()
							,ptnrName : $("#ptnrName").val()
	  					}
		  				,function(data,status){
		  					if (data != null && data != "" && status == "success"){
		  						var subjectFlag = 0;
		  						var memoFlag = 0;
		  						
			  					subjectItems = "<option value=''>--- 선택 ---</option>";
			  					for (var i = 0; i < data.printList.length; i++) {
			  						if ( subject == data.printList[i].col_val ){
			  							subjectFlag = 1;
			  							subjectItems += "<option value='" + data.printList[i].col_val + "' selected>" + data.printList[i].col_val + "</option>";
			  						}else{
			  							subjectItems += "<option value='" + data.printList[i].col_val + "'>" + data.printList[i].col_val + "</option>";
			  						}
			  					}
			  					if (subjectFlag == 0){
			  						subjectItems += "<option value='999' selected>직접입력</option>";
			  						$("#printCtrlSubjectTxt"+index).css("display","block");
			  					}else{
			  						subjectItems += "<option value='999'>직접입력</option>";
			  					}
			  					
			  					
			  					memoItems = "<option value=''>--- 선택 ---</option>";
			  					for (var i = 0; i < data.memoList.length; i++){
			  						if (memo == data.memoList[i].col_val){
			  							memoFlag = 1;
			  							memoItems += "<option value='" + data.memoList[i].col_val + "' selected>" + data.memoList[i].col_val + "</option>";
			  						}else{
			  							memoItems += "<option value='" + data.memoList[i].col_val + "'>" + data.memoList[i].col_val + "</option>";
			  						}
			  					}
			  					
			  					if (memoFlag == 0){
			  						memoItems += "<option value='999' selected>직접입력</option>";
			  						$("#printCtrlMemoTxt"+index).css("display","block");
			  					}else{
			  						memoItems += "<option value='999'>직접입력</option>";
			  					}
			  					
			  					$("#printCtrlMemoSelect"+index).html("");
			  					$("#printCtrlSubjectSelect"+index).html("");
			  					$("#printCtrlMemoSelect"+index).append(memoItems);
			  					$("#printCtrlSubjectSelect"+index).append(subjectItems);
		  					}
		  				},"json"
				);
		  		
			}
			
			function printCtrlUpdate(index,serialNo,flag){
				$.post("./udt9printCtrl"
						,{
							 rptPrintNo : $("#rptPrintNo").val()
							,serialNo : serialNo
							,controlDate: $("#printCtrlDateTxt"+index).val()
							,controlSubject: $("#printCtrlSubjectTxt"+index).val()
							,controlMemo: $("#printCtrlMemoTxt"+index).val()
							,controlEndDate: $("#printCtrlEndDateTxt"+index).val()
							,controlDelayAgent : $("#printCtrlDelayAgentSelect"+index).val()
							,controlDateCnt : $("#printCtrlDateCntTxt"+index).val()
							,controlDelayCnt : $("#printCtrlDelayCntTxt"+index).val()
							,flag : flag
						},
						function(data,status){
							if (data.trim() != "ERROR" && status == 'success'){
								$("#printCtrlOutSpan").html("");
								$("#printCtrlOutSpan").html(data);
								alert("수정에 성공하였습니다.");
								
							}else{
								alert("수정에 실패하였습니다. 잠시후 시도해주세요..");
							}
						}
				);
			}
			
			
			//수정 - 취소
			function printCtrlModifyClose(index){
				//버튼 변경
				$("#ModBtnPrintCtrlSpan"+index).css("display","block");
				$("#ModAftSaveBtnPrintCtrlSpan"+index).css("display","none");
				$("#printCtrlAddBtn").css("display","block");
				
				//입력완료 화면 삭제
				$("#printCtrlDateInputSpan"+index).css("display","none");
				$("#printCtrlSubjectInputSpan"+index).css("display","none");
				$("#printCtrlMemoInputSpan"+index).css("display","none");
				
				//입력 완료 출력
				$("#printCtrlDateSpan"+index).css("display","block");
				$("#printCtrlSubjectSpan"+index).css("display","block");
				$("#printCtrlMemoSpan"+index).css("display","block");
				
				//롯데 - 지연주체 
				$("#printCtrlDelayAgentSpan"+index).css("display","block");
				$("#printCtrlDelayAgentInputSpan"+index).css("display","none");
				
				//롯데 - 일수
				$("#printCtrlDateCntSpan"+index).css("display","block");
				$("#printCtrlDateCntInputSpan"+index).css("display","none");
				
				//롯데 - 지연일수
				$("#printCtrlDelayCntSpan"+index).css("display","block");
				$("#printCtrlDelayCntInputSpan"+index).css("display","none");
			}	
			
			
			
			function printCtrlDelayModifyView(){
				//버튼 변경
				$("#ModBtnPrintCtrlDelaySpan").css("display","none");
				$("#ModAftSaveBtnPrintCtrlDelaySpan").css("display","block");
				$("#printCtrlAddBtn").css("display","none");
				
				//입력 화면 출력
				$("#printCtrlAllDelayInputSpan").css("display","block");
				$("#printCtrlNotInsuInputSpan").css("display","block");
				$("#printCtrlInsuInputSpan").css("display","block");
				
				//입력완료 화면 삭제
				$("#printCtrlAllDelaySpan").css("display","none");
				$("#printCtrlNotInsuSpan").css("display","none");
				$("#printCtrlInsuSpan").css("display","none");
			}
			
			function printCtrlDelayModifyClose(){
				//버튼 변경
				$("#ModBtnPrintCtrlDelaySpan").css("display","block");
				$("#ModAftSaveBtnPrintCtrlDelaySpan").css("display","none");
				$("#printCtrlAddBtn").css("display","block");
				
				//입력 완료 출력
				$("#printCtrlAllDelayInputSpan").css("display","none");
				$("#printCtrlNotInsuInputSpan").css("display","none");
				$("#printCtrlInsuInputSpan").css("display","none");
				
				//입력 화면 삭제
				$("#printCtrlAllDelaySpan").css("display","block");
				$("#printCtrlNotInsuSpan").css("display","block");
				$("#printCtrlInsuSpan").css("display","block");
			}
			
			function printCtrlDelayUpdate(){
				$.post("./udt9printCtrlDelay"
						,{
							 rptPrintNo : $("#rptPrintNo").val()
							,allDelayCnt: $("#printCtrlAllDelayTxt").val()
							,insuDelayCnt: $("#printCtrlInsuTxt").val()
							,notInsuDelayCnt : $("#printCtrlNotInsuTxt").val()
						},
						function(data,status){
							if (data.trim() != "ERROR" && status == 'success'){
								$("#printCtrlOutSpan").html("");
								$("#printCtrlOutSpan").html(data);
								alert("수정에 성공하였습니다.");
							}else{
								alert("수정에 실패하였습니다. 잠시후 시도해주세요..");
							}
						}
				);
			}
			
			function printCtrlLotteAddView(){
		  		$.post("getPrintCtrlList"
		  				,{
							 rptPrintNo : $("#rptPrintNo").val()
							,ptnrName : $("#ptnrName").val()
	  					}
		  				,function(data,status){
		  					if (data != null && data != "" && status == "success"){
			  					subjectItems = "<option value=''>--- 선택 ---</option>";
			  					for (var i = 0; i < data.printList.length; i++) {
			  						subjectItems += "<option value='" + data.printList[i].col_val + "'>" + data.printList[i].col_val + "</option>";
			  					}
			  					subjectItems += "<option value='999'>직접입력</option>";
			  					
			  					memoItems = "<option value=''>--- 선택 ---</option>";
			  					for (var i = 0; i < data.memoList.length; i++) {
			  						memoItems += "<option value='" + data.memoList[i].col_val + "'>" + data.memoList[i].col_val + "</option>";
			  					}
			  					memoItems += "<option value='999'>직접입력</option>";
			  					
			  					
			  					$("#printCtrlAddBtn").hide();
			  					
			  			  		var index = $("#printCtrlSize").val();
			  			  		
			  			  		
			  					$("#printCtrlTbody").append(	
			  						"<tr id='printCtrlTr"+index+"'>"
			  						//일자
			  						+	"<td class='td'>"
			  						+		"<p align='center'>"
			  						+			"<input type='text' class='printCtrlDateTxt' id='printCtrlDateTxt"+index+"' maxlength='10' value='' /><br/>"
			  						+			"~ <input type='text' class='printCtrlEndDateTxt' onchange='calcDateCnt("+index+")' id='printCtrlEndDateTxt"+index+"' maxlength='10' value='' style='margin-top:5px;'/>"
			  						+		"</p>"
			  						+	"</td>"
			  						
			  						//일수
			  						+	"<td class='td'>"
			  						+		"<p align='center'>"
			  						+			"<input type='text' class='printCtrlDateCnt onlyNumber' id='printCtrlDateCntTxt"+index+"' size='3' maxlength='4' />"
			  						+		"</p>"
			  						+	"</td>"
			  						
			  						//업무내용
			  						+	"<td class='td'>"
			  						+		"<p align='center'>"
			  						+			"<select id='printCtrlSubjectSelect"+index+"' onchange='javascript:fnSelectPick(this,1,"+index+");' style='width:140px;' >"
			  						+				subjectItems
			  						+			"</select>"
			  						+			"<input type='text' class='printCtrlTxt' id='printCtrlSubjectTxt"+index+"' value='' style='width:130px;display:none;' />"								
			  						+		"</p>"
			  						+	"</td>"
			  						
			  						//세부내용
			  						+	"<td class='td'>"
			  						+		"<p align='center'>"
			  						+			"<select id='printCtrlMemoSelect"+index+"' onchange='javascript:fnSelectPick(this,2,"+index+");' style='width:140px;' >"
			  						+				memoItems
			  						+			"</select>"				
			  						+			"<input class='printCtrlTxt' type='text' id='printCtrlMemoTxt"+index+"' value='' style='width:130px;display:none;' />"
			  						+		"</p>"		
			  						+	"</td>"
			  						
			  						//지연주체
			  						+	"<td class='td'>" 
			  						+		"<p align='center'>"
			  						+			"<select id='printCtrlDelayAgentSelect"+index+"' onchange='' style='width:65px;' >"
			  						+				"<option value='0'>- 선택 -</option>"
			  						+				"<option value='1'>보험사</option>"
			  						+				"<option value='2'>수익자</option>"
			  						+				"<option value='3'>계약자</option>"
			  						+				"<option value='4'>피보험자</option>"
			  						+			"</select>"	
			  						+		"</p>"
			  						+	"</td>"
			  						
			  						//지연일수
			  						+	"<td class='td'>"
			  						+		"<p align='center'>"
			  						+			"<input type='text' class='printCtrlDelayCnt onlyNumber' id='printCtrlDelayCntTxt"+index+"' size='3' maxlength='4' />"
			  						+		"</p>"
			  						+	"</td>"
			  						
			  						//버튼
			  						+	"<td class='td'>"
			  						+		"<p align='center'>"
			  						+			"<span class='printCtrlSpan' id='SaveBtnPrintCtrlSpan"+index+"'>"			
			  						+				"<img src='./resources/ne_img/btn/btn_save.gif' onclick='javascript:printCtrlInsert("+index+",\"lotte\");' style='cursor:pointer;'/>"
			  						+				"<br/><img src='./resources/ne_img/btn/btn_close.gif' onclick='javascript:printCtrlAddClose("+index+");' serialNo='' style='cursor:pointer;margin-top:5px;'/>"
			  						+			"</span>"
			  						+		"</p>"
			  						+	"</td>"
			  						+"<tr>"
			  					);  
			  					
			  					$('#printCtrlDateTxt'+index).datepicker({ 
			  				    	   showOn: 'button',
			  				    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
			  				    	   buttonImageOnly: true,
			  				    	   buttonText: "달력", 
			  				    	   changeMonth: true,
			  				    	   changeYear: true,
			  				    	   showButtonPanel: false
			  				    });
			  					
			  					$('#printCtrlEndDateTxt'+index).datepicker({ 
			  				    	   showOn: 'button',
			  				    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
			  				    	   buttonImageOnly: true,
			  				    	   buttonText: "달력", 
			  				    	   changeMonth: true,
			  				    	   changeYear: true,
			  				    	   showButtonPanel: false
			  				    });
			  					$("#printCtrlSize").val( parseInt($("#printCtrlSize").val())+1 );
			  					
		  					}else{
		  						alert("잠시 후 시도 해주세요..");
		  					}
		  				},"json"
		  		);
		  	}
		</script>
		
		<!-- 각각 지연일수의 총합 -->
		<input type="hidden" id="firstInsuDelayCnt" value="${insuDelayCnt}" />
		
		<input type="hidden" id='allDelayCnt' value="${print_9_ctrl_delay_cnt.allDelayCnt}"/>
		<input type="hidden" id='notInsuDelayCnt' value="${print_9_ctrl_delay_cnt.notInsuDelayCnt}"/>
		<input type="hidden" id='insuDelayCnt' value="${print_9_ctrl_delay_cnt.insuDelayCnt}"/>
		
					<p style="font-size:large;">
						<b>2. 처리과정</b>
						<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id="printCtrlAddBtn" onclick="javascript:printCtrlLotteAddView();" style="float:right; cursor:pointer;" />
					</p>
	
					<table cellSpacing=0 cellPadding="0" width="648" align="center" bordercolordark="white" bordercolorlight="#999999" >
						<colgroup>
							<col width="110"/>
							<col width="50"/>
							<col width="150"/>
							<col width="150"/>
							<col width="70"/>
							<col width="50"/>
							<col width="50"/>
						</colgroup>
						<tr>
							<td bgcolor="#ECECEC" class="td">
								<p align="center"><b>일 자</b>
							</td>
							<td bgcolor="#ECECEC" class="td">
								<p align="center"><b>일 수</b>
							</td>
							
							<td bgcolor="#ECECEC" class="td">
								<p align="center"><b>업 무 내 용</b>
							</td>
							<td bgcolor="#ECECEC" class="td">
								<p align="center"><b>세 부 내 용</b></p>
							</td>
							<td bgcolor="#ECECEC" class="td">
								<p align="center"><b>지연<br/>주체</b></p>
							</td>
							<td bgcolor="#ECECEC" class="td">
								<p align="center"><b>지연<br/>일수</b></p>
							</td>
							<td bgcolor="#ECECEC" class="td">
								<p align="center"><b>-</b></p>
							</td>
						</tr>
						<tbody id="printCtrlTbody">
						
						<c:forEach items="${print_9_ctrl}" var="printCtrlVo" varStatus="printCtrlStatus">
							<tr id='printCtrlTr${printCtrlStatus.index}'>
								<!-- 일자 -->
								<td class='td'>
									<p align='center'>
										<span class="printCtrlSpan" id="printCtrlDateSpan${printCtrlStatus.index}">${printCtrlVo.controlEndDate}</span>
										<span class="printCtrlInputSpan" id="printCtrlDateInputSpan${printCtrlStatus.index}" style="display:none;">
											<input type='text' class='printCtrlDateTxt' id='printCtrlDateTxt${printCtrlStatus.index}' maxlength='10' value='${printCtrlVo.controlDate}' /><br/>
											~<input type='text' class='printCtrlDateTxt' onchange="calcDateCnt(${printCtrlStatus.index})" id='printCtrlEndDateTxt${printCtrlStatus.index}' maxlength='10' value='${printCtrlVo.controlEndDate}' style='margin-top:5px;'/>
										</span>
									</p>
								</td>

								<!-- 일수 -->
								<td class='td'>
									<p align='center'>
										<span class="printCtrlSpan" id="printCtrlDateCntSpan${printCtrlStatus.index}">
											<c:if test="${printCtrlVo.controlDateCnt ne null}">${printCtrlVo.controlDateCnt}일</c:if>
										</span>
										<span class="printCtrlInputSpan" id="printCtrlDateCntInputSpan${printCtrlStatus.index}" style="display:none;">
											<input type='text' class='printCtrlDateCnt onlyNumber' id='printCtrlDateCntTxt${printCtrlStatus.index}' size='3' maxlength='4' value='${printCtrlVo.controlDateCnt}'/>
										</span>
									</p>
								</td>
								
								<!-- 업무내용 -->
								<td class='td'>
									<p align='center'>
										<span class="printCtrlSpan" id="printCtrlSubjectSpan${printCtrlStatus.index}">${printCtrlVo.controlSubject}</span>
										<span class="printCtrlInputSpan" id="printCtrlSubjectInputSpan${printCtrlStatus.index}" style="display:none;">
		  									<select id='printCtrlSubjectSelect${printCtrlStatus.index}' onchange='javascript:fnSelectPick(this,1,${printCtrlStatus.index});' style='width:140px;' >
		  									</select>
											<input type='text' class='printCtrlTxt' id='printCtrlSubjectTxt${printCtrlStatus.index}' maxlength='10' value='${printCtrlVo.controlSubject}' style='width:130px;display:none;' />								
										</span>
									</p>
								</td>
							
								<!-- 세부내용 -->
								<td class='td'>
									<p align='center'>
										<span class="printCtrlSpan" id="printCtrlMemoSpan${printCtrlStatus.index}" >${printCtrlVo.controlMemo}</span>
										<span class="printCtrlInputSpan" id="printCtrlMemoInputSpan${printCtrlStatus.index}" style="display:none;">
		  									<select id='printCtrlMemoSelect${printCtrlStatus.index}' onchange='javascript:fnSelectPick(this,2,${printCtrlStatus.index});' style='width:140px;' >
		  									</select>				
											<input class='printCtrlTxt' type='text' id='printCtrlMemoTxt${printCtrlStatus.index}' value='${printCtrlVo.controlMemo}' style='width:130px;display:none;' />
										</span>
									</p>		
								</td>			
								
								<!-- 지연주체 -->
								<td class='td'>
									<p align='center'>
										<span class="printCtrlSpan" id="printCtrlDelayAgentSpan${printCtrlStatus.index}" >
											<c:choose>
												<c:when test="${printCtrlVo.controlDelayAgent eq '1'}">보험사</c:when>
												<c:when test="${printCtrlVo.controlDelayAgent eq '2'}">수익자</c:when>
												<c:when test="${printCtrlVo.controlDelayAgent eq '3'}">계약자</c:when>
												<c:when test="${printCtrlVo.controlDelayAgent eq '4'}">피보험자</c:when>
												<c:otherwise></c:otherwise>
											</c:choose>
										</span>
										
										<span class="printCtrlInputSpan" id="printCtrlDelayAgentInputSpan${printCtrlStatus.index}" style="display:none;">
		  									<select id='printCtrlDelayAgentSelect${printCtrlStatus.index}' style='width:65px;' >
		  										<option value='0'>- 선택 -</option>
	  											<option value='1'>보험사</option>
		  										<option value='2'>수익자</option>
	  											<option value='3'>계약자</option>
	  											<option value='4'>피보험자</option>
	  										</select>	
										</span> 
									</p>
								</td>
								 
								<!-- 지연 일수 -->
								<td class='td'>
									<p align='center'>
										<span class="printCtrlSpan" id="printCtrlDelayCntSpan${printCtrlStatus.index}">
											<c:if test="${printCtrlVo.controlDelayCnt ne null}">${printCtrlVo.controlDelayCnt}일</c:if>
										</span>
										<span class="printCtrlInputSpan" id="printCtrlDelayCntInputSpan${printCtrlStatus.index}" style="display:none;">
											<input type='text' class='printCtrlDateCnt onlyNumber' id='printCtrlDelayCntTxt${printCtrlStatus.index}' size='3' maxlength='4' value='${printCtrlVo.controlDelayCnt}'/>
										</span>									
									</p>
								</td>
											
								<!-- 버튼 -->
								<td class="td">
									<p align="center">
										<span class='passTableSpan' id='ModBtnPrintCtrlSpan${printCtrlStatus.index}' >
											<img src='./resources/ls_img/btn_edit_s.gif' onclick='javascript:printCtrlModifyView(${printCtrlStatus.index},"${printCtrlVo.controlSubject}","${printCtrlVo.controlMemo}","${printCtrlVo.controlDelayAgent}");' style='cursor:pointer;'/>
											<img src='./resources/ls_img/btn_del_s.gif' onclick="javascript:printCtrlDelete(${printCtrlVo.serialNo},'lotte9')" style='cursor:pointer;'/>
										</span>
										<span class='passTableSpan' id='ModAftSaveBtnPrintCtrlSpan${printCtrlStatus.index}' style='display:none;'>			
											<img src='./resources/ne_img/btn/btn_save.gif' onclick="javascript:printCtrlUpdate(${printCtrlStatus.index},${printCtrlVo.serialNo})" style='cursor:pointer;'/>
											<br/><img src='./resources/ne_img/btn/btn_close.gif' onclick="javascript:printCtrlModifyClose(${printCtrlStatus.index})" style='cursor:pointer;margin-top:5px;'/>
										</span>
									</p>
								</td>
							</tr>
						</c:forEach>
						</tbody>
                            <tr id="allDelayTr">
                                <td colspan="5" align="center" class='td' bgcolor="#ECECEC">
                                    <span style="color: red;">총지연일수</span>
                                </td>
                            </tr>
                            <tr id="notInsuDelayTr">
                                <td colspan="5" align="center" class='td' bgcolor="#ECECEC">
                                    <span style="color: red;">계약자, 피보험자, 수익자의 책임있는 사유 조사 지연일수</span>
                                </td>
                            </tr>
                            <tr id="insuDelayTr">
                                <td colspan="5" align="center" class='td' style="background-color: yellow;">
                                    <span style="color: red;">보험사 지연일수</span>
                                </td>
                            </tr>
					</table>
