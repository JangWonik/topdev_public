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
        body,table {font-size:9pt;font-family:'굴림','굴림체','돋움','Nanum Gothic', 'verdana'; color:#000;}

        /* 마진과 패딩의 초기화 */
        body, div, p, th, textarea {margin:0;padding:0; font-size:9pt;}
		td {margin:0;padding:0; font-size:8pt;}
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
        p.subtitle {font-weight: bold; margin: 0px 0px 0px 0px; font-size: 10pt !important;}
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
						<tr style="height:12px;">
						 	<th width="30%"><b>구&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;분</b></th>
							<th width="70%"><b>내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</b></th>
					 	</tr>
					 	<tr style="height:12px;">
						    <th width="30%"><b>증&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;권&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;번&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;호</b></th>
						    <td width="70%" style="text-align: left;padding-left:5px;">${rptIssueMain.policyNo}</td>                    
						</tr>
						<tr style="height:12px;">
						    <th width="30%"><b>보&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;험&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;간</b></th>
						    <td width="70%" style="text-align: left;padding-left:5px;">${suimVO.insuTerm}</td>                    
						</tr>
						<tr style="height:12px;">
						    <th width="30%"><b>담&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;보&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</b></th>
						    <td width="70%" style="text-align: left;padding-left:5px;">${rptIssueMain.guaranteeTitle}</td>                    
						</tr>
					 	<tr style="height:12px;">
						    <th width="30%"><b>가 입 금 액 (보상한도액)</b></th>
						    <td width="70%" style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${rptIssueMain.amtSelfPay}" pattern="#,###" /> 원</td>                    
						</tr>		
						<tr style="height:12px;">
						    <th width="30%"><b>자&nbsp;&nbsp;&nbsp;기&nbsp;&nbsp;&nbsp;부&nbsp;&nbsp;&nbsp;담&nbsp;&nbsp;&nbsp;금</b></th>
						    <td width="70%" style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${rptIssueMain.amtCompensationLimit}" pattern="#,###" /> 원</td>                    
						</tr>
						<tr style="height:12px;">
						    <th width="30%"><b>계 약 자&nbsp;&nbsp;/&nbsp;&nbsp;피 보 험 자</b></th>
						    <td width="70%" style="text-align: left;padding-left:5px;">${suimVO.getPolicyholder_nm()} / ${suimVO.getBeneficiary_nm()}</td>                    
						</tr>
						<tr style="height:12px;">
						    <th width="30%"><b>소&nbsp;&nbsp;재&nbsp;&nbsp;지 (목&nbsp;&nbsp;적&nbsp;&nbsp;물)</b></th>
						    <td width="70%" style="text-align: left;padding-left:5px;"><%-- ${rptIssue.suimZipcode} --%>${rptIssue.suimAddress}</td>                    
						</tr>
						<tr style="height:12px;">
						    <th width="30%"><b>사&nbsp;&nbsp;고&nbsp;&nbsp;접&nbsp;&nbsp;수&nbsp;&nbsp;번&nbsp;&nbsp;호</b></th>
						    <td width="70%" style="text-align: left;padding-left:5px;">${rptIssueMain.accidentNo}</td>                    
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
		                <tr style="height:12px;">
						<th width="30%"><b>구&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;분</b></th>
						<th width="70%"><b>내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</b></th>                	
					</tr>
					<tr style="height:12px;">
					    <th width="30%"><b>사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;고&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;시</b></th>
					    <td width="70%" style="text-align: left;padding-left:5px;">${suimVO.accident_date}</td>                    
					</tr>
					<tr style="height:12px;">
					    <th width="30%"><b>사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;고&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;장&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</b></th>
					    <td width="70%" style="text-align: left;padding-left:5px;">
						<c:out value="${suimVO.investigate_addr1}"/><c:out value="${suimVO.investigate_addr2}"/>
					    </td>
					</tr>   
					<tr style="height:12px;">
					    <th width="30%"><b>사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;고&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;인</b></th>
					    <td width="70%" style="text-align: left;padding-left:5px;">
						<c:out value="${rptIssue.insuContent}"/>
					    </td>
					</tr>
					<tr style="height:12px;">
					    <th width="30%"><b>사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;고&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;경&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;위</b></th>
					    <td width="70%" style="text-align: left;padding-left:5px;">
					    ${fn:replace(rptIssue.insuSequence , LF , '<br>')}		
					    </td>
					</tr>
					<tr style="height:12px;">
					    <th width="30%"><b>피&nbsp;&nbsp;해&nbsp;&nbsp;자&nbsp;&nbsp;(피&nbsp;&nbsp;해&nbsp;&nbsp;물)</b></th>
					    <td width="70%" style="text-align: left;padding-left:5px;">
						<c:out value="${suimVO.damagedNm}"/>
					    </td>
					</tr>		            
				</table>
				</div>				
				<!-- 3총괄표 -->
				<div class="display-table" style="margin-top: 10px;">
			    	<!-- 1. 계약사항 -->    	
			        <div class="display-cell">
						<p class="subtitle">3. 총괄표</p>			
					</div>
				</div>
										       	
				<div class="issue_lotte">					
					<table id="table_issue_contract_view" style="border: 1px solid currentColor;">														
						<tr style="height:12px;">
							<th width="30%"><b>구&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;분</b></th>
							<th width="70%"><b>내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</b></th>                	
						</tr>
						<tr style="height:12px;">
						    <th width="30%" style="letter-spacing:3px;"><b>약관상면책부책여부</b></th>
						    <td width="70%" style="text-align: left;padding-left:5px;">
						    	<c:choose>
						    		<c:when test="${rptIssueMain.reparationLiabilityType eq '1'}">[부책] </c:when>
						    		<c:when test="${rptIssueMain.reparationLiabilityType eq '2'}">[면책] </c:when>
						    		<c:otherwise> - </c:otherwise>
						    	</c:choose>
						    	 <%-- / ${rptIssueMain.reparationLiabilityReason} --%>
						    </td>                    
						</tr>	
						<tr style="height:12px;">
						    <th width="30%"><b>지&nbsp;&nbsp;&nbsp;급&nbsp;&nbsp;&nbsp;보&nbsp;&nbsp;&nbsp;험&nbsp;&nbsp;&nbsp;금</b></th>
						    <c:choose>
						   		<c:when test="${rptIssueMain.amtInsuPaymentDisable eq 1}">
						   			<td width="70%" style="text-align: left;padding-left:5px;">단체 사고의 경우 개별 안내 금액에 따름</td>
						   		</c:when>
						   		<c:otherwise>
						   			<td width="70%" style="text-align: right;padding-right:5px;"><fmt:formatNumber value="${rptIssueMain.amtInsuPayment}" pattern="#,###" /> 원</td>
						   		</c:otherwise>
					        </c:choose>	    
						                        
						</tr>
						<tr style="height:12px;">
						    <th width="30%"><b>지&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;급&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;처</b></th>
						    <td width="70%" style="text-align: left;padding-left:5px;">
						    	<c:choose>
						    		<c:when test="${rptIssueMain.paymentPlace eq 1}">피보험자</c:when>
						    		<c:when test="${rptIssueMain.paymentPlace eq 2}">피해자</c:when>
						    		<c:otherwise> - </c:otherwise>
						    	</c:choose>
						    </td>                    
						</tr>		
					</table>					
					<%-- <div class="display-table"  style="margin-top: 10px;">
						<div class="display-cell">
							<p class="subtitle">4. 특이사항</p>
						</div>
					</div>
					<div class="issue_lotte">
						<table id="table_issue_contract_view" style="border: 1px solid currentColor;">
							<tr style="height:12px;">
								<td style="text-align: left;padding-left:5px;">${rptIssue.remarkVal}</td>
							</tr>				
						</table>					
					</div> --%>					
				<br/>
				<b>※ 본 사정서는 최선의 손해사정으로 어느 일방에도 치우침 없이 작성되었음을 명백히 합니다. [끝]</b>
				<br/>
				<br/>
				<!-- 조사자, 담당손해사정사 시작 -->		 	
				<c:choose>
					<c:when test="${empty certiReportUser}">						
						<table>
							<tr style="height:20px;">					 			
								<td style="font-weight:bold; color: red; border: 1px solid;text-align:left;padding-left:5px;">								
									[미배당건으로 담당자 정보가 없습니다.]
								</td>					 			
							</tr>					 		
						</table>						
					</c:when>
					<c:otherwise>
						<table>
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
									<td style="width:30%;border: 1px solid;text-align:left;padding-left:5px;"> ${certiUserVo.user_name}&nbsp;<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${certiUserVo.user_no}/${certiUserVo.user_sign}" width="50" height="14"></td>
									<td style="width:50%;border: 1px solid;text-align:left;padding-left:10px;">
										[ 등록번호 : ${certiUserVo.certi_number} <c:if test='${certiUserVo.work_phone != ""}'>/ 연락처 : ${certiUserVo.work_phone} </c:if>]
									</td>														 			
								</tr>																						
						</c:forEach>
					</table>
					</c:otherwise>
				</c:choose>		 	
				<!-- 조사자, 담당손해사정사 끝 -->
				
				<br/>
				<%-- <table>
					<tr style="height:20px;">
						<td width="50%"></td>
						<th style="width:20%;border: 1px solid;text-align:center;"><b>수&nbsp;&nbsp;임&nbsp;&nbsp;일&nbsp;&nbsp;자</b></th>
						<td style="width:30%;border: 1px solid;text-align:left;padding-left:5px;">${fn:replace(suimVO.getReg_date(),'-', '.')}</td>
					</tr>
					<tr style="height:20px;">
						<td width="50%"></td>
						<th style="width:20%;border: 1px solid;text-align:center;"><b>작&nbsp;&nbsp;성&nbsp;&nbsp;일&nbsp;&nbsp;자</b></th>
						<td style="width:30%;border: 1px solid;text-align:left;padding-left:5px;">${fn:replace(nowdate,'-', '.')}</td>
					</tr>
					<tr style="height:20px;">
						<td width="50%"></td>
						<th style="width:20%;border: 1px solid;text-align:center;"><b>조&nbsp;&nbsp;&nbsp;&nbsp;사&nbsp;&nbsp;&nbsp;&nbsp;자</b></th>
						<td style="width:30%;border: 1px solid;text-align:left;padding-left:5px;">${reportInvgUser.disWorkLevel} ${reportInvgUser.userName} (${reportInvgUser.handphone})</td>
					</tr>
					<tr style="height:20px;">
						<td width="50%"></td>
						<th style="width:20%;border: 1px solid;text-align:center;"><b>대표손해사정사</b></th>
						<td style="width:30%;border: 1px solid;text-align:left;padding-left:5px;">윤경수<img alt="윤경수" src="https://www.toplac.co.kr/resources/ne_img/sign_yun.jpg" width="50" height="14"></td>
					</tr>
				</table>								
				<br/> --%>
				<br/>
				<div align="center"><img src="https://www.toplac.co.kr/resources/ne_img/sign_ceo.jpg" border="0"/></div>					
		    </div>
		    </td>
		</tr>
	</table>
</div>
</div>
</html>		    		