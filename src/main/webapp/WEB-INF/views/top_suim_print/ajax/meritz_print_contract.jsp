<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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