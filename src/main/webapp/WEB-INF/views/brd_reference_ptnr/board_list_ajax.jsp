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
					<td width="5%">${boardListCnt - ( 15 * (pageIdx-1) ) - status.index}</td>
					<td width="15%" style="text-align:left;padding-left:7px;letter-spacing:0px;" title="${brd.ptnr_name}">
						<div style="width:120px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
							${brd.ptnr_name}
						</div>
					</td>
					<td width="6%">
						<c:choose>
							<c:when test="${brd.title_classify eq 1}">
								<input class="buttonMini" type="button" value="1종" style="background-color:#F6CECE;">
							</c:when>
							<c:when test="${brd.title_classify eq 4}">
								<input class="buttonMini" type="button" value="4종" style="background-color:#D8F6CE;">
							</c:when>
							<c:otherwise>
								<input class="buttonMini" type="button" value="전체">
							</c:otherwise>
						</c:choose>							
					</td>
					<td width="9%">						
						${brd.type_classify_nm}						
					</td>
					<td width="5%">${brd.year_classify}</td>					
					<td width="35%" style="text-align:left;padding-left:7px;letter-spacing:0px;" title="${brd.title}">
						<div style="width:290px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
						<a href="./referencePtnrBoardDetail?boardNo=${brd.board_no}&cateSearch=${searchVO.cateSearch}&boardSrcType=${searchVO.boardSrcType}&boardSrcWord=${searchVO.boardSrcWord}&reqPgNo=${reqPgNoInt1}&ptnrSearch=${searchVO.ptnrSearch}&ptnrGubun=${searchVO.ptnrGubun}&titleSearch=${searchVO.titleSearch}&typeSearch=${searchVO.typeSearch}&yearSearch=${searchVO.yearSearch}">
						${brd.title}						
						</a>
						<c:if test="${brd.day_cnt < 1}">
							<img src="./resources/wm_img/common/ico_new.png" alt="new" />
						</c:if>
						</div>
					</td>
					<td width="3%">
						<c:choose>
							<c:when test="${brd.file_cnt eq 1}">
								<a href="./brdRefPtnrFileDownload?fileNo=${brd.board_file_no}" title="바로다운로드">
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
					<td width="8%">${brd.reg_date_fmt}</td>					
					<td width="4%">${brd.view_cnt}</td>
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