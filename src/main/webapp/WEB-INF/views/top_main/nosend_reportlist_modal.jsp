<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
	<div id="nosend-detail-dialog" title="손해사정서미교부현황(개인)" style="font-size: 12px;" align="center">		
		<div style="text-align:left;padding-left:10px;padding-top:5px;padding-bottom:5px;">
		<img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
			<b><span style="font-size:13px;color:#666;">${user_name}</span></b>
		</div>		
		<div class="tableStyle2" style="width: 750px;">
			<table class="vacation-ins-table">											
				<tr>
					<th rowspan="2">사고번호</th>
					<th rowspan="2">보험사명</th>
					<th rowspan="2">종결일자</th>
					<th colspan="3">미교부</th>									
				</tr>
				<tr>
					<th>계약자</th>
					<th>피보험자</th>
					<th>보험청구권자</th>
				</tr>
				<c:choose>
					<c:when test="${reportList.size() == 0}">
						<td colspan="6">조회된 보고서가 없습니다.</td>
					</c:when>
					<c:otherwise>
						<c:forEach items="${reportList}" var="item" varStatus="status">
							<tr onclick="javascript:popSuimDtl(${item.suim_rpt_no});" style="cursor:pointer;" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''">
								<td>${item.suim_accept_no}</td>
								<td>${item.ptnr_name}</td>
								<td>${item.close_date_fmt}</td>
								<td>${item.con_method}</td>
								<td>${item.ins_method}</td>														
								<td>${item.cla_method}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
	</div>