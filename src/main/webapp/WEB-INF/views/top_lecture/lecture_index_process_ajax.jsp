<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
$(document).ready(function(){
	setTimeout(function() {
		doProgressList();
	}, 500);
});

function doProgressList(){
	<c:forEach var="jTemp" items="${myLectureProcessList}">		
		$("#myProgress_${jTemp.pkey}").val(${jTemp.progress_per});		
	</c:forEach>	
}

function doQna( p_pkey ){	
	$("#titleSearch").val(p_pkey);
	$("#eduQnaForm").submit();	
}
</script>
<div class="nociteA nocite" style="height: 400px;width: 1000px;">
	<div class="notice_top">
		<c:choose>
			<c:when test="${ptype eq 'All'}">
				<h3>전체 교육과정 및 진도율</h3>		
			</c:when>
			<c:when test="${ptype eq 'Ing'}">
				<h3>진행중인 교육과정 및 진도율</h3>		
			</c:when>
			<c:when test="${ptype eq 'Done'}">
				<h3>완료된 교육과정 및 진도율</h3>		
			</c:when>
			<c:when test="${ptype eq 'End'}">
				<h3>종료된 교육과정 및 진도율</h3>		
			</c:when>
			<c:otherwise>
				<h3>교육과정 및 진도율</h3>
			</c:otherwise>
		</c:choose>		
	</div>					
	<div class="notice_bot" style="margin: 5px 13px 10px;">
		<div class="tableStyle99">
			<table summary="교육 과정 진도율">
				<caption>교육 과정 진도율</caption>																	
				<tbody>
					<tr>
						<th width="10%">진행상태</th>
						<th width="35%">교육과정 명</th>
						<th width="20%">교육기간</th>
						<th width="20%">진도율</th>
						<th width="15%">-</th>
					</tr>
				<c:choose>					
					<c:when test="${myLectureProcessList.size() eq 0}">
						<tr>
							<td colspan="5" align="center">																		
								수강 내역이 없습니다. 수강신청 후 사용하세요.
							</td>																				
						</tr>
					</c:when>
					<c:otherwise>						
						<c:forEach var="items" items="${myLectureProcessList}" varStatus="status">
							<tr>
								<!--상태-->
								<td align="center">
										<a class="txt">
											<c:choose>
												<c:when test="${items.show_enable eq 1}">
													<input type="button" value="교육예정" class="buttonReadyFlag" onclick="lectureRelationView(${items.pkey})"/>
												</c:when>
												<c:when test="${items.show_enable eq 2}">
													<input type="button" value="교육종료" class="buttonEndFlag" onclick="lectureRelationView(${items.pkey})"/>
												</c:when>
												<c:when test="${items.progress_per > 99.0 && items.ing_flag eq 0}">
													<input type="button" value="교육완료" class="buttonDoneFlag" onclick="lectureRelationView(${items.pkey})"/>													
												</c:when>
												<c:otherwise>
													<input type="button" value="교육진행" class="buttonIngFlag" onclick="lectureRelationView(${items.pkey})"/>
												</c:otherwise>
											</c:choose>
										</a>																				
								</td>
								<td style="text-align:left;padding-left:5px;" title="${items.p_content}"><span class="middot"></span> <b>${items.p_title}</b></td>
								<td align="center">${items.show_sdate_fmt} ~ ${items.show_edate_fmt}</td>
								<td align="center" style="padding-top:8px;">
									<table>
										<tr>
											<td align="center" style="border:0px;" width="60%"><progress value="0" max="100" id="myProgress_${items.pkey}" style="height:10px;width:80%;valign:middle;"></progress></td>
											<td style="border:0px;text-align:right;padding-right:10px;" width="40%"><font color="blue">${items.progress_per}%</font></td>
										</tr>
									</table>									
								</td>
								<!-- 진행률 -->
								<td class="day" width="19%" align="center"> 																																				
									<input type="button" value="과정보기" class="buttonShowFlag" onclick="javascript:doProcessView('${items.pkey}','${items.show_enable}');"/>
									<c:if test="${items.qna_use eq 1}">										
										<input type="button" value="Q&A" class="buttonShowQna" onclick="javascript:doQna('${items.pkey}');"/>
									</c:if>
								</td>								
							</tr>	
						</c:forEach>
					</c:otherwise>
				</c:choose>																	
			</tbody>
			</table>
		</div>												
	</div>	
	<a class="btn_more" href="./lectureUserApplyList"><input type="button" class="buttonMini" value="더보기"/></a>	
</div>
<!-- Qna 이동 -->
<form id="eduQnaForm" name="eduQnaForm" action="brdLectureBoardList">
	<input type="hidden" id="titleSearch" name="titleSearch"/>
</form>