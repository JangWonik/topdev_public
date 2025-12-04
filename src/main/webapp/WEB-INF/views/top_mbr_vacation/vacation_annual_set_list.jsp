<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
	<style>
		.td-overflow-none{
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
		}
		
		.btn-vacation-aprv {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:5px;
			-webkit-border-radius:5px;
			border-radius:5px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:12px;
			color:#696969  !important;
			width:60px;
			height:0px;
			padding:10px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
		}

		.btn-vacation-aprv:active {
			position:relative;
			top:4px
		}
		
		/* 모달 버튼 */
		.ui-button-text-only {
			height:2.1em !important;
		}
	</style>	
							<div class= "tableStyle2" style="border-top: 0px;">
								<!-- search-box -->
								<form id="annualFrm" action="vacationApproval" method="POST">
									<input type="hidden" id="view_type" name="view_type" value="annual" />
									<input type="hidden" id="pageIdxAnnual" name="pageIdxAnnual" />																		
									<div id="search-box"  align="center">
										<table style="width: 100%;" align="center">											
											<tr>
												<th width="10%">연차 부여년도</th>
												<td width="15%">
													<!-- 현재부터 2018년까지로 변경 by top3009-->											
													<jsp:useBean id="now" class="java.util.Date" />
													<fmt:formatDate value="${now}" pattern="yyyy" var="yearVar"/>																	 
													<select id="srchAnnualYear" name="srchAnnualYear" style="width: 156px;">	
														<option value="99" <c:if test="${srchAnnualYear eq '99'}">selected</c:if> >- 전체 -</option>
														<option value="9999" <c:if test="${empty srchAnnualYear or srchAnnualYear eq '9999'}">selected</c:if> >현재사용중인연차</option>																		
														<c:forEach begin="0" end="${yearVar-2018}" var="result" step="1">
															<option value="${yearVar - result}" <c:if test="${srchAnnualYear == (yearVar-result) }">selected="selected"</c:if>>${yearVar-result} 년</option>							
														</c:forEach>
													</select>
													<!-- 현재부터 2018년까지로 변경 끝 by top3009-->																										
												</td>
												<th width="10%">본부구분</th>
												<td width="15%">
													<select id="srchAnnualTeamType" name="srchAnnualTeamType" style="width: 156px;">
														<c:choose>														
															<c:when test="${pms28 eq 1}">
																<option value="1">물보험본부</option>
															</c:when>
															<c:when test="${pms28 eq 4}">
																<option value="4">인보험본부</option>
															</c:when>
															<c:otherwise>
																<option value="5" <c:if test="${srchAnnualTeamType eq 5}">selected</c:if> >- 전체 -</option>
																<option value="1" <c:if test="${srchAnnualTeamType eq 1}">selected</c:if> >물보험본부</option>
																<option value="4" <c:if test="${srchAnnualTeamType eq 4}">selected</c:if> >인보험본부</option>
															</c:otherwise>															
														</c:choose>														
													</select>													
												</td>
												<th width="10%">부서명</th>
												<td width="18%">
													<span style="text-align: left !important;">
														<select id="srchAnnualTeamId" name="srchAnnualTeamId" style="width: 180px;">
															<option value="0">- 전체 -</option>
															<c:forEach items="${teamList}" var="teamVo">
																<c:choose>
																	<c:when test="${srchAnnualTeamId == teamVo.team_id}">
																		<option value="${teamVo.team_id}" selected="selected">
																	</c:when>
																	<c:otherwise>
																		<option value="${teamVo.team_id}">
																	</c:otherwise>
																</c:choose>																
																	<c:if test="${teamVo.team_level == 1}">&nbsp;└</c:if>
																	<c:if test="${teamVo.team_level == 2}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
																	${teamVo.team_name}																
															</c:forEach>
														</select>
													</span>
												</td>
												<td rowspan="2" width="9%">													
													<!-- <a href="#noloc" class="btn-vacation-aprv" id="btn-search" onclick='doSearch();'>검색</a> -->
													<a href="#"><input type="button" value="검 색" class="buttonAssistanceEmail" id="btn-search"  onclick='doSearch();'></a>													
												</td>												
											</tr>
											<tr>
												<th>재직상태</th>
												<td>
													<select id="srchUserState" name="srchUserState" style="width: 156px;">																											
														<option value="99" <c:if test="${srchUserState eq '99'}">selected</c:if> >- 전체 -</option>
														<option value="0" <c:if test="${srchUserState eq '0'}">selected</c:if>>근무자</option>
														<option value="2" <c:if test="${srchUserState eq '2'}">selected</c:if>>대기자</option>
														<option value="1"<c:if test="${srchUserState eq '1'}">selected</c:if>>퇴사자</option>
														<option value="9" <c:if test="${srchUserState eq '9'}">selected</c:if>>SA</option>													
													</select>													
												</td>
												<th>이름</th>
												<td>
													<input type="text" id="srchUserName" name="srchUserName" value="${srchParam.srchUserName }" style="width:152px;"/>
												</td>
												<td colspan="2">※ 기간경과율과 현재사용율이 <font style="font-weight:bold;color:blue;">30%</font> 이상 차이나는 경우 <font style="font-weight:bold;color:red;">적색</font>으로 표시됩니다.</td>																																				
											</tr>												
										</table>										
									</div> 
								</form>									
								<div style="text-align:right;padding:5px 0 5px 0;">
									<img id="exceldown" src="/resources/ls_img/btn_excel.gif" alt="엑셀다운로드" onclick="javascript:doDownLoad();" style="cursor:pointer;"/>
								</div>																
								<table>									
									<thead>
										<tr>											
											<th width="5%">No.</th>
											<th width="10%">센터명</th>
											<th width="10%">부서명</th>
											<th width="10%">이름</th>
											<th width="6%">직급</th>
											<th width="8%">입사일</th>
											<th width="8%">사용시기<br/>(부여일)</th>
											<th width="8%">사용종기</th>
											<th width="5%">기간<br/>경과율</th>
											<th width="5%">현재<br/>사용율</th>
											<th width="5%">연차<br/>부여일</th>
											<th width="5%">사용일</th>
											<th width="5%">잔여일</th>
											<th width="10%">비고</th>											
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${vacationUseList.size() != 0}">
												<c:forEach items="${vacationUseList}" var="item" varStatus="status">
													<tr>														
														<td class="td-overflow-none">${pageInfo.totalRecordCount - (pageInfo.recordCountPerPage * (pageInfo.currentPageNo-1)) - status.index}</td>														
														<td class="td-overflow-none">${item.center_name}</td>
														<td class="td-overflow-none">${item.team_name}</td>
														<td class="td-overflow-none">${item.user_name}</td>
														<td class="td-overflow-none">${item.work_level_nm}</td>
														<td class="td-overflow-none">${item.join_date}</td>
														<td class="td-overflow-none">${item.annual_start_date}</td>
														<td class="td-overflow-none">${item.annual_end_date}</td>
														<td class="td-overflow-none"><fmt:formatNumber value="${item.day_progress}" pattern="##.#"/> %</td>
														<c:set var="per_interval" value="${item.day_progress - item.vacation_progress}"></c:set>														
														<c:choose>
															<c:when test="${per_interval > 30 or per_interval < -30}">
																<td class="td-overflow-none"><font style="font-weight:bold;color:red;"><fmt:formatNumber value="${item.vacation_progress}" pattern="##.#"/> %</font></td>
															</c:when>
															<c:otherwise>																
																<td class="td-overflow-none"><font style="font-weight:bold;color:blue;"><fmt:formatNumber value="${item.vacation_progress}" pattern="##.#"/> %</font></td>		
															</c:otherwise>
														</c:choose>																												
														<td class="td-overflow-none">${item.annual_set}</td>
														<td class="td-overflow-none">${item.annual_use}</td>														
														<td class="td-overflow-none"><%-- ${item.annual_set - item.annual_use} --%><fmt:formatNumber value="${item.annual_set - item.annual_use}" pattern="0.00"/></td>
														<td>
															<a href="#noloc" class="btn-vacation-aprv" id="btn-detail" onclick="openVacationView('${item.user_no}','${item.user_name}','${item.annual_start_date}','${item.annual_end_date}')" style="width: 58px;">상세보기</a>															
														</td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr>
													<td colspan="14">
														검색된 직원이 없습니다.
													</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
							<input type="hidden" id="currPageIdx" value="${pageInfo.currentPageNo}"/>
							<div class="pagingWrap">
						    	<%--<div class="pageContent">--%>
						        	<c:import url="/page_navi_vacation_annual">
						            	<c:param name="beginIdx" value="${pageInfo.firstPageNoOnPageList}"/>
						                <c:param name="endIdx" value="${pageInfo.lastPageNoOnPageList}"/>
						                <c:param name="currentIdx" value="${pageInfo.currentPageNo}"/>
						                <c:param name="totalPageCnt" value="${pageInfo.totalPageCount}"/>						                
									</c:import>
							</div>
<script>
	function doDownLoad(){
		$("#annualFrm").attr('action','vacationAnnualSetAllExcel');
		$("#annualFrm").submit();
	}
	
	function doSearch(){
		$("#annualFrm").attr('action','vacationApproval');
		$("#annualFrm").submit();
	}
</script>