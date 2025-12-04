<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<script>
		$(document).ready(function(){
		});
	</script>
	
	<table>
		<colgroup>
			<col width="55" />	<!-- 순번 -->
			<col width="90" />	<!-- 접수번호 -->
			<col width="35" />	<!-- 사고번호1 -->
			<col width="60" />	<!-- 사고번호2 -->
			<col width="95" />	<!-- 담당부서 -->
			<col width="80" />	<!-- 담당자 -->
			<col width="80" />	<!-- 계약자 -->
			<col width="80" />	<!-- 피보험자 -->
			<col width="80" />	<!-- 피해자/물 -->				
			<col width="80" />	<!-- 접수일 -->
			<col width="80" />	<!-- 이첩 등록자 -->
			<col width="80" />	<!-- 기존 담당자-->
			<col width="80" />	<!-- 변경 담당자 -->
			<col width="70" />	<!-- 이첩 사유 -->		
			<col width="55" />	<!-- 이첩 상태 -->
			<col width="80" />	<!-- 완료일 -->
		</colgroup>
	
		<thead>
			<tr>
				<th>No.</th>
				<th>접수번호</th>
				<th colspan="2">사고번호</th>
				<th>담당부서</th>
				<th>담당자</th>
				<th>계약자</th>
				<th>피보험자</th>
				<th>피해자/물</th>
				<th>접수일</th>
				<th>이첩 등록자</th>
				<th>기존 담당자</th>
				<th>변경 담당자</th>
				<th>이첩 사유</th>
				<th>상태</th>
				<th>완료일</th>
			</tr>
		</thead>
		
		<tbody>
		
		<c:forEach var="rptMbrchgList" items="${rptMbrchgList}" varStatus="rmcStatus">
			<tr id="chgTr${rptMbrchgListStatus.index}"> 
				<!-- 순번 -->
				<td class="chgTd">
					${rptMbrchgListCnt - srchParam.limitPage - rmcStatus.index} 
				</td>
				<!-- 접수번호 -->
				<td class="chgTd" style="cursor:pointer;" onclick="popSuimDtl(${rptMbrchgList.suimRptNo})">
					${rptMbrchgList.suimAcceptNo}
				</td>
				<!-- 사고번호1 -->
				<td class="chgTd" align="right">${rptMbrchgList.accidentNo1}</td>
				<!-- 사고번호2 -->
				<td class="chgTd" align="left">${rptMbrchgList.accidentNo2}</td>
				<!-- 부서명 -->
				<td class="chgTd">${rptMbrchgList.teamNm}</td>
				<!-- 담당자 -->
				<td class="chgTd">${rptMbrchgList.userNm}</td>
				<!-- 계약자 -->
				<td class="chgTd">
					${rptMbrchgList.policyholderNm}
				</td>
				<!-- 피보험자 -->
				<td class="chgTd">
					${rptMbrchgList.beneficiaryNm}
				</td>
				<!-- 피해자/물 -->
				<td class="chgTd">
					${rptMbrchgList.damagedNm}
				</td>
				<!-- 등록일 -->
				<td class="chgTd">
					${rptMbrchgList.regDate}
				</td>
				<!-- 이첩 등록자 -->
				<td class="chgTd">
					${rptMbrchgList.regUserNm}
				</td>
				<!-- 기존 담당자 -->
				<td class="chgTd">
					${rptMbrchgList.fromUserNm}
				</td>
				<!-- 변경 담당자 -->
				<td class="chgTd">
					${rptMbrchgList.toUserNm}
				</td>
				<!-- 이첩 사유 -->
				<td class="chgTd">
					${rptMbrchgList.mbrchgReasonVal}
				</td>
				<!-- 이첩 상태 -->
				<td class="chgTd">
					${rptMbrchgList.mbrchgStateVal}
				</td>
				<!-- 이첩 상태 -->
				<td class="chgTd">
					${rptMbrchgList.mbrchgDate}
				</td>							
			</tr>
			
		</c:forEach>
		</tbody>
	</table>

	<div class="pagingWrap">
    	<%--<div class="pageContent">--%>
        	<c:import url="/page_navi">
            	<c:param name="beginIdx" value="${pageInfo.firstPageNoOnPageList}"/>
                <c:param name="endIdx" value="${pageInfo.lastPageNoOnPageList}"/>
                <c:param name="currentIdx" value="${pageInfo.currentPageNo}"/>
                <c:param name="totalPageCnt" value="${pageInfo.totalPageCount}"/>
			</c:import>
		<%--</div>--%>
     </div>	
	