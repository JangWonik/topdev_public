<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<link rel="stylesheet" type="text/css" href="./resources/wm_css/general_report.css?v=201707261117"/>
<script type="text/javascript">
    function fnReportWord(){
        var cw=screen.availWidth;
        var ch=screen.availHeight;

        var sw=1000; //띄울 창의 넓이
        var sh=740;  //띄울 창의 높이

        var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
        var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치

        window.open('/reportBscInfoNew?suim_rpt_no='+'${param.suim_rpt_no}'+'&cmd=word','word','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
    }

    //일반보고서 출력    
    function fnReportPrintGenaral(){
        var cw=screen.availWidth;
        var ch=screen.availHeight;

        var sw=700; //띄울 창의 넓이
        var sh=550;  //띄울 창의 높이

        var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
        var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치

        window.open('/reportBscInfoNew?suim_rpt_no='+'${param.suim_rpt_no}'+'&cmd=print','print','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
    }
</script>
<div class="reportWrap">
    <div class="reportContent">
        <input type="hidden" id="suim_rpt_no" value="${param.suim_rpt_no}">
        <input type="hidden" id="rpt_print_no" value="${reportPrint1.rptPrintNo}">
        <div class="text-right">
            <a href="/reportBscInfoNew?suim_rpt_no=${param.suim_rpt_no}&cmd=word"><img src="./resources/ls_img/report/btn_word.gif"></a>
            <a href="#noloc" onclick="fnReportPrintGenaral()"><img src="./resources/ls_img/report/icon_print.gif"></a>
        </div>
        <div>
            <img src="//www.toplac.co.kr/resources/ls_img/ls_body/print_head.jpg" width="640" height="56">
            <p class="text-center" style="padding-top: 6px;"><span style="font-size: 9pt;">${reportTeamInfo.teamAddr}</span></p>
            <p class="text-center">
					<span style="font-size: 9pt;">
                        전화 : ${reportTeamInfo.teamTelephone} &nbsp;팩스 : ${reportTeamInfo.teamFax} &nbsp;이메일 : ${reportInvgUser.email}
                    </span>
            </p>
            <p class="text-center" style="padding-top: 2px;">
                <img src="//www.toplac.co.kr/resources/ls_img/ls_body/print_hr.jpg" width="640" height="3" border="0" class="img-responsive center-block">
            </p>
        </div>
        <div style="margin-top: 10px;">
            <div style="width: 60%; float: left">
                <p class="title">수 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신 : ${reportBscInfo.ptnrName}</p>
                <p class="title">
                    참 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조 :
                    ${reportBscInfo.ptnrDeptNm}
                    <c:if test="${reportBscInfo.ptnrMbrNm != ''}">
                        〔 담당 : ${reportBscInfo.ptnrMbrNm} 님 〕
                    </c:if>
                </p>
                <p class="title">
                    제 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목 :
                    <c:if test="${reportBscInfo.beneficiaryNm != ''}">
                        &quot;<b>${reportBscInfo.beneficiaryNm}</b>&quot;
                    </c:if>
                    손해사정서
                </p>
                <p class="title">증 권 번 호 : 제 ${reportBscInfo.policyNo} 호</p>
                <p class="title">사 고 번 호 : ${reportBscInfo.accidentNo}</p>
            </div>
            <div style="width: 40%; float: left">
                <p class="title">Report No. ${reportBscInfo.suimAcceptNo}</p>
                <p class="title">
                    <c:choose>
                        <c:when test="${reportBscInfo.invoiceDate == null || reportBscInfo.invoiceDate == ''}">
                            날짜 정보없음
                        </c:when>
                        <c:otherwise>
                            보고서 제출일 : ${reportBscInfo.invoiceDate}
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
            <div style="clear: both"></div>
            <div>
                <p style="margin-top: 20px; padding: 0px 5px;">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    귀 사의 요청에 의거하여 피보험자 &quot;${reportBscInfo.beneficiaryNm}&quot;의 보험금
                    청구건에 대한 사고조사를 실시하고, 그 결과를 다음과 같이 제출 합니다.
                </p>
            </div>
        </div>
        <div style="margin-top: 50px;">
            <table class="approval" align="center">
                <colgroup>
                    <col width="25%">
                    <col width="25%">
                    <col width="25%">
                    <col width="25%">
                </colgroup>
                <tr>
                    <th>구분</th>
                    <th>성명</th>
                    <th>서명</th>
                    <th>연락처</th>
                </tr>                
                <%-- 담당 손해사정사 정보로 변경 시작 --%>               	               	               	
               	<c:forEach items="${certiManager4ReportUser}" var="certiUserVo">
               		<c:if test="${certiUserVo.certi_state_val eq '손해사정사'}">
	               		<tr>
	               			<td>${certiUserVo.certi_state_val}</td>
	               			<td>${certiUserVo.user_name}</td>
	               			<td>
	               				<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${certiUserVo.user_no}/${certiUserVo.user_sign}" width="50px" height="50px">
	               			</td>
	               			<td>
	               				<c:if test='${certiUserVo.work_phone != ""}'>${certiUserVo.work_phone} </c:if>
	               			</td>
	               		</tr>
               		</c:if>
               	</c:forEach>
                <%-- 담당 손해사정사 정보로 변경 끝 --%>
                <tr>
                    <td>팀&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;장</td>
                    <td>
                        ${reportAprvUser.userName}<br/>
                        <c:if test="${reportAprvUser.workLevel != null && reportAprvUser.workLevel != ''}">
                            (${reportAprvUser.disWorkLevel})
                        </c:if>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${reportAprvUser.userSign != null}">
                                <img width="50" height="50" src="https://toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${reportAprvUser.userNo}/${reportAprvUser.userSign}"/>
                            </c:when>
                            <c:otherwise>
                                사인없음
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${reportAprvUser.handphone}</td>
                </tr>                
                <tr>
                    <td>조 &nbsp;&nbsp;사 &nbsp;&nbsp;자</td>
                    <td>${reportInvgUser.userName } <br />(${reportInvgUser.disWorkLevel})</td>
                    <td>
                        <c:choose>
                            <c:when test="${reportInvgUser.userSign != null}">
                                <img width="50" height="50" src="https://toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${reportInvgUser.userNo}/${reportInvgUser.userSign}"/>
                            </c:when>
                            <c:otherwise>
                                사인없음
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${reportInvgUser.handphone }</td>
                </tr>
            </table>
        </div>
        <!-- 1.계약 확인사항 -->
        <div class="display-table" style="margin-top: 50px;">
            <div class="display-cell">
                <p class="subtitle">1.계약확인사항</p>
            </div>
            <div class="display-cell text-right">
                <a id="btn_cont_edit" href="#noloc" onclick="fnContractEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
                <a id="btn_cont_save" href="#noloc" style="display: none" onclick="fnContractSave();"><img src="./resources/ls_img/icon_write.gif"/></a>
                <a id="btn_cont_cancel" href="#noloc" onclick="fnContractCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
            </div>
        </div>
        <script type="text/javascript">
            function fnContractEdit(){
                $("#btn_cont_edit").hide();
                $("#btn_cont_save").show();
                $("#btn_cont_cancel").show();

                $("#table_contract_view").hide();
                $("#table_contract_edit").show();
            }
            function fnContractCancel() {
                $("#btn_cont_edit").show();
                $("#btn_cont_save").hide();
                $("#btn_cont_cancel").hide();

                $("#table_contract_view").show();
                $("#table_contract_edit").hide();
            }

            function fnContractSave() {
                var param = {};
                param.suim_rpt_no       = $("#suim_rpt_no").val();
                param.insurance_nm      = $("#c_insurance_nm").val();
                param.policy_no         = $("#c_policy_no").val();
                param.insu_term1        = $("#c_insu_term1").val();
                param.insu_term1_sdate        = $("#c_insu_term1_sdate").val();
                param.insu_term1_edate        = $("#c_insu_term1_edate").val();
                param.face_insured_job6 = $("#c_face_insured_job6").val();

                var url = "./report_contract_update";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#div_contract").html(data);
                        fnContractCancel();
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
        <div id="div_contract">
            <table id="table_contract_view">
                <col width="25%">
                <col width="75%">
                <tr>
                    <th>보험종목</th>
                    <td>${reportBscInfo.insuranceNm}</td>
                </tr>
                <tr>
                    <th>증권번호</th>
                    <td>${reportBscInfo.policyNo}</td>
                </tr>
                <tr>
                    <th>보험기간</th>
                    <td>
                    	<c:choose>
                    		<c:when test="${empty reportPrint1.insuTerm1 or reportPrint1.insuTerm1 eq ''}">
                    			${reportPrint1.insuTerm1Sdate} ~ ${reportPrint1.insuTerm1Edate}
                    		</c:when>
                    		<c:otherwise>${reportPrint1.insuTerm1}</c:otherwise>
                    	</c:choose>                    
                    </td>
                </tr>
                <tr>
                    <th>계약자 / 피보험자</th>
                    <td>${reportBscInfo.policyholderNm} / ${reportBscInfo.beneficiaryNm}</td>
                </tr>
                <tr>
                    <th>직무확인사항</th>
                    <td>${reportPrint1.faceInsuredJob6}</td>
                </tr>
            </table>
            <table id="table_contract_edit" style="display:none;">
                <col width="25%">
                <col width="75%">
                <tr>
                    <th>보험종목</th>
                    <td><input type="text" id="c_insurance_nm" value="${reportBscInfo.insuranceNm}"></td>
                </tr>
                <tr>
                    <th>증권번호</th>
                    <td><input type="text" id="c_policy_no" value="${reportBscInfo.policyNo}"></td>
                </tr>
                <tr>
                    <th>보험기간</th>
                    <td>
                    	<c:choose>
                    		<c:when test="${empty reportPrint1.insuTerm1 or reportPrint1.insuTerm1 eq ''}">
                    			<input type="text" class="calendar" style="width:100px;" id="c_insu_term1_sdate" value="${reportPrint1.insuTerm1Sdate}"> ~ <input type="text" class="calendar" style="width:100px;" id="c_insu_term1_edate" value="${reportPrint1.insuTerm1Edate}">
                    		</c:when>
                    		<c:otherwise><input type="text" id="c_insu_term1" value="${reportPrint1.insuTerm1}"></c:otherwise>                    		
                    	</c:choose>                    	
                    </td>
                </tr>
                <tr>
                    <th>계약자 / 피보험자</th>
                    <td>${reportBscInfo.policyholderNm} / ${reportBscInfo.beneficiaryNm}</td>
                </tr>
                <tr>
                    <th>직무확인사항</th>
                    <td><input type="text" id="c_face_insured_job6" value="${reportPrint1.faceInsuredJob6}"></td>
                </tr>
            </table>
        </div>
        <!--// 1.계약 확인사항 -->
        <!-- 2.청구사항 시작-->
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle">2.청구사항</p>
            </div>
            <div class="display-cell text-right">
                <a id="btn_claim_edit" href="#noloc" onclick="fnClaimEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
                <a id="btn_claim_save" href="#noloc" onclick="fnClaimSave();" style="display: none"><img src="./resources/ls_img/icon_write.gif"/></a>
                <a id="btn_claim_cancel" href="#noloc" onclick="fnClaimCancel();" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>
            </div>
        </div>
        <script type="text/javascript">
            function fnClaimEdit(){
                $("#btn_claim_edit").hide();
                $("#btn_claim_save").show();
                $("#btn_claim_cancel").show();

                $(".tr_claim_view").hide();
                $(".tr_claim_edit").show();                
            }

            function fnClaimCancel(){
                $("#btn_claim_edit").show();
                $("#btn_claim_save").hide();
                $("#btn_claim_cancel").hide();

                $(".tr_claim_view").show();
                $(".tr_claim_edit").hide();

            }

            function fnClaimSave(){
                var param = {};
                param.suim_rpt_no       = $("#suim_rpt_no").val();
                param.diagnosis_disease3      = $("#c_diagnosis_disease3").val().replace(/\n/g, "\r\n");
                param.diagnosis_hospital3         = $("#c_diagnosis_hospital3").val();

                var url = "./report_claim_update";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#div_claim").html(data);
                        fnClaimCancel();
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

            function fnClaimSubAdd(){
                $("#btn_claim_sub_add").hide();
                $("#tr_claim_sub_add").show();
            }
            
            function fnClaimSubAdd2(){
                $("#btn_claim_sub_add2").hide();
                $("#tr_claim_sub_add2").show();
            }

            function fnClaimSubCancel(){
                $("#btn_claim_sub_add").show();
                $("#tr_claim_sub_add").hide();
            }
            
            function fnClaimSubCancel3(){
                $("#btn_claim_sub_add2").show();
                $("#tr_claim_sub_add2").hide();
            }

            function fnClaimSubSave(){

                if($("#c_assure_dtl").val() == ""){
                    alert("담보사항을 입력해 주세요.");
                    $("#c_assure_dtl").focus();
                    return;
                }
                if($("#c_join_amount").val() == ""){
                    alert("가입금액을 입력해 주세요.");
                    $("#c_join_amount").focus();
                    return;
                }
                if($("#c_estimation_amount").val() == ""){
                    alert("추정손해액을 입력해 주세요.");
                    $("#c_estimation_amount").focus();
                    return;
                }


                var param = {};
                param.suim_rpt_no          = $("#suim_rpt_no").val();
                param.rpt_print_no          = $("#rpt_print_no").val();
                param.assure_dtl            = $("#c_assure_dtl").val();
                param.join_amount           = $("#c_join_amount").val().num();
                param.estimation_amount     = $("#c_estimation_amount").val().num();

                var url = "./report_claim_sub_insert";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#div_claim").html(data);
                        fnClaimCancel();
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
            
            function fnClaimSubUpdateSave2(p_serial_no){
            	
            	if($("#c_mortgage_type_"+p_serial_no).val() == ""){
                    alert("담보구분을 입력해 주세요.");
                    $("#c_mortgage_type_"+p_serial_no).focus();
                    return;
                }
                if($("#c_mortgage_amount_"+p_serial_no).val() == ""){
                    alert("담보내역을 입력해 주세요.");
                    $("#c_mortgage_amount_"+p_serial_no).focus();
                    return;
                }
                
                //var url = "./report_claim_sub2_insert";
                var url = "./report_claim_sub2_update";
            	
                var param = {};
                param.suim_rpt_no          = $("#suim_rpt_no").val();
                param.rpt_print_no          = $("#rpt_print_no").val();
                param.serial_no 				= p_serial_no;
                param.mortgage_type            = $("#c_mortgage_type_"+p_serial_no).val();
                param.mortgage_amount           = $("#c_mortgage_amount_"+p_serial_no).val().num();
                
                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#div_claim").html(data);
                        fnClaimCancel();
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
            
            function fnClaimSubSave2(){            	

                if($("#c_mortgage_type").val() == ""){
                    alert("담보구분을 입력해 주세요.");
                    $("#c_mortgage_type").focus();
                    return;
                }
                if($("#c_mortgage_amount").val() == ""){
                    alert("담보내역을 입력해 주세요.");
                    $("#c_mortgage_amount").focus();
                    return;
                }

                var param = {};
                param.suim_rpt_no          = $("#suim_rpt_no").val();
                param.rpt_print_no          = $("#rpt_print_no").val();
                param.mortgage_type            = $("#c_mortgage_type").val();
                param.mortgage_amount           = $("#c_mortgage_amount").val().num();                

                //var url = "./report_claim_sub_insert";
                var url = "./report_claim_sub2_insert";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#div_claim").html(data);
                        fnClaimCancel();
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

            function fnClaimSubEdit(idx) {
                $("#tr_claim_sub_view" + idx).hide();
                $("#tr_claim_sub_edit" + idx).show();
            }
            
            function fnClaimSubEdit2(idx){            
	            $("#tr_claim_sub_view" + idx).hide();
	            $("#tr_claim_sub_edit" + idx).show();
	        }
            
            function fnClaimSubCancel2(idx){            
	            $("#tr_claim_sub_view" + idx).show();
	            $("#tr_claim_sub_edit" + idx).hide();
	        }
            
            function fnClaimSubAddCancel2(){
            	$("#tr_claim_sub_view").show();
            	$("#btn_claim_sub_add2").show();            	
	            $("#tr_claim_sub_add2").hide();
            }
            
            //보고서의 추정금액을 에디터창으로 바꾼다.
            function fnClaimSubEdit3(suim_rpt_no_val){
            	$("#estimation_view").hide();
            	$("#estimation_edit").show();
            }
            
            //보고서 추정금액 수정창 닫기
            function fnClaimSubCancel3(){
            	$("#estimation_view").show();
            	$("#estimation_edit").hide();
            }
            
            //보고서 추정금액 수정하기
            function fnClaimSubSave3(suim_rpt_no_val){
            	
            	var url = "./updateEstimationValue";
            	
            	var param = {};
            	
            	param.suim_rpt_no = suim_rpt_no_val;
            	param.estimation_amount = $("#estimation_amount_val").val().num();
            	
            	$.ajax({
            		type: "POST",
    		        url: url,
    		        data: param,    		        
    		        timeout: 20000,    		         
    		        success: function(data){
    		        	$("#esimation_amount_result").html("<span id='esimation_amount_result' class='money'>"+data+"</span>");
    		        	$("#estimation_view").show();
    	            	$("#estimation_edit").hide();
    		        },
    		        error: function(e){
    		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
    		        }            		
            	});
            	
            }
            
            //수임번호를 가지고 추정금액을 가지고 온다.
            function getEstimation(suim_rpt_no_val){
            	
            	var url = "./getEstimationValue";
            	
            	var param = {};
            	param.suim_rpt_no = suim_rpt_no_val;            	
            	$.ajax({
            		type: "POST",
    		        url: url,
    		        data: param,    		        
    		        timeout: 20000,    		         
    		        success: function(data){
    		        	alert("data="+data);
    		        },
    		        error: function(e){
    		            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
    		        }            		
            	});            	
            }

            function fnClaimSubClose(idx) {
                $("#tr_claim_sub_view" + idx).show();
                $("#tr_claim_sub_edit" + idx).hide();
            }

            function fnClaimSubUpdate(idx) {
                if($("#c_assure_dtl" + idx).val() == ""){
                    alert("담보사항을 입력해 주세요.");
                    $("#c_assure_dtl" + idx).focus();
                    return;
                }
                if($("#c_join_amount" + idx).val() == ""){
                    alert("가입금액을 입력해 주세요.");
                    $("#c_join_amount" + idx).focus();
                    return;
                }
                if($("#c_estimation_amount" + idx).val() == ""){
                    alert("추정손해액을 입력해 주세요.");
                    $("#c_estimation_amount" + idx).focus();
                    return;
                }


                var param = {};
                param.suim_rpt_no           = $("#suim_rpt_no").val();
                param.rpt_print_no          = $("#rpt_print_no").val();
                param.serial_no             = $("#c_serial_no" + idx).val();
                param.assure_dtl            = $("#c_assure_dtl" + idx).val();
                param.join_amount           = $("#c_join_amount" + idx).val().num();
                param.estimation_amount     = $("#c_estimation_amount" + idx).val().num();

                var url = "./report_claim_sub_update";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#div_claim").html(data);
                        fnClaimCancel();
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
            
            function fnClaimSubDelete2(serialNo) {
                if (confirm("삭제하시겠습니까?")){                	
                    var param = {};
                    param.suim_rpt_no           = $("#suim_rpt_no").val();
                    param.rpt_print_no          = $("#rpt_print_no").val();
                    param.serial_no             = serialNo;
                    
                    var url = "./report_claim_sub2_delete";

                    $.ajax({
                        type: "POST",
                        url: url,
                        data: param,
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        dataType: "html",
                        timeout: 20000,
                        success: function(data){
                            $("#div_claim").html(data);
                            fnClaimCancel();
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
            }

            function fnClaimSubDelete(idx) {
                if (confirm("삭제하시겠습니까?")){
                    var param = {};
                    param.suim_rpt_no           = $("#suim_rpt_no").val();
                    param.rpt_print_no          = $("#rpt_print_no").val();
                    param.serial_no             = $("#c_serial_no" + idx).val();

                    var url = "./report_claim_sub_delete";

                    $.ajax({
                        type: "POST",
                        url: url,
                        data: param,
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        dataType: "html",
                        timeout: 20000,
                        success: function(data){
                            $("#div_claim").html(data);
                            fnClaimCancel();
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
            }
        </script>
        <div id="div_claim">
            <table id="table_claim">
                <col width="25%">
                <col width="22%">
                <col width="22%">
                <col width="22%">
                <col width="9%">
                <tr>
                    <th>구분</th>
                    <th colspan="4">내용</th>
                </tr>
                <tr class="tr_claim_view">
                    <th>진단병명</th>
                    <td colspan="4">
                        ${fn:replace(fn:replace(fn:escapeXml(reportPrint1.diagnosisDisease3) , CRLF , '<br>'), ' ', '&nbsp;')}
                    </td>
                </tr>
                <tr class="tr_claim_view">
                    <th>진단병원</th>
                    <td colspan="4">${reportPrint1.diagnosisHospital3}</td>
                </tr>
                <tr class="tr_claim_edit" style="display: none">
                    <th>진단병명</th>
                    <td colspan="4">
                        <textarea id="c_diagnosis_disease3" style="height: 50px;">${reportPrint1.diagnosisDisease3}</textarea>
                        <%--<input type="text" id="c_diagnosis_disease3" value="${reportPrint1.diagnosisDisease3}">--%>
                    </td>
                </tr>
                <tr class="tr_claim_edit" style="display: none">
                    <th>진단병원</th>
                    <td colspan="4"><input type="text" id="c_diagnosis_hospital3" value="${reportPrint1.diagnosisHospital3}"></td>
                </tr>
                <!-- 담보내역 및 추정손해액 조건 체크 -->
                <c:choose>
                	<%--기존 정보가 있는 경우--%>
                	<c:when test="${reportAssureList.size() > 0}">
                		<tr>
		                    <th rowspan="${(fn:length(reportAssureList) * 2) + 3}">
		                        담보내역<br/>
		                        및<br/>
		                        추정 손해액
		                    </th>
		                    <th>담보사항</th>
		                    <th>가입금액</th>
		                    <th>추정손해액</th>
		                    <th>
		                        <a href="#noloc" id="btn_claim_sub_add" onclick="fnClaimSubAdd();"><img src="./resources/ls_img/ls_body/btn_add.gif"></a>
		                    </th>
		                </tr>
		                <c:set var="claim_join_amount_total" value="0"/>
		                <c:set var="claim_estimation_amount_total" value="0"/>
		                <c:forEach  var="item" items="${reportAssureList}" varStatus="status">
		                    <c:set var="claim_join_amount_total" value="${claim_join_amount_total + item.joinAmount}"/>
		                    <c:set var="claim_estimation_amount_total" value="${claim_estimation_amount_total + item.estimationAmount}"/>
		                    <tr id="tr_claim_sub_view${status.index}">
		                        <td>${item.assureDtl}</td>
		                        <td style="text-align: right"><span class="money">${item.joinAmount}</span>원</td>
		                        <td style="text-align: right"><span class="money">${item.estimationAmount}</span>원</td>
		                        <td style="text-align: center">
		                            <a href="#noloc" id="btn_claim_sub_edit${status.index}" onclick="fnClaimSubEdit('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
		                            <a href="#noloc" id="btn_claim_sub_delete${status.index}" onclick="fnClaimSubDelete('${status.index}');"><img src='./resources/ls_img/btn_del_s.gif'></a>
		                        </td>
		                    </tr>
		                    <tr id="tr_claim_sub_edit${status.index}" style="display: none;">
		                        <td>
		                            <input type="text" id="c_assure_dtl${status.index}" value="${item.assureDtl}" maxlength="200">
		                            <input type="hidden" id="c_serial_no${status.index}" value="${item.serialNo}"/>
		                        </td>
		                        <td><input type="text" id="c_join_amount${status.index}" value="${item.joinAmount}" class="money" style="text-align: right" maxlength="12"></td>
		                        <td><input type="text" id="c_estimation_amount${status.index}" value="${item.estimationAmount}" class="money" style="text-align: right" maxlength="12"></td>
		                        <td style="text-align: center">
		                            <a href="#noloc" id="btn_claim_sub_update${status.index}" onclick="fnClaimSubUpdate('${status.index}');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                            <a href="#noloc" id="btn_claim_sub_close${status.index}" onclick="fnClaimSubClose('${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		                        </td>
		                    </tr>
		                </c:forEach>
		                <tr id="tr_claim_sub_add" style="display: none;">
		                    <td><input type="text" id="c_assure_dtl" value="" maxlength="200"></td>
		                    <td><input type="text" id="c_join_amount" value="" class="money" style="text-align: right" maxlength="12"></td>
		                    <td><input type="text" id="c_estimation_amount" value="" class="money" style="text-align: right" maxlength="12"></td>
		                    <td style="text-align: center">
		                        <a href="#noloc" id="btn_claim_sub_save" onclick="fnClaimSubSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                        <a href="#noloc" id="btn_claim_sub_cancel" onclick="fnClaimSubCancel();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		                    </td>
		                </tr>
		                <tr>
		                    <th>합계</th>
		                    <td style="text-align: right"><span class="money">${claim_join_amount_total}</span>원</td>
		                    <td style="text-align: right"><span class="money">${claim_estimation_amount_total}</span>원</td>
		                    <td style="text-align: center">-</td>
		                </tr>
                	</c:when>
                	<%-- 기존 정보 없이 담보 구분과 담보내역으로 표시되는 경우 by top3009 --%>
                	<c:otherwise>
                		<tr>
		                    <th rowspan="${(fn:length(reportAssureListSub) * 2) + 4}">
		                        담보내역<br/>
		                        및<br/>
		                        추정 손해액
		                    </th>
		                    <th colspan="2">담보구분</th>
		                    <th>담보내역</th>		                    
		                    <th>
		                        <a href="#noloc" id="btn_claim_sub_add2" onclick="fnClaimSubAdd2();"><img src="./resources/ls_img/ls_body/btn_add.gif"></a>
		                    </th>
		                </tr>		                
		                <c:forEach  var="item" items="${reportAssureListSub}" varStatus="status">		                	
		                	<tr id="tr_claim_sub_view${status.index}">
		                        <td colspan="2">${item.mortgageType}</td>
		                        <td style="text-align: right"><span class="money">${item.mortgageAmount}</span> 원</td>		                        
		                        <td style="text-align: center">
		                        	<a href="#noloc" id="btn_claim_sub2_edit${status.index}" onclick="fnClaimSubEdit2('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>		                            
		                            <a href="#noloc" id="btn_claim_sub2_delete${status.index}" onclick="fnClaimSubDelete2('${item.serialNo}');"><img src='./resources/ls_img/btn_del_s.gif'></a>
		                        </td>
		                    </tr>
		                    <tr id="tr_claim_sub_edit${status.index}" style="display:none;">
		                        <td colspan="2"><input type="text" id="c_mortgage_type_${item.serialNo}" value="${item.mortgageType}" maxlength="200"></td>
		                        <td style="text-align: right"><input type="text" id="c_mortgage_amount_${item.serialNo}" value="${item.mortgageAmount}" class="money" style="text-align: right" maxlength="12"></td>		                        
		                        <td style="text-align: center">		                            
		                        	<a href="#noloc" id="btn_claim_sub_save" onclick="fnClaimSubUpdateSave2('${item.serialNo}');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                        	<a href="#noloc" id="btn_claim_sub_cancel" onclick="fnClaimSubCancel2('${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>    
		                        </td>
		                    </tr>		                    	                    			                
		                </c:forEach>
		                <tr id="tr_claim_sub_add2" style="display: none;">		                		                
		                    <td colspan="2"><input type="text" id="c_mortgage_type" value="" maxlength="200"></td>
		                    <td><input type="text" id="c_mortgage_amount" value="" class="money" style="text-align: right" maxlength="12"></td>		                    
		                    <td style="text-align: center">
		                        <a href="#noloc" id="btn_claim_sub_save" onclick="fnClaimSubSave2();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                        <a href="#noloc" id="btn_claim_sub_cancel" onclick="fnClaimSubAddCancel2();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		                    </td>
		                </tr>
		                <tr id="estimation_view" style="display:">
		                	<th colspan="2">추정금액</th>
		                	<td style="text-align: right"><span id="esimation_amount_result" class="money">${reportPrint1.estimationAmount}</span> 원</td>
		                	<td style="text-align: center">
		                		<a href="#noloc" id="" onclick="fnClaimSubEdit3('${reportPrint1.suimRptNo}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>		                        
		                	</td>
		                </tr>
		                <tr id="estimation_edit" style="display:none">
		                	<th colspan="2">추정금액</th>
		                	<td style="text-align: right">		                		
		                		<input type="text" id="estimation_amount_val" value="${reportPrint1.estimationAmount}" class="money" style="text-align: right" maxlength="12">
		                	</td>
		                	<td style="text-align: center">
		                		<a href="#noloc" id="btn_claim_sub_save" onclick="fnClaimSubSave3('${reportPrint1.suimRptNo}');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                        <a href="#noloc" id="btn_claim_sub_cancel" onclick="fnClaimSubCancel3();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>		                        
		                	</td>
		                </tr>
                	</c:otherwise>
                </c:choose>                
            </table>
        </div>
        <!--// 2.청구사항 시작-->
        <!-- 3.타 보험사 계약 및 지급 사항 시작 -->
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle">3.타 보험사 계약 및 지급사항</p>
            </div>
            <div class="display-cell text-right">
                <a id="btn_insure_add" href="#noloc" onclick="fnOtherInsuAdd();"><img src="./resources/ls_img/ls_body/btn_add.gif"/></a>
            </div>
        </div>
        <script type="text/javascript">
            function fnOtherInsuAdd() {
                $("#btn_insure_add").hide();
                $("#tr_other_insu_add").show();
            }

            function fnOtherInsuCancel() {
                $("#btn_insure_add").show();
                $("#tr_other_insu_add").hide();
            }

            function fnOtherInsuSave() {

                if($("#o_other_insu_com").val() == ""){
                    alert("보험사를 입력해 주세요.");
                    $("#o_other_insu_com").focus();
                    return;
                }
                if($("#o_other_insu_dtl").val() == ""){
                    alert("계약내용을 입력해 주세요.");
                    $("#o_other_insu_dtl").focus();
                    return;
                }
                if($("#o_other_insu_contract").val() == ""){
                    alert("중요사항을 입력해 주세요.");
                    $("#o_other_insu_contract").focus();
                    return;
                }


                var param = {};
                param.suim_rpt_no          = $("#suim_rpt_no").val();
                param.rpt_print_no         = $("#rpt_print_no").val();
                param.other_insu_com       = $("#o_other_insu_com").val();
                param.other_insu_dtl       = $("#o_other_insu_dtl").val();
                param.other_insu_contract  = $("#o_other_insu_contract").val();

                var url = "./report_other_insu_insert";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#div_other_insu").html(data);
                        fnOtherInsuCancel();
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

            function fnOtherInsuEdit(idx) {
                $("#tr_other_insu_view" + idx).hide();
                $("#tr_other_insu_edit" + idx).show();
            }

            function fnOtherInsuClose(idx){
                $("#tr_other_insu_view" + idx).show();
                $("#tr_other_insu_edit" + idx).hide();
            }

            function fnOtherInsuUpdate(idx){

                if($("#o_other_insu_com" + idx).val() == ""){
                    alert("보험사를 입력해 주세요.");
                    $("#o_other_insu_com" + idx).focus();
                    return;
                }
                if($("#o_other_insu_dtl" + idx).val() == ""){
                    alert("계약내용을 입력해 주세요.");
                    $("#o_other_insu_dtl" + idx).focus();
                    return;
                }
                if($("#o_other_insu_contract" + idx).val() == ""){
                    alert("중요사항을 입력해 주세요.");
                    $("#o_other_insu_contract" + idx).focus();
                    return;
                }


                var param = {};
                param.suim_rpt_no           = $("#suim_rpt_no").val();
                param.rpt_print_no          = $("#rpt_print_no").val();
                param.serial_no             = $("#o_serial_no" + idx).val();
                param.other_insu_com        = $("#o_other_insu_com" + idx).val();
                param.other_insu_dtl        = $("#o_other_insu_dtl" + idx).val();
                param.other_insu_contract   = $("#o_other_insu_contract" + idx).val();

                var url = "./report_other_insu_update";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#div_other_insu").html(data);
                        fnOtherInsuCancel();
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

            function fnOtherInsuDelete(idx){
                if (confirm("삭제하시겠습니까?")){
                    var param = {};
                    param.suim_rpt_no           = $("#suim_rpt_no").val();
                    param.rpt_print_no          = $("#rpt_print_no").val();
                    param.serial_no             = $("#o_serial_no" + idx).val();

                    var url = "./report_other_insu_delete";

                    $.ajax({
                        type: "POST",
                        url: url,
                        data: param,
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        dataType: "html",
                        timeout: 20000,
                        success: function(data){
                            $("#div_other_insu").html(data);
                            fnOtherInsuCancel();
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
            }
        </script>
        <div id="div_other_insu">
            <table>
                <colgroup>
                    <col width="25%">
                    <col width="25%">
                    <col width="41%">
                    <col width="9%">
                </colgroup>
                <tr>
                    <th>보험사</th>
                    <th>계약내용</th>
                    <th>중요사항</th>
                    <th>-</th>
                </tr>
                <c:forEach  var="item" items="${reportOtherInsuList}" varStatus="status">
                    <tr id="tr_other_insu_view${status.index}">
                        <td>${item.otherInsuCom}</td>
                        <td>${item.otherInsuDtl}</td>
                        <td>${item.otherInsuContract}</td>
                        <td style="text-align: center">
                            <a href="#noloc" id="btn_insure_edit${status.index}" onclick="fnOtherInsuEdit('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
                            <a href="#noloc" id="btn_insure_delete${status.index}" onclick="fnOtherInsuDelete('${status.index}');"><img src='./resources/ls_img/btn_del_s.gif'></a>
                        </td>
                    </tr>
                    <tr id="tr_other_insu_edit${status.index}" style="display: none;">
                        <td>
                            <input type="text" id="o_other_insu_com${status.index}" value="${item.otherInsuCom}" maxlength="60">
                            <input type="hidden" id="o_serial_no${status.index}" value="${item.serialNo}"/>
                        </td>
                        <td>
                            <input type="text" id="o_other_insu_dtl${status.index}" value="${item.otherInsuDtl}">
                        </td>
                        <td>
                            <input type="text" id="o_other_insu_contract${status.index}" value="${item.otherInsuContract}" maxlength="120">
                        </td>
                        <td style="text-align: center">
                            <a href="#noloc" id="btn_insure_update${status.index}" onclick="fnOtherInsuUpdate('${status.index}');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                            <a href="#noloc" id="btn_insure_close${status.index}" onclick="fnOtherInsuClose('${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                        </td>
                    </tr>
                </c:forEach>
                <tr id="tr_other_insu_add" style="display: none;">
                    <td>
                        <input type="text" id="o_other_insu_com" value="" maxlength="60">
                    </td>
                    <td>
                        <input type="text" id="o_other_insu_dtl" value="" >
                    </td>
                    <td>
                        <input type="text" id="o_other_insu_contract" value="" maxlength="120">
                    </td>
                    <td style="text-align: center">
                        <a href="#noloc" id="btn_insure_save" onclick="fnOtherInsuSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        <a href="#noloc" id="btn_insure_cancel" onclick="fnOtherInsuCancel();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                    </td>
                </tr>
            </table>
        </div>
        <!--// 3.타 보험사 계약 및 지급 사항 시작 -->

        <!-- 4. 중정 조사사항 및 조사 결과 -->
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle">4.중점 조사사항 및 조사 결과</p>
            </div>
        </div>
        <script type="text/javascript">
            function fnEmphasisInvestEdit(){
                $("#tr_emphasis_invest_view").hide();
                $("#tr_emphasis_invest_edit").show();
            }

            function fnEmphasisInvestClose(){
                $("#tr_emphasis_invest_view").show();
                $("#tr_emphasis_invest_edit").hide();
            }

            function fnEmphasisInvestSave(){
                var param = {};
                param.suim_rpt_no           = $("#suim_rpt_no").val();
                param.rpt_print_no          = $("#rpt_print_no").val();
                param.inspect_point_4       = $("#textarea_emphasis_invest").val().replace(/\n/g, "\r\n");

                var url = "./report_emphasis_invest_update";
                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#div_emphasis_invest_result").html(data);
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

            function fnEmphasisResultEdit(){
                $("#tr_emphasis_result_view").hide();
                $("#tr_emphasis_result_edit").show();
            }

            function fnEmphasisResultClose(){
                $("#tr_emphasis_result_view").show();
                $("#tr_emphasis_result_edit").hide();
            }

            function fnEmphasisResultSave(){
                var param = {};
                param.suim_rpt_no           = $("#suim_rpt_no").val();
                param.rpt_print_no          = $("#rpt_print_no").val();
                param.inspect_result_4       = $("#textarea_emphasis_result").val().replace(/\n/g, "\r\n");

                var url = "./report_emphasis_result_update";
                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#div_emphasis_invest_result").html(data);
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

            function fnEmphasisInvestChange(that){
                if (that.value != ""){
                    $("#textarea_emphasis_invest").val($("#textarea_emphasis_invest").val() + that.value + '\n');
                }
                $("#textarea_emphasis_invest").focus();

            }

            function fnEmphasisResultChange(that){
                if (that.value != ""){
                    var tmp = "금번 보험금 청구에 대한 확인 결과,\n" + that.value + "\n귀사의 최종 검토 요청의견임.";
                    $("#textarea_emphasis_result").val(tmp);
                }else{
                    var tmp = "금번 보험금 청구에 대한 확인 결과,\n\n귀사의 최종 검토 요청의견임.";
                    $("#textarea_emphasis_result").val(tmp);
                }
                $("#textarea_emphasis_result").focus();
            }
            
            //조사결과 옵션 1수정
            function fnOption1Modify(){
            	
            	//줄바꿈 처리안한 데이터를 가져온다. (\n으로 처리됨)
            	var url = "./getResultOption1EditValue";
            	
            	var param = {};            	
            	param.suim_rpt_no = $("#suim_rpt_no").val();
            	
            	//초기안내문구
            	var option1_info = "청구병원인 OOOO 병원 확인 결과 금번 청구 진단병명인 OOOO 병명으로 진단 받고 OOOO 사실 확인됨";
            	
            	//수임번호로 조사결과 옵션 1값을 가져온다.            	
            	$.ajax({
            		type: "POST",
            		url: url,
            		data: param,    		        
            		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            		dataType: "html",
            		timeout: 20000,    		         
            		success: function(data){
            			if( data == ''){
            				$("#result_option1").val(option1_info);            				
            			}else{
            				$("#result_option1").val(data);
            			}
            			$("#result_option1_view").hide();
            			$("#result_option1").show();
            		},
            		error: function(e){
            		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
            		}            		
            	});            	
            	
            	
            	$("#option_1_modify").hide();
            	$("#option_1_save").show();
            	$("#option_1_close").show();            	
            }
            
          	//조사결과 옵션 1 저장
            function fnOption1Save(){
          		
				var url = "./updateResultOption1Value";
            	
            	var param = {};            	
            	param.suim_rpt_no = $("#suim_rpt_no").val();
            	param.result_option1 = $("#result_option1").val();
            	
            	$.ajax({
            		type: "POST",
            		url: url,
            		data: param,    		        
            		timeout: 20000,    		         
            		success: function(data){
            			if( data > 0){
            				alert('수정하였습니다.');
            				//저장하고 보기페이지로 전환
                			fnOption1Close();
            			}            			
            		},
            		error: function(e){
            		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
            		}            		
            	});           	
            	
            }
            
            function fnOption1Close(){
            	//기존 옵션 1정보를 가져온다.
            	var url = "./getResultOption1Value";
            	
            	var param = {};            	
            	param.suim_rpt_no = $("#suim_rpt_no").val();
            	
            	//수임번호로 조사결과 옵션 1값을 가져온다.            	
            	$.ajax({
            		type: "POST",
            		url: url,
            		data: param,
            		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            		dataType: "html",
            		timeout: 20000,    		         
            		success: function(data){            			
            			if( data == ''){
            				$("#result_option1_view").html("① 입력된 정보가 없습니다.");            				
            			}else{
            				$("#result_option1_view").html(data);
            			}
            			$("#result_option1").hide();
            			$("#result_option1_view").show();
            		},
            		error: function(e){
            		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
            		}            		
            	});
            	
            	$("#option_1_modify").show();
            	$("#option_1_save").hide();
            	$("#option_1_close").hide();
            }
            
          	//조사결과 옵션 2 저장
            function fnOption2Save(){
          		
				var url = "./updateResultOption2Value";
            	
            	var param = {};            	
            	param.suim_rpt_no = $("#suim_rpt_no").val();
            	param.result_option2 = $("#result_option2").val();
            	
            	$.ajax({
            		type: "POST",
            		url: url,
            		data: param,    		        
            		timeout: 20000,    		         
            		success: function(data){
            			if( data > 0){
            				alert('수정하였습니다.');
            				//저장하고 보기페이지로 전환
                			fnOption2Close();
            			}            			
            		},
            		error: function(e){
            		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
            		}            		
            	});           	
            	
            }
            
          	//조사결과 옵션 2수정
            function fnOption2Modify(){
            	
            	//줄바꿈 처리안한 데이터를 가져온다. (\n으로 처리됨)
            	var url = "./getResultOption2EditValue";
            	
            	var param = {};            	
            	param.suim_rpt_no = $("#suim_rpt_no").val();
            	
            	//초기안내문구
            	var option2_info = "OOOO 병원 의무기록지 OOO (OOOO / OOOOO) 에 의하면";
            	
            	//수임번호로 조사결과 옵션 2값을 가져온다.            	
            	$.ajax({
            		type: "POST",
            		url: url,
            		data: param,    		        
            		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            		dataType: "html",
            		timeout: 20000,    		         
            		success: function(data){
            			if( data == ''){
            				$("#result_option2").val(option2_info);            				
            			}else{
            				$("#result_option2").val(data);
            			}
            			$("#result_option2_view").hide();
            			$("#result_option2").show();
            		},
            		error: function(e){
            		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
            		}            		
            	});            	
            	
            	
            	$("#option_2_modify").hide();
            	$("#option_2_save").show();
            	$("#option_2_close").show();            	
            }
            
			function fnOption2Close(){
            	//기존 옵션 2정보를 가져온다.
            	var url = "./getResultOption2Value";
            	
            	var param = {};            	
            	param.suim_rpt_no = $("#suim_rpt_no").val();
            	
            	//수임번호로 조사결과 옵션 1값을 가져온다.            	
            	$.ajax({
            		type: "POST",
            		url: url,
            		data: param,
            		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            		dataType: "html",
            		timeout: 20000,    		         
            		success: function(data){            			
            			if( data == ''){
            				$("#result_option2_view").html("② 입력된 정보가 없습니다.");            				
            			}else{
            				$("#result_option2_view").html(data);
            			}
            			$("#result_option2").hide();
            			$("#result_option2_view").show();
            		},
            		error: function(e){
            		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
            		}            		
            	});
            	
            	$("#option_2_modify").show();
            	$("#option_2_save").hide();
            	$("#option_2_close").hide();
            }
            
          	//조사결과 옵션 3수정
            function fnOption3Modify(){
            	
            	//줄바꿈 처리안한 데이터를 가져온다. (\n으로 처리됨)
            	var url = "./getResultOption3EditValue";
            	
            	var param = {};            	
            	param.suim_rpt_no = $("#suim_rpt_no").val();            	
            	
            	//수임번호로 조사결과 옵션 3값을 가져온다.
            	$.ajax({
            		type: "POST",
            		url: url,
            		data: param,    		        
            		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            		dataType: "html",
            		timeout: 20000,    		         
            		success: function(data){
            			if( data == ''){
            				$("#result_option3").val();            				
            			}else{
            				$("#result_option3").val(data);
            			}
            			$("#result_option3_view").hide();
            			$("#result_option3").show();
            			$("#option3_radio").show();
            		},
            		error: function(e){
            		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
            		}            		
            	});            	
            	
            	
            	$("#option_3_modify").hide();
            	$("#option_3_save").show();
            	$("#option_3_close").show();            	
            }
          	
            function fnOption3Close(){
            	//기존 옵션 3정보를 가져온다.
            	var url = "./getResultOption3Value";
            	
            	var param = {};            	
            	param.suim_rpt_no = $("#suim_rpt_no").val();
            	
            	//수임번호로 조사결과 옵션 3값을 가져온다.            	
            	$.ajax({
            		type: "POST",
            		url: url,
            		data: param,
            		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            		dataType: "html",
            		timeout: 20000,    		         
            		success: function(data){            			
            			if( data == ''){
            				$("#result_option3_view").html("③ 입력된 정보가 없습니다.");            				
            			}else{
            				$("#result_option3_view").html(data);
            			}
            			$("#result_option3").hide();
            			$("#option3_radio").hide();
            			$("#result_option3_view").show();
            		},
            		error: function(e){
            		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
            		}            		
            	});
            	
            	$("#option_3_modify").show();
            	$("#option_3_save").hide();
            	$("#option_3_close").hide();
            }
            
			//조사결과 옵션 3 저장
            function fnOption3Save(){
          		
				var url = "./updateResultOption3Value";
            	
            	var param = {};            	
            	param.suim_rpt_no = $("#suim_rpt_no").val();
            	param.result_option3 = $("#result_option3").val();
            	
            	$.ajax({
            		type: "POST",
            		url: url,
            		data: param,    		        
            		timeout: 20000,    		         
            		success: function(data){
            			if( data > 0){
            				alert('수정하였습니다.');
            				//저장하고 보기페이지로 전환
                			fnOption3Close();
            			}            			
            		},
            		error: function(e){
            		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
            		}            		
            	});           	
            	
            }
          
          //조사결과 옵션 4수정
            function fnOption4Modify(){
            	
            	//줄바꿈 처리안한 데이터를 가져온다. (\n으로 처리됨)
            	var url = "./getResultOption4EditValue";
            	
            	var param = {};            	
            	param.suim_rpt_no = $("#suim_rpt_no").val();
            	
            	//수임번호로 조사결과 옵션 4값을 가져온다.            	
            	$.ajax({
            		type: "POST",
            		url: url,
            		data: param,    		        
            		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            		dataType: "html",
            		timeout: 20000,    		         
            		success: function(data){
            			if( data == ''){
            				$("#result_option4").attr('placeholder','직접입력 (예제) 제3 의료기관 (OOOO병원 의료자문결과, OOO암의 진단확정은 임상적 소견이 아닌) 조직적소견을 근거로 해당된다는 소견임');            				
            			}else{
            				$("#result_option4").val(data);
            			}
            			$("#result_option4_view").hide();
            			$("#result_option4").show();
            		},
            		error: function(e){
            		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
            		}            		
            	});            	
            	
            	
            	$("#option_4_modify").hide();
            	$("#option_4_save").show();
            	$("#option_4_close").show();            	
            }
          
            function fnOption4Close(){
            	//기존 옵션 4정보를 가져온다.
            	var url = "./getResultOption4Value";
            	
            	var param = {};            	
            	param.suim_rpt_no = $("#suim_rpt_no").val();
            	
            	//수임번호로 조사결과 옵션 4값을 가져온다.            	
            	$.ajax({
            		type: "POST",
            		url: url,
            		data: param,
            		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            		dataType: "html",
            		timeout: 20000,    		         
            		success: function(data){            			
            			if( data == ''){
            				$("#result_option4_view").html("④ 입력된 정보가 없습니다.");            				
            			}else{
            				$("#result_option4_view").html(data);
            			}
            			$("#result_option4").hide();
            			$("#result_option4_view").show();
            		},
            		error: function(e){
            		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
            		}            		
            	});
            	
            	$("#option_4_modify").show();
            	$("#option_4_save").hide();
            	$("#option_4_close").hide();
            }
            
			//조사결과 옵션 4 저장
            function fnOption4Save(){
          		
				var url = "./updateResultOption4Value";
            	
            	var param = {};            	
            	param.suim_rpt_no = $("#suim_rpt_no").val();
            	param.result_option4 = $("#result_option4").val();
            	
            	$.ajax({
            		type: "POST",
            		url: url,
            		data: param,    		        
            		timeout: 20000,    		         
            		success: function(data){
            			if( data > 0){
            				alert('수정하였습니다.');
            				//저장하고 보기페이지로 전환
                			fnOption4Close();
            			}            			
            		},
            		error: function(e){
            		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
            		}            		
            	});           	
            	
            }
			
         	//조사결과 옵션 5수정
            function fnOption5Modify(){
            	
            	//줄바꿈 처리안한 데이터를 가져온다. (\n으로 처리됨)
            	var url = "./getResultOption5EditValue";
            	
            	var param = {};            	
            	param.suim_rpt_no = $("#suim_rpt_no").val();            	
            	
            	//수임번호로 조사결과 옵션 5값을 가져온다.
            	$.ajax({
            		type: "POST",
            		url: url,
            		data: param,    		        
            		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            		dataType: "html",
            		timeout: 20000,    		         
            		success: function(data){
            			if( data == ''){
            				$("#result_option5").val();            				
            			}else{
            				$("#result_option5").val(data);
            			}
            			$("#result_option5_view").hide();
            			$("#result_option5").show();
            			$("#option5_radio").show();
            		},
            		error: function(e){
            		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
            		}            		
            	});            	
            	
            	
            	$("#option_5_modify").hide();
            	$("#option_5_save").show();
            	$("#option_5_close").show();            	
            }
          
            function fnOption5Close(){
            	//기존 옵션 3정보를 가져온다.
            	var url = "./getResultOption5Value";
            	
            	var param = {};            	
            	param.suim_rpt_no = $("#suim_rpt_no").val();
            	
            	//수임번호로 조사결과 옵션 5값을 가져온다.            	
            	$.ajax({
            		type: "POST",
            		url: url,
            		data: param,
            		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            		dataType: "html",
            		timeout: 20000,    		         
            		success: function(data){            			
            			if( data == ''){
            				$("#result_option5_view").html("⑤ 입력된 정보가 없습니다.");            				
            			}else{
            				$("#result_option5_view").html(data);
            			}
            			$("#result_option5").hide();
            			$("#option5_radio").hide();
            			$("#result_option5_view").show();
            		},
            		error: function(e){
            		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
            		}            		
            	});
            	
            	$("#option_5_modify").show();
            	$("#option_5_save").hide();
            	$("#option_5_close").hide();
            }
            
          	//조사결과 옵션 5 저장
            function fnOption5Save(){
          		
				var url = "./updateResultOption5Value";
            	
            	var param = {};            	
            	param.suim_rpt_no = $("#suim_rpt_no").val();
            	param.noti_content = $("#result_option5").val();
            	
            	$.ajax({
            		type: "POST",
            		url: url,
            		data: param,    		        
            		timeout: 20000,    		         
            		success: function(data){
            			if( data > 0){
            				alert('수정하였습니다.');
            				//저장하고 보기페이지로 전환
                			fnOption5Close();
            			}            			
            		},
            		error: function(e){
            		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
            		}            		
            	});           	
            	
            }
        </script>
        <div id="div_emphasis_invest_result">
            <table>
                <colgroup>
                    <col width="25%">
                    <col width="66%">
                    <col width="9%">
                </colgroup>
                <tr id="tr_emphasis_invest_view" style="height: 204px;">
                    <th>중점<br/>조사사항</th>
                    <td style="vertical-align: top;">
                        ${fn:replace(fn:replace(fn:escapeXml(reportPrint1.inspectPoint4) , CRLF , '<br>'), ' ', '&nbsp;')}
                    </td>
                    <td><a id="btn_emphasis_invest_edit" href="#noloc" onclick="fnEmphasisInvestEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a></td>
                </tr>
                <tr id="tr_emphasis_invest_edit" style="display: none">
                    <th>중점<br/>조사사항</th>
                    <td>
                        <select id="select_emphasis_invest" style="margin-bottom: 5px;" onchange="fnEmphasisInvestChange(this);" >
                            <option value="">직접입력</option>
                            <c:forEach  var="item" items="${reportPointCodeList}" varStatus="status">
                                <option value="${item.colVal}">${item.colVal}</option>
                            </c:forEach>
                        </select>
                        <textarea id="textarea_emphasis_invest" style="height: 150px;">${reportPrint1.inspectPoint4}</textarea>
                    </td>
                    <td>
                        <a id="btn_emphasis_invest_save" href="#noloc" onclick="fnEmphasisInvestSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        <a id="btn_emphasis_invest_close" href="#noloc" onclick="fnEmphasisInvestClose();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                    </td>
                </tr>
                <!-- 조사결과 포멧 수정 시작 by top3009 -->
               	<tr>
               		<th rowspan="5">
               			조사결과
               		</th>
               		<td>
               			<b>ㅁ 담보여부</b><br/>
               			<textarea id="result_option1" style="display:none;height: 80px;"></textarea>
               			<span id="result_option1_view"></span>
               		</td>
               		<td>
               			<a id="option_1_modify" href="#noloc" onclick="fnOption1Modify();"><img src="./resources/ls_img/btn_edite.gif" /></a>
               			<a id="option_1_save" href="#noloc" onclick="fnOption1Save();" style="display:none;"><img src="./resources/ne_img/btn/btn_save.gif" /></a>
               			<a id="option_1_close" href="#noloc" onclick="fnOption1Close();" style="display:none;"><img src="./resources/ne_img/btn/btn_close.gif" style="margin-top: 5px;"/></a>
               		</td>               		
               	</tr>
               	<tr>
               		<td>
               			<textarea id="result_option2" style="display:none;height: 120px;"></textarea>
               			<span id="result_option2_view"></span>
               		</td>
               		<td>
               			<a id="option_2_modify" href="#noloc" onclick="fnOption2Modify();"><img src="./resources/ls_img/btn_edite.gif" /></a>
               			<a id="option_2_save" href="#noloc" onclick="fnOption2Save();" style="display:none;"><img src="./resources/ne_img/btn/btn_save.gif" /></a>
               			<a id="option_2_close" href="#noloc" onclick="fnOption2Close();" style="display:none;"><img src="./resources/ne_img/btn/btn_close.gif" style="margin-top: 5px;"/></a>
               		</td>
               	</tr>
               	
               	<tr>
               		<td>
               			<div id="option3_radio" style="display:none;">
               				<table style="background-color:#ECECEC;">
               					<tr>
               						<td>
               							<input type="radio" name="option3_radio_type"  id="option3_radio_type1" value="1"> 본 보험 가입(OOOO.OO.OO) 이전 동일 진단 및 인과관계 있는 병명으로 치료한 사실이 없음 
               						</td>               						
               					</tr>
               					<tr>
               						<td>
               							<input type="radio" name="option3_radio_type" id="option3_radio_type2" value="2"> 보험가입 전인 동일 진단 병명인 OOO으로 OOOO년 OO월 OO일 ~ OOOO년 OO월 OO일 까지 OO병원에서 OOOO 한 사실이 확인됨
               						</td>
               					</tr>
               				</table>               				
               			</div>
               			<textarea id="result_option3" style="display:none;height: 120px;"></textarea>
               			<span id="result_option3_view"></span>
               		</td>
               		<td>
               			<a id="option_3_modify" href="#noloc" onclick="fnOption3Modify();"><img src="./resources/ls_img/btn_edite.gif" /></a>
               			<a id="option_3_save" href="#noloc" onclick="fnOption3Save();" style="display:none;"><img src="./resources/ne_img/btn/btn_save.gif" /></a>
               			<a id="option_3_close" href="#noloc" onclick="fnOption3Close();" style="display:none;"><img src="./resources/ne_img/btn/btn_close.gif" style="margin-top: 5px;"/></a>
               		</td>
               	</tr>
               	
               	<tr>
               		<td>
               			<textarea id="result_option4" style="display:none;height: 120px;"></textarea>
               			<span id="result_option4_view"></span>
               		</td>
               		<td>
               			<a id="option_4_modify" href="#noloc" onclick="fnOption4Modify();"><img src="./resources/ls_img/btn_edite.gif" /></a>
               			<a id="option_4_save" href="#noloc" onclick="fnOption4Save();" style="display:none;"><img src="./resources/ne_img/btn/btn_save.gif" /></a>
               			<a id="option_4_close" href="#noloc" onclick="fnOption4Close();" style="display:none;"><img src="./resources/ne_img/btn/btn_close.gif" style="margin-top: 5px;"/></a>
               		</td>
               	</tr>
               	
               	<tr>
               		<td>
               			<b>ㅁ 고지의무 위반여부</b><br/>
               			<div id="option5_radio" style="display:none;">
               				<table style="background-color:#ECECEC;">
               					<tr>
               						<td>
               							<input type="radio" name="option5_radio_type"  id="option5_radio_type1" value="1"> 재척기간 경과건으로 해당사항 없음 
               						</td>               						
               					</tr>
               					<tr>
               						<td>
               							<input type="radio" name="option5_radio_type" id="option5_radio_type2" value="2"> 계약전 알릴의무 위반사항 확인되지 않음
               						</td>
               					</tr>
               					<tr>
               						<td>
               							<input type="radio" name="option5_radio_type" id="option5_radio_type3" value="3"> 피보험자는 본 보험 가입(OOOO.OO.OO) 이전인 OOOO년 OO월 OO일 OO병원에서 OO병명으로 OOOO년 OO월 OO일 부터 OOOO년 OO월 OO일까지 OOOO OOO OOO 한 사실이 확인 됨
               						</td>
               					</tr>
               					<tr>
               						<td>
               							<input type="radio" name="option5_radio_type" id="option5_radio_type4" value="4"> 피보험자는 본 보험 가입(OOOO.OO.OO) 당시 OOOO 로 직업 고지하였으며, 확인 결과 OOOO으로 확인됨 
               						</td>
               					</tr>
               					<tr>
               						<td>
               							<input type="radio" name="option5_radio_type" id="option5_radio_type5" value="5"> 직접입력
               						</td>
               					</tr>
               				</table>               				
               			</div>
               			<textarea id="result_option5" style="display:none;height: 120px;"></textarea>
               			<span id="result_option5_view"></span>
               		</td>
               		<td>
               			<a id="option_5_modify" href="#noloc" onclick="fnOption5Modify();"><img src="./resources/ls_img/btn_edite.gif" /></a>
               			<a id="option_5_save" href="#noloc" onclick="fnOption5Save();" style="display:none;"><img src="./resources/ne_img/btn/btn_save.gif" /></a>
               			<a id="option_5_close" href="#noloc" onclick="fnOption5Close();" style="display:none;"><img src="./resources/ne_img/btn/btn_close.gif" style="margin-top: 5px;"/></a>
               		</td>
               	</tr>
               	
                <!-- 조사결과 포멧 수정 끝 by top3009 -->                
            </table>
        </div>
        <!--// 4. 중정 조사사항 및 조사 결과 -->
        <!-- 5.총괄 경과표 -->
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle">5.총괄 경과표</p>
            </div>
            <div class="display-cell text-right">            
            	<a href="#noloc" id="btn_summary_insu_add" onclick="fnSummaryInsuAdd();"><button class="btn btn-default" onclick="fnSummaryInsuAdd();">보험가입정보추가</button></a>&nbsp;
                <a href="#noloc" id="btn_summary_add" onclick="fnSummaryAdd();"><img src="./resources/ls_img/ls_body/btn_add.gif"/></a>
            </div>                        
        </div>        
            <table>
            	<tr>
            		<th width="20%">일자</th>
            		<th width="55%">내용</th>
            		<th width="15%">비고</th>
            		<th width="10%">-</th>
            	</tr>
            </table>
            <table>
            	<tr id="report_summary_insu_addform" style="display:none;">
            		<td width="20%">
            			<input type="text" id="summary_insu_write_date" class="calendar" style="width:90px;"/>
            		</td>
            		<td width="55%">
            			<input type="text" id="summary_insu_subject" value="${reportBscInfo.insuranceNm}">
            		</td>
            		<td width="15%">
            			<input type="text" id="remark_insu_content"/>
            		</td>
            		<td  width="10%" style="text-align: center">
                        <a href="#noloc" onclick="fnSummaryInsuSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        <a href="#noloc" onclick="fnSummaryCancel();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                    </td>
            	</tr>
            </table>
            <table>
            	<tr id="report_summary_addform" style="display:none;">
            		<td width="20%">
            			<input type="text" id="summary_write_date" class="calendar" style="width:90px;"/>
            		</td>
            		<td width="55%">
            			<table>
            				<tr>
            					<td width="20%" style="background-color:#ececec;text-align:center">초진일자</td>
            					<td width="80%"><input type="text" id="first_date" class="calendar" style="width:90px;"/></td>
            				</tr>
            				<tr>
            					<td width="20%" style="background-color:#ececec;text-align:center">내원일자</td>
            					<td width="80%"><input type="text" id="income_date" class="calendar" style="width:90px;"/></td>
            				</tr>
            				<tr>
            					<td width="20%" style="background-color:#ececec;text-align:center">내원경위</td>
            					<td width="80%"><textarea id="income_content" style="height: 50px;"></textarea></td>
            				</tr>
            				<!-- <tr>
            					<td width="20%" style="background-color:#ececec;text-align:center">진단병명</td>
            					<td width="80%"><input type="text" id="disease_name"/></td>
            				</tr> -->
            				<tr>
            					<td width="20%" style="background-color:#ececec;text-align:center">진단병명</td>
            					<td width="80%"><textarea id="disease_name" style="height: 50px;"></textarea></td>
            				</tr>
            				<tr>
            					<td width="20%" style="background-color:#ececec;text-align:center">검사사항</td>
            					<td width="80%"><textarea id="inspection_content" style="height: 50px;"></textarea></td>            					
            				</tr>
            				<tr>
            					<td width="20%" style="background-color:#ececec;text-align:center">수술명</td>
            					<td width="80%"><textarea id="operation_content" style="height: 50px;"></textarea></td>            					
            				</tr>
            				<tr>
            					<td width="20%" style="background-color:#ececec;text-align:center">장해진단일</td>
            					<td width="80%"><input type="text" id="obstacle_date" class="calendar" style="width:90px;"/></td>
            				</tr>
            				<tr>
            					<td width="20%" style="background-color:#ececec;text-align:center">장해진단명</td>
            					<td width="80%"><textarea id="obstacle_subject" style="height: 50px;"></textarea></td>            					
            				</tr>
            				<tr>
            					<td width="20%" style="background-color:#ececec;text-align:center">장해내용</td>
            					<td width="80%"><textarea id="obstacle_content" style="height: 50px;"></textarea></td>            					
            				</tr>
            				<!-- <tr>
            					<td width="20%" style="background-color:#ececec;text-align:center">입원기간</td>
            					<td width="80%"><input type="text" id="enter_interval"/></td>
            				</tr> -->
            				<tr>
            					<td width="20%" style="background-color:#ececec;text-align:center">입원기간</td>
            					<td width="80%"><textarea id="enter_interval" style="height: 50px;"></textarea></td>
            				</tr>
            				<!-- <tr>
            					<td width="20%" style="background-color:#ececec;text-align:center">통원기간</td>
            					<td width="80%"><input type="text" id="going_interval"/></td>
            				</tr> -->
            				<tr>
            					<td width="20%" style="background-color:#ececec;text-align:center">통원기간</td>
            					<td width="80%"><textarea id="going_interval" style="height: 50px;"></textarea></td>
            				</tr>
            				<!-- <tr>
            					<td width="20%" style="background-color:#ececec;text-align:center">과거병력</td>
            					<td width="80%"><input type="text" id="past_disease"/></td>
            				</tr> -->
            				<tr>
            					<td width="20%" style="background-color:#ececec;text-align:center">과거병력</td>
            					<td width="80%"><textarea id="past_disease" style="height: 50px;"></textarea></td>
            				</tr>
            				<!-- <tr>
            					<td width="20%" style="background-color:#ececec;text-align:center">외출외박</td>
            					<td width="80%"><input type="text" id="outing_content"/></td>
            				</tr> -->
            				<tr>
            					<td width="20%" style="background-color:#ececec;text-align:center">외출외박</td>
            					<td width="80%"><textarea id="outing_content" style="height: 50px;"></textarea></td>
            				</tr>
            				<tr>
            					<td width="20%" style="background-color:#ececec;text-align:center">기타사항</td>
            					<td width="80%"><textarea id="option_content" style="height: 50px;"></textarea></td>            					
            				</tr>
            				<tr>
            					<td width="20%" style="background-color:#ececec;text-align:center">의사의견</td>
            					<td width="80%"><textarea id="doctor_opinion" style="height: 50px;"></textarea></td>            					
            				</tr>
            			</table>
            		</td>
            		<td width="15%">
            			<input type="text" id="remark_content"/>
            		</td>
            		<td  width="10%" style="text-align: center">
                        <a href="#noloc" onclick="fnSummarySave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        <a href="#noloc" onclick="fnSummaryCancel();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                    </td>
            	</tr>
            	<!-- 추가 값 끝 -->            	
            </table>
            	<!-- 기존 입력값 시작 -->
            	<div id="report_summary_view"></div>
            	<!-- 기존 입력값 끝 -->
            	<!-- 추가 값 시작 -->
            		
        <!--// 5.총괄 경과표 -->
        <script type="text/javascript">
        
        	//총괄표 삭제
        	function fnSummaryDel(serial_no){
        		
        		if( confirm("해당 총괄 경과표를 삭제 하시겠습니까?") ){
        			
        			var url = "./deleteSummaryValue";
        			
        			var param ={};
        			
        			param.serial_no = serial_no;
        			
        			//총괄표 목록을 가져온다.
                	$.ajax({
                		type: "POST",
                		url: url,
                		data: param,
                		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                		dataType: "html",
                		timeout: 20000,    		         
                		success: function(data){            			
                			if( data == 1 ){
                				alert("삭제되었습니다.");
                				//총괄경과표 초기화
                    			fnSummaryCancel();	
                			}
                		},            		
                		error: function (request, status, error) {
                			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
                		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                		}            		
                	});
        			
        		}        		
        		
        	}
        	
        	//총괄표 수정
        	function fnSummaryUpdate(serial_no){
        		//보기페이지 hide
        		$("#summary_tr_"+serial_no).hide();
        		$("#summary_tr_edit_"+serial_no).show();
        		_initDatePicker();        		
        	}
        	
        	//보험명추가
        	function fnSummaryInsuAdd(){
        		//초기화
        		$("#summary_insu_write_date").val('');        		
				$("#remark_insu_content").val('');
				
        		$("#btn_summary_insu_add").hide();
       		 	$("#report_summary_insu_addform").show();
        	}        	
        	
        	function fnSummaryAdd(){
        		//초기화        		
        		$("#summary_write_date").val('');
        		$("#first_date").val('');
        		$("#income_date").val('');
        		$("#income_content").val('');
        		$("#disease_name").val('');
        		$("#inspection_content").val('');
        		$("#operation_content").val('');
        		$("#obstacle_date").val('');
        		$("#obstacle_subject").val('');
        		$("#obstacle_content").val('');
				$("#enter_interval").val('');
				$("#going_interval").val('');
				$("#past_disease").val('');
				$("#outing_content").val('');
				$("#option_content").val('');
				$("#doctor_opinion").val('');
				$("#remark_content").val('');
        		
        		 $("#btn_summary_add").hide();
        		 $("#report_summary_addform").show();
        	}
        	
        	function fnSummaryCancel(){        		
        		
        		var url = "./getSummaryList";
        		
        		var param = {};            	
            	param.suim_rpt_no = $("#suim_rpt_no").val();            	
            	
            	//총괄표 목록을 가져온다.
            	$.ajax({
            		type: "POST",
            		url: url,
            		data: param,
            		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            		dataType: "html",
            		timeout: 20000,    		         
            		success: function(data){            			
            			$("#report_summary_view").html(data);
            			
            			$("#btn_summary_add").show();
            			$("#btn_summary_insu_add").show();
                		$("#report_summary_addform").hide();
                		$("#report_summary_insu_addform").hide();
            		},            		
            		error: function (request, status, error) {
            			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
            		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
            		}            		
            	});        		
        	}
        	        	
        	//총괄표 수정 저장
        	function fnSummaryModifySave(p_serial_no){
        		
        		var param = {};
        		
        		param.serial_no = p_serial_no;
        		param.suim_rpt_no = $("#suim_rpt_no").val();
        		param.write_date = $("#summary_write_date_"+p_serial_no).val();
        		param.first_date = $("#first_date_"+p_serial_no).val();
        		param.income_date = $("#income_date_"+p_serial_no).val();
        		param.income_content = $("#income_content_"+p_serial_no).val();
        		param.disease_name = $("#disease_name_"+p_serial_no).val();
        		param.inspection_content = $("#inspection_content_"+p_serial_no).val();
        		param.operation_content = $("#operation_content_"+p_serial_no).val();
        		param.obstacle_date = $("#obstacle_date_"+p_serial_no).val();
        		param.obstacle_subject = $("#obstacle_subject_"+p_serial_no).val();
        		param.obstacle_content = $("#obstacle_content_"+p_serial_no).val();
				param.enter_interval = $("#enter_interval_"+p_serial_no).val();
				param.going_interval = $("#going_interval_"+p_serial_no).val();
				param.past_disease = $("#past_disease_"+p_serial_no).val();
				param.outing_content = $("#outing_content_"+p_serial_no).val();
				param.option_content = $("#option_content_"+p_serial_no).val();
				param.doctor_opinion = $("#doctor_opinion_"+p_serial_no).val();
				param.remark_content = $("#remark_content_"+p_serial_no).val();
        		
				var url = "./updateSummaryValue";
				
				$.ajax({
					type: "POST",
					url: url,
					data: param,    		        
					timeout: 20000,    		         
					success: function(data){
						if( data > 0){
							alert('수정하였습니다.');
							//저장하고 보기페이지로 전환
							fnSummaryCancel();
						}            			
					},
					error: function(e){
					    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
					}            		
				});
        		
        	}
        	
			function fnSummaryInsuSave(){
        		
        		var param = {};
        		
        		param.suim_rpt_no = $("#suim_rpt_no").val();
        		param.write_date = $("#summary_insu_write_date").val();        		
				param.remark_content = $("#remark_insu_content").val();				
				param.summary_insu_subject = $("#summary_insu_subject").val();
				
				var url = "./insertSummaryValue";
				
				$.ajax({
					type: "POST",
					url: url,
					data: param,    		        
					timeout: 20000,    		         
					success: function(data){
						if( data > 0){
							alert('추가하였습니다.');
							//저장하고 보기페이지로 전환
							fnSummaryCancel();
						}            			
					},
					error: function(e){
					    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
					}            		
				});				
        	}
        	
        	function fnSummarySave(){
        		
        		var param = {};
        		
        		param.suim_rpt_no = $("#suim_rpt_no").val();
        		param.write_date = $("#summary_write_date").val();
        		param.first_date = $("#first_date").val();
        		param.income_date = $("#income_date").val();
        		param.income_content = $("#income_content").val();
        		param.disease_name = $("#disease_name").val();
        		param.inspection_content = $("#inspection_content").val();
        		param.operation_content = $("#operation_content").val();
        		param.obstacle_date = $("#obstacle_date").val();
        		param.obstacle_subject = $("#obstacle_subject").val();
        		param.obstacle_content = $("#obstacle_content").val();
				param.enter_interval = $("#enter_interval").val();
				param.going_interval = $("#going_interval").val();
				param.past_disease = $("#past_disease").val();
				param.outing_content = $("#outing_content").val();
				param.option_content = $("#option_content").val();
				param.doctor_opinion = $("#doctor_opinion").val();
				param.remark_content = $("#remark_content").val();				
				
				var url = "./insertSummaryValue";
				
				$.ajax({
					type: "POST",
					url: url,
					data: param,    		        
					timeout: 20000,    		         
					success: function(data){
						if( data > 0){
							alert('추가하였습니다.');
							//저장하고 보기페이지로 전환
							fnSummaryCancel();
						}            			
					},
					error: function(e){
					    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
					}            		
				});				
        	}
        </script>
        
        <!-- 6.상세확인사항 -->
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell" style="width: 80%;">
                <p class="subtitle">6.관공서 확인사항</p>
            </div>            
        </div>
        <table>
			<tr>
				<th width="20%">일자</th>
				<th width="55%">내용</th>
				<th width="15%">비고</th>
				<th width="10%">-</th>
			</tr>
		</table>        
		<!-- 1단계 시작 -->
        <div id="report_office_view_1"></div>
        <!-- 1단계 끝 -->
        <!-- 2단계 시작 -->
        <div id="report_office_view_2"></div>
        <!-- 2단계 끝 -->
        <!-- 3단계 시작 -->
        <div id="report_office_view_3"></div>
        <!-- 3단계 끝 -->
        <!-- 4단계 시작 -->
        <div id="report_office_view_4"></div>
        <!-- 4단계 끝 -->
        
        <!-- 7.기타 / 특이사항 -->
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell" style="width: 80%;">
                <p class="subtitle">7.기타/특이사항</p>
            </div>            
        </div>
        
        <!-- 기타 / 특이사항의 확인사항 안내 시작-->
        <div id="report_office_view_5" style="padding-bottom:5px;"></div>
        <!-- 기타 / 특이사항의 확인사항 안내 끝-->        
        <!-- 기타 / 특이사항의 특이사항 시작-->
        <div id="report_office_view_6" style="padding-bottom:5px;"></div>
        <!-- 기타 / 특이사항의 특이사항 끝-->        
        <!-- 기타 / 특이사항의 탐문리스트 시작-->
        <div id="report_office_view_7"></div>
        <!-- 기타 / 특이사항의 탐문리스트 끝-->
        
        <!--// 6.상세확인사항 -->
        <script type="text/javascript">
        
		function fnGetReportOffice7(){
        	
        	var url = "./getOffceList7";
        	
        	var param = {};
        	param.suim_rpt_no = $("#suim_rpt_no").val();
        	
        	$.ajax({
        		type: "POST",
        		url: url,
        		data: param,
        		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        		dataType: "html",
        		timeout: 20000,    		         
        		success: function(data){        			
        			$("#report_office_view_7").html(data);        			
        		},            		
        		error: function (request, status, error) {
        			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
        		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
        		}            		
        	});
        	
        }
        
		function fnGetReportOffice6(){
        	
        	var url = "./getOffceList6";
        	
        	var param = {};
        	param.suim_rpt_no = $("#suim_rpt_no").val();
        	
        	$.ajax({
        		type: "POST",
        		url: url,
        		data: param,
        		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        		dataType: "html",
        		timeout: 20000,    		         
        		success: function(data){        			
        			$("#report_office_view_6").html(data);        			
        		},            		
        		error: function (request, status, error) {
        			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
        		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
        		}            		
        	});
        	
        }
        
		function fnGetReportOffice5(){
        	
        	var url = "./getOffceList5";
        	
        	var param = {};
        	param.suim_rpt_no = $("#suim_rpt_no").val();
        	
        	$.ajax({
        		type: "POST",
        		url: url,
        		data: param,
        		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        		dataType: "html",
        		timeout: 20000,    		         
        		success: function(data){        			
        			$("#report_office_view_5").html(data);        			
        		},            		
        		error: function (request, status, error) {
        			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
        		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
        		}            		
        	});
        	
        }
        
		function fnGetReportOffice4(){
        	
        	var url = "./getOffceList4";
        	
        	var param = {};
        	param.suim_rpt_no = $("#suim_rpt_no").val();
        	
        	$.ajax({
        		type: "POST",
        		url: url,
        		data: param,
        		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        		dataType: "html",
        		timeout: 20000,    		         
        		success: function(data){            			
        			$("#report_office_view_4").html(data);        			
        		},            		
        		error: function (request, status, error) {
        			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
        		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
        		}            		
        	});
        	
        }
        
		function fnGetReportOffice3(){
        	
        	var url = "./getOffceList3";
        	
        	var param = {};
        	param.suim_rpt_no = $("#suim_rpt_no").val();
        	
        	$.ajax({
        		type: "POST",
        		url: url,
        		data: param,
        		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        		dataType: "html",
        		timeout: 20000,    		         
        		success: function(data){            			
        			$("#report_office_view_3").html(data);        			
        		},            		
        		error: function (request, status, error) {
        			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
        		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
        		}            		
        	});
        	
        }
        
		function fnGetReportOffice2(){
        	
        	var url = "./getOffceList2";
        	
        	var param = {};
        	param.suim_rpt_no = $("#suim_rpt_no").val();
        	
        	//총괄표 목록을 가져온다.
        	$.ajax({
        		type: "POST",
        		url: url,
        		data: param,
        		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        		dataType: "html",
        		timeout: 20000,    		         
        		success: function(data){            			
        			$("#report_office_view_2").html(data);        			
        		},            		
        		error: function (request, status, error) {
        			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
        		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
        		}            		
        	});
        	
        }
        
        function fnGetReportOffice1(){
        	
        	var url = "./getOffceList1";
        	
        	var param = {};
        	param.suim_rpt_no = $("#suim_rpt_no").val();
        	
        	//총괄표 목록을 가져온다.
        	$.ajax({
        		type: "POST",
        		url: url,
        		data: param,
        		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        		dataType: "html",
        		timeout: 20000,    		         
        		success: function(data){            			
        			$("#report_office_view_1").html(data);        			
        		},            		
        		error: function (request, status, error) {
        			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
        		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
        		}            		
        	});
        	
        }
        
        function fnOffice1Update(){
        	$("#report_office_1_view").hide();
        	$("#report_office_1_edit").show();
        	_initDatePicker();
        }
        
        function fnOffice2Update(){
        	$("#report_office_2_view").hide();
        	$("#report_office_2_edit").show();
        	_initDatePicker();
        }
        
        function fnOffice3Update(){
        	$("#report_office_3_view").hide();
        	$("#report_office_3_edit").show();
        	_initDatePicker();
        }
        
        function fnOffice4Update(){
        	$("#report_office_4_view").hide();
        	$("#report_office_4_edit").show();
        	_initDatePicker();
        }
        
        function fnOffice5Update(){
        	$("#report_office_5_view").hide();
        	$("#report_office_5_edit").show();        	
        }
        
        function fnOffice6Update(){
        	$("#report_office_6_view").hide();
        	$("#report_office_6_edit").show();        	
        }
        
        function fnOffice7Update(){
        	$("#report_office_7_view").hide();
        	$("#report_office_7_edit").show();        	
        }
        
        //관공서 확인사항 항목 1저장
        function fnOffice1ModifySave(){
			var url = "./updateReportOffceList1";
        	
        	var param = {};
        	param.suim_rpt_no = $("#suim_rpt_no").val();
        	param.write_date_1 = $("#office_write_date_1").val();
        	param.check_date_1 = $("#check_date_1").val();
        	param.occur_spot_1 = $("#occur_spot_1").val();
        	param.occur_type_1 = $("#occur_type_1").val();
        	param.disaster_1 = $("#disaster_1").val();
        	param.trans_hospital_1 = $("#trans_hospital_1").val();        	        	
        	param.remark_content_1 = $("#office_remark_content_1").val();        	
        	
        	$.ajax({
				type: "POST",
				url: url,
				data: param,    		        
				timeout: 20000,    		         
				success: function(data){
					if( data > 0){
						alert('수정하였습니다.');
						//저장하고 보기페이지로 전환
						fnGetReportOffice1();
						$("#report_office_1_view").show();
						$("#report_office_1_edit").hide();
					}            			
				},
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}            		
			});
        	
        }
        
      	//관공서 확인사항 항목 2저장
        function fnOffice2ModifySave(){
			var url = "./updateReportOffceList2";
        	
        	var param = {};
        	param.suim_rpt_no = $("#suim_rpt_no").val();
        	param.write_date_2 = $("#office_write_date_2").val();
        	param.personal_info_2 = $("#personal_info_2").val();
        	param.hire_date_2 = $("#hire_date_2").val();
        	param.hire_type_2 = $("#hire_type_2").val();
        	param.office_name_2 = $("#office_name_2").val();
        	param.disaster_date_2 = $("#disaster_date_2").val();
        	param.disaster_type_2 = $("#disaster_type_2").val();
        	param.disaster_content_2 = $("#disaster_content_2").val();
        	param.obstacle_level_2 = $("#obstacle_level_2").val();
        	param.option_2 = $("#option_2").val();        	
        	param.remark_content_2 = $("#office_remark_content_2").val();
        	
        	$.ajax({
				type: "POST",
				url: url,
				data: param,    		        
				timeout: 20000,    		         
				success: function(data){
					if( data > 0){
						alert('수정하였습니다.');
						//저장하고 보기페이지로 전환
						fnGetReportOffice2();
						$("#report_office_2_view").show();
						$("#report_office_2_edit").hide();
					}            			
				},
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}            		
			});
        	
        }
      	
      	//관공서 확인사항 항목 3저장
        function fnOffice3ModifySave(){
			var url = "./updateReportOffceList3";
        	
        	var param = {};
        	param.suim_rpt_no = $("#suim_rpt_no").val();
        	param.write_date_3 = $("#office_write_date_3").val();        	
        	param.occur_date_3 = $("#occur_date_3").val();
        	param.occur_spot_3 = $("#occur_spot_3").val();
        	param.dead_date_3 = $("#dead_date_3").val();
        	param.dead_cause_3 = $("#dead_cause_3").val();
        	param.agree_content_3 = $("#agree_content_3").val();
        	param.result_info_3 = $("#result_info_3").val();
        	param.result_comment_3 = $("#result_comment_3").val();
        	param.family_comment_3 = $("#family_comment_3").val();
        	param.option_3 = $("#option_3").val();        	
        	param.remark_content_3 = $("#office_remark_content_3").val();
        	
        	$.ajax({
				type: "POST",
				url: url,
				data: param,    		        
				timeout: 20000,    		         
				success: function(data){
					if( data > 0){
						alert('수정하였습니다.');
						//저장하고 보기페이지로 전환
						fnGetReportOffice3();
						$("#report_office_3_view").show();
						$("#report_office_3_edit").hide();
					}            			
				},
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}            		
			});
        	
        }
      	
      	//관공서 확인사항 항목 4저장
        function fnOffice4ModifySave(){
			var url = "./updateReportOffceList4";
        	
        	var param = {};
        	param.suim_rpt_no = $("#suim_rpt_no").val();
        	param.write_date_4 = $("#office_write_date_4").val();
        	param.option_4 = $("#option_4").val();        	
        	param.remark_content_4 = $("#office_remark_content_4").val();
        	
        	$.ajax({
				type: "POST",
				url: url,
				data: param,    		        
				timeout: 20000,    		         
				success: function(data){
					if( data > 0){
						alert('수정하였습니다.');
						//저장하고 보기페이지로 전환
						fnGetReportOffice4();
						$("#report_office_4_view").show();
						$("#report_office_4_edit").hide();
					}            			
				},
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}            		
			});
        	
        }
      	
      	//7번 확인사항 안내 저장
        function fnOffice5ModifySave(){
			var url = "./updateReportOffceList5";
        	
        	var param = {};
        	param.suim_rpt_no = $("#suim_rpt_no").val();
        	param.confirm_content_5 = $("#confirm_content_5").val();
        	
        	$.ajax({
				type: "POST",
				url: url,
				data: param,    		        
				timeout: 20000,    		         
				success: function(data){
					if( data > 0){
						alert('수정하였습니다.');
						//저장하고 보기페이지로 전환
						fnGetReportOffice5();
						$("#report_office_5_view").show();
						$("#report_office_5_edit").hide();
					}            			
				},
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}            		
			});
        	
        }
      	
      	//7번 특이사항 저장
        function fnOffice6ModifySave(){
			var url = "./updateReportOffceList6";			
        	
        	var param = {};
        	param.suim_rpt_no = $("#suim_rpt_no").val();
        	param.unique_content_6 = $("#unique_content_6").val();
        	param.insure_address_6 = $("#insure_address_6").val();
        	
        	$.ajax({
				type: "POST",
				url: url,
				data: param,    		        
				timeout: 20000,    		         
				success: function(data){
					if( data > 0){
						alert('수정하였습니다.');
						//저장하고 보기페이지로 전환
						fnGetReportOffice6();
						$("#report_office_6_view").show();
						$("#report_office_6_edit").hide();
					}            			
				},
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}            		
			});
        	
        }
      	
     	//7번 탐문리스트 저장
        function fnOffice7ModifySave(){
			var url = "./updateReportOffceList7";
        	
        	var param = {};
        	param.suim_rpt_no = $("#suim_rpt_no").val();
        	param.search_list_7 = $("#search_list_7").val();        	
        	
        	$.ajax({
				type: "POST",
				url: url,
				data: param,    		        
				timeout: 20000,    		         
				success: function(data){
					if( data > 0){
						alert('수정하였습니다.');
						//저장하고 보기페이지로 전환
						fnGetReportOffice7();
						$("#report_office_7_view").show();
						$("#report_office_7_edit").hide();
					}            			
				},
				error: function(e){
				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
				}            		
			});
        	
        }
        
        </script>

        <!-- 사고처리 과정표 -->
        <div class="text-center" style="font-size: 24px;border: 1px solid #000; padding: 15px 0px; font-family: 돋움; color: #000; margin: 20px 0px;">
            <b>사 고 처 리 과 정 표</b>
        </div>
        <!-- 1.일반사항 -->
        <div class="display-table" style="margin-top: 0px;">
            <div class="display-cell">
                <p class="subtitle">1.일반사항</p>
            </div>
            <div class="display-cell text-right">
                <%--<a id="btn_cont_edit" href="#noloc"><img src="./resources/ls_img/btn_edite.gif"/></a>--%>
                <%--<a id="btn_cont_save" href="#noloc" style="display: none"><img src="./resources/ls_img/icon_write.gif"/></a>--%>
                <%--<a id="btn_cont_cancel" href="#noloc" style="display: none"><img src="./resources/ls_img/btn_write_cancel.gif"/></a>--%>
            </div>
        </div>
        <table>
            <col width="20%">
            <col width="30%">
            <col width="20%">
            <col width="30%">
            <tr>
                <th>보험종목</th>
                <td>${reportBscInfo.insuranceNm}</td>
                <th>피보험자</th>
                <td>${reportBscInfo.beneficiaryNm}님</td>
            </tr>
            <tr>
                <th>사고일시</th>
                <td>${reportBscInfo.accidentDate}</td>
                <th>보험사 담당자</th>
                <td>
                    <c:if test="${reportBscInfo.ptnrMbrNm != ''}">
                        ${reportBscInfo.ptnrMbrNm} 님
                    </c:if>
                </td>
            </tr>
            <tr>
                <th>수임일</th>
                <td>${reportBscInfo.regDate}</td>
                <th>조사자</th>
                <td>${reportInvgUser.userName}</td>
            </tr>
        </table>
        <!--// 1.일반사항 -->
        <!-- 2.처리과정 -->
        <div class="display-table" style="margin-top: 10px;">
            <div class="display-cell">
                <p class="subtitle">2.처리과정</p>
            </div>
            <c:choose>
            	<c:when test="${reportBscInfo.ptnrId == '9'}">
            		<div class="display-cell text-right">
		                <a href="#noloc" id="btn_accident_process_add" onclick="fnAccidentProcessAdd();"><img src="./resources/ls_img/ls_body/btn_add.gif"/></a>
		            </div>
            	</c:when>
            	<c:otherwise>
            		<div class="display-cell text-right">
		                <a href="#noloc" id="btn_sago_list_add" onclick="fnSagoListAdd();"><img src="./resources/ls_img/ls_body/btn_add.gif"/></a>
		            </div>
            	</c:otherwise>
            </c:choose>
        </div>
         <c:choose><%-- 롯데손해보험일경우 --%>
            <c:when test="${reportBscInfo.ptnrId == '9'}">
                <c:import url="../top_suim_print/module/print_ctrl_process_ptnr9.jsp"></c:import>
            </c:when>
            <c:otherwise>
                <table>
		        	<tr>
		        		<th width="20%">일자</th>
		        		<th width="35%">업무내용</th>
		        		<th width="35%">세부내용</th>
		        		<th width="10%">-</th>
		        	</tr>        	
		        </table>
		        <div id=sago_list_view></div>
            </c:otherwise>
        </c:choose>
        <!--// 2.처리과정 -->

        <!-- 3.첨부서류 -->
        <script type="text/javascript">
        	function fnSagoListAdd(){
        		$("#btn_sago_list_add").hide();
        		$("#sago_list_add").show();
        		_initDatePicker();
        	}
        	
        	function fnSagoListUpdate(p_serial_no){
        		$("#sago_list_view_"+p_serial_no).hide();
        		$("#sago_list_edit_"+p_serial_no).show();
        		_initDatePicker();        		
        	}
        	
        	function fnSagoListDel(p_serial_no){
        		
        		if(confirm("해당 사고처리과정을 삭제하시겠습니까?")){
        			
        			var url = "/deleteSagoListValue";
        			
        			var param = {};
        			param.serial_no = p_serial_no;
        			
        			$.ajax({
        				type: "POST",
        				url: url,
        				data: param,    		        
        				timeout: 20000,    		         
        				success: function(data){
        					if( data > 0){
        						alert('삭제하였습니다.');        						        						
        		        		fnSagoList();
        					}            			
        				},
        				error: function(e){
        				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
        				}            		
        			});
        			
        		}        		
        	}
        	
        	function fnSagoUpdate(p_serial_no){
        		
				var url = "./updateSagoListValue";
            	
            	var param = {};
            	param.serial_no = p_serial_no;
            	param.control_subject = $("#control_subject_"+p_serial_no).val();
            	param.control_memo = $("#control_memo_"+p_serial_no).val();
            	param.control_date = $("#control_date_"+p_serial_no).val();
            	
            	$.ajax({
    				type: "POST",
    				url: url,
    				data: param,    		        
    				timeout: 20000,    		         
    				success: function(data){
    					if( data > 0){
    						alert('수정하였습니다.');    						
    		        		fnSagoList();    		        		
    					}            			
    				},
    				error: function(e){
    				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
    				}            		
    			});
        		
        	}
        	
        	function fnSagoSave(){
        		var url = "./insertSagoListValue";
            	
            	var param = {};
            	param.suim_rpt_no = $("#suim_rpt_no").val();
            	param.control_subject = $("#control_subject").val();
            	param.control_memo = $("#control_memo").val();
            	param.control_date = $("#control_date_add").val();
            	
            	$.ajax({
    				type: "POST",
    				url: url,
    				data: param,    		        
    				timeout: 20000,    		         
    				success: function(data){
    					if( data > 0){
    						alert('추가하였습니다.');
    						//저장하고 보기페이지로 전환
    						$("#btn_sago_list_add").show();
    		        		$("#sago_list_add").hide();
    		        		fnSagoList();    		        		
    					}            			
    				},
    				error: function(e){
    				    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
    				}            		
    			});
        	}
        
        
        	function fnSagoList(){
            	
            	var url = "./getSagoList";
            	
            	var param = {};
            	param.suim_rpt_no = $("#suim_rpt_no").val();
            	
            	//총괄표 목록을 가져온다.
            	$.ajax({
            		type: "POST",
            		url: url,
            		data: param,
            		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            		dataType: "html",
            		timeout: 20000,    		         
            		success: function(data){            			
            			$("#sago_list_view").html(data);        			
            		},            		
            		error: function (request, status, error) {
            			console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
            		    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
            		}            		
            	});
            	
            }
        
            function fnAttachDocUseFlagUpdate(useAt){

                var param = {};
                param.suim_rpt_no           = $("#suim_rpt_no").val();
                param.rpt_print_no          = $("#rpt_print_no").val();
                param.use_flag              = useAt;

                var url = "./report_attach_doc_useflag";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "json",
                    timeout: 20000,
                    success: function(data){
                        if(useAt == '1'){
                            $("#div_attach_doc_container").show();
                        }else if(useAt == '0'){
                            $("#div_attach_doc_container").hide();
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

            function fnAttachDocEdit(idx){
                $(".tr_attach_doc_view").show();
                $(".tr_attach_doc_edit").hide();

                $("#tr_attach_doc_view" + idx).hide();
                $("#tr_attach_doc_edit" + idx).show();
            }
            function fnAttachDocClose(idx){
                $("#tr_attach_doc_view" + idx).show();
                $("#tr_attach_doc_edit" + idx).hide();
            }

            function fnAttachDocRefresh(){
                var param = {};
                param.suim_rpt_no               = $("#suim_rpt_no").val();
                param.rpt_print_no              = $("#rpt_print_no").val();
                param.cmd                       = 'RF';

                var url = "./report_attach_doc";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#div_attach_doc_body").html(data);
                        _initMask();
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

            function fnAttachDocAdd(msg){
                $("#ad_attach_name").val(msg);
                $("#tr_attach_doc_add").show();
            }

            function fnAttachDocCancel(){
                $("#tr_attach_doc_add").hide();
            }

            function fnAttachDocSave(idx, cmd){
                if($("#ad_attach_name" + idx).val() == ""){
                    alert("첨부자료를 입력해주세요.");
                    $("#ad_attach_name" + idx).focus();
                    return;
                }

                if($("#ad_attach_copy" + idx).val() == ""){
                    alert("부수를 입력해주세요.");
                    $("#ad_attach_copy" + idx).focus();
                    return;
                }

                var etc_memo = $("#ad_attach_etc_memo" + idx + " option:selected").val();     //비고
                if(etc_memo == "" || (etc_memo == "999" && $("#ad_attach_etc_memo_etc" + idx).val() == "" )){
                    if (etc_memo == "999"){
                        alert("비고 내용을 입력해 주세요.");
                        $("#ad_attach_etc_memo_etc" + idx).focus();
                    }else{
                        alert("비고 내용을 선택해 주세요.");
                        $("#ad_attach_etc_memo" + idx).focus();
                    }
                    return;
                }


                /** 넘길 데이터 정리  **/
                var param = {};
                param.suim_rpt_no               = $("#suim_rpt_no").val();
                param.rpt_print_no              = $("#rpt_print_no").val();
                param.cmd                       = cmd;
                if (cmd == 'U'){
                    param.serial_no             = $("#ad_serial_no" + idx).val();
                }

                param.attach_name              = $("#ad_attach_name" + idx).val();
                param.attach_copy          = $("#ad_attach_copy" + idx).val().num();

                if(etc_memo == "999"){
                    param.attach_etc_memo       = $("#ad_attach_etc_memo_etc" + idx).val();
                }else{
                    param.attach_etc_memo       = etc_memo;
                }

                var url = "./report_attach_doc";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#div_attach_doc_body").html(data);
                        _initMask();
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

            function fnADMemoChange(that, idx){

                if(that.value == '999'){
                    $("#ad_attach_etc_memo_etc" + idx).show();
                }else{
                    $("#ad_attach_etc_memo_etc" + idx).hide();
                }

            }

            function fnAttachDocDelete(idx){
                if(confirm("삭제하시겠습니까?")){
                    var param = {};
                    param.suim_rpt_no               = $("#suim_rpt_no").val();
                    param.rpt_print_no              = $("#rpt_print_no").val();
                    param.cmd                       = 'D';
                    param.serial_no                 = $("#ad_serial_no" + idx).val();
                    var url = "./report_attach_doc";

                    $.ajax({
                        type: "POST",
                        url: url,
                        data: param,
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        dataType: "html",
                        timeout: 20000,
                        success: function(data){
                            $("#div_attach_doc_body").html(data);
                            _initMask();
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
            }

        </script>
        <div class="display-table" style="margin-top: 10px;">
            <div class="display-cell">
                <p class="subtitle">3.첨부서류</p>
            </div>
            <div class="display-cell text-right">
                <input type="radio" id="attach_doc_use_at1" name="attach_doc_use_at" onclick="fnAttachDocUseFlagUpdate('1')"  <c:if test="${reportPrint1.sagodocFlag == 1}">checked="checked"</c:if>>&nbsp;<label for="attach_doc_use_at1">사용</label>
                &nbsp;&nbsp;<input type="radio" id="attach_doc_use_at2" name="attach_doc_use_at" onclick="fnAttachDocUseFlagUpdate('0')"  <c:if test="${reportPrint1.sagodocFlag == 0}">checked="checked"</c:if>>&nbsp;<label for="attach_doc_use_at2">미사용</label>
            </div>
        </div>
        <c:set var="div_attach_doc_container_display" value="display:none;"/>
        <c:if test="${reportPrint1.sagodocFlag == 1}">
            <c:set var="div_attach_doc_container_display" value=""/>
        </c:if>
        <div id="div_attach_doc_container" style="${div_attach_doc_container_display}">
            <div id="div_attach_doc_header">
                <button class="btn btn-default" onclick="fnAttachDocAdd('문답서')">문답서</button>
                <button class="btn btn-default" onclick="fnAttachDocAdd('의무기록')">의무기록</button>
                <button class="btn btn-default" onclick="fnAttachDocAdd('')">직접입력</button>
            </div>
            <div id="div_attach_doc_body">
                <table style="margin-top: 5px;">
                    <colgroup>
                        <col width="9%">
                        <col width="37%">
                        <col width="9%">
                        <col width="36%">
                        <col width="9%">
                    </colgroup>
                    <tr>
                        <th>순번</th>
                        <th>첨부자료</th>
                        <th>부수</th>
                        <th>비고</th>
                        <th>-</th>
                    </tr>
                    <c:forEach  var="item" items="${reportAttachDocList}" varStatus="status">
                        <tr id="tr_attach_doc_view${status.index}" class="tr_attach_doc_view">
                            <td style="text-align: center">${status.count}</td>
                            <td>${item.attachName}</td>
                            <td style="text-align: center">${item.attachCopy}</td>
                            <td>${item.attachEtcMemo}</td>
                            <td style="text-align: center">
                                <a href="#noloc" onclick="fnAttachDocEdit('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
                                <a href="#noloc" onclick="fnAttachDocDelete('${status.index}');"><img src='./resources/ls_img/btn_del_s.gif'></a>
                            </td>
                        </tr>
                        <tr id="tr_attach_doc_edit${status.index}" class="tr_attach_doc_edit" style="display: none;">
                            <td style="text-align: center">${status.count}</td>
                            <td>
                                <input type="hidden" id="ad_serial_no${status.index}" value="${item.serialNo}">
                                <input type="text" id="ad_attach_name${status.index}" value="${item.attachName}">
                            </td>
                            <td>
                                <input type="text" id="ad_attach_copy${status.index}" class="money" value="${item.attachCopy}" style="text-align: right" maxlength="3">
                            </td>
                            <td>
                                <select id="ad_attach_etc_memo${status.index}" onchange="fnADMemoChange(this,'${status.index}');">
                                    <option value="">---선택---</option>
                                    <c:set var="ad_memo_selected" value="0"/>
                                    <c:forEach var="item_memo" items="${reportAttachDocCodeList}">
                                        <c:if test="${item.attachEtcMemo == item_memo}">
                                            <c:set var="ad_memo_selected" value="1"/>
                                        </c:if>
                                        <option value="${item_memo}" <c:if test="${item.attachEtcMemo == item_memo}">selected</c:if>>${item_memo}</option>
                                    </c:forEach>
                                    <option value="999" <c:if test="${ad_memo_selected == 0}">selected</c:if>>직접입력</option>
                                </select>
                                <c:if test="${ad_memo_selected == 0}">
                                    <input type="text" id="ad_attach_etc_memo_etc${status.index}" value="${item.attachEtcMemo}" maxlength="80">
                                </c:if>
                                <c:if test="${ad_memo_selected != 0}">
                                    <input type="text" id="ad_attach_etc_memo_etc${status.index}" style="display: none;" maxlength="80">
                                </c:if>
                            </td>
                            <td style="text-align: center">
                                <a href="#noloc" onclick="fnAttachDocSave('${status.index}','U');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                                <a href="#noloc" onclick="fnAttachDocClose('${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                            </td>
                        </tr>
                    </c:forEach>
                    <tr id="tr_attach_doc_add" style="display: none;">
                        <td style="text-align: center">${status.count}</td>
                        <td>
                            <input type="text" id="ad_attach_name" value="" maxlength="80">
                        </td>
                        <td>
                            <input type="text" id="ad_attach_copy" value="" class="money" maxlength="3" style="text-align: right">
                        </td>
                        <td>
                            <select id="ad_attach_etc_memo" onchange="fnADMemoChange(this,'${status.index}');">
                                <option value="">---선택---</option>
                                <c:forEach var="item_memo" items="${reportAttachDocCodeList}">
                                    <option value="${item_memo}">${item_memo}</option>
                                </c:forEach>
                                <option value="999">직접입력</option>
                            </select>
                            <input type="text" id="ad_attach_etc_memo_etc" style="display: none;" maxlength="80">
                        </td>
                        <td style="text-align: center">
                            <a href="#noloc" onclick="fnAttachDocSave('','C');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                            <a href="#noloc" onclick="fnAttachDocCancel();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <!--// 3.첨부서류 -->
        <!--// 사고처리 과정표 -->

        <div class="text-center" style="font-size: 14px;; font-family: 돋움; color: #000; margin: 20px 0px;">
            <b> ※ 본 손해사정서는 관련 법률(보험업법 제 189조)에 의거 어느 일방에도 편중됨이 없이 <BR />
                신의와 성실의 원칙에 의거하여 공정하게 작성하였음을 명백히 합니다.[끝]
            </b>
        </div>

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
                		alert("허용된 이미지 파일이 아님니다.[JPG/GIF/BMP/PNG]");
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
        <div id="div_attach_img_list" style="margin-top: 10px;">
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
                        <td>
                            <a href="#noloc" onclick="fnAttachImageUpdate('${status.index}');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                            <a href="#noloc" onclick="fnAttachImageClose('${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <!--// 별첨 첨부사진 -->

        <!-- 별첨 병의원 탐문기록지 -->
        <div class="text-center" style="font-size: 24px; padding: 15px 0px; font-family: 돋움; color: #000; margin-top:20px;">
            <b>&lt;별첨:병.의원 탐문기록지&gt;</b>
        </div>
        <div class="text-right" style="margin-bottom: 5px;">
            <a href="#noloc" id="btn_hospital_question_add" onclick="fnHospitalQuestionAdd();"><img src="./resources/ls_img/ls_body/btn_add.gif"/></a>
        </div>
        <script type="text/javascript">
            function fnHospitalQuestionAdd(){
                $("#btn_hospital_question_add").hide();
                $("#tr_hospital_question_add").show();
            }

            function fnHospitalQuestionCancel(){
                $("#btn_hospital_question_add").show();
                $("#tr_hospital_question_add").hide();
            }

            function fnHospitalQuestionEdit(idx){
                $("#tr_hospital_question_view" + idx).hide();
                $("#tr_hospital_question_edit" + idx).show();
            }

            function fnHospitalQuestionClose(idx){
                $("#tr_hospital_question_view" + idx).show();
                $("#tr_hospital_question_edit" + idx).hide();
            }

            function fnHospitalQuestionSave(idx, cmd){

                if($("#hq_hspt_name" + idx).val() == ""){
                    alert("병의원명을 입력해 주세요.");
                    $("#hq_hspt_name" + idx).focus();
                    return;
                }
                if($("#hq_hspt_address" + idx).val() == ""){
                    alert("주소를 입력해 주세요.");
                    $("#hq_hspt_address" + idx).focus();
                    return;
                }
                if($("#hq_hspt_tel" + idx).val() == ""){
                    alert("전화번호를 입력해 주세요.");
                    $("#hq_hspt_tel" + idx).focus();
                    return;
                }
                if($("#hq_hspt_confirm" + idx).val() == ""){
                    alert("확인결과를 입력해 주세요.");
                    $("#hq_hspt_confirm" + idx).focus();
                    return;
                }

                fnHospitalQuestion(idx, cmd);
            }

            function fnHospitalQuestionDelete(idx){
                if(confirm("삭제하시겠습니까?")){
                    fnHospitalQuestion(idx, 'D');
                }
            }

            function fnHospitalQuestion(idx, cmd){
                var param = {};
                param.suim_rpt_no               = $("#suim_rpt_no").val();
                param.rpt_print_no              = $("#rpt_print_no").val();
                param.cmd                       = cmd;
                if (cmd == 'U' || cmd == 'D' ){
                    param.serial_no             = $("#hq_serial_no" + idx).val();
                }

                param.hspt_name                 = $("#hq_hspt_name" + idx).val();
                param.hspt_address              = $("#hq_hspt_address" + idx).val();
                param.hspt_tel                  = $("#hq_hspt_tel" + idx).val();
                param.hspt_confirm              = $("#hq_hspt_confirm" + idx).val();

                var url = "./report_hospital_question";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#div_hospital_question").html(data);
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
        <div id="div_hospital_question">
            <table>
                <colgroup>
                    <col width="11%">
                    <col width="20%">
                    <col width="20%">
                    <col width="20%">
                    <col width="20%">
                    <col width="9%">
                </colgroup>
                <tr>
                    <th>번호</th>
                    <th>병.의원명</th>
                    <th>소재지역</th>
                    <th>연락처</th>
                    <th>확인결과</th>
                    <th>-</th>
                </tr>
                <c:forEach  var="item" items="${reportHospitalQuestionList}" varStatus="status">
                    <tr id="tr_hospital_question_view${status.index}">
                        <td style="text-align: center">${status.count}</td>
                        <td><c:out value="${item.hsptName}"/></td>
                        <td><c:out value="${item.hsptAddress}"/></td>
                        <td><c:out value="${item.hsptTel}"/></td>
                        <td><c:out value="${item.hsptConfirm}"/></td>
                        <td style="text-align: center">
                            <a href="#noloc" onclick="fnHospitalQuestionEdit('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
                            <a href="#noloc" onclick="fnHospitalQuestionDelete('${status.index}');"><img src='./resources/ls_img/btn_del_s.gif'></a>
                        </td>
                    </tr>
                    <tr id="tr_hospital_question_edit${status.index}" style="display: none;">
                        <td style="text-align: center">-</td>
                        <td>
                            <input type="hidden" id="hq_serial_no${status.index}" value="${item.serialNo}">
                            <input type="text" id="hq_hspt_name${status.index}" value="${item.hsptName}" maxlength="80">
                        </td>
                        <td>
                            <input type="text" id="hq_hspt_address${status.index}" value="${item.hsptAddress}" maxlength="150">
                        </td>
                        <td>
                            <input type="text" id="hq_hspt_tel${status.index}" value="${item.hsptTel}" maxlength="40">
                        </td>
                        <td>
                            <input type="text" id="hq_hspt_confirm${status.index}" value="${item.hsptConfirm}" maxlength="250">
                        </td>
                        <td style="text-align: center">
                            <a href="#noloc" onclick="fnHospitalQuestionSave('${status.index}','U');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                            <a href="#noloc" onclick="fnHospitalQuestionClose('${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                        </td>
                    </tr>
                </c:forEach>
                <tr id="tr_hospital_question_add" style="display: none;">
                    <td style="text-align: center">-</td>
                    <td>
                        <input type="text" id="hq_hspt_name" value="" maxlength="80">
                    </td>
                    <td>
                        <input type="text" id="hq_hspt_address" value="" maxlength="150">
                    </td>
                    <td>
                        <input type="text" id="hq_hspt_tel" value="" maxlength="40">
                    </td>
                    <td>
                        <input type="text" id="hq_hspt_confirm" value="" maxlength="250">
                    </td>
                    <td style="text-align: center">
                        <a href="#noloc" onclick="fnHospitalQuestionSave('','C');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        <a href="#noloc" onclick="fnHospitalQuestionCancel('');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                    </td>
                </tr>
            </table>
        </div>

        <!--// 별첨 병의원 탐문기록지 -->

    </div> <!-- //reportContent-->
</div> <!-- //reportWrap-->

<%--<script src="./resources/cmm/js/moment-with-locales.js"></script>--%>
<%--<script src="./resources/cmm/module/bootstrap-3.3.7/js/bootstrap.js"></script>--%>

<script type="text/javascript">
    $(document).ready(function() {
        _initDatePicker();
        _initMask();
        
        //조사결과 옵션1
        fnOption1Close();
        
      	//조사결과 옵션2
        fnOption2Close();
      	
      	//조사결과 옵션3
        fnOption3Close();
      
      	//옵션3 라디오버튼 
      	$("#option3_radio_type1").click(function(){
      		$("#result_option3").val("본 보험 가입(OOOO.OO.OO) 이전 동일 진단 및 인과관계 있는 병명으로 치료한 사실이 없음");
      	});
      	
      	$("#option3_radio_type2").click(function(){
      		$("#result_option3").val("보험가입 전인 동일 진단 병명인 OOO으로 OOOO년 OO월 OO일 ~ OOOO년 OO월 OO일 까지 OO병원에서 OOOO 한 사실이 확인됨");
      	});
      	
		//조사결과 옵션4
        fnOption4Close();
				
      	//조사결과 옵션5
        fnOption5Close();
      	
        $("#option5_radio_type1").click(function(){        	
      		$("#result_option5").val("재척기간 경과건으로 해당사항 없음");
      	});
        
        $("#option5_radio_type2").click(function(){
      		$("#result_option5").val("계약전 알릴의무 위반사항 확인되지 않음");
      	});
        
        $("#option5_radio_type3").click(function(){
      		$("#result_option5").val("피보험자는 본 보험 가입(OOOO.OO.OO) 이전인 OOOO년 OO월 OO일 OO병원에서 OO병명으로 OOOO년 OO월 OO일 부터 OOOO년 OO월 OO일까지 OOOO OOO OOO 한 사실이 확인 됨");
      	});
        
        $("#option5_radio_type4").click(function(){
      		$("#result_option5").val("피보험자는 본 보험 가입(OOOO.OO.OO) 당시 OOOO 로 직업 고지하였으며, 확인 결과 OOOO으로 확인됨");
      	});
        
        $("#option5_radio_type5").click(function(){
        	$("#result_option5").val("");
      		$("#result_option5").attr('placeholder','직접입력하세요.');
      	});
        
        //총괄표 목록을 가져온다.
        fnSummaryCancel();
        
        //관공서 확인사항 1번 항목을 가져온다.
        fnGetReportOffice1();
        
      	//관공서 확인사항 2번 항목을 가져온다.
        fnGetReportOffice2();
      	
      	//관공서 확인사항 3번 항목을 가져온다.
        fnGetReportOffice3();
      	
      	//관공서 확인사항 4번 항목을 가져온다.
        fnGetReportOffice4();
      	
      	//기타/특이사항 확인사항 안내를 가져온다.
        fnGetReportOffice5();
      	
      	//기타/특이사항 특이사항을 가져온다.
        fnGetReportOffice6();
      	
      	//기타/특이사항 탐문리스트를 가져온다.
        fnGetReportOffice7();
      	
      	//사고처리과정표 불러오기. (롯데가 아닌경우만 처리)
      	if(${reportBscInfo.ptnrId} != 9){
      		fnSagoList();	
      	}        
    });

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
    }

    /* mask 처리 */
    function _initMask(){
        var options = {
            onKeyPress : function(cep, event, currentField, options){
                var tid = event.currentTarget.id;
                var tidx = tid.substr(tid.length - 1, 1);
                //console.log(tidx);
                //fnCaculateTotal(tidx);
            },
            reverse : true
        };

        $('input.calendar').mask('0000-00-00',options);
        $('input.money').mask('#,###,###',options);
        $('div.money').mask('999,999,999',{reverse:true});
        $('span.money').mask('999,999,999',{reverse:true});

    }


    function fnShowTest(p, n){
        if(p == 'Y'){
            $("#panel_body_view" + n).show();
        }else{
            $("#panel_body_view" + n).hide();
            $("#panel_body_edit" + n).hide();
        }
    }

    function fnWinClose(){
        window.opener.location.href = "/";
        self.close();
    }
</script>


