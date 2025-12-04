<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${contractListSearch.size() == 0}">
			<tr>
				<td colspan="11" align="center">조회 대상건이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${contractListSearch}" varStatus="status">
				<!-- 보기목록 -->
				<tr id="contract_view_${items.tkey}" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''">
					<td align="center" width="5%" style="cursor: pointer;" onclick="javascript:doViewModal('${items.tkey}');">${topNum - status.index}</td>
					<td align="center" width="12%" style="cursor: pointer;" onclick="javascript:doViewModal('${items.tkey}');">${items.c_type_val}</td>					
					<td width="15%" style="text-align:left;padding-left:5px;cursor: pointer;" title="${items.t_subject}" onclick="javascript:doViewModal('${items.tkey}');">
						<c:choose>
							<c:when test="${fn:length(items.t_subject) > 13}">
								<c:out value="${fn:substring(items.t_subject, 0, 13)}"></c:out>...
							</c:when>
							<c:otherwise>${items.t_subject}</c:otherwise>
						</c:choose>						
					</td>
					<td width="10%" style="text-align:left;padding-left:5px;cursor: pointer;" title="${items.t_username}" onclick="javascript:doViewModal('${items.tkey}');">
						<c:choose>
							<c:when test="${fn:length(items.t_username) > 8}">
								<c:out value="${fn:substring(items.t_username, 0, 8)}"></c:out>...
							</c:when>
							<c:otherwise>${items.t_username}</c:otherwise>
						</c:choose>					
					</td>
					<td align="center" width="7%" style="cursor: pointer;" onclick="javascript:doViewModal('${items.tkey}');">${items.con_sdate_fmt}</td>
					<td align="center" width="7%" style="cursor: pointer;" onclick="javascript:doViewModal('${items.tkey}');">${items.con_edate_fmt}</td>			
					<td align="center" width="10%" style="cursor: pointer;" onclick="javascript:doViewModal('${items.tkey}');">${items.c_area_val}</td>
					<td align="center" width="7%" style="cursor: pointer;" onclick="javascript:doViewModal('${items.tkey}');">${items.reg_date_fmt}</td>
					<td align="center" width="8%" style="cursor: pointer;" onclick="javascript:doViewModal('${items.tkey}');">${items.user_name}</td>
					<td width="11%" style="text-align:left;padding-left:5px;cursor: pointer;" title="${items.t_content}" onclick="javascript:doViewModal('${items.tkey}');">
						<c:choose>
							<c:when test="${fn:length(items.t_content) > 10}">
								<c:out value="${fn:substring(items.t_content, 0, 10)}"></c:out>...
							</c:when>
							<c:otherwise>${items.t_content}</c:otherwise>
						</c:choose>						
					</td>
					<td width="2%" align="center">
						<c:choose>
							<c:when test="${items.file_cnt eq 1}">
								<a href="#" onclick="javascript:fnFileDown('${items.fkey}')" title="바로다운로드">
									<img src="./resources/ls_img/icon_disket.gif">
								</a>
							</c:when>
							<c:when test="${items.file_cnt > 1}">
								<a href="#" onclick="javascript:doViewModal('${items.tkey}');" title="총 ${items.file_cnt} 개의 첨부파일이 존재합니다.">
									<img src="./resources/ls_img/bt_icon.gif">
								</a>
							</c:when>							
						</c:choose>												
					</td>
					<td width="8%" align="center">						
						<input class="buttonMiniEdit" type="button" onclick="javascript:doEditModal('${items.tkey}')" value="수정">
						<input class="buttonMiniDel" type="button" onclick="javascript:doDeleteAll('${items.tkey}','${items.t_subject}');" value="삭제">
					</td>					
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>
<!--계약관리 페이징 시작 -->
<div class="pagingWrap">
	<c:set var="beginIdx" value="${pageInfo.firstPageNoOnPageList}" />
	<c:set var="endIdx" value="${pageInfo.lastPageNoOnPageList}" />
	<c:set var="totalPageCnt" value="${pageInfo.totalPageCount}" />
	<c:set var="currentIdx" value="${pageInfo.currentPageNo}" />
	<c:set var="firstIdx" value="1" />
	<c:set var="lastIdx" value="${totalPageCnt}" />
	<c:set var="prevIdx" value="${currentIdx - 1}" />
	<c:set var="nextIdx" value="${currentIdx + 1}" />	
	 
	<ul class="pagination no-margin">
	    <c:choose>
	        <c:when test="${currentIdx == 1}">
	            <li class="disabled"><a href="#">처음</a></li>
	            <li class="disabled"><a href="#">이전</a></li>
	        </c:when>
	        <c:otherwise>
	            <li><a href="#" onclick="fnGoPageList(${firstIdx});">처음</a></li>
	            <li><a href="#" onclick="fnGoPageList(${prevIdx});">이전</a></li>
	        </c:otherwise>
	    </c:choose>
	    <c:forEach var="idx" begin="${beginIdx}" end="${endIdx}">
	        <c:choose>
	            <c:when test="${idx == currentIdx}">
	                <li class="active"><a href="#"><c:out value="${idx}" /></a></li>
	            </c:when>
	            <c:otherwise>
	                <li><a href="#" onclick="fnGoPageList(${idx})"><c:out value="${idx}" /></a></li>
	            </c:otherwise>
	        </c:choose>
	    </c:forEach>
	    <c:choose>
	        <c:when test="${currentIdx == lastIdx}">
	            <li class="disabled"><a href="#">다음</a></li>
	            <li class="disabled"><a href="#">마지막</a></li>
	        </c:when>
	        <c:otherwise>
	            <li><a href="#" onclick="fnGoPageList(${nextIdx})">다음</a></li>
	            <li><a href="#" onclick="fnGoPageList(${lastIdx})">마지막</a></li>
	        </c:otherwise>
	    </c:choose>
	</ul>
</div>
<!--계약관리 목록 페이징 끝 -->