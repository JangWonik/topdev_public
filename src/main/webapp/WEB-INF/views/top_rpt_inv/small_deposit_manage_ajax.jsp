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
<script src="./resources/ne_js/calendar-rptinv.js"></script>
<link href="./resources/select2/select2.min.css" rel="stylesheet" />
<script src="./resources/select2/select2.min.js"></script>
</head>
<div class= "tableStyle2">
	<!-- 검색 결과 테이블 시작-->
	<table>									
		<tr>
			<th height="28px" width="50px">No</th>			
			<c:choose>
				<c:when test='${param.ptnrOrder == "ASC"}'>
					<th width="170px"><a href="javascript:doOrderPtnrName('');">보험사(거래처) ▲</a></th>
				</c:when>
				<c:when test='${param.ptnrOrder == "DESC"}'>
					<th width="170px"><a href="javascript:doOrderPtnrName('ASC');">보험사(거래처) ▼</a></th>
				</c:when>
				<c:otherwise>
					<th width="170px"><a href="javascript:doOrderPtnrName('DESC');"><font color="blue">보험사(거래처)</font></a></th>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test='${param.incomeAmountOrder == "ASC"}'>
					<th width="100px"><a href="javascript:doOrderIncomeAmount('');">입금금액 ▲</a></th>
				</c:when>
				<c:when test='${param.incomeAmountOrder == "DESC"}'>
					<th width="100px"><a href="javascript:doOrderIncomeAmount('ASC');">입금금액 ▼</a></th>
				</c:when>
				<c:otherwise>
					<th width="100px"><a href="javascript:doOrderIncomeAmount('DESC');"><font color="blue">입금금액</font></a></th>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test='${param.taxAmountOrder == "ASC"}'>
					<th width="100px"><a href="javascript:doOrderTaxAmount('');">계산서금액 ▲</a></th>
				</c:when>
				<c:when test='${param.taxAmountOrder == "DESC"}'>
					<th width="100px"><a href="javascript:doOrderTaxAmount('ASC');">계산서금액 ▼</a></th>
				</c:when>
				<c:otherwise>
					<th width="100px"><a href="javascript:doOrderTaxAmount('DESC');"><font color="blue">계산서금액</font></a></th>
				</c:otherwise>
			</c:choose>			
			<c:choose>
				<c:when test='${param.incomeDateOrder == "ASC"}'>
					<th width="100px"><a href="javascript:doOrderIncomeDate('');">입금일자 ▲</a></th>
				</c:when>
				<c:when test='${param.incomeDateOrder == "DESC"}'>
					<th width="100px"><a href="javascript:doOrderIncomeDate('ASC');">입금일자 ▼</a></th>
				</c:when>
				<c:otherwise>
					<th width="100px"><a href="javascript:doOrderIncomeDate('DESC');"><font color="blue">입금일자</font></a></th>
				</c:otherwise>
			</c:choose>			
			<c:choose>
				<c:when test='${param.regDateOrder == "ASC"}'>
					<th width="90px"><a href="javascript:doOrderRegDate('');">등록일 ▲</a></th>
				</c:when>
				<c:when test='${param.regDateOrder == "DESC"}'>
					<th width="90px"><a href="javascript:doOrderRegDate('ASC');">등록일 ▼</a></th>
				</c:when>
				<c:otherwise>
					<th width="90px"><a href="javascript:doOrderRegDate('DESC');"><font color="blue">등록일</font></a></th>
				</c:otherwise>
			</c:choose>
			<th width="70px">등록자</th>
			<th width="80px">최종수정일</th>
			<th width="80px">최종수정자</th>
			<th width="210px">비고</th>
			<th width="140px">-</th>			
			<th width="17px"></th>
		</tr>									
	</table>
</div>
<c:choose>
	<c:when test="${depositList.size() < 23}">
		<div class= "tableStyle2" style="border-top:0px;">
	</c:when>		
	<c:otherwise>
		<div class= "tableStyle2" style="border-top:0px;overflow-x:hidden;overflow-y:scroll;height:660px;">
	</c:otherwise>
