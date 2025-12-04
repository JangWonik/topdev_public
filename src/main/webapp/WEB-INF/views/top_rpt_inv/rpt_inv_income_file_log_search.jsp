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
		
		$("#logSearchBtn").click(function(){			
			
			var formData = $("#logSearchForm").serialize();
			
			$.ajax({
				type : "post",				
				url : "incomeLogListAjax",
				data : formData,
				success : function(result){					
					$("#logSearchList").html(result);				
				},
				error: function (request, status, error) {			
					console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
				}
			});
			
		});
	});	
	
	</script>
	<div id="income-detail-dialog" title="입금일 파일등록" style="font-size: 12px;text-align:left;">
		<div class="tableStyle2" style="width: 970px;">
			<form id="logSearchForm" name="logSearchForm">
				<table class="tableModal">
					<tr>
						<th style="width:70px;">작업번호</th>
						<td style="width:110px;"><input type="text" id="work_no" name="work_no" value="${paramMap.work_no}" style="width:100px;"/></td>
						<th style="width:70px;">접수번호</th>
						<td style="width:100px;"><input type="text" id="suim_accept_no" name="suim_accept_no"  style="width:90px;"/></td>
						<th style="width:70px;">사고번호</th>
						<td style="width:100px;"><input type="text" id="accident_no" name="accident_no"  style="width:90px;"/></td>
						<th style="width:70px;">계약자명</th>
						<td style="width:100px;"><input type="text" id="policyholder_nm" name="policyholder_nm"  style="width:90px;"/></td>
						<th style="width:70px;">입금일자</th>
						<td style="width:100px;"><input  type="text" class="classCalendar" id="deposit_date" name="deposit_date" style="width:70px;" maxlength="10"></td>
						<td style="width:70px;">
							<input title="검색" class="buttonAssistance" type="button" value="검색" style="width:60px;background-color:darkCyan;" id="logSearchBtn" name="logSearchBtn">
						</td>
					</tr>			
				</table>
			</form>		
		</div>
		<br/>
		<div id="logSearchList"></div>		
	</div>	
	