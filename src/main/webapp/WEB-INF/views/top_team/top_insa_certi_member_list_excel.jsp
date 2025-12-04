<%@ page language="java" contentType="vnd.ms-xls; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date,java.text.DateFormat,java.text.SimpleDateFormat,java.io.UnsupportedEncodingException"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% response.setCharacterEncoding("UTF-8"); %>
<% response.setHeader("Content-Type", "application/vnd.ms-xls"); %>
<%
		Date today = new Date();
		DateFormat timeForNaming = new SimpleDateFormat("yyyyMMdd");
		String filename = "인사관리_직원자격현황_"+timeForNaming.format(today);//String형으로 변환
		try {
			filename = java.net.URLEncoder.encode(filename,"UTF-8").replaceAll("\\+", "_");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
%>
<% response.setHeader("Content-Disposition", "attachment;filename="+filename+".xls"); %>
<table border="1">
	<tr>
		<th width="80px">순번</th>
		<th width="180px">센터명</th>
		<th width="180px">부서명</th>
		<th width="130px">이름</th>		
		<th width="150px">등록구분</th>
		<th width="100px">등록보종</th>
		<th width="120px">등록번호</th>
		<th width="100px">등록일자</th>
		<th width="300px">담당 손해사정사</th>
		<th width="300px">비고</th>
	</tr>
	<c:choose>
		<c:when test="${certiMemberList.size() == 0}">
			<tr>
				<td colspan="9" style="text-align:center;">
					검색된 결과가 없습니다.
				</td>
			</tr>		
		</c:when>
		<c:otherwise>			
			<c:forEach items="${certiMemberList}" var="memberVo" varStatus="status">
				<tr>
					<td style="width:80px;">${certiMemberList.size() - status.index}</td>
					<td style="width:180px;">${memberVo.center_name}</td>
					<td style="width:180px;">${memberVo.team_name}</td>
					<td style="width:130px;">${memberVo.user_name}</td>
					<%-- <td style="width:100px;">
						<c:choose>
							<c:when test="${memberVo.user_state eq 1}"><font color="red">퇴사</font></c:when>
							<c:otherwise>재직중</c:otherwise>
						</c:choose>							
					</td> --%>						
					<td style="width:150px;">
						<c:choose>								
						<c:when test="${memberVo.certi_state eq 1}"><font color="green">보조인 자격 충족</font></c:when>
						<c:when test="${memberVo.certi_state eq 2}"><font color="orange">보조인 자격 불충족</font></c:when>
						<c:when test="${memberVo.certi_state eq 3}">비대상</c:when>
						<c:when test="${memberVo.certi_state eq 4}"><font color="blue">손해사정사</font></c:when>
						<c:when test="${memberVo.certi_state eq 6}"><font color="purple">손해사정사+보조인</font></c:when>
						<c:otherwise><font color="red">미등록</font></c:otherwise>
					</c:choose>
					</td>
					<td style="width:100px;">${memberVo.certi_type_nm}</td>
					<td style="width:120px;mso-number-format:'\@';">${memberVo.certi_number}</td>
					<td style="width:100px;">${memberVo.certi_date_fmt}</td>										
					<td style="width:300px; text-align:left;padding-left:5px;">${memberVo.manager_info_text}</td>
					<td style="width:300px; text-align:left;padding-left:5px;">${memberVo.etc_content}</td>
				</tr>
			</c:forEach>			
		</c:otherwise>
	</c:choose>
</table>
