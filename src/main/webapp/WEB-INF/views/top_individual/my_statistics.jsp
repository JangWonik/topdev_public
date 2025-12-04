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
    <link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=20170411111520" />
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
        th.right {
            text-align: right;
            padding-right: 3px;
        }
        th.left {
            text-align: left;
            padding-left: 1em;
        }
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
        <c:import url="../top_main/top_main_menu.jsp"></c:import>
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
                                    <b>${teamVo.team_name} ${memberVo.userName} 통계</b>
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
                                <form id="srchFrm" name="srchFrm" method="post" action="./myStatistics">
                                    <input type="hidden" id="srchTeamId" name="team_id" value="${srchArg.team_id}"/>
                                    <input type="hidden" id="srchBasicYN" name="basicYN" value="${srchArg.basicYN}"/>
                                    <input type="hidden" id="srchPrimYN" name="primYN" value="${srchArg.primYN}"/>
                                    <input type="hidden" id="srchContractYN" name="contractYN" value="${srchArg.contractYN}"/>
                                    <input type="hidden" id="srchExcelYN" name="excelYN" value="N">
                                    <%--<input type="hidden" id="srchUserNo" name="user_no" value="${srchArg.user_no}"/>--%>

                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="text" id="stdBgnde"  name="stdBgnde" size="10"  value="${srchArg.stdBgnde}" maxlength="10" readonly="readonly"/>
                                    <span style="color:#0066CC">부터</span>&nbsp;&nbsp;&nbsp;
                                    <input type="text" id="stdEndde"  name="stdEndde" size="10"  value="${srchArg.stdEndde}" maxlength="10" readonly="readonly"/>
                                    <span style="color:#0066CC">까지</span>&nbsp;&nbsp;&nbsp;

                                    <input type="checkbox" id="basicYN" <c:if test="${srchArg.basicYN == 'Y'}">checked</c:if> /> <label for="basicYN">기본수임</label>&nbsp;&nbsp;
                                    <input type="checkbox" id="primYN"  <c:if test="${srchArg.primYN == 'Y'}">checked</c:if> /> <label for="primYN">농작물</label>&nbsp;&nbsp;
                                    <input type="checkbox" id="contractYN"  <c:if test="${srchArg.contractYN == 'Y'}">checked</c:if> /> <label for="contractYN">적부</label>&nbsp;&nbsp;

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
                                    <li class="on"><a href="#">개인기준 상세 리스트( ${detailPersonStandardList.size()} )</a></li>
                                    <%--<li><a href="#noloc">팀기준 상세 리스트( ${detailList.size()} )</a></li> --%>
                                    <%--<li><a href="#">농작물( ${primList.size() + primOutAmtList.size()} )</a></li>--%>
                                    <%--<li><a href="#">적부( ${contList.size() + contOutAmtList.size()} )</a></li>--%>
                                </ul>
                            </div>
                            <div class="guestcnt2" style="display:block;">
                                <c:import url="../top_statistics/statistics_basic_member_detail_02.jsp"/>
                            </div>
                            
<%--
                            <div class="guestcnt2" style="display:none;">
                                <c:import url="./statistics_basic_member_detail_01.jsp"/>
                            </div>

                            <div class="guestcnt2" style="display:none;">
                                <c:import url="./statistics_basic_member_detail_02.jsp"/>
                            </div>
                            <div class="guestcnt2" style="display:none;">
                                <c:import url="./statistics_basic_member_detail_03.jsp"/>
                            </div>
--%>

                        </div>
                    </div>

                    <%--로딩 div --%>
                    <div id="loading" style="display: none;">
                        <img id="loading-image" src="./resources/cmm/images/spinner.gif" alt="Loading..." />
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

        $("#basicYN").on("click", function () {
            fnToggle("basicYN","srchBasicYN");
        });

        $("#primYN").on("click", function () {
            fnToggle("primYN","srchPrimYN");
        });

        $("#contractYN").on("click", function () {
            fnToggle("contractYN","srchContractYN");
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

            fnSearch();
        });


    }

    function fnSearch(){
        $("#loading").show();

        $("#srchExcelYN").val("N");
        var frm = document.getElementById("srchFrm");
        frm.action = "./myStatistics";
        frm.submit();
    }


    function fnYear(){
        var imsiyeartxt = $("#year_txt").text();
        $("#stdBgnde").val(--imsiyeartxt+"-12-16");
        $("#stdEndde").val($("#year_txt").text()+"-12-15");

        fnSearch();
    }

    function fnYearPrev(){
        var imsiyeartxt = $("#year_txt").text();
        $("#year_txt").text(--imsiyeartxt);
        $("#stdBgnde").val(--imsiyeartxt+"-12-16");
        $("#stdEndde").val($("#year_txt").text()+"-12-15");

        fnSearch();

    }

    function fnYearNext(){
        var imsiyeartxt = $("#year_txt").text();
        $("#year_txt").text(++imsiyeartxt);
        $("#stdBgnde").val(--imsiyeartxt + "-12-16");
        $("#stdEndde").val($("#year_txt").text()+"-12-15");

        fnSearch();

    }

    function fnToggle(srcId, targetId){
        if ($("#" + srcId).prop("checked")){
            $("#" + targetId).val("Y");
        }else{
            $("#" + targetId).val("N");
        }
    }

    function fnExcel(){
        //엑셀의 경우 ajax는 사용 불가.. 반드시 submit이나 href로 화면제어를 줘야함
        //var data = $("#area_excel").html();
        //$("#excelHtml").attr('value',data);
        //$("#excelFrm").submit();

        $("#srchExcelYN").val("Y");
        var frm = document.getElementById("srchFrm");
        frm.action = "./myStatistics";
        frm.submit();

    }

    function fnPopSuimDtl(suim_rpt_no){
        var cw=screen.availWidth;
        var ch=screen.availHeight;
        var sw=1010; //띄울 창의 넓이
        var sh=screen.availHeight;  //띄울 창의 높이
        var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
        var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
        window.open('suimRptBscDtl?suim_rpt_no='+suim_rpt_no, suim_rpt_no,'width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=yes,scrollbars=yes');
    }

    function fnPopSuimDtlPrim(suim_rpt_no){
        var cw=screen.availWidth;
        var ch=screen.availHeight;
        var sw=1010; //띄울 창의 넓이
        var sh=740;  //띄울 창의 높이
        var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
        var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
        window.open('primBizRptDtl?suim_rpt_no='+suim_rpt_no,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
    }


</script>
<form id="excelFrm" name="excelFrm" method="post" action="./statistics_basic_member_detail_excel">
    <input type="hidden" id="excelHtml" name="excelHtml"/>
    <input type="hidden" id="gubun" name="gubun" value="team"/>
</form>
</body>
</html>
