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
	<table id = "rptBody6Table" align="center"  width="648">
		<tr>
			<td>
				<p align="center"><img src="https://www.toplac.co.kr/resources/ls_img/ls_body/print_head.jpg" width="640" height="56" border="0"></p>
				<p align="center" style="line-height:50%; margin-top:0; margin-bottom:0;">&nbsp;</p>
				<p align="center"><span style="font-size:9pt;">${tmInforForBody.team_addr}</span></p> 
				<p align="center"><span style="font-size:9pt;">전화 : ${tmInforForBody.team_interphone} &nbsp;팩스 : ${tmInforForBody.team_fax} &nbsp;이메일 : ${mbrVoForBody.email}</span></p>
				<hr size="1" width="640" noshade color="black">
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<table  width="648" align="center">
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
							<p>증 권 번 호</p>
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
				
				<table width="640">
	                <!-- <tr>
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
	                -->
	                <%-- 담당 손해사정사 정보로 변경 시작 --%>               	               	               	
					<c:forEach items="${certiManager4ReportUser}" var="certiUserVo">
						<c:if test="${certiUserVo.certi_state_val eq '손해사정사'}">					
							<tr>
			                    <td height="50" width="500">
			                        <p>&nbsp;</p>
			                        <p>&nbsp;</p>
			                        <p style="text-align:right;padding-right:16px;">${certiUserVo.certi_state_val}</p>
			                    </td>
			                    <td width="65">
			                        <p>&nbsp;</p>
			                        <p>&nbsp;</p>
			                        <p>&nbsp;: ${certiUserVo.user_name}</p>
			                    </td>
			                    <td width="75" rowspan="2">
			                        <p>
			                        	<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${certiUserVo.user_no}/${certiUserVo.user_sign}" width="50" height="50">		                        	
			                        </p>
			                    </td>
			                </tr>
			                <tr>
			                    <td width="565" colspan="2">
			                        <p align="right"><c:if test='${certiUserVo.work_phone != ""}'>${certiUserVo.work_phone} </c:if></p>
			                    </td>
			                </tr>
		                </c:if>						
					</c:forEach>
					<%-- 담당 손해사정사 정보로 변경 끝 --%>	                
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
	                    <td colspan="3" height="180" valign="bottom" width="640">
							<p align="center">
								<img src="https://www.toplac.co.kr/resources/ne_img/sign_salary.jpg" />
