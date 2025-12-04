<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>

	<c:forEach items="${selEvalList}" var="vo" varStatus="status">

		<p align="center">
			<b><font color="5792C3"><c:out value="${vo.eval_year}"/> 년도 인사평가내역 </font></b>
		</p>

		<div class= "tableStyle2">

			<table>
				<thead>
					<tr>
						<th width="5%" bgcolor="#efefef">성명</th>
						<!-- 180108 직급/직책 에서 직위/직급으로 변경 -->
						<th width="5%" bgcolor="#efefef">직위</th>
						<th width="5%" bgcolor="#efefef">직급</th>
						<th width="5%" bgcolor="#efefef">입사일</th>
						<th width="5%" bgcolor="#efefef">최근승격일</th>
						<th width="5%" bgcolor="#efefef">생년월일</th>
						<th width="5%" bgcolor="#efefef">손사경력</th>
						<th width="5%" bgcolor="#efefef">본인평가<br />적정연봉</th>
						<th width="5%" bgcolor="#efefef">팀장평가<br />적정연봉</th>
						<th width="5%" bgcolor="#efefef">팀장평가<br />등급</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><c:out value="${vo.getUser_name()}"/></td>
						<td><c:out value="${vo.getWork_type_nm()}"/></td>
						<td><c:out value="${vo.getWork_level_nm()}"/></td>
						<td><c:out value="${vo.getJoin_date()}"/></td>
						<td><c:out value="${vo.getPromotion_date()}"/></td>
						<td><c:out value="${vo.getJumin_no1()}"/></td>
						<td><c:out value="${vo.getCareer_year()}"/></td>
						<td><c:out value="${vo.getSalary_desired()}"/></td>
						<td><c:out value="${vo.getTm_mngr_eval_sal()}"/></td>
						<td><c:out value="${vo.getTm_mngr_eval_grd()}"/></td>
					</tr>
				</tbody>
				
			</table>
	
		</div>
		<div class= "tableStyle2" style="margin-top:10px;">
	
			<table>
				<thead>
					<tr>
						<th width="5%" bgcolor="#efefef">수임건수</th>
						<th width="5%" bgcolor="#efefef">처리건수<br />(절대건수)</th>
						<th width="5%" bgcolor="#efefef">처리건수<br />(평가건수)</th>
						<th width="5%" bgcolor="#efefef">목표건수</th>
						<th width="5%" bgcolor="#efefef">목표건수<br />(달성률)</th>
						<th width="5%" bgcolor="#efefef">처리금액</th>
						<th width="5%" bgcolor="#efefef">목표금액</th>
						<th width="5%" bgcolor="#efefef">목표금액<br />(달성률)</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><c:out value=""/></td>
						<td><c:out value=""/></td>
						<td><c:out value=""/></td>
						<td><c:out value="${vo.getSuim_goal_cnt()}"/></td>
						<td><c:out value=""/></td>
						<td><c:out value=""/></td>
						<td><c:out value="${vo.getSuim_goal_amt()}"/></td>
						<td><c:out value=""/></td>
					</tr>
				</tbody>
				
			</table>
	
		</div>
		<div class= "tableStyle2" style="margin-top:10px;">
	
			<table>
				<tr>
					<th width="20%" bgcolor="#efefef">공적사항</th>
					<td><c:out value="${vo.getAchievement()}"/></td>
				</tr>
				<tr>
					<th width="20%" bgcolor="#efefef">개선사항</th>
					<td><c:out value="${vo.getImprovement()}"/></td>
				</tr>
				<tr>
					<th width="20%" bgcolor="#efefef">차기 연도 중점 추진사항</th>
					<td><c:out value="${vo.getNext_year_task()}"/></td>
				</tr>
				<tr>
					<th width="20%" bgcolor="#efefef">팀장의견</th>
					<td><c:out value="${vo.getTm_mngr_eval()}"/></td>
				</tr>
				<tr>
					<th width="20%" bgcolor="#efefef">담당 임원 의견</th>
					<td><c:out value="${vo.getMng_director_eval()}"/></td>
				</tr>
			</table>
	
		</div>

		<br /><br />

	</c:forEach>

</body>

</html>
