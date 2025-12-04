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
    </style>
    
</head>
<body>
<div class="reportWrap">
    <div class="issue_reportContent">

<table id="container_table" align="center" cellpadding="0" cellspacing="0" width="640" style="border: none;">
    <tr>
        <td>
            <p class="c"><img src="https://www.toplac.co.kr/resources/ls_img/ls_body/print_head.jpg" width="640" height="56" border="0"></p>
            <p class="c"><span style="font-size: 9pt;">${reportTeamInfo.teamAddr}</span></p>
            <p class="c"><span style="font-size: 9pt;">전화 : ${reportInvgUser.officeTel} &nbsp;팩스 : ${reportInvgUser.officeFax} &nbsp;이메일 : ${reportInvgUser.email}</span></p>
 <!--            <p class="c" style="font-size: 0pt;"><img src="https://www.toplac.co.kr/resources/ls_img/ls_body/print_hr.jpg" width="640" border="0" height="3px"></p> -->
            <p class="c" style="font-size: 0pt;">
                <img src="https://www.toplac.co.kr/resources/ls_img/ls_body/print_hr.jpg" width="640" height="3" border="0" class="img-responsive center-block">
            </p>
         <div style="margin-top: 10px">
            <div style="width: 76%; float: left">
            	<p class="issuetitle">Report No.&nbsp; :&nbsp;&nbsp;${rptIssueMain.suimAcceptNo}
            	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	&nbsp;&nbsp;&nbsp;&nbsp;
            	Date. ${rptIssue.writeDateFmt}</p>
                <p class="issuetitle">
                    수&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신&nbsp;&nbsp;:&nbsp;&nbsp;보험계약자, 피보험자 및 보험금청구권자
               	</p>
                <p class="issuetitle">
                    제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목&nbsp;&nbsp;:&nbsp;&nbsp;손해사정서[사고번호 : ${rptIssueMain.accidentNo}]
                </p>
    	    </div> 	    
    	</div>
    	
        <div class="display-table" style="margin-top: 10px; margin-bottom: 0px">
            <div class="display-cell">
                <p class="subtitle">1. 보험계약사항</p>
            </div>
        </div> 
        <div style="margin-top: 0px">
            <table width="640" height="128" border="1">
                <tr>
			        <th width="90" height="32">보 험 사 명</th>
			        <td width="230" height="32">&nbsp;${rptIssueMain.ptnrName}</td>
			        <th width="90" height="32">보 험 종 목</th>
			        <td width="230" height="32">&nbsp;${rptIssueMain.insuranceNm}</td>
                </tr>
                <tr>
			        <th width="40" height="32">보 험 기 간</th>
			        <td width="230" height="32">&nbsp;${rptIssueMain.insuTerm}</td>
			        <th width="90" height="32">담 보 내 용</th>
			        <td width="230" height="32">&nbsp;${rptIssueMain.insuCondition}</td>
                </tr>
                <tr>
			        <th width="90" height="32">가 입 금 액</th>
			        <td width="230" height="32">&nbsp;${rptIssueMain.amtCompensationLimitUnit}
				        <fmt:formatNumber value="${rptIssueMain.amtCompensationLimit}" pattern="###,###,###"/>	
			        </td>
			        <th width="90" height="32">자기부담금</th>
			        <td width="230" height="32">&nbsp;${rptIssueMain.amtSelfPayUnit}
			        	<fmt:formatNumber value="${rptIssueMain.amtSelfPay}" pattern="###,###,###"/>	
			        </td>
                </tr>
                
           </table>
           </div>		
        <div class="display-table" style="margin-top: 20px;">
            <div class="display-cell">
                <p class="subtitle">2. 사고사항</p>
            </div>
        </div> 
            <table cellpadding="0" cellspacing="0" width="640" height="64" border="1">
                <tr>
			        <th width="90" height="32">사 고 일 자</th>
			        <td width="550" height="32">&nbsp;${rptIssueMain.accidentDate5}</td>
                </tr>               
                <tr>
			        <th width="90" height="32">사 고 내 용</th>
			        <td width="550" height="32">
			        &nbsp;${fn:replace(fn:replace(fn:escapeXml(rptIssue.insuContent) , CRLF , '<br>'), ' ', '&nbsp;')}
			        </td>                
                </tr>
           </table>	 
        <div class="display-table" style="margin-top: 20px; margin-bottom: 0px">
            <div class="display-cell">
                <p class="subtitle" style="margin-bottom: 0px">3. 손해액 및 보험금 사정에 크게 영향을 미친사항</p>
            </div>
        </div>            
                <p class="subtitle2" style="font-size: 10pt; margin-top: 10px;  margin-left: 17px;">
               		<c:choose>
               			<c:when test="${rptIssue.reparationLiabilityType eq '1'}">부책</c:when>
               			<c:when test="${rptIssue.reparationLiabilityType eq '2'}">면책</c:when>
               		</c:choose> 
               		/ ${rptIssue.reparationLiabilityReason}               	
                </p> 
