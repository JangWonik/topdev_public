<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>                   
	        <table id="table_comment_view">
	        	<colgroup>
		        	<col width="15%">
		            <col width="85%">
	            </colgroup>
	            <tbody>
	        	<tr>
	        		<th>
	        			구분
	        		</th>
	        		<th>
	        			관련내용
	        		</th>
	        	</tr>
	        	<tr>
	        		<th>
	        			손해사정 의견
	        		</th>
	        		<td style="text-align:left;padding-left:5px;">
	        			${rptIssue.reportComment}
	        		</td>
	        	</tr>
	        	<tr>
	        		<th>
	        			관련 참고사항<br/>(약관,판례 등)
	        		</th>
	        		<td style="text-align:left;padding-left:5px;">
	        			${rptIssue.reportReference}
	        		</td>
	        	</tr>
	        </table>        
	        <table id="table_comment_edit" style="display: none; text-align: left;">
	        	<colgroup>
		        	<col width="15%">
		            <col width="85%">
	            </colgroup>
	            <tbody>
		        	<tr>
		        		<th>
		        			구분
		        		</th>
		        		<th>
		        			관련내용
		        		</th>
		        	</tr>
		        	<tr>
		        		<th>
		        			손해사정 의견
		        		</th>
		        		<td height="100px;">
		        			<textarea rows="5" cols="40" id="report_comment" name="report_comment">${fn:replace(fn:replace(rptIssue.reportComment, '<br/>', CRLF), ' ', '&nbsp;')}</textarea>
		        		</td>
		        	</tr>
		        	<tr>
		        		<th>
		        			관련 참고사항<br/>(약관,판례 등)
		        		</th>
		        		<td height="100px;">
		        			<textarea rows="5" cols="40" id="report_reference" name="report_reference">${fn:replace(fn:replace(rptIssue.reportReference, '<br/>', CRLF), ' ', '&nbsp;')}</textarea>
		        		</td>
		        	</tr>
		        </tbody>
	        </table>