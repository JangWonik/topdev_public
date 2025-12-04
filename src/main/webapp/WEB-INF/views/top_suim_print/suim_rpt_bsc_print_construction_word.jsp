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

<table id="container_table" align="center" cellpadding="0" cellspacing="0" width="640" style="border: none;">    
    <tr>    
       <td>
        	<p class="c"><img src="https://www.toplac.co.kr/resources/ls_img/ls_body/print_head.jpg" width="640" height="56" border="0"></p>
            <p class="c"><span style="font-size: 9pt;">${reportTeamInfo.teamAddr}</span></p>
            <p class="c"><span style="font-size: 9pt;">전화 : ${reportTeamInfo.teamTelephone} &nbsp;팩스 : ${reportTeamInfo.teamFax} &nbsp;이메일 : ${reportInvgUser.email}</span></p>
<!--             <p class="c"><img src="https://www.toplac.co.kr/resources/ls_img/ls_body/print_hr.jpg" width="900" border="0" height="3px" /></p> -->
			<hr size="3"  noshade="noshade"/>
            <table id="receive_table" cellpadding="0" cellspacing="0" >
				<tr>
                    <td width="420">수&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신 : ${reportBscInfo.ptnrName}</td>
<%--                     <td width="340" style="text-align: left;">: ${reportBscInfo.ptnrName}</td> --%>
                    <td class="r" >Report No. ${reportBscInfo.suimAcceptNo}</td>
                </tr>
                
                <tr>
                    <td width="420">참&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조 : ${reportBscInfo.ptnrDeptNm}
                        <c:if test="${reportBscInfo.ptnrMbrNm != ''}">
 							〔 담당 : ${reportBscInfo.ptnrMbrNm} 님 〕
                        </c:if>
					</td>
                   	<td class="r" >
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
                    <td width="300" colspan="2" style="padding: 0px!important;">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목 : 
                        <c:if test="${reportBscInfo.beneficiaryNm != ''}">
                            &quot;<b>${reportBscInfo.beneficiaryNm}</b>&quot;
                        </c:if>
						손해사정서
                    </td>
                </tr>
                
                <tr>
					<td width="640" colspan="2">증 &nbsp;권 &nbsp;번 &nbsp;호 : 제 ${reportBscInfo.policyNo} 호</td>
                </tr>
                
                <tr>
                    <td colspan="2">사 &nbsp;고 &nbsp;번 &nbsp;호 : ${reportBscInfo.accidentNo}</td>
