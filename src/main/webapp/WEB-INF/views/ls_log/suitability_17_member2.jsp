<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="kmemberList" value="${kmemberList}" />
<c:set var="toMonthInt" value="${toMonthInt}" />
<c:set var="monthInt" value="${monthInt}" />
<c:set var="monthInt" value="${month}" />
<c:set var="Suit_M2List" value="${Suit_M2List}" />


				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">
							<%@ include file="suitability_17_member2_top.jsp" %>
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
									</colgroup>
									<thead>
				 <tr>
                    <td class="td" bgcolor="#EFEFEF" >
                        <p align="center"><font color="black">이름</font></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF" >
                        <p align="center"><font color="black">접수번호</font></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF" >
                        <p align="center"><font color="black">종결번호</font></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF" >
            			<p align="center"><font color="black"><b>보험사</b></font></p>
                    </td>
					<td class="td" bgcolor="#EFEFEF" >
            			<p align="center"><font color="black"><b>건물구분</b></font></p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF" >
            			<p align="center"><font color="black"><b>계약자</b></font></p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF" >
            			<p align="center"><font color="black"><b>수임</b></font></p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF" >
            			<p align="center"><font color="black"><b>종결</b></font></p>
                    </td>
                    <td class="td" bgcolor="#EFEFEF" >
            			<p align="center"><font color="black"><b>종결</b></font></p>
                    </td>
                </tr>
                

               
				</thead>
				<tbody>
			
					<c:forEach var="vo" items="${Suit17_M2List}" varStatus="status">
				<tr onMouseOver=this.style.backgroundColor="#FFECEC" onMouseOut=this.style.backgroundColor="">
					
					<td>
						<c:out value="${name}" />
					</td>
					<td>
						<c:out value="${vo.getReport_id()}" />
					</td>
					<td>
						<c:out value="${vo.getResult_id()}" />
					</td>
					<td>
						<c:out value="${vo.getIg_nick()}" />
					</td>
					<td>
					<c:choose>
						<c:when test="${vo.getBd_type() eq 1}">
							일반
						</c:when>
						<c:otherwise>
							공장
						</c:otherwise>
					</c:choose>
					</td>
					<td>
						<c:out value="${vo.getIg_client()}" />
					</td>
					<td>
						<c:out value="${vo.getReg_date()}" />
					</td>
					<td>
						<c:out value="${vo.getEnd_date()}" />
					</td>
					<td>
						<c:if test="${vo.getReport_1() eq 01}">
							조사완료
						</c:if>
						<c:if test="${vo.getReport_1() eq 02}">
							조사실패
						</c:if>
					</td>
					
				</tr>
				</c:forEach>
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
