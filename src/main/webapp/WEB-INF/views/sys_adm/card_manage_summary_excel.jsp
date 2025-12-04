<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
<%
    response.setHeader("Content-Disposition", "attachment; filename=top_card_total_"+pageContext.getAttribute("today")+".xls");
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
											<th rowspan="2">구분</th>
											<th height="30px;" colspan="3">카드종류</th>
											<th colspan="5">카드상태</th>
										</tr>
										<tr>				
											<th height="30px;">정상</th>
											<th>임시</th>
											<th>공용</th>				
											<th>미사용</th>
											<th>사용중</th>
											<th>분실</th>
											<th>미반납</th>
											<th>기타</th>
										</tr>
										<tr>
											<th height="30px;">1종 사업부</th>
											<td style="text-align:right;">${cardSummary1Map.normal_1_cnt}</td>
											<td style="text-align:right;">${cardSummary1Map.temp_1_cnt}</td>
											<td style="text-align:right;">${cardSummary1Map.public_1_cnt}</td>
											<td style="text-align:right;">${cardSummary1Map.state_1_0_cnt}</td>
											<td style="text-align:right;">${cardSummary1Map.state_1_1_cnt}</td>
											<td style="text-align:right;">${cardSummary1Map.state_1_2_cnt}</td>
											<td style="text-align:right;">${cardSummary1Map.state_1_3_cnt}</td>
											<td style="text-align:right;">${cardSummary1Map.state_1_9_cnt}</td>
										</tr>
										<tr>
											<th height="30px;">4종 사업부</th>
											<td style="text-align:right;">${cardSummary4Map.normal_4_cnt}</td>
											<td style="text-align:right;">${cardSummary4Map.temp_4_cnt}</td>
											<td style="text-align:right;">${cardSummary4Map.public_4_cnt}</td>
											<td style="text-align:right;">${cardSummary4Map.state_4_0_cnt}</td>
											<td style="text-align:right;">${cardSummary4Map.state_4_1_cnt}</td>
											<td style="text-align:right;">${cardSummary4Map.state_4_2_cnt}</td>
											<td style="text-align:right;">${cardSummary4Map.state_4_3_cnt}</td>
											<td style="text-align:right;">${cardSummary4Map.state_4_9_cnt}</td>
										</tr>
										<tr>
											<th height="30px;">기타 (미지정)</th>
											<td style="text-align:right;">${cardSummary9Map.normal_9_cnt}</td>
											<td style="text-align:right;">${cardSummary9Map.temp_9_cnt}</td>
											<td style="text-align:right;">${cardSummary9Map.public_9_cnt}</td>
											<td style="text-align:right;">${cardSummary9Map.state_9_0_cnt}</td>
											<td style="text-align:right;">${cardSummary9Map.state_9_1_cnt}</td>
											<td style="text-align:right;">${cardSummary9Map.state_9_2_cnt}</td>
											<td style="text-align:right;">${cardSummary9Map.state_9_3_cnt}</td>
											<td style="text-align:right;">${cardSummary9Map.state_9_9_cnt}</td>
										</tr>
										<tr>
											<th height="30px;">합 계</th>
											<th style="text-align:right;">${cardSummary1Map.normal_1_cnt + cardSummary4Map.normal_4_cnt + cardSummary9Map.normal_9_cnt}</th>
											<th style="text-align:right;">${cardSummary1Map.temp_1_cnt + cardSummary4Map.temp_4_cnt + cardSummary9Map.temp_9_cnt}</th>
											<th style="text-align:right;">${cardSummary1Map.public_1_cnt + cardSummary4Map.public_4_cnt + cardSummary9Map.public_9_cnt}</th>
											<th style="text-align:right;">${cardSummary1Map.state_1_0_cnt + cardSummary4Map.state_4_0_cnt + cardSummary9Map.state_9_0_cnt}</th>
											<th style="text-align:right;">${cardSummary1Map.state_1_1_cnt + cardSummary4Map.state_4_1_cnt + cardSummary9Map.state_9_1_cnt}</th>
											<th style="text-align:right;">${cardSummary1Map.state_1_2_cnt + cardSummary4Map.state_4_2_cnt + cardSummary9Map.state_9_2_cnt}</th>
											<th style="text-align:right;">${cardSummary1Map.state_1_3_cnt + cardSummary4Map.state_4_3_cnt + cardSummary9Map.state_9_3_cnt}</th>
											<th style="text-align:right;">${cardSummary1Map.state_1_9_cnt + cardSummary4Map.state_4_9_cnt + cardSummary9Map.state_9_9_cnt}</th>
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