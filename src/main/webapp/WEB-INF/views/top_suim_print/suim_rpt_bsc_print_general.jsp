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

        window.open('/reportBscInfo?suim_rpt_no='+'${param.suim_rpt_no}'+'&cmd=word','word','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
    }

    //일반보고서 출력    
    function fnReportPrintGenaral(){
        var cw=screen.availWidth;
        var ch=screen.availHeight;

        var sw=700; //띄울 창의 넓이
        var sh=550;  //띄울 창의 높이

        var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
        var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치

        window.open('/reportBscInfo?suim_rpt_no='+'${param.suim_rpt_no}'+'&cmd=print','print','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
    }
</script>
<div class="reportWrap">
    <div class="reportContent">
        <input type="hidden" id="suim_rpt_no" value="${param.suim_rpt_no}">
        <input type="hidden" id="rpt_print_no" value="${reportPrint1.rptPrintNo}">
        <div class="text-right">
            <a href="/reportBscInfo?suim_rpt_no=${param.suim_rpt_no}&cmd=word"><img src="./resources/ls_img/report/btn_word.gif"></a>
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
                <tr>
                    <td>손해사정사</td>
                    <td>윤경수</td>
                    <td><img src="./resources/ls_img/ls_body/sign_yoon.jpg" width="62" height="60" border="0"></td>
                    <td>070-8255-3000</td>
                </tr>
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
            
            function fnClaimSubCancel2(){
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
		                            <a href="#noloc" id="btn_claim_sub2_delete${status.index}" onclick="fnClaimSubDelete2('${item.serialNo}');"><img src='./resources/ls_img/btn_del_s.gif'></a>
		                        </td>
		                    </tr>		                    	                    			                
		                </c:forEach>
		                <tr id="tr_claim_sub_add2" style="display: none;">		                		                
		                    <td colspan="2"><input type="text" id="c_mortgage_type" value="" maxlength="200"></td>
		                    <td><input type="text" id="c_mortgage_amount" value="" class="money" style="text-align: right" maxlength="12"></td>		                    
		                    <td style="text-align: center">
		                        <a href="#noloc" id="btn_claim_sub_save" onclick="fnClaimSubSave2();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		                        <a href="#noloc" id="btn_claim_sub_cancel" onclick="fnClaimSubCancel2();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
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
                <tr id="tr_emphasis_result_view" style="height: 204px;">
                    <th>조사결과</th>
                    <td style="vertical-align: top;">
                        ${fn:replace(fn:replace(fn:escapeXml(reportPrint1.inspectResult4) , CRLF , '<br>'), ' ', '&nbsp;')}
                    </td>
                    <td><a id="btn_emphasis_result_edit" href="#noloc" onclick="fnEmphasisResultEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a></td>
                </tr>
                <tr id="tr_emphasis_result_edit" style="display: none">
                    <th>조사결과</th>
                    <td>
                        <select id="select_emphasis_result" style="margin-bottom: 5px;" onchange="fnEmphasisResultChange(this);">
                            <option value="">직접입력</option>
                            <c:forEach  var="item" items="${reportResultCodeList}" varStatus="status">
                                <option value="${item.colVal}">${item.colVal}</option>
                            </c:forEach>
                        </select>
                        <textarea id="textarea_emphasis_result" style="height: 150px;">${reportPrint1.inspectResult4}</textarea>
                    </td>
                    <td>
                        <a id="btn_emphasis_result_save" href="#noloc" onclick="fnEmphasisResultSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        <a id="btn_emphasis_result_close" href="#noloc" onclick="fnEmphasisResultClose();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                    </td>
                </tr>
            </table>
        </div>
        <!--// 4. 중정 조사사항 및 조사 결과 -->
        <!-- 5.총괄 경과표 -->
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle">5.총괄 경과표</p>
            </div>
            <div class="display-cell text-right">
                <a href="#noloc" id="btn_general_pass_add" onclick="fnGeneralPassAdd();"><img src="./resources/ls_img/ls_body/btn_add.gif"/></a>
            </div>
        </div>
        <script type="text/javascript">
            function fnGeneralPassAdd(){
                $("#btn_general_pass_add").hide();
                $("#tr_general_pass_add").show();
            }
            function fnGeneralPassCancel(){
                $("#btn_general_pass_add").show();
                $("#tr_general_pass_add").hide();
            }

            function fnGeneralPassSave(type, idx){

                if($("#gp_sort_sn" + idx).val() == ""){
                    alert("정렬 순서를 입력해주세요.");
                    $("#gp_sort_sn" + idx).focus();
                    return;
                }

                if($("#investigate_to_date" + idx).val() == ""){
                    alert("시작일자를 입력해주세요.");
                    $("#investigate_to_date" + idx).focus();
                    return;
                }

                if($("#investigate_from_date" + idx).val() == ""){
                    alert("종료일자를 입력해주세요.");
                    $("#investigate_from_date" + idx).focus();
                    return;
                }

                if($("#investigate_date_dtl" + idx).val() == ""){
                    alert("입통원 내용을 입력해주세요.");
                    $("#investigate_date_dtl" + idx).focus();
                    return;
                }

                if($("#investigate_dtl" + idx).val() == ""){
                    alert("내용을 입력해주세요.");
                    $("#investigate_dtl" + idx).focus();
                    return;
                }

                fnGeneralPass(type, idx);
            }

            function fnGeneralPassEdit(idx){
                $("#tr_general_pass_view" + idx).hide();
                $("#tr_general_pass_edit" + idx).show();
            }
            function fnGeneralPassClose(idx){
                $("#tr_general_pass_view" + idx).show();
                $("#tr_general_pass_edit" + idx).hide();
            }

            function fnGeneralPassDelete(idx){
                if(confirm("삭제하시겠습니까?")){
                    fnGeneralPass('D', idx);
                }
            }

            function fnGeneralPassType(type, idx){

                var diff = "";

                if ($("#investigate_to_date" + idx).val() != "" && $("#investigate_from_date" + idx).val() != ""){

                    if(!$("#investigate_to_date" + idx).val().isValidDate()){
                        alert("날짜형식이 올바르지 않습니다.");
                        $("#investigate_to_date" + idx).focus();
                        return;
                    }

                    if(!$("#investigate_from_date" + idx).val().isValidDate()){
                        alert("날짜형식이 올바르지 않습니다.");
                        $("#investigate_from_date" + idx).focus();
                        return;
                    }

                    diff = getDiffDays($("#investigate_to_date" + idx).val().toDate(), $("#investigate_from_date" + idx).val().toDate());
                    diff = diff + 1;
                }else{
                    diff = "0";
                }

                if (type == '1'){
                    $("#investigate_date_dtl" + idx).val("입원 " + diff + "일");
                }else if(type == '2'){
                    $("#investigate_date_dtl" + idx).val("통원 " + diff + "일");
                }
            }

            function fnGeneralPass(type, idx){
                var param = {};
                param.suim_rpt_no           = $("#suim_rpt_no").val();
                param.rpt_print_no          = $("#rpt_print_no").val();
                param.type                  = type;
                if (type == 'U' || type == 'D' ){
                    param.serial_no         = $("#g_serial_no" + idx).val();
                }

                param.investigate_to_date   = $("#investigate_to_date" + idx).val();
                param.investigate_from_date = $("#investigate_from_date" + idx).val();
                param.investigate_date_dtl  = $("#investigate_date_dtl" + idx).val();
                param.investigate_dtl       = $("#investigate_dtl" + idx).val().textAreaToHtml();
                param.investigate_outline   = $("#investigate_outline" + idx).val();
                param.sort_sn               = $("#gp_sort_sn" + idx).val();

                var url = "./report_general_pass";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#div_general_pass").html(data);
                        fnGeneralPassCancel();
                        fnAccidentProcessRefresh(); //사고처리 처리과정 새로고침
                        fnAttachDocRefresh();       //첨부서류 새로고침
                        _initDatePicker();
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
        </script>

        <div id="div_general_pass">
            <table>
                <colgroup>
                    <col width="9%">
                    <col width="25%">
                    <col width="41%">
                    <col width="14%">
                    <col width="9%">
                </colgroup>
                <tr>
                    <th>정렬</th>
                    <th>일자</th>
                    <th>내용</th>
                    <th>비고</th>
                    <th>-</th>
                </tr>
                <c:forEach  var="item" items="${reportGeneralPassList}" varStatus="status">
                    <tr id="tr_general_pass_view${status.index}" style="height: 125px;">
                        <td style="text-align: center">${item.sortSn}</td>
                        <td style="text-align: center">
                            ${item.investigateToDate}<br> ~ ${item.investigateFromDate}<br> (${item.investigateDateDtl})
                        </td>
                        <td style="vertical-align: top;">${item.investigateDtl}</td>
                        <td>${item.investigateOutline}</td>
                        <td style="text-align: center">
                            <a href="#noloc" onclick="fnGeneralPassEdit('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
                            <a href="#noloc" onclick="fnGeneralPassDelete('${status.index}');"><img src='./resources/ls_img/btn_del_s.gif'></a>
                        </td>
                    </tr>
                    <tr id="tr_general_pass_edit${status.index}" style="display: none">
                        <td>
                            <input type="text" id="gp_sort_sn${status.index}" name="sort_sn" value="${item.sortSn}" onkeyup="digitOnly(this);" style="text-align: right" maxlength="3">
                        </td>
                        <td style="text-align: center">
                            <input type="hidden" id="g_serial_no${status.index}" value="${item.serialNo}">
                            <input type="text" id="investigate_to_date${status.index}" class="calendar" value="${item.investigateToDate}" style="width: 55%;" maxlength="10"/> ~ <br>
                            <input type="text" id="investigate_from_date${status.index}" class="calendar" value="${item.investigateFromDate}" style="width: 55%;" maxlength="10"/><br/>
                            <input type="radio" id="patientType1${status.index}" name="patientType" onclick="fnGeneralPassType('1','${status.index}');" checked="checked"><label for="patientType1${status.index}">입원</label>&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="radio" id="patientType2${status.index}" name="patientType" onclick="fnGeneralPassType('2','${status.index}');"><label for="patientType2${status.index}">통원</label><br>
                            <input type="text" id="investigate_date_dtl${status.index}" value="${item.investigateDateDtl}" maxlength="20"/>
                        </td>
                        <td>
                            <c:set var="investigateDtl" value="${fn:replace(item.investigateDtl, '<br>' , CRLF)}"/>
                            <c:set var="investigateDtl" value="${fn:replace(investigateDtl, '&nbsp;' , ' ')}"/>
                            <textarea id="investigate_dtl${status.index}" style="height: 100px;">${investigateDtl}</textarea>
                        </td>
                        <td>
                            <input type="text" id="investigate_outline${status.index}" value="${item.investigateOutline}">
                        </td>
                        <td style="text-align: center">
                            <a href="#noloc" id="btn_general_pass_save" onclick="fnGeneralPassSave('U','${status.index}');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                            <a href="#noloc" id="btn_general_pass_close" onclick="fnGeneralPassClose('${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                        </td>
                    </tr>
                </c:forEach>
                <tr id="tr_general_pass_add" style="display: none">
                    <td>
                        <input type="text" id="gp_sort_sn" name="sort_sn" onkeyup="digitOnly(this);" style="text-align: right" maxlength="3">
                    </td>
                    <td style="text-align: center">
                        <input type="text" id="investigate_to_date" class="calendar" name="stDate" value="" style="width: 55%;" maxlength="10"/> ~ <br>
                        <input type="text" id="investigate_from_date" class="calendar" name="edDate" value="" style="width: 55%;" maxlength="10"/><br/>
                        <input type="radio" id="patientType1" name="patientType" onclick="fnGeneralPassType('1','');"><label for="patientType1">입원</label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="radio" id="patientType2" name="patientType" onclick="fnGeneralPassType('2','');"><label for="patientType2">통원</label><br>
                        <input type="text" id="investigate_date_dtl" value="" maxlength="20"/>
                    </td>
                    <td>
                        <%
                            String preTextAreaAddText = "- 내원경위 : \n- 검사사항 : \n- 진단병명 : \n- 치료사항 : \n";
                        %>
                        <textarea id="investigate_dtl" style="height: 100px;"><%=preTextAreaAddText%></textarea>
                    </td>
                    <td>
                        <input type="text" id="investigate_outline" value="">
                    </td>
                    <td style="text-align: center">
                        <a href="#noloc" onclick="fnGeneralPassSave('C','');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        <a href="#noloc" onclick="fnGeneralPassCancel();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                    </td>
                </tr>
            </table>
        </div>
        <!--// 5.총괄 경과표 -->
        <!-- 6.상세확인사항 -->
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell" style="width: 80%;">
                <p class="subtitle">6.상세 확인사항 &nbsp;&nbsp;&nbsp;<span style="color:red; font-size: 11px; font-weight: bold">(상세 설명이 필요한 경우 해당되는 사항만 선택하여 기재)</span></p>
            </div>
            <div class="display-cell text-right" style="width: 20%;">
                <a href="#noloc" id="btn_detail_confirm_add" onclick="fnDetailConfirmAdd();"><img src="./resources/ls_img/ls_body/btn_add.gif"/></a>
            </div>
        </div>

        <script type="text/javascript">
            function fnDetailConfirmUseFlag(useAt, idx){
                if(useAt == '1'){
                    $("#div_detail_confirm_view" + idx).show();
                    $("#div_detail_confirm_edit" + idx).hide();
                }else if(useAt == '0'){
                    $("#div_detail_confirm_view" + idx).hide();
                    $("#div_detail_confirm_edit" + idx).hide();
                }

                var param = {};
                param.suim_rpt_no           = $("#suim_rpt_no").val();
                param.rpt_print_no          = $("#rpt_print_no").val();
                param.serial_no             = $("#d_serial_no" + idx).val();
                param.detail_gubun          = idx;
                param.use_flag              = useAt;

                var url = "./report_detail_confirm_useflag";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "json",
                    timeout: 20000,
                    success: function(data){
                        $("#d_serial_no" + idx).val(data.serial_no);
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

            function fnDetailConfirmEdit(idx) {
                $("#div_detail_confirm_view" + idx).hide();
                $("#div_detail_confirm_edit" + idx).show();
            }

            function fnDetailConfirmClose(idx) {
                $("#div_detail_confirm_view" + idx).show();
                $("#div_detail_confirm_edit" + idx).hide();
            }

            function fnDetailConfirmUpdate(idx, type) {
                var param = {};
                param.suim_rpt_no           = $("#suim_rpt_no").val();
                param.rpt_print_no          = $("#rpt_print_no").val();
                param.serial_no             = $("#d_serial_no" + idx).val();

                if(type =='Y'){
                    param.detail_gubun          = '99';
                }else{
                    param.detail_gubun          = idx;
                }

                param.detail_title          = $("#detail_title" + idx).val();
                param.detail_content        = $("#detail_content" + idx).val().textAreaToHtml();
                param.detail_content_sub    = $("#detail_content_sub" + idx).val();

                var url = "./report_detail_confirm_update";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "json",
                    timeout: 20000,
                    success: function(data){

                        fnDetailConfirmSuccess(data, idx);
                        fnDetailConfirmClose(idx);
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

            function fnDetailConfirmSuccess(data, idx){

                var txt = "";
                var html = "";
                if(data.detail_gubun == 1){
                    txt = " 확인결과, 아래와 같이 확인됨.<br>";
                    html = data.detail_content_sub + txt + data.detail_content;
                }else if(data.detail_gubun == 2){
                    txt = " 확인결과 <br>";
                    html = data.detail_content_sub + txt + data.detail_content;
                }else{
                    html = data.detail_content;
                }

                $("#div_detail_confirm_view_txt" + idx).html(html);

                if(data.detail_gubun == 99){
                    $("#div_detail_confirm_view_title" + idx).html(data.detail_title);
                }

            }

            function fnDetailConfirmTxtBtn(idx, msg){
                var subTxt = $("#detail_content_sub" + idx).val();
                if (subTxt == "") {
                    $("#detail_content_sub" + idx).val(msg);
                }else{
                    $("#detail_content_sub" + idx).val(subTxt + ', ' + msg);
                }
            }

            function fnDetailConfirmAdd() {
                $("#btn_detail_confirm_add").hide();
                $("#div_detail_confirm_add").show();
                $("#detail_title").focus();
            }

            function fnDetailConfirmCancel() {
                $("#btn_detail_confirm_add").show();
                $("#div_detail_confirm_add").hide();
            }

            function fnDetailConfirmSave() {
                var param = {};
                param.suim_rpt_no           = $("#suim_rpt_no").val();
                param.rpt_print_no          = $("#rpt_print_no").val();
                param.detail_gubun          = '99';
                param.detail_title          = $("#detail_title").val();
                param.detail_content        = $("#detail_content").val().textAreaToHtml();

                var url = "./report_detail_confirm_insert";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "html",
                    timeout: 20000,
                    success: function(data){
                        $("#div_detail_confirm_etc_list").html(data);
                        fnDetailConfirmCancel();
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

            function fnDetailConfirmDel(idx){
                if(confirm("삭제하시겠습니까?")){
                    var param = {};
                    param.suim_rpt_no           = $("#suim_rpt_no").val();
                    param.rpt_print_no          = $("#rpt_print_no").val();
                    param.serial_no             = $("#d_serial_no" + idx).val();

                    var url = "./report_detail_confirm_delete";

                    $.ajax({
                        type: "POST",
                        url: url,
                        data: param,
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        dataType: "html",
                        timeout: 20000,
                        success: function(data){
                            $("#div_detail_confirm_etc_list").html(data);
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

        <div id="div_detail_confirm1" style="border: 1px solid #000000"> <!--직업 직무 확인 -->
            <c:set var="item1" value="${reportDetailConfirmMap.detail1}"/>
            <div class="display-table" style="height: 40px; background-color:#ececec;">
                <div class="display-cell panel-title" style="width: 80%; padding-left: 10px;">
                    직업(직무) 확인  <span style="font-size: 10px; color: red">ex) 피보험자, 회사 등 관계인, 근로복지공단 등 구분</span>
                </div>
                <div class="display-cell text-right" style="width: 20%; padding-right: 10px;">
                    <input type="hidden" id="d_serial_no1" value="${item1.serialNo}">
                    <input type="radio" id="d_use_flag11" name="useFlag11" onclick="fnDetailConfirmUseFlag('1','1');" <c:if test="${item1.useFlag == 1}">checked="checked"</c:if>> <label for="d_use_flag11">사용</label>
                    <input type="radio" id="d_use_flag12" name="useFlag11" onclick="fnDetailConfirmUseFlag('0','1');" <c:if test="${item1.useFlag == 0}">checked="checked"</c:if>> <label for="d_use_flag12">미사용</label>
                </div>
            </div>
            <c:choose>
                <c:when test="${item1.useFlag == 1}">
                    <c:set var="confirm_view1_display" value=""/>
                </c:when>
                <c:otherwise>
                    <c:set var="confirm_view1_display" value="display: none;"/>
                </c:otherwise>
            </c:choose>
            <div id="div_detail_confirm_view1" class="display-table" style="border-top: 1px solid #000000; height: 100px; ${confirm_view1_display}">
                <div id="div_detail_confirm_view_txt1" class="display-cell" style="width: 91%; padding: 5px; vertical-align: top">
                    ${item1.detailContentSub} 확인결과, 아래와 같이 확인됨.<br>
                    ${item1.detailContent}
                </div>
                <div class="display-cell text-center" style="width: 9%;">
                    <a href="#noloc" onclick="fnDetailConfirmEdit('1');"><img src='./resources/ls_img/btn_edite.gif'></a>
                </div>
            </div>
            <div id="div_detail_confirm_edit1" class="display-table" style="border-top: 1px solid #000000; display: none">
                <div class="display-cell" style="width: 91%; padding: 5px;">
                    <c:forEach  var="item" items="${reportJobCodeList}" varStatus="status">
                        <button class="btn btn-default" onclick="fnDetailConfirmTxtBtn('1','${item.colVal}');">${item.colVal}</button>
                    </c:forEach>
                    <input type="text" id="detail_content_sub1" value="${item1.detailContentSub}" style="width: 60%; margin-top: 4px;">확인결과 아래와 같이 확인됨.
                    <textarea id="detail_content1" style="height: 150px;">${fn:replace(fn:replace(item1.detailContent,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
                </div>
                <div class="display-cell text-center" style="width: 9%;">
                    <a href="#noloc" onclick="fnDetailConfirmUpdate('1')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                    <a href="#noloc" onclick="fnDetailConfirmClose('1');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                </div>
            </div>
        </div>
        <div id="div_detail_confirm2" style="border: 1px solid #000000; margin-top: 10px;"> <!--사고 경위 확인 -->
            <c:set var="item2" value="${reportDetailConfirmMap.detail2}"/>
            <div class="display-table" style="height: 40px; background-color:#ececec;">
                <div class="display-cell panel-title" style="width: 80%; padding-left: 10px;">
                    사고 경위 확인  <span style="font-size: 10px; color: red">ex) 피보험자, 목격자, 근로복지공단, 경찰서 등 구분</span>
                </div>
                <div class="display-cell text-right" style="width: 20%; padding-right: 10px;">
                    <input type="hidden" id="d_serial_no2" value="${item2.serialNo}">
                    <input type="radio" id="d_use_flag21" name="useFlag21" onclick="fnDetailConfirmUseFlag('1','2');" <c:if test="${item2.useFlag == 1}">checked="checked"</c:if>> <label for="d_use_flag21">사용</label>
                    <input type="radio" id="d_use_flag22" name="useFlag21" onclick="fnDetailConfirmUseFlag('0','2');" <c:if test="${item2.useFlag == 0}">checked="checked"</c:if>> <label for="d_use_flag22">미사용</label>
                </div>
            </div>
            <c:choose>
                <c:when test="${item2.useFlag == 1}">
                    <c:set var="confirm_view2_display" value=""/>
                </c:when>
                <c:otherwise>
                    <c:set var="confirm_view2_display" value="display: none;"/>
                </c:otherwise>
            </c:choose>
            <div id="div_detail_confirm_view2" class="display-table" style="border-top: 1px solid #000000; height: 100px; ${confirm_view2_display}">
                <div id="div_detail_confirm_view_txt2" class="display-cell" style="width: 91%; padding: 5px; vertical-align: top">
                    ${item2.detailContentSub} 확인결과,<br>
                    ${item2.detailContent}
                </div>
                <div class="display-cell text-center" style="width: 9%;">
                    <a href="#noloc" onclick="fnDetailConfirmEdit('2');"><img src='./resources/ls_img/btn_edite.gif'></a>
                </div>
            </div>
            <div id="div_detail_confirm_edit2" class="display-table" style="border-top: 1px solid #000000; display: none;">
                <div class="display-cell" style="width: 91%; padding: 5px;">
                    <c:forEach  var="item" items="${reportAccidentCodeList}" varStatus="status">
                        <button class="btn btn-default" onclick="fnDetailConfirmTxtBtn('2','${item.colVal}');">${item.colVal}</button>
                    </c:forEach>
                    <input type="text" id="detail_content_sub2" value="${item2.detailContentSub}" style="width: 60%; margin-top: 4px;">확인결과,
                    <textarea id="detail_content2" style="height: 150px;">${fn:replace(fn:replace(item2.detailContent,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
                </div>
                <div class="display-cell text-center" style="width: 9%;">
                    <a href="#noloc" onclick="fnDetailConfirmUpdate('2')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                    <a href="#noloc" onclick="fnDetailConfirmClose('2');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                </div>
            </div>
        </div>

        <div id="div_detail_confirm3" style="border: 1px solid #000000; margin-top: 10px;"> <!--병원 확인 -->
            <c:set var="item3" value="${reportDetailConfirmMap.detail3}"/>
            <div class="display-table" style="height: 40px; background-color:#ececec;">
                <div class="display-cell panel-title" style="width: 80%; padding-left: 10px;">
                    병원 확인  <span style="font-size: 10px; color: red">ex) 장해소견, 진단소견 의학적 인과관계등 설명이 필요한 경우에 한하여 작성</span>
                </div>
                <div class="display-cell text-right" style="width: 20%; padding-right: 10px;">
                    <input type="hidden" id="d_serial_no3" value="${item3.serialNo}">
                    <input type="radio" id="d_use_flag31" name="useFlag31" onclick="fnDetailConfirmUseFlag('1','3');" <c:if test="${item3.useFlag == 1}">checked="checked"</c:if>> <label for="d_use_flag31">사용</label>
                    <input type="radio" id="d_use_flag32" name="useFlag31" onclick="fnDetailConfirmUseFlag('0','3');" <c:if test="${item3.useFlag == 0}">checked="checked"</c:if>> <label for="d_use_flag32">미사용</label>
                </div>
            </div>
            <c:choose>
                <c:when test="${item3.useFlag == 1}">
                    <c:set var="confirm_view3_display" value=""/>
                </c:when>
                <c:otherwise>
                    <c:set var="confirm_view3_display" value="display: none;"/>
                </c:otherwise>
            </c:choose>
            <div id="div_detail_confirm_view3" class="display-table" style="border-top: 1px solid #000000; height: 100px; ${confirm_view3_display}">
                <div id="div_detail_confirm_view_txt3" class="display-cell" style="width: 91%; padding: 5px; vertical-align: top">
                    ${item3.detailContent}
                </div>
                <div class="display-cell text-center" style="width: 9%;">
                    <a href="#noloc" onclick="fnDetailConfirmEdit('3');"><img src='./resources/ls_img/btn_edite.gif'></a>
                </div>
            </div>
            <div id="div_detail_confirm_edit3" class="display-table" style="border-top: 1px solid #000000; display: none;">
                <div class="display-cell" style="width: 91%; padding: 5px;">
                    <textarea id="detail_content3" style="height: 150px;">${fn:replace(fn:replace(item3.detailContent,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
                </div>
                <div class="display-cell text-center" style="width: 9%;">
                    <a href="#noloc" onclick="fnDetailConfirmUpdate('3')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                    <a href="#noloc" onclick="fnDetailConfirmClose('3');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                </div>
            </div>
        </div>


        <div id="div_detail_confirm4" style="border: 1px solid #000000; margin-top: 10px;"> <!--제 3병원 의료자문 확인 -->
            <c:set var="item4" value="${reportDetailConfirmMap.detail4}"/>
            <div class="display-table" style="height: 40px; background-color:#ececec;">
                <div class="display-cell panel-title" style="width: 80%; padding-left: 10px;">
                    제 3 병원 의료자문 확인
                </div>
                <div class="display-cell text-right" style="width: 20%; padding-right: 10px;">
                    <input type="hidden" id="d_serial_no4" value="${item4.serialNo}">
                    <input type="radio" id="d_use_flag41" name="useFlag41" onclick="fnDetailConfirmUseFlag('1','4');" <c:if test="${item4.useFlag == 1}">checked="checked"</c:if>> <label for="d_use_flag41">사용</label>
                    <input type="radio" id="d_use_flag42" name="useFlag41" onclick="fnDetailConfirmUseFlag('0','4');" <c:if test="${item4.useFlag == 0}">checked="checked"</c:if>> <label for="d_use_flag42">미사용</label>
                </div>
            </div>
            <c:choose>
                <c:when test="${item4.useFlag == 1}">
                    <c:set var="confirm_view4_display" value=""/>
                </c:when>
                <c:otherwise>
                    <c:set var="confirm_view4_display" value="display: none;"/>
                </c:otherwise>
            </c:choose>
            <div id="div_detail_confirm_view4" class="display-table" style="border-top: 1px solid #000000; height: 100px; ${confirm_view4_display}">
                <div id="div_detail_confirm_view_txt4" class="display-cell" style="width: 91%; padding: 5px; vertical-align: top">
                    ${item4.detailContent}
                </div>
                <div class="display-cell text-center" style="width: 9%;">
                    <a href="#noloc" onclick="fnDetailConfirmEdit('4');"><img src='./resources/ls_img/btn_edite.gif'></a>
                </div>
            </div>
            <div id="div_detail_confirm_edit4" class="display-table" style="border-top: 1px solid #000000; display: none;">
                <div class="display-cell" style="width: 91%; padding: 5px;">
                    <textarea id="detail_content4" style="height: 150px;">${fn:replace(fn:replace(item4.detailContent,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
                </div>
                <div class="display-cell text-center" style="width: 9%;">
                    <a href="#noloc" onclick="fnDetailConfirmUpdate('4')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                    <a href="#noloc" onclick="fnDetailConfirmClose('4');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                </div>
            </div>
        </div>


        <div id="div_detail_confirm5" style="border: 1px solid #000000; margin-top: 10px;"> <!--피보험자 장해상태 확인 -->
            <c:set var="item5" value="${reportDetailConfirmMap.detail5}"/>
            <div class="display-table" style="height: 40px; background-color:#ececec;">
                <div class="display-cell panel-title" style="width: 80%; padding-left: 10px;">
                    피보험자 장해상태 확인  <br><span style="font-size: 10px; color: red">ex) 문답 과정에서 확인한 피보험자 장해상태 기술 (촬영한 사진은 보고서 뒤 별첨으로 첨부)</span>
                </div>
                <div class="display-cell text-right" style="width: 20%; padding-right: 10px;">
                    <input type="hidden" id="d_serial_no5" value="${item5.serialNo}">
                    <input type="radio" id="d_use_flag51" name="useFlag51" onclick="fnDetailConfirmUseFlag('1','5');" <c:if test="${item5.useFlag == 1}">checked="checked"</c:if>> <label for="d_use_flag51">사용</label>
                    <input type="radio" id="d_use_flag52" name="useFlag51" onclick="fnDetailConfirmUseFlag('0','5');" <c:if test="${item5.useFlag == 0}">checked="checked"</c:if>> <label for="d_use_flag52">미사용</label>
                </div>
            </div>
            <c:choose>
                <c:when test="${item5.useFlag == 1}">
                    <c:set var="confirm_view5_display" value=""/>
                </c:when>
                <c:otherwise>
                    <c:set var="confirm_view5_display" value="display: none;"/>
                </c:otherwise>
            </c:choose>
            <div id="div_detail_confirm_view5" class="display-table" style="border-top: 1px solid #000000; height: 100px; ${confirm_view5_display}">
                <div id="div_detail_confirm_view_txt5" class="display-cell" style="width: 91%; padding: 5px; vertical-align: top">
                    ${item5.detailContent}
                </div>
                <div class="display-cell text-center" style="width: 9%;">
                    <a href="#noloc" onclick="fnDetailConfirmEdit('5');"><img src='./resources/ls_img/btn_edite.gif'></a>
                </div>
            </div>
            <div id="div_detail_confirm_edit5" class="display-table" style="border-top: 1px solid #000000; display: none;">
                <div class="display-cell" style="width: 91%; padding: 5px;">
                    <textarea id="detail_content5" style="height: 150px;">${fn:replace(fn:replace(item5.detailContent,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
                </div>
                <div class="display-cell text-center" style="width: 9%;">
                    <a href="#noloc" onclick="fnDetailConfirmUpdate('5')"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                    <a href="#noloc" onclick="fnDetailConfirmClose('5');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                </div>
            </div>
        </div>
        <div id="div_detail_confirm_etc_list">
            <c:forEach  var="itemEtc" items="${reportDetailConfirmList}" varStatus="status">
                <div id="div_detail_confirm99${status.index}" style="border: 1px solid #000000; margin-top: 10px;"> <!--기타 Loop -->
                    <div id="div_detail_confirm_view99${status.index}">
                        <div class="display-table" style="height: 40px; background-color:#ececec;">
                            <div id="div_detail_confirm_view_title99${status.index}" class="display-cell panel-title" style="padding-left: 10px;">
                                ${itemEtc.detailTitle}
                            </div>
                        </div>
                        <div class="display-table" style="border-top: 1px solid #000000; height: 100px;">
                            <div id="div_detail_confirm_view_txt99${status.index}" class="display-cell" style="width: 91%; padding: 5px; vertical-align: top;">
                                ${itemEtc.detailContent}
                            </div>
                            <div class="display-cell text-center" style="width: 9%;">
                                <a href="#noloc" onclick="fnDetailConfirmEdit('99${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
                                <a href="#noloc" onclick="fnDetailConfirmDel('99${status.index}');"><img src='./resources/ls_img/btn_del_s.gif'></a>
                            </div>
                        </div>
                    </div>
                    <div id="div_detail_confirm_edit99${status.index}" style="display: none;">
                        <div class="display-table" style="height: 40px; background-color:#ececec;">
                            <div class="display-cell panel-title" style="padding-left: 10px;">
                                <input type="hidden" id="d_serial_no99${status.index}" value="${itemEtc.serialNo}">
                                <input type="text" id="detail_title99${status.index}" value="${itemEtc.detailTitle}" style="width: 80%;">
                            </div>
                        </div>
                        <div class="display-table" style="border-top: 1px solid #000000;">
                            <div class="display-cell" style="width: 91%; padding: 5px;">
                                <textarea id="detail_content99${status.index}" style="height: 150px;">${fn:replace(fn:replace(itemEtc.detailContent,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
                            </div>
                            <div class="display-cell text-center" style="width: 9%;">
                                <a href="#noloc" onclick="fnDetailConfirmUpdate('99${status.index}','Y');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                                <a href="#noloc" onclick="fnDetailConfirmClose('99${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <div id="div_detail_confirm_add" style="border: 1px solid #000000; margin-top: 10px; display: none;"> <!--기타 추가 -->
                <div class="display-table" style="height: 40px; background-color:#ececec;">
                    <div class="display-cell panel-title" style="padding-left: 10px;">
                        <input type="text" id="detail_title" style="width: 80%;" maxlength="80">
                    </div>
                </div>
                <div class="display-table" style="border-top: 1px solid #000000;">
                    <div class="display-cell" style="width: 91%; padding: 5px;">
                        <textarea id="detail_content" style="height: 150px;"></textarea>
                    </div>
                    <div class="display-cell text-center" style="width: 9%;">
                        <a href="#noloc" onclick="fnDetailConfirmSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        <a href="#noloc" onclick="fnDetailConfirmCancel();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                    </div>
                </div>
            </div>
        </div>
        <!--// 6.상세확인사항 -->

        <!-- 7.손해사정 결과(조사자 의견) -->
        <script type="text/javascript">
            function fnEmphasisOpinionEdit(){
                $("#btn_emphasis_opinion_edit").hide();
                $("#btn_emphasis_opinion_update").show();
                $("#btn_emphasis_opinion_cancel").show();
                $("#div_emphasis_opinion_view").hide();
                $("#div_emphasis_opinion_edit").show();
            }
            function fnEmphasisOpinionClose(){
                $("#btn_emphasis_opinion_edit").show();
                $("#btn_emphasis_opinion_update").hide();
                $("#btn_emphasis_opinion_cancel").hide();
                $("#div_emphasis_opinion_view").show();
                $("#div_emphasis_opinion_edit").hide();
            }

            function fnEmphasisOpinionUpdate(){
                var param = {};
                param.suim_rpt_no           = $("#suim_rpt_no").val();
                param.rpt_print_no          = $("#rpt_print_no").val();
                param.adjust_result_7       = $("#adjust_result_7").val().textAreaToHtml();

                var url = "./report_emphasis_opinion_update";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "json",
                    timeout: 20000,
                    success: function(data){
                        $("#div_emphasis_opinion_contents").html(data.adjust_result_7);
                        fnEmphasisOpinionClose();
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


            function fnEmphasisUseAt(useAt){
                if(useAt == 'Y'){
                    $("#div_emphasis_opinion").show();
                    $("#div_emphasis_opinion_view").show();
                    $("#div_emphasis_opinion_edit").hide();
                }else{
                    $("#div_emphasis_opinion_view").show();
                    $("#div_emphasis_opinion_edit").hide();
                    $("#div_emphasis_opinion").hide();
                }

                var param = {};
                param.suim_rpt_no           = $("#suim_rpt_no").val();
                param.rpt_print_no          = $("#rpt_print_no").val();
                param.use_at                = useAt;

                var url = "./report_emphasis_opinion_useat";

                $.ajax({
                    type: "POST",
                    url: url,
                    data: param,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    dataType: "json",
                    timeout: 20000,
                    success: function(data){
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
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell" style="width: 80%;">
                <p class="subtitle">7.손해사정 결과(조사자 의견)</p>
            </div>
            <div class="display-cell text-right" style="width: 20%;">
                <input type="radio" id="emphasis_use_at1" name="emphasis_use_at" onclick="fnEmphasisUseAt('Y');" <c:if test="${reportPrint1.adjustResult7UseAt == 'Y'}">checked="checked"</c:if>> <label for="emphasis_use_at1">사용</label>
                <input type="radio" id="emphasis_use_at2" name="emphasis_use_at" onclick="fnEmphasisUseAt('N');" <c:if test="${reportPrint1.adjustResult7UseAt == 'N'}">checked="checked"</c:if>> <label for="emphasis_use_at2">미사용</label>
            </div>
        </div>
        <c:choose>
            <c:when test="${reportPrint1.adjustResult7UseAt == 'Y'}">
                <c:set var="emphasis_opinion_view_display" value=""/>
            </c:when>
            <c:otherwise>
                <c:set var="emphasis_opinion_view_display" value="display: none;"/>
            </c:otherwise>
        </c:choose>
        <div id="div_emphasis_opinion" style="border: 1px solid #000000; ${emphasis_opinion_view_display}">
            <div id="div_emphasis_opinion_view" class="display-table" style="height: 164px;">
                <div id="div_emphasis_opinion_contents" class="display-cell" style="width:91%; padding: 5px; vertical-align: top">
                    ${reportPrint1.adjustResult7}
                </div>
                <div class="display-cell text-center" style="width: 9%;">
                    <a href="#noloc" id="btn_emphasis_opinion_edit" onclick="fnEmphasisOpinionEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
                </div>
            </div>
            <div id="div_emphasis_opinion_edit" class="display-table" style="display: none;">
                <div class="display-cell" style="width:91%; padding: 5px;">
                    <textarea id="adjust_result_7" style="height: 150px;">${fn:replace(fn:replace(reportPrint1.adjustResult7,'<br>', CRLF), '&nbsp;', ' ')}</textarea>
                </div>
                <div class="display-cell text-center" style="width: 9%;">
                    <a href="#noloc" id="btn_emphasis_opinion_update" onclick="fnEmphasisOpinionUpdate()" style="display: none;"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                    <a href="#noloc" id="btn_emphasis_opinion_cancel" onclick="fnEmphasisOpinionClose();" style="display: none;"><img src='./resources/ne_img/btn/btn_close.gif'></a>
                </div>
            </div>
        </div>
        <!--// 7.손해사정 결과(조사자 의견) -->



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
            <div class="display-cell text-right">
                <a href="#noloc" id="btn_accident_process_add" onclick="fnAccidentProcessAdd();"><img src="./resources/ls_img/ls_body/btn_add.gif"/></a>
            </div>
        </div>
        <c:choose><%-- 롯데손해보험일경우 --%>
            <c:when test="${reportBscInfo.ptnrId == '9'}">
                <c:import url="../top_suim_print/module/print_ctrl_process_ptnr9.jsp"></c:import>
            </c:when>
            <c:otherwise>
                <c:import url="../top_suim_print/module/print_ctrl_process_basic.jsp"></c:import>
            </c:otherwise>
        </c:choose>
        <!--// 2.처리과정 -->

        <!-- 3.첨부서류 -->
        <script type="text/javascript">
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


