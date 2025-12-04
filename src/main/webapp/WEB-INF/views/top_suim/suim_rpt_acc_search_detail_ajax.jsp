<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<br/>
<div class="tableStyle99">
	<table>	
		<tr>
			<th width="18%">접수번호</th>
			<th width="18%">보험사</th>
			<th width="34%">피보험자</th>			
			<th width="30%">사고번호</th>			
		</tr>			
		<c:choose>		
			<c:when test="${accList.size() == 0}">
				<tr>
					<td colspan="3" align="center">조회결과값이 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				 <c:forEach var="items" items="${accList}" varStatus="status">
				 	<tr>
				 		<td align="center"><b>${items.suim_accept_no}</b></td>
				 		<td align="center"><b>${items.ptnr_name}</b></td>				 		
				 		<td align="center"><b>${items.beneficiary_nm}</b></td>
				 		<td style="text-align:left;padding-left:5px;"><b>${items.accident_no}</b></td>
				 	</tr>	
				 </c:forEach>			
			</c:otherwise>
		</c:choose>	
	</table>
</div>