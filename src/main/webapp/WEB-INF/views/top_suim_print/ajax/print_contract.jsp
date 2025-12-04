<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<script>
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
</script>