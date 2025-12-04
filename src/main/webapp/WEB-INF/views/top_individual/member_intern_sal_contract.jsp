<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- jstl substring -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>&nbsp;</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	
	<style media="print">
		.noPrint {
 		 	DISPLAY: none 		}
 		.onlyPrint{ 
 			 margin: 15.05px; 
 		} 
		
	</style>

	<style media="screen">
		.onlyPrint {
/* 		 	DISPLAY: none */
		}
	</style>
	
	
	<script>
		$(document).ready(function(){
			
			if("${flag}" != "priview" && "${boardFlag}" != "0"){
				window.print();
			}
			
// 			//본인이 아니면 
// 			if( "${mbrVo_Session.user_no}" == "${salDetail.user_no}"){
				
// 			}else{
				
// 				if ( "${mbrVo_Session.user_no}" != 6 || "${mbrVo_Session.user_no}" != 38 || "${mbrVo_Session.user_no}" != 670 || "${mbrVo_Session.user_no}" != 1117 || "${mbrVo_Session.user_no}" != 215){
// 					alert("잘못된 접근입니다.");
// 					return;
// 				}
// 			}
			
			
			//인쇄버튼		
			$("#printBtn").click(function(){
				window.print();				
				window.close();
			});//$("#printBtn").click
			
			
			//동의버튼
			$("#agreeBtn").click(function(){
				if( $("#user_sign").val() == "" ){
					alert("반드시 도장 및 사인이 등록되어야 합니다. \n My Menu - 정보수정에서 등록 되어야 합니다.");
					return;
				}
				
				var r = confirm("인턴사원 근로계약서 작성을 완료하시겠습니까?");	
				if (!r){
					return false;
					
				}
				
				$.post("AgreeSalary",
						{ 
							user_no : $("#user_no").val() 
						  	,gubun : "intern"
						} 
						,function(data, status){
							if(data == 1 && status == "success"){
								alert("동의 되었습니다.");
								var r = confirm("인쇄하시겠습니까?");
								if (!r){
									location.reload();
									window.close();
									return false;
								}				
								window.print();
								window.close();
							}
						}
				);
			});//$("#agreeBtn").click
		});//$(document).ready
	</script>
	
	<style type="text/css">
		.tg  {border-collapse:collapse;border-spacing:0; width:1020px; }
		
		.tg td{font-family:Arial, sans-serif;font-size:20px;overflow:hidden;word-break:normal;height:20px;line-height: 125%;color: black;padding-left:10px;}
		.tg th{font-family:Arial, sans-serif;font-size:20px;overflow:hidden;word-break:normal;height:20px;color:black;}
		.tg .tg-yw4l{vertical-align:top}
		
		.address {font-size:16px;border-collapse:collapse;border-spacing:0; width:1020px;}
		.address th{color:black;}
		.address td{color:black;}
		
/* 		border-style:solid;border-width:1px; */
		
	</style>
</head>

<body>

<div class="onlyPrint">
<input type="hidden" id="user_no" name="user_no" value="${userDetail.user_no}"/>
<input type="hidden" id="user_sign" name="user_sign" value="${userSign}"/>

