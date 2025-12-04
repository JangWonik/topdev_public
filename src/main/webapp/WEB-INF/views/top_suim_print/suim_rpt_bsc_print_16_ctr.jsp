<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	
	<script>
		$(document).ready(function(){
			
		});


	</script>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
	<table align="center" cellpadding="0" cellspacing="0" width="100%" bgcolor="white">
		<tr>
			<td width="50%" height="30">
				<p><font color="#113F7D">▣ <b>사고조사 처리과정</b></font></p>
			</td>
			<td width="50%" height="30">
				
			</td>
		</tr>
		<tr><td width="100%" height="1" colspan="2" bgcolor="#0077B1"></td></tr>
	</table>
	<table align="center" width="640">
		<tr align="center" bgcolor="#efefef">
			<td class="td" ><p><b>진행일시</b></p></td>
			<td class="td" ><p><b>주요내용</b></p></td>
			<td class="td" ><p><b>면담자</b></p></td>
			<td class="td" ><p><b>관계</b></p></td>
			<td class="td" ><p><b>접촉방법</b></p></td>
		</tr>
		<tbody align="center" id = "sagoList16">
			<c:forEach items="${sagoList}" var="sagoRptVo16">
				<tr id = "print16_Ctrl_${sagoRptVo16.serialNo}" >
					<td class="td">
						<span id = "controlDate16_${sagoRptVo16.serialNo}">${sagoRptVo16.controlDate}</span>
					</td>
					<td class="td">
						<span id = "controlMemo16_${sagoRptVo16.serialNo}">${sagoRptVo16.controlMemoSpan}</span>
					</td>
					<td class="td">
						<span id = "controlWho16_${sagoRptVo16.serialNo}">${sagoRptVo16.controlWho}</span>
					</td>
					<td class="td">
						<span id = "controlRelation16_${sagoRptVo16.serialNo}">${sagoRptVo16.controlRelation}</span>
					</td>
					<td class="td">
						<span id = "controlContact16_${sagoRptVo16.serialNo}">${sagoRptVo16.controlContact}</span>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<p>&nbsp;</p>
</body>