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
	
			/* b2코드 선택 상자 초기화 */
			$("#b2Code").html("");
			$("#b2Code").append(scsel_B2CODE());
			if("${suimSuit_10Vo.b2Code}" != ""){
				$("#b2Code option[value='${suimSuit_10Vo.b2Code}']").attr("selected", true);				
			}
			
			/* b3 번호 세팅 */
			$("#b3a").val("${suimSuit_10Vo.b3}".split("-")[0]);
			$("#b3b").val("${suimSuit_10Vo.b3}".split("-")[1]);
			$("#b3c").val("${suimSuit_10Vo.b3}".split("-")[2]);
			
			/* d 셋팅 */
			$("input:radio[name='d2']:radio[value='${suimSuit_10Vo.d2}']").prop('checked', true);
			$("input:radio[name='d4']:radio[value='${suimSuit_10Vo.d4}']").prop('checked', true);
			$("input:radio[name='d6']:radio[value='${suimSuit_10Vo.d6}']").prop('checked', true);
			
			$('#b1').datepicker({ 
		    	   showOn: 'button',
		    	   buttonImage: './resources/ls_img/icon_calendar.gif', //이미지 url
		    	   buttonImageOnly: true,
		    	   buttonText: "달력", 
		    	   changeMonth: true,
		    	   changeYear: true,
		    	   showButtonPanel: false
		    });
			
			$("#editeOkBtn").click(function(){

				$.post("./suit10RptEditeOk",
						{	 
							 suimRptNo	        :'${suimSuit_10Vo.suimRptNo}'
							,b1 	        	:$("#b1").val()
							,b2 	       		:$("#b2").val()
							,b2Code 	        :$("#b2Code").val()
							,b3 	        	:$("#b3a").val()+"-"+$("#b3b").val()+"-"+$("#b3c").val()
							,c1 	        	:$("#c1").val()
							,c2 	        	:$("#c2").val()
							,c3 	        	:$("#c3").val()
							,c4 	        	:$("#c4").val()
							,c5 	        	:$("#c5").val()
							,c6 	        	:$("#c6").val()
							,d1 	        	:$("#d1").val()
							,d16 	        	:$("#d16").val()
							,d2 	        	:$("input:radio[name='d2']:checked").val()
							,d3 	        	:$("#d3").val()
							,d4 	        	:$("input:radio[name='d4']:checked").val()
							,d5 	        	:$("#d5").val()
							,d6 	        	:$("input:radio[name='d6']:checked").val()
							,d7 	        	:$("#d7").val()
							,d8 	        	:$("#d8").val()
							,d9 	        	:$("#d9").val()
							,d10 	        	:$("#d10").val()
							,d11 	        	:$("#d11").val()
							,d12 	        	:$("#d12").val()
							,d13 	        	:$("#d13").val()
							,d14 	        	:$("#d14").val()
							,d15 	        	:$("#d15").val()
							
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
		
		
		function scsel_B2CODE(){
			var b2Code = "";
			b2Code = "<option value='001'>본인</option>"
			+ "<option value='011'>배우자</option>"
			+ "<option value='021'>자녀</option>"
			+ "<option value='024'>손주</option>"
			+ "<option value='027'>태아</option>"
			+ "<option value='028'>친족(가족)</option>"
			+ "<option value='032'>부</option>"
			+ "<option value='033'>모</option>"
			+ "<option value='042'>조부</option>"
			+ "<option value='043'>조모</option>"
			+ "<option value='051'>형제/자매</option>"
			+ "<option value='102'>친구</option>"
			+ "<option value='103'>지인</option>"
			+ "<option value='105'>임직원</option>"
			+ "<option value='106'>법정상속인</option>"
			+ "<option value='107'>고용주</option>"
			+ "<option value='108'>고용운전자</option>"
			+ "<option value='109'>임대차</option>"
			+ "<option value='125'>차량소유주(본인)</option>"
			+ "<option value='126'>차량소유주(본인외)</option>"
			+ "<option value='127'>질권자</option>"
			+ "<option value='239'>채권자</option>"
			+ "<option value='241'>수출입 관계자</option>"
			+ "<option value='242'>고용인(종업원)</option>"
			+ "<option value='245'>각피보험자본인</option>"
			+ "<option value='999'>기타</option>";

			return b2Code;
		}
		
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
				<font color="white"><b><span style="font-size:11pt;"> 계약적부 보고서(일반)</span></b></font>
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
								<input type="hidden" value = "${suimSuit_10Vo.suimRptNo}" id = "suimRptNo"/>
								<table align="center" cellpadding="0" cellspacing="0" width="100%"  >
				                    <tr>
				                        <td width="100%">
				                            <p><B><font color="black">1. 계약사항</font></B></p>
											<table align="center" cellpadding="0" cellspacing="0" width="100%" class="suitRptTable">
											    <tr>
											        <td bgcolor="#F3F3F3" class="td" nowrap width="20%">
											            <p align="center"><B><font color="black">구분</font></B></p>
											        </td>
											        <td bgcolor="#F3F3F3" class="td" nowrap width="80%">
											            <p align="center"><B><font color="black">계약사항</font></B></p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" nowrap bgcolor="#F3F3F3">
											            <p align="center"><font color="black">계약자명</font></p>
											        </td>
											        <td class="td">
														<p>${suimSuit_10Vo.contractorName}</p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" bgcolor="#F3F3F3">
											            <p align="center"><font color="black">소유자명</font></p>
											        </td>
											        <td class="td">
														<p>${suimSuit_10Vo.hostName}</p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" bgcolor="#F3F3F3">
											            <p align="center"><font color="black">소재지</font></p>
											        </td>
											        <td class="td">
														<p>${suimSuit_10Vo.buildingAddr}</p>
											        </td>
											    </tr>
											</table>
				                            <p>&nbsp;</p>
				                            <p><B><font color="black">2. 실사사항</font></B></p>
											<table align="center" cellpadding="0" cellspacing="0" width="100%" class="suitRptTable">
												<colgroup>
													<col width="20%">
													<col width="40%">
													<col width="20%">
													<col width="20%">
												</colgroup>
											    <tr>
											        <td bgcolor="#F3F3F3" class="td">
											            <p align="center"><B><font color="black">구분</font></B></p>
											        </td>
											        <td bgcolor="#F3F3F3" class="td" colspan="3">
											            <p align="center"><B><font color="black">내용</font></B></p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" bgcolor="#F3F3F3" >
											            <p align="center"><font color="black">실사일시</font></p>
											        </td>
											        <td class="td" >
														<p>
															<input type="text" name="b_1" size="10" id="b1" class="input" maxlength="10"  value="${suimSuit_10Vo.b1}" readonly>  
														</p>
											        </td>
											        <td class="td" bgcolor="#F3F3F3" >
			                                        <p align="center"><font color="black">실사자</font></p>
											        </td>
											        <td class="td" >
											            <p>${suimSuit_10Vo.userName}</p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" bgcolor="#F3F3F3">
											            <p align="center"><font color="black">면담자(관계)</font></p>
											        </td>
											        <td class="td">
														<p>
															<input type=text name="b_2" id="b2" class="input" value="${suimSuit_10Vo.b2}" size="10"> 
						                                    (<select name="b2Code" id="b2Code">
						                                    	
						                                    </select>)
						                                </p>
											        </td>
											        <td class="td" bgcolor="#F3F3F3">
			                                        <p align="center"><font color="black">면담자연락처</font></p>
											        </td>
											        <td class="td">
														<p>
															<input type=text name="b_3_a" id = "b3a" class="input" value="" size="3" maxlength="3" onKeyPress="if ((event.keyCode<46)||(event.keyCode>57)||(event.keyCode==47)) event.returnValue=false;" style="ime-mode:disabled">-
															<input type=text name="b_3_b" id = "b3b" class="input" value="" size="4" maxlength="4" onKeyPress="if ((event.keyCode<46)||(event.keyCode>57)||(event.keyCode==47)) event.returnValue=false;" style="ime-mode:disabled">-
															<input type=text name="b_3_c" id = "b3c" class="input" value="" size="4" maxlength="4" onKeyPress="if ((event.keyCode<46)||(event.keyCode>57)||(event.keyCode==47)) event.returnValue=false;" style="ime-mode:disabled">
														</p>
											        </td>
											    </tr>
											</table>
				                            <p>※면담자와의 관계는 소유자와의 관계를 기재</p>
				                            <p>&nbsp;</p>
				                            <p><B><font color="black">3. 계약사항과 실사사항 비교</font></B></p>
											<table align="center" cellpadding="0" cellspacing="0"  class="suitRptTable">
											    <tr>
											        <td bgcolor="#F3F3F3" class="td">
											            <p align="center"><B><font color="black">구분</font></B></p>
											        </td>
											        <td bgcolor="#F3F3F3" class="td">
											            <p align="center"><B><font color="black">계약사항</font></B></p>
											        </td>
											        <td bgcolor="#F3F3F3" class="td">
											            <p align="center"><B><font color="black">확인사항</font></B></p>
											        </td>
											        <td bgcolor="#F3F3F3" class="td">
											            <p align="center"><B><font color="black">일치여부</font></B></p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" nowrap bgcolor="#F3F3F3">
											            <p align="center"><font color="black">건물급수</font></p>
											        </td>
											        <td class="td">
														<p>${suimSuit_10Vo.buildinginfo03} 급</p>
											        </td>
											        <td class="td">
														<p align="center"><input type=text name="c_1" id="c1" class="input" value="${suimSuit_10Vo.c1} " size="20"></p>
											        </td>
											        <td class="td">
														<p>
															<c:choose>
																<c:when test="${suimSuit_10Vo.report6 eq 1}">■ 일치</c:when>
																<c:when test="${suimSuit_10Vo.report6 eq 2}">□ 불일치</c:when>
															</c:choose>
														</p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" bgcolor="#F3F3F3">
											            <p align="center"><font color="black">실제업종</font></p>
											        </td>
											        <td class="td">
														<p>${suimSuit_10Vo.buildinginfo01}</p>
											        </td>
											        <td class="td">
														<p align="center"><input type=text name="c_2" id="c2" class="input" value="${suimSuit_10Vo.c2}" size="20"></p>
											        </td>
											        <td class="td">
														<p>
															<c:choose>
																<c:when test="${suimSuit_10Vo.report7 eq 1}">■ 일치</c:when>
																<c:when test="${suimSuit_10Vo.report7 eq 2}">□ 불일치</c:when>
															</c:choose>
														</p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" bgcolor="#F3F3F3">
											            <p align="center"><font color="black">요율업종</font></p>
											        </td>
											        <td class="td">
														<p>${suimSuit_10Vo.buildinginfo02}</p>
											        </td>
											        <td class="td">
														<p align="center"><input type=text name="c_3" id="c3" class="input" value="${suimSuit_10Vo.c3}" size="20"></p>
											        </td>
											        <td class="td">
														<p>
															<c:choose>
																<c:when test="${suimSuit_10Vo.report8 eq 1}">■ 일치</c:when>
																<c:when test="${suimSuit_10Vo.report8 eq 2}">□ 불일치</c:when>
															</c:choose>
														</p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" bgcolor="#F3F3F3">
											            <p align="center"><font color="black">소재지</font></p>
											        </td>
											        <td class="td">
														<p>${suimSuit_10Vo.buildingAddr}</p>
											        </td>
											        <td class="td">
														<p align="center"><input type=text name="c_4" id="c4" class="input" value="${suimSuit_10Vo.c4}" size="20"></p>
											        </td>
											        <td class="td">
														<p>
															<c:choose>
																<c:when test="${suimSuit_10Vo.report5 eq 1}">■ 일치</c:when>
																<c:when test="${suimSuit_10Vo.report5 eq 2}">□ 불일치</c:when>
															</c:choose>
														</p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" bgcolor="#F3F3F3">
				                                        <p align="center"><span style="font-size:9pt;"><font color="black">소유자</font></span></p>
											        </td>
											        <td class="td">
														<p>${suimSuit_10Vo.hostName}</p>
											        </td>
											        <td class="td">
														<p align="center"><input type=text name="c_5" id="c5" class="input" value="${suimSuit_10Vo.c5}" size="20"></p>
											        </td>
											        <td class="td">
														<p>
															<c:choose>
																<c:when test="${suimSuit_10Vo.report4 eq 1}">■ 일치</c:when>
																<c:when test="${suimSuit_10Vo.report4 eq 2}">□ 불일치</c:when>
															</c:choose>
														</p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" bgcolor="#F3F3F3">
											            <p align="center"><font color="black">중점요청사항</font></p>
											        </td>
											        <td class="td">
														<p>${suimSuit_10Vo.buildingMemo}</p>
											        </td>
											        <td class="td">
														<p align="center"><input type=text name="c_6" id="c6" class="input" value="${suimSuit_10Vo.c6}" size="20"></p>
											        </td>
											        <td class="td">
														<p>
															<c:choose>
																<c:when test="${suimSuit_10Vo.report11 eq 1}">■ 일치</c:when>
																<c:when test="${suimSuit_10Vo.report11 eq 2}">□ 불일치</c:when>
															</c:choose>
														</p>
											        </td>
											    </tr>
											</table>
				                            <p>&nbsp;</p>
				                            <p><B><font color="black">4. 조사의견</font></B></p>
											<table align="center" cellpadding="0" cellspacing="0" class="suitRptTable">
											    <tr>
											        <td bgcolor="#F3F3F3" class="td" colspan="2" width="30%">
											            <p align="center"><B><font color="black">구분</font></B></p>
											        </td>
											        <td bgcolor="#F3F3F3" class="td">
											            <p align="center"><B><font color="black">조사의견</font></B></p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" nowrap bgcolor="#F3F3F3" rowspan="3">
											            <p align="center"><font color="black">구조</font></p>
											        </td>
											        <td class="td" nowrap bgcolor="#F3F3F3">
											            <p align="center"><font color="black">건물구조</font></p>
											        </td>
											        <td class="td">
											            <p><input type=text name="d_16" id="d16" class="input" value="${suimSuit_10Vo.d16}" size="2">급 (<input type=text name="d_1" id="d1" class="input" value="${suimSuit_10Vo.d1}" size="40">)</p>
											            <p>판넬사용여부 (<input type="radio" name="d2"  class='btn' value='1' >유<input type="radio" name="d2" class='btn' value='0' >무 / 위치 : <input type=text name="d_3" id="d3" class="input" value="${suimSuit_10Vo.d3}" size="20">)</p>
											            <p>천막사용여부 (<input type="radio" name="d4"  class='btn' value='1' >유<input type="radio" name="d4" class='btn' value='0' >무 / 위치 : <input type=text name="d_5" id="d5" class="input" value="${suimSuit_10Vo.d5}" size="20">)</p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" nowrap bgcolor="#F3F3F3">
			                                       		 <p align="center"><font color="black">방화구획</font></p>
											        </td>
											        <td class="td">
											            <p>
											            	<input type="radio" name="d6" class='btn' value='1' >구획 
				                                        	<input type="radio" name="d6" class='btn' value='0' >미구획
				                                        </p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" nowrap bgcolor="#F3F3F3">
			                                        	<p align="center"><font color="black">확인의견</font></p>
											        </td>
											        <td class="td">
											            <p><input type=text name="d_7" class="input" id="d7" value="${suimSuit_10Vo.d7}" size="50"></p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" bgcolor="#F3F3F3" rowspan="2">
											            <p align="center"><font color="black">업종</font></p>
											        </td>
											        <td class="td" bgcolor="#F3F3F3">
				                                        <p align="center"><font color="black">층별업종</font></p>
											        </td>
											        <td class="td">
											            <p>1층 : <input type=text name="d_8" id="d8" class="input" value="${suimSuit_10Vo.d8}" size="40"></p>
											            <p>2층 : <input type=text name="d_9" id="d9" class="input" value="${suimSuit_10Vo.d9}" size="40"></p>
											            <p>3층 : <input type=text name="d_10" id="d10" class="input" value="${suimSuit_10Vo.d10}" size="40"></p>
											            <p>4층 : <input type=text name="d_11" id="d11" class="input" value="${suimSuit_10Vo.d11}" size="40"></p>
											            <p>5층 : <input type=text name="d_12" id="d12" class="input" value="${suimSuit_10Vo.d12}" size="40"></p>
											            <p>5층이상 : <input type=text name="d_13" id="d13" class="input" value="${suimSuit_10Vo.d13}" size="40"></p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" bgcolor="#F3F3F3">
				                                        <p align="center"><font color="black">확인의견</font></p>
											        </td>
											        <td class="td">
											            <p><input type=text name="d_14" id="d14" class="input" value="${suimSuit_10Vo.d14}" size="50"></p>
											        </td>
											    </tr>
											    <tr>
											        <td class="td" bgcolor="#F3F3F3" colspan="2">
											            <p align="center"><font color="black">소재지 확인의견</font></p>
											        </td>
											        <td class="td">
											            <p><input type=text name="d_15" id="d15" class="input" value="${suimSuit_10Vo.d15}" size="50"></p>
											        </td>
											    </tr>
											</table>
											
											<p>&nbsp;</p>
				                            <p><B><font color="black">○ 실사 사진 </font></B></p>
											<table align="center" cellpadding="0" cellspacing="0" class="suitRptTable">
												<tr>
													<td width="30%" align="center">
														<b>※ 파일 선택</b>
													</td>
													<td>
														<%@include file="../include/uploadform_suit10_pic.jsp"%>
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
												<tbody id = "suit10FileListBody" style="margin-bottom:20px;">
													<c:forEach items="${suimSuit_10_FileList}" var="suit10FileVo">
														<tr id = "suit10ImgTr_${suit10FileVo.serialNo}">
															<td align="center" class="suit10Preview"> 
																${suit10FileVo.fileName}
															</td>
															<td align="center">
					 											<img src='./resources/ls_img/btn_del.gif' id = 'suit10ImgDelBtn_${suit10FileVo.serialNo}' 
					 												onclick="suit10ImgSubDel('${suit10FileVo.serialNo}','${suit10FileVo.suimRptNo}','${suit10FileVo.fileName}');" style='cursor:pointer;'/>
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