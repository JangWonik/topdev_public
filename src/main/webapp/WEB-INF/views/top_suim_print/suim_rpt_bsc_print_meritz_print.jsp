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
    <link rel="stylesheet" type="text/css" href="../resources/wm_css/meritz_report.css?v=20171204"/>
</head>
<body>


<div class="reportWrap">
    <div class="reportContent">
        <input type="hidden" id="suim_rpt_no" value="${param.suim_rpt_no}">
        <input type="hidden" id="rpt_print_no" value="${rptBasic.rptPrintNo}">
        
        <div style="margin-top:30px;">
        	<div class="text-center" style="margin-bottom: 20px;">
        		<b><font size="5" color="BLACK">[종 결 보 고 서]</font></b>
        	</div>
       	</div>
       	
       	<div style="margin-top:30px;">
        	<div style="width: 10%; float:left;" > 
        		<p class="title">수신 : </p>
        		<p class="title">발신 : </p>
        	</div>
        	<div style="width: 29%; float:left;"> 
        		<p class="title" align="center">${reportBscInfo.ptnrName}</p>
        		<p class="title" align="center">탑손해사정 주식회사</p>
        	</div>
        	<div style="width: 30%; float:left;"> 
        		<p class="title" align="center">${reportBscInfo.ptnrDeptNm}</p>
        		<p class="title" align="center">${reportTeamInfo.teamName}</p>
        	</div>
        	<div style="width: 31%; float:left;"> 
        		<p class="title" align="center">${reportBscInfo.ptnrMbrNm}</p>
        		<p class="title" align="center">${reportInvgUser.userName} (${reportInvgUser.handphone})</p>
        	</div>
        	<div style="clear: both;"></div>
        </div>
        
        <div style="margin-top:15px;">
           	<div style="width: 33%; float:left;"> 
        		<p class="title" align="left">사고접수일 : ${reportBscInfo.accidentDate}</p>
        	</div>
        	
        	<div style="width: 33%; float:left;"> 
        		<p class="title" align="center">의뢰일시 : ${reportBscInfo.regDate}</p>
        	</div>
        	
        	<div style="width: 33%; float:left;"> 
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
        	</div>
        	<table >
        		<colgroup>
        			<col width="12%" />
        			<col width="13%" />
        			<col width="12%" />
        			<col width="23%" />
        			<col width="12%" />
        			<col width="33%" />
	            </colgroup>
        		<tr>
        			<th>피보험자</th>
        			<td>${reportBscInfo.beneficiaryNm}</td>
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
        </div>	
        
        <section class="meritz_rpt_contract">
        	<h2>▣  계약사항</h2>
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
        	<h2>▣  손해사항</h2>
        	<article id="meritz_rpt_loss_table">
        		<table>
       				<colgroup>
       					<col width="12%"/>
       					<col width="12%"/>
       					<col width="10%"/>
       					<col width="36%"/>
       					<col width="15%"/>
       					<col width="15%"/>
       				</colgroup>
        			<thead>
	        			<tr>
	        				<th>사고일자</th>
	        				<th>사고유형</th>
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
								${fn:replace(fn:replace(rptBasic.diagnosisDisease1 , CRLF , '<br>'), ' ', '&nbsp;')}
							</td>
							<td>
								${fn:replace(fn:replace(rptBasic.diagnosisCode1 , CRLF , '<br>'), ' ', '&nbsp;')}
							</td>
							<td>
								${fn:replace(fn:replace(rptBasic.jobGradeJoin1 , CRLF , '<br>'), ' ', '&nbsp;')}
							</td>
							<td>
								${fn:replace(fn:replace(rptBasic.jobGradeAccident1 , CRLF , '<br>'), ' ', '&nbsp;')}
							</td>
						</tr>       
        			</tbody>
        		</table>
        		
        		<table>
        			<colgroup>
        				<col width="33%"/>
        				<col width="33%"/>
        				<col width="33%"/>
        			</colgroup>
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
        						${fn:replace(fn:replace(fn:escapeXml(rptBasic.insuMortgageDtl1) , CRLF , '<br>'), ' ', '&nbsp;')}
        					</td>
        					<td>
        						${fn:replace(fn:replace(fn:escapeXml(rptBasic.amtTotInsu1) , CRLF , '<br>'), ' ', '&nbsp;')}
        					</td>
        					<td>
        						${fn:replace(fn:replace(fn:escapeXml(rptBasic.amtEstimatedDmgDtl1) , CRLF , '<br>'), ' ', '&nbsp;')}
        					</td>
        				</tr>
        				<tr class="meritz_loss_view">
        					<th colspan="2">
        						합 계
        					</th>
        					<td>
        						${fn:replace(fn:replace(fn:escapeXml(rptBasic.amtEstimatedDmgDtl1) , CRLF , '<br>'), ' ', '&nbsp;')}
        					</td>
        				</tr>
        			</tbody>
        		</table>
        	</article>
        </section>

        <section class="meritz_rpt_inquiry">
        	<h2>▣  청구내용 및 조사결과</h2>
       		<article id="meritz_rpt_inquiry_table">
       			<table>
	               	<colgroup>
	                    <col width="24%" />
	                    <col width="18%" />
	                    <col width="20%" />
	                    <col width="18%" />
	                    <col width="20%" />
	                </colgroup>
					<tr id="meritz_claim_view">
						<th>청구 내용</th>
						<td colspan="4" style="padding:10px;">
							${fn:replace(fn:replace(fn:escapeXml(rptBasic.claimDtl2) , CRLF , '<br>'), ' ', '&nbsp;')}
						</td>
					</tr>

					<tr id="meritz_complaint_avoid_view">
						<th>민원예방활동</th>
						<td colspan="4" style="padding:10px;">
							${fn:replace(fn:replace(fn:escapeXml(rptBasic.complaintAvoidActivity2) , CRLF , '<br>'), ' ', '&nbsp;')}
						</td>
					</tr>
					
					<tr class="meritz_result_view">
						<th rowspan="2">조사자의견<br/>및<br/>조사결과</th>
						<td colspan="4" style="padding:10px;">
							${fn:replace(fn:replace(fn:escapeXml(rptBasic.inspectResult2) , CRLF , '<br>'), ' ', '&nbsp;')}
						</td>
					</tr>
					
					<tr class="meritz_result_view">
						<th>
							계약 유지
						</th>
						<td>
							${rptBasic.contractKeepYn2}
						</td>
						<th>
							민원 여부
						</th>
						<td>
							${rptBasic.minwonDtl2}
						</td>
					</tr>
       			</table>
       		</article>
       	</section>        

        <section class="meritz_rpt_confirm_by_date">
        	<h2>▣  조사자 일자별 확인사항</h2>
       		<article id="meritz_rpt_confirm_by_date_table">
				<table>
       				<colgroup>
       					<col width="20%" />
       					<col width="60%" />
       					<col width="20%" />
       				</colgroup>
       				<thead>
       					<tr>
	       					<th>일자</th>
	       					<th>확인내용</th>
	       					<th>관련기관</th>
       					</tr>
       				</thead>
       				<tbody>
       					<tr>
       						<th colspan="4">
       							계약전
     						</th>
       					</tr>
       					
       					<tr id="bef_add_tr" style="display:none;border:2px solid #8a8a8a;">
       						<td style="text-align: center">
      							<input type="text" class="calendar" id="bef_to_date_add" /> ~ <br/>
      							&nbsp;&nbsp;&nbsp;<input type="text" class="calendar" id="bef_from_date_add" /><br/>
      							<input type="radio" name="bef_confirm_date_gubun_add" onclick="fnSetConfirmDateDtl('bef',1,'add')" id="bef_confirm_date_gubun1_add" value="1">입원
      							<input type="radio" name="bef_confirm_date_gubun_add" onclick="fnSetConfirmDateDtl('bef',2,'add')" id="bef_confirm_date_gubun2_add" value="2">통원
      							<input type="text" id="bef_date_dtl_add" value=""/> 
       						</td>
       						<td>
       						    <%
		                            String preTextAreaAddText = "- 내원경위 : \n- 검사사항 : \n- 진단병명 : \n- 치료사항 : \n";
		                        %>
       							<textarea rows="8" id="bef_confirm_dtl_add"><%=preTextAreaAddText %></textarea>	
       						</td>
       						<td style="text-align: center">
       							메리츠 화재보험 
       							<input type="hidden" id="bef_relative_organ_add" value="메리츠 화재보험" />
       						</td>
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
									<td>
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
       						<th colspan="4">
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
									<td style="text-align: center;">
										${fn:replace(fn:replace(confirmList.confirmDtl , CRLF , '<br>'), ' ', '&nbsp;')}
									</td>
									<!-- 관련기관 -->
									<td style="text-align: center">
										${confirmList.relativeOrgan}
									</td>	
		       					</tr>
		       				</c:if>
       					</c:forEach>
       				</tbody>
       				<tbody>
       					<tr>
       						<th colspan="4">
       							계약후
     						</th>
       					</tr>
       					
       					<tr id="aft_add_tr" style="display:none;border:2px solid #8a8a8a;">
       						<td style="text-align: center">
      							<input type="text" class="calendar" id="aft_to_date_add" /> ~ <br/>
      							&nbsp;&nbsp;&nbsp;<input type="text" class="calendar" id="aft_from_date_add" /><br/>
      							<input type="radio" name="aft_confirm_date_gubun_add" onclick="fnSetConfirmDateDtl('aft',1,'add')" id="aft_confirm_date_gubun1_add" value="1">입원
      							<input type="radio" name="aft_confirm_date_gubun_add" onclick="fnSetConfirmDateDtl('aft',2,'add')" id="aft_confirm_date_gubun2_add" value="2">통원
      							<input type="text" id="aft_date_dtl_add" value=""/> 
       						</td>
       						<td>
       							<textarea rows="8" id="aft_confirm_dtl_add"><%=preTextAreaAddText %></textarea>	
       						</td>
       						<td style="text-align: center">
       							메리츠 화재보험 
       							<input type="hidden" id="aft_relative_organ_add" value="메리츠 화재보험" />
       						</td>
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
									<td>
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
        	<h2>▣  타사 가입사항</h2>
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
        		<h2>▣  주요쟁점사항</h2>
	        	
	       		<article class="meritz_major_issues_table" id="meritz_major_issues_table">
	       		
		       		<!-- 사고내용 -->
		       		<c:if test="${rptBasic.accidentDtlUseAt == 1}">
			       		<section class="major_issues_sub">
			       			<div class="issues_sub_head">
				       			<div class="issues_title" style="font-size: 12px;">
				       				사고내용
				       			</div>
			       			</div>
			       			
			       			<div class="issues_sub_body_view" id="issues_view_accident" > 
				                <div class="display-cell" style="font-size: 12px; "> 
				                	<c:if test="${rptBasic.accidentDtlSub ne '' and rptBasic.accidentDtlSub != null}"> ${rptBasic.accidentDtlSub} 확인 결과, <br/></c:if>
				                    ${fn:replace(fn:replace(rptBasic.accidentDtl6 , CRLF , '<br>'), ' ', '&nbsp;')}
				                </div>
			       			</div>
			       		</section>       		
		       		</c:if>
	       		
		       		<!-- 고지의무 -->
		       		<c:if test="${rptBasic.noticeDuty1UseAt == 1}">
			       		<section class="major_issues_sub">
			       			<div class="issues_sub_head">
				       			<div class="issues_title" style="font-size: 12px;">
				       				고지의무
				       			</div>
			       			</div>
			       			<div class="issues_sub_body_view" id="issues_view_notice1"> 
				                <div class="display-cell" style="font-size: 12px;">
           		                    ${fn:replace(fn:replace(rptBasic.noticeDuty16 , CRLF , '<br>'), ' ', '&nbsp;')}
				                </div>
			       			</div>
			       		</section>
		       		</c:if>
	
	
		       		<!-- 통지의무 -->
		       		<c:if test="${rptBasic.noticeDuty2UseAt == 1}">
		       			<section class="major_issues_sub">
			       			<div class="issues_sub_head">
				       			<div class="issues_title" style="font-size: 12px;">
				       				통지의무
				       			</div>
			       			</div>
			       			<div class="issues_sub_body_view" id="issues_view_notice2" > 
				                <div class="display-cell" style="font-size: 12px;">
				                    ${fn:replace(fn:replace(rptBasic.noticeDuty26 , CRLF , '<br>'), ' ', '&nbsp;')}
				                </div>
			       			</div>
			       		</section>
			       	</c:if>	  
		       		
		       		<!-- 직업급수 -->
		       		<c:if test="${rptBasic.jobGradeConfirmUseAt == 1}">
			       		<section class="major_issues_sub">
			       			<div class="issues_sub_head">
				       			<div class="issues_title" style="font-size: 12px;">
				       				직업급수(확인)
				       			</div>
			       			</div>
			       			<div class="issues_sub_body_view" id="issues_view_job" style="${issues_view_use_at_job}"> 
				                <div class="display-cell" style="font-size: 12px;">
				                	<c:if test="${rptBasic.jobGradeConfirmSub ne '' and rptBasic.jobGradeConfirmSub != null}"> ${rptBasic.jobGradeConfirmSub} 확인 결과, <br/></c:if>
				                    ${fn:replace(fn:replace(rptBasic.jobGradeConfirm6 , CRLF , '<br>'), ' ', '&nbsp;')}
				                </div>
			       			</div>
			       		</section>  	       		
		       		</c:if>
		       		
		       		<!-- 의료자문 -->
		       		<c:if test="${rptBasic.counselMedicalUseAt == 1}">
			       		<section class="major_issues_sub">
			       			<div class="issues_sub_head">
				       			<div class="issues_title" style="font-size: 12px;">
				       				의료자문
				       			</div>
			       			</div>
			       			<div class="issues_sub_body_view" id="issues_view_medical" > 
				                <div class="display-cell" style="font-size: 12px;">
				                    ${fn:replace(fn:replace(rptBasic.counselMedical6 , CRLF , '<br>'), ' ', '&nbsp;')}
				                </div>
			       			</div>
			       		</section>		       		     		
		       		</c:if>
	
		       		<!-- 법률자문 -->
		       		<c:if test="${rptBasic.counselLegalUseAt == 1}">
			       		<section class="major_issues_sub">
			       			<div class="issues_sub_head">
				       			<div class="issues_title" style="font-size: 12px;">
				       				법률자문
				       			</div>
			       			</div>
			       			<div class="issues_sub_body_view" id="issues_view_legal" style="${issues_view_use_at_legal}"> 
				                <div class="display-cell" style="font-size: 12px;">
				                    ${fn:replace(fn:replace(rptBasic.counselLegal6 , CRLF , '<br>'), ' ', '&nbsp;')}
				                </div>
			       			</div>
			       		</section>
		       		</c:if>
		       		
		       		<!-- 관공서 확인내용 -->
		       		<c:if test="${rptBasic.confirmPublicUseAt == 1}">
			       		<section class="major_issues_sub">
			       			<div class="issues_sub_head">
				       			<div class="issues_title" style="font-size: 12px;">
				       				관공서확인내용 (경찰서 등)
				       			</div>
			       			</div>
			       			
			       			<div class="issues_sub_body_view" id="issues_view_public" style="${issues_view_use_at_public}"> 
				                <div class="display-cell" style="font-size: 12px;">
				                    ${fn:replace(fn:replace(rptBasic.confirmPublic6 , CRLF , '<br>'), ' ', '&nbsp;')}
				                </div>
			       			</div>
			       		</section>	   
			       	</c:if>  
	
					<c:if test="${rptBasic.disabilityUseAt == 1}">
			       		<section class="major_issues_sub">
			       			<div class="issues_sub_head">
				       			<div class="issues_title" style="font-size: 12px;">
				       				장해율/장해상태 확인
				       			</div>
			       			</div>
			       			<div class="issues_sub_body_view" id="issues_view_disability" style="${issues_view_use_at_disability}"> 
				                <div class="display-cell" style="font-size: 12px;">
				                    ${fn:replace(fn:replace(rptBasic.disability6 , CRLF , '<br>'), ' ', '&nbsp;')}
				                </div>
			       			</div>
			       		</section>	  
		       		</c:if>	       		
	       		</article>
	       	</section>
		</c:if>
       	
		<section class="meritz_relative_interview">
        	<h2>▣  관련자면담 및 특이사항</h2>
        	<article id="meritz_rpt_interview_table">
        		<table>
      				<colgroup>
       					<col width="20%" />
       					<col width="80%" />
       				</colgroup>
        			<thead>
	        			<tr>
	        				<th>구분</th>
	        				<th>쟁점사항</th>
	        			</tr>
        			</thead>
        			<tbody class="meritz_interview_view">
        				<tr>
        					<td style="text-align: center">
        						피보험자
        						<br/>(or 유가족 면담사항)
       						</td>
        					<td>
       							${fn:replace(fn:replace(rptBasic.faceMemo7 , CRLF , '<br>'), ' ', '&nbsp;')}
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center">
        						독립손사
        						<br/>(세부정보포함)
       						</td>
        					<td>
        						${fn:replace(fn:replace(rptBasic.delegate7 , CRLF , '<br>'), ' ', '&nbsp;')}
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center">
        						탐문내용
       						</td>
        					<td>
        						${fn:replace(fn:replace(rptBasic.questioning7 , CRLF , '<br>'), ' ', '&nbsp;')}
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center">
        						안내 및 특이사항
       						</td>
        					<td>
        						${fn:replace(fn:replace(rptBasic.guideEtc7 , CRLF , '<br>'), ' ', '&nbsp;')}
       						</td>
        				</tr>
        				<tr>
        					<td style="text-align: center">
        						추가서류창구
       						</td>
        					<td>
        						${fn:replace(fn:replace(rptBasic.moreDocument7 , CRLF , '<br>'), ' ', '&nbsp;')}
       						</td>
        				</tr>        				
        			</tbody>
        			
        		</table>
        	</article>
        </section>
        
        <section class="meritz_rpt_ctrl">
        	<h2>▣  사고조사 처리과정</h2>
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

<script type="text/javascript">
    window.print();
</script>
</body>
</html>
