<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="lecture-process-dialog" title="현장보고서 제출현황" style="font-size: 12px;" align="center">
	<br/>
	<div class="tableStyle2" style="width: 850px;">
		<table class="vacation-ins-table">
			<tr>
				<th width="15%" rowspan="2">이름</th>
				<th width="7%" rowspan="2">수임</th>
				<th width="20%" colspan="2">제출</th>
				<th width="20%" colspan="2">미제출</th>
				<th width="12%" rowspan="2">초과율</th>
				<th width="18%" rowspan="2">수임 후 현장보고서<br/>1개월 초과 미제출</th>
				<th width="8%" rowspan="2">평균처리일</th>												
			</tr>				
			<tr>
				<th>3영업일이내</th>
				<th>3영업일초과</th>
				<th>3영업일이내</th>
				<th>3영업일초과</th>
			</tr>			
			<tr>				
				<td><a href="javascript:openSiteMemberReport('${mbrVo_Session.user_no}','suimCnt','${memberSiteMap.end_average_cnt}')">${memberSiteMap.user_name}</a>
					<!-- 초과율 그래프 추가 -->
					<a href="javascript:openPopGraphMember();">
					<img src="./resources/chart/chart_icon.png" title="초과율 그래프">
					</a>
				</td>
				<td><a href="javascript:openSiteMemberReport('${mbrVo_Session.user_no}','suimCnt','${memberSiteMap.end_average_cnt}')">${memberSiteMap.suim_cnt}</a></td>
				<td><a href="javascript:openSiteMemberReport('${mbrVo_Session.user_no}','sub3In','${memberSiteMap.end_average_cnt}')">${memberSiteMap.sub_3_in_cnt }</a></td>
				<td><a href="javascript:openSiteMemberReport('${mbrVo_Session.user_no}','sub3Over','${memberSiteMap.end_average_cnt}')">${memberSiteMap.sub_3_over_cnt}</a></td>
				<td><a href="javascript:openSiteMemberReport('${mbrVo_Session.user_no}','not3In','${memberSiteMap.end_average_cnt}')">${memberSiteMap.not_3_in_cnt}</a></td>
				<td><a href="javascript:openSiteMemberReport('${mbrVo_Session.user_no}','not3Over','${memberSiteMap.end_average_cnt}')">${memberSiteMap.not_3_over_cnt}</a></td>
				<td>${memberSiteMap.over_per} %</td>
				<td><a href="javascript:openSiteMemberReport('${mbrVo_Session.user_no}','not30Over','${memberSiteMap.end_average_cnt}')">${memberSiteMap.not_30_over_cnt}</a></td>
				<td><a href="javascript:openSiteMemberReport('${mbrVo_Session.user_no}','endAverage','${memberSiteMap.end_average_cnt}')">${memberSiteMap.end_average_cnt}</a></td>
			</tr>									
		</table>	
	</div>
</div>
<br/>
<br/>
<div style="text-align:left;padding-left:15px;">
① 수임건수 : 조회일 기준 직전 30일 내 수임건수 (현장보고서 제출 비대상 클래임 제외) <br/>
② 제출 3영업일 이내 : 수임일 포함 3영업일 이내 현장보고서 제출건수  <br/>
③ 제출 3영업일 초과 : 수임일 포함 3영업일 초과 현장보고서 제출건수  <br/>
④ 미 제출 3영업일 이내 : 수임일 포함 3영업일 이내 현장보고서 미 제출건수  <br/>
⑤ 미 제출 3영업일 초과 : 수임일 포함 3영업일 초과 현장보고서 미 제출건수  <br/>
⑥ 초과율 : (③ 제출 3영업일 초과 + ⑤ 미 제출 3영업일 초과) / ① 수임건수 <br/>
⑦ 수임 후 현장보고서 1개월 초과 미제출 : 조회일 기준 직전 30일 초과 미결 건 중 현장보고서 미 제출건수 <br/>
⑧ 현장보고서 제출 관리 대상 ${start_date} 이후 종결 건 평균 처리일(현재 날짜 기준)
</div>
<form name="memberForm" id="memberForm" method="post" action="frontChartMemberModal" target="chartPop">
	<input type="hidden" id="team_id" name="team_id" value="${mbrVo_Session.team_id_main}"/>
	<input type="hidden" name="total_over_per" id="total_over_per" value="${total_over_per }" />
</form>
<script>
	function openPopGraphMember(){
		$("#memberForm").submit();
	}
</script>