<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="kmemberList" value="${kmemberList}" />
<c:set var="toMonthInt" value="${toMonthInt}" />
<c:set var="monthInt" value="${monthInt}" />
<c:set var="monthInt" value="${month}" />
<c:set var="Suit12_1List" value="${Suit12_1List}" />
<c:set var="Suit12_4List" value="${Suit12_4List}" />
<c:set var="Suit12_sum1" value="${Suit12_sum1}" />
<c:set var="Suit12_sum4" value="${Suit12_sum4}" />


				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							<%@ include file="suitability_17_team_top.jsp" %>
						</div>
					</div>
				</div>

				<div class="centercnt_bot2">
					<div class="guest">
						<div class="guestTap">
							<ul>
									<li class="on"><a>${toMonthInt}월 팀별 적부심사(흥국)</a></li>
							</ul>
						</div>
						<div class="guestcnt2" id="reg_tab" style="display:block;">
							<div class="tableStyle2">
								<table cellpadding="0" cellspacing="0" width="990" align="center">
								<colgroup>
										<col width="60">
										<col width="130">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
										<col width="75">
									</colgroup>
									<thead>
				 <tr>
                    <td class="td" bgcolor="#EFEFEF" rowspan="3">
                        <p align="center"><B><font color="black">Type</font></B></p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF" rowspan="3">
                        <p align="center"><B><font color="black">팀</font></B></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF" colspan="2" rowspan="2">
                        <p align="center"><B><font color="black">수임현황</font></B></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF" colspan="6">
                        <p align="center"><B><font color="black">종결현황</font></B></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF" rowspan="3">
            			<p align="center"><font color="black"><b>미결현황</b></font></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF" colspan="5">
            			<p align="center"><font color="black"><b>지급</b></font></p>
                    </td>
                </tr>
                <tr>
					<td class="td" bgcolor="#EFEFEF" colspan="2">
            			<p align="center"><B><font color="black">조사 완료</font></B></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF" colspan="2">
            			<p align="center"><B><font color="black">조사 실패</font></B></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF" colspan="2">
            			<p align="center"><B><font color="black">합계</font></B></p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF" colspan="2">
            			<p align="center"><B><font color="black">심사후</font></B></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF" colspan="2">
            			<p align="center"><B><font color="black">심사전</font></B></p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF" rowspan="2">
            			<p align="center"><B><font color="black">합계</font></B></p>
                    </td>
                </tr>
                <tr>
					<td class="td" bgcolor="#EFEFEF">
            			<p align="center"><font color="black">당월</font></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF">
            			<p align="center"><font color="black">년누계</font></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF">
            			<p align="center"><font color="black">당월</font></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF">
            			<p align="center"><font color="black">년누계</font></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF">
            			<p align="center"><font color="black">당월</font></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF">
            			<p align="center"><font color="black">년누계</font></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF">
            			<p align="center"><font color="black">당월</font></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF">
            			<p align="center"><font color="black">년누계</font></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF">
            			<p align="center"><font color="black">일반</font></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF">
            			<p align="center"><font color="black">공장</font></p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF">
            			<p align="center"><font color="black">일반</font></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF">
            			<p align="center"><font color="black">공장</font></p>
                    </td>
					<!-- <td class="td" bgcolor="#EFEFEF">
            			<p align="center"><font color="black">합계</font></p>
                    </td> -->
                </tr>
				</thead>
				<tbody>
			
					<c:forEach var="vo" items="${Suit17_1List}" varStatus="status">
				<tr onMouseOver=this.style.backgroundColor="#FFECEC" onMouseOut=this.style.backgroundColor="">
					<c:if test="${status.index == 0}">
						<td class="td" bgcolor="#F8F8F8" rowspan="${Suit17_1List.size()}">
							<c:out value="1종" />
						</td>
					</c:if>
					<td>
						<a href="./suitability_17_member?team_id=${vo.getTeam_id()}&team_name=${vo.getTeam_name()}&ViewFromDate=${fromdate}&ViewToDate=${todate}">
						<c:out value="${vo.getTeam_name()}" />
						</a>
					</td>
					<td>
						<c:out value="${vo.getReg_m()}" />
					</td>
					<td>
						<c:out value="${vo.getReg_y()}" />
					</td>
					
					<td>
						<c:out value="${vo.getEndok_m()}" />
					</td>
					<td>
						<c:out value="${vo.getEndok_y()}" />
					</td>
					<td>
						<c:out value="${vo.getEndno_m()}" />
					</td>
					<td>
						<c:out value="${vo.getEndno_y()}" />
					</td>
					<td>
						<c:out value="${vo.getEnd_sum_m()}" />
					</td>
					<td>
						<c:out value="${vo.getEnd_sum_y()}" />
					</td>
					<td>
						<c:out value="${vo.getRid_mi()}" />
					</td>
					<td>
						<fmt:formatNumber  value="${vo.getPrice_g()}" pattern="#,##0.##"/>
					</td>
					<td>
						<fmt:formatNumber  value="${vo.getPrice_f()}" pattern="#,##0.##"/>
					</td>
					<td>
						<fmt:formatNumber  value="${vo.getPrice_g_b()}" pattern="#,##0.##"/>
					</td>
					<td>
						<fmt:formatNumber  value="${vo.getPrice_f_b()}" pattern="#,##0.##"/>
					</td>
					<td>
						<fmt:formatNumber  value="${vo.getPrice_sum()}" pattern="#,##0.##"/>
					</td>			
				</tr>
				</c:forEach>
				</tbody>
				<tbody>
				<tr>
					<td class="td" bgcolor="#EFEFEF" colspan="2">
						<p align="center"><b>소계</b></p>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_sum1.getSum_reg_m()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_sum1.getSum_reg_y()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_sum1.getSum_endok_m()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_sum1.getSum_endok_y()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_sum1.getSum_endno_m()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_sum1.getSum_endno_y()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_sum1.getSum_end_sum_m()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_sum1.getSum_end_sum_y()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_sum1.getSum_rid_mi()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${Suit17_sum1.getSum_price_g()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${Suit17_sum1.getSum_price_f()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${Suit17_sum1.getSum_price_g_b()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${Suit17_sum1.getSum_price_f_b()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${Suit17_sum1.getSum_price_sum()}" pattern="#,##0.##"/>
					</td>
					
					
					</tr>
					</tbody>
			<tbody>
			
					<c:forEach var="vot" items="${Suit17_4List}" varStatus="status">
				<tr onMouseOver=this.style.backgroundColor="#FFECEC" onMouseOut=this.style.backgroundColor="">
					<c:if test="${status.index == 0}">
						<td class="td" bgcolor="#F8F8F8" rowspan="${Suit17_4List.size()}">
							<c:out value="4종" />
						</td>
					</c:if>
					<td>
						<a href="./suitability_17_member?team_id=${vot.getTeam_id()}&team_name=${vot.getTeam_name()}&ViewFromDate=${fromdate}&ViewToDate=${todate}">
						<c:out value="${vot.getTeam_name()}" />
						</a>
					</td>
					<td>
						<c:out value="${vot.getReg_m()}" />
					</td>
					<td>
						<c:out value="${vot.getReg_y()}" />
					</td>
					
					<td>
						<c:out value="${vot.getEndok_m()}" />
					</td>
					<td>
						<c:out value="${vot.getEndok_y()}" />
					</td>
					<td>
						<c:out value="${vot.getEndno_m()}" />
					</td>
					<td>
						<c:out value="${vot.getEndno_y()}" />
					</td>
					<td>
						<c:out value="${vot.getEnd_sum_m()}" />
					</td>
					<td>
						<c:out value="${vot.getEnd_sum_y()}" />
					</td>
					<td>
						<c:out value="${vot.getRid_mi()}" />
					</td>
					<td>
						<fmt:formatNumber value="${vot.getPrice_g()}" pattern="#,##0.##"/>
					</td>
					<td>
						<fmt:formatNumber value="${vot.getPrice_f()}" pattern="#,##0.##"/>
					</td>
					<td>
						<fmt:formatNumber value="${vot.getPrice_g_b()}" pattern="#,##0.##"/>
					</td>
					<td>
						<fmt:formatNumber value="${vot.getPrice_f_b()}" pattern="#,##0.##"/>
					</td>
					<td>
						<fmt:formatNumber value="${vot.getPrice_sum()}" pattern="#,##0.##"/>
					</td>			
				</tr>
				</c:forEach>
				</tbody>
				<tbody>
				<tr>
					<td class="td" bgcolor="#EFEFEF" colspan="2">
						<p align="center"><b>소계</b></p>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_sum4.getSum_reg_m()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_sum4.getSum_reg_y()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_sum4.getSum_endok_m()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_sum4.getSum_endok_y()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_sum4.getSum_endno_m()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_sum4.getSum_endno_y()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_sum4.getSum_end_sum_m()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_sum4.getSum_end_sum_y()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_sum4.getSum_rid_mi()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${Suit17_sum4.getSum_price_g()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${Suit17_sum4.getSum_price_f()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${Suit17_sum4.getSum_price_g_b()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${Suit17_sum4.getSum_price_f_b()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${Suit17_sum4.getSum_price_sum()}" pattern="#,##0.##"/>
					</td>
					
					</tr>
					</tbody>
				<tbody>
				<tr>
					<td class="td" bgcolor="#F8F8F8" colspan="2">
						<p align="center"><b>합계</b></p>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<c:out value="${Suit17_sum14.getSum_reg_m()}"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<c:out value="${Suit17_sum14.getSum_reg_y()}"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<c:out value="${Suit17_sum14.getSum_endok_m()}"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<c:out value="${Suit17_sum14.getSum_endok_y()}"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<c:out value="${Suit17_sum14.getSum_endno_m()}"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<c:out value="${Suit17_sum14.getSum_endno_y()}"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<c:out value="${Suit17_sum14.getSum_end_sum_m()}"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<c:out value="${Suit17_sum14.getSum_end_sum_y()}"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<c:out value="${Suit17_sum14.getSum_rid_mi()}"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber value="${Suit17_sum14.getSum_price_g()}" pattern="#,##0.##"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber value="${Suit17_sum14.getSum_price_f()}" pattern="#,##0.##"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber value="${Suit17_sum14.getSum_price_g_b()}" pattern="#,##0.##"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber value="${Suit17_sum14.getSum_price_f_b()}" pattern="#,##0.##"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber value="${Suit17_sum14.getSum_price_sum()}" pattern="#,##0.##"/>
						</font>
					</td>
					
					
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
