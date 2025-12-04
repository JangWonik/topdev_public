<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("CR", "\r"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<div class="tableStyle2" style="width: 400px;">
	<table class="vacation-ins-table">
		<tr>
			<th width="20%" height="25px">제 목</th>
			<td width="80%" style="text-align:left;padding-left:10px;">
				<div style="width:300px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
					${boardTitle}
				</div>			
			</td>
		</tr>		
		<tr>
			<th width="20%" height="35px">파일목록</th>
			<td colspan="3" style="text-align:left;padding-left:10px;">
				<c:choose>
					<c:when test="${boardDetailFile.size() == 0 }">첨부된 파일이 없습니다.</c:when>
					<c:otherwise>
						<c:forEach items="${boardDetailFile}" var="afile" varStatus="status">
							<div style="padding-top:5px;width:300px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
								<a href="./brdRefPtnrFileDownload?fileNo=${afile.board_file_no}">
								<img src="./resources/ls_img/icon_disket.gif"> ${afile.file_name}
								</a>
							</div>
						</c:forEach>						
					</c:otherwise>
				</c:choose>								
			</td>
		</tr>
	</table>				
</div>