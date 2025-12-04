<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar-rptinv.js"></script>
	<script>
		$(document).ready(function(){
			if('${mbrVo_Session.user_no}' == null || '${mbrVo_Session.user_no}'.trim() == ''){
				alert("로그아웃 상태입니다. 재로그인 하십시오.");
				window.location.assign("./logout");
			}
		});//ready

		
		function windowSet(win) { 
	        var winBody = win.document.body;
	        var wid = winBody.scrollWidth + 16;
	        var hei = winBody.clientHeight + 70;
	        
	        win.resizeTo(wid, hei);
	    }
	</script>
	
 
</head>

<body OnLoad="windowSet(this)">

<!-- wrapper -->
	<!-- contents -->
	<div id="container">
		<div class="noSitePop" style="width: 1340px !important;">
			<!-- nosite_mng_pop_cnt -->
			<div class="nosite_mng_pop_cnt" style="width: 1320px !important;">
				<div class="tArea">
					<p class="suttl">${workloadMap.user_name} 평가기준 달성도 현황</p>
					<div class="tableStyle3" style="width:100% !important;">
                        <div>
                            <table cellpadding="0" cellspacing="0" summary="team조사">
                                <tr>
                                    <th rowspan="2">담당자명</th>
                                    <th rowspan="2">센터명</th>
                                    <th rowspan="2">팀명</th>
                                    <th colspan="4">기준업무량 (누계: ${workloadMap.nowYear})</th>
                                    <th colspan="3">기준업무량 (당월: ${workloadMap.nowMonth})</th>
                                    <th rowspan="2">민원발생<br/>(건)</th>
                                    <th rowspan="2" style="letter-spacing: -2px;">보험사기 제보, 적발<br/>(건)</th>
                                </tr>
                                <tr>
                                	<th>목표(건)</th>
                                	<th>종결(건)</th>
                                	<th>달성률</th>
                                	<th>백분위(상위)</th>
                                	<th>목표(건)</th>
                                	<th>종결(건)</th>
                                	<th>달성률</th>                                	
                                </tr>
                               	<tbody>
	                               	<c:choose>
	                               		<c:when test="${workloadMap == null}">
	                               			<tr>
	                               				<td colspan="13">
	                               					표시 할 내용이 없습니다.
	                               				</td>
	                               			</tr>
			                        	</c:when>
			                        	<c:otherwise>
		                                	<tr>
	                                			<!-- 담당자명 -->
		                                		<td>${workloadMap.userName}</td>
		                                		<!-- 센터명 -->
		                                		<td>${workloadMap.mbrCenterName}</td>
		                                		<!-- 팀명 -->
		                                		<td>${workloadMap.mbrTeamName}</td>
		                                		<!-- 기준업무량-목표(건) -->
		                                		<td>
		                                			<fmt:formatNumber value="${workloadMap.purpose_workload}" pattern="0.0##"/>
	                                			</td>
		                                		<!-- 기준업무량-종결(건)-->
		                                		<td>
		                                			<fmt:formatNumber value="${workloadMap.calc_workload}" pattern="0.0##"/>
	                                			</td>
		                                		<!-- 기준업무량-달성률 -->
		                                		<td>
		                                			<c:choose>
														<c:when test="${workloadMap.calc_workload != 0 && workloadMap.purpose_workload  != 0}">
															<fmt:formatNumber value="${workloadMap.calc_workload / workloadMap.purpose_workload * 100}" pattern="0.0#"/> %
														</c:when>
														<c:otherwise>
															0.0%
														</c:otherwise>
													</c:choose>
		                                		</td>
		                                		<!-- 기준업무량-백분위(상위) -->
		                                		<td>
			                                		<c:choose>
														<c:when test="${workloadMap.rank_workload != 0 && workloadMap.workloadCnt  != 0}">
															<fmt:formatNumber value="${workloadMap.rank_workload / workloadMap.workloadCnt * 100}" pattern="0.0"/> %															
														</c:when>
														<c:otherwise>
															0.0%
														</c:otherwise>
													</c:choose>
		                                		</td>
		                                		<!-- 기준업무량(당월) 목표건 -->
		                                		<fmt:parseNumber var="m_purpose" value="${workloadMap.m_purpose_workload / 12}"></fmt:parseNumber>
		                                		<fmt:parseNumber var="m_workload" value="${workloadMap.m_calc_workload}"></fmt:parseNumber>
		                                		<td>
		                                			<fmt:formatNumber value="${m_purpose}" pattern="0.0##"/>
		                                		</td>
		                                		<!-- 기준업무량(당월) 종결건 -->
		                                		<td>
		                                			<fmt:formatNumber value="${m_workload}" pattern="0.0##"/>
		                                		</td>
		                                		<!-- 기준업무량(당월) 달성율-->
		                                		<td>
		                                			<c:choose>
														<c:when test="${m_purpose != 0 && m_workload  != 0}">
															<fmt:formatNumber value="${m_workload / m_purpose * 100}" pattern="0.0"/> %
														</c:when>
														<c:otherwise>
															0.0%
														</c:otherwise>
													</c:choose>
		                                		</td>		                                		
		                                		<!-- 민원발생(건) -->
		                                		<td>${workloadMap.minwonCnt}</td>
		                                		<!-- 보험사기 제보, 적발(건) -->
		                                		<td>${workloadMap.moralCnt}</td>
		                                	</tr>
			                        	
			                        	</c:otherwise>
	                                </c:choose>
                                </tbody>
                            </table>
                        </div>
					</div><!-- //tableStyle3  -->
				</div><!-- //tArea -->
			</div><!-- //nosite_mng_pop_cnt -->
		</div><!-- //contetns -->
	</div><!-- //contents -->
</body>
</html>
 