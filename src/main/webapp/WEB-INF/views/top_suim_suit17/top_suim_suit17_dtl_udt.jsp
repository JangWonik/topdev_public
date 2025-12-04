<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1,FF=3,otherUA=4" />
	<title>${title_Session}</title>
	<link rel="stylesheet" type="text/css" href="./resources/wm_css/style.css" />
	<script src="./resources/jquery/jquery.min_1_12.js"></script>
	<script src="./resources/wm_js/common.js"></script>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.structure.min.css"/>
	<link rel="stylesheet" href="./resources/jquery/jquery-ui.theme.min.css"/>
	<script src="./resources/jquery/jquery-ui.min.js"></script>
	<script src="./resources/ne_js/calendar.js"></script>
	<%--<script src="./resources/daum/161109.js"></script>--%>
	<script src="./resources/daum/postcode.v2.js"></script>
	<script src='https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js'></script>
	
	<style>
		.tableStyle2 td{
			letter-spacing: 0px !important;
		}
	</style>
</head>

<script>
	$(document).ready(function(){
		$.ajaxSetup({cache:false});
		if ( "${getSuimSuit17DtlBsc.editYN2}" < 1 ){
			alert("접근 권한이 없습니다.");
			window.close();
			return false;
		}
		
		$("#suimTmMbrPopBtn").click(function(){//담당 팀, 담당 직원 바꾸기 팝업
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=500; //띄울 창의 넓이
			var sh=550;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suimTmMbrPop?gbNo='+$("#gbNoForPop").val()+'&smNo='+$("#smNoForPop").val()+'&tmNo='+$("#tmNoForPop").val(),'SuimTmMbrPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		});//$("#suimTmMbrPopBtn").click

		$("#suimPtnrMbrPopBtn").click(function(){//담당 팀, 담당 직원 바꾸기 팝업
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			var sw=500; //띄울 창의 넓이
			var sh=550;  //띄울 창의 높이
			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			window.open('suimPtnrMbrPop?gbNo='+$("#gbNoForPop").val()+'&smNo='+$("#smNoForPop").val()+'&ptnrNo='+$("#ptnrNoForPop").val(),'SuimTmMbrPop','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
		});//$("#suimPtnrMbrPopBtn").click

	});//$(document).ready

	function openSMS(hpNo){
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		var sw=380; //띄울 창의 넓이
		var sh=533;  //띄울 창의 높이
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		window.open('simpleSMSForm?hpNo='+hpNo,'simpleSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}//openSMS

	function openBrdRefPtnr(ptnrSearch){
		var cw=screen.availWidth;
		var ch=screen.availHeight;
		var sw=1010; //띄울 창의 넓이
		var sh=740;  //띄울 창의 높이
		var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
		var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
		window.open('referencePtnrBoardListPop?ptnrSearch='+ptnrSearch,'simpleSMS','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes');
	}//openSMS
	
	$(document).ready(function(){
		
	/* 취소 버튼 동작 */
	$("#cancel").click(function(){
		history.back();
	});
	/* 수정 확인 버튼 동작 */
	$("#edite").click(function(){
		$.post("./suimSuit17DtlUdtOK",
				{	
					suimRptNo       :$("#suimRptNo").val()  //
					,report1        :$("input:radio[name='report1']:checked").val()  // 
					,reC         	:$("#reC").val()  //
// 					,reF           	:$("#reF").val() //
					,reF           	:"윤경수 전무" //고정
					,reG           	:$("#reG").val() // 
					,reH         	:$("input:radio[name='reH']:checked").val()  // 
					,reI           	:$("#reI").val() // 
					,reJ         	:$("input:radio[name='reJ']:checked").val()  // 
					,reK           	:$("#reK").val() // 
					,reL         	:$("input:radio[name='reL']:checked").val()  //
					,reP         	:$("input:radio[name='reP']:checked").val()  //
					,reQ           	:$("#reQ").val() // 
					,reP         	:$("input:radio[name='reP']:checked").val()  //
					,reT         	:$("input:radio[name='reT']:checked").val()  //
					,reU           	:$("#reU").val() //
					,reV         	:$("input:radio[name='reV']:checked").val()  //
					,reW           	:$("#reW").val() //
					,reX           	:$("#reX").val() //
					,reY           	:$("#reY").val() //
					,reZ           	:$("#reZ").val() //
					,reAa           :$("#reAa").val() //
					,reAb           :$("#reAb").val() //
					,reAc           :$("#reAc").val() //
					
				},
				function(data,status){
					if(status == "success"){
						if(data == 0){
							alert("수정 실패하였습니다. 관리자에게 문의해 주세요.");
						}else{
							alert("수정되었습니다.");
							location.href = "topSuimSuit17Dtl?suimRptNo="+$("#suimRptNo").val();
							window.opener.location.reload();
							//window.location.reload();
						}
					}else{
						alert("시스템 오류 입니다. 잠시 후 다시 시도해 주세요.");
					}
				}//function
		);//post
	});
	});//$(document).ready
</script>

<c:set var="suimRptNo" value="${suimRptNo}"/>
<body>

	<!-- header -->
	<div id="headerpop_mbr">
		<div class="inner clear_v2">
			<h1>
				<img src="./resources/wm_img/common/logo.gif" height="40" alt="top - TRUST OBLIGATION PASSION" />
			</h1>
			<div style="text-align:center;padding-top:10px;"><img src="./resources/ls_img/dotte.gif" width="9" height="9" border="0">
				<font color="white"><b><span style="font-size:11pt;"> 장기 물보험 적부 시스템</span></b></font>
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
								<li class="on"><a href="#">적부(흥국) 기본정보</a></li>
							</ul>
						</div>

						<div class="guestcnt5" style="display:block;">

						<div class= "tableStyle21">
							<table>
								<colgroup>
									<col width="20%">
									<col width="30%">
									<col width="15%">
									<col width="20%">
								</colgroup>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ접수번호</b></td>
									<td colspan="3" style="border-right:0;">
										${getSuimSuit17DtlBsc.suimAcceptNo}
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ처리팀</b></td>
									<td>${getSuimSuit17DtlBsc.teamName}</td>
									<td bgcolor="#E7ECF1"><b>ㆍ처리 담당자</b></td>
									<td style="border-right:0;">
										${getSuimSuit17DtlBsc.userName}
									</td>
								</tr>
								<tr>
									<td bgcolor="#E7ECF1"><b>ㆍ보험사</b></td>
									<td colspan="3">
										${getSuimSuit17DtlBsc.ptnrName}
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>
									<input type="radio" checked="checked">
									조사완료여부</b></td>
									<td colspan="3">
										<input type="radio" name="report1" value="01"
										<c:if test="${getSuimSuit17DtlBsc.report1 eq '01'}">checked="checked"
										</c:if>/>
										조사완료&nbsp;&nbsp;&nbsp;
										<input type="radio" name="report1" value="02"
										<c:if test="${getSuimSuit17DtlBsc.report1 eq '02'}">checked="checked"
										</c:if>/>
										조사실패
									</td>
								</tr>
								<tr>
									<td bgcolor="#FFFFCC"><b>ㆍ설계번호</b></td>
									<td colspan="3">${getSuimSuit17DtlBsc.infoA}</td>
								</tr>
								<tr>
									<td bgcolor="#FFFFCC"><b>ㆍ물건구분명</b></td>
									<td colspan="3">${getSuimSuit17DtlBsc.infoM}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ실사일자</b></td>
									<td colspan="3">
									<input type="text" id="reC" name="reC" value="${getSuimSuit17DtlBsc.reC}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ실사자명</b></td>
									<td colspan="3">${getSuimSuit17DtlBsc.userName}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ실사자 휴대전화번호</b></td>
									<td colspan="3">${mbrVoForBody.handphone}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ책임자명</b></td>
									<td colspan="3">
<%-- 										<input type="text" id="reF" name="reF" value="${getSuimSuit17DtlBsc.reF}"/> --%>
										윤경수 전무
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물급수 확인사항</b></td>
									<td colspan="3">
									<input type="text" maxlength="1" id="reG" name="reG" value="${getSuimSuit17DtlBsc.reG}"/>
									급</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ건물급수 일치여부</b></td>
									<td colspan="3">
										<input type="radio" name="reH" value="Y"
										<c:if test="${getSuimSuit17DtlBsc.reH eq 'Y'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;&nbsp;
										<input type="radio" name="reH" value="N"
										<c:if test="${getSuimSuit17DtlBsc.reH eq 'N'}">checked="checked"
										</c:if>/>
										불일치
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ가입업종 확인사항</b></td>
									<td colspan="3">
									<input type="text" id="reI" name="reI" style="width:98%" value="${getSuimSuit17DtlBsc.reI}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ가입업종 일치여부</b></td>
									<td colspan="3">
										<input type="radio" name="reJ" value="Y"
										<c:if test="${getSuimSuit17DtlBsc.reJ eq 'Y'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;&nbsp;
										<input type="radio" name="reJ" value="N"
										<c:if test="${getSuimSuit17DtlBsc.reJ eq 'N'}">checked="checked"
										</c:if>/>
										불일치
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ요율업종 확인사항</b></td>
									<td colspan="3">
										<input type="text" id="reK" name="reK" style="width:98%" value="${getSuimSuit17DtlBsc.reK}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ요율업종 일치여부</b></td>
									<td colspan="3">
										<input type="radio" name="reL" value="Y"
										<c:if test="${getSuimSuit17DtlBsc.reL eq 'Y'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;&nbsp;
										<input type="radio" name="reL" value="N"
										<c:if test="${getSuimSuit17DtlBsc.reL eq 'N'}">checked="checked"
										</c:if>/>
										불일치
									</td>
								</tr>
								<tr>
									<td bgcolor="#FFFFCC"><b>ㆍ소재지 우편번호</b></td>
									<td colspan="3">${getSuimSuit17DtlBsc.infoAa}</td>
								</tr>
								<tr>
									<td bgcolor="#FFFFCC"><b>ㆍ소재지 주소</b></td>
									<td colspan="3">${getSuimSuit17DtlBsc.infoAb}</td>
								</tr>
								<tr>
									<td bgcolor="#FFFFCC"><b>ㆍ소재지 기타주소</b></td>
									<td colspan="3">
										<img src="./resources/ls_img/ls_report/btns_view.gif" onclick="window.open('suimSuit17DtlView?suimRptNo='+${getSuimSuit17DtlBsc.suimRptNo}+'&data=infoAc','_blank','width=540,height=290,scrollbars=no');" style="cursor:pointer;">
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ소재지 일치여부</b></td>
									<td colspan="3">
										<input type="radio" name="reP" value="Y"
										<c:if test="${getSuimSuit17DtlBsc.reP eq 'Y'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;&nbsp;
										<input type="radio" name="reP" value="N"
										<c:if test="${getSuimSuit17DtlBsc.reP eq 'N'}">checked="checked"
										</c:if>/>
										불일치
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ소유자 확인사항</b></td>
									<td colspan="3">
										<input type="text" id="reQ" name="reQ" style="width:98%" value="${getSuimSuit17DtlBsc.reQ}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ소유자 일치여부</b></td>
									<td colspan="3">
										<input type="radio" name="reR" value="Y"
										<c:if test="${getSuimSuit17DtlBsc.reP eq 'Y'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;&nbsp;
										<input type="radio" name="reR" value="N"
										<c:if test="${getSuimSuit17DtlBsc.reR eq 'N'}">checked="checked"
										</c:if>/>
										불일치
									</td>
								</tr>
								<tr>
									<td bgcolor="#FFFFCC"><b>ㆍ중점요청사항</b></td>
									<td colspan="3">${getSuimSuit17DtlBsc.infoAe}</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ중점요청사항 일치여부</b></td>
									<td colspan="3">
										<input type="radio" name="reT" value="Y"
										<c:if test="${getSuimSuit17DtlBsc.reT eq 'Y'}">checked="checked"
										</c:if>/>
										일치&nbsp;&nbsp;&nbsp;
										<input type="radio" name="reT" value="N"
										<c:if test="${getSuimSuit17DtlBsc.reT eq 'N'}">checked="checked"
										</c:if>/>
										불일치
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ구조건물구조 조사의견</b></td>
									<td colspan="3">
										<input type="text" id="reU" name="reU" style="width:98%" value="${getSuimSuit17DtlBsc.reU}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ구조방화구획 조사의견</b></td>
									<td colspan="3">
										<input type="radio" name="reV" value="Y"
										<c:if test="${getSuimSuit17DtlBsc.reV eq 'Y'}">checked="checked"
										</c:if>/>
										설치&nbsp;&nbsp;&nbsp;
										<input type="radio" name="reV" value="N"
										<c:if test="${getSuimSuit17DtlBsc.reV eq 'N'}">checked="checked"
										</c:if>/>
										미설치
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ구조확인의견</b></td>
									<td colspan="3">
										<input type="text" id="reW" name="reW" style="width:98%" value="${getSuimSuit17DtlBsc.reW}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ업종일반층별업종 조사의견</b></td>
									<td colspan="3">
										<input type="text" id="reX" name="reX" style="width:98%" value="${getSuimSuit17DtlBsc.reX}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ업종일반 확인의견</b></td>
									<td colspan="3">
										<input type="text" id="reY" name="reY" style="width:98%" value="${getSuimSuit17DtlBsc.reY}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ업종공장공정 조사의견</b></td>
									<td colspan="3">
										<input type="text" id="reZ" name="reZ" style="width:98%" value="${getSuimSuit17DtlBsc.reZ}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ업종공장생산품 조사의견</b></td>
									<td colspan="3">
										<input type="text" id="reAa" name="reAa" style="width:98%" value="${getSuimSuit17DtlBsc.reAa}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ업종공장 확인의견</b></td>
									<td colspan="3">
										<input type="text" id="reAb" name="reAb" style="width:98%" value="${getSuimSuit17DtlBsc.reAb}"/>
									</td>
								</tr>
								<tr>
									<td bgcolor="#DCFFDC"><b>ㆍ소재지 확인의견</b></td>
									<td colspan="3">
										<input type="text" id="reAc" name="reAc" style="width:98%" value="${getSuimSuit17DtlBsc.reAc}"/>
										<input type="hidden" id="suimRptNo" name="suimRptNo" value="${suimRptNo}"/>
									</td>
								</tr>
								
							</table>
						</div>
						<br>
						<p align="center">
							<img id="edite" src="./resources/ls_img/btn_ok.gif" alt="저장" style ="cursor:pointer" />
							<img id="cancel" src="./resources/ls_img/btn_cancel.gif" alt="취소" style ="cursor:pointer" />
						</p>
						</div><!-- //guestcnt5 -->

					</div><!-- //guest -->
				</div><!-- //bot1-3 -->
			</div><!-- //center_cnt -->
		</div><!-- //contetnsPop -->
	</div>
	<!--//center -->

	<!-- footer -->
	<c:import url="../top_main/top_pop_footer.jsp"></c:import>
	<!-- //footer -->

</body>

</html>
