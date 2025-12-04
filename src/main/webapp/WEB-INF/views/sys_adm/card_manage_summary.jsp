<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<script>
	function doTotalDownload(){		
		$("#doTotalExcelDown").val("1");
	    var frm = document.getElementById("TotalFrm");	    
	    frm.action = "./card_manage_summary";	    
	    frm.submit();
	}
</script>
	
	<form id="TotalFrm">			
		<input type="hidden" id="doTotalExcelDown" name="doTotalExcelDown" value="0"/>
		<input type="hidden" id="viewType" name="viewType" value="Total">
	</form>

	<div style="float: right;padding-bottom:5px;">
		<div style="text-align: right;">
			<img alt="Exceldownload" src="/resources/ls_img/ls_invoice/btn_excel.gif" onclick="javascript:doTotalDownload();" style="cursor:pointer;">&nbsp;
		</div>
	</div>
	<div class= "tableStyle2" style="border-top: 0px;">
		<table style="width: 100%;" align="center">
			<tr>
				<th rowspan="2">구분</th>
				<th height="30px;" colspan="3">카드종류</th>
				<th colspan="5">카드상태</th>
			</tr>
			<tr>				
				<th height="30px;">정상</th>
				<th>임시</th>
				<th>공용</th>				
				<th>미사용</th>
				<th>사용중</th>
				<th>분실</th>
				<th>미반납</th>
				<th>기타</th>
			</tr>
			<tr>
				<th height="30px;">1종 사업부</th>
				<td>${cardSummary1Map.normal_1_cnt}</td>
				<td>${cardSummary1Map.temp_1_cnt}</td>
				<td>${cardSummary1Map.public_1_cnt}</td>
				<td>${cardSummary1Map.state_1_0_cnt}</td>
				<td>${cardSummary1Map.state_1_1_cnt}</td>
				<td>${cardSummary1Map.state_1_2_cnt}</td>
				<td>${cardSummary1Map.state_1_3_cnt}</td>
				<td>${cardSummary1Map.state_1_9_cnt}</td>
			</tr>
			<tr>
				<th height="30px;">4종 사업부</th>
				<td>${cardSummary4Map.normal_4_cnt}</td>
				<td>${cardSummary4Map.temp_4_cnt}</td>
				<td>${cardSummary4Map.public_4_cnt}</td>
				<td>${cardSummary4Map.state_4_0_cnt}</td>
				<td>${cardSummary4Map.state_4_1_cnt}</td>
				<td>${cardSummary4Map.state_4_2_cnt}</td>
				<td>${cardSummary4Map.state_4_3_cnt}</td>
				<td>${cardSummary4Map.state_4_9_cnt}</td>
			</tr>
			<tr>
				<th height="30px;">기타 (미지정)</th>
				<td>${cardSummary9Map.normal_9_cnt}</td>
				<td>${cardSummary9Map.temp_9_cnt}</td>
				<td>${cardSummary9Map.public_9_cnt}</td>
				<td>${cardSummary9Map.state_9_0_cnt}</td>
				<td>${cardSummary9Map.state_9_1_cnt}</td>
				<td>${cardSummary9Map.state_9_2_cnt}</td>
				<td>${cardSummary9Map.state_9_3_cnt}</td>
				<td>${cardSummary9Map.state_9_9_cnt}</td>
			</tr>
			<tr>
				<th height="30px;">합 계</th>
				<th>${cardSummary1Map.normal_1_cnt + cardSummary4Map.normal_4_cnt + cardSummary9Map.normal_9_cnt}</th>
				<th>${cardSummary1Map.temp_1_cnt + cardSummary4Map.temp_4_cnt + cardSummary9Map.temp_9_cnt}</th>
				<th>${cardSummary1Map.public_1_cnt + cardSummary4Map.public_4_cnt + cardSummary9Map.public_9_cnt}</th>
				<th>${cardSummary1Map.state_1_0_cnt + cardSummary4Map.state_4_0_cnt + cardSummary9Map.state_9_0_cnt}</th>
				<th>${cardSummary1Map.state_1_1_cnt + cardSummary4Map.state_4_1_cnt + cardSummary9Map.state_9_1_cnt}</th>
				<th>${cardSummary1Map.state_1_2_cnt + cardSummary4Map.state_4_2_cnt + cardSummary9Map.state_9_2_cnt}</th>
				<th>${cardSummary1Map.state_1_3_cnt + cardSummary4Map.state_4_3_cnt + cardSummary9Map.state_9_3_cnt}</th>
				<th>${cardSummary1Map.state_1_9_cnt + cardSummary4Map.state_4_9_cnt + cardSummary9Map.state_9_9_cnt}</th>
			</tr>
		</table>	
	</div>		