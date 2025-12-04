<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<table>
<c:choose>						
	<c:when test="${searchMemberList.size() != 0}">						
		<c:forEach items="${searchMemberList}" var="item" varStatus="status">
			<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" style ="cursor:pointer;">														
				<td width="4%" class="td-overflow-none" onclick="javascript:openDetailView(${item.ptnr_mbr_no});">${pageInfo.totalRecordCount - (pageInfo.recordCountPerPage * (pageInfo.currentPageNo-1)) - status.index}</td>
				<!-- 이름 -->														
				<td width="9%" class="td-overflow-none" onclick="javascript:openDetailView(${item.ptnr_mbr_no});">${item.ptnr_mbr_nm}</td>
				<!-- 보험사명 -->
				<td width="9%" class="td-overflow-none" onclick="javascript:openDetailView(${item.ptnr_mbr_no});">${item.ptnr_nick}</td>
				<!-- 팀명 -->
				<td width="15%" class="td-overflow-none" onclick="javascript:openDetailView(${item.ptnr_mbr_no});">
					${item.ptnr_dept_nm}
					<c:if test="${item.ptnr_tm2_nm != ''}">
						(${item.ptnr_tm2_nm})
					</c:if>
				</td>
				<!-- 직위 -->
				<td width="6%" class="td-overflow-none" onclick="javascript:openDetailView(${item.ptnr_mbr_no});">${item.ptnr_mbr_position_nm}</td>
				<!-- 직책 -->
				<td width="6%" class="td-overflow-none" onclick="javascript:openDetailView(${item.ptnr_mbr_no});">${item.ptnr_mbr_job_memo}</td>
				<!-- 업종 -->
				<td width="6%" class="td-overflow-none" onclick="javascript:openDetailView(${item.ptnr_mbr_no});">
					<c:choose>
						<c:when test="${item.ptnr_mbr_work_type == 1}">1종</c:when>
						<c:when test="${item.ptnr_mbr_work_type == 4}">4종</c:when>
						<c:when test="${item.ptnr_mbr_work_type == 0}">1종/4종겸직</c:when>
					</c:choose>
				</td>
				<!-- 휴대폰 -->
				<td width="7%" class="td-overflow-none" onclick="javascript:openDetailView(${item.ptnr_mbr_no});">${item.ptnr_mbr_hp}</td>
				<!-- 직통전화 -->
				<td width="7%" class="td-overflow-none" onclick="javascript:openDetailView(${item.ptnr_mbr_no});">${item.ptnr_mbr_office_tel}</td>
				<!-- 팩스 -->
				<td width="7%" class="td-overflow-none" onclick="javascript:openDetailView(${item.ptnr_mbr_no});">${item.ptnr_mbr_office_fax}</td>
				<!-- 이메일 -->														
				<td width="8%" class="td-overflow-none" onclick="javascript:openDetailView(${item.ptnr_mbr_no});">${item.ptnr_mbr_office_email}</td>
				<!-- 메모 -->
				<%-- <td width="8%" class="td-overflow-none" onclick="javascript:openDetailView(${item.ptnr_mbr_no});">${item.ptnr_mbr_work_memo}</td>
				<!-- 주소 -->
				<td width="8%" class="td-overflow-none" onclick="javascript:openDetailView(${item.ptnr_mbr_no});">															
					${item.ptnr_mbr_office_postcode} ${item.ptnr_mbr_office_addr1} ${item.ptnr_mbr_office_addr2}										
				</td> --%>
				<!-- 세금계산서 담당자 -->
				<td width="7%" class="td-overflow-none" onclick="javascript:openDetailView(${item.ptnr_mbr_no});">															
					${item.ptnr_tax_nm}										
				</td>
				<td width="9%" class="td-overflow-none">
					<c:if test="${mbrAuthVo_Session.mbr_pms_9 == 1 }">						
						<input class="buttonMini" value="수정" style="background-color:#CEE3F6;" onclick="javascript:doMemberEdit(${item.ptnr_mbr_no});">&nbsp;
						<input class="buttonMini" value="삭제" style="background-color:#F6CECE;" onclick="javascript:doMemberDel(${item.ptnr_mbr_no},'${item.ptnr_mbr_nm}');">
					</c:if>										
				</td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="15">
				검색된 관련업체 직원이 없습니다.
			</td>
		</tr>
	</c:otherwise>
</c:choose>
</table>
<input type="hidden" id="currPageIdx" value="${pageInfo.currentPageNo}"/>
<div class="pagingWrap">
    <c:import url="/page_navi_ptnr_member_search">
		<c:param name="beginIdx" value="${pageInfo.firstPageNoOnPageList}"/>
		<c:param name="endIdx" value="${pageInfo.lastPageNoOnPageList}"/>
		<c:param name="currentIdx" value="${pageInfo.currentPageNo}"/>
		<c:param name="totalPageCnt" value="${pageInfo.totalPageCount}"/>						                
	</c:import>
</div>