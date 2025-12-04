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
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/jquery/jquery.mask.min.js"></script>
	<script src="./resources/cmm/js/common.js?v=201707311012"></script>
	
	
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
	
	<script src="./resources/ne_js/calendar.js"></script>
	<c:set var="rpt_invoice_no" value="${primBizInvDtl.getRpt_invoice_no()}"/>
	
	<script>
	$(document).ready(function(){
		
		$.ajaxSetup({cache:false});
		
		if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_8}' == 0){
			window.opener.location.assign("./logout");
			window.self.close();
		}
		
		
		if('${tabIdx}' != ''){
			window.opener.location.reload();
			if('${tabIdx}' == 'shareAdd'){
				alert("공동 조사자 추가를 성공 하였습니다.");
			}else if('${tabIdx}' == 'shareUdt'){
				alert("공동 조사자 수정을 성공 하였습니다.");
			}else if('${tabIdx}' == 'shareDel'){
				alert("공동 조사자 삭제를 성공 하였습니다.");
			}
			$("#shareTab").click();
		}

		
		
		$("#inveditsave").click(function(){

			/* if($("#tax_invoice_no").val().trim() == ''){
				alert("세금계산서 NO를 입력하세요.");
				$("#tax_invoice_no").focus();
				return;
			} */
			var tmp = window.confirm("수정 하시겠습니까?");
			if(tmp == false){
				return;
			}
			
			//공동수행 금액 체크로직 시작
			
			var amtBasicVal = $("#amtBasic").val().replace(/,/g,"");
			var amtDailyVal = $("#amtDaily").val().replace(/,/g,"");
			var amtEtcVal = $("#amtEtc").val().replace(/,/g,"");
			var amtTrafficVal = $("#amtTraffic").val().replace(/,/g,"");
			var amtCounselVal = $("#amtCounsel").val().replace(/,/g,"");
			var amtTotalVal = $("#amtTotal").val().replace(/,/g,"");
			
			if( $("#amtBasicSum").val() != amtBasicVal ){
				alert("인보이스의 기본보수와 공동조사자 기본보수의 합계가 다릅니다.");
				return;
			}else if( $("#amtDailySum").val() != amtDailyVal ){
				alert("인보이스의 일비와 공동조사자 일비의 합계가 다릅니다.");
				return;
			}else if( $("#amtEtcSum").val() != amtEtcVal ){
				alert("인보이스의 기타와 공동조사자 기타의 합계가 다릅니다.");
				return;
				
			}else if( $("#amtTrafficeSum").val() != amtTrafficVal ){
				alert("인보이스의 교통비와 공동조사자 교통비의 합계가 다릅니다.");
				return;
				
			}else if( $("#amtCounselSum").val() != amtCounselVal ){
				alert("인보이스의 자문료와 공동조사자 자문료의 합계가 다릅니다.");
				return;
				
			}else if( $("#amtTotalSum").val() != amtTotalVal ){
				alert("인보이스의 합계와와 공동조사자 합계 금액이 다릅니다.");
				return;
				
			}			
			//공동수행 금액 체크로직 끝
			
			//날짜 패턴 체크 시작
			var invoiceDateVal = $("#invoice_date").val();
			var depositDateVal = $("#deposit_date").val();
			var taxDateVal = $("#tax_date").val();
			
			if( invoiceDateVal != ''){
				if( !datePatternChk(invoiceDateVal) ){
					alert("제출일을 확인하세요. : "+invoiceDateVal);
					$("#invoice_date").focus();
					return;
				}	
			}
			
			if( depositDateVal != ''){
				if( !datePatternChk(depositDateVal) ){
					alert("입금일을 확인하세요. : "+depositDateVal);
					$("#deposit_date").focus();
					return;
				}	
			}				
							
			if( taxDateVal != ''){
				if( !datePatternChk(taxDateVal) ){
					alert("세금계산서 재발급일을 확인하세요. : "+taxDateVal);
					$("#tax_date").focus();
					return;
				}	
			}
			
			if('${primBizInvDtl.getAmt_total()}' != $("#amtTotal").val().replace(/,/g,"")){
				$("#edit_amt_cnt").val("1");
			}
			if(('${primBizInvDtl.invoice_date_fmt}' != $("#invoice_date").val())
					|| ('${primBizInvDtl.deposit_date_fmt}' != $("#deposit_date").val())
					|| ('${primBizInvDtl.tax_date_fmt}' != $("#tax_date").val())){
				$("#edit_date_cnt").val("1");
			}
			$.post("./primBizInvUdtOK",
					{
						rptInvNo					:$("#rpt_invoice_no").val()
						,taxNo        				:$("#tax_invoice_no").val()
						,invoiceDate           		:$("#invoice_date").val()
						,depositDate       			:$("#deposit_date").val()
						,taxDate    				:$("#tax_date").val()
						,amtBasic     				:amtBasicVal
						,amtBasicText   			:$("#amtBasicText").val()
						,amtDaily      				:amtDailyVal
						,amtDailyText        		:$("#amtDailyText").val()
						,amtEtc    					:amtEtcVal
						,amtEtcText   				:$("#amtEtcText").val()
						,amtTraffic  				:amtTrafficVal
						,amtTrafficText   			:$("#amtTrafficText").val()
						,amtCounsel   				:amtCounselVal
						,amtCounselText   			:$("#amtCounselText").val()
						,amtTotal					:amtTotalVal
						,memo   					:$("#rpt_invoice_memo").val()
						,editAmtYn   				:$("#edit_amt_cnt").val()
						,editDateYn   				:$("#edit_date_cnt").val()
						,suimRptNo	   				:$("#suim_rpt_no").val()
					},
					function(data,status){
						if(status == "success"){
							if(data == 0){
								alert("수정이 실패하였습니다. 관리자에게 문의해 주세요.");
							}else{
								alert("수정되었습니다.");
								//window.opener.location.assign("./topPtnrDTL?rpt_invoice_no=${rpt_invoice_no}");
								window.opener.location.reload();
								window.location.reload();
							}
						}else{
							alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
						}
					}//function
					
			);//post

		});//$("#popptnrsave").click
		
		$(".amt").blur(function(){
			var tmpSum = String(parseInt($("#amtBasic").val().replace(/,/g,""))
			+ parseInt($("#amtDaily").val().replace(/,/g,""))
			+ parseInt($("#amtTraffic").val().replace(/,/g,""))
			+ parseInt($("#amtCounsel").val().replace(/,/g,""))
			+ parseInt($("#amtEtc").val().replace(/,/g,"")));
			$("#amtTotal").val(tmpSum.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'));
		});//$("#amtBasic").blur
		

	});//ready
	
		function EnterSearch(){
			if (event.keyCode == 13){
		    	$("#inveditsave").click();
		    }
		}
	
		//세금계산서 담당자 수정창
		function modTaxMember(){
			$("#ptnr_tax_view").hide();
			$("#ptnr_tax_edit").show();			
		}
		
		//세금계산서 담당자 저장
		function saveTaxMember(p_ptnr_mbr_no){
			
			var url = "updatePtnrTaxMbr";
			
			var param = {};
			param.ptnr_mbr_no = p_ptnr_mbr_no;
			param.ptnr_tax_mbr_nm = $("#edit_ptnr_tax_nm").val();
			
			var tax_nm = "";
			
			$.ajax({
    	        type: "POST",
    	        url: url,
    	        data: param,
    	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    	        timeout: 20000,    	        
    	        dataType: "JSON", 
    	        success: function(data){
    	        	tax_nm = data.ptnr_tax_nm;    	        	
    	        	$("#ptnr_tax_nm_val").text(tax_nm);
    	        	$("#ptnr_tax_view").show();
    				$("#ptnr_tax_edit").hide();    	        	
    	        }
    	    });
		}
		
		//날짜 패턴을 (yyyy-mm-dd) 인지 확인하는 함수
		function datePatternChk( p_input ){
			
			var datePattern = /^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/;
			
			if( !datePattern.test(p_input) ){
				return false;
			}
			
			return true;
		}
	</script>
