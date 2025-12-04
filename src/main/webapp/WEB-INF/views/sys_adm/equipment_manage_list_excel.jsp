<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%
    response.setHeader("Content-Disposition", "attachment; filename=top_equipment_"+pageContext.getAttribute("today")+".xls");
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
												<th width="10px;">순번</th>												
												<th width="30px;">센터명</th>
												<th width="30px;">부서명</th>
												<th width="15px;">구분</th>
												<th width="30px;">이름</th>
												<th width="18px;">장비종류</th>
												<th width="30px;">일련번호</th>
												<th width="15px;">상태</th>
												<th width="30px;">CPU정보</th>
												<th width="30px;">램크기</th>
												<th width="16px;">등록일</th>
												<th width="16px;">폐기일</th>
												<th width="18px;">제품가격(원)</th>
												<th width="38px;">메모</th>					
											</tr>
										</thead>													
											<tbody>
												<c:choose>
													<c:when test="${equipmentList.size() != 0}">
														<c:set var="totalSize" value="${equipmentList.size()}"/>
														<c:forEach items="${equipmentList}" var="item" varStatus="status">
															<c:choose>
																<c:when test="${item.is_del eq 1}"><tr style="background-color:#CCCCCC"></c:when>
																<c:otherwise><tr></c:otherwise>
															</c:choose>																														
																<td class="td-overflow-none">${totalSize - status.index}</td>														
																<td class="td-overflow-none">${item.center_name}</td>
																<td class="td-overflow-none">
																	<c:choose>
																		<c:when test="${empty item.team_name}">서버실</c:when>
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
																	<c:choose>
																		<c:when test="${item.user_no eq 99999}">공용</c:when>
																		<c:when test="${empty item.user_name}">미등록</c:when>																		
																		<c:otherwise>${item.user_name}</c:otherwise>
																	</c:choose>									
																</td>
																<td class="td-overflow-none">${item.eq_type_nm}</td>
																<td class="td-overflow-none">${item.eq_no}</td>
																<td class="td-overflow-none">${item.eq_state_nm}</td>
																<td class="td-overflow-none">${item.cpu_info_nm}</td>
																<td class="td-overflow-none">${item.memory_size}</td>
																<td class="td-overflow-none">${item.reg_date}</td>
																<td class="td-overflow-none">${item.close_date}</td>								
																<td style="text-align:right;padding-right:5px;" class="td-overflow-none"><fmt:formatNumber value="${item.eq_price}" pattern="#,###" /></td>
																<td class="td-overflow-none">${item.eq_memo}</td>
															</tr>							
														</c:forEach>
															<tr>
																<th></th>
																<th></th>
																<th></th>
																<th></th>
																<th></th>
																<th></th>
																<th></th>																
																<th></th>
																<th></th>
																<th></th>
																<th>합 계</th>																																
																<th colspan="2" style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${total_price}" pattern="#,###" /></th>
																<th></th>
															</tr>						
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