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
A:link {color: #000000;text-decoration: none; }
A:visited {color: #000000;text-decoration: none;}
A:hover {color:#0000ff;text-decoration: none;}
A:active {color: #000000;text-decoration: none;}

p{color:#000000; font-size:10pt; line-height:150%; margin-top:0; margin-bottom:0; font-family:굴림,굴림체;}
.p2{color:#000000; font-size:14pt; line-height:200%; margin-top:0; margin-bottom:0; font-family:굴림,굴림체;}
input {border:solid 1 #dcdcdc; background-color:#ffffff; font-size:10pt; ime-mode:active;}
.input2 {border:solid 1 #003399; background-color:#ffffff; font-size:10pt; ime-mode:active;}
.inputb {border:solid 1 #003399; background-color:#ffffff; font-size:10pt; ime-mode:active;}
textarea {border:solid 1 #dcdcdc; background-color:#ffffff; font-size:10pt; ime-mode:active;}
in_text {border:solid 1 #666666; font-family:굴림,굴림체; font-size:10pt;}
.font_small{color:#999999;font-size:9pt;font-family:돋움,돋움체;line-height:130%;margin-left:0;margin-right:0;margin-top:0;margin-bottom:0;}

table {border-collapse:collapse;border-spacing:0; font-size:10pt;}
.td {border:1px solid #000000; padding:3px;word-break:break-all;}
.td_box {border:1px solid #000000; padding:10px;}
.td_sample {border:1px solid #cccccc; padding:3px;}
.radio{border:0;background-color:transparent;}
.btn{border:0;background-color:transparent;}
.tdb {border:1px solid #000000; padding:3px; color:#000000; font-size:10pt; line-height:150%; margin-top:0; margin-bottom:0; font-family:굴림,굴림체;}
.tdb p {color:#000000; font-size:10pt; line-height:150%; margin-top:0; margin-bottom:0; font-family:굴림,굴림체;}

body {
width:640px;
background-color:#ffffff;
color:#000000;
font-family:굴림,굴림체;
font-size:11pt;
margin-left:0;margin-right:0;margin-top:0;margin-bottom:0;
color: #000000;
scrollbar-face-color: #FFFFFF;
scrollbar-shadow-color: #CCCCCC; 
scrollbar-highlight-color: #F0F0F0; 
scrollbar-3dlight-color: #CCCCCC;
scrollbar-darkshadow-color: #CCCCCC; 
scrollbar-track-color: #F0F0F0; 
scrollbar-arrow-color: #0083c7;
}
-->
</style>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
	<table id = "rptBody6Table" align="center" cellpadding="0" cellspacing="0" width="648">
		<tr>
			<td>
				<p align="center"><img src="https://toplac.co.kr/resources/ls_img/ls_body/print_head.jpg" width="640" height="56" border="0"></p>
				<p align="center" style="line-height:50%; margin-top:0; margin-bottom:0;">&nbsp;</p>
				<p align="center"><span style="font-size:9pt;">${tmInforForBody.team_addr}</span></p> 
				<p align="center"><span style="font-size:9pt;">전화 : ${tmInforForBody.team_interphone} &nbsp;팩스 : ${tmInforForBody.team_fax} &nbsp;이메일 : ${mbrVoForBody.email}</span></p>
				<hr size="1" width="640" noshade color="black">
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<table cellpadding="0" cellspacing="0" width="648" align="center">
					<tr>
						<th width="85" height="30" align="center">
							<p>수 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신</p>
						</th>
						<th width="350" align="left">
							<p>: ${suimVO.ptnr_name}</p>
						</th>
						<th width="90" align="right">
							<p>Report No.</p>
						</th>
						<th width="115" align="left">
							<p>&nbsp;${suimVO.suim_accept_no}</p>
						</th>
					</tr>
					<tr>
						<th height="30" width="85" align="center">
							<p>참 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조</p>
						</th>
						<th width="350" align="left">
							<p>: ${suimVO.ptnr_dept_nm} 
							<c:if test="${suimVO.ptnr_mbr_nm ne ''}">
								(담당 : ${suimVO.ptnr_mbr_nm} 님)
							</c:if></p>
						</th>
						<th width="90" align="right">
							<p>Date.</p>
						</th>
						<th width="115" align="left">
							<p>&nbsp;
							<c:if test="${suimInvVO.invoiceDate eq '' or suimInvVO.invoiceDate eq null}">
								날짜 정보없음
							</c:if>
							<c:if test="${suimInvVO.invoiceDate ne '' or suimInvVO.invoiceDate ne null}">
								${suimInvVO.invoiceDate }
							</c:if>
								
							</p>
						</th>
					</tr>
					<tr>
						<th height="30" width="85" align="center">
							<p>제 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</p>
						</th>
						<th width="555" colspan="3" align="left">
							<p>: ${suimVO.insurance_nm} 
								<c:if test="${suimVO.beneficiary_nm ne ''}">
									&quot;<b>${suimVO.beneficiary_nm}</b>&quot;
								</c:if>
								 손해사정서
							 </p>
						</th>
					</tr>
					<tr>
						<th height="30" width="85" align="center">
							<p>증  &nbsp;권  &nbsp;번  &nbsp;호</p>
						</th>
						<th width="555" colspan="3" align="left">
							<p><b>: 제 ${suimVO.policy_no} 호</b></p>
						</th>
					</tr>
					
					<tr>
						<th height="30" width="85" align="center">
							<p>사  &nbsp;고  &nbsp;번  &nbsp;호</p>
						</th>
						<th width="555" colspan="3" align="left">
							<p><b>: ${suimVO.accident_no}</b></p>
						</th>
					</tr>
					
					<tr>
						<td colspan="4" height="120" width="640">
							<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							귀사의 요청에 의거하여 피보험자 <b>&quot;${suimVO.beneficiary_nm}&quot;</b> 의 
			                        보험금 청구건에 대한 사고조사를 실시하고, 그 결과를 
			                        다음과 같이 제출합니다.
							</p>	
						</td>
					</tr>
				</table>
				
				<p>&nbsp;</p>
				<div  align="right">
				<table cellpadding="0" cellspacing="0" width="640" align="center">
	                <tr>
	                    <td height="70" width="500">
	                        <p>&nbsp;</p>
	                        <p>&nbsp;</p>
	                        <p align="right">손해사정사</p>
	                    </td>
	                    <td width="65">
	                        <p>&nbsp;</p>
	                        <p>&nbsp;</p>
	                        <p>&nbsp;: 윤경수</p>
	                    </td>
	                    <td width="75" rowspan="2">
	                        <p><img src="https://toplac.co.kr/resources/ls_img/ls_body/sign_yoon.jpg" width="72" height="70" border="0"></p>
	                    </td>
	                </tr>
	                <tr>
	                    <td width="565" colspan="2">
	                        <p align="right">070-8255-3000</p>
	                    </td>
	                </tr>
	                <tr>
	                    <td height="50" width="500">
	                        <p>&nbsp;</p>
	                        <p align="right">결 &nbsp;&nbsp;재 &nbsp;&nbsp;자 :</p>
	                    </td>
	                    <td width="65">
	                        <p>&nbsp;</p>
	                        <p>&nbsp; ${mbrVoForBodySantion.user_name}</p>
	                    </td>
	                    <td width="75" rowspan="2">
	                        <p>
                        		<c:choose>
                        			<c:when test="${mbrVoForBodySantion.user_sign ne null}">
			                        	<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${mbrVoForBodySantion.user_no}/${mbrVoForBodySantion.user_sign}" width=50 height=50 border=0>	                        	
                        			</c:when>
                        			<c:otherwise>
		                        		사인 없음
                        			</c:otherwise>
                        		</c:choose>                     			                        	
	                        </p>
	                    </td>
	                </tr>
	                <tr>
	                    <td width="565" colspan="2">
	                        <p align="right">${mbrVoForBodySantion.handphone }</p>
	                    </td>
	                </tr>
	                <tr>
	                    <td height="50" width="500">
	                        <p>&nbsp;</p>
	                        <p align="right">조 &nbsp;&nbsp;사 &nbsp;&nbsp;자 :</p>
	                    </td>
	                    <td width="65">
	                        <p>&nbsp;</p>
	                        <p>&nbsp; ${mbrVoForBody.user_name }</p>
	                    </td>
	                    <td width="75" rowspan="2">
	                        <p>
                               <c:choose>
                        			<c:when test="${signVoForRptUser.user_sign ne '' or signVoForRptUser.user_sign ne null}">
			                        	<img src='https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${signVoForRptUser.user_no}/${signVoForRptUser.user_sign}' width=50 height=50 border=0>	                        	
                        			</c:when>
                        			<c:otherwise>
		                        		사인 없음
                        			</c:otherwise>
                        		</c:choose>                         			                        	
	                        </p>
	                    </td>
	                </tr>
	                <tr>
	                    <td width="565" colspan="2">
	                        <p align="right">${mbrVoForBody.handphone }</p>
	                    </td>
	                </tr>
	                <tr>
	                    <td colspan="3" height="170" valign="bottom" width="640">
							<p align="center">
<!-- 								<img src="https://www.toplac.co.kr/resources/ls_img/report/sign_report.jpg" width="300" height="80" border="0"> -->
								<img src="https://www.toplac.co.kr/resources/ne_img/sign_salary.jpg" />
							</p>
	                    </td>
	                </tr>
	            </table>
				</div>
				<p>&nbsp;</p>
	            <hr size="1" noshade color="black">
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td height="25" width="100%">
							<p class="p2">
								<b>1. 보험계약사항</b>
							</p>
						</td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" align="center" width="640">
					<colgroup>
						<col width="140"></col>
						<col width="100"></col>
						<col width="100"></col>
						<col width="100"></col>
						<col width="100"></col>
					</colgroup>
			
					<tr>
						<td bgcolor="#ECECEC" class="td" width="140">
							<p align="center"><b>구분</b></p>
						</td>
						<td colspan="4" class="td" bgcolor="#ECECEC" width="400">
							<p align="center"><b>내용</b></p>
						</td>
					</tr>
					<tr>
						<td class="td" width="140" >
							<p align="center">보험종목</p>
						</td>
						<td colspan="4" class="td" width="400" >
							<p>
								<span class= "insuNm1SpanClass" id="insuNm1SpanId">${suimVO.insurance_nm }</span>
							</p>
						</td>
					</tr>
					<tr>
						<td class="td" width="140">
							<p align="center">증권번호</p>
						</td>
						<td colspan="4" class="td" width="400">
							<p>
								<span class= "insuNo1SpanClass" id="insuNo1SpanId">${suimVO.policy_no }</span>
							</p>
						</td>
					</tr>
					<tr>
	                    <td class="td" width="140">
							<p align="center">계약자</p>
	                    </td>
	                    <td class="td" width="100">
	                        <p align="center">
	                        	<span class= "policyholderNmSpanClass" id="policyholderNmSpanId">${suimVO.policyholder_nm }</span>
	                        </p>
	                    </td>
	                    <td class="td" width="100" bgcolor="#ECECEC">
							<p align="center">주민번호</p>
	                    </td>
	                    <td colspan="2" width="200" class="td">
	                        <p align="center">
	                        	<span class= "policyholderSsnSpanClass" id="policyholderSsnSpanId">${suimVO.policyholder_ssn }</span>
	                        </p>
	                    </td>
					</tr>
					<tr>
	                    <td class="td" width="140">
							<p align="center">피보험자</p>
	                    </td>
	                    <td class="td" width="100">
	                        <p align="center">
	                        	<span class= "beneficiaryNmSpanClass" id="beneficiaryNmSpanId">${suimVO.beneficiary_nm }</span>
	                        </p>
	                    </td>
	                    <td class="td" width="100" bgcolor="#ECECEC" >
							<p align="center">주민번호</p>
	                    </td>
	                    <td colspan="2" width="200" class="td">
	                        <p align="center">
	                        	<span class= "beneficiarySsnSpanClass" id="beneficiarySsnSpanId">${suimVO.beneficiary_ssn }</span>
	                        </p>
	                    </td>
					</tr>
					<tr>
						<td class="td" width="140">
							<p align="center">주소</p>
						</td>
						<td colspan="4" width="400" class="td">
							<p>
								<span class= "print1_1SpanClass" id="insuredAddr1SpanId">${suimRptBody1_13467Vo.insuredAddr1 }</span>
							</p>
						</td>
					</tr>
					<tr>
						<td class="td" width="140">
							<p align="center">보험 기간</p>
						</td>
						<td colspan="4" width="400" class="td">
							<p>
								<span class= "print1_1SpanClass" id="insuTerm1SpanId">${suimRptBody1_13467Vo.insuTerm1 }</span>
							</p>
						</td>
					</tr>
					<tr>
						<td class="td" width="140">
							<p align="center">직 업</p>
						</td>
						<td colspan="4" class="td" width="400">
							<p>
								<span class= "print1_1SpanClass" id="insuredJob1SpanId">${suimRptBody1_13467Vo.insuredJob1 }</span>
							</p>
						</td>
					</tr>
					<tr>
						<td class="td" width="140">
							<p align="center">연락처</p>
						</td>
						<td colspan="4" class="td" width="400">
							<p>
								<span class= "print1_1SpanClass" id="policyholderTelSpanId">${suimVO.policyholder_tel }</span>
							</p>
						</td>
					</tr>
					<tr>
						<td rowspan="3" class="td" width="140">
							<p align="center">담보 내역 및 추정 금액</p>
						</td>
						<td colspan="2" class="td"  bgcolor="#ECECEC" width="200">
							<p align="center">
								담보 구분
							</p>
						</td>
						<td colspan="2" class="td"  bgcolor="#ECECEC" width="200">
							<p align="center">
								담보 내역
							</p>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="td" width="200">
							<p align="center">
								<span class= "print1_1SpanClass" id="insuMortgage1SpanId">${suimRptBody1_13467Vo.insuMortgage1 }</span>
							</p>
						</td>
						<td  class="td" colspan="2" width="200" >
							<p align="center">
								<span class= "print1_1SpanClass" id="insuMortgageDtl1SpanId">${suimRptBody1_13467Vo.insuMortgageDtl1 }</span>
							</p>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="td"  bgcolor="#ECECEC" width="200">
							<p align="center">
								추정금액		
							</p>
						</td>
						<td  class="td" colspan="2" width="200">
							<p align="center">
								<span class= "amtEstimatedDamageSpanClass" id="amtEstimatedDamageSpanId">${suimVO.amtEstimatedDamage}</span>
								원
							</p>
						</td>
					</tr>
				</table>
				<p>&nbsp;</p>
				
				<!-- 타 보험계약사항 -->
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td height="25" width="100%">
							<p class="p2">
								<b>2. 타 보험계약사항 </b>
							</p>
						</td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<tr>
						<td bgcolor="#ECECEC" class="td" width="140">
							<p align="center"><b>보험회사</b></p>
						</td>
						<td colspan="3" class="td" bgcolor="#ECECEC" width="500">
							<p align="center"><b>중요사항</b></p>
						</td>
					</tr>
					
					<tbody id = "print1_2List">
						<c:forEach items="${suimRptBody1_2List }" var="suimRptBody1_2Vo">
							<tr id = "print1_2ListTr_${suimRptBody1_2Vo.serialNo}">
								<td align="center" class="td" id = "otherInsuComTd_${suimRptBody1_2Vo.serialNo}">
									<span id = "otherInsuComForSpan_${suimRptBody1_2Vo.serialNo}">${suimRptBody1_2Vo.otherInsuComSpan}</span>
								</td>
								<td class="td" colspan="3" id = "otherInsuDtlTd_${suimRptBody1_2Vo.serialNo}">
									<span id = "otherInsuDtlForSpan_${suimRptBody1_2Vo.serialNo}">${suimRptBody1_2Vo.otherInsuDtlSpan}</span>
								</td>
							</tr>					
						</c:forEach>
					</tbody>							
				</table>
				<p>&nbsp;</p>
				<!-- //타 보험계약사항 -->
				
				<!-- 사고사항 -->
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td height="25" width="100%">
							<p class="p2">
								<b>3. 사고사항(청구내용)</b>
							</p>
						</td>
					</tr>
				</table>
				
				<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<tr>
						<td bgcolor="#ECECEC" class="td" width="140">
							<p align="center"><b>구분</b></p>
						</td>
						<td colspan="4" class="td" bgcolor="#ECECEC" width="500">
							<p align="center"><b>내용</b></p>
						</td>
					</tr>
					<tr>
						<td class="td">
							<p align="center">진단병명</p>
						</td>
						<td class="td">
							<p>
								<span class= "print1_3SpanClass" id="diagnosisDisease3SpanId">${suimRptBody1_13467Vo.diagnosisDisease3 }</span>
							</p>
						</td>
						<td class="td" bgcolor="#ECECEC">
							<p align="center">진단병원</p>
						</td>
						<td colspan="2" class="td">
							<p>
								<span class= "print1_3SpanClass" id="diagnosisHospital3SpanId">${suimRptBody1_13467Vo.diagnosisHospital3 }</span>
							</p>
						</td>
					</tr>
					<tr>
						<td class="td">
							<p align="center">사고일자</p>
						</td>
						<td colspan="4" class="td">
							<p>
								<span>${suimVO.accident_date}</span>
							</p>
						</td>
					</tr>
					<tr>
		              <td class="td">
						<p align="center">사고내용</p>
		              </td>
		              <td  colspan="4" class="td">
		                <p >
		                	<span class= "print1_3SpanClass" id="accidentDtl3SpanId">${suimRptBody1_13467Vo.accidentDtl3Span }</span>
		                </p>
		              </td>
					</tr>
					<tr>
						<td class="td" >
						 	 <p align="center">청구내용</p>
			              </td>
			              <td colspan="4" class="td">
			                 <p >
			                  	<span class= "print1_3SpanClass" id="claimDtl3SpanId">${suimRptBody1_13467Vo.claimDtl3Span }</span>
			             	 </p>
			          	</td>
					</tr>
				</table>
				<p>&nbsp;</p>
				<!-- //사고사항 -->
				
				<!-- 조사방향 및 결과 -->
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td height="25" width="100%">
							<p class="p2">
								<b>4. 조사방향 및 결과 </b>
							</p>
						</td>
					</tr>
				</table>
								
				<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640" style="word-break:break-all;">
					<tr>
						<td bgcolor="#ECECEC" class="td" width="140">
							<p align="center"><b>구분</b></p>
						</td>
						<td colspan="4" class="td" bgcolor="#ECECEC" width="500">
							<p align="center"><b>내용</b></p>
						</td>
					</tr>
					
					<tr>
						<td class="td" width="140">
							<p align="center">확인사항</p>
						</td>
						<td  colspan="4" class="td" width="500">
							<p >
							<span class= "print1_4SpanClass" id="inspectPoint4SpanId">
								${suimRptBody1_13467Vo.inspectPoint4Span}
							</span>
						   </p>
						</td>
					</tr>
					
					<tr>
						<td class="td" width="140">
							 <p align="center">조사결과</p>
						  </td>
						  <td colspan="4" class="td" width="500">
							 <p >
								<span class= "print1_4SpanClass" id="inspectResult4SpanId">${suimRptBody1_13467Vo.inspectResult4Span }</span>
							 </p>
						</td>
					</tr>
				</table>
				
				
				<!-- //조사방향 및 결과 -->
				<p>&nbsp;</p>
				
				<!-- 총괄경과표  -->
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td height="25" width="100%">
							<p class="p2">
								<b>5. 총괄경과표 </b>
							</p>
						</td>
					</tr>
				</table>
				<table style="word-break:break-all;" cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<tr>
						<td bgcolor="#ECECEC" class="td" width="140">
							<p align="center"><b>일자</b></p>
						</td>
						<td colspan="3" class="td" bgcolor="#ECECEC" width="360">
							<p align="center"><b>경위</b></p>
						</td>
						<td class="td" bgcolor="#ECECEC" width="90">
							<p align="center"><b>비고</b></p>
						</td>
					</tr>
					
					<tbody id = "Print1_5List">
						<c:forEach items="${suimRptBody1_5List }" var="suimRptBody1_5Vo">
							<tr id = "Print1_5ListTr_${suimRptBody1_5Vo.serialNo}">
								<td align="center" class="td" id = "processDateTd_${suimRptBody1_5Vo.serialNo}">
									<span id = "processDateSpan_${suimRptBody1_5Vo.serialNo}">${suimRptBody1_5Vo.processDateS} <br />~ ${suimRptBody1_5Vo.processDateE}</span>
								</td>
								<td class="td" colspan="3" id = "processDtlTd_${suimRptBody1_5Vo.serialNo}">
									<span id = "processDtlForSpan_${suimRptBody1_5Vo.serialNo}">${suimRptBody1_5Vo.processDtlSpan}</span>
								</td>
								<td class="td">
									<span id = "processEtcMemoForSpan_${suimRptBody1_5Vo.serialNo}">${suimRptBody1_5Vo.processEtcMemo}</span>
								</td>
							</tr>					
						</c:forEach>
					</tbody>
				</table>
				<p>&nbsp;</p>
				<!-- //총괄경과표-->
				
				<!-- 조사내용 -가 -->
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td height="25" >
							<p class="p2">
								<b>6-가. 조사내용</b>
							</p>
						</td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0"  align="center" width="640" style="word-break:break-all;" > 
					<tr>
						<td bgcolor="#ECECEC" class="td" width="640"colspan="2" style="border-bottom:0;" >
							<p align="left"><b>가.</b>
								<span id = "faceOutline6SpanId" class="print1_6SpanClass">${suimRptBody1_13467Vo.faceOutline6}</span>
							</p>
						</td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0"  align="center" style="word-break:break-all;">
					<tr>
			             <td class="td" bgcolor="#ECECEC" width="130">
						<p align="center">피보험자직업</p>
			             </td>
			             <td  class="td" width="510"> 
			               <p >
			               	<span class= "print1_6SpanClass" id="faceInsuredJob6SpanId">
			               		${suimRptBody1_13467Vo.faceInsuredJob6}
			               	</span>
			               </p>
			             </td>
					</tr>
					<tr>
						<td class="td" bgcolor="#ECECEC">
						 	 <p align="center">보험가입경위</p>
			              </td>
			              <td class="td">
			                 <p >
			                  	<span class= "print1_6SpanClass" id="faceContractSituation6SpanId">${suimRptBody1_13467Vo.faceContractSituation6Span }</span>
			             	 </p>
			          	</td>
					</tr>
					<tr>
						<td class="td" bgcolor="#ECECEC">
						 	 <p align="center">발병경위<br />및<br />사고경위</p>
			              </td>
			              <td class="td">
			                 <p >
			                  	<span class= "print1_6SpanClass" id="faceOccurSituation6SpanId">${suimRptBody1_13467Vo.faceOccurSituation6Span }</span>
			             	 </p>
			          	</td>
					</tr>
					<tr>
						<td class="td" bgcolor="#ECECEC">
						 	 <p align="center">중요사항 고지 및<br />자필서명 여부</p>
			              </td>
			              <td class="td">
			                 <p >
			                  	<span class= "print1_6SpanClass" id="faceInformSignYn6SpanId">${suimRptBody1_13467Vo.faceInformSignYn6Span }</span>
			             	 </p>
			          	</td>
					</tr>
					<tr>
						<td class="td" bgcolor="#ECECEC">
						 	 <p align="center">기타사항</p>
			              </td>
			              <td class="td">
			                 <p >
			                  	<span class= "print1_6SpanClass" id="faceEtcMemo6SpanId">${suimRptBody1_13467Vo.faceEtcMemo6Span }</span>
			             	 </p>
			          	</td>
					</tr>
				</table>
				<p>&nbsp;</p>
				<!-- //조사내용 -가 -->
				
				<!-- 조사내용 -나 -->
				<table align="center" cellpadding="0" cellspacing="0" width="640" style="word-break:break-all;">
					<tr>
						<td height="25" width="100%">
							<p class="p2">
								<b>6-나. 조사내용</b>
							</p>
						</td>
					</tr>
				</table>
				<table style="word-break:break-all;" cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<tbody id = "Print1_6_1List">
						<c:forEach items="${suimRptBody1_6_1List }" var="suimRptBody1_6_1Vo">
							<tr class="Print1_6_1ListTr_${suimRptBody1_6_1Vo.serialNo}">
								<td bgcolor="#ECECEC" class="td" width="648" id = "investigateOutlineTd_${suimRptBody1_6_1Vo.serialNo}">
									<p>
										<span id = "investigateOutlineSpan_${suimRptBody1_6_1Vo.serialNo}"><b>나-${suimRptBody1_6_1Vo.ROWNUM}.${suimRptBody1_6_1Vo.investigateOutline}</b></span>
									</p>
								</td>
							</tr>
							<tr class = "Print1_6_1ListTr_${suimRptBody1_6_1Vo.serialNo}">
								<td class="td"  id = "investigateDtlTd_${suimRptBody1_6_1Vo.serialNo}">
									<span id = "investigateDtlSpan_${suimRptBody1_6_1Vo.serialNo}">${suimRptBody1_6_1Vo.investigateDtlSpan}</span>
								</td>
							</tr>				
						</c:forEach>
					</tbody>
				</table>
				<p>&nbsp;</p>
				<!-- //조사내용 -나 -->
				
				<!-- 조사내용 -다-1 -->
				<table style="word-break:break-all;" align="center" cellpadding="0" cellspacing="0" width="648">
					<tr>
						<td height="25" width="100%">
							<p class="p2">
								<b>6-다-1. 조사내용</b>
							</p>
						</td>
					</tr>
				</table>
				<table  style="word-break:break-all;" cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<tr>
						<td bgcolor="#ECECEC" class="td" width="640" style="border-bottom:0;">
							<p align="left"><b>다-1. 과거력 확인사항</b></p>
						</td>
					</tr>
				</table>
				<table style="word-break:break-all;" cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<tr>
			             <td class="td" width="140" >
							<p align="center">확인사항</p>
			             </td>
			             <td  colspan="4" class="td" width="501" >
			               <p >
				               	<span class= "print1_6_cSpanClass" id="pastRespect6SpanId">${suimRptBody1_13467Vo.pastRespect6Span}</span>
			               </p>
			             </td>
					</tr>
					<tr>
						<td class="td" >
						 	 <p align="center">탐문병원</p>
			              </td>
			              <td colspan="4" class="td">
			                 <p >
			                  	<span class= "print1_6_cSpanClass" id="pastHospital6SpanId">${suimRptBody1_13467Vo.pastHospital6Span }</span>
			             	 </p>
			          	</td>
					</tr>
					<tr>
						<td class="td" >
						 	 <p align="center">탐문결과</p>
			              </td>
			              <td colspan="4" class="td">
			                 <p >
			                  	<span class= "print1_6_cSpanClass" id="pastResult6SpanId">${suimRptBody1_13467Vo.pastResult6Span }</span>
			             	 </p>
			          	</td>
					</tr>
				</table>
				<p>&nbsp;</p>
				<!-- //조사내용 -다-1 -->
				
				<!-- 조사내용 -다-2 -->
				<table style="word-break:break-all;" align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td height="25" width="100%">
							<p class="p2">
								<b>6-다-2. 조사내용</b>
							</p>
						</td>
					</tr>
				</table>
				<table style="word-break:break-all;" cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<tr>
						<td bgcolor="#ECECEC" class="td" width="640" style="border-bottom:0;">
							<p align="left"><b>다-2. 기타사항</b></p>
						</td>
					</tr>
				</table>
				<table style="word-break:break-all;" cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<tbody id = "Print1_6_2List">
						<c:forEach items="${suimRptBody1_6_2List }" var="suimRptBody1_6_2Vo">
							<tr id = "Print1_6_2ListTr_${suimRptBody1_6_2Vo.serialNo}">
								<td align="center" class="td" width="140" >
									<span id = "confirmOutlineSpan_${suimRptBody1_6_2Vo.serialNo}">${suimRptBody1_6_2Vo.confirmOutline}</span>
								</td>
								<td class="td" colspan="3" width="448" >
									<span id = "confirmDtlSpan_${suimRptBody1_6_2Vo.serialNo}">${suimRptBody1_6_2Vo.confirmDtlSpan}</span>
								</td>
							</tr>					
						</c:forEach>
					</tbody>
				</table>
				<p>&nbsp;</p>
				<!-- //조사내용 -다-2 -->
				
				<!-- 7.손해사정 결과 -->
				<table style="word-break:break-all;" align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td height="25" >
							<p class="p2">
								<b>7. 손해사정 결과 </b>
							</p>
						</td>
					</tr>
				</table>
				<table style="word-break:break-all;" cellpadding="0" cellspacing="0"  align="center" width="640" > 
					<tr>
		               <td class="td" width="640">
			               	<span class= "print1_7SpanClass" id="adjustResult7SpanId">
			               		${suimRptBody1_13467Vo.adjustResult7Span}
			               	</span>
		               	</td>
					</tr>
				</table>
				<p>&nbsp;</p>
				<!-- //7.손해사정 결과-->
				
				<!-- 8.첨부파일 목록 -->
				<table style="word-break:break-all;" align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td height="25" width="100%">
							<p class="p2">
								<b>8. 첨부자료 목록 </b>
							</p>
						</td>
					</tr>
				</table>
				<table style="word-break:break-all;" cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<tr>
						<td bgcolor="#ECECEC" class="td" width="45" >
							<p align="center"><b>순번</b></p>
						</td>
						<td class="td" bgcolor="#ECECEC" width="320">
							<p align="center"><b>첨부자료</b></p>
						</td>
						<td class="td" bgcolor="#ECECEC" width="50" >
							<p align="center"><b>부수</b></p>
						</td>
						<td class="td" bgcolor="#ECECEC" width="225" >
							<p align="center"><b>비고</b></p>
						</td>
					</tr>
					<tbody id = "Print1_8List">
						<c:forEach items="${suimRptBody1_8List }" var="suimRptBody1_8Vo">
							<tr id = "Print1_8ListTr_${suimRptBody1_8Vo.serialNo}">
								<td align="center" class="td">
									<span >${suimRptBody1_8Vo.ROWNUM}</span>
								</td>
								<td class="td"  >
									<span id = "attachNameSpan_${suimRptBody1_8Vo.serialNo}">${suimRptBody1_8Vo.attachName}</span>
								</td>
								<td class="td" align="center" >
									<span id = "attachCopySpan_${suimRptBody1_8Vo.serialNo}">${suimRptBody1_8Vo.attachCopy}</span>
								</td>
								<td class="td"  >
									<span id = "attachEtcMemoSpan_${suimRptBody1_8Vo.serialNo}">${suimRptBody1_8Vo.attachEtcMemo}</span>
								</td>
							</tr>					
						</c:forEach>
					</tbody>
				</table>
				<p>&nbsp;</p>
				<!-- //8.첨부파일 목록-->
				
				<p>&nbsp;</p>
				<p align="center"><b>본 손해사정서는 당사의 양식과 최선의 노력으로 이해 당사자</b></p>
				<p align="center"><b>어느 일방에도 편중됨이 없이 작성되었음을 명백히 합니다.[끝]</b></p>
				<p>&nbsp;</p>
				<hr size="1" noshade color="black">
				
				<!-- 사고처리 과정표 -->
				<p>&nbsp;</p>
				<table cellpadding="0" cellspacing="0" width="648" align="center">
					<tr>
						<td width="648" height="45" class="td">
							<p style="line-height:200%;" align="center"><font size="5"><b>사 고 처 리 과 정 표</b></font></p>
						</td>
					</tr>
				</table>
				<table align="center" cellpadding="0" cellspacing="0" width="648">
					<tr>
						<td height="25" width="50%">
							<p class="p2"><b>처리과정(서류접수 현황포함)</b></p>
						</td>
						<td height="25" width="50%">
							<p>&nbsp;</p>
						</td>
					</tr>
				</table>
				<table style="word-break:break-all;" cellSpacing=0 cellPadding="0" width="648" align="center" bordercolordark="white" bordercolorlight="#999999">
					<tr>
						<td bgcolor="#ECECEC" class="td" width="208">
							<p align="center"><b>일 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자</b></td>
						<td bgcolor="#ECECEC" class="td" width="208">
							<p align="center"><b>항 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</b></td>
						<td bgcolor="#ECECEC" class="td" width="220">
							<p align="center"><b>처 &nbsp;리 &nbsp;내 &nbsp;용</b></p>
						</td>
					</tr>
					<tbody id="print1_Ctrl">
					<c:forEach items="${sagoList }" var="sagoVo">
						<tr id = "print1_Ctrl_${sagoVo.sagoNo }">
							<td class="td">
								<p align="center">${sagoVo.regDate }</p></td>
							<td class="td">
								<p align="center">${sagoVo.item }</p></td>
							<td class="td">
								<p align="center">${sagoVo.content }</p>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				<p>&nbsp;</p>
				<!-- //사고처리 과정표-->
				
				<!-- 첨부파일 -->
				<table align="center" cellpadding="0" cellspacing="0" width="648">
					<tr>
						<td height="25" width="50%">
							<p class="p2"><b>&lt; 첨부 사진 &gt;</b></p>
						</td>
					</tr>
				</table>
			
				<!-- //첨부파일-->
				
				<c:forEach items="${suimRptImgPrint_1List}" var="attachPrint1ImgVo">
					<div align="center" style="float:left; padding-top:10px;  break-word : nowrap; " >
						<img
							src='https://www.toplac.co.kr/home/hosting_users/toplac/www${attachPrint1ImgVo.filePath}${attachPrint1ImgVo.imgName}'
							id='print1ImgStream_${attachPrint1ImgVo.serialNo}' width='300'
							height='225' style='vertical-align: middle;' /> <br />${attachPrint1ImgVo.imgMemo}
					</div>
				</c:forEach>
			</td>
		</tr>
	</table>
	
	
</body>
</html>