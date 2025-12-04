<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<!DOCTYPE html PUBLIC "-//W3C//Dth HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dth">
<html lang="ko">
<head>
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<style type="text/css">
		td {color:#000000; font-size:11pt; line-height:130%; margin-top:0; margin-bottom:0; font-family:굴림;}
		p {color:#000000; font-size:11pt; line-height:130%; margin-top:0; margin-bottom:0; font-family:굴림;}
		table {border-collapse:collapse;border-spacing:0; font-size:11pt;}
		.td {border:1px solid #000000;padding:3px; font-size:11pt; line-height:130%; margin-top:0; margin-bottom:0; font-family:굴림;}
	</style>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">

	<table align="center" cellpadding="0" cellspacing="0" width="640">
    <tr>
        <td width="100%">
			<p align="center"><img src="https://www.toplac.co.kr/resources/ls_img/ls_body/print_head.jpg" width="640" height="56" border="0"></p>
			<p align="center" style="line-height:100%; margin-top:0; margin-bottom:0;">&nbsp;</p>
			<p align="center">${topTmBscVo.team_addr}</p>
			<p align="center">전화 : ${topTmBscVo.team_interphone} &nbsp;팩스 : ${topTmBscVo.team_fax} &nbsp;이메일 : ${mbrVoForBody.email}</p>
			<hr size="1" width="640" noshade color="black">
			<p>&nbsp;</p>
			<table align="center" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td width="50%">
						<p>탑 계약적부</p>
					</td>
					<td width="50%">
						<p align="right">Date. </p>
					</td>
				</tr>
			</table>
			<p>&nbsp;</p>
			<p>&nbsp;</p>
			<table align="center" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td width="16%" height="40">
						<p>수 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신</p>
					</td>
					<td width="84%">
						<p>: ${getSuimSuit17DtlBsc.ptnrName}</p>
					</td>
				</tr>
				<tr>
					<td width="16%" height="40">
						<p>참 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조</p>
					</td>
					<td width="84%">
						<p>:&nbsp; 장기업무팀장</p>
					</td>
				</tr>
				<tr>
					<td width="16%" height="40">
						<p>제 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</p>
					</td>
					<td width="84%">
						<p>:&nbsp; 계약적부 현장 실사 보고서</p>
					</td>
				</tr>
			</table>
			<p>&nbsp;</p>
			<p>&nbsp;</p>
			<p align="center">귀사의 요청에 의거 다음 건에 대한 현장 계약 적부 실사 결과를 보고합니다.</p>
            <p>&nbsp;</p>
            <p align="center">다&nbsp;&nbsp;음</p>
            <p>&nbsp;</p>
			<table align="center" cellpadding="0" cellspacing="0" width="90%">
				<tr>
					<td width="100%">
						<p>1. 계약번호 : ${getSuimSuit17DtlBsc.infoA}</p>
					</td>
				</tr>
				<tr>
					<td width="100%">
						<p>2. 계 약 자 : ${getSuimSuit17DtlBsc.policyholderNm}</p>
					</td>
				</tr>
			</table>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
			<table align="center" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td width="16%">
						<p>책 &nbsp;&nbsp;&nbsp;임 &nbsp; &nbsp;자</p>
					</td>
					<td width="60">
						<p>: 윤경수</p>
					</td>
					<td width="478">
						<p><img src="https://www.toplac.co.kr/resources/ls_img/ls_body/sign_yoon.jpg" align="absmiddle" width="70" height="70" border="0"></p>
					</td>
				</tr>
			</table>
			<table align="center" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td width="16%">
						<p>실 &nbsp;&nbsp;&nbsp;사 &nbsp;&nbsp;&nbsp;자</p>
					</td>
					<td width="84%">
						<p>: ${getSuimSuit17DtlBsc.userName}</p>
					</td>
				</tr>
				<tr>
					<td width="16%">
						<p></p>
					</td>
					<td width="84%">
						<p>&nbsp;&nbsp;(Mobile : ${mbrVoForBody.handphone})</p>
					</td>
				</tr>
			</table>
			<p>&nbsp;</p>
			<p>&nbsp;</p>
			<p align="center">
				<img src="https://www.toplac.co.kr/resources/ne_img/sign_salary.jpg" />
<!-- 				<img src="https://www.toplac.co.kr/resources/ls_img/report/sign_report.jpg" border="0" width="250" height="78"> -->
			</p>
        </td>
    </tr>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p align="center"><font face="견고딕"><span style="font-size:14pt;">실사보고서 
(<c:if test="${getSuimSuit17DtlBsc.bdType eq '1'}">일반</c:if>
<c:if test="${getSuimSuit17DtlBsc.bdType ne '1'}">공장</c:if>)</span></font></p>
<p>&nbsp;</p>
<p><font face="견고딕"><span style="font-size:14pt;">1. 계약사항</span></font></p>
<table align="center" cellpadding="0" cellspacing="0" width="600" border="1">
    <tr>
        <td bgcolor="#F3F3F3" class="td" nowrap width="20%">
            <p align="center"><B><font color="black">구분</font></B></p>
        </td>
        <td bgcolor="#F3F3F3" class="td" nowrap width="80%">
            <p align="center"><B><font color="black">계약사항</font></B></p>
        </td>
    </tr>
    <tr>
        <td class="td	" nowrap bgcolor="#F3F3F3">
            <p align="center"><font color="black">계약자명</font></p>
        </td>
        <td class="td">
<p>${getSuimSuit17DtlBsc.policyholderNm}</p>
        </td>
    </tr>
    <tr>
        <td class="td" bgcolor="#F3F3F3">
            <p align="center"><font color="black">소유자명</font></p>
        </td>
        <td class="td">
<p>${getSuimSuit17DtlBsc.infoAd}</p>
        </td>
    </tr>
    <tr>
        <td class="td" bgcolor="#F3F3F3">
            <p align="center"><font color="black">소재지</font></p>
        </td>
        <td class="td">${getSuimSuit17DtlBsc.infoAb}&nbsp;&nbsp;${getSuimSuit17DtlBsc.infoAc}</td>
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
<p>${getSuimSuit17DtlBsc.reC}</p>
        </td>
        <td class="td" bgcolor="#F3F3F3" width="20%">
                                        <p align="center"><font color="black">실사자</font></p>
        </td>
        <td class="td" width="20%">
            <p>${getSuimSuit17DtlBsc.userName}</p>
        </td>
    </tr>
    <tr>
        <td class="td" bgcolor="#F3F3F3">
            <p align="center"><font color="black">면담자(관계)</font></p>
        </td>
        <td class="td">
<p>${getSuimSuit17DtlBsc.d18}(

<c:if test="${getSuimSuit17DtlBsc.b2code eq '1'}">본인</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '11'}">배우자</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '21'}">자녀</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '24'}">손주</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '27'}">태아</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '28'}">친족(가족)</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '32'}">부</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '33'}">모</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '42'}">조부</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '43'}">조모</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '51'}">형제/자매</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '102'}">친구</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '103'}">지인</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '105'}">임직원</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '106'}">법정상속인</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '107'}">고용주</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '108'}">고용운전자</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '109'}">임대차</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '125'}">차량소유주(본인)</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '126'}">차량소유주(본인외)</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '127'}">질권자</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '239'}">채권자</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '241'}">수출입_관계자</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '242'}">고용인(종업원)</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '245'}">각피보험자본인</c:if>
<c:if test="${getSuimSuit17DtlBsc.b2code eq '999'}">기타</c:if>

)</p>
        </td>
        <td class="td" bgcolor="#F3F3F3" nowrap>
                                        <p align="center"><font color="black">면담자연락처</font></p>
        </td>
        <td class="td">
            <p>${getSuimSuit17DtlBsc.d19}</p>
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
        <td class="td">${getSuimSuit17DtlBsc.infoN}</td>
        <td class="td">${getSuimSuit17DtlBsc.reG}급</td>
    	<td class="td">
           <p align="center">${getSuimSuit17DtlBsc.reH}
        </td>
    </tr>
    <tr>
        <td class="td" bgcolor="#F3F3F3">
            <p align="center"><font color="black">실제업종</font></p>
        </td>
        <td class="td">${getSuimSuit17DtlBsc.infoO}</td>
        <td class="td">${getSuimSuit17DtlBsc.reI}</td>
        <td class="td">
            <p align="center">${getSuimSuit17DtlBsc.reJ}</td>
    </tr>
    <tr>
        <td class="td" bgcolor="#F3F3F3">
            <p align="center"><font color="black">요율업종</font></p>
        </td>
        <td class="td">${getSuimSuit17DtlBsc.infoP}</td>
        <td class="td">${getSuimSuit17DtlBsc.reK}</td>
        <td class="td">
            <p align="center">${getSuimSuit17DtlBsc.reL}</td>
    </tr>
    <tr>
        <td class="td" bgcolor="#F3F3F3">
            <p align="center"><font color="black">소재지</font></p>
        </td>
        <td class="td">${getSuimSuit17DtlBsc.infoAb}<br>${getSuimSuit17DtlBsc.infoAc}</td>
        <td class="td">${getSuimSuit17DtlBsc.reAc}</td>
        <td class="td">
            <p align="center">${getSuimSuit17DtlBsc.reP}</td>
    </tr>
    <tr>
        <td class="td" bgcolor="#F3F3F3">
                                        <p align="center"><span style="font-size:9pt;"><font color="black">피보험자(소유자)</font></span></p>
        </td>
        <td class="td">${getSuimSuit17DtlBsc.infoAd}</td>
        <td class="td">${getSuimSuit17DtlBsc.reQ}</td>
        <td class="td">
            <p align="center">${getSuimSuit17DtlBsc.reR}</td>
    </tr>
    <tr>
        <td class="td" bgcolor="#F3F3F3">
            <p align="center"><font color="black"><span style="font-size:9pt;">중점요청사항</span></font></p>
        </td>
        <td class="td">${getSuimSuit17DtlBsc.infoAe}</td>
        <td class="td">${getSuimSuit17DtlBsc.d20}</td>
        <td class="td">
            <p align="center">${getSuimSuit17DtlBsc.reT}</td>
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
			${getSuimSuit17DtlBsc.reG}급(${getSuimSuit17DtlBsc.d1})<br>            
			<p>판넬사용여부 (<c:if test="${getSuimSuit17DtlBsc.d2 eq '1'}">■ 유&nbsp; □ 무</c:if>
							<c:if test="${getSuimSuit17DtlBsc.d2 ne '1'}">□ 유&nbsp; ■ 무</c:if>
							/&nbsp;위치&nbsp;:&nbsp;${getSuimSuit17DtlBsc.d3})</p>
            <p>천막사용여부 (<c:if test="${getSuimSuit17DtlBsc.d4 eq '1'}">■ 유&nbsp; □ 무</c:if>
							<c:if test="${getSuimSuit17DtlBsc.d4 ne '1'}">□ 유&nbsp; ■ 무</c:if>
							/&nbsp;위치&nbsp;:&nbsp;${getSuimSuit17DtlBsc.d5})</p>
        </td>
    </tr>
    <tr>
        <td class="td" nowrap bgcolor="#F3F3F3" nowrap>
                                        <p align="center"><font color="black">방화구획</font></p>
        </td>
        <td class="td">
			<c:if test="${getSuimSuit17DtlBsc.reV eq 'Y'}">■ 구획&nbsp; □ 미구획</c:if>
			<c:if test="${getSuimSuit17DtlBsc.reV eq 'N'}">□ 구획&nbsp; ■ 미구획</c:if>
			<c:if test="${(getSuimSuit17DtlBsc.reV eq 'Y') && (getSuimSuit17DtlBsc.reV eq 'N')}">□ 구획&nbsp; □ 미구획</c:if></td>
    </tr>
    <tr>
        <td class="td" nowrap bgcolor="#F3F3F3" nowrap>
                                        <p align="center"><font color="black">확인의견</font></p>
        </td>
        <td class="td">${getSuimSuit17DtlBsc.reW}</td>
    </tr>
    <tr>
        <td class="td" bgcolor="#F3F3F3" rowspan="2" nowrap>
            <p align="center"><font color="black">업종</font></p>
        </td>
        <td class="td" bgcolor="#F3F3F3" nowrap>
                                        <p align="center"><font color="black">층별업종</font></p>
        </td>
        <td class="td">
           	 지층&nbsp;:&nbsp;${getSuimSuit17DtlBsc.d16}<br>
			1층&nbsp;:&nbsp;${getSuimSuit17DtlBsc.d8}<br>
			2층&nbsp;:&nbsp;${getSuimSuit17DtlBsc.d9}<br>
			3층&nbsp;:&nbsp;${getSuimSuit17DtlBsc.d10}<br>
			4층&nbsp;:&nbsp;${getSuimSuit17DtlBsc.d11}<br>
			5층&nbsp;:&nbsp;${getSuimSuit17DtlBsc.d12}<br>
			5층이상&nbsp;:&nbsp;${getSuimSuit17DtlBsc.d13}
        </td>
    </tr>
    <tr>
        <td class="td" bgcolor="#F3F3F3" nowrap>
                                        <p align="center"><font color="black">확인의견</font></p>
        </td>
        <td class="td">${getSuimSuit17DtlBsc.reK}</td>
    </tr>
    <tr>
        <td class="td" bgcolor="#F3F3F3" colspan="2" nowrap>
            <p align="center"><font color="black">소재지 확인의견</font></p>
        </td>
        <td class="td">${getSuimSuit17DtlBsc.reAc}</td>
    </tr>
    <tr>
        <td class="td" bgcolor="#F3F3F3" colspan="2" nowrap>
            <p align="center"><font color="black">기타 특이사항</font></p>
        </td>
        <td class="td">${getSuimSuit17DtlBsc.d17}</td>
    </tr>
</table>
<p>&nbsp;</p>
<p><font face="견고딕"><span style="font-size:14pt;">사진첨부</span></font></p>

	<center>
			<table border="1">
				<c:forEach items="${suimSuit17FileList}" var="fileVO">
				<tr>
					<td>
						<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www${fileVO.filePath}${fileVO.fileName}" width="650" height="400"/>
<%-- 						<img src="http://localhost:8090/home/hosting_users/toplac/www${fileVO.filePath}${fileVO.fileName}"/> --%>
					</td>
				</tr>
				</c:forEach>
			</table>
	</center>


</body>
</html>