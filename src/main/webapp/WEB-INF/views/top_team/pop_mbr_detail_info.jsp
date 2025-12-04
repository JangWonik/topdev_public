<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
	.btn-certi-aprv {
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
		width:150px;
		height:0px;
		padding:10px;
		border-color:#e1e1e1;
		border-width:1px;
		border-style:solid;
		background: #eeeeee;
	}	
</style>	
		<div class="tableStyle5" >
			<div style = "width:29%; float:right; text-align:center; ">
				<div style = "width:100%;  height:200px; margin-top:20px; margin-bottom: 20px;r">
					<img id="myimage" src="${imageBase64}"  width="120" height="150" alt="사원사진" />
					<br /><br />
					<c:choose>
						<c:when test="${imageBase64 != null}">
							<img src="./resources/ls_img/btn_del.gif" id="myimageDel" style="margin-top:10px;cursor: pointer;"/>
						</c:when>
						<c:otherwise>
							<%@include file="../include/uploadform.jsp"%>	
						</c:otherwise>
					</c:choose>
				</div>
				
				<div style = "border:1px solid gray; width:98%;  height:100px; overflow:scroll;">
					도장 : <%@include file="../include/uploadform_sign.jsp"%>
				</div>
				<div style = "border:1px solid gray; width:98%;  height:100px; overflow:scroll;margin-top: 5px;">
					MMS 이미지(220 X 180) : <c:import url="../include/uploadform_mms.jsp"/>
				</div>
			</div>

			 
			<form id="mbrDetailFrm" name = "mbrDetailFrm" method="post" action="updateMbrDetailInfo"> 
				<input type="hidden" name ="user_no" id ="user_no" value = "${memberVo.user_no}"/>
				<input type="hidden" name ="user_id" id ="user_id" value = "${memberVo.user_id}"/>
				<input type="hidden" name="user_name" id="user_name" value="${memberVo.user_name}" />
				<input type="hidden" name="user_cert_ckey" id="user_cert_ckey" value="${userCertCkey}"/><!-- top_mbr_cert의 ckey -->
												
				<table class="memberDetailTable" style="float:left;" border="0" cellpadding="0" cellspacing="0">
					<colgroup>
						<col width="20%">
						<col width="40%">
						<col width="20%">
						<col width="20%">
					</colgroup>
					<thead>
					<tr>
						<td width="20%" class = "tdHead" bgcolor="#efefef">이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</td>
						<td colspan="3" width="80%" style="text-align:left; padding-left:10px;"><span>${memberVo.user_name}</span></td>
					</tr>
					<tr>
						<td width="100" class = "tdHead" bgcolor="#efefef">아&nbsp;이&nbsp;디&nbsp;</td>
						<td colspan="3" width="400" style="text-align:left; padding-left:10px;"><span>${memberVo.user_id}</span>
						<input type="button" value = "비밀번호 초기화" id = "initialPw" />
						</td>
					</tr>
					<tr>
						<td width="100" class = "tdHead" bgcolor="#efefef">주&nbsp;민&nbsp;번&nbsp;호&nbsp;</td>
						<td colspan="3" width="400" style="text-align:left; padding-left:10px;"><span>${memberVo.jumin_no1}</span>&nbsp;&nbsp;-&nbsp;&nbsp;<span>${memberVo.jumin_no2}</span></td>
					</tr>
					<c:if test="${mbrVo_Session.user_state == 9}">
						<tr>
							<td width="100" class = "tdHead" bgcolor="#efefef">카카오(문자) 인증사용 여부</td>
							<td colspan="3" width="400" style="text-align:left; padding-left:10px;">
								<input type="radio" name="is_pass" id="is_pass0" value="0" > 사용중
								<input type="radio" name="is_pass" id="is_pass1" value="1" > 해제됨
								<input type="hidden" name="curr_is_pass" id="curr_is_pass" value="${memberVo.is_pass}"/>
							</td>
						</tr>
					</c:if>
					
					<tr>
						<td width="100" class = "tdHead" bgcolor="#efefef">센&nbsp;터&nbsp;명&nbsp;</td>
						<td colspan="3" width="400" style="text-align:left; padding-left:10px;">
							<span>${memberVo.center_name}</span>
						</td>
					</tr>
					
					<tr>
						<td width="20%" class = "tdHead" bgcolor="#efefef">부&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;서&nbsp;</td>
						<td colspan="3" width="80%" style="text-align:left; padding-left:10px;">
							<select id="team_id_main" name="team_id_main">
								<option value="0" selected>선택</option>
								<c:forEach items="${teamList}" var = "teamVo">
									<option value="${teamVo.team_id}">
									
									<c:if test="${teamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
									<c:if test="${teamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
									${teamVo.team_name}
									</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					
					<tr>
						<td width="20%" class = "tdHead" bgcolor="#efefef">현&nbsp;재&nbsp;위&nbsp;치</td>
						<td colspan="3" width="80%" style="text-align:left; padding-left:10px;">
							<select id="team_id_loc" name="team_id_loc" >
								<option value="0" selected>선택</option>
								<c:forEach items="${teamList}" var = "teamVo">
									<option value="${teamVo.team_id}">
									
									<c:if test="${teamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
									<c:if test="${teamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
									${teamVo.team_name}
									
									</option>
								</c:forEach>
							</select>
						</td>
					</tr>									
					
					<tr>
						<!-- 180108 직급/직책 에서 직위/직급으로 변경 -->
						<td class = "tdHead" bgcolor="#efefef">직위 / 직급 / 직책</td>
						<td colspan="3" style="text-align:left; padding-left:10px;">
							<select id="work_level" name="work_level">
								<c:forEach items="${workLevelList}" var = "levelVo">
									<option value="${levelVo.col_cd}">${levelVo.col_val}</option>
								</c:forEach>
							</select>
							
							<!-- 직급  -->
							<select id="work_rank" style="width:60px;" name="work_rank">
								<option value="">선택</option>
								<c:forEach var="item" items="${workRankList}" varStatus="status">
									<option value="${item.col_cd}">
										${item.col_val}
									</option>
								</c:forEach>
							</select>											

							<select id="work_type" name="work_type">
								<c:forEach items="${workTypeList}" var = "levelVo">
									<option value="${levelVo.col_cd}">${levelVo.col_val}</option>
								</c:forEach>
							</select>
							<input type="button" value="코드설명" onclick="fnCodeDsc();"/>
						</td>
					</tr>
					
					<tr>
						<td class = "tdHead" bgcolor="#efefef">직무 / 직무코드</td>
						<td colspan="3" style="text-align:left; padding-left:10px;">
							<select id="work_job" name="work_job">
								<option value="0">선택</option>
								<c:forEach items="${workJobList}" var="item" varStatus="status">
									<c:if test="${item.col_cd1 == memberVo.team_type2}">
										<option value="${item.col_cd2}" >
											${item.col_val}
										</option>
									</c:if>
								</c:forEach>
							</select>
							
							<span id="workJobCode" style="padding-left: 3px;">
								${memberVo.work_job_code}
							</span>
						</td>
					</tr>
					
					<!-- 겸직추가 시작 -->
					<tr>					
						<td width="20%" class="tdHead" bgcolor="#efefef">겸 직 부 서 / 직 책
							<img src="./resources/ls_img/btn_add_s.gif" border="0" onclick="fnSub_add();" style="cursor:pointer;"/>
						</td>
						<td colspan="3">
							<table>								
								<c:if test="${subJobList.size() == 0 }">
									<tr name="sub_tr">
										<td style="text-align:left; padding-left:10px;border-left:1px solid #FFFFFF;border-right:1px solid #FFFFFF;border-bottom:1px solid #FFFFFF;border-top:1px solid #FFFFFF">
											<select id="sub_team_id_main_0" name="sub_team_id_main" style="width:200px;">
												<option value="0" selected>선택</option>
												<c:forEach items="${teamList}" var = "teamVo">
													<option value="${teamVo.team_id}">												
													<c:if test="${teamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
													<c:if test="${teamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
													${teamVo.team_name}												
													</option>
												</c:forEach>
											</select>																						
											<select id="sub_work_type_0" name="sub_work_type">
												<c:forEach items="${workTypeList}" var = "levelVo">
													<option value="${levelVo.col_cd}">${levelVo.col_val}</option>
												</c:forEach>
											</select>
										</td>
									</tr>									
								</c:if>
								<c:if test="${subJobList.size() > 0 }">								
									<c:forEach items="${subJobList}" var="subJob"  varStatus="status">
										<tr name="sub_tr" id="sub_${status.index}">
											<td style="text-align:left; padding-left:10px;border-left:1px solid #FFFFFF;border-right:1px solid #FFFFFF;border-bottom:1px solid #FFFFFF;border-top:1px solid #FFFFFF">
												<select id="sub_team_id_main_${status.index}" name="sub_team_id_main" style="width:200px;">
													<option value="0">선택</option>													
													<c:forEach items="${teamList}" var = "teamVo">														
														<option value="${teamVo.team_id}" <c:if test="${ teamVo.team_id eq subJob.teamIdMain }">selected</c:if> >
														<c:if test="${teamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>
														<c:if test="${teamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>
														${teamVo.team_name}										
														</option>
													</c:forEach>
												</select>													 																		
												<select id="sub_work_type_${status.index}" name="sub_work_type">
													<c:forEach items="${workTypeList}" var = "levelVo">
														<option value="${levelVo.col_cd}" <c:if test="${ levelVo.col_cd eq subJob.workType }">selected</c:if> >${levelVo.col_val}</option>
													</c:forEach>
												</select>												
												<img src="./resources/ls_img/btn_del_s.gif" border="0" onclick="fnSub_del('sub_${status.index}');" style="cursor:pointer" />
											</td>
										</tr>
									</c:forEach>									
								</c:if>
								<input type="hidden" id="subJobCnt" value="${subJobList.size()}"/>
							</table>
						</td>									
					</tr>					
					<!-- 겸직추가 끝 -->
					
					<tr>
						<td class = "tdHead" bgcolor="#efefef">입&nbsp;사&nbsp;/&nbsp;퇴&nbsp;사&nbsp;일&nbsp;</td>
						<td colspan="3" style="text-align:left; padding-left:10px;">
							＊ 입사&nbsp;:&nbsp;<input type="text" id="join_date" name="join_date" size="10" value="${memberVo.join_date}" maxlength="10" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							＊ 퇴사&nbsp;:&nbsp;<input type="text" id="out_date" name="out_date" size="10" value="${memberVo.out_date}" maxlength="10" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							＊ 면수습 : <input type="text" id="probation_date" name="probation_date" size="10" value="${memberVo.probation_date}" maxlength="10" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<c:if test="${mbrVo_Session.user_state == 9}">							
							＊ 계약일 : <input type="text" class="calendar" id="CTDay" name="CTDay" size="10" value="${memberVo.CTDay}" maxlength="10" />
							</c:if>							
							<br />
							
							<input type="radio" name="user_state" id="user_state0" value="0" > 근무중
							<input type="radio" name="user_state" id="user_state3" value="3" > 휴직중 
							<input type="radio" name="user_state" id="user_state2" value="2" > 발령대기
							<input type="radio" name="user_state" id="user_state1" value="1" onclick="javascript:retireCertChek();"> 퇴사

							<input type="hidden" name="curr_user_state" id="curr_user_state" value="${memberVo.user_state}"/>
						</td>
					</tr>
					
					<!-- 성과급 관련 신입 / 경력직 여부설정 -->
					<tr>
						<td class = "tdHead" bgcolor="#efefef">신입직 / 경력직 여부</td>
						<td colspan="3" style="text-align:left; padding-left:10px;">
							<input type="radio" name="bonus_career_state" id="bonus_career_state0" value="0" > 신입직
							<input type="radio" name="bonus_career_state" id="bonus_career_state1" value="1" > 경력직
							<!-- <input type="radio" name="bonus_career_state" id="bonus_career_state2" value="2" > 일반직 -->
							<input type="hidden" name="curr_bonus_career_state" id="curr_bonus_career_state" value="${memberVo.bonus_career_state}"/>
						</td>
					</tr>
					
					<tr>
						<td class = "tdHead" bgcolor="#efefef">주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소&nbsp;</td>
						<td style="text-align:left; padding-left:10px;">
							<input type="text" name="home_address" id="home_address" size="50" value ="${memberVo.home_address}" style="ime-mode:active;">
							<span></span>
						</td>
						<!-- 현재지역 추가 시작-->
						<td class = "tdHead" bgcolor="#efefef">현&nbsp;재&nbsp;지&nbsp;역</td>
						<td align="center">
							<select name="person_zone" id="person_zone" style="width:150px;">
								<option value="0">선택</option>
								<c:forEach items="${zoneList}" var="personZone" varStatus="status">								
									<c:choose>										
										<c:when test="${memberVo.person_zone eq personZone.col_cd}">
											<option value="${personZone.col_cd}" selected="selected">${personZone.col_val}</option>
										</c:when>
										<c:otherwise>
											<option value="${personZone.col_cd}">${personZone.col_val}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</td>
						<!-- 현재지역 추가 끝-->
					</tr>
					
					<tr>
						<td class = "tdHead"  bgcolor="#efefef">자택 전화번호&nbsp;</td>
						<td colspan="3" style="text-align:left; padding-left:10px;">
							<input type="text" name="home_tel_1" id="home_tel_1" size="5" maxlength="4" value ="${home_tel_1}">
							-
							<input type="text" name="home_tel_2" id="home_tel_2" size="5" maxlength="4" value ="${home_tel_2}">
							-
							<input type="text" name="home_tel_3" id="home_tel_3" size="5" maxlength="4" value ="${home_tel_3}"> 
						</td>
					</tr>
					
					<tr>
						<td class = "tdHead"  bgcolor="#efefef">직통 전화번호&nbsp;</td>
						<td colspan="3" style="text-align:left; padding-left:10px;">
							<input type="text" name="officetel_1" id="officetel_1" size="5" maxlength="4" value = "${officetel_1}">
							-
							<input type="text" name="officetel_2" id="officetel_2" size="5" maxlength="4" value = "${officetel_2}">
							-
							<input type="text" name="officetel_3" id="officetel_3" size="5" maxlength="4" value = "${officetel_3}"> 
						</td> 
					</tr>
					
					<tr>
						<td class = "tdHead"  bgcolor="#efefef">팩스번호&nbsp;</td>
						<td colspan="3" style="text-align:left; padding-left:10px;">
							<input type="text" name="officefax_1" id="officefax_1" size="5" maxlength="4" value = "${officefax_1}">
							-
							<input type="text" name="officefax_2" id="officefax_2" size="5" maxlength="4" value = "${officefax_2}">
							-
							<input type="text" name="officefax_3" id="officefax_3" size="5" maxlength="4" value = "${officefax_3}"> 
						</td> 
					</tr>
					
					<tr>
						<td class = "tdHead" bgcolor="#efefef">핸 드 폰&nbsp;</td>
						<td colspan="3" style="text-align:left; padding-left:10px;">
							<input type="text" name="handphone_1" id="handphone_1" size="5" maxlength="4" value ="${handphone_1}" >
							-
							<input type="text" name="handphone_2" id="handphone_2" size="5" maxlength="4" value = "${handphone_2}">
							-
							<input type="text" name="handphone_3" id="handphone_3" size="5" maxlength="4" value = "${handphone_3}"> 
						</td>
					</tr>
					
					<tr>
						<td class = "tdHead"  bgcolor="#efefef">E - mail</td>
						<td colspan="3" style="text-align:left; padding-left:10px;">
							<input type="text" id="email" name="email" size="25" value="${memberVo.email}" />
						</td>
					</tr>
					
					<!-- 경조금 동의 여부 시작 -->
					<tr>
						<td width="100" class = "tdHead" bgcolor="#efefef">경조금 갹출 동의여부</td>
						<td colspan="3" width="400" style="text-align:left; padding-left:10px;">
							<input type="radio" name="exp_agree" id="exp_agree0" value="0" > 해당없음
							<input type="radio" name="exp_agree" id="exp_agree1" value="1" > 동의
							<input type="radio" name="exp_agree" id="exp_agree2" value="2" > 미동의
							<input type="hidden" name="curr_exp_agree" id="curr_exp_agree" value="${memberVo.exp_agree}"/>
						</td>
					</tr>
					<!-- 경조금 동의 여부 끝 -->					
					
					<!-- 보조인 등록정보 개선 시작 20250728 -->
					<tr>
						<td class = "tdHead" bgcolor="#efefef">보조인 등록정보</td>
						<td colspan="3" style="text-align:left; padding-left:10px;">
							<a href="javascript:certiSubManageModal(${memberVo.user_no});" class="btn-certi-aprv" style="background:#ececc5;width:50px;">관 리</a>
							<c:forEach items="${userCertiSubInfoList}" var="userCertiSub"  varStatus="status">								
								<c:set var="certiSubTypeText"></c:set>
								<c:set var="certiSubNumberText"></c:set>								
								<c:choose>
									<c:when test="${empty userCertiSub.certi_type}"></c:when>
									<c:otherwise>
										<c:set var="certiSubTypeText" value="${userCertiSub.certi_type_nm}"></c:set>
									</c:otherwise>
								</c:choose>
								
								<c:choose>
									<c:when test="${empty userCertiSub.certi_number}"></c:when>
									<c:otherwise>
										<c:set var="certiSubNumberText" value="${userCertiSub.certi_number}"></c:set>										
									</c:otherwise>
								</c:choose>
																
								<c:set var="certiSubFullText" value="[${certiSubTypeText}] [${certiSubNumberText}]"></c:set>
								<input type="button" class="btn-certi-aprv" style="width:200px;" id="certNemberTextButton" value="${certiSubFullText}">
																
								<c:if test="${userCertiSubInfoList.size() > status.count}">,</c:if>
							</c:forEach>
							
							<select id="certi_state_sub" name="certi_state_sub" style="width:140px;" onchange="fnCertiStateSubChange();">
								<option value="0" <c:if test="${memberVo.certi_state == 0}">selected</c:if> >미등록</option>
								<option value="1" <c:if test="${memberVo.certi_state == 1}">selected</c:if> >보조인 자격 충족</option>
								<option value="2" <c:if test="${memberVo.certi_state == 2}">selected</c:if> >보조인 자격 불충족</option>
								<option value="3" <c:if test="${memberVo.certi_state == 3}">selected</c:if> >비대상</option>
								<option value="4" <c:if test="${memberVo.certi_state == 4}">selected</c:if> >손해사정사</option>
								<option value="6" <c:if test="${memberVo.certi_state == 6}">selected</c:if> >손해사정사+보조인</option>
							</select>
						</td>
					</tr>
					<!-- 보조인 등록정보 개선 끝 20250728 -->
					<tr>
						<td class = "tdHead" bgcolor="#efefef">손해사정사 등록정보</td>
						<td colspan="3" style="text-align:left; padding-left:10px;">
							<input type="hidden" id="certiStateVal" name="certiStateVal" value="${memberVo.certi_state}">							
							<a href="javascript:certiManageModal(${memberVo.user_no});" class="btn-certi-aprv" style="background:#CEE3F6;width:50px;">관 리</a>
							<c:forEach items="${userCertiInfoList}" var="userCerti"  varStatus="status">								
								<c:set var="certiTypeText"></c:set>
								<c:set var="certiNumberText"></c:set>								
								<c:choose>
									<c:when test="${empty userCerti.certi_type}"></c:when>
									<c:otherwise>
										<c:set var="certiTypeText" value="${userCerti.certi_type_nm}"></c:set>
									</c:otherwise>
								</c:choose>
								
								<c:choose>
									<c:when test="${empty userCerti.certi_number}"></c:when>
									<c:otherwise>
										<c:set var="certiNumberText" value="${userCerti.certi_number}"></c:set>										
									</c:otherwise>
								</c:choose>
																
								<c:set var="certiFullText" value="[${certiTypeText}] [${certiNumberText}]"></c:set>
								<input type="button" class="btn-certi-aprv" style="width:200px;" id="certNemberTextButton" value="${certiFullText}">
																
								<c:if test="${userCertiInfoList.size() > status.count}">,</c:if>
							</c:forEach>																
							</td>
					</tr>
					<!-- 손해사정사 등록 번호 작업 끝 -->
					
					<!-- 담당 손해사정사 등록 작업 시작 20220706 -->
					<tr>
						<td class = "tdHead" bgcolor="#efefef">담당 손해사정사</td>
						<td colspan="3" style="text-align:left; padding-left:10px;">
							<select id="certiManagerSearch" name="certiManagerSearch" style="width:785px;text-align:left;" multiple="multiple">																		
								<c:forEach items="${certiManagerList}" var = "certiManagerVo">
									<option value="${certiManagerVo.ckey}">[${certiManagerVo.user_name}] [${certiManagerVo.certi_type_nm}] [${certiManagerVo.certi_number}]</option>
								</c:forEach>
							</select>										
						</td>
					</tr>
					
					<!-- 담당 손해사정사 등록 작업 끝 20220706 -->					
					
					<c:if test="${mbrVo_Session.user_no == 966 || mbrVo_Session.user_no == 670 || mbrVo_Session.user_no == 62 || mbrVo_Session.user_no == 6 || mbrVo_Session.user_no == 215 || mbrVo_Session.user_no == 1265 }">
						<tr>
							<td class = "tdHead" bgcolor="#efefef">인사 관련 사항</td>
							<td colspan="3" style="text-align:left; padding-left:10px;">
								<textarea class="memoTextarea" name="insa_memo" id="insa_memo" rows="7" cols="70"  style="ime-mode:active;">${memberVo.memo}</textarea>
							</td>
						</tr>
					</c:if>
					
					<c:if test="${mbrVo_Session.user_no == 966 || mbrVo_Session.user_no == 6}">
						<tr>
							<td class = "tdHead" bgcolor="#efefef">인사 관련</td>
							<td colspan="3" style="text-align:left; padding-left:10px;">
								<textarea class="memoTextarea" name="insa_memo_only" id="insa_memo_only" rows="7" cols="70" style="ime-mode:active;">${memberVo.insa_memo_only}</textarea>
							</td>
						</tr>
					</c:if>
					
					<tr>
						<td colspan="5" style = "border:0; text-align:center;">
							<img src="./resources/ne_img/btn_edite.gif" id="mbrInfoEdit" style = "cursor:pointer;"/>
						</td>
					</tr>
					</thead>
				</table>
			</form>
		</div><!-- //tableStyle4 -->
			
		<div id="code-modal" title="코드설명" style="font-size: 15px;display:none;" align="center">
			<table>
				<tr height="30">
					<th align="left" style="color:#013ADF"><font size="3">  ● 직 급 ( 공 통 )  </font></th>
				</tr>
				<tr>
					<td align="left" style="padding:3px;">
						<div>회장  CE0  ,  사장  SJ  ,  부사장  BSJ  ,  전무  JM  , 상무  SM1~5  ,  이사  E1~5  ,</div> 
						<div>부장  B1~4  ,  차장  C1~4  ,  과장  G1~4  ,  대리  D1~4  ,  주임  J1~2  ,  사원  S1~5  ,</div>
						<div>수습  S1  ,  실장  HD,  고문  KM</div>
						<!-- <div>실장  SJ </div> -->
					</td>
				</tr>
				<tr height="30">
					<th align="left" style="color:#013ADF"><font size="3">  ● 직 무 코 드  </font></th>
				</tr>
				<tr>
					<td align="left" style="padding:3px;">
						▪ 1 종<br />
						임원  M00  ,  농업손사  W00  ,  정책손사  W01  ,  재물손사  W10  ,  대인손사  W20,<br />
						대물손사  W21  ,  서면심사  W30  ,  재경  S00  ,  인사총무  S01,  IT  S02  ,<br />
						물보험기획  S10,  업무지원  S11  ,  의료심사  S12  ,  SIU  S13  ,  센터총무  S20<br />
						<br />
						<br />
						▪ 4 종<br />
						본부 - 임원  ST0  ,  총괄  ST1  ,  팀장  ST2  ,  실무  ST3<br />
						조사팀 - 센터장  SU0  ,  팀장  SU1  ,  실무  SU2  ,  업무지원  SU3<br />
						서면팀 - 총괄  CR0  , 센터장  CR1  ,  팀장  CR2  ,  실무  CR3  ,  업무지원  CR4<br />
					</td>
				</tr>
			</table>
		</div>
		<!-- 손해사정사 자격관리 모달창 시작 -->
		<div id="certi-manager-dialog" title="손해사정사 자격관리" style="font-size: 15px;display:none;" align="center"></div>		
		<!-- 손해사정사 자격관리 모달창 끝 -->
		<!-- 손해사정사 삭제 모달창 시작 -->
		<div id="certi-delete-dialog" title="담당 손해사정사 별 보조인현황 관리" style="font-size: 15px;display:none;" align="center"></div>		
		<!-- 손해사정사 삭제 모달창 끝 -->									
	
		<!-- 비밀번호 초기화 문자보내기 -->
		<!-- <form action=" http://munjamadang.co.kr/smsasp/smsasp.html " method="post" name="resFrom" onsubmit="wait()" style="display:none;"> -->
		<form action="https://api.munjamoa.co.kr/message/toplac/sendMsg" method="post" name="resFrom" onsubmit="wait()" style="display:none;">		
			<!-- 신규정보 추가 시작-->
			<input type="hidden" id="api_key" name="api_key" value="SYhfQxLgaANtMSfdH93staNmfM6ybDQcMsdXdFhkTQMIiYZ9Y8KNZRM2jlfBmLhKAWAumahJh1m0joPiOg04BPgIedOW4FnN7JfV">			
			<input type="hidden" id="m_user_id" name="m_user_id" value="toplac">
			<input type="hidden" id="phone_no" name="phone_no" value="${handphone_1}${handphone_2}${handphone_3}"/>
			<input type="hidden" id="callback_no" name="callback_no" value="0260774600">			
			<input type="hidden" id="name_replace" name="name_replace" value="N"/>
			<input type="hidden" id="SEND_TYPE" name="SEND_TYPE" value="N"/>
			<input type="hidden" id="DATE" name="DATE" />
			<!-- 신규정보 추가 끝-->			
			
			<input type="hidden" name="send_time" value="">
			<!-- <input type="hidden" name="return_url" value="this"> -->
			<input type="hidden" name="end_alert" value="1">
			<input id="msgfocus" name="msgfocus" type="hidden" value="0"/>
			<input type="hidden" name="userid" value="toplac">
			<input type="hidden" name="passwd" value="toplac3000">
			<input type="hidden" name="message" id = "message" value="">
			<input type="hidden" name="sender" value="0260774600">
			<input type="hidden" name="receiver" value="${handphone_1}${handphone_2}${handphone_3}">
		</form>
		
		<script type="text/javascript">
		    $(document).ready(function () {
		    	
				_initInfoView();				
				_initCalendar();				
				
				//페이지 로딩 후 보조인 설정 박스 확인 시작
				if( ${memberVo.certi_state} == 1 ){					
					$("#certi_type_sub").show();
					$("#certi_number_sub").show();					
				}else{					
					$("#certi_type_sub").hide();	
					$("#certi_number_sub").hide();					
				}				
				//페이지 로딩 후 보조인 설정 박스 확인 끝
				
				//페이지 로딩후 손해사정사 등록번호 폼 활성화
				//fnCertiStateMainChange();
				
				//퇴사 버튼 클릭시 체크 시작
				/* $('input[name="user_state"]').on('change', function() {
					
					//퇴사 선택시 손해사정사 여부 및 담당 손해사정사 여부 체크
					if ($(this).val() == '1') {
						retireCertChek();
					}
					
				}); */
				//퇴사 버튼 클릭시 체크 끝
				
				$("#mbrInfoEdit").click(function(){
					
					var work_job = $("#work_job option:selected").val();
					var work_rank = $("#work_rank option:selected").val();
					
					if (work_job == null){
						work_job = 0;
					}
					
					if (work_rank == null){
						work_rank = 0;
					}
					
					//겸직추가
					var arrList = new Array();
					
					var nCnt = $("select[name='sub_work_type']").length;		//겸직 등록수					
					
					for(var i=0; i<nCnt;i++){						
						//arrList[i] =	$("#sub_team_id_main_"+i+" option:selected").val()+"|"+$("#sub_work_type_"+i+" option:selected").val();
						//alert(i+" : "+arrList[i]);
						
						//if( !( $("#sub_team_id_main_"+i+" option:selected").val() == '0' && $("#sub_work_type_"+i+" option:selected").val() == '0' ) ){		//겸직을 선택한 경우만 추가한다.
							arrList[i] =	$("#sub_team_id_main_"+i+" option:selected").val()+"|"+$("#sub_work_type_"+i+" option:selected").val();
							//alert(i+" : "+arrList[i]);
						//}						
					}
					
					var param = {};
					param.user_no = $("#user_no").val();
					param.user_id = $("#user_id").val();
					param.home_address = $("#home_address").val();
					
					/* 추가 시작*/
					param.team_id_main = $("#team_id_main option:selected").val();
					param.team_id_loc = $("#team_id_loc option:selected").val();
					param.join_date = $("#join_date").val();
					param.out_date = $("#out_date").val();
					param.probation_date = $("#probation_date").val();		//면수습일 추가 170406 by lds;
					param.user_state = $("input:radio[name='user_state']:checked").val();
					param.curr_user_state = $("#curr_user_state").val();
					
					param.job_memo = $("#job_memo").val();
					
					param.workLevel = $("#work_level option:selected").val();
					param.workType = $("#work_type option:selected").val();
					param.workRank =  work_rank;
					param.workJob =  work_job;
					
					param.CTDay = $("#CTDay").val();
					
					param.is_pass = $("input:radio[name='is_pass']:checked").val();
					param.exp_agree = $("input:radio[name='exp_agree']:checked").val();
					
					/* 추가 끝*/
					param.home_tel_1 = $("#home_tel_1").val();
					param.home_tel_2 = $("#home_tel_2").val();
					param.home_tel_3 = $("#home_tel_3").val();
					param.officetel_1 = $("#officetel_1").val();
					param.officetel_2 = $("#officetel_2").val();
					param.officetel_3 = $("#officetel_3").val();
					param.officefax_1 = $("#officefax_1").val();
					param.officefax_2 = $("#officefax_2").val();
					param.officefax_3 = $("#officefax_3").val();
					param.handphone_1 = $("#handphone_1").val();
					param.handphone_2 = $("#handphone_2").val();
					param.handphone_3 = $("#handphone_3").val();
					param.comment = $("#comment").val();
					param.insa_memo = $("#insa_memo").val();
					param.insa_memo_only = $("#insa_memo_only").val();
					param.email  =  $("#email").val();
					param.subJob  =  arrList;		//겸직추가 20190411 by top3009
					//param.annual_set = $("#annual_set").val();		//연차휴가일수 추가 20190522 by top3009 설정제거
					
					//기존 손해사정인 자격여부
					var certiStateVal = $("#certiStateVal").val();					
					param.orgCertiState = certiStateVal; 
					
					//보조인 등록 정보 추가 시작					
					var certiStateSubVal = $("#certi_state_sub").val();			//보조인 Sel
					param.certi_state_sub = certiStateSubVal;
					//보조인 등록 정보 추가 끝
					
					//담당 손해사정사 등록 시작
					var certiManagerSearchVal = $("#certiManagerSearch").val();
					param.certi_manager_search = certiManagerSearchVal;					
					//담당 손해사정사 등록 끝
					
					//성과급 신입/경력 여부 설정시작
					param.bonus_career_state = $("input:radio[name='bonus_career_state']:checked").val();
					//성과급 신입/경력 여부 설정 끝
					
					//현재지역 항목추가 시작
					var person_zone_val = $("#person_zone option:selected").val();
					param.person_zone = person_zone_val;
					//현재지역 항목추가 끝
					
					var url = "./popMbrUdt";

		            $.ajax({
		                type: "POST",
		                url: url,
		                data: param,
		                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		                dataType: "html",
		                traditional: true,						//배열허용
		                timeout: 20000,
		                success: function(data){
		                	if(data == 1){
		                		alert("사원 정보 변경이 완료 되었습니다.");
		                		location.reload();
		                	}else{
		                		alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
		                	}              	
		                }                
		            });					
					
				});//click
				
		    });
		    
		    //퇴사시 손해사정사 삭제여부 체크
		    function retireCertChek(){		    	
		    	
		    	var certiStateVal = $("#certiStateVal").val();			//손해사정사 : 4
				var userCertVal = $("#user_cert_ckey").val();
				var p_user_no = $("#user_no").val();
				var manual_text = "0";										//팝업에 기능설명 제외 
				
				if( certiStateVal == '4' && userCertVal != ''){			//손해사정사이면서 등록정보가 존재하는 경우 보조인체크 시작
					
					var url = "getCertiManagerDeleteInfoList";
				
					//보조인 정보 불러오기
					var param = {};
					param.ckey = userCertVal;
					param.user_no = p_user_no;
					param.manual_text = manual_text; 
					
					$.ajax({
			 			type: "POST",
			 			url: url,
			 			data: param,
			 			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			 			timeout: 20000,
			 			dataType: "HTML", 
			 			success: function(data){			
			 				$("#certi-delete-dialog").html();
			 				$("#certi-delete-dialog").html(data);					
			 					$("#certi-delete-dialog").dialog({
			 						height: 450,
			 						width: 550,
			 						closeOnEscape : true,
			 						draggable : true,
			 						title: "퇴사 전 손해사정사 정보조회",					
			 						modal: true,											
			 						buttons:{
			 							/* "삭제" : function(){
			 								doInfoDeleteAction( p_ckey , p_user_no , "DeleteAll");
			 								$(this).dialog("close");		 								
			 								//보조인 등록정보 미등록으로 hidden, selectbox 변경
			 								$("#certiStateVal").val(0);
			 								$("#certi_state_sub").val(0);
			 								//손해사정사 등록정보 버튼 초기화
			 								$("#certNemberTextButton").hide();
			 							}, */
			 							"닫기" : function(){
			 								$(this).dialog("close");							
			 							}
			 						},		 						
			 						overlay:{ opacity: 0., background: '#000000'}
			 					});		
			 			},
			 			error: function(e){
			 			    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
			 			}		 			
			 		});					
				}
		    }
		    
		    //보조인 등록정보 관리 모달
		    function certiSubManageModal( p_user_no ){
		    	
		    	var url = "getCertiSubManagerInfoList";
				
				var param = {};
				param.user_no = p_user_no;
				
				$.ajax({
					type: "POST",
					url: url,
					data: param,
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",
					timeout: 20000,
					dataType: "HTML", 
					success: function(data){			
						$("#certi-manager-dialog").html();
						$("#certi-manager-dialog").html(data);					
							$("#certi-manager-dialog").dialog({
								height: 400,
								width: 500,
								closeOnEscape : true,
								draggable : true,
								title: "보조인 자격관리",					
								modal: true,												
								buttons:{								
									"닫기" : function(){
										$(this).dialog("close");
										location.reload();
										//location.href="popMbrDetail?user_no=${memberVo.user_no}";
									}
								},
								close: function(event, ui) {
									location.reload(); // X 버튼이나 ESC 등 어떤 방법으로 닫아도 새로고침
								},
								overlay:{ opacity: 0., background: '#000000'}
							});		
					},
					error: function(e){
					    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
					}
				});				
		    }
		    
		    //손해사정사 등록정보 관리
		    function certiManageModal( p_user_no ){

		    	var url = "getCertiManagerInfoList";
								
				var param = {};
				param.user_no = p_user_no;
				
				$.ajax({
					type: "POST",
					url: url,
					data: param,
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",
					timeout: 20000,
					dataType: "HTML", 
					success: function(data){			
						$("#certi-manager-dialog").html();
						$("#certi-manager-dialog").html(data);					
							$("#certi-manager-dialog").dialog({
								height: 700,
								width: 900,
								closeOnEscape : true,
								draggable : true,
								title: "손해사정사 자격관리",					
								modal: true,												
								buttons:{								
									"닫기" : function(){
										$(this).dialog("close");
										location.reload();
										//location.href="popMbrDetail?user_no=${memberVo.user_no}";
									}
								},
								close: function(event, ui) {
									location.reload(); // X 버튼이나 ESC 등 어떤 방법으로 닫아도 새로고침
								},
								overlay:{ opacity: 0., background: '#000000'}
							});		
					},
					error: function(e){
					    alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
					}
				});
				 //diaglog 내 select2 활성화

			    /* $("#addUserNo").select2({
			    	dropdownParent: $("#certi-manager-dialog")
			    }); */
		    }    
		    
		  	//보조인 등록정보 selectBox 변경시		 	 
		 	function fnCertiStateSubChange(){		  		
		  		
		 		var certiStateSubVal = $("#certi_state_sub").val();			//보조인 Sel
		 		var certiStateVal = $("#certiStateVal").val();			//직원의 손해사정사 상태 (4:손해사정사)
		 				 		
		 		if( certiStateVal == 4 ){			//기존 손해사정사에서 다른 상태로 바꾸려고 할때		 			
	 				alert("손해사정사 등록정보를 삭제해야 보조인 등록정보 변경이 가능합니다.");
	  				$("#certi_state_sub").val(4);
	  				return;		 			
		 		}else if( certiStateSubVal == 0 ){			//미선택으로 바꾸는 경우		 			
		 			$("#certi_type_sub").hide();
		  			$("#certi_number_sub").hide();
		 		}else{
		 			if( certiStateSubVal == 2 || certiStateSubVal == 3 ){		//보조인 불충족, 비대상
		 				$("#certi_type_sub").hide();
			  			$("#certi_number_sub").hide();			  			
		 			}else if( certiStateSubVal == 4 ){
		 				$("#certi_type_sub").hide();
			  			$("#certi_number_sub").hide();
			  			alert("아래 손해사정사 등록정보에 정보를 추가해야 \n보조인의 담당 손해사정사 등록이 가능합니다.");			  			
			  			certiManageModal(${memberVo.user_no});
		 			}else{					//보조인 등록
		 				$("#certi_type_sub").show();
			  			$("#certi_number_sub").show();			  			
		 			}
		 		}		 		
		  	}
		  	
		 	//손해사정사 정보 DB삭제
		 	function doInfoDeleteAction( p_ckey , p_user_no, p_action_flag){
		 		
		 		var param = {};
		 		param.ckey = p_ckey;
		 		param.user_no = p_user_no;
		 		param.action_flag = p_action_flag;
		 		
		 		$.ajax({
		 			type : "post",
		 			data : param,
		 			url : "actionCertiManageData",
		 			success : function(result){
		 				
		 				if( result == 1 ){			//삭제 성공
		 					alert("손해사정사 정보를 삭제하였습니다.");		 									
		 				}else{
		 					alert("손해사정사 정보 삭제를 실패하였습니다.");	
		 				}
		 				
		 			},
		 			error: function (request, status, error) {			
		 				console.log('code: '+request.status+"\n"+'message: '+request.responseText+"\n"+'error: '+error);
		 			}
		 			
		 		});
		 		
		 		
		 	}
		  	
			function fnCertiSub_del(param){
				
				if( param == "certi_type_tr_0" ){					
					$("#certi_type_main_0").val(0);
					$("#certi_number_main_0").val('');
					return;
				}
				
				var trHtml = $( "tr[id=\'"+param+"\']" );				
				trHtml.remove();
				$("#userCertiCnt").val( parseInt($("#userCertiCnt").val())-1 );		//삭제하면 index 값도 1감소시킨다.
				
			}

		    function fnSub_add(){
		    	
		    	var Sub_Cnt = parseInt($("#subJobCnt").val());		    				    		    			    			    	
		    	
		    	var addSubTr = "";
		    	
		    	addSubTr =	'<tr id="sub_'+Sub_Cnt+'">'+
			    					'<td style="text-align:left; padding-left:10px;border-left:1px solid #FFFFFF;border-right:1px solid #FFFFFF;border-bottom:1px solid #FFFFFF;border-top:1px solid #FFFFFF">'+
				    					'<select id="sub_team_id_main_'+Sub_Cnt+'" name="sub_team_id_main" style="width:200px;">'+
				    						'<option value="0" selected>선택</option>'+
				    						'<c:forEach items="${teamList}" var = "teamVo">'+
				    							'<option value="${teamVo.team_id}">'+
				    							'<c:if test="${teamVo.team_level eq 1}">&nbsp;&nbsp;└</c:if>'+
				    							'<c:if test="${teamVo.team_level eq 2}">&nbsp;&nbsp;&nbsp;&nbsp;└</c:if>'+
				    							'${teamVo.team_name}'+												
				    							'</option>'+
				    						'</c:forEach>'+
				    					'</select>&nbsp;'+																						
				    					'<select id="sub_work_type_'+Sub_Cnt+'" name="sub_work_type">'+				    						
				    						'<c:forEach items="${workTypeList}" var = "levelVo">'+
				    							'<option value="${levelVo.col_cd}">${levelVo.col_val}</option>'+
				    						'</c:forEach>'+
				    					'</select>'+
				    					'&nbsp;<img src="./resources/ls_img/btn_del_s.gif" border="0" onclick="fnSub_del(\'sub_'+Sub_Cnt+'\');" style="cursor:pointer" />'+
				    				'</td>'+				    				
			    				'</tr>';
			    //alert("test="+addSubTr);
			    		    				
		    	var trHtml = $( "tr[name=sub_tr]:last" );		    	
		    	trHtml.after(addSubTr);
		    	Sub_Cnt++;
		    	$("#subJobCnt").val(Sub_Cnt);
		    }
			
			function fnSub_del(param){
				
				if( param == "sub_0" ){
					//alert("첫번째 입력폼은 삭제할 수 없습니다.\n겸직설정을 기본설정으로 초기화합니다.\n초기화 후 수정버튼을 눌러야 겸직초기화가 저장됩니다.'");
					$("#sub_team_id_main_0").val(0);
					$("#sub_work_type_0").val(0);
					return;
				}
				
				//alert('삭제='+param);
				
				var trHtml = $( "tr[id=\'"+param+"\']" );				
				trHtml.remove();
				$("#subJobCnt").val( parseInt($("#subJobCnt").val())-1 );		//삭제하면 index 값도 1감소시킨다.
				
				//alert("jobCnt="+$("#subJobCnt").val());
			}
					    
		    function _initInfoView(){
				$("#team_id_main").val('${memberVo.team_id_main}');
				$("#team_id_loc").val('${memberVo.team_id_loc}');
				
				$("#work_level").val('${memberVo.work_level_cd}');
				$("#work_type").val('${memberVo.work_type_cd}');
				$("#work_rank").val('${memberVo.work_rank_cd}');
				$("#work_job").val('${memberVo.work_job_cd}');
				
				var userState = $("#curr_user_state").val();
				if ( userState == 0 || userState == 9 ){
					$("input:radio[name='user_state']:radio[value='0']").prop("checked",true);
				}else{
					$("input:radio[name='user_state']:radio[value='${memberVo.user_state}']").prop("checked",true);
				}
				
				var isPass = $("#curr_is_pass").val();				
				
				if( isPass == 1 ){					
					$("input:radio[name='is_pass']:radio[value='1']").prop("checked",true);
				}else{					
					$("input:radio[name='is_pass']:radio[value='0']").prop("checked",true);
				}
				
				var expAgree = $("#curr_exp_agree").val();				
				
				if( expAgree == 1 ){					
					$("input:radio[name='exp_agree']:radio[value='1']").prop("checked",true);
				}else if( expAgree == 2 ){					
					$("input:radio[name='exp_agree']:radio[value='2']").prop("checked",true);
				}else{					
					$("input:radio[name='exp_agree']:radio[value='0']").prop("checked",true);
				}
				
				var bonusCareerState = $("#curr_bonus_career_state").val();				
				
				if( bonusCareerState == 1 ){					
					$("input:radio[name='bonus_career_state']:radio[value='1']").prop("checked",true);
				}else if( bonusCareerState == 2 ){
					$("input:radio[name='bonus_career_state']:radio[value='2']").prop("checked",true);
				}else{					
					$("input:radio[name='bonus_career_state']:radio[value='0']").prop("checked",true);
				}
				
				//자격증 등록구분 체크박스 시작
				var certiState = $("#curr_certi_state").val();
				
				if( certiState == 1 ){					
					$("input:radio[name='certi_state']:radio[value='1']").prop("checked",true);
				}else if( certiState == 2 ){					
					$("input:radio[name='certi_state']:radio[value='2']").prop("checked",true);
				}else if( certiState == 3 ){					
					$("input:radio[name='certi_state']:radio[value='3']").prop("checked",true);
				}else if( certiState == 4 ){					
					$("input:radio[name='certi_state']:radio[value='4']").prop("checked",true);
				}else if( certiState == 6 ){					
					$("input:radio[name='certi_state']:radio[value='6']").prop("checked",true);
				}else{					
					$("input:radio[name='certi_state']:radio[value='0']").prop("checked",true);
				}				
				//자격증 등록구분 체크박스 끝
		    }
		    
		    function fnCodeDsc(){
		    	$("#code-modal").dialog({
		    		height: 450,
		    		width: 500,
		    		closeOnEscape : true,
		    		draggable : false,
		    		buttons:{
		    			"닫기" : function(){
		    				$(this).dialog("close");		    				
		    			}
		    		},
		    		modal: true,
		    		overlay:{ opacity: 0., background: '#000000'}
		    	});
		    }
		    
		    function _initCalendar(){    	 
		  		$('.calendar').datepicker({
		  			showOn: 'button',
		  			buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		  			buttonImageOnly: true,
		  			buttonText: "달력", 
		  			changeMonth: true,
		  			changeYear: true,	    	   
		  			showButtonPanel: false,
		  			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		  			dayNamesMin: ['일','월','화','수','목','금','토'],
		  			dateFormat: 'yy-mm-dd',
		  			firstDay: 0,
		  			isRTL: false,
		  			showMonthAfterYear: true
		  	    }); 		
		  		
		  	}
		</script>

</body>
