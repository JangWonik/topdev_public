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
        td.cr {
            color: red;
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
                                <span style="color:red;"><b>${fn:substring(srchArg.stdEndde,0,4)}년 ${fn:substring(srchArg.stdEndde,5,7)}월</b></span> 개인별 평균 통계
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
                            <form id="srchFrm" name="srchFrm" method="post" action="./statistics_result_member_list">
                                <input type="hidden" id="srchTeamId" name="team_id" value="${srchArg.team_id}"/>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="text" id="stdBgnde"  name="stdBgnde" size="10"  value="${srchArg.stdBgnde}" maxlength="10" readonly="readonly"/>
                                <span style="color:#0066CC">부터</span>&nbsp;&nbsp;&nbsp;
                                <input type="text" id="stdEndde"  name="stdEndde" size="10"  value="${srchArg.stdEndde}" maxlength="10" readonly="readonly"/>
                                <span style="color:#0066CC">까지</span>&nbsp;&nbsp;&nbsp;

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
                        <div class="guestTap">
                            <ul>
                                <li class="on"><a>${fn:substring(srchArg.stdEndde,0,4)}년 ${fn:substring(srchArg.stdEndde,5,7)}월 개인별 평균 통계</a></li>
                            </ul>
                        </div>
                        <div class="guestcnt2" id="area_excel" style="display:block;">
                            <div class="tableStyle2">
                                <table cellpadding="0" cellspacing="0" width="1060" align="center">
                                    <colgroup>
                                        <col width="110">
                                        <col width="90">
                                        <col width="86">
                                        <col width="86">
                                        <col width="86">
                                        <col width="86">
                                        <col width="86">
                                        <col width="86">
                                        <col width="86">
                                        <col width="86">
                                        <col width="86">
                                        <col width="86">
                                    </colgroup>
                                    <tr>
                                        <th><span style="color: black;"><b>팀</b></span></th>
                                        <th><span style="color: black;"><b>이름</b></span></th>
                                        <th>유지/지급</th>
                                        <th>유지/삭감</th>
                                        <th>유지/면책</th>
                                        <th>해지/지급</th>
                                        <th>해지/삭감</th>
                                        <th>해지/면책</th>
                                        <th>무담보/지급</th>
                                        <th>무담보/삭감</th>
                                        <th>무담보/면책</th>
                                        <th>합계</th>
                                    </tr>
                                    <c:set var="listCnt" value="${memberList.size()}"/>
                                    <c:forEach  var="item" items="${memberList}" varStatus="status">
                                        <tr>
                                            <c:if test="${status.index == 0}">
                                                <td rowspan="${listCnt}" bgcolor="#F8F8F8">${teamVo.team_name}</td>
                                            </c:if>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${item.userState == 1}">
                                                        <span style="color:red">${item.userName}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${item.userName}
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="right"><fmt:formatNumber value="${item.rptCnt1}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${item.rptCnt2}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${item.rptCnt3}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${item.rptCnt4}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${item.rptCnt5}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${item.rptCnt6}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${item.rptCnt7}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${item.rptCnt8}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${item.rptCnt9}" pattern="#,###"/></td>
                                            <td class="right"><fmt:formatNumber value="${item.rptCntSum}" pattern="#,###"/></td>
                                        </tr>
                                        <c:set var="totalRptCnt1" value="${totalRptCnt1 + item.rptCnt1}"/>
                                        <c:set var="totalRptCnt2" value="${totalRptCnt2 + item.rptCnt2}"/>
                                        <c:set var="totalRptCnt3" value="${totalRptCnt3 + item.rptCnt3}"/>
                                        <c:set var="totalRptCnt4" value="${totalRptCnt4 + item.rptCnt4}"/>
                                        <c:set var="totalRptCnt5" value="${totalRptCnt5 + item.rptCnt5}"/>
                                        <c:set var="totalRptCnt6" value="${totalRptCnt6 + item.rptCnt6}"/>
                                        <c:set var="totalRptCnt7" value="${totalRptCnt7 + item.rptCnt7}"/>
                                        <c:set var="totalRptCnt8" value="${totalRptCnt8 + item.rptCnt8}"/>
                                        <c:set var="totalRptCnt9" value="${totalRptCnt9 + item.rptCnt9}"/>
                                        <c:set var="totalRptCntSum" value="${totalRptCntSum + item.rptCntSum}"/>
                                    </c:forEach>
                                    <tr bgcolor="#EFEFEF">
                                        <td colspan="2"><b>합계</b></td>
                                        <td class="right cr"><fmt:formatNumber value="${totalRptCnt1}" pattern="#,###"/></td>
                                        <td class="right cr"><fmt:formatNumber value="${totalRptCnt2}" pattern="#,###"/></td>
                                        <td class="right cr"><fmt:formatNumber value="${totalRptCnt3}" pattern="#,###"/></td>
                                        <td class="right cr"><fmt:formatNumber value="${totalRptCnt4}" pattern="#,###"/></td>
                                        <td class="right cr"><fmt:formatNumber value="${totalRptCnt5}" pattern="#,###"/></td>
                                        <td class="right cr"><fmt:formatNumber value="${totalRptCnt6}" pattern="#,###"/></td>
                                        <td class="right cr"><fmt:formatNumber value="${totalRptCnt7}" pattern="#,###"/></td>
                                        <td class="right cr"><fmt:formatNumber value="${totalRptCnt8}" pattern="#,###"/></td>
                                        <td class="right cr"><fmt:formatNumber value="${totalRptCnt9}" pattern="#,###"/></td>
                                        <td class="right cr"><fmt:formatNumber value="${totalRptCntSum}" pattern="#,###"/></td>
                                    </tr>
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

        $("#year_txt").on("click", function () {
            fnYear();
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
            frm.action = "./statistics_result_member_list";
            frm.submit();
        });


    }

    function fnSearch(){
        var frm = document.getElementById("srchFrm");
        frm.action = "./statistics_result_member_list";
        frm.submit();
    }

    function fnYear(){
        var imsiyeartxt = $("#year_txt").text();
        $("#stdBgnde").val(--imsiyeartxt+"-12-16");
        $("#stdEndde").val($("#year_txt").text()+"-12-15");
        var frm = document.getElementById("srchFrm");
        frm.action = "./statistics_result_member_list";
        frm.submit();

    }


    function fnYearPrev(){
        var imsiyeartxt = $("#year_txt").text();
        $("#year_txt").text(--imsiyeartxt);
        $("#stdBgnde").val(--imsiyeartxt+"-12-16");
        $("#stdEndde").val($("#year_txt").text()+"-12-15");

        var frm = document.getElementById("srchFrm");
        frm.action = "./statistics_result_member_list";
        frm.submit();

    }

    function fnYearNext(){
        var imsiyeartxt = $("#year_txt").text();
        $("#year_txt").text(++imsiyeartxt);
        $("#stdBgnde").val(--imsiyeartxt + "-12-16");
        $("#stdEndde").val($("#year_txt").text()+"-12-15");

        var frm = document.getElementById("srchFrm");
        frm.action = "./statistics_result_member_list";
        frm.submit();

    }

    function fnExcel(){
        //엑셀의 경우 ajax는 사용 불가.. 반드시 submit이나 href로 화면제어를 줘야함
        var data = $("#area_excel").html();
        $("#excelHtml").attr('value',data);
        $("#excelFrm").submit();
    }

</script>
<form id="excelFrm" name="excelFrm" method="post" action="./statistics_result_list_excel">
    <input type="hidden" id="excelHtml" name="excelHtml"/>
    <input type="hidden" id="gubun" name="gubun" value="member"/>
</form>
</body>
</html>
