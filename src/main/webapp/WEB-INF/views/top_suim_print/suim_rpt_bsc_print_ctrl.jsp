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
         <p>&nbsp;</p>
			<table cellpadding="0" cellspacing="0" width="648" align="center">
				<tr>
					<td width="648" height="45" class="td">
						<p style="line-height:200%;" align="center"><font size="5"><b>사 고 처 리 과 정 표</b></font></p>
					</td>
				</tr>
			</table>
			<table align="center" cellpadding="0" cellspacing="0" width="648">
				<tr>
					<td height="25" width="50%">
						<p class="p2"><b>처리과정(서류접수 현황포함)</b></p>
					</td>
					<td height="25" width="50%">
						<p>&nbsp;</p>
					</td>
				</tr>
			</table>
			<table cellSpacing=0 cellPadding="0" width="648" align="center" bordercolordark="white" bordercolorlight="#999999">
				<tr>
					<td bgcolor="#ECECEC" class="td" width="208">
						<p align="center"><b>일 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자</b></td>
					<td bgcolor="#ECECEC" class="td" width="208">
						<p align="center"><b>항 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</b></td>
					<td bgcolor="#ECECEC" class="td" width="220">
						<p align="center"><b>처 &nbsp;리 &nbsp;내 &nbsp;용</b></p>
					</td>
				</tr>
				<tbody id="print1_Ctrl">
				<c:forEach items="${sagoList }" var="sagoVo">
					<tr id = "print1_Ctrl_${sagoVo.sagoNo }">
						<td class="td">
							<p align="center">${sagoVo.regDate }</p></td>
						<td class="td">
							<p align="center">${sagoVo.item }</p></td>
						<td class="td">
							<p align="center">${sagoVo.content }</p>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<p>&nbsp;</p>
</body>
<p>&nbsp;</p>