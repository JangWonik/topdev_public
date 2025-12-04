<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
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
            <a href="#noloc" id="btn_claim_sub_cancel" onclick="fnClaimSubCancel3();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
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
