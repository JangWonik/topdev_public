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
	<script src="./resources/cmm/js/common.js"></script>	


	<style>
		.costTable table tr td{
			letter-spacing: 0px;
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

			$("#srch_team_id").select2();
			$("#srch_user_no").select2();
			
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
		
		function doTmDownLoad(){
			$("#cost_tm_list_excel_form").submit();	
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
								<img onclick="fnYearPrev()" src="./resources/ne_img/icon_prev.gif" width="17" height="13" border="0">
								<a id="year_txt" href="#">${srchArg.endDe.substring(0,4)}</a>
								<img onclick="fnYearNext()" src="./resources/ne_img/icon_next.gif" width="17" height="13" border="0">
								<c:forEach var="i" begin="1" end="12" step="1" varStatus="">
									<input id="${i}" class="monthbtn" type="button" value="${i}월" />
								</c:forEach>
							</div>

							<form name="cost_tm_list_form" id="cost_tm_list_form" method="POST" action="/cost_tm_list">
							
								<input type="hidden" id="cost_year_month" name="cost_year_month" value="${srchArg.yearMonth}"/>
								
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
									<c:forEach items="${mbrList}" var="item">
										<option value="${item.user_no}" data-search-team="${item.team_id}">${item.user_name}</option>
									</c:forEach>								
								</select>								
								
								<img src="./resources/ne_img/btn/btn_srch.gif" style="cursor: pointer;" onclick="fnMbrSrch();"/>
								
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
								<li><a href="#">개인별 경비 내역</a></li>
							</ul>
						</div>
						<div class="guestcnt2" style="display:block;">
							<form name="cost_tm_list_excel_form" id="cost_tm_list_excel_form" method="POST" action="/cost_tm_list_excel">
								<input type="hidden" id="cost_year_month" name="cost_year_month" value="${srchArg.yearMonth}"/>								
								<input type="hidden" id="hid_bgnDe" name="hid_bgnDe" value="${srchArg.bgnDe}" />
								<input type="hidden" id="hid_endDe" name="hid_endDe" value="${srchArg.endDe}" /> 								
								<input type="hidden" id="hid_stdBgnde" name="stdBgnde" value="${srchArg.stdBgnde}" />
								<input type="hidden" id="hid_stdEndde" name="stdEndde" value="${srchArg.stdEndde}" />
							</form>
							<div style="text-align:right;padding:0 0 5px 0;">
								<img id="excelTmdown" style="cursor: pointer;" onclick="javascript:doTmDownLoad();" alt="엑셀다운로드" src="/resources/ls_img/btn_excel.gif">
							</div>
							<div class="tableStyle2">
                                <div style="padding-right: 17px; background: #e7ecf1;">
                                    <table cellpadding="0" cellspacing="0" width="1060" align="center">
                                    	<colgroup>
                                    		<col style="width:5%" />
                                    		<col style="width:13%" />
                                    		<col style="width:5%" />
                                    		<col style="width:7%" />
                                    		<col style="width:7%" />
                                    		<col style="width:7%" />
                                    		<col style="width:7%" />
                                    		<col style="width:7%" />
                                    		<col style="width:7%" />
                                    		<col style="width:7%" />
                                    		<col style="width:7%" />
                                    		<col style="width:7%" />
                                    		<col style="width:7%" />
                                    		<col style="width:7%" />
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
                                
                                
                                <div class="costTable" style="height:570px; overflow-x: hidden; overflow-y: auto;">
                                    <table cellpadding="0" cellspacing="0" width="1060" align="center">
                                    	<colgroup>
                                    		<col style="width:5%" />
                                    		<col style="width:13%" />
                                    		<col style="width:5%" />
                                    		<col style="width:7%" />
                                    		<col style="width:7%" />
                                    		<col style="width:7%" />
                                    		<col style="width:7%" />
                                    		<col style="width:7%" />
                                    		<col style="width:7%" />
                                    		<col style="width:7%" />
                                    		<col style="width:7%" />
                                    		<col style="width:7%" />
                                    		<col style="width:7%" />
                                    		<col style="width:7%" />
                                    	</colgroup>
										<c:forEach items="${costTmList0}" var="item" varStatus="status">
											<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
												<c:if test="${status.first}">
													<td rowspan="${costTmList0.size()}">
														총괄
													</td>
												</c:if>
												<td>${item.teamName}</td>
												<td>${item.userCnt}</td>
												<td><span class="money">${item.basicAmt}</span></td>
												<td><span class="money">${item.addAmt}</span></td>
												<td><span class="money">${item.claimAmt}</span></td>
												<td><span class="money">${item.totalAmt}</span></td>
												<td><span class="money">${item.tmAprvAmt}</span></td>
												<td><span class="money">${item.hqAprvAmt}</span></td>
												<td><span class="money">${item.financeAprvAmt}</span></td>
												<td><span class="money">${item.helpClientAmt}</span></td>
												<td><span class="money">${item.helpAcceptAmt}</span></td>
												<td><span class="money">${item.depositAmt}</span></td>
												<td>
													<img class="btn_mbr_list" src="./resources/ls_img/top_cost/btn_view.gif" data-team_id="${item.teamId}"  style="cursor: pointer;"/>
												</td>
											</tr>
											<c:set var="basicAmtSum0" value="${basicAmtSum0 + item.basicAmt}" />
											<c:set var="addAmtSum0" value="${addAmtSum0 + item.addAmt}" />
											<c:set var="claimAmtSum0" value="${claimAmtSum0 + item.claimAmt}" />
											<c:set var="totalAmtSum0" value="${totalAmtSum0 + item.totalAmt}" />
											<c:set var="tmAprvAmtSum0" value="${tmAprvAmtSum0 + item.tmAprvAmt}" />
											<c:set var="hqAprvAmtSum0" value="${hqAprvAmtSum0 + item.hqAprvAmt}" />
											<c:set var="financeAprvAmtSum0" value="${financeAprvAmtSum0 + item.financeAprvAmt}" />
											<c:set var="helpClientAmtSum0" value="${helpClientAmtSum0 + item.helpClientAmt}" />
											<c:set var="helpAcceptAmtSum0" value="${helpAcceptAmtSum0 + item.helpAcceptAmt}" />
											<c:set var="depositAmtSum0" value="${depositAmtSum0 + item.depositAmt}" />
										
										</c:forEach>
										<tr bgcolor="#E7ECF1">
                                            <td colspan="3">총괄 소계</td>
                                            <td><span class="money">${basicAmtSum0}</span></td>
                                            <td><span class="money">${addAmtSum0}</span></td>
                                            <td><span class="money">${claimAmtSum0}</span></td>
                                            <td><span class="money">${totalAmtSum0}</span></td>
                                            <td><span class="money">${tmAprvAmtSum0}</span></td>
                                            <td><span class="money">${hqAprvAmtSum0}</span></td>
                                            <td><span class="money">${financeAprvAmtSum0}</span></td>
                                            <td><span class="money">${helpClientAmtSum0}</span></td>
                                            <td><span class="money">${helpAcceptAmtSum0}</span></td>
                                            <td><span class="money">${depositAmtSum0}</span></td>
                                            <td></td>
                                        </tr>

										<c:forEach items="${costTmList1}" var="item" varStatus="status">
											<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
												<c:if test="${status.first}">
													<td rowspan="${costTmList1.size()}">
														1종
													</td>
												</c:if>
												<td>${item.teamName}</td>
												<td>${item.userCnt}</td>
												<td><span class="money">${item.basicAmt}</span></td>
												<td><span class="money">${item.addAmt}</span></td>
												<td><span class="money">${item.claimAmt}</span></td>
												<td><span class="money">${item.totalAmt}</span></td>
												<td><span class="money">${item.tmAprvAmt}</span></td>
												<td><span class="money">${item.hqAprvAmt}</span></td>
												<td><span class="money">${item.financeAprvAmt}</span></td>
												<td><span class="money">${item.helpClientAmt}</span></td>
												<td><span class="money">${item.helpAcceptAmt}</span></td>
												<td><span class="money">${item.depositAmt}</span></td>
												<td>
													<img class="btn_mbr_list" src="./resources/ls_img/top_cost/btn_view.gif" data-team_id="${item.teamId}"  style="cursor: pointer;"/>
												</td>
											</tr>
											<c:set var="basicAmtSum1" value="${basicAmtSum1 + item.basicAmt}" />
											<c:set var="addAmtSum1" value="${addAmtSum1 + item.addAmt}" />
											<c:set var="claimAmtSum1" value="${claimAmtSum1 + item.claimAmt}" />
											<c:set var="totalAmtSum1" value="${totalAmtSum1 + item.totalAmt}" />
											<c:set var="tmAprvAmtSum1" value="${tmAprvAmtSum1 + item.tmAprvAmt}" />
											<c:set var="hqAprvAmtSum1" value="${hqAprvAmtSum1 + item.hqAprvAmt}" />
											<c:set var="financeAprvAmtSum1" value="${financeAprvAmtSum1 + item.financeAprvAmt}" />
											<c:set var="helpClientAmtSum1" value="${helpClientAmtSum1 + item.helpClientAmt}" />
											<c:set var="helpAcceptAmtSum1" value="${helpAcceptAmtSum1 + item.helpAcceptAmt}" />
											<c:set var="depositAmtSum1" value="${depositAmtSum1 + item.depositAmt}" />
										
										</c:forEach>
										<tr bgcolor="#E7ECF1">
                                            <td colspan="3">1종 소계</td>
                                            <td><span class="money">${basicAmtSum1}</span></td>
                                            <td><span class="money">${addAmtSum1}</span></td>
                                            <td><span class="money">${claimAmtSum1}</span></td>
                                            <td><span class="money">${totalAmtSum1}</span></td>
                                            <td><span class="money">${tmAprvAmtSum1}</span></td>
                                            <td><span class="money">${hqAprvAmtSum1}</span></td>
                                            <td><span class="money">${financeAprvAmtSum1}</span></td>
                                            <td><span class="money">${helpClientAmtSum1}</span></td>
                                            <td><span class="money">${helpAcceptAmtSum1}</span></td>
                                            <td><span class="money">${depositAmtSum1}</span></td>
                                            <td></td>
                                        </tr>

										<c:forEach items="${costTmList4}" var="item" varStatus="status">
											<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''">
												<c:if test="${status.first}">
													<td rowspan="${costTmList4.size()}">
														4종
													</td>
												</c:if>
												<td>${item.teamName}</td>
												<td>${item.userCnt}</td>
												<td><span class="money">${item.basicAmt}</span></td>
												<td><span class="money">${item.addAmt}</span></td>
												<td><span class="money">${item.claimAmt}</span></td>
												<td><span class="money">${item.totalAmt}</span></td>
												<td><span class="money">${item.tmAprvAmt}</span></td>
												<td><span class="money">${item.hqAprvAmt}</span></td>
												<td><span class="money">${item.financeAprvAmt}</span></td>
												<td><span class="money">${item.helpClientAmt}</span></td>
												<td><span class="money">${item.helpAcceptAmt}</span></td>
												<td><span class="money">${item.depositAmt}</span></td>
												<td>
													<img class="btn_mbr_list" src="./resources/ls_img/top_cost/btn_view.gif" data-team_id="${item.teamId}"  style="cursor: pointer;"/>
												</td>
											</tr>
											<c:set var="basicAmtSum4" value="${basicAmtSum4 + item.basicAmt}" />
											<c:set var="addAmtSum4" value="${addAmtSum4 + item.addAmt}" />
											<c:set var="claimAmtSum4" value="${claimAmtSum4 + item.claimAmt}" />
											<c:set var="totalAmtSum4" value="${totalAmtSum4 + item.totalAmt}" />
											<c:set var="tmAprvAmtSum4" value="${tmAprvAmtSum4 + item.tmAprvAmt}" />
											<c:set var="hqAprvAmtSum4" value="${hqAprvAmtSum4 + item.hqAprvAmt}" />
											<c:set var="financeAprvAmtSum4" value="${financeAprvAmtSum4 + item.financeAprvAmt}" />
											<c:set var="helpClientAmtSum4" value="${helpClientAmtSum4 + item.helpClientAmt}" />
											<c:set var="helpAcceptAmtSum4" value="${helpAcceptAmtSum4 + item.helpAcceptAmt}" />
											<c:set var="depositAmtSum4" value="${depositAmtSum4 + item.depositAmt}" />
										
										</c:forEach>
										<tr bgcolor="#E7ECF1">
                                            <td colspan="3">4종 소계</td>
                                            <td><span class="money">${basicAmtSum4}</span></td>
                                            <td><span class="money">${addAmtSum4}</span></td>
                                            <td><span class="money">${claimAmtSum4}</span></td>
                                            <td><span class="money">${totalAmtSum4}</span></td>
                                            <td><span class="money">${tmAprvAmtSum4}</span></td>
                                            <td><span class="money">${hqAprvAmtSum4}</span></td>
                                            <td><span class="money">${financeAprvAmtSum4}</span></td>
                                            <td><span class="money">${helpClientAmtSum4}</span></td>
                                            <td><span class="money">${helpAcceptAmtSum4}</span></td>
                                            <td><span class="money">${depositAmtSum4}</span></td>
                                            <td></td>
                                        </tr>

                                        
                                        <tr bgcolor="#E7ECF1">
                                            <td colspan="3">합계</td>
                                            <td><span class="money">${basicAmtSum0+basicAmtSum1+basicAmtSum4}</span></td>
                                            <td><span class="money">${addAmtSum0+addAmtSum1+addAmtSum4}</span></td>
                                            <td><span class="money">${claimAmtSum0+claimAmtSum1+claimAmtSum4}</span></td>
                                            <td><span class="money">${totalAmtSum0+totalAmtSum1+totalAmtSum4}</span></td>
                                            <td><span class="money">${tmAprvAmtSum0+tmAprvAmtSum1+tmAprvAmtSum4}</span></td>
                                            <td><span class="money">${hqAprvAmtSum0+hqAprvAmtSum1+hqAprvAmtSum4}</span></td>
                                            <td><span class="money">${financeAprvAmtSum0+financeAprvAmtSum1+financeAprvAmtSum4}</span></td>
                                            <td><span class="money">${helpClientAmtSum0+helpClientAmtSum1+helpClientAmtSum4}</span></td>
                                            <td><span class="money">${helpAcceptAmtSum0+helpAcceptAmtSum1+helpAcceptAmtSum4}</span></td>
                                            <td><span class="money">${depositAmtSum0+depositAmtSum1+depositAmtSum4}</span></td>                                            
                                            <td></td>
                                        </tr>
                                    </table>
                                </div>
							</div><!-- //tableStyle2 -->
							
							<script>						
								$(document).ready(function(){
									_initMask();
									_initButton();
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
						   	        
						   	     	$(".btn_mbr_list").on("click",function() {
						   	     		var team_id = $(this).data("team_id");   	     
						   	     		fnTmMbrList(team_id);
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
						            var frm = document.getElementById("cost_tm_list_form");
						            var selTeamName = $("#srch_team_id option:selected").text();						            
						            selTeamName = selTeamName.replace("└","").trim();
						            $("#sel_team_name").val(selTeamName);					            
						            
						            frm.submit();
						        }
						        
						        function fnMbrSrch(){
						            var frm = document.getElementById("cost_tm_list_form");
						            var selTeamName = $("#srch_team_id option:selected").text();						            
						            selTeamName = selTeamName.replace("└","").trim();
						            $("#sel_team_name").val(selTeamName);
						            
						            frm.action = "cost_mbr_list";
						            frm.submit();							        	
						        }
						        
								function fnTmMbrList(team_id){
									$("#loading").show();
									$("#srchExcelYN").val("N");
						            $("#srch_team_id").val(team_id);
						            
						            fnMbrSrch();					
								}
						        
						        
							</script>

						</div><!-- //guestcnt -->
						<!-- //개인별 경비 내역 시작-->
						<div class="guestcnt2" style="display:none;">
							<c:import url="./cost_person_list.jsp"></c:import>
						</div>
						<!-- //개인별 경비 내역 끝-->						
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
