<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>	
	<script>
		$(document).ready(function(){
			
			/* Print1_8 추가 영역 보이기 */
			$("#print1_8ShowAddAreaBtn").click(function(){
				$("#print1_8InputTr").css("display","inline");
				$("#editeBody1_8ContentsCancelBtnId").css("display","inline");
				$("#print1_8ShowAddAreaBtn").css("display","none");
				$("#print1_8ShowHideBtnId").css("display","inline");
			});
			
			/* Print1_8 추가 취소하기 */
			$("#editeBody1_8ContentsCancelBtnId").click(function(){
				$("#print1_8InputTr").css("display","none");
				$("#editeBody1_8ContentsCancelBtnId").css("display","none");
				$("#print1_8ShowAddAreaBtn").css("display","inline");
				$("#print1_8SampleImg").css("display","none");
				$("#print1_8ShowHideBtnId").css("display","none");
			});
			
			/* Print1_8 샘플양식 보기 */
			$("#print1_8ShowHideBtnId").click(function(){				
				$("#print1_8SampleImg").css("display","block");					
			});
			
			/* Print1_8 샘플양식 숨기기 */
			$("#print1_8SampleImg").click(function(){				
				$("#print1_8SampleImg").css("display","none");					
			});
			
			/* Print1_8 신규 입력 */
			$("#addBody1_8ContentsOkBtn").click(function(){
				$.post("./insBody1_8Ok",
						{	
							 rptPrintNo			:"${suimRptBody1_13467Vo.rptPrintNo}"
							,attachName  		:$.trim($("#attachName").val())		//첨부자료 이름
							,attachCopy  		:$.trim($("#attachCopy").val())		//첨부자료 부수
							,attachEtcMemo		:$.trim($("#attachEtcMemo").val())	//비고
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장을 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									
									var dataStream = data.split("+");
									
									$("#print1_8InputTr").css("display","none");
									$("#editeBody1_8ContentsCancelBtnId").css("display","none");
									$("#print1_8ShowAddAreaBtn").css("display","inline");
									$("#print1_8SampleImg").css("display","none");
									$("#print1_8ShowHideBtnId").css("display","none");
									
									$(".Print1_8ListInputClass").css("display","none");
									
									$("#Print1_8List").append(
										"<tr id = 'Print1_8ListTr_"+dataStream[1]+"'>"
										+	"<td align='center' class='td'>"
										+		"<span >"+dataStream[0]+"</span>"
										+	"</td>"
										+	"<td class='td'>"
										+		"<span id = 'attachNameSpan_"+dataStream[1]+"'>"+$("#attachName").val()+"</span>"
										+		"<input type='text' size='40' style='display:none;' class='Print1_8ListInputClass' id = 'attachNameForEdite_"+dataStream[1]+"' value='"+$("#attachName").val()+"'/>"
										+	"</td>"
										+	"<td class='td' align='center' >"
										+		"<span id = 'attachCopySpan_"+dataStream[1]+"'>"+$("#attachCopy").val()+"</span>"
										+		"<input type='text' size='4' style='display:none;' class='Print1_8ListInputClass' id = 'attachCopyForEdite_"+dataStream[1]+"' value='"+$("#attachCopy").val()+"'/>"
										+	"</td>"
										+	"<td class='td'  >"
										+		"<span id = 'attachEtcMemoSpan_"+dataStream[1]+"'>"+$("#attachEtcMemo").val()+"</span>"
										+		"<input type='text' size='30' style='display:none;' class='Print1_8ListInputClass' id = 'attachEtcMemoForEdite_"+dataStream[1]+"' value='"+$("#attachEtcMemo").val()+"'/>"
										+	"</td>"
										+	"<td class='td' align='center'>"
										+		"<img src='./resources/ls_img/btn_edit_s.gif' id = 'editePrint1_8Btn_"+dataStream[1]+"' onclick=\"print1_8Edit('"+dataStream[1]+"');\" style='cursor:pointer; '/>  "
										+		"<img src='./resources/ls_img/btn_del_s.gif' id = 'delPrint1_8Btn_"+dataStream[1]+"' onclick=\"print1_8Del('"+dataStream[1]+"');\" style='cursor:pointer; '/>"
										+		"<img id = 'editeBody1_8ContentsOkBtn_"+dataStream[1]+"' src='./resources/ls_img/btn_check_s.gif' title='수정 완료' style='display:none;cursor:pointer;' onclick=\"editePrint1_8Ok('"+dataStream[1]+"');\" />"
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
		
		/* Print1_8 수정하기 화면 동작*/
		function print1_8Edit(serialNo){
			$("#attachNameSpan_"+serialNo).css("display","none");
			$("#attachCopySpan_"+serialNo).css("display","none");
			$("#attachEtcMemoSpan_"+serialNo).css("display","none");
			
			$("#editePrint1_8Btn_"+serialNo).css("display","none");
			$("#delPrint1_8Btn_"+serialNo).css("display","none");
			
			$("#attachNameForEdite_"+serialNo).css("display","inline");
			$("#attachCopyForEdite_"+serialNo).css("display","inline");
			$("#attachEtcMemoForEdite_"+serialNo).css("display","inline");

			$("#editeBody1_8ContentsOkBtn_"+serialNo).css("display","inline");
			
		}
		
		/* Print1_8 수정하기 Ok*/
		function editePrint1_8Ok(serialNo){
			$.post("./editeBody1_8Ok",
					{	
							serialNo			:serialNo
							,attachName			:$("#attachNameForEdite_"+serialNo).val()
							,attachCopy			:$("#attachCopyForEdite_"+serialNo).val()
							,attachEtcMemo  	:$("#attachEtcMemoForEdite_"+serialNo).val()						
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								
								$("#attachNameSpan_"+serialNo).css("display","inline");
								$("#attachCopySpan_"+serialNo).css("display","inline");
								$("#attachEtcMemoSpan_"+serialNo).css("display","inline");
								
								$("#editePrint1_8Btn_"+serialNo).css("display","inline");
								$("#delPrint1_8Btn_"+serialNo).css("display","inline");
								
								$("#attachNameForEdite_"+serialNo).css("display","none");
								$("#attachCopyForEdite_"+serialNo).css("display","none");
								$("#attachEtcMemoForEdite_"+serialNo).css("display","none");

								$("#editeBody1_8ContentsOkBtn_"+serialNo).css("display","none");
								
								$("#attachNameSpan_"+serialNo).html("");
								$("#attachCopySpan_"+serialNo).html("");
								$("#attachEtcMemoSpan_"+serialNo).html("");
								
								$("#attachNameSpan_"+serialNo).html($("#attachNameForEdite_"+serialNo).val());
								$("#attachCopySpan_"+serialNo).html($("#attachCopyForEdite_"+serialNo).val());
								$("#attachEtcMemoSpan_"+serialNo).html($("#attachEtcMemoForEdite_"+serialNo).val());
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
			
		}
		
		/* Print1_8 삭제하기 */
		function print1_8Del(serialNo){
			if(confirm("삭제하시겠습니까?")){
				$.post("./delBody1_8Ok",
						{	
								serialNo	:serialNo
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("삭제 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									
									$("#Print1_8ListTr_"+serialNo).remove();
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
	<table align="center" cellpadding="0" cellspacing="0" width="660">
		<tr>
			<td height="25" width="50%">
				<p class="p2">
					<b>8. 첨부자료 목록 
						<img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print1_8ShowHideBtnId" style="display:none; cursor:pointer; "  />
					</b>
				</p>
			</td>
			<td height="25" width="50%">
				<p align="right">
					<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id = "print1_8ShowAddAreaBtn" style="float:right; cursor:pointer; "  />
					<img src="./resources/ls_img/btn_write_cancel.gif" title="추가 취소" id = "editeBody1_8ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
				</p>
			</td>
		</tr>
		<tr >
			<td colspan="2" align="center">
				<img src="./resources/ls_img/ls_body/1/08.jpg" title="첨부자료 목록 샘플 양식" id = "print1_8SampleImg" style="display:none; cursor:pointer; " onclick="print1_8ShowHide();" />
			</td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="660">
		<tr>
			<td bgcolor="#ECECEC" class="td" width="30" >
				<p align="center"><b>순번</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="300">
				<p align="center"><b>첨부자료</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="40" >
				<p align="center"><b>부수</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="215" >
				<p align="center"><b>비고</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="40" >
				<p align="center"><b>-</b></p>
			</td>
		</tr>
	<!-- </table>
	<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="661"> -->
		<tbody id = "Print1_8List">
			<c:forEach items="${suimRptBody1_8List }" var="suimRptBody1_8Vo">
				<tr id = "Print1_8ListTr_${suimRptBody1_8Vo.serialNo}">
					<td align="center" class="td">
						<span >${suimRptBody1_8Vo.ROWNUM}</span>
					</td>
					<td class="td"  >
						<span id = "attachNameSpan_${suimRptBody1_8Vo.serialNo}">${suimRptBody1_8Vo.attachName}</span>
						<input type="text" style='display:none;' size="40" class="Print1_8ListInputClass" id = "attachNameForEdite_${suimRptBody1_8Vo.serialNo}" value="${suimRptBody1_8Vo.attachName}"/>
					</td>
					<td class="td" align="center" >
						<span id = "attachCopySpan_${suimRptBody1_8Vo.serialNo}">${suimRptBody1_8Vo.attachCopy}</span>
						<input type="text" style='display:none;' size="4" class="Print1_8ListInputClass" id = "attachCopyForEdite_${suimRptBody1_8Vo.serialNo}" value="${suimRptBody1_8Vo.attachCopy}"/>
					</td>
					<td class="td"  >
						<span id = "attachEtcMemoSpan_${suimRptBody1_8Vo.serialNo}">${suimRptBody1_8Vo.attachEtcMemo}</span>
						<input type="text" style='display:none;' size="30" class="Print1_8ListInputClass" id = "attachEtcMemoForEdite_${suimRptBody1_8Vo.serialNo}" value="${suimRptBody1_8Vo.attachEtcMemo}"/>
					</td>
					<td class="td" align="center">
						<img src='./resources/ls_img/btn_edit_s.gif' id = "editePrint1_8Btn_${suimRptBody1_8Vo.serialNo}" onclick="print1_8Edit('${suimRptBody1_8Vo.serialNo}');" style='cursor:pointer; '/>
						<img src='./resources/ls_img/btn_del_s.gif' id = "delPrint1_8Btn_${suimRptBody1_8Vo.serialNo}" onclick="print1_8Del('${suimRptBody1_8Vo.serialNo}');" style='cursor:pointer; '/>
						<img id = "editeBody1_8ContentsOkBtn_${suimRptBody1_8Vo.serialNo}" src="./resources/ls_img/btn_check_s.gif" title="수정 완료" style="display:none;cursor:pointer;" onclick="editePrint1_8Ok('${suimRptBody1_8Vo.serialNo}');" />
					</td>
				</tr>					
			</c:forEach>
		</tbody>
		<tr id = "print1_8InputTr" style="display:none;">
			<td align="center" class="td" width="30">
				-
			</td>
			<td class="td" width="250">
				<input type="text" size="40" id = "attachName"/>
			</td>
			<td class="td" width="30">
				<input type="text" size="4" id = "attachCopy"/>
			</td>
			<td class="td" width="50">
				<input type="text" size="30" id = "attachEtcMemo"/>
			</td>
			<td width="30" class="td"  align="center">
				<img id = "addBody1_8ContentsOkBtn" src="./resources/ls_img/btn_check_s.gif" title="확인사항 추가" style="cursor:pointer;" />
			</td>
		</tr>
	</table>
	<p>&nbsp;</p>
</body>