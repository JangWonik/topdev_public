<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<!DOCTYPE html PUBLIC "-//W3C//Dth HTML 4.1 Transitional//EN" "http://www.w3.org/TR/html4/loose.dth">
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
			<p align="center">전화 : ${topTmBscVo.team_telephone} &nbsp;팩스 : ${topTmBscVo.team_fax} &nbsp;이메일 : ${mbrVoForBody.email}</p>
			<hr size="1" width="640" noshade color="black">
			<p>&nbsp;</p>
			<table align="center" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td width="50%">
						<p>Report No. ${getSuimSuit12DtlBsc.getSuimAcceptNo()}</p>
					</td>
					
					<td width="50%">
						<p align="right">Date. ${wordDate} </p>
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
						<p>: ${getSuimSuit12DtlBsc.ptnrName}</p>
					</td>
				</tr>
				<tr>
					<td width="16%" height="40">
						<p>참 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조</p>
					</td>
					<td width="84%">
						<p>:&nbsp;장기언더라이팅센터장</p>
					</td>
				</tr>
				<tr>
					<td width="16%" height="40">
						<p>계 &nbsp;&nbsp;&nbsp;약 &nbsp;&nbsp;&nbsp;자</p>
					</td>
					<td width="84%">
						<p>: ${getSuimSuit12DtlBsc.rqCrtNm}</p>
					</td>
				</tr>
			</table>
			<p>&nbsp;</p>
			<p>&nbsp;</p>
			<p>&nbsp;</p>
			<p align="left">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				귀사의 요청에 의거 상기 건에 대한 현장 계약 적부 실사 결과를 다음과 같이 보고합니다.
			</p>
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
						<p>: ${getSuimSuit12DtlBsc.userName}</p>
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
<p align="center"><font face="견고딕"><span style="font-size:14pt;">실사보고서 (일반)</span></font></p>
<p>&nbsp;</p>
<p><span style="font-size:14pt;"><b>1. 보험계약사항</b></span></p>
						<table align="center" cellpadding="0" cellspacing="0" width="600">
							<colgroup>
									<col width="15%">
									<col width="35%">
									<col width="15%">
									<col width="35%">
								</colgroup>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black"><b>계약자</b></font></p>
									</td>
									<td class="td">
										<p>${getSuimSuit12DtlBsc.rqCrtNm}</p>
									</td>
									
									
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black"><b>계약일</b></font></p>
									</td>
									
									<td class="td">
										<p>${getSuimSuit12DtlBsc.rqCnrDt}</p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black"><b>설계번호</b></font></p>
									</td>
									<td class="td">
										<p>${getSuimSuit12DtlBsc.rqPlNo}</p>
									</td>
									<td class="td" nowrap bgcolor="#F3F3F3" >
										<p align="center"><font color="black"><b>증권번호</b></font></p>
									</td>
									<td class="td">
										<p>${getSuimSuit12DtlBsc.rqPlyNo}</p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black"><b>증권명</b></font></p>
									</td>
									<td class="td" colspan="3">
										<p>${getSuimSuit12DtlBsc.rqGdNm}</p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black"><b>위임일자</b></font></p>
									</td>
									<td class="td">
										<p>${getSuimSuit12DtlBsc.rqPptyRqDt}</p>
									</td>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black"><b>처리구분</b></font></p>
									</td>
									<td class="td"><p>
										<c:if test="${getSuimSuit12DtlBsc.rqDlFlgCd eq '01'}">사전의뢰</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rqDlFlgCd eq '02'}">사후의뢰</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rqDlFlgCd eq '03'}">취소</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rqDlFlgCd eq '' || getSuimSuit12DtlBsc.rqDlFlgCd eq '0'}"></c:if></p>
									</td>
								</tr>
						</table>
						<p>&nbsp;</p>
						<p><span style="font-size:14pt;"><b>2. 조사결과</b></span></p>
						<table align="center" cellpadding="0" cellspacing="0" width="600">
							<colgroup>
									<col width="40%">
									<col width="10%">
									<col width="40%">
									<col width="10%">
								</colgroup>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">완료여부</font></p>
									</td>
									<td class="td"><p>
										<c:if test="${getSuimSuit12DtlBsc.rstPptyNvCpltYn eq '1'}">완료</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rstPptyNvCpltYn eq '2'}">미수검</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rstPptyNvCpltYn eq '' || getSuimSuit12DtlBsc.rstPptyNvCpltYn eq '0'}"></c:if></p>
									</td>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">조사결과</font></p>
									</td>
									<td class="td"><p>
										<c:if test="${getSuimSuit12DtlBsc.rstNvRst eq '01'}">양호(일치)</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rstNvRst eq '02'}">수정필요(불일치)</c:if>
										<c:if test="${getSuimSuit12DtlBsc.rstNvRst eq '' || getSuimSuit12DtlBsc.rstNvRst eq '0'}"></c:if></p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">조사자의견</font></p>
									</td>
									<td class="td" colspan="3"><p>
										${getSuimSuit12DtlBsc.rstNvRstCtn}</p>
									</td>
								</tr>
						</table>
						<p>&nbsp;</p>
						<p><span style="font-size:14pt;"><b>3. 건물계약확인사항</b></span></p>
						<p>&nbsp;</p>
					<c:forEach items="${getSuimSuit12DtlBldList}" var="getSuimSuit12DtlBld" varStatus="status">
						<p style="font-weight:bold;">
							${status.count}) 건물 ${status.count} 확인사항
						</p>
						<table align="center" cellpadding="0" cellspacing="0" width="600">
							<colgroup>
									<col width="12%">
									<col width="12%">
									<col width="12%">
									<col width="31%">
									<col width="13%">
								</colgroup>
								<tr>
									<td class="td" bgcolor="#F3F3F3">
										<p align="center"><font color="black">실사자</font></p>
									</td>
									<td class="td" bgcolor="#F3F3F3">
										<p align="center"><font color="black">실사일</font></p>
									</td>
									<td class="td" bgcolor="#F3F3F3">
										<p align="center"><font color="black">면담자</font></p>
									</td>
									<td class="td" bgcolor="#F3F3F3">
										<p align="center"><font color="black">계약자와의관계</font></p>
									</td>
									<td class="td" bgcolor="#F3F3F3">
										<p align="center"><font color="black">연락처</font></p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap>
										<p align="center">${getSuimSuit12DtlBsc.userName}</p>
									</td>
									<td class="td">
										<p align="center">${getSuimSuit12DtlBld.getRstBld_RcnDt()}</p>
									</td>
									<td class="td">
										<p align="center">${getSuimSuit12DtlBld.getRstBld_InvpsNm()}</p>
									</td>
									<td class="td">
										<p align="center">${getSuimSuit12DtlBld.getRstBld_CrRelpcRel()}</p>
									</td>
									<td class="td">
										<p align="center">${getSuimSuit12DtlBld.getRstBld_InvpsCntAd()}</p>
									</td>
								</tr>
						</table>
						<p style="line-height:50%; margin-top:0; margin-bottom:0;">&nbsp;</p>
						<table align="center" cellpadding="0" cellspacing="0" width="600">
							<colgroup>
									<col width="15%">
									<col width="55%">
									<col width="15%">
									<col width="15%">
								</colgroup>
								<tr>
									<td class="td" bgcolor="#F3F3F3">
										<p align="center"><font color="black">구분</font></p>
									</td>
									<td class="td" bgcolor="#F3F3F3">
										<p align="center"><font color="black">계약내용</font></p>
									</td>
									<td class="td" bgcolor="#F3F3F3">
										<p align="center"><font color="black">일치여부</font></p>
									</td>
									<td class="td" bgcolor="#F3F3F3">
										<p align="center"><font color="black">기타의견</font></p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">실소유자</font></p>
									</td>
									<td class="td">
										<p>${getSuimSuit12DtlBld.getRqBld_RlOwrNm()}</p>
									</td>
									<td class="td"><p align="center">
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RlOwrNm() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RlOwrNm() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RlOwrNm() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RlOwrNm() eq '0'}"></c:if></p>
									</td>
									<td class="td">
