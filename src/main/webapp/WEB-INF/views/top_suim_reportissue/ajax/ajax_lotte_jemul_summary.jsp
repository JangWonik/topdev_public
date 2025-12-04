<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
</head>
<script>
	$(document).ready(function(){		
			
		//총괄표 자기부담금 직접입력
		$("#amt_self_pay_unit").change( function(){			
			var sSelval = $("#amt_self_pay_unit option:selected").val();
			//직접선택의 경우 입력창을 보여준다.
			if( sSelval == 'direct'){
				$("#amt_self_pay_unit_direct").show();
			}else{
				$("#amt_self_pay_unit_direct").hide();
			}			
		});
		
		
	});
</script>
<c:if test="${ summary_edit_type eq 'view' }">
	<table id="table_issue_contract_view" style="border: 1px solid currentColor;">
		<c:if test="${ctype eq 'C'}">
		<colgroup>
			<col width="15%">
			<col width="15%">
			<col width="15%">
			<col width="15%">
			<col width="15%">
			<col width="15%">
		</colgroup>                
		<tbody>
			<tr>
				<th><b>목적물</b></th>
				<th><b>가입금액</b></th>
				<th><b>보험가액</b></th>
				<th><b>손해액</b></th>
				<th><b>잔존물</b></th>
				<th><b>약관상<br/>지급책임액</b></th>                	
			</tr>
			<c:forEach items="${rptIssueSummaryList}" var="item" varStatus="status">
				<tr>                	
					<td>${item.summaryCate}</td>					
					<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.joinPrice}" pattern="#,###" /></td>
					<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.insuPrice}" pattern="#,###" /></td>
					<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.lossPrice}" pattern="#,###" /></td>
					<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.remainPrice}" pattern="#,###" /></td>
					<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.responPrice}" pattern="#,###" /></td>
				</tr>
			</c:forEach>
			<tr>                	
					<td><b>합계</b></td>
					<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_joinPrice}" pattern="#,###" /></b></td>
					<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_insuPrice}" pattern="#,###" /></b></td>
					<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_lossPrice}" pattern="#,###" /></b></td>
					<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_remainPrice}" pattern="#,###" /></b></td>
					<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_responPrice}" pattern="#,###" /></b></td>
			</tr>
			<tr>
				<th><b>자기부담금</b></th>
				<td colspan="5" style="text-align: right;padding-right:5px;">${rptIssueMain.amtSelfPayUnit} <fmt:formatNumber value="${rptIssueMain.amtSelfPay}" pattern="#,###" /></td>                	
			</tr>
			<tr>
				<th><b>비고</b></th>
				<td colspan="5" style="text-align: left;padding-left:5px;">${rptIssue.remarkVal}</td>                	
			</tr>                
		</tbody>
		</c:if>
		<c:if test="${ctype eq 'B'}">
		<colgroup>
			<col width="20%">
			<col width="20%">
			<col width="20%">
			<col width="20%">
			<col width="20%">			
		</colgroup>                
		<tbody>
			<tr>
				<th><b>구분</b></th>
				<th><b>보상한도액</b></th>
				<th><b>배상책임액</b></th>
				<th><b>자기부담금</b></th>				
				<th><b>약관상<br/>지급책임액</b></th>                	
			</tr>
			<c:forEach items="${rptIssueSummaryList}" var="item" varStatus="status">
				<tr>                	
					<td>${item.summaryCate}</td>					
					<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.compLimitPrice}" pattern="#,###" /></td>
					<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.compResponPrice}" pattern="#,###" /></td>
					<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.selfOptPrice}" pattern="#,###" /></td>					
					<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.responPrice}" pattern="#,###" /></td>
				</tr>
			</c:forEach>
			<tr>                	
					<td><b>합계</b></td>
					<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_compLimitPrice}" pattern="#,###" /></b></td>
					<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_compResponPrice}" pattern="#,###" /></b></td>
					<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_selfOptPrice}" pattern="#,###" /></b></td>
					<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_responPrice}" pattern="#,###" /></b></td>
			</tr>			
			<tr>
				<th><b>비고</b></th>
				<td colspan="5" style="text-align: left;padding-left:5px;">${rptIssue.remarkVal}</td>                	
			</tr>                
		</tbody>
		</c:if>
		<c:if test="${ctype eq 'T'}">
		<colgroup>
			<col width="15%">
			<col width="15%">
			<col width="15%">
			<col width="15%">
			<col width="15%">
			<col width="15%">
		</colgroup>                
		<tbody>
			<tr>
				<th><b>품목</b></th>
				<th><b>가입금액</b></th>
				<th><b>보험가액</b></th>
				<th><b>손해액</b></th>
				<th><b>자기부담금</b></th>
				<th><b>약관상<br/>지급책임액</b></th>                	
			</tr>
			<c:forEach items="${rptIssueSummaryList}" var="item" varStatus="status">
				<tr>                	
					<td>${item.summaryCate}</td>					
					<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.joinPrice}" pattern="#,###" /></td>
					<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.insuPrice}" pattern="#,###" /></td>
					<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.lossPrice}" pattern="#,###" /></td>
					<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.selfOptPrice}" pattern="#,###" /></td>
					<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.responPrice}" pattern="#,###" /></td>
				</tr>
			</c:forEach>
			<tr>                	
					<td><b>합계</b></td>
					<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_joinPrice}" pattern="#,###" /></b></td>
					<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_insuPrice}" pattern="#,###" /></b></td>
					<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_lossPrice}" pattern="#,###" /></b></td>
					<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_selfOptPrice}" pattern="#,###" /></b></td>
					<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_responPrice}" pattern="#,###" /></b></td>
			</tr>			
			<tr>
				<th><b>비고</b></th>
				<td colspan="5" style="text-align: left;padding-left:5px;">${rptIssue.remarkVal}</td>                	
			</tr>                
		</tbody>
		</c:if>		
	</table>
