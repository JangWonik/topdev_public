<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<div class= "tableStyle2">
	<!-- 검색 결과 테이블 시작-->
	<table>									
		<tr>
			<th width="70px">No</th>
			<th width="150px">센터명</th>
			<c:choose>
				<c:when test='${param.teamOrder == "ASC"}'>
					<th width="170px"><a href="javascript:doOrderTeamName('');">부서명 ▲</a></th>
				</c:when>
				<c:when test='${param.teamOrder == "DESC"}'>
					<th width="170px"><a href="javascript:doOrderTeamName('ASC');">부서명 ▼</a></th>
				</c:when>
				<c:otherwise>
					<th width="170px"><a href="javascript:doOrderTeamName('DESC');"><font color="blue">부서명</font></a></th>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test='${param.levelOrder == "ASC"}'>
					<th width="80px"><a href="javascript:doOrderLevel('');">직위 ▲</a></th>
				</c:when>
				<c:when test='${param.levelOrder == "DESC"}'>
					<th width="80px"><a href="javascript:doOrderLevel('ASC');">직위 ▼</a></th>
				</c:when>
				<c:otherwise>
					<th width="80px"><a href="javascript:doOrderLevel('DESC');"><font color="blue">직위</font></a></th>
				</c:otherwise>
			</c:choose>
			<th width="80px">직급</th>
			
			<c:choose>
				<c:when test='${param.workOrder == "ASC"}'>
					<th width="90px"><a href="javascript:doOrderWork('');">직책 ▲</a></th>
				</c:when>
				<c:when test='${param.workOrder == "DESC"}'>
					<th width="90px"><a href="javascript:doOrderWork('ASC');">직책 ▼</a></th>
				</c:when>
				<c:otherwise>
					<th width="90px"><a href="javascript:doOrderWork('DESC');"><font color="blue">직책</font></a></th>
				</c:otherwise>
			</c:choose>
			
			<c:choose>
				<c:when test='${param.userNameOrder == "ASC"}'>
					<th width="140px"><a href="javascript:doOrderUserName('');">이름 ▲</a></th>
				</c:when>
				<c:when test='${param.userNameOrder == "DESC"}'>
					<th width="140px"><a href="javascript:doOrderUserName('ASC');">이름 ▼</a></th>
				</c:when>
				<c:otherwise>
					<th width="140px"><a href="javascript:doOrderUserName('DESC');"><font color="blue">이름</font></a></th>
				</c:otherwise>
			</c:choose>
			
			<th width="70px">아이디</th>
			
			<c:choose>
				<c:when test='${param.joinOrder == "ASC"}'>
					<th width="90px"><a href="javascript:doOrderJoin('');">입사일 ▲</a></th>
				</c:when>
				<c:when test='${param.joinOrder == "DESC"}'>
					<th width="90px"><a href="javascript:doOrderJoin('ASC');">입사일 ▼</a></th>
				</c:when>
				<c:otherwise>
					<th width="90px"><a href="javascript:doOrderJoin('DESC');"><font color="blue">입사일</font></a></th>
				</c:otherwise>
			</c:choose>
			
			<c:choose>
				<c:when test='${param.tab == "retire"}'>
					<c:choose>
						<c:when test='${param.outOrder == "ASC"}'>
							<th width="90px"><a href="javascript:doOrderOut('');"><font color="blue">퇴사일 ▼</font></a></th>
						</c:when>
						<c:when test='${param.outOrder == "DESC"}'>
							<th width="90px"><a href="javascript:doOrderOut('ASC');"><font color="blue">퇴사일 ▲</font></a></th>
						</c:when>
						<c:otherwise>
							<th width="90px"><a href="javascript:doOrderOut('DESC');"><font color="blue">퇴사일</font></a></th>
						</c:otherwise>						
					</c:choose>
				</c:when>
				<c:otherwise>
					<th width="90px">현재상태</th>		
				</c:otherwise>
			</c:choose>
			
			<c:choose>
				<c:when test="${mbrVo_Session.user_state == 9}">
					<th width="100px">출입카드</th>
				</c:when>
				<c:otherwise>
					<th width="100px">직통번호</th>
				</c:otherwise>										
			</c:choose>
			<th width="100px">비고</th>
			<th width="17px"></th>
		</tr>									
	</table>
