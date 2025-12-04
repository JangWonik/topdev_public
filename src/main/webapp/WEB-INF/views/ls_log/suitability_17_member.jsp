<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="kmemberList" value="${kmemberList}" />
<c:set var="toMonthInt" value="${toMonthInt}" />
<c:set var="monthInt" value="${monthInt}" />
<c:set var="monthInt" value="${month}" />
<c:set var="Suit17_MList" value="${Suit17_MList}" />


				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							<%@ include file="suitability_17_member_top.jsp" %>
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
                        <p align="center"><B><font color="black">이름</font></B></p>
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
            			<p align="center"><B><font color="black">심사전</font></B></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF" colspan="2">
            			<p align="center"><B><font color="black">심사후</font></B></p>
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
					<!-- <td class="td" bgcolor="#EFEFEF" rowspan="2">
            			<p align="center"><font color="black">합계</font></p>
                    </td> -->
                </tr>
				</thead>
				<tbody>
			
					<c:forEach var="vo" items="${Suit17_MList}" varStatus="status">
				<tr onMouseOver=this.style.backgroundColor="#FFECEC" onMouseOut=this.style.backgroundColor="">
					
					<td>
						<a href="./suitability_17_member2?team_name=${team_name}&user_id=${vo.getUser_id()}&name=${vo.getName()}&ViewFromDate=${fromdate}&ViewToDate=${todate}">
						<c:out value="${vo.getName()}" />
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
						<c:out value="${vo.getPrice_g()}" />
					</td>
					<td>
						<c:out value="${vo.getPrice_f()}" />
					</td>
					<td>
						<c:out value="${vo.getPrice_g_b()}" />
					</td>
					<td>
						<c:out value="${vo.getPrice_f_b()}" />
					</td>
					<td>
						<c:out value="${vo.getPrice_sum()}" />
					</td>			
				</tr>
				</c:forEach>
				</tbody>
				<tbody>
				<tr>
					<td class="td" bgcolor="#EFEFEF" >
						<p align="center"><b>합계</b></p>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_Msum.getSum_reg_m()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_Msum.getSum_reg_y()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_Msum.getSum_endok_m()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_Msum.getSum_endok_y()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_Msum.getSum_endno_m()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_Msum.getSum_endno_y()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_Msum.getSum_end_sum_m()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_Msum.getSum_end_sum_y()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_Msum.getSum_rid_mi()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_Msum.getSum_price_g()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_Msum.getSum_price_f()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_Msum.getSum_price_g_b()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_Msum.getSum_price_f_b()}"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<c:out value="${Suit17_Msum.getSum_price_sum()}"/>
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
