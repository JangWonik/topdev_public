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
			
			_initSrchParam();
			
		});//$(document).ready
		
		function _initSrchParam(){

			$("#team_id").select2();
			$("#search_no").select2();
			
			var team_id = $("#srch_team_id").val();
			var user_no = $("#srch_user_no").val();
			
			$("#team_id").val(team_id).select2();
 			$("#team_id").change();
 			
			setTimeout(function() {
				$("#search_no").val(user_no).select2();
// 				$("#search_no").change();			
			}, 200);
			
		}

		function goCostAprvChg(aprvCode, stateNo, aprvNo, user_no, cost_deposit_no,idx){
				$.post("./udtNewCostAprv",
					{	aprvCode  				:aprvCode
						,stateNo   				:stateNo
						,aprvNo   				:aprvNo
						,user_no   				:user_no
						,cost_deposit_no		:cost_deposit_no
						,viewFromDate		:$("#viewFromDate").val()
						,viewToDate			:$("#viewToDate").val()
						,amt_hq_aprv			:$("#aprvCost" + idx).val()
					},
					function(data,status){
						if(status == "success"){
// 							alert(data);
							window.location.reload();
							/*
							if(data == 0){
								alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								window.location.reload();
							}//else
								*/
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}//else
					}//function
				);//post
		}//function goCostAprvChg

		function goCostDepositPop(cost_deposit_no, user_no, user_name){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('getNewCostDepositPop?cost_deposit_no='+cost_deposit_no+'&user_no='+user_no+'&user_name='+encodeURI(user_name)
					+'&team_id='+$("#team_id").val()+'&team_name='+$("#team_name").val()
					+'&viewFromDate='+$("#viewFromDate").val()+'&viewToDate='+$("#viewToDate").val(),'depositPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}

		function goNewCostList(){
			newCostSearchForm.action = "./newCostList";
			newCostSearchForm.submit();
		}

		function goNewCostMbrList(id){
			newCostSearchForm.user_no.value = id;
			newCostSearchForm.action = "./getNewCostMbrList";
			
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
								&nbsp;<b>${getTeamInfo.team_name} 팀별 경비 내역</b>
							</div>

							<div style="text-align: right;">
								<img id="yearprev" src="./resources/ne_img/icon_prev.gif" width="17" height="13" border="0">
								<a id="yeartxt" href="#">${inVO.viewToDate.substring(0,4)}</a>
								<img id="yearnext" src="./resources/ne_img/icon_next.gif" width="17" height="13" border="0">
								<c:forEach var="i" begin="1" end="12" step="1" varStatus="">
									<input id="${i}" class="monthbtn" type="button" value="${i}월" />
								</c:forEach>
								<input type="button" value="목록으로"
										onclick="javascript:goNewCostList();" />
							</div>

							<form name="newCostSearchForm" id="newCostSearchForm" method="GET" action="./getNewCostTmList">
								<b>${inVO.viewFromDate}</b>
								<b><font color="#0066CC">부터</font></b>&nbsp;&nbsp;
								<b>${inVO.viewToDate}</b>
								<b><font color="#0066CC">까지</font></b>&nbsp;&nbsp;
								<input	type="hidden" id="viewFromDate" name="viewFromDate" value="${inVO.viewFromDate}"
										size="10" maxlength="10" readonly style="background-color:lightgrey;" />
								<input	type="hidden" id="viewToDate"  name="viewToDate" value="${inVO.viewToDate}"
										size="10" maxlength="10" readonly style="background-color:lightgrey;" />
										
								<select class="team_id" name="team_id" id="team_id" style="width:180px;" >
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
								<input type="hidden" id="srch_user_no" name="srch_user_no" value="<%=request.getParameter("search_no") %>"/>
								<input type="hidden" id="srch_team_id" name="srch_team_id"  value="<%=request.getParameter("team_id") %>"/>
								<input type="hidden" id="user_no" name="user_no">
								<input type="hidden" id="team_type" name="team_type" value="${inVO.team_type}" />
							</form>

							<br/>

						</div>
					</div>
				</div><!-- //centercnt_top -->

				<div class="center_cnt_1300_bot">
					<div class="guest">

						<div class="guestTap">
							<ul>
								<li class="on">
									<a href="#">
										<c:if test="${getTeamInfo.team_name != null}">								
											${getTeamInfo.team_name}
										</c:if>
										<c:if test="${getTeamInfo.team_name == null}">								
											전체 경비내역
										</c:if>
									</a>
								</li>								
							</ul>
						</div>
						<div class="guestcnt4" style="display:block;">

							<div class= "tableStyle2">
								<table>
									<tr>
										<th>담당자</th>
										<th>청구금액<br />(일반)</th>
										<th>청구금액<br />(추가)</th>
										<th>청구금액<br />(클레임)</th>
										<th>청구금액<br />(전체)</th>
										<th>팀장</th>
										<th>본부장</th>
										<th>자금팀 승인</th>
										<th>협조<br />(의뢰)</th>
										<th>협조<br />(수임)</th>
										<th>협조세금<br />(교통비)</th>
										<th>협조세금<br />(챠트비)</th>
										<th>입금액</th>
										<th>입금일</th>
										<th>비고</th>
									</tr>
									<c:forEach items="${getNewCostTmList}" var="vo" varStatus="status">
									<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
										<td>${vo.user_name}</td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.cost_base_pay_amt}" pattern="###,###,##0.##"/></td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.cost_addition_pay_amt}" pattern="###,###,##0.##"/></td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.cost_claim_pay_amt}" pattern="###,###,##0.##"/></td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.cost_base_pay_amt + vo.cost_addition_pay_amt + vo.cost_claim_pay_amt}" pattern="###,###,##0.##"/></td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.cost_base_deposit_amt + vo.cost_claim_deposit_amt + vo.cost_addition_deposit_amt}" pattern="###,###,##0.##"/></td>
										<td style="letter-spacing:0px;">
											<fmt:formatNumber value="${vo.amt_hq_aprv}" pattern="###,###,##0.##"/>
											<input type="hidden" id="aprvCost${status.index}" value="${vo.cost_base_deposit_amt + vo.cost_claim_deposit_amt + vo.cost_addition_deposit_amt}" />
											<c:if test="${mbrAuthVo_Session.mbr_pms_18 eq '1' and vo.baseCnt eq '0' and (vo.claimCnt > '0' || vo.additionCnt > '0')}">																					
												<c:choose>
													<c:when test="${vo.cost_aprv_state == 1}">
														<br /><img src='./resources/ls_img/top_cost/btn_sngin.gif' style="cursor:pointer;"
															onclick="javascript:goCostAprvChg('hqAprv',1,2,${vo.user_no},${vo.cost_deposit_no},${status.index});" />
													</c:when>
													<c:when test="${vo.cost_aprv_state == 2}">
														<br /><img src='./resources/ls_img/top_cost/btn_cancel.gif' style="cursor:pointer;"
															onclick="javascript:goCostAprvChg('hqAprvX',2,1,${vo.user_no},${vo.cost_deposit_no});" />
													</c:when>
													<c:otherwise>
													</c:otherwise>
												</c:choose>
											</c:if>
										</td>
										<td style="letter-spacing:0px;">
											<fmt:formatNumber value="${vo.amt_finance_aprv}" pattern="###,###,##0.##"/>
											<c:if test="${mbrAuthVo_Session.mbr_pms_18 eq '1'}">
												<c:choose>
													<c:when test="${vo.cost_aprv_state == 2}">
														<br /><img src='./resources/ls_img/top_cost/btn_sngin.gif' style="cursor:pointer;"
																onclick="javascript:goCostAprvChg('fiAprv',2,3,${vo.user_no},${vo.cost_deposit_no});" />
													</c:when>
													<c:when test="${vo.cost_aprv_state == 3}">
														<br /><img src='./resources/ls_img/top_cost/btn_cancel.gif' style="cursor:pointer;"
																onclick="javascript:goCostAprvChg('fiAprvX',3,2,${vo.user_no},${vo.cost_deposit_no});" />
													</c:when>
													<c:otherwise>
													</c:otherwise>
												</c:choose>
											</c:if>
										</td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.help_client_traffic_fee+vo.help_client_chart_fee}" pattern="###,###,##0.##"/></td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.help_accept_traffic_fee+vo.help_accept_chart_fee}" pattern="###,###,##0.##"/></td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.help_accept_traffic_fee-vo.help_client_traffic_fee}" pattern="###,###,##0.##"/></td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.help_accept_chart_fee-vo.help_client_chart_fee}" pattern="###,###,##0.##"/></td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${vo.amt_deposit}" pattern="###,###,##0.##"/></td>
										<td style="letter-spacing:0px;">${vo.date_deposit_fmt}
											<c:if test="${mbrAuthVo_Session.mbr_pms_18 eq '1'}">
												<c:choose>
													<c:when test="${vo.cost_aprv_state == 3}">
														<br /><img src='./resources/ls_img/top_cost/btn_settle.gif' style="cursor:pointer;"
																 onclick="javascript:goCostDepositPop(${vo.cost_deposit_no},${vo.user_no},'${vo.user_name}');" />
													</c:when>
													<c:when test="${vo.cost_aprv_state == 4}">
														<br /><img src='./resources/ls_img/top_cost/btn_cancel.gif' style="cursor:pointer;"
																	onclick="javascript:goCostAprvChg('depositX',4,3,${vo.user_no},${vo.cost_deposit_no});" />
													</c:when>
													<c:otherwise>
													</c:otherwise>
												</c:choose>
											</c:if>
										</td>
										<td>
											<c:if test="${mbrAuthVo_Session.mbr_pms_17 eq '1'}">
												<a href="javascript:goNewCostMbrList('${vo.user_no}');">
													<img src="./resources/ls_img/top_cost/btn_view.gif"/>
												</a>
											</c:if>
										</td>
									</tr>
										<c:set var="sum_cost_base_pay_amt" value="${sum_cost_base_pay_amt + vo.cost_base_pay_amt}" />
										<c:set var="sum_cost_claim_pay_amt" value="${sum_cost_claim_pay_amt + vo.cost_claim_pay_amt}" />
										<c:set var="sum_cost_addition_pay_amt" value="${sum_cost_addition_pay_amt + vo.cost_addition_pay_amt}" />
										<c:set var="sum_cost_pay_amt" value="${sum_cost_pay_amt + vo.cost_pay_amt}" />
										<c:set var="sum_cost_deposit_amt" value="${sum_cost_deposit_amt + vo.cost_deposit_amt}" />
										<c:set var="sum_amt_hq_aprv" value="${sum_amt_hq_aprv + vo.amt_hq_aprv}" />
										<c:set var="sum_amt_finance_aprv" value="${sum_amt_finance_aprv + vo.amt_finance_aprv}" />
										<c:set var="sum_help_client_fee" value="${sum_help_client_fee + vo.help_client_traffic_fee+vo.help_client_chart_fee}" />
										<c:set var="sum_help_accept_fee" value="${sum_help_accept_fee + vo.help_accept_traffic_fee+vo.help_accept_chart_fee}" />
										<c:set var="sum_help_client_traffic" value="${sum_help_client_traffic + vo.help_accept_traffic_fee-vo.help_client_traffic_fee}" />
										<c:set var="sum_help_accept_chart" value="${sum_help_accept_chart + vo.help_accept_chart_fee-vo.help_client_chart_fee}" />
										<c:set var="sum_amt_deposit" value="${sum_amt_deposit + vo.amt_deposit}" />
									</c:forEach>
									<tr bgcolor="#E7ECF1">
										<td>합계</td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${sum_cost_base_pay_amt}" pattern="#,##0.##"/></td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${sum_cost_addition_pay_amt}" pattern="#,##0.##"/></td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${sum_cost_claim_pay_amt}" pattern="#,##0.##"/></td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${sum_cost_pay_amt}" pattern="#,##0.##"/></td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${sum_cost_deposit_amt}" pattern="#,##0.##"/></td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${sum_amt_hq_aprv}" pattern="#,##0.##"/></td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${sum_amt_finance_aprv}" pattern="#,##0.##"/></td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${sum_help_client_fee}" pattern="#,##0.##"/></td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${sum_help_accept_fee}" pattern="#,##0.##"/></td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${sum_help_client_traffic}" pattern="#,##0.##"/></td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${sum_help_accept_chart}" pattern="#,##0.##"/></td>
										<td style="letter-spacing:0px;"><fmt:formatNumber value="${sum_amt_deposit}" pattern="#,##0.##"/></td>
										<td></td>
										<td></td>
									</tr>
								</table>
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
