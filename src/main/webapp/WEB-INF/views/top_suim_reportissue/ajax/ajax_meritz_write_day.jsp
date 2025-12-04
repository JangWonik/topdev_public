<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	$(document).ready(function(){
		_initCalendar();						
	});
</script>
</head>
<c:if test="${ write_edit_type eq 'view' }">
	<div class="display-table" style="margin-top: 20px;text-align:center;">
        <div class="display-cell">
			<p class="subtitle">
				${write_date} <a href="#noloc" id="btn_wirte_date_edit" onclick="fnWriteDateSaveUp();"><img src="./resources/ls_img/btn_edit_s.gif"/></a>
			</p>
		</div>
	</div>
</c:if>

<c:if test="${ write_edit_type eq 'edit' }">
	<form name="writeEditForm" id="writeEditForm" method="post">
	<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${suim_rpt_no}">
	<input type="hidden" id="write_edit_type" name="write_edit_type" value="view">
		<div class="display-table" style="margin-top: 20px;text-align:center;">
        <div class="display-cell">
			<p class="subtitle">				 
				<input class="calendar" type="text" id="write_date" name="write_date" value="${write_date}" style="width: 15%;"/>				
				<a id="btn_issue_write_date_save" href="#noloc" onclick="fnIssueWriteDateSave();"><input type="button" value="저장" class="buttonAssistance" title="저장"></a>
				<a id="btn_issue_write_cancel" href="#noloc" onclick="fnIssueWriteDateCancel();"><input type="button" value="취소" style="background-color:#FA58F4;" class="buttonAssistance" title="취소"></a>
			</p>
		</div>
	</div>		
	</form>
</c:if>