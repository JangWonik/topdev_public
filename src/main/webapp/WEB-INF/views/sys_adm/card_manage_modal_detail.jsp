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
    
		<div id="card-action-dialog" title="카드정보상세보기" style="font-size: 15px;" align="center">
			<c:if test="${cardView.is_del eq 1}">			
				<div style="text-align:left;padding-left:10px;padding-top:5px;font-size:12px;">
					<b><font color="red">* 삭제된 장비입니다. ( 삭제일 : ${fn:substring(cardView.del_date,0,19)} ) </font></b>
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
									<c:when test="${empty cardView.team_type}">-</c:when>
									<c:when test="${cardView.team_type eq 0 or cardView.team_type eq 1}">물보험</c:when>
									<c:when test="${cardView.team_type eq 4}">인보험</c:when>										
								</c:choose>																
							</td>
							<th width="20%" height="30">등록일</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								${cardView.reg_date}
							</td>							
						</tr>					
						<tr>
							<th width="20%" height="30">센터명</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								<c:choose>
									<c:when test="${empty cardView.center_name}">-</c:when>
									<c:otherwise>${cardView.center_name}</c:otherwise>
								</c:choose>								
							</td>
							<th rowspan="4" width="20%" height="30">사진</th>
							<td rowspan="4" style="text-align:left;padding-left: 5px;font-weight:bold;">
								<c:choose>
									<c:when test="${imageBase64 != null}">
										<img id="myimage" src="${imageBase64}"  width="100" height="120" alt="직원사진" />
									</c:when>
									<c:otherwise><font color="red">등록된 직원 사진이 없습니다.</font></c:otherwise>
								</c:choose>					
							</td>																
						</tr>
						<tr>
							<th width="20%">부서</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								<c:choose>
									<c:when test="${empty cardView.team_name}">미지정</c:when>
									<c:otherwise>${cardView.team_name}</c:otherwise>
								</c:choose>								
							</td>
						</tr>
						<tr>
							<th width="20%" height="30">카드 종류</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								${cardView.card_type_nm}
							</td>							
						</tr>
						<tr>
							<th width="20%">카드 상태</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								${cardView.card_state_nm}
							</td>
						</tr>
						<tr>
							<th width="20%" height="30">카드 사용지점</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								${cardView.card_zone_nm}
							</td>
							<th width="20%">카드 사용자</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;">
								<c:choose>
									<c:when test="${cardView.user_no eq 99999}">공용</c:when>
									<c:when test="${empty cardView.user_name}">미등록</c:when>									
									<c:otherwise>${cardView.user_name}</c:otherwise>
								</c:choose>								
							</td>
						</tr>						
						<tr>
							<th width="20%" height="30">카드 번호</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;color:blue;">
								${cardView.card_number}								
							</td>							
							<th width="20%" height="30">카드 별칭</th>
							<td style="text-align:left;padding-left: 5px;font-weight:bold;color:green;">
								${cardView.card_uid}								
							</td>
						</tr>
						<tr>
							<th width="20%" height="30">카드 시리얼 번호</th>
							<td align="left" style="text-align:left;padding-left:5px;">
								${cardView.card_serial_no}
							</td>
							<th width="20%" height="30">최종 수정일</th>
							<td align="left" style="text-align:left;padding-left:5px;">
								${cardView.mod_date}
							</td>
						</tr>						
						<tr>
							<th width="20%" height="100">카드 메모</th>
							<td colspan="3" align="left" style="text-align:left;padding-left:5px;">								
								${fn:replace(fn:replace(cardView.card_memo , LF , '<br>'), ' ', '&nbsp;')}
							</td>
						</tr>
					</table>
					<c:set var="logSize" value="${cardlogList.size()}"/>					
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
									<th height="20" colspan="8">카드 로그</th>							
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
								<c:forEach items="${cardlogList}" var="item" varStatus="status">
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