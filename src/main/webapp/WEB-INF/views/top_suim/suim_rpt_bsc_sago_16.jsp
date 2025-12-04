<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<script>
	
	$(document).ready(function(){
		
		/* 사고처리 과정표 16 1행 추가 시작 */
		$("#sagoRptInsBtn").click(function(){

			if($("#controlDate").val() == ''){
				alert("처리 일자를 입력하세요.");
				$("#controlDate").focus();
				return;
			}
			
			if($("#controlMemo").val() == ''){
				alert("처리 내용을 입력하세요.");
				$("#controlMemo").focus();
				return;
			}
			
			if($("#controlWho").val() == ''){
				alert("면담자를 입력하세요.");
				$("#controlWho").focus();
				return;
			}
			
			if($("#controlRelation").val() == ''){
				alert("관계를 입력하세요.");
				$("#controlRelation").focus();
				return;
			}
			
			if($("#controlContact").val() == ''){
				alert("접촉방법을 입력하세요.");
				$("#controlContact").focus();
				return;
			}
			
			$.post("./sagoRptIns16",
					{	
						 suimRptNo   		:$("#suimRptNo").val()  		//
						,controlDate	    :$("#controlDate").val()  		// 처리일자
						,controlMemo        :$("#controlMemo").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')  		// 처리내용
						,controlWho       	:$("#controlWho").val() 		// 면담자
						,controlRelation    :$("#controlRelation").val() 	// 관계
						,controlContact     :$("#controlContact").val() 	// 접촉방법
						
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								alert("저장 완료");
								$("#sagoList").append(
									"<tr id='"+data+"'>"
									+	"<td>"
									+		"<span class = 'controlDateSpanClass' id = 'controlDate_"+data+"'>"+$("#controlDate").val()+"</span>"
									+		"<span id= 'dateAreaForPrint16_"+data+"'>"
									+			"<input class = 'controlDateInputClass' style='display:none;' type='text' size='8' id='controlDateForEdite_"+data+"' value='"+$("#controlDate").val()+"'/>"
									+		"</span>"
									+	"</td>"
									+	"<td>"
									+	"	<span class = 'controlDateSpanClass' id = 'controlMemo_"+data+"'>"+$("#controlMemo").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
									+	"	<textarea class = 'controlDateInputClass' style='display:none;' id='controlMemoForEdite_"+data+"' cols='38' rows='5'>"+$("#controlMemo").val()+"</textarea>"
									+	"</td>"
									+	"<td>"
									+	"	<span class = 'controlDateSpanClass' id = 'controlWho_"+data+"'>"+$("#controlWho").val()+"</span>"
									+	"	<input  class = 'controlDateInputClass' style='display:none;' type='text' size='10' id='controlWhoForEdite_"+data+"' value='"+$("#controlWho").val()+"'/>"
									+	"</td>"
									+	"<td>"
									+	"	<span class = 'controlDateSpanClass' id = 'controlRelation_"+data+"'>"+$("#controlRelation").val()+"</span>"
									+	"	<input class = 'controlDateInputClass' style='display:none;' type='text' size='6' id='controlRelationForEdite_"+data+"' value='"+$("#controlRelation").val()+"'/>"
									+	"</td>"
									+	"<td>"
									+	"	<span class = 'controlDateSpanClass' id = 'controlContact_"+data+"'>"+$("#controlContact").val()+"</span>"
									+	"	<input class = 'controlDateInputClass' style='display:none;' type='text' size='6' id='controlContactForEdite_"+data+"' value = '"+$("#controlContact").val()+"'/>"
									+	"</td>"
									+	"<td>"
									+	"	<img src='./resources/ls_img/btn_edit_s.gif' id = 'sago16EditeCallBtn_"+data+"' onclick=\"sagoEdit('"+data+"');\" style='cursor:pointer;' />"
									+	"	<img src='./resources/ls_img/btn_del_s.gif' id = 'sago16DelBtn_"+data+"' onclick=\"sagoDel('"+data+"');\" style='cursor:pointer;' />"
									+	"<img src='./resources/ls_img/btn_edite.gif' id = 'sago16EditeOkBtn_"+data+"' style='display:none; cursor:pointer;' onclick=\"sagoEditOk('"+data+"');\"/>"
									+	"</td>"
									+"</tr>"
								);
								$("#sagoAddAreaId").css("display","none");
								$("#hideSagoAddAreaBtn").css("display","none");
								$("#showSagoAddAreaBtn").css("display","block");
								
								
								if("${suimVO.suim_rpt_type2 }" == 16){
										$("#sagoList16").append(
	
										"<tr id = 'print16_Ctrl_"+data+"' >"
										+	"<td class='td'>"
										+		"<span id = 'controlDate16_"+data+"'>"+$("#controlDateForEdite_"+data).val()+"</span>"
										+	"</td>"
										+	"<td class='td'>"
										+		"<span id = 'controlMemo16_"+data+"'>"+$("#controlMemoForEdite_"+data).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
										+	"</td>"
										+	"<td class='td'>"
										+		"<span id = 'controlWho16_"+data+"'>"+$("#controlWhoForEdite_"+data).val()+"</span>"
										+	"</td>"
										+	"<td class='td'>"
										+		"<span id = 'controlRelation16_"+data+"'>"+$("#controlRelationForEdite_"+data).val()+"</span>"
										+	"</td>"
										+	"<td class='td'>"
										+		"<span id = 'controlContact16_"+data+"'>"+$("#controlContactForEdite_"+data).val()+"</span>"
										+	"</td>"
										+"</tr>"
									);								
								}
								//저장완료후 입력 폼은 초기화해준다.
								$("#controlMemo").val('');
								$("#controlWho").val('');
								$("#controlRelation").val('');
								$("#controlContact").val('');
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}//function
			);//post
		});
		/* 사고처리 과정표 16 1행 추가 끝 */
		
	});
	
	/* 사고처리 과정표 16 수정 동작 요청 시작 */
	function sagoEdit(serialNo){
		
		$("#controlMemoForEdite_"+serialNo).show();
		$("#controlWhoForEdite_"+serialNo).show();
		$("#controlDateForEdite_"+serialNo).show();
		$("#controlRelationForEdite_"+serialNo).show();
		$("#controlContactForEdite_"+serialNo).show();
		
		$("#controlMemo_"+serialNo).hide();
		$("#controlWho_"+serialNo).hide();
		$("#controlDate_"+serialNo).hide();
		$("#controlRelation_"+serialNo).hide();
		$("#controlContact_"+serialNo).hide();
		
		$("#sago16EditeCallBtn_"+serialNo).hide();
		$("#sago16DelBtn_"+serialNo).hide();
		$("#sago16EditeOkBtn_"+serialNo).show();
		$("#dateAreaForPrint16_"+serialNo).show();
		
		$('#controlDateForEdite_'+serialNo).datepicker({ 
	    	   showOn: 'button',
	    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	    	   buttonImageOnly: true,
	    	   buttonText: "달력", 
	    	   changeMonth: true,
	    	   changeYear: true,
	    	   showButtonPanel: false
	    });
		
		$("#controlMemoForEdite_"+serialNo).focus();
	}
	/* 사고처리 과정표 16 수정 동작 요청 끝 */
	
	/* 사고처리 과정표 16 변경 시작*/
	function sagoEditOk(serialNo){
	
		$.post("./sagoRptUdt16",
				{	
					 serialNo 	  			:serialNo 									 //
					,controlMemo	    	:$("#controlMemoForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')  		 //
					,controlWho       		:$("#controlWhoForEdite_"+serialNo).val() 		 // 
					,controlDate       		:$("#controlDateForEdite_"+serialNo).val() 		 //
					,controlRelation       	:$("#controlRelationForEdite_"+serialNo).val() 	 //
					,controlContact       	:$("#controlContactForEdite_"+serialNo).val() 	 //
					
				},
				function(data,status){
					if(status == "success"){
						if(data == 0){
							alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
						}else{
							
							$("#controlDate_"+serialNo).show();
							$("#controlMemo_"+serialNo).show();
							$("#controlWho_"+serialNo).show();
							$("#controlRelation_"+serialNo).show();
							$("#controlContact_"+serialNo).show();
							
							$("#controlDateForEdite_"+serialNo).hide();
							$("#controlMemoForEdite_"+serialNo).hide();
							$("#controlWhoForEdite_"+serialNo).hide();
							$("#controlRelationForEdite_"+serialNo).hide();
							$("#controlContactForEdite_"+serialNo).hide();
							
							
							$("#controlDate_"+serialNo).html($("#controlDateForEdite_"+serialNo).val());
							$("#controlMemo_"+serialNo).html($("#controlMemoForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
							$("#controlWho_"+serialNo).html($("#controlWhoForEdite_"+serialNo).val());
							$("#controlRelation_"+serialNo).html($("#controlRelationForEdite_"+serialNo).val());
							$("#controlContact_"+serialNo).html($("#controlContactForEdite_"+serialNo).val());
							
							$("#sago16EditeCallBtn_"+serialNo).show();
							$("#sago16DelBtn_"+serialNo).show();
							$("#sago16EditeOkBtn_"+serialNo).hide();
							$("#dateAreaForPrint16_"+serialNo).hide();
							
							if("${suimVO.suim_rpt_type2 }" == 16){
								
								$("#controlDate16_"+serialNo).html($("#controlDateForEdite_"+serialNo).val());
								$("#controlMemo16_"+serialNo).html($("#controlMemoForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								$("#controlWho16_"+serialNo).html($("#controlWhoForEdite_"+serialNo).val());
								$("#controlRelation16_"+serialNo).html($("#controlRelationForEdite_"+serialNo).val());
								$("#controlContact16_"+serialNo).html($("#controlContactForEdite_"+serialNo).val());
																
							} 
						}
					}else{
						alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
					}
				}
		);//post
	};
	/* 사고처리 과정표 16 변경 끝*/
	
	/* 사고처리 과정표 16 1행 삭제 시작 */
	function sagoDel(serialNo){
		if(confirm("삭제하시겠습니까?")){
			
			$.post("./sagoRptDel16",
					{	
						serialNo 	  	:serialNo  //
						
					},
					function(data,status){
						if(status == "success"){
							if(data != 0){
								$("#"+serialNo).html("");
								if("${suimVO.suim_rpt_type2 }" == 16){
									$("#print16_Ctrl_"+serialNo).html("");										
								} 
							}else{
								alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");	
							}
						}else{
							alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");
						}
					}
			);
			
		}
	}
	/* 사고처리 과정표 16 1행 삭제 끝*/
	
	/* 사고처리 과정표 16 인쇄 시작 */
	function sagoPrint(rptNo){
		
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		
		var sw=1010; //띄울 창의 넓이
		var sh=740;  //띄울 창의 높이
	
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		
		window.open('sagoPrintPage?suimRptNo='+rptNo+'&type2=16','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}
	/* 사고처리 과정표 16 인쇄 끝 */
	
	/* 사고처리 과정표 16 추가 영역 보이기 시작 */
	function showSagoAddArea(){

		if( !fnChkListSave()){
			alert("체크리스트 내용을 먼저 입력해 주세요.");
			fnPrgssModifyFrm();
			$("#p_amtEstimatedDamage").focus();
			return;
		}

		$("#sagoAddAreaId").css("display","block");
		$("#showSagoAddAreaBtn").css("display","none");
		$("#hideSagoAddAreaBtn").css("display","block");
		
		/* 일자에 오늘 날짜 자동 입력 */
		var currentDate = new Date();
		var month = currentDate.getMonth() + 1+"";
		
		if(month.length ==1){
			month = "0"+month;
		}
		
		var day = currentDate.getDate() + "";
		
		if(day.length ==1){
			day = "0"+day;
		}
		
		var year = currentDate.getFullYear();
		
		var today = year+"-"+month+"-"+day;

		$("#controlDate").val(today);
		$('#controlDate').datepicker({ 
		   	   showOn: 'button',
		   	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		   	   buttonImageOnly: true,
		   	   buttonText: "달력", 
		   	   changeMonth: true,
		   	   changeYear: true,
		   	   showButtonPanel: false
		   	});
		
		$("#controlMemo").focus();
	}
	/* 사고처리 과정표 16 추가 영역 보이기 끝*/
	
	/* 사고처리 과정표 16 추가 영역 숨기기 시작 */
	function hideSagoAddArea(){
		
		$("#showSagoAddAreaBtn").css("display","block");
		$("#hideSagoAddAreaBtn").css("display","none");
		
		$("#sagoAddAreaId").css("display","none");
		
	}
	/* 사고처리 과정표 16 추가 영역 숨기기 끝 */

</script>
</head>
<body>
	<!-- 사고처리 과정표 16 입력 --> 
	<table align="center" style="margin-top:10px;">
		<colgroup>
			<col width="15%">
			<col width="40%">
			<col width="15%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
		</colgroup>
		<thead>
			<tr>
				<td colspan="6" align="center">
					<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 2-2. 사고처리 과정표 </b>
					<img src="./resources/ls_img/btn_print_s.gif" title="인쇄" style="cursor:pointer;" onclick="sagoPrint('${suimRptNoFromServer}');"/>
					<c:if test="${(suimVO.suimRptState eq '0' and suimVO.editYN > 0) or endModFlag > 0}">
						<img src="./resources/ls_img/btn_add_s.gif" title="추가" id = "showSagoAddAreaBtn" style="float:right; cursor:pointer; margin-right:10px;" onclick="showSagoAddArea();"/>
						<img src="./resources/ls_img/btn_close.gif" title="추가 취소" id = "hideSagoAddAreaBtn" style="float:right; cursor:pointer; margin-right:10px; display:none;" onclick="hideSagoAddArea();"/>
					</c:if>
				</td>
			</tr>
			<tr>
				<th>처리일자</th>
				<th>처리내용</th>
				<th>면담자</th>
				<th>관계</th>
				<th>접촉방법</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody align="center" id = "sagoList">
			<c:forEach items="${sagoList}" var="sagoRptVo">
				<tr id = "${sagoRptVo.serialNo}" >
					<td>
						<span class = "controlSpanClass" id = "controlDate_${sagoRptVo.serialNo}">${sagoRptVo.controlDate}</span>
						<span id= 'dateAreaForPrint16_${sagoRptVo.serialNo}'>
							<input class = "controlInputClass" style="display:none;" type="text" size="8" id="controlDateForEdite_${sagoRptVo.serialNo}" value="${sagoRptVo.controlDate}"/>
						</span>
					</td>
					<td style="text-align:left;padding-left:10px;">
						<span class = "controlSpanClass" id = "controlMemo_${sagoRptVo.serialNo}">${sagoRptVo.controlMemoSpan}</span>
						<textarea class = "controlInputClass" style="display:none;" id="controlMemoForEdite_${sagoRptVo.serialNo}" cols="38" rows="5">${sagoRptVo.controlMemo}</textarea>
					</td>
					<td>
						<span class = "controlSpanClass" id = "controlWho_${sagoRptVo.serialNo}">${sagoRptVo.controlWho}</span>
						<input  class = "controlInputClass" style="display:none;" type="text" size="10" id="controlWhoForEdite_${sagoRptVo.serialNo}" value="${sagoRptVo.controlWho}"/>
					</td>
					<td>
						<span class = "controlSpanClass" id = "controlRelation_${sagoRptVo.serialNo}">${sagoRptVo.controlRelation}</span>
						<input class = "controlInputClass" style="display:none;" type="text" size="6" id="controlRelationForEdite_${sagoRptVo.serialNo}" value="${sagoRptVo.controlRelation}"/>
					</td>
					<td>
						<span class = "controlSpanClass" id = "controlContact_${sagoRptVo.serialNo}">${sagoRptVo.controlContact}</span>
						<input class = "controlInputClass" style="display:none;" type="text" size="6" id="controlContactForEdite_${sagoRptVo.serialNo}" value="${sagoRptVo.controlContact}"/>
					</td>
					<td>
						<c:choose>
							<c:when test="${suimVO.suimRptState eq '0' or suimVO.suimRptState eq '11' }">
								<c:choose>
									<c:when test="${suimVO.editYN > 0 or endModFlag > 0}">
										<img src="./resources/ls_img/btn_edit_s.gif" id = "sago16EditeCallBtn_${sagoRptVo.serialNo}" onclick="sagoEdit('${sagoRptVo.serialNo}');" style='cursor:pointer;' />
										<img src="./resources/ls_img/btn_del_s.gif"  id = "sago16DelBtn_${sagoRptVo.serialNo}" onclick="sagoDel('${sagoRptVo.serialNo}');" style='cursor:pointer;' />
										<img src="./resources/ls_img/btn_edite.gif" id = "sago16EditeOkBtn_${sagoRptVo.serialNo}" style=" display:none; cursor:pointer;" onclick="sagoEditOk('${sagoRptVo.serialNo}');"/>
									</c:when>
									<c:otherwise>
										-
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<!-- 종결 후 수정 -->
								<c:choose>
									<c:when test="${endModFlag > 0}">
										<img src="./resources/ls_img/btn_edit_s.gif" id = "sago16EditeCallBtn_${sagoRptVo.serialNo}" onclick="sagoEdit('${sagoRptVo.serialNo}');" style='cursor:pointer;' />
										<img src="./resources/ls_img/btn_del_s.gif"  id = "sago16DelBtn_${sagoRptVo.serialNo}" onclick="sagoDel('${sagoRptVo.serialNo}');" style='cursor:pointer;' />
										<img src="./resources/ls_img/btn_edite.gif" id = "sago16EditeOkBtn_${sagoRptVo.serialNo}" style=" display:none; cursor:pointer;" onclick="sagoEditOk('${sagoRptVo.serialNo}');"/>
									</c:when>
									<c:otherwise>
										-
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</tbody>		
	</table>
	<div style="display:none;" id = "sagoAddAreaId">
		<table align="center" style="margin-top:10px;">
			<tr align="center">
				<td width="15%">
					<input type="text" size="10" id="controlDate"/>
				</td>
				<td width="40%">
					<textarea id="controlMemo" cols="38" rows="5"></textarea>
				</td>
				<td width="15%">
					<input type="text" size="10" id="controlWho"/>
				</td>
				<td width="10%" align="center">
					<input type="text" size="6" id="controlRelation"/>
				</td>
				<td width="10%" align="center">
					<input type="text" size="6" id="controlContact"/>
				</td>
				<td width="10%">
					<img src="./resources/ls_img/btn_add.gif" id="sagoRptInsBtn" style="cursor:pointer;"/>
				</td>
			</tr>	
		</table>
	</div>
</body>