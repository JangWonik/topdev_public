<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>
	<colgroup>
		<col width="10%">
		<col width="10%">
		<col width="12%">
		<col width="10%">
		<col width="14%">
		<col width="11%">
		<col width="11%">
		<col width="12%">
		<col width="9%">
	</colgroup>	
	<tr>
		<th>재해근로자</th>
		<th>구분</th>
		<th>주민등록번호</th>
		<th>현장명</th>
		<th>손해액</th>
		<th>적용환율</th>
		<th>청구공제금</th>
		<th>비고</th>
		<th>-</th>
		
		<tr id="tr_other_worker_add" style="display:none;">
	  			<td>
	  				<input type="text" id="worker_name" value="" maxlength="40">
	  			</td>
	  			<td>
	  				<select id="worker_type" value="" maxlength="40" onchange="fnChgWorkerType(this,'');">
	  					<option value="">선택</option>
							<option value="1">부책</option>
							<option value="2">면책</option>
							<option value="3">보완</option>
							<option value="4">기타</option>
	  				</select>
	  			</td>
				<td>
	  				<input type="text" id="ssn" value="" maxlength="40">
	  			</td>
	  			<td>
	  				<input type="text" id="country" value="" maxlength="40">
	  			</td>
	  			 <td>
	  				<input type="text" id="damage_amount" value="" maxlength="80">
	  			</td>
	  			 <td>
	  				<input type="text" id="exchange_rate" value="" maxlength="40">
	  			</td>
	  			<td>
	  				<input type="text" id="deduction_amount" value="" maxlength="40">
	  			</td>
	  			 <td>
	 			 		<span id="deduction_remarks_span"></span>
	  				<input type="text" id="deduction_remarks" value="" maxlength="40">
	  			</td>
	  			<td style="text-align:center">
					<a href="#noloc" id="btn_insure_save" onclick="fnOtherWorkerSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
					<a href="#noloc" id="btn_insure_cancel" onclick="fnOtherWorkerCancel();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
				</td>	        		
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
	        		
	        		<tr id="tr_other_worker_view${status.index}" >
	        			<td>
	        				<span ${fontStyle}> ${item.workerName}</span>
        				</td>
        				
	        			<td>
	        				<span ${fontStyle}> 
	        					<c:choose>
	        						<c:when test="${item.workerType == 1}">부책</c:when>
	        						<c:when test="${item.workerType == 2}">면책</c:when>
	        						<c:when test="${item.workerType == 3}">보완</c:when>
	        						<c:when test="${item.workerType == 4}">기타</c:when>
	        					</c:choose>
        					</span>
        				</td>
        				
	        			<td>
	        				<span ${fontStyle}> ${item.ssn}</span>
        				</td>
        				
	        			<td>
	        				<span ${fontStyle}> ${item.country}</span>
        				</td>
        				
	        			<td>
	        				<span ${fontStyle}> ${item.damageAmount}</span>
        				</td>
        				
			        	<td>
			        		<span ${fontStyle}> ${item.exchangeRate}</span>
		        		</td>
		        		
	        			<td style="text-align: right"  class="money">
        					<span ${fontStyle}> ${item.deductionAmount}</span>원
       					</td>
       					
		        		<td>
		        			<span ${fontStyle}> ${item.deductionRemarks}</span>
	        			</td>
	        			
		        		<td style="text-align:center">
		        			<a href="#noloc" id="btn_insure_edit${status.index}" onclick="fnOtherWorkerEdit(${status.index});"><img src='./resources/ls_img/btn_edit_s.gif'></a>
		        			<a href="#noloc" id="btn_insure_delete${status.index}" onclick="fnOtherWorkerDelete('${item.serialNo}',${item.rptPrintNo});"><img src='./resources/ls_img/btn_del_s.gif'></a>
		        		</td>
	        		</tr>
	        		
        		 	<tr id="tr_other_worker_edit${status.index}" style="display: none;">
        				<td>
        					<input type="text" id="worker_name${status.index}" value="${item.workerName}" >
        					<input type="hidden" id="serial_no${status.index}" value="${item.serialNo}"/>
        				</td>
        				<td>
	        				<select id="worker_type${status.index}" onchange="fnChgWorkerType(this,${status.index});">
	        					<option value="" <c:if test="${item.workerType == ''}">selected="selected"</c:if>>선택</option>
								<option value="1" <c:if test="${item.workerType == 1}">selected="selected"</c:if>>부책</option>
								<option value="2" <c:if test="${item.workerType == 2}">selected="selected"</c:if>>면책</option>
								<option value="3" <c:if test="${item.workerType == 3}">selected="selected"</c:if>>보완</option>
								<option value="4" <c:if test="${item.workerType == 4}">selected="selected"</c:if>>기타</option>
	        				</select>        				
        				</td>
        				<td>
        					<input type="text" id="ssn${status.index}" value="${item.ssn}">
        				</td>
        				<td>
        					<input type="text" id="country${status.index}" value="${item.country}">
        				</td> 
        				<td>
        					<input type="text" id="damage_amount${status.index}" value="${item.damageAmount}">
        				</td>
        				<td>
        					<input type="text" id="exchange_rate${status.index}" value="${item.exchangeRate}">
        				</td>  
        				<td>
        					<input type="text" id="deduction_amount${status.index}" value="${item.deductionAmount}">
        				</td>        				  
        				<td>
        					<c:choose>
        						<c:when test="${item.workerType == 1}">
        							<span id="deduction_remarks_span${status.index}">전신환매도율</span>
        							<input type="hidden" id="deduction_remarks${status.index}" value="전신환매도율 " >
       							</c:when>
        						<c:otherwise>
        							<span id="deduction_remarks_span${status.index}"></span>
        							<input type="text" id="deduction_remarks${status.index}" value="${item.deductionRemarks}" >
        						</c:otherwise>
        					</c:choose>
        				</td>   
	        			<td style="text-align:center">
	        				<a href="#noloc" id="btn_insure_edit${status.index}" onclick="fnOtherWorkerUpdate('${item.serialNo}',${item.rptPrintNo},'${status.index}');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
	        				<a href="#noloc" id="btn_insure_delete${status.index}" onclick="fnOtherWorkerClose('${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif'></a>
	        			</td>        				     				        				    				        				       				
        			</tr>
	        	</c:forEach>