<!-- 								<img src="https://www.toplac.co.kr/resources/ls_img/report/sign_report.jpg" width="300" height="80" border="0"> -->
							</p>
							<H2 CLASS="breakhere"></h2>
						</td>
	                </tr>
	            </table>
		            
				<p>&nbsp;</p>
				
				<table align="center"  width="640">
					<tr>
						<td height="25" width="50%">
							<p class="p2">
								<b>1. 계약사항 </b>
							</p>
						</td>
					</tr>
				</table>
				
				<table  align="center" width="640">
					<tr>
						<td bgcolor="#ECECEC" class="td" width="140">
							<p align="center"><b>구분</b></p>
						</td>
						<td colspan="4" class="td" bgcolor="#ECECEC" width="500">
							<p align="center"><b>내용</b></p>
						</td>
					</tr>
					<tr>
						<td class="td" bgcolor="#ECECEC">
							<p align="center" ><b>보험종목</b></p>
						</td>
						<td colspan="4" class="td">
							<p>
								<span id="print17insuranceNm">${suimVO.insurance_nm }</span>
							</p>
						</td>
					</tr>
					<tr>
						<td class="td" bgcolor="#ECECEC">
							<p align="center"><b>계약기간</b></p>
						</td>
						<td colspan="4" class="td">
							<p>
								<span class= "print17_1SpanClass" id="contractPeriod1Span">${suimRptBody17_1356891112Vo.contractPeriod1Span }</span>
							</p>
						</td>
					</tr>
					<tr>
						<td class="td" bgcolor="#ECECEC">
							<p align="center"><b>증권번호</b></p>
						</td>
						<td colspan="4" class="td">
							<p>
								<span id="print17PolicyNo">${suimVO.policy_no }</span>
							</p>
						</td>
					</tr>
					<tr>
	                    <td class="td" bgcolor="#ECECEC">
							<p align="center"><b>계약자/피보험자/수익자</b></p>
	                    </td>
	                    <td colspan="4" class="td">
	                        <p >
	                        		<c:choose>
		                        		<c:when test="${suimVO.policyholder_nm ne ''}">
			                        		${suimVO.policyholder_nm } 	                        		
		                        		</c:when>	                       
		                        		<c:otherwise>
		                        			-
		                        		</c:otherwise> 		
	                        		</c:choose>
	                        		/ 
	                        		<c:choose>
		                        		<c:when test="${suimVO.beneficiary_nm ne ''}">
			                        		${suimVO.beneficiary_nm } 	                        		
		                        		</c:when>	                       
		                        		<c:otherwise>
		                        			-
		                        		</c:otherwise> 		
	                        		</c:choose> 
	                        		/ 
	                        		<c:choose>
		                        		<c:when test="${suimRptBody17_1356891112Vo.beneficiaryDtl1 ne ''}">
			                        		<span class= "print17_1SpanClass" id = "beneficiaryDtl1Span">${suimRptBody17_1356891112Vo.beneficiaryDtl1 }</span>
		                        		</c:when>	                       
		                        		<c:otherwise>
		                        			<span class= "print17_1SpanClass" id = "beneficiaryDtl1Span">-</span>
		                        		</c:otherwise> 		
	                        		</c:choose> 
	                        </p>
	                    </td>
					</tr>
					<tr>
	                    <td class="td" bgcolor="#ECECEC">
							<p align="center"><b>피보험자 청약시 직무</b></p>
	                    </td>
	                    <td colspan="4" class="td">
	                        <p >
	                        	<span class= "print17_1SpanClass" id="jobJoin1Span">${suimRptBody17_1356891112Vo.jobJoin1}</span>
	                        </p>
	                    </td>
					</tr>
					<tr>
	                    <td class="td" bgcolor="#ECECEC">
							<p align="center"><b>현재 직무</b></p>
	                    </td>
	                    <td colspan="4" class="td">
	                        <p >
	                        	<span class= "print17_1SpanClass" id="jobPresent1Span">${suimRptBody17_1356891112Vo.jobPresent1}</span>
	                        </p>
	                    </td>
					</tr>
					<tr>
	                    <td class="td" bgcolor="#ECECEC">
							<p align="center"><b>청구 담보</b></p>
	                    </td>
	                    <td colspan="4" class="td">
	                        <p >
	                        	<span class= "print17_1SpanClass" id="mortgageDtl1Span">${suimRptBody17_1356891112Vo.mortgageDtl1Span }</span>
	                        </p>
	                    </td>
					</tr>
					<tr>
	                    <td class="td" bgcolor="#ECECEC">
							<p align="center"><b>가입금액</b></p>
	                    </td>
	                    <td colspan="4" class="td" >
	                        <p >
	                        	<span class= "print17_1SpanClass" id="amtTotInsu1Span">${suimRptBody17_1356891112Vo.amtTotInsu1Span}</span>
	                        </p>
	                    </td>
					</tr>
					<tr>
	                    <td class="td" bgcolor="#ECECEC">
							<p align="center"><b>비고</b></p>
	                    </td>
	                    <td colspan="4" class="td">
	                        <p >
	                        	<span class= "print17_1SpanClass" id="etc1Span">${suimRptBody17_1356891112Vo.etc1Span}</span>
	                        </p>
	                    </td>
					</tr>
				</table>
				<p>&nbsp;</p>
				<c:if test="${suimRptBody17_1356891112Vo.chungguTypeCode ne 0 }">
					<table align="center"  width="640">
						<tr>
							<td height="25" >
								<p class="p2">
									<b>2. 청구내용
										<!-- <img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print17_2ShowHideBtnId" style="display:none; cursor:pointer; "  /> -->
									</b>
								</p>
							</td>
						</tr>
					</table>
					<table   align="center" width="640" > 
						<tr>
							<td bgcolor="#ECECEC" class="td" width="140" style="border-bottom:0px;">
								<p align="center"><b>구      분</b></p>
							</td>
							<td colspan="3" class="td" bgcolor="#ECECEC" width="500" style="border-bottom:0px;">
								<p align="center"><b>내           용</b></p>
							</td>
						</tr>
					</table>
					<!-- 과거력 시작 -->
					<c:if test="${suimRptBody17_1356891112Vo.chungguTypeCode eq 1 }">
						<table cellpadding="0" width="640" cellspacing="0"  align="center" id = "print17_2aTable" >
							<tr>
								<td class="td" bgcolor="#ECECEC" width="140" >
								 	 <p align="center"><b>청구병명</b></p>
					              </td>
					              <td class="td" width="500" >
					                 <p >
					                  	<span class= "print17_2aSpanClass" id="chungguDtl1aSpan">${suimRptBody17_2Vo.chungguDtl1Span }</span>
					             	 </p>
					          	</td>
							</tr>
							<tr>
								<td class="td" bgcolor="#ECECEC" width="140" >
								 	 <p align="center"><b>병원초진일/초진병원</b></p>
					              </td>
					              <td class="td" width="500" >
					                 <p >
					                  	<span class= "print17_2aSpanClass" id="chungguDtl2aSpan">${suimRptBody17_2Vo.chungguDtl2Span }</span>
					             	 </p>
					          	</td>
							</tr>
							<tr>
								<td class="td" bgcolor="#ECECEC" width="140" >
								 	 <p align="center"><b>초진병원차트상 내원경위</b></p>
					              </td>
					              <td class="td" width="500" >
					                 <p >
					                  	<span class= "print17_2aSpanClass" id="chungguDtl3aSpan">${suimRptBody17_2Vo.chungguDtl3Span }</span>
					             	 </p>
					          	</td>
							</tr>
							<tr>
								<td class="td" bgcolor="#ECECEC" width="140" >
								 	 <p align="center"><b>진단병원/의사</b></p>
					              </td>
					              <td class="td" width="500" >
					                 <p >
					                  	<span class= "print17_2aSpanClass" id="chungguDtl4aSpan">${suimRptBody17_2Vo.chungguDtl4Span }</span>
					             	 </p>
					          	</td>
							</tr>
							<tr>
								<td class="td" bgcolor="#ECECEC" width="140" >
								 	 <p align="center"><b>검사명</b></p>
					              </td>
					              <td class="td" width="500" >
					                 <p >
					                  	<span class= "print17_2aSpanClass" id="chungguDtl5aSpan">${suimRptBody17_2Vo.chungguDtl5Span }</span>
					             	 </p>
					          	</td>
							</tr>
							<tr>
								<td class="td" bgcolor="#ECECEC" width="140" >
								 	 <p align="center"><b>수술명/수술일</b></p>
					              </td>
					              <td class="td" width="500" >
					                 <p >
					                  	<span class= "print17_2aSpanClass" id="chungguDtl6aSpan">${suimRptBody17_2Vo.chungguDtl6Span }</span>
					             	 </p>
					          	</td>
							</tr>
							<tr>
								<td class="td" bgcolor="#ECECEC" width="140" >
								 	 <p align="center"><b>특이사항</b></p>
					              </td>
					              <td class="td" width="500">
					                 <p >
					                  	<span class= "print17_2aSpanClass" id="chungguDtl7aSpan">${suimRptBody17_2Vo.chungguDtl7Span }</span>
					             	 </p>
					          	</td>
							</tr>
						</table>
					</c:if>
					<!-- 과거력 끝 -->
					
					<!-- 2대질병 시작 -->
					<c:if test="${suimRptBody17_1356891112Vo.chungguTypeCode eq 2 }">
					<table cellpadding="0" width="640" cellspacing="0"  align="center" id = "print17_2bTable" >
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>청구병명</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2bSpanClass" id="chungguDtl1bSpan">${suimRptBody17_2Vo.chungguDtl1Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>병원초진일/초진병원</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2bSpanClass" id="chungguDtl2bSpan">${suimRptBody17_2Vo.chungguDtl2Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>초진병원차트상 내원경위</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2bSpanClass" id="chungguDtl3bSpan">${suimRptBody17_2Vo.chungguDtl3Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>진단병원/의사</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2bSpanClass" id="chungguDtl4bSpan">${suimRptBody17_2Vo.chungguDtl4Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>각종검사내용 및 결과</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2bSpanClass" id="chungguDtl5bSpan">${suimRptBody17_2Vo.chungguDtl5Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>수술명/수술일</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2bSpanClass" id="chungguDtl6bSpan">${suimRptBody17_2Vo.chungguDtl6Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>특이사항</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2bSpanClass" id="chungguDtl7bSpan">${suimRptBody17_2Vo.chungguDtl7Span }</span>
				             	 </p>
				          	</td>
						</tr>
					</table>
					</c:if>
					<!-- 2대질병 끝 -->
					
					<!-- 암 시작 -->
					<c:if test="${suimRptBody17_1356891112Vo.chungguTypeCode eq 3 }">
					<table cellpadding="0" width="640" cellspacing="0"  align="center" id = "print17_2cTable" >
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>청구병명</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2cSpanClass" id="chungguDtl1cSpan">${suimRptBody17_2Vo.chungguDtl1Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>병원초진일/초진병원</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2cSpanClass" id="chungguDtl2cSpan">${suimRptBody17_2Vo.chungguDtl2Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>초진병원차트상 내원경위</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2cSpanClass" id="chungguDtl3cSpan">${suimRptBody17_2Vo.chungguDtl3Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>암진단병원/의사</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2cSpanClass" id="chungguDtl4cSpan">${suimRptBody17_2Vo.chungguDtl4Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>조직검사시행일/보고일</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2cSpanClass" id="chungguDtl5cSpan">${suimRptBody17_2Vo.chungguDtl5Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>수술명/수술일</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2cSpanClass" id="chungguDtl6cSpan">${suimRptBody17_2Vo.chungguDtl6Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>특이사항</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2cSpanClass" id="chungguDtl7cSpan">${suimRptBody17_2Vo.chungguDtl7Span }</span>
				             	 </p>
				          	</td>
						</tr>
					</table>
					</c:if>
					<!-- 암 끝 -->
					
					<!-- 상해사망 시작 -->
					<c:if test="${suimRptBody17_1356891112Vo.chungguTypeCode eq 4 }">
					<table cellpadding="0" width="640" cellspacing="0"  align="center" id = "print17_2dTable" >
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>사고일시</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2dSpanClass" id="chungguDtl1dSpan">${suimRptBody17_2Vo.chungguDtl1Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>사고경위</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2dSpanClass" id="chungguDtl2dSpan">${suimRptBody17_2Vo.chungguDtl2Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>사고장소</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2dSpanClass" id="chungguDtl3dSpan">${suimRptBody17_2Vo.chungguDtl3Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>사고현장사진</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2dSpanClass" id="chungguDtl4dSpan">${suimRptBody17_2Vo.chungguDtl4Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>목격자여부</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2dSpanClass" id="chungguDtl5dSpan">${suimRptBody17_2Vo.chungguDtl5Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>병원초진일</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2dSpanClass" id="chungguDtl6dSpan">${suimRptBody17_2Vo.chungguDtl6Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>초진병원 차트 상 내원경위</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2dSpanClass" id="chungguDtl7dSpan">${suimRptBody17_2Vo.chungguDtl7Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>직접사인/간접사인</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2dSpanClass" id="chungguDtl8dSpan">${suimRptBody17_2Vo.chungguDtl8Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>진단병원/의사</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2dSpanClass" id="chungguDtl9dSpan">${suimRptBody17_2Vo.chungguDtl9Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>보검시행여부</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2dSpanClass" id="chungguDtl10dSpan">${suimRptBody17_2Vo.chungguDtl10Span }</span>
				             	 </p>
				          	</td>
						</tr>
					</table>
					</c:if>
					<!-- 상해사망 끝 -->
					
					<!-- 일당/간병비 시작 -->
					<c:if test="${suimRptBody17_1356891112Vo.chungguTypeCode eq 5 }">
					<table cellpadding="0" width="640" cellspacing="0"  align="center" id = "print17_2eTable" >
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>사고일시</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2eSpanClass" id="chungguDtl1eSpan">${suimRptBody17_2Vo.chungguDtl1Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>사고경위</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2eSpanClass" id="chungguDtl2eSpan">${suimRptBody17_2Vo.chungguDtl2Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>사고장소</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2eSpanClass" id="chungguDtl3eSpan">${suimRptBody17_2Vo.chungguDtl3Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>사고현장사진</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2eSpanClass" id="chungguDtl4eSpan">${suimRptBody17_2Vo.chungguDtl4Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>목격자여부</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2eSpanClass" id="chungguDtl5eSpan">${suimRptBody17_2Vo.chungguDtl5Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>병원초진일</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2eSpanClass" id="chungguDtl6eSpan">${suimRptBody17_2Vo.chungguDtl6Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>초진병원차트상 내원경위</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2eSpanClass" id="chungguDtl7eSpan">${suimRptBody17_2Vo.chungguDtl7Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>주치료 내용</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2eSpanClass" id="chungguDtl8eSpan">${suimRptBody17_2Vo.chungguDtl8Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>검사명/검사결과</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2eSpanClass" id="chungguDtl9eSpan">${suimRptBody17_2Vo.chungguDtl9Span }</span>
				             	 </p>
				          	</td>
						</tr>
					</table>
					</c:if>
					<!-- 일당/간병비 끝 -->
					
					<!-- 후유장해 시작 -->
					<c:if test="${suimRptBody17_1356891112Vo.chungguTypeCode eq 6 }">
					<table cellpadding="0" width="640" cellspacing="0"  align="center" id = "print17_2fTable" >
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>사고일시</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2fSpanClass" id="chungguDtl1fSpan">${suimRptBody17_2Vo.chungguDtl1Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>사고경위</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2fSpanClass" id="chungguDtl2fSpan">${suimRptBody17_2Vo.chungguDtl2Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>사고장소</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2fSpanClass" id="chungguDtl3fSpan">${suimRptBody17_2Vo.chungguDtl3Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>사고현장사진</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2fSpanClass" id="chungguDtl4fSpan">${suimRptBody17_2Vo.chungguDtl4Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>목격자여부</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2fSpanClass" id="chungguDtl5fSpan">${suimRptBody17_2Vo.chungguDtl5Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>병원초진일</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2fSpanClass" id="chungguDtl6fSpan">${suimRptBody17_2Vo.chungguDtl6Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>초진병원 차트 상 내원경위</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2fSpanClass" id="chungguDtl7fSpan">${suimRptBody17_2Vo.chungguDtl7Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>후유장해항목/장해율</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2fSpanClass" id="chungguDtl8fSpan">${suimRptBody17_2Vo.chungguDtl8Span }</span>
				             	 </p>
				          	</td>
						</tr>
						<tr>
							<td class="td" bgcolor="#ECECEC" width="140" >
							 	 <p align="center"><b>장해진단병원/의사</b></p>
				              </td>
				              <td class="td" width="500" >
				                 <p >
				                  	<span class= "print17_2fSpanClass" id="chungguDtl9fSpan">${suimRptBody17_2Vo.chungguDtl9Span }</span>
				             	 </p>
				          	</td>
						</tr>
					</table>
					<p>&nbsp;</p>
					</c:if>
					<!-- 후유장애 끝 -->
					<div>
					<p>&nbsp;</p>
					<!-- 피보험자 면담내용 시작 -->
					<table align="center"  width="640">
			             <tr>
			                <td height="25" >
								<p class="p2"><B>3. 피보험자 면담내용</B></p>
			                </td>
			             </tr>
			        </table>
			        <table  align="center" width="640">
			           	<tr>
			                <td align="center" bgcolor="#ECECEC" class="td" width="140">
								<p align="center"><B>구 &nbsp;분</B></p>
			                </td>
			                <td class="td" bgcolor="#ECECEC" width="500">
								<p align="center"><B>내 &nbsp;용</B></p>
			                </td>
						</tr>
			            <tr>
			                <td align="center" class="td" width="140" bgcolor="#ECECEC">
			                    <p><b>면담일시</b></p>
			                </td>
			                <td class="td" width="500">
			                    <p>
			                    	<span class= "print17_3SpanClass" id="faceDate3Span">${suimRptBody17_1356891112Vo.faceDate3Span }</span>
			                    </p>
			                </td>
			            </tr>
			            <tr>
			                <td align="center" class="td" width="140" bgcolor="#ECECEC">
			                    <p><b>면담장소/면담내용</b></p>
			                </td>
			                <td class="td" width="500">
			                    <p>
			                    	<span class= "print17_3SpanClass" id="faceDtl3Span">${suimRptBody17_1356891112Vo.faceDtl3Span }</span>
			                    </p>
			                </td>
			            </tr>
			            <tr>
			                <td align="center" class="td" nowrap width="140" bgcolor="#ECECEC">
			                    <p><b>징구서류</b></p>
			                </td>
			                <td class="td" width="500">
			                    <p>
			                    	<span class= "print17_3SpanClass" id="moreDocument3Span">${suimRptBody17_1356891112Vo.moreDocument3Span }</span>
			                    </p>
			                </td>
						</tr>
			        </table>
					<!-- 피보험자 면담내용 끝 -->
					</div>
					<!-- 타보험가입내역 시작 -->
					<p>&nbsp;</p>
					<div>
					<table align="center"  width="640">
						<tr>
							<td height="25" >
								<p  class="p2"><b>4. 타 보험 가입내역</b></p>
							</td>
						</tr>
					</table>
					<table   align="center" width="640">
						<tr>
							<td bgcolor="#ECECEC" class="td" width="130">
								<p align="center"><b>보험사명</b></p>
							</td>
							<td class="td" bgcolor="#ECECEC" width="130">
								<p align="center"><b>가입일시</b></p>
							</td>
							<td class="td" bgcolor="#ECECEC" width="130">
								<p align="center"><b>가입금액</b></p>
							</td>
							<td class="td" bgcolor="#ECECEC" width="150">
								<p align="center"><b>보험료</b></p>
							</td>
							<td class="td" bgcolor="#ECECEC" width="100">
								<p align="center"><b>모집인</b></p>
							</td>
						</tr>
						
						<tbody id = "print17_4List">
							<c:forEach items="${suimRptBody17_4List }" var="suimRptBody17_4Vo">
								<tr id = "print17_4ListTr_${suimRptBody17_4Vo.serialNo}">
									<td align="center" class="td" id = "otherInsuComTd_${suimRptBody17_4Vo.serialNo}">
										<span id = "otherInsuComForSpan_${suimRptBody17_4Vo.serialNo}">${suimRptBody17_4Vo.otherInsuCom}</span>
									</td>
									<td class="td" id = "otherInsuJoinDateTd_${suimRptBody17_4Vo.serialNo}">
										<span id = "otherInsuJoinDateForSpan_${suimRptBody17_4Vo.serialNo}">${suimRptBody17_4Vo.otherInsuJoinDate}</span>
									</td>
									<td class="td">
										<span id = "otherInsuJoinAmtForSpan_${suimRptBody17_4Vo.serialNo}">${suimRptBody17_4Vo.otherInsuJoinAmt}</span>
									</td>
									<td class="td">
										<span id = "otherInsuPremiumForSpan_${suimRptBody17_4Vo.serialNo}">${suimRptBody17_4Vo.otherInsuPremium}</span>
									</td>
									<td class="td">
										<span id = "otherInsuAgentForSpan_${suimRptBody17_4Vo.serialNo}">${suimRptBody17_4Vo.otherInsuAgent}</span>
									</td>
								</tr>					
							</c:forEach>
						</tbody>
					</table>
					</div>
					<p>&nbsp;</p>
					<div id = "recordForPrint17DivId" style="display:none;">
						<!-- 형사기록 -->
						<table align="center"  width="640">
				           <tr>
					           <td height="25" width="50%">
									<p class="p2"><B>5. 형사기록</B></p>
					           </td>
					       </tr>
					    </table>
					<table  align="center" width="640">
						<tr>
					       <td bgcolor="#ECECEC" class="td" width="155">
								<p align="center"><B>관공서명</B></p>
					       </td>
					       <td bgcolor="#ECECEC" class="td" width="155">
					            <p align="center"><B>문서명</B></p>
					       </td>
					       <td bgcolor="#ECECEC" class="td" width="155">
					            <p align="center"><B>내용</B></p>
					       </td>
					       <td class="td" bgcolor="#ECECEC" width="155">
								<p align="center"><B>비고</B></p>
					       </td>
						</tr>
						<tr>
						    <td class="td" width="155">
								<p>
									<span class= "print17_5SpanClass" id="recordPublic5Span">${suimRptBody17_1356891112Vo.recordPublic5Span }</span>
					            </p>
						    </td>
						    <td class="td" width="155">
								<p>
									<span class= "print17_5SpanClass" id="recordDocNm5Span">${suimRptBody17_1356891112Vo.recordDocNm5Span }</span>
					            </p>
						    </td>
						    <td class="td" width="155">
								<p>
									<span class= "print17_5SpanClass" id="recordDtl5Span">${suimRptBody17_1356891112Vo.recordDtl5Span }</span>
					            </p>
						    </td>
						    <td class="td" width="155">
								<p>
									<span class= "print17_5SpanClass" id="recordEtc5Span">${suimRptBody17_1356891112Vo.recordEtc5Span }</span>
					            </p>
						    </td>
						</tr>
					</table>
						<!-- //형사기록 -->
				</div>
				<p>&nbsp;</p>
				<!-- 면부책여부 -->
				<div>
				<table align="center"  width="640">
		           <tr>
			           <td height="25" >
							<p class="p2"><B>6.
								<c:choose>
									<c:when test="">
										사실관계확인결과
									</c:when>
									<c:otherwise>
										면부책여부
									</c:otherwise>
								</c:choose>
							
							</B></p>
			           </td>
			       </tr>
			    </table>
				<table  align="center" width="640">
					<tr>
				       <td bgcolor="#ECECEC" class="td" width="210">
							<p align="center"><B>관공서명</B></p>
				       </td>
				       <td bgcolor="#ECECEC" class="td" width="220">
				            <p align="center"><B>문서명</B></p>
				       </td>
				       <td class="td" bgcolor="#ECECEC" width="210">
							<p align="center"><B>비고</B></p>
				       </td>
					</tr>
					<tr>
					    <td class="td" width="210">
							<p>
								<span class= "print17_6SpanClass" id="exemptionBasis6Span">${suimRptBody17_1356891112Vo.exemptionBasis6Span }</span>
				            </p>
					    </td>
					    <td class="td" width="220">
							<p>
								<span class= "print17_6SpanClass" id="exemptionDtl6Span">${suimRptBody17_1356891112Vo.exemptionDtl6Span }</span>
				            </p>
					    </td>
					    <td class="td" width="210">
							<p>
								<span class= "print17_6SpanClass" id="exemptionProve6Span">${suimRptBody17_1356891112Vo.exemptionProve6Span }</span>
				            </p>
					    </td>
					</tr>
				</table>
				<p>&nbsp;</p>
				</div>
				<!-- 치료력 관련 조사내용 -->
				<div>
				<table align="center"  width="640">
					<tr>
						<td height="25" >
							<p  class="p2"><b>7. 치료력 관련 조사내용</b></p>
						</td>
					</tr>
				</table>
				<table   align="center" width="640">
					<tr>
						<td bgcolor="#ECECEC" class="td" width="120">
							<p align="center"><b>치료기간</b></p>
						</td>
						<td class="td" bgcolor="#ECECEC" width="140">
							<p align="center"><b>병원명</b></p>
						</td>
						<td class="td" bgcolor="#ECECEC" width="140">
							<p align="center"><b>진단명</b></p>
						</td>
						<td class="td" bgcolor="#ECECEC" width="120">
							<p align="center"><b>검사명</b></p>
						</td>
						<td class="td" bgcolor="#ECECEC" width="120">
							<p align="center"><b>투약일수</b></p>
						</td>
					</tr>
					
					<tbody id = "print17_7List">
						<c:forEach items="${suimRptBody17_7List }" var="suimRptBody17_7Vo">
							<tr id = "print17_7ListTr_${suimRptBody17_7Vo.serialNo}">
								<td align="center" class="td" >
									<span class="medicalSpanClass" id = "medicalHistoryPeriodForSpan_${suimRptBody17_7Vo.serialNo}">${suimRptBody17_7Vo.medicalHistoryPeriodSpan}</span>
								</td>
								<td class="td" >
									<span class="medicalSpanClass" id = "medicalHistoryHospitalForSpan_${suimRptBody17_7Vo.serialNo}">${suimRptBody17_7Vo.medicalHistoryHospitalSpan}</span>
								</td>
								<td class="td">
									<span class="medicalSpanClass" id = "medicalHistoryDiagnosisForSpan_${suimRptBody17_7Vo.serialNo}">${suimRptBody17_7Vo.medicalHistoryDiagnosisSpan}</span>
								</td>
								<td class="td">
									<span class="medicalSpanClass"id = "medicalHistoryTestForSpan_${suimRptBody17_7Vo.serialNo}">${suimRptBody17_7Vo.medicalHistoryTestSpan}</span>
								</td>
								<td class="td">
									<span class="medicalSpanClass" id = "medicalHistoryMedicineForSpan_${suimRptBody17_7Vo.serialNo}">${suimRptBody17_7Vo.medicalHistoryMedicineSpan}</span>
								</td>
							</tr>					
						</c:forEach>
					</tbody>
				</table>
				<p>&nbsp;</p>
				</div>
				<div>
				<!-- 계약체결 경위 -->
				<table align="center"  width="640">
		           <tr>
			           <td height="25" >
							<p class="p2"><B>8. 계약체결경위
							
							</B></p>
			           </td>
			       </tr>
			    </table>
				<table  align="center" width="640">
					<tr>
				       <td bgcolor="#ECECEC" class="td" width="180">
							<p align="center"><B>모집인명</B></p>
				       </td>
				       <td bgcolor="#ECECEC" class="td" width="290">
				            <p align="center"><B>계약자/피보험자 와의 관계</B></p>
				       </td>
				       <td class="td" bgcolor="#ECECEC" width="170">
							<p align="center"><B>근거자료</B></p>
				       </td>
					</tr>
					<tr>
					    <td class="td" width="180">
							<p>
								<span class= "print17_8SpanClass" id="contractAgent8Span">${suimRptBody17_1356891112Vo.contractAgent8Span }</span>
				            </p>
					    </td>
					    <td class="td" width="290">
							<p>
								<span class= "print17_8SpanClass" id="contractRelation8Span">${suimRptBody17_1356891112Vo.contractRelation8Span }</span>
				            </p>
					    </td>
					    <td class="td" width="170">
							<p>
								<span class= "print17_8SpanClass" id="contractSituation8Span">${suimRptBody17_1356891112Vo.contractSituation8Span }</span>
				            </p>
					    </td>
					</tr>
				</table>
				<p>&nbsp;</p>
				</div>
				<!-- 조사결과 요약 -->
				<div>
				<table align="center"  width="640">
		           <tr>
			           <td height="25" >
							<p class="p2"><B>9. 
							<c:choose>
								<c:when test="${suimRptBody17_1356891112Vo.chungguTypeCode eq 0}">
									<span id = "print17ContractTitle">계약자 및 피보험자 주장</span>
								</c:when>
								<c:otherwise>
									<span id = "print17ContractTitle">조사결과요약</span>					
								</c:otherwise>
							</c:choose>
							
							</B></p>
			           </td>
			       </tr>
			    </table>
				<table  align="center" width="640">
					<tr>
				       <td bgcolor="#ECECEC" class="td" width="180">
							<p align="center"><B>조사결과</B></p>
				       </td>
				       <td bgcolor="#ECECEC" class="td" width="290">
				            <p align="center"><B>계약자/피보험자 주장</B></p>
				       </td>
				       <td class="td" bgcolor="#ECECEC" width="170">
							<p align="center"><B>근거자료</B></p>
				       </td>
					</tr>
					<tr>
					    <td class="td" width="180">
							<p>
								<span class= "print17_9SpanClass" id="inspectResult9Span">${suimRptBody17_1356891112Vo.inspectResult9Span }</span>
				            </p>
					    </td>
					    <td class="td" width="290">
							<p>
								<span class= "print17_9SpanClass" id="inspectInsist9Span">${suimRptBody17_1356891112Vo.inspectInsist9Span }</span>
				            </p>
					    </td>
					    <td class="td" width="170">
							<p>
								<span class= "print17_9SpanClass" id="inspectBasis9Span">${suimRptBody17_1356891112Vo.inspectBasis9Span }</span>
				            </p>
					    </td>
					</tr>
				</table>
				</div>
				<p>&nbsp;</p>
				<!-- 사고처리 과정표 시작-->
				<div>
				
				<table cellSpacing=0 cellPadding="0" width="635" align="center" >
					<tr>
						<td colspan="3"><p class="p2"><B>10. 사고처리 과정표</B></p></td>
					</tr>
					<tr>
						<td bgcolor="#ECECEC" class="td" width="200">
							<p align="center"><b>일 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자</b></td>
						<td bgcolor="#ECECEC" class="td" width="204">
							<p align="center"><b>항 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</b></td>
						<td bgcolor="#ECECEC" class="td" width="215">
							<p align="center"><b>처 &nbsp;리 &nbsp;내 &nbsp;용</b></p>
						</td>
					</tr>
					<tbody id="print17_Ctrl">
					<c:forEach items="${sagoList }" var="sagoVo">
						<tr id = "print17_Ctrl_${sagoVo.sagoNo }">
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
				</div>
				<p>&nbsp;</p>
				
				<!-- 사고처리 과정표 끝 -->
				<div>
				<table align="center"  width="640">
		           <tr>
			           <td height="25" width="50%">
							<p class="p2"><B>11. 현장조사결과 체크리스트</B></p>
			           </td>
			       </tr>
			    </table>
				<table  align="center" width="640">
					<tr>
				       <td bgcolor="#ECECEC" class="td" width="225">
							<p align="center"><B>항목</B></p>
				       </td>
				       <td class="td" bgcolor="#ECECEC" width="240">
							<p align="center"><B>확인사항</B></p>
				       </td>
					</tr>
					<tr>
					    <td class="td" >
							<p>
								약관전달 여부
				            </p>
					    </td>
					    <td class="td" >
							<p>
								적정
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkTerms11 eq 1}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
								/우편
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkTerms11 eq 2}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
								/확인안됨
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkTerms11 eq 3}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
				            </p>
					    </td>
					</tr>
					<tr>
					    <td class="td">
							<p>
								상품판매시 면책약관 설명방법
				            </p>
					    </td>
					    <td class="td">
							<p>
								면담
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkExplain11 eq 1}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
								/유선
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkExplain11 eq 2}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
								/인터넷
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkExplain11 eq 3}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
				            </p>
					    </td>
					</tr>
					<tr>
					    <td class="td">
							<p>
								면책약관 적용의 합리성
				            </p>
					    </td>
					    <td class="td">
							<p>
								적정
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkApply11 eq 1}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
								/보험사 유리
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkApply11 eq 2}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
								/소비자 유리
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkApply11 eq 3}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
				            </p>
					    </td>
					</tr>
					<tr>
					    <td class="td">
							<p>
								면부책 판단 구비서류 적정여부
				            </p>
					    </td>
					    <td class="td">
							<p>
								적정
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkDoc11 eq 1}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
								/일부미흡
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkDoc11 eq 2}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
								/미흡
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkDoc11 eq 3}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
				            </p>
					    </td>
					</tr>
					<tr>
					    <td class="td">
							<p>
								면책약관의 이해도
				            </p>
					    </td>
					    <td class="td">
							<p>
								높음
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkFigure11 eq 1}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
								/보통
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkFigure11 eq 2}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
								/낮음
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkFigure11 eq 3}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
				            </p>
					    </td>
					</tr>
					<tr>
					    <td class="td">
							<p>
								작성자 불이익 원칙 적용
				            </p>
					    </td>
					    <td class="td">
							<p>
								적용대상
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkDis11 eq 1}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
								/미대상
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkDis11 eq 2}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
				            </p>
					    </td>
					</tr>
					<tr>
					    <td class="td">
							<p>
								상반되는 판례
				            </p>
					    </td>
					    <td class="td">
							<p>
							
								없음
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkPrecedent11 eq 1}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
								/일부상반
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkPrecedent11 eq 2}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
								/있음
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkPrecedent11 eq 3}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
				            </p>
					    </td>
					</tr>
					<tr>
					    <td class="td">
							<p>
								재검토 가능요소
				            </p>
					    </td>
					    <td class="td">
							<p>
							
								있음
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkReYn11 eq 1}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
								/없음
								<c:choose>
									<c:when test="${suimRptBody17_1356891112Vo.checkReYn11 eq 2}">
										●
									</c:when>
									<c:otherwise>
										○
									</c:otherwise>
								</c:choose>
				            </p>
					    </td>
					</tr>
				</table>
				</div>
				<p>&nbsp;</p>
				<div>
				<table align="center"  width="640">
			           <tr>
				           <td height="25" width="50%">
								<p class="p2"><B>12. 제3자 개입여부
								
								</B></p>
				           </td>
				           <td height="25" width="50%">
				           </td>
				       </tr>
				    </table>
				<table  align="center" width="640">
					<tr>
				       <td bgcolor="#ECECEC" class="td" width="156">
							<p align="center"><B>제3자명</B></p>
				       </td>
				       <td bgcolor="#ECECEC" class="td" width="156">
				            <p align="center"><B>위입경위</B></p>
				       </td>
				       <td class="td" bgcolor="#ECECEC" width="156">
							<p align="center"><B>실제 업무처리자</B></p>
				       </td>
				       <td class="td" bgcolor="#ECECEC" width="156">
							<p align="center"><B>전화번호</B></p>
				       </td>
					</tr>
					<tr>
					    <td class="td" width="156">
							<p>
								<span class= "print17_12SpanClass" id="interveneNm12Span">${suimRptBody17_1356891112Vo.interveneNm12Span }</span>
				            </p>
					    </td>
					    <td class="td" width="156">
							<p>
								<span class= "print17_12SpanClass" id="interveneSituation12Span">${suimRptBody17_1356891112Vo.interveneSituation12Span }</span>
				            </p>
					    </td>
					    <td class="td" width="156">
							<p>
								<span class= "print17_12SpanClass" id="interveneStaff12Span">${suimRptBody17_1356891112Vo.interveneStaff12Span }</span>
				            </p>
					    </td>
					    <td class="td" width="156">
							<p>
								<span class= "print17_12SpanClass" id="interveneTel12Span">${suimRptBody17_1356891112Vo.interveneTel12Span }</span>
				            </p>
					    </td>
					</tr>
				</table>
				</div>
				<p>&nbsp;</p>
				<div>
				<table align="center"  width="640">
					<tr>
						<td height="25" width="50%">
							<p  class="p2"><b>13. 탐문내역</b></p>
						</td>
						<td height="25" width="50%">
						</td>
					</tr>
				</table>
				<table   align="center" width="640">
					<tr>
						<td bgcolor="#ECECEC" class="td" width="185">
							<p align="center"><b>탐문기관명</b></p>
						</td>
						<td class="td" bgcolor="#ECECEC" width="130">
							<p align="center"><b>기준</b></p>
						</td>
						<td class="td" bgcolor="#ECECEC" width="190">
							<p align="center"><b>방문여부</b></p>
						</td>
						<td class="td" bgcolor="#ECECEC" width="95">
							<p align="center"><b>비고</b></p>
						</td>
					</tr>
					
					<tbody id = "print17_13List">
						<c:forEach items="${suimRptBody17_13List }" var="suimRptBody17_13Vo">
							<tr id = "print17_13ListTr_${suimRptBody17_13Vo.serialNo}">
								<td align="center" class="td">
									<span id = "questioningHospitalForSpan_${suimRptBody17_13Vo.serialNo}">${suimRptBody17_13Vo.questioningHospital}</span>
								</td>
								<td class="td" >
									<span id = "questioningBasisForSpan_${suimRptBody17_13Vo.serialNo}">${suimRptBody17_13Vo.questioningBasis}</span>
								</td>
								<td class="td">
									<span id = "questioningVisitForSpan_${suimRptBody17_13Vo.serialNo}">${suimRptBody17_13Vo.questioningVisit}</span>
								</td>
								<td class="td">
									<span id = "questioningEtcForSpan_${suimRptBody17_13Vo.serialNo}">${suimRptBody17_13Vo.questioningEtc}</span>
								</td>
							</tr>					
						</c:forEach>
					</tbody>
				</table>
				<p>&nbsp;</p>
				</div>
			</c:if>
			</td>
		</tr>
	</table>
</body>
</html>