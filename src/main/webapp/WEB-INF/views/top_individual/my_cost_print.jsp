<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<script src="./resources/jquery/jquery.min_1_12.js"></script>
<style type="text/css">
<!--
td {color:#000000; font-size:9pt; line-height:130%; margin-top:0; margin-bottom:0; font-family:돋음,돋음체;}
p {color:#000000; font-size:9pt; line-height:130%; margin-top:0; margin-bottom:0; font-family:돋음,돋음체;}
table {border-collapse:collapse;border-spacing:0; font-size:9pt;}
.td {border:1px solid #000000; padding:3px;}

body {
background-color:#ffffff;
color:#000000;
font-family:굴림,굴림체;
font-size:9pt;
margin-left:0;margin-right:0;margin-top:0;margin-bottom:0;
border: 1px #000000; color: #000000;
}
-->
</style>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<table align="center" cellpadding="0" cellspacing="0" width="800">
	<tr>
		<td width="100%" height="100%" valign="top">
			<table cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td valign="bottom">
						<p><b><u>${team_name}&nbsp;${user_name}</u></b></p>
						<table cellpadding="0" cellspacing="0" width="400" bordercolordark="white" bordercolorlight="#CCCCCC">
							<tr>
								<td bgcolor="#F8F8F8" class="td" width="80">
									<p align="center">담당</p>
								</td>
								<td bgcolor="#F8F8F8" class="td" width="80">
									<p align="center">팀장</p>
								</td>
								<td bgcolor="#F8F8F8" class="td" width="80">
									<p align="center">센터장</p>
								</td>
								<td bgcolor="#F8F8F8" class="td" width="80">
									<p align="center">총괄</p>
								</td>
								<td bgcolor="#F8F8F8" class="td" width="80">
									<p align="center">본부장</p>
								</td>
							</tr>
							<tr>
								<td class="td" width="80" height="50">
									<p align="center">&nbsp;</p>
								</td>
								<td class="td" width="80" height="50">
									<p align="center">&nbsp;</p>
								</td>
								<td class="td" width="80" height="50">
									<p align="center">&nbsp;</p>
								</td>
								<td class="td" width="80" height="50">
									<p align="center">&nbsp;</p>
								</td>
								<td class="td" width="80" height="50">
									<p align="center">&nbsp;</p>
								</td>
							</tr>
						</table>
					</td>
					
					<td width="300" valign="bottom">
                        <p><b><u>재경팀</u></b></p>
                        <div align="right">
				            <table cellpadding="0" cellspacing="0" width="320" bordercolordark="white" bordercolorlight="#CCCCCC">
				                <tr>
				                    <td bgcolor="#F8F8F8" class="td" width="80">
				                        <p align="center">담당</p>
				                    </td>
				                    <td bgcolor="#F8F8F8" class="td" width="80">
				                        <p align="center">팀장</p>
				                    </td>
				                    <td bgcolor="#F8F8F8" class="td" width="80">
				                        <p align="center">본부장</p>
				                    </td>
				                    <td bgcolor="#F8F8F8" class="td" width="80">
				                        <p align="center">사장</p>
				                    </td>
				                </tr>
				                <tr>
				                    <td class="td" height="50" width="80">
										<p align="center">&nbsp;</p>
				                    </td>
				                    <td class="td" height="50" width="80">
										<p align="center">&nbsp;</p>
				                    </td>
				                    <td class="td" height="50" width="80">
										<p align="center">&nbsp;</p>
				                    </td>
				                    <td class="td" height="50" width="80">
										<p align="center">&nbsp;</p>
				                    </td>
				                </tr>
				            </table>
                        </div>
                    </td>
                </tr>
            </table>
            
            <p style="line-height:50%; margin-top:0; margin-bottom:0;">&nbsp;</p>
            
			<table cellpadding="0" cellspacing="0" width="100%" bordercolordark="white" bordercolorlight="#CCCCCC">
				<tr>
					<td bgcolor="#FFE69E" class="td" colspan="10">
						<p>경비내역 카드지출분</p>
					</td>
				</tr>
				<tr>
					<td bgcolor="#F8F8F8" class="td">
						<p align="center">일자</p>
					</td>
					<td bgcolor="#F8F8F8" class="td">
						<p align="center">계정명</p>
					</td>
					<td bgcolor="#F8F8F8" class="td">
						<p align="center">지급처</p>
					</td>
					<td bgcolor="#F8F8F8" class="td">
						<p align="center">관련회사</p>
					</td>
					<td bgcolor="#F8F8F8" class="td">
						<p align="center">면담자</p>
					</td>
					<td bgcolor="#F8F8F8" class="td" colspan="2">
						<p align="center">비고</p>
					</td>
					<td bgcolor="#F8F8F8" class="td" width="100">
						<p align="center">영수증</p>
					</td>
					<td bgcolor="#F8F8F8" class="td" colspan="2">
						<p align="center">지급금액</p>
					</td>
				</tr>
				<c:set value="0" var="tmpFlag1"/>
				<c:set value="0" var="tmpFlag2"/>
				<c:set value="0" var="tmpFlag3"/>
				<c:forEach items="${selCardList}" var="cardVO" varStatus="status">
					<c:if test="${status.index == 0}">
						<c:set var="tmpFlag1" value="${cardVO.getCost_class_no()}" />
					</c:if>
					<c:set var="tmpFlag2" value="${cardVO.getCost_class_no()}" />
					
					<c:if test="${(tmpFlag1 != tmpFlag2)}">
						<tr bgcolor="#E7ECF1">
							<td class="td" colspan="7" align="right"><b>소계</b></td>
							<td class="td" align="center"><fmt:formatNumber value="${tmpSum1}" pattern="###,###,##0.##"/> ea</td>
							<td class="td" align="right" colspan="2"><fmt:formatNumber value="${tmpSum2}" pattern="###,###,##0.##"/> 원</td>
						</tr>
						<c:set var="tmpFlag1" value="${cardVO.getCost_class_no()}" />
						<c:set var="tmpFlag2" value="${cardVO.getCost_class_no()}" />
						<c:set var="tmpSum1" value="0" />
						<c:set var="tmpSum2" value="0" />
						<c:set var="tmpSum3" value="0" />
					</c:if>
					<tr>
						<td class="td">
							<p align="center">${cardVO.getCost_occur_date()}</p>
						</td>
						<td class="td">
							<c:if test="${cardVO.getCost_class_no() eq 11}"><p align="center">대중교통비</p></c:if>
							<c:if test="${cardVO.getCost_class_no() eq 21}"><p align="center">유류대</p></c:if>
							<c:if test="${cardVO.getCost_class_no() eq 31}"><p align="center">주차비</p></c:if>
							<c:if test="${cardVO.getCost_class_no() eq 41}"><p align="center">통행료</p></c:if>
							<c:if test="${cardVO.getCost_class_no() eq 51}"><p align="center">숙박비</p></c:if>
							<c:if test="${cardVO.getCost_class_no() eq 61}"><p align="center">회식대</p></c:if>
							<c:if test="${cardVO.getCost_class_no() eq 71}"><p align="center">식대</p></c:if>
							<c:if test="${cardVO.getCost_class_no() eq 81}"><p align="center">업무협의비</p></c:if>
							<c:if test="${cardVO.getCost_class_no() eq 91}"><p align="center">물품구입비</p></c:if>
							<c:if test="${cardVO.getCost_class_no() eq 101}"><p align="center">우편요금</p></c:if>
							<c:if test="${cardVO.getCost_class_no() eq 111}"><p align="center">통신료</p></c:if>
							<c:if test="${cardVO.getCost_class_no() eq 121}"><p align="center">문서발급비</p></c:if>
							<c:if test="${cardVO.getCost_class_no() eq 131}"><p align="center">수도광열비</p></c:if>
						</td>
						<td class="td"><p align="center"><c:out value="${cardVO.getCost_pay_place()}"/></p></td>
						<td class="td"><p align="center"><c:out value="${cardVO.getCost_involved_com()}"/></p></td>
						<td class="td"><p align="center"><c:out value="${cardVO.getCost_involved_man()}"/></p></td>
						<td class="td" colspan="2"><p align="center"><c:out value="${cardVO.getCost_memo()}"/></p></td>
						<td class="td"><p align="center"><c:out value="${cardVO.getCost_bill_ea()}"/> ea</p></td>
						<td class="td" colspan="10">
							<p align="right">
								<fmt:formatNumber value="${cardVO.getCost_pay_amt()}" pattern="###,###,##0.##"/> 원
							</p>
						</td>
						
					</tr>
					<c:set var="sum_cost_bill_ea" value="${cardVO.cost_bill_ea + sum_cost_bill_ea}" />
					<c:set var="sum_cost_pay_amt" value="${cardVO.cost_pay_amt + sum_cost_pay_amt}" />
					<c:set var="sum_cost_deposit_amt" value="${cardVO.cost_deposit_amt + sum_cost_deposit_amt}" />
					<c:set var="var_cost_aprv_state" value="${cardVO.cost_aprv_state}" />
					<c:set var="tmpSum1" value="${tmpSum1 + cardVO.getCost_bill_ea()}" />
					<c:set var="tmpSum2" value="${tmpSum2 + cardVO.getCost_pay_amt()}" />
					<c:set var="tmpSum3" value="${tmpSum3 + cardVO.cost_deposit_amt}" />
				</c:forEach>
				<tr bgcolor="#E7ECF1">
					<td class="td" align="right" colspan="7"><b>소계</b></td>
					<td class="td" align="center"><fmt:formatNumber value="${tmpSum1}" pattern="###,###,##0.##"/> ea</td>
					<td class="td" align="right" colspan="2"><fmt:formatNumber value="${tmpSum2}" pattern="###,###,##0.##"/> 원</td>
				</tr>
				
				<tr>
					<td class="td" colspan="7" bgcolor="#F8F8F8">
						<p align="right"><B><font color="black">합 계</font></B></p>
					</td>
					<td class="td">
						<c:choose>
							<c:when test="${getMyCostCardSum.sum_cost_bill_ea eq 0}">
							</c:when>
							<c:otherwise>
								<p align="center"><c:out value="${getMyCostCardSum.sum_cost_bill_ea}"/> ea</p>
							</c:otherwise>
						</c:choose>
					</td>
					 
					<td class="td" colspan="2">
						<c:choose>
							<c:when test="${getMyCostCardSum.sum_cost_pay_amt eq 0}">
							</c:when>
							<c:otherwise>
								<p align="right">
									<fmt:formatNumber value="${getMyCostCardSum.sum_cost_pay_amt}" pattern="###,###,##0.##"/> 원
								</p>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
	
				<tr>
					<td bgcolor="#FFE69E" class="td" colspan="10">
						<p>경비내역 현금지출분</p>
					</td>
				</tr>
				
				<tr>
					<td bgcolor="#F8F8F8" class="td">
						<p align="center">일자</p>
					</td>
					<td bgcolor="#F8F8F8" class="td">
						<p align="center">계정명</p>
					</td>
					<td bgcolor="#F8F8F8" class="td">
						<p align="center">지급처</p>
					</td>
					<td bgcolor="#F8F8F8" class="td">
						<p align="center">관련회사</p>
					</td>
					<td bgcolor="#F8F8F8" class="td">
						<p align="center">면담자</p>
					</td>
					<td bgcolor="#F8F8F8" class="td" colspan="2">
						<p align="center">비고</p>
					</td>
					<td bgcolor="#F8F8F8" class="td">
						<p align="center">영수증</p>
					</td>
					<td bgcolor="#F8F8F8" class="td" colspan="2">
						<p align="center">지급금액</p>
					</td>
				</tr>
				<c:set value="0" var="tmpFlagCash1"/>
				<c:set value="0" var="tmpFlagCash2"/>
				<c:set value="0" var="tmpFlagCash3"/>
				<c:forEach items="${selCashList}" var="cashVO" varStatus="status">
					<c:if test="${status.index == 0}">
						<c:set var="tmpFlagCash1" value="${cashVO.getCost_class_no()}" />
					</c:if>
					<c:set var="tmpFlagCash2" value="${cashVO.getCost_class_no()}" />
					<c:if test="${(tmpFlagCash1 != tmpFlagCash2)}">
						<tr bgcolor="#E7ECF1">
							<td class="td" colspan="7" align="right"><b>소계</b></td>
							<td class="td" align="center"><fmt:formatNumber value="${tmpSumCash1}" pattern="###,###,##0.##"/> ea</td>
							<td class="td" align="right" colspan="2"><fmt:formatNumber value="${tmpSumCash2}" pattern="###,###,##0.##"/> 원</td>
						</tr>
						<c:set var="tmpFlagCash1" value="${cashVO.getCost_class_no()}" />
						<c:set var="tmpFlagCash2" value="${cashVO.getCost_class_no()}" />
						<c:set var="tmpSumCash1" value="0" />
						<c:set var="tmpSumCash2" value="0" />
						<c:set var="tmpSumCash3" value="0" />
					</c:if>
					<tr>
						<td class="td">
							<p align="center">${cashVO.getCost_occur_date()}</p>
						</td>
						<td class="td">
							<c:if test="${cashVO.getCost_class_no() eq 11}"><p align="center">대중교통비</p></c:if>
							<c:if test="${cashVO.getCost_class_no() eq 21}"><p align="center">유류대</p></c:if>
							<c:if test="${cashVO.getCost_class_no() eq 31}"><p align="center">주차비</p></c:if>
							<c:if test="${cashVO.getCost_class_no() eq 41}"><p align="center">통행료</p></c:if>
							<c:if test="${cashVO.getCost_class_no() eq 51}"><p align="center">숙박비</p></c:if>
							<c:if test="${cashVO.getCost_class_no() eq 61}"><p align="center">회식대</p></c:if>
							<c:if test="${cashVO.getCost_class_no() eq 71}"><p align="center">식대</p></c:if>
							<c:if test="${cashVO.getCost_class_no() eq 81}"><p align="center">업무협의비</p></c:if>
							<c:if test="${cashVO.getCost_class_no() eq 91}"><p align="center">물품구입비</p></c:if>
							<c:if test="${cashVO.getCost_class_no() eq 101}"><p align="center">우편요금</p></c:if>
							<c:if test="${cashVO.getCost_class_no() eq 111}"><p align="center">통신료</p></c:if>
							<c:if test="${cashVO.getCost_class_no() eq 121}"><p align="center">문서발급비</p></c:if>
							<c:if test="${cashVO.getCost_class_no() eq 131}"><p align="center">수도광열비</p></c:if>
						</td>
						<td class="td"><p align="center"><c:out value="${cashVO.getCost_pay_place()}"/></p></td>
						<td class="td"><p align="center"><c:out value="${cashVO.getCost_involved_com()}"/></p></td>
						<td class="td"><p align="center"><c:out value="${cashVO.getCost_involved_man()}"/></p></td>
						<td class="td" colspan="2"><p align="center"><c:out value="${cashVO.getCost_memo()}"/></p></td>
						<td class="td"><p align="center"><c:out value="${cashVO.getCost_bill_ea()}"/> ea</p></td>
						<td class="td" colspan="2">
							<p align="right">
								<fmt:formatNumber value="${cashVO.getCost_pay_amt()}" pattern="###,###,##0.##"/> 원
							</p>
						</td>
					</tr>
					<c:set var="sum_cost_bill_ea" value="${cashVO.cost_bill_ea + sum_cost_bill_ea}" />
					<c:set var="sum_cost_pay_amt" value="${cashVO.cost_pay_amt + sum_cost_pay_amt}" />
					<c:set var="sum_cost_deposit_amt" value="${cashVO.cost_deposit_amt + sum_cost_deposit_amt}" />
					<c:set var="var_cost_aprv_state" value="${cashVO.cost_aprv_state}" />
					<c:set var="tmpSumCash1" value="${tmpSumCash1 + cashVO.getCost_bill_ea()}" />
					<c:set var="tmpSumCash2" value="${tmpSumCash2 + cashVO.getCost_pay_amt()}" />
					<c:set var="tmpSumCash3" value="${tmpSumCash3 + cashVO.cost_deposit_amt}" />
				</c:forEach>
				<tr bgcolor="#E7ECF1">
						<td class="td" align="right" colspan="7"><b>소계</b></td>
						<td class="td" align="center"><fmt:formatNumber value="${tmpSumCash1}" pattern="###,###,##0.##"/> ea</td>
						<td class="td" align="right" colspan="2"><fmt:formatNumber value="${tmpSumCash2}" pattern="###,###,##0.##"/> 원</td>
					</tr>
				<tr>
				
				<td class="td" colspan="7" bgcolor="#F8F8F8">
					<p align="right"><B><font color="black">합 계</font></B></p>
				</td>
				
		<td class="td" >
			<c:choose>
				<c:when test="${getMyCostCashSum.sum_cost_bill_ea eq 0}">
				</c:when>
				<c:otherwise>
					<p align="center"><c:out value="${getMyCostCashSum.sum_cost_bill_ea}"/> ea</p>
				</c:otherwise>
			</c:choose>
		</td>
		<td class="td" colspan="2">
			<c:choose>
				<c:when test="${getMyCostCashSum.sum_cost_pay_amt eq 0}">
				</c:when>
				<c:otherwise>
					<p align="right"><fmt:formatNumber value="${getMyCostCashSum.sum_cost_pay_amt}" pattern="###,###,##0.##"/> 원</p>
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	
	<tr>
		<td bgcolor="#FFE69E" class="td" colspan="10">
			<p>추가경비내역 카드지출분</p>
		</td>
	</tr>
	<tr>
	<td bgcolor="#F8F8F8" class="td">
		<p align="center">일자</p>
	</td>
	<td bgcolor="#F8F8F8" class="td">
		<p align="center">신청일자</p>
	</td>
	<td bgcolor="#F8F8F8" class="td">
		<p align="center">계정명</p>
	</td>
	<td bgcolor="#F8F8F8" class="td">
		<p align="center">지급처</p>
	</td>
	<td bgcolor="#F8F8F8" class="td">
		<p align="center">관련회사</p>
	</td>
	<td bgcolor="#F8F8F8" class="td">
		<p align="center">면담자</p>
	</td>
	<td bgcolor="#F8F8F8" class="td" width="100">
		<p align="center">비고</p>
	</td>
	<td bgcolor="#F8F8F8" class="td" width="80">
		<p align="center">영수증</p>
	</td>
	<td bgcolor="#F8F8F8" class="td" colspan="2">
		<p align="center">지급금액</p>
	</td>
</tr>
<c:set value="0" var="tmpAddFlag1"/>
<c:set value="0" var="tmpAddFlag2"/>
<c:set value="0" var="tmpAddFlag3"/>
<c:forEach items="${selAddCardList}" var="cardVO" varStatus="status">
	<c:if test="${status.index == 0}">
		<c:set var="tmpAddFlag1" value="${cardVO.getCost_class_no()}" />
	</c:if>
	<c:set var="tmpAddFlag2" value="${cardVO.getCost_class_no()}" />
	
	<c:if test="${(tmpAddFlag1 != tmpAddFlag2)}">
		<tr bgcolor="#E7ECF1">
			<td class="td" colspan="7" align="right"><b>소계</b></td>
			<td class="td" align="center"><fmt:formatNumber value="${tmpAddSum1}" pattern="###,###,##0.##"/> ea</td>
			<td class="td" align="right" colspan="2"><fmt:formatNumber value="${tmpAddSum2}" pattern="###,###,##0.##"/> 원</td>
		</tr>
		<c:set var="tmpAddFlag1" value="${cardVO.getCost_class_no()}" />
		<c:set var="tmpAddFlag2" value="${cardVO.getCost_class_no()}" />
		<c:set var="tmpAddSum1" value="0" />
		<c:set var="tmpAddSum2" value="0" />
		<c:set var="tmpAddSum3" value="0" />
	</c:if>
	<tr>
		<td class="td"><p align="center">${cardVO.getCost_occur_date()}</p></td>
		<td class="td"><p align="center">${cardVO.getCost_reg_date()}</p></td>
		<td class="td">
			<c:if test="${cardVO.getCost_class_no() eq 11}"><p align="center">대중교통비</p></c:if>
			<c:if test="${cardVO.getCost_class_no() eq 21}"><p align="center">유류대</p></c:if>
			<c:if test="${cardVO.getCost_class_no() eq 31}"><p align="center">주차비</p></c:if>
			<c:if test="${cardVO.getCost_class_no() eq 41}"><p align="center">통행료</p></c:if>
			<c:if test="${cardVO.getCost_class_no() eq 51}"><p align="center">숙박비</p></c:if>
			<c:if test="${cardVO.getCost_class_no() eq 61}"><p align="center">회식대</p></c:if>
			<c:if test="${cardVO.getCost_class_no() eq 71}"><p align="center">식대</p></c:if>
			<c:if test="${cardVO.getCost_class_no() eq 81}"><p align="center">업무협의비</p></c:if>
			<c:if test="${cardVO.getCost_class_no() eq 91}"><p align="center">물품구입비</p></c:if>
			<c:if test="${cardVO.getCost_class_no() eq 101}"><p align="center">우편요금</p></c:if>
			<c:if test="${cardVO.getCost_class_no() eq 111}"><p align="center">통신료</p></c:if>
			<c:if test="${cardVO.getCost_class_no() eq 121}"><p align="center">문서발급비</p></c:if>
			<c:if test="${cardVO.getCost_class_no() eq 131}"><p align="center">수도광열비</p></c:if>
		</td>
		<td class="td"><p align="center"><c:out value="${cardVO.getCost_pay_place()}"/></p></td>
		<td class="td"><p align="center"><c:out value="${cardVO.getCost_involved_com()}"/></p></td>
		<td class="td"><p align="center"><c:out value="${cardVO.getCost_involved_man()}"/></p></td>
		<td class="td"><p align="center"><c:out value="${cardVO.getCost_memo()}"/></p></td>
		<td class="td"><p align="center"><c:out value="${cardVO.getCost_bill_ea()}"/> ea</p></td>
		<td class="td" colspan="2">
			<p align="right">
				<fmt:formatNumber value="${cardVO.getCost_pay_amt()}" pattern="###,###,##0.##"/> 원
			</p>
		</td>
	</tr>
	<c:set var="sum_cost_bill_ea" value="${cardVO.cost_bill_ea + sum_cost_bill_ea}" />
	<c:set var="sum_cost_pay_amt" value="${cardVO.cost_pay_amt + sum_cost_pay_amt}" />
	<c:set var="sum_cost_deposit_amt" value="${cardVO.cost_deposit_amt + sum_cost_deposit_amt}" />
	<c:set var="var_cost_aprv_state" value="${cardVO.cost_aprv_state}" />
	<c:set var="tmpAddSum1" value="${tmpAddSum1 + cardVO.getCost_bill_ea()}" />
	<c:set var="tmpAddSum2" value="${tmpAddSum2 + cardVO.getCost_pay_amt()}" />
	<c:set var="tmpAddSum3" value="${tmpAddSum3 + cardVO.cost_deposit_amt}" />
</c:forEach>
<tr bgcolor="#E7ECF1">
	<td class="td" align="right" colspan="7"><b>소계</b></td>
	<td class="td" align="center"><fmt:formatNumber value="${tmpAddSum1}" pattern="###,###,##0.##"/> ea</td>
	<td class="td" align="right" colspan="2"><fmt:formatNumber value="${tmpAddSum2}" pattern="###,###,##0.##"/> 원</td>
</tr>

<tr>
	<td class="td" colspan="7" bgcolor="#F8F8F8">
		<p align="right"><B><font color="black">합 계</font></B></p>
	</td>
	<td class="td">
		<c:choose>
			<c:when test="${getMyCostAddCardSum.sum_cost_bill_ea eq 0}">
			</c:when>
			<c:otherwise>
				<p align="center"><c:out value="${getMyCostAddCardSum.sum_cost_bill_ea}"/> ea</p>
			</c:otherwise>
		</c:choose>
	</td>
	 
	<td class="td" colspan="2">
		<c:choose>
			<c:when test="${getMyCostAddCardSum.sum_cost_pay_amt eq 0}">
			</c:when>
			<c:otherwise>
				<p align="right">
					<fmt:formatNumber value="${getMyCostAddCardSum.sum_cost_pay_amt}" pattern="###,###,##0.##"/> 원
				</p>
			</c:otherwise>
		</c:choose>
	</td>
</tr>

		<tr>
			<td bgcolor="#FFE69E" class="td" colspan="10">
				<p>추가경비내역 현금지출분</p>
			</td>
		</tr>
				
			<tr>
				<td bgcolor="#F8F8F8" class="td">
					<p align="center">일자</p>
				</td>
				<td bgcolor="#F8F8F8" class="td">
					<p align="center">신청일자</p>
				</td>
				<td bgcolor="#F8F8F8" class="td">
					<p align="center">계정명</p>
				</td>
				<td bgcolor="#F8F8F8" class="td">
					<p align="center">지급처</p>
				</td>
				<td bgcolor="#F8F8F8" class="td">
					<p align="center">관련회사</p>
				</td>
				<td bgcolor="#F8F8F8" class="td">
					<p align="center">면담자</p>
				</td>
				<td bgcolor="#F8F8F8" class="td" width="100">
					<p align="center">비고</p>
				</td>
				<td bgcolor="#F8F8F8" class="td" width="80">
					<p align="center">영수증</p>
				</td>
				<td bgcolor="#F8F8F8" class="td" colspan="2">
					<p align="center">지급금액</p>
				</td>
			</tr>
			<c:set value="0" var="tmpFlagCash1"/>
			<c:set value="0" var="tmpFlagCash2"/>
			<c:set value="0" var="tmpFlagCash3"/>
			<c:forEach items="${selAddCashList}" var="cashVO" varStatus="status">
				<c:if test="${status.index == 0}">
					<c:set var="tmpFlagCash1" value="${cashVO.getCost_class_no()}" />
				</c:if>
				<c:set var="tmpFlagCash2" value="${cashVO.getCost_class_no()}" />
				<c:if test="${(tmpFlagCash1 != tmpFlagCash2)}">
					<tr bgcolor="#E7ECF1">
						<td class="td" colspan="7" align="right"><b>소계</b></td>
						<td class="td" align="center"><fmt:formatNumber value="${tmpAddCash1}" pattern="###,###,##0.##"/> ea</td>
						<td class="td" align="right" colspan="2"><fmt:formatNumber value="${tmpAddCash2}" pattern="###,###,##0.##"/> 원</td>
					</tr>
					<c:set var="tmpFlagCash1" value="${cashVO.getCost_class_no()}" />
					<c:set var="tmpFlagCash2" value="${cashVO.getCost_class_no()}" />
					<c:set var="tmpAddCash1" value="0" />
					<c:set var="tmpAddCash2" value="0" />
					<c:set var="tmpAddCash3" value="0" />
				</c:if>
				<tr>
					<td class="td"><p align="center">${cashVO.getCost_occur_date()}</p></td>
					<td class="td"><p align="center">${cashVO.getCost_occur_date()}</p></td>
					<td class="td">
						<c:if test="${cashVO.getCost_class_no() eq 11}"><p align="center">대중교통비</p></c:if>
						<c:if test="${cashVO.getCost_class_no() eq 21}"><p align="center">유류대</p></c:if>
						<c:if test="${cashVO.getCost_class_no() eq 31}"><p align="center">주차비</p></c:if>
						<c:if test="${cashVO.getCost_class_no() eq 41}"><p align="center">통행료</p></c:if>
						<c:if test="${cashVO.getCost_class_no() eq 51}"><p align="center">숙박비</p></c:if>
						<c:if test="${cashVO.getCost_class_no() eq 61}"><p align="center">회식대</p></c:if>
						<c:if test="${cashVO.getCost_class_no() eq 71}"><p align="center">식대</p></c:if>
						<c:if test="${cashVO.getCost_class_no() eq 81}"><p align="center">업무협의비</p></c:if>
						<c:if test="${cashVO.getCost_class_no() eq 91}"><p align="center">물품구입비</p></c:if>
						<c:if test="${cashVO.getCost_class_no() eq 101}"><p align="center">우편요금</p></c:if>
						<c:if test="${cashVO.getCost_class_no() eq 111}"><p align="center">통신료</p></c:if>
						<c:if test="${cashVO.getCost_class_no() eq 121}"><p align="center">문서발급비</p></c:if>
						<c:if test="${cashVO.getCost_class_no() eq 131}"><p align="center">수도광열비</p></c:if>
					</td>
					<td class="td"><p align="center"><c:out value="${cashVO.getCost_pay_place()}"/></p></td>
					<td class="td"><p align="center"><c:out value="${cashVO.getCost_involved_com()}"/></p></td>
					<td class="td"><p align="center"><c:out value="${cashVO.getCost_involved_man()}"/></p></td>
					<td class="td"><p align="center"><c:out value="${cashVO.getCost_memo()}"/></p></td>
					<td class="td"><p align="center"><c:out value="${cashVO.getCost_bill_ea()}"/> ea</p></td>
					<td class="td" colspan="2">
						<p align="right">
							<fmt:formatNumber value="${cashVO.getCost_pay_amt()}" pattern="###,###,##0.##"/> 원
						</p>
					</td>
				</tr>
				<c:set var="sum_cost_bill_ea" value="${cashVO.cost_bill_ea + sum_cost_bill_ea}" />
				<c:set var="sum_cost_pay_amt" value="${cashVO.cost_pay_amt + sum_cost_pay_amt}" />
				<c:set var="sum_cost_deposit_amt" value="${cashVO.cost_deposit_amt + sum_cost_deposit_amt}" />
				<c:set var="var_cost_aprv_state" value="${cashVO.cost_aprv_state}" />
				<c:set var="tmpAddCash1" value="${tmpAddCash1 + cashVO.getCost_bill_ea()}" />
				<c:set var="tmpAddCash2" value="${tmpAddCash2 + cashVO.getCost_pay_amt()}" />
				<c:set var="tmpAddCash3" value="${tmpAddCash3 + cashVO.cost_deposit_amt}" />
			</c:forEach>
			<tr bgcolor="#E7ECF1">
					<td class="td" align="right" colspan="7"><b>소계</b></td>
					<td class="td" align="center"><fmt:formatNumber value="${tmpAddCash1}" pattern="###,###,##0.##"/> ea</td>
					<td class="td" align="right" colspan="2"><fmt:formatNumber value="${tmpAddCash2}" pattern="###,###,##0.##"/> 원</td>
				</tr>
			<tr>
			
			<td class="td" colspan="7" bgcolor="#F8F8F8">
				<p align="right"><B><font color="black">합 계</font></B></p>
			</td>
			
			<td class="td">
				<c:choose>
					<c:when test="${getMyCostAddCashSum.sum_cost_bill_ea eq 0}">
					</c:when>
					<c:otherwise>
						<p align="center"><c:out value="${getMyCostAddCashSum.sum_cost_bill_ea}"/> ea</p>
					</c:otherwise>
				</c:choose>
			</td>
			<td class="td" colspan="2">
				<c:choose>
					<c:when test="${getMyCostAddCashSum.sum_cost_pay_amt eq 0}">
					</c:when>
					<c:otherwise>
						<p align="right"><fmt:formatNumber value="${getMyCostAddCashSum.sum_cost_pay_amt}" pattern="###,###,##0.##"/> 원</p>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>

	
		<tr>
			<td bgcolor="#FFE69E" class="td" colspan="10">
				<p>클레임 교통비 내역 카드지출분</p>
			</td>
		</tr>
		<tr>
			<td bgcolor="#F8F8F8" class="td">
				<p align="center">일자</p>
			</td>
			<td bgcolor="#F8F8F8" class="td">
				<p align="center">계정명</p>
			</td>
			<td bgcolor="#F8F8F8" class="td">
				<p align="center">관련회사</p>
			</td>
			<td bgcolor="#F8F8F8" class="td">
				<p align="center">면담자</p>
			</td>
			<td bgcolor="#F8F8F8" class="td">
				<p align="center">접수번호</p>
			</td>
			<td bgcolor="#F8F8F8" class="td">
				<p align="center">거리</p>
			</td>
			<td bgcolor="#F8F8F8" class="td">
				<p align="center">비고</p>
			</td>
			<td bgcolor="#F8F8F8" class="td">
				<p align="center">영수증</p>
			</td>
			<td bgcolor="#F8F8F8" class="td" colspan="2">
				<p align="center">지급금액</p>
			</td>
		</tr>
		<c:set value="0" var="tmpClaimFlag1"/>
		<c:set value="0" var="tmpClaimFlag2"/>
		<c:set value="0" var="tmpClaimFlag3"/>
	<c:forEach items="${selClaimCardList}" var="claimcardVO" varStatus="status">
		<c:if test="${status.index == 0}">
			<c:set var="tmpClaimFlag1" value="${claimcardVO.getCost_class_no_claim()}" />
		</c:if>
		<c:set var="tmpClaimFlag2" value="${claimcardVO.getCost_class_no_claim()}" />
		<c:if test="${(tmpClaimFlag1 != tmpClaimFlag2)}">
			<tr bgcolor="#E7ECF1">
				<td class="td" colspan="7" align="right"><b>소계</b></td>
				<td class="td" align="center"><fmt:formatNumber value="${tmpClaimSum1}" pattern="###,###,##0.##"/> ea</td>
				<td class="td" align="right" colspan="2"><fmt:formatNumber value="${tmpClaimSum2}" pattern="###,###,##0.##"/> 원</td>
			</tr>
			<c:set var="tmpClaimFlag1" value="${claimcardVO.getCost_class_no_claim()}" />
			<c:set var="tmpClaimFlag2" value="${claimcardVO.getCost_class_no_claim()}" />
			<c:set var="tmpClaimSum1" value="0" />
			<c:set var="tmpClaimSum2" value="0" />
			<c:set var="tmpClaimSum3" value="0" />
		</c:if>
		<tr>
			<td class="td">
				<p align="center">${claimcardVO.getCost_occur_date()}</p>
			</td>
			<td class="td">
				<c:if test="${claimcardVO.getCost_class_no_claim() eq 11}"><p align="center">유류대</p></c:if>
				<c:if test="${claimcardVO.getCost_class_no_claim() eq 21}"><p align="center">통행료</p></c:if>
				<c:if test="${claimcardVO.getCost_class_no_claim() eq 31}"><p align="center">대중교통비</p></c:if>
				
			</td>
			<td class="td"><p align="center"><c:out value="${claimcardVO.getCost_involved_com()}"/></p></td>
			<td class="td"><p align="center"><c:out value="${claimcardVO.getCost_involved_man()}"/></p></td>
			<td class="td"><p align="center"><c:out value="${claimcardVO.getCost_suim_accept_no()}"/></p></td>
			<td class="td"><p align="center"><c:out value="${claimcardVO.getCost_distance()}"/></p></td>
			<td class="td"><p align="center"><c:out value="${claimcardVO.getCost_memo()}"/></p></td>
			<td class="td"><p align="center"><c:out value="${claimcardVO.getCost_bill_ea()}"/> ea</p></td>
			<td class="td" colspan="2">
				<p align="right">
					<fmt:formatNumber value="${claimcardVO.getCost_pay_amt()}" pattern="###,###,##0.##"/> 원
				</p>
			</td>
			
		</tr>
						<c:set var="sum_cost_bill_ea" value="${claimcardVO.cost_bill_ea + sum_cost_bill_ea}" />
						<c:set var="sum_cost_pay_amt" value="${claimcardVO.cost_pay_amt + sum_cost_pay_amt}" />
						<c:set var="sum_cost_deposit_amt" value="${claimcardVO.cost_deposit_amt + sum_cost_deposit_amt}" />
						<c:set var="var_cost_aprv_state" value="${claimcardVO.cost_aprv_state}" />
						<c:set var="tmpClaimSum1" value="${tmpClaimSum1 + claimcardVO.getCost_bill_ea()}" />
						<c:set var="tmpClaimSum2" value="${tmpClaimSum2 + claimcardVO.getCost_pay_amt()}" />
						<c:set var="tmpClaimSum3" value="${tmpClaimSum3 + claimcardVO.cost_deposit_amt}" />
	</c:forEach>
		<tr bgcolor="#E7ECF1">
			<td class="td" align="right" colspan="7"><b>소계</b></td>
			<td class="td" align="center"><fmt:formatNumber value="${tmpClaimSum1}" pattern="###,###,##0.##"/> ea</td>
			<td class="td" align="right" colspan="2"><fmt:formatNumber value="${tmpClaimSum2}" pattern="###,###,##0.##"/> 원</td>
		</tr>

	<tr>
		<td class="td" colspan="7" bgcolor="#F8F8F8">
			<p align="right"><B><font color="black">합 계</font></B></p>
		</td>
		<td class="td">
			<c:choose>
				<c:when test="${getMyCostClaimCardSum.sum_cost_bill_ea eq 0}">
				</c:when>
				<c:otherwise>
					<p align="center"><c:out value="${getMyCostClaimCardSum.sum_cost_bill_ea}"/> ea</p>
				</c:otherwise>
			</c:choose>
		</td>
		<td class="td" colspan="2">
			<c:choose>
				<c:when test="${getMyCostClaimCardSum.sum_cost_pay_amt eq 0}">
				</c:when>
				<c:otherwise>
					<p align="right">
						<fmt:formatNumber value="${getMyCostClaimCardSum.sum_cost_pay_amt}" pattern="###,###,##0.##"/> 원
					</p>
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	
	<tr>
		<td bgcolor="#FFE69E" class="td" colspan="10">
			<p>클레임 교통비 내역 현금지출분</p>
		</td>
	</tr>
	<tr>
		<td bgcolor="#F8F8F8" class="td">
			<p align="center">일자</p>
		</td>
		<td bgcolor="#F8F8F8" class="td">
			<p align="center">계정명</p>
		</td>
		<td bgcolor="#F8F8F8" class="td">
			<p align="center">관련회사</p>
		</td>
		<td bgcolor="#F8F8F8" class="td">
			<p align="center">면담자</p>
		</td>
		<td bgcolor="#F8F8F8" class="td">
			<p align="center">접수번호</p>
		</td>
		<td bgcolor="#F8F8F8" class="td">
			<p align="center">거리</p>
		</td>
		<td bgcolor="#F8F8F8" class="td">
			<p align="center">비고</p>
		</td>
		<td bgcolor="#F8F8F8" class="td">
			<p align="center">영수증</p>
		</td>
		<td bgcolor="#F8F8F8" class="td" colspan="2">
			<p align="center">지급금액</p>
		</td>
	</tr>
		<c:set value="0" var="tmpClaimFlagCash1"/>
		<c:set value="0" var="tmpClaimFlagCash2"/>
		<c:set value="0" var="tmpClaimFlagCash3"/>
	<c:forEach items="${selClaimCashList}" var="claimcashVO" varStatus="status">
		<c:if test="${status.index == 0}">
			<c:set var="tmpClaimFlagCash1" value="${claimcashVO.getCost_class_no_claim()}" />
		</c:if>
		<c:set var="tmpClaimFlagCash2" value="${claimcashVO.getCost_class_no_claim()}" />
		<c:if test="${(tmpClaimFlagCash1 != tmpClaimFlagCash2)}">
			<tr bgcolor="#E7ECF1">
				<td class="td" colspan="7" align="right"><b>소계</b></td>
				<td class="td" align="center"><fmt:formatNumber value="${tmpSumCash1}" pattern="###,###,##0.##"/> ea</td>
				<td class="td" align="right" colspan="2"><fmt:formatNumber value="${tmpSumCash2}" pattern="###,###,##0.##"/> 원</td>
			</tr>
			<c:set var="tmpClaimFlagCash1" value="${claimcashVO.getCost_class_no_claim()}" />
			<c:set var="tmpClaimFlagCash2" value="${claimcashVO.getCost_class_no_claim()}" />
			<c:set var="tmpClaimSumCash1" value="0" />
			<c:set var="tmpClaimSumCash2" value="0" />
			<c:set var="tmpClaimSumCash3" value="0" />
		</c:if>
	<tr>
		<td class="td">
			<p align="center">${claimcashVO.getCost_occur_date()}</p>
		</td>
		<td class="td">
			<c:if test="${claimcashVO.getCost_class_no_claim() eq 11}"><p align="center">유류대</p></c:if>
			<c:if test="${claimcashVO.getCost_class_no_claim() eq 21}"><p align="center">통행료</p></c:if>
			<c:if test="${claimcashVO.getCost_class_no_claim() eq 31}"><p align="center">대중교통비</p></c:if>
		</td>
		<td class="td"><p align="center"><c:out value="${claimcashVO.getCost_involved_com()}"/></p></td>
		<td class="td"><p align="center"><c:out value="${claimcashVO.getCost_involved_man()}"/></p></td>
		<td class="td"><p align="center"><c:out value="${claimcashVO.getCost_suim_accept_no()}"/></p></td>
		<td class="td"><p align="center"><c:out value="${claimcashVO.getCost_distance()}"/></p></td>
		<td class="td"><p align="center"><c:out value="${claimcashVO.getCost_memo()}"/></p></td>
		<td class="td"><p align="center"><c:out value="${claimcashVO.getCost_bill_ea()}"/> ea</p></td>
		<td class="td" colspan="2">
			<p align="right">
				<fmt:formatNumber value="${claimcashVO.getCost_pay_amt()}" pattern="###,###,##0.##"/> 원
			</p>
		</td>
	</tr>
						<c:set var="sum_cost_bill_ea" value="${claimcashVO.cost_bill_ea + sum_cost_bill_ea}" />
						<c:set var="sum_cost_pay_amt" value="${claimcashVO.cost_pay_amt + sum_cost_pay_amt}" />
						<c:set var="sum_cost_deposit_amt" value="${claimcashVO.cost_deposit_amt + sum_cost_deposit_amt}" />
						<c:set var="var_cost_aprv_state" value="${claimcashVO.cost_aprv_state}" />
						<c:set var="tmpClaimSumCash1" value="${tmpClaimSumCash1 + claimcashVO.getCost_bill_ea()}" />
						<c:set var="tmpClaimSumCash2" value="${tmpClaimSumCash2 + claimcashVO.getCost_pay_amt()}" />
						<c:set var="tmpClaimSumCash3" value="${tmpClaimSumCash3 + claimcashVO.cost_deposit_amt}" />
	</c:forEach>
	<tr bgcolor="#E7ECF1">
			<td class="td" align="right" colspan="7"><b>소계</b></td>
			<td class="td" align="center"><fmt:formatNumber value="${tmpClaimSumCash1}" pattern="###,###,##0.##"/> ea</td>
			<td class="td" align="right" colspan="2"><fmt:formatNumber value="${tmpClaimSumCash2}" pattern="###,###,##0.##"/> 원</td>
		</tr>
	<tr>
		<td class="td" colspan="7" bgcolor="#F8F8F8">
			<p align="right"><B><font color="black">합 계</font></B></p>
		</td>
		<td class="td">
			<c:choose>
				<c:when test="${getMyCostClaimCashSum.sum_cost_bill_ea eq 0}">
				</c:when>
				<c:otherwise>
					<p align="center"><c:out value="${getMyCostClaimCashSum.sum_cost_bill_ea}"/> ea</p>
				</c:otherwise>
			</c:choose>
		</td>
		<td class="td" colspan="2">
			<c:choose>
				<c:when test="${getMyCostClaimCashSum.sum_cost_pay_amt eq 0}">
				</c:when>
				<c:otherwise>
					<p align="right"><fmt:formatNumber value="${getMyCostClaimCashSum.sum_cost_pay_amt}" pattern="###,###,##0.##"/> 원</p>
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	
	
	<tr>
		<td class="td" colspan="7" bgcolor="#EDEDED">
			<p align="right"><B><font color="black">총 합 계</font></B></p>
		</td>
		<td class="td" bgcolor="#EDEDED">
			<c:choose>
				<c:when test="${MyCostSum.sum_cost_bill_ea eq 0}">
				</c:when>
				<c:otherwise>
					<p align="center"><c:out value="${MyCostSum.sum_cost_bill_ea}"/> ea</p>
				</c:otherwise>
			</c:choose>
		</td>
		<td class="td" bgcolor="#EDEDED" colspan="2">
			<c:choose>
				<c:when test="${MyCostSum.sum_cost_pay_amt eq 0}">
				</c:when>
				<c:otherwise>
					<p align="right"><fmt:formatNumber value="${MyCostSum.sum_cost_pay_amt}" pattern="###,###,##0.##"/> 원</p>
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
</table>




            <p>&nbsp;</p>
            <p>▣ 협조건 내역</p>
<table align="center" cellpadding="0" cellspacing="0" width="100%" bordercolordark="white" bordercolorlight="#CCCCCC">
<tr>
                    <td class="td" height="27" bgcolor="#F8F8F8">
            <p align="center"><font color="black">구분</font></p>
                    </td>
                    <td class="td" bgcolor="#F8F8F8">
            <p align="center"><font color="black">의뢰팀</font></p>
                    </td>
                    <td class="td" bgcolor="#F8F8F8">
            <p align="center"><font color="black">의뢰인</font></p>
                    </td>
                    <td class="td" bgcolor="#F8F8F8">
            <p align="center"><font color="black">수임팀</font></p>
                    </td>
                    <td class="td" bgcolor="#F8F8F8">
                                    <p align="center"><font color="black">수임인</font></p>
                    </td>
                    <td class="td" bgcolor="#F8F8F8">
            <p align="center"><font color="black">보고서번호</font></p>
                    </td>
                    <td class="td" bgcolor="#F8F8F8">
            <p align="center"><font color="black">피보험자</font></p>
                    </td>
                    <td class="td" bgcolor="#F8F8F8">
            <p align="center"><font color="black">의뢰일</font></p>
                    </td>
                    <td class="td" bgcolor="#F8F8F8">
            <p align="center"><font color="black">완료일</font></p>
                    </td>
                    <td class="td" bgcolor="#F8F8F8">
            <p align="center"><font color="black">금액</font></p>
                    </td>
                </tr>
<c:forEach items="${getMyHelpRptList}" var="clientVO">
<tr>
                    <td class="td">
            <p align="center"><font color="red">의뢰</font></p>
                    </td>
                    <td class="td">
                        <p align="center"><c:out value="${clientVO.getClient_team_nm()}"/></p>
                    </td>
                    <td class="td">
                        <p align="center"><c:out value="${clientVO.getClient_id_nm()}"/></p>
                    </td>
                    <td class="td">
<p align="center"><c:out value="${clientVO.getAccept_team_nm()}"/></p>
                    </td>
                    <td class="td">
<p align="center">
<c:out value="${clientVO.getAccept_id_nm()}"/></p>
                    </td>
                    <td class="td">
            <p align="center"><c:out value="${clientVO.getSuim_accept_no()}"/></p>
                    </td>
                    <td class="td">
            <p align="center"><c:out value="${clientVO.getBeneficiary_nm()}"/></p>
                    </td>
                    <td class="td">
<p align="center"><c:out value="${clientVO.getReg_date_fmt()}"/></p>
                    </td>
                    <td class="td">
<p align="center"><c:out value="${clientVO.getEnd_date_fmt()}"/></p>
                    </td>
                    <td class="td">
<p align="right"><font color="red"><fmt:formatNumber value="${clientVO.getPrice_total()}" pattern="###,###,##0.##"/></font></p>
</td>
</tr>
</c:forEach>
<c:forEach items="${getMyHelpRptListAccept}" var="acceptVO">
<tr>
                    <td class="td">
            <p align="center"><font color="blue">수임</font></p>
                    </td>
                    <td class="td">
                        <p align="center"><c:out value="${acceptVO.getClient_team_nm()}"/></p>
                    </td>
                    <td class="td">
                        <p align="center"><c:out value="${acceptVO.getClient_id_nm()}"/></p>
                    </td>
                    <td class="td">
<p align="center"><c:out value="${acceptVO.getAccept_team_nm()}"/></p>
                    </td>
                    <td class="td">
<p align="center">
<c:out value="${acceptVO.getAccept_id_nm()}"/></p>
                    </td>
                    <td class="td">
            <p align="center"><c:out value="${acceptVO.getSuim_accept_no()}"/></p>
                    </td>
                    <td class="td">
            <p align="center"><c:out value="${acceptVO.getBeneficiary_nm()}"/></p>
                    </td>
                    <td class="td">
<p align="center"><c:out value="${acceptVO.getReg_date_fmt()}"/></p>
                    </td>
                    <td class="td">
<p align="center"><c:out value="${acceptVO.getEnd_date_fmt()}"/></p>
                    </td>
                    <td class="td">
<p align="right"><font color="blue"><fmt:formatNumber value="${acceptVO.getPrice_total()}" pattern="###,###,##0.##"/></font></p>
</td>
</tr>
</c:forEach>


<tr>
                    <td class="td" colspan="9" bgcolor="#F8F8F8">
						<p align="right" style="margin-right:5;"><font color="black"><b>합 계</b></font></p>
                    </td>
                    <td class="td" bgcolor="#F8F8F8">
						<p align="right"><b><fmt:formatNumber value="${-getMyHelpRptListSum.price_total +getMyHelpRptListAcceptSum.price_total}" pattern="###,###,##0.##"/></b></p>
</td>
</tr>
            </table>
</td>
    </tr>
</table>
<script language="JavaScript">
window.print();
</script>
</body>

</html>
