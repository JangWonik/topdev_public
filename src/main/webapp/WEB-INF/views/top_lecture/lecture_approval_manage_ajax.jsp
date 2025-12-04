<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>
		<c:when test="${view_type eq 'all' }">
			<!-- 전체페이지 -->
			<c:choose>		
				<c:when test="${approvalList.size() == 0}">
					<tr>
						<td colspan="11" align="center">조회 대상건이 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="items" items="${approvalList}" varStatus="status">
						<!-- 보기목록 -->
						<tr id="approval_view_${items.akey}">
							<td align="center" width="6%">${topNum - status.index}</td>
							<td align="center" width="10%">${items.center_name}</td>
							<td align="center" width="10%">
								<div style="width:120px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
								${items.team_name}
								</div>
							</td>
							<td align="center" width="8%">${items.user_name}</td>
							<td width="14%" align="left" style="padding-left:5px;"title="${items.p_title}">
								<div style="width:170px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
									${items.p_title}
								</div>
							</td>
							<td align="center" width="8%">${items.reg_date_fmt}</td>
							<td align="center" width="14%">${items.show_sdate_fmt} ~ ${items.show_edate_fmt}</td>
							<td width="14%" align="left" style="padding-left:5px;">
								<div style="width:170px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
									${items.user_comment}
								</div>
							</td>
							<td align="center" width="8%">
								${items.ap_state_val}
							</td>					
							<td align="center" width="8%">
								<a href="#noloc" class="btn-equipment-gray" id="btn-search" onclick="javascript:doApprovalView('${items.akey}');">상세보기</a>
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>		
		</c:when>		
		<c:otherwise>
			<!-- 결재대상이나 결과페이지 -->
			<c:choose>		
				<c:when test="${approvalList.size() == 0}">
					<tr>
						<td colspan="10" align="center">결재 할(된) 대상건이 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="items" items="${approvalList}" varStatus="status">
						<!-- 보기목록 -->
						<tr id="approval_view_${items.akey}">
							<td align="center" width="6%">${topNum - status.index}</td>
							<td align="center" width="12%">${items.center_name}</td>
							<td align="center" width="12%">
								<div style="width:120px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
									${items.team_name}
								</div>
							</td>
							<td align="center" width="10%">${items.user_name}</td>
							<td width="16%" align="left" style="padding-left:5px;">
								<div style="width:170px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
									${items.p_title}
								</div>
							</td>
							<td align="center" width="8%">${items.reg_date_fmt}</td>
							<td align="center" width="14%">${items.show_sdate_fmt} ~ ${items.show_edate_fmt}</td>
							<td width="14%" align="left" style="padding-left:5px;">
								<div style="width:170px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
									${items.user_comment}
								</div>
							</td>					
							<td align="center" width="8%">
								<c:choose>
									<c:when test="${items.ap_state eq 10}">
										<a href="#noloc" class="btn-equipment-green" id="btn-search" onclick="javascript:doApproval('${items.akey}');">결재하기</a>
									</c:when>
									<c:when test="${items.ap_state eq 11}">
										<a href="#noloc" class="btn-equipment-mod" id="btn-search" onclick="javascript:doApproval('${items.akey}');">결재완료</a>
									</c:when>
									<c:when test="${items.ap_state eq 12}">
										<a href="#noloc" class="btn-equipment-cancel" id="btn-search" onclick="javascript:doApproval('${items.akey}');">반려</a>
									</c:when>
									<c:otherwise>
										<a href="#noloc" class="btn-equipment-gray" id="btn-search" onclick="javascript:doApproval('${items.akey}');">상세보기</a>
									</c:otherwise>
								</c:choose>								
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			
		</c:otherwise>
	</c:choose>
</table>
<!--교육결재대상 페이징 시작 -->
<c:if test="${view_type eq 'list' }">
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
</c:if>
<!--교육결재대상 페이징 끝 -->

<!--교육결재내역 페이징 시작 -->
<c:if test="${view_type eq 'result' }">
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
	            <li><a href="#" onclick="fnGoPageResult(${firstIdx});">처음</a></li>
	            <li><a href="#" onclick="fnGoPageResult(${prevIdx});">이전</a></li>
	        </c:otherwise>
	    </c:choose>
	    <c:forEach var="idx" begin="${beginIdx}" end="${endIdx}">
	        <c:choose>
	            <c:when test="${idx == currentIdx}">
	                <li class="active"><a href="#"><c:out value="${idx}" /></a></li>
	            </c:when>
	            <c:otherwise>
	                <li><a href="#" onclick="fnGoPageResult(${idx})"><c:out value="${idx}" /></a></li>
	            </c:otherwise>
	        </c:choose>
	    </c:forEach>
	    <c:choose>
	        <c:when test="${currentIdx == lastIdx}">
	            <li class="disabled"><a href="#">다음</a></li>
	            <li class="disabled"><a href="#">마지막</a></li>
	        </c:when>
	        <c:otherwise>
	            <li><a href="#" onclick="fnGoPageResult(${nextIdx})">다음</a></li>
	            <li><a href="#" onclick="fnGoPageResult(${lastIdx})">마지막</a></li>
	        </c:otherwise>
	    </c:choose>
	</ul>
</div>
</c:if>
<!--교육결재내역 페이징 끝 -->

<!--전체 페이징 시작 -->
<c:if test="${view_type eq 'all' }">
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
		            <li><a href="#" onclick="fnGoPageAll(${firstIdx});">처음</a></li>
		            <li><a href="#" onclick="fnGoPageAll(${prevIdx});">이전</a></li>
		        </c:otherwise>
		    </c:choose>
		    <c:forEach var="idx" begin="${beginIdx}" end="${endIdx}">
		        <c:choose>
		            <c:when test="${idx == currentIdx}">
		                <li class="active"><a href="#"><c:out value="${idx}" /></a></li>
		            </c:when>
		            <c:otherwise>
		                <li><a href="#" onclick="fnGoPageAll(${idx})"><c:out value="${idx}" /></a></li>
		            </c:otherwise>
		        </c:choose>
		    </c:forEach>
		    <c:choose>
		        <c:when test="${currentIdx == lastIdx}">
		            <li class="disabled"><a href="#">다음</a></li>
		            <li class="disabled"><a href="#">마지막</a></li>
		        </c:when>
		        <c:otherwise>
		            <li><a href="#" onclick="fnGoPageAll(${nextIdx})">다음</a></li>
		            <li><a href="#" onclick="fnGoPageAll(${lastIdx})">마지막</a></li>
		        </c:otherwise>
		    </c:choose>
		</ul>
	</div>
</c:if>
<!-- 페이징 끝 -->