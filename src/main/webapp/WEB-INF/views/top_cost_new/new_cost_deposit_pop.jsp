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
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
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

		function goCostAprvChg(aprvCode, stateNo, aprvNo, user_no, cost_deposit_no){
			if($("#date_deposit").val() == ""){
				alert("입금일을 확인해주세요.");
				return;
			}
			$.post("./udtNewCostAprv",
				{	aprvCode  			:aprvCode
					,stateNo   			:stateNo
					,aprvNo   			:aprvNo
					,user_no   			:user_no
					,cost_deposit_no	:cost_deposit_no
					,viewFromDate		:$("#viewFromDate").val()
					,viewToDate			:$("#viewToDate").val()
					,amt_deposit		:$("#amt_deposit").val()
					,date_deposit		:$("#date_deposit").val()
				},
				function(data,status){
					if(status == "success"){
						window.opener.location.reload();
						window.self.close();		
						/*
						if(data == 0){
							alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
						}else{
							window.opener.location.reload();
							window.self.close();
						}//else
						*/
					}else{
						alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
					}//else
				}//function
			);//post
	}//function goCostAprvChg
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
								<li class="on"><a href="#">${getUserInfo.team_name}&nbsp;${getUserInfo.user_name}</a></li>
							</ul>
						</div>
						
						<!-- 관련업체 멤버 정보 컨텐츠 탭 -->
						<div class="guestcnt5" style="display:block;">
							<div style="float: left;">
								<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0">
								&nbsp;<b>${getUserInfo.team_name} ${getUserInfo.user_name}</b>
								<b><font color="#0066CC">경비 내역 입금</font></b>
								<b>${inVO.viewFromDate}</b>
								<b><font color="#0066CC">부터</font></b>&nbsp;&nbsp;
								<b>${inVO.viewToDate}</b>
								<b><font color="#0066CC">까지</font></b>&nbsp;&nbsp;
							</div>

							<form name="newCostSearchForm" id="newCostSearchForm" method="GET" action="./newCostList">
								<input	type="hidden" id="viewFromDate" name="viewFromDate" value="${inVO.viewFromDate}"
										size="10" maxlength="10" readonly style="background-color:lightgrey;" />
								<input	type="hidden" id="viewToDate"  name="viewToDate" value="${inVO.viewToDate}"
										size="10" maxlength="10" readonly style="background-color:lightgrey;" />
								<input type="hidden" id="team_id" name="team_id" value="${inVO.team_id}" />
								<input type="hidden" id="team_name" name="team_name" value="${inVO.team_name}" />
							</form>

							<br /><br />

							<div class= "tableStyle2">
								<table cellpadding="0" cellspacing="0">
										<tr>
					                        <th bgcolor="#F8F8F8" class="td" height="28">
					                            <p align="center"><font color="#003399">자금팀승인</font></p>
					                        </th>
					                        <th bgcolor="#F8F8F8" class="td" height="28">
					                            <p align="center"><font color="#003399">협조(의뢰)</font></p>
					                        </th>
					                        <th bgcolor="#F8F8F8" class="td" height="28">
					                            <p align="center"><font color="#003399">협조(수임)</font></p>
					                        </th>
					                        <th bgcolor="#F8F8F8" class="td" height="28">
					                            <p align="center"><font color="#003399">입금액</font></p>
					                        </th>
					                        <th bgcolor="#F8F8F8" class="td" height="28">
					                            <p align="center"><font color="#003399">입금일</font></p>
					                        </th>
					                    </tr>
					                    <c:forEach items="${getNewCostDepositPop}" var="vo">
					                    <tr>
					                    	<td><fmt:formatNumber value="${vo.amt_finance_aprv}" pattern="###,###,##0.##"/></td>
					                    	<td><fmt:formatNumber value="${vo.help_client_traffic_fee+vo.help_client_chart_fee}" pattern="###,###,##0.##"/></td>
											<td><fmt:formatNumber value="${vo.help_accept_traffic_fee+vo.help_accept_chart_fee}" pattern="###,###,##0.##"/></td>
					                    	<td><fmt:formatNumber value="${vo.amt_finance_aprv-vo.help_client_traffic_fee-vo.help_client_chart_fee+vo.help_accept_traffic_fee+vo.help_accept_chart_fee}" pattern="###,###,##0.##"/></td>
					                    	<td>
					                    		<input type="text" id="date_deposit" name="date_deposit" style="width:70px"/>
												<input type="hidden" id="amt_deposit" name="amt_deposit"
													value="${vo.amt_finance_aprv-vo.help_client_traffic_fee-vo.help_client_chart_fee+vo.help_accept_traffic_fee+vo.help_accept_chart_fee}" />
					                    	</td>
					                    </tr>
					                    	<c:set var="voUserNo" value="${vo.user_no}" />
					                    	<c:set var="voCostDepositNo" value="${vo.cost_deposit_no}" />
					                    </c:forEach>
								</table>
							</div><!-- //tableStyle -->
							<br>
							<p align="center">
								<img src="./resources/ls_img/top_cost/btn_settle.gif" style="cursor:pointer;"
									onclick="javascript:goCostAprvChg('deposit',3,4,${voUserNo},${voCostDepositNo});" />
							</p>
						</div><!-- //guestcnt -->
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
