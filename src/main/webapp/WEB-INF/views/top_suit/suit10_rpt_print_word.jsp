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
.td {border:1px solid #000000;padding:3px; font-size:11pt; line-height:130%; margin-top:0; margin-bottom:0; font-family:굴림;}
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
	<table id = "rptBody6Table" align="center" cellpadding="0" cellspacing="0" width="648">
		<tr>
			<td>
				<p align="center"><img src="https://www.toplac.co.kr/resources/ls_img/ls_body/print_head.jpg" width="640" height="56" border="0"></p>
				<p align="center" style="line-height:50%; margin-top:0; margin-bottom:0;">&nbsp;</p>
				<p align="center"><span style="font-size:9pt;">${topTmInfoForBody.team_addr}</span></p> 
				<p align="center"><span style="font-size:9pt;">전화 : ${topTmInfoForBody.team_interphone} &nbsp;팩스 : ${topTmInfoForBody.team_fax} &nbsp;이메일 : ${mbrVoForBody.email}</span></p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				
				
				<table cellpadding="0" cellspacing="0" width="648" align="center">
					<tr>
						<th width="85" height="30" align="center">
							<p>수 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신</p>
						</th>
						<th width="350" align="left">
							<p>(주) KB 손해보험</p>
						</th>
						<th width="90" align="right">
							<p>Report No.</p>
						</th>
						<th width="115" align="left">
							<p>&nbsp;${suimSuit_10Vo.suimAcceptNo}</p>
						</th>
					</tr>
					<tr>
						<th height="30" width="85" align="center">
							<p>참 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조</p>
						</th>
						<th width="350" align="left">
							<p>: 장기인수팀장</p>
						</th>
					</tr>
					<tr>
						<th height="30" width="85" align="center">
							<p>피 &nbsp;보&nbsp; 험&nbsp;자</p>
						</th>
						<th width="555" colspan="3" align="left">
							<p>
								: ${suimSuit_10Vo.hostName}
							</p>
						</th>
					</tr>
				</table>
				<p>&nbsp;</p>
	            <p>&nbsp;</p>
	            <p>&nbsp;</p>
				<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				귀사의 요청에 의거 상기 건에 대한 현장 계약 적부 실사 결과를 다음과 같이 보고합니다.</p>
	            <p>&nbsp;</p>
            	<p>&nbsp;</p>
				<p>&nbsp;</p>
				<br/>
				<br/>
				<table align="center" cellpadding="0" cellspacing="0" width="100%">
				    <tr>
				        <td width="16%">
							<p>책 &nbsp;&nbsp;&nbsp;임 &nbsp; &nbsp;자</p>
				        </td>
				        <td width="60">
							<p>: 윤경수</p>
				        </td>
				        <td width="478">
							<p><img src="https://www.toplac.co.kr/resources/ls_img/ls_body/sign_yoon.jpg" width="72" height="70" border="0"></p>
				        </td>
				    </tr>
				</table>
				<table align="center" cellpadding="0" cellspacing="0" width="100%">
				    <tr>
				        <td width="16%">
							<p>실 &nbsp;&nbsp;&nbsp;사 &nbsp;&nbsp;&nbsp;자</p>
				        </td>
				        <td width="84%">
							<p>: ${suimSuit_10Vo.userName}</p>
				        </td>
				    </tr>
				    <tr>
				        <td width="16%">
							<p></p>
				        </td>
				        <td width="84%">
							<p>&nbsp;&nbsp;(Mobile 
							: ${suimSuit_10Vo.handphone} )</p>
				        </td>
				    </tr>
				</table>
				<div  align="right">
					<table cellpadding="0" cellspacing="0" width="640">
		                 <tr>
		                    <td colspan="3" height="170" valign="bottom" width="640">
								<p align="center">
									<img src="https://www.toplac.co.kr/resources/ne_img/sign_salary.jpg" />
<!-- 									<img src="https://www.toplac.co.kr/resources/ls_img/report/sign_report.jpg" width="300" height="80" border="0"> -->
								</p>
		                    </td>
		                </tr>
					</table>
				</div>
				
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p align="center"><font face="견고딕"><span style="font-size:14pt;">실사보고서 (일반)</span></font></p>
				<p>&nbsp;</p>
				<p><font face="견고딕"><span style="font-size:14pt;">1. 계약사항</span></font></p>
				<table align="center" cellpadding="0" cellspacing="0" width="600">
				    <tr>
				        <td bgcolor="#F3F3F3" class="td" nowrap width="20%">
				            <p align="center"><B><font color="black">구분</font></B></p>
				        </td>
				        <td bgcolor="#F3F3F3" class="td" nowrap width="80%">
				            <p align="center"><B><font color="black">계약사항</font></B></p>
				        </td>
				    </tr>
				    <tr>
				        <td class="td" nowrap bgcolor="#F3F3F3">
				            <p align="center"><font color="black">계약자명</font></p>
				        </td>
				        <td class="td">
							<p>${suimSuit_10Vo.contractorName}</p>
				        </td>
				    </tr>
				    <tr>
				        <td class="td" bgcolor="#F3F3F3">
				            <p align="center"><font color="black">소유자명</font></p>
				        </td>
				        <td class="td">
							<p>${suimSuit_10Vo.hostName}</p>
				        </td>
				    </tr>
				    <tr>
				        <td class="td" bgcolor="#F3F3F3">
				            <p align="center"><font color="black">소재지</font></p>
				        </td>
				        <td class="td">
							<p>${suimSuit_10Vo.buildingAddr}</p>
				        </td>
				    </tr>
				</table>
				<p>&nbsp;</p>
				<p><font face="견고딕"><span style="font-size:14pt;">2. 실사사항</span></font></p>
				<table align="center" cellpadding="0" cellspacing="0" width="600">
				    <tr>
				        <td bgcolor="#F3F3F3" class="td">
				            <p align="center"><B><font color="black">구분</font></B></p>
				        </td>
				        <td bgcolor="#F3F3F3" class="td" colspan="3">
				            <p align="center"><B><font color="black">내용</font></B></p>
				        </td>
				    </tr>
				    <tr>
				        <td class="td" bgcolor="#F3F3F3" width="20%">
				            <p align="center"><font color="black">실사일시</font></p>
				        </td>
				        <td class="td" width="40%">
							<p>${suimSuit_10Vo.b1}</p>
				        </td>
				        <td class="td" bgcolor="#F3F3F3" width="20%">
				            <p align="center"><font color="black">실사자</font></p>
				        </td>
				        <td class="td" width="20%">
				            <p>${suimSuit_10Vo.userName}</p>
				        </td>
				    </tr>
				    <tr>
				        <td class="td" bgcolor="#F3F3F3">
				            <p align="center"><font color="black">면담자(관계)</font></p>
				        </td>
				        <td class="td">
							<p>${suimSuit_10Vo.b2} (
								<c:choose>
									<c:when test="${suimSuit_10Vo.b2Code eq '001'}">본인</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '011'}">배우자</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '021'}">자녀</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '024'}">손주</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '027'}">태아</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '028'}">친족(가족)</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '032'}">부</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '033'}">모</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '042'}">조부</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '043'}">조모</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '051'}">형제/자매</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '102'}">친구</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '103'}">지인</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '105'}">임직원</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '106'}">법정상속인</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '107'}">고용주</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '108'}">고용운전자</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '109'}">임대차</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '125'}">차량소유주(본인)</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '126'}">자량소유주(본인외)</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '127'}">질권자</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '239'}">채권자</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '241'}">수출입 관계자</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '242'}">고용인 (종업원)</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '245'}">각피보험자본인</c:when>
									<c:when test="${suimSuit_10Vo.b2Code eq '999'}">기타</c:when>								
								</c:choose>
							)</p>
							
							
							
				        </td>
				        <td class="td" bgcolor="#F3F3F3" nowrap>
				            <p align="center"><font color="black">면담자연락처</font></p>
				        </td>
				        <td class="td">
				            <p>${suimSuit_10Vo.b3}</p>
				        </td>
				    </tr>
				</table>
				<p>&nbsp;</p>
				<p><font face="견고딕"><span style="font-size:14pt;">3. 계약사항과 실사사항 
				비교</span></font></p>
				<table align="center" cellpadding="0" cellspacing="0" width="600">
				    <tr>
				        <td bgcolor="#F3F3F3" class="td" nowrap>
				            <p align="center"><B><font color="black">구분</font></B></p>
				        </td>
				        <td bgcolor="#F3F3F3" class="td" nowrap>
				            <p align="center"><B><font color="black">계약사항</font></B></p>
				        </td>
				        <td bgcolor="#F3F3F3" class="td" nowrap>
				            <p align="center"><B><font color="black">확인사항</font></B></p>
				        </td>
				        <td bgcolor="#F3F3F3" class="td" nowrap>
				            <p align="center"><B><font color="black">일치여부</font></B></p>
				        </td>
				    </tr>
				    <tr>
				        <td class="td" nowrap bgcolor="#F3F3F3" nowrap>
				            <p align="center"><font color="black">건물급수</font></p>
				        </td>
				        <td class="td">
							<p>${suimSuit_10Vo.buildinginfo03}급</p>
				        </td>
				        <td class="td">
							<p>${suimSuit_10Vo.c1}</p>
				        </td>
				        <td class="td">
							<p>
								<c:choose>
									<c:when test="${suimSuit_10Vo.report6 eq 1}">■ 일치</c:when>
									<c:when test="${suimSuit_10Vo.report6 eq 2}">□ 불일치</c:when>
								</c:choose>
							</p>
				        </td>
				    </tr>
				    <tr>
				        <td class="td" bgcolor="#F3F3F3">
				            <p align="center"><font color="black">실제업종</font></p>
				        </td>
				        <td class="td">
							<p>${suimSuit_10Vo.buildinginfo01}</p>
				        </td>
				        <td class="td">
							<p>${suimSuit_10Vo.c2}</p>
				        </td>
				        <td class="td">
							<p>
								<c:choose>
									<c:when test="${suimSuit_10Vo.report7 eq 1}">■ 일치</c:when>
									<c:when test="${suimSuit_10Vo.report7 eq 2}">□ 불일치</c:when>
								</c:choose>
							</p>
				        </td>
				    </tr>
				    <tr>
				        <td class="td" bgcolor="#F3F3F3">
				            <p align="center"><font color="black">요율업종</font></p>
				        </td>
				        <td class="td">
							<p>${suimSuit_10Vo.buildinginfo02}</p>
				        </td>
				        <td class="td">
							<p>${suimSuit_10Vo.c3}</p>
				        </td>
				        <td class="td">
							<p>
								<c:choose>
									<c:when test="${suimSuit_10Vo.report8 eq 1}">■ 일치</c:when>
									<c:when test="${suimSuit_10Vo.report8 eq 2}">□ 불일치</c:when>
								</c:choose>
							</p>
				        </td>
				    </tr>
				    <tr>
				        <td class="td" bgcolor="#F3F3F3">
				            <p align="center"><font color="black">소재지</font></p>
				        </td>
				        <td class="td">
							<p>${suimSuit_10Vo.buildingAddr}</p>
				        </td>
				        <td class="td">
							<p>${suimSuit_10Vo.c4}</p>
				        </td>
				        <td class="td">
							<p>
								<c:choose>
									<c:when test="${suimSuit_10Vo.report5 eq 1}">■ 일치</c:when>
									<c:when test="${suimSuit_10Vo.report5 eq 2}">□ 불일치</c:when>
								</c:choose>
							</p>
				        </td>
				    </tr>
				    <tr>
				        <td class="td" bgcolor="#F3F3F3">
				            <p align="center"><span style="font-size:9pt;"><font color="black">소유자</font></span></p>
				        </td>
				        <td class="td">
							<p>${suimSuit_10Vo.hostName}</p>
				        </td>
				        <td class="td">
							<p>${suimSuit_10Vo.c5}</p>
				        </td>
				        <td class="td">
							<p>
								<c:choose>
									<c:when test="${suimSuit_10Vo.report4 eq 1}">■ 일치</c:when>
									<c:when test="${suimSuit_10Vo.report4 eq 2}">□ 불일치</c:when>
								</c:choose>
							</p>
				        </td>
				    </tr>
				    <tr>
				        <td class="td" bgcolor="#F3F3F3">
				            <p align="center"><font color="black"><span style="font-size:9pt;">중점요청사항</span></font></p>
				        </td>
				        <td class="td">
							<p>${suimSuit_10Vo.buildingMemo}</p>
				        </td>
				        <td class="td">
							<p>${suimSuit_10Vo.c6}</p>
				        </td>
				        <td class="td">
							<p>
								<c:choose>
									<c:when test="${suimSuit_10Vo.report11 eq 1}">■ 일치</c:when>
									<c:when test="${suimSuit_10Vo.report11 eq 2}">□ 불일치</c:when>
								</c:choose>
							</p>
				        </td>
				    </tr>
				</table>
				<p>&nbsp;</p>
				<p><font face="견고딕"><span style="font-size:14pt;">4. 조사의견</span></font></p>
				<table align="center" cellpadding="0" cellspacing="0" width="600">
				    <tr>
				        <td bgcolor="#F3F3F3" class="td" colspan="2" nowrap>
				            <p align="center"><B><font color="black">구분</font></B></p>
				        </td>
				        <td bgcolor="#F3F3F3" class="td" nowrap>
				            <p align="center"><B><font color="black">조사의견</font></B></p>
				        </td>
				    </tr>
				    <tr>
				        <td class="td" nowrap bgcolor="#F3F3F3" rowspan="3" nowrap>
				            <p align="center"><font color="black">구조</font></p>
				        </td>
				        <td class="td" nowrap bgcolor="#F3F3F3">
				                                        <p align="center"><font color="black">건물구조</font></p>
				        </td>
				        <td class="td">
							<p>${suimSuit_10Vo.d16}급 (${suimSuit_10Vo.d1})</p>
				            <p>판넬사용여부 ( 
					            <c:choose>
					            	<c:when test="${suimSuit_10Vo.d2 eq '1'}">■</c:when>
					            	<c:otherwise>□</c:otherwise>
					            </c:choose> 유 &nbsp;
					            
					            <c:choose>
					            	<c:when test="${suimSuit_10Vo.d2 ne '1'}">■</c:when>
					            	<c:otherwise>□</c:otherwise>
					            </c:choose> 
					            	
					            	무 / 위치 : ${suimSuit_10Vo.d3})
				            
				            </p>
				            <p>천막사용여부 (
					            <c:choose>
					            	<c:when test="${suimSuit_10Vo.d4 eq '1'}">■</c:when>
					            	<c:otherwise>□</c:otherwise>
					            </c:choose> 유 &nbsp;
					            
					            <c:choose>
					            	<c:when test="${suimSuit_10Vo.d4 ne '1'}">■</c:when>
					            	<c:otherwise>□</c:otherwise>
					            </c:choose> 
					            	
					            	무 / 위치 : ${suimSuit_10Vo.d5})
				            )</p>
				        </td>
				    </tr>
				    <tr>
				        <td class="td" nowrap bgcolor="#F3F3F3" nowrap>
				             <p align="center"><font color="black">방화구획</font></p>
				        </td>
				        <td class="td">
				            <p>
				            	<c:choose>
					            	<c:when test="${suimSuit_10Vo.d6 eq '1'}">■</c:when>
					            	<c:otherwise>□</c:otherwise>
					            </c:choose> 구획 &nbsp;
					            <c:choose>
					            	<c:when test="${suimSuit_10Vo.d6 ne '1'}">■</c:when>
					            	<c:otherwise>□</c:otherwise>
					            </c:choose> 미구획
				            </p>
				        </td>
				    </tr>
				    <tr>
				        <td class="td" nowrap bgcolor="#F3F3F3" nowrap>
				             <p align="center"><font color="black">확인의견</font></p>
				        </td>
				        <td class="td">
				            <p>${suimSuit_10Vo.d7}</p>
				        </td>
				    </tr>
				    <tr>
				        <td class="td" bgcolor="#F3F3F3" rowspan="2" nowrap>
				            <p align="center"><font color="black">업종</font></p>
				        </td>
				        <td class="td" bgcolor="#F3F3F3" nowrap>
				             <p align="center"><font color="black">층별업종</font></p>
				        </td>
				        <td class="td">
				            <p>1층 : ${suimSuit_10Vo.d8}</p>
				            <p>2층 : ${suimSuit_10Vo.d9}</p>
				            <p>3층 : ${suimSuit_10Vo.d10}</p>
				            <p>4층 : ${suimSuit_10Vo.d11}</p>
				            <p>5층 : ${suimSuit_10Vo.d12}</p>
				            <p>5층이상 : ${suimSuit_10Vo.d13}</p>
				        </td>
				    </tr>
				    <tr>
				        <td class="td" bgcolor="#F3F3F3" nowrap>
				             <p align="center"><font color="black">확인의견</font></p>
				        </td>
				        <td class="td">
				            <p>${suimSuit_10Vo.d14}</p>
				        </td>
				    </tr>
				    <tr>
				        <td class="td" bgcolor="#F3F3F3" colspan="2" nowrap>
				            <p align="center"><font color="black">소재지 확인의견</font></p>
				        </td>
				        <td class="td">
				            <p>${suimSuit_10Vo.d15}</p>
				        </td>
				    </tr>
				</table>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<div align="center">
					<c:forEach items="${suimSuit_10_FileList }" var="suit10FileVo">
						<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www${suit10FileVo.filePath}${suit10FileVo.fileName}" width="600" height="500"/>
						<p>&nbsp;</p>
					</c:forEach>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>