<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>보고서 작성</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<link rel="stylesheet" type="text/css" href="./resources/ls_css/rpt_6_style.css" />
	<link rel="stylesheet" type="text/css" href="./resources/ls_css/rpt_1001_style.css" />
	
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
    <link rel="stylesheet" type="text/css" href="./resources/wm_css/general_report.css?v=201707261117"/>
	
	<script src="./resources/jqueryplaceholder/jquery.placeholder.js"></script>	
	<script src="./resources/ne_js/rpt_1001.js"></script>
	<script src="./resources/cmm/js/common.js"></script>
	
	
	<script>
		$(document).ready(function(){
			//ajax 중복 호출을 위한 cache:false
			$.ajaxSetup({cache:false});
		
			$(".dtlTitleTxt").placeholder();
			
			//단순보고서 워드 다운
			$("#rpt1001Word").click(function(){
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				
				var sw=1000; //띄울 창의 넓이
				var sh=740;  //띄울 창의 높이
		
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				
				window.open('PrintWord1001?suimRptNo='+'${suimVO.suim_rpt_no}'+'&type=word','print','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});
			
			//단순보고서 인쇄 
			$("#rpt1001Print").click(function(){
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				
				var sw=700; //띄울 창의 넓이
				var sh=550;  //띄울 창의 높이
		
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				
				window.open('PrintWord1001?suimRptNo='+'${suimVO.suim_rpt_no}'+'&type=page','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});
		});
		
			
	    /* mask 처리 */
	    function _initMask(){
	        var options = {
	            onKeyPress : function(cep, event, currentField, options){
	                var tid = event.currentTarget.id;
	                var tidx = tid.substr(tid.length - 1, 1);
	                //console.log(tidx);
	                //fnCaculateTotal(tidx);
	            },
	            reverse : true
	        };

	        $('input.onlyNumber').mask('#######',options);
	        $('div.onlyNumber').mask('999999999',{reverse:true});
		}
	</script>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
	<input type="hidden" id="sagoDocFlag" value="${print1.sagoDocFlag}" />
	<input type="hidden" id="jobUseFlag" value="${detailMap.jobUseFlag}" />
	<input type="hidden" id="accidentUseFlag" value="${detailMap.accidentUseFlag}" />
	<input type="hidden" id="hospitalUseFlag" value="${detailMap.hospitalUseFlag}" />
	<input type="hidden" id="adviceUseFlag" value="${detailMap.adviceUseFlag}" />
	
	<input type="hidden" id="jobContent" value="${detailMap.jobContent}" />
	<input type="hidden" id="faceInsuredJob6" value="${print1.faceInsuredJob6}" />
	

	
	<!-- 표지시작 -->
	<table id = "rptBody6Table" align="center" cellpadding="0" cellspacing="0" width="648">
		<tr>
			<td>
				<p align="right">
					<img src="./resources/ls_img/report/btn_word.gif" id ="rpt1001Word" title ="워드 출력" style="cursor:pointer;" border="0">
					<img src="./resources/ls_img/report/icon_print.gif" id ="rpt1001Print" title ="화면 인쇄" style="cursor:pointer;" border="0">
				</p>
				<p align="center"><img src="https://www.toplac.co.kr/resources/ls_img/ls_body/print_head.jpg" width="640" height="56" border="0"></p>
				<p align="center" style="line-height:50%; margin-top:0; margin-bottom:0;">&nbsp;</p>
				<p align="center"><span style="font-size:9pt;">${tmInforForBody.team_addr}</span></p> 
				<p align="center"><span style="font-size:9pt;">전화 : ${tmInforForBody.team_telephone} &nbsp;팩스 : ${tmInforForBody.team_fax} &nbsp;이메일 : ${mbrVoForBody.email}</span></p>
				<p align="center"><img src="./resources/ls_img/ls_body/print_hr.jpg" width="640" height="3" border="0"></p>
				
				<table cellpadding="0" cellspacing="0" width="648" align="center">
					<colgroup>
						<col width="400"></col>
						<col width="248"></col>
					</colgroup>
					<tr><th height="20"></th></tr>
					<tr>
						<th align="left" height="30"><!-- 수신 -->
							<p>수 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신 : ${suimVO.ptnr_name}</p>
						</th>
						<th align="right" height="30"><!--  보고서 번호 -->
							<p>Report No. ${suimVO.suim_accept_no}</p>
						</th>
					</tr>
					
					<tr>
						<th align="left" height="30"><!-- 참조 -->
							<p>
								참 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조 : ${suimVO.ptnr_dept_nm} 
								<c:if test="${suimVO.ptnr_mbr_nm ne ''}">
								〔 담당 : ${suimVO.ptnr_mbr_nm} 님 〕
								</c:if>
							</p>
						</th>
						<th align="right" height="30"><!-- 보고서 제출일 -->
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
						<th colspan="2" align="left" height="30">
							<p>
								제 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목 : 
								<c:if test="${suimVO.beneficiary_nm ne ''}">
									&quot;<b>${suimVO.beneficiary_nm}</b>&quot;
								</c:if>
								 손해사정서
							</p>
						</th>
					</tr>
					<tr>
						<th colspan="2" align="left" height="30">
							<p>증 권 번 호 : 제 ${suimVO.policy_no} 호</p>
						</th>
					</tr>
					<tr>
						<th colspan="2" align="left" height="30"> 
							<p>사 고 번 호 : ${suimVO.accident_no}</p>
						</th>
					</tr>
					<tr>
						<td colspan="2" height="120" >
							<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							귀 사의 요청에 의거하여 
							피보험자 &quot;${suimVO.beneficiary_nm}&quot;의
							보험금 청구건에 대한 사고조사를 실시하고, 그 결과를 다음과 같이 제출 합니다.
							
<%-- 							<c:if test="${suimVO.beneficiary_ssn ne null and suimVO.beneficiary_ssn ne ''}">${suimVO.beneficiary_ssn}</c:if>의 --%>
			                        
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
							<td class="td">
								손해사정사
							</td>
							<!-- 성명 -->
							<td class="td">
								윤경수
							</td>
							<!-- 서명 -->
							<td height="70" class="td">
								<p><img src="./resources/ls_img/ls_body/sign_yoon.jpg" width="62" height="60" border="0"></p>
							</td>
							<!-- 연락처 -->
							<td class="td">
								<p>070-8255-3000</p>
							</td>
						</tr>
						
						<tr>
							<!-- 구분 -->
							<td class="td">
								팀 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;장 
							</td>
							<!-- 성명 -->
							<td class="td">
								${mbrVoForBodySantion.user_name}
								<br/>
								<c:if test="${mbrVoForBodySantion.work_level ne null and mbrVoForBodySantion.work_level ne ''}">
									(${mbrVoForBodySantion.work_level})
								</c:if>
							</td>
							<!-- 서명 -->
							<td style="padding: 5px;" height="70" class="td">
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
							<td class="td">
								<p>${mbrVoForBodySantion.handphone }</p>
							</td>
						</tr>	
						
						<tr>
							<!-- 구분 -->
							<td class="td">
								<p>조 &nbsp;&nbsp;사 &nbsp;&nbsp;자 </p>
							</td>
							<!-- 성명 -->
							<td class="td">
								<p>
									${mbrVoForBody.user_name }
									<br/>(${mbrVoForBody.work_level})
								</p>
							</td>
							<!-- 서명 -->
							<td style="padding: 5px;" height="70" class="td">
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
							<td class="td">
								<p>${mbrVoForBody.handphone }</p>
							</td>
						</tr>					
		            </table>
				</div>
		       	<!-- //표지 --> 
		        
		        <!-- print1 PK -->
		        <input type="hidden" id="suimRptNo" value="${suimVO.suim_rpt_no}" />
		        <input type="hidden" id="rptPrintNo" value="${print1.rptPrintNo}" />
		        
				<!-- 계약확인사항 -->
				<p>&nbsp;</p>
	            <hr size="1" noshade color="black">
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td height="25" width="50%">
							<p class="p2">
								<b>1. 계약확인사항 </b>
							</p>
						</td>
						<td height="25" width="50%">
							<p align="right">
								<img style = "cursor:pointer; float:right; " id="SimpleMod1Btn" src="./resources/ls_img/btn_edite.gif"/>
								<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "SimpleCancel1Btn" style="float:right; display:none; cursor:pointer; " />
								<img src="./resources/ls_img/icon_write.gif" title="저장" id = "SimpleSave1Btn" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
							</p>
						</td>
					</tr>
					<tr >
						<td colspan="2" align="center">
							<img src="./resources/ls_img/ls_body/1/01.jpg" title="계약 사항 샘플 양식" id = "print1_1SampleImg" style="display:none; cursor:pointer; " onclick="print1_1ShowHide();" />
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
						<td colspan="4" class="td">
							<p>
								<span class= "1Span" id="insuNm1Span" style="color:black;">${suimVO.insurance_nm}</span>
								<input class="simple1Txt" type="text" id="insuNm1Txt" style="display:none;" value="${suimVO.insurance_nm}"/>
							</p>
						</td>
					</tr>
					
					<tr>
						<td bgcolor="#ECECEC" class="td" width="140">
							<p align="center">증권번호</p>
						</td>
						<td colspan="4" class="td">
							<p>
								<span class= "1Span" id="policyNo1Span">${suimVO.policy_no }</span>
								<input class="simple1Txt" type="text" id="policyNo1Txt" style="display:none;" value="${suimVO.policy_no}"/>
							</p>
						</td>
					</tr>
					
					<tr>
						<td bgcolor="#ECECEC" class="td" width="140">
							<p align="center">계약일자</p>
						</td>
						<td colspan="4" class="td">
							<p>
								<span class= "1Span" id="insuTerm1Span">${print1.insuTerm1}</span>
								<input class="simple1Txt" type="text" id="insuTerm1Txt" style="display:none;" value="${print1.insuTerm1}"/>
							</p>
						</td>
					</tr>
					
					<tr>
						<td bgcolor="#ECECEC" class="td" width="140">
							<p align="center">계약자 / 피보험자</p>
						</td>
						<td colspan="4" class="td">
							<p>
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
							</p>
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
						<td colspan="4" class="td">
							<p>
								<span class= "1Span" id="jobChk1Span">${print1.faceInsuredJob6}</span>
								<input type="text" class="simple1Txt" id="jobChk1Txt" style="display:none;" value="${print1.faceInsuredJob6}"/>
							</p>
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
						<td height="25" width="50%">
							<p align="right">
								<img style = "cursor:pointer; float:right; " id="claimModBtn" src="./resources/ls_img/btn_edite.gif"/>
								<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "claimCancelBtn" style="float:right; display:none; cursor:pointer; " />
								<img src="./resources/ls_img/icon_write.gif" title="저장" id = "claimSaveBtn" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
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
						<th class="td" bgcolor="#ECECEC">구 분</th>
						<th class="td" bgcolor="#ECECEC" colspan="4">내 용</th>
					</tr>
					
					<tr>
						<td class="td" bgcolor="#ECECEC" align="center">진단병명</td>
						<td class="td">
							<span class= "claimSpan" id="diseaseClaimSpan">${print1.diagnosisDisease3}</span>
							<input type="text" class="claimTxt" id="diseaseClaimTxt" style="display:none;" value="${print1.diagnosisDisease3}"/>
						</td>
					</tr>
					 
					<tr>
						<td class="td" bgcolor="#ECECEC" align="center">진단병원</td>
						<td class="td"> 
							<span class= "claimSpan" id="hospitalClaimSpan">${print1.diagnosisHospital3}</span>
							<input type="text" class="claimTxt" id="hospitalClaimTxt" style="display:none;" value="${print1.diagnosisHospital3}"/>
						</td>
					</tr>
					
					<tr>
						<td class="td" bgcolor="#ECECEC" align="center" rowspan="3" style="line-height:110%">
							담보내역<br/>
							및<br/>
							추정 손해액
						</td>
						
						<td id="assureTableTd">
							<input type="hidden" id="assureSize" value="${print_1_assure.size()}"/><!-- 이벤트 발생용 구분값 -->
						    <table>
								<colgroup>
									<col width='149'></col>
									<col width='150'></col>
									<col width='150'></col>
									<col width='50'></col>
								</colgroup>
								<tr>
									<td class='td' align='center' bgcolor='#ECECEC' style='border-top:0px; border-left:0px;'>담보사항</td>
									<td class='td' align='center' bgcolor='#ECECEC' style='border-top:0px;'>가입금액</td>
									<td class='td' align='center' bgcolor='#ECECEC' style='border-top:0px;'>추정손해액</td>
									<td class='td' align='center' bgcolor='#ECECEC' style='border-top:0px;' >
										<!-- 추가버튼 -->
										<img src='./resources/ls_img/ls_body/btn_add.gif' id='assureAddBtn' title='추가' onclick='javascript:assureAddView();' style='cursor:pointer;' />
									</td>
								</tr>
								
								<tbody id='assureTbody'>
									<c:forEach items='${print_1_assure}' var='assureVo' varStatus='assureStatus'>
										<tr id='assureTr${assureStatus.index}' index='${assureStatus.index}'>
											<!-- 담보사항 -->
											<td class='td' align='center' style='border-left: 0px;'>
												<span class='assureSpan' id='dtlAssureSpan${assureStatus.index}'>${assureVo.assureDtl}</span>
												<input type='text' class='assureTxt' id='dtlAssureTxt${assureStatus.index}' value='${assureVo.assureDtl}' style='width:120px;display:none;'/>				
											</td>
										
											<!-- 가입금액 -->
											<td class='td' align='right' style="padding-right:20px;">
												<span class= 'assureSpan' id='joinAmountAssureSpan${assureStatus.index}'><fmt:formatNumber value='${assureVo.joinAmount}' pattern='###,###,##0.##'/> 원</span>
												<input  type='text' class='assureTxt' name='joinAmountAssureTxt' id='joinAmountAssureTxt${assureStatus.index}'
														value='<fmt:formatNumber value='${assureVo.joinAmount}' pattern='###,###,##0.##'/>' style='width:120px;display:none;IME-MODE: disabled;'
														ONKEYDOWN='javascript:onlyNumberFunc2(this);' ONKEYUP='javascript:numberCommaFunc(this);'/>
											</td>
										
											<!-- 추정손해액 -->
											<td class='td' align='right' style="padding-right:20px;">
												<span class= 'assureSpan' id='estimationAmoutAssureSpan${assureStatus.index}'><fmt:formatNumber value='${assureVo.estimationAmount}' pattern='###,###,##0.##'/> 원</span>
												<input  type='text' class='assureTxt' name='estimationAmoutAssureTxt' id='estimationAmoutAssureTxt${assureStatus.index}'
														value='<fmt:formatNumber value='${assureVo.estimationAmount}' pattern='###,###,##0.##'/>' style='width:120px;display:none;IME-MODE: disabled;'
														ONKEYDOWN='javascript:onlyNumberFunc2(this);' ONKEYUP='javascript:numberCommaFunc(this);'/>				
											</td>
										
											<!-- 버튼영역 -->
											<td class='td' align='center'>										
												<span class='assureSpan' id='ModBtnAssureSpan${assureStatus.index}'>
													<img src='./resources/ls_img/btn_edit_s.gif' class='assureModBtn' onclick='javascript:assureModifyView(${assureStatus.index});' style='cursor:pointer;'/>
													 <img src='./resources/ls_img/btn_del_s.gif' class='assureDelBtn' onclick='javascript:assureDelete(${assureVo.serialNo})' style='cursor:pointer;'/>
												</span>
												
												<span class='assureSpan' id='ModAftSaveBtnAssureSpan${assureStatus.index}' style='display:none;'>			
													<img src='./resources/ne_img/btn/btn_save.gif' class='assureModSaveBtn' onclick='javascript:assureUpdate(${assureStatus.index},${assureVo.serialNo});' id='assureModSaveBtn${assureStatus.index}' serialNo='${assureVo.serialNo}' index='${assureStatus.index}' style='cursor:pointer;'/>
													<br/><img src='./resources/ne_img/btn/btn_close.gif' class='assureModCloseBtn' onclick='javascript:assureModifyClose(${assureStatus.index});'  style='cursor:pointer;margin-top:5px;'/>
												</span>					
											</td>
										</tr>
										<c:set var='joinAmountSum' value='${assureVo.joinAmount + joinAmountSum}'/>
										<c:set var='estimationAmoutSum' value='${assureVo.estimationAmount + estimationAmoutSum}'/>
									</c:forEach>
								</tbody>
							
								<tr>
									<td class='td' align='center' bgcolor='#ECECEC' style='border-left: 0px;'>합계</td>
									<td class='td' align='right' style="padding-right:20px;">
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
									<td class='td' align='right' style="padding-right:20px;">
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
									<td class='td' align='center'>
										-
									</td>
								</tr>			
							</table>
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
						<td height="25" width="50%">
							<p align="right">
								<!-- 추가버튼 -->
								<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id="otherInsuAddBtn" onclick="javascript:otherInsuAddView()" style="float:right; cursor:pointer;" />
<!-- 								<img style = "cursor:pointer; float:right; " id="claimModBtn" src="./resources/ls_img/btn_edite.gif"/> -->
<!-- 								<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "claimCancelBtn" style="float:right; display:none; cursor:pointer; " /> -->
<!-- 								<img src="./resources/ls_img/icon_write.gif" title="저장" id = "claimSaveBtn" style="float:right; display:none; cursor:pointer; margin-right:5px;" /> -->
							</p>
						</td>
					</tr>
				</table>
				
				<input type="hidden" id="otherInsuSize" value="${print_1_2.size()}"/>
				<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<colgroup>
						<col width="100"></col>
						<col width="140"></col>
						<col width="350"></col>
						<col width="50"></col>
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
						<td class="td" bgcolor="#ECECEC">
							<p align="center"><b>-</b></p>
						</td>
					</tr>
					<tbody id="otherInsuTbody">
						<c:forEach items="${print_1_2}" var="otherInsu" varStatus="otherInsuStatus">
							<tr id="otherInsuTr${otherInsuStatus.index}">
								<td class="td">
									<p align="center">
										<span class='otherInsuSpan' id='InsuComSpan${otherInsuStatus.index}'>${otherInsu.otherInsuCom}</span>
										<input class='otherInsuTxt' type='text' id='InsuComTxt${otherInsuStatus.index}' value='${otherInsu.otherInsuCom}' style='width:75px;display:none;'/>
									</p>
								</td>

								<td class="td">
									<p align="center">
										<span class='otherInsuSpan' id='InsuContSpan${otherInsuStatus.index}'>${otherInsu.otherInsuContract}</span>
										<input class='otherInsuTxt' type='text' id='InsuContTxt${otherInsuStatus.index}' value='${otherInsu.otherInsuContract}' style='width:115px;display:none;'/>
									</p>
								</td>
								
								<td class="td">
									<p align="center">
										<span class='otherInsuSpan' id='InsuDtlSpan${otherInsuStatus.index}'>${otherInsu.otherInsuDtl}</span>
										<input class='otherInsuTxt' type='text' id='InsuDtlTxt${otherInsuStatus.index}' value='${otherInsu.otherInsuDtl}' style='width:325px;display:none;'/>
									</p>
								</td>
								
								<td class="td">
									<p align="center">
										<span class='OtherInsuSpan' id='ModBtnOtherInsuSpan${otherInsuStatus.index}' >
											<img src='./resources/ls_img/btn_edit_s.gif' onclick='javascript:otherInsuModifyView(${otherInsuStatus.index});' style='cursor:pointer;'/>
											<img src='./resources/ls_img/btn_del_s.gif' onclick="javascript:otherInsuDelete(${otherInsu.serialNo})" style='cursor:pointer;'/>
										</span>
										<span class='OtherInsuSpan' id='ModAftSaveBtnOtherInsuSpan${otherInsuStatus.index}' style='display:none;'>			
											<img src='./resources/ne_img/btn/btn_save.gif' onclick="otherInsuUpdate(${otherInsuStatus.index},${otherInsu.serialNo})" style='cursor:pointer;'/>
											<br/><img src='./resources/ne_img/btn/btn_close.gif' onclick="otherInsuModifyClose(${otherInsuStatus.index})" style='cursor:pointer;margin-top:5px;'/>
										</span>
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
						<td height="25" width="50%">
							<p align="right">
								<!-- 추가버튼 -->
<!-- 								<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id="otherInsuAddBtn" onclick="javascript:otherInsuAddView()" style="float:right; cursor:pointer;" /> -->
<!-- 								<img style = "cursor:pointer; float:right; " id="claimModBtn" src="./resources/ls_img/btn_edite.gif"/> -->
<!-- 								<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "claimCancelBtn" style="float:right; display:none; cursor:pointer; " /> -->
<!-- 								<img src="./resources/ls_img/icon_write.gif" title="저장" id = "claimSaveBtn" style="float:right; display:none; cursor:pointer; margin-right:5px;" /> -->
							</p>
						</td>
					</tr>
				</table>
				
				<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<colgroup>
						<col width="140"></col>
						<col width="450"></col>
						<col width='50'></col>
					</colgroup>
					<tr id="pointBtnTr" style="display: none;">
						<td class="td">
							<p align="center"><b>선택</b></p>
						</td>
						<td class="td">
							<span id='pointBtnSpan'>
								<select class='pointSelect' name='pointSelect' id='pointSelect' style='width:100%;' >
									<c:forEach var="pointList" items="${inspectPointList}" varStatus="DocListStatus">
										<option value="${pointList.col_cd}">${pointList.col_val}</option>
									</c:forEach>
										<option value="0">--- 직접 입력 ---</option>
								</select>
							</span>							
						</td>
						<td class="td">
							<img src="./resources/ls_img/ls_body/btn_add.gif" id="inspectPointAddBtn" title="추가" style="cursor:pointer;" />
						</td>
					</tr>	
									
					<tr>
						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>중점<br/>조사사항</b></p>
						</td>
						
						<td class="td">
							<span class='inspectPointSpan' id='inspectPointSpan'>${print1.inspectPoint4}</span>
							<textarea class="inspectPointTxtArea" id="inspectPointTxtArea" style="display: none;width:435px;"
									  placeholder=""
									  onfocus="javascript:fnAutoSize(this.scrollHeight,this);" 
							   	 	  onKeyUP="javascript:fnAutoSize(this.scrollHeight,this);"
							 		  onKeyDown="javascript:fnAutoSize(this.scrollHeight,this);">${print1.inspectPoint4}</textarea>
								
						</td>
						
						<td class="td">
							<span class='inspectPointSpan' id='ModBtnInspectPointSpan'>
								<img style = "cursor:pointer;" id="inspectPointModBtn" src="./resources/ls_img/btn_edite.gif"/>
							</span>
							<span class='inspectPointSpan' id='ModAftBtnInspectPointSpan' style='display:none;'>	
								<img src='./resources/ne_img/btn/btn_save.gif' id="inspectPointSaveBtn" style='cursor:pointer;margin-top:5px;'/>
								<br/><img src='./resources/ne_img/btn/btn_close.gif' id="inspectPointCloseBtn" style='cursor:pointer;margin-top:5px;'/>
							</span>
						</td>
					</tr>
					
					
					<tr id="resultBtnTr" style="display: none;">
						<td class="td">
							<p align="center"><b>선택</b></p>
						</td>
						<td class="td">
							<span id='pointBtnSpan'>
								<select class='pointSelect' name='resultSelect' id='resultSelect' style='width:100%;' >
									<c:forEach var="resultList" items="${inspectResultList}" varStatus="DocListStatus">
										<option value="${resultList.col_cd}">${resultList.col_val}</option>
									</c:forEach>
										<option value="0">--- 직접 입력 ---</option>
								</select>
							</span>							
						</td>
						<td class="td">
							<img src="./resources/ls_img/ls_body/btn_add.gif" id="inspectResultAddBtn" title="추가" style="cursor:pointer;" />
						</td>
					</tr>	
					
					<tr>
						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>조사 결과</b></p>
						</td>
						
						<td class="td">
							<span class='inspectPointSpan' id='inspectResultSpan'>${print1.inspectResult4}</span>
							
							<textarea class="inspectPointTxtArea" id="inspectResultTxtArea" style="display: none;width:435px;" rows="5"
									  placeholder=""
									  onfocus="javascript:fnAutoSize(this.scrollHeight,this);" 
							   	 	  onKeyUP="javascript:fnAutoSize(this.scrollHeight,this);"
							 		  onKeyDown="javascript:fnAutoSize(this.scrollHeight,this);">${print1.inspectResult4}</textarea>							
						</td>
						
						<td class="td">
							<span class='inspectPointSpan' id='ModBtnInspectResultSpan'>
								<img style = "cursor:pointer;" id="inspectResultModBtn" src="./resources/ls_img/btn_edite.gif"/>
							</span>
							
							<span class='inspectPointSpan' id='ModAftBtnInspectResultSpan' style='display:none;'>	
								<img src='./resources/ne_img/btn/btn_save.gif' id="inspectResultSaveBtn" style='cursor:pointer;margin-top:5px;'/>
								<br/><img src='./resources/ne_img/btn/btn_close.gif' id="inspectResultCloseBtn" style='cursor:pointer;margin-top:5px;'/>
							</span>
						</td>
					</tr>
				</table>		
				<p>&nbsp;</p>	
				
				<!-- 5. 총괄 경과표 -->
				<input type="hidden" id="passTableSize" value="${print_1_6_1.size()}"/><!-- 이벤트 발생용 구분값 -->
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td height="25" width="50%">
							<p class="p2">
								<b>5. 총괄 경과표</b>
							</p>
						</td>
						<td height="25" width="50%">
							<p align="right">
								<!-- 추가버튼 -->
								<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id="passTableAddBtn" onclick="javascript:passTableAddView();" style="float:right; cursor:pointer;" />
							</p>
						</td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<colgroup>
						<col width="120"></col>
						<col width="340"></col>
						<col width="130"></col>
						<col width="50"></col>
					</colgroup>
					<tr>
						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>일 자</b></p>
						</td>
						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>내 용</b></p>
						</td>
						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>비 고</b></p>
						</td>
						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>-</b></p>
						</td>
					</tr>
					<tbody id="passTableTbody">
						<c:forEach items="${print_1_6_1}" var="passTableVo" varStatus="passTableStatus">
							<tr id='passTableTr${passTableStatus.index}'>
								<td class='td'>
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
										<span class='passTableInputSpan' id="passTalbeDateInputSpan${passTableStatus.index}" style="display: none;">
											<input type='text' class='passTableDateTxt' id='passTableToDateTxt${passTableStatus.index}' maxlength='10' value='${passTableVo.investigateToDate}' />
											<br/>~ &nbsp;
											<input type='text' class='passTableDateTxt' id='passTableFromDateTxt${passTableStatus.index}' maxlength='10' value='${passTableVo.investigateFromDate}' style='margin-top:5px;'/>
											<br/><br/>
											<input type="radio" name="passTableGubun" onclick="fnPassTableGubun(1,${passTableStatus.index})" value = "1"/> 입원
											<input type="radio" name="passTableGubun" onclick="fnPassTableGubun(2,${passTableStatus.index})" value = "2"/> 통원
											<br/>
											<input type="text" id="passTableGubunTxt${passTableStatus.index}" value="${passTableVo.investigateDateDtl}" style="width:100px;"/>
										</span>
										<br/>
									</p>
								</td>

								<td class='td'>
									<p align='left'>
										<span class="passTableSpan" id="passTableDtlSpan${passTableStatus.index}">
											${passTableVo.investigateDtl}
										</span>
										<textarea class='passTableTxtArea' id='passTableDtlTxtArea${passTableStatus.index}' style='display:none;width:318px;'
								  				   onfocus='javascript:fnAutoSize(this.scrollHeight,this);'
						   	 	  				   onKeyUP='javascript:fnAutoSize(this.scrollHeight,this);'
						 		  				   onKeyDown='javascript:fnAutoSize(this.scrollHeight,this);'>${passTableVo.investigateDtl}</textarea>
									</p>
								</td>
								<td class='td'>
									<p align='center'>	
										<span class="passTableSpan" id="passTableNoteSpan${passTableStatus.index}">
											${passTableVo.investigateOutline}
										</span>		
										<input class='passTableTxt' type='text' id='passTableNoteTxt${passTableStatus.index}' value='${passTableVo.investigateOutline}' style='display:none;width:108px;'/>
									</p>	
								</td>
								
								<td class='td'>
									<p align='center'>
										<span class='passTableSpan' id='ModBtnPassTableSpan${passTableStatus.index}' >
											<img src='./resources/ls_img/btn_edit_s.gif' onclick='javascript:passTableModifyView(${passTableStatus.index});' style='cursor:pointer;'/>
											<img src='./resources/ls_img/btn_del_s.gif' onclick="javascript:passTableDelete(${passTableVo.serialNo})" style='cursor:pointer;'/>
										</span>
										<span class='passTableSpan' id='ModAftSaveBtnPassTableSpan${passTableStatus.index}' style='display:none;'>			
											<img src='./resources/ne_img/btn/btn_save.gif' onclick="javascript:passTableUpdate(${passTableStatus.index},${passTableVo.serialNo})" style='cursor:pointer;'/>
											<br/><img src='./resources/ne_img/btn/btn_close.gif' onclick="javascript:passTableModifyClose(${passTableStatus.index})" style='cursor:pointer;margin-top:5px;'/>
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
				<input type="hidden" id="dtlChkSize" value="${print_1_detail.size()}"/><!-- 이벤트 발생용 구분값 -->
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<colgroup>
						<col width="520"></col>
						<col width="120"></col>
					</colgroup>
					<tr>
						<td height="25">
							<p class="p2">
								<b>6. 상세 확인사항
									<span style="font-size:12px;color:RED;">
										(상세 설명이 필요한 경우 해당되는 사항만 선택하여 기재)
									</span>
								</b>
							</p>
						</td>
						<td align="right">
							<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id="dtlChkAddBtn" onclick="javascript:dtlChkAddView();" style="float:right; cursor:pointer;" />	
						</td>
					</tr>
				</table>
				
				<table cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<colgroup>
						<col width="520"></col>
						<col width="120"></col>
					</colgroup>
					
<!-- 					티바디 만들고 추가버튼 이벤트 -->
					<tbody id="dtlChkTobody">
						<tr class="td" bgcolor="#ECECEC">
							<td style="font-size:16px;font-weight: bold;padding:10px;">
								직업(직무) 확인
								<span style="font-size:12px;color:RED;">
									ex) 피보험자, 회사 등 관계인, 근로복지공단 등 구분
								</span>
	 						</td>
	 						<td align="right" style="padding-right: 10px;">
								<input type="radio" name="jobChkFlag" value="1" onclick="fnRadioFlag(this,'job')"> 사용 
								<input type="radio" name="jobChkFlag" value="0" onclick="fnRadioFlag(this,'job')"> 미사용
	 						</td>
						</tr>
						
						<tr id="jobDtlChkTr">
							<td class="td" colspan="2" style="padding: 0px;">
								<table cellpadding="0" cellspacing="0" >
									<colgroup>
										<col width="100"></col>
										<col width="490"></col>
										<col width='50'></col>
									</colgroup>
															
									<tr>
										<td colspan="2" style="padding: 5px;">
											<span id="jobViewSpan"> 
												<span class="dtlSpan" id="jobSubSpan">${detailMap.jobContentSub}</span>&nbsp;확인결과, 아래와 같이 확인됨.<br/>
												<span class="dtlSpan" id="jobDtlSpan">${detailMap.jobContent}</span>
											</span>
											
											<span id="jobInputSpan" style="display:none;">
												<c:forEach items="${dtlJobList}" var="jobList" varStatus="jobListStatus">
													<input type="button" class="dtlBtn" id="jobDtlBtn" value="${jobList.col_val}" onclick="dtlAddSubTxt('job',this)" />
												</c:forEach>
												<br/>
												<input type="text" class="dtlTxt" id="jobSubDtlTxt" value="${detailMap.jobContentSub}" style="width:380px;"/>
												확인결과, 아래와 같이 확인됨.
												<textarea class="dtlTxtArea" id="jobDtlTxtArea" style="width:575px;"
														  placeholder=""
														  onfocus="javascript:fnAutoSize(this.scrollHeight,this);" 
												   	 	  onKeyUP="javascript:fnAutoSize(this.scrollHeight,this);"
												 		  onKeyDown="javascript:fnAutoSize(this.scrollHeight,this);">${detailMap.jobContent}</textarea>
											</span>
										</td>
										
										<td align="center">
											<img id="jobModViewBtn" src="./resources/ls_img/btn_edite.gif" onclick="javascript:dtlChkModifyView('job');" style='cursor:pointer;vertical-align: middle;'/>
											<img id="jobSaveBtn" src="./resources/ne_img/btn/btn_save.gif" onclick="javascript:dtlChkInsert('job');" style='cursor:pointer;vertical-align: middle;display:none;'/>
											<img src='./resources/ne_img/btn/btn_close.gif' id="jobSaveCloseBtn" onclick="javascript:dtlChkClose('job')" style='cursor:pointer;margin-top:1px;display:none;'/>
										</td>
									</tr>
								</table>							
							</td>
						</tr>
						
						<tr><td>&nbsp;</td></tr><!-- 행간 조절 -->
						
						<tr class="td" bgcolor="#ECECEC">
							<td style="font-size:16px;font-weight: bold;padding:10px;">
								사고경위 확인
								<span style="font-size:12px;color:RED;">
									ex) 피보험자, 목격자, 근로복지공단, 경찰서 등 구분
								</span>
	 						</td>
	 						<td align="right" style="padding-right: 10px;">
								<input type="radio" name="accidentChkFlag" value="1" onclick="fnRadioFlag(this,'accident')"> 사용 
								<input type="radio" name="accidentChkFlag" value="0" onclick="fnRadioFlag(this,'accident')"> 미사용
	 						</td>
						</tr>			
						
						<tr id="accidentDtlChkTr">
							<td class="td" colspan="2" style="padding: 0px;">
								<table cellpadding="0" cellspacing="0" >
									<colgroup>
										<col width="100"></col>
										<col width="490"></col>
										<col width='50'></col>
									</colgroup>
															
									<tr>
										<td colspan="2" style="padding: 5px;">
											<span id="accidentViewSpan"> 
												<span class="dtlSpan" id="accidentSubSpan">${detailMap.accidentContentSub}</span>&nbsp;확인결과,
												<span class="dtlSpan" id="accidentDtlSpan">${detailMap.accidentContent}</span>
											</span>
											
											<span id="accidentInputSpan" style="display:none;">
												<c:forEach items="${dtlAccidentList}" var="accidentList" varStatus="accidentListStatus">
													<input type="button" class="dtlBtn" id="accidentDtlBtn" value="${accidentList.col_val}" onclick="dtlAddSubTxt('accident',this)" />
												</c:forEach>
												<br/>
												<input type="text" class="dtlTxt" id="accidentSubDtlTxt" value="${detailMap.accidentContentSub}" style="width:380px;"/> 확인결과,
												<textarea class="dtlTxtArea" id="accidentDtlTxtArea" style="width:575px;"
														  placeholder=""
														  onfocus="javascript:fnAutoSize(this.scrollHeight,this);" 
												   	 	  onKeyUP="javascript:fnAutoSize(this.scrollHeight,this);"
												 		  onKeyDown="javascript:fnAutoSize(this.scrollHeight,this);">${detailMap.accidentContent}</textarea>
											</span>
										</td>
										
										<td align="center">
											<img id="accidentModViewBtn" src="./resources/ls_img/btn_edite.gif" onclick="javascript:dtlChkModifyView('accident');" style='cursor:pointer;vertical-align: middle;'/>
											<img id="accidentSaveBtn" src="./resources/ne_img/btn/btn_save.gif" onclick="javascript:dtlChkInsert('accident');" style='cursor:pointer;vertical-align: middle;display:none;'/>
											<img src='./resources/ne_img/btn/btn_close.gif' id="accidentSaveCloseBtn" onclick="javascript:dtlChkClose('accident')" style='cursor:pointer;margin-top:1px;display:none;'/>
										</td>
									</tr>
								</table>							
							</td>
						</tr>	
									
						<tr><td>&nbsp;</td></tr><!-- 행간 조절 -->
	
						<tr class="td" bgcolor="#ECECEC">
							<td style="font-size:16px;font-weight: bold;padding:10px;">
								병원 확인
								<span style="font-size:12px;color:RED; letter-spacing: -1px;">
									ex) 장해소견, 진단소견, 의학적 인과관계 등 설명이 필요한 경우에 한하여 작성
								</span>
	 						</td>
	 						<td align="right" style="padding-right: 10px;">
								<input type="radio" name="hospitalChkFlag" value="1" onclick="fnRadioFlag(this,'hospital')"> 사용 
								<input type="radio" name="hospitalChkFlag" value="0" onclick="fnRadioFlag(this,'hospital')"> 미사용
	 						</td>
						</tr>
						
						<tr id="hospitalDtlChkTr">
							<td class="td" colspan="2" style="padding: 0px;">
								<table cellpadding="0" cellspacing="0" >
									<colgroup>
										<col width="100"></col>
										<col width="490"></col>
										<col width='50'></col>
									</colgroup>
															
									<tr>
										<td colspan="2" style="padding: 5px;">
											<span id="hospitalViewSpan"> 
												<span class="dtlSpan" id="hospitalDtlSpan">${detailMap.hospitalContent}</span>
											</span>
											
											<span id="hospitalInputSpan" style="display:none;">
												<textarea class="dtlTxtArea" id="hospitalDtlTxtArea" style="width:575px;"
														  placeholder=""
														  onfocus="javascript:fnAutoSize(this.scrollHeight,this);" 
												   	 	  onKeyUP="javascript:fnAutoSize(this.scrollHeight,this);"
												 		  onKeyDown="javascript:fnAutoSize(this.scrollHeight,this);">${detailMap.hospitalContent}</textarea>
											</span>
										</td>
										
										<td align="center">
											<img id="hospitalModViewBtn" src="./resources/ls_img/btn_edite.gif" onclick="javascript:dtlChkModifyView('hospital');" style='cursor:pointer;vertical-align: middle;'/>
											<img id="hospitalSaveBtn" src="./resources/ne_img/btn/btn_save.gif" onclick="javascript:dtlChkInsert('hospital');" style='cursor:pointer;vertical-align: middle;display:none;'/>
											<img src='./resources/ne_img/btn/btn_close.gif' id="hospitalSaveCloseBtn" onclick="javascript:dtlChkClose('hospital')" style='cursor:pointer;margin-top:1px;display:none;'/>
										</td>
									</tr>
								</table>							
							</td>
						</tr>	
						
						<tr><td>&nbsp;</td></tr><!-- 행간 조절 -->
						
						<tr class="td" bgcolor="#ECECEC">
							<td style="font-size:16px;font-weight: bold;padding:10px;">
								제 3 병원 의료자문 확인
								<span style="font-size:12px;color:RED; letter-spacing: -1px;">
									
								</span>
	 						</td>
	 						<td align="right" style="padding-right: 10px;">
								<input type="radio" name="adviceChkFlag" value="1" onclick="fnRadioFlag(this,'advice')"> 사용 
								<input type="radio" name="adviceChkFlag" value="0" onclick="fnRadioFlag(this,'advice')"> 미사용
	 						</td>
						</tr>
						
						<tr id="adviceDtlChkTr">
							<td class="td" colspan="2" style="padding: 0px;">
								<table cellpadding="0" cellspacing="0" >
									<colgroup>
										<col width="100"></col>
										<col width="490"></col>
										<col width='50'></col>
									</colgroup>
															
									<tr>
										<td colspan="2" style="padding: 5px;">
											<span id="adviceViewSpan"> 
												<span class="dtlSpan" id="adviceDtlSpan">${detailMap.adviceContent}</span>
											</span>
											
											<span id="adviceInputSpan" style="display:none;">
												<textarea class="dtlTxtArea" id="adviceDtlTxtArea" style="width:575px;"
														  placeholder=""
														  onfocus="javascript:fnAutoSize(this.scrollHeight,this);" 
												   	 	  onKeyUP="javascript:fnAutoSize(this.scrollHeight,this);"
												 		  onKeyDown="javascript:fnAutoSize(this.scrollHeight,this);">${detailMap.adviceContent}</textarea>
											</span>
										</td>
										
										<td align="center">
											<img id="adviceModViewBtn" src="./resources/ls_img/btn_edite.gif" onclick="javascript:dtlChkModifyView('advice');" style='cursor:pointer;vertical-align: middle;'/>
											<img id="adviceSaveBtn" src="./resources/ne_img/btn/btn_save.gif" onclick="javascript:dtlChkInsert('advice');" style='cursor:pointer;vertical-align: middle;display:none;'/>
											<img src='./resources/ne_img/btn/btn_close.gif' id="adviceSaveCloseBtn" onclick="javascript:dtlChkClose('advice')" style='cursor:pointer;margin-top:1px;display:none;'/>
										</td>
									</tr>
								</table>							
							</td>
						</tr>						
					</tbody>
					
					<tbody id="etcDtlChkTbody">
						<c:forEach items="${print_1_detail}" var="etcDtlChk" varStatus="etcDtlChkStatus">
							<c:if test="${etcDtlChk.detailGubun eq 99}">
								<tr id='${etcDtlChkStatus.index}DtlChkTr1'><td>&nbsp;</td></tr>
						  				
								<tr id='${etcDtlChkStatus.index}DtlChkTr2' class='td' bgcolor='#ECECEC'>
									<td style='font-size:16px;font-weight:bold;padding:10px;' colspan='2'>
										<span id="${etcDtlChkStatus.index}DtlTitleSpan">
											${etcDtlChk.detailTitle}			
										</span>
										<input type='text' class='dtlTitleTxt' id='${etcDtlChkStatus.index}DtlTitleTxt' style="display:none;" value="${etcDtlChk.detailTitle}"/>
									</td>
								</tr>
								
								<tr id='${etcDtlChkStatus.index}DtlChkTr3'>
									<td class='td' colspan='2' style='padding: 0px;'>
										<table cellpadding='0' cellspacing='0' >
											<colgroup>
												<col width='100'></col>
												<col width='490'></col>
												<col width='50'></col>
											</colgroup>
					
											<tr>
												<td colspan='2' style='padding: 5px;'>
													<span id="${etcDtlChkStatus.index}ViewSpan">${etcDtlChk.detailContent}</span>
													<span id='${etcDtlChkStatus.index}InputSpan' style="display:none;">
														<textarea class='dtlTxtArea' id='${etcDtlChkStatus.index}DtlTxtArea' style='width:575px;'
														  		  onfocus='javascript:fnAutoSize(this.scrollHeight,this);' 
																  onKeyUP='javascript:fnAutoSize(this.scrollHeight,this);'
																  onKeyDown='javascript:fnAutoSize(this.scrollHeight,this);'>${etcDtlChk.detailContent}</textarea>
													</span>
												</td>
								
												<td align='center'>
												
													<p align="center">
														<span class='etcDtlChkSpan' id='ModBtnEtcDtlChkSpan${etcDtlChkStatus.index}' >
															<img src='./resources/ls_img/btn_edit_s.gif' onclick='javascript:etcDtlChkModifyView(${etcDtlChkStatus.index});' style='cursor:pointer;'/>
															<img src='./resources/ls_img/btn_del_s.gif' onclick="javascript:etcDtlChkDelete(${etcDtlChk.serialNo})" style='cursor:pointer;'/>
														</span>
														<span class='etcDtlChkSpan' id='ModAftSaveBtnEtcDtlChkSpan${etcDtlChkStatus.index}' style='display:none;'>			
															<img src='./resources/ne_img/btn/btn_save.gif' onclick="javascript:etcDtlChkUpdate(${etcDtlChkStatus.index},${etcDtlChk.serialNo})" style='cursor:pointer;'/>
															<br/><img src='./resources/ne_img/btn/btn_close.gif' onclick="javascript:etcDtlChkModifyClose(${etcDtlChkStatus.index})" style='cursor:pointer;margin-top:5px;'/>
														</span>
													</p>
													
												</td>
								
											</tr>
										</table>
									</td>
								</tr>
							</c:if>
						</c:forEach>					
					</tbody>
					
				</table>
				<p id="dtlChkFocus">&nbsp;&nbsp;&nbsp;</p>
				
				
				<p>&nbsp;</p>
				<p align="center" style="font-size:14px;;font-family:돋움;">
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
							<p style="line-height:200%;" align="center"><font size="5"><b>사 고 처 리 과 정 표</b></font></p>
						</td>
					</tr>
				</table>
				<p>&nbsp;</p>
				<p style="font-size:large;"><b>1. 일반사항</b></p>
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
						<td class="td">
							<p align="center"><b>${suimVO.insurance_nm}</b></p>
						</td>

						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>피보험자</b></p>
						</td>
						<td class="td">
							<p align="center"><b>${suimVO.beneficiary_nm} 님</b></p>
						</td>
					</tr>
					
					<tr>
						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>사고일시</b></p>
						</td>
						<td class="td">
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
						<td class="td">
							<p align="center"><b>${suimVO.reg_date}</b></p>
						</td>
						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>조사자</b></p>
						</td>
						<td class="td">
							<p align="center"><b>${mbrVoForBody.user_name}</b></p>
						</td>
					</tr>
				</table>
				
				<p>&nbsp;</p>

				<input type="hidden" id="printCtrlSize" value="${print_1_ctrl.size()}"/><!-- 이벤트 발생용 구분값 -->
				<span id="printCtrlOutSpan">
				<!-- 사고처리과정표 - 처리과정 -->
					<c:choose>
						<c:when test="${suimVO.ptnr_id == 9}">
							<!-- 보험사(롯데) 요청사항, 지연일수 추가 by.lds -->
							<c:import url="../rpt_in/suim_rpt_bsc_print_1001_printCtrlLotte.jsp"></c:import>
						</c:when>
						
						<c:otherwise>
							<p style="font-size:large;">
								<b>2. 처리과정</b>
									<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id="printCtrlAddBtn" onclick="javascript:printCtrlAddView();" style="float:right; cursor:pointer;" />
							</p>
			
							<table cellSpacing=0 cellPadding="0" width="648" align="center" bordercolordark="white" bordercolorlight="#999999">
								<colgroup>
									<col width="150"/>
									<col width="220"/>
									<col width="220"/>
									<col width="50"/>
								</colgroup>
								<tr>
									<td bgcolor="#ECECEC" class="td" width="208">
										<p align="center"><b>일 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자</b></td>
									<td bgcolor="#ECECEC" class="td" width="208">
										<p align="center"><b>항 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</b></td>
									<td bgcolor="#ECECEC" class="td" width="220">
										<p align="center"><b>처 &nbsp;리 &nbsp;내 &nbsp;용</b></p>
									</td>
									<td bgcolor="#ECECEC" class="td" width="220">
										<p align="center"><b>-</b></p>
									</td>
								</tr>
								<tbody id="printCtrlTbody">
									<c:forEach items="${print_1_ctrl}" var="printCtrlVo" varStatus="printCtrlStatus">
										<tr id='printCtrlTr${printCtrlStatus.index}'>
											<td class='td'>
												<p align='center'>
													<span class="printCtrlSpan" id="printCtrlDateSpan${printCtrlStatus.index}">${printCtrlVo.controlDate}</span>
													<span class="printCtrlInputSpan" id="printCtrlDateInputSpan${printCtrlStatus.index}" style="display:none;">
														<input type='text' class='printCtrlTxt' id='printCtrlDateTxt${printCtrlStatus.index}' maxlength='10' value='${printCtrlVo.controlDate}' style='width:90px; font-size:15px;'/>
													</span>
													
												</p>
											</td>
											<td class='td'>
												<p align='center'>
													<span class="printCtrlSpan" id="printCtrlSubjectSpan${printCtrlStatus.index}">${printCtrlVo.controlSubject}</span>
													<span class="printCtrlInputSpan" id="printCtrlSubjectInputSpan${printCtrlStatus.index}" style="display:none;">
					  									<select id='printCtrlSubjectSelect${printCtrlStatus.index}' onchange='javascript:fnSelectPick(this,1,${printCtrlStatus.index});' style='width:180px;' >
					  									</select>
														<input type='text' class='printCtrlTxt' id='printCtrlSubjectTxt${printCtrlStatus.index}' maxlength='10' value='${printCtrlVo.controlSubject}' style='width:180px;display:none;' />								
													</span>
												</p>
											</td>
										
											<td class='td'>
												<p align='center'>
													<span class="printCtrlSpan" id="printCtrlMemoSpan${printCtrlStatus.index}" >${printCtrlVo.controlMemo}</span>
													<span class="printCtrlInputSpan" id="printCtrlMemoInputSpan${printCtrlStatus.index}" style="display:none;">
					  									<select id='printCtrlMemoSelect${printCtrlStatus.index}' onchange='javascript:fnSelectPick(this,2,${printCtrlStatus.index});' style='width:180px;' >
					  									</select>				
														<input class='printCtrlTxt' type='text' id='printCtrlMemoTxt${printCtrlStatus.index}' value='${printCtrlVo.controlMemo}' style='width:180px;display:none;' />
													</span>
												</p>		
											</td>						
										
											<td class="td">
												<p align="center">
													<span class='printCtrlSpan' id='ModBtnPrintCtrlSpan${printCtrlStatus.index}' >
														<img src='./resources/ls_img/btn_edit_s.gif' onclick='javascript:printCtrlModifyView(${printCtrlStatus.index},"${printCtrlVo.controlSubject}","${printCtrlVo.controlMemo}");' style='cursor:pointer;'/>
														<img src='./resources/ls_img/btn_del_s.gif' onclick="javascript:printCtrlDelete(${printCtrlVo.serialNo},'1001')" style='cursor:pointer;'/>
													</span>
													<span class='printCtrlSpan' id='ModAftSaveBtnPrintCtrlSpan${printCtrlStatus.index}' style='display:none;'>			
														<img src='./resources/ne_img/btn/btn_save.gif' onclick="javascript:printCtrlUpdate(${printCtrlStatus.index},${printCtrlVo.serialNo},'1001')" style='cursor:pointer;'/>
														<br/><img src='./resources/ne_img/btn/btn_close.gif' onclick="javascript:printCtrlModifyClose(${printCtrlStatus.index})" style='cursor:pointer;margin-top:5px;'/>
													</span>
												</p>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</c:otherwise>
					</c:choose>
				</span>
				<p>&nbsp;</p>
				
				<!-- 사고처리과정표 - 첨부서류 -->
				<input type="hidden" id="SagoDocSize" value="${print1_8.size()}"/><!-- 이벤트 발생용 구분값 -->
				<p style="font-size:large;">
					<b>
						3. 첨부서류 &nbsp;&nbsp;
					</b>
					<span id="sagoDocFlagSpan" style="font-size:small;">
						<input type="radio" name="sagoDocFlag" value="1" onclick="fnRadioFlag(this,'sagoDoc')" /> 사용
						<input type="radio" name="sagoDocFlag" value="0" onclick="fnRadioFlag(this,'sagoDoc')" /> 미사용
					</span>
					<!-- 추가버튼 
					<img src="./resources/ls_img/ls_body/btn_add.gif" title="추가" id = "SagoDocAddBtn" style="float:right; cursor:pointer;" />-->
				</p>
				
				<!-- 첨부서류 추가 버튼  -->
				<table class="sagoDocTable" cellSpacing="0" cellPadding="0" width="648" align="center" bordercolordark="white" bordercolorlight="#999999" style="margin-bottom:5px;" >
					<colgroup>
						<col width="128"></col>
						<col width="128"></col>
						<col width="128"></col>
						<col width="128"></col>
						<col width="128"></col>
					</colgroup>
					<c:forEach var="DocList" items="${sagoDocKindList}" varStatus="DocListStatus">
						<c:if test="${DocListStatus.first or DocListStatus.count % 5 == 1}">
							<tr>
						</c:if>
							<td >
								<p align="center">
									<input type="button" class="sagoDocAddBtn" id="sagoDocAddBtn${DocList.col_cd}" onclick="javascript:sagoDocAddView('${DocList.col_cd}','${DocList.col_val}');" id="sagoDocBtn${DocList.col_cd}" code="${DocList.col_cd}" value="${DocList.col_val}" style="padding-left:2px;padding-right:2px;width:124px;"/>
									<!-- 클래스로 같은 이벤트, id로 분기 처리하여 비고값 설정. -->
								</p>
							</td>
						<c:if test="${DocListStatus.count % 5  == 0}">
							</tr>
						</c:if>							
					</c:forEach>
				</table>
				
				<table class="sagoDocTable" cellpadding="0" cellspacing="0" bordercolordark="white" bordercolorlight="#CCCCCC" align="center" width="640">
					<colgroup>
						<col width="50"></col>
						<col width="240"></col>
						<col width="50"></col>
						<col width="250"></col>
						<col width="50"></col>
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
						<td bgcolor="#ECECEC" class="td">
							<p align="center"><b>-</b></p>
						</td>
					</tr>
					<tbody id="sagoDocTbody">
						<c:forEach items="${print1_8}" var="print1_8" varStatus="print1_8Status">
							<tr id="sagoDocTr${print1_8Status.index}">
								<td class='td'>
									<p align='center'>
										<span class='sagoDocSpan' id='sagoDocOrderSpan${print1_8Status.index}'>${print1_8Status.count}</span>
<%-- 									<input class='sagoTxt' type='text' id='sagoOrderTxt${print1_8Status}' value='${print1_8Status.count}' style='width:29px;'/> --%>
									</p>
								</td>
								
								<td class='td'>
									<p>
										<span class='sagoDocSpan' id='sagoDocNmSpan${print1_8Status.index}'>${print1_8.attachName}</span>
										<input class='sagoDocTxt' type='text' id='sagoDocNmTxt${print1_8Status.index}' value='${print1_8.attachName}' style='width:219px;display:none;' />
									</p>
								</td>
								
								<td class='td'>
									<p align='center'>
										<span class='sagoDocSpan' id='sagoDocCntSpan${print1_8Status.index}'>${print1_8.attachCopy}</span>
										<input class='sagoDocTxt' type='text' id='sagoDocCntTxt${print1_8Status.index}' value='${print1_8.attachCopy}' style='width:29px;display:none;'/>
									</p>
								</td>
								
								<td class='td'>
									<p>
										<span class='sagoDocSpan' id='sagoDocNoteSpan${print1_8Status.index}'>${print1_8.attachEtcMemo}</span>
										<span class='sagoDocInputSpan' id='sagoDocNoteInputSpan${print1_8Status.index}' style="display:none;">
		  									<select id='sagoDocNoteSelect${print1_8Status.index}' onchange='javascript:fnSelectPick(this,3,${print1_8Status.index});' style='width:229px;' >
		  									</select>	
											<input class='sagoDocTxt' type='text' id='sagoDocNoteTxt${print1_8Status.index}' value='${print1_8.attachEtcMemo}' style='width:229px;display:none;'/>
										</span>
									</p>
								</td>
								
								<td class='td'>
									<p align='center'>
										<span class='sagoDocSpan' id='ModBtnSagoDocSpan${print1_8Status.index}'>
											<img src='./resources/ls_img/btn_edit_s.gif' class='SagoDocModBtn' onclick="sagoDocModifyView('${print1_8Status.index}')"   id='SagoDocModViewBtn${print1_8Status.index}' serialNo='${print1_8.serialNo}' style='cursor:pointer;'/>
											<img src='./resources/ls_img/btn_del_s.gif' class='SagoDocDelBtn' onclick="sagoDocDelete('${print1_8.serialNo}')" id='SagoDocDelBtn${print1_8Status.index}' index='${print1_8Status.count}' serialNo='${print1_8.serialNo}' style='cursor:pointer;'/>
										</span>
							
										<span class='sagoDocSpan' id='ModAftSaveBtnSagoDocSpan${print1_8Status.index}' style='display:none;'>
											<img src='./resources/ne_img/btn/btn_save.gif' class='SagoModSaveBtn' onclick="sagoDocUpdate('${print1_8Status.index}','${print1_8.serialNo}')" id='SagoDocModSaveBtn${print1_8Status.index}'style='cursor:pointer;'/>
											<br/><img src='./resources/ne_img/btn/btn_close.gif' class='SagoModCloseBtn' onclick="sagoDocModifyClose('${print1_8Status.index}')" id='SagoDocModCloseBtn${print1_8Status.index}' style='cursor:pointer;margin-top:5px;'/>
										</span>
									</p>
								</td>
							<tr>
						</c:forEach>
					</tbody>
				</table>
			</td>
		</tr>
	</table>
	
	<p id="sagoFocus">&nbsp;&nbsp;&nbsp;</p>
    <c:if test="${suimVO.ptnr_id == 9}">
    <div class="reportWrap">
        <div class="reportContent">
            <!-- 별첨 병의원 탐문기록지 -->
            <div class="text-center" style="font-size: 24px; padding: 15px 0px; font-family: 돋움; color: #000; margin-top:20px;">
                <b>&lt;별첨:병.의원 탐문기록지&gt;</b>
            </div>
            <div class="text-right" style="margin-bottom: 5px;">
                <a href="#noloc" id="btn_hospital_question_add" onclick="fnHospitalQuestionAdd();"><img src="./resources/ls_img/ls_body/btn_add.gif"/></a>
            </div>
            <script type="text/javascript">
                function fnHospitalQuestionAdd(){
                    $("#btn_hospital_question_add").hide();
                    $("#tr_hospital_question_add").show();
                }

                function fnHospitalQuestionCancel(){
                    $("#btn_hospital_question_add").show();
                    $("#tr_hospital_question_add").hide();
                }

                function fnHospitalQuestionEdit(idx){
                    $("#tr_hospital_question_view" + idx).hide();
                    $("#tr_hospital_question_edit" + idx).show();
                }

                function fnHospitalQuestionClose(idx){
                    $("#tr_hospital_question_view" + idx).show();
                    $("#tr_hospital_question_edit" + idx).hide();
                }

                function fnHospitalQuestionSave(idx, cmd){

                    if($("#hq_hspt_name" + idx).val() == ""){
                        alert("병의원명을 입력해 주세요.");
                        $("#hq_hspt_name" + idx).focus();
                        return;
                    }
                    if($("#hq_hspt_address" + idx).val() == ""){
                        alert("주소를 입력해 주세요.");
                        $("#hq_hspt_address" + idx).focus();
                        return;
                    }
                    if($("#hq_hspt_tel" + idx).val() == ""){
                        alert("전화번호를 입력해 주세요.");
                        $("#hq_hspt_tel" + idx).focus();
                        return;
                    }
                    if($("#hq_hspt_confirm" + idx).val() == ""){
                        alert("확인결과를 입력해 주세요.");
                        $("#hq_hspt_confirm" + idx).focus();
                        return;
                    }

                    fnHospitalQuestion(idx, cmd);
                }

                function fnHospitalQuestionDelete(idx){
                    if(confirm("삭제하시겠습니까?")){
                        fnHospitalQuestion(idx, 'D');
                    }
                }

                function fnHospitalQuestion(idx, cmd){
                    var param = {};
                    param.suim_rpt_no               = $("#suimRptNo").val();
                    param.rpt_print_no              = $("#rptPrintNo").val();
                    param.cmd                       = cmd;
                    if (cmd == 'U' || cmd == 'D' ){
                        param.serial_no             = $("#hq_serial_no" + idx).val();
                    }

                    param.hspt_name                 = $("#hq_hspt_name" + idx).val();
                    param.hspt_address              = $("#hq_hspt_address" + idx).val();
                    param.hspt_tel                  = $("#hq_hspt_tel" + idx).val();
                    param.hspt_confirm              = $("#hq_hspt_confirm" + idx).val();

                    var url = "./report_hospital_question";

                    $.ajax({
                        type: "POST",
                        url: url,
                        data: param,
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        dataType: "html",
                        timeout: 20000,
                        success: function(data){
                            $("#div_hospital_question").html(data);
                        },
                        error: function(xhr, status, error){
                            if(xhr.status == "901"){
                                fnWinClose();
                            }else{
                                alert("네트웍 상태가 불안정합니다. 잠시후 다시 시도해 주십시요.");
                            }
                        },
                        beforeSend : function(xmlHttpRequest){
                            xmlHttpRequest.setRequestHeader("AJAX", "true");
                        }
                    });


                }

            </script>
            <div id="div_hospital_question">
                <table>
                    <colgroup>
                        <col width="11%">
                        <col width="20%">
                        <col width="20%">
                        <col width="20%">
                        <col width="20%">
                        <col width="9%">
                    </colgroup>
                    <tr>
                        <th>번호</th>
                        <th>병.의원명</th>
                        <th>소재지역</th>
                        <th>연락처</th>
                        <th>확인결과</th>
                        <th>-</th>
                    </tr>
                    <c:forEach  var="item" items="${reportHospitalQuestionList}" varStatus="status">
                        <tr id="tr_hospital_question_view${status.index}">
                            <td style="text-align: center">${status.count}</td>
                            <td><c:out value="${item.hsptName}"/></td>
                            <td><c:out value="${item.hsptAddress}"/></td>
                            <td><c:out value="${item.hsptTel}"/></td>
                            <td><c:out value="${item.hsptConfirm}"/></td>
                            <td style="text-align: center">
                                <a href="#noloc" onclick="fnHospitalQuestionEdit('${status.index}');"><img src='./resources/ls_img/btn_edit_s.gif'></a>
                                <a href="#noloc" onclick="fnHospitalQuestionDelete('${status.index}');"><img src='./resources/ls_img/btn_del_s.gif'></a>
                            </td>
                        </tr>
                        <tr id="tr_hospital_question_edit${status.index}" style="display: none;">
                            <td style="text-align: center">-</td>
                            <td>
                                <input type="hidden" id="hq_serial_no${status.index}" value="${item.serialNo}">
                                <input type="text" id="hq_hspt_name${status.index}" value="${item.hsptName}" maxlength="80">
                            </td>
                            <td>
                                <input type="text" id="hq_hspt_address${status.index}" value="${item.hsptAddress}" maxlength="150">
                            </td>
                            <td>
                                <input type="text" id="hq_hspt_tel${status.index}" value="${item.hsptTel}" maxlength="40">
                            </td>
                            <td>
                                <input type="text" id="hq_hspt_confirm${status.index}" value="${item.hsptConfirm}" maxlength="250">
                            </td>
                            <td style="text-align: center">
                                <a href="#noloc" onclick="fnHospitalQuestionSave('${status.index}','U');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                                <a href="#noloc" onclick="fnHospitalQuestionClose('${status.index}');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                            </td>
                        </tr>
                    </c:forEach>
                    <tr id="tr_hospital_question_add" style="display: none;">
                        <td style="text-align: center">-</td>
                        <td>
                            <input type="text" id="hq_hspt_name" value="" maxlength="80">
                        </td>
                        <td>
                            <input type="text" id="hq_hspt_address" value="" maxlength="150">
                        </td>
                        <td>
                            <input type="text" id="hq_hspt_tel" value="" maxlength="40">
                        </td>
                        <td>
                            <input type="text" id="hq_hspt_confirm" value="" maxlength="250">
                        </td>
                        <td style="text-align: center">
                            <a href="#noloc" onclick="fnHospitalQuestionSave('','C');"><img src='./resources/ne_img/btn/btn_save.gif'></a>
                            <a href="#noloc" onclick="fnHospitalQuestionCancel('');"><img src='./resources/ne_img/btn/btn_close.gif' style="margin-top: 5px;"></a>
                        </td>
                    </tr>
                </table>
            </div>

            <!--// 별첨 병의원 탐문기록지 -->
        </div>
    </div>
    </c:if>
	
</body>
