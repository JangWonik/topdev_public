<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
            <table id="issue_send_tbl" style="border: 2px solid;">
                <colgroup>
                    <col width="15%">
                    <col width="15%">
                    <col width="20%">                    
                    <col width="15%">
                    <col width="15%">
                    <col width="15%">
                </colgroup>
                
                <tr>
                    <th>구분</th>
                    <th>교부 동의 여부</th>
                    <th>연락처</th>
                    <th>교부 발송 여부</th>
                    <th>비 동의일자<br/>/ <span style="color:blue">발송일시</span></th>
                    <th>-</th>
                </tr>
                
                <tr id="tr_issue_send_add" style="display: none">
                    <td>
                    	<select id="send_target_add" >
                    		<option value="1">계약자</option>
                    		<option value="5">피보험자</option>
                    		<option value="10">보험청구권자</option>
                    	</select>
                    </td>
                    
                     <td style="text-align: center">	
                     	<input type="radio" id="privacy_agree1_add" name="privacy_agree_add" value="1" onchange="fnPrivacyAgreeChk();"/><label for="privacy_agree1_add">동의</label>
                     	<input type="radio" id="privacy_agree2_add" name="privacy_agree_add" value="2" onchange="fnPrivacyAgreeChk();"/><label for="privacy_agree2_add">비 동의</label>                	
                    </td> 
                    
                    <td style="text-align: center">                    	
                    	<div id="mobile_display">
                    		<input type="text" class="tel" id="tel1_add"  maxlength="3" style="width: 25% !important;" disabled="disabled"/>-
	                    	<input type="text" class="tel" id="tel2_add"  maxlength="4" style="width: 30% !important;" disabled="disabled"/>-
	                    	<input type="text" class="tel" id="tel3_add"  maxlength="4" style="width: 30% !important;" disabled="disabled"/>
                    	</div>
                    	<div id="disagree_display">
                    		<input class="calendar" type="text" id="disagree_date" value="${sToday}" style="width: 70%;"/>
                    	</div>
                    	<div id="none_display" style="text-align: center">
                    		-
                    	</div>                        
                    </td>
                    <td>
                    	<c:choose>
                    		<c:when test="${item.privacyAgree == 2}">
                    			${ item.disagreeDate }
                    		</c:when>
                    		<c:otherwise>
                    			-
                    		</c:otherwise>	                    		
                    	</c:choose>
                    	<br/>/
                    	<c:choose>
                    		<c:when test="${item.privacyAgree == 1}">
                    			${ item.sendDate }
                    		</c:when>
                    		<c:otherwise>
                    			-
                    		</c:otherwise>
                    	</c:choose>	                    	
                    </td>
                    <td style="text-align: center">
						- 
                    </td>                    
                    
                    <td style="text-align: center">
                        <a href="#noloc" onclick="fnIssueSendSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                        <a href="#noloc" onclick="fnIssueSendCancel();"><img src='./resources/ne_img/btn/btn_close.gif'></a>
                    </td>
                </tr>
                                
                <c:forEach items="${rptIssueSendList}" var="item" varStatus="status">
	                <tr>
	                    <td>
	                    	<select id="send_target_${status.index}" >
	                    		<option <c:if test="${item.sendTarget eq '1'}">selected</c:if> value="1">계약자</option>
	                    		<option <c:if test="${item.sendTarget eq '5'}">selected</c:if> value="5">피보험자</option>
	                    		<option <c:if test="${item.sendTarget eq '10'}">selected</c:if> value="10">보험청구권자</option>
	                    	</select>
	                    </td>	                	
	                    <td style="text-align: center">	
