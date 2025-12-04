<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>보고서 작성</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<link rel="stylesheet" type="text/css" href="./resources/ls_css/rpt_6_style.css" />
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	
	<script>
		$(document).ready(function(){
			
			/* 1. 보험계약사항 수정 취소하기 */
			$("#editeBody1_1ContentsCancelBtnId").click(function(){
				
				$(".print1_1SpanClass").css("display","inline");
				$(".print1_1InputClass").css("display","none");	
				$("#editeBody1_1ContentsCancelBtnId").css("display","none");
				$("#editeBody1_1ContentsOkBtnId").css("display","none");
				$("#rptBody1_1UdtActionBtn").css("display","inline");
				$("#print1_1ShowHideBtnId").css("display","none");
				$("#print1_1SampleImg").css("display","none");
				
			});
			
			/* 보험계약사항 수정 Ok 하기 */
			$("#editeBody1_1ContentsOkBtnId").click(function(){
				
				$.post("./editeBody1_1Ok",
						{	
							 rptPrintNo		:"${suimRptBody1_13467Vo.rptPrintNo}"
							,insuredAddr1  		:$("#insuredAddr1").val()		//주소
							,insuTerm1  		:$("#insuTerm1").val()			//보험기간
							,insuredJob1  		:$("#insuredJob1").val()		//직업
							,insuMortgage1  	:$("#insuMortgage1").val()		//담보구분	
							,insuMortgageDtl1  	:$("#insuMortgageDtl1").val()	//담보내역
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("불러오기를 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									$(".print1_1SpanClass").css("display","inline");
									$(".print1_1InputClass").css("display","none");	
									$("#editeBody1_1ContentsCancelBtnId").css("display","none");
									$("#editeBody1_1ContentsOkBtnId").css("display","none");
									$("#rptBody1_1UdtActionBtn").css("display","inline");
									$("#print1_1ShowHideBtnId").css("display","none");
									$("#print1_1SampleImg").css("display","none");
									
									$("#insuredAddr1SpanId").html($("#insuredAddr1").val());
									$("#insuTerm1SpanId").html($("#insuTerm1").val());
									$("#insuredJob1SpanId").html($("#insuredJob1").val());
									$("#insuMortgage1SpanId").html($("#insuMortgage1").val());
									$("#insuMortgageDtl1SpanId").html($("#insuMortgageDtl1").val());
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			});
			
			
			/* 계약사항 샘플 이미지 보이기 */
			$("#print1_1ShowHideBtnId").click(function(){
				
				$("#print1_1SampleImg").css("display","block");					
			});
			
			$("#rptBody1WordOut").click(function(){
				
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
				
				window.open('suimRptBody1PrintOut?suimRptNo='+'${suimRptBody1_13467Vo.suimRptNo}'+'&type=word','tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});
			
			$("#rptBody1PageOut").click(function(){
				
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
				
				window.open('suimRptBody1PrintOut?suimRptNo='+'${suimRptBody1_13467Vo.suimRptNo}'+'&type=page','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});
			
		});
		
		function rptBody1_1UdtAction(){
			
			$(".print1_1SpanClass").css("display","none");
			$(".print1_1InputClass").css("display","inline");
			$("#rptBody1_1UdtActionBtn").css("display","none");
			$("#editeBody1_1ContentsCancelBtnId").css("display","inline");
			$("#editeBody1_1ContentsOkBtnId").css("display","inline");
			$("#print1_1ShowHideBtnId").css("display","inline");
			
		}
		
		/* 계약사항 샘플 양식 숨기기 */
		function print1_1ShowHide(){
			$("#print1_1SampleImg").css("display","none");	
		}
		
	</script>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
	<table id = "rptBody6Table" align="center" cellpadding="0" cellspacing="0" width="648">
		<tr>
			<td>
				<p align="right">
					<img src="./resources/ls_img/report/btn_word.gif" id ="rptBody1WordOut" title ="워드 출력" style="cursor:pointer;" border="0">
					<img src="./resources/ls_img/report/icon_print.gif" id ="rptBody1PageOut" title ="화면 인쇄" style="cursor:pointer;" border="0">
				</p>
				<p align="center"><img src="https://www.toplac.co.kr/resources/ls_img/ls_body/print_head.jpg" width="640" height="56" border="0"></p>
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
						<th width="90" align="right">
							<p>Date.</p>
						</th>
						<th width="115" align="left">
							<p>&nbsp;
							<c:if test="${suimInvVO.invoiceDate eq '' or suimInvVO.invoiceDate eq null}">
								날짜 정보없음
							</c:if>
							<c:if test="${suimInvVO.invoiceDate ne '' or suimInvVO.invoiceDate ne null}">
								${suimInvVO.invoiceDate }
							</c:if>
								
							</p>
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
						<th height="30" width="85" align="center">
							<p>사 고 번 호</p>
						</th>
						<th width="555" colspan="3" align="left">
							<p><b>: ${suimVO.accident_no}</b></p>
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
	                <tr>
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
	                </tr>
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
								<b>1. 보험계약사항 
									<img src="./resources/ls_img/ls_body/icon_score_zoom.gif" title="샘플 양식 보기" id = "print1_1ShowHideBtnId" style="display:none; cursor:pointer; "  />
								</b>
							</p>
						</td>
						<td height="25" width="50%">
							<p align="right">
								<img style = "cursor:pointer; float:right; " id= "rptBody1_1UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody1_1UdtAction();"/>
								<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody1_1ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
								<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody1_1ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
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
					<tr>
						<td bgcolor="#ECECEC" class="td" width="140">
							<p align="center"><b>구분</b></p>
						</td>
						<td colspan="4" class="td" bgcolor="#ECECEC" width="500">
							<p align="center"><b>내용</b></p>
						</td>
					</tr>
					<tr>
						<td class="td">
							<p align="center">보험종목</p>
						</td>
						<td colspan="4" class="td">
							<p>
								<span class= "insuNm1SpanClass" id="insuNm1SpanId">${suimVO.insurance_nm }</span>
							</p>
						</td>
					</tr>
					<tr>
						<td class="td">
							<p align="center">증권번호</p>
						</td>
						<td colspan="4" class="td">
							<p>
								<span class= "insuNo1SpanClass" id="insuNo1SpanId">${suimVO.policy_no }</span>
							</p>
						</td>
					</tr>
					<tr>
	                    <td class="td">
							<p align="center">계약자</p>
	                    </td>
	                    <td class="td">
	                        <p align="center">
	                        	<span class= "policyholderNmSpanClass" id="policyholderNmSpanId">${suimVO.policyholder_nm }</span>
	                        </p>
	                    </td>
	                    <td class="td"  bgcolor="#ECECEC">
							<p align="center">주민번호</p>
	                    </td>
	                    <td colspan="2" class="td">
	                        <p align="center">
	                        	<span class= "policyholderSsnSpanClass" id="policyholderSsnSpanId">${suimVO.policyholder_ssn }</span>
	                        </p>
	                    </td>
					</tr>
					<tr>
	                    <td class="td">
							<p align="center">피보험자</p>
	                    </td>
	                    <td class="td">
	                        <p align="center">
	                        	<span class= "beneficiaryNmSpanClass" id="beneficiaryNmSpanId">${suimVO.beneficiary_nm }</span>
	                        </p>
	                    </td>
	                    <td class="td" bgcolor="#ECECEC" >
							<p align="center">주민번호</p>
	                    </td>
	                    <td colspan="2" class="td">
	                        <p align="center">
	                        	<span class= "beneficiarySsnSpanClass" id="beneficiarySsnSpanId">${suimVO.beneficiary_ssn }</span>
	                        </p>
	                    </td>
					</tr>
					<tr>
						<td class="td">
							<p align="center">주소</p>
						</td>
						<td colspan="4" class="td">
							<p>
								<span class= "print1_1SpanClass" id="insuredAddr1SpanId">${suimRptBody1_13467Vo.insuredAddr1 }</span>
								<input type="text" size= "70" class= "print1_1InputClass" id = "insuredAddr1" style="display:none;" value="${suimRptBody1_13467Vo.insuredAddr1 }"/>
							</p>
						</td>
					</tr>
					<tr>
						<td class="td">
							<p align="center">보험 기간</p>
						</td>
						<td colspan="4" class="td">
							<p>
								<span class= "print1_1SpanClass" id="insuTerm1SpanId">${suimRptBody1_13467Vo.insuTerm1 }</span>
								<input type="text" size= "70" class= "print1_1InputClass" id = "insuTerm1" style="display:none;" value="${suimRptBody1_13467Vo.insuTerm1 }"/>
							</p>
						</td>
					</tr>
					<tr>
						<td class="td">
							<p align="center">직 업</p>
						</td>
						<td colspan="4" class="td">
							<p>
								<span class= "print1_1SpanClass" id="insuredJob1SpanId">${suimRptBody1_13467Vo.insuredJob1 }</span>
								<input type="text" size= "70" class= "print1_1InputClass" id = "insuredJob1" style="display:none;" value="${suimRptBody1_13467Vo.insuredJob1 }"/>
							</p>
						</td>
					</tr>
					<tr>
						<td class="td">
							<p align="center">연락처</p>
						</td>
						<td colspan="4" class="td">
							<p>
								<span class= "print1_1SpanClass" id="policyholderTelSpanId">${suimVO.policyholder_tel }</span>
							</p>
						</td>
					</tr>
					<tr>
						<td rowspan="3" class="td">
							<p align="center">담보 내역 및 추정 금액</p>
						</td>
						<td colspan="2" class="td"  bgcolor="#ECECEC">
							<p align="center">
								담보 구분
							</p>
						</td>
						<td colspan="2" class="td"  bgcolor="#ECECEC">
							<p align="center">
								담보 내역
							</p>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="td">
							<p align="center">
								<span class= "print1_1SpanClass" id="insuMortgage1SpanId">${suimRptBody1_13467Vo.insuMortgage1 }</span>
								<input type="text" size= "45" class= "print1_1InputClass" id = "insuMortgage1" style="display:none;" value = "${suimRptBody1_13467Vo.insuMortgage1 }"/>
							</p>
						</td>
						<td colspan="2" class="td">
							<p align="center">
								<span class= "print1_1SpanClass" id="insuMortgageDtl1SpanId">${suimRptBody1_13467Vo.insuMortgageDtl1 }</span>
								<input type="text" size= "20" class= "print1_1InputClass" id = "insuMortgageDtl1" style="display:none;" value="${suimRptBody1_13467Vo.insuMortgageDtl1 }"/>
							</p>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="td"  bgcolor="#ECECEC">
							<p align="center">
								추정금액		
							</p>
						</td>
						<td colspan="2" class="td">
							<p align="center">
								<span class= "amtEstimatedDamageSpanClass" id="amtEstimatedDamageSpanId">${suimVO.amtEstimatedDamage }</span>
								원
							</p>
						</td>
					</tr>
				</table>
				<p>&nbsp;</p>
				
				<!-- 타 보험계약사항 -->
				<c:import url="../top_suim_print/suim_rpt_bsc_print_1_2.jsp"></c:import>
				<!-- //타 보험계약사항 -->
				
				<!-- 사고사항 -->
				<c:import url="../top_suim_print/suim_rpt_bsc_print_1_3.jsp"></c:import>
				<!-- //사고사항 -->
				
				<!-- 조사방향 및 결과 -->
				<c:import url="../top_suim_print/suim_rpt_bsc_print_1_4.jsp"></c:import>
				<!-- //조사방향 및 결과 -->
				
				<!-- 총괄경과표  -->
				<c:import url="../top_suim_print/suim_rpt_bsc_print_1_5.jsp"></c:import>
				<!-- //총괄경과표-->
				
				<!-- 조사내용 -가 -->
				<c:import url="../top_suim_print/suim_rpt_bsc_print_1_6.jsp"></c:import>
				<!-- //조사내용 -가 -->
				
				<!-- 조사내용 -나 -->
				<c:import url="../top_suim_print/suim_rpt_bsc_print_1_6b.jsp"></c:import>
				<!-- //조사내용 -나 -->
				
				<!-- 조사내용 -다-1 -->
				<c:import url="../top_suim_print/suim_rpt_bsc_print_1_6c.jsp"></c:import>
				<!-- //조사내용 -다-1 -->
				
				<!-- 조사내용 -다-2 -->
				<c:import url="../top_suim_print/suim_rpt_bsc_print_1_6d.jsp"></c:import>
				<!-- //조사내용 -다-2 -->
				
				<!-- 7.손해사정 결과 -->
				<c:import url="../top_suim_print/suim_rpt_bsc_print_1_7.jsp"></c:import>
				<!-- //7.손해사정 결과-->
				
				<!-- 8.첨부파일 목록 -->
				<c:import url="../top_suim_print/suim_rpt_bsc_print_1_8.jsp"></c:import>
				<!-- //8.첨부파일 목록-->
				
				<p>&nbsp;</p>
				<p align="center"><b>본 손해사정서는 당사의 양식과 최선의 노력으로 이해 당사자</b></p>
				<p align="center"><b>어느 일방에도 편중됨이 없이 작성되었음을 명백히 합니다.[끝]</b></p>
				<p>&nbsp;</p>
				<hr size="1" noshade color="black">
				
				<!-- 사고처리 과정표 -->
				<c:import url="../top_suim_print/suim_rpt_bsc_print_ctrl.jsp"></c:import>
				<!-- //사고처리 과정표-->
				
				<!-- 첨부파일 -->
				<c:import url="../top_suim_print/suim_rpt_bsc_print_file.jsp"></c:import>
				<!-- //첨부파일-->
				
			</td>
		</tr>
	</table>
	
	
</body>