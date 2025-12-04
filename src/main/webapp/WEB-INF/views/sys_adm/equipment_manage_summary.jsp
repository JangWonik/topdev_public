<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<script>
	function doTotalDownload(){		
		$("#doTotalExcelDown").val("1");
	    var frm = document.getElementById("TotalFrm");	    
	    frm.action = "./equipment_manage_summary";	    
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
				<th colspan="4" height="30px;">재직인원현황</th>
			</tr>
			<tr>
				<th height="25px;">총 괄</th>
				<th>1종 사업부</th>
				<th>4종 사업부</th>
				<th>총 합</th>								
			</tr>
			<tr>
				<td height="25px;">${worktype_cnt.get(0).getCnt()} 명</td>
				<td>
					<c:out value="${worktype_cnt.get(1).getCnt()+worktype_cnt.get(2).getCnt()
					+worktype_cnt.get(3).getCnt()+worktype_cnt.get(4).getCnt()
					+worktype_cnt.get(9).getCnt()+worktype_cnt.get(10).getCnt()+worktype_cnt.get(13).getCnt()}"/> 명
				</td>
				<td>
					<c:out value="${worktype_cnt.get(5).getCnt()+worktype_cnt.get(6).getCnt()
					+worktype_cnt.get(7).getCnt()+worktype_cnt.get(8).getCnt()
					+worktype_cnt.get(11).getCnt()+worktype_cnt.get(12).getCnt()+worktype_cnt.get(14).getCnt()}"/> 명
				</td>
				<td>
					<c:out value="${worktype_cnt.get(0).getCnt()
					+worktype_cnt.get(1).getCnt()+worktype_cnt.get(2).getCnt()
					+worktype_cnt.get(3).getCnt()+worktype_cnt.get(4).getCnt()
					+worktype_cnt.get(9).getCnt()+worktype_cnt.get(10).getCnt()
					+worktype_cnt.get(5).getCnt()+worktype_cnt.get(6).getCnt()
					+worktype_cnt.get(7).getCnt()+worktype_cnt.get(8).getCnt()
					+worktype_cnt.get(11).getCnt()+worktype_cnt.get(12).getCnt()
					+worktype_cnt.get(13).getCnt()+worktype_cnt.get(14).getCnt()}"/> 명
				</td>
			</tr>
		</table>	
	</div>
	<br/>
	<div class= "tableStyle2" style="border-top: 5px;">
		<table style="width: 100%;" align="center">
			<tr>
				<th height="30px;">장비종류</th>
				<th>사용중</th>
				<th>사용가능 (대기)</th>
				<th>사용불가능 (고장+보류)</th>
				<th>미회수</th>
				<th>총 계</th>
			</tr>
			<c:forEach var="item" items="${eqSummary}">
				<c:set var="eq_use_cnt" value="${item.eq_use_cnt}"/>
				<c:set var="eq_wait_cnt" value="${item.eq_wait_cnt}"/>
				<c:set var="eq_break_hold_cnt" value="${item.eq_break_cnt+item.eq_hold_cnt}"/>
				<c:set var="eq_un_collect_cnt" value="${item.eq_uncollect_cnt}"/>
				<c:set var="eq_total_cnt" value="${item.eq_use_cnt + item.eq_wait_cnt + item.eq_break_cnt + item.eq_hold_cnt + item.eq_uncollect_cnt}"/>
				<tr>
					<th height="25px;">${item.col_val}</th>
					<td>${eq_use_cnt}</td>
					<td>${eq_wait_cnt}</td>
					<td>${eq_break_hold_cnt}</td>
					<td>${eq_un_collect_cnt}</td>
					<td>${eq_total_cnt}</td>
				</tr>
				<c:set var="total_eq_use_cnt" value="${total_eq_use_cnt + eq_use_cnt}"/>
				<c:set var="total_eq_wait_cnt" value="${total_eq_wait_cnt + eq_wait_cnt}"/>
				<c:set var="total_eq_break_hold_cnt" value="${total_eq_break_hold_cnt + eq_break_hold_cnt}"/>
				<c:set var="total_eq_un_collect_cnt" value="${total_eq_un_collect_cnt + eq_un_collect_cnt}"/>
				<c:set var="total_eq_total_cnt" value="${total_eq_total_cnt + eq_total_cnt}"/>				
			</c:forEach>
			<tr>
				<th height="30px;">합 계</th>
				<th>${total_eq_use_cnt}</th>
				<th>${total_eq_wait_cnt}</th>
				<th>${total_eq_break_hold_cnt}</th>
				<th>${total_eq_un_collect_cnt}</th>
				<th>${total_eq_total_cnt}</th>
			</tr>
		</table>
	</div>	