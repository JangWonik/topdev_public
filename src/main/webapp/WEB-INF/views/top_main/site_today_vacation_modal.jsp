<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	.buttonMiniView{
		width:80px;
		height:20px;
	    background-color:#F7F7F7;
	    color:#666;
	    text-align: center;
		border-radius:5px;
	    font-size: 10px;
	    cursor: pointer;
	    text-decoration:none;
	    border: solid 1px grey;		    
	}
</style>
<div id="lecture-process-dialog" title="오늘 휴가자 목록" style="font-size: 12px;" align="center">		
	<div class="tableStyle2" style="width: 570px;">			
		<table class="vacation-ins-table">
			<tr>
				<th width="6%">순번</th>
				<th width="22%">팀명</th>
				<th width="22%">이름</th>
				<th width="30%">휴가 기간</th>				
				<th width="20%">휴가 종류</th>																		
			</tr>
			<c:choose>
				<c:when test="${vacationUserList.size() == 0}">
					<td colspan="5">오늘 휴가자가 없습니다.</td>
				</c:when>
				<c:otherwise>
					<c:forEach items="${vacationUserList}" var="item" varStatus="status">
					<tr>						
						<td>${vacationUserList.size() - status.index}</td>
						<td>${item.team_name}</td>
						<td>${item.user_name}</td>
						<td>${item.sdate} ~ ${item.edate}</td>				
						<td>${item.vacation_type_val}</td>
					</tr>										
					</c:forEach>
				</c:otherwise>
			</c:choose>				
			
		</table>	
	</div>
</div>		
