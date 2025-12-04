<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

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
						<p>
							<b>
								${fn:substring(srchArg.cost_year_month,0,2)}년
								
								${fn:substring(srchArg.cost_year_month,2,5)}월
								   
								<u>${userInfo.team_name}&nbsp;${userInfo.user_name}</u>
							</b>
						</p>
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

			<c:set var="basicCardEaSum" 	value="0" />
			<c:set var="basicCardAmtSum" 	value="0" />
			<c:set var="basicCashEaSum" 	value="0" />
			<c:set var="basicCashAmtSum" 	value="0" />
			
			<c:set var="addCardEaSum" 		value="0" />
			<c:set var="addCardAmtSum" 		value="0" />
			<c:set var="addCashEaSum" 		value="0" />
			<c:set var="addCashAmtSum" 		value="0" />
			
			<c:set var="claimCardEaSum" 	value="0" />
			<c:set var="claimCardAmtSum" 	value="0" />
			<c:set var="claimCashEaSum" 	value="0" />
			<c:set var="claimCashAmtSum" 	value="0" />			
            
			<table cellpadding="0" cellspacing="0" width="100%" bordercolordark="white" bordercolorlight="#CCCCCC">
				<colgroup>
					<col style="width:10%;" />
					<col style="width:10%;" />
					<col style="width:14%;" />
					<col style="width:8%;" />
					<col style="width:15%;" /> 
					<col style="width:8%;" />
					<col style="width:16%;" />
					<col style="width:8%;" />
					<col style="width:12%;" />
					
				</colgroup>
				<tr>
					<td bgcolor="#FFE69E" class="td" colspan="10">
						<p>경비내역 카드지출분</p>
					</td>
				</tr>
				<tr>
					<td bgcolor="#F8F8F8" class="td">
						<p align="center">발생일자</p>
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
				
				
				<c:forEach items="${basicCardList}" var="item" varStatus="status">
					<tr>
						<td class="td"><p align="center">${item.costOccurDate}</p></td>
						<td class="td"><p align="center">${item.costClassNm}</p></td>
						<td class="td"><p align="center">${item.costPayPlace}</p></td>
						<td class="td"><p align="center">${item.costInvolvedCom}</p></td>
						<td class="td"><p align="center">${item.costInvolvedMan}</p></td>
						<td class="td" colspan="2"><p align="center">${item.costMemo}</p></td>
						<td class="td"><p align="center">${item.costBillEa} ea</p>
						<td class="td" colspan="2">
							<p align="right"> <fmt:formatNumber value="${item.costPayAmt}" pattern="###,###,##0.##"/> 원 </p>
						</td>
					</tr>
					
					<c:set var="basicCardEaSum" value="${basicCardEaSum + item.costBillEa}" />
					<c:set var="basicCardAmtSum" value="${basicCardAmtSum + item.costPayAmt}" />
					 
					<c:set var="tmpEaSum" value="${tmpEaSum + item.costBillEa}" />
					<c:set var="tmpAmtSum" value="${tmpAmtSum + item.costPayAmt}" />
					
					<c:if test="${item.costClassNo != basicCardList[status.count].costClassNo}">
						<tr bgcolor="#E7ECF1">
							<td class="td" colspan="7" align="right"><b>소계</b></td>
							<td class="td" align="center"><fmt:formatNumber value="${tmpEaSum}" pattern="###,###,##0.##"/> ea</td>
							<td class="td" align="right" colspan="2"><fmt:formatNumber value="${tmpAmtSum}" pattern="###,###,##0.##"/> 원</td>
						</tr>
						<c:set var="tmpEaSum" 	value="0" />
						<c:set var="tmpAmtSum" 	value="0" />
					</c:if>
					
				</c:forEach>
				<tr>
					<td class="td" colspan="7" bgcolor="#F8F8F8">
						<p align="right"><B><font color="black">합 계</font></B></p>
					</td>
					<td class="td" align="center">	
						<fmt:formatNumber value="${basicCardEaSum}" pattern="###,###,##0.##"/> ea
					</td>
					<td class="td" align="right" colspan="2"> 
						<fmt:formatNumber value="${basicCardAmtSum}" pattern="###,###,##0.##"/> 원	
					</td>
				</tr>
			

				<tr>
					<td bgcolor="#FFE69E" class="td" colspan="10">
						<p>경비내역 현금지출분</p>
					</td>
				</tr>
				
				<tr>
					<td bgcolor="#F8F8F8" class="td">
						<p align="center">발생일자</p>
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

				<c:forEach items="${basicCashList}" var="item" varStatus="status">
					<tr>
						<td class="td"><p align="center">${item.costOccurDate}</p></td>
						<td class="td"><p align="center">${item.costClassNm}</p></td>
						<td class="td"><p align="center">${item.costPayPlace}</p></td>
						<td class="td"><p align="center">${item.costInvolvedCom}</p></td>
						<td class="td"><p align="center">${item.costInvolvedMan}</p></td>
						<td class="td" colspan="2"><p align="center">${item.costMemo}</p></td>
						<td class="td"><p align="center">${item.costBillEa} ea</p>
						<td class="td" colspan="2">
							<p align="right"> <fmt:formatNumber value="${item.costPayAmt}" pattern="###,###,##0.##"/> 원 </p>
						</td>
					</tr>
					
					<c:set var="basicCashEaSum" value="${basicCashEaSum + item.costBillEa}" />
					<c:set var="basicCashAmtSum" value="${basicCashAmtSum + item.costPayAmt}" />
					 
					<c:set var="tmpEaSum" value="${tmpEaSum + item.costBillEa}" />
					<c:set var="tmpAmtSum" value="${tmpAmtSum + item.costPayAmt}" />
					
					<c:if test="${item.costClassNo != basicCashList[status.count].costClassNo}">
						<tr bgcolor="#E7ECF1">
							<td class="td" colspan="7" align="right"><b>소계</b></td>
							<td class="td" align="center"><fmt:formatNumber value="${tmpEaSum}" pattern="###,###,##0.##"/> ea</td>
							<td class="td" align="right" colspan="2"><fmt:formatNumber value="${tmpAmtSum}" pattern="###,###,##0.##"/> 원</td>
						</tr>
						<c:set var="tmpEaSum" 	value="0" />
						<c:set var="tmpAmtSum" 	value="0" />
					</c:if>
					
				</c:forEach>				
				<tr>
					<td class="td" colspan="7" bgcolor="#F8F8F8">
						<p align="right"><B><font color="black">합 계</font></B></p>
					</td>
					<td class="td" align="center">	
						<fmt:formatNumber value="${basicCashEaSum}" pattern="###,###,##0.##"/> ea
					</td>
					<td class="td" align="right" colspan="2"> 
						<fmt:formatNumber value="${basicCashAmtSum}" pattern="###,###,##0.##"/> 원	
					</td>
				</tr>
				

				<tr>
					<td bgcolor="#FFE69E" class="td" colspan="10">
						<p>추가 경비내역 카드지출분</p>
					</td>
				</tr>
				<tr>
					<td bgcolor="#F8F8F8" class="td">
						<p align="center">발생일자</p>
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
				
				
				<c:forEach items="${addCardList}" var="item" varStatus="status">
					<tr>
						<td class="td"><p align="center">${item.costOccurDate}</p></td>
						<td class="td"><p align="center">${item.costClassNm}</p></td>
						<td class="td"><p align="center">${item.costPayPlace}</p></td>
						<td class="td"><p align="center">${item.costInvolvedCom}</p></td>
						<td class="td"><p align="center">${item.costInvolvedMan}</p></td>
						<td class="td" colspan="2"><p align="center">${item.costMemo}</p></td>
						<td class="td"><p align="center">${item.costBillEa} ea</p>
						<td class="td" colspan="2">
							<p align="right"> <fmt:formatNumber value="${item.costPayAmt}" pattern="###,###,##0.##"/> 원 </p>
						</td>
					</tr>
					
					<c:set var="addCardEaSum" value="${addCardEaSum + item.costBillEa}" />
					<c:set var="addCardAmtSum" value="${addCardAmtSum + item.costPayAmt}" />
					 
					<c:set var="tmpEaSum" value="${tmpEaSum + item.costBillEa}" />
					<c:set var="tmpAmtSum" value="${tmpAmtSum + item.costPayAmt}" />
					
					<c:if test="${item.costClassNo != addCardList[status.count].costClassNo}">
						<tr bgcolor="#E7ECF1">
							<td class="td" colspan="7" align="right"><b>소계</b></td>
							<td class="td" align="center"><fmt:formatNumber value="${tmpEaSum}" pattern="###,###,##0.##"/> ea</td>
							<td class="td" align="right" colspan="2"><fmt:formatNumber value="${tmpAmtSum}" pattern="###,###,##0.##"/> 원</td>
						</tr>
						<c:set var="tmpEaSum" 	value="0" />
						<c:set var="tmpAmtSum" 	value="0" />
					</c:if>
					
				</c:forEach>
				<tr>
					<td class="td" colspan="7" bgcolor="#F8F8F8">
						<p align="right"><B><font color="black">합 계</font></B></p>
					</td>
					<td class="td" align="center">	
						<fmt:formatNumber value="${addCardEaSum}" pattern="###,###,##0.##"/> ea
					</td>
					<td class="td" align="right" colspan="2"> 
						<fmt:formatNumber value="${addCardAmtSum}" pattern="###,###,##0.##"/> 원	
					</td>
				</tr>
			

				<tr>
					<td bgcolor="#FFE69E" class="td" colspan="10">
						<p>추가 경비내역 현금지출분</p>
					</td>
				</tr>
				
				<tr>
					<td bgcolor="#F8F8F8" class="td">
						<p align="center">발생일자</p>
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

				<c:forEach items="${addCashList}" var="item" varStatus="status">
					<tr>
						<td class="td"><p align="center">${item.costOccurDate}</p></td>
						<td class="td"><p align="center">${item.costClassNm}</p></td>
						<td class="td"><p align="center">${item.costPayPlace}</p></td>
						<td class="td"><p align="center">${item.costInvolvedCom}</p></td>
						<td class="td"><p align="center">${item.costInvolvedMan}</p></td>
						<td class="td" colspan="2"><p align="center">${item.costMemo}</p></td>
						<td class="td"><p align="center">${item.costBillEa} ea</p>
						<td class="td" colspan="2">
							<p align="right"> <fmt:formatNumber value="${item.costPayAmt}" pattern="###,###,##0.##"/> 원 </p>
						</td>
					</tr>
					
					<c:set var="addCashEaSum" value="${addCashEaSum + item.costBillEa}" />
					<c:set var="addCashAmtSum" value="${addCashAmtSum + item.costPayAmt}" />
					 
					<c:set var="tmpEaSum" value="${tmpEaSum + item.costBillEa}" />
					<c:set var="tmpAmtSum" value="${tmpAmtSum + item.costPayAmt}" />
					
					<c:if test="${item.costClassNo != addCashList[status.count].costClassNo}">
						<tr bgcolor="#E7ECF1">
							<td class="td" colspan="7" align="right"><b>소계</b></td>
							<td class="td" align="center"><fmt:formatNumber value="${tmpEaSum}" pattern="###,###,##0.##"/> ea</td>
							<td class="td" align="right" colspan="2"><fmt:formatNumber value="${tmpAmtSum}" pattern="###,###,##0.##"/> 원</td>
						</tr>
						<c:set var="tmpEaSum" 	value="0" />
						<c:set var="tmpAmtSum" 	value="0" />
					</c:if>
					
				</c:forEach>				
				<tr>
					<td class="td" colspan="7" bgcolor="#F8F8F8">
						<p align="right"><B><font color="black">합 계</font></B></p>
					</td>
					<td class="td" align="center">	
						<fmt:formatNumber value="${addCashEaSum}" pattern="###,###,##0.##"/> ea
					</td>
					<td class="td" align="right" colspan="2"> 
						<fmt:formatNumber value="${addCashAmtSum}" pattern="###,###,##0.##"/> 원	
					</td>
				</tr>					
						
						
				<tr>
					<td bgcolor="#FFE69E" class="td" colspan="10">
						<p>클레임 교통비 내역 카드지출분</p>
					</td>
				</tr>
				<tr>
					<td bgcolor="#F8F8F8" class="td">
						<p align="center">종결일자</p>
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
				
			
				<c:forEach items="${claimCardList}" var="item" varStatus="status">
					<tr>
						<td class="td"><p align="center">${item.costOccurDate}</p></td>
						<td class="td"><p align="center">${item.costClassNm}</p></td>
						<td class="td"><p align="center">${item.costInvolvedCom}</p></td>
						<td class="td"><p align="center">${item.costInvolvedMan}</p></td>
						<td class="td"><p align="center">${item.costSuimAcceptNo}</p></td>
						<td class="td"><p align="center">${item.costDistance}</p></td>
						<td class="td"><p align="center">${item.costMemo}</p></td>
						<td class="td"><p align="center">${item.costBillEa} ea</p>
						<td class="td" colspan="2">
							<p align="right"> <fmt:formatNumber value="${item.costPayAmt}" pattern="###,###,##0.##"/> 원 </p>
						</td>
					</tr>
					
					<c:set var="claimCardEaSum" value="${claimCardEaSum + item.costBillEa}" />
					<c:set var="claimCardAmtSum" value="${claimCardAmtSum + item.costPayAmt}" />
					 
					<c:set var="tmpEaSum" value="${tmpEaSum + item.costBillEa}" />
					<c:set var="tmpAmtSum" value="${tmpAmtSum + item.costPayAmt}" />
					
					<c:if test="${item.costClassNo != claimCardList[status.count].costClassNo}">
						<tr bgcolor="#E7ECF1">
							<td class="td" colspan="7" align="right"><b>소계</b></td>
							<td class="td" align="center"><fmt:formatNumber value="${tmpEaSum}" pattern="###,###,##0.##"/> ea</td>
							<td class="td" align="right" colspan="2"><fmt:formatNumber value="${tmpAmtSum}" pattern="###,###,##0.##"/> 원</td>
						</tr>
						<c:set var="tmpEaSum" 	value="0" />
						<c:set var="tmpAmtSum" 	value="0" />
					</c:if>
					
				</c:forEach>				
				<tr>
					<td class="td" colspan="7" bgcolor="#F8F8F8">
						<p align="right"><B><font color="black">합 계</font></B></p>
					</td>
					<td class="td" align="center">	
						<fmt:formatNumber value="${claimCardEaSum}" pattern="###,###,##0.##"/> ea
					</td>
					<td class="td" align="right" colspan="2"> 
						<fmt:formatNumber value="${claimCardAmtSum}" pattern="###,###,##0.##"/> 원	
					</td>
				</tr>					
		
				<tr>
					<td bgcolor="#FFE69E" class="td" colspan="10">
						<p>클레임 교통비 내역 현금지출분</p>
					</td>
				</tr>
				<tr>
					<td bgcolor="#F8F8F8" class="td">
						<p align="center">종결일자</p>
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
				
			
				<c:forEach items="${claimCashList}" var="item" varStatus="status">
					<tr>
						<td class="td"><p align="center">${item.costOccurDate}</p></td>
						<td class="td"><p align="center">${item.costClassNm}</p></td>
						<td class="td"><p align="center">${item.costInvolvedCom}</p></td>
						<td class="td"><p align="center">${item.costInvolvedMan}</p></td>
						<td class="td"><p align="center">${item.costSuimAcceptNo}</p></td>
						<td class="td"><p align="center">${item.costDistance}</p></td>
						<td class="td"><p align="center">${item.costMemo}</p></td>
						<td class="td"><p align="center">${item.costBillEa} ea</p>
						<td class="td" colspan="2">
							<p align="right"> <fmt:formatNumber value="${item.costPayAmt}" pattern="###,###,##0.##"/> 원 </p>
						</td>
					</tr>
					
					<c:set var="claimCashEaSum" value="${claimCashEaSum + item.costBillEa}" />
					<c:set var="claimCashAmtSum" value="${claimCashAmtSum + item.costPayAmt}" />
					 
					<c:set var="tmpEaSum" value="${tmpEaSum + item.costBillEa}" />
					<c:set var="tmpAmtSum" value="${tmpAmtSum + item.costPayAmt}" />
					
					<c:if test="${item.costClassNo != claimCashList[status.count].costClassNo}">
						<tr bgcolor="#E7ECF1">
							<td class="td" colspan="7" align="right"><b>소계</b></td>
							<td class="td" align="center"><fmt:formatNumber value="${tmpEaSum}" pattern="###,###,##0.##"/> ea</td>
							<td class="td" align="right" colspan="2"><fmt:formatNumber value="${tmpAmtSum}" pattern="###,###,##0.##"/> 원</td>
						</tr>
						<c:set var="tmpEaSum" 	value="0" />
						<c:set var="tmpAmtSum" 	value="0" />
					</c:if>
					
				</c:forEach>				
				<tr>
					<td class="td" colspan="7" bgcolor="#F8F8F8">
						<p align="right"><B><font color="black">합 계</font></B></p>
					</td>
					<td class="td" align="center">	
						<fmt:formatNumber value="${claimCashEaSum}" pattern="###,###,##0.##"/> ea
					</td>
					<td class="td" align="right" colspan="2"> 
						<fmt:formatNumber value="${claimCashAmtSum}" pattern="###,###,##0.##"/> 원	
					</td>
				</tr>		
							
				<tr>
					<td class="td" colspan="7" bgcolor="#EDEDED">
						<p align="right"><B><font color="black">총 합 계</font></B></p>
					</td>
					<td class="td" bgcolor="#EDEDED">
						<p align="center">${basicCardEaSum + basicCashEaSum + addCardEaSum + addCashEaSum + claimCardEaSum + claimCashEaSum}ea</p>					
					</td>
					<td class="td" bgcolor="#EDEDED" colspan="2">
						<p align="right">
							<fmt:formatNumber value="${basicCardAmtSum + basicCashAmtSum + addCardAmtSum + addCashAmtSum + claimCardAmtSum + claimCashAmtSum}" pattern="###,###,##0.##"/> 원
						</p>					
					</td>
				</tr>
			</table>



			<c:set var="helpClientSum" value="0" />
			<c:set var="helpAcceptSum" value="0" />
			
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
                
				<c:forEach items="${helpClientList}" var="item">
					<tr>
	                    <td class="td">
	            			<p align="center"><font color="red">의뢰</font></p>
	                    </td>
	                    <td class="td"> 
	                        <p align="center">${item.client_team_nm}</p>
	                    </td>
	                    <td class="td">
	                        <p align="center">${item.client_id_nm}</p>
	                    </td>
	                    <td class="td">
							<p align="center">${item.accept_team_nm}</p>
	                    </td>
	                    <td class="td">
							<p align="center">${item.accept_id_nm}</p>
	                    </td>
	                    <td class="td">
	            			<p align="center">${item.suim_accept_no}</p>
	                    </td>
	                    <td class="td">
	            			<p align="center">${item.beneficiary_nm}</p>
	                    </td>
	                    <td class="td">
							<p align="center">${item.reg_date_fmt}</p>
	                    </td>
	                    <td class="td">
							<p align="center">${item.end_date_fmt}</p>
	                    </td>
	                    <td class="td">
							<p align="right"><font color="red"><fmt:formatNumber value="${item.price_total}" pattern="###,###,##0.##"/></font></p>
						</td>
					</tr>
					<c:set var="helpClientSum" value="${helpClientSum + item.price_total}" />
				</c:forEach>
								
				<c:forEach items="${helpAcceptList}" var="item">
					<tr>
	                    <td class="td">
	            			<p align="center"><font color="blue">수임</font></p>
	                    </td>
	                    <td class="td">
	                        <p align="center">${item.client_team_nm}</p>
	                    </td>
	                    <td class="td">
	                        <p align="center">${item.client_id_nm}</p>
	                    </td>
	                    <td class="td">
							<p align="center">${item.accept_team_nm}</p>
	                    </td>
	                    <td class="td">
							<p align="center">${item.accept_id_nm}</p>
	                    </td>
	                    <td class="td">
	            			<p align="center">${item.suim_accept_no}</p>
	                    </td>
	                    <td class="td">
	            			<p align="center">${item.beneficiary_nm}</p>
	                    </td>
	                    <td class="td">
							<p align="center">${item.reg_date_fmt}</p>
	                    </td>
	                    <td class="td">
							<p align="center">${item.end_date_fmt}</p>
	                    </td>
	                    <td class="td">
							<p align="right"><font color="blue"><fmt:formatNumber value="${item.price_total}" pattern="###,###,##0.##"/></font></p>
						</td>
					</tr>
					<c:set var="helpAcceptSum" value="${helpAcceptSum + item.price_total}" />
				</c:forEach>
				<tr>
                    <td class="td" colspan="9" bgcolor="#F8F8F8">
						<p align="right" style="margin-right:5;"><font color="black"><b>합 계</b></font></p>
                    </td>
                    <td class="td" bgcolor="#F8F8F8">
						<p align="right"><b><fmt:formatNumber value="${helpAcceptSum - helpClientSum}" pattern="###,###,##0.##"/></b></p>
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