<%-- 										<p><c:if test="${getSuimSuit12DtlBld.getRstBld_RlOwrNmEtMtt() eq '0'}"></c:if></p> --%>
										<p>${getSuimSuit12DtlBld.getRstBld_RlOwrNmEtMtt()}</p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">소재지</font></p>
									</td>
									<td class="td">
										<p>${getSuimSuit12DtlBld.getRqBld_CtnAdr()}</p>
									</td>
									<td class="td"><p align="center">
										<c:if test="${getSuimSuit12DtlBld.getRstBld_CtnAdr() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_CtnAdr() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_CtnAdr() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_CtnAdr() eq '0'}"></c:if></p>
									</td>
									<td class="td">
<%-- 										<p><c:if test="${getSuimSuit12DtlBld.getRstBld_CtnAdr() eq '0'}"></c:if></p> --%>
										<p>${getSuimSuit12DtlBld.getRstBld_CtnAdrEtMtt()}</p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">건물 급수</font></p>
									</td>
									<td class="td">
										<p>${getSuimSuit12DtlBld.getRqBld_BldRnkCd()}</p>
									</td>
									<td class="td"><p align="center">
										<c:if test="${getSuimSuit12DtlBld.getRstBld_BldRnkCd() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_BldRnkCd() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_BldRnkCd() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_BldRnkCd() eq '0'}"></c:if></p>
									</td>
									<td class="td">
