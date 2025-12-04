<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="lecture-process-dialog" title="공개 강의실 정보조회" style="font-size: 12px;" align="center">	
	<div style="float: left;padding:5px 0 10px 10px;">
		<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" >
		&nbsp;<b>금액 변동내역 (단위:원)</b>								
    </div>	
	<div class="tableStyle99" style="width: 760px;">
		<table class="vacation-ins-table">			
			<tr>
				<th width="10%">로그번호</th>
				<th width="10%">수정자</th>
				<th width="11%">총합계</th>
				<th width="11%">기본보수</th>
				<th width="11%">일비</th>
				<th width="10%">교통비</th>
				<th width="10%">자문비</th>
				<th width="10%">기타</th>
				<th width="17%">수정일</th>
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
</div>		