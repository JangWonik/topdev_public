<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<!DOCTYPE html>
<html>
<head>
    <title>보고서 상세</title>
    <style>
        /*기본태그 정의*/
        html, body{padding:0;margin:0;}
        /* 모바일 가로모드 폰트확대 방지 */
        body{-webkit-text-size-adjust:none;}
        body,table {font-size:11pt;font-family:'굴림','굴림체','돋움','Nanum Gothic', 'verdana'; color:#000;}
        /* 마진과 패딩의 초기화 */
        body, div, p, th, td, textarea {margin:0;padding:0;}
        .reportWrap {width: 100%;}
        .reportContent {
            position: relative;
            /*background-color: #3e8f3e;*/
            width: 640px;
            margin: auto;
        }

        .text-left {text-align: left;}
        .text-right {text-align: right;}
        .text-center {text-align: center;}

        .display-table{
            width: 100%;
            display: table;
            table-layout: fixed;
        }

        .display-cell{
            display: table-cell;
            vertical-align: middle;
            float: none;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }
        tr {height: 42px;}
        th {
            background-color: #ECECEC;
            font-weight: bold;
            text-align: center;
            vertical-align: middle;
            padding: 4px 0px 4px 0px;
        }
        td {
            font-weight: normal;
            padding: 4px 5px 4px 5px;
            letter-spacing: -1px;
            line-height:20px;
            text-align: left;
            vertical-align: middle;
        }

        table, th, td {
            border: 1px solid black;
        }

        table.approval  th {background-color: #FFF3F3;}
        table.approval  td {text-align: center;}
        table.approval  tr {height: 69px;}
        table.approval  tr:first-child {height: 42px;}
        table.center    td {text-align: center}



        p {line-height: 150%;}
        p.title {font-weight: bold; margin: 10px 10px 8px 0px;}
        p.subtitle {font-weight: bold; margin: 10px 10px 8px 0px; font-size: 14pt;}
        .panel-title {font-weight: bold;}



        /*.reportContent table {width: 100%; border-spacing: 0px;}*/
        /*.reportContent tr {height: 42px;}*/
        /*.reportContent th {background-color: #ECECEC; border: 1px solid; font-weight: bold; padding: 4px 0px 4px 0px; text-align: center; vertical-align: middle}*/
        /*.reportContent td {border: 1px solid; font-weight: normal; padding: 4px 5px 4px 5px; letter-spacing: -1px; line-height:20px; text-align: left; vertical-align: middle}*/
    </style>
</head>
<body>
<div class="reportWrap">
    <div class="reportContent">
        <div>
            <img src="/resources/ls_img/ls_body/print_head.jpg" width="640" height="56">
            <p class="text-center" style="padding-top: 6px;"><span style="font-size: 9pt;">${reportTeamInfo.teamAddr}</span></p>
            <p class="text-center">
					<span style="font-size: 9pt;">
                        전화 : ${reportTeamInfo.teamTelephone} &nbsp;팩스 : ${reportTeamInfo.teamFax} &nbsp;이메일 : ${reportInvgUser.email}
                    </span>
            </p>
            <p class="text-center" style="padding-top: 2px;">
                <img src="/resources/ls_img/ls_body/print_hr.jpg" width="640" height="3" border="0" class="img-responsive center-block">
            </p>
        </div>
        <div style="margin-top: 10px;">
            <div style="width: 60%; float: left">
                <p class="title">수 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신 : ${reportBscInfo.ptnrName}</p>
                <p class="title">
                    참 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조 :
                    ${reportBscInfo.ptnrDeptNm}
                    <c:if test="${reportBscInfo.ptnrMbrNm != ''}">
                        〔 담당 : ${reportBscInfo.ptnrMbrNm} 님 〕
                    </c:if>
                </p>
                <p class="title">
                    제 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목 :
                    <c:if test="${reportBscInfo.beneficiaryNm != ''}">
                        &quot;<b>${reportBscInfo.beneficiaryNm}</b>&quot;
                    </c:if>
                    손해사정서
                </p>
                <p class="title">증 권 번 호 : 제 ${reportBscInfo.policyNo} 호</p>
                <p class="title">사 고 번 호 : ${reportBscInfo.accidentNo}</p>
            </div>
            <div style="width: 40%; float: left">
                <p class="title">Report No. ${reportBscInfo.suimAcceptNo}</p>
                <p class="title">
                    <c:choose>
                        <c:when test="${reportBscInfo.invoiceDate == null || reportBscInfo.invoiceDate == ''}">
                            날짜 정보없음
                        </c:when>
                        <c:otherwise>
                            보고서 제출일 : ${reportBscInfo.invoiceDate}
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
            <div style="clear: both"></div>
            <div>
                <p style="margin-top: 20px; padding: 0px 5px;">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    귀 사의 요청에 의거하여 피보험자 &quot;${reportBscInfo.beneficiaryNm}&quot;의 보험금
                    청구건에 대한 사고조사를 실시하고, 그 결과를 다음과 같이 제출 합니다.
                </p>
            </div>
        </div>
        <div style="margin-top: 50px;">
            <table class="approval" align="center">
                <colgroup>
                    <col width="25%">
                    <col width="25%">
                    <col width="25%">
                    <col width="25%">
                </colgroup>
                <tr>
                    <th>구분</th>
                    <th>성명</th>
                    <th>서명</th>
                    <th>연락처</th>
                </tr>
                <tr>
                    <td>손해사정사</td>
                    <td>윤경수</td>
                    <td><img src="./resources/ls_img/ls_body/sign_yoon.jpg" width="62" height="60" border="0"></td>
                    <td>070-8255-3000</td>
                </tr>
                <tr>
                    <td>팀&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;장</td>
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
                <tr>
                    <td>조 &nbsp;&nbsp;사 &nbsp;&nbsp;자</td>
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
        </div>
        <div class="display-table" style="margin-top: 100px;">
            <div class="display-cell text-center">
                <img src="/resources/ne_img/sign_salary.jpg" />
            </div>
        </div>
        <!-- 1.계약 확인사항 -->
        <div style="page-break-after: always;"></div>
        <div class="display-table" style="margin-top: 0px;">
            <div class="display-cell">
                <p class="subtitle">1.&nbsp;계약&nbsp;확인사항</p>
            </div>
        </div>
        <div id="div_contract">
            <table id="table_contract_view">
                <col width="25%">
                <col width="75%">
                <tr>
                    <th>보험종목</th>
                    <td>${reportBscInfo.insuranceNm}</td>
                </tr>
                <tr>
                    <th>증권번호</th>
                    <td>${reportBscInfo.policyNo}</td>
                </tr>
                <tr>
                    <th>보험기간</th>
                    <td>
                    	<c:choose>
                    		<c:when test="${empty reportPrint1.insuTerm1 or reportPrint1.insuTerm1 eq ''}">
                    			${reportPrint1.insuTerm1Sdate} ~ ${reportPrint1.insuTerm1Edate}
                    		</c:when>
                    		<c:otherwise>${reportPrint1.insuTerm1}</c:otherwise>
                    	</c:choose>
                    </td>
                </tr>
                <tr>
                    <th>계약자 / 피보험자</th>
                    <td>${reportBscInfo.policyholderNm} / ${reportBscInfo.beneficiaryNm}</td>
                </tr>
                <tr>
                    <th>직무확인사항</th>
                    <td>${reportPrint1.faceInsuredJob6}</td>
                </tr>
            </table>
        </div>
        <!--// 1.계약 확인사항 -->
        <!-- 2.청구사항 시작-->
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle">2.청구사항</p>
            </div>
        </div>
        <div id="div_claim">
            <table id="table_claim">
                <col width="25%">
                <col width="25%">
                <col width="25%">
                <col width="25%">
                <tr>
                    <th>구분</th>
                    <th colspan="3">내용</th>
                </tr>
                <tr class="tr_claim_view">
                    <th>진단병명</th>
                    <td colspan="3" style="padding:5px 5px; vertical-align: top; word-break: break-all">
                        ${fn:replace(fn:replace(fn:escapeXml(reportPrint1.diagnosisDisease3) , CRLF , '<br>'), ' ', '&nbsp;')}
                        <%--&nbsp;${reportPrint1.diagnosisDisease3}--%>
                    </td>
                </tr>
                <tr class="tr_claim_view">
                    <th>진단병원</th>
                    <td colspan="3">${reportPrint1.diagnosisHospital3}</td>
                </tr>
                
                <c:choose>
                	<c:when test="${reportAssureList.size() > 0}">
                		<tr>
		                    <th rowspan="${(fn:length(reportAssureList) * 2) + 3}">
		                        담보내역<br/>
		                        및<br/>
		                        추정 손해액
		                    </th>
		                    <th>담보사항</th>
		                    <th>가입금액</th>
		                    <th>추정손해액</th>
		                </tr>
		                <c:set var="claim_join_amount_total" value="0"/>
		                <c:set var="claim_estimation_amount_total" value="0"/>
		                <c:forEach  var="item" items="${reportAssureList}" varStatus="status">
		                    <c:set var="claim_join_amount_total" value="${claim_join_amount_total + item.joinAmount}"/>
		                    <c:set var="claim_estimation_amount_total" value="${claim_estimation_amount_total + item.estimationAmount}"/>
		                    <tr id="tr_claim_sub_view${status.index}">
		                        <td>${item.assureDtl}</td>
		                        <td style="text-align: right"><span class="money"><fmt:formatNumber value="${item.joinAmount}" pattern="###,###,###"/></span>원</td>
		                        <td style="text-align: right"><span class="money"><fmt:formatNumber value="${item.estimationAmount}" pattern="###,###,###"/></span>원</td>
		                    </tr>
		                </c:forEach>
		                <tr>
		                    <th>합계</th>
		                    <td style="text-align: right"><span class="money"><fmt:formatNumber value="${claim_join_amount_total}" pattern="###,###,###"/></span>원</td>
		                    <td style="text-align: right"><span class="money"><fmt:formatNumber value="${claim_estimation_amount_total}" pattern="###,###,###"/></span>원</td>
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
                
            </table>
        </div>
        <!--// 2.청구사항 시작-->
        <!-- 3.타 보험사 계약 및 지급 사항 시작 -->
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle">3.타 보험사 계약 및 지급사항</p>
            </div>
        </div>
        <div id="div_other_insu">
            <table>
                <colgroup>
                    <col width="25%">
                    <col width="25%">
                    <col width="50%">
                </colgroup>
                <tr>
                    <th>보험사</th>
                    <th>계약내용</th>
                    <th>중요사항</th>
                </tr>
                <c:forEach  var="item" items="${reportOtherInsuList}" varStatus="status">
                    <tr id="tr_other_insu_view${status.index}">
                        <td>${item.otherInsuCom}</td>
                        <td>${item.otherInsuDtl}</td>
                        <td>${item.otherInsuContract}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <!--// 3.타 보험사 계약 및 지급 사항 시작 -->
        <!-- 4. 중정 조사사항 및 조사 결과 -->
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle">4.중점 조사사항 및 조사 결과</p>
            </div>
        </div>
        <div id="div_emphasis_invest_result">
            <table>
                <colgroup>
                    <col width="25%">
                    <col width="75%">
                </colgroup>
                <tr id="tr_emphasis_invest_view" style="height: 150px;">
                    <th>중점<br/>조사사항</th>
                    <td style="vertical-align: top;">
                        ${fn:replace(fn:replace(fn:escapeXml(reportPrint1.inspectPoint4) , CRLF , '<br>'), ' ', '&nbsp;')}
                    </td>
                </tr>
                <tr id="tr_emphasis_result_view" style="height: 150px;">
                    <th>조사결과</th>
                    <td style="vertical-align: top;">
                        ${fn:replace(fn:replace(fn:escapeXml(reportPrint1.inspectResult4) , CRLF , '<br>'), ' ', '&nbsp;')}
                    </td>
                </tr>
            </table>
        </div>
        <!--// 4. 중정 조사사항 및 조사 결과 -->
        <!-- 5.총괄 경과표 -->
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle">5.총괄 경과표</p>
            </div>
        </div>
        <div id="div_general_pass">
            <table>
                <colgroup>
                    <col width="25%">
                    <col width="50%">
                    <col width="25%">
                </colgroup>
                <tr>
                    <th>일자</th>
                    <th>내용</th>
                    <th>비고</th>
                </tr>
                <c:forEach  var="item" items="${reportGeneralPassList}" varStatus="status">
                    <tr id="tr_general_pass_view${status.index}" style="height: 125px;">
                        <td style="text-align: center">
                                ${item.investigateToDate}<br> ~ ${item.investigateFromDate}<br> (${item.investigateDateDtl})
                        </td>
                        <td style="vertical-align: top;">${item.investigateDtl}</td>
                        <td>${item.investigateOutline}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <!--// 5.총괄 경과표 -->
        <!-- 6.상세확인사항 -->
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell" style="width: 80%;">
                <p class="subtitle">6.상세 확인사항</p>
            </div>
        </div>
        <c:set var="item1" value="${reportDetailConfirmMap.detail1}"/>
        <c:if test="${item1.useFlag == 1}">
            <div id="div_detail_confirm1" style="border: 1px solid #000000">
                <div class="display-table" style="height: 40px; background-color:#ececec;">
                    <div class="display-cell panel-title" style="width: 80%; padding-left: 10px;">
                        직업(직무) 확인
                    </div>
                </div>
                <div id="div_detail_confirm_view1" class="display-table" style="border-top: 1px solid #000000; height: 100px;">
                    <div id="div_detail_confirm_view_txt1" class="display-cell" style="padding: 5px; vertical-align: top">
                        ${item1.detailContentSub} 확인결과, 아래와 같이 확인됨.<br>
                        ${item1.detailContent}
                    </div>
                </div>
            </div>
        </c:if>

        <c:set var="item2" value="${reportDetailConfirmMap.detail2}"/>
        <c:if test="${item2.useFlag == 1}">
            <div style="border: 1px solid #000000; margin-top: 10px;">
                <div class="display-table" style="height: 40px; background-color:#ececec;">
                    <div class="display-cell panel-title" style="padding-left: 10px;">
                        사고 경위 확인
                    </div>
                </div>
                <div class="display-table" style="border-top: 1px solid #000000; height: 100px;">
                    <div class="display-cell" style="padding: 5px; vertical-align: top">
                        ${item2.detailContentSub} 확인결과,<br>
                        ${item2.detailContent}
                    </div>
                </div>
            </div>
        </c:if>

        <c:set var="item3" value="${reportDetailConfirmMap.detail3}"/>
        <c:if test="${item3.useFlag == 1}">
            <div style="border: 1px solid #000000; margin-top: 10px;">
                <div class="display-table" style="height: 40px; background-color:#ececec;">
                    <div class="display-cell panel-title" style="padding-left: 10px;">
                        병원 확인
                    </div>
                </div>
                <div class="display-table" style="border-top: 1px solid #000000; height: 100px;">
                    <div class="display-cell" style="padding: 5px; vertical-align: top">
                        ${item3.detailContent}
                    </div>
                </div>
            </div>
        </c:if>

        <c:set var="item4" value="${reportDetailConfirmMap.detail4}"/>
        <c:if test="${item4.useFlag == 1}">
            <div style="border: 1px solid #000000; margin-top: 10px;">
                <div class="display-table" style="height: 40px; background-color:#ececec;">
                    <div class="display-cell panel-title" style="padding-left: 10px;">
                        병원 확인
                    </div>
                </div>
                <div class="display-table" style="border-top: 1px solid #000000; height: 100px;">
                    <div class="display-cell" style="padding: 5px; vertical-align: top">
                        ${item4.detailContent}
                    </div>
                </div>
            </div>
        </c:if>

        <c:set var="item5" value="${reportDetailConfirmMap.detail5}"/>
        <c:if test="${item5.useFlag == 1}">
            <div style="border: 1px solid #000000; margin-top: 10px;">
                <div class="display-table" style="height: 40px; background-color:#ececec;">
                    <div class="display-cell panel-title" style="padding-left: 10px;">
                        피보험자 장해상태 확인
                    </div>
                </div>
                <div class="display-table" style="border-top: 1px solid #000000; height: 100px;">
                    <div class="display-cell" style="padding: 5px; vertical-align: top">
                        ${item5.detailContent}
                    </div>
                </div>
            </div>
        </c:if>
        <c:forEach  var="itemEtc" items="${reportDetailConfirmList}" varStatus="status">
            <div style="border: 1px solid #000000; margin-top: 10px;">
                <div class="display-table" style="height: 40px; background-color:#ececec;">
                    <div class="display-cell panel-title" style="padding-left: 10px;">
                        ${itemEtc.detailTitle}
                    </div>
                </div>
                <div class="display-table" style="border-top: 1px solid #000000; height: 100px;">
                    <div class="display-cell" style="padding: 5px; vertical-align: top">
                        ${itemEtc.detailContent}
                    </div>
                </div>
            </div>
        </c:forEach>
        <!--// 6.상세확인사항 -->
        <!-- 7.손해사정 결과(조사자 의견) -->
        <c:if test="${reportPrint1.adjustResult7UseAt == 'Y'}">
            <div class="display-table" style="margin-top: 20px;">
                <div class="display-cell">
                    <p class="subtitle">7.손해사정 결과(조사자 의견)</p>
                </div>
            </div>
            <div style="border: 1px solid #000000;">
                <div id="div_emphasis_opinion_view" class="display-table" style="height: 164px;">
                    <div id="div_emphasis_opinion_contents" class="display-cell" style="padding: 5px; vertical-align: top">
                        ${reportPrint1.adjustResult7}
                    </div>
                </div>
            </div>
        </c:if>
        <!--// 7.손해사정 결과(조사자 의견) -->

        <!-- 사고처리 과정표 -->
        <div style="page-break-after: always;"></div>
        <div class="text-center" style="font-size: 16pt;border: 1px solid #000; padding: 15px 0px; font-family: 돋움; color: #000; margin-top:20px;">
            <b>사 고 처 리 과 정 표</b>
        </div>
        <!-- 1.일반사항 -->
        <div class="display-table" style="margin-top: 10px;">
            <div class="display-cell">
                <p class="subtitle">1.일반사항</p>
            </div>
        </div>
        <table>
            <col width="20%">
            <col width="30%">
            <col width="20%">
            <col width="30%">
            <tr>
                <th>보험종목</th>
                <td>${reportBscInfo.insuranceNm}</td>
                <th>피보험자</th>
                <td>${reportBscInfo.beneficiaryNm}님</td>
            </tr>
            <tr>
                <th>사고일시</th>
                <td>${reportBscInfo.accidentDate}</td>
                <th>보험사 담당자</th>
                <td>
                    <c:if test="${reportBscInfo.ptnrMbrNm != ''}">
                        ${reportBscInfo.ptnrMbrNm} 님
                    </c:if>
                </td>
            </tr>
            <tr>
                <th>수임일</th>
                <td>${reportBscInfo.regDate}</td>
                <th>조사자</th>
                <td>${reportInvgUser.userName}</td>
            </tr>
        </table>
        <!--// 1.일반사항 -->
        <!-- 2.처리과정 -->
        <div class="display-table" style="margin-top: 10px;">
            <div class="display-cell">
                <p class="subtitle">2.처리과정</p>
            </div>
        </div>
        <c:choose><%-- 롯데손해보험일경우 --%>
            <c:when test="${reportBscInfo.ptnrId == '9'}">
                <table cellpadding="0" cellspacing="0" align="center">
                    <tr>
                        <th width="102">일자</th>
                        <th width="70">일수</th>
                        <th width="160">업무내용</th>
                        <th width="168">세부내용</th>
                        <th width="70">지연주체</th>
                        <th width="70">지연일수</th>
                    </tr>
                    <c:forEach var="item" items="${reportAccidentProcessList}" varStatus="status">
                        <tr>
                            <td class="text-center">${item.controlDate}</td>
                            <td class="text-right">${item.controlDateCnt}일</td>
                            <td style="padding: 0px 5px;">${item.controlSubject}</td>
                            <td style="padding: 0px 5px;">${item.controlMemo}</td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${item.controlDelayAgent == 1}">보험사</c:when>
                                    <c:when test="${item.controlDelayAgent == 2}">수익자</c:when>
                                    <c:when test="${item.controlDelayAgent == 3}">계약자</c:when>
                                    <c:when test="${item.controlDelayAgent == 4}">피보험자</c:when>
                                </c:choose>
                            </td>
                            <td class="text-right" style="padding: 0px 5px;">${item.controlDelayCnt}일</td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <th colspan="5">
                            <span style="color: red">총지연일수</span>
                        </th>
                        <td class="text-right" style="padding: 0px 5px;">${reportPrint1.printctrlAllDelayCnt}일</td>
                    </tr>
                    <tr>
                        <th colspan="5">
                            <span style="color: red">계약자, 피보험자, 수익자의 책임있는 사유 조사 지연일수</span>
                        </th>
                        <td class="text-right" style="padding: 0px 5px;">${reportPrint1.printctrlNotinsuDelayCnt}일</td>
                    </tr>
                    <tr>
                        <th colspan="5" style="background-color: yellow">
                            <span style="color: red">보험사 지연일수</span>
                        </th>
                        <td class="text-right" style="padding: 0px 5px;">${reportPrint1.printctrlInsuDelayCnt}일</td>
                    </tr>
                </table>
            </c:when>
            <c:otherwise>
                <table cellpadding="0" cellspacing="0" align="center">
                    <tr>
                        <th width="102">일자</th>
                        <th width="269">업무내용</th>
                        <th width="269">세부내용</th>
                    </tr>
                    <c:forEach var="item" items="${reportAccidentProcessList}" varStatus="status">
                        <tr>
                            <td class="text-center">${item.controlDate}</td>
                            <td style="padding: 0px 5px;">${item.controlSubject}</td>
                            <td style="padding: 0px 5px;">${item.controlMemo}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:otherwise>
        </c:choose>
        <!--// 2.처리과정 -->
        <%-- 3.첨부서류 --%>
        <c:if test="${reportPrint1.sagodocFlag == 1}">
            <div class="display-table" style="margin-top: 10px;">
                <div class="display-cell">
                    <p class="subtitle">3.첨부서류</p>
                </div>
            </div>
            <table>
                <colgroup>
                    <col width="9%">
                    <col width="41%">
                    <col width="9%">
                    <col width="41%">
                </colgroup>
                <tr>
                    <th>순번</th>
                    <th>첨부자료</th>
                    <th>부수</th>
                    <th>비고</th>
                </tr>
                <c:forEach  var="item" items="${reportAttachDocList}" varStatus="status">
                    <tr id="tr_attach_doc_view${status.index}" class="tr_attach_doc_view">
                        <td class="text-center">${status.count}</td>
                        <td>${item.attachName}</td>
                        <td class="text-center">${item.attachCopy}</td>
                        <td>${item.attachEtcMemo}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
        <!--// 3.첨부서류 -->
        <!--// 사고처리 과정표 -->

        <div class="text-center" style="font-size: 14px;; font-family: 돋움; color: #000; margin: 20px 0px;">
            <b> ※ 본 손해사정서는 관련 법률(보험업법 제 189조)에 의거 어느 일방에도 편중됨이 없이 <BR />
                신의와 성실의 원칙에 의거하여 공정하게 작성하였음을 명백히 합니다.[끝]
            </b>
        </div>

        <!-- 별첨 첨부사진 -->
        <div style="page-break-after: always;"></div>
        <div class="text-center" style="font-size: 24px; padding: 15px 0px; font-family: 돋움; color: #000; margin: 20px 0px;">
            <b>&lt;별첨:첨부사진&gt;</b>
        </div>
        <c:forEach var="item" items="${reportAttachImageList}" varStatus="status">
            <c:if test="${status.index > 0 && status.index % 2 == 0}">
                <div style="page-break-after: always;"></div>
            </c:if>
            <table>
                <tr>
                    <td>
                        <img src="/home/hosting_users/toplac/www${item.filePath}${item.imgName}" width="630" height="370" border="0">
                    </td>
                </tr>
                <tr>
                    <td>${item.imgMemo}</td>
                </tr>
            </table><br/>
        </c:forEach>
        <!--// 별첨 첨부사진 -->

        <!-- 별첨 병의원 탐문기록지 -->
        <div style="page-break-after: always;"></div>
        <div class="text-center" style="font-size: 24px; padding: 15px 0px; font-family: 돋움; color: #000; margin-top:20px;">
            <b>&lt;별첨:병.의원 탐문기록지&gt;</b>
        </div>
        <table>
            <colgroup>
                <col width="11%">
                <col width="20%">
                <col width="29%">
                <col width="20%">
                <col width="20%">
            </colgroup>
            <tr>
                <th>번호</th>
                <th>병.의원명</th>
                <th>소재지역</th>
                <th>연락처</th>
                <th>확인결과</th>
            </tr>
            <c:forEach  var="item" items="${reportHospitalQuestionList}" varStatus="status">
                <tr id="tr_hospital_question_view${status.index}">
                    <td class="text-center">${status.count}</td>
                    <td><c:out value="${item.hsptName}"/></td>
                    <td><c:out value="${item.hsptAddress}"/></td>
                    <td><c:out value="${item.hsptTel}"/></td>
                    <td><c:out value="${item.hsptConfirm}"/></td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
<script type="text/javascript">
    window.print();
</script>
</body>
</html>
