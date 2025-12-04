<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>	
	<script>
		$(document).ready(function(){
			
			/* Print_17_4 추가 영역 보이기 */
			$("#print17_4ShowAddAreaBtn").click(function(){
				$("#print17_4InputTr").css("display","inline");
				$("#editeBody17_4ContentsCancelBtnId").css("display","inline");
				$("#print17_4ShowAddAreaBtn").css("display","none");
			});
			
			/* Print_17_4 추가 취소하기 */
			$("#editeBody17_4ContentsCancelBtnId").click(function(){
				$("#print17_4InputTr").css("display","none");
				$("#editeBody17_4ContentsCancelBtnId").css("display","none");
				$("#print17_4ShowAddAreaBtn").css("display","inline");
			});
			
			/* Print17_4 신규 입력 */
			$("#addBody17_4ContentsOkBtn").click(function(){
				$.post("./insBody17_4Ok",
						{	
							suimRptNo			:"${suimRptBody17_1356891112Vo.suimRptNo}"
							,otherInsuCom  		:$("#otherInsuCom").val()			//보험사
							,otherInsuJoinDate  :$("#otherInsuJoinDate").val()		//담보내용
							,otherInsuJoinAmt  	:$("#otherInsuJoinAmt").val()		//보험기간
							,otherInsuPremium  	:$("#otherInsuPremium").val()		//청구내용 및 결과
							,otherInsuAgent  	:$("#otherInsuAgent").val()			//청구내용 및 결과
							
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장을 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$("#print17_4InputTr").css("display","none");
									$("#editeBody17_4ContentsCancelBtnId").css("display","none");
									$("#print17_4ShowAddAreaBtn").css("display","inline");

									$("#print17_4List").append(
										"<tr id = 'print17_4ListTr_"+data+"'>"
										+	"<td align='center' class='td' id = 'otherInsuComTd_"+data+"'>"
										+		"<span id = 'otherInsuComForSpan_"+data+"'>"+$("#otherInsuCom").val()+"</span>"
										+		"<input type='text' size='15' style='display:none;' id = 'otherInsuComForEdite_"+data+"' value = '"+$("#otherInsuCom").val()+"' />"
										+	"</td>"
										+	"<td class='td' id = 'otherInsuJoinDateTd_"+data+"'>"
										+		"<span id = 'otherInsuJoinDateForSpan_"+data+"'>"+$("#otherInsuJoinDate").val()+"</span>"
										+		"<input type='text' size='15' style='display:none;' id = 'otherInsuJoinDateForEdite_"+data+"' value = '"+$("#otherInsuJoinDate").val()+"' />"
										+	"</td>"
										+	"<td class='td'>"
										+		"<span id = 'otherInsuJoinAmtForSpan_"+data+"'>"+$("#otherInsuJoinAmt").val()+"</span>"
										+		"<input type='text' size='15' style='display:none;' id = 'otherInsuJoinAmtForEdite_"+data+"' value = '"+$("#otherInsuJoinAmt").val()+"' />"
										+	"</td>"
										+	"<td class='td'>"
										+		"<span id = 'otherInsuPremiumForSpan_"+data+"'>"+$("#otherInsuPremium").val()+"</span>"
										+		"<input type='text' size='18' style='display:none;' id = 'otherInsuPremiumForEdite_"+data+"' value = '"+$("#otherInsuPremium").val()+"' />"
										+	"</td>"
										+	"<td class='td'>"
										+		"<span id = 'otherInsuAgentForSpan_"+data+"'>"+$("#otherInsuAgent").val()+"</span>"
										+		"<input type='text' size='7' style='display:none;' id = 'otherInsuAgentForEdite_"+data+"' value = '"+$("#otherInsuAgent").val()+"' />"
										+	"</td>"
										+	"<td class='td' align='center'>"
										+		"<img src='./resources/ls_img/btn_edit_s.gif' id = 'editePrint17_4Btn_"+data+"' onclick=\"print17_4Edit('"+data+"');\" style='cursor:pointer;'/>  "
										+		"<img src='./resources/ls_img/btn_del_s.gif' id = 'delPrint17_4Btn_"+data+"' onclick=\"print17_4Del('"+data+"');\" style='cursor:pointer;'/>"
										+		"<img id = 'editeBody17_4ContentsOkBtn_"+data+"' src='./resources/ls_img/btn_check_s.gif' title='수정 완료' style='display:none;cursor:pointer;' onclick=\"editePrint17_4Ok('"+data+"');\" />"
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
		
		/* Print17_4 수정하기 화면 동작*/
		function print17_4Edit(serialNo){
			$("#otherInsuComForSpan_"+serialNo).css("display","none");
			$("#otherInsuJoinDateForSpan_"+serialNo).css("display","none");
			$("#otherInsuJoinAmtForSpan_"+serialNo).css("display","none");
			$("#otherInsuPremiumForSpan_"+serialNo).css("display","none");
			$("#otherInsuAgentForSpan_"+serialNo).css("display","none");
			
			$("#editePrint17_4Btn_"+serialNo).css("display","none");
			$("#delPrint17_4Btn_"+serialNo).css("display","none");
			
			$("#otherInsuComForEdite_"+serialNo).css("display","inline");
			$("#otherInsuJoinDateForEdite_"+serialNo).css("display","inline");
			$("#otherInsuJoinAmtForEdite_"+serialNo).css("display","inline");
			$("#otherInsuPremiumForEdite_"+serialNo).css("display","inline");
			$("#otherInsuAgentForEdite_"+serialNo).css("display","inline");
			
			$("#editeBody17_4ContentsOkBtn_"+serialNo).css("display","inline");
			
		}
		
		/* Print17_4 수정하기 Ok*/
		function editePrint17_4Ok(serialNo){
			$.post("./editeBody17_4Ok",
					{	
							serialNo			:serialNo
							,otherInsuCom  		:$("#otherInsuComForEdite_"+serialNo).val()			//보험사
							,otherInsuJoinDate  :$("#otherInsuJoinDateForEdite_"+serialNo).val()		//담보내용
							,otherInsuJoinAmt  	:$("#otherInsuJoinAmtForEdite_"+serialNo).val()		//보험기간
							,otherInsuPremium  	:$("#otherInsuPremiumForEdite_"+serialNo).val()		//청구내용 및 결과
							,otherInsuAgent  	:$("#otherInsuAgentForEdite_"+serialNo).val()		//청구내용 및 결과
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								
								$("#otherInsuComForSpan_"+serialNo).css("display","inline");
								$("#otherInsuJoinDateForSpan_"+serialNo).css("display","inline");
								$("#otherInsuJoinAmtForSpan_"+serialNo).css("display","inline");
								$("#otherInsuPremiumForSpan_"+serialNo).css("display","inline");
								$("#otherInsuAgentForSpan_"+serialNo).css("display","inline");
								
								$("#editePrint17_4Btn_"+serialNo).css("display","inline");
								$("#delPrint17_4Btn_"+serialNo).css("display","inline");
								
								$("#otherInsuComForEdite_"+serialNo).css("display","none");
								$("#otherInsuJoinDateForEdite_"+serialNo).css("display","none");
								$("#otherInsuJoinAmtForEdite_"+serialNo).css("display","none");
								$("#otherInsuPremiumForEdite_"+serialNo).css("display","none");
								$("#otherInsuAgentForEdite_"+serialNo).css("display","none");
								
								$("#editeBody17_4ContentsOkBtn_"+serialNo).css("display","none");
								
								$("#otherInsuComForSpan_"+serialNo).html("");
								$("#otherInsuJoinDateForSpan_"+serialNo).html("");
								$("#otherInsuJoinAmtForSpan_"+serialNo).html("");
								$("#otherInsuPremiumForSpan_"+serialNo).html("");
								$("#otherInsuAgentForSpan_"+serialNo).html("");
								
								$("#otherInsuComForSpan_"+serialNo).html($("#otherInsuComForEdite_"+serialNo).val());
								$("#otherInsuJoinDateForSpan_"+serialNo).html($("#otherInsuJoinDateForEdite_"+serialNo).val());
								$("#otherInsuJoinAmtForSpan_"+serialNo).html($("#otherInsuJoinAmtForEdite_"+serialNo).val());
								$("#otherInsuPremiumForSpan_"+serialNo).html($("#otherInsuPremiumForEdite_"+serialNo).val());
								$("#otherInsuAgentForSpan_"+serialNo).html($("#otherInsuAgentForEdite_"+serialNo).val());
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
			
		}
		
		/* Print17_4 삭제하기 */
		function print17_4Del(serialNo){
			if(confirm("삭제하시겠습니까?")){
				$.post("./delBody17_4Ok",
						{	
								serialNo	:serialNo
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("삭제 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									
									$("#print17_4ListTr_"+serialNo).remove();
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
				<p  class="p2"><b>4. 타 보험 가입내역</b></p>
			</td>
			<td height="25" width="50%">
				<p align="right">
					<c:if test="${suimVO.suimRptState eq 0}">
						<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id = "print17_4ShowAddAreaBtn" style="float:right; cursor:pointer; "  />
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody17_4ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
					</c:if>
				</p>
			</td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0"  align="center" width="600">
		<tr>
			<td bgcolor="#ECECEC" class="td" width="120">
				<p align="center"><b>보험사명</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="120">
				<p align="center"><b>가입일시</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="120">
				<p align="center"><b>가입금액</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="145">
				<p align="center"><b>보험료</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="60">
				<p align="center"><b>모집인</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="50">
				<p align="center"><b>비고</b></p>
			</td>
		</tr>
		
		<tbody id = "print17_4List">
			<c:forEach items="${suimRptBody17_4List }" var="suimRptBody17_4Vo">
				<tr id = "print17_4ListTr_${suimRptBody17_4Vo.serialNo}">
					<td align="center" class="td" id = "otherInsuComTd_${suimRptBody17_4Vo.serialNo}">
						<span id = "otherInsuComForSpan_${suimRptBody17_4Vo.serialNo}">${suimRptBody17_4Vo.otherInsuCom}</span>
						<input type="text" size="15" style="display:none;" id = "otherInsuComForEdite_${suimRptBody17_4Vo.serialNo}" value = "${suimRptBody17_4Vo.otherInsuCom}" />
					</td>
					<td class="td" id = "otherInsuJoinDateTd_${suimRptBody17_4Vo.serialNo}">
						<span id = "otherInsuJoinDateForSpan_${suimRptBody17_4Vo.serialNo}">${suimRptBody17_4Vo.otherInsuJoinDate}</span>
						<input type="text" size="15" style="display:none;" id = "otherInsuJoinDateForEdite_${suimRptBody17_4Vo.serialNo}" value = "${suimRptBody17_4Vo.otherInsuJoinDate}" />
					</td>
					<td class="td">
						<span id = "otherInsuJoinAmtForSpan_${suimRptBody17_4Vo.serialNo}">${suimRptBody17_4Vo.otherInsuJoinAmt}</span>
						<input type="text" size="15" style="display:none;" id = "otherInsuJoinAmtForEdite_${suimRptBody17_4Vo.serialNo}" value = "${suimRptBody17_4Vo.otherInsuJoinAmt}" />
					</td>
					<td class="td">
						<span id = "otherInsuPremiumForSpan_${suimRptBody17_4Vo.serialNo}">${suimRptBody17_4Vo.otherInsuPremium}</span>
						<input type="text" size="18" style="display:none;" id = "otherInsuPremiumForEdite_${suimRptBody17_4Vo.serialNo}" value = "${suimRptBody17_4Vo.otherInsuPremium}" />
					</td>
					<td class="td">
						<span id = "otherInsuAgentForSpan_${suimRptBody17_4Vo.serialNo}">${suimRptBody17_4Vo.otherInsuAgent}</span>
						<input type="text" size="7" style="display:none;" id = "otherInsuAgentForEdite_${suimRptBody17_4Vo.serialNo}" value = "${suimRptBody17_4Vo.otherInsuAgent}" />
					</td>
					<td class="td" align="center">
						<c:if test="${suimVO.suimRptState eq 0}">
							<img src='./resources/ls_img/btn_edit_s.gif' id = "editePrint17_4Btn_${suimRptBody17_4Vo.serialNo}" onclick="print17_4Edit('${suimRptBody17_4Vo.serialNo}');" style='cursor:pointer;'/>
							<img src='./resources/ls_img/btn_del_s.gif' id = "delPrint17_4Btn_${suimRptBody17_4Vo.serialNo}" onclick="print17_4Del('${suimRptBody17_4Vo.serialNo}');" style='cursor:pointer;'/>
							<img id = "editeBody17_4ContentsOkBtn_${suimRptBody17_4Vo.serialNo}" src="./resources/ls_img/btn_check_s.gif" title="수정 완료" style="display:none;cursor:pointer;" onclick="editePrint17_4Ok('${suimRptBody17_4Vo.serialNo}');" />
						</c:if>
					</td>
				</tr>					
			</c:forEach>
		</tbody>
		<tr id = "print17_4InputTr" style="display:none;">
			<td align="center" class="td">
				<input type="text" size="15" id = "otherInsuCom"/>
			</td >
			<td class="td">
				<input type="text" size="15" id = "otherInsuJoinDate"/>
			</td>
			<td class="td">
				<input type="text" size="15" id = "otherInsuJoinAmt"/>
			</td>
			<td class="td">
				<input type="text" size="18" id = "otherInsuPremium"/>
			</td>
			<td class="td">
				<input type="text" size="7" id = "otherInsuAgent"/>
			</td>
			<td class="td" align="center">
				<img id = "addBody17_4ContentsOkBtn" src="./resources/ls_img/btn_check_s.gif" title="타사 가입사항 추가" style="cursor:pointer;" />
			</td>
		</tr>
	</table>
	<p>&nbsp;</p>
</body>