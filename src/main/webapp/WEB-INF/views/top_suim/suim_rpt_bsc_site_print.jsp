<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
 
<script src="./resources/jquery/jquery.min_1_12.js"></script>
<style>
<!--
p {color:#000000; font-size:10pt; line-height:130%; margin-top:0; margin-bottom:0; font-family:돋움,돋움체;}
table {border-collapse:collapse;border-spacing:0; color:#000000; font-size:10pt; line-height:130%; margin-top:0; margin-bottom:0; font-family:돋움,돋움체;}
.td {border:1px solid #666666; padding:3px; color:#000000; font-size:10pt; line-height:130%; margin-top:0; margin-bottom:0; font-family:돋움,돋움체;}
H2.breakhere {page-break-before: always}
body{margin-left:0;margin-right:0;margin-top:0;margin-bottom:0;}
-->
</style>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<table cellpadding="0" cellspacing="0" width="100%" align="center" height="900">
	<tr>
		<td width="100%" valign="top" height="100%">
			<table cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td width="50%">
						<p>
							<img src="https://www.toplac.co.kr/resources/ls_img/report/head_site_txt1.jpg" width="205" height="56" border="0">
						</p>
						
					</td>
					<td width="50%">
						<p align="right"><img src="https://www.toplac.co.kr/resources/ls_img/report/head_site_logo.jpg" width="190" height="56" border="0"></p>
					</td>
				</tr>
				<tr>
					<td width="100%" height="1" colspan="2" bgcolor="#777777"></td>
				</tr>
			</table>
			<p>&nbsp;</p>
			<table cellpadding="0" cellspacing="0" width="100%" align="center">
				<tr>
					<td width="50%">
						<p style="line-height:150%;"><b><u><span style="font-size:11pt;">Report No. ${suimListDtl.suimAcceptNo }</span></u></b></p>
					</td>
					<td width="50%">
						<p style="line-height:150%;" align="right"><b><span style="font-size:11pt;"><u>Date. ${suimRptSiteVo.siteDate}</u></span></b></p>
					</td>
				</tr>
			</table>
			<p>&nbsp;</p>
			<table cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td width="14%" class="td" bgcolor="#CECFFF">
						<p align="center">수&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신</p>
					</td>
					<td width="36%" class="td">
						<p>${suimListDtl.ptnrName}</p>
					</td>
					<td width="14%" class="td" bgcolor="#CECFFF">
						<p align="center">수 임 일 시</p>
					</td>
					<td width="36%" class="td">
						<p>${suimListDtl.regDate}</p>
					</td>
				</tr>
				<tr>
					<td width="14%" class="td" bgcolor="#CECFFF">
						<p align="center">참&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조</p>
					</td>
					<td width="36%" class="td">
                        <p>${suimRptSiteVo.siteChamjo}</p>
					</td>
					<td width="14%" class="td" bgcolor="#CECFFF">
						<p align="center">사 고 번 호</p>
					</td>
					<td width="36%" class="td">
						<p>${suimListDtl.accidentNo}</p>
					</td>
				</tr>
				<tr>
					<td width="14%" class="td" bgcolor="#CECFFF">
						<p align="center">보험사담당</p>
					</td>
					<td width="36%" class="td">
                        <p>
                        	${suimListDtl.ptnrMbrNm} ${suimListDtl.ptnrMbrPositionNm4edit} 
                        	☎  ${suimListDtl.ptnr_mbr_office_tel}
                        </p>
					</td>
					<td width="14%" class="td" bgcolor="#CECFFF">
						<p align="center">손 사 담 당</p>
					</td>
					<td width="36%" class="td">
						<p>
							${suimListDtl.userName}  
                        	☎  ${suimListDtl.rptUserHp}
                        </p>
					</td>
				</tr>
			</table>
			<p>&nbsp;</p>
			<p style="line-height:200%;"><b><span style="font-size:11pt;">◆ 계약사항</span></b></p>
			<table cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td width="14%" class="td" bgcolor="#CECFFF">
						<p align="center">보 험 종 목</p>
					</td>
					<td width="36%" class="td">
						<p>${suimListDtl.insuranceNm}</p>
					</td>
					<td width="14%" class="td" bgcolor="#CECFFF">
						<p align="center">증 권 번 호</p>
					</td>
					<td width="36%" class="td">
						<p>${suimListDtl.policyNo}</p>
					</td>
				</tr>
				<tr>
					<td width="14%" class="td" bgcolor="#CECFFF">
						<p align="center">계&nbsp;&nbsp;약&nbsp;&nbsp;자</p>
					</td>
					<td width="36%" class="td">
						<p>${suimListDtl.policyholderNm}</p>
					</td>
					<td width="14%" class="td" bgcolor="#CECFFF">
						<p align="center">피 보 험 자</p>
					</td>
					<td width="36%" class="td">
						<p>${suimListDtl.beneficiaryNm}</p>
					</td>
				</tr>
				<tr>
                    <td width="14%" class="td" bgcolor="#CECFFF">
                        <p align="center">보 험 기 간</p>
                    </td>
                    <td width="36%" class="td">
						<p>${suimListDtl.insuTerm}</p>
                    </td>
                    <td width="14%" class="td" bgcolor="#CECFFF">
                        <p align="center">보상한도액</p>
                    </td>
                    <td width="36%" class="td">
						<p><c:out value="${suimListDtl.compensationLimitUnit}"/> <fmt:formatNumber value="${suimListDtl.amtCompensationLimit}" pattern="###,###,##0.##"/>
						
						(
						<c:choose>
							<c:when test="${suimRptSiteVo.compensationLimitFlag eq 0}">
								1사고당
							</c:when>
							<c:when test="${suimRptSiteVo.compensationLimitFlag eq 1}">
								1청구당
							</c:when>
							<c:when test="${suimRptSiteVo.compensationLimitFlag eq 2}">
								1인당
							</c:when>
							<c:otherwise>
								${suimRptSiteVo.compensationLimitEtcAmt}
							</c:otherwise>
						</c:choose>
						
						)
						
						</p>
                    </td>
                </tr>
                <tr>
                    <td width="14%" class="td" bgcolor="#CECFFF">
                        <p align="center">담 보 사 항</p>
                    </td>
                    <td width="36%" class="td">
						<p>${suimListDtl.insuMortgage}</p>
                    </td>
                    <td width="14%" class="td" bgcolor="#CECFFF">
                        <p align="center">자기부담금</p>
                    </td>
                    <td width="36%" class="td">
						<p><c:out value="${suimListDtl.selfPayLimitUnit}"/> <fmt:formatNumber value="${suimListDtl.amtSelfPay}" pattern="###,###,##0.##"/>
						
						(
							<c:choose>
								<c:when test="${suimRptSiteVo.selfPayFlag eq 0}">
									1사고당
								</c:when>
								<c:when test="${suimRptSiteVo.selfPayFlag eq 1}">
									1청구당
								</c:when>
								<c:when test="${suimRptSiteVo.selfPayFlag eq 2}">
									1인당
								</c:when>
								<c:otherwise>
									${suimRptSiteVo.selfPayEtcAmt}
								</c:otherwise>
							</c:choose>
						)
						
						</p>
                    </td>
                </tr>
            </table>
            <p>&nbsp;</p>
            <p style="line-height:200%;"><b><span style="font-size:11pt;">◆ 사고사항</span></b></p>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="14%" class="td" bgcolor="#CECFFF">
                        <p align="center">사 고 일 시</p>
                    </td>
                    <td width="36%" class="td">
						<p>${suimListDtl.accidentDate}</p>
                    </td>
                    <td width="14%" class="td" bgcolor="#CECFFF">
                        <p align="center">사 고 장 소</p>
                    </td>
                    <td width="36%" class="td">
                        <p>${suimListDtl.investigateAddr1} ${suimListDtl.investigateAddr2}</p>
                    </td>
                </tr>
                <tr>
                    <td width="14%" class="td" bgcolor="#CECFFF" height="60">
                        <p align="center">사 고 내 용</p>
                    </td>
                    <td width="86%" colspan="3" class="td" valign="top">
						<p>${suimListDtl.accidentFacts}</p>
                    </td>
                </tr>
                <tr>
                    <td width="14%" class="td" bgcolor="#CECFFF">
                        <p align="center">피 해 사 항</p>
                    </td>
                    <td width="86%" colspan="3" class="td">
						<p>${suimListDtl.damagedFacts}</p>
                    </td>
                </tr>
                <tr>
                    <td width="14%" class="td" bgcolor="#CECFFF">
                        <p align="center">면&middot;부책관련</p>
                    </td>
                    <td width="36%" class="td">
						<p>
							<c:choose>
								<c:when test="${suimRptSiteVo.exemptionFlag eq 0 }">
									없음
								</c:when>
								<c:when test="${suimRptSiteVo.exemptionFlag eq 1 }">
									부책
								</c:when>
								<c:when test="${suimRptSiteVo.exemptionFlag eq 2 }">
									면책
								</c:when>
								<c:when test="${suimRptSiteVo.exemptionFlag eq 3 }">
									판단보류
								</c:when>
							</c:choose>
							/ 피해자 과실 : ${suimRptSiteVo.damagedNegligence}%
						</p>
                    </td>
                    <td width="14%" class="td" bgcolor="#CECFFF">
                        <p align="center">추정손해액</p>
                    </td>
                    <td width="36%" class="td">
						<p>￦ <fmt:formatNumber value="${suimListDtl.amtEstimatedDamage}" pattern="###,###,##0.##"/> ( 분류 :
							<c:choose>
								<c:when test="${suimRptSiteVo.dmgCtgr eq 0 }">
									없음
								</c:when>
								<c:when test="${suimRptSiteVo.dmgCtgr eq 1 }">
									대인
								</c:when>
								<c:when test="${suimRptSiteVo.dmgCtgr eq 2 }">
									대물
								</c:when>
								<c:when test="${suimRptSiteVo.dmgCtgr eq 3 }">
									대물,대인 합산
								</c:when>
								<c:when test="${suimRptSiteVo.dmgCtgr eq 4 }">
									재물
								</c:when>
								<c:when test="${suimRptSiteVo.dmgCtgr eq 9 }">
									${suimRptSiteVo.dmgCtgrEtcNm}
								</c:when>
							</c:choose>
						)</p>
                    </td>
                </tr>
            </table>
			<p>&nbsp;</p>
			
			<c:if test="${sagoList ne null }">			
				<p style="line-height:200%;"><b><span style="font-size:11pt;">◆ 사고처리과정표 or 일자별진행경과</span></b></p>
				<table cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td bgcolor="#CECFFF" class="td" width="14%">
							<p align="center"><b>일 &nbsp;&nbsp;&nbsp;&nbsp;자</b></p>
						</td>
						<td bgcolor="#CECFFF" class="td" width="14%">
							<p align="center"><b>항 &nbsp;&nbsp;&nbsp;&nbsp;목</b></p>
						</td>
						<td bgcolor="#CECFFF" class="td" width="72%">
							<p align="center"><b>처 리 내 용</b></p>
						</td>
					</tr>
					<c:forEach items="${sagoList}" var="sagoVo">
						<tr>
							<td class="td" nowrap>
								<p align="center">
									${sagoVo.regDate}
								</p>
							</td>
							<td class="td" nowrap>
								<p align="center">
									${sagoVo.item}
								</p>
							</td>
							<td class="td">
								<p align="center">
									${sagoVo.content}
								</p>
							</td>
						</tr>
					</c:forEach>	
				</table>
			</c:if>
			
			<p>&nbsp;</p>
            <p style="line-height:200%;"><b><span style="font-size:11pt;">◆ 문제점 및 향후처리방안</span></b></p>
            <table cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td width="14%" class="td" bgcolor="#CECFFF" height="95">
						<p align="center">진 행 사 항</p>
						<p align="center">및</p>
						<p align="center">문&nbsp;&nbsp;제&nbsp;&nbsp;점</p>
                    </td>
                     <td width="86%" class="td" valign="top">
						<c:forEach var="prbList" items="${probList}" varStatus="probStatus">
							<c:if test="${probStatus.last}">
										${prbList.prb_memo}
							</c:if>
						</c:forEach>
                    </td>
                </tr>
                <tr>
                    <td width="14%" class="td" bgcolor="#CECFFF" nowrap height="95">
                        <p align="center">향후처리방안</p>
                    </td>
                    <td width="86%" class="td" valign="top">
						<c:forEach var="plnList" items="${planList}" varStatus="planStatus">
							<c:if test="${planStatus.last}">
										${plnList.pln_memo}
							</c:if>
						</c:forEach>
                    </td>
                </tr>
            </table>
            <p>&nbsp;</p>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="14%" class="td" bgcolor="#CECFFF">
                        <p align="center">첨 부 자 료</p>
                    </td>
                    <td width="86%" class="td">
						<p>${suimRptSiteVo.memoAttach}</p>
                    </td>
                </tr>
            </table>
		</td>
	</tr>
</table>
<p>&nbsp;</p>
<table cellpadding="0" cellspacing="0" width="100%" align="center" height="75">
	<tr>
		<td width="100%" height="100%">
			<p style="line-height:100%;" align="right"><b><span style="font-size:14pt;">탑손해사정주식회사</span></b></p>
			<p style="line-height:0%;" align="center"><hr size="2" noshade color="black"></p>
			<table cellpadding="0" cellspacing="0" width="100%" align="center">
				<tr>
					<td>
						<p>담당자번호 : ${suimListDtl.rptUserHp}</p>
						<p>담당자팩스 : ${suimListDtl.officeFax}</p>
					</td>
					<td>
						<p align="right">본 보고서는 직인이 생략된 양식입니다.</p>
						<p align="right">발행일시/문서번호 : ${suimRptSiteVo.siteDate} / ${suimRptSiteVo.siteReportId} </p>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<c:if test="${suimRptSiteImgListLength ne 0 }">
<table cellpadding="0" cellspacing="0" width="100%" align="center" height="900">
	<tr>
		<td width="100%" valign="top" height="100%">
			<table cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td width="50%">
						<p><img src="https://www.toplac.co.kr/resources/ls_img/report/head_site_txt2.jpg" width="262" height="56" border="0"></p>
					</td>
					<td width="50%">
						<p align="right"><img src="https://www.toplac.co.kr/resources/ls_img/report/head_site_logo.jpg" width="190" height="56" border="0"></p>
					</td>
				</tr>
				<tr>
					<td width="100%" height="1" colspan="2" bgcolor="#777777"></td>
				</tr>
			</table>
			<p>&nbsp;</p>
			<table cellpadding="0" cellspacing="0" width="100%" align="center">
				<tr>
					<td width="50%">
						<p style="line-height:150%;"><b><u><span style="font-size:11pt;">Report No. ${suimListDtl.suimAcceptNo } </span></u></b></p>
					</td>
					<td width="50%">
						<p align="right" style="line-height:150%;"><b><span style="font-size:11pt;"><u>Date. ${suimRptSiteVo.siteDate}</u></span></b></p>
					</td>
				</tr>
			</table>
			<p>&nbsp;</p>
			
			<div style="width:100%; padding-left:13%;">
				<c:forEach items="${suimRptSiteImgList}" var="siteImgVo" >
				<div style="width : 350px; float:left; margin-bottom:15px;">
					<p align="center"><img src="${siteImgVo.imgStream}" width=280 height=210  /></p>
					<p style="line-height:50%; margin-top:0; margin-bottom:0;" align="center">&nbsp;</p>
					<p align="center">${siteImgVo.imgSubject}</p>
				</div>
				</c:forEach>
			</div>
						
		</td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" width="100%" align="center" height="75">
	<tr>
		<td width="100%" height="100%">
			<p style="line-height:100%;" align="right"><b><span style="font-size:14pt;">탑특종손해사정주식회사</span></b></p>
			<p style="line-height:0%;" align="center"><hr size="2" noshade color="black"></p>
			<table cellpadding="0" cellspacing="0" width="100%" align="center">
				<tr>
					<td>
						<p>담당자번호 : ${suimListDtl.rptUserHp}</p>
						<p>담당자팩스 : ${suimListDtl.officeFax}</p>
					</td>
					<td>
						<p align="right">본 보고서는 직인이 생략된 양식입니다.</p>
						<p align="right">발행일시/문서번호 : ${suimRptSiteVo.siteDate} / ${suimRptSiteVo.siteReportId} </p>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</c:if>
</body>
<script language="JavaScript">
<!--
window.print();
-->
</script>
</html>