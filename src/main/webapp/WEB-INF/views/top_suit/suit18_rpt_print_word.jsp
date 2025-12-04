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
				<table cellpadding="0" cellspacing="0" width="648" align="center">
					 <tr>
				        <td width="50%">
							<p>Report No. ${suimSuit_18Vo.suimAcceptNo}</p>
				        </td>
				        <td width="50%">
							<p align="right">Date. ${todayForWord} </p>
				        </td>
				    </tr>
				</table>
				<p>&nbsp;</p>
	            <p>&nbsp;</p>
	            <p>&nbsp;</p>
				<table cellpadding="0" cellspacing="0" width="648" align="center">
					<tr>
						<td width="85" height="30" >
							<p>수 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신</p>
						</td>
						<td width="84%">
							<p>:&nbsp;삼성화재해상보험(주)</p>
						</td>
					</tr>
					<tr>
						<td width="16%" height="40">
							<p>참 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조</p>
						</td>
						<th width="350" align="left">
							<p>:&nbsp;장기심사파트장</p>
						</th>
					</tr>
					<tr>
						<td width="16%" height="40">
							<p>피 &nbsp;보&nbsp; 험&nbsp;자</p>
						</td>
						<td width="84%">
							<p>
								: ${suimSuit_18Vo.bd1A}
							</p>
						</td>
					</tr>
				</table>
				<p>&nbsp;</p>
	            <p>&nbsp;</p>
	            <p>&nbsp;</p>
	            <table cellpadding="0" cellspacing="0" width="648" align="center">
	            	<tr>
	            		<td>
	            			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				귀사의 요청에 의거 상기 건에 대한 현장 계약 적부 실사 결과를 다음과 같이 보고합니다.</p>
	            		</td>
	            	</tr>
	            </table>
				
	            <p>&nbsp;</p>
            	<p>&nbsp;</p>

				<p>&nbsp;</p>
				<table cellpadding="0" cellspacing="0" width="648" align="center">
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
				<table cellpadding="0" cellspacing="0" width="648" align="center">
				    <tr>
				        <td width="16%">
							<p>실 &nbsp;&nbsp;&nbsp;사 &nbsp;&nbsp;&nbsp;자</p>
				        </td>
				        <td width="84%">
							<p>: ${suimSuit_18Vo.userName}</p>
				        </td>
				    </tr>
				    <tr>
				        <td width="16%">
							<p></p>
				        </td>
				        <td width="84%">
							<p>&nbsp;&nbsp;(Mobile 
							: ${suimSuit_18Vo.handphone} )</p>
				        </td>
				    </tr>
				</table>
				<div  align="center">
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
				<p align="center"><font face="견고딕"><span style="font-size:14pt;">일반물건 
				계약사항 확인서</span></font></p>
				<p>&nbsp;</p>
                            
                            <table cellpadding="0" cellspacing="0" width="648" align="center">
							    <tr>
							        <td >
										<p><B><font color="black">1. 보험계약사항</font></B></p>
							        </td>
					        	</tr>
					        </table>
							<table cellpadding="0" cellspacing="0" width="648" align="center" >
							  
							    <tr>
							    	<td bgcolor="#F3F3FF" class="td" nowrap >
							            <p align="center"><B><font color="black">부호</font></B></p>
							        </td>
							        <td bgcolor="#F3F3FF" class="td" nowrap >
							            <p align="center"><B><font color="black">구분</font></B></p>
							        </td>
							        <td bgcolor="#F3F3FF" class="td" nowrap  colspan="3">
							            <p align="center"><B><font color="black">계약사항</font></B></p>
							        </td>
							    </tr>
							    <tr>
							    	<td class="td" nowrap bgcolor="#F3F3FF">
							            <p align="center"><font color="black">1</font></p>
							        </td>
							        <td class="td" nowrap bgcolor="#F3F3FF">
							            <p align="center"><font color="black">계약자명(업체명)</font></p>
							        </td>
							        <td class="td" colspan="3">
										<p align="center">${suimSuit_18Vo.contractorName }</p>
							        </td>
							    </tr>
							    <tr>
							    	<td class="td" nowrap bgcolor="#F3F3FF">
							            <p align="center"><font color="black">2</font></p>
							        </td>
							        <td class="td" bgcolor="#F3F3FF">
							            <p align="center"><font color="black">소재지</font></p>
							        </td>
							        <td class="td" colspan="3">
										<p align="center">${suimSuit_18Vo.bd1D}</p>
							        </td>
							    </tr>
							    <tr>
							    	<td class="td" nowrap bgcolor="#F3F3FF">
							            <p align="center"><font color="black">3</font></p>
							        </td>
							        <td class="td" bgcolor="#F3F3FF">
							            <p align="center"><font color="black">가입업종</font></p>
							        </td>
							        <td class="td">
										<p>${suimSuit_18Vo.bd1G}</p>
							        </td>
							        <td class="td" bgcolor="#F3F3FF">
							        	<p align="center">요율직종</p>
							        </td>
							        <td class="td" >
							        	<p>${suimSuit_18Vo.bd1H}</p>
							        </td>
							    </tr>
							</table>
                            <p>&nbsp;</p>
                            <table cellpadding="0" cellspacing="0" width="648" align="center">
							    <tr>
							        <td >
										<p><B><font color="black">2. 실사일시 및 중점 점검 요청 항목</font></B></p>
										<p>&nbsp;&nbsp;&nbsp;&nbsp;가. 실사일시</p>
							        </td>
					        	</tr>
					        </table>
							<table cellpadding="0" cellspacing="0" width="648" align="center" >
								<colgroup>
									<col width="20%">
									<col width="30%">
									<col width="20%">
									<col width="30%">
								</colgroup>
							    <tr>
							        <td bgcolor="#F3F3FF" class="td">
							            <p align="center"><B><font color="black">구분</font></B></p>
							        </td>
							        <td bgcolor="#F3F3FF" class="td" colspan="3">
							            <p align="center"><B><font color="black">내용</font></B></p>
							        </td>
							    </tr>
							    <tr>
							        <td class="td">
							            <p align="center"><font color="black">실사일</font></p>
							        </td>
							        <td class="td" colspan="3" >
										<p>
											${suimSuit_18Vo.bd1J}  
										</p>
							        </td>
						        </tr>
						        <tr>
							        <td class="td">
                                       <p align="center"><font color="black">실사자</font></p>
							        </td>
							        <td class="td" colspan="3" >
							            <p>${suimSuit_18Vo.userName}</p>
							        </td>
							    </tr>
							    <tr>
							        <td class="td">
							            <p align="center"><font color="black">면담자(피보험자와 관계)</font></p>
							        </td>
							        <td class="td">
										<p>
											${suimSuit_18Vo.bd1I}
		                                </p>
							        </td>
							        <td class="td" bgcolor="#F3F3FF">
                                       	<p align="center"><font color="black">면담자연락처</font></p>
							        </td>
							        <td class="td">
										<p>
											${suimSuit_18Vo.b1}
										</p>
							        </td>
							    </tr>
							</table>
                            
                            <p>&nbsp;</p>
                            
                            <table cellpadding="0" cellspacing="0" width="648" align="center">
							    <tr>
							        <td >
										<p>&nbsp;&nbsp;&nbsp;&nbsp;나. 중점요청항목</p>
							        </td>
					        	</tr>
					        </table>
                            <table cellpadding="0" cellspacing="0" width="648" align="center">
								<colgroup>
									<col width="40%">
									<col width="60%">
								</colgroup>
							    <tr>
							        <td bgcolor="#F3F3FF" class="td">
							            <p align="center"><B><font color="black">구분</font></B></p>
							        </td>
							        <td bgcolor="#F3F3FF" class="td" >
							            <p align="center"><B><font color="black">중점 점검 요청 항목</font></B></p>
							        </td>
							    </tr>
							    <tr>
							        <td class="td">
							            <p align="center"><font color="black">1</font></p>
							        </td>
							        <td class="td" >
										<p>
											${suimSuit_18Vo.memo1}  
										</p>
							        </td>
						        </tr>
						        <tr>
							        <td class="td">
                                       <p align="center"><font color="black">2</font></p>
							        </td>
							        <td class="td" >
							            <p>${suimSuit_18Vo.memo2}</p>
							        </td>
							    </tr>
							</table>
                            <p>&nbsp;</p>
                            
                            <table cellpadding="0" cellspacing="0" width="648" align="center">
							    <tr>
							        <td >
										<p><B><font color="black">3. 계약사항과 주요항목</font></B></p>
							        </td>
					        	</tr>
					        </table>
							<table cellpadding="0" cellspacing="0" width="648" align="center"  >
							
								<colgroup>
									<col width="10%">
									<col width="35%">
									<col width="20%">
									<col width="10%">
									<col width="20%">
								</colgroup>
							    <tr>
							        <td bgcolor="#F3F3FF" class="td">
							            <p align="center"><B><font color="black">구분</font></B></p>
							        </td>
							        <td bgcolor="#F3F3FF" class="td">
							            <p align="center"><B><font color="black">계약사항</font></B></p>
							        </td>
							        <td bgcolor="#F3F3FF" class="td">
							            <p align="center"><B><font color="black">확인</font></B></p>
							        </td>
							        <td bgcolor="#F3F3FF" class="td">
							            <p align="center"><B><font color="black">일치여부</font></B></p>
							        </td>
							        <td bgcolor="#F3F3FF" class="td">
							            <p align="center"><B>내 &nbsp;&nbsp;&nbsp;용</B></p>
							        </td>
							    </tr>
							    <tr>
							        <td class="td" nowrap bgcolor="#F3F3FF">
							            <p align="center"><font color="black">건물급수</font></p>
							        </td>
							        <td class="td">
										<p align="center">
											<c:if test="${suimSuit_18Vo.bd1F ne ''}">
												${suimSuit_18Vo.bd1F} 급
											</c:if>
										</p>
							        </td>
							        <td class="td">
										<p align="center">
											<c:if test="${suimSuit_18Vo.bd1K ne ''}">
												${suimSuit_18Vo.bd1K} 급
											</c:if>
										</p>
							        </td>
							        <td class="td">
										<p align="center">
											<c:choose>
												<c:when test="${suimSuit_18Vo.report6 eq 1}">
													■
												</c:when>
												<c:when test="${suimSuit_18Vo.report6 eq 2}">
													□
												</c:when>
											</c:choose>		
										</p>
							        </td>
							        <td class="td">
										<p align="center">${suimSuit_18Vo.c2}</p>
							        </td>
							    </tr>
							    <tr>
							        <td class="td" bgcolor="#F3F3FF">
							            <p align="center"><font color="black">가입업종</font></p>
							        </td>
							        <td class="td">
										<p align="center">${suimSuit_18Vo.bd1G}</p>
							        </td>
							        <td class="td">
										<p align="center">${suimSuit_18Vo.bd1L}</p>
							        </td>
							        <td class="td">
										<p align="center">
											<c:choose>
												<c:when test="${suimSuit_18Vo.report7 eq 1}">■</c:when>
												<c:when test="${suimSuit_18Vo.report7 eq 2}">□</c:when>
											</c:choose>
										</p>
							        </td>
							        <td class="td">
										<p align="center">${suimSuit_18Vo.c4}</p>
							        </td>
							    </tr>
							    <tr>
							        <td class="td" bgcolor="#F3F3FF">
							            <p align="center"><font color="black">요율업종</font></p>
							        </td>
							        <td class="td">
										<p align="center">${suimSuit_18Vo.bd1H}</p>
							        </td>
							        <td class="td">
										<p align="center">${suimSuit_18Vo.bd1M}</p>
							        </td>
							        <td class="td">
										<p align="center">
											<c:choose>
												<c:when test="${suimSuit_18Vo.report8 eq 1}">■ </c:when>
												<c:when test="${suimSuit_18Vo.report8 eq 2}">□ </c:when>
											</c:choose>
										</p>
							        </td>
							        <td class="td">
										<p align="center">${suimSuit_18Vo.c6}</p>
							        </td>
							        
							    </tr>
							    <tr>
							        <td class="td" bgcolor="#F3F3FF">
							            <p align="center"><font color="black">소재지</font></p>
							        </td>
							        <td class="td">
										<p align="center">${suimSuit_18Vo.bd1D}</p>
							        </td>
							        <td class="td">
										<p align="center">${suimSuit_18Vo.c7}</p>
							        </td>
							        <td class="td">
										<p align="center">
											<c:choose>
												<c:when test="${suimSuit_18Vo.report5 eq 1}">■ </c:when>
												<c:when test="${suimSuit_18Vo.report5 eq 2}">□ </c:when>
											</c:choose>
										</p>
							        </td>
							        <td class="td">
										<p align="center">${suimSuit_18Vo.c8}</p>
							        </td>
							    </tr>
							    <tr>
							        <td class="td" bgcolor="#F3F3FF">
                                        <p align="center"><span style="font-size:9pt;"><font color="black">피보험자</font></span></p>
                                        <p align="center"><span style="font-size:9pt;">(소유자)</span></p>
							        </td>
							        <td class="td">
										<p align="center">${suimSuit_18Vo.bd1A}</p>
							        </td>
							        <td class="td">
										<p align="center">${suimSuit_18Vo.bd1N}</p>
							        </td>
							        <td class="td">
										<p align="center">
											<c:choose>
												<c:when test="${suimSuit_18Vo.report4 eq 1}">■</c:when>
												<c:when test="${suimSuit_18Vo.report4 eq 2}">□</c:when>
											</c:choose>
										</p>
							        </td>
							        <td class="td">
										<p align="center">${suimSuit_18Vo.c10}</p>
							        </td>
							    </tr>
							</table>
                            <p>&nbsp;</p>
                            
                             <table cellpadding="0" cellspacing="0" width="648" align="center">
							    <tr>
							        <td >
										<p><B><font color="black">4. 적부조사 의견</font></B></p>
							        </td>
					        	</tr>
					        </table>
							<table cellpadding="0" cellspacing="0" width="648" align="center" >
								<colgroup>
									<col width="20%">
									<col width="80%">
								</colgroup>
							    <tr>
							        <td bgcolor="#F3F3FF" class="td" colspan="2">
							            <p><B>&nbsp;○ 건물구조확인</B></p>
							        </td>
							    </tr>
							    <tr>
							        <td class="td" width="100" nowrap>
							            <p align="center">건 &nbsp;&nbsp;물 &nbsp;&nbsp;구 &nbsp;&nbsp;조</p>
							            <p align="center">(판넬및천막유무)</p>
							        </td>
							        <td class="td" width="500">
							            
							            <p>${suimSuit_18Vo.bd1K} 급(기둥:${suimSuit_18Vo.d1} &nbsp;외벽:${suimSuit_18Vo.d2} &nbsp;지붕:${suimSuit_18Vo.d3})</p>
								            <p>패널(  
								        	<c:if test="${suimSuit_18Vo.d4 eq 1 }">■</c:if>
								        	<c:if test="${suimSuit_18Vo.d4 eq 0 }">□</c:if>    
								            유 &nbsp;
								            <c:if test="${suimSuit_18Vo.d4 eq 0 }">■</c:if>
								        	<c:if test="${suimSuit_18Vo.d4 eq 1 }">□</c:if>   
								            무 / 위치 : 
								            ${suimSuit_18Vo.d5}
								            )</p>
								            <p>천막( 
								        	<c:if test="${suimSuit_18Vo.d6 eq 1 }">■</c:if>
								        	<c:if test="${suimSuit_18Vo.d6 eq 0 }">□</c:if>     
								             유 &nbsp;
								            <c:if test="${suimSuit_18Vo.d4 eq 0 }">■</c:if>
								        	<c:if test="${suimSuit_18Vo.d4 eq 1 }">□</c:if> 
								              
								            무 / 위치 : ${suimSuit_18Vo.d7})</p>
							            
							        </td>
							    </tr>
							    <tr>
							        <td class="td">
							            <p align="center">층&nbsp;별&nbsp;방&nbsp;화&nbsp;구&nbsp;획</p>
							        </td>
							        <td class="td">
							            <p>
								           <c:choose>
												<c:when test="${suimSuit_18Vo.d8 eq 1}">■</c:when> 
												<c:when test="${suimSuit_18Vo.d8 eq 0}">□</c:when>
											</c:choose>
											있음
											<c:choose>
												<c:when test="${suimSuit_18Vo.d8 eq 1}">□</c:when> 
												<c:when test="${suimSuit_18Vo.d8 eq 0}">■</c:when>
											</c:choose>
											없음
							            </p>
							        </td>
							    </tr>
							    <tr>
							        <td class="td">
							            <p align="center">건&nbsp;물&nbsp;확&nbsp;인&nbsp;의&nbsp;견</p>
							        </td>
							        <td class="td">
							            <p>${suimSuit_18Vo.d9}</p>
							        </td>
							    </tr>
							</table>
							<p>&nbsp;</p>
							<table cellpadding="0" cellspacing="0" width="648" align="center" >
								<colgroup>
									<col width="20%">
									<col width="80%">
								</colgroup>
							    <tr>
							        <td bgcolor="#F3F3FF" class="td" colspan="2">
							            <p><B>&nbsp;○ 업종확인</B></p>
							        </td>
							    </tr>
							    <tr>
							        <td class="td" nowrap>
							            <p align="center">층&nbsp;별&nbsp;영&nbsp;위&nbsp;업&nbsp;종</p>
							        </td>
							        <td class="td">
