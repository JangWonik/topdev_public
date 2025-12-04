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

	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>
	
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
                                    <span style="color:red;"><b>${fn:substring(srchArg.stdEndde,0,4)}년 ${fn:substring(srchArg.stdEndde,5,7)}월</b></span> 팀별 평균 통계
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
                                <form id="srchFrm" name="srchFrm" method="post" action="./statistics_basic_team_list">
                                	<input type="hidden" id="tabType" name="tabType" value="${tabType}"/>
                                    <input type="hidden" id="srchTeamId" name="team_id"/>
                                    <input type="hidden" id="srchBasicYN" name="basicYN" value="${srchArg.basicYN}"/>
                                    <input type="hidden" id="srchPrimYN" name="primYN" value="${srchArg.primYN}"/>
                                    <input type="hidden" id="srchContractYN" name="contractYN" value="${srchArg.contractYN}"/>
                                    <input type="hidden" id="srchExcelYN" name="excelYN" value="N">
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="text" id="stdBgnde"  name="stdBgnde" size="10"  value="${srchArg.stdBgnde}" maxlength="10" readonly="readonly"/>
                                    <span style="color:#0066CC">부터</span>&nbsp;&nbsp;&nbsp;
                                    <input type="text" id="stdEndde"  name="stdEndde" size="10"  value="${srchArg.stdEndde}" maxlength="10" readonly="readonly"/>
                                    <span style="color:#0066CC">까지</span>&nbsp;&nbsp;&nbsp;

                                    <input type="checkbox" id="basicYN" <c:if test="${srchArg.basicYN == 'Y'}">checked</c:if> /> <label for="basicYN">기본수임</label>&nbsp;&nbsp;
                                    <input type="checkbox" id="primYN" <c:if test="${srchArg.primYN == 'Y'}">checked</c:if> /> <label for="primYN">농작물</label>&nbsp;&nbsp;
                                    <input type="checkbox" id="contractYN" <c:if test="${srchArg.contractYN == 'Y'}">checked</c:if> /> <label for="contractYN">적부</label>&nbsp;&nbsp;
                                    
									<select id="srchUserNo" name="srchUserNo">
										<option value="0"> - 직원검색 - </option>
										<c:forEach items="${memberList}" var="item" >
											<option value="${item.teamId}">${item.userName}</option>
										
										</c:forEach>										
									</select>                                    
                                    
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
                                	<c:if test="${tabType eq '1' || tabType eq ''}">                                    
	                                    <li id="tabMenu1" class="on"><a href="#">1종</a></li>
	                                    <li id="tabMenu2"><a href="#">4종</a></li>
	                                    <li id="tabMenu3"><a href="#">1종+4종</a></li>
                                    </c:if>
                                    <c:if test="${tabType eq '4'}">
                                    	<li id="tabMenu1"><a href="#">1종</a></li>
                                    	<li id="tabMenu2" class="on"><a href="#">4종</a></li>
                                    	<li id="tabMenu3"><a href="#">1종+4종</a></li>
                                    </c:if>
                                    <c:if test="${tabType eq '5'}">
                                    	<li id="tabMenu1"><a href="#">1종</a></li>
                                    	<li id="tabMenu2"><a href="#">4종</a></li>
                                    	<li id="tabMenu3" class="on"><a href="#">1종+4종</a></li>
                                    </c:if>
                                </ul>
                            </div>
                            <div class="guestcnt2" style="display:block;">
                            	<c:if test="${tabType eq '1' || tabType eq ''}">
                            	<c:import url="./statistics_basic_team_list_02.jsp"></c:import>
                            	</c:if>
                            	<c:if test="${tabType eq '4'}">                                                            
                                <c:import url="./statistics_basic_team_list_03.jsp"></c:import>
                                </c:if>
                                <c:if test="${tabType eq '5'}">                            
                                <c:import url="./statistics_basic_team_list_01.jsp"></c:import>
                                </c:if>
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
		$("#srchUserNo").select2();
    });
    
    $("#tabMenu1").click(function(){    	
		$("#tabType").val('1');
		fnSearch();
	});
    
    $("#tabMenu2").click(function(){    	
		$("#tabType").val('4');
		fnSearch();
	});
    
    $("#tabMenu3").click(function(){    	
		$("#tabType").val('5');
		fnSearch();
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

        $("#srchTeamId").val("");
        $("#srchExcelYN").val("N");
        var frm = document.getElementById("srchFrm");
        frm.action = "./statistics_basic_team_list";
        
    	//직원 선택 검색 추가 180918
    	if ( $("#srchUserNo").val() != 0){
            $("#srchTeamId").val( $("#srchUserNo").val() );
            frm.action = "./statistics_basic_member_list";
    	}    	
    	
        frm.submit();
    }

    function fnMemberList(teamId, teamType){
    	$("#srchExcelYN").val("N");
        $("#srchTeamId").val(teamId);
        var frm = document.getElementById("srchFrm");
        frm.action = "./statistics_basic_member_list";
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
        $("#srchExcelYN").val("Y");        
        var frm = document.getElementById("srchFrm");
        frm.action = "./statistics_basic_team_list";
        frm.submit();
    }

</script>
</body>
</html>