</table>	        	
        	 <p style="padding: 0px 5px;">
				※상기 환율은 ~ 일자 외환은행 국가별 최초고시 환율을 적용함
			</p>
			      
<!--          <div class="display-table" style="margin-top: 50px;"> -->
<!--             <div class="display-cell"> -->
<!--                 <p class="subtitle">2. 지급공제금 지급처</p> -->
<!--             </div> -->
<!--         </div> -->
        <div id="div_other_worker_payment">               
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
	        		<c:if test="${item.workerType != 2 }">
		     		<tr id="tr_other_worker_payment_view${status.index}">
		     			<td>${item.paymentPlace}</td>
		     			<td>${item.workerName}</td>
		     			<td>${item.bank}</td>
		     			<td>${item.accountNumber}</td>
		     			<td style="text-align: right"  class="money">${item.deductionAmount}원</td>
		     			<td>${item.paymentRemarks}</td>
		     			<td style="text-align:center">
		      			<a href="#noloc" id="btn_insure_edit${status.index}" onclick="fnOtherWorkerPaymentEdit('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
		      			<a href="#noloc" id="btn_insure_delete${status.index}" onclick="fnOtherWorkerDelete('${item.serialNo}',${item.rptPrintNo});"><img src='./resources/ls_img/btn_del_s.gif'></a>	        			
		     			</td> 
		     		</tr>
        		
		     		<tr id="tr_other_worker_payment_update${status.index}" style="display: none;">
		     			<td>
		     				<input type="text" id="payment_place${status.index}" value="${item.paymentPlace}" maxlength="40">
		     			</td>
		     			<td>${item.workerName}</td>
		     			<td>
		     				<input type="text" id="bank${status.index}" value="${item.bank}" maxlength="40">
		     			</td>
		     			<td>
		     				<input type="text" id="account_number${status.index}" value="${item.accountNumber}" maxlength="40">
		     			</td>
		     			<td>${item.deductionAmount}</td>
		     			<td>
		     				<input type="text" id="payment_remarks${status.index}" value="${item.paymentRemarks}" maxlength="40">
		     			</td>
		     			<td style="text-align:center">
		     				<a href="#noloc" id="btn_insure_save" onclick="fnOtherWorkerPaymentSave('${item.serialNo}',${item.rptPrintNo},'${status.index}');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
		     			</td>
		     		</tr>
		     		</c:if>
        			</c:forEach>
       			 </table>
       
				</div>  	
       
