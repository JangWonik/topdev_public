<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Language" content="ko"> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
	<title>${title_Session}</title>

<style>
	p {color:#000000; font-size:12pt; line-height:150%; margin-top:0; margin-bottom:0; font-family:돋움,돋움체;}
	table {border-collapse:collapse;border-spacing:0; color:#000000; font-size:12pt; line-height:150%; margin-top:0; margin-bottom:0; font-family:돋움,돋움체;}
	.td {border:1px solid #666666; padding:3px; color:#000000; font-size:12pt; line-height:150%; margin-top:0; margin-bottom:0; font-family:돋움,돋움체;}
	H2.breakhere {page-break-before: always}
	body{margin-left:0;margin-right:0;margin-top:0;margin-bottom:0;}
</style>

</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<table cellpadding="0" cellspacing="0" width="100%" align="center">
	<tr>
		<td width="100%">
			<p>&nbsp;</p>
			<p>&nbsp;</p>
			<p style="line-height:200%;" align="center"><b><font size="5">재 직 증 명 서</font></b></p>
			<p>&nbsp;</p>
			<p>&nbsp;</p>
			<table cellpadding="0" cellspacing="0" width="640" align="center">
				<tr align="center" height='50'>
					<td class="td" width="20%">
						<p>성명</p>
					</td>
					<td class="td" width="30%">
						<p>${certPrintVo.user_name}</p>
					</td>
					<td class="td" width="20%">
						<p>생년월일</p>
					</td>
					<td class="td" width="30%">
						<p>${certPrintVo.birthDay}</p>
					</td>
				</tr>
				<tr align="center" height='50'>
					<td class="td">
						<p>주소</p>
					</td>
					<td class="td" colspan="3">
						<p>${certPrintVo.home_address}</p>
					</td>
				</tr>
				<tr align="center" height='50'>
					<td class="td">
						<p>근무부서</p>
					</td>
					<td class="td">
						<p>${certPrintVo.team_name}</p>
					</td>
					<td class="td">
						<p>직위</p>
					</td>
					<td class="td">
						<p>${certPrintVo.work_level }</p>
					</td>
				</tr>
				<tr align="center" height='50'>
					<td class="td" rowspan="2">
						<p>근무기간</p>
					</td>
					<td class="td">
						<p>입사일</p>
					</td>
					<td class="td" colspan="2">
						<p> ${certPrintVo.join_date } 부터</p>
					</td>
				</tr>
				<tr align="center" height='50'>
					<td class="td">
						<p>현재일</p>
					</td>
					<td class="td" colspan="2">
						<p> ${certPrintVo.now} 현재</p>
					</td>
				</tr>
				<tr align="center" height='50'>
					<td class="td">
						<p>용도</p>
					</td>
					<td class="td" colspan="3">
						<p>${certPrintVo.issue_reason} </p>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" width="640" align="center">
				<tr align="center">
					<td class="td">
						<p>&nbsp;</p>
						<p>&nbsp;</p>
						<p>상기와 같이 증명합니다.</p>
						<p>&nbsp;</p>
						<p>&nbsp;</p>
						<p>&nbsp;</p>
						<p>&nbsp;</p>
						<p>&nbsp;</p>
						<p> ${certPrintVo.now}</p>
						<p>&nbsp;</p>
						<p>&nbsp;</p>
						<p align="center">
<!-- 							<img src="./resources/ls_img/report/sign_report.jpg" border="0"> -->
							<img src="./resources/ne_img/sign_salary.jpg" width="260" height="99" border="0"/>
						</p>
						<p>&nbsp;</p>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<script language="JavaScript">
<!--
window.print();
-->
</script>
</body>
</html>