</c:if>
<c:if test="${ summary_edit_type eq 'edit' }">
	<form name="summaryEditForm" id="summaryEditForm" method="post">
	<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suimVO.suim_rpt_no}">
	<input type="hidden" id="summary_edit_type" name="summary_edit_type" value="view">
	<input type="hidden" id="ctype" name="ctype" value="${ctype}">
	<table id="table_issue_contract_edit" style="border: 1px solid currentColor;">
		<c:if test="${ctype eq 'C'}">
		<colgroup>
			<col width="15%">
			<col width="15%">
			<col width="15%">
			<col width="15%">
			<col width="15%">
			<col width="15%">
		</colgroup>                
		<tbody>
			<tr name="summary_tr">
				<th><b>목적물</b><br/>
					<img src="./resources/ls_img/btn_add_s.gif" onclick="fnSummary_add('${ctype}');" style="cursor:pointer"/>
				</th>
				<th><b>가입금액</b></th>
				<th><b>보험가액</b></th>
				<th><b>손해액</b></th>
				<th><b>잔존물</b></th>
				<th><b>약관상<br/>지급책임액</b></th>                	
			</tr>
			<c:if test="${ rowSpan eq 0 }">			
				<tr>
					<td>
						<input type="text" id="summary_cate" name="summary_cate" maxlength="7">
						<!-- <select name="summary_cate">						
							<option value="건물" selected>건물</option>
							<option value="기계">기계</option>
							<option value="동산">동산</option>
						</select> -->
					</td>					
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="join_price" name="join_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="insu_price" name="insu_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="loss_price" name="loss_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="remain_price" name="remain_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="respon_price" name="respon_price" value="0" style="text-align: right;padding-right:5px;width:86px;" onkeydown="return showKeyCode(event)"></td>
				</tr>
			</c:if>
			<c:forEach items="${rptIssueSummaryList}" var="item" varStatus="status">				
				<tr>
					<td>
						<input type="text" id="summary_cate" name="summary_cate" maxlength="7" value="${item.summaryCate}">
						<%-- <select name="summary_cate">						
							<option value="건물" <c:if test="${ item.summaryCate eq '건물' }">selected</c:if> >건물</option>
							<option value="기계" <c:if test="${ item.summaryCate eq '기계' }">selected</c:if> >기계</option>
							<option value="동산" <c:if test="${ item.summaryCate eq '동산' }">selected</c:if> >동산</option>
						</select> --%>
					</td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="join_price" name="join_price" value="${item.joinPrice}" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="insu_price" name="insu_price" value="${item.insuPrice}" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="loss_price" name="loss_price" value="${item.lossPrice}" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="remain_price" name="remain_price" value="${item.remainPrice}" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="respon_price" name="respon_price" value="${item.responPrice}" style="text-align: right;padding-right:5px;width:78px;" onkeydown="return showKeyCode(event)">
					<img src="./resources/ls_img/btn_del_s.gif" border="0" onclick="fnSummary_del('${item.suimRptNo }','${item.summaryNo}');" style="cursor:pointer" />
					</td>
				</tr>
			</c:forEach>
			<tr>                	
					<td><b>합계</b></td>
					<td style="text-align: right;padding-right:5px;"><b>${sum_joinPrice}</b></td>
					<td style="text-align: right;padding-right:5px;"><b>${sum_insuPrice}</b></td>
					<td style="text-align: right;padding-right:5px;"><b>${sum_lossPrice}</b></td>
					<td style="text-align: right;padding-right:5px;"><b>${sum_remainPrice}</b></td>
					<td style="text-align: right;padding-right:5px;"><b>${sum_responPrice}</b></td>
			</tr>
			<tr>
				<th><b>자기부담금</b></th>
				<td colspan="5" style="text-align: right;padding-right:6px;">
						<select id="amt_self_pay_unit" name="amt_self_pay_unit" style="width:100px;height:25px;">						
							<option value="￦" <c:if test="${ rptIssueMain.amtSelfPayUnit eq '￦' }">selected</c:if> >￦</option>
							<option value="$" <c:if test="${ rptIssueMain.amtSelfPayUnit eq '$' }">selected</c:if> >$</option>
							<option value="direct" <c:if test="${ rptIssueMain.amtSelfPayUnit eq '직접입력' }">selected</c:if> >직접입력</option>
						</select>
					<input type="text" id="amt_self_pay_unit_direct" style="width:100px;display:none">
					<input type="text" class="money" id="amt_self_pay" value="${rptIssueMain.amtSelfPay}" style="width:200px;text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)">					
				</td>                	
			</tr>
			<tr>
				<th><b>비고</b></th>
				<td colspan="5" style="text-align: left;padding-left:5px;">
					<input type="text" id="remark_val" value="${rptIssue.remarkVal}" style="width:520px" maxlength="150"/>
				</td>                	
			</tr>                
		</tbody>
		</c:if>
		<c:if test="${ctype eq 'B'}">
		<colgroup>
			<col width="20%">
			<col width="20%">
			<col width="20%">
			<col width="20%">
			<col width="20%">	
		</colgroup>                
		<tbody>
			<tr name="summary_tr">
				<th><b>구분</b><br/>
					<img src="./resources/ls_img/btn_add_s.gif" onclick="fnSummary_add('${ctype}');" style="cursor:pointer"/>
				</th>
				<th><b>보상한도액</b></th>
				<th><b>배상책임액</b></th>
				<th><b>자기부담금</b></th>				
				<th><b>약관상<br/>지급책임액</b></th>                	
			</tr>
			<c:if test="${ rowSpan eq 0 }">			
				<tr>
					<td>
						<input type="text" id="summary_cate" name="summary_cate" maxlength="7">
						<!-- <select name="summary_cate">						
							<option value="대인" selected>대인</option>
							<option value="대물">대물</option>
							<option value="대인&#43;대물">대인&#43;대물</option>
						</select> -->
					</td>					
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="comp_limit_price" name="comp_limit_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="comp_respon_price" name="comp_respon_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="self_opt_price" name="self_opt_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="respon_price" name="respon_price" value="0" style="text-align: right;padding-right:5px;width:100px;" onkeydown="return showKeyCode(event)"></td>
				</tr>
			</c:if>
			
			<c:forEach items="${rptIssueSummaryList}" var="item" varStatus="status">
				<tr>                	
					<td>
						<input type="text" id="summary_cate" name="summary_cate" maxlength="7" value="${item.summaryCate}">
						<%-- <select name="summary_cate">						
							<option value="대인" <c:if test="${ item.summaryCate eq '대인' }">selected</c:if> >대인</option>
							<option value="대물" <c:if test="${ item.summaryCate eq '대물' }">selected</c:if> >대물</option>
							<option value="대인&#43;대물" <c:if test="${ item.summaryCate eq '대인&#43;대물' }">selected</c:if> >대인&#43;대물</option>
						</select> --%>
					</td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="comp_limit_price" name="comp_limit_price" value="${item.compLimitPrice}" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="comp_respon_price" name="comp_respon_price" value="${item.compResponPrice}" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="self_opt_price" name="self_opt_price" value="${item.selfOptPrice}" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="respon_price" name="respon_price" value="${item.responPrice}" style="text-align: right;padding-right:5px;width:78px;" onkeydown="return showKeyCode(event)">
					<img src="./resources/ls_img/btn_del_s.gif" border="0" onclick="fnSummary_del('${item.suimRptNo }','${item.summaryNo}');" style="cursor:pointer" />
					</td>
				</tr>
			</c:forEach>
			<tr>                	
					<td><b>합계</b></td>
					<td style="text-align: right;padding-right:5px;"><b>${sum_compLimitPrice}</b></td>
					<td style="text-align: right;padding-right:5px;"><b>${sum_compResponPrice}</b></td>
					<td style="text-align: right;padding-right:5px;"><b>${sum_selfOptPrice}</b></td>
					<td style="text-align: right;padding-right:5px;"><b>${sum_responPrice}</b></td>					
			</tr>			
			<tr>
				<th><b>비고</b></th>
				<td colspan="5" style="text-align: left;padding-left:5px;">
					<input type="text" id="remark_val" value="${rptIssue.remarkVal}" maxlength="150"/>
				</td>                	
			</tr>                
		</tbody>
		</c:if>		
		<!-- 여행자보험 수정 시작 -->
		<c:if test="${ctype eq 'T'}">
		<colgroup>
			<col width="15%">
			<col width="15%">
			<col width="15%">
			<col width="15%">
			<col width="15%">
			<col width="15%">	
		</colgroup>                
		<tbody>
			<tr name="summary_tr">
				<th><b>품목</b><br/>
					<img src="./resources/ls_img/btn_add_s.gif" onclick="fnSummary_add('${ctype}');" style="cursor:pointer"/>
				</th>				
				<th><b>가입금액</b></th>
				<th><b>보험가액</b></th>
				<th><b>손해액</b></th>
				<th><b>자기부담금</b></th>
				<th><b>약관상<br/>지급책임액</b></th>                	
			</tr>
			<c:if test="${ rowSpan eq 0 }">			
				<tr>
					<td>
						<input type="text" id="summary_cate" name="summary_cate" maxlength="7">
						<!-- <select name="summary_cate">						
							<option value="휴대품1" selected>휴대품1</option>
							<option value="휴대품2">휴대품2</option>							
						</select> -->
					</td>					
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="join_price" name="join_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="insu_price" name="insu_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="loss_price" name="loss_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="self_opt_price" name="self_opt_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="respon_price" name="respon_price" value="0" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
				</tr>
			</c:if>
			
			<c:forEach items="${rptIssueSummaryList}" var="item" varStatus="status">
				<tr>                	
					<td>
						<input type="text" id="summary_cate" name="summary_cate" maxlength="7" value="${item.summaryCate}">
						<%-- <select name="summary_cate">						
							<option value="휴대품1" <c:if test="${ item.summaryCate eq '휴대품1' }">selected</c:if> >휴대품1</option>
							<option value="휴대품2" <c:if test="${ item.summaryCate eq '휴대품2' }">selected</c:if> >휴대품2</option>							
						</select> --%>
					</td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="join_price" name="join_price" value="${item.joinPrice}" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="insu_price" name="insu_price" value="${item.insuPrice}" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="loss_price" name="loss_price" value="${item.lossPrice}" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)"></td>
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="self_opt_price" name="self_opt_price" value="${item.selfOptPrice}" style="text-align: right;padding-right:5px;" onkeydown="return showKeyCode(event)">
					<td style="text-align: right;padding-right:5px;"><input type="text" class="money" id="respon_price" name="respon_price" value="${item.responPrice}" style="text-align: right;padding-right:5px;width:78px;" onkeydown="return showKeyCode(event)">
					<img src="./resources/ls_img/btn_del_s.gif" border="0" onclick="fnSummary_del('${item.suimRptNo }','${item.summaryNo}');" style="cursor:pointer" />
					</td>
				</tr>
			</c:forEach>
			<tr>                	
					<td><b>합계</b></td>
					<td style="text-align: right;padding-right:5px;"><b>${sum_joinPrice}</b></td>
					<td style="text-align: right;padding-right:5px;"><b>${sum_insuPrice}</b></td>					
					<td style="text-align: right;padding-right:5px;"><b>${sum_lossPrice}</b></td>
					<td style="text-align: right;padding-right:5px;"><b>${sum_selfOptPrice}</b></td>
					<td style="text-align: right;padding-right:5px;"><b>${sum_responPrice}</b></td>					
			</tr>			
			<tr>
				<th><b>비고</b></th>
				<td colspan="5" style="text-align: left;padding-left:5px;">
					<input type="text" id="remark_val" value="${rptIssue.remarkVal}" maxlength="150"/>
				</td>                	
			</tr>                
		</tbody>
		</c:if>
	</table>
	</form>
</c:if>
