<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=20170411111520" />
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->    
    <script src="./resources/ne_js/calendar.js?v=20170321111520"></script>    
	<div id="loadFileList" style="padding-top:10px;">
		<div class="tableStyle2" style="width: 660px;">
			<table class="vacation-ins-table">
				<tr>
					<th width="60px;">순번</th>
					<th width="200px;">접수번호</th>
					<th width="200px;">입금일자</th>
					<th width="180px;">보고서유무</th>					
				</tr>			
				<c:choose>
					<c:when test="${prevList.size() == 0}">
						<tr>
							<td colspan="4">${paramMap.error}</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${prevList}" var="item" varStatus="status">
						<tr>
							<td>${prevList.size() - status.index}</td>
							<td>${item.accept_no}</td>
							<td>${item.income_date}</td>
							<td>
								<c:choose>
									<c:when test="${item.enable}">
										<font color="blue">유</font>
									</c:when>
									<c:otherwise>
										<font color="red">무 (확인필요)</font>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>				
			</table>
		</div>
	</div>