<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<script src="./resources/jquery/jquery.min_1_12.js"></script>
<style type="text/css">
<!--
td {color:#000000; font-size:10pt; line-height:130%; margin-top:0; margin-bottom:0; font-family:돋음,돋음체;}
p {color:#000000; font-size:10pt; line-height:130%; margin-top:0; margin-bottom:0; font-family:돋음,돋음체;}
table {border-collapse:collapse;border-spacing:0; font-size:9pt;}
.td {border:1px solid #000000; padding:3px;}

body {
background-color:#ffffff;
color:#000000;
font-family:굴림,굴림체;
font-size:10pt;
margin-left:0;margin-right:0;margin-top:0;margin-bottom:0;
border: 1px #000000; color: #000000;
}
-->
</style>
</head>
<body>
<br/>
<br/>
<br/>
<table align="center" cellpadding="0" cellspacing="0" width="660" border="1">
	<tr>
		<td colspan="2" height="40" align="center">
			<span style="font-size:12pt;">
			<b><u>사 고 처 리 과 정 표</u></b>
			</span>
			(${suimVo.suim_accept_no})
		</td>
		<td align="center" width="15%">담 당 자</td>
		<td width="35%" style="text-align:left;padding-left:5px;">${suimVo.user_name}</td>
	</tr>
	<tr>
		<td height="30" align="center" width="15%">보 험 종 목</td>
		<td width="35%" style="text-align:left;padding-left:5px;">${suimVo.insurance_nm}</td>
		<td align="center" width="15%">보 험 사</td>
		<td width="35%" style="text-align:left;padding-left:5px;">${suimVo.ptnr_name}</td>
	</tr>
	<tr>
		<td height="30" align="center" width="15%">사 고 번 호</td>
		<td width="35%" style="text-align:left;padding-left:5px;">${suimVo.accident_no}</td>
		<td align="center" width="15%">증 권 번 호</td>
		<td width="35%" style="text-align:left;padding-left:5px;">${suimVo.policy_no}</td>
	</tr>
	<tr>
		<td height="30" align="center" width="15%">보험사담당</td>
		<td width="35%" style="text-align:left;padding-left:5px;">
			${suimVo.ptnr_mbr_nm}
			<%-- 보험사 담당 직위추가 시작 --%>
			<c:if test="${not empty suimVo.ptnr_mbr_position_nm}">
				${suimVo.ptnr_mbr_position_nm}
			</c:if>
			<%-- 보험사 담당 직위추가 끝 --%>
		</td>
		<td align="center" width="15%">계 약 자</td>
		<td width="35%" style="text-align:left;padding-left:5px;">${suimVo.policyholder_nm}</td>
	</tr>
	<tr>
		<td height="30" align="center" width="15%">연 락 처</td>
		<td width="35%" style="text-align:left;padding-left:5px;">${suimVo.ptnr_mbr_office_tel}</td>
		<td align="center" width="15%">연 락 처</td>
		<td width="35%" style="text-align:left;padding-left:5px;">${suimVo.policyholder_tel}</td>
	</tr>
	<tr>
		<td height="30" align="center" width="15%">피 해 자</td>
		<td width="35%" style="text-align:left;padding-left:5px;">${suimVo.damaged_nm}</td>
		<td align="center" width="15%">피 보 험 자</td>
		<td width="35%" style="text-align:left;padding-left:5px;">${suimVo.beneficiary_nm}</td>
	</tr>
	<tr>
		<td height="30" align="center" width="15%">연 락 처</td>
		<td width="35%" style="text-align:left;padding-left:5px;">${suimVo.damaged_tel}</td>
		<td align="center" width="15%">연 락 처</td>
		<td width="35%" style="text-align:left;padding-left:5px;">${suimVo.beneficiary_tel}</td>
	</tr>	
	<tr>
		<td height="30" align="center" width="15%">관련자</td>		
		<td width="85%" style="text-align:left;padding-left:5px;" colspan="3"></td>
	</tr>
	<tr>
		<td height="30" align="center" width="15%">사 고 일 자</td>
		<td width="35%" style="text-align:left;padding-left:5px;">${suimVo.accident_date}</td>
		<td align="center" width="15%">수 임 일 자</td>
		<td width="35%" style="text-align:left;padding-left:5px;">${suimVo.reg_date}</td>
	</tr>
</table>
<br/>
<table align="center" cellpadding="0" cellspacing="0" width="660" border="1">
	<tr>
		<td height="45" align="center" width="15%">사 고 내 용</td>		
		<td width="85%" style="text-align:left;padding-left:5px;">${suimVo.accident_facts}</td>
	</tr>
	<tr>
		<td height="45" align="center" width="15%">특 이 사 항</td>		
		<td width="85%" style="text-align:left;padding-left:5px;">${suimVo.reference_facts}</td>
	</tr>
</table>
<br/>
<table align="center" cellpadding="0" cellspacing="0" width="660">
	<tr>
		<td style="padding-bottom:5px;">
			<span style="font-size:11pt;">
			◈ 처리과정 (서류접수, 유선통화, 약속 등)
			</span>
		</td>
	</tr>
</table>
<table align="center" cellpadding="0" cellspacing="0" width="660" border="1">
	<tr>
		<td width="5%" height="30" align="center">
			No			
		</td>			
		<td width="15%" align="center">
			처 리 일 자
		</td>
		<td width="50%" align="center">
			처 리 내 용
		</td>
		<td width="30%" align="center">
			팀장 지시 및 결재 
		</td>
	</tr>	
	<c:forEach var="index" begin="1" end="16">
	<tr>
		<td width="5%" height="30" align="center">
			${index}			
		</td>			
		<td width="15%" align="center">
			
		</td>
		<td width="50%" align="center">
			
		</td>
		<td width="30%" align="center">
			 
		</td>
	</tr>
	</c:forEach>
</table>
	<script language="JavaScript">
		 window.print();
	</script>	
</body>
</html>