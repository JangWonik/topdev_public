<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${title_Session}</title>
<div id="salary-detail-dialog" title="기본급 설정 등록" style="font-size: 15px;" align="center">
	<br/>
	<div class="tableStyle2" style="width: 750px;">
		<table class="vacation-ins-table">
			<colgroup>
				<col style="width:25%;">
				<col style="width:25%;">
				<col style="width:25%;">
				<col style="width:25%;">					
			</colgroup>
			<tbody>
			<tr>
				<th>등록(수정)자</th>
				<td style="font-weight:bold;">${salarySetupInfoMap.reg_user_nm}</td>
				<th>등록(수정)일자</th>
				<td style="font-weight:bold;">${salarySetupInfoMap.reg_date_fmt}</td>
			</tr>
			<tr>
				<th>등록 명</th>
				<td style="font-weight:bold;">
					${salarySetupInfoMap.salary_subject}
				</td>
				<th>사용여부</th>
				<td>
					<c:choose>
						<c:when test="${salarySetupInfoMap.is_use eq 0}">사용함</c:when>
						<c:otherwise>사용안함</c:otherwise>
					</c:choose>					
				</td>
			</tr>
			<tr>
				<th>적용 시작일자</th>
				<td style="font-weight:bold;">${salarySetupInfoMap.term_sdate_fmt}</td>
				<th>적용 종료일자</th>
				<td style="font-weight:bold;">${salarySetupInfoMap.term_edate_fmt}</td>					
			</tr>
			<tr>
				<td colspan="4"></td>
			</tr>
			<tr>
				<th colspan="4">수습기간 기본급</th>
			</tr>				
			<tr>
				<th>기본</th>
				<th>1개월</th>
				<th>2개월</th>
				<th>3개월</th>
			</tr>
			<tr>
				<td><fmt:formatNumber value="${salarySetupInfoMap.intern_pay}" pattern="#,##0.##"/> 원</td>
				<td><fmt:formatNumber value="${salarySetupInfoMap.intern_pay_1}" pattern="#,##0.##"/> 원</td>
				<td><fmt:formatNumber value="${salarySetupInfoMap.intern_pay_2}" pattern="#,##0.##"/> 원</td>
				<td><fmt:formatNumber value="${salarySetupInfoMap.intern_pay_3}" pattern="#,##0.##"/> 원</td>
			</tr>
			<tr>
				<td colspan="4"></td>
			</tr>
			<tr>
				<th colspan="4">경력기간 기본급</th>
			</tr>				
			<tr>
				<th>1년 미만</th>
				<th>2년차</th>
				<th>3년차</th>
				<th>4년차 이상</th>
			</tr>
			<tr>
				<td><fmt:formatNumber value="${salarySetupInfoMap.career_pay_1}" pattern="#,##0.##"/> 원</td>
				<td><fmt:formatNumber value="${salarySetupInfoMap.career_pay_2}" pattern="#,##0.##"/> 원</td>
				<td><fmt:formatNumber value="${salarySetupInfoMap.career_pay_3}" pattern="#,##0.##"/> 원</td>
				<td><fmt:formatNumber value="${salarySetupInfoMap.career_pay_4}" pattern="#,##0.##"/> 원</td>
			</tr>
			<tr>
				<td colspan="4"></td>
			</tr>
			<tr>
				<th colspan="4">근속수당(당사)</th>
			</tr>				
			<tr>
				<th>1년 이상</th>
				<th>2년 이상</th>
				<th>3년 이상</th>
				<th>4년 이상</th>
			</tr>
			<tr>
				<td><fmt:formatNumber value="${salarySetupInfoMap.conti_pay_1}" pattern="#,##0.##"/> 원</td>
				<td><fmt:formatNumber value="${salarySetupInfoMap.conti_pay_2}" pattern="#,##0.##"/> 원</td>
				<td><fmt:formatNumber value="${salarySetupInfoMap.conti_pay_3}" pattern="#,##0.##"/> 원</td>
				<td><fmt:formatNumber value="${salarySetupInfoMap.conti_pay_4}" pattern="#,##0.##"/> 원</td>
			</tr>
			<tr>
				<td colspan="4"></td>
			</tr>
			<tr>
				<th>팀장 수당</th>
				<td><fmt:formatNumber value="${salarySetupInfoMap.manager_pay}" pattern="#,##0.##"/> 원</td>
				<th>기본급 최대 허용 액</th>
				<td><fmt:formatNumber value="${salarySetupInfoMap.max_pay}" pattern="#,##0.##"/> 원</td>
			</tr>	
			</tbody>																																																		
		</table>				
	</div>
</div>