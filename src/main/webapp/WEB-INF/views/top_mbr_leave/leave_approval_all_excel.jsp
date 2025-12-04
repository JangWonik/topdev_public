<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<% response.setCharacterEncoding("UTF-8"); %>
<% response.setHeader("Content-Type", "application/vnd.ms-xls"); %>
<% response.setHeader("Content-Disposition", "attachment;filename=LeaveList.xls"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<style>
		.td-overflow-none{
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
		}
		
		.btn-vacation-aprv {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:5px;
			-webkit-border-radius:5px;
			border-radius:5px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:12px;
			color:#696969  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
		}

		.btn-vacation-aprv:active {
			position:relative;
			top:4px
		}
		
		/* 모달 버튼 */
		.ui-button-text-only {
			height:2.1em !important;
		}
	</style>
</head>
<body>
<div class= "tableStyle2" style="border-top: 0px;">																
	<table border="1">									
		<thead>
			<tr>											
				<th width="4%">No.</th>
				<th width="8%">센터명</th>
				<th width="8%">부서명</th>
				<th width="7%">이름</th>
				<th width="7%">신청일</th>
				<th width="6%">종류</th>
				<th width="10%">기간</th>											
				<th width="5%">사용일</th>											
				<th width="10%">사유</th>
				<th width="10%">상태</th>
				<th width="7%">현재결재자</th>														
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${approvalList.size() != 0}">
					<c:forEach items="${approvalList}" var="item" varStatus="status">
						<tr>														
							<td class="td-overflow-none">${approvalList.size() - status.index}</td>														
							<td class="td-overflow-none">${item.center_name}</td>
							<td class="td-overflow-none">${item.team_name}</td>
							<td class="td-overflow-none">${item.user_name}</td>
							<td class="td-overflow-none">${item.regdate}</td>
							<td class="td-overflow-none">${item.leave_type_val}</td>
							<td class="td-overflow-none">${item.sdate} ~ ${item.edate}</td>														
							<td class="td-overflow-none">${item.leave_interval} 일</td>															
							<td class="td-overflow-none">${item.leave_content}</td>
							<td class="td-overflow-none">${item.approval_state_val}</td>
							<td class="td-overflow-none">															
								<c:choose>
									<c:when test="${item.approval_state eq 30 or item.approval_state eq 31 or item.approval_state eq 32}">인사팀</c:when>
									<c:otherwise>																											
										${item.approvaler_now_name}
									</c:otherwise>
								</c:choose>											
							</td>							
						</tr>						
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="11">
							검색된 휴직내역이 없습니다.
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</div>													