<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<c:set var="suim_accept_no" value="${reportBscInfo.suimAcceptNo}"/>
<%
    String suim_accept_no = (String)pageContext.getAttribute("suim_accept_no");
    response.setHeader("Content-Disposition", "attachment; filename="+suim_accept_no+".doc");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setContentType("application/vnd.ms-word");
%>
<!DOCTYPE html>
<html>
<head>
    <title>보고서 상세</title>
    <style>
        /*기본태그 정의*/
        html, body{padding:0;margin:0;}

        /* 모바일 가로모드 폰트확대 방지 */
        body{-webkit-text-size-adjust:none;}

        /*body,table,input,textarea,select{font-size:12px;font-family:'돋움','Dotum', 'verdana';color:#666;}*/
        body,table {font-size:11pt;font-family:'굴림','굴림체','돋움','Nanum Gothic', 'verdana'; color:#000;}

        /* 마진과 패딩의 초기화 */
        body, div, p, th, td, textarea {margin:0;padding:0;}

        /* 테이블 스타일 초기화 */
        table {border-collapse:collapse;border-spacing:0; table-layout:fixed;width:640px;}
        table th td {border: 1px solid black;}
        tr {height: 42px;}
        th {background-color: #ECECEC; font-weight: bold; text-align: center; word-wrap:break-word}
        td {font-weight: normal; word-break: break-all; word-wrap:break-word;}
        td .title{font-weight: bold}


        #receive_table tr {height: 30px;}
        #receive_table td {font-weight: bold;}

        #approval_table td {text-align: center;}
        /*#approval table tr:first-child {height: 42px;}*/
        /*#approval table th {background-color: #FFF3F3;}*/


        /* 이미지 및 필드셋에서 보더 표시 초기화 */
        img {border:0;}
        img {vertical-align:middle;}

        body {width:100%;}
        p {line-height:150%;}
        p .title{font-size:14pt; font-weight: bold; line-height:200%;}

        .l {text-align: left;}
        .r {text-align: right;}
        .c {text-align: center;}

    </style>
</head>
<body>
<table id="container_table" align="center" cellpadding="0" cellspacing="0" width="640" style="border: none;">
    <tr>
        <td>
            <p class="c"><img src="https://www.toplac.co.kr/resources/ls_img/ls_body/print_head.jpg" width="640" height="56" border="0"></p>
            <p class="c"><span style="font-size: 9pt;">${reportTeamInfo.teamAddr}</span></p>
            <p class="c"><span style="font-size: 9pt;">전화 : ${reportTeamInfo.teamTelephone} &nbsp;팩스 : ${reportTeamInfo.teamFax} &nbsp;이메일 : ${reportInvgUser.email}</span></p>
            <p class="c" style="font-size: 0pt;"><img src="https://www.toplac.co.kr/resources/ls_img/ls_body/print_hr.jpg" width="640" border="0" height="3px"></p>

            <table id="receive_table" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="80">수&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신</td>
                    <td width="340" style="text-align: left;">: ${reportBscInfo.ptnrName}</td>
                    <td class="r" width="220">Report No. ${reportBscInfo.suimAcceptNo}</td>
                </tr>
                <tr>
                    <td style="text-align: justify;">참&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조</td>
                    <td style="text-align: left;">
                        :
                        ${reportBscInfo.ptnrDeptNm}
                        <c:if test="${reportBscInfo.ptnrMbrNm != ''}">
                            〔 담당 : ${reportBscInfo.ptnrMbrNm} 님 〕
                        </c:if>
                    </td>
                    <td class="r">
                        <c:choose>
                            <c:when test="${reportBscInfo.invoiceDate == null || reportBscInfo.invoiceDate == ''}">
                                날짜 정보없음
                            </c:when>
                            <c:otherwise>
                                보고서 제출일 : ${reportBscInfo.invoiceDate}
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: justify;padding: 0px!important;">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</td>
                    <td style="text-align: left;">
                        :
                        <c:if test="${reportBscInfo.beneficiaryNm != ''}">
                            &quot;<b>${reportBscInfo.beneficiaryNm}</b>&quot;
                        </c:if>
                        손해사정서
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td style="text-align: justify;">증 &nbsp;권 &nbsp;번 &nbsp;호</td>
                    <td style="text-align: left;">: 제 ${reportBscInfo.policyNo} 호</td>
                    <td></td>
                </tr>
                <tr>
                    <td style="text-align: justify;">사 &nbsp;고 &nbsp;번 &nbsp;호</td>
                    <td style="text-align: left;">: ${reportBscInfo.accidentNo}</td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <p style="margin-top: 20px; padding: 0px 5px; font-weight: normal;">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            귀 사의 요청에 의거하여 피보험자 &quot;${reportBscInfo.beneficiaryNm}&quot;의 보험금
                            청구건에 대한 사고조사를 실시하고, 그 결과를 다음과 같이 제출 합니다.
                        </p>
                    </td>
                </tr>
            </table>
            <%--사인정보 시작--%>
            <p style="">&nbsp;</p>
            <p style="">&nbsp;</p>
            <p style="">&nbsp;</p>
            <table id="approval_table" cellpadding="0" cellspacing="0" align="center" width="640" border="1">
                <tr height="42">
                    <th height="42" style="background-color: #FFF3F3; width: 160px;">구분</th>
                    <th style="background-color: #FFF3F3; width: 160px;">성명</th>
                    <th style="background-color: #FFF3F3; width: 160px;">서명</th>
                    <th style="background-color: #FFF3F3; width: 160px;">연락처</th>
                </tr>
                <tr height="69">
                    <td height="69">손해사정사</td>
                    <td>윤경수</td>
                    <td><img src="https://toplac.co.kr/resources/ls_img/ls_body/sign_yoon.jpg" width="62" height="60" border="0"></td>
                    <td>070-8255-3000</td>
                </tr>
                <tr height="69">
                    <td height="69">팀&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;장</td>
                    <td>
                        ${reportAprvUser.userName}<br/>
                        <c:if test="${reportAprvUser.workLevel != null && reportAprvUser.workLevel != ''}">
                            (${reportAprvUser.disWorkLevel})
                        </c:if>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${reportAprvUser.userSign != null}">
                                <img width="50" height="50" src="https://toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${reportAprvUser.userNo}/${reportAprvUser.userSign}"/>
                            </c:when>
                            <c:otherwise>
                                사인없음
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${reportAprvUser.handphone}</td>
                </tr>
                <tr height="69">
                    <td height="69">조&nbsp;&nbsp;사&nbsp;&nbsp;자</td>
                    <td>${reportInvgUser.userName } <br />(${reportInvgUser.disWorkLevel})</td>
                    <td>
                        <c:choose>
                            <c:when test="${reportInvgUser.userSign != null}">
                                <img width="50" height="50" src="https://toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${reportInvgUser.userNo}/${reportInvgUser.userSign}"/>
                            </c:when>
                            <c:otherwise>
                                사인없음
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${reportInvgUser.handphone }</td>
                </tr>
            </table>
            <%--사인정보 끝--%>
            <p style="">&nbsp;</p>
            <p style="">&nbsp;</p>
            <p style="">&nbsp;</p>
            <p class="c"><img src="https://www.toplac.co.kr/resources/ne_img/sign_salary.jpg" /></p>
            <%--표지 끝--%>
            <%--1.계약 확인사항--%>
            <p style="">&nbsp;</p>
            <p class="title" style="font-size: 14pt;">1.&nbsp;계약&nbsp;확인사항</p>
            <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
                <tr>
                    <th width="160">보험종목</th>
                    <td width="480">&nbsp;${reportBscInfo.insuranceNm}</td>
                </tr>
                <tr>
                    <th>증권번호</th>
                    <td>&nbsp;${reportBscInfo.policyNo}</td>
                </tr>
                <tr>
                    <th>보험기간</th>
                    <td>
                    	<c:choose>
                    		<c:when test="${empty reportPrint1.insuTerm1 or reportPrint1.insuTerm1 eq ''}">
                    			&nbsp;${reportPrint1.insuTerm1Sdate} ~ ${reportPrint1.insuTerm1Edate}
                    		</c:when>
                    		<c:otherwise>&nbsp;${reportPrint1.insuTerm1}</c:otherwise>
                    	</c:choose>
                    </td>
                </tr>
                <tr>
                    <th>계약자 / 피보험자</th>
                    <td>&nbsp;${reportBscInfo.policyholderNm} / ${reportBscInfo.beneficiaryNm}</td>
                </tr>
                <tr>
                    <th>직무확인사항</th>
                    <td>&nbsp;${reportPrint1.faceInsuredJob6}</td>
                </tr>
            </table>
            <%--2. 청구사항--%>
            <p style="">&nbsp;</p>
            <p class="title" style="font-size: 14pt;">2.&nbsp;청구사항</p>
            <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
                <tr>
                    <th width="160">구&nbsp;&nbsp;&nbsp;&nbsp;분</th>
                    <th colspan="3">내&nbsp;&nbsp;&nbsp;&nbsp;용</th>
                </tr>
                <tr>
                    <th>진단병명</th>
                    <td colspan="3" style="padding:0px 5px; word-break: break-all">
                        ${fn:replace(fn:replace(fn:escapeXml(reportPrint1.diagnosisDisease3) , CRLF , '<br>'), ' ', '&nbsp;')}
                        <%--&nbsp;${reportPrint1.diagnosisDisease3}--%>
                    </td>
                </tr>
                <tr>
                    <th>진단병원</th>
                    <td colspan="3">&nbsp;${reportPrint1.diagnosisHospital3}</td>
                </tr>
                
                <!-- 담보내역 및 추정손해액 조건 체크 -->
  				<c:choose>
					<c:when test="${reportAssureList.size() > 0}">
					<tr>
						<th rowspan="${(fn:length(reportAssureList) * 2) + 3}">
	                        담보내역<br/>
	                        및<br/>
	                        추정 손해액
	                    </th>
	                    <th width="160">담보사항</th>
	                    <th width="160">가입금액</th>
	                    <th width="160">추정손해액</th>
	                </tr>
	                <c:set var="claim_join_amount_total" value="0"/>
	                <c:set var="claim_estimation_amount_total" value="0"/>
	                <c:forEach  var="item" items="${reportAssureList}" varStatus="status">
	                    <c:set var="claim_join_amount_total" value="${claim_join_amount_total + item.joinAmount}"/>
	                    <c:set var="claim_estimation_amount_total" value="${claim_estimation_amount_total + item.estimationAmount}"/>
	                    <tr>
	                        <td>&nbsp;${item.assureDtl}</td>
	                        <td style="text-align: right"><fmt:formatNumber value="${item.joinAmount}" pattern="###,###,###"/>원&nbsp;</td>
	                        <td style="text-align: right"><fmt:formatNumber value="${item.estimationAmount}" pattern="###,###,###"/>원&nbsp;</td>
	                    </tr>
	                </c:forEach>
	                <tr>
	                    <th>합계</th>
	                    <td style="text-align: right"><fmt:formatNumber value="${claim_join_amount_total}" pattern="###,###,###"/>원&nbsp;</td>
	                    <td style="text-align: right"><fmt:formatNumber value="${claim_estimation_amount_total}" pattern="###,###,###"/>원&nbsp;</td>
	                </tr>					
					</c:when>
					<c:otherwise>
					<tr>
						<th rowspan="${(fn:length(reportAssureListSub) * 2) + 4}">
				            담보내역<br/>
				            및<br/>
				            추정 손해액
				        </th>
				        <th colspan="2">담보구분</th>
				        <th>담보내역</th>				        
					</tr>
					<c:forEach  var="item" items="${reportAssureListSub}" varStatus="status">		                	
				    	<tr>
				            <td colspan="2">&nbsp;${item.mortgageType}</td>
				            <td style="text-align: right"><fmt:formatNumber value="${item.mortgageAmount}" pattern="###,###,###"/>원&nbsp;</td>			            
				        </tr>
				    </c:forEach>
				    <tr>
				    	<th colspan="2">추정금액</th>
				    	<td style="text-align: right"><fmt:formatNumber value="${reportPrint1.estimationAmount}" pattern="###,###,###"/>원&nbsp;</td>				    	
				    </tr>
					</c:otherwise>
  				</c:choose>
  				                
                <%-- <tr>
                    <th rowspan="${(fn:length(reportAssureList) * 2) + 3}">
                        담보내역<br/>
                        및<br/>
                        추정 손해액
                    </th>
                    <th width="160">담보사항</th>
                    <th width="160">가입금액</th>
                    <th width="160">추정손해액</th>
                </tr>
                <c:set var="claim_join_amount_total" value="0"/>
                <c:set var="claim_estimation_amount_total" value="0"/>
                <c:forEach  var="item" items="${reportAssureList}" varStatus="status">
                    <c:set var="claim_join_amount_total" value="${claim_join_amount_total + item.joinAmount}"/>
                    <c:set var="claim_estimation_amount_total" value="${claim_estimation_amount_total + item.estimationAmount}"/>
                    <tr>
                        <td>&nbsp;${item.assureDtl}</td>
                        <td style="text-align: right"><fmt:formatNumber value="${item.joinAmount}" pattern="###,###,###"/>원&nbsp;</td>
                        <td style="text-align: right"><fmt:formatNumber value="${item.estimationAmount}" pattern="###,###,###"/>원&nbsp;</td>
                    </tr>
                </c:forEach>
                <tr>
                    <th>합계</th>
                    <td style="text-align: right"><fmt:formatNumber value="${claim_join_amount_total}" pattern="###,###,###"/>원&nbsp;</td>
                    <td style="text-align: right"><fmt:formatNumber value="${claim_estimation_amount_total}" pattern="###,###,###"/>원&nbsp;</td>
                </tr>
                --%>
            </table> 
            
            <%--3.타 보험사 계약 및 지급사항--%>
            <p style="">&nbsp;</p>
            <p class="title" style="font-size: 14pt;">3.&nbsp;타 보험사 계약 및 지급사항</p>
            <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
                <tr>
                    <th width="160">보험사</th>
                    <th width="240">계약내용</th>
                    <th width="240">중요사항</th>
                </tr>
                <c:forEach  var="item" items="${reportOtherInsuList}" varStatus="status">
                    <tr>
                        <td class="c">${item.otherInsuCom}</td>
                        <td style="padding:0px 5px; text-align: justify;">${item.otherInsuDtl}</td>
                        <td style="padding:0px 5px; text-align: justify;">${item.otherInsuContract}</td>
                    </tr>
                </c:forEach>
            </table>
            <%--4.중점 조사사항 및 조사 결과--%>
            <p style="">&nbsp;</p>
            <p class="title" style="font-size: 14pt;">4.&nbsp;중점 조사사항 및 조사 결과</p>
            <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
                <tr style="height: 150px;">
                    <th width="160">중점<br/>조사사항</th>
                    <td width="480" style="padding:5px 5px; vertical-align: top; word-break: break-all">
                        <%--${reportPrint1.inspectPoint4}--%>
                        ${fn:replace(fn:replace(fn:escapeXml(reportPrint1.inspectPoint4) , CRLF , '<br>'), ' ', '&nbsp;')}
                    </td>
                </tr>
                <tr style="height: 150px;">
                    <th>조사결과</th>
                    <td style="padding:5px 5px; vertical-align: top;">
                        ${fn:replace(fn:escapeXml(reportPrint1.inspectResult4) , CRLF , '<br>')}
                    </td>
                </tr>
            </table>
            <%--5.총괄 경과표--%>
            <p style="">&nbsp;</p>
            <p class="title" style="font-size: 14pt;">5.&nbsp;총괄 경과표</p>
            <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
                <tr>
                    <th width="160">일&nbsp;&nbsp;&nbsp;&nbsp;자</th>
                    <th width="320">내&nbsp;&nbsp;&nbsp;&nbsp;용</th>
                    <th width="160">비&nbsp;&nbsp;&nbsp;&nbsp;고</th>
                </tr>
                <c:forEach  var="item" items="${reportGeneralPassList}" varStatus="status">
                    <tr style="height: 125px;">
                        <td style="text-align: center">
                                ${item.investigateToDate}<br> ~ ${item.investigateFromDate}<br> (${item.investigateDateDtl})
                        </td>
                        <td style="vertical-align: top; padding: 5px 5px;">${item.investigateDtl}</td>
                        <td style="padding: 5px 5px;">${item.investigateOutline}</td>
                    </tr>
                </c:forEach>
            </table>
            <%--6.상세 확인사항--%>
            <p style="">&nbsp;</p>
            <p class="title" style="font-size: 14pt;">6.&nbsp;상세 확인사항</p>
            <c:set var="item1" value="${reportDetailConfirmMap.detail1}"/>
            <c:if test="${item1.useFlag == 1}">
                <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
                    <tr>
                        <th style="text-align: left; padding: 0px 5px;">직업(직무) 확인</th>
                    </tr>
                    <tr>
                        <td style="text-align: left; padding: 5px 5px;">
                            ${item1.detailContentSub} 확인결과, 아래와 같이 확인됨.<br>
                            ${item1.detailContent}
                        </td>
                    </tr>
                </table>
            </c:if>
            <c:set var="item2" value="${reportDetailConfirmMap.detail2}"/>
            <c:if test="${item2.useFlag == 1}">
                <p style="font-size: 5pt;">&nbsp;</p>
                <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
                    <tr>
                        <th style="text-align: left; padding: 0px 5px;">사고 경위 확인</th>
                    </tr>
                    <tr>
                        <td style="text-align: left; padding: 5px 5px;">
                            ${item2.detailContentSub} 확인결과,<br>
                            ${item2.detailContent}
                        </td>
                    </tr>
                </table>
            </c:if>
            <c:set var="item3" value="${reportDetailConfirmMap.detail3}"/>
            <c:if test="${item3.useFlag == 1}">
                <p style="font-size: 5pt;">&nbsp;</p>
                <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
                    <tr>
                        <th style="text-align: left; padding: 0px 5px;">병원 확인</th>
                    </tr>
                    <tr>
                        <td style="text-align: left; padding: 5px 5px;">
                            ${item3.detailContent}
                        </td>
                    </tr>
                </table>
            </c:if>
            <c:set var="item4" value="${reportDetailConfirmMap.detail4}"/>
            <c:if test="${item4.useFlag == 1}">
                <p style="font-size: 5pt;">&nbsp;</p>
                <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
                    <tr>
                        <th style="text-align: left; padding: 0px 5px;">제 3 병원 의료자문 확인</th>
                    </tr>
                    <tr>
                        <td style="text-align: left; padding: 5px 5px;">
                            ${item4.detailContent}
                        </td>
                    </tr>
                </table>
            </c:if>
            <c:set var="item5" value="${reportDetailConfirmMap.detail5}"/>
            <c:if test="${item5.useFlag == 1}">
                <p style="font-size: 5pt;">&nbsp;</p>
                <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
                    <tr>
                        <th style="text-align: left; padding: 0px 5px;">피보험자 장해상태 확인</th>
                    </tr>
                    <tr>
                        <td style="text-align: left; padding: 5px 5px;">
                            ${item5.detailContent}
                        </td>
                    </tr>
                </table>
            </c:if>
            <c:forEach  var="itemEtc" items="${reportDetailConfirmList}" varStatus="status">
                <p style="font-size: 5pt;">&nbsp;</p>
                <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
                    <tr>
                        <th style="text-align: left; padding: 0px 5px;">${itemEtc.detailTitle}</th>
                    </tr>
                    <tr>
                        <td style="text-align: left; padding: 5px 5px;">
                                ${itemEtc.detailContent}
                        </td>
                    </tr>
                </table>
            </c:forEach>
            <%--7.손해사정 결과(조사자 의견)--%>
            <c:if test="${reportPrint1.adjustResult7UseAt == 'Y'}">
                <p style="">&nbsp;</p>
                <p class="title" style="font-size: 14pt;">7.&nbsp;손해사정 결과(조사자 의견)</p>
                <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
                    <tr>
                        <td style="text-align: left; padding: 5px 5px;">
                            ${reportPrint1.adjustResult7}
                        </td>
                    </tr>
                </table>
            </c:if>
            <%-- 사고처리 과정표 --%>
            <p style="">&nbsp;</p>
            <p style="">&nbsp;</p>
            <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
                <tr style="height: 69px;">
                    <td style="text-align: center; padding: 5px 5px;">
                        <b><p style="font-size: 16pt;line-height: 100%;">사 고 처 리 과 정 표</p></b>
                    </td>
                </tr>
            </table>
            <%-- 1.일반사항 --%>
            <p style="">&nbsp;</p>
            <p class="title" style="font-size: 14pt;">1.&nbsp;일반사항</p>
            <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
                <tr>
                    <th width="120">보험종목</th>
                    <td width="200" style="padding: 0px 5px;">${reportBscInfo.insuranceNm}</td>
                    <th width="120">피보험자</th>
                    <td width="200" style="padding: 0px 5px;">${reportBscInfo.beneficiaryNm}님</td>
                </tr>
                <tr>
                    <th>사고일시</th>
                    <td style="padding: 0px 5px;">${reportBscInfo.accidentDate}</td>
                    <th>보험사 담당자</th>
                    <td style="padding: 0px 5px;">
                        <c:if test="${reportBscInfo.ptnrMbrNm != ''}">
                            ${reportBscInfo.ptnrMbrNm} 님
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <th>수임일</th>
                    <td style="padding: 0px 5px;">${reportBscInfo.regDate}</td>
                    <th>조사자</th>
                    <td style="padding: 0px 5px;">${reportInvgUser.userName}</td>
                </tr>
            </table>
            <%-- 2.처리과정 --%>
            <p style="">&nbsp;</p>
            <p class="title" style="font-size: 14pt;">2.&nbsp;처리과정</p>
            <c:choose><%-- 롯데손해보험일경우 --%>
                <c:when test="${reportBscInfo.ptnrId == '9'}">
                    <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
                        <tr>
                            <th width="102">일&nbsp;&nbsp;&nbsp;&nbsp;자</th>
                            <th width="70">일&nbsp;수</th>
                            <th width="160">업무내용</th>
                            <th width="168">세부내용</th>
                            <th width="70">지연주체</th>
                            <th width="70">지연일수</th>
                        </tr>
                        <c:forEach var="item" items="${reportAccidentProcessList}" varStatus="status">
                            <tr>
                                <td class="c">${item.controlDate}</td>
                                <td class="r">${item.controlDateCnt}일</td>
                                <td style="padding: 0px 5px;">${item.controlSubject}</td>
                                <td style="padding: 0px 5px;">${item.controlMemo}</td>
                                <td class="c">
                                    <c:choose>
                                        <c:when test="${item.controlDelayAgent == 1}">보험사</c:when>
                                        <c:when test="${item.controlDelayAgent == 2}">수익자</c:when>
                                        <c:when test="${item.controlDelayAgent == 3}">계약자</c:when>
                                        <c:when test="${item.controlDelayAgent == 4}">피보험자</c:when>
                                    </c:choose>
                                </td>
                                <td class="r" style="padding: 0px 5px;">${item.controlDelayCnt}일</td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <th colspan="5">
                                <span style="color: red">총지연일수</span>
                            </th>
                            <td class="r" style="padding: 0px 5px;">${reportPrint1.printctrlAllDelayCnt}일</td>
                        </tr>
                        <tr>
                            <th colspan="5">
                                <span style="color: red">계약자, 피보험자, 수익자의 책임있는 사유 조사 지연일수</span>
                            </th>
                            <td class="r" style="padding: 0px 5px;">${reportPrint1.printctrlNotinsuDelayCnt}일</td>
                        </tr>
                        <tr>
                            <th colspan="5" style="background-color: yellow">
                                <span style="color: red">보험사 지연일수</span>
                            </th>
                            <td class="r" style="padding: 0px 5px;">${reportPrint1.printctrlInsuDelayCnt}일</td>
                        </tr>
                    </table>
                </c:when>
                <c:otherwise>
                    <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
                        <tr>
                            <th width="102">일&nbsp;&nbsp;&nbsp;&nbsp;자</th>
                            <th width="269">업무내용</th>
                            <th width="269">세부내용</th>
                        </tr>
                        <c:forEach var="item" items="${reportAccidentProcessList}" varStatus="status">
                            <tr>
                                <td class="c">${item.controlDate}</td>
                                <td style="padding: 0px 5px;">${item.controlSubject}</td>
                                <td style="padding: 0px 5px;">${item.controlMemo}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:otherwise>
            </c:choose>
            <%-- 3.첨부서류 --%>
            <c:if test="${reportPrint1.sagodocFlag == 1}">
                <p style="">&nbsp;</p>
                <p class="title" style="font-size: 14pt;">3.&nbsp;첨부서류</p>
                <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
                    <tr>
                        <th width="50">순번</th>
                        <th width="270">첨부자료</th>
                        <th width="50">부수</th>
                        <th width="270">비고</th>
                    </tr>
                    <c:forEach  var="item" items="${reportAttachDocList}" varStatus="status">
                        <tr>
                            <td class="c">${status.count}</td>
                            <td style="padding: 0px 5px;">${item.attachName}</td>
                            <td class="c">${item.attachCopy}</td>
                            <td style="padding: 0px 5px;">${item.attachEtcMemo}</td>
                        </tr>
                    </c:forEach>
                </table>
            	</c:if>

            <p style="">&nbsp;</p>
            <p align="center"><b> ※ 본 손해사정서는 당사의 양식과 최선의 노력으로 이해 당사자</b></p>
            <p align="center"><b>어느 일방에도 편중됨이 없이 작성되었음을 명백히 합니다.[끝]</b></p>
            <p style="">&nbsp;</p>

            <%--<img src="http://lorempixel.com/1024/860/" width="630" height="350" border="0">--%>
            <p style="">&nbsp;</p>
            <p class="title" align="center" style="font-size: 16pt; font-family: 돋움;"><b>&lt;별첨:첨부사진&gt;</b></p>

            <c:forEach var="item" items="${reportAttachImageList}" varStatus="status">
                <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
                    <tr>
                        <td style="padding: 5px 5px;">
                            <img src="https://www.toplac.co.kr/home/hosting_users/toplac/www${item.filePath}${item.imgName}" width="630" height="350" border="0">
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 5px 5px;">${item.imgMemo}</td>
                    </tr>
                </table><br/>
            </c:forEach>

            <p style="">&nbsp;</p>
            <p style="">&nbsp;</p>
            <p class="title" align="center" style="font-size: 16pt; font-family: 돋움;"><b>&lt;별첨:병.의원 탐문기록지&gt;</b></p>
            <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
                <tr>
                    <th width="50">번호</th>
                    <th width="147">병.의원명</th>
                    <th width="169">소재지역</th>
                    <th width="127">연락처</th>
                    <th width="147">확인결과</th>
                </tr>
                <c:forEach  var="item" items="${reportHospitalQuestionList}" varStatus="status">
                    <tr>
                        <td class="c">${status.count}</td>
                        <td style="padding: 0px 5px;"><c:out value="${item.hsptName}"/></td>
                        <td style="padding: 0px 5px;"><c:out value="${item.hsptAddress}"/></td>
                        <td class="c" style="padding: 0px 5px;"><c:out value="${item.hsptTel}"/></td>
                        <td style="padding: 0px 5px;"><c:out value="${item.hsptConfirm}"/></td>
                    </tr>
                </c:forEach>
            </table>

        </td> <%-- container td--%>
    </tr> <%-- container tr--%>
</table> <%-- container table--%>
</body>
</html>
