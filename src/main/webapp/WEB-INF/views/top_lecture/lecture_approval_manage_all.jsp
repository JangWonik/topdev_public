<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 교육 결재 전체 내역 -->
<div class="tableStyle99">															
	<table>
		<tr>
			<th width="6%">No</th>
			<th width="10%">센터명</th>
			<th width="10%">부서명</th>
			<th width="8%">신청자</th>
			<th width="14%">교육과정 명</th>
			<th width="8%">신청일</th>
			<th width="14%">시청기간</th>
			<th width="14%">신청사유</th>
			<th width="8%">결재상태</th>			
			<th width="8%"> - </th>						
		</tr>
	</table>
	<div id="lectureApprovalAllList"></div>
</div>
<!-- 결재 대상건 조회 끝 -->