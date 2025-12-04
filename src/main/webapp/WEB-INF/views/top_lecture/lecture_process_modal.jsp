<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="lecture-process-dialog" title="교육과정 구성관리" style="font-size: 12px;" align="center">
	<br/>
	<div class="tableStyle2" style="width: 860px;">
		<table class="vacation-ins-table">
			<tr>
				<th width="15%">과정명</th>
				<td width="35%">${processInfo.p_title}</td>
				<th width="15%">등록자</th>
				<td width="35%">${processInfo.reg_user_name}</td>
			</tr>				
			<tr>
				<th width="15%">수강신청기간</th>
				<td width="35%">${processInfo.apply_sdate_fmt} ~ ${processInfo.apply_edate_fmt}</td>
				<th width="15%">교육기간</th>
				<td width="35%">${processInfo.show_sdate_fmt} ~ ${processInfo.show_edate_fmt}</td>
			</tr>
		</table>
		<br/>	
		<table>	
			<tr>
				<th width="45%">										
					대상교육목록
				</th>				
				<td width="10%" rowspan="2">
					<!-- 추가 이동버튼-->
					<img src="./resources/ls_img/icon_pg_next.gif" border="0" onclick="fnNext();" style="cursor:pointer" /><br/>
					<img src="./resources/ls_img/icon_pg_prev.gif" border="0" onclick="fnPrev();" style="cursor:pointer" />
				</td>
				<th width="45%">					
					저장대상목록
				</th>					
			</tr>
			<tr>
				<td>
					<!-- 대상교육목록 -->
					<form id="sourceLectureForm" name="sourceLectureForm">
						<select id="sourceLectureList" name="sourceLectureList[]" multiple style="width:360px;height:350px;">
							<c:forEach var="items" items="${lectureList}" varStatus="status">
								<option value="${items.ekey}">${items.subject}</option>
							</c:forEach>
						</select>
					</form>
				</td>				
				<td>
					<!-- 저장대상목록 -->
					<form id="targetLectureForm" name="targetLectureForm">
						<input type="hidden" id="pkey" name="pkey" value="${processInfo.pkey}"/>
						<select id="targetLectureList" name="targetLectureList[]" multiple style="width:360px;height:350px;">
							<c:forEach var="items" items="${processLectureList}" varStatus="status">
								<option value="${items.ekey}">${items.subject}</option>
							</c:forEach>																					
						</select>
					</form>
				</td>
			</tr>			
		</table>		
	</div>
</div>