<!--                     <td style="text-align: left;"></td> -->
                </tr>
                
                <tr>
                    <td colspan="2">
                        <p style="margin-top: 20px; padding: 0px 5px; font-weight: normal;">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            귀사의 요청에 의거하여 피보험자 &quot;${reportBscInfo.beneficiaryNm} &quot;  에 대한 사고조사를 실시하고, 
                    	그 결과에 대한 최종 보고서를 다음과 같이 제출합니다.
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
                    <th height="42" style="background-color: #FFF3F3; width: 200px;">구분</th>
                    <th style="background-color: #FFF3F3; width: 200px;">성명</th>
                    <th style="background-color: #FFF3F3; width: 200px;">서명</th>
                    <th style="background-color: #FFF3F3; width: 200px;">연락처</th>
                </tr>
                <!-- <tr height="69">
                    <td height="69">손해사정사</td>
                    <td>윤경수</td>
                    <td><img src="https://toplac.co.kr/resources/ls_img/ls_body/sign_yoon.jpg" width="62" height="60" border="0"></td>
                    <td>070-8255-3000</td>
                </tr> -->
				<%-- 담당 손해사정사 정보로 변경 시작 --%>
				<c:forEach items="${certiManager4ReportUser}" var="certiUserVo">
					<c:if test="${certiUserVo.certi_state_val eq '손해사정사'}">
						<tr height="69">
						    <td height="69">${certiUserVo.certi_state_val}</td>
						    <td>${certiUserVo.user_name}</td>
						    <td><img src="https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${certiUserVo.user_no}/${certiUserVo.user_sign}" width="50" height="50"></td>
						    <td><c:if test='${certiUserVo.work_phone != ""}'>${certiUserVo.work_phone} </c:if></td>
						</tr>
					</c:if>
				</c:forEach>
				<%-- 담당 손해사정사 정보로 변경 끝 --%> 
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
        	<%--1.공제계약사항--%>
        	<p style="">&nbsp;</p>
            <p class="title" style="font-size: 14pt;">1.&nbsp;공제계약사항</p>
            <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
                <tr>
                    <th width="100">항목</th>
                    <th width="340">계약사항</th>
                    <th width="100">계약사항검토</th>
                    <th width="100">비고</th>
                </tr>
                <tr>
                    <th>공제종목</th>
                    <td  class="c">${reportBscInfo.insuranceNm}</td>
                    <td  class="c">일치</td>
                    <td  class="c">${contractDetail.deductionRemarks}</td>
                </tr>
                <tr>
                    <th>증권번호</th>
                    <td  class="c">${reportBscInfo.policyNo}</td>
                    <td  class="c">일치</td>
                    <td  class="c">${contractDetail.stockRemarks}</td>
                </tr>
                <tr>
                    <th>계 약 자</th>
                    <td  class="c">${reportBscInfo.policyholderNm}</td>
                    <td  class="c">일치</td>
                    <td  class="c">${contractDetail.contractorRemarks}</td>
                </tr>
                <tr>
                   <th>피공제자</th>
                    <td  class="c">${reportBscInfo.beneficiaryNm}</td>
                    <td  class="c">일치</td>
                    <td  class="c">${contractDetail.workerRemarks}</td>
                </tr>
                <tr>
                   <th>주&nbsp;&nbsp;&nbsp;&nbsp;소</th>
                    <td  class="c">${contractDetail.address}</td>
                    <td  class="c">일치</td>
                    <td  class="c">${contractDetail.addressRemarks}</td>
                </tr>                
                <tr>
                   	<th>공제기간</th>
                    <td  class="c">${contractDetail.deductionStartDate} ~ ${contractDetail.deductionEndDate}</td>
                    <td  class="c">일치</td>
                    <td  class="c">${contractDetail.deductionPeriodRemarks}</td>
                </tr>                
                <tr>
                   <th>보상한도</th>
                    <td  class="c">법정보상 한도</td>
                    <td  class="c">일치</td>
                    <td  class="c">${contractDetail.compensationLimitRemarks}</td>
                </tr>                
                <tr>
                   <th>공제금액</th>
                    <td  class="c">-</td>
                    <td  class="c">일치</td>
                    <td  class="c">${contractDetail.deductionAmountRemarks}</td>
                </tr>                
                <tr>
                   	<th>적용약관</th>
                    <td  class="c">해외근로자재해공제 보통 약관 <br />비업무상재해 확장 추가특별약관</td>
                    <td  class="c">일치</td>
                    <td  class="c">${contractDetail.termsRemarks}</td>
                </tr>                
            </table>
            <%--2. 청구공제금(추산)--%>
            <p style="">&nbsp;</p>
            <p class="title" style="font-size: 14pt;">2.&nbsp;청구공제금(추산)</p>
            <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
        		<tr style="font-size:13px;">
        			<th width="65">재해근로자</th>
        			<th width="65">구분</th>
        			<th width="80">생년월일</th>
        			<th width="55">현장명</th>
        			<th width="80">손해액</th>
        			<th width="55">단위</th>
        			<th width="120">적용환율 <br />(전신환매도율)</th>
        			<th width="120">청구공제금</th>
        		</tr>
        		<c:forEach var="item" items="${reportOtherWorkerList}" varStatus="status" >
        			 <c:choose>
	        			<c:when test="${item.workerType == 1}">
	        				<c:set var="fontStyle" value='' />
        				 </c:when>
	        			<c:when test="${item.workerType == 2}"> 
	        				<c:set var="fontStyle" value='style="color:red;"' />
        				</c:when>
	        			<c:otherwise>
	        				<c:set var="fontStyle" value='' />
        				</c:otherwise>
	        		 </c:choose>
        			<tr style="font-size:15px;">
        				<td style="padding: 0px 5px;" class="c"><span ${fontStyle}> ${item.workerName}</span></td>
        				<td style="padding: 0px 5px;" class="c">
        					<span ${fontStyle}>
	       						<c:choose>
	        						<c:when test="${item.workerType == 1}">부책</c:when>
	        						<c:when test="${item.workerType == 2}">면책</c:when>
	        						<c:when test="${item.workerType == 3}">보완</c:when>
	        						<c:when test="${item.workerType == 4}">일부보완</c:when>
	        					</c:choose>
        					 </span>
        				</td>
        				<td style="padding: 0px 5px;" class="c"><span ${fontStyle}> ${item.ssn}</span></td>
        				<td style="padding: 0px 5px;" class="c"><span ${fontStyle}> ${item.country}</span></td>
        				<td style="padding: 0px 5px; text-align: right;"><span ${fontStyle}>
        				<fmt:formatNumber value="${item.damageAmount}" pattern="###,###,###.###"/>&nbsp;</span></td>
        				<td style="padding: 0px 5px;" class="c"><span ${fontStyle}> ${item.countryUnit}</span></td>
        				<td style="padding: 0px 5px;text-align: right;"><span ${fontStyle}><fmt:formatNumber value="${item.exchangeRate}" pattern="###,###,###.##"/>&nbsp;</span></td>
        				<td style="padding: 0px 5px;text-align: right;"><span ${fontStyle}><fmt:formatNumber value="${item.deductionAmount}" pattern="###,###,###"/>원&nbsp;</span></td>
        			</tr>
        		</c:forEach>
        			<tr>
	        			<td style="text-align:center;">합계</td>
	        			<td></td>
	        			<td></td>
	        			<td></td>	        			
	        			<td></td>	        			
	        			<td></td>	        			
	        			<td></td>	        			
	        			<td class="r"><fmt:formatNumber value="${deductionSum}" pattern="###,###,###"/>원&nbsp;</td>
	        		</tr>
        	</table>
				<div>
	                <p style="margin-top: 0px; padding: 0px 5px;">
					&nbsp;&nbsp;※상기 환율은 ${reportPrint30.exchangeRateDate}일자 외환은행 국가별 최초고시 환율을 적용함 &nbsp;&nbsp;&nbsp;&nbsp;(단위 : 원)
	                </p>
	            </div>
