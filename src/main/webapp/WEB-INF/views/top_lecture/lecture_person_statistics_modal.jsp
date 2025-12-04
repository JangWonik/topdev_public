<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
$(document).ready(function () {
	setTimeout(function() {
		doProgressList();
	}, 500);	
});

function doProgressList(){
	<c:forEach var="pTemp" items="${detailPersonList}">		
		$("#personProgress_${pTemp.pkey}").val(${pTemp.sProcessPer});		
	</c:forEach>	
}
</script>
<div id="lecture-process-dialog" title="교육시청하기" style="font-size: 12px;" align="center">
	<br/>
	<div class="tableStyle2" style="width: 1000px;">
		<table class="vacation-ins-table">
			<tr>
				<th width="15%">교육 대상자</th>
				<td width="35%">${user_name}</td>				
				<th width="15%">교육상태</th>
				<td width="35%">${process_state}</td>
			</tr>
		</table>
		<br/>	
		<table>
			<tr>
				<th width="5%">No</th>
				<th width="35%">교육과정 명</th>
				<th width="20%">교육기간</th>
				<th width="20%">수료일</th>
				<th width="30%">진도율</th>
			</tr>
			<c:choose>
				<c:when test="${detailPersonList.size() eq 0}">
					<tr>
						<td colspan="4">조회된 내역이 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="items" items="${detailPersonList}" varStatus="status">
						<tr>
							<td align="center">${detailPersonList.size() - status.index}</td>
							<td>${items.p_title}</td>
							<td>${items.show_sdate_fmt} ~ ${items.show_edate_fmt}</td>
							<td>${items.sEndDate}</td>
							<td>
								<c:choose>
									<c:when test="${process_state eq '교육과정 신청중' }">교육과정 진행 전</c:when>
									<c:otherwise>
									<table>
										<tr>
											<td align="center" style="border:0px;" width="80%"><progress value="0" max="100" id="personProgress_${items.pkey}" style="height:10px;width:80%;valign:middle;"></progress></td>
											<td style="border:0px;text-align:right;padding-right:20px;" width="40%"><b><font color="blue">${items.sProcessPer} %</font></b></td>
										</tr>
									</table>									
									</c:otherwise>
								</c:choose>
							</td>	
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>			
		</table>					
	</div>
</div>