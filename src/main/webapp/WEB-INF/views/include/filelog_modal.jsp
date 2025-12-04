<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
<style>
	/* 모달 버튼 */
	.ui-button-text-only {
		height:2.1em !important;
	}	
</style>					
<div id="vacation-detail-dialog" title="파일다운로드 로그조회" style="font-size: 12px;" align="center">
	<br/>	
		<div class="tableStyle2" style="width: 650px;">
			<table class="vacation-ins-table">			
				<tr>
					<th width="20%">파일명</th>
					<td width="80%" style="text-align:left;padding-left:5px;">${paramMap.fileName}</td>
				</tr>
			</table>
			<table>
				<tr>
					<th width="8%">No</th>
					<th width="12%">사용자</th>
					<th width="50%">용도</th>
					<th width="15%">아이피</th>
					<th width="15%">다운일자</th>
				</tr>
				<c:choose>
					<c:when test="${filedownLogList.size() == 0 }">
						<tr>
							<td colspan="5">파일을 다운로드한 기록이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${filedownLogList}" var = "logList" varStatus="status">
							<tr> 
								<td>${filedownLogList.size() - status.index}</td>
								<td>${logList.user_nm}</td>
								<td style="text-align:left;padding-left:5px;">${logList.down_comment}</td>
								<td>${logList.user_ip}</td>
								<td>${logList.reg_date_fmt}</td>								
							</tr>
						</c:forEach>								
					</c:otherwise>
				</c:choose>																																																		
			</table>
		</div>
</div>