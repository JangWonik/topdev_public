<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
       			<table>
	               	<colgroup>
	                    <col width="20%" />
	                    <col width="16%" />
	                    <col width="20%" />
	                    <col width="15%" />
	                    <col width="20%" />
	                    <col width="9%" />
	                </colgroup>
					<tr id="meritz_claim_view">
						<th>청구 내용</th>
						<td colspan="4" style="padding:10px;">
							${fn:replace(fn:replace(rptBasic.claimDtl2 , CRLF , '<br>'), ' ', '&nbsp;')}
						</td>
						<td>
							<a id="btn_claim_edit" href="#noloc" onclick="fnClaimEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
						</td>
					</tr>
					
					<tr id="meritz_claim_edit" style="display: none;">
						<th>청구 내용</th>
						<td colspan="4">
							<select id="select_claim_code" style="margin-bottom: 5px;" onchange="fnClaimCodeChange(this);" >
                            	<option value="">직접입력</option>
	                            <c:forEach var="item" items="${claimCodeList}" varStatus="status">
	                                <option value="${item.colVal}">${item.colVal}</option>
	                            </c:forEach>
                        	</select>
                        	<textarea id="claim_dtl" style="height: 150px;">${fn:replace(fn:replace(rptBasic.claimDtl2 , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
						</td>
						
						<td>
                        	<a id="btn_claim_save" href="#noloc" onclick="fnClaimSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        	<a id="btn_claim_close" href="#noloc" onclick="fnClaimClose();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
						</td>
					</tr>

					<tr id="meritz_complaint_avoid_view">
						<th>민원예방활동</th>
						<td colspan="4" style="padding:10px;">
							${fn:replace(fn:replace(rptBasic.complaintAvoidActivity2 , CRLF , '<br>'), ' ', '&nbsp;')}
						</td>
						<td>
							<a id="btn_complaint_avoid_edit" href="#noloc" onclick="fnComplaintAvoidEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
						</td>
					</tr>
					
					<tr id="meritz_complaint_avoid_edit" style="display: none;">
						<th>민원예방활동</th>
						<td colspan="4">
                        	<textarea id="complaint_avoid_activity" style="height: 150px;">${fn:replace(fn:replace(rptBasic.complaintAvoidActivity2 , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
						</td>
						
						<td>
                        	<a id="btn_complaint_avoid_save" href="#noloc" onclick="fnComplaintAvoidSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        	<a id="btn_complaint_avoid_close" href="#noloc" onclick="fnComplaintAvoidClose();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
						</td>
					</tr>

					<tr class="meritz_result_view">
						<th rowspan="2">조사자의견<br/>및<br/>조사결과</th>
						<td colspan="4" style="padding:10px;">
							${fn:replace(fn:replace(rptBasic.inspectResult2 , CRLF , '<br>'), ' ', '&nbsp;')}
						</td>
						<td rowspan="2">
							<a id="btn_result_edit" href="#noloc" onclick="fnResultEdit();"><img src="./resources/ls_img/btn_edite.gif"/></a>
						</td>
					</tr>
					<tr class="meritz_result_view">
						<th>
							계약 유지
						</th>
						<td>
							${rptBasic.contractKeepYn2}
						</td>
						<th>
							민원 여부
						</th>
						<td>
							${rptBasic.minwonDtl2}
						</td>
					</tr>
					
										
					<tr class="meritz_result_edit" style="display: none;">
						<th rowspan="2">조사자의견<br/>및<br/>조사결과</th>
						<td colspan="4">
							<select id="select_result_code" style="margin-bottom: 5px;" onchange="fnResultCodeChange(this);" >
                            	<option value="">직접입력</option>
	                            <c:forEach var="item" items="${resultCodeList}" varStatus="status">
	                                <option value="${item.colVal}">${item.colVal}</option>
	                            </c:forEach>
                        	</select>
                        	<textarea id="inspect_result" style="height: 150px;">${fn:replace(fn:replace(rptBasic.inspectResult2 , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
						</td>
						<td rowspan="2">
                        	<a id="btn_result_save" href="#noloc" onclick="fnResultSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        	<a id="btn_result_close" href="#noloc" onclick="fnResultClose();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
						</td>
					</tr>
					<tr class="meritz_result_edit" style="display: none;">
						<th>
							계약 유지
						</th>
						<td>
							<input type="text" id="contract_keep_yn" value="${rptBasic.contractKeepYn2}" />
						</td>
						<th>
							민원 여부
						</th>
						<td>
							<input type="text" id="minwon_dtl" value="${rptBasic.minwonDtl2}" />
						</td>
					</tr>					
       			</table>