<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%
    response.setHeader("Content-Disposition", "attachment; filename=salary_4_"+pageContext.getAttribute("today")+".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>
<h1>인보험 급여내역 (정산일자 : ${sales_date})</h1>
<table border="1">	
	<tr>
		<th bgcolor="#F2F5A9" rowspan="2">No</th>
		<th bgcolor="#F2F5A9" rowspan="2">팀명</th>
		<th bgcolor="#F2F5A9" rowspan="2">보험사</th>
		<th bgcolor="#F2F5A9" rowspan="2">직무</th>
		<th bgcolor="#F2F5A9" rowspan="2">이름</th>
		<th bgcolor="#F2F5A9" rowspan="2">입사일자</th>
		
		<th bgcolor="#F5D0A9" colspan="4">경력정보</th>
		
		<th bgcolor="#F2F5A9" rowspan="2">손감</th>			
		<th bgcolor="#F2F5A9" rowspan="2">민원</th>
		<th bgcolor="#F2F5A9" rowspan="2">기준 매출액</th>
		<th bgcolor="#F2F5A9" rowspan="2">직원 매출액</th>
		
		<th bgcolor="#A9F5BC" colspan="5">기본급 정보</th>
		
		<th bgcolor="#A9D0F5" colspan="8">성과급 정보</th>		
					
		<th bgcolor="#F2F5A9" rowspan="2">급여 합계</th>
		<th bgcolor="#F2F5A9" rowspan="2">비고</th>
	</tr>
	<tr>
		<th bgcolor="#F5D0A9">경력일수</th>
		<th bgcolor="#F5D0A9">근속일수</th>
		<th bgcolor="#F5D0A9">휴직일수</th>				
		<th bgcolor="#F5D0A9">총 경력일수</th>
		
		<th bgcolor="#A9F5BC">기본급 정산구분</th>		
		<th bgcolor="#A9F5BC">기본급</th>
		<th bgcolor="#A9F5BC">근속수당</th>
		<th bgcolor="#A9F5BC">팀장수당</th>		
		<th bgcolor="#A9F5BC">기본급 합계</th>
		
		<th bgcolor="#A9D0F5">성과급 정산구분</th>
		<th bgcolor="#A9D0F5">성과구간</th>
		<th bgcolor="#A9D0F5">구간 성과급</th>
		<th bgcolor="#A9D0F5">본인부담 시상비</th>
		<th bgcolor="#A9D0F5">직업변경 시상비</th>
		<th bgcolor="#A9D0F5">기타1</th>
		<th bgcolor="#A9D0F5">기타2</th>
		<th bgcolor="#A9D0F5">성과급 합계</th>
	</tr>
	<c:choose>		
		<c:when test="${masterList.size() == 0}">
			<tr>
				<td colspan="17" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			 <c:forEach var="items" items="${masterList}" varStatus="status">
			 	<tr>
			 		<td align="center">${masterList.size() - status.index}</td>
			 		<td align="center">${items.team_name}</td>
			 		<td align="center">${items.insu_name}</td>
			 		<td align="center">${items.part_name}</td>
			 		<td align="center">${items.user_name}</td>
			 		<td align="center">${items.join_date_fmt}</td>
			 		<td align="center">${items.work_month_txt}</td>
			 		<td align="center">${items.career_month_txt}</td>
			 		<td align="center">${items.leave_month_txt}</td>			 		
			 		<td align="center">${items.total_work_month_txt}</td>
			 		<td align="center">${items.loss_rate}</td>
			 		<td align="center">${items.minwon_cnt}</td>
			 		<td style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.base_sales}" pattern="#,##0.##"/></td>
			 		<td style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.cal_result_sales}" pattern="#,##0.##"/></td>
			 		<td align="center">
			 			<c:choose>
			 				<c:when test="${items.pay_flag eq 1}">
			 					<font color="green">연봉제</font>
			 				</c:when>
			 				<c:otherwise>
			 					<font color="blue">월급제</font>
			 				</c:otherwise>
			 			</c:choose>			 		
			 		</td>
			 		<td style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.career_pay}" pattern="#,##0.##"/></td>
			 		<td style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.work_pay}" pattern="#,##0.##"/></td>
			 		<td style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.manager_pay}" pattern="#,##0.##"/></td>
			 		
			 		<td style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.base_total_pay}" pattern="#,##0.##"/></td>
			 		<td align="center">
			 			<c:choose>
			 				<c:when test="${items.incentive_type eq 1}">
			 					<font color="blue">종결건</font>
			 				</c:when>
			 				<c:when test="${items.incentive_type eq 2}">
			 					<font color="green">매출액</font>
			 				</c:when>
			 				<c:otherwise>
			 					<font color="red">미지정</font>
			 				</c:otherwise>
			 			</c:choose>			 		
			 		</td>
			 		<td><font color="red">${items.cal_reason_text}</font></td>
			 		<td style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.part_pay}" pattern="#,##0.##"/></td>
			 		<td style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.self_option_pay}" pattern="#,##0.##"/></td>
			 		<td style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.job_option_pay}" pattern="#,##0.##"/></td>
			 		<td style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.etc1_option_pay}" pattern="#,##0.##"/></td>
			 		<td style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.etc2_option_pay}" pattern="#,##0.##"/></td>			 		
			 		<td style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.sum_sales_pay}" pattern="#,##0.##"/></td>
			 		<td style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${items.base_total_pay+items.sum_sales_pay}" pattern="#,##0.##"/></td>
			 		<td align="center">${items.etc_memo}</td>
			 	</tr>
			 	<!-- 최소 기준 매출액 -->
			 	<c:set var="total_base_sales" value="${total_base_sales + items.base_sales}" />
			 	<!-- 직원 매출액 합계 -->
			 	<c:set var="total_cal_result_sales" value="${total_cal_result_sales + items.cal_result_sales}" />
			 	<!-- 기본급 합계-->
			 	<c:set var="total_base_total_pay" value="${total_base_total_pay + items.base_total_pay}" />
			 	<!-- 성과급 합계 -->
			 	<c:set var="total_sum_sales_pay" value="${total_sum_sales_pay + items.sum_sales_pay}" />
			 	<!-- 급여 합계 -->
			 	<c:set var="total_salary_all" value="${total_salary_all + items.base_total_pay+items.sum_sales_pay}" />
			 </c:forEach>			
		</c:otherwise>
	</c:choose>
</table>
<br/>
<table border="1">	
	<tr>
		<th width="10%">총 기준 매출액 합계</th>
		<td width="10%" style="text-align:right;padding-right:10px;"><fmt:formatNumber value="${total_base_sales}" pattern="#,##0.##"/></td>
		<th width="10%">총 직원 매출액 합계</th>
		<td width="10%" style="text-align:right;padding-right:10px;"><fmt:formatNumber value="${total_cal_result_sales}" pattern="#,##0.##"/></td>
		<th width="10%">총 기본급  합계</th>
		<td width="10%" style="text-align:right;padding-right:10px;"><b><font color="green"><fmt:formatNumber value="${total_base_total_pay}" pattern="#,##0.##"/></font></b></td>
		<th width="10%">총 성과급 합계</th>
		<td width="10%" style="text-align:right;padding-right:10px;"><b><font color="blue"><fmt:formatNumber value="${total_sum_sales_pay}" pattern="#,##0.##"/></font></b></td>				
		<th width="10%">총 급여 합계</th>
		<td width="10%" style="text-align:right;padding-right:10px;"><b><font color="red"><fmt:formatNumber value="${total_salary_all}" pattern="#,##0.##"/></font></b></td>
	</tr>
</table>
