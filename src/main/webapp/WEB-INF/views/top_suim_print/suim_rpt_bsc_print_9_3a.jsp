<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>	
	<script>
		$(document).ready(function(){
			
			/* Print_9_3a 추가 영역 보이기 */
			$("#print9_3aShowAddAreaBtn").click(function(){
				$("#print9_3aInputTr").css("display","inline");
				$("#editeBody9_3aContentsCancelBtnId").css("display","inline");
				$("#print9_3aShowAddAreaBtn").css("display","none");
				

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
			
			/* Print_9_3a 추가 취소하기 */
			$("#editeBody9_3aContentsCancelBtnId").click(function(){
				$("#print9_3aInputTr").css("display","none");
				$("#editeBody9_3aContentsCancelBtnId").css("display","none");
				$("#print9_3aShowAddAreaBtn").css("display","inline");
			});

			/* Print9_3a 신규 입력 */
			$("#addBody9_3aContentsOkBtn").click(function(){
				$.post("./insBody9_3aOk",
						{	
							 rptPrintNo			:"${suimRptBody9_13467Vo.rptPrintNo}"
							,processDateS  		:$("#processDateS").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//경과 시작일
							,processDateE  		:$("#processDateE").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//종료일
							,processDtl  		:$("#processDtl").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//경과 상세내용
							,processHospital	:$("#processHospital").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	//기관
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장을 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$("#print9_3aInputTr").css("display","none");
									$("#editeBody9_3aContentsCancelBtnId").css("display","none");
									$("#print9_3aShowAddAreaBtn").css("display","inline");
									
									$("#print9_3aList").append(
										"<tr id = 'print9_3aListTr_"+data+"'>"
										+	"<td align='center' class='td' id = 'processDateTd_"+data+"'>"
										+		"<div id = 'processDateDivId_"+data+"'>"
										+			"<input type='text' size='10' style='display:none;' class='Print9_3aListInputClass' id = 'processDateSForEdite_"+data+"' value='"+$("#processDateS").val()+"' />" 
										+			"<input type='text' size='10' style='display:none;' class='Print9_3aListInputClass' id = 'processDateEForEdite_"+data+"' value='"+$("#processDateE").val()+"' />"
										+		"</div>"
										+		"<span id = 'processDateSpan_"+data+"'>"+$("#processDateS").val()+" <br />~ "+$("#processDateE").val()+"</span>"
										+	"</td>"
										+	"<td class='td' colspan='3' id = 'processDtlTd_"+data+"'>"
										+		"<span id = 'processDtlSpan_"+data+"'>"+$("#processDtl").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
										+		"<textarea  class='Print9_3aListInputClass' style='width:99%;height:55px;overflow:visible; display:none;' id = 'processDtlForEdite_"+data+"'>"+$("#processDtl").val()+"</textarea>"
										+	"</td>"
										+	"<td class='td' align='center' id = 'processHospitalTd_"+data+"'>"
										+		"<span id = 'processHospitalSpan_"+data+"'>"+$("#processHospital").val()+"</span>"
										+		"<input type='text' size= '15' class= 'print1_1InputClass' id = 'processHospitalForEdite_"+data+"' style='display:none;' value='"+$("#processHospital").val()+"'/>"
										+	"</td>"
										+	"<td align='center' class='td'>"
										+		"<img src='./resources/ls_img/btn_edit_s.gif' id = 'editePrint9_3aBtn_"+data+"' onclick=\"print9_3aEdit('"+data+"');\" style='cursor:pointer;'/>  "
										+		"<img src='./resources/ls_img/btn_del_s.gif' id = 'delPrint9_3aBtn_"+data+"' onclick=\"print9_3aDel('"+data+"');\" style='cursor:pointer;'/>"
										+		"<img id = 'editeBody9_3aContentsOkBtn_"+data+"' src='./resources/ls_img/btn_check_s.gif' title='수정 완료' style='display:none;cursor:pointer;' onclick=\"editePrint9_3aOk('"+data+"');\" />"
										+	"</td>"
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
		
		/* Print9_3a 수정하기 화면 동작*/
		function print9_3aEdit(serialNo){
			$("#processDateSpan_"+serialNo).css("display","none");
			$("#processDtlSpan_"+serialNo).css("display","none");
			$("#processHospitalSpan_"+serialNo).css("display","none");

			$("#editePrint9_3aBtn_"+serialNo).css("display","none");
			$("#delPrint9_3aBtn_"+serialNo).css("display","none");
			
			$("#processDateSForEdite_"+serialNo).css("display","inline");
			$("#processDateEForEdite_"+serialNo).css("display","inline");
			$("#processDtlForEdite_"+serialNo).css("display","inline");
			$("#processHospitalForEdite_"+serialNo).css("display","inline");
			
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
			
			$("#editeBody9_3aContentsOkBtn_"+serialNo).css("display","inline");
			
		}
		
		/* Print9_3a 수정하기 Ok*/
		function editePrint9_3aOk(serialNo){
			$.post("./editeBody9_3aOk",
					{	
							serialNo			:serialNo
							,processDateS  		:$("#processDateSForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//경과 시작일
							,processDateE  		:$("#processDateEForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//종료일
							,processDtl  		:$("#processDtlForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//경과 상세내용
							,processHospital	:$("#processHospitalForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	//기관
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{

								$("#processDateSpan_"+serialNo).css("display","inline");
								$("#processDtlSpan_"+serialNo).css("display","inline");
								$("#processHospitalSpan_"+serialNo).css("display","inline");
								
								$("#editePrint9_3aBtn_"+serialNo).css("display","inline");
								$("#delPrint9_3aBtn_"+serialNo).css("display","inline");
								
								$("#processDateSForEdite_"+serialNo).css("display","none");
								$("#processDateEForEdite_"+serialNo).css("display","none");
								$("#processDtlForEdite_"+serialNo).css("display","none");
								$("#processHospitalForEdite_"+serialNo).css("display","none");
								$("#processDateDivId_"+serialNo).hide();
								
								$("#editeBody9_3aContentsOkBtn_"+serialNo).css("display","none");
								
								$("#processDateSpan_"+serialNo).html("");
								$("#processDtlSpan_"+serialNo).html("");
								$("#processHospitalSpan_"+serialNo).html("");
								
								$("#processDateSpan_"+serialNo).html($("#processDateSForEdite_"+serialNo).val()+"<br> ~"+$("#processDateEForEdite_"+serialNo).val());
								$("#processDtlSpan_"+serialNo).html($("#processDtlForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								$("#processHospitalSpan_"+serialNo).html($("#processHospitalForEdite_"+serialNo).val());
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
			
		}
		
		/* Print9_3a 삭제하기 */
		function print9_3aDel(serialNo){
			if(confirm("삭제하시겠습니까?")){
				$.post("./delBody9_3aOk",
						{	
								serialNo	:serialNo
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("삭제 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									
									$("#print9_3aListTr_"+serialNo).remove();
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
			<td height="25" width="80%">
				<p class="p2">
					<b>3. 조사내용(요약) : 나. 피보험자 병력사항 요약 경과표 
						<!-- <img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print9_3aShowHideBtnId" style="display:none; cursor:pointer; "  /> -->
					</b>
				</p>
			</td>
			<td height="25" width="20%">
				<p align="right">
					<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id = "print9_3aShowAddAreaBtn" style="float:right; cursor:pointer; "  />
					<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody9_3aContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
				</p>
			</td>
		</tr>
		<tr >
			<td colspan="2" align="center">
				<!-- <img src="./resources/ls_img/ls_body/1/02.jpg" title="계약 사항 샘플 양식" id = "print9_3aSampleImg" style="display:none; cursor:pointer; " onclick="print1_1ShowHide();" /> -->
			</td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0" align="center" width="640">
		<tr>
			<td bgcolor="#ECECEC" class="td" width="140">
				<p align="center"><b>일 자</b></p>
			</td>
			<td colspan="3" class="td" bgcolor="#ECECEC" width="300">
				<p align="center"><b>내 용</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="125">
				<p align="center"><b>기 관</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="50">
				<p align="center"><b>비고</b></p>
			</td>
		</tr>
		
		<tbody id = "print9_3aList">
			<c:forEach items="${SuimRptBody9_3aList }" var="suimRptBody9_3aVo">
				<tr id = "print9_3aListTr_${suimRptBody9_3aVo.serialNo}">
					<td align="center" class="td" id = "processDateTd_${suimRptBody9_3aVo.serialNo}">
						<div id = 'processDateDivId_${suimRptBody9_3aVo.serialNo}'>
							<input type="text" size="10" style="display:none;" class="Print9_3aListInputClass" id = "processDateSForEdite_${suimRptBody9_3aVo.serialNo}" value="${suimRptBody9_3aVo.processDateS }" /> 
							<input type="text" size="10" style="display:none;" class="Print9_3aListInputClass" id = "processDateEForEdite_${suimRptBody9_3aVo.serialNo}" value="${suimRptBody9_3aVo.processDateE }" />
						</div>
						<span id = "processDateSpan_${suimRptBody9_3aVo.serialNo}">${suimRptBody9_3aVo.processDateS} <br />~ ${suimRptBody9_3aVo.processDateE}</span>
					</td>
					<td class="td" colspan="3" id = "processDtlTd_${suimRptBody9_3aVo.serialNo}">
						<span id = "processDtlSpan_${suimRptBody9_3aVo.serialNo}">${suimRptBody9_3aVo.processDtlSpan}</span>
						<textarea  class="Print9_3aListInputClass" style="width:99%;height:55px;overflow:visible; display:none;" id = "processDtlForEdite_${suimRptBody9_3aVo.serialNo}">${suimRptBody9_3aVo.processDtl}</textarea>
					</td>
					<td align="center" class="td" id = "processHospitalTd_${suimRptBody9_3aVo.serialNo}">
						<span id = "processHospitalSpan_${suimRptBody9_3aVo.serialNo}">${suimRptBody9_3aVo.processHospital}</span>
						<input type="text" size= "15" class= "print1_1InputClass" id = "processHospitalForEdite_${suimRptBody9_3aVo.serialNo}" style="display:none;" value="${suimRptBody9_3aVo.processHospital }"/>
					</td>
					<td align="center" class="td">
						<img src='./resources/ls_img/btn_edit_s.gif' id = "editePrint9_3aBtn_${suimRptBody9_3aVo.serialNo}" onclick="print9_3aEdit('${suimRptBody9_3aVo.serialNo}');" style='cursor:pointer;'/>
						<img src='./resources/ls_img/btn_del_s.gif' id = "delPrint9_3aBtn_${suimRptBody9_3aVo.serialNo}" onclick="print9_3aDel('${suimRptBody9_3aVo.serialNo}');" style='cursor:pointer;'/>
						<img id = "editeBody9_3aContentsOkBtn_${suimRptBody9_3aVo.serialNo}" src="./resources/ls_img/btn_check_s.gif" title="수정 완료" style="display:none;cursor:pointer;" onclick="editePrint9_3aOk('${suimRptBody9_3aVo.serialNo}');" />
					</td>
				</tr>					
			</c:forEach>
		</tbody>
		<tr id = "print9_3aInputTr" style="display:none;">
			<td align="center" class="td">
				<input type="text" size="10" id = "processDateS" readonly="readonly" style="margin-right:2px;" /> ~
				<input type="text" size="10" id = "processDateE" readonly="readonly" style="margin-right:2px;"/>
			</td >
			<td colspan="3"  class="td">
				<textarea style="width:99%;height:55px;overflow:visible;" id = "processDtl"></textarea>
			</td>
			<td align="center" class="td">
				<input id = "processHospital" size="15"></input>
			</td>
			<td class="td" align="center">
				<img id = "addBody9_3aContentsOkBtn" src="./resources/ls_img/btn_check_s.gif" title="요약 경과표 추가" style="cursor:pointer;" />
			</td>
		</tr>
	</table>
	<p>&nbsp;</p>
</body>