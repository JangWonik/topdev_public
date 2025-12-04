<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
	      	<div id="div_contract_detail_view">        
		       	<div class="display-table" style="margin-top: 50px;">
		            <div class="display-cell">
		                <p class="subtitle">1. 공제계약사항</p>
		            </div>
			        <div class="display-cell text-right">
		               	<a id="btn_contract_edit" href="#noloc" onclick="fnContractEdit();"><img src='./resources/ne_img/btn_edite.gif'></a>
		           	</div>
		        </div>
	        	<table>
	        		<colgroup>
	        			<col width="20%">
	        			<col width="50%">
	        			<col width="15%">
	        			<col width="15%">
	        		</colgroup>	
	        		<tr> 
	        			<th>항     목</th>
	        			<th>계약사항</th>
	        			<th>계약사항검토</th>
	        			<th>비     고</th>
	        		</tr>
	     			<tr>
		     			<th>공제종목</th>
		     			<td>${reportBscInfo.insuranceNm}</td>
		     			<td>일치</td>
		     			<c:choose>
		     			<c:when test="${contractDetail.deductionRemarks == ''}"><td>-</td></c:when>
		     			<c:otherwise><td>${contractDetail.deductionRemarks}</td></c:otherwise>
		     			</c:choose>	
		     		</tr>	
	     			<tr>
		     			<th>증권번호</th>
		     			<td>${reportBscInfo.policyNo}</td>
		     			<td>일치</td>
	     				<c:choose>
		     			<c:when test="${contractDetail.stockRemarks == ''}"><td>-</td></c:when>
		     			<c:otherwise><td>${contractDetail.stockRemarks}</td></c:otherwise>
		     			</c:choose>		     			
		     		</tr>		     		
	     			<tr>
		     			<th>계약자</th>
		     			<td>${reportBscInfo.policyholderNm}</td>
		     			<td>일치</td>
	     				<c:choose>
		     			<c:when test="${contractDetail.contractorRemarks == ''}"><td>-</td></c:when>
		     			<c:otherwise><td>${contractDetail.contractorRemarks}</td></c:otherwise>
		     			</c:choose>		     			
		     		</tr>
	     			<tr>
		     			<th>피공제자</th>
		     			<td>${reportBscInfo.beneficiaryNm}</td>
		     			<td>일치</td>
	     				<c:choose>
		     			<c:when test="${contractDetail.workerRemarks == ''}"><td>-</td></c:when>
		     			<c:otherwise><td>${contractDetail.workerRemarks}</td></c:otherwise>
		     			</c:choose>			     			
		     		</tr>
	     			<tr>
		     			<th>주       소</th>
		     			<td>${contractDetail.address}</td>
		     			<td>일치</td>
	     				<c:choose>
		     			<c:when test="${contractDetail.addressRemarks == ''}"><td>-</td></c:when>
		     			<c:otherwise><td>${contractDetail.addressRemarks}</td></c:otherwise>
		     			</c:choose>			     			
		     		</tr>		     		
	     			<tr>
		     			<th>공제기간</th>
		     			<td>${contractDetail.deductionStartDate} ~ ${contractDetail.deductionEndDate}</td>
		     			<td>공제기간 내</td>
	     				<c:choose>
		     			<c:when test="${contractDetail.deductionPeriodRemarks == ''}"><td>-</td></c:when>
		     			<c:otherwise><td>${contractDetail.deductionPeriodRemarks}</td></c:otherwise>
		     			</c:choose>		     			
		     		</tr>		     		
	     			<tr>
		     			<th>보상한도</th>
		     			<td>법정보상 한도</td>
		     			<td>일치</td>
	     				<c:choose>
		     			<c:when test="${contractDetail.compensationLimitRemarks == ''}"><td>-</td></c:when>
		     			<c:otherwise><td>${contractDetail.compensationLimitRemarks}</td></c:otherwise>
		     			</c:choose>			     			
		     		</tr>		     		
	     			<tr>
		     			<th>공제금액</th>
		     			<td>-</td>
		     			<td>일치</td>
	     				<c:choose>
		     			<c:when test="${contractDetail.deductionAmountRemarks == ''}"><td>-</td></c:when>
		     			<c:otherwise><td>${contractDetail.deductionAmountRemarks}</td></c:otherwise>
		     			</c:choose>			     			
		     		</tr>		     		
	     			<tr>
		     			<th>적용약관</th>
		     			<td>해외근로자재해공제 보통 약관 <br />비업무상재해 확장 추가특별약관</td>
		     			<td>일치</td>
	     				<c:choose>
		     			<c:when test="${contractDetail.termsRemarks == ''}"><td>-</td></c:when>
		     			<c:otherwise><td>${contractDetail.termsRemarks}</td></c:otherwise>
		     			</c:choose>		     			
		     		</tr>		     				     					     		
	       			</table>
				</div>
				
				<div id="div_contract_detail_edit"  style="display: none;">  
					<div class="display-table" style="margin-top: 50px;">
			            <div class="display-cell">
			                <p class="subtitle">1. 공제계약사항</p>
			            </div>
				        <div class="display-cell text-right">
			               	<a id="btn_contract_save" href="#noloc" onclick="fnContractSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
			               	<a id="btn_contract_close" href="#noloc" onclick="fnContractClose();"><img src='./resources/ne_img/btn/btn_close.gif'></a>
			           	</div>
		        	</div>           
		        	<table>
		        		<colgroup>
		        			<col width="20%">
		        			<col width="50%">
		        			<col width="15%">
		        			<col width="15%">
		        		</colgroup>	
		        		<tr> 
		        			<th>항     목</th>
		        			<th>계약사항</th>
		        			<th>계약사항검토</th>
		        			<th>비     고</th>
		        		</tr>
		     			<tr>
			     			<th>공제종목</th>
			     			<td>${reportBscInfo.insuranceNm}</td>
			     			<td>일치</td>
			     			<td><input type="text" id="deduction_remarks" value="${contractDetail.deductionRemarks}" maxlength="40"></td>		     			
			     		</tr>	
		     			<tr>
			     			<th>증권번호</th>
			     			<td>${reportBscInfo.policyNo}</td>
			     			<td>일치</td>
			     			<td><input type="text" id="stock_remarks" value="${contractDetail.stockRemarks}" maxlength="40"></td>		     			
			     		</tr>		     		
		     			<tr>
			     			<th>계약자</th>
			     			<td>${reportBscInfo.policyholderNm}</td>
			     			<td>일치</td>
			     			<td><input type="text" id="contractor_remarks"  value="${contractDetail.contractorRemarks}" maxlength="40"></td>		     			
			     		</tr>
		     			<tr>
			     			<th>피공제자</th>
			     			<td>${reportBscInfo.beneficiaryNm}</td>
			     			<td>일치</td>
			     			<td><input type="text" id="worker_remarks"  value="${contractDetail.workerRemarks}" maxlength="40"></td>		     			
			     		</tr>
		     			<tr>
			     			<th>주       소</th>
			     			<td>
			     				<input type="text" id="address" value="${contractDetail.address}">
			     			</td>
			     			<td>일치</td>
			     			<td><input type="text" id="address_remarks"  value="${contractDetail.addressRemarks}" maxlength="40"></td>		     			
			     		</tr>		     		
		     			<tr>
			     			<th>공제기간</th>
			     			<td style="text-align: center">
	                        	<input type="text" id="deduction_start_date" class="calendar" name="stDate" value="${contractDetail.deductionStartDate}" style="width: 55%;" value="${contractDetail.deductionStartDate}" maxlength="10"/> ~ <br/>
	                        	<input type="text" id="deduction_end_date" class="calendar" name="edDate" value="${contractDetail.deductionEndDate}" style="width: 55%;" value="${contractDetail.deductionEndDate}" maxlength="10"/><br/>
	                    	</td>
			     			<td>공제기간 내</td>
			     			<td><input type="text" id="deduction_period_remarks" value="${contractDetail.deductionPeriodRemarks}" maxlength="40"></td>		     			
			     		</tr>		     		
		     			<tr>
			     			<th>보상한도</th>
			     			<td>법정보상 한도</td>
			     			<td>일치</td>
			     			<td><input type="text" id="compensation_limit_remarks" value="${contractDetail.compensationLimitRemarks}" maxlength="40"></td>		     			
			     		</tr>		     		
		     			<tr>
			     			<th>공제금액</th>
			     			<td>-</td>
			     			<td>일치</td>
			     			<td><input type="text" id="deduction_amount_remarks" value="${contractDetail.deductionAmountRemarks}" maxlength="40"></td>		     			
			     		</tr>		     		
		     			<tr>
			     			<th>적용약관</th>
			     			<td>해외근로자재해공제 보통 약관 <br />비업무상재해 확장 추가특별약관</td>
			     			<td>일치</td>
			     			<td><input type="text" id="terms_remarks" value="${contractDetail.termsRemarks}" maxlength="40"></td>		     			
			     		</tr>		     				     					     		
		       			</table>
				</div>
