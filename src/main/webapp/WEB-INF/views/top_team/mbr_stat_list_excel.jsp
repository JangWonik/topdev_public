<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head> 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<style>p,td{font-size:10pt;}</style>
</head>
<body>
	<table cellpadding="0" cellspacing="0" width="100%">
	    <tr>
	   	<c:choose>
	   		<c:when test="${title eq '퇴사자 명부' }">
	   			<td colspan="13">
			</c:when>
			<c:otherwise>
				<td colspan="12">	
			</c:otherwise>    
	   	</c:choose>
		<p style="line-height:200%;"><font color="#003399" size="5"><b>${title}</b></font></p>
	        </td>
	        <td colspan="2">
	            <p align=right>기준일자 : ${today} </p>
	        </td>
	    </tr>
    	<tr height="10"><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><!-- <td></td> --></tr>
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
									<th bgcolor='#dceb8a'>센터명</th>
									<th bgcolor='#dceb8a'>부서명</th>
									<th bgcolor='#dceb8a'>보종</th>
									<!-- 180108 직급/직책 에서 직위/직급으로 변경 -->
									<th bgcolor='#dceb8a'>직위</th>
									<th bgcolor='#dceb8a'>직급</th>
									<th bgcolor='#dceb8a'>직책</th>
									<th bgcolor='#dceb8a'>이름</th>
									<th bgcolor='#dceb8a'>아이디</th>
									<th bgcolor='#dceb8a'>이메일</th>
									<th bgcolor='#dceb8a'>휴대전화</th>
									<th bgcolor='#dceb8a'>직통번호</th>
									<th bgcolor='#dceb8a'>개인팩스</th>
									<th bgcolor='#dceb8a'>입사일</th>
									<c:if test="${title eq '퇴사자 명부' }">
										<th bgcolor='#dceb8a'>퇴사일</th>
									</c:if>
									<!-- <th bgcolor='#dceb8a'>집주소</th> -->
								</tr>
								<c:forEach items="${memberList}" var="memList" varStatus="memStatus">
								<tr align="center">
									<td>${memberListCnt - memStatus.index}</td>
									<td>${memList.center_name}</td>
									<td>${memList.team_name}</td>
									<td>
										<c:choose>
											<c:when test="${memList.team_type == 0}">
												총괄
											</c:when>
											<c:otherwise>
												${memList.team_type}종
											</c:otherwise>				
										</c:choose>
									</td>
									<!-- 직책 job_memo -> work_type으로 변경 
									<td>${memList.job_memo}</td> -->			
									<td>${memList.work_level}</td>
									<td>${memList.work_rank}</td>
									<td>${memList.work_type}</td>			
									<td>			
										<c:choose>
											<c:when test="${mbrVo.user_state eq 9}">
												${memList.user_name}<br/>${memList.user_no}
											</c:when>
											<c:otherwise>${memList.user_name}</c:otherwise>
										</c:choose>
									</td>
									<td>${memList.user_id}</td>
									<td>${memList.email}</td>
									<td>${memList.handphone}</td>
									<td>${memList.office_tel}</td>
									<td>${memList.office_fax}</td>
									<td>
										<c:choose>
											<c:when test='${memList.join_date == "1970-01-01"}'></c:when>
											<c:otherwise>${memList.join_date}</c:otherwise>
										</c:choose>
									</td>									
									<c:if test="${title eq '퇴사자 명부' }">
										<td>${memList.out_date}</td>
									</c:if>
									<%-- <td>${memList.home_address}</td> --%>
								</tr>
								</c:forEach>
							</table><!-- //t3 -->
						</td>
					</tr>
				</table> <!-- //t2 -->			
			</td>
		</tr>
	</table> <!-- //t1 -->
</body>
</html>