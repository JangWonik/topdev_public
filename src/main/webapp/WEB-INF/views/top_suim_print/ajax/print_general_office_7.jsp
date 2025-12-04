<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<table>	
	<tr>
		<th width="90%" style="text-align:left;padding-left:5px;">탐문리스트</th>
		<th width="10%">-</th>
	</tr>
	<tr id="report_office_7_view">
	<c:choose>
	<c:when test="${reportOfficeList7.size() == 0 }">	
		<td width="90%">
			- 수정버튼을 눌러 정보를 입력해주세요.
		</td>
		<td  width="10%" style="text-align: center">
			<a href="#noloc" onclick="fnOffice7Update();"><img src='./resources/ls_img/btn_edite.gif'></a>
		</td>	
	</c:when>
	<c:otherwise>
		<c:forEach var="item" items="${reportOfficeList7}" varStatus="status">			
    		<td width="90%">						
				<c:if test="${!empty item.searchList7}">
					<div style="padding:5px,0,0,5px;">
					${fn:replace(item.searchList7,LF,'<br/>')}
					</div>
				</c:if>										
			</td>			
    		<td  width="10%" style="text-align: center">
            	<a href="#noloc" onclick="fnOffice7Update();"><img src='./resources/ls_img/btn_edite.gif'></a>
			</td>
		</c:forEach>		
	</c:otherwise>
	</c:choose>
	</tr>
	
	<tr id="report_office_7_edit" style="display:none;">
		<td>			
			<c:choose>
				<c:when test="${reportOfficeList7.size() == 0 }">				
						<textarea id="search_list_7" style="height: 100px;"></textarea>								
				</c:when>
				<c:otherwise>
					<c:forEach var="item" items="${reportOfficeList7}" varStatus="status">										
						<textarea id="search_list_7" style="height: 100px;">${item.searchList7}</textarea>											    		
					</c:forEach>		
				</c:otherwise>
			</c:choose>		
		</td>
		<td rowspan="2" width="10%" style="text-align: center">
			<a href="#noloc" onclick="fnOffice7ModifySave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
            <a href="#noloc" onclick="fnGetReportOffice7();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		</td>		
	</tr>	
</table>