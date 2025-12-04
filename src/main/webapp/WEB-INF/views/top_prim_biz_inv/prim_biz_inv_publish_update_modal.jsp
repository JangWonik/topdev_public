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
    
	<script>
	$(document).ready(function(){		

		$("#publishSaveBtn").click(function(){			
			
			var publish_data_val = $("#publish_date").val();
			var sMsg = "입력 된 세금계산서 발행일자로 일괄적용하시겠습니까?";			
			
			if( publish_data_val == '' ){
				alert("세금계산서 발행일자를 입력해주세요.");
				$("#publish_date").focus();
				return;
			}
			
			if( confirm(sMsg) ){
				
				var formData = $("#publishSaveForm").serialize();
				
				$.ajax({
					type : "post",									
//					url : "updatePublishDate",
					url : "updatePrimPublishDate",
					data : formData,
					success : function(result){
						alert(result.msg);						
						//창 닫고 새로고침
						$("#publish-detail-dialog").dialog('close');
						//재검색
						$("#searchBtn").click();
						
					},
					error: function (request, status, error) {			
						console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
					}
				});					
				
			}			
			
		});
		
	});	
	
	</script>	
	<form id="publishSaveForm" name="publishSaveForm" method="post">	
	<div id="publish-detail-dialog" title="계산서발행일자 일괄처리" style="font-size: 12px;" align="center">				
		<div style="text-align:left;padding-left:10px;padding-top:5px;padding-bottom:5px;">
		<img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
			<b>
				<span style="font-size:13px;color:#666;"> 계산서 발행일자 : </span>
				<input  type="text" class="classCalendar" id="publish_date" name="publish_date" style="width:width:100px;" maxlength="10">
			</b>
			&nbsp;
			<!-- 입금일자 일괄처리버튼 -->
			<input title="세금계산서 발행일자 일괄처리" class="buttonAssistanceDocu" type="button" value="계산서일자 일괄적용" id="publishSaveBtn">
		</div>		
		<div class="tableStyle2" style="width: 550px;">
			<table class="vacation-ins-table">											
				<tr>
					<th>보험사</th>
					<th>접수번호</th>
					<th>제출일</th>
					<th>종결일</th>
					<th>총청구금액</th>				
				</tr>
				<c:choose>
					<c:when test="${invDetailList.size() == 0}">
						<tr>
							<td colspan="5">조회된 인보이스 정보가 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${invDetailList}" var="item" varStatus="status">
							<input type="hidden" name="suim_rpt_no[]" value="${item.suim_rpt_no}"/>
							<tr>
								<td>${item.ptnr_name}</td>
								<td>${item.suim_accept_no}</td>
								<td>${item.invoice_date_fmt}</td>
								<td>${item.close_date_fmt}</td>
								<td style="text-align:right;padding-right:5px;">
									<fmt:formatNumber value="${item.amt_total}" pattern="#,###" /> 원									
								</td>
							</tr>
							<c:set var="total_amount" value="${total_amount + item.amt_total}"></c:set>							
						</c:forEach>
					</c:otherwise>
				</c:choose>
				<tr>
					<th colspan="4">
						합 계
					</th>
					<th style="text-align:right;padding-right:5px;">
						<fmt:formatNumber value="${total_amount}" pattern="#,###" /> 원
					</th>
				</tr>				
			</table>
		</div>
	</div>
	</form>