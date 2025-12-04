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
	<script>
		/* function goMmrState(team_id){
			location.href = "topMemberState?team_id="+team_id;
		} */
		
		function excMemberTel(){
			excelTelForm.submit();
		}
	</script>
</head>

<body>
<style>p,td{font-size:8pt;}</style>

<table cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td colspan="7">
            <p style="line-height:200%;"><font color="#003399" size="4"><b>탑손해사정(주) 연락처</b></font></p>
        </td>
        <td colspan="2">
            <p align=right>기준일자 : ${today} </p>
        </td>
    </tr>
    <tr height="25">
    	<td colspan="9">
    		<p align="right">※ 팀 내 겸직인원이 존재하는 경우 () 괄호안에 겸직 포함인원으로 표시됩니다.</p>
    	</td>
    </tr>
</table>




<table><!-- t1 -->
<tr>
<td>
<table><!-- t2 -->
<tr>

<c:if test="${gubun eq 'all' || gubun eq 'kind1' || gubun eq 'kind0'}">


<td width="45%" style="padding-right:20px;">
	<c:if test="${gubun eq 'all' || gubun eq 'kind0'}">
		<table cellpadding="0" cellspacing="0" width="100%">
		    <tr>
		        <td colspan="9">
		            <p><font color="#003399" size="2"><b>본사 사업부</b></font></p>
		        </td>
		    </tr>
		</table>
		<table width=100% align=center border='1'><!-- t3 -->
			<tr align=center height=25>
				<th bgcolor='#dceb8a'>권역</th>
				<th bgcolor='#dceb8a'>부서</th>
				<th bgcolor='#dceb8a'>성명</th>
				<!-- 180108 직급/직책 에서 직위/직급으로 변경 -->
				<th bgcolor='#dceb8a'>직위</th>
				<!-- <th bgcolor='#dceb8a'>직급</th> -->
				<th bgcolor='#dceb8a'>직책</th>
				<th bgcolor='#dceb8a'>직통전화</th>
				<th bgcolor='#dceb8a'>핸드폰</th>
				<th bgcolor='#dceb8a'>개인팩스</th>
				<th bgcolor='#dceb8a'>E-mail</th>
			</tr>
	
	
			<c:forEach items="${teamList_head}" var="tmVo">
				<c:if test="${tmVo.cnt > 0}">
					<c:choose>
						<c:when test="${tmVo.team_level == 0}">
							<c:set var="flag" value="0" />
							<tr align="center">
								<td rowspan="${tmVo.cnt}"> ${tmVo.team_name} ${tmVo.member_cnt - tmVo.sub_cnt}명 (${tmVo.member_cnt}명)</td>
						</c:when>
						
						<c:otherwise>
							<c:if test="${flag == 1}">
								<tr align="center">
							</c:if>
								<td rowspan="${tmVo.cnt+1}"> ${tmVo.team_name} ${tmVo.member_cnt - tmVo.sub_cnt}명 (${tmVo.member_cnt}명)</td>
								<td colspan="7" align="left" bgcolor="#b9d1d6" > ${tmVo.team_addr}</td>
							</tr>
							<c:set var="flag" value="1" />
							
							<c:forEach items="${memberList}" var="memVo">
								<c:if test="${tmVo.team_id == memVo.team_id_loc}">
									<tr align="center">
										<td>${memVo.user_name}</td>
										<td>${memVo.work_level_cd}</td>
										<td>${memVo.work_type_cd}</td>
										<td>${memVo.office_tel}</td>
										<td>${memVo.handphone}</td>
										<td>${memVo.office_fax}</td>
										<td>${memVo.email}</td>
									</tr>
								</c:if>
							</c:forEach>	
						</c:otherwise>
					</c:choose>
				</c:if>
				
			</c:forEach>	
		</table><!-- //t3 -->
		
		</c:if>
	
	
	<c:if test="${gubun eq 'all' || gubun eq 'kind1'}">
	
		<table cellpadding="0" cellspacing="0" width="100%">
		    <tr>
		        <td colspan="9">
		            <p><font color="#003399" size="2"><b>1종 사업부</b></font></p>
		        </td>
		    </tr>
		</table>
		
		<table width=100% align=center border='1'><!-- t3 -->
			<tr align=center height=25>
				<th bgcolor='#dceb8a'>권역</th>
				<th bgcolor='#dceb8a'>부서</th>
				<th bgcolor='#dceb8a'>성명</th>
				<!-- 180108 직급/직책 에서 직위/직급으로 변경 -->
				<th bgcolor='#dceb8a'>직위</th>
				<!-- <th bgcolor='#dceb8a'>직급</th> -->
				<th bgcolor='#dceb8a'>직책</th>
				<th bgcolor='#dceb8a'>직통전화</th>
				<th bgcolor='#dceb8a'>핸드폰</th>
				<th bgcolor='#dceb8a'>개인팩스</th>
				<th bgcolor='#dceb8a'>E-mail</th>
			</tr>
			
			<c:forEach items="${teamList_1}" var="tmVo">				
				<c:if test="${tmVo.cnt > 0}">
					<c:choose>
						<c:when test="${tmVo.team_level == 0}">
							<c:set var="flag" value="0" />
							<tr align="center">
								<td rowspan="${tmVo.cnt}"> ${tmVo.team_name} ${tmVo.member_cnt - tmVo.sub_cnt}명 (${tmVo.member_cnt}명)</td>
						</c:when>
						
						<c:otherwise>
							<c:if test="${flag == 1}">
								<tr align="center">
							</c:if>
								<td rowspan="${tmVo.cnt+1}"> ${tmVo.team_name} ${tmVo.member_cnt - tmVo.sub_cnt}명 (${tmVo.member_cnt}명)</td>
								<td colspan="7" align="left" bgcolor="#b9d1d6" > ${tmVo.team_addr}</td>
							</tr>
							<c:set var="flag" value="1" />
							
							<c:forEach items="${memberList}" var="memVo">
								<c:choose>
									<c:when test="${tmVo.team_id != memVo.team_id_loc}"></c:when>
									<c:otherwise>
										<c:if test="${memVo.is_sub == '1'}">
											<tr align="center">
												<td bgcolor="#FFFF00">${memVo.user_name} (겸직)</td>
												<td bgcolor="#FFFF00">${memVo.work_level_cd}</td>
												<td bgcolor="#FFFF00">${memVo.work_type_cd}</td>
												<td bgcolor="#FFFF00">${memVo.office_tel}</td>
												<td bgcolor="#FFFF00">${memVo.handphone}</td>
												<td bgcolor="#FFFF00">${memVo.office_fax}</td>
												<td bgcolor="#FFFF00">${memVo.email}</td>
											</tr>	
										</c:if>
										<c:if test="${memVo.is_sub == '0'}">
											<tr align="center">
												<td>${memVo.user_name}</td>
												<td>${memVo.work_level_cd}</td>
												<td>${memVo.work_type_cd}</td>
												<td>${memVo.office_tel}</td>
												<td>${memVo.handphone}</td>
												<td>${memVo.office_fax}</td>
												<td>${memVo.email}</td>
											</tr>
										</c:if>										
									</c:otherwise>
								</c:choose>
							</c:forEach>	
						</c:otherwise>
					</c:choose>
				</c:if>	
			</c:forEach>	
		</table><!-- //t3 -->
	</c:if>
