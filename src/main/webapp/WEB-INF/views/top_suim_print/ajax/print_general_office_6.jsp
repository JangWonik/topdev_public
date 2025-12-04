<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<table>	
	<tr>
		<th width="90%" style="text-align:left;padding-left:5px;">특이사항</th>
		<th width="10%">-</th>
	</tr>
	<tr id="report_office_6_view">
	<c:choose>
	<c:when test="${reportOfficeList6.size() == 0 }">	
		<td width="90%">
			- 수정버튼을 눌러 정보를 입력해주세요.
		</td>
		<td  width="10%" style="text-align: center">
			<a href="#noloc" onclick="fnOffice6Update();"><img src='./resources/ls_img/btn_edite.gif'></a>
		</td>	
	</c:when>
	<c:otherwise>
		<c:forEach var="item" items="${reportOfficeList6}" varStatus="status">			
    		<td width="90%">						
				<c:if test="${!empty item.uniqueContent6}">
					<div style="padding:5px,0,0,5px;">
					${fn:replace(item.uniqueContent6,LF,'<br/>')}
					</div>
				</c:if>
				<br/>
				<c:if test="${!empty item.insureAddress6}">
					<div style="padding:5px,0,0,5px;">
					<b>피보험자(계약자) 주소 : </b>${item.insureAddress6}
					</div>
				</c:if>						
			</td>			
    		<td  width="10%" style="text-align: center">
            	<a href="#noloc" onclick="fnOffice6Update();"><img src='./resources/ls_img/btn_edite.gif'></a>
			</td>
		</c:forEach>		
	</c:otherwise>
	</c:choose>
	</tr>
	
	<tr id="report_office_6_edit" style="display:none;">
		<td>			
			<c:choose>
				<c:when test="${reportOfficeList6.size() == 0 }">				
						<textarea id="unique_content_6" style="height: 50px;"></textarea>
						<table>
							<tr>
								<th width="20%">피보험자(계약자)주소</th>
								<td width="80%"><input type="text" id="insure_address_6"></td>
							</tr>
						</table>									
				</c:when>
				<c:otherwise>
					<c:forEach var="item" items="${reportOfficeList6}" varStatus="status">										
						<textarea id="unique_content_6" style="height: 100px;">${item.uniqueContent6}</textarea>
						<table>
							<tr>
								<th width="30%">피보험자(계약자) 주소</th>
								<td width="70%"><input type="text" id="insure_address_6" value="${item.insureAddress6}"></td>
							</tr>
						</table>					    		
					</c:forEach>		
				</c:otherwise>
			</c:choose>		
		</td>
		<td rowspan="2" width="10%" style="text-align: center">
			<a href="#noloc" onclick="fnOffice6ModifySave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
            <a href="#noloc" onclick="fnGetReportOffice6();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		</td>		
	</tr>	
</table>