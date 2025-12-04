<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>	
	<script>
		$(document).ready(function(){
			
			/* Print_9_3c 추가 영역 보이기 */
			$("#print9_3cShowAddAreaBtn").click(function(){
				$("#print9_3cInputTr").css("display","inline");
				$("#editeBody9_3cContentsCancelBtnId").css("display","inline");
				$("#print9_3cShowAddAreaBtn").css("display","none");
				
			});
			
			/* Print_9_3c 추가 취소하기 */
			$("#editeBody9_3cContentsCancelBtnId").click(function(){
				$("#print9_3cInputTr").css("display","none");
				$("#editeBody9_3cContentsCancelBtnId").css("display","none");
				$("#print9_3cShowAddAreaBtn").css("display","inline");
			});

			/* Print_9_3c 신규 입력 */
			$("#addBody9_3cContentsOkBtn").click(function(){
				$.post("./insBody9_3cOk",
						{	
							 rptPrintNo			:"${suimRptBody9_13467Vo.rptPrintNo}"
							,otherInsuCom  		:$("#otherInsuCom").val()									//보험사
							,otherInsuContract  :$("#otherInsuContract").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//계약내용
							,otherInsuProcess  	:$("#otherInsuProcess").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//진행사항
							,otherInsuEtcMemo	:$("#otherInsuEtcMemo").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//비고
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장을 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$("#print9_3cInputTr").css("display","none");
									$("#editeBody9_3cContentsCancelBtnId").css("display","none");
									$("#print9_3cShowAddAreaBtn").css("display","inline");
									
									$("#print9_3cList").append(
										"<tr id = 'print9_3cListTr_"+data+"'>"
										+	"<td align='center' class='td' id = 'otherInsuComTd_"+data+"'>"
										+		"<input type='text' size='10' style='display:none;' class='print9_3cListInputClass' id = 'otherInsuComForEdite_"+data+"' value='"+$("#otherInsuCom").val()+"' />" 
										+		"<span id = 'otherInsuComSpan_"+data+"'>"+$("#otherInsuCom").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
										+	"</td>"
										+	"<td class='td' colspan='3' id = 'otherInsuContractTd_"+data+"'>"
										+		"<span id = 'otherInsuContractSpan_"+data+"'>"+$("#otherInsuContract").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
										+		"<textarea  class='print9_3cListInputClass' style='width:99%;height:55px;overflow:visible; display:none;' id = 'otherInsuContractForEdite_"+data+"'>"+$("#otherInsuContract").val()+"</textarea>"
										+	"</td>"
										+	"<td class='td' id = 'otherInsuProcessTd_"+data+"'>"
										+		"<span id = 'otherInsuProcessSpan_"+data+"'>"+$("#otherInsuProcess").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
										+		"<textarea  class='print9_3cListInputClass' style='width:99%;height:55px;overflow:visible; display:none;' id = 'otherInsuProcessForEdite_"+data+"'>"+$("#otherInsuProcess").val()+"</textarea>"									
										+	"</td>"
										+	"<td class='td' id = 'otherInsuEtcMemoTd_"+data+"'>"
										+		"<span id = 'otherInsuEtcMemoSpan_"+data+"'>"+$("#otherInsuEtcMemo").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
										+		"<textarea  class='print9_3cListInputClass' style='width:99%;height:55px;overflow:visible; display:none;' id = 'otherInsuEtcMemoForEdite_"+data+"'>"+$("#otherInsuEtcMemo").val()+"</textarea>"
										+	"</td>"
										+	"<td align='center' class='td'>"
										+		"<img src='./resources/ls_img/btn_edit_s.gif' id = 'editePrint9_3cBtn_"+data+"' onclick=\"print9_3cEdit('"+data+"');\" style='cursor:pointer;'/>  "
										+		"<img src='./resources/ls_img/btn_del_s.gif' id = 'delPrint9_3cBtn_"+data+"' onclick=\"print9_3cDel('"+data+"');\" style='cursor:pointer;'/>"
										+		"<img id = 'editeBody9_3cContentsOkBtn_"+data+"' src='./resources/ls_img/btn_check_s.gif' title='수정 완료' style='display:none;cursor:pointer;' onclick=\"editePrint9_3cOk('"+data+"');\" />"
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
		
		/* Print9_3c 수정하기 화면 동작*/
		function print9_3cEdit(serialNo){
			$("#otherInsuComSpan_"+serialNo).css("display","none");
			$("#otherInsuContractSpan_"+serialNo).css("display","none");
			$("#otherInsuProcessSpan_"+serialNo).css("display","none");
			$("#otherInsuEtcMemoSpan_"+serialNo).css("display","none");

			$("#editePrint9_3cBtn_"+serialNo).css("display","none");
			$("#delPrint9_3cBtn_"+serialNo).css("display","none");
			
			$("#otherInsuComForEdite_"+serialNo).css("display","inline");
			$("#otherInsuContractForEdite_"+serialNo).css("display","inline");
			$("#otherInsuProcessForEdite_"+serialNo).css("display","inline");
			$("#otherInsuEtcMemoForEdite_"+serialNo).css("display","inline");
			
			$("#editeBody9_3cContentsOkBtn_"+serialNo).css("display","inline");
			
		}
		
		/* Print9_3c 수정하기 Ok*/
		function editePrint9_3cOk(serialNo){
			$.post("./editeBody9_3cOk",
					{	
							serialNo			:serialNo
							,otherInsuCom  		:$("#otherInsuComForEdite_"+serialNo).val()									//보험사
							,otherInsuContract  :$("#otherInsuContractForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//계약내용
							,otherInsuProcess  	:$("#otherInsuProcessForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//진행사항
							,otherInsuEtcMemo	:$("#otherInsuEtcMemoForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//비고
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{

								$("#otherInsuComSpan_"+serialNo).css("display","inline");
								$("#otherInsuContractSpan_"+serialNo).css("display","inline");
								$("#otherInsuProcessSpan_"+serialNo).css("display","inline");
								$("#otherInsuEtcMemoSpan_"+serialNo).css("display","inline");
								
								$("#editePrint9_3cBtn_"+serialNo).css("display","inline");
								$("#delPrint9_3cBtn_"+serialNo).css("display","inline");
								
								$("#otherInsuComForEdite_"+serialNo).css("display","none");
								$("#otherInsuContractForEdite_"+serialNo).css("display","none");
								$("#otherInsuProcessForEdite_"+serialNo).css("display","none");
								$("#otherInsuEtcMemoForEdite_"+serialNo).css("display","none");
								
								$("#editeBody9_3cContentsOkBtn_"+serialNo).css("display","none");
								
								$("#otherInsuComSpan_"+serialNo).html("");
								$("#otherInsuContractSpan_"+serialNo).html("");
								$("#otherInsuProcessSpan_"+serialNo).html("");
								$("#otherInsuEtcMemoSpan_"+serialNo).html("");
								
								$("#otherInsuComSpan_"+serialNo).html($("#otherInsuComForEdite_"+serialNo).val());
								$("#otherInsuContractSpan_"+serialNo).html($("#otherInsuContractForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								$("#otherInsuProcessSpan_"+serialNo).html($("#otherInsuProcessForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								$("#otherInsuEtcMemoSpan_"+serialNo).html($("#otherInsuEtcMemoForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
			
		}
		
		/* Print9_3c 삭제하기 */
		function print9_3cDel(serialNo){
			if(confirm("삭제하시겠습니까?")){
				$.post("./delBody9_3cOk",
						{	
								serialNo	:serialNo
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("삭제 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									
									$("#print9_3cListTr_"+serialNo).remove();
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
					<b>3. 조사내용(요약) : 다. 타 보험사 처리내역 
						<!-- <img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print9_3aShowHideBtnId" style="display:none; cursor:pointer; "  /> -->
					</b>
				</p>
			</td>
			<td height="25" width="20%">
				<p align="right">
					<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id = "print9_3cShowAddAreaBtn" style="float:right; cursor:pointer; "  />
					<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody9_3cContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
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
			<td bgcolor="#ECECEC" class="td" width="115">
				<p align="center"><b>보험사</b></p>
			</td>
			<td colspan="3" class="td" bgcolor="#ECECEC" width="145">
				<p align="center"><b>계약내용</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="155">
				<p align="center"><b>진행사항</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="100">
				<p align="center"><b>비고</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="35">
				<p align="center"><b>-</b></p>
			</td>
		</tr>
		
		<tbody id = "print9_3cList">
			<c:forEach items="${SuimRptBody9_3cList }" var="suimRptBody9_3cVo">
				<tr id = "print9_3cListTr_${suimRptBody9_3cVo.serialNo}">
					<td align="center" class="td" id = "otherInsuComTd_${suimRptBody9_3cVo.serialNo}">
						<input type="text" size="10" style="display:none;" class="print9_3cListInputClass" id = "otherInsuComForEdite_${suimRptBody9_3cVo.serialNo}" value="${suimRptBody9_3cVo.otherInsuCom }" /> 
						<span id = "otherInsuComSpan_${suimRptBody9_3cVo.serialNo}">${suimRptBody9_3cVo.otherInsuCom}</span>
					</td>
					<td class="td" colspan="3" id = "otherInsuContractTd_${suimRptBody9_3cVo.serialNo}">
						<span id = "otherInsuContractSpan_${suimRptBody9_3cVo.serialNo}">${suimRptBody9_3cVo.otherInsuContractSpan}</span>
						<textarea  class="print9_3cListInputClass" style="width:99%;height:55px;overflow:visible; display:none;" id = "otherInsuContractForEdite_${suimRptBody9_3cVo.serialNo}">${suimRptBody9_3cVo.otherInsuContract}</textarea>
					</td>
					<td class="td" id = "otherInsuProcessTd_${suimRptBody9_3cVo.serialNo}">
						<span id = "otherInsuProcessSpan_${suimRptBody9_3cVo.serialNo}">${suimRptBody9_3cVo.otherInsuProcessSpan}</span>
						<textarea  class="print9_3cListInputClass" style="width:99%;height:55px;overflow:visible; display:none;" id = "otherInsuProcessForEdite_${suimRptBody9_3cVo.serialNo}">${suimRptBody9_3cVo.otherInsuProcess}</textarea>
					</td>
					<td class="td" id = "otherInsuEtcMemoTd_${suimRptBody9_3cVo.serialNo}">
						<span id = "otherInsuEtcMemoSpan_${suimRptBody9_3cVo.serialNo}">${suimRptBody9_3cVo.otherInsuEtcMemoSpan}</span>
						<textarea  class="print9_3cListInputClass" style="width:99%;height:55px;overflow:visible; display:none;" id = "otherInsuEtcMemoForEdite_${suimRptBody9_3cVo.serialNo}">${suimRptBody9_3cVo.otherInsuEtcMemo}</textarea>
					</td>
					<td align="center" class="td">
						<img src='./resources/ls_img/btn_edit_s.gif' id = "editePrint9_3cBtn_${suimRptBody9_3cVo.serialNo}" onclick="print9_3cEdit('${suimRptBody9_3cVo.serialNo}');" style='cursor:pointer;'/>
						<img src='./resources/ls_img/btn_del_s.gif' id = "delPrint9_3cBtn_${suimRptBody9_3cVo.serialNo}" onclick="print9_3cDel('${suimRptBody9_3cVo.serialNo}');" style='cursor:pointer;'/>
						<img id = "editeBody9_3cContentsOkBtn_${suimRptBody9_3cVo.serialNo}" src="./resources/ls_img/btn_check_s.gif" title="수정 완료" style="display:none;cursor:pointer;" onclick="editePrint9_3cOk('${suimRptBody9_3cVo.serialNo}');" />
					</td>
				</tr>					
			</c:forEach>
		</tbody>
		<tr id = "print9_3cInputTr" style="display:none;">
			<td align="center" class="td">
				<input type="text" size="15" id = "otherInsuCom" />
			</td >
			<td colspan="3"  class="td">
				<textarea style="width:99%;height:55px;overflow:visible;" id = "otherInsuContract"></textarea>
			</td>
			<td  class="td">
				<textarea style="width:99%;height:55px;overflow:visible;" id = "otherInsuProcess"></textarea>
			</td>
			<td align="center" class="td">
				<textarea style="width:99%;height:55px;overflow:visible;" id = "otherInsuEtcMemo"></textarea>
			</td>
			<td class="td" align="center">
				<img id = "addBody9_3cContentsOkBtn" src="./resources/ls_img/btn_check_s.gif" title="타 보험사 처리내역 추가" style="cursor:pointer;" />
			</td>
		</tr>
	</table>
	<p>&nbsp;</p>
</body>