<%-- 										<p><c:if test="${getSuimSuit12DtlBld.getRstBld_BldRnkcdEtMtt() eq '0'}"></c:if></p> --%>
										<p>${getSuimSuit12DtlBld.getRstBld_BldRnkcdEtMtt()}</p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">영위업종</font></p>
									</td>
									<td class="td">
										<p>${getSuimSuit12DtlBld.getRqBld_MngmBnNm()}</p>
									</td>
									<td class="td"><p align="center">
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MngmBnNm() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MngmBnNm() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MngmBnNm() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MngmBnNm() eq '0'}"></c:if></p>
									</td>
									<td class="td">
<%-- 										<p><c:if test="${getSuimSuit12DtlBld.getRstBld_MngmBnnmEtMtt() eq '0'}"></c:if></p> --%>
										<p>${getSuimSuit12DtlBld.getRstBld_MngmBnnmEtMtt()}</p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">건물 기둥</font></p>
									</td>
									<td class="td">
										<p>${getSuimSuit12DtlBld.getRqBld_PleNm()}</p>
									</td>
									<td class="td"><p align="center">
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PleNm() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PleNm() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PleNm() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PleNm() eq '0'}"></c:if></p>
									</td>
									<td class="td">
										<p></p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">건물 지붕</font></p>
									</td>
									<td class="td">
										<p>${getSuimSuit12DtlBld.getRqBld_RofNm()}</p>
									</td>
									<td class="td"><p align="center">
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RofNm() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RofNm() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RofNm() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_RofNm() eq '0'}"></c:if></p>
									</td>
									<td class="td">
										<p></p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">건물 외벽</font></p>
									</td>
									<td class="td">
										<p>${getSuimSuit12DtlBld.getRqBld_WllNm()}</p>
									</td>
									<td class="td"><p align="center">
										<c:if test="${getSuimSuit12DtlBld.getRstBld_WllNm() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_WllNm() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_WllNm() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_WllNm() eq '0'}"></c:if></p>
									</td>
									<td class="td">
										<p></p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">지상(층)</font></p>
									</td>
									<td class="td">
										<p>${getSuimSuit12DtlBld.getRqBld_Grod()}</p>
									</td>
									<td class="td"><p align="center">
										<c:if test="${getSuimSuit12DtlBld.getRstBld_GrodEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_GrodEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_GrodEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_GrodEqalYn() eq '0'}"></c:if></p>
									</td>
									<td class="td">
<%-- 										<p><c:if test="${getSuimSuit12DtlBld.getRstBld_GrodEtMtt() eq '0'}"></c:if></p> --%>
										<p>${getSuimSuit12DtlBld.getRstBld_GrodEtMtt()}</p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">지하(층)</font></p>
									</td>
									<td class="td">
										<p>${getSuimSuit12DtlBld.getRqBld_Undg()}</p>
									</td>
									<td class="td"><p align="center">
										<c:if test="${getSuimSuit12DtlBld.getRstBld_UndgEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_UndgEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_UndgEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_UndgEqalYn() eq '0'}"></c:if></p>
									</td>
									<td class="td">
<%-- 										<p><c:if test="${getSuimSuit12DtlBld.getRstBld_UndgEtMtt() eq '0'}"></c:if></p> --%>
										<p>${getSuimSuit12DtlBld.getRstBld_UndgEtMtt()}</p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">연면적</font></p>
									</td>
									<td class="td">
										<p>${getSuimSuit12DtlBld.getRqBld_Ttare()}</p>
									</td>
									<td class="td"><p align="center">
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TtareEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TtareEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TtareEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TtareEqalYn() eq '0'}"></c:if></p>
									</td>
									<td class="td">
