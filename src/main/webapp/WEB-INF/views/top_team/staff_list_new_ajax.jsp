<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div style="padding-top:5px;text-align: right;">
	<img alt="Exceldownload" src="/resources/ls_img/ls_invoice/btn_excel.gif" onclick="javascript:doDownload();" style="cursor:pointer;">
</div>
<div class="guestcnt4" style="display:block;height:750px;margin-top:5px;">
	<div class="tableStyle2">
		<table>									
			<tr>
				<th width="50px;">순번</th>
				<th width="120px;">팀명</th>
				<th width="80px;">직위</th>
				<th width="80px;">직책</th>
				<th width="80px;">이름</th>
				<th width="80px;">아이디</th>
				<th width="80px;">
					<c:choose>
						<c:when test='${srchArg.joinDateOrder == "ASC"}'>
							<a href="javascript:doOrderJoinDate('DESC');">입사일 ▼</a>	
						</c:when>
						<c:when test='${srchArg.joinDateOrder == "DESC"}'>
							<a href="javascript:doOrderJoinDate('ASC');">입사일 ▲</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:doOrderJoinDate('DESC');"><font color="blue">입사일</font></a>
						</c:otherwise>
					</c:choose>												
				</th>
				<th width="80px;">
					<c:choose>
						<c:when test='${srchArg.outDateOrder == "ASC"}'>
							<a href="javascript:doOrderOutDate('DESC');">퇴사일 ▼</a>	
						</c:when>
						<c:when test='${srchArg.outDateOrder == "DESC"}'>
							<a href="javascript:doOrderOutDate('ASC');">퇴사일 ▲</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:doOrderOutDate('DESC');"><font color="blue">퇴사일</font></a>
						</c:otherwise>
					</c:choose>
				</th>
				<th width="80px;">현재상태</th>
				<th width="80px;">휴직유무</th>
				<th width="100px;">경조금 갹출 동의</th>
				<th width="80px;">비고</th>		
				<th width="10px;"></th>	
			</tr>
		</table>
		<div id="subList" style="overflow:auto;width:100%; height:660px;">
			<table>	
				<c:choose>		
					<c:when test="${memberList.size() == 0}">
						<tr>
							<td colspan="10" align="center">검색결과가 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="items" items="${memberList}" varStatus="status">
							<c:set var="idx" value="${memberList.size() - status.index}"/>
							<tr id="info_view_${idx}">
								<td width="50px;">${idx}</td>
								<td width="120px;">${items.team_name}</td>
								<td width="80px;">${items.work_level_name}</td>
								<td width="80px;">${items.work_type_name}</td>
								<td width="80px;">${items.user_name}</td>
								<td width="80px;">${items.user_id}</td>
								<td width="80px;">${items.join_date_fmt}</td>
								<td width="80px;">${items.out_date_fmt}</td>
								<td width="80px;">${items.user_state_name}</td>
								<td width="80px;">
									<c:choose>
										<c:when test="${items.leave_cnt > 0}"><font color="green">유 (${items.leave_cnt}회)</font></c:when>
										<c:otherwise>무</c:otherwise>
									</c:choose>
								</td>
								<td width="100px;">
									<c:choose>
										<c:when test="${items.exp_agree eq 1}"><font color="blue">동의</font></c:when>
										<c:when test="${items.exp_agree eq 2}"><font color="red">미동의</font></c:when>
										<c:otherwise>해당없음</c:otherwise>
									</c:choose>
								</td>
								<td width="80px;">
									<a href="#noloc" class="btn-vacation-aprv" id="btn-search" style="background:#F2F2F2;" onclick="javascript:popStaffDetail(${items.user_no})">상세보기</a>
								</td>					
								<c:if test="${memberList.size() < 23}">
									<td width="10px;"></td>
								</c:if>
							</tr>								
						</c:forEach>			
					</c:otherwise>
				</c:choose>
			</table>
		</div>
	</div>
</div>