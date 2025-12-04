<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>	
	<script>
		$(document).ready(function(){
			
			/* Print_5 추가 영역 보이기 */
			$("#print1_5ShowAddAreaBtn").click(function(){
				$("#print1_5InputTr").css("display","inline");
				$("#editeBody1_5ContentsCancelBtnId").css("display","inline");
				$("#print1_5ShowAddAreaBtn").css("display","none");
				$("#print1_5ShowHideBtnId").css("display","inline");
				
				$('#processDateS').datepicker({ 
					   showOn: 'button',
					   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
					   buttonImageOnly: true,
					   buttonText: "달력", 
					   changeMonth: true,
					   changeYear: true,
					   showButtonPanel: false
				});
				
				$('#processDateE').datepicker({ 
					   showOn: 'button',
					   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
					   buttonImageOnly: true,
					   buttonText: "달력", 
					   changeMonth: true,
					   changeYear: true,
					   showButtonPanel: false
				});
				
			});
			
			/* Print_5 추가 취소하기 */
			$("#editeBody1_5ContentsCancelBtnId").click(function(){
				$("#print1_5InputTr").css("display","none");
				$("#editeBody1_5ContentsCancelBtnId").css("display","none");
				$("#print1_5ShowAddAreaBtn").css("display","inline");
				$("#print1_5SampleImg").css("display","none");
				$("#print1_5ShowHideBtnId").css("display","none");
			});
			
			/* Print_5 샘플양식 보기 */
			$("#print1_5ShowHideBtnId").click(function(){				
				$("#print1_5SampleImg").css("display","block");					
			});
			
			/* Print_5 샘플양식 숨기기 */
			$("#print1_5SampleImg").click(function(){				
				$("#print1_5SampleImg").css("display","none");					
			});
			
			/* Print1_5 신규 입력 */
			$("#addBody1_5ContentsOkBtn").click(function(){
				$.post("./insBody1_5Ok",
						{	
							 rptPrintNo			:"${suimRptBody1_13467Vo.rptPrintNo}"
							,processDateS  		:$("#processDateS").val()		//경과 시작일
							,processDateE  		:$("#processDateE").val()		//경과 종료일
							,processDtl			:$("#processDtl").val()			//경과 내용
							,processEtcMemo		:$("#processEtcMemo").val()		//경과 비고
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장을 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$("#print1_5InputTr").css("display","none");
									$("#editeBody1_5ContentsCancelBtnId").css("display","none");
									$("#print1_5ShowAddAreaBtn").css("display","inline");
									$("#print1_5SampleImg").css("display","none");
									$("#print1_5ShowHideBtnId").css("display","none");
									
									$(".Print1_5ListInputClass").css("display","none");
									
									$("#Print1_5List").append(
										"<tr id = 'Print1_5ListTr_"+data+"'>"
											+"<td class='td' id = 'processDateTd_"+data+"' align='center'>"
												+"<div id = 'processDateDivId_"+data+"'>"
													+"<input type='text' size='10' style='display:none;' class='Print1_5ListInputClass' id = 'processDateSForEdite_"+data+"' value='"+$("#processDateS").val()+"'/>"
													+"<input type='text' size='10' style='display:none;' class='Print1_5ListInputClass' id = 'processDateEForEdite_"+data+"' value='"+$("#processDateE").val()+"'/>"
												+"</div>"
												+"<span id = 'processDateSpan_"+data+"'>"+$("#processDateS").val()+" <br /> ~ "+$("#processDateE").val() +"</span>"
											+"</td>"
											+"<td class='td' colspan='3' id = 'processDtlTd_"+data+"'>"
												+"<span id = 'processDtlForSpan_"+data+"'>"+$("#processDtl").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
												+"<textarea class='Print1_5ListInputClass' style='width:99%;height:55px;overflow:visible; display:none;' id = 'processDtlForEdite_"+data+"'>"+$("#processDtl").val()+"</textarea>"
											+"</td>"
											+"<td class='td'>" 
												+"<span id = 'processEtcMemoForSpan_"+data+"'>"+$("#processEtcMemo").val()+"</span>"
												+"<input type='text' size='10' style='display:none;' size='' class='Print1_5ListInputClass' id = 'processEtcMemoForEdite_"+data+"' value='"+$("#processEtcMemo").val()+"'/>"
										 	+"</td>"
										 	+"<td class='td'>"
												+"<img src='./resources/ls_img/btn_edit_s.gif' id = 'editePrint1_5Btn_"+data+"' onclick=\"print1_5Edit('"+data+"');\" style='cursor:pointer;margin-right:5px;'/>"
												+"<img src='./resources/ls_img/btn_del_s.gif' id = 'delPrint1_5Btn_"+data+"' onclick=\"print1_5Del('"+data+"');\" style='cursor:pointer; '/>"
												+"<img id = 'editeBody1_5ContentsOkBtn_"+data+"' src='./resources/ls_img/btn_check_s.gif' title='수정 완료' style='display:none;cursor:pointer;' onclick=\"editePrint1_5Ok('"+data+"');\" />"
										 	+"</td>"
										+"</tr>"	
									);
									
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
			
			
		});
		
		/* Print1_5 수정하기 화면 동작*/
		function print1_5Edit(serialNo){
			$("#processDateSpan_"+serialNo).css("display","none");
			$("#processDtlForSpan_"+serialNo).css("display","none");
			$("#processEtcMemoForSpan_"+serialNo).css("display","none");
			
			$("#editePrint1_5Btn_"+serialNo).css("display","none");
			$("#delPrint1_5Btn_"+serialNo).css("display","none");
			
			$("#processDateSForEdite_"+serialNo).css("display","inline");
			$("#processDateEForEdite_"+serialNo).css("display","inline");
			$("#processDtlForEdite_"+serialNo).css("display","inline");
			$("#processEtcMemoForEdite_"+serialNo).css("display","inline");
			
			$("#editeBody1_5ContentsOkBtn_"+serialNo).css("display","inline");
			$("#processDateDivId_"+serialNo).show();
			
			$('#processDateSForEdite_'+serialNo).datepicker({ 
				   showOn: 'button',
				   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
				   buttonImageOnly: true,
				   buttonText: "달력", 
				   changeMonth: true,
				   changeYear: true,
				   showButtonPanel: false
			});
			
			$('#processDateEForEdite_'+serialNo).datepicker({ 
				   showOn: 'button',
				   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
				   buttonImageOnly: true,
				   buttonText: "달력", 
				   changeMonth: true,
				   changeYear: true,
				   showButtonPanel: false
			});
			
		}
		
		/* Print1_5 수정하기 Ok*/
		function editePrint1_5Ok(serialNo){
			$.post("./editeBody1_5Ok",
					{	
							serialNo			:serialNo
							,processDateS  		:$("#processDateSForEdite_"+serialNo).val()									//경과 시작일
							,processDateE  		:$("#processDateEForEdite_"+serialNo).val()									//경과 종료일
							,processDtl			:$("#processDtlForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//경과 내용
							,processEtcMemo		:$("#processEtcMemoForEdite_"+serialNo).val()								//경과 비고
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								
								$("#processDateSpan_"+serialNo).css("display","inline");
								$("#processDtlForSpan_"+serialNo).css("display","inline");
								$("#processEtcMemoForSpan_"+serialNo).css("display","inline");
								
								$("#editePrint1_5Btn_"+serialNo).css("display","inline");
								$("#delPrint1_5Btn_"+serialNo).css("display","inline");
								
								$("#processDateSForEdite_"+serialNo).css("display","none");
								$("#processDateEForEdite_"+serialNo).css("display","none");
								$("#processDtlForEdite_"+serialNo).css("display","none");
								$("#processEtcMemoForEdite_"+serialNo).css("display","none");
								
								$("#editeBody1_5ContentsOkBtn_"+serialNo).css("display","none");
								$("#processDateDivId_"+serialNo).hide();
								
								$("#processDateSpan_"+serialNo).html("");
								$("#processDtlForSpan_"+serialNo).html("");
								$("#processEtcMemoForSpan_"+serialNo).html("");
								
								$("#processDateSpan_"+serialNo).html($("#processDateSForEdite_"+serialNo).val()+"<br /> ~"+$("#processDateEForEdite_"+serialNo).val() );
								$("#processDtlForSpan_"+serialNo).html($("#processDtlForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								$("#processEtcMemoForSpan_"+serialNo).html($("#processEtcMemoForEdite_"+serialNo).val());
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
			
		}
		
		/* Print1_5 삭제하기 */
		function print1_5Del(serialNo){
			if(confirm("삭제하시겠습니까?")){
				$.post("./delBody1_5Ok",
						{	
								serialNo	:serialNo
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("삭제 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									
									$("#Print1_5ListTr_"+serialNo).remove();
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			}
		}
		
	</script>
	
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
	<hr size="1" noshade color="black">
	<table align="center" cellpadding="0" cellspacing="0" width="640">
		<tr>
			<td height="25" width="50%">
				<p class="p2">
					<b>5. 총괄경과표 
						<img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print1_5ShowHideBtnId" style="display:none; cursor:pointer; "  />
					</b>
				</p>
			</td>
			<td height="25" width="50%">
				<p align="right">
					<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id = "print1_5ShowAddAreaBtn" style="float:right; cursor:pointer; "  />
					<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody1_5ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
				</p>
			</td>
		</tr>
		<tr >
			<td colspan="2" align="center">
				<img src="./resources/ls_img/ls_body/1/05.jpg" title="계약 사항 샘플 양식" id = "print1_5SampleImg" style="display:none; cursor:pointer; " onclick="print1_1ShowHide();" />
			</td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
		<tr>
			<td bgcolor="#ECECEC" class="td" width="140">
				<p align="center"><b>일자</b></p>
			</td>
			<td colspan="3" class="td" bgcolor="#ECECEC" width="360">
				<p align="center"><b>경위</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="90">
				<p align="center"><b>비고</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="40">
				<p align="center"><b>-</b></p>
			</td>
		</tr>
		
		<tbody id = "Print1_5List">
			<c:forEach items="${suimRptBody1_5List }" var="suimRptBody1_5Vo">
				<tr id = "Print1_5ListTr_${suimRptBody1_5Vo.serialNo}">
					<td align="center" class="td" id = "processDateTd_${suimRptBody1_5Vo.serialNo}">
						<div id = 'processDateDivId_${suimRptBody1_5Vo.serialNo}'>
							<input type="text" size="10" style="display:none;" class="Print1_5ListInputClass" id = "processDateSForEdite_${suimRptBody1_5Vo.serialNo}" value="${suimRptBody1_5Vo.processDateS }" /> 
							<input type="text" size="10" style="display:none;" class="Print1_5ListInputClass" id = "processDateEForEdite_${suimRptBody1_5Vo.serialNo}" value="${suimRptBody1_5Vo.processDateE }" />
						</div>
						<span id = "processDateSpan_${suimRptBody1_5Vo.serialNo}">${suimRptBody1_5Vo.processDateS} <br />~ ${suimRptBody1_5Vo.processDateE}</span>
					</td>
					<td class="td" colspan="3" id = "processDtlTd_${suimRptBody1_5Vo.serialNo}">
						<span id = "processDtlForSpan_${suimRptBody1_5Vo.serialNo}">${suimRptBody1_5Vo.processDtlSpan}</span>
						<textarea class="Print1_5ListInputClass" style="width:99%;height:55px;overflow:visible; display:none;" id = "processDtlForEdite_${suimRptBody1_5Vo.serialNo}">${suimRptBody1_5Vo.processDtl}</textarea>
					</td>
					<td class="td">
						<span id = "processEtcMemoForSpan_${suimRptBody1_5Vo.serialNo}">${suimRptBody1_5Vo.processEtcMemo}</span>
						<input type="text" size="10" style="display:none;" size="" class="Print1_5ListInputClass" id = "processEtcMemoForEdite_${suimRptBody1_5Vo.serialNo}" value="${suimRptBody1_5Vo.processEtcMemo}"/>
					</td>
					<td class="td">
						<img src='./resources/ls_img/btn_edit_s.gif' id = "editePrint1_5Btn_${suimRptBody1_5Vo.serialNo}" onclick="print1_5Edit('${suimRptBody1_5Vo.serialNo}');" style='cursor:pointer; '/>
						<img src='./resources/ls_img/btn_del_s.gif' id = "delPrint1_5Btn_${suimRptBody1_5Vo.serialNo}" onclick="print1_5Del('${suimRptBody1_5Vo.serialNo}');" style='cursor:pointer; '/>
						<img id = "editeBody1_5ContentsOkBtn_${suimRptBody1_5Vo.serialNo}" src="./resources/ls_img/btn_check_s.gif" title="수정 완료" style="display:none;cursor:pointer;" onclick="editePrint1_5Ok('${suimRptBody1_5Vo.serialNo}');" />
					</td>
				</tr>					
			</c:forEach>
		</tbody>
		<tr id = "print1_5InputTr" style="display:none;">
			<td align="center" class="td">
				<input type="text" size="10" id = "processDateS" readonly="readonly" style="margin-right:2px;" /> ~
				<input type="text" size="10" id = "processDateE" readonly="readonly" style="margin-right:2px;"/>
			</td >
			<td colspan="3"  class="td">
				<textarea style="width:99%;height:55px;overflow:visible;" id = "processDtl"></textarea>
			</td>
			<td class="td">
				<input type="text" size="10" id = "processEtcMemo" />
			</td>
			<td class="td">
				<img id = "addBody1_5ContentsOkBtn" src="./resources/ls_img/btn_check_s.gif" title="경과표 추가" style="cursor:pointer;" />			
			</td>
		</tr>
							
	</table>
	<p>&nbsp;</p>
</body>