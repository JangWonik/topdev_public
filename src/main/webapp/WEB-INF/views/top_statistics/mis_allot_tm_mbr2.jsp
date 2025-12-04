<%@ page language="java" contentType="text/html;charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="tableStyle2">
	<div style="width:100%; overflow-x: auto; overflow-y: hidden !important;">
		<div style="width:1882px;" >
		    <div style="padding-right: 17px; background: #e7ecf1;">
		        <table cellpadding="0" cellspacing="0" width="1060" align="center">
		            <colgroup>
		                <col style="width:98px;" />
		                <col style="width:155px;" />		                
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:50px;" />		                
		            </colgroup>
		            <tr>
		                <th>팀</th>
		                <th class="border-right">이름</th>
		                <th class="border-right">합계</th>
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
		        </table>
		    </div>
		    <div style="height:632px; overflow-x: hidden; overflow-y: auto;">
		        <table cellpadding="0" cellspacing="0" align="center">
		            <colgroup>
		                <col style="width:98px;" />
		                <col style="width:110px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:43px;" />
		                <col style="width:44px;" />
		                <col style="width:43px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />
		                <col style="width:44px;" />		                
		                <col style="width:44px;" />		                
		            </colgroup>
		            <c:set var="orgRowSpanTeamId" value=""/>
		            <c:set var="orgSubTotalTeamId" value="${memList[0].teamId}"/>
		            <c:forEach  var="item" items="${memList}" varStatus="status">
		                <c:if test="${orgSubTotalTeamId != item.teamId}">
		                	<c:set var="orgSubTotalTeamId" value="${item.teamId}"/>
		                	<c:set var="totalReg02" value="${totalReg02 + subReg02}"/>
		                    <c:set var="totalReg03" value="${totalReg03 + subReg03}"/>
		                    <c:set var="totalReg04" value="${totalReg04 + subReg04}"/>
		                    <c:set var="totalReg05" value="${totalReg05 + subReg05}"/>
		                    <c:set var="totalReg06" value="${totalReg06 + subReg06}"/>
		                    <c:set var="totalReg07" value="${totalReg07 + subReg07}"/>
		                    <c:set var="totalReg08" value="${totalReg08 + subReg08}"/>
		                    <c:set var="totalReg09" value="${totalReg09 + subReg09}"/>
		                    <c:set var="totalReg10" value="${totalReg10 + subReg10}"/>
		                    <c:set var="totalReg11" value="${totalReg11 + subReg11}"/>
		                    <c:set var="totalReg12" value="${totalReg12 + subReg12}"/>
		                    <c:set var="totalReg13" value="${totalReg13 + subReg13}"/>
		                    <c:set var="totalReg14" value="${totalReg14 + subReg14}"/>
		                    <c:set var="totalReg15" value="${totalReg15 + subReg15}"/>
		                    <c:set var="totalReg16" value="${totalReg16 + subReg16}"/>
		                    <c:set var="totalReg17" value="${totalReg17 + subReg17}"/>
		                    <c:set var="totalReg18" value="${totalReg18 + subReg18}"/>
		                    <c:set var="totalReg19" value="${totalReg19 + subReg19}"/>
		                    <c:set var="totalReg20" value="${totalReg20 + subReg20}"/>
		                    <c:set var="totalReg21" value="${totalReg21 + subReg21}"/>
		                    <c:set var="totalReg22" value="${totalReg22 + subReg22}"/>
		                    <c:set var="totalReg23" value="${totalReg23 + subReg23}"/>
		                    <c:set var="totalReg24" value="${totalReg24 + subReg24}"/>
		                    <c:set var="totalReg25" value="${totalReg25 + subReg25}"/>
		                    <c:set var="totalReg26" value="${totalReg26 + subReg26}"/>
		                    <c:set var="totalReg27" value="${totalReg27 + subReg27}"/>
		                    <c:set var="totalReg28" value="${totalReg28 + subReg28}"/>
		                    <c:set var="totalReg29" value="${totalReg29 + subReg29}"/>
		                    <c:set var="totalReg30" value="${totalReg30 + subReg30}"/>
		                    <c:set var="totalReg31" value="${totalReg31 + subReg31}"/>
				                    
		                    <c:set var="totalDay02" value="${totalDay02 + subDay02}"/>
		                    <c:set var="totalDay03" value="${totalDay03 + subDay03}"/>
		                    <c:set var="totalDay04" value="${totalDay04 + subDay04}"/>
		                    <c:set var="totalDay05" value="${totalDay05 + subDay05}"/>
		                    <c:set var="totalDay06" value="${totalDay06 + subDay06}"/>
		                    <c:set var="totalDay07" value="${totalDay07 + subDay07}"/>
		                    <c:set var="totalDay08" value="${totalDay08 + subDay08}"/>
		                    <c:set var="totalDay09" value="${totalDay09 + subDay09}"/>
		                    <c:set var="totalDay10" value="${totalDay10 + subDay10}"/>
		                    <c:set var="totalDay11" value="${totalDay11 + subDay11}"/>
		                    <c:set var="totalDay12" value="${totalDay12 + subDay12}"/>
		                    <c:set var="totalDay13" value="${totalDay13 + subDay13}"/>
		                    <c:set var="totalDay14" value="${totalDay14 + subDay14}"/>
		                    <c:set var="totalDay15" value="${totalDay15 + subDay15}"/>
		                    <c:set var="totalDay16" value="${totalDay16 + subDay16}"/>
		                    <c:set var="totalDay17" value="${totalDay17 + subDay17}"/>
		                    <c:set var="totalDay18" value="${totalDay18 + subDay18}"/>
		                    <c:set var="totalDay19" value="${totalDay19 + subDay19}"/>
		                    <c:set var="totalDay20" value="${totalDay20 + subDay20}"/>
		                    <c:set var="totalDay21" value="${totalDay21 + subDay21}"/>
		                    <c:set var="totalDay22" value="${totalDay22 + subDay22}"/>
		                    <c:set var="totalDay23" value="${totalDay23 + subDay23}"/>
		                    <c:set var="totalDay24" value="${totalDay24 + subDay24}"/>
		                    <c:set var="totalDay25" value="${totalDay25 + subDay25}"/>
		                    <c:set var="totalDay26" value="${totalDay26 + subDay26}"/>
		                    <c:set var="totalDay27" value="${totalDay27 + subDay27}"/>
		                    <c:set var="totalDay28" value="${totalDay28 + subDay28}"/>
		                    <c:set var="totalDay29" value="${totalDay29 + subDay29}"/>
		                    <c:set var="totalDay30" value="${totalDay30 + subDay30}"/>
		                    <c:set var="totalDay31" value="${totalDay31 + subDay31}"/>                    
		                    
		                    <c:set var="totalTotalSum" value="${totalTotalSum + subTotalSum}"/>
		                    <c:set var="totalDayTotalSum" value="${totalDayTotalSum + subDayTotalSum}"/>
		                    
		                    <c:set var="totalRegYearCnt" value="${totalRegYearCnt + subRegYearCnt}"/>
		                    <c:set var="totalClsMonthCnt" value="${totalClsMonthCnt + subClsMonthCnt}"/>
		                    <c:set var="totalClsYearCnt" value="${totalClsYearCnt + subClsYearCnt}"/>
		                    <c:set var="totalPendingCnt" value="${totalPendingCnt + subPendingCnt}"/>				            
		                    <tr>
		                        <th class="border-right" colspan="2">소계</th>
		                        <th class="border-right">
				                	<p><fmt:formatNumber value="${subTotalSum}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDayTotalSum}" pattern="#,###"/></p>
				               	</th>
				               	<th><!--<span style="color: red">--><fmt:formatNumber value="${subPendingCnt}" pattern="#,###"/><!--</span>--></th>                
				               	<th><fmt:formatNumber value="${subRegYearCnt}" pattern="#,###"/></th>
		                        <th><fmt:formatNumber value="${subClsMonthCnt}" pattern="#,###"/></th>
		                        <th class="border-right"><fmt:formatNumber value="${subClsYearCnt}" pattern="#,###"/></th>
				                <th>
				                	<p><fmt:formatNumber value="${subReg02}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay02}" pattern="#,###"/></p>
								</th>
				                <th>
				                	<p><fmt:formatNumber value="${subReg03}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay03}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg04}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay04}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg05}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay05}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg06}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay06}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg07}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay07}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg08}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay08}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg09}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay09}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg10}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay10}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg11}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay11}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg12}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay12}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg13}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay13}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg14}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay14}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg15}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay15}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg16}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay16}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg17}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay17}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg18}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay18}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg19}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay19}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg20}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay20}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg21}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay21}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg22}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay22}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg23}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay23}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg24}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay24}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg25}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay25}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg26}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay26}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg27}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay27}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg28}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay28}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg29}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay29}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg30}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay30}" pattern="#,###"/></p>
								</th>
								<th>
				                	<p><fmt:formatNumber value="${subReg31}" pattern="#,###"/></p>
				                	<p class="sub-p"><fmt:formatNumber value="${subDay31}" pattern="#,###"/></p>
								</th>		                        		                        
		                    </tr>
		                    				                    
		                    <c:set var="subReg02" value="0"/>
		                    <c:set var="subReg03" value="0"/>
		                    <c:set var="subReg04" value="0"/>
		                    <c:set var="subReg05" value="0"/>
		                    <c:set var="subReg06" value="0"/>
		                    <c:set var="subReg07" value="0"/>
		                    <c:set var="subReg08" value="0"/>
		                    <c:set var="subReg09" value="0"/>
		                    <c:set var="subReg10" value="0"/>
		                    <c:set var="subReg11" value="0"/>
		                    <c:set var="subReg12" value="0"/>
		                    <c:set var="subReg13" value="0"/>
		                    <c:set var="subReg14" value="0"/>
		                    <c:set var="subReg15" value="0"/>
		                    <c:set var="subReg16" value="0"/>
		                    <c:set var="subReg17" value="0"/>
		                    <c:set var="subReg18" value="0"/>
		                    <c:set var="subReg19" value="0"/>
		                    <c:set var="subReg20" value="0"/>
		                    <c:set var="subReg21" value="0"/>
		                    <c:set var="subReg22" value="0"/>
		                    <c:set var="subReg23" value="0"/>
		                    <c:set var="subReg24" value="0"/>
		                    <c:set var="subReg25" value="0"/>
		                    <c:set var="subReg26" value="0"/>
		                    <c:set var="subReg27" value="0"/>
		                    <c:set var="subReg28" value="0"/>
		                    <c:set var="subReg29" value="0"/>
		                    <c:set var="subReg30" value="0"/>
		                    <c:set var="subReg31" value="0"/>
		                    <c:set var="subTotalSum" value="0"/>
		                    		                    
		                    <c:set var="subDay02" value="0"/>
		                    <c:set var="subDay03" value="0"/>
		                    <c:set var="subDay04" value="0"/>
		                    <c:set var="subDay05" value="0"/>
		                    <c:set var="subDay06" value="0"/>
		                    <c:set var="subDay07" value="0"/>
		                    <c:set var="subDay08" value="0"/>
		                    <c:set var="subDay09" value="0"/>
		                    <c:set var="subDay10" value="0"/>
		                    <c:set var="subDay11" value="0"/>
		                    <c:set var="subDay12" value="0"/>
		                    <c:set var="subDay13" value="0"/>
		                    <c:set var="subDay14" value="0"/>
		                    <c:set var="subDay15" value="0"/>
		                    <c:set var="subDay16" value="0"/>
		                    <c:set var="subDay17" value="0"/>
		                    <c:set var="subDay18" value="0"/>
		                    <c:set var="subDay19" value="0"/>
		                    <c:set var="subDay20" value="0"/>
		                    <c:set var="subDay21" value="0"/>
		                    <c:set var="subDay22" value="0"/>
		                    <c:set var="subDay23" value="0"/>
		                    <c:set var="subDay24" value="0"/>
		                    <c:set var="subDay25" value="0"/>
		                    <c:set var="subDay26" value="0"/>
		                    <c:set var="subDay27" value="0"/>
		                    <c:set var="subDay28" value="0"/>
		                    <c:set var="subDay29" value="0"/>
		                    <c:set var="subDay30" value="0"/>
		                    <c:set var="subDay31" value="0"/>
		                    <c:set var="subDayTotalSum" value="0"/>
		                    
		                    <c:set var="subRegYearCnt" value="0"/>
		                    <c:set var="subClsMonthCnt" value="0"/>
		                    <c:set var="subClsYearCnt" value="0"/>
		                    <c:set var="subPendingCnt" value="0"/>
		                    
		                </c:if>
		                
		                <tr>
		                    <c:if test="${orgRowSpanTeamId != item.teamId}">
		                        <td rowspan="${item.rowSpan + 1}">${item.teamName}</td>
		                        <c:set var="orgRowSpanTeamId" value="${item.teamId}"/>
		                    </c:if>
		                    <td>${item.userName}</td>
		                    <td class="border-right">
		                    	<p>수임</p><p class="sub-p">종결</p>
		                   	</td>
		                    <td class="border-right" bgcolor="#faebd7">		                        
		                        <c:set var="subTotal" value="${item.reg02 + item.reg03 + item.reg04 + item.reg05
		                                       + item.reg06 + item.reg07 + item.reg08 + item.reg09 + item.reg10
		                                       + item.reg11 + item.reg12 + item.reg13 + item.reg14 + item.reg15
		                                       + item.reg16 + item.reg17 + item.reg18 + item.reg19 + item.reg20
		                                       + item.reg21 + item.reg22 + item.reg23 + item.reg24 + item.reg25
		                                       + item.reg26 + item.reg27 + item.reg28 + item.reg29 + item.reg30
		                                       + item.reg31
		                                        }"/>
		                        <c:set var="subDayTotal" value="${item.day02 + item.day03 + item.day04 + item.day05
		                                       + item.day06 + item.day07 + item.day08 + item.day09 + item.day10
		                                       + item.day11 + item.day12 + item.day13 + item.day14 + item.day15
		                                       + item.day16 + item.day17 + item.day18 + item.day19 + item.day20
		                                       + item.day21 + item.day22 + item.day23 + item.day24 + item.day25
		                                       + item.day26 + item.day27 + item.day28 + item.day29 + item.day30
		                                       + item.day31
		                                        }"/>
		                        <c:set var="subReg02" value="${subReg02 + item.reg02}"/>
				                <c:set var="subReg03" value="${subReg03 + item.reg03}"/>
				                <c:set var="subReg04" value="${subReg04 + item.reg04}"/>
				                <c:set var="subReg05" value="${subReg05 + item.reg05}"/>
				                <c:set var="subReg06" value="${subReg06 + item.reg06}"/>
				                <c:set var="subReg07" value="${subReg07 + item.reg07}"/>
				                <c:set var="subReg08" value="${subReg08 + item.reg08}"/>
				                <c:set var="subReg09" value="${subReg09 + item.reg09}"/>
				                <c:set var="subReg10" value="${subReg10 + item.reg10}"/>
				                <c:set var="subReg11" value="${subReg11 + item.reg11}"/>
				                <c:set var="subReg12" value="${subReg12 + item.reg12}"/>
				                <c:set var="subReg13" value="${subReg13 + item.reg13}"/>
				                <c:set var="subReg14" value="${subReg14 + item.reg14}"/>
				                <c:set var="subReg15" value="${subReg15 + item.reg15}"/>
				                <c:set var="subReg16" value="${subReg16 + item.reg16}"/>
				                <c:set var="subReg17" value="${subReg17 + item.reg17}"/>
				                <c:set var="subReg18" value="${subReg18 + item.reg18}"/>
				                <c:set var="subReg19" value="${subReg19 + item.reg19}"/>
				                <c:set var="subReg20" value="${subReg20 + item.reg20}"/>
				                <c:set var="subReg21" value="${subReg21 + item.reg21}"/>
				                <c:set var="subReg22" value="${subReg22 + item.reg22}"/>
				                <c:set var="subReg23" value="${subReg23 + item.reg23}"/>
				                <c:set var="subReg24" value="${subReg24 + item.reg24}"/>
				                <c:set var="subReg25" value="${subReg25 + item.reg25}"/>
				                <c:set var="subReg26" value="${subReg26 + item.reg26}"/>
				                <c:set var="subReg27" value="${subReg27 + item.reg27}"/>
				                <c:set var="subReg28" value="${subReg28 + item.reg28}"/>
				                <c:set var="subReg29" value="${subReg29 + item.reg29}"/>
				                <c:set var="subReg30" value="${subReg30 + item.reg30}"/>
				                <c:set var="subReg31" value="${subReg31 + item.reg31}"/>
				                
				                <c:set var="subDay02" value="${subDay02 + item.day02}"/>
				                <c:set var="subDay03" value="${subDay03 + item.day03}"/>
				                <c:set var="subDay04" value="${subDay04 + item.day04}"/>
				                <c:set var="subDay05" value="${subDay05 + item.day05}"/>
				                <c:set var="subDay06" value="${subDay06 + item.day06}"/>
				                <c:set var="subDay07" value="${subDay07 + item.day07}"/>
				                <c:set var="subDay08" value="${subDay08 + item.day08}"/>
				                <c:set var="subDay09" value="${subDay09 + item.day09}"/>
				                <c:set var="subDay10" value="${subDay10 + item.day10}"/>
				                <c:set var="subDay11" value="${subDay11 + item.day11}"/>
				                <c:set var="subDay12" value="${subDay12 + item.day12}"/>
				                <c:set var="subDay13" value="${subDay13 + item.day13}"/>
				                <c:set var="subDay14" value="${subDay14 + item.day14}"/>
				                <c:set var="subDay15" value="${subDay15 + item.day15}"/>
				                <c:set var="subDay16" value="${subDay16 + item.day16}"/>
				                <c:set var="subDay17" value="${subDay17 + item.day17}"/>
				                <c:set var="subDay18" value="${subDay18 + item.day18}"/>
				                <c:set var="subDay19" value="${subDay19 + item.day19}"/>
				                <c:set var="subDay20" value="${subDay20 + item.day20}"/>
				                <c:set var="subDay21" value="${subDay21 + item.day21}"/>
				                <c:set var="subDay22" value="${subDay22 + item.day22}"/>
				                <c:set var="subDay23" value="${subDay23 + item.day23}"/>
				                <c:set var="subDay24" value="${subDay24 + item.day24}"/>
				                <c:set var="subDay25" value="${subDay25 + item.day25}"/>
				                <c:set var="subDay26" value="${subDay26 + item.day26}"/>
				                <c:set var="subDay27" value="${subDay27 + item.day27}"/>
				                <c:set var="subDay28" value="${subDay28 + item.day28}"/>
				                <c:set var="subDay29" value="${subDay29 + item.day29}"/>
				                <c:set var="subDay30" value="${subDay30 + item.day30}"/>
				                <c:set var="subDay31" value="${subDay31 + item.day31}"/>                
				
				                <c:set var="subTotalSum" value="${subTotalSum + subTotal}"/>
				                <c:set var="subDayTotalSum" value="${subDayTotalSum + subDayTotal}"/>
				                
				                <c:set var="subRegYearCnt" value="${subRegYearCnt + item.regYearCnt}"/>
				                <c:set var="subClsMonthCnt" value="${subClsMonthCnt + item.clsMonthCnt}"/>
				                <c:set var="subClsYearCnt" value="${subClsYearCnt + item.clsYearCnt}"/>
				                <c:set var="subPendingCnt" value="${subPendingCnt + item.pendingCnt}"/>                                          
			                                        
		                    	<p>${subTotal}</p><p class="sub-p">${subDayTotal}</p>
		                    	<td bgcolor="#faebd7"><!--<span style="color: red">-->${item.pendingCnt}<!--</span>--></td>		                    
		                    <td bgcolor="#faebd7">${item.regYearCnt}</td>
		                    <td bgcolor="#faebd7">${item.clsMonthCnt}</td>
		                    <td class="border-right" bgcolor="#faebd7">${item.clsYearCnt}</td>	
		                    <td><p>${item.reg02}</p><p class="sub-p">${item.day02}</p></td>
		                    <td><p>${item.reg03}</p><p class="sub-p">${item.day03}</p></td>
		                    <td><p>${item.reg04}</p><p class="sub-p">${item.day04}</p></td>
		                    <td><p>${item.reg05}</p><p class="sub-p">${item.day05}</p></td>
		                    <td><p>${item.reg06}</p><p class="sub-p">${item.day06}</p></td>
		                    <td><p>${item.reg07}</p><p class="sub-p">${item.day07}</p></td>
		                    <td><p>${item.reg08}</p><p class="sub-p">${item.day08}</p></td>
		                    <td><p>${item.reg09}</p><p class="sub-p">${item.day09}</p></td>
		                    <td><p>${item.reg10}</p><p class="sub-p">${item.day10}</p></td>
		                    <td><p>${item.reg11}</p><p class="sub-p">${item.day11}</p></td>
		                    <td><p>${item.reg12}</p><p class="sub-p">${item.day12}</p></td>
		                    <td><p>${item.reg13}</p><p class="sub-p">${item.day13}</p></td>
		                    <td><p>${item.reg14}</p><p class="sub-p">${item.day14}</p></td>
		                    <td><p>${item.reg15}</p><p class="sub-p">${item.day15}</p></td>
		                    <td><p>${item.reg16}</p><p class="sub-p">${item.day16}</p></td>
		                    <td><p>${item.reg17}</p><p class="sub-p">${item.day17}</p></td>
		                    <td><p>${item.reg18}</p><p class="sub-p">${item.day18}</p></td>
		                    <td><p>${item.reg19}</p><p class="sub-p">${item.day19}</p></td>
		                    <td><p>${item.reg20}</p><p class="sub-p">${item.day20}</p></td>
		                    <td><p>${item.reg21}</p><p class="sub-p">${item.day21}</p></td>
		                    <td><p>${item.reg22}</p><p class="sub-p">${item.day22}</p></td>
		                    <td><p>${item.reg23}</p><p class="sub-p">${item.day23}</p></td>
		                    <td><p>${item.reg24}</p><p class="sub-p">${item.day24}</p></td>
		                    <td><p>${item.reg25}</p><p class="sub-p">${item.day25}</p></td>
		                    <td><p>${item.reg26}</p><p class="sub-p">${item.day26}</p></td>
		                    <td><p>${item.reg27}</p><p class="sub-p">${item.day27}</p></td>
		                    <td><p>${item.reg28}</p><p class="sub-p">${item.day28}</p></td>
		                    <td><p>${item.reg29}</p><p class="sub-p">${item.day29}</p></td>
		                    <td><p>${item.reg30}</p><p class="sub-p">${item.day30}</p></td>
		                    <td><p>${item.reg31}</p><p class="sub-p">${item.day31}</p></td>
		                </tr>		                
		                
		            </c:forEach>
		            <c:set var="totalReg02" value="${totalReg02 + subReg02}"/>
		            <c:set var="totalReg03" value="${totalReg03 + subReg03}"/>
		            <c:set var="totalReg04" value="${totalReg04 + subReg04}"/>
		            <c:set var="totalReg05" value="${totalReg05 + subReg05}"/>
		            <c:set var="totalReg06" value="${totalReg06 + subReg06}"/>
		            <c:set var="totalReg07" value="${totalReg07 + subReg07}"/>
		            <c:set var="totalReg08" value="${totalReg08 + subReg08}"/>
		            <c:set var="totalReg09" value="${totalReg09 + subReg09}"/>
		            <c:set var="totalReg10" value="${totalReg10 + subReg10}"/>
		            <c:set var="totalReg11" value="${totalReg11 + subReg11}"/>
		            <c:set var="totalReg12" value="${totalReg12 + subReg12}"/>
		            <c:set var="totalReg13" value="${totalReg13 + subReg13}"/>
		            <c:set var="totalReg14" value="${totalReg14 + subReg14}"/>
		            <c:set var="totalReg15" value="${totalReg15 + subReg15}"/>
		            <c:set var="totalReg16" value="${totalReg16 + subReg16}"/>
		            <c:set var="totalReg17" value="${totalReg17 + subReg17}"/>
		            <c:set var="totalReg18" value="${totalReg18 + subReg18}"/>
		            <c:set var="totalReg19" value="${totalReg19 + subReg19}"/>
		            <c:set var="totalReg20" value="${totalReg20 + subReg20}"/>
		            <c:set var="totalReg21" value="${totalReg21 + subReg21}"/>
		            <c:set var="totalReg22" value="${totalReg22 + subReg22}"/>
		            <c:set var="totalReg23" value="${totalReg23 + subReg23}"/>
		            <c:set var="totalReg24" value="${totalReg24 + subReg24}"/>
		            <c:set var="totalReg25" value="${totalReg25 + subReg25}"/>
		            <c:set var="totalReg26" value="${totalReg26 + subReg26}"/>
		            <c:set var="totalReg27" value="${totalReg27 + subReg27}"/>
		            <c:set var="totalReg28" value="${totalReg28 + subReg28}"/>
		            <c:set var="totalReg29" value="${totalReg29 + subReg29}"/>
		            <c:set var="totalReg30" value="${totalReg30 + subReg30}"/>
		            <c:set var="totalReg31" value="${totalReg31 + subReg31}"/>
		            <c:set var="totalTotalSum" value="${totalTotalSum + subTotalSum}"/>
		            <c:set var="totalRegYearCnt" value="${totalRegYearCnt + subRegYearCnt}"/>
		            <c:set var="totalClsMonthCnt" value="${totalClsMonthCnt + subClsMonthCnt}"/>
		            <c:set var="totalClsYearCnt" value="${totalClsYearCnt + subClsYearCnt}"/>
		            <c:set var="totalPendingCnt" value="${totalPendingCnt + subPendingCnt}"/>
		            <tr>
		                <th class="border-right" colspan="2">소계</th>
		                <th class="border-right">
		                	<p><fmt:formatNumber value="${subTotalSum}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDayTotalSum}" pattern="#,###"/></p>
		               	</th>
		               	<th><!--<span style="color: red">--><fmt:formatNumber value="${subPendingCnt}" pattern="#,###"/><!--</span>--></th>
		               	<th><fmt:formatNumber value="${subRegYearCnt}" pattern="#,###"/></th>
		                <th><fmt:formatNumber value="${subClsMonthCnt}" pattern="#,###"/></th>
		                <th class="border-right"><fmt:formatNumber value="${subClsYearCnt}" pattern="#,###"/></th>
		                <th>
		                	<p><fmt:formatNumber value="${subReg02}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay02}" pattern="#,###"/></p>
						</th>
		                <th>
		                	<p><fmt:formatNumber value="${subReg03}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay03}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg04}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay04}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg05}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay05}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg06}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay06}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg07}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay07}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg08}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay08}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg09}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay09}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg10}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay10}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg11}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay11}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg12}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay12}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg13}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay13}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg14}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay14}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg15}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay15}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg16}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay16}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg17}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay17}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg18}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay18}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg19}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay19}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg20}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay20}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg21}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay21}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg22}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay22}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg23}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay23}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg24}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay24}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg25}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay25}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg26}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay26}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg27}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay27}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg28}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay28}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg29}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay29}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg30}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay30}" pattern="#,###"/></p>
						</th>
						<th>
		                	<p><fmt:formatNumber value="${subReg31}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${subDay31}" pattern="#,###"/></p>
						</th>                
		            </tr>		            		            
		            
		            <tr>
		                <th class="border-right" colspan="3">합계</th>
		                <th class="border-right">
		                	<p><fmt:formatNumber value="${totalTotalSum+subTotalSum}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDayTotalSum+subDayTotalSum}" pattern="#,###"/></p>
		               	</th>
		               	<th><!--<span style="color: red">--><fmt:formatNumber value="${totalPendingCnt+subPendingCnt}" pattern="#,###"/><!--</span>--></th>
		               	<th><fmt:formatNumber value="${totalRegYearCnt+subRegYearCnt}" pattern="#,###"/></th>
		                <th><fmt:formatNumber value="${totalClsMonthCnt+subClsMonthCnt}" pattern="#,###"/></th>
		                <th class="border-right"><fmt:formatNumber value="${totalClsYearCnt+subClsYearCnt}" pattern="#,###"/></th>
		                <th>
		                	<p><fmt:formatNumber value="${totalReg02+subReg02}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay02+subDay02}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg03+subReg03}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay03+subDay03}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg04+subReg04}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay04+subDay04}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg05+subReg05}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay05+subDay05}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg06+subReg06}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay06+subDay06}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg07+subReg07}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay07+subDay07}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg08+subReg08}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay08+subDay08}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg09+subReg09}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay09+subDay09}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg10+subReg10}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay10+subDay10}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg11+subReg11}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay11+subDay11}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg12+subReg12}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay12+subDay12}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg13+subReg13}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay13+subDay13}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg14+subReg14}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay14+subDay14}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg15+subReg15}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay15+subDay15}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg16+subReg16}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay16+subDay16}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg17+subReg17}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay17+subDay17}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg18+subReg18}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay18+subDay18}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg19+subReg19}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay19+subDay19}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg20+subReg20}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay20+subDay20}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg21+subReg21}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay21+subDay21}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg22+subReg22}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay22+subDay22}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg23+subReg23}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay23+subDay23}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg24+subReg24}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay24+subDay24}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg25+subReg25}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay25+subDay25}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg26+subReg26}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay26+subDay26}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg27+subReg27}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay27+subDay27}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg28+subReg28}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay28+subDay28}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg29+subReg29}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay29+subDay29}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg30+subReg30}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay30+subDay30}" pattern="#,###"/></p>
		               	</th>
		               	<th>
		                	<p><fmt:formatNumber value="${totalReg31+subReg31}" pattern="#,###"/></p>
		                	<p class="sub-p"><fmt:formatNumber value="${totalDay31+subDay31}" pattern="#,###"/></p>
		               	</th>		                
		            </tr>		
		        </table>
		    </div>
		</div>
	</div>
</div>
