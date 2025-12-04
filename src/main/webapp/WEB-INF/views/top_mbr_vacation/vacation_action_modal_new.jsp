<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

	<style>
		.td-overflow-none{
			text-overflow : ellipsis;
			overflow : hidden;
			white-space : nowrap;
			word-wrap:normal;
		}
		
		.vacation-ins-table tr{
			height: 50px;
		}
		.vacation-ins-kind li {
			float:left;			
			width:100px;
			padding:0 10px; 	
			text-align: left;
		}
		.ui-button-text-only {
			height:2.1em !important;
		}
		
		.vacation-btn {
			font-weight:bold;
			text-decoration:none;
			font-family:Arial;
			box-shadow:inset #fafafa 0px 5px 8px -1px;
			o-box-shadow:inset #fafafa 0px 5px 8px -1px;
			-moz-box-shadow:inset #fafafa 0px 5px 8px -1px;
			-webkit-box-shadow:inset #fafafa 0px 5px 8px -1px;
			text-indent:0px;
			line-height:0px;
			-moz-border-radius:3px;
			-webkit-border-radius:3px;
			border-radius:3px;
			text-align:center;
			vertical-align:middle;
			display:inline-block;
			font-size:12px;
			color:#696969  !important;
			width:63px;
			height:0px;
			padding:13px;
			border-color:#e1e1e1;
			border-width:1px;
			border-style:solid;
			background: #eeeeee;
		}

		.vacation-btn:active {
			position:relative;
			top:4px
		}
		
	</style>	
	
	<form id="vacationActionFrm">
	
		<!-- 기존 파라미터 시작 -->
		<input type="hidden" id="vacation_user_no"  name="vacation_user_no" value="${srchParam.userNo}" />
		<input type="hidden" id="vacation_team_id" name="vacation_team_id" value="${srchParam.teamId}" />
		<input type="hidden" id="vacation_team_type" name="vacation_team_type" value="${srchParam.teamType}" />
		<input type="hidden" id="vacation_year" name="vacation_year" value="${srchParam.year}" />
		<input type="hidden" id="vacation_remain_cnt" name="vacation_remain_cnt" value="${11 - srchParam.vacationUseCnt}" />		
		<input type="hidden" id="vacation_cnt" name="vacation_cnt" value="0" />		
		<input type="hidden" id="vacation_mod_no" name="vacation_mod_no" value=""/>
		<input type="hidden" id="vacation_mod_state" name="vacation_mod_state" />
		<!-- 기존 파라미터 끝 -->
		<!-- 신규 파라미터 시작 -->
		<input type="hidden" id="checkedVacationVal" name="checkedVacationVal" />
		<input type="hidden" id="vacationIntervalVal" name="vacationIntervalVal" />
		<input type="hidden" id="vacationAnnualSetVal" name="vacationAnnualSetVal" value="${vacation.annual_set}"/>
		<input type="hidden" id="vacationAnnualUseVal" name="vacationAnnualUseVal" value="${vacation.annual_use}"/>
		<input type="hidden" id="vacationAnnualRemainVal" name="vacationAnnualRemainVal" value="${vacation.annual_set - vacation.annual_use}"/>		
		<input type="hidden" id="approval_state" name="approval_state"/>	
		<input type="hidden" id="vacation_serial_no" name="vacation_serial_no"/>
		<input type="hidden" id="vacation_basedate" name="vacation_basedate"/>
		<input type="hidden" id="vacation_type" name="vacation_type"/>
		<input type="hidden" id="notApproval" name="notApproval" value="${notApproval}"/>
		<!-- 선연차 사용 플래그 추가 by top3009 -->
		<input type="hidden" id="next_use" name="next_use" value="0"/>				
		<!-- 신규 파라미터 끝 -->
		<!-- 휴가 신청시점 연차잔여일  -->
		<input type="hidden" id="remain_vacation_use" name="remain_vacation_use" value="${vacation.annual_set - vacation.annual_use}">		
					
		<!-- 수정후 신규 파라미터 시작 -->
		<!-- 기본(1차결재자) -->
		<input type="hidden" id="approvaler_01" name="approvaler_01" value="${approvaler_01}"/>
		<input type="hidden" id="approvaler_03" name="approvaler_03" value="${approvaler_03}"/>
		<!-- 결재자유무(1:최종결재단계로 넘어감, 0:결재1차) -->
		<input type="hidden" id="pass_approval" name="pass_approval" value="${pass_approval}"/>
		<!-- 반차, 반반차 시간 옵션 시작 -->
		<input type="hidden" id="vacation_option" name="vacation_option"/>
		<!-- 반차, 반반차 시간 옵션 끝 -->		
		<!-- 수정후 신규 파라미터 끝 -->
		<div id="vacation-action-dialog" title="휴가 신청" style="font-size: 15px;display:none;" align="center">
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
							<th>휴가안내</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">								
								<span id="vacation_info_text"><!-- <b>연차</b> : 1일 유급휴가  --></span>
							</td>							
						</tr>
						
						<tr class="tr_vacation_add">
							<th>일반휴가</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<input type="radio" name="vacation_kind" id="vacation_kind_0" value="100" checked="checked" onclick="changeVacationClick();"> 연차 &nbsp;
								<c:if test="${mbrVo_Session.team_type ne 4}">
								<input type="radio" name="vacation_kind" id="vacation_kind_1" value="200" onclick="changeVacationClick();"> 반차 &nbsp;
								<input type="radio" name="vacation_kind" id="vacation_kind_11" value="210" onclick="changeVacationClick();"> 반&middot;반차
								</c:if>
							</td>
						</tr>
												
						<c:if test="${mbrVo_Session.team_type ne 4}">
						<!-- 오전, 오후 반차 선택 시작 (4종 제외)-->
						<tr class="tr_vacation_half_view">
							<th>반차휴가</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<input type="radio" name="vacation_kind_half" id="vacation_kind_2_1" value="201" onclick="changeVacationClick();"> 오전반차 &nbsp;								
								<input type="radio" name="vacation_kind_half" id="vacation_kind_2_2" value="202" onclick="changeVacationClick();"> 오후반차						
							</td>
						</tr>
						<!-- 오전, 오후 반차 선택 끝 -->
						<!-- 반반차 선택 시작 -->
						<tr class="tr_vacation_quarter_view">
							<th>반&middot;반차휴가<br/>(시작시간)</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">								
								<input type="radio" name="vacation_kind_quarter" id="vacation_kind_2_3" value="211" onclick="changeVacationClick();"> 09:00 &nbsp;								
								<input type="radio" name="vacation_kind_quarter" id="vacation_kind_2_4" value="212" onclick="changeVacationClick();"> 10:00 &nbsp;
								<input type="radio" name="vacation_kind_quarter" id="vacation_kind_2_5" value="213" onclick="changeVacationClick();"> 11:00 &nbsp;
								<input type="radio" name="vacation_kind_quarter" id="vacation_kind_2_6" value="214" onclick="changeVacationClick();"> 13:00 &nbsp;
								<input type="radio" name="vacation_kind_quarter" id="vacation_kind_2_7" value="215" onclick="changeVacationClick();"> 14:00 &nbsp;
								<input type="radio" name="vacation_kind_quarter" id="vacation_kind_2_8" value="216" onclick="changeVacationClick();"> 15:00 &nbsp;
								<input type="radio" name="vacation_kind_quarter" id="vacation_kind_2_9" value="217" onclick="changeVacationClick();"> 16:00								
							</td>
						</tr>
						<!-- 반반차 선택 끝 -->
						</c:if>
						
						<tr class="tr_vacation_add">
							<th>경조휴가</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<input type="radio" name="vacation_kind" id="vacation_kind_2" value="301" onclick="changeVacationClick();"> 결혼 &nbsp;
								<!-- <input type="radio" name="vacation_kind" id="vacation_kind_3" value="302"> 회갑 &nbsp; -->
								<input type="radio" name="vacation_kind" id="vacation_kind_4" value="303" onclick="changeVacationClick();"> 사망 &nbsp;
								<!-- <input type="radio" name="vacation_kind" id="vacation_kind_5" value="304"> 탈상 &nbsp; -->
								<!-- <input type="radio" name="vacation_kind" id="vacation_kind_6" value="305"> 기타 &nbsp; -->
							</td>
						</tr>
						
						<tr class="tr_vacation_add">
							<th>출산휴가</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<input type="radio" name="vacation_kind" id="vacation_kind_7" value="400" onclick="changeVacationClick();"> 배우자출산 &nbsp;
								<input type="radio" name="vacation_kind" id="vacation_kind_8" value="500" onclick="changeVacationClick();"> 출산전&middot;후 &nbsp;
								<input type="radio" name="vacation_kind" id="vacation_kind_9" value="600" onclick="changeVacationClick();"> 유&middot;사산 &nbsp;
							</td>
						</tr>
						
						<tr class="tr_vacation_add">
							<th>특별휴가</th>
							<td style="text-align:left;padding-left: 30px;" colspan="4">
								<input type="radio" name="vacation_kind" id="vacation_kind_10" value="700" onclick="changeVacationClick();"> 예비군(민방위)
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
								<input type="text" class="classCalendar" id="vacation_start_date" name="vacation_start_date" style="width: 100px;" readonly />
								&nbsp;~&nbsp;
								<input type="text" class="classCalendar" id="vacation_end_date" name="vacation_end_date" style="width: 100px;" readonly />
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
							<th rowspan="2">연차정보<br/><br/>(${vacation.base_year} 년)</th>
							<th>연차 부여일</th>
							<th>연차 사용일</th>
							<th>연차 잔여일</th>
							<th>연차신청 후 잔여일</th>
						</tr>
						<tr class="tr_vacation_add">
							<td><fmt:formatNumber value="${vacation.annual_set}" pattern="0.00"/> 일</td>
							<td><fmt:formatNumber value="${vacation.annual_use}" pattern="0.00"/> 일</td>
							<td><fmt:formatNumber value="${vacation.annual_set - vacation.annual_use}" pattern="0.00"/> 일</td>
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
							<td><fmt:formatNumber value="${vacation.annual_set}" pattern="0.00"/> 일</td>
							<td><fmt:formatNumber value="${vacation.annual_use}" pattern="0.00"/> 일</td>
							<td><fmt:formatNumber value="${vacation.annual_set - vacation.annual_use}" pattern="0.00"/> 일</td>
							<td><font style="font-weight:bold;color:blue;"><span id="vacation_interval_info">0</span> 일</font></td>							
						</tr>
						
						<%-- <tr  class="tr_vacation_add">
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
						</tr> --%>
						
						<tr  class="tr_vacation_add">
							<th rowspan="2">결재</th>	
							<c:choose>
								<c:when test="${pass_approval eq '1'}">
									<th colspan="4">최종 확인</th>
								</c:when>
								<c:otherwise>
									<th colspan="4">결재자</th>
								</c:otherwise>
							</c:choose>			
						</tr>						
						
						<%-- <tr  class="tr_vacation_view">
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
						</tr> --%>
						
						<tr  class="tr_vacation_view">
							<th rowspan="2">결재</th>
							<c:choose>
								<c:when test="${pass_approval eq '1'}">
									<th colspan="4">최종 확인</th>
								</c:when>
								<c:otherwise>
									<th colspan="4">결재자</th>
								</c:otherwise>
							</c:choose>																					
						</tr>
						
						<tr>
							<c:choose>
							<%-- 최종결재자만 표시되는 경우 본인으로 표시 --%>
							<c:when test="${pass_approval eq '1' }">
								<td colspan="4">
									${mbrVo_Session.user_name}
									<%-- <c:choose>
										<c:when test="${approvalList3.size() > 0}">
											인사총무팀											
										</c:when>
										<c:otherwise>
											최종 확인자가 없습니다.
										</c:otherwise>
									</c:choose> --%>
								</td>
							</c:when>
							<c:otherwise>
								<%-- 결재자 --%>								
								<td colspan="4">
									${approvaler_name_01}
								</td>
								<%-- 최종결재자 --%>								
								<%-- <td colspan="2">
									<c:choose>
										<c:when test="${approvalList3.size() > 0}">
											인사총무팀
											<c:forEach items="${approvalList3}" var="item" varStatus="status">
												${item.user_name} <br/>
											</c:forEach>
										</c:when>
										<c:otherwise>
											최종 확인자가 없습니다.
										</c:otherwise>
									</c:choose>
								</td> --%>
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
	
	<script>
		$(document).ready( function(){			
			
			/**
			$("input:radio[name=vacation_kind]").click(function(){
				var chkVal = $("input:radio[name=vacation_kind]:checked").val();
				$("#checkedVacationVal").val(chkVal);			//체크한 휴가코드를 Set 한다.
				
				var chkSubVal = $("input:radio[name=vacation_kind_half]:checked").val();
				$("#checkedVacationSubVal").val(chkSubVal);			//체크한 반차 휴가코드를 Set 한다.
				
				//휴가안내 기능추가
				if( chkVal == '100' ){
					$("#vacation_info_text").html("<b>연차</b> : 1일 유급휴가");
				}else if(chkVal == '200'){
					$("#vacation_info_text").html("<b>반차</b> : 오전반차, 오후반차");					
				}else if(chkVal == '301'){
					$("#vacation_info_text").html("<b>경조사(결혼)</b> : 본인 5일");
					$("#overDay").html('');
				}else if(chkVal == '302'){
					$("#vacation_info_text").html("<b>경조사(회갑)</b> : 본인 및 배우자 2일 / 본인 및 배우자의 부모 1일");
					$("#overDay").html('');
				}else if(chkVal == '303'){
					$("#vacation_info_text").html("<b>경조사(사망)</b> : 배우자 7일 / 본인 및 배우자의 부모 5일 / 본인 및 배우자의 형제자매 3일 </br>본인 및 배우자의 조부모 2일");
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
				}else if(chkSubVal == '201'){
					$("#vacation_info_text").html("<b>오전반차</b> : 09:00 ~ 13:00");
				}else if(chkSubVal == '202'){
					$("#vacation_info_text").html("<b>오후반차</b> : 14:00 ~ 18:00");
				}else{
					$("#vacation_info_text").html("");
				}				
				
				if( chkVal == '700' ){					
					$("#vacation_info_text").html("<b>예비군(민방위)</b> : 예비군, 민방위훈련");
					//예비군인 경우 첨부파일을 활성화한다.
					$("#tr_vacation_file").show();
					$(".tr_vacation_half_view").hide();
					$("#overDay").html('');
				}else if( chkVal == '200' ){					
					$(".tr_vacation_half_view").show();
				}else{
					$(".tr_vacation_half_view").hide();
					$("#tr_vacation_file").hide();					
				}
				
				//기간이 선택된 상태에서 휴가종류를 바꾼경우
				if( $("#vacation_end_date").val() != "" && $("#vacation_start_date").val() != "" ){
					doVacationCal();
				}
				
			});
			**/
			
			
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
		
		//휴가 라디오 버튼 클릭시 체크
		function changeVacationClick(){			
			var chkVal = $("input:radio[name=vacation_kind]:checked").val();
			$("#checkedVacationVal").val(chkVal);			//체크한 휴가코드를 Set 한다.
			
			var chkSubVal = $("input:radio[name=vacation_kind_half]:checked").val();
			$("#checkedVacationSubVal").val(chkSubVal);			//체크한 반차 휴가코드를 Set 한다.
			
			var chkQuarterVal = $("input:radio[name=vacation_kind_quarter]:checked").val();
			$("#checkedVacationQuarterVal").val(chkSubVal);			//체크한 반반차 휴가코드를 Set 한다.
			
			//휴가안내 기능추가
			if( chkVal == '100' ){
				$("#vacation_info_text").html("<b>연차</b> : 1일 유급휴가");
			}else if(chkVal == '200'){
				$("#vacation_info_text").html("<b>반차</b> : 오전반차, 오후반차");
				//반차안내 시작			
				if(chkSubVal == '201'){					
					$("#vacation_info_text").html("<b>오전반차</b> : 09:00 ~ 13:00 (휴게시간 미포함)");
				}else if(chkSubVal == '202'){					
					$("#vacation_info_text").html("<b>오후반차</b> : 14:00 ~ 18:00");
				}
			}else if(chkVal == '210'){					//반반차 안내 시작
				$("#vacation_info_text").html("<b>반&middot;반차</b> : 2시간 단위로 사용가능한 부분연차");
				//반반차안내 시작			
				if(chkQuarterVal == '211'){					
					$("#vacation_info_text").html("<b>반&middot;반차시간</b> : 09:00 ~ 11:00");
				}else if(chkQuarterVal == '212'){
					$("#vacation_info_text").html("<b>반&middot;반차시간</b> : 10:00 ~ 12:00");
				}else if(chkQuarterVal == '213'){
					$("#vacation_info_text").html("<b>반&middot;반차시간</b> : 11:00 ~ 14:00");
				}else if(chkQuarterVal == '214'){
					$("#vacation_info_text").html("<b>반&middot;반차시간</b> : 13:00 ~ 15:00");
				}else if(chkQuarterVal == '215'){
					$("#vacation_info_text").html("<b>반&middot;반차시간</b> : 14:00 ~ 16:00");
				}else if(chkQuarterVal == '216'){
					$("#vacation_info_text").html("<b>반&middot;반차시간</b> : 15:00 ~ 17:00");
				}else if(chkQuarterVal == '217'){
					$("#vacation_info_text").html("<b>반&middot;반차시간</b> : 16:00 ~ 18:00");
				}
			}else if(chkVal == '301'){
				$("#vacation_info_text").html("<b>경조사(결혼)</b> : 본인 5일");
				$("#overDay").html('');
			}else if(chkVal == '302'){
				$("#vacation_info_text").html("<b>경조사(회갑)</b> : 본인 및 배우자 2일 / 본인 및 배우자의 부모 1일");
				$("#overDay").html('');
			}else if(chkVal == '303'){
				$("#vacation_info_text").html("<b>경조사(사망)</b> : 배우자 7일 / 본인 및 배우자의 부모 5일 / 본인 및 배우자의 형제자매 3일 </br>본인 및 배우자의 조부모 2일");
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
				$(".tr_vacation_half_view").hide();
				$(".tr_vacation_quarter_view").hide();
				$("#overDay").html('');
			}else if( chkVal == '200' ){
				$(".tr_vacation_half_view").show();
				$(".tr_vacation_quarter_view").hide();
			}else if( chkVal == '210' ){				
				$(".tr_vacation_quarter_view").show();
				$(".tr_vacation_half_view").hide();
			}else{
				$(".tr_vacation_half_view").hide();
				$(".tr_vacation_quarter_view").hide();
				$("#tr_vacation_file").hide();
			}
			
			//반차가 아닌경우 반차 설정값 초기화
			if( chkVal != '200' ){
				$("input:radio[name=vacation_kind_half]").prop("checked",false);
			}
			
			//반반차가 아닌경우 반차 설정값 초기화
			if( chkVal != '210' ){
				$("input:radio[name=vacation_kind_quarter]").prop("checked",false);
			}
			
			//반차, 반반차는 시작시간을 vacation_option 에 설정한다.
			if( chkVal == '200' ){
				$("#vacation_option").val(chkSubVal);		//오전반차:201, 오후반차:202
			}else if( chkVal == '210' ){
				$("#vacation_option").val(chkQuarterVal);		//반반차 시작시간 설정 (211>09:00 ~ 217>16:00)
			}else{							//반차, 반반차 외에는 옵션값 초기화
				$("#vacation_option").val(0);
			}
			
			//기간이 선택된 상태에서 휴가종류를 바꾼경우
			if( $("#vacation_end_date").val() != "" && $("#vacation_start_date").val() != "" ){				
				doVacationCal();
			}
		}
		
		
		//두날짜를 비교해서 시작일이 종료일보다 작으면 false, 크면 true (20240131 오류수정)
		function dateChk(startDate, endDate){			
			var sDate = new Date(startDate);
			var eDate = new Date(endDate);			
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
			param.checkedVacationSubVal				= $("#checkedVacationSubVal").val();				//반차코드
			param.checkedVacationQuarterVal				= $("#checkedVacationQuarterVal").val();		//반반차코드
			
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
						if( $("#checkedVacationVal").val() == '100' || $("#checkedVacationVal").val() == '200' || $("#checkedVacationVal").val() == '210' ) {
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
								//선연차 체크는 결재완료 시점에 한다. by top3009 (20220113)
								//$("#next_use").val(1);
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
	
		function fnVacationIns(){
			
        	$("#vacation_start_date").val("");
        	$("#vacation_end_date").val("");
        	$("#vacation_comment").val("");
        	$("input:radio[name='vacation_kind']").prop('checked', false);
        	$("#vacation_mod_no").val("");
        	$("#vacation_mod_state").val("");
        	$("#vacation_state").hide();
        	
        	$("#vacation_start_date").prop("disabled",false);
        	$("#vacation_end_date").prop("disabled",false);
        	$("#vacation_comment").prop("disabled",false);
        	//$("input:radio[name='vacation_kind']").prop("disabled",false);
        	
        	//휴가타입 초기화
        	var chkVal = $("input:radio[name=vacation_kind]:checked").val();
			$("#checkedVacationVal").val(chkVal);
			
			//휴가안내 초기화
			$("#vacation_info_text").html('');
        	
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
			$(".tr_vacation_half_view").hide();			//반차선택 가림
			$(".tr_vacation_quarter_view").hide();			//반반차선택 가림
			
			//신청일 경우 결재내역을 가린다.
			$("#return_comment_tr").hide();
			
			//선연차사용 체크박스 초기화			
			$("input:checkbox[id='overDayChk']").prop("checked", false);
			
			//선연차 플래그 값 초기화
			$("#next_use").val(0);
			
			//결재자없는 경우 체크			
			//alert("notapproval="+$("#notApproval").val());			
        	
			$("#vacation-action-dialog").dialog({
				height: 750,
				width: 800,
				closeOnEscape : true,
				draggable : true,
				appendTo : "#vacationActionFrm",
				title: "휴가 신청",
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
		
		
		
		function fnVacationMod( p_no ){			
			//var label1 = "내용 수정";
			var label2 = "신청 취소";
			var label3 = "창닫기";
			var modalButtons = {};
			
			//기존 결재정보가 있으면 취소 제외			
			var ap_date_01 = $("#ap_date_01_"+p_no).val();			
			
			//1차결재 대기인경우만 취소가 가능하다.
			if( $("#approval_state").val() == 30 && ap_date_01 == "" ){
				//결재 내역 표시 안함
				$("#return_comment_tr").hide();
				modalButtons[label2] = function(){ if(!confirm("신청 취소 하시겠습니까?"))return; fnVacationAction('D') };
				modalButtons[label3] = function(){ $(this).dialog("close") };
			}else{
				modalButtons[label3] = function(){ $(this).dialog("close") };
			}
			
			//반차, 반반차 입력폼을 막아준다			
			$(".tr_vacation_half_view").hide();
			$(".tr_vacation_quarter_view").hide();
			
			//휴가신청일을 셋팅해준다.			
			$("#vacation_interval_info").text($("#vacationIntervalVal").val());
			
			$("#vacation-action-dialog").dialog({
				height: 650,
				width: 800,
				closeOnEscape : true,
				draggable : false,
				appendTo : "#vacationActionFrm",
				title: "휴가 상세보기",
				buttons : modalButtons,
				modal: true,
				overlay:{ opacity: 0., background: '#000000'}
			});			
		}
		
		function fnVacationAction(action,vacationState){			
			
			var vacationStartdate =  $("#vacation_start_date").val();
			var vacationEnddate = $("#vacation_end_date").val();
						
			if (action == "C" || action == "U"){
								
				if ( !$("input:radio[name='vacation_kind']").is(":checked") ){
					alert("휴가 종류를 선택 해 주세요.");
					return false;
				}
				
				//반차 선택 시 오전, 오후 체크
				if( $("input:radio[name=vacation_kind]:checked").val() == 200 ){
					if( !$("input:radio[name='vacation_kind_half']").is(":checked") ){
						alert("반차휴가 종류를 선택해 주세요.");
						return false;	
					}
				}
				
				//반반차 선택 시 시간 체크
				if( $("input:radio[name=vacation_kind]:checked").val() == 210 ){
					if( !$("input:radio[name='vacation_kind_quarter']").is(":checked") ){
						alert("반·반차휴가 시작시간을 선택해 주세요.");
						return false;	
					}
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
				
				if ( $("input:radio[name=vacation_kind]:checked").val() == 210
					&& ( $("#vacation_start_date").val() != $("#vacation_end_date").val() )	){
					alert("반·반차는 시작일과 종료일이 같아야 합니다.");
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
				if($("#vacation_interval_cal").text() < 0 && ( $("input:radio[name=vacation_kind]:checked").val() == 100 || $("input:radio[name=vacation_kind]:checked").val() == 200 || $("input:radio[name=vacation_kind]:checked").val() == 210)){
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
			
			var url = "/actionVacationNew";
			
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
		    param.append("vacation_basedate", $("#vacation_start_date_val").text());		    	//취소시 사용하는 base_date
		    		    
		    param.append("vacationTeamType", $("#vacation_team_type").val());
		    param.append("vacationStartDate", vacationStartdate);
		    param.append("vacationEndDate", vacationEnddate);
		    param.append("vacationComment", $("#vacation_comment").val());
		    param.append("vacationKind", $("input:radio[name='vacation_kind']:checked").val());		    
		    param.append("vacationType", $("#vacation_type").val());
		    
		    //반차, 반반차 옵션 추가 (반반차 옵션이 없는 경우 0으로 초기화)
		    var vacationOptionVal = $("#vacation_option").val();
		    if( vacationOptionVal == ""){
		    	vacationOptionVal = "0";
		    }		    
		    param.append("vacationOption",vacationOptionVal);
		    		    
		    param.append("teamManager", $("#teamManager").val());
		    param.append("teamManagerYn", $("#teamManagerYn").val());
		    param.append("centerManager", $("#centerManager").val());
		    
		    param.append("vacationIntervalVal",$("#vacationIntervalVal").val());		//휴가신청일수 추가
		   	param.append("notApproval",$("#notApproval").val());							//결재자없는경우 예외처리 플래그
		   	
		   	param.append("passApproval",$("#pass_approval").val());				//passApproval : 0 (정상결재), 1: 부문장 또는 결재대상이 없어 최종결재로 넘어감
		   	param.append("approvaler_01",$("#approvaler_01").val());				//결재자(1차): passApproval 이 1인 경우는 없을수도 있음
		   	param.append("approvaler_03",$("#approvaler_03").val());				//결재자(1차): passApproval 이 1인 경우는 없을수도 있음
		   	
		   	param.append("next_use",$("#next_use").val());				//선연차사용시 플래그 1로 표시
		   	
		   	param.append("remain_vacation_use",$("#remain_vacation_use").val());		//휴가 신청시점의 남아있는 연차 항목추가
		    			
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
		        		location.href="./myVacationMainNew";
		        	}else if (data.result == "0010"){//수정
		        		fnGoPage(pageIdx);
		        		$("#vacation-action-dialog").dialog("close");		        		
		        	}else if (data.result == "0020"){//취소
		        		alert("휴가 신청취소가 완료되었습니다.");
		        		fnGoPage(pageIdx);
		        		$("#vacation-action-dialog").dialog("close");		        		
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
