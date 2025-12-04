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
.td {border:1px solid #000000; padding:3px;}
.td_box {border:1px solid #000000; padding:10px;}
.td_sample {border:1px solid #cccccc; padding:3px;}
.radio{border:0;background-color:transparent;}
.btn{border:0;background-color:transparent;}
.tdb {border:1px solid #000000; padding:3px; color:#000000; font-size:10pt; line-height:150%; margin-top:0; margin-bottom:0; font-family:굴림,굴림체;}
.tdb p {color:#000000; font-size:10pt; line-height:150%; margin-top:0; margin-bottom:0; font-family:굴림,굴림체;}

body {
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
				<p align="center"><img src="https://www.toplac.co.kr/resources/ls_img/ls_body/print_head.jpg" width="640" height="56" border="0"></p>
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
					</tr>
					<tr>
						<th height="30" width="85" align="center">
							<p>제 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</p>
						</th>
						<th width="555" colspan="3" align="left">
							<p>: ${suimVO.insurance_nm} 
								<c:if test="${suimVO.policyholder_nm ne ''}">
									&quot;<b>${suimVO.policyholder_nm}</b>&quot;
								</c:if>
								 손해사정서
							 </p>
						</th>
					</tr>
					<tr>
						<th height="30" width="85" align="center">
							<p>증&nbsp; 권&nbsp; 번&nbsp; 호</p>
						</th>
						<th width="555" colspan="3" align="left">
							<p><b>: 제 ${suimVO.policy_no} 호</b></p>
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
				<table cellpadding="0" cellspacing="0" width="640">
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
	                        <p><img src="https://www.toplac.co.kr/resources/ls_img/ls_body/sign_yoon.jpg" width="72" height="70" border="0"></p>
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
	                        <p>&nbsp; 
	                        	<c:choose>
		                        	<c:when test="${mbrVoForBodySantion ne null}">
			                        	${mbrVoForBodySantion.user_name}	                        	
		                        	</c:when>
		                        	<c:otherwise>
		                        		<font color="red"> 미상신</font>
		                        	</c:otherwise>
	                        	</c:choose>
	                        </p>
	                    </td>
	                    <td width="75" rowspan="2">
	                        <p>
								<c:choose>
									<c:when test="${mbrVoForBodySantion.user_sign ne null}">
										<%-- <img src="/home/hosting_users/toplac/www/ls_data/member_sign/${mbrVoForBodySantion.user_no}/${mbrVoForBodySantion.user_sign}" width=50 height=50 border=0> --%>	                        	
										<img src="https://toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${mbrVoForBodySantion.user_no}/${mbrVoForBodySantion.user_sign}" width=50 height=50 border=0>
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
										<%-- <img src='/home/hosting_users/toplac/www/ls_data/member_sign/${signVoForRptUser.user_no}/${signVoForRptUser.user_sign}' width=50 height=50 border=0> --%>	                        	
										<img src="https://toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${signVoForRptUser.user_no}/${signVoForRptUser.user_sign}" width=50 height=50 border=0>
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
	            <table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td colspan="2" height="25" width="20%">
							<p class="p2">
								<b>1. 계약확인사항
								</b>
							</p>
						</td>
					</tr>
				</table>
	            <table cellpadding="0" cellspacing="0" align="center" width="640">
	                 <tr>
	                    <td class="td" width="20%" bgcolor="#ECECEC">
							<p align="center"><B>보 &nbsp;험 &nbsp;종 &nbsp;목</B></p>
	                    </td>
	                    <td colspan="2" class="td" width="70%">
	                        <p align="center">${suimVO.insurance_nm }</p>
	                    </td>
	                    
					</tr>
	                 <tr>
	                    <td class="td" bgcolor="#ECECEC">
							<p align="center"><B>증 &nbsp;권 &nbsp;번 &nbsp;호</B></p>
	                    </td>
	                    <td colspan="2" class="td">
	                        <p align="center">${suimVO.policy_no }</p>
	                    </td>
					</tr>
	                 <tr>
	                    <td class="td" bgcolor="#ECECEC">
	                        <p align="center"><B><span style="font-size:9pt;">계약자/ 피보험자</span></B></p>
	                    </td>
	                    <td colspan="2" class="td">
							<p align="center">${suimVO.policyholder_nm }(${suimVO.policyholder_ssn }) / ${suimVO.beneficiary_nm }(${suimVO.beneficiary_ssn })</p>
	                    </td>
					</tr>
	                 <tr>
	                   <td class="td" rowspan="2" bgcolor="#ECECEC">
	                       <p align="center"><B>청 &nbsp;구 &nbsp;담 &nbsp;보</B></p>
	                   </td>
	                   <td class="td" bgcolor="#ECECEC">
	                   	<p align="center">담 보 구 분</p>
	                   </td>
	                    <td class="td" bgcolor="#ECECEC">
	                    <p align="center">담 보 내 역</p>
	                   </td>
					</tr>
					 <tr>
		                  <td>
		                   	<p align="center">
	                   			<span >${suimRptBody9_13467Vo.insuMortgage1Span }</span>
		                   	</p>
		                  </td>
		                  <td class="td">
		                   	<p style="margin-left:10;">
	                   			<span  >${suimRptBody9_13467Vo.insuMortgageDtl1Span }</span>
		                   	</p> 
		                  	</td>
		              </tr>
	                <tr>
			            <td class="td" bgcolor="#ECECEC">
	                        <p align="center"><B>직무확인사항</B></p>
			            </td>
			            <td colspan="2" class="td">
			                <p>
			                	<span >${suimRptBody9_13467Vo.insuredJob1Span }</span>
			                </p>
			            </td>
	               </tr>
	            </table>
	            <p>&nbsp;</p>
	            
	            <!-- 조사결과(요약) -->
			<table align="center" cellpadding="0" cellspacing="0" width="640">
				<tr>
					<td height="25" >
						<p class="p2">
							<b>2. 조사결과(요약) 
							</b>
						</p>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" align="center" width="640">
				<tr>
					<td width="20%"></td>
					<td width="70%"></td>
				</tr>
				<tr>
					<td colspan="2" bgcolor="#ECECEC" class="td" >
						<p align="center"><b>청 구 사 항</b></p>
					</td>
				</tr>
				<tr>
					<td class="td" bgcolor="#ECECEC">
						<p align="center"><b>진단명</b></p>
					</td>
					<td class="td" >
						<p>
							<span >${suimRptBody9_13467Vo.diagnosisDisease3Span }</span>
						</p>
					</td>
				</tr>
				<tr>
					<td class="td" bgcolor="#ECECEC" >
						<p align="center"><b>사고개요</b></p>
					</td>
					<td class="td" >
						<p>
							<span >${suimRptBody9_13467Vo.accidentDtl3Span }</span>
						</p>
					</td>
				</tr>
				<tr>
	              <td colspan="2" class="td"  bgcolor="#ECECEC" >
					<p align="center"><b>조 사 결 과</b></p>
	              </td>
				</tr>
				<tr>
					<td class="td" bgcolor="#ECECEC">
						<p align="center"><b>확인사항</b></p>
					</td>
					<td class="td">
						<p>
							<span >${suimRptBody9_13467Vo.inspectPoint3Span }</span>
						</p>
					</td>
				</tr>
				<tr>
					<td class="td" bgcolor="#ECECEC">
						<p align="center"><b>결론</b></p>
					</td>
					<td class="td">
						<p>
							<span >${suimRptBody9_13467Vo.inspectResult3 }</span>
						</p>
					</td>
				</tr>
			</table>
			<!-- //조사결과(요약) -->
			<p>&nbsp;</p>
			<!-- 조사내용(요약) :가 -->
			<table align="center" cellpadding="0" cellspacing="0" width="640">
				<tr>
					<td height="25" width="70%">
						<p class="p2">
							<b>3. 조사내용(요약) : 가. 피보험자 면담사항
							</b>
						</p>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0"  align="center" width="640" > 
				<tr>
					<td bgcolor="#ECECEC" class="td" width="144" style="border-bottom:0px;">
						<p align="center"><b>구      분</b></p>
					</td>
					<td colspan="3" class="td" bgcolor="#ECECEC" width="500" style="border-bottom:0px;">
						<p align="center"><b>내           용</b></p>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0"  align="center" >
				<tr>
					<td class="td" bgcolor="#ECECEC" width="140" >
					 	 <p align="center"><b>보험가입경위</b></p>
		              </td>
		              <td class="td" width="485" >
		                 <p >
		                  	<span >${suimRptBody9_13467Vo.faceContractSituation4Span }</span>
		             	 </p>
		          	</td>
				</tr>
				<tr>
					<td class="td" bgcolor="#ECECEC">
					 	 <p align="center"><b>중요사항 고지 및<br />자필서명 여부</b></p>
		              </td>
		              <td class="td">
		                 <p >
		                  	<span >${suimRptBody9_13467Vo.faceInformSignYn4Span }</span>
		             	 </p>
		          	</td>
				</tr>
				<tr>
					<td class="td" bgcolor="#ECECEC">
					 	 <p align="center"><b>타 보험확인사항</b></p>
		              </td>
		              <td class="td">
		                 <p >
		                  	<span >${suimRptBody9_13467Vo.faceOtherInsuMemo4Span }</span>
		             	 </p>
		          	</td>
				</tr>
				
				<tr>
					<td class="td" bgcolor="#ECECEC">
					 	 <p align="center"><b>피보험자 요청사항</b></p>
		              </td>
		              <td class="td">
		                 <p >
		                  	<span >${suimRptBody9_13467Vo.faceInsuredDemand4Span }</span>
		             	 </p>
		          	</td>
				</tr>
			</table>
			<!-- //조사내용(요약) :가 -->
			<p>&nbsp;</p>
			<!-- 조사내용(요약) :나 -->
			<table align="center" cellpadding="0" cellspacing="0" width="640">
				<tr>
					<td height="25" width="80%">
						<p class="p2">
							<b>3. 조사내용(요약) : 나. 피보험자 병력사항 요약 경과표 
							</b>
						</p>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" align="center" width="640">
				<tr>
					<td bgcolor="#ECECEC" class="td" width="140">
						<p align="center"><b>일 자</b></p>
					</td>
					<td colspan="3" class="td" bgcolor="#ECECEC" width="300">
						<p align="center"><b>내 용</b></p>
					</td>
					<td class="td" bgcolor="#ECECEC" width="125">
						<p align="center"><b>기 관</b></p>
					</td>
				</tr>
				
				<tbody id = "print9_3aList">
					<c:forEach items="${SuimRptBody9_3aList }" var="suimRptBody9_3aVo">
						<tr id = "print9_3aListTr_${suimRptBody9_3aVo.serialNo}">
							<td align="center" class="td" id = "processDateTd_${suimRptBody9_3aVo.serialNo}">
								<span id = "processDateSpan_${suimRptBody9_3aVo.serialNo}">${suimRptBody9_3aVo.processDateS} <br />~ ${suimRptBody9_3aVo.processDateE}</span>
							</td>
							<td class="td" colspan="3" id = "processDtlTd_${suimRptBody9_3aVo.serialNo}">
								<span id = "processDtlSpan_${suimRptBody9_3aVo.serialNo}">${suimRptBody9_3aVo.processDtlSpan}</span>
							</td>
							<td align="center" class="td" id = "processHospitalTd_${suimRptBody9_3aVo.serialNo}">
								<span id = "processHospitalSpan_${suimRptBody9_3aVo.serialNo}">${suimRptBody9_3aVo.processHospital}</span>
							</td>
						</tr>					
					</c:forEach>
				</tbody>
			</table>
			<p>&nbsp;</p>
			<!-- //조사내용(요약) :나 -->
			
			<!-- 조사내용(요약) :다 -->
			<table align="center" cellpadding="0" cellspacing="0" width="640">
				<tr>
					<td height="25" width="80%">
						<p class="p2">
							<b>3. 조사내용(요약) : 다. 타 보험사 처리내역 
								<!-- <img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print9_3aShowHideBtnId" style="display:none; cursor:pointer; "  /> -->
							</b>
						</p>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" align="center" width="640">
				<tr>
					<td bgcolor="#ECECEC" class="td" width="115">
						<p align="center"><b>보험사</b></p>
					</td>
					<td colspan="3" class="td" bgcolor="#ECECEC" width="145">
						<p align="center"><b>계약내용</b></p>
					</td>
					<td class="td" bgcolor="#ECECEC" width="155">
						<p align="center"><b>진행사항</b></p>
					</td>
					<td class="td" bgcolor="#ECECEC" width="100">
						<p align="center"><b>비고</b></p>
					</td>
				</tr>
				
				<tbody id = "print9_3cList">
					<c:forEach items="${SuimRptBody9_3cList }" var="suimRptBody9_3cVo">
						<tr id = "print9_3cListTr_${suimRptBody9_3cVo.serialNo}">
							<td align="center" class="td" id = "otherInsuComTd_${suimRptBody9_3cVo.serialNo}">
								<span id = "otherInsuComSpan_${suimRptBody9_3cVo.serialNo}">${suimRptBody9_3cVo.otherInsuCom}</span>
							</td>
							<td class="td" colspan="3" id = "otherInsuContractTd_${suimRptBody9_3cVo.serialNo}">
								<span id = "otherInsuContractSpan_${suimRptBody9_3cVo.serialNo}">${suimRptBody9_3cVo.otherInsuContractSpan}</span>
							</td>
							<td class="td" id = "otherInsuProcessTd_${suimRptBody9_3cVo.serialNo}">
								<span id = "otherInsuProcessSpan_${suimRptBody9_3cVo.serialNo}">${suimRptBody9_3cVo.otherInsuProcessSpan}</span>
							</td>
							<td class="td" id = "otherInsuEtcMemoTd_${suimRptBody9_3cVo.serialNo}">
								<span id = "otherInsuEtcMemoSpan_${suimRptBody9_3cVo.serialNo}">${suimRptBody9_3cVo.otherInsuEtcMemoSpan}</span>
							</td>
						</tr>					
					</c:forEach>
				</tbody>
			</table>
			<p>&nbsp;</p>
			<!-- //조사내용(요약) :다 -->
            
            <!-- 청구 관련 조사내용(상세) -->
			<table align="center" cellpadding="0" cellspacing="0" width="640">
				<tr>
					<td height="25" width="80%">
						<p class="p2">
							<b>4. 청구관련 조사내용(상세) 
								<!-- <img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print9_3aShowHideBtnId" style="display:none; cursor:pointer; "  /> -->
							</b>
						</p>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" align="center" width="640">
				<tr>
					<td bgcolor="#ECECEC" class="td" width="550">
						<p align="left"><b>▶ 피보험자 조사내용</b></p>
					</td>
				</tr>
				
				<tbody id = "print9_3dList">
					<c:forEach items="${SuimRptBody9_3dList }" var="suimRptBody9_3dVo">
						<tr id = "print9_3dListTr_${suimRptBody9_3dVo.serialNo}">
							<td align="left" class="td" id = "investigateOutlineTd_${suimRptBody9_3dVo.serialNo}" >
								■ <span id = "investigateOutlineSpan_${suimRptBody9_3dVo.serialNo}">${suimRptBody9_3dVo.investigateOutline}</span><br />
								<span id = "investigateDtlSpan_${suimRptBody9_3dVo.serialNo}">${suimRptBody9_3dVo.investigateDtlSpan}</span>
							</td>
						</tr>					
					</c:forEach>
				</tbody>
			</table>
			<p>&nbsp;</p>
			<!-- //청구 관련 조사내용(상세) -->
			
			<!-- 기타병원_확인내용 -->
			<table cellpadding="0" cellspacing="0" align="center" width="640">
				<tr>
					<td bgcolor="#ECECEC" colspan="2" class="td" >
						<p align="left" style="display:inline;"><b>▶ 기타병원 확인내용</b></p>
					</td>
				</tr>
				<tr>
					<td class="td" width="640" >
						<p>
							<span >${suimRptBody9_13467Vo.hospitalMemo6Span }</span>
						</p>
					</td>
				</tr>
			</table>
			<!-- //기타병원_확인내용 -->
            <p>&nbsp;</p>
            <!-- 조사결과_상세내용 -->
			<table align="center" cellpadding="0" cellspacing="0" width="640">
				<tr>
					<td height="25" >
						<p class="p2">
							<b>5. 조사결과(상세) 
							</b>
						</p>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" align="center" width="640">
				<tr>
					<td bgcolor="#ECECEC" colspan="2" class="td" >
						<p align="left" style="display:inline;"><b>▶ 조사결과</b></p>
					</td>
				</tr>
				<tr>
					<td class="td" width="640" >
						<p>
							<span >${suimRptBody9_13467Vo.detailRecord7Span }</span>
						</p>
					</td>
				</tr>
			</table>
			<!-- //조사결과_상세내용 -->
            
            <p align="center">&nbsp;</p>
            <p align="center"><B>◁◁ 본 보고서는 최대 신의 성실로 공정하게 작성 되었음을 명백히 합니다. ▷▷ </B></p>
            <p>&nbsp;</p>
            
			<!-- 사고처리 과정표 -->
			<table cellpadding="0" cellspacing="0" width="640" align="center">
				<tr>
					<td width="635" height="45" class="td">
						<p style="line-height:200%;" align="center"><font size="5"><b>사 고 처 리 과 정 표</b></font></p>
					</td>
				</tr>
			</table>
			<table align="center" cellpadding="0" cellspacing="0" width="640">
                <tr>
                    <td height="25" width="50%">
						<p class="p2"><B>1. 일반사항</B></p>
                    </td>
                    <td height="25" width="50%">
						<p>&nbsp;</p>
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" align="center" width="640">
               <tr>
	               <td class="td" bgcolor="#ECECEC">
						<p align="center">보 험&nbsp;종 목</p>
	               </td>
	               <td class="td">
	                   	<p align="center">${suimVO.getInsurance_nm()}</p>
	               </td>
	               <td class="td" bgcolor="#ECECEC">
						<p align="center">피 보 험 자</p>
	               </td>
	               <td class="td">
	                  	<p align="center">${suimVO.getBeneficiary_nm()}</p>
	               </td>
				</tr>
                <tr>
                    <td class="td" bgcolor="#ECECEC">
						<p align="center">사 고 일 시</p>
                    </td>
                    <td class="td">
                        <p align="center">${suimVO.accident_date}</p>
                    </td>
                    <td class="td" bgcolor="#ECECEC" nowrap>
						<p align="center">보험사담당자</p>
                    </td>
                    <td class="td">
                        <p align="center">${suimVO.ptnr_mbr_nm}</p>
                    </td>
				</tr>
                <tr>
                    <td class="td" bgcolor="#ECECEC" nowrap>
						<p align="center">보고서접수일</p>
                    </td>
                    <td class="td">
                        <p align="center">${suimVO.getReg_date()}</p>
                    </td>
                    <td class="td" bgcolor="#ECECEC">
						<p align="center">조 &nbsp;&nbsp;사 &nbsp;&nbsp;자</p>
                    </td>
                    <td class="td">
                        <p align="center">${suimVO.user_name}</p>
                    </td>
				</tr>
            </table>
            <p>&nbsp;</p>
			<table align="center" cellpadding="0" cellspacing="0" width="640">
				<tr>
					<td height="25" width="50%">
						<p class="p2"><b>2. 처리과정</b></p>
					</td>
					<td height="25" width="50%">
						<p>&nbsp;</p>
					</td>
				</tr>
			</table>
			
			<table cellSpacing=0 cellPadding="0" width="635" align="center" >
				<colgroup>
					<col width="100"/>
					<col width="50"/>
					<col width="200"/>
					<col width="200"/>
					<col width="50"/>
					<col width="48"/>
				</colgroup>
                <tr>
                    <td bgcolor="#ECECEC" class="td" >
                        <p align="center"><b>일 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자</b></td>
                    <td bgcolor="#ECECEC" class="td" >
                        <p align="center"><b>일 수</b></p>
                    </td>
                    <td bgcolor="#ECECEC" class="td" >
                        <p align="center"><b>업 &nbsp;무 &nbsp;내 &nbsp;용</b></td>
                    <td bgcolor="#ECECEC" class="td" >
                        <p align="center"><b>세 &nbsp;부 &nbsp;내 &nbsp;용</b></p>
                    </td>
                    <td bgcolor="#ECECEC" class="td" >
                        <p align="center"><b>지연<br/>주체</b></p>
                    </td>
                    <td bgcolor="#ECECEC" class="td" >
                        <p align="center"><b>지연<br/>일수</b></p>
                    </td>
                </tr>
                
				<tbody id="print9_Ctrl">
					<c:forEach items="${print_9_ctrl}" var="printCtrlVo" varStatus="printCtrlStatus">
						<tr id='printCtrlTr${printCtrlStatus.index}'>
							<td class='td' style="word-break:break-all;">
								<p align='center'>
									<span class="printCtrlSpan" id="printCtrlDateSpan${printCtrlStatus.index}">${printCtrlVo.controlEndDate}</span>
								</p>
							</td>
							<td class='td' style="word-break:break-all;">
                            	<p align='center'>
                                	<span class="printCtrlSpan" id="printCtrlDateCntSpan${printCtrlStatus.index}">${printCtrlVo.controlDateCnt} 일</span>
								</p>
							</td>
							<td class='td' style="word-break:break-all;">
								<p align='center'>
									<span class="printCtrlSpan" id="printCtrlSubjectSpan${printCtrlStatus.index}">${printCtrlVo.controlSubject}</span>
								</p>
							</td>
							<td class='td' style="word-break:break-all;">
								<p align='center'>
									<span class="printCtrlSpan" id="printCtrlMemoSpan${printCtrlStatus.index}" >${printCtrlVo.controlMemo}</span>
								</p>
							</td>
                            <td class='td' style="word-break:break-all;">
                            	<p align='center'>
                                	<span class="printCtrlSpan" id="printCtrlDateCntSpan${printCtrlStatus.index}">
                        				<c:choose>
											<c:when test="${printCtrlVo.controlDelayAgent eq '1'}">보험사</c:when>
											<c:when test="${printCtrlVo.controlDelayAgent eq '2'}">수익자</c:when>
											<c:when test="${printCtrlVo.controlDelayAgent eq '3'}">계약자</c:when>
											<c:when test="${printCtrlVo.controlDelayAgent eq '4'}">피보험자</c:when>
										</c:choose>
                                   	</span>
								</p>
							</td>
                            <td class='td' style="word-break:break-all;">
	                        	<p align='center'>
                                	<span class="printCtrlSpan" id="printCtrlDateCntSpan${printCtrlStatus.index}">
                                    	${printCtrlVo.controlDelayCnt} 일
                                   	</span>
								</p>
							</td>
						</tr>
					</c:forEach>
				</tbody>
                <tr>
                    <td colspan="4" align="center" class='td' bgcolor="#ECECEC">
                        <span style="color: red;">총지연일수</span>
                    </td>
                    <td colspan="2" align="center" class='td'>
                    	${print_9_ctrl_delay_cnt.allDelayCnt} 일
                   	</td>
                </tr>
                <tr>
                    <td colspan="4" align="center" class='td' bgcolor="#ECECEC">
                        <span style="color: red;">계약자, 피보험자, 수익자의 책임있는 사유 조사 지연일수</span>
                    </td>
                    <td colspan="2" align="center" class='td'>
                    	${print_9_ctrl_delay_cnt.notInsuDelayCnt} 일
                   	</td>
                </tr>
                <tr>
                    <td colspan="4" align="center" class='td' style="background-color: yellow;">
                        <span style="color: red;">보험사 지연일수</span>
                    </td>
                    <td colspan="2" align="center" class='td'>
                    	${print_9_ctrl_delay_cnt.insuDelayCnt} 일
                   	</td>
                </tr>
			</table>
			
			<!-- //사고처리 과정표-->
			<p>&nbsp;</p>
			<!-- 8.첨부파일 목록 -->
			<table align="center" cellpadding="0" cellspacing="0" width="640">
				<tr>
					<td height="25" width="50%">
						<p class="p2">
							<b>3. 첨부서류 
							</b>
						</p>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" align="center" width="640">
				<tr>
					<td bgcolor="#ECECEC" class="td" width="30" >
						<p align="center"><b>순번</b></p>
					</td>
					<td class="td" bgcolor="#ECECEC" width="270">
						<p align="center"><b>첨부자료</b></p>
					</td>
					<td class="td" bgcolor="#ECECEC" width="40" >
						<p align="center"><b>부수</b></p>
					</td>
					<td class="td" bgcolor="#ECECEC" width="160" >
						<p align="center"><b>비고</b></p>
					</td>
				</tr>
			<!-- </table>
			<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="661"> -->
				<tbody id = "Print9_fileList">
					<c:forEach items="${suimRptBody9_fileList }" var="suimRptBody9_fileVo">
						<tr id = "Print9_fileListTr_${suimRptBody9_fileVo.serialNo}">
							<td align="center" class="td">
								<span >${suimRptBody9_fileVo.ROWNUM}</span>
							</td>
							<td class="td"  >
								<span >${suimRptBody9_fileVo.attachName}</span>
							</td>
							<td class="td" align="center" >
								<span >${suimRptBody9_fileVo.attachCopy}</span>
							</td>
							<td class="td"  >
								<span >${suimRptBody9_fileVo.attachEtcMemo}</span>
							</td>
						</tr>					
					</c:forEach>
				</tbody>
			</table>
			<p>&nbsp;</p>
			<!-- //8.첨부파일 목록-->
			
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
