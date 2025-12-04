<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>	
	<script>
		$(document).ready(function(){
			
			/* Print_2 추가 영역 보이기 */
			$("#print1_2ShowAddAreaBtn").click(function(){
				$("#print1_2InputTr").css("display","inline");
				$("#editeBody1_2ContentsCancelBtnId").css("display","inline");
				$("#print1_2ShowAddAreaBtn").css("display","none");
				$("#print1_2ShowHideBtnId").css("display","inline");
			});
			
			/* Print_2 추가 취소하기 */
			$("#editeBody1_2ContentsCancelBtnId").click(function(){
				$("#print1_2InputTr").css("display","none");
				$("#editeBody1_2ContentsCancelBtnId").css("display","none");
				$("#print1_2ShowAddAreaBtn").css("display","inline");
				$("#print1_2SampleImg").css("display","none");
				$("#print1_2ShowHideBtnId").css("display","none");
			});
			
			/* Print_2 샘플양식 보기 */
			$("#print1_2ShowHideBtnId").click(function(){				
				$("#print1_2SampleImg").css("display","block");					
			});
			
			/* Print_2 샘플양식 숨기기 */
			$("#print1_2SampleImg").click(function(){				
				$("#print1_2SampleImg").css("display","none");					
			});
			
			/* Print1_2 신규 입력 */
			$("#addBody1_2ContentsOkBtn").click(function(){
				$.post("./insBody1_2Ok",
						{	
							 rptPrintNo			:"${suimRptBody1_13467Vo.rptPrintNo}"
							,otherInsuCom  		:$("#otherInsuCom").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//보험
							,otherInsuDtl  		:$("#otherInsuDtl").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//보험내용
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장을 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$("#print1_2InputTr").css("display","none");
									$("#editeBody1_2ContentsCancelBtnId").css("display","none");
									$("#print1_2ShowAddAreaBtn").css("display","inline");
									$("#print1_2SampleImg").css("display","none");
									$("#print1_2ShowHideBtnId").css("display","none");
									
									$("#print1_2List").append(
										"<tr id = 'print1_2ListTr_"+data+"'>"
											+"<td class='td' id = 'otherInsuComTd_"+data+"' align='center'>"
												+"<span id = 'otherInsuComForSpan_"+data+"'>"+$("#otherInsuCom").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
												+"<input type='text' size='15' style='display:none;' id = 'otherInsuComForEdite_"+data+"' value = '"+$("#otherInsuCom").val()+"' />"
											+"</td>"
											+"<td class='td' colspan='3' id = 'otherInsuDtlTd_"+data+"'>"
												+"<span id = 'otherInsuDtlForSpan_"+data+"'>"+$("#otherInsuDtl").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
												+"<textarea style='width:99%;height:55px;overflow:visible; display:none;' id = 'otherInsuDtlForEdite_"+data+"'>"+$("#otherInsuDtl").val()+"</textarea>"
											+"</td>"
											+"<td class='td'>" 
												+ "<img src='./resources/ls_img/btn_edit_s.gif' id = 'editePrint1_2Btn_"+data+"' onclick=\"print2Edit('"+data+"');\" style='cursor:pointer;'/> "
												+ "<img src='./resources/ls_img/btn_del_s.gif' id = 'delPrint1_2Btn_"+data+"' onclick='print2Del("+data+");' style='cursor:pointer;'/>"
												+ "<img id = 'editeBody1_2ContentsOkBtn_"+data+"' src='./resources/ls_img/btn_check_s.gif' title='수정 완료' style='display:none;cursor:pointer;' onclick=\"editePrint1_2Ok('"+data+"');\" />"
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
		
		/* Print1_2 수정하기 화면 동작*/
		function print2Edit(serialNo){
			$("#otherInsuComForSpan_"+serialNo).css("display","none");
			$("#otherInsuDtlForSpan_"+serialNo).css("display","none");
			$("#editePrint1_2Btn_"+serialNo).css("display","none");
			$("#delPrint1_2Btn_"+serialNo).css("display","none");
			
			$("#otherInsuComForEdite_"+serialNo).css("display","inline");
			$("#otherInsuDtlForEdite_"+serialNo).css("display","inline");
			
			$("#editeBody1_2ContentsOkBtn_"+serialNo).css("display","inline");
			
		}
		
		/* Print1_2 수정하기 Ok*/
		function editePrint1_2Ok(serialNo){
			$.post("./editeBody1_2Ok",
					{	
							serialNo			:serialNo
							,otherInsuCom  		:$("#otherInsuComForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//보험
							,otherInsuDtl  		:$("#otherInsuDtlForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//보험내용
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								
								$("#otherInsuComForSpan_"+serialNo).css("display","inline");
								$("#otherInsuDtlForSpan_"+serialNo).css("display","inline");
								$("#editePrint1_2Btn_"+serialNo).css("display","inline");
								$("#delPrint1_2Btn_"+serialNo).css("display","inline");
								
								$("#otherInsuComForEdite_"+serialNo).css("display","none");
								$("#otherInsuDtlForEdite_"+serialNo).css("display","none");
								
								$("#editeBody1_2ContentsOkBtn_"+serialNo).css("display","none");
								
								$("#otherInsuComForSpan_"+serialNo).html("");
								$("#otherInsuDtlForSpan_"+serialNo).html("");
								
								$("#otherInsuComForSpan_"+serialNo).html($("#otherInsuComForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								$("#otherInsuDtlForSpan_"+serialNo).html($("#otherInsuDtlForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
			
		}
		
		/* Print1_2 삭제하기 */
		function print2Del(serialNo){
			if(confirm("삭제하시겠습니까?")){
				$.post("./delBody1_2Ok",
						{	
								serialNo	:serialNo
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("삭제 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									
									$("#print1_2ListTr_"+serialNo).remove();
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
					<b>2. 타 보험계약사항 
						<img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print1_2ShowHideBtnId" style="display:none; cursor:pointer; "  />
					</b>
				</p>
			</td>
			<td height="25" width="50%">
				<p align="right">
					<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id = "print1_2ShowAddAreaBtn" style="float:right; cursor:pointer; "  />
					<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody1_2ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
				</p>
			</td>
		</tr>
		<tr >
			<td colspan="2" align="center">
				<img src="./resources/ls_img/ls_body/1/02.jpg" title="계약 사항 샘플 양식" id = "print1_2SampleImg" style="display:none; cursor:pointer; " onclick="print1_1ShowHide();" />
			</td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
		<tr>
			<td bgcolor="#ECECEC" class="td" width="140">
				<p align="center"><b>보험회사</b></p>
			</td>
			<td colspan="3" class="td" bgcolor="#ECECEC" width="460">
				<p align="center"><b>중요사항</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="35">
				<p align="center"><b>비고</b></p>
			</td>
		</tr>
		
		<tbody id = "print1_2List">
			<c:forEach items="${suimRptBody1_2List }" var="suimRptBody1_2Vo">
				<tr id = "print1_2ListTr_${suimRptBody1_2Vo.serialNo}">
					<td align="center" class="td" id = "otherInsuComTd_${suimRptBody1_2Vo.serialNo}">
						<span id = "otherInsuComForSpan_${suimRptBody1_2Vo.serialNo}">${suimRptBody1_2Vo.otherInsuComSpan}</span>
						<input type="text" size="15" style="display:none;" id = "otherInsuComForEdite_${suimRptBody1_2Vo.serialNo}" value = "${suimRptBody1_2Vo.otherInsuCom}" />
					</td>
					<td class="td" colspan="3" id = "otherInsuDtlTd_${suimRptBody1_2Vo.serialNo}">
						<span id = "otherInsuDtlForSpan_${suimRptBody1_2Vo.serialNo}">${suimRptBody1_2Vo.otherInsuDtlSpan}</span>
						<textarea style="width:99%;height:55px;overflow:visible; display:none;" id = "otherInsuDtlForEdite_${suimRptBody1_2Vo.serialNo}">${suimRptBody1_2Vo.otherInsuDtl}</textarea>
					</td>
					<td class="td">
						<img src='./resources/ls_img/btn_edit_s.gif' id = "editePrint1_2Btn_${suimRptBody1_2Vo.serialNo}" onclick="print2Edit('${suimRptBody1_2Vo.serialNo}');" style='cursor:pointer;'/>
						<img src='./resources/ls_img/btn_del_s.gif' id = "delPrint1_2Btn_${suimRptBody1_2Vo.serialNo}" onclick="print2Del('${suimRptBody1_2Vo.serialNo}');" style='cursor:pointer;'/>
						<img id = "editeBody1_2ContentsOkBtn_${suimRptBody1_2Vo.serialNo}" src="./resources/ls_img/btn_check_s.gif" title="수정 완료" style="display:none;cursor:pointer;" onclick="editePrint1_2Ok('${suimRptBody1_2Vo.serialNo}');" />
					</td>
				</tr>					
			</c:forEach>
		</tbody>
		<tr id = "print1_2InputTr" style="display:none;">
			<td align="center" class="td">
				<input type="text" size="15" class="print1_2ListInputClass" id = "otherInsuCom" />
			</td >
			<td colspan="3"  class="td">
				<textarea style="width:99%;height:55px;overflow:visible;" id = "otherInsuDtl"></textarea>
			</td>
			<td class="td">
				<img id = "addBody1_2ContentsOkBtn" src="./resources/ls_img/btn_check_s.gif" title="타 보험 추가" style="cursor:pointer;" />
			</td>
		</tr>
							
	</table>
	<p>&nbsp;</p>
</body>