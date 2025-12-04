<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="centercnt_top">
</div><!-- centercnt_top -->

<div class="centercnt_bot2">
	<div class="guest">
		<script>
		$(document).ready(function(){
			$("#statisticsIndexDateSearch").change(function(){
				$("#statisticsIndexToday").val($("#statisticsIndexDateSearch").val());
				$("#statisticsIndexForm").submit();
			});
		});
		</script>
		<form action="./statisticsIndex" id="statisticsIndexForm" name="statisticsIndexForm">
			<input type="hidden" id="statisticsIndexToday" name="statisticsIndexToday" />
		</form>
		<p style="margin-bottom:5px;text-align:center;">
			<img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
			<b>${fn:substring(statisticsIndexToday,0,4)}년
			${fn:substring(statisticsIndexToday,5,7)}월
			${fn:substring(statisticsIndexToday,8,10)}일 기본 통계</b>
			<input	type="text" class="classCalendar" id="statisticsIndexDateSearch" name="statisticsIndexDateSearch" size="10"
					value="${statisticsIndexToday}" readonly style="background-color:lightgrey;" />
		</p>
		<div class="guestTap">
			<ul>
				<li class="on"><a href="#">1종 팀별</a></li>
				<li><a href="#">1종 보험사별</a></li>
				<li><a href="#">4종 팀별</a></li>
				<li><a href="#">4종 보험사별</a></li>
			</ul>
		</div>
		<div class="guestcnt2" style="display:block;">
			<div class="tableStyle2">
				<div style="padding-right: 20px; background: #e7ecf1;">
                    <table cellpadding="0" cellspacing="0" width="1060" align="center">
                        <colgroup>
                            <col width="100">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                        </colgroup>
                        <tr>
                            <th>팀명</th>
                            <th>현재 인원</th>
                            <th>접수<br>${statisticsIndexTodayText}</th>
                            <th>제출<br>${statisticsIndexTodayText}</th>
                            <th>종결<br>${statisticsIndexTodayText}</th>
                            <th>접수<br>${nowVO.monthFrom} 부터<br>${nowVO.monthTo} 까지</th>
                            <th>종결<br>${nowVO.monthFrom} 부터<br>${nowVO.monthTo} 까지</th>
                            <th>접수<br>${nowVO.month1From} 부터<br>${nowVO.month1To} 까지</th>
                            <th>종결<br>${nowVO.month1From} 부터<br>${nowVO.month1To} 까지</th>
                            <th>접수<br>${nowVO.year1From} 부터<br>${nowVO.year1To} 까지</th>
                            <th>종결<br>${nowVO.year1From} 부터<br>${nowVO.year1To} 까지</th>
                        </tr>
                    </table>
                </div>
                <div style="height:630px; overflow-x: hidden; overflow-y: auto;">
                    <table cellpadding="0" cellspacing="0" width="1060" align="center">
                        <colgroup>
                            <col width="100">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                        </colgroup>
                        <tbody>
                        <c:forEach items="${team1List}" var="team1ListVO" varStatus="status" >
                            <tr onMouseOver="this.style.backgroundColor='#FFECEC'"
                                onMouseOut="this.style.backgroundColor=''" style ="cursor:pointer;">
                                <td>${team1ListVO.team_name}</td>
                                <td>${team1ListVO.now_mbr_cnt}</td>
                                <td>${team1ListVO.now_reg_cnt}</td>
                                <td>${team1ListVO.now_aprv_cnt}</td>
                                <td>${team1ListVO.now_cls_cnt}</td>
                                <td>${team1ListVO.mon_reg_cnt}</td>
                                <td>${team1ListVO.mon_cls_cnt}</td>
                                <td>${team1ListVO.b1m_reg_cnt}</td>
                                <td>${team1ListVO.b1m_cls_cnt}</td>
                                <td>${team1ListVO.b1y_reg_cnt}</td>
                                <td>${team1ListVO.b1y_cls_cnt}</td>
                            </tr>
                            <c:set var="sum1_1" value="${sum1_1 + team1ListVO.now_mbr_cnt}" />
                            <c:set var="sum1_2" value="${sum1_2 + team1ListVO.now_reg_cnt}" />
                            <c:set var="sum1_3" value="${sum1_3 + team1ListVO.now_aprv_cnt}" />
                            <c:set var="sum1_4" value="${sum1_4 + team1ListVO.now_cls_cnt}" />
                            <c:set var="sum1_5" value="${sum1_5 + team1ListVO.mon_reg_cnt}" />
                            <c:set var="sum1_6" value="${sum1_6 + team1ListVO.mon_cls_cnt}" />
                            <c:set var="sum1_7" value="${sum1_7 + team1ListVO.b1m_reg_cnt}" />
                            <c:set var="sum1_8" value="${sum1_8 + team1ListVO.b1m_cls_cnt}" />
                            <c:set var="sum1_9" value="${sum1_9 + team1ListVO.b1y_reg_cnt}" />
                            <c:set var="sum1_10" value="${sum1_10 + team1ListVO.b1y_cls_cnt}" />
                        </c:forEach>
                        <tr bgcolor="#E7ECF1">
                            <td>합계</td>
                            <td>${sum1_1}</td>
                            <td>${sum1_2}</td>
                            <td>${sum1_3}</td>
                            <td>${sum1_4}</td>
                            <td>${sum1_5}</td>
                            <td>${sum1_6}</td>
                            <td>${sum1_7}</td>
                            <td>${sum1_8}</td>
                            <td>${sum1_9}</td>
                            <td>${sum1_10}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
			</div><!-- //tableStyle2 -->
		</div>
		<div class="guestcnt2" style="display:none;">
			<div class="tableStyle2">
                <div style="padding-right: 20px; background: #e7ecf1;">
                    <table cellpadding="0" cellspacing="0" width="1060" align="center">
                        <colgroup>
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                        </colgroup>
                        <tr>
                            <th>보험사명</th>
                            <th>접수<br>${statisticsIndexTodayText}</th>
                            <th>제출<br>${statisticsIndexTodayText}</th>
                            <th>종결<br>${statisticsIndexTodayText}</th>
                            <th>접수<br>${nowVO.monthFrom} 부터<br>${nowVO.monthTo} 까지</th>
                            <th>종결<br>${nowVO.monthFrom} 부터<br>${nowVO.monthTo} 까지</th>
                            <th>접수<br>${nowVO.month1From} 부터<br>${nowVO.month1To} 까지</th>
                            <th>종결<br>${nowVO.month1From} 부터<br>${nowVO.month1To} 까지</th>
                            <th>접수<br>${nowVO.year1From} 부터<br>${nowVO.year1To} 까지</th>
                            <th>종결<br>${nowVO.year1From} 부터<br>${nowVO.year1To} 까지</th>
                        </tr>
                    </table>
                </div>
                <div style="height:630px; overflow-x: hidden; overflow-y: auto;">
                    <table cellpadding="0" cellspacing="0" width="1060" align="center">
                        <colgroup>
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                        </colgroup>
                        <tbody>
                        <c:forEach items="${ptnr1List}" var="ptnr1ListVO" varStatus="status" >
                            <tr onMouseOver="this.style.backgroundColor='#FFECEC'"
                                onMouseOut="this.style.backgroundColor=''" style ="cursor:pointer;">
                                <td>${ptnr1ListVO.ptnr_name}</td>
                                <td>${ptnr1ListVO.now_reg_cnt}</td>
                                <td>${ptnr1ListVO.now_aprv_cnt}</td>
                                <td>${ptnr1ListVO.now_cls_cnt}</td>
                                <td>${ptnr1ListVO.mon_reg_cnt}</td>
                                <td>${ptnr1ListVO.mon_cls_cnt}</td>
                                <td>${ptnr1ListVO.b1m_reg_cnt}</td>
                                <td>${ptnr1ListVO.b1m_cls_cnt}</td>
                                <td>${ptnr1ListVO.b1y_reg_cnt}</td>
                                <td>${ptnr1ListVO.b1y_cls_cnt}</td>
                            </tr>
                            <c:set var="sum2_2" value="${sum2_2 + ptnr1ListVO.now_reg_cnt}" />
                            <c:set var="sum2_3" value="${sum2_3 + ptnr1ListVO.now_aprv_cnt}" />
                            <c:set var="sum2_4" value="${sum2_4 + ptnr1ListVO.now_cls_cnt}" />
                            <c:set var="sum2_5" value="${sum2_5 + ptnr1ListVO.mon_reg_cnt}" />
                            <c:set var="sum2_6" value="${sum2_6 + ptnr1ListVO.mon_cls_cnt}" />
                            <c:set var="sum2_7" value="${sum2_7 + ptnr1ListVO.b1m_reg_cnt}" />
                            <c:set var="sum2_8" value="${sum2_8 + ptnr1ListVO.b1m_cls_cnt}" />
                            <c:set var="sum2_9" value="${sum2_9 + ptnr1ListVO.b1y_reg_cnt}" />
                            <c:set var="sum2_10" value="${sum2_10 + ptnr1ListVO.b1y_cls_cnt}" />
                        </c:forEach>
                        <tr bgcolor="#E7ECF1">
                            <td>합계</td>
                            <td>${sum2_2}</td>
                            <td>${sum2_3}</td>
                            <td>${sum2_4}</td>
                            <td>${sum2_5}</td>
                            <td>${sum2_6}</td>
                            <td>${sum2_7}</td>
                            <td>${sum2_8}</td>
                            <td>${sum2_9}</td>
                            <td>${sum2_10}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
			</div><!-- //tableStyle2 -->
		</div>
		<div class="guestcnt2" style="display:none;">
			<div class="tableStyle2">
                <div style="padding-right: 20px; background: #e7ecf1;">
                    <table cellpadding="0" cellspacing="0" width="1060" align="center">
                        <colgroup>
                            <col width="100">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                        </colgroup>
                        <tr>
                            <th>팀명</th>
                            <th>현재 인원</th>
                            <th>접수<br>${statisticsIndexTodayText}</th>
                            <th>제출<br>${statisticsIndexTodayText}</th>
                            <th>종결<br>${statisticsIndexTodayText}</th>
                            <th>접수<br>${nowVO.monthFrom} 부터<br>${nowVO.monthTo} 까지</th>
                            <th>종결<br>${nowVO.monthFrom} 부터<br>${nowVO.monthTo} 까지</th>
                            <th>접수<br>${nowVO.month1From} 부터<br>${nowVO.month1To} 까지</th>
                            <th>종결<br>${nowVO.month1From} 부터<br>${nowVO.month1To} 까지</th>
                            <th>접수<br>${nowVO.year1From} 부터<br>${nowVO.year1To} 까지</th>
                            <th>종결<br>${nowVO.year1From} 부터<br>${nowVO.year1To} 까지</th>
                        </tr>
                    </table>
                </div>
                <div style="height:630px; overflow-x: hidden; overflow-y: auto;">
                    <table cellpadding="0" cellspacing="0" width="1060" align="center">
                        <colgroup>
                            <col width="100">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                            <col width="96">
                        </colgroup>
                        <tbody>
                        <c:forEach items="${team4List}" var="team4ListVO" varStatus="status" >
                            <tr onMouseOver="this.style.backgroundColor='#FFECEC'"
                                onMouseOut="this.style.backgroundColor=''" style ="cursor:pointer;">
                                <td>${team4ListVO.team_name}</td>
                                <td>${team4ListVO.now_mbr_cnt}</td>
                                <td>${team4ListVO.now_reg_cnt}</td>
                                <td>${team4ListVO.now_aprv_cnt}</td>
                                <td>${team4ListVO.now_cls_cnt}</td>
                                <td>${team4ListVO.mon_reg_cnt}</td>
                                <td>${team4ListVO.mon_cls_cnt}</td>
                                <td>${team4ListVO.b1m_reg_cnt}</td>
                                <td>${team4ListVO.b1m_cls_cnt}</td>
                                <td>${team4ListVO.b1y_reg_cnt}</td>
                                <td>${team4ListVO.b1y_cls_cnt}</td>
                            </tr>
                            <c:set var="sum3_1" value="${sum3_1 + team4ListVO.now_mbr_cnt}" />
                            <c:set var="sum3_2" value="${sum3_2 + team4ListVO.now_reg_cnt}" />
                            <c:set var="sum3_3" value="${sum3_3 + team4ListVO.now_aprv_cnt}" />
                            <c:set var="sum3_4" value="${sum3_4 + team4ListVO.now_cls_cnt}" />
                            <c:set var="sum3_5" value="${sum3_5 + team4ListVO.mon_reg_cnt}" />
                            <c:set var="sum3_6" value="${sum3_6 + team4ListVO.mon_cls_cnt}" />
                            <c:set var="sum3_7" value="${sum3_7 + team4ListVO.b1m_reg_cnt}" />
                            <c:set var="sum3_8" value="${sum3_8 + team4ListVO.b1m_cls_cnt}" />
                            <c:set var="sum3_9" value="${sum3_9 + team4ListVO.b1y_reg_cnt}" />
                            <c:set var="sum3_10" value="${sum3_10 + team4ListVO.b1y_cls_cnt}" />
                        </c:forEach>
                        <tr bgcolor="#E7ECF1">
                            <td>합계</td>
                            <td>${sum3_1}</td>
                            <td>${sum3_2}</td>
                            <td>${sum3_3}</td>
                            <td>${sum3_4}</td>
                            <td>${sum3_5}</td>
                            <td>${sum3_6}</td>
                            <td>${sum3_7}</td>
                            <td>${sum3_8}</td>
                            <td>${sum3_9}</td>
                            <td>${sum3_10}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
			</div><!-- //tableStyle2 -->
		</div>
		<div class="guestcnt2" style="display:none;">
			<div class="tableStyle2">
                <div style="padding-right: 20px; background: #e7ecf1;">
                    <table cellpadding="0" cellspacing="0" width="1060" align="center">
                        <colgroup>
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                        </colgroup>
                        <tr>
                            <th>보험사명</th>
                            <th>접수<br>${statisticsIndexTodayText}</th>
                            <th>제출<br>${statisticsIndexTodayText}</th>
                            <th>종결<br>${statisticsIndexTodayText}</th>
                            <th>접수<br>${nowVO.monthFrom} 부터<br>${nowVO.monthTo} 까지</th>
                            <th>종결<br>${nowVO.monthFrom} 부터<br>${nowVO.monthTo} 까지</th>
                            <th>접수<br>${nowVO.month1From} 부터<br>${nowVO.month1To} 까지</th>
                            <th>종결<br>${nowVO.month1From} 부터<br>${nowVO.month1To} 까지</th>
                            <th>접수<br>${nowVO.year1From} 부터<br>${nowVO.year1To} 까지</th>
                            <th>종결<br>${nowVO.year1From} 부터<br>${nowVO.year1To} 까지</th>
                        </tr>
                    </table>
                </div>
                <div style="height:630px; overflow-x: hidden; overflow-y: auto;">
                    <table cellpadding="0" cellspacing="0" width="1060" align="center">
                        <colgroup>
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                            <col width="106">
                        </colgroup>
                        <tbody>
                        <c:forEach items="${ptnr4List}" var="ptnr4ListVO" varStatus="status" >
                            <tr onMouseOver="this.style.backgroundColor='#FFECEC'"
                                onMouseOut="this.style.backgroundColor=''" style ="cursor:pointer;">
                                <td>${ptnr4ListVO.ptnr_name}</td>
                                <td>${ptnr4ListVO.now_reg_cnt}</td>
                                <td>${ptnr4ListVO.now_aprv_cnt}</td>
                                <td>${ptnr4ListVO.now_cls_cnt}</td>
                                <td>${ptnr4ListVO.mon_reg_cnt}</td>
                                <td>${ptnr4ListVO.mon_cls_cnt}</td>
                                <td>${ptnr4ListVO.b1m_reg_cnt}</td>
                                <td>${ptnr4ListVO.b1m_cls_cnt}</td>
                                <td>${ptnr4ListVO.b1y_reg_cnt}</td>
                                <td>${ptnr4ListVO.b1y_cls_cnt}</td>
                            </tr>
                            <c:set var="sum4_2" value="${sum4_2 + ptnr4ListVO.now_reg_cnt}" />
                            <c:set var="sum4_3" value="${sum4_3 + ptnr4ListVO.now_aprv_cnt}" />
                            <c:set var="sum4_4" value="${sum4_4 + ptnr4ListVO.now_cls_cnt}" />
                            <c:set var="sum4_5" value="${sum4_5 + ptnr4ListVO.mon_reg_cnt}" />
                            <c:set var="sum4_6" value="${sum4_6 + ptnr4ListVO.mon_cls_cnt}" />
                            <c:set var="sum4_7" value="${sum4_7 + ptnr4ListVO.b1m_reg_cnt}" />
                            <c:set var="sum4_8" value="${sum4_8 + ptnr4ListVO.b1m_cls_cnt}" />
                            <c:set var="sum4_9" value="${sum4_9 + ptnr4ListVO.b1y_reg_cnt}" />
                            <c:set var="sum4_10" value="${sum4_10 + ptnr4ListVO.b1y_cls_cnt}" />
                        </c:forEach>
                        <tr bgcolor="#E7ECF1">
                            <td>합계</td>
                            <td>${sum4_2}</td>
                            <td>${sum4_3}</td>
                            <td>${sum4_4}</td>
                            <td>${sum4_5}</td>
                            <td>${sum4_6}</td>
                            <td>${sum4_7}</td>
                            <td>${sum4_8}</td>
                            <td>${sum4_9}</td>
                            <td>${sum4_10}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
			</div><!-- //tableStyle2 -->
		</div>
	</div>
</div><!-- centercnt_bot2 -->
