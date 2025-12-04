<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table>	
	<c:choose>		
		<c:when test="${lectureQuizList.size() == 0}">
			<tr>
				<td colspan="6" align="center">조회결과값이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="items" items="${lectureQuizList}" varStatus="status">				
				<tr>
					<td width="5%" align="center">${lectureQuizList.size() - status.index}</td>
					<td width="22%" style="padding-left:5px;" title="${items.title}"><div style="cursor:pointer;width:250px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" onclick="javascript:doQuizView('${items.qkey}')">${items.title}</div></td>
					<td width="22%" style="padding-left:5px;" title="${items.question}"><div style="cursor:pointer;width:250px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" onclick="javascript:doQuizView('${items.qkey}')">${items.question}</div></td>
					<td width="22%" style="padding-left:5px;" title="${items.comment}"><div style="cursor:pointer;width:250px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" onclick="javascript:doQuizView('${items.qkey}')">${items.comment}</div></td>
					<td width="9%" align="center">
						<c:choose>
							<c:when test="${items.is_use eq 0}">사용함</c:when>
							<c:otherwise>사용안함</c:otherwise>
						</c:choose>
					</td>
					<td width="10%" align="center">${items.regdate_fmt}</td>
					<td width="10%" align="center">
						<a href="#noloc" class="btn-equipment-mod-s" id="btn-search" onclick="javascript:doQuizMod('${items.qkey}');">수정</a>
						<a href="#noloc" class="btn-equipment-del-s" id="btn-search" onclick="javascript:doQuizDelete('${items.qkey}','${items.title}');">삭제</a>
					</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>