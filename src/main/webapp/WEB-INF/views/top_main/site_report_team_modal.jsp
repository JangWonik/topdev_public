<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	.buttonMiniView{
		width:80px;
		height:20px;
	    background-color:#F7F7F7;
	    color:#666;
	    text-align: center;
		border-radius:5px;
	    font-size: 10px;
	    cursor: pointer;
	    text-decoration:none;
	    border: solid 1px grey;		    
	}
</style>
<script>
	//그래프 새창 띄우기
	function openPopGraph(p_val){
		
		//센터전체목록 그래프로 처리
		if( p_val == 'team_all' ){
			var obj = document.teamAllForm;
			$("#viewType").val(p_val);			
			obj.submit();
		}else if( p_val == 'team_sel' ){
			var obj = document.teamSelForm;
			$("#viewType").val(p_val);
			obj.submit();
		}
	}
</script>
<c:choose>
	<c:when test="${menuType eq 'Team'}">
		<form name="teamAllForm" id="teamAllForm" method="post" action="frontChartDetailModal" target="chartPop">
		<input type="hidden" id="viewType" name="viewType"/>
		<div id="lecture-process-dialog" title="현장보고서 제출현황" style="font-size: 12px;" align="center">		
			<div style="width:950px;padding:5px 0 5px 0;">
				<div style="float: left;">
					<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" >
					&nbsp;&nbsp;<b>${title_center_name}</b>
					<!-- 초과율 그래프 추가 기능은 있으나 막음 20210525-->
					<%-- <c:if test="${not empty teamSiteResult}">
					<a href="javascript:openPopGraph('team_all');">
					<img src="./resources/chart/chart_text_icon.png" title="초과율 그래프">
					</a>								
					</c:if> --%>
				</div>			
				<div style="text-align: right;">
					<c:if test="${mbr_pms_38 eq '1' or work_type_cd eq '14' or work_type_cd eq '2'}">					
						<a href="javascript:openSiteReportCenter( 0 )" class="btn-vacation-list-ins" title="센터목록으로 이동합니다.">센터목록</a>&nbsp;
					</c:if>
					<a href="./getSiteReportAll" class="btn-vacation-list-ins" title="현장보고서 제출현황 전체페이지로 이동합니다." style="background:#A9D0F5;">바로가기</a>								
				</div>
			</div>
			<div class="tableStyle2" style="width: 950px;">
				<table class="vacation-ins-table">
					<tr>
						<th width="130px" rowspan="2">팀명</th>
						<th width="130px" rowspan="2">수임</th>
						<th width="200px" colspan="2">제출</th>
						<th width="200px" colspan="2">미제출</th>
						<th width="60px" rowspan="2">초과율</th>
						<th width="125px" rowspan="2">수임 후 현장보고서<br/>1개월 초과 미제출</th>
						<th width="80px" rowspan="2">평균처리일</th>
						<th width="15px" rowspan="2">&nbsp;</th>																			
					</tr>						
					<tr>
						<th>3영업일이내</th>
						<th>3영업일초과</th>
						<th>3영업일이내</th>
						<th>3영업일초과</th>
					</tr>
				</table>
			</div>
			<div class="tableStyle2" style="height:480px;width:950px; overflow-x: hidden; overflow-y: auto;border-top:0px;">
				<table>		
					<c:forEach items="${teamSiteResult}" var="item" varStatus="status">
					<tr onclick="javascript:openSiteReportTeam(${item.team_id});" style="cursor:pointer;" onmouseover="this.style.backgroundColor='#FFECEC'" onmouseout="this.style.backgroundColor=''">
						<td width="130px">${item.team_name}</td>
						<td width="130px">${item.suim_cnt}</td>
						<td width="100px">${item.sub_3_in_cnt }</td>
						<td width="100px">${item.sub_3_over_cnt}</td>
						<td width="100px">${item.not_3_in_cnt}</td>
						<td width="100px">${item.not_3_over_cnt}</td>
						<td width="60px">${item.over_per} %</td>
						<td width="125px">${item.not_30_over_cnt}</td>
						<td width="80px">${item.end_average_cnt}</td>
						<c:set var="sum_suim_cnt" value="${sum_suim_cnt + item.suim_cnt}"/>
						<c:set var="sum_sub_3_in_cnt" value="${sum_sub_3_in_cnt + item.sub_3_in_cnt}"/>
						<c:set var="sum_sub_3_over_cnt" value="${sum_sub_3_over_cnt + item.sub_3_over_cnt}"/>
						<c:set var="sum_not_3_in_cnt" value="${sum_not_3_in_cnt + item.not_3_in_cnt}"/>
						<c:set var="sum_not_3_over_cnt" value="${sum_not_3_over_cnt + item.not_3_over_cnt}"/>						
						<c:set var="sum_not_30_over_cnt" value="${sum_not_30_over_cnt + item.not_30_over_cnt}"/>
						<c:set var="sum_end_average_cnt" value="${sum_end_average_cnt + item.end_average_cnt}"/>					
					</tr>
						<input type="hidden" name="all_name[]" value="['${item.team_name}','(${item.over_per}%)']"/>
						<input type="hidden" name="all_over_per[]" value="${item.over_per}"/>
					</c:forEach>
					<tr>
						<th>합계</th>
						<th>${sum_suim_cnt}</th>
						<th>${sum_sub_3_in_cnt}</th>
						<th>${sum_sub_3_over_cnt}</th>
						<th>${sum_not_3_in_cnt}</th>
						<th>${sum_not_3_over_cnt}</th>
						<th>
							<c:choose>
								<c:when test="${sum_suim_cnt == 0}">0%</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${(sum_sub_3_over_cnt + sum_not_3_over_cnt) / sum_suim_cnt * 100}" pattern="#,###"/>%
								</c:otherwise>
							</c:choose>							
						</th>
						<th>${sum_not_30_over_cnt}</th>						
						<th>							
							<fmt:formatNumber value="${sum_end_average_cnt / teamSiteResult.size()}" pattern="#,###"/>
						</th>
					</tr>						
				</table>	
			</div>
		</div>
		<input type="hidden" name="all_over_per_sum" value='<fmt:formatNumber value="${(sum_sub_3_over_cnt + sum_not_3_over_cnt) / sum_suim_cnt * 100}" pattern="#,###"/>'>
		</form>
	</c:when>
	<c:when test="${menuType eq 'Member'}">
		<form name="teamSelForm" id="teamSelForm" method="post" action="frontChartDetailModal" target="chartPop">
		<input type="hidden" id="viewType" name="viewType"/>
		<div id="lecture-process-dialog" title="현장보고서 제출현황" style="font-size: 12px;" align="center">
			<div style="width:950px;padding:5px 0 5px 0;">
				<div style="float: left;">
					<img src="./resources/ls_img/dotte.gif" width="12" height="12" border="0" >
					&nbsp;&nbsp;<b>
						<a href="javascript:openSiteReportCenter( 0 )">센터목록</a> 
						>
						<a href="javascript:openSiteReportCenter( ${title_team_center } )">${title_center_name}</a>
						> 
						<font color="blue">${title_team_name}</font>
					</b>
					<!-- 초과율 그래프 추가 -->
					<c:if test="${not empty memberSiteResult}">
					<a href="javascript:openPopGraph('team_sel');">
					<img src="./resources/chart/chart_text_icon.png" title="초과율 그래프">
					</a>
					</c:if>
				</div>			
				<div style="text-align: right;">					
					<a href="javascript:openSiteReportTeam( 0 )" class="btn-vacation-list-ins" title="팀 목록으로 이동합니다.">팀 목록</a>&nbsp;					
					<a href="./getSiteReportAll" class="btn-vacation-list-ins" title="현장보고서 제출현황 전체페이지로 이동합니다." style="background:#A9D0F5;">바로가기</a>								
				</div>
			</div>			
			<div class="tableStyle2" style="width: 950px;">
				<table>
					<tr>
						<th width="15%" rowspan="2">이름</th>
						<th width="15%" rowspan="2">수임</th>
						<th width="20%" colspan="2">제출</th>
						<th width="20%" colspan="2">미제출</th>
						<th width="6%" rowspan="2">초과율</th>
						<th width="16%" rowspan="2">수임 후 현장보고서<br/>1개월 초과 미제출</th>
						<th width="8%" rowspan="2">평균처리일</th>												
					</tr>						
					<tr>
						<th>3영업일이내</th>
						<th>3영업일초과</th>
						<th>3영업일이내</th>
						<th>3영업일초과</th>
					</tr>		
					<c:forEach items="${memberSiteResult}" var="item" varStatus="status">					
					<tr>
						<td><a href="javascript:openSiteMemberReport('${item.user_no}','suimCnt','${item.end_average_cnt}')">${item.user_name}</a></td>
						<td><a href="javascript:openSiteMemberReport('${item.user_no}','suimCnt','${item.end_average_cnt}')">${item.suim_cnt}</a></td>
						<td><a href="javascript:openSiteMemberReport('${item.user_no}','sub3In','${item.end_average_cnt}')">${item.sub_3_in_cnt }</a></td>
						<td><a href="javascript:openSiteMemberReport('${item.user_no}','sub3Over','${item.end_average_cnt}')">${item.sub_3_over_cnt}</a></td>
						<td><a href="javascript:openSiteMemberReport('${item.user_no}','not3In','${item.end_average_cnt}')">${item.not_3_in_cnt}</a></td>
						<td><a href="javascript:openSiteMemberReport('${item.user_no}','not3Over','${item.end_average_cnt}')">${item.not_3_over_cnt}</a></td>
						<td>${item.over_per} %</td>
						<td><a href="javascript:openSiteMemberReport('${item.user_no}','not30Over','${item.end_average_cnt}')">${item.not_30_over_cnt}</a></td>
						<td><a href="javascript:openSiteMemberReport('${item.user_no}','endAverage','${item.end_average_cnt}')">${item.end_average_cnt}</a></td>					
					</tr>
						<c:set var="sum_suim_cnt" value="${sum_suim_cnt + item.suim_cnt}"/>
						<c:set var="sum_sub_3_in_cnt" value="${sum_sub_3_in_cnt + item.sub_3_in_cnt}"/>
						<c:set var="sum_sub_3_over_cnt" value="${sum_sub_3_over_cnt + item.sub_3_over_cnt}"/>
						<c:set var="sum_not_3_in_cnt" value="${sum_not_3_in_cnt + item.not_3_in_cnt}"/>
						<c:set var="sum_not_3_over_cnt" value="${sum_not_3_over_cnt + item.not_3_over_cnt}"/>						
						<c:set var="sum_not_30_over_cnt" value="${sum_not_30_over_cnt + item.not_30_over_cnt}"/>
						<c:set var="sum_end_average_cnt" value="${sum_end_average_cnt + item.end_average_cnt}"/>						
						<input type="hidden" name="all_name[]" value="['${item.user_name}','(${item.over_per}%)']"/>
						<input type="hidden" name="all_over_per[]" value="${item.over_per}"/>					
					</c:forEach>
					<tr>
						<th>합계</th>
						<th>${sum_suim_cnt}</th>
						<th>${sum_sub_3_in_cnt}</th>
						<th>${sum_sub_3_over_cnt}</th>
						<th>${sum_not_3_in_cnt}</th>
						<th>${sum_not_3_over_cnt}</th>
						<th>
							<c:choose>
								<c:when test="${sum_suim_cnt == 0}">0%</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${(sum_sub_3_over_cnt + sum_not_3_over_cnt) / sum_suim_cnt * 100}" pattern="#,###"/>%
								</c:otherwise>
							</c:choose>							
						</th>
						<th>${sum_not_30_over_cnt}</th>
						<th>
							<fmt:formatNumber value="${sum_end_average_cnt / memberSiteResult.size()}" pattern="#,###"/>
						</th>
					</tr>						
				</table>	
			</div>
		</div>
		<input type="hidden" name="all_over_per_sum" value='<fmt:formatNumber value="${(sum_sub_3_over_cnt + sum_not_3_over_cnt) / sum_suim_cnt * 100}" pattern="#,###"/>'>
		<input type="hidden" name="total_over_per" id="total_over_per" value="${total_over_per }" />
		</form>
	</c:when>
</c:choose>
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