<center>
	<table class="tg">
		<tr>
	   		<th style="font-size:xx-large;  color:black; font-weight:bold; height:80px;">
	   			인턴사원(internship) 근로계약서	
   			</th>
	  	</tr>
	  	<tr>
	  		<td align="left" style="padding-left:0px;">
	  			탑손해사정주식회사(이하 "사업주" 라 함)와 ${userDetail.user_name}(이하 "근로자" 라 함)은 아래와 같이 인턴사원(internship, 시용)근로계약을 체결하고 이를 성실히 이행할 것을 약정한다.
	  		</td>
	  	</tr>
	  	
		<tr><td>&nbsp;</td></tr>
	  	<tr><td>-&nbsp;&nbsp;&nbsp;아&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;래&nbsp;&nbsp;&nbsp;-</td></tr>
	  	<tr><td>&nbsp;</td></tr>
	  	
	  	<tr><th align="left">1. 근로계약기간</th></tr>
	  	<tr><td align="left">본 근로계약기간은 근로계약체결일로부터 3개월(90일)까지로 한다.</td></tr>
	  	<tr><td>&nbsp;</td></tr>
	  	
	  	<tr><th align="left">2. 근무장소 및 업무</th></tr>
	  	<tr><td align="left">사업주의 본점, 지점, 파견지점, 등의 사무실과 실무현장에서 손해사정에 대한 제반(실무훈련, 견습)업무</td></tr>
	  	
 		<tr><td>&nbsp;</td></tr>
 		<tr><th align="left">3. 근로시간 및 근무일/휴일</th></tr>
	  	<tr>
	  		<td align="left">
	  			소정근로시간 : 09시 00분부터 18시00분까지 (휴게시간 : 12시 00분 ~ 13시 00분)
				<br/>근무일 / 휴일 : 매주 5일(월요일~금요일)근무, 주휴일 매주 일요일<font size="3">(단,1주 소정근로일을 개근한 경우 유급으로 부여한다)</font>
				<br/><font size="3">※ 사업주는 필요한 경우에는 근로자와 합의하여 1주 12시간을 한도로 근로시간을 연장 할 수 있다.</font>
			</td>
		</tr>
		
		<tr><td>&nbsp;</td></tr>
 		<tr><th align="left">4. 임금</th></tr>
	  	<tr>
	  		<td align="left">
	  			사업주는 인턴사원근로기간 동안 교통비, 식대, 실무훈련임금의 명목으로 매월 말일에 근로자 명의의 예금통장으로 월1,500,000원을 지급한다. 
	  			<!-- 2017.10.24. 하명호이사님 요청사항 -->
	  			<c:if test="${userDetail.reg_date > 1508425200 or userDetail.reg_date == null}">
	  				(단, 2018.1.1. 이후에는 월 임금을 변경, 별도 계약한 후 적용함)
	  			</c:if>
				<br/><font size="3" style="letter-spacing:0.7px;">※사업주는 인턴사원 근로계약 종료시점에 근로자가 정직원채용(본채용)에 필요한 요건, 자격이 충족 될 경우(본채용심사 통과 시) 해당 근로자와 새로운 본채용 근로계약을 체결하여 임금, 상여금, 기타 제수당 등의 근로계약조건을 협의 할 수 있다.</font>
			</td>
		</tr>
		
		<tr><td>&nbsp;</td></tr>
 		<tr><th align="left">5. 연차유급휴가</th></tr>
	  	<tr>
	  		<td align="left">
	  			연차 유급휴가는 근로기준법에서 정하는 바에 따라 부여한다. 
			</td>
		</tr>
		
		<tr><td>&nbsp;</td></tr>
 		<tr><th align="left">6. 사회보험 적용여부 (□고용보험 □산재보험 □국민연금 □건강보험)</th></tr>
	  	<tr>
	  		<td align="left">
	  			사업주는 본 계약기간 동안 근로자에게 사회보험(4대 보험)을 적용한다.
			</td>
		</tr>
		
		<tr><td>&nbsp;</td></tr>
 		<tr><th align="left">7. 비밀유지 및 손해배상</th></tr>
	  	<tr>
	  		<td align="left">
	  			근로자는 업무상 취득한 사업주의 비밀(경영상의 비밀, 영업노하우 등 일체)을 항시(재직, 퇴직)유지하여야 한다. 
	  			<br/>이를 위반하여 사업주에게 손해를 입힌 경우 근로자는 월 지급총액(30일 기준)의 10배에 상당하는 금액을 손해배상금으로 사업주에게 배상하여야 한다.
			</td>
		</tr>
		
		<tr><td>&nbsp;</td></tr>
 		<tr><th align="left">8. 계약해지, 퇴직 및 계약의 자동종료</th></tr>
	  	<tr>
	  		<td align="left">
	  			 근로자가 아래 제1호 내지 제3호에 해당하여 인턴사원 근로계약을 지속하기 어려운 경우 인턴사원 근로계약 종료 전이라도 사업주는 근로자를 상대로 계약을 해지 할 수 있다.
				<br/>① 근로자의 일체의 부정 또는 정당한 업무명령에 위반한 경우
				<br/>② 근로자의 무단결근, 지각, 조퇴, 근무이탈이 월3회 또는 3일 이상 계속 된 경우
				<br/>③ 기타 근로자의 귀책사유로 인해 본 근로계약을 지속하는 것이 어려운 경우 
				<br/>④ 기타 전 각호에 준하는 사유가 있거나 근로자가 근로자측의 사정으로 본 계약을 해지하는 경우 근로자는 사직예정일로부터 30일전에 사직서를 사업주에게 제출하여야 하며,업무인수 • 인계 후 퇴직하여야 한다.또한 업무인수인계서를 작성하여 결재를 받아야 하며, 위반 시 사업주에게 발생된 손해를 배상하여야 한다.
				<br/>⑤ 본 근로계약은 기간의 정함이 있는 근로계약으로 본채용 계약이 체결되지 않을 경우 당사자간 별도의 의사표시 &nbsp;&nbsp;&nbsp;&nbsp;없이 근로계약만료로 자동 종료한다.
	  			 
			</td>
		</tr>
		
		<tr><td>&nbsp;</td></tr>
 		<tr><th align="left">9. 근로계약서 교부</th></tr>
	  	<tr>
	  		<td align="left">
	  			사업주는 근로계약을 체결함과 동시에 본 계약서를 사본하여 근로자의 교부요구와 관계없이 근로자에게 교부한다.	  			 
			</td>
		</tr>
		
		<tr><td>&nbsp;</td></tr>
 		<tr><th align="left">10. 기타</th></tr>
	  	<tr>
	  		<td align="left">
	  			이 계약에 정함이 없는 사항은 노동관계법령에 따른다. 			 
			</td>
		</tr>
	  	
		<tr>
  			<th style="font-size:x-large;  color:black; font-weight:bold; height:80px;">
	   			${userDetail.join_date}	
   			</th>
	  	</tr>
  	</table>
	<table class="address" >
		<colgroup>
			<col width="75px;"></col>
			<col width="75px;"></col>
			<col width="335px;"></col>
			
			<col width="30px;"></col>
			
			<col width="75px;"></col>
			<col width="75px;"></col>
			<col width="335px;"></col>
		</colgroup>
		<tr style="height:35px;">
			<th>사업주</th>
			<td style="padding-left: 0px;">주&nbsp;&nbsp;&nbsp;소 :</td>
			<td style="padding-left: 0px;" align="left">서울시 마포구 마포대로 63-8 301호</td>
			<td>&nbsp;</td>
			<th style="padding-left: 0px;">근로자</th>
			<td style="padding-left: 0px;">주&nbsp;&nbsp;&nbsp;소 :</td>
			<td style="padding-left: 0px;" align="left">${userDetail.home_address}</td>
		</tr>
		<tr style="height:35px;">
			<th>&nbsp;</th>
			<td style="padding-left: 0px;">법인명 :</td>
			<td style="padding-left: 0px;"align="left">탑손해사정 주식회사</td>
			<td style="padding-left: 0px;">&nbsp;</td>
			<th style="padding-left: 0px;">&nbsp;</th>
			<td style="padding-left: 0px;">연락처 : </td>
			<td style="padding-left: 0px;" align="left">${userDetail.handphone}</td>
		</tr>
		<tr style="height:35px;">
			<th>&nbsp;</th>
			<td style="padding-left: 0px;">대&nbsp;&nbsp;&nbsp;표 :</td>
			<td style="padding-left: 0px;" align="left">
				전&nbsp;&nbsp;&nbsp;태&nbsp;&nbsp;&nbsp;옥 
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="./resources/ne_img/intern_sign.jpg"/> 
			</td>
			<td style="padding-left: 0px;">&nbsp;</td>
			<th>&nbsp;</th>
			<td style="padding-left: 0px;">성&nbsp;&nbsp;&nbsp;명 : </td>
			<td align="left" style="padding-left: 0px;">
				${userDetail.user_name}
				<c:if test="${userSign ne null and userSign ne ''}">
					<img src="${userSign}" width="45"/>
				</c:if> 
			</td> 
		</tr>
		
		<tr>
			<th colspan="3" align="left" valign="bottom" style="color:#233575;font-size:12px;"><img src="./resources/ne_img/intern_logo.jpg"/>TOP LOSS ADJUSTERS CO., LTD.</th>
			<td>&nbsp;</td>
			<th colspan="3" align="right" style="color:#233575;font-size:12px;">[탑손해사정주식회사 인사서식 제1호]</th>
		</tr>
	</table>
</center>
</div>

<div class="noPrint">
	<c:if test="${flag ne 'priview' }">
		<br/><br/>
		<table >
			<tr>
				<td align="center">
					<c:if test="${userDetail.sal_state == 1}">
						<input  type="button" id="agreeBtn" name="agreeBtn" value="작성" style="width:80px;height:40px;"/>
					</c:if>
					<c:if test="${userDetail.sal_state == 2}">
						<input  type="button" id="printBtn" name="printBtn" value="인쇄하기" style="width:80px;height:40px;"/>
					</c:if>
				</td>		
			</tr>	
		</table>
		<br/><br/>
	</c:if>
</div>

</body>


</html>
