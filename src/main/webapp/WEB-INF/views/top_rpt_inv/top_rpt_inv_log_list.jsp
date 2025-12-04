<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_8}' == 0){
				window.opener.location.assign("./logout");
				window.self.close();
			}
		});//ready
	</script>
	<style>
		.invoiceResultTable tr td{
			letter-spacing: 0px;
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
		}		
	
	</style>
</head>

<body>	
	<div style="float: left;padding:0px 0 10px;">
		<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" >
		&nbsp;<b>금액 변동내역 (단위:원)</b>								
    </div>
	<div class="tableStyle99" >		
		<table>
			<tr>
				<th width="10%">로그번호</th>
				<th width="10%">수정자</th>
				<th width="11%">총합계</th>
				<th width="11%">기본보수</th>
				<th width="11%">일비</th>
				<th width="11%">교통비</th>
				<th width="11%">자문비</th>
				<th width="11%">기타</th>
				<th width="14%">수정일</th>
			</tr>
			<c:forEach items="${invoiceLogList}" var="logVO">
				<tr>					
					<td align="center"><c:out value="${logVO.serial_no}"/></td>
					<td align="center"><c:out value="${logVO.reg_user_nm}"/></td>
					<td style="text-align:right;padding-right:5px;letter-spacing:0;">						
						<fmt:formatNumber value="${logVO.amt_total}" pattern="###,###,##0.##"/>
					</td>
					<td style="text-align:right;padding-right:5px;letter-spacing:0;">
						<fmt:formatNumber value="${logVO.amt_basic}" pattern="###,###,##0.##"/>						
					</td>
					<td style="text-align:right;padding-right:5px;letter-spacing:0;">
						<fmt:formatNumber value="${logVO.amt_daily}" pattern="###,###,##0.##"/>						
					</td>
					<td style="text-align:right;padding-right:5px;letter-spacing:0;">
						<fmt:formatNumber value="${logVO.amt_traffic}" pattern="###,###,##0.##"/>						
					</td>
					<td style="text-align:right;padding-right:5px;letter-spacing:0;">
						<fmt:formatNumber value="${logVO.amt_counsel}" pattern="###,###,##0.##"/>						
					</td>
					<td style="text-align:right;padding-right:5px;letter-spacing:0;">
						<fmt:formatNumber value="${logVO.amt_etc}" pattern="###,###,##0.##"/>						
					</td>
					<td align="center" style="letter-spacing: -1px;"><c:out value="${logVO.reg_date_fmt}"/></td>					
				</tr>
			</c:forEach>	
		</table>
	</div>
	<div style="float: left;padding:10px 0 10px;">
		<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" >
		&nbsp;<b>세부변동내역</b>								
    </div>	
	<div class= "tableStyle99" >
	<c:forEach items="${invoiceLogList}" var="logVO">
		<!-- 검색 결과 테이블 -->			
				<table cellpadding="0" cellspacing="0" class="invoiceResultTable">
					<colgroup>
						<col width="12.5%" />
						<col width="12.5%" />
						<col width="12.5%" />
						<col width="12.5%" />
						<col width="12.5%" />
						<col width="12.5%" />
						<col width="13%" />
						<col width="12%" />
					</colgroup>
					<tr>
						<th>로그번호</th>
						<td><c:out value="${logVO.serial_no}"/></td>
						<th>수정자</th>
						<td><c:out value="${logVO.reg_user_nm}"/></td>
						<th>수정일</th>
						<td style="letter-spacing: -1px;"><c:out value="${logVO.reg_date_fmt}"/></td>
						<th>세금계산서 NO</th>
						<td><c:out value="${logVO.tax_invoice_no}"/>호</td>
					</tr>
					<tr>
						<th>총합계</th>
						<td><c:out value="${logVO.amt_total}"/>원</td>
						<th style="letter-spacing: -1px;">제출일</th>
						<td><c:out value="${logVO.invoice_date_fmt}"/></td>
						<th>입금일</th>
						<td style="letter-spacing: -1px;"><c:out value="${logVO.deposit_date_fmt}"/></td>
						<th>세금계산서재발급일</th>
						<td style="letter-spacing: -1px;"><c:out value="${logVO.tax_date_fmt}"/></td>
					</tr>
					<tr>
						<th>기본보수</th>
						<td><c:out value="${logVO.amt_basic}"/>원</td>
						<th>기본보수 내역</th>
						<td colspan="5"><c:out value="${logVO.amt_basic_dtl}"/></td>
					</tr>
					<tr>
						<th>일비</th>
						<td><c:out value="${logVO.amt_daily}"/>원</td>
						<th>일비 내역</th>
						<td colspan="5"><c:out value="${logVO.amt_daily_dtl}"/></td>
					</tr>
					<tr>
						<th>교통비</th>
						<td><c:out value="${logVO.amt_traffic}"/>원</td>
						<th>교통비 내역</th>
						<td colspan="5"><c:out value="${logVO.amt_traffic_dtl}"/></td>
					</tr>
					<tr>
						<th>자문비</th>
						<td><c:out value="${logVO.amt_counsel}"/>원</td>
						<th>자문비 내역</th>
						<td colspan="5"><c:out value="${logVO.amt_counsel_dtl}"/></td>
					</tr>
					<tr>
						<th>기타</th>
						<td><c:out value="${logVO.amt_etc}"/>원</td>
						<th>기타 내역</th>
						<td colspan="5"><c:out value="${logVO.amt_etc_dtl}"/></td>
					</tr>
					<tr>
						<th>비고</th>
						<td colspan="7"><c:out value="${logVO.rpt_invoice_memo}"/></td>
					</tr>
				</table>			
		<!-- //검색 결과 테이블 -->
		<br />
	</c:forEach>
	</div>
</body>

</html>
