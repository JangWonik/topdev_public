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
    <link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
    <link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->

    <script src="./resources/jquery/jquery.min_1_12.js"></script>
    <script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
    <script src="./resources/ne_js/calendar.js?v=20170315151920"></script><!-- calendar -->

    <script src="./resources/wm_js/common.js"></script>
    <script src="./resources/cmm/js/common.js"></script>

    <style type="text/css">
        /*.tableStyle2 th {background:#efefef;}*/
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
                                    <img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" align="absmiddle">&nbsp; ${teamVo.team_name} 개인별 업무처리현황
                                </div>
                                <br/><br/>
                                <form id="srchFrm" name="srchFrm" method="post" action="./statistics_work_member_list">
                                    <input type="hidden" id="srchTeamId" name="team_id" value="${srchArg.team_id}"/>
                                    <input type="hidden" id="srchTeamType" name="team_type" value="${srchArg.team_type}"/>

                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <span style="color:#0066CC">기준일자</span>
                                    <input type="text" id="stdBgnde"  name="stdBgnde" size="10"  value="${srchArg.stdBgnde}" maxlength="10" readonly="readonly"/>
                                    <input type=image src="./resources/ne_img/icon_log_src.gif" width="110" height="22" border="0" class="btn">

                                    <p style="display: inline; float: right;">
                                        <%--<a id="btn_back" href="#noloc"><img src="./resources/ls_img/icon_copy_back.gif"></a>--%>
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
<%--
                            <div class="guestTap">
                                <ul>
                                    <li class="on"><a>${fn:substring(srchArg.stdBgnde,5,7)}월 개인별 처리내용</a></li>
                                </ul>
                            </div>
