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
	<form id="quiz_template" name="quiz_template">
	<input type="hidden" id="quiz_answer" name="quiz_answer" value="${quizMap.answer}"/>
	<input type="hidden" id="quiz_next" name="quiz_next" value="${quizMap.next_ord}"/>
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
				<th width="20%">질문</th>
				<td colspan="80%" style="text-align:left;padding-left: 5px;">
					${quizMap.question}
				</td>
			</tr>	
			<tr>
				<th width="20%">답변</th>
				<td colspan="80%" style="text-align:left;padding-left: 5px;">
					<div>
						<input type="radio" id="ex1" name="ex" value="1"/> ${quizMap.ex1}	
					</div>
					<div>
						<input type="radio" id="ex2" name="ex" value="2"/> ${quizMap.ex2}	
					</div>
					<c:if test="${!empty quizMap.ex3}">
						<div>
							<input type="radio" id="ex3" name="ex" value="3"/> ${quizMap.ex3}	
						</div>
					</c:if>
					<c:if test="${!empty quizMap.ex4}">
						<div>
							<input type="radio" id="ex4" name="ex" value="4"/> ${quizMap.ex4}	
						</div>
					</c:if>
					<c:if test="${!empty quizMap.ex5}">
						<div>
							<input type="radio" id="ex5" name="ex" value="5"/> ${quizMap.ex5}	
						</div>
					</c:if>
				</td>
			</tr>
			</tbody>																																																		
		</table>
		<div style="padding:10px 0 10px 0;">
			<input class="buttonEduView" onclick="javascript:doQuizConfirm();" type="button" value="제출하기">
		</div>
		<div id="quiz_comment" style="display:none;">
			<table>
				<tbody>
					<colgroup>
						<col style="width:20%;">
						<col style="width:80%;">											
					</colgroup>				
				<tr>
					<th colspan="2">
						정답은 <font color="red">${quizMap.answer}</font> 번 입니다. 정답을 선택하고 제출하기를 눌러주세요.
					</th>
				</tr>
				<tr>
					<th height="200">해 설</th>
					<td align="left" style="text-align:left;padding-left:5px;">
						${fn:replace(fn:replace(quizMap.comment , LF , '<br>'), ' ', '&nbsp;')}
					</td>
				</tr>
				</tbody>
			</table>
		</div>		
	</div>
	</form>
</div>