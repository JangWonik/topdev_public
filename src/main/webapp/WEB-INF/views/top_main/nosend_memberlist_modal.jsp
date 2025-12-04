<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
	<div id="nosend-detail-dialog" title="손해사정서미교부현황(개인)" style="font-size: 12px;" align="center">		
		<div style="text-align:left;padding-left:10px;padding-top:5px;padding-bottom:5px;">
		<img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
			<b><span style="font-size:13px;color:#666;">${team_name}</span></b>
		</div>		
		<div class="tableStyle2" style="width: 550px;">
			<table class="vacation-ins-table">											
				<tr>
					<th>담당자</th>
					<th>계약자</th>
					<th>피보험자</th>
					<th>보험금청구권자</th>
					<th>전체</th>				
				</tr>
				<c:choose>
					<c:when test="${memberList.size() == 0}">
						<td colspan="5">조회된 팀원이 없습니다.</td>
					</c:when>
					<c:otherwise>
						<c:forEach items="${memberList}" var="item" varStatus="status">
							<tr onclick="javascript:goSendReportList('${item.user_no}','${item.user_name}');" style="cursor:pointer;" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''">
								<td>${item.user_name}</td>
								<td>${item.nNoSend_Type1}</td>
								<td>${item.nNoSend_Type5}</td>
								<td>${item.nNoSend_Type10}</td>														
								<td>${item.nNoSend_Total}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
	</div>