--%>
                            <div class="guestcnt2" id="area_excel" style="display:block;">
                                <div class="tableStyle2">
                                    <table cellpadding="0" cellspacing="0" width="1060" align="center">
                                        <colgroup>
                                            <col width="60">
                                            <col width="40">
                                            <col width="40">
                                            <col width="35"><!--건-->
                                            <col width="45"><!--퍼센트-->
                                            <col width="35"><!--건-->
                                            <col width="45"><!--퍼센트-->
                                            <col width="35"><!--건-->
                                            <col width="45"><!--퍼센트-->
                                            <col width="35"><!--건-->
                                            <col width="45"><!--퍼센트-->
                                            <col width="35"><!--건-->
                                            <col width="45"><!--퍼센트-->
                                            <col width="35"><!--건-->
                                            <col width="45"><!--퍼센트-->
                                            <col width="35"><!--건-->
                                            <col width="45"><!--퍼센트-->
                                            <col width="35"><!--건-->
                                            <col width="45"><!--퍼센트-->
                                            <col width="55">
                                            <col width="35">
                                            <col width="35">
                                        </colgroup>
                                        <tr>
                                            <th class="border-right" rowspan="2"><span style="color: black;"><b>이름</b></span></th>
                                            <th rowspan="2">접수</th>
                                            <th class="border-right" rowspan="2">종결</th>
                                            <th class="border-right" colspan="17" style="border-bottom: 1px solid #e5e5e5;">진행</th>
                                            <th colspan="2" style="border-bottom: 1px solid #e5e5e5;"><span style="color: black;"><b>합계</b></span></th>
                                        </tr>
                                        <tr>
                                            <th class="border-right" colspan="2">10일 미만</th>
                                            <th class="border-right" colspan="2">10일 초과</th>
                                            <th class="border-right" colspan="2">20일 초과</th>
                                            <th class="border-right" colspan="2">30일 초과</th>
                                            <th class="border-right" colspan="2">60일 초과</th>
                                            <th class="border-right" colspan="2">90일 초과</th>
                                            <th class="border-right"colspan="2">120일 초과</th>
                                            <th class="border-right" colspan="2">합계</th>
                                            <th class="border-right">평균경과일수<!-- 평균처리기일 --></th>
                                            <th>예상</th>
                                            <th>발생</th>
                                        </tr>
                                        <c:forEach  var="item" items="${workMemberList}" varStatus="status">
                                            <tr>
                                                <td class="border-right">${item.userName}</td>
                                                <td class="right"><fmt:formatNumber value="${item.receiveCnt}" pattern="#,###"/></td>
                                                <td class="right border-right"><fmt:formatNumber value="${item.closeCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.day10PrevCnt}" pattern="#,###"/></td>
                                                <td class="right border-right"><fmt:formatNumber value="${item.day10PrevPs}" pattern="##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${item.day10NextCnt}" pattern="#,###"/></td>
                                                <td class="right border-right"><fmt:formatNumber value="${item.day10NextPs}" pattern="##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${item.day20NextCnt}" pattern="#,###"/></td>
                                                <td class="right border-right"><fmt:formatNumber value="${item.day20NextPs}" pattern="##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${item.day30NextCnt}" pattern="#,###"/></td>
                                                <td class="right border-right"><fmt:formatNumber value="${item.day30NextPs}" pattern="##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${item.day60NextCnt}" pattern="#,###"/></td>
                                                <td class="right border-right"><fmt:formatNumber value="${item.day60NextPs}" pattern="##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${item.day90NextCnt}" pattern="#,###"/></td>
                                                <td class="right border-right"><fmt:formatNumber value="${item.day90NextPs}" pattern="##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${item.day120NextCnt}" pattern="#,###"/></td>
                                                <td class="right border-right"><fmt:formatNumber value="${item.day120NextPs}" pattern="##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${item.totalCnt}" pattern="#,###"/></td>
                                                <td class="right border-right"><fmt:formatNumber value="${item.totalPs}" pattern="###.#"/>%</td>
                                                <td class="right border-right">
                                                    <fmt:formatNumber var="itemTotalCnt" value="${item.totalCnt}" pattern="#.##"/>
                                                    <fmt:formatNumber var="itemRegDateTime" value="${item.regDateTime}" pattern="#.##"/>
                                                    <fmt:formatNumber value="${itemTotalCnt == 0 ? 0 : ((itemTotalCnt * unixTime - itemRegDateTime) / 86400) / itemTotalCnt}" pattern="#,###.#"/>일
                                                </td>
                                                <td class="right"><fmt:formatNumber value="${item.anticipationCnt}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${item.occurCnt}" pattern="#,###"/></td>
                                            </tr>
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
                                        <c:if test="${workMemberList.size() > 0}">
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
                                                <td class="border-right"> 합 계 </td>
                                                <td class="right"><fmt:formatNumber value="${subReceiveCnt1}" pattern="#,###"/></td>
                                                <td class="right border-right"><fmt:formatNumber value="${subCloseCnt1}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${subDay10PrevCnt1}" pattern="#,###"/></td>
                                                <td class="right border-right"><fmt:formatNumber value="${subTotalCnt1 == 0 ? 0.0 : subDay10PrevCnt1 / subTotalCnt1 * 100}" pattern="#,##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${subDay10NextCnt1}" pattern="#,###"/></td>
                                                <td class="right border-right"><fmt:formatNumber value="${subTotalCnt1 == 0 ? 0.0 : subDay10NextCnt1 / subTotalCnt1 * 100}" pattern="#,##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${subDay20NextCnt1}" pattern="#,###"/></td>
                                                <td class="right border-right"><fmt:formatNumber value="${subTotalCnt1 == 0 ? 0.0 : subDay20NextCnt1 / subTotalCnt1 * 100}" pattern="#,##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${subDay30NextCnt1}" pattern="#,###"/></td>
                                                <td class="right border-right"><fmt:formatNumber value="${subTotalCnt1 == 0 ? 0.0 : subDay30NextCnt1 / subTotalCnt1 * 100}" pattern="#,##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${subDay60NextCnt1}" pattern="#,###"/></td>
                                                <td class="right border-right"><fmt:formatNumber value="${subTotalCnt1 == 0 ? 0.0 : subDay60NextCnt1 / subTotalCnt1 * 100}" pattern="#,##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${subDay90NextCnt1}" pattern="#,###"/></td>
                                                <td class="right border-right"><fmt:formatNumber value="${subTotalCnt1 == 0 ? 0.0 : subDay90NextCnt1 / subTotalCnt1 * 100}" pattern="#,##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${subDay120NextCnt1}" pattern="#,###"/></td>
                                                <td class="right border-right"><fmt:formatNumber value="${subTotalCnt1 == 0 ? 0.0 : subDay120NextCnt1 / subTotalCnt1 * 100}" pattern="#,##0.0"/>%</td>
                                                <td class="right"><fmt:formatNumber value="${subTotalCnt1}" pattern="#,###"/></td>
                                                <td class="right border-right"><fmt:formatNumber value="${subTotalCnt1 == 0 ? 0.0 : subTotalCnt1 / subTotalCnt1 * 100}" pattern="#,###"/>%</td>
                                                <td class="right border-right">
                                                    <fmt:formatNumber value="${subTotalCnt1 == 0 ? 0 : ((subTotalCnt1 * unixTime - subRegDateTime1) / 86400) / subTotalCnt1}" pattern="#,###.#"/>일
                                                </td>
                                                <td class="right"><fmt:formatNumber value="${subAnticipationCnt1}" pattern="#,###"/></td>
                                                <td class="right"><fmt:formatNumber value="${subOccurCnt1}" pattern="#,###"/></td>
                                            </tr>
                                        </c:if>
                                        <c:if test="${workMemberList.size() == 0}">
                                            <tr>
                                                <td colspan = "22">
                                                    검색 결과가 존재 하지 않습니다.
                                                </td>
                                            </tr>
                                        </c:if>
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
        $("#btn_excel").on("click", function () {
            fnExcel();
        });
        /*
        $("#btn_back").on("click", function () {
            fnGoBack();
        });
        */
    }

    function fnExcel(){
        //엑셀의 경우 ajax는 사용 불가.. 반드시 submit이나 href로 화면제어를 줘야함
        var data = $("#area_excel").html();
        $("#excelHtml").attr('value',data);
        $("#excelFrm").submit();

    }

    function fnGoBack(){
        var frm = document.getElementById("srchFrm");
        frm.action = "./statistics_work_team_list";
        frm.submit();
    }

</script>
<form id="excelFrm" name="excelFrm" method="post" action="./statistics_work_list_excel">
    <input type="hidden" id="excelHtml" name="excelHtml"/>
    <input type="hidden" id="gubun" name="gubun" value="member"/>
</form>
</body>
</html>
