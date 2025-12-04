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
	<script src="./resources/jquery/jquery.mask.min.js"></script>	
	
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/><!-- calendar -->
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/><!-- calendar -->
	<script src="./resources/jquery/jquery-ui.min.js"></script><!-- calendar -->
	<script src="./resources/ne_js/calendar.js"></script><!-- calendar -->
	<script src="./resources/wm_js/common.js"></script>

	<style>
		.costTable table tr td{
			letter-spacing: 0px;
		}
		
		.buttonAllAprv{
			width:60px;
			height:18px;
		    background-color:#CED8F6;
		    color:#666;
		    text-align: center;
			border-radius:5px;
		    font-size: 11px;
		    cursor: pointer;
		    text-decoration:none;
		    border: solid 1px grey;		    
		}
	</style>

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

			/* 처리팀 지정 */
		    $("#srch_team_id").change(function(){
			    
				var team_id = $("#srch_team_id option:selected").val();
				
				var param ={};
				param.team_id = team_id;
				
				var url = "/selectStatisticsMbrList";
		    	
	       	    $.ajax({
	       	        type: "POST",
	       	        url: url,
	       	        data: param,
	       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	       	        timeout: 20000,
	       	        async: false,
	       	        dataType: "JSON", 
	       	        success: function(data){
						$("#srch_user_no").empty();
						
						if(data.length == 0){
							$("#srch_user_no").append(
								"<option value='0'>"
									+"직원 없음"
								+"</option>"
							);
						}else{
							$("#srch_user_no").append( "<option value = '0'>직원 미지정</option>");
							
		                    $.each(data, function(index, entry) {
	                    		$("#srch_user_no").append(
                    				"<option value = '"+entry.user_no+"' data-search-team = '"+entry.team_id+"'>"
										+entry.user_name
                            		+ "</option>"
	   							);
							});//each
						}
	       	        }
	       	    });  
				
			});
		
			$("#srch_user_no").change(function(){
				if($("#srch_user_no").val() != 0){
					var team_id = $("#srch_user_no option:selected").data("search-team");
					$("#srch_team_id").val(team_id).select2();
				}
			});
			
			
		});//$(document).ready
		
		function doAllAprv( p_costdeposit_no, p_user_no ){			
			
			var param = {};
			param.cost_year_month = $("#cost_year_month").val();
			param.aprv_state = '3';			
			param.cost_deposit_no =  p_costdeposit_no;
			param.user_no = p_user_no;
			
			var url = "aprv_cost_item_all";
	    	
       	    $.ajax({
       	    	type: "POST",
                url: url,
                data: param,
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                dataType: "json",
                timeout: 20000,
                success: function(data){       	        	
       	        	//console.log("data:"+data.result);
					alert('일괄 승인되었습니다.');
					fnSearch();
       	        },            		
        		error: function (request, status, error) {
        			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
        		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
        		}
       	    });       	 
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
								&nbsp;<b>${srchArg.sel_team_name} 경비 내역</b>
							</div>

							<div style="text-align: right;">
								<img onclick="fnYearPrev()" src="./resources/ne_img/icon_prev.gif" width="17" height="13" border="0">
								<a id="year_txt" href="#">${srchArg.endDe.substring(0,4)}</a>
								<img onclick="fnYearNext()" src="./resources/ne_img/icon_next.gif" width="17" height="13" border="0">
								<c:forEach var="i" begin="1" end="12" step="1" varStatus="">
									<input id="${i}" class="monthbtn" type="button" value="${i}월" />
								</c:forEach>
							</div>

							<form name="cost_mbr_list_form" id="cost_mbr_list_form" method="POST" action="/cost_mbr_list">
							
								<input type="hidden" id="cost_year_month" name="cost_year_month" value="${srchArg.yearMonth}"/>
								
								<input type="hidden" id="gubun" name="gubun" value="finance" />
 								<input type="hidden" id="team_id" name="team_id" value="${srchArg.team_id}"/>
								<input type="hidden" id="user_no" name="user_no" />
								
								<input type="hidden" id="hid_user_no" name="hid_user_no" value="${srchArg.srch_user_no}"/>
								<input type="hidden" id="hid_team_id" name="hid_team_id" value="${srchArg.srch_team_id}"/>								
																
								<input type="hidden" id="hid_bgnDe" name="hid_bgnDe" value="${srchArg.bgnDe}" />
								<input type="hidden" id="hid_endDe" name="hid_endDe" value="${srchArg.endDe}" />
 								
 								<input type="hidden" id="hid_stdBgnde" name="stdBgnde" value="${srchArg.stdBgnde}" />
 								<input type="hidden" id="hid_stdEndde" name="stdEndde" value="${srchArg.stdEndde}" />
 								
 								<input type="hidden" id="sel_team_name" name="sel_team_name" value="${srchArg.sel_team_name}"/>
								
								<b>${srchArg.stdBgnde}</b>
								<b><font color="#0066CC">부터</font></b>&nbsp;&nbsp;
								<b>${srchArg.stdEndde}</b>
								<b><font color="#0066CC">까지</font></b>&nbsp;&nbsp;
										
								<select class="srch_team_id" name="srch_team_id" id="srch_team_id" style="width:180px;" >
									<option value="0" selected>전체</option>
									<c:forEach items="${tmList}" var = "teamItem">
										<option value="${teamItem.team_id}">
										<c:if test="${teamItem.team_level eq 1}">&nbsp;&nbsp;└</c:if>
										<c:if test="${teamItem.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
										${teamItem.team_name}
										</option>
									</c:forEach>
								</select>						
								
								<select name="srch_user_no" id="srch_user_no" style="width:180px;">
									<option value="0">직원 미지정</option>
									<c:forEach items="${mbrList}" var="mbrItem">
										<option value="${mbrItem.user_no}" data-srch_team_id="${mbrItem.team_id}">${mbrItem.user_name}</option>
									</c:forEach>
								</select>								
								
								<img src="./resources/ne_img/btn/btn_srch.gif" style="cursor: pointer;" onclick="fnSearch();"/>
										
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
										${srchArg.sel_team_name}
									</a>
								</li>								
							</ul>
						</div>
						<div class="guestcnt4" style="display:block;">

							<div class= "tableStyle2 costTable">
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
								
									<c:set var="SumBasicAmt"  value="0"/>
									<c:set var="SumAddAmt"  value="0"/>
									<c:set var="SumClaimAmt"  value="0"/>
									<c:set var="SumTotalAmt"  value="0"/>
									<c:set var="SumTmAprvAmt"  value="0"/>
									<c:set var="SumHqAprvAmt"  value="0"/>
									<c:set var="SumFinanceAprvAmt"  value="0"/>
									<c:set var="SumHelpClient"  value="0"/>
									<c:set var="SumHelpAccept"  value="0"/>
									<c:set var="SumHelpTraffic"  value="0"/>
									<c:set var="SumHelpChart"  value="0"/>
									<c:set var="SumDepositAmt"  value="0"/>
									
									<c:choose>
										<c:when test="${costMbrList.size() eq 0}">
											<tr>
												<td colspan="15">선택한 팀의 팀원이 없습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${costMbrList}" var="item" varStatus="status">
												<tr>
													<td>${item.userName}</td>
													<td><span class="money">${item.basicAmt}</span></td>
													<td><span class="money">${item.addAmt}</span></td>
													<td><span class="money">${item.claimAmt}</span></td>
													<td><span class="money">${item.totalAmt}</span></td>
													<td>
														<span class="money">${item.tmAprvAmt}</span>
													</td>
													<td>
														<c:if test="${item.hqAprvAmt ne '0'}">
															<span class="money">${item.hqAprvAmt}</span><br/>
														</c:if>
														<c:if test="${mbrAuthVo_Session.mbr_pms_18 eq '1'}">							
															<c:choose>
																<c:when test="${item.costDepositState == 1}">
																	<img class="btn_cost_aprv" src='./resources/ls_img/top_cost/btn_sngin.gif' data-aprv_state="2" data-deposit_no="${item.costDepositNo}" data-user_no = "${item.userNo}" style="cursor:pointer;" />
																</c:when>
																<c:when test="${item.costDepositState == 2}">
																	<img class="btn_cost_aprv" src='./resources/ls_img/top_cost/btn_cancel.gif' data-aprv_state="1" data-deposit_no="${item.costDepositNo}" data-user_no = "${item.userNo}" style="cursor:pointer;" />
																</c:when>
															</c:choose>
														</c:if>
													</td>
													<td>
														<c:if test="${item.financeAprvAmt ne '0'}">
															<span class="money">${item.financeAprvAmt}</span><br/>
														</c:if>
														
														<c:if test="${mbrAuthVo_Session.mbr_pms_18 eq '1'}">							
															<c:choose>
																<c:when test="${item.costDepositState == 2}">
																	<img class="btn_cost_aprv" src='./resources/ls_img/top_cost/btn_sngin.gif' data-aprv_state="3" data-deposit_no="${item.costDepositNo}" data-user_no = "${item.userNo}" style="cursor:pointer;" />
																</c:when>
																<c:when test="${item.costDepositState == 3}">
																	<img class="btn_cost_aprv" src='./resources/ls_img/top_cost/btn_cancel.gif' data-aprv_state="2" data-deposit_no="${item.costDepositNo}" data-user_no = "${item.userNo}" style="cursor:pointer;" />
																</c:when>
															</c:choose>
														</c:if>												
														<!-- 1종이면서 pms18 권한이 잇는경우만 표시 -->
														<c:if test="${not empty item.costDepositNo && item.depositAmt eq '0' && (item.costDepositState ne 3 && item.costDepositState ne 4)}">													
															<c:if test="${mbrAuthVo_Session.mbr_pms_18 eq '1' && (mbrVo_Session.team_type eq '0' or mbrVo_Session.team_type eq '1') }">
																<input class="buttonAllAprv" type="button" onclick="javascript:doAllAprv('${item.costDepositNo}','${item.userNo}')" value="일괄승인">
															</c:if>	
														</c:if>												
													</td>
													<td><span class="money">${item.helpClientTrafficFee+item.helpClientChartFee}</span></td>
													<td><span class="money">${item.helpAcceptTrafficFee+item.helpAcceptChartFee}</span></td>
													<td><fmt:formatNumber value="${item.helpAcceptTrafficFee-item.helpClientTrafficFee}" pattern="###,###,##0"/></td>
													<td><fmt:formatNumber value="${item.helpAcceptChartFee-item.helpClientChartFee}" pattern="###,###,##0"/></td>
													<td>
														<c:if test="${item.depositAmt ne '0'}">
															<span class="money">${item.depositAmt}</span>
														</c:if>
													</td>
													<td>
														<c:if test="${item.depositDate ne '0'}">
															${item.depositDate}
														</c:if>
														
														<c:if test="${mbrAuthVo_Session.mbr_pms_18 eq '1'}">							
															<c:choose>
																<c:when test="${item.costDepositState == 3}">
																	<img class="btn_cost_settle" src='./resources/ls_img/top_cost/btn_settle.gif' data-user_no ="${item.userNo}" data-deposit_no="${item.costDepositNo}" data-user_no = "${item.userNo}" style="cursor:pointer;" />
																</c:when>
																<c:when test="${item.costDepositState == 4}">
																	<img class="btn_cost_settle_cancel" src='./resources/ls_img/top_cost/btn_cancel.gif' data-aprv_state="3" data-deposit_no="${item.costDepositNo}"  data-user_no = "${item.userNo}" style="cursor:pointer;" />
																</c:when>
															</c:choose>
														</c:if>												
													</td>
													<td>
														<c:if test="${mbrAuthVo_Session.mbr_pms_17 eq '1' or mbrAuthVo_Session.mbr_pms_18 eq '1'}">
															<img class="btn_mbr_detail" data-user_no="${item.userNo}" src="./resources/ls_img/top_cost/btn_view.gif" style="cursor: pointer;"/>
														</c:if>
													</td>																				
												</tr>
												
												<c:set var="SumBasicAmt"  value="${SumBasicAmt + item.basicAmt}"/>
												<c:set var="SumAddAmt"  value="${SumAddAmt + item.addAmt}"/>
												<c:set var="SumClaimAmt"  value="${SumClaimAmt + item.claimAmt}"/>
												<c:set var="SumTotalAmt"  value="${SumTotalAmt + item.totalAmt}"/>
												
												<c:set var="SumTmAprvAmt"  value="${SumTmAprvAmt + item.tmAprvAmt}"/>
												<c:set var="SumHqAprvAmt"  value="${SumHqAprvAmt + item.hqAprvAmt}"/>
												<c:set var="SumFinanceAprvAmt"  value="${SumFinanceAprvAmt + item.financeAprvAmt}"/>
												
												<c:set var="SumHelpClient"  value="${SumHelpClient +  item.helpClientTrafficFee+item.helpClientChartFee}"/>
												<c:set var="SumHelpAccept"  value="${SumHelpAccept +  item.helpAcceptTrafficFee+item.helpAcceptChartFee}"/>
												
												<c:set var="SumHelpTraffic"  value="${SumHelpTraffic +  item.helpAcceptTrafficFee-item.helpClientTrafficFee}"/>
												<c:set var="SumHelpChart"  value="${SumHelpChart +  item.helpAcceptChartFee-item.helpClientChartFee}"/>
												
												<c:set var="SumDepositAmt"  value="${SumDepositAmt+ item.depositAmt}"/>
												
											</c:forEach>
										</c:otherwise>
									</c:choose>			
															
									
									<tr style="background: #e7ecf1">		
										<td>합계</td>
										<td><span class="money">${SumBasicAmt}</span></td>
										<td><span class="money">${SumAddAmt}</span></td>
										<td><span class="money">${SumClaimAmt}</span></td>
										<td><span class="money">${SumTotalAmt}</span></td>
										
										<td><span class="money">${SumTmAprvAmt}</span></td>
										<td><span class="money">${SumHqAprvAmt}</span></td>
										<td><span class="money">${SumFinanceAprvAmt}</span></td>
										
										<td><span class="money">${SumHelpClient}</span></td>
										<td><span class="money">${SumHelpAccept}</span></td>
										<td><span class="money">${SumHelpTraffic}</span></td>
										<td><span class="money">${SumHelpChart}</span></td>
										
										<td><span class="money">${SumDepositAmt}</span></td>
										
										<td></td>
										<td></td>
										
										
										
									</tr>
								</table>
							</div><!-- //tableStyle2 -->
							
							<script>						
								$(document).ready(function(){
									_initMask();
									_initButton();
									_initSrchParam();
								});
								
						
								/* mask 처리 */
								function _initMask(){
								    var options = {
								        onKeyPress : function(cep, event, currentField, options){
								            var tid = event.currentTarget.id;
								            var tidx = tid.substr(tid.length - 1, 1);
								        },
								        reverse : true
								    };
						
								    $('input.calendar').mask('0000-00-00',options);
								    $('input.money').mask('#,###,###',options);
								    $('td.money').mask('#,##0',{reverse:true});
								    $('div.money').mask('#,##0',{reverse:true});
								    $('span.money').mask('#,##0',{reverse:true});
								}
								
						  	    //버튼 이벤트
						   	    function _initButton() {
						
						   	        $("#year_txt").on("click", function () {
						   	            fnYear();
						   	        });
						
						   	        $("#btn_year_prev").on("click", function () {
						   	            fnYearPrev();
						   	        });
						   	        $("#btn_year_next").on("click", function () {
						   	            fnYearNext();
						   	        });
						   	        
						   	     	$(".btn_mbr_detail").on("click",function() {
						   	     		var user_no = $(this).data("user_no");   	     
						   	     		fnMbrDetailSearch(user_no);
						   	     	});
						   	     	
						   	     	$(".btn_cost_aprv").on("click",function() {
						   	     		var cost_deposit_no = $(this).data("deposit_no");
						   	     		var aprv_state = $(this).data("aprv_state");
						   	     		var user_no= $(this).data("user_no");
						   	     		$("#user_no").val(user_no);
						   	     		
						   	     		var frm = document.getElementById("cost_mbr_list_form");
						   	     		
										var hiddenField = document.createElement("input");
							   	        hiddenField.setAttribute("type", "hidden");
							   	        hiddenField.setAttribute("name", "cost_deposit_no");
							   	        hiddenField.setAttribute("value", cost_deposit_no);
										frm.appendChild(hiddenField);

										hiddenField = document.createElement("input");
							   	        hiddenField.setAttribute("type", "hidden");
							   	        hiddenField.setAttribute("name", "aprv_state");
							   	        hiddenField.setAttribute("value", aprv_state);
										frm.appendChild(hiddenField);
										
										fnSearch();
						   	     	});
						   	     	
						   	     	$(".btn_cost_settle").on("click",function() {
						   	     		var cost_deposit_no = $(this).data("deposit_no");
						   	     		var user_no= $(this).data("user_no");
						   	     		var bgnDe = $("#hid_bgnDe").val();
						   	     		var endDe = $("#hid_endDe").val();
						   	     		
						   	     		openSettlePop(cost_deposit_no, user_no, bgnDe, endDe);
						   	     		
						   	     	});
						   	     	
						   	     	$(".btn_cost_settle_cancel").on("click",function() {
						   	     		var cost_deposit_no = $(this).data("deposit_no");
						   	     		var aprv_state = $(this).data("aprv_state");
						   	     		var user_no = $(this).data("user_no");
						   	     		$("#user_no").val(user_no);
					   	     		
						   	     		
						   	     		var frm = document.getElementById("cost_mbr_list_form");
						   	     		
										var hiddenField = document.createElement("input");
							   	        hiddenField.setAttribute("type", "hidden");
							   	        hiddenField.setAttribute("name", "cost_deposit_no");
							   	        hiddenField.setAttribute("value", cost_deposit_no);
										frm.appendChild(hiddenField);

										hiddenField = document.createElement("input");
							   	        hiddenField.setAttribute("type", "hidden");
							   	        hiddenField.setAttribute("name", "aprv_state");
							   	        hiddenField.setAttribute("value", aprv_state);
										frm.appendChild(hiddenField);
										
										hiddenField = document.createElement("input");
							   	        hiddenField.setAttribute("type", "hidden");
							   	        hiddenField.setAttribute("name", "settle_cancel");
							   	        hiddenField.setAttribute("value", "1");
										frm.appendChild(hiddenField);
										
										fnSearch();
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
						
						   	            $("#hid_stdBgnde").val($("#year_txt").text() + "-" + imsiMonthStartStr + "-" + "16");
						   	            $("#hid_stdEndde").val($("#year_txt").text() + "-" + imsimonth + "-" + "15");
						
						   	            if(imsimonth == 1){
						   	                $("#hid_stdBgnde").val(($("#year_txt").text()-1) + "-" + "12" + "-" + "16");
						   	            }
						
						   	            fnSearch();
						   	        });
						   	    }
						  	    
						        function fnYearPrev(){
						            var imsiyeartxt = $("#year_txt").text();
						            $("#year_txt").text(--imsiyeartxt);
						            $("#hid_stdBgnde").val(--imsiyeartxt+"-12-16");
						            $("#hid_stdEndde").val($("#year_txt").text()+"-12-15");
						        }
						
						        function fnYearNext(){
						            var imsiyeartxt = $("#year_txt").text();
						            $("#year_txt").text(++imsiyeartxt);
						            $("#hid_stdBgnde").val(--imsiyeartxt + "-12-16");
						            $("#hid_stdEndde").val($("#year_txt").text()+"-12-15");
						        }
						        
						        function fnSearch(){
						            $("#loading").show();
						
						            $("#srchExcelYN").val("N");
						            var frm = document.getElementById("cost_mbr_list_form");
						            
						            //선택한 팀 이름을 별도로 넘긴다.
						            var selTeamName = $("#srch_team_id option:selected").text();						            
						            selTeamName = selTeamName.replace("└","").trim();
						            $("#sel_team_name").val(selTeamName);
						            
						            frm.submit();
						        }
						        
								function _initSrchParam(){

									$("#srch_team_id").select2();
									$("#srch_user_no").select2();
									
									var team_id = $("#hid_team_id").val();
									var user_no = $("#hid_user_no").val();
									
									$("#srch_team_id").val(team_id).select2();
						 			$("#srch_team_id").change();
						 			
									setTimeout(function() {
										$("#srch_user_no").val(user_no).select2();
									}, 200);
								}
								
								function fnMbrDetailSearch(user_no){
									$("#loading").show();
									$("#srchExcelYN").val("N");
									
						            $("#user_no").val(user_no);
						            
						            var frm = document.getElementById("cost_mbr_list_form");
						            
						            frm.action = "cost_detail";
						            frm.submit();									
								}

					   	 		function openSettlePop(cost_deposit_no, user_no, bgnDe, endDe){
					   				var cw=screen.availWidth;
					   				var ch=screen.availHeight;
					   				var sw=1010; //띄울 창의 넓이
					   				var sh=740;  //띄울 창의 높이
					   				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
					   				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
					   				window.open('cost_settle_pop?cost_deposit_no='+cost_deposit_no+'&user_no='+user_no+'&bgnDe='+bgnDe+'&endDe='+endDe,'settlePop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
					   			}	
					   	 		
					   	 		
						        
						        
						        
							</script>
							
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
