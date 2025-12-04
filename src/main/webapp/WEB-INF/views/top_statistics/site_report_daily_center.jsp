<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2">
    <div style="background: #e7ecf1;">
        <table>
            <tr>
                <th width="160px">센터명</th>                
                <th width="30px" title="${nowVO.dayBefore30}">${nowVO.dayBefore30.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore29}">${nowVO.dayBefore29.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore28}">${nowVO.dayBefore28.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore27}">${nowVO.dayBefore27.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore26}">${nowVO.dayBefore26.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore25}">${nowVO.dayBefore25.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore24}">${nowVO.dayBefore24.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore23}">${nowVO.dayBefore23.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore22}">${nowVO.dayBefore22.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore21}">${nowVO.dayBefore21.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore20}">${nowVO.dayBefore20.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore19}">${nowVO.dayBefore19.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore18}">${nowVO.dayBefore18.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore17}">${nowVO.dayBefore17.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore16}">${nowVO.dayBefore16.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore15}">${nowVO.dayBefore15.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore14}">${nowVO.dayBefore14.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore13}">${nowVO.dayBefore13.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore12}">${nowVO.dayBefore12.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore11}">${nowVO.dayBefore11.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore10}">${nowVO.dayBefore10.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore9}">${nowVO.dayBefore9.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore8}">${nowVO.dayBefore8.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore7}">${nowVO.dayBefore7.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore6}">${nowVO.dayBefore6.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore5}">${nowVO.dayBefore5.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore4}">${nowVO.dayBefore4.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore3}">${nowVO.dayBefore3.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore2}">${nowVO.dayBefore2.substring(8,10)}</th>
                <th width="30px" title="${nowVO.dayBefore1}">${nowVO.dayBefore1.substring(8,10)}</th>                                
            </tr>            
        </table>
    </div>
    <div style="height:630px; overflow-x: hidden; overflow-y: auto;">
        <table>            
            <c:forEach var="center" items="${centerList}" varStatus="status">            	
                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                	<td width="160px">
                		${center.center_name}
                		<!-- 그래프 추가 -->
                		<a href="javascript:openSiteChartDetail('C','${center.team_center}','${stdBgnde}');">
            				<img src="./resources/chart/chart_icon.png"/>
            			</a>
                	</td>                	
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore30}');"><fmt:formatNumber value="${center.over_per_30}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore29}');"><fmt:formatNumber value="${center.over_per_29}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore28}');"><fmt:formatNumber value="${center.over_per_28}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore27}');"><fmt:formatNumber value="${center.over_per_27}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore26}');"><fmt:formatNumber value="${center.over_per_26}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore25}');"><fmt:formatNumber value="${center.over_per_25}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore24}');"><fmt:formatNumber value="${center.over_per_24}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore23}');"><fmt:formatNumber value="${center.over_per_23}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore22}');"><fmt:formatNumber value="${center.over_per_22}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore21}');"><fmt:formatNumber value="${center.over_per_21}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore20}');"><fmt:formatNumber value="${center.over_per_20}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore19}');"><fmt:formatNumber value="${center.over_per_19}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore18}');"><fmt:formatNumber value="${center.over_per_18}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore17}');"><fmt:formatNumber value="${center.over_per_17}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore16}');"><fmt:formatNumber value="${center.over_per_16}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore15}');"><fmt:formatNumber value="${center.over_per_15}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore14}');"><fmt:formatNumber value="${center.over_per_14}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore13}');"><fmt:formatNumber value="${center.over_per_13}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore12}');"><fmt:formatNumber value="${center.over_per_12}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore11}');"><fmt:formatNumber value="${center.over_per_11}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore10}');"><fmt:formatNumber value="${center.over_per_10}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore9}');"><fmt:formatNumber value="${center.over_per_9}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore8}');"><fmt:formatNumber value="${center.over_per_8}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore7}');"><fmt:formatNumber value="${center.over_per_7}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore6}');"><fmt:formatNumber value="${center.over_per_6}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore5}');"><fmt:formatNumber value="${center.over_per_5}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore4}');"><fmt:formatNumber value="${center.over_per_4}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore3}');"><fmt:formatNumber value="${center.over_per_3}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore2}');"><fmt:formatNumber value="${center.over_per_2}" type="number"/></a></td>
                	<td width="30px"><a href="javascript:openSiteReportDetail('C','${center.team_center}','${nowVO.dayBefore1}');"><fmt:formatNumber value="${center.over_per_1}" type="number"/></a></td>                	
                </tr>
			</c:forEach>    
        </table>
    </div>
</div>
