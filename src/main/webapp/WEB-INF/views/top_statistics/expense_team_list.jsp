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
        .ui-button-text {
        	font-size : 12px;
        }
        
        .btn-vacation-aprv {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:5px;
			-webkit-border-radius:5px;
			border-radius:5px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:12px;
			color:#696969  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
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
                                    <span style="color:red;"><b>${baseYear}년 ${baseMonth}월</b></span> 이재조사비 정보 <span style="color:blue;"><b>팀 조회 페이지</b></span>
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
                                <form id="srchFrm" name="srchFrm" method="post" action="expenseTeamList">                                	
                                    <input type="text" id="stdBgnde"  name="stdBgnde" size="10"  value="${stdBgnde}" maxlength="10" readonly="readonly"/>
                                    <span style="color:#0066CC">부터</span>&nbsp;&nbsp;&nbsp;
                                    <input type="text" id="stdEndde"  name="stdEndde" size="10"  value="${stdEndde}" maxlength="10" readonly="readonly"/>
                                    <span style="color:#0066CC">까지</span>&nbsp;&nbsp;&nbsp;
                                    
                                    <select id="tmSearchMain" name="tmSearchMain" style="width:180px;text-align:left;">
										<option value="9999" <c:if test="${empty s_team_id}">selected</c:if> > - 전체 - </option>										
										<c:forEach items="${teamList}" var = "teamVo">
											<option value="${teamVo.teamId}"
												<c:if test="${s_team_id eq teamVo.teamId}">selected</c:if>>
												<c:if test="${teamVo.teamLevel == 1}">&nbsp;└</c:if>
												<c:if test="${teamVo.teamLevel == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
												${teamVo.teamName}
											</option>
										</c:forEach>
									</select>
									<input type="hidden" id="s_team_id" name="s_team_id"/>									
                                    <a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick='javascript:fnSearch();'>검색</a>
                                    <p style="display: inline; float: right;">
                                    <input type="hidden" id="excelYN" name="excelYN" value="N">
									<a id="btn_excel" href="#noloc">                                
										<img src="./resources/ls_img/btn_excel.gif"></a>
	                                </p>                                    
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
								        	<th class="border-right" width="5%">센터명</th>
								        	<th class="border-right" width="5%">팀명</th>
								        	<th class="border-right" width="5%">센터&middot;팀 장명</th>
								        	<th class="border-right" width="5%">평균인원수</th>
								        	<c:forEach var="days" items="${dates}" varStatus="status">								        		
								        		<th class="border-right" width="2%">${fn:substring(days,5,10)}</th>
								        	</c:forEach>								        									            	            
								        </tr>								        
								        <c:choose>
								        	<c:when test="${expenseTeamList.size() eq 0}">
								        		<tr>
										        		<td class="border-right" colspan="${dates.size()+4}">
										        			해당날짜의 적재된 팀 누적정보가 없습니다.
										        		</td>
										        </tr>
								        	</c:when>
								        	<c:otherwise>
								        		<c:forEach var="items" items="${expenseTeamList}" varStatus="status">
								        			<c:choose>
								        				<c:when test="${items.teamLevel eq 0}">
								        					<tr bgcolor="yellow">
												        		<td class="border-right">${items.centerName}</td>
												                <td class="border-right">${items.teamName}</td>
												                <td class="border-right">${items.teamManagerName}</td>
												                <td class="border-right"><fmt:formatNumber value="${items.totalCnt / items.divisionCnt}" pattern="0.0"/></td>
												                <c:forEach var="daysTerm" begin="0" end="${items.daysCnt-1}" varStatus="s">
												                	<c:set var="tempName">cnt${daysTerm}</c:set>
												                	<c:set var="tempDate">date${daysTerm}</c:set>												                	
												                	<td class="border-right">
												                		<a href="#" onclick="doModify('${items.teamId}','${items.teamName}','${items[tempDate]}','${items[tempName]}');return false;">
												                	${items[tempName]}
												                		</a>
												                	</td>												                		
												                </c:forEach>
															</tr>
								        				</c:when>
								        				<c:otherwise>
								        					<tr>
												        		<td class="border-right">${items.centerName}</td>
												                <td class="border-right">${items.teamName}</td>
												                <td class="border-right">${items.teamManagerName}</td>
												                <td class="border-right"><fmt:formatNumber value="${items.totalCnt / items.divisionCnt}" pattern="0.0"/></td>
												                <c:forEach var="daysTerm" begin="0" end="${items.daysCnt-1}" varStatus="s">
												                	<c:set var="tempName">cnt${daysTerm}</c:set>
												                	<c:set var="tempDate">date${daysTerm}</c:set>												                	
												                	<td class="border-right">
												                		<a href="#" onclick="doModify('${items.teamId}','${items.teamName}','${items[tempDate]}','${items[tempName]}');return false;">
												                	${items[tempName]}
												                		</a>
												                	</td>												                		
												                </c:forEach>
															</tr>
								        				</c:otherwise>
								        			</c:choose>										        	
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
                                        
                </div>
            </div>
        </div>        
    </div>
	<%-- 카운트 수정 팝업 --%>
	<form id="modifyForm" name="modifyForm">
	<input type="hidden" id="team_id_val" name="team_id_val" />
	<input type="hidden" id="base_date_val" name="base_date_val" />
	<div id="count-modify-dialog" title="팀인원 변경" style="font-size: 15px;display:none;" align="center">
		<div class="tableStyle2" style="width:300px;height:100px;border-top: 0px;">
			<table class="vacation-ins-table">																	
				<tr>
					<th>수정팀</th>
					<th>기준날짜</th>
					<th>변경 인원수</th>						
				</tr>
				<tr>
					<td><span id="modTeam"></span></td>
					<td><span id="modDate"></span></td>
					<td><input type="text" id="member_cnt_val" name="member_cnt_val" size="10"/></td>							
				</tr>																																																											
			</table>
		</div>
	</div>
	</form>
	<%-- 카운트 수정 팝업 --%> 
	<script type='text/javascript'>
    $(document).ready(function () {
        _initButton();
		$("#srchUserNo").select2();
		
		$("#tmSearchMain").select2();
		
		//갱신하기 버튼 클릭시
		$("#expenseMain").click( function(){
			goExpenseMain();
		});	
		
    });
    
    function doModify(teamId,teamName,baseDate,memberCnt){
    	//alert('수정='+teamId+" : "+teamName+" : "+baseDate+" : "+memberCnt);
    	//dialog 셋팅
    	$("#modTeam").text(teamName);
    	$("#modDate").text(baseDate);
    	$("#member_cnt_val").val(memberCnt);
    	//form 셋팅
    	$("#team_id_val").val(teamId);
    	$("#base_date_val").val(baseDate);
    	
    	//수정 다이어 로그 출력
    	$("#count-modify-dialog").dialog({
			height: 200,
			width: 400,
			closeOnEscape : true,
			draggable : true,
			title: "팀 인원 변경",
			appendTo : "#modifyForm",
			modal: true,
			buttons:{						
				"수정" : function(){
						fnModifyAction();					
						$(this).dialog("close");					
				},
				"취소" : function(){
					$(this).dialog("close");
				}
			},
			overlay:{ opacity: 0., background: '#000000'}
		});
    }
    
    //스케줄러 값 수동 갱신
    function fnModifyAction(){
    	
    	var url = "/expenseTeamListAction";
    	
    	var param = new FormData();
    	param.append("team_id", $("#team_id_val").val());
    	param.append("base_date", $("#base_date_val").val());
    	param.append("member_cnt",$("#member_cnt_val").val());
    	
    	$.ajax({
	        type: "POST",
	        url: url,
	        data: param,
	        timeout: 20000,
	        processData: false,
	        contentType: false,
	        dataType: "JSON", 
	        success: function(data){	        	
	        	if( data.result == 'Success' ){
	        		alert('수정되었습니다.');
	        	}else if( data.result == 'Empty Value' ){
	        		alert('필수입력값이 없습니다.');
	        	}else if( data.result == 'Empty Schedule' ){
	        		alert('해당일에 스케줄 정보가 없습니다.');
	        	}
	        	//페이지 리로딩
	        	fnSearch();
	        },
	        //error: function(e){
	            //alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요."+e);
	        //}
	        error:function(request,status,error){	            
	            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요. ("+request.responseText+")");
			}
	    });    	
    	
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
        
		var teamSeachVal = $("#tmSearchMain").val();
        
        $("#s_team_id").val(teamSeachVal);
        
        frm.excelYN.value = "N";        
        frm.action = "./expenseTeamList";
        
    	//직원 선택 검색 추가 180918
    	if ( $("#srchUserNo").val() != 0){
            $("#srchTeamId").val( $("#srchUserNo").val() );
            frm.action = "./expenseTeamList";
    	}    	
    	
        frm.submit();
    }
    
    function fnYear(){
    	
    	var frm = document.getElementById("srchFrm");
    	
    	var imsiyeartxt = $("#year_txt").text();
    	frm.excelYN.value = "N";
        $("#stdBgnde").val(--imsiyeartxt+"-12-16");
        $("#stdEndde").val($("#year_txt").text()+"-12-15");

        fnSearch();
    }

    function fnYearPrev(){
    	
    	var frm = document.getElementById("srchFrm");
    	
        var imsiyeartxt = $("#year_txt").text();
        
        frm.excelYN.value = "N";
        
        $("#stdBgnde").val(--imsiyeartxt+"-11-16");        
        $("#year_txt").text(imsiyeartxt);
        $("#stdEndde").val($("#year_txt").text()+"-12-15");
        
        fnSearch();

    }

    function fnYearNext(){
    	
    	var frm = document.getElementById("srchFrm");
    	
    	var imsiyeartxt = $("#year_txt").text();
    	
    	frm.excelYN.value = "N";
    	
    	$("#stdBgnde").val(imsiyeartxt + "-12-16");
    	$("#year_txt").text(++imsiyeartxt);
    	$("#stdEndde").val($("#year_txt").text()+"-01-15");    	

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
        frm.action = "./expenseTeamList";
        frm.submit();
    }
    
    
</script>
</body>
</html>