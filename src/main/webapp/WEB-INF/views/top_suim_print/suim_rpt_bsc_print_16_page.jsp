<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page import = "java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
 
<script src="./resources/jquery/jquery.min_1_12.js"></script>
<style>
<!--
td {color:#000000; font-size:11pt; line-height:130%; margin-top:0; margin-bottom:0; font-family:굴림;}
p {color:#000000; font-size:11pt; line-height:130%; margin-top:0; margin-bottom:0; font-family:굴림;}
table {border-collapse:collapse;border-spacing:0; font-size:11pt;}
.td {border:1px solid #999999; padding:3px;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:2.0cm 2.0cm 2.0cm 2.0cm;
	mso-header-margin:42.55pt;
	mso-footer-margin:49.6pt;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
	<table id = "rptBody6Table" align="center" cellpadding="0" cellspacing="0" width="640">
		<tr>
			<td width="640">
				<p style="line-height:200%;" align="center"><b><font size="5">[종 결 보 고 서]</font></b></p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr height="30" align="center">
						<th nowrap >수신 :</th>
						<th nowrap >&nbsp;${suimVO.ptnr_name}</th>
						<th nowrap >&nbsp;&nbsp;${suimVO.ptnr_dept_nm}</th>
						<th nowrap >&nbsp;&nbsp;${suimVO.ptnr_mbr_nm}</th>
					</tr>
					<tr height="30" align="center">
						<th nowrap >발신 :</th>
						<th nowrap >&nbsp;탑손해사정 주식회사</th>
						<th nowrap >&nbsp;&nbsp;${tmInforForBody.team_name}</th>
						<th nowrap >&nbsp;&nbsp;${mbrVoForBody.user_name} (${mbrVoForBody.handphone})</th>
					</tr>
				</table>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr height="30">
						<th width="34%" align="left">사고접수일 : ${suimVO.accident_date}</th>
						<th width="33%" align="center">의뢰일시 : ${suimVO.reg_date}</th>
						<th width="33%" align="right">보고일자 : ${suimInvVO.invoiceDate }</th>
					</tr>
				</table>
				<table align="center" width="640">
					<tr align="center">
						<td width="10%" bgcolor="#EFEFEF" class="td"><p>피보험자</p></td>
						<td width="15%" class="td"><p>${suimVO.getBeneficiary_nm()}</p></td>
						<td width="10%" bgcolor="#EFEFEF" class="td"><p>사고번호</p></td>
						<td width="20%" class="td"><p>${suimVO.getAccident_no()}</p></td>
						<td width="10%" bgcolor="#EFEFEF" class="td"><p>조사담당</p></td>
						<td width="25%" class="td"><p>${suimVO.user_name}</p></td>
					</tr>
					<tr align="center">
						<td bgcolor="#EFEFEF" class="td"><p>주민번호</p></td>
						<td colspan="3" class="td"><p>${suimVO.getBeneficiary_ssn()}</p></td>
						<td bgcolor="#EFEFEF" class="td"><p>보상담당</p></td>
						<td class="td"><p>${suimVO.ptnr_mbr_nm}</p></td>
					</tr>
				</table>
				<p>&nbsp;</p>
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td width="640" height="30">
							<p>▣ <b>계약사항</b></p>
						</td>
					</tr>
				</table>
				<table align="center" width="648">
					<tr align="center" bgcolor="#EFEFEF">
						<td class="td" nowrap><p>상품명</p></td>
						<td class="td" nowrap><p>증권번호</p></td>
						<td class="td" nowrap><p>보험시기</p></td>
						<td class="td" nowrap><p>보험종기</p></td>
						<td class="td" nowrap><p>계약자명</p></td>
						<td class="td" nowrap><p>계약상태</p></td>
					</tr>
					<tr align="center">
						<td class="td"><p>${suimVO.getInsurance_nm()} </p></td>
						<td class="td"><p>${suimVO.getPolicy_no()} </p></td>
						<td class="td">
							<p>
								<span  id = "insuPeriodS1Span">${ suimRptBody16_1267Vo.insuPeriodS1Span}</span>
							</p>
						</td> 
						<td class="td">
							<p> 
								<span  id = "insuPeriodE1Span">${ suimRptBody16_1267Vo.insuPeriodE1Span}</span>
							</p>
						</td>
						<td class="td"><p>${suimVO.getPolicyholder_nm()} </p></td>
						<td class="td">
							<p> 
								<span  id = "contractState1Span">${ suimRptBody16_1267Vo.contractState1Span}</span>
							</p>
						</td> 
					</tr>
				</table>
				<p>&nbsp;</p>
				<table align="center" cellpadding="0" cellspacing="0" width="648">
					<tr>
						<td width="640" height="30">
							<p>▣ <b>손해사항</b></p>
						</td>
					</tr>
				</table>
				<table align="center" width="648">
					<tr align="center" bgcolor="#EFEFEF">
						<td class="td" nowrap><p>사고일자</p></td>
						<td class="td" nowrap><p>사고유형</p></td>
						<td class="td" nowrap colspan="2"><p>진단명</p></td>
						<td class="td" nowrap><p>가입시<br>직업급수</p></td>
						<td class="td" nowrap><p>사고시<br>직업급수</p></td>
					</tr>
					<tr align="center">
						<td class="td">
							<p>
								<span  id = "accidentDate1Span">
								<c:choose>
									<c:when test="${suimRptBody16_1267Vo.accidentDate1 eq '1970-01-01' }">
										-								
									</c:when>
									<c:otherwise>
										${ suimRptBody16_1267Vo.accidentDate1}
									</c:otherwise>								
								</c:choose>
								</span>
							</p>
						</td>
						<td class="td">
							<p>
								<span  id = "accidentSumUp1Span">${ suimRptBody16_1267Vo.accidentSumUp1Span}</span>
							</p>
						</td> <!-- accident_sum_up_1 -->
						<td class="td">
							<p>
								<span  id = "diagnosisDisease1Span">${ suimRptBody16_1267Vo.diagnosisDisease1Span}</span>
							</p>
						</td> <!-- diagnosis_disease_1 -->
						<td class="td">
							<p>
								<span  id = "diagnosisCode1Span">${ suimRptBody16_1267Vo.diagnosisCode1Span}</span>
							</p>
						</td> <!-- diagnosis_code_1 -->
						<td class="td">
							<p>
								<span  id = "jobGradeJoin1Span">${ suimRptBody16_1267Vo.jobGradeJoin1Span}</span>
							</p>
						</td> <!-- job_grade_join_1 -->
						<td class="td">
							<p>
								<span  id = "jobGradeAccident1Span">${ suimRptBody16_1267Vo.jobGradeAccident1Span}</span>
							</p>
						</td> <!-- job_grade_accident_1 -->
					</tr>
				</table>
				<p>&nbsp;</p>
				<table align="center" width="648">
					<tr align="center" bgcolor="#efefef">
						<td class="td" nowrap>담보내용</td>
						<td class="td" nowrap>보험가입금액</td>
						<td class="td" nowrap>추정손해액</td>
					</tr>
					<tr align="center">
						<td class="td"> 
								<span  id = "insuMortgageDtl1Span">${ suimRptBody16_1267Vo.insuMortgageDtl1Span}</span>
						</td> <!-- insu_mortgage_dtl_1 -->
						<td class="td"> 
								<span  id = "amtTotInsu1Span">${ suimRptBody16_1267Vo.amtTotInsu1Span}</span>
						</td> <!-- amt_tot_insu_1 -->
						<td class="td"> 
								<span  id = "amtEstimatedDmgDtl1Span">${ suimRptBody16_1267Vo.amtEstimatedDmgDtl1Span}</span>
						</td> <!-- amt_estimated_dmg_dtl_1 -->
					</tr>
					<tr align="center">
						<td bgcolor="#efefef" class="td" colspan="2">합 계</td>
						<td class="td">	
							<span>${ suimVO.amtEstimatedDamage} 원</span>								
                   		</td>
					</tr>
				</table>
            <p>&nbsp;</p>
            
            <table align="center" cellpadding="0" cellspacing="0" width="640" bgcolor="white">
				<tr>
					<td width="50%" height="30">
						<p><font color="#113F7D">▣ <b>청구내용 및 조사결과</b></font></p>
					</td>
					<td width="50%" height="30">
						<p align="right">
						</p> 
					</td>
				</tr>
				<tr><td width="640" height="1" colspan="2" bgcolor="#0077B1"></td></tr>
			</table>
			<table align="center" width="648">
				<tr>
					<td width="100" align="center" bgcolor="#EFEFEF" class="td"><p>청구내용<br>(조사한 내용을<br>상세히 기술)</p></td>
					<td class="td" colspan="4">
						<p>
							<span class="print16_2SpanClass" id = "claimDtl2Span">${ suimRptBody16_1267Vo.claimDtl2Span}</span>
						</p>
					</td>
				</tr>
				<tr>
					<td width="100" align="center" bgcolor="#EFEFEF" class="td"><p>민원예방활동</p></td>
					<td class="td" colspan="4">
						<p>
							<span class="print16_2SpanClass" id = "complaintAvoidActivity2Span">${ suimRptBody16_1267Vo.complaintAvoidActivity2Span}</span>
						</p>
					</td>
				</tr>
				<tr>
					<td width="100" align="center" bgcolor="#EFEFEF" class="td" rowspan="2"><p>조사자의견<br>및<br>조사결과</p></td>
					<td class="td" colspan="4">
						<p>
							<span class="print16_2SpanClass" id = "inspectResult2Span">${ suimRptBody16_1267Vo.inspectResult2Span}</span>
						</p>
					</td>
				</tr>
				<tr align="center">
					<td bgcolor="#EFEFEF" class="td" nowrap><p>계약유지</p></td>
					<td class="td">
						<p>
							<span class="print16_2SpanClass" id = "contractKeepYn2Span">${ suimRptBody16_1267Vo.contractKeepYn2Span}</span>
						</p>
					</td>
					<td bgcolor="#EFEFEF" class="td" nowrap><p>민원여부</p></td>
					<td class="td">
						<p>
							<span class="print16_2SpanClass" id = "minwonDtl2Span">${ suimRptBody16_1267Vo.minwonDtl2Span}</span>
						</p>
					</td>
				</tr>
			</table>
			<p>&nbsp;</p>
            
            <table align="center" cellpadding="0" cellspacing="0" width="640" bgcolor="white">
				<tr>
					<td width="50%" height="30">
						<p><font color="#113F7D">▣ <b>조사자 일자별 확인사항</b></font></p>
					</td>
					<td width="50%" height="30">
						<p align="right">
							<!-- <a href='./report_03.php?rid=' onclick="NewPopUp(this.href,'Report_03','700','550','yes','center');return false" onfocus='this.blur()'><img src='../img/btn_edite.gif' border='0'></a> -->
						</p>
					</td>
				</tr>
				<tr><td width="640" height="1" colspan="2" bgcolor="#0077B1"></td></tr>
			</table>
			<table align="center" width="648">
				<tr align="center" bgcolor="#efefef">
					<td class="td" nowrap><b>일자</b></td>
					<td class="td" nowrap><b>확인내용</b></td>
					<td class="td" nowrap><b>관련기관</b></td>
				</tr>
				<tr>
					<td colspan="3" class="td" align="center" bgcolor="#efefef">
						<b>계약전
						</b>
					</td>
				</tr>
				<tbody id = "contractBListBody">
				<c:forEach items="${suimRptBody16_3BList}" var="contractB">
					<c:if test="${contractB.contractBa eq 1}">
						<tr id = "Print16_3BListTr_${contractB.serialNo}">
							<td class="td">
								<span class="print16_3BSpanClass_${contractB.serialNo}" id = "confirmDateBSpanId_${contractB.serialNo}">${contractB.confirmDateSpan}</span>
							</td>
							<td class="td">
								<span class="print16_3BSpanClass_${contractB.serialNo}" id = "confirmDtlBSpanId_${contractB.serialNo}">${contractB.confirmDtlSpan}</span>
							</td>
							<td class="td">
								<span class="print16_3BSpanClass_${contractB.serialNo}" id = "relativeOrganBSpanId_${contractB.serialNo}">${contractB.relativeOrganSpan}</span>
							</td>
						</tr>
					</c:if>
				</c:forEach>
				</tbody>
				
				<tr>
					<td colspan="3" class="td" align="center" bgcolor="#efefef" >
						<b>계약일
						</b>
					</td>
				</tr>
				<tbody id = "contractDListBody">
				<c:forEach items="${suimRptBody16_3DList}" var="contractD">
					<c:if test="${contractD.contractBa eq 2}">
						<tr id = "Print16_3DListTr_${contractD.serialNo}">
							<td class="td">
								<span class="print16_3DSpanClass_${contractD.serialNo}" id = "confirmDateDSpanId_${contractD.serialNo}">${contractD.confirmDateSpan}</span>
							</td>
							<td class="td">
								<span class="print16_3DSpanClass_${contractD.serialNo}" id = "confirmDtlDSpanId_${contractD.serialNo}">${contractD.confirmDtlSpan}</span>
							</td>
							<td class="td">
								<span class="print16_3DSpanClass_${contractD.serialNo}" id = "relativeOrganDSpanId_${contractD.serialNo}">${contractD.relativeOrganSpan}</span>
							</td>
						</tr>
					</c:if>
				</c:forEach>
				</tbody>
				
				<tr>
					<td class="td" align="center" colspan="3" bgcolor="#efefef">
						<b>계약후
						</b>
					</td>
				</tr>		
				<tbody id = "contractAListBody">
				<c:forEach items="${suimRptBody16_3AList}" var="contractA">
					<c:if test="${contractA.contractBa eq 3}">
						<tr id = "Print16_3AListTr_${contractA.serialNo}">
							<td class="td">
								<span class="print16_3ASpanClass_${contractA.serialNo}" id = "confirmDateASpanId_${contractA.serialNo}">${contractA.confirmDateSpan}</span>
							</td>
							<td class="td">
								<span class="print16_3ASpanClass_${contractA.serialNo}" id = "confirmDtlASpanId_${contractA.serialNo}">${contractA.confirmDtlSpan}</span>
							</td>
							<td class="td">
								<span class="print16_3ASpanClass_${contractA.serialNo}" id = "relativeOrganASpanId_${contractA.serialNo}">${contractA.relativeOrganSpan}</span>
							</td>
						</tr>
					</c:if>
				</c:forEach>
				</tbody>
			</table>
			<p>&nbsp;</p>
			<table align="center" cellpadding="0" cellspacing="0" width="640">
				<tr>
					<td height="25" width="50%">
						<p><font color="#113F7D">▣ <b>타사 가입사항</b></font></p>
					</td>
					<td height="25" width="50%">
						<p align="right">
						</p>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0"  align="center" width="640">
				<tr>
					<td bgcolor="#ECECEC" class="td" width="120">
						<p align="center"><b>보험회사</b></p>
					</td>
					<td class="td" bgcolor="#ECECEC" width="120">
						<p align="center"><b>담보내용</b></p>
					</td>
					<td class="td" bgcolor="#ECECEC" width="130">
						<p align="center"><b>보험기간</b></p>
					</td>
					<td class="td" bgcolor="#ECECEC" width="180">
						<p align="center"><b>청구내용 및 결과</b></p>
					</td>
				</tr>
				
				<tbody id = "print16_4List">
					<c:forEach items="${suimRptBody16_4List }" var="suimRptBody16_4Vo">
						<tr id = "print16_4ListTr_${suimRptBody16_4Vo.serialNo}">
							<td align="center" class="td" id = "otherInsuComTd_${suimRptBody16_4Vo.serialNo}">
								<span id = "otherInsuComForSpan_${suimRptBody16_4Vo.serialNo}">${suimRptBody16_4Vo.otherInsuComSpan}</span>
							</td>
							<td class="td" id = "otherInsuMortgageTd_${suimRptBody16_4Vo.serialNo}">
								<span id = "otherInsuMortgageForSpan_${suimRptBody16_4Vo.serialNo}">${suimRptBody16_4Vo.otherInsuMortgageSpan}</span>
							</td>
							<td class="td">
								<span id = "otherInsuPeriodForSpan_${suimRptBody16_4Vo.serialNo}">${suimRptBody16_4Vo.otherInsuPeriodSpan}</span>
							</td>
							<td class="td">
								<span id = "otherInsuEtcMemoForSpan_${suimRptBody16_4Vo.serialNo}">${suimRptBody16_4Vo.otherInsuEtcMemoSpan}</span>
							</td>
						</tr>					
					</c:forEach>
				</tbody>
									
			</table>
			<p>&nbsp;</p>
			
			<table align="center" cellpadding="0" cellspacing="0" width="640">
				<tr>
					<td height="25" >
						<p class="p2">
							<font color="#113F7D">▣ <b>주요쟁점사항</b></font>
						</p>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" align="center" width="640">
				<tr>
					<td bgcolor="#ECECEC" class="td" width="20%" >
						<p align="center"><b>구분</b></p>
					</td>
					<td class="td" bgcolor="#ECECEC" width="80%">
						<p align="center"><b>쟁점사항</b></p>
					</td>
				</tr>
					
				<tr>
					<td class="td" >
					 	 <p align="center">사고내용</p>
		              </td>
		              <td  class="td">
		                 <p >
		                  	<span  id="accidentDtl6SpanId">${suimRptBody16_1267Vo.accidentDtl6Span}</span>
		             	 </p>
		          	</td>
				</tr>
				<tr>
					<td class="td" >
					 	 <p align="center">고지의무</p>
		              </td>
		              <td  class="td">
		                 <p >
		                  	<span  id="noticeDuty16SpanId">${suimRptBody16_1267Vo.noticeDuty16Span}</span>
		             	 </p>
		          	</td>
				</tr>
				<tr>
					<td class="td" >
					 	 <p align="center">통지의무</p>
		              </td>
		              <td  class="td">
		                 <p >
		                  	<span  id="noticeDuty26SpanId">${suimRptBody16_1267Vo.noticeDuty26Span}</span>
		             	 </p>
		          	</td>
				</tr>
				<tr>
					<td class="td" >
					 	 <p align="center">직업급수(확인)</p>
		              </td>
		              <td  class="td">
		                 <p >
		                  	<span  id="jobGradeConfirm6SpanId">${suimRptBody16_1267Vo.jobGradeConfirm6Span}</span>
		             	 </p>
		          	</td>
				</tr>
				<tr>
					<td class="td" >
					 	 <p align="center">의료자문</p>
		              </td>
		              <td  class="td">
		                 <p >
		                  	<span  id="counselMedical6SpanId">${suimRptBody16_1267Vo.counselMedical6Span}</span>
		             	 </p>
		          	</td>
				</tr>
				<tr>
					<td class="td" >
					 	 <p align="center">법률자문</p>
		              </td>
		              <td  class="td">
		                 <p >
		                  	<span  id="counselLegal6SpanId">${suimRptBody16_1267Vo.counselLegal6Span}</span>
		             	 </p>
		          	</td>
				</tr>
				<tr>
					<td class="td" >
					 	 <p align="center">관공서확인내용<br />(경찰서 등)</p>
		              </td>
		              <td  class="td">
		                 <p >
		                  	<span  id="confirmPublic6SpanId">${suimRptBody16_1267Vo.confirmPublic6Span}</span>
		             	 </p>
		          	</td>
				</tr>
				<tr>
					<td class="td" >
					 	 <p align="center">사고현장사진</p>
		              </td>
		              <td  class="td">
		                 <p >
		                  	<span  id="sitePicture6SpanId">${suimRptBody16_1267Vo.sitePicture6Span}</span>
		             	 </p>
		          	</td>
				</tr>
				<tr>
					<td class="td" >
					 	 <p align="center">장해율/<br />장해상태확인</p>
		              </td>
		              <td  class="td">
		                 <p >
		                  	<span  id="disability6SpanId">${suimRptBody16_1267Vo.disability6Span}</span>
		             	 </p>
		          	</td>
				</tr>
			</table>
			<p>&nbsp;</p>
			<table align="center" cellpadding="0" cellspacing="0" width="640">
				<tr>
					<td height="25" width="50%">
						<p class="p2">
							<font color="#113F7D">▣ <b>관련자면담 및 특이사항</b></font>
						</p>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" align="center" width="640">
				<tr>
					<td bgcolor="#ECECEC" class="td" width="20%">
						<p align="center"><b>구분</b></p>
					</td>
					<td  class="td" bgcolor="#ECECEC" width="80%">
						<p align="center"><b>쟁점사항</b></p>
					</td>
				</tr>
				<tr>
					<td class="td" >
					 	 <p align="center">피보험자<br />(or 유가족<br />면담사항)</p>
		              </td>
		              <td  class="td">
		                 <p >
		                  	<span class= "print16_7SpanClass" id="faceMemo7SpanId">${suimRptBody16_1267Vo.faceMemo7Span}</span>
		             	 </p>
		          	</td>
				</tr>
				<tr>
					<td class="td" >
					 	 <p align="center">독립손사<br />(세부정보포함)</p>
		              </td>
		              <td  class="td">
		                 <p >
		                  	<span class= "print16_7SpanClass" id="delegate7SpanId">${suimRptBody16_1267Vo.delegate7Span}</span>
		             	 </p>
		          	</td>
				</tr>
				<tr>
					<td class="td" >
					 	 <p align="center">탐문내용</p>
		              </td>
		              <td  class="td">
		                 <p >
		                  	<span class= "print16_7SpanClass" id="questioning7SpanId">${suimRptBody16_1267Vo.questioning7Span}</span>
		             	 </p>
		          	</td>
				</tr>
				<tr>
					<td class="td" >
					 	 <p align="center">안내<br />및 특이사항</p>
		              </td>
		              <td  class="td">
		                 <p >
		                  	<span class= "print16_7SpanClass" id="guideEtc7SpanId">${suimRptBody16_1267Vo.guideEtc7Span}</span>
		             	 </p>
		          	</td>
				</tr>
				<tr>
					<td class="td" >
					 	 <p align="center">추가서류창구</p>
		              </td>
		              <td  class="td">
		                 <p >
		                  	<span class= "print16_7SpanClass" id="moreDocument7SpanId">${suimRptBody16_1267Vo.moreDocument7Span}</span>
		             	 </p>
		          	</td>
				</tr>
			</table>
			<p>&nbsp;</p>
			<table align="center" cellpadding="0" cellspacing="0" width="640" bgcolor="white">
				<tr>
					<td width="50%" height="30">
						<p><font color="#113F7D">▣ <b>사고조사 처리과정</b></font></p>
					</td>
					<td width="50%" height="30">
						
					</td>
				</tr>
				<tr><td width="640" height="1" colspan="2" bgcolor="#0077B1"></td></tr>
			</table>
			<table align="center" width="640">
				<tr align="center" bgcolor="#efefef">
					<td class="td" ><p><b>진행일시</b></p></td>
					<td class="td" ><p><b>주요내용</b></p></td>
					<td class="td" ><p><b>면담자</b></p></td>
					<td class="td" ><p><b>관계</b></p></td>
					<td class="td" ><p><b>접촉방법</b></p></td>
				</tr>
				<tbody align="center" id = "sagoList16">
					<c:forEach items="${sagoList}" var="sagoRptVo16">
						<tr id = "print16_Ctrl_${sagoRptVo16.serialNo}" >
							<td class="td">
								<span id = "controlDate16_${sagoRptVo16.serialNo}">${sagoRptVo16.controlDate}</span>
							</td>
							<td class="td">
								<span id = "controlMemo16_${sagoRptVo16.serialNo}">${sagoRptVo16.controlMemoSpan}</span>
							</td>
							<td class="td">
								<span id = "controlWho16_${sagoRptVo16.serialNo}">${sagoRptVo16.controlWho}</span>
							</td>
							<td class="td">
								<span id = "controlRelation16_${sagoRptVo16.serialNo}">${sagoRptVo16.controlRelation}</span>
							</td>
							<td class="td">
								<span id = "controlContact16_${sagoRptVo16.serialNo}">${sagoRptVo16.controlContact}</span>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<p>&nbsp;</p>
			<table align="center" cellpadding="0" cellspacing="0" width="640">
				<tr>
					<td width="640">
						<p>상기와 같이 위임받은 사고조사에 대하여 신의성실의 원칙에 의거 공정하게 처리되었음을 확인하고, 보고서를 제출합니다.</p>
					</td>
				</tr>
			</table>
			
			</td>
		</tr>
	</table>
</body>
<script language="JavaScript">
<!--
window.print();
-->
</script>
</html>