<%-- 		    <table style="margin-top: 0px; padding-top: 0px">  
		    
		  
		             <tr>
		                    <td style="padding-left: 17px; width: 50px; padding-top: 0px; font-size: 10pt">
		                		<c:choose>
		                			<c:when test="${rptIssue.reparationLiabilityType eq '1'}">부책</c:when>
		                			<c:when test="${rptIssue.reparationLiabilityType eq '2'}">면책</c:when>
		                		</c:choose>
		                	</td>
		                	<td style="width: 10px; padding-top: 0px; font-size: 10pt">/</td>
		                	<td style="font-size: 10pt">
		                		${rptIssue.reparationLiabilityReason}
		                	</td>
		            </tr>    
		    </table> --%>
		        <div class="display-table" style="margin-top: 20px; margin-bottom: 0px">
		            <div class="display-cell">
		                <p class="subtitle" style="margin-bottom: 0px">4. 지급보험금</p>
		            </div>
		        </div>
		        <c:choose>
                 	<c:when test="${rptIssueMain.amtInsuPaymentDisable eq 1}">                 		
                 		<p class="subtitle2" style="font-size: 10pt; margin-top: 10px;  margin-left: 17px;">
		                	<!-- 협의금액에 따름 -->단체 사고의 경우 개별 안내 금액에 따름
		                </p>
                 	</c:when>
                 	<c:otherwise>
                 		<p class="subtitle2" style="font-size: 10pt; margin-top: 10px;  margin-left: 17px;">
		                	￦ <fmt:formatNumber value="${rptIssueMain.amtInsuPayment}" pattern="###,###,###"/>
		                </p>		
                 	</c:otherwise>
                </c:choose>
                
                <p class="subtitle2" style="font-size: 10pt; margin-top: 30px; text-align: right;">
						담당자 : ${reportInvgUser.disWorkLevel} ${reportInvgUser.userName}  (연락처 : ${reportInvgUser.handphone})
                </p>
                <table>
                	<tr>
                		<td valign="middle" align="right" width="496"><p class="subtitle2" style="font-size: 10pt; margin-top: 10px;">대표손해사정사 : 윤경수</p></td>
                		<td valign="middle"><img src="https://www.toplac.co.kr/resources/ne_img/sign_yun.jpg" height="30" width="50" /></td>
                	</tr>
                </table>
                 
				<!-- <div style="width:150px; height:150px; border:1px solid red; float: left;">
					대표손해사정사 : 윤경수  	   			
				</div>
				<div style="width:150px; height:150px; border:1px solid green; float: right;">
					aaa
					<img height="30" width="50" src="https://www.toplac.co.kr/resources/ne_img/sign_yun.jpg" />
				</div> -->				
