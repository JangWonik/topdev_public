<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2">
	<div style="width:100%; overflow-x: auto; overflow-y: hidden !important;">
		<div style="width:1882px;" >
		    <div style="padding-right: 17px;background: #e7ecf1;">
		        <table cellpadding="0" cellspacing="0" width="1060" align="center">
		            <colgroup>
		                <col width="178">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">		                
		            </colgroup>
		            <thead>
		            <tr>
		                <th class="border-right">센터명 (인원)</th>
		                <th class="border-right">합계</th>		                
		                <th class="border-right">인당<br/>건수</th>
		                <th class="border-right">인당<br/>미결</th>
		                <th>미결</th>
		                <th>연간<br />수임</th>
		                <th>당월<br />종결</th>
		                <th class="border-right">연간<br />종결</th>		                
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
		        </table>
		    </div>
		    <div style="height:632px; overflow-x: hidden; overflow-y: auto;">
		        <table cellpadding="0" cellspacing="0" width="1060" align="center">
		            <colgroup>
		                <col width="135">
		                <col width="43">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">
		                <col width="44">		                
		            </colgroup>
		            <tbody>
		            <c:forEach var="center" items="${TeamCenterListVO}" varStatus="status">
		            	<!-- 기타는 제외하고 표시한다. -->		            	
		            	<c:if test="${center.team_center ne 999 && center.team_center ne 51 && center.team_center ne 52 && center.team_center ne 101 && center.team_center ne 102 && center.team_center ne 103}">
		            		<tr style="cursor:pointer; bgcolor: #E7ECF1; text-align: center;" onclick="openCenterByPtnrModal(${center.team_center},'${center.team_center_val}');" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">		                    
			                    <td>${center.team_center_val} (${center.member_cnt})</td>
			                    <td class="border-right">
			                    	<p>수임</p><p class="sub-p">종결</p>
			                    </td>
			                    <td class="border-right">		                    	
			                    	<c:set var="sub1_regSum" value="${center.reg_29+center.reg_28+center.reg_27+center.reg_26+center.reg_25+center.reg_24+center.reg_23+center.reg_22+center.reg_21+center.reg_20+center.reg_19+center.reg_18+center.reg_17+center.reg_16+center.reg_15+center.reg_14+center.reg_13+center.reg_12+center.reg_11+center.reg_10+center.reg_09+center.reg_08+center.reg_07+center.reg_06+center.reg_05+center.reg_04+center.reg_03+center.reg_02+center.reg_01+center.reg_00-center.reg_wc_29-center.reg_wc_28-center.reg_wc_27-center.reg_wc_26-center.reg_wc_25-center.reg_wc_24-center.reg_wc_23-center.reg_wc_22-center.reg_wc_21-center.reg_wc_20-center.reg_wc_19-center.reg_wc_18-center.reg_wc_17-center.reg_wc_16-center.reg_wc_15-center.reg_wc_14-center.reg_wc_13-center.reg_wc_12-center.reg_wc_11-center.reg_wc_10-center.reg_wc_09-center.reg_wc_08-center.reg_wc_07-center.reg_wc_06-center.reg_wc_05-center.reg_wc_04-center.reg_wc_03-center.reg_wc_02-center.reg_wc_01-center.reg_wc_00}"/>
			                    	<c:set var="sub1_daySum" value="${center.day_29+center.day_28+center.day_27+center.day_26+center.day_25+center.day_24+center.day_23+center.day_22+center.day_21+center.day_20+center.day_19+center.day_18+center.day_17+center.day_16+center.day_15+center.day_14+center.day_13+center.day_12+center.day_11+center.day_10+center.day_09+center.day_08+center.day_07+center.day_06+center.day_05+center.day_04+center.day_03+center.day_02+center.day_01+center.day_00-center.day_wc_29-center.day_wc_28-center.day_wc_27-center.day_wc_26-center.day_wc_25-center.day_wc_24-center.day_wc_23-center.day_wc_22-center.day_wc_21-center.day_wc_20-center.day_wc_19-center.day_wc_18-center.day_wc_17-center.day_wc_16-center.day_wc_15-center.day_wc_14-center.day_wc_13-center.day_wc_12-center.day_wc_11-center.day_wc_10-center.day_wc_09-center.day_wc_08-center.day_wc_07-center.day_wc_06-center.day_wc_05-center.day_wc_04-center.day_wc_03-center.day_wc_02-center.day_wc_01-center.day_wc_00}"/>
			                    	<p>${sub1_regSum}</p><p class="sub-p">${sub1_daySum}</p>
			                  	</td>			                  	
			                  	<!-- 1인당 건수 시작 -->
			                  	<td class="border-right" bgcolor="#faebd7">
			                  		<c:choose>		                  			
			                  			<c:when test="${center.member_cnt eq 0}">
			                  				<p>0</p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:when test="${sub1_regSum eq 0 && sub1_daySum ne 0}">
			                  				<p>0</p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / center.member_cnt}" pattern="#.#"/></p>
			                  			</c:when>
			                  			<c:when test="${sub1_regSum ne 0 && sub1_daySum eq 0}">
			                  				<p><fmt:formatNumber value="${sub1_regSum / center.member_cnt}" pattern="#.#"/></p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:otherwise>
			                  				<p><fmt:formatNumber value="${sub1_regSum / center.member_cnt}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / center.member_cnt}" pattern="#.#"/></p>
			                  			</c:otherwise>
			                  		</c:choose>		                  		
			                  	</td>
			                  	<!-- 1인당 건수 끝 -->			                  	
			                    <!-- 1인당 미결 시작 -->
								<td class="border-right" bgcolor="#faebd7">
									<c:choose>		                  			
										<c:when test="${ center.member_cnt eq 0}">
											<p>0</p>
										</c:when>
										<c:when test="${ (center.reg_mi - center.reg_wc_mi) eq 0 }">
											<p>0</p>
										</c:when>		                  			
										<c:otherwise>
											<p><fmt:formatNumber value="${(center.reg_mi - center.reg_wc_mi) / center.member_cnt}" pattern="#.#"/></p>
										</c:otherwise>
									</c:choose>		                  		
								</td>
								<!-- 1인당 미결 끝 -->
								<td bgcolor="#faebd7">
			                    	<font color="">${center.reg_mi - center.reg_wc_mi}</font>
			                    </td>
			                    <td bgcolor="#faebd7">
			                   		${center.reg_y - center.reg_wc_y}
			                 	</td>
			                    <td bgcolor="#faebd7">
			                    	${center.cls_m - center.cls_wc_m}
			                   	</td>
			                    <td class="border-right" bgcolor="#faebd7">
			                    	${center.cls_y - center.cls_wc_y}
			                	</td>
			                    <td>
			                    	<p>${center.reg_29 - center.reg_wc_29}</p><p class="sub-p">${center.day_29 - center.day_wc_29}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_28 - center.reg_wc_28}</p><p class="sub-p">${center.day_28 - center.day_wc_28}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_27 - center.reg_wc_27}</p><p class="sub-p">${center.day_27 - center.day_wc_27}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_26 - center.reg_wc_26}</p><p class="sub-p">${center.day_26 - center.day_wc_26}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_25 - center.reg_wc_25}</p><p class="sub-p">${center.day_25 - center.day_wc_25}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_24 - center.reg_wc_24}</p><p class="sub-p">${center.day_24 - center.day_wc_24}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_23 - center.reg_wc_23}</p><p class="sub-p">${center.day_23 - center.day_wc_23}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_22 - center.reg_wc_22}</p><p class="sub-p">${center.day_22 - center.day_wc_22}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_21 - center.reg_wc_21}</p><p class="sub-p">${center.day_21 - center.day_wc_21}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_20 - center.reg_wc_20}</p><p class="sub-p">${center.day_20 - center.day_wc_20}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_19 - center.reg_wc_19}</p><p class="sub-p">${center.day_19 - center.day_wc_19}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_18 - center.reg_wc_18}</p><p class="sub-p">${center.day_18 - center.day_wc_18}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_17 - center.reg_wc_17}</p><p class="sub-p">${center.day_17 - center.day_wc_17}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_16 - center.reg_wc_16}</p><p class="sub-p">${center.day_16 - center.day_wc_16}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_15 - center.reg_wc_15}</p><p class="sub-p">${center.day_15 - center.day_wc_15}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_14 - center.reg_wc_14}</p><p class="sub-p">${center.day_14 - center.day_wc_14}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_13 - center.reg_wc_13}</p><p class="sub-p">${center.day_13 - center.day_wc_13}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_12 - center.reg_wc_12}</p><p class="sub-p">${center.day_12 - center.day_wc_12}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_11 - center.reg_wc_11}</p><p class="sub-p">${center.day_11 - center.day_wc_11}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_10 - center.reg_wc_10}</p><p class="sub-p">${center.day_10 - center.day_wc_10}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_09 - center.reg_wc_09}</p><p class="sub-p">${center.day_09 - center.day_wc_09}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_08 - center.reg_wc_08}</p><p class="sub-p">${center.day_08 - center.day_wc_08}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_07 - center.reg_wc_07}</p><p class="sub-p">${center.day_07 - center.day_wc_07}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_06 - center.reg_wc_06}</p><p class="sub-p">${center.day_06 - center.day_wc_06}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_05 - center.reg_wc_05}</p><p class="sub-p">${center.day_05 - center.day_wc_05}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_04 - center.reg_wc_04}</p><p class="sub-p">${center.day_04 - center.day_wc_04}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_03 - center.reg_wc_03}</p><p class="sub-p">${center.day_03 - center.day_wc_03}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_02 - center.reg_wc_02}</p><p class="sub-p">${center.day_02 - center.day_wc_02}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_01 - center.reg_wc_01}</p><p class="sub-p">${center.day_01 - center.day_wc_01}</p>
			                    </td>
			                    <td>
			                    	<p>${center.reg_00 - center.reg_wc_00}</p><p class="sub-p">${center.day_00 - center.day_wc_00}</p>
			                    </td>	                    
			                </tr>	
			                <!-- 조사 소계 계산시작 -->
			                <c:set var="sumMember_cnt_mid" value="${sumMember_cnt_mid + center.member_cnt}" />
			                <c:set var="sumReg_mid_29" value="${sumReg_mid_29 + center.reg_29 - center.reg_wc_29}" />
			                <c:set var="sumReg_mid_28" value="${sumReg_mid_28 + center.reg_28 - center.reg_wc_28}" />
			                <c:set var="sumReg_mid_27" value="${sumReg_mid_27 + center.reg_27 - center.reg_wc_27}" />
			                <c:set var="sumReg_mid_26" value="${sumReg_mid_26 + center.reg_26 - center.reg_wc_26}" />
			                <c:set var="sumReg_mid_25" value="${sumReg_mid_25 + center.reg_25 - center.reg_wc_25}" />
			                <c:set var="sumReg_mid_24" value="${sumReg_mid_24 + center.reg_24 - center.reg_wc_24}" />
			                <c:set var="sumReg_mid_23" value="${sumReg_mid_23 + center.reg_23 - center.reg_wc_23}" />
			                <c:set var="sumReg_mid_22" value="${sumReg_mid_22 + center.reg_22 - center.reg_wc_22}" />
			                <c:set var="sumReg_mid_21" value="${sumReg_mid_21 + center.reg_21 - center.reg_wc_21}" />
			                <c:set var="sumReg_mid_20" value="${sumReg_mid_20 + center.reg_20 - center.reg_wc_20}" />
			                <c:set var="sumReg_mid_19" value="${sumReg_mid_19 + center.reg_19 - center.reg_wc_19}" />
			                <c:set var="sumReg_mid_18" value="${sumReg_mid_18 + center.reg_18 - center.reg_wc_18}" />
			                <c:set var="sumReg_mid_17" value="${sumReg_mid_17 + center.reg_17 - center.reg_wc_17}" />
			                <c:set var="sumReg_mid_16" value="${sumReg_mid_16 + center.reg_16 - center.reg_wc_16}" />
			                <c:set var="sumReg_mid_15" value="${sumReg_mid_15 + center.reg_15 - center.reg_wc_15}" />
			                <c:set var="sumReg_mid_14" value="${sumReg_mid_14 + center.reg_14 - center.reg_wc_14}" />
			                <c:set var="sumReg_mid_13" value="${sumReg_mid_13 + center.reg_13 - center.reg_wc_13}" />
			                <c:set var="sumReg_mid_12" value="${sumReg_mid_12 + center.reg_12 - center.reg_wc_12}" />
			                <c:set var="sumReg_mid_11" value="${sumReg_mid_11 + center.reg_11 - center.reg_wc_11}" />
			                <c:set var="sumReg_mid_10" value="${sumReg_mid_10 + center.reg_10 - center.reg_wc_10}" />
			                <c:set var="sumReg_mid_09" value="${sumReg_mid_09 + center.reg_09 - center.reg_wc_09}" />
			                <c:set var="sumReg_mid_08" value="${sumReg_mid_08 + center.reg_08 - center.reg_wc_08}" />
			                <c:set var="sumReg_mid_07" value="${sumReg_mid_07 + center.reg_07 - center.reg_wc_07}" />
			                <c:set var="sumReg_mid_06" value="${sumReg_mid_06 + center.reg_06 - center.reg_wc_06}" />
			                <c:set var="sumReg_mid_05" value="${sumReg_mid_05 + center.reg_05 - center.reg_wc_05}" />
			                <c:set var="sumReg_mid_04" value="${sumReg_mid_04 + center.reg_04 - center.reg_wc_04}" />
			                <c:set var="sumReg_mid_03" value="${sumReg_mid_03 + center.reg_03 - center.reg_wc_03}" />
			                <c:set var="sumReg_mid_02" value="${sumReg_mid_02 + center.reg_02 - center.reg_wc_02}" />
			                <c:set var="sumReg_mid_01" value="${sumReg_mid_01 + center.reg_01 - center.reg_wc_01}" />
			                <c:set var="sumReg_mid_00" value="${sumReg_mid_00 + center.reg_00 - center.reg_wc_00}" />
			                <c:set var="sumReg_mid_sum" value="${sumReg_mid_sum + sub1_regSum}" />		                
			                		                
			                <c:set var="sumDay_mid_29" value="${sumDay_mid_29 + center.day_29 - center.day_wc_29}" />
			                <c:set var="sumDay_mid_28" value="${sumDay_mid_28 + center.day_28 - center.day_wc_28}" />
			                <c:set var="sumDay_mid_27" value="${sumDay_mid_27 + center.day_27 - center.day_wc_27}" />
			                <c:set var="sumDay_mid_26" value="${sumDay_mid_26 + center.day_26 - center.day_wc_26}" />
			                <c:set var="sumDay_mid_25" value="${sumDay_mid_25 + center.day_25 - center.day_wc_25}" />
			                <c:set var="sumDay_mid_24" value="${sumDay_mid_24 + center.day_24 - center.day_wc_24}" />
			                <c:set var="sumDay_mid_23" value="${sumDay_mid_23 + center.day_23 - center.day_wc_23}" />
			                <c:set var="sumDay_mid_22" value="${sumDay_mid_22 + center.day_22 - center.day_wc_22}" />
			                <c:set var="sumDay_mid_21" value="${sumDay_mid_21 + center.day_21 - center.day_wc_21}" />
			                <c:set var="sumDay_mid_20" value="${sumDay_mid_20 + center.day_20 - center.day_wc_20}" />
			                <c:set var="sumDay_mid_19" value="${sumDay_mid_19 + center.day_19 - center.day_wc_19}" />
			                <c:set var="sumDay_mid_18" value="${sumDay_mid_18 + center.day_18 - center.day_wc_18}" />
			                <c:set var="sumDay_mid_17" value="${sumDay_mid_17 + center.day_17 - center.day_wc_17}" />
			                <c:set var="sumDay_mid_16" value="${sumDay_mid_16 + center.day_16 - center.day_wc_16}" />
			                <c:set var="sumDay_mid_15" value="${sumDay_mid_15 + center.day_15 - center.day_wc_15}" />
			                <c:set var="sumDay_mid_14" value="${sumDay_mid_14 + center.day_14 - center.day_wc_14}" />
			                <c:set var="sumDay_mid_13" value="${sumDay_mid_13 + center.day_13 - center.day_wc_13}" />
			                <c:set var="sumDay_mid_12" value="${sumDay_mid_12 + center.day_12 - center.day_wc_12}" />
			                <c:set var="sumDay_mid_11" value="${sumDay_mid_11 + center.day_11 - center.day_wc_11}" />
			                <c:set var="sumDay_mid_10" value="${sumDay_mid_10 + center.day_10 - center.day_wc_10}" />
			                <c:set var="sumDay_mid_09" value="${sumDay_mid_09 + center.day_09 - center.day_wc_09}" />
			                <c:set var="sumDay_mid_08" value="${sumDay_mid_08 + center.day_08 - center.day_wc_08}" />
			                <c:set var="sumDay_mid_07" value="${sumDay_mid_07 + center.day_07 - center.day_wc_07}" />
			                <c:set var="sumDay_mid_06" value="${sumDay_mid_06 + center.day_06 - center.day_wc_06}" />
			                <c:set var="sumDay_mid_05" value="${sumDay_mid_05 + center.day_05 - center.day_wc_05}" />
			                <c:set var="sumDay_mid_04" value="${sumDay_mid_04 + center.day_04 - center.day_wc_04}" />
			                <c:set var="sumDay_mid_03" value="${sumDay_mid_03 + center.day_03 - center.day_wc_03}" />
			                <c:set var="sumDay_mid_02" value="${sumDay_mid_02 + center.day_02 - center.day_wc_02}" />
			                <c:set var="sumDay_mid_01" value="${sumDay_mid_01 + center.day_01 - center.day_wc_01}" />
			                <c:set var="sumDay_mid_00" value="${sumDay_mid_00 + center.day_00 - center.day_wc_00}" />                
			                <c:set var="sumDay_mid_sum" value="${sumDay_mid_sum + sub1_daySum}" />
			                
			                <c:set var="sumReg_mid_y" value="${sumReg_mid_y + center.reg_y - center.reg_wc_y}" />
			                <c:set var="sumCls_mid_m" value="${sumCls_mid_m + center.cls_m - center.cls_wc_m}" />
			                <c:set var="sumCls_mid_y" value="${sumCls_mid_y + center.cls_y - center.cls_wc_y}" />
			                <c:set var="sumReg_mid_mi" value="${sumReg_mid_mi + center.reg_mi - center.reg_wc_mi}" />
			                <!-- 조사 소계 계산 끝 -->	
		            	</c:if>
		            	
		            	<!-- 물보험 합산 계산 시작 -->
		            	<c:set var="sumMember_cnt_center" value="${sumMember_cnt_center + center.member_cnt}" />
		            	<c:set var="sumReg_center_29" value="${sumReg_center_29 + center.reg_29}" />
		                <c:set var="sumReg_center_28" value="${sumReg_center_28 + center.reg_28}" />
		                <c:set var="sumReg_center_27" value="${sumReg_center_27 + center.reg_27}" />
		                <c:set var="sumReg_center_26" value="${sumReg_center_26 + center.reg_26}" />
		                <c:set var="sumReg_center_25" value="${sumReg_center_25 + center.reg_25}" />
		                <c:set var="sumReg_center_24" value="${sumReg_center_24 + center.reg_24}" />
		                <c:set var="sumReg_center_23" value="${sumReg_center_23 + center.reg_23}" />
		                <c:set var="sumReg_center_22" value="${sumReg_center_22 + center.reg_22}" />
		                <c:set var="sumReg_center_21" value="${sumReg_center_21 + center.reg_21}" />
		                <c:set var="sumReg_center_20" value="${sumReg_center_20 + center.reg_20}" />
		                <c:set var="sumReg_center_19" value="${sumReg_center_19 + center.reg_19}" />
		                <c:set var="sumReg_center_18" value="${sumReg_center_18 + center.reg_18}" />
		                <c:set var="sumReg_center_17" value="${sumReg_center_17 + center.reg_17}" />
		                <c:set var="sumReg_center_16" value="${sumReg_center_16 + center.reg_16}" />
		                <c:set var="sumReg_center_15" value="${sumReg_center_15 + center.reg_15}" />
		                <c:set var="sumReg_center_14" value="${sumReg_center_14 + center.reg_14}" />
		                <c:set var="sumReg_center_13" value="${sumReg_center_13 + center.reg_13}" />
		                <c:set var="sumReg_center_12" value="${sumReg_center_12 + center.reg_12}" />
		                <c:set var="sumReg_center_11" value="${sumReg_center_11 + center.reg_11}" />
		                <c:set var="sumReg_center_10" value="${sumReg_center_10 + center.reg_10}" />
		                <c:set var="sumReg_center_09" value="${sumReg_center_09 + center.reg_09}" />
		                <c:set var="sumReg_center_08" value="${sumReg_center_08 + center.reg_08}" />
		                <c:set var="sumReg_center_07" value="${sumReg_center_07 + center.reg_07}" />
		                <c:set var="sumReg_center_06" value="${sumReg_center_06 + center.reg_06}" />
		                <c:set var="sumReg_center_05" value="${sumReg_center_05 + center.reg_05}" />
		                <c:set var="sumReg_center_04" value="${sumReg_center_04 + center.reg_04}" />
		                <c:set var="sumReg_center_03" value="${sumReg_center_03 + center.reg_03}" />
		                <c:set var="sumReg_center_02" value="${sumReg_center_02 + center.reg_02}" />
		                <c:set var="sumReg_center_01" value="${sumReg_center_01 + center.reg_01}" />
		                <c:set var="sumReg_center_00" value="${sumReg_center_00 + center.reg_00}" />
		                <c:set var="sumReg_center_sum" value="${sumReg_center_sum + center.reg_29+center.reg_28+center.reg_27+center.reg_26+center.reg_25+center.reg_24+center.reg_23+center.reg_22+center.reg_21+center.reg_20+center.reg_19+center.reg_18+center.reg_17+center.reg_16+center.reg_15+center.reg_14+center.reg_13+center.reg_12+center.reg_11+center.reg_10+center.reg_09+center.reg_08+center.reg_07+center.reg_06+center.reg_05+center.reg_04+center.reg_03+center.reg_02+center.reg_01+center.reg_00}" />		                
		                		                
		                <c:set var="sumDay_center_29" value="${sumDay_center_29 + center.day_29}" />
		                <c:set var="sumDay_center_28" value="${sumDay_center_28 + center.day_28}" />
		                <c:set var="sumDay_center_27" value="${sumDay_center_27 + center.day_27}" />
		                <c:set var="sumDay_center_26" value="${sumDay_center_26 + center.day_26}" />
		                <c:set var="sumDay_center_25" value="${sumDay_center_25 + center.day_25}" />
		                <c:set var="sumDay_center_24" value="${sumDay_center_24 + center.day_24}" />
		                <c:set var="sumDay_center_23" value="${sumDay_center_23 + center.day_23}" />
		                <c:set var="sumDay_center_22" value="${sumDay_center_22 + center.day_22}" />
		                <c:set var="sumDay_center_21" value="${sumDay_center_21 + center.day_21}" />
		                <c:set var="sumDay_center_20" value="${sumDay_center_20 + center.day_20}" />
		                <c:set var="sumDay_center_19" value="${sumDay_center_19 + center.day_19}" />
		                <c:set var="sumDay_center_18" value="${sumDay_center_18 + center.day_18}" />
		                <c:set var="sumDay_center_17" value="${sumDay_center_17 + center.day_17}" />
		                <c:set var="sumDay_center_16" value="${sumDay_center_16 + center.day_16}" />
		                <c:set var="sumDay_center_15" value="${sumDay_center_15 + center.day_15}" />
		                <c:set var="sumDay_center_14" value="${sumDay_center_14 + center.day_14}" />
		                <c:set var="sumDay_center_13" value="${sumDay_center_13 + center.day_13}" />
		                <c:set var="sumDay_center_12" value="${sumDay_center_12 + center.day_12}" />
		                <c:set var="sumDay_center_11" value="${sumDay_center_11 + center.day_11}" />
		                <c:set var="sumDay_center_10" value="${sumDay_center_10 + center.day_10}" />
		                <c:set var="sumDay_center_09" value="${sumDay_center_09 + center.day_09}" />
		                <c:set var="sumDay_center_08" value="${sumDay_center_08 + center.day_08}" />
		                <c:set var="sumDay_center_07" value="${sumDay_center_07 + center.day_07}" />
		                <c:set var="sumDay_center_06" value="${sumDay_center_06 + center.day_06}" />
		                <c:set var="sumDay_center_05" value="${sumDay_center_05 + center.day_05}" />
		                <c:set var="sumDay_center_04" value="${sumDay_center_04 + center.day_04}" />
		                <c:set var="sumDay_center_03" value="${sumDay_center_03 + center.day_03}" />
		                <c:set var="sumDay_center_02" value="${sumDay_center_02 + center.day_02}" />
		                <c:set var="sumDay_center_01" value="${sumDay_center_01 + center.day_01}" />
		                <c:set var="sumDay_center_00" value="${sumDay_center_00 + center.day_00}" />                
		                <c:set var="sumDay_center_sum" value="${sumDay_center_sum + center.day_29+center.day_28+center.day_27+center.day_26+center.day_25+center.day_24+center.day_23+center.day_22+center.day_21+center.day_20+center.day_19+center.day_18+center.day_17+center.day_16+center.day_15+center.day_14+center.day_13+center.day_12+center.day_11+center.day_10+center.day_09+center.day_08+center.day_07+center.day_06+center.day_05+center.day_04+center.day_03+center.day_02+center.day_01+center.day_00}" />
		                
		                <c:set var="sumReg_center_y" value="${sumReg_center_y + center.reg_y}" />
		                <c:set var="sumCls_center_m" value="${sumCls_center_m + center.cls_m}" />
		                <c:set var="sumCls_center_y" value="${sumCls_center_y + center.cls_y}" />
		                <c:set var="sumReg_center_mi" value="${sumReg_center_mi + center.reg_mi}" />
		            	<!-- 물보험 합산 계산 끝 -->
		            </c:forEach>
		            <!-- 조사소계 표시 시작 -->
		            <tr bgcolor="#E7ECF1">
		                <td class="border-right" colspan="2">물보험 센터 (조사)소계 (${sumMember_cnt_mid})</td>
		                <td class="border-right">
		                	<p>${sumReg_mid_sum}</p><p class="sub-p">${sumDay_mid_sum}</p>
		               	</td>
		               	<td class="border-right">
		               		<p><fmt:formatNumber value="${sumReg_mid_sum / sumMember_cnt_mid}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sumDay_mid_sum / sumMember_cnt_mid}" pattern="#.#"/></p>
		               	</td>
		               	<td class="border-right">
		               		<p><fmt:formatNumber value="${sumReg_mid_mi / sumMember_cnt_mid}" pattern="#.#"/></p>
		               	</td>
		               	<td><font color="">${sumReg_mid_mi}</font></td>
		               	<td>${sumReg_mid_y}</td>
		                <td>${sumCls_mid_m}</td>
		                <td class="border-right">${sumCls_mid_y}</td>
		                <td>
							<p>${sumReg_mid_29}</p><p class="sub-p">${sumDay_mid_29}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_28}</p><p class="sub-p">${sumDay_mid_28}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_27}</p><p class="sub-p">${sumDay_mid_27}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_26}</p><p class="sub-p">${sumDay_mid_26}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_25}</p><p class="sub-p">${sumDay_mid_25}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_24}</p><p class="sub-p">${sumDay_mid_24}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_23}</p><p class="sub-p">${sumDay_mid_23}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_22}</p><p class="sub-p">${sumDay_mid_22}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_21}</p><p class="sub-p">${sumDay_mid_21}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_20}</p><p class="sub-p">${sumDay_mid_20}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_19}</p><p class="sub-p">${sumDay_mid_19}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_18}</p><p class="sub-p">${sumDay_mid_18}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_17}</p><p class="sub-p">${sumDay_mid_17}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_16}</p><p class="sub-p">${sumDay_mid_16}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_15}</p><p class="sub-p">${sumDay_mid_15}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_14}</p><p class="sub-p">${sumDay_mid_14}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_13}</p><p class="sub-p">${sumDay_mid_13}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_12}</p><p class="sub-p">${sumDay_mid_12}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_11}</p><p class="sub-p">${sumDay_mid_11}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_10}</p><p class="sub-p">${sumDay_mid_10}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_09}</p><p class="sub-p">${sumDay_mid_09}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_08}</p><p class="sub-p">${sumDay_mid_08}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_07}</p><p class="sub-p">${sumDay_mid_07}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_06}</p><p class="sub-p">${sumDay_mid_06}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_05}</p><p class="sub-p">${sumDay_mid_05}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_04}</p><p class="sub-p">${sumDay_mid_04}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_03}</p><p class="sub-p">${sumDay_mid_03}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_02}</p><p class="sub-p">${sumDay_mid_02}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_01}</p><p class="sub-p">${sumDay_mid_01}</p>
		               	</td>
		                <td>
							<p>${sumReg_mid_00}</p><p class="sub-p">${sumDay_mid_00}</p>
		               	</td>                
		            </tr>
		            <!-- 조사소계 표시 끝 -->
		            
		            <!-- 물보험 심사 건수 시작 -->
	            	<c:forEach var="center" items="${TeamCenterListVO}" varStatus="status">            	
	            		<c:if test="${center.team_center eq 51 || center.team_center eq 52}">
	            		<tr>
		            			<td>${center.team_center_val} (${center.member_cnt})</td>
			                    <td class="border-right">
			                    	<p>수임</p><p class="sub-p">종결</p>
			                    </td>
			                    <td class="border-right">		                    	
			                    	<c:set var="sub1_regSum" value="${center.reg_29+center.reg_28+center.reg_27+center.reg_26+center.reg_25+center.reg_24+center.reg_23+center.reg_22+center.reg_21+center.reg_20+center.reg_19+center.reg_18+center.reg_17+center.reg_16+center.reg_15+center.reg_14+center.reg_13+center.reg_12+center.reg_11+center.reg_10+center.reg_09+center.reg_08+center.reg_07+center.reg_06+center.reg_05+center.reg_04+center.reg_03+center.reg_02+center.reg_01+center.reg_00}"/>
			                    	<c:set var="sub1_daySum" value="${center.day_29+center.day_28+center.day_27+center.day_26+center.day_25+center.day_24+center.day_23+center.day_22+center.day_21+center.day_20+center.day_19+center.day_18+center.day_17+center.day_16+center.day_15+center.day_14+center.day_13+center.day_12+center.day_11+center.day_10+center.day_09+center.day_08+center.day_07+center.day_06+center.day_05+center.day_04+center.day_03+center.day_02+center.day_01+center.day_00}"/>
			                    	<p>${sub1_regSum}</p><p class="sub-p">${sub1_daySum}</p>
			                  	</td>
			                  	<!-- 1인당 건수 시작 -->
			                  	<td class="border-right" bgcolor="#faebd7">
			                  		<c:choose>		                  			
			                  			<c:when test="${center.member_cnt eq 0}">
			                  				<p>0</p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:when test="${sub1_regSum eq 0 && sub1_daySum ne 0}">
			                  				<p>0</p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / center.member_cnt}" pattern="#.#"/></p>
			                  			</c:when>
			                  			<c:when test="${sub1_regSum ne 0 && sub1_daySum eq 0}">
			                  				<p><fmt:formatNumber value="${sub1_regSum / center.member_cnt}" pattern="#.#"/></p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:otherwise>
			                  				<p><fmt:formatNumber value="${sub1_regSum / center.member_cnt}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / center.member_cnt}" pattern="#.#"/></p>
			                  			</c:otherwise>
			                  		</c:choose>		                  		
			                  	</td>
			                  	<!-- 1인당 건수 끝 -->			                  	
			                    <!-- 1인당 미결 시작 -->
								<td class="border-right" bgcolor="#faebd7">
									<c:choose>		                  			
										<c:when test="${ center.member_cnt eq 0}">
											<p>0</p>
										</c:when>
										<c:when test="${ center.reg_mi eq 0 }">
											<p>0</p>
										</c:when>		                  			
										<c:otherwise>
											<p><fmt:formatNumber value="${center.reg_mi / center.member_cnt}" pattern="#.#"/></p>
										</c:otherwise>
									</c:choose>		                  		
								</td>
								<!-- 1인당 미결 끝 -->
								<td bgcolor="#faebd7">
			                    	<font color="">${center.reg_mi}</font>
			                    </td>
			                    <td bgcolor="#faebd7">
			                   		${center.reg_y}
			                 	</td>
			                    <td bgcolor="#faebd7">
			                    	${center.cls_m}
			                   	</td>
			                    <td class="border-right" bgcolor="#faebd7">
			                    	${center.cls_y}
			                	</td>		                    
			                    <td>
									<p>${center.reg_29}</p><p class="sub-p">${center.day_29}</p>
								</td>
								<td>
									<p>${center.reg_28}</p><p class="sub-p">${center.day_28}</p>
								</td>
								<td>
									<p>${center.reg_27}</p><p class="sub-p">${center.day_27}</p>
								</td>
								<td>
									<p>${center.reg_26}</p><p class="sub-p">${center.day_26}</p>
								</td>
								<td>
									<p>${center.reg_25}</p><p class="sub-p">${center.day_25}</p>
								</td>
								<td>
									<p>${center.reg_24}</p><p class="sub-p">${center.day_24}</p>
								</td>
								<td>
									<p>${center.reg_23}</p><p class="sub-p">${center.day_23}</p>
								</td>
								<td>
									<p>${center.reg_22}</p><p class="sub-p">${center.day_22}</p>
								</td>
								<td>
									<p>${center.reg_21}</p><p class="sub-p">${center.day_21}</p>
								</td>
								<td>
									<p>${center.reg_20}</p><p class="sub-p">${center.day_20}</p>
								</td>
								<td>
									<p>${center.reg_19}</p><p class="sub-p">${center.day_19}</p>
								</td>
								<td>
									<p>${center.reg_18}</p><p class="sub-p">${center.day_18}</p>
								</td>
								<td>
									<p>${center.reg_17}</p><p class="sub-p">${center.day_17}</p>
								</td>
								<td>
									<p>${center.reg_16}</p><p class="sub-p">${center.day_16}</p>
								</td>
								<td>
									<p>${center.reg_15}</p><p class="sub-p">${center.day_15}</p>
								</td>
								<td>
									<p>${center.reg_14}</p><p class="sub-p">${center.day_14}</p>
								</td>
								<td>
									<p>${center.reg_13}</p><p class="sub-p">${center.day_13}</p>
								</td>
								<td>
									<p>${center.reg_12}</p><p class="sub-p">${center.day_12}</p>
								</td>
								<td>
									<p>${center.reg_11}</p><p class="sub-p">${center.day_11}</p>
								</td>
								<td>
									<p>${center.reg_10}</p><p class="sub-p">${center.day_10}</p>
								</td>
								<td>
									<p>${center.reg_09}</p><p class="sub-p">${center.day_09}</p>
								</td>
								<td>
									<p>${center.reg_08}</p><p class="sub-p">${center.day_08}</p>
								</td>
								<td>
									<p>${center.reg_07}</p><p class="sub-p">${center.day_07}</p>
								</td>
								<td>
									<p>${center.reg_06}</p><p class="sub-p">${center.day_06}</p>
								</td>
								<td>
									<p>${center.reg_05}</p><p class="sub-p">${center.day_05}</p>
								</td>
								<td>
									<p>${center.reg_04}</p><p class="sub-p">${center.day_04}</p>
								</td>
								<td>
									<p>${center.reg_03}</p><p class="sub-p">${center.day_03}</p>
								</td>
								<td>
									<p>${center.reg_02}</p><p class="sub-p">${center.day_02}</p>
								</td>
								<td>
									<p>${center.reg_01}</p><p class="sub-p">${center.day_01}</p>
								</td>
								<td>
									<p>${center.reg_00}</p><p class="sub-p">${center.day_00}</p>
								</td>	                    
		            		</tr>
		                <!-- 물보험 심사 소계계산 시작 -->
		                	<c:set var="sumMember_cnt_etc" value="${sumMember_cnt_etc + center.member_cnt}" />
			                <c:set var="sumReg_etc_29" value="${sumReg_etc_29 + center.reg_29}" />
							<c:set var="sumReg_etc_28" value="${sumReg_etc_28 + center.reg_28}" />
							<c:set var="sumReg_etc_27" value="${sumReg_etc_27 + center.reg_27}" />
							<c:set var="sumReg_etc_26" value="${sumReg_etc_26 + center.reg_26}" />
							<c:set var="sumReg_etc_25" value="${sumReg_etc_25 + center.reg_25}" />
							<c:set var="sumReg_etc_24" value="${sumReg_etc_24 + center.reg_24}" />
							<c:set var="sumReg_etc_23" value="${sumReg_etc_23 + center.reg_23}" />
							<c:set var="sumReg_etc_22" value="${sumReg_etc_22 + center.reg_22}" />
							<c:set var="sumReg_etc_21" value="${sumReg_etc_21 + center.reg_21}" />
							<c:set var="sumReg_etc_20" value="${sumReg_etc_20 + center.reg_20}" />
							<c:set var="sumReg_etc_19" value="${sumReg_etc_19 + center.reg_19}" />
							<c:set var="sumReg_etc_18" value="${sumReg_etc_18 + center.reg_18}" />
							<c:set var="sumReg_etc_17" value="${sumReg_etc_17 + center.reg_17}" />
							<c:set var="sumReg_etc_16" value="${sumReg_etc_16 + center.reg_16}" />
							<c:set var="sumReg_etc_15" value="${sumReg_etc_15 + center.reg_15}" />
							<c:set var="sumReg_etc_14" value="${sumReg_etc_14 + center.reg_14}" />
							<c:set var="sumReg_etc_13" value="${sumReg_etc_13 + center.reg_13}" />
							<c:set var="sumReg_etc_12" value="${sumReg_etc_12 + center.reg_12}" />
							<c:set var="sumReg_etc_11" value="${sumReg_etc_11 + center.reg_11}" />
							<c:set var="sumReg_etc_10" value="${sumReg_etc_10 + center.reg_10}" />
							<c:set var="sumReg_etc_09" value="${sumReg_etc_09 + center.reg_09}" />
							<c:set var="sumReg_etc_08" value="${sumReg_etc_08 + center.reg_08}" />
							<c:set var="sumReg_etc_07" value="${sumReg_etc_07 + center.reg_07}" />
							<c:set var="sumReg_etc_06" value="${sumReg_etc_06 + center.reg_06}" />
							<c:set var="sumReg_etc_05" value="${sumReg_etc_05 + center.reg_05}" />
							<c:set var="sumReg_etc_04" value="${sumReg_etc_04 + center.reg_04}" />
							<c:set var="sumReg_etc_03" value="${sumReg_etc_03 + center.reg_03}" />
							<c:set var="sumReg_etc_02" value="${sumReg_etc_02 + center.reg_02}" />
							<c:set var="sumReg_etc_01" value="${sumReg_etc_01 + center.reg_01}" />
							<c:set var="sumReg_etc_00" value="${sumReg_etc_00 + center.reg_00}" />
							<c:set var="sumReg_etc_sum" value="${sumReg_etc_sum + sub1_regSum}" />		                
										
							<c:set var="sumDay_etc_29" value="${sumDay_etc_29 + center.day_29}" />
							<c:set var="sumDay_etc_28" value="${sumDay_etc_28 + center.day_28}" />
							<c:set var="sumDay_etc_27" value="${sumDay_etc_27 + center.day_27}" />
							<c:set var="sumDay_etc_26" value="${sumDay_etc_26 + center.day_26}" />
							<c:set var="sumDay_etc_25" value="${sumDay_etc_25 + center.day_25}" />
							<c:set var="sumDay_etc_24" value="${sumDay_etc_24 + center.day_24}" />
							<c:set var="sumDay_etc_23" value="${sumDay_etc_23 + center.day_23}" />
							<c:set var="sumDay_etc_22" value="${sumDay_etc_22 + center.day_22}" />
							<c:set var="sumDay_etc_21" value="${sumDay_etc_21 + center.day_21}" />
							<c:set var="sumDay_etc_20" value="${sumDay_etc_20 + center.day_20}" />
							<c:set var="sumDay_etc_19" value="${sumDay_etc_19 + center.day_19}" />
							<c:set var="sumDay_etc_18" value="${sumDay_etc_18 + center.day_18}" />
							<c:set var="sumDay_etc_17" value="${sumDay_etc_17 + center.day_17}" />
							<c:set var="sumDay_etc_16" value="${sumDay_etc_16 + center.day_16}" />
							<c:set var="sumDay_etc_15" value="${sumDay_etc_15 + center.day_15}" />
							<c:set var="sumDay_etc_14" value="${sumDay_etc_14 + center.day_14}" />
							<c:set var="sumDay_etc_13" value="${sumDay_etc_13 + center.day_13}" />
							<c:set var="sumDay_etc_12" value="${sumDay_etc_12 + center.day_12}" />
							<c:set var="sumDay_etc_11" value="${sumDay_etc_11 + center.day_11}" />
							<c:set var="sumDay_etc_10" value="${sumDay_etc_10 + center.day_10}" />
							<c:set var="sumDay_etc_09" value="${sumDay_etc_09 + center.day_09}" />
							<c:set var="sumDay_etc_08" value="${sumDay_etc_08 + center.day_08}" />
							<c:set var="sumDay_etc_07" value="${sumDay_etc_07 + center.day_07}" />
							<c:set var="sumDay_etc_06" value="${sumDay_etc_06 + center.day_06}" />
							<c:set var="sumDay_etc_05" value="${sumDay_etc_05 + center.day_05}" />
							<c:set var="sumDay_etc_04" value="${sumDay_etc_04 + center.day_04}" />
							<c:set var="sumDay_etc_03" value="${sumDay_etc_03 + center.day_03}" />
							<c:set var="sumDay_etc_02" value="${sumDay_etc_02 + center.day_02}" />
							<c:set var="sumDay_etc_01" value="${sumDay_etc_01 + center.day_01}" />
							<c:set var="sumDay_etc_00" value="${sumDay_etc_00 + center.day_00}" />                
							<c:set var="sumDay_etc_sum" value="${sumDay_etc_sum + sub1_daySum}" />
							
							<c:set var="sumReg_etc_y" value="${sumReg_etc_y + center.reg_y}" />
							<c:set var="sumCls_etc_m" value="${sumCls_etc_m + center.cls_m}" />
							<c:set var="sumCls_etc_y" value="${sumCls_etc_y + center.cls_y}" />
							<c:set var="sumReg_etc_mi" value="${sumReg_etc_mi + center.reg_mi}" />	 
		                 <!-- 물보험 심사 소계계산 끝 -->	                 
	                    </c:if>
	            	</c:forEach>
	            	<!-- 물보험 심사 소계 표시 시작 -->
	            	<tr bgcolor="#E7ECF1">
		                    <td class="border-right" colspan="2">물보험심사센터 소계 (${sumMember_cnt_etc})</td>
		                    <td class="border-right">		                    	
		                    	<c:set var="sub1_regSum" value="${sumReg_etc_29+sumReg_etc_28+sumReg_etc_27+sumReg_etc_26+sumReg_etc_25+sumReg_etc_24+sumReg_etc_23+sumReg_etc_22+sumReg_etc_21+sumReg_etc_20+sumReg_etc_19+sumReg_etc_18+sumReg_etc_17+sumReg_etc_16+sumReg_etc_15+sumReg_etc_14+sumReg_etc_13+sumReg_etc_12+sumReg_etc_11+sumReg_etc_10+sumReg_etc_09+sumReg_etc_08+sumReg_etc_07+sumReg_etc_06+sumReg_etc_05+sumReg_etc_04+sumReg_etc_03+sumReg_etc_02+sumReg_etc_01+sumReg_etc_00}"/>
		                    	<c:set var="sub1_daySum" value="${sumDay_etc_29+sumDay_etc_28+sumDay_etc_27+sumDay_etc_26+sumDay_etc_25+sumDay_etc_24+sumDay_etc_23+sumDay_etc_22+sumDay_etc_21+sumDay_etc_20+sumDay_etc_19+sumDay_etc_18+sumDay_etc_17+sumDay_etc_16+sumDay_etc_15+sumDay_etc_14+sumDay_etc_13+sumDay_etc_12+sumDay_etc_11+sumDay_etc_10+sumDay_etc_09+sumDay_etc_08+sumDay_etc_07+sumDay_etc_06+sumDay_etc_05+sumDay_etc_04+sumDay_etc_03+sumDay_etc_02+sumDay_etc_01+sumDay_etc_00}"/>
		                    	<p>${sub1_regSum}</p><p class="sub-p">${sub1_daySum}</p>
		                  	</td>
		                  	<td class="border-right">
			               		<p><fmt:formatNumber value="${sub1_regSum / sumMember_cnt_etc}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / sumMember_cnt_etc}" pattern="#.#"/></p>
			               	</td>			               	
		                    <td class="border-right">
			               		<p><fmt:formatNumber value="${sumReg_etc_mi / sumMember_cnt_etc}" pattern="#.#"/></p>
			               	</td>		                  			            		
			               	<td>
		                    	<font color="">${sumReg_etc_mi}</font>
		                    </td>
		                    <td>
		                   		${sumReg_etc_y}
		                 	</td>
		                    <td>
		                    	${sumCls_etc_m}
		                   	</td>
		                    <td class="border-right">
		                    	${sumCls_etc_y}
		                	</td>
		                    <td>
								<p>${sumReg_etc_29}</p><p class="sub-p">${sumDay_etc_29}</p>
							</td>
							<td>
								<p>${sumReg_etc_28}</p><p class="sub-p">${sumDay_etc_28}</p>
							</td>
							<td>
								<p>${sumReg_etc_27}</p><p class="sub-p">${sumDay_etc_27}</p>
							</td>
							<td>
								<p>${sumReg_etc_26}</p><p class="sub-p">${sumDay_etc_26}</p>
							</td>
							<td>
								<p>${sumReg_etc_25}</p><p class="sub-p">${sumDay_etc_25}</p>
							</td>
							<td>
								<p>${sumReg_etc_24}</p><p class="sub-p">${sumDay_etc_24}</p>
							</td>
							<td>
								<p>${sumReg_etc_23}</p><p class="sub-p">${sumDay_etc_23}</p>
							</td>
							<td>
								<p>${sumReg_etc_22}</p><p class="sub-p">${sumDay_etc_22}</p>
							</td>
							<td>
								<p>${sumReg_etc_21}</p><p class="sub-p">${sumDay_etc_21}</p>
							</td>
							<td>
								<p>${sumReg_etc_20}</p><p class="sub-p">${sumDay_etc_20}</p>
							</td>
							<td>
								<p>${sumReg_etc_19}</p><p class="sub-p">${sumDay_etc_19}</p>
							</td>
							<td>
								<p>${sumReg_etc_18}</p><p class="sub-p">${sumDay_etc_18}</p>
							</td>
							<td>
								<p>${sumReg_etc_17}</p><p class="sub-p">${sumDay_etc_17}</p>
							</td>
							<td>
								<p>${sumReg_etc_16}</p><p class="sub-p">${sumDay_etc_16}</p>
							</td>
							<td>
								<p>${sumReg_etc_15}</p><p class="sub-p">${sumDay_etc_15}</p>
							</td>
							<td>
								<p>${sumReg_etc_14}</p><p class="sub-p">${sumDay_etc_14}</p>
							</td>
							<td>
								<p>${sumReg_etc_13}</p><p class="sub-p">${sumDay_etc_13}</p>
							</td>
							<td>
								<p>${sumReg_etc_12}</p><p class="sub-p">${sumDay_etc_12}</p>
							</td>
							<td>
								<p>${sumReg_etc_11}</p><p class="sub-p">${sumDay_etc_11}</p>
							</td>
							<td>
								<p>${sumReg_etc_10}</p><p class="sub-p">${sumDay_etc_10}</p>
							</td>
							<td>
								<p>${sumReg_etc_09}</p><p class="sub-p">${sumDay_etc_09}</p>
							</td>
							<td>
								<p>${sumReg_etc_08}</p><p class="sub-p">${sumDay_etc_08}</p>
							</td>
							<td>
								<p>${sumReg_etc_07}</p><p class="sub-p">${sumDay_etc_07}</p>
							</td>
							<td>
								<p>${sumReg_etc_06}</p><p class="sub-p">${sumDay_etc_06}</p>
							</td>
							<td>
								<p>${sumReg_etc_05}</p><p class="sub-p">${sumDay_etc_05}</p>
							</td>
							<td>
								<p>${sumReg_etc_04}</p><p class="sub-p">${sumDay_etc_04}</p>
							</td>
							<td>
								<p>${sumReg_etc_03}</p><p class="sub-p">${sumDay_etc_03}</p>
							</td>
							<td>
								<p>${sumReg_etc_02}</p><p class="sub-p">${sumDay_etc_02}</p>
							</td>
							<td>
								<p>${sumReg_etc_01}</p><p class="sub-p">${sumDay_etc_01}</p>
							</td>
							<td>
								<p>${sumReg_etc_00}</p><p class="sub-p">${sumDay_etc_00}</p>
							</td>		                    		                    
	                    </tr>
	            	<!-- 물보험 심사 소계 표시 끝 -->
	            	
	            	<!-- 물보험 심사 건수 끝 -->
		            
		            <!-- 서면심사 시작 -->
		            <c:forEach var="center" items="${TeamCenterListVO}" varStatus="status">		            	
            			<c:if test="${center.wc_center_flag eq 1 && center.team_center ne 999}">
	            			<tr>
	            				<td>${center.team_center_val}(서면심사)</td>
	            				<td class="border-right">
			                    	<p>수임</p><p class="sub-p">종결</p>
			                    </td>
			                    <td class="border-right">		                    	
			                    	<c:set var="sub1_wc_regSum" value="${center.reg_wc_29+center.reg_wc_28+center.reg_wc_27+center.reg_wc_26+center.reg_wc_25+center.reg_wc_24+center.reg_wc_23+center.reg_wc_22+center.reg_wc_21+center.reg_wc_20+center.reg_wc_19+center.reg_wc_18+center.reg_wc_17+center.reg_wc_16+center.reg_wc_15+center.reg_wc_14+center.reg_wc_13+center.reg_wc_12+center.reg_wc_11+center.reg_wc_10+center.reg_wc_09+center.reg_wc_08+center.reg_wc_07+center.reg_wc_06+center.reg_wc_05+center.reg_wc_04+center.reg_wc_03+center.reg_wc_02+center.reg_wc_01+center.reg_wc_00}"/>
			                    	<c:set var="sub1_wc_daySum" value="${center.day_wc_29+center.day_wc_28+center.day_wc_27+center.day_wc_26+center.day_wc_25+center.day_wc_24+center.day_wc_23+center.day_wc_22+center.day_wc_21+center.day_wc_20+center.day_wc_19+center.day_wc_18+center.day_wc_17+center.day_wc_16+center.day_wc_15+center.day_wc_14+center.day_wc_13+center.day_wc_12+center.day_wc_11+center.day_wc_10+center.day_wc_09+center.day_wc_08+center.day_wc_07+center.day_wc_06+center.day_wc_05+center.day_wc_04+center.day_wc_03+center.day_wc_02+center.day_wc_01+center.day_wc_00}"/>
			                    	<p>${sub1_wc_regSum}</p><p class="sub-p">${sub1_wc_daySum}</p>
			                  	</td>
			                  	<td class="border-right" bgcolor="#faebd7">
									<p>-</p><p class="sub-p">-</p>
								</td>								
			                    <td class="border-right" bgcolor="#faebd7">
									<p>-</p>
								</td>
								<td bgcolor="#faebd7">
			                    	<font color="">${center.reg_wc_mi}</font>
			                    </td>
			                    <td bgcolor="#faebd7">
			                   		${center.reg_wc_y}
			                 	</td>
			                    <td bgcolor="#faebd7">
			                    	${center.cls_wc_m}
			                   	</td>
			                    <td class="border-right" bgcolor="#faebd7">
			                    	${center.cls_wc_y}
			                	</td>
	            				<td>
									<p>${center.reg_wc_29}</p><p class="sub-p">${center.day_wc_29}</p>
								</td>
								<td>
									<p>${center.reg_wc_28}</p><p class="sub-p">${center.day_wc_28}</p>
								</td>
								<td>
									<p>${center.reg_wc_27}</p><p class="sub-p">${center.day_wc_27}</p>
								</td>
								<td>
									<p>${center.reg_wc_26}</p><p class="sub-p">${center.day_wc_26}</p>
								</td>
								<td>
									<p>${center.reg_wc_25}</p><p class="sub-p">${center.day_wc_25}</p>
								</td>
								<td>
									<p>${center.reg_wc_24}</p><p class="sub-p">${center.day_wc_24}</p>
								</td>
								<td>
									<p>${center.reg_wc_23}</p><p class="sub-p">${center.day_wc_23}</p>
								</td>
								<td>
									<p>${center.reg_wc_22}</p><p class="sub-p">${center.day_wc_22}</p>
								</td>
								<td>
									<p>${center.reg_wc_21}</p><p class="sub-p">${center.day_wc_21}</p>
								</td>
								<td>
									<p>${center.reg_wc_20}</p><p class="sub-p">${center.day_wc_20}</p>
								</td>
								<td>
									<p>${center.reg_wc_19}</p><p class="sub-p">${center.day_wc_19}</p>
								</td>
								<td>
									<p>${center.reg_wc_18}</p><p class="sub-p">${center.day_wc_18}</p>
								</td>
								<td>
									<p>${center.reg_wc_17}</p><p class="sub-p">${center.day_wc_17}</p>
								</td>
								<td>
									<p>${center.reg_wc_16}</p><p class="sub-p">${center.day_wc_16}</p>
								</td>
								<td>
									<p>${center.reg_wc_15}</p><p class="sub-p">${center.day_wc_15}</p>
								</td>
								<td>
									<p>${center.reg_wc_14}</p><p class="sub-p">${center.day_wc_14}</p>
								</td>
								<td>
									<p>${center.reg_wc_13}</p><p class="sub-p">${center.day_wc_13}</p>
								</td>
								<td>
									<p>${center.reg_wc_12}</p><p class="sub-p">${center.day_wc_12}</p>
								</td>
								<td>
									<p>${center.reg_wc_11}</p><p class="sub-p">${center.day_wc_11}</p>
								</td>
								<td>
									<p>${center.reg_wc_10}</p><p class="sub-p">${center.day_wc_10}</p>
								</td>
								<td>
									<p>${center.reg_wc_09}</p><p class="sub-p">${center.day_wc_09}</p>
								</td>
								<td>
									<p>${center.reg_wc_08}</p><p class="sub-p">${center.day_wc_08}</p>
								</td>
								<td>
									<p>${center.reg_wc_07}</p><p class="sub-p">${center.day_wc_07}</p>
								</td>
								<td>
									<p>${center.reg_wc_06}</p><p class="sub-p">${center.day_wc_06}</p>
								</td>
								<td>
									<p>${center.reg_wc_05}</p><p class="sub-p">${center.day_wc_05}</p>
								</td>
								<td>
									<p>${center.reg_wc_04}</p><p class="sub-p">${center.day_wc_04}</p>
								</td>
								<td>
									<p>${center.reg_wc_03}</p><p class="sub-p">${center.day_wc_03}</p>
								</td>
								<td>
									<p>${center.reg_wc_02}</p><p class="sub-p">${center.day_wc_02}</p>
								</td>
								<td>
									<p>${center.reg_wc_01}</p><p class="sub-p">${center.day_wc_01}</p>
								</td>
								<td>
									<p>${center.reg_wc_00}</p><p class="sub-p">${center.day_wc_00}</p>
								</td>			                    			                    
	            			</tr>
	            			<!-- 센터심사 소계 계산 시작 -->
		            		<c:set var="sumReg_wc_29" value="${sumReg_wc_29 + center.reg_wc_29}" />
							<c:set var="sumReg_wc_28" value="${sumReg_wc_28 + center.reg_wc_28}" />
							<c:set var="sumReg_wc_27" value="${sumReg_wc_27 + center.reg_wc_27}" />
							<c:set var="sumReg_wc_26" value="${sumReg_wc_26 + center.reg_wc_26}" />
							<c:set var="sumReg_wc_25" value="${sumReg_wc_25 + center.reg_wc_25}" />
							<c:set var="sumReg_wc_24" value="${sumReg_wc_24 + center.reg_wc_24}" />
							<c:set var="sumReg_wc_23" value="${sumReg_wc_23 + center.reg_wc_23}" />
							<c:set var="sumReg_wc_22" value="${sumReg_wc_22 + center.reg_wc_22}" />
							<c:set var="sumReg_wc_21" value="${sumReg_wc_21 + center.reg_wc_21}" />
							<c:set var="sumReg_wc_20" value="${sumReg_wc_20 + center.reg_wc_20}" />
							<c:set var="sumReg_wc_19" value="${sumReg_wc_19 + center.reg_wc_19}" />
							<c:set var="sumReg_wc_18" value="${sumReg_wc_18 + center.reg_wc_18}" />
							<c:set var="sumReg_wc_17" value="${sumReg_wc_17 + center.reg_wc_17}" />
							<c:set var="sumReg_wc_16" value="${sumReg_wc_16 + center.reg_wc_16}" />
							<c:set var="sumReg_wc_15" value="${sumReg_wc_15 + center.reg_wc_15}" />
							<c:set var="sumReg_wc_14" value="${sumReg_wc_14 + center.reg_wc_14}" />
							<c:set var="sumReg_wc_13" value="${sumReg_wc_13 + center.reg_wc_13}" />
							<c:set var="sumReg_wc_12" value="${sumReg_wc_12 + center.reg_wc_12}" />
							<c:set var="sumReg_wc_11" value="${sumReg_wc_11 + center.reg_wc_11}" />
							<c:set var="sumReg_wc_10" value="${sumReg_wc_10 + center.reg_wc_10}" />
							<c:set var="sumReg_wc_09" value="${sumReg_wc_09 + center.reg_wc_09}" />
							<c:set var="sumReg_wc_08" value="${sumReg_wc_08 + center.reg_wc_08}" />
							<c:set var="sumReg_wc_07" value="${sumReg_wc_07 + center.reg_wc_07}" />
							<c:set var="sumReg_wc_06" value="${sumReg_wc_06 + center.reg_wc_06}" />
							<c:set var="sumReg_wc_05" value="${sumReg_wc_05 + center.reg_wc_05}" />
							<c:set var="sumReg_wc_04" value="${sumReg_wc_04 + center.reg_wc_04}" />
							<c:set var="sumReg_wc_03" value="${sumReg_wc_03 + center.reg_wc_03}" />
							<c:set var="sumReg_wc_02" value="${sumReg_wc_02 + center.reg_wc_02}" />
							<c:set var="sumReg_wc_01" value="${sumReg_wc_01 + center.reg_wc_01}" />
							<c:set var="sumReg_wc_00" value="${sumReg_wc_00 + center.reg_wc_00}" />
							<c:set var="sumReg_wc_sum" value="${sumReg_wc_sum + sub1_wc_regSum}" />		                
										
							<c:set var="sumDay_wc_29" value="${sumDay_wc_29 + center.day_wc_29}" />
							<c:set var="sumDay_wc_28" value="${sumDay_wc_28 + center.day_wc_28}" />
							<c:set var="sumDay_wc_27" value="${sumDay_wc_27 + center.day_wc_27}" />
							<c:set var="sumDay_wc_26" value="${sumDay_wc_26 + center.day_wc_26}" />
							<c:set var="sumDay_wc_25" value="${sumDay_wc_25 + center.day_wc_25}" />
							<c:set var="sumDay_wc_24" value="${sumDay_wc_24 + center.day_wc_24}" />
							<c:set var="sumDay_wc_23" value="${sumDay_wc_23 + center.day_wc_23}" />
							<c:set var="sumDay_wc_22" value="${sumDay_wc_22 + center.day_wc_22}" />
							<c:set var="sumDay_wc_21" value="${sumDay_wc_21 + center.day_wc_21}" />
							<c:set var="sumDay_wc_20" value="${sumDay_wc_20 + center.day_wc_20}" />
							<c:set var="sumDay_wc_19" value="${sumDay_wc_19 + center.day_wc_19}" />
							<c:set var="sumDay_wc_18" value="${sumDay_wc_18 + center.day_wc_18}" />
							<c:set var="sumDay_wc_17" value="${sumDay_wc_17 + center.day_wc_17}" />
							<c:set var="sumDay_wc_16" value="${sumDay_wc_16 + center.day_wc_16}" />
							<c:set var="sumDay_wc_15" value="${sumDay_wc_15 + center.day_wc_15}" />
							<c:set var="sumDay_wc_14" value="${sumDay_wc_14 + center.day_wc_14}" />
							<c:set var="sumDay_wc_13" value="${sumDay_wc_13 + center.day_wc_13}" />
							<c:set var="sumDay_wc_12" value="${sumDay_wc_12 + center.day_wc_12}" />
							<c:set var="sumDay_wc_11" value="${sumDay_wc_11 + center.day_wc_11}" />
							<c:set var="sumDay_wc_10" value="${sumDay_wc_10 + center.day_wc_10}" />
							<c:set var="sumDay_wc_09" value="${sumDay_wc_09 + center.day_wc_09}" />
							<c:set var="sumDay_wc_08" value="${sumDay_wc_08 + center.day_wc_08}" />
							<c:set var="sumDay_wc_07" value="${sumDay_wc_07 + center.day_wc_07}" />
							<c:set var="sumDay_wc_06" value="${sumDay_wc_06 + center.day_wc_06}" />
							<c:set var="sumDay_wc_05" value="${sumDay_wc_05 + center.day_wc_05}" />
							<c:set var="sumDay_wc_04" value="${sumDay_wc_04 + center.day_wc_04}" />
							<c:set var="sumDay_wc_03" value="${sumDay_wc_03 + center.day_wc_03}" />
							<c:set var="sumDay_wc_02" value="${sumDay_wc_02 + center.day_wc_02}" />
							<c:set var="sumDay_wc_01" value="${sumDay_wc_01 + center.day_wc_01}" />
							<c:set var="sumDay_wc_00" value="${sumDay_wc_00 + center.day_wc_00}" />                
							<c:set var="sumDay_wc_sum" value="${sumDay_wc_sum + sub1_wc_daySum}" />
							
							<c:set var="sumReg_wc_y" value="${sumReg_wc_y + center.reg_wc_y}" />
							<c:set var="sumCls_wc_m" value="${sumCls_wc_m + center.cls_wc_m}" />
							<c:set var="sumCls_wc_y" value="${sumCls_wc_y + center.cls_wc_y}" />
							<c:set var="sumReg_wc_mi" value="${sumReg_wc_mi + center.reg_wc_mi}" />	            		
		            		<!-- 센터심사 소계 계산 끝 -->
            			</c:if>
            		</c:forEach>
            		<!-- 서면심사 소계표시 시작 -->
            		<tr bgcolor="#E7ECF1">
		                <td class="border-right" colspan="2">물보험 센터 (서면심사)소계</td>
		                <td class="border-right">
		                	<p>${sumReg_wc_sum}</p><p class="sub-p">${sumDay_wc_sum}</p>
		               	</td>
		               	<td class="border-right">
							<p>-</p><p class="sub-p">-</p>
						</td>						
						<td class="border-right">
							<p>-</p><p class="sub-p">-</p>
						</td>
						<td><font color="">${sumReg_wc_mi}</font></td>
						<td>${sumReg_wc_y}</td>
		                <td>${sumCls_wc_m}</td>
		                <td class="border-right">${sumCls_wc_y}</td>
		                <td>
							<p>${sumReg_wc_29}</p><p class="sub-p">${sumDay_wc_29}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_28}</p><p class="sub-p">${sumDay_wc_28}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_27}</p><p class="sub-p">${sumDay_wc_27}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_26}</p><p class="sub-p">${sumDay_wc_26}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_25}</p><p class="sub-p">${sumDay_wc_25}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_24}</p><p class="sub-p">${sumDay_wc_24}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_23}</p><p class="sub-p">${sumDay_wc_23}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_22}</p><p class="sub-p">${sumDay_wc_22}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_21}</p><p class="sub-p">${sumDay_wc_21}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_20}</p><p class="sub-p">${sumDay_wc_20}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_19}</p><p class="sub-p">${sumDay_wc_19}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_18}</p><p class="sub-p">${sumDay_wc_18}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_17}</p><p class="sub-p">${sumDay_wc_17}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_16}</p><p class="sub-p">${sumDay_wc_16}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_15}</p><p class="sub-p">${sumDay_wc_15}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_14}</p><p class="sub-p">${sumDay_wc_14}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_13}</p><p class="sub-p">${sumDay_wc_13}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_12}</p><p class="sub-p">${sumDay_wc_12}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_11}</p><p class="sub-p">${sumDay_wc_11}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_10}</p><p class="sub-p">${sumDay_wc_10}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_09}</p><p class="sub-p">${sumDay_wc_09}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_08}</p><p class="sub-p">${sumDay_wc_08}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_07}</p><p class="sub-p">${sumDay_wc_07}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_06}</p><p class="sub-p">${sumDay_wc_06}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_05}</p><p class="sub-p">${sumDay_wc_05}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_04}</p><p class="sub-p">${sumDay_wc_04}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_03}</p><p class="sub-p">${sumDay_wc_03}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_02}</p><p class="sub-p">${sumDay_wc_02}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_01}</p><p class="sub-p">${sumDay_wc_01}</p>
		               	</td>
		                <td>
							<p>${sumReg_wc_00}</p><p class="sub-p">${sumDay_wc_00}</p>
		               	</td>            
		            </tr>
            		<!-- 서면심사 소계표시 끝 -->            		
		            <!-- 서면심사 끝 -->
		            
		            <!-- 기타 시작 -->
		            <c:forEach var="center" items="${TeamCenterListVO}" varStatus="status">            	
	            		<c:if test="${center.team_center eq 999}">
		            		<tr>
		            			<td>${center.team_center_val} (${center.member_cnt})</td>
			                    <td class="border-right">
			                    	<p>수임</p><p class="sub-p">종결</p>
			                    </td>
			                    <td class="border-right">		                    	
			                    	<c:set var="sub1_regSum" value="${center.reg_29+center.reg_28+center.reg_27+center.reg_26+center.reg_25+center.reg_24+center.reg_23+center.reg_22+center.reg_21+center.reg_20+center.reg_19+center.reg_18+center.reg_17+center.reg_16+center.reg_15+center.reg_14+center.reg_13+center.reg_12+center.reg_11+center.reg_10+center.reg_09+center.reg_08+center.reg_07+center.reg_06+center.reg_05+center.reg_04+center.reg_03+center.reg_02+center.reg_01+center.reg_00}"/>
			                    	<c:set var="sub1_daySum" value="${center.day_29+center.day_28+center.day_27+center.day_26+center.day_25+center.day_24+center.day_23+center.day_22+center.day_21+center.day_20+center.day_19+center.day_18+center.day_17+center.day_16+center.day_15+center.day_14+center.day_13+center.day_12+center.day_11+center.day_10+center.day_09+center.day_08+center.day_07+center.day_06+center.day_05+center.day_04+center.day_03+center.day_02+center.day_01+center.day_00}"/>
			                    	<p>${sub1_regSum}</p><p class="sub-p">${sub1_daySum}</p>
			                  	</td>
			                  	<!-- 1인당 건수 시작 -->
			                  	<td class="border-right" bgcolor="#faebd7">
			                  		<c:choose>		                  			
			                  			<c:when test="${ center.member_cnt eq 0}">
			                  				<p>0</p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:when test="${ sub1_regSum eq 0 && sub1_daySum ne 0}">
			                  				<p>0</p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / center.member_cnt}" pattern="#.#"/></p>
			                  			</c:when>
			                  			<c:when test="${ sub1_regSum ne 0 && sub1_daySum eq 0}">
			                  				<p><fmt:formatNumber value="${sub1_regSum / center.member_cnt}" pattern="#.#"/></p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:otherwise>
			                  				<p><fmt:formatNumber value="${sub1_regSum / center.member_cnt}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / center.member_cnt}" pattern="#.#"/></p>
			                  			</c:otherwise>
			                  		</c:choose>		                  		
			                  	</td>
			                  	<!-- 1인당 건수 끝 -->			                  	
			                    <!-- 1인당 미결 시작 -->
								<td class="border-right" bgcolor="#faebd7">
									<c:choose>		                  			
										<c:when test="${ center.member_cnt eq 0}">
											<p>0</p>
										</c:when>
										<c:when test="${ center.reg_mi eq 0 }">
											<p>0</p>
										</c:when>		                  			
										<c:otherwise>
											<p><fmt:formatNumber value="${center.reg_mi / center.member_cnt}" pattern="#.#"/></p>
										</c:otherwise>
									</c:choose>		                  		
								</td>
								<!-- 1인당 미결 끝 -->
								<td bgcolor="#faebd7">
			                    	<font color="">${center.reg_mi}</font>
			                    </td>
			                    <td bgcolor="#faebd7">
			                   		${center.reg_y}
			                 	</td>
			                    <td bgcolor="#faebd7">
			                    	${center.cls_m}
			                   	</td>
			                    <td class="border-right" bgcolor="#faebd7">
			                    	${center.cls_y}
			                	</td>
			                    <td>
									<p>${center.reg_29}</p><p class="sub-p">${center.day_29}</p>
								</td>
								<td>
									<p>${center.reg_28}</p><p class="sub-p">${center.day_28}</p>
								</td>
								<td>
									<p>${center.reg_27}</p><p class="sub-p">${center.day_27}</p>
								</td>
								<td>
									<p>${center.reg_26}</p><p class="sub-p">${center.day_26}</p>
								</td>
								<td>
									<p>${center.reg_25}</p><p class="sub-p">${center.day_25}</p>
								</td>
								<td>
									<p>${center.reg_24}</p><p class="sub-p">${center.day_24}</p>
								</td>
								<td>
									<p>${center.reg_23}</p><p class="sub-p">${center.day_23}</p>
								</td>
								<td>
									<p>${center.reg_22}</p><p class="sub-p">${center.day_22}</p>
								</td>
								<td>
									<p>${center.reg_21}</p><p class="sub-p">${center.day_21}</p>
								</td>
								<td>
									<p>${center.reg_20}</p><p class="sub-p">${center.day_20}</p>
								</td>
								<td>
									<p>${center.reg_19}</p><p class="sub-p">${center.day_19}</p>
								</td>
								<td>
									<p>${center.reg_18}</p><p class="sub-p">${center.day_18}</p>
								</td>
								<td>
									<p>${center.reg_17}</p><p class="sub-p">${center.day_17}</p>
								</td>
								<td>
									<p>${center.reg_16}</p><p class="sub-p">${center.day_16}</p>
								</td>
								<td>
									<p>${center.reg_15}</p><p class="sub-p">${center.day_15}</p>
								</td>
								<td>
									<p>${center.reg_14}</p><p class="sub-p">${center.day_14}</p>
								</td>
								<td>
									<p>${center.reg_13}</p><p class="sub-p">${center.day_13}</p>
								</td>
								<td>
									<p>${center.reg_12}</p><p class="sub-p">${center.day_12}</p>
								</td>
								<td>
									<p>${center.reg_11}</p><p class="sub-p">${center.day_11}</p>
								</td>
								<td>
									<p>${center.reg_10}</p><p class="sub-p">${center.day_10}</p>
								</td>
								<td>
									<p>${center.reg_09}</p><p class="sub-p">${center.day_09}</p>
								</td>
								<td>
									<p>${center.reg_08}</p><p class="sub-p">${center.day_08}</p>
								</td>
								<td>
									<p>${center.reg_07}</p><p class="sub-p">${center.day_07}</p>
								</td>
								<td>
									<p>${center.reg_06}</p><p class="sub-p">${center.day_06}</p>
								</td>
								<td>
									<p>${center.reg_05}</p><p class="sub-p">${center.day_05}</p>
								</td>
								<td>
									<p>${center.reg_04}</p><p class="sub-p">${center.day_04}</p>
								</td>
								<td>
									<p>${center.reg_03}</p><p class="sub-p">${center.day_03}</p>
								</td>
								<td>
									<p>${center.reg_02}</p><p class="sub-p">${center.day_02}</p>
								</td>
								<td>
									<p>${center.reg_01}</p><p class="sub-p">${center.day_01}</p>
								</td>
								<td>
									<p>${center.reg_00}</p><p class="sub-p">${center.day_00}</p>
								</td>	                    
		            		</tr>
		            		<tr bgcolor="#E7ECF1">
		            			<td class="border-right" colspan="2">${center.team_center_val} 소계 (${center.member_cnt})</td>
		            			<td class="border-right">		                    	
			                    	<c:set var="sub1_regSum" value="${center.reg_29+center.reg_28+center.reg_27+center.reg_26+center.reg_25+center.reg_24+center.reg_23+center.reg_22+center.reg_21+center.reg_20+center.reg_19+center.reg_18+center.reg_17+center.reg_16+center.reg_15+center.reg_14+center.reg_13+center.reg_12+center.reg_11+center.reg_10+center.reg_09+center.reg_08+center.reg_07+center.reg_06+center.reg_05+center.reg_04+center.reg_03+center.reg_02+center.reg_01+center.reg_00}"/>
			                    	<c:set var="sub1_daySum" value="${center.day_29+center.day_28+center.day_27+center.day_26+center.day_25+center.day_24+center.day_23+center.day_22+center.day_21+center.day_20+center.day_19+center.day_18+center.day_17+center.day_16+center.day_15+center.day_14+center.day_13+center.day_12+center.day_11+center.day_10+center.day_09+center.day_08+center.day_07+center.day_06+center.day_05+center.day_04+center.day_03+center.day_02+center.day_01+center.day_00}"/>
			                    	<p>${sub1_regSum}</p><p class="sub-p">${sub1_daySum}</p>
			                  	</td>
			                  	<td class="border-right">
			                  		<c:choose>		                  			
			                  			<c:when test="${ center.member_cnt eq 0}">
			                  				<p>0</p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:when test="${ sub1_regSum eq 0 && sub1_daySum ne 0}">
			                  				<p>0</p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / center.member_cnt}" pattern="#.#"/></p>
			                  			</c:when>
			                  			<c:when test="${ sub1_regSum ne 0 && sub1_daySum eq 0}">
			                  				<p><fmt:formatNumber value="${sub1_regSum / center.member_cnt}" pattern="#.#"/></p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:otherwise>
			                  				<p><fmt:formatNumber value="${sub1_regSum / center.member_cnt}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / center.member_cnt}" pattern="#.#"/></p>
			                  			</c:otherwise>
			                  		</c:choose>		                  		
			                  	</td>
			                    <!-- 1인당 미결 시작 -->
								<td class="border-right">
									<c:choose>		                  			
										<c:when test="${ center.member_cnt eq 0}">
											<p>0</p>
										</c:when>
										<c:when test="${ center.reg_mi eq 0 }">
											<p>0</p>
										</c:when>		                  			
										<c:otherwise>
											<p><fmt:formatNumber value="${center.reg_mi / center.member_cnt}" pattern="#.#"/></p>
										</c:otherwise>
									</c:choose>		                  		
								</td>
								<!-- 1인당 미결 끝 -->
								<td>
			                    	<font color="">${center.reg_mi}</font>
			                    </td>
			                    <td>
			                   		${center.reg_y}
			                 	</td>
			                    <td>
			                    	${center.cls_m}
			                   	</td>
			                    <td class="border-right">
			                    	${center.cls_y}
			                	</td>			                    
			                    <td>
									<p>${center.reg_29}</p><p class="sub-p">${center.day_29}</p>
								</td>
								<td>
									<p>${center.reg_28}</p><p class="sub-p">${center.day_28}</p>
								</td>
								<td>
									<p>${center.reg_27}</p><p class="sub-p">${center.day_27}</p>
								</td>
								<td>
									<p>${center.reg_26}</p><p class="sub-p">${center.day_26}</p>
								</td>
								<td>
									<p>${center.reg_25}</p><p class="sub-p">${center.day_25}</p>
								</td>
								<td>
									<p>${center.reg_24}</p><p class="sub-p">${center.day_24}</p>
								</td>
								<td>
									<p>${center.reg_23}</p><p class="sub-p">${center.day_23}</p>
								</td>
								<td>
									<p>${center.reg_22}</p><p class="sub-p">${center.day_22}</p>
								</td>
								<td>
									<p>${center.reg_21}</p><p class="sub-p">${center.day_21}</p>
								</td>
								<td>
									<p>${center.reg_20}</p><p class="sub-p">${center.day_20}</p>
								</td>
								<td>
									<p>${center.reg_19}</p><p class="sub-p">${center.day_19}</p>
								</td>
								<td>
									<p>${center.reg_18}</p><p class="sub-p">${center.day_18}</p>
								</td>
								<td>
									<p>${center.reg_17}</p><p class="sub-p">${center.day_17}</p>
								</td>
								<td>
									<p>${center.reg_16}</p><p class="sub-p">${center.day_16}</p>
								</td>
								<td>
									<p>${center.reg_15}</p><p class="sub-p">${center.day_15}</p>
								</td>
								<td>
									<p>${center.reg_14}</p><p class="sub-p">${center.day_14}</p>
								</td>
								<td>
									<p>${center.reg_13}</p><p class="sub-p">${center.day_13}</p>
								</td>
								<td>
									<p>${center.reg_12}</p><p class="sub-p">${center.day_12}</p>
								</td>
								<td>
									<p>${center.reg_11}</p><p class="sub-p">${center.day_11}</p>
								</td>
								<td>
									<p>${center.reg_10}</p><p class="sub-p">${center.day_10}</p>
								</td>
								<td>
									<p>${center.reg_09}</p><p class="sub-p">${center.day_09}</p>
								</td>
								<td>
									<p>${center.reg_08}</p><p class="sub-p">${center.day_08}</p>
								</td>
								<td>
									<p>${center.reg_07}</p><p class="sub-p">${center.day_07}</p>
								</td>
								<td>
									<p>${center.reg_06}</p><p class="sub-p">${center.day_06}</p>
								</td>
								<td>
									<p>${center.reg_05}</p><p class="sub-p">${center.day_05}</p>
								</td>
								<td>
									<p>${center.reg_04}</p><p class="sub-p">${center.day_04}</p>
								</td>
								<td>
									<p>${center.reg_03}</p><p class="sub-p">${center.day_03}</p>
								</td>
								<td>
									<p>${center.reg_02}</p><p class="sub-p">${center.day_02}</p>
								</td>
								<td>
									<p>${center.reg_01}</p><p class="sub-p">${center.day_01}</p>
								</td>
								<td>
									<p>${center.reg_00}</p><p class="sub-p">${center.day_00}</p>
								</td>	                    
		            		</tr>
	            		</c:if>
            		</c:forEach>
		            <!-- 기타 끝 -->
		            
		            <!-- 물보험 소계 표시 시작 -->
		            <tr bgcolor="#E7ECF1">
		                <th class="border-right" colspan="2">물보험 소계 (${sumMember_cnt_center})</th>
		                <th class="border-right">
		                	<p>${sumReg_center_sum}</p><p class="sub-p">${sumDay_center_sum}</p>
		               	</th>
		               	<th class="border-right">		                	
		                	<p><fmt:formatNumber value="${sumReg_center_sum / sumMember_cnt_center}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sumDay_center_sum / sumMember_cnt_center}" pattern="#.#"/></p>
		               	</th>		               	
		               	<th class="border-right">		                	
		                	<p><fmt:formatNumber value="${sumReg_center_mi / sumMember_cnt_center}" pattern="#.#"/></p>
		               	</th>
		               	<th><font color="">${sumReg_center_mi}</font></th>
		               	<th>${sumReg_center_y}</th>
		                <th>${sumCls_center_m}</th>
		                <th class="border-right">${sumCls_center_y}</th>
		                <th>
							<p>${sumReg_center_29}</p><p class="sub-p">${sumDay_center_29}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_28}</p><p class="sub-p">${sumDay_center_28}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_27}</p><p class="sub-p">${sumDay_center_27}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_26}</p><p class="sub-p">${sumDay_center_26}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_25}</p><p class="sub-p">${sumDay_center_25}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_24}</p><p class="sub-p">${sumDay_center_24}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_23}</p><p class="sub-p">${sumDay_center_23}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_22}</p><p class="sub-p">${sumDay_center_22}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_21}</p><p class="sub-p">${sumDay_center_21}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_20}</p><p class="sub-p">${sumDay_center_20}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_19}</p><p class="sub-p">${sumDay_center_19}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_18}</p><p class="sub-p">${sumDay_center_18}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_17}</p><p class="sub-p">${sumDay_center_17}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_16}</p><p class="sub-p">${sumDay_center_16}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_15}</p><p class="sub-p">${sumDay_center_15}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_14}</p><p class="sub-p">${sumDay_center_14}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_13}</p><p class="sub-p">${sumDay_center_13}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_12}</p><p class="sub-p">${sumDay_center_12}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_11}</p><p class="sub-p">${sumDay_center_11}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_10}</p><p class="sub-p">${sumDay_center_10}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_09}</p><p class="sub-p">${sumDay_center_09}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_08}</p><p class="sub-p">${sumDay_center_08}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_07}</p><p class="sub-p">${sumDay_center_07}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_06}</p><p class="sub-p">${sumDay_center_06}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_05}</p><p class="sub-p">${sumDay_center_05}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_04}</p><p class="sub-p">${sumDay_center_04}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_03}</p><p class="sub-p">${sumDay_center_03}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_02}</p><p class="sub-p">${sumDay_center_02}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_01}</p><p class="sub-p">${sumDay_center_01}</p>
		               	</th>
		                <th>
							<p>${sumReg_center_00}</p><p class="sub-p">${sumDay_center_00}</p>
		               	</th>                
		            </tr>
		            <!-- 물보험 소계 표시 끝 -->
		            
		            <!-- 인보험 조사 심사시작 -->
		            <c:forEach var="center4" items="${TeamCenter4ListVO}" varStatus="status">            	
	            		<c:if test="${center4.team_center eq 101 || center4.team_center eq 102 || center4.team_center eq 103}">
		            		<tr>
		            			<td>${center4.team_center_val} (${center4.member_cnt})</td>
			                    <td class="border-right">
			                    	<p>수임</p><p class="sub-p">종결</p>
			                    </td>
			                    <td class="border-right">		                    	
			                    	<c:set var="sub1_regSum" value="${center4.reg_29+center4.reg_28+center4.reg_27+center4.reg_26+center4.reg_25+center4.reg_24+center4.reg_23+center4.reg_22+center4.reg_21+center4.reg_20+center4.reg_19+center4.reg_18+center4.reg_17+center4.reg_16+center4.reg_15+center4.reg_14+center4.reg_13+center4.reg_12+center4.reg_11+center4.reg_10+center4.reg_09+center4.reg_08+center4.reg_07+center4.reg_06+center4.reg_05+center4.reg_04+center4.reg_03+center4.reg_02+center4.reg_01+center4.reg_00}"/>
			                    	<c:set var="sub1_daySum" value="${center4.day_29+center4.day_28+center4.day_27+center4.day_26+center4.day_25+center4.day_24+center4.day_23+center4.day_22+center4.day_21+center4.day_20+center4.day_19+center4.day_18+center4.day_17+center4.day_16+center4.day_15+center4.day_14+center4.day_13+center4.day_12+center4.day_11+center4.day_10+center4.day_09+center4.day_08+center4.day_07+center4.day_06+center4.day_05+center4.day_04+center4.day_03+center4.day_02+center4.day_01+center4.day_00}"/>
			                    	<p>${sub1_regSum}</p><p class="sub-p">${sub1_daySum}</p>
			                  	</td>
			                  	<!-- 1인당 건수 시작 -->
			                  	<td class="border-right" bgcolor="#faebd7">
			                  		<c:choose>		                  			
			                  			<c:when test="${center4.member_cnt eq 0}">
			                  				<p>0</p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:when test="${sub1_regSum eq 0 && sub1_daySum ne 0}">
			                  				<p>0</p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / center4.member_cnt}" pattern="#.#"/></p>
			                  			</c:when>
			                  			<c:when test="${sub1_regSum ne 0 && sub1_daySum eq 0}">
			                  				<p><fmt:formatNumber value="${sub1_regSum / center4.member_cnt}" pattern="#.#"/></p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:otherwise>
			                  				<p><fmt:formatNumber value="${sub1_regSum / center4.member_cnt}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / center4.member_cnt}" pattern="#.#"/></p>
			                  			</c:otherwise>
			                  		</c:choose>		                  		
			                  	</td>
			                  	<!-- 1인당 건수 끝 -->			                  	
			                    <!-- 1인당 미결 시작 -->
								<td class="border-right" bgcolor="#faebd7">
									<c:choose>		                  			
										<c:when test="${ center4.member_cnt eq 0}">
											<p>0</p>
										</c:when>
										<c:when test="${ center4.reg_mi eq 0 }">
											<p>0</p>
										</c:when>		                  			
										<c:otherwise>
											<p><fmt:formatNumber value="${center4.reg_mi / center4.member_cnt}" pattern="#.#"/></p>
										</c:otherwise>
									</c:choose>		                  		
								</td>
								<!-- 1인당 미결 끝 -->
								<td bgcolor="#faebd7">
			                    	<font color="">${center4.reg_mi}</font>
			                    </td>
			                    <td bgcolor="#faebd7">
			                   		${center4.reg_y}
			                 	</td>
			                    <td bgcolor="#faebd7">
			                    	${center4.cls_m}
			                   	</td>
			                    <td class="border-right" bgcolor="#faebd7">
			                    	${center4.cls_y}
			                	</td>
			                    <td>
									<p>${center4.reg_29}</p><p class="sub-p">${center4.day_29}</p>
								</td>
								<td>
									<p>${center4.reg_28}</p><p class="sub-p">${center4.day_28}</p>
								</td>
								<td>
									<p>${center4.reg_27}</p><p class="sub-p">${center4.day_27}</p>
								</td>
								<td>
									<p>${center4.reg_26}</p><p class="sub-p">${center4.day_26}</p>
								</td>
								<td>
									<p>${center4.reg_25}</p><p class="sub-p">${center4.day_25}</p>
								</td>
								<td>
									<p>${center4.reg_24}</p><p class="sub-p">${center4.day_24}</p>
								</td>
								<td>
									<p>${center4.reg_23}</p><p class="sub-p">${center4.day_23}</p>
								</td>
								<td>
									<p>${center4.reg_22}</p><p class="sub-p">${center4.day_22}</p>
								</td>
								<td>
									<p>${center4.reg_21}</p><p class="sub-p">${center4.day_21}</p>
								</td>
								<td>
									<p>${center4.reg_20}</p><p class="sub-p">${center4.day_20}</p>
								</td>
								<td>
									<p>${center4.reg_19}</p><p class="sub-p">${center4.day_19}</p>
								</td>
								<td>
									<p>${center4.reg_18}</p><p class="sub-p">${center4.day_18}</p>
								</td>
								<td>
									<p>${center4.reg_17}</p><p class="sub-p">${center4.day_17}</p>
								</td>
								<td>
									<p>${center4.reg_16}</p><p class="sub-p">${center4.day_16}</p>
								</td>
								<td>
									<p>${center4.reg_15}</p><p class="sub-p">${center4.day_15}</p>
								</td>
								<td>
									<p>${center4.reg_14}</p><p class="sub-p">${center4.day_14}</p>
								</td>
								<td>
									<p>${center4.reg_13}</p><p class="sub-p">${center4.day_13}</p>
								</td>
								<td>
									<p>${center4.reg_12}</p><p class="sub-p">${center4.day_12}</p>
								</td>
								<td>
									<p>${center4.reg_11}</p><p class="sub-p">${center4.day_11}</p>
								</td>
								<td>
									<p>${center4.reg_10}</p><p class="sub-p">${center4.day_10}</p>
								</td>
								<td>
									<p>${center4.reg_09}</p><p class="sub-p">${center4.day_09}</p>
								</td>
								<td>
									<p>${center4.reg_08}</p><p class="sub-p">${center4.day_08}</p>
								</td>
								<td>
									<p>${center4.reg_07}</p><p class="sub-p">${center4.day_07}</p>
								</td>
								<td>
									<p>${center4.reg_06}</p><p class="sub-p">${center4.day_06}</p>
								</td>
								<td>
									<p>${center4.reg_05}</p><p class="sub-p">${center4.day_05}</p>
								</td>
								<td>
									<p>${center4.reg_04}</p><p class="sub-p">${center4.day_04}</p>
								</td>
								<td>
									<p>${center4.reg_03}</p><p class="sub-p">${center4.day_03}</p>
								</td>
								<td>
									<p>${center4.reg_02}</p><p class="sub-p">${center4.day_02}</p>
								</td>
								<td>
									<p>${center4.reg_01}</p><p class="sub-p">${center4.day_01}</p>
								</td>
								<td>
									<p>${center4.reg_00}</p><p class="sub-p">${center4.day_00}</p>
								</td>	                    		            			
		            		</tr>
		            		
		            		<!-- 인보험 조사심사 소계 계산 시작 -->
		            		<c:set var="sumMember4_cnt_mid" value="${sumMember4_cnt_mid + center4.member_cnt}" />
		            		<c:set var="sumReg4_mid_29" value="${sumReg4_mid_29 + center4.reg_29}" />
							<c:set var="sumReg4_mid_28" value="${sumReg4_mid_28 + center4.reg_28}" />
							<c:set var="sumReg4_mid_27" value="${sumReg4_mid_27 + center4.reg_27}" />
							<c:set var="sumReg4_mid_26" value="${sumReg4_mid_26 + center4.reg_26}" />
							<c:set var="sumReg4_mid_25" value="${sumReg4_mid_25 + center4.reg_25}" />
							<c:set var="sumReg4_mid_24" value="${sumReg4_mid_24 + center4.reg_24}" />
							<c:set var="sumReg4_mid_23" value="${sumReg4_mid_23 + center4.reg_23}" />
							<c:set var="sumReg4_mid_22" value="${sumReg4_mid_22 + center4.reg_22}" />
							<c:set var="sumReg4_mid_21" value="${sumReg4_mid_21 + center4.reg_21}" />
							<c:set var="sumReg4_mid_20" value="${sumReg4_mid_20 + center4.reg_20}" />
							<c:set var="sumReg4_mid_19" value="${sumReg4_mid_19 + center4.reg_19}" />
							<c:set var="sumReg4_mid_18" value="${sumReg4_mid_18 + center4.reg_18}" />
							<c:set var="sumReg4_mid_17" value="${sumReg4_mid_17 + center4.reg_17}" />
							<c:set var="sumReg4_mid_16" value="${sumReg4_mid_16 + center4.reg_16}" />
							<c:set var="sumReg4_mid_15" value="${sumReg4_mid_15 + center4.reg_15}" />
							<c:set var="sumReg4_mid_14" value="${sumReg4_mid_14 + center4.reg_14}" />
							<c:set var="sumReg4_mid_13" value="${sumReg4_mid_13 + center4.reg_13}" />
							<c:set var="sumReg4_mid_12" value="${sumReg4_mid_12 + center4.reg_12}" />
							<c:set var="sumReg4_mid_11" value="${sumReg4_mid_11 + center4.reg_11}" />
							<c:set var="sumReg4_mid_10" value="${sumReg4_mid_10 + center4.reg_10}" />
							<c:set var="sumReg4_mid_09" value="${sumReg4_mid_09 + center4.reg_09}" />
							<c:set var="sumReg4_mid_08" value="${sumReg4_mid_08 + center4.reg_08}" />
							<c:set var="sumReg4_mid_07" value="${sumReg4_mid_07 + center4.reg_07}" />
							<c:set var="sumReg4_mid_06" value="${sumReg4_mid_06 + center4.reg_06}" />
							<c:set var="sumReg4_mid_05" value="${sumReg4_mid_05 + center4.reg_05}" />
							<c:set var="sumReg4_mid_04" value="${sumReg4_mid_04 + center4.reg_04}" />
							<c:set var="sumReg4_mid_03" value="${sumReg4_mid_03 + center4.reg_03}" />
							<c:set var="sumReg4_mid_02" value="${sumReg4_mid_02 + center4.reg_02}" />
							<c:set var="sumReg4_mid_01" value="${sumReg4_mid_01 + center4.reg_01}" />
							<c:set var="sumReg4_mid_00" value="${sumReg4_mid_00 + center4.reg_00}" />
							<c:set var="sumReg4_mid_sum" value="${sumReg4_mid_sum + sub1_regSum}" />		                
										
							<c:set var="sumDay4_mid_29" value="${sumDay4_mid_29 + center4.day_29}" />
							<c:set var="sumDay4_mid_28" value="${sumDay4_mid_28 + center4.day_28}" />
							<c:set var="sumDay4_mid_27" value="${sumDay4_mid_27 + center4.day_27}" />
							<c:set var="sumDay4_mid_26" value="${sumDay4_mid_26 + center4.day_26}" />
							<c:set var="sumDay4_mid_25" value="${sumDay4_mid_25 + center4.day_25}" />
							<c:set var="sumDay4_mid_24" value="${sumDay4_mid_24 + center4.day_24}" />
							<c:set var="sumDay4_mid_23" value="${sumDay4_mid_23 + center4.day_23}" />
							<c:set var="sumDay4_mid_22" value="${sumDay4_mid_22 + center4.day_22}" />
							<c:set var="sumDay4_mid_21" value="${sumDay4_mid_21 + center4.day_21}" />
							<c:set var="sumDay4_mid_20" value="${sumDay4_mid_20 + center4.day_20}" />
							<c:set var="sumDay4_mid_19" value="${sumDay4_mid_19 + center4.day_19}" />
							<c:set var="sumDay4_mid_18" value="${sumDay4_mid_18 + center4.day_18}" />
							<c:set var="sumDay4_mid_17" value="${sumDay4_mid_17 + center4.day_17}" />
							<c:set var="sumDay4_mid_16" value="${sumDay4_mid_16 + center4.day_16}" />
							<c:set var="sumDay4_mid_15" value="${sumDay4_mid_15 + center4.day_15}" />
							<c:set var="sumDay4_mid_14" value="${sumDay4_mid_14 + center4.day_14}" />
							<c:set var="sumDay4_mid_13" value="${sumDay4_mid_13 + center4.day_13}" />
							<c:set var="sumDay4_mid_12" value="${sumDay4_mid_12 + center4.day_12}" />
							<c:set var="sumDay4_mid_11" value="${sumDay4_mid_11 + center4.day_11}" />
							<c:set var="sumDay4_mid_10" value="${sumDay4_mid_10 + center4.day_10}" />
							<c:set var="sumDay4_mid_09" value="${sumDay4_mid_09 + center4.day_09}" />
							<c:set var="sumDay4_mid_08" value="${sumDay4_mid_08 + center4.day_08}" />
							<c:set var="sumDay4_mid_07" value="${sumDay4_mid_07 + center4.day_07}" />
							<c:set var="sumDay4_mid_06" value="${sumDay4_mid_06 + center4.day_06}" />
							<c:set var="sumDay4_mid_05" value="${sumDay4_mid_05 + center4.day_05}" />
							<c:set var="sumDay4_mid_04" value="${sumDay4_mid_04 + center4.day_04}" />
							<c:set var="sumDay4_mid_03" value="${sumDay4_mid_03 + center4.day_03}" />
							<c:set var="sumDay4_mid_02" value="${sumDay4_mid_02 + center4.day_02}" />
							<c:set var="sumDay4_mid_01" value="${sumDay4_mid_01 + center4.day_01}" />
							<c:set var="sumDay4_mid_00" value="${sumDay4_mid_00 + center4.day_00}" />                
							<c:set var="sumDay4_mid_sum" value="${sumDay4_mid_sum + sub1_daySum}" />
							
							<c:set var="sumReg4_mid_y" value="${sumReg4_mid_y + center4.reg_y}" />
							<c:set var="sumCls4_mid_m" value="${sumCls4_mid_m + center4.cls_m}" />
							<c:set var="sumCls4_mid_y" value="${sumCls4_mid_y + center4.cls_y}" />
							<c:set var="sumReg4_mid_mi" value="${sumReg4_mid_mi + center4.reg_mi}" />		            		
		            		<!-- 인보험 조사심사 소계 계산 시작 -->		            		
		            	</c:if>
		            	
		            	<!-- 4종 전체 합계 계산 시작 -->
		            	<c:set var="sumMember4_cnt_center" value="${sumMember4_cnt_center + center4.member_cnt}" />
	            		<c:set var="sumReg4_center_29" value="${sumReg4_center_29 + center4.reg_29}" />
						<c:set var="sumReg4_center_28" value="${sumReg4_center_28 + center4.reg_28}" />
						<c:set var="sumReg4_center_27" value="${sumReg4_center_27 + center4.reg_27}" />
						<c:set var="sumReg4_center_26" value="${sumReg4_center_26 + center4.reg_26}" />
						<c:set var="sumReg4_center_25" value="${sumReg4_center_25 + center4.reg_25}" />
						<c:set var="sumReg4_center_24" value="${sumReg4_center_24 + center4.reg_24}" />
						<c:set var="sumReg4_center_23" value="${sumReg4_center_23 + center4.reg_23}" />
						<c:set var="sumReg4_center_22" value="${sumReg4_center_22 + center4.reg_22}" />
						<c:set var="sumReg4_center_21" value="${sumReg4_center_21 + center4.reg_21}" />
						<c:set var="sumReg4_center_20" value="${sumReg4_center_20 + center4.reg_20}" />
						<c:set var="sumReg4_center_19" value="${sumReg4_center_19 + center4.reg_19}" />
						<c:set var="sumReg4_center_18" value="${sumReg4_center_18 + center4.reg_18}" />
						<c:set var="sumReg4_center_17" value="${sumReg4_center_17 + center4.reg_17}" />
						<c:set var="sumReg4_center_16" value="${sumReg4_center_16 + center4.reg_16}" />
						<c:set var="sumReg4_center_15" value="${sumReg4_center_15 + center4.reg_15}" />
						<c:set var="sumReg4_center_14" value="${sumReg4_center_14 + center4.reg_14}" />
						<c:set var="sumReg4_center_13" value="${sumReg4_center_13 + center4.reg_13}" />
						<c:set var="sumReg4_center_12" value="${sumReg4_center_12 + center4.reg_12}" />
						<c:set var="sumReg4_center_11" value="${sumReg4_center_11 + center4.reg_11}" />
						<c:set var="sumReg4_center_10" value="${sumReg4_center_10 + center4.reg_10}" />
						<c:set var="sumReg4_center_09" value="${sumReg4_center_09 + center4.reg_09}" />
						<c:set var="sumReg4_center_08" value="${sumReg4_center_08 + center4.reg_08}" />
						<c:set var="sumReg4_center_07" value="${sumReg4_center_07 + center4.reg_07}" />
						<c:set var="sumReg4_center_06" value="${sumReg4_center_06 + center4.reg_06}" />
						<c:set var="sumReg4_center_05" value="${sumReg4_center_05 + center4.reg_05}" />
						<c:set var="sumReg4_center_04" value="${sumReg4_center_04 + center4.reg_04}" />
						<c:set var="sumReg4_center_03" value="${sumReg4_center_03 + center4.reg_03}" />
						<c:set var="sumReg4_center_02" value="${sumReg4_center_02 + center4.reg_02}" />
						<c:set var="sumReg4_center_01" value="${sumReg4_center_01 + center4.reg_01}" />
						<c:set var="sumReg4_center_00" value="${sumReg4_center_00 + center4.reg_00}" />
						<c:set var="sumReg4_center_sum" value="${sumReg4_center_sum + center4.reg_29+center4.reg_28+center4.reg_27+center4.reg_26+center4.reg_25+center4.reg_24+center4.reg_23+center4.reg_22+center4.reg_21+center4.reg_20+center4.reg_19+center4.reg_18+center4.reg_17+center4.reg_16+center4.reg_15+center4.reg_14+center4.reg_13+center4.reg_12+center4.reg_11+center4.reg_10+center4.reg_09+center4.reg_08+center4.reg_07+center4.reg_06+center4.reg_05+center4.reg_04+center4.reg_03+center4.reg_02+center4.reg_01+center4.reg_00}" />		                
									
						<c:set var="sumDay4_center_29" value="${sumDay4_center_29 + center4.day_29}" />
						<c:set var="sumDay4_center_28" value="${sumDay4_center_28 + center4.day_28}" />
						<c:set var="sumDay4_center_27" value="${sumDay4_center_27 + center4.day_27}" />
						<c:set var="sumDay4_center_26" value="${sumDay4_center_26 + center4.day_26}" />
						<c:set var="sumDay4_center_25" value="${sumDay4_center_25 + center4.day_25}" />
						<c:set var="sumDay4_center_24" value="${sumDay4_center_24 + center4.day_24}" />
						<c:set var="sumDay4_center_23" value="${sumDay4_center_23 + center4.day_23}" />
						<c:set var="sumDay4_center_22" value="${sumDay4_center_22 + center4.day_22}" />
						<c:set var="sumDay4_center_21" value="${sumDay4_center_21 + center4.day_21}" />
						<c:set var="sumDay4_center_20" value="${sumDay4_center_20 + center4.day_20}" />
						<c:set var="sumDay4_center_19" value="${sumDay4_center_19 + center4.day_19}" />
						<c:set var="sumDay4_center_18" value="${sumDay4_center_18 + center4.day_18}" />
						<c:set var="sumDay4_center_17" value="${sumDay4_center_17 + center4.day_17}" />
						<c:set var="sumDay4_center_16" value="${sumDay4_center_16 + center4.day_16}" />
						<c:set var="sumDay4_center_15" value="${sumDay4_center_15 + center4.day_15}" />
						<c:set var="sumDay4_center_14" value="${sumDay4_center_14 + center4.day_14}" />
						<c:set var="sumDay4_center_13" value="${sumDay4_center_13 + center4.day_13}" />
						<c:set var="sumDay4_center_12" value="${sumDay4_center_12 + center4.day_12}" />
						<c:set var="sumDay4_center_11" value="${sumDay4_center_11 + center4.day_11}" />
						<c:set var="sumDay4_center_10" value="${sumDay4_center_10 + center4.day_10}" />
						<c:set var="sumDay4_center_09" value="${sumDay4_center_09 + center4.day_09}" />
						<c:set var="sumDay4_center_08" value="${sumDay4_center_08 + center4.day_08}" />
						<c:set var="sumDay4_center_07" value="${sumDay4_center_07 + center4.day_07}" />
						<c:set var="sumDay4_center_06" value="${sumDay4_center_06 + center4.day_06}" />
						<c:set var="sumDay4_center_05" value="${sumDay4_center_05 + center4.day_05}" />
						<c:set var="sumDay4_center_04" value="${sumDay4_center_04 + center4.day_04}" />
						<c:set var="sumDay4_center_03" value="${sumDay4_center_03 + center4.day_03}" />
						<c:set var="sumDay4_center_02" value="${sumDay4_center_02 + center4.day_02}" />
						<c:set var="sumDay4_center_01" value="${sumDay4_center_01 + center4.day_01}" />
						<c:set var="sumDay4_center_00" value="${sumDay4_center_00 + center4.day_00}" />                
						<c:set var="sumDay4_center_sum" value="${sumDay4_center_sum + center4.day_29+center4.day_28+center4.day_27+center4.day_26+center4.day_25+center4.day_24+center4.day_23+center4.day_22+center4.day_21+center4.day_20+center4.day_19+center4.day_18+center4.day_17+center4.day_16+center4.day_15+center4.day_14+center4.day_13+center4.day_12+center4.day_11+center4.day_10+center4.day_09+center4.day_08+center4.day_07+center4.day_06+center4.day_05+center4.day_04+center4.day_03+center4.day_02+center4.day_01+center4.day_00}" />
						
						<c:set var="sumReg4_center_y" value="${sumReg4_center_y + center4.reg_y}" />
						<c:set var="sumCls4_center_m" value="${sumCls4_center_m + center4.cls_m}" />
						<c:set var="sumCls4_center_y" value="${sumCls4_center_y + center4.cls_y}" />
						<c:set var="sumReg4_center_mi" value="${sumReg4_center_mi + center4.reg_mi}" />
						<!-- 4종 전체 합계 계산 끝 -->
		            	
		            </c:forEach>
		            
		            <!-- 인보험 조사 심사 소계 표시 시작 -->
            		<tr bgcolor="#E7ECF1">
		                <td class="border-right" colspan="2">인보험 조사심사 소계 (${sumMember4_cnt_mid})</td>
		                <td class="border-right">
		                	<p>${sumReg4_mid_sum}</p><p class="sub-p">${sumDay4_mid_sum}</p>
		               	</td>
		               	<td class="border-right">
		               		<p><fmt:formatNumber value="${sumReg4_mid_sum / sumMember4_cnt_mid}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sumDay4_mid_sum / sumMember4_cnt_mid}" pattern="#.#"/></p>
		               	</td>		               	
		               	<td class="border-right">
		               		<p><fmt:formatNumber value="${sumReg4_mid_mi / sumMember4_cnt_mid}" pattern="#.#"/></p>
		               	</td>
		               	<td><font color="">${sumReg4_mid_mi}</font></td>
		               	<td>${sumReg4_mid_y}</td>
		                <td>${sumCls4_mid_m}</td>
		                <td class="border-right">${sumCls4_mid_y}</td>
		                <td>
							<p>${sumReg4_mid_29}</p><p class="sub-p">${sumDay4_mid_29}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_28}</p><p class="sub-p">${sumDay4_mid_28}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_27}</p><p class="sub-p">${sumDay4_mid_27}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_26}</p><p class="sub-p">${sumDay4_mid_26}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_25}</p><p class="sub-p">${sumDay4_mid_25}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_24}</p><p class="sub-p">${sumDay4_mid_24}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_23}</p><p class="sub-p">${sumDay4_mid_23}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_22}</p><p class="sub-p">${sumDay4_mid_22}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_21}</p><p class="sub-p">${sumDay4_mid_21}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_20}</p><p class="sub-p">${sumDay4_mid_20}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_19}</p><p class="sub-p">${sumDay4_mid_19}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_18}</p><p class="sub-p">${sumDay4_mid_18}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_17}</p><p class="sub-p">${sumDay4_mid_17}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_16}</p><p class="sub-p">${sumDay4_mid_16}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_15}</p><p class="sub-p">${sumDay4_mid_15}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_14}</p><p class="sub-p">${sumDay4_mid_14}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_13}</p><p class="sub-p">${sumDay4_mid_13}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_12}</p><p class="sub-p">${sumDay4_mid_12}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_11}</p><p class="sub-p">${sumDay4_mid_11}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_10}</p><p class="sub-p">${sumDay4_mid_10}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_09}</p><p class="sub-p">${sumDay4_mid_09}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_08}</p><p class="sub-p">${sumDay4_mid_08}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_07}</p><p class="sub-p">${sumDay4_mid_07}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_06}</p><p class="sub-p">${sumDay4_mid_06}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_05}</p><p class="sub-p">${sumDay4_mid_05}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_04}</p><p class="sub-p">${sumDay4_mid_04}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_03}</p><p class="sub-p">${sumDay4_mid_03}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_02}</p><p class="sub-p">${sumDay4_mid_02}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_01}</p><p class="sub-p">${sumDay4_mid_01}</p>
		               	</td>
		                <td>
							<p>${sumReg4_mid_00}</p><p class="sub-p">${sumDay4_mid_00}</p>
		               	</td>                
		            </tr>
            		<!-- 인보험 조사 심사 소계 표시 끝 -->
            		
            		<!-- 인보험 기타 시작 -->
            		<c:forEach var="center4" items="${TeamCenter4ListVO}" varStatus="status">	            	
	            		<c:if test="${center4.team_center eq 999}">
		            		<tr>
		            			<td>${center4.team_center_val} (${center4.member_cnt})</td>
			                    <td class="border-right">
			                    	<p>수임</p><p class="sub-p">종결</p>
			                    </td>
			                    <td class="border-right">		                    	
			                    	<c:set var="sub1_regSum" value="${center4.reg_29+center4.reg_28+center4.reg_27+center4.reg_26+center4.reg_25+center4.reg_24+center4.reg_23+center4.reg_22+center4.reg_21+center4.reg_20+center4.reg_19+center4.reg_18+center4.reg_17+center4.reg_16+center4.reg_15+center4.reg_14+center4.reg_13+center4.reg_12+center4.reg_11+center4.reg_10+center4.reg_09+center4.reg_08+center4.reg_07+center4.reg_06+center4.reg_05+center4.reg_04+center4.reg_03+center4.reg_02+center4.reg_01+center4.reg_00}"/>
			                    	<c:set var="sub1_daySum" value="${center4.day_29+center4.day_28+center4.day_27+center4.day_26+center4.day_25+center4.day_24+center4.day_23+center4.day_22+center4.day_21+center4.day_20+center4.day_19+center4.day_18+center4.day_17+center4.day_16+center4.day_15+center4.day_14+center4.day_13+center4.day_12+center4.day_11+center4.day_10+center4.day_09+center4.day_08+center4.day_07+center4.day_06+center4.day_05+center4.day_04+center4.day_03+center4.day_02+center4.day_01+center4.day_00}"/>
			                    	<p>${sub1_regSum}</p><p class="sub-p">${sub1_daySum}</p>
			                  	</td>
			                  	<!-- 1인당 건수 시작 -->
			                  	<td class="border-right" bgcolor="#faebd7">
			                  		<c:choose>		                  			
			                  			<c:when test="${center4.member_cnt eq 0}">
			                  				<p>0</p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:when test="${sub1_regSum eq 0 && sub1_daySum ne 0}">
			                  				<p>0</p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / center4.member_cnt}" pattern="#.#"/></p>
			                  			</c:when>
			                  			<c:when test="${sub1_regSum ne 0 && sub1_daySum eq 0}">
			                  				<p><fmt:formatNumber value="${sub1_regSum / center4.member_cnt}" pattern="#.#"/></p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:otherwise>
			                  				<p><fmt:formatNumber value="${sub1_regSum / center4.member_cnt}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / center4.member_cnt}" pattern="#.#"/></p>
			                  			</c:otherwise>
			                  		</c:choose>		                  		
			                  	</td>
			                  	<!-- 1인당 건수 끝 -->			                  	
			                    <!-- 1인당 미결 시작 -->
								<td class="border-right" bgcolor="#faebd7">
									<c:choose>		                  			
										<c:when test="${ center4.member_cnt eq 0}">
											<p>0</p>
										</c:when>
										<c:when test="${ center4.reg_mi eq 0 }">
											<p>0</p>
										</c:when>		                  			
										<c:otherwise>
											<p><fmt:formatNumber value="${center4.reg_mi / center4.member_cnt}" pattern="#.#"/></p>
										</c:otherwise>
									</c:choose>		                  		
								</td>
								<!-- 1인당 미결 끝 -->
								<td bgcolor="#faebd7">
			                    	<font color="">${center4.reg_mi}</font>
			                    </td>
			                    <td bgcolor="#faebd7">
			                   		${center4.reg_y}
			                 	</td>
			                    <td bgcolor="#faebd7">
			                    	${center4.cls_m}
			                   	</td>
			                    <td class="border-right" bgcolor="#faebd7">
			                    	${center4.cls_y}
			                	</td>		                    
			                    <td>
									<p>${center4.reg_29}</p><p class="sub-p">${center4.day_29}</p>
								</td>
								<td>
									<p>${center4.reg_28}</p><p class="sub-p">${center4.day_28}</p>
								</td>
								<td>
									<p>${center4.reg_27}</p><p class="sub-p">${center4.day_27}</p>
								</td>
								<td>
									<p>${center4.reg_26}</p><p class="sub-p">${center4.day_26}</p>
								</td>
								<td>
									<p>${center4.reg_25}</p><p class="sub-p">${center4.day_25}</p>
								</td>
								<td>
									<p>${center4.reg_24}</p><p class="sub-p">${center4.day_24}</p>
								</td>
								<td>
									<p>${center4.reg_23}</p><p class="sub-p">${center4.day_23}</p>
								</td>
								<td>
									<p>${center4.reg_22}</p><p class="sub-p">${center4.day_22}</p>
								</td>
								<td>
									<p>${center4.reg_21}</p><p class="sub-p">${center4.day_21}</p>
								</td>
								<td>
									<p>${center4.reg_20}</p><p class="sub-p">${center4.day_20}</p>
								</td>
								<td>
									<p>${center4.reg_19}</p><p class="sub-p">${center4.day_19}</p>
								</td>
								<td>
									<p>${center4.reg_18}</p><p class="sub-p">${center4.day_18}</p>
								</td>
								<td>
									<p>${center4.reg_17}</p><p class="sub-p">${center4.day_17}</p>
								</td>
								<td>
									<p>${center4.reg_16}</p><p class="sub-p">${center4.day_16}</p>
								</td>
								<td>
									<p>${center4.reg_15}</p><p class="sub-p">${center4.day_15}</p>
								</td>
								<td>
									<p>${center4.reg_14}</p><p class="sub-p">${center4.day_14}</p>
								</td>
								<td>
									<p>${center4.reg_13}</p><p class="sub-p">${center4.day_13}</p>
								</td>
								<td>
									<p>${center4.reg_12}</p><p class="sub-p">${center4.day_12}</p>
								</td>
								<td>
									<p>${center4.reg_11}</p><p class="sub-p">${center4.day_11}</p>
								</td>
								<td>
									<p>${center4.reg_10}</p><p class="sub-p">${center4.day_10}</p>
								</td>
								<td>
									<p>${center4.reg_09}</p><p class="sub-p">${center4.day_09}</p>
								</td>
								<td>
									<p>${center4.reg_08}</p><p class="sub-p">${center4.day_08}</p>
								</td>
								<td>
									<p>${center4.reg_07}</p><p class="sub-p">${center4.day_07}</p>
								</td>
								<td>
									<p>${center4.reg_06}</p><p class="sub-p">${center4.day_06}</p>
								</td>
								<td>
									<p>${center4.reg_05}</p><p class="sub-p">${center4.day_05}</p>
								</td>
								<td>
									<p>${center4.reg_04}</p><p class="sub-p">${center4.day_04}</p>
								</td>
								<td>
									<p>${center4.reg_03}</p><p class="sub-p">${center4.day_03}</p>
								</td>
								<td>
									<p>${center4.reg_02}</p><p class="sub-p">${center4.day_02}</p>
								</td>
								<td>
									<p>${center4.reg_01}</p><p class="sub-p">${center4.day_01}</p>
								</td>
								<td>
									<p>${center4.reg_00}</p><p class="sub-p">${center4.day_00}</p>
								</td>	                    		            			
		            		</tr>
		            		<tr bgcolor="#E7ECF1">
		            			<td class="border-right" colspan="2">${center4.team_center_val} 소계 (${center4.member_cnt})</td>
		            			<td class="border-right">		                    	
			                    	<c:set var="sub1_regSum" value="${center4.reg_29+center4.reg_28+center4.reg_27+center4.reg_26+center4.reg_25+center4.reg_24+center4.reg_23+center4.reg_22+center4.reg_21+center4.reg_20+center4.reg_19+center4.reg_18+center4.reg_17+center4.reg_16+center4.reg_15+center4.reg_14+center4.reg_13+center4.reg_12+center4.reg_11+center4.reg_10+center4.reg_09+center4.reg_08+center4.reg_07+center4.reg_06+center4.reg_05+center4.reg_04+center4.reg_03+center4.reg_02+center4.reg_01+center4.reg_00}"/>
			                    	<c:set var="sub1_daySum" value="${center4.day_29+center4.day_28+center4.day_27+center4.day_26+center4.day_25+center4.day_24+center4.day_23+center4.day_22+center4.day_21+center4.day_20+center4.day_19+center4.day_18+center4.day_17+center4.day_16+center4.day_15+center4.day_14+center4.day_13+center4.day_12+center4.day_11+center4.day_10+center4.day_09+center4.day_08+center4.day_07+center4.day_06+center4.day_05+center4.day_04+center4.day_03+center4.day_02+center4.day_01+center4.day_00}"/>
			                    	<p>${sub1_regSum}</p><p class="sub-p">${sub1_daySum}</p>
			                  	</td>			                  	
				               	<!-- 기타 1인당 건수 시작 -->
			                  	<td class="border-right">
			                  		<c:choose>		                  			
			                  			<c:when test="${center4.member_cnt eq 0}">
			                  				<p>0</p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:when test="${sub1_regSum eq 0 && sub1_daySum ne 0}">
			                  				<p>0</p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / center4.member_cnt}" pattern="#.#"/></p>
			                  			</c:when>
			                  			<c:when test="${sub1_regSum ne 0 && sub1_daySum eq 0}">
			                  				<p><fmt:formatNumber value="${sub1_regSum / center4.member_cnt}" pattern="#.#"/></p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:otherwise>
			                  				<p><fmt:formatNumber value="${sub1_regSum / center4.member_cnt}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / center4.member_cnt}" pattern="#.#"/></p>
			                  			</c:otherwise>
			                  		</c:choose>		                  		
			                  	</td>
			                  	<!-- 기타 1인당 건수 시작 -->			                  	
			                    <!-- 1인당 미결 시작 -->
								<td class="border-right">
									<c:choose>		                  			
										<c:when test="${ center4.member_cnt eq 0}">
											<p>0</p>
										</c:when>
										<c:when test="${ center4.reg_mi eq 0 }">
											<p>0</p>
										</c:when>		                  			
										<c:otherwise>
											<p><fmt:formatNumber value="${center4.reg_mi / center4.member_cnt}" pattern="#.#"/></p>
										</c:otherwise>
									</c:choose>		                  		
								</td>
								<!-- 1인당 미결 끝 -->
								<td>
			                    	<font color="">${center4.reg_mi}</font>
			                    </td>
			                    <td>
			                   		${center4.reg_y}
			                 	</td>
			                    <td>
			                    	${center4.cls_m}
			                   	</td>
			                    <td class="border-right">
			                    	${center4.cls_y}
			                	</td>			                    
			                    <td>
									<p>${center4.reg_29}</p><p class="sub-p">${center4.day_29}</p>
								</td>
								<td>
									<p>${center4.reg_28}</p><p class="sub-p">${center4.day_28}</p>
								</td>
								<td>
									<p>${center4.reg_27}</p><p class="sub-p">${center4.day_27}</p>
								</td>
								<td>
									<p>${center4.reg_26}</p><p class="sub-p">${center4.day_26}</p>
								</td>
								<td>
									<p>${center4.reg_25}</p><p class="sub-p">${center4.day_25}</p>
								</td>
								<td>
									<p>${center4.reg_24}</p><p class="sub-p">${center4.day_24}</p>
								</td>
								<td>
									<p>${center4.reg_23}</p><p class="sub-p">${center4.day_23}</p>
								</td>
								<td>
									<p>${center4.reg_22}</p><p class="sub-p">${center4.day_22}</p>
								</td>
								<td>
									<p>${center4.reg_21}</p><p class="sub-p">${center4.day_21}</p>
								</td>
								<td>
									<p>${center4.reg_20}</p><p class="sub-p">${center4.day_20}</p>
								</td>
								<td>
									<p>${center4.reg_19}</p><p class="sub-p">${center4.day_19}</p>
								</td>
								<td>
									<p>${center4.reg_18}</p><p class="sub-p">${center4.day_18}</p>
								</td>
								<td>
									<p>${center4.reg_17}</p><p class="sub-p">${center4.day_17}</p>
								</td>
								<td>
									<p>${center4.reg_16}</p><p class="sub-p">${center4.day_16}</p>
								</td>
								<td>
									<p>${center4.reg_15}</p><p class="sub-p">${center4.day_15}</p>
								</td>
								<td>
									<p>${center4.reg_14}</p><p class="sub-p">${center4.day_14}</p>
								</td>
								<td>
									<p>${center4.reg_13}</p><p class="sub-p">${center4.day_13}</p>
								</td>
								<td>
									<p>${center4.reg_12}</p><p class="sub-p">${center4.day_12}</p>
								</td>
								<td>
									<p>${center4.reg_11}</p><p class="sub-p">${center4.day_11}</p>
								</td>
								<td>
									<p>${center4.reg_10}</p><p class="sub-p">${center4.day_10}</p>
								</td>
								<td>
									<p>${center4.reg_09}</p><p class="sub-p">${center4.day_09}</p>
								</td>
								<td>
									<p>${center4.reg_08}</p><p class="sub-p">${center4.day_08}</p>
								</td>
								<td>
									<p>${center4.reg_07}</p><p class="sub-p">${center4.day_07}</p>
								</td>
								<td>
									<p>${center4.reg_06}</p><p class="sub-p">${center4.day_06}</p>
								</td>
								<td>
									<p>${center4.reg_05}</p><p class="sub-p">${center4.day_05}</p>
								</td>
								<td>
									<p>${center4.reg_04}</p><p class="sub-p">${center4.day_04}</p>
								</td>
								<td>
									<p>${center4.reg_03}</p><p class="sub-p">${center4.day_03}</p>
								</td>
								<td>
									<p>${center4.reg_02}</p><p class="sub-p">${center4.day_02}</p>
								</td>
								<td>
									<p>${center4.reg_01}</p><p class="sub-p">${center4.day_01}</p>
								</td>
								<td>
									<p>${center4.reg_00}</p><p class="sub-p">${center4.day_00}</p>
								</td>	                    		            			
		            		</tr>
	            		</c:if>
	            	</c:forEach>            		
            		<!-- 인보험 기타 끝 -->
		            
		            <!-- 인보험 소계 시작 -->
		            <tr bgcolor="#E7ECF1">
		                <th class="border-right" colspan="2">인보험 소계 (${ sumMember4_cnt_center})</th>
		                <th class="border-right">
		                	<p>${sumReg4_center_sum}</p><p class="sub-p">${sumDay4_center_sum}</p>
		               	</th>
		               	<th class="border-right">		                	
		                	<p><fmt:formatNumber value="${sumReg4_center_sum / sumMember4_cnt_center}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sumDay4_center_sum / sumMember4_cnt_center}" pattern="#.#"/></p>
		               	</th>		               	
		               	<th class="border-right">		                	
		                	<p><fmt:formatNumber value="${sumReg4_center_mi / sumMember4_cnt_center}" pattern="#.#"/></p>
		               	</th>
		               	<th><font color="">${sumReg4_center_mi}</font></th>
		               	<th>${sumReg4_center_y}</th>
		                <th>${sumCls4_center_m}</th>
		                <th class="border-right">${sumCls4_center_y}</th>
		                <th>
							<p>${sumReg4_center_29}</p><p class="sub-p">${sumDay4_center_29}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_28}</p><p class="sub-p">${sumDay4_center_28}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_27}</p><p class="sub-p">${sumDay4_center_27}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_26}</p><p class="sub-p">${sumDay4_center_26}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_25}</p><p class="sub-p">${sumDay4_center_25}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_24}</p><p class="sub-p">${sumDay4_center_24}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_23}</p><p class="sub-p">${sumDay4_center_23}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_22}</p><p class="sub-p">${sumDay4_center_22}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_21}</p><p class="sub-p">${sumDay4_center_21}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_20}</p><p class="sub-p">${sumDay4_center_20}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_19}</p><p class="sub-p">${sumDay4_center_19}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_18}</p><p class="sub-p">${sumDay4_center_18}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_17}</p><p class="sub-p">${sumDay4_center_17}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_16}</p><p class="sub-p">${sumDay4_center_16}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_15}</p><p class="sub-p">${sumDay4_center_15}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_14}</p><p class="sub-p">${sumDay4_center_14}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_13}</p><p class="sub-p">${sumDay4_center_13}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_12}</p><p class="sub-p">${sumDay4_center_12}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_11}</p><p class="sub-p">${sumDay4_center_11}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_10}</p><p class="sub-p">${sumDay4_center_10}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_09}</p><p class="sub-p">${sumDay4_center_09}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_08}</p><p class="sub-p">${sumDay4_center_08}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_07}</p><p class="sub-p">${sumDay4_center_07}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_06}</p><p class="sub-p">${sumDay4_center_06}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_05}</p><p class="sub-p">${sumDay4_center_05}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_04}</p><p class="sub-p">${sumDay4_center_04}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_03}</p><p class="sub-p">${sumDay4_center_03}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_02}</p><p class="sub-p">${sumDay4_center_02}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_01}</p><p class="sub-p">${sumDay4_center_01}</p>
		               	</th>
		                <th>
							<p>${sumReg4_center_00}</p><p class="sub-p">${sumDay4_center_00}</p>
		               	</th>                
		            </tr>
		            <!-- 인보험 소계 끝 -->		            
		            <!-- 인보험 조사 심사 끝 -->
		            
		            <!-- 전체합계 시작 -->
		            <!-- 전체 합계 시작 -->
		            <tr bgcolor="#E7ECF1">
		                <th class="border-right" colspan="2"><font color="blue">전 체 합 계 (${sumMember_cnt_center + sumMember4_cnt_center})</font></th>
		                <th class="border-right">
		                	<p><font color="blue">${sumReg_center_sum + sumReg4_center_sum}</font></p><p class="sub-p"><font color="blue">${sumDay_center_sum + sumDay4_center_sum}</font></p>
		               	</th>
		               	<th class="border-right">		               	
		               		<p>
		               		<font color="blue">
		               			<fmt:formatNumber value="${ (sumReg_center_sum + sumReg4_center_sum) / (sumMember_cnt_center + sumMember4_cnt_center) }" pattern="#.#"/>
		               		</font></p><p class="sub-p">		               		
		               		<font color="blue">
		               			<fmt:formatNumber value="${ (sumDay_center_sum + sumDay4_center_sum) / (sumMember_cnt_center + sumMember4_cnt_center) }" pattern="#.#"/>
		               		</font></p>		               		 
		               	</th>		               	
		               	<th class="border-right">		               	
		               		<p>
		               		<font color="blue">
		               			<fmt:formatNumber value="${ (sumReg_center_mi + sumReg4_center_mi) / (sumMember_cnt_center + sumMember4_cnt_center) }" pattern="#.#"/>
		               		</font></p>		               		 
		               	</th>
		               	<th><font color="blue">${sumReg_center_mi + sumReg4_center_mi}</font></th>
		               	<th><font color="blue">${sumReg_center_y + sumReg4_center_y}</font></th>
		                <th><font color="blue">${sumCls_center_m + sumCls4_center_m}</font></th>
		                <th class="border-right"><font color="blue">${sumCls_center_y + sumCls4_center_y}</font></th>		               	
		                <th>
							<p><font color="blue">${sumReg_center_29 + sumReg4_center_29}</font></p><p class="sub-p"><font color="blue">${sumDay_center_29 + sumDay4_center_29}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_28 + sumReg4_center_28}</font></p><p class="sub-p"><font color="blue">${sumDay_center_28 + sumDay4_center_28}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_27 + sumReg4_center_27}</font></p><p class="sub-p"><font color="blue">${sumDay_center_27 + sumDay4_center_27}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_26 + sumReg4_center_26}</font></p><p class="sub-p"><font color="blue">${sumDay_center_26 + sumDay4_center_26}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_25 + sumReg4_center_25}</font></p><p class="sub-p"><font color="blue">${sumDay_center_25 + sumDay4_center_25}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_24 + sumReg4_center_24}</font></p><p class="sub-p"><font color="blue">${sumDay_center_24 + sumDay4_center_24}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_23 + sumReg4_center_23}</font></p><p class="sub-p"><font color="blue">${sumDay_center_23 + sumDay4_center_23}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_22 + sumReg4_center_22}</font></p><p class="sub-p"><font color="blue">${sumDay_center_22 + sumDay4_center_22}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_21 + sumReg4_center_21}</font></p><p class="sub-p"><font color="blue">${sumDay_center_21 + sumDay4_center_21}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_20 + sumReg4_center_20}</font></p><p class="sub-p"><font color="blue">${sumDay_center_20 + sumDay4_center_20}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_19 + sumReg4_center_19}</font></p><p class="sub-p"><font color="blue">${sumDay_center_19 + sumDay4_center_19}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_18 + sumReg4_center_18}</font></p><p class="sub-p"><font color="blue">${sumDay_center_18 + sumDay4_center_18}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_17 + sumReg4_center_17}</font></p><p class="sub-p"><font color="blue">${sumDay_center_17 + sumDay4_center_17}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_16 + sumReg4_center_16}</font></p><p class="sub-p"><font color="blue">${sumDay_center_16 + sumDay4_center_16}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_15 + sumReg4_center_15}</font></p><p class="sub-p"><font color="blue">${sumDay_center_15 + sumDay4_center_15}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_14 + sumReg4_center_14}</font></p><p class="sub-p"><font color="blue">${sumDay_center_14 + sumDay4_center_14}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_13 + sumReg4_center_13}</font></p><p class="sub-p"><font color="blue">${sumDay_center_13 + sumDay4_center_13}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_12 + sumReg4_center_12}</font></p><p class="sub-p"><font color="blue">${sumDay_center_12 + sumDay4_center_12}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_11 + sumReg4_center_11}</font></p><p class="sub-p"><font color="blue">${sumDay_center_11 + sumDay4_center_11}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_10 + sumReg4_center_10}</font></p><p class="sub-p"><font color="blue">${sumDay_center_10 + sumDay4_center_10}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_09 + sumReg4_center_09}</font></p><p class="sub-p"><font color="blue">${sumDay_center_09 + sumDay4_center_09}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_08 + sumReg4_center_08}</font></p><p class="sub-p"><font color="blue">${sumDay_center_08 + sumDay4_center_08}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_07 + sumReg4_center_07}</font></p><p class="sub-p"><font color="blue">${sumDay_center_07 + sumDay4_center_07}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_06 + sumReg4_center_06}</font></p><p class="sub-p"><font color="blue">${sumDay_center_06 + sumDay4_center_06}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_05 + sumReg4_center_05}</font></p><p class="sub-p"><font color="blue">${sumDay_center_05 + sumDay4_center_05}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_04 + sumReg4_center_04}</font></p><p class="sub-p"><font color="blue">${sumDay_center_04 + sumDay4_center_04}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_03 + sumReg4_center_03}</font></p><p class="sub-p"><font color="blue">${sumDay_center_03 + sumDay4_center_03}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_02 + sumReg4_center_02}</font></p><p class="sub-p"><font color="blue">${sumDay_center_02 + sumDay4_center_02}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_01 + sumReg4_center_01}</font></p><p class="sub-p"><font color="blue">${sumDay_center_01 + sumDay4_center_01}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_center_00 + sumReg4_center_00}</font></p><p class="sub-p"><font color="blue">${sumDay_center_00 + sumDay4_center_00}</font></p>
		               	</th>                
		            </tr>
		            <!-- 전체합계 끝 -->
		            </tbody>
		        </table>
		    </div>
		</div>
	</div>
</div>
