<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
<style>
	/* 모달 버튼 */
	.ui-button-text-only {
		height:2.1em !important;
	}	
</style>					
<div id="vacation-detail-dialog" title="파일다운로드" style="font-size: 12px;" align="center">
	<br/>
	<form id="downForm_${paramMap.key}" method="GET">
		<!-- 엔터키막기용 input by top3009-->
		<input hidden="hidden"/>
		<input type="hidden" id="key" name="key" value="${paramMap.key}"/>
		<input type="hidden" id="type" name="type" value="${paramMap.type}"/>
		<input type="hidden" id="suimRptNo" name="suimRptNo" value="${paramMap.suimRptNo}"/>
		<div class="tableStyle2" style="width: 450px;">
			<table class="vacation-ins-table">			
				<tr>
					<th width="30%">파일명</th>
					<td width="70%">${paramMap.fileName}</td>
				</tr>
				<tr>
					<th>다운로드 사유</th>
					<td><input type="text" id="downComment_${paramMap.key}" name="downComment" style="width:300px;" maxlength="100"></td>
				</tr>
				<tr>
					<td colspan="2" style="height:35px;">
						<a href="#noloc" class="buttonEduDown" id="btn-search" onclick="javascript:doDownCancel();">취소</a>
						<a href="#noloc" class="buttonEduView" id="btn-search" onclick="javascript:doDownStart(${paramMap.key});">다운로드</a>
					</td>
				</tr>																																										
			</table>
		</div>	
	</form>
</div>