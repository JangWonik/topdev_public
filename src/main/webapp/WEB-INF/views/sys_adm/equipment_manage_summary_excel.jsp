<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%
    response.setHeader("Content-Disposition", "attachment; filename=top_equipment_total_"+pageContext.getAttribute("today")+".xls");
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
										<tr>
											<th colspan="4" height="30px;">재직인원현황</th>
										</tr>
										<tr>
											<th height="25px;">총 괄</th>
											<th>1종 사업부</th>
											<th>4종 사업부</th>
											<th>총 합</th>								
										</tr>
										<tr>
											<td height="25px;" style="text-align:right;">${worktype_cnt.get(0).getCnt()} 명</td>
											<td style="text-align:right;">
												<c:out value="${worktype_cnt.get(1).getCnt()+worktype_cnt.get(2).getCnt()
												+worktype_cnt.get(3).getCnt()+worktype_cnt.get(4).getCnt()
												+worktype_cnt.get(9).getCnt()+worktype_cnt.get(10).getCnt()+worktype_cnt.get(13).getCnt()}"/> 명
											</td>
											<td style="text-align:right;">
												<c:out value="${worktype_cnt.get(5).getCnt()+worktype_cnt.get(6).getCnt()
												+worktype_cnt.get(7).getCnt()+worktype_cnt.get(8).getCnt()
												+worktype_cnt.get(11).getCnt()+worktype_cnt.get(12).getCnt()+worktype_cnt.get(14).getCnt()}"/> 명
											</td>
											<td style="text-align:right;">
												<c:out value="${worktype_cnt.get(0).getCnt()
												+worktype_cnt.get(1).getCnt()+worktype_cnt.get(2).getCnt()
												+worktype_cnt.get(3).getCnt()+worktype_cnt.get(4).getCnt()
												+worktype_cnt.get(9).getCnt()+worktype_cnt.get(10).getCnt()
												+worktype_cnt.get(5).getCnt()+worktype_cnt.get(6).getCnt()
												+worktype_cnt.get(7).getCnt()+worktype_cnt.get(8).getCnt()
												+worktype_cnt.get(11).getCnt()+worktype_cnt.get(12).getCnt()
												+worktype_cnt.get(13).getCnt()+worktype_cnt.get(14).getCnt()}"/> 명
											</td>
										</tr>
									</table>
									</div>
									<br/>
									<div class= "tableStyle2" style="border-top: 5px;">
										<table cellpadding="0" cellspacing="0" width="1060" align="center" border="1">
											<tr>
												<th height="30px;">장비종류</th>
												<th>사용중</th>
												<th>사용가능 (대기)</th>
												<th>사용불가능 (고장+보류)</th>
												<th>미회수</th>
												<th>총 계</th>
											</tr>
											<c:forEach var="item" items="${eqSummary}">
												<c:set var="eq_use_cnt" value="${item.eq_use_cnt}"/>
												<c:set var="eq_wait_cnt" value="${item.eq_wait_cnt}"/>
												<c:set var="eq_break_hold_cnt" value="${item.eq_break_cnt+item.eq_hold_cnt}"/>
												<c:set var="eq_un_collect_cnt" value="${item.eq_uncollect_cnt}"/>
												<c:set var="eq_total_cnt" value="${item.eq_use_cnt + item.eq_wait_cnt + item.eq_break_cnt + item.eq_hold_cnt + item.eq_uncollect_cnt}"/>
												<tr>
													<th height="25px;" style="text-align:right;">${item.col_val}</th>
													<td style="text-align:right;">${eq_use_cnt}</td>
													<td style="text-align:right;">${eq_wait_cnt}</td>
													<td style="text-align:right;">${eq_break_hold_cnt}</td>
													<td style="text-align:right;">${eq_un_collect_cnt}</td>
													<td style="text-align:right;">${eq_total_cnt}</td>
												</tr>
												<c:set var="total_eq_use_cnt" value="${total_eq_use_cnt + eq_use_cnt}"/>
												<c:set var="total_eq_wait_cnt" value="${total_eq_wait_cnt + eq_wait_cnt}"/>
												<c:set var="total_eq_break_hold_cnt" value="${total_eq_break_hold_cnt + eq_break_hold_cnt}"/>
												<c:set var="total_eq_un_collect_cnt" value="${total_eq_un_collect_cnt + eq_un_collect_cnt}"/>
												<c:set var="total_eq_total_cnt" value="${total_eq_total_cnt + eq_total_cnt}"/>				
											</c:forEach>
											<tr>
												<th height="30px;" style="text-align:right;">합 계</th>
												<th style="text-align:right;">${total_eq_use_cnt}</th>
												<th style="text-align:right;">${total_eq_wait_cnt}</th>
												<th style="text-align:right;">${total_eq_break_hold_cnt}</th>
												<th style="text-align:right;">${total_eq_un_collect_cnt}</th>
												<th style="text-align:right;">${total_eq_total_cnt}</th>
											</tr>
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