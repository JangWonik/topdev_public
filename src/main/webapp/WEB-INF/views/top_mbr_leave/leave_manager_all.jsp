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
	<!-- 휴직신청 폼 시작 -->
	<form id="leaveActionFrm">
	
		<!-- 기존 파라미터 시작 -->
		<input type="hidden" id="leave_user_no"  name="leave_user_no" value="${srchParam.userNo}" />
		<input type="hidden" id="leave_team_id" name="leave_team_id" value="${srchParam.teamId}" />
		<input type="hidden" id="leave_team_type" name="leave_team_type" value="${srchParam.teamType}" />				
		<input type="hidden" id="leave_cnt" name="leave_cnt" value="0" />		
		<input type="hidden" id="leave_mod_no" name="leave_mod_no" value=""/>
		<input type="hidden" id="leave_mod_state" name="leave_mod_state" />
		<!-- 기존 파라미터 끝 -->
		<!-- 신규 파라미터 시작 -->
		<input type="hidden" id="checkedLeaveVal" name="checkedLeaveVal" />
		<input type="hidden" id="vacationIntervalVal" name="vacationIntervalVal" />
		<input type="hidden" id="leaveIntervalVal" name="leaveIntervalVal" />				
		<input type="hidden" id="approval_state" name="approval_state"/>	
		<input type="hidden" id="leave_serial_no" name="leave_serial_no"/>		
		<input type="hidden" id="leave_type" name="leave_type"/>
		<input type="hidden" id="notApproval" name="notApproval" value="${notApproval}"/>
		<!-- 신규 파라미터 끝 -->
					
		<!-- 수정후 신규 파라미터 시작 -->
		<!-- 기본(1차결재자) -->
		<input type="hidden" id="approvaler_01" name="approvaler_01" value="${approvaler_01}"/>
		<input type="hidden" id="approvaler_03" name="approvaler_03" value="${approvaler_03}"/>
		<!-- 결재자유무(1:최종결재단계로 넘어감, 0:결재1차) -->
		<input type="hidden" id="pass_approval" name="pass_approval" value="${pass_approval}"/>		
		<!-- 수정후 신규 파라미터 끝 -->
		<div id="leave-manager-dialog" title="휴직 신청" style="font-size: 15px;display:none;" align="center">
			<br/>
			<div class="tableStyle2" style="width: 780px;">
				<table class="vacation-ins-table">					
					<tbody>					
						<tr id="leave_state">
							<th>결재상태</th>
							<td style="text-align:left;padding-left: 30px;font-weight:bold;" colspan="4">
								<span id="leave_state_val"></span>
							</td>											
						</tr>
						
						<tr class="tr_leave_add">
							<th>신청자</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">								
								<span id="ap_user_info"></span>
							</td>							
						</tr>
						
						<tr class="tr_leave_add">
							<th>휴직유형</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<input type="radio" name="leave_kind" id="leave_kind_0" value="1001" checked="checked"> 육아휴직 &nbsp;								
								<input type="radio" name="leave_kind" id="leave_kind_1" value="2001"> 가족돌봄휴직 &nbsp;
								<!-- 산재휴직 질병상해휴직 추가 -->
								<input type="radio" name="leave_kind" id="leave_kind_2" value="3001"> 산재승인휴직 &nbsp;
								<input type="radio" name="leave_kind" id="leave_kind_3" value="4001"> 상해/질병휴직 &nbsp;
								<input type="radio" name="leave_kind" id="leave_kind_4" value="9001"> 기타 휴직
							</td>
						</tr>
						
						<tr class="tr_leave_add">
							<th>휴직안내</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">								
								<span id="leave_info_text"><b>육아휴직</b> : 남녀고용평등과 일&middot;가정양립지원에 관한 법률 제19조1항에 따른 육아휴직 (최대 1년) </span>
							</td>
						</tr>
						
						<tr class="tr_leave_add">
							<th>사유</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<input type="text" id="leave_comment" name="leave_comment" style="width:480px;" />								
							</td>
						</tr>
						
						<tr class="tr_leave_add">
							<th>기간</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<input type="text" class="classCalendar" id="leave_start_date" name="leave_start_date" style="width: 100px;"/>
								&nbsp;~&nbsp;
								<input type="text" class="classCalendar" id="leave_end_date" name="leave_end_date" style="width: 100px;"/>
								&nbsp; <font style="font-weight:bold;color:blue;">( 근무일 기준 : <span id="vacation_interval">0</span> ) 일</font> &nbsp;
								<font style="font-weight:bold;color:green;">( 총 : <span id="leave_interval_all">0</span> ) 일</font>  								
							</td>
						</tr>
						
						<tr  class="tr_leave_add">
							<th rowspan="2">결재</th>	
							<c:choose>
								<c:when test="${pass_approval eq '1'}">
									<th colspan="4">최종 확인</th>
								</c:when>
								<c:otherwise>
									<th colspan="2">결재자</th>							
									<th colspan="2">최종 확인</th>	
								</c:otherwise>
							</c:choose>			
						</tr>
						
						<tr class="tr_leave_add">
							<c:choose>
							<%-- 최종결재자만 표시되는 경우--%>
							<c:when test="${pass_approval eq '1' }">
								<td colspan="4">
									<c:choose>
										<c:when test="${approvaler_03 ne ''}">
											인사총무팀											
										</c:when>
										<c:otherwise>
											최종 확인자가 없습니다.
										</c:otherwise>
									</c:choose>
								</td>
							</c:when>
							<c:otherwise>
								<%-- 결재자 --%>								
								<td colspan="2">
									<span id="approvaler_name_01"></span>
									<%-- ${approvaler_name_01} --%>
								</td>
								<%-- 최종결재자 --%>
								<td colspan="2">
									<c:choose>
										<c:when test="${approvaler_03 ne ''}">
											인사총무팀											
										</c:when>
										<c:otherwise>
											최종 확인자가 없습니다.
										</c:otherwise>
									</c:choose>
								</td>
							</c:otherwise>
						</c:choose>						
						</tr>
						
						<tr class="tr_leave_add">
							<th>휴직 후<br/>연차유급휴가<br/>부여기준</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">								
								<span id="leave_set_text">육아 휴직 기간 중 소정근로일수(근로자와 사용자가 근로하기로 정한 날)에 대해 출근한 것으로 보아 15일의 <br/>유급휴가 부여 (3년 이상 계속 근로한 근로자에게는 최초 1년을 초과하는 계속 근로 연수 매 2년에 대하여 1일을 <br/>가산한 유급휴가 부여)<br/>
								※ 1년간 80퍼센트 이상 출근한 근로자의 연차유급휴가 부여기준과 동일하게 적용
								</span>
							</td>
						</tr>
						
						<tr class="tr_leave_view">
							<th>휴직종류</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<span id="leave_kind_val"></span>
							</td>
						</tr>						
						
						<tr class="tr_leave_view">
							<th>사유</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<span id="leave_comment_val"></span>								
							</td>
						</tr>											
						
						<tr class="tr_leave_view">
							<th>기간</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<span id="leave_start_date_val"></span>&nbsp;~&nbsp;<span id="leave_end_date_val"></span>								
								&nbsp; <font style="font-weight:bold;color:blue;">( <span id="leave_interval_val">0</span> ) 일간</font>
							</td>
						</tr>						
						
						<tr class="tr_leave_view">
							<th rowspan="2">결재</th>
							<c:choose>
								<c:when test="${pass_approval eq '1'}">
									<th colspan="4">최종 확인</th>
								</c:when>
								<c:otherwise>
									<th colspan="2">결재자</th>							
									<th colspan="2">최종 확인</th>	
								</c:otherwise>
							</c:choose>																					
						</tr>
						<tr class="tr_leave_view">
							<c:choose>
							<%-- 최종결재자만 표시되는 경우--%>
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
								<%-- 결재자 --%>								
								<td colspan="2">
									${approvaler_name_01}
								</td>
								<%-- 최종결재자 --%>
								<td colspan="2">
									<c:choose>
										<c:when test="${approvalList3.size() > 0}">
											인사총무팀											
										</c:when>
										<c:otherwise>
											최종 확인자가 없습니다.
										</c:otherwise>
									</c:choose>
								</td>
							</c:otherwise>
						</c:choose>						
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
	<!-- 휴직신청 폼 끝 -->
	
	<!-- 휴가신청 폼 시작 -->
	<%-- <form id="vacationActionFrm">	
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
		<div id="vacation-manager-dialog" title="휴직 신청" style="font-size: 15px;display:none;" align="center">
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
							<c:choose>
								<c:when test="${pass_approval eq '1'}">
									<th colspan="4">최종 확인</th>
								</c:when>
								<c:otherwise>
									<th colspan="2">결재자</th>							
									<th colspan="2">최종 확인</th>	
								</c:otherwise>
							</c:choose>			
						</tr>
						<tr  class="tr_vacation_view">
							<th rowspan="2">결재</th>
							<c:choose>
								<c:when test="${pass_approval eq '1'}">
									<th colspan="4">최종 확인</th>
								</c:when>
								<c:otherwise>
									<th colspan="2">결재자</th>							
									<th colspan="2">최종 확인</th>	
								</c:otherwise>
							</c:choose>																					
						</tr>
						<tr>
							<c:choose>
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
						</c:choose>						
						</tr>
						<tr id="return_comment_tr" style="display: none;">
							<th>결재 내역</th>
							<td  style="text-align:left;padding-left: 30px;" id="return_comment"  colspan="4"></td>
						</tr>						
					</tbody>																																																							
				</table>
			</div>
		</div>
	</form> --%>	
	<!-- 휴가신청 폼 끝 -->
	
		<div class= "tableStyle2" style="border-top: 0px;padding-bottom:5px;" align="left">
			<table>
				<tr>
					<th height="25px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0"> 신청자</th>
					<td colspan="2">
						<select id="srchUserList" name="srchUserList" style="width: 334px;">
							<option value="0" <c:if test="${srchUserList eq 0}">selected</c:if> >- 선택하세요 -</option>
							<c:forEach items="${ApUserList}" var="apUserVo">
								<option value="${apUserVo.user_no}">${apUserVo.user_name} [${apUserVo.team_name}]</option>
							</c:forEach>							
						</select>
					</td>
					<td colspan="4" style="text-align:left;padding-left:10px;">
						<a href="#noloc" class="btn-vacation-list-ins" id="btn-vacation-list-ins">휴직 신청</a>
					</td>					
				</tr>
			</table>
		</div>
		
							<div class= "tableStyle2" style="border-top: 0px;">
								<!-- search-box -->
								<form id="searchFrm" action="leaveManager" method="POST">
									<input type="hidden" id="view_type" name="view_type" value="search" />
									<input type="hidden" id="pageIdxSearch" name="pageIdxSearch" />									
									<div id="search-box"  align="center">
										<table style="width: 100%;" align="center">											
											<tr>												
												<th style="width: 70px;">종류</th>
												<td>
													<select id="srchKind" name="srchKind" style="width: 150px;">
														<option value="99">- 전체 -</option>
														<c:forEach items="${leaveKindList}" var="item" varStatus="status">
															<c:choose>
																<c:when test="${srchParam.srchKind == item.leave_code}">
																	<option value="${item.leave_code}" selected="selected">${item.leave_type}</option>
																</c:when>
																<c:otherwise>
																	<option value="${item.leave_code}">${item.leave_type}</option>
																</c:otherwise>
															</c:choose>													
														</c:forEach>
													</select>											
												</td>
												<th style="width: 70px;">상태</th>
												<td>
													<select id="srchState" name="srchState" style="width: 150px;">
														<option value="00">- 전체 -</option>
														<c:forEach items="${leaveStateList}" var="item" varStatus="status">
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
												<th style="width: 70px;">구분</th>
												<td>
													<select id="srchTeamType" name="srchTeamType" style="width: 150px;">
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
												<th style="width: 70px;">부서</th>
												<td style="width: 170px;">
													<span style="text-align: left !important;">
														<select id="srchTeamId" name="srchTeamId" style="width: 160px;">
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
												<th style="width: 70px;">이름</th>
												<td>
													<input type="text" id="srchUserName" name="srchUserName" value="${srchParam.srchUserName }"/>
												</td>
												<td style="width: 100px;">
													<a href="#noloc" class="btn-vacation-aprv" id="approval-all-btn-search">검색</a>
												</td>																								
											</tr>
										</table>
										<br/>
									</div> 
								</form>										
								<!-- 목록시작 -->																
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
											<th width="5%">사용일</th>											
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
														<td class="td-overflow-none">${item.leave_type_val}</td>
														<td class="td-overflow-none">${item.sdate} ~ ${item.edate}</td>														
														<td class="td-overflow-none">${item.leave_interval} 일</td>															
														<td class="td-overflow-none">${item.leave_content}</td>
														<td class="td-overflow-none">${item.approval_state_val}</td>
														<td class="td-overflow-none">															
															<c:choose>
																<c:when test="${item.approval_state eq 30 or item.approval_state eq 31 or item.approval_state eq 32}">인사팀</c:when>
																<c:otherwise>
																	<c:if test="${mbrVo_Session.user_state eq 9 and (item.approvaler_01 ne 99991 and item.approvaler_01 ne 99994)}">
																		<img src="./resources/ls_img/ls_invoice/btn_s_edite.gif" style="cursor:pointer;"	onclick="updateNowLeaveApproval('${item.serial_no}')" title="결재자 수정하기" />
																	</c:if>																	
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
													<td colspan="12">
														검색된 휴직내역이 없습니다.
													</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
							<input type="hidden" id="currPageIdx" value="${pageInfo.currentPageNo}"/>
							<div class="pagingWrap">
						        	<c:import url="/page_navi_leave_search">
						            	<c:param name="beginIdx" value="${pageInfo.firstPageNoOnPageList}"/>
						                <c:param name="endIdx" value="${pageInfo.lastPageNoOnPageList}"/>
						                <c:param name="currentIdx" value="${pageInfo.currentPageNo}"/>
						                <c:param name="totalPageCnt" value="${pageInfo.totalPageCount}"/>						                
									</c:import>
							</div>
							<!-- 목록 끝 -->							
						
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
		
		//휴직 신청 버튼
		$("#btn-vacation-list-ins").on("click",function(){
			
			var sel_user_no = $("#srchUserList").val();									
			
			if( sel_user_no == 0 ){
				alert("휴직을 신청 할 신청자를 선택해 주세요");
				return;
			}
			
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
		        	
		        	$("#leave_user_no").val(data.ap_user_no);
		        	$("#leave_team_id").val(data.ap_team_id);
		        	$("#leave_team_type").val(data.ap_team_type);
		        	$("#ap_user_info").text(data.ap_user_name+" ["+data.ap_team_name+"]");
		        	
		        	//alert("data="+data.approvaler_name_01+" : "+data.ap_approvaler_01+" : "+data.ap_approvaler_03);
		        	
		        	//1차 결재자 이름 정보표시
		        	$("#approvaler_name_01").text(data.approvaler_name_01);
		        	//1차 결재자 사번 정보
		        	$("#approvaler_01").val(data.ap_approvaler_01);
		        	
		        	//인사총무팀장 사번 셋팅
		        	$("#approvaler_03").val(data.ap_approvaler_03);
		        	
	        		return;
		        },
		        error: function(e){
		            alert("휴직신청 정보가 올바르지 않습니다.");
		            $("#leave-manager-dialog").dialog("close");
		        }
		    });
			
			fnVacationIns();
		});
		
		$("input:radio[name=leave_kind]").click(function(){
			var chkVal = $("input:radio[name=leave_kind]:checked").val();
			$("#checkedVacationVal").val(chkVal);			//체크한 휴가코드를 Set 한다. (휴직코드로 변경필요)				
			
			//휴직안내 기능추가
			if( chkVal == '1001' ){
				$("#leave_info_text").html("<b>육아휴직</b> : 남녀고용평등과 일·가정양립지원에 관한 법률 제19조1항에 따른 육아휴직 (최대 1년)");
			}else if(chkVal == '2001'){
				$("#leave_info_text").html("<b>가족돌봄휴직</b> : 남녀고용평등과 일ㆍ가정양립지원에 관한 법률 제22조의 2에 따른 휴직 (최대 90일)");
			}else if(chkVal == '3001'){
				$("#leave_info_text").html("<b>산재승인휴직</b> : 산업재해보상보헙법상 업무상 재해(질병 등)으로 인정되어 산재가 승인된 기간에 대한 휴직");					
			}else if(chkVal == '4001'){
				$("#leave_info_text").html("<b>상해/질병휴직</b> : 산업재해보상보헙법상 업무상 재해(질병 등)를 제외한 상해/질병에 따른 휴직");					
			}else if(chkVal == '9001'){
				$("#leave_info_text").html("<b>기타 휴직</b> : 육아, 가족돌봄휴직에 해당하지 아니하는 본인 신청에 따른 휴직");					
			}
			
			//휴직 후 연차유급휴가 부여기준 추가
			if( chkVal == '1001' ){
				$("#leave_set_text").html("육아 휴직 기간 중 소정근로일수(근로자와 사용자가 근로하기로 정한 날)에 대해 출근한 것으로 보아 15일의 <br/>유급휴가 부여 (3년 이상 계속 근로한 근로자에게는 최초 1년을 초과하는 계속 근로 연수 매 2년에 대하여 1일을 <br/>가산한 유급휴가 부여)<br/>※ 1년간 80퍼센트 이상 출근한 근로자의 연차유급휴가 부여기준과 동일하게 적용");
			}else if(chkVal == '2001'){
				$("#leave_set_text").html("가족 돌봄 휴직 기간을 제외한 나머지 소정근로일수(근로자와 사용자가 근로하기로 정한 날)의 출근율을 가지고 산정하며, 연차유급휴가 일수는 가족 돌봄 휴직 기간을 제외한 나머지 소정근로일수와 연간 총 소정근로일수의 비율에 따라 산정.<br/>단, 가족 돌봄 휴직 기간을 제외한 나머지 소정근로일수와 연간 총 소정근로일수의 비율이 80퍼센트 이상인 경우,<br/>15일의 유급휴가 부여<br/>(3년 이상 계속 근로한 근로자에게는 최초 1년을 초과하는 계속 근로 연수 매 2년에 대하여 1일을 가산한 유급휴가 부여)");
			}else if(chkVal == '3001'){
				$("#leave_set_text").html("산재휴직 연차부여기준");
			}else if(chkVal == '4001'){
				$("#leave_set_text").html("질병상해휴직 연차부여기준");
			}else if(chkVal == '9001'){
				$("#leave_set_text").html("기타 휴직 기간을 제외한 나머지 소정근로일수와 연간 총 소정근로일수의 비율이 80퍼센트 이상인 경우 15일의 유급휴가 부여 (3년 이상 계속 근로한 근로자에게는 최초 1년을 초과하는 계속 근로 연수 매 2년에 대하여 1일을 가산한 유급휴가 부여), 80퍼센트 미만인 경우 1개월 개근 시 1일의 유급휴가 부여");					
			}
			
			//기간이 선택된 상태에서 휴가종류를 바꾼경우
			if( $("#leave_end_date").val() != "" && $("#leave_start_date").val() != "" ){
				doVacationCal();
				doLeaveCal();
			}
			
		});
		
		
		$("#leave_start_date").change( function(){				
			if( $("#leave_end_date").val() != "" ){					
				doVacationCal();
				doLeaveCal();
			}
		});
		
		$("#leave_end_date").change( function(){				
			if( $("#leave_start_date").val() != "" ){					
				doVacationCal();
				doLeaveCal();
			}
		});
		
	});
	
	function fnVacationIns(){
		
       	$("#leave_start_date").val("");
       	$("#leave_end_date").val("");
       	$("#leave_comment").val("");

       	$("#leave_mod_no").val("");
       	$("#leave_mod_state").val("");
       	$("#leave_state").hide();
       	
       	$("#leave_start_date").prop("disabled",false);
       	$("#leave_end_date").prop("disabled",false);
       	$("#leave_comment").prop("disabled",false);
       	
       	//휴직타입 초기화
       	var chkVal = $("input:radio[name=leave_kind]:checked").val();
		$("#checkedLeaveVal").val(chkVal);					        	
		
		$(".tr_leave_add").show();
		$(".tr_leave_view").hide();								
		
		//신청일 경우 결재내역을 가린다.
		$("#return_comment_tr").hide();
		
		$("#leave-manager-dialog").dialog({
			height: 650,
			width: 850,
			closeOnEscape : true,
			draggable : false,
			appendTo : "#leaveActionFrm",
			title: "관리자 휴직 신청",
			buttons:{
				"휴직 신청" : function(){
					var action = fnLeaveAction('C');
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
		
		var vacationStartdate =  $("#leave_start_date").val();
		var vacationEnddate = $("#leave_end_date").val();				
		
		var param = {};
		param.vacationStartDate       = vacationStartdate;
		param.vacationEndDate			= vacationEnddate;
		param.checkedVacationVal				= $("#checkedVacationVal").val();		//휴직코드 (1001: 1년, 2001: 90일까지 가능함)
		
		//종료날짜가 시작날짜보다 이전일자인지 체크한다.
		if( dateChk( vacationStartdate,  vacationEnddate) ){
			alert('휴직 시작일자가 종료일자보다 작아야합니다. ');
			return;
		}			
		
		var url = "./countVacation";

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
					//계산된 실제휴가일수를 넣어준다. (연차소모일과  상관없음)
					$("#vacationIntervalVal").val(data);					
				}                	
		    }                
		});
		
	}
							
	function doLeaveCal(){
		
		var vacationStartdate =  $("#leave_start_date").val();
		var vacationEnddate = $("#leave_end_date").val();				
		
		var param = {};
		param.vacationStartDate       = vacationStartdate;
		param.vacationEndDate			= vacationEnddate;
		param.checkedVacationVal				= $("#checkedVacationVal").val();		//휴직코드 (1001: 1년, 2001: 90일까지 가능함)
		
		//종료날짜가 시작날짜보다 이전일자인지 체크한다.
		if( dateChk( vacationStartdate,  vacationEnddate) ){
			alert('휴직 시작일자가 종료일자보다 작아야합니다. ');
			return;
		}			
		
		var url = "./countLeave";
		
		//총 휴가 신청일수
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
					$("#leave_interval_all").text(data);						
					//계산된 실제휴가일수를 넣어준다. (연차소모일과  상관없음)
					$("#leaveIntervalVal").val(data);						
				}                	
		    }                
		});
		
	}
							
	//휴직 신청저장
	//휴직신청버튼클릭
	function fnLeaveAction(action){
		
		var vacationStartdate =  $("#leave_start_date").val();
		var vacationEnddate = $("#leave_end_date").val();
					
		if (action == "C" || action == "U"){
							
			if ( !$("input:radio[name='leave_kind']").is(":checked") ){
				alert("휴직의 종류를 선택 해 주세요.");
				return false;
			}
			
			if ( $("#leave_comment").val() == "" ){
				alert("휴직 사유를 입력 해 주세요.");
				return false;
			}				
			
			if ( vacationStartdate == "" ){
				alert("휴직 시작일을 입력 해 주세요.");
				return false;
			}
			
			if ( vacationEnddate == "" ){
				alert("휴직 종료일을 입력 해 주세요.");
				return false;
			}
			
			//육아휴직의 경우 1년			
			if ( $("input:radio[name=leave_kind]:checked").val() == 1001){					
				
				if($("#leaveIntervalVal").val() > 366 ){
					alert('육아휴직는 최대 1년까지 신청이 가능합니다.');
					return;
				}
				
			}
			
			//가족돌봄휴직의 경우 90일
			if ( $("input:radio[name=leave_kind]:checked").val() == 2001){					
				
				if($("#leaveIntervalVal").val() > 90 ){
					alert('가족돌봄휴직은 90일까지 신청이 가능합니다.');
					return;
				}
				
			}
			
			//종료날짜가 시작날짜보다 이전일자인지 체크한다.
			if( dateChk( vacationStartdate,  vacationEnddate) ){
				alert('휴직 시작일자가 종료일자보다 작아야합니다. ');
				return;
			}
		}
		
		//var url = "/actionVacationNewManager";
		//var url = "/actionLeave";
		var url = "/actionLeaveManager";
		
		if( action == "D" ){
			url = "/actionLeaveCancel";
		}			
		
	    var param = new FormData();		    
	    		    
	    param.append("action",action);	    
	    
	    if (action == 'U'|| action == 'D' ||action == 'FD'){
	    	param.append("serial_no", $("#leave_serial_no").val());
	    }	    
	    
	    param.append("userNo", $("#leave_user_no").val());
	    param.append("teamId", $("#leave_team_id").val());
	    param.append("leave_basedate", $("#leave_start_date_val").text());		    	//취소시 사용하는 base_date
	    		    
	    param.append("leaveTeamType", $("#leave_team_type").val());
	    param.append("vacationStartDate", vacationStartdate);
	    param.append("vacationEndDate", vacationEnddate);
	    param.append("leaveComment", $("#leave_comment").val());
	    param.append("leaveKind", $("input:radio[name='leave_kind']:checked").val());		    
	    param.append("leaveType", $("#leave_type").val());
	    		    
	    param.append("teamManager", $("#teamManager").val());
	    param.append("teamManagerYn", $("#teamManagerYn").val());
	    param.append("centerManager", $("#centerManager").val());
	    
	    param.append("vacationIntervalVal",$("#vacationIntervalVal").val());		//근무일제외 휴직신청일수 추가
	    param.append("leaveIntervalVal",$("#leaveIntervalVal").val());		//총휴직 신청일수 추가
	   	param.append("notApproval",$("#notApproval").val());							//결재자없는경우 예외처리 플래그
	   	
	   	param.append("passApproval",$("#pass_approval").val());				//passApproval : 0 (정상결재), 1: 부문장 또는 결재대상이 없어 최종결재로 넘어감
	   	param.append("approvaler_01",$("#approvaler_01").val());				//결재자(1차): passApproval 이 1인 경우는 없을수도 있음
	   	param.append("approvaler_03",$("#approvaler_03").val());				//결재자(1차): passApproval 이 1인 경우는 없을수도 있음
	   				
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
	        	
	        	if (data.result == "0000" ){//신청
	        		alert("휴직 신청이 완료되었습니다.");
	        		location.href="./leaveManager";
	        	}else if (data.result == "0010"){//수정
	        		fnGoPage(pageIdx);
	        		$("#leave-action-dialog").dialog("close");		        		
	        	}else if (data.result == "0020"){//취소
	        		alert("휴직 신청취소가 완료되었습니다.");
	        		fnGoPage(pageIdx);
	        		$("#leave-action-dialog").dialog("close");		        		
	        	}else if(data.result == "900"){		        		
	        		alert("신청하신 휴직일정이 기존에 신청한 휴직기간과 중복됩니다.");
	        	}else if(data.result == "999"){
	        		alert("결재자가 지정되어있지 않아 휴직을 신청할수 없습니다. 관리자에게 문의하세요.");
	        	}
	        	
        		return;
	        },
	        error: function(e){
	            alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
	        }
	    });
	}
</script>