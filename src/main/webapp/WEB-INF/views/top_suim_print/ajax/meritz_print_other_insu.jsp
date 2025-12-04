<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
				<table>
       				<colgroup>
       					<col width="15%" />
       					<col width="30%" />
       					<col width="16%" />
						<col width="30%" />
       					<col width="9%" />
       				</colgroup>
       				<thead>
       					<tr>
	       					<th>보험회사</th>
	       					<th>담보내용</th>
	       					<th>보험기간</th>
	       					<th>청구내용 및 결과</th>
	       					<th>비고</th>
       					</tr>
       				</thead>        
       				<tbody> 
						<tr id="other_insu_add" style="display:none;border:2px solid #8a8a8a;"> 
							<td>  
								<input type="text" id="other_insu_com_add"/>
							</td>
							<td>  
								<textarea id="other_insu_mortgage_add" rows="5"></textarea>
							</td>
							<td>  
								<textarea id="other_insu_period_add" rows="5"></textarea>
							</td>
							<td>  
								<textarea id="other_insu_etc_memo_add" rows="5"></textarea>
							</td>				
							<td>
                      			<a id="btn_other_insu_save_add" href="#noloc" onclick="fnOtherInsuSave('add','C');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        		<a id="btn_other_insu_close_add" href="#noloc" onclick="fnOtherInsuClose();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
							</td>																	
						</tr>
						
						<c:forEach items="${rptOtherInsu}" var="oiList" varStatus="oiStatus">
							<tr id="other_insu_view_${oiStatus.index}">
								<td style="text-align: center;">
									${oiList.otherInsuCom}
								</td>	
								<td>
									${fn:replace(fn:replace(oiList.otherInsuMortgage , CRLF , '<br>'), ' ', '&nbsp;')}
								</td>
								<td>
									${fn:replace(fn:replace(oiList.otherInsuPeriod , CRLF , '<br>'), ' ', '&nbsp;')}
								</td>
								<td>
									${fn:replace(fn:replace(oiList.otherInsuEtcMemo , CRLF , '<br>'), ' ', '&nbsp;')}								
								</td>
								<td>
									<a id="btn_other_insu_edit_${rcStatus.index}" href="#noloc" onclick="fnOtherInsuEdit(${oiStatus.index});"><img src="./resources/ls_img/btn_edite.gif"/></a>
								</td>
							</tr>
							
							<tr id="other_insu_edit_${oiStatus.index}" style="display: none;">
								<td style="text-align: center;">
									<input type="text" id="other_insu_com_${oiStatus.index}" value="${oiList.otherInsuCom}"/>
								</td>	
								<td>
									<textarea id="other_insu_mortgage_${oiStatus.index}" rows="5">${fn:replace(fn:replace(oiList.otherInsuMortgage , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
								</td>
								<td>
									<textarea id="other_insu_period_${oiStatus.index}" rows="5">${fn:replace(fn:replace(oiList.otherInsuPeriod , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
								</td>	
								<td>
									<textarea id="other_insu_etc_memo_${oiStatus.index}" rows="5">${fn:replace(fn:replace(oiList.otherInsuEtcMemo , '<br>', CRLF), ' ', '&nbsp;')}</textarea>
								</td>
								<td>
	       							<input type="hidden" id="oi_serial_no_${oiStatus.index}" value="${oiList.serialNo}" />
	                       			<a id="btn_other_insu_save_${oiStatus.index}" href="#noloc" onclick="fnOtherInsuSave(${oiStatus.index},'U');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
	                       			<a id="btn_other_insu_del_${oiStatus.index}" href="#noloc" onclick="fnOtherInsuDelete(${oiStatus.index},'D');"><img src='./resources/ls_img/btn_del.gif' style="margin-top: 5px;"></a>
	                        		<a id="btn_other_insu_close_${oiStatus.index}" href="#noloc" onclick="fnOtherInsuCancel(${oiStatus.index});"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
								</td>							
						</c:forEach>
       				</tbody>
       			</table> 