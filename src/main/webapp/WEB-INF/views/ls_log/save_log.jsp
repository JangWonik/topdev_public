<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="kmemberList" value="${kmemberList}" />
<c:set var="toMonthInt" value="${toMonthInt}" />
<c:set var="monthInt" value="${monthInt}" />
<c:set var="monthInt" value="${month}" />
<c:set var="ReusltIgTList4" value="${ReusltIgTList4}" />
<c:set var="R_Ig_T4List" value="${R_Ig_T4List}" />
<c:set var="Log_Result" value="${Log_Result}" />


				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							
						</div>
					</div>
				</div>

				<div class="centercnt_bot2">
					<div class="guest">
						<div class="guestTap">
							<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" align="absmiddle">&nbsp;
								<b>팀 & 개인별 정산 내역</b>
						</div>
						<div class="guestcnt2" id="reg_tab" style="display:block;">
							<div class="tableStyle2">
								<table cellpadding="0" cellspacing="0" width="500" align="center">
								<colgroup>
										<col width="75">
										<col width="75">
										<col width="75">
									</colgroup>
									<thead>
	<tr>
		<td class="td" bgcolor="#EFEFEF"><p><b>년</b></p></td>
		<td class="td" bgcolor="#EFEFEF"><p><b>월</b></p></td>
		<td class="td" bgcolor="#EFEFEF"><p><b>비고</b></p></td>
			
	</tr>
	</thead>
	<tbody>

		<c:forEach var="vo" items="${Log_Result}" varStatus="status">
	<tr>
		
		<td>
			<c:out value="${vo.getYear()}" /><br>
		</td>
		<td>
			<c:out value="${vo.getMonth()}" /><br>
		</td>
		<td>
		 	<p align="center"><a href="./save_log_team?no=${vo.getNo()}">
			<img src="./resources/ls_img/btns_view.gif" width="65" height="18" border="0"></a></p>
		</td>
		
	</c:forEach>
	</tr>
	</tbody>
	
		
		</table>
							</div>
						</div>
						<div class="guestcnt">
						</div>
						<div class="guestcnt">
						</div>
						<div class="guestcnt">
						</div>
						<div class="guestcnt">
						</div>
					</div>
				</div>
