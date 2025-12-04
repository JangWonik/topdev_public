<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:scriptlet> pageContext.setAttribute("newline", "\n"); </jsp:scriptlet>
<html>
	<head>
	</head>
	
	<!-- 엑셀로 표시할때, 숫자 소수점 표기법 변경 
		<td style='mso-number-format:"\@";'>01041061469</td>
	 -->	
	<body>
		<table border="1">
			<thead>
				<tr>
					<th bgcolor='#dceb8a'>No.</th>
					<th bgcolor='#dceb8a'>접수번호</th>
					<th bgcolor='#dceb8a' colspan="2">사고번호</th>
					<th bgcolor='#dceb8a'>담당부서</th>
					<th bgcolor='#dceb8a'>담당자</th>
					<th bgcolor='#dceb8a'>계약자</th>
					<th bgcolor='#dceb8a'>피보험자</th>
					<th bgcolor='#dceb8a'>피해자/물</th>
					<th bgcolor='#dceb8a'>접수일</th>
					<th bgcolor='#dceb8a'>이첩 등록자</th>
					<th bgcolor='#dceb8a'>기존 담당자</th>
					<th bgcolor='#dceb8a'>변경 담당자</th>
					<th bgcolor='#dceb8a'>이첩 사유</th>
					<th bgcolor='#dceb8a'>상태</th>
					<th bgcolor='#dceb8a'>완료일</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach var="rptMbrchgList" items="${rptMbrchgList}" varStatus="rmcStatus">
					<tr id="chgTr${rptMbrchgListStatus.index}"> 
						<!-- 순번 -->
						<td class="chgTd">
							${rmcStatus.count} 
						</td>
						<!-- 접수번호 -->
						<td class="chgTd">
							${rptMbrchgList.suimAcceptNo}
						</td>
						<!-- 사고번호1 -->
						<td class="chgTd" align="right" style="letter-spacing: 0;">${rptMbrchgList.accidentNo1}</td>
						<!-- 사고번호2 -->
						<td class="chgTd" align="left" style="letter-spacing: 0;">${rptMbrchgList.accidentNo2}</td>
						<!-- 부서명 -->
						<td class="chgTd">${rptMbrchgList.teamNm}</td>
						<!-- 담당자 -->
						<td class="chgTd">${rptMbrchgList.userNm}</td>
						<!-- 계약자 -->
						<td class="chgTd">
							${rptMbrchgList.policyholderNm}
						</td>
						<!-- 피보험자 -->
						<td class="chgTd">
							${rptMbrchgList.beneficiaryNm}
						</td>
						<!-- 피해자/물 -->
						<td class="chgTd">
							${rptMbrchgList.damagedNm}
						</td>
						<!-- 등록일 -->
						<td class="chgTd">
							${rptMbrchgList.regDate}
						</td>
						<!-- 이첩 등록자 -->
						<td class="chgTd">
							${rptMbrchgList.regUserNm}
						</td>
						<!-- 기존 담당자 -->
						<td class="chgTd">
							${rptMbrchgList.fromUserNm}
						</td>
						<!-- 변경 담당자 -->
						<td class="chgTd">
							${rptMbrchgList.toUserNm}
						</td>
						<!-- 이첩 사유 -->
						<td class="chgTd">
							${rptMbrchgList.mbrchgReasonVal}
						</td>
						<!-- 이첩 상태 -->
						<td class="chgTd">
							${rptMbrchgList.mbrchgStateVal}
						</td>
						<!-- 이첩 상태 -->
						<td class="chgTd">
							${rptMbrchgList.mbrchgDate}
						</td>							
					</tr>
				</c:forEach>		
			</tbody>
		</table>
	
	</body>
</html>

