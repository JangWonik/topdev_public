<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<table>		
	<c:forEach var="item" items="${sagoList}" varStatus="status">			
		<tr id="sago_list_view_${item.sagoNo}">			
			<td width="20%" style="text-align: center">${item.regDate}</td>
			<td width="35%">${item.item}</td>
			<td width="35%">${item.content}</td>
			<td  width="10%" style="text-align: center">
				<a href="#noloc" onclick="fnSagoListUpdate('${item.sagoNo}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
				<a href="#noloc" onclick="fnSagoListDel('${item.sagoNo}');"><img src='./resources/ls_img/btn_del_s.gif'></a>
			</td>
		</tr>
		
		<tr id="sago_list_edit_${item.sagoNo}" style="display:none;">			
			<td width="20%" style="text-align: center"><input type="text" id="control_date_${item.sagoNo}" class="calendar" value="${item.regDate}" style="width:90px;"></td>
			<td width="35%"><input type="text" id="control_subject_${item.sagoNo}" value="${item.item}"></td>
			<td width="35%"><input type="text" id="control_memo_${item.sagoNo}" value="${item.content}"></td>
			<td  width="10%" style="text-align: center">
				<a href="#noloc" onclick="fnSagoUpdate('${item.sagoNo}');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
            	<a href="#noloc" onclick="fnSagoList();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
			</td>
		</tr>		
	</c:forEach>
	
	<tr id="sago_list_add" style="display:none;">			
		<td width="20%" style="text-align: center"><input type="text" id="control_date_add" class="calendar" style="width:90px;"></td>
		<td width="35%"><input type="text" id="control_subject"></td>
		<td width="35%"><input type="text" id="control_memo"></td>
		<td  width="10%" style="text-align: center">
			<a href="#noloc" onclick="fnSagoSave();"><img src='./resources/ne_img/btn/btn_save.gif'></a>
            <a href="#noloc" onclick="fnSagoList();"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
		</td>
	</tr>	
</table>