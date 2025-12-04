<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="tableStyle2">
    <table cellpadding="0" cellspacing="0" width="1060" align="center" <c:if test="${srchArg.excelYN == 'Y'}">border="1"</c:if>>
		<colgroup>
            <col width="60">
            <col width="47.5">
            <col width="47.5">
            <col width="47.5">
            <col width="47.5">
            <col width="47.5">
            <col width="47.5">
            <col width="47.5">
            <col width="47.5">
            <col width="47.5">
            <col width="47.5">
            <col width="47.5">
            <col width="47.5">
            <col width="47.5">            
            <col width="43.5">
            <col width="43.5">
            <col width="43.5">
            <col width="29.75">
            <col width="29.75">            
            <col width="47.5">
            <col width="47.5">
            <col width="47.5">
        </colgroup>
        <tr>
            <th rowspan="4"><span style="color: black;">구분</span></th>
            <th class="border-right" rowspan="4"><span style="color: black;">접수번호</span></th>
            <th colspan="20">공동수행 반영</th>
        </tr>
        <tr>
            <th colspan="20">인보이스 현황<span style="color: red">(당월)</span></th>
        </tr>
        <tr>
            <th class="border-right" colspan="4">공동수행 반영 전</th>
            <th class="border-right" colspan="4">공동수행지급</th>
            <th class="border-right" colspan="4">공동수행수령</th>
            <th colspan="5">공동수행 반영 후</th>
            <th rowspan="2">자문료</th>
            <th rowspan="2">기타</th>
            <th rowspan="2">합계</th>
        </tr>
        <tr>
            <th>기본료</th>
            <th>일비</th>
            <th>교통비</th>
            <th class="border-right">기준업무량(건)</th>
            <th>기본료</th>
            <th>일비</th>
            <th>교통비</th>
            <th class="border-right">기준업무량(건)</th>
            <th>기본료</th>
            <th>일비</th>
            <th>교통비</th>
            <th class="border-right">기준업무량(건)</th>
            <th>기본료</th>
            <th>일비</th>
            <th>교통비</th>
            <th>기준업무량(건)</th>   
            <th>기준업무환산(건)</th>                                    
        </tr>
        <c:set var="total_amtBasic" value="0"/>
        <c:set var="total_amtDaily" value="0"/>
        <c:set var="total_amtTraffic" value="0"/>
        <fmt:formatNumber var="total_suimRptEa" value="0" pattern="#.###"/>

        <c:set var="total_shareMinusAmtBasic" value="0"/>
        <c:set var="total_shareMinusAmtDaily" value="0"/>
        <c:set var="total_shareMinusAmtTraffic" value="0"/>
        <fmt:formatNumber var="total_shareMinusEa" value="0" pattern="#.###"/>

        <c:set var="total_sharePlusAmtBasic" value="0"/>
        <c:set var="total_sharePlusAmtDaily" value="0"/>
        <c:set var="total_sharePlusAmtTraffic" value="0"/>
        <fmt:formatNumber var="total_sharePlusEa" value="0" pattern="#.###"/>

        <c:set var="total_subTotal" value="0"/>
        <c:set var="total_amtCounsel" value="0"/>
        <c:set var="total_amtEtc" value="0"/>
        <c:set var="total_rowTotal" value="0"/>

        <c:set var="rowspan1" value="0"/>
        <c:set var="rowspan2" value="0"/>
        <c:set var="rowspan1AT" value="0"/>
        <c:set var="rowspan2AT" value="0"/>

        <c:forEach  var="item" items="${detailList}" varStatus="status">
            <c:if test="${item.gubun == 1 || item.gubun == 2 || item.gubun == 3}">
                <c:set var="rowspan1" value="${rowspan1 + 1}"/>
            </c:if>
            <c:if test="${item.gubun == 4 || item.gubun == 5 || item.gubun == 6}">
                <c:set var="rowspan2" value="${rowspan2 + 1}"/>
            </c:if>
        </c:forEach>


        <c:forEach  var="item" items="${detailList}" varStatus="status">
            <tr>
                <c:if test="${rowspan1AT == 0}">
                    <c:if test="${item.gubun == 1 || item.gubun == 2 || item.gubun == 3}">
                        <td rowspan="${rowspan1}" bgcolor="#efefef">본인담당건</td>
                        <c:set var="rowspan1AT" value="1"/>
                    </c:if>
                </c:if>
                <c:if test="${rowspan2AT == 0}">
                    <c:if test="${item.gubun == 4 || item.gubun == 5 || item.gubun == 6}">
                        <td rowspan="${rowspan2}" bgcolor="#efefef">공동 수행건</td>
                        <c:set var="rowspan2AT" value="1"/>
                    </c:if>
                </c:if>
                <%--<td>--%>
                    <%--<c:if test="${item.gubun == 1 || item.gubun == 2 || item.gubun == 3}">본인 담당건</c:if>--%>
                    <%--<c:if test="${item.gubun == 4 || item.gubun == 5 || item.gubun == 6}">공동 수행건</c:if>--%>
                <%--</td>--%>
                <td class="border-right">
                    <c:choose>
                        <c:when test="${srchArg.excelYN == 'Y'}">
                            ${item.suimAcceptNo}
                        </c:when>
                        <c:otherwise>
                            <c:if test="${item.gubun == 1 || item.gubun == 4}">
                                <a href="#noloc" onclick="fnPopSuimDtl('${item.suimRptNo}')">${item.suimAcceptNo}</a>
                            </c:if>
                            <c:if test="${item.gubun == 2 || item.gubun == 3 || item.gubun == 5 || item.gubun == 6}">
                                <a href="#noloc" onclick="fnPopSuimDtlPrim('${item.suimRptNo}')">${item.suimAcceptNo}</a>
                            </c:if>

                        </c:otherwise>
                    </c:choose>
                </td>
                <td class="right"><fmt:formatNumber value="${item.amtBasic}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.amtDaily}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.amtTraffic}" pattern="#,###"/></td>
                <%-- <td class="right border-right"><fmt:formatNumber value="${item.suimRptEa}" pattern="#,###.###"/></td> --%>
                <td class="right border-right"><fmt:formatNumber value="${item.workloadEa}" pattern="#,###.###"/></td>
                
                <td class="right"><span style="color: red"><fmt:formatNumber value="${item.shareMinusAmtBasic}" pattern="#,###"/></span></td>
                <td class="right"><span style="color: red"><fmt:formatNumber value="${item.shareMinusAmtDaily}" pattern="#,###"/></span></td>
                <td class="right"><span style="color: red"><fmt:formatNumber value="${item.shareMinusAmtTraffic}" pattern="#,###"/></span></td>
                <%-- <td class="right border-right"><span style="color: red"><fmt:formatNumber value="${item.shareMinusEa}" pattern="#,###.###"/></span></td> --%>
                <td class="right border-right"><span style="color: red"><fmt:formatNumber value="${item.shareMinusWorkloadEa}" pattern="#,###.###"/></span></td>
                
                <c:choose>
                	<c:when test="${item.gubun == 2 || item.gubun == 3}">
		                <td class="right">0</td>
		                <td class="right">0</td>
		                <td class="right">0</td>
		                <td class="right border-right">0</td>                		
                	</c:when>
                	<c:otherwise>
		                <td class="right"><fmt:formatNumber value="${item.sharePlusAmtBasic}" pattern="#,###"/></td>
		                <td class="right"><fmt:formatNumber value="${item.sharePlusAmtDaily}" pattern="#,###"/></td>
		                <td class="right"><fmt:formatNumber value="${item.sharePlusAmtTraffic}" pattern="#,###"/></td>
		                <%-- <td class="right border-right"><fmt:formatNumber value="${item.sharePlusEa}" pattern="#,###.###"/></td> --%>
		                <td class="right border-right"><fmt:formatNumber value="${item.sharePlusWorkloadEa}" pattern="#,###.###"/></td>
                	</c:otherwise>
                </c:choose>
                
                <c:choose>
                	<c:when test="${item.gubun == 2 || item.gubun == 3 || item.gubun == 5 || item.gubun == 6}">
		                <td class="right"><fmt:formatNumber value="${item.sharePlusAmtBasic}" pattern="#,###"/></td>
		                <td class="right"><fmt:formatNumber value="${item.sharePlusAmtDaily}" pattern="#,###"/></td>
		                <td class="right"><fmt:formatNumber value="${item.sharePlusAmtTraffic}" pattern="#,###"/></td>
		                <%-- <td class="right"><fmt:formatNumber value="${item.sharePlusEa}" pattern="#,###.###"/></td> --%>		                		                
		                <%-- <td class="right"><fmt:formatNumber value="${item.sharePlusWorkloadEa}" pattern="#,###.###"/></td> --%>
		                <td class="right"><fmt:formatNumber value="${item.workloadEa - item.shareMinusWorkloadEa}" pattern="#,###.###"/></td>
		                <td class="right"><fmt:formatNumber value="${item.calcWorkload}" pattern="#,###.###"/><!-- 여기 --></td>
		                <td class="right"><fmt:formatNumber value="${item.sharePlusAmtCounsel}" pattern="#,###"/></td>
		                <td class="right"><fmt:formatNumber value="${item.sharePlusAmtEtc}" pattern="#,###"/></td>
		                <td class="right">
		                	<c:set var="subTotal" value="${item.sharePlusAmtBasic + item.sharePlusAmtDaily + item.sharePlusAmtTraffic}"/>
		                    <c:set var="rowTotal" value="${subTotal + item.sharePlusAmtCounsel + item.sharePlusAmtEtc}"/>
		                    <fmt:formatNumber value="${rowTotal}" pattern="#,###"/>
		                </td>		                	
                	</c:when>
                	<c:otherwise>
		                <td class="right"><fmt:formatNumber value="${item.amtBasic - item.shareMinusAmtBasic + item.sharePlusAmtBasic}" pattern="#,###"/></td>
		                <td class="right"><fmt:formatNumber value="${item.amtDaily - item.shareMinusAmtDaily + item.sharePlusAmtDaily}" pattern="#,###"/></td>
		                <td class="right"><fmt:formatNumber value="${item.amtTraffic - item.shareMinusAmtTraffic + item.sharePlusAmtTraffic}" pattern="#,###"/></td>
		                <%-- <td class="right"><fmt:formatNumber value="${item.suimRptEa - item.shareMinusEa + item.sharePlusEa}" pattern="#,###.###"/></td> --%>		                
		                <td class="right"><fmt:formatNumber value="${item.workloadEa - item.shareMinusWorkloadEa + item.sharePlusWorkloadEa}" pattern="#,###.###"/></td>
		                <td class="right"><fmt:formatNumber value="${item.calcWorkload}" pattern="#,###.###"/></td>
		                
		                <td class="right"><fmt:formatNumber value="${item.amtCounsel}" pattern="#,###"/></td>
		                <td class="right"><fmt:formatNumber value="${item.amtEtc}" pattern="#,###"/></td>
		                
		                <td class="right">
		                	<c:set var="subTotal" value="${item.amtBasic + item.amtDaily - item.shareMinusAmtBasic - item.shareMinusAmtDaily - item.shareMinusAmtTraffic + item.sharePlusAmtBasic + item.sharePlusAmtDaily + item.sharePlusAmtTraffic}"/>
		                    <c:set var="rowTotal" value="${subTotal + item.amtTraffic + item.amtCounsel + item.amtEtc}"/>
		                    <fmt:formatNumber value="${rowTotal}" pattern="#,###"/>
		                </td>
                	</c:otherwise>
                </c:choose>                
            </tr>
            <c:set var="total_amtBasic" value="${total_amtBasic + item.amtBasic}"/>
            <c:set var="total_amtDaily" value="${total_amtDaily + item.amtDaily}"/>
            <c:set var="total_amtTraffic" value="${total_amtTraffic + item.amtTraffic}"/>

            <fmt:formatNumber var="total_suimRptEa" value="${total_suimRptEa + item.suimRptEa}" pattern="#.###"/>
            <fmt:formatNumber var="total_workloadEa" value="${total_workloadEa + item.workloadEa}" pattern="#.###"/>

            <c:set var="total_shareMinusAmtBasic" value="${total_shareMinusAmtBasic + item.shareMinusAmtBasic}"/>
            <c:set var="total_shareMinusAmtDaily" value="${total_shareMinusAmtDaily + item.shareMinusAmtDaily}"/>
            <c:set var="total_shareMinusAmtTraffic" value="${total_shareMinusAmtTraffic + item.shareMinusAmtTraffic}"/>            
            <fmt:formatNumber var="total_shareMinusEa" value="${total_shareMinusEa + item.shareMinusEa}" pattern="#.###"/>
            <fmt:formatNumber var="total_shareMinusWorkloadEa" value="${total_shareMinusWorkloadEa + item.shareMinusWorkloadEa}" pattern="#.###"/>

			<c:if test="${item.gubun != 2 && item.gubun != 3}">
	            <c:set var="total_sharePlusAmtBasic" value="${total_sharePlusAmtBasic + item.sharePlusAmtBasic}"/>
	            <c:set var="total_sharePlusAmtDaily" value="${total_sharePlusAmtDaily + item.sharePlusAmtDaily}"/>
	            <c:set var="total_sharePlusAmtTraffic" value="${total_sharePlusAmtTraffic + item.sharePlusAmtTraffic}"/>
	            <fmt:formatNumber var="total_sharePlusEa" value="${total_sharePlusEa + item.sharePlusEa}" pattern="#.###"/>
	            <fmt:formatNumber var="total_sharePlusWorkloadEa" value="${total_sharePlusWorkloadEa + item.sharePlusWorkloadEa}" pattern="#.###"/>
			</c:if>			
			<c:choose>
            	<c:when test="${item.gubun == 2 || item.gubun == 3 || item.gubun == 5 || item.gubun == 6 }">
		            <c:set var="total_sumShareAmtBasic" value="${total_sumShareAmtBasic + item.sharePlusAmtBasic}"/>
		            <c:set var="total_sumShareAmtDaily" value="${total_sumShareAmtDaily + item.sharePlusAmtDaily}"/>
		            <c:set var="total_sumShareAmtTraffic" value="${total_sumShareAmtTraffic + item.sharePlusAmtTraffic}"/>
		            <c:set var="total_sumShareSuimRptEa" value="${total_sumShareSuimRptEa + item.sharePlusEa}"/>
		            <c:set var="total_amtCounsel" value="${total_amtCounsel + item.sharePlusAmtCounsel}"/>
		            <c:set var="total_amtEtc" value="${total_amtEtc + item.sharePlusAmtEtc}"/>            	
            	</c:when>
            	<c:otherwise>
		            <c:set var="total_sumShareAmtBasic" value="${total_sumShareAmtBasic + item.amtBasic - item.shareMinusAmtBasic + item.sharePlusAmtBasic }"/>
		            <c:set var="total_sumShareAmtDaily" value="${total_sumShareAmtDaily + item.amtDaily - item.shareMinusAmtDaily + item.sharePlusAmtDaily }"/>
		            <c:set var="total_sumShareAmtTraffic" value="${total_sumShareAmtTraffic + item.amtTraffic - item.shareMinusAmtTraffic + item.sharePlusAmtTraffic }"/>
		            <c:set var="total_sumShareSuimRptEa" value="${total_sumShareSuimRptEa + item.suimRptEa - item.shareMinusEa + item.sharePlusEa }"/>
		            <c:set var="total_amtCounsel" value="${total_amtCounsel + item.amtCounsel}"/>
		            <c:set var="total_amtEtc" value="${total_amtEtc + item.amtEtc}"/>
            	</c:otherwise>
            </c:choose>
            <fmt:formatNumber var="total_calcWorkload" value="${total_calcWorkload + item.calcWorkload}" pattern="#.###"/>
            <c:set var="total_subTotal" value="${total_subTotal + subTotal}"/>
            <c:set var="total_rowTotal" value="${total_rowTotal + rowTotal}"/>
        </c:forEach>
        <tr>
            <th class="border-right" colspan="2">합계</th>
            <th class="right"><fmt:formatNumber value="${total_amtBasic}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${total_amtDaily}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${total_amtTraffic}" pattern="#,###"/></th>
            <%-- <th class="right border-right"><fmt:formatNumber value="${total_suimRptEa}" pattern="#,###.###"/></th> --%>
            <th class="right border-right"><fmt:formatNumber value="${total_workloadEa}" pattern="#,###.###"/></th>
            
            <th class="right"><span style="color: red"><fmt:formatNumber value="${total_shareMinusAmtBasic}" pattern="#,###"/></span></th>
            <th class="right"><span style="color: red"><fmt:formatNumber value="${total_shareMinusAmtDaily}" pattern="#,###"/></span></th>
            <th class="right"><span style="color: red"><fmt:formatNumber value="${total_shareMinusAmtTraffic}" pattern="#,###"/></span></th>
            <%-- <th class="right border-right"><span style="color: red"><fmt:formatNumber value="${total_shareMinusEa}" pattern="#,###.###"/></span></th> --%>
            <th class="right border-right"><span style="color: red"><fmt:formatNumber value="${total_shareMinusWorkloadEa}" pattern="#,###.###"/></span></th>
            
            <th class="right"><fmt:formatNumber value="${total_sharePlusAmtBasic}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${total_sharePlusAmtDaily}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${total_sharePlusAmtTraffic}" pattern="#,###"/></th>
            <%-- <th class="right border-right"><fmt:formatNumber value="${total_sharePlusEa}" pattern="#,###.###"/>여긴가</th> --%>
            <th class="right border-right"><fmt:formatNumber value="${total_sharePlusWorkloadEa}" pattern="#,###.###"/></th>          
                                   
            <th class="right"><fmt:formatNumber value="${total_sumShareAmtBasic}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${total_sumShareAmtDaily}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${total_sumShareAmtTraffic}" pattern="#,###"/></th>            
            
            <%-- <th class="right"><fmt:formatNumber value="${total_sumShareSuimRptEa}" pattern="#,###.###"/></th> --%>
            <th class="right"><fmt:formatNumber value="${total_workloadEa-total_shareMinusWorkloadEa+total_sharePlusWorkloadEa}" pattern="#,###.###"/></th>
            <%-- <th class="right"><fmt:formatNumber value="${total_sumShareSuimRptEa}" pattern="#,###.###"/></th> --%>
            <th class="right"><fmt:formatNumber value="${total_calcWorkload}" pattern="#,###.###"/></th><!-- 환산합계 -->       
            
            <th class="right"><fmt:formatNumber value="${total_amtCounsel}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${total_amtEtc}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${total_rowTotal}" pattern="#,###"/></th>
        </tr>
    </table>