</div>
<c:choose>
	<c:when test="${searchStatMemberList.size() < 21}">
		<div class= "tableStyle2" style="border-top:0px;">
	</c:when>
	<c:when test='${param.tab == "search" }'>
		<div class= "tableStyle2" style="border-top:0px;overflow-x:hidden;overflow-y:scroll;height:620px;">
	</c:when>	
	<c:otherwise>
		<div class= "tableStyle2" style="border-top:0px;overflow-x:hidden;overflow-y:scroll;height:650px;">
	</c:otherwise>
</c:choose>
	<table>
		<c:choose>
			<c:when test="${searchStatMemberList.size() == 0}">
				<tr>
					<td colspan="11">검색결과가 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
			</c:otherwise>
		</c:choose>
		<c:forEach items="${searchStatMemberList}" var="item" varStatus="status">
			<tr>
				<!-- No -->
				<td width="70px">${item.rownum}</td>
				<!-- 센터명 -->
				<td width="150px" title="${item.center_name}">
					<c:choose>
						<c:when test="${fn:length(item.center_name) > 12}">
							${fn:substring(item.center_name,0,12)}...
						</c:when>
						<c:otherwise>${item.center_name}</c:otherwise>
					</c:choose>					
				</td>
				<!-- 팀명 -->
				<td width="170px" title="${item.team_name}">
					<c:choose>
						<c:when test="${fn:length(item.team_name) > 12}">
							${fn:substring(item.team_name,0,12)}...
						</c:when>
						<c:otherwise>${item.team_name}</c:otherwise>
					</c:choose>					
				</td>
				<!-- 직위 -->
				<td width="80px">${item.work_level}</td>
				<!-- 직급 -->
				<td width="80px">${item.work_rank}</td>
				<!-- 직책 -->
				<td width="90px">${item.work_type}</td>
				<!-- 이름 -->
				<td width="140px" title="${item.user_no}">${item.user_name}</td>
				<!-- 아이디 -->
				<td width="70px">${item.user_id}</td>
				<!-- 입사일 -->
				<td width="90px">
					<c:choose>
						<c:when test='${item.join_date == "1970-01-01"}'>정보없음</c:when>
						<c:otherwise>${item.join_date}</c:otherwise>
					</c:choose>				
				</td>
				
				<c:choose>
					<c:when test='${param.tab == "retire"}'>
						<!-- 퇴사일 -->
						<td width="90px">${item.out_date}</td>						
					</c:when>
					<c:otherwise>
						<!-- 현재상태 -->
							<td width="90px">
								<c:choose>
									<c:when test='${item.user_state eq "휴직중"}'>
										<font color="green">${item.user_state}</font>
									</c:when>
									<c:when test='${item.user_state eq "발령대기"}'>
										<font color="orange">${item.user_state}</font>
									</c:when>
									<c:when test='${item.user_state eq "퇴사"}'>
										<font color="red">${item.user_state}</font>
									</c:when>
									<c:otherwise>
										<font color="blue">${item.user_state}</font>
									</c:otherwise>
								</c:choose>					
							</td>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${mbrVo_Session.user_state == 9}">
						<td width="100px">															
							<c:choose>
								<c:when test="${item.card_key eq 0}">
									<a class="btn-vacation-aprv" id="btn-detail" style="background:#F3E2A9;width: 58px;" onclick="popCardAdd('${item.user_no}','${item.team_id_main}')" href="#noloc">카드등록</a>
								</c:when>
								<c:otherwise>
									<a class="btn-vacation-aprv" id="btn-detail" style="background:#CEE3F6;width: 58px;" onclick="popCardDetail('${item.card_key}')" href="#noloc">정보조회</a>
								</c:otherwise>
							</c:choose>
						</td>	
					</c:when>
					<c:otherwise>
						<td width="100px">${item.office_tel}</td>
					</c:otherwise>
				</c:choose>
				<!-- 비고 -->
				<td width="100px">
					<a class="btn-vacation-aprv" id="btn-detail" style="width: 58px;" onclick="javascript:popMbrDetail('${item.user_no}');" href="#noloc">상세보기</a>
				</td>
				<c:if test="${searchStatMemberList.size() < 21}">
					<td width="17px"></td>
				</c:if>				
			</tr>
		</c:forEach>
	</table>
</div>