</head>
<c:set value="${ptnrMbr}" var="ptnrMbr"/>
<c:set value="${ptnrList}" var="ptnrList"/>
<body>
	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> INVOICE 수정 </span></b></font>
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
								<li class="on"><a href="#">농작물 INVOICE 수정</a></li>
								<li><a href="#">농작물 INVOICE 변경 LOG</a></li>
								<li id="shareTab"><a href="#">공동조사자 수정</a></li>
								<li><a href="#">공동조사자 변경 LOG</a></li>
							</ul>
						</div>
						
						<!-- 관련업체 멤버 정보 컨텐츠 탭 -->
						<div class="guestcnt5" style="display:block;">
						<c:set var="primBizInvDtl" value="${primBizInvDtl}"/>
						<div class= "tableStyle21 primBizInvTable" >
							<table cellpadding="0" cellspacing="0">
									<colgroup>
										<col width="12.5%" />
										<col width="12.5%" />
										<col width="12.5%" />
										<col width="12.5%" />
										<col width="12.5%" />
										<col width="12.5%" />
										<col width="13%" />
										<col width="12%" />
									</colgroup>
									<tr>
										<th>세금계산서 NO</th>
										<td colspan="7"><input type="text" id="tax_invoice_no" name="tax_invoice_no" onkeypress="EnterSearch();" value="${primBizInvDtl.getTax_invoice_no()}"/> 호
										 <font color="blue"> ( ※ 입금일 또는 세금계산서 재발급일이 있는 경우 자동으로 세금계산서 NO가 부여됩니다. )</font></td>
									</tr>
									<tr>
										<th>보험사</th>
										<td colspan="3"><c:out value="${primBizInvDtl.getPtnr_name()}"/></td>
										<th>담당자</th>
										<%-- <td colspan="3"><c:out value="${primBizInvDtl.getPtnr_mbr_name()}"/></td> --%>
										<td><c:out value="${primBizInvDtl.getPtnr_mbr_name()}"/></td>
										<th>세금계산서 담당자</th>
										<td>
											<div id="ptnr_tax_view">
												<span id="ptnr_tax_nm_val">${primBizInvDtl.getPtnr_tax_nm()}</span>
												<a href="javascript:modTaxMember();">
													<img src="resources/ls_img/ls_invoice/btn_s_edite.gif" style="cursor:pointer;">
												</a>
											</div>
											<div id="ptnr_tax_edit" style="display:none;">
												<input type="text" id="edit_ptnr_tax_nm" name="edit_ptnr_tax_nm" value="${primBizInvDtl.getPtnr_tax_nm()}" style="width:70px;"/>
												<a href="javascript:saveTaxMember(${primBizInvDtl.getPtnr_mbr_no()});">
													<img src="resources/ls_img/icon_disket.gif" style="cursor:pointer;">
												</a>
											</div>											
										</td>
									</tr>
									<tr>
										<th>담당부서</th>
										<td colspan="3"><c:out value="${primBizInvDtl.getTeam_name()}"/></td>
										<th>조사자</th>
										<td colspan="3"><c:out value="${primBizInvDtl.getUser_name()}"/></td>
									</tr>
									<tr>
										<th>계약자</th>
										<td colspan="3"><c:out value="${primBizInvDtl.getPolicyholder_nm()}"/></td>
										<th>피보험자</th>
										<td colspan="3"><c:out value="${primBizInvDtl.getBeneficiary_nm()}"/></td>
									</tr>
									<tr>
										<th>접수번호</th>
										<td><c:out value="${primBizInvDtl.getSuim_accept_no()}"/></td>
										<th>종결번호</th>
										<td><c:out value="${primBizInvDtl.getSuim_close_no()}"/></td>
										<th>사고번호</th>
										<td><c:out value="${primBizInvDtl.getAccident_no()}"/></td>
										<th>증권번호</th>
										<td><c:out value="${primBizInvDtl.getPolicy_no()}"/></td>
									</tr>
									<tr>
										<th>종결일</th>
										<td><c:out value="${primBizInvDtl.close_date_fmt}"/></td>
										<th>제출일</th>
										<td><input	type="text" class="classCalendar" id="invoice_date" name="invoice_date" onkeypress="EnterSearch();"
													value="${primBizInvDtl.invoice_date_fmt}" size="10" maxlength="10" /></td>
										<th>입금일</th>
										<td><input	type="text" class="classCalendar" id="deposit_date" name="deposit_date" onkeypress="EnterSearch();"
													value="${primBizInvDtl.deposit_date_fmt}" size="10" maxlength="10" /></td>
										<th>세금계산서재발급일</th>
										<td><input	type="text" class="classCalendar" id="tax_date" name="tax_date" onkeypress="EnterSearch();"
													value="${primBizInvDtl.tax_date_fmt}" size="10" maxlength="10" /></td>
									</tr>
									<tr>
										<th>기본보수</th>
										<td colspan="5"><input type="text" id="amtBasicText" name="amtBasicText" onkeypress="EnterSearch();" value="${primBizInvDtl.getAmt_basic_dtl()}" style="width:98%"/></td>
										<td colspan="2"><input type="text" id="amtBasic" name="amtBasic" onkeypress="EnterSearch();" value="<fmt:formatNumber value="${primBizInvDtl.getAmt_basic()}" pattern="###,###,##0.##"/>" class="amt" />원</td>
									</tr>
									<tr>
										<th>일비</th>
										<td colspan="5"><input type="text" id="amtDailyText" name="amtDailyText" onkeypress="EnterSearch();" value="${primBizInvDtl.getAmt_daily_dtl()}" style="width:98%"/></td>
										<td colspan="2"><input type="text" id="amtDaily" name="amtDaily" onkeypress="EnterSearch();" value="<fmt:formatNumber value="${primBizInvDtl.getAmt_daily()}" pattern="###,###,##0.##"/>" class="amt" />원</td>
									</tr>
									<tr>
										<th>교통비</th>
										<td colspan="5"><input type="text" id="amtTrafficText" name="amtTrafficText" onkeypress="EnterSearch();" value="${primBizInvDtl.getAmt_traffic_dtl()}" style="width:98%"/></td>
										<td colspan="2"><input type="text" id="amtTraffic" name="amtTraffic" onkeypress="EnterSearch();" value="<fmt:formatNumber value="${primBizInvDtl.getAmt_traffic()}" pattern="###,###,##0.##"/>" class="amt" />원</td>
									</tr>
									<tr>
										<th>자문료</th>
										<td colspan="5"><input type="text" id="amtCounselText" name="amtCounselText" onkeypress="EnterSearch();" value="${primBizInvDtl.getAmt_counsel_dtl()}" style="width:98%"/></td>
										<td colspan="2"><input type="text" id="amtCounsel" name="amtCounsel" onkeypress="EnterSearch();" value="<fmt:formatNumber value="${primBizInvDtl.getAmt_counsel()}" pattern="###,###,##0.##"/>" class="amt" />원</td>
									</tr>
									<tr>
										<th>기타</th>
										<td colspan="5"><input type="text" id="amtEtcText" name="amtEtcText" onkeypress="EnterSearch();" value="${primBizInvDtl.getAmt_etc_dtl()}" style="width:98%"/></td>
										<td colspan="2"><input type="text" id="amtEtc" name="amtEtc" onkeypress="EnterSearch();" value="<fmt:formatNumber value="${primBizInvDtl.getAmt_etc()}" pattern="###,###,##0.##"/>" class="amt" />원</td>
									</tr>
									<tr>
										<th>총합계</th>
										<td colspan="5">-</td>
										<td colspan="2"><input type="text" id="amtTotal" name="amtTotal" value='<fmt:formatNumber value="${primBizInvDtl.getAmt_total()}" pattern="###,###,##0.##"/>' readonly style="background-color:lightgrey;" />원
										<input type="hidden" id="rpt_invoice_no" name="rpt_invoice_no" value="${primBizInvDtl.getRpt_invoice_no()}"/>
										<input type="hidden" id="edit_amt_cnt" name="edit_amt_cnt" value="0"/>
										<input type="hidden" id="edit_date_cnt" name="edit_date_cnt" value="0"/>
										<input type="hidden" id="suim_rpt_no" name="suim_rpt_no" value="${primBizInvDtl.getSuim_rpt_no()}"/>
										</td>
									</tr>
									<tr>
										<th>비고</th>
										<td colspan="7"><textarea style="width:98%" rows="5" id="rpt_invoice_memo" name=""><c:out value="${primBizInvDtl.getRpt_invoice_memo()}"/></textarea></td>
									</tr>
							</table>
						</div><!-- //tableStyle4 -->
						<br>
						<p align="center">
							<img id="inveditsave" src="./resources/ls_img/icon_write.gif" alt="저장" style ="cursor:pointer" />
						</p>
						<!-- 합계 체크를 시작 -->						
						<c:forEach items="${primBizInvShareList}" var="primBizInvShareList" varStatus="status">
							<c:set var="amtBasicSum" value="${amtBasicSum + primBizInvShareList.getShare_amt_basic()}"></c:set>
							<c:set var="amtDailySum" value="${amtDailySum + primBizInvShareList.getShare_amt_daily()}"></c:set>
							<c:set var="amtEtcSum" value="${amtEtcSum + primBizInvShareList.getShare_amt_etc()}"></c:set>
							<c:set var="amtTrafficeSum" value="${amtTrafficeSum + primBizInvShareList.getShare_amt_traffic()}"></c:set>
							<c:set var="amtCounselSum" value="${amtCounselSum + primBizInvShareList.getShare_amt_counsel()}"></c:set>
							<c:set var="amtTotalSum" value="${amtTotalSum + primBizInvShareList.getShare_amt_total()}"></c:set>
							<c:set var="amtEaSum" value="${amtEaSum + primBizInvShareList.getShare_ea()}"></c:set>
						</c:forEach>
						<input type="hidden" id="amtBasicSum" name="amtBasicSum" value="${amtBasicSum}">
						<input type="hidden" id="amtDailySum" name="amtDailySum" value="${amtDailySum}">
						<input type="hidden" id="amtEtcSum" name="amtEtcSum" value="${amtEtcSum}">
						<input type="hidden" id="amtTrafficeSum" name="amtTrafficeSum" value="${amtTrafficeSum}">
						<input type="hidden" id=amtCounselSum name="amtCounselSum" value="${amtCounselSum}">
						<input type="hidden" id="amtTotalSum" name="amtTotalSum" value="${amtTotalSum}">
						<!-- 합계 체크를 끝 -->
						</div><!-- //guestcnt5 -->

						<div class="guestcnt5" style="display:none;">
							<c:import url="../top_prim_biz_inv/prim_biz_inv_log_list.jsp"></c:import>
						</div><!-- //guestcnt5 -->

						<div class="guestcnt5" style="display:none;">
							<c:import url="../top_prim_biz_inv/prim_biz_inv_share.jsp"></c:import>
						</div><!-- //guestcnt5 -->

						<div class="guestcnt5" style="display:none;">
							<c:import url="../top_prim_biz_inv/prim_biz_inv_share_log_list.jsp"></c:import>
						</div><!-- //guestcnt5 -->

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
