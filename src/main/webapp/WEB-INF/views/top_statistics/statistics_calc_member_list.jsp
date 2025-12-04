<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${title_Session}</title>
    <link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=20170321111520" />
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->

    <script src="./resources/jquery/jquery.min_1_12.js"></script>
    <script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
    <script src="./resources/ne_js/calendar.js?v=20170321111520"></script><!-- calendar -->

    <script src="./resources/wm_js/common.js"></script>
    <script src="./resources/cmm/js/common.js"></script>

    <style type="text/css">
        .tableStyle2 tr:hover { background-color:#ffecec; } /* hovering */
        td.right {
            text-align: right;
            padding-right: 3px;
        }
        td.left {
            text-align: left;
            padding-left: 1em;
        }
    </style>

</head>
<body>
    <div id="wrapper">
        <!-- top menu import -->
        <c:import url="../top_statistics/statistics_menu.jsp"></c:import>
        <!-- top menu import -->

        <div id="container">
            <div class="contetns2">
                <div class="center_cnt2">



                    <%--검색 영역--%>
                    <div class="centercnt_top">
                        <div class="nociteA log_top">
                            <div class="search_bar">
                                <div style="float: left;">
                                    <img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" align="absmiddle">&nbsp;
                                    <span style="color:red;"><b>${fn:substring(srchArg.stdEndde,0,4)}년 ${fn:substring(srchArg.stdEndde,5,7)}월</b></span> 팀 개인별 통계
                                </div>
                                <div style="text-align: right;">
                                    <a id="btn_year_prev" href="#noloc">
                                        <img src="./resources/ne_img/icon_prev.gif" width="17" height="13" border="0">
                                    </a>
                                    <a id="year_txt" href="#noloc;">${fn:substring(srchArg.stdEndde,0,4)}</a>
                                    <a id="btn_year_next" href="#noloc">
                                        <img src="./resources/ne_img/icon_next.gif" width="17" height="13" border="0">
                                    </a>
                                    <c:forEach var="i" begin="1" end="12" step="1" varStatus="">
                                        <input id="${i}" class="monthbtn" type="button" value="${i}월" />
                                    </c:forEach>
                                </div><br/>
                                <form id="srchFrm" name="srchFrm" method="post" action="./statistics_calc_team_list">
                                    <input type="hidden" id="srchTeamId" name="team_id"/>
                                    <input type="hidden" id="srchTeamType" name="team_type"/>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="text" id="stdBgnde"  name="stdBgnde" size="10"  value="${srchArg.stdBgnde}" maxlength="10" readonly="readonly"/>
                                    <span style="color:#0066CC">부터</span>&nbsp;&nbsp;&nbsp;
                                    <input type="text" id="stdEndde"  name="stdEndde" size="10"  value="${srchArg.stdEndde}" maxlength="10" readonly="readonly"/>
                                    <span style="color:#0066CC">까지</span>&nbsp;&nbsp;&nbsp;
<%--

                                    <select id="stdType" name="stdType">
                                        <option value = "0" <c:if test="${srchArg.stdType == '0'}">selected="selected"</c:if>>-전체-</option>
                                        <option value = "1" <c:if test="${srchArg.stdType == '1'}">selected="selected"</c:if>>1종   </option>
                                        <option value = "4" <c:if test="${srchArg.stdType == '4'}">selected="selected"</c:if>>4종   </option>
                                    </select>
--%>



                                    <a id="btn_search" href="#noloc">
                                        <img src="./resources/ne_img/icon_log_src.gif" width="110" height="22" border="0">
                                    </a>
                                    <p style="display: inline; float: right;">
                                        <a id="btn_excel" href="#noloc">
                                            <img src="./resources/ls_img/btn_excel.gif">
                                        </a>
                                    </p>
                                    <br>

                                </form>
                            </div>
                        </div>
                    </div>








                    <%--본문 영역--%>
                    <div class="centercnt_bot2" style="margin:0 auto;">
                        <div class="guest">
                            <%--<div class="guestTap">--%>
                                <%--<ul>--%>
                                    <%--<li class="on"><a>${fn:substring(srchArg.stdEndde,0,4)}년 ${fn:substring(srchArg.stdEndde,5,7)}월 팀별 평균 통계</a></li>--%>
                                <%--</ul>--%>
                            <%--</div>--%>
                            <div class="guestcnt2" id="area_excel" style="display:block;">
                                <div class="tableStyle2">
                                    <table cellpadding="0" cellspacing="0" width="1060" align="center">
                                        <colgroup>
                                            <col width="90">
                                            <col width="40">
                                            <col width="40">
                                            <col width="40">
                                            <col width="35">
                                            <col width="45">
                                            <col width="35">
                                            <col width="45">
                                            <col width="35">
                                            <col width="45">
                                            <col width="35">
                                            <col width="45">
                                            <col width="35">
                                            <col width="45">
                                            <col width="35">
                                            <col width="45">
                                            <col width="35">
                                            <col width="45">
                                            <col width="35">
                                        </colgroup>
                                        <tr>
                                            <th rowspan="4"><span style="color: black;"><b>이름</b></span></th>
                                            <th colspan="2">수임현황</th>
                                            <th colspan="2">종결현황</th>
                                            <th>미결현황</th>
                                            <th colspan="2">종결평가</th>
                                            <th colspan="10"><b>공동수행자의 비율 및 금액을 반영한 결과<span style="color: red">(반영안함!)</span></b></th>
                                            <th rowspan="4">미수금</th>
                                        </tr>
                                        <tr>
                                            <th colspan="2">절대건수</th>
                                            <th colspan="2">절대건수</th>
                                            <th>절대건수</th>
                                            <th colspan="2">평가건수</th>
                                            <th colspan="10">인보이스 현황<span style="color: red">(당월)</span></th>
                                        </tr>
                                        <tr>
                                            <th rowspan="2">당월</th>
                                            <th rowspan="2">년누계</th>
                                            <th rowspan="2">당월</th>
                                            <th rowspan="2">년누계</th>
                                            <th rowspan="2">현재</th>
                                            <th rowspan="2">당월</th>
                                            <th rowspan="2">공동적용</th>
                                            <th rowspan="2">기본료</th>
                                            <th rowspan="2">일비</th>
                                            <th colspan="2">공동수행</th>
                                            <th colspan="2">소계</th>
                                            <th rowspan="2">교통비</th>
                                            <th rowspan="2">자문료</th>
                                            <th rowspan="2">기타</th>
                                            <th rowspan="2">합계</th>
                                        </tr>
                                        <tr>
                                            <th>기본료</th>
                                            <th>일비</th>
                                            <th>정산기본료</th>
                                            <th>정산일비</th>
                                        </tr>
                                        <tr>
                                            <td>1</td>
                                            <td>2</td>
                                            <td>3</td>
                                            <td>4</td>
                                            <td>5</td>
                                            <td>6</td>
                                            <td>7</td>
                                            <td>8</td>
                                            <td>9</td>
                                            <td>0</td>
                                            <td>1</td>
                                            <td>2</td>
                                            <td>3</td>
                                            <td>4</td>
                                            <td>5</td>
                                            <td>6</td>
                                            <td>7</td>
                                            <td>8</td>
                                            <td>9</td>
                                        </tr>
                                        <%--
                                        <c:set var="listCnt1" value="${workTeamList1.size()}"/>
                                        <c:forEach  var="item" items="${workTeamList1}" varStatus="status">
                                            <tr>
                                                <c:if test="${status.index == 0}">
                                                <td rowspan="${listCnt1}" bgcolor="#F8F8F8">1종</td>
                                                </c:if>
                                                <td class="left"><a href="#noloc" onclick="fnMemberList('${item.teamId}','1');">${item.teamName}</a></td>
                                                <td class="right"><fmt:formatNumber value="${item.userCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.receiveCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.closeCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.day10PrevCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.day10PrevPs}" pattern="##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${item.day10NextCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.day10NextPs}" pattern="##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${item.day20NextCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.day20NextPs}" pattern="##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${item.day30NextCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.day30NextPs}" pattern="##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${item.day60NextCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.day60NextPs}" pattern="##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${item.day90NextCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.day90NextPs}" pattern="##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${item.day120NextCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.day120NextPs}" pattern="##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${item.totalCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.totalPs}" pattern="###.#"/>%</td>
                                                <td class="right">
                                                    <fmt:formatNumber var="itemTotalCnt" value="${item.totalCnt}" pattern="#.##"/>
                                                    <fmt:formatNumber var="itemRegDateTime" value="${item.regDateTime}" pattern="#.##"/>

                                                    <fmt:formatNumber value="${itemTotalCnt == 0 ? 0 : ((itemTotalCnt * unixTime - itemRegDateTime) / 86400) / itemTotalCnt}" pattern="#,###.#"/>일
                                                </td>
                                                <td class="right"><fmt:formatNumber value="${item.anticipationCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.occurCnt}" pattern="#,###"/></td>
                                            </tr>
                                            <c:set var="subUserCnt1" value="${subUserCnt1 + item.userCnt}"/>
                                            <c:set var="subReceiveCnt1" value="${subReceiveCnt1 + item.receiveCnt}"/>
                                            <c:set var="subCloseCnt1" value="${subCloseCnt1 + item.closeCnt}"/>
                                            <c:set var="subDay10PrevCnt1" value="${subDay10PrevCnt1 + item.day10PrevCnt}"/>
                                            <c:set var="subDay10NextCnt1" value="${subDay10NextCnt1 + item.day10NextCnt}"/>
                                            <c:set var="subDay20NextCnt1" value="${subDay20NextCnt1 + item.day20NextCnt}"/>
                                            <c:set var="subDay30NextCnt1" value="${subDay30NextCnt1 + item.day30NextCnt}"/>
                                            <c:set var="subDay60NextCnt1" value="${subDay60NextCnt1 + item.day60NextCnt}"/>
                                            <c:set var="subDay90NextCnt1" value="${subDay90NextCnt1 + item.day90NextCnt}"/>
                                            <c:set var="subDay120NextCnt1" value="${subDay120NextCnt1 + item.day120NextCnt}"/>
                                            <c:set var="subTotalCnt1" value="${subTotalCnt1 + item.totalCnt}"/>
                                            <c:set var="subRegDateTime1" value="${subRegDateTime1 + item.regDateTime}"/>
                                            <c:set var="subAnticipationCnt1" value="${subAnticipationCnt1 + item.anticipationCnt}"/>
                                            <c:set var="subOccurCnt1" value="${subOccurCnt1 + item.occurCnt}"/>
                                        </c:forEach>
                                        <tr bgcolor="#EFEFEF">
                                            <fmt:formatNumber var="subDay10PrevCnt1" value="${subDay10PrevCnt1}" pattern="#.##"/>
                                            <fmt:formatNumber var="subDay10NextCnt1" value="${subDay10NextCnt1}" pattern="#.##"/>
                                            <fmt:formatNumber var="subDay20NextCnt1" value="${subDay20NextCnt1}" pattern="#.##"/>
                                            <fmt:formatNumber var="subDay30NextCnt1" value="${subDay30NextCnt1}" pattern="#.##"/>
                                            <fmt:formatNumber var="subDay60NextCnt1" value="${subDay60NextCnt1}" pattern="#.##"/>
                                            <fmt:formatNumber var="subDay90NextCnt1" value="${subDay90NextCnt1}" pattern="#.##"/>
                                            <fmt:formatNumber var="subDay120NextCnt1" value="${subDay120NextCnt1}" pattern="#.##"/>
                                            <fmt:formatNumber var="subTotalCnt1" value="${subTotalCnt1}" pattern="#.##"/>
                                            <fmt:formatNumber var="subRegDateTime1" value="${subRegDateTime1}" pattern="#.##"/>
                                            <td colspan="2">소계</td>
                                            <td class="right"><fmt:formatNumber value="${subUserCnt1}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subReceiveCnt1}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subCloseCnt1}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subDay10PrevCnt1}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subTotalCnt1 == 0 ? 0.0 : subDay10PrevCnt1 / subTotalCnt1 * 100}" pattern="#,##0.0"/>%</td>
                                            <td class="right"><fmt:formatNumber value="${subDay10NextCnt1}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subTotalCnt1 == 0 ? 0.0 : subDay10NextCnt1 / subTotalCnt1 * 100}" pattern="#,##0.0"/>%</td>
                                            <td class="right"><fmt:formatNumber value="${subDay20NextCnt1}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subTotalCnt1 == 0 ? 0.0 : subDay20NextCnt1 / subTotalCnt1 * 100}" pattern="#,##0.0"/>%</td>
                                            <td class="right"><fmt:formatNumber value="${subDay30NextCnt1}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subTotalCnt1 == 0 ? 0.0 : subDay30NextCnt1 / subTotalCnt1 * 100}" pattern="#,##0.0"/>%</td>
                                            <td class="right"><fmt:formatNumber value="${subDay60NextCnt1}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subTotalCnt1 == 0 ? 0.0 : subDay60NextCnt1 / subTotalCnt1 * 100}" pattern="#,##0.0"/>%</td>
                                            <td class="right"><fmt:formatNumber value="${subDay90NextCnt1}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subTotalCnt1 == 0 ? 0.0 : subDay90NextCnt1 / subTotalCnt1 * 100}" pattern="#,##0.0"/>%</td>
                                            <td class="right"><fmt:formatNumber value="${subDay120NextCnt1}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subTotalCnt1 == 0 ? 0.0 : subDay120NextCnt1 / subTotalCnt1 * 100}" pattern="#,##0.0"/>%</td>
                                            <td class="right"><fmt:formatNumber value="${subTotalCnt1}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subTotalCnt1 == 0 ? 0.0 : subTotalCnt1 / subTotalCnt1 * 100}" pattern="#,###"/>%</td>
                                            <td class="right">
                                                <fmt:formatNumber value="${subTotalCnt1 == 0 ? 0 : ((subTotalCnt1 * unixTime - subRegDateTime1) / 86400) / subTotalCnt1}" pattern="#,###.#"/>일
                                            </td>
                                            <td class="right"><fmt:formatNumber value="${subAnticipationCnt1}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subOccurCnt1}" pattern="#,###"/></td>
                                        </tr>
                                        <c:set var="listCnt4" value="${workTeamList4.size()}"/>
                                        <c:forEach  var="item" items="${workTeamList4}" varStatus="status">
                                            <tr>
                                                <c:if test="${status.index == 0}">
                                                    <td rowspan="${listCnt4}" bgcolor="#F8F8F8">4종</td>
                                                </c:if>
                                                <td class="left"><a href="#noloc" onclick="fnMemberList('${item.teamId}','4');">${item.teamName}</a></td>
                                                <td class="right"><fmt:formatNumber value="${item.userCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.receiveCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.closeCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.day10PrevCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.day10PrevPs}" pattern="##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${item.day10NextCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.day10NextPs}" pattern="##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${item.day20NextCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.day20NextPs}" pattern="##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${item.day30NextCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.day30NextPs}" pattern="##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${item.day60NextCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.day60NextPs}" pattern="##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${item.day90NextCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.day90NextPs}" pattern="##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${item.day120NextCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.day120NextPs}" pattern="##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${item.totalCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.totalPs}" pattern="###.#"/>%</td>
                                                <td class="right">
                                                    <fmt:formatNumber var="itemTotalCnt" value="${item.totalCnt}" pattern="#.##"/>
                                                    <fmt:formatNumber var="itemRegDateTime" value="${item.regDateTime}" pattern="#.##"/>
                                                    <fmt:formatNumber value="${itemTotalCnt == 0 ? 0 : ((itemTotalCnt * unixTime - itemRegDateTime) / 86400) / itemTotalCnt}" pattern="#,###.#"/>일
                                                </td>
                                                <td class="right"><fmt:formatNumber value="${item.anticipationCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.occurCnt}" pattern="#,###"/></td>
                                            </tr>
                                            <c:set var="subUserCnt4" value="${subUserCnt4 + item.userCnt}"/>
                                            <c:set var="subReceiveCnt4" value="${subReceiveCnt4 + item.receiveCnt}"/>
                                            <c:set var="subCloseCnt4" value="${subCloseCnt4 + item.closeCnt}"/>
                                            <c:set var="subDay10PrevCnt4" value="${subDay10PrevCnt4 + item.day10PrevCnt}"/>
                                            <c:set var="subDay10NextCnt4" value="${subDay10NextCnt4 + item.day10NextCnt}"/>
                                            <c:set var="subDay20NextCnt4" value="${subDay20NextCnt4 + item.day20NextCnt}"/>
                                            <c:set var="subDay30NextCnt4" value="${subDay30NextCnt4 + item.day30NextCnt}"/>
                                            <c:set var="subDay60NextCnt4" value="${subDay60NextCnt4 + item.day60NextCnt}"/>
                                            <c:set var="subDay90NextCnt4" value="${subDay90NextCnt4 + item.day90NextCnt}"/>
                                            <c:set var="subDay120NextCnt4" value="${subDay120NextCnt4 + item.day120NextCnt}"/>
                                            <c:set var="subTotalCnt4" value="${subTotalCnt4 + item.totalCnt}"/>
                                            <c:set var="subRegDateTime4" value="${subRegDateTime4 + item.regDateTime}"/>
                                            <c:set var="subDayAvrTime4" value="${subDayAvrTime4 + item.dayAvrTime}"/>
                                            <c:set var="subAnticipationCnt4" value="${subAnticipationCnt4 + item.anticipationCnt}"/>
                                            <c:set var="subOccurCnt4" value="${subOccurCnt4 + item.occurCnt}"/>
                                        </c:forEach>
                                        <tr bgcolor="#EFEFEF">
                                            <fmt:formatNumber var="subDay10PrevCnt4" value="${subDay10PrevCnt4}" pattern="#.##"/>
                                            <fmt:formatNumber var="subDay10NextCnt4" value="${subDay10NextCnt4}" pattern="#.##"/>
                                            <fmt:formatNumber var="subDay20NextCnt4" value="${subDay20NextCnt4}" pattern="#.##"/>
                                            <fmt:formatNumber var="subDay30NextCnt4" value="${subDay30NextCnt4}" pattern="#.##"/>
                                            <fmt:formatNumber var="subDay60NextCnt4" value="${subDay60NextCnt4}" pattern="#.##"/>
                                            <fmt:formatNumber var="subDay90NextCnt4" value="${subDay90NextCnt4}" pattern="#.##"/>
                                            <fmt:formatNumber var="subDay120NextCnt4" value="${subDay120NextCnt4}" pattern="#.##"/>
                                            <fmt:formatNumber var="subTotalCnt4" value="${subTotalCnt4}" pattern="#.##"/>
                                            <fmt:formatNumber var="subRegDateTime4" value="${subRegDateTime4}" pattern="#.##"/>
                                            <td colspan="2">소계</td>
                                            <td class="right"><fmt:formatNumber value="${subUserCnt4}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subReceiveCnt4}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subCloseCnt4}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subDay10PrevCnt4}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subTotalCnt4 == 0 ? 0.0 : subDay10PrevCnt4 / subTotalCnt4 * 100}" pattern="#,##0.0"/>%</td>
                                            <td class="right"><fmt:formatNumber value="${subDay10NextCnt4}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subTotalCnt4 == 0 ? 0.0 : subDay10NextCnt4 / subTotalCnt4 * 100}" pattern="#,##0.0"/>%</td>
                                            <td class="right"><fmt:formatNumber value="${subDay20NextCnt4}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subTotalCnt4 == 0 ? 0.0 : subDay20NextCnt4 / subTotalCnt4 * 100}" pattern="#,##0.0"/>%</td>
                                            <td class="right"><fmt:formatNumber value="${subDay30NextCnt4}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subTotalCnt4 == 0 ? 0.0 : subDay30NextCnt4 / subTotalCnt4 * 100}" pattern="#,##0.0"/>%</td>
                                            <td class="right"><fmt:formatNumber value="${subDay60NextCnt4}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subTotalCnt4 == 0 ? 0.0 : subDay60NextCnt4 / subTotalCnt4 * 100}" pattern="#,##0.0"/>%</td>
                                            <td class="right"><fmt:formatNumber value="${subDay90NextCnt4}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subTotalCnt4 == 0 ? 0.0 : subDay90NextCnt4 / subTotalCnt4 * 100}" pattern="#,##0.0"/>%</td>
                                            <td class="right"><fmt:formatNumber value="${subDay120NextCnt4}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subTotalCnt4 == 0 ? 0.0 : subDay120NextCnt4 / subTotalCnt4 * 100}" pattern="#,##0.0"/>%</td>
                                            <td class="right"><fmt:formatNumber value="${subTotalCnt4}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subTotalCnt4 == 0 ? 0.0 : subTotalCnt4 / subTotalCnt4 * 100}" pattern="#,###"/>%</td>
                                            <td class="right">
                                                <fmt:formatNumber value="${subTotalCnt4 == 0 ? 0 : ((subTotalCnt4 * unixTime - subRegDateTime4) / 86400) / subTotalCnt4}" pattern="#,###.#"/>일
                                            </td>
                                            <td class="right"><fmt:formatNumber value="${subAnticipationCnt4}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${subOccurCnt4}" pattern="#,###"/></td>
                                        </tr>
                                        <tr bgcolor="#F8F8F8">
                                            <td colspan="2">합계</td>
                                            <fmt:formatNumber var="GlobalTotalCnt" value="${subTotalCnt1 + subTotalCnt4}" pattern="#.##"/>
                                            <fmt:formatNumber var="GlobalRegDateTime" value="${subRegDateTime1 + subRegDateTime4}" pattern="#.##"/>
                                            <td class="right"><span style="color: red"><fmt:formatNumber value="${subUserCnt1 + subUserCnt4}" pattern="#,###"/></span></td>
                                            <td class="right"><span style="color: red"><fmt:formatNumber value="${subReceiveCnt1 + subReceiveCnt4}" pattern="#,###"/></span></td>
                                            <td class="right"><span style="color: red"><fmt:formatNumber value="${subCloseCnt1 + subCloseCnt4}" pattern="#,###"/></span></td>
                                            <td class="right"><span style="color: red"><fmt:formatNumber value="${subDay10PrevCnt1 + subDay10PrevCnt4}" pattern="#,###"/></td>
                                            <td class="right"><span style="color: red"><fmt:formatNumber value="${GlobalTotalCnt == 0 ? 0.0 : (subDay10PrevCnt1 + subDay10PrevCnt4) / GlobalTotalCnt * 100}" pattern="#,##0.0"/>%</span></td>
                                            <td class="right"><span style="color: red"><fmt:formatNumber value="${subDay10NextCnt1 + subDay10NextCnt4}" pattern="#,###"/></span></td>
                                            <td class="right"><span style="color: red"><fmt:formatNumber value="${GlobalTotalCnt == 0 ? 0.0 : (subDay10NextCnt1 + subDay10NextCnt4) / GlobalTotalCnt * 100}" pattern="#,##0.0"/>%</span></td>
                                            <td class="right"><span style="color: red"><fmt:formatNumber value="${subDay20NextCnt1 + subDay20NextCnt4}" pattern="#,###"/></span></td>
                                            <td class="right"><span style="color: red"><fmt:formatNumber value="${GlobalTotalCnt == 0 ? 0.0 : (subDay20NextCnt1 + subDay20NextCnt4) / GlobalTotalCnt * 100}" pattern="#,##0.0"/>%</span></td>
                                            <td class="right"><span style="color: red"><fmt:formatNumber value="${subDay30NextCnt1 + subDay30NextCnt4}" pattern="#,###"/></span></td>
                                            <td class="right"><span style="color: red"><fmt:formatNumber value="${GlobalTotalCnt == 0 ? 0.0 : (subDay30NextCnt1 + subDay30NextCnt4) / GlobalTotalCnt * 100}" pattern="#,##0.0"/>%</span></td>
                                            <td class="right"><span style="color: red"><fmt:formatNumber value="${subDay60NextCnt1 + subDay60NextCnt4}" pattern="#,###"/></span></td>
                                            <td class="right"><span style="color: red"><fmt:formatNumber value="${GlobalTotalCnt == 0 ? 0.0 : (subDay60NextCnt1 + subDay60NextCnt4) / GlobalTotalCnt * 100}" pattern="#,##0.0"/>%</span></td>
                                            <td class="right"><span style="color: red"><fmt:formatNumber value="${subDay90NextCnt1 + subDay90NextCnt4}" pattern="#,###"/></span></td>
                                            <td class="right"><span style="color: red"><fmt:formatNumber value="${GlobalTotalCnt == 0 ? 0.0 : (subDay90NextCnt1 + subDay90NextCnt4) / GlobalTotalCnt * 100}" pattern="#,##0.0"/>%</span></td>
                                            <td class="right"><span style="color: red"><fmt:formatNumber value="${subDay120NextCnt1 + subDay120NextCnt4}" pattern="#,###"/></span></td>
                                            <td class="right"><span style="color: red"><fmt:formatNumber value="${GlobalTotalCnt == 0 ? 0.0 : (subDay120NextCnt1 + subDay120NextCnt4) / GlobalTotalCnt * 100}" pattern="#,##0.0"/>%</span></td>
                                            <td class="right"><span style="color: red"><fmt:formatNumber value="${GlobalTotalCnt}" pattern="#,###"/></span></td>
                                            <td class="right"><span style="color: red"><fmt:formatNumber value="${GlobalTotalCnt == 0 ? 0.0 : GlobalTotalCnt / GlobalTotalCnt * 100}" pattern="#,###.#"/>%</span></td>
                                            <td class="right">
                                                <span style="color: red"><fmt:formatNumber value="${GlobalTotalCnt == 0 ? 0 : ((GlobalTotalCnt * unixTime - GlobalRegDateTime) / 86400) / GlobalTotalCnt}" pattern="#,###.#"/>일</span>
                                            </td>
                                            <td class="right"><span style="color: red"><fmt:formatNumber value="${subAnticipationCnt1 + subAnticipationCnt4}" pattern="#,###"/></span></td>
                                            <td class="right"><span style="color: red"><fmt:formatNumber value="${subOccurCnt1 + subOccurCnt4}" pattern="#,###"/></span></td>
                                        </tr>
                                        --%>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!-- footer -->
        <c:import url="../top_statistics/statistics_footer.jsp"></c:import>
        <!-- //footer -->
    </div>
<script type='text/javascript'>
    $(document).ready(function () {
        _initButton();
    });

    //버튼 이벤트
    function _initButton() {
        $("#btn_search").on("click", function () {
            fnSearch();
        });

        $("#btn_excel").on("click", function () {
            fnExcel();
        });


        $("#btn_year_prev").on("click", function () {
            fnYearPrev();
        });
        $("#btn_year_next").on("click", function () {
            fnYearNext();
        });


        //월별 선택 버튼 클릭시 해당월에 해당하는 날짜 text 입력
        $(".monthbtn").click(function(){

            var imsimonth = $(this).attr("id");
            var imsiMonthStart = imsimonth -1;

            if(imsimonth.length < 2){
                imsimonth = "0" + imsimonth;
            }

            var imsiMonthStartStr = "0" + imsiMonthStart;

            if(imsiMonthStartStr.length > 2) {
                imsiMonthStartStr = imsiMonthStartStr.substring(1, imsiMonthStartStr.length);
            }

            $("#stdBgnde").val($("#year_txt").text() + "-" + imsiMonthStartStr + "-" + "16");
            $("#stdEndde").val($("#year_txt").text() + "-" + imsimonth + "-" + "15");

            if(imsimonth == 1){
                $("#stdBgnde").val(($("#year_txt").text()-1) + "-" + "12" + "-" + "16");
            }

            var frm = document.getElementById("srchFrm");
            frm.action = "./statistics_calc_member_list";
            //frm.submit();
        });


    }

    function fnSearch(){

        $("#srchTeamId").val("");
        $("#srchTeamType").val("");
        var frm = document.getElementById("srchFrm");
        frm.action = "./statistics_calc_member_list";
        frm.submit();
    }

    function fnMemberList(teamId, teamType){
        $("#srchTeamId").val(teamId);
        $("#srchTeamType").val(teamType);
        var frm = document.getElementById("srchFrm");
        frm.action = "./statistics_calc_member_list";
        frm.submit();
    }

    function fnYearPrev(){
        var imsiyeartxt = $("#year_txt").text();
        $("#year_txt").text(--imsiyeartxt);
        $("#stdBgnde").val(--imsiyeartxt+"-12-16");
        $("#stdEndde").val($("#year_txt").text()+"-12-15");

        var frm = document.getElementById("srchFrm");
        frm.action = "./statistics_calc_member_list";
        //frm.submit();

    }

    function fnYearNext(){
        var imsiyeartxt = $("#year_txt").text();
        $("#year_txt").text(++imsiyeartxt);
        $("#stdBgnde").val($("#year_txt").text()+"-12-16");
        $("#stdEndde").val(++imsiyeartxt+"-12-15");

        var frm = document.getElementById("srchFrm");
        frm.action = "./statistics_calc_member_list";
        //frm.submit();

    }

    function fnExcel(){
        //엑셀의 경우 ajax는 사용 불가.. 반드시 submit이나 href로 화면제어를 줘야함
        var data = $("#area_excel").html();
        $("#excelHtml").attr('value',data);
        $("#excelFrm").submit();
    }

</script>
<form id="excelFrm" name="excelFrm" method="post" action="./statistics_calc_list_excel">
    <input type="hidden" id="excelHtml" name="excelHtml"/>
    <input type="hidden" id="gubun" name="gubun" value="team"/>
</form>
</body>
</html>