<%-- 										<p><c:if test="${getSuimSuit12DtlBld.getRstBld_TtareEtMtt() eq '0'}"></c:if></p> --%>
										<p>${getSuimSuit12DtlBld.getRstBld_TtareEtMtt()}</p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">가입면적</font></p>
									</td>
									<td class="td">
										<p>${getSuimSuit12DtlBld.getRqBld_IsAre()}</p>
									</td>
									<td class="td"><p align="center">
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsAreEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsAreEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsAreEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsAreEqalYn() eq '0'}"></c:if></p>
									</td>
									<td class="td">
<%-- 										<p><c:if test="${getSuimSuit12DtlBld.getRstBld_IsAreEtMtt() eq '0'}"></c:if></p> --%>
										<p>${getSuimSuit12DtlBld.getRstBld_IsAreEtMtt()}</p>
									</td>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">가입유형</font></p>
									</td>
									<td class="td"><p>
										<c:if test="${getSuimSuit12DtlBld.getRqBld_IsTp() eq '01'}">전치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRqBld_IsTp() eq '02'}">일부</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRqBld_IsTp() eq '' || getSuimSuit12DtlBld.getRqBld_IsTp() eq '0'}"></c:if></p>
									</td>
									<td class="td"><p align="center">
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsTpEqalYn() eq '1'}">일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsTpEqalYn() eq '2'}">불일치</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsTpEqalYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsTpEqalYn() eq '0'}"></c:if></p>
									</td>
									<td class="td"><p>
<%-- 										<c:if test="${getSuimSuit12DtlBld.getRstBld_IsTpEqalYn() eq '0'}"></c:if></p> --%>
										<p>${getSuimSuit12DtlBld.getRstBld_IsTpEtMtt()}</p>
										
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">판넬 유무</font></p>
									</td>
									<td class="td">
										<p></p>
									</td>
									<td class="td"><p align="center">
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PanlYn() eq '1'}">유</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PanlYn() eq '2'}">무</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PanlYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_PanlYn() eq '0'}"></c:if></p>
									</td>
									<td class="td"><p>
<%-- 										<c:if test="${getSuimSuit12DtlBld.getRstBld_PanlPst() eq '0'}"></c:if></p> --%>
										<p>${getSuimSuit12DtlBld.getRstBld_PanlPst()}</p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">천막 유무</font></p>
									</td>
									<td class="td">
										<p></p>
									</td>
									<td class="td"><p align="center">
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TntYn() eq '1'}">유</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TntYn() eq '2'}">무</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TntYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_TntYn() eq '0'}"></c:if></p>
									</td>
									<td class="td"><p>
