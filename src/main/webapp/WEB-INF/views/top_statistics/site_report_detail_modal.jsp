<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="lecture-process-dialog" title="현장보고서 제출현황 상세보기" style="font-size: 12px;" align="center">
	<br/>
	<c:choose>
		<c:when test="${modalType eq 'M'}">
			<div class="tableStyle2" style="width: 680px;">		
				<table class="vacation-ins-table">
					<tr>
						<th>기준일자</th>
						<th>센터명</th>
						<th>팀명</th>
						<th>성명</th>
					</tr>
					<tr>
						<td>${memberSiteMap.regdate}</td>
						<td>${memberSiteMap.center_name}</td>
						<td>${memberSiteMap.team_name}</td>
						<td>${memberSiteMap.user_name}</td>
					</tr>
				</table>
				<br/>
				<table class="vacation-ins-table">			
					<tr>				
						<th width="15%" rowspan="2">수임</th>
						<th width="20%" colspan="2">제출</th>
						<th width="20%" colspan="2">미제출</th>
						<th width="12%" rowspan="2">초과율</th>
						<th width="18%" rowspan="2">수임 후 현장보고서<br/>1개월 초과 미제출</th>												
					</tr>				
					<tr>
						<th>3영업일이내</th>
						<th>3영업일초과</th>
						<th>3영업일이내</th>
						<th>3영업일초과</th>
					</tr>			
					<tr>
						<td>${memberSiteMap.suim_cnt}</td>
						<td>${memberSiteMap.sub_3_in_cnt }</td>
						<td>${memberSiteMap.sub_3_over_cnt}</td>
						<td>${memberSiteMap.not_3_in_cnt}</td>
						<td>${memberSiteMap.not_3_over_cnt}</td>
						<td>${memberSiteMap.over_per} %</td>
						<td>${memberSiteMap.not_30_over_cnt}</td>					
					</tr>									
				</table>	
			</div>
		</c:when>
		
		<c:when test="${modalType eq 'T'}">
			<div class="tableStyle2" style="width: 680px;">		
				<table class="vacation-ins-table">
					<tr>
						<th>기준일자</th>
						<th>센터명</th>
						<th>팀명</th>						
					</tr>
					<tr>
						<td>${teamSiteMap.regdate}</td>
						<td>${teamSiteMap.center_name}</td>
						<td>${teamSiteMap.team_name}</td>						
					</tr>
				</table>
				<br/>
				<table class="vacation-ins-table">			
					<tr>				
						<th width="15%" rowspan="2">수임</th>
						<th width="20%" colspan="2">제출</th>
						<th width="20%" colspan="2">미제출</th>
						<th width="12%" rowspan="2">초과율</th>
						<th width="18%" rowspan="2">수임 후 현장보고서<br/>1개월 초과 미제출</th>												
					</tr>				
					<tr>
						<th>3영업일이내</th>
						<th>3영업일초과</th>
						<th>3영업일이내</th>
						<th>3영업일초과</th>
					</tr>			
					<tr>
						<td>${teamSiteMap.suim_cnt}</td>
						<td>${teamSiteMap.sub_3_in_cnt }</td>
						<td>${teamSiteMap.sub_3_over_cnt}</td>
						<td>${teamSiteMap.not_3_in_cnt}</td>
						<td>${teamSiteMap.not_3_over_cnt}</td>
						<td>${teamSiteMap.over_per} %</td>
						<td>${teamSiteMap.not_30_over_cnt}</td>					
					</tr>									
				</table>	
			</div>
		</c:when>
		
		<c:when test="${modalType eq 'C'}">
			<div class="tableStyle2" style="width: 680px;">		
				<table class="vacation-ins-table">
					<tr>
						<th>기준일자</th>
						<th>센터명</th>												
					</tr>
					<tr>
						<td>${centerSiteMap.regdate}</td>
						<td>${centerSiteMap.center_name}</td>											
					</tr>
				</table>
				<br/>
				<table class="vacation-ins-table">			
					<tr>				
						<th width="15%" rowspan="2">수임</th>
						<th width="20%" colspan="2">제출</th>
						<th width="20%" colspan="2">미제출</th>
						<th width="12%" rowspan="2">초과율</th>
						<th width="18%" rowspan="2">수임 후 현장보고서<br/>1개월 초과 미제출</th>												
					</tr>				
					<tr>
						<th>3영업일이내</th>
						<th>3영업일초과</th>
						<th>3영업일이내</th>
						<th>3영업일초과</th>
					</tr>			
					<tr>
						<td>${centerSiteMap.suim_cnt}</td>
						<td>${centerSiteMap.sub_3_in_cnt }</td>
						<td>${centerSiteMap.sub_3_over_cnt}</td>
						<td>${centerSiteMap.not_3_in_cnt}</td>
						<td>${centerSiteMap.not_3_over_cnt}</td>
						<td>${centerSiteMap.over_per} %</td>
						<td>${centerSiteMap.not_30_over_cnt}</td>					
					</tr>									
				</table>	
			</div>
		</c:when>
		
		<c:when test="${modalType eq 'S'}">
			<div class="tableStyle2" style="width: 680px;">		
				<table class="vacation-ins-table">
					<tr>
						<th>기준일자</th>
						<th>부문명</th>												
					</tr>
					<tr>
						<td>${sectorSiteMap.regdate}</td>
						<td>${sectorSiteMap.sector_name}</td>											
					</tr>
				</table>
				<br/>
				<table class="vacation-ins-table">			
					<tr>				
						<th width="15%" rowspan="2">수임</th>
						<th width="20%" colspan="2">제출</th>
						<th width="20%" colspan="2">미제출</th>
						<th width="12%" rowspan="2">초과율</th>
						<th width="18%" rowspan="2">수임 후 현장보고서<br/>1개월 초과 미제출</th>												
					</tr>				
					<tr>
						<th>3영업일이내</th>
						<th>3영업일초과</th>
						<th>3영업일이내</th>
						<th>3영업일초과</th>
					</tr>			
					<tr>
						<td>${sectorSiteMap.suim_cnt}</td>
						<td>${sectorSiteMap.sub_3_in_cnt }</td>
						<td>${sectorSiteMap.sub_3_over_cnt}</td>
						<td>${sectorSiteMap.not_3_in_cnt}</td>
						<td>${sectorSiteMap.not_3_over_cnt}</td>
						<td>${sectorSiteMap.over_per} %</td>
						<td>${sectorSiteMap.not_30_over_cnt}</td>					
					</tr>									
				</table>	
			</div>
		</c:when>
	</c:choose>
</div>