<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>	
	<script>
		$(document).ready(function(){
			
			/* Print_16_4 추가 영역 보이기 */
			$("#print16_4ShowAddAreaBtn").click(function(){
				$("#print16_4InputTr").show();
				$("#editeBody16_4ContentsCancelBtnId").show();
				$("#print16_4ShowAddAreaBtn").hide();
				$("#print16_4ShowHideBtnId").show();
			});
			
			/* Print_16_4 추가 취소하기 */
			$("#editeBody16_4ContentsCancelBtnId").click(function(){
				$("#print16_4InputTr").hide();
				$("#editeBody16_4ContentsCancelBtnId").hide();
				$("#print16_4ShowAddAreaBtn").show();
				$("#print16_4SampleImg").hide();
				$("#print16_4ShowHideBtnId").hide();
			});
			
			/* Print16_4 신규 입력 */
			$("#addBody16_4ContentsOkBtn").click(function(){
				$.post("./insBody16_4Ok",
						{	
							 rptPrintNo			:"${suimRptBody16_1267Vo.rptPrintNo}"
							,otherInsuCom  		:$("#otherInsuCom").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')			//보험사
							,otherInsuMortgage  :$("#otherInsuMortgage").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//담보내용
							,otherInsuPeriod  	:$("#otherInsuPeriod").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//보험기간
							,otherInsuEtcMemo  	:$("#otherInsuEtcMemo").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//청구내용 및 결과
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장을 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$("#print16_4InputTr").hide();
									$("#editeBody16_4ContentsCancelBtnId").hide();
									$("#print16_4ShowAddAreaBtn").show();

									$("#print16_4List").append(
										"<tr id = 'print16_4ListTr_"+data+"'>"
										+	"<td align='center' class='td' id = 'otherInsuComTd_"+data+"'>"
										+		"<span id = 'otherInsuComForSpan_"+data+"'>"+$("#otherInsuCom").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
										+		"<input type='text' size='15' style='display:none;' id = 'otherInsuComForEdite_"+data+"' value = '"+$("#otherInsuCom").val()+"' />"
										+	"</td>"
										+	"<td class='td' id = 'otherInsuMortgageTd_"+data+"'>"
										+		"<span id = 'otherInsuMortgageForSpan_"+data+"'>"+$("#otherInsuMortgage").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
										+		"<textarea style='width:99%;height:55px;overflow:visible; display:none;' id = 'otherInsuMortgageForEdite_"+data+"'>"+$("#otherInsuMortgage").val()+"</textarea>"
										+	"</td>"
										+	"<td class='td'>"
										+		"<span id = 'otherInsuPeriodForSpan_"+data+"'>"+$("#otherInsuPeriod").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
										+		"<textarea style='width:99%;height:55px;overflow:visible; display:none;' id = 'otherInsuPeriodForEdite_"+data+"'>"+$("#otherInsuPeriod").val()+"</textarea>"
										+	"</td>"
										+	"<td class='td'>"
										+		"<span id = 'otherInsuEtcMemoForSpan_"+data+"'>"+$("#otherInsuEtcMemo").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
										+		"<textarea style='width:99%;height:55px;overflow:visible; display:none;' id = 'otherInsuEtcMemoForEdite_"+data+"'>"+$("#otherInsuEtcMemo").val()+"</textarea>"
										+	"</td>"
										+	"<td class='td' align='center'>"
										+		"<img src='./resources/ls_img/btn_edit_s.gif' id = 'editePrint16_4Btn_"+data+"' onclick=\"print2Edit('"+data+"');\" style='cursor:pointer;'/>  "
										+		"<img src='./resources/ls_img/btn_del_s.gif' id = 'delPrint16_4Btn_"+data+"' onclick=\"print16_4Del('"+data+"');\" style='cursor:pointer;'/>"
										+		"<img id = 'editeBody16_4ContentsOkBtn_"+data+"' src='./resources/ls_img/btn_check_s.gif' title='수정 완료' style='display:none;cursor:pointer;' onclick=\"editePrint16_4Ok('"+data+"');\" />"
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
		
		/* Print16_4 수정하기 화면 동작*/
		function print2Edit(serialNo){
			$("#otherInsuComForSpan_"+serialNo).hide();
			$("#otherInsuMortgageForSpan_"+serialNo).hide();
			$("#otherInsuPeriodForSpan_"+serialNo).hide();
			$("#otherInsuEtcMemoForSpan_"+serialNo).hide();
			
			$("#editePrint16_4Btn_"+serialNo).hide();
			$("#delPrint16_4Btn_"+serialNo).hide();
			
			$("#otherInsuComForEdite_"+serialNo).show();
			$("#otherInsuMortgageForEdite_"+serialNo).show();
			$("#otherInsuPeriodForEdite_"+serialNo).show();
			$("#otherInsuEtcMemoForEdite_"+serialNo).show();
			
			$("#editeBody16_4ContentsOkBtn_"+serialNo).show();
			
		}
		
		/* Print16_4 수정하기 Ok*/
		function editePrint16_4Ok(serialNo){
			$.post("./editeBody16_4Ok",
					{	
							serialNo			:serialNo
							,otherInsuCom  		:$("#otherInsuComForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')			//보험사
							,otherInsuMortgage  :$("#otherInsuMortgageForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//담보내용
							,otherInsuPeriod  	:$("#otherInsuPeriodForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//보험기간
							,otherInsuEtcMemo  	:$("#otherInsuEtcMemoForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//청구내용 및 결과
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								
								$("#otherInsuComForSpan_"+serialNo).show();
								$("#otherInsuMortgageForSpan_"+serialNo).show();
								$("#otherInsuPeriodForSpan_"+serialNo).show();
								$("#otherInsuEtcMemoForSpan_"+serialNo).show();
								
								$("#editePrint16_4Btn_"+serialNo).show();
								$("#delPrint16_4Btn_"+serialNo).show();
								
								$("#otherInsuComForEdite_"+serialNo).hide();
								$("#otherInsuMortgageForEdite_"+serialNo).hide();
								$("#otherInsuPeriodForEdite_"+serialNo).hide();
								$("#otherInsuEtcMemoForEdite_"+serialNo).hide();
								
								$("#editeBody16_4ContentsOkBtn_"+serialNo).hide();
								
								$("#otherInsuComForSpan_"+serialNo).html("");
								$("#otherInsuMortgageForSpan_"+serialNo).html("");
								$("#otherInsuPeriodForSpan_"+serialNo).html("");
								$("#otherInsuEtcMemoForSpan_"+serialNo).html("");
								
								$("#otherInsuComForSpan_"+serialNo).html($("#otherInsuComForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								$("#otherInsuMortgageForSpan_"+serialNo).html($("#otherInsuMortgageForEdite_"+serialNo).html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								$("#otherInsuPeriodForSpan_"+serialNo).html($("#otherInsuPeriodForEdite_"+serialNo).html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								$("#otherInsuEtcMemoForSpan_"+serialNo).html($("#otherInsuEtcMemoForEdite_"+serialNo).html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
			
		}
		
		/* Print16_4 삭제하기 */
		function print16_4Del(serialNo){
			if(confirm("삭제하시겠습니까?")){
				$.post("./delBody16_4Ok",
						{	
								serialNo	:serialNo
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("삭제 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									
									$("#print16_4ListTr_"+serialNo).remove();
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
				<p><font color="#113F7D">▣ <b>타사 가입사항</b></font></p>
			</td>
			<td height="25" width="50%">
				<p align="right">
					<c:if test="${suimVO.suimRptState eq 0}">
						<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id = "print16_4ShowAddAreaBtn" style="float:right; cursor:pointer; "  />
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody16_4ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
					</c:if>
				</p>
			</td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0"  align="center" width="600">
		<tr>
			<td bgcolor="#ECECEC" class="td" width="120">
				<p align="center"><b>보험회사</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="120">
				<p align="center"><b>담보내용</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="130">
				<p align="center"><b>보험기간</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="180">
				<p align="center"><b>청구내용 및 결과</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="50">
				<p align="center"><b>비고</b></p>
			</td>
		</tr>
		
		<tbody id = "print16_4List">
			<c:forEach items="${suimRptBody16_4List }" var="suimRptBody16_4Vo">
				<tr id = "print16_4ListTr_${suimRptBody16_4Vo.serialNo}">
					<td align="center" class="td" id = "otherInsuComTd_${suimRptBody16_4Vo.serialNo}">
						<span id = "otherInsuComForSpan_${suimRptBody16_4Vo.serialNo}">${suimRptBody16_4Vo.otherInsuComSpan}</span>
						<input type="text" size="15" style="display:none;" id = "otherInsuComForEdite_${suimRptBody16_4Vo.serialNo}" value = "${suimRptBody16_4Vo.otherInsuCom}" />
					</td>
					<td class="td" id = "otherInsuMortgageTd_${suimRptBody16_4Vo.serialNo}">
						<span id = "otherInsuMortgageForSpan_${suimRptBody16_4Vo.serialNo}">${suimRptBody16_4Vo.otherInsuMortgageSpan}</span>
						<textarea style="width:99%;height:55px;overflow:visible; display:none;" id = "otherInsuMortgageForEdite_${suimRptBody16_4Vo.serialNo}">${suimRptBody16_4Vo.otherInsuMortgage}</textarea>
					</td>
					<td class="td">
						<span id = "otherInsuPeriodForSpan_${suimRptBody16_4Vo.serialNo}">${suimRptBody16_4Vo.otherInsuPeriodSpan}</span>
						<textarea style="width:99%;height:55px;overflow:visible; display:none;" id = "otherInsuPeriodForEdite_${suimRptBody16_4Vo.serialNo}">${suimRptBody16_4Vo.otherInsuPeriod}</textarea>
					</td>
					<td class="td">
						<span id = "otherInsuEtcMemoForSpan_${suimRptBody16_4Vo.serialNo}">${suimRptBody16_4Vo.otherInsuEtcMemoSpan}</span>
						<textarea style="width:99%;height:55px;overflow:visible; display:none;" id = "otherInsuEtcMemoForEdite_${suimRptBody16_4Vo.serialNo}">${suimRptBody16_4Vo.otherInsuEtcMemo}</textarea>
					</td>
					<td class="td" align="center">
						<c:if test="${suimVO.suimRptState eq 0}">
							<img src='./resources/ls_img/btn_edit_s.gif' id = "editePrint16_4Btn_${suimRptBody16_4Vo.serialNo}" onclick="print2Edit('${suimRptBody16_4Vo.serialNo}');" style='cursor:pointer;'/>
							<img src='./resources/ls_img/btn_del_s.gif' id = "delPrint16_4Btn_${suimRptBody16_4Vo.serialNo}" onclick="print16_4Del('${suimRptBody16_4Vo.serialNo}');" style='cursor:pointer;'/>
							<img id = "editeBody16_4ContentsOkBtn_${suimRptBody16_4Vo.serialNo}" src="./resources/ls_img/btn_check_s.gif" title="수정 완료" style="display:none;cursor:pointer;" onclick="editePrint16_4Ok('${suimRptBody16_4Vo.serialNo}');" />
						</c:if>
					</td>
				</tr>					
			</c:forEach>
		</tbody>
		<tr id = "print16_4InputTr" style="display:none;">
			<td align="center" class="td">
				<textarea style="width:99%;height:55px;overflow:visible;" id = "otherInsuCom"></textarea>
			</td >
			<td class="td">
				<textarea style="width:99%;height:55px;overflow:visible;" id = "otherInsuMortgage"></textarea>
			</td>
			<td class="td">
				<textarea style="width:99%;height:55px;overflow:visible;" id = "otherInsuPeriod"></textarea>
			</td>
			<td class="td">
				<textarea style="width:99%;height:55px;overflow:visible;" id = "otherInsuEtcMemo"></textarea>
			</td>
			<td class="td" align="center">
				<img id = "addBody16_4ContentsOkBtn" src="./resources/ls_img/btn_check_s.gif" title="타사 가입사항 추가" style="cursor:pointer;" />
			</td>
		</tr>
							
	</table>
	<p>&nbsp;</p>
</body>