<%-- 							<input type="radio" id="privacy_agree_add1" name="privacy_agree_add" value="1" <c:if test="${item.privacyAgree == 1}">checked</c:if> /><label for="privacy_agree_add1">동의</label>
							<input type="radio" id="privacy_agree_add2" name="privacy_agree_add" value="2" <c:if test="${item.privacyAgree == 2}">checked</c:if> /><label for="privacy_agree_add2">비 동의</label> --%>
                    		<input type="radio" id="privacy_agree1_add" name="privacy_agree_${status.index}" value="${item.privacyAgree}" <c:if test="${item.privacyAgree == 1}">checked</c:if> disabled="disabled"/>동의
                    		<input type="radio" id="privacy_agree2_add" name="privacy_agree_${status.index}" value="${item.privacyAgree}" <c:if test="${item.privacyAgree == 2}">checked</c:if> disabled="disabled"/>비 동의                    		
                    	</td>
	                    <td style="text-align: center">
	                    	<c:choose>
								<c:when test="${item.privacyAgree == 1}">
									<input type="text" class="tel" id="tel1_${status.index}" maxlength="3" value="${item.tel1}" style="width: 25% !important;" />-
									<input type="text" class="tel" id="tel2_${status.index}" maxlength="4" value="${item.tel2}" style="width: 30% !important;" />-
									<input type="text" class="tel" id="tel3_${status.index}" maxlength="4"  value="${item.tel3}" style="width: 30% !important;" />
								</c:when>
								<c:otherwise>
									<input type="text" class="tel" id="tel1_${status.index}" maxlength="3" value="${item.tel1}" style="width: 25% !important;" disabled="disabled"/>-
									<input type="text" class="tel" id="tel2_${status.index}" maxlength="4" value="${item.tel2}" style="width: 30% !important;" disabled="disabled"/>-
									<input type="text" class="tel" id="tel3_${status.index}" maxlength="4"  value="${item.tel3}" style="width: 30% !important;" disabled="disabled"/>
								</c:otherwise>							
							</c:choose>	                    
	                    </td>
	                    <td style="text-align: center">
	                    	<c:choose>
	                    		<c:when test="${suimVO.suimRptState == 2}">
			                    	<c:choose>
			                    		<c:when test="${item.privacyAgree == 2}">
				                    		비 동의
				                    	</c:when>	
				                    	<c:when test="${item.sendState == 1}">
				                    		발송 완료
				                    	</c:when>
				                    	<c:when test="${item.sendState == 2}">				                    	
				                    		발송중<br/>
				                    		( ${ item.stateMsg } )				                    		
				                    	</c:when>
				                    	<c:when test="${item.sendState == 0 && item.sendDate != null }">				                    	
				                    		발송실패<br/>
				                    		( ${ item.stateMsg } )				                    		
				                    	</c:when>				                    				                    	
										<c:when test="${item.privacyAgree == 1}">
											<img src='./resources/ls_img/btn_sms_s.gif' style="cursor: pointer;" onclick="fnIssueSendMsg(${status.index});">		                    	
										</c:when>
				                    	<c:otherwise>
											<c:choose>
												<c:when test="${item.privacyAgree == 1}">
													<img src='./resources/ls_img/btn_sms_s.gif' style="cursor: pointer;" onclick="fnIssueSendMsg(${status.index});">		                    	
												</c:when>
												<c:otherwise>
												-
												</c:otherwise>
											</c:choose>
				                    	</c:otherwise>
			                    	</c:choose>
	                    		</c:when>
	                    		<c:otherwise>
			                    	<c:choose>
			                    		<c:when test="${item.privacyAgree == 2}">
				                    		비 동의
				                    	</c:when>
				                    	<c:when test="${item.sendState == 1}">
				                    		발송 완료
				                    	</c:when>
				                    	<c:when test="${item.sendState == 2}">
				                    		발송중<br/>
				                    		( ${ item.stateMsg } )
				                    	</c:when>
				                    	<c:when test="${item.sendState == 0}">
				                    		<img src='./resources/ls_img/btn_sms_s.gif' style="cursor: pointer;" onclick="fnIssueSendMsg(${status.index});">
				                    	</c:when>				                    					                    	
				                    	<c:otherwise>
											종결 후 발송가능		                    	
				                    	</c:otherwise>
			                    	</c:choose>
	                    		</c:otherwise>
	                    	</c:choose>
	                    </td>	                    
	                    <td>
	                    	${ item.disagreeDate }
	                    	<span style="color:blue">${ item.sendDate }</span>
	                    	<%-- <c:choose>
	                    		<c:when test="${item.privacyAgree == 2}">
	                    			${ item.disagreeDate }	                    			
	                    		</c:when>
	                    		<c:otherwise>
	                    			-
	                    		</c:otherwise>	                    		
	                    	</c:choose>
	                    	<br/>/
	                    	<c:choose>
	                    		<c:when test="${item.privacyAgree == 1}">
	                    			${ item.sendDate }
	                    		</c:when>
	                    		<c:otherwise>
	                    			-
	                    		</c:otherwise>
	                    	</c:choose> --%>	                    	
	                    </td>
	                    <td style="text-align: center">
	                    	<c:choose>
		                    	<c:when test="${item.sendState == 1}">
		                    		-
		                    	</c:when>
		                    	 <c:when test="${item.privacyAgree == 2 && item.suimRptState == 2}">
		                    		-
		                    	</c:when>			                    	                    	
	                    		<c:otherwise>	                    		
		                     	   	<a href="#noloc" onclick="fnIssueSendUpdate(${status.index});"><img src='./resources/ls_img/btn_edite.gif'></a>
		                        	<a href="#noloc" onclick="fnIssueSendDelete(${status.index});"><img src='./resources/ls_img/btn_del.gif'></a>
								</c:otherwise>
	                    	</c:choose>
	                        <input type="hidden" id="send_serial_no_${status.index}" value="${item.serialNo}" />
	                    </td>	                    	                        	
	                </tr>	
                </c:forEach>
            </table>
            
            
            
            
            
            
            