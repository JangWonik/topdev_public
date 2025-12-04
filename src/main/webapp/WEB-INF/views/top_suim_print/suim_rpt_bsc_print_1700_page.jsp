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
				<p align="center"><img src="./resources/ls_img/ls_body/print_head.jpg" width="640" height="56" border="0"></p>
				<p align="center" style="line-height:50%; margin-top:0; margin-bottom:0;">&nbsp;</p>
				<p align="center"><span style="font-size:9pt;">${tmInforForBody.team_addr}</span></p> 
				<p align="center"><span style="font-size:9pt;">전화 : ${tmInforForBody.team_interphone} &nbsp;팩스 : ${tmInforForBody.team_fax} &nbsp;이메일 : ${mbrVoForBody.email}</span></p>
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
	                        <p><img src="./resources/ls_img/ls_body/sign_yoon.jpg" width="72" height="70" border="0"></p>
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
	            </table>
				</div>
				<p>&nbsp;</p>
	           
			<table align="center" cellpadding="0" cellspacing="0" width="640">
				<tr>
					<td height="25">
						<p class="p2"><B>▣ 민원관련 및 전달사항</B></p>
					</td>
				</tr>
			</table>
			<table align="center" cellpadding="0" cellspacing="0" width="640">
				<tr>
					<td class="td" align="center" bgcolor='#cccccc' nowrap>민원가능지수</td>
					<td class="td" align="center" bgcolor='#cccccc' nowrap>민원지수</td>
					<td class="td" align="center" bgcolor='#cccccc' nowrap>고객 성향</td>
					<td class="td" align="center" bgcolor='#cccccc' nowrap>전달할 사항</td>
				</tr>
				<tr>
					<td class="td" align="center" nowrap>A:가능성 적음
						<input type="radio" style="display:none;" name="minwonGrade6" value="A" class="print1700_1InputClass"/>
					</td>
					<td class="td" align="center" nowrap>0~3점</td>
					<td class="td" rowspan="3">
						<span id = "minwonCustomer6Span" class="print1700_1SpanClass">${suimRptBody1700Vo.minwonCustomer6Span}
						<b>
							<c:choose>
								<c:when test="${suimRptBody1700Vo.minwonGrade6 eq 'A'}">
									(A)								
								</c:when>
								<c:when test="${suimRptBody1700Vo.minwonGrade6 eq 'B'}">
									(B)
								</c:when>
								<c:otherwise>
									(C)
								</c:otherwise>
							</c:choose>
						</b></span>
					</td>
					<td class="td" rowspan="3">
						<span id = "minwonMemo6Span" class="print1700_1SpanClass">${suimRptBody1700Vo.minwonMemo6Span}</span>
					</td>
				</tr>
				<tr>
					<td class="td" align="center" nowrap>B:가능성 있음
					</td>
					<td class="td" align="center" nowrap>4~5점</td>
				</tr>
				<tr>
					<td class="td" align="center" nowrap>C:가능성 높음
					</td>
					<td class="td" align="center" nowrap>6~10점</td>
				</tr>
			</table>
            <p>&nbsp;</p>
			<table align="center" cellpadding="0" cellspacing="0" width="640">
				<tr>
					<td height="25" >
						<p class="p2"><B>▣ 조사보고서</B></p>
					</td>
				</tr>
			</table>
			<!-- 조사보고서 -시작- -->
			<table align="center" cellpadding="0" cellspacing="0" width="640">
			    <tr>
			        <td rowspan="6" bgcolor="#CCFFFF" class="tdb" nowrap>
			            <p align="center"><B>피해</B></p>
			            <p align="center"><B>관련</B></p>
			            <p align="center"><B>사항</B></p>
			        </td>
			        <td bgcolor="#CCFFFF" class="tdb" nowrap>
			            <p align="center"><B>피보험자</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">${suimVO.beneficiary_nm}</p>
			        </td>
			        <td bgcolor="#CCFFFF" class="tdb" nowrap>
			            <p align="center"><B>사고번호</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">${suimVO.getAccident_no()}</p>
			        </td>
			        <td bgcolor="#CCFFFF" class="tdb" nowrap>
			            <p align="center"><B>가입일</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			            	<span id = "joinDate1Span" class="print1700_2SpanClass">${suimRptBody1700Vo.joinDate1}</span>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>실손담보</B></p>
			        </td>
			        <td colspan="5" class="tdb">
			            <p align="center">
			            	<span id = "mortgage1Span" class="print1700_2SpanClass">${suimRptBody1700Vo.mortgage1}</span>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>진단명</B></p>
			        </td>
			        <td colspan="5" class="tdb">
			            <p align="center">
			            	<span id = "diagnosis1Span" class="print1700_2SpanClass">${suimRptBody1700Vo.diagnosis1}</span>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>병원명</B></p>
			        </td>
			        <td bgcolor="#CCFFFF" class="tdb" nowrap>
			            <p align="center"><B>치료기간</B></p>
			        </td>
			        <td colspan="4" bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>주치료내용</B></p>
			        </td>
			    </tr>
			    <tr>
			        <td rowspan="2" class="tdb">
			            <p align="center">
			            	<span id = "hospital1Span" class="print1700_2SpanClass">${suimRptBody1700Vo.hospital1Span}</span>
			            </p>
			        </td>
			        <td rowspan="2" class="tdb">
			            <p align="center">
			            	<span id = "patientPeriod1Span" class="print1700_2SpanClass">${suimRptBody1700Vo.patientPeriod1Span}</span>
			            </p>
			        </td>
			        <td colspan="4" class="tdb">
			            <p align="center">
			            	<span id = "cureDtl1Span" class="print1700_2SpanClass">${suimRptBody1700Vo.cureDtl1}</span>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>청구금액</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
				            <span id = "amtReq1Span" class="print1700_2SpanClass">${suimRptBody1700Vo.amtReq1}</span>
			                 원</p>
			        </td>
			        <td class="tdb">
			            <p align="center"><B>요청삭감</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			        		<span id = "amtReduce1Span" class="print1700_2SpanClass">${suimRptBody1700Vo.amtReduce1}</span>
			            원</p>
			        </td>
			    </tr>
			    <tr>
			        <td bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>쟁점</B></p>
			            <p align="center"><B>사항</B></p>
			        </td>
			        <td colspan="6" class="tdb">
			            <p>
			            	<span id = "issue2Span" class="print1700_2SpanClass">${suimRptBody1700Vo.issue2Span}</span>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td rowspan="7" bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>고객</B></p>
			            <p align="center"><B>정보</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center"><B>주소</B></p>
			        </td>
			        <td colspan="3" class="tdb">
			            <p align="center">
			            	<span id = "addr3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.addr3}</span>
			            </p>
			        </td>
			        <td class="tdb">
			            <p align="center"><B>연락처</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			            	<span id = "tel3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.tel3}</span>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>직업</B></p>
			            <p align="center"><B>(회사명)</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			            	<span id = "job3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.job3}</span>
			            </p>
			        </td>
			        <td class="tdb">
			            <p align="center"><B>직무</B></p>
			            <p align="center"><B>(실제하는일)</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			            	<span id = "jobDtl3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.jobDtl3}</span>
			            </p>
			        </td>
			        <td class="tdb">
			            <p align="center"><B>연소득</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			            	<span id = "totSal3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.totSal3}</span>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>건보가입</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			            	<span id = "nhis3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.nhis3}</span>
			            </p>
			        </td>
			        <td class="tdb">
			            <p align="center"><B>보험료</B></p>
			        </td>
			        <td colspan="3" class="tdb">
			            <p align="center">
			        		<span id = "amtNhis3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.amtNhis3}</span>
			            원</p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>운전여부</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			            	<span id = "driveYn3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.driveYn3}</span>
			            </p>
			        </td>
			        <td class="tdb">
			            <p align="center"><B>소유차량번호</B></p>
			        </td>
			        <td colspan="3" class="tdb">
			            <p align="center">
			            	<span id = "carNo3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.carNo3}</span>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>모집자</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			            	<span id = "agent3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.agent3}</span>
			            </p>
			        </td>
			        <td class="tdb">
			            <p align="center"><B>보험계약 경위</B></p>
			        </td>
			        <td colspan="3" class="tdb">
			            <p align="center">
			            	<span id = "contractSituation3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.contractSituation3}</span>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>타사가입사항</B></p>
			        </td>
			        <td colspan="5" class="tdb">
			            <p>
			            	<span id = "otherInsuDtl3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.otherInsuDtl3}</span>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>기&nbsp;타</B></p>
			        </td>
			        <td colspan="5" class="tdb">
			            <p>
			            	<span id = "customerInfo3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.customerInfo3}</span>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td rowspan="9" bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>조사</B></p>
			            <p align="center"><B>결과</B></p>
			        </td>
			        <td bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>해지/전환</B></p>
			        </td>
			        <td class="tdb" colspan="2">
			            <p align="center">
			            	<span id = "contractKeepYn4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.contractKeepYn4}</span>
			            </p>
			        </td>
			        <td colspan="2" bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>문답서</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			            	<span id = "qnaPaper4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.qnaPaper4}</span>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>재이용방지여부</B></p>
			        </td>
			        <td class="tdb" colspan="2">
			            <p align="center">
			            	<span id = "reuseYn4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.reuseYn4}</span>
			            </p>
			        </td>
			        <td colspan="2" bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>본인상한제</B></p>
			            <p align="center"><B>/산정특례</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			            	<span id = "specialCase4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.specialCase4}</span>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>항목</B></p>
			        </td>
			        <td bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>재택심사금</B></p>
			        </td>
			        <td bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>협의결과</B></p>
			        </td>
			        <td colspan="3" bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>사유</B></p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center">입원의료비</p>
			        </td>
			        <td class="tdb">
			            <p align="right">
				           	<span id = "amtHome4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.amtHome4Span}</span>
			            </p>
			        </td>
			        <td class="tdb">
			            <p align="right">
				           	<span id = "amtSettle4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.amtSettle4Span}</span>
			            </p>
			        </td>
			        <td colspan="3" class="tdb">
			            <p align="center">
			            	<span id = "basis4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.basis4Span}</span>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>소계</B></p>
			        </td>
			        <td class="tdb">
			            <p align="right">
			        		<span id = "amtHomeSum4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.amtHomeSum4}</span>
			            원</p>
			        </td>
			        <td class="tdb">
			            <p align="right">
			        		<span id = "amtSettleSum4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.amtSettleSum4}</span>
			            원</p>
			        </td>
			        <td colspan="3" class="tdb">
			            <p align="center"> </p>
			        </td>
			    </tr>
			    <tr>
			        <td colspan="6" bgcolor="#B8CCE4" class="tdb">
			            <p align="center"><B>현재상태</B></p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>일상생활</B></p>
			        </td>
			        <td colspan="5" class="tdb">
			            <p>
			            	<span id = "currentState4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.currentState4}</span>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>향후치료계획</B></p>
			        </td>
			        <td colspan="5" class="tdb">
			            <p>
			            	<span id = "futurePlan4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.futurePlan4}</span>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>주치료병원</B></p>
			            <p align="center"><B>선택사유</B></p>
			        </td>
			        <td colspan="5" class="tdb">
			            <p>
			            	<span id = "hospitalMemo4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.hospitalMemo4}</span>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>기타</B></p>
			            <p align="center"><B>의견</B></p>
			        </td>
			        <td colspan="6" class="tdb">
			            <p>
			            	<span id = "etcMemo5Span" class="print1700_2SpanClass">${suimRptBody1700Vo.etcMemo5Span}</span>
			            </p>
			        </td>
			    </tr>
			</table>
			<!-- 조사보고서 -끝- -->
	        
	        <p>&nbsp;</p>
	        <!-- 첨부자료 목록 -->
				
			<table align="center" cellpadding="0" cellspacing="0" width="640">
				<tr>
					<td height="25" >
						<p class="p2">
							<b>▣  첨부자료 목록 </b>
						</p>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" align="center" width="640">
				<tr>
					<td bgcolor="#ECECEC" class="td" width="30" >
						<p align="center"><b>순번</b></p>
					</td>
					<td class="td" bgcolor="#ECECEC" width="300">
						<p align="center"><b>첨부자료</b></p>
					</td>
					<td class="td" bgcolor="#ECECEC" width="40" >
						<p align="center"><b>부수</b></p>
					</td>
					<td class="td" bgcolor="#ECECEC" width="270" >
						<p align="center"><b>비고</b></p>
					</td>
				</tr>
				<tbody id = "Print1700_7List">
					<c:forEach items="${suimRptBody1700_7List }" var="suimRptBody1700_7Vo">
						<tr id = "Print1700_7ListTr_${suimRptBody1700_7Vo.serialNo}">
							<td align="center" class="td">
								<span >${suimRptBody1700_7Vo.ROWNUM}</span>
							</td>
							<td class="td"  >
								<span id = "attachNameSpan_${suimRptBody1700_7Vo.serialNo}">${suimRptBody1700_7Vo.attachName}</span>
							</td>
							<td class="td" align="center" >
								<span id = "attachCopySpan_${suimRptBody1700_7Vo.serialNo}">${suimRptBody1700_7Vo.attachCopy}</span>
							</td>
							<td class="td"  >
								<span id = "attachEtcMemoSpan_${suimRptBody1700_7Vo.serialNo}">${suimRptBody1700_7Vo.attachEtcMemo}</span>
							</td>
						</tr>					
					</c:forEach>
				</tbody>
			</table>
			<p>&nbsp;</p>	
				
			<!-- // 첨부자료 목록-->
	        
	        <p>&nbsp;</p>
			<p align="center"><B>본 손해사정서는 당사의 양식과 최선의 노력으로 이해 당사자</B></p>
			<p align="center"><B>어느 일방에도 편중됨이 없이 작성되었음을 명백히 합니다.[끝]</B></p>
			<p>&nbsp;</p>
			<table cellpadding="0" cellspacing="0" width="640" align="center">
				<tr>
					<td width="100%" class="td" align="center">
						<p><b>최종보고서 제출일로부터 15일 이내에 본사 손사 담당자로부터 조사서류 일체의</b></p>
						<p><b>파기에 관한 의사표시가 없는 경우, 지체 없이 조사서류 일체를 파기한다.</b></p>
					</td>
				</tr>
			</table>
			<p>&nbsp;</p>
			
			<p>&nbsp;</p>
			<table cellpadding="0" cellspacing="0" width="640" align="center">
				<tr>
					<td width="100%" height="45" class="td">
						<p style="line-height:200%;" align="center"><font size="5"><b>사 고 처 리 과 정 표</b></font></p>
					</td>
				</tr>
			</table>
			<table align="center" cellpadding="0" cellspacing="0" width="640">
				<tr>
					<td height="25" width="50%">
						<p class="p2"><B>처리과정(서류접수 현황포함)</B></p>
					</td>
					<td height="25" width="50%">
						<p>&nbsp;</p>
					</td>
				</tr>
			</table>
			<table cellSpacing=0 cellPadding="0" width="635" align="center" >
				<tr>
					<td bgcolor="#ECECEC" class="td" width="200">
						<p align="center"><b>일 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자</b></td>
					<td bgcolor="#ECECEC" class="td" width="204">
						<p align="center"><b>항 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</b></td>
					<td bgcolor="#ECECEC" class="td" width="215">
						<p align="center"><b>처 &nbsp;리 &nbsp;내 &nbsp;용</b></p>
					</td>
				</tr>
				<tbody id="print1700_Ctrl">
				<c:forEach items="${sagoList }" var="sagoVo">
					<tr id = "print1700_Ctrl_${sagoVo.sagoNo }">
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
			</td>
		</tr>
	</table>
</body>
<script language="JavaScript">
window.print();
</script>
</html>