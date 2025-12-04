<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<link rel="stylesheet" type="text/css" href="./resources/wm_css/meritz_report.css?v=20171214"/>
<script type="text/javascript">
	$(document).ready(function(){
		_initDatePicker();		
	});
		
		

    function fnReportWord(){
        var cw=screen.availWidth;
        var ch=screen.availHeight;

        var sw=1000; //띄울 창의 넓이
        var sh=740;  //띄울 창의 높이

        var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
        var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치

        window.open('/meritz/reportMeritzInfo?suim_rpt_no='+'${param.suim_rpt_no}'+'&cmd=word','word','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
    }

    function fnReportPrint(){
        var cw=screen.availWidth;
        var ch=screen.availHeight;

        var sw=700; //띄울 창의 넓이
        var sh=550;  //띄울 창의 높이

        var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
        var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치

        window.open('/meritz/reportMeritzInfo?suim_rpt_no='+'${param.suim_rpt_no}'+'&cmd=print','print','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
    }
    
	/* DatePicker 적용 */
	function _initDatePicker(){
		$(".calendar").datepicker({ 
	    	   showOn: 'button',
	    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
	    	   buttonImageOnly: true,
	    	   buttonText: "달력", 
	    	   changeMonth: true,
	    	   changeYear: true,
	    	   showButtonPanel: false
	    });
		
		$(".calendar").keypress(function(){
	 		if (event.keyCode == 8){ 
	 			return false;
	 		}
			if($(this).val().length == 4 || $(this).val().length == 7){
				$(this).val($(this).val()+"-")
			}
		});
	}
</script>

<div class="reportWrap">
    <div class="reportContent">
        <input type="hidden" id="suim_rpt_no" value="${param.suim_rpt_no}">
        <input type="hidden" id="rpt_print_no" value="${rptBasic.rptPrintNo}">
        
        <div class="text-right">
            <a href="/meritz/reportMeritzInfo?suim_rpt_no=${param.suim_rpt_no}&cmd=word"><img src="./resources/ls_img/report/btn_word.gif"></a>
            <a href="#noloc" onclick="fnReportPrint()"><img src="./resources/ls_img/report/icon_print.gif"></a>
        </div>
        
        <div style="margin-top:30px;">
        	<div class="text-center" style="margin-bottom: 20px;">
        		<b><font size="5" color="BLACK">[종 결 보 고 서]</font></b>
        	</div>
       	</div>
       	
       	<div style="margin-top:30px;">
        	<div style="width: 10%; float:left;" > 
        		<p class="title">수신 : </p>
        		<p class="title">발신 : </p>
        	</div>
        	<div style="width: 29%; float:left;"> 
        		<p class="title" align="center">${reportBscInfo.ptnrName}</p>
        		<p class="title" align="center">탑손해사정 주식회사</p>
        	</div>
        	<div style="width: 30%; float:left;"> 
        		<p class="title" align="center">${reportBscInfo.ptnrDeptNm}</p>
        		<p class="title" align="center">${reportTeamInfo.teamName}</p>
        	</div>
        	<div style="width: 31%; float:left;"> 
        		<p class="title" align="center">${reportBscInfo.ptnrMbrNm}</p>
        		<p class="title" align="center">${reportInvgUser.userName} (${reportInvgUser.handphone})</p>
        	</div>
        	<div style="clear: both;"></div>
        </div>
        
        <div style="margin-top:15px;">
           	<div style="width: 33%; float:left;"> 
        		<p class="title" align="left">사고접수일 : ${reportBscInfo.accidentDate}</p>
        	</div>
        	
        	<div style="width: 33%; float:left;"> 
        		<p class="title" align="center">의뢰일시 : ${reportBscInfo.regDate}</p>
        	</div>
        	
        	<div style="width: 33%; float:left;"> 
        		<p class="title" align="right">
       				보고일자 : 
					<c:choose>
						<c:when test="${reportBscInfo.invoiceDate ne null }">
							<c:choose>
								<c:when test="${reportBscInfo.invoiceDate ne '' }">
									${reportBscInfo.invoiceDate }														
								</c:when>
								<c:otherwise>
									<font color="red">미제출 </font>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<font color="red">미제출 </font>
						</c:otherwise>
					</c:choose>
       			</p>
        	</div>
        	<table>
        		<colgroup>
        			<col width="12%" />
        			<col width="13%" />
        			<col width="12%" />
        			<col width="23%" />
        			<col width="12%" />
        			<col width="33%" />
	            </colgroup>
        		<tr>
        			<th>피보험자</th>
        			<td>${reportBscInfo.beneficiaryNm}</td>
        			<th>사고번호</th>
        			<td>${reportBscInfo.accidentNo}</td>
        			<th>조사담당</th>
        			<td>${reportInvgUser.userName}</td>
        		</tr>
        		<tr>
        			<th>주민번호</th>
        			<td colspan="3">${reportBscInfo.beneficiarySsn}</td>
        			<th>보상담당</th>
        			<td>${reportBscInfo.ptnrMbrNm}</td>
        		</tr>
        	</table>
        </div>	
        
        <section class="meritz_rpt_contract">
        	<h2>▣  계약사항</h2>
        	<div class="btnSpan">
                <a id="btn_cont_edit"	href="#noloc" onclick="fnContractEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
                <a id="btn_cont_save"	href="#noloc" onclick="fnContractSave();" style="display: none"><img src="./resources/ls_img/icon_write.gif"/></a>
                <a id="btn_cont_cancel"	href="#noloc" onclick="fnContractCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
       		</div>
       		<article id="meritz_rpt_contract_table">
				<table>
	       			<colgroup>
	        			<col width="30%" />
	        			<col width="14%" />
	        			<col width="16%" />
	        			<col width="16%" />
	        			<col width="12%" />
	        			<col width="12%" />
		            </colgroup>
		            <thead>
		            	<tr>
		            		<th>상품명</th>
		            		<th>증권번호</th>
		            		<th>보험시기</th>
		            		<th>보험종기</th>
		            		<th>계약자명</th>
		            		<th>계약상태</th>
		            	</tr>
		            </thead>
		            <tbody>
						<tr class="meritz_cont_view">
							<td>${reportBscInfo.insuranceNm}</td>
							<td>${reportBscInfo.policyNo}</td>
							<td>${rptBasic.insuPeriodS1}</td>
							<td>${rptBasic.insuPeriodE1}</td>
							<td>${reportBscInfo.policyholderNm}</td>
							<td>${rptBasic.contractState1}</td>
						</tr>		
						<tr class="meritz_cont_edit" style="display: none;">
							<td>
								${reportBscInfo.insuranceNm}
							</td>
							<td>
								${reportBscInfo.policyNo}
							</td>
							<td>
								<input type="text" id="insu_period_s" class="calendar" value="${rptBasic.insuPeriodS1}" />
							</td>
							<td>
								<input type="text" id="insu_period_e" class="calendar" value="${rptBasic.insuPeriodE1}"/>
							</td>
							<td>
								${reportBscInfo.policyholderNm}
							</td>
							<td>
								<input type="text" id="contract_state" value="${rptBasic.contractState1}" /> 
							</td>
						</tr>  
		            </tbody>
	        	</table>
	        </article>
        </section>
		<script type="text/javascript">
			//
			// 계약사항
			//
            function fnContractEdit(){
                $("#btn_cont_edit").hide();
                $("#btn_cont_save").show();
                $("#btn_cont_cancel").show();

                $(".meritz_cont_view").hide();
                $(".meritz_cont_edit").show();
            }
            
            function fnContractCancel() {
                $("#btn_cont_edit").show();
                $("#btn_cont_save").hide();
                $("#btn_cont_cancel").hide();

                $(".meritz_cont_view").show();
                $(".meritz_cont_edit").hide();
            }

            function fnContractSave() {
                var param = {};
                param.suim_rpt_no       = $("#suim_rpt_no").val();
                param.insu_period_s     = $("#insu_period_s").val();
                param.insu_period_e     = $("#insu_period_e").val();
                param.contract_state 	= $("#contract_state").val();
                
                var url = "/meritz/meritz_rpt_contract_update";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#meritz_rpt_contract_table").html(data); 
                        fnContractCancel();
                        _initDatePicker();
                    },
                    error: function(xhr, status, error){
                        if(xhr.status == "901"){
                            fnWinClose();
                        }else{
                            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                        }
                    },
                    beforeSend : function(xmlHttpRequest){
                        xmlHttpRequest.setRequestHeader("AJAX", "true");
                    }

                });
            }
		</script>	
        
        <section class="meritz_rpt_loss">
        	<h2>▣  손해사항</h2>
         	<div class="btnSpan">
                <a id="btn_loss_edit"	href="#noloc" onclick="fnLossEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
                <a id="btn_loss_save"	href="#noloc" onclick="fnLossSave();" style="display: none"><img src="./resources/ls_img/icon_write.gif"/></a>
                <a id="btn_loss_cancel"	href="#noloc" onclick="fnLossCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
       		</div>       	
        	<article id="meritz_rpt_loss_table">
        		<table>
        			<thead>
	        			<tr>
	        				<th>사고일자</th>
	        				<th>사고유형</th>
	        				<th colspan="2">진단명</th>
	        				<th>가입시<br/>직업급수</th>
	        				<th>사고시<br/>직업급수</th>
	        			</tr>
        			</thead>
        			<tbody>
        				<tr class="meritz_loss_view">
							<td>
								${rptBasic.accidentDate1}
							</td>
							<td>
								${rptBasic.accidentSumUp1}
							</td>
							<td>
								${fn:replace(fn:replace(rptBasic.diagnosisDisease1 , CRLF , '<br>'), ' ', '&nbsp;')}
							</td>
							<td>
								${fn:replace(fn:replace(rptBasic.diagnosisCode1 , CRLF , '<br>'), ' ', '&nbsp;')}
							</td>
							<td>
								${fn:replace(fn:replace(rptBasic.jobGradeJoin1 , CRLF , '<br>'), ' ', '&nbsp;')}
							</td>
							<td>
								${fn:replace(fn:replace(rptBasic.jobGradeAccident1 , CRLF , '<br>'), ' ', '&nbsp;')}
							</td>
						</tr>      
						<tr class="meritz_loss_edit" style="display:none;">
							<td>
								<input type="text" id="accident_date" class="calendar" value="${rptBasic.accidentDate1}" />
							</td>
							<td>
								<input type="text" id="accident_sum_up" value="${rptBasic.accidentSumUp1}" /> 
							</td>
							<td>
								<textarea id="diagnosis_disease" placeholder="진단 병명" rows="5">${fn:replace(fn:replace(rptBasic.diagnosisDisease1 , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
							</td>
							<td>
								<textarea id="diagnosis_code" placeholder="진단 코드" rows="5">${fn:replace(fn:replace(rptBasic.diagnosisCode1 , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
							</td>
							<td>
								<textarea id="job_grade_join" rows="5">${fn:replace(fn:replace(rptBasic.jobGradeJoin1 , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
							</td>
							<td>
								<textarea id="job_grade_accident" rows="5">${fn:replace(fn:replace(rptBasic.jobGradeAccident1 , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
							</td>
						</tr>
        			</tbody>
        		</table>
        		
        		<table>
        			<colgroup>
        				<col width="33%"/>
        				<col width="33%"/>
        				<col width="33%"/>
        			</colgroup>
        			<thead>
	        			<tr>
	        				<th>담보내용</th>
	        				<th>보험가입금액</th>
	        				<th>추정손해액</th>
	        			</tr>
        			</thead>
        			<tbody>
        				<tr class="meritz_loss_view">
        					<td>
        						${fn:replace(fn:replace(rptBasic.insuMortgageDtl1 , CRLF , '<br>'), ' ', '&nbsp;')}
        					</td>
        					<td>
        						${fn:replace(fn:replace(rptBasic.amtTotInsu1 , CRLF , '<br>'), ' ', '&nbsp;')}
        					</td>
        					<td>
        						${fn:replace(fn:replace(rptBasic.amtEstimatedDmgDtl1 , CRLF , '<br>'), ' ', '&nbsp;')}
        					</td>
        				</tr>
        				<tr class="meritz_loss_view">
        					<th colspan="2">
        						합 계
        					</th>
        					<td>
        						${rptBasic.amtEstimatedDmgDtl1}
        					</td>
        				</tr>
        				<tr class="meritz_loss_edit" style="display:none;">
        					<td>
        						<textarea id="insu_mortgage_dtl" rows="5" >${fn:replace(fn:replace(rptBasic.insuMortgageDtl1 , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
        					</td>
        					<td>
        						<textarea id="amt_tot_insu" rows="5">${fn:replace(fn:replace(rptBasic.amtTotInsu1 , '<br>', CRLF), ' ', '&nbsp;')} </textarea>        					
        					</td>
        					<td>
								<textarea id="amt_estimated_dmg_dtl" rows="5">${fn:replace(fn:replace(rptBasic.amtEstimatedDmgDtl1 , '<br>', CRLF), ' ', '&nbsp;')}</textarea> 	
        					</td>
        				</tr>
        			</tbody>
        		</table>
        	</article>
        </section>
  		<script type="text/javascript">
  			//
  			// 손해사항
  			//
            function fnLossEdit(){
                $("#btn_loss_edit").hide();
                $("#btn_loss_save").show();
                $("#btn_loss_cancel").show();

                $(".meritz_loss_view").hide();
                $(".meritz_loss_edit").show();
            }
            
            function fnLossCancel() {
                $("#btn_loss_edit").show();
                $("#btn_loss_save").hide();
                $("#btn_loss_cancel").hide();

                $(".meritz_loss_view").show();
                $(".meritz_loss_edit").hide();
            }

            function fnLossSave() {
                var param = {};
                param.suim_rpt_no       = $("#suim_rpt_no").val();
                param.accident_date     = $("#accident_date").val();
                param.accident_sum_up     = $("#accident_sum_up").val();
                
                param.diagnosis_disease 	= $("#diagnosis_disease").val().replace(/\n/g, "\r\n");
                param.diagnosis_code 	= $("#diagnosis_code").val().replace(/\n/g, "\r\n");
                param.job_grade_join 	= $("#job_grade_join").val().replace(/\n/g, "\r\n");
                param.job_grade_accident 	= $("#job_grade_accident").val().replace(/\n/g, "\r\n");
                param.insu_mortgage_dtl    = $("#insu_mortgage_dtl").val().replace(/\n/g, "\r\n");
                param.amt_tot_insu       	= $("#amt_tot_insu").val().replace(/\n/g, "\r\n");
                param.amt_estimated_dmg_dtl = $("#amt_estimated_dmg_dtl").val().replace(/\n/g, "\r\n");
                
                var url = "/meritz/meritz_rpt_loss_update";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#meritz_rpt_loss_table").html(data); 
                        fnLossCancel();
                        _initDatePicker();
                    },
                    error: function(xhr, status, error){
                        if(xhr.status == "901"){
                            fnWinClose();
                        }else{
                            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                        }
                    },
                    beforeSend : function(xmlHttpRequest){
                        xmlHttpRequest.setRequestHeader("AJAX", "true");
                    }

                });
            }
		</script>

        <section class="meritz_rpt_inquiry">
        	<h2>▣  청구내용 및 조사결과</h2>
       		<article id="meritz_rpt_inquiry_table">
       			<table>
	               	<colgroup>
	                    <col width="20%" />
	                    <col width="16%" />
	                    <col width="20%" />
	                    <col width="15%" />
	                    <col width="20%" />
	                    <col width="9%" />
	                </colgroup>
					<tr id="meritz_claim_view">
						<th>청구 내용</th>
						<td colspan="4" style="padding:10px;">
							${fn:replace(fn:replace(rptBasic.claimDtl2 , CRLF , '<br>'), ' ', '&nbsp;')}
						</td>
						<td>
							<a id="btn_claim_edit" href="#noloc" onclick="fnClaimEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
						</td>
					</tr>
					
					<tr id="meritz_claim_edit" style="display: none;">
						<th>청구 내용</th>
						<td colspan="4">
							<select id="select_claim_code" style="margin-bottom: 5px;" onchange="fnClaimCodeChange(this);" >
                            	<option value="">직접입력</option>
	                            <c:forEach var="item" items="${claimCodeList}" varStatus="status">
	                                <option value="${item.colVal}">${item.colVal}</option>
	                            </c:forEach>
                        	</select>
                        	<textarea id="claim_dtl" style="height: 150px;">${fn:replace(fn:replace(rptBasic.claimDtl2 , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
						</td>
						
						<td>
                        	<a id="btn_claim_save" href="#noloc" onclick="fnClaimSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        	<a id="btn_claim_close" href="#noloc" onclick="fnClaimClose();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
						</td>
					</tr>

					<tr id="meritz_complaint_avoid_view">
						<th>민원예방활동</th>
						<td colspan="4" style="padding:10px;">
							${fn:replace(fn:replace(rptBasic.complaintAvoidActivity2 , CRLF , '<br>'), ' ', '&nbsp;')}
						</td>
						<td>
							<a id="btn_complaint_avoid_edit" href="#noloc" onclick="fnComplaintAvoidEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
						</td>
					</tr>
					
					<tr id="meritz_complaint_avoid_edit" style="display: none;">
						<th>민원예방활동</th>
						<td colspan="4">
                        	<textarea id="complaint_avoid_activity" style="height: 150px;">${fn:replace(fn:replace(rptBasic.complaintAvoidActivity2 , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
						</td>
						
						<td>
                        	<a id="btn_complaint_avoid_save" href="#noloc" onclick="fnComplaintAvoidSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        	<a id="btn_complaint_avoid_close" href="#noloc" onclick="fnComplaintAvoidClose();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
						</td>
					</tr>

					<tr class="meritz_result_view">
						<th rowspan="2">조사자의견<br/>및<br/>조사결과</th>
						<td colspan="4" style="padding:10px;">
							${fn:replace(fn:replace(rptBasic.inspectResult2 , CRLF , '<br>'), ' ', '&nbsp;')}
						</td>
						<td rowspan="2">
							<a id="btn_result_edit" href="#noloc" onclick="fnResultEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
						</td>
					</tr>
					<tr class="meritz_result_view">
						<th>
							계약 유지
						</th>
						<td>
							${rptBasic.contractKeepYn2}
						</td>
						<th>
							민원 여부
						</th>
						<td>
							${rptBasic.minwonDtl2}
						</td>
					</tr>
					
										
					<tr class="meritz_result_edit" style="display: none;">
						<th rowspan="2">조사자의견<br/>및<br/>조사결과</th>
						<td colspan="4">
							<select id="select_result_code" style="margin-bottom: 5px;" onchange="fnResultCodeChange(this);" >
                            	<option value="">직접입력</option>
	                            <c:forEach var="item" items="${resultCodeList}" varStatus="status">
	                                <option value="${item.colVal}">${item.colVal}</option>
	                            </c:forEach>
                        	</select>
                        	<textarea id="inspect_result" style="height: 150px;">${fn:replace(fn:replace(rptBasic.inspectResult2 , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
						</td>
						<td rowspan="2">
                        	<a id="btn_result_save" href="#noloc" onclick="fnResultSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        	<a id="btn_result_close" href="#noloc" onclick="fnResultClose();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
						</td>
					</tr>
					<tr class="meritz_result_edit" style="display: none;">
						<th>
							계약 유지
						</th>
						<td>
							<input type="text" id="contract_keep_yn" value="${rptBasic.contractKeepYn2}" />
						</td>
						<th>
							민원 여부
						</th>
						<td>
							<input type="text" id="minwon_dtl" value="${rptBasic.minwonDtl2}" />
						</td>
					</tr>					
       			</table>
       		</article>
       	</section>        
       	<script>
       		//
       		// 청구내용
       		//
       		function fnClaimEdit(){
       			$("#meritz_claim_view").hide();
       			$("#meritz_claim_edit").show();
       		}
       		
       		function fnClaimClose(){
       			$("#meritz_claim_view").show();
       			$("#meritz_claim_edit").hide();    
       		}
       		
       		function fnClaimSave(){
       			var param = {};
       			param.suim_rpt_no 		= $("#suim_rpt_no").val();
                param.claim_dtl			= $("#claim_dtl").val().replace(/\n/g, "\r\n");
       			
                var url = "/meritz/meritz_rpt_claim_update";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#meritz_rpt_inquiry_table").html(data); 
                        fnClaimClose();
                    },
                    error: function(xhr, status, error){
                        if(xhr.status == "901"){
                            fnWinClose();
                        }else{
                            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                        }
                    },
                    beforeSend : function(xmlHttpRequest){
                        xmlHttpRequest.setRequestHeader("AJAX", "true");
                    }
                });
       		}
       		
       		function fnClaimCodeChange(that){
                if (that.value != ""){
                    $("#claim_dtl").val($("#claim_dtl").val() + that.value + '\n');
                }
                $("#claim_dtl").focus();
       		}	
       		
       		//
       		// 민원예방활동
       		//
       		function fnComplaintAvoidEdit(){
       			$("#meritz_complaint_avoid_view").hide();
       			$("#meritz_complaint_avoid_edit").show();
       		}
       		
       		function fnComplaintAvoidClose(){
       			$("#meritz_complaint_avoid_view").show();
       			$("#meritz_complaint_avoid_edit").hide();    
       		}
       		
       		function fnComplaintAvoidSave(){
       			var param = {};
       			param.suim_rpt_no 				= $("#suim_rpt_no").val();
                param.complaint_avoid_activity	= $("#complaint_avoid_activity").val().replace(/\n/g, "\r\n");
                
                var url = "/meritz/meritz_rpt_complaint_aviod_update";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#meritz_rpt_inquiry_table").html(data); 
                        fnComplaintAvoidClose();
                    },
                    error: function(xhr, status, error){
                        if(xhr.status == "901"){
                            fnWinClose();
                        }else{
                            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                        }
                    },
                    beforeSend : function(xmlHttpRequest){
                        xmlHttpRequest.setRequestHeader("AJAX", "true");
                    }
                });
       		}
       		
       		
       		//
       		// 조사자의견 및 조사결과
       		//
       		function fnResultEdit(){
       			$(".meritz_result_view").hide();
       			$(".meritz_result_edit").show();
       		}
       		
       		function fnResultClose(){
       			$(".meritz_result_view").show();
       			$(".meritz_result_edit").hide();    
       		}
       		
       		function fnResultSave(){
       			var param = {};
    			param.suim_rpt_no 		= $("#suim_rpt_no").val();
                param.inspect_result	= $("#inspect_result").val().replace(/\n/g, "\r\n");
                param.contract_keep_yn 	= $("#contract_keep_yn").val();
                param.minwon_dtl 	= $("#minwon_dtl").val();
               
                var url = "/meritz/meritz_rpt_result_update";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#meritz_rpt_inquiry_table").html(data); 
                        fnResultClose();
                    },
                    error: function(xhr, status, error){
                        if(xhr.status == "901"){
                            fnWinClose();
                        }else{
                            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                        }
                    },
                    beforeSend : function(xmlHttpRequest){
                        xmlHttpRequest.setRequestHeader("AJAX", "true");
                    }
                });
       		}    
       		
       		function fnResultCodeChange(that){
                if (that.value != ""){
                    $("#inspect_result").val($("#inspect_result").val() + that.value + '\n');
                }
                $("#inspect_result").focus();
       		}	
       		
       	</script>

        <section class="meritz_rpt_confirm_by_date">
        	<h2>▣  조사자 일자별 확인사항</h2>
       		<article id="meritz_rpt_confirm_by_date_table">
				<table>
       				<colgroup>
       					<col width="20%" />
       					<col width="51%" />
       					<col width="20%" />
       					<col width="9%" />
       				</colgroup>
       				<thead>
       					<tr>
	       					<th>일자</th>
	       					<th>확인내용</th>
	       					<th>관련기관</th>
	       					<th>비고</th>
       					</tr>
       				</thead>
       				<tbody>
       					<tr>
       						<th colspan="4">
       							계약전
       							<img src="./resources/ls_img/btn_add_s.gif" title="계약 전 사항 추가" style="cursor:pointer; vertical-align:middle;" id="bef_confirm_add_btn" onclick="fnConfirmAdd('bef');"/>  
     						</th>
       					</tr>
       					
       					<tr id="bef_add_tr" style="display:none;border:2px solid #8a8a8a;">
       						<td style="text-align: center">
      							<input type="text" class="calendar" id="bef_to_date_add" /> ~ <br/>
      							&nbsp;&nbsp;&nbsp;<input type="text" class="calendar" id="bef_from_date_add" /><br/>
      							<input type="radio" name="bef_confirm_date_gubun_add" onclick="fnSetConfirmDateDtl('bef',1,'add')" id="bef_confirm_date_gubun1_add" value="1">입원
      							<input type="radio" name="bef_confirm_date_gubun_add" onclick="fnSetConfirmDateDtl('bef',2,'add')" id="bef_confirm_date_gubun2_add" value="2">통원
      							<input type="text" id="bef_date_dtl_add" value=""/> 
       						</td>
       						<td>
       						    <%
		                            String preTextAreaAddText = "- 내원경위 : \n- 검사사항 : \n- 진단병명 : \n- 치료사항 : \n";
		                        %>
       							<textarea rows="8" id="bef_confirm_dtl_add"><%=preTextAreaAddText %></textarea>	
       						</td>
       						<td style="text-align: center">
       							<textarea rows="8" id="bef_relative_organ_add" ></textarea>
       						</td>
       						<td>
                       			<a id="btn_bef_confirm_save_add" href="#noloc" onclick="fnConfirmSave('bef','add','C');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        		<a id="btn_bef_confirm_close_add" href="#noloc" onclick="fnConfirmClose('bef');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
       						</td>
       					</tr>
       					
       					<c:forEach items="${rptConfirm}" var="confirmList" varStatus="rcStatus">
	       					<c:if test="${confirmList.contractBa == 1}">
		       					<tr id="bef_confirm_view_${rcStatus.index}" >
		       						<!-- 일자 -->
									<td style="text-align: center">
										${confirmList.confirmToDate}
										<c:if test="${confirmList.confirmFromDate ne NULL and confirmList.confirmFromDate ne ''}">
											<br/>~
											${confirmList.confirmFromDate}
										</c:if>
										<c:if test="${confirmList.confirmGubunTxt ne NULL and confirmList.confirmGubunTxt ne ''}">
											<br/>
											(${confirmList.confirmGubunTxt})
										</c:if>									
									</td>
									<!-- 확인내용 -->
									<td>
										${fn:replace(fn:replace(confirmList.confirmDtl , CRLF , '<br>'), ' ', '&nbsp;')}
									</td>
									<!-- 관련기관 -->
									<td style="text-align: center">
										${fn:replace(fn:replace(confirmList.relativeOrgan , CRLF , '<br>'), ' ', '&nbsp;')}
									</td>
									<!-- 비고 - 버튼 -->
									<td>
										<a id="btn_bef_confirm_edit_${rcStatus.index}" href="#noloc" onclick="fnConfirmEdit('bef',${rcStatus.index});"><img src="./resources/ls_img/btn_edite.gif"/></a>
									</td>
		       					</tr>
		       					
		       					<tr id="bef_confirm_edit_${rcStatus.index}" style="display:none;">
		       						<td style="text-align: center">
		      							<input type="text" class="calendar" id="bef_to_date_${rcStatus.index}" value="${confirmList.confirmToDate}" /> ~ <br/>
		      							&nbsp;&nbsp;&nbsp;<input type="text" class="calendar" id="bef_from_date_${rcStatus.index}" value="${confirmList.confirmFromDate}"/><br/>
		      							<input type="radio" name="bef_confirm_date_gubun_${rcStatus.index}" onclick="fnSetConfirmDateDtl('bef',1,${rcStatus.index})" id="bef_confirm_date_gubun1_${rcStatus.index}"  <c:if test="${confirmList.confirmGubun eq '1'}">checked="checked"</c:if> value="1">입원
		      							<input type="radio" name="bef_confirm_date_gubun_${rcStatus.index}" onclick="fnSetConfirmDateDtl('bef',2,${rcStatus.index})" id="bef_confirm_date_gubun2_${rcStatus.index}"  <c:if test="${confirmList.confirmGubun eq '2'}">checked="checked"</c:if> value="2">통원
		      							<input type="text" id="bef_date_dtl_${rcStatus.index}" value="${confirmList.confirmGubunTxt}"/> 
		       						</td>
		       						
		       						<td>
		       							<textarea rows="8" id="bef_confirm_dtl_${rcStatus.index}">${fn:replace(fn:replace(confirmList.confirmDtl , '<br>', CRLF), ' ', '&nbsp;')}</textarea>	
		       						</td>
		       						
		       						<td style="text-align: center">
		       							<textarea rows="8" id="bef_relative_organ_${rcStatus.index}">${fn:replace(fn:replace(confirmList.relativeOrgan , '<br>', CRLF), ' ', '&nbsp;')}</textarea>	
		       						</td>
		       						
		       						<td>
		       							<input type="hidden" id="bef_c_serial_no_${rcStatus.index}" value="${confirmList.serialNo}" />
		                       			<a id="btn_bef_confirm_save_${rcStatus.index}" href="#noloc" onclick="fnConfirmSave('bef',${rcStatus.index},'U');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
										<a id="btn_bef_confirm_del_${rcStatus.index}" href="#noloc" onclick="fnConfirmDelete('bef',${rcStatus.index},'D');"><img src='./resources/ls_img/btn_del.gif' style="margin-top: 5px;"></a>		                       			
		                        		<a id="btn_bef_confirm_close_${rcStatus.index}" href="#noloc" onclick="fnConfirmCancel('bef',${rcStatus.index});"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		       						</td>								       						
		       					</tr>
	       					</c:if>
       					</c:forEach>
       				</tbody>
       				
       				<tbody>
       					<tr>
       						<th colspan="4">
       							계약일
       							<img src="./resources/ls_img/btn_add_s.gif" title="계약 일 사항 추가" style="cursor:pointer; vertical-align:middle;" id="day_confirm_add_btn" onclick="fnConfirmAdd('day');"/>  
     						</th>
       					</tr>
       					
       					<tr id="day_add_tr" style="display:none;border:2px solid #8a8a8a;">
       						<td style="text-align: center">
      							<input type="text" class="calendar" id="day_to_date_add" />
      							
       						</td>
       						<td>
       							<textarea rows="8" id="day_confirm_dtl_add"></textarea>	
       						</td>
       						<td style="text-align: center">
       							메리츠 화재보험
       							<input type="hidden" id="bef_relative_organ_add" value="메리츠 화재보험" />
       						</td>
       						<td>
       							<input type="hidden" id="day_relative_organ_add" value="메리츠 화재보험" />
                       			<a id="btn_day_confirm_save_add" href="#noloc" onclick="fnConfirmSave('day','add','C');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        		<a id="btn_day_confirm_close_add" href="#noloc" onclick="fnConfirmClose('day');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
       						</td>
       					</tr>
       					
       					<c:forEach items="${rptConfirm}" var="confirmList" varStatus="rcStatus">
       						<c:if test="${confirmList.contractBa == 2}">
		       					<tr id="day_confirm_view_${rcStatus.index}" >
		       						<!-- 일자 -->
									<td style="text-align: center">
										${confirmList.confirmToDate}
									</td>
									<!-- 확인내용 -->
									<td style="text-align: center;">
										${fn:replace(fn:replace(confirmList.confirmDtl , CRLF , '<br>'), ' ', '&nbsp;')}
									</td>
									<!-- 관련기관 -->
									<td style="text-align: center">
										${confirmList.relativeOrgan}
									</td>									
									<!-- 비고 - 버튼 -->
									<td>
										<a id="btn_day_confirm_edit_${rcStatus.index}" href="#noloc" onclick="fnConfirmEdit('day',${rcStatus.index});"><img src="./resources/ls_img/btn_edite.gif"/></a>
									</td>
		       					</tr>
		       					
		       					<tr id="day_confirm_edit_${rcStatus.index}" style="display:none;">
		       						<td style="text-align: center">
		      							<input type="text" class="calendar" id="day_to_date_${rcStatus.index}" value="${confirmList.confirmToDate}" />
		       						</td>
		       						<td>
		       							<textarea rows="8" id="day_confirm_dtl_${rcStatus.index}">${confirmList.confirmDtl}</textarea>	
		       						</td>
		       						<td style="text-align: center">
		       							메리츠 화재보험
		       							<input type="hidden" id="day_relative_organ_${rcStatus.index}" value="${confirmList.relativeOrgan}" />
		       						</td>		       						
		       						<td>
		       							<input type="hidden" id="day_c_serial_no_${rcStatus.index}" value="${confirmList.serialNo}" />
		       							<input type="hidden" id="day_relative_organ_${rcStatus.index}" value="메리츠 화재보험" />
		                       			<a id="btn_day_confirm_save_${rcStatus.index}" href="#noloc" onclick="fnConfirmSave('day',${rcStatus.index},'U');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                       			<a id="btn_day_confirm_del_${rcStatus.index}" href="#noloc" onclick="fnConfirmDelete('day',${rcStatus.index},'D');"><img src='./resources/ls_img/btn_del.gif' style="margin-top: 5px;"></a>
		                        		<a id="btn_day_confirm_close_${rcStatus.index}" href="#noloc" onclick="fnConfirmCancel('day',${rcStatus.index});"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		       						</td>								       						
		       					</tr>
		       				</c:if>
       					</c:forEach>
       				</tbody>
       				<tbody>
       					<tr>
       						<th colspan="4">
       							계약후
       							<img src="./resources/ls_img/btn_add_s.gif" title="계약 후 사항 추가" style="cursor:pointer; vertical-align:middle;" id="aft_confirm_add_btn" onclick="fnConfirmAdd('aft');"/>  
     						</th>
       					</tr>
       					
       					<tr id="aft_add_tr" style="display:none;border:2px solid #8a8a8a;">
       						<td style="text-align: center">
      							<input type="text" class="calendar" id="aft_to_date_add" /> ~ <br/>
      							&nbsp;&nbsp;&nbsp;<input type="text" class="calendar" id="aft_from_date_add" /><br/>
      							<input type="radio" name="aft_confirm_date_gubun_add" onclick="fnSetConfirmDateDtl('aft',1,'add')" id="aft_confirm_date_gubun1_add" value="1">입원
      							<input type="radio" name="aft_confirm_date_gubun_add" onclick="fnSetConfirmDateDtl('aft',2,'add')" id="aft_confirm_date_gubun2_add" value="2">통원
      							<input type="text" id="aft_date_dtl_add" value=""/> 
       						</td>
       						<td>
       							<textarea rows="8" id="aft_confirm_dtl_add"><%=preTextAreaAddText %></textarea>	
       						</td>
       						<td style="text-align: center">
       							<textarea rows="8" id="aft_relative_organ_add"></textarea>	
       						</td>
       						<td>
                       			<a id="btn_aft_confirm_save_add" href="#noloc" onclick="fnConfirmSave('aft','add','C');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        		<a id="btn_aft_confirm_close_add" href="#noloc" onclick="fnConfirmClose('aft');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
       						</td>
       					</tr>
       					
       					<c:forEach items="${rptConfirm}" var="confirmList" varStatus="rcStatus">
       						<c:if test="${confirmList.contractBa == 3}">
		       					<tr id="aft_confirm_view_${rcStatus.index}" >
		       						<!-- 일자 -->
									<td style="text-align: center">
										${confirmList.confirmToDate}
										<c:if test="${confirmList.confirmFromDate ne NULL and confirmList.confirmFromDate ne ''}">
											<br/>~
											${confirmList.confirmFromDate}
										</c:if>
										<c:if test="${confirmList.confirmGubunTxt ne NULL and confirmList.confirmGubunTxt ne ''}">
											<br/>
											(${confirmList.confirmGubunTxt})
										</c:if>									
									</td>
									<!-- 확인내용 -->
									<td>
										${fn:replace(fn:replace(confirmList.confirmDtl , CRLF , '<br>'), ' ', '&nbsp;')}
									</td>
									<!-- 관련기관 -->
									<td style="text-align: center">
										${fn:replace(fn:replace(confirmList.relativeOrgan , CRLF , '<br>'), ' ', '&nbsp;')}
									</td>
									<!-- 비고 - 버튼 -->
									<td>
										<a id="btn_aft_confirm_edit_${rcStatus.index}" href="#noloc" onclick="fnConfirmEdit('aft',${rcStatus.index});"><img src="./resources/ls_img/btn_edite.gif"/></a>
									</td>
		       					</tr>
		       					
		       					<tr id="aft_confirm_edit_${rcStatus.index}" style="display:none;">
		       						<td style="text-align: center">
		      							<input type="text" class="calendar" id="aft_to_date_${rcStatus.index}" value="${confirmList.confirmToDate}" /> ~ <br/>
		      							&nbsp;&nbsp;&nbsp;<input type="text" class="calendar" id="aft_from_date_${rcStatus.index}" value="${confirmList.confirmFromDate}"/><br/>
		      							<input type="radio" name="aft_confirm_date_gubun_${rcStatus.index}" onclick="fnSetConfirmDateDtl('aft',1,${rcStatus.index})" id="aft_confirm_date_gubun1_${rcStatus.index}"  <c:if test="${confirmList.confirmGubun eq '1'}">checked="checked"</c:if> value="1">입원
		      							<input type="radio" name="aft_confirm_date_gubun_${rcStatus.index}" onclick="fnSetConfirmDateDtl('aft',2,${rcStatus.index})" id="aft_confirm_date_gubun2_${rcStatus.index}"  <c:if test="${confirmList.confirmGubun eq '2'}">checked="checked"</c:if> value="2">통원
		      							<input type="text" id="aft_date_dtl_${rcStatus.index}" value="${confirmList.confirmGubunTxt}"/> 
		       						</td>
		       						<td>
		       							<textarea rows="8" id="aft_confirm_dtl_${rcStatus.index}">${fn:replace(fn:replace(confirmList.confirmDtl, '<br>', CRLF), ' ', '&nbsp;')}</textarea>	
		       						</td>
		       						<td style="text-align: center">
		       							<textarea rows="8" id="aft_relative_organ_${rcStatus.index}">${fn:replace(fn:replace(confirmList.relativeOrgan, '<br>', CRLF), ' ', '&nbsp;')}</textarea>	
		       						</td>
		       						<td>
		       							<input type="hidden" id="aft_c_serial_no_${rcStatus.index}" value="${confirmList.serialNo}" />
		                       			<a id="btn_aft_confirm_save_${rcStatus.index}" href="#noloc" onclick="fnConfirmSave('aft',${rcStatus.index},'U');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                       			<a id="btn_aft_confirm_del_${rcStatus.index}" href="#noloc" onclick="fnConfirmDelete('aft',${rcStatus.index},'D');"><img src='./resources/ls_img/btn_del.gif' style="margin-top: 5px;"></a>
		                        		<a id="btn_aft_confirm_close_${rcStatus.index}" href="#noloc" onclick="fnConfirmCancel('aft',${rcStatus.index});"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		       						</td>								       						
		       					</tr>
		       				</c:if>
       					</c:forEach>
       				</tbody>
       			</table>
       		</article>
       	</section>        
        <script>
        	//일자별 확인사항 추가 화면 OPEN 
        	function fnConfirmAdd(gubun){
        		$("#"+gubun+"_confirm_add_btn").hide();
        		$("#"+gubun+"_add_tr").show();
        	}
        	
        	// 일자별 확인사항 추가 화면 닫기 
        	function fnConfirmClose(gubun){
        		$("#"+gubun+"_confirm_add_btn").show();
        		$("#"+gubun+"_add_tr").hide();		
        	}        	
        	
        	// 일자별 확인사항 INSERT 
        	function fnConfirmSave(gubun,index,type){
    			if( $("#"+gubun+"_to_date_"+index).val().trim() == "" ){
    				alert("시작일을 입력 해 주세요..");
    				return;
    			}
    			
    			if( $("#"+gubun+"_confirm_dtl_"+index).val().trim() == "" ){
    				alert("확인 내용을 입력 해 주세요..");
    				return;
    			}
        		
				fnConfirm(gubun,index,type);
        	}
        	
        	// 일자별 확인사항 DELETE 
        	function fnConfirmDelete(gubun,index,type){
        		var r = confirm("해당 행을 삭제하시겠습니까?");
        		if (r){
        			fnConfirm(gubun,index,type);	
        		}
        	}       	
        	
        	// 일자별 확인사항 수정 화면 OPEN 
        	function fnConfirmEdit(gubun,index){
        		$("#"+gubun+"_confirm_view_"+index).hide();
        		$("#"+gubun+"_confirm_edit_"+index).show();
        	}
        	
        	// 일자별 확인사항 수정 화면 CLOSE 
        	function fnConfirmCancel(gubun,index){
        		$("#"+gubun+"_confirm_view_"+index).show();
        		$("#"+gubun+"_confirm_edit_"+index).hide();
        	}
        	
        	// 일자별 확인사항 TRANAC         	
        	function fnConfirm(gubun,index,type){
       			var param = {};
       			param.type				= type;
    			param.rpt_print_no 		= $("#rpt_print_no").val();
    			param.confirm_gubun		= $("input:radio[name="+gubun+"_confirm_date_gubun_"+index+"]:checked").val();
    			param.confirm_gubun_txt	= $("#"+gubun+"_date_dtl_"+index).val();
    			param.confirm_to_date	= $("#"+gubun+"_to_date_"+index).val();
    			param.confirm_from_date	= $("#"+gubun+"_from_date_"+index).val();
    			param.relative_organ	= $("#"+gubun+"_relative_organ_"+index).val().replace(/\n/g, "\r\n");
    			param.confirm_dtl		= $("#"+gubun+"_confirm_dtl_"+index).val().replace(/\n/g, "\r\n");
    			
    			if (type == 'C'){
					switch(gubun){
						case "bef" : param.contract_ba = 1; break;
						case "day" : param.contract_ba = 2; break;
						case "aft" : param.contract_ba = 3; break;
					}
    			}else if (type == 'U' || type == 'D'){
    				param.serial_no = $("#"+gubun+"_c_serial_no_"+index).val();
    			}
                var url = "/meritz/meritz_rpt_confirm";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#meritz_rpt_confirm_by_date_table").html(data);
                        _initDatePicker();
                        
                        if (type == 'C'){
                        	alert("추가에 성공하였습니다..");
                        }else if (type == 'U'){
                        	alert("수정에 성공하였습니다..");
                        }else if (type == 'D'){
                        	alert("삭제에 성공하였습니다..");
                        }
                        
                    },
                    error: function(xhr, status, error){
                        if(xhr.status == "901"){
                            fnWinClose();
                        }else{
                            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                        }
                    },
                    beforeSend : function(xmlHttpRequest){
                        xmlHttpRequest.setRequestHeader("AJAX", "true");
                    }
                });     
        	}        	
        	
        	// 일자별 확인사항 입원, 통원 날짜 계산 
			function fnSetConfirmDateDtl(gubun,val,index){
				var strDate1 = $("#"+gubun+"_to_date_"+index).val();
				var strDate2 = $("#"+gubun+"_from_date_"+index).val();
				
				if ( (strDate1 > strDate2) || (strDate1=="" && strDate2=="") ){
					alert("날짜 정보를 확인 해 주세요.");
					return;
				}
				
				var arr1 = strDate1.split('-');
				var arr2 = strDate2.split('-');
				var dat1 = new Date(arr1[0], arr1[1], arr1[2]);
				var dat2 = new Date(arr2[0], arr2[1], arr2[2]);
	
				var diff = dat2 - dat1;
				
				var currDay = 24 * 60 * 60 * 1000;// 시 * 분 * 초 * 밀리세컨
				var currMonth = currDay * 30;// 월 만듬
				var currYear = currMonth * 12; // 년 만듬
				
				var diffDay =  parseInt(diff/currDay+1);
				
				if (val == 1){
					$("#"+gubun+"_date_dtl_"+index).val("입원 "+diffDay+"일");
				}else{
					$("#"+gubun+"_date_dtl_"+index).val("통원 "+diffDay+"회");
				}
			}
        </script>
        
        <section class="meritz_other_insu">
        	<h2>▣  타사 가입사항</h2>
        	<div class="btnSpan">
                <a id="btn_other_insu_add" href="#noloc" onclick="fnOtherInsuAdd();"><img src="./resources/ls_img/btn_add.gif"/></a>
       		</div>
       		<article id="meritz_other_insu_table">
				<table>
       				<colgroup>
       					<col width="15%" />
       					<col width="30%" />
       					<col width="16%" />
						<col width="30%" />
       					<col width="9%" />
       				</colgroup>
       				<thead>
       					<tr>
	       					<th>보험회사</th>
	       					<th>담보내용</th>
	       					<th>보험기간</th>
	       					<th>청구내용 및 결과</th>
	       					<th>비고</th>
       					</tr>
       				</thead>        
       				<tbody> 
						<tr id="other_insu_add" style="display:none;border:2px solid #8a8a8a;"> 
							<td>  
								<input type="text" id="other_insu_com_add"/>
							</td>
							<td>  
								<textarea id="other_insu_mortgage_add" rows="5"></textarea>
							</td>
							<td>  
								<textarea id="other_insu_period_add" rows="5"></textarea>
							</td>
							<td>  
								<textarea id="other_insu_etc_memo_add" rows="5"></textarea>
							</td>				
							<td>
                      			<a id="btn_other_insu_save_add" href="#noloc" onclick="fnOtherInsuSave('add','C');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        		<a id="btn_other_insu_close_add" href="#noloc" onclick="fnOtherInsuClose();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
							</td>																	
						</tr>
						
						<c:forEach items="${rptOtherInsu}" var="oiList" varStatus="oiStatus">
							<tr id="other_insu_view_${oiStatus.index}">
								<td style="text-align: center;">
									${oiList.otherInsuCom}
								</td>	
								<td>
									${fn:replace(fn:replace(oiList.otherInsuMortgage , CRLF , '<br>'), ' ', '&nbsp;')}
								</td>
								<td>
									${fn:replace(fn:replace(oiList.otherInsuPeriod , CRLF , '<br>'), ' ', '&nbsp;')}
								</td>
								<td>
									${fn:replace(fn:replace(oiList.otherInsuEtcMemo , CRLF , '<br>'), ' ', '&nbsp;')}								
								</td>
								<td>
									<a id="btn_other_insu_edit_${rcStatus.index}" href="#noloc" onclick="fnOtherInsuEdit(${oiStatus.index});"><img src="./resources/ls_img/btn_edite.gif"/></a>
								</td>
							</tr>
							
							<tr id="other_insu_edit_${oiStatus.index}" style="display: none;">
								<td style="text-align: center;">
									<input type="text" id="other_insu_com_${oiStatus.index}" value="${oiList.otherInsuCom}"/>
								</td>	
								<td>
									<textarea id="other_insu_mortgage_${oiStatus.index}" rows="5">${fn:replace(fn:replace(oiList.otherInsuMortgage , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
								</td>
								<td>
									<textarea id="other_insu_period_${oiStatus.index}" rows="5">${fn:replace(fn:replace(oiList.otherInsuPeriod , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
								</td>	
								<td>
									<textarea id="other_insu_etc_memo_${oiStatus.index}" rows="5">${fn:replace(fn:replace(oiList.otherInsuEtcMemo , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
								</td>
								<td>
	       							<input type="hidden" id="oi_serial_no_${oiStatus.index}" value="${oiList.serialNo}" />
	                       			<a id="btn_other_insu_save_${oiStatus.index}" href="#noloc" onclick="fnOtherInsuSave(${oiStatus.index},'U');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
	                       			<a id="btn_other_insu_del_${oiStatus.index}" href="#noloc" onclick="fnOtherInsuDelete(${oiStatus.index},'D');"><img src='./resources/ls_img/btn_del.gif' style="margin-top: 5px;"></a>
	                        		<a id="btn_other_insu_close_${oiStatus.index}" href="#noloc" onclick="fnOtherInsuCancel(${oiStatus.index});"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
								</td>							
						</c:forEach>
       				</tbody>
       			</table> 
       		</article>
       	</section>
        <script>
	    	//타사가입사항 추가 화면 OPEN
	    	function fnOtherInsuAdd(){
	    		$("#btn_other_insu_add").hide();
	    		$("#other_insu_add").show();
	    	}
	    	
	    	//타사가입사항 추가 화면 CLOSE
	    	function fnOtherInsuClose(){
	    		$("#btn_other_insu_add").show();
	    		$("#other_insu_add").hide();	
	    	}  
	    	
	    	//타사가입사항 저장
	    	function fnOtherInsuSave(index,type){
	    		if ( !fnVaildOtherInsu(index) ){
	    			return;
	    		}
	    		fnOtherInsu(index,type);
	    	}
	    	
	    	//타사가입사항 수정 VIEW
	    	function fnOtherInsuEdit(index){
	    		$("#other_insu_view_"+index).hide();
	    		$("#other_insu_edit_"+index).show();
	    	} 
	    	
	    	//타사가입사항 수정 VIEW 취소
	    	function fnOtherInsuCancel(index){
	    		$("#other_insu_view_"+index).show();
	    		$("#other_insu_edit_"+index).hide();
	    	} 
	    	
        	//타사가입사항 DELETE 
        	function fnOtherInsuDelete(index,type){
        		var r = confirm("해당 행을 삭제하시겠습니까?");
        		if (r){
        			fnOtherInsu(index,type);	
        		}
        	}   
	    	
	    	//타사가입사항 validation
	    	function fnVaildOtherInsu(index){
    			if ( $("#other_insu_com_"+index).val().trim() == "" ){
    				alert("보험회사를 입력 해 주세요..");
    				return false; 
    			}
    			if ( $("#other_insu_mortgage_"+index).val().trim() == "" ){
    				alert("담보내용을 입력 해 주세요..");
    				return false; 
    			}
    			if ( $("#other_insu_period_"+index).val().trim() == "" ){
    				alert("보험기간을 입력 해 주세요..");
    				return false;
    			}
    			if ( $("#other_insu_etc_memo_"+index).val().trim() == "" ){
    				alert("청구 내용 및 결과를 입력 해 주세요..");
    				return false; 
    			}
    			
    			return true;
	    	}	    	
	    	
	    	
	    	function fnOtherInsu(index,type){
	    		var param = {};
       			param.type					= type;
    			param.rpt_print_no 			= $("#rpt_print_no").val();		
	    		param.other_insu_com		= $("#other_insu_com_"+index).val().trim();
	    		param.other_insu_mortgage	= $("#other_insu_mortgage_"+index).val().trim().replace(/\n/g, "\r\n");
	    		param.other_insu_period		= $("#other_insu_period_"+index).val().trim().replace(/\n/g, "\r\n");
	    		param.other_insu_etc_memo	= $("#other_insu_etc_memo_"+index).val().trim().replace(/\n/g, "\r\n");
    			if (type == 'U' || type == 'D'){
    				param.serial_no = $("#oi_serial_no_"+index).val();
    			}
    			
                var url = "/meritz/meritz_rpt_other_insu";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#meritz_other_insu_table").html(data);
                        if (type == 'C'){
                        	alert("추가에 성공하였습니다..");
                        }else if (type == 'U'){
                        	alert("수정에 성공하였습니다..");
                        }else if (type == 'D'){
                        	alert("삭제에 성공하였습니다..");
                        }
                    },
                    error: function(xhr, status, error){
                        if(xhr.status == "901"){
                            fnWinClose();
                        }else{
                            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                        }
                    },
                    beforeSend : function(xmlHttpRequest){
                        xmlHttpRequest.setRequestHeader("AJAX", "true");
                    }
                });   
	    	} 
        </script>
        
		<section class="meritz_major_issues">
        	<h2>▣  주요쟁점사항</h2>
        	<div class="btnSpan">
                <a id="btn_major_issues_add" href="#noloc" onclick="fnMajorIssuesAdd();"><img src="./resources/ls_img/btn_add.gif"/></a>
       		</div>
       		
       		<article class="meritz_major_issues_table" id="meritz_major_issues_table">
       		
	       		<!-- 사고내용 -->
	       		<section class="major_issues_sub">
	       			<div class="issues_sub_head">
		       			<div class="issues_title">
		       				사고내용
		       				<span>
		       					ex) 피보험자, 목격자, 근로복지공단, 경찰서 등 구분
	       					</span>
		       			</div>
		       			<div class="issues_use_at">
			                <input type="radio" value="1" name="accident" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.accidentDtlUseAt == 1}">checked="checked"</c:if>> <label for="">사용</label>
			                <input type="radio" value="0" name="accident" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.accidentDtlUseAt == 0}">checked="checked"</c:if>> <label for="">미사용</label>
		       			</div>
	       			</div>
	       			
		            <c:choose>
		                <c:when test="${rptBasic.accidentDtlUseAt == 1}">
		                    <c:set var="issues_view_use_at_accident" value=""/>
		                </c:when>
		                <c:otherwise>
		                    <c:set var="issues_view_use_at_accident" value="display: none;"/>
		                </c:otherwise>
	       			</c:choose>
	       			<div class="issues_sub_body_view" id="issues_view_accident" style="${issues_view_use_at_accident}"> 
		                <div class="display-cell">
		                	<c:if test="${rptBasic.accidentDtlSub ne '' and rptBasic.accidentDtlSub != null}"> ${rptBasic.accidentDtlSub} 확인 결과, <br/></c:if>
		                    ${fn:replace(fn:replace(rptBasic.accidentDtl6 , CRLF , '<br>'), ' ', '&nbsp;')}
		                </div>
		                <div class="display-cell text-center">
							<a href="#noloc" onclick="fnMajorIssueEdit('accident');"><img src='./resources/ls_img/btn_edite.gif'></a>
		                </div>
	       			</div>
	       			
	       			<div class="issues_sub_body_edit" id="issues_edit_accident" style="display: none;">
	       				<div class="display-cell">
							<c:forEach items="${issuesAccidentCode}" var="iaList" varStatus="iaStatus">
								<input type="button" onclick="fnSetIssuesSubTxt(this,'accident')" value="${iaList.colVal}" />
							</c:forEach>
							<br/>
							<input type="text" id="issues_txt_sub_accident" value="${rptBasic.accidentDtlSub}" style="width:380px;"/>	확인 결과,
	       					<textarea id="issues_txt_accident" rows="8">${fn:replace(fn:replace(rptBasic.accidentDtl6,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
	       				</div>
		                <div class="display-cell text-center">
		                    <a href="#noloc" onclick="fnMajorIssueUpdate('accident')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                    <a href="#noloc" onclick="fnMajorIssueClose('accident');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		                </div>
	       			</div>
	       		</section>       		
       		
       		
	       		<!-- 고지의무 -->
	       		<section class="major_issues_sub">
	       			<div class="issues_sub_head">
		       			<div class="issues_title">
		       				고지의무
		       			</div>
		       			<div class="issues_use_at">
			                <input type="radio" value="1" name="notice1" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.noticeDuty1UseAt == 1}">checked="checked"</c:if>> <label for="">사용</label>
			                <input type="radio" value="0" name="notice1" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.noticeDuty1UseAt == 0}">checked="checked"</c:if>> <label for="">미사용</label>
		       			</div>
	       			</div>
	       			
		            <c:choose>
		                <c:when test="${rptBasic.noticeDuty1UseAt == 1}">
		                    <c:set var="issues_view_use_at_notice1" value=""/>
		                </c:when>
		                <c:otherwise>
		                    <c:set var="issues_view_use_at_notice1" value="display: none;"/>
		                </c:otherwise>
	       			</c:choose>
	       			<div class="issues_sub_body_view" id="issues_view_notice1" style="${issues_view_use_at_notice1}"> 
		                <div class="display-cell">
		                    ${fn:replace(fn:replace(rptBasic.noticeDuty16 , CRLF , '<br>'), ' ', '&nbsp;')}
		                </div>
		                <div class="display-cell text-center">
							<a href="#noloc" onclick="fnMajorIssueEdit('notice1');"><img src='./resources/ls_img/btn_edite.gif'></a>
		                </div>
	       			</div>
	       			<div class="issues_sub_body_edit" id="issues_edit_notice1" style="display: none;">
	       				<div class="display-cell">
	       					<textarea id="issues_txt_notice1" rows="8">${fn:replace(fn:replace(rptBasic.noticeDuty16,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
	       				</div>
		                <div class="display-cell text-center">
		                    <a href="#noloc" onclick="fnMajorIssueUpdate('notice1')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                    <a href="#noloc" onclick="fnMajorIssueClose('notice1');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		                </div>
	       			</div>
	       		</section>

	       		<!-- 통지의무 -->
	       		<section class="major_issues_sub">
	       			<div class="issues_sub_head">
		       			<div class="issues_title">
		       				통지의무
		       			</div>
		       			<div class="issues_use_at">
			                <input type="radio" value="1" name="notice2" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.noticeDuty2UseAt == 1}">checked="checked"</c:if>> <label for="">사용</label>
			                <input type="radio" value="0" name="notice2" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.noticeDuty2UseAt == 0}">checked="checked"</c:if>> <label for="">미사용</label>
		       			</div>
	       			</div>
	       			
		            <c:choose>
		                <c:when test="${rptBasic.noticeDuty2UseAt == 1}">
		                    <c:set var="issues_view_use_at_notice2" value=""/>
		                </c:when>
		                <c:otherwise>
		                    <c:set var="issues_view_use_at_notice2" value="display: none;"/>
		                </c:otherwise>
	       			</c:choose>
	       			<div class="issues_sub_body_view" id="issues_view_notice2" style="${issues_view_use_at_notice2}"> 
		                <div class="display-cell">
		                    ${fn:replace(fn:replace(rptBasic.noticeDuty26 , CRLF , '<br>'), ' ', '&nbsp;')}
		                </div>
		                <div class="display-cell text-center">
							<a href="#noloc" onclick="fnMajorIssueEdit('notice2');"><img src='./resources/ls_img/btn_edite.gif'></a>
		                </div>
	       			</div>
	       			<div class="issues_sub_body_edit" id="issues_edit_notice2" style="display: none;">
	       				<div class="display-cell">
	       					<textarea id="issues_txt_notice2" rows="8">${fn:replace(fn:replace(rptBasic.noticeDuty26,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
	       				</div>
		                <div class="display-cell text-center">
		                    <a href="#noloc" onclick="fnMajorIssueUpdate('notice2')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                    <a href="#noloc" onclick="fnMajorIssueClose('notice2');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		                </div>
	       			</div>
	       		</section>	       		

	       		<!-- 직업급수 -->
	       		<section class="major_issues_sub">
	       			<div class="issues_sub_head">
		       			<div class="issues_title">
		       				직업급수(확인)
							<span>
								ex) 피보험자, 회사 등 관계인, 근로복지공단 등 구분 
							</span>		       				
		       			</div>
		       			<div class="issues_use_at">
			                <input type="radio" value="1" name="job" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.jobGradeConfirmUseAt == 1}">checked="checked"</c:if>> <label for="">사용</label>
			                <input type="radio" value="0" name="job" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.jobGradeConfirmUseAt == 0}">checked="checked"</c:if>> <label for="">미사용</label>
		       			</div>
	       			</div>
		            <c:choose>
		                <c:when test="${rptBasic.jobGradeConfirmUseAt == 1}">
		                    <c:set var="issues_view_use_at_job" value=""/>
		                </c:when>
		                <c:otherwise>
		                    <c:set var="issues_view_use_at_job" value="display: none;"/>
		                </c:otherwise>
	       			</c:choose>
	       			<div class="issues_sub_body_view" id="issues_view_job" style="${issues_view_use_at_job}"> 
		                <div class="display-cell">
		                	<c:if test="${rptBasic.jobGradeConfirmSub ne '' and rptBasic.jobGradeConfirmSub != null}"> ${rptBasic.jobGradeConfirmSub} 확인 결과, <br/></c:if>
		                    ${fn:replace(fn:replace(rptBasic.jobGradeConfirm6 , CRLF , '<br>'), ' ', '&nbsp;')}
		                </div>
		                <div class="display-cell text-center">
							<a href="#noloc" onclick="fnMajorIssueEdit('job');"><img src='./resources/ls_img/btn_edite.gif'></a>
		                </div>
	       			</div>
	       			
	       			<div class="issues_sub_body_edit" id="issues_edit_job" style="display: none;">
	       				<div class="display-cell">
							<c:forEach items="${issuesjobCode}" var="ijList" varStatus="ijStatus">
								<input type="button" onclick="fnSetIssuesSubTxt(this,'job')" value="${ijList.colVal}" />
							</c:forEach>
							<br/>
							<input type="text" id="issues_txt_sub_job" value="${rptBasic.jobGradeConfirmSub}" style="width:380px;"/>	확인 결과,
	       					<textarea id="issues_txt_job" rows="8">${fn:replace(fn:replace(rptBasic.jobGradeConfirm6,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
	       				</div>
		                <div class="display-cell text-center">
		                    <a href="#noloc" onclick="fnMajorIssueUpdate('job')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                    <a href="#noloc" onclick="fnMajorIssueClose('job');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		                </div>
	       			</div>
	       		</section>  
	       		
	       		
	       		<!-- 의료자문 -->
	       		<section class="major_issues_sub">
	       			<div class="issues_sub_head">
		       			<div class="issues_title">
		       				의료자문
		       			</div>
		       			<div class="issues_use_at">
			                <input type="radio" value="1" name="medical" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.counselMedicalUseAt == 1}">checked="checked"</c:if>> <label for="">사용</label>
			                <input type="radio" value="0" name="medical" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.counselMedicalUseAt == 0}">checked="checked"</c:if>> <label for="">미사용</label>
		       			</div>
	       			</div>
	       			
		            <c:choose>
		                <c:when test="${rptBasic.counselMedicalUseAt == 1}">
		                    <c:set var="issues_view_use_at_medical" value=""/>
		                </c:when>
		                <c:otherwise>
		                    <c:set var="issues_view_use_at_medical" value="display: none;"/>
		                </c:otherwise>
	       			</c:choose>
	       			<div class="issues_sub_body_view" id="issues_view_medical" style="${issues_view_use_at_medical}"> 
		                <div class="display-cell">
		                    ${fn:replace(fn:replace(rptBasic.counselMedical6 , CRLF , '<br>'), ' ', '&nbsp;')}
		                </div>
		                <div class="display-cell text-center">
							<a href="#noloc" onclick="fnMajorIssueEdit('medical');"><img src='./resources/ls_img/btn_edite.gif'></a>
		                </div>
	       			</div>
	       			<div class="issues_sub_body_edit" id="issues_edit_medical" style="display: none;">
	       				<div class="display-cell">
	       					<textarea id="issues_txt_medical" rows="8">${fn:replace(fn:replace(rptBasic.counselMedical6,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
	       				</div>
		                <div class="display-cell text-center">
		                    <a href="#noloc" onclick="fnMajorIssueUpdate('medical')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                    <a href="#noloc" onclick="fnMajorIssueClose('medical');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		                </div>
	       			</div>
	       		</section>		       		     		


	       		<!-- 법률자문 -->
	       		<section class="major_issues_sub">
	       			<div class="issues_sub_head">
		       			<div class="issues_title">
		       				법률자문
		       			</div>
		       			<div class="issues_use_at">
			                <input type="radio" value="1" name="legal" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.counselLegalUseAt == 1}">checked="checked"</c:if>> <label for="">사용</label>
			                <input type="radio" value="0" name="legal" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.counselLegalUseAt == 0}">checked="checked"</c:if>> <label for="">미사용</label>
		       			</div>
	       			</div>
	       			
		            <c:choose>
		                <c:when test="${rptBasic.counselLegalUseAt == 1}">
		                    <c:set var="issues_view_use_at_legal" value=""/>
		                </c:when>
		                <c:otherwise>
		                    <c:set var="issues_view_use_at_legal" value="display: none;"/>
		                </c:otherwise>
	       			</c:choose>
	       			<div class="issues_sub_body_view" id="issues_view_legal" style="${issues_view_use_at_legal}"> 
		                <div class="display-cell">
		                    ${fn:replace(fn:replace(rptBasic.counselLegal6 , CRLF , '<br>'), ' ', '&nbsp;')}
		                </div>
		                <div class="display-cell text-center">
							<a href="#noloc" onclick="fnMajorIssueEdit('legal');"><img src='./resources/ls_img/btn_edite.gif'></a>
		                </div>
	       			</div>
	       			<div class="issues_sub_body_edit" id="issues_edit_legal" style="display: none;">
	       				<div class="display-cell">
	       					<textarea id="issues_txt_legal" rows="8">${fn:replace(fn:replace(rptBasic.counselLegal6,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
	       				</div>
		                <div class="display-cell text-center">
		                    <a href="#noloc" onclick="fnMajorIssueUpdate('legal')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                    <a href="#noloc" onclick="fnMajorIssueClose('legal');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		                </div>
	       			</div>
	       		</section>
	       		
	       		<!-- 관공서 확인내용 -->
	       		<section class="major_issues_sub">
	       			<div class="issues_sub_head">
		       			<div class="issues_title">
		       				관공서확인내용 (경찰서 등)
		       			</div>
		       			<div class="issues_use_at">
			                <input type="radio" value="1" name="public" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.confirmPublicUseAt == 1}">checked="checked"</c:if>> <label for="">사용</label>
			                <input type="radio" value="0" name="public" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.confirmPublicUseAt == 0}">checked="checked"</c:if>> <label for="">미사용</label>
		       			</div>
	       			</div>
	       			
		            <c:choose>
		                <c:when test="${rptBasic.confirmPublicUseAt == 1}">
		                    <c:set var="issues_view_use_at_public" value=""/>
		                </c:when>
		                <c:otherwise>
		                    <c:set var="issues_view_use_at_public" value="display: none;"/>
		                </c:otherwise>
	       			</c:choose>
	       			<div class="issues_sub_body_view" id="issues_view_public" style="${issues_view_use_at_public}"> 
		                <div class="display-cell">
		                    ${fn:replace(fn:replace(rptBasic.confirmPublic6 , CRLF , '<br>'), ' ', '&nbsp;')}
		                </div>
		                <div class="display-cell text-center">
							<a href="#noloc" onclick="fnMajorIssueEdit('public');"><img src='./resources/ls_img/btn_edite.gif'></a>
		                </div>
	       			</div>
	       			<div class="issues_sub_body_edit" id="issues_edit_public" style="display: none;">
	       				<div class="display-cell">
	       					<textarea id="issues_txt_public" rows="8">${fn:replace(fn:replace(rptBasic.confirmPublic6,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
	       				</div>
		                <div class="display-cell text-center">
		                    <a href="#noloc" onclick="fnMajorIssueUpdate('public')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                    <a href="#noloc" onclick="fnMajorIssueClose('public');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		                </div>
	       			</div>
	       		</section>	     

	       		<!-- 관공서 확인내용 -->
	       		<section class="major_issues_sub">
	       			<div class="issues_sub_head">
		       			<div class="issues_title">
		       				장해율/장해상태 확인
							<br/>		       				
		       				<span>
								ex) 문답 과정에서 확인한 피보험자 장해상태 기술 (촬영한 사진은 보고서 뒤 별첨으로 첨부)		       				
		       				</span>
		       			</div>
		       			<div class="issues_use_at">
			                <input type="radio" value="1" name="disability" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.disabilityUseAt == 1}">checked="checked"</c:if>> <label for="">사용</label>
			                <input type="radio" value="0" name="disability" onclick="fnRadioUseAt(this);"  <c:if test="${rptBasic.disabilityUseAt == 0}">checked="checked"</c:if>> <label for="">미사용</label>
		       			</div>
	       			</div>
	       			
		            <c:choose>
		                <c:when test="${rptBasic.disabilityUseAt == 1}">
		                    <c:set var="issues_view_use_at_disability" value=""/>
		                </c:when>
		                <c:otherwise>
		                    <c:set var="issues_view_use_at_disability" value="display: none;"/>
		                </c:otherwise>
	       			</c:choose>
	       			<div class="issues_sub_body_view" id="issues_view_disability" style="${issues_view_use_at_disability}"> 
		                <div class="display-cell">
		                    ${fn:replace(fn:replace(rptBasic.disability6 , CRLF , '<br>'), ' ', '&nbsp;')}
		                </div>
		                <div class="display-cell text-center">
							<a href="#noloc" onclick="fnMajorIssueEdit('disability');"><img src='./resources/ls_img/btn_edite.gif'></a>
		                </div>
	       			</div>
	       			<div class="issues_sub_body_edit" id="issues_edit_disability" style="display: none;">
	       				<div class="display-cell">
	       					<textarea id="issues_txt_disability" rows="8">${fn:replace(fn:replace(rptBasic.disability6,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
	       				</div>
		                <div class="display-cell text-center">
		                    <a href="#noloc" onclick="fnMajorIssueUpdate('disability')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                    <a href="#noloc" onclick="fnMajorIssueClose('disability');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		                </div>
	       			</div>
	       		</section>	  	       		
	       		
	       		  		
       		</article>
       	</section>
       	
       	<script>
	       	function fnRadioUseAt(that){
	       		var use_at = $(that).val();
	       		var gubun = $(that).attr("name");
	
	            var param = {};
	            param.suim_rpt_no           = $("#suim_rpt_no").val();
	            param.use_at				= use_at;
	            param.gubun					= gubun;
	            
	            var url = "/meritz/meritz_rpt_issues_use_at_update";
	
	            $.ajax({
	                type: "POST",
	                url: url,
	                data: param,
	                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	                dataType: "json",
	                timeout: 20000,
	                success: function(data){
	                    if(use_at == '1'){
	                        $("#issues_view_" + gubun).show();
	                        $("#issues_edit_" + gubun).hide();
	                    }else if(use_at == '0'){
	                        $("#issues_view_" + gubun).hide();
	                        $("#issues_edit_" + gubun).hide();
	                    }
	                },
	                error: function(xhr, status, error){
	                    if(xhr.status == "901"){
	                        fnWinClose();
	                    }else{
	                        alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	                    }
	                },
	                beforeSend : function(xmlHttpRequest){
	                    xmlHttpRequest.setRequestHeader("AJAX", "true");
	                }
	            });
			}
	
			function fnMajorIssueEdit(gubun){
	        	$("#issues_view_"+gubun).hide();
	        	$("#issues_edit_"+gubun).show();
	        }
	
			function fnMajorIssueClose(gubun){
	        	$("#issues_view_"+gubun).show();
	        	$("#issues_edit_"+gubun).hide();
	        }
			
			function fnMajorIssueUpdate(gubun){
	            var param = {};
	            param.suim_rpt_no           = $("#suim_rpt_no").val();
	            param.issues_contents		= $("#issues_txt_"+gubun).val().replace(/\n/g, "\r\n");
	    		param.gubun 				= gubun;        
	            if (gubun == 'accident' || gubun == 'job'){
	            	param.issues_sub_contents	= $("#issues_txt_sub_"+gubun).val().replace(/\n/g, "\r\n");
	            }
		            
	            var url = "/meritz/meritz_rpt_issues_contents_update";
	
	            $.ajax({
	                type: "POST",
	                url: url,
	                data: param,
	                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	                dataType: "html",
	                timeout: 20000,
	                success: function(data){
	                    $("#meritz_major_issues_table").html(data);
	                },
	                error: function(xhr, status, error){
	                    if(xhr.status == "901"){
	                        fnWinClose();
	                    }else{
	                        alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	                    }
	                },
	                beforeSend : function(xmlHttpRequest){
	                    xmlHttpRequest.setRequestHeader("AJAX", "true");
	                }
	            });
			}
			
			
			function fnSetIssuesSubTxt(that,gubun){
				var val = $(that).val();
				
				if ( $("#issues_txt_sub_"+gubun).val() == "" ){
					$("#issues_txt_sub_"+gubun).val( val );
				}else{
					var tmpStr = $("#issues_txt_sub_"+gubun).val()+ ", " + val
					$("#issues_txt_sub_"+gubun).val( tmpStr );
				}
				
			}
       	
       	</script>
       	
		<section class="meritz_relative_interview">
        	<h2>▣  관련자면담 및 특이사항</h2>
         	<div class="btnSpan">
                <a id="btn_interview_edit"	href="#noloc" onclick="fnInterviewEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
                <a id="btn_interview_save"	href="#noloc" onclick="fnInterviewSave();" style="display: none"><img src="./resources/ls_img/icon_write.gif"/></a>
                <a id="btn_interview_cancel"	href="#noloc" onclick="fnInterviewCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
       		</div>       	  
        	<article id="meritz_rpt_interview_table">
        		<table>
      				<colgroup>
       					<col width="20%" />
       					<col width="80%" />
       				</colgroup>
        			<thead>
	        			<tr>
	        				<th>구분</th>
	        				<th>쟁점사항</th>
	        			</tr>
        			</thead>
        			<tbody class="meritz_interview_view">
        				<tr>
        					<td style="text-align: center">
        						피보험자
        						<br/>(or 유가족 면담사항)
       						</td>
        					<td>
       							${fn:replace(fn:replace(rptBasic.faceMemo7 , CRLF , '<br>'), ' ', '&nbsp;')}
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center">
        						독립손사
        						<br/>(세부정보포함)
       						</td>
        					<td>
        						${fn:replace(fn:replace(rptBasic.delegate7 , CRLF , '<br>'), ' ', '&nbsp;')}
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center">
        						탐문내용
       						</td>
        					<td>
        						${fn:replace(fn:replace(rptBasic.questioning7 , CRLF , '<br>'), ' ', '&nbsp;')}
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center">
        						안내 및 특이사항
       						</td>
        					<td>
        						${fn:replace(fn:replace(rptBasic.guideEtc7 , CRLF , '<br>'), ' ', '&nbsp;')}
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center">
        						추가서류창구
       						</td>
        					<td>
        						${fn:replace(fn:replace(rptBasic.moreDocument7 , CRLF , '<br>'), ' ', '&nbsp;')}
       						</td>
        				</tr>        				
        			</tbody>
        			
        			<tbody class="meritz_interview_edit" style="display: none;">
        				<tr>
        					<td style="text-align: center">
        						피보험자
        						<br/>(or 유가족 면담사항)
       						</td>
        					<td>
        						<textarea id="face_memo" rows="5">${fn:replace(fn:replace(rptBasic.faceMemo7 , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center">
        						독립손사
        						<br/>(세부정보포함)
       						</td>
        					<td>
        						<textarea id="delegate" rows="5">${fn:replace(fn:replace(rptBasic.delegate7 , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center">
        						탐문내용
       						</td>
        					<td>
        						<textarea id="questioning" rows="5">${fn:replace(fn:replace(rptBasic.questioning7 , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center">
        						안내 및 특이사항
       						</td>
        					<td>
        						<textarea id="guide_etc" rows="5">${fn:replace(fn:replace(rptBasic.guideEtc7 , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center">
        						추가서류창구
       						</td>
        					<td>
        						<textarea id="more_document" rows="5">${fn:replace(fn:replace(rptBasic.moreDocument7 , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
       						</td>
        				</tr>        	        			
        			</tbody>
        		</table>
        	</article>
        </section>
        
		<script type="text/javascript">
			//
			// 관련자면담 및 특이사항
			//
            function fnInterviewEdit(){
                $("#btn_interview_edit").hide();
                $("#btn_interview_save").show();
                $("#btn_interview_cancel").show();
                 
                $(".meritz_interview_view").hide();
                $(".meritz_interview_edit").show();
            }
             
            function fnInterviewCancel() {
                $("#btn_interview_edit").show();
                $("#btn_interview_save").hide();
                $("#btn_interview_cancel").hide();

                $(".meritz_interview_view").show();
                $(".meritz_interview_edit").hide();
            }

            function fnInterviewSave() {
                var param = {};
                param.suim_rpt_no       = $("#suim_rpt_no").val();
                param.face_memo 		= $("#face_memo").val().replace(/\n/g, "\r\n");
                param.delegate 			= $("#delegate").val().replace(/\n/g, "\r\n");
                param.questioning 		= $("#questioning").val().replace(/\n/g, "\r\n");
                param.guide_etc 		= $("#guide_etc").val().replace(/\n/g, "\r\n");
                param.more_document 	= $("#more_document").val().replace(/\n/g, "\r\n");
                
                var url = "/meritz/meritz_rpt_interview_update";
	
                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#meritz_rpt_interview_table").html(data); 
                        fnInterviewCancel();
                    },
                    error: function(xhr, status, error){
                        if(xhr.status == "901"){
                            fnWinClose();
                        }else{
                            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                        }
                    },
                    beforeSend : function(xmlHttpRequest){
                        xmlHttpRequest.setRequestHeader("AJAX", "true");
                    }

                });
            }
		</script>	        
        <section class="meritz_rpt_ctrl">
        	<h2>▣  사고조사 처리과정</h2>
        	<div class="btnSpan">
                <a id="btn_ctrl_add" href="#noloc" onclick="fnCtrlAdd();"><img src="./resources/ls_img/btn_add.gif"/></a>
       		</div>
       		<article id="meritz_ctrl_table">
       			<table>
       				<colgroup>
       					<col width="16%" />
       					<col width="19%" />
       					<col width="19%" />
       					<col width="19%" />
       					<col width="18%" />
       					<col width="9%" />
       				</colgroup>
       				<thead>
       					<tr>
	       					<th>진행일시</th>
	       					<th>주요내용</th>
	       					<th>면담자</th>
	       					<th>관계</th>
	       					<th>접촉방법</th>
	       					<th>비고</th>
       					</tr>
       				</thead>        
       				<tbody> 
						<tr id="meritz_ctrl_add" style="display:none;border:2px solid #8a8a8a;"> 
							<td>  
								<input type="text" class="calendar" id="control_date_add" />
							</td>
							
							<td>
		                        <select id="select_control_memo_add" style="margin-bottom: 5px;" onchange="fnControlChange(this,'memo','add');" >
		                        	<option value="">--선택--</option>
		                            <c:forEach  var="item" items="${reportMemoCodeList}" varStatus="status">
		                                <option value="${item.colVal}">${item.colVal}</option>
		                            </c:forEach>
		                            <option value="999">직접입력</option>
		                        </select>  
								<input type="text" id="control_memo_add" style="display: none;" />
							</td> 
							
							<td>
		                        <select id="select_control_who_add" style="margin-bottom: 5px;" onchange="fnControlChange(this,'who','add');" >
		                        	<option value="">--선택--</option>
		                            <c:forEach  var="item" items="${reportWorkCodeList}" varStatus="status">
		                                <option value="${item}">${item}</option>
		                            </c:forEach>
									<option value="999">직접입력</option>
		                        </select>  							  
								<input type="text" id="control_who_add" style="display: none;"/>
							</td>
							
							<td>  
		                        <select id="select_control_relation_add" style="margin-bottom: 5px;" onchange="fnControlChange(this,'relation','add');" >
		                        	<option value="">--선택--</option>
		                            <c:forEach  var="item" items="${reportRelationCodeList}" varStatus="status">
		                                <option value="${item}">${item}</option>
		                            </c:forEach>
		                            <option value="999">직접입력</option>
		                        </select>  							  
								<input type="text" id="control_relation_add" style="display: none;"/>
							</td>			
							
							<td>  
		                        <select id="select_control_Contact_add" style="margin-bottom: 5px;" onchange="fnControlChange(this,'contact','add');" >
		                        	<option value="">--선택--</option>
		                            <c:forEach  var="item" items="${reportContactCodeList}" varStatus="status">
		                                <option value="${item}">${item}</option>
		                            </c:forEach>
									<option value="999">직접입력</option>
		                        </select>  								
								<input type="text" id="control_contact_add" style="display: none;"/>
							</td>			
								
							<td>
                      			<a id="btn_other_insu_save_add" href="#noloc" onclick="fnCtrlSave('C','add');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        		<a id="btn_other_insu_close_add" href="#noloc" onclick="fnCtrlClose();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
							</td>																	
						</tr>
						<c:forEach items="${rptControl}" var="rcList" varStatus="rcStatus">
							<tr id="meritz_ctrl_view_${rcStatus.index}">
								<td style="text-align: center;">
									${rcList.controlDate}
								</td>	
								<td style="text-align: center;">
									${rcList.controlMemo}
								</td>
								<td style="text-align: center;">
									${rcList.controlWho}
								</td>
								<td style="text-align: center;">
									${rcList.controlRelation}								
								</td>
								<td style="text-align: center;">
									${rcList.controlContact}								
								</td>
								<td>
									<a id="btn_merit_ctrl_edit_${rcStatus.index}" href="#noloc" onclick="fnCtrlEdit(${rcStatus.index});"><img src="./resources/ls_img/btn_edite.gif"/></a>
								</td>
							</tr>
							
							<tr id="meritz_ctrl_edit_${rcStatus.index}" style="display: none;">
								<td>  
									<input type="text" class="calendar" id="control_date_${rcStatus.index}" value="${rcList.controlDate}"/>
								</td>
								
								<td>
			                        <select id="select_control_memo_${rcStatus.index}" style="margin-bottom: 5px;" onchange="fnControlChange(this,'memo','${rcStatus.index}');" >
			                        	<option value="">--선택--</option>
			                        	<c:set var="ctrl_memo_selected" value="0"/>
			                            <c:forEach  var="item" items="${reportMemoCodeList}" varStatus="status">
			                            	<c:if test="${item.colVal == rcList.controlMemo}">
				                                <c:set var="ctrl_memo_selected" value="1"/>
				                            </c:if>
			                                <option value="${item.colVal}" <c:if test="${item.colVal == rcList.controlMemo}">selected</c:if> >${item.colVal}</option>
			                            </c:forEach>
			                            <option value="999" <c:if test="${ctrl_memo_selected == 0}">selected</c:if> >직접입력</option>
			                        </select>  
									<input type="text" id="control_memo_${rcStatus.index}"  <c:if test="${ctrl_memo_selected == 1}">style="display: none;"</c:if> value="${rcList.controlMemo}"/>
								</td> 
								
								<td>
			                        <select id="select_control_who_${rcStatus.index}" style="margin-bottom: 5px;" onchange="fnControlChange(this,'who','${rcStatus.index}');" >
			                        	<option value="">--선택--</option>
			                        	<c:set var="ctrl_who_selected" value="0"/>
			                            <c:forEach  var="item" items="${reportWorkCodeList}" varStatus="status">
			                            	<c:if test="${item == rcList.controlWho}">
				                                <c:set var="ctrl_who_selected" value="1"/>
				                            </c:if>
			                                <option value="${item}" <c:if test="${item == rcList.controlWho}">selected</c:if> >${item}</option>
			                            </c:forEach>
										<option value="999" <c:if test="${ctrl_who_selected == 0}">selected</c:if> >직접입력</option>
			                        </select>  		
									<input type="text" id="control_who_${rcStatus.index}" <c:if test="${ctrl_who_selected == 1}">style="display: none;"</c:if> value="${rcList.controlWho}"/>
								</td>
								
								<td>  
			                        <select id="select_control_relation_${rcStatus.index}" style="margin-bottom: 5px;" onchange="fnControlChange(this,'relation','${rcStatus.index}');" >
			                        	<option value="">--선택--</option>
			                        	<c:set var="ctrl_relation_selected" value="0"/>
			                            <c:forEach  var="item" items="${reportRelationCodeList}" varStatus="status">
			                            	<c:if test="${item == rcList.controlRelation}">
				                                <c:set var="ctrl_relation_selected" value="1"/>
				                            </c:if>
			                                <option value="${item}" <c:if test="${item == rcList.controlRelation}">selected</c:if> >${item}</option>
			                            </c:forEach>
			                            <option value="999" <c:if test="${ctrl_relation_selected == 0}">selected</c:if> >직접입력</option>
			                        </select>  							  
			                        
									<input type="text" id="control_relation_${rcStatus.index}" <c:if test="${ctrl_relation_selected == 1}">style="display: none;"</c:if> value="${rcList.controlRelation}"/>
								</td>			
								
								<td>  
			                        <select id="select_control_Contact_${rcStatus.index}" style="margin-bottom: 5px;" onchange="fnControlChange(this,'contact','${rcStatus.index}');" >
			                        	<option value="">--선택--</option>
			                        	<c:set var="ctrl_contact_selected" value="0"/>
			                            <c:forEach  var="item" items="${reportContactCodeList}" varStatus="status">
			                            	<c:if test="${item == rcList.controlContact}">
				                                <c:set var="ctrl_contact_selected" value="1"/>
				                            </c:if>			                            
			                                <option value="${item}" <c:if test="${item == rcList.controlContact}">selected</c:if> >${item}</option>
			                            </c:forEach>
										<option value="999" <c:if test="${ctrl_contact_selected == 0}">selected</c:if> >직접입력</option>
			                        </select>  			
									<input type="text" id="control_contact_${rcStatus.index}" <c:if test="${ctrl_contact_selected == 1}">style="display: none;"</c:if> value="${rcList.controlContact}"/>
								</td>		
								
								<td>
	       							<input type="hidden" id="rc_serial_no_${rcStatus.index}" value="${rcList.serialNo}" />
	                       			<a id="btn_meritz_ctrl_save_${rcStatus.index}" href="#noloc" onclick="fnCtrlSave('U',${rcStatus.index});"><img src='./resources/ne_img/btn/btn_save.gif'></a>
	                       			<a id="btn_meritz_ctrl_del_${rcStatus.index}" href="#noloc" onclick="fnCtrlDelete('D',${rcStatus.index});"><img src='./resources/ls_img/btn_del.gif' style="margin-top: 5px;"></a>
	                        		<a id="btn_meritz_ctrl_close_${rcStatus.index}" href="#noloc" onclick="fnCtrlCancel(${rcStatus.index});"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
								</td>							
						</c:forEach>
					</tbody>
				</table>
						
       		</article>
       	</section>
       	<script>
       		function fnCtrlAdd(){
       			$("#meritz_ctrl_add").show();
       			$("#btn_ctrl_add").hide();
       		}	
       		
       		function fnCtrlClose(){
       			$("#meritz_ctrl_add").hide();
       			$("#btn_ctrl_add").show();
       		}
       		
       		function fnCtrlEdit(idx){
       			$("#meritz_ctrl_view_"+idx).hide();
       			$("#meritz_ctrl_edit_"+idx).show();
       			$("#btn_ctrl_add").hide();
       		}
       		
       		function fnCtrlCancel(idx){
       			$("#meritz_ctrl_view_"+idx).show();
       			$("#meritz_ctrl_edit_"+idx).hide();
       			$("#btn_ctrl_add").show();
       		}
       		
       		function fnControlChange(that,gubun,idx){
       			var selectValue = $(that).val();
       			
       			if (selectValue == 999){
       				$("#control_"+gubun+"_"+idx).show();
       				$("#control_"+gubun+"_"+idx).val("");
       			}else{
       				$("#control_"+gubun+"_"+idx).hide();
       				$("#control_"+gubun+"_"+idx).val(selectValue);
       			}
       		}
       		
       		function fnCtrlSave(type,idx){
       			fnRptControl(type,idx);  		
       		}
       		
       		function fnCtrlDelete(type,idx){
       			var r = confirm("해당 건을 삭제 하시겠습니까?");
       			if (!r){
       				return;
       			}
       			fnRptControl(type,idx);
       		}
       		
	    	function fnRptControl(type,index){
	    		var param = {};
       			param.type					= type;
    			param.suim_rpt_no 			= $("#suim_rpt_no").val();
    			param.control_date			= $("#control_date_"+index).val().trim();
	    		param.control_memo			= $("#control_memo_"+index).val().trim();
	    		param.control_who			= $("#control_who_"+index).val().trim();
	    		param.control_relation		= $("#control_relation_"+index).val().trim();
	    		param.control_contact		= $("#control_contact_"+index).val().trim();
	    		
    			if (type == 'U' || type == 'D'){
    				param.serial_no = $("#rc_serial_no_"+index).val();
    			}
				
                var url = "/meritz/meritz_rpt_control";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#meritz_ctrl_table").html(data);
                        if (type == 'C'){
                        	alert("추가에 성공하였습니다..");
                        }else if (type == 'U'){
                        	alert("수정에 성공하였습니다..");
                        }else if (type == 'D'){
                        	alert("삭제에 성공하였습니다..");
                        }
                        
                        $("#btn_ctrl_add").show();
                        _initDatePicker();
                    },
                    error: function(xhr, status, error){
                        if(xhr.status == "901"){
                            fnWinClose();
                        }else{
                            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                        }
                    },
                    beforeSend : function(xmlHttpRequest){
                        xmlHttpRequest.setRequestHeader("AJAX", "true");
                    }
                });   
	    	} 
       
       	</script>
       	
        <!-- 별첨 첨부사진 -->
        <div class="text-center" style="font-size: 24px; padding: 15px 0px; font-family: 돋움; color: #000; margin: 20px 0px;">
            <b>&lt;별첨:첨부사진&gt;</b>
        </div>
<%--
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell" style="width: 80%;">
                <p class="subtitle">&lt;별첨:첨부사진&gt; &nbsp;&nbsp;&nbsp;<span style="color:red; font-size: 12px; font-weight: bold">(사고현장, 피보험자 장해상태, 방사선 검사결과 등)</span></p>
            </div>
            <div class="display-cell text-right" style="width: 20%;">
                <a href="#noloc"><img src="./resources/ls_img/ls_body/btn_add.gif"/></a>
            </div>
        </div>
--%>
        <script src="/resources/jquery/jquery.form.min.js"></script>
        <script type="text/javascript">

            function fnAttachFileSave() {

                if($("#ai_img_memo").val() == ""){
                    alert("설명을 입력해 주세요.");
                    $("#ai_img_memo").focus();
                    return;
                }

                if($("#ai_img_rank").val() == ""){
                    alert("정렬순서를 입력해 주세요.");
                    $("#ai_img_rank").focus();
                    return;
                }
                if($("#ai_attach_img").val() == ""){
                    alert("이미지를 선택해 주세요.");
                    $("#ai_attach_img").focus();
                    return;
                }

                $('#tr_attach_file_btn').hide();
                $('#tr_attach_file_progress').show();
                $("#btn_attach_file_submit").trigger('click');
            }

            $('#newFrm').ajaxForm({
                beforeSend: function() {
                    var percentVal = '0%';
                    $("#div_bar").css("width",percentVal);
                    $("#div_percent").html(percentVal);
                },
                uploadProgress: function(event, position, total, percentComplete) {
                    var percentVal = percentComplete + '%';
                    $("#div_bar").css("width",percentVal);
                    $("#div_percent").html(percentVal);
                },
                error: function(xhr, status, error){
                    if(xhr.status == "901"){
                        fnWinClose();
                    }else{
                        alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                    }
                },
                success: function(data) {
                	if(data == '0'){
                		alert("DB 등록 오류 입니다. 관리자에게 문의 바랍니다.");
                	}else if(data == '1'){
                		alert("허용된 이미지 파일이 아닙니다.[JPG/GIF/BMP/PNG]");
                	}else{
                        var percentVal = '100%';
                        $("#div_bar").css("width",percentVal);
                        $("#div_percent").html(percentVal);                		
                	}
                },
                complete: function(xhr) {
                    $('#tr_attach_file_btn').show();
                    $('#tr_attach_file_progress').hide();
                    $('#newFrm').clearForm();
                    fnAttachImageRefresh();
                    //$('#newFrm').resetForm();
                }
            });


        </script>
        <div id="div_attach_img_add">
            <form id="newFrm" name="newFrm" action="/upload" method="post" enctype="multipart/form-data">
                <input  type="hidden" name="func" value="10"/>
                <input  type="hidden" name="gubun" value="0"/>
                <input  type="hidden" name="imgpage" value="1"/>
                <input  type="hidden" name="suimRptNo"  value="${reportBscInfo.suimRptNo}"/>
                <table>
                    <colgroup>
                        <col width="25%">
                        <col width="75%">
                    </colgroup>
                    <tr>
                        <th>사진설명</th>
                        <td><input type="text" id="ai_img_memo" name="rptprint1ImgExplain"></td>
                    </tr>
                    <tr>
                        <th>정렬순서</th>
                        <td><input type="text" id="ai_img_rank" name="imgRank" onkeyup="digitOnly(this);" style="width: 20%; text-align: right" maxlength="3"></td>
                    </tr>
                    <tr>
                        <th>이미지선택</th>
                        <td><input type="file" id="ai_attach_img" name="attchFile" accept=".jpg,.gif,.bmp,.png"></td>
                    </tr>
                    <tr id="tr_attach_file_btn">
                        <td colspan="2" style="text-align: center">
                            <a href="#noloc" onclick="fnAttachFileSave();"><img src="./resources/ls_img/ls_body/btn_add.gif"/></a>
                        </td>
                    </tr>
                    <tr id="tr_attach_file_progress" style="display: none;">
                        <td colspan="2" style="text-align: center">
                            <div class="progress">
                                <div id="div_bar" class="bar"></div >
                                <div id="div_percent" class="percent">0%</div >
                            </div>
                        </td>
                    </tr>
                </table>
                <input style ="display:none; visibility:hidden;" type="submit" id ="btn_attach_file_submit"/>
            </form>
        </div>
        <script type="text/javascript">
            function fnAttachImageEdit(idx){
                $("#tr_attach_image_view" + idx).hide();
                $("#tr_attach_image_edit" + idx).show();
            }

            function fnAttachImageClose(idx){
                $("#tr_attach_image_view" + idx).show();
                $("#tr_attach_image_edit" + idx).hide();
            }

            function fnAttachImageUpdate(idx){
                if($("#ai_img_rank" + idx).val() == ""){
                    alert("정렬순서를 입력해 주세요.");
                    $("#ai_img_rank" + idx).focus();
                    return;
                }
                if($("#ai_img_memo" + idx).val() == ""){
                    alert("설명을 입력해 주세요.");
                    $("#ai_img_memo" + idx).focus();
                    return;
                }
                fnAttachImage(idx, 'U');
            }

            function fnAttachImageDelete(idx){
                if(confirm("삭제하시겠습니까?")){
                    fnAttachImage(idx, 'D');
                }
            }

            function fnAttachImageRefresh(){
                var param = {};
                param.suim_rpt_no               = $("#suim_rpt_no").val();
                param.rpt_print_no              = $("#rpt_print_no").val();
                param.cmd                       = "RF";

                var url = "./report_attach_image";
                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#div_attach_img_list").html(data);
                    },
                    error: function(xhr, status, error){
                        if(xhr.status == "901"){
                            fnWinClose();
                        }else{
                            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                        }
                    },
                    beforeSend : function(xmlHttpRequest){
                        xmlHttpRequest.setRequestHeader("AJAX", "true");
                    }
                });
            }

            function fnAttachImage(idx, cmd){
                var param = {};
                param.suim_rpt_no               = $("#suim_rpt_no").val();
                param.rpt_print_no              = $("#rpt_print_no").val();
                param.cmd                       = cmd;
                param.serial_no                 = $("#ai_serial_no" + idx).val();
                param.img_rank                  = $("#ai_img_rank" + idx).val();
                param.img_memo                  = $("#ai_img_memo" + idx).val();

                var url = "./report_attach_image";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#div_attach_img_list").html(data);
                    },
                    error: function(xhr, status, error){
                        if(xhr.status == "901"){
                            fnWinClose();
                        }else{
                            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                        }
                    },
                    beforeSend : function(xmlHttpRequest){
                        xmlHttpRequest.setRequestHeader("AJAX", "true");
                    }
                });

            }
        </script>
        <div id="div_attach_img_list" style="margin-top: 10px;margin-bottom:100px;">
            <table>
                <colgroup>
                    <col width="10%">
                    <col width="60%">
                    <col width="21%">
                    <col width="9%">
                </colgroup>
                <tr>
                    <th>순서</th>
                    <th>설명</th>
                    <th>파일명</th>
                    <th>-</th>
                </tr>
                <c:forEach var="item" items="${reportAttachImageList}" varStatus="status">
                    <tr id="tr_attach_image_view${status.index}">
                        <td>${item.imgRank}</td>
                        <td>${item.imgMemo}</td>
                        <td>${item.imgName}</td>
                        <td>
                            <a href="#noloc" onclick="fnAttachImageEdit('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
                            <a href="#noloc" onclick="fnAttachImageDelete('${status.index}');"><img src='./resources/ls_img/btn_del_s.gif'></a>
                        </td>
                    </tr>
                    <tr id="tr_attach_image_edit${status.index}" style="display: none;">
                        <td>
                            <input type="hidden" id="ai_serial_no${status.index}" value="${item.serialNo}">
                            <input type="text" id="ai_img_rank${status.index}" value="${item.imgRank}" onkeyup="digitOnly(this);">
                        </td>
                        <td><input type="text" id="ai_img_memo${status.index}" value="${item.imgMemo}"></td>
                        <td>${item.imgName}</td>
                        <td align="center">
                            <a href="#noloc" onclick="fnAttachImageUpdate('${status.index}');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                            <a href="#noloc" onclick="fnAttachImageClose('${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <!--// 별첨 첨부사진 -->
	</div>
</div>       
       	
