<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
            <table id="table_basis_view">
                <tr>
                    <th>
                    	${fn:replace(fn:replace(fn:escapeXml(rptIssue.paymentBasis) , CRLF , '<br>'), ' ', '&nbsp;')}
                   	</th>
                </tr>
            </table>
            
            <table id="table_basis_edit" style="display:none;">
                <tr>
                    <td>
                    	<textarea id="payment_basis" maxlength="200" rows="5">${rptIssue.paymentBasis}</textarea>
                   	</td> 
                </tr>
            </table>