<!-- 	            <div class="display-cell text-right">&nbsp;&nbsp;(단위 : 원) </div>	        		 -->
        		<%--3. 지급공제금 지급처--%>
        	<p style="">&nbsp;</p>
            <p class="title" style="font-size: 14pt;">3.&nbsp;지급공제금 지급처</p>
            <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
        		<tr>
        			<th width="100">지급처</th>
        			<th width="80">대상자</th>
        			<th width="80">은행명</th>
        			<th width="170">계좌번호</th>
        			<th width="130">지급액</th>
        			<th width="80">비고</th>
        		</tr>
        		<c:forEach var="item" items="${reportOtherWorkerList}" varStatus="status" >
        			<c:if test="${item.workerType == 1 || item.workerType == 4}">
	        			<tr>
	        				<td class="c"> ${item.paymentPlace}</td>
	        				<td class="c">	${item.workerName}</td>
	        				<td class="c"> ${item.bank}</td>
	        				<td class="c"> ${item.accountNumber}</td>
	        				<td style="text-align: right;"><fmt:formatNumber value="${item.paymentAmount}" pattern="###,###,###"/>원&nbsp;</td>
	        				<td class="c"> ${item.paymentRemarks}</td>
	        			</tr>
        			</c:if>
        		</c:forEach>
       		<tr>
       			<td style="text-align:center;">합계</td>
       			<td></td>
       			<td></td>
       			<td></td>
       			<td class="r"><fmt:formatNumber value="${paymentSum}" pattern="###,###,###"/>원&nbsp;</td>
       			<td></td>
       		</tr>       		
        	</table>
        	<%--4. 보상책임 등 검토--%>
        	<p style="">&nbsp;</p>
            <p class="title" style="font-size: 14pt;">4.&nbsp;보상책임 등 검토</p>
            <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
            	<tr>
            		<th colspan="2"><b>&nbsp;가. 피보험자의 보상책임</b></th>
            	</tr>
            	<tr>
            		<td width="100"  class="c">면  /  부책</td>
            		<td>&nbsp;
            			${reportOtherWorkerList.size()}명 중
	     				${workerType2}명 면책 / ${workerType1}명 부책 
            		</td>
            	</tr>
            	<tr>
            		<td class="c">판단근거</td>
            		<td style="font-size: 11pt;">&nbsp;
            		본 건 사고는 재해근로자 (${reportWorkerType1[0].workerName} 외 ${reportOtherWorkerList.size()-workerType2-workerType3}명) 가 해외현장 근무 중 ${reportPrint30.disease}외 
            		질병 및 상해사고가 발현하여 요양후 청구한 사고로, 재해근로자의 상병명은 업무기인성 및 업무수행성이 인정되지 않는 점, 공제기간내에 발생된 점, 본 공제약관상   
	     			 비업무상재해확장담보 추가 특별약관상 보상하지 않는 손해에 해당되지 아니한 점등을 근거로 판단해 볼 때, 보험금 지급에 대한 보상 책임이 있는 것으로 사료되어 지급하고자 합니다.
 	     				<c:forEach var="item" items="${reportOtherWorkerList}" varStatus="status">
		     			 	<c:if test="${item.workerType == 2}">
		     			 		${item.judgementReason}
		     			 	</c:if>
	     				 </c:forEach>
            		</td>
            	</tr>
	     		<tr>
	     			<td  class="c">관련법규</td>
	     			<td>&nbsp;비업무상재해확장담보 추가특별약관</td>
	     		</tr>            	
            </table>
            <%--5. 면책건 및 삭감--%>
        	<p style="">&nbsp;</p>
            <p class="title" style="font-size: 14pt;">5.&nbsp; 면책건 및 삭감</p>
            <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
            	<tr>
	      			<th width="100">성명</th>
	       			<th width="130">사고일자</th>
	       			<th width="100">국가</th>
	       			<th width="140">금액(원)</th>
	       			<th width="170">면책사유</th>
       			</tr>
       			<c:forEach var="item" items="${reportOtherWorkerList}" varStatus="status">
       				<c:if test="${item.workerType == 2}">
       					<tr>
			     			<td class="c">${item.workerName}</td>
				     		<td class="c">${item.accidentDate}</td>		     			
			     			<td class="c">${item.country}</td>
			     			<td style="text-align: right"><fmt:formatNumber value="${item.deductionAmount}" pattern="###,###,###"/>원&nbsp;</td>
			     			<td class="c">${item.immunityReason}</td>       					
       					</tr>
       				</c:if>
       			</c:forEach>            	           
            </table>
            <%--6. 보완요청 건--%>
            <p style="">&nbsp;</p>
            <p class="title" style="font-size: 14pt;">6.&nbsp; 보완요청 건</p>
            <table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
            	<tr>
	      			<th width="100">성명</th>
	       			<th width="130">사고일자</th>
	       			<th width="100">국가</th>
	       			<th width="140">금액(원)</th>
	       			<th width="170">보완사유</th>
       			</tr>
       			<c:forEach var="item" items="${reportOtherWorkerList}" varStatus="status">
       				<c:if test="${item.workerType == 3 || item.workerType == 4}">
       					<tr>
			     			<td class="c">${item.workerName}</td>
				     		<td class="c">${item.accidentDate}</td>		     			
			     			<td class="c">${item.country}</td>
			     			<td style="text-align: right">
			     				<c:choose>
				     				<c:when test="${item.partSupplementAmount == null }">
				     					<fmt:formatNumber value="${item.deductionAmount}" pattern="###,###,###"/>원&nbsp;
				     				</c:when>
				     				<c:otherwise>
				     					<fmt:formatNumber value="${item.partSupplementAmount}" pattern="###,###,###"/>원&nbsp;
				     				</c:otherwise>
			     				</c:choose>
			     			</td>			     			
			     			<td class="c">${item.supplementReason}</td>       					
       					</tr>
       				</c:if>
       			</c:forEach>            	           
            </table>
            <%--7. 첨부자료 목록--%>
            <c:if test="${reportPrint30.sagodocFlag == 1}">
               <p style="">&nbsp;</p>
               <p class="title" style="font-size: 14pt;">7.&nbsp;첨부서류</p>
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
	                    <td style="padding: 0px 5px;" class="c">${item.attachName}</td>
	                    <td class="c">${item.attachCopy}</td>
	                    <td style="padding: 0px 5px;" class="c">${item.attachEtcMemo}</td>                   		
                   	</tr>
                   </c:forEach>          
            	</table>
            </c:if>
            
            <p style="">&nbsp;</p>
            <p align="center"><b> ※ 본 손해사정서는 당사의 양식과 최선의 노력으로 이해 당사자</b></p>
            <p align="center"><b>어느 일방에도 편중됨이 없이 작성되었음을 명백히 합니다.[끝]</b></p>
            <p style="">&nbsp;</p>
            	
        </td>
   </tr>     
</table>        
</html>       