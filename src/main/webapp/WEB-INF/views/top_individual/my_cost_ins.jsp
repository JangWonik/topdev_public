<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
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
			if('${mbrVo_Session.user_no}' == null){
				window.location.assign("./logout");
			}
			
			$("#printMyCost").click(function(){
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				
				var sw=1010; //띄울 창의 넓이
				var sh=740;  //띄울 창의 높이

				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				
				window.open('printMyCost?user_no='+$("#user_no").val()+'&viewFromDate='+$("#viewFromDate").val()+'&viewToDate='+$("#viewToDate").val(),'_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});
		
			
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
							,cost_deposit_no				:$("#cost_deposit_no").val()
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
				
		    	if(imsimonth.length < 2) imsimonth = "0"+imsimonth;
		    	if(imsimonth.length > 2) imsimonth = imsimonth;
		    	
		    	var imsiMonthStart = imsimonth -1;
		    	var imsiMonthStartStr = "0"+imsiMonthStart;
		    	var imsiMonthEndStr = imsimonth;
		    	
		    	if(imsiMonthStartStr.length > 2) imsiMonthStartStr = imsiMonthStartStr.substring(1, imsiMonthStartStr.length);
		        	$("#selectFrom").val($("#yeartxt").text()+"-"+imsiMonthStartStr +"-"+ "16");
		        	$("#selectTo").val($("#yeartxt").text()+"-"+imsiMonthEndStr+"-"+ "16");
		        	$("#selectNo").val();
		        if(imsimonth == 1){
		        	$("#selectFrom").val(($("#yeartxt").text()-1)+"-"+"12" +"-"+ "16");
		        }
		    	var tmpViewFromDate = $("#selectFrom").val();
		    	var tmpViewToDate = $("#selectTo").val();
				window.location.assign("./myCostInsList?cost_class_no="+tmpSelNo+"&viewFromDate="+tmpViewFromDate+"&viewToDate="+tmpViewToDate);	
			});
			
		});//ready
		
		/* 협조건 내역 상세보기 */
		function viewhelpbtn(serial_no){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			
			window.open('helpRptBscDtl?serialNo='+serial_no+'&viewFromDate='+$("#viewFromDate").val()+'&viewToDate='+$("#viewToDate").val(),'_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		}
		
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

			<!-- left_cnt -->
			<c:import url="../top_main/top_main_left.jsp"></c:import>
			<!-- //left_cnt -->

			<!-- centercnt_top -->
			<div class="center_cnt">

				<!-- centercnt_bot -->
				<div class="centercnt_bot1-2">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">나의 경비내역</a></li>
							</ul>
							
						</div>
						<%-- <c:set value="cost_class_no" var="cost_class_no"/> --%>
						<div style ="text-align:left; margin-top:5px;">
							<select id="select_class_no">
								<option value="0" <c:if test="${cost_class_no eq '0'}"> selected="selected" </c:if>>-전체-</option>
								<option value="11" <c:if test="${cost_class_no eq '11'}"> selected="selected" </c:if>>대중교통비</option>
								<option value="21" <c:if test="${cost_class_no eq '21'}"> selected="selected" </c:if>>유류대</option>
								<option value="31" <c:if test="${cost_class_no eq '31'}"> selected="selected" </c:if>>주차비</option>
								<option value="41" <c:if test="${cost_class_no eq '41'}"> selected="selected" </c:if>>통행료</option>
								<option value="51" <c:if test="${cost_class_no eq '51'}"> selected="selected" </c:if>>숙박비</option>
								<option value="61" <c:if test="${cost_class_no eq '61'}"> selected="selected" </c:if>>회식대</option>
								<option value="71" <c:if test="${cost_class_no eq '71'}"> selected="selected" </c:if>>식대</option>
								<option value="81" <c:if test="${cost_class_no eq '81'}"> selected="selected" </c:if>>업무협의비</option>
								<option value="91" <c:if test="${cost_class_no eq '91'}"> selected="selected" </c:if>>물품구입비</option>
								<option value="101" <c:if test="${cost_class_no eq '101'}"> selected="selected" </c:if>>우편요금</option>
								<option value="111" <c:if test="${cost_class_no eq '111'}"> selected="selected" </c:if>>통신료</option>
								<option value="121" <c:if test="${cost_class_no eq '121'}"> selected="selected" </c:if>>문서발급비</option>
								<option value="131" <c:if test="${cost_class_no eq '131'}"> selected="selected" </c:if>>수도광열비</option>
							</select>
							<input type="hidden" id="user_no" name="user_no" value="${user_no}"/>
							<input type="hidden" id="viewFromDate" name="fromdate" value="${fromdate}"/>
							<input type="hidden" id="viewToDate" name="todate" value="${todate}"/>
							<%@include file="../top_individual/my_cost_top.jsp"%>
							<img id="printMyCost" style = "cursor:pointer; float:right;" src="./resources/ls_img/icon_print.gif"/>
						</div>
						<div class="guestcnt4" style="display:block;">
						 <b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/> 나의 경비내역 추가</b>
							<div class= "tableStyle2">
								<table>
									<colgroup>
										<col width="8%">
										<col width="8%">
										<col width="5%">
										<col width="5%">
										<col width="6%">
										<col width="8%">
										<col width="8%">
										<col width="8%">
										<col width="8%">
										<col width="3%">
										<col width="7%">
										<col width="5%">
									</colgroup>
									<tr>
										<th>일자</th>
										<th>계정명</th>
										<th>구분</th>
										<th>영수증 수</th>
										<th>금액</th>
										<th>지급처</th>
										<th>관련회사</th>
										<th>면담자</th>
										<th>비고</th>
										<th>상태</th>
										<th>확정금액</th>
										<th>비고</th>
									</tr>
									<tr>
										<td><input type="text" id="cost_occur_date" name="cost_occur_date" style="width:60px;"/></td>
										<td>
											<select id="cost_class_no">
												<option value="">-선택-</option>
												<option value="11">대중교통비</option>
												<option value="21">유류대</option>
												<option value="31">주차비</option>
												<option value="41">통행료</option>
												<option value="51">숙박비</option>
												<option value="61">회식대</option>
												<option value="71">식대</option>
												<option value="81">업무협의비</option>
												<option value="91">물품구입비</option>
												<option value="101">우편요금</option>
												<option value="111">통신료</option>
												<option value="121">문서발급비</option>
												<option value="131">수도광열비</option>
											</select>
										</td>
										<td style="width:;">
											<select id="cost_pay_type">
												<option value="1">카드</option>
												<option value="0">현금</option>
											</select>
										</td>
										<td><input type="text" id="cost_bill_ea" name="cost_bill_ea" style="width:20px"/>ea</td>
										<td><input type="text" id="cost_pay_amt" name="cost_pay_amt" style="width:63px"/></td>
										<td><input type="text" id="cost_pay_place" name="cost_pay_place" style="width:85px"/></td>
										<td><input type="text" id="cost_involved_com" name="cost_involved_com" style="width:85px"/></td>
										<td><input type="text" id="cost_involved_man" name="cost_involved_man" style="width:85px"/></td>
										<td><input type="text" id="cost_memo" name="cost_memo" style="width:85px"/></td>
										<td></td>
										<td></td>
										
										<td>
											<img src="./resources/ls_img/btn_add.gif" id="addMyCostIns" alt="추가" style ="cursor:pointer" />
											<input type="hidden" id="cost_deposit_no" name="cost_deposit_no" value="${getMyCostDepositInfo.cost_deposit_no}"/>
										</td>
									</tr>
									
								</table>
									
								</div>
								<br>
									<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/> 나의 경비내역 수정/삭제</b>
								<div class= "tableStyle2">
									<table>
										<thead>
											<colgroup>
												<col width="8%">
												<col width="8%">
												<col width="5%">
												<col width="5%">
												<col width="6%">
												<col width="8%">
												<col width="8%">
												<col width="8%">
												<col width="8%">
												<col width="3%">
												<col width="7%">
												<col width="5%">
											</colgroup>
											<tr>
												<th>일자</th>
												<th>계정명</th>
												<th>구분</th>
												<th>영수증 수</th>
												<th>금액</th>
												<th>지급처</th>
												<th>관련회사</th>
												<th>면담자</th>
												<th>비고</th>
												<th>상태</th>
												<th>확정금액</th>
												<th>비고</th>
											</tr>
											<%-- <c:set value="${getMyCostList}" var="getMyCostList"/> --%>
											<c:forEach items="${getMyCostInsList}" var="getMyCostList" varStatus="status" >
											<tr>
												<td><input type="text" id="cost_occur_date${status.index}" class="cost_occur_date" name="cost_occur_dateUDT" value="${getMyCostList.getCost_occur_date()}" style="width:60px;"/></td>
												<td>
												<select id="cost_class_no${status.index}">
													<option value="0" <c:if test="${getMyCostList.getCost_class_no() eq '0'}"> selected="selected" </c:if>>-전체-</option>
													<option value="11" <c:if test="${getMyCostList.getCost_class_no() eq '11'}"> selected="selected" </c:if>>대중교통비</option>
													<option value="21" <c:if test="${getMyCostList.getCost_class_no() eq '21'}"> selected="selected" </c:if>>유류대</option>
													<option value="31" <c:if test="${getMyCostList.getCost_class_no() eq '31'}"> selected="selected" </c:if>>주차비</option>
													<option value="41" <c:if test="${getMyCostList.getCost_class_no() eq '41'}"> selected="selected" </c:if>>통행료</option>
													<option value="51" <c:if test="${getMyCostList.getCost_class_no() eq '51'}"> selected="selected" </c:if>>숙박비</option>
													<option value="61" <c:if test="${getMyCostList.getCost_class_no() eq '61'}"> selected="selected" </c:if>>회식대</option>
													<option value="71" <c:if test="${getMyCostList.getCost_class_no() eq '71'}"> selected="selected" </c:if>>식대</option>
													<option value="81" <c:if test="${getMyCostList.getCost_class_no() eq '81'}"> selected="selected" </c:if>>업무협의비</option>
													<option value="91" <c:if test="${getMyCostList.getCost_class_no() eq '91'}"> selected="selected" </c:if>>물품구입비</option>
													<option value="101" <c:if test="${getMyCostList.getCost_class_no() eq '101'}"> selected="selected" </c:if>>우편요금</option>
													<option value="111" <c:if test="${getMyCostList.getCost_class_no() eq '111'}"> selected="selected" </c:if>>통신료</option>
													<option value="121" <c:if test="${getMyCostList.getCost_class_no() eq '121'}"> selected="selected" </c:if>>문서발급비</option>
													<option value="131" <c:if test="${getMyCostList.getCost_class_no() eq '131'}"> selected="selected" </c:if>>수도광열비</option>
												</select>
												</td>
												<td style="width:;">
													<select id="cost_pay_type${status.index}">
														<option value="1" <c:if test="${getMyCostList.getCost_pay_type() eq '1'}"> selected="selected" </c:if>>카드</option>
														<option value="0" <c:if test="${getMyCostList.getCost_pay_type() eq '0'}"> selected="selected" </c:if>>현금</option>
													</select>
												</td>
												<td><input type="text" id="cost_bill_ea${status.index}" name="cost_bill_ea" value="${getMyCostList.getCost_bill_ea()}" style="width:20px"/>ea</td>
												<td><input type="text" id="cost_pay_amt${status.index}" name="cost_pay_amt" value="${getMyCostList.getCost_pay_amt()}"style="width:63px"/></td>
												<td><input type="text" id="cost_pay_place${status.index}" name="cost_pay_place" value="${getMyCostList.getCost_pay_place()}"style="width:85px"/></td>
												<td><input type="text" id="cost_involved_com${status.index}" name="cost_involved_com" value="${getMyCostList.getCost_involved_com()}"style="width:85px"/></td>
												<td><input type="text" id="cost_involved_man${status.index}" name="cost_involved_man" value="${getMyCostList.getCost_involved_man()}"style="width:85px"/></td>
												<td><input type="text" id="cost_memo${status.index}" name="cost_memo" value="${getMyCostList.getCost_memo()}"style="width:85px"/></td>
												<td>
													<c:if test="${getMyCostList.getCost_aprv_state() eq '0'}">청구</c:if>
													<c:if test="${getMyCostList.getCost_aprv_state() eq '1'}">팀장</c:if>
													<c:if test="${getMyCostList.getCost_aprv_state() eq '2'}">본부장</c:if>
													<c:if test="${getMyCostList.getCost_aprv_state() eq '3'}">승인</c:if>
												</td>
												<td><%-- <c:out value="${getMyCostList.getCost_deposit_amt()}"/> --%></td>
												<td>
													<input type="image" src="./resources/ls_img/btn_edit_s.gif" value="${status.index}" class="udtMyCost" alt="수정" style ="cursor:pointer" />
													<input type="image" src="./resources/ls_img/btn_del_s.gif" value="${status.index}" class="delMyCost" alt="삭제" style ="cursor:pointer" />
													<input type="hidden" id="cost_no${status.index}" name="cost_no" value="${getMyCostList.getCost_no()}"/>
													<input type="hidden" id="sum_cost_bill_ea" name="sum_cost_bill_ea" value="${getMyCostSum.sum_cost_bill_ea}"/>
													<input type="hidden" id="sum_cost_pay_amt" name="sum_cost_pay_amt" value="${getMyCostSum.sum_cost_pay_amt}"/>
												</td>
											</tr>
											</c:forEach>
											<tr>
												<td colspan="3"><b>합계</b></td>
												<td><c:out value="${getMyCostSum.sum_cost_bill_ea}"/>ea</td>
												<td><c:out value="${getMyCostSum.sum_cost_pay_amt}"/>원</td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
										</tbody>
										
									</table>
									<b><font color="red">※ 현금관련 영수증은 한장당 3만원 이상 불가 (병원영수증제외)</font></b>
							</div><!-- //tableStyle2 -->
							<br>
							<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 영수증 업로드</b>
							<div class= "tableStyle2">
						<!-- 현재 진행 상황 입력 --> 
						<c:set var="mycostListSize" value="${mycostListSize}"/>
							<table>
								<colgroup>
									<col width="60%">
									<col width="40%">
								</colgroup>
									<tr>
										<th>파일명</th>
										<th>등록일</th>
									</tr>
						<c:if test="${mycostListSize ne 0}">
								<tbody align="center" id = "MyCostBillFileList">
									<c:forEach items="${myCostBillFileList}" var="orgFileVo">
										<tr id = "MyCostBillFileOrgTr_${orgFileVo.getSerialNo()}">
											<td>
												<a href="myCostBillFileDownload?key=${orgFileVo.getSerialNo()}&type=rptOrigin&cost_deposit_no=${orgFileVo.getCost_deposit_no()}">
						        				   <font color="blue"> ${orgFileVo.getFileName()} </font>
						  					    </a>
											</td>
											<td>
												${orgFileVo.getRegDate()}
													<img src='./resources/ls_img/btn_del_s.gif' onclick="MyCostBillOrgFileDel('${orgFileVo.getSerialNo()}');" style='cursor:pointer; margin-left:5px;'/>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<tr>
									<td colspan="2" align="center">
										<%@include file="../include/uploadform_myCostBillFile.jsp"%>			
									</td>
								</tr>
						</c:if>
									
							</table>
							</div>
							<br>
							<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/> 협조건 내역</b>
							<div class= "tableStyle2">
								<table>
								 	<tbody>
									<tr>
										<th>구분</th>
										<th>의뢰팀</th>
										<th>의뢰인</th>
										<th>수임팀</th>
										<th>수임인</th>
										<th>보고서번호</th>
										<th>피보험자</th>
										<th>의뢰일</th>
										<th>완료일</th>
										<th>상태</th>
										<th>금액</th>
										<th>상세보기</th>
									</tr>
									<c:forEach items="${getMyHelpRptList}" var="clientVO">
									<tr>
										<td>의뢰</td>
										<td><c:out value="${clientVO.getClient_team_nm()}"/></td>
										<td><c:out value="${clientVO.getClient_id_nm()}"/></td>
										<td><c:out value="${clientVO.getAccept_team_nm()}"/></td>
										<td><c:out value="${clientVO.getAccept_id_nm()}"/></td>
										<td><c:out value="${clientVO.getSuim_accept_no()}"/></td>
										<td><c:out value="${clientVO.getBeneficiary_nm()}"/></td>
										<td><c:out value="${clientVO.getReg_date_fmt()}"/></td>
										<td><c:out value="${clientVO.getEnd_date_fmt()}"/></td>
										<td>
											<c:if test="${clientVO.getHelp_state() eq 1}">진행</c:if>
											<c:if test="${clientVO.getHelp_state() eq 2}">완료대기</c:if>
											<c:if test="${clientVO.getHelp_state() eq 3}">완료</c:if>
											<c:if test="${clientVO.getHelp_state() ne 1 && getMyHelpRptList.getHelp_state() ne 2 && getMyHelpRptList.getHelp_state() ne 3}">대기</c:if>
										</td>
										<td><c:out value="${clientVO.getPrice_total()}"/></td>
										<td><input type="image" src="./resources/ls_img/top_cost/btn_view.gif" onclick="viewhelpbtn(${clientVO.getSerial_no()})" /></td>
									</tr>
									</c:forEach>
									<tr>
										<td colspan="10">합계</td>
										<td><c:out value="${getMyHelpRptListSum.price_total}"/></td>
										<td></td>
									</tr>
									</tbody>
								</table>
							</div>
							<br>
							<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;"/> 의뢰건 내역</b>
							<div class= "tableStyle2">
								<table>
								 	<tbody>
									<tr>
										<th>구분</th>
										<th>의뢰팀</th>
										<th>의뢰인</th>
										<th>수임팀</th>
										<th>수임인</th>
										<th>보고서번호</th>
										<th>피보험자</th>
										<th>의뢰일</th>
										<th>완료일</th>
										<th>상태</th>
										<th>금액</th>
										<th>상세보기</th>
									</tr>
									<c:forEach items="${getMyHelpRptListAccept}" var="acceptVO">
									<tr>
										<td>수임</td>
										<td><c:out value="${acceptVO.getClient_team_nm()}"/></td>
										<td><c:out value="${acceptVO.getClient_id_nm()}"/></td>
										<td><c:out value="${acceptVO.getAccept_team_nm()}"/></td>
										<td><c:out value="${acceptVO.getAccept_id_nm()}"/></td>
										<td><c:out value="${acceptVO.getSuim_accept_no()}"/></td>
										<td><c:out value="${acceptVO.getBeneficiary_nm()}"/></td>
										<td><c:out value="${acceptVO.getReg_date_fmt()}"/></td>
										<td><c:out value="${acceptVO.getEnd_date_fmt()}"/></td>
										<td>
											<c:if test="${acceptVO.getHelp_state() eq 1}">진행</c:if>
											<c:if test="${acceptVO.getHelp_state() eq 2}">완료대기</c:if>
											<c:if test="${acceptVO.getHelp_state() eq 3}">완료</c:if>
											<c:if test="${acceptVO.getHelp_state() ne 1 && getMyHelpRptListClient.getHelp_state() ne 2 && getMyHelpRptListClient.getHelp_state() ne 3}">대기</c:if>
										</td>
										<td><c:out value="${acceptVO.getPrice_total()}"/></td>
										<td><input type="image" src="./resources/ls_img/top_cost/btn_view.gif" onclick="viewhelpbtn(${acceptVO.getSerial_no()})" /></td>
									</tr>
									</c:forEach>
									<tr>
										<td colspan="10">합계</td>
										<td><c:out value="${getMyHelpRptListAcceptSum.price_total}"/></td>
										<td></td>
									</tr>
									</tbody>
								</table>
							</div>
							
							
						</div><!-- //guestcnt4 -->
					</div>
					
					
					
				</div>
				<!-- //centercnt_bot -->

				<!-- banner -->
				<c:import url="../top_main/top_main_banner.jsp"></c:import>
				<!-- //banner -->

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
