<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE HTML>
<html lang="ko">
<head>
	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.user_no}'.trim() == ''
					|| ('${mbrVo_Session.team_id_main}' != '7'
							&& '${mbrAuthVo_Session.mbr_pms_17}' == '0' && '${mbrAuthVo_Session.mbr_pms_18}' == '0')){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}
		});//ready
		
		function doDownLoad(){			
			$("#cost_person_list_form").submit();
		}
	</script>

</head>

<body>	
	<form name="cost_person_list_form" id="cost_person_list_form" method="POST" action="/cost_person_list_excel">
		<input type="hidden" id="cost_year_month" name="cost_year_month" value="${srchArg.yearMonth}"/>								
		<input type="hidden" id="hid_bgnDe" name="hid_bgnDe" value="${srchArg.bgnDe}" />
		<input type="hidden" id="hid_endDe" name="hid_endDe" value="${srchArg.endDe}" /> 								
		<input type="hidden" id="hid_stdBgnde" name="stdBgnde" value="${srchArg.stdBgnde}" />
		<input type="hidden" id="hid_stdEndde" name="stdEndde" value="${srchArg.stdEndde}" />
	</form>
	<div style="text-align:right;padding:0 0 5px 0;">
		<img id="exceldown" style="cursor: pointer;" onclick="javascript:doDownLoad();" alt="엑셀다운로드" src="/resources/ls_img/btn_excel.gif">
	</div>	
	<div class= "tableStyle2 costTable" style="overflow:scroll;width:100%; height:600px;">
		<table>
			<tr>
				<th width="11%">팀명</th>
				<th width="11%">이름</th>
				<th width="6%">청구금액<br />(일반)</th>
				<th width="6%">청구금액<br />(추가)</th>
				<th width="6%">청구금액<br />(클레임)</th>
				<th width="6%">청구금액<br />(전체)</th>
				<th width="6%">팀장</th>
				<th width="6%">본부장</th>
				<th width="6%">자금팀 승인</th>
				<th width="6%">협조<br />(의뢰)</th>
				<th width="6%">협조<br />(수임)</th>
				<th width="6%">협조세금<br />(교통비)</th>
				<th width="6%">협조세금<br />(챠트비)</th>
				<th width="6%">입금액</th>
				<th width="6%">입금일</th>				
			</tr>
		
			<%-- <c:set var="SumBasicAmt"  value="0"/>
			<c:set var="SumAddAmt"  value="0"/>
			<c:set var="SumClaimAmt"  value="0"/>
			<c:set var="SumTotalAmt"  value="0"/>
			<c:set var="SumTmAprvAmt"  value="0"/>
			<c:set var="SumHqAprvAmt"  value="0"/>
			<c:set var="SumFinanceAprvAmt"  value="0"/>
			<c:set var="SumHelpClient"  value="0"/>
			<c:set var="SumHelpAccept"  value="0"/>
			<c:set var="SumHelpTraffic"  value="0"/>
			<c:set var="SumHelpChart"  value="0"/>
			<c:set var="SumDepositAmt"  value="0"/>	 --%>		
									
			<c:forEach items="${personList}" var="item" varStatus="status">
				<tr>
					<td>${item.team_name}</td>
					<td>${item.user_name}</td>
					<td><span class="money">${item.cost_base_deposit_amt}</span></td>
					<td><span class="money">${item.cost_addition_deposit_amt}</span></td>
					<td><span class="money">${item.cost_claim_deposit_amt}</span></td>
					<td><span class="money">${item.cost_total_amt}</span></td>
					<td>
						<span class="money">${item.tm_aprv_amt}</span>
					</td>
					<td>
						<c:choose>
							<c:when test="${item.hq_aprv_amt ne '0'}">
								<span class="money">${item.hq_aprv_amt}</span><br/>
							</c:when>
							<c:otherwise>0</c:otherwise>
						</c:choose>						
						<%-- <c:if test="${mbrAuthVo_Session.mbr_pms_18 eq '1'}">							
							<c:choose>
								<c:when test="${item.cost_aprv_state == 1}">
									<br/><img class="btn_cost_aprv" src='./resources/ls_img/top_cost/btn_sngin.gif' data-aprv_state="2" data-deposit_no="${item.cost_deposit_no}" data-user_no = "${item.user_no}" style="cursor:pointer;" />
								</c:when>
								<c:when test="${item.cost_aprv_state == 2}">
									<br/><img class="btn_cost_aprv" src='./resources/ls_img/top_cost/btn_cancel.gif' data-aprv_state="1" data-deposit_no="${item.cost_deposit_no}" data-user_no = "${item.user_no}" style="cursor:pointer;" />
								</c:when>								
							</c:choose>
						</c:if> --%>
					</td>
					<td>
						<c:choose>
							<c:when test="${item.finance_aprv_amt ne '0'}">
								<span class="money">${item.finance_aprv_amt}</span><br/>
							</c:when>
							<c:otherwise>0</c:otherwise>
						</c:choose>
						<%-- <c:if test="${mbrAuthVo_Session.mbr_pms_18 eq '1'}">					
							<c:choose>
								<c:when test="${item.cost_aprv_state == 2}">
									<br/><img class="btn_cost_aprv" src='./resources/ls_img/top_cost/btn_sngin.gif' data-aprv_state="3" data-deposit_no="${item.cost_deposit_no}" data-user_no = "${item.user_no}" style="cursor:pointer;" />
								</c:when>
								<c:when test="${item.cost_aprv_state == 3}">
									<br/><img class="btn_cost_aprv" src='./resources/ls_img/top_cost/btn_cancel.gif' data-aprv_state="2" data-deposit_no="${item.cost_deposit_no}" data-user_no = "${item.user_no}" style="cursor:pointer;" />
								</c:when>								
							</c:choose>
						</c:if>
						<!-- 1종이면서 pms18 권한이 잇는경우만 표시 -->
						<c:if test="${not empty item.cost_deposit_no && item.cost_deposit_amt eq '0' && (item.cost_deposit_no ne 3 && item.cost_aprv_state ne 4)}">													
							<c:if test="${mbrAuthVo_Session.mbr_pms_18 eq '1' && mbrVo_Session.team_type eq '0'}">
								<br/><input class="buttonAllAprv" type="button" onclick="javascript:doAllAprv('${item.cost_deposit_no}','${item.user_no}')" value="일괄승인">
							</c:if>	
						</c:if> --%>												
					</td>
					<td><span class="money">${item.help_client_traffic_fee+item.help_client_chart_fee}</span></td>
					<td><span class="money">${item.help_accept_traffic_fee+item.help_accept_chart_fee}</span></td>
					<td><fmt:formatNumber value="${item.help_accept_traffic_fee-item.help_client_traffic_fee}" pattern="###,###,##0"/></td>
					<td><fmt:formatNumber value="${item.help_accept_chart_fee-item.help_client_chart_fee}" pattern="###,###,##0"/></td>
					<td>
						<c:choose>
							<c:when test="${item.cost_deposit_amt ne '0'}">
								<span class="money">${item.cost_deposit_amt}</span>
							</c:when>
							<c:otherwise>0</c:otherwise>
						</c:choose>						
					</td>
					<td>
						<c:choose>
							<c:when test="${item.cost_deposit_date > 0}">
								${item.cost_deposit_date_fmt}
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>
						<%-- <c:if test="${mbrAuthVo_Session.mbr_pms_18 eq '1'}">							
							<c:choose>
								<c:when test="${item.cost_aprv_state == 3}">
									<br/><img class="btn_cost_settle" src='./resources/ls_img/top_cost/btn_settle.gif' data-user_no ="${item.user_no}" data-deposit_no="${item.cost_deposit_no}" data-user_no = "${item.user_no}" style="cursor:pointer;" />
								</c:when>
								<c:when test="${item.cost_aprv_state == 4}">
									<br/><img class="btn_cost_settle_cancel" src='./resources/ls_img/top_cost/btn_cancel.gif' data-aprv_state="3" data-deposit_no="${item.cost_deposit_no}"  data-user_no = "${item.user_no}" style="cursor:pointer;" />
								</c:when>
							</c:choose>
						</c:if> --%>												
					</td>																									
				</tr>
				
				<%-- <c:set var="SumBasicAmt"  value="${SumBasicAmt + item.cost_base_deposit_amt}"/>
				<c:set var="SumAddAmt"  value="${SumAddAmt + item.cost_addition_deposit_amt}"/>
				<c:set var="SumClaimAmt"  value="${SumClaimAmt + item.cost_claim_deposit_amt}"/>
				<c:set var="SumTotalAmt"  value="${SumTotalAmt + item.cost_total_amt}"/>
				
				<c:set var="SumTmAprvAmt"  value="${SumTmAprvAmt + item.tm_aprv_amt}"/>
				<c:set var="SumHqAprvAmt"  value="${SumHqAprvAmt + item.hq_aprv_amt}"/>
				<c:set var="SumFinanceAprvAmt"  value="${SumFinanceAprvAmt + item.finance_aprv_amt}"/>
				
				<c:set var="SumHelpClient"  value="${SumHelpClient +  item.help_client_traffic_fee+item.help_client_chart_fee}"/>
				<c:set var="SumHelpAccept"  value="${SumHelpAccept +  item.help_accept_traffic_fee+item.help_accept_chart_fee}"/>
				
				<c:set var="SumHelpTraffic"  value="${SumHelpTraffic +  item.help_accept_traffic_fee-item.help_client_traffic_fee}"/>
				<c:set var="SumHelpChart"  value="${SumHelpChart +  item.help_accept_chart_fee-item.help_client_chart_fee}"/>
				
				<c:set var="SumDepositAmt"  value="${SumDepositAmt+ item.cost_deposit_amt}"/> --%>
				
			</c:forEach>
			<%-- <tr style="background: #e7ecf1">		
				<td colspan="2">합계</td>
				<td><span class="money">${SumBasicAmt}</span></td>
				<td><span class="money">${SumAddAmt}</span></td>
				<td><span class="money">${SumClaimAmt}</span></td>
				<td><span class="money">${SumTotalAmt}</span></td>
				
				<td><span class="money">${SumTmAprvAmt}</span></td>
				<td><span class="money">${SumHqAprvAmt}</span></td>
				<td><span class="money">${SumFinanceAprvAmt}</span></td>
				
				<td><span class="money">${SumHelpClient}</span></td>
				<td><span class="money">${SumHelpAccept}</span></td>
				<td><span class="money">${SumHelpTraffic}</span></td>
				<td><span class="money">${SumHelpChart}</span></td>
				
				<td><span class="money">${SumDepositAmt}</span></td>
				
				<td></td>
				<td></td>
			</tr> --%>
		</table>
	</div><!-- //tableStyle2 -->
</body>

</html>
