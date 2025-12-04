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
                                    <span style="color:red;"><b>${fn:substring(srchArg.stdEndde,0,4)}년 ${fn:substring(srchArg.stdEndde,5,7)}월</b></span> 이재조사비 정보 <span style="color:blue;"><b>실시간조회 갱신 페이지</b></span>
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
                                <form id="srchFrm" name="srchFrm" method="post" action="./expenseMain">
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
                                    <!-- 갱신하기 버튼 추가 시작-->
                                    <input type="button" id="expenseUpdate" value="갱신하기" /> (클릭시 현재 조회중인 월의 이재조사비정보가 갱신됩니다.)
                                    <input type="hidden" id="dataUpdate" name="dataUpdate" />&nbsp;&nbsp;&nbsp;
                                    <!-- 갱신하기 버튼 추가 끝-->
                                    <!-- 조회페이지로 이동 버튼 시작 -->
                                    <input type="button" id="goExpenseList" value="결과페이지이동" /> (연봉서버와 연동중인 페이지로 이동합니다.)
                                    <!-- 조회페이지로 이동 버튼 끝 -->
                                    <br>
                                </form>                                
                            </div>
                        </div>
                    </div>

                    <%--본문 영역--%>
                    <div class="centercnt_bot2">
                        <div class="guest">
                            <div class="guestTap">                                
                            	<!-- 내용 테이블 시작 -->
								<div class="tableStyle2">
								    <table cellpadding="0" cellspacing="0" align="center">								        
								        <tr>
								        	<th class="border-right" rowspan="2">센터명</th>
								        	<th class="border-right" rowspan="2">팀명</th>
								            <th class="border-right" rowspan="2">이름</th>
								            <th class="border-right" rowspan="2">직급</th>
								            <th class="border-right" rowspan="2">직무</th>
								            <th class="border-right" rowspan="2">직책</th>
								            <th class="border-right" rowspan="2">평균팀원</th>								            
								            <th class="border-right" rowspan="2">간접비</th>
								            <th class="border-right" rowspan="2">수수료매출</th>
								            <th class="border-right" colspan="4">기준업무량</th>
								            <th class="border-right" colspan="3">기준업무량(예외처리)</th>
								         	<th class="border-right" colspan="3">일비</th>	      
								         	<th class="border-right" rowspan="2">센터품질관리비</th>
								         	<th class="border-right" rowspan="2">서면심사<br/>(물보험서면심사외)</th>
								         	<th class="border-right" rowspan="2">양식보험<br/>승선지원비</th>
								         	<th class="border-right" rowspan="2">가축재해<br/>이재조사비</th>
								         	<th class="border-right" rowspan="2">교통비</th>      
								        </tr>
								        <tr>
								        	<th class="border-right">년 목표</th>
								        	<th class="border-right">월 목표</th>
								        	<th class="border-right">월 달성량</th>
								        	<th class="border-right">월 달성율</th>
								        	<th class="border-right">서면심사<br/>(WC)</th>
								        	<th class="border-right">서면심사<br/>(맥도날드)</th>
								        	<th class="border-right">서면심사<br/>(스마트스코어)</th>								        	
								        	<th class="border-right">당월종결</th>
								        	<th class="border-right">공동실적</th>
								        	<th class="border-right">합계</th>
								        </tr>
								        <c:forEach var="items" items="${memberList}" varStatus="status">
								        	<c:choose>
						                		<c:when test="${items.workType eq 14}"><tr bgcolor="orange"></c:when>
						                		<c:when test="${items.workType eq 3}"><tr bgcolor="yellow"></c:when>
						                		<c:otherwise><tr></c:otherwise>
						                	</c:choose>								        	
								        		<td class="border-right">${items.centerName}</td>
								                <td class="border-right">${items.teamName}</td>
								                <td class="border-right">${items.userName}</td>
								                <td class="border-right">${items.workLevelNm}</td>
								                <td class="border-right">${items.workJob}</td>
								                <td class="border-right">${items.workJobCd}</td>
								                <td class="border-right">
								                <%-- ${items.workType} --%>
								                ${items.memberAvg}								                	
								                </td>
								                <td class="border-right">${items.insideCost}</td>
								                <td class="border-right"><%-- ${items.amtBasic}<br/>${items.shareAmtBasic}<br/> --%>${items.sumAmtBasic}</td>
								                <td class="border-right">${items.workloadYear}</td>
								                <td class="border-right">${items.workloadMonth}</td>
								                <td class="border-right">${items.workloadCal}</td>
								                <td class="border-right">${items.workloadPer}</td>
								                <td class="border-right">${items.wcCost}</td>
								                <td class="border-right">${items.mcCost}</td>
								                <td class="border-right">${items.ssCost}</td>
								                <td class="border-right">${items.amtDaily}</td>
								                <td class="border-right">${items.shareAmtDaily}</td>
								                <td class="border-right">${items.sumAmtDaily}</td>
								                <td class="border-right">${items.centerManageCost}</td>
								                <td class="border-right">${items.extraCost}</td>
								                <td class="border-right">${items.extraSuhypCost}</td>
								                <td class="border-right">${items.extraCowCost}</td>
								                <td class="border-right">${items.sumAmtTraffic}</td>
											</tr>
								        </c:forEach>								        								        
								    </table>
								</div>                            	
                            </div>
                        </div>
                    </div>
                    <!-- 내용 테이블 끝 -->

                    <%--로딩 div --%>
                    <div id="loading" style="display: none;">
                        <img id="loading-image" src="./resources/cmm/images/spinner.gif" alt="Loading..." />
                    </div>
                    <%--로딩 div --%>
                </div>
            </div>
        </div>        
    </div>
    
<script type='text/javascript'>
    $(document).ready(function () {
        _initButton();
		$("#srchUserNo").select2();
		
		//갱신하기 버튼 클릭시
		$("#expenseUpdate").click( function(){
			if( confirm("조회된 이재조사비 정보를 갱신하시겠습니까?\n기존 등록정보는 삭제됩니다.") ){
				$("#loading").show();
				$("#dataUpdate").val('Y');
				$("#srchFrm").submit();	
			}
		});
		
		//갱신하기 버튼 클릭시
		$("#goExpenseList").click( function(){							
			$("#srchFrm").attr("action","expenseList").submit();			
		});
		
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
        frm.action = "./expenseMain";
        
    	//직원 선택 검색 추가 180918
    	if ( $("#srchUserNo").val() != 0){
            $("#srchTeamId").val( $("#srchUserNo").val() );
            frm.action = "./expenseMain";
    	}    	
    	
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
    
</script>
</body>
</html>