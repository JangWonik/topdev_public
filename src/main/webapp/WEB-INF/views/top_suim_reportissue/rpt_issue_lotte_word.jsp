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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
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
        tr {height: 42px;}
        th {background-color: #E7ECF1; font-weight: normal; text-align: center; word-wrap:break-word;}
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
		.reportContent th {padding: 8px 0px 4px 20px; border: 0px solid; background-color: #FFF; text-align: left; vertical-align: top; font-weight: normal;}
		.reportContent td {border: 0px solid; vertical-align: top; text-align: left;}


        .l {text-align: left;}
        .r {text-align: right;}
        .c {text-align: center;}

	#table_issue_contract_view th {padding: 4px 0px 4px 0px; border: 1px solid; background-color: #E7ECF1; text-align: center; vertical-align:middle; font-weight: normal; border-bottom: 1px;}
	#table_issue_contract_view td {border: 1px solid; text-align: center; vertical-align: middle;}
	#table_accident_view th {padding: 4px 0px 4px 0px; border: 1px solid; background-color: #E7ECF1; text-align: center; vertical-align:middle; font-weight: normal; border-bottom: 1px;}
	#table_accident_view td {border: 1px solid; text-align: center; vertical-align: middle;}
	.issue_reportContent .display-cell{
	    display: table-cell;
	    vertical-align: middle;
	    float: none;
	}	
</style>
</head>
<div class="reportWrap">
    <div class="issue_reportContent">
	    <table id="container_table" align="center" cellpadding="0" cellspacing="0" width="640" style="border: none;">
		    <tr>
		    	<td>
		    		<div class="text-center" align="center" style="margin-top: -5px;">
		    		<p class="text-center"><span style="font-size: 20px;"><b>
		    		<c:if test="${ctype eq 'C'}">
		   				재물보험 손해 사정서
		   			</c:if>
		   			<c:if test="${ctype eq 'B'}">
		   				배상책임보험 손해 사정서
		   			</c:if>
		   			<c:if test="${ctype eq 'T'}">
		   				여행자보험 손해 사정서
		   			</c:if>
		    		</b></span></p>    		
		    	</div>
		    	<div class="display-table" style="margin-top: 10px;">
			    	<!-- 1. 계약사항 -->    	
			        <div class="display-cell">
						<p class="subtitle">1. 계약사항</p>			
					</div>			
		       	</div>
				<div class="issue_lotte">			
					<table id="table_issue_contract_view" style="border: 1px solid currentColor;">						         
						<tbody>
						<tr style="height:12px;">
						 	<th colspan="2" style="width:25%;"><b>구분</b></th>
						 	<th style="width:75%;"><b>계약사항</b></th>
					 	</tr>
					 	<tr style="height:12px;">
						    <th colspan="2" style="width:25%;"><b>보험종목 / 증권번호</b></th>
						    <td style="width:75%;text-align: left;padding-left:5px;">${rptIssueMain.insuranceNm} / ${rptIssueMain.policyNo}</td>                    
						</tr>   
						<tr style="height:12px;">
							<th colspan="2" style="width:25%;"><b>계약자 / 피보험자</b></th>
							<%-- <td style="width:75%;text-align: left;padding-left:5px;">${suimVO.getPolicyholder_nm()} / ${suimVO.getBeneficiary_nm()}</td> --%>
							<td style="width:75%;text-align: left;padding-left:5px;">${sHiddenPolicyNm} / ${sHiddenBenefitNm}</td>                    
						</tr>
						<c:if test="${ ctype eq 'C' || ctype eq 'B' }">                    
						<tr style="height:12px;">
							<th colspan="2" style="width:25%;"><b>소재지</b></th>
							<td style="width:75%;text-align: left;padding-left:5px;">                    	 
							<%-- 우편번호 : <span id="vZipcode">${ rptIssue.suimZipcode }</span><br/> --%>
							<span id="vAddress">${ rptIssue.suimAddress }</span><br/>					    
							</td>
						</tr>
						</c:if>
						<tr style="height:12px;">
							<th colspan="2" style="width:25%;"><b>보험기간</b></th>
							<td style="width:75%;text-align: left;padding-left:5px;"><span id="vInsuterm">${suimVO.insuTerm}</span></td>                    
						</tr>
						<c:if test="${ rowSpan eq 0 }">
					        <tr style="height:12px;">
								<th rowspan="${rowSpan}" style="width:10%;">
								<b>
								<c:if test="${ctype eq 'C'}">
									보험<br/>목적물
								</c:if>
								<c:if test="${ctype eq 'B' || ctype eq 'T'}">
									계약약관
								</c:if>
								</b><br/>						                	
								</th>
								<th style="width:15%;">
								<b>-</b>						
								</th>
								<td  style="width:75%;text-align: left;padding-left:5px;">-</td>										
							</tr>
						</c:if>				
						<c:forEach items="${rptIssueContList}" var="item" varStatus="status">
							<tr style="height:12px;">
							<c:if test="${ status.index == 0 }">			
								<th rowspan="${rowSpan}" style="width:10%;">
									<b>
									<c:if test="${ctype eq 'C'}">
										보험<br/>목적물
									</c:if>
									<c:if test="${ctype eq 'B' || ctype eq 'T'}">
										계약약관
									</c:if>
									</b>
									<br/>						                	
								</th>
							</c:if>
							<th style="width:15%;">
								<b>${ item.contCate }</b>						
							</th>                
							<td  style="width:75%;text-align: left;padding-left:5px;">${ item.contContent }</td>										
							</tr>
						</c:forEach>
					</table>	
				</div>
		                        
				<!-- 2. 사고사항 -->
				<div class="display-table" style="margin-top: 10px;">
			    	<!-- 1. 계약사항 -->    	
			        <div class="display-cell">
						<p class="subtitle">2. 사고사항</p>			
					</div>
				</div>
				<div class="issue_lotte">        
		        	<table id="table_issue_contract_view" style="border: 1px solid currentColor;">		                
		                <tr style="height:12px;">
		                	<th style="width:15%;"><b>구분</b></th>
		                	<th style="width:85%;"><b>상세내용</b></th>                	
		                </tr>
		                <tr style="height:12px;">
		                    <th style="width:15%;"><b>사고일시</b></th>
		                    <td  style="width:85%;text-align: left;padding-left:5px;">${suimVO.accident_date}</td>                    
		                </tr>
		                <tr style="height:12px;">
		                    <th style="width:15%;"><b>사고장소</b></th>
		                    <td style="width:85%;text-align: left;padding-left:5px;">
		                    	<c:out value="${suimVO.investigate_addr1}"/><%-- <c:out value="${suimVO.investigate_addr2}"/> --%>
		                    </td>
		                </tr>   
		                <tr style="height:12px;">
		                    <th style="width:15%;"><b>사고내용</b></th>
		                    <td style="width:85%;text-align: left;padding-left:5px;">
		                    	${rptIssue.insuContent}
		                    	<%-- <c:out value="${suimVO.getAccident_facts()}"/> --%>
		                    </td>                    
		                </tr>
		                <c:if test="${ctype eq 'B' }">
		                <tr style="height:12px;">
							<th style="width:15%;"><b>피해자</b></th>
							<td style="width:85%;text-align: left;padding-left:5px;">${suimVO.getDamaged_nm()}</td>
						</tr>
		                </c:if>		            
				</table>
				</div>
				<!-- 3총괄표 -->
				<div class="display-table" style="margin-top: 10px;">	    	    	
			        <div class="display-cell">
						<p class="subtitle">3. 총괄표</p>			
					</div>			
		       	</div>
				<div class="issue_lotte">
					<table id="table_issue_contract_view" style="border: 1px solid currentColor;">
						<c:if test="${ctype eq 'C'}">						
						<tr style="height:12px;">
							<th><b>목적물</b></th>
							<th><b>가입금액</b></th>
							<th><b>보험가액</b></th>
							<th><b>손해액</b></th>
							<th><b>잔존물</b></th>
							<th><b>약관상<br/>지급책임액</b></th>                	
						</tr>
						<c:forEach items="${rptIssueSummaryList}" var="item" varStatus="status">
							<tr style="height:12px;">                	
								<td>${item.summaryCate}</td>
								<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.joinPrice}" pattern="#,###" />&nbsp;</td>
								<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.insuPrice}" pattern="#,###" />&nbsp;</td>
								<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.lossPrice}" pattern="#,###" />&nbsp;</td>
								<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.remainPrice}" pattern="#,###" />&nbsp;</td>
								<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.responPrice}" pattern="#,###" />&nbsp;</td>
							</tr>
						</c:forEach>
						<tr style="height:12px;">                	
								<td><b>합계</b></td>
								<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_joinPrice}" pattern="#,###" /></b>&nbsp;</td>
								<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_insuPrice}" pattern="#,###" /></b>&nbsp;</td>
								<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_lossPrice}" pattern="#,###" /></b>&nbsp;</td>
								<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_remainPrice}" pattern="#,###" /></b>&nbsp;</td>
								<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_responPrice}" pattern="#,###" /></b>&nbsp;</td>
						</tr>
						<tr style="height:12px;">
							<td>자기부담금</td>
							<td colspan="5" style="text-align: right;padding-right:5px;">${rptIssueMain.amtSelfPayUnit} <fmt:formatNumber value="${rptIssueMain.amtSelfPay}" pattern="#,###" /></td>                	
						</tr>
						<tr style="height:12px;">
							<th>비고</th>
							<td colspan="5" style="text-align: left;padding-left:5px;">${rptIssue.remarkVal}</td>                	
						</tr>	
						</c:if>
						<c:if test="${ctype eq 'B'}">
						<tr style="height:12px;">
							<th><b>목적물</b></th>
							<th><b>보상한도액</b></th>
							<th><b>배상책임액</b></th>
							<th><b>자기부담금</b></th>				
							<th><b>약관상<br/>지급책임액</b></th>                	
						</tr>
						<c:forEach items="${rptIssueSummaryList}" var="item" varStatus="status">
							<tr style="height:12px;">                	
								<td>${item.summaryCate}</td>								
								<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.compLimitPrice}" pattern="#,###" />&nbsp;</td>
								<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.compResponPrice}" pattern="#,###" />&nbsp;</td>
								<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.selfOptPrice}" pattern="#,###" />&nbsp;</td>					
								<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.responPrice}" pattern="#,###" />&nbsp;</td>
							</tr>
						</c:forEach>
						<tr style="height:12px;">                	
								<td><b>합계</b></td>
								<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_compLimitPrice}" pattern="#,###" /></b>&nbsp;</td>
								<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_compResponPrice}" pattern="#,###" /></b>&nbsp;</td>
								<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_selfOptPrice}" pattern="#,###" /></b>&nbsp;</td>
								<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_responPrice}" pattern="#,###" /></b>&nbsp;</td>
						</tr>						
						<tr style="height:12px;">
							<th>비고</th>
							<td colspan="5" style="text-align: left;padding-left:5px;">${rptIssue.remarkVal}</td>                	
						</tr>
						</c:if>
						<c:if test="${ctype eq 'T'}">						
						<tr style="height:12px;">
							<th><b>목적물</b></th>
							<th><b>가입금액</b></th>
							<th><b>보험가액</b></th>
							<th><b>손해액</b></th>
							<th><b>자기부담금</b></th>
							<th><b>약관상<br/>지급책임액</b></th>                	
						</tr>
						<c:forEach items="${rptIssueSummaryList}" var="item" varStatus="status">
							<tr style="height:12px;">                	
								<td>${item.summaryCate}</td>
								<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.joinPrice}" pattern="#,###" />&nbsp;</td>
								<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.insuPrice}" pattern="#,###" />&nbsp;</td>
								<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.lossPrice}" pattern="#,###" />&nbsp;</td>
								<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.selfOptPrice}" pattern="#,###" />&nbsp;</td>
								<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.responPrice}" pattern="#,###" />&nbsp;</td>
							</tr>
						</c:forEach>
						<tr style="height:12px;">                	
								<td><b>합계</b></td>
								<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_joinPrice}" pattern="#,###" /></b>&nbsp;</td>
								<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_insuPrice}" pattern="#,###" /></b>&nbsp;</td>
								<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_lossPrice}" pattern="#,###" /></b>&nbsp;</td>
								<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_selfOptPrice}" pattern="#,###" /></b>&nbsp;</td>
								<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_responPrice}" pattern="#,###" /></b>&nbsp;</td>
						</tr>						
						<tr style="height:12px;">
							<th>비고</th>
							<td colspan="5" style="text-align: left;padding-left:5px;">${rptIssue.remarkVal}</td>                	
						</tr>	
						</c:if>					
					</table>					
				<br/>
				<p style="font-size: 9pt; text-align: left; ">
				* 상기와 같이 손해액이 산정되었음을 안내드리며, 보험회사의 검토 과정상 일부 금액의 변동이 있을 수 있습니다.
				</p>
				<br/>
				<!-- 조사자, 담당손해사정사 시작 -->		 	
				<c:choose>
					<c:when test="${empty certiReportUser}">						
						<table>
							<tr>					 			
								<td style="font-weight:bold; color: red; text-align:left;">
									[미배당건으로 담당자 정보가 없습니다.]
								</td>					 			
							</tr>					 		
						</table>						
					</c:when>
					<c:otherwise>
						<c:forEach items="${certiReportUser}" var="certiUserVo">							
							<table>
								<tr>						 			
									<td width="12%" style="font-weight:bold; text-align:left;">
										${certiUserVo.certi_state_val}
									</td>
									<td width="20%" style="font-weight:bold; text-align:center;">
										${certiUserVo.user_name}
									</td>
									<td width="18%" style="font-weight:bold; text-align:left;">						 										 				
										<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${certiUserVo.user_no}/${certiUserVo.user_sign}" width="50" height="30">
									</td>
									<td width="50%" style="font-weight:bold; text-align:left;"></td>						 			
								</tr>
								<tr>
									<td colspan="4" style="font-weight:bold; text-align:left;">
									 [ 등록번호 : ${certiUserVo.certi_number} <c:if test='${certiUserVo.work_phone != ""}'>/ 연락처 : ${certiUserVo.work_phone} </c:if>]
									</td>						 							 			
								</tr>
							</table>							
						</c:forEach>
					</c:otherwise>
				</c:choose>		 	
				<!-- 조사자, 담당손해사정사 끝 -->			
				<%-- <table>					
					<tbody>								
						<tr style="height:10px;">
							<td style="width:50%;"></td>
							<td style="width:50%;text-align: left;"><b>수임일자 : ${suimVO.getReg_date()}</b></td>	
						</tr>
						<tr style="height:10px;">
							<td style="width:50%;"></td>
							<td style="width:50%;text-align: left;">
								<b>작성일자 : ${nowdate}</b>
							</td>						
						</tr>
						<tr style="height:10px;">
							<td style="width:50%;"></td>
							<td style="width:50%;text-align: left;"><b>조 사 자 : ${reportInvgUser.disWorkLevel} ${reportInvgUser.userName}  (연락처 : ${reportInvgUser.handphone})</b></td>	
						</tr>
						<tr>
							<td style="width:50%;"></td>
							<td style="width:50%;text-align: left;"><b>대표손해사정사 : 윤경수</b><img alt="윤경수" src="https://www.toplac.co.kr/resources/ne_img/sign_yun.jpg" width="50" height="30"></td>	
						</tr>								
				</table> --%>				
				<br/>				
				<div align="center"><img src="https://www.toplac.co.kr/resources/ne_img/sign_ceo.jpg" border="0"/></div>					
		    </div>
	    	</td>
	    </tr>
    	</table>    	
    </div>    
</div>