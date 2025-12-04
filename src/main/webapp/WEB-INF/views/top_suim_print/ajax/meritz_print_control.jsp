<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
       			<table>
       				<colgroup>
       					<col width="16%" />
       					<col width="19%" />
       					<col width="19%" />
       					<col width="19%" />
       					<col width="18%" />
       					<col width="9%" />
       				</colgroup>
       				<thead>
       					<tr>
	       					<th>진행일시</th>
	       					<th>주요내용</th>
	       					<th>면담자</th>
	       					<th>관계</th>
	       					<th>접촉방법</th>
	       					<th>비고</th>
       					</tr>
       				</thead>        
       				<tbody> 
						<tr id="meritz_ctrl_add" style="display:none;border:2px solid #8a8a8a;"> 
							<td>  
								<input type="text" class="calendar" id="control_date_add" />
							</td>
							
							<td>
		                        <select id="select_control_memo_add" style="margin-bottom: 5px;" onchange="fnControlChange(this,'memo','add');" >
		                        	<option value="">--선택--</option>
		                            <c:forEach  var="item" items="${reportMemoCodeList}" varStatus="status">
		                                <option value="${item.colVal}">${item.colVal}</option>
		                            </c:forEach>
		                            <option value="999">직접입력</option>
		                        </select>  
								<input type="text" id="control_memo_add" style="display: none;" />
							</td> 
							
							<td>
		                        <select id="select_control_who_add" style="margin-bottom: 5px;" onchange="fnControlChange(this,'who','add');" >
		                        	<option value="">--선택--</option>
		                            <c:forEach  var="item" items="${reportWorkCodeList}" varStatus="status">
		                                <option value="${item}">${item}</option>
		                            </c:forEach>
									<option value="999">직접입력</option>
		                        </select>  							  
								<input type="text" id="control_who_add" style="display: none;"/>
							</td>
							
							<td>  
		                        <select id="select_control_relation_add" style="margin-bottom: 5px;" onchange="fnControlChange(this,'relation','add');" >
		                        	<option value="">--선택--</option>
		                            <c:forEach  var="item" items="${reportRelationCodeList}" varStatus="status">
		                                <option value="${item}">${item}</option>
		                            </c:forEach>
		                            <option value="999">직접입력</option>
		                        </select>  							  
								<input type="text" id="control_relation_add" style="display: none;"/>
							</td>			
							
							<td>  
		                        <select id="select_control_Contact_add" style="margin-bottom: 5px;" onchange="fnControlChange(this,'contact','add');" >
		                        	<option value="">--선택--</option>
		                            <c:forEach  var="item" items="${reportContactCodeList}" varStatus="status">
		                                <option value="${item}">${item}</option>
		                            </c:forEach>
									<option value="999">직접입력</option>
		                        </select>  								
								<input type="text" id="control_contact_add" style="display: none;"/>
							</td>			
								
							<td>
                      			<a id="btn_other_insu_save_add" href="#noloc" onclick="fnCtrlSave('C','add');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        		<a id="btn_other_insu_close_add" href="#noloc" onclick="fnCtrlClose();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
							</td>																	
						</tr>
						<c:forEach items="${rptControl}" var="rcList" varStatus="rcStatus">
							<tr id="meritz_ctrl_view_${rcStatus.index}">
								<td style="text-align: center;">
									${rcList.controlDate}
								</td>	
								<td style="text-align: center;">
									${rcList.controlMemo}
								</td>
								<td style="text-align: center;">
									${rcList.controlWho}
								</td>
								<td style="text-align: center;">
									${rcList.controlRelation}								
								</td>
								<td style="text-align: center;">
									${rcList.controlContact}								
								</td>
								<td>
									<a id="btn_merit_ctrl_edit_${rcStatus.index}" href="#noloc" onclick="fnCtrlEdit(${rcStatus.index});"><img src="./resources/ls_img/btn_edite.gif"/></a>
								</td>
							</tr>
							
							<tr id="meritz_ctrl_edit_${rcStatus.index}" style="display: none;">
								<td>  
									<input type="text" class="calendar" id="control_date_${rcStatus.index}" value="${rcList.controlDate}"/>
								</td>
								
								<td>
			                        <select id="select_control_memo_${rcStatus.index}" style="margin-bottom: 5px;" onchange="fnControlChange(this,'memo','${rcStatus.index}');" >
			                        	<option value="">--선택--</option>
			                        	<c:set var="ctrl_memo_selected" value="0"/>
			                            <c:forEach  var="item" items="${reportMemoCodeList}" varStatus="status">
			                            	<c:if test="${item.colVal == rcList.controlMemo}">
				                                <c:set var="ctrl_memo_selected" value="1"/>
				                            </c:if>
			                                <option value="${item.colVal}" <c:if test="${item.colVal == rcList.controlMemo}">selected</c:if> >${item.colVal}</option>
			                            </c:forEach>
			                            <option value="999" <c:if test="${ctrl_memo_selected == 0}">selected</c:if> >직접입력</option>
			                        </select>  
									<input type="text" id="control_memo_${rcStatus.index}"  <c:if test="${ctrl_memo_selected == 1}">style="display: none;"</c:if> value="${rcList.controlMemo}"/>
								</td> 
								
								<td>
			                        <select id="select_control_who_${rcStatus.index}" style="margin-bottom: 5px;" onchange="fnControlChange(this,'who','${rcStatus.index}');" >
			                        	<option value="">--선택--</option>
			                        	<c:set var="ctrl_who_selected" value="0"/>
			                            <c:forEach  var="item" items="${reportWorkCodeList}" varStatus="status">
			                            	<c:if test="${item == rcList.controlWho}">
				                                <c:set var="ctrl_who_selected" value="1"/>
				                            </c:if>
			                                <option value="${item}" <c:if test="${item == rcList.controlWho}">selected</c:if> >${item}</option>
			                            </c:forEach>
										<option value="999" <c:if test="${ctrl_who_selected == 0}">selected</c:if> >직접입력</option>
			                        </select>  		
									<input type="text" id="control_who_${rcStatus.index}" <c:if test="${ctrl_who_selected == 1}">style="display: none;"</c:if> value="${rcList.controlWho}"/>
								</td>
								
								<td>  
			                        <select id="select_control_relation_${rcStatus.index}" style="margin-bottom: 5px;" onchange="fnControlChange(this,'relation','${rcStatus.index}');" >
			                        	<option value="">--선택--</option>
			                        	<c:set var="ctrl_relation_selected" value="0"/>
			                            <c:forEach  var="item" items="${reportRelationCodeList}" varStatus="status">
			                            	<c:if test="${item == rcList.controlRelation}">
				                                <c:set var="ctrl_relation_selected" value="1"/>
				                            </c:if>
			                                <option value="${item}" <c:if test="${item == rcList.controlRelation}">selected</c:if> >${item}</option>
			                            </c:forEach>
			                            <option value="999" <c:if test="${ctrl_relation_selected == 0}">selected</c:if> >직접입력</option>
			                        </select>  							  
			                        
									<input type="text" id="control_relation_${rcStatus.index}" <c:if test="${ctrl_relation_selected == 1}">style="display: none;"</c:if> value="${rcList.controlRelation}"/>
								</td>			
								
								<td>  
			                        <select id="select_control_Contact_${rcStatus.index}" style="margin-bottom: 5px;" onchange="fnControlChange(this,'contact','${rcStatus.index}');" >
			                        	<option value="">--선택--</option>
			                        	<c:set var="ctrl_contact_selected" value="0"/>
			                            <c:forEach  var="item" items="${reportContactCodeList}" varStatus="status">
			                            	<c:if test="${item == rcList.controlContact}">
				                                <c:set var="ctrl_contact_selected" value="1"/>
				                            </c:if>			                            
			                                <option value="${item}" <c:if test="${item == rcList.controlContact}">selected</c:if> >${item}</option>
			                            </c:forEach>
										<option value="999" <c:if test="${ctrl_contact_selected == 0}">selected</c:if> >직접입력</option>
			                        </select>  			
									<input type="text" id="control_contact_${rcStatus.index}" <c:if test="${ctrl_contact_selected == 1}">style="display: none;"</c:if> value="${rcList.controlContact}"/>
								</td>		
								
								<td>
	       							<input type="hidden" id="rc_serial_no_${rcStatus.index}" value="${rcList.serialNo}" />
	                       			<a id="btn_meritz_ctrl_save_${rcStatus.index}" href="#noloc" onclick="fnCtrlSave('U',${rcStatus.index});"><img src='./resources/ne_img/btn/btn_save.gif'></a>
	                       			<a id="btn_meritz_ctrl_del_${rcStatus.index}" href="#noloc" onclick="fnCtrlDelete('D',${rcStatus.index});"><img src='./resources/ls_img/btn_del.gif' style="margin-top: 5px;"></a>
	                        		<a id="btn_meritz_ctrl_close_${rcStatus.index}" href="#noloc" onclick="fnCtrlCancel(${rcStatus.index});"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
								</td>							
						</c:forEach>
					</tbody>
				</table>