<!-- 							            <p>1. 층별업종 지층:<?=$row[d_10]?></p> -->
							            <p>1. 층별업종 지층:${suimSuit_18Vo.d10}</p>
							            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1층:${suimSuit_18Vo.d11}</p>
							            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2층:${suimSuit_18Vo.d12}</p>
							            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3층:${suimSuit_18Vo.d13}</p>
							            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4층:${suimSuit_18Vo.d14}</p>
							            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5층:${suimSuit_18Vo.d15}</p>
							            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5층이상:${suimSuit_18Vo.d16}</p>
							            <p>2. 다음 업종에 해당되는 경우 체크 및 입력</p>
							            <p>&nbsp;&nbsp;2_1. 판매시설</p>
							            <p>&nbsp;&nbsp;&nbsp;-상설할인 매장 여부 : 
							            	<c:choose>
												<c:when test="${suimSuit_18Vo.d17 eq 1}">■</c:when> 
												<c:when test="${suimSuit_18Vo.d17 eq 0}">□</c:when>
											</c:choose>
							            있음
							            	<c:choose>
												<c:when test="${suimSuit_18Vo.d17 eq 0}">■</c:when> 
												<c:when test="${suimSuit_18Vo.d17 eq 1}">□</c:when>
											</c:choose>
							            없음
							            
							            </p>
							            <p>&nbsp;&nbsp;&nbsp;-재래시장 여부 : 
							            	<c:choose>
												<c:when test="${suimSuit_18Vo.d18 eq 1}">■</c:when> 
												<c:when test="${suimSuit_18Vo.d18 eq 0}">□</c:when>
											</c:choose>
							            있음
							            	<c:choose>
												<c:when test="${suimSuit_18Vo.d18 eq 0}">■</c:when> 
												<c:when test="${suimSuit_18Vo.d18 eq 1}">□</c:when>
											</c:choose>
							            없음
							            
							            </p>
							        </td>
							    </tr>
							    <tr>
							        <td class="td">
							            <p align="center">업 종&nbsp;확&nbsp;인&nbsp;의&nbsp;견</p>
							        </td>
							        <td class="td">
							            <p>${suimSuit_18Vo.d19}</p>
							        </td>
							    </tr>
							</table>
							<p>&nbsp;</p>
							<p>&nbsp;</p>
							<table cellpadding="0" cellspacing="0" width="648" align="center"  >
								<colgroup>
									<col width="20%">
									<col width="80%">
								</colgroup>
							    <tr>
							        <td bgcolor="#F3F3FF" class="td" colspan="2">
							            <p><B>&nbsp;○ 목적물 확인</B></p>
							        </td>
							    </tr>
							    <tr>
							        <td class="td" width="100" nowrap>
							            <p align="center">소재지 확인의견</p>
							        </td>
							        <td class="td" width="500">
										<p>
											<c:choose>
												<c:when test="${suimSuit_18Vo.report5 eq 1 }">■</c:when>
												<c:when test="${suimSuit_18Vo.report5 eq 2 }">□</c:when>
											</c:choose>	
											일치  &nbsp;&nbsp;
											<c:choose>
												<c:when test="${suimSuit_18Vo.report5 eq 1 }">□</c:when>
												<c:when test="${suimSuit_18Vo.report5 eq 2 }">■</c:when>
											</c:choose>	
											불일치 
										</p>
							            <p>- 의견 :${suimSuit_18Vo.d20}</p>
							        </td>
							    </tr>
							</table>
				<p>&nbsp;</p>
				<p>&nbsp;</p>

			</td>
		</tr>
	</table>
	
	<table style="width:800px;" align="center">
		<c:forEach items="${suimSuit_18_FileList}" var="suit18FileVo" varStatus="status">
			<c:choose>
				<c:when test="${status.count % 2 == 1 }">
					<tr>
						<td align="center">
							
							<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www${suit18FileVo.filePath}${suit18FileVo.fileName}" width="350" height="300"/>
						</td>
				</c:when>
				
				<c:otherwise>
						<td align="center">
							<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www${suit18FileVo.filePath}${suit18FileVo.fileName}" width="350" height="300"/>
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
			
			
				
				
			
		</c:forEach>
	</table>
					
</body>
</html>