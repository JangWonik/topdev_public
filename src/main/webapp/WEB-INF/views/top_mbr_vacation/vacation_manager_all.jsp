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
	<!-- 휴가신청 폼 시작 -->
	<form id="vacationActionFrm">	
		<!-- 기존 파라미터 시작 -->
		<input type="hidden" id="vacation_user_no"  name="vacation_user_no" />
		<input type="hidden" id="vacation_team_id" name="vacation_team_id" />
		<input type="hidden" id="vacation_team_type" name="vacation_team_type" />
		<input type="hidden" id="vacation_year" name="vacation_year" value="${srchParam.year}" />
		<input type="hidden" id="vacation_remain_cnt" name="vacation_remain_cnt" value="${11 - srchParam.vacationUseCnt}" />		
		<input type="hidden" id="vacation_cnt" name="vacation_cnt" value="0" />		
		<input type="hidden" id="vacation_mod_no" name="vacation_mod_no" value=""/>
		<input type="hidden" id="vacation_mod_state" name="vacation_mod_state" />
		<!-- 기존 파라미터 끝 -->
		<!-- 신규 파라미터 시작 -->
		<input type="hidden" id="checkedVacationVal" name="checkedVacationVal" />
		<input type="hidden" id="vacationIntervalVal" name="vacationIntervalVal" />
		<input type="hidden" id="vacationAnnualSetVal" name="vacationAnnualSetVal"/>
		<input type="hidden" id="vacationAnnualUseVal" name="vacationAnnualUseVal"/>
		<input type="hidden" id="vacationAnnualRemainVal" name="vacationAnnualRemainVal"/>		
		<input type="hidden" id="approval_state" name="approval_state"/>	
		<input type="hidden" id="vacation_serial_no" name="vacation_serial_no"/>
		<input type="hidden" id="vacation_basedate" name="vacation_basedate"/>
		<input type="hidden" id="vacation_type" name="vacation_type"/>
		<input type="hidden" id="notApproval" name="notApproval" value="${notApproval}"/>
		<!-- 선연차 사용 플래그 추가 by top3009 -->
		<input type="hidden" id="next_use" name="next_use" value="0"/>				
		<!-- 신규 파라미터 끝 -->
					
		<!-- 수정후 신규 파라미터 시작 -->
		<!-- 기본(1차결재자) -->
		<input type="hidden" id="approvaler_01" name="approvaler_01" />
		<input type="hidden" id="approvaler_03" name="approvaler_03" />
		<!-- 결재자유무(1:최종결재단계로 넘어감, 0:결재1차) -->
		<!-- 1차결재 없이 최종단계로 넘긴다. -->
		<input type="hidden" id="pass_approval" name="pass_approval" value="1"/>		
		<!-- 수정후 신규 파라미터 끝 -->
		<div id="vacation-manager-dialog" title="휴가 신청" style="font-size: 15px;display:none;" align="center">
			<br/>
			<div class="tableStyle2" style="width: 700px;">
				<table class="vacation-ins-table">					
					<tbody>					
						<tr id="vacation_state">
							<th>결재상태</th>
							<td style="text-align:left;padding-left: 30px;font-weight:bold;" colspan="4">
								<span id="vacation_state_val"></span>
							</td>											
						</tr>						
						<tr class="tr_vacation_add">
							<th>신청자</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">								
								<span id="ap_user_info"></span>
							</td>							
						</tr>
						
						<tr class="tr_vacation_add">
							<th>휴가안내</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">								
								<span id="vacation_info_text"><b>연차</b> : 1일 유급휴가 </span>
							</td>							
						</tr>
						
						<tr class="tr_vacation_add">
							<th>일반휴가</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<input type="radio" name="vacation_kind" id="vacation_kind_0" value="100" checked="checked"> 연차 &nbsp;
								<input type="radio" name="vacation_kind" id="vacation_kind_1" value="200"> 반차
							</td>
						</tr>
						
						<tr class="tr_vacation_add">
							<th>경조휴가</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<input type="radio" name="vacation_kind" id="vacation_kind_2" value="301"> 결혼 &nbsp;
								<input type="radio" name="vacation_kind" id="vacation_kind_3" value="302"> 회갑 &nbsp;
								<input type="radio" name="vacation_kind" id="vacation_kind_4" value="303"> 사망 &nbsp;
								<input type="radio" name="vacation_kind" id="vacation_kind_5" value="304"> 탈상 &nbsp;
								<!-- <input type="radio" name="vacation_kind" id="vacation_kind_6" value="305"> 기타 &nbsp; -->
							</td>
						</tr>
						
						<tr class="tr_vacation_add">
							<th>출산휴가</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<input type="radio" name="vacation_kind" id="vacation_kind_7" value="400"> 배우자출산 &nbsp;
								<input type="radio" name="vacation_kind" id="vacation_kind_8" value="500"> 출산전&middot;후 &nbsp;
								<input type="radio" name="vacation_kind" id="vacation_kind_9" value="600"> 유&middot;사산 &nbsp;
							</td>
						</tr>
						
						<tr class="tr_vacation_add">
							<th>특별휴가</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<input type="radio" name="vacation_kind" id="vacation_kind_10" value="700"> 예비군(민방위)
							</td>
						</tr>
						
						<tr class="tr_vacation_view">
							<th>휴가종류</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<span id="vacation_kind_val"></span>
							</td>
						</tr>						
						
						<tr id="tr_vacation_file" style="display: none;">
							<th>증적자료첨부</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<span id="file_down_span">
									<a href="/" >
										<span id="file_name"></span>
									</a>
									&nbsp;<img class="btn_file_del" src="./resources/ls_img/btn_del_s.gif" alt="삭제" style="cursor:pointer" />							
								</span>
								<span id="file_up_span">
									<input type="file" id="vacation_file" name="vacation_file" style="width: 90%;">
								</span>
							</td>
						</tr>
						
						<tr class="tr_vacation_file_view">
							<th>증적자료첨부</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<a href="/" ><span id="file_name_val"></span></a>
							</td>
						</tr>
						
						<tr class="tr_vacation_add">
							<th>사유</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<input type="text" id="vacation_comment" name="vacation_comment" style="width:480px;" />
								<br/>
								<font color="red"><b>※ 사유 간략히 기재, 단 "월차","정기휴가" 라고 입력하지 말 것</b></font>
							</td>
						</tr>
						<tr class="tr_vacation_view">
							<th>사유</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<span id="vacation_comment_val"></span>								
							</td>
						</tr>											
						<tr class="tr_vacation_add">
							<th>기간</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<input type="text" class="classCalendar" id="vacation_start_date" name="vacation_start_date" style="width: 100px;"/>
								&nbsp;~&nbsp;
								<input type="text" class="classCalendar" id="vacation_end_date" name="vacation_end_date" style="width: 100px;"/>
								&nbsp; <font style="font-weight:bold;color:blue;">( <span id="vacation_interval">0</span> ) 일간</font> &nbsp;저장시 주휴일은 자동으로 제외됩니다.
								<span id="overDay" style="padding-top: 10px;"></span>
							</td>
						</tr>
						<tr class="tr_vacation_view">
							<th>기간</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<span id="vacation_start_date_val"></span>&nbsp;~&nbsp;<span id="vacation_end_date_val"></span>								
								&nbsp; <font style="font-weight:bold;color:blue;">( <span id="vacation_interval_val">0</span> ) 일간</font>
							</td>
						</tr>
						
						<tr class="tr_vacation_add">
							<th rowspan="2">연차정보<br/><br/>(<span id="ap_base_year"></span> 년)</th>
							<th>연차 부여일</th>
							<th>연차 사용일</th>
							<th>연차 잔여일</th>
							<th>연차신청 후 잔여일</th>
						</tr>
						<tr class="tr_vacation_add">
							<td><span id="ap_annual_set"></span> 일</td>
							<td><span id="ap_annual_use"></span> 일</td>
							<td><span id="ap_annual_remain"></span> 일</td>
							<td><font style="font-weight:bold;color:blue;"><span id="vacation_interval_cal">0</span> 일</font></td>
						</tr>
						
						<tr class="tr_vacation_view">
							<th rowspan="2">연차정보<br/><br/>(${vacation.base_year} 년)</th>
							<th>연차 부여일</th>
							<th>연차 사용일</th>
							<th>연차 잔여일</th>
							<th>휴가신청일</th>							
						</tr>
						<tr class="tr_vacation_view">
							<td>${vacation.annual_set} 일</td>
							<td>${vacation.annual_use} 일</td>
							<td>${vacation.annual_set - vacation.annual_use} 일</td>
							<td><font style="font-weight:bold;color:blue;"><span id="vacation_interval_info">0</span> 일</font></td>							
						</tr>
						
						<tr  class="tr_vacation_add">
							<th rowspan="2">결재</th>
							<th colspan="4">최종 확인</th>	
							<%-- <c:choose>
								<c:when test="${pass_approval eq '1'}">
									<th colspan="4">최종 확인</th>
								</c:when>
								<c:otherwise>
									<th colspan="2">결재자</th>							
									<th colspan="2">최종 확인</th>	
								</c:otherwise>
							</c:choose>			 --%>
						</tr>
						<tr  class="tr_vacation_view">
							<th rowspan="2">결재</th>
							<th colspan="4">최종 확인</th>
							<%-- <c:choose>
								<c:when test="${pass_approval eq '1'}">
									<th colspan="4">최종 확인</th>
								</c:when>
								<c:otherwise>
									<th colspan="2">결재자</th>							
									<th colspan="2">최종 확인</th>	
								</c:otherwise>
							</c:choose> --%>																					
						</tr>
						<tr>
							<td colspan="4">
								<span id="approvaler_name_01"></span>
							</td>
							<%-- <c:choose>
							최종결재자만 표시되는 경우
							<c:when test="${pass_approval eq '1' }">
								<td colspan="4">
									<c:choose>
										<c:when test="${approvalList3.size() > 0}">
											인사총무팀											
										</c:when>
										<c:otherwise>
											최종 확인자가 없습니다.
										</c:otherwise>
									</c:choose>
								</td>
							</c:when>
							<c:otherwise>
								결재자								
								<td colspan="2">
									<span id="approvaler_name_01"></span>
								</td>
								최종결재자
								<td colspan="2">인사총무팀</td>
							</c:otherwise> 
						</c:choose>--%>			
						</tr>
						<tr id="return_comment_tr" style="display: none;">
							<th>결재 내역</th>
							<td  style="text-align:left;padding-left: 30px;" id="return_comment"  colspan="4"></td>
						</tr>						
					</tbody>																																																							
				</table>
			</div>
		</div>
	</form>	
	<!-- 휴가신청 폼 끝 -->
	
		<div class= "tableStyle2" style="border-top: 0px;padding-bottom:5px;" align="left">
			<table>
				<tr>
					<th height="25px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0"> 신청자</th>
					<td colspan="2">
						<select id="srchUserList" name="srchUserList" style="width: 334px;">
							<option value="0" <c:if test="${srchUserList eq 0}">selected</c:if> >- 선택하세요 -</option>
							<c:forEach items="${ApUserList}" var="apUserVo">
								<option value="${apUserVo.user_no}">${apUserVo.user_name} [${apUserVo.team_name}]
									<c:if test="${apUserVo.user_state eq 1}">[퇴사자]</c:if>
								</option>
							</c:forEach>							
						</select>
					</td>
					<td colspan="4" style="text-align:left;padding-left:10px;">
						<a href="#noloc" class="btn-vacation-list-ins" id="btn-vacation-list-ins">휴가 신청</a>
					</td>					
				</tr>
			</table>
		</div>
			
		<!-- <div style="text-align:right;padding-bottom:5px;">
			<img src="./resources/ls_img/ls_invoice/btn_excel.gif" style='cursor:pointer;' id="approvalAllexcelBtn" />
		</div> -->
							<div class= "tableStyle2" style="border-top: 0px;">
								<!-- search-box -->
								<form id="searchFrm" action="vacationManager" method="POST">
									<input type="hidden" id="view_type" name="view_type" value="search" />
									<input type="hidden" id="pageIdxSearch" name="pageIdxSearch" />									
									<div id="search-box"  align="center">
										<table style="width: 100%;" align="center">											
											<tr>
												<th>년도</th>
												<td>
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
												<th>종류</th>
												<td>
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
												<th>상태</th>
												<td>
													<select id="srchState" name="srchState" style="width: 156px;">
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
												<td rowspan="2">
													<a href="#noloc" class="btn-vacation-aprv" id="approval-all-btn-search">검색</a>
												</td>												
											</tr>											
											<tr>
												<th>구분</th>
												<td>
													<select id="srchTeamType" name="srchTeamType" style="width: 156px;">
														<c:choose>														
															<c:when test="${pms34 eq 1}">
																<option value="1">물보험본부</option>
															</c:when>
															<c:when test="${pms34 eq 4}">
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
												<th>부서</th>
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
												<th>이름</th>
												<td>
													<input type="text" id="srchUserName" name="srchUserName" value="${srchParam.srchUserName }"/>
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
											<th width="7%">신청일</th>
											<th width="6%">종류</th>
											<th width="10%">기간</th>
											<th width="5%">결재 전<br/>잔여일</th>
											<th width="5%">사용일</th>
											<th width="5%">차감일</th>
											<th width="10%">사유</th>
											<th width="10%">상태</th>
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
														<td class="td-overflow-none">${item.vacation_type_val}</td>
														<td class="td-overflow-none">${item.sdate} ~ ${item.edate}</td>
														<td class="td-overflow-none"><fmt:formatNumber value="${item.annual_set}" pattern="0.00"/> 일</td>
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
																<c:when test="${item.approval_state eq 30 or item.approval_state eq 31 or item.approval_state eq 32}">인사팀</c:when>
																<c:otherwise>																																		
																	${item.approvaler_now_name}
																</c:otherwise>
															</c:choose>											
														</td>
														<td class="td-overflow-none">
															<a href="#noloc" class="btn-vacation-aprv" id="btn-detail" onclick="openDetailView(${item.serial_no})" style="width: 58px;">상세보기</a>
														</td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr>
													<td colspan="14">
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
						        	<c:import url="/page_navi_vacation_manager_search">
						            	<c:param name="beginIdx" value="${pageInfo.firstPageNoOnPageList}"/>
						                <c:param name="endIdx" value="${pageInfo.lastPageNoOnPageList}"/>
						                <c:param name="currentIdx" value="${pageInfo.currentPageNo}"/>
						                <c:param name="totalPageCnt" value="${pageInfo.totalPageCount}"/>						                
									</c:import>
							</div>							
						
						<script>
							var vacationNoArr = new Array();	
						
							$(document).ready(function(){								
								$("#srchTeamId").select2();
								$("#srchYear").select2();
								$("#srchKind").select2();
								$("#srchTeamType").select2();		
								$("#srchAnnualTeamId").select2();
								$("#srchAnnualYear").select2();								
								$("#srchAnnualTeamType").select2();
								$("#srchUserState").select2();
								$("#srchState").select2();								
								
								//신청자 선택상자
								$("#srchUserList").select2();
								
								//휴가 신청 버튼
								$("#btn-vacation-list-ins").on("click",function(){
									var sel_user_no = $("#srchUserList").val();									
									
									if( sel_user_no == 0 ){
										alert("휴가를 신청 할 신청자를 선택해 주세요");
										return;
									}
									
									//연차신청 후 잔여일 값 초기화
									$("#vacation_interval_cal").text("0");
									
									//alert("sel_user_no="+sel_user_no);
									
									var url = "getApUserVacationInfo";
									
									//신청자정보를 가져온다.
									var param = {};
									param.user_no = sel_user_no;
									
									$.ajax({
								        type: "POST",
								        url: url,
								        data: param,
								        timeout: 20000,								        
								        dataType: "JSON", 
								        success: function(data){								        	
								        	//alert("data="+data.ap_user_no+" : "+data.ap_user_name+" : "+data.ap_team_name+" : "+data.ap_team_id);
								        	
								        	$("#vacation_user_no").val(data.ap_user_no);
								        	$("#vacation_team_id").val(data.ap_team_id);
								        	$("#vacation_team_type").val(data.ap_team_type);
								        	$("#ap_user_info").text(data.ap_user_name+" ["+data.ap_team_name+"]");
								        	
								        	$("#ap_base_year").text(data.ap_base_year);
								        	$("#ap_annual_set").text(data.ap_annual_set);
								        	$("#ap_annual_use").text(data.ap_annual_use);
								        	$("#ap_annual_remain").text(data.ap_annual_remain);
								        	
								        	//남은 휴가 수 셋팅
								        	$("#vacationAnnualRemainVal").val(data.ap_annual_remain);
								        	
								        	//1차 결재자 이름 정보표시
								        	$("#approvaler_name_01").text(data.approvaler_name_01);
								        	//1차 결재자 사번 정보
								        	$("#approvaler_01").val(data.ap_approvaler_01);
								        	
								        	//인사총무팀장 사번 셋팅
								        	$("#approvaler_03").val(data.ap_approvaler_03);
								        	
							        		return;
								        },
								        error: function(e){
								            alert("할당받은 연차정보가 없습니다.");
								            $("#vacation-manager-dialog").dialog("close");
								        }
								    });
									
									fnVacationIns();
								});
								
								$("input:radio[name=vacation_kind]").click(function(){
									var chkVal = $("input:radio[name=vacation_kind]:checked").val();
									$("#checkedVacationVal").val(chkVal);			//체크한 휴가코드를 Set 한다.				
									
									//휴가안내 기능추가
									if( chkVal == '100' ){
										$("#vacation_info_text").html("<b>연차</b> : 1일 유급휴가");
									}else if(chkVal == '200'){
										$("#vacation_info_text").html("<b>반차</b> : 오전반차, 오후반차");
									}else if(chkVal == '301'){
										$("#vacation_info_text").html("<b>경조사(결혼)</b> : 본인 5일 / 자녀 1일");
										$("#overDay").html('');
									}else if(chkVal == '302'){
										$("#vacation_info_text").html("<b>경조사(회갑)</b> : 본인 및 배우자 2일 / 본인 및 배우자의 부모 1일");
										$("#overDay").html('');
									}else if(chkVal == '303'){
										$("#vacation_info_text").html("<b>경조사(사망)</b> : 배우자 7일 / 본인 및 배우자의 부모 5일 / 본인 및 배우자의 형제자매 3일 </br>본인 및 배우자의 조부모 2일 / 형제자매의 배우자 2일");
										$("#overDay").html('');
									}else if(chkVal == '304'){
										$("#vacation_info_text").html("<b>경조사(탈상)</b> : 배우자 2일 / 본인 및 배우자의 부모 1일 / 본인의 형제자매 1일");
										$("#overDay").html('');
									}else if(chkVal == '400'){
										$("#vacation_info_text").html("<b>배우자출산</b> : 출산(예정)일부터 120일이내 20일 사용(120일이내 3회 분할사용 가능)");
										$("#overDay").html('');
									}else if(chkVal == '500'){
										$("#vacation_info_text").html("<b>출산전&middot;후</b> : 산·전후 90일(다태아를 임신한 경우 120일) (단, 출산 후 45일(다태아 임신의 경우 60일)이상 부여)");
										$("#overDay").html('');
									}else if(chkVal == '600'){
										$("#vacation_info_text").html("<b>유&middot;사산</b> : 임신기간이 11주 이내 5일 / 12주 ~ 15주이내 10일 / 16주 ~ 21주 이내 30일<br/>22주 ~ 27주 이내 60일 / 29주 이상 90일(단, 모자보건법 14조가 허용하는 사유일 경우)");
										$("#overDay").html('');
									}
									
									if( chkVal == '700' ){					
										$("#vacation_info_text").html("<b>예비군(민방위)</b> : 예비군, 민방위훈련");
										//예비군인 경우 첨부파일을 활성화한다.
										$("#tr_vacation_file").show();
										$("#overDay").html('');
									}else{
										$("#tr_vacation_file").hide();					
									}
									
									//기간이 선택된 상태에서 휴가종류를 바꾼경우
									if( $("#vacation_end_date").val() != "" && $("#vacation_start_date").val() != "" ){
										doVacationCal();
									}
									
								});
								
								
								$("#vacation_start_date").change( function(){				
									if( $("#vacation_end_date").val() != "" ){					
										doVacationCal();
									}
								});
								
								$("#vacation_end_date").change( function(){				
									if( $("#vacation_start_date").val() != "" ){					
										doVacationCal();
									}
								});
								
							});
							
							function fnVacationIns(){
								
					        	$("#vacation_start_date").val("");
					        	$("#vacation_end_date").val("");
					        	$("#vacation_comment").val("");

					        	$("#vacation_mod_no").val("");
					        	$("#vacation_mod_state").val("");
					        	$("#vacation_state").hide();
					        	
					        	$("#vacation_start_date").prop("disabled",false);
					        	$("#vacation_end_date").prop("disabled",false);
					        	$("#vacation_comment").prop("disabled",false);
					        	
					        	//휴가타입 초기화
					        	var chkVal = $("input:radio[name=vacation_kind]:checked").val();
								$("#checkedVacationVal").val(chkVal);
					        	
					        	// 파일 업로드 부분 초기화
								if( chkVal == '700' ){					
									//예비군인 경우 첨부파일을 활성화한다.
									$("#tr_vacation_file").show();				
								}else{
									$("#tr_vacation_file").hide();					
								}        	
					        	$("#file_name").html("");
					        	$("#file_up_span").show();
								$("#file_down_span").hide();
								
								$(".tr_vacation_add").show();
								$(".tr_vacation_view").hide();
								$(".tr_vacation_file_view").hide();
								
								//신청일 경우 결재내역을 가린다.
								$("#return_comment_tr").hide();
								
								//선연차사용 체크박스 초기화			
								$("input:checkbox[id='overDayChk']").prop("checked", false);
								
								//선연차 플래그 값 초기화
								$("#next_use").val(0);											
					        	
								$("#vacation-manager-dialog").dialog({
									height: 750,
									width: 800,
									closeOnEscape : true,
									draggable : false,
									appendTo : "#vacationActionFrm",
									title: "관리자 휴가 신청",
									buttons:{
										"휴가 신청" : function(){
											var action = fnVacationAction('C');
											if (action){
												$(this).dialog("close");
											}
										},
										"취소" : function(){
											$(this).dialog("close");
										}
									},
									modal: true,
									overlay:{ opacity: 0., background: '#000000'}
								});
							}
							
							
							//두날짜를 비교해서 시작일이 종료일보다 작으면 false, 크면 true
							function dateChk(startDate, endDate){								
								var sDate = new Date(startDate);
								var eDate = new Date(endDate);
								//날짜 비교
								if( sDate.getTime() > eDate.getTime() ){
									return true;
								}else{
									return false;
								}
							}
							
							
							function doVacationCal(){
								
								var vacationStartdate =  $("#vacation_start_date").val();
								var vacationEnddate = $("#vacation_end_date").val();				
								
								var param = {};
								param.userNo = $("#vacation_user_no").val();
								param.vacationStartDate       = vacationStartdate;
								param.vacationEndDate			= vacationEnddate;
								param.checkedVacationVal				= $("#checkedVacationVal").val();			
								
								var url = "./countVacation";			
								
								//종료날짜가 시작날짜보다 이전일자인지 체크한다.
								if( dateChk( vacationStartdate,  vacationEnddate) ){
									alert('휴가 시작일자가 종료일자보다 작아야합니다. ');
									return;
								}			

								$.ajax({
								    type: "POST",
								    url: url,
								    data: param,
								    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
								    dataType: "html",
								    traditional: true,						//배열허용
								    timeout: 20000,
								    success: function(data){            	
										if( data ){		//1인 경우 성공						
											$("#vacation_interval").text(data);
											//신청 휴가가 연차이거나 반차인경우 연차사용후 잔여일 계산을 해준다.						
											if( $("#checkedVacationVal").val() == '100' || $("#checkedVacationVal").val() == '200') {
												var remainCal = $("#vacationAnnualRemainVal").val() - data;
												//소숫점 처리
												remainCal = Math.round(remainCal*100) / 100;
												$("#vacation_interval_cal").text(remainCal);
												if( remainCal < 0 ){
													alert("연차 잔여일수 보다 연차신청일 수가 많습니다. \n신청된 휴가는 다음해 연차에서 차감됩니다.");
													//연차이월 체크 html 생성
													$("#overDay").html("<br/><br/><input type='checkbox' id='overDayChk'/> <font color='blue'><b>신청한 연차의 선연차 사용을 확인합니다.</b></font>");
													//남은 연차가 없어서 신청할수 있도록 한다. by top3009
													//return;
													//선연차 플래그 셋팅
													$("#next_use").val(1);
												}
											}else{
												var remainCal = $("#vacationAnnualRemainVal").val();
												//소숫점 처리
												remainCal = Math.round(remainCal*100) / 100;
												$("#vacation_interval_cal").text(remainCal);
												//$("#vacation_interval_cal").text($("#vacationAnnualRemainVal").val());	
											}
											//계산된 실제휴가일수를 넣어준다. (연차소모일과  상관없음)
											$("#vacationIntervalVal").val(data);					
										}                	
								    }                
								});
								
							}
							
							//휴가 신청저장
							function fnVacationAction(action,vacationState){
			
								var vacationStartdate =  $("#vacation_start_date").val();
								var vacationEnddate = $("#vacation_end_date").val();
											
								if (action == "C" || action == "U"){
													
									if ( !$("input:radio[name='vacation_kind']").is(":checked") ){
										alert("휴가 종류를 선택 해 주세요.");
										return false;
									}				
									
									if ( $("#vacation_comment").val() == "" ){
										alert("휴가 사유를 입력 해 주세요.");
										return false;
									}				
									
									if ( vacationStartdate == "" ){
										alert("휴가 시작일을 입력 해 주세요.");
										return false;
									}
									
									if ( vacationEnddate == "" ){
										alert("휴가 종료일을 입력 해 주세요.");
										return false;
									}
									
									if ( $("input:radio[name=vacation_kind]:checked").val() == 200
										&& ( $("#vacation_start_date").val() != $("#vacation_end_date").val() )	){
										alert("반차는 시작일과 종료일이 같아야 합니다.");
										return false;
									}				
													
									
									//결혼인경우 휴가날짜가 최대 5일
									if ( $("input:radio[name=vacation_kind]:checked").val() == 301){					
										if($("#vacation_interval").text() > 5 ){
											alert('결혼휴가는 최대 5일까지 가능합니다.');
											return;
										}
									}
									
									//회갑인경우 최대 2일
									if ( $("input:radio[name=vacation_kind]:checked").val() == 302){
										if($("#vacation_interval").text() > 2 ){
											alert('회갑휴가는 최대 2일까지 가능합니다.');
											return;
										}
									}
									
									//사망인경우 최대 7일
									if ( $("input:radio[name=vacation_kind]:checked").val() == 303){
										if($("#vacation_interval").text() > 7 ){
											alert('사망휴가는 최대 7일까지 가능합니다.');
											return;
										}
									}
									
									//탈상인경우 최대 2일
									if ( $("input:radio[name=vacation_kind]:checked").val() == 304){
										if($("#vacation_interval").text() > 2 ){
											alert('탈상휴가는 최대 7일까지 가능합니다.');
											return;
										}
									}
									
									//배우자출산 최대 10일
									if ( $("input:radio[name=vacation_kind]:checked").val() == 400){
										if($("#vacation_interval").text() > 20 ){
											alert('배우자 출산휴가는 최대 20일까지 가능합니다.');
											return;
										}
									}
									
									//출산전후 휴가
									if ( $("input:radio[name=vacation_kind]:checked").val() == 500){
										if($("#vacation_interval").text() > 120 ){
											alert('출산전후 휴가는 최대 120일까지 가능합니다.');
											return;
										}
									}
									
									//유사산 휴가
									if ( $("input:radio[name=vacation_kind]:checked").val() == 600){
										if($("#vacation_interval").text() > 90 ){
											alert('유사산 휴가는 최대 90일까지 가능합니다.');
											return;
										}
									}
									
									//연차 잔여가 없더라도 신청할수 있도록 변경 by top3009				
									if($("#vacation_interval_cal").text() < 0 && ( $("input:radio[name=vacation_kind]:checked").val() == 100 || $("input:radio[name=vacation_kind]:checked").val() == 200) ){
										if(!$("input:checkbox[id='overDayChk']").is(":checked")){
											alert("신청한 연차의 선연차 사용을 확인합니다. 항목에 체크해주세요.");
											$("#overDayChk").focus();
											return;
										}
									}
									
									if ( $("input:radio[name=vacation_kind]:checked").val() == 700 && $("#vacation_file").val() == ""){
										alert("예비군(민방위)의 경우 반드시 증적자료를 첨부하셔야 합니다.");					 
										return false;					
									}
									
									//종료날짜가 시작날짜보다 이전일자인지 체크한다.
									if( dateChk( vacationStartdate,  vacationEnddate) ){
										alert('휴가 시작일자가 종료일자보다 작아야합니다. ');
										return;
									}
								}
								
								var url = "/actionVacationNewManager";
								
								if( action == "D" ){
									url = "/actionVacationCancel";	
								}			
								
							    var param = new FormData();
							    
							    var vacationFile = $('#vacation_file')[0].files[0];
							    param.append('vacationFile', vacationFile);
							    
							    param.append("action",action);
							    
							    if (action == 'U'|| action == 'D' ||action == 'FD'){
							    	param.append("serial_no", $("#vacation_serial_no").val());
							    }
							    
							    param.append("userNo", $("#vacation_user_no").val());
							    param.append("teamId", $("#vacation_team_id").val());
							    param.append("teamType",$("#vacation_team_type").val());							    
							    
							    param.append("vacation_basedate", $("#vacation_start_date_val").text());		    	//취소시 사용하는 base_date
							    		    
							    param.append("vacationTeamType", $("#vacation_team_type").val());
							    param.append("vacationStartDate", vacationStartdate);
							    param.append("vacationEndDate", vacationEnddate);
							    param.append("vacationComment", $("#vacation_comment").val());
							    param.append("vacationKind", $("input:radio[name='vacation_kind']:checked").val());		    
							    param.append("vacationType", $("#vacation_type").val());
							    		    
							    param.append("teamManager", $("#teamManager").val());
							    param.append("teamManagerYn", $("#teamManagerYn").val());
							    param.append("centerManager", $("#centerManager").val());
							    
							    param.append("vacationIntervalVal",$("#vacationIntervalVal").val());		//휴가신청일수 추가
							   	param.append("notApproval",$("#notApproval").val());							//결재자없는경우 예외처리 플래그
							   	
							   	param.append("passApproval",$("#pass_approval").val());				//passApproval : 0 (정상결재), 1: 부문장 또는 결재대상이 없어 최종결재로 넘어감
							   	param.append("approvaler_01",$("#approvaler_01").val());				//결재자(1차): passApproval 이 1인 경우는 없을수도 있음
							   	param.append("approvaler_03",$("#approvaler_03").val());				//결재자(1차): passApproval 이 1인 경우는 없을수도 있음
							   	
							   	param.append("next_use",$("#next_use").val());				//선연차사용시 플래그 1로 표시 
							    			
								var pageIdx = $("#currPageIdx").val();
							    $.ajax({
							        type: "POST",
							        url: url,
							        data: param,
							        timeout: 20000,
							        processData: false,
							        contentType: false,
							        dataType: "JSON", 
							        success: function(data){
							        	
							        	/* if (data.result != "0100" ){
							        		alert(data.msg);
							        	} */
							        	
							        	if (data.result == "0000" ){//신청
							        		alert("휴가 신청이 완료되었습니다.");
							        		//location.href="./myVacationMainNew";
							        		location.href="./vacationManager";							        		
							        	}else if (data.result == "0010"){//수정
							        		fnGoPage(pageIdx);
							        		$("#vacation-manager-dialog").dialog("close");		        		
							        	}else if (data.result == "0020"){//취소
							        		alert("휴가 신청취소가 완료되었습니다.");
							        		fnGoPage(pageIdx);
							        		$("#vacation-manager-dialog").dialog("close");		        		
							        	}else if (data.result == "0100"){//파일 삭제
								        	$("#file_name").html("");
								        	$("#file_up_span").show();
											$("#file_down_span").hide();
							        	}else if(data.result == "900"){		        		
							        		alert("신청하신 휴가일정이 기존에 신청한 휴가기간과 중복됩니다.");
							        	}else if(data.result == "901"){
							        		alert("신청하신 연차일수가 결재 진행중인 연차신청일수와 합산하여\n신청가능한 연차일수를 초과합니다.");
							        	}else if(data.result == "902"){
							        		alert("신청연도에 부여된 연차정보가 없습니다. 관리자에게 문의하세요.");
							        	}else if(data.result == "999"){
							        		alert("결재자가 지정되어있지 않아 휴가를 신청할수 없습니다. 관리자에게 문의하세요.");
							        	}else if(data.result == "903"){			//휴가 신청기간이 입사일자보다 이전 인 경우
							        		alert("휴가신청기간이 입사일자보다 이전입니다. 신청일자를 확인 해 주세요.");
							        	}
							        	
						        		return;
							        },
							        error: function(e){
							            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
							        }
							    });
							}
						</script>
