<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
	
	<script>
		$(document).ready(function(){
			$.ajaxSetup({cache:false});
			if('${mbrVo_Session.user_no}' == null){
				window.location.assign("./logout");
			}
			
			
			$("#addMyCostIns").click(function(){
				
				if($("#cost_class_no").val().trim() == ''){
					alert("계정명을 선택하세요.");
					$("#cost_class_no").focus();
					return;
				}
				
				if($("#cost_pay_type").val().trim() == ''){
					alert("구분을 선택하세요.");
					$("#cost_pay_type").focus();
					return;
				}
				
				if($("#cost_bill_ea").val().trim() == ''){
					alert("영수증 수를 입력하세요.");
					$("#cost_bill_ea").focus();
					return;
				}
				
				if($("#cost_pay_amt").val().trim() == ''){
					alert("금액을 입력하세요.");
					$("#cost_pay_amt").focus();
					return;
				}
				
				if($("#cost_occur_date").val().trim() == ''){
					alert("날짜를 선택하세요.");
					$("#cost_occur_date").focus();
					return;
				}
				
				$.post("./myCostInsAddOK",
						{
					
							cost_class_no					:$("#cost_class_no").val()
							,cost_occur_date     			:$("#cost_occur_date").val()
							,cost_pay_place					:$("#cost_pay_place").val()
							,cost_involved_com     			:$("#cost_involved_com").val()
							,cost_involved_man      		:$("#cost_involved_man").val()
							,cost_memo    					:$("#cost_memo").val()
							,cost_pay_type  				:$("#cost_pay_type").val()
							,cost_pay_amt  					:$("#cost_pay_amt").val()
							,cost_bill_ea   				:$("#cost_bill_ea").val()
							,sum_cost_bill_ea				:$("#sum_cost_bill_ea").val()
							,sum_cost_pay_amt				:$("#sum_cost_pay_amt").val()
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("나의 경비내역 추가가 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									alert("추가되었습니다.");
									//window.opener.location.assign("./topPtnrDTL?rpt_invoice_no=${rpt_invoice_no}");
									//window.opener.location.reload();
									window.location.reload();
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
						
				);//post

			});//$("#popptnrsave").click	
			
			
			$(".udtMyCost").click(function(){
				
				var tmpVar = $(this).attr("value");
				if($("#cost_class_no"+tmpVar).val().trim() == ''){
					alert("계정명을 선택하세요.");
					$("#cost_class_no"+tmpVar).focus();
					return;
				}
				
				if($("#cost_pay_type"+tmpVar).val().trim() == ''){
					alert("구분을 선택하세요.");
					$("#cost_pay_type"+tmpVar).focus();
					return;
				}
				
				if($("#cost_bill_ea"+tmpVar).val().trim() == ''){
					alert("영수증 수를 입력하세요.");
					$("#cost_bill_ea"+tmpVar).focus();
					return;
				}
				
				if($("#cost_pay_amt"+tmpVar).val().trim() == ''){
					alert("금액을 입력하세요.");
					$("#cost_pay_amt"+tmpVar).focus();
					return;
				}
				
				if($("#cost_occur_date"+tmpVar).val().trim() == ''){
					alert("날짜를 선택하세요.");
					$("#cost_occur_date"+tmpVar).focus();
					return;
				}
				
				
				$.post("./myCostUdtOK",
						{
							
							cost_no							:$("#cost_no"+tmpVar).val()
							,cost_class_no					:$("#cost_class_no"+tmpVar).val()
							,cost_occur_date     			:$("#cost_occur_date"+tmpVar).val()
							,cost_pay_place					:$("#cost_pay_place"+tmpVar).val()
							,cost_involved_com     			:$("#cost_involved_com"+tmpVar).val()
							,cost_involved_man      		:$("#cost_involved_man"+tmpVar).val()
							,cost_memo    					:$("#cost_memo"+tmpVar).val()
							,cost_pay_type  				:$("#cost_pay_type"+tmpVar).val()
							,cost_pay_amt  					:$("#cost_pay_amt"+tmpVar).val()
							,cost_bill_ea   				:$("#cost_bill_ea"+tmpVar).val()
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("나의 경비내역 수정이 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									alert("수정되었습니다.");
									//window.opener.location.assign("./topPtnrDTL?rpt_invoice_no=${rpt_invoice_no}");
									//window.opener.location.reload();
									window.location.reload();
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
						
				);//post

			});//$("#popptnrsave").click
			
			
			$(".delMyCost").click(function(){
				var tmpVar = $(this).attr("value");
				$.post("./myCostDelOK",
						{
							cost_no					:$("#cost_no"+tmpVar).val()
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("나의 경비내역 삭제가 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									alert("삭제되었습니다.");
									//window.opener.location.assign("./primBizInvDtl?rpt_invoice_no=${rpt_invoice_no}");
									//window.opener.location.reload();
									window.location.reload();
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
						
				);//post

			});/* $("#popptnrsave").click */
			
			
			$("#select_class_no").change(function(){
				$("monthbtn").click();
				var tmpSelNo = $("#select_class_no option:selected").val();
				var imsimonth = ${toAccumMonth};
				
		    	var imsiMonthStart = imsimonth -1;
		    	alert(imsimonth);
		    	if(imsimonth.length < 2) imsimonth = "0"+imsimonth;
		    	var imsiMonthStartStr = "0"+imsiMonthStart;
		    	var imsiMonthEndStr = "0" +imsimonth;
		    	if(imsiMonthStartStr.length > 2) imsiMonthStartStr = imsiMonthStartStr.substring(1, imsiMonthStartStr.length);
		        	$("#selectFrom").val($("#yeartxt").text()+"-"+imsiMonthStartStr +"-"+ "16");
		        	$("#selectTo").val($("#yeartxt").text()+"-"+imsiMonthEndStr+"-"+ "16");
		        	$("#selectNo").val();
		        if(imsimonth == 1){
		        	//alert(($("#yeartxt").text()-1)+"12"+"16");
		        	$("#selectFrom").val(($("#yeartxt").text()-1)+"-"+"12" +"-"+ "16");
		        }
		    	var tmpViewFromDate = $("#selectFrom").val();
		    	var tmpViewToDate = $("#selectTo").val();
				alert(tmpSelNo);
				window.location.assign("./myCostInsList?cost_class_no="+tmpSelNo+"&viewFromDate="+tmpViewFromDate+"&viewToDate="+tmpViewToDate);	
			});
			
		});//ready
		
		/* 보고서 원본파일 삭제 */
		function MyCostBillOrgFileDel(serialNo){
			if(confirm("보고서 원본 파일을 삭제하시겠습니까?")){
				$.post("./myCostBillFileDel",
						{	
							serialNo 	:	serialNo  //						
						},
						function(data,status){
							if(status == "success"){
								if(data != 0){
									$("#myCostBillFileOrgTr_"+serialNo).css("display","none");
									window.location.reload();
								}else{
									alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");	
								}
							}else{
								alert("시스템 오류입니다. 잠시 후 재시도 해주세요.");
							}
						}
					);
				}
			}
		
		function deposit_btn(cost_deposit_no, cost_no, user_id, user_name, team_id, team_name, viewFromDate, viewToDate){
			
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이
	
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			
			window.open('topCostDepositPop?cost_deposit_no='+cost_deposit_no+'&cost_no='+cost_no+'&user_id='+user_id+'&user_name='+user_name+'&team_id='+team_id+'&team_name='+team_name+'&viewFromDate='+viewFromDate+'&viewToDate='+viewToDate,'tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		
		function action_cost(action,user_id){
			
// 			if(action =='submit_hq') {
// 				if(!confirm("결재 하시겠습니까?")){
// 					return;
// 				}
// 			}else if(action =='submit_hq_x'){
// 				if(!confirm("취소 하시겠습니까?")){
// 					return;
// 				}
// 			}else if(action =='submit_finance'){
// 				if(!confirm("결재 하시겠습니까?")){
// 					return;
// 				}
// 			}else if(action =='submit_finance_x'){
// 				if(!confirm("취소 하시겠습니까?")){
// 					return;
// 				}
// 			}else if(action =='submit_deposit'){
// 				if(!confirm("결재 하시겠습니까?")){
// 					return;
// 				}
// 			}else if(action =='submit_deposit_x'){
// 				if(!confirm("취소 하시겠습니까?")){
// 					return;
// 				}
// 			}//if(!confirm	

				$.post("./topCostUdtOK",
					{	
						action  			:action
						,user_id   			:user_id
						,viewFromDate		:$("#viewFromDate").val()
						,viewToDate			:$("#viewToDate").val()
						,cost_deposit_no	:$("#cost_deposit_no").val()
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
// 								if(action =='submit_hq') {
// 									alert("결재 하였습니다.");									
// 								}//if
// 								if(action =='submit_hq_x') {
// 									alert("결재 취소하였습니다.");									
// 								}//if
// 								if(action =='submit_finance') {
// 									alert("결재 하였습니다.");									
// 								}//if
// 								if(action =='submit_finance_x') {
// 									alert("결재 취소하였습니다.");									
// 								}//if
// 								if(action =='submit_deposit') {
// 									alert("입금 완료하였습니다.");									
// 								}//if
								window.location.reload();
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

<!-- wrapper -->
<div id="wrapper">
	<!-- skipnavi --><!-- header -->
	<c:import url="../top_main/top_main_menu.jsp"></c:import>
	<!-- //skipnavi --><!-- //header -->

	<!-- contents -->
	<div id="container">
		<div class="contetns">

			<!-- centercnt_top -->
			<div class="center_cnt_1300">

				<!-- centercnt_bot -->
				<div class="center_cnt_1300_bot">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">경비 내역</a></li>
							</ul>
						</div>
						<br>
						<div>
							<input type="hidden" id="viewFromDate" name="fromdate" value="${fromdate}"/>
							<input type="hidden" id="viewToDate" name="todate" value="${todate}"/>
							<%@include file="../top_cost/top_cost_team_top.jsp"%>
						</div>
						<div class="guestcnt4" style="display:block;">
							<div class= "tableStyle2">
								<table>
								 	<tbody>
								 	<%-- <colgroup>
										<col width="8%">
										<col width="5%">
										<col width="10%">
										<col width="5%">
										<col width="9%">
										<col width="9%">
										<col width="9%">
										<col width="9%">
										<col width="9%">
										<col width="9%">
										<col width="9%">
										<col width="9%">
									</colgroup> --%>
									<tr style="background-color:#e7ecf1">
										<td rowspan="2"><b>담당자</b></td>
										<td rowspan="2"><b>청구</b></td>
										<td rowspan="2"><b>팀장</b></td>
										<td rowspan="2"><b>본부장</b></td>
										<td rowspan="2"><b>자금팀 승인</b></td>
										<td colspan="2"><b>협조</b></td>
										<td colspan="2"><b>협조 세금</b></td>
										<td rowspan="2"><b>입금액</b></td>
										<td rowspan="2"><b>입금일</b></td>
										<td rowspan="2"><b>비고</b></td>
									</tr>
									<tr style="background-color:#e7ecf1">
										<td><b>의뢰</b></td>
										<td><b>수임</b></td>
										<td><b>교통비</b></td>
										<td><b>차트비</b></td>
									</tr>
									<%-- <c:set value="${getCostList}" var="getCostList"/> --%>
									<c:forEach items="${getCostTeamList}" var="getCostTeamList" varStatus="status" >
									<tr>
										<td><c:out value="${getCostTeamList.getUser_name()}"/></td>
										<td><fmt:formatNumber value="${getCostTeamList.getSum_cost_pay_amt()}" pattern="###,###,##0.##"/></td>
										<td>
											<c:if test="${getCostTeamList.getCost_aprv_state() eq 1 || getCostTeamList.getCost_aprv_state() eq 2 || getCostTeamList.getCost_aprv_state() eq 3 || getCostTeamList.getCost_aprv_state() eq 4}">
												<fmt:formatNumber value="${getCostTeamList.getSum_cost_deposit_amt()}" pattern="###,###,##0.##"/>
											</c:if>
										</td>
										<td>
											<c:if test="${getCostTeamList.getCost_aprv_state() eq 1}">
											
												<c:if test="${mbrAuthVo_Session.mbr_pms_18 eq '1'}">
												<img src="./resources/ls_img/top_cost/btn_sngin.gif" onclick="action_cost('submit_hq',${getCostTeamList.getUser_no()});" style="cursor:pointer;"/>
												</c:if>
												<input type="hidden" id="cost_deposit_no" name="cost_deposit_no" value="${getCostTeamList.getCost_deposit_no()}" />
												<input type="hidden" id="user_id" name="user_id" value="${getCostTeamList.getUser_no()}" />
												<input type="hidden" id="viewFromDate" name="viewFromDate" value="${fromdate}" />
												<input type="hidden" id="viewToDate" name="viewToDate" value="${todate}" />
											</c:if>
											<c:if test="${getCostTeamList.getCost_aprv_state() eq 2 || getCostTeamList.getCost_aprv_state() eq 3 || getCostTeamList.getCost_aprv_state() eq 4}">
												<fmt:formatNumber value="${getCostTeamList.getAmt_hq_aprv()}" pattern="###,###,##0.##"/>
												<c:if test="${getCostTeamList.getCost_aprv_state() eq 2}">
													<c:if test="${mbrAuthVo_Session.mbr_pms_18 eq '1'}">
													<img src="./resources/ls_img/top_cost/btn_cancel.gif" onclick="action_cost('submit_hq_x',${getCostTeamList.getUser_no()});" style="cursor:pointer;"/>
													</c:if>
												</c:if>
												<input type="hidden" id="cost_deposit_no" name="cost_deposit_no" value="${getCostTeamList.getCost_deposit_no()}" />
												<input type="hidden" id="user_id" name="user_id" value="${getCostTeamList.getUser_no()}" />
												<input type="hidden" id="viewFromDate" name="viewFromDate" value="${fromdate}" />
												<input type="hidden" id="viewToDate" name="viewToDate" value="${todate}" />
											</c:if>
										</td>
										<td>
											<c:if test="${getCostTeamList.getCost_aprv_state() eq 2}">
												<c:if test="${mbrAuthVo_Session.mbr_pms_18 eq '1'}">
												<img src="./resources/ls_img/top_cost/btn_sngin_ja.gif" onclick="action_cost('submit_finance',${getCostTeamList.getUser_no()});" style="cursor:pointer;"/>
												</c:if>
												<input type="hidden" id="cost_deposit_no" name="cost_deposit_no" value="${getCostTeamList.getCost_deposit_no()}" />
												<input type="hidden" id="user_id" name="user_id" value="${getCostTeamList.getUser_no()}" />
												<input type="hidden" id="viewFromDate" name="viewFromDate" value="${fromdate}" />
												<input type="hidden" id="viewToDate" name="viewToDate" value="${todate}" />
											</c:if>
											<c:if test="${getCostTeamList.getCost_aprv_state() eq 3 || getCostTeamList.getCost_aprv_state() eq 4}">
												<fmt:formatNumber value="${getCostTeamList.getAmt_finance_aprv()}" pattern="###,###,##0.##"/>
												<c:if test="${getCostTeamList.getCost_aprv_state() eq 3}">
													<c:if test="${mbrAuthVo_Session.mbr_pms_18 eq '1'}">
													<img src="./resources/ls_img/top_cost/btn_cancel_ja.gif" onclick="action_cost('submit_finance_x',${getCostTeamList.getUser_no()});" style="cursor:pointer;"/>
													</c:if>
												</c:if>
												<input type="hidden" id="cost_deposit_no" name="cost_deposit_no" value="${getCostTeamList.getCost_deposit_no()}" />
												<input type="hidden" id="user_id" name="user_id" value="${getCostTeamList.getUser_no()}" />
												<input type="hidden" id="viewFromDate" name="viewFromDate" value="${fromdate}" />
												<input type="hidden" id="viewToDate" name="viewToDate" value="${todate}" />
											</c:if>
										</td>
										<c:choose>
												<c:when test="${getCostTeamList.getHelp1_price() eq 0}">
												<td></td></c:when>
												<c:otherwise>
													<td><fmt:formatNumber value="${getCostTeamList.getHelp1_price()}" pattern="###,###,##0.##"/></td>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${getCostTeamList.getHelp2_price() eq 0}">
												<td></td></c:when>
												<c:otherwise>
													<td><fmt:formatNumber value="${getCostTeamList.getHelp2_price()}" pattern="###,###,##0.##"/></td>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${getCostTeamList.getSemu1_price() eq 0}">
												<td></td></c:when>
												<c:otherwise>
													<td><fmt:formatNumber value="${getCostTeamList.getSemu1_price()}" pattern="###,###,##0.##"/></td>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${getCostTeamList.getSemu2_price() eq 0}">
												<td></td></c:when>
												<c:otherwise>
													<td><fmt:formatNumber value="${getCostTeamList.getSemu2_price()}" pattern="###,###,##0.##"/></td>
												</c:otherwise>
											</c:choose>
										<td>
											<c:if test="${getCostTeamList.getCost_aprv_state() eq 4}">
												<fmt:formatNumber value="${getCostTeamList.getAmt_deposit()}" pattern="###,###,##0.##"/>
											</c:if>
										</td>
										<td>
											<c:if test="${getCostTeamList.getCost_aprv_state() eq 3}">
												<c:if test="${mbrAuthVo_Session.mbr_pms_17 eq '1'}">
												<img src="./resources/ls_img/top_cost/btn_sngin.gif" onclick="deposit_btn(<c:out value='${getCostTeamList.getCost_deposit_no()}'/>,<c:out value='${getCostTeamList.getCost_no()}'/>,<c:out value='${getCostTeamList.getUser_no()}'/>,'<c:out value='${getCostTeamList.getUser_name()}'/>',<c:out value='${team_id}'/>,'<c:out value='${team_name}'/>','<c:out value='${fromdate}'/>','<c:out value='${todate}'/>');" 
												style="cursor:pointer;"/>
												</c:if>
												<input type="hidden" id="cost_deposit_no" name="cost_deposit_no" value="${getCostTeamList.getCost_deposit_no()}" />
												<input type="hidden" id="user_id" name="user_id" value="${getCostTeamList.getUser_no()}" />
												<input type="hidden" id="viewFromDate" name="viewFromDate" value="${fromdate}" />
												<input type="hidden" id="viewToDate" name="viewToDate" value="${todate}" />
											</c:if>
											<c:if test="${getCostTeamList.getCost_aprv_state() eq 4}">
												<c:out value="${getCostTeamList.getDate_deposit()}"/>
												<c:if test="${mbrAuthVo_Session.mbr_pms_17 eq '1'}">
												<img src="./resources/ls_img/top_cost/btn_cancel.gif" onclick="action_cost('submit_deposit_x',${getCostTeamList.getUser_no()});" style="cursor:pointer;"/>
												</c:if>
												<input type="hidden" id="cost_deposit_no" name="cost_deposit_no" value="${getCostTeamList.getCost_deposit_no()}" />
												<input type="hidden" id="user_id" name="user_id" value="${getCostTeamList.getUser_no()}" />
												<input type="hidden" id="viewFromDate" name="viewFromDate" value="${fromdate}" />
												<input type="hidden" id="viewToDate" name="viewToDate" value="${todate}" />
											</c:if>
										</td>
										<td>
											<a href="./topCostMember?user_id=${getCostTeamList.getUser_no()}&cost_aprv_state=${getCostTeamList.getCost_aprv_state()}&user_name=${getCostTeamList.getUser_name()}&team_id=${team_id}&team_name=${team_name}&viewFromDate=${fromdate}&viewToDate=${todate}">
											<img src="./resources/ls_img/top_cost/btn_view.gif"/></a>
											
										</td>
									</tr>
									</c:forEach>
									<tr>
										<td>합계</td>
										<td><fmt:formatNumber value="${getCostTeamListTotal.total_cost_pay_amt}" pattern="###,###,##0.##"/></td>
										<td><fmt:formatNumber value="${getCostTeamListTotal.total_cost_deposit_amt}" pattern="###,###,##0.##"/></td>
										<td><fmt:formatNumber value="${getCostTeamListTotal.total_amt_hq_aprv}" pattern="###,###,##0.##"/></td>
										<td><fmt:formatNumber value="${getCostTeamListTotal.total_amt_finance_aprv}" pattern="###,###,##0.##"/></td>
										<td><fmt:formatNumber value="${getCostTeamListTotal.total_help1_price}" pattern="###,###,##0.##"/></td>
										<td><fmt:formatNumber value="${getCostTeamListTotal.total_help2_price}" pattern="###,###,##0.##"/></td>
										<td><fmt:formatNumber value="${getCostTeamListTotal.total_semu1_price}" pattern="###,###,##0.##"/></td>
										<td><fmt:formatNumber value="${getCostTeamListTotal.total_semu2_price}" pattern="###,###,##0.##"/></td>
										<td><fmt:formatNumber value="${getCostTeamListTotal.total_amt_deposit}" pattern="###,###,##0.##"/></td>
										<td><c:out value=""/></td>
										<td><c:out value=""/></td>
									</tr>
									</tbody>
								</table>
							</div><!-- //tableStyle2 -->
						</div><!-- //guestcnt4 -->

					</div>
				</div>
				<!-- //centercnt_bot -->

			</div>
			<!-- //center_cnt -->
		</div>
	</div>
	<!-- //contents -->

	<!-- footer -->
	<c:import url="../top_main/top_main_footer.jsp"></c:import>
	<!-- //footer -->

</div>
<!-- //wrapper -->

</body>
</html>