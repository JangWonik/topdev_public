<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<table>
		<c:forEach var="item" items="${reportSummaryList}" varStatus="status">		
    	<tr id="summary_tr_${item.serialNo}">
    		<td width="20%" style="text-align:center;">
    			${item.writeDateFmt}
    		</td>
    		<td width="55%">
    			<c:if test="${!empty item.summaryInsuSubject}">
					<div style="padding:5px,0,0,5px;">
						<b>${item.summaryInsuSubject}</b>
					</div>
				</c:if>    			
				<c:if test="${!empty item.firstDateFmt}">
					<div style="padding:5px,0,0,5px;">
					초진일자 : ${item.firstDateFmt}
					</div>
				</c:if>
				<c:if test="${!empty item.incomeDateFmt}">
					<div style="padding:5px,0,0,5px;">
					내원일자 : ${item.incomeDateFmt}
					</div>
				</c:if>
				<c:if test="${!empty item.incomeContent}">
					<div style="padding:5px,0,0,5px;">
					내원경위 : ${fn:replace(item.incomeContent,LF,'<br/>')}
					</div>
				</c:if>
				<c:if test="${!empty item.diseaseName}">
					<div style="padding:5px,0,0,5px;">
					<%-- 진단병명 : ${item.diseaseName} --%>
					진단병명 : ${fn:replace(item.diseaseName,LF,'<br/>')}
					</div>
				</c:if>
				<c:if test="${!empty item.inspectionContent}">
					<div style="padding:5px,0,0,5px;">
					검사사항 : ${fn:replace(item.inspectionContent,LF,'<br/>')}
					</div>
				</c:if>
				<c:if test="${!empty item.operationContent}">
					<div style="padding:5px,0,0,5px;">
					수 술 명 : ${fn:replace(item.operationContent,LF,'<br/>')}
					</div>
				</c:if>
				<c:if test="${!empty item.obstacleDateFmt}">
					<div style="padding:5px,0,0,5px;">
					장해진단일 : ${item.obstacleDateFmt}
					</div>
				</c:if>
				<c:if test="${!empty item.obstacleSubject}">
					<div style="padding:5px,0,0,5px;">
					장해진단명 : ${fn:replace(item.obstacleSubject,LF,'<br/>')}
					</div>
				</c:if>
				<c:if test="${!empty item.obstacleContent}">
					<div style="padding:5px,0,0,5px;">
					장해내용 : ${fn:replace(item.obstacleContent,LF,'<br/>')}
					</div>
				</c:if>
				<c:if test="${!empty item.enterInterval}">
					<div style="padding:5px,0,0,5px;">
					<%-- 입원기간 : ${item.enterInterval} --%>
					입원기간 : ${fn:replace(item.enterInterval,LF,'<br/>')}
					</div>
				</c:if>
				<c:if test="${!empty item.goingInterval}">
					<div style="padding:5px,0,0,5px;">
					<%-- 통원기간 : ${item.goingInterval} --%>
					통원기간 : ${fn:replace(item.goingInterval,LF,'<br/>')}
					</div>
				</c:if>
				<c:if test="${!empty item.pastDisease}">
					<div style="padding:5px,0,0,5px;">
					<%-- 과거병력 : ${item.pastDisease} --%>
					과거병력 : ${fn:replace(item.pastDisease,LF,'<br/>')}
					</div>
				</c:if>
				<c:if test="${!empty item.outingContent}">
					<div style="padding:5px,0,0,5px;">
					<%-- 외출외박 : ${item.outingContent} --%>
					외출외박 : ${fn:replace(item.outingContent,LF,'<br/>')}
					</div>
				</c:if>
				<c:if test="${!empty item.optionContent}">
					<div style="padding:5px,0,0,5px;">
					기타사항 : ${fn:replace(item.optionContent,LF,'<br/>')}
					</div>
				</c:if>
				<c:if test="${!empty item.doctorOpinion}">
					<div style="padding:5px,0,0,5px;">
					의사의견 : ${fn:replace(item.doctorOpinion,LF,'<br/>')}
					</div>
				</c:if>
    		</td>
    		<td width="15%">
    			${item.remarkContent}
    		</td>
    		<td  width="10%" style="text-align: center">
    			<c:if test="${empty item.summaryInsuSubject}">
    			<a href="#noloc" onclick="fnSummaryUpdate('${item.serialNo}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
    			</c:if>
    			<a href="#noloc" onclick="fnSummaryDel('${item.serialNo}');"><img src='./resources/ls_img/btn_del_s.gif'></a>                
            </td>
    	</tr>    	
    	    	    	
    	<tr  id="summary_tr_edit_${item.serialNo}" style="display:none;">
    		<td width="20%">
           		<input type="text" id="summary_write_date_${item.serialNo}" class="calendar" style="width:90px;" value="${item.writeDateFmt}" />
           	</td>
           	<td width="55%">
           		<table>
           			<tr>
      					<td width="20%" style="background-color:#ececec;text-align:center">초진일자</td>
      					<td width="80%"><input type="text" id="first_date_${item.serialNo}" class="calendar" style="width:90px;" value="${item.firstDateFmt}"/></td>
      				</tr>
      				<tr>
      					<td width="20%" style="background-color:#ececec;text-align:center">내원일자</td>
      					<td width="80%"><input type="text" id="income_date_${item.serialNo}" class="calendar" style="width:90px; value="${item.incomeDateFmt}"/></td>
      				</tr>
      				<tr>
      					<td width="20%" style="background-color:#ececec;text-align:center">내원경위</td>
      					<td width="80%"><textarea id="income_content_${item.serialNo}" style="height: 50px;">${item.incomeContent}</textarea></td>
      				</tr>
      				<tr>
      					<td width="20%" style="background-color:#ececec;text-align:center">진단병명</td>
      					<%-- <td width="80%"><input type="text" id="disease_name_${item.serialNo}" value="${item.diseaseName}"/></td> --%>
      					<td width="80%"><textarea id="disease_name_${item.serialNo}" style="height: 50px;">${item.diseaseName}</textarea></td>      					
      				</tr>
      				<tr>
      					<td width="20%" style="background-color:#ececec;text-align:center">검사사항</td>
      					<td width="80%"><textarea id="inspection_content_${item.serialNo}" style="height: 50px;">${item.inspectionContent}</textarea></td>            					
      				</tr>
      				<tr>
      					<td width="20%" style="background-color:#ececec;text-align:center">수술명</td>
      					<td width="80%"><textarea id="operation_content_${item.serialNo}" style="height: 50px;">${item.operationContent}</textarea></td>            					
      				</tr>
      				<tr>
      					<td width="20%" style="background-color:#ececec;text-align:center">장해진단일</td>
      					<td width="80%"><input type="text" id="obstacle_date_${item.serialNo}" class="calendar" style="width:90px;" value="${item.obstacleDateFmt}"/></td>
      				</tr>
      				<tr>
      					<td width="20%" style="background-color:#ececec;text-align:center">장해진단명</td>
      					<td width="80%"><textarea id="obstacle_subject_${item.serialNo}" style="height: 50px;">${item.obstacleSubject}</textarea></td>            					
      				</tr>
      				<tr>
      					<td width="20%" style="background-color:#ececec;text-align:center">장해내용</td>
      					<td width="80%"><textarea id="obstacle_content_${item.serialNo}" style="height: 50px;">${item.obstacleContent}</textarea></td>            					
      				</tr>
      				<tr>
      					<td width="20%" style="background-color:#ececec;text-align:center">입원기간</td>      					
      					<%-- <td width="80%"><input type="text" id="enter_interval_${item.serialNo}" value="${item.enterInterval}"/></td> --%>
      					<td width="80%"><textarea id="enter_interval_${item.serialNo}" style="height: 50px;">${item.enterInterval}</textarea></td>
      				</tr>
      				<tr>
      					<td width="20%" style="background-color:#ececec;text-align:center">통원기간</td>
      					<%-- <td width="80%"><input type="text" id="going_interval_${item.serialNo}" value="${item.goingInterval}"/></td> --%>
      					<td width="80%"><textarea id="going_interval_${item.serialNo}" style="height: 50px;">${item.goingInterval}</textarea></td>
      				</tr>
      				<tr>
      					<td width="20%" style="background-color:#ececec;text-align:center">과거병력</td>
      					<%-- <td width="80%"><input type="text" id="past_disease_${item.serialNo}" value="${item.pastDisease}"/></td> --%>
      					<td width="80%"><textarea id="past_disease_${item.serialNo}" style="height: 50px;">${item.pastDisease}</textarea></td>
      				</tr>
      				<tr>
      					<td width="20%" style="background-color:#ececec;text-align:center">외출외박</td>
      					<%-- <td width="80%"><input type="text" id="outing_content_${item.serialNo}" value="${item.outingContent}"/></td> --%>
      					<td width="80%"><textarea id="outing_content_${item.serialNo}" style="height: 50px;">${item.outingContent}</textarea></td>
      				</tr>
      				<tr>
      					<td width="20%" style="background-color:#ececec;text-align:center">기타사항</td>
      					<td width="80%"><textarea id="option_content_${item.serialNo}" style="height: 50px;">${item.optionContent}</textarea></td>            					
      				</tr>
      				<tr>
      					<td width="20%" style="background-color:#ececec;text-align:center">의사의견</td>
      					<td width="80%"><textarea id="doctor_opinion_${item.serialNo}" style="height: 50px;">${item.doctorOpinion}</textarea></td>            					
      				</tr>
      			</table>
           	</td>
           	<td width="15%">
           		<input type="text" id="remark_content_${item.serialNo}" value="${item.remarkContent}"/>
           	</td>
           	<td  width="10%" style="text-align: center">           		
            	<a href="#noloc" onclick="fnSummaryModifySave('${item.serialNo}');"><img src='./resources/ne_img/btn/btn_save.gif'></a>            	
                <a href="#noloc" onclick="fnSummaryCancel();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
			</td>			
		</tr>								
		</c:forEach>
    <!-- 추가 값 끝 -->            	
</table>