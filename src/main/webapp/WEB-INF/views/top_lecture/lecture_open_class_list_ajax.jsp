<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>	
</head>
<body>
<c:choose>
	<c:when test="${empty reqPgNo}">
		<c:set var="pageIdx" value="1" />
	</c:when>
	<c:otherwise>
		<c:set var="pageIdx" value="${reqPgNo}" />
	</c:otherwise>
</c:choose>
<div class="tableStyle2" style="border-top:0px;">
	<table>							
		<c:choose>
			<c:when test="${boardList.size() == 0}">
				<tr>
					<td colspan="9" align="center">조회 결과가 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${boardList}" var="brd" varStatus="status">
				<tr>
					<td width="5%">${boardListCnt - ( 18 * (pageIdx-1) ) - status.index}</td>
					<td width="6%">
						<c:choose>
							<c:when test="${brd.team_type eq 0}">공통</c:when>
							<c:when test="${brd.team_type eq 1}">물보험</c:when>
							<c:when test="${brd.team_type eq 4}">인보험</c:when>
						</c:choose>						
					</td>
					<td width="9%">${brd.category_name}</td>
					<td width="25%" style="text-align:left;padding-left:10px;letter-spacing:0px;" title="${brd.subject}">						
						<div style="width:300px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;cursor:pointer;" onclick="javascript:doOpenLectureView(${brd.okey});">
							${brd.subject}
						<c:if test="${brd.day_cnt < 2}">
							<img src="./resources/wm_img/common/ico_new.png" alt="new" />
						</c:if>						
						</div>						
					</td>
					<td width="25%" style="text-align:left;padding-left:10px;letter-spacing:0px;" title="${brd.introduce}">
						<div style="width:300px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;cursor:pointer;" onclick="javascript:doOpenLectureView(${brd.okey});">											
							${brd.introduce}
						</div>
					</td>
					<td width="3%">
						<c:if test="${!empty brd.file_org_name}">
							<a href="oOpenFileDownload?okey=${brd.okey}">
								<img src="./resources/ls_img/icon_disket.gif" title="${brd.file_org_name}">
							</a>
						</c:if>
					</td>
					<td width="9%" style="text-align:left;padding-left:10px;letter-spacing:0px;" title="${brd.manager_name}">
						<div style="width:100px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
							${brd.manager_name}
						</div>
						</td>
					<td width="4%">
						<c:choose>
							<c:when test="${mbrVo_Session.user_state eq 9 || mbrVo_Session.user_no == 966 || mbrVo_Session.user_no == 215  || mbrVo_Session.user_no == 1265}">
								<a href="#" onclick="javascript:doOpenLectureLogView(${brd.okey})">
									<font color="blue">${brd.view_cnt}</font>
								</a>
							</c:when>
							<c:otherwise>${brd.view_cnt}</c:otherwise>
						</c:choose>						
					</td>
					<td width="7%">${brd.reg_date_fmt}</td>
					<td width="7%"><input class="buttonDoneFlag" type="button" onclick="javascript:doOpenClassView('${brd.okey}');" value="강의시청"></td>
				</tr>
				</c:forEach>	
			</c:otherwise>
		</c:choose>		
	</table>
</div>
<div class="pagingWrap">
	<ul class="pagination no-margin">            
		<c:if test="${pgNm1 != null}">
			<c:if test="${startPgNoInt1 > 10}">
				<li>
					<a href="javascript:reqPgNoClick(${startPgNoInt1 - 1});">이전</a>
				</li>
			</c:if>
			<c:forEach var="pageNo" begin="${startPgNoInt1}" end="${endPgNoInt1}" step="1">
				<li <c:if test="${reqPgNoInt1 == pageNo}">class='active'</c:if>><a onclick="javascript:reqPgNoClick(${pageNo});" href="#">${pageNo}</a></li>
			</c:forEach>
			<c:if test="${totPgCntInt1 >= endPgNoInt1 + 1}">
				<li>
					<a href="javascript:reqPgNoClick(${endPgNoInt1 + 1});">다음</a>
				</li>					
			</c:if>
		</c:if>
	</ul>
</div>
</body>
</html>