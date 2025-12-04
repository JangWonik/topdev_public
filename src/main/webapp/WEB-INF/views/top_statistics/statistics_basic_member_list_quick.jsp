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
    
    <link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>

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
        
        .buttonDiaAll{
			width:140px;
			height:23px;
		    background-color:#2E7EE8;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		    }
		
		.buttonDiaTeam{
			width:120px;
			height:23px;
		    background-color:darkCyan;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 13px;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
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
                                    <b>${teamVo.team_name} 개인별 통계</b>
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
                                <form id="srchFrm" name="srchFrm" method="post" action="./statistics_basic_member_list_quick">
                                    <input type="hidden" id="srchUserNo" name="user_no"/>
                                    <input type="hidden" id="srchBasicYN" name="basicYN" value="${srchArg.basicYN}"/>
                                    <input type="hidden" id="srchPrimYN" name="primYN" value="${srchArg.primYN}"/>
                                    <input type="hidden" id="srchContractYN" name="contractYN" value="${srchArg.contractYN}"/>
                                    <input type="hidden" id="srchExcelYN" name="excelYN" value="N">
                                    <input type="hidden" id="retireUser" name="retireUser" value="N">
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="text" id="stdBgnde"  name="stdBgnde" size="10"  value="${srchArg.stdBgnde}" maxlength="10" readonly="readonly"/>
                                    <span style="color:#0066CC">부터</span>&nbsp;&nbsp;&nbsp;
                                    <input type="text" id="stdEndde"  name="stdEndde" size="10"  value="${srchArg.stdEndde}" maxlength="10" readonly="readonly"/>
                                    <span style="color:#0066CC">까지</span>&nbsp;&nbsp;&nbsp;

                                    <select id="srchTeamId" name="team_id" onchange="fnSearch();" style="width:200px;">
                                        <c:forEach var="team" items="${teamList}" varStatus="status">
                                            <option value="${team.teamId}" <c:if test="${team.teamId == srchArg.team_id}">selected="selected"</c:if>>${team.teamName}</option>
                                        </c:forEach>
                                    </select>&nbsp;&nbsp;&nbsp;

                                    <input type="checkbox" id="basicYN" <c:if test="${srchArg.basicYN == 'Y'}">checked</c:if> /> <label for="basicYN">기본수임</label>&nbsp;&nbsp;
                                    <input type="checkbox" id="primYN"  <c:if test="${srchArg.primYN == 'Y'}">checked</c:if> /> <label for="primYN">농작물</label>&nbsp;&nbsp;
                                    <input type="checkbox" id="contractYN"  <c:if test="${srchArg.contractYN == 'Y'}">checked</c:if> /> <label for="contractYN">적부</label>&nbsp;&nbsp;

                                    <a id="btn_search" href="#noloc">
                                        <img src="./resources/ne_img/icon_log_src.gif" width="110" height="22" border="0">
                                    </a>
                                    <p style="display: inline; float: right;">
                                        <c:if test="${mbrVo_Session.user_state == '9' || mbrVo_Session.user_no =='215' || mbrVo_Session.user_no =='966' || mbrVo_Session.user_no =='1265' || mbrVo_Session.user_no =='371' || mbrVo_Session.user_no =='1421'}">
                                            <!-- <input type="button" class="monthbtn" onclick="fnWholeExcel()" value="팀전체 엑셀다운"/> -->
                                            <input title="퇴직자 포함엑셀다운" class="buttonDiaAll" id="allNonBtn" onclick="fnWholeNonExcel()" type="button" value="퇴직자 포함엑셀다운">                                            
                                            <input title="팀전체 엑셀다운" class="buttonDiaTeam" id="allBtn" onclick="fnWholeExcel()" type="button" value="팀전체 엑셀다운">
                                        </c:if>
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
                                    <li class="on"><a href="#noloc">개인기준 개인별 통계</a></li>
                                    <li><a href="#noloc">팀기준 개인별 통계</a></li>
                                </ul>
                            </div>
                            <div class="guestcnt2" style="display:block;">
                                <c:import url="./statistics_basic_member_list_02_quick.jsp"></c:import>
                            </div>
                            <div class="guestcnt2" style="display:none;">
                                <c:import url="./statistics_basic_member_list_01_quick.jsp"></c:import>
                            </div>
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
        $("#srchTeamId").select2();
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

    function fnMemberDetail(userNo){
    	
    	$("#srchExcelYN").val("N");
        $("#srchUserNo").val(userNo);
        var frm = document.getElementById("srchFrm");
        frm.action = "./statistics_basic_member_detail";
        frm.submit();
    }


    function fnSearch(){
        $("#loading").show();

        $("#retireUser").val("N");
        $("#srchExcelYN").val("N");
        var frm = document.getElementById("srchFrm");
        frm.action = "./statistics_basic_member_list_quick";
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
// 
    function fnExcel(){
    	$("#retireUser").val('N');
        $("#srchExcelYN").val("Y");
        var frm = document.getElementById("srchFrm");
        frm.action = "./statistics_basic_member_list_quick";
        frm.submit();
    }

    function fnWholeExcel(){
    	$("#retireUser").val('N');
        var frm = document.getElementById("srchFrm");
        frm.action = "./statistics_basic_member_list_whole_excel_quick";
        frm.submit();
    }
    
    function fnWholeNonExcel(){
        var frm = document.getElementById("srchFrm");
        $("#retireUser").val('Y');
        frm.action = "./statistics_basic_member_list_whole_excel_quick";
        frm.submit();
    }

</script>
<%--<form id="excelFrm" name="excelFrm" method="post" action="./statistics_calc_list_excel">--%>
    <%--<input type="hidden" id="excelHtml" name="excelHtml"/>--%>
    <%--<input type="hidden" id="gubun" name="gubun" value="team"/>--%>
<%--</form>--%>
</body>
</html>
