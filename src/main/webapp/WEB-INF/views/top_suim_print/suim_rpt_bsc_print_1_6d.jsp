<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>	
	<script>
		$(document).ready(function(){
			
			/* Print1_6_2 추가 영역 보이기 */
			$("#print1_6_2ShowAddAreaBtn").click(function(){
				$("#print1_6_2InputTr").css("display","inline");
				$("#editeBody1_6_2ContentsCancelBtnId").css("display","inline");
				$("#print1_6_2ShowAddAreaBtn").css("display","none");
				$("#print1_6_2ShowHideBtnId").css("display","inline");
			});
			
			/* Print1_6_2 추가 취소하기 */
			$("#editeBody1_6_2ContentsCancelBtnId").click(function(){
				$("#print1_6_2InputTr").css("display","none");
				$("#editeBody1_6_2ContentsCancelBtnId").css("display","none");
				$("#print1_6_2ShowAddAreaBtn").css("display","inline");
				$("#print1_6_2SampleImg").css("display","none");
				$("#print1_6_2ShowHideBtnId").css("display","none");
			});
			
			/* Print1_6_2 샘플양식 보기 */
			$("#print1_6_2ShowHideBtnId").click(function(){				
				$("#print1_6_2SampleImg").css("display","block");					
			});
			
			/* Print1_6_2 샘플양식 숨기기 */
			$("#print1_6_2SampleImg").click(function(){				
				$("#print1_6_2SampleImg").css("display","none");					
			});
			
			/* Print1_6_2 신규 입력 */
			$("#addBody1_6_2ContentsOkBtn").click(function(){
				$.post("./insBody1_6_2Ok",
						{	
							 rptPrintNo			:"${suimRptBody1_13467Vo.rptPrintNo}"
							,confirmOutline  	:$.trim($("#confirmOutline").val())							//확인 사항
							,confirmDtl  		:$.trim($("#confirmDtl").val()).replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//확인 내용
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장을 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$("#print1_6_2InputTr").css("display","none");
									$("#editeBody1_6_2ContentsCancelBtnId").css("display","none");
									$("#print1_6_2ShowAddAreaBtn").css("display","inline");
									$("#print1_6_2SampleImg").css("display","none");
									$("#print1_6_2ShowHideBtnId").css("display","none");
									
									$(".Print1_6_2ListInputClass").css("display","none");
									
									$("#Print1_6_2List").append(
										"<tr id = 'Print1_6_2ListTr_"+data+"'>"
										+	"<td align='center' class='td' width='140' >"
										+		"<input size='18' type='text' class='Print1_6_2ListInputClass' style='display:none;' id = 'confirmOutlineForEdite_"+data+"' value='"+$("#confirmOutline").val()+"'/>"
										+		"<span id = 'confirmOutlineSpan_"+data+"'>"+$("#confirmOutline").val()+"</span>"
										+	"</td>"
										+	"<td class='td' colspan='3' width='495' >"
										+		"<span id = 'confirmDtlSpan_"+data+"'>"+$("#confirmDtl").val()+"</span>"
										+		"<textarea class='Print1_6_2ListInputClass' style='width:99%;height:55px;overflow:visible; display:none;' id = 'confirmDtlForEdite_"+data+"'>"+$("#confirmDtl").val()+"</textarea>"
										+	"</td>"
										+	"<td align='center' width='50' class='td'>"
										+		"<img src='./resources/ls_img/btn_edit_s.gif' id = 'editePrint1_6_2Btn_"+data+"' onclick=\"print1_6_2Edit('"+data+"');\" style='cursor:pointer; '/> "
										+		"<img src='./resources/ls_img/btn_del_s.gif' id = 'delPrint1_6_2Btn_"+data+"' onclick=\"print1_6_2Del('"+data+"');\" style='cursor:pointer; '/>"
										+		"<img id = 'editeBody1_6_2ContentsOkBtn_"+data+"' src='./resources/ls_img/btn_check_s.gif' title='수정 완료' style='display:none;cursor:pointer;' onclick=\"editePrint1_6_2Ok('"+data+"');\" />"
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
		
		/* Print1_6_2 수정하기 화면 동작*/
		function print1_6_2Edit(serialNo){
			$("#confirmOutlineSpan_"+serialNo).css("display","none");
			$("#confirmDtlSpan_"+serialNo).css("display","none");
			
			$("#editePrint1_6_2Btn_"+serialNo).css("display","none");
			$("#delPrint1_6_2Btn_"+serialNo).css("display","none");
			
			$("#confirmOutlineForEdite_"+serialNo).css("display","inline");
			$("#confirmDtlForEdite_"+serialNo).css("display","inline");

			$("#editeBody1_6_2ContentsOkBtn_"+serialNo).css("display","inline");
			
		}
		
		/* Print1_6_2 수정하기 Ok*/
		function editePrint1_6_2Ok(serialNo){
			$.post("./editeBody1_6_2Ok",
					{	
							serialNo			:serialNo
							,confirmOutline		:$("#confirmOutlineForEdite_"+serialNo).val()					
							,confirmDtl  		:$("#confirmDtlForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')						
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								
								$("#confirmOutlineSpan_"+serialNo).css("display","inline");
								$("#confirmDtlSpan_"+serialNo).css("display","inline");
								
								$("#editePrint1_6_2Btn_"+serialNo).css("display","inline");
								$("#delPrint1_6_2Btn_"+serialNo).css("display","inline");
								
								$("#confirmOutlineForEdite_"+serialNo).css("display","none");
								$("#confirmDtlForEdite_"+serialNo).css("display","none");

								$("#editeBody1_6_2ContentsOkBtn_"+serialNo).css("display","none");
								
								$("#confirmOutlineSpan_"+serialNo).html("");
								$("#confirmDtlSpan_"+serialNo).html("");
								
								$("#confirmOutlineSpan_"+serialNo).html($("#confirmOutlineForEdite_"+serialNo).val());
								$("#confirmDtlSpan_"+serialNo).html($("#confirmDtlForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
			
		}
		
		/* Print1_6_2 삭제하기 */
		function print1_6_2Del(serialNo){
			if(confirm("삭제하시겠습니까?")){
				$.post("./delBody1_6_2Ok",
						{	
								serialNo	:serialNo
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("삭제 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									
									$("#Print1_6_2ListTr_"+serialNo).remove();
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
					<b>6-다-2. 조사내용 
						<img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print1_6_2ShowHideBtnId" style="display:none; cursor:pointer; "  />
					</b>
				</p>
			</td>
			<td height="25" width="50%">
				<p align="right">
					<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id = "print1_6_2ShowAddAreaBtn" style="float:right; cursor:pointer; "  />
					<img src="./resources/ls_img/btn_write_cancel.gif" title="추가 취소" id = "editeBody1_6_2ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
				</p>
			</td>
		</tr>
		<tr >
			<td colspan="2" align="center">
				<img src="./resources/ls_img/ls_body/1/06d.jpg" title="계약 사항 샘플 양식" id = "print1_6_2SampleImg" style="display:none; cursor:pointer; " onclick="print1_1ShowHide();" />
			</td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="652">
		<tr>
			<td bgcolor="#ECECEC" class="td" width="595" style="border-bottom:0;">
				<p align="left"><b>다-2. 기타사항</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="50" style="border-bottom:0;">
				<p align="center"><b>비고</b></p>
			</td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="661">
		<tbody id = "Print1_6_2List">
			<c:forEach items="${suimRptBody1_6_2List }" var="suimRptBody1_6_2Vo">
				<tr id = "Print1_6_2ListTr_${suimRptBody1_6_2Vo.serialNo}">
					<td align="center" class="td" width="140" >
						<input type="text" size="18" class="Print1_6_2ListInputClass" style="display:none;" id = "confirmOutlineForEdite_${suimRptBody1_6_2Vo.serialNo}" value="${suimRptBody1_6_2Vo.confirmOutline }"/>
						<span id = "confirmOutlineSpan_${suimRptBody1_6_2Vo.serialNo}">${suimRptBody1_6_2Vo.confirmOutline}</span>
					</td>
					<td class="td" colspan="3" width="448" >
						<span id = "confirmDtlSpan_${suimRptBody1_6_2Vo.serialNo}">${suimRptBody1_6_2Vo.confirmDtlSpan}</span>
						<textarea class="Print1_6_2ListInputClass" style="width:99%;height:55px;overflow:visible; display:none;" id = "confirmDtlForEdite_${suimRptBody1_6_2Vo.serialNo}">${suimRptBody1_6_2Vo.confirmDtl}</textarea>
					</td>
					<td width="50" class="td" align="center">
						<img src='./resources/ls_img/btn_edit_s.gif' id = "editePrint1_6_2Btn_${suimRptBody1_6_2Vo.serialNo}" onclick="print1_6_2Edit('${suimRptBody1_6_2Vo.serialNo}');" style='cursor:pointer; '/>
						<img src='./resources/ls_img/btn_del_s.gif' id = "delPrint1_6_2Btn_${suimRptBody1_6_2Vo.serialNo}" onclick="print1_6_2Del('${suimRptBody1_6_2Vo.serialNo}');" style='cursor:pointer; '/>
						<img id = "editeBody1_6_2ContentsOkBtn_${suimRptBody1_6_2Vo.serialNo}" src="./resources/ls_img/btn_check_s.gif" title="수정 완료" style="display:none;cursor:pointer;" onclick="editePrint1_6_2Ok('${suimRptBody1_6_2Vo.serialNo}');" />
					</td>
				</tr>					
			</c:forEach>
		</tbody>
		<tr id = "print1_6_2InputTr" style="display:none;">
			<td align="center" class="td" width="150">
				<input type="text" size="18" id = "confirmOutline" />
			</td >
			<td class="td" colspan="3" width="438">
				<textarea style="width:99%;height:55px;overflow:visible;" id = "confirmDtl"></textarea>
			</td>
			<td width="50" class="td"  align="center">
				<img id = "addBody1_6_2ContentsOkBtn" src="./resources/ls_img/btn_check_s.gif" title="확인사항 추가" style="cursor:pointer;" />
			</td>
		</tr>
	</table>
	<p>&nbsp;</p>
</body>