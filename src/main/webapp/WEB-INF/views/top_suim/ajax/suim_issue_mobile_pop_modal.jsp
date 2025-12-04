<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">	
	<div style="margin:10px 5px 0px 5px;background-color:#CEE3F6;">
			<div class="tableStyle4">
				<table>
					<tr>
						<td>
							${fn:replace(fn:replace(fn:escapeXml(sendMap.sendContent) , LF , '<br>'), ' ', '&nbsp;')}							
						</td>
					</tr>
				</table>
			</div>
	</div>	    
   </body>
</html>
