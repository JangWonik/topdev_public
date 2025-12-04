<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="kmemberList" value="${kmemberList}" />
<c:set var="toMonthInt" value="${toMonthInt}" />
<c:set var="monthInt" value="${monthInt}" />
<c:set var="monthInt" value="${month}" />
<c:set var="Work_T1List" value="${Work_T1List}" />
<c:set var="Work_T4List" value="${Work_T4List}" />
<c:set var="ig_id" value="${ig_id}" />


				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							<%@ include file="work_team_top.jsp" %>
						</div>
					</div>
				</div>

				<div class="centercnt_bot2">
					<div class="guest">
						<div class="guestTap">
							<ul>
									<li class="on"><a>${toMonthInt}월 팀별 처리내용</a></li>
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
									</colgroup>
									<thead>
				<tr>
                    <td class="td" bgcolor="#EFEFEF" rowspan="2">
                        <p align="center"><b><font color="black">Type</font></b></p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF" rowspan="2">
                        <p align="center"><b><font color="black">팀</font></b></p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF" rowspan="2">
                        <p align="center">인원</p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF" rowspan="2">
                        <p align="center">접수</p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF" rowspan="2">
           				<p align="center">종결</p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF" colspan="17">
           				<p align="center">진행</p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF" colspan="2">
           				
           				<p align="center"><font color="black"><b>합계</b></font></p>
                    </td>
                </tr>
                <tr>
                    <td class="td" bgcolor="#EFEFEF" colspan="2">
           				<p align="center">10일 미만</p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF" colspan="2">
           				<p align="center">10일 초과</p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF" colspan="2">
         				<p align="center">20일 초과</p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF" colspan="2">
            			<p align="center">30일 초과</p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF" colspan="2">
            			<p align="center">60일 초과</p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF" colspan="2">
            			<p align="center">90일 초과</p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF" colspan="2">
            			<p align="center">120일 초과</p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF" colspan="2">
            			<p align="center">합계</p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF">
            			<p align="center">평균경과일수<!-- 평균처리기일 --></p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF">
            			<p align="center">예상</p>
                    </td>
					<td class="td" bgcolor="#EFEFEF">
            			<p align="center">발생</p>
                    </td>
                </tr>
				</thead>
				<tbody>
			
					<c:forEach var="vo" items="${Work_T1List}" varStatus="status">
				<tr onMouseOver=this.style.backgroundColor="#FFECEC" onMouseOut=this.style.backgroundColor="">
					<c:if test="${status.index == 0}">
						<td class="td" bgcolor="#F8F8F8" rowspan="${Work_T1List.size()}">
							<c:out value="1종" />
						</td>
					</c:if>
					<td>
						<c:out value="${vo.getTeam_name()}" />
					</td>
					<td>
						<c:out value="${vo.getU_cnt()}" />
					</td>
					<td>
						<c:out value="${vo.getPer()}" />
					</td>
					
					<td>
						<c:out value="${vo.getRid_end()}" />
					</td>
					<td>
						<c:out value="${vo.getRid_10m()}" />
					</td>
					<td>
						<c:out value="${vo.getRid_10m_ps()}" />%
					</td>
					<td>
						<c:out value="${vo.getRid_10p()}" />
					</td>
					<td>
						<c:out value="${vo.getRid_10p_ps()}" />%
					</td>
					<td>
						<c:out value="${vo.getRid_20p()}" />
					</td>
					<td>
						<c:out value="${vo.getRid_20p_ps()}" />%
					</td>
					<td>
						<c:out value="${vo.getRid_30p()}" />
					</td>
					<td>
						<c:out value="${vo.getRid_30p_ps()}" />%
					</td>
					<td>
						<c:out value="${vo.getRid_60p()}" />
					</td>
					<td>
						<c:out value="${vo.getRid_60p_ps()}" />%
					</td>
					<td>
						<c:out value="${vo.getRid_90p()}" />
					</td>
					<td>
						<c:out value="${vo.getRid_90p_ps()}" />%
					</td>
					<td>
						<c:out value="${vo.getRid_120p()}" />
					</td>
					<td>
						<c:out value="${vo.getRid_120p_ps()}" />%
					</td>
					<td>
						<c:out value="${vo.getRid_sum()}" />
					</td>
					<td>
						<c:choose>
						<c:when test="${vo.getRid_sum() ne 0}">
							100%
						</c:when>
						<c:otherwise>
							0%
						</c:otherwise>
					</c:choose>
					</td>
					<td>
						<c:out value="${vo.getRid_avr()}" />
					</td>
					<td>
						<c:out value="${vo.getRid_sum_p()}" />
					</td>
					<td>
						<c:out value="${vo.getRid_sum_r()}" />
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
						<fmt:formatNumber value="${work_sum1.getSum_u_cnt()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${work_sum1.getSum_per()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${work_sum1.getSum_rid_end()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${work_sum1.getSum_rid_10m()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${work_sum1.getSum_rid_10m_ps()}" pattern="#,##0.##"/>%
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${work_sum1.getSum_rid_10p()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${work_sum1.getSum_rid_10p_ps()}" pattern="#,##0.##"/>%
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${work_sum1.getSum_rid_20p()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${work_sum1.getSum_rid_20p_ps()}" pattern="#,##0.##"/>%
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${work_sum1.getSum_rid_30p()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${work_sum1.getSum_rid_30p_ps()}" pattern="#,##0.##"/>%
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${work_sum1.getSum_rid_60p()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${work_sum1.getSum_rid_60p_ps()}" pattern="#,##0.##"/>%
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${work_sum1.getSum_rid_90p()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${work_sum1.getSum_rid_90p_ps()}" pattern="#,##0.##"/>%
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${work_sum1.getSum_rid_120p()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${work_sum1.getSum_rid_120p_ps()}" pattern="#,##0.##"/>%
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${work_sum1.getSum_rid_sum()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<br>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<br>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${work_sum1.getSum_rid_sum_p()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber value="${work_sum1.getSum_rid_sum_r()}" pattern="#,##0.##"/>
					</td>
					
					</tr>
					</tbody>
			
				<c:forEach var="vot" items="${Work_T4List}" varStatus="status">
				<tr onMouseOver=this.style.backgroundColor="#FFECEC" onMouseOut=this.style.backgroundColor="">
					<c:if test="${status.index == 0}">
						<td class="td" bgcolor="#F8F8F8" rowspan="${Work_T4List.size()}">
							<c:out value="4종" />
						</td>
					</c:if>
					<td>
						<c:out value="${vot.getTeam_name()}" />
					</td>
					<td>
						<c:out value="${vot.getU_cnt()}" />
					</td>
					<td>
						<c:out value="${vot.getPer()}" />
					</td>
					
					<td>
						<c:out value="${vot.getRid_end()}" />
					</td>
					<td>
						<c:out value="${vot.getRid_10m()}" />
					</td>
					<td>
						<c:out value="${vot.getRid_10m_ps()}" />%
					</td>
					<td>
						<c:out value="${vot.getRid_10p()}" />
					</td>
					<td>
						<c:out value="${vot.getRid_10p_ps()}" />%
					</td>
					<td>
						<c:out value="${vot.getRid_20p()}" />
					</td>
					<td>
						<c:out value="${vot.getRid_20p_ps()}" />%
					</td>
					<td>
						<c:out value="${vot.getRid_30p()}" />
					</td>
					<td>
						<c:out value="${vot.getRid_30p_ps()}" />%
					</td>
					<td>
						<c:out value="${vot.getRid_60p()}" />
					</td>
					<td>
						<c:out value="${vot.getRid_60p_ps()}" />%
					</td>
					<td>
						<c:out value="${vot.getRid_90p()}" />
					</td>
					<td>
						<c:out value="${vot.getRid_90p_ps()}" />%
					</td>
					<td>
						<c:out value="${vot.getRid_120p()}" />
					</td>
					<td>
						<c:out value="${vot.getRid_120p_ps()}" />%
					</td>
					<td>
						<c:out value="${vot.getRid_sum()}" />
					</td>
					<td>
						<c:choose>
						<c:when test="${vot.getRid_sum() ne 0}">
							100%
						</c:when>
						<c:otherwise>
							0%
						</c:otherwise>
					</c:choose>
					</td>
					<td>
						<c:out value="${vot.getRid_avr()}" />
					</td>
					<td>
						<c:out value="${vot.getRid_sum_p()}" />
					</td>
					<td>
						<c:out value="${vot.getRid_sum_r()}" />
					</td>
					
					
				</tr>
				</c:forEach>
				
				<tbody>
				<tr>
					<td class="td" bgcolor="#EFEFEF" colspan="2">
						<p align="center"><b>소계</b></p>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber  value="${work_sum4.getSum_u_cnt()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber  value="${work_sum4.getSum_per()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber  value="${work_sum4.getSum_rid_end()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber  value="${work_sum4.getSum_rid_10m()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber  value="${work_sum4.getSum_rid_10m_ps()}" pattern="#,##0.##"/>%
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber  value="${work_sum4.getSum_rid_10p()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber  value="${work_sum4.getSum_rid_10p_ps()}" pattern="#,##0.##"/>%
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber  value="${work_sum4.getSum_rid_20p()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber  value="${work_sum4.getSum_rid_20p_ps()}" pattern="#,##0.##"/>%
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber  value="${work_sum4.getSum_rid_30p()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber  value="${work_sum4.getSum_rid_30p_ps()}" pattern="#,##0.##"/>%
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber  value="${work_sum4.getSum_rid_60p()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber  value="${work_sum4.getSum_rid_60p_ps()}" pattern="#,##0.##"/>%
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber  value="${work_sum4.getSum_rid_90p()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber  value="${work_sum4.getSum_rid_90p_ps()}" pattern="#,##0.##"/>%
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber  value="${work_sum4.getSum_rid_120p()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber  value="${work_sum4.getSum_rid_120p_ps()}" pattern="#,##0.##"/>%
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber  value="${work_sum4.getSum_rid_sum()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<br>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<br>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber  value="${work_sum4.getSum_rid_sum_p()}" pattern="#,##0.##"/>
					</td>
					<td class="td" bgcolor="#EFEFEF">
						<fmt:formatNumber  value="${work_sum4.getSum_rid_sum_r()}" pattern="#,##0.##"/>
					</td>
					
					</tr>
					</tbody>
				<tbody>
				<tr>
					<td class="td" bgcolor="#F8F8F8" colspan="2">
						<p align="center"><b>합계</b></p>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber  value="${work_sum14.getSum_u_cnt()}" pattern="#,##0.##"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber  value="${work_sum14.getSum_per()}" pattern="#,##0.##"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber  value="${work_sum14.getSum_rid_end()}" pattern="#,##0.##"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber  value="${work_sum14.getSum_rid_10m()}" pattern="#,##0.##"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber  value="${work_sum14.getSum_rid_10m_ps()}" pattern="#,##0.##"/>%
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber  value="${work_sum14.getSum_rid_10p()}" pattern="#,##0.##"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber  value="${work_sum14.getSum_rid_10p_ps()}" pattern="#,##0.##"/>%
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber  value="${work_sum14.getSum_rid_20p()}" pattern="#,##0.##"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber  value="${work_sum14.getSum_rid_20p_ps()}" pattern="#,##0.##"/>%
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber  value="${work_sum14.getSum_rid_30p()}" pattern="#,##0.##"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber  value="${work_sum14.getSum_rid_30p_ps()}" pattern="#,##0.##"/>%
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber  value="${work_sum14.getSum_rid_60p()}" pattern="#,##0.##"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber  value="${work_sum14.getSum_rid_60p_ps()}" pattern="#,##0.##"/>%
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber  value="${work_sum14.getSum_rid_90p()}" pattern="#,##0.##"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber  value="${work_sum14.getSum_rid_90p_ps()}" pattern="#,##0.##"/>%
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber  value="${work_sum14.getSum_rid_120p()}" pattern="#,##0.##"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber  value="${work_sum14.getSum_rid_120p_ps()}" pattern="#,##0.##"/>%
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber  value="${work_sum14.getSum_rid_sum()}" pattern="#,##0.##"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						</font>
						
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber  value="${work_sum14.getSum_rid_sum_p()}" pattern="#,##0.##"/>
						</font>
					</td>
					<td class="td" bgcolor="#F8F8F8"><font color="red">
						<fmt:formatNumber  value="${work_sum14.getSum_rid_sum_r()}" pattern="#,##0.##"/>
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
