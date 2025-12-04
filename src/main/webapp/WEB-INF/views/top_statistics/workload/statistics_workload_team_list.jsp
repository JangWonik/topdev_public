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
        <c:import url="../statistics_menu.jsp"></c:import>
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
                                    <c:choose>
                                    	<c:when test="${srchArg.type == '1'}">
                                    		<b>센터별 평가기준 달성도 통계</b>
                                    	</c:when>
                                    	<c:when test="${srchArg.type == '2'}">
                                    		<b>팀별 평가기준 달성도 통계</b>	
                                   		</c:when>
                                    	<c:when test="${srchArg.type == '3'}">
                                    		<b>개인별 평가기준 달성도 통계</b>
                                    	</c:when>
                                    </c:choose>
                                </div>
                                
                                <div style="text-align: right;">
                                    <a id="btn_year_prev" href="#noloc">
                                        <img src="./resources/ne_img/icon_prev.gif" width="17" height="13" border="0">
                                    </a>
                                    <a id="year_txt" href="#noloc;">${fn:substring(srchArg.endDate,0,4)}</a>
                                    <a id="btn_year_next" href="#noloc">
                                        <img src="./resources/ne_img/icon_next.gif" width="17" height="13" border="0">
                                    </a>
                                    <c:forEach var="i" begin="1" end="12" step="1" varStatus="">
                                        <input id="${i}" class="monthbtn" type="button" value="${i}월" />
                                    </c:forEach>
                                </div><br/>
                                
                                <form id="srchFrm" name="srchFrm" method="get" action="./workloadStatistics">
                                	
                                	<input type="hidden" id="gubun" name="gubun" value="${srchArg.gubun}">
                                	<input type="hidden" id="type" name="type" value="${srchArg.type}">
                                	<input type="hidden" id="extra" name="extra" value="${srchArg.extra}">
                                	
                                	<input type="hidden" id="teamId" name="teamId" value="${srchArg.teamId}">
                                	<input type="hidden" id="teamGroupOrder" name="teamGroupOrder" value="${srchArg.teamGroupOrder}">
                                	
                                    <input type="hidden" id="srchBasicYN" name="basicYN" value="${srchArg.basicYN}"/>
                                    <input type="hidden" id="srchPrimYN" name="primYN" value="${srchArg.primYN}"/>
                                    <input type="hidden" id="srchContractYN" name="contractYN" value="${srchArg.contractYN}"/>
                                    <input type="hidden" id="srchExcelYN" name="excelYN" value="N">
                                    
                                    <input type="hidden" id="srchOrderDirection" name="orderDirection" value="${srchArg.orderDirection}" />
                                    <input type="hidden" id="srchOrderKey" name="orderKey" value="${srchArg.orderKey}" />
                                    
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="text" class="classCalendar" id="startDate"  name="startDate" size="10"  value="${srchArg.startDate}" maxlength="10" readonly="readonly"/>
                                    <span style="color:#0066CC">부터</span>&nbsp;&nbsp;&nbsp;
                                    <input type="text" class="classCalendar" id="endDate"  name="endDate" size="10"  value="${srchArg.endDate}" maxlength="10" readonly="readonly"/>
                                    <span style="color:#0066CC">까지</span>&nbsp;&nbsp;&nbsp;
                                    
                                    <input type="checkbox" id="basicYN" <c:if test="${srchArg.basicYN == 'Y'}">checked</c:if> /> <label for="basicYN">기본수임</label>&nbsp;&nbsp;
                                    <input type="checkbox" id="primYN" <c:if test="${srchArg.primYN == 'Y'}">checked</c:if> /> <label for="primYN">농작물</label>&nbsp;&nbsp;
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
                                    <c:choose>
                                    	<c:when test="${srchArg.type == '1'}">
                                    		<li class="on"><a href="#noloc">센터별 평가기준 달성도</a></li>
                                    	</c:when>
                                    	<c:when test="${srchArg.type == '2'}">
                                    		<li class="on"><a href="#noloc">팀별 평가기준 달성도</a></li>
                                   		</c:when>
                                    	<c:when test="${srchArg.type == '3'}">
                                    		<li class="on"><a href="#noloc">개인별 평가기준 달성도</a></li>
                                    	</c:when>
                                    </c:choose>
                                </ul>
                            </div>
                            <div class="guestcnt2" style="display:block;">
								<c:choose>
                                   	<c:when test="${srchArg.type == '3'}">
                                   		<c:import url="./statistics_workload_member_list_01.jsp"></c:import>
                                   	</c:when>
                                   	<c:otherwise>
		                                <c:import url="./statistics_workload_team_list_01.jsp"></c:import>
                                   	</c:otherwise>
								</c:choose>
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
        <c:import url="../statistics_footer.jsp"></c:import>
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

            $("#startDate").val($("#year_txt").text() + "-" + imsiMonthStartStr + "-" + "16");
            $("#endDate").val($("#year_txt").text() + "-" + imsimonth + "-" + "15");

            if(imsimonth == 1){
                $("#startDate").val(($("#year_txt").text()-1) + "-" + "12" + "-" + "16");
            }

            fnSearch();
        });


    }

    /*
    function fnMemberDetail(userNo){
        $("#srchUserNo").val(userNo);
        var frm = document.getElementById("srchFrm");
        frm.action = "./statistics_basic_member_detail";
        frm.submit();
    }
	*/

    function fnSearch(){
		if (!fnVaildDate()){
			return;
		}
		
        $("#loading").show();
        $("#srchExcelYN").val("N");
        var frm = document.getElementById("srchFrm");
        frm.action = "./workloadStatistics";
        frm.submit();
    }

    function fnYear(){
        var imsiyeartxt = $("#year_txt").text();
        $("#startDate").val(--imsiyeartxt+"-12-16");
        $("#endDate").val($("#year_txt").text()+"-12-15");

        fnSearch();
    }

    function fnYearPrev(){
        var imsiyeartxt = $("#year_txt").text();
        $("#year_txt").text(--imsiyeartxt);
        $("#startDate").val(--imsiyeartxt+"-12-16");
        $("#endDate").val($("#year_txt").text()+"-12-15");

        fnSearch();
    }

    function fnYearNext(){
        var imsiyeartxt = $("#year_txt").text();
        $("#year_txt").text(++imsiyeartxt);
        $("#startDate").val(--imsiyeartxt + "-12-16");
        $("#endDate").val($("#year_txt").text()+"-12-15");

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
//        var data = $("#area_excel").html();
//        $("#excelHtml").attr('value',data);
//        $("#excelFrm").submit();
        $("#srchExcelYN").val("Y");
        var frm = document.getElementById("srchFrm");
        frm.action = "./workloadStatistics";
        frm.submit();
    }

	function fnVaildDate(){
		var startDate = $("#startDate").val();
		var endDate = $("#endDate").val();
		var startArr = startDate.split('-');
		var endArr = endDate.split('-');
		var sDate = new Date(startArr[0], startArr[1], startArr[2]);
		var eDate = new Date(endArr[0], endArr[1], endArr[2]);
		
		var diff = eDate - sDate;
		var currDay = 24 * 60 * 60 * 1000; //시 * 분 * 초 * 밀리세컨
		var diffCnt= parseInt(diff/currDay);
		
		if (diffCnt > 365){
			alert("검색 가능한 날짜 범위를 초과하였습니다");
			return false;
		}
		
		return true;
	}
    
    
</script>
<%--<form id="excelFrm" name="excelFrm" method="post" action="./statistics_calc_list_excel">--%>
    <%--<input type="hidden" id="excelHtml" name="excelHtml"/>--%>
    <%--<input type="hidden" id="gubun" name="gubun" value="team"/>--%>
<%--</form>--%>
</body>
</html>
