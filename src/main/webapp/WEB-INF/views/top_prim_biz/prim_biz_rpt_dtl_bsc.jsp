<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>

<script>
	$(document).ready(function(){
		$("#suimTmMbrPopBtn").click(function(){//담당 팀, 담당 직원 바꾸기 팝업
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=500; //띄울 창의 넓이
			var sh=550;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suimTmMbrPop?gbNo='+$("#gbNoForPop").val()+'&smNo='+$("#smNoForPop").val()+'&tmNo='+$("#tmNoForPop").val(),'SuimTmMbrPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		});//$("#suimTmMbrPopBtn").click

		$("#suimPtnrMbrPopBtn").click(function(){//보험사, 보험사 직원 바꾸기 팝업
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=500; //띄울 창의 넓이
			var sh=550;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suimPtnrMbrPop?gbNo='+$("#gbNoForPop").val()+'&smNo='+$("#smNoForPop").val()+'&ptnrNo='+$("#ptnrNoForPop").val(),'SuimTmMbrPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		});//$("#suimPtnrMbrPopBtn").click
		
		$("#printPrimRpt").click(function(){
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
			var sw=1010; //띄울 창의 넓이
			var sh=740;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			
			window.open('printPrimRpt?suim_rpt_no='+$("#suimRptNo").val(),'_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		});
	});//$(document).ready

	function openSMS(hpNo){//SMS 오픈
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		var sw=380; //띄울 창의 넓이
		var sh=533;  //띄울 창의 높이
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		window.open('simpleSMSForm?hpNo='+hpNo,'simpleSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}//openSMS

	function openBrdRefPtnr(ptnrSearch){//보험사 자료실 오픈
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		var sw=1010; //띄울 창의 넓이
		var sh=740;  //띄울 창의 높이
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		window.open('referencePtnrBoardListPop?ptnrSearch='+ptnrSearch,'simpleSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}//openSMS

	/* 기본정보 수정 페이지 이동 */
	function primBizSuimUdtPage(suim_rpt_state, edit_yn, end_mod_auth){
		
		if (end_mod_auth == 0){
			if(suim_rpt_state != 0){
				alert("미결 건만 수정 가능합니다.");
				return;
			}
			if(edit_yn == 0){
				alert("수정 권한이 없습니다.");
				return;
			}
		}
		
		$("#editPrimBizRptBscTab").click();
	}
	
	
</script>

<input type="hidden" name="gbNoForPop" id="gbNoForPop" value="2" />
<input type="hidden" name="ptnrNoForPop" id="ptnrNoForPop" value="${primBizRptDtl.ptnr_id}" />
<input type="hidden" name="smNoForPop" id="smNoForPop" value="${primBizRptDtl.suim_rpt_no}" />
<input type="hidden" name="tmNoForPop" id="tmNoForPop" value="${primBizRptDtl.team_id}" />

						<table style="margin-bottom:5px;">
							<tr>
								<td align="left" style="padding-left:10px;">
									<c:if test="${primBizRptDtl.lock_flag eq '1' and mbrAuthVo_Session.mbr_pms_5 eq '1'}">
										<img src="./resources/ls_img/report/icon_lock.gif" border="0" style="cursor:pointer;"
											onclick="primBizRptStateChange('primBizRptStateChgUnLock');" />
									</c:if>
									<b> 보고서 기본 정보</b>
								</td>
								<td align="right" style="padding-right:10px;">
									<!-- suim_rpt_state change -->
									<c:choose>
										<c:when test="${primBizRptDtl.suim_rpt_state eq '31'}">
											<!-- 위임취소 프로세스 추가 170801 -->
											<c:choose>   
												<c:when test="${primBizRptDtl.close_pms_yn ne 0 or primBizRptDtl.user_no eq mbrVo_Session.user_no}">												
													<c:if test="${primBizRptDtl.rptCancelApprovalAuthYN ne 0}">
														<img src="./resources/ne_img/btn/btn_aprv_cancel.gif" onclick="fnRptCancelApproval();" style="cursor:pointer;"/>
													</c:if>
													<img src="./resources/ne_img/btn/btn_mod_cancel.gif" onclick="fnRptCancelMod();" style="cursor:pointer;"/>
													<img src="./resources/ne_img/btn/btn_reqcancel_cancel.gif" onclick="fnRptCancelDel();" style="cursor:pointer;"/>
												</c:when>
												
												<c:otherwise>
													<img src="./resources/ne_img/btn/btn_ing_cancel.gif" style="cursor:pointer; margin-top:3px;"/>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
										
											<!-- submit -->
											<c:if test="${primBizRptDtl.suim_rpt_state eq '0' and primBizRptDtl.editYN2 > 0}">
												<img src="./resources/ls_img/report/btn_rch_1.gif" border="0" style="cursor:pointer;"
													 onclick="primBizRptStateChange2('primBizRptStateChgSubmit');" />
												
												<c:if test="${primBizRptDtl.user_no == mbrVo_Session.user_no}">
													<img src="./resources/ne_img/btn/btn_single_submit.png" border="0" style="cursor:pointer;"
														 onclick="primBizRptSingleSubmit();" />												
												</c:if>
													
											</c:if>
											<!-- submitX -->
											<c:if test="${(primBizRptDtl.suim_rpt_state eq '1' or primBizRptDtl.suim_rpt_state eq '11') and primBizRptDtl.editYN2 > 0}">
												<img src="./resources/ls_img/report/btn_rch_1x.gif" border="0" style="cursor:pointer;"
													onclick="primBizRptStateChange('primBizRptStateChgSubmitX');" />
											</c:if>
											<!-- return -->
											<c:if test="${primBizRptDtl.suim_rpt_state eq '1' and primBizRptDtl.close_pms_yn != 0}">
												<img src="./resources/ls_img/report/btn_rch_return.gif" border="0" style="cursor:pointer;"
													onclick="primBizRptStateChange('primBizRptStateChgReturn');" />
											</c:if>
											<!-- returnX -->
											<c:if test="${primBizRptDtl.suim_rpt_state eq '11' and primBizRptDtl.user_no eq mbrVo_Session.user_no}">
												<img src="./resources/ls_img/report/btn_rch_return_x.gif" border="0" style="cursor:pointer;"
													onclick="primBizRptStateChange('primBizRptStateChgReturnX');" />
											</c:if>
											<!-- close -->
											<c:if test="${primBizRptDtl.suim_rpt_state eq '1' and primBizRptDtl.close_pms_yn != 0}">
												<img src="./resources/ls_img/report/btn_rch_2.gif" border="0" style="cursor:pointer;"
													onclick="primBizRptStateChange('primBizRptStateChgClose');" />
											</c:if>
											<!-- closeX -->
											<c:if test="${primBizRptDtl.suim_rpt_state eq '2' and mbrAuthVo_Session.mbr_pms_4 eq '1'}">
												<img src="./resources/ls_img/report/btn_rch_2x.gif" border="0" style="cursor:pointer;"
													onclick="primBizRptStateChange('primBizRptStateChgCloseX');" />
											</c:if>
											
											<!-- delete -->
											<c:if test="${primBizRptDtl.suim_rpt_state ne '2' and mbrAuthVo_Session.mbr_pms_3 eq '1'}">
												<img src="./resources/ls_img/report/btn_report_del.gif" border="0" style="cursor:pointer;"
													ONCLICK="primBizRptStateChange('primBizRptStateChgDel');" />
											</c:if>
											
											<!-- cancel -->
											<c:if test="${primBizRptDtl.suim_rpt_state < 2 and (primBizRptDtl.close_pms_yn ne 0 or mbrVo.user_no eq suimVO.user_no)}">
												<img src="./resources/ls_img/report/btn_rch_3.gif" border="0" style="cursor:pointer;"
													 ONCLICK="fnRptCancelIns();" />
											</c:if>											
											
											<!-- cancelX -->
											<c:if test="${primBizRptDtl.suim_rpt_state eq '3' and mbrAuthVo_Session.mbr_pms_4 eq '1'}">
												<img src="./resources/ls_img/report/btn_rch_3x.gif" border="0" style="cursor:pointer;"
													 ONCLICK="fnRptCancelRestore();" />
											</c:if>
											
											<!-- cancel -->
											<!-- 위임취소 프로세스 적용 후 미사용 170803 by.lds -->
											<!-- 
											<c:if test="${primBizRptDtl.suim_rpt_state < 2 and mbrAuthVo_Session.mbr_pms_3 eq '1'}">
												<img src="./resources/ls_img/report/btn_rch_3.gif" border="0" style="cursor:pointer;"
													 ONCLICK="primBizRptStateChange('primBizRptStateChgCancel');" />
											</c:if>
											 -->
											<!-- cancelX -->
											<!-- 위임취소 프로세스 적용 후 미사용 170803 by.lds -->
											<!--  
											<c:if test="${primBizRptDtl.suim_rpt_state eq '3' and mbrAuthVo_Session.mbr_pms_3 eq '1'}">
												<img src="./resources/ls_img/report/btn_rch_3x.gif" border="0" style="cursor:pointer;"
													 ONCLICK="primBizRptStateChange('primBizRptStateChgCancelX');" />
											</c:if>
											 -->

										</c:otherwise>
									</c:choose>
									<!-- //suim_rpt_state change -->
								</td>
							</tr>
						</table>
						<div class= "tableStyle21">
							<table>
								<colgroup>
									<col width="12.5%">
									<col>
									<col width="12.5%">
									<col>
									<col width="12.5%">
									<col>
								</colgroup>
								<tr>
									<td bgcolor="#E7ECF1"><b>접수번호</b></td>
									<td style="border-right:0;">
										${primBizRptDtl.suim_accept_no}
										<%-- <c:if test="${primBizRptDtl.moral_flag > 0}"><font color='#ff0099'>${primBizRptDtl.moral_flag_nm}</font></c:if> --%>
										<c:if test="${primBizRptDtl.lock_flag == 0}">
											<img id="printPrimRpt" style = "cursor:pointer; float:right;" src="./resources/ls_img/icon_print_info.gif"/>
										</c:if>
									</td>
									
									<c:choose>
										<c:when test="${primBizRptDtl.registrant != 0}">
											<td bgcolor="#E7ECF1"><b>수임 등록자</b></td>
											<td>${primBizRptDtl.registrant_nm}</td>
											<td colspan="2" style="border-left:0;">
												<img style = "cursor:pointer; float:right; margin-right:5px;" src="./resources/ls_img/btn_edite.gif"
													onclick="primBizSuimUdtPage('${primBizRptDtl.suim_rpt_state}','${primBizRptDtl.edit_yn}', '${primBizRptDtl.endModAuth}');" />
											</td>											
										</c:when>
										<c:otherwise>
											<td colspan="4" style="border-left:0;">
												<img style = "cursor:pointer; float:right; margin-right:5px;" src="./resources/ls_img/btn_edite.gif"
													onclick="primBizSuimUdtPage('${primBizRptDtl.suim_rpt_state}','${primBizRptDtl.edit_yn}', '${primBizRptDtl.endModAuth}');" />
											</td>		
										</c:otherwise>
									</c:choose>
								</tr>
								
								<c:if test="${primBizRptDtl.suim_rpt_state eq '31' or primBizRptDtl.suim_rpt_state eq '3'}">
									<tr>
										<td bgcolor="#E7ECF1"><b>위임취소 사유</b></td>
										<td colspan="5" style="border-left:0;">
											${fn:replace(fn:replace(fn:escapeXml(rptCancel.cancelReason) , CRLF , '<br>'), ' ', '&nbsp;')}
										</td>
									</tr>
								</c:if>
								
								<tr>
									<td bgcolor="#E7ECF1"><b>구분</b></td>
									<td>${primBizRptDtl.suim_rpt_type1_nm}</td>
									<td bgcolor="#E7ECF1"><b>현재상태</b></td>
									<td>${primBizRptDtl.suim_rpt_state_nm}</td>
									<td bgcolor="#E7ECF1"><b>민원관련</b></td>
									<td>${primBizRptDtl.minwon_flag_nm}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>처리팀</b></td>
									<td>${primBizRptDtl.team_name}</td>
									<td bgcolor="#E7ECF1"><b>처리 담당자</b></td>
									<td style="border-right:0;">
										<c:if test="${primBizRptDtl.mbrChgAuthYN == 1}">
											<img src="./resources/ls_img/report/icon_change.gif" id="suimTmMbrPopBtn" style="cursor:pointer;" border="0" width="14" height="14">
										</c:if>
										${primBizRptDtl.user_name}
										<c:if test="${primBizRptDtl.handphone != ''}">
											&nbsp;<img src="./resources/ls_img/report/icon_hp.gif" style="cursor:pointer;" onclick="openSMS('${primBizRptDtl.handphone}');" />
											${primBizRptDtl.handphone}
										</c:if>
									</td>
									<td colspan="2" style="border-left:0;"></td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>보험사</b></td>
									<td>
										${primBizRptDtl.ptnr_name}
										<c:if test="${primBizRptDtl.ptnr_id != ''}">
											&nbsp;<img src="./resources/ls_img/report/icon_ig_pds.gif" style="cursor:pointer;" onclick="openBrdRefPtnr('${primBizRptDtl.ptnr_id}');" />
										</c:if>
									</td>
									<td bgcolor="#E7ECF1"><b>보험사 담당자</b></td>
									<td>
										<c:if test="${primBizRptDtl.suim_rpt_state == 0 && primBizRptDtl.ptnrMbrChgAuthYN > 0}">
											<img src="./resources/ls_img/report/icon_change.gif" id="suimPtnrMbrPopBtn" style="cursor:pointer;" border="0" width="14" height="14">
										</c:if>
										${primBizRptDtl.ptnr_mbr_nm}
										<c:if test="${primBizRptDtl.ptnr_mbr_hp != ''}">
											&nbsp;<img src="./resources/ls_img/report/icon_hp.gif" style="cursor:pointer;" onclick="openSMS('${primBizRptDtl.ptnr_mbr_hp}');" />
											${primBizRptDtl.ptnr_mbr_hp}
										</c:if>
									</td>
									<td bgcolor="#E7ECF1"><b>보험사 담당부서</b></td>
									<td>
									<!-- 종결된 경우는 종결시점저장된 보험사 부서팀명으로 표시 by top3009 -->
										<c:choose>
											<c:when test="${primBizRptDtl.suim_rpt_state eq 2}">
												${primBizRptDtl.close_ptnr_dept_nm}
												<c:if test="${primBizRptDtl.close_ptnr_tm2_nm ne ''}">(${primBizRptDtl.close_ptnr_tm2_nm})</c:if>
											</c:when>
											<c:otherwise>
												${primBizRptDtl.ptnr_dept_name}
												<c:if test="${primBizRptDtl.ptnr_tm2_nm ne '' and primBizRptDtl.ptnr_tm2_nm ne null}">
													(${primBizRptDtl.ptnr_tm2_nm})
												</c:if>
											</c:otherwise>
										</c:choose>	
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>사고번호</b></td>
									<td>${primBizRptDtl.accident_no}</td>
									<td bgcolor="#E7ECF1"><b>증권번호</b></td>
									<td>${primBizRptDtl.policy_no}</td>
									<td bgcolor="#E7ECF1"><b>보험종목</b></td>
									<td>${primBizRptDtl.insurance_nm}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>계약자</b></td>
									<td>${primBizRptDtl.policyholder_nm}</td>
									<td bgcolor="#E7ECF1"><b>피보험자</b></td>
									<td>${primBizRptDtl.beneficiary_nm}</td>
									<td bgcolor="#E7ECF1"><b>피해자/피해물</b></td>
									<td>${primBizRptDtl.damaged_nm}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>계약자 연락처</b></td>
									<td>${primBizRptDtl.policyholder_tel}</td>
									<td bgcolor="#E7ECF1"><b>피보험자 연락처</b></td>
									<td>${primBizRptDtl.beneficiary_tel}</td>
									<td bgcolor="#E7ECF1"><b>피해자 연락처</b></td>
									<td>${primBizRptDtl.damaged_tel}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>사고내용</b></td>
									<td colspan="5">${primBizRptDtl.accident_facts}</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>사고일</b></td>
									<td>${primBizRptDtl.accident_date_fmt}</td>
									<td bgcolor="#E7ECF1"><b>수임일</b></td>
									<td style="border-right:0;">${primBizRptDtl.reg_date_fmt}</td>
									<td bgcolor="#E7ECF1"><b>종결일</b></td>
									<td style="border-right:0;">
										${primBizRptDtl.close_date_fmt}
										<c:if test="${mbrVo_Session.user_state == 9 && primBizRptDtl.suim_rpt_state == 2}">
												<c:import url="../util_rpt/inc_edit_close_date.jsp"></c:import>
										</c:if>
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>추정손해액</b></td>
									<td>${primBizRptDtl.amt_estimated_damage} 원</td>
									<td bgcolor="#E7ECF1"><b>추정수수료</b></td>
									<td style="border-right:0;">${primBizRptDtl.commission_estimated} 원</td>
									<td colspan="2" style="border-left:0;"></td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>조사지역</b></td>
									<td colspan="5">
										${primBizRptDtl.investigate_postcode}
										${primBizRptDtl.investigate_addr1}
										${primBizRptDtl.investigate_addr2}</td>
								</tr>
							</table>
						</div>
