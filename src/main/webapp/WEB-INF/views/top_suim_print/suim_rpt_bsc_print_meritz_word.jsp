s<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<html>
<head>
    <title>보고서 상세</title>
    <link rel="stylesheet" type="text/css" href="https://toplac.co.kr/resources/wm_css/meritz_report_word.css?v=20171214"/>
    <style>
    
		table {border-spacing:0; width: 100%; padding:0 !important; }
 		th{padding:0 !important; }
		td{padding:0 !important; text-align: center !important; vertical-align: middle;}

 		.td {border:1px solid #999999; padding:3px; line-height:120%;} 
 		.wordTd{word-break:break-all;}
		p {color:#000000; font-size:11pt; line-height:120%; margin-top:0; margin-bottom:0; font-family:굴림;}
		
 		.leftTd{ padding-left: 5px !important;  text-align:left !important; word-break:break-all;}
		.confirmTh{text-align: left !important; padding: 0px 5px !important;}
		.confirmTd{text-align: left !important; padding: 5px 5px !important;}
		
		.inquiryTh{width: 20% !important;}
		.inquiryTd{width: 80% !important; text-align:left !important; word-break:break-all; padding-left: 5px !important; }
		
		.lossTh{width: 10% !important;}
		
		
    </style>
</head>
<body>

<div class="reportWrap" style="border: none; width:640px;">
    <div class="reportContent"> 
        <div style="margin-top:30px;">
        	<div class="text-center" style="margin-bottom: 20px;">
        		<b><font size="5" color="BLACK">[종 결 보 고 서]</font></b>
        	</div>
       	</div>
       	
       	<table class="header_table" >
       		<tr>
				<td style="line-height: 80%"> <p class="title">수신 : </p> </td>
				<td> <p class="title" align="center">${reportBscInfo.ptnrName}</p> </td>
				<td> <p class="title" align="center">${reportBscInfo.ptnrDeptNm}</p> </td>
				<td> <p class="title" align="center">${reportBscInfo.ptnrMbrNm}</p> </td>
       		</tr>
       		<tr>
       			<td> <p class="title">발신 : </p> </td>
       			<td> <p class="title" align="center">탑손해사정 주식회사</p> </td>
       			<td> <p class="title" align="center">${reportTeamInfo.teamName}</p> </td>
       			<td> <p class="title" align="center">${reportInvgUser.userName} (${reportInvgUser.handphone})</p> </td>
       		</tr>
       	</table>
       	<br/>
       	<table class="header_table" >
       		<tr>
				<td> <p class="title" align="left">사고접수일 : ${reportBscInfo.accidentDate}</p> </td>
				<td> <p class="title" align="center">의뢰일시 : ${reportBscInfo.regDate}</p> </td>
				<td>
					<p class="title" align="right">
	       				보고일자 : 
						<c:choose>
							<c:when test="${reportBscInfo.invoiceDate ne null }">
								<c:choose>
									<c:when test="${reportBscInfo.invoiceDate ne '' }">
										${reportBscInfo.invoiceDate }														
									</c:when>
									<c:otherwise>
										<font color="red">미제출 </font>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<font color="red">미제출 </font>
							</c:otherwise>
						</c:choose>
	       			</p> 
				</td>
       		</tr>
       	</table>
        
       	<table>
       		<tr>
       			<th>피보험자</th>
       			<td style="text-align: center;">
       				${reportBscInfo.beneficiaryNm}
   				</td>
       			<th>사고번호</th>
       			<td>${reportBscInfo.accidentNo}</td>
       			<th>조사담당</th>
       			<td>${reportInvgUser.userName}</td>
       		</tr>
       		<tr>
       			<th>주민번호</th>
       			<td colspan="3">${reportBscInfo.beneficiarySsn}</td>
       			<th>보상담당</th>
       			<td>${reportBscInfo.ptnrMbrNm}</td>
       		</tr>
       	</table>
        
        <section class="meritz_rpt_contract">
        	<h4>▣  계약사항</h4>
       		<article id="meritz_rpt_contract_table">
				<table>
	       			<colgroup>
	        			<col width="30%" />
	        			<col width="14%" />
	        			<col width="16%" />
	        			<col width="16%" />
	        			<col width="12%" />
	        			<col width="12%" />
		            </colgroup>
		            <thead>
		            	<tr>
		            		<th>상품명</th>
		            		<th>증권번호</th>
		            		<th>보험시기</th>
		            		<th>보험종기</th>
		            		<th>계약자명</th>
		            		<th>계약상태</th>
		            	</tr>
		            </thead>
		            <tbody>
						<tr class="meritz_cont_view">
							<td>${reportBscInfo.insuranceNm}</td>
							<td>${reportBscInfo.policyNo}</td>
							<td>${rptBasic.insuPeriodS1}</td>
							<td>${rptBasic.insuPeriodE1}</td>
							<td>${reportBscInfo.policyholderNm}</td>
							<td>${rptBasic.contractState1}</td>
						</tr>		
		            </tbody>
	        	</table>
	        </article>
        </section>
        
        <section class="meritz_rpt_loss">
        	<h4>▣  손해사항</h4>
        	<article id="meritz_rpt_loss_table">
        		<table>
        			<thead>
	        			<tr>
	        				<th class="lossTh" >사고일자</th>
	        				<th class="lossTh" >사고유형</th>
	        				<th colspan="2">진단명</th>
	        				<th>가입시<br/>직업급수</th>
	        				<th>사고시<br/>직업급수</th>
	        			</tr>
        			</thead>
        			<tbody>
        				<tr class="meritz_loss_view">
							<td>
								${rptBasic.accidentDate1}
							</td>
							<td>
								${rptBasic.accidentSumUp1}
							</td>
							<td>
								${rptBasic.diagnosisDisease1}
							</td>
							<td>
								${rptBasic.diagnosisCode1}
							</td>
							<td>
								${rptBasic.jobGradeJoin1}
							</td>
							<td>
								${rptBasic.jobGradeAccident1}
							</td>
						</tr>      
        			</tbody>
        		</table>
        		<br/>
        		<table>
        			<thead>
	        			<tr>
	        				<th>담보내용</th>
	        				<th>보험가입금액</th>
	        				<th>추정손해액</th>
	        			</tr>
        			</thead>
        			<tbody>
        				<tr class="meritz_loss_view">
        					<td>
        						${fn:replace(fn:replace(rptBasic.insuMortgageDtl1 , CRLF , '<br>'), ' ', '&nbsp;')}
        					</td>
        					<td>
        						${fn:replace(fn:replace(rptBasic.amtTotInsu1 , CRLF , '<br>'), ' ', '&nbsp;')}
        					</td>
        					<td>
        						${fn:replace(fn:replace(rptBasic.amtEstimatedDmgDtl1 , CRLF , '<br>'), ' ', '&nbsp;')}
        					</td>
        				</tr>
        				<tr class="meritz_loss_view">
        					<th colspan="2">
        						합 계
        					</th>
        					<td>
        						${rptBasic.amtEstimatedDmgDtl1}
        					</td>
        				</tr>
        			</tbody>
        		</table>
        	</article>
        </section>

        <section class="meritz_rpt_inquiry">
        	<h4>▣  청구내용 및 조사결과</h4>
       		<article id="meritz_rpt_inquiry_table">
       		
       			<table>
					<tr>
						<th class="inquiryTh">청구 내용</th>
						<td class="inquiryTd" colspan="4">
							${fn:replace(fn:replace(rptBasic.claimDtl2, CRLF , '<br>'), ' ', '&nbsp;')}
						</td>
					</tr>

					<tr>
						<th class="inquiryTh">민원예방활동</th>
						<td class="inquiryTd" colspan="4" >
							${fn:replace(fn:replace(rptBasic.complaintAvoidActivity2 , CRLF , '<br>'), ' ', '&nbsp;')}
						</td>
					</tr>
					
					<tr>
						<th rowspan="2" class="inquiryTh">조사자의견<br/>및<br/>조사결과</th>
						<td class="inquiryTd" colspan="4" >
							${fn:replace(fn:replace(rptBasic.inspectResult2 , CRLF , '<br>'), ' ', '&nbsp;')}
						</td>
					</tr>
					
					<tr>
						<th width="50">
							계약 유지
						</th>
						<td class="wordTd" width="100" >
							${rptBasic.contractKeepYn2}
						</td>
						<th width="50">
							민원 여부
						</th>
						<td class="wordTd" width="100">
							${rptBasic.minwonDtl2}
						</td>							
					</tr>		
       			</table>
       			
       		</article>
       	</section>        

        <section class="meritz_rpt_confirm_by_date">
        	<h4>▣  조사자 일자별 확인사항</h4>
       		<article id="meritz_rpt_confirm_by_date_table">
				<table>
       				<thead>
       					<tr>
	       					<th style="width: 15%">일자</th>
	       					<th style="width: 60%">확인내용</th>
	       					<th style="width: 25%">관련기관</th>
       					</tr>
       				</thead>
       				<tbody>
       					<tr>
       						<th colspan="3" style="padding:0 !important; border: none !important; " >
       							계약전
     						</th>
       					</tr>
       					
       					<c:forEach items="${rptConfirm}" var="confirmList" varStatus="rcStatus">
	       					<c:if test="${confirmList.contractBa == 1}">
		       					<tr id="bef_confirm_view_${rcStatus.index}" >
		       						<!-- 일자 -->
									<td style="text-align: center">
										${confirmList.confirmToDate}
										<c:if test="${confirmList.confirmFromDate ne NULL and confirmList.confirmFromDate ne ''}">
											<br/>~
											${confirmList.confirmFromDate}
										</c:if>
										<c:if test="${confirmList.confirmGubunTxt ne NULL and confirmList.confirmGubunTxt ne ''}">
											<br/>
											(${confirmList.confirmGubunTxt})
										</c:if>									
									</td>
									<!-- 확인내용 -->
									<td class="leftTd">
										${fn:replace(fn:replace(confirmList.confirmDtl , CRLF , '<br>'), ' ', '&nbsp;')}
									</td>
									<!-- 관련기관 -->
									<td style="text-align: center">
										${fn:replace(fn:replace(confirmList.relativeOrgan , CRLF , '<br>'), ' ', '&nbsp;')}
									</td>
		       					</tr>
	       					</c:if>
       					</c:forEach>
       				</tbody>
       				<tbody>
       					<tr>
       						<th colspan="3">
       							계약일
     						</th>
       					</tr>
       					
       					<c:forEach items="${rptConfirm}" var="confirmList" varStatus="rcStatus">
       						<c:if test="${confirmList.contractBa == 2}">
		       					<tr id="day_confirm_view_${rcStatus.index}" >
		       						<!-- 일자 -->
									<td style="text-align: center">
										${confirmList.confirmToDate}
									</td>
									<!-- 확인내용 -->
									<td colspan="2" style="text-align: center;">
										${fn:replace(fn:replace(confirmList.confirmDtl , CRLF , '<br>'), ' ', '&nbsp;')}
									</td>
		       					</tr>
		       				</c:if>
       					</c:forEach>
       				</tbody>
       				
       				<tbody>
       					<tr>
       						<th colspan="3">
       							계약후
     						</th>
       					</tr>
       					
       					<c:forEach items="${rptConfirm}" var="confirmList" varStatus="rcStatus">
       						<c:if test="${confirmList.contractBa == 3}">
		       					<tr id="aft_confirm_view_${rcStatus.index}" >
		       						<!-- 일자 -->
									<td style="text-align: center">
										${confirmList.confirmToDate}
										<c:if test="${confirmList.confirmFromDate ne NULL and confirmList.confirmFromDate ne ''}">
											<br/>~
											${confirmList.confirmFromDate}
										</c:if>
										<c:if test="${confirmList.confirmGubunTxt ne NULL and confirmList.confirmGubunTxt ne ''}">
											<br/>
											(${confirmList.confirmGubunTxt})
										</c:if>									
									</td>
									<!-- 확인내용 -->
									<td class="leftTd">
										${fn:replace(fn:replace(confirmList.confirmDtl , CRLF , '<br>'), ' ', '&nbsp;')}
									</td>
									<!-- 관련기관 -->
									<td style="text-align: center">
										${fn:replace(fn:replace(confirmList.relativeOrgan , CRLF , '<br>'), ' ', '&nbsp;')}
									</td>
		       					</tr>
		       				</c:if>
       					</c:forEach>
       				</tbody>
       			</table>
       		</article>
       	</section>        
        
        <section class="meritz_other_insu">
        	<h4>▣  타사 가입사항</h4>
       		<article id="meritz_other_insu_table">
				<table>
       				<colgroup>
       					<col width="18%" />
       					<col width="32%" />
       					<col width="18%" />
						<col width="32%" />
       				</colgroup>
       				<thead>
       					<tr>
	       					<th>보험회사</th>
	       					<th>담보내용</th>
	       					<th>보험기간</th>
	       					<th>청구내용 및 결과</th>
       					</tr>
       				</thead>        
       				<tbody> 
						
						<c:forEach items="${rptOtherInsu}" var="oiList" varStatus="oiStatus">
							<tr id="other_insu_view_${oiStatus.index}">
								<td style="text-align: center;">
									${oiList.otherInsuCom}
								</td>	
								<td>
									${fn:replace(fn:replace(oiList.otherInsuMortgage , CRLF , '<br>'), ' ', '&nbsp;')}
								</td>
								<td>
									${fn:replace(fn:replace(oiList.otherInsuPeriod , CRLF , '<br>'), ' ', '&nbsp;')}
								</td>
								<td>
									${fn:replace(fn:replace(oiList.otherInsuEtcMemo , CRLF , '<br>'), ' ', '&nbsp;')}								
								</td>
							</tr>
						</c:forEach>
       				</tbody>
       			</table>
       		</article>
       	</section>
        
		<c:if test="${rptBasic.accidentDtlUseAt == 1 or rptBasic.noticeDuty1UseAt == 1 or  rptBasic.noticeDuty2UseAt == 1 
				   or rptBasic.jobGradeConfirmUseAt == 1 or rptBasic.counselMedicalUseAt == 1 or rptBasic.counselLegalUseAt == 1 
				   or rptBasic.confirmPublicUseAt == 1 or  rptBasic.disabilityUseAt == 1 }">
			<section class="meritz_major_issues">
        		<h4>▣  주요쟁점사항</h4>
	        	
		       		<!-- 사고내용 -->
		       		<c:if test="${rptBasic.accidentDtlUseAt == 1}">
						<table cellpadding="0" cellspacing="0" align="center" width="640" border="1" style="margin-bottom: 50px !important;">
		                    <tr>
		                        <th class="confirmTh">사고내용</th>
		                    </tr>
		                    <tr>
		                        <td class="confirmTd">
				                	<c:if test="${rptBasic.accidentDtlSub ne '' and rptBasic.accidentDtlSub != null}"> ${rptBasic.accidentDtlSub} 확인 결과, <br/></c:if>
				                    ${fn:replace(fn:replace(rptBasic.accidentDtl6 , CRLF , '<br>'), ' ', '&nbsp;')}
		                        </td>
		                    </tr>
		                </table>
		                <p style="line-height: 10px;">　</p>
		       		</c:if>
	       		
		       		<!-- 고지의무 -->
		       		<c:if test="${rptBasic.noticeDuty1UseAt == 1}">
						<table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
		                    <tr>
		                        <th class="confirmTh">고지의무</th>
		                    </tr>
		                    <tr>
		                        <td class="confirmTd">
 									${fn:replace(fn:replace(rptBasic.noticeDuty16 , CRLF , '<br>'), ' ', '&nbsp;')}
		                        </td>
		                    </tr>
		                </table>	
		                <p style="line-height: 10px;">　</p>
		       		</c:if>
	
	
		       		<!-- 통지의무 -->
		       		<c:if test="${rptBasic.noticeDuty2UseAt == 1}">
		       			<table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
		                    <tr>
		                        <th class="confirmTh">통지의무</th>
		                    </tr>
		                    <tr>
		                        <td class="confirmTd">
 									${fn:replace(fn:replace(rptBasic.noticeDuty26 , CRLF , '<br>'), ' ', '&nbsp;')}
		                        </td>
		                    </tr>
		                </table>
		                <p style="line-height: 10px;">　</p>
			       	</c:if>	  
		       		
		       		<!-- 직업급수 -->
		       		<c:if test="${rptBasic.jobGradeConfirmUseAt == 1}">
		       			<table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
		                    <tr>
		                        <th class="confirmTh">직업급수(확인)</th>
		                    </tr>
		                    <tr>
		                        <td class="confirmTd">
				                	<c:if test="${rptBasic.jobGradeConfirmSub ne '' and rptBasic.jobGradeConfirmSub != null}"> ${rptBasic.jobGradeConfirmSub} 확인 결과, <br/></c:if>
				                    ${fn:replace(fn:replace(rptBasic.jobGradeConfirm6 , CRLF , '<br>'), ' ', '&nbsp;')}
		                        </td>
		                    </tr>
		                </table>
		                <p style="line-height: 10px;">　</p>
		       		</c:if>
		       		
		       		<!-- 의료자문 -->
		       		<c:if test="${rptBasic.counselMedicalUseAt == 1}">
		       			<table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
		                    <tr>
		                        <th class="confirmTh">의료자문</th>
		                    </tr>
		                    <tr>
		                        <td class="confirmTd">
				                    ${fn:replace(fn:replace(rptBasic.counselMedical6 , CRLF , '<br>'), ' ', '&nbsp;')}
		                        </td>
		                    </tr>
		                </table>
		                <p style="line-height: 10px;">　</p>
		       		</c:if>
	
		       		<!-- 법률자문 -->
		       		<c:if test="${rptBasic.counselLegalUseAt == 1}">
		       			<table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
		                    <tr>
		                        <th class="confirmTh">법률자문</th>
		                    </tr>
		                    <tr>
		                        <td class="confirmTd">
				                    ${fn:replace(fn:replace(rptBasic.counselLegal6 , CRLF , '<br>'), ' ', '&nbsp;')}
		                        </td>
		                    </tr>
		                </table>
		                <p style="line-height: 10px;">　</p>
		       		</c:if>
		       		
		       		<!-- 관공서 확인내용 -->
		       		<c:if test="${rptBasic.confirmPublicUseAt == 1}">
		       			<table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
		                    <tr>
		                        <th class="confirmTh">관공서확인내용 (경찰서 등)</th>
		                    </tr>
		                    <tr>
		                        <td class="confirmTd">
				                    ${fn:replace(fn:replace(rptBasic.confirmPublic6 , CRLF , '<br>'), ' ', '&nbsp;')}
		                        </td>
		                    </tr>
		                </table>
		                <p style="line-height: 10px;">　</p>
			       	</c:if>  
	
					<c:if test="${rptBasic.disabilityUseAt == 1}">
		       			<table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
		                    <tr>
		                        <th class="confirmTh">장해율/장해상태 확인</th>
		                    </tr>
		                    <tr>
		                        <td class="confirmTd">
			                   		${fn:replace(fn:replace(rptBasic.disability6 , CRLF , '<br>'), ' ', '&nbsp;')}
		                        </td>
		                    </tr>
		                </table>
		                <p style="line-height: 10px;">　</p>
		       		</c:if>	       		
	       	</section>
		</c:if>
       	
		<section class="meritz_relative_interview">
        	<h4>▣  관련자면담 및 특이사항</h4>
        	<article id="meritz_rpt_interview_table">
        		<table>
        			<thead>
	        			<tr>
	        				<th>구분</th>
	        				<th>쟁점사항</th>
	        			</tr>
        			</thead>
        			<tbody class="meritz_interview_view">
        				<tr>
        					<td style="text-align: center" width="100">
        						피보험자
        						<br/>(or 유가족 면담사항)
       						</td>
        					<td style="word-break:break-all;">
       							${fn:replace(fn:replace(rptBasic.faceMemo7 , CRLF , '<br>'), ' ', '&nbsp;')}
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center" width="100">
        						독립손사
        						<br/>(세부정보포함)
       						</td>
        					<td style="word-break:break-all;">
        						${fn:replace(fn:replace(rptBasic.delegate7 , CRLF , '<br>'), ' ', '&nbsp;')}
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center" width="100">
        						탐문내용
       						</td>
        					<td style="word-break:break-all;">
        						${fn:replace(fn:replace(rptBasic.questioning7 , CRLF , '<br>'), ' ', '&nbsp;')}
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center" width="100">
        						안내 및 특이사항
       						</td>
        					<td style="word-break:break-all;">
        						${fn:replace(fn:replace(rptBasic.guideEtc7 , CRLF , '<br>'), ' ', '&nbsp;')}
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center" width="100">
        						추가서류창구
       						</td>
        					<td style="word-break:break-all;">
        						${fn:replace(fn:replace(rptBasic.moreDocument7 , CRLF , '<br>'), ' ', '&nbsp;')}
       						</td>
        				</tr>        				
        			</tbody>
        			
        		</table>
        	</article>
        </section>
        
        <section class="meritz_rpt_ctrl">
        	<h4>▣  사고조사 처리과정</h4>
       		<article id="meritz_ctrl_table">
       			<table>
       				<colgroup>
       					<col width="16%" />
       					<col width="21%" />
       					<col width="21%" />
       					<col width="21%" />
       					<col width="21%" />
       				</colgroup>
       				<thead>
       					<tr>
	       					<th>진행일시</th>
	       					<th>주요내용</th>
	       					<th>면담자</th>
	       					<th>관계</th>
	       					<th>접촉방법</th>
       					</tr>
       				</thead>        
       				<tbody> 
						<c:forEach items="${rptControl}" var="rcList" varStatus="rcStatus">
							<tr id="meritz_ctrl_view_${rcStatus.index}">
								<td style="text-align: center;">
									${rcList.controlDate}
								</td>	
								<td style="text-align: center;">
									${rcList.controlMemo}
								</td>
								<td style="text-align: center;">
									${rcList.controlWho}
								</td>
								<td style="text-align: center;">
									${rcList.controlRelation}								
								</td>
								<td style="text-align: center;">
									${rcList.controlContact}								
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
						
       		</article>
       	</section>
       	
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
	</div>
</div>       

</body>
</html>
