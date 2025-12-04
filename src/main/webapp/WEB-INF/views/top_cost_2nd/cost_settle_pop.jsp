<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	
	<script src="./resources/jquery/jquery.mask.min.js"></script>	
	
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<style>
		#settleTable th{
			background : #F8F8F8;
			height : 28px ;
			color: #003399;
			text-align: center;
		}
		#settleTable td{
			letter-spacing: 0px;
		}	
	
	</style>
	<script>
		$(document).ready(function(){

			$.ajaxSetup({cache:false});

			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.user_no}'.trim() == ''
					|| ('${mbrVo_Session.team_id_main}' != '7'
							&& '${mbrAuthVo_Session.mbr_pms_17}' == '0' && '${mbrAuthVo_Session.mbr_pms_18}' == '0')){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.opener.location.assign("./logout");
				window.self.close();
			}
		});//ready

	</script>
</head>
<body>
	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 경비내역 입금 </span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->
	
	<!-- center -->
	<div id ="container">
		<div class="contetnsPop">
			<div class="center_cnt">
				<div class="centercnt_bot1-3">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">${costSettle.teamNm}&nbsp;${costSettle.userNm}</a></li>
							</ul>
						</div>
						
						<!-- 관련업체 멤버 정보 컨텐츠 탭 -->
						<div class="guestcnt5" style="display:block;">
							<input type="hidden" id="team_id" value="${costSettle.teamId}">
							<input type="hidden" id="user_no" value="${costSettle.userNo}">
							<input type="hidden" id="cost_deposit_no" value="${costSettle.costDepositNo}">
							<input type="hidden" id="cost_year_month" value="${costSettle.costYearMonth}">
							<input type="hidden" id="cost_deposit_help_amt" value="${costSettle.helpAcceptFee - costSettle.helpClientFee}">
							<input type="hidden" id="cost_deposit_total_amt" value="${costSettle.costDepositTotalAmt + costSettle.helpAcceptFee - costSettle.helpClientFee}">
							
							
							<div style="float: left;">
								<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">
								&nbsp;<b>${costSettle.teamNm} ${costSettle.userNm}</b>
								<b>경비 내역 입금</b>
								<b><font color="#0066CC">${costSettle.bgnDe}</font></b>
								<b>부터</b>&nbsp;&nbsp;
								<b><font color="#0066CC">${costSettle.endDe}</font></b>
								<b>까지</b>&nbsp;&nbsp;
							</div>

							<br /><br />

							<div class= "tableStyle2">
								<table id="settleTable" cellpadding="0" cellspacing="0">
									<tr>
				                        <th>자금팀승인</th>
				                        <th>협조(의뢰)</th>
				                        <th>협조(수임)</th>
				                        <th>입금액</th>
				                        <th>입금일</th>
				                    </tr>
				                    
				                    <tr>
				                    	<td><span class="money">${costSettle.costDepositTotalAmt}</span> 원</td>
				                    	<td><span class="money">${costSettle.helpClientFee}</span> 원</td>
										<td><span class="money">${costSettle.helpAcceptFee}</span> 원</td>
				                    	<td><span class="money">${costSettle.costDepositTotalAmt + costSettle.helpAcceptFee - costSettle.helpClientFee}</span> 원</td>
				                    	<td>
				                    		<input type="text" id="cost_deposit_date" name="cost_deposit_date" class="classCalendar" style="width:70px"/>
				                    	</td>
				                    </tr>
								</table>
							</div><!-- //tableStyle -->
							<br>
							<p align="center">
								<img src="./resources/ls_img/top_cost/btn_settle.gif" style="cursor:pointer;"
									onclick="fnAprvCostSettle();" />
							</p>
						</div><!-- //guestcnt -->
						
						<script>
							$(document).ready(function(){ 
								_initMask();
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
							
							function fnAprvCostSettle(){
								var param = {};
								
								param.aprv_state 				= "4";
								param.cost_deposit_no 			= $("#cost_deposit_no").val();
								param.cost_deposit_date			= $("#cost_deposit_date").val();
								param.user_no					= $("#user_no").val();
								param.cost_year_month			= $("#cost_year_month").val();
								param.cost_deposit_help_amt		= $("#cost_deposit_help_amt").val();
								param.cost_deposit_total_amt	= $("#cost_deposit_total_amt").val();
								
						    	var url = "/aprv_cost_settle";
						    	
					       	    $.ajax({
					       	        type: "POST",
					       	        url: url,
					       	        data: param,
					       	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
					       	        timeout: 20000,
					       	        async: false,
					       	        dataType: "HTML", 
					       	        success: function(data){
					       	        	window.opener.document.cost_mbr_list_form.team_id.value = $("#team_id").val();
					       	        	window.opener.document.cost_mbr_list_form.submit();
										window.self.close();	
					       	        }			
					       	    });
							}
							
						</script>						
						
					</div><!-- //guest -->
				</div><!-- //bot1-3 -->
			</div>
		</div>
	</div>
	<!--//center -->

	<!-- footer -->
	<c:import url="../top_main/top_pop_footer.jsp"></c:import>
	<!-- //footer -->

</body>
