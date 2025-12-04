<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>	
	<script>
		$(document).ready(function(){
			
			/* Print1700_7 추가 영역 보이기 */
			$("#print1700_7ShowAddAreaBtn").click(function(){
				$("#print1700_7InputTr").css("display","inline");
				$("#editeBody1700_7ContentsCancelBtnId").css("display","inline");
				$("#print1700_7ShowAddAreaBtn").css("display","none");
				$("#print1700_7ShowHideBtnId").css("display","inline");
			});
			
			/* Print1700_7 추가 취소하기 */
			$("#editeBody1700_7ContentsCancelBtnId").click(function(){
				$("#print1700_7InputTr").css("display","none");
				$("#editeBody1700_7ContentsCancelBtnId").css("display","none");
				$("#print1700_7ShowAddAreaBtn").css("display","inline");
				$("#print1700_7SampleImg").css("display","none");
				$("#print1700_7ShowHideBtnId").css("display","none");
			});
			
			/* Print1700_7 샘플양식 보기 */
			$("#print1700_7ShowHideBtnId").click(function(){				
				$("#print1700_7SampleImg").css("display","block");					
			});
			
			/* Print1700_7 샘플양식 숨기기 */
			$("#print1700_7SampleImg").click(function(){				
				$("#print1700_7SampleImg").css("display","none");					
			});
			
			/* Print1700_7 신규 입력 */
			$("#addBody1700_7ContentsOkBtn").click(function(){
				$.post("./insBody1700_7Ok",
						{	
							 suimRptNo			:"${suimRptBody1700Vo.suimRptNo}"
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
									
									$("#print1700_7InputTr").css("display","none");
									$("#editeBody1700_7ContentsCancelBtnId").css("display","none");
									$("#print1700_7ShowAddAreaBtn").css("display","inline");
									$("#print1700_7SampleImg").css("display","none");
									$("#print1700_7ShowHideBtnId").css("display","none");
									
									$(".Print1700_7ListInputClass").css("display","none");
									
									$("#Print1700_7List").append(
										"<tr id = 'Print1700_7ListTr_"+dataStream[1]+"'>"
										+	"<td align='center' class='td'>"
										+		"<span >"+dataStream[0]+"</span>"
										+	"</td>"
										+	"<td class='td'>"
										+		"<span id = 'attachNameSpan_"+dataStream[1]+"'>"+$("#attachName").val()+"</span>"
										+		"<input type='text' size='40' style='display:none;' class='Print1700_7ListInputClass' id = 'attachNameForEdite_"+dataStream[1]+"' value='"+$("#attachName").val()+"'/>"
										+	"</td>"
										+	"<td class='td' align='center' >"
										+		"<span id = 'attachCopySpan_"+dataStream[1]+"'>"+$("#attachCopy").val()+"</span>"
										+		"<input type='text' size='4' style='display:none;' class='Print1700_7ListInputClass' id = 'attachCopyForEdite_"+dataStream[1]+"' value='"+$("#attachCopy").val()+"'/>"
										+	"</td>"
										+	"<td class='td'  >"
										+		"<span id = 'attachEtcMemoSpan_"+dataStream[1]+"'>"+$("#attachEtcMemo").val()+"</span>"
										+		"<input type='text' size='25' style='display:none;' class='Print1700_7ListInputClass' id = 'attachEtcMemoForEdite_"+dataStream[1]+"' value='"+$("#attachEtcMemo").val()+"'/>"
										+	"</td>"
										+	"<td class='td' align='center'>"
										+		"<img src='./resources/ls_img/btn_edit_s.gif' id = 'editePrint1700_7Btn_"+dataStream[1]+"' onclick=\"print1700_7Edit('"+dataStream[1]+"');\" style='cursor:pointer; '/>  "
										+		"<img src='./resources/ls_img/btn_del_s.gif' id = 'delPrint1700_7Btn_"+dataStream[1]+"' onclick=\"print1700_7Del('"+dataStream[1]+"');\" style='cursor:pointer; '/>"
										+		"<img id = 'editeBody1700_7ContentsOkBtn_"+dataStream[1]+"' src='./resources/ls_img/btn_check_s.gif' title='수정 완료' style='display:none;cursor:pointer;' onclick=\"editePrint1700_7Ok('"+dataStream[1]+"');\" />"
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
		
		/* Print1700_7 수정하기 화면 동작*/
		function print1700_7Edit(serialNo){
			$("#attachNameSpan_"+serialNo).css("display","none");
			$("#attachCopySpan_"+serialNo).css("display","none");
			$("#attachEtcMemoSpan_"+serialNo).css("display","none");
			
			$("#editePrint1700_7Btn_"+serialNo).css("display","none");
			$("#delPrint1700_7Btn_"+serialNo).css("display","none");
			
			$("#attachNameForEdite_"+serialNo).css("display","inline");
			$("#attachCopyForEdite_"+serialNo).css("display","inline");
			$("#attachEtcMemoForEdite_"+serialNo).css("display","inline");

			$("#editeBody1700_7ContentsOkBtn_"+serialNo).css("display","inline");
			
		}
		
		/* Print1700_7 수정하기 Ok*/
		function editePrint1700_7Ok(serialNo){
			$.post("./editeBody1700_7Ok",
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
								
								$("#editePrint1700_7Btn_"+serialNo).css("display","inline");
								$("#delPrint1700_7Btn_"+serialNo).css("display","inline");
								
								$("#attachNameForEdite_"+serialNo).css("display","none");
								$("#attachCopyForEdite_"+serialNo).css("display","none");
								$("#attachEtcMemoForEdite_"+serialNo).css("display","none");

								$("#editeBody1700_7ContentsOkBtn_"+serialNo).css("display","none");
								
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
		
		/* Print1700_7 삭제하기 */
		function print1700_7Del(serialNo){
			if(confirm("삭제하시겠습니까?")){
				$.post("./delBody1700_7Ok",
						{	
								serialNo	:serialNo
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("삭제 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									
									$("#Print1700_7ListTr_"+serialNo).remove();
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
					<b>▣  첨부자료 목록 
						<img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print1700_7ShowHideBtnId" style="display:none; cursor:pointer; "  />
					</b>
				</p>
			</td>
			<td height="25" width="50%">
				<p align="right">
				<c:if test="${suimVO.suimRptState eq 0}">
					<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id = "print1700_7ShowAddAreaBtn" style="float:right; cursor:pointer; "  />
					<img src="./resources/ls_img/btn_write_cancel.gif" title="추가 취소" id = "editeBody1700_7ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
				</c:if>	
				</p>
			</td>
		</tr>
		<tr >
			<td colspan="2" align="center">
				<img src="./resources/ls_img/ls_body/1/08.jpg" title="첨부자료 목록 샘플 양식" id = "print1700_7SampleImg" style="display:none; cursor:pointer; " onclick="print1700_7ShowHide();" />
			</td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0" align="center" width="660">
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
			<td class="td" bgcolor="#ECECEC" width="195" >
				<p align="center"><b>비고</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="40" >
				<p align="center"><b>-</b></p>
			</td>
		</tr>
		<tbody id = "Print1700_7List">
			<c:forEach items="${suimRptBody1700_7List }" var="suimRptBody1700_7Vo">
				<tr id = "Print1700_7ListTr_${suimRptBody1700_7Vo.serialNo}">
					<td align="center" class="td">
						<span >${suimRptBody1700_7Vo.ROWNUM}</span>
					</td>
					<td class="td"  >
						<span id = "attachNameSpan_${suimRptBody1700_7Vo.serialNo}">${suimRptBody1700_7Vo.attachName}</span>
						<input type="text" style='display:none;' size="40" class="Print1700_7ListInputClass" id = "attachNameForEdite_${suimRptBody1700_7Vo.serialNo}" value="${suimRptBody1700_7Vo.attachName}"/>
					</td>
					<td class="td" align="center" >
						<span id = "attachCopySpan_${suimRptBody1700_7Vo.serialNo}">${suimRptBody1700_7Vo.attachCopy}</span>
						<input type="text" style='display:none;' size="4" class="Print1700_7ListInputClass" id = "attachCopyForEdite_${suimRptBody1700_7Vo.serialNo}" value="${suimRptBody1700_7Vo.attachCopy}"/>
					</td>
					<td class="td"  >
						<span id = "attachEtcMemoSpan_${suimRptBody1700_7Vo.serialNo}">${suimRptBody1700_7Vo.attachEtcMemo}</span>
						<input type="text" style='display:none;' size="25" class="Print1700_7ListInputClass" id = "attachEtcMemoForEdite_${suimRptBody1700_7Vo.serialNo}" value="${suimRptBody1700_7Vo.attachEtcMemo}"/>
					</td>
					<td class="td" align="center">
					<c:if test="${suimVO.suimRptState eq 0}">
						<img src='./resources/ls_img/btn_edit_s.gif' id = "editePrint1700_7Btn_${suimRptBody1700_7Vo.serialNo}" onclick="print1700_7Edit('${suimRptBody1700_7Vo.serialNo}');" style='cursor:pointer; '/>
						<img src='./resources/ls_img/btn_del_s.gif' id = "delPrint1700_7Btn_${suimRptBody1700_7Vo.serialNo}" onclick="print1700_7Del('${suimRptBody1700_7Vo.serialNo}');" style='cursor:pointer; '/>
						<img id = "editeBody1700_7ContentsOkBtn_${suimRptBody1700_7Vo.serialNo}" src="./resources/ls_img/btn_check_s.gif" title="수정 완료" style="display:none;cursor:pointer;" onclick="editePrint1700_7Ok('${suimRptBody1700_7Vo.serialNo}');" />
					</c:if>
					</td>
				</tr>					
			</c:forEach>
		</tbody>
		<tr id = "print1700_7InputTr" style="display:none;">
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
				<input type="text" size="25" id = "attachEtcMemo"/>
			</td>
			<td width="30" class="td"  align="center">
				<img id = "addBody1700_7ContentsOkBtn" src="./resources/ls_img/btn_check_s.gif" title="확인사항 추가" style="cursor:pointer;" />
			</td>
		</tr>
	</table>
	<p>&nbsp;</p>
</body>