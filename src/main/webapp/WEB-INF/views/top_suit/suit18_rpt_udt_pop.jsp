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
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<script>
		$(document).ready(function(){
	
			/* 기본값 셋팅 */
			$("input:radio[name='d4']:radio[value='${suimSuit_18Vo.d4}']").prop('checked', true);
			$("input:radio[name='d6']:radio[value='${suimSuit_18Vo.d6}']").prop('checked', true);
			$("input:radio[name='d8']:radio[value='${suimSuit_18Vo.d8}']").prop('checked', true);
			$("input:radio[name='d17']:radio[value='${suimSuit_18Vo.d17}']").prop('checked', true);
			$("input:radio[name='d18']:radio[value='${suimSuit_18Vo.d18}']").prop('checked', true);
			
			$("#editeOkBtn").click(function(){

				$.post("./suit18RptEditeOk",
						{	 
							 suimRptNo	        :'${suimSuit_18Vo.suimRptNo}'
							,d4 	        	:$("input:radio[name='d4']:checked").val()
							,d6 	        	:$("input:radio[name='d6']:checked").val()
							,d8 	        	:$("input:radio[name='d8']:checked").val()
							,d17 	        	:$("input:radio[name='d17']:checked").val()
							,d18 	        	:$("input:radio[name='d18']:checked").val()
							,b1					:$("#b1").val()
							
							,c2					:$("#c2").val()
							,c4					:$("#c4").val()
							,c6					:$("#c6").val()
							,c7					:$("#c7").val()
							,c8					:$("#c8").val()
							,c10				:$("#c10").val()
							
							,d1					:$("#d1").val()
							,d2					:$("#d2").val()
							,d3					:$("#d3").val()
							,d5					:$("#d5").val()
							,d7					:$("#d7").val()
							,d9					:$("#d9").val()
							,d10				:$("#d10").val()
							,d11				:$("#d11").val()
							,d12				:$("#d12").val()
							,d13				:$("#d13").val()
							,d14				:$("#d14").val()
							,d15				:$("#d15").val()
							,d16				:$("#d16").val()
							,d19				:$("#d19").val()
							,d20				:$("#d20").val()
							
							
							
						},
						function(data,status){
							if(status == "success"){
								if(data == 0){
									alert("저장 실패하였습니다. 관리자에게 문의해 주세요.");
								}else{
									alert("저장되었습니다.");
									if(confirm("창을 닫으시겠습니까?")){
										window.close();
									}
								}
							}else{
								alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
							}
						}//function
				);//post
			});
			
			
			$("#cancelBtn").click(function(){
				window.close();
			});
			
			
			
		}); //document.ready()
		
		
	</script>
	<style>
		.tableStyle2 td{
			letter-spacing: 0px !important;
		}
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
				<font color="white"><b><span style="font-size:11pt;"> 계약적부 보고서작성</span></b></font>
			</div>
		</div>
	</div>
	<!-- //header -->

	<!-- center -->
	<div id ="container">
		<div class="contetnsPop">
			<div class="center_cnt">
				<div class="centercnt_bot1-3">
					<div class="guest">
						<div class="guestTap">
							<ul>
								<li class="on"><a href="#">보고서 작성</a></li>
							</ul>
						</div>

						<!-- 관련업체 멤버 정보 컨텐츠 탭 -->
						<div class="guestcnt5" style="display:block;">
							<div class= "tableStyle6">
								<input type="hidden" value = "${suimSuit_18Vo.suimRptNo}" id = "suimRptNo"/>
								<table align="center" cellpadding="0" cellspacing="0" width="100%"  >
				                    <tr>
				                        <td width="100%">
				                            <p><B><font color="black">1. 보험계약사항</font></B></p>
											<table align="center" cellpadding="0" cellspacing="0" width="100%" class="suitRptTable">
											    <colgroup>
													<col width="5%">
													<col width="15%">
													<col width="34%">
													<col width="8%">
													<col width="38%">
												</colgroup>
											    <tr>
											    	<td bgcolor="#F3F3FF" class="td" nowrap >
											            <p align="center"><B><font color="black">부호</font></B></p>
											        </td>
											        <td bgcolor="#F3F3FF" class="td" nowrap >
											            <p align="center"><B><font color="black">구분</font></B></p>
											        </td>
											        <td bgcolor="#F3F3FF" class="td" nowrap  colspan="3">
											            <p align="center"><B><font color="black">계약사항</font></B></p>
											        </td>
											    </tr>
											    <tr>
											    	<td class="td" nowrap bgcolor="#F3F3FF">
											            <p align="center"><font color="black">1</font></p>
											        </td>
											        <td class="td" nowrap bgcolor="#F3F3FF">
											            <p align="center"><font color="black">계약자명(업체명)</font></p>
											        </td>
											        <td class="td" colspan="3">
														<p align="center">***</p>
											        </td>
											    </tr>
											    <tr>
											    	<td class="td" nowrap bgcolor="#F3F3FF">
											            <p align="center"><font color="black">2</font></p>
											        </td>
											        <td class="td" bgcolor="#F3F3FF">
											            <p align="center"><font color="black">소재지</font></p>
											        </td>
											        <td class="td" colspan="3">
														<p align="center">******************</p>
											        </td>
											    </tr>
											    <tr>
											    	<td class="td" nowrap bgcolor="#F3F3FF">
											            <p align="center"><font color="black">3</font></p>
											        </td>
											        <td class="td" bgcolor="#F3F3FF">
											            <p align="center"><font color="black">가입업종</font></p>
											        </td>
											        <td class="td">
														<p>${suimSuit_18Vo.bd1G}</p>
											        </td>
											        <td bgcolor="#F3F3FF">
											        	<p align="center">요율직종</p>
											        </td>
											        <td>
											        	<p>${suimSuit_18Vo.bd1H}</p>
											        </td>
											    </tr>
											</table>
				                            <p>&nbsp;</p>
				                            <p><B><font color="black">2. 실사일시 및 중점 점검 요청 항목</font></B></p>
				                            <p>&nbsp;&nbsp;&nbsp;&nbsp;가. 실사일시</p>
											<table align="center" cellpadding="0" cellspacing="0" width="100%" class="suitRptTable">
												<colgroup>
													<col width="20%">
													<col width="30%">
													<col width="20%">
													<col width="30%">
												</colgroup>
											    <tr>
											        <td bgcolor="#F3F3FF" class="td">
											            <p align="center"><B><font color="black">구분</font></B></p>
											        </td>
											        <td bgcolor="#F3F3FF" class="td" colspan="3">
											            <p align="center"><B><font color="black">내용</font></B></p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td">
											            <p align="center"><font color="black">실사일</font></p>
											        </td>
											        <td class="td" colspan="3" >
														<p>
															${suimSuit_18Vo.bd1J}  
														</p>
											        </td>
										        </tr>
										        <tr>
											        <td class="td">
			                                        <p align="center"><font color="black">실사자</font></p>
											        </td>
											        <td class="td" colspan="3" >
											            <p>${suimSuit_18Vo.userName}</p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td">
											            <p align="center"><font color="black">면담자(피보험자와 관계)</font></p>
											        </td>
											        <td class="td">
														<p>
															${suimSuit_18Vo.bd1I}
						                                </p>
											        </td>
											        <td class="td" bgcolor="#F3F3FF">
			                                        	<p align="center"><font color="black">면담자연락처</font></p>
											        </td>
											        <td class="td">
														<p>
															<%-- 이정호 과장 요청사항으로 항목 수정 (20240906) --%>
															<%-- <input type=text name="b1" id = "b1" value="${suimSuit_18Vo.b1}" class="input" value="" size="15" maxlength="15" onKeyPress="if ((event.keyCode<46)||(event.keyCode>57)||(event.keyCode==47)) event.returnValue=false;" style="ime-mode:disabled"> --%>
															<input type=text name="b1" id = "b1" value="${suimSuit_18Vo.clerkHndPhoneNo}" class="input" value="" size="15" maxlength="15" onKeyPress="if ((event.keyCode<46)||(event.keyCode>57)||(event.keyCode==47)) event.returnValue=false;" style="ime-mode:disabled">
														</p>
											        </td>
											    </tr>
											</table>
				                            
				                            <p>&nbsp;</p>
				                            <p>&nbsp;&nbsp;&nbsp;&nbsp;나. 중점요청항목</p>
				                            <table align="center" cellpadding="0" cellspacing="0" width="100%" class="suitRptTable">
												<colgroup>
													<col width="40%">
													<col width="60%">
												</colgroup>
											    <tr>
											        <td bgcolor="#F3F3FF" class="td">
											            <p align="center"><B><font color="black">구분</font></B></p>
											        </td>
											        <td bgcolor="#F3F3FF" class="td" >
											            <p align="center"><B><font color="black">중점 점검 요청 항목</font></B></p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td">
											            <p align="center"><font color="black">1</font></p>
											        </td>
											        <td class="td" >
														<p>
															${suimSuit_18Vo.memo1}  
														</p>
											        </td>
										        </tr>
										        <tr>
											        <td class="td">
			                                        <p align="center"><font color="black">2</font></p>
											        </td>
											        <td class="td" >
											            <p>${suimSuit_18Vo.memo2}</p>
											        </td>
											    </tr>
											</table>
				                            <p>&nbsp;</p>
				                            <p><B><font color="black">3. 계약사항과 주요항목</font></B></p>
											<table align="center" cellpadding="0" cellspacing="0"  class="suitRptTable">
											
												<colgroup>
													<col width="10%">
													<col width="35%">
													<col width="20%">
													<col width="10%">
													<col width="20%">
												</colgroup>
											    <tr>
											        <td bgcolor="#F3F3FF" class="td">
											            <p align="center"><B><font color="black">구분</font></B></p>
											        </td>
											        <td bgcolor="#F3F3FF" class="td">
											            <p align="center"><B><font color="black">계약사항</font></B></p>
											        </td>
											        <td bgcolor="#F3F3FF" class="td">
											            <p align="center"><B><font color="black">확인</font></B></p>
											        </td>
											        <td bgcolor="#F3F3FF" class="td">
											            <p align="center"><B><font color="black">일치여부</font></B></p>
											        </td>
											        <td bgcolor="#F3F3FF" class="td">
											            <p align="center"><B>내 &nbsp;&nbsp;&nbsp;용</B></p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" nowrap bgcolor="#F3F3FF">
											            <p align="center"><font color="black">건물급수</font></p>
											        </td>
											        <td class="td">
														<p align="center">
															<c:if test="${suimSuit_18Vo.bd1F ne ''}">
																${suimSuit_18Vo.bd1F} 급
															</c:if>
														</p>
											        </td>
											        <td class="td">
														<p align="center">
															<c:if test="${suimSuit_18Vo.bd1K ne ''}">
																${suimSuit_18Vo.bd1K} 급
															</c:if>
														</p>
											        </td>
											        <td class="td">
														<p align="center">
															<c:choose>
																<c:when test="${suimSuit_18Vo.report6 eq 1}">
																	■
																</c:when>
																<c:when test="${suimSuit_18Vo.report6 eq 2}">
																	□
																</c:when>
															</c:choose>		
														</p>
											        </td>
											        <td class="td">
														<p align="center"><input type=text name="c2" id="c2" class="input" value="${suimSuit_18Vo.c2} " size="17"></p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" bgcolor="#F3F3FF">
											            <p align="center"><font color="black">가입업종</font></p>
											        </td>
											        <td class="td">
														<p align="center">${suimSuit_18Vo.bd1G}</p>
											        </td>
											        <td class="td">
														<p align="center">${suimSuit_18Vo.bd1L}</p>
											        </td>
											        <td class="td">
														<p align="center">
															<c:choose>
																<c:when test="${suimSuit_18Vo.report7 eq 1}">■</c:when>
																<c:when test="${suimSuit_18Vo.report7 eq 2}">□</c:when>
															</c:choose>
														</p>
											        </td>
											        <td class="td">
														<p align="center"><input type=text name="c4" id="c4" class="input" value="${suimSuit_18Vo.c4}" size="17"></p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" bgcolor="#F3F3FF">
											            <p align="center"><font color="black">요율업종</font></p>
											        </td>
											        <td class="td">
														<p align="center">${suimSuit_18Vo.bd1H}</p>
											        </td>
											        <td class="td">
														<p align="center">${suimSuit_18Vo.bd1M}</p>
											        </td>
											        <td class="td">
														<p align="center">
															<c:choose>
																<c:when test="${suimSuit_18Vo.report8 eq 1}">■ </c:when>
																<c:when test="${suimSuit_18Vo.report8 eq 2}">□ </c:when>
															</c:choose>
														</p>
											        </td>
											        <td class="td">
														<p align="center"><input type=text name="c6" id="c6" class="input" value="${suimSuit_18Vo.c6}" size="17"></p>
											        </td>
											        
											    </tr>
											    <tr>
											        <td class="td" bgcolor="#F3F3FF">
											            <p align="center"><font color="black">소재지</font></p>
											        </td>
											        <td class="td">
														<p align="center">*****</p>
											        </td>
											        <td class="td">
											        	<%-- 김성호과장 요청사항으로 항목 수정 (20240909) --%>
														<%-- <p align="center"><input type=text name="c7" id="c7" class="input" value="${suimSuit_18Vo.c7}" size="17"></p> --%>
														<p align="center"><input type=text name="c7" id="c7" class="input" value="${suimSuit_18Vo.bd1D}" size="17"></p>
											        </td>
											        <td class="td">
														<p align="center">
															<c:choose>
																<c:when test="${suimSuit_18Vo.report5 eq 1}">■ </c:when>
																<c:when test="${suimSuit_18Vo.report5 eq 2}">□ </c:when>
															</c:choose>
														</p>
											        </td>
											        <td class="td">
														<p align="center"><input type=text name="c8" id="c8" class="input" value="${suimSuit_18Vo.c8}" size="17"></p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" bgcolor="#F3F3FF">
				                                        <p align="center"><span style="font-size:9pt;"><font color="black">피보험자</font></span></p>
				                                        <p align="center"><span style="font-size:9pt;">(소유자)</span></p>
											        </td>
											        <td class="td">
														<p align="center">***</p>
											        </td>
											        <td class="td">
														<p align="center">${suimSuit_18Vo.bd1N}</p>
											        </td>
											        <td class="td">
														<p align="center">
															<c:choose>
																<c:when test="${suimSuit_18Vo.report4 eq 1}">■</c:when>
																<c:when test="${suimSuit_18Vo.report4 eq 2}">□</c:when>
															</c:choose>
														</p>
											        </td>
											        <td class="td">
														<p align="center"><input type=text name="c10" id="c10" class="input" value="${suimSuit_18Vo.c10}" size="17"></p>
											        </td>
											    </tr>
											</table>
				                            <p>&nbsp;</p>
				                            <p><B><font color="black">4. 적부조사 의견</font></B></p>
											<table align="center" cellpadding="0" cellspacing="0"  class="suitRptTable">
												<colgroup>
													<col width="20%">
													<col width="80%">
												</colgroup>
											    <tr>
											        <td bgcolor="#F3F3FF" class="td" colspan="2">
											            <p><B>&nbsp;○ 건물구조확인</B></p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" width="100" nowrap>
											            <p align="center">건 &nbsp;&nbsp;물 &nbsp;&nbsp;구 &nbsp;&nbsp;조</p>
											            <p align="center">(판넬및천막유무)</p>
											        </td>
											        <td class="td" width="500">
											            <p >${suimSuit_18Vo.bd1K} 급
											            	(기둥 : <input type=text name="d1" id="d1" class="input" value="${suimSuit_18Vo.d1}" size="15"/> 
											            	 , 외벽 : <input type=text name="d2" id="d2" class=input value="${suimSuit_18Vo.d2}" size="15"/> 
											            	 , 지붕 : <input type=text name="d3" id="d3" class=input value="${suimSuit_18Vo.d3}" size="15"/> )
											            </p>
											            <p>
											            	패널( <input type="radio" name="d4" class='btn' value='1' /> 유 <input type="radio" name="d4" class='btn' value='0' />
											            	무 / 위치 : <input type=text name="d5" id ="d5" class=input value="${suimSuit_18Vo.d5}" size="20"/>) 
											            </p>
											            <p>
											            	천막( <input type="radio" name="d6" class='btn' value='1' /> 유 <input type="radio" name="d6" class='btn' value='0' /> 
											            	무 / 위치 : <input type=text name="d7" id ="d7" class=input value="${suimSuit_18Vo.d7}" size="20"/>)
											            </p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td">
											            <p align="center">층&nbsp;별&nbsp;방&nbsp;화&nbsp;구&nbsp;획</p>
											        </td>
											        <td class="td">
											            <p>
												            <input type="radio" name="d8" class='btn' value='1'/>있음
												            <input type="radio" name="d8" class='btn' value='0'/>없음
											            </p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td">
											            <p align="center">건&nbsp;물&nbsp;확&nbsp;인&nbsp;의&nbsp;견</p>
											        </td>
											        <td class="td">
											            <p><input type=text name="d9" id="d9" class="input" value="${suimSuit_18Vo.d9}" size="50"></p>
											        </td>
											    </tr>
											</table>
											<p>&nbsp;</p>
											<table align="center" cellpadding="0" cellspacing="0"  class="suitRptTable">
												<colgroup>
													<col width="20%">
													<col width="80%">
												</colgroup>
											    <tr>
											        <td bgcolor="#F3F3FF" class="td" colspan="2">
											            <p><B>&nbsp;○ 업종확인</B></p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" width="100" nowrap>
											            <p align="center">층&nbsp;별&nbsp;영&nbsp;위&nbsp;업&nbsp;종</p>
											        </td>
											        <td class="td" width="500">
											            <p>1. 층별업종 지층:<input type=text name="d10" id="d10" class=input value="${suimSuit_18Vo.d10}" size="40"></p>
											            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1층:<input type=text name="d11" id="d11" class=input value="${suimSuit_18Vo.d11}" size="70"></p>
											            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2층:<input type=text name="d12" id="d12" class=input value="${suimSuit_18Vo.d12}" size="70"></p>
											            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3층:<input type=text name="d13" id="d13" class=input value="${suimSuit_18Vo.d13}" size="70"></p>
											            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4층:<input type=text name="d14" id="d14" class=input value="${suimSuit_18Vo.d14}" size="70"></p>
											            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5층:<input type=text name="d15" id="d15" class=input value="${suimSuit_18Vo.d15}" size="70"></p>
											            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5층이상:<input type=text name="d16" id="d16" class=input value="${suimSuit_18Vo.d16}" size="70"></p>
											            <p>2. 다음 업종에 해당되는 경우 체크 및 입력</p>
											            <p>&nbsp;&nbsp;2_1. 판매시설</p>
											            <p>&nbsp;&nbsp;&nbsp;-상설할인 매장 여부 : <input type="radio" name="d17" class='btn' value='1' >있음 
											                                        <input type="radio" name="d17" class='btn' value='0' >없음</p>
											            <p>&nbsp;&nbsp;&nbsp;-재래시장 여부 : <input type="radio" name="d18" class='btn' value='1' >있음 
											                                        <input type="radio" name="d18" class='btn' value='0' >없음</p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td">
											            <p align="center">업 종&nbsp;확&nbsp;인&nbsp;의&nbsp;견</p>
											        </td>
											        <td class="td">
											            <p><input type=text name="d19" id="d19" class=input value="${suimSuit_18Vo.d19}" size="50"></p>
											        </td>
											    </tr>
											</table>
											<p>&nbsp;</p>
											<p>&nbsp;</p>
											<table align="center" cellpadding="0" cellspacing="0"  class="suitRptTable">
												<colgroup>
													<col width="20%">
													<col width="80%">
												</colgroup>
											    <tr>
											        <td bgcolor="#F3F3FF" class="td" colspan="2">
											            <p><B>&nbsp;○ 목적물 확인</B></p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" width="100" nowrap>
											            <p align="center">소재지 확인의견</p>
											        </td>
											        <td class="td" width="500">
														<p>
															<c:choose>
																<c:when test="${suimSuit_18Vo.report5 eq 1 }">■</c:when>
																<c:when test="${suimSuit_18Vo.report5 eq 2 }">□</c:when>
															</c:choose>	
															일치  &nbsp;&nbsp;
															<c:choose>
																<c:when test="${suimSuit_18Vo.report5 eq 1 }">□</c:when>
																<c:when test="${suimSuit_18Vo.report5 eq 2 }">■</c:when>
															</c:choose>	
															불일치 
														</p>
														<%-- 이정호 과장 요청사항으로 항목 수정 (20240906) --%>														
											            <%-- <p>- 의견 :<input type=text name="d20" id="d20" class=input value="${suimSuit_18Vo.d20}" size="50"></p> --%>
											            <p>- 의견 :<input type=text name="d20" id="d20" class=input value="${suimSuit_18Vo.bd1D}" size="50"></p>
											        </td>
											    </tr>
											</table>
											
				                            <p><B><font color="black">○ 실사 사진 </font></B></p>
											<table align="center" cellpadding="0" cellspacing="0" class="suitRptTable">
												<tr>
													<td width="30%" align="center">
														<b>※ 파일 선택</b>
													</td>
													<td>
														<%@include file="../include/uploadform_suit18_pic.jsp"%>
													</td>
												</tr>
											</table>
											<table  align="center" cellpadding="0" cellspacing="0" class="suitRptTable">
												<colgroup>
													<col width="70%">
													<col width="30%">
												</colgroup>
												<tr>
													<td colspan="2" align="center"><font color="blue">사진 목록</font></td>
												</tr>
												<tbody id = "suit18FileListBody" style="margin-bottom:20px;">
													<input type="hidden" id="fileListSize" value="${fileListSize}" />
													<c:forEach items="${suimSuit_18_FileList}" var="suit18FileVo">
														<tr id = "suit18ImgTr_${suit18FileVo.serialNo}">
															<td align="center" class="suit10Preview"> 
																${suit18FileVo.fileName}
															</td>
															<td align="center">
					 											<img src='./resources/ls_img/btn_del.gif' id = 'suit18ImgDelBtn_${suit18FileVo.serialNo}' 
					 												onclick="suit18ImgSubDel('${suit18FileVo.serialNo}','${suit18FileVo.suimRptNo}','${suit18FileVo.fileName}');" style='cursor:pointer;'/>
															</td>
														</tr>
													</c:forEach>												
												</tbody>
											</table>
										</td>
									</tr>
							</table>
								
							</div>
							<br>
							<p align="center">
								<img id="editeOkBtn" src="./resources/ls_img/btn_ok.gif" alt="저장" style ="cursor:pointer" />
								<img id="cancelBtn" src="./resources/ls_img/btn_cancel.gif" alt="취소" style ="cursor:pointer" />
							</p>
						</div><!-- //guest -->
					</div><!-- //bot1-3 -->
				</div>
			</div>
		</div>
	<!--//center -->
	</div>
	<!-- footer -->
	<c:import url="../top_main/top_pop_footer.jsp"></c:import>
	<!-- //footer -->

</body>