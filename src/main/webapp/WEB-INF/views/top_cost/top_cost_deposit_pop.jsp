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
	<title>INVOICE 수정</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
	
	<script src="./resources/ne_js/calendar.js"></script>
	<script>
		$(document).ready(function(){
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_9}' == 0){
				window.opener.location.assign("./logout");
				window.self.close();
			}
		});//ready
	</script>
	<c:set var="rpt_invoice_no" value="${invoiceDtl.getRpt_invoice_no()}"/>
	<script>
	$(document).ready(function(){

		$.ajaxSetup({cache:false});
		
		$("#invmemoeditsave").click(function(){
			
			
			$.post("./primBizInvMemoUdtOK",
					{
						rpt_invoice_no				:$("#rpt_invoice_no").val()
						,rpt_invoice_memo   		:$("#rpt_invoice_memo").val()
						,suim_rpt_no	   			:$("#suim_rpt_no").val()
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("수정이 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								alert("수정되었습니다.");
								//window.opener.location.assign("./topPtnrDTL?rpt_invoice_no=${rpt_invoice_no}");
								window.self.close();
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}//function
					
			);//post

		});//$("#popptnrsave").click

		

	});//ready
	
	function action_cost(action){
		if(action =='submit_deposit') {
			if(!confirm("승인 하시겠습니까?")){
				return;
			}
		}	

			$.post("./topCostUdtOK",
				{	
					action  			:action
					,user_id   			:$("#user_id").val()
					,date_deposit		:$("#date_deposit").val()
					,amt_deposit		:$("#amt_deposit").val()
					,cost_deposit_no	:$("#cost_deposit_no").val()
					,cost_no			:$("#cost_no").val()
				},
				function(data,status){
					if(status == "success"){
						if(data == 0){
							alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
						}else{
							if(action =='submit_deposit') {
								alert("입금 완료하였습니다.");									
							}//if
							window.opener.location.assign("./topCostTeam?team_id=${team_id}&team_name=${team_name}&viewFromDate=${fromdate}&viewToDate=${todate}");
							window.self.close();
						}//else
					}else{
						alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
					}//else
				}//function
			);//post */
		
	}//function action_cost1
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
								<li class="on"><a href="#">${team_name}&nbsp;${user_name}</a></li>
							</ul>
						</div>
						
						<!-- 관련업체 멤버 정보 컨텐츠 탭 -->
						<div class="guestcnt5" style="display:block;">
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
				                    <c:forEach items="${getCostMemberDeposit}" var="getCostMemberDeposit">
				                    <tr>
				                    	<td><fmt:formatNumber value="${getCostMemberDeposit.getAmt_finance_aprv()}" pattern="###,###,##0.##"/></td>
				                    	<td><fmt:formatNumber value="${getCostMemberDeposit.getHelp1_price()}" pattern="###,###,##0.##"/></td>
										<td><fmt:formatNumber value="${getCostMemberDeposit.getHelp2_price()}" pattern="###,###,##0.##"/></td>
				                    	<td><fmt:formatNumber value="${getCostMemberDeposit.getAmt_finance_aprv() - getCostMemberDeposit.getHelp1_price() + getCostMemberDeposit.getHelp2_price()}" pattern="###,###,##0.##"/></td>
				                    	<td>
				                    		<input type="text" id="date_deposit" name="date_deposit"/>
				                    		<input type="hidden" id="cost_deposit_no" name="cost_deposit_no" value="${getCostMemberDeposit.getCost_deposit_no()}" />
											<input type="hidden" id="cost_no" name="cost_no" value="${cost_no}" />
											<input type="hidden" id="user_id" name="user_id" value="${getCostMemberDeposit.getUser_no()}" />
											<input type="hidden" id="amt_deposit" name="amt_deposit" value="${getCostMemberDeposit.getAmt_finance_aprv() - getCostMemberDeposit.getHelp1_price() + getCostMemberDeposit.getHelp2_price()}" />
				                    	</td>
				                    </tr>
				                    </c:forEach>
							</table>
						</div>
						<br>
						<p align="center">
							<img src="./resources/ls_img/top_cost/btn_sngin.gif" onclick="action_cost('submit_deposit');" style="cursor:pointer;"/>
						</p>
						</div>
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
