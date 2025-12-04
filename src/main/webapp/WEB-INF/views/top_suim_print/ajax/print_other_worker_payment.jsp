<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

			      
        <div class="display-table" style="margin-top: 50px;">
            <div class="display-cell">
                <p class="subtitle">2. 지급공제금 지급처</p>
          </div>
        </div>
        
    	<table>
    		<colgroup>
    			<col width="15%">
    			<col width="10%">
    			<col width="10%">
    			<col width="25%">
    			<col width="20%">
    			<col width="12%">
    			<col width="8%">
    		</colgroup>	
    		<tr>
    			<th>지급처</th>
    			<th>대상자</th>
    			<th>은행명</th>
    			<th>계좌번호</th>
    			<th>지급액</th>
    			<th>비고</th>
    			<th>-</th>
    		</tr>
    		
    		<c:forEach var="item" items="${reportOtherWorkerList}" varStatus="status" >
    			 <c:choose>
	     			<c:when test="${item.workerType == 1}">
	     				<c:set var="fontStyle" value='' />
	    				 </c:when>
	     			<c:when test="${item.workerType == 2}"> 
	     				<c:set var="fontStyle" value='style="color:red;font-weight: bold;"' />
	    				</c:when>
	     			<c:otherwise>
	     				<c:set var="fontStyle" value='' />
	    				</c:otherwise>
     			</c:choose>
     		
     		<tr id="tr_other_worker_payment_view${status.index}">
     			<td>
     				<span ${fontStyle}> ${item.paymentPlace}</span>
     			</td>
     			<td> 
     				<span ${fontStyle}> ${item.workerName}</span>
     			</td>
     			<td>
     				<span ${fontStyle}> ${item.bank}</span>
     			</td>
     			<td>
     				<span ${fontStyle}> ${item.accountNumber}</span>
     			</td>
     			<td>
     				<span ${fontStyle}> ${item.deductionAmount}</span>
     			</td>
     			<td>
     				<span ${fontStyle}> ${item.paymentRemarks}</span>
     			</td>
     			<td style="text-align:center">
      			<a href="#noloc" id="btn_insure_edit${status.index}" onclick="fnOtherWorkerPaymentEdit('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
      			<a href="#noloc" id="btn_insure_delete${status.index}" onclick="fnOtherWorkerDelete('${item.serialNo}',${item.rptPrintNo});"><img src='./resources/ls_img/btn_del_s.gif'></a>	        			
     			</td> 
     		</tr>
    		
     		<tr id="tr_other_worker_payment_update${status.index}" style="display: none;">
     			<td>
     				<input type="text" id="payment_place${status.index}" value="${item.paymentPlace}" maxlength="40">
     			</td>
     			<td> 
     				<span ${fontStyle}> ${item.workerName}</span>
     			</td>
     			<td>
     				<input type="text" id="bank${status.index}" value="${item.bank}" maxlength="40">
     			</td>
     			<td>
     				<input type="text" id="account_number${status.index}" value="${item.accountNumber}" maxlength="40">
     			</td>
     			<td>
     				<span ${fontStyle}> ${item.deductionAmount}</span>
     			</td>
     			<td>
     				<input type="text" id="payment_remarks${status.index}" value="${item.paymentRemarks}" maxlength="40">
     			</td>
     			<td style="text-align:center">
     				<a href="#noloc" id="btn_insure_save" onclick="fnOtherWorkerPaymentSave('${item.serialNo}',${item.rptPrintNo},'${status.index}');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
     			</td>
     		</tr>
    		</c:forEach>
    </table>