<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
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
	<script src="./resources/ne_js/calendar-rptinv.js"></script>
	<script src="./resources/ne_js/ne_number.js"></script>
	
	<script>
		$(document).ready(function(){
			
			$.ajaxSetup({cache:false});
			
			//5초에 한번씩 작업상태를 체크한다.
	    	setInterval(chkWorkState,5000);
			
			if('${mbrAuthVo_Session.user_no}' == null || '${mbrAuthVo_Session.mbr_pms_8}' == 0){
				window.opener.location.assign("./logout");
				window.self.close();
			}
			
			//작업중으로 상태 변경
			$("#work_ing").click( function(){
				
				var url = "updateInvoiceWorkState";
				
				var param = {};
				param.suim_rpt_no = $("#suimRptNo").val();
				param.user_no = $("#workUserNo").val();
				param.action_flag = "work_ing";
				
				$.ajax({
	    	        type: "POST",
	    	        url: url,
	    	        data: param,
	    	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	    	        timeout: 20000,    	        
	    	        dataType: "JSON", 
	    	        success: function(data){	    	        	
	    	        	//작업중으로 변경
	    	        	if( data.work_state == 1 ){
	    	        		$("#now_state_text").html("<font color='red'>작업중</font>");
	    	        		$("#now_work_user_text").text(data.work_user_nm);	    	        		
	    	        	}	    	        	    	        	
	    	        }
	    	    });
			});	
			
			//대기중으로 상태 변경
			$("#work_standby").click( function(){				
			
				var url = "updateInvoiceWorkState";
				
				var param = {};
				param.suim_rpt_no = $("#suimRptNo").val();
				param.user_no = $("#workUserNo").val();
				param.action_flag = "work_standby";
				
				$.ajax({
	    	        type: "POST",
	    	        url: url,
	    	        data: param,
	    	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	    	        timeout: 20000,    	        
	    	        dataType: "JSON", 
	    	        success: function(data){
	    	        	if( data.result == 9999 ){
	    	        		alert("현재 "+ data.work_user_nm +"님이 작업중입니다.\n작업자에게 문의하세요.");
	    	        		$("#work_ing").prop("checked",true);
	    	        	}else{
	    	        		$("#now_state_text").html("<font color='blue'>대기중</font>");
	    	        		$("#now_work_user_text").text('');	    	        		
	    	        	}	    	        	
	    	        }
	    	    });
			});
			
			$("#inveditsave").click(function(){
				
				//if($("#taxNo").val().trim() == ''){
				//	alert("세금계산서 NO를 입력하세요.");
				//	$("#taxNo").focus();
				//	return;
				//}
				
				//작업자 여부를 확인해서 저장할것인지를 확인한다.
				var chkFlag = doWorkChk();				
				
				if( !chkFlag ){					
					return;
				}
				
				//날짜 패턴 체크 시작
				var invoiceDateVal = $("#invoiceDate").val();
				var depositDateVal = $("#depositDate").val();
				var taxDateVal = $("#taxDate").val();
				
				if( invoiceDateVal != ''){
					if( !datePatternChk(invoiceDateVal) ){
						alert("제출일을 확인하세요. : "+invoiceDateVal);
						$("#invoiceDate").focus();
						return;
					}	
				}
				
				if( depositDateVal != ''){
					if( !datePatternChk(depositDateVal) ){
						alert("입금일을 확인하세요. : "+depositDateVal);
						$("#depositDate").focus();
						return;
					}	
				}				
								
				if( taxDateVal != ''){
					if( !datePatternChk(taxDateVal) ){
						alert("세금계산서 재발급일을 확인하세요. : "+taxDateVal);
						$("#taxDate").focus();
						return;
					}	
				}
				
				if('${invoiceDtl.getAmt_total()}' != $("#amtTotal").val().replace(/,/g,"")){
					$("#editAmtYn").val("1");
				}
				if(('${invoiceDtl.getInvoice_date_fmt()}' != $("#invoiceDate").val())
						|| ('${invoiceDtl.getDeposit_date_fmt()}' != $("#depositDate").val())
						|| ('${invoiceDtl.getTax_date_fmt()}' != $("#taxDate").val())){
					$("#editDateYn").val("1");
				}
				$.post("./rptInvUdtOK",
						{	rptInvNo          :$("#rptInvNo").val()
							,suimRptNo        :$("#suimRptNo").val()
							,editAmtYn        :$("#editAmtYn").val()
							,editDateYn       :$("#editDateYn").val()
							,taxNo            :$("#taxNo").val()
							,invoiceDate      :$("#invoiceDate").val()
							,depositDate      :$("#depositDate").val()
							,taxDate          :$("#taxDate").val()
							,amtBasicText     :$("#amtBasicText").val()
							,amtBasic         :$("#amtBasic").val().replace(/,/g,"")
							,amtDailyText     :$("#amtDailyText").val()
							,amtDaily         :$("#amtDaily").val().replace(/,/g,"")
							,amtTrafficText   :$("#amtTrafficText").val()
							,amtTraffic       :$("#amtTraffic").val().replace(/,/g,"")
							,amtCounselText   :$("#amtCounselText").val()
							,amtCounsel       :$("#amtCounsel").val().replace(/,/g,"")
							,amtEtcText       :$("#amtEtcText").val()
							,amtEtc           :$("#amtEtc").val().replace(/,/g,"")
							,memo             :$("#memo").val()
							,amtTotal		  :$("#amtTotal").val().replace(/,/g,"")
							,suimRptEa		  :$("#suimRptEa").val()
							
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("수정이 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									alert("수정이 완료 되었습니다.");
									window.opener.location.reload();
									window.self.close();
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
		
		function doWorkChk(){
			
			var url = "checkInvoiceWorkStateEnable";
			
			var sRet;
			
			var param = {};
			param.suim_rpt_no = $("#suimRptNo").val();
			param.user_no = $("#workUserNo").val();
			
			$.ajax({
    	        type: "POST",
    	        url: url,
    	        data: param,
    	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",    	             
    	        timeout: 20000,    	        
    	        dataType: "JSON",
    	        async: false,						//비동기로 처리
    	        success: function(data){
    	        	if( !data.result ){    	        	
    	        		alert("현재 "+ data.work_user_nm +"님이 작업중입니다.\n작업자에게 문의하세요.");
    	        		sRet = 0;
    	        	}else{
    	        		sRet = 1;
    	        	}
    	        }
    	    });
			return sRet;
		}
		
		//작업상태  체크 프로세스
		function chkWorkState(){						
			var url = "checkInvoiceWorkState";
			
			var param = {};
			param.suim_rpt_no = $("#suimRptNo").val();			
			
			$.ajax({
    	        type: "POST",
    	        url: url,
    	        data: param,
    	        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    	        timeout: 20000,    	        
    	        dataType: "JSON", 
    	        success: function(data){
    	        	if( data.work_state == 1 ){			//작업중인경우
    	        		$("#now_state_text").html("<font color='red'>작업중</font>");
    	        		$("#now_work_user_text").text(data.work_user_nm);
    	        		$("#work_ing").prop("checked",true);
    	        	}else{			//대기중인경우
    	        		$("#now_state_text").html("<font color='blue'>대기중</font>");
    	        		$("#now_work_user_text").text('');    	        		
    	        		$("#work_standby").prop("checked",true);
    	        	}
    	        }
    	    });
		}
		
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
<body>
	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> INVOICE 상세 </span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->
	
	<!-- center -->
	<div id ="container">
		<div class="contetnsPop">
			<div class="center_cnt">
				<div class="centercnt_bot1-3" style="height: 678px !important;">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">INVOICE 수정</a></li>
								<li><a href="#">INVOICE 로그</a></li>
							</ul>
						</div><!-- //guestTap -->

						<div class="guestcnt5" style="display:block; height: 600px;">
							<div class= "tableStyle21">
								<input type="hidden" id="rptInvNo" name="rptInvNo" value="${invoiceDtl.getRpt_invoice_no()}" />
								<input type="hidden" id="suimRptNo" name="suimRptNo" value="${invoiceDtl.getSuim_rpt_no()}" />
								<input type="hidden" id="editAmtYn" name="editAmtYn" value="0" />
								<input type="hidden" id="editDateYn" name="editDateYn" value="0" />
								<input type="hidden" id="workUserNo" name="workUserNo" value="${mbrAuthVo_Session.user_no}"/>								
								<table cellpadding="0" cellspacing="0">
									<colgroup>
										<col width="12%" />
										<col width="13%" />
										<col width="12%" />
										<col width="13%" />
										<col width="12%" />
										<col width="13%" />
										<col width="12%" />
										<col width="13%" />
									</colgroup>
									<!-- 동시작업 방지를 위한 작업자 설정시작 -->
									<tr>
										<th>현재상태</th>
										<td>
											<span id="now_state_text">
												<c:choose>
													<c:when test="${invoiceDtl.getWork_state() eq 1}">
														<font color="red">작업중</font>
													</c:when>
													<c:otherwise>
														<font color="blue">대기중</font>
													</c:otherwise>
												</c:choose>
											</span>
										</td>
										<th>작업자</th>
										<td>
											<span id="now_work_user_text">
												${invoiceDtl.getWork_user_nm()}
											</span>
										</td>
										<th>작업상태변경</th>
										<td colspan="3">
											<input type="radio" name="work_state" id="work_standby" value="0" <c:if test="${invoiceDtl.getWork_state() eq 0}">checked</c:if> />
											&nbsp;
											<font color="blue">대기중</font>											
											&nbsp;&nbsp;&nbsp;&nbsp;
											<input type="radio" name="work_state" id="work_ing" value="1" <c:if test="${invoiceDtl.getWork_state() eq 1}">checked</c:if> />
											&nbsp;
											<font color="red">작업중</font>
										</td>
									</tr>
									<tr>
										<th>세금계산서 NO</th>
										<td colspan="7"><input type="text" onkeyup="EnterSearch()" id="taxNo" name="taxNo" value="${invoiceDtl.getTax_invoice_no()}" style="ime-mode:active;"/> 호 
										 <font color="blue"> ( ※ 입금일 또는 세금계산서 재발급일이 있는 경우 자동으로 세금계산서 NO가 부여됩니다. )</font></td>
									</tr>
									<tr>
										<th>보험사</th>
										<td colspan="3"><c:out value="${invoiceDtl.getPtnr_name()}"/></td>
										<th>담당자</th>
										<td><c:out value="${invoiceDtl.getPtnr_mbr_name()}"/></td>
										<th>세금계산서 담당자</th>
										<td>
											<div id="ptnr_tax_view">
												<span id="ptnr_tax_nm_val">${invoiceDtl.getPtnr_tax_nm()}</span>
												<a href="javascript:modTaxMember();">
													<img src="resources/ls_img/ls_invoice/btn_s_edite.gif" style="cursor:pointer;">
												</a>
											</div>
											<div id="ptnr_tax_edit" style="display:none;">
												<input type="text" id="edit_ptnr_tax_nm" name="edit_ptnr_tax_nm" value="${invoiceDtl.getPtnr_tax_nm()}" style="width:85px;"/>
												<a href="javascript:saveTaxMember(${invoiceDtl.getPtnr_mbr_no()});">
													<img src="resources/ls_img/icon_disket.gif" style="cursor:pointer;">
												</a>
											</div>											
										</td>
									</tr>
									<tr>
										<th>담당부서</th>
										<td colspan="3"><c:out value="${invoiceDtl.getTeam_name()}"/></td>
										<th>조사자</th>
										<td colspan="3"><c:out value="${invoiceDtl.getUser_name()}"/></td>
									</tr>
									<tr>
										<th>계약자</th>
										<td colspan="3"><c:out value="${invoiceDtl.getPolicyholder_nm()}"/></td>
										<th>피보험자</th>
										<td colspan="3"><c:out value="${invoiceDtl.getBeneficiary_nm()}"/></td>
									</tr>
									<tr>
										<th>접수번호</th>
										<td style="letter-spacing:0" ><c:out value="${invoiceDtl.getSuim_accept_no()}"/></td>
										<th>종결번호</th>
										<td style="letter-spacing:0"><c:out value="${invoiceDtl.getSuim_close_no()}"/></td>
										<th>사고번호</th>
										<td style="letter-spacing:0"><c:out value="${invoiceDtl.getAccident_no()}"/></td>
										<th>증권번호</th>
										<td style="letter-spacing:0"><c:out value="${invoiceDtl.getPolicy_no()}"/></td>
									</tr>
									<tr>
										<th>종결일</th>
										<td style="letter-spacing:0"><c:out value="${invoiceDtl.getClose_date_fmt()}"/></td>
										<th>제출일</th>
										<td style="letter-spacing:0"><input	type="text" style="ime-mode:active;" onkeyup="EnterSearch()" class="classCalendar" id="invoiceDate" name="invoiceDate"
													value="${invoiceDtl.getInvoice_date_fmt()}" size="10" maxlength="10" /></td>
										<th>입금일</th>
										<td style="letter-spacing:0"><input	type="text" style="ime-mode:active;" onkeyup="EnterSearch()" class="classCalendar" id="depositDate" name="depositDate"
													value="${invoiceDtl.getDeposit_date_fmt()}" size="10" maxlength="10" /></td>
										<th style="letter-spacing: -1px;">세금계산서 재발급일</th>
										<td style="letter-spacing:0">
											<input	type="text" style="ime-mode:active;" onkeyup="EnterSearch()" class="classCalendar" id="taxDate" name="taxDate"
													value="${invoiceDtl.getTax_date_fmt()}" size="10" maxlength="10" />
										</td>
									</tr>
									<tr>
										<th>종결(평가)건수</th>
										<td style="letter-spacing: 0" colspan="7">
											<input type="text" style="ime-mode:active;" onkeyup="EnterSearch()" id="suimRptEa" name="suimRptEa"  size="5" value="${invoiceDtl.suim_rpt_ea}" />건										
										</td>
									</tr>
									<tr>
										<th>기본보수</th>
										<td colspan="5"><input type="text" id="amtBasicText" name="amtBasicText" value="${invoiceDtl.getAmt_basic_dtl()}" style="width:98%;ime-mode:active;"/></td>
										<td colspan="2">
											<input type="text" id="amtBasic" name="amtBasic"  
												   value='<fmt:formatNumber value="${invoiceDtl.getAmt_basic()}" pattern="###,###,##0.##"/>'
												   ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;" class="amt" />원
										</td>
									</tr>
									<tr>
										<th>일비</th>
										<td colspan="5"><input type="text" id="amtDailyText" name="amtDailyText" value="${invoiceDtl.getAmt_daily_dtl()}" style="width:98%;ime-mode:active;"/></td>
										<td colspan="2">
											<input type="text" id="amtDaily" name="amtDaily" 
								  				   value='<fmt:formatNumber value="${invoiceDtl.getAmt_daily()}" pattern="###,###,##0.##"/>' class="amt"
								  				   ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;" class="amt" />원
					  				   </td>
									</tr>
									<tr>
										<th>교통비</th>
										<td colspan="5"><input type="text" id="amtTrafficText" name="amtTrafficText" value="${invoiceDtl.getAmt_traffic_dtl()}" style="width:98%;ime-mode:active;"/></td>
										<td colspan="2">
											<input type="text" id="amtTraffic" name="amtTraffic" 
								  				   value='<fmt:formatNumber value="${invoiceDtl.getAmt_traffic()}" pattern="###,###,##0.##"/>' class="amt"
								  				   ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;" class="amt" />원
										</td>
									</tr>
									<tr>
										<th>자문료</th>
										<td colspan="5"><input type="text" id="amtCounselText" name="amtCounselText"value="${invoiceDtl.getAmt_counsel_dtl()}" style="width:98%;ime-mode:active;"/></td>
										<td colspan="2">
											<input type="text" id="amtCounsel" name="amtCounsel" 
								  				   value='<fmt:formatNumber value="${invoiceDtl.getAmt_counsel()}" pattern="###,###,##0.##"/>' class="amt"
								  				   ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;" class="amt" />원
										</td>
									</tr>
									<tr>
										<th>기타</th>
										<td colspan="5"><input type="text" id="amtEtcText" name="amtEtcText" value="${invoiceDtl.getAmt_etc_dtl()}" style="width:98%;ime-mode:active;"/></td>
										<td colspan="2">
											<input type="text" id="amtEtc" name="amtEtc" 
								  				   value='<fmt:formatNumber value="${invoiceDtl.getAmt_etc()}" pattern="###,###,##0.##"/>' class="amt"
								  				   ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);" style="IME-MODE: disabled;" class="amt" />원											
										</td>
									</tr>
									<tr>
										<th>총합계</th>
										<td colspan="5">-</td>
										<td colspan="2"><input type="text" id="amtTotal" name="amtTotal" value='<fmt:formatNumber value="${invoiceDtl.getAmt_total()}" pattern="###,###,##0.##"/>' readonly style="background-color:lightgrey;" />원
										</td>
									</tr>
									<tr>
										<th>비고</th>
										<td colspan="7"><textarea style="width:98%;" rows="5" id="memo" name="memo" style="ime-mode:active;"><c:out value="${invoiceDtl.getRpt_invoice_memo()}"/></textarea></td>
									</tr>
								</table>
							</div><!-- //tableStyle21 -->
							<p align="center" style="margin-top:10px;">
								<img id="inveditsave" src="./resources/ls_img/icon_write.gif" alt="저장" style ="cursor:pointer" />
							</p>
						</div><!-- //guestcnt5 -->

						<div class="guestcnt5" style="display:none;height: 600px;">
							<c:import url="../top_rpt_inv/top_rpt_inv_log_list.jsp"></c:import>
						</div><!-- //guestcnt5 -->

					</div><!-- //guest -->
				</div><!-- //bot1-3 -->
			</div>
		</div>
	</div>
	<!--//center -->

	<!-- footer -->
<%-- 	<c:import url="../top_main/top_pop_footer.jsp"></c:import> --%>
	<!-- //footer -->

</body>
