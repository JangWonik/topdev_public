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
		
		.buttonAssistanceEmail{
			width:120px;
			height:50px;
		    background-color:darkCyan;
		    color:#FFFFFF;
		    text-align: center;
			border-radius:5px;
		    font-size: 15px;
		    font-weight: bold;
		    cursor: pointer;
		    text-decoration:none;
		    border: none;
		}
	</style>	
		<div style="text-align:right;padding-bottom:5px;">
			<img src="./resources/ls_img/ls_invoice/btn_excel.gif" style='cursor:pointer;' id="approvalAllexcelBtn" />
		</div>
							<div class= "tableStyle2" style="border-top: 0px;">
								<!-- search-box -->
								<form id="searchFrm" action="vacationApproval" method="POST">
									<input type="hidden" id="view_type" name="view_type" value="search" />
									<input type="hidden" id="pageIdxSearch" name="pageIdxSearch" />
									<input type="hidden" id="srchApDateOrder" name="srchApDateOrder" value="${srchApDateOrder}"/>									
									<div id="search-box"  align="center">
										<table style="width: 100%;" align="center">											
											<tr>
												<th width="10%">조회년도</th>
												<td width="13%">
													<!-- 현재부터 2018년까지로 변경 by top3009-->											
													<jsp:useBean id="now" class="java.util.Date" />
													<fmt:formatDate value="${now}" pattern="yyyy" var="yearVar"/>																	 
													<select id="srchYear" name="srchYear" style="width: 156px;">	
														<option value="99" <c:if test="${srchYear eq '99'}">selected</c:if> >- 전체 -</option>																		
														<c:forEach begin="0" end="${yearVar-2018}" var="result" step="1">
															<option value="${yearVar - result}" <c:if test="${srchYear == (yearVar-result) }">selected="selected"</c:if>>${yearVar-result} 년</option>							
														</c:forEach>
													</select>
													<!-- 현재부터 2018년까지로 변경 끝 by top3009-->													
												</td>
												<th width="10%">휴가종류</th>
												<td width="13%">
													<select id="srchKind" name="srchKind" style="width: 156px;">
														<option value="99">- 전체 -</option>
														<c:forEach items="${vacationKindList}" var="item" varStatus="status">
															<c:choose>
																<c:when test="${srchParam.srchKind == item.vacation_code}">
																	<option value="${item.vacation_code}" selected="selected">${item.vacation_type}</option>
																</c:when>
																<c:otherwise>
																	<option value="${item.vacation_code}">${item.vacation_type}</option>
																</c:otherwise>
															</c:choose>													
														</c:forEach>
													</select>											
												</td>
												<th width="10%">결재상태</th>
												<td width="11%">
													<select id="srchState" name="srchState" style="width: 126px;">
														<option value="00">- 전체 -</option>
														<c:forEach items="${vacationStateList}" var="item" varStatus="status">
															<c:choose>
																<c:when test="${srchParam.srchState == item.approval_code}">
																	<option value="${item.approval_code}" selected="selected">${item.approval_val}</option>
																</c:when>
																<c:otherwise>
																	<option value="${item.approval_code}">${item.approval_val}</option>
																</c:otherwise>
															</c:choose>		
														</c:forEach>	
													</select>												
												</td>
												<th width="10%">이름</th>
												<td width="11%">
													<input type="text" id="srchUserName" name="srchUserName" value="${srchParam.srchUserName }"/>
												</td>
												<td rowspan="2">
													<a href="#"><input type="button" value="검 색" class="buttonAssistanceEmail" id="approval-all-btn-search"></a>
												</td>												
											</tr>											
											<tr>
												<th>본부구분</th>
												<td>
													<select id="srchTeamType" name="srchTeamType" style="width: 156px;">
														<c:choose>														
															<c:when test="${pms28 eq 1}">
																<option value="1">물보험본부</option>
															</c:when>
															<c:when test="${pms28 eq 4}">
																<option value="4">인보험본부</option>
															</c:when>
															<c:otherwise>
																<option value="5" <c:if test="${srchTeamType eq 5}">selected</c:if> >- 전체 -</option>
																<option value="1" <c:if test="${srchTeamType eq 1}">selected</c:if> >물보험본부</option>
																<option value="4" <c:if test="${srchTeamType eq 4}">selected</c:if> >인보험본부</option>
															</c:otherwise>															
														</c:choose>														
													</select>													
												</td>
												<th>부서명</th>
												<td>
													<span style="text-align: left !important;">
														<select id="srchTeamId" name="srchTeamId" style="width: 156px;">
															<option value="0">- 전체 -</option>
															<c:forEach items="${teamList}" var="teamVo">
																<c:choose>
																	<c:when test="${srchParam.srchTeamId == teamVo.team_id}">
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
												<th>휴가기간</th>
												<td colspan="3">
													<input type="text" class="classCalendar" id="srch_sdate" name="srch_sdate" style="width: 100px;" value="${srch_sdate}"> ~ 
													<input type="text" class="classCalendar" id="srch_edate" name="srch_edate" style="width: 100px;" value="${srch_edate}">
												</td>																																				
											</tr>
										</table>
										<br/>
									</div> 
								</form>									
																								
								<table>									
									<thead>
										<tr>											
											<th width="4%">No.</th>
											<th width="8%">센터명</th>
											<th width="8%">부서명</th>
											<th width="7%">이름</th>											
											<th width="6%">신청일</th>
											<th width="6%">											
												<c:choose>
													<c:when test="${srchApDateOrder == 'DESC' }"><a href="javascript:doApDateOrder('ASC');" style="color:blue;">결재일▼</a></c:when>
													<c:when test="${srchApDateOrder == 'ASC' }"><a href="javascript:doApDateOrder('99');" style="color:blue;">결재일▲</a></c:when>
													<c:otherwise><a href="javascript:doApDateOrder('DESC');" style="color:blue;">결재일</a></c:otherwise>
												</c:choose>											
											</th>
											<th width="6%">종류</th>
											<th width="10%">기간</th>
											<th width="5%">결재 전<br/>잔여일</th>											
											<th width="4%">사용일</th>											
											<th width="4%">차감일</th>
											<th width="10%">사유</th>											
											<th width="7%">상태</th>
											<th width="7%">현재결재자</th>
											<th width="8%">비고</th>											
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${approvalList.size() != 0}">
												<c:forEach items="${approvalList}" var="item" varStatus="status">
													<tr>														
														<td class="td-overflow-none">${pageInfo.totalRecordCount - (pageInfo.recordCountPerPage * (pageInfo.currentPageNo-1)) - status.index}</td>														
														<td class="td-overflow-none">${item.center_name}</td>
														<td class="td-overflow-none">${item.team_name}</td>
														<td class="td-overflow-none">${item.user_name}</td>
														<td class="td-overflow-none">${item.regdate}</td>
														<td class="td-overflow-none">${item.approve_date}</td>
														<td class="td-overflow-none">${item.vacation_type_val}</td>
														<td class="td-overflow-none">${item.sdate} ~ ${item.edate}</td>
														<td class="td-overflow-none">
															<c:choose>
																<c:when test="${item.remain_vacation_use == 0}">
																	<fmt:formatNumber value="${item.annual_set - item.annual_use}" pattern="0.00"/>
																</c:when>
																<c:otherwise>
																	<fmt:formatNumber value="${item.remain_vacation_use}" pattern="0.00"/>
																</c:otherwise>
															</c:choose>
															<%-- <fmt:formatNumber value="${item.annual_set}" pattern="0.00"/> --%>
															 일
														</td>
														<td class="td-overflow-none">${item.vacation_interval} 일</td>
														<td class="td-overflow-none">
															<c:choose>
																<c:when test="${item.vacation_type eq 100 or item.vacation_type eq 200 or item.vacation_type eq 210}">
																	${item.vacation_interval} 일
																</c:when>
																<c:otherwise>
																	0 일
															</c:otherwise>
															</c:choose>															
														</td>														
														<td class="td-overflow-none">${item.vacation_content}</td>
														<td class="td-overflow-none">${item.approval_state_val}</td>
														<td class="td-overflow-none"> 
															<c:choose>
																<c:when test="${item.ap_date_01 ne '' and item.approval_state eq 31}">인사팀</c:when>
																<c:otherwise>
																	<c:if test="${mbrVo_Session.user_state eq 9 and (item.approvaler_01 ne 99991 and item.approvaler_01 ne 99994)}">
																		<img src="./resources/ls_img/ls_invoice/btn_s_edite.gif" style="cursor:pointer;"	onclick="updateNowApproval('${item.serial_no}')" title="결재자 수정하기" />
																	</c:if>
																	${item.approvaler_now_name}																	
																</c:otherwise>
															</c:choose>
															<%--																														
															<c:choose>
																<c:when test="${item.approval_state eq 30 or item.approval_state eq 31 or item.approval_state eq 32}">인사팀</c:when>
																<c:otherwise>
																	<c:if test="${mbrVo_Session.user_state eq 9 and (item.approvaler_01 ne 99991 and item.approvaler_01 ne 99994)}">
																		<img src="./resources/ls_img/ls_invoice/btn_s_edite.gif" style="cursor:pointer;"	onclick="updateNowApproval('${item.serial_no}')" title="결재자 수정하기" />
																	</c:if>																	
																	${item.approvaler_now_name}
																</c:otherwise>
															</c:choose>
															 --%>											
														</td>
														<td class="td-overflow-none">
															<a href="#noloc" class="btn-vacation-aprv" id="btn-detail" onclick="openDetailView(${item.serial_no})" style="width: 58px;">상세보기</a>
														</td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr>
													<td colspan="15">
														검색된 휴가내역이 없습니다.
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
						        	<c:import url="/page_navi_vacation_search">
						            	<c:param name="beginIdx" value="${pageInfo.firstPageNoOnPageList}"/>
						                <c:param name="endIdx" value="${pageInfo.lastPageNoOnPageList}"/>
						                <c:param name="currentIdx" value="${pageInfo.currentPageNo}"/>
						                <c:param name="totalPageCnt" value="${pageInfo.totalPageCount}"/>						                
									</c:import>
							</div>							
						
						<script>
							var vacationNoArr = new Array();	
						
							$(document).ready(function(){
								_initBtn();
								$("#srchTeamId").select2();
								$("#srchYear").select2();
								$("#srchKind").select2();
								$("#srchState").select2();
								$("#srchTeamType").select2();		
								$("#srchAnnualTeamId").select2();
								$("#srchAnnualYear").select2();								
								$("#srchAnnualTeamType").select2();
								$("#srchUserState").select2();
							});

							function doApDateOrder( p_order ){
								$("#srchApDateOrder").val( p_order );
								$("#approval-all-btn-search").click();
							}
						</script>
