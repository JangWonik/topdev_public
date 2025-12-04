<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>	
	<script>
		$(document).ready(function(){

			if("${rptWriteFlag}" == "yes"){
				$("#rptWrite").click();
			}
			
			/* Print_5 추가 영역 보이기 */
			$("#print1_6_1ShowAddAreaBtn").click(function(){
				$(".print1_6_1InputTr").css("display","inline");
				$("#editeBody1_6_1ContentsCancelBtnId").css("display","inline");
				$("#print1_6_1ShowAddAreaBtn").css("display","none");
				$("#print1_6_1ShowHideBtnId").css("display","inline");
			});
			
			/* Print_5 추가 취소하기 */
			$("#editeBody1_6_1ContentsCancelBtnId").click(function(){
				$(".print1_6_1InputTr").css("display","none");
				$("#editeBody1_6_1ContentsCancelBtnId").css("display","none");
				$("#print1_6_1ShowAddAreaBtn").css("display","inline");
				$("#print1_6_1SampleImg").css("display","none");
				$("#print1_6_1ShowHideBtnId").css("display","none");
			});
			
			/* Print_5 샘플양식 보기 */
			$("#print1_6_1ShowHideBtnId").click(function(){				
				$("#print1_6_1SampleImg").css("display","block");					
			});
			
			/* Print_5 샘플양식 숨기기 */
			$("#print1_6_1SampleImg").click(function(){				
				$("#print1_6_1SampleImg").css("display","none");					
			});
			
			/* Print1_6_1 신규 입력 */
			$("#addBody1_6_1ContentsOkBtn").click(function(){
				$.post("./insBody1_6_1Ok",
						{	
							 rptPrintNo					:"${suimRptBody1_13467Vo.rptPrintNo}"
							,investigateOutline  		:$("#investigateOutline").val()							//경과 시작일
							,investigateDtl  			:$("#investigateDtl").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//경과 종료일
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장을 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$(".print1_6_1InputTr").css("display","none");
									$("#editeBody1_6_1ContentsCancelBtnId").css("display","none");
									$("#print1_6_1ShowAddAreaBtn").css("display","inline");
									$("#print1_6_1SampleImg").css("display","none");
									$("#print1_6_1ShowHideBtnId").css("display","none");
									
									$(".Print1_6_1ListInputClass").css("display","none");
									
									$("#Print1_6_1List").append(
										"<tr class = 'Print1_6_1ListTr_"+data+"'>"
										+	"<td bgcolor='#ECECEC' class='td' width='610' id = 'investigateOutlineTd_"+data+"'>"
										+		"<p align='left'>"
										+			"<span id = 'investigateOutlineSpan_"+data+"'><b>나-."+$("#investigateOutline").val()+"</b></span>"
										+			"<input type='text' size='50' style='display:none;' class='Print1_6_1ListInputClass'  id='investigateOutlineForEdite_"+data+"'/>"
										+		"</p>"
										+	"</td>"
										+	"<td align='center' bgcolor='#ECECEC' class='td' width='40' >"
										+		"비고"
										+	"</td>"
										+"</tr>"
										+"<tr class = 'Print1_6_1ListTr_"+data+"'>"
										+	"<td class='td'  id = 'investigateDtlTd_"+data+"'>"
										+		"<span id = 'investigateDtlForSpan_"+data+"'>"+$("#investigateDtl").html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
										+		"<textarea class='Print1_6_1ListInputClass' style='width:99%;height:55px;overflow:visible; display:none;' id = 'investigateDtlForEdite_"+data+"'>"+$("#investigateDtl").html()+"</textarea>"
										+	"</td>"
										+	"<td align='center' class='td'>"
										+		"<img src='./resources/ls_img/btn_edit_s.gif' id = 'editePrint1_6_1Btn_"+data+"' onclick=\"print1_6_1Edit('"+data+"');\" style='cursor:pointer; '/>"
										+		"<img src='./resources/ls_img/btn_del_s.gif' id = 'delPrint1_6_1Btn_"+data+"' onclick=\"print1_6_1Del('"+data+"');\" style='cursor:pointer; '/>"
										+		"<img id = 'editeBody1_6_1ContentsOkBtn_"+data+"' src='./resources/ls_img/btn_check_s.gif' title='수정 완료' style='display:none;cursor:pointer;' onclick=\"editePrint1_6_1Ok('"+data+"');\" />"
										+	"</td>"
										+"</tr>"	
									);
									$("#rptWriteFlag").val("yes");
									location.href = "suimRptBscDtl?suim_rpt_no="+"${suimVO.suim_rpt_no}"+"&rptWriteFlag=yes";
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
			
			
		});
		
		/* Print1_6_1 수정하기 화면 동작*/
		function print1_6_1Edit(serialNo){
			$("#investigateOutlineSpan_"+serialNo).css("display","none");
			$("#investigateDtlSpan_"+serialNo).css("display","none");
			
			$("#editePrint1_6_1Btn_"+serialNo).css("display","none");
			$("#delPrint1_6_1Btn_"+serialNo).css("display","none");
			$("#print1_6_1ShowHideBtnId").css("display","inline");
			
			
			$("#investigateOutlineForEdite_"+serialNo).css("display","inline");
			$("#investigateDtlForEdite_"+serialNo).css("display","inline");
			
			$("#editeBody1_6_1ContentsOkBtn_"+serialNo).css("display","inline");
		}
		
		/* Print1_6_1 수정하기 Ok*/
		function editePrint1_6_1Ok(serialNo){
			$.post("./editeBody1_6_1Ok",
					{	
							serialNo					:serialNo
							,investigateOutline  		:$("#investigateOutlineForEdite_"+serialNo).val()							//경과 시작일
							,investigateDtl  			:$("#investigateDtlForEdite_"+serialNo).html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//경과 종료일
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								
								var outLineTitle = $("#investigateOutlineSpan_"+serialNo).html().split(".")[0]; 
								$("#investigateOutlineSpan_"+serialNo).css("display","inline");
								$("#investigateDtlSpan_"+serialNo).css("display","inline");
								
								$("#editePrint1_6_1Btn_"+serialNo).css("display","inline");
								$("#delPrint1_6_1Btn_"+serialNo).css("display","inline");
								
								$("#investigateOutlineForEdite_"+serialNo).css("display","none");
								$("#investigateDtlForEdite_"+serialNo).css("display","none");
								
								$("#editeBody1_6_1ContentsOkBtn_"+serialNo).css("display","none");
								
								$("#investigateOutlineSpan_"+serialNo).html("");
								$("#investigateDtlSpan_"+serialNo).html("");
								$("#print1_6_1ShowHideBtnId").css("display","none");
								
								$("#investigateOutlineSpan_"+serialNo).html(outLineTitle+"."+$("#investigateOutlineForEdite_"+serialNo).val());
								$("#investigateDtlSpan_"+serialNo).html($("#investigateDtlForEdite_"+serialNo).html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
			
		}
		
		/* Print1_6_1 삭제하기 */
		function print1_6_1Del(serialNo){
			if(confirm("삭제하시겠습니까?")){
				$.post("./delBody1_6_1Ok",
						{	
								serialNo	:serialNo
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("삭제 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$("#rptWriteFlag").val("yes");
									$(".Print1_6_1ListTr_"+serialNo).remove();
									location.href = "suimRptBscDtl?suim_rpt_no="+"${suimVO.suim_rpt_no}"+"&rptWriteFlag=yes";
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
					<b>6-나. 조사내용 
						<img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print1_6_1ShowHideBtnId" style="display:none; cursor:pointer; "  />
					</b>
				</p>
			</td>
			<td height="25" width="50%">
				<p align="right">
					<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id = "print1_6_1ShowAddAreaBtn" style="float:right; cursor:pointer; "  />
					<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody1_6_1ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
				</p>
			</td>
		</tr>
		<tr >
			<td colspan="2" align="center">
				<img src="./resources/ls_img/ls_body/1/06b.jpg" title="계약 사항 샘플 양식" id = "print1_6_1SampleImg" style="display:none; cursor:pointer; " onclick="print1_1ShowHide();" />
			</td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
		<tbody id = "Print1_6_1List">
			<c:forEach items="${suimRptBody1_6_1List }" var="suimRptBody1_6_1Vo">
				<tr class="Print1_6_1ListTr_${suimRptBody1_6_1Vo.serialNo}">
					<td bgcolor="#ECECEC" class="td" width="605" id = "investigateOutlineTd_${suimRptBody1_6_1Vo.serialNo}">
						<p>
							<span id = "investigateOutlineSpan_${suimRptBody1_6_1Vo.serialNo}"><b>나-${suimRptBody1_6_1Vo.ROWNUM}.${suimRptBody1_6_1Vo.investigateOutlineSpan}</b></span>
							<input type="text"  size="50" class="Print1_6_1ListInputClass" style='display:none;'  id="investigateOutlineForEdite_${suimRptBody1_6_1Vo.serialNo}" value = "${suimRptBody1_6_1Vo.investigateOutline}"/>
						</p>
					</td>
					<td align="center" bgcolor="#ECECEC" class="td" width="40" >
						비고
					</td>
				</tr>
				<tr class = "Print1_6_1ListTr_${suimRptBody1_6_1Vo.serialNo}">
					<td class="td"  id = "investigateDtlTd_${suimRptBody1_6_1Vo.serialNo}">
						<span id = "investigateDtlSpan_${suimRptBody1_6_1Vo.serialNo}">${suimRptBody1_6_1Vo.investigateDtlSpan}</span>
						<textarea class="Print1_6_1ListInputClass" style="width:99%;height:300px;overflow:visible; display:none;" id = "investigateDtlForEdite_${suimRptBody1_6_1Vo.serialNo}">${suimRptBody1_6_1Vo.investigateDtl}</textarea>
					</td>
					<td align="center" class="td">
						<img src='./resources/ls_img/btn_edit_s.gif' id = "editePrint1_6_1Btn_${suimRptBody1_6_1Vo.serialNo}" onclick="print1_6_1Edit('${suimRptBody1_6_1Vo.serialNo}');" style='cursor:pointer; '/>
						<img src='./resources/ls_img/btn_del_s.gif' id = "delPrint1_6_1Btn_${suimRptBody1_6_1Vo.serialNo}" onclick="print1_6_1Del('${suimRptBody1_6_1Vo.serialNo}');" style='cursor:pointer; '/>
						<img id = "editeBody1_6_1ContentsOkBtn_${suimRptBody1_6_1Vo.serialNo}" src="./resources/ls_img/btn_check_s.gif" title="수정 완료" style="display:none;cursor:pointer;" onclick="editePrint1_6_1Ok('${suimRptBody1_6_1Vo.serialNo}');" />
					</td>
				</tr>				
			</c:forEach>
		</tbody>
		<tr class= "print1_6_1InputTr" style="display:none;">
			<td bgcolor="#ECECEC" class="td" width="610">
				<p align="left"><b>나-.</b>
				<input type="text" size="50" id = "investigateOutline" value="○○병원(과거력 및 고지의무위반사항등)"/>
				</p>
			</td>
			<td align="center" bgcolor="#ECECEC" class="td"  width="40" >
				비고
			</td>
		</tr>
		<tr class= "print1_6_1InputTr" style="display:none;">
			<td  class="td">
				<textarea style="width:99%;height:300px;overflow:visible;" id = "investigateDtl">① 내원일자 : 
② 진단병명 : 
③ 입원기간 : 
④ 치료내용 : 
⑤ 검사결과 : 
⑥ 기타사항 : 
⑦ 기타사항 : 
⑧ 기타사항 : 
⑨ 기타사항 : 
⑩ 기타사항 :</textarea>
			</td>
			<td align="center" class="td"  width="40" >
				<img id = "addBody1_6_1ContentsOkBtn" src="./resources/ls_img/btn_check_s.gif" title="저장" style="cursor:pointer;" />	
			</td>
		</tr>					
	</table>
	<p>&nbsp;</p>
</body>