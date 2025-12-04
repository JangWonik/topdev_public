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
			
			$(".print1700_2InputClass").hide();
			$("input:radio[name='minwonGrade6']:radio[value='${suimRptBody1700Vo.minwonGrade6}']").prop('checked', true);
			
			$("#editeBody1700_1ContentsCancelBtnId").click(function (){
				$("#rptBody1700_1UdtActionBtn").show();
				$("#editeBody1700_1ContentsCancelBtnId").hide();
				$("#editeBody1700_1ContentsOkBtnId").hide();
				
				$(".print1700_1InputClass").hide();
				$(".print1700_1SpanClass").show();
				
			});
			
			$("#editeBody1700_2ContentsCancelBtnId").click(function (){
				$("#rptBody1700_2UdtActionBtn").show();
				$("#editeBody1700_2ContentsCancelBtnId").hide();
				$("#editeBody1700_2ContentsOkBtnId").hide();
				
				$(".print1700_2InputClass").hide();
				$(".print1700_2SpanClass").show();
				
			});
			
			/* 민원관련 및 전달사항 수정 OK */
			$("#editeBody1700_1ContentsOkBtnId").click(function(){
				
				if($("input:radio[name='minwonGrade6']:checked").val() == null){
					alert("민원가능 지수를 입력하세요.");
					return;
				}
				
				if($("#minwonCustomer6").val() == ''){
					alert("고객 성향을 입력하세요.");
					return;
				}
				
				if($("#minwonMemo6").val() == ''){
					alert("전달 사항을 입력하세요.");
					return;
				}
				
				$.post("./editeBody1700_1Ok",
						{	
							 suimRptNo			:"${suimRptBody1700Vo.suimRptNo}"
							,minwonGrade6  		:$("input:radio[name='minwonGrade6']:checked").val() 								//민원가능지수
							,minwonCustomer6  	:$("#minwonCustomer6").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')	//민원고객성향
							,minwonMemo6		:$("#minwonMemo6").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;') 		//민원전달사황
						},
						function(data,status){
							
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									
									$(".print1700_1InputClass").hide();
									$(".print1700_1SpanClass").show();
									
									$("#rptBody1700_1UdtActionBtn").show();
									$("#editeBody1700_1ContentsCancelBtnId").hide();
									$("#editeBody1700_1ContentsOkBtnId").hide();
									
									$("#minwonCustomer6Span").html($("#minwonCustomer6").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')
											+"<b>("+$("input:radio[name='minwonGrade6']:checked").val()+")</b>");
									$("#minwonMemo6Span").html($("#minwonMemo6").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
			}); // end click
			
			$("#editeBody1700_2ContentsOkBtnId").click(function(){
				
				$.post("./editeBody1700_2Ok",
						{	
							 suimRptNo			:"${suimRptBody1700Vo.suimRptNo}"
							,joinDate1  		:$("#joinDate1").val()																	//가입일
							,mortgage1  		:$("#mortgage1").val()																	//실손담보
							,diagnosis1  		:$("#diagnosis1").val()																	//진단명
							,hospital1  		:$("#hospital1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//병원명
							,patientPeriod1  	:$("#patientPeriod1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')			//치료기간
							,cureDtl1  			:$("#cureDtl1").val()																	//주치료내용
							,amtReq1  			: uncomma($("#amtReq1").val())															//청구금액
							,amtReduce1  		: uncomma($("#amtReduce1").val())														//요청삭감
							,issue2  			:$("#issue2").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')					//쟁점사항
							,addr3  			:$("#addr3").val()																		//고객주소
							,tel3  				:$("#tel3").val()																		//고객연락처
							,job3  				:$("#job3").val()																		//직업(회사명)
							,jobDtl3  			:$("#jobDtl3").val()																	//직무
							,totSal3  			: uncomma($("#totSal3").val())															//연소득
							,nhis3  			:$("#nhis3").val()																		//건보가입
							,amtNhis3  			: uncomma($("#amtNhis3").val())															//보험료
							,driveYn3  			:$("#driveYn3").val()																	//운전여부
							,carNo3  			:$("#carNo3").val()																		//소유차량번호
							,agent3  			:$("#agent3").val()																		//모집자
							,contractSituation3 :$("#contractSituation3").val()															//보험계약경위
							,otherInsuDtl3  	:$("#otherInsuDtl3").val()																//타사가입사항
							,customerInfo3  	:$("#customerInfo3").val()																//기타고객정보
							,contractKeepYn4  	:$("#contractKeepYn4").val()															//해지,전환
							,qnaPaper4  		:$("#qnaPaper4").val()																	//문답서
							,reuseYn4  			:$("#reuseYn4").val()																	//재이용방지여부
							,specialCase4  		:$("#specialCase4").val()																//본인상한제/산정
							,amtHome4  			:$("#amtHome4").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//재택심사금
							,amtSettle4  		:$("#amtSettle4").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//협의결과금
							,basis4  			:$("#basis4").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')					//사유
							,amtHomeSum4  		: uncomma($("#amtHomeSum4").val())														//재택심사금_소계
							,amtSettleSum4  	: uncomma($("#amtSettleSum4").val())													//협의결과금_소계
							,currentState4  	:$("#currentState4").val()																//일상생활
							,futurePlan4  		:$("#futurePlan4").val()																//향후치료계획
							,hospitalMemo4  	:$("#hospitalMemo4").val()																//주치료병원 선택
							,etcMemo5  			:$("#etcMemo5").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;')				//기타의견
						},
						function(data,status){
							
							if(status == "success"){
								if(data == 0){
									alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									
									$(".print1700_2InputClass").hide();
									$(".print1700_2SpanClass").show();
									
									$("#rptBody1700_2UdtActionBtn").show();
									$("#editeBody1700_2ContentsCancelBtnId").hide();
									$("#editeBody1700_2ContentsOkBtnId").hide();
									
									$("#joinDate1Span").html($("#joinDate1").val());
									$("#mortgage1Span").html($("#mortgage1").val());
									$("#diagnosis1Span").html($("#diagnosis1").val());
									$("#hospital1Span").html($("#hospital1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#patientPeriod1Span").html($("#patientPeriod1").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#cureDtl1Span").html($("#cureDtl1").val());
									$("#amtReq1Span").html( comma(uncomma($("#amtReq1").val())));
									$("#amtReduce1Span").html(comma(uncomma($("#amtReduce1").val())));
									$("#issue2Span").html($("#issue2").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#addr3Span").html($("#addr3").val());
									$("#tel3Span").html($("#tel3").val());
									$("#job3Span").html($("#job3").val());
									$("#jobDtl3Span").html($("#jobDtl3").val());
									$("#totSal3Span").html(comma(uncomma($("#totSal3").val())));
									$("#nhis3Span").html($("#nhis3").val());
									$("#amtNhis3Span").html(comma(uncomma($("#amtNhis3").val())));
									$("#driveYn3Span").html($("#driveYn3").val());
									$("#carNo3Span").html($("#carNo3").val());
									$("#agent3Span").html($("#agent3").val());
									$("#contractSituation3Span").html($("#contractSituation3").val());
									$("#otherInsuDtl3Span").html($("#otherInsuDtl3").val());
									$("#customerInfo3Span").html($("#customerInfo3").val());
									$("#contractKeepYn4Span").html($("#contractKeepYn4").val());
									$("#qnaPaper4Span").html($("#qnaPaper4").val());
									$("#reuseYn4Span").html($("#reuseYn4").val());
									$("#specialCase4Span").html($("#specialCase4").val());
									$("#amtHome4Span").html($("#amtHome4").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#amtSettle4Span").html($("#amtSettle4").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#basis4Span").html($("#basis4").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
									$("#amtHomeSum4Span").html(comma(uncomma($("#amtHomeSum4").val())));
									$("#amtSettleSum4Span").html(comma(uncomma($("#amtSettleSum4").val())));
									$("#currentState4Span").html($("#currentState4").val());
									$("#futurePlan4Span").html($("#futurePlan4").val());
									$("#hospitalMemo4Span").html($("#hospitalMemo4").val());
									$("#etcMemo5Span").html($("#etcMemo5").val().replace(/\n/g, "<br>").replace(/\u0020/g, '&nbsp;'));
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}
				);//post
				
			});
			
			$("#rptBody1700WordOut").click(function(){
				
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
				
				window.open('suimRptBody1700PrintOut?suimRptNo='+'${suimRptBody1700Vo.suimRptNo}'+'&type=word','tst','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});
			
			$("#rptBody1700PageOut").click(function(){
				
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
				
				window.open('suimRptBody1700PrintOut?suimRptNo='+'${suimRptBody1700Vo.suimRptNo}'+'&type=page','_blank','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
			});
			
		}); // document.ready
		
		function rptBody1700_1UdtAction(){
			$(".print1700_1InputClass").show();
			$(".print1700_1SpanClass").hide();
			
			$("#rptBody1700_1UdtActionBtn").hide();
			$("#editeBody1700_1ContentsCancelBtnId").show();
			$("#editeBody1700_1ContentsOkBtnId").show();
			
		}
		
		function rptBody1700_2UdtAction(){
			$(".print1700_2InputClass").show();
			$(".print1700_2SpanClass").hide();
			
			$("#rptBody1700_2UdtActionBtn").hide();
			$("#editeBody1700_2ContentsCancelBtnId").show();
			$("#editeBody1700_2ContentsOkBtnId").show();
			
		}
		
		//콤마찍기
		function comma(str) {
			if(str == '0'){
				return "-";
			}else{
			    str = String(str);
			    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');			
			}
		}
		
		//콤마풀기
		function uncomma(str) {
			if(str == '' || str == '-'){
				return "0";
			}else{
			    str = String(str);
			    return str.replace(/[^\d]+/g, '');		
			}
		}
		
	</script>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
	<table id = "rptBody6Table" align="center" cellpadding="0" cellspacing="0" width="648">
		<tr>
			<td>
				<p align="right">
					<img src="./resources/ls_img/report/btn_word.gif" id ="rptBody1700WordOut" title ="워드 출력" style="cursor:pointer;" border="0">
					<img src="./resources/ls_img/report/icon_print.gif" id ="rptBody1700PageOut" title ="화면 인쇄" style="cursor:pointer;" border="0">
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
								<c:if test="${suimVO.policyholder_nm ne ''}">
									&quot;<b>${suimVO.policyholder_nm}</b>&quot;
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
						<p class="p2"><B>▣ 민원관련 및 전달사항</B></p>
					</td>
					<td height="25" width="50%">
						<p align="right">
							<c:if test="${suimVO.suimRptState eq 0}">
								<img style = "cursor:pointer; float:right; " id= "rptBody1700_1UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody1700_1UdtAction();"/>
								<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody1700_1ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
								<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody1700_1ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
							</c:if>
						</p>
					</td>
				</tr>
			</table>
			<table align="center" cellpadding="0" cellspacing="0" width="640">
				<tr>
					<td class="td" align="center" bgcolor='#cccccc' nowrap>민원가능지수</td>
					<td class="td" align="center" bgcolor='#cccccc' nowrap>민원지수</td>
					<td class="td" align="center" bgcolor='#cccccc' nowrap>고객 성향</td>
					<td class="td" align="center" bgcolor='#cccccc' nowrap>전달할 사항</td>
				</tr>
				<tr>
					<td class="td" align="center" nowrap>A:가능성 적음
						<input type="radio" style="display:none;" name="minwonGrade6" value="A" class="print1700_1InputClass"/>
					</td>
					<td class="td" align="center" nowrap>0~3점</td>
					<td class="td" rowspan="3">
						<span id = "minwonCustomer6Span" class="print1700_1SpanClass">${suimRptBody1700Vo.minwonCustomer6Span}
						<b>
							<c:choose>
								<c:when test="${suimRptBody1700Vo.minwonGrade6 eq 'A'}">
									(A)								
								</c:when>
								<c:when test="${suimRptBody1700Vo.minwonGrade6 eq 'B'}">
									(B)
								</c:when>
								<c:otherwise>
									(C)
								</c:otherwise>
							</c:choose>
						</b></span>
						<textarea class= "print1700_1InputClass" id="minwonCustomer6" 
							style="display:none;" cols="22" rows="6">${suimRptBody1700Vo.minwonCustomer6} </textarea>
					</td>
					<td class="td" rowspan="3">
						<span id = "minwonMemo6Span" class="print1700_1SpanClass">${suimRptBody1700Vo.minwonMemo6Span}</span>
						<textarea class= "print1700_1InputClass" id="minwonMemo6" 
							style="display:none;" cols="22" rows="6">${suimRptBody1700Vo.minwonMemo6}</textarea>
					</td>
				</tr>
				<tr>
					<td class="td" align="center" nowrap>B:가능성 있음
						<input type="radio" style="display:none;" value="B" name="minwonGrade6" class="print1700_1InputClass"/>
					</td>
					<td class="td" align="center" nowrap>4~5점</td>
				</tr>
				<tr>
					<td class="td" align="center" nowrap>C:가능성 높음
						<input type="radio" style="display:none;" value="C" name="minwonGrade6" class="print1700_1InputClass"/>
					</td>
					<td class="td" align="center" nowrap>6~10점</td>
				</tr>
			</table>
            <p>&nbsp;</p>
            <hr size="1" noshade color="black">
			<table align="center" cellpadding="0" cellspacing="0" width="640">
				<tr>
					<td height="25" width="50%">
						<p class="p2"><B>▣ 조사보고서</B></p>
					</td>
					<td height="25" width="50%">
						<p align="right">
							<c:if test="${suimVO.suimRptState eq 0}">
								<img style = "cursor:pointer; float:right; " id= "rptBody1700_2UdtActionBtn" src="./resources/ls_img/btn_edite.gif" onclick="rptBody1700_2UdtAction();"/>
								<img src="./resources/ls_img/btn_write_cancel.gif" title="수정 취소" id = "editeBody1700_2ContentsCancelBtnId" style="float:right; display:none; cursor:pointer; " />
								<img src="./resources/ls_img/icon_write.gif" title="저장" id = "editeBody1700_2ContentsOkBtnId" style="float:right; display:none; cursor:pointer; margin-right:5px;" />
							</c:if>
						</p>
					</td>
				</tr>
			</table>
			<!-- 조사보고서 -시작- -->
			<table cellpadding="0" cellspacing="0" width="640">
			    <tr>
			        <td rowspan="6" bgcolor="#CCFFFF" class="tdb" nowrap>
			            <p align="center"><B>피해</B></p>
			            <p align="center"><B>관련</B></p>
			            <p align="center"><B>사항</B></p>
			        </td>
			        <td bgcolor="#CCFFFF" class="tdb" nowrap>
			            <p align="center"><B>피보험자</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">${suimVO.beneficiary_nm}</p>
			        </td>
			        <td bgcolor="#CCFFFF" class="tdb" nowrap>
			            <p align="center"><B>사고번호</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">${suimVO.getAccident_no()}</p>
			        </td>
			        <td bgcolor="#CCFFFF" class="tdb" nowrap>
			            <p align="center"><B>가입일</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			            	<span id = "joinDate1Span" class="print1700_2SpanClass">${suimRptBody1700Vo.joinDate1}</span>
			            	<input type="text" size="10" class="print1700_2InputClass" id = "joinDate1" value="${suimRptBody1700Vo.joinDate1}"/>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>실손담보</B></p>
			        </td>
			        <td colspan="5" class="tdb">
			            <p align="center">
			            	<span id = "mortgage1Span" class="print1700_2SpanClass">${suimRptBody1700Vo.mortgage1}</span>
			            	<input type="text" size="60" class="print1700_2InputClass" id = "mortgage1" value="${suimRptBody1700Vo.mortgage1}"/>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>진단명</B></p>
			        </td>
			        <td colspan="5" class="tdb">
			            <p align="center">
			            	<span id = "diagnosis1Span" class="print1700_2SpanClass">${suimRptBody1700Vo.diagnosis1}</span>
			            	<input type="text" size="60" class="print1700_2InputClass" id = "diagnosis1" value="${suimRptBody1700Vo.diagnosis1}"/>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>병원명</B></p>
			        </td>
			        <td bgcolor="#CCFFFF" class="tdb" nowrap>
			            <p align="center"><B>치료기간</B></p>
			        </td>
			        <td colspan="4" bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>주치료내용</B></p>
			        </td>
			    </tr>
			    <tr>
			        <td rowspan="2" class="tdb">
			            <p align="center">
			            	<span id = "hospital1Span" class="print1700_2SpanClass">${suimRptBody1700Vo.hospital1Span}</span>
							<textarea class= "print1700_2InputClass" id="hospital1" 
								 cols="11" rows="6">${suimRptBody1700Vo.hospital1}</textarea>
			            </p>
			        </td>
			        <td rowspan="2" class="tdb">
			            <p align="center">
			            	<span id = "patientPeriod1Span" class="print1700_2SpanClass">${suimRptBody1700Vo.patientPeriod1Span}</span>
							<textarea class= "print1700_2InputClass" id="patientPeriod1" 
								 cols="11" rows="6">${suimRptBody1700Vo.patientPeriod1}</textarea>
			            </p>
			        </td>
			        <td colspan="4" class="tdb">
			            <p align="center">
			            	<span id = "cureDtl1Span" class="print1700_2SpanClass">${suimRptBody1700Vo.cureDtl1}</span>
			            	<input type="text" size="50" class="print1700_2InputClass" id = "cureDtl1" value="${suimRptBody1700Vo.cureDtl1}"/>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>청구금액</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
				            <span id = "amtReq1Span" class="print1700_2SpanClass">${suimRptBody1700Vo.amtReq1}</span>
				           	<input type="text" size="8" class="print1700_2InputClass" id = "amtReq1" value="${suimRptBody1700Vo.amtReq1}"/>
			                 원</p>
			        </td>
			        <td class="tdb">
			            <p align="center"><B>요청삭감</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			        		<span id = "amtReduce1Span" class="print1700_2SpanClass">${suimRptBody1700Vo.amtReduce1}</span>
				           	<input type="text" size="8" class="print1700_2InputClass" id = "amtReduce1" value="${suimRptBody1700Vo.amtReduce1}"/>    
			            원</p>
			        </td>
			    </tr>
			    <tr>
			        <td bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>쟁점</B></p>
			            <p align="center"><B>사항</B></p>
			        </td>
			        <td colspan="6" class="tdb">
			            <p>
			            	<span id = "issue2Span" class="print1700_2SpanClass">${suimRptBody1700Vo.issue2Span}</span>
							<textarea class= "print1700_2InputClass" id="issue2" 
								 cols="87" rows="6">${suimRptBody1700Vo.issue2}</textarea>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td rowspan="7" bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>고객</B></p>
			            <p align="center"><B>정보</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center"><B>주소</B></p>
			        </td>
			        <td colspan="3" class="tdb">
			            <p align="center">
			            	<span id = "addr3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.addr3}</span>
				           	<input type="text" size="30" class="print1700_2InputClass" id = "addr3" value="${suimRptBody1700Vo.addr3}"/>
			            </p>
			        </td>
			        <td class="tdb">
			            <p align="center"><B>연락처</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			            	<span id = "tel3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.tel3}</span>
				           	<input type="text" size="10" class="print1700_2InputClass" id = "tel3" value="${suimRptBody1700Vo.tel3}"/>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>직업</B></p>
			            <p align="center"><B>(회사명)</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			            	<span id = "job3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.job3}</span>
				           	<input type="text" size="10" class="print1700_2InputClass" id = "job3" value="${suimRptBody1700Vo.job3}"/>
			            </p>
			        </td>
			        <td class="tdb">
			            <p align="center"><B>직무</B></p>
			            <p align="center"><B>(실제하는일)</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			            	<span id = "jobDtl3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.jobDtl3}</span>
				           	<input type="text" size="10" class="print1700_2InputClass" id = "jobDtl3" value="${suimRptBody1700Vo.jobDtl3}"/>
			            </p>
			        </td>
			        <td class="tdb">
			            <p align="center"><B>연소득</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			            	<span id = "totSal3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.totSal3}</span>
				           	<input type="text" size="10" class="print1700_2InputClass" id = "totSal3" value="${suimRptBody1700Vo.totSal3}"/>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>건보가입</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			            	<span id = "nhis3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.nhis3}</span>
				           	<input type="text" size="10" class="print1700_2InputClass" id = "nhis3" value="${suimRptBody1700Vo.nhis3}"/>
			            </p>
			        </td>
			        <td class="tdb">
			            <p align="center"><B>보험료</B></p>
			        </td>
			        <td colspan="3" class="tdb">
			            <p align="center">
			        		<span id = "amtNhis3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.amtNhis3}</span>
				           	<input type="text" size="10" class="print1700_2InputClass" id = "amtNhis3" value="${suimRptBody1700Vo.amtNhis3}"/>    
			            원</p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>운전여부</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			            	<span id = "driveYn3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.driveYn3}</span>
				           	<input type="text" size="10" class="print1700_2InputClass" id = "driveYn3" value="${suimRptBody1700Vo.driveYn3}"/>
			            </p>
			        </td>
			        <td class="tdb">
			            <p align="center"><B>소유차량번호</B></p>
			        </td>
			        <td colspan="3" class="tdb">
			            <p align="center">
			            	<span id = "carNo3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.carNo3}</span>
				           	<input type="text" size="30" class="print1700_2InputClass" id = "carNo3" value="${suimRptBody1700Vo.carNo3}"/>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>모집자</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			            	<span id = "agent3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.agent3}</span>
				           	<input type="text" size="10" class="print1700_2InputClass" id = "agent3" value="${suimRptBody1700Vo.agent3}"/>
			            </p>
			        </td>
			        <td class="tdb">
			            <p align="center"><B>보험계약 경위</B></p>
			        </td>
			        <td colspan="3" class="tdb">
			            <p align="center">
			            	<span id = "contractSituation3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.contractSituation3}</span>
				           	<input type="text" size="30" class="print1700_2InputClass" id = "contractSituation3" value="${suimRptBody1700Vo.contractSituation3}"/>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>타사가입사항</B></p>
			        </td>
			        <td colspan="5" class="tdb">
			            <p>
			            	<span id = "otherInsuDtl3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.otherInsuDtl3}</span>
				           	<input type="text" size="10" class="print1700_2InputClass" id = "otherInsuDtl3" value="${suimRptBody1700Vo.otherInsuDtl3}"/>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>기&nbsp;타</B></p>
			        </td>
			        <td colspan="5" class="tdb">
			            <p>
			            	<span id = "customerInfo3Span" class="print1700_2SpanClass">${suimRptBody1700Vo.customerInfo3}</span>
				           	<input type="text" size="10" class="print1700_2InputClass" id = "customerInfo3" value="${suimRptBody1700Vo.customerInfo3}"/>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td rowspan="9" bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>조사</B></p>
			            <p align="center"><B>결과</B></p>
			        </td>
			        <td bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>해지/전환</B></p>
			        </td>
			        <td class="tdb" colspan="2">
			            <p align="center">
			            	<span id = "contractKeepYn4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.contractKeepYn4}</span>
				           	<input type="text" size="20" class="print1700_2InputClass" id = "contractKeepYn4" value="${suimRptBody1700Vo.contractKeepYn4}"/>
			            </p>
			        </td>
			        <td colspan="2" bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>문답서</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			            	<span id = "qnaPaper4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.qnaPaper4}</span>
				           	<input type="text" size="10" class="print1700_2InputClass" id = "qnaPaper4" value="${suimRptBody1700Vo.qnaPaper4}"/>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>재이용방지여부</B></p>
			        </td>
			        <td class="tdb" colspan="2">
			            <p align="center">
			            	<span id = "reuseYn4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.reuseYn4}</span>
				           	<input type="text" size="20" class="print1700_2InputClass" id = "reuseYn4" value="${suimRptBody1700Vo.reuseYn4}"/>
			            </p>
			        </td>
			        <td colspan="2" bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>본인상한제</B></p>
			            <p align="center"><B>/산정특례</B></p>
			        </td>
			        <td class="tdb">
			            <p align="center">
			            	<span id = "specialCase4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.specialCase4}</span>
				           	<input type="text" size="10" class="print1700_2InputClass" id = "specialCase4" value="${suimRptBody1700Vo.specialCase4}"/>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>항목</B></p>
			        </td>
			        <td bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>재택심사금</B></p>
			        </td>
			        <td bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>협의결과</B></p>
			        </td>
			        <td colspan="3" bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>사유</B></p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center">입원의료비</p>
			        </td>
			        <td class="tdb">
			            <p align="right">
				           	<span id = "amtHome4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.amtHome4Span}</span>
							<textarea class= "print1700_2InputClass" id="amtHome4" 
								cols="10" rows="6">${suimRptBody1700Vo.amtHome4}</textarea>
			            </p>
			        </td>
			        <td class="tdb">
			            <p align="right">
				           	<span id = "amtSettle4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.amtSettle4Span}</span>
							<textarea class= "print1700_2InputClass" id="amtSettle4" 
								 cols="10" rows="6">${suimRptBody1700Vo.amtSettle4}</textarea>
			            </p>
			        </td>
			        <td colspan="3" class="tdb">
			            <p align="center">
			            	<span id = "basis4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.basis4Span}</span>
							<textarea class= "print1700_2InputClass" id="basis4" 
								 cols="41" rows="6">${suimRptBody1700Vo.basis4}</textarea>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>소계</B></p>
			        </td>
			        <td class="tdb">
			            <p align="right">
			        		<span id = "amtHomeSum4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.amtHomeSum4}</span>
				           	<input type="text" size="8" class="print1700_2InputClass" id = "amtHomeSum4" value="${suimRptBody1700Vo.amtHomeSum4}"/>    
			            원</p>
			        </td>
			        <td class="tdb">
			            <p align="right">
			        		<span id = "amtSettleSum4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.amtSettleSum4}</span>
				           	<input type="text" size="8" class="print1700_2InputClass" id = "amtSettleSum4" value="${suimRptBody1700Vo.amtSettleSum4}"/>    
			            원</p>
			        </td>
			        <td colspan="3" class="tdb">
			            <p align="center"> </p>
			        </td>
			    </tr>
			    <tr>
			        <td colspan="6" bgcolor="#B8CCE4" class="tdb">
			            <p align="center"><B>현재상태</B></p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>일상생활</B></p>
			        </td>
			        <td colspan="5" class="tdb">
			            <p>
			            	<span id = "currentState4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.currentState4}</span>
				           	<input type="text" size="63" class="print1700_2InputClass" id = "currentState4" value="${suimRptBody1700Vo.currentState4}"/>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>향후치료계획</B></p>
			        </td>
			        <td colspan="5" class="tdb">
			            <p>
			            	<span id = "futurePlan4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.futurePlan4}</span>
				           	<input type="text" size="63" class="print1700_2InputClass" id = "futurePlan4" value="${suimRptBody1700Vo.futurePlan4}"/>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td class="tdb">
			            <p align="center"><B>주치료병원</B></p>
			            <p align="center"><B>선택사유</B></p>
			        </td>
			        <td colspan="5" class="tdb">
			            <p>
			            	<span id = "hospitalMemo4Span" class="print1700_2SpanClass">${suimRptBody1700Vo.hospitalMemo4}</span>
				           	<input type="text" size="63" class="print1700_2InputClass" id = "hospitalMemo4" value="${suimRptBody1700Vo.hospitalMemo4}"/>
			            </p>
			        </td>
			    </tr>
			    <tr>
			        <td bgcolor="#CCFFFF" class="tdb">
			            <p align="center"><B>기타</B></p>
			            <p align="center"><B>의견</B></p>
			        </td>
			        <td colspan="6" class="tdb">
			            <p>
			            	<span id = "etcMemo5Span" class="print1700_2SpanClass">${suimRptBody1700Vo.etcMemo5Span}</span>
							<textarea class= "print1700_2InputClass" id="etcMemo5" 
								 cols="87" rows="6">${suimRptBody1700Vo.etcMemo5}</textarea>
			            </p>
			        </td>
			    </tr>
			</table>
			<!-- 조사보고서 -끝- -->
	        
	        <p>&nbsp;</p>
	        <!-- 첨부자료 목록 -->
				<c:import url="../top_suim_print/suim_rpt_bsc_print_1700_7.jsp"></c:import>
			<!-- // 첨부자료 목록-->
	        
	        <p>&nbsp;</p>
			<p align="center"><B>본 손해사정서는 당사의 양식과 최선의 노력으로 이해 당사자</B></p>
			<p align="center"><B>어느 일방에도 편중됨이 없이 작성되었음을 명백히 합니다.[끝]</B></p>
			<p>&nbsp;</p>
			<table cellpadding="0" cellspacing="0" width="640" align="center">
				<tr>
					<td width="100%" class="td" align="center">
						<p><b>최종보고서 제출일로부터 15일 이내에 본사 손사 담당자로부터 조사서류 일체의</b></p>
						<p><b>파기에 관한 의사표시가 없는 경우, 지체 없이 조사서류 일체를 파기한다.</b></p>
					</td>
				</tr>
			</table>
			<p>&nbsp;</p>
			
			<hr size="1" noshade color="black">
			<p>&nbsp;</p>
			<table cellpadding="0" cellspacing="0" width="640" align="center">
				<tr>
					<td width="100%" height="45" class="td">
						<p style="line-height:200%;" align="center"><font size="5"><b>사 고 처 리 과 정 표</b></font></p>
					</td>
				</tr>
			</table>
			<table align="center" cellpadding="0" cellspacing="0" width="640">
				<tr>
					<td height="25" width="50%">
						<p class="p2"><B>처리과정(서류접수 현황포함)</B></p>
					</td>
					<td height="25" width="50%">
						<p>&nbsp;</p>
					</td>
				</tr>
			</table>
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
				<tbody id="print1700_Ctrl">
				<c:forEach items="${sagoList }" var="sagoVo">
					<tr id = "print1700_Ctrl_${sagoVo.sagoNo }">
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
			</td>
		</tr>
	</table>
	
	
</body>