</div>
<!-- 미수금 내역 -->
<table align="center" cellpadding="0" cellspacing="0" width="1060">
    <tr>
        <td width="100%" height="30">
            <p><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0"> <b><font color="black">미수금내역</font></b></p>
        </td>
    </tr>
</table>
<div class="tableStyle2">
    <table cellpadding="0" cellspacing="0" width="1060" align="center" <c:if test="${srchArg.excelYN == 'Y'}">border="1"</c:if>>
        <colgroup>
            <col width="60">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
        </colgroup>
        <tr>
            <th>NO</th>
            <th>보험사</th>
            <th>접수번호</th>
            <th>계약자</th>
            <th>피보험자</th>
            <th>종결일</th>
            <th>기본보수</th>
            <th>일비</th>
            <th>교통비</th>
            <th>자문료</th>
            <th>기타</th>
            <th>미수금</th>
        </tr>
        <c:set var="cnt" value="${detailOutAmtList.size()}"/>
        <c:set var="oTotal_amtBasic_01" value="0"/>
        <c:set var="oTotal_amtDaily_01" value="0"/>
        <c:set var="oTotal_amtTraffic_01" value="0"/>
        <c:set var="oTotal_amtCounsel_01" value="0"/>
        <c:set var="oTotal_amtEtc_01" value="0"/>
        <c:set var="oTotal_outAmt_01" value="0"/>
    
        <c:forEach  var="item" items="${detailOutAmtList}" varStatus="status">
            <tr>
                <td>${cnt - status.index}</td>
                <td>${item.ptnrNm}</td>
                <td>
                    <c:choose>
                        <c:when test="${srchArg.excelYN == 'Y'}">
                            ${item.suimAcceptNo}
                        </c:when>
                        <c:otherwise>
                            <c:if test="${item.gubun == 1}">
                                <a href="#noloc" onclick="fnPopSuimDtl('${item.suimRptNo}')">${item.suimAcceptNo}</a>
                            </c:if>
                            <c:if test="${item.gubun == 2 || item.gubun == 3}">
                                <a href="#noloc" onclick="fnPopSuimDtlPrim('${item.suimRptNo}')">${item.suimAcceptNo}</a>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${item.policyholderNm}</td>
                <td>${item.beneficiaryNm}</td>
                <td>${item.closeDate}</td>
                <td class="right"><fmt:formatNumber value="${item.amtBasic}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.amtDaily}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.amtTraffic}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.amtCounsel}" pattern="#,###"/></td>
                <td class="right"><fmt:formatNumber value="${item.amtEtc}" pattern="#,###"/></td>
                <td class="right">
                    <span style="color: red;"><fmt:formatNumber value="${item.outAmt}" pattern="#,###"/></span>
                </td>
            </tr>
            <c:set var="oTotal_amtBasic_01" value="${oTotal_amtBasic_01 + item.amtBasic}"/>
            <c:set var="oTotal_amtDaily_01" value="${oTotal_amtDaily_01 + item.amtDaily}"/>
            <c:set var="oTotal_amtTraffic_01" value="${oTotal_amtTraffic_01 + item.amtTraffic}"/>
            <c:set var="oTotal_amtCounsel_01" value="${oTotal_amtCounsel_01 + item.amtCounsel}"/>
            <c:set var="oTotal_amtEtc_01" value="${oTotal_amtEtc_01 + item.amtEtc}"/>
            <c:set var="oTotal_outAmt_01" value="${oTotal_outAmt_01 + item.outAmt}"/>
        </c:forEach>
        <tr>
            <th colspan="6">미수금 합계</th>
            <th class="right"><fmt:formatNumber value="${oTotal_amtBasic_01}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${oTotal_amtDaily_01}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${oTotal_amtTraffic_01}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${oTotal_amtCounsel_01}" pattern="#,###"/></th>
            <th class="right"><fmt:formatNumber value="${oTotal_amtEtc_01}" pattern="#,###"/></th>
            <th class="right">
                <span style="color: red;"><fmt:formatNumber value="${oTotal_outAmt_01}" pattern="#,###"/></span>
            </th>
        </tr>
    </table>
</div>
