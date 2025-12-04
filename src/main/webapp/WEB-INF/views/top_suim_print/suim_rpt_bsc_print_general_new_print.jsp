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
                <!-- <tr>
                    <td>손해사정사</td>
                    <td>윤경수</td>
                    <td><img src="./resources/ls_img/ls_body/sign_yoon.jpg" width="62" height="60" border="0"></td>
                    <td>070-8255-3000</td>
                </tr> -->
                <%-- 담당 손해사정사 정보로 변경 시작 --%>               	               	               	
               	<c:forEach items="${certiManager4ReportUser}" var="certiUserVo">
               		<c:if test="${certiUserVo.certi_state_val eq '손해사정사'}">
	               		<tr>
	               			<td>${certiUserVo.certi_state_val}</td>
	               			<td>${certiUserVo.user_name}</td>
	               			<td>
	               				<img width="50" height="50" src="https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${certiUserVo.user_no}/${certiUserVo.user_sign}">
	               			</td>
	               			<td>
	               				<c:if test='${certiUserVo.work_phone != ""}'>${certiUserVo.work_phone} </c:if>
	               			</td>
	               		</tr>
               		</c:if>
               	</c:forEach>
                <%-- 담당 손해사정사 정보로 변경 끝 --%>
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
                    <!-- 신규 조사결과 시작 by top3009 -->                    
                    <td>
                    	<c:set var="nCnt" value="1"/>
                    	<c:forEach var="item" items="${reportResult}" varStatus="status">
                    		<b>ㅁ 담보여부</b><br/>
                    		<c:if test="${!empty item.option1}">
                    			<div style="padding-top:5px;">
                    			${nCnt}. ${fn:replace(item.option1,LF,'<br/>')}<br/>
                    			<c:set var="nCnt" value="${nCnt+1}"/>
                    			</div>
                    		</c:if>
                    		<c:if test="${!empty item.option2}">
                    			<div style="padding-top:5px;">
                    			${nCnt}. ${fn:replace(item.option2,LF,'<br/>')}<br/>                    			
                    			<c:set var="nCnt" value="${nCnt+1}"/>
                    			</div>
                    		</c:if>
                    		<c:if test="${!empty item.option3}">
                    			<div style="padding-top:5px;">
                    			${nCnt}. ${fn:replace(item.option3,LF,'<br/>')}<br/>                    			
                    			<c:set var="nCnt" value="${nCnt+1}"/>
                    			</div>
                    		</c:if>
                    		<c:if test="${!empty item.option4}">
                    			<div style="padding-top:5px;">
                    			${nCnt}. ${fn:replace(item.option4,LF,'<br/>')}<br/>                    			
                    			<c:set var="nCnt" value="${nCnt+1}"/>
                    			</div>
                    		</c:if>
                    		<c:if test="${!empty item.notiContent}">
                    			<div style="padding-top:10px;">
                    			<b>ㅁ 고지의무 위반여부</b>
                    			</div>
                    			<div style="padding-top:5px;">
                    			${fn:replace(item.notiContent,LF,'<br/>')}<br/>                    			
                    			</div>
                    		</c:if>
                    		<br/>
                       		<b>상기 내용 확인되어, 이에 대한 귀사의 최종 검토 바랍니다.</b>                       	                    		
                    	</c:forEach>                       	
                    </td>
                    <!-- 신규 조사결과 끝 by top3009 -->
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
        		<tr>
            		<th width="20%">일자</th>
            		<th width="60%">내용</th>
            		<th width="20%">비고</th>            		
            	</tr>
        		<c:forEach var="item" items="${reportSummaryList}" varStatus="status">
		            <tr>
			    		<td width="20%" style="text-align:center;">
			    			${item.writeDateFmt}
			    		</td>
			    		<td width="60%">
			    			<c:if test="${!empty item.summaryInsuSubject}">
								<div style="padding:5px,0,0,5px;">
									<b>${item.summaryInsuSubject}</b>
								</div>
							</c:if>    			
							<c:if test="${!empty item.firstDateFmt}">
								<div style="padding:5px,0,0,5px;">
								- 초진일자 : ${item.firstDateFmt}
								</div>
							</c:if>
							<c:if test="${!empty item.incomeDateFmt}">
								<div style="padding:5px,0,0,5px;">
								- 내원일자 : ${item.incomeDateFmt}
								</div>
							</c:if>
							<c:if test="${!empty item.incomeContent}">
								<div style="padding:5px,0,0,5px;">
								- 내원경위 : ${fn:replace(item.incomeContent,LF,'<br/>')}
								</div>
							</c:if>
							<c:if test="${!empty item.diseaseName}">
								<div style="padding:5px,0,0,5px;">
								<%-- - 진단병명 : ${item.diseaseName} --%>
								- 진단병명 : ${fn:replace(item.diseaseName,LF,'<br/>')}
								</div>
							</c:if>
							<c:if test="${!empty item.inspectionContent}">
								<div style="padding:5px,0,0,5px;">
								- 검사사항 : ${fn:replace(item.inspectionContent,LF,'<br/>')}
								</div>
							</c:if>
							<c:if test="${!empty item.operationContent}">
								<div style="padding:5px,0,0,5px;">
								- 수 술 명 : ${fn:replace(item.operationContent,LF,'<br/>')}
								</div>
							</c:if>
							<c:if test="${!empty item.obstacleDateFmt}">
								<div style="padding:5px,0,0,5px;">
								- 장해진단일 : ${item.obstacleDateFmt}
								</div>
							</c:if>
							<c:if test="${!empty item.obstacleSubject}">
								<div style="padding:5px,0,0,5px;">
								- 장해진단명 : ${fn:replace(item.obstacleSubject,LF,'<br/>')}
								</div>
							</c:if>
							<c:if test="${!empty item.obstacleContent}">
								<div style="padding:5px,0,0,5px;">
								- 장해내용 : ${fn:replace(item.obstacleContent,LF,'<br/>')}
								</div>
							</c:if>
							<c:if test="${!empty item.enterInterval}">
								<div style="padding:5px,0,0,5px;">
								<%-- - 입원기간 : ${item.enterInterval} --%>
								- 입원기간 : ${fn:replace(item.enterInterval,LF,'<br/>')}
								</div>
							</c:if>
							<c:if test="${!empty item.goingInterval}">
								<div style="padding:5px,0,0,5px;">
								<%-- - 통원기간 : ${item.goingInterval} --%>
								- 통원기간 : ${fn:replace(item.goingInterval,LF,'<br/>')}
								</div>
							</c:if>
							<c:if test="${!empty item.pastDisease}">
								<div style="padding:5px,0,0,5px;">
								<%-- - 과거병력 : ${item.pastDisease} --%>
								- 과거병력 : ${fn:replace(item.pastDisease,LF,'<br/>')}
								</div>
							</c:if>
							<c:if test="${!empty item.outingContent}">
								<div style="padding:5px,0,0,5px;">
								<%-- - 외출외박 : ${item.outingContent} --%>
								- 외출외박 : ${fn:replace(item.outingContent,LF,'<br/>')}
								</div>
							</c:if>
							<c:if test="${!empty item.optionContent}">
								<div style="padding:5px,0,0,5px;">
								- 기타사항 : ${fn:replace(item.optionContent,LF,'<br/>')}
								</div>
							</c:if>
							<c:if test="${!empty item.doctorOpinion}">
								<div style="padding:5px,0,0,5px;">
								- 의사의견 : ${fn:replace(item.doctorOpinion,LF,'<br/>')}
								</div>
							</c:if>
			    		</td>
			    		<td width="20%">
			    			${item.remarkContent}
			    		</td>			    		
			    	</tr>
		    	</c:forEach>
	    	</table>
        </div>
        <!--// 5.총괄 경과표 -->
        <!-- 6.관공서 확인사항 -->
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell" style="width: 80%;">
                <p class="subtitle">6.관공서 확인사항</p>
            </div>
        </div>        
        <table>
			<tr>
				<th width="20%">일자</th>
				<th width="60%">내용</th>
				<th width="20%">비고</th>				
			</tr>
			<c:forEach var="item" items="${reportOfficeList1}" varStatus="status">
				<tr>
					<td width="20%" style="text-align:center;">
		    			${item.writeDate1Fmt}
		    		</td>
		    		<td width="60%">    			
						<c:if test="${!empty item.checkDate1}">
							<div style="padding:5px,0,0,5px;">
							- 신고일시 : ${item.checkDate1}
							</div>
						</c:if>
						<c:if test="${!empty item.occurSpot1}">
							<div style="padding:5px,0,0,5px;">
							- 발생장소 : ${item.occurSpot1}
							</div>
						</c:if>
						<c:if test="${!empty item.occurType1}">
							<div style="padding:5px,0,0,5px;">
							- 발생유형 : ${item.occurType1}
							</div>
						</c:if>
						<c:if test="${!empty item.disaster1}">
							<div style="padding:5px,0,0,5px;">
							- 재해경위 : ${item.disaster1}
							</div>
						</c:if>
						<c:if test="${!empty item.transHospital1}">
							<div style="padding:5px,0,0,5px;">
							- 후송병원 : ${item.transHospital1}
							</div>
						</c:if>
					</td>
					<td width="20%">
		    			${item.remarkContent1}
		    		</td>
		    	</tr>		    		
			</c:forEach>
			
			<c:forEach var="item" items="${reportOfficeList2}" varStatus="status">
				<tr>
					<td width="20%" style="text-align:center;">
		    			${item.writeDate2Fmt}
		    		</td>
		    		<td width="60%">    			
						<c:if test="${!empty item.personalInfo2}">
							<div style="padding:5px,0,0,5px;">
							- 인적사항 : ${item.personalInfo2}
							</div>
						</c:if>
						<c:if test="${!empty item.hireDate2Fmt}">
							<div style="padding:5px,0,0,5px;">
							- 채용일자 : ${item.hireDate2Fmt}
							</div>
						</c:if>
						<c:if test="${!empty item.hireType2}">
							<div style="padding:5px,0,0,5px;">
							- 채용직종 : ${item.hireType2}
							</div>
						</c:if>
						<c:if test="${!empty item.officeName2}">
							<div style="padding:5px,0,0,5px;">
							- 사업장명 : ${item.officeName2}
							</div>
						</c:if>
						<c:if test="${!empty item.disasterDate2Fmt}">
							<div style="padding:5px,0,0,5px;">
							- 재해일자 : ${item.disasterDate2Fmt}
							</div>
						</c:if>						
						<c:if test="${!empty item.disasterType2}">
							<div style="padding:5px,0,0,5px;">
							- 재해유형 : ${item.disasterType2}
							</div>
						</c:if>
						<c:if test="${!empty item.disasterContent2}">
							<div style="padding:5px,0,0,5px;">
							- 재해경위 : ${fn:replace(item.disasterContent2,LF,'<br/>')}
							</div>
						</c:if>
						<c:if test="${!empty item.obstacleLevel2}">
							<div style="padding:5px,0,0,5px;">
							- 장해등급 : ${item.obstacleLevel2}
							</div>
						</c:if>
						<c:if test="${!empty item.option2}">
							<div style="padding:5px,0,0,5px;">
							- 기타사항 : ${fn:replace(item.option2,LF,'<br/>')}
							</div>
						</c:if>
					</td>
					<td width="20%">
		    			${item.remarkContent2}
		    		</td>		    		
				</tr>
			</c:forEach>
			<c:forEach var="item" items="${reportOfficeList3}" varStatus="status">
				<tr>
					<td width="20%" style="text-align:center;">
		    			${item.writeDate3Fmt}
		    		</td>
		    		<td width="60%">    			
						<c:if test="${!empty item.occurDate3}">
							<div style="padding:5px,0,0,5px;">
							- 발생일시 : ${item.occurDate3}
							</div>
						</c:if>
						<c:if test="${!empty item.occurSpot3}">
							<div style="padding:5px,0,0,5px;">
							- 발생장소 : ${item.occurSpot3}
							</div>
						</c:if>
						<c:if test="${!empty item.deadDate3}">
							<div style="padding:5px,0,0,5px;">
							- 사망일시 : ${item.deadDate3}
							</div>
						</c:if>
						<c:if test="${!empty item.deadCause3}">
							<div style="padding:5px,0,0,5px;">
							- 사망원인 : ${item.deadCause3}
							</div>
						</c:if>
						<c:if test="${!empty item.agreeContent3}">
							<div style="padding:5px,0,0,5px;">
							- 협의내용 : ${fn:replace(item.agreeContent3,LF,'<br/>')}
							</div>
						</c:if>
						<c:if test="${!empty item.resultInfo3}">
							<div style="padding:5px,0,0,5px;">
							- 검안결과 : ${item.resultInfo3}
							</div>
						</c:if>
						<c:if test="${!empty item.resultComment3}">
							<div style="padding:5px,0,0,5px;">
							- 내사의견 : ${fn:replace(item.resultComment3,LF,'<br/>')}
							</div>
						</c:if>
						<c:if test="${!empty item.familyComment3}">
							<div style="padding:5px,0,0,5px;">
							- 유족진술 : ${fn:replace(item.familyComment3,LF,'<br/>')}
							</div>
						</c:if>
						<c:if test="${!empty item.option3}">
							<div style="padding:5px,0,0,5px;">
							- 기타사항 : ${fn:replace(item.option3,LF,'<br/>')}
							</div>
						</c:if>
					</td>
					<td width="20%">
		    			${item.remarkContent3}
		    		</td>		    		
				</tr>
			</c:forEach>
			<c:forEach var="item" items="${reportOfficeList4}" varStatus="status">
				<tr>
					<td width="20%" style="text-align:center;">
		    			${item.writeDate4Fmt}
		    		</td>
		    		<td width="60%">						
						<c:if test="${!empty item.option4}">
							<div style="padding:5px,0,0,5px;">
							- ${fn:replace(item.option4,LF,'<br/>')}
							</div>
						</c:if>						
					</td>
					<td width="20%">
		    			${item.remarkContent4}
		    		</td>		    		
				</tr>
			</c:forEach>						
		</table>
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
        <!-- 7.기타/특이사항 -->
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell" style="width: 80%;">
                <p class="subtitle">7.기타 / 특이사항</p>
            </div>
        </div>
        <table>	
			<tr>
				<th width="100%" style="text-align:left;padding-left:5px;">확인사항 안내</th>
			</tr>
			<tr>
				<c:forEach var="item" items="${reportOfficeList5}" varStatus="status">			
		    		<td width="100%">						
						<c:if test="${!empty item.confirmContent5}">
							<div style="padding:5px,0,0,5px;">
							${fn:replace(item.confirmContent5,LF,'<br/>')}
							</div>
						</c:if>						
					</td>		    		
				</c:forEach>
			</tr>			
			<tr>
				<th width="100%" style="text-align:left;padding-left:5px;">특이사항</th>
			</tr>
			<tr>
				<c:forEach var="item" items="${reportOfficeList6}" varStatus="status">			
		    		<td width="100%">						
						<c:if test="${!empty item.uniqueContent6}">
							<div style="padding:5px,0,0,5px;">
							${fn:replace(item.uniqueContent6,LF,'<br/>')}
							</div>
						</c:if>
						<br/>
						<c:if test="${!empty item.insureAddress6}">
							<div style="padding:5px,0,0,5px;">
							<b>피보험자(계약자) 주소 : </b>${item.insureAddress6}
							</div>
						</c:if>						
					</td>		    		
				</c:forEach>
			</tr>
			<tr>
				<th width="100%" style="text-align:left;padding-left:5px;">탐문리스트</th>				
			</tr>
			<tr>
				<c:forEach var="item" items="${reportOfficeList7}" varStatus="status">			
		    		<td width="100%">						
						<c:if test="${!empty item.searchList7}">
							<div style="padding:5px,0,0,5px;">
							${fn:replace(item.searchList7,LF,'<br/>')}
							</div>
						</c:if>										
					</td>
				</c:forEach>
			</tr>
		</table>

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
        <c:choose>
        	<c:when test="${reportBscInfo.ptnrId == '9'}">
        		<%-- 롯데용 처리과정 출력시작 --%>
        		<table class="center">
			        <col width="15%">
			        <col width="10%">
			        <col width="21%">
			        <col width="20%">
			        <col width="15%">
			        <col width="10%">			        
			        <tr>
			            <th>일자</th>
			            <th>일수</th>
			            <th>업무내용</th>
			            <th>세부내용</th>
			            <th>지연주체</th>
			            <th>지연일수</th>			            
			        </tr>
			        <c:forEach var="item" items="${reportAccidentProcessList}" varStatus="status">
			            <tr id="tr_accident_process_view${status.index}">
			                <td>${item.controlDate}</td>
			                <td>${item.controlDateCnt}일</td>
			                <td>${item.controlSubject}</td>
			                <td>${item.controlMemo}</td>
			                <td>
			                    <c:choose>
			                        <c:when test="${item.controlDelayAgent == 1}">보험사</c:when>
			                        <c:when test="${item.controlDelayAgent == 2}">수익자</c:when>
			                        <c:when test="${item.controlDelayAgent == 3}">계약자</c:when>
			                        <c:when test="${item.controlDelayAgent == 4}">피보험자</c:when>
			                    </c:choose>
			                </td>
			                <td>${item.controlDelayCnt}일</td>			                
			            </tr>			            
			        </c:forEach>			        
			        <tfoot id="tfoot_accident_process_view">
			        <tr>
			            <th colspan="5">
			                <span style="color: red">총지연일수</span>
			            </th>
			            <td>${reportPrint1.printctrlAllDelayCnt}일</td>
			        </tr>
			        <tr>
			            <th colspan="5">
			                <span style="color: red">계약자, 피보험자, 수익자의 책임있는 사유 조사 지연일수</span>
			            </th>
			            <td>${reportPrint1.printctrlNotinsuDelayCnt}일</td>
			        </tr>
			        <tr>
			            <th colspan="5" style="background-color: yellow">
			                <span style="color: red">보험사 지연일수</span>
			            </th>
			            <td>${reportPrint1.printctrlInsuDelayCnt}일</td>
			        </tr>
			        </tfoot>			        
			    </table>
                <%-- 롯데용 처리과정 출력 종료 --%>
            </c:when>
            <c:otherwise>
                <table cellpadding="0" cellspacing="0" align="center">
		            <tr>
		                <th width="102">일자</th>
		                <th width="269">업무내용</th>
		                <th width="269">세부내용</th>
		            </tr>
		            <c:forEach var="item" items="${sagoList}" varStatus="status">
		                <tr>
		                    <td class="text-center">${item.regDate}</td>
		                    <td style="padding: 0px 5px;">${item.item}</td>
		                    <td style="padding: 0px 5px;">${item.content}</td>
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