</c:choose>
	<table>
		<c:choose>
			<c:when test="${depositList.size() == 0}">
				<tr>
					<td colspan="11">검색결과가 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
			</c:otherwise>
		</c:choose>
		<c:forEach items="${depositList}" var="item" varStatus="status">
			<c:set var="idx" value="${depositList.size() - status.index}"/>
			<tr id="view_${item.dkey}" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''">
				<!-- No -->
				<td width="50px">${idx}</td>
				<!-- 보험사(거래처) -->
				<td width="170px">${item.ptnr_name}</td>
				<!-- 입금금액 -->
				<td width="95px" style="text-align:right;padding-right:5px;">
					<fmt:formatNumber value="${item.income_amount}" pattern="###,###,##0.##"/>
				</td>
				<!-- 계산서금액 -->
				<td width="95px" style="text-align:right;padding-right:5px;">
					<fmt:formatNumber value="${item.tax_amount}" pattern="###,###,##0.##"/>
				</td>
				<!-- 입금일자 -->
				<td width="100px">${item.income_date_fmt}</td>
				<!-- 등록일 -->
				<td width="90px">${item.reg_date_fmt}</td>
				<!-- 등록자 -->				
				<td width="70px">${item.reg_user_name}</td>
				<!-- 최종수정일 -->
				<td width="80px">${item.modify_date_fmt}</td>
				<!-- 최종수정자 -->
				<td width="80px">${item.modify_user_name}</td>
				<!-- 비고-->
				<td width="205px" style="text-align:left;padding-left:5px;" title="${item.extra_memo}">
					<c:choose>
						<c:when test="${fn:length(item.extra_memo) > 16}">
							${fn:substring(item.extra_memo,0,16)}...
						</c:when>
						<c:otherwise>${item.extra_memo}</c:otherwise>
					</c:choose>					
				</td>
				<!-- 수정, 삭제 기능버튼 -->
				<td width="140px">
					<input title="수정" class="buttonAssistanceMember" type="button" value="수 정" style="width:60px;height:20px;background:#00a000;" onclick="javascrip:doDepositModify('${item.dkey}');">&nbsp;
					<input title="삭제" class="buttonAssistanceMember" type="button" value="삭 제" style="width:60px;height:20px;background:#FF3333;" onclick="javascrip:doDepositDelete('${item.dkey}','${idx}');">
				</td>				
				<c:if test="${depositList.size() < 23}">
					<td width="17px"></td>
				</c:if>				
			</tr>			
			<tr id="edit_${item.dkey}" style="display:none;background:#FFECEC;">
				<!-- No -->
				<td width="50px">${idx}</td>
				<!-- 보험사(거래처) -->
				<td width="170px">
					<select id="editPtnrSearch_${item.dkey}" name="editPtnrSearch_${item.dkey}" style="width:160px;" tabindex=0>
						<option value="0" selected>전체</option>
						<c:forEach items="${ptnrList}" var = "ptnrVo">
							<option value="${ptnrVo.ptnr_id}"
								<c:if test="${item.ptnr_id == ptnrVo.ptnr_id}">selected</c:if>
							>
								<c:if test="${ptnrVo.ptnr_level == 1}">&nbsp;└</c:if>
								${ptnrVo.ptnr_nick}
							</option>
						</c:forEach>
					</select>
				</td>
				<!-- 입금금액 -->
				<td width="95px" style="text-align:right;padding-right:5px;">
					<input type="text" class="money" id="editIncomeAmount_${item.dkey}" name="editIncomeAmount_${item.dkey}" value="${item.income_amount}" style="width:80px;text-align: right;padding-right:5px;" tabindex=5/>
				</td>
				<!-- 입금금액 -->
				<td width="95px" style="text-align:right;padding-right:5px;">
					<input type="text" class="money" id="editTaxAmount_${item.dkey}" name="editTaxAmount_${item.dkey}" value="${item.tax_amount}" style="width:80px;text-align: right;padding-right:5px;" tabindex=6/>
				</td>
				<!-- 입금일자 -->
				<td width="100px">					
					<input	type="text" class="classCalendar" id="editIncomeDate_${item.dkey}" name="editIncomeDate_${item.dkey}" value="${item.income_date_fmt}" size="10" maxlength="10" tabindex=7/>					
				</td>
				<!-- 등록일 -->
				<td width="90px">${item.reg_date_fmt}</td>
				<!-- 등록자 -->				
				<td width="70px">${item.reg_user_name}</td>
				<!-- 최종수정일 -->
				<td width="80px">${item.modify_date_fmt}</td>
				<!-- 최종수정자 -->
				<td width="80px">${item.modify_user_name}</td>
				<!-- 비고-->
				<td width="205px" style="text-align:left;padding-left:5px;">
					<input type="text" id="editExtraMemo_${item.dkey}" name="editExtraMemo_${item.dkey}" value="${item.extra_memo}" style="width:95%;" tabindex=8/>
				</td>
				<!-- 수정, 삭제 기능버튼 -->
				<td width="140px">
					<input title="저 장" class="buttonAssistanceMember" type="button" value="저 장" style="width:60px;height:20px;" onclick="javascrip:doDepositModifySave('${item.dkey}');">&nbsp;
					<input title="취 소" class="buttonAssistanceMember" type="button" value="취 소" style="width:60px;height:20px;background:#FFA500;" onclick="javascrip:doDepositModifyCancel('${item.dkey}');">
				</td>				
				<c:if test="${depositList.size() < 23}">
					<td width="17px"></td>
				</c:if>
			</tr>
			<c:set var="sum_income_amount" value="${sum_income_amount + item.income_amount}"></c:set>
			<c:set var="sum_tax_amount" value="${sum_tax_amount + item.tax_amount}"></c:set>
		</c:forEach>
	</table>
</div>
<div class="tableStyle2" style="border:0px;">
	<!-- 합계 테이블 시작-->
	<table>
		<tr>
			<th height="28px" width="228px"><font color="red">목록 금액 합계</font></th>			
			<th width="99px" style="text-align:right;padding-right:5px;font-color:red;">
				<font color="red"><fmt:formatNumber value="${sum_income_amount}" pattern="###,###,##0.##"/></font>
			</th>
			<th width="99px" style="text-align:right;padding-right:5px;font-color:red;">
				<font color="red"><fmt:formatNumber value="${sum_tax_amount}" pattern="###,###,##0.##"/></font>
			</th>
			<th></th>
		</tr>									
	</table>
	<!-- 합계 테이블 끝-->
</div>