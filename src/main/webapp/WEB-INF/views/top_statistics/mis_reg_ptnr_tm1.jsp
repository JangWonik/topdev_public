<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="tableStyle2">
    <div style="padding-right: 17px; background: #e7ecf1;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
            <thead>
            <tr>
                <th>Type</th>
                <th style="width: 150px;">센터</th>                
                <th style="width: 150px;">부서</th>
                <th>구분</th>
                <th>${nowVO.monBefore11.substring(0,7)}</th>
                <th>${nowVO.monBefore10.substring(0,7)}</th>
                <th>${nowVO.monBefore9.substring(0,7)}</th>
                <th>${nowVO.monBefore8.substring(0,7)}</th>
                <th>${nowVO.monBefore7.substring(0,7)}</th>
                <th>${nowVO.monBefore6.substring(0,7)}</th>
                <th>${nowVO.monBefore5.substring(0,7)}</th>
                <th>${nowVO.monBefore4.substring(0,7)}</th>
                <th>${nowVO.monBefore3.substring(0,7)}</th>
                <th>${nowVO.monBefore2.substring(0,7)}</th>
                <th>${nowVO.monBefore1.substring(0,7)}</th>
                <th>${nowVO.monBefore0.substring(0,7)}</th>
                <th>합계</th>
            </tr>
            </thead>
        </table>
    </div>
    
    <div style="height:654px; overflow-x: hidden; overflow-y: auto;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
            <tbody>
            <c:forEach var="vo" items="${MisRegPtnrTm1}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center; cursor: pointer;" 
                	onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
                	onClick="goMisRegPtnrTmMbr('${vo.team_id}','${vo.team_type}','${srchArg.ptnr_id}','${srchArg.ptnr_nick}');">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisRegPtnrTm1.size() + 1}">1종</td>
                    </c:if>
                    <td style="width: 150px;">${vo.center_name}</td>                    
                    <td style="width: 150px;">${vo.team_name}</td>
                    <td>수임<br /><br />종결</td>
                    <td>${vo.reg_12}<br /><br />${vo.cls_12}</td>
                    <td>${vo.reg_11}<br /><br />${vo.cls_11}</td>
                    <td>${vo.reg_10}<br /><br />${vo.cls_10}</td>
                    <td>${vo.reg_9}<br /><br />${vo.cls_9}</td>
                    <td>${vo.reg_8}<br /><br />${vo.cls_8}</td>
                    <td>${vo.reg_7}<br /><br />${vo.cls_7}</td>
                    <td>${vo.reg_6}<br /><br />${vo.cls_6}</td>
                    <td>${vo.reg_5}<br /><br />${vo.cls_5}</td>
                    <td>${vo.reg_4}<br /><br />${vo.cls_4}</td>
                    <td>${vo.reg_3}<br /><br />${vo.cls_3}</td>
                    <td>${vo.reg_2}<br /><br />${vo.cls_2}</td>
                    <td>${vo.reg_1}<br /><br />${vo.cls_1}</td>
                    <td>${vo.reg_12+vo.reg_11+vo.reg_10+vo.reg_9+vo.reg_8+vo.reg_7+vo.reg_6+vo.reg_5+vo.reg_4+vo.reg_3+vo.reg_2+vo.reg_1}
                        <br /><br />
                            ${vo.cls_12+vo.cls_11+vo.cls_10+vo.cls_9+vo.cls_8+vo.cls_7+vo.cls_6+vo.cls_5+vo.cls_4+vo.cls_3+vo.cls_2+vo.cls_1}
                    </td>
                </tr>
                <c:set var="sumReg_12" value="${sumReg_12 + vo.reg_12}" />
                <c:set var="sumReg_11" value="${sumReg_11 + vo.reg_11}" />
                <c:set var="sumReg_10" value="${sumReg_10 + vo.reg_10}" />
                <c:set var="sumReg_9" value="${sumReg_9 + vo.reg_9}" />
                <c:set var="sumReg_8" value="${sumReg_8 + vo.reg_8}" />
                <c:set var="sumReg_7" value="${sumReg_7 + vo.reg_7}" />
                <c:set var="sumReg_6" value="${sumReg_6 + vo.reg_6}" />
                <c:set var="sumReg_5" value="${sumReg_5 + vo.reg_5}" />
                <c:set var="sumReg_4" value="${sumReg_4 + vo.reg_4}" />
                <c:set var="sumReg_3" value="${sumReg_3 + vo.reg_3}" />
                <c:set var="sumReg_2" value="${sumReg_2 + vo.reg_2}" />
                <c:set var="sumReg_1" value="${sumReg_1 + vo.reg_1}" />
                <c:set var="sumReg_sum" value="${sumReg_sum + vo.reg_12+vo.reg_11+vo.reg_10+vo.reg_9+vo.reg_8+vo.reg_7+vo.reg_6+vo.reg_5+vo.reg_4+vo.reg_3+vo.reg_2+vo.reg_1}" />
                <c:set var="sumCls_12" value="${sumCls_12 + vo.cls_12}" />
                <c:set var="sumCls_11" value="${sumCls_11 + vo.cls_11}" />
                <c:set var="sumCls_10" value="${sumCls_10 + vo.cls_10}" />
                <c:set var="sumCls_9" value="${sumCls_9 + vo.cls_9}" />
                <c:set var="sumCls_8" value="${sumCls_8 + vo.cls_8}" />
                <c:set var="sumCls_7" value="${sumCls_7 + vo.cls_7}" />
                <c:set var="sumCls_6" value="${sumCls_6 + vo.cls_6}" />
                <c:set var="sumCls_5" value="${sumCls_5 + vo.cls_5}" />
                <c:set var="sumCls_4" value="${sumCls_4 + vo.cls_4}" />
                <c:set var="sumCls_3" value="${sumCls_3 + vo.cls_3}" />
                <c:set var="sumCls_2" value="${sumCls_2 + vo.cls_2}" />
                <c:set var="sumCls_1" value="${sumCls_1 + vo.cls_1}" />
                <c:set var="sumCls_sum" value="${sumCls_sum + vo.cls_12+vo.cls_11+vo.cls_10+vo.cls_9+vo.cls_8+vo.cls_7+vo.cls_6+vo.cls_5+vo.cls_4+vo.cls_3+vo.cls_2+vo.cls_1}" />
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">1종 소계</td>
                <td>수임<br /><br />종결</td>
                <td>${sumReg_12}<br /><br />${sumCls_12}</td>
                <td>${sumReg_11}<br /><br />${sumCls_11}</td>
                <td>${sumReg_10}<br /><br />${sumCls_10}</td>
                <td>${sumReg_9}<br /><br />${sumCls_9}</td>
                <td>${sumReg_8}<br /><br />${sumCls_8}</td>
                <td>${sumReg_7}<br /><br />${sumCls_7}</td>
                <td>${sumReg_6}<br /><br />${sumCls_6}</td>
                <td>${sumReg_5}<br /><br />${sumCls_5}</td>
                <td>${sumReg_4}<br /><br />${sumCls_4}</td>
                <td>${sumReg_3}<br /><br />${sumCls_3}</td>
                <td>${sumReg_2}<br /><br />${sumCls_2}</td>
                <td>${sumReg_1}<br /><br />${sumCls_1}</td>
                <td>${sumReg_sum}<br /><br />${sumCls_sum}</td>
            </tr>
            <c:forEach var="vo" items="${MisRegPtnrTm4}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center; cursor:pointer" 
                	onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''"
                   	onClick="goMisRegPtnrTmMbr('${vo.team_id}','${vo.team_type}','${srchArg.ptnr_id}','${srchArg.ptnr_nick}');">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisRegPtnrTm4.size() + 1}">4종</td>
                    </c:if>
                    <td>${vo.center_name}</td>
                    <td>${vo.team_name}</td>
                    <td>수임<br /><br />종결</td>
                    <td>${vo.reg_12}<br /><br />${vo.cls_12}</td>
                    <td>${vo.reg_11}<br /><br />${vo.cls_11}</td>
                    <td>${vo.reg_10}<br /><br />${vo.cls_10}</td>
                    <td>${vo.reg_9}<br /><br />${vo.cls_9}</td>
                    <td>${vo.reg_8}<br /><br />${vo.cls_8}</td>
                    <td>${vo.reg_7}<br /><br />${vo.cls_7}</td>
                    <td>${vo.reg_6}<br /><br />${vo.cls_6}</td>
                    <td>${vo.reg_5}<br /><br />${vo.cls_5}</td>
                    <td>${vo.reg_4}<br /><br />${vo.cls_4}</td>
                    <td>${vo.reg_3}<br /><br />${vo.cls_3}</td>
                    <td>${vo.reg_2}<br /><br />${vo.cls_2}</td>
                    <td>${vo.reg_1}<br /><br />${vo.cls_1}</td>
                    <td>${vo.reg_12+vo.reg_11+vo.reg_10+vo.reg_9+vo.reg_8+vo.reg_7+vo.reg_6+vo.reg_5+vo.reg_4+vo.reg_3+vo.reg_2+vo.reg_1}
                        <br /><br />
                            ${vo.cls_12+vo.cls_11+vo.cls_10+vo.cls_9+vo.cls_8+vo.cls_7+vo.cls_6+vo.cls_5+vo.cls_4+vo.cls_3+vo.cls_2+vo.cls_1}
                    </td>
                </tr>
                <c:set var="sumReg4_12" value="${sumReg4_12 + vo.reg_12}" />
                <c:set var="sumReg4_11" value="${sumReg4_11 + vo.reg_11}" />
                <c:set var="sumReg4_10" value="${sumReg4_10 + vo.reg_10}" />
                <c:set var="sumReg4_9" value="${sumReg4_9 + vo.reg_9}" />
                <c:set var="sumReg4_8" value="${sumReg4_8 + vo.reg_8}" />
                <c:set var="sumReg4_7" value="${sumReg4_7 + vo.reg_7}" />
                <c:set var="sumReg4_6" value="${sumReg4_6 + vo.reg_6}" />
                <c:set var="sumReg4_5" value="${sumReg4_5 + vo.reg_5}" />
                <c:set var="sumReg4_4" value="${sumReg4_4 + vo.reg_4}" />
                <c:set var="sumReg4_3" value="${sumReg4_3 + vo.reg_3}" />
                <c:set var="sumReg4_2" value="${sumReg4_2 + vo.reg_2}" />
                <c:set var="sumReg4_1" value="${sumReg4_1 + vo.reg_1}" />
                <c:set var="sumReg4_sum" value="${sumReg4_sum + vo.reg_12+vo.reg_11+vo.reg_10+vo.reg_9+vo.reg_8+vo.reg_7+vo.reg_6+vo.reg_5+vo.reg_4+vo.reg_3+vo.reg_2+vo.reg_1}" />
                <c:set var="sumCls4_12" value="${sumCls4_12 + vo.cls_12}" />
                <c:set var="sumCls4_11" value="${sumCls4_11 + vo.cls_11}" />
                <c:set var="sumCls4_10" value="${sumCls4_10 + vo.cls_10}" />
                <c:set var="sumCls4_9" value="${sumCls4_9 + vo.cls_9}" />
                <c:set var="sumCls4_8" value="${sumCls4_8 + vo.cls_8}" />
                <c:set var="sumCls4_7" value="${sumCls4_7 + vo.cls_7}" />
                <c:set var="sumCls4_6" value="${sumCls4_6 + vo.cls_6}" />
                <c:set var="sumCls4_5" value="${sumCls4_5 + vo.cls_5}" />
                <c:set var="sumCls4_4" value="${sumCls4_4 + vo.cls_4}" />
                <c:set var="sumCls4_3" value="${sumCls4_3 + vo.cls_3}" />
                <c:set var="sumCls4_2" value="${sumCls4_2 + vo.cls_2}" />
                <c:set var="sumCls4_1" value="${sumCls4_1 + vo.cls_1}" />
                <c:set var="sumCls4_sum" value="${sumCls4_sum + vo.cls_12+vo.cls_11+vo.cls_10+vo.cls_9+vo.cls_8+vo.cls_7+vo.cls_6+vo.cls_5+vo.cls_4+vo.cls_3+vo.cls_2+vo.cls_1}" />
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">4종 소계</td>
                <td>수임<br /><br />종결</td>
                <td>${sumReg4_12}<br /><br />${sumCls4_12}</td>
                <td>${sumReg4_11}<br /><br />${sumCls4_11}</td>
                <td>${sumReg4_10}<br /><br />${sumCls4_10}</td>
                <td>${sumReg4_9}<br /><br />${sumCls4_9}</td>
                <td>${sumReg4_8}<br /><br />${sumCls4_8}</td>
                <td>${sumReg4_7}<br /><br />${sumCls4_7}</td>
                <td>${sumReg4_6}<br /><br />${sumCls4_6}</td>
                <td>${sumReg4_5}<br /><br />${sumCls4_5}</td>
                <td>${sumReg4_4}<br /><br />${sumCls4_4}</td>
                <td>${sumReg4_3}<br /><br />${sumCls4_3}</td>
                <td>${sumReg4_2}<br /><br />${sumCls4_2}</td>
                <td>${sumReg4_1}<br /><br />${sumCls4_1}</td>
                <td>${sumReg4_sum}<br /><br />${sumCls4_sum}</td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="3">합계</td>
                <td>수임<br /><br />종결</td>
                <td>${sumReg_12+sumReg4_12}<br /><br />${sumCls_12+sumCls4_12}</td>
                <td>${sumReg_11+sumReg4_11}<br /><br />${sumCls_11+sumCls4_11}</td>
                <td>${sumReg_10+sumReg4_10}<br /><br />${sumCls_10+sumCls4_10}</td>
                <td>${sumReg_9+sumReg4_9}<br /><br />${sumCls_9+sumCls4_9}</td>
                <td>${sumReg_8+sumReg4_8}<br /><br />${sumCls_8+sumCls4_8}</td>
                <td>${sumReg_7+sumReg4_7}<br /><br />${sumCls_7+sumCls4_7}</td>
                <td>${sumReg_6+sumReg4_6}<br /><br />${sumCls_6+sumCls4_6}</td>
                <td>${sumReg_5+sumReg4_5}<br /><br />${sumCls_5+sumCls4_5}</td>
                <td>${sumReg_4+sumReg4_4}<br /><br />${sumCls_4+sumCls4_4}</td>
                <td>${sumReg_3+sumReg4_3}<br /><br />${sumCls_3+sumCls4_3}</td>
                <td>${sumReg_2+sumReg4_2}<br /><br />${sumCls_2+sumCls4_2}</td>
                <td>${sumReg_1+sumReg4_1}<br /><br />${sumCls_1+sumCls4_1}</td>
                <td>${sumReg_sum+sumReg4_sum}<br /><br />${sumCls_sum+sumCls4_sum}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
