<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<%--spiner start--%>
    <script src="/resources/jquery/spin.js"></script>
    <script src="/resources/jquery/jquery.spin.js"></script>
    <%--spiner end --%>
	
	
	<script>
		var workload_ea_first = false;	//최초 진입시 종결건수값 변경 안되도록 하기 위한 값
		
		$(document).ready(function(){
			
			//기준업무량 초기화 
			$("#workload_type"+"${primBizRptDtl.suim_rpt_type1}"+"_"+"${primBizRptDtl.workloadType}").click();
			if ("${primBizRptDtl.workloadType}" == ""){
				workload_ea_first = true;
			}
			
			$("#cancelEditPrimBizRptInvTabBtn").click(function(){
				var tmp = window.confirm("작성을 취소 하시겠습니까?");
				if(tmp == false){
					return;
				}
				$("#infoPrimBizRptTab").click();
			});

			$("#editPrimBizRptInvTabBtn").click(function(){
				var tmp = window.confirm("종결 및 인보이스 정보를 수정 하시겠습니까?");
				if(tmp == false){
					return;
				}
				
				if ( $("#invoice_date").val() == "" || $("#invoice_date").val() == 0){
					alert("인보이스 제출일을 입력 해 주세요..");
					return;
				}
				
				if (!workloadValid && "${primBizRptDtl.workloadUseAt}" == 1){
					alert("기준업무량 상세 구분을 입력 해 주세요..");
					return;
				}else if( $("#workload_ea").val() == ""){
					alert("기준업무량 종결건수를 입력 해 주세요..");
					return;
				}
				
				$("#workload_ea").prop("disabled",false);
				
		        var param = $("#editPrimBizRptInvTabForm").serialize();
		        var url = "./primBizRptDtlInvUdt";
		        
		        $.ajax({
		            type: "POST",
		            url: url,
		            data: param,
		            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		            timeout: 20000,
		            dataType: "JSON", 
		            success: function(data){
		            	if (data.result == 1){
							alert("수정 되었습니다");
							location.reload();
		            	}
// 		            	$("#srchResultUl").append(data);
		            },
		            error: function(e){
		                alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		            },
		        });
				
			});

			$(".invAmtToSum").blur(function(){
				var tmpSum = String(parseInt($("#amt_basic").val().replace(/,/g,""))
				+ parseInt($("#amt_daily").val().replace(/,/g,""))
				+ parseInt($("#amt_traffic").val().replace(/,/g,""))
				+ parseInt($("#amt_counsel").val().replace(/,/g,""))
				+ parseInt($("#amt_etc").val().replace(/,/g,"")));
				$("#amt_total").val(tmpSum.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
			});//$(".invAmtToSum").blur

		});//$(document).ready
		
		var workloadValid = false;
		
		function fnValidWorkload(col_cd1,col_cd2){
			var param = {};
			param.col_cd1 = col_cd1;
			param.col_cd2 = col_cd2;
			
		    var url = "/getWorkloadEaGubun";
		    $.ajax({
		        type: "POST",
		        url: url,
		        data: param,
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		        timeout: 20000,
		        dataType: "JSON", 
		        success: function(data){
		        	$("#workload_ea").val( data.workloadEa );
		        	
		        	workloadValid = true;
		        },
	            beforeSend: function(){
	            $('body').spin();
		        },
		        complete: function(){
		            $('body').spin(false);
		        }
		        
		    });
		}
		
	</script>
						<form id="editPrimBizRptInvTabForm" name="editPrimBizRptInvTabForm" action="./primBizRptDtlInvUdt" method="post">
							<input type="hidden" name="suim_rpt_no" value="${primBizRptDtl.suim_rpt_no}"/>
							<input type="hidden" name="rpt_invoice_no" value="${primBizRptDtl.rpt_invoice_no}"/>
							<table style="margin-bottom:5px;">
								<tr>
									<td align="left" style="padding-left:10px;"><b> 종결 내용</b></td>
									<td align="right" style="padding-right:10px;">
									</td>
								</tr>
							</table>
							<div class= "tableStyle21">
								<table>
									<colgroup>
										<col width="14%">
										<col>
										<col width="14%">
										<col>
										<col width="14%">
										<col>
									</colgroup>
									<tr>
										<td bgcolor="#E7ECF1"><b>종결 구분</b></td>
										<td>
											<select id="suim_rpt_type1_close12" name="suim_rpt_type1_close12">
												<c:forEach items="${type1Close12List}" var="close12Vo">
													<option value="${close12Vo.col_cd}"
														<c:if test="${primBizRptDtl.suim_rpt_type1_close12 == close12Vo.col_cd}">selected</c:if>
													>${close12Vo.col_val}</option>
												</c:forEach>
											</select>
										</td>
										<td bgcolor="#E7ECF1"><b>종결(평가) 건수</b></td>
										<td style="border-right:0;">
											<input type="text" name="suim_rpt_ea" id="suim_rpt_ea"
												value="<fmt:formatNumber value="${primBizRptDtl.suim_rpt_ea}" pattern="###,###,##0.##"/>"
												style="ime-mode:disabled;text-align:right;" /> 건
										</td>
										<td colspan="2" style="border-left:0;"></td>
									</tr>
									
									<c:if test="${primBizRptDtl.workloadUseAt == 1}">
										<tr>
											<td bgcolor="#E7ECF1" style="padding:4px 2px 4px 10px !important;"><b>기준업무량 상세구분</b></td>
											<td colspan="3">
												<c:if test="${primBizRptDtl.workloadUseAt == 1}">
													<c:forEach items="${workloadTypeList}" var="item" varStatus="status">
														<c:if test="${item.col_cd1 == 5 }">
															<input type="radio" name="workload_type" id="workload_type${item.col_cd1}_${item.col_cd2}" value="${item.col_cd2}" onclick="fnValidWorkload('${item.col_cd1}','${item.col_cd2}');"/>
															<label for='workload_type${item.col_cd1}_${item.col_cd2}'>${item.col_val}</label>&nbsp;
														</c:if> 
													</c:forEach>
												</c:if>
											</td>
											
											<td bgcolor="#E7ECF1" style="padding:4px 2px 4px 10px !important;"><b>기준업무량 종결 건수</b></td>
											<td style="border-right:0;">
												<input type="text" name="workload_ea" id="workload_ea" 
													   value="${primBizRptDtl.workloadEa}" style="ime-mode:disabled;text-align:right;" /> 건
											</td>
										</tr>
									</c:if>
									
									<tr>
										<td bgcolor="#E7ECF1"><b>청구 금액</b></td>
										<td>
											<input type="text" name="amt_claimed" id="amt_claimed"
												value="<fmt:formatNumber value="${primBizRptDtl.amt_claimed}" pattern="###,###,##0.##"/>"
												ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;" /> 원
										</td>
										<td bgcolor="#E7ECF1"><b>합의 금액</b></td>
										<td>
											<input type="text" name="amt_settlement" id="amt_settlement"
												value="<fmt:formatNumber value="${primBizRptDtl.amt_settlement}" pattern="###,###,##0.##"/>"
												ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;" /> 원
										</td>
										<td bgcolor="#E7ECF1"><b>지급 보험금</b></td>
										<td>
											<input type="text" name="amt_insu_payment" id="amt_insu_payment"
												value="<fmt:formatNumber value="${primBizRptDtl.amt_insu_payment}" pattern="###,###,##0.##"/>"
												ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;" /> 원
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>평가(추정)손해액</b></td>
										<td>
											<input type="text" name="amt_estimated_damage" id="amt_estimated_damage"
												value="<fmt:formatNumber value="${primBizRptDtl.amt_estimated_damage}" pattern="###,###,##0.##"/>"
												ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;" /> 원
										</td>
										<td bgcolor="#E7ECF1"><b>자기 부담금</b></td>
										<td>
											<input type="text" name="amt_self_pay" id="amt_self_pay"
												value="<fmt:formatNumber value="${primBizRptDtl.amt_self_pay}" pattern="###,###,##0.##"/>"
												ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;" /> 원
										</td>
										<td bgcolor="#E7ECF1"><b>절감액</b></td>
										<td>
											<input type="text" name="amt_reduction" id="amt_reduction"
												value="<fmt:formatNumber value="${primBizRptDtl.amt_reduction}" pattern="###,###,##0.##"/>"
												ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;" /> 원
										</td>
									</tr>
								</table>
							</div>
	
							<br />
	
							<table style="margin-bottom:5px;">
								<tr>
									<td align="left" style="padding-left:10px;"><b> INVOICE</b></td>
									<td align="right" style="padding-right:10px;">
									</td>
								</tr>
							</table>
							<div class= "tableStyle21">
								<table>
									<colgroup>
										<col width="12.5%">
										<col>
										<col width="12.5%">
										<col>
										<col width="12.5%">
										<col>
									</colgroup>
									<tr>
										<td bgcolor="#E7ECF1"><b>제출일</b></td>
										<td colspan="5">
											<input type="text" class="classCalendar" id="invoice_date" name="invoice_date" size="10"
												value="${primBizRptDtl.invoice_date_fmt}" readonly style="background-color:lightgrey;" />
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>기본보수</b></td>
										<td>
											<input type="text" name="amt_basic" id="amt_basic" class="invAmtToSum"
												value="<fmt:formatNumber value="${primBizRptDtl.amt_basic}" pattern="###,###,##0.##"/>"
												ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;" /> 원
										</td>
										<td bgcolor="#E7ECF1"><b>기본보수 내역</b></td>
										<td colspan="3">
											<input type="text" name="amt_basic_dtl" value="${primBizRptDtl.amt_basic_dtl}" size="70" maxlength="50">
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>일비</b></td>
										<td>
											<input type="text" name="amt_daily" id="amt_daily" class="invAmtToSum"
												value="<fmt:formatNumber value="${primBizRptDtl.amt_daily}" pattern="###,###,##0.##"/>"
												ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;" /> 원
										</td>
										<td bgcolor="#E7ECF1"><b>일비 내역</b></td>
										<td colspan="3">
											<input type="text" name="amt_daily_dtl" value="${primBizRptDtl.amt_daily_dtl}" size="70" maxlength="50">
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>교통비</b></td>
										<td>
											<input type="text" name="amt_traffic" id="amt_traffic" class="invAmtToSum"
												value="<fmt:formatNumber value="${primBizRptDtl.amt_traffic}" pattern="###,###,##0.##"/>"
												ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;" /> 원
										</td>
										<td bgcolor="#E7ECF1"><b>교통비 내역</b></td>
										<td colspan="3">
											<input type="text" name="amt_traffic_dtl" value="${primBizRptDtl.amt_traffic_dtl}" size="70" maxlength="50">
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>자문료</b></td>
										<td>
											<input type="text" name="amt_counsel" id="amt_counsel" class="invAmtToSum"
												value="<fmt:formatNumber value="${primBizRptDtl.amt_counsel}" pattern="###,###,##0.##"/>"
												ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;" /> 원
										</td>
										<td bgcolor="#E7ECF1"><b>자문료 내역</b></td>
										<td colspan="3">
											<input type="text" name="amt_counsel_dtl" value="${primBizRptDtl.amt_counsel_dtl}" size="70" maxlength="50">
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>기타</b></td>
										<td>
											<input type="text" name="amt_etc" id="amt_etc" class="invAmtToSum"
												value="<fmt:formatNumber value="${primBizRptDtl.amt_etc}" pattern="###,###,##0.##"/>"
												ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;" /> 원
										</td>
										<td bgcolor="#E7ECF1"><b>기타 내역</b></td>
										<td colspan="3">
											<input type="text" name="amt_etc_dtl" value="${primBizRptDtl.amt_etc_dtl}" size="70" maxlength="50">
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>합계</b></td>
										<td>
											<input type="text" name="amt_total" id="amt_total"
												value="<fmt:formatNumber value="${primBizRptDtl.amt_total}" pattern="###,###,##0.##"/>"
												readonly style="background-color:lightgrey;text-align:right;" /> 원
										</td>
										<td colspan="4"></td>
									</tr>
								</table>
							</div>
						</form>
						<p align="center" style="margin-top:7px;">
							<img id="editPrimBizRptInvTabBtn" src="./resources/ls_img/btn_ok.gif" alt="저장" style ="cursor:pointer" />
							<img id="cancelEditPrimBizRptInvTabBtn" src="./resources/ls_img/btn_cancel.gif" alt="취소" style ="cursor:pointer" />
						</p>
						