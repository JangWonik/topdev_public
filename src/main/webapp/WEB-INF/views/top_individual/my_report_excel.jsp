<% response.setCharacterEncoding("UTF-8"); %>
<% response.setHeader("Content-Type", "application/vnd.ms-xls"); %>
<%-- <% response.setHeader("Content-Disposition", "attachment;filename=${user_name}${todate}미결.xls"); %> --%>

<%@ page language="java" contentType="vnd.ms-xls; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="application/vnd.ms-xls; charset=UTF-8">
	<meta charset="UTF-8">
</head>

<body>

	<table cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td colspan="4">
            <p style="line-height:200%;"><font color="#003399" size="4"><b>◈ 미결 및 민원현황</b></font></p>
        </td>
        <td>
            <p>기준일자 : ${todate}</p>
        </td>
        <td>
            <p></p>
        </td>		
        <td><p>&nbsp;</p></td>
        <td><p>&nbsp;</p></td>
        <td><p>&nbsp;</p></td>
        <td><p>&nbsp;</p></td>
        <td rowspan="2">
            <div align="right">
                <table border="1" cellspacing="0" width="160" bordercolordark="white" bordercolorlight="black">
                    <tr>
                        <td>
                            <p align="center"><b>담당</b></p>
                        </td>
                        <td>
                            <p align="center"><b>팀장</b></p>
                        </td>
                        <td>
                            <p align="center"><b>본부장</b></p>
                        </td>
                    </tr>
                    <tr>
                        <td height="50">
                            <p align="center">&nbsp;</p>
                        </td>
                        <td height="50">
                            <p align="center">&nbsp;</p>
                        </td>
                        <td height="50">
                            <p align="center">&nbsp;</p>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <p align="right">팀명 : ${team_name}</p>
        </td>
        <td>
            <p></p>
        </td>
        <td>
            <p>&nbsp;</p>
        </td>
        <td>
            <p>&nbsp;</p>
        </td>
        <td>
            <p></p>
        </td>
        <td><p>&nbsp;</p></td>
        <td><p>&nbsp;</p></td>
        <td><p>&nbsp;</p></td>
        <td><p>&nbsp;</p></td>
        <td><p>&nbsp;</p></td>
    </tr>
    <tr>
        <td>
            <p>&nbsp;</p>
        </td>
        <td>
            <p>&nbsp;</p>
        </td>
        <td>
            <p>&nbsp;</p>
        </td>
        <td>
            <p>&nbsp;</p>
        </td>
        <td>
            <p>&nbsp;</p>
</td>
        <td>
            <p>&nbsp;</p>
        </td>
        <td>
            <p>&nbsp;</p>
        </td>
        <td>
            <p>&nbsp;</p>
</td>
        <td>
            <p>&nbsp;</p>
</td>
        <td>
            <p>&nbsp;</p>
</td>
        <td>
            <p>&nbsp;</p>
        </td>
    </tr>
</table>
<table width=100% align=center border='1' cellpadding=4 cellspacing=0 bordercolorlight='#cccccc' bordercolordark='#FFFFFF'>
<tr align=center height=25>
<th bgcolor='#ccffff'>순번</td>
<th bgcolor='#ccffff'>TOP접수번호</td>
<th bgcolor='#ccffff'>보험사</td>
<th bgcolor='#ccffff'>보험종목</td>
<th bgcolor='#ccffff'>사고</td>
<th bgcolor='#ccffff'>증권번호</td>
<th bgcolor='#ccffff'>계약자</td>
<th bgcolor='#ccffff'>피보험자</td>
<th bgcolor='#ccffff'>피해자</td>
<th bgcolor='#ccffff'>사고개요</td>
<th bgcolor='#ccffff'>문제점/처리방안</td>
<th bgcolor='#ccffff'>진행단계</td>
<th bgcolor='#ccffff'><font color="red">민원가능성</font></td>
<th bgcolor='#ccffff'>수임일</td>
<th bgcolor='#ccffff'>경과일수</td>
<th bgcolor='#ccffff'>종결예정일</td>
<th bgcolor='#ccffff'>참고사항</td>
<th bgcolor='#ccffff'>조사자</td>
</tr>

<c:forEach items="${getMyReportExcel}" var="getMyReportExcelVO" varStatus="status">
<tr>
<td>${getMyReportExcel.size() - status.index}</td>
<td>${getMyReportExcelVO.getSuim_accept_no()}</td>
<td>${getMyReportExcelVO.getPtnr_nick()}</td>
<td>${getMyReportExcelVO.getInsurance_nm()}</td>
<td>${getMyReportExcelVO.getAccident_no()}</td>
<td>${getMyReportExcelVO.getPolicy_no()}</td>
<td>${getMyReportExcelVO.getPolicyholder_nm()}</td>
<td>${getMyReportExcelVO.getBeneficiary_nm()}</td>
<td>${getMyReportExcelVO.getDamaged_nm()}</td>
<td>${getMyReportExcelVO.getAccident_facts()}</td>
<td></td>
<td>
	<c:choose>
		<c:when test="${getMyReportExcelVO.getInterim_Cnt() > 0}">현장보고&nbsp;${getMyReportExcelVO.getInterim_Cnt()}건</c:when>
		<c:when test="${getMyReportExcelVO.getSite_Cnt() > 0 && getMyReportExcelVO.getInterim_Cnt() eq 0}">중간보고</c:when>
		<c:otherwise></c:otherwise>
	</c:choose>
</td>
<td></td>
<td>${getMyReportExcelVO.getReg_date()}</td>
<td>${getMyReportExcelVO.getPast_date()}일</td>
<td></td>
<td></td>
<td>${getMyReportExcelVO.getUser_name()}</td>
</tr>
</c:forEach>

</table>

</body>

</html>
