<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<c:forEach items="${invoiceLogList}" var="logVO">
		<!-- 검색 결과 테이블 -->
			<div class= "tableStyle21">
				<table cellpadding="0" cellspacing="0">
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
						<td><c:out value="${logVO.reg_date_fmt}"/></td>
						<th>세금계산서 NO</th>
						<td><c:out value="${logVO.tax_invoice_no}"/>호</td>
					</tr>
					<tr>
						<th>총합계</th>
						<td><c:out value="${logVO.amt_total}"/>원</td>
						<th>제출일</th>
						<td><c:out value="${logVO.invoice_date_fmt}"/></td>
						<th>입금일</th>
						<td><c:out value="${logVO.deposit_date_fmt}"/></td>
						<th>세금계산서재발급일</th>
						<td><c:out value="${logVO.tax_date_fmt}"/></td>
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
			</div>
		<!-- //검색 결과 테이블 -->
		<br />
	</c:forEach>