</td>
<td></td>


</c:if>



<td width="45%" valign="top" style="padding-left:20px;">
	<c:if test="${gubun eq 'all' || gubun eq 'kind4'}">

		<table cellpadding="0" cellspacing="0" width="100%">
		    <tr>
		        <td colspan="9">
		            <p><font color="#003399" size="2"><b>4종 사업부</b></font></p>
		        </td>
		    </tr>
		</table>
		
		<table width=100% align=center border='1'><!-- t3 -->
			<tr align=center height=25>
				<th bgcolor='#dceb8a'>권역</th>
				<th bgcolor='#dceb8a'>부서</th>
				<th bgcolor='#dceb8a'>성명</th>
				<!-- 180108 직급/직책 에서 직위/직급으로 변경 -->
				<th bgcolor='#dceb8a'>직위</th>
				<th bgcolor='#dceb8a'>직급</th>
				<th bgcolor='#dceb8a'>직통전화</th>
				<th bgcolor='#dceb8a'>핸드폰</th>
				<th bgcolor='#dceb8a'>개인팩스</th>
				<th bgcolor='#dceb8a'>E-mail</th>
			</tr>
			
			<c:forEach items="${teamList_4}" var="tmVo">
				<c:if test="${tmVo.cnt > 0}">
					<c:choose>
						<c:when test="${tmVo.team_level == 0}">
							<c:set var="flag" value="0" />
							<tr align="center">
								<td rowspan="${tmVo.cnt}"> ${tmVo.team_name} ${tmVo.member_cnt - tmVo.sub_cnt}명 (${tmVo.member_cnt}명)</td>
						</c:when>
						
						<c:otherwise>
							<c:if test="${flag == 1}">
								<tr align="center">
							</c:if>
								<td rowspan="${tmVo.cnt+1}"> ${tmVo.team_name} ${tmVo.member_cnt - tmVo.sub_cnt}명 (${tmVo.member_cnt}명)</td>
								<td colspan="7" align="left" bgcolor="#b9d1d6" > ${tmVo.team_addr}</td>
							</tr>
							<c:set var="flag" value="1" />
							
							<c:forEach items="${memberList}" var="memVo">
								<c:choose>
									<c:when test="${tmVo.team_id != memVo.team_id_loc}"></c:when>
									<c:otherwise>
										<c:if test="${memVo.is_sub == '1'}">
											<tr align="center">
												<td bgcolor="#FFFF00">${memVo.user_name} (겸직)</td>
												<td bgcolor="#FFFF00">${memVo.work_level_cd}</td>
												<td bgcolor="#FFFF00">${memVo.work_type_cd}</td>
												<td bgcolor="#FFFF00">${memVo.office_tel}</td>
												<td bgcolor="#FFFF00">${memVo.handphone}</td>
												<td bgcolor="#FFFF00">${memVo.office_fax}</td>
												<td bgcolor="#FFFF00">${memVo.email}</td>
											</tr>	
										</c:if>
										<c:if test="${memVo.is_sub == '0'}">
											<tr align="center">
												<td>${memVo.user_name}</td>
												<td>${memVo.work_level_cd}</td>
												<td>${memVo.work_type_cd}</td>
												<td>${memVo.office_tel}</td>
												<td>${memVo.handphone}</td>
												<td>${memVo.office_fax}</td>
												<td>${memVo.email}</td>
											</tr>
										</c:if>										
									</c:otherwise>
								</c:choose>
								<%-- <c:if test="${tmVo.team_id == memVo.team_id_loc}">
									<tr align="center">
										<td>${memVo.user_name}</td>
										<td>${memVo.work_level_cd}</td>
										<td>${memVo.work_type_cd}</td>
										<td>${memVo.office_tel}</td>
										<td>${memVo.handphone}</td>
										<td>${memVo.office_fax}</td>
										<td>${memVo.email}</td>
									</tr>
								</c:if>	 --%>						
							</c:forEach>	
						</c:otherwise>
					</c:choose>
				</c:if>				
			</c:forEach>	
		</table><!-- //t3 -->
	</c:if>
</td>

</tr>
</table> <!-- //t2 -->			
</td>
</tr>
</table> <!-- //t1 -->





</body>
</html>
