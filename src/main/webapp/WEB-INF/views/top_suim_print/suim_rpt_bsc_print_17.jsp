<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>탑손해사정(주)</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<link rel="stylesheet" type="text/css" href="./resources/ls_css/rpt_6_style.css" />
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	
	<script>
		$(document).ready(function(){
			
			$("input:radio[name='chungguType']:radio[value='${suimRptBody17_1356891112Vo.chungguTypeCode}']").prop('checked', true);
			
			if("${suimRptBody17_1356891112Vo.chungguTypeCode}" != 0){
				$("#print17ContentsDivId").show();	
				
				if("${suimRptBody17_1356891112Vo.chungguTypeCode}" == 1){
					$("#print17_2aTable").show();
				}else if("${suimRptBody17_1356891112Vo.chungguTypeCode}" == 2){
					$("#print17_2bTable").show();
				}else if("${suimRptBody17_1356891112Vo.chungguTypeCode}" == 3){
					$("#print17_2cTable").show();
				}else if("${suimRptBody17_1356891112Vo.chungguTypeCode}" == 4){
					$("#print17_2dTable").show();
					$("#recordForPrint17DivId").show();
				}else if("${suimRptBody17_1356891112Vo.chungguTypeCode}" == 5){
					$("#print17_2eTable").show();
				}else if("${suimRptBody17_1356891112Vo.chungguTypeCode}" == 6){
					$("#print17_2fTable").show();
				}
			}
			
			/* 1. 보험계약사항 수정 취소하기 */
			$("#editeBody17_1ContentsCancelBtnId").click(function(){
				
				$(".print17_1SpanClass").css("display","inline");
				$(".print17_1InputClass").css("display","none");	
				$("#editeBody17_1ContentsCancelBtnId").css("display","none");
				$("#editeBody17_1ContentsOkBtnId").css("display","none");
				$("#rptBody17_1UdtActionBtn").css("display","inline");
				$("#print17_1ShowHideBtnId").css("display","none");
				$("#print17_1SampleImg").css("display","none");
				
			});
			
			/* 보험계약사항 수정 Ok 하기 */
			$("#editeBody17_1ContentsOkBtnId").click(function(){
				
				$.post("./editeBody17_1Ok",
						{	
							 suimRptNo			:"${suimRptBody17_1356891112Vo.suimRptNo}"
							,contractPeriod1  	:$("#contractPeriod1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')		//계약기간
							,beneficiaryDtl1  	:$("#beneficiaryDtl1").val()															//수익자
							,jobJoin1  			:$("#jobJoin1").val()																	//직업1
							,jobPresent1  		:$("#jobPresent1").val()																//현직업	
							,mortgageDtl1	  	:$("#mortgageDtl1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')			//청구담보
							,amtTotInsu1		:$("#amtTotInsu1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')			//가입금액
							,etc1				:$("#etc1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')					//비고
							,chungguType		:$("input:radio[name='chungguType']:checked").val() 									//청구구분
						},
						function(data,status){
							
							var dataStream = data.split("+");
							var chungguType = $("input:radio[name='chungguType']:checked").val();
							if(status == "success"){
								if(dataStream[0] == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									
									$(".print17_1SpanClass").css("display","inline");
									$(".print17_1InputClass").css("display","none");	
									$("#editeBody17_1ContentsCancelBtnId").css("display","none");
									$("#editeBody17_1ContentsOkBtnId").css("display","none");
									$("#rptBody17_1UdtActionBtn").css("display","inline");
									
									$("#contractPeriod1Span").html($("#contractPeriod1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#mortgageDtl1Span").html($("#mortgageDtl1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#amtTotInsu1Span").html($("#amtTotInsu1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#etc1Span").html($("#etc1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									
									$("#beneficiaryDtl1Span").html($("#beneficiaryDtl1").val());
									$("#jobJoin1Span").html($("#jobJoin1").val());
									$("#jobPresent1Span").html($("#jobPresent1").val());
									$("#chungguTypeSpan").html(dataStream[1]);
									
									$("#print17ContractTitle").html("");
									
									if(chungguType == 0){
										$("#print17ContentsDivId").hide();	
										
										$("#print17ContractTitle").html("계약자 및 피보험자 주장");
									}else{
										$("#print17ContentsDivId").show();
										
										$("#print17_2aTable").hide();
										$("#print17_2bTable").hide();
										$("#print17_2cTable").hide();
										$("#print17_2dTable").hide();
										$("#print17_2eTable").hide();
										$("#print17_2fTable").hide();
										$("#recordForPrint17DivId").hide();
										
										if(chungguType == 1){
											$("#print17_2aTable").show();											
										}else if(chungguType == 2){
											$("#print17_2bTable").show();
										}else if(chungguType == 3){
											$("#print17_2cTable").show();
										}else if(chungguType == 4){
											$("#print17_2dTable").show();
											$("#recordForPrint17DivId").show();
										}else if(chungguType == 5){
											$("#print17_2eTable").show();
										}else if(chungguType == 6){
											$("#print17_2fTable").show();
										}
										
										$("#print17ContractTitle").html("조사결과요약");
									}
									
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
			$("#rptBody17WordOut").click(function(){
				
// 				if("${suimVO.suimRptState}" != 2){
// 					alert("종결건이 아니면 인쇄할 수 없습니다.");
// 					return;
// 				}
				
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				
				var sw=1010; //띄울 창의 넓이
				var sh=740;  //띄울 창의 높이
		
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				
				window.open('suimRptBody17PrintOut?suimRptNo='+'${suimRptBody17_1356891112Vo.suimRptNo}'+'&type=word','tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});
			
			$("#rptBody17PageOut").click(function(){
				
// 				if("${suimVO.suimRptState}" != 2){
// 					alert("종결건이 아니면 인쇄할 수 없습니다.");
// 					return;
// 				} 
				
				var cw=screen.availWidth;
				var ch=screen.availHeight;
				
				var sw=700; //띄울 창의 넓이
				var sh=550;  //띄울 창의 높이
		
				var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
				var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
				
				window.open('suimRptBody17PrintOut?suimRptNo='+'${suimRptBody17_1356891112Vo.suimRptNo}'+'&type=page','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});
			
		});
		
		function rptBody17_1UdtAction(){
			
			$(".print17_1SpanClass").css("display","none");
			$(".print17_1InputClass").css("display","inline");
			$("#rptBody17_1UdtActionBtn").css("display","none");
			$("#editeBody17_1ContentsCancelBtnId").css("display","inline");
			$("#editeBody17_1ContentsOkBtnId").css("display","inline");
			
		}
	</script>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
	<table id = "rptBody6Table" align="center" cellpadding="0" cellspacing="0" width="648">
		<tr>
			<td>
				<p align="right">
					<img src="./resources/ls_img/report/btn_word.gif" id ="rptBody17WordOut" title ="워드 출력" style="cursor:pointer;" border="0">
					<img src="./resources/ls_img/report/icon_print.gif" id ="rptBody17PageOut" title ="화면 인쇄" style="cursor:pointer;" border="0">
				</p>
				<p align="center"><img src="./resources/ls_img/ls_body/print_head.jpg" width="640" height="56" border="0"></p>
				<p align="center" style="line-height:50%; margin-top:0; margin-bottom:0;">&nbsp;</p>
				<p align="center"><span style="font-size:9pt;">${tmInforForBody.team_addr}</span></p> 
				<p align="center"><span style="font-size:9pt;">전화 : ${tmInforForBody.team_interphone} &nbsp;팩스 : ${tmInforForBody.team_fax} &nbsp;이메일 : ${mbrVoForBody.email}</span></p>
				<hr size="1" width="640" noshade color="black">
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<table cellpadding="0" cellspacing="0" width="648" align="center">
					<tr>
						<th width="85" height="30" align="center">
							<p>수 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;신</p>
						</th>
						<th width="350" align="left">
							<p>: ${suimVO.ptnr_name}</p>
						</th>
						<th width="90" align="right">
							<p>Report No.</p>
						</th>
						<th width="115" align="left">
							<p>&nbsp;${suimVO.suim_accept_no}</p>
						</th>
					</tr>
					<tr>
						<th height="30" width="85" align="center">
							<p>참 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조</p>
						</th>
						<th width="350" align="left">
							<p>: ${suimVO.ptnr_dept_nm} 
							<c:if test="${suimVO.ptnr_mbr_nm ne ''}">
								(담당 : ${suimVO.ptnr_mbr_nm} 님)
							</c:if></p>
						</th>
					</tr>
					<tr>
						<th height="30" width="85" align="center">
							<p>제 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</p>
						</th>
						<th width="555" colspan="3" align="left">
							<p>: ${suimVO.insurance_nm} 
								<c:if test="${suimVO.beneficiary_nm ne ''}">
									&quot;<b>${suimVO.beneficiary_nm}</b>&quot;
								</c:if>
								 손해사정서
							 </p>
						</th>
					</tr>
					<tr>
						<th height="30" width="85" align="center">
							<p>증 권 번 호</p>
						</th>
						<th width="555" colspan="3" align="left">
							<p><b>: 제 ${suimVO.policy_no} 호</b></p>
						</th>
					</tr>
					<tr>
						<td colspan="4" height="120" width="640">
							<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							귀사의 요청에 의거하여 피보험자 <b>&quot;${suimVO.beneficiary_nm}&quot;</b> 의 
			                        보험금 청구건에 대한 사고조사를 실시하고, 그 결과를 
			                        다음과 같이 제출합니다.
							</p>	
						</td>
					</tr>
				</table>
				
				<p>&nbsp;</p>
				<div  align="right">
				<table cellpadding="0" cellspacing="0" width="640">
	                <!-- <tr>
	                    <td height="70" width="500">
	                        <p>&nbsp;</p>
	                        <p>&nbsp;</p>
	                        <p align="right">손해사정사</p>
	                    </td>
	                    <td width="65">
	                        <p>&nbsp;</p>
	                        <p>&nbsp;</p>
	                        <p>&nbsp;: 윤경수</p>
	                    </td>
	                    <td width="75" rowspan="2">
	                        <p><img src="./resources/ls_img/ls_body/sign_yoon.jpg" width="72" height="70" border="0"></p>
	                    </td>
	                </tr> -->
	                <%-- 담당 손해사정사 정보로 변경 시작 --%>               	               	               	
					<c:forEach items="${certiManager4ReportUser}" var="certiUserVo">
						<c:if test="${certiUserVo.certi_state_val eq '손해사정사'}">
							<tr>
							    <td height="50" width="500">
								<p>&nbsp;</p>
								<p>&nbsp;</p>
								<p style="text-align:right;padding-right:16px;">${certiUserVo.certi_state_val}</p>
							    </td>
							    <td width="65">
								<p>&nbsp;</p>
								<p>&nbsp;</p>
								<p>&nbsp;: ${certiUserVo.user_name}</p>
							    </td>
							    <td width="75" rowspan="2">
								<p>
									<img src="https://www.toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${certiUserVo.user_no}/${certiUserVo.user_sign}" width="50" height="50">		                        	
								</p>
							    </td>
							</tr>
							<tr>
							    <td width="565" colspan="2">
								<p align="right"><c:if test='${certiUserVo.work_phone != ""}'>${certiUserVo.work_phone} </c:if></p>
							    </td>
							</tr>
						</c:if>
					</c:forEach>					
	                <tr>
	                    <td width="565" colspan="2">
	                        <p align="right">070-8255-3000</p>
	                    </td>
	                </tr>
	                <tr>
	                    <td height="50" width="500">
	                        <p>&nbsp;</p>
	                        <p align="right">결 &nbsp;&nbsp;재 &nbsp;&nbsp;자 :</p>
	                    </td>
	                    <td width="65">
	                        <p>&nbsp;</p>
	                        <p>&nbsp; ${mbrVoForBodySantion.user_name}</p>
	                    </td>
	                    <td width="75" rowspan="2">
	                        <p>
								<c:choose>
									<c:when test="${mbrVoForBodySantion.user_sign ne null}">
										<%-- <img src="/home/hosting_users/toplac/www/ls_data/member_sign/${mbrVoForBodySantion.user_no}/${mbrVoForBodySantion.user_sign}" width=50 height=50 border=0> --%>
										<img src="https://toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${mbrVoForBodySantion.user_no}/${mbrVoForBodySantion.user_sign}" width=50 height=50 border=0>	                        	
									</c:when>
									<c:otherwise>
										사인 없음
									</c:otherwise>
								</c:choose>
	                        </p>
	                    </td>
	                </tr>
	                <tr>
	                    <td width="565" colspan="2">
	                        <p align="right">${mbrVoForBodySantion.handphone }</p>
	                    </td>
	                </tr>
	                <tr>
	                    <td height="50" width="500">
	                        <p>&nbsp;</p>
	                        <p align="right">조 &nbsp;&nbsp;사 &nbsp;&nbsp;자 :</p>
	                    </td>
	                    <td width="65">
	                        <p>&nbsp;</p>
	                        <p>&nbsp; ${mbrVoForBody.user_name }</p>
	                    </td>
	                    <td width="75" rowspan="2">
	                        <p>
								<c:choose>
									<c:when test="${signVoForRptUser.user_sign ne '' or signVoForRptUser.user_sign ne null}">
										<%-- <img src='/home/hosting_users/toplac/www/ls_data/member_sign/${signVoForRptUser.user_no}/${signVoForRptUser.user_sign}' width=50 height=50 border=0> --%>
										<img src="https://toplac.co.kr/home/hosting_users/toplac/www/ls_data/member_sign/${signVoForRptUser.user_no}/${signVoForRptUser.user_sign}" width=50 height=50 border=0>	                        	
									</c:when>
									<c:otherwise>
										사인 없음
									</c:otherwise>
								</c:choose>  
	                        </p>
	                    </td>
	                </tr>
	                <tr>
	                    <td width="565" colspan="2">
	                        <p align="right">${mbrVoForBody.handphone }</p>
	                    </td>
	                </tr>
	            </table>
				</div>
				<p>&nbsp;</p>
	            <hr size="1" noshade color="black">
				<table align="center" cellpadding="0" cellspacing="0" width="640">
					<tr>
						<td height="25" width="50%">
							<p class="p2">
								<b>1. 계약사항 </b>
							</p>
						</td>
						<td height="25" width="50%">
							<p align="right">
							<c:if test="${suimVO.suimRptState eq 0}">
								<img style = "cursor:pointer; float:right; " id= "rptBody17_1UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody17_1UdtAction();"/>
								<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody17_1ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
								<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody17_1ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
								</c:if>
							</p>
						</td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" align="center" width="640">
					<tr>
						<td bgcolor="#ECECEC" class="td" width="140">
							<p align="center"><b>구분</b></p>
						</td>
						<td colspan="4" class="td" bgcolor="#ECECEC" width="500">
							<p align="center"><b>내용</b></p>
						</td>
					</tr>
					<tr>
						<td class="td" bgcolor="#ECECEC">
							<p align="center" ><b>보험종목</b></p>
						</td>
						<td colspan="4" class="td">
							<p>
								<span id="print17insuranceNm">${suimVO.insurance_nm }</span>
							</p>
						</td>
					</tr>
					<tr>
						<td class="td" bgcolor="#ECECEC">
							<p align="center"><b>계약기간</b></p>
						</td>
						<td colspan="4" class="td">
							<p>
								<span class= "print17_1SpanClass" id="contractPeriod1Span">${suimRptBody17_1356891112Vo.contractPeriod1Span }</span>
								<textarea class= "print17_1InputClass" id="contractPeriod1" style="display:none;" cols="80" rows="3">${suimRptBody17_1356891112Vo.contractPeriod1}</textarea>
							</p>
						</td>
					</tr>
					<tr>
						<td class="td" bgcolor="#ECECEC">
							<p align="center"><b>증권번호</b></p>
						</td>
						<td colspan="4" class="td">
							<p>
								<span id="print17PolicyNo">${suimVO.policy_no }</span>
							</p>
						</td>
					</tr>
					<tr>
	                    <td class="td" bgcolor="#ECECEC">
							<p align="center"><b>계약자/피보험자/수익자</b></p>
	                    </td>
	                    <td colspan="4" class="td">
	                        <p >
	                        		<c:choose>
		                        		<c:when test="${suimVO.policyholder_nm ne ''}">
			                        		${suimVO.policyholder_nm } 	                        		
		                        		</c:when>	                       
		                        		<c:otherwise>
		                        			-
		                        		</c:otherwise> 		
	                        		</c:choose>
	                        		/ 
	                        		<c:choose>
		                        		<c:when test="${suimVO.beneficiary_nm ne ''}">
			                        		${suimVO.beneficiary_nm } 	                        		
		                        		</c:when>	                       
		                        		<c:otherwise>
		                        			-
		                        		</c:otherwise> 		
	                        		</c:choose> 
	                        		/ 
	                        		<c:choose>
		                        		<c:when test="${suimRptBody17_1356891112Vo.beneficiaryDtl1 ne ''}">
			                        		<span class= "print17_1SpanClass" id = "beneficiaryDtl1Span">${suimRptBody17_1356891112Vo.beneficiaryDtl1 }</span>
			                        		<input class= "print17_1InputClass" type="text" size="10" style="display:none;" id = "beneficiaryDtl1" value="${suimRptBody17_1356891112Vo.beneficiaryDtl1}"/> 	                        		
		                        		</c:when>	                       
		                        		<c:otherwise>
		                        			<span class= "print17_1SpanClass" id = "beneficiaryDtl1Span">-</span>
			                        		<input class= "print17_1InputClass" type="text" size="10" style="display:none;" id = "beneficiaryDtl1" value="${suimRptBody17_1356891112Vo.beneficiaryDtl1}"/>
		                        		</c:otherwise> 		
	                        		</c:choose> 
	                        </p>
	                    </td>
					</tr>
					<tr>
	                    <td class="td" bgcolor="#ECECEC">
							<p align="center"><b>피보험자 청약시 직무</b></p>
	                    </td>
	                    <td colspan="4" class="td">
	                        <p >
	                        	<span class= "print17_1SpanClass" id="jobJoin1Span">${suimRptBody17_1356891112Vo.jobJoin1}</span>
	                        	<input class= "print17_1InputClass" type="text" style="display:none;" id = "jobJoin1" value="${suimRptBody17_1356891112Vo.jobJoin1}"/>
	                        </p>
	                    </td>
					</tr>
					<tr>
	                    <td class="td" bgcolor="#ECECEC">
							<p align="center"><b>현재 직무</b></p>
	                    </td>
	                    <td colspan="4" class="td">
	                        <p >
	                        	<span class= "print17_1SpanClass" id="jobPresent1Span">${suimRptBody17_1356891112Vo.jobPresent1}</span>
	                        	<input class= "print17_1InputClass" type="text" style="display:none;" id = "jobPresent1" value="${suimRptBody17_1356891112Vo.jobPresent1}"/>
	                        </p>
	                    </td>
					</tr>
					<tr>
	                    <td class="td" bgcolor="#ECECEC">
							<p align="center"><b>청구 담보</b></p>
	                    </td>
	                    <td colspan="4" class="td">
	                        <p >
	                        	<span class= "print17_1SpanClass" id="mortgageDtl1Span">${suimRptBody17_1356891112Vo.mortgageDtl1Span }</span>
								<textarea class= "print17_1InputClass" id="mortgageDtl1" style="display:none;" cols="80" rows="3">${suimRptBody17_1356891112Vo.mortgageDtl1}</textarea>
	                        </p>
	                    </td>
					</tr>
					<tr>
	                    <td class="td" bgcolor="#ECECEC">
							<p align="center"><b>가입금액</b></p>
	                    </td>
	                    <td colspan="4" class="td" >
	                        <p >
	                        	<span class= "print17_1SpanClass" id="amtTotInsu1Span">${suimRptBody17_1356891112Vo.amtTotInsu1Span}</span>
	                        	<textarea class= "print17_1InputClass" id="amtTotInsu1" style="display:none;" cols="80" rows="3">${suimRptBody17_1356891112Vo.amtTotInsu1}</textarea>
	                        </p>
	                    </td>
					</tr>
					<tr>
	                    <td class="td" bgcolor="#ECECEC">
							<p align="center"><b>비고</b></p>
	                    </td>
	                    <td colspan="4" class="td">
	                        <p >
	                        	<span class= "print17_1SpanClass" id="etc1Span">${suimRptBody17_1356891112Vo.etc1Span}</span>
	                        	<textarea class= "print17_1InputClass" id="etc1" style="display:none;"  cols="80" rows="3">${suimRptBody17_1356891112Vo.etc1}</textarea>
	                        </p>
	                    </td>
					</tr>
					<tr>
	                    <td class="td" bgcolor="#ECECEC">
							<p align="center"><b>청구내용 <font color="red">(청구내용에 따라, 보고서 양식이 달라집니다)</font></b></p>
	                    </td>
	                    <td colspan="4" class="td">
	                        <p >
	                        <span class= "print17_1SpanClass" id="chungguTypeSpan">${suimRptBody17_1356891112Vo.chungguType}</span>	
	                        <span class= "print17_1InputClass" style="display:none;">
	                        	<input type="radio" name = "chungguType" value="1"/> 과거력
	                        	<input type="radio" name = "chungguType" value="2"/> 2대질병
	                        	<input type="radio" name = "chungguType" value="3"/> 암
	                        	<input type="radio" name = "chungguType" value="4"/> 상해사망
	                        	<input type="radio" name = "chungguType" value="5"/> 일당,간병비
	                        	<input type="radio" name = "chungguType" value="6"/> 후유장해
	                        	<input type="radio" name = "chungguType" value="0"/> -없음-
	                        </span>
	                        </p>
	                    </td>
					</tr>
				</table>
				<p>&nbsp;</p>
				
				<div id = "print17ContentsDivId" style="display:none;">
				<!-- 청구내용 -->
				<c:import url="../top_suim_print/suim_rpt_bsc_print_17_2.jsp"></c:import>
				<!-- //청구내용 -->
				
				<!-- 피보험자 면담내용 -->
				<c:import url="../top_suim_print/suim_rpt_bsc_print_17_3.jsp"></c:import>
				<!-- //피보험자 면담내용 -->
				
				<!-- 타보험가입내역 -->
				<c:import url="../top_suim_print/suim_rpt_bsc_print_17_4.jsp"></c:import>
				<!-- //타보험가입내역-->
				
				<div id = "recordForPrint17DivId" style="display:none;">
					<!-- 형사기록 -->
					<c:import url="../top_suim_print/suim_rpt_bsc_print_17_5.jsp"></c:import>
					<!-- //형사기록 -->
				</div>
				
				<!-- 면부책여부 / 사실관계확인결과-->
					<c:import url="../top_suim_print/suim_rpt_bsc_print_17_6.jsp"></c:import>
				<!-- //면부책여부 / 사실관계확인결과-->
				
				<!-- 치료력 관련 조사내용 -->
				<c:import url="../top_suim_print/suim_rpt_bsc_print_17_7.jsp"></c:import>
				<!-- //치료력 관련 조사내용-->
				
				<!-- 계약체결 경위 -->
					<c:import url="../top_suim_print/suim_rpt_bsc_print_17_8.jsp"></c:import>
				<!-- // 계약체결 경위-->
				
				<!-- 조사결과 -->
					<c:import url="../top_suim_print/suim_rpt_bsc_print_17_9.jsp"></c:import>
				<!-- // 조사결과-->
				
				<!-- 사고처리 과정표 시작-->
				<p class="p2"><B>10. 사고처리 과정표</B></p>
				<table cellSpacing=0 cellPadding="0" width="635" align="center" >
					<tr>
						<td bgcolor="#ECECEC" class="td" width="200">
							<p align="center"><b>일 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자</b></td>
						<td bgcolor="#ECECEC" class="td" width="204">
							<p align="center"><b>항 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</b></td>
						<td bgcolor="#ECECEC" class="td" width="215">
							<p align="center"><b>처 &nbsp;리 &nbsp;내 &nbsp;용</b></p>
						</td>
					</tr>
					<tbody id="print17_Ctrl">
					<c:forEach items="${sagoList }" var="sagoVo">
						<tr id = "print17_Ctrl_${sagoVo.sagoNo }">
							<td class="td">
								<p align="center">${sagoVo.regDate }</p></td>
							<td class="td">
								<p align="center">${sagoVo.item }</p></td>
							<td class="td">
								<p align="center">${sagoVo.content }</p>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				<p>&nbsp;</p>
				<!-- 사고처리 과정표 끝 -->
				
				
				<!-- 현장조사 체크리스트 -->
					<c:import url="../top_suim_print/suim_rpt_bsc_print_17_11.jsp"></c:import>
				<!-- // 현장조사 체크리스트-->
				
				<!-- 제3자 개입여부 -->
					<c:import url="../top_suim_print/suim_rpt_bsc_print_17_12.jsp"></c:import>
				<!-- // 제3자 개입여부-->
				
				<!-- 탐문내역 -->
				<c:import url="../top_suim_print/suim_rpt_bsc_print_17_13.jsp"></c:import>
				<!-- //탐무내역-->
				
				
				</div>
			</td>
		</tr>
	</table>
	
	
</body>