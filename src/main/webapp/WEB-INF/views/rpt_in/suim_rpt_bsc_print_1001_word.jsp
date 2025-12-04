<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>보고서 작성</title>
<!-- 	<link rel="stylesheet" type="text/css" href="./resources/ls_css/rpt_6_style.css" /> -->
<!-- 	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/> -->
<!-- 	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/> -->
	<script src="https://www.toplac.co.kr/resources/jquery/jquery.min_1_12.js"></script>
	<style>
 		.td {border:1px solid #999999; padding:3px; line-height:120%;} 
 		.wordTd{word-wrap: break-word;}
		p {color:#000000; font-size:11pt; line-height:120%; margin-top:0; margin-bottom:0; font-family:굴림;}
		table {border-collapse:collapse;border-spacing:0; font-size:11pt; }
	</style>
	
	<script>
		$(document).ready(function(){
			/** 메뉴 출력 플래그 **/
			fnRaidoViewCtrl("sagoDoc","${print1.sagoDocFlag}");
			
			fnRaidoViewCtrl("job","${detailMap.jobUseFlag}");
			fnRaidoViewCtrl("accident","${detailMap.accidentUseFlag}");
			fnRaidoViewCtrl("hospital","${detailMap.hospitalUseFlag}");
			fnRaidoViewCtrl("advice","${detailMap.adviceUseFlag}");
			
			var FlagChk = "${detailMap.jobUseFlag}" == 0 
						   && "${detailMap.accidentUseFlag}" == 0
						   && "${detailMap.hospitalUseFlag}" == 0
						   && "${detailMap.adviceUseFlag}" == 0;
			
			if( FlagChk ){
				$("#gubunDtlChkTr").css("display","none");
			}

		});
		
	  	function fnRaidoViewCtrl(gubun,flag){
	  		if (gubun == "sagoDoc"){
		  		if (flag == 0){
					$(".sagoDocTable").css("display","none");
					$(':radio[name="sagoDocFlag"]:radio[value="0"]').attr('checked',true);
		  		}else{
					$(".sagoDocTable").css("display","block");
					$(':radio[name="sagoDocFlag"]:radio[value="1"]').attr('checked',true);
		  		}
	  		}else{
		  		if (flag == 0){
		  			$("#"+gubun+"DtlChkTr0").css("display","none");
		  			$("#"+gubun+"DtlChkTr1").css("display","none");
		  			$("#"+gubun+"DtlChkTr2").css("display","none");
		  			
		  			$(':radio[name="'+gubun+'ChkFlag"]:radio[value="0"]').attr('checked',true);
		  		}else{
		  			$("#"+gubun+"DtlChkTr0").css("display","block");
		  			$("#"+gubun+"DtlChkTr1").css("display","block");
		  			$("#"+gubun+"DtlChkTr2").css("display","block");
		  			
		  			$(':radio[name="'+gubun+'ChkFlag"]:radio[value="1"]').attr('checked',true);
		  		}
		  		
	  		}
	  	}
	</script>
	
</head>


<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
	<!-- 표지시작 -->
	<table id = "rptBody6Table" align="center" cellpadding="0" cellspacing="0" width="648" >
		<tr>
			<td>
				<p align="center"><img src="https://www.toplac.co.kr/resources/ls_img/ls_body/print_head.jpg" width="640" height="56" border="0"></p>
				<p align="center" style="line-height:50%; margin-top:0; margin-bottom:0;">&nbsp;</p>
				<p align="center"><span style="font-size:9pt;">${tmInforForBody.team_addr}</span></p> 
				<p align="center"><span style="font-size:9pt;">전화 : ${tmInforForBody.team_telephone} &nbsp;팩스 : ${tmInforForBody.team_fax} &nbsp;이메일 : ${mbrVoForBody.email}</span></p>
				<p align="center"><img src="./resources/ls_img/ls_body/print_hr.jpg" width="640" height="3" border="0"></p>
				
				
				<table cellpadding="0" cellspacing="0" width="648" align="center" >
					<tr>
						<th height="20" colspan="3"></th>
					</tr>
					
					<tr>
						<th align="left" height="30" width="80"><!-- 수신 -->
							<p>
								수 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신 
							</p>
						</th>
						<th align="left" height="30" width="320">
							<p>&nbsp;: ${suimVO.ptnr_name}</p>
						</th>
						
						<th align="right" height="30" width="248"><!--  보고서 번호 -->
							<p>Report No. ${suimVO.suim_accept_no}</p>
						</th>
					</tr>
					
					<tr>
						<th align="left" height="30" width="40"><!-- 참조 -->
							<p>
								참 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조
							</p>
						</th>
						
						<th align="left" height="30" width="320">
							<p>
								&nbsp;: ${suimVO.ptnr_dept_nm} 
								<c:if test="${suimVO.ptnr_mbr_nm ne ''}">
								〔 담당 : ${suimVO.ptnr_mbr_nm} 님 〕
								</c:if>
							</p>
						</th>
						
						
						<th align="right" height="30" width="248"><!-- 보고서 제출일 -->
							<p>
								<c:choose>
									<c:when test="${suimInvVO.invoiceDate eq '' or suimInvVO.invoiceDate eq null}">
										날짜 정보없음
									</c:when>
									<c:otherwise>
										보고서 제출일 : ${suimInvVO.invoiceDate.replaceAll("-",".") }
									</c:otherwise>
								</c:choose>
							</p>
						</th>
					</tr>
					
					<tr>
						<th align="left" height="30" width="80">
							<p>
								제 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목
							</p>
						</th>
						
						<th align="left" height="30" colspan="2" width="568">
							<p>
								&nbsp;: <c:if test="${suimVO.beneficiary_nm ne ''}">
									&quot;<b>${suimVO.beneficiary_nm}</b>&quot;
								</c:if>
								 손해사정서
							</p>
						</th>
					</tr>
					<tr>
						<th align="left" height="30" width="80">
							<p>증&nbsp;&nbsp;권&nbsp;번&nbsp;&nbsp;호 </p>
						</th>
						<th align="left" height="30"  colspan="2" width="568" >
							<p>&nbsp;: 제 ${suimVO.policy_no} 호</p>
						</th>
						
					</tr>
					<tr>
						<th  align="left" height="30" width="80"> 
							<p>사&nbsp;&nbsp;고&nbsp;번&nbsp;&nbsp;호</p>
						</th>
						<th align="left" height="30"  colspan="2" width="568">
							<p>&nbsp;: ${suimVO.accident_no}</p>
						</th>
					</tr>
					<tr>
						<td  colspan="3" height="120" width="648">
							<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							귀 사의 요청에 의거하여 
							피보험자 &quot;${suimVO.beneficiary_nm}&quot;의
							보험금 청구건에 대한 사고조사를 실시하고, 그 결과를 다음과 같이 제출 합니다.
							</p>	
						</td>
					</tr>
				</table>		
		
				<p>&nbsp;</p>
				
				<div align="center">
					<table cellpadding="0" cellspacing="0" width="640" style="border:1px">
						<tr>
							<th height="40" class="td" style="background-color:#FFF3F3;">
								구 분 
							</th>
							<th class="td" style="background-color:#FFF3F3;">
								성 명
							</th>
							<th class="td" style="background-color:#FFF3F3;">
								서 명
							</th>
							<th class="td" style="background-color:#FFF3F3;">
								연 락 처
							</th>
						</tr>
						
						<tr>
							<!-- 구분 -->
							<td class="td" align="center">
								손해사정사
							</td>
							<!-- 성명 -->
							<td class="td" align="center">
								윤경수
							</td>
							<!-- 서명 -->
							<td height="70" class="td" align="center">
								<p><img src="https://www.toplac.co.kr/resources/ls_img/ls_body/sign_yoon.jpg" width="62" height="60" border="0"></p>
							</td>
							<!-- 연락처 -->
							<td class="td" align="center">
								<p>070-8255-3000</p>
							</td>
						</tr>
						
						<tr>
							<!-- 구분 -->
							<td class="td" align="center">
								팀 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;장 
							</td>
							<!-- 성명 -->
							<td class="td" align="center">
								${mbrVoForBodySantion.user_name}
								<br/>
								<c:if test="${mbrVoForBodySantion.work_level ne null and mbrVoForBodySantion.work_level ne ''}">
									(${mbrVoForBodySantion.work_level})
								</c:if>
							</td>
							<!-- 서명 -->
							<td style="padding: 5px;" height="70" class="td" align="center">
                        		<c:choose> 
                        			<c:when test="${mbrVoForBodySantion.user_sign ne null}"> 
			                        	<img src="https://toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${mbrVoForBodySantion.user_no}/${mbrVoForBodySantion.user_sign}" width=50 height=50 border=0>	                        	 
                        			</c:when> 
                        			<c:otherwise> 
		                        		사인 없음
                        			</c:otherwise> 
                        		</c:choose>   
							</td>
							<!-- 연락처 -->
							<td class="td" align="center">
								<p>${mbrVoForBodySantion.handphone }</p>
							</td>
						</tr>	
						
						<tr>
							<!-- 구분 -->
							<td class="td" align="center">
								<p>조 &nbsp;&nbsp;사 &nbsp;&nbsp;자 </p>
							</td>
							<!-- 성명 -->
							<td class="td" align="center">
								<p>
									${mbrVoForBody.user_name }
									<br/>(${mbrVoForBody.work_level})
								</p>
							</td>
							<!-- 서명 -->
							<td style="padding: 5px;" height="70" class="td" align="center">
                               <c:choose>
                        			<c:when test="${signVoForRptUser.user_sign ne '' or signVoForRptUser.user_sign ne null}">
			                        	<img src='https://toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${signVoForRptUser.user_no}/${signVoForRptUser.user_sign}' width=50 height=50 border=0>	                        	
                        			</c:when>
                        			<c:otherwise>
		                        		사인 없음
                        			</c:otherwise>
                        		</c:choose>    
							</td>
							<!-- 연락처 -->
							<td class="td" align="center">
								<p>${mbrVoForBody.handphone }</p>
							</td>
						</tr>					
		            </table>
				</div>
				<br/>
				<br/>
				<br/>
				<div align="center">
					<img src="https://www.toplac.co.kr/resources/ne_img/sign_salary.jpg" />
				</div>
		       	<!-- //표지 --> 

				<div style='page-break-before:always'></div> 
		        
		        <!-- print1 PK -->
		        <input type="hidden" id="suimRptNo" value="${suimVO.suim_rpt_no}" />
		        <input type="hidden" id="rptPrintNo" value="${print1.rptPrintNo}" />
		        
				<!-- 계약확인사항 -->
				<p>&nbsp;</p>
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td height="25" width="50%">
							<p class="p2">
								<b>1. 계약확인사항 </b>
							</p>
						</td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<colgroup>
						<col width="140"></col>
						<col width="500"></col>
					</colgroup>
					<tr>
						<td bgcolor="#ECECEC" class="td" width="140">
							<p align="center">보험종목</p>
						</td>
						
						<td class="td" style="word-break:break-all;">
							<span class= "1Span" id="insuNm1Span" style="color:black;">${suimVO.insurance_nm}</span>
						</td>
					</tr>
					
					<tr>
						<td bgcolor="#ECECEC" class="td" width="140">
							<p align="center">증권번호</p>
						</td>
						
						<td class="td" style="word-break:break-all;">
							<span class= "1Span" id="policyNo1Span">${suimVO.policy_no }</span>
						</td>
					</tr>
					
					<tr>
						<td bgcolor="#ECECEC" class="td" width="140">
							<p align="center">계약일자</p>
						</td>
						<td class="td" style="word-break:break-all;">
							<span class= "1Span" id="insuTerm1Span">${print1.insuTerm1}</span>
						</td>
					</tr>
					
					<tr>
						<td bgcolor="#ECECEC" class="td" width="140">
							<p align="center">계약자 / 피보험자</p>
						</td>
						<td class="td" style="word-break:break-all;">
							<!-- 계약자 -->
							${suimVO.policyholder_nm}
							<c:if test="${suimVO.policyholder_ssn2 ne null and suimVO.policyholder_ssn2 ne '' }"> 
								(${suimVO.policyholder_ssn2}) 
							</c:if>
							/
							<!-- 피보험자 -->
							${suimVO.beneficiary_nm}
							<c:if test="${suimVO.beneficiary_ssn2 ne null and suimVO.beneficiary_ssn2 ne '' }"> 
								(${suimVO.beneficiary_ssn2}) 
							</c:if>
						</td>
					</tr>
					
					<!-- 
					<tr>
						<td bgcolor="#ECECEC" class="td" width="140">
							<p align="center">청구담보</p>
						</td>
						<td colspan="4" class="td">
							<p>
								<span class= "1Span" id="mortgage1Span">${print1.insuMortgage1}</span>
								<input type="text" class="simple1Txt" id="mortgage1Txt" style="display:none;" value="${print1.insuMortgage1}"/>
							</p>
						</td>
					</tr>					
				 	-->
				
					<tr>
						<td bgcolor="#ECECEC" class="td" width="140">
							<p align="center">직무확인사항</p>
						</td>
						<td class="td" style="word-break:break-all;">
							<span class= "1Span" id="jobChk1Span">${print1.faceInsuredJob6}</span>
						</td>
					</tr>
				</table>
				<!-- //1.계약확인사항 -->
				<p>&nbsp;</p>
				<!-- 2. 청구사항 -->
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td height="25" width="50%">
							<p class="p2">
								<b>2. 청구사항 </b>
							</p>
						</td>
					</tr>
				</table>
				
				<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<colgroup>
						<col width="140"></col>
						<col width='200'></col>
						<col width='150'></col>
						<col width='150'></col>
					</colgroup>
					
					<tr>
						<th class="td" bgcolor="#ECECEC">구 분</th>
						<th class="td" colspan="3" bgcolor="#ECECEC">내 용</th>
					</tr>
					
					<tr>
						<td class="td" bgcolor="#ECECEC" align="center">진단병명</td>
						<td class="td" colspan="3" style="word-break:break-all;">
							<span class= "claimSpan" id="diseaseClaimSpan" >${print1.diagnosisDisease3}</span>
 						</td>
					</tr>
					 
					<tr>
						<td class="td" bgcolor="#ECECEC" align="center">진단병원</td>
						<td class="td" colspan="3" style="word-break:break-all;"> 
							<span class= "claimSpan" id="hospitalClaimSpan">${print1.diagnosisHospital3}</span>
						</td>
					</tr>
					
					<tr>
						<td class="td" bgcolor="#ECECEC" align="center" rowspan="${print_1_assure.size()+2}" style="line-height:110%">
							담보내역<br/>
							및<br/>
							추정 손해액
						</td>
						<td class='td' align='center' bgcolor='#ECECEC'>담보사항</td>
						<td class='td' align='center' bgcolor='#ECECEC'>가입금액</td>
						<td class='td' align='center' bgcolor='#ECECEC'>추정손해액</td>
					</tr>
				<c:forEach items='${print_1_assure}' var='assureVo' varStatus='assureStatus'>
					<tr>
						<!-- 담보사항 -->
						<td class='td' align='center' style='border-left: 0px;word-break:break-all;'>
							<span class='assureSpan' id='dtlAssureSpan${assureStatus.index}'>${assureVo.assureDtl}</span>
						</td>
						
						<!-- 가입금액 -->
						<td class='td' style="padding-right:10px;" align='right'>
							<span class= 'assureSpan' id='joinAmountAssureSpan${assureStatus.index}'><fmt:formatNumber value='${assureVo.joinAmount}' pattern='###,###,##0.##'/> 원</span>
						</td>
					
						<!-- 추정손해액 -->
						<td class='td' style="padding-right:10px;" align='right'>
							<span class= 'assureSpan' id='estimationAmoutAssureSpan${assureStatus.index}'><fmt:formatNumber value='${assureVo.estimationAmount}' pattern='###,###,##0.##'/> 원</span>
						</td>
					</tr>
					
					<c:set var='joinAmountSum' value='${assureVo.joinAmount + joinAmountSum}'/>
					<c:set var='estimationAmoutSum' value='${assureVo.estimationAmount + estimationAmoutSum}'/>
				</c:forEach>
					<tr>
						<td class='td' align='center' bgcolor='#ECECEC' style='border-left: 0px;'>합계</td>
						<td class='td' style="padding-right:10px;" align='right'>
							<span class= 'claimSpan' id='joinAmountSumSpan'>
								<c:choose>
									<c:when test="${joinAmountSum ne 0 and joinAmountSum ne ''}">
										<fmt:formatNumber value='${joinAmountSum}' pattern='###,###,##0.##'/> 원
									</c:when>
									<c:otherwise>
										-												
									</c:otherwise>
								</c:choose>
							</span>
						</td>
						<td style="padding-right:10px;" class='td' align='right'>
							<span class= 'claimSpan' id='estimationAmoutSum'>
								<c:choose>
									<c:when test="${estimationAmoutSum ne 0 and estimationAmoutSum ne ''}">
										<fmt:formatNumber value='${estimationAmoutSum}' pattern='###,###,##0.##'/> 원
									</c:when>
									<c:otherwise>
										-												
									</c:otherwise>
								</c:choose>
							</span>	
						</td>
					</tr>	
				</table>
				<!--// 2. 청구사항 -->
				<p>&nbsp;</p>
				<!-- 3. 타 보험사 계약 및 지급사항 -->
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td height="25" width="50%">
							<p class="p2">
								<b>3. 타 보험사 계약 및 지급사항 </b>
							</p>
						</td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<colgroup>
						<col width="100"></col>
						<col width="190"></col>
						<col width="350"></col>
					</colgroup>
					<tr>
						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>보험사</b></p>
						</td>
						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>계약내용</b></p>
						</td>
						<td class="td" bgcolor="#ECECEC" >
							<p align="center"><b>중요사항</b></p>
						</td>
					</tr>
					<tbody id="otherInsuTbody">
						<c:forEach items="${print_1_2}" var="otherInsu" varStatus="otherInsuStatus">
							<tr id="otherInsuTr${otherInsuStatus.index}">
								<td class="td" style="word-break:break-all;">
									<p align="center">
										<span class='otherInsuSpan' id='InsuComSpan${otherInsuStatus.index}'>${otherInsu.otherInsuCom}</span>
									</p>
								</td>

								<td class="td" style="word-break:break-all;">
									<p align="center">
										<span class='otherInsuSpan' id='InsuContSpan${otherInsuStatus.index}'>${otherInsu.otherInsuContract}</span>
									</p>
								</td>
								
								<td class="td" style="word-break:break-all;">
									<p align="center">
										<span class='otherInsuSpan' id='InsuDtlSpan${otherInsuStatus.index}'>${otherInsu.otherInsuDtl}</span>
									</p>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- //3. 타 보험사 계약 및 지급사항 -->
				<p>&nbsp;</p>
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td height="25" width="50%">
							<p class="p2">
								<b>4. 중점 조사사항 및 조사 결과 </b>
							</p>
						</td>
					</tr>
				</table>
				
				<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<colgroup>
						<col width="140"></col>
						<col width="500"></col>
					</colgroup>
									
					<tr>
						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>중점<br/>조사사항</b></p>
						</td>
						
						<td class="td" style="word-break:break-all;">
							<span class='inspectPointSpan' id='inspectPointSpan'>${print1.inspectPoint4}</span>
						</td>
					</tr>
					
					<tr>
						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>조사 결과</b></p>
						</td>
						
						<td class="td" style="word-break:break-all;">
							<span class='inspectPointSpan' id='inspectResultSpan'>${print1.inspectResult4}</span>
						</td>
					</tr>
				</table>		
				<p>&nbsp;</p>	
				
				<!-- 5. 총괄 경과표 -->
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td height="25" width="50%">
							<p class="p2">
								<b>5. 총괄 경과표</b>
							</p>
						</td>
					</tr>
				</table>
				
				<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<colgroup>
						<col width="120"></col>
						<col width="390"></col>
						<col width="130"></col>
					</colgroup>
					<tr>
						<td bgcolor="#ECECEC" class="td" width="120">
							<p align="center"><b>일 자</b></p>
						</td>
						<td bgcolor="#ECECEC" class="td" width="390">
							<p align="center"><b>내 용</b></p>
						</td>
						<td bgcolor="#ECECEC" class="td" width="130">
							<p align="center"><b>비 고</b></p>
						</td>
					</tr>
					<tbody id="passTableTbody">
						<c:forEach items="${print_1_6_1}" var="passTableVo" varStatus="passTableStatus">
							<tr id='passTableTr${passTableStatus.index}'>
								<td class='td' style="word-break:break-all;" width="120">
									<p align='center'>
										<span class="passTableSpan" id="passTableDateSpan${passTableStatus.index}">
											${passTableVo.investigateToDate}
											<c:if test="${passTableVo.investigateFromDate ne NULL and passTableVo.investigateFromDate ne ''}">
												<br/>~
												${passTableVo.investigateFromDate}
											</c:if>
											<c:if test="${passTableVo.investigateDateDtl ne NULL and passTableVo.investigateDateDtl ne ''}">
												<br/>
												(${passTableVo.investigateDateDtl})
											</c:if>
										</span>
										<br/>
									</p>
								</td>

								<td class='td' style="word-break:break-all;" width="390">
									<p align='left'>
										<span class="passTableSpan" id="passTableDtlSpan${passTableStatus.index}">
											${passTableVo.investigateDtl}
										</span>
									</p>
								</td>
								<td class='td' style="word-break:break-all;" width="130">
									<p align='center'>	
										<span class="passTableSpan" id="passTableNoteSpan${passTableStatus.index}">
											${passTableVo.investigateOutline}
										</span>		
									</p>	
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- //5. 총괄 경과표 -->
				<p>&nbsp;</p>			
				<!-- 6. 상세 확인사항 -->
				<c:if test="${detailMap.jobUseFlag == 1 or detailMap.accidentUseFlag == 1 or detailMap.hospitalUseFlag == 1 or detailMap.adviceUseFlag == 1 or print_1_detail.size() >= 5}">
					<table align="center" cellpadding="0" cellspacing="0" width="640" id="dtlChkHeader" >
						<colgroup>
							<col width="640"></col>
						</colgroup>
						<tr>
							<td height="25">
								<p class="p2">
									<b>6. 상세 확인사항
									</b>
								</p>
							</td>
						</tr>
					</table>
				</c:if>
				
				<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<colgroup>
						<col width="640"></col>
					</colgroup>
					
					<tbody id="dtlChkTobody">
						<c:if test="${detailMap.jobUseFlag == 1}" >
							<tr id="jobDtlChkTr1" bgcolor="#ECECEC">
								<td class="td" style="font-size:16px;font-weight: bold;padding:10px;">
									직업(직무) 확인
		 						</td>
							</tr>
							
							<tr id="jobDtlChkTr2">
								<td class="td" style="padding: 10px;word-break:break-all;" >
									<span id="jobViewSpan"> 
										<span class="dtlSpan" id="jobSubSpan" >${detailMap.jobContentSub}</span>&nbsp;확인결과, 아래와 같이 확인됨.<br/>
										<span class="dtlSpan" id="jobDtlSpan" >${detailMap.jobContent}</span>
									</span>
								</td>
							</tr>
							<tr id="accidentDtlChkTr0"><td>&nbsp;</td></tr><!-- 행간 조절 -->
						</c:if>						
						
						<c:if test="${detailMap.accidentUseFlag == 1}" >
							<tr class="td" bgcolor="#ECECEC" id="accidentDtlChkTr1">
								<td class="td" style="font-size:16px;font-weight: bold;padding:10px;">
									사고경위 확인
		 						</td>
							</tr>			
							
							<tr id="accidentDtlChkTr2">
								<td class="td" style="padding: 10px;word-break:break-all;" >
									<span id="accidentViewSpan"> 
										<span class="dtlSpan" id="accidentSubSpan">${detailMap.accidentContentSub}</span>&nbsp;확인결과,
										<span class="dtlSpan" id="accidentDtlSpan">${detailMap.accidentContent}</span>
									</span>
								</td>
							</tr>
							<tr id="hospitalDtlChkTr0"><td>&nbsp;</td></tr><!-- 행간 조절 -->
						</c:if>
									
						<c:if test="${detailMap.hospitalUseFlag == 1}" >
							<tr class="td" bgcolor="#ECECEC" id="hospitalDtlChkTr1">
								<td class="td" style="font-size:16px;font-weight: bold;padding:10px;">
									병원 확인
		 						</td>
							</tr>
							
							<tr id="hospitalDtlChkTr2">
								<td class="td" style="padding: 10px;word-break:break-all;">
									<span id="hospitalViewSpan"> 
										<span class="dtlSpan" id="hospitalDtlSpan">${detailMap.hospitalContent}</span>
									</span>
								</td>
							</tr>	
							<tr id="adviceDtlChkTr0"><td>&nbsp;</td></tr><!-- 행간 조절 -->
						</c:if>
						
						<c:if test="${detailMap.adviceUseFlag == 1}" >
							<tr class="td" bgcolor="#ECECEC" id="adviceDtlChkTr1">
								<td class="td" style="font-size:16px;font-weight: bold;padding:10px;">
									제 3 병원 의료자문 확인
		 						</td>
							</tr>
							
							<tr id="adviceDtlChkTr2">
								<td class="td" style="padding: 10px;word-break:break-all;">
									<span id="adviceViewSpan"> 
										<span class="dtlSpan" id="adviceDtlSpan">${detailMap.adviceContent}</span>
									</span>
								</td>
							</tr>						
							<tr id="gubunDtlChkTr"><td>&nbsp;</td></tr><!-- 행간 조절 -->
						</c:if>
					</tbody>
					
					<tbody id="etcDtlChkTbody">
						<c:forEach items="${print_1_detail}" var="etcDtlChk" varStatus="etcDtlChkStatus">
							<c:if test="${etcDtlChk.detailGubun eq 99}">
								<tr id='${etcDtlChkStatus.index}DtlChkTr2' class='td' bgcolor='#ECECEC'>
									<td class="td" style='font-size:16px;font-weight:bold;padding:10px;word-break:break-all;' >
										<span id="${etcDtlChkStatus.index}DtlTitleSpan">
											${etcDtlChk.detailTitle}			
										</span>
									</td>
								</tr>
								
								<tr id='${etcDtlChkStatus.index}DtlChkTr3'>
									<td class='td' style='padding: 10px;word-break:break-all;'>
										<span id="${etcDtlChkStatus.index}ViewSpan">${etcDtlChk.detailContent}</span>
									</td>
								</tr>
								
								<tr id='${etcDtlChkStatus.index}DtlChkTr1'><td>&nbsp;</td></tr>
							</c:if>
						</c:forEach>					
					</tbody>
				</table>
				<p id="dtlChkFocus">&nbsp;&nbsp;&nbsp;</p>
				
				
				<p>&nbsp;</p>
				<p align="center" style="font-size:16px;letter-spacing:-1px;font-family:돋움;">
					<b>
						※ 본 손해사정서는 관련 법률(보험업법 제 189조)에 의거 어느 일방에도 편중됨이 없이
						<BR/>
						신의와 성실의 원칙에 의거하여 공정하게 작성하였음을 명백히 합니다.[끝]
					</b>
				</p>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<!-- 사고처리 과정표 -->
				<table cellpadding="0" cellspacing="0" width="648" align="center">
					<tr>
						<td width="640" height="45" class="td" valign="middle"> 
							<p style="margin:auto 0;" align="center"><font size="5"><b>사 고 처 리 과 정 표</b></font></p>
						</td>
					</tr>
				</table>
				<p>&nbsp;</p>
				
				<p class="p2"><b>1. 일반사항</b></p>
				<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<colgroup>
						<col width="100"></col>
						<col width="220"></col>
						<col width="100"></col>
						<col width="220"></col>
					</colgroup>
					
					<tr>
						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>보험종목</b></p>
						</td>
						<td class="td" style="word-break:break-all;">
							<p align="center"><b>${suimVO.insurance_nm}</b></p>
						</td>

						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>피보험자</b></p>
						</td>
						<td class="td" style="word-break:break-all;">
							<p align="center"><b>${suimVO.beneficiary_nm} 님</b></p>
						</td>
					</tr>
					
					<tr>
						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>사고일시</b></p>
						</td>
						<td class="td" style="word-break:break-all;">
							<p align="center"><b>${suimVO.accident_date}</b></p>
						</td>
						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>보험사 담당자</b></p>
						</td>
						<td class="td">
							<p align="center">
								<b>
									<c:if test="${suimVO.ptnr_mbr_nm ne ''}">
										${suimVO.ptnr_mbr_nm} 님
									</c:if>
								</b>
							</p>
						</td>
					</tr>
					
					<tr>
						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>보고서접수일</b></p>
						</td>
						<td class="td" style="word-break:break-all;">
							<p align="center"><b>${suimVO.reg_date}</b></p>
						</td>
						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>조사자</b></p>
						</td>
						<td class="td" style="word-break:break-all;">
							<p align="center"><b>${mbrVoForBody.user_name}</b></p>
						</td>
					</tr>
				</table>
				
				<p>&nbsp;</p>

				<!-- 사고처리과정표 - 처리과정 -->
				<p class="p2">
					<b>2. 처리과정</b>
				</p>
				
				<table cellSpacing=0 cellPadding="0" width="648" align="center" bordercolordark="white" bordercolorlight="#999999">
					<colgroup>
						<c:choose>
                            <c:when test="${suimVO.ptnr_id == 9}">
                                <col width="100"/>
                                <col width="50"/>
                                <col width="200"/>
                                <col width="200"/>
                                <col width="50"/>
                                <col width="48"/>
                            </c:when>
                            <c:otherwise>
                                <col width="150"/>
                                <col width="228"/>
                                <col width="270"/>
                            </c:otherwise>
                        </c:choose>
					</colgroup>
					<%--${suimVO.ptnr_id} - ${suimVO.ptnr_mbr_no}--%>
                    <c:choose>
                        <c:when test="${suimVO.ptnr_id == 9}">
                            <tr>
                                <td bgcolor="#ECECEC" class="td" >
                                    <p align="center"><b>일 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자</b></td>
                                <td bgcolor="#ECECEC" class="td" >
                                    <p align="center"><b>일 수</b></p>
                                </td>
                                <td bgcolor="#ECECEC" class="td" >
                                    <p align="center"><b>업 &nbsp;무 &nbsp;내 &nbsp;용</b></td>
                                <td bgcolor="#ECECEC" class="td" >
                                    <p align="center"><b>세 &nbsp;부 &nbsp;내 &nbsp;용</b></p>
                                </td>
                                <td bgcolor="#ECECEC" class="td" >
                                    <p align="center"><b>지연주체</b></p>
                                </td>
                                <td bgcolor="#ECECEC" class="td" >
                                    <p align="center"><b>지연일수</b></p>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td bgcolor="#ECECEC" class="td" >
                                    <p align="center"><b>일 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자</b></td>
                                <td bgcolor="#ECECEC" class="td" >
                                    <p align="center"><b>항 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</b></td>
                                <td bgcolor="#ECECEC" class="td" >
                                    <p align="center"><b>처 &nbsp;리 &nbsp;내 &nbsp;용</b></p>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                    <tbody id="printCtrlTbody">
						<c:forEach items="${print_1_ctrl}" var="printCtrlVo" varStatus="printCtrlStatus">
							<tr id='printCtrlTr${printCtrlStatus.index}'>
								<td class='td' style="word-break:break-all;">
									<p align='center'>
										<span class="printCtrlSpan" id="printCtrlDateSpan${printCtrlStatus.index}">${printCtrlVo.controlEndDate}</span>
									</p>
								</td>
                                <c:if test="${suimVO.ptnr_id == 9}">
                                    <td class='td' style="word-break:break-all;">
                                    	<p align='center'>
                                    		<span class="printCtrlSpan" id="printCtrlDateCntSpan${printCtrlStatus.index}">${printCtrlVo.controlDateCnt} 일</span>
                                    	</p>
                                   	</td>
                                </c:if>
								<td class='td' style="word-break:break-all;">
									<p align='center'>
										<span class="printCtrlSpan" id="printCtrlSubjectSpan${printCtrlStatus.index}">${printCtrlVo.controlSubject}</span>
									</p>
								</td>

								<td class='td' style="word-break:break-all;">
									<p align='center'>
										<span class="printCtrlSpan" id="printCtrlMemoSpan${printCtrlStatus.index}" >${printCtrlVo.controlMemo}</span>
									</p>
								</td>

                                <c:if test="${suimVO.ptnr_id == 9}">
                                    <td class='td' style="word-break:break-all;">
                                    	<p align='center'>
	                                    	<span class="printCtrlSpan" id="printCtrlDateCntSpan${printCtrlStatus.index}">
	                        					<c:choose>
													<c:when test="${printCtrlVo.controlDelayAgent eq '1'}">보험사</c:when>
													<c:when test="${printCtrlVo.controlDelayAgent eq '2'}">수익자</c:when>
													<c:when test="${printCtrlVo.controlDelayAgent eq '3'}">계약자</c:when>
													<c:when test="${printCtrlVo.controlDelayAgent eq '4'}">피보험자</c:when>
												</c:choose>
                                    		</span>
		                                </p>
                                   	</td>
                                    <td class='td' style="word-break:break-all;">
		                                <p align='center'>
	                                    	<span class="printCtrlSpan" id="printCtrlDateCntSpan${printCtrlStatus.index}">
	                                    		${printCtrlVo.controlDelayCnt} 일
	                                   		</span>
		                                </p>
                                   	</td>
                                </c:if>

							</tr>
						</c:forEach>
                        <c:if test="${suimVO.ptnr_id == 9}">
                            <tr>
                                <td colspan="4" align="center" class='td' bgcolor="#ECECEC">
                                    <span style="color: red;">총지연일수</span>
                                </td>
                                <td colspan="2" align="center" class='td'>
                                	${print_1_ctrl_delay_cnt.allDelayCnt} 일
                               	</td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center" class='td' bgcolor="#ECECEC">
                                    <span style="color: red;">계약자, 피보험자, 수익자의 책임있는 사유 조사 지연일수</span>
                                </td>
                                <td colspan="2" align="center" class='td'>
                                	${print_1_ctrl_delay_cnt.notInsuDelayCnt} 일
                               	</td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center" class='td' style="background-color: yellow;">
                                    <span style="color: red;">보험사 지연일수</span>
                                </td>
                                <td colspan="2" align="center" class='td'>
                                	${print_1_ctrl_delay_cnt.insuDelayCnt} 일
                               	</td>
                            </tr>
                        </c:if>
					</tbody>
				</table>
			<c:if test="${print1.sagoDocFlag == 1}">				
				<p>&nbsp;</p>
				<!-- 사고처리과정표 - 첨부서류 -->			
				<p class="p2">
						<b>3. 첨부서류</b>
				</p>
				
				<table class="sagoDocTable" cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<colgroup>
						<col width="50"></col>
						<col width="240"></col>
						<col width="50"></col>
						<col width="300"></col>
					</colgroup>	
					<tr>
						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>순번</b></p>
						</td>
						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>첨부자료</b></p>
						</td>

						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>부수</b></p>
						</td>
						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>비고</b></p>
						</td>
					</tr>
					<tbody id="sagoDocTbody">
						<c:forEach items="${print1_8}" var="print1_8" varStatus="print1_8Status">
							<tr id="sagoDocTr${print1_8Status.index}">
								<td class='td' align="center">
									<span style="font-size: 12px;" class='sagoDocSpan' id='sagoDocOrderSpan${print1_8Status.index}'>${print1_8Status.count}</span>
<%-- 									<input class='sagoTxt' type='text' id='sagoOrderTxt${print1_8Status}' value='${print1_8Status.count}' style='width:29px;'/> --%>
								</td>
								
								<td class='td' align="center">
									<span style="font-size: 12px;" class='sagoDocSpan' id='sagoDocNmSpan${print1_8Status.index}'>${print1_8.attachName}</span>
								</td>
								
								<td class='td' align="center">
									<span style="font-size: 12px;" class='sagoDocSpan' id='sagoDocCntSpan${print1_8Status.index}'>${print1_8.attachCopy}</span>
								</td>
								
								<td class='td' align="center">
									<span style="font-size: 12px;" class='sagoDocSpan' id='sagoDocNoteSpan${print1_8Status.index}'>${print1_8.attachEtcMemo}</span>
								</td>
							<tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
			</td>
		</tr>
	</table>
    <c:if test="${suimVO.ptnr_id == 9 && fn:length(reportHospitalQuestionList) > 0}">
	<p style="">&nbsp;</p>
	<p style="">&nbsp;</p>
	<p class="title" align="center" style="font-size: 16pt; font-family: 돋움;"><b>&lt;별첨:병.의원 탐문기록지&gt;</b></p>
	<table cellpadding="0" cellspacing="0" align="center" width="640" border="1">
		<tr>
			<th bgcolor="#ECECEC" class="td" width="50">번호</th>
			<th bgcolor="#ECECEC" class="td" width="147">병.의원명</th>
			<th bgcolor="#ECECEC" class="td" width="169">소재지역</th>
			<th bgcolor="#ECECEC" class="td" width="127">연락처</th>
			<th bgcolor="#ECECEC" class="td" width="147">확인결과</th>
		</tr>
		<c:forEach  var="item" items="${reportHospitalQuestionList}" varStatus="status">
			<tr>
				<td class="td" align="center">${status.count}</td>
				<td class="td" style="padding: 0px 5px;"><c:out value="${item.hsptName}"/></td>
				<td class="td" style="padding: 0px 5px;"><c:out value="${item.hsptAddress}"/></td>
				<td class="td" style="padding: 0px 5px;"><c:out value="${item.hsptTel}"/></td>
				<td class="td" style="padding: 0px 5px;"><c:out value="${item.hsptConfirm}"/></td>
			</tr>
		</c:forEach>
	</table>
    </c:if>


	
</body>