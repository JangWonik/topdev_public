<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%
    response.setHeader("Content-Disposition", "attachment; filename=top_card_"+pageContext.getAttribute("today")+".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-excel");
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
    <div class="tableStyle2" id="area_excel">
    	<div style="padding-right: 17px;background: #e7ecf1;">        
            <div class="contetns2">
                <div class="center_cnt2">                    
                    <%--본문 영역--%>
                    <div class="centercnt_bot2">
                        <div class="guest">
                            <div class="guestTap">                                
                            	<!-- 내용 테이블 시작 -->
								<div class="tableStyle2">
								    <table cellpadding="0" cellspacing="0" width="1060" align="center" border="1">
										<thead>
											<tr>
												<th width="15px;">순번</th>												
												<th width="30px;">센터명</th>
												<th width="30px;">부서명</th>
												<th width="15px;">구분</th>
												<th width="35px;">이름(별칭)</th>
												<th width="18px;">카드종류</th>
												<th width="40px;">카드번호</th>
												<th width="40px;">카드시리얼</th>
												<th width="15px;">상태</th>
												<th width="20px;">등록일</th>
												<th width="20px;">수정일</th>
												<th width="15px;">사용지점</th>												
												<th width="100px;">메모</th>					
											</tr>
										</thead>													
											<tbody>
												<c:choose>
													<c:when test="${cardList.size() != 0}">
														<c:set var="totalSize" value="${cardList.size()}"/>
														<c:forEach items="${cardList}" var="item" varStatus="status">
															<c:choose>
																<c:when test="${item.is_del eq 1}"><tr style="background-color:#CCCCCC"></c:when>
																<c:otherwise><tr></c:otherwise>
															</c:choose>																														
																<td class="td-overflow-none">${totalSize - status.index}</td>														
																<td class="td-overflow-none">${item.center_name}</td>
																<td class="td-overflow-none">
																	<c:choose>
																		<c:when test="${empty item.team_name}">미지정</c:when>
																		<c:otherwise>${item.team_name}</c:otherwise>
																	</c:choose>
																</td>
																<td class="td-overflow-none"> 
																	<c:choose>
																		<c:when test="${empty item.team_type}">-</c:when>
																		<c:when test="${item.team_type eq 0 or item.team_type eq 1}">물보험</c:when>
																		<c:when test="${item.team_type eq 4}">인보험</c:when>										
																	</c:choose>								
																</td>
																<td class="td-overflow-none">
																	<c:if test="${not empty item.user_name}">${item.user_name}</c:if>
																	<c:if test="${not empty item.card_uid}">(${item.card_uid})</c:if>								
																</td>
																<td class="td-overflow-none">${item.card_type_nm}</td>
																<td style="mso-number-format:'\@';">${item.card_number}</td>
																<td style="mso-number-format:'\@';">${item.card_serial_no}</td>																
																<td class="td-overflow-none">${item.card_state_nm}</td>
																<td class="td-overflow-none">${item.reg_date}</td>
																<td class="td-overflow-none">${item.mod_date}</td>
																<td class="td-overflow-none">${item.card_zone_nm}</td>
																<td class="td-overflow-none">${item.card_memo}</td>								
															</tr>							
														</c:forEach>																					
													</c:when>
													<c:otherwise>
														<tr>
															<td colspan="13">
																검색된 장비가 없습니다.
															</td>
														</tr>
													</c:otherwise>
												</c:choose>				
											</tbody>
										</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</html>