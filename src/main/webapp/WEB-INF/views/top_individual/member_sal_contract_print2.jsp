<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<script>
	</script>
	<style type="text/css">
		.tg  {border-collapse:collapse;border-spacing:0; width:1000px; }
		.tg td{font-family:Arial, sans-serif;font-size:15px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
		.tg .tg-yw4l{vertical-align:top}
		
		.header {font-weight: bold; font-size:15px; text-align: center; padding: 5px 10px 5px;}
		.header2 {font-size:15px; text-align: center; padding: 5px 10px 5px; }
		.comment {text-align:left;padding: 17px 20px 17px; line-height:200%;}
		
		.innerTable td{padding: 5px 10px 5px; text-align: center;}
		.innerTable .innerHeader{padding: 5px 10px 5px; text-align: center; font-size:14px;}
		
		.tg2  {border-collapse:collapse;border-spacing:0; width:1000px; }
		.tg2 td{font-family:Arial, sans-serif;font-size:15px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
		.tg2 .tg-yw4l{vertical-align:top}
		.tg2 .comment {text-align:left;padding: 12px 20px 12px; line-height:190%;}
		
	</style>
</head>

<body>
<center>
	<table class="tg">
		<tr>
	   		<th colspan="7" style="font-size: x-large; font-weight:bold; padding-top: 30px;padding-bottom: 30px;">
	   			연봉 근로 계약서 
   			</th>
	  	</tr>
	  
	  	<tr>	
	    	<td rowspan="4" class="header">1. 계약 당사자</td>
	    	<td rowspan="2" class="header">사용자</td>
	    	<td class="header2" >사업체명</td>
	    	<td colspan="2" class="header">탑손해사정주식회사</td>
	    	<td class="header2" >대표이사</td>
	    	<td class="header">전태옥</td>
	  	</tr>
	  	
	  	<tr>
	    	<td class="header2" >주소 및 연락처</td>
	    	<td colspan="4" class="header2"> 서울시 마포구 마포대로 68-8 삼창프라자빌딩 301호</td>
	  	</tr>
	  	
		<tr>
			<td rowspan="2" class="header">근로자</td>
		    <td class="header2" >성명 및 직위</td>
		    <td class="header">홍길동</td><!-- 이름 -->
		    <td class="header">사원</td><!-- 직급 -->
		    <td class="header2" >생년월일</td>
		    <td class="header2" >1970-01-01</td><!-- 생년월일 -->
		</tr>
		
		<tr>
			<td class="header2" >주소</td>
		 	<td colspan="2" class="header2" > 서울시 서대문구 </td><!-- 주소 -->
			<td class="header2" >전화번호</td>
			<td class="header2" >010-1234-5678</td><!-- 전화번호 -->
	  	</tr>
	  	
	  	<tr>
   			<td colspan="7" style="padding-top:30px;padding-bottom:30px;text-align:center;">
   				위 사용자와 근로자는 아래의 연봉 및 근로저건을 성실히 이행할 것을 약정하고 연봉근로계약을 체결한다. <br />
   				- 아 래 -
   			</td>
	  	</tr>
	  	
		<tr>
			<td class="header" rowspan="10">
				2.근로조건 
			</td>
			<td class="header">
		    	근무장소/<br/>업무내용
	    	</td>
			<td colspan="5" class="comment">
		             가. 근무장소 : 사용자의 사업장 혹은 사용자가 지정하는 장소<br>
				 나. 업무내용 : 물보험 손해사정업무 외(지원업무 포함)<br>
    			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(사용자는 사업운영에 필요할 경우 근로자에게 보직변경, 전직 등 인사명령을 할 수 있으며, 
    			<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;근로자는 이에 따른다)								
			</td>
		</tr>
		
	  	<tr>
	    	<td class="header">
	    		근로계약기간<br/>
	    		<font style="font-size:13px;">(연봉 및 근로조건 등 적용기간)</font>
    		</td>
	    	<td colspan="3" align="left"  class="comment">
	    		2017년 1월 1일 ~ 2017년 12월 31일	    		
    		</td>
	    	<td class="header">최초 입사일</td>
	    	<td class="header">2016년 1월 1일</td><!-- 입사일 -->
	  	</tr>
	  	
		<tr>
			<td rowspan="4" class="header">임금</td>
			<td class="header">산정기간<br>지급방법<br>연봉총액<br>월 급여</td>
			<td colspan="4" align="left"  class="comment">
			 	가. 연봉금액의 변경시 새로운 연봉근로계약서를 작성하여 적용한다.
				<br/>나. 근로자의 연봉총액, 월 급여<font style="font-size:13px;">(연봉총액/13개월, 연봉총액의 12/13을</font>
				<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font style="font-size:13px;">연간 총 급여로 지급)</font>는 아래와 같으며 월 급여에서 법령 및 노사간 합의에 
				<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;의한 금액을 공제하고 매월 초일에 기산하여 말일에 마감하고 하고 
				<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;당월 말일에 근로자명의의 급여통장에 입급한다.
				<br/>다. 사용자는 연봉총액의 1/13 은 퇴직급여에 충당<font style="font-size:13px;">(적립)</font>하고 근로자퇴직급여 
				<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;보장법에 따른 퇴직급여의 지급요건을 충족하는 근로자에게 지급한다.
				<br/>
				<center>
					 <table class="innerTable">
					 	<tr>
					 		<td width="33%" style="line-height:100%">
					 			연봉 총액
					 			<br/><font style="font-size:11px;">(퇴직급여 충당(적립)금 포함)</font>
					 		</td>
					 		<td width="22%">
						 		<font style="font-size:14px; line-height:100%;">
						 			₩ 3,000,000,000<!-- 연봉총액 -->
						 		</font>
					 		</td>
					 		<td width="25%" style="line-height:130%">
					 			월 급여
					 			<br/><font style="font-size:11px;">(연봉총액 / 13개월)</font>
					 		</td>
					 		<td width="20%">
						 		<font style="font-size:14px; line-height:130%;">
						 			₩ 23,076,930<!-- 월급여 -->
						 		</font>
					 		</td>
					 	</tr>
					 </table>
				 </center>					
			</td>
		</tr>
		
		<tr>
			<td class="header">구성항목</td>
			<td colspan="4"  class="comment">
				월 급여의 구성항목은 아래와 같으며, 근로자는 사전에 아래와 같이 
				<br/>법정기준시간을 초과한 연장근로에 동의하며 월 급여에 연장근로시간 대한 
				<br/>임금 및 가산수당이 모두 포함되어 있음을 확인하였고, 근로자는 이와 같은 
				<br/>법정 제수당이 포함되어 있는 포괄임금산정방식에 동의한다. 
				<span style="line-height: 100%">
					<br/>
					<br/>동의자 
					홍길동 (서명)
				</span> 
				<br/><br/>
				 
				<table class="innerTable">
					<tr>
						<td class="innerHeader">기본급</td>
				 		<td width="20%">1,258,162</td>
				 		<td class="innerHeader">주휴수당</td>
				 		<td width="20%">311,633</td>
				 	</tr>
				 	<tr>
				 		<td class="innerHeader">연장근로 및 가산수당</td>
				 		<td width="20%">437,898</td>
				 		<td class="innerHeader" style="line-height:100%">차량유지비 <br/>또는 교통비</td>
				 		<td width="20%">200,000</td>
				 	</tr>
				 	<tr>
				 		<td class="innerHeader">식대</td>
				 		<td width="20%">100,000</td>
				 		<td></td>
				 		<td></td>
				 	</tr>
				 	<tr>
				 		<td class="innerHeader">월 급여 합계</td>
				 		<td colspan="3">2,307,693</td>
				 	</tr>
				 </table>
			</td>
		</tr>
		
		<tr>
			<td class="header">계산 방법</td>
			<td colspan="4"  class="comment"> 
				임금 및 법정 제수당의 계산방법은 다음과 같다.
				<font color="RED" style="font-size:14px;">
					<br/>
					- 기본급은 월 174시간, (유급)주휴수당은 월 34.8시간을 기준으로 산정하여 지급한다
					<br/>
					- 연장근로 및 가산수당은 월평균 32.6시간 (150%할증 - 48.9시간)을 기준으로 
					<br/>&nbsp;&nbsp;&nbsp;산정하여 지급한다.
				</font>
			</td>
		</tr>
		
		<tr>
			<td class="header">기타</td>
			<td colspan="4"  class="comment">
				근로자의 결근, 지각, 조퇴, 외출, 사전 약정한 연장 근로시간 미만 근로 등의 
				<br/>발생시에는 해당시간분의 임금(가산임금포함)은 공제한다. 
			</td>
		</tr>
	</table>
	
	<table class="tg2" style="page-break-before :always;">
		<tr>
			<td class="header" width="121px;" rowspan="4">2. 근로조건</td>
			<td class="header" width="122px;">
				시용수습기간
				<br/>
				<font style="font-size:12px;">
					(신규입사자의 경우)
				</font>
			</td>
			<td colspan="5"  class="comment" >
				최초 입사 후 최초 3개월을 시용수습기간으로 정할 수 있으며 시용수습기간 중 급여 등 근로조건은 
				<br/><font color="RED">별도 계약서작성을 통해 정한다.</font> 
				<br/> 다만, 근로자의 직무능력이 충분하다고 사용자가 판단한 경우에는 적용하지 않는다.								
			</td>
		</tr>
		
		<tr>
			<td class="header">근무 조건</td>
			<td colspan="5"  class="comment">
				가. 소정근무요일 및 소정근로시간은  평일(월~금) 09:00 ~ 18:00 으로 정한다.
				<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;다만, 사업운영, 계절적 요인, 근무부서의 형편, 업무의 필요 등에 따라 조정할 수 있으며, 
				<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;근로자는 이에 동의한다.						
				<br/>나. 가목의 소정근무시간 내 1일 휴게시간은 12:00 ~ 13:00 으로 한다.(중식시간 포함)
				<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;휴게시간은 업무형편 등 제반여건에 따라 조정하거나 분할하여 사용할 수 있다.							
				<br/>다. 가목의 소정근로시간<font style="font-size:13px;">(나목의 휴게시간제외)</font>외 추가 연장근로시간은 월평균 32.6 시간으로 합의한다.								
				<br/>라. 사용자는 사업운영상 필요한 경우 근로자에게 다목에서 사전 약정한 연장근로에 추가하여 
				<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;연장근로, 휴일근로, 야간근로를 지시할 수 있으며 근로자는 이에 동의한다.								
				<br/>마. 근로자가 출장 등 근로시간의 일부 또는 전부를 사업장밖에서 업무를 수행하여 근로시간을 
				<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;산정하기 어려운 때에는 소정근로시간을 근로한 것으로 본다.								
				<br/>바. 근로일 및 근로시간, 휴게시간 등은 회사사정 및 근무여건에 따라 변경하여 운용될 수 있다.								
			</td>
		</tr>
		
		<tr>
			<td class="header">휴일 / 휴가</td>
			<td colspan="5"  class="comment">
				가. 주휴일은 매주 일요일로 하며, 1주간의 소정근로일을 개근한 경우 유급으로 부여한다.								
				<br/>나. 소정근무일이 아닌 토요일은 무급휴무일로 하며, 근로자의 날은 법령에 따라 유급으로 부여한다.								
				<br/>다. 사용자는 사전에 약정한 연장, 휴일, 야간 근로시간을 초과한 근로시간이 발생할 경우 
				<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;근로기준법 제57조에 따른 보상휴가제를 실시할 수 있다. 	
				<br/>라. 연차유급휴가와 기타 휴가, 휴일에 대해서는 관계법령 및 취업규칙 등에서 정한 바에 따른다.								
			</td>
		</tr>
		<tr>
			<td class="header">퇴직</td>
			<td colspan="5"  class="comment">
				가. 근로자는 근무 중 퇴직하고자 할 경우에는 퇴직예정일로 부터 1개월 전에 퇴직원을 제출하고 
				<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;후임자를 선임하여 업무 인수인계를 완료할 때까지 성실하게 근무하여야 한다.								
				<br/>나. 근로자는 사용자가 승인인한 경우를 제외하고 업무인수인계서를 작성하여 결재를 득하여야 하며, 
				<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;이러한 의무를 위반하여 사용자에게 손해가 발생한 경우 근로자는 월 지급총액(30일기준)의 5배를 
				<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;그 손해액으로 배상하여야 한다.								
				<br/>다. 퇴직급여는 취업규칙 및 근로자퇴직급여보장법에 의한다.								
				<br/>라. 기간의 정함이 있는 근로계약을 체결한 경우 기간의 만료로 근로계약은 자동 종료한다.								
			</td>
		</tr>
		
		<tr>
			<td class="header">3. 근로계약해지</td>
			<td colspan="6"  class="comment">
				사용자는 아래의 사유가 발생할 경우 근로계약을 해지할 수 있다.								
				<br/>가. 취업규칙 등 회사의 제반 규정 또는 정당한 업무명령 등을 위반하였을 때								
				<br/>나. 업무를 태만히 하거나 업무수행능력 부족 또는 건강상의 장애 등으로 업무를 감당하기 어려울 때 								
				<br/>다. 회사 규정에 의한 징계 혹은 근로관계 해지사유 발생 및 기타 사회통념상 계속근로관계를 유지하는 것이 어렵다고
				<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;인정될 때  								
			</td>
		</tr>
		<tr>
			<td class="header">4. 기타</td>
			<td colspan="6"  class="comment">
				가. 근로자는  본 근로계약에 관한 사항, 급여명세 및 연봉금액은 다른 직원에게 공개하지 않는 등 비밀의무를 준수해야 하며, 
				<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;이를 위반할 경우 근로자는 이로 인한 모든 불이익을 감수한다.								
				<br/>나. 근로자는 회사 재직기간 중 지득한 모든 정보자산 등을 사용자의 동의 없이 어떠한 경우에도 이를 사적으로 이용하거나 
				<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제3자에게 누설할 수 없으며, 근로자는 이를 위반하여 회사에 손해를 끼친 경우에는 민사,형사, 행정상 일체의
				<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;법적책임을 진다.								
				<br/>다. 시간외 근로(연장, 야간, 휴일근로)는 회사의 지시나 승인을 받은 시간만을 기준으로 한다.								
				<br/>라. 근로자의 고의 또는 과실로 사용자에게 손해를 미친 경우, 사용자는 근로자에게 손해배상근로자 청구할 수 있다.								
				<br/>마. 본 계약서에 명시하지 않은 사항은 취업규칙, 관계법령 및 기타 관례에 따른다.								
			</td>
		</tr>
		<tr>
			<td colspan="7" style="padding-top:30px;padding-bottom:0px;text-align:center;border-bottom: 0px;">
				2016 년      월      일<!-- 작성연월일 -->
				<br />										
				<br/>사용자와 근로자는 상기 사항에 대하여 이의가 없음을 확인하고 근로계약을 체결합니다.										
			</td>
		</tr>
		<tr>
			<td colspan="3" class="header2" style="border-right: 0; border-top: 0; padding-top: 0px;">
				(사용자)&nbsp;&nbsp;&nbsp;<img src="./resources/ne_img/sign_salary.jpg" />
			</td>
			<td style="border: 0">
				<br/><br/><br/><br/><br/><br/><br/>
			</td>
			<td colspan="3" class="header2" style="border-left: 0; border-top: 0; padding-top: 0px">
				(근로자) 홍길동 (사인)
				<!-- 이름 사인 -->
			</td>
		</tr>
		<tr>
			<td colspan="7" style="border-bottom: 0;">
				<font style="font-size:13px;padding-left:5px; ">
					※ 근로자는 위 연봉근로계약서에 관한 내용을 충분히 이해하고 동의하며,  위와 같은 연봉근로계약을 체결한 후 동 연봉근로계약서를 사용자로부터 교부받았음을 확인함.   
				</font>
			</td>
		</tr>
		<tr>
			<td colspan="7" align="right" style="padding-right: 40px; font-size: 13px; border-top:0;">
				<br/>
				근로자 홍길동 (서명)
				<br/><br/>
			</td>
		</tr>
	</table>
</center>	
</body>


</html>
