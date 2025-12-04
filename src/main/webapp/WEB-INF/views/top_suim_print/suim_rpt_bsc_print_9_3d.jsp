<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>	
	<script>
		$(document).ready(function(){
			
			/* Print_9_3d 추가 영역 보이기 */
			$("#print9_3dShowAddAreaBtn").click(function(){
				$("#print9_3dInputTr").css("display","inline");
				$("#editeBody9_3dContentsCancelBtnId").css("display","inline");
				$("#print9_3dShowAddAreaBtn").css("display","none");
				
			});
			
			/* Print_9_3d 추가 취소하기 */
			$("#editeBody9_3dContentsCancelBtnId").click(function(){
				$("#print9_3dInputTr").css("display","none");
				$("#editeBody9_3dContentsCancelBtnId").css("display","none");
				$("#print9_3dShowAddAreaBtn").css("display","inline");
			});

			/* Print_9_3d 신규 입력 */
			$("#addBody9_3dContentsOkBtn").click(function(){
				$.post("./insBody9_3dOk",
						{	
							 rptPrintNo			:"${suimRptBody9_13467Vo.rptPrintNo}"
							,investigateOutline	:$("#investigateOutline").val()							//개요
							,investigateDtl  	:$("#investigateDtl").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//상세
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장을 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$("#print9_3dInputTr").css("display","none");
									$("#editeBody9_3dContentsCancelBtnId").css("display","none");
									$("#print9_3dShowAddAreaBtn").css("display","inline");
									
									$("#print9_3dList").append(
										"<tr id = 'print9_3dListTr_"+data+"'>"
										+	"<td align='left' class='td' id = 'investigateOutlineTd_"+data+"' >"
										+		"■ <input type='text' size='10' style='display:none;' class='print9_3dListInputClass' id = 'investigateOutlineForEdite_"+data+"' value='"+$("#investigateOutline").val()+"' />" 
										+		"<span id = 'investigateOutlineSpan_"+data+"'>"+$("#investigateOutline").val()+"</span><br />"
										+		"<span id = 'investigateDtlSpan_"+data+"'>"+$("#investigateDtl").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
										+		"<textarea  class='print9_3dListInputClass' style='width:99%;height:255px;overflow:visible; display:none;' id = 'investigateDtlForEdite_"+data+"'>"+$("#investigateDtl").val()+"</textarea>"
										+	"</td>"
										+	"<td align='center' class='td'>"
										+		"<img src='./resources/ls_img/btn_edit_s.gif' id = 'editePrint9_3dBtn_"+data+"' onclick=\"print9_3dEdit('"+data+"');\" style='cursor:pointer;'/>"
										+		"<img src='./resources/ls_img/btn_del_s.gif' id = 'delPrint9_3dBtn_"+data+"' onclick=\"print9_3dDel('"+data+"');\" style='cursor:pointer;'/>"
										+		"<img id = 'editeBody9_3dContentsOkBtn_"+data+"' src='./resources/ls_img/btn_check_s.gif' title='수정 완료' style='display:none;cursor:pointer;' onclick=\"editePrint9_3dOk('"+data+"');\" />"
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
		
		/* Print9_3d 수정하기 화면 동작*/
		function print9_3dEdit(serialNo){
			$("#investigateOutlineSpan_"+serialNo).css("display","none");
			$("#investigateDtlSpan_"+serialNo).css("display","none");

			$("#editePrint9_3dBtn_"+serialNo).css("display","none");
			$("#delPrint9_3dBtn_"+serialNo).css("display","none");
			
			$("#investigateOutlineForEdite_"+serialNo).css("display","inline");
			$("#investigateDtlForEdite_"+serialNo).css("display","inline");
			
			$("#editeBody9_3dContentsOkBtn_"+serialNo).css("display","inline");
			
		}
		
		/* Print9_3d 수정하기 Ok*/
		function editePrint9_3dOk(serialNo){
			$.post("./editeBody9_3dOk",
					{	
							serialNo			:serialNo
							,investigateOutline :$("#investigateOutlineForEdite_"+serialNo).val()							//개요
							,investigateDtl  	:$("#investigateDtlForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//상세
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{

								$("#investigateOutlineSpan_"+serialNo).css("display","inline");
								$("#investigateDtlSpan_"+serialNo).css("display","inline");
								
								$("#editePrint9_3dBtn_"+serialNo).css("display","inline");
								$("#delPrint9_3dBtn_"+serialNo).css("display","inline");
								
								$("#investigateOutlineForEdite_"+serialNo).css("display","none");
								$("#investigateDtlForEdite_"+serialNo).css("display","none");
								
								$("#editeBody9_3dContentsOkBtn_"+serialNo).css("display","none");
								
								$("#investigateOutlineSpan_"+serialNo).html("");
								$("#investigateDtlSpan_"+serialNo).html("");
								
								$("#investigateOutlineSpan_"+serialNo).html($("#investigateOutlineForEdite_"+serialNo).val());
								$("#investigateDtlSpan_"+serialNo).html($("#investigateDtlForEdite_"+serialNo).html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
			
		}
		
		/* Print9_3d 삭제하기 */
		function print9_3dDel(serialNo){
			if(confirm("삭제하시겠습니까?")){
				$.post("./delBody9_3dOk",
						{	
								serialNo	:serialNo
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("삭제 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									
									$("#print9_3dListTr_"+serialNo).remove();
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
					<b>4. 청구관련 조사내용(상세) 
						<!-- <img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print9_3aShowHideBtnId" style="display:none; cursor:pointer; "  /> -->
					</b>
				</p>
			</td>
			<td height="25" width="20%">
				<p align="right">
					<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id = "print9_3dShowAddAreaBtn" style="float:right; cursor:pointer; "  />
					<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody9_3dContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
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
			<td bgcolor="#ECECEC" class="td" width="550">
				<p align="left"><b>▶ 피보험자 조사내용</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="40">
				<p align="center"><b>비고</b></p>
			</td>
		</tr>
		
		<tbody id = "print9_3dList">
			<c:forEach items="${SuimRptBody9_3dList }" var="suimRptBody9_3dVo">
				<tr id = "print9_3dListTr_${suimRptBody9_3dVo.serialNo}">
					<td align="left" class="td" id = "investigateOutlineTd_${suimRptBody9_3dVo.serialNo}" >
						■ <input type="text" size="10" style="display:none;" class="print9_3dListInputClass" id = "investigateOutlineForEdite_${suimRptBody9_3dVo.serialNo}" value="${suimRptBody9_3dVo.investigateOutline }" /> 
						<span id = "investigateOutlineSpan_${suimRptBody9_3dVo.serialNo}">${suimRptBody9_3dVo.investigateOutline}</span><br />
						<span id = "investigateDtlSpan_${suimRptBody9_3dVo.serialNo}">${suimRptBody9_3dVo.investigateDtlSpan}</span>
						<textarea  class="print9_3dListInputClass" style="width:99%;height:255px;overflow:visible; display:none;" id = "investigateDtlForEdite_${suimRptBody9_3dVo.serialNo}">${suimRptBody9_3dVo.investigateDtl}</textarea>
					</td>
					<td align="center" class="td">
						<img src='./resources/ls_img/btn_edit_s.gif' id = "editePrint9_3dBtn_${suimRptBody9_3dVo.serialNo}" onclick="print9_3dEdit('${suimRptBody9_3dVo.serialNo}');" style='cursor:pointer;'/>
						<img src='./resources/ls_img/btn_del_s.gif' id = "delPrint9_3dBtn_${suimRptBody9_3dVo.serialNo}" onclick="print9_3dDel('${suimRptBody9_3dVo.serialNo}');" style='cursor:pointer;'/>
						<img id = "editeBody9_3dContentsOkBtn_${suimRptBody9_3dVo.serialNo}" src="./resources/ls_img/btn_check_s.gif" title="수정 완료" style="display:none;cursor:pointer;" onclick="editePrint9_3dOk('${suimRptBody9_3dVo.serialNo}');" />
					</td>
				</tr>					
			</c:forEach>
		</tbody>
		<tr id = "print9_3dInputTr" style="display:none;">
			<td align="left" class="td">
				■ <input type="text" size="50" id = "investigateOutline" value="○○병원(청구병원)" style="margin-bottom:10px;"/>
				<textarea style="width:99%;height:155px;overflow:visible;" id = "investigateDtl">   ① 내원일자 : 
   ② 진단병명 : 
   ③ 통원기간 : 
   ④ 입원기간 : 
   ⑤ 검사내용 : 
   ⑥ 투약내용 : </textarea>
			</td >
			<!-- <td class="td">
			</td> -->
			<td class="td" align="center">
				<img id = "addBody9_3dContentsOkBtn" src="./resources/ls_img/btn_check_s.gif" title="피보험자 조사내용 추가" style="cursor:pointer;" />
			</td>
		</tr>
	</table>
	<p>&nbsp;</p>
</body>