<%-- 										<c:if test="${getSuimSuit12DtlBld.getRstBld_TntPst() eq '0'}"></c:if></p> --%>
										<p>${getSuimSuit12DtlBld.getRstBld_TntPst()}</p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">방화구획</font></p>
									</td>
									<td class="td">
										<p></p>
									</td>
									<td class="td"><p align="center">
										<c:if test="${getSuimSuit12DtlBld.getRstBld_FlrFirZoneYn() eq '1'}">유</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_FlrFirZoneYn() eq '2'}">무</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_FlrFirZoneYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_FlrFirZoneYn() eq '0'}"></c:if></p>
									</td>
									<td class="td">
										<p></p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">확인의견</font></p>
									</td>
									<td class="td" colspan="3">
										<p>${getSuimSuit12DtlBld.getRstBld_EtMtt1()}</p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">상설할인</font></p>
									</td>
									<td class="td">
										<p></p>
									</td>
									<td class="td"><p align="center">
										<c:if test="${getSuimSuit12DtlBld.getRstBld_SlEqmtDcYn() eq '1'}">유</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_SlEqmtDcYn() eq '2'}">무</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_SlEqmtDcYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_SlEqmtDcYn() eq '0'}"></c:if></p>
									</td>
									<td class="td">
										<p></p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">재래시장</font></p>
									</td>
									<td class="td">
										<p></p>
									</td>
									<td class="td"><p align="center">
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MrkYn() eq '1'}">유</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MrkYn() eq '2'}">무</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MrkYn() eq '3'}">미확인</c:if>
										<c:if test="${getSuimSuit12DtlBld.getRstBld_MrkYn() eq '0'}"></c:if></p>
									</td>
									<td class="td">
										<p></p>
									</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center"><font color="black">층별업종</font></p>
									</td>
									<td class="td" colspan="3">
									<table cellpadding="0" cellspacing="0">
										<tr>
											<td nowrap>
												<p>지하 :</p>
											</td>
											<td>
												<p>${getSuimSuit12DtlBld.getRstBld_FlrBtpUndg()}</p>
											</td>
										</tr>
										<tr>
											<td>
												<p>1 층 :</p>
											</td>
											<td>
												<p>${getSuimSuit12DtlBld.getRstBld_FlrBtpFloor1()}</p>
											</td>
										</tr>
										<tr>
											<td>
												<p>2 층 :</p>
											</td>
											<td>
												<p>${getSuimSuit12DtlBld.getRstBld_FlrBtpFloor2()}</p>
											</td>
										</tr>
										<tr>
											<td>
												<p>3 층 :</p>
											</td>
											<td>
												<p>${getSuimSuit12DtlBld.getRstBld_FlrBtpFloor3()}</p>
											</td>
										</tr>
									</table>
								</td>
								</tr>
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3">
										<p align="center">종합의견</p>
									</td>
									<td class="td" colspan="3">
										<p>${getSuimSuit12DtlBld.getRstBld_EtMtt2()}</p>
									</td>
								</tr>
						</table>
						</c:forEach>
						<p>&nbsp;</p>
						<p><span style="font-size:14pt;"><b>4. 목적물 확인사항</b></span></p>
						<table align="center" cellpadding="0" cellspacing="0" width="600">
							<tr>
								<td bgcolor="#F3F3F3" class="td" width="80">
									<p align="center"><B><font color="black">목적물</font></B></p>
								</td>
								<td bgcolor="#F3F3F3" class="td" width="520">
									<p align="center"><B><font color="black">확인사항</font></B></p>
								</td>
							</tr>
								<colgroup>
									<col width="10%">
									<col width="10%">
									<col width="40%">
									<col width="40%">
								</colgroup>
							<c:forEach items="${getSuimSuit12DtlOjList}" var="getSuimSuit12DtlOj" varStatus="status">
								<tr>
									<td class="td" nowrap bgcolor="#F3F3F3" width="80">
										<p align="center"><font color="black">목적물 ${status.index + 1}</font></p>
									</td>
									<td class="td" width="520">
		                                <table cellpadding="0" cellspacing="0" width="505">
				                           	<tr>
				                                <td width="80" height="25">
				                                    <p>유 &nbsp;&nbsp;&nbsp;형</p>
				                                </td>
				                                <td width="380">
				                                	<p>${getSuimSuit12DtlOj.getRqOj_OjTp()}</p>
				                                </td>
				                                <td width="45">						
				                                	<p align="center">
													<c:if test="${getSuimSuit12DtlOj.getRstOj_OjTpEqalYn() eq '1'}">일치</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRstOj_OjTpEqalYn() eq '2'}">불일치</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRstOj_OjTpEqalYn() eq '3'}">미확인</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRstOj_OjTpEqalYn() eq '0'}"></c:if></p>
				                                </td>
				                               </tr>
				                               <tr>
				                                   <td width="80" height="25">
				                                       <p>급&nbsp;&nbsp;&nbsp;&nbsp;수</p>
				                                   </td>
				                                   <td width="380">
				                                   	<p>${getSuimSuit12DtlOj.getRqOj_Rnk()}</p>
				                                   </td>
				                                   <td width="45">						
				                                   	<p align="center">
													<c:if test="${getSuimSuit12DtlOj.getRstOj_RnkEqalYn() eq '1'}">일치</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRstOj_RnkEqalYn() eq '2'}">불일치</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRstOj_RnkEqalYn() eq '3'}">미확인</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRstOj_RnkEqalYn() eq '0'}"></c:if></p>
				                                   </td>
				                               </tr>
				                               <tr>
				                                   <td width="80" height="25">
				                                       <p>수용구분</p>
				                                   </td>
				                                   <td width="380">
				                                   	<p>
				                                   	<c:if test="${getSuimSuit12DtlOj.getRqOj_AccptPlcFlgCd() eq '01'}">건물내</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRqOj_AccptPlcFlgCd() eq '02'}">건물밖(야적)</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRqOj_AccptPlcFlgCd() eq ''}"></c:if></p>
				                                   </td>
				                                   <td width="45">						
				                                   	<p align="center">
													<c:if test="${getSuimSuit12DtlOj.getRstOj_AccptPlcFlgcdEqalYn() eq '1'}">일치</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRstOj_AccptPlcFlgcdEqalYn() eq '2'}">불일치</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRstOj_AccptPlcFlgcdEqalYn() eq '3'}">미확인</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRstOj_AccptPlcFlgcdEqalYn() eq '0'}"></c:if></p>
				                                   </td>
				                               </tr>
				                               <tr>
				                                   <td width="80" height="25">
				                                       <p>야적물건</p>
				                                   </td>
				                                   <td width="380">
				                                   	<p>
				                                   	<c:if test="${getSuimSuit12DtlOj.getRqOj_FldstObjFlgCd() eq '1'}">가연성</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRqOj_FldstObjFlgCd() eq '2'}">불연성</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRqOj_FldstObjFlgCd() eq ''}"></c:if></p>
				                                   </td>
				                                   <td width="45">						
				                                   	<p align="center">
													<c:if test="${getSuimSuit12DtlOj.getRstOj_FldstObjFlgcdEqalYn() eq '1'}">일치</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRstOj_FldstObjFlgcdEqalYn() eq '2'}">불일치</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRstOj_FldstObjFlgcdEqalYn() eq '3'}">미확인</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRstOj_FldstObjFlgcdEqalYn() eq '0'}"></c:if></p>
				                                   </td>
				                               </tr>
				                               <tr>
				                                   <td width="80" height="25">
				                                       <p>지하수용</p>
				                                   </td>
				                                   <td width="380">
				                                   	<p>
				                                   	<c:if test="${getSuimSuit12DtlOj.getRqOj_UndgAccptYn() eq '1'}">수용</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRqOj_UndgAccptYn() eq '2'}">수용안함</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRqOj_UndgAccptYn() eq ''}"></c:if></p>
				                                   </td>
				                                   <td width="45">						
				                                   	<p align="center">
													<c:if test="${getSuimSuit12DtlOj.getRstOj_UndgAccptYnEqalYn() eq '1'}">일치</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRstOj_UndgAccptYnEqalYn() eq '2'}">불일치</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRstOj_UndgAccptYnEqalYn() eq '3'}">미확인</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRstOj_UndgAccptYnEqalYn() eq '0'}"></c:if></p>
				                                   </td>
				                               </tr>
				                               <tr>
				                                   <td width="80" height="25">
				                                       <p>세부사항</p>
				                                   </td>
				                                   <td width="380">
				                                   	<p>${getSuimSuit12DtlOj.getRqOj_Dt_Mtt()}</p>
				                                   </td>
				                                   <td width="45">						
				                                   	<p align="center">
													<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_MttEqalYn() eq '1'}">일치</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_MttEqalYn() eq '2'}">불일치</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_MttEqalYn() eq '3'}">미확인</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_MttEqalYn() eq '0'}"></c:if></p>
				                                   </td>
				                               </tr>
				                               <tr>
				                                   <td width="80" height="25">
				                                       <p>수용장소</p>
				                                   </td>
				                                   <td width="380">
				                                   	<p>${getSuimSuit12DtlOj.getRqOj_Dt_AccptPlc()}</p>
				                                   </td>
				                                   <td width="45">						
				                                   	<p align="center">
													<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_AccptPlcEqalYn() eq '1'}">일치</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_AccptPlcEqalYn() eq '2'}">불일치</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_AccptPlcEqalYn() eq '3'}">미확인</c:if>
													<c:if test="${getSuimSuit12DtlOj.getRstOj_Dt_AccptPlcEqalYn() eq '0'}"></c:if></p>
				                                   </td>
			                       			  </tr>
		                             	</table>
			                         </td>
			                    </tr>
			                    </c:forEach>
						</table>
						<br/>
						<br/>
						<c:forEach items="${suimSuit12FileList}" var="FileVO" varStatus="status">
							<img src="https://toplac.co.kr/home/hosting_users/toplac/www${FileVO.getFilePath()}${FileVO.getFileName()}" width="650" height="400"/><br/><br/>
						</c:forEach>

				</body>
			</html>