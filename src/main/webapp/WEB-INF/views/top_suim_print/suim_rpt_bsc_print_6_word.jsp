<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page import = "java.io.*" %>
<%-- <%
	String filename = "현장보고서";
	filename = java.net.URLEncoder.encode(filename,"UTF-8");
	response.setHeader("Content-Disposition", "attachment;filename="+filename+".doc");
	response.setHeader("Content-Description", "JSP Generated Data");  
    //response.setContentType("application/vnd.ms-word");
%> --%>
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
	<table cellpadding="0" cellspacing="0" width="640" align="center">
		<tr>
			<td width="640">
				<p align="center"><img src="https://www.toplac.co.kr/resources/ls_img/ls_body/print_head.jpg" width="640" height="56" border="0"></p>
				<p align="center" style="line-height:50%; margin-top:0; margin-bottom:0;">&nbsp;</p>
				<p align="center"><span style="font-size:9pt;">${tmInforForBody.team_addr}</span></p> 
				<p align="center"><span style="font-size:9pt;">전화 : ${tmInforForBody.team_interphone} &nbsp;팩스 : ${tmInforForBody.team_fax} &nbsp;이메일 : ${mbrVoForBody.email}</span></p>
				<hr size="1" width="640" noshade color="black">
				<p>&nbsp;</p>
				<table cellpadding="0" cellspacing="0" width="640" align="center">
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
								<c:if test="${suimVO.policyholder_nm ne ''}">
									&quot;<b>${suimVO.policyholder_nm}</b>&quot;
								</c:if>
								 손해사정서
							 </p>
						</th>
					</tr>
					<tr>
						<th height="30" width="85" align="center">
							<p>수 &nbsp;&nbsp;임 &nbsp;&nbsp;일</p>
						</th>
						<th width="555" colspan="3" align="left">
							<p>: ${suimVO.reg_date} </p>
						</th>
					</tr>
					<tr>
						<th height="30" width="85" align="center">
							<p>사 고 번 호</p>
						</th>
						<th width="555" colspan="3" align="left">
							<p>: ${suimVO.accident_no}</p>
						</th>
					</tr>
				</table>
				
				<table cellpadding="0" cellspacing="0"  align="center" width="640">
					<tr>
						<td class="td_box" width="100%">
							<p>&nbsp;1. 귀사에서 손해사정 의뢰하신 ${suimVO.policyholder_nm }(${suimVO.policyholder_ssn })님의 보험금 청구와 관련하여</p>
							<table cellpadding="0" cellspacing="0">
								<tr>
									<td nowrap>
										<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(청구내용: ${suimRptBodyVo.requestDtl } 
											<c:if test="${suimRptBodyVo.daysInpatient ne '' }">
												<br />
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												입원일: ${suimRptBodyVo.daysInpatient }	
											</c:if>
											<c:if test="${suimRptBodyVo.daysOutpatient ne '' }">
												<br />
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												통원일: ${suimRptBodyVo.daysOutpatient }									
											</c:if>
											)
										</p>	
									</td>
								</tr>
						    </table>
							<p>&nbsp;2. 본 보고서는 최대 선의의 원칙에 의거하여 이해 당사자 어느 일방에도 치우침 없이 작성하였음을</p>
							<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명백히 합니다.</p>
						</td>
					</tr>
	            </table>
				<p>&nbsp;</p>
				<div  align="right">
				<table cellpadding="0" cellspacing="0" width="640">
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
	                        <p><img src="https://www.toplac.co.kr/resources/ls_img/ls_body/sign_yoon.jpg" width="52" height="50" border="0"></p>
	                    </td>
	                </tr>
	                <tr>
	                    <td width="565" colspan="2">
	                        <p align="right">070-8255-3000</p>
	                    </td>
	                </tr> -->
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
	                    <td width="75">
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
							<c:choose>
								<c:when test="${signVoForRptUser.user_sign ne '' or signVoForRptUser.user_sign ne null}">
									<img src='https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${signVoForRptUser.user_no}/${signVoForRptUser.user_sign}' width=50 height=50 border=0>	                        	
								</c:when>
								<c:otherwise>
									사인 없음
								</c:otherwise>
							</c:choose>  
	                    </td>
	                </tr>
	                <tr>
	                    <td width="565" colspan="2">
	                        <p align="right">${mbrVoForBody.handphone }</p>
	                    </td>
	                </tr>
	            </table>
				</div>
				<p align="center">
<!-- 					<img src="https://www.toplac.co.kr/resources/ls_img/report/sign_report.jpg" width="300" height="80" border="0"> -->
					<img src="https://www.toplac.co.kr/resources/ne_img/sign_salary.jpg" />
				</p>
			</td>
		</tr>
	</table>

</body>
</html>