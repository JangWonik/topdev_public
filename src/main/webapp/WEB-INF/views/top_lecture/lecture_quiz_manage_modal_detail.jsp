<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${title_Session}</title>    
<div id="quiz-detail-dialog" title="테스트 상세보기" style="font-size: 15px;" align="center">
	<br/>
	<div class="tableStyle2" style="width: 750px;">
		<table class="vacation-ins-table">
			<colgroup>
				<col style="width:20%;">
				<col style="width:30%;">
				<col style="width:20%;">
				<col style="width:30%;">					
			</colgroup>
			<tbody>
			<tr>
				<th width="20%"><font color="red">*</font> 테스트 명</th>
				<td colspan="3" style="text-align:left;padding-left: 5px;">
					${quizMap.title}
				</td>
			</tr>
			<tr>
				<th width="20%"><font color="red">*</font> 질문 내용</th>
				<td colspan="3" style="text-align:left;padding-left: 5px;">
					${quizMap.question}
				</td>
			</tr>
			<tr>
				<th width="20%"><font color="red">*</font> 보기1</th>
				<td colspan="3" style="text-align:left;padding-left: 5px;">
					${quizMap.ex1}
				</td>
			</tr>
			<tr>
				<th width="20%"><font color="red">*</font> 보기2</th>
				<td colspan="3" style="text-align:left;padding-left: 5px;">
					${quizMap.ex2}
				</td>
			</tr>
			<tr>
				<th width="20%">보기3</th>
				<td colspan="3" style="text-align:left;padding-left: 5px;">
					${quizMap.ex3}
				</td>
			</tr>
			<tr>
				<th width="20%">보기4</th>
				<td colspan="3" style="text-align:left;padding-left: 5px;">
					${quizMap.ex4}
				</td>
			</tr>
			<tr>
				<th width="20%">보기5</th>
				<td colspan="3" style="text-align:left;padding-left: 5px;">
					${quizMap.ex5}
				</td>
			</tr>
			<tr>
				<th width="20%"><font color="red">*</font> 정답</th>
				<td width="30%">
					${quizMap.answer}
				</td>
				<th width="20%">사용여부</th>
				<td width="30%">
					<c:choose>
						<c:when test="${quizMap.is_use eq 0}">사용함</c:when>
						<c:otherwise>사용안함</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th width="20%" height="200">해 설<br/>(오답 선택 시 표시)</th>
				<td colspan="3" align="left" style="text-align:left;padding-left:5px;">
					${fn:replace(fn:replace(quizMap.comment , LF , '<br>'), ' ', '&nbsp;')}
				</td>
			</tr>
			</tbody>																																																		
		</table>		
	</div>
</div>