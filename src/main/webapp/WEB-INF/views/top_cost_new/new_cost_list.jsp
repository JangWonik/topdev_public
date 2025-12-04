<%@ page	language="java"
			contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE HTML>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css">
	<!--<link rel="stylesheet" type="text/css" href="./resources/ne_css/style2.css">-->
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<link href="./resources/select2/select2.min.css" rel="stylesheet" />
	<script src="./resources/select2/select2.min.js"></script>	
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
	<script src="./resources/ne_js/calendar.js"></script><!-- calendar -->
	<script src="./resources/wm_js/common.js"></script>

	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.user_no}'.trim() == ''
					|| ('${mbrVo_Session.team_id_main}' != '7'
							&& '${mbrAuthVo_Session.mbr_pms_17}' == '0' && '${mbrAuthVo_Session.mbr_pms_18}' == '0')){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}
		});//ready

		$(document).ready(function(){

			$.ajaxSetup({cache:false});
			$("#team_id").select2();
			$("#search_no").select2();
			
			$("#yearprev").click(function(){
		        var imsiyeartxt = $("#yeartxt").text();
		        $("#yeartxt").text(--imsiyeartxt);
	        	$("#viewFromDate").val(--imsiyeartxt+"-12-16");
	        	$("#viewToDate").val($("#yeartxt").text()+"-12-15");
		    });
		    $("#yearnext").click(function(){
		        var imsiyeartxt = $("#yeartxt").text();
		        $("#yeartxt").text(++imsiyeartxt);
	        	$("#viewFromDate").val($("#yeartxt").text()+"-12-16");
	        	$("#viewToDate").val(++imsiyeartxt+"-12-15");
		    });
	
		    //월별 선택 버튼 클릭시 해당월에 해당하는 날짜 text 입력
		    $(".monthbtn").click(function(){
		    	var imsimonth = $(this).attr("id");
		    	var imsiMonthStart = imsimonth -1;
		    	if(imsimonth.length < 2) imsimonth = "0"+imsimonth;
		    	var imsiMonthStartStr = "0"+imsiMonthStart;
		    	if(imsiMonthStartStr.length > 2) imsiMonthStartStr = imsiMonthStartStr.substring(1, imsiMonthStartStr.length);
		        	$("#viewFromDate").val($("#yeartxt").text()+"-"+imsiMonthStartStr +"-"+ "16");
		        	$("#viewToDate").val($("#yeartxt").text()+"-"+imsimonth+"-"+ "15");
		        if(imsimonth == 1){
		        	$("#viewFromDate").val(($("#yeartxt").text()-1)+"-"+"12" +"-"+ "16");
		        }
		        newCostSearchForm.submit();
		    });//monthbtn.click
		    
			/* 처리팀 지정 */
		    $("#team_id").change(function(){
		    
			var team_id = $("#team_id option:selected").val();
			$.post("topMbrForSelectedTeam"
					,{ team_id : team_id }
					,function(data,status){
						if(status == "success"){
							$("#search_no").empty();
							
							if(data.length == 0){
								$("#search_no").append(
									"<option value='0'>"
										+"직원 없음"
									+"</option>"
								);
							}else{
								$("#search_no").append( "<option value = '0'>직원 미지정</option>");
								
			                    $.each(data, function(index, entry) {
		                    		$("#search_no").append(
	                    				"<option value = '"+entry.user_no+"' data-search-team = '"+entry.team_id+"'>"
											+entry.user_name
                                		+ "</option>"
		   							);
								});//each
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}
					,"json"
			);//post
			
		});//$("#topTeamId").change()
		
		$("#search_no").change(function(){
			if($("#team_id").val() == 0){
				var team_id = $("#search_no option:selected").data("search-team");
				$("#team_id").val(team_id).select2();
			}
		});
		
	
		});//$(document).ready

		function goNewCostTmList(id, nm, type){
			newCostSearchForm.action = "./getNewCostTmList";
			newCostSearchForm.team_id.value = id;
			newCostSearchForm.team_name.value = encodeURI(nm);
			newCostSearchForm.team_type.value = type;
// 			newCostSearchForm.method = "POST";
			newCostSearchForm.submit();
		}
		
		function fnSearchUserBtn(){
			var frm = document.getElementById("newCostSearchForm");
	        frm.action = "./getNewCostTmList";
	        frm.submit();
		}		

			
	</script>
</head>

<body>

<!-- wrapper -->
<div id="wrapper">

	<!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">
			<div class="center_cnt_1300">

				<div class="centercnt_top">
					<div class="nociteA log_top">
						<div class="search_bar">

							<div style="float: left;">
								<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">
								&nbsp;<b>팀별 경비 내역</b>
							</div>

							<div style="text-align: right;">
								<img id="yearprev" src="./resources/ne_img/icon_prev.gif" width="17" height="13" border="0">
								<a id="yeartxt" href="#">${inVO.viewToDate.substring(0,4)}</a>
								<img id="yearnext" src="./resources/ne_img/icon_next.gif" width="17" height="13" border="0">
								<c:forEach var="i" begin="1" end="12" step="1" varStatus="">
									<input id="${i}" class="monthbtn" type="button" value="${i}월" />
								</c:forEach>
							</div>

							<form name="newCostSearchForm" id="newCostSearchForm" method="GET" action="./newCostList">
								<b>${inVO.viewFromDate}</b>
								<b><font color="#0066CC">부터</font></b>&nbsp;&nbsp;
								<b>${inVO.viewToDate}</b>
								<b><font color="#0066CC">까지</font></b>&nbsp;&nbsp;
								<input	type="hidden" id="viewFromDate" name="viewFromDate" value="${inVO.viewFromDate}"
										size="10" maxlength="10" readonly style="background-color:lightgrey;" />
								<input	type="hidden" id="viewToDate"  name="viewToDate" value="${inVO.viewToDate}"
										size="10" maxlength="10" readonly style="background-color:lightgrey;" />

								<select class="team_id" name=team_id id="team_id" style="width:180px;" >
									<option value="0" selected>전체</option>
									<c:forEach items="${topTeamList}" var = "topTeamVo">
										<option value="${topTeamVo.team_id}">
										<c:if test="${topTeamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
										<c:if test="${topTeamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
										${topTeamVo.team_name}
										</option>
									</c:forEach>
								</select>								
								<select name="search_no" id="search_no" style="width:180px;">
									<option value="0">직원 미지정</option>
									<c:forEach items="${topMbrList}" var="item">
										<option value="${item.user_no}" data-search-team="${item.team_id}">${item.user_name}</option>
									</c:forEach>
								</select>								
								<input type="image" onclick="fnSearchUserBtn();" src="./resources/wm_img/common/bg_btnbg01.gif" style="width:56px;height:26px;border:0px;" class="btn">		
								<input type="hidden" id="team_name" name="team_name" />
								<input type="hidden" id="team_type" name="team_type" />
<!-- 								<input type="text" id="search_name" name="search_name"> -->
							</form>
							<br/>
						</div>
					</div>
				</div><!-- //centercnt_top -->

				<div class="center_cnt_1300_bot" >
					<div class="guest">

						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">팀별 경비 내역</a></li>
							</ul>
						</div>
						<div class="guestcnt2" style="display:block;">

							<div class= "tableStyle2">
                                <div style="padding-right: 17px; background: #e7ecf1;">
                                    <table cellpadding="0" cellspacing="0" width="1060" align="center">
                                        <colgroup>
                                            <col width="5%">
                                            <col width="8%">
                                            <col width="4%">
                                            <col width="7%">
                                            <col width="7%">
                                            <col width="7%">
                                            <col width="7%">
                                            <col width="7%">
                                            <col width="7%">
                                            <col width="7%">
                                            <col width="7%">
                                            <col width="7%">
                                            <col width="7%">
                                            <col width="7%">
                                        </colgroup>
                                        <tr>
                                            <th>Type</th>
                                            <th>지점</th>
                                            <th>인원</th>
                                            <th>청구금액<br />(일반)</th>
                                            <th>청구금액<br />(추가)</th>
                                            <th>청구금액<br />(클레임)</th>
                                            <th>청구금액<br />(전체)</th>
                                            <th>팀장</th>
                                            <th>본부장</th>
                                            <th>자금팀 승인</th>
                                            <th>협조(의뢰)</th>
                                            <th>협조(수임)</th>
                                            <th>입금액</th>
                                            <th>비고</th>
                                        </tr>
                                    </table>
                                </div>
                                <div class="statisticsTable" style="height:570px; overflow-x: hidden; overflow-y: auto;">
                                    <table cellpadding="0" cellspacing="0" width="1060" align="center">
                                        <colgroup>
                                            <col width="5%">
                                            <col width="8%">
                                            <col width="4%">
                                            <col width="7%">
                                            <col width="7%">
                                            <col width="7%">
                                            <col width="7%">
                                            <col width="7%">
                                            <col width="7%">
                                            <col width="7%">
                                            <col width="7%">
                                            <col width="7%">
                                            <col width="7%">
                                            <col width="7%">
                                        </colgroup>
                                        <c:forEach items="${getCostList0}" var="vo" varStatus="status">
                                            <tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
							                    <c:if test="${status.index == 0}">
							                        <td rowspan="${getCostList0.size()}">총괄</td>
							                    </c:if>
                                                <td><c:out value="${vo.team_name}"/></td>
                                                <td><c:out value="${vo.userCnt}"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.cost_base_pay_amt}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.cost_addition_pay_amt}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.cost_claim_pay_amt}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.cost_base_pay_amt + vo.cost_addition_pay_amt + vo.cost_claim_pay_amt}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.cost_base_deposit_amt + vo.cost_claim_deposit_amt + vo.cost_addition_deposit_amt}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.amt_hq_aprv}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.amt_finance_aprv}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.help_client_price_total}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.help_accept_price_total}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.amt_deposit}" pattern="###,###,##0.##"/></td>
                                                <td>
                                                    <a href="javascript:goNewCostTmList('${vo.team_id}','${vo.team_name}','${vo.team_type}');">
                                                        <img src="./resources/ls_img/top_cost/btn_view.gif"/>
                                                    </a>
                                                </td>
                                            </tr>
                                            <c:set var="sum_cost_pay_amt0" value="${sum_cost_pay_amt0 +vo.cost_base_pay_amt + vo.cost_addition_pay_amt + vo.cost_claim_pay_amt}" />
                                            <c:set var="sum_cost_base_pay_amt0" value="${sum_cost_base_pay_amt0 + vo.cost_base_pay_amt}" />
                                            <c:set var="sum_cost_addtiion_pay_amt0" value="${sum_cost_addtiion_pay_amt0 + vo.cost_addition_pay_amt}" />
                                            <c:set var="sum_cost_claim_pay_amt0" value="${sum_cost_claim_pay_amt0 + vo.cost_claim_pay_amt}" />
                                            <c:set var="sum_cost_deposit_amt0" value="${sum_cost_deposit_amt0 + vo.cost_base_deposit_amt + vo.cost_claim_deposit_amt + vo.cost_addition_deposit_amt}" />
                                            <c:set var="sum_amt_hq_aprv0" value="${sum_amt_hq_aprv0 + vo.amt_hq_aprv}" />
                                            <c:set var="sum_amt_finance_aprv0" value="${sum_amt_finance_aprv0 + vo.amt_finance_aprv}" />
                                            <c:set var="sum_help_client_price_total0" value="${sum_help_client_price_total0 + vo.help_client_price_total}" />
                                            <c:set var="sum_help_accept_price_total0" value="${sum_help_accept_price_total0 + vo.help_accept_price_total}" />
                                            <c:set var="sum_amt_deposit0" value="${sum_amt_deposit0 + vo.amt_deposit}" />
                                        </c:forEach>
                                        <tr bgcolor="#E7ECF1">
                                            <td colspan="3">총괄 소계</td>
                                            <td><fmt:formatNumber value="${sum_cost_base_pay_amt0}" pattern="###,###,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_cost_addtiion_pay_amt0}" pattern="###,###,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_cost_claim_pay_amt0}" pattern="###,###,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_cost_pay_amt0}" pattern="###,###,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_cost_deposit_amt0}" pattern="###,###,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_amt_hq_aprv0}" pattern="###,###,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_amt_finance_aprv0}" pattern="###,###,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_help_client_price_total0}" pattern="###,###,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_help_accept_price_total0}" pattern="###,###,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_amt_deposit0}" pattern="###,###,##0.##"/></td>
                                            <td></td>
                                        </tr>
                                        
                                        <c:forEach items="${getCostList1}" var="vo" varStatus="status">
                                            <tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
							                    <c:if test="${status.index == 0}">
							                        <td rowspan="${getCostList1.size()}">1종</td>
							                    </c:if>
                                                <td><c:out value="${vo.team_name}"/></td>
                                                <td><c:out value="${vo.userCnt}"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.cost_base_pay_amt}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.cost_addition_pay_amt}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.cost_claim_pay_amt}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.cost_base_pay_amt + vo.cost_addition_pay_amt + vo.cost_claim_pay_amt}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.cost_base_deposit_amt + vo.cost_claim_deposit_amt + vo.cost_addition_deposit_amt}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.amt_hq_aprv}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.amt_finance_aprv}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.help_client_price_total}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.help_accept_price_total}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.amt_deposit}" pattern="###,###,##0.##"/></td>
                                                <td>
                                                    <a href="javascript:goNewCostTmList('${vo.team_id}','${vo.team_name}','${vo.team_type}');">
                                                        <img src="./resources/ls_img/top_cost/btn_view.gif"/>
                                                    </a>
                                                </td>
                                            </tr>
                                            <c:set var="sum_cost_pay_amt1" value="${sum_cost_pay_amt1 +vo.cost_base_pay_amt + vo.cost_addition_pay_amt + vo.cost_claim_pay_amt}" />
                                            <c:set var="sum_cost_base_pay_amt1" value="${sum_cost_base_pay_amt1 + vo.cost_base_pay_amt}" />
                                            <c:set var="sum_cost_addtiion_pay_amt1" value="${sum_cost_addtiion_pay_amt1 + vo.cost_addition_pay_amt}" />
                                            <c:set var="sum_cost_claim_pay_amt1" value="${sum_cost_claim_pay_amt1 + vo.cost_claim_pay_amt}" />
                                            <c:set var="sum_cost_deposit_amt1" value="${sum_cost_deposit_amt1 + vo.cost_base_deposit_amt + vo.cost_claim_deposit_amt + vo.cost_addition_deposit_amt}" />
                                            <c:set var="sum_amt_hq_aprv1" value="${sum_amt_hq_aprv1 + vo.amt_hq_aprv}" />
                                            <c:set var="sum_amt_finance_aprv1" value="${sum_amt_finance_aprv1 + vo.amt_finance_aprv}" />
                                            <c:set var="sum_help_client_price_total1" value="${sum_help_client_price_total1 + vo.help_client_price_total}" />
                                            <c:set var="sum_help_accept_price_total1" value="${sum_help_accept_price_total1 + vo.help_accept_price_total}" />
                                            <c:set var="sum_amt_deposit1" value="${sum_amt_deposit1 + vo.amt_deposit}" />
                                        </c:forEach>
                                        <tr bgcolor="#E7ECF1">
                                            <td colspan="3">1종 소계</td>
                                            <td><fmt:formatNumber value="${sum_cost_base_pay_amt1}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_cost_addtiion_pay_amt1}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_cost_claim_pay_amt1}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_cost_pay_amt1}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_cost_deposit_amt1}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_amt_hq_aprv1}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_amt_finance_aprv1}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_help_client_price_total1}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_help_accept_price_total1}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_amt_deposit1}" pattern="#,##0.##"/></td>
                                            <td></td>
                                        </tr>
                                        
                                        <c:forEach items="${getCostList4}" var="vo" varStatus="status">
                                            <tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
 							                    <c:if test="${status.index == 0}">
							                        <td rowspan="${getCostList4.size()}">4종</td>
							                    </c:if>
                                                <td><c:out value="${vo.team_name}"/></td>
                                                <td><c:out value="${vo.userCnt}"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.cost_base_pay_amt}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.cost_addition_pay_amt}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.cost_claim_pay_amt}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.cost_base_pay_amt + vo.cost_addition_pay_amt + vo.cost_claim_pay_amt}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.cost_base_deposit_amt + vo.cost_claim_deposit_amt + vo.cost_addition_deposit_amt}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.amt_hq_aprv}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.amt_finance_aprv}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.help_client_price_total}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.help_accept_price_total}" pattern="###,###,##0.##"/></td>
                                                <td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.amt_deposit}" pattern="###,###,##0.##"/></td>
                                                <td>
                                                    <a href="javascript:goNewCostTmList('${vo.team_id}','${vo.team_name}','${vo.team_type}');">
                                                        <img src="./resources/ls_img/top_cost/btn_view.gif"/>
                                                    </a>
                                                </td>
                                            </tr>
                                            <c:set var="sum_cost_pay_amt4" value="${sum_cost_pay_amt4 +vo.cost_base_pay_amt + vo.cost_addition_pay_amt + vo.cost_claim_pay_amt}" />
                                            <c:set var="sum_cost_base_pay_amt4" value="${sum_cost_base_pay_amt4 + vo.cost_base_pay_amt}" />
                                            <c:set var="sum_cost_addtiion_pay_amt4" value="${sum_cost_addtiion_pay_amt4 + vo.cost_addition_pay_amt}" />
                                            <c:set var="sum_cost_claim_pay_amt4" value="${sum_cost_claim_pay_amt4 + vo.cost_claim_pay_amt}" />
                                            <c:set var="sum_cost_deposit_amt4" value="${sum_cost_deposit_amt4 + vo.cost_base_deposit_amt + vo.cost_claim_deposit_amt + vo.cost_addition_deposit_amt}" />
                                            <c:set var="sum_amt_hq_aprv4" value="${sum_amt_hq_aprv4 + vo.amt_hq_aprv}" />
                                            <c:set var="sum_amt_finance_aprv4" value="${sum_amt_finance_aprv4 + vo.amt_finance_aprv}" />
                                            <c:set var="sum_help_client_price_total4" value="${sum_help_client_price_total4 + vo.help_client_price_total}" />
                                            <c:set var="sum_help_accept_price_total4" value="${sum_help_accept_price_total4 + vo.help_accept_price_total}" />
                                            <c:set var="sum_amt_deposit4" value="${sum_amt_deposit4 + vo.amt_deposit}" />
                                        </c:forEach>
                                        <tr bgcolor="#E7ECF1">
                                            <td colspan="3">4종 소계</td>
                                            <td><fmt:formatNumber value="${sum_cost_base_pay_amt4}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_cost_addtiion_pay_amt4}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_cost_claim_pay_amt4}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_cost_pay_amt4}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_cost_deposit_amt4}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_amt_hq_aprv4}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_amt_finance_aprv4}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_help_client_price_total4}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_help_accept_price_total4}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_amt_deposit4}" pattern="#,##0.##"/></td>
                                            <td></td>
                                        </tr>                                        
                                        
                                        <tr bgcolor="#E7ECF1">
                                            <td colspan="3">합계</td>
                                            <td><fmt:formatNumber value="${sum_cost_base_pay_amt0 + sum_cost_base_pay_amt1 + sum_cost_base_pay_amt4}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_cost_addtiion_pay_amt0 + sum_cost_addtiion_pay_amt1 + sum_cost_addtiion_pay_amt4}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_cost_claim_pay_amt0 + sum_cost_claim_pay_amt1 + sum_cost_claim_pay_amt4}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_cost_pay_amt0 + sum_cost_pay_amt1 + sum_cost_pay_amt4}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_cost_deposit_amt0 + sum_cost_deposit_amt1 + sum_cost_deposit_amt4}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_amt_hq_aprv0 + sum_amt_hq_aprv1 + sum_amt_hq_aprv4}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_amt_finance_aprv0 + sum_amt_finance_aprv1 + sum_amt_finance_aprv4}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_help_client_price_total0 + sum_help_client_price_total1 + sum_help_client_price_total4}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_help_accept_price_total0 + sum_help_accept_price_total1 + sum_help_accept_price_total4}" pattern="#,##0.##"/></td>
                                            <td><fmt:formatNumber value="${sum_amt_deposit0 + sum_amt_deposit1 + sum_amt_deposit4}" pattern="#,##0.##"/></td>
                                            <td></td>
                                        </tr>
                                    </table>
                                </div>
							</div><!-- //tableStyle2 -->

						</div><!-- //guestcnt -->

					</div><!-- //guest -->
				</div><!-- centercnt_bot2 -->

			</div><!-- //center_cnt -->
		</div><!-- //contents -->
	</div><!-- //container -->

	<!-- footer -->
	<c:import url="../top_statistics/statistics_footer.jsp"></c:import>
	<!-- //footer -->

</div>
<!-- //wrapper -->

</body>

</html>
