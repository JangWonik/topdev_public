<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>	
	<script>
		$(document).ready(function(){
			
			/* Print_17_13 추가 영역 보이기 */
			$("#print17_13ShowAddAreaBtn").click(function(){
				$("#print17_13InputTr").css("display","inline");
				$("#editeBody17_13ContentsCancelBtnId").css("display","inline");
				$("#print17_13ShowAddAreaBtn").css("display","none");
			});
			
			/* Print_17_13 추가 취소하기 */
			$("#editeBody17_13ContentsCancelBtnId").click(function(){
				$("#print17_13InputTr").css("display","none");
				$("#editeBody17_13ContentsCancelBtnId").css("display","none");
				$("#print17_13ShowAddAreaBtn").css("display","inline");
			});
			
			/* Print17_13 신규 입력 */
			$("#addBody17_13ContentsOkBtn").click(function(){
				$.post("./insBody17_13Ok",
						{	
							suimRptNo				:"${suimRptBody17_1356891112Vo.suimRptNo}"
							,questioningHospital  	:$("#questioningHospital").val()			//보험사
							,questioningBasis  		:$("#questioningBasis").val()		//담보내용
							,questioningVisit  		:$("#questioningVisit").val()		//보험기간
							,questioningEtc  		:$("#questioningEtc").val()		//청구내용 및 결과
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장을 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$("#print17_13InputTr").css("display","none");
									$("#editeBody17_13ContentsCancelBtnId").css("display","none");
									$("#print17_13ShowAddAreaBtn").css("display","inline");

									$("#print17_13List").append(
										"<tr id = 'print17_13ListTr_"+data+"'>"
										+	"<td align='center' class='td' >"
										+		"<span id = 'questioningHospitalForSpan_"+data+"'>"+$("#questioningHospital").val()+"</span>"
										+		"<input type='text' size='25' style='display:none;' id = 'questioningHospitalForEdite_"+data+"' value = '"+$("#questioningHospital").val()+"' />"
										+	"</td>"
										+	"<td class='td' >"
										+		"<span id = 'questioningBasisForSpan_"+data+"'>"+$("#questioningBasis").val()+"</span>"
										+		"<input type='text' size='10' style='display:none;' id = 'questioningBasisForEdite_"+data+"' value = '"+$("#questioningBasis").val()+"' />"
										+	"</td>"
										+	"<td class='td'>"
										+		"<span id = 'questioningVisitForSpan_"+data+"'>"+$("#questioningVisit").val()+"</span>"
										+		"<input type='text' size='22' style='display:none;' id = 'questioningVisitForEdite_"+data+"' value = '"+$("#questioningVisit").val()+"' />"
										+	"</td>"
										+	"<td class='td'>"
										+		"<span id = 'questioningEtcForSpan_"+data+"'>"+$("#questioningEtc").val()+"</span>"
										+		"<input type='text' size='13' style='display:none;' id = 'questioningEtcForEdite_"+data+"' value = '"+$("#questioningEtc").val()+"' />"
										+	"</td>"
										+	"<td class='td' align='center'>"
										+		"<img src='./resources/ls_img/btn_edit_s.gif' id = 'editePrint17_13Btn_"+data+"' onclick=\"print17_13Edit('"+data+"');\" style='cursor:pointer;'/>  "
										+		"<img src='./resources/ls_img/btn_del_s.gif' id = 'delPrint17_13Btn_"+data+"' onclick=\"print17_13Del('"+data+"');\" style='cursor:pointer;'/>"
										+		"<img id = 'editeBody17_13ContentsOkBtn_"+data+"' src='./resources/ls_img/btn_check_s.gif' title='수정 완료' style='display:none;cursor:pointer;' onclick=\"editePrint17_13Ok('"+data+"');\" />"
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
		
		/* Print17_13 수정하기 화면 동작*/
		function print17_13Edit(serialNo){
			$("#questioningHospitalForSpan_"+serialNo).css("display","none");
			$("#questioningBasisForSpan_"+serialNo).css("display","none");
			$("#questioningVisitForSpan_"+serialNo).css("display","none");
			$("#questioningEtcForSpan_"+serialNo).css("display","none");
			
			$("#editePrint17_13Btn_"+serialNo).css("display","none");
			$("#delPrint17_13Btn_"+serialNo).css("display","none");
			
			$("#questioningHospitalForEdite_"+serialNo).css("display","inline");
			$("#questioningBasisForEdite_"+serialNo).css("display","inline");
			$("#questioningVisitForEdite_"+serialNo).css("display","inline");
			$("#questioningEtcForEdite_"+serialNo).css("display","inline");
			
			$("#editeBody17_13ContentsOkBtn_"+serialNo).css("display","inline");
			
		}
		
		/* Print17_13 수정하기 Ok*/
		function editePrint17_13Ok(serialNo){
			$.post("./editeBody17_13Ok",
					{	
							serialNo				:serialNo
							,questioningHospital  	:$("#questioningHospitalForEdite_"+serialNo).val()	//탐문기관명
							,questioningBasis  		:$("#questioningBasisForEdite_"+serialNo).val()		//기준
							,questioningVisit  		:$("#questioningVisitForEdite_"+serialNo).val()		//방문여부
							,questioningEtc  		:$("#questioningEtcForEdite_"+serialNo).val()		//비고
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								
								$("#questioningHospitalForSpan_"+serialNo).css("display","inline");
								$("#questioningBasisForSpan_"+serialNo).css("display","inline");
								$("#questioningVisitForSpan_"+serialNo).css("display","inline");
								$("#questioningEtcForSpan_"+serialNo).css("display","inline");
								
								$("#editePrint17_13Btn_"+serialNo).css("display","inline");
								$("#delPrint17_13Btn_"+serialNo).css("display","inline");
								
								$("#questioningHospitalForEdite_"+serialNo).css("display","none");
								$("#questioningBasisForEdite_"+serialNo).css("display","none");
								$("#questioningVisitForEdite_"+serialNo).css("display","none");
								$("#questioningEtcForEdite_"+serialNo).css("display","none");
								
								$("#editeBody17_13ContentsOkBtn_"+serialNo).css("display","none");
								
								$("#questioningHospitalForSpan_"+serialNo).html("");
								$("#questioningBasisForSpan_"+serialNo).html("");
								$("#questioningVisitForSpan_"+serialNo).html("");
								$("#questioningEtcForSpan_"+serialNo).html("");
								
								$("#questioningHospitalForSpan_"+serialNo).html($("#questioningHospitalForEdite_"+serialNo).val());
								$("#questioningBasisForSpan_"+serialNo).html($("#questioningBasisForEdite_"+serialNo).val());
								$("#questioningVisitForSpan_"+serialNo).html($("#questioningVisitForEdite_"+serialNo).val());
								$("#questioningEtcForSpan_"+serialNo).html($("#questioningEtcForEdite_"+serialNo).val());
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
			
		}
		
		/* Print17_13 삭제하기 */
		function print17_13Del(serialNo){
			if(confirm("삭제하시겠습니까?")){
				$.post("./delBody17_13Ok",
						{	
								serialNo	:serialNo
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("삭제 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									
									$("#print17_13ListTr_"+serialNo).remove();
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
				<p  class="p2"><b>13. 탐문내역</b></p>
			</td>
			<td height="25" width="50%">
				<p align="right">
					<c:if test="${suimVO.suimRptState eq 0}">
						<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id = "print17_13ShowAddAreaBtn" style="float:right; cursor:pointer; "  />
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody17_13ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
					</c:if>
				</p>
			</td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0"  align="center" width="600">
		<tr>
			<td bgcolor="#ECECEC" class="td" width="180">
				<p align="center"><b>탐문기관명</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="80">
				<p align="center"><b>기준</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="150">
				<p align="center"><b>방문여부</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="95">
				<p align="center"><b>비고</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="50">
				<p align="center"><b>-</b></p>
			</td>
		</tr>
		
		<tbody id = "print17_13List">
			<c:forEach items="${suimRptBody17_13List }" var="suimRptBody17_13Vo">
				<tr id = "print17_13ListTr_${suimRptBody17_13Vo.serialNo}">
					<td align="center" class="td">
						<span id = "questioningHospitalForSpan_${suimRptBody17_13Vo.serialNo}">${suimRptBody17_13Vo.questioningHospital}</span>
						<input type="text" size="25" style="display:none;" id = "questioningHospitalForEdite_${suimRptBody17_13Vo.serialNo}" value = "${suimRptBody17_13Vo.questioningHospital}" />
					</td>
					<td class="td" >
						<span id = "questioningBasisForSpan_${suimRptBody17_13Vo.serialNo}">${suimRptBody17_13Vo.questioningBasis}</span>
						<input type="text" size="10" style="display:none;" id = "questioningBasisForEdite_${suimRptBody17_13Vo.serialNo}" value = "${suimRptBody17_13Vo.questioningBasis}" />
					</td>
					<td class="td">
						<span id = "questioningVisitForSpan_${suimRptBody17_13Vo.serialNo}">${suimRptBody17_13Vo.questioningVisit}</span>
						<input type="text" size="22" style="display:none;" id = "questioningVisitForEdite_${suimRptBody17_13Vo.serialNo}" value = "${suimRptBody17_13Vo.questioningVisit}" />
					</td>
					<td class="td">
						<span id = "questioningEtcForSpan_${suimRptBody17_13Vo.serialNo}">${suimRptBody17_13Vo.questioningEtc}</span>
						<input type="text" size="13" style="display:none;" id = "questioningEtcForEdite_${suimRptBody17_13Vo.serialNo}" value = "${suimRptBody17_13Vo.questioningEtc}" />
					</td>
					<td class="td" align="center">
						<c:if test="${suimVO.suimRptState eq 0}">
							<img src='./resources/ls_img/btn_edit_s.gif' id = "editePrint17_13Btn_${suimRptBody17_13Vo.serialNo}" onclick="print17_13Edit('${suimRptBody17_13Vo.serialNo}');" style='cursor:pointer;'/>
							<img src='./resources/ls_img/btn_del_s.gif' id = "delPrint17_13Btn_${suimRptBody17_13Vo.serialNo}" onclick="print17_13Del('${suimRptBody17_13Vo.serialNo}');" style='cursor:pointer;'/>
							<img id = "editeBody17_13ContentsOkBtn_${suimRptBody17_13Vo.serialNo}" src="./resources/ls_img/btn_check_s.gif" title="수정 완료" style="display:none;cursor:pointer;" onclick="editePrint17_13Ok('${suimRptBody17_13Vo.serialNo}');" />
						</c:if>
					</td>
				</tr>					
			</c:forEach>
		</tbody>
		<tr id = "print17_13InputTr" style="display:none;">
			<td align="center" class="td">
				<input type="text" size="25" id = "questioningHospital"/>
			</td >
			<td class="td">
				<input type="text" size="10" id = "questioningBasis"/>
			</td>
			<td class="td">
				<input type="text" size="22" id = "questioningVisit"/>
			</td>
			<td class="td">
				<input type="text" size="13" id = "questioningEtc"/>
			</td>
			<td class="td" align="center">
				<img id = "addBody17_13ContentsOkBtn" src="./resources/ls_img/btn_check_s.gif" title="탐문내역 추가" style="cursor:pointer;" />
			</td>
		</tr>
	</table>
	<p>&nbsp;</p>
</body>