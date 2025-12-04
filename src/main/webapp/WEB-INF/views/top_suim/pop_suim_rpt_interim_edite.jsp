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
	<title>중간 보고 수정</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<script src="./resources/ne_js/ne_number.js"></script>
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
	

	<script>
	
		$(document).ready(function(){
			
			
			$("#cancel").click(function (){
				if(confirm("작성중인 보고서를 취소하시겠습니까?")){
					window.close();
				}
			});
			
			/* 이미지 */
			if('${suimRptSiteImgListLength}' != 0){
				$("#attachedImg").css("display","block");
			}
			
			isManualInput('${suimRptSiteVo.compensationLimitFlag}','amtCompensationLimitEtcSpan');
			$("#amtCompensationLimitFlag").val('${suimRptSiteVo.compensationLimitFlag}');
			
			isManualInput('${suimRptSiteVo.selfPayFlag}','selfPayEtcAmtSpan');
			$("#selfPayFlag").val('${suimRptSiteVo.selfPayFlag}');
			
			$("#exemptionFlag").val('${suimRptSiteVo.exemptionFlag}');
			isManualInput('${suimRptSiteVo.dmgCtgr}','dmgCtgrSpan');
			$("#dmgCtgr").val('${suimRptSiteVo.dmgCtgr}');
			
			$("#editeOk").click(function (){
				
				var siteDateVal;
				
				if( ${suimListDtl.suimRptType1} == '3' || ${suimListDtl.suimRptType1} == '4'){
					if($("#siteDateFix").val()  == ''){
						alert("작성일자를 입력하세요");
						return;
					}
					siteDateVal = $("#siteDateFix").val();
				}else{
					if($("#siteDate").val()  == ''){
						alert("작성일자를 입력하세요");
						return;
					}
					siteDateVal = $("#siteDate").val() 
				}
				
				if($("#orderNo").val()  == ''){
					alert("회차를 입력하세요");
					return;
				}
				if($("#amtEstimatedDamage").val()  == ''){
					alert("추정손해액을 입력하세요");
					return;
				}
				
				if($("#amtSelfPay").val() == ''){
					$("#amtSelfPay").val('0');
				}
				
				if($("#amtCompensationLimit").val() == ''){
					$("#amtCompensationLimit").val('0');
				}
				
				var compensationUnitVal = "";
				var selfPayUnitVal = "";
				
				if($("#amtCompensationLimitSelect").val() == '0'){
					compensationUnitVal = "￦";
				}else if($("#amtCompensationLimitSelect").val() == '1'){
					compensationUnitVal = "$";
				}else{
					compensationUnitVal = $("#CompensationUnit").val()
				}
				
				if($("#selfPayLimitSelect").val() == '0'){
					selfPayUnitVal = "￦";
				}else if($("#selfPayLimitSelect").val() == '1'){
					selfPayUnitVal = "$";
				}else{
					selfPayUnitVal = $("#selfPayUnit").val()
				}
				
				$.post("./editeSiteRpt4",
						{	
							 interimFlag				:$("#interimFlag").val()  										// 현장,중간 구분
							,rptSiteNo					:$("#rptSiteNo").val()  										// 현장 시리얼 No
							,suimRptNo					:$("#suimRptNo").val()  										// 수임건No 
							,orderNo					:$("#orderNo").val()
							//,siteDate         			:$("#siteDateFix").val()  											// 작성일
							,siteDate         			:siteDateVal  											// 작성일							
							,siteChamjo         		:$("#siteChamjo").val()  										// 참조
							,accidentNo           		:$("#accNo").val() 												// 사고번호 
							,ptnrMbrPositionNm4edit		:$("#ptnrMbrJobMemo").val() 									// 파트너사 직원 직급
							,ptnrMbrNm    				:$("#ptnrMbrNm").val() 											// 파트너사 직원 이름
							,insuranceNm     			:$("#insuranceNm").val() 										// 보험종목 
							,policyNo  					:$("#policyNo").val() 											// 계약번호 
							,policyholderNm       		:$("#policyholderNm").val() 									// 계약자 이름 
							,beneficiaryNm         		:$("#beneficiaryNm").val() 										// 피보험자 이름 
							,policyholderSsn    		:$("#policyholderSsn1").val()+"-"+$("#policyholderSsn2").val()  // 계약자 주민
							,beneficiarySsn  			:$("#beneficiarySsn1").val()+"-"+$("#beneficiarySsn2").val() 	// 피보험자 주민
							,insuTerm 					:$("#insuTerm").val() 											// 보험종목
							,amtCompensationLimit  		:removeCommaFunc( $("#amtCompensationLimit").val() ) 								// 보상한도액
							,compensationLimitUnit		:compensationUnitVal
							,selfPayLimitUnit			:selfPayUnitVal
							,compensationLimitEtcAmt	:$("#amtCompensationLimitEtc").val() 							// 보상한도액 직접입력
							,compensationLimitFlag  	:$("#amtCompensationLimitFlag option:selected").val() 			// 보상한도액 분류
							,insuMortgage    			:$("#insuMortgage").val()										// 담보사항
							,selfPayFlag    			:$("#selfPayFlag option:selected").val() 						// 자기부담 분류
							,amtSelfPay					:removeCommaFunc( $("#amtSelfPay").val() ) 										// 자기부담금
							,selfPayEtcAmt	 			:$("#selfPayEtcAmtEtc").val() 									// 자기부담 분류 직접입력
							,siteZone		 			:$("#siteZone").val() 											// 주소 
							,policyholderContact 		:$("#policyholder_tel_1").val()+"-"+$("#policyholder_tel_2").val()+"-"+$("#policyholder_tel_3").val() // 계약자 연락처
							,referenceFacts 			:$("#referenceFacts").val() 									// 특이사항
							,accidentDate 				:$("#accidentDate").val() 										// 사고일
							,investigateAddr1   		:$("#siteZone1").val() 											// 사고조사지역 주소  
							,investigateAddr2			:$("#siteZone2").val() 											// 사고조사지역 세부주소 
							//,accidentFacts				:$("#accidentFacts").html() 									// 사고내용
							,accidentFacts				:$("#accidentFacts").val() 									// 사고내용
							,damagedFacts 				:$("#damagedFacts").val() 										// 피해사항 
							,exemptionFlag 				:$("#exemptionFlag option:selected").val() 						// 면 부책관련 분류
							,amtEstimatedDamage 		:removeCommaFunc( $("#amtEstimatedDamage").val() ) 								// 추정손해액
							,dmgCtgr 					:$("#dmgCtgr option:selected").val() 							// 추정손해액 분류
							,dmgCtgrEtcNm 				:$("#dmgCtgrEtcNm").val() 										// 추정손해액 분류 직접입력
							,damagedNegligence 			:$("#damagedNegligence").val() 									// 피해자 과실율
							,memoProblem 				:$("#memoProblem").html() 										// 문제점 
							,memoRemedy 				:$("#memoRemedy").html() 										// 향후 처리방안
							,memoAttach					:$("#memoAttach").val() 										// 첨부
							
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									alert("수정 되었습니다.");
                                    window.opener.location.reload();
                                    window.close();
									
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
				
			});
			
		});
		
		/* 단위 직접 입력부 보이기,안보이기 */
		function CompensationUnitInput(obj,id){
			
			if(obj == 2){
				//$("#"+id).css("display","inline-block");
				$("#"+id).show();
			}else{
				//$("#"+id).css("display","none");
				$("#"+id).hide();
			}	
			
		}
		
		/* 단위 직접 입력부 보이기,안보이기 */
		function selfPayUnitInput(obj,id){
			
			if(obj == 2){
				//$("#"+id).css("display","inline-block");
				$("#"+id).show();
			}else{
				//$("#"+id).css("display","none");
				$("#"+id).hide();
			}	
			
		}
		
		/* 금액 직접 입력부 보이기,안보이기 */
		function isManualInput(obj,id){
			
			if(obj == 9){
				$("#"+id).css("display","block");				
			}else{
				$("#"+id).css("display","none");
			}	
		}
		
	</script>
	
	<style>
	
	</style>

</head>

<body>
	<!-- header --><!--2016.01.14.rjh.수정.교체.-->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<c:choose>
					<c:when test="${suimListDtl.interimFlag == 1}">
						<font color="white"><b><span style="font-size:11pt;"> 중간 손해사정서 수정  [ ${suimListDtl.suimAcceptNo} ]</span></b></font>
					</c:when>
					<c:when test="${suimListDtl.interimFlag == 2}">
						<font color="white"><b><span style="font-size:11pt;"> 진행 경과 보고서 수정  [ ${suimListDtl.suimAcceptNo} ]</span></b></font>
					</c:when>
				</c:choose>
			</div>
		</div>
	</div>
	<!-- //header -->

	<!-- center -->
	<div id ="container">
		<div class="contetnsPop_site">
			<div class="center_cnt_site">
				<%--<div class="centercnt_bot1-4">--%>
					<div class="centercnt_bot1_5" style="width: 800px;">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on">
                                    <c:choose>
                                        <c:when test="${suimListDtl.interimFlag == 1}">
                                            <a href="#">중간 손해사정서 수정</a>
                                        </c:when>
                                        <c:when test="${suimListDtl.interimFlag == 2}">
                                            <a href="#">진행 경과 보고서 수정</a>
                                        </c:when>
                                    </c:choose>
                                </li>
								
							</ul>
						</div>

						<div class="guestcnt6" style="display:block;">

							<div class= "tableStyle7" >
							<input type="hidden" id = "suimRptNo" value ="${suimListDtl.suimRptNo}"/>
							<input type="hidden" id = "rptSiteNo" value ="${suimRptSiteVo.rptSiteNo}"/>
							<input type="hidden" id = "interimFlag" value ="${suimListDtl.interimFlag}"/>
							
								<table align="center" style = "margin-top:10px; width:100%;" >
									<colgroup>
										<col width="20%">
										<col width="30%">
										<col width="20%">
										<col width="30%">
									</colgroup>
									<tr>
										<th>Report No.</th>
										<td colspan="3">${suimListDtl.suimAcceptNo }</td>
									</tr>
									<tr>
										<th>회차</th>
										<td>
											<input type="text" id="orderNo" name="orderNo" value = "${suimRptSiteVo.orderNo }" style="width:20px; margin:left;" />&nbsp;회차
										</td>
										<th>작성일자</th>
										<td>											
											<c:choose>
											<c:when test="${suimListDtl.suimRptType1 eq 3 or suimListDtl.suimRptType1 eq 4}">
												${suimRptSiteVo.siteDate }
												<input type="hidden" id="siteDateFix" value = "${suimRptSiteVo.siteDate }"/>
											</c:when>
											<c:otherwise>
												<input type="text" id="siteDate" size="20" class="endContents" value = "${suimRptSiteVo.siteDate }"/>
											</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</table>
								
								<table align="center" style="margin-top:10px; width:100%;">
									
									<colgroup>
										<col width="20%">
										<col width="30%">
										<col width="20%">
										<col width="30%">
									</colgroup>
									<tr>
										<th>수신</th>
										<td>${suimListDtl.ptnrName}</td>
										<th>수임일시</th>
										<td>${suimListDtl.regDate}</td>
									</tr>
									<tr>
										<th>참조</th>
										<td>
											<input type="text" id= "siteChamjo" value ="${suimRptSiteVo.siteChamjo}" style="ime-mode:active;"/>
										</td>
										<th>사고번호</th>
										<td>
											<input type="text" id="accNo" value="${suimListDtl.accidentNo}" style="ime-mode:active;"/>
										</td>
									</tr>
									<tr>
										<th>보험사담당</th>
										<td>
											<c:choose>
												<c:when test="${suimListDtl.ptnrMbrNm ne '' and suimListDtl.ptnrMbrNm ne null}">
													이름 : ${suimListDtl.ptnrMbrNm}
													<c:if test="${suimListDtl.ptnrMbrPositionNm4edit ne '' and suimListDtl.ptnrMbrPositionNm4edit ne null}">
														<br/>직급 : ${suimListDtl.ptnrMbrPositionNm4edit}
													</c:if>
													
													<c:if test="${suimListDtl.ptnrMbrHp ne '' and suimListDtl.ptnrMbrHp ne null}">
														<p>☎  ${suimListDtl.ptnrMbrHp }</p>
													</c:if>
													<!-- 170131 4edit필드 사용 보류로 인한 주석처리, by LDS-->
<%-- 												이름 : <input type="text" size="10" id="ptnrMbrNm" value ="${suimListDtl.ptnrMbrNm}"/><br /> --%>
<%-- 												직급 : <input type="text" size="10" id="ptnrMbrJobMemo" value = "${suimListDtl.ptnrMbrPositionNm4edit}"/> --%>
												</c:when>
												<c:otherwise>
													보험사 담당자 미배당
												</c:otherwise>
											</c:choose>
											<!-- 소스코드 수정 최소화를 위한 변수.. -->
											<input type="hidden" size="10" id="ptnrMbrNm" value ="${suimListDtl.ptnrMbrNm}"/>
											<input type="hidden" size="10" id="ptnrMbrJobMemo" value = "${suimListDtl.ptnrMbrPositionNm4edit}"/>
											
										</td>
										<th>손사담당</th>
										<td>
											${suimListDtl.userName}
											<p>☎ ${suimListDtl.rptUserHp}</p>
										</td>
									</tr>
								</table>
								
								<table align="center" style ="margin-top:10px; width:100%;">
									<colgroup>
										<col width="15%">
										<col width="35%">
										<col width="15%">
										<col width="35%">
									</colgroup>
									<tr bgcolor="#FFF2B4">
										<td colspan="4">
											<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 계약 사항</b>
										</td>
									</tr>
									<tr>
										<th>보험종목</th>
										<td>
											<input type="text" size="31" id= "insuranceNm" value="${suimListDtl.insuranceNm}" style="ime-mode:active;"/>
										</td>
										<th>증권번호</th>
										<td>
											<input type="text" size="31" id= "policyNo" value="${suimListDtl.policyNo }" style="ime-mode:active;"/>
										</td>
									</tr>
									<tr>
										<th>계약자</th>
										<td>
											ㆍ성명 : <input type="text" size="12" id = "policyholderNm" value ="${suimListDtl.policyholderNm}" style="ime-mode:active;"/>
										</td>
										<th>피보험자</th>
										<td>
											ㆍ성명 : <input type="text" size="12" id = "beneficiaryNm" value ="${suimListDtl.beneficiaryNm}" style="ime-mode:active;"/>
										</td>
									</tr>
									<%-- <tr>
										<td>
											ㆍ등록번호 : <input type="text" size="8" id = "policyholderSsn1" value ="${policyholderSsn1}"/>-
													 <input type="text" size="8" id = "policyholderSsn2" value ="${policyholderSsn2}"/>
										</td>
										<td>
											ㆍ등록번호 : <input type="text" size="8" id = "beneficiarySsn1" value ="${beneficiarySsn1}"/>-
													 <input type="text" size="8" id = "beneficiarySsn2" value ="${beneficiarySsn2}"/>
										</td>
									</tr> --%>
									<tr>
										<th>보험기간</th>
										<td>
											<input type="text" size="30" id = "insuTerm" value ="${suimListDtl.insuTerm }"/>
										</td>
										<th>담보사항</th>
										<td>
											<input type="text" size="30" id = "insuMortgage" value = "${suimListDtl.insuMortgage }" style="ime-mode:active;"/>
										</td>
									</tr>
									<tr>
										<th>보상한도액</th>
										<td colspan="3">
											<select id="amtCompensationLimitSelect" onchange="CompensationUnitInput(this.value, 'CompensationUnitSpan');">
												<option value="0" <c:if test="${suimListDtl.compensationLimitUnit eq '￦'}"> selected="selected" </c:if>>￦</option>
												<option value="1" <c:if test="${suimListDtl.compensationLimitUnit eq '$'}"> selected="selected" </c:if>>$</option>
												<option value="2" <c:if test="${suimListDtl.compensationLimitUnit ne '￦' && suimListDtl.compensationLimitUnit ne '$'}"> selected="selected" </c:if>>직접입력</option>
											</select>
											<c:choose>
												<c:when test="${suimListDtl.compensationLimitUnit == '￦' || suimListDtl.compensationLimitUnit == '$'}">
													<span id = "CompensationUnitSpan" style="display:none;"> &nbsp;<input type="text" size="7" id="CompensationUnit" value="" maxlength="5"/></span>
												</c:when>
												<c:otherwise>
													<span id = "CompensationUnitSpan"> &nbsp;<input type="text" size="7" id="CompensationUnit" value="${suimListDtl.compensationLimitUnit}" maxlength="5"/></span>
												</c:otherwise>
											</c:choose>
											
											
											 <input type="text" size="12" id = "amtCompensationLimit"
													 VALUE="<fmt:formatNumber value="${suimListDtl.amtCompensationLimit}" pattern="###,###,##0.##"/>"
													 ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;" />
											<select id="amtCompensationLimitFlag" onchange="isManualInput(this.value,'amtCompensationLimitEtcSpan');">
												<option value="0">1사고당</option>
												<option value="1">1청구당</option>
												<option value="2">1인당</option>
												<option value="9">직접입력</option>
											</select> <br />
											<span id = "amtCompensationLimitEtcSpan" style="display:none;">ㆍ직접입력 : <input type="text" size="12" id = "amtCompensationLimitEtc" value = "${suimRptSiteVo.compensationLimitEtcAmt }"/></span>
										</td>
									</tr>
									<tr>
										
										<th>자기부담금</th>
										<td colspan="3">
											<select id="selfPayLimitSelect" onchange="selfPayUnitInput(this.value, 'selfPayUnitSpan');">
												<option value="0" <c:if test="${suimListDtl.selfPayLimitUnit eq '￦'}"> selected="selected" </c:if>>￦</option>
												<option value="1" <c:if test="${suimListDtl.selfPayLimitUnit eq '$'}"> selected="selected" </c:if>>$</option>
												<option value="2" <c:if test="${suimListDtl.selfPayLimitUnit ne '￦' && suimListDtl.selfPayLimitUnit ne '$'}"> selected="selected" </c:if>>직접입력</option>
											</select>
											<c:choose>
												<c:when test="${suimListDtl.selfPayLimitUnit == '￦' || suimListDtl.selfPayLimitUnit == '$'}">
													<span id = "selfPayUnitSpan" style="display:none;"> &nbsp;<input type="text" size="7" id="selfPayUnit" value="" maxlength="5"/></span>
												</c:when>
												<c:otherwise>
													<span id = "selfPayUnitSpan"> &nbsp;<input type="text" size="7" id="selfPayUnit" value="${suimListDtl.selfPayLimitUnit}" maxlength="5"/></span>
												</c:otherwise>
											</c:choose>
											
											<input type="text" size="12" id = "amtSelfPay"
													 VALUE="<fmt:formatNumber value="${suimListDtl.amtSelfPay}" pattern="###,###,##0.##"/>"
													 ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;" />

											<select id="selfPayFlag" onchange="isManualInput(this.value,'selfPayEtcAmtSpan');" >
												<option value="0">1사고당</option>
												<option value="1">1청구당</option>
												<option value="2">1인당</option>
												<option value="9">직접입력</option>
											</select> <br />
											<span id="selfPayEtcAmtSpan" style="display:none;">ㆍ직접입력 : <input type="text" size="12" id = "selfPayEtcAmtEtc" value = "${suimRptSiteVo.selfPayEtcAmt }"/></span>
										</td>
									</tr>
									<tr>
										<th>주소</th>
										<td colspan="3"> 
											<input type="text" size="80" id = "siteZone" value = "${suimRptSiteVo.siteZone}" style="ime-mode:active;"/>
										</td>
									</tr>
									<tr>
										<th>연락처</th>
										<td colspan="3"> 
											<input type="text" size="5" id = "policyholder_tel_1" value = "${policyholder_tel_1}"/>-
											<input type="text" size="5" id = "policyholder_tel_2" value = "${policyholder_tel_2}"/>-
											<input type="text" size="5" id = "policyholder_tel_3" value = "${policyholder_tel_3}"/>
										</td>
									</tr>
									<tr>
										<th>특이사항</th>
										<td colspan="3"> 
											<input type="text" size="80" id = "referenceFacts" value = "${suimListDtl.referenceFacts }" style="ime-mode:active;"/>
										</td>
									</tr>
								</table>
								
								<table align="center" style ="margin-top:10px; width:100%;">
									<colgroup>
										<col width="15%">
										<col width="35%">
										<col width="15%">
										<col width="35%">
									</colgroup>
									<tr bgcolor="#FFF2B4">
										<td colspan="4">
											<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 사고 사항</b>
										</td>
									</tr>
									<tr>
										<th>사고일</th>
										<td>
											<input type="text" id = "accidentDate" value = "${suimListDtl.accidentDate }" style="ime-mode:active;"/>
										</td>
										<th>사고장소</th>
										<td>
											<input type="text" size="25" id = "siteZone1" value = "${suimListDtl.investigateAddr1 }" style="ime-mode:active;"/>
											<input type="hidden" id = "siteZone2" value = "${suimListDtl.investigateAddr2}"/>
											<%-- <input type="text" size="30" id = "siteZone2" value = "${suimListDtl.investigateAddr2 }" style="ime-mode:active;"/> --%>
										</td>
									</tr>
									<tr>
										<th>사고내용</th>
										<td colspan="3"> 
											<textarea rows="3" cols="80" id = "accidentFacts" style="ime-mode:active;">${suimListDtl.accidentFacts}</textarea>
										</td>
									</tr>
									<tr>
										<th>피해사항</th>
										<td colspan="3"> 
											<input type="text" size="80" id = "damagedFacts" style="ime-mode:active;" value = "${suimListDtl.damagedFacts }"/>
										</td>
									</tr>
									<tr>
										<th>면 부책관련</th>
										<td>
											<select id="exemptionFlag"  >
												<option value="0">없음</option>
												<option value="1">부책</option>
												<option value="2">면책</option>
												<option value="3">판단보류</option>
											</select>
										</td>
										<th>추정손해액</th>
										<td>
											￦ <input type="text" size="12" id = "amtEstimatedDamage"
													 VALUE="<fmt:formatNumber value="${suimListDtl.amtEstimatedDamage}" pattern="###,###,##0.##"/>"
													 ONKEYDOWN="javascript:onlyNumberFunc2(this);" ONKEYUP="javascript:numberCommaFunc(this);"  style="ime-mode:disabled;text-align:right;" /> 원
											<select id="dmgCtgr" onchange="isManualInput(this.value,'dmgCtgrSpan');">
												<option value="0">없음</option>
												<option value="1">대인</option>
												<option value="2">대물</option>
												<option value="3">대인+대물</option>
												<option value="4">재물</option>
												<option value="9">직접입력</option>
											</select> <br />
											<span id="dmgCtgrSpan" style="display:none;">ㆍ직접입력 : <input type="text" size="12" id="dmgCtgrEtcNm" value= "${suimRptSiteVo.dmgCtgrEtcNm }"/></span>
										</td>
									</tr>
									<tr>
										<th>피해자 과실</th>
										<td colspan="3">
											<input type="text" style="ime-mode:active;" id = "damagedNegligence" style="text-align:right;" size="5" value = "${suimRptSiteVo.damagedNegligence }"  />％
										</td>
									</tr>
								</table>
								
								<!--******** 문제점 ********-->
								<table align="center" style ="margin-top:10px; width:100%;">
									<colgroup>
										<col width="20%">
										<col width="80%">
									</colgroup>

									<thead>
										<tr bgcolor="#FFF2B4">
											<td colspan="2">
												<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 문제점</b>
											</td>
										</tr>
										<tr>
											<th>작성일</th>
											<th>내용</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="prbList" items="${probList}" varStatus="probStatus">
										<c:if test="${probStatus.last}">
											<tr align="center">
												<td>${prbList.prb_date}</td>
												<td style="text-align:left;padding-left:5px;">
													${prbList.prb_memo}
													<input type="hidden" id="memoProblem" value="${prbList.prb_memo}"/>
												</td>
											</tr>
										</c:if>
										</c:forEach>
										
									</tbody>
								</table>
								<!--******** 문제점 ********-->
								
								<!--******** 향후처리방안 ********-->	
								<table align="center" style ="margin-top:10px; width:100%;">
									<colgroup>
										<col width="20%">
										<col width="80%">
									</colgroup>

									<thead>
										<tr bgcolor="#FFF2B4">
											<td colspan="2">
												<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 향후처리방안</b>
											</td>
										</tr>
										<tr>
											<th>작성일</th>
											<th>내용</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="plnList" items="${planList}" varStatus="planStatus">
										<c:if test="${planStatus.last}">
											<tr align="center">
												<td>${plnList.pln_date}</td>
												<td style="text-align:left;padding-left:5px;">
													${plnList.pln_memo}
													<input type="hidden" id="memoRemedy" value="${plnList.pln_memo}"/>
												</td>
											</tr>
										</c:if>
										</c:forEach>
										
									</tbody>
								</table>
								<!--******** 향후처리방안 ********-->	
								
								<table align="center" style ="margin-top:10px; width:100%;">
									<colgroup>
										<col width="15%">
										<col width="35%">
										<col width="15%">
										<col width="35%">
									</colgroup>
									<tr bgcolor="#FFF2B4">
										<td colspan="4">
											<b><img src="./resources/ls_img/dotte.gif" style="vertical-align:middle;" /> 파일 업로드</b>
											<b>【 첨부 설명 : <input type="text" size="65" id= "memoAttach" value = "${suimRptSiteVo.memoAttach }"/>】</b>
										</td>
									</tr>
									
									<tr>
										<th>사진 첨부</th>
										<td id = "attachSiteImg" colspan="3">
											<%@include file="../include/uploadform_siteInterimImg.jsp"%>
										</td>
									</tr>
									
									<tbody id = "attachedImg" style="display:none;">
										<c:forEach items="${suimRptSiteImgList }" var="attachImgVo">
											 <tr id = 'siteImgTr_${attachImgVo.rptSiteImgNo}'>
						        				 <td align="center">
						        				 	사진 설명 : <textarea style='margin-top: 5px;' disabled = "disabled" rows='10' cols='25' id = 'siteImgEx_${attachImgVo.rptSiteImgNo}' title='사진 설명' onfocus="this.select();">${attachImgVo.imgSubject}</textarea>
						        				 	<img src='./resources/ls_img/btn_edite.gif' id = "siteImgEditBtn_${attachImgVo.rptSiteImgNo}" onclick="siteImgSubEdit('${attachImgVo.rptSiteImgNo}');" style='cursor:pointer; margin-top:5px;'/>
						        				 	<img src='./resources/ls_img/btn_del.gif' id = 'siteImgDelBtn_${attachImgVo.rptSiteImgNo}' onclick="siteImgSubDel('${attachImgVo.rptSiteImgNo}');" style='cursor:pointer; margin-top:5px;'/>
						        				 	<img src='./resources/ls_img/btn_check_s.gif' id = 'siteImgEditOkBtn_${attachImgVo.rptSiteImgNo}' onclick="siteImgEditOk('${attachImgVo.rptSiteImgNo}');" style='cursor:pointer; margin-top:5px; display:none;'/>
						        				 </td>
						        				 <td align='center'>
						        				 	<img src='${attachImgVo.imgStream}' id ='siteImgStream_${attachImgVo.rptSiteImgNo}' width='369' height='206' style='vertical-align:middle;' />
						        				 </td>
					        				 </tr>
										</c:forEach>
									</tbody>
								</table>
								
								<p align="center" style= "margin-top:20px;">
									<img id="editeOk" src="./resources/ls_img/btn_ok.gif" alt="저장" style ="cursor:pointer" />
									<img id="cancel" src="./resources/ls_img/btn_cancel.gif" alt="취소" style ="cursor:pointer" />
								</p>
								
							</div>
						
						</div> <!-- //guestcnt5 -->
					</div><!-- //guest -->
				</div><!-- //bot1-3 -->
			</div>
		</div>
	</div>
	<!--//center -->

	<!-- footer -->
	<%--<c:import url="../top_main/top_pop_footer_site.jsp"></c:import>--%>
	<!-- //footer -->

</body>