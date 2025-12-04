<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

		<script>
			$(document).ready(function(){
				if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_8}' == 0){
					window.opener.location.assign("./logout");
					window.self.close();
				}
			});//ready
		</script>
		
		<!-- 검색 결과 테이블 -->
		<div class= "tableStyle21">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<th>공동조사자</th>
					<th>기본보수</th>
					<th>일비</th>
					<th>교통비</th>
					<th>자문료</th>
					<th>기타</th>
					<th>합계</th>
					<th>건수</th>
					<th>등록일</th>
					<th>등록사원</th>
					<th>등록유형</th>
				</tr>
				<c:forEach items="${primBizInvShareLogList}" var="logVO" varStatus="status">
					<tr>
						<!--공동조사자-->
						<td>${logVO.share_user_nm}</td>
						<!--기본보수-->
						<td>${logVO.share_amt_basic}</td>
						<!--일비-->
						<td>${logVO.share_amt_daily}</td>
						<!--교통비-->
						<td>${logVO.share_amt_traffic}</td>
						<!--자문료-->
						<td>${logVO.share_amt_counsel}</td>
						<!--기타-->
						<td>${logVO.share_amt_etc}</td>
						<!--합계-->
						<td>${logVO.share_amt_total}</td>
						<!--건수-->
						<td>${logVO.share_ea}</td>
						<!--등록일-->
						<td>${logVO.reg_date_fmt}</td>
						<!--등록사원-->
						<td>${logVO.reg_user_nm}</td>
						<!--등록유형-->
						<td>${logVO.reg_type_nm}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<!-- //검색 결과 테이블 -->
		<br />
