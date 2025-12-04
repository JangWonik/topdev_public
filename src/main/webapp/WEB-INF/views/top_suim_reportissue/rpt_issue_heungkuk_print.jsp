<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge;text/html; charset=UTF-8">
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/jquery/jquery-ui.min.js"></script>	
	<!-- 상단 include 페이지의 css 적용 -->
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=201705231112" />
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<!-- 상단 include 페이지의 css 적용 -->
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/rpt_issue.css?v=20181204?v=2018"/>	
		
	<script type="text/javascript">
    $(document).ready(function() {
		window.print();
    });
</script>
</head>
<div class="reportWrap">
    <div class="issue_reportContent">    	
    	<div class="text-center">
    		<p class="text-center">
    		<span style="font-size: 20px;">
    		<b>
    		<c:if test="${ctype eq 'C'}">
   				재물보험 손해사정서
   			</c:if>
   			<c:if test="${ctype eq 'B'}">
   				배상책임보험 손해사정서
   			</c:if>
   			<c:if test="${ctype eq 'I'}">
   				인보험 손해사정서
   			</c:if>
    		</b>
    		</span></p>    		
    	</div>
    	<div class="display-table" style="margin-top: 10px;">
	    	<!-- 1. 계약사항 -->    	
	        <div class="display-cell">
				<p class="subtitle">1. 계약사항</p>			
			</div>			
       	</div>
		<div class="issue_lotte">			
			<table id="table_issue_contract_view" style="border: 1px solid currentColor;">
				<colgroup>
					<col width="15%">			
					<col width="85%">
				</colgroup>                
				<tbody>
				<tr style="height:12px;">
				 	<th><b>구분</b></th>
				 	<th><b>계약사항</b></th>
			 	</tr>
			 	<tr style="height:12px;">
				    <th><b>보험종목</b></th>
				    <td style="text-align: left;padding-left:5px;">${rptIssueMain.insuranceNm}</td>                    
				</tr>
				<tr style="height:12px;">
				    <th><b>증권번호</b></th>
				    <td style="text-align: left;padding-left:5px;">${rptIssueMain.policyNo}</td>                    
				</tr>
				<tr style="height:12px;">
				    <th><b>계 약 자</b></th>
				    <%-- <td style="text-align: left;padding-left:5px;">${suimVO.getPolicyholder_nm()}</td> --%>
				    <td style="text-align: left;padding-left:5px;">${sHiddenPolicyNm}</td>                    
				</tr>
				<tr style="height:12px;">
				    <th><b>피보험자</b></th>
				    <%-- <td style="text-align: left;padding-left:5px;">${suimVO.getBeneficiary_nm()}</td> --%>
				    <td style="text-align: left;padding-left:5px;">${sHiddenBenefitNm}</td>                    
				</tr>
				<c:if test="${ctype eq 'C' || ctype eq 'B' }">
				<tr style="height:12px;">
				    <th><b>소 재 지</b></th>
				    <td style="text-align: left;padding-left:5px;">${ rptIssue.suimAddress }</td>                    
				</tr>
				</c:if>
				<tr style="height:12px;">
				    <th><b>보험기간</b></th>
				    <td style="text-align: left;padding-left:5px;">${suimVO.insuTerm}</td>                    
				</tr>			
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
        	<c:choose>
        		<c:when test="${ctype eq 'I'}">
        			<colgroup>
	                    <col width="17%">
	                    <col width="83%">                    
	                </colgroup>                
	                <tbody>
	                <tr style="height:12px;">
	                	<th><b>구분</b></th>
	                	<th><b>상세내용</b></th>                	
	                </tr>
	                <tr style="height:12px;">
	                    <th><b>사고(진료)일시</b></th>
	                    <td  style="text-align: left;padding-left:5px;">${suimVO.accident_date}</td>                    
	                </tr>	                   
	                <tr style="height:12px;">
	                    <th><b>사고(진단)내용</b></th>
	                    <td  style="text-align: left;padding-left:5px;">
	                    	<c:out value="${rptIssue.insuContent}"/>                    	
	                    </td>                    
	                </tr>
        		</c:when>
        		<c:otherwise>
        			<colgroup>
	                    <col width="15%">
	                    <col width="85%">                    
	                </colgroup>                
	                <tbody>
	                <tr style="height:12px;">
	                	<th><b>구분</b></th>
	                	<th><b>상세내용</b></th>                	
	                </tr>
	                <tr style="height:12px;">
	                    <th><b>사고일시</b></th>
	                    <td  style="text-align: left;padding-left:5px;">${suimVO.accident_date}</td>                    
	                </tr>
	                <tr style="height:12px;">
	                    <th><b>사고장소</b></th>
	                    <td  style="text-align: left;padding-left:5px;">
	                    	<c:out value="${suimVO.investigate_addr1}"/><c:out value="${suimVO.investigate_addr2}"/>
	                    </td>
	                </tr>   
	                <tr style="height:12px;">
	                    <th><b>사고원인</b></th>
	                    <td  style="text-align: left;padding-left:5px;">
	                    	<c:out value="${rptIssue.insuContent}"/>                    	
	                    </td>                    
	                </tr>
        		</c:otherwise>
        	</c:choose>  
            </tbody>
		</table>
		</div>
		<!-- 3총괄표 -->
		<div class="display-table" style="margin-top: 10px;">	    	    	
	        <div class="display-cell">
				<p class="subtitle">3. 총괄표</p>			
			</div>
			<div class="display-cell text-right" style="vertical-align:bottom;">
	       		<p style="font-size:12px;">(단위 : 원)</p>
	       	</div>			
       	</div>       	
		<div class="issue_lotte">
			<table id="table_issue_contract_view" style="border: 1px solid currentColor;">
				<c:if test="${ctype eq 'C'}">
				<colgroup>
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
				</colgroup>                
				<tbody>
					<tr style="height:12px;">
						<th><b>목적물</b></th>
						<th><b>보험가입금액</b></th>
						<th><b>보험가액</b></th>
						<th><b>손해액</b></th>
						<th><b>잔존물</b></th>
						<th><b>지급보험금</b></th>                	
					</tr>
					<c:forEach items="${rptIssueSummaryList}" var="item" varStatus="status">
						<tr style="height:12px;">                	
							<td>${item.summaryCate}</td>					
							<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.joinPrice}" pattern="#,###" /></td>
							<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.insuPrice}" pattern="#,###" /></td>
							<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.lossPrice}" pattern="#,###" /></td>
							<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.remainPrice}" pattern="#,###" /></td>
							<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.payPrice}" pattern="#,###" /></td>
						</tr>
					</c:forEach>
					<tr style="height:12px;">                	
							<td><b>합계</b></td>
							<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_joinPrice}" pattern="#,###" /></b></td>
							<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_insuPrice}" pattern="#,###" /></b></td>
							<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_lossPrice}" pattern="#,###" /></b></td>
							<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_remainPrice}" pattern="#,###" /></b></td>
							<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_payPrice}" pattern="#,###" /></b></td>
					</tr>
					<tr style="height:12px;">
						<th><b>자기부담금</b></th>
						<td colspan="5" style="text-align: right;padding-right:5px;">${rptIssueMain.amtSelfPayUnit} <fmt:formatNumber value="${rptIssueMain.amtSelfPay}" pattern="#,###" /></td>                	
					</tr>			                
				</tbody>		
				</c:if>
				<c:if test="${ctype eq 'B'}">
				<colgroup>
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
					<col width="15%">			
				</colgroup>                
				<tbody>
					<tr style="height:12px;">
						<th><b>목적물</b></th>
						<th><b>보상한도액</b></th>
						<th><b>손해액</b></th>
						<th><b>공제금액</b></th>				
						<th><b>지급보험금</b></th>
						<th><b>비고</b></th>                	
					</tr>
					<c:forEach items="${rptIssueSummaryList}" var="item" varStatus="status">
						<tr style="height:12px;">                	
							<td>${item.summaryCate}</td>					
							<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.compLimitPrice}" pattern="#,###" /></td>
							<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.lossPrice}" pattern="#,###" /></td>
							<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.netLossPrice}" pattern="#,###" /></td>					
							<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.payPrice}" pattern="#,###" /></td>
							<td style="text-align: right;padding-right:5px;">${item.exceptionVal}</td>
						</tr>
					</c:forEach>
					<tr style="height:12px;">                	
							<td><b>합계</b></td>
							<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_compLimitPrice}" pattern="#,###" /></b></td>
							<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_lossPrice}" pattern="#,###" /></b></td>
							<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_netLossPrice}" pattern="#,###" /></b></td>
							<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_payPrice}" pattern="#,###" /></b></td>
							<td style="text-align: right;padding-right:5px;"></td>
					</tr>			                
				</tbody>		
				</c:if>
				<c:if test="${ctype eq 'I'}">
					<colgroup>
						<col width="15%">
						<col width="15%">
						<col width="15%">
						<col width="15%">
						<col width="15%">
						<col width="15%">			
					</colgroup>                
					<tbody>
						<tr style="height:12px;">
							<th><b>증권번호</b></th>
							<th><b>담보명</b></th>
							<th><b>가입금액</b></th>
							<th><b>청구금액</b></th>
							<th><b>지급금액</b></th>				
							<th><b>비고</b></th>                	
						</tr>
						<c:forEach items="${rptIssueSummaryList}" var="item" varStatus="status">
							<tr style="height:12px;">                	
								<td>${item.insuNm}</td>
								<td>${item.summaryCate}</td>					
								<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.joinPrice}" pattern="#,###" /></td>
								<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.billPrice}" pattern="#,###" /></td>
								<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${item.payPrice}" pattern="#,###" /></td>					
								<td style="text-align: left;padding-left:5px;">${item.exceptionVal}</td>
							</tr>
						</c:forEach>
						<tr style="height:12px;">                	
								<td><b>합계</b></td>
								<td></td>
								<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_joinPrice}" pattern="#,###" /></b></td>
								<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_billPrice}" pattern="#,###" /></b></td>
								<td style="text-align: right;padding-right:5px;"><b><fmt:formatNumber value="${sum_payPrice}" pattern="#,###" /></b></td>
								<td style="text-align: right;padding-right:5px;"></td>
						</tr>			                
					</tbody>
				</c:if>		
			</table>
			<div class="display-table">
				<div class="display-cell">
					<p class="subtitle">
					<c:choose>
						<c:when test="${ctype eq 'I'}">
							4. 확인사항
						</c:when>
						<c:otherwise>
							4. 특이사항
						</c:otherwise>
					</c:choose>
					</p>
				</div>
			</div>
			<div class="issue_lotte">
				<table id="table_issue_contract_view" style="border: 1px solid currentColor;">
					<tr style="height:20px;">
						<td style="text-align: left;padding-left:5px;">${rptIssue.remarkVal}</td>
					</tr>				
				</table>					
			</div>					
		<br/>
		<br/>		
		<table>
			<tr>
				<td><p style="font-size:15px;font-weight:bold;text-align:center;"><c:out value="${fn:replace(nowdate,'-', '.')}"/></p></td>
			</tr>	
		</table>		
		<br/>
		<!-- 조사자, 담당손해사정사 시작 -->		 	
		<c:choose>
			<c:when test="${empty certiReportUser}">
				<div style="padding:20px 0 20px 0;">
					<table>
						<tr>					 			
							<td style="font-weight:bold; color: red; text-align:left;">
								[미배당건으로 담당자 정보가 없습니다.]
							</td>					 			
						</tr>					 		
					</table>
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${certiReportUser}" var="certiUserVo">
					<div style="padding:10px 0 10px 0;">
						<table>
							<tr>						 			
								<td width="12%" style="font-weight:bold; text-align:left;">
									${certiUserVo.certi_state_val}
								</td>
								<td width="20%" style="font-weight:bold; text-align:center;">
									${certiUserVo.user_name}
								</td>
								<td width="18%" style="font-weight:bold; text-align:left;">						 										 				
									<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${certiUserVo.user_no}/${certiUserVo.user_sign}" width="30px" height="20px">
								</td>
								<td width="50%" style="font-weight:bold; text-align:left;"></td>						 			
							</tr>
							<tr>
								<td colspan="4" style="font-weight:bold; text-align:left;">
								 [ 등록번호 : ${certiUserVo.certi_number} <c:if test='${certiUserVo.work_phone != ""}'>/ 연락처 : ${certiUserVo.work_phone} </c:if>]
								</td>						 							 			
							</tr>
						</table>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>		 	
		<!-- 조사자, 담당손해사정사 끝 -->
		<%-- <table>
			<colgroup>
			    <col width="50%">
			    <col width="50%">
			</colgroup>
			<tbody>				
				<tr>
					<td></td>
					<td><b>담 당 자 : ${reportInvgUser.disWorkLevel} ${reportInvgUser.userName}  (연락처 : ${reportInvgUser.handphone})</b></td>	
				</tr>
				<tr>
					<td></td>
					<td><b>대표손해사정사 : 윤경수</b><img alt="윤경수" src="./resources/ne_img/sign_yun.jpg" width="50" height="30"></td>	
				</tr>
			</tbody>			
		</table> --%>		
		<br/>
		<div align="center"><img src="https://www.toplac.co.kr/resources/ne_img/sign_ceo.jpg" border="0"/></div>					
    </div>
    </div>    
</div>
<br/>
<br/>