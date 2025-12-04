<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="lecture-process-dialog" title="교육과정 구성관리" style="font-size: 12px;" align="center">
	<br/>
	<div class="tableStyle2" style="width: 860px;">
		<table class="vacation-ins-table">
			<tr>
				<th width="15%">주제명</th>
				<td width="35%">${lectureInfo.subject}</td>
				<th width="15%">강사</th>
				<td width="35%">${lectureInfo.reg_user_name}</td>
			</tr>				
			<tr>
				<th width="15%">개요</th>
				<td colspan="3" style="text-align:left;padding: 5px 5px 5px 5px;">${lectureInfo.introduce}</td>
			</tr>
		</table>
		<br/>	
		<table>	
			<tr>
				<th width="45%">										
					테스트 대상 목록
				</th>				
				<td width="10%" rowspan="2">
					<!-- 추가 이동버튼-->
					<img src="./resources/ls_img/icon_pg_next.gif" border="0" onclick="fnQuizNext();" style="cursor:pointer" /><br/>
					<img src="./resources/ls_img/icon_pg_prev.gif" border="0" onclick="fnQuizPrev();" style="cursor:pointer" />
				</td>
				<th width="45%">					
					테스트 저장 목록
				</th>					
			</tr>
			<tr>
				<td>
					<!-- 대상교육목록 -->
					<form id="sourceLectureQuizForm" name="sourceLectureQuizForm">
						<select id="sourceLectureQuizList" name="sourceLectureQuizList[]" multiple style="width:360px;height:350px;">
							<c:forEach var="items" items="${lectureQuizList}" varStatus="status">
								<option value="${items.qkey}">${items.title}</option>
							</c:forEach>
						</select>
					</form>
				</td>				
				<td>
					<!-- 저장대상목록 -->
					<form id="targetLectureInfoForm" name="targetLectureInfoForm">
						<input type="hidden" id="ekey" name="ekey" value="${lectureInfo.ekey}"/>
						<select id="targetLectureInfoList" name="targetLectureInfoList[]" multiple style="width:360px;height:350px;">
							<c:forEach var="items" items="${lectureRelationQuizList}" varStatus="status">
								<option value="${items.qkey}">${items.title}</option>
							</c:forEach>																					
						</select>
					</form>
				</td>
			</tr>			
		</table>		
	</div>
</div>
