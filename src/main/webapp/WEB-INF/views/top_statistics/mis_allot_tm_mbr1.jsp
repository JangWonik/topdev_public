<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
					<div style="width:100%; overflow-x: auto; overflow-y: hidden !important;">
						<div style="width:1882px;" >
							<div class="tableStyle2">
								<table cellpadding="0" cellspacing="0" width="1060" align="center">
						            <colgroup>
						                <col width="180">
						                <col width="45">						                
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						                <col width="46">
						            </colgroup>
						            <thead>
							            <tr>
							                <th colspan="2">${inVO.team_name}</th>
							                <th>합계</th>
							                <th>미결</th>
							                <th>연간<br />수임</th>
							                <th>당월<br />종결</th>
							                <th>연간<br />종결</th>							                
							                <th>${nowVO.dayBefore29.substring(8,10)}</th>
							                <th>${nowVO.dayBefore28.substring(8,10)}</th>
							                <th>${nowVO.dayBefore27.substring(8,10)}</th>
							                <th>${nowVO.dayBefore26.substring(8,10)}</th>
							                <th>${nowVO.dayBefore25.substring(8,10)}</th>
							                <th>${nowVO.dayBefore24.substring(8,10)}</th>
							                <th>${nowVO.dayBefore23.substring(8,10)}</th>
							                <th>${nowVO.dayBefore22.substring(8,10)}</th>
							                <th>${nowVO.dayBefore21.substring(8,10)}</th>
							                <th>${nowVO.dayBefore20.substring(8,10)}</th>
							                <th>${nowVO.dayBefore19.substring(8,10)}</th>
							                <th>${nowVO.dayBefore18.substring(8,10)}</th>
							                <th>${nowVO.dayBefore17.substring(8,10)}</th>
							                <th>${nowVO.dayBefore16.substring(8,10)}</th>
							                <th>${nowVO.dayBefore15.substring(8,10)}</th>
							                <th>${nowVO.dayBefore14.substring(8,10)}</th>
							                <th>${nowVO.dayBefore13.substring(8,10)}</th>
							                <th>${nowVO.dayBefore12.substring(8,10)}</th>
							                <th>${nowVO.dayBefore11.substring(8,10)}</th>
							                <th>${nowVO.dayBefore10.substring(8,10)}</th>
							                <th>${nowVO.dayBefore9.substring(8,10)}</th>
							                <th>${nowVO.dayBefore8.substring(8,10)}</th>
							                <th>${nowVO.dayBefore7.substring(8,10)}</th>
							                <th>${nowVO.dayBefore6.substring(8,10)}</th>
							                <th>${nowVO.dayBefore5.substring(8,10)}</th>
							                <th>${nowVO.dayBefore4.substring(8,10)}</th>
							                <th>${nowVO.dayBefore3.substring(8,10)}</th>
							                <th>${nowVO.dayBefore2.substring(8,10)}</th>
							                <th>${nowVO.dayBefore1.substring(8,10)}</th>
							                <th>${nowVO.dayBefore0.substring(8,10)}</th>
							            </tr>		
						           	</thead>
									<tbody>
							            <c:forEach var="vo" items="${getMisAllotTmMbr1}" varStatus="status">
							                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
							                    <td>${vo.user_name}</td>
							                    <td>
							                    	<p>수임</p><p class="sub-p">종결</p>
							                    </td>
							                    <td bgcolor="#faebd7">
							                    	<c:set var="sub1_regSum" value="${vo.reg_29+vo.reg_28+vo.reg_27+vo.reg_26+vo.reg_25+vo.reg_24+vo.reg_23+vo.reg_22+vo.reg_21+vo.reg_20+vo.reg_19+vo.reg_18+vo.reg_17+vo.reg_16+vo.reg_15+vo.reg_14+vo.reg_13+vo.reg_12+vo.reg_11+vo.reg_10+vo.reg_09+vo.reg_08+vo.reg_07+vo.reg_06+vo.reg_05+vo.reg_04+vo.reg_03+vo.reg_02+vo.reg_01+vo.reg_00}"/>
							                    	<c:set var="sub1_daySum" value="${vo.day_29+vo.day_28+vo.day_27+vo.day_26+vo.day_25+vo.day_24+vo.day_23+vo.day_22+vo.day_21+vo.day_20+vo.day_19+vo.day_18+vo.day_17+vo.day_16+vo.day_15+vo.day_14+vo.day_13+vo.day_12+vo.day_11+vo.day_10+vo.day_09+vo.day_08+vo.day_07+vo.day_06+vo.day_05+vo.day_04+vo.day_03+vo.day_02+vo.day_01+vo.day_00}"/>
							                    	<p>${sub1_regSum}</p><p class="sub-p">${sub1_daySum}</p>
							                  	</td>
							                  	<td bgcolor="#faebd7">
							                    	${vo.reg_mi}
							                    </td>
							                    <td bgcolor="#faebd7">
							                   		${vo.reg_y}
							                 	</td>
							                    <td bgcolor="#faebd7">
							                    	${vo.cls_m}
							                   	</td>
							                    <td bgcolor="#faebd7">
							                    	${vo.cls_y}
							                	</td>
							                    <td>
							                    	<p>${vo.reg_29}</p><p class="sub-p">${vo.day_29}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_28}</p><p class="sub-p">${vo.day_28}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_27}</p><p class="sub-p">${vo.day_27}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_26}</p><p class="sub-p">${vo.day_26}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_25}</p><p class="sub-p">${vo.day_25}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_24}</p><p class="sub-p">${vo.day_24}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_23}</p><p class="sub-p">${vo.day_23}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_22}</p><p class="sub-p">${vo.day_22}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_21}</p><p class="sub-p">${vo.day_21}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_20}</p><p class="sub-p">${vo.day_20}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_19}</p><p class="sub-p">${vo.day_19}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_18}</p><p class="sub-p">${vo.day_18}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_17}</p><p class="sub-p">${vo.day_17}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_16}</p><p class="sub-p">${vo.day_16}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_15}</p><p class="sub-p">${vo.day_15}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_14}</p><p class="sub-p">${vo.day_14}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_13}</p><p class="sub-p">${vo.day_13}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_12}</p><p class="sub-p">${vo.day_12}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_11}</p><p class="sub-p">${vo.day_11}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_10}</p><p class="sub-p">${vo.day_10}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_09}</p><p class="sub-p">${vo.day_09}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_08}</p><p class="sub-p">${vo.day_08}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_07}</p><p class="sub-p">${vo.day_07}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_06}</p><p class="sub-p">${vo.day_06}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_05}</p><p class="sub-p">${vo.day_05}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_04}</p><p class="sub-p">${vo.day_04}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_03}</p><p class="sub-p">${vo.day_03}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_02}</p><p class="sub-p">${vo.day_02}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_01}</p><p class="sub-p">${vo.day_01}</p>
							                    </td>
							                    <td>
							                    	<p>${vo.reg_00}</p><p class="sub-p">${vo.day_00}</p>
							                    </td>							                    
							                </tr>
							                <%-- <c:set var="sumReg_30" value="${sumReg_30 + vo.reg_30}" /> --%>
							                <c:set var="sumReg_29" value="${sumReg_29 + vo.reg_29}" />
							                <c:set var="sumReg_28" value="${sumReg_28 + vo.reg_28}" />
							                <c:set var="sumReg_27" value="${sumReg_27 + vo.reg_27}" />
							                <c:set var="sumReg_26" value="${sumReg_26 + vo.reg_26}" />
							                <c:set var="sumReg_25" value="${sumReg_25 + vo.reg_25}" />
							                <c:set var="sumReg_24" value="${sumReg_24 + vo.reg_24}" />
							                <c:set var="sumReg_23" value="${sumReg_23 + vo.reg_23}" />
							                <c:set var="sumReg_22" value="${sumReg_22 + vo.reg_22}" />
							                <c:set var="sumReg_21" value="${sumReg_21 + vo.reg_21}" />
							                <c:set var="sumReg_20" value="${sumReg_20 + vo.reg_20}" />
							                <c:set var="sumReg_19" value="${sumReg_19 + vo.reg_19}" />
							                <c:set var="sumReg_18" value="${sumReg_18 + vo.reg_18}" />
							                <c:set var="sumReg_17" value="${sumReg_17 + vo.reg_17}" />
							                <c:set var="sumReg_16" value="${sumReg_16 + vo.reg_16}" />
							                <c:set var="sumReg_15" value="${sumReg_15 + vo.reg_15}" />
							                <c:set var="sumReg_14" value="${sumReg_14 + vo.reg_14}" />
							                <c:set var="sumReg_13" value="${sumReg_13 + vo.reg_13}" />
							                <c:set var="sumReg_12" value="${sumReg_12 + vo.reg_12}" />
							                <c:set var="sumReg_11" value="${sumReg_11 + vo.reg_11}" />
							                <c:set var="sumReg_10" value="${sumReg_10 + vo.reg_10}" />
							                <c:set var="sumReg_09" value="${sumReg_09 + vo.reg_09}" />
							                <c:set var="sumReg_08" value="${sumReg_08 + vo.reg_08}" />
							                <c:set var="sumReg_07" value="${sumReg_07 + vo.reg_07}" />
							                <c:set var="sumReg_06" value="${sumReg_06 + vo.reg_06}" />
							                <c:set var="sumReg_05" value="${sumReg_05 + vo.reg_05}" />
							                <c:set var="sumReg_04" value="${sumReg_04 + vo.reg_04}" />
							                <c:set var="sumReg_03" value="${sumReg_03 + vo.reg_03}" />
							                <c:set var="sumReg_02" value="${sumReg_02 + vo.reg_02}" />
							                <c:set var="sumReg_01" value="${sumReg_01 + vo.reg_01}" />
							                <c:set var="sumReg_00" value="${sumReg_00 + vo.reg_00}" />
							                <c:set var="sumReg_sum" value="${sumReg_sum + sub1_regSum}" />
							                
							                
							                <%-- <c:set var="sumDay_30" value="${sumDay_30 + vo.day_30}" /> --%>
							                <c:set var="sumDay_29" value="${sumDay_29 + vo.day_29}" />
							                <c:set var="sumDay_28" value="${sumDay_28 + vo.day_28}" />
							                <c:set var="sumDay_27" value="${sumDay_27 + vo.day_27}" />
							                <c:set var="sumDay_26" value="${sumDay_26 + vo.day_26}" />
							                <c:set var="sumDay_25" value="${sumDay_25 + vo.day_25}" />
							                <c:set var="sumDay_24" value="${sumDay_24 + vo.day_24}" />
							                <c:set var="sumDay_23" value="${sumDay_23 + vo.day_23}" />
							                <c:set var="sumDay_22" value="${sumDay_22 + vo.day_22}" />
							                <c:set var="sumDay_21" value="${sumDay_21 + vo.day_21}" />
							                <c:set var="sumDay_20" value="${sumDay_20 + vo.day_20}" />
							                <c:set var="sumDay_19" value="${sumDay_19 + vo.day_19}" />
							                <c:set var="sumDay_18" value="${sumDay_18 + vo.day_18}" />
							                <c:set var="sumDay_17" value="${sumDay_17 + vo.day_17}" />
							                <c:set var="sumDay_16" value="${sumDay_16 + vo.day_16}" />
							                <c:set var="sumDay_15" value="${sumDay_15 + vo.day_15}" />
							                <c:set var="sumDay_14" value="${sumDay_14 + vo.day_14}" />
							                <c:set var="sumDay_13" value="${sumDay_13 + vo.day_13}" />
							                <c:set var="sumDay_12" value="${sumDay_12 + vo.day_12}" />
							                <c:set var="sumDay_11" value="${sumDay_11 + vo.day_11}" />
							                <c:set var="sumDay_10" value="${sumDay_10 + vo.day_10}" />
							                <c:set var="sumDay_09" value="${sumDay_09 + vo.day_09}" />
							                <c:set var="sumDay_08" value="${sumDay_08 + vo.day_08}" />
							                <c:set var="sumDay_07" value="${sumDay_07 + vo.day_07}" />
							                <c:set var="sumDay_06" value="${sumDay_06 + vo.day_06}" />
							                <c:set var="sumDay_05" value="${sumDay_05 + vo.day_05}" />
							                <c:set var="sumDay_04" value="${sumDay_04 + vo.day_04}" />
							                <c:set var="sumDay_03" value="${sumDay_03 + vo.day_03}" />
							                <c:set var="sumDay_02" value="${sumDay_02 + vo.day_02}" />
							                <c:set var="sumDay_01" value="${sumDay_01 + vo.day_01}" />
							                <c:set var="sumDay_00" value="${sumDay_00 + vo.day_00}" />                
							                <c:set var="sumDay_sum" value="${sumDay_sum + sub1_daySum}" />
							                
							                <c:set var="sumReg_y" value="${sumReg_y + vo.reg_y}" />
							                <c:set var="sumCls_m" value="${sumCls_m + vo.cls_m}" />
							                <c:set var="sumCls_y" value="${sumCls_y + vo.cls_y}" />
							                <c:set var="sumReg_mi" value="${sumReg_mi + vo.reg_mi}" />
							            </c:forEach>
							            <tr bgcolor="#E7ECF1">
							                <th colspan="2">소계</th>
							                <th>
							                	<p>
							                		<fmt:formatNumber value="${sumReg_sum}" pattern="#,###"/>
							                	</p>
							                	<p class="sub-p">
							                		<fmt:formatNumber value="${sumDay_sum}" pattern="#,###"/>							                		
							                	</p>
							               	</th>							                
							               	<th><fmt:formatNumber value="${sumReg_mi}" pattern="#,###"/></th>
							               	<th><fmt:formatNumber value="${sumReg_y}" pattern="#,###"/></th>
							                <th><fmt:formatNumber value="${sumCls_m}" pattern="#,###"/></th>
							                <th><fmt:formatNumber value="${sumCls_y}" pattern="#,###"/></th>
							                <th>
												<p>${sumReg_29}</p><p class="sub-p">${sumDay_29}</p>
							               	</th>
							                <th>
												<p>${sumReg_28}</p><p class="sub-p">${sumDay_28}</p>
							               	</th>
							                <th>
												<p>${sumReg_27}</p><p class="sub-p">${sumDay_27}</p>
							               	</th>
							                <th>
												<p>${sumReg_26}</p><p class="sub-p">${sumDay_26}</p>
							               	</th>
							                <th>
												<p>${sumReg_25}</p><p class="sub-p">${sumDay_25}</p>
							               	</th>
							                <th>
												<p>${sumReg_24}</p><p class="sub-p">${sumDay_24}</p>
							               	</th>
							                <th>
												<p>${sumReg_23}</p><p class="sub-p">${sumDay_23}</p>
							               	</th>
							                <th>
												<p>${sumReg_22}</p><p class="sub-p">${sumDay_22}</p>
							               	</th>
							                <th>
												<p>${sumReg_21}</p><p class="sub-p">${sumDay_21}</p>
							               	</th>
							                <th>
												<p>${sumReg_20}</p><p class="sub-p">${sumDay_20}</p>
							               	</th>
							                <th>
												<p>${sumReg_19}</p><p class="sub-p">${sumDay_19}</p>
							               	</th>
							                <th>
												<p>${sumReg_18}</p><p class="sub-p">${sumDay_18}</p>
							               	</th>
							                <th>
												<p>${sumReg_17}</p><p class="sub-p">${sumDay_17}</p>
							               	</th>
							                <th>
												<p>${sumReg_16}</p><p class="sub-p">${sumDay_16}</p>
							               	</th>
							                <th>
												<p>${sumReg_15}</p><p class="sub-p">${sumDay_15}</p>
							               	</th>
							                <th>
												<p>${sumReg_14}</p><p class="sub-p">${sumDay_14}</p>
							               	</th>
							                <th>
												<p>${sumReg_13}</p><p class="sub-p">${sumDay_13}</p>
							               	</th>
							                <th>
												<p>${sumReg_12}</p><p class="sub-p">${sumDay_12}</p>
							               	</th>
							                <th>
												<p>${sumReg_11}</p><p class="sub-p">${sumDay_11}</p>
							               	</th>
							                <th>
												<p>${sumReg_10}</p><p class="sub-p">${sumDay_10}</p>
							               	</th>
							                <th>
												<p>${sumReg_09}</p><p class="sub-p">${sumDay_09}</p>
							               	</th>
							                <th>
												<p>${sumReg_08}</p><p class="sub-p">${sumDay_08}</p>
							               	</th>
							                <th>
												<p>${sumReg_07}</p><p class="sub-p">${sumDay_07}</p>
							               	</th>
							                <th>
												<p>${sumReg_06}</p><p class="sub-p">${sumDay_06}</p>
							               	</th>
							                <th>
												<p>${sumReg_05}</p><p class="sub-p">${sumDay_05}</p>
							               	</th>
							                <th>
												<p>${sumReg_04}</p><p class="sub-p">${sumDay_04}</p>
							               	</th>
							                <th>
												<p>${sumReg_03}</p><p class="sub-p">${sumDay_03}</p>
							               	</th>
							                <th>
												<p>${sumReg_02}</p><p class="sub-p">${sumDay_02}</p>
							               	</th>
							                <th>
												<p>${sumReg_01}</p><p class="sub-p">${sumDay_01}</p>
							               	</th>
							                <th>
												<p>${sumReg_00}</p><p class="sub-p">${sumDay_00}</p>
							               	</th>					                
							            </tr>							        
									</tbody>
								</table>
							</div>
						</div>
					</div>