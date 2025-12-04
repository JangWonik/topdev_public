<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>	
	<script>
		$(document).ready(function(){
			
			/* Print9_file 추가 영역 보이기 */
			$("#Print9_fileShowAddAreaBtn").click(function(){
				$("#Print9_fileInputTr").css("display","inline");
				$("#editeBody9_fileContentsCancelBtnId").css("display","inline");
				$("#Print9_fileShowAddAreaBtn").css("display","none");
				$("#Print9_fileShowHideBtnId").css("display","inline");
			});
			
			/* Print9_file 추가 취소하기 */
			$("#editeBody9_fileContentsCancelBtnId").click(function(){
				$("#Print9_fileInputTr").css("display","none");
				$("#editeBody9_fileContentsCancelBtnId").css("display","none");
				$("#Print9_fileShowAddAreaBtn").css("display","inline");
				$("#Print9_fileSampleImg").css("display","none");
				$("#Print9_fileShowHideBtnId").css("display","none");
			});
			
			/* Print9_file 샘플양식 보기 */
			$("#Print9_fileShowHideBtnId").click(function(){				
				$("#Print9_fileSampleImg").css("display","block");					
			});
			
			/* Print9_file 샘플양식 숨기기 */
			$("#Print9_fileSampleImg").click(function(){				
				$("#Print9_fileSampleImg").css("display","none");					
			});
			
			/* Print9_file 신규 입력 */
			$("#addBody9_fileContentsOkBtn").click(function(){
				$.post("./insBody9_fileOk",
						{	
							 rptPrintNo			:"${suimRptBody9_13467Vo.rptPrintNo}"
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
									
									$("#Print9_fileInputTr").css("display","none");
									$("#editeBody9_fileContentsCancelBtnId").css("display","none");
									$("#Print9_fileShowAddAreaBtn").css("display","inline");
									$("#Print9_fileSampleImg").css("display","none");
									$("#Print9_fileShowHideBtnId").css("display","none");
									
									$(".Print9_fileListInputClass").css("display","none");
									
									$("#Print9_fileList").append(
										"<tr id = 'Print9_fileListTr_"+dataStream[1]+"'>"
										+	"<td align='center' class='td'>"
										+		"<span >"+dataStream[0]+"</span>"
										+	"</td>"
										+	"<td class='td'>"
										+		"<span id = 'attachNameSpan_"+dataStream[1]+"'>"+$("#attachName").val()+"</span>"
										+		"<input type='text' size='40' style='display:none;' class='Print9_fileListInputClass' id = 'attachNameForEdite_"+dataStream[1]+"' value='"+$("#attachName").val()+"'/>"
										+	"</td>"
										+	"<td class='td' align='center' >"
										+		"<span id = 'attachCopySpan_"+dataStream[1]+"'>"+$("#attachCopy").val()+"</span>"
										+		"<input type='text' size='4' style='display:none;' class='Print9_fileListInputClass' id = 'attachCopyForEdite_"+dataStream[1]+"' value='"+$("#attachCopy").val()+"'/>"
										+	"</td>"
										+	"<td class='td'  >"
										+		"<span id = 'attachEtcMemoSpan_"+dataStream[1]+"'>"+$("#attachEtcMemo").val()+"</span>"
										+		"<input type='text' size='25' style='display:none;' class='Print9_fileListInputClass' id = 'attachEtcMemoForEdite_"+dataStream[1]+"' value='"+$("#attachEtcMemo").val()+"'/>"
										+	"</td>"
										+	"<td class='td' align='center'>"
										+		"<img src='./resources/ls_img/btn_edit_s.gif' id = 'editePrint9_fileBtn_"+dataStream[1]+"' onclick=\"Print9_fileEdit('"+dataStream[1]+"');\" style='cursor:pointer; '/>  "
										+		"<img src='./resources/ls_img/btn_del_s.gif' id = 'delPrint9_fileBtn_"+dataStream[1]+"' onclick=\"Print9_fileDel('"+dataStream[1]+"');\" style='cursor:pointer; '/>"
										+		"<img id = 'editeBody9_fileContentsOkBtn_"+dataStream[1]+"' src='./resources/ls_img/btn_check_s.gif' title='수정 완료' style='display:none;cursor:pointer;' onclick=\"editePrint9_fileOk('"+dataStream[1]+"');\" />"
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
		
		/* Print9_file 수정하기 화면 동작*/
		function Print9_fileEdit(serialNo){
			$("#attachNameSpan_"+serialNo).css("display","none");
			$("#attachCopySpan_"+serialNo).css("display","none");
			$("#attachEtcMemoSpan_"+serialNo).css("display","none");
			
			$("#editePrint9_fileBtn_"+serialNo).css("display","none");
			$("#delPrint9_fileBtn_"+serialNo).css("display","none");
			
			$("#attachNameForEdite_"+serialNo).css("display","inline");
			$("#attachCopyForEdite_"+serialNo).css("display","inline");
			$("#attachEtcMemoForEdite_"+serialNo).css("display","inline");

			$("#editeBody9_fileContentsOkBtn_"+serialNo).css("display","inline");
			
		}
		
		/* Print9_file 수정하기 Ok*/
		function editePrint9_fileOk(serialNo){
			$.post("./editeBody9_fileOk",
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
								
								$("#editePrint9_fileBtn_"+serialNo).css("display","inline");
								$("#delPrint9_fileBtn_"+serialNo).css("display","inline");
								
								$("#attachNameForEdite_"+serialNo).css("display","none");
								$("#attachCopyForEdite_"+serialNo).css("display","none");
								$("#attachEtcMemoForEdite_"+serialNo).css("display","none");

								$("#editeBody9_fileContentsOkBtn_"+serialNo).css("display","none");
								
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
		
		/* Print9_file 삭제하기 */
		function Print9_fileDel(serialNo){
			if(confirm("삭제하시겠습니까?")){
				$.post("./delBody9_fileOk",
						{	
								serialNo	:serialNo
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("삭제 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									
									$("#Print9_fileListTr_"+serialNo).remove();
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
					<b>3. 첨부서류 
						<img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "Print9_fileShowHideBtnId" style="display:none; cursor:pointer; "  />
					</b>
				</p>
			</td>
			<td height="25" width="50%">
				<p align="right">
					<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id = "Print9_fileShowAddAreaBtn" style="float:right; cursor:pointer; "  />
					<img src="./resources/ls_img/btn_write_cancel.gif" title="추가 취소" id = "editeBody9_fileContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
				</p>
			</td>
		</tr>
		<tr >
			<td colspan="2" align="center">
				<img src="./resources/ls_img/ls_body/1/08.jpg" title="첨부자료 목록 샘플 양식" id = "Print9_fileSampleImg" style="display:none; cursor:pointer; " onclick="Print9_fileShowHide();" />
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
			<td class="td" bgcolor="#ECECEC" width="180" >
				<p align="center"><b>비고</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="40" >
				<p align="center"><b>-</b></p>
			</td>
		</tr>
	<!-- </table>
	<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="661"> -->
		<tbody id = "Print9_fileList">
			<c:forEach items="${suimRptBody9_fileList }" var="suimRptBody9_fileVo">
				<tr id = "Print9_fileListTr_${suimRptBody9_fileVo.serialNo}">
					<td align="center" class="td">
						<span >${suimRptBody9_fileVo.ROWNUM}</span>
					</td>
					<td class="td"  >
						<span id = "attachNameSpan_${suimRptBody9_fileVo.serialNo}">${suimRptBody9_fileVo.attachName}</span>
						<input type="text" style='display:none;' size="40" class="Print9_fileListInputClass" id = "attachNameForEdite_${suimRptBody9_fileVo.serialNo}" value="${suimRptBody9_fileVo.attachName}"/>
					</td>
					<td class="td" align="center" >
						<span id = "attachCopySpan_${suimRptBody9_fileVo.serialNo}">${suimRptBody9_fileVo.attachCopy}</span>
						<input type="text" style='display:none;' size="4" class="Print9_fileListInputClass" id = "attachCopyForEdite_${suimRptBody9_fileVo.serialNo}" value="${suimRptBody9_fileVo.attachCopy}"/>
					</td>
					<td class="td"  >
						<span id = "attachEtcMemoSpan_${suimRptBody9_fileVo.serialNo}">${suimRptBody9_fileVo.attachEtcMemo}</span>
						<input type="text" style='display:none;' size="25" class="Print9_fileListInputClass" id = "attachEtcMemoForEdite_${suimRptBody9_fileVo.serialNo}" value="${suimRptBody9_fileVo.attachEtcMemo}"/>
					</td>
					<td class="td" align="center">
						<img src='./resources/ls_img/btn_edit_s.gif' id = "editePrint9_fileBtn_${suimRptBody9_fileVo.serialNo}" onclick="Print9_fileEdit('${suimRptBody9_fileVo.serialNo}');" style='cursor:pointer; '/>
						<img src='./resources/ls_img/btn_del_s.gif' id = "delPrint9_fileBtn_${suimRptBody9_fileVo.serialNo}" onclick="Print9_fileDel('${suimRptBody9_fileVo.serialNo}');" style='cursor:pointer; '/>
						<img id = "editeBody9_fileContentsOkBtn_${suimRptBody9_fileVo.serialNo}" src="./resources/ls_img/btn_check_s.gif" title="수정 완료" style="display:none;cursor:pointer;" onclick="editePrint9_fileOk('${suimRptBody9_fileVo.serialNo}');" />
					</td>
				</tr>					
			</c:forEach>
		</tbody>
		<tr id = "Print9_fileInputTr" style="display:none;">
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
				<img id = "addBody9_fileContentsOkBtn" src="./resources/ls_img/btn_check_s.gif" title="확인사항 추가" style="cursor:pointer;" />
			</td>
		</tr>
	</table>
	<p>&nbsp;</p>
</body>