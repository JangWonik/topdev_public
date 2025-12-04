<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
<meta http-equiv="X-UA-Compatible" content="IE=edge;text/html; charset=UTF-8">
	<!-- 상단 include 페이지의 css 적용 -->
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css?v=201705231112" />
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<!-- 상단 include 페이지의 css 적용 -->
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/rpt_issue.css?v=20181204?v=2018"/>		
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script type="text/javascript">
    $(document).ready(function() {
		window.print();
    });
</script>
</head>
<div class="reportWrap">
    <div class="issue_reportContent">    	
    	<div class="text-center">
    		<p class="text-center" style="padding-top: 30px;">
    			<span style="font-size: 20px;border-bottom:1px solid black;"><b>
    			<c:choose>
    				<c:when test="${ctype eq 'C'}">재물보험 손해사정서</c:when>
    				<c:when test="${ctype eq 'B'}">배상책임보험 손해사정서</c:when>
    				<c:when test="${ctype eq 'I'}">인보험 손해사정서</c:when>
    				<c:otherwise>손 해 사 정 서</c:otherwise>
    			</c:choose>    			
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
				<colgroup>
					<col width="25%">			
					<col width="75%">
				</colgroup>                
				<tbody>
				<tr style="height:20px;">
				 	<th><b>구 분</b></th>
				 	<th><b>내 용</b></th>
			 	</tr>
			 	<tr style="height:20px;">
				    <th><b>증 권 번 호</b></th>
				    <td style="text-align: left;padding-left:5px;">${rptIssueMain.policyNo}</td>                    
				</tr>
				<tr style="height:20px;">
				    <th><b>보 험 기 간</b></th>
				    <td style="text-align: left;padding-left:5px;">${suimVO.insuTerm}</td>                    
				</tr>
				<tr style="height:20px;">
				    <th><b>담 보 명</b></th>
				    <td style="text-align: left;padding-left:5px;">${rptIssueMain.guaranteeTitle}</td>                    
				</tr>
			 	<tr style="height:20px;">
				    <th><b>가입금액 (보상한도액)</b></th>
				    <td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${rptIssueMain.amtSelfPay}" pattern="#,###" /> 원</td>                    
				</tr>		
				<tr style="height:20px;">
				    <th><b>자 기 부 담 금</b></th>
				    <td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${rptIssueMain.amtCompensationLimit}" pattern="#,###" /> 원</td>                    
				</tr>
				<tr style="height:20px;">
				    <th><b>계약자 / 피보험자</b></th>
				    <td style="text-align: left;padding-left:5px;">${suimVO.getPolicyholder_nm()} / ${suimVO.getBeneficiary_nm()}</td>                    
				</tr>
				<tr style="height:20px;">
				    <th><b>소 재 지 ( 목 적 물 )</b></th>
				    <td style="text-align: left;padding-left:5px;"><%-- ${rptIssue.suimZipcode} --%>${rptIssue.suimAddress}</td>                    
				</tr>
				<tr style="height:20px;">
				    <th><b>사 고 접 수 번 호</b></th>
				    <td style="text-align: left;padding-left:5px;">${rptIssueMain.accidentNo}</td>                    
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
                <colgroup>
			    <col width="25%">
			    <col width="75%">                    
			</colgroup>                
			<tbody>
			<tr style="height:20px;">
				<th><b>구 분</b></th>
				<th><b>내 용</b></th>                	
			</tr>
			<tr style="height:20px;">
			    <th><b>사 고 일 시</b></th>
			    <td  style="text-align: left;padding-left:5px;">${suimVO.accident_date}</td>                    
			</tr>
			<tr style="height:20px;">
			    <th><b>사 고 장 소</b></th>
			    <td  style="text-align: left;padding-left:5px;">
				<c:out value="${suimVO.investigate_addr1}"/><c:out value="${suimVO.investigate_addr2}"/>
			    </td>
			</tr>   
			<tr style="height:20px;">
			    <th><b>사 고 원 인</b></th>
			    <td  style="text-align: left;padding-left:5px;">
				<c:out value="${rptIssue.insuContent}"/>
			    </td>
			</tr>
			<tr style="height:20px;">
			    <th><b>사 고 경 위</b></th>
			    <td  style="text-align: left;padding-left:5px;">
			    ${fn:replace(rptIssue.insuSequence , LF , '<br>')}		
			    </td>
			</tr>
			<tr style="height:20px;">
			    <th><b>피 해 자 ( 피 해 물 )</b></th>
			    <td  style="text-align: left;padding-left:5px;">
				<c:out value="${suimVO.damagedNm}"/>
			    </td>
			</tr>
		    </tbody>
		</table>
		</div>
		<!-- 3총괄표 -->
		<div class="display-table" style="margin-top: 10px;">	    	    	
	        <div class="display-cell">
				<p class="subtitle">3. 총괄표</p>			
			</div>
			<!-- <div class="display-cell text-right" style="vertical-align:bottom;">
	       		<p style="font-size:12px;">(단위 : 원)</p>
	       	</div> -->			
       	</div>       	
		<div class="issue_lotte">
			<table id="table_issue_contract_view" style="border: 1px solid currentColor;">
				<colgroup>
				    <col width="25%">
				    <col width="75%">                    
				</colgroup>                
				<tbody>
				<tr style="height:20px;">
					<th><b>구 분</b></th>
					<th><b>내 용</b></th>                	
				</tr>
				<tr style="height:20px;">
				    <th><b>약 관 상 면 책  부 책 여 부</b></th>
				    <td  style="text-align: left;padding-left:5px;">
				    	<c:choose>
				    		<c:when test="${rptIssueMain.reparationLiabilityType eq '1'}">[부책] </c:when>
				    		<c:when test="${rptIssueMain.reparationLiabilityType eq '2'}">[면책] </c:when>
				    		<c:otherwise> - </c:otherwise>
				    	</c:choose>
				    	 <%-- / ${rptIssueMain.reparationLiabilityReason} --%>
				    </td>                    
				</tr>	
				<tr style="height:20px;">
				    <th><b>지 급 보 험 금</b></th>
				    <c:choose>
				   		<c:when test="${rptIssueMain.amtInsuPaymentDisable eq 1}">
				   			<td  style="text-align: left;padding-left:5px;">단체 사고의 경우 개별 안내 금액에 따름</td>
				   		</c:when>
				   		<c:otherwise>
				   			<td style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${rptIssueMain.amtInsuPayment}" pattern="#,###" /> 원</td>
				   		</c:otherwise>
			        </c:choose>	    
				                        
				</tr>
				<tr style="height:20px;">
				    <th><b>지 급 처</b></th>
				    <td style="text-align: left;padding-left:5px;">
				    	<c:choose>
				    		<c:when test="${rptIssueMain.paymentPlace eq 1}">피보험자</c:when>
				    		<c:when test="${rptIssueMain.paymentPlace eq 2}">피해자</c:when>
				    		<c:otherwise> - </c:otherwise>
				    	</c:choose>
				    </td>                    
				</tr>
			    </tbody>		
			</table>								
		<br/>
		<b>※ 본 사정서는 최선의 손해사정으로 어느 일방에도 치우침 없이 작성되었음을 명백히 합니다. [끝]</b>
		<br/>
		<br/>
		<!-- 조사자, 담당손해사정사 시작 -->
		<div class="issue_lotte">		 	
			<c:choose>
				<c:when test="${empty certiReportUser}">						
					<table id="table_issue_contract_view" style="border: 1px solid currentColor;">
						<tr style="height:20px;">					 			
							<td style="font-weight:bold; color: red; border: 1px solid;text-align:left;padding-left:5px;">								
								[미배당건으로 담당자 정보가 없습니다.]
							</td>					 			
						</tr>					 		
					</table>						
				</c:when>
				<c:otherwise>
					<table id="table_issue_contract_view" style="border: 1px solid currentColor;">
						<colgroup>
						    <col width="20%">
						    <col width="25%">
						    <col width="55%">                    
						</colgroup>
						<tbody>
						<tr style="height:20px;">								
							<th style="width:20%;border: 1px solid;text-align:center;letter-spacing:10px;font-weight:bold;"> 수임일자</th>
							<td style="width:80%;border: 1px solid;text-align:left;padding-left:5px;" colspan="2"> ${fn:replace(suimVO.getReg_date(),'-', '.')}</td>								
						</tr>
						<tr style="height:20px;">								
							<th style="width:20%;border: 1px solid;text-align:center;letter-spacing:10px;font-weight:bold;"> 작성일자</th>
							<td style="width:80%;border: 1px solid;text-align:left;padding-left:5px;" colspan="2"> ${fn:replace(nowdate,'-', '.')}</td>								
						</tr>
						<c:forEach items="${certiReportUser}" var="certiUserVo">
							<tr style="height:20px;">
								<th style="width:20%;border: 1px solid;text-align:center;letter-spacing:10px;font-weight:bold;"> ${certiUserVo.certi_state_val}</th>
								<td style="width:20%;border: 1px solid;text-align:left;padding-left:5px;"> ${certiUserVo.user_name}&nbsp;<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${certiUserVo.user_no}/${certiUserVo.user_sign}" width="50" height="14"></td>
								<td style="width:60%;border: 1px solid;text-align:left;padding-left:10px;">
									[ 등록번호 : ${certiUserVo.certi_number} <c:if test='${certiUserVo.work_phone != ""}'>/ 연락처 : ${certiUserVo.work_phone} </c:if>]
								</td>														 			
							</tr>																			
						</c:forEach>
					</tbody>
				</table>
				</c:otherwise>
			</c:choose>
		</div>		 	
		<!-- 조사자, 담당손해사정사 끝 -->
		<%-- <br/>				
		<table>
			<colgroup>
			    <col width="50%">
			    <col width="50%">
			</colgroup>
			<tbody>
				<tr style="height:20px;">
					<td></td>
					<td>
						<table style="border: 1px solid;">
							<tr style="height:22px;">
								<td style="width:35%;border: 1px solid;text-align:center;"><b>수&nbsp;&nbsp;임&nbsp;&nbsp;일&nbsp;&nbsp;자</b></td>
								<td style="width:65%;border: 1px solid;text-align:left;padding-left:5px;">${fn:replace(suimVO.getReg_date(),'-', '.')}</td>
							</tr>
							<tr style="height:22px;">
								<td style="width:35%;border: 1px solid;text-align:center;"><b>작&nbsp;&nbsp;성&nbsp;&nbsp;일&nbsp;&nbsp;자</b></td>
								<td style="width:65%;border: 1px solid;text-align:left;padding-left:5px;">${fn:replace(nowdate,'-', '.')}</td>
							</tr>
							<tr style="height:22px;">
								<td style="width:35%;border: 1px solid;text-align:center;"><b>조&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자</b></td>
								<td style="width:65%;border: 1px solid;text-align:left;padding-left:5px;">${reportInvgUser.disWorkLevel} ${reportInvgUser.userName} (${reportInvgUser.handphone})</td>
							</tr>
							<tr style="height:22px;">
								<td style="width:35%;border: 1px solid;text-align:center;"><b>대표손해사정사</b></td>
								<td style="width:65%;border: 1px solid;text-align:left;padding-left:5px;">윤경수<img alt="윤경수" src="./resources/ne_img/sign_yun.jpg" width="50" height="20"></td>
							</tr>
						</table>
					</td>						
				</tr>
			</tbody>			
		</table>		
		<br/> --%>
		<br/>
		<div align="center"><img src="https://www.toplac.co.kr/resources/ne_img/sign_ceo.jpg" border="0"/></div>					
    </div>
    </div>    
</div>
<br/>
<br/>