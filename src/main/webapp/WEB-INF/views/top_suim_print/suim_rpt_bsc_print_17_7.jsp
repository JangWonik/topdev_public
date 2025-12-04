<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>	
	<script>
		$(document).ready(function(){
			
			/* Print_17_7 추가 영역 보이기 */
			$("#print17_7ShowAddAreaBtn").click(function(){
				$("#print17_7InputTr").css("display","inline");
				$("#editeBody17_7ContentsCancelBtnId").css("display","inline");
				$("#print17_7ShowAddAreaBtn").css("display","none");
			});
			
			/* Print_17_7 추가 취소하기 */
			$("#editeBody17_7ContentsCancelBtnId").click(function(){
				$("#print17_7InputTr").css("display","none");
				$("#editeBody17_7ContentsCancelBtnId").css("display","none");
				$("#print17_7ShowAddAreaBtn").css("display","inline");
			});
			
			/* Print17_7 신규 입력 */
			$("#addBody17_7ContentsOkBtn").click(function(){
				$.post("./insBody17_7Ok",
						{	
							suimRptNo					:"${suimRptBody17_1356891112Vo.suimRptNo}"
							,medicalHistoryPeriod  		:$("#medicalHistoryPeriod").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')			//치료기간
							,medicalHistoryHospital  	:$("#medicalHistoryHospital").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//병원명
							,medicalHistoryDiagnosis  	:$("#medicalHistoryDiagnosis").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//진단명
							,medicalHistoryTest  		:$("#medicalHistoryTest").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//검사명
							,medicalHistoryMedicine  	:$("#medicalHistoryMedicine").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')			//투약일수
							
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장을 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$("#print17_7InputTr").css("display","none");
									$("#editeBody17_7ContentsCancelBtnId").css("display","none");
									$("#print17_7ShowAddAreaBtn").css("display","inline");

									$("#print17_7List").append(
										"<tr id = 'print17_7ListTr_"+data+"'>" 
										+	"<td align='center' class='td' >"
										+		"<span class='medicalSpanClass' id = 'medicalHistoryPeriodForSpan_"+data+"'>"+$("#medicalHistoryPeriod").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
										+		"<textarea style='display:none;' class='medicalInputClass' rows='3' cols='17' id = 'medicalHistoryPeriodForEdite_"+data+"' >"+$("#medicalHistoryPeriod").val()+"</textarea>"
										+	"</td>"
										+	"<td class='td' >"
										+		"<span class='medicalSpanClass' id = 'medicalHistoryHospitalForSpan_"+data+"'>"+$("#medicalHistoryHospital").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
										+		"<textarea style='display:none;' class='medicalInputClass' rows='3' cols='14' id = 'medicalHistoryHospitalForEdite_"+data+"' >"+$("#medicalHistoryHospital").val()+"</textarea>"
										+	"</td>"
										+	"<td class='td'>"
										+		"<span class='medicalSpanClass' id = 'medicalHistoryDiagnosisForSpan_"+data+"'>"+$("#medicalHistoryDiagnosis").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
										+		"<textarea style='display:none;' class='medicalInputClass' rows='3' cols='14' id = 'medicalHistoryDiagnosisForEdite_"+data+"' >"+$("#medicalHistoryDiagnosis").val()+"</textarea>"
										+	"</td>"
										+	"<td class='td'>"
										+		"<span class='medicalSpanClass'id = 'medicalHistoryTestForSpan_"+data+"'>"+$("#medicalHistoryTest").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
										+		"<textarea style='display:none;' class='medicalInputClass' rows='3' cols='14' id = 'medicalHistoryTestForEdite_"+data+"' >"+$("#medicalHistoryTest").val()+"</textarea>"
										+	"</td>"
										+	"<td class='td'>"
										+		"<span class='medicalSpanClass' id = 'medicalHistoryMedicineForSpan_"+data+"'>"+$("#medicalHistoryMedicine").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
										+		"<textarea style='display:none;' class='medicalInputClass' rows='3' cols='14' id = 'medicalHistoryMedicineForEdite_"+data+"' >"+$("#medicalHistoryMedicine").val()+"</textarea>"
										+	"</td>"
										+	"<td class='td' align='center'>"
										+		"<img src='./resources/ls_img/btn_edit_s.gif' id = 'editePrint17_7Btn_"+data+"' onclick=\"print17_7Edit('"+data+"');\" style='cursor:pointer;'/>  "
										+		"<img src='./resources/ls_img/btn_del_s.gif' id = 'delPrint17_7Btn_"+data+"' onclick=\"print17_7Del('"+data+"');\" style='cursor:pointer;'/>"
										+		"<img id = 'editeBody17_7ContentsOkBtn_"+data+"' src='./resources/ls_img/btn_check_s.gif' title='수정 완료' style='display:none;cursor:pointer;' onclick=\"editePrint17_7Ok('"+data+"');\" />"
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
		
		/* Print17_7 수정하기 화면 동작*/
		function print17_7Edit(serialNo){
			$("#medicalHistoryPeriodForSpan_"+serialNo).css("display","none");
			$("#medicalHistoryHospitalForSpan_"+serialNo).css("display","none");
			$("#medicalHistoryDiagnosisForSpan_"+serialNo).css("display","none");
			$("#medicalHistoryTestForSpan_"+serialNo).css("display","none");
			$("#medicalHistoryMedicineForSpan_"+serialNo).css("display","none");
			
			$("#editePrint17_7Btn_"+serialNo).css("display","none");
			$("#delPrint17_7Btn_"+serialNo).css("display","none");
			
			$("#medicalHistoryPeriodForEdite_"+serialNo).css("display","inline");
			$("#medicalHistoryHospitalForEdite_"+serialNo).css("display","inline");
			$("#medicalHistoryDiagnosisForEdite_"+serialNo).css("display","inline");
			$("#medicalHistoryTestForEdite_"+serialNo).css("display","inline");
			$("#medicalHistoryMedicineForEdite_"+serialNo).css("display","inline");
			
			$("#editeBody17_7ContentsOkBtn_"+serialNo).css("display","inline");
			
		}
		
		/* Print17_7 수정하기 Ok*/
		function editePrint17_7Ok(serialNo){
			$.post("./editeBody17_7Ok",
					{	
							serialNo					:serialNo
							,medicalHistoryPeriod  		:$("#medicalHistoryPeriodForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')			//치료기간
							,medicalHistoryHospital  	:$("#medicalHistoryHospitalForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//병원명
							,medicalHistoryDiagnosis  	:$("#medicalHistoryDiagnosisForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//진단명
							,medicalHistoryTest  		:$("#medicalHistoryTestForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//검사명
							,medicalHistoryMedicine  	:$("#medicalHistoryMedicineForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//투약일수
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								
								$("#medicalHistoryPeriodForSpan_"+serialNo).css("display","inline");
								$("#medicalHistoryHospitalForSpan_"+serialNo).css("display","inline");
								$("#medicalHistoryDiagnosisForSpan_"+serialNo).css("display","inline");
								$("#medicalHistoryTestForSpan_"+serialNo).css("display","inline");
								$("#medicalHistoryMedicineForSpan_"+serialNo).css("display","inline");
								
								$("#editePrint17_7Btn_"+serialNo).css("display","inline");
								$("#delPrint17_7Btn_"+serialNo).css("display","inline");
								
								$("#medicalHistoryPeriodForEdite_"+serialNo).css("display","none");
								$("#medicalHistoryHospitalForEdite_"+serialNo).css("display","none");
								$("#medicalHistoryDiagnosisForEdite_"+serialNo).css("display","none");
								$("#medicalHistoryTestForEdite_"+serialNo).css("display","none");
								$("#medicalHistoryMedicineForEdite_"+serialNo).css("display","none");
								
								$("#editeBody17_7ContentsOkBtn_"+serialNo).css("display","none");
								
								$("#medicalHistoryPeriodForSpan_"+serialNo).html("");
								$("#medicalHistoryHospitalForSpan_"+serialNo).html("");
								$("#medicalHistoryDiagnosisForSpan_"+serialNo).html("");
								$("#medicalHistoryTestForSpan_"+serialNo).html("");
								$("#medicalHistoryMedicineForSpan_"+serialNo).html("");
								
								$("#medicalHistoryPeriodForSpan_"+serialNo).html($("#medicalHistoryPeriodForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								$("#medicalHistoryHospitalForSpan_"+serialNo).html($("#medicalHistoryHospitalForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								$("#medicalHistoryDiagnosisForSpan_"+serialNo).html($("#medicalHistoryDiagnosisForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								$("#medicalHistoryTestForSpan_"+serialNo).html($("#medicalHistoryTestForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								$("#medicalHistoryMedicineForSpan_"+serialNo).html($("#medicalHistoryMedicineForEdite_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
			
		}
		
		/* Print17_7 삭제하기 */
		function print17_7Del(serialNo){
			if(confirm("삭제하시겠습니까?")){
				$.post("./delBody17_7Ok",
						{	
								serialNo	:serialNo
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("삭제 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									
									$("#print17_7ListTr_"+serialNo).remove();
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
				<p  class="p2"><b>7. 치료력 관련 조사내용</b></p>
			</td>
			<td height="25" width="50%">
				<p align="right">
					<c:if test="${suimVO.suimRptState eq 0}">
						<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id = "print17_7ShowAddAreaBtn" style="float:right; cursor:pointer; "  />
						<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody17_7ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
					</c:if>
				</p>
			</td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0"  align="center" width="600">
		<tr>
			<td bgcolor="#ECECEC" class="td" width="120">
				<p align="center"><b>치료기간</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="105">
				<p align="center"><b>병원명</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="105">
				<p align="center"><b>진단명</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="115">
				<p align="center"><b>검사명</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="105">
				<p align="center"><b>투약일수</b></p>
			</td>
			<td class="td" bgcolor="#ECECEC" width="50">
				<p align="center"><b>비고</b></p>
			</td>
		</tr>
		
		<tbody id = "print17_7List">
			<c:forEach items="${suimRptBody17_7List }" var="suimRptBody17_7Vo">
				<tr id = "print17_7ListTr_${suimRptBody17_7Vo.serialNo}">
					<td align="center" class="td" >
						<span class="medicalSpanClass" id = "medicalHistoryPeriodForSpan_${suimRptBody17_7Vo.serialNo}">${suimRptBody17_7Vo.medicalHistoryPeriodSpan}</span>
						<textarea style="display:none;" class="medicalInputClass" rows="3" cols="17" id = "medicalHistoryPeriodForEdite_${suimRptBody17_7Vo.serialNo}" >${suimRptBody17_7Vo.medicalHistoryPeriod}</textarea>
					</td>
					<td class="td" >
						<span class="medicalSpanClass" id = "medicalHistoryHospitalForSpan_${suimRptBody17_7Vo.serialNo}">${suimRptBody17_7Vo.medicalHistoryHospitalSpan}</span>
						<textarea style="display:none;" class="medicalInputClass" rows="3" cols="14" id = "medicalHistoryHospitalForEdite_${suimRptBody17_7Vo.serialNo}" >${suimRptBody17_7Vo.medicalHistoryHospital}</textarea>
					</td>
					<td class="td">
						<span class="medicalSpanClass" id = "medicalHistoryDiagnosisForSpan_${suimRptBody17_7Vo.serialNo}">${suimRptBody17_7Vo.medicalHistoryDiagnosisSpan}</span>
						<textarea style="display:none;" class="medicalInputClass" rows="3" cols="14" id = "medicalHistoryDiagnosisForEdite_${suimRptBody17_7Vo.serialNo}" >${suimRptBody17_7Vo.medicalHistoryDiagnosis}</textarea>
					</td>
					<td class="td">
						<span class="medicalSpanClass"id = "medicalHistoryTestForSpan_${suimRptBody17_7Vo.serialNo}">${suimRptBody17_7Vo.medicalHistoryTestSpan}</span>
						<textarea style="display:none;" class="medicalInputClass" rows="3" cols="14" id = "medicalHistoryTestForEdite_${suimRptBody17_7Vo.serialNo}" >${suimRptBody17_7Vo.medicalHistoryTest}</textarea>
					</td>
					<td class="td">
						<span class="medicalSpanClass" id = "medicalHistoryMedicineForSpan_${suimRptBody17_7Vo.serialNo}">${suimRptBody17_7Vo.medicalHistoryMedicineSpan}</span>
						<textarea style="display:none;" class="medicalInputClass" rows="3" cols="14" id = "medicalHistoryMedicineForEdite_${suimRptBody17_7Vo.serialNo}" >${suimRptBody17_7Vo.medicalHistoryMedicine}</textarea>
					</td>
					<td class="td" align="center">
						<c:if test="${suimVO.suimRptState eq 0}">
							<img src='./resources/ls_img/btn_edit_s.gif' id = "editePrint17_7Btn_${suimRptBody17_7Vo.serialNo}" onclick="print17_7Edit('${suimRptBody17_7Vo.serialNo}');" style='cursor:pointer;'/>
							<img src='./resources/ls_img/btn_del_s.gif' id = "delPrint17_7Btn_${suimRptBody17_7Vo.serialNo}" onclick="print17_7Del('${suimRptBody17_7Vo.serialNo}');" style='cursor:pointer;'/>
							<img id = "editeBody17_7ContentsOkBtn_${suimRptBody17_7Vo.serialNo}" src="./resources/ls_img/btn_check_s.gif" title="수정 완료" style="display:none;cursor:pointer;" onclick="editePrint17_7Ok('${suimRptBody17_7Vo.serialNo}');" />
						</c:if>
					</td>
				</tr>					
			</c:forEach>
		</tbody>
		<tr id = "print17_7InputTr" style="display:none;">
			<td align="center" class="td">
				<textarea rows="3" cols="17" id = "medicalHistoryPeriod" ></textarea>
			</td >
			<td class="td">
				<textarea rows="3" cols="14" id = "medicalHistoryHospital" ></textarea>
			</td>
			<td class="td">
				<textarea rows="3" cols="14" id = "medicalHistoryDiagnosis" ></textarea>
			</td>
			<td class="td">
				<textarea rows="3" cols="14" id = "medicalHistoryTest" ></textarea>
			</td>
			<td class="td">
				<textarea rows="3" cols="14" id = "medicalHistoryMedicine" ></textarea>
			</td>
			<td class="td" align="center">
				<img id = "addBody17_7ContentsOkBtn" src="./resources/ls_img/btn_check_s.gif" title="치료력 관련 조사내용 추가" style="cursor:pointer;" />
			</td>
		</tr>
	</table>
	<p>&nbsp;</p>
</body>