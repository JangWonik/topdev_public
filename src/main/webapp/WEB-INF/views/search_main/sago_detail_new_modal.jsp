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
					
		<div id="vacation-detail-dialog" title="사고처리과정표" style="font-size: 12px;" align="center">
			<br/>
			<div class="tableStyle2" style="width: 700px;">
				<table class="vacation-ins-table">
					<colgroup>
						<col width="20%"/>
						<col width="30%"/>
						<col width="50%"/>																					
					</colgroup>					
					<tbody>						
						<tr>
							<th>일자</th>
							<th>항목</th>
							<th>처리내용</th>
						</tr>
						<c:choose>
							<c:when test="${sagoTotalList.size() == 0 }">
								<tr>
									<td colspan="3">등록된 사고처리과정표가 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${sagoTotalList}" var = "sagoList">
									<tr> 
										<td>${sagoList.control_date}</td>
										<td>${sagoList.control_subject}</td>
										<td>${sagoList.control_memo}</td>
									</tr>
								</c:forEach>								
							</c:otherwise>
						</c:choose>
					</tbody>																																																							
				</table>
			</div>
		</div>