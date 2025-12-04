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
	<div style="height:634px; overflow-x: hidden; overflow-y: auto;">
        <table cellpadding="0" cellspacing="0" width="1060" align="center">
            <tbody>
            <c:forEach var="vo" items="${MisEndPtnrTm1}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisEndPtnrTm1.size() + 1}">1종</td>
                    </c:if>
                    <td style="width: 150px;">${vo.center_name}</td>
                    <td style="width: 150px;">${vo.team_name}</td>
                    <td>
                        <c:out value="${vo.getEnd_rid12()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid11()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid10()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid9()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid8()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid7()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid6()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid5()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid4()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid3()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid2()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.getEnd_rid()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo.end_rid12+vo.end_rid11+vo.end_rid10+vo.end_rid9+vo.end_rid8+vo.end_rid7+vo.end_rid6+vo.end_rid5+vo.end_rid4+vo.end_rid3+vo.end_rid2+vo.end_rid}"	/>
                    </td>
                </tr>
                <c:set var="sumEnd_12" value="${sumEnd_12 + vo.end_rid12}" />
                <c:set var="sumEnd_11" value="${sumEnd_11 + vo.end_rid11}" />
                <c:set var="sumEnd_10" value="${sumEnd_10 + vo.end_rid10}" />
                <c:set var="sumEnd_9" value="${sumEnd_9 + vo.end_rid9}" />
                <c:set var="sumEnd_8" value="${sumEnd_8 + vo.end_rid8}" />
                <c:set var="sumEnd_7" value="${sumEnd_7 + vo.end_rid7}" />
                <c:set var="sumEnd_6" value="${sumEnd_6 + vo.end_rid6}" />
                <c:set var="sumEnd_5" value="${sumEnd_5 + vo.end_rid5}" />
                <c:set var="sumEnd_4" value="${sumEnd_4 + vo.end_rid4}" />
                <c:set var="sumEnd_3" value="${sumEnd_3 + vo.end_rid3}" />
                <c:set var="sumEnd_2" value="${sumEnd_2 + vo.end_rid2}" />
                <c:set var="sumEnd" value="${sumEnd + vo.end_rid}" />
                <c:set var="sumEnd_sum" value="${sumEnd_sum + vo.end_rid12+vo.end_rid11+vo.end_rid10+vo.end_rid9+vo.end_rid8+vo.end_rid7+vo.end_rid6+vo.end_rid5+vo.end_rid4+vo.end_rid3+vo.end_rid2+vo.end_rid}" />
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">1종 소계</td>
                <td>${sumEnd_12}</td>
                <td>${sumEnd_11}</td>
                <td>${sumEnd_10}</td>
                <td>${sumEnd_9}</td>
                <td>${sumEnd_8}</td>
                <td>${sumEnd_7}</td>
                <td>${sumEnd_6}</td>
                <td>${sumEnd_5}</td>
                <td>${sumEnd_4}</td>
                <td>${sumEnd_3}</td>
                <td>${sumEnd_2}</td>
                <td>${sumEnd}</td>
                <td>${sumEnd_sum}</td>
            </tr>

            <c:forEach var="vo4" items="${MisEndPtnrTm4}" varStatus="status">
                <tr style="bgcolor: #E7ECF1; text-align: center;" onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
                    <c:if test="${status.index == 0}">
                        <td rowspan="${MisEndPtnrTm4.size() + 1}">4종</td>
                    </c:if>
                    <td style="width: 150px;">${vo4.center_name}</td>
                    <td style="width: 150px;">${vo4.team_name}</td>
                    <td>
                        <c:out value="${vo4.getEnd_rid12()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid11()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid10()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid9()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid8()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid7()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid6()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid5()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid4()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid3()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid2()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.getEnd_rid()}" /><br>
                    </td>
                    <td>
                        <c:out value="${vo4.end_rid12+vo4.end_rid11+vo4.end_rid10+vo4.end_rid9+vo4.end_rid8+vo4.end_rid7+vo4.end_rid6+vo4.end_rid5+vo4.end_rid4+vo4.end_rid3+vo4.end_rid2+vo4.end_rid}"	/>
                    </td>
                </tr>

                <c:set var="sumEnd4_12" value="${sumEnd4_12 + vo4.end_rid12}" />
                <c:set var="sumEnd4_11" value="${sumEnd4_11 + vo4.end_rid11}" />
                <c:set var="sumEnd4_10" value="${sumEnd4_10 + vo4.end_rid10}" />
                <c:set var="sumEnd4_9" value="${sumEnd4_9 + vo4.end_rid9}" />
                <c:set var="sumEnd4_8" value="${sumEnd4_8 + vo4.end_rid8}" />
                <c:set var="sumEnd4_7" value="${sumEnd4_7 + vo4.end_rid7}" />
                <c:set var="sumEnd4_6" value="${sumEnd4_6 + vo4.end_rid6}" />
                <c:set var="sumEnd4_5" value="${sumEnd4_5 + vo4.end_rid5}" />
                <c:set var="sumEnd4_4" value="${sumEnd4_4 + vo4.end_rid4}" />
                <c:set var="sumEnd4_3" value="${sumEnd4_3 + vo4.end_rid3}" />
                <c:set var="sumEnd4_2" value="${sumEnd4_2 + vo4.end_rid2}" />
                <c:set var="sumEnd4" value="${sumEnd4 + vo4.end_rid}" />
                <c:set var="sumEnd4_sum" value="${sumEnd4_sum + vo4.end_rid12+vo4.end_rid11+vo4.end_rid10+vo4.end_rid9+vo4.end_rid8+vo4.end_rid7+vo4.end_rid6+vo4.end_rid5+vo4.end_rid4+vo4.end_rid3+vo4.end_rid2+vo4.end_rid}" />
            </c:forEach>
            <tr bgcolor="#E7ECF1">
                <td colspan="2">4종 소계</td>
                <td>${sumEnd4_12}</td>
                <td>${sumEnd4_11}</td>
                <td>${sumEnd4_10}</td>
                <td>${sumEnd4_9}</td>
                <td>${sumEnd4_8}</td>
                <td>${sumEnd4_7}</td>
                <td>${sumEnd4_6}</td>
                <td>${sumEnd4_5}</td>
                <td>${sumEnd4_4}</td>
                <td>${sumEnd4_3}</td>
                <td>${sumEnd4_2}</td>
                <td>${sumEnd4}</td>
                <td>${sumEnd4_sum}</td>
            </tr>
            <tr bgcolor="#E7ECF1">
                <td colspan="3">합계</td>
                <td>${sumEnd_12 + vo.end_rid12 + sumEnd4_12 + vo4.end_rid12}</td>
                <td>${sumEnd_11 + vo.end_rid11 + sumEnd4_11 + vo4.end_rid11}</td>
                <td>${sumEnd_10 + vo.end_rid10 + sumEnd4_10 + vo4.end_rid10}</td>
                <td>${sumEnd_9 + vo.end_rid9 + sumEnd4_9 + vo4.end_rid9}</td>
                <td>${sumEnd_8 + vo.end_rid8 + sumEnd4_8 + vo4.end_rid8}</td>
                <td>${sumEnd_7 + vo.end_rid7 + sumEnd4_7 + vo4.end_rid7}</td>
                <td>${sumEnd_6 + vo.end_rid6 + sumEnd4_6 + vo4.end_rid6}</td>
                <td>${sumEnd_5 + vo.end_rid5 + sumEnd4_5 + vo4.end_rid5}</td>
                <td>${sumEnd_4 + vo.end_rid4 + sumEnd4_4 + vo4.end_rid4}</td>
                <td>${sumEnd_3 + vo.end_rid3 + sumEnd4_3 + vo4.end_rid3}</td>
                <td>${sumEnd_2 + vo.end_rid2 + sumEnd4_2 + vo4.end_rid2}</td>
                <td>${sumEnd + vo.end_rid + sumEnd4 + vo4.end_rid}</td>
                <td>${sumEnd_sum + vo.end_rid12+vo.end_rid11+vo.end_rid10+vo.end_rid9+vo.end_rid8+vo.end_rid7+vo.end_rid6+vo.end_rid5+vo.end_rid4+vo.end_rid3+vo.end_rid2+vo.end_rid
                        + sumEnd4_sum + vo4.end_rid12+vo4.end_rid11+vo4.end_rid10+vo4.end_rid9+vo4.end_rid8+vo4.end_rid7+vo4.end_rid6+vo4.end_rid5+vo4.end_rid4+vo4.end_rid3+vo4.end_rid2+vo4.end_rid}</td>
            </tr>
            </tbody>
        </table>
	</div>
</div>
