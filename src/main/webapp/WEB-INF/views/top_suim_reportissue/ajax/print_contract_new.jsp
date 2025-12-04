<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
           <table id="table_issue_contract_view" style="border: 1px solid">
                <colgroup>
                    <col width="15%">
                    <col width="35%">
                    <col width="15%">                    
                    <col width="35%">
                </colgroup>                
                <tr>
                    <th>보&nbsp;&nbsp;험&nbsp;&nbsp;사&nbsp;&nbsp;명</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.ptnrName}</td>
                    <th>보&nbsp;&nbsp;험&nbsp;&nbsp;종&nbsp;&nbsp;목</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.insuranceNm}</td>
                </tr>
                <!-- 계약자 피보험자 시작 by top3009 -->
                <tr>
                    <th>계&nbsp;&nbsp;&nbsp;&nbsp;약&nbsp;&nbsp;&nbsp;&nbsp;자</th>
                    <td style="text-align: left;">
                    	&nbsp;${rptIssueMain.policyholderNm}
                    	<c:if test="${not empty rptIssueMain.policyholderTel}">
                    		<br/>&nbsp;(&#9742; ${rptIssueMain.policyholderTel})
                    	</c:if>
                    </td>
                    <th>피&nbsp;&nbsp;보&nbsp;&nbsp;험&nbsp;&nbsp;자</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.beneficiaryNm}
                    	<c:if test="${not empty rptIssueMain.beneficiaryTel}">
                    		<br/>&nbsp;(&#9742; ${rptIssueMain.beneficiaryTel})
                    	</c:if>
                    </td>
                </tr>
                <!-- 계약자 피보험자 끝 by top3009 -->   
                <tr>
                    <th>보&nbsp;&nbsp;험&nbsp;&nbsp;기&nbsp;&nbsp;간</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.insuTerm}</td>
                    <th>담&nbsp;&nbsp;보&nbsp;&nbsp;내&nbsp;&nbsp;용</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.insuCondition}</td>
                </tr>
                <tr>
                <c:choose>
                	<c:when test="${suim_rpt_type1 eq '3' or suim_rpt_type1 eq '4'}">
                		<th>가&nbsp;&nbsp;입&nbsp;&nbsp;금&nbsp;&nbsp;액</th>
	                    <td style="text-align: left;" colspan="3">&nbsp;${rptIssueMain.amtCompensationLimitUnit} 
	                    	<span class="money">${rptIssueMain.amtCompensationLimit}</span>                    
	                    </td>	                    
                	</c:when>
                	<c:otherwise>
                		<th>가&nbsp;&nbsp;입&nbsp;&nbsp;금&nbsp;&nbsp;액</th>
	                    <td style="text-align: left;">&nbsp;${rptIssueMain.amtCompensationLimitUnit} 
	                    	<span class="money">${rptIssueMain.amtCompensationLimit}</span>                    
	                    </td>
	                    <th>자 기 부 담 금</th>
	                    <td style="text-align: left;">&nbsp;${rptIssueMain.amtSelfPayUnit} 
	                    	<span class="money">${rptIssueMain.amtSelfPay}</span>                    
	                    </td>
                	</c:otherwise>
                </c:choose>
                </tr>                               
            </table>
            <table id="table_issue_contract_edit" style="display:none;">
                    <col width="15%">
                    <col width="35%">
                    <col width="15%">                    
                    <col width="35%">
                <tr>
					<th>보&nbsp;&nbsp;험&nbsp;&nbsp;사&nbsp;&nbsp;명</th>
                    <td style="text-align: left;">&nbsp;${rptIssueMain.ptnrName}</td>
                    <th>보&nbsp;&nbsp;험&nbsp;&nbsp;종&nbsp;&nbsp;목</th>
                    <td style="text-align: left;"><input type="text" id="insurance_nm" value="${rptIssueMain.insuranceNm}"></td>
                </tr>
                <!-- 계약자 피보험자 시작 by top3009 -->
                <tr>
                    <th>계&nbsp;&nbsp;&nbsp;&nbsp;약&nbsp;&nbsp;&nbsp;&nbsp;자</th>
                    <td style="text-align: left;"><input type="text" id="policyholder_nm" value="${rptIssueMain.policyholderNm}"></td>
                    <th>피&nbsp;&nbsp;보&nbsp;&nbsp;험&nbsp;&nbsp;자</th>
                    <td style="text-align: left;"><input type="text" id="beneficiary_nm" value="${rptIssueMain.beneficiaryNm}"></td>
                </tr>
                <tr>
                    <th>계약자연락처</th>
                    <td style="text-align: left;padding-left:5px;">
                    	<input type="text" size="5" maxlength="4" id="poltel_1" value="${policyholder_tel_1}" onkeydown="javascript:onlyNumberFunc2(this);" style="width:50px;IME-MODE: disabled;"> -
						<input type="text" size="5" maxlength="4" id="poltel_2" value="${policyholder_tel_2}" onkeydown="javascript:onlyNumberFunc2(this);" style="width:60px;IME-MODE: disabled;"> -
						<input type="text" size="5" maxlength="4" id="poltel_3" value="${policyholder_tel_3}" onkeydown="javascript:onlyNumberFunc2(this);" style="width:60px;IME-MODE: disabled;"> 
                    </td>
                    <th>피보험자연락처</th>
                    <td style="text-align: left; left;padding-left:5px;">
                    	<input type="text" size="5" maxlength="4" id="bentel_1" value="${beneficiary_tel_1}" onkeydown="javascript:onlyNumberFunc2(this);" style="width:50px;IME-MODE: disabled;"> -
						<input type="text" size="5" maxlength="4" id="bentel_2" value="${beneficiary_tel_2}" onkeydown="javascript:onlyNumberFunc2(this);" style="width:60px;IME-MODE: disabled;"> -
						<input type="text" size="5" maxlength="4" id="bentel_3" value="${beneficiary_tel_3}" onkeydown="javascript:onlyNumberFunc2(this);" style="width:60px;IME-MODE: disabled;"> 
                    </td>
                </tr>
                <!-- 계약자 피보험자 끝 by top3009 --> 
                <tr>
                    <th>보&nbsp;&nbsp;험&nbsp;&nbsp;기&nbsp;&nbsp;간</th>
					<td style="text-align: left;">
					    <input class="calendar" type="text" id="insu_term" value="" style="width: 35%;"/>
					    &nbsp;~&nbsp;
					    <input class="calendar" type="text" id="insu_term_end" value="" style="width: 35%;"/>	                    
					</td>
                    <th>담&nbsp;&nbsp;보&nbsp;&nbsp;내&nbsp;&nbsp;용</th>
                    <td style="text-align: left;"><input type="text" id="insu_condition" value="${rptIssueMain.insuCondition}"></td>
                </tr>      
                <tr>
                	<c:choose>
	                	<c:when test="${suim_rpt_type1 eq '3' or suim_rpt_type1 eq '4'}">
	                		<th>가&nbsp;&nbsp;입&nbsp;&nbsp;금&nbsp;&nbsp;액</th>
		                    <td style="text-align: left;" colspan="3">
								<select class="selectTxt" id="select_amt_compensation_limit_unit" >
									<option value="￦" <c:if test="${rptIssueMain.amtCompensationLimitUnit eq '￦'}"> selected="selected" </c:if>>￦</option>
									<option value="$" <c:if test="${rptIssueMain.amtCompensationLimitUnit eq '$'}"> selected="selected" </c:if>>$</option>
									<option value="99" <c:if test="${rptIssueMain.amtCompensationLimitUnit ne null && rptIssueMain.amtCompensationLimitUnit ne '' && rptIssueMain.amtCompensationLimitUnit ne '￦' && rptIssueMain.amtCompensationLimitUnit ne '$'}"> selected="selected" </c:if>>직접입력</option>
								</select>
								<input type="text" id="amt_compensation_limit_unit" style="display: none;" value="${rptIssueMain.amtCompensationLimitUnit}"> 
		                    	<input class="money"  type="text" id="amt_compensation_limit" value="${rptIssueMain.amtCompensationLimit}">
		                    	
		                    	<input type="hidden" id="amt_self_pay_unit" value="${rptIssueMain.amtSelfPayUnit}"> 
		                    	<input type="hidden" id="amt_self_pay" value="${rptIssueMain.amtSelfPay}">                    
		                    </td>		                    
	                	</c:when>
	                	<c:otherwise>
	                		<th>가&nbsp;&nbsp;입&nbsp;&nbsp;금&nbsp;&nbsp;액</th>
		                    <td style="text-align: left;">
								<select class="selectTxt" id="select_amt_compensation_limit_unit" >
									<option value="￦" <c:if test="${rptIssueMain.amtCompensationLimitUnit eq '￦'}"> selected="selected" </c:if>>￦</option>
									<option value="$" <c:if test="${rptIssueMain.amtCompensationLimitUnit eq '$'}"> selected="selected" </c:if>>$</option>
									<option value="99" <c:if test="${rptIssueMain.amtCompensationLimitUnit ne null && rptIssueMain.amtCompensationLimitUnit ne '' && rptIssueMain.amtCompensationLimitUnit ne '￦' && rptIssueMain.amtCompensationLimitUnit ne '$'}"> selected="selected" </c:if>>직접입력</option>
								</select>
								<input type="text" id="amt_compensation_limit_unit" style="display: none;" value="${rptIssueMain.amtCompensationLimitUnit}"> 
		                    	<input class="money"  type="text" id="amt_compensation_limit" value="${rptIssueMain.amtCompensationLimit}">                    
		                    </td>
		                    <th>자 기 부 담 금</th>
		                    <td style="text-align: left;">
								<select class="selectTxt" id="select_amt_self_pay_unit"  >
									<option value="￦" <c:if test="${rptIssueMain.amtSelfPayUnit eq '￦'}"> selected="selected" </c:if>>￦</option>
									<option value="$" <c:if test="${rptIssueMain.amtSelfPayUnit eq '$'}"> selected="selected" </c:if>>$</option>
									<option value="99" <c:if test="${rptIssueMain.amtSelfPayUnit ne null && rptIssueMain.amtSelfPayUnit ne '' && rptIssueMain.amtSelfPayUnit ne '￦' && rptIssueMain.amtSelfPayUnit ne '$'}"> selected="selected" </c:if>>직접입력</option>
								</select>
						        <input type="text" id="amt_self_pay_unit" style="display: none;" value="${rptIssueMain.amtSelfPayUnit}"> 
		                    	<input class="money"  type="text" id="amt_self_pay" value="${rptIssueMain.amtSelfPay}">                    
		                    </td>
	                	</c:otherwise>
                	</c:choose>                    
                </tr>                             
            </table>    
            
<script type="text/javascript">

$(document).ready(function() {
	_initMask();		
	_initCalendar();		
	_initEvent();

	//입력값에 '~' 있으면 분리해서 넣어준다.
	var sDate = '${rptIssueMain.insuTerm}';						
	if( sDate.indexOf("~") > -1 ){
		var bDate = sDate.split("~");
		$("#insu_term").val(bDate[0]);
		$("#insu_term_end").val(bDate[1]);
	}
	//달력추가 끝 by top3009

});

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

function _initCalendar(){
 	$('.calendar').datepicker({ 
    	   showOn: 'button',
    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
    	   buttonImageOnly: true,
    	   buttonText: "달력", 
    	   changeMonth: true,
    	   changeYear: true,	    	   
    	   showButtonPanel: false	    	   
    });				
}
</script>