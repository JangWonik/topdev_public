<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="tableStyle2" style="width: 750px;">
		<table class="vacation-ins-table">
			<tr>
				<th colspan="4">기본정보</th>
			</tr>
			<tr>
				<th>센터명</th>
				<td>${userMap.center_name}</td>
				<th>팀 명</th>
				<td>${userMap.team_name}</td>
			</tr>
			<tr>
				<th>이 름</th>
				<td><b>${userMap.user_name}</b></td>
				<th>직 급</th>
				<td>${userMap.work_level_nm}</td>
			</tr>
			<tr>
				<th>보험사</th>
				<td>
					<c:choose>
						<c:when test="${empty userMap.insu_name}"><font color="red">미지정</font></c:when>
						<c:otherwise>${userMap.insu_name}</c:otherwise>
					</c:choose>
				</td>
				<th>직 무</th>
				<td>
					<c:choose>
						<c:when test="${empty userMap.part_name}"><font color="red">미지정</font></c:when>
						<c:otherwise>${userMap.part_name}</c:otherwise>
					</c:choose>					
				</td>
			</tr>
			<tr>
				<th>입사일자</th>
				<td>${userMap.join_date_fmt}</td>
				<th>경력(연차)</th>
				<td><b>${userMap.total_work_month_text} (${userMap.total_work_year_text})</b></td>
			</tr>
			<tr>
				<th>경력일수</th>
				<td>${userMap.work_month_text}</td>
				<th>근속일수</th>
				<td>${userMap.career_month_text}</td>
			</tr>
			<c:if test="${userMap.leave_month > 0}">
			<tr>
				<th>휴직(무급)일수</th>
				<td>${userMap.leave_month_text}</td>
				<th></th>
				<td></td>
			</tr>
			</c:if>
			<tr>
				<td colspan="4" style="border:0px;"></td>
			</tr>
			<tr>
				<th colspan="4">기본급 정보</th>
			</tr>
			<tr>
				<th>기본급 기준일</th>
				<td>${userMap.base_sdate} ~ ${userMap.base_edate}</td>
				<th>급여방식</th>
				<td>
					<c:choose>
						<c:when test="${userMap.pay_flag eq 0}">월급제</c:when>
						<c:otherwise>연봉제</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>기본급</th>
				<td style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${userMap.career_pay}" pattern="#,##0.##"/></td>
				<th>근속수당</th>
				<td style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${userMap.work_pay}" pattern="#,##0.##"/></td>
			</tr>
			<tr>
				<th>팀장수당</th>
				<td style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${userMap.manager_pay}" pattern="#,##0.##"/></td>
				<th>기본급 합계</th>
				<td style="text-align:right;padding-right:5px;"><font color="green"><b><fmt:formatNumber value="${userMap.base_total_pay}" pattern="#,##0.##"/></b></font></td>
			</tr>
			<tr>
				<td colspan="4" style="border:0px;"></td>
			</tr>
			<tr>
				<th colspan="4">성과급 정보</th>
			</tr>
			<tr>
				<th>실적 기준일</th>
				<td>${userMap.chk_sdate} ~ ${userMap.chk_edate}</td>
				<th>성과급 기준</th>
				<td>
					<c:choose>
						<c:when test="${userMap.insu_type eq 1}">종결건</c:when>
						<c:when test="${userMap.insu_type eq 2}">매출액</c:when>
						<c:otherwise><font color="red">미지정</font></c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>기준 손감율</th>
				<td>${userMap.loss_rate}</td>
				<th>건 당 금액</th>
				<td style="text-align:right;padding-right:5px;">${userMap.unit_sales}</td>
			</tr>
			<tr>
				<th>(최소)기본건수</th>
				<td style="text-align:right;padding-right:5px;">${userMap.base_count}</td>
				<th>(최소)기본매출액</th>
				<td style="text-align:right;padding-right:5px;">${userMap.base_sales}</td>
			</tr>
			<tr>
				<td colspan="4" style="border:0px;"></td>
			</tr>
			<tr>
				<th colspan="4">구간 지급율</th>				
			</tr>
			<tr>
				<th>1구간 (${userMap.payout_rate_1}%)</th>
				<th>2구간 (${userMap.payout_rate_2}%)</th>
				<th>3구간 (${userMap.payout_rate_3}%)</th>
				<th>4구간 (${userMap.payout_rate_4}%)</th>
			</tr>
			<c:choose>
				<c:when test="${userMap.insu_type eq 1}">
					<tr>
						<td>${userMap.base_count} ~ ${userMap.count_chk_point_1}</td>
						<td>${userMap.count_chk_point_1} ~ ${userMap.count_chk_point_2}</td>
						<td>${userMap.count_chk_point_2} ~ ${userMap.count_chk_point_3}</td>
						<td>${userMap.count_chk_point_3} 초과</td>
					</tr>
				</c:when>
				<c:when test="${userMap.insu_type eq 2}">
					<tr>
						<td>${userMap.base_sales} ~ ${userMap.sales_chk_point_1}</td>
						<td>${userMap.sales_chk_point_1} ~ ${userMap.sales_chk_point_2}</td>
						<td>${userMap.sales_chk_point_2} ~ ${userMap.sales_chk_point_3}</td>
						<td>${userMap.sales_chk_point_3} 초과</td>
					</tr>
				</c:when>
			</c:choose>			
			<tr>
				<td colspan="2"  style="text-align:left;padding-left:5px;">※ 손감미만 또는 민원발생시 지급율 : <b>${userMap.fail_rate} %</b></td>
				<th>성과 구간</th>
				<td><font color="red"><b>${userMap.cal_reason_text}</b></font></td>
			</tr>
			<tr>
				<td colspan="4" style="border:0px;"></td>
			</tr>
			<tr>
				<th>본인부담 시상비</th>
				<th>직업변경 시상비</th>
				<th>기타1</th>
				<th>기타2</th>				
			</tr>
			<tr>
				<td style="text-align:right;padding-right:5px;">${userMap.self_option_pay}</td>
				<td style="text-align:right;padding-right:5px;">${userMap.job_option_pay}</td>
				<td style="text-align:right;padding-right:5px;">${userMap.etc1_option_pay}</td>
				<td style="text-align:right;padding-right:5px;">${userMap.etc2_option_pay}</td>
			</tr>
			<tr>
				<td colspan="4" style="border:0px;"></td>
			</tr>
			<tr>
				<th>손감율</th>
				<th>민원발생</th>
				<th>직원 매출액</th>
				<th>성과급 합계</th>				
			</tr>
			<tr>
				<td>${userMap.user_loss_rate}</td>
				<td>${userMap.minwon_cnt}</td>
				<td style="text-align:right;padding-right:5px;">${userMap.cal_result_sales}</td>
				<td style="text-align:right;padding-right:5px;"><font color="green"><b><fmt:formatNumber value="${userMap.sum_sales_pay}" pattern="#,##0.##"/></b></font></td>				
			</tr>
			<tr>
				<th>비고</th>
				<td colspan="3" style="text-align:left;padding-left:5px;">${userMap.etc_memo}</td>
			</tr>
			<tr>
				<td colspan="4" style="border:0px;"></td>
			</tr>
			<tr>
				<th>정산일자</th>
				<td><b>${userMap.sales_date}</b></td>
				<th>급여 합계</th>
				<td style="text-align:right;padding-right:5px;"><font color="blue"><b><fmt:formatNumber value="${userMap.base_total_pay+userMap.sum_sales_pay}" pattern="#,##0.##"/></b></font></td>				
			</tr>
		</table>
	</div>