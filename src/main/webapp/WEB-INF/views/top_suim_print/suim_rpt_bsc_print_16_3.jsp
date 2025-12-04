<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>	
	<script>
		$(document).ready(function(){
			
			/* Print16_3 : B 추가 영역 보이기 */
			$("#contractBAddAreaBtn").click(function(){
				$("#contractBAddArea").show();
			});
			
			
			/* Print16_3 : D 추가 영역 보이기 */
			$("#contractDAddAreaBtn").click(function(){
				$("#contractDAddArea").show();
				
			});
		
			/* Print16_3 : A 추가 영역 보이기 */
			$("#contractAAddAreaBtn").click(function(){
				$("#contractAAddArea").show();
			});
		
			$("#addBody16_3contractBOkBtn").click(function(){
				$.post("./insBody16_3Ok",
						{	
							 rptPrintNo			:"${suimRptBody16_1267Vo.rptPrintNo}"
							,contractBa			: 1
							,confirmDate  		:$("#confirmDateB").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//계약일자
							,confirmDtl  		:$("#confirmDtlB").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//확인내용
							,relativeOrgan  	:$("#relativeOrganB").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//관련기관
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("불러오기를 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$(".print16_3BSpanClass").css("display","inline");
									$(".print16_3BInputClass").css("display","none");	
									$("#contractBAddArea").hide();
									$("#contractBListBody").append(
											
											"<tr id = 'Print16_3BListTr_"+data+"'>"
											+	"<td class='td'>"
											+		"<span class='print16_3BSpanClass_"+data+"' id = 'confirmDateBSpanId_"+data+"'>"+$("#confirmDateB").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
											+		"<textarea class='print16_3BInputClass_"+data+"' id='confirmDateB_"+data+"' style='display:none; width:99%; height:50px;'>"+$("#confirmDateB").val()+"</textarea>"
											+	"</td>"
											+	"<td class='td'>"
											+		"<span class='print16_3BSpanClass_"+data+"' id = 'confirmDtlBSpanId_"+data+"'>"+$("#confirmDtlB").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
											+		"<textarea class='print16_3BInputClass_"+data+"' id='confirmDtlB_"+data+"' style='display:none; width:99%; height:50px;'>"+$("#confirmDtlB").val()+"</textarea>"
											+	"</td>"
											+	"<td class='td'>"
											+		"<span class='print16_3BSpanClass_"+data+"' id = 'relativeOrganBSpanId_"+data+"'>"+$("#relativeOrganB").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
											+		"<textarea class='print16_3BInputClass_"+data+"' id='relativeOrganB_"+data+"' style='display:none; width:99%; height:50px;'>"+$("#relativeOrganB").val()+"</textarea>"
											+	"</td>"
											+	"<td class='td' align='center'>"
											+		"<img src='./resources/ls_img/btn_edit_s.gif' id = 'editePrint16_3BBtn_"+data+"' onclick=\"print16_3BEdit('"+data+"');\" style='cursor:pointer; '/>  "
											+		"<img src='./resources/ls_img/btn_del_s.gif' id = 'delPrint16_3BBtn_"+data+"' onclick=\"print16_3Del('1','"+data+"');\" style='cursor:pointer; '/>"
											+		"<img id ='editeBody16_3BContentsOkBtn_"+data+"' src='./resources/ls_img/btn_check_s.gif' title='수정 완료' style='display:none;cursor:pointer;' onclick=\"editePrint16_3BOk('"+data+"');\" />"
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
			
			$("#addBody16_3contractDOkBtn").click(function(){
				$.post("./insBody16_3Ok",
						{	
							 rptPrintNo			:"${suimRptBody16_1267Vo.rptPrintNo}"
							,contractBa			: 2
							,confirmDate  		:$("#confirmDateD").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//계약일자
							,confirmDtl  		:$("#confirmDtlD").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//확인내용
							,relativeOrgan  	:$("#relativeOrganD").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//관련기관
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("불러오기를 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$(".print16_3DSpanClass").css("display","inline");
									$(".print16_3DInputClass").css("display","none");	
									$("#contractDAddArea").hide();
									$("#contractDListBody").append(
											
											"<tr id = 'Print16_3DListTr_"+data+"'>"
											+	"<td class='td'>"
											+		"<span class='print16_3DSpanClass_"+data+"' id = 'confirmDateDSpanId_"+data+"'>"+$("#confirmDateD").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
											+		"<textarea class='print16_3DInputClass_"+data+"' id='confirmDateD_"+data+"' style='display:none; width:99%; height:50px;'>"+$("#confirmDateD").val()+"</textarea>"
											+	"</td>"
											+	"<td class='td'>"
											+		"<span class='print16_3DSpanClass_"+data+"' id = 'confirmDtlDSpanId_"+data+"'>"+$("#confirmDtlD").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
											+		"<textarea class='print16_3DInputClass_"+data+"' id='confirmDtlD_"+data+"' style='display:none; width:99%; height:50px;'>"+$("#confirmDtlD").val()+"</textarea>"
											+	"</td>"
											+	"<td class='td'>"
											+		"<span class='print16_3DSpanClass_"+data+"' id = 'relativeOrganDSpanId_"+data+"'>"+$("#relativeOrganD").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
											+		"<textarea class='print16_3DInputClass_"+data+"' id='relativeOrganD_"+data+"' style='display:none; width:99%; height:50px;'>"+$("#relativeOrganD").val()+"</textarea>"
											+	"</td>"
											+	"<td class='td' align='center'>"
											+		"<img src='./resources/ls_img/btn_edit_s.gif' id = 'editePrint16_3DBtn_"+data+"' onclick=\"print16_3DEdit('"+data+"');\" style='cursor:pointer; '/>  "
											+		"<img src='./resources/ls_img/btn_del_s.gif' id = 'delPrint16_3DBtn_"+data+"' onclick=\"print16_3Del('2','"+data+"');\" style='cursor:pointer; '/>"
											+		"<img id ='editeBody16_3DContentsOkBtn_"+data+"' src='./resources/ls_img/btn_check_s.gif' title='수정 완료' style='display:none;cursor:pointer;' onclick=\"editePrint16_3DOk('"+data+"');\" />"
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
			
			$("#addBody16_3contractAOkBtn").click(function(){
				$.post("./insBody16_3Ok",
						{	
							 rptPrintNo			:"${suimRptBody16_1267Vo.rptPrintNo}"
							,contractBa			: 3
							,confirmDate  		:$("#confirmDateA").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//계약일자
							,confirmDtl  		:$("#confirmDtlA").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//확인내용
							,relativeOrgan  	:$("#relativeOrganA").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//관련기관
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("불러오기를 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$(".print16_3ASpanClass").css("display","inline");
									$(".print16_3AInputClass").css("display","none");	
									$("#contractAAddArea").hide();
									$("#contractAListBody").append(
											
											"<tr id = 'Print16_3AListTr_"+data+"'>"
											+	"<td class='td'>"
											+		"<span class='print16_3ASpanClass_"+data+"' id = 'confirmDateASpanId_"+data+"'>"+$("#confirmDateA").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
											+		"<textarea class='print16_3AInputClass_"+data+"' id='confirmDateA_"+data+"' style='display:none; width:99%; height:50px;'>"+$("#confirmDateA").val()+"</textarea>"
											+	"</td>"
											+	"<td class='td'>"
											+		"<span class='print16_3ASpanClass_"+data+"' id = 'confirmDtlASpanId_"+data+"'>"+$("#confirmDtlA").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
											+		"<textarea class='print16_3AInputClass_"+data+"' id='confirmDtlA_"+data+"' style='display:none; width:99%; height:50px;'>"+$("#confirmDtlA").val()+"</textarea>"
											+	"</td>"
											+	"<td class='td'>"
											+		"<span class='print16_3ASpanClass_"+data+"' id = 'relativeOrganASpanId_"+data+"'>"+$("#relativeOrganA").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')+"</span>"
											+		"<textarea class='print16_3AInputClass_"+data+"' id='relativeOrganA_"+data+"' style='display:none; width:99%; height:50px;'>"+$("#relativeOrganA").val()+"</textarea>"
											+	"</td>"
											+	"<td class='td' align='center'>"
											+		"<img src='./resources/ls_img/btn_edit_s.gif' id = 'editePrint16_3ABtn_"+data+"' onclick=\"print16_3AEdit('"+data+"');\" style='cursor:pointer; '/>  "
											+		"<img src='./resources/ls_img/btn_del_s.gif' id = 'delPrint16_3ABtn_"+data+"' onclick=\"print16_3Del('3','"+data+"');\" style='cursor:pointer; '/>"
											+		"<img id ='editeBody16_3AContentsOkBtn_"+data+"' src='./resources/ls_img/btn_check_s.gif' title='수정 완료' style='display:none;cursor:pointer;' onclick=\"editePrint16_3AOk('"+data+"');\" />"
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
		
		/* 계약 전 사항 수정 */
		function print16_3BEdit(serialNo){
			$(".print16_3BSpanClass_"+serialNo).hide();
			$(".print16_3BInputClass_"+serialNo).show();
			
			$("#editePrint16_3BBtn_"+serialNo).hide();
			$("#delPrint16_3BBtn_"+serialNo).hide();
			$("#editeBody16_3BContentsOkBtn_"+serialNo).show();
			
		}
		
		/* 계약 일 사항 수정 */
		function print16_3DEdit(serialNo){
			$(".print16_3DSpanClass_"+serialNo).hide();
			$(".print16_3DInputClass_"+serialNo).show();
			
			$("#editePrint16_3DBtn_"+serialNo).hide();
			$("#delPrint16_3DBtn_"+serialNo).hide();
			$("#editeBody16_3DContentsOkBtn_"+serialNo).show();
			
		}
		
		/* 계약 후 사항 수정 */
		function print16_3AEdit(serialNo){
			$(".print16_3ASpanClass_"+serialNo).hide();
			$(".print16_3AInputClass_"+serialNo).show();
			
			$("#editePrint16_3ABtn_"+serialNo).hide();
			$("#delPrint16_3ABtn_"+serialNo).hide();
			$("#editeBody16_3AContentsOkBtn_"+serialNo).show();
			
		}
		
		function editePrint16_3BOk(serialNo){
			$.post("./editeBody16_3Ok",
					{	
						 serialNo			:serialNo
						,confirmDate  		:$("#confirmDateB_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//계약일자
						,confirmDtl  		:$("#confirmDtlB_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//확인내용
						,relativeOrgan  	:$("#relativeOrganB_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//관련기관
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("불러오기를 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								$(".print16_3BSpanClass_"+serialNo).show();
								
								$("#confirmDateBSpanId_"+serialNo).html($("#confirmDateB_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								$("#confirmDtlBSpanId_"+serialNo).html($("#confirmDtlB_"+serialNo).html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								$("#relativeOrganBSpanId_"+serialNo).html($("#relativeOrganB_"+serialNo).html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								
								
								$(".print16_3BInputClass_"+serialNo).hide();
								
								$("#editePrint16_3BBtn_"+serialNo).show();
								$("#delPrint16_3BBtn_"+serialNo).show();
								$("#editeBody16_3BContentsOkBtn_"+serialNo).hide();
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
		}
		
		function editePrint16_3DOk(serialNo){
			$.post("./editeBody16_3Ok",
					{	
						 serialNo			:serialNo
						,confirmDate  		:$("#confirmDateD_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//계약일자
						,confirmDtl  		:$("#confirmDtlD_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//확인내용
						,relativeOrgan  	:$("#relativeOrganD_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//관련기관
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("불러오기를 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								$(".print16_3DSpanClass_"+serialNo).show();
								
								$("#confirmDateDSpanId_"+serialNo).html($("#confirmDateD_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								$("#confirmDtlDSpanId_"+serialNo).html($("#confirmDtlD_"+serialNo).html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								$("#relativeOrganDSpanId_"+serialNo).html($("#relativeOrganD_"+serialNo).html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								
								
								$(".print16_3DInputClass_"+serialNo).hide();
								
								$("#editePrint16_3DBtn_"+serialNo).show();
								$("#delPrint16_3DBtn_"+serialNo).show();
								$("#editeBody16_3DContentsOkBtn_"+serialNo).hide();
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
		}
		
		function editePrint16_3AOk(serialNo){
			$.post("./editeBody16_3Ok",
					{	
						 serialNo			:serialNo
						,confirmDate  		:$("#confirmDateA_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//계약일자
						,confirmDtl  		:$("#confirmDtlA_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//확인내용
						,relativeOrgan  	:$("#relativeOrganA_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//관련기관
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("불러오기를 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								$(".print16_3ASpanClass_"+serialNo).show();
								
								$("#confirmDateASpanId_"+serialNo).html($("#confirmDateA_"+serialNo).val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								$("#confirmDtlASpanId_"+serialNo).html($("#confirmDtlA_"+serialNo).html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								$("#relativeOrganASpanId_"+serialNo).html($("#relativeOrganA_"+serialNo).html().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								
								
								$(".print16_3AInputClass_"+serialNo).hide();
								
								$("#editePrint16_3ABtn_"+serialNo).show();
								$("#delPrint16_3ABtn_"+serialNo).show();
								$("#editeBody16_3AContentsOkBtn_"+serialNo).hide();
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
			);//post
		}
		
		/* Print16_3 삭제하기 */
		function print16_3Del(kind,serialNo){
			if(confirm("삭제하시겠습니까?")){
				$.post("./delBody16_3Ok",
						{	
								serialNo	:serialNo
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("삭제 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									if(kind == 1){
										$("#Print16_3BListTr_"+serialNo).remove();										
									}else if(kind == 2){
										$("#Print16_3DListTr_"+serialNo).remove();
									}else{
										$("#Print16_3AListTr_"+serialNo).remove();
									}
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
	<table align="center" cellpadding="0" cellspacing="0" width="100%" bgcolor="white">
		<tr>
			<td width="50%" height="30">
				<p><font color="#113F7D">▣ <b>조사자 일자별 확인사항</b></font></p>
			</td>
			<td width="50%" height="30">
				<p align="right">
					<!-- <a href='./report_03.php?rid=' onclick="NewPopUp(this.href,'Report_03','700','550','yes','center');return false" onfocus='this.blur()'><img src='../img/btn_edite.gif' border='0'></a> -->
				</p>
			</td>
		</tr>
		<tr><td width="100%" height="1" colspan="2" bgcolor="#0077B1"></td></tr>
	</table>
	<table align="center" width="640">
		<colgroup>
			<col width="200"></col>
			<col width="200"></col>
			<col width="200"></col>
			<col width="40"></col>
		</colgroup>
		<tr align="center" bgcolor="#efefef">
			<td class="td" nowrap><b>일자</b></td>
			<td class="td" nowrap><b>확인내용</b></td>
			<td class="td" nowrap><b>관련기관</b></td>
			<td class="td" nowrap><b>비고</b></td>
		</tr>
		<tr>
			<td colspan="4" class="td" align="center" bgcolor="#efefef">
				<b>계약전
					<img src="./resources/ls_img/btn_add_s.gif" title="계약 전 사항 추가" id = "contractBAddAreaBtn" style="cursor:pointer; vertical-align:middle;" onclick=""/>
				</b>
			</td>
		</tr>
		<tbody id = "contractBListBody">
		<c:forEach items="${suimRptBody16_3BList}" var="contractB">
			<c:if test="${contractB.contractBa eq 1}">
				<tr id = "Print16_3BListTr_${contractB.serialNo}">
					<td class="td">
						<span class="print16_3BSpanClass_${contractB.serialNo}" id = "confirmDateBSpanId_${contractB.serialNo}">${contractB.confirmDateSpan}</span>
						<textarea class="print16_3BInputClass_${contractB.serialNo}" id="confirmDateB_${contractB.serialNo}" style="display:none;width:99%; height:50px;">${contractB.confirmDate}</textarea>
					</td>
					<td class="td">
						<span class="print16_3BSpanClass_${contractB.serialNo}" id = "confirmDtlBSpanId_${contractB.serialNo}">${contractB.confirmDtlSpan}</span>
						<textarea class="print16_3BInputClass_${contractB.serialNo}" id="confirmDtlB_${contractB.serialNo}" style="display:none;width:99%; height:50px;">${contractB.confirmDtl}</textarea>
					</td>
					<td class="td">
						<span class="print16_3BSpanClass_${contractB.serialNo}" id = "relativeOrganBSpanId_${contractB.serialNo}">${contractB.relativeOrganSpan}</span>
						<textarea class="print16_3BInputClass_${contractB.serialNo}" id="relativeOrganB_${contractB.serialNo}" style="display:none;width:99%; height:50px;">${contractB.relativeOrgan}</textarea>
					</td>
					<td class="td" align="center">
						<c:if test="${suimVO.suimRptState eq 0}">
							<img src='./resources/ls_img/btn_edit_s.gif' id = "editePrint16_3BBtn_${contractB.serialNo}" onclick="print16_3BEdit('${contractB.serialNo}');" style='cursor:pointer; '/>
							<img src='./resources/ls_img/btn_del_s.gif' id = "delPrint16_3BBtn_${contractB.serialNo}" onclick="print16_3Del('1','${contractB.serialNo}');" style='cursor:pointer; '/>
							<img id = "editeBody16_3BContentsOkBtn_${contractB.serialNo}" src="./resources/ls_img/btn_check_s.gif" title="수정 완료" style="display:none;cursor:pointer;" onclick="editePrint16_3BOk('${contractB.serialNo}');" />
						</c:if>
					</td>
				</tr>
			</c:if>
		</c:forEach>
		</tbody>
		<tr id = "contractBAddArea" style="display:none;">
			<td class="td" >
				<textarea id="confirmDateB" style="width:99%; height:50px;"></textarea>
			</td>
			<td class="td">
				<textarea id="confirmDtlB" style="width:99%; height:50px;"></textarea>
			</td>
			<td class="td" >
				<textarea id="relativeOrganB" style="width:99%; height:50px;"></textarea>
			</td>
			<td class="td" align="center">
				<img id = "addBody16_3contractBOkBtn" src="./resources/ls_img/btn_check_s.gif" title="추가" style="cursor:pointer;"/>
			</td>
		</tr>
		
		
		<tr>
			<td colspan="4" class="td" align="center" bgcolor="#efefef" >
				<b>계약일
					<img src="./resources/ls_img/btn_add_s.gif" title="계약 일 사항 추가" id = "contractDAddAreaBtn" style="cursor:pointer; vertical-align:middle;" onclick=""/>
				</b>
			</td>
		</tr>
		<tbody id = "contractDListBody">
		<c:forEach items="${suimRptBody16_3DList}" var="contractD">
			<c:if test="${contractD.contractBa eq 2}">
				<tr id = "Print16_3DListTr_${contractD.serialNo}">
					<td class="td">
						<span class="print16_3DSpanClass_${contractD.serialNo}" id = "confirmDateDSpanId_${contractD.serialNo}">${contractD.confirmDateSpan}</span>
						<textarea class="print16_3DInputClass_${contractD.serialNo}" id="confirmDateD_${contractD.serialNo}" style="display:none;width:99%; height:50px;">${contractD.confirmDate}</textarea>
					</td>
					<td class="td">
						<span class="print16_3DSpanClass_${contractD.serialNo}" id = "confirmDtlDSpanId_${contractD.serialNo}">${contractD.confirmDtlSpan}</span>
						<textarea class="print16_3DInputClass_${contractD.serialNo}" id="confirmDtlD_${contractD.serialNo}" style="display:none;width:99%; height:50px;">${contractD.confirmDtl}</textarea>
					</td>
					<td class="td">
						<span class="print16_3DSpanClass_${contractD.serialNo}" id = "relativeOrganDSpanId_${contractD.serialNo}">${contractD.relativeOrganSpan}</span>
						<textarea class="print16_3DInputClass_${contractD.serialNo}" id="relativeOrganD_${contractD.serialNo}" style="display:none;width:99%; height:50px;">${contractD.relativeOrgan}</textarea>
					</td>
					<td class="td" align="center">
						<c:if test="${suimVO.suimRptState eq 0}">
							<img src='./resources/ls_img/btn_edit_s.gif' id = "editePrint16_3DBtn_${contractD.serialNo}" onclick="print16_3DEdit('${contractD.serialNo}');" style='cursor:pointer; '/>
							<img src='./resources/ls_img/btn_del_s.gif' id = "delPrint16_3DBtn_${contractD.serialNo}" onclick="print16_3Del('2','${contractD.serialNo}');" style='cursor:pointer; '/>
							<img id = "editeBody16_3DContentsOkBtn_${contractD.serialNo}" src="./resources/ls_img/btn_check_s.gif" title="수정 완료" style="display:none;cursor:pointer;" onclick="editePrint16_3DOk('${contractD.serialNo}');" />
						</c:if>
					</td>
				</tr>
			</c:if>
		</c:forEach>
		</tbody>
		
		<tr id = "contractDAddArea" style="display:none;">
			<td class="td">
				<textarea id="confirmDateD" style="width:99%; height:50px;"></textarea>
			</td>
			<td class="td">
				<textarea id="confirmDtlD" style="width:99%; height:50px;"></textarea>
			</td>
			<td class="td">
				<textarea id="relativeOrganD" style="width:99%; height:50px;"></textarea>
			</td>
			<td class="td" align="center">
				<img id = "addBody16_3contractDOkBtn" src="./resources/ls_img/btn_check_s.gif" title="추가" style="cursor:pointer;"/>
			</td>
		</tr>
		<tr>
			<td class="td" align="center" colspan="4" bgcolor="#efefef">
				<b>계약후
					<img src="./resources/ls_img/btn_add_s.gif" title="계약 후 사항 추가" id = "contractAAddAreaBtn" style="cursor:pointer; vertical-align:middle;" onclick=""/>
				</b>
			</td>
		</tr>		
		<tbody id = "contractAListBody">
		<c:forEach items="${suimRptBody16_3AList}" var="contractA">
			<c:if test="${contractA.contractBa eq 3}">
				<tr id = "Print16_3AListTr_${contractA.serialNo}">
					<td class="td">
						<span class="print16_3ASpanClass_${contractA.serialNo}" id = "confirmDateASpanId_${contractA.serialNo}">${contractA.confirmDateSpan}</span>
						<textarea class="print16_3AInputClass_${contractA.serialNo}" id="confirmDateA_${contractA.serialNo}" style="display:none;width:99%; height:50px;">${contractA.confirmDate}</textarea>
					</td>
					<td class="td">
						<span class="print16_3ASpanClass_${contractA.serialNo}" id = "confirmDtlASpanId_${contractA.serialNo}">${contractA.confirmDtlSpan}</span>
						<textarea class="print16_3AInputClass_${contractA.serialNo}" id="confirmDtlA_${contractA.serialNo}" style="display:none;width:99%; height:50px;">${contractA.confirmDtl}</textarea>
					</td>
					<td class="td">
						<span class="print16_3ASpanClass_${contractA.serialNo}" id = "relativeOrganASpanId_${contractA.serialNo}">${contractA.relativeOrganSpan}</span>
						<textarea class="print16_3AInputClass_${contractA.serialNo}" id="relativeOrganA_${contractA.serialNo}" style="display:none;width:99%; height:50px;">${contractA.relativeOrgan}</textarea>
					</td>
					<td class="td" align="center">
						<c:if test="${suimVO.suimRptState eq 0}">
							<img src='./resources/ls_img/btn_edit_s.gif' id = "editePrint16_3ABtn_${contractA.serialNo}" onclick="print16_3AEdit('${contractA.serialNo}');" style='cursor:pointer; '/>
							<img src='./resources/ls_img/btn_del_s.gif' id = "delPrint16_3ABtn_${contractA.serialNo}" onclick="print16_3Del('3','${contractA.serialNo}');" style='cursor:pointer; '/>
							<img id = "editeBody16_3AContentsOkBtn_${contractA.serialNo}" src="./resources/ls_img/btn_check_s.gif" title="수정 완료" style="display:none;cursor:pointer;" onclick="editePrint16_3AOk('${contractA.serialNo}');" />
						</c:if>
					</td>
				</tr>
			</c:if>
		</c:forEach>
		</tbody>
		
		<tr id = "contractAAddArea" style="display:none;">
			<td class="td">
				<textarea id="confirmDateA" style="width:99%; height:50px;"></textarea>
			</td>
			<td class="td">
				<textarea id="confirmDtlA" style="width:99%; height:50px;"></textarea>
			</td>
			<td class="td">
				<textarea id="relativeOrganA" style="width:99%; height:50px;"></textarea>
			</td>
			<td class="td" align="center">
				<img id = "addBody16_3contractAOkBtn" src="./resources/ls_img/btn_check_s.gif" title="추가" style="cursor:pointer;"/>
			</td>
		</tr>
	</table>
	<p>&nbsp;</p>
</body>