<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<script src="./resources/ne_js/ne_number.js"></script>
	<script src="./resources/ckeditor/ckeditor.js"></script>
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
	
	<script>
		$(document).ready(function(){

			$("#postCodeBtn").click(function(){
				var themeObj = {
						   bgColor: "#C00C0C", //바탕 배경색
						   //searchBgColor: "", //검색창 배경색
						   //contentBgColor: "", //본문 배경색(검색결과,결과없음,첫화면,검색서제스트)
						   //pageBgColor: "", //페이지 배경색
						   //textColor: "", //기본 글자색
						   //queryTextColor: "", //검색창 글자색
						   //postcodeTextColor: "", //우편번호 글자색
						   emphTextColor: "#C01160" //강조 글자색
						   //outlineColor: "", //테두리
						};
				new daum.Postcode({
					theme: themeObj,
					oncomplete: function(data) {
						$("#investigate_postcode").val(data.zonecode);
						$("#investigate_addr1").val(data.roadAddress);
					}
				}).open();
			});//$("#postCodeBtn").click

			$("#cancelEditPrimBizRptBscTabBtn").click(function(){
				var tmp = window.confirm("작성을 취소 하시겠습니까?");
				if(tmp == false){
					return;
				}
				$("#infoPrimBizRptTab").click();
			});

			$("#editPrimBizRptBscTabBtn").click(function(){
				//policyholder_tel
				if($("#policyholder_tel_1").val().trim() == "" && $("#policyholder_tel_2").val().trim() == ""
						&& $("#policyholder_tel_3").val().trim() == ""){//no policyholder_tel
				}else if($("#policyholder_tel_1").val().trim() != "" && $("#policyholder_tel_2").val().trim() != ""
						&& $("#policyholder_tel_3").val().trim() != ""){
					$("#policyholder_tel").val($("#policyholder_tel_1").val().trim() + "-"
							+ $("#policyholder_tel_2").val().trim()  + "-" + $("#policyholder_tel_3").val().trim());
				}else{
					alert("계약자 연락처가 올바르지 않습니다.");
					return;
				}
				//beneficiary_tel
				if($("#beneficiary_tel_1").val().trim() == "" && $("#beneficiary_tel_2").val().trim() == ""
						&& $("#beneficiary_tel_3").val().trim() == ""){//no beneficiary_tel
				}else if($("#beneficiary_tel_1").val().trim() != "" && $("#beneficiary_tel_2").val().trim() != ""
						&& $("#beneficiary_tel_3").val().trim() != ""){
					$("#beneficiary_tel").val($("#beneficiary_tel_1").val().trim() + "-"
							+ $("#beneficiary_tel_2").val().trim()  + "-" + $("#beneficiary_tel_3").val().trim());
				}else{
					alert("피보험자 연락처가 올바르지 않습니다.");
					return;
				}
				//damaged_tel
				if($("#damaged_tel_1").val().trim() == "" && $("#damaged_tel_2").val().trim() == ""
						&& $("#damaged_tel_3").val().trim() == ""){//no damaged_tel
				}else if($("#damaged_tel_1").val().trim() != "" && $("#damaged_tel_2").val().trim() != ""
						&& $("#damaged_tel_3").val().trim() != ""){
					$("#damaged_tel").val($("#damaged_tel_1").val().trim() + "-"
							+ $("#damaged_tel_2").val().trim()  + "-" + $("#damaged_tel_3").val().trim());
				}else{
					alert("피해자 연락처가 올바르지 않습니다.");
					return;
				}
				var tmp = window.confirm("보고서 기본 정보를 수정 하시겠습니까?");
				if(tmp == false){
					return;
				}
				
				//CKEDITOR 값 넣어주기				
				$("#accident_facts").val(CKEDITOR.instances.accident_facts.getData());
				
		        var param = $("#editPrimBizRptBscTabForm").serialize();
		        var url = "./primBizRptDtlBscUdt";
		        
		        $.ajax({
		            type: "POST",
		            url: url,
		            data: param,
		            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		            timeout: 20000,
		            dataType: "JSON", 
		            success: function(data){
		            	if (data.result == 1){
							alert("수정 되었습니다");
							location.reload();
		            	}
// 		            	$("#srchResultUl").append(data);
		            },
		            error: function(e){
		                alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
		            },
		        });
// 				editPrimBizRptBscTabForm.submit();
				
				
			});

		});//$(document).ready
	</script>

						<table style="margin-bottom:5px;">
							<tr>
								<td align="left" style="padding-left:10px;"><b> 보고서 기본 정보</b></td>
								<td align="right" style="padding-right:10px;"><!-- 보고서 상태 값 변경 관리 -->
								</td><!-- //보고서 상태 값 변경 관리 -->
							</tr>
						</table>
						<div class= "tableStyle21">
							<form name="editPrimBizRptBscTabForm" id="editPrimBizRptBscTabForm" action="./primBizRptDtlBscUdt" method="post">
								<input type="hidden" name="suim_rpt_no" value="${primBizRptDtl.suim_rpt_no}"/>
								<input type="hidden" name="policyholder_tel" id="policyholder_tel" />
								<input type="hidden" name="beneficiary_tel" id="beneficiary_tel" />
								<input type="hidden" name="damaged_tel" id="damaged_tel" />
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
											&nbsp;(현재상태 : ${primBizRptDtl.suim_rpt_state_nm})
										</td>
										<td bgcolor="#E7ECF1"><b>모랄확인</b></td>
										<td>
											<input type="radio" name="moral_flag" value="0" 
												<c:if test="${primBizRptDtl.moral_flag eq 0}">checked="checked"</c:if>
											/> 미확인
											&nbsp;<input type="radio" name="moral_flag" value="1"
												<c:if test="${primBizRptDtl.moral_flag eq 1}">checked="checked"</c:if>
											/> 모랄(O)
											&nbsp;<input type="radio" name="moral_flag" value="2"
												<c:if test="${primBizRptDtl.moral_flag eq 2}">checked="checked"</c:if>
											/> 모랄(X)
										</td>
										<td bgcolor="#E7ECF1"><b>민원관련</b></td>
										<td>
											<input type="radio" name="minwon_flag" value="0"
												<c:if test="${primBizRptDtl.minwon_flag eq 0}">checked="checked"</c:if>
											/> 없음
											&nbsp;<input type="radio" name="minwon_flag" value="1"
												<c:if test="${primBizRptDtl.minwon_flag eq 1}">checked="checked"</c:if>
											/> 예상
											&nbsp;<input type="radio" name="minwon_flag" value="2"
												<c:if test="${primBizRptDtl.minwon_flag eq 2}">checked="checked"</c:if>
											/> 발생
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>처리팀</b></td>
										<td>${primBizRptDtl.team_name}</td>
										<td bgcolor="#E7ECF1"><b>처리 담당자</b></td>
										<td style="border-right:0;">${primBizRptDtl.user_name}</td>
										<td colspan="2" style="border-left:0;"></td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>보험사</b></td>
										<td>${primBizRptDtl.ptnr_name}</td>
										<td bgcolor="#E7ECF1"><b>보험사 담당자</b></td>
										<td>${primBizRptDtl.ptnr_mbr_nm}</td>
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
										<td bgcolor="#E7ECF1"><b>구분</b></td>
										<td colspan="5">
											<input type="radio" name="suim_rpt_type1" value="5"
												<c:if test="${primBizRptDtl.suim_rpt_type1 eq 5}">checked="checked"</c:if>
											/> 농작물
											&nbsp;<input type="radio" name="suim_rpt_type1" value="6"
												<c:if test="${primBizRptDtl.suim_rpt_type1 eq 6}">checked="checked"</c:if>
											/> 적부(삼성)
											&nbsp;<input type="radio" name="suim_rpt_type1" value="7"
												<c:if test="${primBizRptDtl.suim_rpt_type1 eq 7}">checked="checked"</c:if>
											/> 적부(KB)
											&nbsp;<input type="radio" name="suim_rpt_type1" value="8"
												<c:if test="${primBizRptDtl.suim_rpt_type1 eq 8}">checked="checked"</c:if>
											/> 적부(한화)
											&nbsp;<input type="radio" name="suim_rpt_type1" value="9"
												<c:if test="${primBizRptDtl.suim_rpt_type1 eq 9}">checked="checked"</c:if>
											/> 적부(삼성스마트)
											&nbsp;<input type="radio" name="suim_rpt_type1" value="10"
												<c:if test="${primBizRptDtl.suim_rpt_type1 eq 10}">checked="checked"</c:if>
											/> 적부(흥국)
											&nbsp;<input type="radio" name="suim_rpt_type1" value="99"
												<c:if test="${primBizRptDtl.suim_rpt_type1 eq 99}">checked="checked"</c:if>
											/> 적부(기타)
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>사고번호</b></td>
										<td>
											<input type="text" name="accident_no" value="${primBizRptDtl.accident_no}" size="27" maxlength="20">
										</td>
										<td bgcolor="#E7ECF1"><b>증권번호</b></td>
										<td>
											<input type="text" name="policy_no" value="${primBizRptDtl.policy_no}" size="27" maxlength="20">
										</td>
										<td colspan="2" style="border-left:0;"></td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>보험종목</b></td>
										<td colspan="5">
											<input type="text" name="insurance_nm" value="${primBizRptDtl.insurance_nm}" size="70" maxlength="50">
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>계약자</b></td>
										<td>
											<input type="text" name="policyholder_nm" value="${primBizRptDtl.policyholder_nm}" size="27" maxlength="20">
										</td>
										<td bgcolor="#E7ECF1"><b>피보험자</b></td>
										<td>
											<input type="text" name="beneficiary_nm" value="${primBizRptDtl.beneficiary_nm}" size="27" maxlength="20">
										</td>
										<td bgcolor="#E7ECF1"><b>피해자/피해물</b></td>
										<td>
											<input type="text" name="damaged_nm" value="${primBizRptDtl.damaged_nm}" size="27" maxlength="20">
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>계약자 연락처</b></td>
										<td>
											<input type="text" name="policyholder_tel_1" id="policyholder_tel_1" value="${policyholder_tel_1}"
												size="3" maxlength="3" ONKEYDOWN="javascript:onlyNumberFunc2(this);" style="ime-mode:disabled">
											- <input type="text" name="policyholder_tel_2" id="policyholder_tel_2" value="${policyholder_tel_2}"
												size="4" maxlength="4" ONKEYDOWN="javascript:onlyNumberFunc2(this);" style="ime-mode:disabled">
											- <input type="text" name="policyholder_tel_3" id="policyholder_tel_3" value="${policyholder_tel_3}"
												size="4" maxlength="4" ONKEYDOWN="javascript:onlyNumberFunc2(this);" style="ime-mode:disabled">
										</td>
										<td bgcolor="#E7ECF1"><b>피보험자 연락처</b></td>
										<td>
											<input type="text" name="beneficiary_tel_1" id="beneficiary_tel_1" value="${beneficiary_tel_1}"
												size="3" maxlength="3" ONKEYDOWN="javascript:onlyNumberFunc2(this);" style="ime-mode:disabled">
											- <input type="text" name="beneficiary_tel_2" id="beneficiary_tel_2" value="${beneficiary_tel_2}"
												size="4" maxlength="4" ONKEYDOWN="javascript:onlyNumberFunc2(this);" style="ime-mode:disabled">
											- <input type="text" name="beneficiary_tel_3" id="beneficiary_tel_3" value="${beneficiary_tel_3}"
												size="4" maxlength="4" ONKEYDOWN="javascript:onlyNumberFunc2(this);" style="ime-mode:disabled">
										</td>
										<td bgcolor="#E7ECF1"><b>피해자 연락처</b></td>
										<td>
											<input type="text" name="damaged_tel_1" id="damaged_tel_1" value="${damaged_tel_1}"
												size="3" maxlength="3" ONKEYDOWN="javascript:onlyNumberFunc2(this);" style="ime-mode:disabled">
											- <input type="text" name="damaged_tel_2" id="damaged_tel_2" value="${damaged_tel_2}"
												size="4" maxlength="4" ONKEYDOWN="javascript:onlyNumberFunc2(this);" style="ime-mode:disabled">
											- <input type="text" name="damaged_tel_3" id="damaged_tel_3" value="${damaged_tel_3}"
												size="4" maxlength="4" ONKEYDOWN="javascript:onlyNumberFunc2(this);" style="ime-mode:disabled">
										</td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>사고내용</b></td>
										<td colspan="5">
											<textarea id="accident_facts" name="accident_facts">${primBizRptDtl.accident_facts}</textarea>
											<script>
												CKEDITOR.replace('accident_facts',{height:70,removePlugins:'toolbar,elementspath,resize'});
											</script>
										</td>
									</tr>
									
									<tr>
										<td bgcolor="#E7ECF1"><b>사고일</b></td>
										<td>
											<input type="text" class="classCalendar" id="accident_date" name="accident_date" size="10"
												value="${primBizRptDtl.accident_date_fmt}" readonly style="background-color:lightgrey;" />
										</td>
										<td bgcolor="#E7ECF1"><b>수임일</b></td>
										<td style="border-right:0;">
											<input type="text" class="classCalendar" id="reg_date" name="reg_date" size="10"
												value="${primBizRptDtl.reg_date_fmt}" readonly style="background-color:lightgrey;" />
										</td>
										<td colspan="2" style="border-left:0;"></td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>추정손해액</b></td>
										<td>
											<input type="text" name="amt_estimated_damage" id="amt_estimated_damage"
												value="<fmt:formatNumber value="${primBizRptDtl.amt_estimated_damage}" pattern="###,###,##0.##"/>"
												ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;" /> 원
										</td>
										<td bgcolor="#E7ECF1"><b>추정수수료</b></td>
										<td>
											<input type="text" name="commission_estimated" id="commission_estimated"
												value="<fmt:formatNumber value="${primBizRptDtl.commission_estimated}" pattern="###,###,##0.##"/>"
												ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;" /> 원
										</td>
										<td colspan="2" style="border-left:0;"></td>
									</tr>
									<tr>
										<td bgcolor="#E7ECF1"><b>조사지역</b></td>
										<td colspan="5">
											<input type="text" name="investigate_postcode" id="investigate_postcode" size="10" readonly style="background-color:lightgrey;" value ="${primBizRptDtl.investigate_postcode}"/>													  
											<input type="button" id="postCodeBtn" value="우편번호 찾기"><br />
											<input type="text" name="investigate_addr1" id="investigate_addr1"  size="40" readonly style="background-color:lightgrey;" value="${primBizRptDtl.investigate_addr1}"/>
										    <input type="text" name="investigate_addr2" id="investigate_addr2"  size="50" value="${primBizRptDtl.investigate_addr2}"/>
										</td>
									</tr>
								</table>
							</form>
						</div>
						<p align="center" style="margin-top:7px;">
							<img id="editPrimBizRptBscTabBtn" src="./resources/ls_img/btn_ok.gif" alt="저장" style ="cursor:pointer" />
							<img id="cancelEditPrimBizRptBscTabBtn" src="./resources/ls_img/btn_cancel.gif" alt="취소" style ="cursor:pointer" />
						</p>
