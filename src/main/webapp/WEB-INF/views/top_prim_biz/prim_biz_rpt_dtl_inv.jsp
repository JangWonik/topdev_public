<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
	/* 종결정보 수정 페이지 이동 */
	function primBizSuimInvUdtPage(suim_rpt_state, edit_yn, end_mod_auth){
		if (end_mod_auth == 0) {
			if(suim_rpt_state != 0){
				alert("미결 건만 수정 가능합니다.");
				return;
			}
			if(edit_yn == 0){
				alert("수정 권한이 없습니다.");
				return;
			}
		}
		$("#editPrimBizRptInvTab").click();
	}
</script>
						<table style="margin-bottom:5px;">
							<tr>
								<td align="left" style="padding-left:10px;"><b> 종결 내용</b></td>
								<td align="right" style="padding-right:10px;">
									<img style = "cursor:pointer; float:right; margin-right:5px;" src="./resources/ls_img/btn_edite.gif"
										onclick="primBizSuimInvUdtPage('${primBizRptDtl.suim_rpt_state}','${primBizRptDtl.edit_yn}','${primBizRptDtl.endModAuth}');" />
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
									<td>${primBizRptDtl.suim_rpt_type1_close12_nm}</td>
									<td bgcolor="#E7ECF1"><b>종결(평가) 건수</b></td>
									<td style="border-right:0;">${primBizRptDtl.suim_rpt_ea} 건</td>
									<td colspan="2" style="border-left:0;"></td>
								</tr>

								
								<c:if test="${primBizRptDtl.workloadUseAt == 1}">
									<tr>
										<td bgcolor="#E7ECF1" style="padding:4px 2px 4px 10px !important"><b>기준업무량 상세구분</b></td>
										<td>${primBizRptDtl.workloadTypeVal}</td>
										
										
										<td bgcolor="#E7ECF1" style="padding:4px 2px 4px 10px !important"><b>기준업무량 종결건수</b></td>
										<td style="border-right:0;">${primBizRptDtl.workloadEa} 건</td>
										<td colspan="2" style="border-left:0;"></td>
									</tr>								
								</c:if>
								
								
								<tr>
									<td bgcolor="#E7ECF1"><b>청구 금액</b></td>
									<td><fmt:formatNumber value="${primBizRptDtl.amt_claimed}" pattern="###,###,##0.##"/> 원</td>
									<td bgcolor="#E7ECF1"><b>합의 금액</b></td>
									<td><fmt:formatNumber value="${primBizRptDtl.amt_settlement}" pattern="###,###,##0.##"/> 원</td>
									<td bgcolor="#E7ECF1"><b>지급 보험금</b></td>
									<td><fmt:formatNumber value="${primBizRptDtl.amt_insu_payment}" pattern="###,###,##0.##"/> 원</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>평가(추정)손해액</b></td>
									<td><fmt:formatNumber value="${primBizRptDtl.amt_estimated_damage}" pattern="###,###,##0.##"/> 원</td>
									<td bgcolor="#E7ECF1"><b>자기 부담금</b></td>
									<td><fmt:formatNumber value="${primBizRptDtl.amt_self_pay}" pattern="###,###,##0.##"/> 원</td>
									<td bgcolor="#E7ECF1"><b>절감액</b></td>
									<td><fmt:formatNumber value="${primBizRptDtl.amt_reduction}" pattern="###,###,##0.##"/> 원</td>
								</tr>
							</table>
						</div>

						<br />

						<table style="margin-bottom:5px;">
							<tr>
								<td align="left" style="padding-left:10px;"><b> INVOICE</b></td>
								<td align="right" style="padding-right:10px;">
									<img style = "cursor:pointer; float:right; margin-right:5px;" src="./resources/ls_img/btn_edite.gif"
										onclick="primBizSuimInvUdtPage('${primBizRptDtl.suim_rpt_state}','${primBizRptDtl.edit_yn}','${primBizRptDtl.endModAuth}');" />
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
										${primBizRptDtl.invoice_date_fmt}
										<c:if test="${primBizRptDtl.tax_date_fmt != ''}">
											(제출일 변경됨 : ${primBizRptDtl.tax_date_fmt})
										</c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>기본보수</b></td>
									<td><fmt:formatNumber value="${primBizRptDtl.amt_basic}" pattern="###,###,##0.##"/> 원</td>
									<td bgcolor="#E7ECF1"><b>기본보수 내역</b></td>
									<td colspan="3">${primBizRptDtl.amt_basic_dtl}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>일비</b></td>
									<td><fmt:formatNumber value="${primBizRptDtl.amt_daily}" pattern="###,###,##0.##"/> 원</td>
									<td bgcolor="#E7ECF1"><b>일비 내역</b></td>
									<td colspan="3">${primBizRptDtl.amt_daily_dtl}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>교통비</b></td>
									<td><fmt:formatNumber value="${primBizRptDtl.amt_traffic}" pattern="###,###,##0.##"/> 원</td>
									<td bgcolor="#E7ECF1"><b>교통비 내역</b></td>
									<td colspan="3">${primBizRptDtl.amt_traffic_dtl}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>자문료</b></td>
									<td><fmt:formatNumber value="${primBizRptDtl.amt_counsel}" pattern="###,###,##0.##"/> 원</td>
									<td bgcolor="#E7ECF1"><b>자문료 내역</b></td>
									<td colspan="3">${primBizRptDtl.amt_counsel_dtl}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>기타</b></td>
									<td><fmt:formatNumber value="${primBizRptDtl.amt_etc}" pattern="###,###,##0.##"/> 원</td>
									<td bgcolor="#E7ECF1"><b>기타 내역</b></td>
									<td colspan="3">${primBizRptDtl.amt_etc_dtl}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>합계</b></td>
									<td><fmt:formatNumber value="${primBizRptDtl.amt_total}" pattern="###,###,##0.##"/> 원</td>
									<td colspan="4"></td>
								</tr>
							</table>
						</div>
