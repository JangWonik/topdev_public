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
					${boardDetail.title}
				</div>			
			</td>									
		</tr>		
		<tr>
			<th width="20%" height="35px">현재 분류</th>
			<td width="80%" style="text-align:left;padding-left:10px;">
				${boardDetail.category_id_nm}
			</td>
		</tr>
		<tr>
			<th width="20%" height="35px">변경될 분류</th>
			<td width="80%" style="text-align:left;padding-left:10px;">
				<select id="cateSelectModal" name="cateSelectModal" style="width:60%;">
					<c:forEach items="${cateList}" var = "cateVo">
						<option value="${cateVo.col_cd}"
							<c:if test="${searchVO.cateSearch == cateVo.col_cd}">selected</c:if> > ${cateVo.col_val} </option>
					</c:forEach>					
				</select>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:doCategoryUpdate('${boardDetail.board_no}');" class="btn-vacation-aprv" id="uploadCateSendBtn"  style="background:#CEE3F6;">수정</a>	
			</td>			
		</tr>
	</table>				
</div>