<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${title_Session}</title>
    
		<div id="equipment-action-dialog" title="장비상세보기" style="font-size: 15px;" align="center">
			<c:if test="${equipmentView.is_del eq 1}">			
				<div style="text-align:left;padding-left:10px;padding-top:5px;font-size:12px;">
					<b><font color="red">* 삭제된 장비입니다. ( 삭제일 : ${fn:substring(equipmentView.del_date,0,19)} ) </font></b>
				</div>
			</c:if>
			<br/>
			<div class="tableStyle2" style="width: 750px;">
				<table class="vacation-ins-table">					
					<tbody>
						<tr>
							<th width="20%" height="30">구분</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								<c:choose>
									<c:when test="${empty equipmentView.team_type}">-</c:when>
									<c:when test="${equipmentView.team_type eq 0 or equipmentView.team_type eq 1}">물보험</c:when>
									<c:when test="${equipmentView.team_type eq 4}">인보험</c:when>										
								</c:choose>																
							</td>							
							<th width="20%">장비 사용자</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								<c:choose>
									<c:when test="${equipmentView.user_no eq 99999}">공용</c:when>
									<c:when test="${empty equipmentView.user_name}">미등록</c:when>									
									<c:otherwise>${equipmentView.user_name}</c:otherwise>
								</c:choose>								
							</td>
						</tr>					
						<tr>
							<th width="20%" height="30">센터명</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								<c:choose>
									<c:when test="${empty equipmentView.center_name}">-</c:when>
									<c:otherwise>${equipmentView.center_name}</c:otherwise>
								</c:choose>								
							</td>				
							<th width="20%">부서</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								<c:choose>
									<c:when test="${empty equipmentView.team_name}">서버실</c:when>
									<c:otherwise>${equipmentView.team_name}</c:otherwise>
								</c:choose>								
							</td>											
						</tr>
						<tr>
							<th width="20%" height="30">장비 종류</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								${equipmentView.eq_type_nm}
							</td>
							<th width="20%">장비 상태</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								${equipmentView.eq_state_nm}
							</td>
						</tr>
						<!-- 데스크 탑일 경우만 보여준다. -->
						<c:if test="${equipmentView.eq_type eq 1}">
							<tr>
								<th width="20%" height="30">CPU 종류</th>
								<td style="text-align:left;padding-left: 5px;font-weight:bold;">
									${equipmentView.cpu_info_nm}
								</td>
								<th width="20%">RAM 크기</th>
								<td style="text-align:left;padding-left: 5px;font-weight:bold;">
									${equipmentView.memory_size} GByte
								</td>
							</tr>						
						</c:if>
						<tr>
							<th width="20%" height="30">등록일</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								${equipmentView.reg_date}
							</td>
							<th width="20%" height="30">폐기일</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								${equipmentView.close_date}
							</td>
						</tr>
						<tr>
							<th width="20%" height="30">장비 일련번호</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								${equipmentView.eq_no}								
							</td>
							<th width="20%" height="30">장비 가격</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								<fmt:formatNumber value="${equipmentView.eq_price}" pattern="#,###" /> 원																
							</td>
						</tr>						
						<tr>
							<th width="20%" height="100">장비 메모</th>
							<td colspan="3" align="left" style="text-align:left;padding-left:5px;">								
								${fn:replace(fn:replace(equipmentView.eq_memo , LF , '<br>'), ' ', '&nbsp;')}
							</td>
						</tr>
					</table>
					<c:set var="logSize" value="${equipmentlogList.size()}"/>					
					<c:if test="${logSize > 0}">
					<div style="padding:2px;"></div>
						<table>
							<tbody>
								<colgroup>
									<col width="5%">
									<col width="8%">
									<col width="10%">
									<col width="12%">
									<col width="10%">
									<col width="15%">
									<col width="10%">
									<col width="50%">									
								</colgroup>
								<tr>
									<th height="20" colspan="8">장비 로그</th>							
								</tr>
								<tr>							
									<th height="20">순번</th>
									<th>상태</th>
									<th>로그일</th>
									<th>아이피</th>
									<th>작업자</th>
									<th>소유팀</th>
									<th>소유자</th>									
									<th>내역</th>							
								</tr>
								<c:forEach items="${equipmentlogList}" var="item" varStatus="status">
									<tr>
										<td>${logSize - status.index}</td>
										<td>
											<c:choose>
												<c:when test="${item.log_action eq 'Insert'}">등록</c:when>
												<c:when test="${item.log_action eq 'Update'}">수정</c:when>
												<c:when test="${item.log_action eq 'Close'}">폐기</c:when>
												<c:when test="${item.log_action eq 'Delete'}">삭제</c:when>
												<c:otherwise>${item.log_action}</c:otherwise>
											</c:choose>										
										</td>
										<td>${item.log_reg_date}</td>
										<td>${item.log_ip }</td>
										<td>${item.log_user_name}</td>
										<td>
											<c:choose>
												<c:when test="${empty item.team_name}"> - </c:when>
												<c:otherwise>${item.team_name}</c:otherwise>											
											</c:choose>
										</td>
										<td>
											<c:choose>
												<c:when test="${empty item.user_name}"> - </c:when>
												<c:otherwise>${item.user_name}</c:otherwise>											
											</c:choose>
										</td>										
										<td style="text-align:left;padding-left:5px;">${item.log_content}</td>	
									</tr>												
								</c:forEach>						
							</tbody>																																																							
						</table>
					</c:if>				
				</div>
			</div>