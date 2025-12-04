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
                                    <span style="color:red;"><b>${baseYear}년 ${baseMonth}월</b></span> 이재조사비 정보 <span style="color:blue;"><b>조회 페이지</b></span>
                                </div>
                                <div style="text-align: right;">
                                    <a id="btn_year_prev" href="#noloc">
                                        <img src="./resources/ne_img/icon_prev.gif" width="17" height="13" border="0">
                                    </a>
                                    <a id="year_txt" href="#noloc;">${baseYear}</a>
                                    <a id="btn_year_next" href="#noloc">
                                        <img src="./resources/ne_img/icon_next.gif" width="17" height="13" border="0">
                                    </a>
                                    <c:forEach var="i" begin="1" end="12" step="1" varStatus="">
                                        <input id="${i}" class="monthbtn" type="button" value="${i}월" />
                                    </c:forEach>
                                </div><br/>
                                <form id="srchFrm" name="srchFrm" method="post" action="./expenseMain">                                	
                                    <input type="text" id="stdBgnde"  name="stdBgnde" size="10"  value="${stdBgnde}" maxlength="10" readonly="readonly"/>
                                    <span style="color:#0066CC">부터</span>&nbsp;&nbsp;&nbsp;
                                    <input type="text" id="stdEndde"  name="stdEndde" size="10"  value="${stdEndde}" maxlength="10" readonly="readonly"/>
                                    <span style="color:#0066CC">까지</span>&nbsp;&nbsp;&nbsp;
                                    <!-- 갱신하기 버튼 추가 시작-->
                                    <input type="button" id="expenseMain" value="갱신페이지로 이동하기" /> (정보 갱신 작업페이지로 이동합니다.)                                    
                                    <!-- 갱신하기 버튼 추가 끝-->
                                    <!-- 엑셀다운로드 버튼 추가 시작 -->                                    
                                    <p style="display: inline; float: right;">
                                    <input type="hidden" id="excelYN" name="excelYN" value="N">
									<a id="btn_excel" href="#noloc">                                
										<img src="./resources/ls_img/btn_excel.gif"></a>
	                                </p>									
	                                <!-- 엑셀다운로드 버튼 추가 시작 -->
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
								            <!-- <th class="border-right" rowspan="2">직무</th>
								            <th class="border-right" rowspan="2">직책</th> -->
								            <th class="border-right" rowspan="2">평균팀원</th>								            
								            <th class="border-right" rowspan="2">간접비</th>
								            <th class="border-right" rowspan="2">수수료매출</th>
								            <th class="border-right" colspan="4">기준업무량</th>
								            <th class="border-right" colspan="3">기준업무량(예외처리)</th>
								         	<th class="border-right" colspan="3">일비</th>	      
								         	<th class="border-right" rowspan="2">센터품질<br/>관리비</th>
								         	<th class="border-right" rowspan="2">서면심사<br/>(물보험서면심사외)</th>
								         	<th class="border-right" rowspan="2">양식보험<br/>승선지원비</th>
								         	<th class="border-right" rowspan="2">가축재해<br/>이재조사비</th>
								         	<th class="border-right" rowspan="2">교통비</th>
								         	<th class="border-right" colspan="4">수동입력항목 (클릭시입력가능)</th>      
								        </tr>
								        <tr>
								        	<th class="border-right">년 목표</th>
								        	<th class="border-right">월 목표</th>
								        	<th class="border-right">월 달성량</th>
								        	<th class="border-right">월 달성율</th>
								        	<th class="border-right">서면심사(WC)</th>
								        	<th class="border-right">서면심사<br/>(맥도날드)</th>
								        	<th class="border-right">서면심사<br/>(스마트스코어)</th>								        	
								        	<th class="border-right">당월종결</th>
								        	<th class="border-right">공동실적</th>
								        	<th class="border-right">합계</th>
								        	<th class="border-right">농협보험<br/>이재조사비</th>
								        	<th class="border-right">양식보험<br/>이재조사비</th>
								        	<th class="border-right">품위유지비</th>
								        	<th class="border-right">차감액</th>								        	
								        </tr>
								        <c:choose>
								        	<c:when test="${expenseList.size() eq 0}">
								        		<tr>
										        		<td class="border-right" colspan="25">
										        			<a href="javascript:goExpenseMain();">
										        			${baseYear}년 ${baseMonth}월 이재조사비 정보가 없습니다. 작업페이지로 이동하여 데이터를 갱신해주세요. [클릭]
										        			</a>
										        		</td>
										        </tr>
								        	</c:when>
								        	<c:otherwise>
								        		<c:forEach var="items" items="${expenseList}" varStatus="status">
										        	<c:choose>
								                		<c:when test="${items.workType eq 14}"><tr bgcolor="orange"></c:when>
								                		<c:when test="${items.workType eq 3}"><tr bgcolor="yellow"></c:when>
								                		<c:otherwise><tr></c:otherwise>
								                	</c:choose>								        	
										        		<td class="border-right">${items.centerName}</td>
										                <td class="border-right">${items.teamName}</td>
										                <td class="border-right">${items.userName}</td>
										                <td class="border-right">${items.workLevelNm}</td>
										                <%-- <td class="border-right">${items.workJob}</td>
										                <td class="border-right">${items.workJobCd}</td> --%>
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
										                <td class="border-right">${items.suhypCost}</td>
										                <td class="border-right">${items.cowCost}</td>
										                <td class="border-right">${items.trafficCost}</td>
										                <td class="border-right" style="cursor:pointer;" onclick="javascript:directModify('${items.userNo}','${items.baseYear}','${items.baseMonth}','${items.userName}','${items.nonghypCost}','${items.dispatchCost}','${items.eleganceCost}','${items.deductionCost}');" >${items.nonghypCost}</td>
										                <td class="border-right" style="cursor:pointer;" onclick="javascript:directModify('${items.userNo}','${items.baseYear}','${items.baseMonth}','${items.userName}','${items.nonghypCost}','${items.dispatchCost}','${items.eleganceCost}','${items.deductionCost}');" >${items.dispatchCost}</td>
										                <td class="border-right" style="cursor:pointer;" onclick="javascript:directModify('${items.userNo}','${items.baseYear}','${items.baseMonth}','${items.userName}','${items.nonghypCost}','${items.dispatchCost}','${items.eleganceCost}','${items.deductionCost}');" >${items.eleganceCost}</td>
										                <td class="border-right" style="cursor:pointer;" onclick="javascript:directModify('${items.userNo}','${items.baseYear}','${items.baseMonth}','${items.userName}','${items.nonghypCost}','${items.dispatchCost}','${items.eleganceCost}','${items.deductionCost}');" >${items.deductionCost}</td>
													</tr>
										        </c:forEach>
								        	</c:otherwise>
								        </c:choose>								        								        								        
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
                    
                    <%-- 이재조사비 수동입력 모달 시작 --%>
                    <form id="expenseActionFrm" name="expenseActionFrm" method="post">
                    <input type="hidden" id="v_baseYear" />
                    <input type="hidden" id="v_baseMonth" />
                    <input type="hidden" id="v_userNo" />
                    <div id="expense-action_dialog" title="수동입력" style="font-size: 15px;display:none;" align="center">
						<br/>
						<div class="tableStyle2" style="width: 350px;">
							<table>					
								<tbody>					
									<tr>
										<th>대상자</th>
										<td style="text-align:left;padding-left: 10px;font-weight:bold;">
											<span id="v_userName"></span>
										</td>										
									</tr>
									<tr>
										<th>농협보험이재조사비</th>
										<td style="text-align:left;padding-left: 10px;font-weight:bold;">
											<input type="text" id="v_nonghypCost" style="text-align:right;"/> 원
										</td>
									</tr>
									<tr>
										<th>파견수당</th>
										<td style="text-align:left;padding-left: 10px;font-weight:bold;">
											<input type="text" id="v_dispatchCost" style="text-align:right;"/> 원
										</td>
									</tr>
									<tr>
										<th>품위유지비</th>
										<td style="text-align:left;padding-left: 10px;font-weight:bold;">
											<input type="text" id="v_eleganceCost" style="text-align:right;"/> 원
										</td>
									</tr>
									<tr>
										<th>차감액</th>
										<td style="text-align:left;padding-left: 10px;font-weight:bold;">
											<input type="text" id="v_deductionCost" style="text-align:right;"/> 원
										</td>
									</tr>
								</tbody>																																																							
							</table>
						</div>
					</div>
					</form>
					<%-- 이재조사비 수동입력 모달 끝 --%>
                    
                </div>
            </div>
        </div>        
    </div>
    
