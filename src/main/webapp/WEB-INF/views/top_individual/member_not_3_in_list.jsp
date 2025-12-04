<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}
		});		
	</script>

<div class= "tableStyle2">
	<table>
		<thead>
			<tr>
				<th width="5%">구분</th>
				<th width="7%">접수번호</th>
				<th width="6%">보험사</th>
				<th width="8%">피보험자</th>
				<th width="5%">수임일자</th>
				<th width="5%">경과</th>
				<th width="5%">상태</th>
			</tr>
		</thead>
		<tbody>
			<!--  -->
			<c:forEach items="${not3InList}" var="suimVO" varStatus="status" > <!-- begin="1" end="20" step="1" -->
			
			<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
			style ="cursor:pointer;" onclick="popSuimDtl('${suimVO.suim_rpt_no}')">
				<!-- suim_rpt_type1 -->
				<td>${suimVO.suim_rpt_type1_nm}</td>
				<!-- suim_accept_no -->
				<td>${suimVO.suim_accept_no}</td>
				<!-- 보험사 -->
				<td>${suimVO.ptnr_name}</td>
				<!-- 피보험자 -->
				<td>${suimVO.beneficiary_nm}</td>
				<!-- 수임일자 -->
				<td>
					<c:choose>
						<c:when test="${empty suimVO.trans_date_fmt}">${suimVO.reg_date_fmt}</c:when>
						<c:otherwise>${suimVO.reg_date_fmt} (${suimVO.trans_date_fmt})</c:otherwise>
					</c:choose>
				</td>
				<!-- 경과 -->
				<td>
					<c:choose>
						<c:when test="${empty suimVO.trans_date_fmt}">${suimVO.past_date} 일</c:when>
						<c:otherwise>${suimVO.past_date} 일 ( ${suimVO.past_trans_date} ) 일</c:otherwise>
					</c:choose>
				</td>
				<!-- 상태 -->
				<td>${suimVO.suim_rpt_state_nm}</td>
			</tr>
			</c:forEach>
			<!-- 손해보험 출력 끝 -->
		</tbody>
	</table>
</div><!-- //tableStyle2 -->
