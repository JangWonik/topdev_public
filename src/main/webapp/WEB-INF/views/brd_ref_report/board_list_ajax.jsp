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
					<td colspan="8" align="center">조회 결과가 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${boardList}" var="brd" varStatus="status">
				<tr>
					<td width="6%">${boardListCnt - ( 15 * (pageIdx-1) ) - status.index}</td>
					<td width="12%">${brd.event_id_nm}</td>
					<td width="12%">${brd.type_id_nm}</td>
					<td width="40%" style="text-align:left;padding-left:7px;letter-spacing:0px;">
						<div style="width:360px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
						<a href="./refReportBoardDetail?boardNo=${brd.board_no}&cateSearch=${searchVO.cateSearch}&eventSearch=${searchVO.eventSearch}&typeSearch=${searchVO.typeSearch}&boardSrcWord=${searchVO.boardSrcWord}&reqPgNo=${reqPgNoInt1}">
						${brd.title}						
						</a>
						</div>
					</td>
					<td width="5%">
						<c:choose>
							<c:when test="${brd.file_cnt eq 1}">
								<a href="./brdRefReportFileDownload?fileNo=${brd.board_file_no}" title="바로다운로드">
									<img src="./resources/ls_img/icon_disket.gif">
								</a>
							</c:when>
							<c:when test="${brd.file_cnt > 1}">
								<a href="#" onclick="javascript:doViewModal('${brd.board_no}');" title="총 ${brd.file_cnt} 개의 첨부파일이 존재합니다.">
									<img src="./resources/ls_img/bt_icon.gif">
								</a>
							</c:when>
						</c:choose>						
					</td>
					<td width="10%">${brd.user_nm}</td>
					<td width="10%">${brd.reg_date_fmt}</td>
					<td width="5%">${brd.view_cnt}</td>
				</tr>
				</c:forEach>	
			</c:otherwise>
		</c:choose>		
	</table>
</div>	
<table border="0" style="margin-top:7px;">
	<tr>									
		<td align="center">
			<c:if test="${pgNm1 != null}">
				<c:if test="${startPgNoInt1 > 10}">
					<a href="javascript:reqPgNoClick(${startPgNoInt1 - 1});">&lt;</a>
				</c:if>
			
				<c:forEach var="pageNo" begin="${startPgNoInt1}" end="${endPgNoInt1}" step="1">
					<c:choose>
						<c:when test="${reqPgNoInt1 != pageNo}">
							<a href="javascript:reqPgNoClick(${pageNo});"><c:out value="${pageNo}" /></a>
							&nbsp;&nbsp;
						</c:when>
						<c:otherwise>
							<font color="red"><c:out value="${pageNo}" /></font>
							&nbsp;&nbsp;
						</c:otherwise>
					</c:choose>
				</c:forEach>
			
				<c:if test="${totPgCntInt1 >= endPgNoInt1 + 1}">
					<a href="javascript:reqPgNoClick(${endPgNoInt1 + 1});">&gt;</a>
				</c:if>
			</c:if>
		</td>
	</tr>
</table>

</body>
</html>