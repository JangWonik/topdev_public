<% response.setCharacterEncoding("UTF-8"); %>
<% response.setHeader("Content-Type", "application/vnd.ms-xls"); %>
<% response.setHeader("Content-Disposition", "attachment;filename=VacationSearchList.xls"); %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>	
<html>	
	<body>
	<div class= "tableStyle2" style="border-top: 0px;">																								
		<table border="1">									
			<thead>
				<tr>											
					<th width="5%">No.</th>
					<th width="10%">센터명</th>
					<th width="10%">부서명</th>
					<th width="10%">이름</th>
					<th width="6%">직급</th>
					<th width="8%">입사일</th>
					<th width="8%">사용시기<br/>(부여일)</th>
					<th width="8%">사용종기</th>
					<th width="8%">기간<br/>경과율</th>
					<th width="8%">현재<br/>사용율</th>
					<th width="5%">연차<br/>부여일</th>
					<th width="5%">사용일</th>
					<th width="5%">잔여일</th>															
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${vacationUseList.size() != 0}">
						<c:forEach items="${vacationUseList}" var="item" varStatus="status">
							<tr>														
								<td class="td-overflow-none">${pageInfo.totalRecordCount - (pageInfo.recordCountPerPage * (pageInfo.currentPageNo-1)) - status.index}</td>														
								<td class="td-overflow-none">${item.center_name}</td>
								<td class="td-overflow-none">${item.team_name}</td>
								<td class="td-overflow-none">${item.user_name}</td>
								<td class="td-overflow-none">${item.work_level_nm}</td>
								<td class="td-overflow-none">${item.join_date}</td>
								<td class="td-overflow-none">${item.annual_start_date}</td>
								<td class="td-overflow-none">${item.annual_end_date}</td>
								<td class="td-overflow-none"><fmt:formatNumber value="${item.day_progress}" pattern="##.#"/> %</td>
								<c:set var="per_interval" value="${item.day_progress - item.vacation_progress}"></c:set>														
								<c:choose>
									<c:when test="${per_interval > 30 or per_interval < -30}">
										<td class="td-overflow-none"><font style="font-weight:bold;color:red;"><fmt:formatNumber value="${item.vacation_progress}" pattern="##.#"/> %</font></td>
									</c:when>
									<c:otherwise>																
										<td class="td-overflow-none"><font style="font-weight:bold;color:blue;"><fmt:formatNumber value="${item.vacation_progress}" pattern="##.#"/> %</font></td>		
									</c:otherwise>
								</c:choose>																												
								<td class="td-overflow-none">${item.annual_set}</td>
								<td class="td-overflow-none">${item.annual_use}</td>														
								<td class="td-overflow-none">${item.annual_set - item.annual_use}</td>								
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="13">
								검색된 직원이 없습니다.
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
	</body>
</html>