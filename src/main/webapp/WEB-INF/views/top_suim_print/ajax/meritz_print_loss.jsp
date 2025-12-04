<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
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