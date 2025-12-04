<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<c:set var="suim_accept_no" value="${rptIssueMain.suimAcceptNo}"/>
<%
    String suim_accept_no = (String)pageContext.getAttribute("suim_accept_no");
    response.setHeader("Content-Disposition", "attachment; filename=issue_"+suim_accept_no+".doc");
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
        body,table {font-size:10pt;font-family:'굴림','굴림체','돋움','Nanum Gothic', 'verdana'; color:#000;}

        /* 마진과 패딩의 초기화 */
        body, div, p, th, textarea {margin:0;padding:0; font-size:10pt;}        
		td {margin:0;padding:0; font-size:9pt;}
        /* 테이블 스타일 초기화 */
        table {border-collapse:collapse;border-spacing:0; table-layout:fixed;width:640px;}
        table th td {border: 1px solid black;}
        tr {height: 22px;}
        th {background-color: #E7ECF1; font-weight: bold; text-align: center; word-wrap:break-word;}
        td {font-weight: normal; word-break: break-all; word-wrap:break-word;}
        td .title{font-weight: bold} */


        #receive_table tr {height: 30px;}
        #receive_table td {font-weight: bold;}

        #approval_table td {text-align: center;} */
        #approval table tr:first-child {height: 42px;}
        #approval table th {background-color: #FFF3F3;}


        /* 이미지 및 필드셋에서 보더 표시 초기화 */
         img {border:0;}
        img {vertical-align:middle;}

        body {width:100%;}
        p {line-height: 150%;}
        p.title {font-weight: bold; margin: 10px 10px 8px 0px;}
        p.subtitle {font-weight: bold; margin: 0px 0px 0px 0px; font-size: 11pt !important;}
		p.subtitle2 {line-height: 70%;}
        .panel-title {font-weight: bold;}

		.reportContent tr {height: 35px;}
		.reportContent th {padding: 8px 0px 4px 20px; border: 0px solid; background-color: #FFF; text-align: left; vertical-align: top; font-weight: bold;}
		.reportContent td {border: 0px solid; vertical-align: top; text-align: left;}


        .l {text-align: left;}
        .r {text-align: right;}
        .c {text-align: center;}

	#table_issue_contract_view th {padding: 4px 0px 4px 0px; border: 1px solid; background-color: #E7ECF1; text-align: center; vertical-align:middle; font-weight: bold; border-bottom: 1px;}
	#table_issue_contract_view td {border: 1px solid; text-align: center; vertical-align: middle;}
	#table_accident_view th {padding: 4px 0px 4px 0px; border: 1px solid; background-color: #E7ECF1; text-align: center; vertical-align:middle; font-weight: normal; border-bottom: 1px;}
	#table_accident_view td {border: 1px solid; text-align: center; vertical-align: middle;}
    </style>
    
</head>
<body>
<div class="reportWrap">
    <div class="issue_reportContent">
		<table id="container_table" align="center" cellpadding="0" cellspacing="0" width="640" style="border: none;">
		    <tr>    	
		        <td>        	
		        	<div class="text-center" align="center" style="margin-top: -5px;">
				    	<p class="text-center" style="font-size:20px;font-weight:bold;">[손 해 사 정 서]</p>
				    </div>
				    <div class="display-table" style="margin-top: 20px; margin-bottom: 0px">
			            <div class="display-cell">
			                <p class="subtitle">1. 수임 정보</p>
			            </div>
			        </div> 
				    <div>
			            <table width="640" border="1">
							<tr>
								<th>접수번호</th>
								<th>수임일자</th>
								<th>종결일자</th>
							</tr>
							<tr>
								<td style="text-align:center">${rptIssueMain.meritzAcceptNo}</td>
								<td style="text-align:center">${rptIssueMain.regDate}</td>
								<td style="text-align:center">${rptIssueMain.meritzCloseDateFmt}</td>
							</tr>
							<tr>
								<th>수임내용</th>
								<td colspan="2" style="text-align:left;padding:5px;">
									${fn:replace(fn:replace(fn:escapeXml(rptIssueMain.meritzSuimContent) , CRLF , '<br>'), ' ', '&nbsp;')}				
								</td>
							</tr>
						</table>
					</div>
					<div class="display-table" style="margin-top: 20px; margin-bottom: 0px">
			            <div class="display-cell">
			                <p class="subtitle">2. 계약사항</p>
			            </div>
			        </div>
			        <div>
			        	<table width="640" border="1">
							<tr>
								<th colspan="3" width="60%">증권번호</th>
								<th width="40%">상품명</th>			
							</tr>
							<tr>
								<td style="text-align:center" colspan="3">${rptIssueMain.policyNo}</td>
								<td style="text-align:center">${rptIssueMain.insuranceNm}</td>
							</tr>
							<tr>
								<th>계약자</th>
								<th>피보험자</th>
								<th>수익자</th>
								<th>보험기간</th>
							</tr>
							<tr>
								<td style="text-align:center">${rptIssueMain.policyholderNm}</td>
								<td style="text-align:center">${rptIssueMain.beneficiaryNm}</td>
								<td style="text-align:center">${rptIssueMain.meritzBeneficiary}</td>
								<td style="text-align:center">${rptIssueMain.insuTerm}</td>
							</tr>
						</table>
					</div>
					<br/>
					<div>
						<table width="640" border="1">
							<tr>
								<th width="40%">담보명</th>
								<th width="30%">가입금액</th>
								<th width="30%">청구금액</th>
							</tr>
							<c:choose>
								<c:when test="${coverageInfoList.size() == 0}">
									<td colspan="3"></td>
								</c:when>
								<c:otherwise>
									<c:forEach items="${coverageInfoList}" var="item" varStatus="status">			
										<tr>
											<td style="text-align:center">${item.coverageNm}</td>
											<td style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${item.joinPrice}" pattern="#,###" /></td>
											<td style="text-align:right;padding-right:5px;"><fmt:formatNumber value="${item.billPrice}" pattern="#,###" />&nbsp;</td>									
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>				
						</table>
					</div>
					<div class="display-table" style="margin-top: 20px; margin-bottom: 0px">
			            <div class="display-cell">
			                <p class="subtitle">3. 사고 및 손해조사내용</p>
			            </div>
			        </div>
			        <div>
			        	<table width="640" border="1">
			        		<tr>
			        			<td style="text-align:left;padding:5px 5px 5px 5px;">${fn:replace(fn:replace(fn:escapeXml(rptIssue.insuContent) , CRLF , '<br>'), ' ', '&nbsp;')}</td>
			        		</tr>
			        	</table>
			        </div>
			        <div class="display-table" style="margin-top: 20px; margin-bottom: 0px">
			            <div class="display-cell">
			                <p class="subtitle">4. 손해사정시 적용된 관계법규 및 약관</p>
			            </div>
			        </div>
			        <div>
				        <table width="640" border="1">
						    <tr>
						    	<th width="20%">관련법규</th>
						    	<td width="30%" style="text-align:left;padding:5px 5px 5px 5px;">${lawEtcContentInfo.law_subject}</td>
						    	<th width="20%">관련약관</th>
						    	<td width="30%" style="text-align:left;padding:5px 5px 5px 5px;">${lawEtcContentInfo.law_etc}</td>
						    </tr>
						</table>
					</div>
					<div class="display-table" style="margin-top: 20px; margin-bottom: 0px">
			            <div class="display-cell">
			                <p class="subtitle">5. 약관상 보험자 지급책임의 범위</p>
			            </div>
			        </div>
			        <div>
			        	<table width="640" border="1">
							<tr>
								<th width="20%">지급책임</th>		    	
						    	<td width="30%" style="text-align:left;padding:5px 5px 5px 5px;">
						    		<c:choose>
						    			<c:when test="${lawSelContentInfo.reparation_liability_type == 1}">부책</c:when>
						    			<c:when test="${lawSelContentInfo.reparation_liability_type == 2}">면책</c:when>
						    			<c:otherwise> - </c:otherwise>
						    		</c:choose>
						    	</td>
						    	<th width="20%">책임범위</th>		    	
						    	<td width="30%" style="text-align:left;padding:5px 5px 5px 5px;">
						    		<c:choose>
						    			<c:when test="${lawSelContentInfo.reparation_liability_reason_etc == 1}">동 약관 보상하는 손해</c:when>
						    			<c:when test="${lawSelContentInfo.reparation_liability_reason_etc == 2}">동 약관 보상하지 않는 손해</c:when>
						    			<c:otherwise> - </c:otherwise>
						    		</c:choose>
						    	</td>		    	
						    </tr>		    
						</table>
			        </div>
			        <div class="display-table" style="margin-top: 20px; margin-bottom: 0px">
			            <div class="display-cell">
			                <p class="subtitle">6. 그 밖에 손해액 및 보험금 사정에 크게 영향을 미친 사항</p>
			            </div>
			        </div>
			        <div>
			        	<table width="640" border="1">
				        	<tr>
						    	<td style="text-align:left;padding:5px 5px 5px 5px;">
						    		<c:choose>
						    			<c:when test="${empty lawReasonInfo.reparationLiabilityReason}"> - </c:when>
						    			<c:otherwise>
						    				${lawReasonInfo.reparationLiabilityReason}		
						    			</c:otherwise>
						    		</c:choose>    		
						    	</td>
						    </tr>
				        </table>
			        </div>
			        <div class="display-table" style="margin-top: 20px;margin-left:20px;">
			            <div class="display-cell">
			                <p class="subtitle">민감정보가 포함된 내용은 피보험자의 동의가 있을 경우에만 제공됩니다.</p>
			                <p class="subtitle">상기 손해사정결과는 보험금 최종심사 결과와 상이할 수 있습니다.</p>		                
			            </div>
					</div>
			        <div class="display-table" style="margin-top: 20px;text-align:center;">
				        <div class="display-cell">
							<p class="subtitle">
								${rptIssueMain.writeDateFmt}
							</p>
						</div>
					</div>
					<div class="display-table" style="margin-top: 20px;">
						<c:choose>
					 		<c:when test="${empty certiReportUser}">			 			
							 	<table width="640" border="1">
							 		<tr>					 			
							 			<td style="font-size:14px; font-family: 돋움; color: red; text-align:left;">
							 				[미배당건으로 담당자 정보가 없습니다.]
							 			</td>					 			
							 		</tr>					 		
							 	</table>					 	
					 		</c:when>
					 		<c:otherwise>
			 					<table width="640" border="1">
			 						<c:forEach items="${certiReportUser}" var="certiUserVo" varStatus="status">
				 						<tr>
				 							<th width="15%">
				 								<c:choose>
													<c:when test="${status.index eq 0}">조사자</c:when>
													<c:otherwise>${certiUserVo.certi_state_val}</c:otherwise>
												</c:choose>
				 							</th>
				 							<td width="25%" style="text-align:left;padding:5px 5px 5px 5px;">
				 								${certiUserVo.user_name}&nbsp;
				 								<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${certiUserVo.user_no}/${certiUserVo.user_sign}" width="30px" height="20px">
				 							</td>
				 							<th width="10%">등록번호</th>
				 							<td style="text-align:left;padding:5px 5px 5px 5px;">${certiUserVo.certi_number}</td>
				 							<th width="10%">연락처</th>
				 							<td style="text-align:left;padding:5px 5px 5px 5px;"><c:if test='${certiUserVo.work_phone != ""}'>${certiUserVo.work_phone}</c:if></td>
				 						</tr>
			 						</c:forEach>		 						
			 					</table>
					 		</c:otherwise>
					 	</c:choose>
					</div>
					<p style="margin-top: 30px; text-align: center;">
						<img src="https://www.toplac.co.kr/resources/ne_img/sign_ceo.jpg" /> 
					</p>
				</td> <%-- container td--%>
			</tr> <%-- container tr--%>
		</table> <%-- container table--%>
	</div>
</div>

</body>
</html>

