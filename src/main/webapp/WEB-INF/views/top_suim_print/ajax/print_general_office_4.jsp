<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<table>	
	<tr id="report_office_4_view">
		<c:choose>			
			<c:when test="${reportOfficeList4.size() == 0 }">								
					<td width="20%" style="text-align:center;">
						-
					</td>
					<td width="55%">
						- 수정버튼을 눌러 정보를 입력해주세요.
					</td>
					<td width="15%">
						-
					</td>
					<td  width="10%" style="text-align: center">
						<a href="#noloc" onclick="fnOffice4Update();"><img src='./resources/ls_img/btn_edite.gif'></a>
					</td>				
			</c:when>
			<c:otherwise>
				<c:forEach var="item" items="${reportOfficeList4}" varStatus="status">
					<td width="20%" style="text-align:center;">
		    			${item.writeDate4Fmt}
		    		</td>
		    		<td width="55%">						
						<c:if test="${!empty item.option4}">
							<div style="padding:5px,0,0,5px;">
							- ${fn:replace(item.option4,LF,'<br/>')}
							</div>
						</c:if>						
					</td>
					<td width="15%">
		    			${item.remarkContent4}
		    		</td>
		    		<td  width="10%" style="text-align: center">
		            	<a href="#noloc" onclick="fnOffice4Update();"><img src='./resources/ls_img/btn_edite.gif'></a>
					</td>
				</c:forEach>
			</c:otherwise>			
		</c:choose>
		</tr>
		
		<tr id="report_office_4_edit" style="display:none;">
			<c:choose>			
				<c:when test="${reportOfficeList4.size() == 0 }">								
					<td width="20%" style="text-align:center;">
						<input type="text" id="office_write_date_4" class="calendar" style="width:90px;"/>
					</td>
					<td width="55%">
						<table>							
	      					<tr>
		      					<td width="20%" style="background-color:#ececec;text-align:center">직접입력</td>
		      					<td width="80%"><textarea id="option_4" style="height: 50px;"></textarea></td>
	      					</tr>	      										
	      				</table>
					</td>
					<td width="15%">
						<input type="text" id="office_remark_content_4" style="width:80px;" />
					</td>
					<td  width="10%" style="text-align: center">
						<a href="#noloc" onclick="fnOffice4ModifySave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
               			<a href="#noloc" onclick="fnGetReportOffice4();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
					</td>				
				</c:when>
				<c:otherwise>
					<c:forEach var="item" items="${reportOfficeList4}" varStatus="status">
						<td width="20%" style="text-align:center;">
							<input type="text" id="office_write_date_4" class="calendar" style="width:90px;" value="${item.writeDate4Fmt}"/>			    			
			    		</td>
			    		<td width="55%">    			
							<table>
		      					<tr>
			      					<td width="20%" style="background-color:#ececec;text-align:center">직접입력</td>
			      					<td width="80%"><textarea id="option_4" style="height: 50px;">${item.option4}</textarea></td>
		      					</tr>		      						      					
		      				</table>
						</td>
						<td width="15%">							
							<input type="text" id="office_remark_content_4" style="width:80px;" value="${item.remarkContent4}"/>			    			
			    		</td>
			    		<td  width="10%" style="text-align: center">
			            	<a href="#noloc" onclick="fnOffice4ModifySave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                			<a href="#noloc" onclick="fnGetReportOffice4();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
						</td>
					</c:forEach>
				</c:otherwise>			
			</c:choose>
		</tr>            	
</table>