<script type='text/javascript'>
    $(document).ready(function () {
        _initButton();
		$("#srchUserNo").select2();
		
		//갱신하기 버튼 클릭시
		$("#expenseMain").click( function(){
			goExpenseMain();
		});		
		
    });
    
    //수동입력 수정    
    function fnExpenseAction(){
    	
    	var param = {};    	
    	param.v_userNo = $("#v_userNo").val();
    	param.v_baseYear = $("#v_baseYear").val();
    	param.v_baseMonth = $("#v_baseMonth").val();
    	param.v_nonghypCost = $("#v_nonghypCost").val();
    	param.v_dispatchCost = $("#v_dispatchCost").val();
    	param.v_eleganceCost = $("#v_eleganceCost").val();
    	param.v_deductionCost = $("#v_deductionCost").val();
    	
    	$.ajax({
    		type : "post",
			url : "expenseExtraAction",					
			data : param,
			dataType: "html",
    		success : function(result){
    			alert("수정하였습니다.");
    			fnSearch();
    		},
    		error: function (request, status, error) {			
    			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
    		}    			
    	});
    }
    
    //수동입력항목 추가
    function directModify(p_userNo, p_baseYear, p_baseMonth, p_userName, p_nonghypCost, p_dispatchCost, p_eleganceCost, p_deductionCost){
    	//alert('param='+p_userNo+" : "+p_baseYear+" : "+p_baseMonth+" : "+p_userName+" : "+p_nonghypCost+" : "+p_dispatchCost+" : "+p_eleganceCost+" : "+p_deductionCost);
    	//update 팝업시작
    	
    	//팝업창 값셋팅
    	$("#v_userNo").val(p_userNo);
    	$("#v_baseYear").val(p_baseYear);
    	$("#v_baseMonth").val(p_baseMonth);
    	$("#v_userName").text(p_userName);
    	$("#v_nonghypCost").val(p_nonghypCost);
    	$("#v_dispatchCost").val(p_dispatchCost);
    	$("#v_eleganceCost").val(p_eleganceCost);
    	$("#v_deductionCost").val(p_deductionCost);    	
    	
    	$("#expense-action_dialog").dialog({
				height: 300,
				width: 400,
				closeOnEscape : true,
				draggable : true,					
				title: "수동 입력",
				buttons:{
					"수정" : function(){
						var action = fnExpenseAction();
						if (action){
							$(this).dialog("close");
						}
					},
					"취소" : function(){
						$(this).dialog("close");
					}
				},
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});
    	
    	//update 팝업 끝
    	//fnSearch();
    }
    
    function goExpenseMain(){
    	$("#loading").show();
    	srchFrm.submit();
    }
    	
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
        var frm = document.getElementById("srchFrm");        
        frm.excelYN.value = "N";
        
        frm.action = "./expenseList";
        
    	//직원 선택 검색 추가 180918
    	if ( $("#srchUserNo").val() != 0){
            $("#srchTeamId").val( $("#srchUserNo").val() );
            frm.action = "./expenseList";
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
    
    function fnExcel(){        
        var frm = document.getElementById("srchFrm");
        frm.excelYN.value = "Y";
        frm.action = "./expenseList";
        frm.submit();
    }
    
</script>
</body>
</html>