<!--                 <p class="subtitle2" style="font-size: 10pt; margin-top: 20px; text-align: right; margin-right: 85px">
						<img src="https://www.toplac.co.kr/resources/ne_img/sign_yun2.jpg" />  
                </p>  -->
                <p style="margin-top: 30px; text-align: center;">
 						<img src="https://www.toplac.co.kr/resources/ne_img/sign_ceo.jpg" /> 
                </p>     
                <p style="font-size: 9pt; margin-top: 20px; text-align: left; ">
					※본 손해사정서는 보험업법 제188조에 근거한 손해사정사의 의견으로 보험업법 제189조에 따라 발송하는 서식이며 보험사의
					최종의사결과에 따라 달라질 수 있음을 양지해 주시기 바랍니다.
                </p>                                 	                 		    
<%-- 			<table style="margin-top: 100px; padding-top: 100px">	
				<tr>
					<td style="text-align: right; width: 50px; padding-top: 0px; font-size: 10pt" >
						당담자 : ${reportInvgUser.userName} ${reportInvgUser.disWorkLevel} (연락처 : ${reportInvgUser.handphone})		
					</td>
				</tr>	
			</table>	 --%>
<!-- 			<table style="margin-top: 0px; padding-top: 0px">	
				<tr>
					<td style="text-align: right; padding-right: 111px; width: 50px; padding-top: 0px; font-size: 10pt">
						대표손해사정사 : 윤경수 전무 	
					</td>
				</tr>	
			</table> -->	
<!-- 			<table style="margin-top: 0px; padding-top: 0px">	
				<tr>
					<td style="text-align: center; width: 50px; padding-top: 0px">
						<img src="https://www.toplac.co.kr/resources/ne_img/sign_ceo.jpg" /><br/><br/>			
					</td>
				</tr>	
			</table> -->					
<!-- 			<table style="margin-top: 0px; padding-top: 0px">	
				<tr>
					<td>
						※ 본 손해사정서는 보험업법 제188조에 근거한 손해사정사의 의견으로 보험업법 제 189조에 따라 발송하는 서식이며 보험사의
						최종의사결정과 잘라질 수 있음을 양지해 주시기 바랍니다.		
					</td>
				</tr>	
			</table>	 -->		    		                        
                      
<%-- 		    <table id="table_issue_contract_view" style="border: 1px solid">               
			    <tr>
			        <th style="border-bottom: 20px">보&nbsp;&nbsp;험&nbsp;&nbsp;사&nbsp;&nbsp;명</th>
			        <td style="text-align: left;">&nbsp;${rptIssueMain.ptnrName}</td>
			        <th width="10">보&nbsp;&nbsp;험&nbsp;&nbsp;종&nbsp;&nbsp;목</th>
			        <td style="text-align: left;">&nbsp;${rptIssueMain.insuranceNm}</td>
			    </tr>   
			    <tr>
			        <th>보&nbsp;&nbsp;험&nbsp;&nbsp;기&nbsp;&nbsp;간</th>
			        <td style="text-align: left;">&nbsp;${rptIssueMain.insuTerm}</td>
			        <th>담&nbsp;&nbsp;보&nbsp;&nbsp;내&nbsp;&nbsp;용</th>
			        <td style="text-align: left;">&nbsp;${rptIssueMain.insuCondition}</td>
			    </tr>                    
			    <tr>
			        <th>가&nbsp;&nbsp;입&nbsp;&nbsp;금&nbsp;&nbsp;액</th>
			        <td style="text-align: left;">&nbsp;${rptIssueMain.amtCompensationLimitUnit} 
			        	<span class="money">${rptIssueMain.amtCompensationLimit}</span>                    
			        </td>
			        <th>자 기 부 담 금</th>
			        <td style="text-align: left;">&nbsp;${rptIssueMain.amtSelfPayUnit} 
			        	<span class="money">${rptIssueMain.amtSelfPay}</span>                    
			        </td>
			    </tr>                
			</table> --%>
    		    </td> <%-- container td--%>
   			 </tr> <%-- container tr--%>
		</table> <%-- container table--%>
	</div>
</div>

</body>
</html>

