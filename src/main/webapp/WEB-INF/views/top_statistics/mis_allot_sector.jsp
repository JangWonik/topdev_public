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
		                <col width="179">
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
		                <th class="border-right">부문 (인원)</th>
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
		                <col width="44">
		            </colgroup>
		            <tbody>
		            <c:forEach var="sector" items="${TeamSectorListVO}" varStatus="status">
		            	<!-- 서면심사 포함한 부문 시작 -->
		            	<c:if test="${sector.team_sector eq 1 || sector.team_sector eq 2 || sector.team_sector eq 3 || sector.team_sector eq 7}">
		            	<tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">		                    
		                    <td>${sector.team_sector_val} (${sector.member_cnt})</td>
		                    <td class="border-right">
		                    	<p>수임</p><p class="sub-p">종결</p>
		                    </td>
		                    <td class="border-right">		                    	
		                    	<c:set var="sub1_regSum" value="${sector.reg_29+sector.reg_28+sector.reg_27+sector.reg_26+sector.reg_25+sector.reg_24+sector.reg_23+sector.reg_22+sector.reg_21+sector.reg_20+sector.reg_19+sector.reg_18+sector.reg_17+sector.reg_16+sector.reg_15+sector.reg_14+sector.reg_13+sector.reg_12+sector.reg_11+sector.reg_10+sector.reg_09+sector.reg_08+sector.reg_07+sector.reg_06+sector.reg_05+sector.reg_04+sector.reg_03+sector.reg_02+sector.reg_01+sector.reg_00-sector.reg_wc_29-sector.reg_wc_28-sector.reg_wc_27-sector.reg_wc_26-sector.reg_wc_25-sector.reg_wc_24-sector.reg_wc_23-sector.reg_wc_22-sector.reg_wc_21-sector.reg_wc_20-sector.reg_wc_19-sector.reg_wc_18-sector.reg_wc_17-sector.reg_wc_16-sector.reg_wc_15-sector.reg_wc_14-sector.reg_wc_13-sector.reg_wc_12-sector.reg_wc_11-sector.reg_wc_10-sector.reg_wc_09-sector.reg_wc_08-sector.reg_wc_07-sector.reg_wc_06-sector.reg_wc_05-sector.reg_wc_04-sector.reg_wc_03-sector.reg_wc_02-sector.reg_wc_01-sector.reg_wc_00}"/>
		                    	<c:set var="sub1_daySum" value="${sector.day_29+sector.day_28+sector.day_27+sector.day_26+sector.day_25+sector.day_24+sector.day_23+sector.day_22+sector.day_21+sector.day_20+sector.day_19+sector.day_18+sector.day_17+sector.day_16+sector.day_15+sector.day_14+sector.day_13+sector.day_12+sector.day_11+sector.day_10+sector.day_09+sector.day_08+sector.day_07+sector.day_06+sector.day_05+sector.day_04+sector.day_03+sector.day_02+sector.day_01+sector.day_00-sector.day_wc_29-sector.day_wc_28-sector.day_wc_27-sector.day_wc_26-sector.day_wc_25-sector.day_wc_24-sector.day_wc_23-sector.day_wc_22-sector.day_wc_21-sector.day_wc_20-sector.day_wc_19-sector.day_wc_18-sector.day_wc_17-sector.day_wc_16-sector.day_wc_15-sector.day_wc_14-sector.day_wc_13-sector.day_wc_12-sector.day_wc_11-sector.day_wc_10-sector.day_wc_09-sector.day_wc_08-sector.day_wc_07-sector.day_wc_06-sector.day_wc_05-sector.day_wc_04-sector.day_wc_03-sector.day_wc_02-sector.day_wc_01-sector.day_wc_00}"/>
		                    	<p>${sub1_regSum}</p><p class="sub-p">${sub1_daySum}</p>
		                  	</td>
		                  	<!-- 1인당 건수 시작 -->
		                  	<td class="border-right" bgcolor="#faebd7">
		                  		<c:choose>		                  			
		                  			<c:when test="${ sector.member_cnt eq 0}">
		                  				<p>0</p><p class="sub-p">0</p>
		                  			</c:when>
		                  			<c:when test="${ sub1_regSum eq 0 && sub1_daySum ne 0}">
		                  				<p>0</p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / sector.member_cnt}" pattern="#.#"/></p>
		                  			</c:when>
		                  			<c:when test="${ sub1_regSum ne 0 && sub1_daySum eq 0}">
		                  				<p><fmt:formatNumber value="${sub1_regSum / sector.member_cnt}" pattern="#.#"/></p><p class="sub-p">0</p>
		                  			</c:when>
		                  			<c:otherwise>
		                  				<p><fmt:formatNumber value="${sub1_regSum / sector.member_cnt}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / sector.member_cnt}" pattern="#.#"/></p>
		                  			</c:otherwise>
		                  		</c:choose>		                  		
		                  	</td>
		                  	<!-- 1인당 건수 끝 -->		                  	
		                    <!-- 1인당 미결 시작 -->
							<td class="border-right" bgcolor="#faebd7">
								<c:choose>		                  			
									<c:when test="${ sector.member_cnt eq 0}">
										<p>0</p>
									</c:when>
									<c:when test="${ (sector.reg_mi - sector.reg_wc_mi) eq 0 }">
										<p>0</p>
									</c:when>		                  			
									<c:otherwise>
										<p><fmt:formatNumber value="${(sector.reg_mi - sector.reg_wc_mi) / sector.member_cnt}" pattern="#.#"/></p>
									</c:otherwise>
								</c:choose>		                  		
							</td>
							<!-- 1인당 미결 끝 -->
							<td bgcolor="#faebd7">
		                    	<font color="">${sector.reg_mi - sector.reg_wc_mi}</font>
		                    </td>
		                    <td bgcolor="#faebd7">
		                   		${sector.reg_y - sector.reg_wc_y}
		                 	</td>
		                    <td bgcolor="#faebd7">
		                    	${sector.cls_m - sector.cls_wc_m}
		                   	</td>
		                    <td class="border-right" bgcolor="#faebd7">
		                    	${sector.cls_y - sector.cls_wc_y}
		                	</td>
		                    <td>
		                    	<p>${sector.reg_29 - sector.reg_wc_29}</p><p class="sub-p">${sector.day_29 - sector.day_wc_29}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_28 - sector.reg_wc_28}</p><p class="sub-p">${sector.day_28 - sector.day_wc_28}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_27 - sector.reg_wc_27}</p><p class="sub-p">${sector.day_27 - sector.day_wc_27}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_26 - sector.reg_wc_26}</p><p class="sub-p">${sector.day_26 - sector.day_wc_26}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_25 - sector.reg_wc_25}</p><p class="sub-p">${sector.day_25 - sector.day_wc_25}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_24 - sector.reg_wc_24}</p><p class="sub-p">${sector.day_24 - sector.day_wc_24}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_23 - sector.reg_wc_23}</p><p class="sub-p">${sector.day_23 - sector.day_wc_23}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_22 - sector.reg_wc_22}</p><p class="sub-p">${sector.day_22 - sector.day_wc_22}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_21 - sector.reg_wc_21}</p><p class="sub-p">${sector.day_21 - sector.day_wc_21}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_20 - sector.reg_wc_20}</p><p class="sub-p">${sector.day_20 - sector.day_wc_20}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_19 - sector.reg_wc_19}</p><p class="sub-p">${sector.day_19 - sector.day_wc_19}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_18 - sector.reg_wc_18}</p><p class="sub-p">${sector.day_18 - sector.day_wc_18}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_17 - sector.reg_wc_17}</p><p class="sub-p">${sector.day_17 - sector.day_wc_17}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_16 - sector.reg_wc_16}</p><p class="sub-p">${sector.day_16 - sector.day_wc_16}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_15 - sector.reg_wc_15}</p><p class="sub-p">${sector.day_15 - sector.day_wc_15}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_14 - sector.reg_wc_14}</p><p class="sub-p">${sector.day_14 - sector.day_wc_14}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_13 - sector.reg_wc_13}</p><p class="sub-p">${sector.day_13 - sector.day_wc_13}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_12 - sector.reg_wc_12}</p><p class="sub-p">${sector.day_12 - sector.day_wc_12}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_11 - sector.reg_wc_11}</p><p class="sub-p">${sector.day_11 - sector.day_wc_11}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_10 - sector.reg_wc_10}</p><p class="sub-p">${sector.day_10 - sector.day_wc_10}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_09 - sector.reg_wc_09}</p><p class="sub-p">${sector.day_09 - sector.day_wc_09}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_08 - sector.reg_wc_08}</p><p class="sub-p">${sector.day_08 - sector.day_wc_08}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_07 - sector.reg_wc_07}</p><p class="sub-p">${sector.day_07 - sector.day_wc_07}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_06 - sector.reg_wc_06}</p><p class="sub-p">${sector.day_06 - sector.day_wc_06}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_05 - sector.reg_wc_05}</p><p class="sub-p">${sector.day_05 - sector.day_wc_05}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_04 - sector.reg_wc_04}</p><p class="sub-p">${sector.day_04 - sector.day_wc_04}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_03 - sector.reg_wc_03}</p><p class="sub-p">${sector.day_03 - sector.day_wc_03}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_02 - sector.reg_wc_02}</p><p class="sub-p">${sector.day_02 - sector.day_wc_02}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_01 - sector.reg_wc_01}</p><p class="sub-p">${sector.day_01 - sector.day_wc_01}</p>
		                    </td>
		                    <td>
		                    	<p>${sector.reg_00 - sector.reg_wc_00}</p><p class="sub-p">${sector.day_00 - sector.day_wc_00}</p>
		                    </td>                    
		                </tr>		            	
		                <!-- 서면심사 포함한 부문 끝 -->
		                
		                <!-- 정책, 재물, 배상부문 소계 계산시작 -->
						<c:set var="sumMember_cnt_mid" value="${sumMember_cnt_mid + sector.member_cnt}" />
						
		                <c:set var="sumReg_mid_29" value="${sumReg_mid_29 + sector.reg_29 - sector.reg_wc_29}" />
		                <c:set var="sumReg_mid_28" value="${sumReg_mid_28 + sector.reg_28 - sector.reg_wc_28}" />
		                <c:set var="sumReg_mid_27" value="${sumReg_mid_27 + sector.reg_27 - sector.reg_wc_27}" />
		                <c:set var="sumReg_mid_26" value="${sumReg_mid_26 + sector.reg_26 - sector.reg_wc_26}" />
		                <c:set var="sumReg_mid_25" value="${sumReg_mid_25 + sector.reg_25 - sector.reg_wc_25}" />
		                <c:set var="sumReg_mid_24" value="${sumReg_mid_24 + sector.reg_24 - sector.reg_wc_24}" />
		                <c:set var="sumReg_mid_23" value="${sumReg_mid_23 + sector.reg_23 - sector.reg_wc_23}" />
		                <c:set var="sumReg_mid_22" value="${sumReg_mid_22 + sector.reg_22 - sector.reg_wc_22}" />
		                <c:set var="sumReg_mid_21" value="${sumReg_mid_21 + sector.reg_21 - sector.reg_wc_21}" />
		                <c:set var="sumReg_mid_20" value="${sumReg_mid_20 + sector.reg_20 - sector.reg_wc_20}" />
		                <c:set var="sumReg_mid_19" value="${sumReg_mid_19 + sector.reg_19 - sector.reg_wc_19}" />
		                <c:set var="sumReg_mid_18" value="${sumReg_mid_18 + sector.reg_18 - sector.reg_wc_18}" />
		                <c:set var="sumReg_mid_17" value="${sumReg_mid_17 + sector.reg_17 - sector.reg_wc_17}" />
		                <c:set var="sumReg_mid_16" value="${sumReg_mid_16 + sector.reg_16 - sector.reg_wc_16}" />
		                <c:set var="sumReg_mid_15" value="${sumReg_mid_15 + sector.reg_15 - sector.reg_wc_15}" />
		                <c:set var="sumReg_mid_14" value="${sumReg_mid_14 + sector.reg_14 - sector.reg_wc_14}" />
		                <c:set var="sumReg_mid_13" value="${sumReg_mid_13 + sector.reg_13 - sector.reg_wc_13}" />
		                <c:set var="sumReg_mid_12" value="${sumReg_mid_12 + sector.reg_12 - sector.reg_wc_12}" />
		                <c:set var="sumReg_mid_11" value="${sumReg_mid_11 + sector.reg_11 - sector.reg_wc_11}" />
		                <c:set var="sumReg_mid_10" value="${sumReg_mid_10 + sector.reg_10 - sector.reg_wc_10}" />
		                <c:set var="sumReg_mid_09" value="${sumReg_mid_09 + sector.reg_09 - sector.reg_wc_09}" />
		                <c:set var="sumReg_mid_08" value="${sumReg_mid_08 + sector.reg_08 - sector.reg_wc_08}" />
		                <c:set var="sumReg_mid_07" value="${sumReg_mid_07 + sector.reg_07 - sector.reg_wc_07}" />
		                <c:set var="sumReg_mid_06" value="${sumReg_mid_06 + sector.reg_06 - sector.reg_wc_06}" />
		                <c:set var="sumReg_mid_05" value="${sumReg_mid_05 + sector.reg_05 - sector.reg_wc_05}" />
		                <c:set var="sumReg_mid_04" value="${sumReg_mid_04 + sector.reg_04 - sector.reg_wc_04}" />
		                <c:set var="sumReg_mid_03" value="${sumReg_mid_03 + sector.reg_03 - sector.reg_wc_03}" />
		                <c:set var="sumReg_mid_02" value="${sumReg_mid_02 + sector.reg_02 - sector.reg_wc_02}" />
		                <c:set var="sumReg_mid_01" value="${sumReg_mid_01 + sector.reg_01 - sector.reg_wc_01}" />
		                <c:set var="sumReg_mid_00" value="${sumReg_mid_00 + sector.reg_00 - sector.reg_wc_00}" />
		                <c:set var="sumReg_mid_sum" value="${sumReg_mid_sum + sub1_regSum}" />		                
		                		                
		                <c:set var="sumDay_mid_29" value="${sumDay_mid_29 + sector.day_29 - sector.day_wc_29}" />
		                <c:set var="sumDay_mid_28" value="${sumDay_mid_28 + sector.day_28 - sector.day_wc_28}" />
		                <c:set var="sumDay_mid_27" value="${sumDay_mid_27 + sector.day_27 - sector.day_wc_27}" />
		                <c:set var="sumDay_mid_26" value="${sumDay_mid_26 + sector.day_26 - sector.day_wc_26}" />
		                <c:set var="sumDay_mid_25" value="${sumDay_mid_25 + sector.day_25 - sector.day_wc_25}" />
		                <c:set var="sumDay_mid_24" value="${sumDay_mid_24 + sector.day_24 - sector.day_wc_24}" />
		                <c:set var="sumDay_mid_23" value="${sumDay_mid_23 + sector.day_23 - sector.day_wc_23}" />
		                <c:set var="sumDay_mid_22" value="${sumDay_mid_22 + sector.day_22 - sector.day_wc_22}" />
		                <c:set var="sumDay_mid_21" value="${sumDay_mid_21 + sector.day_21 - sector.day_wc_21}" />
		                <c:set var="sumDay_mid_20" value="${sumDay_mid_20 + sector.day_20 - sector.day_wc_20}" />
		                <c:set var="sumDay_mid_19" value="${sumDay_mid_19 + sector.day_19 - sector.day_wc_19}" />
		                <c:set var="sumDay_mid_18" value="${sumDay_mid_18 + sector.day_18 - sector.day_wc_18}" />
		                <c:set var="sumDay_mid_17" value="${sumDay_mid_17 + sector.day_17 - sector.day_wc_17}" />
		                <c:set var="sumDay_mid_16" value="${sumDay_mid_16 + sector.day_16 - sector.day_wc_16}" />
		                <c:set var="sumDay_mid_15" value="${sumDay_mid_15 + sector.day_15 - sector.day_wc_15}" />
		                <c:set var="sumDay_mid_14" value="${sumDay_mid_14 + sector.day_14 - sector.day_wc_14}" />
		                <c:set var="sumDay_mid_13" value="${sumDay_mid_13 + sector.day_13 - sector.day_wc_13}" />
		                <c:set var="sumDay_mid_12" value="${sumDay_mid_12 + sector.day_12 - sector.day_wc_12}" />
		                <c:set var="sumDay_mid_11" value="${sumDay_mid_11 + sector.day_11 - sector.day_wc_11}" />
		                <c:set var="sumDay_mid_10" value="${sumDay_mid_10 + sector.day_10 - sector.day_wc_10}" />
		                <c:set var="sumDay_mid_09" value="${sumDay_mid_09 + sector.day_09 - sector.day_wc_09}" />
		                <c:set var="sumDay_mid_08" value="${sumDay_mid_08 + sector.day_08 - sector.day_wc_08}" />
		                <c:set var="sumDay_mid_07" value="${sumDay_mid_07 + sector.day_07 - sector.day_wc_07}" />
		                <c:set var="sumDay_mid_06" value="${sumDay_mid_06 + sector.day_06 - sector.day_wc_06}" />
		                <c:set var="sumDay_mid_05" value="${sumDay_mid_05 + sector.day_05 - sector.day_wc_05}" />
		                <c:set var="sumDay_mid_04" value="${sumDay_mid_04 + sector.day_04 - sector.day_wc_04}" />
		                <c:set var="sumDay_mid_03" value="${sumDay_mid_03 + sector.day_03 - sector.day_wc_03}" />
		                <c:set var="sumDay_mid_02" value="${sumDay_mid_02 + sector.day_02 - sector.day_wc_02}" />
		                <c:set var="sumDay_mid_01" value="${sumDay_mid_01 + sector.day_01 - sector.day_wc_01}" />
		                <c:set var="sumDay_mid_00" value="${sumDay_mid_00 + sector.day_00 - sector.day_wc_00}" />                
		                <c:set var="sumDay_mid_sum" value="${sumDay_mid_sum + sub1_daySum}" />
		                
		                <c:set var="sumReg_mid_y" value="${sumReg_mid_y + sector.reg_y - sector.reg_wc_y}" />
		                <c:set var="sumCls_mid_m" value="${sumCls_mid_m + sector.cls_m - sector.cls_wc_m}" />
		                <c:set var="sumCls_mid_y" value="${sumCls_mid_y + sector.cls_y - sector.cls_wc_y}" />
		                <c:set var="sumReg_mid_mi" value="${sumReg_mid_mi + sector.reg_mi - sector.reg_wc_mi}" />		                		                
		                <!-- 정책, 재물, 배상부문 소계 계산 끝 -->
		                </c:if>
		                
		                <!-- 총 합산 계산시작 -->
		                <c:set var="sumMember_cnt" value="${sumMember_cnt + sector.member_cnt}" />
		                
		                <c:set var="sumReg_29" value="${sumReg_29 + sector.reg_29}" />
						<c:set var="sumReg_28" value="${sumReg_28 + sector.reg_28}" />
						<c:set var="sumReg_27" value="${sumReg_27 + sector.reg_27}" />
						<c:set var="sumReg_26" value="${sumReg_26 + sector.reg_26}" />
						<c:set var="sumReg_25" value="${sumReg_25 + sector.reg_25}" />
						<c:set var="sumReg_24" value="${sumReg_24 + sector.reg_24}" />
						<c:set var="sumReg_23" value="${sumReg_23 + sector.reg_23}" />
						<c:set var="sumReg_22" value="${sumReg_22 + sector.reg_22}" />
						<c:set var="sumReg_21" value="${sumReg_21 + sector.reg_21}" />
						<c:set var="sumReg_20" value="${sumReg_20 + sector.reg_20}" />
						<c:set var="sumReg_19" value="${sumReg_19 + sector.reg_19}" />
						<c:set var="sumReg_18" value="${sumReg_18 + sector.reg_18}" />
						<c:set var="sumReg_17" value="${sumReg_17 + sector.reg_17}" />
						<c:set var="sumReg_16" value="${sumReg_16 + sector.reg_16}" />
						<c:set var="sumReg_15" value="${sumReg_15 + sector.reg_15}" />
						<c:set var="sumReg_14" value="${sumReg_14 + sector.reg_14}" />
						<c:set var="sumReg_13" value="${sumReg_13 + sector.reg_13}" />
						<c:set var="sumReg_12" value="${sumReg_12 + sector.reg_12}" />
						<c:set var="sumReg_11" value="${sumReg_11 + sector.reg_11}" />
						<c:set var="sumReg_10" value="${sumReg_10 + sector.reg_10}" />
						<c:set var="sumReg_09" value="${sumReg_09 + sector.reg_09}" />
						<c:set var="sumReg_08" value="${sumReg_08 + sector.reg_08}" />
						<c:set var="sumReg_07" value="${sumReg_07 + sector.reg_07}" />
						<c:set var="sumReg_06" value="${sumReg_06 + sector.reg_06}" />
						<c:set var="sumReg_05" value="${sumReg_05 + sector.reg_05}" />
						<c:set var="sumReg_04" value="${sumReg_04 + sector.reg_04}" />
						<c:set var="sumReg_03" value="${sumReg_03 + sector.reg_03}" />
						<c:set var="sumReg_02" value="${sumReg_02 + sector.reg_02}" />
						<c:set var="sumReg_01" value="${sumReg_01 + sector.reg_01}" />
						<c:set var="sumReg_00" value="${sumReg_00 + sector.reg_00}" />
						<c:set var="sumReg_sum" value="${sumReg_sum + sector.reg_29+sector.reg_28+sector.reg_27+sector.reg_26+sector.reg_25+sector.reg_24+sector.reg_23+sector.reg_22+sector.reg_21+sector.reg_20+sector.reg_19+sector.reg_18+sector.reg_17+sector.reg_16+sector.reg_15+sector.reg_14+sector.reg_13+sector.reg_12+sector.reg_11+sector.reg_10+sector.reg_09+sector.reg_08+sector.reg_07+sector.reg_06+sector.reg_05+sector.reg_04+sector.reg_03+sector.reg_02+sector.reg_01+sector.reg_00}" />		                
									
						<c:set var="sumDay_29" value="${sumDay_29 + sector.day_29}" />
						<c:set var="sumDay_28" value="${sumDay_28 + sector.day_28}" />
						<c:set var="sumDay_27" value="${sumDay_27 + sector.day_27}" />
						<c:set var="sumDay_26" value="${sumDay_26 + sector.day_26}" />
						<c:set var="sumDay_25" value="${sumDay_25 + sector.day_25}" />
						<c:set var="sumDay_24" value="${sumDay_24 + sector.day_24}" />
						<c:set var="sumDay_23" value="${sumDay_23 + sector.day_23}" />
						<c:set var="sumDay_22" value="${sumDay_22 + sector.day_22}" />
						<c:set var="sumDay_21" value="${sumDay_21 + sector.day_21}" />
						<c:set var="sumDay_20" value="${sumDay_20 + sector.day_20}" />
						<c:set var="sumDay_19" value="${sumDay_19 + sector.day_19}" />
						<c:set var="sumDay_18" value="${sumDay_18 + sector.day_18}" />
						<c:set var="sumDay_17" value="${sumDay_17 + sector.day_17}" />
						<c:set var="sumDay_16" value="${sumDay_16 + sector.day_16}" />
						<c:set var="sumDay_15" value="${sumDay_15 + sector.day_15}" />
						<c:set var="sumDay_14" value="${sumDay_14 + sector.day_14}" />
						<c:set var="sumDay_13" value="${sumDay_13 + sector.day_13}" />
						<c:set var="sumDay_12" value="${sumDay_12 + sector.day_12}" />
						<c:set var="sumDay_11" value="${sumDay_11 + sector.day_11}" />
						<c:set var="sumDay_10" value="${sumDay_10 + sector.day_10}" />
						<c:set var="sumDay_09" value="${sumDay_09 + sector.day_09}" />
						<c:set var="sumDay_08" value="${sumDay_08 + sector.day_08}" />
						<c:set var="sumDay_07" value="${sumDay_07 + sector.day_07}" />
						<c:set var="sumDay_06" value="${sumDay_06 + sector.day_06}" />
						<c:set var="sumDay_05" value="${sumDay_05 + sector.day_05}" />
						<c:set var="sumDay_04" value="${sumDay_04 + sector.day_04}" />
						<c:set var="sumDay_03" value="${sumDay_03 + sector.day_03}" />
						<c:set var="sumDay_02" value="${sumDay_02 + sector.day_02}" />
						<c:set var="sumDay_01" value="${sumDay_01 + sector.day_01}" />
						<c:set var="sumDay_00" value="${sumDay_00 + sector.day_00}" />                
						<c:set var="sumDay_sum" value="${sumDay_sum + sector.day_29+sector.day_28+sector.day_27+sector.day_26+sector.day_25+sector.day_24+sector.day_23+sector.day_22+sector.day_21+sector.day_20+sector.day_19+sector.day_18+sector.day_17+sector.day_16+sector.day_15+sector.day_14+sector.day_13+sector.day_12+sector.day_11+sector.day_10+sector.day_09+sector.day_08+sector.day_07+sector.day_06+sector.day_05+sector.day_04+sector.day_03+sector.day_02+sector.day_01+sector.day_00}" />
						
						<c:set var="sumReg_y" value="${sumReg_y + sector.reg_y}" />
						<c:set var="sumCls_m" value="${sumCls_m + sector.cls_m}" />
						<c:set var="sumCls_y" value="${sumCls_y + sector.cls_y}" />
						<c:set var="sumReg_mi" value="${sumReg_mi + sector.reg_mi}" />		                
		                <!-- 총 합산 계산 끝 -->
		            </c:forEach>
		            <!-- 정책, 재물, 배상부문 소계 표시 시작 -->
		            <tr bgcolor="#E7ECF1">
		                <td class="border-right" colspan="2">부문(조사) 소계 (${sumMember_cnt_mid})</td>
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
		            <!-- 정책, 재물, 배상부문 소계 표시 끝 -->
		            
		            <!-- 물보험심사부분 시작 -->
		            <c:forEach var="sector" items="${TeamSectorListVO}" varStatus="status">	            	
	            		<c:if test="${sector.team_sector eq 4}">
		            		<tr>
		            			<td>${sector.team_sector_val} (${sector.member_cnt})</td>
			                    <td class="border-right">
			                    	<p>수임</p><p class="sub-p">종결</p>
			                    </td>
			                    <td class="border-right">		                    	
			                    	<c:set var="sub1_regSum" value="${sector.reg_29+sector.reg_28+sector.reg_27+sector.reg_26+sector.reg_25+sector.reg_24+sector.reg_23+sector.reg_22+sector.reg_21+sector.reg_20+sector.reg_19+sector.reg_18+sector.reg_17+sector.reg_16+sector.reg_15+sector.reg_14+sector.reg_13+sector.reg_12+sector.reg_11+sector.reg_10+sector.reg_09+sector.reg_08+sector.reg_07+sector.reg_06+sector.reg_05+sector.reg_04+sector.reg_03+sector.reg_02+sector.reg_01+sector.reg_00}"/>
			                    	<c:set var="sub1_daySum" value="${sector.day_29+sector.day_28+sector.day_27+sector.day_26+sector.day_25+sector.day_24+sector.day_23+sector.day_22+sector.day_21+sector.day_20+sector.day_19+sector.day_18+sector.day_17+sector.day_16+sector.day_15+sector.day_14+sector.day_13+sector.day_12+sector.day_11+sector.day_10+sector.day_09+sector.day_08+sector.day_07+sector.day_06+sector.day_05+sector.day_04+sector.day_03+sector.day_02+sector.day_01+sector.day_00}"/>
			                    	<p>${sub1_regSum}</p><p class="sub-p">${sub1_daySum}</p>
			                  	</td>
			                  	<!-- 1인당 건수 시작 -->
			                  	<td class="border-right" bgcolor="#faebd7">
			                  		<c:choose>		                  			
			                  			<c:when test="${ sector.member_cnt eq 0}">
			                  				<p>0</p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:when test="${ sub1_regSum eq 0 && sub1_daySum ne 0}">
			                  				<p>0</p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / sector.member_cnt}" pattern="#.#"/></p>
			                  			</c:when>
			                  			<c:when test="${ sub1_regSum ne 0 && sub1_daySum eq 0}">
			                  				<p><fmt:formatNumber value="${sub1_regSum / sector.member_cnt}" pattern="#.#"/></p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:otherwise>
			                  				<p><fmt:formatNumber value="${sub1_regSum / sector.member_cnt}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / sector.member_cnt}" pattern="#.#"/></p>
			                  			</c:otherwise>
			                  		</c:choose>		                  		
			                  	</td>
			                  	<!-- 1인당 건수 끝 -->			                  	
			                    <!-- 1인당 미결 시작 -->
								<td class="border-right" bgcolor="#faebd7">
									<c:choose>		                  			
										<c:when test="${ sector.member_cnt eq 0}">
											<p>0</p>
										</c:when>
										<c:when test="${ sector.reg_mi eq 0 }">
											<p>0</p>
										</c:when>		                  			
										<c:otherwise>
											<p><fmt:formatNumber value="${sector.reg_mi / sector.member_cnt}" pattern="#.#"/></p>
										</c:otherwise>
									</c:choose>		                  		
								</td>
								<!-- 1인당 미결 끝 -->
								<td bgcolor="#faebd7">
			                    	<font color="">${sector.reg_mi}</font>
			                    </td>
			                    <td bgcolor="#faebd7">
			                   		${sector.reg_y}
			                 	</td>
			                    <td bgcolor="#faebd7">
			                    	${sector.cls_m}
			                   	</td>
			                    <td class="border-right" bgcolor="#faebd7">
			                    	${sector.cls_y}
			                	</td>		                    
			                    <td>
									<p>${sector.reg_29}</p><p class="sub-p">${sector.day_29}</p>
								</td>
								<td>
									<p>${sector.reg_28}</p><p class="sub-p">${sector.day_28}</p>
								</td>
								<td>
									<p>${sector.reg_27}</p><p class="sub-p">${sector.day_27}</p>
								</td>
								<td>
									<p>${sector.reg_26}</p><p class="sub-p">${sector.day_26}</p>
								</td>
								<td>
									<p>${sector.reg_25}</p><p class="sub-p">${sector.day_25}</p>
								</td>
								<td>
									<p>${sector.reg_24}</p><p class="sub-p">${sector.day_24}</p>
								</td>
								<td>
									<p>${sector.reg_23}</p><p class="sub-p">${sector.day_23}</p>
								</td>
								<td>
									<p>${sector.reg_22}</p><p class="sub-p">${sector.day_22}</p>
								</td>
								<td>
									<p>${sector.reg_21}</p><p class="sub-p">${sector.day_21}</p>
								</td>
								<td>
									<p>${sector.reg_20}</p><p class="sub-p">${sector.day_20}</p>
								</td>
								<td>
									<p>${sector.reg_19}</p><p class="sub-p">${sector.day_19}</p>
								</td>
								<td>
									<p>${sector.reg_18}</p><p class="sub-p">${sector.day_18}</p>
								</td>
								<td>
									<p>${sector.reg_17}</p><p class="sub-p">${sector.day_17}</p>
								</td>
								<td>
									<p>${sector.reg_16}</p><p class="sub-p">${sector.day_16}</p>
								</td>
								<td>
									<p>${sector.reg_15}</p><p class="sub-p">${sector.day_15}</p>
								</td>
								<td>
									<p>${sector.reg_14}</p><p class="sub-p">${sector.day_14}</p>
								</td>
								<td>
									<p>${sector.reg_13}</p><p class="sub-p">${sector.day_13}</p>
								</td>
								<td>
									<p>${sector.reg_12}</p><p class="sub-p">${sector.day_12}</p>
								</td>
								<td>
									<p>${sector.reg_11}</p><p class="sub-p">${sector.day_11}</p>
								</td>
								<td>
									<p>${sector.reg_10}</p><p class="sub-p">${sector.day_10}</p>
								</td>
								<td>
									<p>${sector.reg_09}</p><p class="sub-p">${sector.day_09}</p>
								</td>
								<td>
									<p>${sector.reg_08}</p><p class="sub-p">${sector.day_08}</p>
								</td>
								<td>
									<p>${sector.reg_07}</p><p class="sub-p">${sector.day_07}</p>
								</td>
								<td>
									<p>${sector.reg_06}</p><p class="sub-p">${sector.day_06}</p>
								</td>
								<td>
									<p>${sector.reg_05}</p><p class="sub-p">${sector.day_05}</p>
								</td>
								<td>
									<p>${sector.reg_04}</p><p class="sub-p">${sector.day_04}</p>
								</td>
								<td>
									<p>${sector.reg_03}</p><p class="sub-p">${sector.day_03}</p>
								</td>
								<td>
									<p>${sector.reg_02}</p><p class="sub-p">${sector.day_02}</p>
								</td>
								<td>
									<p>${sector.reg_01}</p><p class="sub-p">${sector.day_01}</p>
								</td>
								<td>
									<p>${sector.reg_00}</p><p class="sub-p">${sector.day_00}</p>
								</td>    			
		            		</tr>
		            		<tr bgcolor="#E7ECF1">
		            			<td class="border-right" colspan="2">${sector.team_sector_val} 소계 (${sector.member_cnt})</td>
		            			<td class="border-right">		                    	
			                    	<c:set var="sub1_regSum" value="${sector.reg_29+sector.reg_28+sector.reg_27+sector.reg_26+sector.reg_25+sector.reg_24+sector.reg_23+sector.reg_22+sector.reg_21+sector.reg_20+sector.reg_19+sector.reg_18+sector.reg_17+sector.reg_16+sector.reg_15+sector.reg_14+sector.reg_13+sector.reg_12+sector.reg_11+sector.reg_10+sector.reg_09+sector.reg_08+sector.reg_07+sector.reg_06+sector.reg_05+sector.reg_04+sector.reg_03+sector.reg_02+sector.reg_01+sector.reg_00}"/>
			                    	<c:set var="sub1_daySum" value="${sector.day_29+sector.day_28+sector.day_27+sector.day_26+sector.day_25+sector.day_24+sector.day_23+sector.day_22+sector.day_21+sector.day_20+sector.day_19+sector.day_18+sector.day_17+sector.day_16+sector.day_15+sector.day_14+sector.day_13+sector.day_12+sector.day_11+sector.day_10+sector.day_09+sector.day_08+sector.day_07+sector.day_06+sector.day_05+sector.day_04+sector.day_03+sector.day_02+sector.day_01+sector.day_00}"/>
			                    	<p>${sub1_regSum}</p><p class="sub-p">${sub1_daySum}</p>
			                  	</td>
			                  	<td class="border-right">
				               		<p><fmt:formatNumber value="${sub1_regSum / sector.member_cnt}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / sector.member_cnt}" pattern="#.#"/></p>
				               	</td>				               	
			                    <td class="border-right">
				               		<p><fmt:formatNumber value="${sector.reg_mi / sector.member_cnt}" pattern="#.#"/></p>
				               	</td>
				               	<td>
			                    	<font color="">${sector.reg_mi}</font>
			                    </td>
			                    <td>
			                   		${sector.reg_y}
			                 	</td>
			                    <td>
			                    	${sector.cls_m}
			                   	</td>
			                    <td class="border-right">
			                    	${sector.cls_y}
			                	</td>			                    
			                    <td>
									<p>${sector.reg_29}</p><p class="sub-p">${sector.day_29}</p>
								</td>
								<td>
									<p>${sector.reg_28}</p><p class="sub-p">${sector.day_28}</p>
								</td>
								<td>
									<p>${sector.reg_27}</p><p class="sub-p">${sector.day_27}</p>
								</td>
								<td>
									<p>${sector.reg_26}</p><p class="sub-p">${sector.day_26}</p>
								</td>
								<td>
									<p>${sector.reg_25}</p><p class="sub-p">${sector.day_25}</p>
								</td>
								<td>
									<p>${sector.reg_24}</p><p class="sub-p">${sector.day_24}</p>
								</td>
								<td>
									<p>${sector.reg_23}</p><p class="sub-p">${sector.day_23}</p>
								</td>
								<td>
									<p>${sector.reg_22}</p><p class="sub-p">${sector.day_22}</p>
								</td>
								<td>
									<p>${sector.reg_21}</p><p class="sub-p">${sector.day_21}</p>
								</td>
								<td>
									<p>${sector.reg_20}</p><p class="sub-p">${sector.day_20}</p>
								</td>
								<td>
									<p>${sector.reg_19}</p><p class="sub-p">${sector.day_19}</p>
								</td>
								<td>
									<p>${sector.reg_18}</p><p class="sub-p">${sector.day_18}</p>
								</td>
								<td>
									<p>${sector.reg_17}</p><p class="sub-p">${sector.day_17}</p>
								</td>
								<td>
									<p>${sector.reg_16}</p><p class="sub-p">${sector.day_16}</p>
								</td>
								<td>
									<p>${sector.reg_15}</p><p class="sub-p">${sector.day_15}</p>
								</td>
								<td>
									<p>${sector.reg_14}</p><p class="sub-p">${sector.day_14}</p>
								</td>
								<td>
									<p>${sector.reg_13}</p><p class="sub-p">${sector.day_13}</p>
								</td>
								<td>
									<p>${sector.reg_12}</p><p class="sub-p">${sector.day_12}</p>
								</td>
								<td>
									<p>${sector.reg_11}</p><p class="sub-p">${sector.day_11}</p>
								</td>
								<td>
									<p>${sector.reg_10}</p><p class="sub-p">${sector.day_10}</p>
								</td>
								<td>
									<p>${sector.reg_09}</p><p class="sub-p">${sector.day_09}</p>
								</td>
								<td>
									<p>${sector.reg_08}</p><p class="sub-p">${sector.day_08}</p>
								</td>
								<td>
									<p>${sector.reg_07}</p><p class="sub-p">${sector.day_07}</p>
								</td>
								<td>
									<p>${sector.reg_06}</p><p class="sub-p">${sector.day_06}</p>
								</td>
								<td>
									<p>${sector.reg_05}</p><p class="sub-p">${sector.day_05}</p>
								</td>
								<td>
									<p>${sector.reg_04}</p><p class="sub-p">${sector.day_04}</p>
								</td>
								<td>
									<p>${sector.reg_03}</p><p class="sub-p">${sector.day_03}</p>
								</td>
								<td>
									<p>${sector.reg_02}</p><p class="sub-p">${sector.day_02}</p>
								</td>
								<td>
									<p>${sector.reg_01}</p><p class="sub-p">${sector.day_01}</p>
								</td>
								<td>
									<p>${sector.reg_00}</p><p class="sub-p">${sector.day_00}</p>
								</td>	                    
		            		</tr>
	            		</c:if>
	            	</c:forEach>
		            <!-- 물보험심사부분 끝 -->
		            
		            <!-- 부문(심사) 시작 -->
		            <c:forEach var="sector" items="${TeamSectorListVO}" varStatus="status">
	            		<c:if test="${sector.wc_sector_flag eq 1 && sector.team_sector ne 9}">
	            			<tr>
		            			<td>${sector.team_sector_val}(서면심사)</td>
			                    <td class="border-right">
			                    	<p>수임</p><p class="sub-p">종결</p>
			                    </td>
			                    <td class="border-right">		                    	
			                    	<c:set var="sub1_wc_regSum" value="${sector.reg_wc_29+sector.reg_wc_28+sector.reg_wc_27+sector.reg_wc_26+sector.reg_wc_25+sector.reg_wc_24+sector.reg_wc_23+sector.reg_wc_22+sector.reg_wc_21+sector.reg_wc_20+sector.reg_wc_19+sector.reg_wc_18+sector.reg_wc_17+sector.reg_wc_16+sector.reg_wc_15+sector.reg_wc_14+sector.reg_wc_13+sector.reg_wc_12+sector.reg_wc_11+sector.reg_wc_10+sector.reg_wc_09+sector.reg_wc_08+sector.reg_wc_07+sector.reg_wc_06+sector.reg_wc_05+sector.reg_wc_04+sector.reg_wc_03+sector.reg_wc_02+sector.reg_wc_01+sector.reg_wc_00}"/>
			                    	<c:set var="sub1_wc_daySum" value="${sector.day_wc_29+sector.day_wc_28+sector.day_wc_27+sector.day_wc_26+sector.day_wc_25+sector.day_wc_24+sector.day_wc_23+sector.day_wc_22+sector.day_wc_21+sector.day_wc_20+sector.day_wc_19+sector.day_wc_18+sector.day_wc_17+sector.day_wc_16+sector.day_wc_15+sector.day_wc_14+sector.day_wc_13+sector.day_wc_12+sector.day_wc_11+sector.day_wc_10+sector.day_wc_09+sector.day_wc_08+sector.day_wc_07+sector.day_wc_06+sector.day_wc_05+sector.day_wc_04+sector.day_wc_03+sector.day_wc_02+sector.day_wc_01+sector.day_wc_00}"/>
			                    	<p>${sub1_wc_regSum}</p><p class="sub-p">${sub1_wc_daySum}</p>
			                  	</td>
			                  	<td class="border-right" bgcolor="#faebd7">
			                  		-
			                  	</td>			                  	
			                    <td class="border-right" bgcolor="#faebd7">
			                  		-
			                  	</td>
			                  	<td bgcolor="#faebd7">
			                    	<font color="">${sector.reg_wc_mi}</font>
			                    </td>
			                    <td bgcolor="#faebd7">
			                   		${sector.reg_wc_y}
			                 	</td>
			                    <td bgcolor="#faebd7">
			                    	${sector.cls_wc_m}
			                   	</td>
			                    <td class="border-right" bgcolor="#faebd7">
			                    	${sector.cls_wc_y}
			                	</td>
			                    <td>
									<p>${sector.reg_wc_29}</p><p class="sub-p">${sector.day_wc_29}</p>
								</td>
								<td>
									<p>${sector.reg_wc_28}</p><p class="sub-p">${sector.day_wc_28}</p>
								</td>
								<td>
									<p>${sector.reg_wc_27}</p><p class="sub-p">${sector.day_wc_27}</p>
								</td>
								<td>
									<p>${sector.reg_wc_26}</p><p class="sub-p">${sector.day_wc_26}</p>
								</td>
								<td>
									<p>${sector.reg_wc_25}</p><p class="sub-p">${sector.day_wc_25}</p>
								</td>
								<td>
									<p>${sector.reg_wc_24}</p><p class="sub-p">${sector.day_wc_24}</p>
								</td>
								<td>
									<p>${sector.reg_wc_23}</p><p class="sub-p">${sector.day_wc_23}</p>
								</td>
								<td>
									<p>${sector.reg_wc_22}</p><p class="sub-p">${sector.day_wc_22}</p>
								</td>
								<td>
									<p>${sector.reg_wc_21}</p><p class="sub-p">${sector.day_wc_21}</p>
								</td>
								<td>
									<p>${sector.reg_wc_20}</p><p class="sub-p">${sector.day_wc_20}</p>
								</td>
								<td>
									<p>${sector.reg_wc_19}</p><p class="sub-p">${sector.day_wc_19}</p>
								</td>
								<td>
									<p>${sector.reg_wc_18}</p><p class="sub-p">${sector.day_wc_18}</p>
								</td>
								<td>
									<p>${sector.reg_wc_17}</p><p class="sub-p">${sector.day_wc_17}</p>
								</td>
								<td>
									<p>${sector.reg_wc_16}</p><p class="sub-p">${sector.day_wc_16}</p>
								</td>
								<td>
									<p>${sector.reg_wc_15}</p><p class="sub-p">${sector.day_wc_15}</p>
								</td>
								<td>
									<p>${sector.reg_wc_14}</p><p class="sub-p">${sector.day_wc_14}</p>
								</td>
								<td>
									<p>${sector.reg_wc_13}</p><p class="sub-p">${sector.day_wc_13}</p>
								</td>
								<td>
									<p>${sector.reg_wc_12}</p><p class="sub-p">${sector.day_wc_12}</p>
								</td>
								<td>
									<p>${sector.reg_wc_11}</p><p class="sub-p">${sector.day_wc_11}</p>
								</td>
								<td>
									<p>${sector.reg_wc_10}</p><p class="sub-p">${sector.day_wc_10}</p>
								</td>
								<td>
									<p>${sector.reg_wc_09}</p><p class="sub-p">${sector.day_wc_09}</p>
								</td>
								<td>
									<p>${sector.reg_wc_08}</p><p class="sub-p">${sector.day_wc_08}</p>
								</td>
								<td>
									<p>${sector.reg_wc_07}</p><p class="sub-p">${sector.day_wc_07}</p>
								</td>
								<td>
									<p>${sector.reg_wc_06}</p><p class="sub-p">${sector.day_wc_06}</p>
								</td>
								<td>
									<p>${sector.reg_wc_05}</p><p class="sub-p">${sector.day_wc_05}</p>
								</td>
								<td>
									<p>${sector.reg_wc_04}</p><p class="sub-p">${sector.day_wc_04}</p>
								</td>
								<td>
									<p>${sector.reg_wc_03}</p><p class="sub-p">${sector.day_wc_03}</p>
								</td>
								<td>
									<p>${sector.reg_wc_02}</p><p class="sub-p">${sector.day_wc_02}</p>
								</td>
								<td>
									<p>${sector.reg_wc_01}</p><p class="sub-p">${sector.day_wc_01}</p>
								</td>
								<td>
									<p>${sector.reg_wc_00}</p><p class="sub-p">${sector.day_wc_00}</p>
								</td>	                    		            			
		            		</tr>
		            		<!-- 부문심사 소계 계산 시작 -->
		            		<c:set var="sumReg_wc_29" value="${sumReg_wc_29 + sector.reg_wc_29}" />
							<c:set var="sumReg_wc_28" value="${sumReg_wc_28 + sector.reg_wc_28}" />
							<c:set var="sumReg_wc_27" value="${sumReg_wc_27 + sector.reg_wc_27}" />
							<c:set var="sumReg_wc_26" value="${sumReg_wc_26 + sector.reg_wc_26}" />
							<c:set var="sumReg_wc_25" value="${sumReg_wc_25 + sector.reg_wc_25}" />
							<c:set var="sumReg_wc_24" value="${sumReg_wc_24 + sector.reg_wc_24}" />
							<c:set var="sumReg_wc_23" value="${sumReg_wc_23 + sector.reg_wc_23}" />
							<c:set var="sumReg_wc_22" value="${sumReg_wc_22 + sector.reg_wc_22}" />
							<c:set var="sumReg_wc_21" value="${sumReg_wc_21 + sector.reg_wc_21}" />
							<c:set var="sumReg_wc_20" value="${sumReg_wc_20 + sector.reg_wc_20}" />
							<c:set var="sumReg_wc_19" value="${sumReg_wc_19 + sector.reg_wc_19}" />
							<c:set var="sumReg_wc_18" value="${sumReg_wc_18 + sector.reg_wc_18}" />
							<c:set var="sumReg_wc_17" value="${sumReg_wc_17 + sector.reg_wc_17}" />
							<c:set var="sumReg_wc_16" value="${sumReg_wc_16 + sector.reg_wc_16}" />
							<c:set var="sumReg_wc_15" value="${sumReg_wc_15 + sector.reg_wc_15}" />
							<c:set var="sumReg_wc_14" value="${sumReg_wc_14 + sector.reg_wc_14}" />
							<c:set var="sumReg_wc_13" value="${sumReg_wc_13 + sector.reg_wc_13}" />
							<c:set var="sumReg_wc_12" value="${sumReg_wc_12 + sector.reg_wc_12}" />
							<c:set var="sumReg_wc_11" value="${sumReg_wc_11 + sector.reg_wc_11}" />
							<c:set var="sumReg_wc_10" value="${sumReg_wc_10 + sector.reg_wc_10}" />
							<c:set var="sumReg_wc_09" value="${sumReg_wc_09 + sector.reg_wc_09}" />
							<c:set var="sumReg_wc_08" value="${sumReg_wc_08 + sector.reg_wc_08}" />
							<c:set var="sumReg_wc_07" value="${sumReg_wc_07 + sector.reg_wc_07}" />
							<c:set var="sumReg_wc_06" value="${sumReg_wc_06 + sector.reg_wc_06}" />
							<c:set var="sumReg_wc_05" value="${sumReg_wc_05 + sector.reg_wc_05}" />
							<c:set var="sumReg_wc_04" value="${sumReg_wc_04 + sector.reg_wc_04}" />
							<c:set var="sumReg_wc_03" value="${sumReg_wc_03 + sector.reg_wc_03}" />
							<c:set var="sumReg_wc_02" value="${sumReg_wc_02 + sector.reg_wc_02}" />
							<c:set var="sumReg_wc_01" value="${sumReg_wc_01 + sector.reg_wc_01}" />
							<c:set var="sumReg_wc_00" value="${sumReg_wc_00 + sector.reg_wc_00}" />
							<c:set var="sumReg_wc_sum" value="${sumReg_wc_sum + sub1_wc_regSum}" />		                
										
							<c:set var="sumDay_wc_29" value="${sumDay_wc_29 + sector.day_wc_29}" />
							<c:set var="sumDay_wc_28" value="${sumDay_wc_28 + sector.day_wc_28}" />
							<c:set var="sumDay_wc_27" value="${sumDay_wc_27 + sector.day_wc_27}" />
							<c:set var="sumDay_wc_26" value="${sumDay_wc_26 + sector.day_wc_26}" />
							<c:set var="sumDay_wc_25" value="${sumDay_wc_25 + sector.day_wc_25}" />
							<c:set var="sumDay_wc_24" value="${sumDay_wc_24 + sector.day_wc_24}" />
							<c:set var="sumDay_wc_23" value="${sumDay_wc_23 + sector.day_wc_23}" />
							<c:set var="sumDay_wc_22" value="${sumDay_wc_22 + sector.day_wc_22}" />
							<c:set var="sumDay_wc_21" value="${sumDay_wc_21 + sector.day_wc_21}" />
							<c:set var="sumDay_wc_20" value="${sumDay_wc_20 + sector.day_wc_20}" />
							<c:set var="sumDay_wc_19" value="${sumDay_wc_19 + sector.day_wc_19}" />
							<c:set var="sumDay_wc_18" value="${sumDay_wc_18 + sector.day_wc_18}" />
							<c:set var="sumDay_wc_17" value="${sumDay_wc_17 + sector.day_wc_17}" />
							<c:set var="sumDay_wc_16" value="${sumDay_wc_16 + sector.day_wc_16}" />
							<c:set var="sumDay_wc_15" value="${sumDay_wc_15 + sector.day_wc_15}" />
							<c:set var="sumDay_wc_14" value="${sumDay_wc_14 + sector.day_wc_14}" />
							<c:set var="sumDay_wc_13" value="${sumDay_wc_13 + sector.day_wc_13}" />
							<c:set var="sumDay_wc_12" value="${sumDay_wc_12 + sector.day_wc_12}" />
							<c:set var="sumDay_wc_11" value="${sumDay_wc_11 + sector.day_wc_11}" />
							<c:set var="sumDay_wc_10" value="${sumDay_wc_10 + sector.day_wc_10}" />
							<c:set var="sumDay_wc_09" value="${sumDay_wc_09 + sector.day_wc_09}" />
							<c:set var="sumDay_wc_08" value="${sumDay_wc_08 + sector.day_wc_08}" />
							<c:set var="sumDay_wc_07" value="${sumDay_wc_07 + sector.day_wc_07}" />
							<c:set var="sumDay_wc_06" value="${sumDay_wc_06 + sector.day_wc_06}" />
							<c:set var="sumDay_wc_05" value="${sumDay_wc_05 + sector.day_wc_05}" />
							<c:set var="sumDay_wc_04" value="${sumDay_wc_04 + sector.day_wc_04}" />
							<c:set var="sumDay_wc_03" value="${sumDay_wc_03 + sector.day_wc_03}" />
							<c:set var="sumDay_wc_02" value="${sumDay_wc_02 + sector.day_wc_02}" />
							<c:set var="sumDay_wc_01" value="${sumDay_wc_01 + sector.day_wc_01}" />
							<c:set var="sumDay_wc_00" value="${sumDay_wc_00 + sector.day_wc_00}" />                
							<c:set var="sumDay_wc_sum" value="${sumDay_wc_sum + sub1_wc_daySum}" />
							
							<c:set var="sumReg_wc_y" value="${sumReg_wc_y + sector.reg_wc_y}" />
							<c:set var="sumCls_wc_m" value="${sumCls_wc_m + sector.cls_wc_m}" />
							<c:set var="sumCls_wc_y" value="${sumCls_wc_y + sector.cls_wc_y}" />
							<c:set var="sumReg_wc_mi" value="${sumReg_wc_mi + sector.reg_wc_mi}" />		            		
		            		<!-- 부문심사 소계 계산 끝 -->
	            		</c:if>
            		</c:forEach>
            		<!-- 부문 소계 표시 시작 -->
            		<tr bgcolor="#E7ECF1">
		                <td class="border-right" colspan="2">부문(서면심사) 소계</td>
		                <td class="border-right">
		                	<p>${sumReg_wc_sum}</p><p class="sub-p">${sumDay_wc_sum}</p>
		               	</td>
		               	<td class="border-right">
		                	<p>-</p><p class="sub-p">-</p>
		               	</td>		               	
		               	<td class="border-right">
		                	<p>-</p>
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
            		<!-- 부문 소계 표시 끝 -->		            
		            <!-- 부문(심사) 끝 -->
		            
		            <!-- 기타부문 시작 -->
		            <c:forEach var="sector" items="${TeamSectorListVO}" varStatus="status">	            	
	            		<c:if test="${sector.team_sector eq 9}">
		            		<tr>
		            			<td>${sector.team_sector_val} (${sector.member_cnt})</td>
			                    <td class="border-right">
			                    	<p>수임</p><p class="sub-p">종결</p>
			                    </td>
			                    <td class="border-right">		                    	
			                    	<c:set var="sub1_regSum" value="${sector.reg_29+sector.reg_28+sector.reg_27+sector.reg_26+sector.reg_25+sector.reg_24+sector.reg_23+sector.reg_22+sector.reg_21+sector.reg_20+sector.reg_19+sector.reg_18+sector.reg_17+sector.reg_16+sector.reg_15+sector.reg_14+sector.reg_13+sector.reg_12+sector.reg_11+sector.reg_10+sector.reg_09+sector.reg_08+sector.reg_07+sector.reg_06+sector.reg_05+sector.reg_04+sector.reg_03+sector.reg_02+sector.reg_01+sector.reg_00}"/>
			                    	<c:set var="sub1_daySum" value="${sector.day_29+sector.day_28+sector.day_27+sector.day_26+sector.day_25+sector.day_24+sector.day_23+sector.day_22+sector.day_21+sector.day_20+sector.day_19+sector.day_18+sector.day_17+sector.day_16+sector.day_15+sector.day_14+sector.day_13+sector.day_12+sector.day_11+sector.day_10+sector.day_09+sector.day_08+sector.day_07+sector.day_06+sector.day_05+sector.day_04+sector.day_03+sector.day_02+sector.day_01+sector.day_00}"/>
			                    	<p>${sub1_regSum}</p><p class="sub-p">${sub1_daySum}</p>
			                  	</td>
			                  	<!-- 1인당 건수 시작 -->
			                  	<td class="border-right" bgcolor="#faebd7">
			                  		<c:choose>		                  			
			                  			<c:when test="${ sector.member_cnt eq 0}">
			                  				<p>0</p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:when test="${ sub1_regSum eq 0 && sub1_daySum ne 0}">
			                  				<p>0</p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / sector.member_cnt}" pattern="#.#"/></p>
			                  			</c:when>
			                  			<c:when test="${ sub1_regSum ne 0 && sub1_daySum eq 0}">
			                  				<p><fmt:formatNumber value="${sub1_regSum / sector.member_cnt}" pattern="#.#"/></p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:otherwise>
			                  				<p><fmt:formatNumber value="${sub1_regSum / sector.member_cnt}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / sector.member_cnt}" pattern="#.#"/></p>
			                  			</c:otherwise>
			                  		</c:choose>		                  		
			                  	</td>
			                  	<!-- 1인당 건수 끝 -->			                  			           
			                    <!-- 1인당 미결 시작 -->
								<td class="border-right" bgcolor="#faebd7">
									<c:choose>		                  			
										<c:when test="${ sector.member_cnt eq 0}">
											<p>0</p>
										</c:when>
										<c:when test="${ sector.reg_mi eq 0 }">
											<p>0</p>
										</c:when>		                  			
										<c:otherwise>
											<p><fmt:formatNumber value="${sector.reg_mi / sector.member_cnt}" pattern="#.#"/></p>
										</c:otherwise>
									</c:choose>		                  		
								</td>
								<!-- 1인당 미결 끝 -->
								<td bgcolor="#faebd7">
			                    	<font color="">${sector.reg_mi}</font>
			                    </td>
			                    <td bgcolor="#faebd7">
			                   		${sector.reg_y}
			                 	</td>
			                    <td bgcolor="#faebd7">
			                    	${sector.cls_m}
			                   	</td>
			                    <td class="border-right" bgcolor="#faebd7">
			                    	${sector.cls_y}
			                	</td>        
			                    <td>
									<p>${sector.reg_29}</p><p class="sub-p">${sector.day_29}</p>
								</td>
								<td>
									<p>${sector.reg_28}</p><p class="sub-p">${sector.day_28}</p>
								</td>
								<td>
									<p>${sector.reg_27}</p><p class="sub-p">${sector.day_27}</p>
								</td>
								<td>
									<p>${sector.reg_26}</p><p class="sub-p">${sector.day_26}</p>
								</td>
								<td>
									<p>${sector.reg_25}</p><p class="sub-p">${sector.day_25}</p>
								</td>
								<td>
									<p>${sector.reg_24}</p><p class="sub-p">${sector.day_24}</p>
								</td>
								<td>
									<p>${sector.reg_23}</p><p class="sub-p">${sector.day_23}</p>
								</td>
								<td>
									<p>${sector.reg_22}</p><p class="sub-p">${sector.day_22}</p>
								</td>
								<td>
									<p>${sector.reg_21}</p><p class="sub-p">${sector.day_21}</p>
								</td>
								<td>
									<p>${sector.reg_20}</p><p class="sub-p">${sector.day_20}</p>
								</td>
								<td>
									<p>${sector.reg_19}</p><p class="sub-p">${sector.day_19}</p>
								</td>
								<td>
									<p>${sector.reg_18}</p><p class="sub-p">${sector.day_18}</p>
								</td>
								<td>
									<p>${sector.reg_17}</p><p class="sub-p">${sector.day_17}</p>
								</td>
								<td>
									<p>${sector.reg_16}</p><p class="sub-p">${sector.day_16}</p>
								</td>
								<td>
									<p>${sector.reg_15}</p><p class="sub-p">${sector.day_15}</p>
								</td>
								<td>
									<p>${sector.reg_14}</p><p class="sub-p">${sector.day_14}</p>
								</td>
								<td>
									<p>${sector.reg_13}</p><p class="sub-p">${sector.day_13}</p>
								</td>
								<td>
									<p>${sector.reg_12}</p><p class="sub-p">${sector.day_12}</p>
								</td>
								<td>
									<p>${sector.reg_11}</p><p class="sub-p">${sector.day_11}</p>
								</td>
								<td>
									<p>${sector.reg_10}</p><p class="sub-p">${sector.day_10}</p>
								</td>
								<td>
									<p>${sector.reg_09}</p><p class="sub-p">${sector.day_09}</p>
								</td>
								<td>
									<p>${sector.reg_08}</p><p class="sub-p">${sector.day_08}</p>
								</td>
								<td>
									<p>${sector.reg_07}</p><p class="sub-p">${sector.day_07}</p>
								</td>
								<td>
									<p>${sector.reg_06}</p><p class="sub-p">${sector.day_06}</p>
								</td>
								<td>
									<p>${sector.reg_05}</p><p class="sub-p">${sector.day_05}</p>
								</td>
								<td>
									<p>${sector.reg_04}</p><p class="sub-p">${sector.day_04}</p>
								</td>
								<td>
									<p>${sector.reg_03}</p><p class="sub-p">${sector.day_03}</p>
								</td>
								<td>
									<p>${sector.reg_02}</p><p class="sub-p">${sector.day_02}</p>
								</td>
								<td>
									<p>${sector.reg_01}</p><p class="sub-p">${sector.day_01}</p>
								</td>
								<td>
									<p>${sector.reg_00}</p><p class="sub-p">${sector.day_00}</p>
								</td>	                    		            			
		            		</tr>
		            		<tr bgcolor="#E7ECF1">
		            			<td class="border-right" colspan="2">${sector.team_sector_val} 소계 (${sector.member_cnt})</td>
		            			<td class="border-right">		                    	
			                    	<c:set var="sub1_regSum" value="${sector.reg_29+sector.reg_28+sector.reg_27+sector.reg_26+sector.reg_25+sector.reg_24+sector.reg_23+sector.reg_22+sector.reg_21+sector.reg_20+sector.reg_19+sector.reg_18+sector.reg_17+sector.reg_16+sector.reg_15+sector.reg_14+sector.reg_13+sector.reg_12+sector.reg_11+sector.reg_10+sector.reg_09+sector.reg_08+sector.reg_07+sector.reg_06+sector.reg_05+sector.reg_04+sector.reg_03+sector.reg_02+sector.reg_01+sector.reg_00}"/>
			                    	<c:set var="sub1_daySum" value="${sector.day_29+sector.day_28+sector.day_27+sector.day_26+sector.day_25+sector.day_24+sector.day_23+sector.day_22+sector.day_21+sector.day_20+sector.day_19+sector.day_18+sector.day_17+sector.day_16+sector.day_15+sector.day_14+sector.day_13+sector.day_12+sector.day_11+sector.day_10+sector.day_09+sector.day_08+sector.day_07+sector.day_06+sector.day_05+sector.day_04+sector.day_03+sector.day_02+sector.day_01+sector.day_00}"/>
			                    	<p>${sub1_regSum}</p><p class="sub-p">${sub1_daySum}</p>
			                  	</td>
			                  	<td class="border-right">
				               		<p><fmt:formatNumber value="${sub1_regSum / sector.member_cnt}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / sector.member_cnt}" pattern="#.#"/></p>
				               	</td>				               	
			                    <td class="border-right">
				               		<p><fmt:formatNumber value="${sector.reg_mi / sector.member_cnt}" pattern="#.#"/></p>
				               	</td>
				               	<td>
			                    	<font color="">${sector.reg_mi}</font>
			                    </td>
			                    <td>
			                   		${sector.reg_y}
			                 	</td>
			                    <td>
			                    	${sector.cls_m}
			                   	</td>
			                    <td class="border-right">
			                    	${sector.cls_y}
			                	</td>			                  				                    
			                    <td>
									<p>${sector.reg_29}</p><p class="sub-p">${sector.day_29}</p>
								</td>
								<td>
									<p>${sector.reg_28}</p><p class="sub-p">${sector.day_28}</p>
								</td>
								<td>
									<p>${sector.reg_27}</p><p class="sub-p">${sector.day_27}</p>
								</td>
								<td>
									<p>${sector.reg_26}</p><p class="sub-p">${sector.day_26}</p>
								</td>
								<td>
									<p>${sector.reg_25}</p><p class="sub-p">${sector.day_25}</p>
								</td>
								<td>
									<p>${sector.reg_24}</p><p class="sub-p">${sector.day_24}</p>
								</td>
								<td>
									<p>${sector.reg_23}</p><p class="sub-p">${sector.day_23}</p>
								</td>
								<td>
									<p>${sector.reg_22}</p><p class="sub-p">${sector.day_22}</p>
								</td>
								<td>
									<p>${sector.reg_21}</p><p class="sub-p">${sector.day_21}</p>
								</td>
								<td>
									<p>${sector.reg_20}</p><p class="sub-p">${sector.day_20}</p>
								</td>
								<td>
									<p>${sector.reg_19}</p><p class="sub-p">${sector.day_19}</p>
								</td>
								<td>
									<p>${sector.reg_18}</p><p class="sub-p">${sector.day_18}</p>
								</td>
								<td>
									<p>${sector.reg_17}</p><p class="sub-p">${sector.day_17}</p>
								</td>
								<td>
									<p>${sector.reg_16}</p><p class="sub-p">${sector.day_16}</p>
								</td>
								<td>
									<p>${sector.reg_15}</p><p class="sub-p">${sector.day_15}</p>
								</td>
								<td>
									<p>${sector.reg_14}</p><p class="sub-p">${sector.day_14}</p>
								</td>
								<td>
									<p>${sector.reg_13}</p><p class="sub-p">${sector.day_13}</p>
								</td>
								<td>
									<p>${sector.reg_12}</p><p class="sub-p">${sector.day_12}</p>
								</td>
								<td>
									<p>${sector.reg_11}</p><p class="sub-p">${sector.day_11}</p>
								</td>
								<td>
									<p>${sector.reg_10}</p><p class="sub-p">${sector.day_10}</p>
								</td>
								<td>
									<p>${sector.reg_09}</p><p class="sub-p">${sector.day_09}</p>
								</td>
								<td>
									<p>${sector.reg_08}</p><p class="sub-p">${sector.day_08}</p>
								</td>
								<td>
									<p>${sector.reg_07}</p><p class="sub-p">${sector.day_07}</p>
								</td>
								<td>
									<p>${sector.reg_06}</p><p class="sub-p">${sector.day_06}</p>
								</td>
								<td>
									<p>${sector.reg_05}</p><p class="sub-p">${sector.day_05}</p>
								</td>
								<td>
									<p>${sector.reg_04}</p><p class="sub-p">${sector.day_04}</p>
								</td>
								<td>
									<p>${sector.reg_03}</p><p class="sub-p">${sector.day_03}</p>
								</td>
								<td>
									<p>${sector.reg_02}</p><p class="sub-p">${sector.day_02}</p>
								</td>
								<td>
									<p>${sector.reg_01}</p><p class="sub-p">${sector.day_01}</p>
								</td>
								<td>
									<p>${sector.reg_00}</p><p class="sub-p">${sector.day_00}</p>
								</td>    			
		            		</tr>
	            		</c:if>
	            	</c:forEach>		            
		            <!-- 기타부문 끝 -->
		            
		            <tr bgcolor="#E7ECF1">
		                <th class="border-right" colspan="2">물보험 소계 (${sumMember_cnt})</th>
		                <th class="border-right">
		                	<p>${sumReg_sum}</p><p class="sub-p">${sumDay_sum}</p>
		               	</th>
		               	<th class="border-right">		                	
		                	<p><fmt:formatNumber value="${sumReg_sum / sumMember_cnt}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sumDay_sum / sumMember_cnt}" pattern="#.#"/></p>
		               	</th>		               	
		               	<th class="border-right">		                	
		                	<p><fmt:formatNumber value="${sumReg_mi / sumMember_cnt}" pattern="#.#"/></p>
		               	</th>
		               	<th><font color="">${sumReg_mi}</font></th>
		               	<th>${sumReg_y}</th>
		                <th>${sumCls_m}</th>
		                <th class="border-right">${sumCls_y}</th>
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
		            <!-- 인보험 조사 심사 시작 -->
		            <c:forEach var="sector4" items="${TeamSector4ListVO}" varStatus="status">
	            		<c:if test="${sector4.team_sector eq 5 || sector4.team_sector eq 6}">
	            			<tr>
		            			<td>${sector4.team_sector_val} (${sector4.member_cnt})</td>
			                    <td class="border-right">
			                    	<p>수임</p><p class="sub-p">종결</p>
			                    </td>
			                    <td class="border-right">		                    	
			                    	<c:set var="sub1_regSum" value="${sector4.reg_29+sector4.reg_28+sector4.reg_27+sector4.reg_26+sector4.reg_25+sector4.reg_24+sector4.reg_23+sector4.reg_22+sector4.reg_21+sector4.reg_20+sector4.reg_19+sector4.reg_18+sector4.reg_17+sector4.reg_16+sector4.reg_15+sector4.reg_14+sector4.reg_13+sector4.reg_12+sector4.reg_11+sector4.reg_10+sector4.reg_09+sector4.reg_08+sector4.reg_07+sector4.reg_06+sector4.reg_05+sector4.reg_04+sector4.reg_03+sector4.reg_02+sector4.reg_01+sector4.reg_00}"/>
			                    	<c:set var="sub1_daySum" value="${sector4.day_29+sector4.day_28+sector4.day_27+sector4.day_26+sector4.day_25+sector4.day_24+sector4.day_23+sector4.day_22+sector4.day_21+sector4.day_20+sector4.day_19+sector4.day_18+sector4.day_17+sector4.day_16+sector4.day_15+sector4.day_14+sector4.day_13+sector4.day_12+sector4.day_11+sector4.day_10+sector4.day_09+sector4.day_08+sector4.day_07+sector4.day_06+sector4.day_05+sector4.day_04+sector4.day_03+sector4.day_02+sector4.day_01+sector4.day_00}"/>
			                    	<p>${sub1_regSum}</p><p class="sub-p">${sub1_daySum}</p>
			                  	</td>
			                  	<!-- 1인당 건수 시작 -->
			                  	<td class="border-right" bgcolor="#faebd7">
			                  		<c:choose>		                  			
			                  			<c:when test="${ sector4.member_cnt eq 0}">
			                  				<p>0</p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:when test="${ sub1_regSum eq 0 && sub1_daySum ne 0}">
			                  				<p>0</p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / sector4.member_cnt}" pattern="#.#"/></p>
			                  			</c:when>
			                  			<c:when test="${ sub1_regSum ne 0 && sub1_daySum eq 0}">
			                  				<p><fmt:formatNumber value="${sub1_regSum / sector4.member_cnt}" pattern="#.#"/></p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:otherwise>
			                  				<p><fmt:formatNumber value="${sub1_regSum / sector4.member_cnt}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / sector4.member_cnt}" pattern="#.#"/></p>
			                  			</c:otherwise>
			                  		</c:choose>		                  		
			                  	</td>
			                  	<!-- 1인당 건수 끝 -->			                  	
			                    <!-- 1인당 미결 시작 -->
								<td class="border-right" bgcolor="#faebd7">
									<c:choose>		                  			
										<c:when test="${ sector4.member_cnt eq 0}">
											<p>0</p>
										</c:when>
										<c:when test="${ sector4.reg_mi eq 0 }">
											<p>0</p>
										</c:when>		                  			
										<c:otherwise>
											<p><fmt:formatNumber value="${sector4.reg_mi / sector4.member_cnt}" pattern="#.#"/></p>
										</c:otherwise>
									</c:choose>		                  		
								</td>
								<!-- 1인당 미결 끝 -->
								<td bgcolor="#faebd7">
			                    	<font color="">${sector4.reg_mi}</font>
			                    </td>	                    
			                    <td bgcolor="#faebd7">
			                   		${sector4.reg_y}
			                 	</td>
			                    <td bgcolor="#faebd7">
			                    	${sector4.cls_m}
			                   	</td>
			                    <td class="border-right" bgcolor="#faebd7">
			                    	${sector4.cls_y}
			                	</td>
			                    <td>
									<p>${sector4.reg_29}</p><p class="sub-p">${sector4.day_29}</p>
								</td>
								<td>
									<p>${sector4.reg_28}</p><p class="sub-p">${sector4.day_28}</p>
								</td>
								<td>
									<p>${sector4.reg_27}</p><p class="sub-p">${sector4.day_27}</p>
								</td>
								<td>
									<p>${sector4.reg_26}</p><p class="sub-p">${sector4.day_26}</p>
								</td>
								<td>
									<p>${sector4.reg_25}</p><p class="sub-p">${sector4.day_25}</p>
								</td>
								<td>
									<p>${sector4.reg_24}</p><p class="sub-p">${sector4.day_24}</p>
								</td>
								<td>
									<p>${sector4.reg_23}</p><p class="sub-p">${sector4.day_23}</p>
								</td>
								<td>
									<p>${sector4.reg_22}</p><p class="sub-p">${sector4.day_22}</p>
								</td>
								<td>
									<p>${sector4.reg_21}</p><p class="sub-p">${sector4.day_21}</p>
								</td>
								<td>
									<p>${sector4.reg_20}</p><p class="sub-p">${sector4.day_20}</p>
								</td>
								<td>
									<p>${sector4.reg_19}</p><p class="sub-p">${sector4.day_19}</p>
								</td>
								<td>
									<p>${sector4.reg_18}</p><p class="sub-p">${sector4.day_18}</p>
								</td>
								<td>
									<p>${sector4.reg_17}</p><p class="sub-p">${sector4.day_17}</p>
								</td>
								<td>
									<p>${sector4.reg_16}</p><p class="sub-p">${sector4.day_16}</p>
								</td>
								<td>
									<p>${sector4.reg_15}</p><p class="sub-p">${sector4.day_15}</p>
								</td>
								<td>
									<p>${sector4.reg_14}</p><p class="sub-p">${sector4.day_14}</p>
								</td>
								<td>
									<p>${sector4.reg_13}</p><p class="sub-p">${sector4.day_13}</p>
								</td>
								<td>
									<p>${sector4.reg_12}</p><p class="sub-p">${sector4.day_12}</p>
								</td>
								<td>
									<p>${sector4.reg_11}</p><p class="sub-p">${sector4.day_11}</p>
								</td>
								<td>
									<p>${sector4.reg_10}</p><p class="sub-p">${sector4.day_10}</p>
								</td>
								<td>
									<p>${sector4.reg_09}</p><p class="sub-p">${sector4.day_09}</p>
								</td>
								<td>
									<p>${sector4.reg_08}</p><p class="sub-p">${sector4.day_08}</p>
								</td>
								<td>
									<p>${sector4.reg_07}</p><p class="sub-p">${sector4.day_07}</p>
								</td>
								<td>
									<p>${sector4.reg_06}</p><p class="sub-p">${sector4.day_06}</p>
								</td>
								<td>
									<p>${sector4.reg_05}</p><p class="sub-p">${sector4.day_05}</p>
								</td>
								<td>
									<p>${sector4.reg_04}</p><p class="sub-p">${sector4.day_04}</p>
								</td>
								<td>
									<p>${sector4.reg_03}</p><p class="sub-p">${sector4.day_03}</p>
								</td>
								<td>
									<p>${sector4.reg_02}</p><p class="sub-p">${sector4.day_02}</p>
								</td>
								<td>
									<p>${sector4.reg_01}</p><p class="sub-p">${sector4.day_01}</p>
								</td>
								<td>
									<p>${sector4.reg_00}</p><p class="sub-p">${sector4.day_00}</p>
								</td>	                    		            			
		            		</tr>
		            		<!-- 인보험 조사심사 소계 계산 시작 -->
		            		<c:set var="sumMember4_cnt_mid" value="${sumMember4_cnt_mid + sector4.member_cnt}" />
		            		
		            		<c:set var="sumReg4_mid_29" value="${sumReg4_mid_29 + sector4.reg_29}" />
							<c:set var="sumReg4_mid_28" value="${sumReg4_mid_28 + sector4.reg_28}" />
							<c:set var="sumReg4_mid_27" value="${sumReg4_mid_27 + sector4.reg_27}" />
							<c:set var="sumReg4_mid_26" value="${sumReg4_mid_26 + sector4.reg_26}" />
							<c:set var="sumReg4_mid_25" value="${sumReg4_mid_25 + sector4.reg_25}" />
							<c:set var="sumReg4_mid_24" value="${sumReg4_mid_24 + sector4.reg_24}" />
							<c:set var="sumReg4_mid_23" value="${sumReg4_mid_23 + sector4.reg_23}" />
							<c:set var="sumReg4_mid_22" value="${sumReg4_mid_22 + sector4.reg_22}" />
							<c:set var="sumReg4_mid_21" value="${sumReg4_mid_21 + sector4.reg_21}" />
							<c:set var="sumReg4_mid_20" value="${sumReg4_mid_20 + sector4.reg_20}" />
							<c:set var="sumReg4_mid_19" value="${sumReg4_mid_19 + sector4.reg_19}" />
							<c:set var="sumReg4_mid_18" value="${sumReg4_mid_18 + sector4.reg_18}" />
							<c:set var="sumReg4_mid_17" value="${sumReg4_mid_17 + sector4.reg_17}" />
							<c:set var="sumReg4_mid_16" value="${sumReg4_mid_16 + sector4.reg_16}" />
							<c:set var="sumReg4_mid_15" value="${sumReg4_mid_15 + sector4.reg_15}" />
							<c:set var="sumReg4_mid_14" value="${sumReg4_mid_14 + sector4.reg_14}" />
							<c:set var="sumReg4_mid_13" value="${sumReg4_mid_13 + sector4.reg_13}" />
							<c:set var="sumReg4_mid_12" value="${sumReg4_mid_12 + sector4.reg_12}" />
							<c:set var="sumReg4_mid_11" value="${sumReg4_mid_11 + sector4.reg_11}" />
							<c:set var="sumReg4_mid_10" value="${sumReg4_mid_10 + sector4.reg_10}" />
							<c:set var="sumReg4_mid_09" value="${sumReg4_mid_09 + sector4.reg_09}" />
							<c:set var="sumReg4_mid_08" value="${sumReg4_mid_08 + sector4.reg_08}" />
							<c:set var="sumReg4_mid_07" value="${sumReg4_mid_07 + sector4.reg_07}" />
							<c:set var="sumReg4_mid_06" value="${sumReg4_mid_06 + sector4.reg_06}" />
							<c:set var="sumReg4_mid_05" value="${sumReg4_mid_05 + sector4.reg_05}" />
							<c:set var="sumReg4_mid_04" value="${sumReg4_mid_04 + sector4.reg_04}" />
							<c:set var="sumReg4_mid_03" value="${sumReg4_mid_03 + sector4.reg_03}" />
							<c:set var="sumReg4_mid_02" value="${sumReg4_mid_02 + sector4.reg_02}" />
							<c:set var="sumReg4_mid_01" value="${sumReg4_mid_01 + sector4.reg_01}" />
							<c:set var="sumReg4_mid_00" value="${sumReg4_mid_00 + sector4.reg_00}" />
							<c:set var="sumReg4_mid_sum" value="${sumReg4_mid_sum + sub1_regSum}" />		                
										
							<c:set var="sumDay4_mid_29" value="${sumDay4_mid_29 + sector4.day_29}" />
							<c:set var="sumDay4_mid_28" value="${sumDay4_mid_28 + sector4.day_28}" />
							<c:set var="sumDay4_mid_27" value="${sumDay4_mid_27 + sector4.day_27}" />
							<c:set var="sumDay4_mid_26" value="${sumDay4_mid_26 + sector4.day_26}" />
							<c:set var="sumDay4_mid_25" value="${sumDay4_mid_25 + sector4.day_25}" />
							<c:set var="sumDay4_mid_24" value="${sumDay4_mid_24 + sector4.day_24}" />
							<c:set var="sumDay4_mid_23" value="${sumDay4_mid_23 + sector4.day_23}" />
							<c:set var="sumDay4_mid_22" value="${sumDay4_mid_22 + sector4.day_22}" />
							<c:set var="sumDay4_mid_21" value="${sumDay4_mid_21 + sector4.day_21}" />
							<c:set var="sumDay4_mid_20" value="${sumDay4_mid_20 + sector4.day_20}" />
							<c:set var="sumDay4_mid_19" value="${sumDay4_mid_19 + sector4.day_19}" />
							<c:set var="sumDay4_mid_18" value="${sumDay4_mid_18 + sector4.day_18}" />
							<c:set var="sumDay4_mid_17" value="${sumDay4_mid_17 + sector4.day_17}" />
							<c:set var="sumDay4_mid_16" value="${sumDay4_mid_16 + sector4.day_16}" />
							<c:set var="sumDay4_mid_15" value="${sumDay4_mid_15 + sector4.day_15}" />
							<c:set var="sumDay4_mid_14" value="${sumDay4_mid_14 + sector4.day_14}" />
							<c:set var="sumDay4_mid_13" value="${sumDay4_mid_13 + sector4.day_13}" />
							<c:set var="sumDay4_mid_12" value="${sumDay4_mid_12 + sector4.day_12}" />
							<c:set var="sumDay4_mid_11" value="${sumDay4_mid_11 + sector4.day_11}" />
							<c:set var="sumDay4_mid_10" value="${sumDay4_mid_10 + sector4.day_10}" />
							<c:set var="sumDay4_mid_09" value="${sumDay4_mid_09 + sector4.day_09}" />
							<c:set var="sumDay4_mid_08" value="${sumDay4_mid_08 + sector4.day_08}" />
							<c:set var="sumDay4_mid_07" value="${sumDay4_mid_07 + sector4.day_07}" />
							<c:set var="sumDay4_mid_06" value="${sumDay4_mid_06 + sector4.day_06}" />
							<c:set var="sumDay4_mid_05" value="${sumDay4_mid_05 + sector4.day_05}" />
							<c:set var="sumDay4_mid_04" value="${sumDay4_mid_04 + sector4.day_04}" />
							<c:set var="sumDay4_mid_03" value="${sumDay4_mid_03 + sector4.day_03}" />
							<c:set var="sumDay4_mid_02" value="${sumDay4_mid_02 + sector4.day_02}" />
							<c:set var="sumDay4_mid_01" value="${sumDay4_mid_01 + sector4.day_01}" />
							<c:set var="sumDay4_mid_00" value="${sumDay4_mid_00 + sector4.day_00}" />                
							<c:set var="sumDay4_mid_sum" value="${sumDay4_mid_sum + sub1_daySum}" />
							
							<c:set var="sumReg4_mid_y" value="${sumReg4_mid_y + sector4.reg_y}" />
							<c:set var="sumCls4_mid_m" value="${sumCls4_mid_m + sector4.cls_m}" />
							<c:set var="sumCls4_mid_y" value="${sumCls4_mid_y + sector4.cls_y}" />
							<c:set var="sumReg4_mid_mi" value="${sumReg4_mid_mi + sector4.reg_mi}" />		            		
		            		<!-- 인보험 조사심사 소계 계산 시작 -->
	            		</c:if>
	            		<!-- 4종 전체 합계 계산 시작 -->	            		
	            		<c:set var="sumMember4_cnt" value="${sumMember4_cnt + sector4.member_cnt}" />
	            		
	            		<c:set var="sumReg4_29" value="${sumReg4_29 + sector4.reg_29}" />
						<c:set var="sumReg4_28" value="${sumReg4_28 + sector4.reg_28}" />
						<c:set var="sumReg4_27" value="${sumReg4_27 + sector4.reg_27}" />
						<c:set var="sumReg4_26" value="${sumReg4_26 + sector4.reg_26}" />
						<c:set var="sumReg4_25" value="${sumReg4_25 + sector4.reg_25}" />
						<c:set var="sumReg4_24" value="${sumReg4_24 + sector4.reg_24}" />
						<c:set var="sumReg4_23" value="${sumReg4_23 + sector4.reg_23}" />
						<c:set var="sumReg4_22" value="${sumReg4_22 + sector4.reg_22}" />
						<c:set var="sumReg4_21" value="${sumReg4_21 + sector4.reg_21}" />
						<c:set var="sumReg4_20" value="${sumReg4_20 + sector4.reg_20}" />
						<c:set var="sumReg4_19" value="${sumReg4_19 + sector4.reg_19}" />
						<c:set var="sumReg4_18" value="${sumReg4_18 + sector4.reg_18}" />
						<c:set var="sumReg4_17" value="${sumReg4_17 + sector4.reg_17}" />
						<c:set var="sumReg4_16" value="${sumReg4_16 + sector4.reg_16}" />
						<c:set var="sumReg4_15" value="${sumReg4_15 + sector4.reg_15}" />
						<c:set var="sumReg4_14" value="${sumReg4_14 + sector4.reg_14}" />
						<c:set var="sumReg4_13" value="${sumReg4_13 + sector4.reg_13}" />
						<c:set var="sumReg4_12" value="${sumReg4_12 + sector4.reg_12}" />
						<c:set var="sumReg4_11" value="${sumReg4_11 + sector4.reg_11}" />
						<c:set var="sumReg4_10" value="${sumReg4_10 + sector4.reg_10}" />
						<c:set var="sumReg4_09" value="${sumReg4_09 + sector4.reg_09}" />
						<c:set var="sumReg4_08" value="${sumReg4_08 + sector4.reg_08}" />
						<c:set var="sumReg4_07" value="${sumReg4_07 + sector4.reg_07}" />
						<c:set var="sumReg4_06" value="${sumReg4_06 + sector4.reg_06}" />
						<c:set var="sumReg4_05" value="${sumReg4_05 + sector4.reg_05}" />
						<c:set var="sumReg4_04" value="${sumReg4_04 + sector4.reg_04}" />
						<c:set var="sumReg4_03" value="${sumReg4_03 + sector4.reg_03}" />
						<c:set var="sumReg4_02" value="${sumReg4_02 + sector4.reg_02}" />
						<c:set var="sumReg4_01" value="${sumReg4_01 + sector4.reg_01}" />
						<c:set var="sumReg4_00" value="${sumReg4_00 + sector4.reg_00}" />
						<c:set var="sumReg4_sum" value="${sumReg4_sum + sector4.reg_29+sector4.reg_28+sector4.reg_27+sector4.reg_26+sector4.reg_25+sector4.reg_24+sector4.reg_23+sector4.reg_22+sector4.reg_21+sector4.reg_20+sector4.reg_19+sector4.reg_18+sector4.reg_17+sector4.reg_16+sector4.reg_15+sector4.reg_14+sector4.reg_13+sector4.reg_12+sector4.reg_11+sector4.reg_10+sector4.reg_09+sector4.reg_08+sector4.reg_07+sector4.reg_06+sector4.reg_05+sector4.reg_04+sector4.reg_03+sector4.reg_02+sector4.reg_01+sector4.reg_00}" />		                
									
						<c:set var="sumDay4_29" value="${sumDay4_29 + sector4.day_29}" />
						<c:set var="sumDay4_28" value="${sumDay4_28 + sector4.day_28}" />
						<c:set var="sumDay4_27" value="${sumDay4_27 + sector4.day_27}" />
						<c:set var="sumDay4_26" value="${sumDay4_26 + sector4.day_26}" />
						<c:set var="sumDay4_25" value="${sumDay4_25 + sector4.day_25}" />
						<c:set var="sumDay4_24" value="${sumDay4_24 + sector4.day_24}" />
						<c:set var="sumDay4_23" value="${sumDay4_23 + sector4.day_23}" />
						<c:set var="sumDay4_22" value="${sumDay4_22 + sector4.day_22}" />
						<c:set var="sumDay4_21" value="${sumDay4_21 + sector4.day_21}" />
						<c:set var="sumDay4_20" value="${sumDay4_20 + sector4.day_20}" />
						<c:set var="sumDay4_19" value="${sumDay4_19 + sector4.day_19}" />
						<c:set var="sumDay4_18" value="${sumDay4_18 + sector4.day_18}" />
						<c:set var="sumDay4_17" value="${sumDay4_17 + sector4.day_17}" />
						<c:set var="sumDay4_16" value="${sumDay4_16 + sector4.day_16}" />
						<c:set var="sumDay4_15" value="${sumDay4_15 + sector4.day_15}" />
						<c:set var="sumDay4_14" value="${sumDay4_14 + sector4.day_14}" />
						<c:set var="sumDay4_13" value="${sumDay4_13 + sector4.day_13}" />
						<c:set var="sumDay4_12" value="${sumDay4_12 + sector4.day_12}" />
						<c:set var="sumDay4_11" value="${sumDay4_11 + sector4.day_11}" />
						<c:set var="sumDay4_10" value="${sumDay4_10 + sector4.day_10}" />
						<c:set var="sumDay4_09" value="${sumDay4_09 + sector4.day_09}" />
						<c:set var="sumDay4_08" value="${sumDay4_08 + sector4.day_08}" />
						<c:set var="sumDay4_07" value="${sumDay4_07 + sector4.day_07}" />
						<c:set var="sumDay4_06" value="${sumDay4_06 + sector4.day_06}" />
						<c:set var="sumDay4_05" value="${sumDay4_05 + sector4.day_05}" />
						<c:set var="sumDay4_04" value="${sumDay4_04 + sector4.day_04}" />
						<c:set var="sumDay4_03" value="${sumDay4_03 + sector4.day_03}" />
						<c:set var="sumDay4_02" value="${sumDay4_02 + sector4.day_02}" />
						<c:set var="sumDay4_01" value="${sumDay4_01 + sector4.day_01}" />
						<c:set var="sumDay4_00" value="${sumDay4_00 + sector4.day_00}" />                
						<c:set var="sumDay4_sum" value="${sumDay4_sum + sector4.day_29+sector4.day_28+sector4.day_27+sector4.day_26+sector4.day_25+sector4.day_24+sector4.day_23+sector4.day_22+sector4.day_21+sector4.day_20+sector4.day_19+sector4.day_18+sector4.day_17+sector4.day_16+sector4.day_15+sector4.day_14+sector4.day_13+sector4.day_12+sector4.day_11+sector4.day_10+sector4.day_09+sector4.day_08+sector4.day_07+sector4.day_06+sector4.day_05+sector4.day_04+sector4.day_03+sector4.day_02+sector4.day_01+sector4.day_00}" />
						
						<c:set var="sumReg4_y" value="${sumReg4_y + sector4.reg_y}" />
						<c:set var="sumCls4_m" value="${sumCls4_m + sector4.cls_m}" />
						<c:set var="sumCls4_y" value="${sumCls4_y + sector4.cls_y}" />
						<c:set var="sumReg4_mi" value="${sumReg4_mi + sector4.reg_mi}" />
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
            		<c:forEach var="sector4" items="${TeamSector4ListVO}" varStatus="status">	            	
	            		<c:if test="${sector4.team_sector eq 9}">
		            		<tr>
		            			<td>${sector4.team_sector_val} (${sector4.member_cnt})</td>
			                    <td class="border-right">
			                    	<p>수임</p><p class="sub-p">종결</p>
			                    </td>
			                    <td class="border-right">		                    	
			                    	<c:set var="sub1_regSum" value="${sector4.reg_29+sector4.reg_28+sector4.reg_27+sector4.reg_26+sector4.reg_25+sector4.reg_24+sector4.reg_23+sector4.reg_22+sector4.reg_21+sector4.reg_20+sector4.reg_19+sector4.reg_18+sector4.reg_17+sector4.reg_16+sector4.reg_15+sector4.reg_14+sector4.reg_13+sector4.reg_12+sector4.reg_11+sector4.reg_10+sector4.reg_09+sector4.reg_08+sector4.reg_07+sector4.reg_06+sector4.reg_05+sector4.reg_04+sector4.reg_03+sector4.reg_02+sector4.reg_01+sector4.reg_00}"/>
			                    	<c:set var="sub1_daySum" value="${sector4.day_29+sector4.day_28+sector4.day_27+sector4.day_26+sector4.day_25+sector4.day_24+sector4.day_23+sector4.day_22+sector4.day_21+sector4.day_20+sector4.day_19+sector4.day_18+sector4.day_17+sector4.day_16+sector4.day_15+sector4.day_14+sector4.day_13+sector4.day_12+sector4.day_11+sector4.day_10+sector4.day_09+sector4.day_08+sector4.day_07+sector4.day_06+sector4.day_05+sector4.day_04+sector4.day_03+sector4.day_02+sector4.day_01+sector4.day_00}"/>
			                    	<p>${sub1_regSum}</p><p class="sub-p">${sub1_daySum}</p>
			                  	</td>
			                  	<!-- 1인당 건수 시작 -->
			                  	<td class="border-right" bgcolor="#faebd7">
			                  		<c:choose>		                  			
			                  			<c:when test="${ sector4.member_cnt eq 0}">
			                  				<p>0</p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:when test="${ sub1_regSum eq 0 && sub1_daySum ne 0}">
			                  				<p>0</p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / sector4.member_cnt}" pattern="#.#"/></p>
			                  			</c:when>
			                  			<c:when test="${ sub1_regSum ne 0 && sub1_daySum eq 0}">
			                  				<p><fmt:formatNumber value="${sub1_regSum / sector4.member_cnt}" pattern="#.#"/></p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:otherwise>
			                  				<p><fmt:formatNumber value="${sub1_regSum / sector4.member_cnt}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / sector4.member_cnt}" pattern="#.#"/></p>
			                  			</c:otherwise>
			                  		</c:choose>		                  		
			                  	</td>
			                  	<!-- 1인당 건수 끝 -->			                  	
			                    <!-- 1인당 미결 시작 -->
								<td class="border-right" bgcolor="#faebd7">
									<c:choose>		                  			
										<c:when test="${sector4.member_cnt eq 0}">
											<p>0</p>
										</c:when>
										<c:when test="${sector4.reg_mi eq 0 }">
											<p>0</p>
										</c:when>		                  			
										<c:otherwise>
											<p><fmt:formatNumber value="${sector4.reg_mi / sector4.member_cnt}" pattern="#.#"/></p>
										</c:otherwise>
									</c:choose>		                  		
								</td>
								<!-- 1인당 미결 끝 -->
								<td bgcolor="#faebd7">
			                    	<font color="">${sector4.reg_mi}</font>
			                    </td>
			                    <td bgcolor="#faebd7">
			                   		${sector4.reg_y}
			                 	</td>
			                    <td bgcolor="#faebd7">
			                    	${sector4.cls_m}
			                   	</td>
			                    <td class="border-right" bgcolor="#faebd7">
			                    	${sector4.cls_y}
			                	</td>		                    
			                    <td>
									<p>${sector4.reg_29}</p><p class="sub-p">${sector4.day_29}</p>
								</td>
								<td>
									<p>${sector4.reg_28}</p><p class="sub-p">${sector4.day_28}</p>
								</td>
								<td>
									<p>${sector4.reg_27}</p><p class="sub-p">${sector4.day_27}</p>
								</td>
								<td>
									<p>${sector4.reg_26}</p><p class="sub-p">${sector4.day_26}</p>
								</td>
								<td>
									<p>${sector4.reg_25}</p><p class="sub-p">${sector4.day_25}</p>
								</td>
								<td>
									<p>${sector4.reg_24}</p><p class="sub-p">${sector4.day_24}</p>
								</td>
								<td>
									<p>${sector4.reg_23}</p><p class="sub-p">${sector4.day_23}</p>
								</td>
								<td>
									<p>${sector4.reg_22}</p><p class="sub-p">${sector4.day_22}</p>
								</td>
								<td>
									<p>${sector4.reg_21}</p><p class="sub-p">${sector4.day_21}</p>
								</td>
								<td>
									<p>${sector4.reg_20}</p><p class="sub-p">${sector4.day_20}</p>
								</td>
								<td>
									<p>${sector4.reg_19}</p><p class="sub-p">${sector4.day_19}</p>
								</td>
								<td>
									<p>${sector4.reg_18}</p><p class="sub-p">${sector4.day_18}</p>
								</td>
								<td>
									<p>${sector4.reg_17}</p><p class="sub-p">${sector4.day_17}</p>
								</td>
								<td>
									<p>${sector4.reg_16}</p><p class="sub-p">${sector4.day_16}</p>
								</td>
								<td>
									<p>${sector4.reg_15}</p><p class="sub-p">${sector4.day_15}</p>
								</td>
								<td>
									<p>${sector4.reg_14}</p><p class="sub-p">${sector4.day_14}</p>
								</td>
								<td>
									<p>${sector4.reg_13}</p><p class="sub-p">${sector4.day_13}</p>
								</td>
								<td>
									<p>${sector4.reg_12}</p><p class="sub-p">${sector4.day_12}</p>
								</td>
								<td>
									<p>${sector4.reg_11}</p><p class="sub-p">${sector4.day_11}</p>
								</td>
								<td>
									<p>${sector4.reg_10}</p><p class="sub-p">${sector4.day_10}</p>
								</td>
								<td>
									<p>${sector4.reg_09}</p><p class="sub-p">${sector4.day_09}</p>
								</td>
								<td>
									<p>${sector4.reg_08}</p><p class="sub-p">${sector4.day_08}</p>
								</td>
								<td>
									<p>${sector4.reg_07}</p><p class="sub-p">${sector4.day_07}</p>
								</td>
								<td>
									<p>${sector4.reg_06}</p><p class="sub-p">${sector4.day_06}</p>
								</td>
								<td>
									<p>${sector4.reg_05}</p><p class="sub-p">${sector4.day_05}</p>
								</td>
								<td>
									<p>${sector4.reg_04}</p><p class="sub-p">${sector4.day_04}</p>
								</td>
								<td>
									<p>${sector4.reg_03}</p><p class="sub-p">${sector4.day_03}</p>
								</td>
								<td>
									<p>${sector4.reg_02}</p><p class="sub-p">${sector4.day_02}</p>
								</td>
								<td>
									<p>${sector4.reg_01}</p><p class="sub-p">${sector4.day_01}</p>
								</td>
								<td>
									<p>${sector4.reg_00}</p><p class="sub-p">${sector4.day_00}</p>
								</td>    			
		            		</tr>
		            		<tr bgcolor="#E7ECF1">
		            			<td class="border-right" colspan="2">${sector4.team_sector_val} 소계 (${sector4.member_cnt})</td>
		            			<td class="border-right">		                    	
			                    	<c:set var="sub1_regSum" value="${sector4.reg_29+sector4.reg_28+sector4.reg_27+sector4.reg_26+sector4.reg_25+sector4.reg_24+sector4.reg_23+sector4.reg_22+sector4.reg_21+sector4.reg_20+sector4.reg_19+sector4.reg_18+sector4.reg_17+sector4.reg_16+sector4.reg_15+sector4.reg_14+sector4.reg_13+sector4.reg_12+sector4.reg_11+sector4.reg_10+sector4.reg_09+sector4.reg_08+sector4.reg_07+sector4.reg_06+sector4.reg_05+sector4.reg_04+sector4.reg_03+sector4.reg_02+sector4.reg_01+sector4.reg_00}"/>
			                    	<c:set var="sub1_daySum" value="${sector4.day_29+sector4.day_28+sector4.day_27+sector4.day_26+sector4.day_25+sector4.day_24+sector4.day_23+sector4.day_22+sector4.day_21+sector4.day_20+sector4.day_19+sector4.day_18+sector4.day_17+sector4.day_16+sector4.day_15+sector4.day_14+sector4.day_13+sector4.day_12+sector4.day_11+sector4.day_10+sector4.day_09+sector4.day_08+sector4.day_07+sector4.day_06+sector4.day_05+sector4.day_04+sector4.day_03+sector4.day_02+sector4.day_01+sector4.day_00}"/>
			                    	<p>${sub1_regSum}</p><p class="sub-p">${sub1_daySum}</p>
			                  	</td>
			                  	<!-- 1인당 건수 시작 -->
			                  	<td class="border-right">
			                  		<c:choose>		                  			
			                  			<c:when test="${ sector4.member_cnt eq 0}">
			                  				<p>0</p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:when test="${ sub1_regSum eq 0 && sub1_daySum ne 0}">
			                  				<p>0</p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / sector4.member_cnt}" pattern="#.#"/></p>
			                  			</c:when>
			                  			<c:when test="${ sub1_regSum ne 0 && sub1_daySum eq 0}">
			                  				<p><fmt:formatNumber value="${sub1_regSum / sector4.member_cnt}" pattern="#.#"/></p><p class="sub-p">0</p>
			                  			</c:when>
			                  			<c:otherwise>
			                  				<p><fmt:formatNumber value="${sub1_regSum / sector4.member_cnt}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sub1_daySum / sector4.member_cnt}" pattern="#.#"/></p>
			                  			</c:otherwise>
			                  		</c:choose>		                  		
			                  	</td>
			                  	<!-- 1인당 건수 끝 -->			                  	
			                    <!-- 1인당 미결 시작 -->
								<td class="border-right">
									<c:choose>		                  			
										<c:when test="${sector4.member_cnt eq 0}">
											<p>0</p>
										</c:when>
										<c:when test="${sector4.reg_mi eq 0 }">
											<p>0</p>
										</c:when>		                  			
										<c:otherwise>
											<p><fmt:formatNumber value="${sector4.reg_mi / sector4.member_cnt}" pattern="#.#"/></p>
										</c:otherwise>
									</c:choose>		                  		
								</td>
								<!-- 1인당 미결 끝 -->
								<td>
			                    	<font color="">${sector4.reg_mi}</font>
			                    </td>
			                    <td>
			                   		${sector4.reg_y}
			                 	</td>
			                    <td>
			                    	${sector4.cls_m}
			                   	</td>
			                    <td class="border-right">
			                    	${sector4.cls_y}
			                	</td>			                    
			                    <td>
									<p>${sector4.reg_29}</p><p class="sub-p">${sector4.day_29}</p>
								</td>
								<td>
									<p>${sector4.reg_28}</p><p class="sub-p">${sector4.day_28}</p>
								</td>
								<td>
									<p>${sector4.reg_27}</p><p class="sub-p">${sector4.day_27}</p>
								</td>
								<td>
									<p>${sector4.reg_26}</p><p class="sub-p">${sector4.day_26}</p>
								</td>
								<td>
									<p>${sector4.reg_25}</p><p class="sub-p">${sector4.day_25}</p>
								</td>
								<td>
									<p>${sector4.reg_24}</p><p class="sub-p">${sector4.day_24}</p>
								</td>
								<td>
									<p>${sector4.reg_23}</p><p class="sub-p">${sector4.day_23}</p>
								</td>
								<td>
									<p>${sector4.reg_22}</p><p class="sub-p">${sector4.day_22}</p>
								</td>
								<td>
									<p>${sector4.reg_21}</p><p class="sub-p">${sector4.day_21}</p>
								</td>
								<td>
									<p>${sector4.reg_20}</p><p class="sub-p">${sector4.day_20}</p>
								</td>
								<td>
									<p>${sector4.reg_19}</p><p class="sub-p">${sector4.day_19}</p>
								</td>
								<td>
									<p>${sector4.reg_18}</p><p class="sub-p">${sector4.day_18}</p>
								</td>
								<td>
									<p>${sector4.reg_17}</p><p class="sub-p">${sector4.day_17}</p>
								</td>
								<td>
									<p>${sector4.reg_16}</p><p class="sub-p">${sector4.day_16}</p>
								</td>
								<td>
									<p>${sector4.reg_15}</p><p class="sub-p">${sector4.day_15}</p>
								</td>
								<td>
									<p>${sector4.reg_14}</p><p class="sub-p">${sector4.day_14}</p>
								</td>
								<td>
									<p>${sector4.reg_13}</p><p class="sub-p">${sector4.day_13}</p>
								</td>
								<td>
									<p>${sector4.reg_12}</p><p class="sub-p">${sector4.day_12}</p>
								</td>
								<td>
									<p>${sector4.reg_11}</p><p class="sub-p">${sector4.day_11}</p>
								</td>
								<td>
									<p>${sector4.reg_10}</p><p class="sub-p">${sector4.day_10}</p>
								</td>
								<td>
									<p>${sector4.reg_09}</p><p class="sub-p">${sector4.day_09}</p>
								</td>
								<td>
									<p>${sector4.reg_08}</p><p class="sub-p">${sector4.day_08}</p>
								</td>
								<td>
									<p>${sector4.reg_07}</p><p class="sub-p">${sector4.day_07}</p>
								</td>
								<td>
									<p>${sector4.reg_06}</p><p class="sub-p">${sector4.day_06}</p>
								</td>
								<td>
									<p>${sector4.reg_05}</p><p class="sub-p">${sector4.day_05}</p>
								</td>
								<td>
									<p>${sector4.reg_04}</p><p class="sub-p">${sector4.day_04}</p>
								</td>
								<td>
									<p>${sector4.reg_03}</p><p class="sub-p">${sector4.day_03}</p>
								</td>
								<td>
									<p>${sector4.reg_02}</p><p class="sub-p">${sector4.day_02}</p>
								</td>
								<td>
									<p>${sector4.reg_01}</p><p class="sub-p">${sector4.day_01}</p>
								</td>
								<td>
									<p>${sector4.reg_00}</p><p class="sub-p">${sector4.day_00}</p>
								</td>	                    		            			
		            		</tr>
	            		</c:if>
	            	</c:forEach>
            		<!-- 인보험 기타 끝 -->
            		
		            <!-- 인보험 조사 심사 끝 -->
		            
		            <!-- 인보험 소계 시작 -->
		            <tr bgcolor="#E7ECF1">
		                <th class="border-right" colspan="2">인보험 소계 (${sumMember4_cnt})</th>
		                <th class="border-right">
		                	<p>${sumReg4_sum}</p><p class="sub-p">${sumDay4_sum}</p>
		               	</th>
		               	<th class="border-right">		                	
		                	<p><fmt:formatNumber value="${sumReg4_sum / sumMember4_cnt}" pattern="#.#"/></p><p class="sub-p"><fmt:formatNumber value="${sumDay4_sum / sumMember4_cnt}" pattern="#.#"/></p>
		               	</th>		               	
		               	<th class="border-right">		                	
		                	<p><fmt:formatNumber value="${sumReg4_mi / sumMember4_cnt}" pattern="#.#"/></p>
		               	</th>
		               	<th><font color="">${sumReg4_mi}</font></th>
		               	<th>${sumReg4_y}</th>
		                <th>${sumCls4_m}</th>
		                <th class="border-right">${sumCls4_y}</th>
		                <th>
							<p>${sumReg4_29}</p><p class="sub-p">${sumDay4_29}</p>
		               	</th>
		                <th>
							<p>${sumReg4_28}</p><p class="sub-p">${sumDay4_28}</p>
		               	</th>
		                <th>
							<p>${sumReg4_27}</p><p class="sub-p">${sumDay4_27}</p>
		               	</th>
		                <th>
							<p>${sumReg4_26}</p><p class="sub-p">${sumDay4_26}</p>
		               	</th>
		                <th>
							<p>${sumReg4_25}</p><p class="sub-p">${sumDay4_25}</p>
		               	</th>
		                <th>
							<p>${sumReg4_24}</p><p class="sub-p">${sumDay4_24}</p>
		               	</th>
		                <th>
							<p>${sumReg4_23}</p><p class="sub-p">${sumDay4_23}</p>
		               	</th>
		                <th>
							<p>${sumReg4_22}</p><p class="sub-p">${sumDay4_22}</p>
		               	</th>
		                <th>
							<p>${sumReg4_21}</p><p class="sub-p">${sumDay4_21}</p>
		               	</th>
		                <th>
							<p>${sumReg4_20}</p><p class="sub-p">${sumDay4_20}</p>
		               	</th>
		                <th>
							<p>${sumReg4_19}</p><p class="sub-p">${sumDay4_19}</p>
		               	</th>
		                <th>
							<p>${sumReg4_18}</p><p class="sub-p">${sumDay4_18}</p>
		               	</th>
		                <th>
							<p>${sumReg4_17}</p><p class="sub-p">${sumDay4_17}</p>
		               	</th>
		                <th>
							<p>${sumReg4_16}</p><p class="sub-p">${sumDay4_16}</p>
		               	</th>
		                <th>
							<p>${sumReg4_15}</p><p class="sub-p">${sumDay4_15}</p>
		               	</th>
		                <th>
							<p>${sumReg4_14}</p><p class="sub-p">${sumDay4_14}</p>
		               	</th>
		                <th>
							<p>${sumReg4_13}</p><p class="sub-p">${sumDay4_13}</p>
		               	</th>
		                <th>
							<p>${sumReg4_12}</p><p class="sub-p">${sumDay4_12}</p>
		               	</th>
		                <th>
							<p>${sumReg4_11}</p><p class="sub-p">${sumDay4_11}</p>
		               	</th>
		                <th>
							<p>${sumReg4_10}</p><p class="sub-p">${sumDay4_10}</p>
		               	</th>
		                <th>
							<p>${sumReg4_09}</p><p class="sub-p">${sumDay4_09}</p>
		               	</th>
		                <th>
							<p>${sumReg4_08}</p><p class="sub-p">${sumDay4_08}</p>
		               	</th>
		                <th>
							<p>${sumReg4_07}</p><p class="sub-p">${sumDay4_07}</p>
		               	</th>
		                <th>
							<p>${sumReg4_06}</p><p class="sub-p">${sumDay4_06}</p>
		               	</th>
		                <th>
							<p>${sumReg4_05}</p><p class="sub-p">${sumDay4_05}</p>
		               	</th>
		                <th>
							<p>${sumReg4_04}</p><p class="sub-p">${sumDay4_04}</p>
		               	</th>
		                <th>
							<p>${sumReg4_03}</p><p class="sub-p">${sumDay4_03}</p>
		               	</th>
		                <th>
							<p>${sumReg4_02}</p><p class="sub-p">${sumDay4_02}</p>
		               	</th>
		                <th>
							<p>${sumReg4_01}</p><p class="sub-p">${sumDay4_01}</p>
		               	</th>
		                <th>
							<p>${sumReg4_00}</p><p class="sub-p">${sumDay4_00}</p>
		               	</th>                
		            </tr>
		            <!-- 인보험 소계 끝 -->
		            
		            <!-- 전체 합계 시작 -->
		            <tr bgcolor="#E7ECF1">
		                <th class="border-right" colspan="2"><font color="blue">전 체 합 계 (${sumMember_cnt + sumMember4_cnt})</font></th>
		                <th class="border-right">
		                	<p><font color="blue">${sumReg_sum + sumReg4_sum}</font></p><p class="sub-p"><font color="blue">${sumDay_sum + sumDay4_sum}</font></p>
		               	</th>
		               	<th class="border-right">		               		
		               		<p><font color="blue"><fmt:formatNumber value="${ (sumReg_sum + sumReg4_sum) / (sumMember_cnt + sumMember4_cnt) }" pattern="#.#"/></font></p><p class="sub-p"><font color="blue"><fmt:formatNumber value="${ (sumDay_sum + sumDay4_sum) / (sumMember_cnt + sumMember4_cnt) }" pattern="#.#"/></font></p>
		               	</th>		               	
		               	<th class="border-right">		               		
		               		<p><font color="blue"><fmt:formatNumber value="${ (sumReg_mi + sumReg4_mi) / (sumMember_cnt + sumMember4_cnt) }" pattern="#.#"/></font></p>
		               	</th>
		               	<th><font color="blue">${sumReg_mi + sumReg4_mi}</font></th>
		               	<th><font color="blue">${sumReg_y + sumReg4_y}</font></th>
		                <th><font color="blue">${sumCls_m + sumCls4_m}</font></th>
		                <th class="border-right"><font color="blue">${sumCls_y + sumCls4_y}</font></th>
		                <th>
							<p><font color="blue">${sumReg_29 + sumReg4_29}</font></p><p class="sub-p"><font color="blue">${sumDay_29 + sumDay4_29}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_28 + sumReg4_28}</font></p><p class="sub-p"><font color="blue">${sumDay_28 + sumDay4_28}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_27 + sumReg4_27}</font></p><p class="sub-p"><font color="blue">${sumDay_27 + sumDay4_27}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_26 + sumReg4_26}</font></p><p class="sub-p"><font color="blue">${sumDay_26 + sumDay4_26}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_25 + sumReg4_25}</font></p><p class="sub-p"><font color="blue">${sumDay_25 + sumDay4_25}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_24 + sumReg4_24}</font></p><p class="sub-p"><font color="blue">${sumDay_24 + sumDay4_24}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_23 + sumReg4_23}</font></p><p class="sub-p"><font color="blue">${sumDay_23 + sumDay4_23}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_22 + sumReg4_22}</font></p><p class="sub-p"><font color="blue">${sumDay_22 + sumDay4_22}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_21 + sumReg4_21}</font></p><p class="sub-p"><font color="blue">${sumDay_21 + sumDay4_21}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_20 + sumReg4_20}</font></p><p class="sub-p"><font color="blue">${sumDay_20 + sumDay4_20}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_19 + sumReg4_19}</font></p><p class="sub-p"><font color="blue">${sumDay_19 + sumDay4_19}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_18 + sumReg4_18}</font></p><p class="sub-p"><font color="blue">${sumDay_18 + sumDay4_18}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_17 + sumReg4_17}</font></p><p class="sub-p"><font color="blue">${sumDay_17 + sumDay4_17}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_16 + sumReg4_16}</font></p><p class="sub-p"><font color="blue">${sumDay_16 + sumDay4_16}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_15 + sumReg4_15}</font></p><p class="sub-p"><font color="blue">${sumDay_15 + sumDay4_15}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_14 + sumReg4_14}</font></p><p class="sub-p"><font color="blue">${sumDay_14 + sumDay4_14}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_13 + sumReg4_13}</font></p><p class="sub-p"><font color="blue">${sumDay_13 + sumDay4_13}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_12 + sumReg4_12}</font></p><p class="sub-p"><font color="blue">${sumDay_12 + sumDay4_12}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_11 + sumReg4_11}</font></p><p class="sub-p"><font color="blue">${sumDay_11 + sumDay4_11}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_10 + sumReg4_10}</font></p><p class="sub-p"><font color="blue">${sumDay_10 + sumDay4_10}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_09 + sumReg4_09}</font></p><p class="sub-p"><font color="blue">${sumDay_09 + sumDay4_09}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_08 + sumReg4_08}</font></p><p class="sub-p"><font color="blue">${sumDay_08 + sumDay4_08}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_07 + sumReg4_07}</font></p><p class="sub-p"><font color="blue">${sumDay_07 + sumDay4_07}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_06 + sumReg4_06}</font></p><p class="sub-p"><font color="blue">${sumDay_06 + sumDay4_06}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_05 + sumReg4_05}</font></p><p class="sub-p"><font color="blue">${sumDay_05 + sumDay4_05}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_04 + sumReg4_04}</font></p><p class="sub-p"><font color="blue">${sumDay_04 + sumDay4_04}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_03 + sumReg4_03}</font></p><p class="sub-p"><font color="blue">${sumDay_03 + sumDay4_03}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_02 + sumReg4_02}</font></p><p class="sub-p"><font color="blue">${sumDay_02 + sumDay4_02}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_01 + sumReg4_01}</font></p><p class="sub-p"><font color="blue">${sumDay_01 + sumDay4_01}</font></p>
		               	</th>
		                <th>
							<p><font color="blue">${sumReg_00 + sumReg4_00}</font></p><p class="sub-p"><font color="blue">${sumDay_00 + sumDay4_00}</font></p>
		               	</th>                
		            </tr>
		            <!-- 전체 합계 끝 -->
		            </tbody>
		        </table>
		    </div>
		</div>
	</div>
</div>
