<%-- <% response.setCharacterEncoding("UTF-8"); %> --%>
<%-- <% response.setHeader("Content-Type", "application/vnd.ms-xls"); %> --%>
<%-- <% String fileName = "직원주소록.xls"; %> --%>
<%-- <% fileName = java.net.URLEncoder.encode(fileName,"UTF-8"); %> --%>
<%-- <% response.setHeader("Content-Disposition", "attachment;filename="+fileName); %> --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head> 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
</head>

<body>
<style>p,td{font-size:10pt;}</style>

<table cellpadding="0" cellspacing="0" width="100%">
    <tr>
		<td colspan="12">	
            <p style="line-height:200%;"><font color="#003399" size="5"><b>${title}</b></font></p>
        </td>
        <td colspan="2">
            <p align=right>기준일자 : ${today} </p>
        </td>
    </tr>
    <tr height="10"><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
</table>


<table><!-- t1 -->
<tr>
<td>
<table><!-- t2 -->
<tr>



<td width="45%" style="padding-right:20px;">
	<table width=100% align=center border='1'><!-- t3 -->
		<tr align=center height=25>
			<th bgcolor='#dceb8a'>No</th>
			<th bgcolor='#dceb8a'>회사명</th>
			<th bgcolor='#dceb8a'>부서</th>
			<th bgcolor='#dceb8a'>팀</th>
			<th bgcolor='#dceb8a'>직위</th>
			<th bgcolor='#dceb8a'>직책</th>
			<th bgcolor='#dceb8a'>업종</th>
			<th bgcolor='#dceb8a'>이름</th>
			<th bgcolor='#dceb8a'>휴대전화</th>
			<th bgcolor='#dceb8a'>직통번호</th>
			<th bgcolor='#dceb8a'>팩스</th>
			<th bgcolor='#dceb8a'>Email</th>
			<th bgcolor='#dceb8a'>조사건</th>
			<th bgcolor='#dceb8a'>주소</th>
		</tr>
		
	<c:forEach items="${ptnrList}" var="pList" varStatus="ptnrStatus">
		<tr align="center">
			<!-- No -->
			<td>${ptnrListCnt - ptnrStatus.index}</td>
			<!-- 회사명 -->
			<td>${pList.ptnr_nick}</td>
			<!-- 부서 -->
			<td>${pList.ptnr_dept_nm}</td>
			<!-- 팀 -->
			<td>${pList.ptnr_tm2_nm}</td>
			<!-- 직급 -->
			<td>${pList.ptnr_mbr_position_nm}</td>
			<!-- 직책 -->
			<td>${pList.ptnr_mbr_job_memo}</td>
			<!-- 업종 -->
			<td>${pList.ptnr_mbr_work_type}</td>
			<!-- 이름 -->
			<td>${pList.ptnr_mbr_nm}</td>
			<!-- 휴대전화 -->
			<td>${pList.ptnr_mbr_hp}</td>
			<!-- 직통번호 -->
			<td>${pList.ptnr_mbr_office_tel}</td>
			<!-- 팩스 -->
			<td>${pList.ptnr_mbr_office_fax}</td>
			<!-- Email -->
			<td>${pList.ptnr_mbr_office_email}</td>
			<!-- 조사건 -->
			<td>${pList.ptnr_suim_cnt}</td>
			<!-- 주소 -->
			<td>${pList.ptnr_mbr_office_addr1}</td>
		</tr>
	</c:forEach>
	
	</table><!-- //t3 -->
</td>

</tr>

</table> <!-- //t2 -->			
</td>
</tr>
</table> <!-- //t1 -->



<!-- <table width=100% align=center border='1'> -->
<!-- 	<tr align=center height=25> -->
<!-- 		<th bgcolor='#dceb8a'>권역</th> -->
<!-- 		<th bgcolor='#dceb8a'>부서</th> -->
<!-- 		<th bgcolor='#dceb8a'>성명</th> -->
<!-- 		<th bgcolor='#dceb8a'>직위</th> -->
<!-- 		<th bgcolor='#dceb8a'>직책</th> -->
<!-- 		<th bgcolor='#dceb8a'>직통전화</th> -->
<!-- 		<th bgcolor='#dceb8a'>핸드폰</th> -->
<!-- 		<th bgcolor='#dceb8a'>개인팩스</th> -->
<!-- 		<th bgcolor='#dceb8a'>E-mail</th> -->
<!-- 	</tr> -->
	
<%-- 	<c:forEach items="${teamList_head}" var="tmVo"> --%>
<%-- 		<c:choose> --%>
<%-- 			<c:when test="${tmVo.team_level == 0}"> --%>
<!-- 				<tr> -->
<%-- 					<td rowspan="${tmVo.cnt}"> ${tmVo.team_name}</td> --%>
<%-- 			</c:when> --%>
<%-- 			<c:when test="${tmVo.team_level == 1}"> --%>
<%-- 					<td rowspan="${tmVo.cnt+1}"> ${tmVo.team_name}</td> --%>
<%-- 					<td colspan="7" align="left" bgcolor="#b9d1d6" > ${tmVo.team_addr}</td> --%>
<!-- 				</tr> -->
<%-- 				<c:forEach items="${memberList}" var="memVo"> --%>
<%-- 					<c:if test="${tmVo.team_id == memVo.team_id_main}"> --%>
<!-- 						<tr> -->
<%-- 							<td>${memVo.user_name}</td> --%>
<%-- 							<td>${memVo.work_level_cd}</td> --%>
<%-- 							<td>${memVo.work_type_cd}</td> --%>
<%-- 							<td>${memVo.office_tel}</td> --%>
<%-- 							<td>${memVo.handphone}</td> --%>
<%-- 							<td>${memVo.office_fax}</td> --%>
<%-- 							<td>${memVo.email}</td> --%>
<!-- 						</tr> -->
<%-- 					</c:if> --%>
<%-- 				</c:forEach>	 --%>
<%-- 			</c:when> --%>
<%-- 		</c:choose> --%>
<%-- 	</c:forEach>	 --%>
<!-- </table> -->





<!-- 	<table border="3"> -->
<%-- 		<c:forEach items="${teamList_head}" var="tmVo"> --%>
<%-- 			<c:choose> --%>
<%-- 				<c:when test="${tmVo.team_level == 0}"> --%>
<%-- 						<td rowspan="${tmVo.cnt}">${tmVo.team_name}</td> --%>
<%-- 				</c:when> --%>
<%-- 				<c:when test="${tmVo.team_level == 1}"> --%>
<%-- 						<td rowspan="${tmVo.cnt}">${tmVo.team_name}</td> --%>
<%-- 				</c:when> --%>
<%-- 			</c:choose> --%>
			
<%-- 		</c:forEach> --%>
<!-- 	</table> -->
	




</body>
</html>
