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
	<c:forEach var="pTemp" items="${detailMemberList}">		
		$("#processProgress_${pTemp.user_no}").val(${pTemp.sProcessPer});		
	</c:forEach>	
}
</script>

<div id="lecture-process-dialog" title="교육과정별 통계 상세보기" style="font-size: 12px;" align="center">
	<br/>	
	<div class="tableStyle2" style="width: 980px;">
		<table class="vacation-ins-table">
			<tr>
				<th width="15%">교육과정 명</th>
				<td width="35%">${ProcessMap.p_title}</td>				
				<th width="15%">교육상태</th>
				<td width="35%">${ProcessMap.process_state}</td>
			</tr>
			<tr>
				<th width="15%">교육기간</th>
				<td width="35%">${ProcessMap.show_sdate_fmt} ~ ${ProcessMap.show_edate_fmt}</td>				
				<th width="15%">조회인원 수</th>
				<td width="35%">${detailMemberList.size()}</td>
			</tr>
		</table>
		</div>
		<br/>
		<c:choose>
			<c:when test="${ProcessMap.type_flag eq 'AP'}">
			<div class="tableStyle2" style="width: 980px;">
				<table>
					<tr>
						<th width="50px">No</th>
						<th width="140px">센터명</th>
						<th width="140px">부서명</th>
						<th width="140px">이름</th>
						<th width="100px">신청일</th>
						<th width="100px">수료일</th>
						<th width="287px">진도율</th>
						<th width="13px"></th>
					</tr>
				</table>
			</div>
			<div class="tableStyle99" style="width:980px;height:625px; overflow-x: hidden; overflow-y: auto">	
				<table>
					<c:choose>
						<c:when test="${detailMemberList.size() eq 0}">
							<tr>
								<td colspan="6">조회된 내역이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="items" items="${detailMemberList}" varStatus="status">
								<tr>
									<td width="50px" align="center">${detailMemberList.size() - status.index}</td>
									<td width="140px" align="center">${items.center_name}</td>
									<td width="140px" align="center">${items.team_name}</td>
									<td width="140px" align="center">${items.user_name}</td>
									<td width="100px" align="center">${items.reg_date_fmt}</td>
									<td width="100px" align="center">${items.sEndDate}</td>
									<td width="287px" align="center">
										<table>
											<tr>
												<td align="center" style="border:0px;" width="80%"><progress value="0" max="100" id="processProgress_${items.user_no}" style="height:10px;width:80%;valign:middle;"></progress></td>
												<td style="border:0px;text-align:right;padding-right:50px;" width="40%"><b><font color="blue">${items.sProcessPer} %</font></b></td>
											</tr>
										</table>
									</td>											
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>			
				</table>
			</div>
			</c:when>
			<c:otherwise>
				<div class="tableStyle2" style="width: 980px;">
					<table>
						<tr>
							<th width="50px" align="center">No</th>
							<th width="140px" align="center">센터명</th>
							<th width="140px" align="center">부서명</th>
							<th width="140px" align="center">이름</th>
							<th width="100px" align="center">수료일</th>
							<th width="387px" align="center">진도율</th>
							<th width="13px" align="center"></th>
						</tr>
					</table>
				</div>
				<div class="tableStyle99" style="width:980px;height:625px; overflow-x: hidden; overflow-y: auto">
					<table>
						<c:choose>
							<c:when test="${detailMemberList.size() eq 0}">
								<tr>
									<td colspan="5">조회된 내역이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="items" items="${detailMemberList}" varStatus="status">
									<tr>
										<td width="50px" align="center">${detailMemberList.size() - status.index}</td>
										<td width="140px" align="center">${items.center_name}</td>
										<td width="140px" align="center">${items.team_name}</td>
										<td width="140px" align="center">${items.user_name}</td>
										<td width="100px" align="center">${items.sEndDate}</td>
										<td width="387px" align="center">
											<table>
												<tr>
													<td align="center" style="border:0px;" width="80%"><progress value="0" max="100" id="processProgress_${items.user_no}" style="height:10px;width:80%;valign:middle;"></progress></td>
													<td style="border:0px;text-align:right;padding-right:50px;" width="40%"><b><font color="blue">${items.sProcessPer} %</font></b></td>
												</tr>
											</table>
										</td>	
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>			
					</table>
				</div>
			</c:otherwise>
		</c:choose>							
	</div>